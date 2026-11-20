Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD80606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUYPGzOs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D9F10E368;
	Fri, 20 Nov 2026 12:03:40 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D1A112974
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 12:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hy5gAGeWxYHMK7emSIb5yXEGXYWdsDti3qh9CnS/BlW525oWwGms7aQmci1fAcd2Cj3XRvZthZDXtrBSw5/jOk08GWDHk0tLPezySMmlBjfPx8urWtawbQ2IPi1EUg3Xth7sNXUElwjfMzVqIVMgSBvT/0hE6i03ruZr6+a7Ibo8rC9wkrN52Pxsm9/VRwHlZgz4QwB/HW9+F8zgliQjDYKEWSFxLDRHIoM87asU0xn8HlrJWWQQ720QwycUvpgHzYL5pLwD4AOFREJkuOZqTQ7YdWUyyBuhUglZc6kkP+9qReu7MbXpG0VpjByajNUl41WtwrfrJv7saeir/qXITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyTcSEpB3XrP/RupDjjD0YZ7rJnB7Jozo4qDtjgiX2s=;
 b=yPuqOmvl8wChaZM1ib0YtCr+bnHNmtBcwXJ2kzyjXFji7VbhphmtyztxEfCDwPiY2MWXz12UE7fWHahO2veVgy78aZnDHIBsFPPeOPrLdYolkHSW6iRAyJT8rglcD5By81IXzdNNr2kwApX+IP/Y8+JMB5/I96XS1/BiokAGBp+aph18xJgPM4r4mnJSEiNe4xremXXTSHErCMIN4AccQdRGCcKy3fTqUH5QZJBtALQeX0vFUr73lXUd8H9FsUBUerdn8HKeGYVbEHWyF0Pql1+BVn5M4lQPrGpzhgtlOkeylXYUFcgW1uTp2xNdgp9H/dLhLq0oWWiI7A0LwHHBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyTcSEpB3XrP/RupDjjD0YZ7rJnB7Jozo4qDtjgiX2s=;
 b=AUYPGzOsy0DnVUiyqOSAwqxzOMDg818ujmEQSgayB3jzACYanOHNMV1ilifXw6PngZ8cwEFDZA+/RTBBIY20XMrQjTkvbkwGC8sA/AWJZ6EpWrrWGHKI/sw6mHPcqp5wDEJ6VQgjOkBwjTJ8I6daG61vk1Lp5CWQNoDJPJlsbPg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV0PR12MB980390.namprd12.prod.outlook.com (2603:10b6:408:3ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 12:03:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 12:03:29 +0000
Message-ID: <90b6d1f2-2ed4-4259-9470-96144c27d5e1@amd.com>
Date: Fri, 20 Nov 2026 13:03:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] drm/amdgpu/vm: reserve space for last_unlocked in
 handle_fault
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-4-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119144049.2057674-4-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV0PR12MB980390:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd6fcf-1f6c-450e-ac9e-08df46fe4a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: qt98kaslGb7hg2CNP/jpH2BlkVDlFl4XJtFkC0IlniOfKQ/X/tv00Ee6TZUNDxYVsDdjF4FRReuqrgK8BMDKXeFPGd2XEKTDDtspC5UcQMswa8V9NHuETbcU2WzdbKRdplksRrjo1SHm2S1Hk49BHjYLydAhYacNf/3KdXH3N7oyeS6DqMytwIvBXOzUqvQWQp2xpfNA6fOljGuNsy0nEjRSMNUAjCMtZY1DZTLH+0bopSwCJW1beWHp8jAfvWuTCM5aEFn2S8GSPuLFfed8ifQjMl8j1Qru51JjeJgQ2YpcOdEalhEjHcIY6mwtPCGlpQL+72DYWI+4hdSAzRF6cYdFRkhEGQEcoRcVWMMi7pIVJwqjlnGEpvFbqg3v9ERocAP/n0OtC2WVIA/j+XUuofA9TKYEkP9mMjlV8syACvb6q2T2aG/CeD2BZMPN6hj+aIGXZ7M/0OkQfuGAAtHt72HyIFgdMQzHCUyate413DMdFnQt1EEvQOvw7Un5Jb05TyrxlF/Li4CzMUyaBJ3fVnn1LVMYgIkr8Z8sm1Bm1+ZcnRhhdYVZwGjwqDpEywAwPjb8hkIKA3CHdwRFNjs5LaELGvcY6VPAqdadC1dPcykGMMHeMEW9U161ko7g0TyPmsZVUy/nzgHZRWQzxOnFmkxMzaiIkjyg2mNr8mr0zXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZSa1d3a3d4N2RlT0dLZlpDei9uN1poeTczUjFaa2loQS84Snkwdm1aQjhE?=
 =?utf-8?B?TTN2aHZUTHJqTEE2YzlQc1V0TDl4TFdqZ0RSZGJ4SjN5aUVyWnVVOUZJYVU0?=
 =?utf-8?B?bHo4RnJmNDJCdmhGYWpTNUlQZ3BDbkhZZE1TcVFtYmZLcGRldHBHc1cyRExO?=
 =?utf-8?B?NjBZS2hzeThSRTBTcmdGaVMvZFR3Zkh3bjBpeFJWcDBETHM4a0RCODhiQmlR?=
 =?utf-8?B?SHAzSnJJQ2Y1dExtV0g4Y3RxZXdRRmt4dzZRd3pMc295RUlVdUp4ZVp6OTNT?=
 =?utf-8?B?WWhYcTkzOHhvNVVoeU5qcUsrOU53NzNtN1pCcW5ZTG1mRnBHOFdwVS9GcEN0?=
 =?utf-8?B?bW1ERnhLWkJvQk1qWnRRWVBCUHJQNXF6NWJMQ2t6ek15SEh4QTJ2Q1RKZmw5?=
 =?utf-8?B?Qms4aDBqRzg1dGdUTlZBMTNnMy93SHZaN1ljVzROK2sxQnB0LzlxNFZ3WWsy?=
 =?utf-8?B?b1FLQko2akwvRTl5bTlWS0RRandMTGRWY001Z0pVUm0zVWtLbXB0YldUa1Jv?=
 =?utf-8?B?RnlYdGY5NEMwTm5UaWNRUXh1enJaSHYzSlRzcTRvVjNCR3BFajdXYmhXTEgv?=
 =?utf-8?B?czVJT21BMzVqeFRESlNuYStDaUhZcytBaHNOcE4vMGZQTFNtVUxlbUt0ZWh6?=
 =?utf-8?B?UjlqU2dzaXVoaHdtaFhOS3RheUU2Z0VZYWVTQTRhMzNtaXJyVzJRWjB1OHRq?=
 =?utf-8?B?T3prSUZWUUtFQ09xRFBXWW12WFlvVmh6VEFhZUtBM0ZDdmZwcDVZQS8xTnJG?=
 =?utf-8?B?Y2lsamRxalRubzVWdmVJSXZrcUs4SlhlOVlza0poU2oyU3Q5RjRvdENDM3Rl?=
 =?utf-8?B?QTNmUFFMQ244NzVKVWNITkszdVJRTjRqdjB1RmhTTEd1OVRiNVhrbVRhTzM0?=
 =?utf-8?B?MzJxamtCMGNEb0lWNnVwTVNYc1Q1bXBnYXJ4TWxIV3U1VmZxVk42SDZralFF?=
 =?utf-8?B?TGNvajN3emU5YStFNE9IOThvUXBBQmNyZkNzWmxHOGE2cnJpZXUvc3Vtc043?=
 =?utf-8?B?ODd5WmJZYUhWZzB2TFVKRGV6NmR1OE5xSlpsK2Fhb1NtMmpPckdvOC9EaG9q?=
 =?utf-8?B?SmRJTDZCOVQvNFBNN2FxMDg5dTd4empRMzlzWjhOSnBzYWl4NzVDSE13SENh?=
 =?utf-8?B?U2lSYWhMNDhJTlZOMlBZTkVOZ29xRUprT2N6U29Dc0w0bmRqbU9TZGE5SlhR?=
 =?utf-8?B?MnRzREoveCtKZnRVU2hWa3A1NEJzYU5sWDZVbklpK3J3akt6NllJSElBUjhm?=
 =?utf-8?B?RHo3UGxWY3FwMW1BNnphbDg2MFRrSXdXZHQvZkMwYTh3UXk0cjdianlpRmIv?=
 =?utf-8?B?UTJRaXNpVHpCU2RzYit6WUdaSERqeHNJWCs3MjRMakRpOFlkUFBqUDZGeFY0?=
 =?utf-8?B?NXFCQi9Pei9VbW9wL1ZNZnJSM2xXTUl5RW9rOGRqajBQWW1wTGwwbllJbkpr?=
 =?utf-8?B?em5YajhjdDQ5aG5QT1QwSUpWY2JYOWtwVFRJRkYzZ3lWNTdyZXFQVTE0OTYz?=
 =?utf-8?B?OGN2NEFib3dEL2FwbmtodUVvemJGdEpjMCswcklzSEs5T1gwZkxiWS9vYm9J?=
 =?utf-8?B?azlSWE9GODVJelM1alFMUGJZZFJQeWRKT2JEQ3RTb1FsaGhUbis4anU3cjNt?=
 =?utf-8?B?SWp5bGNBb3FyU1VoQmxzYTZKSnZHY0p3ZzNkOE5FRktKNVNidy9tM2JFcWNZ?=
 =?utf-8?B?SU5TZlpzbzJqMjBkUk1JK3U5VzYrOUJuZ0lJbS83ajhqWEttektDL0o2d2J0?=
 =?utf-8?B?NHdGVENHUUVKRE4zYzh1eWNGRXpGWjRVVnJmUTh5b0czM0RiV1NKcU1xaGxt?=
 =?utf-8?B?QmxkYm9pQkRtdWU2cUkrWk9kR2pVcUl3OEVmQ0VhRG5JN09ORU41SGdidzQx?=
 =?utf-8?B?MlNTVHhFUThEcU5WN055S0k2ckpKY1RaeVQ2bXRXZCt4djhhYzMwMzlXT0V3?=
 =?utf-8?B?bFZGZCs5c25ubDk4VVBTaHpJamJHdWdmN0lta1FaTmxVK1dLNW9uUjhTVlNT?=
 =?utf-8?B?QllUREY4Um8rYXMzcVh6UWk4R2tFcnpJbHBXN3JlRW9ybDlFaUlKbmVBUkZP?=
 =?utf-8?B?alRPVjQwWEUvaSs5eEh6VndyWk5keFVNRXBNaTQvOXROU2YxNThIN3d5eWFG?=
 =?utf-8?B?cVhmcTN5NkNGVnpEQmZyTDJ6cmswdFJWeUE3eHFqaG1LbE0rZFRST3NBRG1j?=
 =?utf-8?B?SGE5RHBMV0EzWWxCUHB6WkxrNEluem1VY1V3bnpmRGxwODI4MmpTcjFBU2di?=
 =?utf-8?B?UlZQKzdmalAxb2lVR21DQWxJUlZzSUltNkdYRFFjdnBWOXJWUittQjJsZFZ5?=
 =?utf-8?Q?F1G4hawDe0e0G9XEAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd6fcf-1f6c-450e-ac9e-08df46fe4a90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 12:03:29.8411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWNSyv1/a/x/m/il20o/1ddTUN7s1AJh88iLPAmAtM+3GSY+5NbOexUVXFt4lfDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB980390
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/26 15:40, Benjamin Cheng wrote:
> Normally last_unlocked lives on the same entity (vm->delayed) as the
> SDMA commit so they would use the same slot, but in this case handle_fault
> calls update_range in immediate mode, making the SDMA commit live in the
> immediate entity.
> 
> Since the two fences are not in the same entity, we need to reserve two
> fence slots here.
> 
> Fixes: 2b665c3735b3 ("drm/amdgpu: reserve fence slot to update page table")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
> v3:
> (Christian)
> - No TLB fence or TTM_NUM_MOVE_FENCES need to be added here.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 4d31c41fb684..b1d2779a2aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3187,7 +3187,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  		value = 0;
>  	}
>  
> -	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
> +	/* update_range operates in immediate mode here meaning the SDMA commit
> +	 * is on the immediate entity, while the last_unlocked comes from the
> +	 * delayed entity.
> + 	 */

Oh that is a good catch but clearly not the right way of fixing this.

We should not touch the last_unlocked fence in any way possible while doing an immediate update to handle a page fault.

My patch set already drops that handling, so we should be save for now. Please review patch "drm/amdgpu/vm: add amdgpu_vm_pt_leaves() v4" on the mailing list instead.

Thanks,
Christian.

> +	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 2);
>  	if (r) {
>  		pr_debug("failed %d to reserve fence slot\n", r);
>  		goto error_unlock;

