Return-Path: <SRS0=N2cc=CA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72149C433E1
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Aug 2020 01:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EA020720
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Aug 2020 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Az1CaUk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EA020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97CE6EB17;
	Sat, 22 Aug 2020 01:42:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C1796EB17
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2020 01:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMasVDLoeDRUMEzb0G5vwjjuZhjxbo0TCOmP7M31dVkyC7zESjtQ60Cl5aERHb0vp9Uf8ZAGOlPfVqU5Ou8KLK1jjTCvdXuZRmLvaKxBx1Nfq94jVubqq3J00P9g7PYUVWC4mSHDesVicPz95juz+ebdRSDHqMcxfqppUKn5PeXX1/3xnIYbNJbIYekGk4Ec4YgvbClY2NaT8dlHGqhBKETH66h1W7+tCqeq6iYfNZczuXlCKfNgbe8baCheGspclyS3QKRED402/w2DVHz5z0uFWp2I98hUbvCZKSTqX6LhlqiHJANf9y6YMl3liTYZS5sMAsR5XzyWPAK8zPkTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5PyKSVhKPEug5V75o5pgMM3PLTUkKes0LfLx7s2tyU=;
 b=bquv4GWA7TYh1Omdx7KeVdLuh03N4UD2ARtJzIYxFpexQk06DSjxzlDIPRumKfDsrW/WWRAfOBv3SqDVQU8CmICH/80QD5EG/nvf0vl32Vh3xEYDGKaNWHbAfdpPEQo3kz+is8GkIDjtKlJaosBU/scJ0IxC5YRJEcfCQf9IeeZUMqvSEO5PqTfzbxlUuTlQkK82+m5rKJOm/1QUf1h03nj8aLzJe6APcLOOsPnf5zmuqOMR0jO42/35rp/7bWLXkdKHc/doYvPTXDzyMRozhJrsp6M3cyVCsBXS2KaDt8iJw5IeJh9nDW6vTYCT3ziIXjbkU56o/NFzUMn3a2WfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5PyKSVhKPEug5V75o5pgMM3PLTUkKes0LfLx7s2tyU=;
 b=Az1CaUk2rLibCatJWLX6oeUkiqgj2i4WJam4yLds1+BlPJ/imcAfbs8qnp157Fdim+KLPHZ35eZUZTCMfYfUHXA0W+5muH+m+oIunHcKI6oByeAr5I+5hW1aR1RA3D6cEBTIkxK5gSQuIv50hc+5LYqp7Plfz4Hnq4J1tk24gGk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Sat, 22 Aug
 2020 01:42:31 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Sat, 22 Aug 2020
 01:42:31 +0000
Date: Sat, 22 Aug 2020 09:42:22 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v5] drm/amdkfd: implement the dGPU fallback path for apu
 (v5)
Message-ID: <20200822014222.GA338112@hr-amd>
References: <20200821125037.361341-1-ray.huang@amd.com>
 <7f293d34-d358-74c8-3e64-118740b814fb@amd.com>
Content-Disposition: inline
In-Reply-To: <7f293d34-d358-74c8-3e64-118740b814fb@amd.com>
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR0401CA0007.apcprd04.prod.outlook.com (2603:1096:202:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Sat, 22 Aug 2020 01:42:29 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f209bfa-ad9f-4f4d-1de3-08d8463ca236
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25143FF6BCC537BEFBCFE134EC580@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+JlnlpgLn8BAhUnT2JQOmqAXox3MWCMUVwstsBo6+AtpL40Jh9lbgcXwVlp9O4eDOo8iP73ALLVCfTctaikFp2eSKPmdOAUnHbUfiOUhvc3xNJr5Car166EmSJpSaHX2pbujV1jFU49DIsEbdFv4JSUzLdwPzjsggCLKsrHOHUPFRrMhEJbeSKEy/43jHIOVgW/pxqUdk3gVgfBKwHfsM/wsFhAOJbuvtDt5n9HYL5DMAn7M6iXJd4ZCZehHLeqNPZU/BO+SRBEeeEf4+tFARaAfNWhcyOXzK1bc/JfPkW66Dp2jGRX00WmM/XZAdyJGH75n0RY3NHnBWv9joCHWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(478600001)(6496006)(52116002)(66946007)(66476007)(8676002)(316002)(2906002)(55016002)(66556008)(86362001)(30864003)(26005)(5660300002)(4326008)(8936002)(33716001)(186003)(33656002)(956004)(6666004)(6636002)(16526019)(1076003)(9686003)(83380400001)(6862004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: S/AVDVciIHu5rFjq5te1gIagrDv0iksQbTzneKzh57fV1suIS2O6cKaBP/5XvqyBIlCxC0jaMhMPmCG7NZF4FdsnCJMn+rc9Vcl7AGbsI9czeJijumO99GDjeItYxLfDoL5twXvBJLpxbFYv+/yy7o3QGtWW9fKnewvfvghWhwvzL8sWRf+GmHoydGR+/mjvm41Fz/sH0qvsR1bvPenHbvao2AknS81lZ0hYfQ/Sf8OM9G7wSRrIvYcY2qpEk4uKgyPg7mXszgi2iUx0c4JmoCihQSdnfp593/JgsUMgVHA4Nzxy4XIgF+0JmNpOE8Rb2yNNcPdCE/BYk+Dk/MxtVhtpaQ92oiSiWmH4HqpePsaoED1q5tLORa51xLIzUJ8bd+o8WCR7SyHQq3RD9dDdCoK5yUEVphGNU2HnY60V8im/9aKB6SX4TFhWLnXOL745Y4Bqwc4G6V4X3mePkny4M/mwRAZILDun9UvD+8oXoML1LTuc6kdwb9D5nFkYfi5uWxPkzjkVl/bRXjFpLOZcxf0gymZG43HMLnJ9VYbDJcXxA2pB4G92Ar8wO5n6SovAveBP0WVxgsq5xsAAmkekDA+UtRyTEuX/HLEPra6a63f2yuPArxfLTzbC5hntFWLmvmolVyq82Vec1ATatpSjQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f209bfa-ad9f-4f4d-1de3-08d8463ca236
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2020 01:42:31.1210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvAKFfrg13pIijZ5qRBgW0kmlp9FTKnTxzkWuthBVfhkTfhFd0cucnWipUrpBIDuRSGE6T4hPZg7tWHsscTyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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

On Sat, Aug 22, 2020 at 12:48:00AM +0800, Kuehling, Felix wrote:
> =

> Am 2020-08-21 um 8:50 a.m. schrieb Huang Rui:
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
> > v5: refine acpi crat good but no iommu support case, and rename the
> >     title.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 ++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 22 ++++++++++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  4 +--
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 ++-
> >  .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
> >  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 10 +++---
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 ++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 36 +++++++++++++++++--
> >  10 files changed, 76 insertions(+), 19 deletions(-)
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
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_chardev.c
> > index 1b60e0ed6b5c..3ec5322ba88d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
> >  		return true;
> >  	}
> >  =

> > -	if (dev->device_info->needs_iommu_device)
> > +	if (dev->use_iommu_v2)
> >  		return false;
> >  =

> >  	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_crat.c
> > index 59557e3e206a..aba40df189d9 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > @@ -740,6 +740,25 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev =
*kdev,
> >  	return 0;
> >  }
> >  =

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static bool kfd_ignore_crat(void)
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
> > @@ -751,7 +770,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,
> >   *
> >   *	Return 0 if successful else return error code
> >   */
> > -#ifdef CONFIG_ACPI
> >  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >  {
> >  	struct acpi_table_header *crat_table;
> > @@ -775,7 +793,7 @@ int kfd_create_crat_image_acpi(void **crat_image, s=
ize_t *size)
> >  		return -EINVAL;
> >  	}
> >  =

> > -	if (ignore_crat) {
> > +	if (kfd_ignore_crat()) {
> >  		pr_info("CRAT table disabled by module option\n");
> >  		return -ENODATA;
> >  	}
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_dbgdev.c
> > index 3e5904f8876a..e4159b5f83d5 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > @@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_db=
gdev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, pdd->qpd.vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device);
> > +				dbgdev->dev->use_iommu_v2);
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> > @@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgd=
ev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device);
> > +				dbgdev->dev->use_iommu_v2);
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
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
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b=
/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > index 95a82ac455f2..309f63a0b34a 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager =
*dqm,
> >  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> >  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
> >  		if (amdgpu_noretry &&
> > -		    !dqm->dev->device_info->needs_iommu_device)
> > +		    !dqm->dev->use_iommu_v2)
> >  			qpd->sh_mem_config |=3D
> >  				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> >  =

> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_flat_memory.c
> > index 78714f9a8b11..798303c3c7ac 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > @@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_proces=
s_device *pdd, uint8_t id)
> >  	pdd->lds_base =3D MAKE_LDS_APP_BASE_VI();
> >  	pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> >  =

> > -	if (!pdd->dev->device_info->needs_iommu_device) {
> > +	if (!pdd->dev->use_iommu_v2) {
> >  		/* dGPUs: SVM aperture starting at 0
> >  		 * with small reserved space for kernel.
> >  		 * Set them to CANONICAL addresses.
> > @@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
> >  				return -EINVAL;
> >  			}
> >  =

> > -			if (!dev->device_info->needs_iommu_device) {
> > +			if (!dev->use_iommu_v2) {
> >  				/* dGPUs: the reserved space for kernel
> >  				 * before SVM
> >  				 */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_iommu.c
> > index 4d3b4188b9a1..0c0269497e51 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > @@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
> >  	struct amd_iommu_device_info iommu_info;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!kfd->use_iommu_v2)
> >  		return -ENODEV;
> >  =

> >  	iommu_info.flags =3D 0;
> > @@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!kfd->use_iommu_v2)
> >  		return 0;
> >  =

> >  	iommu_info.flags =3D 0;
> > @@ -109,7 +109,7 @@ int kfd_iommu_bind_process_to_device(struct kfd_pro=
cess_device *pdd)
> >  	struct kfd_process *p =3D pdd->process;
> >  	int err;
> >  =

> > -	if (!dev->device_info->needs_iommu_device || pdd->bound =3D=3D PDD_BO=
UND)
> > +	if (!dev->use_iommu_v2 || pdd->bound =3D=3D PDD_BOUND)
> >  		return 0;
> >  =

> >  	if (unlikely(pdd->bound =3D=3D PDD_BOUND_SUSPENDED)) {
> > @@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct=
 kfd_dev *kfd)
> >   */
> >  void kfd_iommu_suspend(struct kfd_dev *kfd)
> >  {
> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!kfd->use_iommu_v2)
> >  		return;
> >  =

> >  	kfd_unbind_processes_from_device(kfd);
> > @@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!kfd->use_iommu_v2)
> >  		return 0;
> >  =

> >  	pasid_limit =3D kfd_get_pasid_limit();
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index 60243798cce2..641b964387ec 100644
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
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index cbb8535abf0c..d141f726d037 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, stru=
ct attribute *attr,
> >  		 * If the ASIC is APU except Kaveri, set local memory size
> >  		 * to 0 to disable local memory support
> >  		 */
> > -		if (!dev->gpu->device_info->needs_iommu_device
> > +		if (!dev->gpu->use_iommu_v2
> >  			|| dev->gpu->device_info->asic_family =3D=3D CHIP_KAVERI) {
> >  			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
> >  				&local_mem_info);
> > @@ -1197,7 +1197,7 @@ static struct kfd_topology_device *kfd_assign_gpu=
(struct kfd_dev *gpu)
> >  		/* Discrete GPUs need their own topology device list
> >  		 * entries. Don't assign them to CPU/APU nodes.
> >  		 */
> > -		if (!gpu->device_info->needs_iommu_device &&
> > +		if (!gpu->use_iommu_v2 &&
> >  		    dev->node_props.cpu_cores_count)
> >  			continue;
> >  =

> > @@ -1452,7 +1452,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
> >  	* Overwrite ATS capability according to needs_iommu_device to fix
> >  	* potential missing corresponding bit in CRAT of BIOS.
> >  	*/
> > -	if (dev->gpu->device_info->needs_iommu_device)
> > +	if (dev->gpu->use_iommu_v2)
> >  		dev->node_props.capability |=3D HSA_CAP_ATS_PRESENT;
> >  	else
> >  		dev->node_props.capability &=3D ~HSA_CAP_ATS_PRESENT;
> > @@ -1579,6 +1579,36 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
> >  	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
> >  }
> >  =

> > +void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
> > +{
> > +	struct kfd_topology_device *dev;
> > +
> > +	gpu->use_iommu_v2 =3D false;
> > +
> > +	down_read(&topology_lock);
> > +
> > +	/* Only use IOMMUv2 if there is an APU topology node with no GPU
> > +	 * assigned yet. This GPU will be assigned to it.
> > +	 */
> > +	list_for_each_entry(dev, &topology_device_list, list) {
> > +		if (dev->node_props.cpu_cores_count &&
> > +		    dev->node_props.simd_count &&
> > +		    !dev->gpu) {
> > +			/* If device_info indicates no iommu support, force
> > +			 * simd_count as 0 to tell user mode no GPU in the APU
> > +			 * node.
> > +			 */
> > +			if (!gpu->device_info->needs_iommu_device)
> > +				dev->node_props.simd_count =3D 0;
> =

> This assumes that the APU's built-in GPU is the first to be initialized.
> If there is a dGPU and that gets initialized first, you will set
> dev->node_props.simd_count =3D 0 here, which will force the APU to run in
> dGPU mode.
> =

> Maybe that's intentional, but it seems weird that this depends on the
> order in which GPUs are initialized. That order may not be stable
> between reboots, so relying on that can lead to unexpected behaviour and
> confusing bug reports.
> =


This is to fix the case if ACPI CRAT is good on Renoir. If ACPI CRAT good
by default on Renoir, we will initialize the APU node at that time. If it
checked needs_iommu_device here, then we can report the simd_count as 0 to
user mode to treat this node as pure CPU. This is in spired by below
comments:

>> I'd suggest trying a more general solution in node_show in
>> kfd_topology.c. If we see an APU node (that has CPU and GPU cores) with
>> no associated GPU (dev->gpu_id is 0 or dev->gpu is NULL), we can report
>> it as a pure CPU node to user mode by just reporting the simd_count as 0.

Thanks,
Ray

> Regards,
> =A0 Felix
> =

> =

> > +			else
> > +				gpu->use_iommu_v2 =3D true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	up_read(&topology_lock);
> > +}
> > +
> >  #if defined(CONFIG_DEBUG_FS)
> >  =

> >  int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
