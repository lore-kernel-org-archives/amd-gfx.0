Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C9AFF494F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A43E10E170;
	Mon, 30 Mar 2026 12:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RE/D48dt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB0C10E170
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 12:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy5dSMR3m3UoivoIT6xDSJiEjx91qx6v7CZOvbD//ufqK0JkP9iYQcGj0ZvxhIu7nehQ6lXhQIa1JVcQQHNyPJZOhtU9FMuvp94qsyBoCgVkqwIhF/owtgKALnY0vY2Z9hdqNfqnOY1ryknMZQ7Lgli/q0/LEXlOHwrMfbpIV9ec9EnXnZNyXbYUmhrCr3RqdJeAOSNuN9CVU5oYF1ArnTcx/3jUlDaXOwQo5yek7Th/26QoHl4txDozigp3lJBzd921FWaiEfNUgtadyIYl778P3rUm7NCXpZ67j/Z0RNnm2Hh1pX8YiSE1XfYB/i3+O7E2Skvw2kdyRPYFCMSmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww2adsMqn4E3XajoToJHu4s/J9F3sCR0vmqG63XpmG4=;
 b=iGRO0gAymN1I2nj1LuuV7Ul7mE2iwr7ORBqjN9YAidUbFLAaGzyG5ebxFDfY0qum3ZgSD3QqjUwQv6h8/JTvROoF/X7Nf3BmsrJfHxHbNRKDjfllHB4Ld1SYd45lDKGqwkINF815wXjL3o+Tq1gO3qY5k57RvDYyNY2yaVSE8hjsKb9TPc//Q6GqV0DFe5JJGYnH7NIEwHXHSB0+pua9eZQ3CfRQzKAdRpoaEeVDxpX1K/ZEXUBLJxowcqugs7F4yDG8Rn60lcuwfGdDSgtbq8j8IeR+V8Z8o9QUK9yJ3/Hv4bKi0hEjqiKJxI1o7BCARFXYlM7KkZUf7i5uMwwA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww2adsMqn4E3XajoToJHu4s/J9F3sCR0vmqG63XpmG4=;
 b=RE/D48dtFh75dyu6DGg9Z6lodX/kXGciH+8651yn+gaqjGE2AWn8XQ1aIy8JMp+ft8bjtKYTPE6sXo+RHMO2QH9jKkNABcEQuqcWdGKu2drdP7v+2HzwxsIX62tJ7ZCYyXBUBidv+5Or3hOlNjO4IDog7eJd3U1iA8l/XDaiNs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999157.namprd12.prod.outlook.com (2603:10b6:303:2bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:40:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 12:40:27 +0000
Message-ID: <a1195a6c-af89-4e28-b4b3-984a8a57853b@amd.com>
Date: Mon, 30 Mar 2026 14:40:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/3] drm/amdgpu/userq: dont check return value in
 amdgpu_userq_evict
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326132353.2753833-1-sunil.khatri@amd.com>
 <20260326132353.2753833-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260326132353.2753833-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999157:EE_
X-MS-Office365-Filtering-Correlation-Id: 1926c626-b385-421a-7144-08de8e598503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lxjRVut766o/f7sHnOhrARKYKiExazuTBZE+H9YiAfKkChYaS4HDU3+gmOlD7lrKtTLTsI2Jb5I9s+JzhqUoUynwSCo2XhgCijb0jITjjQzTrKILAIFXb4NVbLBzZRm+ZNsY96Is5a+mzfGgLkKQcVBCKm/2G8NgNdaMw4u2sVyPnZ6wNipV/4rbxUO9+hjAW/ruU0M0zazlj77Pcy6lmnAiIad9LVlTV2xJ8F5RB1FjcSvNeSMCWvOMQVDjd51N3bQ9yRYfh6MOe5nSYBo/2Dz/TRviQ5ZT8RMED/PMSAWW86irj4320mL3WcaoQMkIKXOfCCAjGSAohixGm0RfqZqfKz5ctVDVk5qSj1oIJs16CLvG9guAywdG9CeGcybhEpPhQoYyyhu8623Dr3XIN0pdt2rTQG7UvVR5OzaFTmJ5HS0glFQTUYACEUtNIcSKKhCYl71NB16qDL2NbqwsjncAzimnBsG/gbfMG8AqKYPvNAsQsuW0SLNtcfczkC+aNrVS1KVJ38Jp2sDweJcavPTE0hqyMjxj0rmHndPjkNSLEZR4+UHXhcZa4kYtH0K0waHB9BNY9kV2+UUgYnC5lKCCPs29Ni78wSaUUGxdJWLjchdLrXk1XNEkWzP+mH/pK6LGnH9+gT0YdOLqc6g/VaJuhUU3URBtMFNdcxgsPVkYrigHDgyubnEyyFBNswZ03esl6APMfEue/DMZtjprH4StJT6ujO75dGDN/TNQFik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtCVzM5QUlZRHRPMzVmR043Tnk4SzZSdnhsYnBYZXhnQlB3YXpZa3RBdk5U?=
 =?utf-8?B?VG5JSDhvSytZNGNuQnZiaUp2SWRZSWlCc004bE1qRWZOUmFXb3lKL1NBWkVM?=
 =?utf-8?B?eHVESTNhTXBaUFhsV0RMRXRxaW9WVWZoVVhEcVJpTk9DdWNKanFwWml1dlRy?=
 =?utf-8?B?azN3UjJabmFHVXczeTJ5ZEJURXN6dVZ5N1dXekV0dzhJck9BQnEzcDcyMS96?=
 =?utf-8?B?aDMxUGw4RHBPcHhXL0Vvb214a3llVUFkTGNBN3VLWGZObC8rS2tzS0lLWjMy?=
 =?utf-8?B?ZTdlbG9hMXB2VHJzaFRhYkRkUmgxRmtBVVF1dlZSTVFxNmNkaFR1NEJzeDRq?=
 =?utf-8?B?dDR1cENZOTh1ZXFjTzNvQ2s2dTBtZmtWd0pEcUJCWWQ3d0dxZmRFaVg5MWNV?=
 =?utf-8?B?OXVzMW9ydGVqODZ0WW1DRElnaDIwOVFIZUxkUWtwTERpTmUrVXE4THBDV21D?=
 =?utf-8?B?NVV5VHNNV0JXTmVDM0ZhbEowenVTSk40VmNyWmVPbFpvU3U0Z1NVSlZzZVpk?=
 =?utf-8?B?eHNkSHdqeUpNbFlrRkw0NHJhRit5MERIWEkzM052ZG8xTC9ZWWxuZ3BneUxj?=
 =?utf-8?B?V1ZXaUx2VGxYcnRjYmI4M2FoOVI2TjgxU0xweEdjakJrR2o3WFdXUlBocTJu?=
 =?utf-8?B?UFI4STJ5Tk9sb0RuWHc0ZmdJNHlsb2tqS2dHVnZtbi8xQ1MxSzZkeG12cWtT?=
 =?utf-8?B?dXY5NGl6MzB3a1ViV091ZWI3SDZDRWJ4MDhqOFBkRjJWSzBoN3BmTmxIbmRo?=
 =?utf-8?B?cm9scnhMTUdLdzRvMXhkVWdXQi91NkJFMlJGQlZzRmJiSjlMM3N6TDQ2UEFh?=
 =?utf-8?B?SStjZjBLZ01aaXlqN3FkWXdNSTBOR3RhNHNtY3NaSGxtWFlmaUtINlVUUDEw?=
 =?utf-8?B?OTY2dXJEWTZUN0xsRUxrQUdwaW9ZOGZLNlFMUkRjWnhzUEFZVHZXaGZkOWF0?=
 =?utf-8?B?YzNlZ2s0SkU2aCtBK3Z1RHVpN0xwMGp5Z0V6MzlhNDZYeHpDZjJSL015cDNH?=
 =?utf-8?B?K3VWZnlNbjJwNHIvUWtTZjV6WnRyeUE0S0dGQ3lHZjg0U25FbkxwN2dqb0xh?=
 =?utf-8?B?S3pkbzVESkhEaFRHRUFPRXNjd0dFVGFrL2JrUDIzMUVMdDVjQy8zS2xvRk1i?=
 =?utf-8?B?Vm5oVTJFM3J0MmYrN2hwMzE5bGh1MDFSWktLZk5NVHFkTGxnT3lDSzd3a3pq?=
 =?utf-8?B?THVBdUx6QjVRZFpGUUNzR05HK1VGclk0Z1ZaT3NzVjlsZVFTakZDaWFvK0Fz?=
 =?utf-8?B?L1o1dWRLcmtHYjJkU0JPSWNwVXlYczRTa3JTcEd3dTR6ZEVzOXdjSDRqWnVO?=
 =?utf-8?B?cVR5NWFpeUFBSGFEWWoraG5hMjZSbWhJVFlUMDJhT0hQemFOekozRm05KzNW?=
 =?utf-8?B?Yy90cGdNVkcwK0wwVitEbUlhQjRtZVJuUDBncUV0NTlET29YQ1M2NU9VM1pB?=
 =?utf-8?B?VEJYTDZFR01LZ1REeHNFaWZKQkRsKy9YL0VkTWNCbGN4T3ZxTHZDOTZUUFdB?=
 =?utf-8?B?VjRXT3Q2SVEwRldGUm5BdHgzSXlqUnNuYjJDYmJCRFJyTDlSSlNoYjRKYnYw?=
 =?utf-8?B?MGpUdlduczc0NEt1enk3RGVqVmYxeUI2dFRoYnM5U2E0clpCWlRwNFBmaTB2?=
 =?utf-8?B?S2NRSm44L1BjQU9IMFVmQVNhcDVEcWtURHRrUEpDNk1OUTJtdjFhL01kOEhP?=
 =?utf-8?B?RERiakVKWFV4aGVETmJxa1dSVjFRTFV1dVd1OWNXQXE3KytIN2NiM3lFVnVh?=
 =?utf-8?B?cTk3ZnpmbkZVZmE4SkROTENjMEdySnpVZkUxUDgvdjA2TnhyTEpUTkZKQ3or?=
 =?utf-8?B?ajdaRW1hV0JraHllb0tXM0l2dmZUZWNKQ0ZXZEI2V0dnU0hlaEExbU16TWIx?=
 =?utf-8?B?T1dCRjJraEUrd1B0UUJMc1lnS2tITDQrcVMzZm1MT0tLeVBJMTk5K0c1ZC9B?=
 =?utf-8?B?YWxBWkNLbWdPRjJEaTE4OHc1VUlVV1BUNHhTa2YwaXVmWUxhUmtsRFF4bUcv?=
 =?utf-8?B?Zm1OZk80M3RvQ3N1TDg0ZEZINE45dGVLRHErY0h3WmI0RE1UZThoem1KclZH?=
 =?utf-8?B?bExIN1F2WmcrU0VoNG9yaGRDbXZzbXFJdWpTcWRoVUljRnk1ZldYK2ozUDdB?=
 =?utf-8?B?LzdWZzRTZnk1MWlIRVp0RGpUQkp6SGliaUNWd2s0eW02WDF3UkdRbDdTV0l3?=
 =?utf-8?B?RGRvZzdhaExKSzlxa214MXhEdGNxV0wwWVVtSVFJSnlkeTQ1QkxtVnRyT1hQ?=
 =?utf-8?B?Mnh0SzRXN2dSYjg3Tm1LQzlsM2xnZXZyRWNvNXU1bHFVZEFWQ2J4OGFUZzZo?=
 =?utf-8?Q?SajajHe7aV28JKFpdv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1926c626-b385-421a-7144-08de8e598503
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:40:27.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MYp9KHXaCP3Yan1oVodty/5buZZlNDE9s2Gn8WCrV4qNiN6I/SYwc+yYEWf6uXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999157
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

On 3/26/26 14:23, Sunil Khatri wrote:
> In function amdgpu_userq_evict we do not need to check
> for return values and print errors as we are already
> print error in all the functions of amdgpu_userq_evict.
> 
> a. amdgpu_userq_wait_for_signal: Could timeout and we print
>    error message in the function already
> b. amdgpu_userq_evict_all: We unmap all the queues here and
>    in case of unmap failure we already print unmap error.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index aa0e6eea9436..6e6b1cae15ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1258,7 +1258,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	}
>  
>  	if (ret)
> -		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
> +		drm_file_err(uq_mgr->file, "Couldn't unmap all the queue, eviction failed\n");

I think it would be good to include ret in the error message.

>  	return ret;
>  }
>  
> @@ -1289,10 +1289,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f)
>  			continue;
>  
> -		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> +		ret = dma_fence_wait_timeout(f, false, MAX_SCHEDULE_TIMEOUT);

With those parameters dma_fence_wait_timeout() can't fail any more, so you don't really need to handle the return value.

There is also the dma_fence_wait() function as shortcut for that.

Regards,
Christian.

>  		if (ret <= 0) {
>  			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
>  				     f->context, f->seqno);
> @@ -1308,17 +1308,11 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
> -	int ret;
>  
>  	/* Wait for any pending userqueue fence work to finish */
> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret)
> -		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
> -
> -	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret)
> -		dev_err(adev->dev, "Failed to evict userqueue\n");
> -
> +	amdgpu_userq_wait_for_signal(uq_mgr);
> +	/* unmaps all the queues */
> +	amdgpu_userq_evict_all(uq_mgr);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,

