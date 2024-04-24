Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F53C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 11:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506AC113A7E;
	Wed, 24 Apr 2024 11:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="faMUSNTR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCFD113A7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 11:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKwvGqSY5gvphIdkY/qYyM16OC+CMoqW68kmmA6+IMSPZRlYdLf0cRMas2aiX67wdJHEhWyc4PlXmcBQbKpEr/0LhEofW6BPAyvd78vjQA3X78e6iJmklOpCwYe3g7JctB65FTGFE9JGY4NZwW9RpZ5uvtb/pfs/TzY3e6JbKo+iYIKF13FbPFGwCKn3WzhX767CVL1T5ODvd+OYstOnw2lPVilL1AUnVVSB10qAXodU3dxjxcrkEr0z4LR3UXApAuZ2YTU4BwuXlBZS0WfkvxpZwn4MbfXJrBoO+65COqnTLKwxIr5LV59MXcbbmk7k085gv4k0No8IfuvLf71O/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ownedJFEnQmw3Eqn5SJyjvuM33vWNHA3BoC1AxFz0s=;
 b=mdONe82hGhqeu2ht79fSrSWrNKXiG1MOVb+4IloF2CWPTMCg3Tyz1MceOYLzaLdySVxxscuRhFPZn2CwbOnyLP5NsZyCJ6qzKl/raynu9xSc7BxI51xP0rlgoTXzpUDD3nOHFnVOTnleweucoOPwkKZ+6xEloXqY1FrkzAs5Ijf/wbr4ptJbtB480pOYQ9nADxmjhJVN5NaynskTGj4qO+KY8jf4gcPIULI+3dA2WYie/W766No1LXvBVqtFUHY3NBwJn8FUq7pEBdLK6zgW6zYgVM1HguD0F82xAXzIqIiVs7RMDSvd0L/4QCJj6/uvqif5nyQylieu3nbloXYJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ownedJFEnQmw3Eqn5SJyjvuM33vWNHA3BoC1AxFz0s=;
 b=faMUSNTR1Jx6XCAKPUKPimawNTWeJ9j4oeA0tZQtQFz/9LeJOs2pvlI2Hf4DtWzBIk5txnaoCDpr74Ovab73kFwYYC3Y4b3abiN6KhVnwc7bE/ddU1LowtrolKKo7TIFA0K0oisZ7ZXLJehQHRT0rnT75BLYZqJy0koburi/rIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 11:36:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 11:36:35 +0000
Message-ID: <cb7d12a9-9545-4f4e-a530-b37ed59c324d@amd.com>
Date: Wed, 24 Apr 2024 13:36:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Initialize timestamp for some legacy SOCs
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20240424100343.608218-1-Jun.Ma2@amd.com>
 <20240424100343.608218-2-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424100343.608218-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c5fe7a-a5d0-4be5-7531-08dc6452cbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TElVakp2ZXhEempBRVhYeDEyZW80Ni8vTlBvK3lva1ppS2pZQndraGFCYkxr?=
 =?utf-8?B?dUdOSWtnOHdzdURBK2Nnb2VzcmNZdStFWFlhKzRvbmRJcnJGaGJOMVlPZWs1?=
 =?utf-8?B?eDJLZkJsR3VuWGtBa1pFbm8yS3JKSmFZM2Q5c0RLcW1SR1BPdVYxdXdISWNH?=
 =?utf-8?B?ajFwV3BIWDBORnZESXNlOVVTRXV3V1lWRmxoMHlFZ2lqL2xORFNMOW1ZbTF2?=
 =?utf-8?B?YXV6TElYM1BLYWJIN2Z3Umk0dDdPT1AyUTRjL1E2L1M2RHFXZGxkN1ZZNWRF?=
 =?utf-8?B?QThyY3ZQS3l6RU1CT3J2bVJMQ0ZZdm1IOFpIMWIraXhWdno3NkhQWWlrOGUw?=
 =?utf-8?B?Mm5id2d6dGdOeHRrVDRlM0Jpc3A0clAwYnBtZld4dlVZSWNxQU9VRzZpblZw?=
 =?utf-8?B?ZU9aVzZBZGVpN1JsK1hQQXNsTHNKTzZncWJ6c2ttZlhMVXJsMG11Zkx6dXFj?=
 =?utf-8?B?SkREUnZOT2tFZUhiZUpibFc1UXVDTHoxc3JyMU1kRndWdnFTcUJyQVdzTmR6?=
 =?utf-8?B?STJ5TUdIN2Y1ZmZpRVJGOGVLeVcwckhBN2RiZDVBRVhqYWFNL01GOHFTdHhN?=
 =?utf-8?B?Y1IwSTZHOVB3SWtHV1oyaitneW40dTFJTjZyMmdCZ1IzZWg0QUYxdzB3Vm1w?=
 =?utf-8?B?YmMxOEtDbWR1NzVnL3dEcGFoNEp3bHJwTHc0a211U094T2N6c3VjRGd0b29O?=
 =?utf-8?B?b0RQVnp3RFZGaGZSNWd5dVNxUW9sMjIvbS9nRnNuT05nQ3Zxc2h1ckRESHg3?=
 =?utf-8?B?U3NNNTZCUjA0RSsyZWowWjVFMTd3eXVFc0REVk9wYnRmUjNaYm9lOGNKQ2VT?=
 =?utf-8?B?eFNON3hMMERLVHc1ZzEwSHVzVm1UNUxTRW96QzhCRWJ3YjU3Qk9BakNISWt0?=
 =?utf-8?B?UGRKaFBRalg2V0pDTmQ2OXRYc2xGS2dJb01nWWVWZlpQUU5XWE1xaGtYTDBy?=
 =?utf-8?B?Kzl0Zm9vU3JtQXNmaDhtaVRYK0g4V29nQmcrOTZUVDRKMUhqZHpoN1F5K1NM?=
 =?utf-8?B?Z1djTkExM0d4VHMyMTluclcvc1J4L2hTNm1OT004UjZOeGpTeDVrQmtGNzkw?=
 =?utf-8?B?RlVVN2p2Vk5YSVdzWGpTc3BtdExrNlNPNWZ4RGhyY1lBM25xVVpNaVlkNXJl?=
 =?utf-8?B?OGM4bzlhMkEwZVBsTUNLMWpia2E3Q2FkVEhpbm9GZ3pSamJrcHhSVi9wYWFE?=
 =?utf-8?B?c21wYjdNQUpUbHJyMmVVWm5iQ0tDSElPaWhlaEZhSC9uOWtLYmlkajRBK05V?=
 =?utf-8?B?WnpKa0JiaVdKdUlUUURGOWY2dnV0eUVnZDdubGRGWDFPbVpBeUJVaThLR0h6?=
 =?utf-8?B?MlI0MWF4VnFXZTZSWExQOWQrZDAvRS9Ha0hXVStMOFI3ZmxWTENPNXZkUmZt?=
 =?utf-8?B?bTVORjVBa1VLK01TS2p3Z0piUzF2cVE1dWdaeTk3ZjZxcnI5K2d2TUpySVVC?=
 =?utf-8?B?d1hKYzdGYnRaNElMSVR4Nlp6NW9pekJXUjNGRVlEMXFpMk85UHNzNzAyQXB6?=
 =?utf-8?B?RWJFMWJEMmk1UVNZQ2tYUW1NdmlMWVJOOEJ5bWFONEhQZWswV0lveVhzdUYx?=
 =?utf-8?B?cTNIcUF0UlQ2bW9kd281OFZxUkszTFY3YTA5TWJpZWxmMDc4eFk3RDNlTE5R?=
 =?utf-8?B?Z25kY2dKYkNoTW4vZll3QXVNM3V0bkFWQ1RxakdqQkt5SXBMTDFXekF3czJ2?=
 =?utf-8?B?YWJ1UlVMUVh4cHJnL201R1dqVkd5V3R1RzFzSUU2NVgzNER2V24xcGZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFKbEh4b0ZwTDk1QWhTQi9zR0lUdWw2aE1QMzF5RWhLSnpxcUFQR2NQcG1s?=
 =?utf-8?B?NnpsM1JIM1hJZzh2MzBxTlVpdTl0Z0UwYUNUaEUrMlowUVV1ejIvVkJOZFhm?=
 =?utf-8?B?dEFTUVdrNG55QnNkZlBWRmd1U1JvWko4cHRlckc5TExXbTZEVktLclM5YWhL?=
 =?utf-8?B?Rm1UYXlZUjlEZDFOeEdUK3p6THdnMWEvSzNPMFJrRmt2c1hLYk84MVNEbE9L?=
 =?utf-8?B?T0VCZ0c1Qjg5eVRrNnZXeDBwaDd5Mm96SW1jTmE1c1RuVGkzWjJqSVVhYUFW?=
 =?utf-8?B?WklKL1hFeS9zKy9LUmpVYThNb28xaFVvWUJnWHl4VXhjZVRvQWVRWDZkamhx?=
 =?utf-8?B?SWxUWHJLK1Q0VWV4L3RBck84YXNpcFFhZXlCMnQzR0VuM0ZEdUl6b0dLSUJl?=
 =?utf-8?B?c09od3lLZStzNmdiY3pQNG9FNmgvV3BPRjhtVit2T2piUFVyMmV4d0hsSWlT?=
 =?utf-8?B?VzZCSkNvZ1RUSU82MUhTeTUvZEp4dFlxK05iVWwva3RKNWk4Y0Q1OUxlUStp?=
 =?utf-8?B?S0tYZEVaY09jaEJXSUVWazIraDhXNzlzVEFPZ2E1dkRlMHkvVlAxdUtMeGo5?=
 =?utf-8?B?VUluRXhrbGVyVUNsZWQwMDY2aXlUa2hoVlJqRThVWnNNcDRIbm9ZQjZ5N0sv?=
 =?utf-8?B?SzYydmxTa1dhaGl5aUduNVcrRmluUFQrNzMya3lMUEw2NWZ3Z0gza0R6Q1Mw?=
 =?utf-8?B?a21ZUnljb3k2NTZVazEzQTJFb0VHTVRrN1ZJZ3ZHTE8vaW1HQklObk1yTHNI?=
 =?utf-8?B?VnZ3ZENQOTVnKytWUVZMb2JjSmVOSWI5bEZic05vcTFHQSt5OFFaVFN4R3Fl?=
 =?utf-8?B?UDNrdlRkTzFDLzJGcU9JUElwcVRzQm0wcFowYnFBVEJ1bldOVlFNdFdON3px?=
 =?utf-8?B?dmJxYVhvYklQcWd4UUlLclBOK0pyQktkd1VZSmtiN2RjMXQxaWpLNUdvN1dN?=
 =?utf-8?B?UkhNNW5mdGtJR3VCZDN0SFEraUNCQW5wVTdQZ0pDNEpXQkdiTGtWOVJVYy9G?=
 =?utf-8?B?UldJRGVkb3c3d2dBeTdaM0tLdGFyMkdYZ2JjUlhYdFFxTTlNcFk2ZksvZW1D?=
 =?utf-8?B?QTFEVkpOeU40V3RXMDR4Y01pb3RqRndUTkphRElILzZXN0VUVVNnOVZoSEda?=
 =?utf-8?B?REZOUVBqYkVNS2dyaW0xOHdqSTRNYjlsZG5pTFh6SFdEOW9EYXp4NjlWODdv?=
 =?utf-8?B?TmhZcTZIYTQwQmFiQWZ1SGQ0ZUxqUFRaU25YOW0rMUdLaWZZbjdMNnF1SHdX?=
 =?utf-8?B?US9wNEhzS1hPTW5Cc1pwSmp4OXV5UGMySUNtalRWVUM0NlpzUTNXc1RFUkFZ?=
 =?utf-8?B?U09LQ2pVZWJrWTkxaFJSM3dvSUlHUW50bGp6WkR1N0F2Rm1ZdkpMM3gvTGQ5?=
 =?utf-8?B?TWNVaVMzRE1wdW9qWmIyOU5iZVdEbGMrUTBHS3Q4dWNlM2FNMGR5NjVHZURV?=
 =?utf-8?B?UWRLOGVkWXBKSnE3NXgrVVJKQ3Y4QmpDbHNMRld6TUd0aHA1TjR3QXk5OG1x?=
 =?utf-8?B?L0hpL2ZLZDJhK3VJQlpjd3g4NGZtc1FWb3c1ZlZ2OHNYdTZOOXVyWmFmRENr?=
 =?utf-8?B?Z3c2ZmJzOFdHZGJsMTJSNmV6eHRvbzVOUXBLZngyWFNMalVCZzdSOFd3NEdt?=
 =?utf-8?B?UG5WU01WcVo3ZDNuRFVrNHlaL0tpWnNqUklGOXZkaHVxbDdQWTk4TUlJL1Yx?=
 =?utf-8?B?UXM2NStRWnhwRWJOMThvd2hNNTZyTU9Fc1RqQnRQSVloaWZCeWdkVlJsa0lZ?=
 =?utf-8?B?ZUN6QStGL2pWcnNrTXhmZll0ckpJQURvZlpldm03TWJrQll4dmZHbGxxcnBP?=
 =?utf-8?B?cWdKNjJpMEhZM0dJbXg0V2Z1dGhqRGVBa2FudkR6YVR3K0dqZldISkQ5aXo5?=
 =?utf-8?B?SVBTaWQ2WTRJTVI1N3ludEtOQ3Zkand4TEZVNURYd3hHb1ZiZWlkcGZpUnZz?=
 =?utf-8?B?MGRqN0FqYXQwVnNjTmxzRk00ZjRkakt1eUlRQTVZT2dSTW91L3NoMUNzbENI?=
 =?utf-8?B?bFBMbldtNTYyOGdQV2hLNXVrbDZwa3J3cU5CU0J1dUdzbUJpVXRxT1V5dXpx?=
 =?utf-8?B?T0xqWEZ1QzlSVnR3c1UyanJYejJhbU9kY0J2MUIzNGxEUUFHTEZEeEErazI3?=
 =?utf-8?Q?oMOlVC50n67Jn0jR/sWNPLgC6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c5fe7a-a5d0-4be5-7531-08dc6452cbb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:36:35.0096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxn0xzJydIkFZauxB2ASHkcbE+V09DEkL2FmixLzqOMdBz+kLa8DxtMSu4tUj3Et
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
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

Am 24.04.24 um 12:03 schrieb Ma Jun:
> Initialize the interrupt timestamp for some legacy SOCs
> to fix the coverity issue "Uninitialized scalar variable"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 7e6d09730e6d..665c63f55278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -445,6 +445,14 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>   
>   	entry.ih = ih;
>   	entry.iv_entry = (const uint32_t *)&ih->ring[ring_index];
> +
> +	/*
> +	 * timestamp is not supported on some legacy SOCs (cik, cz, iceland,
> +	 * si and tonga), so initialize timestamp and timestamp_src to 0
> +	 */
> +	entry.timestamp = 0;
> +	entry.timestamp_src = 0;
> +
>   	amdgpu_ih_decode_iv(adev, &entry);
>   
>   	trace_amdgpu_iv(ih - &adev->irq.ih, &entry);

