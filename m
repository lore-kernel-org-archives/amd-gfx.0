Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60A3C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 22:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F05310FFFF;
	Fri, 26 Apr 2024 22:44:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUPtSOmB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B2810FFFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 22:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxQb/9JNtPLvRHyCLNlUI4Svs1j8rRGQwuuHxawtUzUmLOX7TAQTFyisY6z43wfD/bb8ueeeziah1aOVoeTR0AbHI8f7rnNZghgwZ4PKJAxMcmSG21XBigzPhWc8JHFD63tBF4o8npPDSc2txpHrggyXYJfQySN7TkyPpjbdRhdawbrAe+IHmt4JYZhL0E883LDhaWKr8jq0EimuJfM+uicu+Y4INH2UiOvyDPiPJFodMYghZI3xZJZCIodztS3M4S7tY8sCF8A7RZ6oJzOBxZ7WgLN7X1cgtqAh+jhu2QKRspbnwxRYhQ9GKQsa4TUb7XTHg1rRXo+/yDvjg/3Vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qlqyh89Irm961aALgl5p4jINbae3sFnNJWPiG2/o2o=;
 b=SJsNBdoomqxDrVtcpGFamNb0PElCNw6+8FoaLJZT3z5U2ut98Z4C1GLh7r62BPxA4VaAFx+5orG038WYo4TGdDJFwduzEtfRAvtAREEezpvaSZw8a5/f6VAOHvi9cCuaxKE7XACNlCBnOtL+jWOb7Wqou2l1YS3R+QcnNsvlHX94eJ+ySwgSAfXfwPfO6zJxR0mHXUURCuJiFK79f3J8Y17Mo6yL+ievCoxzr3qP0bQVtZl26Ewlt2bl2BBpZ9KS5zOZjmEMVNAvjNUiwP9//OeVbG4MOXaOk68p9Icj+yEPVDVk1h5HMWgtyO2aym4n5I9Jbi8ePdKBoRAAkkl2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qlqyh89Irm961aALgl5p4jINbae3sFnNJWPiG2/o2o=;
 b=hUPtSOmByyBJNEA0yqBOjUyQBo6+JNX2OTtN1P7hxzlMIIpo3rm8wcWnLIgDFo0lo/xYEh/U0qLp12ZD5RpXuufblA/fWaSYT26XE35UeaSfxvzARNrnwvFmYBin3HawcePejPZ2OejHzkFMxUnmLO1Yuf5GUTXed5B202QpyA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 22:44:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 22:44:47 +0000
Message-ID: <53f958ca-3422-4ee8-9d07-228156d984bc@amd.com>
Date: Fri, 26 Apr 2024 18:44:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Allow memory oversubscription on small
 APUs
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Aaron Liu <aaron.liu@amd.com>
References: <20240426083750.485808-1-Lang.Yu@amd.com>
 <20240426083750.485808-2-Lang.Yu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240426083750.485808-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 81120e07-e49b-411b-fd0b-08dc664279d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJLK2JkMjhQRTh2UG55MzhNZjNhcHc0ZHdwWmRoblQ4RW5sSmw2TUV3Wnhv?=
 =?utf-8?B?THM0VS9VclA1bTlEeFZwTjhwV0Q2K1B3V0tsdHUxcUFENXZ4SUpnWHF3elU4?=
 =?utf-8?B?TVZFWForMjd6cGJuOGlERUpkRmViVG1VZ1M4WDBINUZuUDZtelR6M0t4bktM?=
 =?utf-8?B?VGhNdFhYdDMvKzBJRENqTFA2dkpHUVFXOHd2L0pXazZQNXh3dzBwdkduWENR?=
 =?utf-8?B?dkFncmd3MFNjL015QTJTWmlRNk5xTE1aQjNkTHVrcE02RWtpWVZSMWZoaG5N?=
 =?utf-8?B?Ynk5MSs1d1RCZ3NwWlpVMU1PNzNzRlJHblo1TE5YQlF4clFMTXNtaFB3MmhW?=
 =?utf-8?B?Y3ROYzkxbXFSL3A2c0lneUxlbGN3b2hMVkwzUTZYWWxnVjgzcndTSHgyN3RT?=
 =?utf-8?B?STFXbUpwTjV6OFAxMk8vUFF6Unp3RTNONjl6V3hGM2tFM3FCbUNKalA3SENW?=
 =?utf-8?B?cGxsajhHVlBMNzE1RjR1anNRaSsrMjM4SnNhTmZLditzcWo4ckQwMHBsZWJZ?=
 =?utf-8?B?Z2tSSGxlNDdtZ3M1Z3E4bW94ajgveG1wUTIzVEVYNkJTa0h1bHhEVDlJc0pR?=
 =?utf-8?B?bVA1S0tBZGRKUHBwUStKSUFCWTY5cWdzN01jdkpsSk00aG5WMjRUUkVld2pX?=
 =?utf-8?B?Zy8yNEFWbm5SU3NJc0NybHZiUExHc2JzSWp5WXNUWDFQM3l2WTNVeHNWNXIx?=
 =?utf-8?B?cE0wRkdpRjVkdDNQZWMvN2dOc1NhYzk1YW54Nmg3Vi92VFlLWGFXaEgwZVVZ?=
 =?utf-8?B?WWNyR3NDR3BFbDlrWExEcStmc0FWQjQyd1ozdzNldkdINThKUXl1SUVFbTVZ?=
 =?utf-8?B?QnNaNmErMThIbUszdmZlOGM0N0s1K2E4dTg2RUhLYjRrVmxrN040M2t2MlVv?=
 =?utf-8?B?MlF2NlQ3T25saXdtSmxvMjVpWi9ibmZUYnpQNjV2bDBSeWRMdnhLTEVCaE90?=
 =?utf-8?B?bDlDR0tBSXE4SjVLUnpYb2JqVUhpYnlhNUlBbllmYmkyOFhDRncvYjV1clJE?=
 =?utf-8?B?VUorRXY3cGVGdERxYnM5S0lLQk5ldEFDV0ZnR0NobUoxK0dSQ3VIOGhWL0Qx?=
 =?utf-8?B?d3hEVXh2S3BUYmRkbS9MMlVwRG1hZEM5aTJoeUR4NkpMbVN1c3NvTm9qZTR4?=
 =?utf-8?B?M251NTJyQ0ROK2JPbHdIZFhyQU11UUU0em9lNytzSlBxRnhMejk5MEtndlhG?=
 =?utf-8?B?M0wyTVZHRngwbFp4OVcyTkJvT3NkcGZkbHJPMzN4QVEvd1NMUnV6SklWeURt?=
 =?utf-8?B?bitWTGQwcU1LaHFOSWdmbWl4MEU3UXArcE5BYUo4Z3lRL0JCSkpmcldyek0r?=
 =?utf-8?B?c1podXh4L3V6YmpwcEZMbStMbU9IYkNwcHJ3WkRwMnQ4ajBxaFhrdE5EbElI?=
 =?utf-8?B?elhUa1BJQ0VkNUpWemx3Ukc0SkZaUnRaMGpKN2xMK3RHak52U2V0b0lOUUpX?=
 =?utf-8?B?bDhid1AyUVFPajRTaUdFbENSc2lsNDRndTFhZjkwYXRUeUN4RWQreVI2eTVG?=
 =?utf-8?B?bXFRZHl5T1hwK2J5VDRkbXFlTDRCdW9CayttcDFMenVkMGJKRFM5Y09TbExi?=
 =?utf-8?B?NXFFYlNjNy8yc05aZ1c2TVVpQWp1ZjFwN1U4QjlwNENkZEpkKzF5SEhOQS81?=
 =?utf-8?B?VW95QWxJeDV4cFg0ak40L3k2M20vYW5DR3duRGNMSGQ2VmdsSHNYQ1JHNlZK?=
 =?utf-8?B?RU13WnVxTG1JRmFCdTkrN284dTZ6K051T1hUM3p5SGtkdnJING81WHlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JQSG9VL0lUSC9jMlBKWEhlNzhPL0RrL0ZnTEU1SXUxU2xGQlJYUTUrNUZs?=
 =?utf-8?B?WFhIYkMvRFI2R3lPUFgwZm94clhZWlAvdUJZTnd0MkJIbVViSHVUR2NyeWRS?=
 =?utf-8?B?VVdOQzlHVHAzWCtjb25TZDNvY1o3cDdDZWR6eDltcmE0UkZpY0lmb053ZEkx?=
 =?utf-8?B?SDQzRXZLWUh0MHRHeU9BVkFzVnltcU9iS2JoUkkvVjkyeERBM3BEdnRTVnF5?=
 =?utf-8?B?MlZSbVVCSWxVQmM2SW1aOEZYMkdmVGZUd1ZQY3B4eFZ1aCtiNUpZK25JT0ti?=
 =?utf-8?B?WFdBQ3hkdzRIdFZEYWtSR2cxQXdXVEtNcDV6MG1YbXdOZEl4Rkk4eWJYSkFl?=
 =?utf-8?B?RitzOC9ONzVITkVMMFppbTFLcVExbDArZnhIdlBOcmdpUmwrcjQ2U3BPUUQx?=
 =?utf-8?B?MU01OEt2MkQwcStWWlVSS3p6WFB3ODhkeWVUSlU4cnlSMmcrODg3QkZwZ28w?=
 =?utf-8?B?TFlNMkswNzVGZWZDWUVnVmRTT2swMlFNTmpWUlEvWVRHWWhRQUNqN2hIRkph?=
 =?utf-8?B?TUJtMlR2Qkwvd05jZ3RrWGV0Rno5dnJPTUVxMEZYY0Q4Mk84NktFcURCRTky?=
 =?utf-8?B?NUlRZ1R4Um1FZkZZb3k4Z0Foc1Zuc3pLOWdSbkgxK0hJQ3ZIYXpMdWVIOGpG?=
 =?utf-8?B?OE4ralZYb3R0ZlJ2a3MxejZiRUZXazYzRlp6Rmh4RFBoek51TmJGVEtUNUli?=
 =?utf-8?B?bjYzdjZ5OER4S3RFWUprVnNMMEJWVjhHc1ltcU1KY3Vlajl1YTkzQzVCNlp0?=
 =?utf-8?B?UXpJcFh3Y3BCYzVKMGVsZ1hNQktUSWdSWE45bzhCcXMvV3E0clBHZXMweWJ4?=
 =?utf-8?B?Vnp6dmIxU3lKWEVOaXJ1UmtRU1A4Wk5aZzdtZDJObzNjeFU5emFIaUxGR0tN?=
 =?utf-8?B?bFhPQnJocWREYU5FNWMzSnJvNkRTaThKL1dqaUoxdU5oL1loWjZPNmRWcnNp?=
 =?utf-8?B?THliTlA2cjYwOVo4RW9Mdkd1bkdqVXlhcUFDV01QTk5pUUR4VEFoSklNcWJ4?=
 =?utf-8?B?U1hpSmtOVWNCa0JVQTFLKzV1cEF1cWVsNzBSWUJmVU9LV3lQT0szbFYvcTFk?=
 =?utf-8?B?bzVwUzNlZHpUOHNCa096U0RvVUVWNi9YUjNXbkNoSTZ5VUdvY21vS1A3T3Zz?=
 =?utf-8?B?NUw0blBwa2o2em4zQ3g5cTB1MVFOZUtvTDZlOExSc24vOGg2QVhidzM1Nkh0?=
 =?utf-8?B?NXVwd0w0cVBtRU0yWVN5UTg5dndKeGt2QzVqczUrbml6Q2VKazhldHh3a3Jr?=
 =?utf-8?B?RXdOY0o5REJXdmJObjdCdkFJNkRSRnR4Y2UvUW96NnVnSDNSdW1ZVjg2emg0?=
 =?utf-8?B?eHl5YzVMRzdScG5FcFhFTjBZOVdPZ202Nlo1T1RlTmY1aWFTSEorQWozdGFy?=
 =?utf-8?B?OVdBTnQ1WkxJekpYREN6d2ZmdkpFVmM4Ukg4RytkNXFpWkhMYWV6dmowM1l0?=
 =?utf-8?B?RFptdGJSY0dXM2Y0QjVhcVFTNUZ1LzVvY1hkYXB5QzRaUkVqZW81UzNlTWR4?=
 =?utf-8?B?S2JYTG5CMHFUbUpBY1RyYnNOOUlRWW5IaElUdlFDa2xxQkYxRGR3N05VUi9l?=
 =?utf-8?B?SFRKd2ZST1VWNkVWSFZTLzFaTXRhUnh0QVRqQUhqSHdLTW1ka2srWWxlaVZN?=
 =?utf-8?B?M1FlWGtEZHRTSFhlSUdRNTlMQVlwSkRrVFZBTE9QRTk0RTI2UFZRcFRKNGcw?=
 =?utf-8?B?ampqWVk3MnYvNjZEWlFRbTZkMWUzVi9PMXQyU0U3ajlGQy9WZVVtam5GZ2lO?=
 =?utf-8?B?M1BnR29vU2t4bFBHUlZIWEZJcWdjVUNwbDBSUUJnSWJvYlNDVWpoRkpzTFFL?=
 =?utf-8?B?bGNZTTNyOGZJYzdHcXI1WWRmMDdwdzA2cG12ZndzVm16ZVluWGdtM2Z0NkdI?=
 =?utf-8?B?Y2VOdGZYN1k1eGhRcVBqN2ZlV2MzU0RjL1hYYkxJZC91YTFNS3YzdFQ5dE12?=
 =?utf-8?B?eTh0U1o3WjJYYU1oanR5RnRpTzNuc2NzcW1UZWhUak1HejdEZDIxT2tiOVBU?=
 =?utf-8?B?NTdyTGlMK202bWtvK2dFTW96V2NnSmJQRndXUFFPczY0RVRaUDdESDNGUDNQ?=
 =?utf-8?B?TDQwbytGdGJsMlo0NHhxZUs3Wm5Eb3RiVkxIQmh5K21aREw5bWp5RnVlM0dT?=
 =?utf-8?Q?XLSErHzj3x8bvk2vZZXL0FxEn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81120e07-e49b-411b-fd0b-08dc664279d1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 22:44:47.8553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87W5WNkablM5zx87ORkFF2KGepUnFrsp7QnMOKSiym+X7q9wRNKE1UPlQXW0RzqFrcApyKtAnbsCarZyYLMvNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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

On 2024-04-26 04:37, Lang Yu wrote:
> The default ttm_tt_pages_limit is 1/2 of system memory.
> It is prone to out of memory with such a configuration.
Indiscriminately allowing the violation of all memory limits is not a 
good solution. It will lead to poor performance once you actually reach 
ttm_pages_limit and TTM starts swapping out BOs.

Regards,
   Felix


>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++++++++---
>   3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 3295838e9a1d..c01c6f3ab562 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -167,7 +167,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>   	int i;
>   	int last_valid_bit;
>   
> -	amdgpu_amdkfd_gpuvm_init_mem_limits();
> +	amdgpu_amdkfd_gpuvm_init_mem_limits(adev);
>   
>   	if (adev->kfd.dev) {
>   		struct kgd2kfd_shared_resources gpu_resources = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 1de021ebdd46..13284dbd8c58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -363,7 +363,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
>   
>   
>   #if IS_ENABLED(CONFIG_HSA_AMD)
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev);
>   void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>   				struct amdgpu_vm *vm);
>   
> @@ -376,7 +376,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>   void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>   #else
>   static inline
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev)
>   {
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7eb5afcc4895..a3e623a320b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -60,6 +60,7 @@ static struct {
>   	int64_t system_mem_used;
>   	int64_t ttm_mem_used;
>   	spinlock_t mem_limit_lock;
> +	bool alow_oversubscribe;
>   } kfd_mem_limit;
>   
>   static const char * const domain_bit_to_string[] = {
> @@ -110,7 +111,7 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>    *  System (TTM + userptr) memory - 15/16th System RAM
>    *  TTM memory - 3/8th System RAM
>    */
> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
> +void amdgpu_amdkfd_gpuvm_init_mem_limits(struct amdgpu_device *adev)
>   {
>   	struct sysinfo si;
>   	uint64_t mem;
> @@ -130,6 +131,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
>   
>   	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
> +	kfd_mem_limit.alow_oversubscribe = !!(adev->flags & AMD_IS_APU);
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),
>   		(kfd_mem_limit.max_ttm_mem_limit >> 20));
> @@ -221,8 +223,12 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   	     kfd_mem_limit.max_ttm_mem_limit) ||
>   	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
>   	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
> -		ret = -ENOMEM;
> -		goto release;
> +		if (kfd_mem_limit.alow_oversubscribe) {
> +			pr_warn_ratelimited("Memory is getting oversubscried.\n");
> +		} else {
> +			ret = -ENOMEM;
> +			goto release;
> +		}
>   	}
>   
>   	/* Update memory accounting by decreasing available system
