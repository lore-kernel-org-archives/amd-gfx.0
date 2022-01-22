Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15208C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jan 2022 06:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C4A10E49B;
	Sat, 22 Jan 2022 06:42:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E35F10E49B
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 06:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFxXjJier8SnA+pbfNTTI4Cxrh2XJ3GgTaKOINeMPLSMAe8TH6R1L32jo4qGwk7depODnLBsbCWRdB8fNdimbNWPReqIwoC2z454lAe47xiozi24x3P/5BqObCMRkNpAsxlUzTRJKhbX5MNROWIWa8WPTCl5hG0Ja5euDbVXUe+P72KfTRsFbaWrwUFk3J4DK9+cd6njLBuOUFnCDtg9RczAzCQmDqHtBdYF+BkpyH71k9E7E2iMfOrgJLqBDWr3AdLqChmgyEmksZy6k1pVHIH4zcFlL4ulFQxIwXpci2CiuPxsz3DLOO+B4pWgZnwTHEdCy2LB72xfGW3B9QVrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRQClfIWqF3hIxUk7PS/kGBsdmaPEhVbqaI5lmFpwJs=;
 b=jYRCQpuNDXcv7/yNe1nwVZomRYoiny1793SyS/QwLzGll6el3Em2pKbYup2bqNza4/22YSHo1TksHTbAb3to/+F8syycrsR7L8T++1LoSCSC3bPpGYLRyHrcMCcS5FyK0/ga5nxm/A0vJywpNFooHd2pz5A8Mfhk23rMHS14IeZp/w0eDidUl2FxrXwMhogzFSy2yuZ8T2oLb99d4TRXTjF/ogVlK62fX2x67QivjyhdQPNpVHEgQVekYLX09OnFMZJXRXnaYGdjrZDNEJgqP9L5EG6CnFYhVWu/4LXFLfZkSQkPBWepIGtu3FSvsUI3fcF6nxgs+TSzBk+teMJxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRQClfIWqF3hIxUk7PS/kGBsdmaPEhVbqaI5lmFpwJs=;
 b=Ll7yK+dC5wYg2fQVHo4a6XTWvDSVut+GenbYw8LBMkF1rs1S2GP5Xyuom1eVY+Y7kcUfzr+1tOvBDT0rrQSLhL2T07wqJXs4aND5QZqZRweQnauv9/e5A48aMDT3oQ33qdslgwS3r+47TrQ4bBI4pxzooVpXrYsLARH1kTQKj3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR12MB1655.namprd12.prod.outlook.com (2603:10b6:910:11::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 06:42:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Sat, 22 Jan 2022
 06:42:39 +0000
Message-ID: <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
Date: Sat, 22 Jan 2022 12:12:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8845ef0b-58bc-441f-3984-08d9dd726219
X-MS-TrafficTypeDiagnostic: CY4PR12MB1655:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16555032FE2F98939E27CDA3975C9@CY4PR12MB1655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmw2ikAef9eVd5sqS5p14an6qvVIZnkcEsP2Ys03ugdrt6oHIN067dgy9bTXqfzkoSP5UVUNOyycqPH8XR2Dnc0zx7abLJkBqejBddxbRCfJH7wAi3xNHAivczPwUTZSX+/fDfUUbtuWYp70P7ekuleVfzFTKKLEzoIRw0yt5w8Ml0tfFYzyptEvDBnYkBh68+TwXVfQFU3AXeowFOP5tG6cCYadzAwJcogNsnbyMPmC3c/KxerLmMzC3LO6QiWJSSnsyTE3C9WyXgVnzu3jVlEZ4gyRYup459isavzEmx7AT5K2nzlV5bWSeUP0LN7dlmzMZpQvWI03S6pgwI8Ci4wCTaH5r4ukzCbc/9WLpZT1KR8ie4THI5KxWEvVnqjRF6tPYTB11hzw7c4RAXPlGSTSk7BRl/v65a3VjTA6aFL4D2Rec7MWDhTjlmimaN27W3pAMm4msSvvbKYoSkQZ08WeMiij7087Qy2gJj6qpNGDL4/UxA/MdQaDBS9OTkSkOh4aiiIfEdzfVt68MF51t+SKE7uHXOTmkqbNy9uPg+D81gW79/Wl9eZup1Jex+fxtHZjJbGCJTw4UIn/8TQGoR9S20Q6YzPWOu4kTY9+LT9f0Kn46gbNiMgJYfbJg8wsh2ZX9KHx+MNwFr+IZQFrXsxKbt2dUuo02L0coYUkA5+cY5oDwuONsv9HA/ZmvtVHnztCo/2EorVN0HPdX1Tbsk1fX6OrBVd7bu/Ny3peMtUFv4MqijBukZNfGT55ShZSs01FCSvmyHjF8wUJSvLNptu/yqDunQkgoWJbBU/XOl2qSJm+h+/PQk5n+wAxDTs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(26005)(54906003)(53546011)(38100700002)(31686004)(6506007)(4326008)(110136005)(8936002)(6512007)(8676002)(508600001)(6666004)(66946007)(66476007)(966005)(36756003)(6486002)(186003)(86362001)(66556008)(83380400001)(5660300002)(2906002)(31696002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2h6bEZRMmozdFkxdGg0SnZVMUlqdW4xTkswRWJGSUlYeDdVblJJUDQ0dnFC?=
 =?utf-8?B?R2N5TmFkc3hCNjhZaS9qMnlkT0E0cFZhRUx3NHhNRHNJREVwaXRPWU9XejZX?=
 =?utf-8?B?OGd5MFRIRUlOTXFsMHpyeG0vc3Z2VEYyakdPQ0l2REN1enRKUzFBeDE1L0ZK?=
 =?utf-8?B?empJdU8zYXk0R09MbGNwbW0yamMzSExmaXI0MUZ2cVM5QjI1NE5hQWwxV1g1?=
 =?utf-8?B?dmd2YkpQc3FKaCtZOUJiQUpmOWgxenRBRFhTQ21Hc2JOVXBpQmNzVUJDa3hZ?=
 =?utf-8?B?SE14MU8rdUV4anNmRStqZEpmQUQ5RWZwN3ovZXlZRXRYZ2JwTmd4ZzJURVZz?=
 =?utf-8?B?T2RiRzhFQXVIYjB4ZGhrblZjUW9vbk9oVmF6amowTXVoTEM0amovWXRhYmRJ?=
 =?utf-8?B?Q0Q0RFRjQnh4WjlSeVdLMXR1aDVIMXArM1BNdjE3bk9OaTNtUWs0SnVVOEI4?=
 =?utf-8?B?dXVjRTZVTjhOUEZpRnB0b0pCaWMzSkE1ZGVZUXI5azlybW5rNnBjK2xuSUJR?=
 =?utf-8?B?V3ZmbWZ0ZlF0WmlybGVpRkpIN1VZYkJvMmVjbXgrci91QkRPS05IdEZoYlhi?=
 =?utf-8?B?RElBYkdnak1Dc3h4Q3Vsc2Mzb3ZRdEFBWkdkYWdEeEo5RlVpZXRyKzVtdUIy?=
 =?utf-8?B?emZLMFc5NkJXdXYwOFFBSHZhTDFWaVkxMGNHaGRwYm5ZRUJSOVZ3MHFTeWZa?=
 =?utf-8?B?eWw5aDdQUVBaaHJkd3h6NTA0Q3RZNlRMdERzU3ZrZTUwM1FQYVNMSmdScEdY?=
 =?utf-8?B?ZzY3ZjlIVDF6VjZXTXg2eXNlcWdGMTk0M2RrU3hUaDhPdVptUkZNMlJ1QzV3?=
 =?utf-8?B?eWpNNVhTS1U0VklyUkdzSmhLUHp5Q1JJZVdqT2Nia2gyNUNiNTVZa1J1MThI?=
 =?utf-8?B?RUsrNzBZTUY4aWdVbm1uWGwxaXdZc1k4TW1EbmhPclhoNmZWODJJZnplZHVl?=
 =?utf-8?B?SE92V3dGVjd3b3ZtSDZxaHRmTXJsL054ZWRMKzgyaVJpK0tUNUtSc3A4dGw2?=
 =?utf-8?B?bitTOWY4c0IvcVBMVW1FUzhOY2ZYbDg5a3BJWCtWNmhVMlY0ZWpwRFN5RWVr?=
 =?utf-8?B?L0NheFZTZFpEOHl5YmFtc3o5YXAxZ1dVZ3RZVEgwN21pbnFSemlTWkR4T3ps?=
 =?utf-8?B?Mk8vZzVCRGI5TnI5MTduZ0hRVzlVT0xtYTcrbUFraVE2WTBZSWVTUjJ5Q3Fx?=
 =?utf-8?B?K0xSdmIrK0lyamFrYVRsOUNKWmltUi83QjBqZG9XVy9sZVNwUFhiUTVOTWFo?=
 =?utf-8?B?UnQxRUFxeEJsTHMrODQ0V1Ryd3ZCeVorN2kxeUltMGFqcjg5MG9zQ1lVcVll?=
 =?utf-8?B?T0lQbHlYMGZlMExRK0kyb3BGdlhLWTdpQ3JXdTNDRGFUa1UzQmhIQ293U1Jy?=
 =?utf-8?B?STBnR09hcWtKVkt6N2NudHJZYWU4MXRFNGVDWk05RG1rVjhiNGxHK0l6UHcx?=
 =?utf-8?B?elgxTk5xWENjTEVTdHE3NitvRWZVN2NJTlE2dHU1K29GeVE5T1RJaHhNQ05q?=
 =?utf-8?B?V0lFMWp5cHgwdDRjZGNYaEJWMjRINGJaS2xCK1NJb1p3N2FCMjFYbTBxenlk?=
 =?utf-8?B?ZGc0OU1HNTJOS1V3czY3VzRuTkFvSGhUY1JqWm9FcTEyeVhYclBzaHpXN1g0?=
 =?utf-8?B?SkpkT2hqbnJVQUR2b0diTnloSUJLV1EvV0ZrbExGQTVHRlNRNGcyT2dNV3Nz?=
 =?utf-8?B?bEhkcEFFZ2liczQxa1ptVlZVYVQvdnJybHY0V2hlcldvMEpaa0RoMTIybHNH?=
 =?utf-8?B?VExjNHlUc2JzTDc2eDBrSkI5cExuR2J0VU9ldFdUUlRZMXRmT3BYSklXVFhD?=
 =?utf-8?B?YmZ4SDhVL05DclppRGRtU1FxR0Jpc3BVQVV6NUl5Wm0vOTBFL1pESTBtbnBU?=
 =?utf-8?B?SUUxVHVDcEZFVnd3SHNXU2hlYk1vKzJGRWxUMzJka2N3N1NTSmxRcXB2M2NH?=
 =?utf-8?B?VFk3VGo5UkM3WlhmeGZDb29BZWkzL1ptRkJndFZmVW9xSnlPbk1uUVg2OUtP?=
 =?utf-8?B?V1ZpcExNbU9yRXlOek9KaXkwTWdUc1kyN2x2ZFZwRU11dFpoMm1HRkx0THNI?=
 =?utf-8?B?c1Z2bmp6VjNGaVZDemZXWndQN25ETVdlZElaeTdINGYrQVhZUGtJNWZ1ZkJV?=
 =?utf-8?Q?xBBU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845ef0b-58bc-441f-3984-08d9dd726219
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 06:42:39.5059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ng7JMCH9HF6KZrxkCw8t/VYzFwQjp8Xx8oDkWj/mVwB0zYSsw/uYWOTQdonHQ5Ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1655
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/22/2022 2:04 AM, Sharma, Shashank wrote:
>  From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Date: Fri, 21 Jan 2022 14:19:42 +0530
> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> This patch adds a GPU reset handler for Navi ASIC family, which
> typically dumps some of the registersand sends a trace event.
> 
> V2: Accomodated call to work function to send uevent
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
> b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 01efda4398e5..ada35d4c5245 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>       }
>   }
> 
> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +    int r = 0, i;
> +
> +    /* original raven doesn't have full asic reset */
> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +        return;
> +    for (i = 0; i < adev->num_ip_blocks; i++) {
> +        if (!adev->ip_blocks[i].status.valid)
> +            continue;
> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +            continue;
> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
> +
> +        if (r)
> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> +                    adev->ip_blocks[i].version->funcs->name, r);
> +    }
> +
> +    /* Schedule work to send uevent */
> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
> +        DRM_ERROR("failed to add GPU reset work\n");
> +
> +    dump_stack();
> +}
> +
>   static int nv_asic_reset(struct amdgpu_device *adev)
>   {
>       int ret = 0;
> 
> +    amdgpu_reset_dumps(adev);

Had a comment on this before. Now there are different reasons (or even 
no reason like a precautionary reset) to perform reset. A user would be 
interested in a trace only if the reason is valid.

To clarify on why a work shouldn't be scheduled on every reset, check here -

https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2188


Thanks,
Lijo

>       switch (nv_asic_reset_method(adev)) {
>       case AMD_RESET_METHOD_PCI:
>           dev_info(adev->dev, "PCI reset\n");
