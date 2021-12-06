Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6496C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 15:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7F27B06B;
	Mon,  6 Dec 2021 15:38:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9F37B065
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 15:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLym751wCZR4ZOjNS22V3NPUMqJonLTC9hqsGi3wK8teCW2H22a0DO4nf8eByg2ICHHI0A7GNSkkq/jDGMMiiUwQKfgMC1H3rnCL5sM+XFmCaIqI59QTEg4oOleM5dtWcGXSLxNaK2+dfP2rFrh5JZPDUiZD97AXdzBqOLdggOYGlHL9Aj68WgiqnjNlUd4OQXKom+6N7lMlz2k3SowIiQJyfT/pmn5tg7WfJKuHlGGDRnN5CV0d6yxCk5fQMWiKu+KXfFtvbDSTatH3jtleuE3U63cxuI0JxHOLi1+5bfzh9m4UCNe8wQMHEQA5ZRODQ+C3wlodA8NnKJKRMYiq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NprOK3S3hG1EKerJZAFAWaFuwv9CtjiSdlLNdJu6u8=;
 b=PQsuYbE24UChCc5QI19nL/BuuOxLYnEct/Cr3i2C6ZdHrtfcQJHPxBKyZLI7ePqOMq1qb4IaqNyMEnmWx9F09r22y7imVvAE2ZgBBRxjEsPqerjNPx9F7xNG0zzyg3IYLApWtna3GoML/j5cQFOGLB2DOfdK+zybNcOAFbV8LM9YGNU2IZfMl7nrVuGdHcK6mushLN5tfDeQjOyNhJ00YLDs5GNrLo0vLZCJxpnnBSWXjBsiBflICfZrYEy2OIAQev8YdmI8cnJ98qrnmgxHdQigOhN9rGfpewQCvHxbix/SbQF74Rqufh8u36bhWiOBqwabVLStnoeO7w0g7QRD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NprOK3S3hG1EKerJZAFAWaFuwv9CtjiSdlLNdJu6u8=;
 b=0B79h9p0TrOADlTdoetHg4K0YaRaEYKoeVgR/Pb1exNARCgk+KJm7J394b49pOCb65g/x4weU+NiqaSije4RmGm0MuJPkOd56toQk6fMmaJ3gwA8ubWjSRQiQ23NLw1OmIqyXyS5lH8JIC928VmLbKoN9yj+Uqa87mNTuS3NxMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 15:24:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 15:24:28 +0000
Subject: Re: [RFC PATCH 1/2] drm/amdgpu/UAPI: add new PROFILE IOCTL
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20211202191912.6148-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <88bab1a5-0b03-b0ea-6cb0-19d5e71d1ff5@amd.com>
Date: Mon, 6 Dec 2021 10:24:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211202191912.6148-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 15:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b182993-be12-4b2d-e55e-08d9b8cc7e54
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211B4600ECCB841008C6ECE926D9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9SQM85dHKGY2mMKKd1qcPPBicqMHr7PNsuG8bJF7Jf7Yz2SJTgZKVwGpfirHMM724VJNXA6M9eTNzy38gmc6q5b2L+43xS7sxXDawKrzu+U0P2J/ZDRXv6RDARcvcYTUkngT0V9AfqgqBhr0GbhE920f7DI/foDdGxuWHunidw46A9T9GFoWuwTZzFdkbZrkR5jvg2rY+MdZ2kGKFmL+CVlidMd+/Ys+y578sv3dpCzOefj0FefXmVrlhbjr4eyueGiAAmxuXSGrLmxlcrvEF0jFiFBaJJYMpm+QP2RoiMQtVSXU0t0JQrmlG9hq8oLaVsf+O1dWttiNxmfOrumTrfYhh87veKtcNIEyc3pAjvU+dDfVzTnSgnoACOCV9yOGYnnHG3dvQogOP3wdJnzkhY9S1ua7msa6j/gG6TXAncKz0iDXpkT4pMcjiOKbfnQFbsemyVthuiLvQ8HDZWKVNvjondQNUsnOQALXVhLcclo66Pma9FIzRTv6RLIiT2y9wBH/djCUmxAo2fYlkDH2Cll9fJ6jGHf27zGPt67vVBTtc5f4lHrpcDLEz1wd2EfbnUqzj+8MrNm2CwtZxd+GnwAL8qwXOHvzNJvoCP3UaU+SdKEWohOPfa0mVNSete6SnNw6U3H9T6AANOjWsVu34uVcwPXJAN5GJ3fEIqD7GrYA/dVsynOp1WrwXpiqvcG5VPAbns70PzvPPxfm049hdaL1dI+wXLii87PLv4ywpwXTF40Pi0WTCsTY8nVFtk7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8936002)(38100700002)(31686004)(6636002)(31696002)(83380400001)(2906002)(36756003)(86362001)(6862004)(8676002)(6486002)(16576012)(5660300002)(37006003)(956004)(66946007)(316002)(66476007)(66556008)(30864003)(508600001)(26005)(186003)(2616005)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hTUU1POWd0ZmVHZUxsUzVzQVdERGdWa0EvVzZjbWVTd01iZ1h6Z3FSa1ZZ?=
 =?utf-8?B?ZzFuMFEwZXZabWFZT1B0azJPcmsrMDMyajJxbG1abE12anNKdFdTQWpZUmRP?=
 =?utf-8?B?RzRzU3IrTG13LytKeG95ejdXUFRKM2RpM0Vac0hxZDh1L2JTRWJhb2NOYWhl?=
 =?utf-8?B?dXRzQ1BjaWdmRzJkOTJhN0lDQ08rTkgwSStGVHp2MlRMSHV4OFFRQk5iamp3?=
 =?utf-8?B?ak1YOG1iclR5N0VOSzYxVzNzSG1hMUN1N3R6Z01NMFpqb1RwSHJXVzBNdkJq?=
 =?utf-8?B?M292TnhKbkdZU0gzSTBjMVAzLzduRnZTY1dFWDBxb2RsWnhuRnNTWG1UWEFm?=
 =?utf-8?B?cmE4dFA1TW5RbEFrNHVWOVJPVEZLVEppTE1VS1RyemdVOXJtczRnbXFINnN3?=
 =?utf-8?B?R0UrVldWVVBKUTR6MHpZOUJCQXZqVEVsZlU1bTJ2QWNBZlE0R1FFZ1oyVEtE?=
 =?utf-8?B?S2JwZmlOWTIvNVBZbU96ZXZvSGdiODR0VERDdFVPMkg2Kzg1RjVnb21nQVBs?=
 =?utf-8?B?Z2R4bHZqQ3N2bFM3YzNSKys1NmlMSnVndzdLUTJabnJwL0xGelJnOS9RR1o3?=
 =?utf-8?B?N3JGOWZjM1lQLytQMU1ZNXJUS1c3RzZnUkhWSHBPZXRKcldmVkIwZXQ2TXZk?=
 =?utf-8?B?UUNkdjhWQ0tFY0MzNmdWR3lwS2Q4Q1UrMUk1MEZUZzhrTWIwbmZMTldSbTlJ?=
 =?utf-8?B?aEx4UFZ4cUxWTHA3ZVZ0bGlaSFpmRnZYKzZMWXBOaUplejBvM2w0UWNrZjdS?=
 =?utf-8?B?dmJiL0wrQUl6T0xuN0FNSjU5Ukp5SnZlS2p2bkx0M01xclg2VUFJWGdNNkNH?=
 =?utf-8?B?azlHWk1sZkJGOHQ4SUxEK05kKzF4RWR6TldPTDU5anlmTFFsU0h2VUptdERX?=
 =?utf-8?B?WVQwOVdQZmlCNmRtNkhHWExMWlk2UzJIdlBEeElqY2dONnFDN0tOS0ZhUnp6?=
 =?utf-8?B?NDJNMitNbVdIOTNmRml2SlRKU3lTZVpMZ1o1QXc0dlQraTluZWdrTlZXQmxv?=
 =?utf-8?B?c3paSGtxeDdKNFN0cXMveFNFZSsxRTdNcU8rcDF6VXE0TGI3VERoeC82dWtm?=
 =?utf-8?B?MjBOdVF6c3dEYUt5ZTRWS2JoZ281UWlGVXJma3R2c0tmUkFFcTB5d2pRcjJv?=
 =?utf-8?B?VHVTeEVMOVNoN1cwZ1BUTnVEeUZqdTNNMDJNa3d1Z00vNDVKMTR2U3BVWXZE?=
 =?utf-8?B?RFJEbk16QUt0TnNLd08yc3A4TnhKckZSZittS1ZHL05yV0w4cU5RV1BNZWdW?=
 =?utf-8?B?bUFoWkRLaVJDdWIyK0k4Q09RSEp2YkNud2VhRmFsN0l6dG1mb0dBMGV3cVph?=
 =?utf-8?B?RWhQbzg5eCtRVUlKUWdtM1E3WktPczFFNjVRd0RPTE82SkJhaXIxTnNvMjBG?=
 =?utf-8?B?eDk2L0J5MWNXeVRMMDBQVHRmNHFKbXBxUzJlcllsbnBSbDluUnJHaE1aSWUy?=
 =?utf-8?B?REhmOWFqSUxDTk02VGV1aUtKcnpuRGptdjU5Qk5ZeWkxRWYzbnRtSmZLaGFy?=
 =?utf-8?B?UDUwZXJndy92MFZRZ3gwcFpLbGNRWXZtUDJMRm5CbmNUbElER0p3ZnRnOCtF?=
 =?utf-8?B?RDNoaDBYU0RJbEFha0dRdVBPMENPQndDVllNZ05qUTZDNmRCQmpFR2RkWWZa?=
 =?utf-8?B?VGJONi85VVR6WWJHcnFZVXN5dlhDNm95UFlYaWFNTmdZRzFralBteDZaWDBO?=
 =?utf-8?B?ZzUzUGcrUEZpVm41eEw5UE4ydUFiTnNRQ1ZFWS9ha0lJdlNkTU9tK3pBY3Y0?=
 =?utf-8?B?ZmE3Mm5VdjJkZyt2eVQzaEhUU2g0M2s3TENyVmZZbTNmcWZjdFpOY2szY1JO?=
 =?utf-8?B?MXUzYjMyK1krQlJsMFVQanRTZ1g4eGJvR0NYSEtQbGlyWEI3OTkzMVdYN01i?=
 =?utf-8?B?eDJ5VUY2QUd0dHFKNll4eUp6RTU3Smw3Yzc2RUNvUW9OdmtwUEU2azJ3ZFR5?=
 =?utf-8?B?VS9CUUJkdGdUbW5Kc0VNK1NwRUQzUCt0Qzg1T0pSVlh4Tml4MytZUHZINVFs?=
 =?utf-8?B?bzkvejk2emFTM1R1SXdtWDlnNHNzRHladDNTa2wyeWJXdU9ISHM0Umxad0Zm?=
 =?utf-8?B?aWVTTzBrVVBIVmhVL1hpblB4c1F6bVpxaWFJSFN4dW9DM2tBZnpDK2VNMzhC?=
 =?utf-8?B?RENzWXRxbFY5VWdLd1Q4QU1qUHVSQ1VXWU5GRzhUallMUTVzVW8xVy9jckhR?=
 =?utf-8?Q?fJr+MNUr3JkP3Guv36wesWE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b182993-be12-4b2d-e55e-08d9b8cc7e54
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 15:24:28.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSdStXOuLCTeDYXHuN442CZOGE9FsYo8zo8uAaczCs1TblJEDFjbyh3QZaycWIRu4DyFGk3wp0UVMyN1MKceGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-12-02 um 2:19 p.m. schrieb Alex Deucher:
> This adds a new IOCTL currently used to implement querying
> and setting the stable power state for GPU profiling.  The
> stable pstates use fixed clocks and disable certain power
> features in order to get accurate pipeline profiling.
>
> Currently this is handled via sysfs, and that is still
> available, but this makes it easier for applications
> to utilize.  Note that the power state is global so
> setting it will affect all applications.  There are currently
> no checks in place to prevent multiple applications from
> using this interface, but it doesn't make sense to do
> profiling while you have multiple applications running in the
> first place, so it's up to the user to ensure this in order
> to get good results.
>
> This patch add an interface to query what profiling mode is
> currently active and to set enable a profiling mode.

I was expecting this to be some exclusive mode that only one client
could use at a time. If someone is already using it, other users should
get -EBUSY. When the client terminates, the default mode should be
restored automatically.

It would also be nice to coordinate with the existing sysfs interface in
some defined way. E.g. the ioctl could override the mode chosen in sysfs
and client termination would restore the mode chosen in sysfs. Or a
non-default mode in sysfs could block the ioctl (return -EBUSY), sysfs
writes fail if there is an ioctl client, and sysfs faithfully reports
the current mode chosen by the ioctl.

Regards,
  Felix


>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c | 112 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h |  30 ++++++
>  include/uapi/drm/amdgpu_drm.h               |  28 +++++
>  5 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 7fedbb725e17..4cf5bf637a9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> -	amdgpu_eeprom.o amdgpu_mca.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_profile.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bc1355c6248d..0e27f9673f8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -46,6 +46,7 @@
>  #include "amdgpu_sched.h"
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_amdkfd.h"
> +#include "amdgpu_profile.h"
>  
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
> @@ -2467,6 +2468,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILE, amdgpu_profile_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> new file mode 100644
> index 000000000000..94fe408e810f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/amdgpu_drm.h>
> +#include "amdgpu.h"
> +
> +/**
> + * amdgpu_profile_ioctl - Manages settings for profiling.
> + *
> + * @dev: drm device pointer
> + * @data: drm_amdgpu_vm
> + * @filp: drm file pointer
> + *
> + * Returns:
> + * 0 for success, -errno for errors.
> + */
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp)
> +{
> +	union drm_amdgpu_profile *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum amd_dpm_forced_level current_level, requested_level;
> +	int r;
> +
> +	if (pp_funcs->get_performance_level)
> +		current_level = amdgpu_dpm_get_performance_level(adev);
> +	else
> +		current_level = adev->pm.dpm.forced_level;
> +
> +	switch (args->in.op) {
> +	case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
> +		if (args->in.flags)
> +			return -EINVAL;
> +		switch (current_level) {
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
> +			break;
> +		case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
> +			break;
> +		default:
> +			args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
> +			break;
> +		}
> +		break;
> +	case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
> +		if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
> +			return -EINVAL;
> +		switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
> +			requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> +			break;
> +		case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
> +			requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		if ((current_level != requested_level) && pp_funcs->force_performance_level) {
> +			mutex_lock(&adev->pm.mutex);
> +			r = amdgpu_dpm_force_performance_level(adev, requested_level);
> +			if (!r)
> +				adev->pm.dpm.forced_level = requested_level;
> +			mutex_unlock(&adev->pm.mutex);
> +			if (r)
> +				return r;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> new file mode 100644
> index 000000000000..cd1c597bae11
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profile.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_PROFILE_H__
> +#define __AMDGPU_PROFILE_H__
> +
> +int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *filp);
> +
> +#endif
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 26e45fc5eb1a..b6edf4a826f9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>  #define DRM_AMDGPU_VM			0x13
>  #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>  #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_PROFILE		0x16
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>  #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>  #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_PROFILE	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILE, union drm_amdgpu_profile)
>  
>  /**
>   * DOC: memory domains
> @@ -1120,6 +1122,32 @@ struct drm_amdgpu_info_video_caps {
>  	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>  };
>  
> +/* profile ioctl */
> +#define AMDGPU_PROFILE_OP_GET_STABLE_PSTATE	1
> +#define AMDGPU_PROFILE_OP_SET_STABLE_PSTATE	2
> +
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK	0xf
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE	0
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD	1
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK	2
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK	3
> +#define AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK	4
> +
> +struct drm_amdgpu_profile_in {
> +	/** AMDGPU_PROFILE_OP_* */
> +	__u32	op;
> +	__u32	flags;
> +};
> +
> +struct drm_amdgpu_profile_out {
> +	__u64	flags;
> +};
> +
> +union drm_amdgpu_profile {
> +	struct drm_amdgpu_profile_in in;
> +	struct drm_amdgpu_profile_out out;
> +};
> +
>  /*
>   * Supported GPU families
>   */
