Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE6C433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BB120714
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O5tm/eOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BB120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AAF6E02D;
	Fri, 21 Aug 2020 03:53:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E547D6E02D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 03:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eotrz7yF1Sw2/baR8ta9VNTo5IIAFAWw8zKC28Q8BkZIeJqyYvswRKLMYJqcRE5+7i9EpZw4yZh+CjpiuuXu2ipfRJdMblFExnaP3kmdwcKIFiE/VcHCTZjmrcrrfi3Tnj56CHFHLnaW3fYIiRj5+0x09gmlBHLyLirY3u4Pg8wfy/APKK6FZ/XhF8yms2l+67DxLPs9VoxQ9UOn/4rqKGNLn21UniferYIQfy5GwDXWZV0B2u9lIq9jaCq9IpQB4n4AjQsSlM+tJm8Tzw0Yx08HzTtyCC+UTGmgbk+MZxwDa29H/UcH6D2kGKMhpI8bxR9uHp8KoetixXq84PhT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1Z5ggorPqwt3uYzCHwXQiUUzBljHbaL4ocOcc2HYms=;
 b=VEKluglxjGz25gmi5+czhoJzakAJIjQ8xveG7WwH2S4QK95GZkRzerumWFuE5W+cthUwWoN1avtJUw1yi24r7F0S8tTSVT5UnTWvVwQazxkMlzt9spq6rgdNNocpwDXAGNOgn5cHlniKk5SgGnJX7gvpEH9/7Gii6Pm5Ub8qap8ahBJPBnOvG2cA/Ir5pLePSzrKHaACvwckJm/gh4tto+mnEoOf6OJQA2IZ+tK/6gAyeTRco3lqJ01oX+rdkuDtLBgXBOXK/IhfKfPz/eBDKqKd0SGAaoSGVRTaL/Qi7Big6haybOKF34GmPkAYfwk6xuRnGfQQA+yiX3q0dPzdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1Z5ggorPqwt3uYzCHwXQiUUzBljHbaL4ocOcc2HYms=;
 b=O5tm/eOwqk/itD2hAKzIZ3JdF/qzlHx7RIl4hRbKhbjI9MydXsYgdvdB+OObA9fUN82zVAv3zJ2OXgspiVF+CalNLAtOKJ5k7UiFBmUF7k+lSFLjDaMApBeAK+h7xJbh3PtLZ5bgN61Fq/E3ws9leEcOg8vv66tU0KBSvG4a3YY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 03:53:27 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Fri, 21 Aug 2020
 03:53:27 +0000
Date: Fri, 21 Aug 2020 11:53:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v4 2/2] drm/amdkfd: force raven as "dgpu" path (v4)
Message-ID: <20200821035317.GA337061@hr-amd>
References: <20200820084008.293114-1-ray.huang@amd.com>
 <20200820084008.293114-2-ray.huang@amd.com>
 <f266f414-94a2-795f-bcd4-2076eba38043@amd.com>
Content-Disposition: inline
In-Reply-To: <f266f414-94a2-795f-bcd4-2076eba38043@amd.com>
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR04CA0090.apcprd04.prod.outlook.com (2603:1096:202:15::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 03:53:25 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03452c75-b9eb-4a2c-69bc-08d84585c23e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43016CEFF02DC00D687F69B8EC5B0@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4YKUobOGf8Ef7P59diUNhAXxtqyn2MK290xZ18OPR8dAZMblUZg5eSgiptHR9KXe+jObeKGrWvPGbJdc3nzfjxR2RjRNGKBY+i9OsBMzWWmDc4YHjAi2GQH27Uq+X0mnjRPYPK66We4sX0xOln3DvHt+F+OEbvZX1ZNwsjxoFwj4ABSUJa/Y4tg1Zuwu9lMJAFxdgUtgFETTqoC6AVsu9LW9c/+z8MzCjkjAKhhtGlmhaPKlTmVpO5ixTleRqn4tmVUfXtvzm6TAhYfoCY8Ylec4o07Awug2eEwDkB1ArSu1dH+KPHwe9oz6GnT1/J6Z6igJ2Lntm5hcOQbmhFh2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8936002)(66476007)(8676002)(66946007)(66556008)(26005)(478600001)(86362001)(1076003)(6496006)(5660300002)(33656002)(316002)(83380400001)(956004)(2906002)(9686003)(6666004)(33716001)(4326008)(16526019)(6862004)(186003)(52116002)(6636002)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /qMwExIVTj0ypJ4AqNLxiMXLR8hAvo0xAOyMVOWYAdjxULcDQR7mnzXQWFVAt3s4+mWtgHrqNRUIQbpmYgWKhY29BE72f/VNO6UBX9YS5Cl3je2WH75jR3tZKMNnVCPvKx4Ctf+HheFEDwQiUYXSbxYmKhZwE/P1ciPX0ewcveqAnbuBCXbEwHcFMMidPouUuT81Os/mKpv/uhqZpm8nh91ViQObFaSNNkd/mG37j8mVgONJOotKe8ChgTp1zEiedWURJ0PN0Ps587qHmVzTl92RnfdOYsxqiYpqxst9BoJ/6Jk0xPKZPbYHBTgFJTI017qTbDSqrmDd8siK4XSKbkn2tSC5QxYMdilJ2cSYbzDitXWz1ZuBqlkkxQCLOTmuVpCDUzaU+TK5wy/5DF9k9JcPahBW7MyHmqp3fEthz9M7wD0gm0V4I/15y4KlxKkcS1pHyqGSSx8Cebrw6VR8GyBnCEgg7bDVOvfhczH11jQcUdV2M2AY8RsCLwSUr498CW2cqYZTMjHb2MUABihwCE0j4EjU6Bz3czLEpMgkNre3P9Rh0qtQvMA4pMh4MEVqbnpdtv52TWIcLFrx4ew+6iSHxup9QHQtLx1x0W0MXVfmSZxwjtS1qD2ofBYUf6jdxfoy1uVPg9sAuTIlbhW/vA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03452c75-b9eb-4a2c-69bc-08d84585c23e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 03:53:26.8799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZsKam1lUjJw35UmzqXXyhpe1vkCCtP/aadWPFQOxJ45jYq7Xmr3zVl7pn+zhfiKRnyuq0VtUJQ04KTs8DoEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 21, 2020 at 10:41:17AM +0800, Kuehling, Felix wrote:
> =

> Am 2020-08-20 um 4:40 a.m. schrieb Huang Rui:
> > We still have a few iommu issues which need to address, so force raven
> > as "dgpu" path for the moment.
> >
> > This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
> > or ACPI CRAT table not correct.
> >
> > v2: Use ignore_crat parameter to decide whether it will go with IOMMUv2.
> > v3: Align with existed thunk, don't change the way of raven, only renoir
> >     will use "dgpu" path by default.
> > v4: don't update global ignore_crat in the driver, and revise fallback
> >     function if CRAT is broken.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 ++++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 23 +++++++++++++++++++++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  5 ++++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 10 ++++++++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 ++++++++++++++++++++
> >  5 files changed, 57 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index a9a4319c24ae..189f9d7e190d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
> >   * Ignore CRAT table during KFD initialization. By default, KFD uses t=
he ACPI CRAT
> >   * table to get information about AMD APUs. This option can serve as a=
 workaround on
> >   * systems with a broken CRAT table.
> > + *
> > + * Default is auto (according to asic type, iommu_v2, and crat table, =
to decide
> > + * whehter use CRAT)
> >   */
> >  int ignore_crat;
> >  module_param(ignore_crat, int, 0444);
> >  MODULE_PARM_DESC(ignore_crat,
> > -	"Ignore CRAT table during KFD initialization (0 =3D use CRAT (default=
), 1 =3D ignore CRAT)");
> > +	"Ignore CRAT table during KFD initialization (0 =3D auto (default), 1=
 =3D ignore CRAT)");
> >  =

> >  /**
> >   * DOC: halt_if_hws_hang (int)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_crat.c
> > index 59557e3e206a..a17cfc290072 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -22,6 +22,7 @@
> >  =

> >  #include <linux/pci.h>
> >  #include <linux/acpi.h>
> > +#include <asm/processor.h>
> >  #include "kfd_crat.h"
> >  #include "kfd_priv.h"
> >  #include "kfd_topology.h"
> > @@ -740,6 +741,25 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev =
*kdev,
> >  	return 0;
> >  }
> >  =

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +bool kfd_ignore_crat(void)
> > +{
> > +	bool ret;
> > +
> > +	if (ignore_crat)
> > +		return true;
> > +
> > +#ifndef KFD_SUPPORT_IOMMU_V2
> > +	ret =3D true;
> > +#else
> > +	ret =3D false;
> > +#endif
> > +
> > +	return ret;
> > +}
> > +
> >  /*
> >   * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
> >   * copies CRAT from ACPI (if available).
> > @@ -751,7 +771,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,
> >   *
> >   *	Return 0 if successful else return error code
> >   */
> > -#ifdef CONFIG_ACPI
> >  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >  {
> >  	struct acpi_table_header *crat_table;
> > @@ -775,7 +794,7 @@ int kfd_create_crat_image_acpi(void **crat_image, s=
ize_t *size)
> >  		return -EINVAL;
> >  	}
> >  =

> > -	if (ignore_crat) {
> > +	if (kfd_ignore_crat()) {
> >  		pr_info("CRAT table disabled by module option\n");
> >  		return -ENODATA;
> >  	}
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device.c
> > index 2c030c2b5b8d..fdf64d361be3 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -112,6 +112,7 @@ static const struct kfd_device_info carrizo_device_=
info =3D {
> >  	.num_xgmi_sdma_engines =3D 0,
> >  	.num_sdma_queues_per_engine =3D 2,
> >  };
> > +#endif
> >  =

> >  static const struct kfd_device_info raven_device_info =3D {
> >  	.asic_family =3D CHIP_RAVEN,
> > @@ -130,7 +131,6 @@ static const struct kfd_device_info raven_device_in=
fo =3D {
> >  	.num_xgmi_sdma_engines =3D 0,
> >  	.num_sdma_queues_per_engine =3D 2,
> >  };
> > -#endif
> >  =

> >  static const struct kfd_device_info hawaii_device_info =3D {
> >  	.asic_family =3D CHIP_HAWAII,
> > @@ -688,6 +688,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >  		goto gws_error;
> >  	}
> >  =

> > +	/* If CRAT is broken, won't set iommu enabled */
> > +	kfd_double_confirm_iommu_support(kfd);
> > +
> >  	if (kfd_iommu_device_init(kfd)) {
> >  		dev_err(kfd_device, "Error initializing iommuv2\n");
> >  		goto device_iommu_error;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index 82f955750e75..5b70fbe429f1 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -308,12 +308,14 @@ struct kfd_dev {
> >  =

> >  	/* xGMI */
> >  	uint64_t hive_id;
> > -    =

> >  	/* UUID */
> >  	uint64_t unique_id;
> >  =

> >  	bool pci_atomic_requested;
> >  =

> > +	/* Use IOMMU v2 flag */
> > +	bool use_iommu_v2;
> > +
> >  	/* SRAM ECC flag */
> >  	atomic_t sram_ecc_flag;
> >  =

> > @@ -1009,6 +1011,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struc=
t pci_dev *pdev);
> >  struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd);
> >  int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
> >  int kfd_numa_node_to_apic_id(int numa_node_id);
> > +void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
> >  =

> >  /* Interrupts */
> >  int kfd_interrupt_init(struct kfd_dev *dev);
> > @@ -1232,9 +1235,12 @@ static inline int kfd_devcgroup_check_permission=
(struct kfd_dev *kfd)
> >  #endif
> >  }
> >  =

> > +bool kfd_ignore_crat(void);
> > +
> >  static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *dev)
> >  {
> > -	return dev && dev->device_info->needs_iommu_device;
> > +	return !kfd_ignore_crat() && dev && dev->use_iommu_v2 &&
> > +		dev->device_info->needs_iommu_device;
> =

> I think this could now be simplified:
> =

>     return dev && dev->use_iommu_v2; =

> =

> So maybe you don't need this function any more.

In Renoir, if ACPI CRAT from SBIOS is good, we may still use
dev->device_info->needs_iommu_device to confirm whether we should go dGPU.

> =

> =

> >  }
> >  =

> >  /* Debugfs */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index 4b29815e9205..8907b5317103 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -1579,6 +1579,26 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
> >  	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
> >  }
> >  =

> > +void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
> > +{
> > +	struct kfd_topology_device *dev;
> > +
> > +	unsigned temp =3D 0;
> > +
> > +	down_read(&topology_lock);
> > +
> > +	/* The cpu_cores_count and simd_count aren't zero at the same time in
> > +	 * APU node.
> > +	 */
> > +	list_for_each_entry(dev, &topology_device_list, list)
> > +		temp |=3D dev->node_props.cpu_cores_count *
> > +			dev->node_props.simd_count;
> =

> You shouldn't look at all GPUs, only at the GPU currently being
> initialized. Otherwise all your dGPUs in an APU system will also have
> use_iommu_v2 =3D=3D true, which would be confusing.
> =

> I'd do this in kfd_assign_gpu, because at that point you have access to
> the kfd_topology_device and the kfd_dev at the same time without having
> to add another loop.
> =


Actually, I follow your comment to do it like this, however, we have to set
the use_iommu_v2 before kfd_iommu_device_init(). kfd_assign_gpu in kfd_topo=
logy_add_device()
is a little late.

Thanks,
Ray

>             ...
>     	list_for_each_entry(dev, &topology_device_list, list) {
>                     /* Discrete GPUs need their own topology device list
>                      * entries. Don't assign them to CPU/APU nodes.
>                      */
>                     if (!gpu->device_info->needs_iommu_device &&
>                         dev->node_props.cpu_cores_count)
>                             continue;
> =

>                     if (!dev->gpu && (dev->node_props.simd_count > 0)) {
>     +                       if (dev->node_props.cpu_cores_count)
>     +                               dev->use_iommu_v2 =3D true;
>                             ...
> =

> Regards,
> =A0 Felix
> =

> =

> > +
> > +	up_read(&topology_lock);
> > +
> > +	gpu->use_iommu_v2 =3D temp ? true : false;
> > +}
> > +
> >  #if defined(CONFIG_DEBUG_FS)
> >  =

> >  int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
