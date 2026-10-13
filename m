Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F90CC6B0F
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9107210E791;
	Tue, 13 Oct 2026 09:26:28 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFC310E791
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqWYpci4vuBpodsZ+b05T2J8MsuOw9Clik3pjQxzYX+9mlIf2Q2bpkr2lvHocAL2zOTLK/lWrgbjBvET0mFI1PqSgSq8Pdtl/Ho+QuSUpIp/EJVwQk0Qku1rLzpbL6T8GgfjROt6mqFSPBHyTodvTK0qY5UuoVQv8Yl6Dm1j+MpqQRrj0IyynPA5Tf3DVNqpNPEAd1CBw6F5/6sfBoxROBUyqk9pyrsYsOjguDd3g4V9CCHOR+e6KzSMgYIOydeDB+R3v+HhPGBjK3gYPOfmtCKAC/7L4gYpcNtTUvKwe4Mwc5poUzggI6CQvSvJvIpjV4i5tdVGL9E9U6xC9MthjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx/qoBENIJ4P06aEv2B0bU0nVN6JuefXhPOVrSB6H60=;
 b=At1Mk9cXf/j6Ge95/5Fgvekm1Pf/3gNY+Z7YYTmdSaeLZ32li1hlbVcO3a+u3g03NkC1xfqxOqKyq4b/Ymzyd2/cfiv4EktMSSyr7mKwvHx7Ori5+fVulnowFujiFxTrgGtJERKZwjLzPtbt7iOcldyEL5CuJHkZnxxZUz7ccbm6AmZOcZ2kEpxsHIucebFN7MMwW8AVZfrVEP+LPVIItOf7aCl1lGJfjKqezU0XVChku0mK7+rf0ru2ztbABRRSfgE7qcyCNaOQm9lf9LUwM/hHV1Iz6PhN5WNA6dYADtI00e7PLNrbXSr81r4So3NYozeIjmk5AB7OBw2utnDA/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx/qoBENIJ4P06aEv2B0bU0nVN6JuefXhPOVrSB6H60=;
 b=LcmJsQWfVze6+UOBA4Gb0eJ+VX5yzl4t9MdjQ+5PPdThjS7gMcghp1sl/oj5v8WRealTyTRMqwM4Yk+9AXI7pSbibOK1QdTFJE0jGlOj1SS6VeyOo1d3fmrGUDe47E/6IOvU13w05utbzDqXe6/VW5iwaXl5oc6SjIAQAL40WGQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:26:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:26:17 +0000
Message-ID: <639f5147-1694-49af-8ac4-dea9ccdd7f89@amd.com>
Date: Tue, 13 Oct 2026 11:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
 failure
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013082457.2492273-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 661acd45-3c31-4c60-01db-08df290c08cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: GBXMlLIhNNXK7767CevOKKS3WC8HRgLjnDdpz3M/WmRHSQwn/9/hRlK0//MOwAvMCJJ5RX0yJ+p66s3HcPz7RWcApdPXk3CJLSIYRWvWyyekZs3ZNCpiCp1PDzI8dBUdS4QscPaAEXldhtAda6agkPRFm86KEEovjTChkdrt3bCmeUkmM15z4OY7LdZxsy65iV2+nlF1ujCT02ArJKuMU4gBCb1gn36+Yqfw6vYEzuBZtLi9xfLlANnRXLkRnaRdIRMEexxhDFM3FkXMLTL+BJiQFclSDdG9wNydQD/oGkwnmz2or1pAJGmLAlEAeTthqn643tp00FEeJdr9F4MPjw7Ql7zdoYNBovpNG3C4pxaRNjH/Ysim9xkwHr1JmqWgTokAEaOibXqtrjtbDcLussIHmzFYcfK6o7So9xzDbu/nRZN32v/9hJdmaO8DBx95Kvq47Gs3oT3+SGPllacS6iK5vZuNUBPm3uRc8BM5rWtxfF8Z5dGowYHwugt4cy89wZO5bWKH3f4nvVJ1j0VIoixGVSfY9dK+q10AjtWxWWuayLunquX3Y0I8fB1RMe4sUqcVjETBhZhBO8smPIDAkbo3noFI7g2lDtZq4a7DTMGOBUHIT6n3jKtbZP7XT0W+PkMikcy1mxtVkcNXIl2rtppAbYVdV3rrN2qf7v1NC3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDZJUjFMNzc1TS9oWDhqK1pZVERQVGZDTHlSdEZ2T0xZZldjeURzMVVVNVFl?=
 =?utf-8?B?Z0lQVVRJeVdORkZaTnRYS0NGZWpmSno3WWR3QitBUzZNbkdJZmx6R3kwRkNk?=
 =?utf-8?B?bTBFc3MrekxZV3RWdkYyUm5TYUNrYkdrdjBKNUV0ZDNwSjk4VVZydVFCeHBY?=
 =?utf-8?B?MWlOUHRaZHpMUEd1OWQvclpmVVF2QUNIbkpUQi9iSkl0WGU5b05uYXE0UWZG?=
 =?utf-8?B?RVRSTS9WejZWNjFNaFBuMUUrcW8zYmhBTDBvK0dZQW5oY1V6Wjdua0NYQUdh?=
 =?utf-8?B?RlllektCcTBBNjd6YTdKKzRwTFFxbnVLcUozNFlvUkxRTDF2dkJOZWhUWlFT?=
 =?utf-8?B?RmljS3dRdXhzclRWd01HWVpRdjJ3RjhyS3pvcHM1d0NSOHEzTjFOb0NBdlZz?=
 =?utf-8?B?bFdKRDdaZ3JGVnVrbGw4Y1dlQ1JvNWFuNytGYkcrOW5DbkllNmZiOGtUWTl5?=
 =?utf-8?B?MXV0YjFxYU9abFZtZjJDWlJCWUNIV3BsbW9TcEtGSDdWMXY2NytKV2RSUmxC?=
 =?utf-8?B?NGFmdC9LZDMwTUlPbmt0dHBxdUExUURiYzJ5a01nWkdSZ3ZpQytIZ0hGeWVZ?=
 =?utf-8?B?dU9oNXpTSktDaGN2QXpwaDhMZytHSjZLQ0srOEt3UlgyTTYzcE1ZMTd6RWZI?=
 =?utf-8?B?VE9CVjQyUlhwbm9tNHZ1YkZzM0FaNHVvTzB4bzZPRXlBemFHdUdRejJSWW45?=
 =?utf-8?B?ai9DbUVrVGtHZFh4Qlo5dk90YXRIeTN4a3JaSHRnVmt0bnBRSTkwWElmNS9J?=
 =?utf-8?B?RjV0VGlyeGR2VnVha2dWbE9nTXM0ZmRabzludTZxRDcrMzNDWW9zMFg0VHVx?=
 =?utf-8?B?SWlHYlhpUHdGWmN2dmFWMGpDUXFqR0pzQ1B6c3RFeG1MaWtrR3owbUdqWXFS?=
 =?utf-8?B?N2RlZm4zcEVwcGFPMkMxTHlEb2dtM3RuYStKNlVlY0JSZE9NTmV5K29tZksv?=
 =?utf-8?B?ZmlRRnE5eU8xY2Y2d0JYR2U1WDRtdGZqZkp1RUUvVDY4VmVDUm5zNTM2TmhW?=
 =?utf-8?B?aGcwVFRJTkoyZis5WWNCT21BRlc3WW9oQjFtR2xRUEFOSUgyRVVNcWJNQUpQ?=
 =?utf-8?B?VDk3b2loa0dsODl2NkZIYTN2cnI1WldyL21sV1FKenZ4YTRFdTdsaDBJbGZ1?=
 =?utf-8?B?eVAwUkFDRm5oeDVaWmN5NllrOGQ1MWVJMElzd21YdW80TzZRdFhUQmFTaHM5?=
 =?utf-8?B?ZjY1WHI4RUFUUG8rOGJQWjNHcS9WU05ibUcrVVRxZ25Vc1VKQ2padkM1ci85?=
 =?utf-8?B?c2IwbjdMRUtONlZadElvaHlIcER6b1VXU0R2TXVvMjUzWFFhUnBmQWdCdENs?=
 =?utf-8?B?VGNjOWZJM0c3STRJSmxmWDhqNUpIVHZ2MjhDU0hqLytSQktOMEtzQVMzemd6?=
 =?utf-8?B?RVY1Z2owb2NIeFAybmdwZzk3NmVMd3RCVHZOMFNydmNXUksvMzBNSkNhSjRB?=
 =?utf-8?B?OUlmamdrb0I3YkUxdFdMT0kvZjVLMVV5QTN2TWdUaFdjV2RVWVo4U1JGUit6?=
 =?utf-8?B?Z1c2cG9JYlFLNFBXWXVSQTBlNW1qRVVsMmNqd0lSblk2MkFlWWVEZzNLVTZo?=
 =?utf-8?B?amhyaXVvc1JhNG1VakFITFJISGFqeHRsTnZhbGNISitvbWN1cFZ6anN3NnZR?=
 =?utf-8?B?d1E0M0xjTW5TeENJa2NjcndBWkZnazJBQjU0U3A5a0xpcFVEWnJaeC9aOGhF?=
 =?utf-8?B?azBIRFVoUVl4U21RTkVFKzN2eFJGeGxPTjZ6bk5URTdudnFkR3V1T1p0SS9W?=
 =?utf-8?B?K3lTT1FoeEErZjJ1QURQeVhmMXAzZkJFL3hjVUk4NWlBc3JMczdQZkgxYVp0?=
 =?utf-8?B?YzdmV2xEL3QzY1l4dkFkZWZCZVVYdWNuVXgwQUt3cEg3ak5xTlBMZTFTdm5E?=
 =?utf-8?B?Z2ZaM3JtNzhHZnRUOGQvT280d1lNUUwvL3IrY2NxTjl3a0VndWlWUXdNMEtK?=
 =?utf-8?B?dm9qem4xZmY3WmhJdVc1UGlFRzF5Znl4ZDIvVENGWHo0QkhkSWRmL0RWQ2hH?=
 =?utf-8?B?eFM1ZW41dThOUkVha3JiSDExQW9Id3BOTnJ1V2grWmQ1dUFES2V1SUdHbWs1?=
 =?utf-8?B?cEpXOWNVY1RzWm9CM0VDZUZ4YUxJcmxmNGV5bUNiWUFhekFXMlBjTnY0TkpJ?=
 =?utf-8?B?aWxxc3VkK3BKUXRvdE1pSW9LZG1yMnIwQTV1aE5vOGJ4MTdSaGhndHNzLzc5?=
 =?utf-8?B?a3NvL0tub3BkWWRVbFJDSkRFd0YrOU5YUWNST2hpcWo2ZC9yT3o4S1BDSGZy?=
 =?utf-8?B?N09meTRuakpnR1ZpZmh3VTRsT01Fc00yL0wzK05hdHpKUEZjT3c1eCsvOGNh?=
 =?utf-8?Q?8uBP3SnCLNjyqpxLOp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661acd45-3c31-4c60-01db-08df290c08cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:26:17.6593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQaCRIpmVSTF9YOvoVp9mXcKsMnRGMO7CJDjX3W9bgqdGZAq510FDzzA8QobwOvD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

On 10/13/26 10:24, Prike Liang wrote:
> On userq eviction failure, the suspend worker waits for reset_work
> while holding userq_mutex and inside a DMA-fence signaling section.
> This makes eviction-fence completion depend on GPU recovery finishing,
> although recovery can itself require memory allocation and eviction.

Absolutely clear NAK to that!

GPU recovery is to unlock memory allocation and eviction, so it can *NEVER* allocate memory nor depend on eviction to complete.

This patch here is just utterly nonsense. What we need to avoid is to touch the userq mutex and/or any eviction fence from the GPU recovery.

Regards,
Christian.

> 
> Fixes: c8ed2de0f2ee ("drm/amdgpu: rework userq reset work handling")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 12 +++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 10 +++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 082d045edf45..c2d1bc7decba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -65,6 +65,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>  	struct dma_fence *ev_fence;
>  	bool cookie;
> +	int r;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
> @@ -79,21 +80,26 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	cookie = dma_fence_begin_signalling();
>  
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> -	amdgpu_userq_evict(uq_mgr);
> +	r = amdgpu_userq_evict(uq_mgr);
>  
>  	/*
>  	 * Signaling the eviction fence must be done while holding the
>  	 * userq_mutex. Otherwise we won't resume the queues before issuing the
>  	 * next fence.
>  	 */
> -	dma_fence_signal(ev_fence);
> +	if (!r)
> +		dma_fence_signal(ev_fence);
>  	dma_fence_end_signalling(cookie);
>  	dma_fence_put(ev_fence);
>  
> -	if (!evf_mgr->shutdown)
> +	if (!r && !evf_mgr->shutdown)
>  		schedule_delayed_work(&uq_mgr->resume_work, 0);
>  
>  	mutex_unlock(&uq_mgr->userq_mutex);
> +
> +	if (r)
> +		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
> +					     &uq_mgr->reset_work);
>  }
>  
>  int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3fe91fdafe55..5fef0cc7703c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1308,13 +1308,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  			ret = r;
>  	}
>  
> -	if (ret) {
> +	if (ret)
>  		drm_file_err(uq_mgr->file,
>  			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
> -		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
> -					     &uq_mgr->reset_work);
> -		flush_work(&uq_mgr->reset_work);
> -	}
>  	return ret;
>  }
>  
> @@ -1334,10 +1330,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	}
>  }
>  
> -void
> +int
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	amdgpu_userq_evict_all(uq_mgr);
> +	return amdgpu_userq_evict_all(uq_mgr);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..4dcf6151de6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>  
>  void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
> -void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
> +int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>  				  struct amdgpu_eviction_fence_mgr *evf_mgr);

