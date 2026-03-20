Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED31A1093181
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 07:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F47A10E4EA;
	Fri, 20 Mar 2026 07:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hviyEJqQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D46510E4EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 07:33:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k13rN4HQNF5U2ic5LapheHPU2NHWcs+LJng5eroWlMt0YtAfUVOiV/i99gx1ThETdUGLU/CQiV8uMunWQ+Mgky1eex+4Tb+S//bcghmmLelC6xmcYo4IQ7g/CC7n65TV+ZcZ4qO61OZG/V1TF4emRI/E8u1ngWypIiauNT3vlM18KMXu17VFFHFJMYVByxfdca//061qFzLb6b7KUUApS6Jn06/1jd4qyNlRse1jkXctAri6xx7TLpZmIFRKVM3CqzUXFecE5zJpBSfnVoaNpHwCx7oM+H+iQ56Lr79/z3fCjqoP8vzpDcfEEvTn6fLWqui8xJAB/2+Gygzcd9hPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GAwVQpfZNUHlYrl9hL7KNx8NR4T4LCvhc2lFAcItXM=;
 b=N9qZZ3MxyXrfyTQreAdKu4Ivqqhk0AXuehIRIs0cxi10EHhr/cVDq61kfGC7AzOxemKjwpFosxx1T2kp4AWoMTrm3p2V0fVW/u10qZ2EelarlCW1KQ8Ntl1k1xajEHqtuTscUwf56ImsSzt/ujaQsAN9IK36j99UCSr+lIJEkqOTgYbV/FFCAmzYSpbMfwwujJbYOp5zCYypVuPJ6pBM9zbCw5xny9YAIAbOPStaDYH1tzm5xOlB2SaG6OGOk7fgwXnadzSplxlOCUC7NOcSarVmNDztTq5kUvCI7I68dbMh857kdDUR2UCXsR2+DgKqw0TVoCPmNZ6cEhdeRSQe6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GAwVQpfZNUHlYrl9hL7KNx8NR4T4LCvhc2lFAcItXM=;
 b=hviyEJqQxrHQwrNZCPZDj6Eqlup04BP3FOee5S4S3LbeCdVdQbQzTDF/mR4Sd3Kao9u1GBGL96GswgQn5mJKTnrSYxnVH1Ma9u5eYuiM9HnN+iGIBJcL0JwnUEYqWi/C+J5GS3q0Lh3fBaO9A+B/9z6rVNZxLatAy4t+SFpKRZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 07:33:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 07:33:47 +0000
Message-ID: <66d0a3ee-ad82-46f6-a4f0-bc29f6ba87dc@amd.com>
Date: Fri, 20 Mar 2026 13:03:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260320060409.616702-1-lijo.lazar@amd.com>
 <DM6PR12MB29727D5217CFA4B1590DACE1824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB29727D5217CFA4B1590DACE1824CA@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce74a88-b20b-4b97-65a0-08de865305da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: id+XtzG6/DMcGblSQlIdtxfJNSDXxsi/kpyEYU7wfIcWXsc77QSP2//11NhJtc2kOFLgcAGt6l3c4e/6OS+qG0ZQ3OyQJNuFzlR6wfzsrKMVsLMjExE0aZ8NPul/1P6gNjliGl9y2+9DJQiF9Km1rf/YAGWGo1V2XVMJ6LM5HjB222sAaW5pzKaVl1ne/5aBj/UF5pHuMs7PK9Yy20Dt+WuXev4N/pFKUdjtQZHOEQ0X7PKunWQ0vT63THzHX3DkXCjCVUcvJqsvZm/Aj0tnfzUTu52uSuSZboYnAjYEDkFL+jlHgCd+qy48IhqxlYCpeGdSgz1bwQzSBur+4tRtLzOVd9At7byIQDQIpql4S7izo7rNEMHJqVfqCi69banihXxZnoXrDZhNxYLeZl+WGSDZx//+QPxLDiI5J3/wNRpR4bfNjiJKvFuoeeSacxRo/XxXEjkAhEvVlw29HL36RQ/sxUsIDeq47g2laTH9uzblzn2Dutz+8qa+qPXM+eGThPlvKbU0qDxa8yE9HNfVzrRyI3vF9cyZmo0ynDFBW1O2q1FJrIagDFPEMrw3X3xMwKQoEO0ydt7Bu3+lLmqTsZSsUF/KdpY2+VEPwRwK3uBox+0iWqGwPU0kQ/w6C+hDbBqe7zd5Fj0BQwzB7rTnhWZoUyOGO93U1rtQyBnd8lZ9/qeQu2PS9wg4WKPYqnwAMsJxqpslrCYzoyJBvu/SgBH9x/C+38W+3Qcs+B2pSIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJ4V1g0RlVOR01kamkrdkhWZmNRaURENEpuZ3lhM0hSTnhGNlcvaTVmZWk0?=
 =?utf-8?B?ME4zR2FvZFhDZk5uaUNsT3RQb1NneWk5RmdrZC9yNTVZQUxVVzNIczR5Zi94?=
 =?utf-8?B?SXM0TVNpOXZ3dEtlZVFES0xVS3N4MjhaMHIrWDZ3LzZ3OUVUQ2xLSk53dUly?=
 =?utf-8?B?cW01VERSR1k0Ni9PZ3dtaEhlWUJHcVJzSE8wRU15YWk2TnpVM3FMRCszMmd0?=
 =?utf-8?B?TDZPT2h0cDBUeUl5dkJSTkZvRVdsSEI1ZFo0RnZNVVVqaUNlcVV3ZnBwb1Fp?=
 =?utf-8?B?ZStRMi9ualFHKzVQZTNXVHlXd2RsT0pUVFcvL0pmQ3JUeGNabDRRZzJDRWVF?=
 =?utf-8?B?UDBWQ2lkOTRjVjMxcEtON2twVmpWeXRZQlZ3Y2VubXRjTGxRMytnMFNSeVJ2?=
 =?utf-8?B?V2RaTGUvNlBKUG1Ta1RyeUU4NFNCdzYxK1IzZ1MwNGRDaElQWGFuWjBPY1dQ?=
 =?utf-8?B?MlEzbTlwaG96NWwyeitDM2FNcm1vNXpmaFFHWEl2ZE0yT1VBa3dBd1lIK2dL?=
 =?utf-8?B?aVNpRmpPL0VqTGxrdTFLZzlJUEk5YlRGU1JLQm4vNWFlVUNackNPYUNRc2ZH?=
 =?utf-8?B?TitVTzdNSFhaa1E2M3hTRFVPZWJQdHRjMFFtWWZWTTNPVVBDSW1hMjZIMHVw?=
 =?utf-8?B?V2xhZm5vRHcwa0F0WG5OZWpYSWVYcnd2SGVFV2thUWMvSGNIeW5ReUdrOThK?=
 =?utf-8?B?QXNHZEtrS1FhRnV0bzhYS0grbGF0bjNWZTl2aUV2Y3NPa0hsMS90V3huRzRw?=
 =?utf-8?B?K2dOTExkNDNsZ29GVVBBdzRkb2JNV3FaSklHVlJCdFVsS2Fia1JkVDl3NjF1?=
 =?utf-8?B?YTB2dWRwSnBYamxwZkRScDlpY1hPZzdOUzNCcWxJNXdJdnRCVUNVa1V3TExL?=
 =?utf-8?B?anBhOGtET1BJZERHaXBCSHBNci85TmFlVEpQU1A0NnJ4dkorYlpnejdUcFhh?=
 =?utf-8?B?Y211Uk5KbWtpQXpPUndHTThOeG5jWmZmdC9BS3ZicGpndU5TOEZmS3VpU2tG?=
 =?utf-8?B?dWRZaEwyZGx6VGpnbkoyM0k5WjIxcnlpUk9uZmZEelZIaFlmTDZhajh6Nzkv?=
 =?utf-8?B?bDhkNzVpN0xYUkJFcU56bzFuNVNJc2JPdnNqR2xKQ0s5bERSNlh2TWthQmN4?=
 =?utf-8?B?cmpXM08yUko1NWQ3SlRqTlRFSlAvSWVINytPYXdaU2pXYWVOOWlzeE9uZ0Fu?=
 =?utf-8?B?NUtOZ3BZaWdTQXozKy9EQ3pPYTFmZlNsZmtrUHlXM1FlOHo5REExZHhjVURU?=
 =?utf-8?B?TEdIN1RZR3hZbFpPUXMyK0s1TWpkQnp3NExNU2Nkc3pqQVc0UDhGUDlkM1RV?=
 =?utf-8?B?blV3Y1NxTzlQUDBGbExobkZWSVZkczRxU0ZKMzN3SDZ3S2VIeWZKZkk0RVRi?=
 =?utf-8?B?WUdOVDdESXcyZFVFa1hvMHl3NlkweldQYW4ycWNzZHEvQndHemgwcUpLaTBD?=
 =?utf-8?B?QmtTSU9IM2EvWnV0enB5dG52YWIxdy85YzFyem95VkxmMkxwL2hyWTY3RXB4?=
 =?utf-8?B?MnZ5N2cvb01EdHhkZ2dBM0JBTWkrSy9teDM1M2FiZjRYWEdQTElOUzZ6aVFU?=
 =?utf-8?B?N2dYWFl4U1AxZ1habHg1WUFXM1BNdzIwS2s4SVVtZlBLWGhCUHJFSmtGcmFE?=
 =?utf-8?B?aFBDam1mWEdiZUpzTW1WZWJpK2V2dlhtYUdYaTArcC9nS3hZemgzbjh3M29R?=
 =?utf-8?B?T3J4VlRyMFA4aUM0NDN3R01VZkRwV2lMY09lem5RMHRlbGttNnJZU2wvdkxn?=
 =?utf-8?B?dVlvZk50enVIWjQwL0h0Qm1zazRqYWR3aEQ5WTdCeEs0OFI2SjNEaDNPUG5J?=
 =?utf-8?B?ME4yOGtTOEJ1S2lZY21MMVBNVlMyOEV5dE1DTXM4VUZ0bVhLTkVKZVJnK2R0?=
 =?utf-8?B?ZktlcHp5bnNYSW5jVnN4amFJMkorbWtoRnlxaVVnQmVkazNVd2hDK1lRNnlO?=
 =?utf-8?B?L21TVGFLVGJ2d0dVNVNmNm9TZjRNTWhNcHJPR1hPeUZnK1B2L3RteEdSM1NV?=
 =?utf-8?B?NEF4MWtjbHpHeG9JZGNnaW5rL2xGNkR4TGFNcnd2WE1uckdYM3VKc2wweUc3?=
 =?utf-8?B?WlRQS0MwQlNSaWw0aFBpQnp3eXVEcGhBL0RSdHE4bkU1WElPbXVGNzVBYzU2?=
 =?utf-8?B?cG1KOFB6a3g0SzZubnAyYmxpTEVtM2FlY2VoZU03dk8yT0M4V3JFL1BaSFVz?=
 =?utf-8?B?WTBDdjBVa0dHQ1dVZnk2R1RPYW53eDZYTmhoYko0cEcxa2FvRFNQWFVhUTd6?=
 =?utf-8?B?QkNyV3A2a3E0a0tzZ1RyUUJPcE90Y0hMMWJSbVdZYnQvTk04RjBsb2M2Q21z?=
 =?utf-8?B?TSsvZlNUZGNCbnBhdlBkUkw0ZFlPblpac2xnV1VCNjJ0TGJ2dlh4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce74a88-b20b-4b97-65a0-08de865305da
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 07:33:47.5919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v35JC54vEBjv++p0vfyQc+osD7anRm7IqjwKSB4lJU+Lua7ueS3HXNOkdwk2zAfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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



On 20-Mar-26 12:09 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> +       smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION;
> 
> wrong ? in smu v11

It is odd, but that is the way how it is defined in 
smu11_driver_if_vangogh.h.
> 
> +       case IP_VERSION(11, 0, 13):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
> +               break;
> +       }

> 
> Please add a default case to handle invalid values, this is required for kernel robustness
> 

It's not required. This - smu_set_funcs() - is the one which is expected 
to take care of the right IP versions. set_ppt_funcs won't be called 
outside of those checks.

> btw,
> if your intention is to replace all check_fw_version callbacks, you might as well remove this entry from pptable_funcs entirely.
> long term, these callbacks are redundant, so a cleanup is necessary.
> 

This can be done in a followup patch. Just retained the callback in case 
there is any special version format requirement.

Thanks,
Lijo

> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, March 20, 2026 14:04
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: [PATCH 1/3] drm/amd/pm: Unify version check in SMUv11
> 
> Use common helper function for firmware version check and logging in
> SMUv11
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  | 14 ----  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  5 +-
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 +++++-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 25 ++++++-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 75 -------------------
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  3 +-
>   7 files changed, 52 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index 7c1701ed3e11..dd94e8a9e218 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -25,18 +25,6 @@
> 
>   #include "amdgpu_smu.h"
> 
> -#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF -#define SMU11_DRIVER_IF_VERSION_ARCT 0x17 -#define SMU11_DRIVER_IF_VERSION_NV10 0x37 -#define SMU11_DRIVER_IF_VERSION_NV12 0x38 -#define SMU11_DRIVER_IF_VERSION_NV14 0x38 -#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x40 -#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE -#define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03 -#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF -#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0xD -#define SMU11_DRIVER_IF_VERSION_Cyan_Skillfish 0x8
> -
>   /* MP Apertures */
>   #define MP0_Public                     0x03800000
>   #define MP0_SRAM                       0x03900000
> @@ -148,8 +136,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
> 
>   int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
> 
> -int smu_v11_0_check_fw_version(struct smu_context *smu);
> -
>   int smu_v11_0_set_driver_table_location(struct smu_context *smu);
> 
>   int smu_v11_0_set_tool_table_location(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 0c4afd1e1aab..d73c3c191e9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -65,6 +65,8 @@
>   #define SMU_FEATURES_HIGH_MASK       0xFFFFFFFF00000000
>   #define SMU_FEATURES_HIGH_SHIFT      32
> 
> +#define SMU11_DRIVER_IF_VERSION_ARCT 0x17
> +
>   static const struct smu_feature_bits arcturus_dpm_features = {
>          .bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
>                    SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
> @@ -1906,7 +1908,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>          /* pptable related */
>          .setup_pptable = arcturus_setup_pptable,
>          .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .check_fw_version = smu_v11_0_check_fw_version,
> +       .check_fw_version = smu_cmn_check_fw_version,
>          .write_pptable = smu_cmn_write_pptable,
>          .set_driver_table_location = smu_v11_0_set_driver_table_location,
>          .set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -1959,5 +1961,6 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
>          smu->table_map = arcturus_table_map;
>          smu->pwr_src_map = arcturus_pwr_src_map;
>          smu->workload_map = arcturus_workload_map;
> +       smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
>          smu_v11_0_init_msg_ctl(smu, arcturus_message_map);  } diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 87953a4d0a43..1cc26cc79454 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -582,7 +582,7 @@ cyan_skillfish_get_enabled_mask(struct smu_context *smu,  static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
> 
>          .check_fw_status = smu_v11_0_check_fw_status,
> -       .check_fw_version = smu_v11_0_check_fw_version,
> +       .check_fw_version = smu_cmn_check_fw_version,
>          .init_power = smu_v11_0_init_power,
>          .fini_power = smu_v11_0_fini_power,
>          .init_smc_tables = cyan_skillfish_init_smc_tables, @@ -605,5 +605,6 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
>          smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
>          smu->table_map = cyan_skillfish_table_map;
>          smu->is_apu = true;
> +       smu->smc_driver_if_version = MP1_DRIVER_IF_VERSION;
>          smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);  } diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 737bfdfb814c..f2ce8de58cb9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -73,6 +73,10 @@ static const struct smu_feature_bits navi10_dpm_features = {
> 
>   #define SMU_11_0_GFX_BUSY_THRESHOLD 15
> 
> +#define SMU11_DRIVER_IF_VERSION_NV10  0x37 #define
> +SMU11_DRIVER_IF_VERSION_NV12  0x38 #define SMU11_DRIVER_IF_VERSION_NV14
> +0x38
> +
>   static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>          MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
>          MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
> @@ -3310,7 +3314,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>          .check_fw_status = smu_v11_0_check_fw_status,
>          .setup_pptable = navi10_setup_pptable,
>          .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .check_fw_version = smu_v11_0_check_fw_version,
> +       .check_fw_version = smu_cmn_check_fw_version,
>          .write_pptable = smu_cmn_write_pptable,
>          .set_driver_table_location = smu_v11_0_set_driver_table_location,
>          .set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -3363,11 +3367,26 @@ static const struct pptable_funcs navi10_ppt_funcs = {
> 
>   void navi10_set_ppt_funcs(struct smu_context *smu)  {
> +       struct amdgpu_device *adev = smu->adev;
> +
>          smu->ppt_funcs = &navi10_ppt_funcs;
>          smu->clock_map = navi10_clk_map;
>          smu->feature_map = navi10_feature_mask_map;
>          smu->table_map = navi10_table_map;
>          smu->pwr_src_map = navi10_pwr_src_map;
>          smu->workload_map = navi10_workload_map;
> +
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(11, 0, 0):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
> +               break;
> +       case IP_VERSION(11, 0, 9):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
> +               break;
> +       case IP_VERSION(11, 0, 5):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
> +               break;
> +       }
> +
>          smu_v11_0_init_msg_ctl(smu, navi10_message_map);  } diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 6268bc5ed3e6..68255cfcb04d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3120,7 +3120,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>          .check_fw_status = smu_v11_0_check_fw_status,
>          .setup_pptable = sienna_cichlid_setup_pptable,
>          .get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> -       .check_fw_version = smu_v11_0_check_fw_version,
> +       .check_fw_version = smu_cmn_check_fw_version,
>          .write_pptable = smu_cmn_write_pptable,
>          .set_driver_table_location = smu_v11_0_set_driver_table_location,
>          .set_tool_table_location = smu_v11_0_set_tool_table_location,
> @@ -3177,13 +3177,36 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>          .mode2_reset = sienna_cichlid_mode2_reset,  };
> 
> +#define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid  0x40
> +#define SMU11_DRIVER_IF_VERSION_Navy_Flounder   0xE
> +#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF
> +#define SMU11_DRIVER_IF_VERSION_Beige_Goby      0xD
> +
>   void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)  {
> +       struct amdgpu_device *adev = smu->adev;
> +
>          smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
>          smu->clock_map = sienna_cichlid_clk_map;
>          smu->feature_map = sienna_cichlid_feature_mask_map;
>          smu->table_map = sienna_cichlid_table_map;
>          smu->pwr_src_map = sienna_cichlid_pwr_src_map;
>          smu->workload_map = sienna_cichlid_workload_map;
> +
> +       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> +       case IP_VERSION(11, 0, 7):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
> +               break;
> +       case IP_VERSION(11, 0, 11):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
> +               break;
> +       case IP_VERSION(11, 0, 12):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
> +               break;
> +       case IP_VERSION(11, 0, 13):
> +               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
> +               break;
> +       }
> +
>          smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);  } diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 1eec1a88e05f..98e7109bbc95 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -192,81 +192,6 @@ int smu_v11_0_check_fw_status(struct smu_context *smu)
>          return -EIO;
>   }
> 
> -int smu_v11_0_check_fw_version(struct smu_context *smu) -{
> -       struct amdgpu_device *adev = smu->adev;
> -       uint32_t if_version = 0xff, smu_version = 0xff;
> -       uint8_t smu_program, smu_major, smu_minor, smu_debug;
> -       int ret = 0;
> -
> -       ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
> -       if (ret)
> -               return ret;
> -
> -       smu_program = (smu_version >> 24) & 0xff;
> -       smu_major = (smu_version >> 16) & 0xff;
> -       smu_minor = (smu_version >> 8) & 0xff;
> -       smu_debug = (smu_version >> 0) & 0xff;
> -       if (smu->is_apu)
> -               adev->pm.fw_version = smu_version;
> -
> -       switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
> -       case IP_VERSION(11, 0, 0):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV10;
> -               break;
> -       case IP_VERSION(11, 0, 9):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV12;
> -               break;
> -       case IP_VERSION(11, 0, 5):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_NV14;
> -               break;
> -       case IP_VERSION(11, 0, 7):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
> -               break;
> -       case IP_VERSION(11, 0, 11):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
> -               break;
> -       case IP_VERSION(11, 5, 0):
> -       case IP_VERSION(11, 5, 2):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
> -               break;
> -       case IP_VERSION(11, 0, 12):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
> -               break;
> -       case IP_VERSION(11, 0, 13):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Beige_Goby;
> -               break;
> -       case IP_VERSION(11, 0, 8):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
> -               break;
> -       case IP_VERSION(11, 0, 2):
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
> -               break;
> -       default:
> -               dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
> -                       amdgpu_ip_version(adev, MP1_HWIP, 0));
> -               smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
> -               break;
> -       }
> -
> -       /*
> -        * 1. if_version mismatch is not critical as our fw is designed
> -        * to be backward compatible.
> -        * 2. New fw usually brings some optimizations. But that's visible
> -        * only on the paired driver.
> -        * Considering above, we just leave user a verbal message instead
> -        * of halt driver loading.
> -        */
> -       if (if_version != smu->smc_driver_if_version) {
> -               dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> -                       "smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
> -                       smu->smc_driver_if_version, if_version,
> -                       smu_program, smu_version, smu_major, smu_minor, smu_debug);
> -       }
> -
> -       return ret;
> -}
> -
>   static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)  {
>          struct amdgpu_device *adev = smu->adev; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 08179840697e..0349c73eb000 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2512,7 +2512,7 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr  static const struct pptable_funcs vangogh_ppt_funcs = {
> 
>          .check_fw_status = smu_v11_0_check_fw_status,
> -       .check_fw_version = smu_v11_0_check_fw_version,
> +       .check_fw_version = smu_cmn_check_fw_version,
>          .init_smc_tables = vangogh_init_smc_tables,
>          .fini_smc_tables = smu_v11_0_fini_smc_tables,
>          .init_power = smu_v11_0_init_power,
> @@ -2562,5 +2562,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>          smu->table_map = vangogh_table_map;
>          smu->workload_map = vangogh_workload_map;
>          smu->is_apu = true;
> +       smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION;
>          smu_v11_0_init_msg_ctl(smu, vangogh_message_map);  }
> --
> 2.49.0
> 

