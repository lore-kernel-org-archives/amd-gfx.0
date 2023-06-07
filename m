Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF1C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 18:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D72510E4F0;
	Wed,  7 Jun 2023 18:19:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6ED10E4F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 18:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm6bw49fFqnjkcePc2hh/n+7N5fjQFuzUD+zu+lOU1M1Kn9PxjRNdarO5oKBdN9rff/lLqSaAOg2mxoQk3Fin5G54Ptk0VyDbWRYAYgkuwKzCTQbd0EeXgKtuT0nWhHXAq/bSiW3LxoMdhCMHP7ILUj/BCoiaaIW8TyoMvlelbBIsAAvKFICilSmS+T/5dVARmMpZYRN3hKy1O0Y6N4DVSVCkdbZ0j5wMaSZf0lgk5Hcxbtly20K8EmXkQeOzxo5cNrz+ylGKbwkYswL2WWtmXMMzfJtOcY266c62XfSBXrF9wDB44gWvaBw4E6nBsluHe77cCrjdX+yf9ehd5xEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e51/bmLUpL20Ov2vzd60MWJtgT/LAlG1f4vgpEuAJ0=;
 b=EpxnBW/9fi9ersvzeOtIM7js2ioxLGduERIP6VsRKBe7bOIqARO2mPn9PS+uDiJUjPuPyg8TIbegRj1uPpZ3BBcvp/hEMmuO3Gp1YZftx3iFwUMsSn6nXZ5/1oAzVAcFtMpwdq4ppMtq843EuenQiL0qF/j2fE1sMXWJvL180a9zQZo7Tp+tXoCmxAim67s4/Moqsxuw+emFGPR2UepXN5Dz8zk9iTJkhRm4Q94+GUJrHZoOvbbrCxZGCI7AOo/AjuvLBSOKXlm5jOT3Qv5T68C2HcUXlTQsWlWK/wHXtHyRrq2ZWbEXQ7lKlG9KPx+LeApm3kMxp2nE4hCaj5WCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e51/bmLUpL20Ov2vzd60MWJtgT/LAlG1f4vgpEuAJ0=;
 b=ggoZg4JwZnO3j4wGPQjtpWUDUz0G3jKu0vUZow6PchXjXO1YRUYFCHsIlqOIsIOprcswPEy4TQ2pfXJu10iICsFLycyYGwGM23LmoJN3Yn5D28KnDiEqIT4RV97M9hGYcz8C19lnEoJvU/Ec5yQJDAxLuXnoozkWP5suCPRFxdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:19:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 18:19:50 +0000
Message-ID: <bdcb24d4-de8c-81fa-b794-49395cc69819@amd.com>
Date: Wed, 7 Jun 2023 14:19:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20230607172647.1824726-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230607172647.1824726-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: d33bacd9-af01-4cce-315f-08db6783c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MES7fKDI3yMd0SOiIi4c1XBNAAH+QTiVHhD0i0eo/1bk9y7jTr+lbvRHYd7BOFsdi/tjdzbPuxcmBtKoVWqdxZNAGifLcVXvHB69lFby1EKDNGaKe3pxqwHlWbXTf7cjFfQIbj2DAVpB2AzxXNaQg3OEUjWn9Ypp5uU/BNICAI52Hc/74FN5eq2g4oQgD8L/GtM0jtclwDvBAj+uOBBMQ2/6HsLdx1rz01/Ldz2LgUgVc7itzjgoJBTy91QnJ8Tm7yxUdIhn87rX/TZJ0pX6uubCav+Cs5LLfq0X14kKhqjqxAkOQOPbKkz2WLrEBvrxJhiiRapKCDc/mGzwPdSLE0lIkC+xQ8F8FVOgrbS823kVOwu+kUCWQgJ5Vk7lV7d26y/cMEd9S4yDHr3t2AlliiyvygzbE48u9rRoJAgR6glmQYmgADsO3cb5Lx4+hR0oGGDkavUXM75z2fCtrauze9xdEbkD+zsjYziC8wpd/sj4QGOw4CiXZtTcpa6Rq5b1OTiYkt2lVP3ERLEb4U687rz0yjDVM/TqnugXCPTrm89ROrhmXS74aMyXkcn8XPgTAg8S5VZ+hdOzDHvl6A/c89WrX3d7/FK6AcNAVTH1aSKWDgyKJJRMf8RHMh+p+OjUUy9pSGJrcgql1+1gZxtrYu0GKwlEPQbWkTls5W0h3stB8l7vU2oQcZqI8oroBwX6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(36916002)(6486002)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(6512007)(6506007)(26005)(53546011)(186003)(8676002)(5660300002)(8936002)(6862004)(316002)(41300700001)(2906002)(44832011)(31686004)(37006003)(66899021)(478600001)(66946007)(66556008)(66476007)(6636002)(4326008)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3NKc0NxOHM5VjJHZzB1cFd4OUtSZ0JJQzFKdDdRMWlZZXlYUHQ5WU4zTktx?=
 =?utf-8?B?aDN2V0RMUUNmZXR3Z0dkRFNVekNoTWtJbk1VL2pjei9tWmNKdFhKNG91Qjk3?=
 =?utf-8?B?dmRac0xYSFVhaFRCTlRTODlEamJEN0ljY0hnUjlHbWdadzI5SUszQldqSU05?=
 =?utf-8?B?MEd3RlQwT3ZRUCswZmsyaW9nV2N5T3A2VjQzMHZZNGlEUUh1TG9Hc3V0QUhK?=
 =?utf-8?B?MmE0YUVyeDdpTjVzdkFGeXBzOXZldkROTzgzaTE5eGM4WU5WeDJrVllpQmNW?=
 =?utf-8?B?MFYxNk5NN01UaThKUjZFZk9GNys4REU3RitVVXRTbEhDL0NtV0R0MWV5UGxN?=
 =?utf-8?B?QmlRTUdsc2ZPWXFsN0tMeFpySjlLUlhmbExWWXkwOFpWWno0dllHT1pIYkYx?=
 =?utf-8?B?dSs0NkdqbHkvQUsrV2xKRG5QOXY5Z3VrcXFwUXd0Qk9raGR2YUdFZkhTVzVJ?=
 =?utf-8?B?ZTQ0SVBsdDZhNUE4MGQ0MU5lRThMWG5PLzhhdW1ZTVRNVzdXRGdDOUgrek1h?=
 =?utf-8?B?OC9mM21hYk5sVVB4aTg5TnF1NG56U1NkMllRWHgyUEdLdWNMQVo1eEVxSEFx?=
 =?utf-8?B?Y2ZqMW0xcFJuVnFWSVhOZGNUeHJ2dWhmWWZ6bm9rUU84NkhuQWVBdER0WTY2?=
 =?utf-8?B?MVpzNXFHQk1BK0N0MG5BTk8zQ3NPcUZ5bWJTSkdEYkcwK2pxV3oyZURHNzRS?=
 =?utf-8?B?QnhwcCtER21rbUFnMnhzVkdWRnpSQnhlWDJOMUNGTTJtS29ZWjZXSUV0c0tV?=
 =?utf-8?B?dDhzeTFSL010V201OGl5aVYxcThSUXo0STRKS0tuU1dLcVNGZU45VjlCeEc3?=
 =?utf-8?B?Q3RyZFc2ZXhwRlYxUXNJZDRUbmNtVGRJOWNDT0FtN3kyTDVCWmdJaGlGdXk5?=
 =?utf-8?B?a1JhNk9URG40OEFNQUlOYmNlbVRZSk45aVdRVUdYenorV1pIM1B3S0VHTlRz?=
 =?utf-8?B?cTN4WnBZNitZeno4ZlZwREZZYkpyTlYzY1FWdWtGUXZBU051MzlxU2grV2lP?=
 =?utf-8?B?Vzg0SWh2MmVJK3JzYm1aR1Vzc3dvdlBxSVZsSjJEcDU1dWRZczIxYjhEU2Zy?=
 =?utf-8?B?VlFtRkdQL2xjNmpYNklQNjA1VVlPS0psU0VDSkh1RGZWNXdHWkZOejF4OVFE?=
 =?utf-8?B?RjJ3YTBDcmdST2U3K3F6bVFRZXJSZGlPd0Y5VStDUnVpazV1UkowR3ZHQ1lS?=
 =?utf-8?B?eTdZMlFPaGUzWXFJQkFDQlMwN21tODJxYklERmQ0TUtsOUVrd3JrUXBOV3Nj?=
 =?utf-8?B?b3B3N1l3MUJhcjA3MGlIRzZ0M0oyT09kRkdWUkFOUnFoazVGall1akJJUTJt?=
 =?utf-8?B?OEQxdk1YaGxlRUsrSS9iTDFPVzhnMVZ0MFl5ZXhnRHBGaHh2czVMKzYrZkJ2?=
 =?utf-8?B?TS9LNlhRSm5ZODRFdGhwdGVBRHVXRnlaZkdkYmx2RG9DOUljQ3p6NGhFa1Yz?=
 =?utf-8?B?anJ3Qm4vN3hHYWdkSFN6NHEwZDNvYUJsMnlybEtGNUV2aTRwWnRqWkxVbHFt?=
 =?utf-8?B?enRpUkhwUHcwdUZWT09ybGFPZjQzRnY2MTVUY3hNb3N6T1haWnBzcWtPZXpG?=
 =?utf-8?B?ZkJuKytBWVJVVmZwUkUrUENITmVrNTFEYW5IcGcxZ096WFpDT2NKK1U0dnRl?=
 =?utf-8?B?cTFkM1NBUUxmeGRnWnNKdHVWSDZPUlpSMW01SSs1RDdPRjVTUERONmRMcXQw?=
 =?utf-8?B?NmErVE9RYkNOcFdCVXQ4TlpmSENxSWJCdmZBVG8rbXprQWFwUHBHNmxId3FO?=
 =?utf-8?B?Y0JHZFkwNFZQWVJpbEcrcVc0ZkZ6Uk5oazdRcnhIQ28ra1IrUjNQN0lObnZF?=
 =?utf-8?B?cXR4UlJ6djkwMXlOMW5Na1Joai9hSDFkNlk0VWhCVUhxU01uTHF1clp3akhk?=
 =?utf-8?B?S1RkYXROQTFjNk1mZlNRMTB1REZ2anNpTG90ZzdqSWhqMGtla2tLaCs0Ui8x?=
 =?utf-8?B?eTUwaElHMmpzMW1HUVBXRG5vZjZrZmVpMURxek56THR2aEtTTWRqblh1Si9p?=
 =?utf-8?B?dlZXK0xhazhGSHRETm5YWEE4QnNmdkJyMmhES1lhaVNia2MzRzFiZVRpSUw0?=
 =?utf-8?B?Qzh4UlVBeHJ0c2lBazlKU0FaK0dGUzdxcE9IVDdLL3FmVkQ3Y0UxazlsWDlC?=
 =?utf-8?Q?rHEf9axC9MnQ9Lz80asQ9LfKE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33bacd9-af01-4cce-315f-08db6783c87d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 18:19:50.6955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fzKprOa0gsKtVx47XjWmWNZKCVu70mvSOXtkeuIlwomiYqKx+jGz+4a0LDW78JZSB+Z7OCX8rnRkVosuQWwog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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
Cc: "Huang, JinhuiEric" <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-07 13:26, Jonathan Kim wrote:
> There are a few fixes required to enable gfx11 debugging.
>
> First, ADD_QUEUE.trap_en is an inappropriate place to toggle
> a per-process register so move it to SET_SHADER_DEBUGGER.trap_en.
> When ADD_QUEUE.skip_process_ctx_clear is set, MES will prioritize
> the SET_SHADER_DEBUGGER.trap_en setting.

I see you have a firmware version check for enabling debugging. But is 
the struct SET_SHADER_DEBUGGER change safe with older firmware when 
debugging is disabled?


>
> Second, to preserve correct save/restore priviledged wave states
> in coordination with the trap enablement setting, resume suspended
> waves early in the disable call.
>
> Finally, displaced single stepping can cause non-fatal illegal
> instructions during process termination on debug disable.  To work
> around this, stall the waves prior to disable and allow clean
> up to happen naturally on process termination.
>
> NOTE: The AMDGPU_MES_VERSION_MASK check is a place holder as
> MES FW updates have been reviewed but is awaiting binary
> creation.  Once the binaries have been created, this check may
> be subject to change.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 31 ++++++++++++++-----
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 12 ++++---
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  1 +
>   7 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 20cc3fffe921..95d69f9c7361 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -928,7 +928,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
>   				const uint32_t *tcp_watch_cntl,
> -				uint32_t flags)
> +				uint32_t flags,
> +				bool trap_en)
>   {
>   	struct mes_misc_op_input op_input = {0};
>   	int r;
> @@ -945,6 +946,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
>   			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
>   
> +	op_input.set_shader_debugger.trap_en = trap_en;
> +
>   	amdgpu_mes_lock(&adev->mes);
>   
>   	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index b5f5eed2b5ef..2d6ac30b7135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -294,6 +294,7 @@ struct mes_misc_op_input {
>   			} flags;
>   			uint32_t spi_gdbg_per_vmid_cntl;
>   			uint32_t tcp_watch_cntl[4];
> +			uint32_t trap_en;
>   		} set_shader_debugger;
>   	};
>   };
> @@ -361,7 +362,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
>   				const uint32_t *tcp_watch_cntl,
> -				uint32_t flags);
> +				uint32_t flags,
> +				bool trap_en);
>   
>   int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>   			int queue_type, int idx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c4e3cb8d44de..1bdaa00c0b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -347,6 +347,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
>   				input->set_shader_debugger.tcp_watch_cntl,
>   				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
> +		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
>   		break;
>   	default:
>   		DRM_ERROR("unsupported misc op (%d) \n", input->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 125274445f43..e7bc07068eed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -349,12 +349,30 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
>   {
>   	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
>   	uint32_t flags = pdd->process->dbg_flags;
> +	bool sq_trap_en = !!spi_dbg_cntl;
>   
>   	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>   		return 0;
>   
> +	/*
> +	 * For displaced single stepping, the debugger inserts s_trap instructions
> +	 * from user space.
> +	 * This can race with the CWSR workaround during a non-IOCTL disable and
> +	 * cause non-fatal trailing SQ illegal instructions.
> +	 * As a work around, stall waves indefinitely in this case as the process
> +	 * queues will terminate anyways.  MES will automatically clean up the
> +	 * SPI debug HW registers when all queues are unmapped.
> +	 * IOCTL disable will not hit these cases as the program needs to be in a
> +	 * non-continued state to make the disable call in the first place so
> +	 * debugger insertion of s_trap in debug memory will never occur.

This comment has a lot of jargon. I don't know what "non-ioctl disable", 
"non-fatal trailing SQ illegal instructions" and "non-continued state" 
mean. Looking at the condition below, I think this is missing some 
context. I think you're trying to fix something about process 
termination (!pdd->process->mm), which is not mentioned anywhere in the 
comment, or obfuscated by jargon ("non-IOCTL disable"). I think you're 
also making some assumptions about how the debugger interacts with the 
CPU threads of the program ("program needs to be in a non-continued 
state to make the disable call"). Making assumptions about user mode is 
not a good idea. A different debugger or tool may use the debug API in 
unexpected ways.


> +	 */
> +	if (KFD_GC_VERSION(pdd->dev) >= IP_VERSION(11, 0, 0) &&
> +	    KFD_GC_VERSION(pdd->dev) < IP_VERSION(12, 0, 0) &&
> +	    !pdd->process->mm && !sq_trap_en)
> +		spi_dbg_cntl |= 0x1; /* Set SPI_GDBG_PER_VMID_CNTL.stall_vmid */

This looks like a HW-specific workaround in non-HW-specific code. Is 
this something that could be done in kgd_gfx_v11_disable_debug_trap?

That said, if the pdd->process->mm is NULL, how can the debugger still 
access the process' memory to insert s_trap instructions?

Regards,
   Felix


> +
>   	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
> -						pdd->watch_points, flags);
> +						pdd->watch_points, flags, sq_trap_en);
>   }
>   
>   #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
> @@ -557,6 +575,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   
>   	if (!unwind) {
>   		uint32_t flags = 0;
> +		int resume_count = resume_queues(target, 0, NULL);
> +
> +		if (resume_count)
> +			pr_debug("Resumed %d queues\n", resume_count);
>   
>   		cancel_work_sync(&target->debug_event_workarea);
>   		kfd_dbg_clear_process_address_watch(target);
> @@ -598,13 +620,6 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   	}
>   
>   	kfd_dbg_set_workaround(target, false);
> -
> -	if (!unwind) {
> -		int resume_count = resume_queues(target, 0, NULL);
> -
> -		if (resume_count)
> -			pr_debug("Resumed %d queues\n", resume_count);
> -	}
>   }
>   
>   static void kfd_dbg_clean_exception_status(struct kfd_process *target)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0c1be91a87c6..ff0a28760494 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
> -			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0) ||
> -			      q->properties.is_dbg_wa;
> +			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0);
>   	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index faa7939f35bd..90b86a6ac7bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1863,13 +1863,15 @@ static void kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *de
>   {
>   	bool firmware_supported = true;
>   
> -	/*
> -	 * FIXME: GFX11 FW currently not sufficient to deal with CWSR WA.
> -	 * Updated FW with API changes coming soon.
> -	 */
>   	if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0) &&
>   			KFD_GC_VERSION(dev->gpu) < IP_VERSION(12, 0, 0)) {
> -		firmware_supported = false;
> +		uint32_t mes_api_rev = (dev->gpu->adev->mes.sched_version &
> +						AMDGPU_MES_API_VERSION_MASK) >>
> +						AMDGPU_MES_API_VERSION_SHIFT;
> +		uint32_t mes_rev = dev->gpu->adev->mes.sched_version &
> +						AMDGPU_MES_VERSION_MASK;
> +
> +		firmware_supported = (mes_api_rev >= 14) && (mes_rev >= 64);
>   		goto out;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index f3c15f18ddb5..0997e999416a 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -575,6 +575,7 @@ struct SET_SHADER_DEBUGGER {
>   	} flags;
>   	uint32_t spi_gdbg_per_vmid_cntl;
>   	uint32_t tcp_watch_cntl[4]; /* TCP_WATCHx_CNTL */
> +	uint32_t trap_en;
>   };
>   
>   union MESAPI__MISC {
