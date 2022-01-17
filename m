Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4A0C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 07:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1308F10F1AA;
	Mon, 17 Jan 2022 07:58:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E2F10F1AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 07:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4TQgDKxNBIkJSo8HuWDezfNCLlZ/D9nMPHSVPI25glVhlZJGcj9TyzrukFgoh2jTbuT5bmfiP2ZHIWC08JGhJTPk2nhWDAzxyvJPUOJ6YCR4IzdQ8MDHJm0ggJvmPE5m88UUkpPdiIYbp+eUGh3krZxHCq0QbQeawbRq3O36RNpPS7de1rwgXAG1QpRK3y9GWreYp8PwR5PKc5ij6FSf0XLhEGXGkN5SiCwffoaSh7Spc2EzNxbuCVDpQ72iU86UJHjE7FNCCgV3Ztd+jBQ5/RwYAjrIyOrMCX1l5GNdbx4sescJVwYTBKYr0LvnVQ64Ck7obfSTkpE+cjCtLnDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U66EgQzDwm2P7Nf8DBee1/nTezkxImvfwRaPkdyu/Ao=;
 b=OQifXaBvg2U+vWwVR4YBiJ6KSU0ljH52/4Wxx64KybTZGPE8DurZRCkQ24A1SZ+LO27RMvMyL4lA2vauC3iQAjIJfFm4TO++a1aNmscFINVtIzq9QAH2H6oLuT3A0Rm1tgDaEIKHutVdR64Gbtboz2jBPhcg8eGA3oeMMb32UsbCiO4hT5DagjpA/+iJpCjC6CjSHlMd2GNsGQqwj+4lcZfdC+f4kinkthcgKB0s/FUaKoQsJSe3ePA5beuEn5t4WA4H92aWw98+47kc2t6gNcwhzTAsQ9HTALcHZcKcUpjiBkjTCy2ONjgMlY3kBJ9v/Jj87hdA4GzKJPbbRB5F8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U66EgQzDwm2P7Nf8DBee1/nTezkxImvfwRaPkdyu/Ao=;
 b=dXJEQMBCvjR/MDbKZloxKdO00zo+O6xX9OdShSMUia3xHKhPdGhlYQLjuaUmjJ/6naeXN89DkHHTlIkSaXieob9f+o09Bkpqki8l74/Ajtar4hERS6QttnZ8WY1O2deqFztOXQ22i0yYs6rzjEsCzETdKbOYv2agbVRYtw1/s18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by BYAPR12MB3144.namprd12.prod.outlook.com
 (2603:10b6:a03:d6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 07:58:49 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 07:58:49 +0000
Subject: Re: [PATCH] drm/amdgpu: limit the number of dst address in trace
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220117075546.40427-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ac860246-573c-c151-6170-b28aa1976062@amd.com>
Date: Mon, 17 Jan 2022 08:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220117075546.40427-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::24) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04c03e40-4a00-4416-5f6a-08d9d98f31cb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144D7C254493E8DE86C7F1F83579@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAKTbTecPm/wdUSmR1VOnPablw0pKeP8HmFNHIi7dws8hjBxW0t31yOOJmIKQoWyIcvYl/lizw6hf79KXtCMDe8D+PlSXLfZecGrxQLshSvWACrxtLIqv4ksxP/un+OXScRNFKI2h8XD4GsNiGsZN+VPa5oJLDRdik/dNeGPqN+y1EcYuVi6Ur+e1Jn3K97da5kVF4pEUfHVstFk4At3BkR5rQ7liv76BEgKwlTrvEFhT7DY+LLyDd8IH98NdbENH2N/W1b0GVxGVI381dgRKxaqugL0YoGRAFeugFW1V890XxkqvV2QgLTuHPasgCUwW3I2ayhvPTyHfhPuq97joQGanYnve6kZjFWfPwQgY6fFvUglcSV8ltnKDebEa2AW8G72/L8Ps2JPM7zkNy/LTu9z79leST8jFyU2lGF+tluOk3ZJ24YPlJTxLDMMuACHH2RKrefcF4x5pYkUV9E0LqvcglFuyXsnmPlE/B4QYUls6iQkWyVdraQ8NKrxHtWWWNKznmLwH3th9heVuQLwBLwaTHrHLbpnCFaFoXgB2RKXfq+OMRnLB/SFw0knbb1rEr06BH9IeJSpdcnL9MM3+YgqBZFCAT8yBwxF6K9X7re9ZsfO/jRqPlT7X2kXONxujoZ3EGgQFtmxSNJN+Wg/lB4EIIYYleYH8tpFxfHO5p9HNUhxDfHPsLhZ95zQszaLm8ErqfylRKjAKioO7i6eChusCtVJk29z3ZgcGifB8zeL0bu8oRdzzAzjz5WsKdtCyTDWBAbfqbtxQ47GFjCCQyu/dzPaVzU1pwFfu5AMbs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(66556008)(316002)(2616005)(31686004)(6506007)(83380400001)(5660300002)(2906002)(8936002)(508600001)(36756003)(66574015)(66946007)(6512007)(6666004)(66476007)(186003)(4326008)(8676002)(6486002)(38100700002)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNCak9RQ0tzTUY3UCtMbVBUV0I0Rlk4eTA3dEtvSy93d3BNZ2ZVU3dZZkJT?=
 =?utf-8?B?TG93dnllU3pjaWY0S2FHbC9ZVmZ5MktUM2xkcDk2VTIzWE5YOFdXUjVjRGxJ?=
 =?utf-8?B?dTAzUXZmaXIyS2tsMDFBdHVpOVRpRWRVRlhKTEp3cjRxNnphdVBoVGpIdi8r?=
 =?utf-8?B?R3ZOU254QkZwQytCZ0RnWDBrZEtoSWVDRy9lcVIyM3NLUlpGVkNrM0Y2eDlF?=
 =?utf-8?B?cUJENy9hSnNJRVRvU1BtNExFdVlGeFpOSUhGUS8zTjIwZXJzSnA0eVVPenRv?=
 =?utf-8?B?ZTFCK0liZnAvRjhOZnplb3BwQmtFYWM2bzhGNENlN3Z0dEdlZnE0cE5ndzJl?=
 =?utf-8?B?ZDduaTBBTE1yUER3Ym4yMm1TcHYwWWlwenhpNk83ZlVhRmIxc0cxMmVadDdW?=
 =?utf-8?B?SGtyK3hxUlJSU05ESUZEbEtiTGp3bVZNRGhOQ045NHdIRjRIZG1rRDVPQmc1?=
 =?utf-8?B?R3M4Q3JmY1JnR3FnUHBHQVQvbnh2NnFOOXRLbmlyb2ZhUGtzZm9rMkN4OHkv?=
 =?utf-8?B?Y3pKR2N1eUlmNGZFdTJkcFhoWkF4QWNWWm5lN3VYVUdTU3MyNlprQkswakVK?=
 =?utf-8?B?blpJZm1wVHFVZkJxS0ZVenFveXpFOERXUHY4cUJ1YWhYMG1ndmRBdGhFei9S?=
 =?utf-8?B?TVlrYjV4WmxDUHBkdDdTNE1GTkJ2MTlhZ3NNQTYyaWtmUW5QejM2WGtsM2pJ?=
 =?utf-8?B?YXdrVVN0d0F1WjRodFpkdmhacVJ6OHhCRVZiKzRjTzN1RVp6dXhYREVUbTlv?=
 =?utf-8?B?eWhMdnk2S3BUWTd1TnNDUk1xMkcwaXRpbE9pNVB0UUo1ak42VVI1WXdpNXd5?=
 =?utf-8?B?NkRQTUdsYTM0MlpPWTM3SXFMTU1FR3E5ZlJveGlHdDVkSEM1b0Z2R3J4NHdZ?=
 =?utf-8?B?VS9pbTVMQ1hqekh4K293cjBQY0N4dUc1WmdLcjNtNndLbGd1UU8xdXhGNUZW?=
 =?utf-8?B?dzZ1Skl5bXk0clFJQTI5SjVwWGVwOURLUTE3MlppYVdTaEpKUStZUEloTE9x?=
 =?utf-8?B?eWVtSTdUY0QvKytiY1ZXbk5HVitnMmxGRWNsV0VkdllPRnk5WEpqR3M5L2E2?=
 =?utf-8?B?aGk3ZU4xMEFZODhXeWltSjNESEh1bEtFTU9JT3I1K0c3T2FWSGM3cHIxN1B5?=
 =?utf-8?B?N1krbk5YUHJrY0JtTlNoaFRRSWdpMmI3aDF2dXEvRGZzK2NsZi9LbHEwTldE?=
 =?utf-8?B?ZnI3OTFOOGlsdHpYSHpXU0k1UnBLRTVpL0xobGtpZjVCOFlhVjRqT0hvMWR4?=
 =?utf-8?B?WVM0c3FXUEhoTmF5ZnRzVDR0UFFNZm9HMlJhUFVZMytER0JVR0NtRHg4NDhM?=
 =?utf-8?B?Wm94TEs5bkR6d0tTckk1NU54dENPdjRtNGVKd3N3aHpJTkZPZUxjSVpQTUgz?=
 =?utf-8?B?U0o2eDlUY3RVK0l1SDByNnBzY2svWnlzT1ZKbU1zRUUzeUZLY05DUVRKZ0No?=
 =?utf-8?B?ZFZadloxMXlaUUMzeFRuRDJQa2F5SEtNT1k2Q0JtNGZaN2FWOS9lV2xuZHlZ?=
 =?utf-8?B?dzNWSEtVNVA2NE96L0hOTmFSbmx0TnhPdk1RT1F2T2lhUTJqaEQyVXBTM2Vl?=
 =?utf-8?B?ajhUY3ZWamNhQlp2Wll3SkttQlZTS1ZnZ09yc1JURnBKL1V3S2VSZTNCWjJx?=
 =?utf-8?B?cmlsWEdZVWxZZVQvalZQWi9scDIydkI3SzZWeG5ZYUx0U2NjUUxrZTJKUitI?=
 =?utf-8?B?MHdMMVQ5UEFlRnpQdkZCdkY4Qm02U3UzRG1rZzF6UHFkZmlCM3VVbmhqbXI4?=
 =?utf-8?B?TlJRMFROMm0rRXdSbERMYTdON0FWWmU2Z0h1djJxeXNRM1UxdGVYYzJ4Umx0?=
 =?utf-8?B?K3NQWittUEJOS1pQYldxejc4bzBnRkU0S3dtRFlwaXNyZlcyeTdIeXV1V3hX?=
 =?utf-8?B?b003ZTBhRm5oTFZSZVlmSDZQRHZqSDd1NDcwRFZBU29tSHFJM015UDdKZFZZ?=
 =?utf-8?B?NHhyY0JMNWF2eCtNYk9IVEl6NFlUOWcwNjlXNG1vbzBheDFkM2lnUDllT2tr?=
 =?utf-8?B?N2hSbURwSWpKdmZmcFVzYkhDSmZ2c2RuQWcxN2h5SXNHNXRtWTJTUWZhMWVP?=
 =?utf-8?B?OGF2eFl5dkFRYyswcVFZcysvQVBjTGZyZnV1RUJoa1A2SEZZMUFWTjZxWXo4?=
 =?utf-8?Q?9OpE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c03e40-4a00-4416-5f6a-08d9d98f31cb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 07:58:49.0473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqUwPhn5EuD9+17upVeAY1tPjxxdWslqfgPMdQN74mpOWEuPZNSda98tPHH+zGdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.01.22 um 08:55 schrieb Somalapuram Amaranath:
> trace_amdgpu_vm_update_ptes trace unable to log when nptes too large
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 5 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..a48b34d4ce31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -358,11 +358,10 @@ TRACE_EVENT(amdgpu_vm_update_ptes,
>   			}
>   	),
>   	TP_printk("pid:%u vm_ctx:0x%llx start:0x%010llx end:0x%010llx,"
> -		  " flags:0x%llx, incr:%llu, dst:\n%s%s", __entry->pid,
> +		  " flags:0x%llx, incr:%llu, dst:\n%s", __entry->pid,
>   		  __entry->vm_ctx, __entry->start, __entry->end,
>   		  __entry->flags, __entry->incr,  __print_array(
> -		  __get_dynamic_array(dst), min(__entry->nptes, 32u), 8),
> -		  __entry->nptes > 32 ? "..." : "")
> +		  __get_dynamic_array(dst), __entry->nptes, 8))
>   );
>   
>   TRACE_EVENT(amdgpu_vm_set_ptes,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 0e7dc23f78e7..f367fcc5c535 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1634,7 +1634,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
>   			nptes = max(nptes, 1u);
>   
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
> -						    nptes, dst, incr, upd_flags,
> +						    min(nptes, 32u), dst, incr, upd_flags,
>   						    vm->task_info.pid,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),

