Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF11CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 09:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8BD10EDBD;
	Tue, 29 Sep 2026 09:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vA4vbWg9";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938C210EDC0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 09:07:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRe1l6x+aMkBajzyCLktc07Ver989syjZlrcRX6kE2DGiqvMYwAaFlV6sf+z3kopM8QOpUQu7rl1v/EW6TBUKpBWF3Zlo3F2sMCP+pKwcIfyTQPUmzWTGcq/FZNJg4mUTnvNczKhGIWmhPG4hNhlyKfy9lBr8VEADbSEHhX3JJ++/PRwIZ5uxfeOMrxIcpE0+xsye7MQFhNrPPav2n3QFzsi72+PNKDT9Ap+cC32m9jwpp1gcDPfF3B8bcVXzx7mCrg8P31L2SRz0k3bsifYyBz2oMEvKI6Nv8vuMD8ONr8cwreVN2WuE/Ff5UqcW2RVDcOhPd2m5MtQmaiy+QSQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St/sK3Cy+eQsLXUQS6dRUb/yGwL+iNMjhV3NAQfidW4=;
 b=S/8p0q5V9qgkaULycwzjiJMOiE2OisN7wDkvKZH0JwuVgXbkoOvg9qNh4azF96zpiZZSpeyqVFQ3t50h1FShwH/rBwjyrr5qKwvaztpXumqDjSIvhNRDUCFYZbQpWyFp2mcuisiInedcEC+nUt+hey/7gYp2DXGfIL7fSrd4Vo1pW9Ww37oWS0NXwq31HPtNx+AxNu9fk9J2lRlCnpTtEn/bi9NfBe3hUrdjLkI7Np5AVt27aZAR/dX7Rr41LvhndCYzqtsRsxLn0Q8qNPkHp8fI3azxaeHEBWB1N7xPoXlRxFfvOlRzjKpMGIh56ihU9LSNP0ANA+0SYyZHCv1CQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St/sK3Cy+eQsLXUQS6dRUb/yGwL+iNMjhV3NAQfidW4=;
 b=vA4vbWg97wagefTyUbt7NEGenF8BSlF093Ie6aJNWkRiEaxnyG3XsEApk0yKw0nLNHvg1SPhjZYtsBeFwB09TI4WIYxqn45O3HHO84QtJ0oKDnjoQaj6O+L8L4eikie6yFMA2idD8/aS+GyNrbNLowdQS4zh92fZGbX7W1b2d5Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:07:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:07:24 +0000
Message-ID: <ad2eff85-0e6e-4313-a02c-1a60f1f95c49@amd.com>
Date: Tue, 29 Sep 2026 11:07:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: reject mappings without a backing BO
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260929085357.3900280-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260929085357.3900280-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0303.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1a04ee-9b8f-4b59-03ef-08df1e09137d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aYn5fhnzO9vDgMgdJ76SltM0hNFWqUUoOqz1NgSrpSGrVUOek0K/06K81wkrQ4dFRzS9FlYqJ3sKehjerhewPAzoUMnK+BNvGe87IsshW+TFG1qmA0SkR1Gp0tc9W7Pu7yM71Qh5Nhxnykr+JEVTOokL4Qj/MXxpMrcp5dT+4GHeSS6TuqmkSUOTMvlCYkMOPmE7dm8nvoSo8EtKuBMewX/ONlUyeRcD3uVqJnHite1x8VCcXmtG7B70pvkSiAOEw6+bhtpXe8d2ThCinBVF1XuJ9HMygAootbj8CHnTMABRmbTNXqcmuntWgrpXFLbNqp57xx2bPm59MSGJWefR6gUG+lM2hho70fQM5gmZFHEIL26L/YObKAk2kH/0LUXCgzfamQTGJKYBl9YI9G0l9WZToyYCfEV6q+Cz9OtUPmQPddZEu6P9aZ6ZEDftc5Vz8LRYEuYlfvSY65jzLxAQhgZ+8fH2sqnnQ8HqBGsb2o12ApD0OlXfB7didxbqIRIq38SD42reuf2hCGVYP4ACm2ig7hrHOKcGQnq8GZNAOOeePVq+WPhB4EnT1CM7CbhbngzjuSWLyz8WDKEnbXm7UGwTX8grOJLuYz9AfsOIQOGineTgyh+ZqzOneq17WwEwg1OEfHqS0RPrSdF2oaZyaxezPxILGSPGv52O0ywnd0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWJOVGdMRnExbzdPazV0eVZHeEhIUFdwdFU0ZjRrcG1pa1BrM2QyVFp6bU0z?=
 =?utf-8?B?MEJrQXVmc05YdG44RzFZY1ArZGRJR2xhLzk5aXI2cnVVbFV0MUwvVUQ0RkE3?=
 =?utf-8?B?c0tpOFlXMitHQWZMamQvZ0w2bmRaYUJCTUJ4cjA2RzRWMUN6c05aSjVQd25v?=
 =?utf-8?B?bjkxV2U4OUt1YzhRa1UrVXhrWk5yT1d5M0VHbkhwcEQ1VU1hSG9wVmpYNVRT?=
 =?utf-8?B?Ty9PWktqNlo5R0pwS2UwYzEzdG93OXlTWDB4a3pOczFYM2VFVm54US8vY3Ry?=
 =?utf-8?B?Q3JGTXEwMUhCOGJxRHBVNi9pakN1blFKNUExaHhCVzJsSGFkTFBDOENaMUtq?=
 =?utf-8?B?RjBhU3ZIL3Rodi93VkwxOWF1eHZrbDQ4ellFSFUxdFVONE1aMWswR3VYOUQ2?=
 =?utf-8?B?anQrVmI1RERQYld1Kzk4REtWNmttRU90elJvZ0lhWDhLdlpuMzZuS1VLUlpJ?=
 =?utf-8?B?bjhBYXF3TjZGTFBxdEpWSHNFUWVVbTFsSm9UUFJMKzRCUCtwRktuVER5NDdk?=
 =?utf-8?B?Q3pWUHA2ZG9Dc3lIVzBTblFhVk92QlQvT2Q5YkR2cEhNNU0vSC80V25ESEpQ?=
 =?utf-8?B?aTBBN2RoU3dvTkFGQmkwY2I1UkFuVURsN1Z6cGUvQVNvcUlXRVhCTVZUcUdl?=
 =?utf-8?B?MlV1WW9OdnhZVk1iMUoreUhITkNkZ0lQTVBQWFp3RjBrb2NHZ2EzQVVlYVNq?=
 =?utf-8?B?Rm0wT3lVb0NTbjJtcmc0TE9VTzVRaVA3OUVDcFdFanpaRUNVNExIdldZOXVK?=
 =?utf-8?B?V2F0UnhJbXVZN2tDV1ZyU2JhTTRYU3hvcmFPaWxnMXNkYlRrN3FlcG01ME5W?=
 =?utf-8?B?OFEzY0ZzUXJuWXFpdnJpMVFVaytGYlowd0hONGdDVVJwdjk5endNaXdsQW53?=
 =?utf-8?B?TzlCREIwWDVDQVFrS1lDb2ZoWDNacysyS3JRaTloM0ZkMlJxYkhrdjh0amJZ?=
 =?utf-8?B?R1B3MEdaTkkrdThjV0ZXTWpRNlFWZFpKdDhYRkpxaDd3Tms5L25DdDZKV0dM?=
 =?utf-8?B?T1lTeHhVZDJTSm42Yk5NQTAyY1QxUEdPUUZiQ2hoK1pmNTRpdFgwdGVoR1d3?=
 =?utf-8?B?SzhJc0tLSkpwSGVNY3BSUUpYbUFMejV6MnRIQjRYVm9La2xqVkpPZHBIeS9K?=
 =?utf-8?B?OXl2dDA1QTRFRE5jK2xhRjhTU24xZjBQOEhQZFlDR2w3aXhpTmxnSDYyeWZP?=
 =?utf-8?B?V2JkS0VveXNnQXlmYkZ6SkhuQXZ3Z0JmYjR6RmtOMFp6RUlad2RXSG9iKzFV?=
 =?utf-8?B?OFJmSXRKdG5SaWZmTzJoNHJPNlZNbTBYaEY0MEo4UHpUelBYVVVDMXJyU1R3?=
 =?utf-8?B?Ky8yU21zTlBNVnVGakM1Ri95Si83RGtjU2x0ZEY2eWU4b0N2VWtIUnE1U3kx?=
 =?utf-8?B?QTBEczAwU1UzeFZOTk14L3RlWEtybjV6bDU0Qzl3dEZ3L2NsQllJbVR2cGsw?=
 =?utf-8?B?UHZwRjlEL2ZVSGFHdGU5T04wQVV4eVgvVzh1a1dabVM1SUo5V0l1ajVWak0v?=
 =?utf-8?B?N3AyaU0vY3F6Y1REc09sa3hwZmJZWmdxOU1PVVR5M1BhVzhpZUMzeURMQkhU?=
 =?utf-8?B?d1ZFWkc0bmkzMXFsYUZvN0RXQWMxK0kzbENlcjAyMUFod3diRVgwSDUvYUxs?=
 =?utf-8?B?bkpFRXRSYm1Ianh3N0MyNmd5amNUL2I1UmdYZWNUc0ZpcXRiMzFPSklDb1cx?=
 =?utf-8?B?T2pKM25MMnU5ZWZGLzFuNGdZb09lZEU5ZE5xaHRHSUxsUEwrSlJESjJrSlJn?=
 =?utf-8?B?UzNSK1lOTXFuUEFHU2hxQ3BDTGlsZTZydDdLcnVOSTE3V0FQYklZUWhpTVYw?=
 =?utf-8?B?N2lidDlXdUNQY1pQS0NreHl0TGp4YWdDU0JLWFEzNjUwZWcwSW1mL085UTIx?=
 =?utf-8?B?RnJwemJwSjBJU3JrVkg2ZzVDM3JjZkt3M0pQSU1lT0lrQnkvWVRzSkxqbDd6?=
 =?utf-8?B?Z2JndnBxLzkwVHVGdFR5eUwzWktmVDEzU253SFg0N0xGSWFZWWE3VHR6aGR2?=
 =?utf-8?B?Rjc0c3B6SU5EK05Za01KOG5ZV3pSWWlNUVRGTjQ0M0JWME1Hcm8zdEk5bDBM?=
 =?utf-8?B?VzliUHAzbjVzYWRqWUlMb1c1ZUxPRzBnZ2I2YnVydGZXWTQ1d2RlUnJiUURn?=
 =?utf-8?B?UHd5WGxjSithTTJPbVVjM0xZRTVkS0pobmUzRGVqcXVHUkhiZ2RXTXYvMU1m?=
 =?utf-8?B?WjA4NjB3YkN6dnJONXhoM0g5RUVvMnNLYlB6djNzMGRocy9WVUFPZXQ3T2xx?=
 =?utf-8?B?dnJscnpZRHpEUENiY21wNnIyMVA2b1BYTXdiNGRvaXNOMDhzdDdVU3ZVcE5O?=
 =?utf-8?Q?Z3hdLzzLuUazZ7p8YB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1a04ee-9b8f-4b59-03ef-08df1e09137d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:07:24.1660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo1xIgaEjAXKVMG5C1BY5POrhwqtzeQBmng6qz4j8FtWccIgzWO0xLlyNpZcveTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
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

On 9/29/26 10:53, Jesse Zhang wrote:
> PRT mappings have a bo_va but no backing BO. Reject them when validating
> queue buffers and when looking up the WPTR for MES or USERQ_SIGNAL, before
> passing the BO to the reservation or CPU mapping helpers.
> 
> Repeat the check at the WPTR lookups because the VM reservation is dropped
> between initial validation and use.
> 
> Without this, pointing a user queue's WPTR at a PRT (sparse) VA mapping
> makes mes_userq_create_wptr_mapping() dereference a NULL bo (base.bo) and
> oops in the reservation helper:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>   Oops: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 4558 Comm: amd_fuzzing Tainted: G            E       7.1.0+
>   RIP: 0010:drm_exec_lock_obj+0x2b/0x140 [drm_exec]
>   CR2: 0000000000000158
>   Call Trace:
>    drm_exec_prepare_obj+0x25/0x60 [drm_exec]
>    mes_userq_create_wptr_mapping+0xc4/0x1c0 [amdgpu]
>    mes_userq_mqd_create+0x351/0x870 [amdgpu]
>    amdgpu_userq_ioctl+0x7ef/0xf80 [amdgpu]
>    drm_ioctl_kernel+0xac/0x110 [drm]
>    drm_ioctl+0x2c6/0x5b0 [drm]
>    amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
>    __x64_sys_ioctl+0xa0/0xf0
>    do_syscall_64+0xa3/0x4d0
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 75d5ceaa53c6..63875761dfac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -253,7 +253,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>  		return -EINVAL;
>  
>  	va_map = amdgpu_vm_bo_lookup_mapping(vm, start_addr);
> -	if (!va_map)
> +	if (!va_map || !va_map->bo_va->base.bo)
>  		return -EINVAL;
>  
>  	/* Lookup guarantees start_addr is mapped; ensure full span is covered. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index b885e90ec5f5..118db0306559 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -386,7 +386,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  			goto lock_error;
>  
>  		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr);
> -		if (!mapping) {
> +		if (!mapping || !mapping->bo_va->base.bo) {
>  			ret = -EINVAL;
>  			goto lock_error;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1b06a4618125..e6c167a39d44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -54,7 +54,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  			goto fail_lock;
>  
>  		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr);
> -		if (!wptr_mapping) {
> +		if (!wptr_mapping || !wptr_mapping->bo_va->base.bo) {
>  			ret = -EINVAL;
>  			goto fail_lock;
>  		}

