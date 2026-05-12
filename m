Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE9CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC44E10E26A;
	Tue, 12 May 2026 08:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p/GiIbrb";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5716F10E26A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2uM6ykLp+4zo9to3JYfMbXywPel6YCrZ52oIpc1wQqWPg2FWAH48CeepPz5vtmoxEqH5+8BnVKVJO/L+3lbXiPhIPKWPNGzFYLL7R1p/jXTdQRc204/WACsLHomNDyXVvvGZqeT6SBiBVr81CKCMs2YyOSUbu2DWJF1KEKy1e2gUCeTOzjC7NCqarCv4nVdg9k//08XRg5ptqQ3WDrf5Ivlwyg5Br7tc8R3Ve7RerL9ynmQYpuCLwmpMvoRsGuxjgP6FNCbiw/h4rOnmv12nGff6W9VeIN2vJq6HNiDXHpTLWtsxQVesh6VZUcyTuVA94bsYjYCbnA3Oi/s8kMJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85WS+AxzSWG7aqrBHw3JKIF2C9vJBLJ4xl/UOFfh0ZQ=;
 b=wm/i43z1/bUyqgfNStjWyc7PZ9iCzX1YD1MDYkUzUYCQbx5tnBOEj2ONzHzTPnoUUdvI6SXcugnQ0TJ5qT14xZPyzWtjScNoKq5Myippj+BaxNswtTivPwcOu/l5T6ceT607G1+WN1URbBeEEi3w+/liytNrgVa/M33UmThzkH+5i8Uj6LEVP5b03K4/yjVTPWGpvcKoYwUny96m97U9GMFB6jevnR+fMd61CmpBozvTJ3wneBLggcalznqeKJSdyP10JHb4tVg0HBnWaoInv7cwKZmJlPbUVbmtaCmKL76Ro7YbPpla6Ud1pkVn4uMDY6HG5e1+ywaLbOfq6u29zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85WS+AxzSWG7aqrBHw3JKIF2C9vJBLJ4xl/UOFfh0ZQ=;
 b=p/GiIbrbP9yJ4pGOs8OxiZRVutR0OfzO6rcdK1m7SIGtEGMiUVIWkLvXLi02c8KbOcE2vxznw7zUl0xjdxqrAbQzpoMiZZG05JFYb8Wf3Yv3DKISgCFATnuvRyQcXLONZVrMLltMFFnQptakp3mv4E0QOuyJ8fzJeFlYthEnatY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 08:22:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 08:22:48 +0000
Message-ID: <d16f309d-27fd-4f50-8e56-3839501a1196@amd.com>
Date: Tue, 12 May 2026 10:22:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: make sure only one reset work thread
 runs at a time
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260512070444.405424-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512070444.405424-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: fb13fc93-2b2c-474f-f4de-08deafffa66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: OLh2k9wQQ77jVLk9suchNjY7SVDbru9zWCKY1nO9xrhbroJ29SoED7JCTay5DEUe6lamRPO7+uKaXKJv//Sljm38UmwDg2vStNH3FcmFHId0d5CeOnJdEa+ujy5OQzXiLc4w0SWsNqGuqiqiLOdWwNFLKHmeCFm5VZd9ANrZq0piqZUjx8e9A58FSeJs12m67FJorxVbVMejH7jAhExdULeVeR+B7zijsEBRxOobnh5iQ5nLvAMGInfdhSBJQuVRnpjRo7IadQTvVkp1YcFWWMndid5t7Y/CqWlprJoGzw0VlbD3MuTay/bPWNCir7IiXnI8nt49BkM9wrnfua9HlLakc74WVe3Pmw4v18MzCYUULI71OJ0OgWETyhErhUcS68tQFlupjOUthgYYJkFUDufqI5vO7IlprFDKcRIxZHVoqktB1VN+ICrkpRvpHYiYDT+r6F4qs1TlGY+YWErwRE8dFIhLsAE2nWo79NGCf9cTvi6WErHlbuPKUTCnZZ6G9kzUnP0CyO0bZWFo2C5Us1xNwk/chzcK1uzLn9IxNFdfVPqnucW1EPnA1iZukRri7lyk/mQdEZsTaeM9glCPabAQfoD2PwndMXJaN96Q4I9yhu26kfDHo5t36mWp7EfBmXJGWaikwTGecPzsR8G20b6InWdYTQKqQuHEZOhyzVX3fAM4cMS7bsJd7PI3nN14
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRDN2FjOG16MzlYc2JNa2FNbDFsVzBqSUNrN2x2K2tvSHliWVBHenZ0dHpr?=
 =?utf-8?B?YkV5OHRva3FxQWtzUkxTdDZETVF0SENwTFdveEJUVnFmWUhuVDczcTVMRXQ5?=
 =?utf-8?B?MDNDWVhxUk1SdWIvOEhIOXdyekE4T1gwMWVUWDNBeVdOUUtSWmhTT0cxNk5Y?=
 =?utf-8?B?Uys3ZUJpY3hWMjhWS1BrOTc3bnBRS1pLNmRnWU56d1pzdm1FQXpZTUxzcnlz?=
 =?utf-8?B?UENjYzQzL2wwNThPdVd0TmQwYkhXMWdnNEY4RlRaRmdkRm9xV2JwVkQ3OWdp?=
 =?utf-8?B?bWl0VDcwVVBnVm9adndOTDJqa3lhbjZrQkd4RnBHNnk0YmxzdkJERmhnSy9Q?=
 =?utf-8?B?ZlBYcEpCV0xsb3JhU3NJcUU0Tkc5V1ZYakJRd0pBMzN2MVQ1UHNwRjZBbDRB?=
 =?utf-8?B?Z0FtZXJFSVdmdXlaTE1CK2tER0tZaDQyTzExU1BpSGFtR09FUDRsWlFPN3Zp?=
 =?utf-8?B?a2QwOUhxb1M1V0QvMmlMc0o3UkdKelZlYnpzTW1idmZQNG5JZFNLU0ZzNzQ5?=
 =?utf-8?B?T3Z2NGtlK3NyQ1p3WktIT2tJQmtITDN1NnZHdWxrLzhmSzBYUW9DWjYyVmRC?=
 =?utf-8?B?MDFQSTdMQ2pXMmhqN0Q3UnpoQUllRHgrcVlMemdFcXhrempJaHBua01oZm1B?=
 =?utf-8?B?WXJtTUdZRVEvcHhDYU9qeHJyRHBxcG9uYTgxRW1SZkJvMW15N2Q4REZsWGgz?=
 =?utf-8?B?RzRBS1dMQ3ZNZWVlM01kMm16UWNZTE1GeC9UYWZQSWtxN1Fqc3JMRFVueDFs?=
 =?utf-8?B?dkdESUZwaEp4aDRROGQycEF4N3F1OXcyMjdpN1Nnek1oQ0Z1UnhzSW1OQWF0?=
 =?utf-8?B?WExMY2lDQnNWTHduaTBsejFTR3MzM0FpQVFDbnRZSWs0YnZ5cG1RajVxdUpI?=
 =?utf-8?B?UGdmTXkxYWVCYzlmZmpXRmdGbTJ3ZGFFZExhakV1b1E4c0FjT2dvZEVVS0xS?=
 =?utf-8?B?U0tWaVIxelRSMkdvR29lWHBCWVNYdXVLNlMvYk9HN1lDTzh4MFc1dkVNbHhM?=
 =?utf-8?B?NnpCTVkxWlBlY21WS1N6ZWk3QzB1ajRyb1hpYWgyZDIvbU1pK20rK0pleExH?=
 =?utf-8?B?Tm84T0lRQmhGa29HZGpIb0kwYk5aY1UxVFR4UTBFRnFZN0U4QWtLUHBqKzdk?=
 =?utf-8?B?YXNnYXJud3QrL1RzejhqTmo2T3F1Y1lDUUphK1B4Vmt2c1JMVzk0T0lKVy9p?=
 =?utf-8?B?dDY1WTBYcmZ4NTdkMmNyU0diTGhJSE9WOUk4ZHpCR2ZjRmJ6YkUwRlR5UlZx?=
 =?utf-8?B?eXhvWmxaZHlZdFR3MnFOQURKZUUxTDQzdmdTck00bU5MbTA5U2FuOXBVVk4r?=
 =?utf-8?B?QnlBSTZGZk9jNTJYMTIvbkw1TzdDejlxbCtLcUJLcDM0TEE5SjZnWlppelM4?=
 =?utf-8?B?WmEzQWdrTlprS21tRW1YWm5lZjlwZkxWbjA3R2p1cEZ3ZUswUDM4OVpMSFBi?=
 =?utf-8?B?bzlDQ0NhZ1VBR2NrQ2lTT0c1R2Zid3FoN3o1dCtWbTRYZTZVaGpHM1FWMDI5?=
 =?utf-8?B?T3hKNE15ckJ1aERnV1hrckwyTFk5MUxiekMwL0xyL3VjUStmTHFBaHFEam1n?=
 =?utf-8?B?djZvMXVTN2wwcFlaOEd3ZlBxS3Y0ZlY1N3NoaDhkaVcwMzRZZyt1d202elds?=
 =?utf-8?B?cnJpMVZzSkc3YjVQa1FOUG1DeGtyRTBGbG9MTnJDNEZlSTBmMEVBb3AyZGcw?=
 =?utf-8?B?aUdXZ0hGWVljbVNjdm1tVHF2eGN3UDR1VHU4cmFrd3Nkek02bUplUVJkbGtH?=
 =?utf-8?B?Y2Ivdm0yemtWalVybWJHWkdUL21HY254aE9GRkRJRjhMY3ZJTU5RMTRDT3pD?=
 =?utf-8?B?OEgwdGVRWWt3akQ1YXQyMzBBWE4wV2V5Unh2V3RCUVBzN3E3VEZlZUN6WU5D?=
 =?utf-8?B?djIyQzhIL1lybUtySjhMMWZRazNDaXcwV3RXTEdPdFF0QVpXODN2aXZiL3pj?=
 =?utf-8?B?N0lLbis1bmJaRFRIb2ovOGkvQ09Rc3dadS9FenJnOUFiWnZmQk0vYUdraUlV?=
 =?utf-8?B?Rk5kU0k3R0tYdzV1aU14c25nRVhUMmNibVdJTW9kZFFhWVVzcWRJRGxTS2hk?=
 =?utf-8?B?Q2lrZ0FER3RWQjYzQ3ZiMnlVKy83L2lMQVJEWnVIaXdWNnE2VVZleUtKSEh6?=
 =?utf-8?B?Q3B2OEJKMEdKUTV4UjZCZ2cxT3VzeXZVdVBCZ1U1dEIySEFSdFYvbkFYWEJD?=
 =?utf-8?B?U0MwWkMzSUdyY1ZiUmVoZHgwUFZFbjV0RGxabFBocldCcFlsYWFCMzNSaG1x?=
 =?utf-8?B?ajltRFVsU1k1V0MrQzlBM0QydU9rZ0NCL0xOZW5jL3IvaXlIVGNsM0JPMi9h?=
 =?utf-8?Q?eRJYDaQ+e/aLDIv3Lm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb13fc93-2b2c-474f-f4de-08deafffa66f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:22:47.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F62ex1wqucUjNyrBo0/qJoFkSlDAXbNO/vxPu6Lm0zbcO0n+f+7OQgMt7b5nFFtV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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

On 5/12/26 09:04, Sunil Khatri wrote:
> CPU0:   hang_detect_work → directly calls reset_work()
> CPU1:   evict_all → queues reset_work (via workqueue)
> 
> There is a possibility of two reset thread running at same time.
> To avoid that we add a per queue manager flag to avoid duplication.

Clear NAK, that doesn't make sense.

All reset work must run on a single threaded reset queue, so only one work at a time can run.

If multiple reset sources trigger at the same time (which is quite common) then the ones handled by a reset are canceled as soon as the reset is completed.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 0a1fc45f5b4e..1440f51b667f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -109,6 +109,19 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>  	if (!amdgpu_gpu_recovery)
>  		return;
>  
> +	/*
> +	 * Prevent concurrent/duplicate reset executions. Both hang_detect_work
> +	 * (direct call) and evict_all (via schedule+flush_work) can invoke this
> +	 * function simultaneously. Use an atomic test-and-set so only the first
> +	 * caller proceeds; the second exits early.
> +	 *
> +	 * Note: amdgpu_in_reset() cannot be used here because in_gpu_reset is
> +	 * only set deep inside amdgpu_device_gpu_recover(), well after we've
> +	 * already entered this function.
> +	 */
> +	if (atomic_cmpxchg(&uq_mgr->reset_in_progress, 0, 1) != 0)
> +		return;
> +
>  	/*
>  	 * Iterate through all queue types to detect and reset problematic queues
>  	 * Process each queue type in the defined order
> @@ -145,6 +158,8 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>  
>  		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>  	}
> +
> +	atomic_set(&uq_mgr->reset_in_progress, 0);
>  }
>  
>  static void amdgpu_userq_hang_detect_work(struct work_struct *work)
> @@ -1304,6 +1319,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *f
>  
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	INIT_WORK(&userq_mgr->reset_work, amdgpu_userq_mgr_reset_work);
> +	atomic_set(&userq_mgr->reset_in_progress, 0);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 49b33e2d6932..2748ecc0f6c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -129,6 +129,7 @@ struct amdgpu_userq_mgr {
>  	 * Reset work which is used when eviction fails.
>  	 */
>  	struct work_struct		reset_work;
> +	atomic_t			reset_in_progress;
>  	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
>  };
>  

