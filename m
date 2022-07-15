Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9D2C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1CA10F679;
	Sat, 16 Jul 2022 14:35:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23B810E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 15:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4RggRCVbMMeQvgBlQ31gz5NriOCdXzcQhtlfnQrhPvR53cmpN7zWJlrLGq7jEyDElkiNGjAwXFVtXNTl7awtuQS86s6qtBIQ9Q4hjEo/t9F8nfIqb9uM7qek8EGGyhfMDV1DBIliiPd/+21AdOF/DlGDQr0IB0B9Jq7NkHoEmN/wLCsaw7VBLB3KyDYtEfNKZkRf/tau2mViKqfJcut7agz78XNM+OhX3zie+oZUf6RncSyZ/lLya4W81yMdJKO8YiqNZOs/8nGGzqeNtUSuBlBC9vo4SBPsvjcu4TzRYXrdbZ3SfLvlA3McbpV6qRJb7EvI/GPx0EZ1fjzrkQs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Es71fy0iyrw2laXb86bDY+EVefRfYfkchLywaDP86gI=;
 b=EYJ73IfJgNQcBvOgxwTjmI/XwzMuz/MRWSYNoSECi7tKPxW1G8Tkf/+GJXXrT1lZlFWl7b3jjstYmp7OMqT+jsTDCwVMc6x8HTPOIYvBdKOSlpC0ZxQGFJshArNFR3Y+xfg+DizxXQvguABekCp8j3n0YC1/O/qT4m7ODXGs7c8MKTNy1gqRCTqenADHB6u0KbeEmJ4PR1SoxhUCwLjLXtvDqBsF8R1YYqLIIPT7sU2A/Sq+nLjVWgUV19nl2vAmPzzxZxYX3gG+zf55NVBYKY8lxPzZFmAILEzk298hysMs+NJpmiOmBktzfjeYpoqSVvieHwJdH2NUjnDpFbApOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Es71fy0iyrw2laXb86bDY+EVefRfYfkchLywaDP86gI=;
 b=QIMR3C/rbOqZKVuCLyKj/7MrQ6srx93/WLx/05RMsvZZXfwc4mq4Zh+2h76JigRQCgO3sIHeUKXbgY+GpKBiDzSgVzL6RTlSCMGGOxJoUBMQ8MRatw5jrmHPMSfz/cA9J35Djg8zWOsvJgxtT4zwczBPJrLtCfrFle1t9FlFLnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 15:42:44 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9da9:705a:18ae:5e91%9]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 15:42:44 +0000
Message-ID: <c2619d27-a480-2f13-cbdd-1f409c5e4738@amd.com>
Date: Fri, 15 Jul 2022 11:42:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
 <20220715084356.427458-3-Jiadong.Zhu@amd.com>
 <7ca91143-9da1-4fc4-0cde-268705764e42@gmail.com>
 <DS7PR12MB633367D703FBDC999E8B7E79F48B9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <SJ1PR12MB633848FACEAA771E018BAA0EF48B9@SJ1PR12MB6338.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <SJ1PR12MB633848FACEAA771E018BAA0EF48B9@SJ1PR12MB6338.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::30) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b444db-aca9-45c5-a186-08da6678a904
X-MS-TrafficTypeDiagnostic: DS0PR12MB6535:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7eeMwB1z3qu+tfVSm8oND8bDycfg/ZfEFn6q3MO7aZus7eUiBw7YeOK3SiFJN6LeRwSsNLT8VM7M/jsgLaKncBFOHP5WcMBZq7agool0eoEffKV4jD872bAXKfCJLMhMhTowdVUshktR0Uv2z9DQq7RTI1upKtrRxN4mZnGe9ULUyXWLEP8EYeCn1osJKchNbhH+40maahOfj46MMXom3q6bn35kiOWs8VIfYnxFEFOubMriqnbtLyLy9Yy9TdgW7PsVQwP6fodaULxnm49LAeswbXL+0AOvFKZmBR+3sygy+eSxeAkX3YDjq1QBCNRMirBBep8/3ppufsuqpAFI3KBonhukMJ+L1Ms7fLurBlLyvlmJasxnD99JwjV+US4QVptoHEzuGTICmvLbvPFQh/czf72YNC36IXF+cdqmN73UsydtlTLuosnbDYaoCprT0zKzlGhMcPCVmnQSuIc4jHAXOJ2fXFyynBu5Bt1ZFoA5unPBe2uWP+GCwJuLHYft/Yg1d3ydSSiBbOYvL3jhEowi4vqANDlKrfXTinaUpt8U0ZpTJpEbi7yaH42aMCC1fry6SA+LVKj8JSTO9tlm3xuS04SLH5NhxIAWcP896DiqM2NtE/EGiW/IU6d7iCom00IJz/Mu5s41LzP78Psx8jbCKNJKUQXcOIHKh8VpDjLgXMmPsk6eBEJ4BimJYyU2G+AKGPtcqFG8hylr4lGQ7q/a0vYkDy3vgOPowQKqkb3xITENqxDl9ziPp+xlB5j1ZQPzv9iBB1JJaUrc+DY2bvosonV7ezDy4/nM7OeM31ByKtL57Xx3fj6OgfmDhmwum2CGr9GC+l+dzJ/VL/W8Z0EWIoYHLt1PokmSfJkaR2/DrsDw/fQDENvqyABkmSi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(83380400001)(66476007)(8936002)(66946007)(966005)(54906003)(4326008)(8676002)(31686004)(110136005)(316002)(66574015)(36756003)(66556008)(86362001)(53546011)(186003)(44832011)(6512007)(6486002)(41300700001)(6506007)(45080400002)(2906002)(5660300002)(2616005)(31696002)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZFSTEvQTUwRDZDMzJpWUc2Q3lOM0FxNlppbTJWM1p6MlVraGNIbTFMdXZt?=
 =?utf-8?B?UUxNekRUOC95U2NIUy9tWTJNYnBGcEJGVHlHWW9uam9TMzJvU3JxaHYwTnBy?=
 =?utf-8?B?cnhKd2hJK2FSc1NlV0kxVlh2dWhHWVczdXVBeGN2WHhQMFBJcFgrbTlPL01U?=
 =?utf-8?B?QVRqZlpOUlcwNHZqTjAxMlFtT0o3RFBXZjFnVjVic0ROQ2dZQnUyYjRNa1Bs?=
 =?utf-8?B?eDZjMnVwVXlZU29hMjVpY2VlQXBXQ1g5dGo0VFNqZjdGY2YwT2FDTlZDYzkr?=
 =?utf-8?B?emxtM21NMVhIeERCQmFXUkxaVXpZeEZURm1LWmxPQ2FjWUlGbFRTL2dFL2pR?=
 =?utf-8?B?MzA2RjlhU3pUcG53L3c4dEZSRzJST0JqbUJSZ2ZPMjdXSjVOejF1eUJ6Vkpz?=
 =?utf-8?B?QTllM1ZNQ2xFb1ZvSVJydE5VSFNDS1dSZG52V3M5T0tIWW5VcElNYktBVEFS?=
 =?utf-8?B?bFNlNnJzUFFoZkJINFM0aWx3TnpQeHloTzJ4WXdNclpDWUFEZ1liV21OZE13?=
 =?utf-8?B?ZEhLSzVxSEJVaGVDTTJIK1FOOWV4NjQ4aUVJTjNRbGI5cWFLRDUwYStBRWxJ?=
 =?utf-8?B?MUtNUk1RVlBWZjBxMlltaXdkb0V2RFBOQjAvUHB3U1M2bE5WMTRCS3B5bjlC?=
 =?utf-8?B?blJKT204TnFFL1lwK1pCaHN2Qm1WaGNNUVp0dk5GZ3ZGbzRZM211L2dXN2VH?=
 =?utf-8?B?NjQ0UWpuVk1nVXYzRXAvMm02RC9MZlk2ZERsZldIbENZVWw0U285bFFoZVZH?=
 =?utf-8?B?bTMvSDA2Wm11eTBlT25YN2tmWGZtV2ZMS2RNdk1HS05QY1Z3ZnlUTUlweEJm?=
 =?utf-8?B?N0lubG50bFFhVi8zNXVlYUVFY0ZISElnRWRvZXpsUE5XZW4zbFBVa3I2R2dL?=
 =?utf-8?B?a2VxZXdKRUVVK04wa3Izajk2K2ovL0t1b1E4NUhzUlhnQmJzeDJMT2lqNzNl?=
 =?utf-8?B?c082cXMrQTMvejNXVUlGc3MyVCtsSVpXOTlwWUxHelhQN25tVkMraHVNVFVR?=
 =?utf-8?B?OHVPZmZ2SnoyTkRKYjdaZGF0YXVmcnlTSmxLMnF4cE1vOXhNenlGeHpGVEV2?=
 =?utf-8?B?aXVrUXhVR0NnUFdUclhBRXUwRmUrazhWN1Q3Q1cxQzZRTHhBMGZZUWZNRFpF?=
 =?utf-8?B?bndlT0RBUURwaWJkZWQzaVNESmlsei9ZM3c1NGZhUm9Rc2RlNVI2aDFQc2JC?=
 =?utf-8?B?c0RobjdpdjlxZWVNYUVEdjJQeHJ3TC9HVisrT1lQN1FQR2VrWGR6SDFqR0RI?=
 =?utf-8?B?b2FZVjJkaVFDQkR4RXN0ZGZrdllEeHBUbi9aVVdEczVLWllYallYaDV1Qkgv?=
 =?utf-8?B?THdUUEpLcWYrNzlCd29WVStHc1ZTT2I5TmdhZE13cVlDZlZKRE1BQ24xRm9a?=
 =?utf-8?B?V0JYUDhLS2daU1dGN3ZXVTBLRGxvRm1JNkRxeFNsQnJtQ0g3YnVCQjEvMys2?=
 =?utf-8?B?OGhJQ3NRWm4xQmhvRzdwLzNIcXBWYWEwZHp5clJyYU54Y0ExNS9iU3BOT3Zr?=
 =?utf-8?B?NTB2Y0NxWnpNWlE5ZVZmTHN1UVdSWDFUb3FHeVdpVWJQWXJLSWwxZ1hqNzJ4?=
 =?utf-8?B?K2NyQkQ4enpGeEIwdmsvNWwzbGtnRzFkNDBPa2ErdTYxQ3ZJRmdQRWdYNm1a?=
 =?utf-8?B?dTZhMW94SjV4VlYzQXkvUnpEbE9PTEdiL1k5VDFOZ1JoeVN2V1UzalVsNUI5?=
 =?utf-8?B?SEpNdENyWEFJSWxpSm14ZnBLLzNFR285ano4SzFzYk5zZzlocCtHOFBYQ2p4?=
 =?utf-8?B?dUVmM3gwL0FidERnWnV2azVCTFpOL1g5RW5lUjVKL2FsY2d0Sk44bVpHc0VV?=
 =?utf-8?B?RG96allzS2Z3KzJ1dmVJWUJLSFp2WFo1MkFPOURKcUhxVEVORkZ0S09IT1Az?=
 =?utf-8?B?N04rd0IwNE1raGc5MmVaV2djdFJJUTdMSUc1VmtpRXg2dS9Ocm5pZk9qOVdu?=
 =?utf-8?B?bEZzY0lqZEVucUtlM1BNN3prV25VV1R0NlVJSFNKYXhOVmJyRGMxWnhQZTdO?=
 =?utf-8?B?T2tUemJJSjYwWm55emdybUE5SGRoNmNDK1RHNHpRTG15QmRwdVkrZ2FNd29V?=
 =?utf-8?B?QkR2cUNhOFo5MUREYlFEY3RsN2IwNklrcjRaemwxbFQrTko4cnFrdG5GTHEx?=
 =?utf-8?B?U0NXMzRlYXlTeGFvTnErYm1TS3l3ZXJNQWk2Y2Z1Tlg4ZDdMTWwweDdPa3Rp?=
 =?utf-8?Q?Wdz0WsVaq1GIISmZmveea4KolxumU7JAsXjNZhEiOrER?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b444db-aca9-45c5-a186-08da6678a904
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:42:44.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53dPU/oWLSu9NJy0jZimsfB+/uod2EgLROTT0q9PqNHXwEMcZTTwyp2cW6BuchVgDEOr0ud0HR7FB9RfFJNE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-07-15 05:28, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
>
> Updated some comments
>
> -----Original Message-----
> From: Zhu, Jiadong
> Sent: Friday, July 15, 2022 5:13 PM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
>
> Hi Christian,
>
> The resubmitted job in function amdgpu_ib_preempt_job_recovery returns the same hw fence because of this commit:
>
> static void amdgpu_ib_preempt_job_recovery(struct drm_gpu_scheduler *sched) {
>          struct drm_sched_job *s_job;
>          struct dma_fence *fence;
>
>          spin_lock(&sched->job_list_lock);
>          list_for_each_entry(s_job, &sched->pending_list, list) {
>                  fence = sched->ops->run_job(s_job);       //fence returned has the same address with swapped fences
>                  dma_fence_put(fence);
>          }
>          spin_unlock(&sched->job_list_lock);
> }
>
>
>
> commit c530b02f39850a639b72d01ebbf7e5d745c60831
> Author: Jack Zhang <Jack.Zhang1@amd.com>
> Date:   Wed May 12 15:06:35 2021 +0800
>
>      drm/amd/amdgpu embed hw_fence into amdgpu_job
>
>      Why: Previously hw fence is alloced separately with job.
>      It caused historical lifetime issues and corner cases.
>      The ideal situation is to take fence to manage both job
>      and fence's lifetime, and simplify the design of gpu-scheduler.
>
>      How:
>      We propose to embed hw_fence into amdgpu_job.
>      1. We cover the normal job submission by this method.
>      2. For ib_test, and submit without a parent job keep the
>      legacy way to create a hw fence separately.
>      v2:
>      use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is
>      embedded in a job.
>      v3:
>      remove redundant variable ring in amdgpu_job
>      v4:
>      add tdr sequence support for this feature. Add a job_run_counter to
>      indicate whether this job is a resubmit job.
>      v5
>      add missing handling in amdgpu_fence_enable_signaling
>
>      Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>      Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
>      Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>      Reviewed by: Monk Liu <monk.liu@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> Thus the fence we swapped out is signaled and put twice in the following 2 functions and we get " refcount_t: underflow; use-after-free. " errors latter.
>
>                  /* wait for jobs finished */
>                  amdgpu_fence_wait_empty(ring); //wait on the resubmitted fence which is signaled and put somewhere else. The refcount decreased by 1 after amdgpu_fence_wait_empty.
>
>                  /* signal the old fences */
>                  amdgpu_ib_preempt_signal_fences(fences, length);   //signal and put the previous swapped fence, signal would return -22.
>
> Thanks,
> Jiadong


Did you have 'drm/amdgpu: Follow up change to previous drm scheduler 
change.' this commit in your branch while you encountered this problem ? 
I don't see an underflow issue
for the preempted job when inspecting the code with this commit in mind -

amdgpu_fence_emit
             dma_fence_init 1
             dma_fence_get(fence) 2
             rcu_assign_pointer(*ptr, dma_fence_get(fence) 3

drm_sched_main
     s_fence->parent = dma_fence_get(fence); 4
     dma_fence_put(fence); 3

amdgpu_ib_preempt_job_recovery
     amdgpu_fence_emit
         if (job && job->job_run_counter) -> dma_fence_get(fence); 4
         rcu_assign_pointer(*ptr, dma_fence_get(fence)); 5

     dma_fence_put(fence); 4

amdgpu_fence_wait_empty
     dma_fence_get_rcu(fence) 5
     dma_fence_put(fence) 4

amdgpu_process_fence (EOP interrupt for re-submission of preempted job)
     dma_fence_put 3

amdgpu_ib_preempt_signal_fences
     dma_fence_put 2

amdgpu_job_free_cb
     dma_fence_put(&job->hw_fence) 1

drm_sched_fence_release_scheduled
     dma_fence_put(fence->parent); 0

Also take a look here for reference - 
https://drive.google.com/file/d/1yEoeW6OQC9WnwmzFW6NBLhFP_jD0xcHm/view

Andrey





Andrey


>
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Friday, July 15, 2022 4:48 PM
> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Cc: Huang, Ray <Ray.Huang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
> Subject: Re: [PATCH 3/3] drm/amdgpu: skip put fence if signal fails
>
> [CAUTION: External Email]
>
> Am 15.07.22 um 10:43 schrieb jiadong.zhu@amd.com:
>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>
>> Dma_fence_signal returning non-zero indicates that the fence is
>> signaled and put somewhere else.
>> Skip dma_fence_put to make the fence refcount correct.
> Well quite a big NAK on this.
>
> Reference counting should be completely independent where a fence signals.
>
> Andrey can you take a look at this as well?
>
> Thanks,
> Christian.
>
>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index f4ed0785d523..93c1a5e83835 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1500,8 +1500,8 @@ static void amdgpu_ib_preempt_signal_fences(struct dma_fence **fences,
>>                fence = fences[i];
>>                if (!fence)
>>                        continue;
>> -             dma_fence_signal(fence);
>> -             dma_fence_put(fence);
>> +             if (!dma_fence_signal(fence))
>> +                     dma_fence_put(fence);
>>        }
>>    }
>>
