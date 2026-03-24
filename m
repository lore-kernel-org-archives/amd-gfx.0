Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D80F54ACD
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 15:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7FC10E67A;
	Tue, 24 Mar 2026 15:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hWB84jV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B8510E67A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 15:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkC0QeCkiL/OhYrQNK0r2XWd7WI8IZ+75wuJRxfXRgeOedvVDX9u+6FVyzDHWsuXWQs7vNJRMOiMpYvW+c0ySPfC5FkZDc7flnDA94e6fgZTdJ8oE983GULaPxvLlyEdbwZNfDBwpyNtmksYGNilbvtTILh0+9pMCOXE86ic+ySnuNVuCUzoUUHa3PLbYp+pALeE4P7/hXjPPS6S/vqSRlnVo5tT46gRqlCHIlIPy1RSToKjScrEbtu1sIeVN9PTuk3SdOOdLLr/htapMpkIcd+KcPl2M1m/O+sqw/mOdEMvBhqSeBp+p1VcP9QtWiSkpMb0fSnWCjZWhZmXVLR0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfOER6Qm2KhZWjxmMFumMxPIemN1mOVHdRvpedDdDko=;
 b=jt1VTdYm77YIMWpINvt4aeEOeXvwOOwGTIhvnsgucJDShOlNEYbv3hpMp/HPPMowNFAOF2IZU6bLG4G3cF+CpDMr6g2k7ksMJm53eYey5v5GVtQCNfev3ZYkIjMFA47b+ThpDyjLxGAAKqru02j67zUB8+gsAaX0AtfAKlhVf4M0mgj5xq83JnlKIBLkYcqpyKHLkG2N7aptKo4J2cUJqWDoCmbK15k55NlDvjHRZl9F0LpHT6pn8KMD63yU6+rFe8+b2xqQ27IkW6rRSU8Iw/FC3QaMErnOQ9RBAAlvw82QvJrJtpJAgdg3T97oLFpJGNK8uXoFLF7wYoP5AhvNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfOER6Qm2KhZWjxmMFumMxPIemN1mOVHdRvpedDdDko=;
 b=5hWB84jVBlXyHIZPKbkmDF3Fjrddx7Jck4t0WZrf7wsirYyumHjB5HlrQG/yLjUP7cw1Oa4cTXbxgimLt9gwDEs0trlG+/QqqmQ94+lvZ/mXAfYpaNMi3oP3cbgv0xvWCG96KEXuD6Sc3ny7ezsQ6XJychQqINwwL7NwAzU9lds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:32:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:32:14 +0000
Message-ID: <cb1f4eca-a631-4ccd-b661-892d75c387b3@amd.com>
Date: Tue, 24 Mar 2026 16:32:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu/userq: schedule_delayed_work should be
 after fence signalled
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260324152514.1419906-1-sunil.khatri@amd.com>
 <20260324152514.1419906-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324152514.1419906-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 706e52b2-c1b7-48aa-48c7-08de89ba85ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 1KZ5e1uoa9rDtLi0yFu5yUO30Ai88W+WO12OBVRixY9Me47THhT8ULeSyCWMAcANvaghOon7pb609P/iSoT0pvK4aJbrpPuvK/FiTqH7uojmqVEaDcn8X/nw4a7M5Agy/ZFRyvTC3K3ui0FE7UFPv8/NGMOzvRGOth9xPddROiE1mtq8cuQg504Sqqc+yKg/nrs7Tru56p1rg2eZm00D7bVJPAo1MV7FaNpeelHl99nyo5Dd9KFBoqomA+VR7y3Rrv0wQ1A1x5VT18XZIVcno+ZyKMCFB2kxgMtpk7zcPrh13SSr7pCJ32BgT+YpkuV8VFqmmiIIXcGB2yQTeQBXXUNmQ4Dsu780fgiXiyBGmpU0nGa7IOfbM25yH+4ugX7r2x5qeccxH7RePYD7P+ErT9aHEFSR2W0U3fHKhhTplwCSr8+lKZhikNbJE/lny1xcY8EZZK+0gBNCyEJ/xDEoX9g+wYPxPswBHxBgZpwOsc/xtQtU7PDytqaN+avTvps8srpz/UJ9m0Gslq880U6B2FlRnHs9H4utF4C8EeV4UuTzPWthz5ShOy5CvfEUpZeFtulrsqUXh6vkVI+Z41GHGhxEFG/8o+MP86gYIO1LxHg5NL3p/RTrUo2JYfp2pqscI0A1e7vAJx0iNRkDyOvqd99L6ZJzKHzSH1ZzuCV8R//PDhxSxkWmhf1a5HoN9yZvXWn0KZKVKoN8bggKn2t+qs9DiVY+TINgAaJVs53TF4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGp5VEtHVElPcThmRHByQjl5TGp6ekJOTmFwLzlWSHRjWmR0QkJvSHB3QmN3?=
 =?utf-8?B?N2F0Wnk5Rm5VdzdoakJ0M1NNdVlacmFybDE1cHFiYlVlYXVoaXhCWFZsQlUr?=
 =?utf-8?B?bW9yUVZNdGViVWJmSjdLbGdmd0w5bU9PZHg5MGU0RTREVFRiWEI2TlF1OVR6?=
 =?utf-8?B?dERkV1Z1OEJCWFltNEFUMUdCM21hb01MYlRDYWJMM0JvQ0lVa0t1eTY3Ukd0?=
 =?utf-8?B?aHVPbDlyQ05ONUxNZENFcDlGeWYvK2xtRlpPbERSSHE4aWY4cmV5UUJac0NW?=
 =?utf-8?B?a3hyRkRqN1VTL1NoZU5BYURuWFdPTUpWMzFoMGpqWmc3akhJamFHOTlZYkF1?=
 =?utf-8?B?UDBFK2wvZmNiYy9jYnhoM3dEQXFQNXU4cXU1YnRaMCs4a3JxdU04ejJPWHkr?=
 =?utf-8?B?cjJGaWswUlFtOHErMW1NRUl3UDFOVlVyRXAwSldkWWpEWTc0OEcxanQ0YnU5?=
 =?utf-8?B?TFJ4dDg5NXppTHVQWlFFL29xYUtldjdtcGlVMnBHbHU5TFp5VHNmNE5naHAz?=
 =?utf-8?B?N0Fla3Q1d2xZbFdWdGdVN1ZTZkh2QXJOSjRXcDJLQVFSUDhnWFFGOFJvblZ5?=
 =?utf-8?B?V2FKeXJZOWlEelNZaUtQQ0VGRFFEN1pBY2FKTnJGb3h4aTVBSHdQaWwrMFdE?=
 =?utf-8?B?WDRjTnQrUWZaWWF5M1VUQmlXMUhlR3IrZnBGN3pveDJ6MWV5V1lvdGpNVE5Y?=
 =?utf-8?B?QUtmejZhMU1Ud3k3b0VxUE5ZeFB1SjB4dXpLTG1oaW1LZXovUy9VSE52c09L?=
 =?utf-8?B?WTRyemFRRHhnYS9IdXA4TWNObWNyZ2kyZzloOHlacWlMQlh4dG5nZFhEUERr?=
 =?utf-8?B?cTl2bElZNXNDUDV0cDVxdXgxb2tBUmVuTU40ZjlKZmpLR3FZRzdBT2M1RllE?=
 =?utf-8?B?L3JmdlgyYnJvRDFvS0tpTUV0eVdSeHRnMHBDVTBTNkFuZFo1eWdrd3pmbGh2?=
 =?utf-8?B?YTc2QUdRcWFkMTZISTc1bjdYTDZkVHBsWE9kbnVtWU9sVmFPdkUwUTJWb294?=
 =?utf-8?B?ZUhraVFkb2Ryb0FtU1NOZW9EYmZ0MFNOWHU4RHJCd3ZhRmdjK0QzTDY2eW1a?=
 =?utf-8?B?bFcvZE4xRWZCbDVmTVZmUXBQUHNhTmV6SnZaOFpaWVJDZVlMU1BodzJjYkxv?=
 =?utf-8?B?K296cFl6NXhUNmJOaVNGR3pHR0NCVXU3clRNWVlBK2xISnlGa1lOZmpSRHR5?=
 =?utf-8?B?ZWxOVk94WWhOaWlTYkNrZW5mdzBsL091c2ZFazBLbUV2TEpOMmJTNW9lQ1pi?=
 =?utf-8?B?MFFxMENSU0o3Ymx3R0xjOWkyK1ArY1Z5OFBLSzhjeEJYbmFDR0xrclhyTGZQ?=
 =?utf-8?B?NktEeVpROU4yTE9lZ1h1RXNSOWxnOENUYXF3RGY3S0d5ZXp0cm5vVld0OUNr?=
 =?utf-8?B?Ykdhek1UKzQ2dERHSDRna3lWQ3BkY1FnOGVGbk9tNkpSMjF5MVoxbjQ4Ujhy?=
 =?utf-8?B?Zy9sZDRpSmJEYjdGN0p2ZW5iWjhyUlNvS2hLMWVoL0FLMGFCQzRPd3V0U0Q0?=
 =?utf-8?B?TlhMVGtFcHB4aEVUL0Izc2FhcG0yUGlSenFXaWExenFqVkNRQTVKbWNWUEp5?=
 =?utf-8?B?TThuUUYwcHZRdXlPZFc0UHhGTllsY2tzZ2tjbjRoWlZPbFJxdG5GbXFzOWNN?=
 =?utf-8?B?amNjNHI1cmdld1JGQWdoeHo0bFV6ZUlHcXBQTHMySUNVZ2EvTTVTdGJHQmRl?=
 =?utf-8?B?ZGZmMk5PdDA4bVRsWm85UmxHZEI4Qm43SEEwWVhXWDBCQUNaUER4TFZYOUlI?=
 =?utf-8?B?M3VrRE84RHNlUGFoTlQ4MEZoRXBJanBrM212cndPY1A2TlFmZ3JhbG56dlRV?=
 =?utf-8?B?NllYWU0yN0xNTDNZV2tiRVVHNkQ4aUNDZEJLVWxuZkxmNzVmRjJuZ0Q2L2VG?=
 =?utf-8?B?bUNXb3VMRVJ6TzNqeXYrY1BRSTJQbDZ3dlVuMlZvUlFPNWU4MVdrMG43OXIv?=
 =?utf-8?B?WVpPTVNJS3oyVUVacDU0aEJMWk9oR3VpSmFqOGRNcDE2UWpRQlhNb2Zwb09P?=
 =?utf-8?B?TnAyYjdDc3c1K3hLQnpSVTlVVm1QMURBUm0zNTRzUWZEV3NsVm13cWVCQ2tY?=
 =?utf-8?B?RjNCZ1FiQ2pDU3Z6THFzSEVmdTNIVHF3dE9oWEt6K054dVE2OVBjMEJFTVlO?=
 =?utf-8?B?b0pzRHFRYnR2aXNDK1NIU3lpVzNNZXJIWGRLbC9IRlFBeDg0YzRSV0xnVEdU?=
 =?utf-8?B?bmJzTkZVT2hDeUQ2RGhpM2ZFR1NQbGgvelN4NlZtcmRvWEVtNDg2T3Y1WDhC?=
 =?utf-8?B?RDR0b28wSi82NURtWlZWNFI0TE03MXc5ZEJkK2w5U3VEMW5OaXk3dDR1d3Rv?=
 =?utf-8?Q?kjmk56dlnpZaGtGnN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706e52b2-c1b7-48aa-48c7-08de89ba85ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:32:13.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tReSvO27mE7ABVoEjUnWIzYEgAc706jhwbRCna212PsdCOQaFPWC7vYgzsvJiaix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

On 3/24/26 16:25, Sunil Khatri wrote:
> Reorganise the amdgpu_eviction_fence_suspend_worker code so
> schedule_delayed_work is the last thing we do after amdgpu_userq_evict
> is complete and the eviction fence is signalled.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

But please re-order the patches, this one here should come first.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 6 +++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          | 3 +--
>  3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 641d03ef8608..5ae477c49a53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -76,7 +76,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	cookie = dma_fence_begin_signalling();
>  
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> -	amdgpu_userq_evict(uq_mgr, !evf_mgr->shutdown);
> +	amdgpu_userq_evict(uq_mgr);
>  
>  	/*
>  	 * Signaling the eviction fence must be done while holding the
> @@ -86,6 +86,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	dma_fence_signal(ev_fence);
>  	dma_fence_end_signalling(cookie);
>  	dma_fence_put(ev_fence);
> +
> +	if (!evf_mgr->shutdown)
> +		schedule_delayed_work(&uq_mgr->resume_work, 0);
> +
>  	mutex_unlock(&uq_mgr->userq_mutex);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 85c6a2256c4a..f312afae0e88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1298,7 +1298,7 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  }
>  
>  void
> -amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
> +amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	int ret;
> @@ -1312,8 +1312,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr, bool schedule_resume)
>  	if (ret)
>  		dev_err(adev->dev, "Failed to evict userqueue\n");
>  
> -	if (schedule_resume)
> -		schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index f0abc16d02cc..a4d44abf24fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -133,8 +133,7 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
>  void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>  				 struct amdgpu_userq_obj *userq_obj);
>  
> -void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
> -			bool schedule_resume);
> +void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>  				  struct amdgpu_eviction_fence_mgr *evf_mgr);

