Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 02:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231F02076E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 02:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ND+4ziHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F02076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829A689B49;
	Wed, 19 Aug 2020 02:53:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C496189B49
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 02:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2V3hxUooelGGizoPEUZKFaRlQoE2Y1pUKhLvDhLz6m1m6NTP23t98j6oUbJ/ZNgdukW+DQOQ1zphEskPbNShYjJTOG6OUHHEQTCRArXo5nl6rSFaRDpWvj39bq7uQPZtx2h8AFTwm+DBf1h+TuHjvmf8oTjERhtR83KbFjwjz1VB8Ara3tSUaZQLc3NHnSi3LJm0O0hBxDHn13nhCe2QvCcsHJ7DpPGCOjFegRYata6Hq3U83V7rowq0oKCLrclXO3wl8Dmy82RbuTh/qZKVaP97Uv2J79LTmvCtXmbny2xo6kpGcDpR9qxi8coZQFEvndIaHlkcf1+ajImt9rJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4vaMCI+I4tbJq4jCcl5EDHqU6wjVzDKt5kXJMx3vd0=;
 b=ZRPLJ5PLEs8cd6g+7kXnNxFYoPWDPEM5NhxrSvsd6qYXIGUmuzwTF+97Ymv46X9jxLR6VnTBWyLhV2MFAQ/3kOljFHujn3mgXX9vm8JxN+mq0ab3gpyDE04HJyMy6ELjlsitmrx1LLtDoIfvea0l6wlIZ0GRgdxi/5DZx2aUKxeXFWSyCxvNyOkVVykljU6ssoN4xA4+d3+qg6R/J08wxOBUoeAwzPVVDV8D0j6IZhUG6DFxq4dYk12MkaZXJS3uK3g/mLB5U6GZ/TW4vGIGuz1zdH1FATyBqe5nISSgqMYWaQC67KKUp6NYCDIZDlcMYJXLcFCi/KXKNAuwsq882A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4vaMCI+I4tbJq4jCcl5EDHqU6wjVzDKt5kXJMx3vd0=;
 b=ND+4ziHm77C16GOMh70rIP7Us8wm2UJhVLZxFdPu/tj4iMIV2nv15Zy3K4efniHJl/OB2EGua1H5rjWVXrVfWfOIBlPRXVPMr4D1tElvco6ek3WtRIXC2CuBPO86V0cRSNvYKBhsya3BHAf4nZDWsntP4T95RwkMnAON4L0hmxg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 02:53:24 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 02:53:24 +0000
Date: Wed, 19 Aug 2020 10:53:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v2 1/3] drm/amdkfd: force raven as "dgpu" path (v2)
Message-ID: <20200819025315.GA181724@hr-amd>
References: <20200818130932.180114-1-ray.huang@amd.com>
 <b110758d-0c52-f64a-9906-30281756d2b9@amd.com>
Content-Disposition: inline
In-Reply-To: <b110758d-0c52-f64a-9906-30281756d2b9@amd.com>
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR02CA0197.apcprd02.prod.outlook.com (2603:1096:201:21::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 19 Aug 2020 02:53:22 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4896bcd-d57d-4dcc-32be-08d843eb09ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4520B7EF767C34D0AF09769FEC5D0@MN2PR12MB4520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQ/Jugef6n7WrjP3jEwdxwyKeSQza4I+MSN5Cw+5zp4nIZ0fGfaSkUXdWus09leMSfrGYCkk7SJKq1aBTeFm3kILEWFMiEAhhZGSLFahB4wiOru63KMvTFDl9nz4sFQ8zZ4JceHiEM2UUenxcl11ISx0O05o0fc9x3Zy4XDeRpZS8nX1YV82kDi/BnxK5s113kVw6PqHsk6I4nnBUDVaKiuXsSDbweSm3DdI2pXia7zCGQo9fz613QlVpWMGwiDz15R69mr8Fzo4YR5ZieiYVi9C0Kipy2U9KokElDrEwzmQXn73D4FKiFtFcmhDq6iIEeRm8i0zRafdpOrLvWOu+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(8936002)(2906002)(8676002)(16526019)(956004)(33656002)(6496006)(6636002)(83380400001)(9686003)(55016002)(33716001)(4326008)(186003)(52116002)(6666004)(66476007)(26005)(478600001)(66946007)(5660300002)(6862004)(66556008)(316002)(86362001)(1076003)(30864003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rnqtXSL1GiTbbAx871nJ0KH4BgqPndzKAkV/ToMjzvFo1bp2LbeNcAs5/U6ds0IMDFNtksj7emSyNSOahC2MSUJ8ZsS8OBvFLIA+64/nOj/i4CSxfBgdYQFBRNeF25mpySzXMyr5G5YawSYZGXdE2Q6IaQGmHxVkuoLC/DO9SXTp5RBZgcSAOji69V8/HtPFxFqsVvS6oSsFjOu2ccsxAdS7ayahAoxAndeD77ABbCVRFFHuA+K5OoLwvDNhZL9W9RjgQrxTPqQcUidXMrZ+jfBBcqvHlMByVZXJ1rAliSs+GjDmXbrFF48aG+QT9/RUVrq1PgbPfhtcemIqz/x8mb3aJN3ZsOXs8UFzjhjepXcFCcScAUd3FJS5u6IOuDkSm1oL9cFlMzPzgqfQOdKnPJkHcazx9P8Bz8XKz6KtKLS4qaPok+GjtUW9+0io7P9LnIRNpC+wrJiHX7Jvl3xjN/6Gysvx1BXz6TinQDlB9kKDZCAo0J91gx/SqN3+L61YVHhhvC70jz0opbWzioGvOnlogwMCYP90uHlK6d6cBWTrmlnJvAKZAF53GderCFZkAUYC4kIwjXG07EIQ42gLXPSXMsug2lfNd6v4vyw9+ypzhvS5SHPhJJB6W/SHNfpn4PJSMGcrYOiQttLU5ZTsgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4896bcd-d57d-4dcc-32be-08d843eb09ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 02:53:24.0218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZv8RcTdYpxtoI2JPyCjscgGqTkB+t3oy2ZWBKmoB2SPNaVqMbSjVqLWMn/inrzH8iZhO+Yz1286ebei8S73Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
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

On Tue, Aug 18, 2020 at 11:01:25PM +0800, Kuehling, Felix wrote:
> Am 2020-08-18 um 9:09 a.m. schrieb Huang Rui:
> > We still have a few iommu issues which need to address, so force raven
> > as "dgpu" path for the moment.
> >
> > This is to add the fallback path to bypass IOMMU if IOMMU v2 is disabled
> > or ACPI CRAT table not correct.
> >
> > v2: use ignore_crat parameter to decide whether it will go with IOMMUv2.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  5 +++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 27 ++++++++++++++++++-
> >  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  4 +--
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  2 +-
> >  .../amd/amdkfd/kfd_device_queue_manager_v9.c  |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
> >  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        | 10 +++----
> >  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  7 ++---
> >  9 files changed, 46 insertions(+), 17 deletions(-)
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
> > index 1b60e0ed6b5c..20ef754dc62e 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -1258,7 +1258,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
> >  		return true;
> >  	}
> >  =

> > -	if (dev->device_info->needs_iommu_device)
> > +	if (dev->device_info->needs_iommu_device && !ignore_crat)
> >  		return false;
> >  =

> >  	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_crat.c
> > index 59557e3e206a..98993584802f 100644
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
> > @@ -740,6 +741,29 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev =
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
> > +	/* Raven series will go with the fallback path to use virtual CRAT */
> > +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> > +	    boot_cpu_data.x86 =3D=3D 0x17) {
> > +		ignore_crat =3D 1;
> =

> Does your change require Thunk changes? If yes, then changing this by
> default breaks existing user mode and cannot be applied upstream.
> =

> If you expect that this is a temporary workaround, then don't apply it
> here, apply it in your grub config or modprobe config.

I see. Will keep the default using CRAT for Raven as well to make sure the
existing thunk workable.

Thanks,
Ray

> =

> Regards,
> =A0 Felix
> =

> =

> > +	}
> > +
> > +	return;
> > +}
> > +
> >  /*
> >   * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
> >   * copies CRAT from ACPI (if available).
> > @@ -751,7 +775,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,
> >   *
> >   *	Return 0 if successful else return error code
> >   */
> > -#ifdef CONFIG_ACPI
> >  int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >  {
> >  	struct acpi_table_header *crat_table;
> > @@ -775,6 +798,8 @@ int kfd_create_crat_image_acpi(void **crat_image, s=
ize_t *size)
> >  		return -EINVAL;
> >  	}
> >  =

> > +	kfd_setup_ignore_crat_option();
> > +
> >  	if (ignore_crat) {
> >  		pr_info("CRAT table disabled by module option\n");
> >  		return -ENODATA;
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_dbgdev.c
> > index 3e5904f8876a..0c4161ac4102 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> > @@ -309,7 +309,7 @@ static int dbgdev_address_watch_nodiq(struct kfd_db=
gdev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, pdd->qpd.vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device);
> > +				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
> > @@ -399,7 +399,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgd=
ev *dbgdev,
> >  	for (i =3D 0; i < adw_info->num_watch_points; i++) {
> >  		dbgdev_address_watch_set_registers(adw_info, &addrHi, &addrLo,
> >  				&cntl, i, vmid,
> > -				dbgdev->dev->device_info->needs_iommu_device);
> > +				dbgdev->dev->device_info->needs_iommu_device && !ignore_crat);
> >  =

> >  		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
> >  		pr_debug("\t\t%20s %08x\n", "register index :", i);
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
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b=
/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > index 95a82ac455f2..48b86bdbb680 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
> > @@ -62,7 +62,7 @@ static int update_qpd_v9(struct device_queue_manager =
*dqm,
> >  				SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
> >  					SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
> >  		if (amdgpu_noretry &&
> > -		    !dqm->dev->device_info->needs_iommu_device)
> > +		    !(dqm->dev->device_info->needs_iommu_device && !ignore_crat))
> >  			qpd->sh_mem_config |=3D
> >  				1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> >  =

> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_flat_memory.c
> > index 78714f9a8b11..6044d36bceb6 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > @@ -321,7 +321,7 @@ static void kfd_init_apertures_vi(struct kfd_proces=
s_device *pdd, uint8_t id)
> >  	pdd->lds_base =3D MAKE_LDS_APP_BASE_VI();
> >  	pdd->lds_limit =3D MAKE_LDS_APP_LIMIT(pdd->lds_base);
> >  =

> > -	if (!pdd->dev->device_info->needs_iommu_device) {
> > +	if (!(pdd->dev->device_info->needs_iommu_device && !ignore_crat)) {
> >  		/* dGPUs: SVM aperture starting at 0
> >  		 * with small reserved space for kernel.
> >  		 * Set them to CANONICAL addresses.
> > @@ -423,7 +423,7 @@ int kfd_init_apertures(struct kfd_process *process)
> >  				return -EINVAL;
> >  			}
> >  =

> > -			if (!dev->device_info->needs_iommu_device) {
> > +			if (!(dev->device_info->needs_iommu_device && !ignore_crat)) {
> >  				/* dGPUs: the reserved space for kernel
> >  				 * before SVM
> >  				 */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_iommu.c
> > index 4d3b4188b9a1..c767b524bea4 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> > @@ -41,7 +41,7 @@ int kfd_iommu_check_device(struct kfd_dev *kfd)
> >  	struct amd_iommu_device_info iommu_info;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> >  		return -ENODEV;
> >  =

> >  	iommu_info.flags =3D 0;
> > @@ -63,7 +63,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
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
> > +	if (!(dev->device_info->needs_iommu_device && !ignore_crat) || pdd->b=
ound =3D=3D PDD_BOUND)
> >  		return 0;
> >  =

> >  	if (unlikely(pdd->bound =3D=3D PDD_BOUND_SUSPENDED)) {
> > @@ -284,7 +284,7 @@ static void kfd_unbind_processes_from_device(struct=
 kfd_dev *kfd)
> >   */
> >  void kfd_iommu_suspend(struct kfd_dev *kfd)
> >  {
> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> >  		return;
> >  =

> >  	kfd_unbind_processes_from_device(kfd);
> > @@ -304,7 +304,7 @@ int kfd_iommu_resume(struct kfd_dev *kfd)
> >  	unsigned int pasid_limit;
> >  	int err;
> >  =

> > -	if (!kfd->device_info->needs_iommu_device)
> > +	if (!(kfd->device_info->needs_iommu_device && !ignore_crat))
> >  		return 0;
> >  =

> >  	pasid_limit =3D kfd_get_pasid_limit();
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_topology.c
> > index cbb8535abf0c..ad8139594b6f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -545,7 +545,7 @@ static ssize_t node_show(struct kobject *kobj, stru=
ct attribute *attr,
> >  		 * If the ASIC is APU except Kaveri, set local memory size
> >  		 * to 0 to disable local memory support
> >  		 */
> > -		if (!dev->gpu->device_info->needs_iommu_device
> > +		if (!(dev->gpu->device_info->needs_iommu_device && !ignore_crat)
> >  			|| dev->gpu->device_info->asic_family =3D=3D CHIP_KAVERI) {
> >  			amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd,
> >  				&local_mem_info);
> > @@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
> >  						    COMPUTE_UNIT_CPU, NULL,
> >  						    proximity_domain);
> >  		cpu_only_node =3D 1;
> > +		ignore_crat =3D 1;
> >  		if (ret) {
> >  			pr_err("Error creating VCRAT table for CPU\n");
> >  			return ret;
> > @@ -1197,7 +1198,7 @@ static struct kfd_topology_device *kfd_assign_gpu=
(struct kfd_dev *gpu)
> >  		/* Discrete GPUs need their own topology device list
> >  		 * entries. Don't assign them to CPU/APU nodes.
> >  		 */
> > -		if (!gpu->device_info->needs_iommu_device &&
> > +		if (!(gpu->device_info->needs_iommu_device && !ignore_crat) &&
> >  		    dev->node_props.cpu_cores_count)
> >  			continue;
> >  =

> > @@ -1452,7 +1453,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
> >  	* Overwrite ATS capability according to needs_iommu_device to fix
> >  	* potential missing corresponding bit in CRAT of BIOS.
> >  	*/
> > -	if (dev->gpu->device_info->needs_iommu_device)
> > +	if (dev->gpu->device_info->needs_iommu_device && !ignore_crat)
> >  		dev->node_props.capability |=3D HSA_CAP_ATS_PRESENT;
> >  	else
> >  		dev->node_props.capability &=3D ~HSA_CAP_ATS_PRESENT;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
