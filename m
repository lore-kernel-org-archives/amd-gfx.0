Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E17A108B91E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 12:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097B710E14C;
	Fri, 20 Mar 2026 12:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O1uVxPoo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACF710E14C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 12:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+OYe8L+w48hRKtJx9zmAUriX+faj5fa1BebXP3lJCAmSbQUGIEB4rfDuRx2+C8XM9VGs/YOesbvYydiiIdhnXnLox1k6PTsCM3Sy3keqteZNIsjovuMb4zOcX0jEPUtuoWbjTzfJFMncMauxkJn1iKOblRTGhTFoB8v9w0q2GmqVK3tE9YGC07o8M2682jrHgMOO9tKTEKIA1gLt7GNPJkEMwoWaFBnSRqTGFBHRXPAkOMkvvWT/TO/mwdqcD0Zi+/WGBMsWUcXEpcpR+5FK9hDY7b7ozmtrlHYS7kppWB/4o9VhyylAkMXatpQjQ+JVWi7M2UJrzWQj23k/QyNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeLjBWLGhEi8KT4BCddGDXfCsOld5Ov2qzsZadpoqNw=;
 b=iciV8xxHnIcPD8JJMdpKcWBoA+fM/B7IISPqbWB112YU6tMJfNeEntJmiWPC6sSbSlj3ZMHNC7OSDpx+gCVMMO/va5JguUM+L/h1BSHzJ+pIoZG6ohx6T9xtBECw62FEYYXIroWF5H5HAw3bb+uXfNx6zc2eVeUk/8z5x62Ie4l/MVCKf2LIYTl5rQPuICS1fWYCdzHsmj0Z5cUvYRC9+83zrYTxkA63xbxvt/ueyS2AN8zhGjWsitgxHArP+ggAZxRszNYnm1NWr3nkWUrZWSSE7sovnyxa9Pr/F79HkSeDLlRJt/5qF1RDHr3LoBCxeUP8axFmDoi1SPqUsgbcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeLjBWLGhEi8KT4BCddGDXfCsOld5Ov2qzsZadpoqNw=;
 b=O1uVxPoomEujUR6VP6j/H+imYsiX20k08ihWZQkEorhVRos6XT1CM9ZhsAb0a5nwrcKWH27vFNSlxqnaosfFJNGiEK+i8goHN/STNc2+WwXGR9JmhQ4pd+C9OtnPcEdmSNWFepfho96gcpVvN9F1/cWvPVpB4VsrTgPvyI7QtNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8df) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 12:53:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:53:13 +0000
Message-ID: <2e96687b-ad2b-4548-96c9-d7205edceb07@amd.com>
Date: Fri, 20 Mar 2026 13:53:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: cleanup amdgpu_userq_get/put where not
 needed
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Prike Liang <Prike.Liang@amd.com>
References: <20260320120822.3776362-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260320120822.3776362-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: da3c3460-9aa5-44c0-66e5-08de867fa5fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: Cqt2hrHNWfKb0dcCRbw0v0ZIlHzNYDea2A+V2+59fAuepcn9vXR79mXJ/XKlat0i/usz1za6DIkc4jY3Ru+l7mTJmW24AK7JTw+b0eyv4/9QvAnERGntCx7WaoE5nuEwgP6KMkwDnSFNp23rwFMBY5aJLxoLGjvRSNkGzXJof9dYVAzT+ISA4/e0ANn/DhlOoO6jLdYC86iJy9XppVZGjsfqHQGojF9OldHOcoFMlC7U1qfVlONYRxvh7Q5I3BT/x1n51T3/2HdWG/Br8a2BhMUl8cX111PYKz75AGhnGCDzlwxPtvPFrhnxI4MrxWjCJ7l0SIhLth5GtLeJYuuv2UN6KsNO44+ldQ4B/wGw2dr7SkJOXifMz2n6Vo53hk3zbLDuYgEPcFsluDGMyDUycZpr5wasR6PxXE04Kxfms4ynXwzXtyoxSKkFRqllUlioO+8qqpD3UOFq/i6v4uozgaPvNc5+hUUXoAkUCYWZP566XWnM0X7hH4OOGUQ8crS30jOlPE5pCiq/pACMiDRTi2axGY/9GNj0300+SRzqZAKHdtWjg5nSiB6neoCVHfMeozD/8wuh5IbdF4FflDtqjVd7N9yxfwTLtI186Z9A/S+4ZUMI0TGIYssiR2WoFl3u83nLCdkVLOlSaCINvZi07T3Up/OzRVfv3ugPIBvYFdmQfotxfB+B0QbHImpvB+vIUCSYEXx6CWNqFVesCtgo+LSDxZhdAlwAwt4/WSRR82U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amcxZnlEei9SVzBXcitBZjlpM2VzY2NDeUJhNlhFNnN5MEpybFV2aSs3KzIv?=
 =?utf-8?B?OTYvOWp4VlVCQ2xSN09lSmRYQ3lxNndYR2VkSUhLcXoyZE9XRTFGMVQybzZx?=
 =?utf-8?B?N2NqMWlpblQxYzhtZVBDUmQwcDRNNUw2cTE3c0pxY2FISFgvYzJOKzVRRzRR?=
 =?utf-8?B?K1FuSmZYZFN5QmhYOTNOc1NqMTNMTTk2Vk1wcFdOb0xsM2dpVzE3ZjZ2MUlZ?=
 =?utf-8?B?eTZGRzBSeUppZDdzajdmTTJ1dE9ITURoMXlsTGIzMlJEMHRKMzFjSFh1ZGZP?=
 =?utf-8?B?a1BBay9pa3paZ1Fmd3Q0c2RhYUFtTE1aZ1Y4THY5ZmhZdldpM09ucll1QkRG?=
 =?utf-8?B?RFIwcmFwb2dvTGdyNzhnVFhCNWhQTG92UkVtTnNBT3ZGT05CU0p4VkcwVHo4?=
 =?utf-8?B?UHl0VlQvM0dLVUIzdnRpK2szOW9ZbjJRemkxajRrSkdBU0pYOHVhRGk5SmZh?=
 =?utf-8?B?MGx0Vml3TGVwOEQ0R1lEdmY0WkNQL25yWGJMMXhwMDZqZ1YybHZJb29kNnRy?=
 =?utf-8?B?OEUrWEZ0aWY5bmRCbm1hZHVaZTgzdStMSkNqNzY5SDdYc210cEE2ZVphdFZw?=
 =?utf-8?B?aVVIN3h6YU5yUXdqdW1RaWdVL2ozMnBEZ2JNS1ltUkFaTDllWlNqVlhvcUox?=
 =?utf-8?B?Y0tNNVRmS29hNzFtQzl1T1UvUzJGOWl3Y1h2MnhrRkdSRVFENGVVUkFCV2ZV?=
 =?utf-8?B?WlNvNmRvNk9OTkhoaTUvbndBdzBBRzFSUGlpN0RLYzA2UEF3Yy9FK016dVht?=
 =?utf-8?B?dEVIRnBlK0Zpd2lJeWpma3QrbHNLZVlqZ0RRbVFnKzdXSTJRMm80c3dwcUhU?=
 =?utf-8?B?aU11TktBQ0VwMjlhUXF6T1lULzJXdjZnZitCM0RDMDhETXdaalRvYXQyVG9v?=
 =?utf-8?B?SmxZOTFnNkIxOG1MNDJCOE1qUnBhcmVodmkza1VNWjUxSVVuR0tiNHg1WkJ2?=
 =?utf-8?B?SHJtdHJaZHF1aCtQTVBEY2M2aFFjQUVxeE54clg2cWpkQ0FsTFgzcWFHanpt?=
 =?utf-8?B?Y094NnhFSldvNnFsR0pvMTlDL21aclE5R3BYa1hlQlR5RFlucUNiZEx4Q1N3?=
 =?utf-8?B?NDVhQzRrQjZ4VlhDRzUxWnUydmNJWXV2aTdSQUFmdDB2LzU2WER0SGRDR210?=
 =?utf-8?B?WnhPUVJOaFJQYTB1bWtHLy85RzRCbnJWdGVJN3EzSXRONi9DTGQzYlFkKzUy?=
 =?utf-8?B?L0t1dnVsY0xsZTJKa0hML09FZVhSUVp0TEJxWUJFeG5PakVtbTBxSnhPa2Mw?=
 =?utf-8?B?WmxmaFdDL0hZdmw3YktQbU1qUlFsTmVxaFhIY3hrSUJnNE9jR2hYN2t5cGcz?=
 =?utf-8?B?NytQTjZia3lXOStCeVBUUnM0dkFPMzVvdHdCL2FTYkUyY2hoaHg3ZXJjb0N4?=
 =?utf-8?B?MUdNZmt1bXE5aGJyeTE3VjYrKzBtWldScGNJZ3V5NGVjczY5MXlrVEZjQXJD?=
 =?utf-8?B?cy94RkpEYkN5OHYvT0tURTJzaEc1TEVNVWVRakpaekZ4YUVZRTVtUjFFRU9G?=
 =?utf-8?B?VWtnczUrYUp3VkZSWFBNVWVEcHJiZk9TeGVFbmtaZEplRkJSRGtZVS85bkZ4?=
 =?utf-8?B?ZGFVcmpadmxtUzQ4b3RiS1JQcU9jaDVCVVIwZjBNREloYlp4bU5FRlhpWXI3?=
 =?utf-8?B?Q3NwOTJaUlp2RDF1dlpiSEF3MmM0V0FBaDFhaytRTk1pZGw2cGRhcXgrNGZv?=
 =?utf-8?B?b1lobE1IaStXVEM1STJSS1Fha0ZMVkdMV3dsNjJTTGZ3cnY5ZWEvdm1yblZS?=
 =?utf-8?B?cThnakRXV3RnYWNIdC9xOE43em0vbWhoSHMzNWx6cDlzUEhsMW5MdjhzTjdy?=
 =?utf-8?B?SzVxUVkxcUoza1M1NTNnN1ZFSzFMeTVpaC9XUHMrYWVmd3plcDQrRnM2b0h0?=
 =?utf-8?B?Unlha3ZWeDRkMGlwcFBuUzFnaFQ0OVZpL1V2SHUvK0dmVkFFaFBZRlpWWG5E?=
 =?utf-8?B?Z2ZJZFhoVHA0eEthY3BOOGx4YWlkc2tVUExXb1VmUCtnMjk1ZU01OHBPV2dX?=
 =?utf-8?B?amtzanl1NDI2d0FydXR1MHc0RkRrR0sxRGF2WC9PUnY1eXdEVk5DRVBzMTJq?=
 =?utf-8?B?aEhCbDJJUnFJbW5VcU9yUS9lSFU4cEp3aVRwdDk5VE51YzlwOGFhY3dhZnN4?=
 =?utf-8?B?anpETTVZMGpKdVExcTlhbXZ5WGZhL1lEOTB0eE5waFVGck13cGdVWjAxWjVQ?=
 =?utf-8?B?aFBPTnZHaUxFWXpSZzMyWkc0YWN6a0RaTElrSWJjeUhUclJqby9uM0VFVmw5?=
 =?utf-8?B?RTZXY1RTd2Y3czd2RFJWWGF0UmVvdFkrWHB3QzNtS3g0bjgxeG5XaVgxcWNh?=
 =?utf-8?Q?kdUMIde527o9U40yQv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3c3460-9aa5-44c0-66e5-08de867fa5fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:53:13.8241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is/j7cqZTAhrTWLovwi8yhr/H2wgOZdjVjY3BPcLr0yJ7+Z6rD84zhThODjJFFu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77
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

On 3/20/26 13:08, Sunil Khatri wrote:
> amdgpu_userq_put/get are not needed in case we already holding
> the userq_mutex and reference is valid already from queue create
> time or from signal ioctl. These additional get/put could be a
> potential reason for deadlock in case the ref count reaches zero
> and destroy is called which again try to take the userq_mutex.
> 
> Due to the above change we avoid deadlock between suspend/restore
> calling destroy queues trying to take userq_mutex again.
> 
> Cc: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Yeah that suddenly makes much more sense. I should have seen that there is something wrong during the initial review of amdgpu_userq_get()/_put().

Anyway better late than never. Patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ced9ade44be4..3162edf19136 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -999,15 +999,11 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	/* Resume all the queues for this process */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		queue = amdgpu_userq_get(uq_mgr, queue_id);
> -		if (!queue)
> -			continue;
>  
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
> -			amdgpu_userq_put(queue);
>  			continue;
>  		}
>  
> @@ -1015,7 +1011,6 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (r)
>  			ret = r;
>  
> -		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1251,14 +1246,10 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	/* Try to unmap all the queues in this process ctx */
> -	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		queue = amdgpu_userq_get(uq_mgr, queue_id);
> -		if (!queue)
> -			continue;
> +	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {;
>  		r = amdgpu_userq_preempt_helper(queue);
>  		if (r)
>  			ret = r;
> -		amdgpu_userq_put(queue);
>  	}
>  
>  	if (ret)
> @@ -1291,24 +1282,18 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	int ret;
>  
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		queue = amdgpu_userq_get(uq_mgr, queue_id);
> -		if (!queue)
> -			continue;
> -
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f)) {
> -			amdgpu_userq_put(queue);
> +		if (!f || dma_fence_is_signaled(f))
>  			continue;
> -		}
> +
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> -			amdgpu_userq_put(queue);
> +
>  			return -ETIMEDOUT;
>  		}
> -		amdgpu_userq_put(queue);
>  	}
>  
>  	return 0;

