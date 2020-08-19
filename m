Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08EAC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 23:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89D42173E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 23:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89D42173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E12E6E880;
	Wed, 19 Aug 2020 23:56:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5F4B6E87F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 23:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbTJXRu42cC32gihnYEBsVpDTAir7mDZF5Ev5aOCbwY5d6sWXrb7CFuH0G5ij0rk/bwPz/M3Xp+JQcY00FXasiQh78L3cuoYiW6noIWQZ0m4OuUBlvbflTJMPY1LghchbjGQkj74N9VsfWYepPtmy3ygYj4LTZ+Nc0RI4hp7DxeIRo8Zk8o/66ryuAyfD/j13UvmChqIXJFZr+EAoUGQmsfO7EdIebhadQFsMA/3Jyc82vgoZfQEN7ojIRzw8QCeCZEILYAsfZ8HcvrnT96dz1GfErYcsnOLGBYmeihyR6KqWIgsINMXi+qirwxR9YaGH6HMPehFaTWujIO2AqoWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlZWkevxRjygTn5Q+09I1TXGAJgSqGg9ESH0Xr5zr6o=;
 b=c6yjpXKW7u1Oti+xxR0jfQLTBt9YFEum6o1tH6MzbSzUHwsHo4+l4oDl78er/aa/ZG/c9bVYQgKf8WZn5E4Tu1ON+m9aXpe/R2S7jkkW4rVG6IFKVk//RO/GNygN6nmdd3llepQM2iCxW/tE/ZLFH1pH2pDYxRoX9wJwtCYRjLIs0gyXQtopSUrZ9qJ/b/mWejDcjs1faZTQeNXScUY90PK/aEkaYYbhbuz1+Vz3fZBi+PjZ/6RkALm/uZrfEBAXh6LCztp7uvNU3E3LmNmP5U5o+ykJE/Q0SWQGzyQxsC/74wnSDWcr4GBJdLZvCe7JiJ8UELRRhgRN9fCbfgKj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlZWkevxRjygTn5Q+09I1TXGAJgSqGg9ESH0Xr5zr6o=;
 b=yXzrRgbdKHpz6vcxWDlAcsWHqSdWeiZXAIimAQlBQX0xu1Fa9moU0yOSNftlpQ06V3EqMgUInELCjC+HKbLPz7ZRupxZyy7DXiy1nnAJ68JMb+TW0tvMjy7cqNPIae5xEqm/sEh44+cHfL5Zc1ej9m1ajzpEBdyRvBTZeBGjRjI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 23:56:26 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 23:56:26 +0000
Date: Thu, 20 Aug 2020 07:56:17 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
Message-ID: <20200819235617.GB215900@hr-amd>
References: <20200819110647.212404-1-ray.huang@amd.com>
 <20200819110647.212404-2-ray.huang@amd.com>
 <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
Content-Disposition: inline
In-Reply-To: <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Wed, 19 Aug 2020 23:56:24 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d40f63e-3c83-453d-db44-08d8449b7b65
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679980A00930DB355D13164EC5D0@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lroj4MSqV2eIWI6LEddFGDTm8aCMDMt3JluUvN756wsRgQDC7LapwtnYQrxJARLezwWGj4JXDwMXvd1DJmGMzLjp/5hXKjn1HABNM7jgahTELEfalhWKDISUmt8eSRoxAX95d46HJeEKa+YAPlfNmg3bjUua+oKxqsZLOz+uiJOnIeYmaA5Y37CjPbHFrsbK6frFzrHT8NbXUs+D11fvfUNcvYQHU0G6xOi6BnzXDCGqra7O/Ci77F/FRdueSOVn9Oi6/wqwLeIgE3bOawd/kRBn4cGb05MeBLpBIev2WrSjkt/o5Ftiy1k+AFuVuveF6oqSvAkl6XHd1+U5tbPf1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(8676002)(6496006)(1076003)(6862004)(4326008)(66476007)(66556008)(316002)(66946007)(478600001)(6666004)(55016002)(186003)(26005)(52116002)(956004)(2906002)(16526019)(33716001)(5660300002)(86362001)(6636002)(8936002)(9686003)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5WIubmbCyj+TNhYM745wiWHtwPKzns14UqiW2++zt7Z5eKT0t2j1k/w04n2KFfq4gDgH8qoAMBq3QbEiNEnSnKocofx5w0DXQjVFTxnP8j7YwkwSTZTFXzEcT8ghfjrAQWaFBS8ZWx1hwWslLy9nsz5bhkAxrzawM/xsdwLH2d3sLjnFQ2yAEbEvoKxOSAa/e12qlNK5t3mQHFGOQuq1IWxFQKCkRaK7ip+q1PISdf1Zx7j/QOJkXzTOjNIlSlP0yvZBl6b33YUdozirOq6hhg/2mztWar9it8YFjaKcxRNJTBw48PORIH68mLscshqqvO5s9KFj5G3l+yF2et+ydSNebFxULLsyVk7d4wq88vsW6jV+q9Tyvrk3ffrMJvioO69ubD9VKNYLmFS6APwbFFaqXFptu38VLkytLcPJD53pyQZ+84y8bLRo+RBlJiyJ/c7dmcLtEtWv+rSetYiyqhgEcRjbsgczx2VAJbXd5jV88NREZ7AcuVu/DCV7ZGyge98Ym6qdk3vMQpco+TAnjO3nRYppPt6+vcn3YEYJeKopsxgVlr0weRmry3TJu2GCb7+pWJjOt1chEoL1g+pWbdlkqd26ttDzdjtTIBcmXgZwtKG1pNUA0WkOVMkbQJ2dt3gpdk6GO+yB04JosZfWzA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d40f63e-3c83-453d-db44-08d8449b7b65
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 23:56:25.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jbe6jJ5QFecwmLzF0b68RDIY9V4rCynQsXvCX7FsHSTBtbu9cuJXiUyfzraZ5o1VRW42q50gd+KbyrzuS0V2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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

On Wed, Aug 19, 2020 at 11:38:34PM +0800, Kuehling, Felix wrote:
> Am 2020-08-19 um 7:06 a.m. schrieb Huang Rui:
> > We still have a few iommu issues which need to address, so force raven
> > as "dgpu" path for the moment.
> >
> > This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
> > or ACPI CRAT table not correct.
> >
> > v2: Use ignore_crat parameter to decide whether it will go with IOMMUv2.
> > v3: Align with existed thunk, don't change the way of raven, only renoir
> >     will use "dgpu" path by default.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 +++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 28 ++++++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  1 +
> >  5 files changed, 34 insertions(+), 4 deletions(-)
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
> > index 59557e3e206a..f8346d4402e2 100644
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
> > @@ -740,6 +741,30 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev =
*kdev,
> >  	return 0;
> >  }
> >  =

> > +
> > +#ifdef CONFIG_ACPI
> > +static void kfd_setup_ignore_crat_option(void)
> > +{
> > +
> > +	if (ignore_crat)
> > +		return;
> > +
> > +#ifndef KFD_SUPPORT_IOMMU_V2
> > +	ignore_crat =3D 1;
> > +#else
> > +	ignore_crat =3D 0;
> > +#endif
> > +
> > +	/* Renoir use the fallback path to align with existed thunk */
> =

> Are you sure you need special code for Renoir here? For Renoir the
> dev->device_info already treats it as a dGPU and always has.

Renoir also is an APU, in other words, we might have got the correct CRAT
table from SBIOS (the CRAT table in SBIOS for renoir is broken so far). If
we had got CRAT table, the kfd would create an APU node. That's not
expected.

> =

> I don't like the whole idea of changing the value of a module parameter,
> because it is global and visible to the user through sysfs. Instead, if
> you need to override the value of ignore_crat to consider other
> conditions, I think kfd_device_use_iommu_v2 and
> kfd_create_crat_image_acpi would be the right place to do it.
> =

> To avoid duplicating the conditions, you could add a helper function
> bool kfd_ignore_crat(void) that can be called instead of using the
> ignore_crat parameter directly. This function, changing the global
> module parameter, should be removed.

That makes sense. Will update it in next version.

> =

> =

> > +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> > +	    boot_cpu_data.x86 =3D=3D 0x17 &&
> > +	    boot_cpu_data.x86_model >=3D 0x60 && boot_cpu_data.x86_model < 0x=
70) {
> > +		ignore_crat =3D 1;
> > +	}
> > +
> > +	return;
> > +}
> > +
> >  /*
> >   * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
> >   * copies CRAT from ACPI (if available).
> > @@ -751,7 +776,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,
> >   *
> >   *	Return 0 if successful else return error code
> >   */
> > -#ifdef CONFIG_ACPI
> >  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >  {
> >  	struct acpi_table_header *crat_table;
> > @@ -775,6 +799,8 @@ int kfd_create_crat_image_acpi(void **crat_image, s=
ize_t *size)
> >  		return -EINVAL;
> >  	}
> >  =

> > +	kfd_setup_ignore_crat_option();
> > +
> >  	if (ignore_crat) {
> >  		pr_info("CRAT table disabled by module option\n");
> >  		return -ENODATA;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device.c
> > index 2c030c2b5b8d..dab44951c4d8 100644
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
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index 82f955750e75..4b6e7ef7a71c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -1234,7 +1234,7 @@ static inline int kfd_devcgroup_check_permission(=
struct kfd_dev *kfd)
> >  =

> >  static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *dev)
> >  {
> > -	return dev && dev->device_info->needs_iommu_device;
> > +	return !ignore_crat && dev && dev->device_info->needs_iommu_device;
> >  }
> >  =

> >  /* Debugfs */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index 4b29815e9205..b92ce75a4c53 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
> >  						    COMPUTE_UNIT_CPU, NULL,
> >  						    proximity_domain);
> >  		cpu_only_node =3D 1;
> > +		ignore_crat =3D 1;
> =

> Don't change the global variable. I think you're doing this here in case
> the CRAT table is broken and contains no GPU info. Maybe we need to add
> a new flag "use_iommu_v2" into the kfd_dev structure to handle this.
> =


Yes, you're right. Will remove global ignore_crat update. Let me revise it
again.

Thanks,
Ray

> Regards,
> =A0 Felix
> =

> =

> >  		if (ret) {
> >  			pr_err("Error creating VCRAT table for CPU\n");
> >  			return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
