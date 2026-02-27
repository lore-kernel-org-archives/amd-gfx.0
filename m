Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D1FD531A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967F110E11D;
	Fri, 27 Feb 2026 09:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xssojb7I";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 051BB10E11D
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 09:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtT1Gbn1kMIR8skVJ/8nJlhWsMSOrtZfaKZ4fO0OW+qsmLiN4ryOsEQjg8TLhmpLf5gQyMMh5qgowhTKMD/fxJjKBp9F/BKK6EmL0jWsRaC04pQedpxeyEEuH5XWf6AoxgbMM2wfRmm12+ywgcGKGiNppVBxTZ8SGQxC6TrQZugJl/rv961LW/yx1n9O1OovajXovVuIO78e6UGVSLsUciX6YIunbZhHRVBa/5MY2vbtZ6fMHzb8WlAPALQnkhLS0e+NRk7e6id+khEfTFNNb5n0nV0GtNZb7TScBEWYheVnvjhTxDa7bpj4+aSWJnAqROK6Wmplu+/DacHRKFCmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VasRj3dgGM0WEHEvpzVQ+TnMwCc9V++utvlAtm/P0Og=;
 b=WWvjU7UKyk0jgsGoB3iconA+oFBS636BuTVDzDFgNiWECG53vZfP6KvU6ufHS9vZHguejJZ5rX/pgQClJy7EYGXmNZ34EqR3JK4XGG4CkXH06P3rB2wK2XKGhvsmkRcYinKxwacQwa1Th+nueoq61fFvZETsEKGncMqAz4grEU2ADS1S+UGUtEr5ofYaw8PUg//VqW1/8bFhn1kyDilA5QON+VAwS7DxZFrtE0pAN4ArutSWesidHUABOKHb0ivv30qUnUsFmwOfpft5PIjhcc87D6AdmeMKhGyQS4Me2XgjKtuATwBJHnVhmffKrFXtRgr+xbFxjlhpnCiks1SkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VasRj3dgGM0WEHEvpzVQ+TnMwCc9V++utvlAtm/P0Og=;
 b=xssojb7IDCzM+DTCI+dMrOmNV93qh+GjAb/f6Pmek540qsAdBlVuuh6bvtlKhqhtTevvUnV8XrffHRf95VuJWhQpIovbcYZOd6/ZRDD1sJWICl8CZrci7SIeZdKV5cORsiYTL9APIrpBzUbQJTMGpNh5n53pqlXISOUYnVlrUFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 09:22:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 09:22:10 +0000
Message-ID: <a871d9b0-0317-42a3-89b4-a7d766fa6d53@amd.com>
Date: Fri, 27 Feb 2026 10:22:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: Remove impossible NULL check from
 amdgpu_userq_signal_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20260226154918.84354-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260226154918.84354-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0046.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fa9002-9569-4591-d3e9-08de75e1af0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: Zt4cbcehaqMO/Yk46Gr0+tUO9gpPD79Kiaiw7QLNEqMUV9Jp9j4AV88FSWXgrAolqSM9Ha2O88LEJMyxzmAnPBtzwjItNUk185HXNxcabc7VFeDlT1ZR9O06KU/68Ea0g6wEeRyrDTTUIyBad7RFVpequHZ4mkl4zO8RQ23C7hVDn8Ef9CHtmpIxRIHV2jHFV0EndXolCepe5z4ayICthof8P4hVoN4BVV4jcSNzMBHxt7E97dGwBmlbO3f1tqN64VwB35J/SX/xuFWCw1LRGwUmi798vk384ubskm74bYrmawqGspZAU+5oepVAL5QHguD90FAb0QDLFpkik0FNPrQ7mU1Lyd+K795z48XJr4ly94xFofmZ1vVJknScLcFlmR3jfgP5+FKlRQclheD0VFMmrk7l8sY9u1uB2zeUXTJOtYFlCl1ij3aP4zfw38pWvhH65wcaVEcEK3uxLZqPmD64LKvKpInCcbZzLHqL8fx/atUZHOD4sapXKXuhn7mZI36hC5ttfFXRbtXLnyWIT/7Q4w/6V63YEoPUVg/snndIzQowGFmJXzleG1EoMHTtuNoa5ZKlpJHd161MNAM4j9iCFqX6VUkkAq31O0HLsrbipJC754jRmShrQwvg0x1EMfcSJTXL5Ax8QIP34CmSLzbPphHOoMf3PLaWqsBblv0HCL73yzGJIbhiW28M5hK3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzVXd1pYK2JFRWI5cFBYOUJreFdLY1NGVFhKRGdHSmhIejlyU2dkaGN2WkE4?=
 =?utf-8?B?WXo4MStFV3ZIN3ZML2xIK0ZwcllNK0pNckVIOUgyMnJMWkFQNDFLaEVtdEtB?=
 =?utf-8?B?U0pqWHBGZWo2UWxXajh5ZjlLRURLaHhIOXRzNHBUNWRWMWdyS3JDeG5xUEI1?=
 =?utf-8?B?MGdiSS8ybHBrbHU5TDZLQW5wQWYyaFY1dVBlK2ZOUGdMbnlJc21JVWtYL1RZ?=
 =?utf-8?B?VEdhQThOVlpMUzROekY0ekVHa0pxQkVPL2lWU1c3QjhGTzg2eUFSaGl6d0Fq?=
 =?utf-8?B?TnJOa1ZVVmE4L3hmQ2hyUWpVMTJnQnVBd2RjM0o0YnRkY3crWHVDLzhYaUpT?=
 =?utf-8?B?RGQ4Q1EvaC9SUDFHbVlLa01STEVsYlBEZ3owbTJMbkpVcnJDZEE4Sksvd1NU?=
 =?utf-8?B?dndobE1ZbVhJOWZuNDFvck4zS2lvc2YvV3JmcVIzK3QvTVJld2hoTy9vSUJp?=
 =?utf-8?B?Q1dnU1Fvc1pnMkE1YnFzUEZBQ0w0Zm9rMWRFSTBVN093MzRxd0R0T3dwaXhk?=
 =?utf-8?B?d2JXdUV2UFZ3cmw1TEU3dDRIcnlSYzEwOXFhTmk4dXRkV3pzZEJvNlB6by9O?=
 =?utf-8?B?RGxLYit1bkJFbnRFWWsxTStpbzhqb21HOEZnbms3cWorVm5OZi9WZzJscGhY?=
 =?utf-8?B?bmhuQ2tXS1B4ejdXdExIOG1PMm9HaXdLZWh0dDNUZDJDcE1oUTc5R1ROejF5?=
 =?utf-8?B?TmJ3LzB4M1orSUo2NzNYQU1sSTl0R3R6aGhySzF2RGpKM29aTmhTNVVaMlpl?=
 =?utf-8?B?TjBZdEtaZjlZblVVSG42WDFkQ21pTlJWMVl6UXBwOVMvbDYvbWMweDlYNUlW?=
 =?utf-8?B?OWNlSjNEQzJCYW1hNXpFN3JYYUtZblZNcDNOVmJReDBVMFM3b0Q3VGJteDNl?=
 =?utf-8?B?cytDbERxNEFUMWRkTHZnc0puZUVJUzAzYW84b2MzV1h2NWYxTGl1ODRMOE8x?=
 =?utf-8?B?bkxhaml1elNtd3FwY0MvQkM1SlQ0dTNlRWxCb01MMHEwYWRERmJINFE2Vkhx?=
 =?utf-8?B?TTd6Zmh0S3kyc1pHM1kvaFBTOFNrZSs4MU5YWGZXdkpsM0pLbGRqUG5nK0tJ?=
 =?utf-8?B?cklkckpXSjl0YUd1NGN6b2V6cStRR0ZGa3I2OU9UazdCcmNRZEMvclZRdFhU?=
 =?utf-8?B?VWx3ZHE3eWxWUjUzUUR4VWt0cFNlRDdWc1gyUUxwcXUzcnA4WHhNckxQdlpO?=
 =?utf-8?B?NVR6dTh4NnJROTYrNGEwemJJdGxSditzK0ZFRVlHQ1RwRUxaV1RuaUErSko5?=
 =?utf-8?B?QTlPQ2I1MHVpdkUya1dSQWVMNlNLcjArODVZVkhNWStwZWgrc3FsUzlKL0th?=
 =?utf-8?B?Q0o2Y1ZMUkUwUjkzWmhQV25JZkIzZkpnK0pjZ2lmdjFLK1RuUkRrY2JvdG5v?=
 =?utf-8?B?MnBuZnBvVnV2WE8vOE5RWmpzUjY2UnBnWlp2OFQyUXNaeTdyTWtqT1A1a2t5?=
 =?utf-8?B?WmxXOE56aEd6Z0ErQ3h5aUNnb3BtaGFRTnQ4N3F2VlVvU0hpNXE2UGZjblNt?=
 =?utf-8?B?eXY1eXZzUW9BWVRUeFpFczJNNlN4SHRtajdxSnh2ck1LWk1WY3YyeEhwQno3?=
 =?utf-8?B?ZS9TQW9SRnJlM0puc1dZU2JLd2JqK2J2TzNTK1pNQXN5bi9rOGpwZDZ1RlV0?=
 =?utf-8?B?NHhnNkw2L2FzK3FhRlppNkpXWkg2UzAyZE0raXo0ZzlnR3JWSnVobHVGeGxU?=
 =?utf-8?B?c3RuQk93WUpWbmlNeUp5TU05T29sNjVCWUFMNDR2dTN4bFQ3ZW5RNHF3TDdK?=
 =?utf-8?B?V3BLR0tHRERyZjJDM1drVGgzRTE5OGlIcTV5ZzczbS9WTGs5R0R2TjJVYmlp?=
 =?utf-8?B?anV1dXdNSG5ETXgwSjFMVitOaEwzY1ZCOEFwWmxweFN3QWhPYWJ6NFVLVkpu?=
 =?utf-8?B?TWJROEJwSUxrV2ZJWEF4S3NXYjcxWHdZU25GSmR6TFRLMmZDSzdwWHRsb25U?=
 =?utf-8?B?TUF4WUZuL3ZRc3BzM3JqMWh6WTdTU2FzcGVVeDhveUpVbWg3emJWeUFGNFRn?=
 =?utf-8?B?d2tUdGhTdmZHRWlCWHUzTW9vSmk2dllHM3ZiSVdJU3RCbFJjMjI4Zm0yckZB?=
 =?utf-8?B?REw3VWVYOTJCcUNtMEpiV0pFeHpQUStJRG9rd083Wm9VOWFyajhUL0duNG5n?=
 =?utf-8?B?RWNLWnpGWHJScWVhc3p2Yk9Md3YzR1YwYm9CVGNFU3kzV3dsTGo2ZUlYbjlN?=
 =?utf-8?B?LzMxUmtmR2F4VjZZK3NwWGswQnQwMXMvT1JHdDNMMFl3NHdmTHFwMnlIaEEw?=
 =?utf-8?B?b1VPU2xnVGRnbnpoN3BIVVVpZElhUFJFRGJJVnYyRENHTE1pM3praXRBK1FO?=
 =?utf-8?Q?jm/GFHiRDlbrnA5k8p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fa9002-9569-4591-d3e9-08de75e1af0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:22:10.0919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9yohhK1VkP2lyxOKdErZPd3DL+ZcZXA4lraP9gaqL6st1RjpZP+hbAKMKFMMyyo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713
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

On 2/26/26 16:49, Tvrtko Ursulin wrote:
> LKP reports two suspicious NULL pointer checks, triggered by
> 4ca06f6fb45d ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
> but these checks were redundant even before. Remove them.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602262219.UY2pqzl2-lkp@intel.com/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index ba128b2a2d49..0f941021fcf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -548,7 +548,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	for (i = 0; i < num_read_bo_handles; i++) {
> -		if (!gobj_read || !gobj_read[i]->resv)
> +		if (!gobj_read[i]->resv)
>  			continue;

The test for resv not NULL is also completely superfluous here.

We would have crashed much earlier with a NULL pointer dereference if the GEM object would be mangled like that.

Regards,
Christian.

>  
>  		dma_resv_add_fence(gobj_read[i]->resv, fence,
> @@ -556,7 +556,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  	for (i = 0; i < num_write_bo_handles; i++) {
> -		if (!gobj_write || !gobj_write[i]->resv)
> +		if (!gobj_write[i]->resv)
>  			continue;
>  
>  		dma_resv_add_fence(gobj_write[i]->resv, fence,

