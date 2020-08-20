Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D57FC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 04:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE5320786
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 04:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TQgtrq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE5320786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81D26E89D;
	Thu, 20 Aug 2020 04:41:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB046E89C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 04:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAOb/JYBdZoynJ5vK7UftyrTknsVFZYLDm681xHPVRY/LWIBGOaD+Nbg/GGWttbsqTXl+oLOKT5nrdQUFZdtaphD9IRY0sSS4+7JeiOvGIk4elDsaKl2AB2cSGqYGqmVm3TfZBhvRZ/MTjselFLaL9aSnz8/LsLflBRIHoYBNccdtErub1MXlnAREJ1syNPe7SWdqHtDxyiilY+zDV/3LY271VBA+CyydMgYn1s1Dbv2Qs4VFfCJXnJvCADZgp908Px2wYLzuX9AkzcfmpQpfqNZDBA2JnAXQmtu/tmq2agVP1UQiqb3pHToOWpSirrOCekHl3VLMSh7jBoYxEt3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDuNdZdh0c/swgiWW1cGZ1S5ZraEqfOXaeUfDcUOyuo=;
 b=DOijx7tqMRXLJM8mc+pGEuQfQE8zWB85+QbyzraK6N4Zvme18Cx14Mw1ndl+UU/cd/4zfPZEp+ys03tAWFzr+sdiV10pgoDPRVCnJ3O5cUqwNrGV1WTk3lO6KoIiyOoamrCKDuQSNT2IkPxt0umoN3IgGS+yhzzhQGTkCHtojDzLwxsEDiJW6yGj+aZJc07jpNX4PyXOU79C5F+d7oH2vjG49xWG0plSomkMgWZcT9a2qx4150j3iAnXiGGR/RM25hRIQEpkZoiyczdQ+jfZYIEG2v0A1OzqDmItiRGPz3LUeQq3Win07ts+UC4uRju68/es6z7UQ/XNKw7WqSAqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDuNdZdh0c/swgiWW1cGZ1S5ZraEqfOXaeUfDcUOyuo=;
 b=0TQgtrq95txTf194PqDwvQNLgejfwak915t/Ie+b7Iy3psUt++BUtOMd6ltSexyhcZDSiEWVQR3f7zwp9QrcnNqhYHwt1WmQPYNwnRVQ3pbkd6Is1VE0T+Hl9rc/xIiywDD3vD8+Dw8XJ7ydXPL6He1XwbLX37m9EzWBRD+XT+4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 04:41:26 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 04:41:26 +0000
Date: Thu, 20 Aug 2020 12:41:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
Message-ID: <20200820044116.GA91211@hr-amd>
References: <20200819110647.212404-1-ray.huang@amd.com>
 <20200819110647.212404-2-ray.huang@amd.com>
 <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
 <20200819235617.GB215900@hr-amd>
 <e31242f8-78df-9b7f-5e5a-b57c1722d5c3@amd.com>
 <20200820030935.GE215900@hr-amd>
 <506e0c80-dc4a-c4db-6b34-dddc234fda0b@amd.com>
Content-Disposition: inline
In-Reply-To: <506e0c80-dc4a-c4db-6b34-dddc234fda0b@amd.com>
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR06CA0023.apcprd06.prod.outlook.com (2603:1096:202:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 04:41:24 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd35c6e8-d717-44bf-5af7-08d844c34be8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37923E7C81E3E1600EC7BB76EC5A0@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BJ4l3IAli2klb/Z+5Snl+jBOChhHPZ5GXP8aZ2HQGJe3qQLPoPPEw1P9lRJYBOnbupXZzDAJ1wNpD0HTIjbr71b+EpxYbK9Z2KlepIqitU2h+OEOWR8pJIkSLlah/fzzlddsh0xa3Vh5CdREDuYN/I8+LKgObqaPEjyF/6m4+8Kxst9qt2Yhr/xMox5xVXUYQQRWLj1CY8WrftTd6PlVCMwTJeejzNh6KpPj9bf42tYqWD4xZI0K5leJ50dhlidznINdVV4xp3QdlV9wW/nK67rTp5H6iKjbE49chHt4lDDO9sg93Q0mdZfMymJypXgD2BHIF2Z9vY23uj61LXWXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(55016002)(66476007)(52116002)(5660300002)(26005)(66946007)(66556008)(316002)(6496006)(33656002)(478600001)(4326008)(86362001)(6862004)(16526019)(8676002)(6666004)(186003)(83380400001)(6636002)(1076003)(956004)(33716001)(9686003)(2906002)(8936002)(53546011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zpB0TE2U5o67WvVsBW7A95GNO4EINirmKUGenrexHsEvCC5A/7ombB/hDGT1UEfuqsiaf6Rg/dUtprn76Zb8MdVwarMbmtaci/KAH+T3/krk1Mvrlv7Bzh0n779trWogEgKoIqGSCrG9HyB4++E8Dy2qGCVBqSj6m0ZtkN+fj7FZoTqIm66345o/sq+9Yp2+KfqhyYqg+cq+OTFiFtLDOgUiRhKS+2tcxL8sgC7PlkAeIaCK4+p0QIAp1MYVYgCjKVHO3yhDt4qtjWPf5kC+YxLNXTxc3fuS5BNwzzQCpVAk1evgPYxZ7w+9xcMPo7KsQTbKgvpmiVVbIauBlj6mj85n5KVku/AVhhv9Z6LXSfSnYiIuiam157UgtBfFmrw6SBVbyqcuAnNwt10d1WHeskNfZPE9xZZAEv1C9/RgrUjvdK09/o8AaNtm4RCvI6z3t5HRQVeoBFoNet0YhRUQtnwPF9HGf/U9DefHEH1UFoTrqrP7dQWgzVz+ua6FRleKhRJB5eJL7E4j4//z0T/AVPQAQy/jMQLscxKx+Wd17UQJkK775s0QVHALynUM+tF1qK/vk5NjjrH3F9XK9HNQS4JqgXQqVLV0G9Dt+JoFiwnNK4BOeB1lAKryyY5df7Y+r6MmwzmmY1mzOsbDf1FVEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd35c6e8-d717-44bf-5af7-08d844c34be8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 04:41:25.9993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlWUux62aCsTrseN/1zbSjX55hXhkskY4cPMxXMS7EeEUeHOz8dh3AMs+K1Lf7nGVXBRXml9OgEsPi1PqyUIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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

On Thu, Aug 20, 2020 at 12:05:56PM +0800, Kuehling, Felix wrote:
> =

> Am 2020-08-19 um 11:09 p.m. schrieb Huang Rui:
> > On Thu, Aug 20, 2020 at 08:18:57AM +0800, Kuehling, Felix wrote:
> >> On 2020-08-19 7:56 p.m., Huang Rui wrote:
> >>> On Wed, Aug 19, 2020 at 11:38:34PM +0800, Kuehling, Felix wrote:
> >>>> Am 2020-08-19 um 7:06 a.m. schrieb Huang Rui:
> >>>>> We still have a few iommu issues which need to address, so force ra=
ven
> >>>>> as "dgpu" path for the moment.
> >>>>>
> >>>>> This is to add the fallback path to bypass IOMMU if IOMMU v2 is dis=
abled
> >>>>> or ACPI CRAT table not correct.
> >>>>>
> >>>>> v2: Use ignore_crat parameter to decide whether it will go with IOM=
MUv2.
> >>>>> v3: Align with existed thunk, don't change the way of raven, only r=
enoir
> >>>>>      will use "dgpu" path by default.
> >>>>>
> >>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 +++-
> >>>>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 28 ++++++++++++++++++=
++++-
> >>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c   |  2 +-
> >>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +-
> >>>>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c |  1 +
> >>>>>   5 files changed, 34 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_drv.c
> >>>>> index a9a4319c24ae..189f9d7e190d 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> @@ -684,11 +684,14 @@ MODULE_PARM_DESC(debug_largebar,
> >>>>>    * Ignore CRAT table during KFD initialization. By default, KFD u=
ses the ACPI CRAT
> >>>>>    * table to get information about AMD APUs. This option can serve=
 as a workaround on
> >>>>>    * systems with a broken CRAT table.
> >>>>> + *
> >>>>> + * Default is auto (according to asic type, iommu_v2, and crat tab=
le, to decide
> >>>>> + * whehter use CRAT)
> >>>>>    */
> >>>>>   int ignore_crat;
> >>>>>   module_param(ignore_crat, int, 0444);
> >>>>>   MODULE_PARM_DESC(ignore_crat,
> >>>>> -	"Ignore CRAT table during KFD initialization (0 =3D use CRAT (def=
ault), 1 =3D ignore CRAT)");
> >>>>> +	"Ignore CRAT table during KFD initialization (0 =3D auto (default=
), 1 =3D ignore CRAT)");
> >>>>>   =

> >>>>>   /**
> >>>>>    * DOC: halt_if_hws_hang (int)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_crat.c
> >>>>> index 59557e3e206a..f8346d4402e2 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> >>>>> @@ -22,6 +22,7 @@
> >>>>>   =

> >>>>>   #include <linux/pci.h>
> >>>>>   #include <linux/acpi.h>
> >>>>> +#include <asm/processor.h>
> >>>>>   #include "kfd_crat.h"
> >>>>>   #include "kfd_priv.h"
> >>>>>   #include "kfd_topology.h"
> >>>>> @@ -740,6 +741,30 @@ static int kfd_fill_gpu_cache_info(struct kfd_=
dev *kdev,
> >>>>>   	return 0;
> >>>>>   }
> >>>>>   =

> >>>>> +
> >>>>> +#ifdef CONFIG_ACPI
> >>>>> +static void kfd_setup_ignore_crat_option(void)
> >>>>> +{
> >>>>> +
> >>>>> +	if (ignore_crat)
> >>>>> +		return;
> >>>>> +
> >>>>> +#ifndef KFD_SUPPORT_IOMMU_V2
> >>>>> +	ignore_crat =3D 1;
> >>>>> +#else
> >>>>> +	ignore_crat =3D 0;
> >>>>> +#endif
> >>>>> +
> >>>>> +	/* Renoir use the fallback path to align with existed thunk */
> >>>> Are you sure you need special code for Renoir here? For Renoir the
> >>>> dev->device_info already treats it as a dGPU and always has.
> >>> Renoir also is an APU, in other words, we might have got the correct =
CRAT
> >>> table from SBIOS (the CRAT table in SBIOS for renoir is broken so far=
). If
> >>> we had got CRAT table, the kfd would create an APU node. That's not
> >>> expected.
> >> kfd_assign_gpu will not assign a Renoir GPU as the APU from the CRAT =

> >> table because gpu->device_info->needs_iommu_device is False for Renoir=
. =

> >> So Renoir will always show up in the topology as its own discrete GPU =
node.
> >>
> >> How does this work today? Renoir is already treated as a dGPU. But the =

> >> CPU node info (/sys/class/kfd/kfd/topology/nodes/0/properties) from th=
e =

> >> CRAT table still shows GPU cores?
> >>
> >> Regards,
> >>  =A0 Felix
> >>
> >>
> >>>> I don't like the whole idea of changing the value of a module parame=
ter,
> >>>> because it is global and visible to the user through sysfs. Instead,=
 if
> >>>> you need to override the value of ignore_crat to consider other
> >>>> conditions, I think kfd_device_use_iommu_v2 and
> >>>> kfd_create_crat_image_acpi would be the right place to do it.
> >>>>
> >>>> To avoid duplicating the conditions, you could add a helper function
> >>>> bool kfd_ignore_crat(void) that can be called instead of using the
> >>>> ignore_crat parameter directly. This function, changing the global
> >>>> module parameter, should be removed.
> >>> That makes sense. Will update it in next version.
> >>>
> >>>>> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> >>>>> +	    boot_cpu_data.x86 =3D=3D 0x17 &&
> >>>>> +	    boot_cpu_data.x86_model >=3D 0x60 && boot_cpu_data.x86_model =
< 0x70) {
> >>>>> +		ignore_crat =3D 1;
> >>>>> +	}
> >>>>> +
> >>>>> +	return;
> >>>>> +}
> >>>>> +
> >>>>>   /*
> >>>>>    * kfd_create_crat_image_acpi - Allocates memory for CRAT image a=
nd
> >>>>>    * copies CRAT from ACPI (if available).
> >>>>> @@ -751,7 +776,6 @@ static int kfd_fill_gpu_cache_info(struct kfd_d=
ev *kdev,
> >>>>>    *
> >>>>>    *	Return 0 if successful else return error code
> >>>>>    */
> >>>>> -#ifdef CONFIG_ACPI
> >>>>>   int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
> >>>>>   {
> >>>>>   	struct acpi_table_header *crat_table;
> >>>>> @@ -775,6 +799,8 @@ int kfd_create_crat_image_acpi(void **crat_imag=
e, size_t *size)
> >>>>>   		return -EINVAL;
> >>>>>   	}
> >>>>>   =

> >>>>> +	kfd_setup_ignore_crat_option();
> >>>>> +
> >>>>>   	if (ignore_crat) {
> >>>>>   		pr_info("CRAT table disabled by module option\n");
> >>>>>   		return -ENODATA;
> >>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_device.c
> >>>>> index 2c030c2b5b8d..dab44951c4d8 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> >>>>> @@ -112,6 +112,7 @@ static const struct kfd_device_info carrizo_dev=
ice_info =3D {
> >>>>>   	.num_xgmi_sdma_engines =3D 0,
> >>>>>   	.num_sdma_queues_per_engine =3D 2,
> >>>>>   };
> >>>>> +#endif
> >>>>>   =

> >>>>>   static const struct kfd_device_info raven_device_info =3D {
> >>>>>   	.asic_family =3D CHIP_RAVEN,
> >>>>> @@ -130,7 +131,6 @@ static const struct kfd_device_info raven_devic=
e_info =3D {
> >>>>>   	.num_xgmi_sdma_engines =3D 0,
> >>>>>   	.num_sdma_queues_per_engine =3D 2,
> >>>>>   };
> >>>>> -#endif
> >>>>>   =

> >>>>>   static const struct kfd_device_info hawaii_device_info =3D {
> >>>>>   	.asic_family =3D CHIP_HAWAII,
> >>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/dr=
m/amd/amdkfd/kfd_priv.h
> >>>>> index 82f955750e75..4b6e7ef7a71c 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> >>>>> @@ -1234,7 +1234,7 @@ static inline int kfd_devcgroup_check_permiss=
ion(struct kfd_dev *kfd)
> >>>>>   =

> >>>>>   static inline bool kfd_device_use_iommu_v2(const struct kfd_dev *=
dev)
> >>>>>   {
> >>>>> -	return dev && dev->device_info->needs_iommu_device;
> >>>>> +	return !ignore_crat && dev && dev->device_info->needs_iommu_devic=
e;
> >>>>>   }
> >>>>>   =

> >>>>>   /* Debugfs */
> >>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_topology.c
> >>>>> index 4b29815e9205..b92ce75a4c53 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> >>>>> @@ -1090,6 +1090,7 @@ int kfd_topology_init(void)
> >>>>>   						    COMPUTE_UNIT_CPU, NULL,
> >>>>>   						    proximity_domain);
> >>>>>   		cpu_only_node =3D 1;
> >>>>> +		ignore_crat =3D 1;
> >>>> Don't change the global variable. I think you're doing this here in =
case
> >>>> the CRAT table is broken and contains no GPU info. Maybe we need to =
add
> >>>> a new flag "use_iommu_v2" into the kfd_dev structure to handle this.
> >>>>
> > Find it just now, kfd_dev is not initialized here. So we may be unable =
to
> > use flag in kfd_dev.
> =

> I see. This is very early during module init. When you get here, you
> already failed to read the ACPI CRAT table and created a VCRAT for the
> CPU with no GPU cores.
> =

> If you wanted to add a per device "use_iommu_v2" flag, you could
> probably set that in kfd_assign_gpu when it assigns a KFD device to a
> node with CPU cores.
> =


Yes, exactly!

Thanks,
Ray

> Regards,
> =A0 Felix
> =

> =

> >
> > Thanks,
> > Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
