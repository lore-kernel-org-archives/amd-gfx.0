Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6616C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 09:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77F6EA0A;
	Tue, 30 Nov 2021 09:58:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905826EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 09:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsdAplCFLwbJjswiQHceeGUjdcoMN3KbPYMCOLiXWSrsga2gSrObnhWzEVkK9NhnxOmLptk3cEKpwQLLDBjJBWvzV4M657TIQX6urrlGXX8yK0YUwMgF6/7lxBoR0z/jiukPU9gCmlXQNGNE2Yq35kqwCKnyZP8LnDc+Kr1My963PubDhHxeHMdWacDcFHPUfwMkCW2EJistSIn4coPb1MvIk9vsXGEyOlX1N82dgypv6/3LjcNvg2y1VKEc9h6cMLq2VorWeZfU0W5PJzV/kUURakCND3qor/kNqkHYYrlmFqnUbA/4BAVqw7IceIce9T0Q7wgGo/cIbnRiw1atVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=727WECh6BU4cC3di2lFhVKJ6skc+v/1REZ0YG9RxaR8=;
 b=Z1PvZuF5F+6KA6pdL8Z+7lgaOT3CUBJSe2dx9r4jOwEfzjSqj1Rnb6M2hf2jSrsYpn5c/QbqzDu9VpHZSnythIKcMSOLE7jkSj0V+rfiYlF5rNB3yXaonQOpt1QX4VF0h8cHviCL74TYYbSvopiDDHIcQbrbg5EupNNS6OH0DRx64YSOwCYH1kiRAncPA0EQO0tITw8DB2avwY8DOkGxXBMuaSA+4YgO8vZLzbY6O+t+OPnHTfqObBNB0+/5aHb6F7JH9jS84Eu7A7pK+IDktrhURfOykru90XW2f0FVrEjKNM1VGzd9NXf1n6iz1aBMtF8EwN/ZA2H+tLp0lrO6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=727WECh6BU4cC3di2lFhVKJ6skc+v/1REZ0YG9RxaR8=;
 b=2mfIFSaHsV3I7yuyVM0IinT2VrP79HzGJCK/T6rXiLtgBy19M/wS85kkYbKISCuiKlBThCOv7qdNE4u3TIuC5mmBmOyJTlV7dXhkqpYX13VGHJ91LtTmZBr1klShCZPx+Y6F7vumsQE+QLUD4cBMlhJziuT8guRMharMyGpcGM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0080.namprd12.prod.outlook.com
 (2603:10b6:301:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:58:55 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Tue, 30 Nov 2021
 09:58:54 +0000
Subject: Re: [PATCH V2 00/17] Unified entry point for other blocks to interact
 with power
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e2712a6d-0c42-eb00-2352-93f1f5501d90@amd.com>
Date: Tue, 30 Nov 2021 10:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::26) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:fa20:e17b:e063:b6d3]
 (2a02:908:1252:fb60:fa20:e17b:e063:b6d3) by
 AS8PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:20b:310::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 09:58:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9880f8d-98ca-4790-8063-08d9b3e804d7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0080:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0080B0EA8528AA65069CF17C83679@MWHPR1201MB0080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGyZD9Y3A7xstUsIYCslQa2mKZRrQe2q5BO/EPltCXh3K7mv5ok4JyvjtAXZGpXhcyZAwolBKIoi7bhZ0kJlRv3tjLdnaG1GfaQZqORR/Idpe5PL8D1voAIUN+Ge9id80frzluAQQBwgB3kTIfqWyuJ1QNwUGPzy+P6GNYkc2q7hruWgsJvPTROACSGzmPPiWQObu03YaYbCQrp1CP8rgLouf8+bs+Mo4n/dl6EKMZr6ZUXWw9uqr8+01kfGQzO+h7ag1bHqqfFwlmVDlJiQ4YkT/70U0oB1HVxj+FxcqScgQMDGNe2iYeSnfDjcWYflvBc5WOaODXXoktuZgx0tRbuL2vzgrGEiEgentQXcR72bQTE5Lh6UidKYyod962X2uXjxOmpkpqwxftMH+Kwem/XQ4nzsFyp75/PqlCyOasxfT4EwXNAVVroizU+TvJ/rCk6RnvAmYhL9reBi+fPUCOpApukDyanlvrRycQOjyS9cshqymUWhrX2AUw9w1WavQX9bNHgEfbu5pae3JhVaIPegMGHyFIwX2cVG4z9m1WhZD0hUD7AHtI9D1ljYyxMAIz69byeFejMprBgfMsJpFKawrV3/oT5fu2eReVJkBIIREIQCjnkTut/a2w85o6k5MLh64i+UMxezytPCCvL8NdanANuCMEBJL5FlkdTFL0ryur36cJDx+Y+RwE+DIkkOSmped1mCDK3lc7jC+v/fRafXIpt1pceeCez6S7Eyq/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(508600001)(30864003)(36756003)(2616005)(86362001)(6486002)(83380400001)(316002)(66946007)(4326008)(31696002)(66556008)(66476007)(6666004)(2906002)(38100700002)(8676002)(5660300002)(8936002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pYUXFNOVRlVWxVY1JReUdDYjRJYlVoMXN6SUszRzkySmJmZWdpSWlZVEFz?=
 =?utf-8?B?S01MbHZSOGh2VUhmQnl6NFVySzBRT1VYQ2NiYmNCbmRUYWg4WVA2NVBBRzBv?=
 =?utf-8?B?L1N6ek9DVFBpelpIaUhpVTNRRDR1M3pyYXVMOERVSHB6bmtEdVg5alp6RFQ0?=
 =?utf-8?B?OGtaSVN3dVVjUy9sUVZIZVFyVGNzSFQ3RTdxdWRQSXhNVlV2eU5xRXcyTENk?=
 =?utf-8?B?dUlQUkVkVTBCTVJhdnlidEw1SHYzUyt5NnU4aWFMbkkvSWhZcUhOMUtTYitZ?=
 =?utf-8?B?NHBvN01zR3dLOFNKMXphenRnTE4vdUdQNzB0clhjY1pKMDY4a2pkQmxhY2pu?=
 =?utf-8?B?S0tvaEoybzFScXhFbjF1aEt2aDBxOG9WZVBKbXlSZ2xaM21pdURHUE51aEw1?=
 =?utf-8?B?YjVwMGxsMm5GSTRRcnVLcGVWUWZsYlVhdDBzZlhUUExVQjRHcEs1bnZpaFda?=
 =?utf-8?B?aFl1WDNtMHJMQXAxcWJFUWlmNFVTbVBsdlQ4eFZiZFNNN3dHN25Qb0ErdEVR?=
 =?utf-8?B?dk00MnNSZitNbFBpMlN6K2s5cTAwdVJ2QVAxQVNTVjZmWUcraWVGZTB2REJa?=
 =?utf-8?B?aEVYdHN3ZmE5U1lmY1lRWk9aclVZZ1k0K1d5OFBTOUMvYXA3aVNGZjdrTThD?=
 =?utf-8?B?NC9ObmpUa25laHNGUXFsUnZ6TG1vc3JrdCtCSHJocnJqMWxoOFF6TnY5RllL?=
 =?utf-8?B?ZEwxcFQzUVlMMFdCQTE5UEhleHZEVXVGNzdIc3JWUFpEb09UYUhENmNPVzEr?=
 =?utf-8?B?K3hQNzFEYjJNbXUzMlFOY3JqWFBSTlJ3NVlSVHpSSGk4WjRxZU5nUWhhMGhK?=
 =?utf-8?B?cGRpdnVqbG9mdzhMeEJ1cTVPVWNSMzh2SlpEekc5YldiODlJUXNCS1VKc2hO?=
 =?utf-8?B?WGtKSU9lMW03TG5TRDV2eEJndUlONkVBV2VGU200WlFXUTRPeE1FMGR4a3Jh?=
 =?utf-8?B?SHRCSEd0OUh1RXkrbHFheXZBZFBORG5QTDFiSlI4amJSSVFCMlVyTDRtUjFE?=
 =?utf-8?B?dzFReDkxU3ltc1gwSE9uTm15THNIeDZnMlVNcmx4V2hVUUM3T3hRTS9FMFRt?=
 =?utf-8?B?enY1NzlhSUdWZzl0Z0xUdjVXQ0hHWGpiV2NSSFBjYzJPRGhUMzhTWmxzaHJs?=
 =?utf-8?B?bHpGNTl6aGRkYUUyRDAzUzhOL090VlhndTBBc1dZbVFIcmsxTnh6OUNCM2d0?=
 =?utf-8?B?RlJPbFJpbXJHa0F4UUlFYmFFcEdRd3plQkpKMHJKYkJLdnE4WlgrVVRzdzg4?=
 =?utf-8?B?TXpGUWQ0TWVtc3hNY0YzR3dnR2NscEE3Y3FxNmtOanc0cVRsenlUOVRoazQx?=
 =?utf-8?B?cG1lSUI2emx4emc5RDBwQTRTaG8xMUpQUE9Qc2JrSm9sOWVMMCsrSGVMMWFG?=
 =?utf-8?B?WHFsUDVDZWErWVpFd3lVK24vK1NrZndvdDdoUXRsTm9LWkVsMWc0cHRWU3Bi?=
 =?utf-8?B?TFExY2hXNWJvMHFnUkpTWVNmUmozUUVYTktjclRiZkl1a1lNY1orVWJ4b1VD?=
 =?utf-8?B?UExFbzdDZEovenpyRUEvZHZ5dlJKSkhVWFhuUy9ZWTQzM3oxWUlKL1lXK3pL?=
 =?utf-8?B?VUhzVEFHaG11RFpRM3grR1RZOGZ6Unljb3VkTzJJN2NOcmpINnI2UmtyRUJR?=
 =?utf-8?B?eHJxWnhhVUk3Y3N5MHBZclRwTWxSMm8rcnBnQlhaaWROdTNJb1VUU3RET1pW?=
 =?utf-8?B?UmhWclp6WHpZcEpUYjFXOGY2V3lxaWMrTEFZTkRCb3ZCWUlWVC9OTml0WWJj?=
 =?utf-8?B?U1ZmOEl6UENLNnBiTng4QUxoeXlJS25TT1M5MVNVek84NnIyUzk3S3Y3SVJv?=
 =?utf-8?B?SzV4M1BpRE5Ma3RnbVVncUc4WGZWVzY4aDZTZHdlL2ZST0RucHFLUnFRU3c3?=
 =?utf-8?B?K2dqbmttZHM2ZDNLMFRWa3VYRmUrZWdSanFidmpxSm5HZVJFNXdVcDlBZS9P?=
 =?utf-8?B?L1oySkRURjNjOUFOWTJBUG1ma1hGV01wbU9STzRUQjd4bTFNY01rck83dEZo?=
 =?utf-8?B?VGxDSTZzRFY5NmJsZ1JVZDkyS0RWeGFEZllPTDN1Tmx5WTZ4OWw5bkNRcWtO?=
 =?utf-8?B?K1gyS0VhKzlKVU9XVGZJdFBtakk0SjlnVlFkQzFYUlAxY3BDNkZGSWRsSUhq?=
 =?utf-8?B?YU9HYXFBMnA5U29HNjllYldjajF2SHMrTlJRd0RkY1J5cmFxTklEa0M5OWF3?=
 =?utf-8?Q?3kGNza7HlhuI1pKEG8XMxC8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9880f8d-98ca-4790-8063-08d9b3e804d7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:58:54.7541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7CIl4HlTADODYgo+ngCplrJuiNJIwrQfYExB2QW9FxB9bmvidVP3jsHgutPLZ0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0080
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.11.21 um 08:42 schrieb Evan Quan:
> There are several problems with current power implementations:
> 1. Too many internal details are exposed to other blocks. Thus to interact with
>     power, they need to know which power framework is used(powerplay vs swsmu)
>     or even whether some API is implemented.
> 2. A lot of cross callings exist which make it hard to get a whole picture of
>     the code hierarchy. And that makes any code change/increment error-prone.
> 3. Many different types of lock are used. It is calculated there is totally
>     13 different locks are used within power. Some of them are even designed for
>     the same purpose.
>
> To ease the problems above, this patch series try to
> 1. provide unified entry point for other blocks to interact with power.
> 2. relocate some source code piece/headers to avoid cross callings.
> 3. enforce a unified lock protection on those entry point APIs above.
>     That makes the future optimization for unnecessary power locks possible.

I only skimmed over it, but that looks really good on first glance.

But you need to have Alex take a look as well since I only have a very 
high level understanding of power management.

Regards,
Christian.

>
> Evan Quan (17):
>    drm/amd/pm: do not expose implementation details to other blocks out
>      of power
>    drm/amd/pm: do not expose power implementation details to amdgpu_pm.c
>    drm/amd/pm: do not expose power implementation details to display
>    drm/amd/pm: do not expose those APIs used internally only in
>      amdgpu_dpm.c
>    drm/amd/pm: do not expose those APIs used internally only in si_dpm.c
>    drm/amd/pm: do not expose the API used internally only in kv_dpm.c
>    drm/amd/pm: create a new holder for those APIs used only by legacy
>      ASICs(si/kv)
>    drm/amd/pm: move pp_force_state_enabled member to amdgpu_pm structure
>    drm/amd/pm: optimize the amdgpu_pm_compute_clocks() implementations
>    drm/amd/pm: move those code piece used by Stoney only to smu8_hwmgr.c
>    drm/amd/pm: correct the usage for amdgpu_dpm_dispatch_task()
>    drm/amd/pm: drop redundant or unused APIs and data structures
>    drm/amd/pm: do not expose the smu_context structure used internally in
>      power
>    drm/amd/pm: relocate the power related headers
>    drm/amd/pm: drop unnecessary gfxoff controls
>    drm/amd/pm: revise the performance level setting APIs
>    drm/amd/pm: unified lock protections in amdgpu_dpm.c
>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |    2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    7 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |  421 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h  |   30 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   25 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   18 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |    7 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |    5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |    2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
>   .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  246 +-
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |   14 +
>   drivers/gpu/drm/amd/pm/Makefile               |   12 +-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 2435 ++++++++---------
>   drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  |   94 +
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  568 ++--
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  339 +--
>   .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |   32 +
>   drivers/gpu/drm/amd/pm/legacy-dpm/Makefile    |   32 +
>   .../pm/{powerplay => legacy-dpm}/cik_dpm.h    |    0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.c |   47 +-
>   .../amd/pm/{powerplay => legacy-dpm}/kv_dpm.h |    0
>   .../amd/pm/{powerplay => legacy-dpm}/kv_smc.c |    0
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 1510 ++++++++++
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h    |   71 +
>   .../amd/pm/{powerplay => legacy-dpm}/ppsmc.h  |    0
>   .../pm/{powerplay => legacy-dpm}/r600_dpm.h   |    0
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.c |  111 +-
>   .../amd/pm/{powerplay => legacy-dpm}/si_dpm.h |    7 +
>   .../amd/pm/{powerplay => legacy-dpm}/si_smc.c |    0
>   .../{powerplay => legacy-dpm}/sislands_smc.h  |    0
>   drivers/gpu/drm/amd/pm/powerplay/Makefile     |    4 -
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   51 +-
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   10 +-
>   .../pm/{ => powerplay}/inc/amd_powerplay.h    |    0
>   .../drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h |    0
>   .../amd/pm/{ => powerplay}/inc/fiji_ppsmc.h   |    0
>   .../pm/{ => powerplay}/inc/hardwaremanager.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/hwmgr.h    |    3 -
>   .../{ => powerplay}/inc/polaris10_pwrvirus.h  |    0
>   .../amd/pm/{ => powerplay}/inc/power_state.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/pp_debug.h |    0
>   .../amd/pm/{ => powerplay}/inc/pp_endian.h    |    0
>   .../amd/pm/{ => powerplay}/inc/pp_thermal.h   |    0
>   .../amd/pm/{ => powerplay}/inc/ppinterrupt.h  |    0
>   .../drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu10.h    |    0
>   .../pm/{ => powerplay}/inc/smu10_driver_if.h  |    0
>   .../pm/{ => powerplay}/inc/smu11_driver_if.h  |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu71.h    |    0
>   .../pm/{ => powerplay}/inc/smu71_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu72.h    |    0
>   .../pm/{ => powerplay}/inc/smu72_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu73.h    |    0
>   .../pm/{ => powerplay}/inc/smu73_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu74.h    |    0
>   .../pm/{ => powerplay}/inc/smu74_discrete.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smu75.h    |    0
>   .../pm/{ => powerplay}/inc/smu75_discrete.h   |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_common.h  |    0
>   .../pm/{ => powerplay}/inc/smu7_discrete.h    |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_fusion.h  |    0
>   .../amd/pm/{ => powerplay}/inc/smu7_ppsmc.h   |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h |    0
>   .../amd/pm/{ => powerplay}/inc/smu8_fusion.h  |    0
>   .../gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h |    0
>   .../pm/{ => powerplay}/inc/smu9_driver_if.h   |    0
>   .../{ => powerplay}/inc/smu_ucode_xfer_cz.h   |    0
>   .../{ => powerplay}/inc/smu_ucode_xfer_vi.h   |    0
>   .../drm/amd/pm/{ => powerplay}/inc/smumgr.h   |    0
>   .../amd/pm/{ => powerplay}/inc/tonga_ppsmc.h  |    0
>   .../amd/pm/{ => powerplay}/inc/vega10_ppsmc.h |    0
>   .../inc/vega12/smu9_driver_if.h               |    0
>   .../amd/pm/{ => powerplay}/inc/vega12_ppsmc.h |    0
>   .../amd/pm/{ => powerplay}/inc/vega20_ppsmc.h |    0
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   95 +-
>   .../amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h  |    0
>   .../drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h   |   20 +-
>   .../amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h   |    0
>   .../inc/smu11_driver_if_arcturus.h            |    0
>   .../inc/smu11_driver_if_cyan_skillfish.h      |    0
>   .../{ => swsmu}/inc/smu11_driver_if_navi10.h  |    0
>   .../inc/smu11_driver_if_sienna_cichlid.h      |    0
>   .../{ => swsmu}/inc/smu11_driver_if_vangogh.h |    0
>   .../amd/pm/{ => swsmu}/inc/smu12_driver_if.h  |    0
>   .../inc/smu13_driver_if_aldebaran.h           |    0
>   .../inc/smu13_driver_if_yellow_carp.h         |    0
>   .../pm/{ => swsmu}/inc/smu_11_0_cdr_table.h   |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_types.h    |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h    |    0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h    |    0
>   .../pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h  |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h  |    0
>   .../pm/{ => swsmu}/inc/smu_v11_0_pptable.h    |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h   |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h  |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h   |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h  |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h    |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h  |    0
>   .../drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h    |    0
>   .../amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h |    0
>   .../pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h    |    0
>   .../pm/{ => swsmu}/inc/smu_v13_0_pptable.h    |    0
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   10 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    9 +-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   34 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   11 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   10 +-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   15 +-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |    4 +
>   114 files changed, 3657 insertions(+), 2671 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
>   create mode 100644 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/Makefile
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/cik_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.c (99%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/kv_smc.c (100%)
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>   create mode 100644 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.h
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/r600_dpm.h (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.c (99%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_dpm.h (99%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/si_smc.c (100%)
>   rename drivers/gpu/drm/amd/pm/{powerplay => legacy-dpm}/sislands_smc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/amd_powerplay.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/cz_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/fiji_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hardwaremanager.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/hwmgr.h (99%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/polaris10_pwrvirus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/power_state.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_debug.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_endian.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/pp_thermal.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/ppinterrupt.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/rv_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu10_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu11_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu71_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu72_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu73_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu74_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu75_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_common.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_discrete.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu8_fusion.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_cz.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smu_ucode_xfer_vi.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/smumgr.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/tonga_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega10_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12/smu9_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega12_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => powerplay}/inc/vega20_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/aldebaran_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/amdgpu_smu.h (98%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/arcturus_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_arcturus.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_cyan_skillfish.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_navi10.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_sienna_cichlid.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu11_driver_if_vangogh.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu12_driver_if.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_aldebaran.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu13_driver_if_yellow_carp.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_11_0_cdr_table.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_types.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_7_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_0_pptable.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_5_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v11_8_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v12_0_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_pmfw.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_1_ppsmc.h (100%)
>   rename drivers/gpu/drm/amd/pm/{ => swsmu}/inc/smu_v13_0_pptable.h (100%)
>

