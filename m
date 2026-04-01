Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5188D3517E
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 13:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717D610E27F;
	Wed,  1 Apr 2026 13:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vzTYf9Yz";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7CC10E27F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 13:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3MgHOxyMxEGz+K9M5UtQ2AICIq/W8Y26RnKSCd7jHKDkMdMt/QUY9H49ug/17mRE3Jh7vNFGv+ieGhgOueDBlvCizkOf+uzse9+6UTMdofh2Wps8Da7DICN/eJUjO7QWKm6+eTO7LLzfhBHbTmW+IHU9yNmPofV+D4ILlqUhHI80Nnidlb33SA/HhSMe9n+sg5wjfsyUXkhDMKudS/66T1dh8oEulKBPyuZlRHp9VkN9CgUdcdvnSUYi6xRbSg46+oYi5sT5Xd/SpjUNA0V3eQC45qvkEEgtLv+R46bwBc4dq3827TvEZYG5IxXJOfwzqOObh1ZoBoiqP9nZ9/W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WKzQDOOdDOHK+CRjRoRNueleDrx/4Fma1KGUGpi1po=;
 b=ptjRoeYALQOtjCwcZn5skNbnM8Sy245TThc1TjuRRh/d4cpMaIJzptTQwnPTx547UY4WxYIWA61d9i5SxLxuziwUWLoLKcpzkMoE5vCOWI4zZMa0fl+ylFMcXGOVxvBqK2+MAJq0Uvxfd6Q8gTLYVJpEIacfCRm6dtzhq6TZ4exuTwoEAwoL+huzFya5eWIFwNLM5HBZe8+ZMN+TT7Pa79Hthi9uqj4faVGcP+bXf56Ndvrd69bQtWg7/KMUsmyLYG3gaInBcqS+ThfSw1xdT45wGmXMCbfJxnxwcEPrp/CieFMDDoUfiNrKv16pDqby+7PsszPxZp3i6NvBEu7Onw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WKzQDOOdDOHK+CRjRoRNueleDrx/4Fma1KGUGpi1po=;
 b=vzTYf9YzZhqY7ORbqwGScaEbonzRS2jEvhs1AqHT1Pmqd6UPiAkYTWS39VNTr11SLriVCJ92z7r+apD5rCYhiOzPfbLM4sb0Uiz0bOja0V8VJh27QMJ9ecxsCKjSNFhKQ95IjBKOsdkVf/3BHJl0uO41oh0XpKcIv0le6EdTADo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:29:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 13:29:47 +0000
Message-ID: <63462e1d-0fc2-41a7-804c-ee4497bbbcae@amd.com>
Date: Wed, 1 Apr 2026 15:29:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 5/5] drm/amdgpu/userq: use dma_fence_wait_timeout
 without test for signalled
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331134654.2762805-1-sunil.khatri@amd.com>
 <20260331134654.2762805-6-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331134654.2762805-6-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0094.namprd02.prod.outlook.com
 (2603:10b6:208:51::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e450c9f-02e8-4b46-674f-08de8ff2be3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: na7pBUpr2DLLfu5NzTB8ctbUjFgn8fKlt2JkFx/11/SYKNEkLszB1U8ZxznigI7vKUgzWfU/1x2/OvnWOjWl9lk0fdDehKTxK0AmhExfHNLhdsEr5xyN62pECSVD+y986bEWD6hTykcHnuXU9yLS6RVD9Dj9BapZC4ZPOiL5+7NvYQ0jHU9AiBB1qbj/tfyqwzjwu2Rg6a/uGZNrxIb43ajoz7XPeMJ9orpdNlGOLMT1SmDqPLW9iZeBfbEsof1LuUbcEOs669FbsSjEQhU/707sMUxvq95FAswx2H/JjJLPqbr2quO6ARLfJMUJ4FdGttOWjR0AyKsMOkKB+d9bXS9DpCsdJV/G4nLW9Cp9HGn8lyHZj/u6Hp/Um6BrQPKg3Keq2yqPN5CCdVDhtXpjvZhavt4vjT+zLJCK0gv2Llhx7vPFETR7/JiNzysbKcQOv/Pe8YQSnuxAhvStTtIlZPiCn2pcGpuOO7lAGxVvwuGxUv1ZbfUJDokrq7Lti472A3MjaSpMU/KU/W8OSAOx6twKYi25lzhToAvrqqN3fMv7QDEX1Z8lT8e5OX7UtKZe2RfFk3CQj5FvPaGPcpNgfEy44kLES1ENg1h+ZJo+j0eMTUX6bOMTwDA23uo+Lc9ykqSnKCmf9C9oasj9QaTNuCHRgK/M45IBwVFAIvIFlyhxFlPCEwocF9SMHifCVWA6Aj3mP8n3V3NK4+CLvlzaXSbZ1uqxowa9suo140XYjUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhaeTVibFlkN0hsUkJsbThjM3g1Y0JCQ05iTjY4aEFiVUtwbkc2TitQazMy?=
 =?utf-8?B?WDlJaFN4anFVSW9sN0hIbFYxTGljT2xZMTczdzFJRjA3cmsxdmQxQVZTS3hJ?=
 =?utf-8?B?cFlFckw5K01VOTY0bzhnRlYxaEtxbWdrUi9Zem8wamUvYk8xemRNSkpDaGVG?=
 =?utf-8?B?VExEa21HVkU1MVZ3bE9kQzR3c21PTmczYWp0bVY0RTlPc3RJQndqWGYxL3Nh?=
 =?utf-8?B?YzhkbFduUHNWNkVIY0l2eEswY0NWZS9VeU9xeVk4TytacDR6VDAxRnBxS2Ir?=
 =?utf-8?B?Y0krR242UEoreUpEaXFFQjBxMG1XYjZhSE55YzB2VVliMjVhaGxDeHB1VkN0?=
 =?utf-8?B?aTA1d2hWOXEyOUZ5N2s4WG9sM2lYVEhQNHpZSnZLRldPZlBudk1IUzkxK0VB?=
 =?utf-8?B?cGRkL0tmTlkrd3pkK08wWUthMEFJRVF2UGk4MkNJdTVrSng2K1JRbnJKOGlX?=
 =?utf-8?B?WHBqUnRYVWZCa1pwYnBiK3ZBY1RDdTVhajZGVnpTbWxhR1Vyb2kwbVV0MW9w?=
 =?utf-8?B?QXgxVUhaVWVKTEJWVmgzbWhaeUU5bmhDc0dCRWRRT3pmMThnbC9iWXh1d1JJ?=
 =?utf-8?B?Tlp2dC9xRVNOV2liNVdER1dPUG91NEFnbmpZR0llNnpBVFFFQ3pyUDlYc0dj?=
 =?utf-8?B?eS9NTEtZSHBRckJPay9PeDM4empGTkFQb0U1N2QvYkhjM2NCSVZBVnRBSHlW?=
 =?utf-8?B?R2RaSzU5QTN0ZHkwV2gzZkxHMHpjTGtIUGZXMENRL3dONy9nNHdHS04wbzZI?=
 =?utf-8?B?cXpDS3ZrLzh6NkVySW85WmlkRkVQbElRZGtOV3g1aVh6OGtKYzJwcDBVa3VK?=
 =?utf-8?B?VEpVaFF4Sk1IOExpUFdMQWtNZkJVV2NvZXlNcG52dXpOeVV3MTM5a1J4QnU3?=
 =?utf-8?B?b0ZlS0dBMEJvL2p0TXVGMXlBaktRSnhvM0YyNThVS2tWN0M0bWlZeGpad01i?=
 =?utf-8?B?SUw5bGNvQVBkNmd5YkNnVUNKRmVhQ2pVZWVqSVlsUm41RXNwYkpLUEpUUWFr?=
 =?utf-8?B?ZkVFM21KYjN5K0tuSTFQOUhFRy9QT1RwbjdOcHBYMi9vUENTMUVmL1J5alZ5?=
 =?utf-8?B?N0p4eGVURWNISGcwWDZ1a05pR3FseDk4NDdPQnlTNWRRU2lSZnZIUDhLQWNs?=
 =?utf-8?B?L3BuQ3AyQ05mUml0SXlkY1lPT3prczVSdHIrczF4RkFGaGc3K3F0NExqZ1Zt?=
 =?utf-8?B?L1J0U3hRUS9QdnlHVkFxNU5zdUdoNWZnWFhhZUI3TXRqaWJ3b3I5Rnp4SG1B?=
 =?utf-8?B?aEkxQmFsUjlFaFBybENvMW5CQzY1YURJNmdtMm1xMWQ5dWlEbGxyQnVEMTJn?=
 =?utf-8?B?ODF4TGl0dmpTVW9GMVVsMEpybHoxVXN2TFJGSUhPOVYwZktyMFhUQjQ2Ulln?=
 =?utf-8?B?UVdZYVZvTFFLTWZINXdxT0cvQTVWT3hWYm0yYUc0dGFEckdRWGh3aFRrb1E5?=
 =?utf-8?B?aWltQ25PSWFheDh5OUhwckN2NURkRmhwdU1yYWFMWkhQaGZuWVV2MTVCLzU5?=
 =?utf-8?B?VmZUN05HY0R1OUhhMS9lNG1XREhzS1drZDNiU1RHMENyNnRKODk3bnBTanNF?=
 =?utf-8?B?UlFJbHJKcDRkV1kxK0swSnFtMmpXRUM1Z0d4Qjg1ZDR6cVhtalZmQzdMMXRm?=
 =?utf-8?B?bWhhUDAyUWo5S1E1VFppNzNXQmZKNzNOaW9RVXFjZzNxdTFFaFo5emxuWXNP?=
 =?utf-8?B?MGpZN090RlMxMmlCREVXVStKdUxjRU5KckpNV1c2SU9odDlHUEUwRzFlNHk0?=
 =?utf-8?B?WkZnZS85cFNQWW5yMElxc0xGbEtoODRqSXVZSFdFaWw5RFhsQm1nQ3hXTWY2?=
 =?utf-8?B?UlBHbUdxdUZrczlvRlI4YjFQUzJONGVwb3VwUVp0NGZHUGlDNXR6VXorVTBq?=
 =?utf-8?B?bkJjVVVCeDl4UyszeXRhUUtsdi9QdTVIK2lXM1JOZHZsRzloR3pRVFB0S2hp?=
 =?utf-8?B?ZUIxei94S1ZWZk9GOEpmb09pVkY1dTFOTWN4ZndXTDlJSlo5bUlCTDNMajdz?=
 =?utf-8?B?QTlsQVRKVUs1ZFYxMEZKd253RS9OcGVjWkhXMEpHaVVwMUFYZ1d1aVBQaDBD?=
 =?utf-8?B?MURFSDB2RUJZVmg5ZFhXdVFWQmNVR21PV1dPVzRXRXl5ZTZQKzFJQXNiaXlt?=
 =?utf-8?B?YU8zR2J4TW1KS3l5NFdtNmpSemg5ZkFSd20rK211aE5ZcWhGVWtTcGRHRHh5?=
 =?utf-8?B?dDhETEpZc0ZvOWhuTG1OTnJhcXlKRmwwUUZXVDVDRTR3cUpaMC8wdmRoSDZw?=
 =?utf-8?B?NCt6WTdVZURtc1FnRUxnbk04Q0xNT0tqZTZLNEU3NUcrMlVqc0cxRS9jb0c5?=
 =?utf-8?Q?hkvfXLI4Yx+qT1qW2O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e450c9f-02e8-4b46-674f-08de8ff2be3e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:29:47.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHBiF8cs0tQVWWhzE9LKPSZ7N66yZ3xvTC6I4hrSZQozWkTQYnehm+Sh9mCpqtzC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

On 3/31/26 15:46, Sunil Khatri wrote:
> In function amdgpu_userq_wait_for_last_fence use
> dma_fence_wait to wait infinitely.
> 
> Also there is no need to print error as we wont be
> timing out anymore.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 31f45bd2732c..4136f1ac1e7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -427,23 +427,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>  	return r;
>  }
>  
> -static int amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
> +static void amdgpu_userq_wait_for_last_fence(struct amdgpu_usermode_queue *queue)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct dma_fence *f = queue->last_fence;
> -	int ret = 0;
>  
> -	if (f && !dma_fence_is_signaled(f)) {
> -		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
> -		if (ret <= 0) {
> -			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
> -				     f->context, f->seqno);
> -			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			return -ETIME;
> -		}
> -	}
> +	if (!f)
> +		return;
>  
> -	return ret;
> +	dma_fence_wait(f, false);
>  }
>  
>  static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)

