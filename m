Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A7C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 22:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708C810E5B4;
	Thu, 30 May 2024 22:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RY60dXrY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453A110E5B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 22:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH1VrBkQHT3tIGQs6KUa7OJJbT/m5oVwT8vbw4wZOP2gg2pqe1GUQjf7AKhiIcw8iNaIDBtV7zuiHTm+5kLiW9/2XZf+mem8e3i43oHjptw6ibgzLjRwupM+80ZQbTY3re4B9M9TOj1BwNw+pqqyofOSviaPZhLd2laJvEU7+mT6l1/smnkGoT/sbBYYgGy/a9KSNRr3eCPacuvhRka7RiDqIsb5j+FT8dl5EpanlSSslk6be68vkAzSZvBTvQ1SJcMl04yNwU/1rzv+1NqhxaF1mR6/Q6cTkMRzW7Pz2WzSe2F4KWh7r007QjjnAd0s2RdPKb8SvPVp42bpolimVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlLBxaS0rG77G3cninhqwTCnfx8lG0n5FSA3yLjN7sU=;
 b=Vxz6scMqIwrxTClc5a0uiSJBzh0HrQCVXdEZgTEl8RG/ztw/m6gtqdbBN1EvAORDlEnH1maBOvlMVD1UYT0qaGxH2H+2oWEZ5ObdvHBa90V0UyBP4O+szzOzO/jT8jgzaSgCadHQRhU1V4xa1Il6JCSodPxVFlmA+XpQdzrFxAP+TsGcxiJLeShNJqvsjNd0y2AFmSiBU8OGYw/1jtRTPoegsLkKVf4trEaqvSoZ5yPrkUH6KK/n5o+4kGCmSsNW1LMWTbC1BQ9oYNh8spPBH4KJx7T3gKHwNfJjEFWg4Vf2169iYnNbOd3GftSJ70b99xeLjVEqJLfMqGugD4WEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlLBxaS0rG77G3cninhqwTCnfx8lG0n5FSA3yLjN7sU=;
 b=RY60dXrYbTv4h4LMTxdoP6aiSXECM63Qw9sIEDUQXWn18ue+CmPz4ERzLYodQSTXMgaE+y/9qQQyAoc5asMnjz+6G/a0zrOQQV8J4Wu8hZKpbMw533Mg1h0mIDQRvke6ZxPsv/hkUkwci1598WzbiEncPhhHYBVEce3QUjR3SxY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 22:02:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 22:02:05 +0000
Message-ID: <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
Date: Thu, 30 May 2024 18:02:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com, Likun.Gao@amd.com,
 Hawking.Zhang@amd.com
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240528172340.34517-10-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0347.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c20aef-000b-4fb7-3b5b-08dc80f42499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0x1VEZrbEIvaG1HQnpHczhBeFJQM0NHZjN5VC9zWkptZVlhSEk4b1pJUnBD?=
 =?utf-8?B?cGU0OERHSnNtQnNxK1NnR0E0aTdaQmppM09SVUtwYTJweFVtTzVweVlabS9B?=
 =?utf-8?B?N1NnZGRxeVl6aGVBK1ZGaGJyTTRYU1pBUUcrRXJyUXFlc1cwb1B6ZmFBSWlU?=
 =?utf-8?B?cjV3S3JIaTdUVnJGVTNQelpHS0tnOXRuMHVWQ3p5MjdTMDJrbzNCcDArR2ZN?=
 =?utf-8?B?ODloRzQ4UUpmT1BUYVFOUFZ4VlZhQWRTNHpIb1JEMENFUTZPOGRaam5xa25L?=
 =?utf-8?B?Z0tOSklDWnNJOVB3ZVkzVHEwdUpPTFlOR2o1MzBSK0RvbVNzaUw5MVdtY1dD?=
 =?utf-8?B?VElmV3FYVFFGYzlOeXI0dGl6c3NVZlloK2FLV1k0b01BK2RoYUtXSDVhcjBL?=
 =?utf-8?B?NGlXakFGOEhOMWJkZUN2S2RmVERlUjROTkpXa0UzRlE5N1l3NkNtMldKUyty?=
 =?utf-8?B?bHlnbVRZT2JuK3oyUjJlTjdFMlVwK1N2aytMZHNDZkhmYlJiYnh2aFVKYUxV?=
 =?utf-8?B?aEM4eDYyUmlFcDFBWmViMFZrQVhGeGcwQWt1YXBLTVhIbEM2TW92M2YxL28w?=
 =?utf-8?B?OGhTSENLbU1ZNmxFYTZudnpseklPYVh4clR2dVdncG5EbHZ3Ui80Wm9US0Zr?=
 =?utf-8?B?TWd6VXo4VkJkdGlETEJ0Ynp5K2JHd2trN1Q3cWtQYjRNb3VmUDQ3bExGRDBN?=
 =?utf-8?B?c0JpRXJmQXlNWXFTY3MvV3JwbHVEdHFXampwSWYvOGt1ekxkVTVmS2sxeWd4?=
 =?utf-8?B?SlNGcmd0L01aU2hQeXdHMnZjMVVyY2ZyVGxLZUxNTllXTm1nM3pxR1ZDSzR0?=
 =?utf-8?B?U0ExUnZoa3VDSmVzSmRtcU4rYy9vOGdVWEtXZk4vMW51OWFPRUlNeml2dGFh?=
 =?utf-8?B?OENXN2FHMnVpRmZNRzh6dzQ3QVlYOFJ1SnFDZDIyOVRUNkVKcmt1UFBTd3U5?=
 =?utf-8?B?RWxES2owU2hldHU4Q3dlL0lNcnk1S3NTb0JpYkkzaGFxd2J2dlVPa1EvNmFu?=
 =?utf-8?B?bWsvR1hvc3orWHNuQkQ0ME1idmVEZ0tlamxaVnpONENIMSs3d2EvcmkydTdM?=
 =?utf-8?B?S1JuVzZMekpPR1JwUjIwd0I3bklCZ1Btckk4VEt6ZGdXSFY0dEZtS2QxTWJl?=
 =?utf-8?B?bW5qNTV6OG8zaUZPcm85Vk9XWDZGVDY4SklnVkk1WTNJSHNEbC9VVUlSVW5p?=
 =?utf-8?B?NmxFSEZuUkFwSE5jTzFoeDdXOEgyMHFqNytkZThzYWIyMDd0WWMzWGRDYnVp?=
 =?utf-8?B?UURIbUpUS0JsUXFjZlM0NElBUklKakxBM3I3a1B6Z2h0U3dkejRwZ2NYeDVt?=
 =?utf-8?B?L2RIc2dIVUt1NndLaEh3cXpabnF1T2dvb2R1R1k0MDBwTllCR2dISTI0WllX?=
 =?utf-8?B?bEtFQzA4TVQ5dGlqUlJRb0V5K3lzN1NqQklzVTJOK2Z5RXZtNW5Ybmc5T3Mz?=
 =?utf-8?B?dGIyZDZEQ2R4Ukl4T2F6V2VqOTZNRU9vK3lxM1lxdWVOY1d1dTdmTktVdEY4?=
 =?utf-8?B?VDg5L1AycGk4bnRXUGg0STM1Z2kzWHgyZXpVZGhMOFRHOW55VVRwSlIyS0RG?=
 =?utf-8?B?Q1k3c0hFbVMyUVpZWjlhcTdUTk10NEthcklWcjBrSGEyTUZrMTA0QzFqcnp5?=
 =?utf-8?B?bnVwZUdEN2tpUnJqMVFiQlVyM2o0a0g0MDd0RGpGSmQray83T3pBZjRqYkVv?=
 =?utf-8?B?L1BRVEV1V1JQS0ZtQ1VTNUU1N256ZUZWN1FqaVF2NmxxeUhYSE5XWlZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NUWHVyN2ovdlJodWp3bytIZlU0Tm1YOUVDVkI5eXB2N1ZEVG91N3JMeDlL?=
 =?utf-8?B?RTVKZGRHQ05ERjRIeHNhdmp6ckFyL3k3dCtBWmEwNllLSEtTaXZ2dTQyRlV3?=
 =?utf-8?B?cjR6TzZlWDJBOENNVjVobU1iZjJBK3VNRG9OdytJbjE3RU5saUdObFdqZFYv?=
 =?utf-8?B?MWtZSkgvRkEvRGZQNDEwUGhnajdLKzZRZW4wcWoxUURSMEU2UFZLRlRPTmsv?=
 =?utf-8?B?QkFQRm1ERk8xUzl1dzVCd2h0c2hKZ0hNWXdSRXdIVTQrbEVtSUhHaHR4RzY0?=
 =?utf-8?B?NXVyZndoUm5PSlRrcUh1VVJ0L1pwWGkxc1JBUDh3UEJUMC94NDlhWnBkbzJU?=
 =?utf-8?B?NXFjZFQrdTdiTnZBdm80NkhHYksycWEyWFNpZXR3M0xhd3NVN1FvY3IralpU?=
 =?utf-8?B?T252dG1pRTFnMTVXVFZxbUpLZmRFK0JZTVlzUXdOak9mZHVvRDA4bnpFUWJQ?=
 =?utf-8?B?Tkkxalh5bkd5QkVxbXNFSUZBZXlDSXFrUndDOUovdDVJMUxlTjdGNUdRQndi?=
 =?utf-8?B?bDMrUExpODNyN3BlRVdvbEJEWFpFK1UrRERkd2xxeGJuT041aHVGQ3NwZWIx?=
 =?utf-8?B?QUE3bTJ0R2VQemtNL1NPV1M2RDZGWEFRbUNteWhzS0pDVnVBMkk2czFWQUZC?=
 =?utf-8?B?TlFIcWo4dXVQOWZScVpmV0E4RHdZRFN5MGRGZzBnTGpDbFlIUWpkOXJBOUw2?=
 =?utf-8?B?ZmNpaUNVYjl2aUtRVXJVNTlzNnZKM3JyWk9IQXBoWSthOEZuY3o4UTd0Ty9L?=
 =?utf-8?B?SElBZUMzRzBoWkZPclF0K2tBRDRxdGhhK2F6YURaVWlBaTJxZGIvemoyNFFq?=
 =?utf-8?B?Y05kQkZLQm84U3poVjkxMTZEYThGa2VMUEpIK3NJV21yV1hCSGFVSTJzOUY3?=
 =?utf-8?B?TDNRZW5BVlNEaUM2R3ExaUNCZEd5bWI3L3VVM2VFUm1tYlo0NEQzaDA2WVFX?=
 =?utf-8?B?M0o1TGUwOC85Q3dRb3FxTzY1UXhyQkUzdDVOdXlMM3RVYW9WMHhITGE5TDNy?=
 =?utf-8?B?elVkNG5mVUMxYUxWSzlNN0owTytHenY2RksxTFNDUUppZExhaVBJZjJ2ZTFI?=
 =?utf-8?B?ZVpaNm9CaDcwTWl3WmRRemlFWjJNRDNud2xCVUdRcytIWmorVDZVS1AwUEtu?=
 =?utf-8?B?WnlzTEdwUjBheE5XRjVrT29qd25CZEEzZXBDUXNDbmtLNGRJM2tyenBUSXpX?=
 =?utf-8?B?ck15eS80NzRMK01lNmh3QVVuZVI0R3Q2OXJuMTFUcndNRmQreU5MK3FFbkNG?=
 =?utf-8?B?UmVBU0FucXdXQUVVZkpSanlaS2lUeXdPMTFIZFRIVGVUeG9VSzF2NG12eGZS?=
 =?utf-8?B?WFliM2lZd3Z6b0libC91dFZHR2tTd0ZaMWNNeUxmZ3UrdDhpYnlhMUJlNFVS?=
 =?utf-8?B?L0h2QTJ1MWQxaTJMRlFLV3pMVlhldVpHS3FhNU4vQWxoQ3U4TGdHQ1JIVFI1?=
 =?utf-8?B?dEJtSTVDVG05ZG5NRzhWZzJhbDlYZUYrbStsYXFJQW5GZDN5TngvdVJXRUFZ?=
 =?utf-8?B?dnA1dlp3WkNUVE05ZTdDTjlsTXdsMXpRaTZaRzNlUkVadTdBMVBIWnN0TWZi?=
 =?utf-8?B?b1JDWGhSQnZpYlNZaDM4OVJiK0ZpT3krYXRlZGhtWERkOGx0N1RtZm9ra01M?=
 =?utf-8?B?Qm9CME1JUUdXQ0hlWWRmWDNJWVdROHJUN04wRnhkT3RpRGhMLzVQbTk2SVpI?=
 =?utf-8?B?eEdRbXA2cXplVlJWNGtMRERhd2VGNmloWFlYWG4rKzVTcEt0UWczQU91NzQ4?=
 =?utf-8?B?MGpPQWQzU1NycjZnNkM4T3BrUWR2ZU9xZ3lFYjBsR0c2VHZCYXRvaTBDOFYv?=
 =?utf-8?B?bjJYaUs5VFQwWnI2RlQ1Z1dMcHh3NlY5amJkcFQ3cll5cHRiMXZHMmNWYmxl?=
 =?utf-8?B?c1FUaHU5Nnhmcys3dStvb3FFdm91TDVJekRpYndrbE1HMFM2OE5lTm5aZlR1?=
 =?utf-8?B?d0hERElLOWsrdDZsaG9ISm1CMUhBVXBKeFJybDJJeHhCeElBZUZPT1YrRDls?=
 =?utf-8?B?dlhSczU3VVhQdW1wYzliWjNHN1NaaEFzR00yTEhGZ0RueXVSam01L3F3NUF1?=
 =?utf-8?B?UUdNalVsOThTK2RPVTBnb2ZURHNNZHNwVjF6cHhIbC9HUDV2SHRlT3NCdXZ4?=
 =?utf-8?Q?Xs+Z3VpNv81F8oUKsYZH+cg5t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c20aef-000b-4fb7-3b5b-08dc80f42499
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 22:02:05.5373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIxkQm5x+cqtbVGMap1DdW4MKWTIQnN7F0fE9oaO46IcChnsckiCZUBZ80a/M3q8Lztwxfcx4msAap4t5Qjlzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805
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

On 2024-05-28 13:23, Yunxiang Li wrote:
> These functions are missing the lock for reset domain.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                | 8 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
>   3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index eb172388d99e..ddc5e9972da8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -34,6 +34,7 @@
>   #include <asm/set_memory.h>
>   #endif
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include <drm/drm_drv.h>
>   #include <drm/ttm/ttm_tt.h>
>   
> @@ -401,13 +402,14 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>   {
>   	int i;
>   
> -	if (!adev->gart.ptr)
> +	if (!adev->gart.ptr || !down_read_trylock(&adev->reset_domain->sem))
>   		return;
>   
>   	mb();
>   	amdgpu_device_flush_hdp(adev, NULL);
>   	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
>   		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
> +	up_read(&adev->reset_domain->sem);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..52a3170d15b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -307,8 +307,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
>   			ring->name);
>   	} else {
> -		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
> -				       &fence);
> +		r = -ETIME;
> +		if (down_read_trylock(&adev->reset_domain->sem)) {
> +			r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
> +					       job, &fence);
> +			up_read(&adev->reset_domain->sem);
> +		}
>   		if (r)
>   			dev_err(adev->dev,
>   				"Error scheduling IBs (%d) in ring(%s)", r,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 86ea610b16f3..21f5a1fb3bf8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -28,6 +28,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_kernel_queue.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   
>   static inline struct process_queue_node *get_queue_by_qid(
>   			struct process_queue_manager *pqm, unsigned int qid)
> @@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -	if (dev->kfd->shared_resources.enable_mes)
> -		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
> +	if (dev->kfd->shared_resources.enable_mes &&
> +	    down_read_trylock(&dev->adev->reset_domain->sem)) {
> +		amdgpu_mes_flush_shader_debugger(dev->adev,
> +						 pdd->proc_ctx_gpu_addr);
> +		

It's not clear to me what's the requirement for reset domain locking 
around MES calls. We have a lot more of them in 
kfd_device_queue_manager.c (mostly calling adev->mes.funcs->... 
directly). Do they all need to be wrapped individually?

Regards,
   Felix


> up_read(&dev->adev->reset_domain->sem);
> +	}
>   	pdd->already_dequeued = true;
>   }
>   
