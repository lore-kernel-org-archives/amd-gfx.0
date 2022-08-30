Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2961FECAAD4
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 22:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544E310E30E;
	Tue, 30 Aug 2022 22:47:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD4110E301
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 22:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLtBa+MNhfWTzRP92GTZ+MSHLhLcsl8furtENK1K3jxLyXyA29l2mcBvrxTuqQYSpdFHx1qisk1LGMX5E8rv2+uLKLifTqX/mNhigu5e1Q+o7zYEKKAtNhLbVaWViIV5cw5IeJPUFM9HkK9HpBx6NGm/yTe36VuCyAk1p2JQiNIk7JoVfO1NGB0aBmj2DMUvDhz17mLjF7Nae8LLSt1aJj7B05QjVioFpI7dhrF8UOgRJVlAgA1gBRTjtStk3kWlkxYpzMVaZu8s2gyyKsA+J8EVhdKys4LvP/kMM4NNazr8q2DwT1iCJhdns237UQ90NVJj6gXDL/yu31ElnHKMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx+wj6jQomwCzeStt8Hu8dcgsCQUKswhH6nX8tGkA2Y=;
 b=NAv1Hu/B7wPO0si+rDHpc+Bsa/UyRv2EwZAfBA1R/tpn8jB1y/ujcuSGordGiJfjXEOQV6D+AAtTda3hyqpdyFzXApawaO61b6C0ggRjP2/IbN2dQPA7Kvpg8hxrYWDR9W9kp+HpxeFfmjcwT+wde14DKZQkqPpRBjd6SM4XPgoO4h6dgNSWGfgoLf47a2qWIu3Ceg3kVeeuJ6PufR4W7RsjbX/asoamAqyfrx40UG/gyl5KIFbwXYvqa9KDHJ9Y2jRkaKerCoKUMGxQ+wqSjQ6zP9EdQ0vsohGJrcOF3mjfDcF0hRLi2sanfJrCaZ3lN8DQ/LpXP+OiSbtD0UQ2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx+wj6jQomwCzeStt8Hu8dcgsCQUKswhH6nX8tGkA2Y=;
 b=1tyaEn/TL59CljqGFRNBs6wA++7WtG8q5k5spq9YUnru+/6jwd8HrwlqWE0HCcrMK9j+vqKaBeYxYrSZWV4f2uaXs2ccLq97zdmSkPhgmVmIYM0xQJEDwT+BU0uPsUAWwWY+uKXIR+iclo6mOLP/ev/T6rSzX2uiiuA92iXZTNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 22:46:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:46:55 +0000
Message-ID: <ac3ff7df-5fea-d8e9-7996-df8ece678d50@amd.com>
Date: Tue, 30 Aug 2022 18:46:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/29] drm/amdkfd: add debug and runtime enable interface
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
 <20220829143026.1509027-2-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220829143026.1509027-2-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:610:10e::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515a77b3-980d-45b4-2366-08da8ad989df
X-MS-TrafficTypeDiagnostic: BY5PR12MB4132:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p9fg+nN6QAa+59dIsq/bRbM9x+9by3GiMFj3K/ADiAz+B7cXPyveX6gE5RROl1JwpGHdyVBdz2iBph0mqhu7P9tJ8emV0X1BJywOwvnix+5+0kZf+qLdsg9NV1OSyxiuPaS/bKfEY8q1zeppn8IE4chhb0+5sKTFCVbAX0UCRkLgR8IXYT//48a1DD/57C++GPw3LLp03kmY4+7EdIWqlBsrqs2QMUD1peVDMUZV8JfGHORhyg56RyG3W37Ap20IAxR/rDs68g71v53m8EhMNIutR8/XTQe/BOm9sHH1gokntJGHQrmt9ZwO1yOMdtrhHO9AevZiccp2Og0gZuUTifu6fhMcTLbqk7naNuzWKfwwVqoSAF0nS/Kno0KciBMA9xFkOFo2DW6rsA4hoYUEWL2GH7sbayjj9lf5/PbM2i/p34xX9MOvqesnKKMZZsTubzL2huoChhmubRRpItuPa5RvQLxcxKmXl5x0fSBiN9hxs7eFP0UDmE5ziC+6KGTLKNV6gPwETcaPUkKzsCy5wxvu32BbxiypI14c8tstDL75w6GhsAq/uOom/PcWKTKwKEF2AH4rIzI081FbgjwTmiBcxPClV6jMP0r/qmz6Lc9Rv8mFZEm0OHXNYR2/DnQsKOTVY99b1SRtQIHQx4V4DbX5eIDIFi3Hdanb+gVOFB+i+iFQ87W743zZXeLS/vdL7FJPcW4kv8E18TTIhbNumMYbEo5W14w3Ey79alWZZxTSohuK78c6uCZD0jROZ7bg70pqgG/U6a2v/VOl3e9cbtSefGn5UNQaFogvlYpZlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(186003)(2616005)(4326008)(30864003)(44832011)(2906002)(8936002)(8676002)(66556008)(66946007)(66476007)(5660300002)(6512007)(478600001)(31686004)(36756003)(6506007)(36916002)(26005)(53546011)(83380400001)(6486002)(41300700001)(86362001)(31696002)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BCbGZzdG5XYkpPVHdzdE9oc0huS2NqWDNzOWtJbm5uRjVtMExjRGgvbFlN?=
 =?utf-8?B?Vk5kaloyd3FLQjZtdlJ0MXh5Y0lMVGVDN2ZsSUtwRHBvZU54QWZYd2tZTjBl?=
 =?utf-8?B?OW1ic3VvRXZQUjhYT2pVRVRnbUp0WmdqRGUrWEZ1akVjZjRzUllKWUxOdjFa?=
 =?utf-8?B?SXRuZitUUHU4T3J3aXRLNGVnY2VTeml3N1BKZ1dLYUY0ODlORjB1M3ZBaVpz?=
 =?utf-8?B?VkQzSXMyL3B2VVladGM0THlqMmx2cjlBN3YwQm94SzJPZldFMjJWQTdlWm40?=
 =?utf-8?B?ejZINnlEdExmVTJVQ3FNK1FCZkJvZklrRmttRmZGR3BJK2ptOEFKUDJsVzJJ?=
 =?utf-8?B?dVp3TTFET0oxQnIrdGFJS3ZWM20wU2RSa0t4QU1NV1A3M2s4ZThuRm9DdElB?=
 =?utf-8?B?Vmp6U21sb1lJZG0vNVAzYVRHSmJlVTNsdkVGYVd3MnhsdWwrNU4rZE5WejM5?=
 =?utf-8?B?K094Q29UVGxmNVMwOE56MmxsUWM0R1ArV2lkQ1ZFSVFiQ24vR2IyTlo1UUYv?=
 =?utf-8?B?MnlPSnhhQmNyTmU3VUg3L0MyZ0svV0lKd2VwakFreEl3U0NnaUlNQnVWc0dH?=
 =?utf-8?B?TmsraHY2aVVmanNmaFNmb2ptYzN0dVdYNEViMXVDUXFVLzEyMzBiS1oxTFZN?=
 =?utf-8?B?RWlvSDBxbkJxVjdFK2hVYlpnTkFMYysvemE4VU5MVmVQbHd3UjN5YXAvYzBw?=
 =?utf-8?B?ekNPM01OUWlIQm9peHR5UFcxb2EvQmsrbkdSNHZQRVhKR2ZYTUtnYkV5aEhs?=
 =?utf-8?B?eit3Vkk3REpmSUN1LzVwa3lwYjZEbFF3OGwzL0Q2V09Nc2dlbW9JQkhqQVVZ?=
 =?utf-8?B?VTNNSHNmSzBxaUd2QThJQjNlY1F5Q00zQjRjK2V3R1Nnc2gzb0ttaXJYcVlz?=
 =?utf-8?B?RlFpc2Ztc0FKNldMOExvOFlpaWR4Z2FSd1hWNzVnWEd6dTNNRzZTMmdCOXFs?=
 =?utf-8?B?QnkzMTloejZFM25JbUphWmJPaE01Um52WnBwY3g1MkMvRFR6R295aHZwYjhn?=
 =?utf-8?B?djlnRzdvQXl3QW5oM3ZZdE5sTzVEU0p2eU1VNU1nY3pBMW1GOC9yQ3IzQUVT?=
 =?utf-8?B?TmJhNExMUUhkNDZEZ2llWWk2eVBSaVZlajNFWEx6U3g0QTlOZVFFdEk0R1lF?=
 =?utf-8?B?VHMvai9IZXB3Ui92U1M4Rnp2aTNDZitPYUFJbmhzWDY4K1NHYk5tcEJtbXBG?=
 =?utf-8?B?ZmxFYXBnS1Q4T2sxeHAzV0RqSEUvK1FVTGV5YnVEeDFraDc0RzIrYjJxcFZw?=
 =?utf-8?B?QUpRakZEQ1d3elplZEtFcDNkKy9veXQ1eTlWeFh5NWVINjVSYTRWOEh6eTY2?=
 =?utf-8?B?RVVhRCtiUUVQL0VvaUdXc2VFWmoyN3Q3UTl1Y0JOdWVsSG52NnVKVlFDSG4x?=
 =?utf-8?B?bzBxb2pWT3JDSVhSOTgvL0VCYzBBanhQWW9rYU9LalNUVFBXcEVyM1E3eVVK?=
 =?utf-8?B?WHlHbzI5TStLOHZaMTc0WElNcGhxZmwrZlpKUVVrU1dxODcySjdpUkcwSDNC?=
 =?utf-8?B?K0lOWXg3Nm95cytGNHd5VzYrRUtRaDJ3cUlrb3Jpb0hJR0F6TTQ3N1hnUWhY?=
 =?utf-8?B?NDhqYkdPVHU4R2twVVJkVnRJRDRzVjEvSFNZSTZvVjhuTnNib0ZNMFFtVWMy?=
 =?utf-8?B?elo4NG4vczZvZlJjYklMbWpxRnpGNXNscERYNGJWYnAwSzh6dGVoRngxNU4w?=
 =?utf-8?B?VlhtbVRYRkdYc3dtVkpnV0hwUG5mSmw1bzFPN0xzWDBOU29HM0M5R20zNWx0?=
 =?utf-8?B?RmpSVy9WM3EwRmZJR2xDM3p1RS83REIvWVI4Vy9SSWw1LzNKYnlBdHZzeFds?=
 =?utf-8?B?Qm41V2NSNE90OFo4S2pDWDdqa3JWeWFLVjJuSkdQN3o0RlhtUmZzWTZIeDRS?=
 =?utf-8?B?SWN1QkVEOTdHRHRQek9ielZubVBqcDVjYjZUSGcwang5b1ZMeXQySkFHQW1S?=
 =?utf-8?B?OGwrREkwRVlFK1VwcVhzdW9wbHk2UVhVRnlxb3B2djN4NGhWaW5vSndvZ0ph?=
 =?utf-8?B?bDVsMlVvUVRUUlBuelpLWmtva0RrNjh0bm1KWVlFcVdmL0FJVHN3bVZZQi9H?=
 =?utf-8?B?U3o4dnhMMkRKOXVjdCtlSG9WbGs0RU05ZzBSOWFyV2ZpM3V5UWJnVVY2djcz?=
 =?utf-8?Q?yJgwkY5Jl0btZQbWqh1qU4ly+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515a77b3-980d-45b4-2366-08da8ad989df
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:46:55.3078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyJKNmqdYVAOgeq+E8HIzoGSgUGcNeif0l/zOgGxlVNs3+54lTgRWZvUjQGX79CpeDBMHXIVXL/C60Dy06BhuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
Cc: Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-29 10:29, Jonathan Kim wrote:
> Introduce the GPU debug operations interface.
>
> For ROCm-GDB to extend the GNU Debugger's ability to inspect the AMD GPU
> instruction set, provide the necessary interface to allow the debugger
> to HW debug-mode set and query exceptions per HSA queue, process or
> device.
>
> The runtime_enable interface coordinates exception handling with the
> HSA runtime.
>
> Full documention is available in the kern docs at uapi/linux/kfd_ioctl.h.

"Full documentation" is a bold claim. ;) Some more specific comments and 
suggestions inline.


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  48 ++
>   include/uapi/linux/kfd_ioctl.h           | 562 ++++++++++++++++++++++-
>   2 files changed, 609 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index dc774ddf3445..f6f4a348b94b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2614,6 +2614,48 @@ static int kfd_ioctl_criu(struct file *filep, struct kfd_process *p, void *data)
>   	return ret;
>   }
>   
> +static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	return 0;
> +}
> +
> +static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_dbg_trap_args *args = data;
> +	int r = 0;
> +
> +	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> +		pr_err("Debugging does not support sched_policy %i", sched_policy);
> +		return -EINVAL;
> +	}
> +
> +	switch (args->op) {
> +	case KFD_IOC_DBG_TRAP_ENABLE:
> +	case KFD_IOC_DBG_TRAP_DISABLE:
> +	case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
> +	case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
> +	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
> +	case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
> +	case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
> +	case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
> +	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
> +	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
> +	case KFD_IOC_DBG_TRAP_SET_FLAGS:
> +	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
> +	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
> +	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
> +	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
> +		pr_warn("Debugging not supported yet\n");
> +		r = -EPERM;
> +		break;
> +	default:
> +		pr_err("Invalid option: %i\n", args->op);
> +		r = -EINVAL;
> +	}
> +
> +	return r;
> +}
> +
>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>   	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>   			    .cmd_drv = 0, .name = #ioctl}
> @@ -2723,6 +2765,12 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
>   			kfd_ioctl_get_available_memory, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_RUNTIME_ENABLE,
> +			kfd_ioctl_runtime_enable, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
> +			kfd_ioctl_set_debug_trap, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index 42b60198b6c5..5517dd28b974 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -109,6 +109,18 @@ struct kfd_ioctl_get_available_memory_args {
>   	__u32 pad;
>   };
>   
> +struct kfd_dbg_device_info_entry {
> +	__u64 exception_status;
> +	__u64 lds_base;
> +	__u64 lds_limit;
> +	__u64 scratch_base;
> +	__u64 scratch_limit;
> +	__u64 gpuvm_base;
> +	__u64 gpuvm_limit;
> +	__u32 gpu_id;
> +	__u32 pad;
> +};
> +
>   /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
>   #define KFD_IOC_CACHE_POLICY_COHERENT 0
>   #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
> @@ -766,6 +778,548 @@ struct kfd_ioctl_set_xnack_mode_args {
>   	__s32 xnack_enabled;
>   };
>   
> +/* Wave launch override modes */
> +enum kfd_dbg_trap_override_mode {
> +	KFD_DBG_TRAP_OVERRIDE_OR = 0,
> +	KFD_DBG_TRAP_OVERRIDE_REPLACE = 1
> +};
> +
> +/* Wave launch overrides */
> +enum kfd_dbg_trap_mask {
> +	KFD_DBG_TRAP_MASK_FP_INVALID = 1,
> +	KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL = 2,
> +	KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO = 4,
> +	KFD_DBG_TRAP_MASK_FP_OVERFLOW = 8,
> +	KFD_DBG_TRAP_MASK_FP_UNDERFLOW = 16,
> +	KFD_DBG_TRAP_MASK_FP_INEXACT = 32,
> +	KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO = 64,
> +	KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH = 128,
> +	KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION = 256
> +};
> +
> +/* Wave launch modes */
> +enum kfd_dbg_trap_wave_launch_mode {
> +	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_NORMAL = 0,
> +	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_HALT = 1,
> +	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_KILL = 2,
> +	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_DEBUG = 3,
> +	KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL = 4
> +};
> +
> +/* Address watch modes */
> +enum kfd_dbg_trap_address_watch_mode {
> +	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_READ = 0,
> +	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_NONREAD = 1,
> +	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ATOMIC = 2,
> +	KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ALL = 3
> +};
> +
> +/* Additional wave settings */
> +enum kfd_dbg_trap_flags {
> +	KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP = 1,
> +	KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP = 2
> +};
> +
> +/* Trap exceptions */
> +enum kfd_dbg_trap_exception_code {
> +	EC_NONE = 0,
> +	/* per queue */
> +	EC_QUEUE_WAVE_ABORT = 1,
> +	EC_QUEUE_WAVE_TRAP = 2,
> +	EC_QUEUE_WAVE_MATH_ERROR = 3,
> +	EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION = 4,
> +	EC_QUEUE_WAVE_MEMORY_VIOLATION = 5,
> +	EC_QUEUE_WAVE_APERTURE_VIOLATION = 6,
> +	EC_QUEUE_PACKET_DISPATCH_DIM_INVALID = 16,
> +	EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID = 17,
> +	EC_QUEUE_PACKET_DISPATCH_CODE_INVALID = 18,
> +	EC_QUEUE_PACKET_RESERVED = 19,
> +	EC_QUEUE_PACKET_UNSUPPORTED = 20,
> +	EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID = 21,
> +	EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID = 22,
> +	EC_QUEUE_PACKET_VENDOR_UNSUPPORTED = 23,
> +	EC_QUEUE_PREEMPTION_ERROR = 30,
> +	EC_QUEUE_NEW = 31,
> +	/* per device */
> +	EC_DEVICE_QUEUE_DELETE = 32,
> +	EC_DEVICE_MEMORY_VIOLATION = 33,
> +	EC_DEVICE_RAS_ERROR = 34,
> +	EC_DEVICE_FATAL_HALT = 35,
> +	EC_DEVICE_NEW = 36,
> +	/* per process */
> +	EC_PROCESS_RUNTIME = 48,
> +	EC_PROCESS_DEVICE_REMOVE = 49,
> +	EC_MAX
> +};
> +
> +/* Mask generated by ecode in kfd_dbg_trap_exception_code */
> +#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
> +
> +/* Masks for exception code type checks below */
> +#define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
> +				 KFD_EC_MASK(EC_QUEUE_WAVE_TRAP) |	\
> +				 KFD_EC_MASK(EC_QUEUE_WAVE_MATH_ERROR) |	\
> +				 KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION) |	\
> +				 KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION) |	\
> +				 KFD_EC_MASK(EC_QUEUE_WAVE_APERTURE_VIOLATION) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
> +				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED)	|	\
> +				 KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR)	|	\
> +				 KFD_EC_MASK(EC_QUEUE_NEW))
> +#define KFD_EC_MASK_DEVICE	(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) |		\
> +				 KFD_EC_MASK(EC_DEVICE_RAS_ERROR) |		\
> +				 KFD_EC_MASK(EC_DEVICE_FATAL_HALT) |		\
> +				 KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION) |	\
> +				 KFD_EC_MASK(EC_DEVICE_NEW))
> +#define KFD_EC_MASK_PROCESS	(KFD_EC_MASK(EC_PROCESS_RUNTIME) |	\
> +				 KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
> +
> +/* Checks for exception code types for KFD search */
> +#define KFD_DBG_EC_TYPE_IS_QUEUE(ecode)					\
> +			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
> +#define KFD_DBG_EC_TYPE_IS_DEVICE(ecode)				\
> +			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
> +#define KFD_DBG_EC_TYPE_IS_PROCESS(ecode)				\
> +			(!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
> +
> +
> +/* Runtime enable states */
> +enum kfd_dbg_runtime_state {
> +	DEBUG_RUNTIME_STATE_DISABLED = 0,
> +	DEBUG_RUNTIME_STATE_ENABLED = 1,
> +	DEBUG_RUNTIME_STATE_ENABLED_BUSY = 2,
> +	DEBUG_RUNTIME_STATE_ENABLED_ERROR = 3
> +};
> +
> +/* Runtime enable status */
> +struct kfd_runtime_info {
> +	__u64 r_debug;
> +	__u32 runtime_state;
> +	__u32 ttmp_setup;
> +};
> +
> +/* Enable modes for runtime enable */
> +#define KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK	1
> +#define KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK	2
> +
> +/**
> + * kfd_ioctl_runtime_enable_args - Arguments for runtime enable
> + *
> + * Coordinates debug exception signalling and debug device enablement with runtime.
> + *
> + * @r_debug - pointer to user struct for sharing information between ROCr and the debuggger
> + * @mode_mask - mask to set mode
> + *	KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK - enable runtime for debugging, otherwise disable
> + *	KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK - enable trap temporary setup (ignore on disable)
> + *
> + * Return - 0 on SUCCESS.
> + *	  - EBUSY if runtime enable call already pending.
> + *	  - EEXIST if user queues already active prior to call.
> + *	    If process is debug enabled, runtime enable will enable debug devices and
> + *	    wait for debugger process to send runtime exception EC_PROCESS_RUNTIME
> + *	    to unblock - see kfd_ioctl_dbg_trap_args.
> + *
> + */
> +struct kfd_ioctl_runtime_enable_args {
> +	__u64 r_debug;
> +	__u32 mode_mask;
> +};
> +
> +/* Queue information */
> +struct kfd_queue_snapshot_entry {
> +	__u64 exception_status;
> +	__u64 ring_base_address;
> +	__u64 write_pointer_address;
> +	__u64 read_pointer_address;
> +	__u64 ctx_save_restore_address;
> +	__u32 queue_id;
> +	__u32 gpu_id;
> +	__u32 ring_size;
> +	__u32 queue_type;
> +	__u32 ctx_save_restore_area_size;
> +	__u32 reserved[17];

Probably a single u32 of padding is sufficient, since we added a 
mechanism to grow this struct in backwards compatible way in the future.


> +};
> +
> +/* Queue status return for suspend/resume */
> +#define KFD_DBG_QUEUE_ERROR_BIT		30
> +#define KFD_DBG_QUEUE_INVALID_BIT	31
> +#define KFD_DBG_QUEUE_ERROR_MASK	(1 << KFD_DBG_QUEUE_ERROR_BIT)
> +#define KFD_DBG_QUEUE_INVALID_MASK	(1 << KFD_DBG_QUEUE_INVALID_BIT)
> +
> +/* Context save area header information */
> +struct kfd_context_save_area_header {
> +	__u32 control_stack_offset;
> +	__u32 control_stack_size;
> +	__u32 wave_state_offset;
> +	__u32 wave_state_size;
> +	__u32 debug_offset;
> +	__u32 debug_size;
> +	__u64 err_payload_addr;
> +	__u32 err_event_id;
> +	__u32 reserved1;
> +};
> +
> +/* Debug operations */
> +enum kfd_dbg_trap_operations {
> +	KFD_IOC_DBG_TRAP_ENABLE = 0,
> +	KFD_IOC_DBG_TRAP_DISABLE = 1,
> +	KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT = 2,
> +	KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED = 3,
> +	KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE = 4,
> +	KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE = 5,
> +	KFD_IOC_DBG_TRAP_SUSPEND_QUEUES = 6,
> +	KFD_IOC_DBG_TRAP_RESUME_QUEUES = 7,
> +	KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH = 8,
> +	KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH = 9,
> +	KFD_IOC_DBG_TRAP_SET_FLAGS = 10,
> +	KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT = 11,
> +	KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO = 12,
> +	KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT = 13,
> +	KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT = 14
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_enable_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_ENABLE.
> + *
> + *     Enables debug session for target process. Call @op KFD_IOC_DBG_TRAP_DISABLE in
> + *     kfd_ioctl_dbg_trap_args to disable debug session.
> + *
> + *     @exception_mask (IN)	- exceptions to raise to the debugger
> + *     @rinfo_ptr      (IN)	- pointer to runtime info buffer (see kfd_runtime_info)
> + *     @rinfo_size     (IN/OUT)	- size of runtime info buffer in bytes
> + *     @dbg_fd	       (IN)	- fd the KFD will nofify the debugger with of raised
> + *				  exceptions set in exception_mask
> + *     Return - 0 on SUCCESS.

Please document possible error conditions and the corresponding error codes.


> + *		Copies KFD saved kfd_runtime_info to @rinfo_ptr on enable.
> + *		Size of kfd_runtime saved by the KFD returned to @rinfo_size.
> + */
> +struct kfd_ioctl_dbg_trap_enable_args {
> +	__u64 exception_mask;
> +	__u64 rinfo_ptr;
> +	__u32 rinfo_size;
> +	__u32 dbg_fd;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_send_runtime_event_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT.
> + *     Raises exceptions to runtime.
> + *
> + *     @exception_mask (IN) - exceptions to raise to runtime
> + *     @gpu_id	       (IN) - target device id
> + *     @queue_id       (IN) - target queue id
> + *
> + *     Return - 0 on SUCCESS.

Please document possible error conditions and the corresponding error codes.


> + *		If exception_mask contains EC_PROCESS_RUNTIME, unblocks pending
> + *		AMDKFD_IOC_RUNTIME_ENABLE call - see kfd_ioctl_runtime_enable_args.
> + *		All other exceptions are raised to runtime through err_payload_addr.
> + *		See kfd_context_save_area_header.
> + */
> +struct kfd_ioctl_dbg_trap_send_runtime_event_args {
> +	__u64 exception_mask;
> +	__u32 gpu_id;
> +	__u32 queue_id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_exceptions_enabled_args
> + *
> + *     Arguments for KFD_IOC_SET_EXCEPTIONS_ENABLED
> + *     Set new exceptions to be raised to the debugger.
> + *
> + *     @exception_mask (IN) - new exceptions to raise the debugger
> + */
> +struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args {
> +	__u64 exception_mask;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_wave_launch_override_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE
> + *     Enable HW exceptions to raise trap.
> + *
> + *     @override_mode	     (IN)     - see kfd_dbg_trap_override_mode
> + *     @enable_mask	     (IN/OUT) - see kfd_dbg_trap_mask
> + *     @support_request_mask (IN/OUT) - see kfd_dbg_trap_mask

The meaning of the enable_mask and support_request_mask needs more 
explanation.


> + *
> + *     Return - 0 on SUCCESS.
> + *	      - EPERM if mode is not supported.
> + *	      - EPERM if mode is not supported.
> + *	      - EACCES if trap support requested is not actually supported.
> + *		Previous enablement is returned in @enable_mask.
> + *		Actual support is returned in @support_request_mask.
> + */
> +struct kfd_ioctl_dbg_trap_set_wave_launch_override_args {
> +	__u32 override_mode;
> +	__u32 enable_mask;
> +	__u32 support_request_mask;
> +	__u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_wave_launch_mode_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE
> + *     Set wave launch mode.
> + *
> + *     @mode (IN) - see kfd_dbg_trap_wave_launch_mode
> + *
> + *     Return - 0 on SUCCESS.

Please document possible error conditions and the corresponding error codes.


> + */
> +struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args {
> +	__u32 launch_mode;
> +	__u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_suspend_queues_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SUSPEND_QUEUES
> + *     Suspend queues.
> + *
> + *     @exception_mask	(IN) - raised exceptions to clear
> + *     @queue_array_ptr (IN) - pointer to array of queue ids (DWORD per queue id)

Better to call this "u32 per queue id". DWORD is ambiguous.


> + *			       to suspend
> + *     @num_queues	(IN) - number of queues to suspend in @queue_array_ptr
> + *     @grace_period	(IN) - wave time allowance before preemption

What's the unit for the grace period?


> + *
> + *     Return - Number of queues suspended on SUCCESS.
> + *		KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK masked
> + *		for each queue id in @queue_array_ptr array reports unsuccessful
> + *		suspend reason.
> + *		KFD_DBG_QUEUE_ERROR_MASK = HW failure.
> + *		KFD_DBG_QUEUE_INVALID_MASK = queue does not exist, is new or
> + *		is being destroyed.
> + *		Suspended queues can never be destroyed.

I think this should say "Destroying of suspended queues blocks until the 
queue is resumed. This allows the debugger to access queue information 
and context save areas of suspended queues without fears of racing with 
a queue destruction."


> + *		Automatically copies per queue context save area header information
> + *		into the save area base
> + *		(see kfd_queue_snapshot_entry and kfd_context_save_area_header).
> + */
> +struct kfd_ioctl_dbg_trap_suspend_queues_args {
> +	__u64 exception_mask;
> +	__u64 queue_array_ptr;
> +	__u32 num_queues;
> +	__u32 grace_period;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_resume_queues_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_RESUME_QUEUES
> + *     Resume queues.
> + *
> + *     @queue_array_ptr (IN) - pointer to array of queue ids (DWORD per queue id)

DWORD -> u32


> + *			       to resume
> + *     @num_queues	(IN) - number of queues to resume in @queue_array_ptr
> + *
> + *     Return - Number of queues resumed on SUCCESS.
> + *		KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK mask
> + *		for each queue id in @queue_array_ptr array reports unsuccessful
> + *		resume reason.
> + *		KFD_DBG_QUEUE_ERROR_MASK = HW failure.
> + *		KFD_DBG_QUEUE_INVALID_MASK = queue does not exist.
> + */
> +struct kfd_ioctl_dbg_trap_resume_queues_args {
> +	__u64 queue_array_ptr;
> +	__u32 num_queues;
> +	__u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_node_address_watch_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH
> + *     Sets address watch for device.
> + *
> + *     @address	(IN)  - watch address to set
> + *     @mode    (IN)  - see kfd_dbg_trap_address_watch_mode
> + *     @mask    (IN)  - watch address mask
> + *     @dev_id  (IN)  - target device to set watch point
> + *     @id      (OUT) - watch id allocated
> + *
> + *     Return - 0 on SUCCESS.

Please document possible error conditions and the corresponding error codes.


> + *		Allocated watch ID returned to @id.
> + */
> +struct kfd_ioctl_dbg_trap_set_node_address_watch_args {
> +	__u64 address;
> +	__u32 mode;
> +	__u32 mask;
> +	__u32 dev_id;
> +	__u32 id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_clear_node_address_watch_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH
> + *     Clear address watch for device.
> + *
> + *     @dev_id  (IN)  - target device to clear watch point
> + *     @id      (IN) - allocated watch id to clear
> + *
> + *     Return - 0 on SUCCESS.
> + */
> +struct kfd_ioctl_dbg_trap_clear_node_address_watch_args {
> +	__u32 dev_id;
> +	__u32 id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_flags_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_SET_FLAGS
> + *     Sets flags for wave behaviour.
> + *
> + *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
(see kfd_dbg_trap_flags).


> + *
> + *     Return - 0 on SUCCESS.
> + *	      - EPERM if any debug device does not allow flag options.
> + */
> +struct kfd_ioctl_dbg_trap_set_flags_args {
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_query_debug_event_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT
> + *     Find a raised exception.

Find one ore more raised exceptions. This function can return multiple 
exceptions from a single queue or a single device with one call. To find 
all raised exceptions, this function must be called repeatedly until it 
returns -EAGAIN. Returned exceptions can optionally be cleared by 
setting the corresponding bit in the @exception_mask input parameter. 
However, clearing an exception prevents retrieving further information 
about it with KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO.


> + *
> + *     @exception_mask (IN/OUT) - exception to clear (IN) and raised (OUT)
> + *     @gpu_id	       (OUT)    - gpu id of exceptions raised
> + *     @queue_id       (OUT)    - queue id of exceptions raised
> + *
> + *     Return - 0 on raised exception found
> + *            - EAGAIN if no raised exception has been found
> + *              Raised exceptions found are returned in @exception mask
> + *              with reported source id returned in @gpu_id or @queue_id.
> + */
> +struct kfd_ioctl_dbg_trap_query_debug_event_args {
> +	__u64 exception_mask;
> +	__u32 gpu_id;
> +	__u32 queue_id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_query_exception_info_args
> + *
> + *     Arguments KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO
> + *     Get additional info on raised exception.
> + *
> + *     @info_ptr	(IN)	 - pointer to exception info buffer to copy to
> + *     @info_size	(IN/OUT) - exception info buffer size (bytes)
> + *     @source_id	(IN)     - target gpu or queue id
> + *     @exception_code	(IN)     - target exception
> + *     @clear_exception	(IN)     - clear raised @exception_code exception
> + *				   (0 = false, 1 = true)
> + *
> + *     Return - 0 on SUCCESS.
> + *              If @exception_code is EC_DEVICE_MEMORY_VIOLATION, copy @info_size(OUT)
> + *		bytes of memory exception data to @info_ptr.
> + *              If @exception_code is EC_PROCESS_RUNTIME, copy saved
> + *              kfd_runtime_info to @info_ptr.
> + *              Actual required @info_ptr size (bytes) is returned in @info_size.
> + */
> +struct kfd_ioctl_dbg_trap_query_exception_info_args {
> +	__u64 info_ptr;
> +	__u32 info_size;
> +	__u32 source_id;
> +	__u32 exception_code;
> +	__u32 clear_exception;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_get_queue_snapshot_args
> + *
> + *     Arguments KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT
> + *     Get queue information.
> + *
> + *     @exception_mask	 (IN)	  - exceptions raised to clear
> + *     @snapshot_buf_ptr (IN)	  - queue snapshot entry buffer
> + *				    (see kfd_queue_snapshot_entry)
> + *     @buf_size	 (IN/OUT) - number of queue snapshot entries

Call this num_queues to avoid ambiguity.

> + *     @entry_size	 (IN/OUT) - size per entry in bytes

The debugger specifies the size of the array allocated in @num_queues. 
KFD returns the number of queues that actually existed. If this is 
larger than the size specified by the debugger, KFD will not overflow 
the array allocated by the debugger.

The debugger specifies sizeof(struct kfd_queue_snapshot_entry) in 
@entry_size. KFD returns the number of bytes actually populated per 
entry. The debugger should use the KFD_IOCTL_MINOR_VERSION to determine, 
which fields in struct kfd_queue_snapshot_entry are valid. This allows 
growing the ABI in a backwards compatible manner.


> + *
> + *     Return - 0 on SUCCESS.
> + *              Copies @size(IN) queue snapshot entries into @snapshot_buf_ptr if
> + *              @buf_size(IN) > 0.
> + *              Otherwise return @buf_size(OUT) queue snapshot entries that exist.
> + */
> +struct kfd_ioctl_dbg_trap_queue_snapshot_args {
> +	__u64 exception_mask;
> +	__u64 snapshot_buf_ptr;
> +	__u32 buf_size;
> +	__u32 entry_size;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_get_device_snapshot_args
> + *
> + *     Arguments for KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT
> + *     Get device information.
> + *
> + *     @exception_mask	 (IN)	  - exceptions raised to clear
> + *     @snapshot_buf_ptr (IN)	  - pointer to snapshot buffer (see kfd_device_snapshot_entry)

The definition of struct kfd_device_snapshot_entry is missing in this patch.


> + *     @buf_size	 (IN/OUT) - number of debug devices to snapshot

Call this num_devices to avoid ambiguity.


> + *     @entry_size	 (IN/OUT) - size per entry in bytes
The debugger specifies the size of the array allocated in @num_devices. 
KFD returns the number of devices that actually existed.

The debugger specifies sizeof(struct kfd_device_snapshot_entry) in 
@entry_size. KFD returns the number of bytes actually populated. The 
debugger should use KFD_IOCTL_MINOR_VERSION to determine, which fields 
in struct kfd_device_snapshot_entry are valid. This allows growing the 
ABI in a backwards compatible manner.


> + *
> + *     Return - 0 on SUCCESS.
> + *            - ENOSPC if requested number of debug devices is less than the
> + *		actual number of debug devices.

This is different from now the queue snapshot works. Is there a reason 
for this difference? Maybe it's because the number of devices is 
expected to be static and should be known by the debugger ahead of time, 
while the number of queues can change dynamically. However, given that 
the queue and device snapshot interfaces are otherwise identical, this 
subtle semantic difference is a bit disturbing.

Regards,
   Felix


> + *	        Copies @buf_size(OUT) number of device snapshot entries into
> + *		@snapshot_buf_ptr.
> + *	        Actual number of device snapshot entries returned in @buf_size.
> + */
> +struct kfd_ioctl_dbg_trap_device_snapshot_args {
> +	__u64 exception_mask;
> +	__u64 snapshot_buf_ptr;
> +	__u32 buf_size;
> +	__u32 entry_size;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_args
> + *
> + * Arguments to debug target process.
> + *
> + *     @pid - target process to debug
> + *     @op  - debug operation (see kfd_dbg_trap_operations)
> + *
> + *     @op determines which union struct args to use.
> + *     Refer to kern docs for each kfd_ioctl_dbg_trap_*_args struct.
> + */
> +struct kfd_ioctl_dbg_trap_args {
> +	__u32 pid;
> +	__u32 op;
> +
> +	union {
> +		struct kfd_ioctl_dbg_trap_enable_args enable;
> +		struct kfd_ioctl_dbg_trap_send_runtime_event_args send_runtime_event;
> +		struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args set_exceptions_enabled;
> +		struct kfd_ioctl_dbg_trap_set_wave_launch_override_args launch_override;
> +		struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args launch_mode;
> +		struct kfd_ioctl_dbg_trap_suspend_queues_args suspend_queues;
> +		struct kfd_ioctl_dbg_trap_resume_queues_args resume_queues;
> +		struct kfd_ioctl_dbg_trap_set_node_address_watch_args set_node_address_watch;
> +		struct kfd_ioctl_dbg_trap_clear_node_address_watch_args clear_node_address_watch;
> +		struct kfd_ioctl_dbg_trap_set_flags_args set_flags;
> +		struct kfd_ioctl_dbg_trap_query_debug_event_args query_debug_event;
> +		struct kfd_ioctl_dbg_trap_query_exception_info_args query_exception_info;
> +		struct kfd_ioctl_dbg_trap_queue_snapshot_args queue_snapshot;
> +		struct kfd_ioctl_dbg_trap_device_snapshot_args device_snapshot;
> +	};
> +};
> +
>   #define AMDKFD_IOCTL_BASE 'K'
>   #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
>   #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -877,7 +1431,13 @@ struct kfd_ioctl_set_xnack_mode_args {
>   #define AMDKFD_IOC_AVAILABLE_MEMORY		\
>   		AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
>   
> +#define AMDKFD_IOC_RUNTIME_ENABLE		\
> +		AMDKFD_IOWR(0x24, struct kfd_ioctl_runtime_enable_args)
> +
> +#define AMDKFD_IOC_DBG_TRAP			\
> +		AMDKFD_IOWR(0x25, struct kfd_ioctl_dbg_trap_args)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x24
> +#define AMDKFD_COMMAND_END		0x26
>   
>   #endif
