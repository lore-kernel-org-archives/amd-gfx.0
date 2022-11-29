Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACC9C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 23:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9E610E281;
	Tue, 29 Nov 2022 23:55:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED5910E281
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 23:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOv4YmUpSg2m3q0R29b1AQuC6dMCPbqfF8psPDJqbLZqimatL3HHxZn2ypCpEHfi4K3u/zwoJ6GMCFxqCgo+lFXRN8CTpX/lpZMGOYoWcEXWDzi8+J+XZF3nC/mqIyzWiynvp1Xs3tZgYMkpqmm9Z0LnB1o+ZbSzsxgr1maddk0isZ7hLg7fmuUMzxv8nmJPbcbISM5EaoNKQxrbhoG1uQrfxlvsJ77hfdN+XxEmaPJ/24v75mMvP/KvW1V2/cuKbFPtaa5foKbs5n/jTKRSbRuXZ20BO3zmJH1RQ6AiGHPQWtAmDfr17bZYWcdob/5FRp1TRNzhyIyMiKAU49fUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOCwNf0SGnrlbj0s/ZsohEGhrzXe5y5PLgeQoISo8HQ=;
 b=ZsJgM4pAoNon2N1xneYyj481Co0gauKW/HvsyKq0Ec1kjIKzU+Q8spYEmo4pUk3pqBZijCT10txk/nLYewq76Um2vY8yE/TnG7cltWmd8EOuIU3nbVw935vMoxwhIrrnQreF6TDm6qYQcVQhOMCwPHo5NARQMvlYRLZPA0qLhI2INYaUrL4LLmnlBM2IyB6owypDnGWzKn9AnCiyWA7qJXcGqsiz9CpA71fNnSiyMMOcGafKj+y08tC2lfVz2KtfshRQbDAU5H6ARsDywrhemZkPxnU2r4lG9CQC5NDDS3UlDWaWnnaeb0lvlIjKv36uPDkJTD2vKpAYbcukOkYMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOCwNf0SGnrlbj0s/ZsohEGhrzXe5y5PLgeQoISo8HQ=;
 b=UNtywflm6/ELTIU6yf11INL0bp3f1NbSb59AhncuReHT33bQvl3zqHJa0o/cC3XMvwhEhgp569fY7xhXmmn9YvdH/qi0jmPk/aJrl5GBWq9GnskM1apjbw9gdGaHn3Qt9L5lAetlKDOL8Wlp+8DXH+GEyu35KzgezFVjKMlcKiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 23:55:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 23:55:18 +0000
Message-ID: <b05ea898-76c8-f19c-06d8-c176e7877d8d@amd.com>
Date: Tue, 29 Nov 2022 18:55:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 22/29] drm/amdkfd: add debug suspend and resume process
 queues operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-22-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-22-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:610:75::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe4559e-0af6-4d06-0b1a-08dad2652aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1q0ndMnnfCYlC7SLuqURH+m/X6fwAf3VMWXbkuBB6WyXWrw8ZmCFAFFrf6zC6/b/luOjyYkKw2km+B9VklS4/FoF/QZ4M5LwJRUnki6U+FtdE6sJBwW6E2HhCA3CoQIabaMYFijQQ5lnEOAbN2bSAMqCmnpieljnquT1PR+ub3Rv2lqBvsPehsN9jTwVPTs5jjYtM8w+ioZz9XuGznlRbbrc6XbNDh05CDTNK8XTHYpFpJ/vdJncfNWIaudFLrF9zYpxq0SIvP3+vbQRakzxuL/H91oUTPM+Je3WpetdqW0uwiOaY6r13upAyvg7cfYG5JrvuO2PRWDGai6g9B6/wkSLDTwiiVZQ5KuYvfi1nbYgiRXbsTG4b+N/llNtGwD3RWgUgV8ZT0lHqRwnKAeqaamxzEk45FqKE73TZoGoLBfJ9HrpvtQH7QRi86tOfH0ujkCnC/MxGRqpwI9nRE4s8G9DJwubY36zu+Vg/tP3Hyze3dSvOVMwikdMlrEMBpDvsS4NKMlQOIwXlSq5InI6zEImKwQgqrk+/YU8wubAuebtHGD0C+HhhSzsNJ7dNsThgps/V0+Tj8/rzlTIvlmPcF0PMmL/pPmJOryRPZkxGRJ6m6ql951XeIuAx8DBzTm/IjAzqsXAQt1ChjD9rSGb/wfF/K0U/XI76472LGOuyBMd4931PIaibCl5f9Zl6duPaTFXg8MbUoR16TUcvOceWmcDx+qo/sQKfBfP+1p0Mfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(53546011)(36756003)(478600001)(6512007)(6506007)(6486002)(15650500001)(26005)(36916002)(38100700002)(66476007)(8676002)(66556008)(41300700001)(66946007)(86362001)(31696002)(4001150100001)(44832011)(30864003)(316002)(8936002)(5660300002)(186003)(2616005)(31686004)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGVtYm1HRW5wUmlOa2V4OG9JUWdOOHZXV0JnL0JlakRuZEozanNjQVJ6czBv?=
 =?utf-8?B?TUZpZzNNNnJCd2QvUVNMSW53U3NSQk50ZjA0UG1iVTFJOUFISmdZbWNSNmRD?=
 =?utf-8?B?alIxSHNjSDF5QmpTZDUxRzArQ3B5ZUpmdE1nMnNJVlZZOEwrbHJhelN0OVRt?=
 =?utf-8?B?YlFsT2JScEZNNzZEQ1c1dURzV2FQOUE1djR0UkVXR3BXRHJ5VFAwbHZ2UDE5?=
 =?utf-8?B?SU9UeWYzSzA2UkV5VWIyM0NBZWc3OXNoNE5RUEw5UitxeXhzOEloWWRpcjFw?=
 =?utf-8?B?OFpyN29qZ1gxRGc2YVJOWlgwdEVtNEdHRnVraENsRERTUE5LMHAza0Yxanph?=
 =?utf-8?B?ODlvTWVVWnRTMVRSeU9NemNHWjdBNGtuSjU3Z3pzbzR1cDRkT084K0ZmK0Fp?=
 =?utf-8?B?QjN1UnVrMEsvZGtHcmlTR2JWLzRYN1RwcHJRNmFSRXkwSjdPVGdWRHE2WFVV?=
 =?utf-8?B?SjFSLzV5Q2kweStEZnZWa3lTK1RPRDFZRVpHZ1BlV0crUWxVRXozY3EvLzZD?=
 =?utf-8?B?QmxvN2ZnblRjNDZmcWZxaVhmdkNtWUdrTTNBMXBVNTRDcnB2ZkoxbmtDc1pR?=
 =?utf-8?B?WXZVRGdsclJQbithc3lQZkw2OUE5TE9XYTB5QTFyOGNmd1NTT2xPUFAzUnN6?=
 =?utf-8?B?bjdTNmpSTHNvcVB4aFJXMTJySkxLRmgzeHluUk8wd3Y1QXhXeUNRZ2YzUzc0?=
 =?utf-8?B?a3pTM3ZPWTFLaXpPMys2b25SWWJZSDEzR3AzZ1AyOE40UWV2UDdUU3dpY2V2?=
 =?utf-8?B?MEV1OXJ3UVJIV041YUNVam1Hb1BXU3ZTL2pGaGpHYTBaQjZ1bytSemJ2NlVp?=
 =?utf-8?B?d25CUHFveUJLaW9BbU9iT1VQQWtZY3BCdENYRERhOG9pekV0TEVjUmJGTmlx?=
 =?utf-8?B?anprWTdvU0pYclMxNVBPRS9KS0diQkJNZ0xEZ1oxTG1uK2ZhL2o1RnA4NHJp?=
 =?utf-8?B?ZzRabjNuK3NGb0FxTHBGMS9aNy9KVnBnRTdqNTZIbGdJOHM4Mnk2U3pmVERz?=
 =?utf-8?B?b0ExaTZ6M21UNk1vR2ZzdFc4WTRBTnQzSmpSSXBCRXZlNHQzOTlvMmFYem9G?=
 =?utf-8?B?eG1zYzJhMnVMWitTVkJKbDNhZ0JoQjUzOHVMbnRobG16dFBoYkx0TlAzMnl6?=
 =?utf-8?B?bkIyOG5iZkh5MjZMSTRDM3ZtWnVNL1pJUTFKSlYzREo3T1k4WThjdlluVkI2?=
 =?utf-8?B?ckFLNVowSHMyM2JIMWg0NFJjMjBaUE14UnB1Yk9URVdPTEVJcEpuTkcxbmdu?=
 =?utf-8?B?bkhEdFc1NWhRZmUySkVTenFweENMbGdZUTZuM2dTWS9mSnlFS0xrT2RiVU9i?=
 =?utf-8?B?MVRIZGwyTGlpbXJZdzB6R0ZSMlRwYzdDSXNlR0NHeHFtUXFuUzJ4MkJmMWtq?=
 =?utf-8?B?eWpvdUQwUm8xbmVETDBNcC9IdVJROEpTL2lYbVg1TmNiaDB2NFgwT3hHM0Jl?=
 =?utf-8?B?VDhRSzRvMjdpSWJCcWRvUzNUeVM4bWhjZ2FPZm9ia2FCclpmSVl4UDNiTjd1?=
 =?utf-8?B?MzZ2L0M5M2gyaXI1Ump1YjVFb2Q3NGZCN3pKOVVEdTdoQXh2a1BiUDRObS9T?=
 =?utf-8?B?L3ZvQ3phbVVGcmhjbm53eFRnZUY1amJUK0orMG5tOEF2ZFB5cFlzWTY2SzNB?=
 =?utf-8?B?UzR4OVkzU2I5U1h3bnVBcUNrdHZFb1llUFdmRFBCV3VXWFV6cmJQSEgweHR5?=
 =?utf-8?B?amZGYTB4ZHErck4wRWs3T0dBK2hPSGRUUktJdVNlMGJWMTIyQnFCOTBSTFBC?=
 =?utf-8?B?d2VLR0NKamFFY0VVSnZIRTJEandIK0ZMUk5DL21KZEtBbzVoNTZST05YbHZS?=
 =?utf-8?B?cmFlcnIxUmZ2R045bzFSdVRYV0NNYk1MVlUrRXNnNWNVSzFueGd0cDBMMW1z?=
 =?utf-8?B?L0hTWGVHbXJWN2VYQlJtc1pETWx0Z0hyUURjbGI0dEFyZUNUQndUNWIrM1Zl?=
 =?utf-8?B?UDFXelB1eXhRK0hNU2EzbmwxNDh3SjJTMnpYQ0U5RjJoWlFiUm0xNTlzdUtt?=
 =?utf-8?B?RXQ5SzBONk4zbTA2eWJlekZLbkNsKzc1Y3ZvVGluMkVUeGh6MGg4Si9nYVhJ?=
 =?utf-8?B?N2oybEJ5ZVk3OUJ5ZUxmRFd6RXFOOXR4d01DV2U1eThEL0daRkxESUFMbXhD?=
 =?utf-8?Q?ozS6CJnioLjSMYjbpB8coi6Xf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe4559e-0af6-4d06-0b1a-08dad2652aca
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 23:55:17.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPPRPv0+z3iPW26+dVbucKyhO1YYcoYxUkxAOdlW6oN+aGZ5jLfKyehl4x6WT7jGh/wn6Q1J7IBeiNHkaPx2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> In order to inspect waves from the saved context at any point during a
> debug session, the debugger must be able to preempt queues to trigger
> context save by suspending them.
>
> On queue suspend, the KFD will copy the context save header information
> so that the debugger can correctly crawl the appropriate size of the saved
> context. The debugger must then also be allowed to resume suspended queues.
>
> A queue that is newly created cannot be suspended because queue ids are
> recycled after destruction so the debugger needs to know that this has
> occurred.  Query functions will be later added that will clear a given
> queue of its new queue status.
>
> A queue cannot be destroyed while it is suspended to preserve its saved
> context during debugger inspection.  Have queue destruction block while
> a queue is suspended and unblocked when it is resumed.  Likewise, if a
> queue is about to be destroyed, it cannot be suspended.
>
> Return the number of queues successfully suspended or resumed along with
> a per queue status array where the upper bits per queue status show that
> the request was invalid (new/destroyed queue suspend request, missing
> queue) or an error occurred (HWS in a fatal state so it can't suspend or
> resume queues).
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Some nit-picks inline. Other than that, this patch looks good to me.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  12 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   7 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 401 +++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  11 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  10 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  14 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   5 +-
>   7 files changed, 454 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 63665279ce4d..ec26c51177f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -410,6 +410,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	pr_debug("Write ptr address   == 0x%016llX\n",
>   			args->write_pointer_address);
>   
> +	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev, queue_id, false, NULL, 0);
>   	return 0;
>   
>   err_create_queue:
> @@ -2903,7 +2904,18 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				args->launch_mode.launch_mode);
>   		break;
>   	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
> +		r = suspend_queues(target,
> +				args->suspend_queues.num_queues,
> +				args->suspend_queues.grace_period,
> +				args->suspend_queues.exception_mask,
> +				(uint32_t *)args->suspend_queues.queue_array_ptr);
> +
> +		break;
>   	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
> +		r = resume_queues(target, false,
> +				args->resume_queues.num_queues,
> +				(uint32_t *)args->resume_queues.queue_array_ptr);
> +		break;
>   	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
>   	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
>   	case KFD_IOC_DBG_TRAP_SET_FLAGS:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 210851f2cdb3..afa56aad316b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -274,6 +274,13 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   
>   		count++;
>   	}
> +
> +	if (!unwind) {
> +		int resume_count = resume_queues(target, true, 0, NULL);
> +
> +		if (resume_count)
> +			pr_debug("Resumed %d queues\n", resume_count);
> +	}
>   }
>   
>   static void kfd_dbg_clean_exception_status(struct kfd_process *target)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index bf4787b4dc6c..589efbefc8dc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -921,6 +921,79 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	return retval;
>   }
>   
> +/* suspend_single_queue does not lock the dqm like the
> + * evict_process_queues_cpsch or evict_process_queues_nocpsch. You should
> + * lock the dqm before calling, and unlock after calling.
> + *
> + * The reason we don't lock the dqm is because this function may be
> + * called on multiple queues in a loop, so rather than locking/unlocking
> + * multiple times, we will just keep the dqm locked for all of the calls.
> + */
> +static int suspend_single_queue(struct device_queue_manager *dqm,
> +				      struct kfd_process_device *pdd,
> +				      struct queue *q)
> +{
> +	bool is_new;
> +
> +	if (q->properties.is_suspended)
> +		return 0;
> +
> +	pr_debug("Suspending PASID %u queue [%i]\n",
> +			pdd->process->pasid,
> +			q->properties.queue_id);
> +
> +	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
> +
> +	if (is_new || q->properties.is_being_destroyed) {
> +		pr_debug("Suspend: skip %s queue id %i\n",
> +				is_new ? "new" : "destroyed",
> +				q->properties.queue_id);
> +		return -EBUSY;
> +	}
> +
> +	q->properties.is_suspended = true;
> +	if (q->properties.is_active) {
> +		decrement_queue_count(dqm, &pdd->qpd, q);
> +		q->properties.is_active = false;
> +	}
> +
> +	return 0;
> +}
> +
> +/* resume_single_queue does not lock the dqm like the functions
> + * restore_process_queues_cpsch or restore_process_queues_nocpsch. You should
> + * lock the dqm before calling, and unlock after calling.
> + *
> + * The reason we don't lock the dqm is because this function may be
> + * called on multiple queues in a loop, so rather than locking/unlocking
> + * multiple times, we will just keep the dqm locked for all of the calls.
> + */
> +static void resume_single_queue(struct device_queue_manager *dqm,
> +				      struct qcm_process_device *qpd,
> +				      struct queue *q)
> +{
> +	struct kfd_process_device *pdd;
> +	uint64_t pd_base;
> +
> +	if (!q->properties.is_suspended)
> +		return;
> +
> +	pdd = qpd_to_pdd(qpd);
> +	/* Retrieve PD base */
> +	pd_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);

This variable seems to be unused.


> +
> +	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
> +			    pdd->process->pasid,
> +			    q->properties.queue_id);
> +
> +	q->properties.is_suspended = false;
> +
> +	if (QUEUE_IS_ACTIVE(q->properties)) {
> +		q->properties.is_active = true;
> +		increment_queue_count(dqm, qpd, q);
> +	}
> +}
> +
>   static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   					struct qcm_process_device *qpd)
>   {
> @@ -1885,6 +1958,31 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   	return map_queues_cpsch(dqm);
>   }
>   
> +static int wait_on_destroy_queue(struct device_queue_manager *dqm,
> +				 struct queue *q)
> +{
> +	struct kfd_process_device *pdd = kfd_get_process_device_data(q->device,
> +								q->process);
> +	int ret = 0;
> +
> +	if (pdd->qpd.is_debug)
> +		return ret;
> +
> +	q->properties.is_being_destroyed = true;
> +
> +	if (pdd->process->debug_trap_enabled && q->properties.is_suspended) {
> +		dqm_unlock(dqm);
> +		mutex_unlock(&q->process->mutex);
> +		ret = wait_event_interruptible(dqm->destroy_wait,
> +						!q->properties.is_suspended);
> +
> +		mutex_lock(&q->process->mutex);
> +		dqm_lock(dqm);
> +	}
> +
> +	return ret;
> +}
> +
>   static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   				struct qcm_process_device *qpd,
>   				struct queue *q)
> @@ -1904,11 +2002,16 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   				q->properties.queue_id);
>   	}
>   
> -	retval = 0;
> -
>   	/* remove queue from list to prevent rescheduling after preemption */
>   	dqm_lock(dqm);
>   
> +	retval = wait_on_destroy_queue(dqm, q);
> +
> +	if (retval) {
> +		dqm_unlock(dqm);
> +		return retval;
> +	}
> +
>   	if (qpd->is_debug) {
>   		/*
>   		 * error, currently we do not allow to destroy a queue
> @@ -1954,7 +2057,17 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   
>   	dqm_unlock(dqm);
>   
> -	/* Do free_mqd after dqm_unlock(dqm) to avoid circular locking */
> +	/*
> +	 * Do free_mqd and delete raise event after dqm_unlock(dqm) to avoid

I think this was meant to say "... raise delete event ...".


> +	 * circular locking
> +	 */
> +	kfd_dbg_ev_raise(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE),
> +			qpd->pqm->process,
> +			q->device,
> +			-1,
> +			false,
> +			NULL,
> +			0);

One line per parameter seems excessive here. The last 4 parameters are 
basically N/A. I think this is more readable:

+	kfd_dbg_ev_raise(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE),
+			qpd->pqm->process, q->device,
+			-1, false, NULL, 0);


>   	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
>   
>   	return retval;
> @@ -2418,8 +2531,10 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
>   		goto out_free;
>   	}
>   
> -	if (!dqm->ops.initialize(dqm))
> +	if (!dqm->ops.initialize(dqm)) {
> +		init_waitqueue_head(&dqm->destroy_wait);
>   		return dqm;
> +	}
>   
>   out_free:
>   	kfree(dqm);
> @@ -2557,6 +2672,284 @@ int release_debug_trap_vmid(struct device_queue_manager *dqm,
>   	return r;
>   }
>   
> +#define QUEUE_NOT_FOUND		-1
> +/* invalidate queue operation in array */
> +static void q_array_invalidate(uint32_t num_queues, uint32_t *queue_ids)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_queues; i++)
> +		queue_ids[i] |= KFD_DBG_QUEUE_INVALID_MASK;
> +}
> +
> +/* find queue index in array */
> +static int q_array_get_index(unsigned int queue_id,
> +		uint32_t num_queues,
> +		uint32_t *queue_ids)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_queues; i++)
> +		if (queue_id == (queue_ids[i] & ~KFD_DBG_QUEUE_INVALID_MASK))
> +			return i;
> +
> +	return QUEUE_NOT_FOUND;
> +}
> +
> +struct copy_context_work_handler_workarea {
> +	struct work_struct copy_context_work;
> +	struct kfd_process *p;
> +};
> +
> +static void copy_context_work_handler (struct work_struct *work)
> +{
> +	struct copy_context_work_handler_workarea *workarea;
> +	struct mqd_manager *mqd_mgr;
> +	struct queue *q;
> +	struct mm_struct *mm;
> +	struct kfd_process *p;
> +	uint32_t tmp_ctl_stack_used_size, tmp_save_area_used_size;
> +	int i;
> +
> +	workarea = container_of(work,
> +			struct copy_context_work_handler_workarea,
> +			copy_context_work);
> +
> +	p = workarea->p;
> +	mm = get_task_mm(p->lead_thread);
> +
> +	if (!mm)
> +		return;
> +
> +	kthread_use_mm(mm);
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct device_queue_manager *dqm = pdd->dev->dqm;
> +		struct qcm_process_device *qpd = &pdd->qpd;
> +
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_CP];
> +
> +			/* We ignore the return value from get_wave_state
> +			 * because
> +			 * i) right now, it always returns 0, and
> +			 * ii) if we hit an error, we would continue to the
> +			 *      next queue anyway.
> +			 */
> +			mqd_mgr->get_wave_state(mqd_mgr,
> +					q->mqd,
> +					(void __user *)	q->properties.ctx_save_restore_area_address,
> +					&tmp_ctl_stack_used_size,
> +					&tmp_save_area_used_size);
> +		}
> +	}
> +	kthread_unuse_mm(mm);
> +	mmput(mm);
> +}
> +
> +static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
> +{
> +	size_t array_size = num_queues * sizeof(uint32_t);
> +	uint32_t *queue_ids = NULL;
> +
> +	if (!usr_queue_id_array)
> +		return NULL;
> +
> +	queue_ids = kzalloc(array_size, GFP_KERNEL);
> +	if (!queue_ids)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (copy_from_user(queue_ids, usr_queue_id_array, array_size))
> +		return ERR_PTR(-EFAULT);
> +
> +	return queue_ids;
> +}
> +
> +int resume_queues(struct kfd_process *p,
> +		bool resume_all_queues,
> +		uint32_t num_queues,
> +		uint32_t *usr_queue_id_array)
> +{
> +	uint32_t *queue_ids = get_queue_ids(num_queues, usr_queue_id_array);
> +	int total_resumed = 0;
> +	int i;
> +
> +	if (!resume_all_queues && IS_ERR(queue_ids))
> +		return PTR_ERR(queue_ids);
> +
> +	/* mask all queues as invalid.  unmask per successful request */
> +	if (!resume_all_queues)
> +		q_array_invalidate(num_queues, queue_ids);
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct device_queue_manager *dqm = pdd->dev->dqm;
> +		struct qcm_process_device *qpd = &pdd->qpd;
> +		struct queue *q;
> +		int r, per_device_resumed = 0;
> +
> +		dqm_lock(dqm);
> +
> +		/* unmask queues that resume or already resumed as valid */
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			int q_idx = QUEUE_NOT_FOUND;
> +
> +			if (queue_ids)
> +				q_idx = q_array_get_index(
> +						q->properties.queue_id,
> +						num_queues,
> +						queue_ids);
> +
> +			if (resume_all_queues || q_idx != QUEUE_NOT_FOUND) {
> +				resume_single_queue(dqm, &pdd->qpd, q);
> +				if (queue_ids)
> +					queue_ids[q_idx] &=
> +						~KFD_DBG_QUEUE_INVALID_MASK;
> +				per_device_resumed++;
> +			}
> +		}
> +
> +		if (!per_device_resumed) {
> +			dqm_unlock(dqm);
> +			continue;
> +		}
> +
> +		r = execute_queues_cpsch(dqm,
> +					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
> +					0,
> +					USE_DEFAULT_GRACE_PERIOD);
> +		if (r) {
> +			pr_err("Failed to resume process queues\n");
> +			if (!resume_all_queues) {
> +				list_for_each_entry(q, &qpd->queues_list, list) {
> +					int q_idx = q_array_get_index(
> +							q->properties.queue_id,
> +							num_queues,
> +							queue_ids);
> +
> +					/* mask queue as error on resume fail */
> +					if (q_idx != QUEUE_NOT_FOUND)
> +						queue_ids[q_idx] |=
> +							KFD_DBG_QUEUE_ERROR_MASK;
> +				}
> +			}
> +		} else {
> +			wake_up_all(&dqm->destroy_wait);
> +			total_resumed += per_device_resumed;
> +		}
> +
> +		dqm_unlock(dqm);
> +	}
> +
> +	if (copy_to_user((void __user *)usr_queue_id_array, queue_ids,
> +			num_queues * sizeof(uint32_t)))

I think we should skip this if resume_all_queues is true, because the 
queue array pointer is NULL in that case. I think we get away with it 
because num_queues is also 0 and copy_to_user becomes a NOP, but seems a 
bit weird.

	if (!resume_all_queues && copy_to_user(...))

Also, if it's legal to call this from user mode with usr_queue_id_array 
== NULL, we should instead check

	if (usr_queue_id_array && copy_to_user(...))

Maybe we could just replace the resume_all_queues parameter with a check 
for !usr_queue_id_array.

Regards,
   Felix


> +		pr_err("copy_to_user failed on queue resume\n");
> +
> +	kfree(queue_ids);
> +
> +	return total_resumed;
> +}
> +
> +int suspend_queues(struct kfd_process *p,
> +			uint32_t num_queues,
> +			uint32_t grace_period,
> +			uint64_t exception_clear_mask,
> +			uint32_t *usr_queue_id_array)
> +{
> +	uint32_t *queue_ids = get_queue_ids(num_queues, usr_queue_id_array);
> +	int total_suspended = 0;
> +	int i;
> +
> +	if (IS_ERR(queue_ids))
> +		return PTR_ERR(queue_ids);
> +
> +	/* mask all queues as invalid.  umask on successful request */
> +	q_array_invalidate(num_queues, queue_ids);
> +
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +		struct device_queue_manager *dqm = pdd->dev->dqm;
> +		struct qcm_process_device *qpd = &pdd->qpd;
> +		struct queue *q;
> +		int r, per_device_suspended = 0;
> +
> +		mutex_lock(&p->event_mutex);
> +		dqm_lock(dqm);
> +
> +		/* unmask queues that suspend or already suspended */
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			int q_idx = q_array_get_index(q->properties.queue_id,
> +							num_queues,
> +							queue_ids);
> +
> +			if (q_idx != QUEUE_NOT_FOUND &&
> +					!suspend_single_queue(dqm, pdd, q)) {
> +				queue_ids[q_idx] &=
> +					~KFD_DBG_QUEUE_INVALID_MASK;
> +				per_device_suspended++;
> +			}
> +		}
> +
> +		if (!per_device_suspended) {
> +			dqm_unlock(dqm);
> +			mutex_unlock(&p->event_mutex);
> +			continue;
> +		}
> +
> +		r = execute_queues_cpsch(dqm,
> +			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
> +			grace_period);
> +
> +		if (r)
> +			pr_err("Failed to suspend process queues.\n");
> +		else
> +			total_suspended += per_device_suspended;
> +
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			int q_idx = q_array_get_index(q->properties.queue_id,
> +						num_queues, queue_ids);
> +
> +			if (q_idx == QUEUE_NOT_FOUND)
> +				continue;
> +
> +			/* mask queue as error on suspend fail */
> +			if (r)
> +				queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
> +			else if (exception_clear_mask)
> +				q->properties.exception_status &=
> +							~exception_clear_mask;
> +		}
> +
> +		dqm_unlock(dqm);
> +		mutex_unlock(&p->event_mutex);
> +		amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
> +	}
> +
> +	if (total_suspended) {
> +		struct copy_context_work_handler_workarea copy_context_worker;
> +
> +		INIT_WORK_ONSTACK(
> +				&copy_context_worker.copy_context_work,
> +				copy_context_work_handler);
> +
> +		copy_context_worker.p = p;
> +
> +		schedule_work(&copy_context_worker.copy_context_work);
> +
> +
> +		flush_work(&copy_context_worker.copy_context_work);
> +		destroy_work_on_stack(&copy_context_worker.copy_context_work);
> +	}
> +
> +	if (copy_to_user((void __user *)usr_queue_id_array, queue_ids,
> +			num_queues * sizeof(uint32_t)))
> +		pr_err("copy_to_user failed on queue suspend\n");
> +
> +	kfree(queue_ids);
> +
> +	return total_suspended;
> +}
> +
>   int debug_lock_and_unmap(struct device_queue_manager *dqm)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index bef3be84c5cc..12643528684c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -259,6 +259,8 @@ struct device_queue_manager {
>   	struct kfd_mem_obj	hiq_sdma_mqd;
>   	bool			sched_running;
>   	uint32_t		wait_times;
> +
> +	wait_queue_head_t	destroy_wait;
>   };
>   
>   void device_queue_manager_init_cik(
> @@ -286,6 +288,15 @@ int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd);
>   int release_debug_trap_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd);
> +int suspend_queues(struct kfd_process *p,
> +			uint32_t num_queues,
> +			uint32_t grace_period,
> +			uint64_t exception_clear_mask,
> +			uint32_t *usr_queue_id_array);
> +int resume_queues(struct kfd_process *p,
> +		bool resume_all_queues,
> +		uint32_t num_queues,
> +		uint32_t *usr_queue_id_array);
>   int debug_lock_and_unmap(struct device_queue_manager *dqm);
>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>   int debug_refresh_runlist(struct device_queue_manager *dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index cb484ace17de..d74862755213 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -237,6 +237,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  u32 *save_area_used_size)
>   {
>   	struct v10_compute_mqd *m;
> +	struct kfd_context_save_area_header header;
>   
>   	m = get_mqd(mqd);
>   
> @@ -255,6 +256,15 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   	 * accessible to user mode
>   	 */
>   
> +	header.control_stack_size = *ctl_stack_used_size;
> +	header.wave_state_size = *save_area_used_size;
> +
> +	header.wave_state_offset = m->cp_hqd_wg_state_offset;
> +	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
> +
> +	if (copy_to_user(ctl_stack, &header, sizeof(header)))
> +		return -EFAULT;
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 86f1cf090246..f05a2bed655a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -289,6 +289,7 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  u32 *save_area_used_size)
>   {
>   	struct v9_mqd *m;
> +	struct kfd_context_save_area_header header;
>   
>   	/* Control stack is located one page after MQD. */
>   	void *mqd_ctl_stack = (void *)((uintptr_t)mqd + PAGE_SIZE);
> @@ -300,7 +301,18 @@ static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   	*save_area_used_size = m->cp_hqd_wg_state_offset -
>   		m->cp_hqd_cntl_stack_size;
>   
> -	if (copy_to_user(ctl_stack, mqd_ctl_stack, m->cp_hqd_cntl_stack_size))
> +	header.control_stack_size = *ctl_stack_used_size;
> +	header.wave_state_size = *save_area_used_size;
> +
> +	header.wave_state_offset = m->cp_hqd_wg_state_offset;
> +	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
> +
> +	if (copy_to_user(ctl_stack, &header, sizeof(header)))
> +		return -EFAULT;
> +
> +	if (copy_to_user(ctl_stack + m->cp_hqd_cntl_stack_offset,
> +				mqd_ctl_stack + m->cp_hqd_cntl_stack_offset,
> +				*ctl_stack_used_size))
>   		return -EFAULT;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index bd3d8a0b61b7..3d529c7499f8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -477,6 +477,8 @@ struct queue_properties {
>   	uint32_t doorbell_off;
>   	bool is_interop;
>   	bool is_evicted;
> +	bool is_suspended;
> +	bool is_being_destroyed;
>   	bool is_active;
>   	bool is_gws;
>   	/* Not relevant for user mode queues in cp scheduling */
> @@ -499,7 +501,8 @@ struct queue_properties {
>   #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
>   			    (q).queue_address != 0 &&	\
>   			    (q).queue_percent > 0 &&	\
> -			    !(q).is_evicted)
> +			    !(q).is_evicted &&		\
> +			    !(q).is_suspended)
>   
>   enum mqd_update_flag {
>   	UPDATE_FLAG_CU_MASK = 0,
