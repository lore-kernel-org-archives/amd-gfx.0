Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF685C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 00:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929C82078D
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 00:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929C82078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CBB6E889;
	Thu, 20 Aug 2020 00:31:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B286E889
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 00:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpS+cL+zkJeSAWvxsAr/S8+93P3NvlPjY06NCug4jZK0I1/4YUeFm5A6T5+cs0SGIr5beXe9QUHGtxO2dPnWOUpcgNykHz63NAvrvQ9MommmSwPTCWEKudyeqO3PXVRrdrULqPQvAz007YmIn3Nfm/ThIBamQQwIB8E2y2+9v1lw8jichpWMZ0p5jRgiG20DLMm3PvDyHN/ZWy7mD8foO+Kd4wKU9FFLYIdILgQ9bKiF/WBNQ47u7+7hvvoPFBuK4hJFuRWaflNXL5FLex5aPKfc8tCClV8AThbdcNqxoMei5czd/fJhMRxXFyjZU4JONexbc4MGa2JG0cBvC2Zmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh5wUAJF50/2e8/o59qvdlgmOrEZB8xWNcWL5MtOYnY=;
 b=bnlhxrkRvo6kH8MFq7BhEZKSXfl18WVfAilkEiyMUH4+CllYF43ALoCOtxxoYjUyAXPqvDE1OiWrGDYIbLMnvtfd5OO0yHqd1D6vYRJ0VoGFE/RLLqkG4LQzaS0Xfd9Aebx2ptQWM489urxURyuVgDVtCYmUqYxGtFFVPvZ/2ma4VuvulLaEuPn+nPbwERs1394h0UtjR9UBJ+AFJ5oS3r+lLsnxHIOzOAmKKiDPeKR3OP6nf1a07wgdNOGr5+vfYEcwOfpbHrwiFIPAOA+KodS0QNHoaOx6QGqOHx9S6gZNZWde0M/i953pAc9tj80/Hw1TwRCtcsaiyJCiQ0Aveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh5wUAJF50/2e8/o59qvdlgmOrEZB8xWNcWL5MtOYnY=;
 b=fYELTXJNBUlLYxHwYQ/btPh6lrjXtJVrojQLQ7VVqspGLzMPfL9oPP6Upc36SZPCIOJbjcewVF+U0KjWv75akSBvXTdHCuXls8jy/cBw9CeyYMG/hrwK981yj7WT+a9bW7F7GyfsgfFrtKCpx58mZ3lzSDuciDu8rZ79r6DjkYA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by BL0PR12MB2578.namprd12.prod.outlook.com (2603:10b6:207:49::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 00:31:33 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 00:31:33 +0000
Date: Thu, 20 Aug 2020 08:31:25 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
Message-ID: <20200820003125.GD215900@hr-amd>
References: <20200819110647.212404-1-ray.huang@amd.com>
 <20200819110647.212404-2-ray.huang@amd.com>
 <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
 <20200819235617.GB215900@hr-amd>
 <e31242f8-78df-9b7f-5e5a-b57c1722d5c3@amd.com>
Content-Disposition: inline
In-Reply-To: <e31242f8-78df-9b7f-5e5a-b57c1722d5c3@amd.com>
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK0PR01CA0058.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 00:31:32 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d15e5a7-8876-4a8b-85c2-08d844a063c0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2578BFD63B67A311F3802C2DEC5A0@BL0PR12MB2578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtl2w903oZKALZF6uCWD45Cc06T5BidqwFLdduieZB0qAvExk+03BENmMpLtAk6+kuQwVaS9S39UKSFP9gEcKirHyGV4dK+8Sbqbv16u0UExTZJblD8/jRwZiu7TG0V4fPpn3/jWlpw1YFmtm71tg2QC2GD5KtTi4W8v7S0/3JmFe3Lef6d2gRkgafM/kOy8Zywozu4j9MTZl2wWiF0SckOvqdzwRfH154BN77+StFnERThf+Dv8pvMAVm2nhddBNkdMi4qZWWz4I+vm81DYtQ+scUeeM/61WKblBxWXdOralt7935qu4+ZBBA2HVyBiW0+dn41vXI4yKUWd9g+Rqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(26005)(6636002)(9686003)(53546011)(316002)(8936002)(6862004)(55016002)(52116002)(83380400001)(33656002)(33716001)(6496006)(956004)(4326008)(16526019)(186003)(2906002)(6666004)(8676002)(66556008)(66946007)(478600001)(1076003)(5660300002)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ziqxtuE5/ZrWd+IK+VMLqNHuAchwBCNsCe9gvDhSKZ0lY0IQcG/khjJZu77sqnSeShqbGet+WlbTrHkF+EdeX9o/SDqf5vBH4Lg65CR8kHXfJuV39ctdZXwmJiOrgcFYLUpSWsWWcX69V4gOjZvU8u2gVfQznsfjG1swfyASbC96ClhHy2ZAVrKKGYmC76vjlqEsPnHdcBpAt64wfUAN2tbTSwgHFE/OMig+yw06URUn431Tazq9fbnV7oKezH6KfHpc8FoBlw3Po+OQ02LZgMsYoZTJyb5dTGrX5gsryIIv9t5e5hX7fF4h8HI/PUw7sKVGNu1Or9y6EbLpKQYezJw5tUhsl4GjQT3ODwRTCuPk8uMfntyLtB5qAJjMPUgw+t4xlfh4dvQxuCnaEy1JAiezrDbuDy/CoE7KK4iLUjKvvVMhZYY4ZWvJtZDkJ/pHFAIflxHYttznv0n4ghezBkamCbkan7ln8eJdGKgTvCfpOGk2C/dlEVI4GnosCuBw1eCjJqaB+0l2flHVnEpKIXFjvy4ga+SfUGwzXVnoQ9iCqI5xrxHH8B8KUgEH7zO39WMDH350wy1t4t+gPxe5qZj7qQAFygbPiTpqIrE1cdfTgT6We73daokbVYR7CQa8IW7HEcmGefeAxhxHb58i2Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d15e5a7-8876-4a8b-85c2-08d844a063c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 00:31:33.3961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Imz+yRsQrreNsgOvCbq1NbF9+C8WkfH+3Bv78jyUV4aPKoEg5W/OfVydUYFh/WRSGhnjeDNmGgOTe6eZNmvy6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2578
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

On Thu, Aug 20, 2020 at 08:18:57AM +0800, Kuehling, Felix wrote:
> On 2020-08-19 7:56 p.m., Huang Rui wrote:
> > On Wed, Aug 19, 2020 at 11:38:34PM +0800, Kuehling, Felix wrote:
> >> Am 2020-08-19 um 7:06 a.m. schrieb Huang Rui:
> >>> We still have a few iommu issues which need to address, so force raven
> >>> as "dgpu" path for the moment.
> >>>
> >>> This is to add the fallback path to bypass IOMMU if IOMMU v2 is disab=
led
> >>> or ACPI CRAT table not correct.
> >>>
> >>> v2: Use ignore_crat parameter to decide whether it will go with IOMMU=
v2.
> >>> v3: Align with existed thunk, don't change the way of raven, only ren=
oir
> >>>      will use "dgpu" path by default.
> >>>
> >>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 +++-
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 28 ++++++++++++++++++++=
++-
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  2 +-
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +-
> >>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  1 +
> >>>   5 files changed, 34 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_drv.c
> >>> index a9a4319c24ae..189f9d7e190d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
> >>>    * Ignore CRAT table during KFD initialization. By default, KFD use=
s the ACPI CRAT
> >>>    * table to get information about AMD APUs. This option can serve a=
s a workaround on
> >>>    * systems with a broken CRAT table.
> >>> + *
> >>> + * Default is auto (according to asic type, iommu_v2, and crat table=
, to decide
> >>> + * whehter use CRAT)
> >>>    */
> >>>   int ignore_crat;
> >>>   module_param(ignore_crat, int, 0444);
> >>>   MODULE_PARM_DESC(ignore_crat,
> >>> -	"Ignore CRAT table during KFD initialization (0 =3D use CRAT (defau=
lt), 1 =3D ignore CRAT)");
> >>> +	"Ignore CRAT table during KFD initialization (0 =3D auto (default),=
 1 =3D ignore CRAT)");
> >>>   =

> >>>   /**
> >>>    * DOC: halt_if_hws_hang (int)
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_crat.c
> >>> index 59557e3e206a..f8346d4402e2 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>> @@ -22,6 +22,7 @@
> >>>   =

> >>>   #include <linux/pci.h>
> >>>   #include <linux/acpi.h>
> >>> +#include <asm/processor.h>
> >>>   #include "kfd_crat.h"
> >>>   #include "kfd_priv.h"
> >>>   #include "kfd_topology.h"
> >>> @@ -740,6 +741,30 @@ static int kfd_fill_gpu_cache_info(struct kfd_de=
v *kdev,
> >>>   	return 0;
> >>>   }
> >>>   =

> >>> +
> >>> +#ifdef CONFIG_ACPI
> >>> +static void kfd_setup_ignore_crat_option(void)
> >>> +{
> >>> +
> >>> +	if (ignore_crat)
> >>> +		return;
> >>> +
> >>> +#ifndef KFD_SUPPORT_IOMMU_V2
> >>> +	ignore_crat =3D 1;
> >>> +#else
> >>> +	ignore_crat =3D 0;
> >>> +#endif
> >>> +
> >>> +	/* Renoir use the fallback path to align with existed thunk */
> >> Are you sure you need special code for Renoir here? For Renoir the
> >> dev->device_info already treats it as a dGPU and always has.
> > Renoir also is an APU, in other words, we might have got the correct CR=
AT
> > table from SBIOS (the CRAT table in SBIOS for renoir is broken so far).=
 If
> > we had got CRAT table, the kfd would create an APU node. That's not
> > expected.
> =

> kfd_assign_gpu will not assign a Renoir GPU as the APU from the CRAT =

> table because gpu->device_info->needs_iommu_device is False for Renoir. =

> So Renoir will always show up in the topology as its own discrete GPU nod=
e.
> =

> How does this work today? Renoir is already treated as a dGPU. But the =

> CPU node info (/sys/class/kfd/kfd/topology/nodes/0/properties) from the =

> CRAT table still shows GPU cores?
> =


Yes, Renoir works well. In fact, I found the problem while I was enabling
the dGPU path for raven before. Even I set needs_iommu_device as false in
raven's device info. The kfd still creates the APU node. (in v1 patch)

Let me rollback to check it again.

Thanks,
Ray

> Regards,
>  =A0 Felix
> =

> =

> >
> >> I don't like the whole idea of changing the value of a module paramete=
r,
> >> because it is global and visible to the user through sysfs. Instead, if
> >> you need to override the value of ignore_crat to consider other
> >> conditions, I think kfd_device_use_iommu_v2 and
> >> kfd_create_crat_image_acpi would be the right place to do it.
> >>
> >> To avoid duplicating the conditions, you could add a helper function
> >> bool kfd_ignore_crat(void) that can be called instead of using the
> >> ignore_crat parameter directly. This function, changing the global
> >> module parameter, should be removed.
> > That makes sense. Will update it in next version.
> >
> >>
> >>> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> >>> +	    boot_cpu_data.x86 =3D=3D 0x17 &&
> >>> +	    boot_cpu_data.x86_model >=3D 0x60 && boot_cpu_data.x86_model < =
0x70) {
> >>> +		ignore_crat =3D 1;
> >>> +	}
> >>> +
> >>> +	return;
> >>> +}
> >>> +
> >>>   /*
> >>>    * kfd_create_crat_image_acpi - Allocates memory for CRAT image and
> >>>    * copies CRAT from ACPI (if available).
> >>> @@ -751,7 +776,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev=
 *kdev,
> >>>    *
> >>>    *	Return 0 if successful else return error code
> >>>    */
> >>> -#ifdef CONFIG_ACPI
> >>>   int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >>>   {
> >>>   	struct acpi_table_header *crat_table;
> >>> @@ -775,6 +799,8 @@ int kfd_create_crat_image_acpi(void **crat_image,=
 size_t *size)
> >>>   		return -EINVAL;
> >>>   	}
> >>>   =

> >>> +	kfd_setup_ignore_crat_option();
> >>> +
> >>>   	if (ignore_crat) {
> >>>   		pr_info("CRAT table disabled by module option\n");
> >>>   		return -ENODATA;
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_device.c
> >>> index 2c030c2b5b8d..dab44951c4d8 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>> @@ -112,6 +112,7 @@ static const struct kfd_device_info carrizo_devic=
e_info =3D {
> >>>   	.num_xgmi_sdma_engines =3D 0,
> >>>   	.num_sdma_queues_per_engine =3D 2,
> >>>   };
> >>> +#endif
> >>>   =

> >>>   static const struct kfd_device_info raven_device_info =3D {
> >>>   	.asic_family =3D CHIP_RAVEN,
> >>> @@ -130,7 +131,6 @@ static const struct kfd_device_info raven_device_=
info =3D {
> >>>   	.num_xgmi_sdma_engines =3D 0,
> >>>   	.num_sdma_queues_per_engine =3D 2,
> >>>   };
> >>> -#endif
> >>>   =

> >>>   static const struct kfd_device_info hawaii_device_info =3D {
> >>>   	.asic_family =3D CHIP_HAWAII,
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_priv.h
> >>> index 82f955750e75..4b6e7ef7a71c 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >>> @@ -1234,7 +1234,7 @@ static inline int kfd_devcgroup_check_permissio=
n(struct kfd_dev *kfd)
> >>>   =

> >>>   static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *de=
v)
> >>>   {
> >>> -	return dev && dev->device_info->needs_iommu_device;
> >>> +	return !ignore_crat && dev && dev->device_info->needs_iommu_device;
> >>>   }
> >>>   =

> >>>   /* Debugfs */
> >>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_topology.c
> >>> index 4b29815e9205..b92ce75a4c53 100644
> >>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>> @@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
> >>>   						    COMPUTE_UNIT_CPU, NULL,
> >>>   						    proximity_domain);
> >>>   		cpu_only_node =3D 1;
> >>> +		ignore_crat =3D 1;
> >> Don't change the global variable. I think you're doing this here in ca=
se
> >> the CRAT table is broken and contains no GPU info. Maybe we need to add
> >> a new flag "use_iommu_v2" into the kfd_dev structure to handle this.
> >>
> > Yes, you're right. Will remove global ignore_crat update. Let me revise=
 it
> > again.
> >
> > Thanks,
> > Ray
> >
> >> Regards,
> >>  =A0 Felix
> >>
> >>
> >>>   		if (ret) {
> >>>   			pr_err("Error creating VCRAT table for CPU\n");
> >>>   			return ret;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
