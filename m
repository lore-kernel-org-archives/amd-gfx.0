Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D1CCD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 04:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 295DD10ECA0;
	Thu, 11 Jun 2026 04:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZSc9zr0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66BB10ECA0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 04:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKadjPlw/GJe+I2FZdcXihEHcq+3WWSncW8U0V1i7/W8nREzINeJe3NVzogK4ytVDhVUj80dXZCCcaVqFqMd6/R23IWwcpG55nTu4oIysAaMOp1kMqaM6IWyex05Kyv/IyKCnMnrE5s8jD53Svt3mNZEl3QDZGAh24ZRI8G4Ssb2+OIPMQR5kL8md9nZE79J9h5Ho1bWdXbXufFLzvLi2CLduRijtdYY75NxcAgDVGSKEdN/kbXEc2PI8ejT/aeUlSlrHY7rbpw/pFNDGlMRNoKpBJ8TMWoMx9j4wvFguGMSpnMZgT+3c6kn/4qRgrVOGcQ1gr6NN57cdOAhRw35Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkMvs/Yha4rTtFhcTsTFUmlBkd4dlfqsBDWPqyBLems=;
 b=B0qgY9M9MhqFfLixZvoYhfjP4GD/LUfPBucMRQ0CV3WeIHiDoocWX6SY3+eE9Uf7TFqtIeCK0Qn2ISQR/ZKxXfjYv+OZMbSZViDaEh+8A2J5Wtt6p+6inccEQrtWOUCSAxKNBDnSYv2/g+WSl/f6Mx0TMBmWOAbATKipns/ng/3laC9SyoWBEAAM7rXo5XCoOklqMPfSqvHzx6hkZumNPSnFbdfVpAoeRnUoXCc52vKvrPwKmrJZ3kJeAaXqiKDuFUzgaNlhABPYc6b9mG5TfJKytYErPgxtXOIGptjkSX7f2Zh0DMcSfFCFAn9jfAIAEKKif0zcdXLL+kG/JUp+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkMvs/Yha4rTtFhcTsTFUmlBkd4dlfqsBDWPqyBLems=;
 b=mZSc9zr06jtMe58AaoUySmuDAYTfQr3YtysI5ypCl0AsdWTMAFeieLEiP6+zYifycP6CFaQbVC75Uz1JxsWk+XX5NV43yDx/iG7Rl9GNOyePuumzT7euB2/a5+/vYdiTwOt5FwmPDrHXsbatH1Ato1J2B77oHrJBQleC2jSEbt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Thu, 11 Jun 2026 04:37:23 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 04:37:23 +0000
Message-ID: <b0de670c-7d16-4b5d-b167-8396697aece2@amd.com>
Date: Wed, 10 Jun 2026 23:37:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: add AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU
 debug mask
Content-Language: en-US
To: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: victor.zhao@amd.com, amd-gfx@lists.freedesktop.org
References: <20260611033953.362305-1-guoqing.zhang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260611033953.362305-1-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:805:ca::20) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DM4PR12MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 00fdec60-67be-4c8b-a93c-08dec77321c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8PKDqObdmOAkmK+glfXS8XuB70lxXm0coKQnOCaYQydd8DruydpkEHg7LiwgSrTVPXMFBFxP9SldNKP1AU+9phiU+1qHlvCzVN4DTPv1NGAfi9/EhUtaE0pCU2OLwx/S3+nIY5ypLOBD/kO0NFQYhWN3JO+Sv0jPistQc/NaD7qvSJsSyYpOyYCVKErT4c+FHzLSF6Lsiy2WcIs5q433zipwVeTP/lSinPYpnSe6KJUw2cR2l/DJGscqxGakerr84QiEN1XUzWvOusgobXtgqQAI5Bk7SLrbmA6z3+fjCY4BOwYfj1+M/TctqK+xAj/PsnqFvVJjJzRM+aHq6scPCi9EcaiLVJnbS5+bX1AAloucytVtxIq+zSeMM/VrO4nkRsowVd1uvbBcNalyCkQG3Ksezg70KQ/SUmjHpZS+vo28sh7Zj3HsgZNnqkVRKGwpm/XmifjjvRTeyYaIj9vJNj+73pntmTNYAD4lfezefvFM0Az3K8ELvVvXDaUKB6pFIXwHZ5QBwbs4ScKltmwIs8hFdtGGP/d8nS7HdnoSb6jFfhyNL8V9wgLhk2WZNNRvRtHwCg6Ks3t4bsn84+YQaPrCuO8ZO07h0M98WsjEOT2PEvowJxvAUco4wJXYnE6iz0328jyBXWUx3OgIvcXx9kQ5Fy1GRq7Qz2kS7f2UyvM6ckz1BwXJXwfVY6iNxqzh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURNdWxqeTF2bTBZMFpBd0hEZkZoLzJFeWZEbWlDY0ppNjZpQ2phLzJQdE9w?=
 =?utf-8?B?ZFVJdkRaeUhHNTRxcmFPcDA2RkpPTlFQUzJSMGFoeDhpbGc0NGxsTjhkMTZB?=
 =?utf-8?B?L0RwcnhSKzVKSm9LclZTU1lydWdzNG1sQVN0QUhHN2Rza3pCbGxueDBhWUQ5?=
 =?utf-8?B?ZnhBZjk3WDk2VTZ4YVJibEl1RnRlTkFrSFBMU0lRYnNLeXB0ZnJtdVhPRTVL?=
 =?utf-8?B?dGVnZkFmejJXRDFML2F0S3R4RzQrcnRacUlnWGpxa2pYRHZJMjNMRXZPaTVz?=
 =?utf-8?B?RW03YS9Od2xVbVIyZjh2WU0xTnBYNER5QWIyajdFNUVUK2w5YURLb0syRkxQ?=
 =?utf-8?B?a0tYWW82L0hVWUVvZzdudXo2OW9ZSzFaMHQxelhkQ2ZKUmpxV2NQMjNTUU94?=
 =?utf-8?B?RzFSR2ZzakQ0dDQ3NWkyV3dtd0ZxMEFKL29GVkovZ2xvWHBOYkIyRm43eE4y?=
 =?utf-8?B?ME5aWG9qQUs5YXE4d1lGbXRMQm5pQlV6eXc3MTdpdHpYMmdDcVVlSm84MWYr?=
 =?utf-8?B?UktJN1BXdHVVaGtXOE9EcjhCSzJxRk9OT1hxZ2VmNndlcFlZVXAwcXBFTkcy?=
 =?utf-8?B?NTF2ZjJCcldQc3E3YTNUaVE5VHdiQ1l1MDd0Y3dEblBkREVCWTBPU240UWRp?=
 =?utf-8?B?M2l3QVMrMC9jNVB4WlhGSVRteGFOb0NXTFM4SkhvUU4wdFY1cktjMkJ2U1l2?=
 =?utf-8?B?UVBtZzkxZnhrKytsbDd0SVNpN01SZEpGU0ZjUTNBRzRaNTVYajhsSU1PV2JI?=
 =?utf-8?B?Rnk5TzdtblJsK240WnVhR1B3WkRaQVkvZHFYUm5sOUw0VG5QUVJsem91OUxh?=
 =?utf-8?B?b1ptZUhZU2tMMmRXcnZCV3lmRnFHdjkyRUFiMWFMaDVNTS8vMlpsa2IwUEVT?=
 =?utf-8?B?TUUxZmsvL2l4OTFwc2VnSjJIdUhKUlBxd2lWelEzL1hwQ3lVNENiN01rcHF1?=
 =?utf-8?B?eXN6b2NlTUcvYTRvazlQN1Y1b002eEhRTWF5T3NzWWpIdWFRc25BeVJPOGpW?=
 =?utf-8?B?cEhkOWFkTHlTSHBFZjlkeTlkQklqT1RGNVNmODRzR1A4UjhBdm9yYkx6M3pT?=
 =?utf-8?B?NkpzYTJMQXJOQ3M1S1VQOG5jRmlXT1JMM2duQnNzTG53K1JubDIxTUpaaGRY?=
 =?utf-8?B?MFFFbk9QejBDVEd5Zm5xaHNCdGZINVRJZjRuWmI4Z1JFVXNUWTVCSGNCUUU5?=
 =?utf-8?B?NHpBZ2FhT0ZWSnVSM2o2VHNhZFpjKzNhT3k4Y2Y4bGtaYk5wcUVUcnlMRXVX?=
 =?utf-8?B?MThTa1JaRmIrWXpKeU4vOUxXejQ4TlBhVXhuNzN4VkhzVGRyRGUzSHVONUxi?=
 =?utf-8?B?VUxTbHc2V3NVYUtQVThuWjZPQ2RMeE1NUm1TeC8vVWlPcFFTWW4xaFFOYktn?=
 =?utf-8?B?YVBrbEM3UUJtQUY0MkRRM1ZncmRReis5b1FSZTVsYUVLV1NNTHZGV0Y0UGRO?=
 =?utf-8?B?V3orNElRN1lVRmtLdXh5TVhrZTJ5UC96aDQ3ektuQ0dCSjB6RnA1QXo2bmdK?=
 =?utf-8?B?TExDYWdFZ25Hc3lHUytaNHFhWTRnWi9zeUJ1aTQ2SmcxdHlVZytPc2ladG9H?=
 =?utf-8?B?c29yYWxYNTlvQjdoTUJRcmFjRjN2Z1RRTUlNcWxpYzErK3JZMjR1aVY2d1BS?=
 =?utf-8?B?bE5YczVVRXJteUoya084bnpmSE5xbHpOakJMK2ViZEtZaXZvZFN1TVBtc0lv?=
 =?utf-8?B?OWl5TURGcUdnbWVISVRPTzVRY0xXTE9hNVYxYkJDZHBlZDU3d3RjRU5iSkR6?=
 =?utf-8?B?cVByclJRdHhpeGMvSjJ0cnNDY2UxVXQvUUpkYmVkQlNyYUttM2MrNFRkQXEv?=
 =?utf-8?B?Q0t0Sm1MY2tSSVc2a3hudVlIUldxWURYYUJuOTdaNi84KzdadkhlZlNQL2NI?=
 =?utf-8?B?bmRlQWw1eXJWRHV4THo4dDRob0lNOHc1L0lMZCtpVGhqeU1VS1VWd0V4L2lw?=
 =?utf-8?B?K2FnMEtmWGRFVnNIekhITVBxQUVXdWxxS0swMnVtelU5WHBLR2xFQ1lhLzlp?=
 =?utf-8?B?Q2JId0h5b3Z6M0twY3BoVFpXcmdaOTkwMXc5Vm91dGM0N0hNcWNiTE0yUm4r?=
 =?utf-8?B?Z1JTckZHWlBuSGc0eGFIcXd2RlJTeFlUR09ab1ZEQTV5YXlNUVBJZWNUdXJw?=
 =?utf-8?B?T3JCbWYwNCtqU1IxQnlzOWFCaC9xb1o1aDhWR2t5WUpDT1plRG9BT2JaQ3lC?=
 =?utf-8?B?NUg0LzdmQklsOHRscENVWlcrSTJkQUorODB3Ynd2U2FFekE1eWJxZU1JRTFR?=
 =?utf-8?B?cjFpVjUxNGo2SVFvdE5CSW1EL0VzZHpGVlM1SGszVm9NZ3NSRUtoNFlFeHBp?=
 =?utf-8?Q?lksyxLs4F1UD5RnVDK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fdec60-67be-4c8b-a93c-08dec77321c9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:37:23.7168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbButzhhSur2bFJMpt4TQ5UWQl/PGH4jk/DpRnA+WEpVqz+jvEl0BqtyCzUcUSp8/asKQjJlKAZs38J8ONU0uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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



On 6/10/26 22:39, Samuel Zhang wrote:
> Kernel parameter `no_console_suspend` is required to capture all
> hibernation kernel log via serial console. But when the parameter
> is set, GPU will be resumed in thaw stage. This causes many issues
> on alinux3 kernel.
> 
> Fix: add new debug mask `AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU` to
> replace the check of `console_suspend_enabled` in thaw() callback.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 503bb64c1e55..18385c09e9d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -33,7 +33,6 @@
>   #include <drm/drm_vblank.h>
>   
>   #include <linux/cc_platform.h>
> -#include <linux/console.h>
>   #include <linux/dynamic_debug.h>
>   #include <linux/module.h>
>   #include <linux/mmu_notifier.h>
> @@ -146,7 +145,8 @@ enum AMDGPU_DEBUG_MASK {
>   	AMDGPU_DEBUG_SMU_POOL = BIT(7),
>   	AMDGPU_DEBUG_VM_USERPTR = BIT(8),
>   	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG = BIT(9),
> -	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10)
> +	AMDGPU_DEBUG_ENABLE_CE_CS = BIT(10),
> +	AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU = BIT(11),

You should add a line to amdgpu_init_debug_options() as well for this 
change.

>   };
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> @@ -2707,7 +2707,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   
>   	/* do not resume device if it's normal hibernation */
> -	if (console_suspend_enabled &&
> +	if (!(amdgpu_debug_mask & AMDGPU_DEBUG_HIBERNATION_THAW_RESUME_GPU) &&

We don't seem to use this code pattern elsewhere for amdgpu_debug_mask 
to look for a bit where it's needed.

Rather assign a variable in amdgpu_init_debug_options() and look at that 
variable.

>   	    !pm_hibernate_is_recovering() &&
>   	    !pm_hibernation_mode_is_suspend())
>   		return 0;

