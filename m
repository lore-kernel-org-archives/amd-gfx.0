Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A92C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1B210EB59;
	Mon, 24 Jan 2022 07:15:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B0D10EB56
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho3JeIx5uYu6YXUABCPG4bYMdwE+y+ZiC8NjJSL5uMXvzLSPwkGNbWWUv0A8D/v14TkdjtSV12CsAr5sqOLB/YvpVWKpumbriu6Ox/HlmV8L5IlL4jupPTMCXy47/3LBqOKTED/lOpIdpe+ANlGOztDsbDOoxxAx//L+LQINvlzdDHzobTClMRHDRWRm0PNLfHhklWghswuVkpfdzgy557/kcImuZql8bEUVbH1AXKabdkcDVczq5CjFzcrJ9/GLVfaiTRhD9s5tbby/W6RlON2KREUFswTYBVVeNe9UoV8ASpzyAW+aQWYGjjJ2/qOKtOE69TkuHADEQiB1s/k5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDnuhXBntjTIIsPhfZ33ocJtXrkaMF7BDAj4JahmTlo=;
 b=nx5Zl8uqaPJV3Jr0UUZ5EraIRdvSVIu1Vb35soWbj8jigzbgSjbzGchtANEUdg7YJe67r6sRaiKXgwLXhj6WIuIV44dIh1K4Ovm7Vd60mVYUYqEXdSfcQyxMYmtcsW8Ya8GeNUyddWDGRc+iySGzQa1eEavxmtAZXOFnDvcmo2qGSNVx6Ud8XXTagcvujBVYaiVnpuKy/AYw3Yr2LF0AIxSc0pSyhGs7S8YPLeN6Jmtt9GU//24aGfsji9RAQEMEXwkjjAG5qrl+vaQEBoWBh2ekQq5Wem0OHfOgewlzNNdUPueLGDIzV9uy3T7U6Obiz9xJvMermPuLenPiHcVV9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDnuhXBntjTIIsPhfZ33ocJtXrkaMF7BDAj4JahmTlo=;
 b=17wttn0zgDKqtUtHtftafrlbxgkZpjjDe3Vu4pRyKBh0VvER6BHqUmku3NUFrhWwhBIXBZ1mjHYxesKBRLpJv85py/jEpOEJtC6rttOEvSMUH39mPgX7FzbFDIWNRpVJ7axtdkabHRC2veeuvSMpOkL/uqC1qGIBCaUvyiLkv1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1537.namprd12.prod.outlook.com (2603:10b6:405:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 07:15:23 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:15:23 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: add reset register trace dump function
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fa8d13a4-ccbe-6e8c-5c97-9c4d7f1134f6@amd.com>
Date: Mon, 24 Jan 2022 08:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <ba6e97b5-17e0-819a-fb2e-5c4515995156@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:206:1::37) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d38d8f1-1465-46b7-c230-08d9df0949bb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1537:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1537D95592EDFE47B671CCAE835E9@BN6PR12MB1537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC0l3VoKGmqPJJar2/tWtC+UWWqhkk6INSOmMlcpzrM4ccvGEk8o55GgWlagKqi3NHQIaEoVzHsfJw6I9LjSYaAHxjuMPtuNtSnABRFLEfUHNHQdBoNShKEQog5EMYT3PN2FZPyJJaS16R45nd2b13wosn73QBYe6MkamNnQrJ/oV3UGbQqLSBz+GwWaeNgrN/ZQzwhVPjcrkIKAOrqUatdpOUrMS/LGc4rgS0qmtWhghWKArF6qsLQ5IyX/KpI3XiTBTV0qk5fkY8a4pML3y2GeMTyzYoHvsNMv34BwL3YfGqTljr2iFwJ64JvmI3tHQCjzMtxex0HkTk+2BGBqwuVf3k8WuIsMM3k5iPqRMaqB/8xFVbEMwfsdnBzfKWxSoDh7GX29buiR3xfRkAuJzBE4s/UUljeFYTq41qc/p5Y2t9tqup7IipAZ2brnglE584yTOjCz785VOUU899QuwAxfugvUfop8WUQ+S/XJJ71z3d1KR4IWP2fB1F2SZOsPaPR87shW29KBNTBB9NnlngWv2shTTsIQHJVRyrGcHkM9b92TPXqq+1uztqLh9RSPg4eTdOKJ3xBwLJnt43m79LRZB9jvwBqv68R4FGveRJgDf1ltV3lSCLGcXd+UvPHxy/fwDI4adJsw2+l8Kwtp++UUTHTSiYwVNi6WgWmuO3DAyh5I+O6q8tRJeanJbnU4L1BaL0xby0Qby8xoWLWSxlmkPPSemTXKGOYf6M7/4SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(83380400001)(6666004)(31686004)(38100700002)(6486002)(53546011)(2906002)(36756003)(4326008)(31696002)(26005)(86362001)(6512007)(8936002)(6506007)(508600001)(186003)(66946007)(2616005)(316002)(54906003)(110136005)(66556008)(66476007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEMzYVAxVStsejBHbjd4ZWZWRUh0UXNiWTZkQWx1MnRGbFV1bHBvQ0RiTHNZ?=
 =?utf-8?B?Rk41b29JY0o4alRUanFsN1lyUXdKMmZacDM1aHRXZ1RTelA0Q0x6OTBFbnVB?=
 =?utf-8?B?cTROWElwM1M5d2NoSG1ubFhYUFpZT0t4anl3UHNNNGlaRStvNXNpNStrZjFn?=
 =?utf-8?B?MDg5ZmdZb3Rhcm5RWWFwaFJOczQ5cmVaVk1Ta2p1Q2xWczM4U2dyVjZqRC9p?=
 =?utf-8?B?NklWNGVNZzBENzYvL1dHMjdhWVJkMnp5R3p5SnFPejJwNzBCL1VwN1B4ME1H?=
 =?utf-8?B?a0x3V2NIbVNsS2lSSHlyZVBEOHpSK0dXemR4SWIvby80Wk9BU2hzb0hjcmtG?=
 =?utf-8?B?dzl0N2gvMklWbU11QXovbkdGZ2UzZHQ1SEhOOEtIUENVOVZhV0s2RVowOFU1?=
 =?utf-8?B?MTBCVVdqNWV6YkJ0SWV2aFVmTVB4NmVpZmFwMDZkY0FSbWZVRzNDZE9hbk1R?=
 =?utf-8?B?Umd0MWU1SzRDZlZqMW0rb3ptWXU3eitLR2JKcTY5dkZLZnNpak1vNWhkUGFO?=
 =?utf-8?B?cllwVnFwV0Z3VDBVMzZSeTRtdktxZXJ1OXV5eUxJM1FIVGJjb0JCTTc1bWlF?=
 =?utf-8?B?S2JwSFBDeTFtbm1UU0tRdnd2cWNjczVTRTFzQUJMcEJvVnc1dVUrTzd6OFkw?=
 =?utf-8?B?cVMvbDArM2JCYlZILzRsNEtSWTExQW5qRXhMYVM2cXlMalRVUUNiOWxLTlhE?=
 =?utf-8?B?ZTNtTHAvRDBSVjFJOVVOL1JZN3QrS0QzYnFKQktYb3Q4RHVrdFRWQ1k4eEV1?=
 =?utf-8?B?STVsRUVuZmdGNzIydktWK0lyQXlLR3JrdklXRFZIYnc3MHlyL1RiZUVaeDZn?=
 =?utf-8?B?dU1rZmgvaTM0TzRLUzlrM2xRVVJYRERHYlh0NDBXRVpZMXVwWktUeEhoaXJi?=
 =?utf-8?B?TG0rUFZpMTF4KytwejhvTFRQVXlwYjJndXF1VnhlNWIwZFBwTXZYNzRRYUdH?=
 =?utf-8?B?RzRqNEVzTHdNUUpkQzAvc21ma25pUEFLUTVPaUhsd3EwbWRhb25HQ3RySHlU?=
 =?utf-8?B?dFpWWnVxTDdGVnJZNU4zczJGWUxKMnExM3FWR1hCQUNlNlJXTjNONHpqRGlM?=
 =?utf-8?B?STNPbERPS21OYzFIY0NnaTlSVGdjcGowVzFZdzNRbVNkWHlNNE80Y2pvcU8x?=
 =?utf-8?B?dEJDL2x4OGhDQzJvZmd0TURBRFNrdHR6MHVtTlA4Zk02azdwOXNleFlBQTg4?=
 =?utf-8?B?SkxRVzJKT2VDN24xUzFmSXR0YTNkQURmMzBLQWR1Zk5kbjhmQXZOVXBBWWRZ?=
 =?utf-8?B?Qk92VC94Vyt2TnNoU3huK1RWY2RoYXZNSjRrSEp1WTVqS1d2WjlmRVdZSk1w?=
 =?utf-8?B?MFBuTGQ5N0VlbkpnUU53SnBIN3BhSHBNWHJCQ25MbnB0WnBFeTdkQ2ZWeTlU?=
 =?utf-8?B?bG5vZjYzeVhRUVk5V1B3ekhMMk9QU3JPSVRNbFVKT29kZXZMb2FuYjYvVzFI?=
 =?utf-8?B?aVo2Q3NseFZBSkhFTXA0dE5OV0RMUTV2WTA0dU0rU2Y5QU9tbWR1WE94ZGcr?=
 =?utf-8?B?NFgyYSs2UnNGUUFsaWdNTFprRDVMaEhYSDE3cFpzUFRCclNTSWhnWjg4MWhY?=
 =?utf-8?B?Z1Q3cUYxUEhnYnpldVo2Q0ZrTjBEcTZ3UVZncEl5emlSUXU3dENKZ0xpU2hi?=
 =?utf-8?B?UWx0RE9TMGhXWjFPYitBUDNFWlRtdkJTMldWT0VERDVrUzBpMFp4aEFSZkNj?=
 =?utf-8?B?Mzl1VDRIZU8wZE1ta2tRQ2h3UCtFenkveWozOEc0T1RhU1lSc2ZZQ2JvdUdC?=
 =?utf-8?B?Q0FoZzBkNVgrRjllekdHcjBnMjhuazUwK2NsS0JoTDB2WnRiQWpxcTZmQ3ZY?=
 =?utf-8?B?dHM5VzhpcmdpN1ZITjAvN25uMXZERVNGMUZwb29sRFRFWlhsOHR0RW1FdERa?=
 =?utf-8?B?L3NreXg3ZW5zUSsvdUJ1dEMzUjhuQXhvZHNxbDhwRG1kYVBxalJRWWNQVUVp?=
 =?utf-8?B?VmNhUG5FYTc5ZlNZTWt5UlBXM2l3RTlLaEw1UjE2ZkZ6T1hPVUwrbU9QQ2E1?=
 =?utf-8?B?aHIwYzJhSDhzek5VaWYzb2xtZTRia1lvRFl1eEZOSzNOU3p2VnFCWXUycldy?=
 =?utf-8?B?MzRHZ1J0TjJPWHVDSm9lRFBNV2xBaVVraDQzeWVzQ1YxK3U4T0FPRkQvelJi?=
 =?utf-8?Q?2BP4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d38d8f1-1465-46b7-c230-08d9df0949bb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:15:23.5939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXj52U6+pdk3B5T/z3+DUTeav3vCDjMiRkZd54544VzMnceb3r5Y1SUmOLYY8J87
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1537
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
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.01.22 um 21:34 schrieb Sharma, Shashank:
> From 1c5c552eeddaffd9fb3e7d45ece1b2b28fccc575 Mon Sep 17 00:00:00 2001
> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Date: Fri, 21 Jan 2022 14:19:10 +0530
> Subject: [PATCH 3/4] drm/amdgpu: add reset register trace dump 
> function for
>  gfx_v10_0
>
> Implementation of register trace dump function on the AMD GPU resets
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  8 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 53 ++++++++++++++++++++++-
>  drivers/gpu/drm/amd/include/amd_shared.h  |  1 +
>  3 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..c97b53b54333 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -537,6 +537,14 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>                __entry->seqno)
>  );
>
> +TRACE_EVENT(gfx_v10_0_reset_reg_dumps,
> +        TP_PROTO(char *reg_dumps),
> +        TP_ARGS(reg_dumps),
> +        TP_STRUCT__entry(__string(dumps, reg_dumps)),
> +        TP_fast_assign(__assign_str(dumps, reg_dumps);),
> +        TP_printk("amdgpu register dump {%s}", __get_str(dumps))
> +);
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 16dbe593cba2..05974ed5416d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -46,7 +46,7 @@
>  #include "v10_structs.h"
>  #include "gfx_v10_0.h"
>  #include "nbio_v2_3.h"
> -
> +#include "amdgpu_trace.h"
>  /*
>   * Navi10 has two graphic rings to share each graphic pipe.
>   * 1. Primary ring
> @@ -188,6 +188,12 @@
>  #define RLCG_ERROR_REPORT_ENABLED(adev) \
>      (amdgpu_sriov_reg_indirect_mmhub(adev) || 
> amdgpu_sriov_reg_indirect_gc(adev))
>
> +#define N_REGS (17)
> +#define DUMP_REG(addr) do {                    \
> +        (dump)[i][0] = (addr);                \
> +        (dump)[i++][1] =  RREG32_SOC15_IP(GC, addr);    \
> +    } while (0)

Those macros need an AMDGPU_ prefix and maybe some better names.

 From the design POV I'm really wondering if it wouldn't be better if 
userspace defines the registers we want to dump in case of a crash.

Regards,
Christian.

> +
>  MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
>  MODULE_FIRMWARE("amdgpu/navi10_me.bin");
> @@ -7488,7 +7494,6 @@ static int gfx_v10_0_hw_init(void *handle)
>  {
>      int r;
>      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>      if (!amdgpu_emu_mode)
>          gfx_v10_0_init_golden_registers(adev);
>
> @@ -7602,6 +7607,49 @@ static int gfx_v10_0_hw_fini(void *handle)
>      return 0;
>  }
>
> +static int gfx_v10_0_reset_reg_dumps(void *handle)
> +{
> +    struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +    uint32_t i = 0;
> +    uint32_t (*dump)[2], n_regs = 0;
> +    char *reg_dumps;
> +
> +    dump = kmalloc(N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
> +    reg_dumps = kmalloc(1024, GFP_KERNEL);
> +
> +    if (dump == NULL || reg_dumps == NULL)
> +        return -ENOMEM;
> +
> +    DUMP_REG(mmGRBM_STATUS2);
> +    DUMP_REG(mmGRBM_STATUS_SE0);
> +    DUMP_REG(mmGRBM_STATUS_SE1);
> +    DUMP_REG(mmGRBM_STATUS_SE2);
> +    DUMP_REG(mmGRBM_STATUS_SE3);
> +    DUMP_REG(mmSDMA0_STATUS_REG);
> +    DUMP_REG(mmSDMA1_STATUS_REG);
> +    DUMP_REG(mmCP_STAT);
> +    DUMP_REG(mmCP_STALLED_STAT1);
> +    DUMP_REG(mmCP_STALLED_STAT1);
> +    DUMP_REG(mmCP_STALLED_STAT3);
> +    DUMP_REG(mmCP_CPC_STATUS);
> +    DUMP_REG(mmCP_CPC_BUSY_STAT);
> +    DUMP_REG(mmCP_CPC_STALLED_STAT1);
> +    DUMP_REG(mmCP_CPF_STATUS);
> +    DUMP_REG(mmCP_CPF_BUSY_STAT);
> +    DUMP_REG(mmCP_CPF_STALLED_STAT1);
> +
> +    n_regs = i;
> +
> +    for (i = 0; i < n_regs; i++)
> +        sprintf(reg_dumps + strlen(reg_dumps), "%08x: %08x, ", 
> dump[i][0], dump[i][1]);
> +
> +    trace_gfx_v10_0_reset_reg_dumps(reg_dumps);
> +    kfree(dump);
> +    kfree(reg_dumps);
> +
> +    return 0;
> +}
> +
>  static int gfx_v10_0_suspend(void *handle)
>  {
>      return gfx_v10_0_hw_fini(handle);
> @@ -9367,6 +9415,7 @@ static const struct amd_ip_funcs 
> gfx_v10_0_ip_funcs = {
>      .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>      .set_powergating_state = gfx_v10_0_set_powergating_state,
>      .get_clockgating_state = gfx_v10_0_get_clockgating_state,
> +    .reset_reg_dumps = gfx_v10_0_reset_reg_dumps,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h 
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index 257f280d3d53..76d3a55278df 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -296,6 +296,7 @@ struct amd_ip_funcs {
>                       enum amd_powergating_state state);
>      void (*get_clockgating_state)(void *handle, u32 *flags);
>      int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level 
> *level);
> +    int (*reset_reg_dumps)(void *handle);
>  };
>
>

