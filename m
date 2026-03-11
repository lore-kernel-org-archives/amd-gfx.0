Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B85FD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E94C10E2F4;
	Wed, 11 Mar 2026 04:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Hur/1sp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3ED10E2F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAAfBZnjZ1PvdbP5Z7GGZPB5L0lreZBkiIemOMQ1crs3taBF7AwrBGsBgm2/6zLywv/fRFcTwxKmPpeLL9vzuJeoonXUgtRJp/zoN3DeTwBjW5k311/jz0OOO7VHtxcA9Lkhp7LlKYTSsmXR0sogs1A07FfKGZ4g3UZauC3I05t3O09oNGv+nWsVNwECsiqVIS1pRIrt7HYRYBkQJJ4iD36zPGm/B5B2ZJLtvuEgMDF8QrK6iI/o8ZKDQAN7xBQq51RM+bOrI/DxxqHcQYEqI12SgHKyjkYWdGDCIgFJE+hJnKeIa2jGlURtOaoJK94gd1QpNCaMdzBDNz95vX7VaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDetslNcy0B1w3vV7vWeFSG7649aB5YbyIkvtjcArcw=;
 b=Yb1lk6lG013CASxiLwTUHrwsKbDocrJXUh9E2s5kAqCn4shqbwjBQboHVRcNdA28mIgzIl3mMYvHBRlqu7iwqyjuClXbDKqu+fON74FSe5iAetcO4A4KSPe6B7n8Yo1Raxpd3CGur7ae1vUluixk8mLjQXrJbrfcM9uEATCqFS7AWF8bcZILuHbfE4EE6+5/fztCb/p38tLTD+cstJvZKnBToBtX9kvTqJwqc4qvscKyjncaN4nQHlYZDiW/V2cQjFMjYuehqcV0BKo1yjUJxpiRQHrxIdgx98d0kRxfiRL3QX6MvHECSVtOEV6ns7ciy09aDTk9ougLQA0XliS4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDetslNcy0B1w3vV7vWeFSG7649aB5YbyIkvtjcArcw=;
 b=1Hur/1spZagofgTvlLxw8+ei64KSPRcKIWeGZ5uDCe6ybcu/Q/GjYI7COv7kjQuDREALdfRFayQyRBwnyoYcQsGJelvgLVjzyv7v7NOO11N4D4OTb8muOP3IbFHBfkR/E164W+L0JRNNwhv8XWbsaKu3E/8H6QwOdSr5+1WuI/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Wed, 11 Mar
 2026 04:24:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 04:24:52 +0000
Message-ID: <0c6c1b03-50ca-43fd-a7cf-bcfd0975cdf3@amd.com>
Date: Wed, 11 Mar 2026 09:54:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd: Set num IP blocks to 0 if discovery fails
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260310165822.2930580-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260310165822.2930580-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b4da91-d1d3-42bc-02c2-08de7f2623b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 2zOC2yEV6UcxEst4pnvYNunb8A39vevdSAy+V2acva9BM1G6RlcWY1h17USFwriBJ0iaDIRFm1o9QoTd1ioK67aZuxU8I1mR01GdpyH+AyyW1qoSXE5gmWKtmJjaHyEdiuzrGF75ZTYPXzSQ62dt3Ieto6kMWi6uuzgTb9/puJ0g7Fljxmm7Mtuf/NaQK/lNczIpoSfc7JpiiTyHZUGkIzCjHw+4iWZ1PiNJ5u49zcrU+8lbIO6mA3Lb8cMGH7RqUM7H6R/hmX8hpVO3NjUlw5ieBN++89qvzGuE0zU2Tddr5qRyFV+8+NGlNmJbGQ14xcGNxPzLX+RDlPlkUrEC9r4tqFTMJHNxX8LWxV/OhuPVA1LwxbJQnJPMLMDi2B2t4aoiCVDLE/iP64ccop3+FCBKEEu4SYcW2hxWr++d1fJfESkIUBVNj77/CyG21MtZm9quiw7369LQILx/jFqMUcCsbHEDV+slsPqzAg7Y+jv/NM8Y21D2eHfl3kj8iAisQiitIIYGSa3uzVr0VvwkH3uanGpS2kiJsmVewCeeDzDcdYMi+ZfEPnS913e06NBOFGZDx++7Uo377YL0TuPgBvPsWTuu56CUcsnEWGP63s7sA7NJgx0cEtJcbifU6u6za+ZoXHkUHJ0YcY6U7ZBZSYQZmLAY+PLdGwSQIfUz6dHKEM2P1fVHHxoxqI4EIVyL4j8yrRREo0PNuUKNysrlQBmoH6eykTp7QiHX8E5/vUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9aSm1zM1RPakFpTE1uWUVCVVhXeHMvUTEvM241T3dyV3IzaEhJNVhFTnIx?=
 =?utf-8?B?SE5HaEwrS0tpSjZCRWlEWHBmSm84SHhaaW5SSHlsYkJKTWU3c0VsWktXRFh3?=
 =?utf-8?B?ZzBuRFpJbDZuVW1hTkZnNlJmdTd4dEtjQkV5ekxtWHV1cVNiYmNZRVpRa2ZI?=
 =?utf-8?B?cFJIUm9xNjF2UlFvaDRqRnZmeE95Q3dlbUJjTUFPNkpPcUZKOXpGSDdFa3hO?=
 =?utf-8?B?WWhSUHFUT1FXcG1JN3FuMWVtWXdaL3pxeDhEMDVubWNFVGM1dmJySjBXajB3?=
 =?utf-8?B?MTJYUHl3SjNidExOOXVOREhCZ1FaVHUzUHZJZkduSzZlSVptRk51ZUsremgz?=
 =?utf-8?B?NkJaUkdRcVM4MGNaenJ3OURZbFZldnJvNnRETHdKSkhVQ1p6RUVLNk1WRXNu?=
 =?utf-8?B?MHpwNHIwMEVxemF0NFB3cExyLzNHV0pYcmhoSGJ4cTYrOCtsaHJaQk9wODkr?=
 =?utf-8?B?bE1LaUlzeVlXRkVPL0NsSGkzVDJ2UVJvME1KSGJDNGpwSS8weU5pazJOK2Fa?=
 =?utf-8?B?SVdNbU0zR0h2eWk0UGkxOGV5OVpXUzNZQi9zVDZpV0E5Rk5pMVZQdVp5YThQ?=
 =?utf-8?B?ZUtQTXBxYSt2UXJGS2w2dllFNStIaGM5b015SnVOZmZlTXdEL2dvbU5nME5t?=
 =?utf-8?B?dTRUY2dJdkM5RlZrZ2svWDJvLzNlVGJVajdXdEFpL0N3QmVIYWcwVDJNem04?=
 =?utf-8?B?OWtnS1NYaGpncmJrNXYvOGFVcEEzZEwxMURzWXpiSlZRcUp3aE43dHQrOVk4?=
 =?utf-8?B?RnNpVktYMTRBaU5LcHBRWEJIdTdYVk1jTWFSTFp0ZVJ4NCtZVEVnU2tkWUVW?=
 =?utf-8?B?MDI0S3RPeHA4cTROTExpT0R5RTFxZmlFZndwYm4yZ0V5YjRtK013UFFNbitR?=
 =?utf-8?B?S0t1cSt1cW1hZ0dhbm1mZHNnYzhRZXRwcjRFdWNwYUNnNThvZnRoSnk3Mnd6?=
 =?utf-8?B?djhHK0syWmFCSm43MlA1d25rQ3AwRXdLbFpId21lSGx2MnRnV2VpWDZHcUpa?=
 =?utf-8?B?aUVGTXBGa2xIRDdyNHhGdGFIWUd6UkJycXpyazZGc052WWE1Y01xY2k1dGY5?=
 =?utf-8?B?UWxKbzAxS0h2QVg5NHc0emp3WEVnYkx0NEJIUDNlZlBnRjhWYjYxcjhJOElh?=
 =?utf-8?B?WVg1SXE4cEFqMGlHR1lJbUpIbG1aYUx5ZEJHMVpCelhCc0xQV0FicDVVeTRM?=
 =?utf-8?B?c3p1VGxtbmpTNWZpdjlUT0pVQmlGRmQ3clNnT0R2ak5xTFQyNXU5TVJkTDMv?=
 =?utf-8?B?bTNCY1gya2hFTUxsL1ZPdnhpZ3FLMlM2b09YNUY4ejNDb3grbkpEaW9XckZl?=
 =?utf-8?B?MCs0dWtxZVpUQlNOblZUY2liSHhVZC9yT0p1Wm5IQzJWRUQ2dUVKVUtEOXpq?=
 =?utf-8?B?Y0hYQTR1b01Wcm5hUFZ0Y2g1WXJkdnYrcStHL0NrditRWWwzSkZJOCtEbEJ3?=
 =?utf-8?B?RlZZMXhnYUNNKy9GeWdXV1BNbnBGQ1BxOEJ4TCtwRUc3NFh1NWhqVFN1R3BS?=
 =?utf-8?B?Q1NSYTdOdlV5cTBVNTBVUmZOQm93OEVaZGlYcWdKNXBHVnh6MkN3OGtZc3d2?=
 =?utf-8?B?cWdaVFVnQS80QWxSOUZrQlVJTGxWOU1Mb28vWGQ3ZERLT3dLWTlwNmxTRmYr?=
 =?utf-8?B?d1VTUXR1VUJaamdSSDlOQmh2bEVjMS9DNGE5UTBZYUo3RVpHZHFEWkgzdUx1?=
 =?utf-8?B?UXg5Uy9kVkduSWtRTVFSNVhOWXkrOWNuWWs0MGZlQmNvVEdjckYrZWNLc2lS?=
 =?utf-8?B?by9rbmd6aUFybkJlNDlSYVByZGFCQWtLdHV1T0duWUppcHJRZDduMDg0WkxJ?=
 =?utf-8?B?WXZZMm52MVZpdGx2N0NJTW5UeHVqNm1YNW1rajh5VkdxeXR0YmNDdEIzWGdh?=
 =?utf-8?B?V05RZzhjeDlIdnVqd0twVjVsK1BsT2ZEVzA5SytBdUZXTk5ZTlhwaXpjWVlq?=
 =?utf-8?B?dHdXd3FINW5pZWlGVUM1UjJHUmRVVXVSVk5KbUlCY28xZWU3UkJCSGFUSU5Q?=
 =?utf-8?B?eWNBWkxVRm1hcXpuQm5rTk5yTGlIM1l6a1ZzdHpJWjI1Y3h4bkFwcEh1ZTlu?=
 =?utf-8?B?M29pRkFWSXRKSzZRNkcyanlyT3hYc2k5ZUt1RWxEWVRORGg1c1drOU1SbTUr?=
 =?utf-8?B?dFRhM3BhNHlPb1dndkZRZ2tqWHlnYVlpbnFvTDBYeHo2TnhZUmdnUEt3ZkhO?=
 =?utf-8?B?eCtpeEx1TTJKTldPcGVGbjVIRTBuak1ENS9LQUlOeGdXZ2tHZVhMaTFIeURS?=
 =?utf-8?B?N3BlaE5RbHdIU3RIdTFsLzJoODN1SHBiU09jT1NGVVkwOStWa2R6N2dLM1VL?=
 =?utf-8?B?YVEwaEdGZHB5M082ODZCMnVuOHZ6dDVwaGNYQVpUaU45Y2h5SEQxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b4da91-d1d3-42bc-02c2-08de7f2623b2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:24:52.1237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaNE1XK76R64zTPxHD6CSszVBHMj8iBkfAMqmXuO6jD7uunHfexuoD9fXeq8e/Nv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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



On 10-Mar-26 10:28 PM, Mario Limonciello wrote:
> If discovery has failed for any reason (such as no support for a block)
> then there is no need to unwind all the IP blocks in fini. In this
> condition there can actually be failures during the unwind too.
> 
> Reset num_ip_blocks to zero during failure path and skip the unnecessary
> cleanup path.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v3:
>   * Skip cleanup path for early discovery failure
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 2 +-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5c24369821e47..c1949070a2969 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2701,8 +2701,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   		break;
>   	default:
>   		r = amdgpu_discovery_set_ip_blocks(adev);
> -		if (r)
> +		if (r) {
> +			adev->num_ip_blocks = 0;
>   			return r;
> +		}
>   		break;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 77e2133de5cf9..7f19554b9ad11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -83,7 +83,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   
> -	if (adev == NULL)
> +	if (adev == NULL || !adev->num_ip_blocks)
>   		return;
>   
>   	amdgpu_unregister_gpu_instance(adev);

