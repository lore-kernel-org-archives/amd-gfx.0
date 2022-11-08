Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43A5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B0210E290;
	Tue,  8 Nov 2022 13:59:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C257D10E290
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 13:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZukM9Zm/gC/n9RgIeAKqhHtniOiSBlkYXGpVS+c5argNv0vK3lA4Gm6Zmz2we4aawAKRXWuZfxM/9VawicaIOhU+jyGFtP/T7rzl/WVZmHbxxvur1MW3L/f54r6XNAY6s3TEsuTgLjgkCZhG8vBhrPV75w9wlFuznYdwHpJvK5UXm2OqmkD+GCtaognEGIrvh1kddla9KA12fsIofleaaXwPurLPI5kDaoMvyuOX3mSwyQhX060ff/r1xejrHFE/t6KCuxpCEJkYc2Zo2g7zIVUKlKgnGfPTpJeivYLNaCq1qBsGtvNwVKQV4+agQJP1QmV00W0xVrdOPKWqRIFhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OlD9mWzKdag8HCYZSWGK7qzN0thZMktCMH5YeNID9I=;
 b=W2jtIfjDrBwliOaTlC0x00/Fve3FfHJJ2mbbkP+y1C4a6tLuIcW+vlqqBYT9rUdkzeTDK9yrVf+5bMi90WWPSN14KbogCCS1zSdYuJXzw7a96NXg9M5FgdNucOo5kgLWFwL8EWATRExGU92Vxcq1vjv+MetrLZ7HQJ7yz2k0RC0ba0N4G138bSO9vWNImJHbSLYMEALbQ6m7D/ZP1ks8kUNVWk05ClVnGk2vkx3GfKeRqmG5+InJc8XHZm698fwSGwUZrhel05RoUxnus6/LJvP37VofCpHFMYeBcmXyiMoweHtP+ifoa/t38R0OYbSqGEbCNqhSrNC22mrQgY8aUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OlD9mWzKdag8HCYZSWGK7qzN0thZMktCMH5YeNID9I=;
 b=LpTn+fx7vcEk2pkJ3Y/qNLeYEiGVlhcjrJa4wBvWYJQQFyXJtsr6o6/ahXrRR0h+4jFqKJeeTDQj6inQod8euaqkHf3i0A93dH0v8ROp6ALDU0OlDTwdALxYihbJVsk+jgd09Uqd5alGwprEMtxWGVhsHDa6uKSuQpI33ZuB8/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 13:59:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::992b:b2b:80dc:86cc]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::992b:b2b:80dc:86cc%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 13:59:11 +0000
Message-ID: <47247c96-f514-c075-7b99-289a08c552e0@amd.com>
Date: Tue, 8 Nov 2022 19:29:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amd/pm: enable mode1 reset on smu_v13_0_10
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221108003543.2912161-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221108003543.2912161-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: abae5a40-58d5-4394-b644-08dac1916914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPn4+5e9TlByQKDn3RfJTDb+tcCYRjy1S1u+hphjycbY5FF2F35QOZc6qkuerY8Ced8M0bbrRWcza8RIPwsAT+NMNxSkV2cE+rOhJxVMnPd4yqzXYt9BAv4icYpb+BdOJkALV96SoyVekXpZgCSAWTyjmO32bGb7NBaHnOpUaj5anrGMXzya2SYilX9LvMN0oMn0WJPP9/3tUnYa+TCW+5gJwcoqpPXqrafHdirT5NjXqFRD2U/avgOXyfM6od7pMOW8IdATxcnRGg4TmcxGJB4urGYwbhhRTToM/fa9APaDcZu51SUaiOIfZGrpUPM5jikzCbA5tuRGo/YYw7T3xngVL6W1sZ98U7RqJYW2ZhyStHMCQ7fxA0e9QfIKiWODslpm0o3pqlE7D15lxikfzxYp3/+lRmWKQjEEo6gmcJ37Fb5PYMDB1uviuKFrJuTTD07dtGA1Q4NU3Iuy3UIdwj5PHPJ6xER75Jf9qkQfWq1ZEsTCe926B3mk2kfB/82gP5ndgTC1axJkMlnee2JxvRkQ8BV7rAKTXt89kbwV1S77/xVf1Gf8pAEd6QMYq0f+v98+KW1p6iZM3OxQyw40YTO/Uu1J7WaAn6/U1pcAxKc6/sMn4rprn0pmzgfMmoAULsTS1GCf+Aied6VQE8QzyqogmrGoYBnd+x4lHsuF7K8gvrD6iIuzqD2Ah4blTAx9ys/ulu+0DtaLg1aSecUy3rOnBpY40WVu/hdH/ZqXRtumaRsRywwkblO2Oh44pAyb/tNc7jF3NeGp/6xGJRdgofkMnR+05yG7XgLed4SmeCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(31686004)(36756003)(2616005)(26005)(5660300002)(38100700002)(31696002)(8936002)(86362001)(2906002)(83380400001)(316002)(66556008)(66476007)(66946007)(41300700001)(8676002)(186003)(478600001)(6512007)(6666004)(6506007)(6486002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmViREZ6SFdvVkhuTk9jdnRlamFEdUdqVDNYL2FjUSs4eW5UbWVpcHhxZHRz?=
 =?utf-8?B?dlZVcHUxVXVWaGozajhFczBxbC8xcVcxdVBiYlBTbEFxU0thTEZodExqMXBF?=
 =?utf-8?B?WDVTeldkQWU4cVU1ZWVhOW91VWh1a2tqcmZEN0NYZTRmN1VVWmRiK3lqQ0h0?=
 =?utf-8?B?Ymx3R0creGg3MWl0VTFaWFNNZlM3OXBKdUdGWm9WRVhGanY0MlYwaTRYNERu?=
 =?utf-8?B?WUZhZ3J4d3BaUmlySnBsaWVuQTcvdnd3eFFnN05LQWNTcGxLcUZPejFWQjBE?=
 =?utf-8?B?WUgralIxNUZoYitqakhIdG5aaUpBOEQvYzUwVlo5bUZtNmZnc2o1WHJtK1Nx?=
 =?utf-8?B?cGxPK0E1dFROM0Vsam5GV3hOMDFNSmlnQTFXYWs2azhob2VUc1A3Sy9KbWZE?=
 =?utf-8?B?enBYRVlXWS9GNmdzSTBqbWNvenJXamlYbk9iT2o1R2gzS2JzZHFuendyRkYw?=
 =?utf-8?B?NGlFOXFZWTl4R053RC94YXJvQTNsb09WUmMzdHNIWW9vUkRpbGs2NnRNY1Na?=
 =?utf-8?B?Wk03c2lZd1NMYWg4bUozWUZ6cHAvNCtYRXEwcmlFSE91T0ViNVNZY2U4dTIx?=
 =?utf-8?B?ejhTRTRyd0twQzBqSjVGVlNBUlppOUlnanMvL0tXdVZSZ1BISm1MUEgvaU9D?=
 =?utf-8?B?aHRGZmhwbUkwNEVYMTVUOTEvVjNBSU11UFJwOEVnV1JDYVdmdzRlK3EzRnNO?=
 =?utf-8?B?N2R6TGpJZklYaFlkOHNEclpKcGt3V2dET3BGMXArQUtrZEp5WWlsbDZzNnU1?=
 =?utf-8?B?a0dtTmVtOGh5MWFkYkNaaGNIeXZXclJML1JpckVLeCt2VGVFaXFRNzRJUzBR?=
 =?utf-8?B?eHplMzZ2ME5kK2M4bkdTZzkvUkFzRzM5SS9WcThSZGg3MExESjY4RVRPMzFs?=
 =?utf-8?B?enhGZHhVL2xKRGg5Wmg2MlZvNTA4aHJnY0ZvblVFSkJhaTAyejU5WkphWXpi?=
 =?utf-8?B?Nmd1WnQvZnhCSnc4ZENWeWR0NEJqcUkvMEViaHcwMFZGbHNjR1N4ajRYaVdv?=
 =?utf-8?B?aXM1N2pPSElXZDlrdnk3K2ZDSnpwZnlDaFdYZlhmQXVzdTFQd0MvdVhvRkU5?=
 =?utf-8?B?RHlMcnNlanFmeVhLVG1acFZHWEVyeDVDNHA0WHhqYm4wZExnV1VUb3hxM2dr?=
 =?utf-8?B?NDRrM2JpSFJidjhvRFdwQmdhSy9MRVpqMW1SV2p2MlZtMjlVY1BsRm13NEl0?=
 =?utf-8?B?YlBTVml0aEhTeU5kT1JyM2xlVkdQUDhiVFFINUZPeWFxeUQvUTlsZDViUlpJ?=
 =?utf-8?B?bkhsK3gwZlhabzJNMGw0bFZWQ0FTaXNvdWorVU5Ja2p5UmNxQnEvYUdjVlk5?=
 =?utf-8?B?bzY2bUpvcVFVUDYvTmpZQ0lTNjNOTVlXYmZPY2lhNmlaUnZrcmN2Zkgxem9Y?=
 =?utf-8?B?R3lOUDZpVFYxNmwxZmMvMytYRUZiZjdvWWRtV0sybkdlWndHNHhLUzVqdzdH?=
 =?utf-8?B?M2NIRnNUYWR6UjVjWW9JU2g4NHc1a0NuYjdmVzlrYVNkSFZvdXh1SkVXbTZ0?=
 =?utf-8?B?TnZ1dDFIMXRtS2ZwQ0dJbUxnbSsxaEEva2RLWVAwSzFKZjFyNndJM2wzZExY?=
 =?utf-8?B?SGkwc2U4bEN5SW1sVnc2MlZYNjFJTlVibHR3Q2dXTURKOFhZMURia0IzRlpy?=
 =?utf-8?B?NnV6NStOV1JDd0RFdXk3OXJHbHVucjdpUDBSaE5IZVUrSXkyZDRXVVRvWWU4?=
 =?utf-8?B?YlRFd2RSdmVGczhYL3ZYcUEwVjZTNHBOeXkwNnlTUU1kWldvaWlxU2g0UExu?=
 =?utf-8?B?dW8veGVoMFFnaHk2am12OVo5c3M5KzlISTk4TzNaRm9IaHBZSmpnckY1RWZJ?=
 =?utf-8?B?OVBjQnZkQ2lCejNaZWtBNGlKTk1EWlBBQ1ZYVjZ5YW5FNGlLMVFQdWpJOW5J?=
 =?utf-8?B?RVFEZ2E1ZDU5TFZJcnFpQVpyNGVPWFNJUDZ3L3BQV2pDaUhCNUVsZ0VGVHJh?=
 =?utf-8?B?cHIwT3Z5R0ZGRXFGSkZWdG9Sa0FLMjRtNDR6UnZKSTVBRXhLWVJpRUhyYk5a?=
 =?utf-8?B?MmdLczc3OFpkK3N3Wng0bTA2cnVxZUJYRXFoV1M1SEpVeVFXNXJ2R3ZzcXFO?=
 =?utf-8?B?U3hFYXAxb3RUeDVEbUVMQ0htUDFGMlplQnlxRElaQ1Q5VzJKTnFjbm5KWnhP?=
 =?utf-8?Q?UTPj04P1306kDzDwq26oBqCbB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abae5a40-58d5-4394-b644-08dac1916914
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:59:10.9979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3PWhZu5NmtUM0lrXblztnYyYOoIp2GESScaWjINRrCfUg1gL1p9YZWsaekzSQ+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/8/2022 6:05 AM, Kenneth Feng wrote:
> enable mode1 reset and prioritize debug port on msu_v13_0_10
> as a more reliable message processing
> 
> v2 - move mode1 reset callback to smu_v13_0_0_ppt.c
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 ++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 53 ++++++++++++++++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 18 +++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ++
>   5 files changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 1d4013ed0d10..b258e9aa0558 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -322,6 +322,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
>   	switch (adev->ip_versions[MP1_HWIP][0]) {
>   	case IP_VERSION(13, 0, 0):
>   	case IP_VERSION(13, 0, 7):
> +	case IP_VERSION(13, 0, 10):
>   		return AMD_RESET_METHOD_MODE1;
>   	case IP_VERSION(13, 0, 4):
>   		return AMD_RESET_METHOD_MODE2;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index e2fa3b066b96..1bc26e93a83c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -568,6 +568,10 @@ struct smu_context
>   	u32 param_reg;
>   	u32 msg_reg;
>   	u32 resp_reg;
> +
> +	u32 debug_param_reg;
> +	u32 debug_msg_reg;
> +	u32 debug_resp_reg;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 29529328152d..588527310188 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -70,6 +70,26 @@
>   
>   #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
>   
> +#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
> +#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
> +#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
> +#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_75                                                                            0x028b
> +#define mmMP1_SMN_C2PMSG_75_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_53                                                                            0x0275
> +#define mmMP1_SMN_C2PMSG_53_BASE_IDX                                                                   0
> +
> +#define mmMP1_SMN_C2PMSG_54                                                                            0x0276
> +#define mmMP1_SMN_C2PMSG_54_BASE_IDX                                                                   0
> +
> +#define DEBUGSMC_MSG_Mode1Reset	2
> +
>   static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
> @@ -1763,6 +1783,35 @@ static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
>   					       NULL);
>   }
>   
> +static int smu_v13_0_0_mode1_reset(struct smu_context *smu)
> +{
> +	int ret = 0;
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10))
> +		ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
> +	else
> +		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
> +
> +	if (!ret)
> +		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> +
> +	return ret;
> +}
> +
> +static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
> +	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
> +	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
> +
> +	smu->debug_param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_53);
> +	smu->debug_msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_75);
> +	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
> +}
> +
>   static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
>   	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
> @@ -1830,7 +1879,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.baco_enter = smu_v13_0_baco_enter,
>   	.baco_exit = smu_v13_0_baco_exit,
>   	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
> -	.mode1_reset = smu_v13_0_mode1_reset,
> +	.mode1_reset = smu_v13_0_0_mode1_reset,
>   	.set_mp1_state = smu_v13_0_0_set_mp1_state,
>   	.set_df_cstate = smu_v13_0_0_set_df_cstate,
>   };
> @@ -1844,5 +1893,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
>   	smu->table_map = smu_v13_0_0_table_map;
>   	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
>   	smu->workload_map = smu_v13_0_0_workload_map;
> -	smu_v13_0_set_smu_mailbox_registers(smu);
> +	smu_v13_0_0_set_smu_mailbox_registers(smu);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index e4f8f90ac5aa..768b6e7dbd77 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -233,6 +233,18 @@ static void __smu_cmn_send_msg(struct smu_context *smu,
>   	WREG32(smu->msg_reg, msg);
>   }
>   
> +static int __smu_cmn_send_debug_msg(struct smu_context *smu,
> +			       u32 msg,
> +			       u32 param)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	WREG32(smu->debug_param_reg, param);
> +	WREG32(smu->debug_msg_reg, msg);
> +	WREG32(smu->debug_resp_reg, 0);
> +
> +	return 0;
> +}
>   /**
>    * smu_cmn_send_msg_without_waiting -- send the message; don't wait for status
>    * @smu: pointer to an SMU context
> @@ -386,6 +398,12 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>   					       read_arg);
>   }
>   
> +int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
> +			 uint32_t msg) > +{
> +	return __smu_cmn_send_debug_msg(smu, msg, 0);

Since this is a common API interface, passing 0 as param value doesn't 
look good.Instead keep the param also as part of the argument and pass 0 
as value from the caller (for ex:smu v13.0.10 implementation in this case)

Thanks,
Lijo

> +}
> +
>   int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   				   enum smu_cmn2asic_mapping_type type,
>   				   uint32_t index)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 1526ce09c399..f82cf76dd3a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -42,6 +42,9 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>   			 enum smu_message_type msg,
>   			 uint32_t *read_arg);
>   
> +int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
> +			 uint32_t msg);
> +
>   int smu_cmn_wait_for_response(struct smu_context *smu);
>   
>   int smu_cmn_to_asic_specific_index(struct smu_context *smu,
