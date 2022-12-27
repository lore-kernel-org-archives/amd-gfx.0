Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA24C10F1B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Dec 2022 09:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D84710E092;
	Tue, 27 Dec 2022 09:32:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A65B10E092
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Dec 2022 09:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKsdGp8XM7d3DD3uUUqwoTStcb5weSKkbv2rpp2XJE5S3wQfesrYPAZ5S7i2Pfr+QujleqepbvMdgEqDecDPm72ocvPI1qky8CGzinKe2KqTBoJJ99U/c7sCFI/C7X7X85i/xXvHgDkTSLf78lqy5wL/Yhosd1YvqUeizOcOWgP5ggMa914DhLRaAaE/l54mSD9hqQ/wlgeQe5JgvUiZwD/1+6oaSo1COv9QFHDLjjVm2PLWVm3ZuT+iJM8kfL75n6ulvrVWZDRE8KnIQ3GxePxzmLMjDv6ONQI/5r4p9oUiYJbgAW5k1wFQ08j5Ciisye6WIyFW1fw4C5szPx8srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2VClk02t/A8strCXKiIK/tSB1r0zkA1yygDEG2DLRc=;
 b=Yp7+Zy3XPRRtBYodL+9dxKLtimNUaD+z6cW+gg1qFBmGF6PVYSyKGlO9nJk1hJxYkI/M7NfloJ2FHrBQYvO55/3ckUdUvFbJ3OkCn/0c9mndw7kvk6NDH4p6lbfJ96yjnmeX9ZlC1EkYawF6lv38CwgnOsZDCNkzsqjGslUQ0zPrspEO1LFCAU13BKnjojZLj0e1dWsKIt+B7LDYK7HBoEKW+647w1wZc+fuh4joJadWgtwmwGrWMqaemkL4TR2r7xJ2ZyKn/afVmlyylb2Ly9dS0W6Ce9qrpJ5izQiM4wr2NLW20XFJrHiqJOCYKnfrH3sVzxGhBuKB5n0UdD4sQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2VClk02t/A8strCXKiIK/tSB1r0zkA1yygDEG2DLRc=;
 b=dyzxZjmzajHVXxA0LgVFMRLYN6m+XFuuVgmRHKOL9vvoJaJWrt0CvhxewHvvkMkpVuFhA/8i7ODZ16z9+GgEi2StkxWA5ds3Fx2GB5iNPAfGjGxrHR1I+mngPn249zju4mziLNl9iIqe0F+6pS2AT518Zv1FKNlFhU8q8Ga8nhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 09:32:52 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c6ec:8cc8:ced1:1aac]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c6ec:8cc8:ced1:1aac%7]) with mapi id 15.20.5944.016; Tue, 27 Dec 2022
 09:32:51 +0000
Message-ID: <43791e54-efb1-1e30-b591-dfd7fe8aaf96@amd.com>
Date: Tue, 27 Dec 2022 15:02:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC 7/7] drm/amdgpu: Secure semaphore for usermode queue
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-8-shashank.sharma@amd.com>
 <CY5PR12MB63697DDDABCFB60476254AA6C1EF9@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CY5PR12MB63697DDDABCFB60476254AA6C1EF9@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|BL0PR12MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0305bfab-ede8-4495-2faa-08dae7ed534e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzenBVk0I2MX8T8fbC8uQTVa3aH1N0vxo+SX47xZVngVZvO3yMExGWdaDLuL1YT1eQx2hiyiS72yRgxA2xWlZy9YvI+BO4jrpGKnrcEdi4ZRcLX5Ny7kl1BZwGvr1CMZQudAL+DVkte0lLNFiziT5yddxEhKagSmA30DZ7GL3OaXcmIDv2F/FxjTdwjIZGjFmVikOYd2pn50Khk8iTxX8wmA6uCepKDPzqwyHIF8/SNNpfRO7th8a+2Vz70C0ZGdIBDVV6MuGE/kY+FYVKgAlvsARl37rOK5XonaWu+ZOld2Q5fTzlhb0DxbKIB51XP7isvr2uEuFerdGQZ1bMyZL3aVS9/N60naDtERpWF+aIobnjEm1Zg0vHCxTdvZ0FA2lR21NlX7l9MSt9mDZL02hhiC8ZkY8KmMSx2r5OX+fkGFZN7O0e83kjwtQWsgdhm4eh3XqBFhRNRzgZFbkZEzpaPrL7afcU/56nAkXapElrmL35YzDKK8lgYqQ/CJWdTMNGPPEum08+vSELn9WdaLh9dK5LYDK08XeANWsii7Nr7ygONqujBV5JrQoBPiTajv8QAY1pajIsHkd1AzACBDIGTAc12iHYQe7OAarwOaa64SvBpNAMeM8X4ojWKzdwMCwr1LGeC1L5Gq4kivMRENTW36LyI992Km+9y1jEn1xkRhC4RT3sxYK6PKF5W3S4JmE2J6OVvd+PZaNWqpmbYF2NGzl3UMTe1Dw/BWz/6hlgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(38100700002)(83380400001)(31696002)(8676002)(86362001)(4326008)(66476007)(66946007)(66556008)(41300700001)(316002)(54906003)(2906002)(30864003)(8936002)(5660300002)(2616005)(26005)(186003)(6512007)(6486002)(478600001)(53546011)(6666004)(6506007)(110136005)(36756003)(66899015)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdMQ0h3Rmp1Unl5THMvVXY4Mk1qbkxGVUxxYW41c2E2UkswKzl0cUtlTElw?=
 =?utf-8?B?TUJaWnFRVlBMOWl6eEhXZWtWemxVZnduQ01TUnhrOVRmcG05UERXdktNenlP?=
 =?utf-8?B?MHBkU0hPN1ZCOWJZcExFR1VmY1poYWhWd2l0NWsyQXpMMnZIQnNSeXN1MXdt?=
 =?utf-8?B?QnluRmhZeWhISzlwK2V0alhUeEdlcTZMdHNkOG01dUErQ1BqcTBmUFVRZGN0?=
 =?utf-8?B?RmYxK1FWMThYckdLWkoyczUvSkRpOGhROU1MTCtQeW9WVW0xeXBHbGE5ekdT?=
 =?utf-8?B?ZncyVStldkdVWTBObVpBRGtrdDJrNmFmVHhqRFhqRjFxWmduRHdhRytDSkRo?=
 =?utf-8?B?bWU5TFQyRHdTRHlBcldvMXQ3bmp4TXdJeTlhNE83TndKcitoaXdMb1RIdW4w?=
 =?utf-8?B?SzY5dVlOU1I3bkdrM1B0Q2NqMlFqS3FGSVdGYjF2WFBOUWlLYk5WLzRKTjVa?=
 =?utf-8?B?NkhXRVFieWY1WFVBcGxiTWpyV2JHZWV4RjFVNUNsK3c4TU41WHd2WmI1cTRS?=
 =?utf-8?B?Z1kyNEFVTGp6UW91cG52bnZlanM2QzdKbGNvQWJHbjRaazIrYzg1TkFUL0Ur?=
 =?utf-8?B?cUQzNEFPSkJmaWd6TE5HT0JrZzUweU5CSk5qMmZLc3l2ZXhYa2t0WkU1M2dM?=
 =?utf-8?B?MUJXdG9nWEJMSjhTTTRHRzd2cVpPYU9zcFdmcWw0Z2NhNHo3YXMvcDh6ZTVK?=
 =?utf-8?B?NStLN1RkNTBsSS8wM1BYNzZCeElFcFZleng5UUt5eVloNUw4VWpVSWY2SFVO?=
 =?utf-8?B?SXppd0J5YzVTTWREYjlxemFOTkxkdDJRb0dscUFaOS94Zy83UlVQdDFlQkgz?=
 =?utf-8?B?ZmtyaXVuTDV4WCtzU0JHR0MyZ0ZQTGdMdXB1QlhTM0p3My82bXlYbWtQZVZP?=
 =?utf-8?B?ek4xeFppZU1LOUZvcjdUcjQxSGlhL2F5SFROOTNkaDZsLzQ0R1NrZFZtLzBj?=
 =?utf-8?B?SjNoU1BFS2NiOGt3NTVsYnpJSEVYMzZFSDlkSVZrc3R6aEMvYWhYa1dCOW85?=
 =?utf-8?B?blpyN1J1Ykt4dDkwTmdkdW5EZ3ZORFpsQVNoeERTcm1Qck9aOGhxSDkwZWF5?=
 =?utf-8?B?c0hxVVZ3ME5MUnFtWGFSLytBS2F0RCtKVUhlbXkvQVNCcHQvQ0plQnJvSjVX?=
 =?utf-8?B?c0JuM0pTVUZPdXIrREduU0l2VjBVNks5WHhJeENMYjcxenhvZnZXRzUyTDNs?=
 =?utf-8?B?ODV4dkk4ZjkrdzI4dEtKSGVlalFXOHBFdmVBcHZyZVVKWlg2SXgwS2V2MFJG?=
 =?utf-8?B?K3ZzTWg1NUMrWFExMCsyc2pDb3VadjlEWEJyRnRxRDBXTHBoL2wzZ0xDSEw5?=
 =?utf-8?B?a05pdXlnb0dCZjJwYVI5SjAvTWE5Rzh5UlNHVWZaOURWSGFsaUpRYkJZeE5V?=
 =?utf-8?B?U1RlUTYyaHJxVEo5d2wrbG5obFU3dE5TanY4STdJS2ZuSk4zdVVsa3Y0dXRZ?=
 =?utf-8?B?clVBd1dtcU0wQi9kblpPTXVRTld6RjZLbm1seXBQeWRFcE82R0dBRWNUSm5Z?=
 =?utf-8?B?a3FUL0wzRkU2Y25EOXB5TVVocGV5Y3NhUlpVL2crWFlNdWRTNHVWUGJnZ2NH?=
 =?utf-8?B?cDJrYkpTUngyVmUzclUyUlR6YWQraEh5V3ZJVGpuek1qU1pObDN3TDFFblZQ?=
 =?utf-8?B?U0ZaeGFqSk14WGthczJzR29reXJvOXBiajRWb0tPZ1BSSWVDYmNXaG5WZ0Ru?=
 =?utf-8?B?bGxLR0hSWWkzaDZSWVBycU40ZzdkWGVJVUNnbDdoWmg1UlVORUwxQUVIY1Ay?=
 =?utf-8?B?cUxCaTFETVN5MmRhNGROK0RDbmdWT21vQ2VPdXB1UlN5aTJNWkkyMVRJYm1q?=
 =?utf-8?B?RXdpeTlSS3Z3c2JOK2Z2VWl6ZUE3N1hDblUwNjRwWmV3eHo1ZWgzVDY4bHJw?=
 =?utf-8?B?SWhMcW5mUUZsWmRPcGJqY2l1L3ljNE1Xb3NESmlGWXcwbyt4WTU1Mi9Hckc5?=
 =?utf-8?B?L3U2dCtUd2hIck0rdm43ZitXV1E0dTVwaGNUdCtteXlyeG5peENUaThwZ1Zo?=
 =?utf-8?B?NFEycFlhUTQ5WFBSUGs0VU9FNjBsU3Z0ZDlTVDN4SndPbmpvRERzOVBNdHBz?=
 =?utf-8?B?Q0d2cWF3TDJpZk91S1lHM3NmMzVzUzYrb216VGJDeGpMZXNNVkw0QUJqdWZ2?=
 =?utf-8?Q?2zenJmy4I2KO1MC8k2qxnohcF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0305bfab-ede8-4495-2faa-08dae7ed534e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2022 09:32:51.8650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt/G7kW6vdlQTJRqPByQCOtCll/A2b3uIfzG8uU6FqxRQCkEXQbQu9UCUf4X+j7xA4Vou6M7jXCWfOKQ7/tJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/25/2022 3:37 PM, Zhang, Yifan wrote:
> [Public]
>
> From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
>
> This is a WIP patch, which adds an kernel implementation of secure semaphore for the usermode queues. The UAPI for the same is yet to be implemented.
>
> The idea is to create a RO page and map it to each process requesting a user mode queue, and give them a qnique offset in the page, which can be polled (like wait_mem) for sync.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Shamra <shashank.sharma@amd.com>
>
> Signed-off-by: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   7 +-
>   .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++++++++++++
>   .../drm/amd/include/amdgpu_usermode_queue.h   |  10 +
>   .../amd/include/amdgpu_usermode_queue_mqd.h   |   4 +-
>   6 files changed, 272 insertions(+), 3 deletions(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index e2a34ee57bfb..daec7bb9ab3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -211,6 +211,7 @@ amdgpu-y += amdgpu_amdkfd.o
>   
>   # add usermode queue
>   amdgpu-y += amdgpu_userqueue.o
> +amdgpu-y += amdgpu_userqueue_secure_sem.o
>   
>   ifneq ($(CONFIG_HSA_AMD),)
>   AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 4b566fcfca18..7325c01efc90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -749,9 +749,17 @@ struct amdgpu_mqd {
>   			struct amdgpu_mqd_prop *p);
>   };
>   
> +struct amdgpu_userq_sec_sem {
> +	struct amdgpu_bo *sem_obj;
> +	u64 gpu_addr;
> +	u32 num_sem;
> +	unsigned long used[DIV_ROUND_UP(64, BITS_PER_LONG)]; };
> +
>   struct amdgpu_userq_globals {
>   	struct ida ida;
>   	struct mutex userq_mutex;
> +	struct amdgpu_userq_sec_sem sem;
>   };
>   
>   #define AMDGPU_RESET_MAGIC_NUM 64
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index b164e24247ca..2af634bbe3dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -261,6 +261,10 @@ amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_qu
>       /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>       mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
>   
> +    /* Setup semaphore fence address */
> +    mqd->fenceaddress_lo = queue->sem_data.sem_gpu_addr & 0xFFFFFFFC;
> +    mqd->fenceaddress_lo = upper_32_bits(queue->sem_data.sem_gpu_addr)
> + & 0xFFFF;
> +
>
> It should be mqd-> fenceaddress_high = upper_32_bits(queue->sem_data.sem_gpu_addr)  & 0xFFFF
yes, I think it got messed up in integration.

Thanks,
Arun.
>
>       /* activate the queue */
>       mqd->cp_gfx_hqd_active = 1;
>   }
> @@ -472,10 +476,11 @@ int amdgpu_userqueue_init(struct amdgpu_device *adev)
>       struct amdgpu_userq_globals *uqg = &adev->userq;
>   
>       mutex_init(&uqg->userq_mutex);
> +    amdgpu_userqueue_sec_sem_init(adev);
>       return 0;
>   }
>   
>   void amdgpu_userqueue_fini(struct amdgpu_device *adev)  {
> -
> +    amdgpu_userqueue_sec_sem_fini(adev);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
> new file mode 100644
> index 000000000000..6e6a7d62a300
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
> @@ -0,0 +1,245 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +#include "amdgpu.h"
> +#include "amdgpu_mes.h"
> +#include "amdgpu_usermode_queue.h"
> +#include "amdgpu_usermode_queue_mqd.h"
> +
> +static int amdgpu_userqueue_sem_addr_unmap(struct amdgpu_device *adev,
> +					   struct amdgpu_usermode_queue *q) {
> +    struct amdgpu_userq_sec_sem_data *sem_bo_data = &q->sem_data;
> +    struct amdgpu_bo_va *bo_va = sem_bo_data->sem_data_va;
> +    struct amdgpu_vm *vm = bo_va->base.vm;
> +    struct amdgpu_bo *bo = adev->userq.sem.sem_obj;
> +    struct amdgpu_bo_list_entry vm_pd;
> +    struct list_head list, duplicates;
> +    struct dma_fence *fence = NULL;
> +    struct ttm_validate_buffer tv;
> +    struct ww_acquire_ctx ticket;
> +    long r = 0;
> +
> +    INIT_LIST_HEAD(&list);
> +    INIT_LIST_HEAD(&duplicates);
> +
> +    tv.bo = &bo->tbo;
> +    tv.num_shared = 2;
> +    list_add(&tv.head, &list);
> +
> +    amdgpu_vm_get_pd_bo(vm, &list, &vm_pd);
> +
> +    r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
> +    if (r) {
> +        DRM_ERROR("leaking bo va because we fail to reserve bo (%ld)\n", r);
> +        return r;
> +    }
> +
> +    amdgpu_vm_bo_del(adev, bo_va);
> +    if (!amdgpu_vm_ready(vm))
> +        goto out_unlock;
> +
> +    r = dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP, &fence);
> +    if (r)
> +        goto out_unlock;
> +    if (fence) {
> +        amdgpu_bo_fence(bo, fence, true);
> +        fence = NULL;
> +    }
> +
> +    r = amdgpu_vm_clear_freed(adev, vm, &fence);
> +    if (r || !fence)
> +        goto out_unlock;
> +
> +    dma_fence_wait(fence, false);
> +    amdgpu_bo_fence(bo, fence, true);
> +    dma_fence_put(fence);
> +
> +out_unlock:
> +    if (unlikely(r < 0))
> +        DRM_ERROR("failed to clear page tables (%ld)\n", r);
> +    ttm_eu_backoff_reservation(&ticket, &list);
> +
> +    return r;
> +}
> +
> +static u64 amdgpu_sem_bo_vaddr(struct amdgpu_device *adev) {
> +       u64 addr = AMDGPU_VA_RESERVED_SIZE;
> +
> +       /* TODO:Find va address for sem bo mapping */
> +       return addr;
> +}
> +
> +static int amdgpu_userqueue_sem_addr_map(struct amdgpu_device *adev,
> +                                        struct amdgpu_usermode_queue
> +*q) {
> +    struct amdgpu_userq_sec_sem_data *sem_bo_data;
> +    struct amdgpu_bo *sem_obj = adev->userq.sem.sem_obj;
> +    struct ttm_validate_buffer csa_tv;
> +    struct amdgpu_bo_list_entry pd;
> +    struct ww_acquire_ctx ticket;
> +    struct amdgpu_vm *vm = q->vm;
> +    struct amdgpu_bo_va *bo_va;
> +    struct amdgpu_sync sync;
> +    struct list_head list;
> +    int r;
> +
> +    amdgpu_sync_create(&sync);
> +    INIT_LIST_HEAD(&list);
> +    INIT_LIST_HEAD(&csa_tv.head);
> +
> +    sem_bo_data = &q->sem_data;
> +
> +    csa_tv.bo = &sem_obj->tbo;
> +    csa_tv.num_shared = 1;
> +
> +    list_add(&csa_tv.head, &list);
> +    amdgpu_vm_get_pd_bo(vm, &list, &pd);
> +
> +    r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
> +    if (r) {
> +        DRM_ERROR("failed to reserve userqueue sec sem object BO: err=%d\n", r);
> +        return r;
> +    }
> +
> +    bo_va = amdgpu_vm_bo_add(adev, vm, sem_obj);
> +    if (!bo_va) {
> +        ttm_eu_backoff_reservation(&ticket, &list);
> +        DRM_ERROR("failed to create bo_va for userqueue sec sem object BO\n");
> +        return -ENOMEM;
> +    }
> +
> +    sem_bo_data->sem_gpu_addr = amdgpu_sem_bo_vaddr(adev);
> +    r = amdgpu_vm_bo_map(adev, bo_va, sem_bo_data->sem_gpu_addr, 0,
> +                        AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64),
> +                        AMDGPU_PTE_READABLE | AMDGPU_PTE_READABLE);
> +
> +    if (r) {
> +        DRM_ERROR("failed to do bo_map on sec sem object BO, err=%d\n", r);
> +        goto error;
> +    }
> +
> +    r = amdgpu_vm_bo_update(adev, bo_va, false);
> +    if (r) {
> +        DRM_ERROR("failed to do vm_bo_update on sec sem object BO\n");
> +        goto error;
> +    }
> +    amdgpu_sync_fence(&sync, bo_va->last_pt_update);
> +
> +    r = amdgpu_vm_update_pdes(adev, vm, false);
> +    if (r) {
> +        DRM_ERROR("failed to update pdes on sec sem object BO\n");
> +        goto error;
> +    }
> +    amdgpu_sync_fence(&sync, vm->last_update);
> +
> +    amdgpu_sync_wait(&sync, false);
> +    ttm_eu_backoff_reservation(&ticket, &list);
> +
> +    amdgpu_sync_free(&sync);
> +    sem_bo_data->sem_data_va = bo_va;
> +    return 0;
> +
> +error:
> +    amdgpu_vm_bo_del(adev, bo_va);
> +    ttm_eu_backoff_reservation(&ticket, &list);
> +    amdgpu_sync_free(&sync);
> +    return r;
> +}
> +
> +int amdgpu_userqueue_sec_sem_get(struct amdgpu_device *adev,
> +                            struct amdgpu_usermode_queue *q,
> +                            u64 *gpu_addr) {
> +    unsigned long offset = find_first_zero_bit(adev->userq.sem.used, adev->userq.sem.num_sem);
> +    u32 sem_offset;
> +    int r;
> +
> +    if (offset < adev->userq.sem.num_sem) {
> +        __set_bit(offset, adev->userq.sem.used);
> +        sem_offset = offset << 6; /* convert to qw offset */
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    r = amdgpu_userqueue_sem_addr_map(adev, q);
> +    if (r) {
> +        DRM_ERROR("failed to map sec sem object BO");
> +        amdgpu_userqueue_sem_addr_unmap(adev, q);
> +        return r;
> +    }
> +
> +    *gpu_addr = sem_offset + q->sem_data.sem_gpu_addr;
> +
> +    return 0;
> +}
> +
> +void amdgpu_userqueue_sec_sem_free(struct amdgpu_device *adev,
> +                                struct amdgpu_usermode_queue *q,
> +                                u32 sem) {
> +    int r;
> +
> +    r = amdgpu_userqueue_sem_addr_unmap(adev, q);
> +    if (r)
> +        DRM_ERROR("failed to unmap sec sem object BO");
> +
> +    sem >>= 6;
> +    if (sem < adev->userq.sem.num_sem)
> +        __clear_bit(sem, adev->userq.sem.used); }
> +
> +int
> +amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev) {
> +    int r;
> +
> +    if (adev->userq.sem.sem_obj == NULL) {
> +        /*
> +        * AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64) = AMDGPU_MAX_USERQUEUE_SEC_SEM
> +        * 64bit slots
> +        */
> +        r = amdgpu_bo_create_kernel(adev, AMDGPU_MAX_USERQUEUE_SEC_SEM * sizeof(u64),
> +                                    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT, &adev->userq.sem.sem_obj,
> +                                    &adev->userq.sem.gpu_addr, NULL);
> +        if (r) {
> +            DRM_ERROR("Create userqueue SEM bo failed, err %d\n", r);
> +            return r;
> +        }
> +
> +        adev->userq.sem.num_sem = AMDGPU_MAX_USERQUEUE_SEC_SEM;
> +        memset(&adev->userq.sem.used, 0, sizeof(adev->userq.sem.used));
> +    }
> +
> +    return 0;
> +}
> +
> +void
> +amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev) {
> +    if (adev->userq.sem.sem_obj) {
> +        amdgpu_bo_free_kernel(&adev->userq.sem.sem_obj,
> +                &adev->userq.sem.gpu_addr,
> +                NULL);
> +        adev->userq.sem.sem_obj = NULL;
> +    }
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> index 8bf3c0be6937..630d9b5d2423 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> @@ -25,6 +25,12 @@
>   #define AMDGPU_USERMODE_QUEUE_H_
>   
>   #define AMDGPU_MAX_USERQ 512
> +#define AMDGPU_MAX_USERQUEUE_SEC_SEM 64
> +
> +struct amdgpu_userq_sec_sem_data {
> +	u64 sem_gpu_addr;
> +	struct amdgpu_bo_va *sem_data_va;
> +};
>   
>   struct amdgpu_userq_ctx {
>   	struct amdgpu_bo *obj;
> @@ -52,7 +58,11 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_vm    	*vm;
>   	struct amdgpu_userq_ctx proc_ctx;
>   	struct amdgpu_userq_ctx gang_ctx;
> +
> +	struct amdgpu_userq_sec_sem_data sem_data;
>   	struct list_head 	list;
>   };
>   
> +int amdgpu_userqueue_sec_sem_init(struct amdgpu_device *adev); void
> +amdgpu_userqueue_sec_sem_fini(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
> index d0a285708ba5..e0bfb67d91f4 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
> @@ -35,8 +35,8 @@ struct amdgpu_usermode_queue_mqd
>   	uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>   	uint32_t shadow_initialized; // offset: 6  (0x6)
>   	uint32_t ib_vmid; // offset: 7  (0x7)
> -	uint32_t reserved_8; // offset: 8  (0x8)
> -	uint32_t reserved_9; // offset: 9  (0x9)
> +	uint32_t fenceaddress_lo; // offset: 8  (0x8)
> +	uint32_t fenceaddress_high; // offset: 9  (0x9)
>   	uint32_t reserved_10; // offset: 10  (0xA)
>   	uint32_t reserved_11; // offset: 11  (0xB)
>   	uint32_t reserved_12; // offset: 12  (0xC)
> --
> 2.34.1

