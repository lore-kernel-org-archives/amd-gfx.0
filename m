Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA766C35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 12:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F49C10E0A5;
	Thu, 21 Dec 2023 12:56:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D164110E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 12:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQQ8eT99SowBCQv+6xKFZQ9ypLpuJAetmHHmVwi/zgeAkpyOpU1BGyWDdeIhLboW4lNlr+ZQPPPFEJ2ZB2jHtF19DOcDxT26PjHEGMJk2XpebehAcptjt15AsVSGoSUcfkIiFbcLexrgvDc+zs4eqbnDYKcE2CnvUBvaQ0sZKtWqj8LYtJ+64NkxRcQS33ZKFkEEZbLg1hi6kGK/jXUh2zd21KjqTf2A4BevCooFD+kQDHS52HBPgvS4/JoLa1aj1GXU9Ityn/qbAyl0uX4qAknxJAUN1OUTi65tz9D5wNFEojF8YQkds9bMsX5Ja9b4RuZFa3vqYtDlcc9O6kN4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS+wDuVFVVK540xqrD6oasmUcuaFe68I2243T6eSZgc=;
 b=FYcgYzoTEK0yR+DTqQyPqjA5uc/hPhUU8LpuYuw+UB+PdINVz43V/9IsVaePyD4ylrbp4cHScIw7Q5uNISb0Aug35BEo3xQG62AB/89YdMAD21hF7MKfHP0tdpqNkjtbsa/FZ932ILsCFKpJI34tX67ROGQgO+wL98eoXplnX8+M7BL5r1Ch+n/OnskR6sYuWdJUDQRNJIZwNd2L7zcO80qB3Fyg7tOvHled2hhPZmwtsX6boF8kubpeTg4N//tGHa3LTFPBKXf+nLU0JUkdOoOZ4nv89owb+5o6VGWz3FzCNvrMiUHSwiqgJzgcWq1KbJACLSFJEm+Xyu7bo1JBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS+wDuVFVVK540xqrD6oasmUcuaFe68I2243T6eSZgc=;
 b=TTfWPVzmfvPiYY1IdTd7A9y4fHJUBfVuC1/7EBbUHE+rIV0m5WyvBS4D4e0Uh1LSGeo+/fj/AKc23luWG9Jb+3nFb2EXVgK9SOvMPyA9qeIy/mIv2DQkHSIYTNXMSwAWYL/TsjdYJ49snJyME3ADDrISu/M3wauCVYICXKnKutg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 12:56:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 12:56:19 +0000
Message-ID: <725f864c-d53d-4839-9326-99e323638c3a@amd.com>
Date: Thu, 21 Dec 2023 18:26:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Use logical AND operator (&&) instead of
 bitwise AND (&) with a bool operand
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20231221024239.1150518-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231221024239.1150518-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: f17d73c8-11cd-4377-ef4a-08dc022438f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iYwztKIv/krkJ4vygxhwzfJx9BVdIUj4nL3rBzjfmoRCKC5rZ4xXTYeY83Zx5jwh3HoR5LP8SU5+Uc9h1TYT9N4jfJHJAhb/HoUpXs1USy23tsYU9sj55AvkumewK1Uzyq0CpWs3JsdekboHVkdrMfAU1tNTcYlsJNcUdX5gz8MTP2CZWdIHQpEUwvzJu8oW1JmPSjRDHfxRqJmS6cu7sqPZQ9Kv4tbAVdIr71Rjp134+dKt25oWdDlz2V3Kg+25pyLmE9LgKL6Isti/8W5KnMMOreuUgOJ+AgULJtK7OiLGEBWKd1eKv/zZeiWc6XWVSzEJ4ps4LMs4/ZtGh+vgTiu8TF4mO2C/AkPMk8DrPo6eEIpNKXtUx53oMtJU2SOVQ0mArHBHTlirtqCXdo//ZfsEom0EzBkz+rlA/6yBmFytCI+GCvvvlwaP7ErhwX8i3Mbi2fGzjxjsVNVy0IUVjh49fiB+ZKQRhXQ8FWmtYxrFSf46BkHeq0cKUYkC6ONNzFmZRHSyl+yB0vASpWHq6Vt9pJQJx5UyoHDKyFdQix/gdz6Zq93JAd6mpsQfB0KOepb+h83NQtcVOnLsx5/BiM6BQTV9FNqfThdzZXaih2qxuVio0fkIoluW5Glf8428wEqgBGtZ1ZB2qe80chLzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(2906002)(86362001)(31696002)(41300700001)(38100700002)(66556008)(110136005)(66946007)(2616005)(66476007)(26005)(6636002)(66574015)(316002)(6666004)(53546011)(6512007)(6506007)(36756003)(6486002)(31686004)(478600001)(8936002)(83380400001)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhzZHBmSXNUZUtDWFYvTjY0Uzh1bC83RGJUNmNRY295cDUzNlhqR2xkcUhh?=
 =?utf-8?B?REUwTThCZSt4NmRYQXVkVnRpVHdEaXQ3L1NpcWdFcXA3VSs1a2dPUDl4TDZh?=
 =?utf-8?B?Qnd3UXRLR0F6bjRXczBvTllTN0M5eExhYk1HK2E3SnJ2R1QvT2FwNUpoRW11?=
 =?utf-8?B?OHBNaW1ndTlrMUJRdjVtUFZjazU1dStDdms2RDNpMEkzTlF1RmQrdkxHR2ZT?=
 =?utf-8?B?U3JUOUZkdzArM2MvanRBaWJMWSszS0NOWEZhMWNteXcyWXVzb1RpOXpXbEJZ?=
 =?utf-8?B?czZQRDRjMHNVVTRxeDFxK1U3YUkvWEcxVUd3ZGpFTDVhd3hiV3lWODhXYm9x?=
 =?utf-8?B?SFU3WGRCbjQ0NUYxcVZMdy9CNHJNQnI1NFdteUpkOTFkRCtSdzhQRHRFUDJJ?=
 =?utf-8?B?YUExb3cxcENkYU1hdUFYSVVWaHBNL0RzU0NPWkF3QkN2R2plY0s0ZWREQzhN?=
 =?utf-8?B?VVF0VHZob0JId1NXb2hvMVEzMjkzNEUvN0FwcG9rY3NJNHFWQkthd3puRVVV?=
 =?utf-8?B?d0hPUUJDS0lVTFlodzM3R09NNEg1bXF3ZE1TMlZ6VkhtOGNJWW1iWm5sT1lU?=
 =?utf-8?B?VFVCUG1FaG8vUEFXQkpxRUx3alZ0YVpQOGV2RFd6S1Y2SGxqWHhyWVdzcjk2?=
 =?utf-8?B?VnMrU1Y4THR4a3dtcTI2dmJNeXVLOENzNXdia0pjV20xcFg1WDFtYzZZMnlC?=
 =?utf-8?B?a2pkWTFCeWloNnRmc25lUHY3VkJDS0E2aUVVUFg5dFpFUVRadmd1N21kYlFX?=
 =?utf-8?B?WlJzZnczb0NUY1QwUzdZbFBnL09JUFNsNGxIUmVYN3lDcUJzLzBPRUdDQURq?=
 =?utf-8?B?Q1ZOOHNDZE5xS1c3R1VSTlJTZ29mQThaOFVNM3ZWMTY4dERZcm5zZWtESXMv?=
 =?utf-8?B?eDU2VlVhN1FpTm1TL0xmU1UxVkxVWGN6OWVWU3lSaTJ1dGN3K1RnNktLRDRF?=
 =?utf-8?B?NHdQTHF5YzlhcWFSZ25UMjdhMVN6UGRWWUVtNVhsMXVKUUlLVGxVd0ZyVUYz?=
 =?utf-8?B?cXJpYTlHaC83V0Zvb3BGYXY0SVFXQ2pHZW1TSGRvSjVZZDJJbm42NSs3NHMz?=
 =?utf-8?B?eTBMRmlLZmp2Y3hqUlROWThwcmZuTlRmdlRjVk5qT3g1TFlDc21TdW1WNitX?=
 =?utf-8?B?UGxPVFlmelh0RXdKTkZUbmlQMExCbEtnREVBQllKRGU0SmpNMUg0Vi9meFh0?=
 =?utf-8?B?SngreHVlbS9wN1p3NEVZTklxZUlPT0hLaXNTZEhFUUlYU3VZMWFRZ1FVamEv?=
 =?utf-8?B?NzRRN1VMWjJrZWtnV3h5SzEvQXpPUHNWTmsza01NTWdaTGpHd292VlFNNUVH?=
 =?utf-8?B?eDIvaHdEVlYxNkJXWU5oSStudG9YMHpMNzJkOEhzaVRyS3pOOE5DRjM2OUNP?=
 =?utf-8?B?WXlHS1NIcFg1ZTBmUVhhb1NlSWFyY2Rtb1lEMjdWUlFCbUJlQjdXTzBaMFAy?=
 =?utf-8?B?QzNRc2Y0dmx1RWRjU3pFU1BVV1lRcnA1RjNWcFdGaGtVVEREZi9lRlZ4MGdk?=
 =?utf-8?B?Y0piVTVpU1pMREI5cW9hOHh5UjFPQ0NOa1oxZEpxaWZrZ3gvUW9XcFcwSGtk?=
 =?utf-8?B?eVZBZ1hWRzZ6emtsUWxNNHZUUytoWkIzYnd3SG9pNVpDTjNwZ0ZxWEorSXZv?=
 =?utf-8?B?d1VnaVI3ZmZRNUR4K2EzZ05qMkMxcTQya2xIQ09RY21QSWw0R1dGM2VpNnVw?=
 =?utf-8?B?U3hUallPTU5rMzJERGpRVnBkT2J5Z29maEtQT0l1VmsxaEd0Uzh3b2ZqTHMv?=
 =?utf-8?B?N3ZwUWtwWGs2aUdVcm0vN2NIVjJjQXVPdlNueFdxMi9FdU90bVpTVHhaT2Q3?=
 =?utf-8?B?Q2x2aTB1Yk1qcWk3OUVjTHZGWVYvRjZxcVlWL01RdngrM1czbi9odHZRTkNT?=
 =?utf-8?B?SkJQbHZ3RlpDRW8wNXEzUFpUU0p2UlVRWllVZDdXeXJnR1h0bnpqODZ2WGR3?=
 =?utf-8?B?M2pxeUN6STVuQTc5TStDV1NHNk91RW9USmVIK2JlakFwOHlzd1hQdGVaZ1N3?=
 =?utf-8?B?M1YwN2RLNUg5OGJXLzVSQVNmYml6ZlQzelRRNUVnT1lKWklHNXZTbHp2S2Z3?=
 =?utf-8?B?MEo4SE02V2ZlQ0RkRzFMTjlYSGNwbFlTNEJuR0NQZ3l1RVpBN3lEaU9BN0NK?=
 =?utf-8?Q?vJZP6F+zWZOVkSKzjFXPyjALe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d73c8-11cd-4377-ef4a-08dc022438f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:56:18.5273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2+zJsDgOBvZlIs86fqdWwjLTVnxJx+alHDirg3eU5Qc1w9dMuQ7o63W1z+0gVZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/21/2023 8:12 AM, Srinivasan Shanmugam wrote:
> Doing a bitwise AND between a bool and an int is generally not a good
> idea.  The bool will be promoted to an int with value 0 or 1, the int is
> generally regarded as true with a non-zero value, thus ANDing them using
> bitwise has the potential to yield an undesired result.
> 
> Thus fixes the below:
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 pm_map_process_aldebaran() warn: maybe use && instead of &
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 8ee2bedd301a..da83deee45a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -114,7 +114,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>   			packet->tcp_watch_cntl[i] = pdd->watch_points[i];
>   
>   		packet->bitfields2.single_memops =
> -				!!(pdd->process->dbg_flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP);
> +				!!(pdd->process->dbg_flags && KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP);

Logical AND of bool with a known constant doesn't make sense. dbg_flags 
looks to be defined in the wrong way; to process multiple debug flag 
options, better to define as u32.

Thanks,
Lijo

>   	}
>   
>   	packet->sh_mem_config = qpd->sh_mem_config;


