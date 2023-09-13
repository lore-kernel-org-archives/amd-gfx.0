Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF58EE3F3F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 00:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C1F10E0BF;
	Wed, 13 Sep 2023 00:35:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692EF10E0BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 00:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaqQxZQB/lO0Ah/67s2CjJtIboIR5H9hiXcCWysqxo5gIqfpKBAch8TeQXF0ldOVG9mQYrRUu+fi0pst+CouS1EKj5qC5hkiEG9zYb3Oxbrl9h4fG3zsWGAq9fCfuA1zGQ8I93dbYKmBlV58mQXQScL2IzY/hOc+vmmLW8d/3GVdoOgpmGh/PNiVCIk6DEKXgLnp6f4kqTrTqMZvLXGWQEoMcUOsUn0ksJwKjVpRTTM5IQ8ebuSCd68LeEQ2BtR4YPKJlmS88Axx8NcgaO8eZOx049I38SrJjaYA2ubL9TorqomihaiQrm4RHMzILZNZtWPbf63I84CDUl8lxA0+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuxEA3D+ZlILzcljeyuIaK/NHwN+RJ1QyNtndlExptc=;
 b=aKJ4L4wfxDuIi8eNh2NtFqkwSzTSbgjHCa7uGrV8Ubw1pf6+uAAZptGkFw39Ckhe5qupmH+2FzuJt4kztWbZg744HgSnS45Gl4PhIEseHcP32bllB+YDZa5tGrE+fW2ieq7+iaxK/xhIEJ8LKv6rB3mSm+zYpUrX3uvtm5vUPgaN7BLraBzyRmbSmtzbCW7jhnm5eeyO4gUZ1b3rUaSdjQR/kbDNZxfno0qApe3GuefKiF1Kyjx8L2+MRV+yZbDTAIr7qbwPsk6EitDAboRA1xIP8wrQ2LwXV1up1D7zZKkkN+umOI3d4I6V7WzZ3DBaVrDhq5zibqlnmSRa0hVMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuxEA3D+ZlILzcljeyuIaK/NHwN+RJ1QyNtndlExptc=;
 b=YOtgVihjCLOjz5OdZgL+yArDcCxQbjVvatsvrq7q9J/rRXBxIlD6sr4BNm3Q9S5ChBHnZ1xUxNSdiFBSsWs4Ca/NZqFY+zyfQ01iAL2Cn/zwT4YvjjAlNOn7GtWjQ+w5YT49cSIHyoxhwWfE12M/ZXhj2wXkDLzgfM51QLD9DQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 00:35:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::620f:8aa7:43d6:8010%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:35:40 +0000
Message-ID: <97d7d655-66b8-e117-471e-0785affeb660@amd.com>
Date: Tue, 12 Sep 2023 20:35:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Content-Language: en-US
To: Jonathan Kim <Jonathan.Kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c35fa97-652c-46c7-a503-08dbb3f15b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tJdmRjCx1G8UqzbGA/cYprOqoYbLn7ceR82ZuJltR3Fm/6y/0LA1PsmijveDaun6jwmhOPFzuHnbK0FEIwIFj0Rbo7J/KRD4zCI85y6gh03guALRCyih19iSgdig2aH+2g5FhQSp6Ozg0/N//Kowh1haGnkn4lEKVpJa6zf8e0XwnGc7m8NYKlmInPbnA6XfUrD51Lu5rX95mczecifl8/Mhw11U0n/IHcyRgYt/v36FaotrFlMKgZu10vmX+j3SsKNCen7He1sIBbI5N1L3DNEXyGmbRo/HM17TdMVTzGVwU/K9X8kR6ba374Nx3V6nwZEMr/Nk1ZwV/8/Kj06w1B9FWWRCZSUQgWXC0ckqJu8pGhvxs2HA+3meAUkoUnD4w6R1kntcjTV6wbcQwlB07zFiiDjJeb9hd+vFNUyX3LqaR4Y3dm+MUfKukodcIwTTD2t3tiVOQOJy2OCqdeDbFiEBtRqsbuQIWa8kWZlDnUokWVOj8kadNfYlmV9x1Kmitnl2h8ud+VhLqUjLHX1smSnUP2sTmrhVSmDIG7e86oUufkQUQmTI8HiVmbkN/3RsL9JzcKk7dLXD8XXDesgW/X1eyYWu6sfjZBBnOpWiPXzKLe71aD8jeZbq7xxXLsOqsGfmnh1ZvTtU6gusauIOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(31696002)(86362001)(2906002)(38100700002)(478600001)(53546011)(6666004)(6486002)(6506007)(6512007)(66476007)(316002)(66946007)(83380400001)(66556008)(31686004)(26005)(44832011)(2616005)(4326008)(8676002)(36756003)(8936002)(5660300002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm1ER2hxUmNQYlBkQkg4OHUwL2RHOXA4UTlxdmtjd1RQZ1BWL2lTczllTjk2?=
 =?utf-8?B?Z3pjRGxtUWJvMFFiNWdPRVBDaDFmb1VkZG9QVnVFdE40SjZxRjdoSlJLdjE5?=
 =?utf-8?B?eVJlRG9jby8wSU1iRGVtclhDSjlFWVVBZXFPb2RBcGNDZnVaTlhqWTh0SVBp?=
 =?utf-8?B?TmRGVWVLbEdFQ09SNTk4Q0ZlZzJUVEF3NVpvdkkzV01qNW1ObFZFd2dJSmNu?=
 =?utf-8?B?SjlRTU9Oa3NjMEUxT1hnb3VsSFNKSFdpMy9iWlRkdEZmdkV2MXlXeXZsY3VL?=
 =?utf-8?B?bE9HS1NCOVYvbStpNnNWY2JoWFJOOVJvUlVmUURQdVhienpiUTZDUnJSckRu?=
 =?utf-8?B?QTdzUy9rdThTT2ZGN2R4QzlydmtiMkFRTllBZmNnZFduRSszWkNYV2xLM3Jn?=
 =?utf-8?B?S3gwVlU2TEpmc051ZzZTQVk2ZThzdXBJeUR3SzZhaEJnR29XaWRqZnBPbW5j?=
 =?utf-8?B?VUNwSWVRdG8yOGpzazJnNEFlby8rakpHY2Z6RkkzS0Y5WHVURjJjZDRralQ5?=
 =?utf-8?B?ZWxNL3J4SkZEWnY3dTZKeWdXL3cxQ3RKVC9CenBrOWVhc3VYYkZTcWIrYzNB?=
 =?utf-8?B?NFBSblZSNHVCWmV2THRFeXNLdElkNXhkRFRIQkhIdGttZVl3NjF0R1A2Mk8r?=
 =?utf-8?B?SEpBMkQvQ1J0YzJ0Z1lGYmVjdG0yM1NqZGVuZ3UxbE1GTWlXaWhwM2UxQ1Rv?=
 =?utf-8?B?a2dLRHRxbDJnY2xpcVVXRWdQWmNoeU82VVFUWmFoZkI2Y2lKWjRYcDl1RWw4?=
 =?utf-8?B?dkZsOWkzWlVoeTdzTjE5Q0RjRlAzQzRKVUtQdzNvL25YTFQ3Q2Y0TERMRERn?=
 =?utf-8?B?WUlQMit6cndtQ2xrdVUzdXBQMnMvdFY2M0ljTmFPQmdRSW16Uk5VR3dOd05F?=
 =?utf-8?B?QlBKL1VDYlFKWEZFdVpJeHNXUU4xZk56dUtTSGdBSlpnQWFpOXR1UHdvOVRN?=
 =?utf-8?B?UTQ3bXVqaDY5ek5PdGoyaFYwME45VVdkYnNGd2l2QmR0RjJzdHFrQkR1Rk0w?=
 =?utf-8?B?ZE4vQXdzMzV1Y25MclpqbFJPT2RpTlphK25abGZRTGp2QTVRa2JZbXY0SzRX?=
 =?utf-8?B?S0ExbjdEbjdrT1JZWHRXU2ZLTWVLN0RGeTQyVU1TQlhRNlVsbEdqV2tPT2M2?=
 =?utf-8?B?Q3RlL01jaFp4RHB1OGhPTkh3akJWSDNBQkhlN2NMWGxQNGlQcnJvejlnM1pj?=
 =?utf-8?B?V2IrR2xWZy9DSnJQeVVNZ1hSUEJDK2doazhGc3h6MHg0QzdLV0lNK2o5dzNi?=
 =?utf-8?B?MWNLU0ZPbEcwMzZIYUs3cngzVlpMbWx1di9nZEErYm5xRkNPU1lpRDhqTUgz?=
 =?utf-8?B?M3lsc241MHQwZVc3UzVVWm9QUVllR3VIa2tPbnZiRnczNG1qWGhreURwdm5R?=
 =?utf-8?B?L0VtUERRclVBVk1RMi81QXkraEpDS1pTS0hkaUFVSlJCQ1BucjI3MXFrMEhO?=
 =?utf-8?B?dzc3UWs2aUNyR1p3bDZqcjhPT2pGcm1PS3lQMnQyWEM1bG81UE45S0FETTJx?=
 =?utf-8?B?RXNSUEJNVHZtd2JCWWtkZVhmV1dXTGllWTFHWTM3OEFCdDM0SzNyTXNiazRp?=
 =?utf-8?B?RGNwQVAvNXFRQ1JUMTJFclplU011am5FblZCekdwbEQrcHJDN2U0R01vN0VX?=
 =?utf-8?B?WVdTWGQ4UGlmNGVJSXRYQ3NFZ1Q3M0xjYVF2UC9WcGhqNHZYWlZGQ0ptNnpK?=
 =?utf-8?B?WHNUbVpjdmMwSHh4T0hPamw2UlptV0NKS28wTmI0UjRNYzlGQldLOW5BU0FC?=
 =?utf-8?B?UTN1cFY2am5zTG9EVlJFRjZENlQ0aGgvMzlpZDBDK3J5WkhHZ1BscWNzeWYx?=
 =?utf-8?B?Sk5zVitUeWxkcE41YXpBWFZGeUx5K29pOTkxNmdaNm9TZHVNYUgxSGE5eUg2?=
 =?utf-8?B?STRuUVBUZkliMHE1bjhxWkJ4TnNWS2tSRmI2cjV4SjlFdmdXazlMRGhvOE1V?=
 =?utf-8?B?K09VRzFMSndkWWlGcFZLVzh2VDR1OG1LQU1nZmdyMHhPVk55KzV1a1NEbHZh?=
 =?utf-8?B?UFNzYWtOcElRWXBrb1pPYkxRTlZmQzVpSWpkVkhycG5ndERVQ1BhYkU2ai9i?=
 =?utf-8?B?dDNKeTJtWi9qMDVxYWttTmNVNUtEZHo0YkVBbXErekk0b0o4akVCVWhXajZv?=
 =?utf-8?Q?UlBmWpkD/muOMdLGmi/rSmD+J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c35fa97-652c-46c7-a503-08dbb3f15b4c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:35:40.4533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ix5UzntjJwoP+uhd9iiatVQGb/x12MFniCi2f2o0Msnl8CX9HOQlSZfTIO8RHKdyH5/fOaCVrff603Zi2c+r+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
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
Cc: Ruili.Ji@amd.com, JinHuiEricHuang@amd.com, Shikai.Guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-12 8:17, Jonathan Kim wrote:
> There are cases where HSA is not initialized when adding queues

This statement doesn't make sense to me. If HSA is not initialized, it 
means user mode hasn't opened the KFD device. So it can't create queues. 
What do you really mean here?

Regards,
   Felix


>   and
> the ADD_QUEUE API should clear the MES process context instead of
> SET_SHADER_DEBUGGER.
>
> The only time ADD_QUEUE.skip_process_ctx_clear is required is for
> debugger use cases and a debugged process is always runtime enabled
> when adding a queue.
>
> Tested-by: Shikai Guo <shikai.guo@amd.com>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6d07a5dd2648..77159b03a422 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,10 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = !kfd_dbg_has_cwsr_workaround(q->device);
> -	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled ||
> -					     kfd_dbg_has_ttmps_always_setup(q->device);
> +	queue_input.skip_process_ctx_clear =
> +		qpd->pqm->process->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED &&
> +						(qpd->pqm->process->debug_trap_enabled ||
> +						 kfd_dbg_has_ttmps_always_setup(q->device));
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
>   	if (queue_type < 0) {
