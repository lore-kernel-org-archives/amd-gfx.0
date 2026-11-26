Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAA606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FqJPb4IO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB3010E1D5;
	Thu, 26 Nov 2026 05:01:59 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E74810E1D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 05:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLkRl9wiU5x9X7ZJlbvi5pVPSyTYIVzxEUBibHx1sOEz1kagc5td3eFqb4qAjSZO0u3lAGyQOyJU0PtIzmRbeshnrAXWv3v9cp/fe8L9/ab7SY716pqACHhwpXrW3f09hYNelMSCJs8ALoE4d9HT/hyetzcOQoxLjjcRpTpCCvLXJGXdrOrBbkxM7T6dIrOtCbS85dglGnI37BZfCteIua7qCJ7UmebUaMZ5pPIupmwoSqeCVga14aEzycFXxRA4DzOv2IijFHQkwIK009KJG/FGmIykOUaQfnwk814PBljACBKagXwKapUP1sDyhYHWJhCBlxzZd4QLTkCyttt2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGtC+PozPRUBa8o0LEQI0dO8l3A613yDyWQuHp+ki9E=;
 b=TWKFmj583y7NINJPf+DqUnGBEW1pMnwHxH6bBKwzaQCDO+PZA2IPT1lOcIGzG8mVgE4O99kzIgGVdeuhnMhlW5T4SwBar912f2SKWsdFwmJOcdLAtUKffDebNKKF6q2DWRcfm8MqJyOlI+qIWCtcwTJcMuJDbReSxhLGMJo8/xcTcE6MwlCst8NdIM+ftSBAAmH87MRvBUlavanGvhnTf5JP9x9souMEhefFXgSXvWkpefp6XkXJ9nzBko/W8ZCn8O2HhJkgu4bU/lRrBuyHLr9Ruy3/usdczZj4bToaHhFJzQ9/Ko7w+TmF5RTF2NPP41gHl0bnzGDbxiRicejD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGtC+PozPRUBa8o0LEQI0dO8l3A613yDyWQuHp+ki9E=;
 b=FqJPb4IOCi7n45flG6U9Ut22d2z5tyxi1N71qJuxSDftuwNSoPiN+F9Jrgshc526QzxrHVb5Jdk9v0HR7RRGvMhhb9wsVhY9WkyKo/2aIvlt5sdACrkTymr6ISvNS/tv59pfbhlD9tmpx2agU3vtVXTx4B9kKO/SHEYMYH9zwjg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SAVPR12MB999122.namprd12.prod.outlook.com (2603:10b6:806:4e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 05:01:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 05:01:31 +0000
Message-ID: <a5e7f3df-7a50-468b-95a5-35fa675139ee@amd.com>
Date: Thu, 26 Nov 2026 10:31:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Use min/2 as deep sleep threshold
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 kevinyang.wang@amd.com
References: <20261123041850.2586764-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20261123041850.2586764-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::18) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SAVPR12MB999122:EE_
X-MS-Office365-Filtering-Correlation-Id: 56be0013-3ca9-45b9-e8ba-08df4b7a5637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: dxUHW8ygQ5YcmtvFP0oyJsmrkgzbdfD8l+LVdFsmdC8GUAM987UqyDB4SQG1CbF1il29+BnocWcm1Li7QqmQlkmq0nJ5FQ5y/W0kXB+CcQoBt/WiSm+qP9O2RYFdke039c9esdj2QVXQQ8VXIi27udN50jWWqDC+XNbSok29wpXrIdqkRi1y6dmfgq9ZO3HvhRFZVxyEbs6QH5RVUDfprcHZuHAkJRuR0b88PlnHxViiGf2vQYXgqG7Dd/+lGuWbTuNro8ZjyjTpBMjl4wkyzQAOcAd28aH7N5OsGLLBLoWLRvmLa8Xl/uBPuN8+cvsEpqjf7ZFDb2Xk/UDqltGvnJAzZmVLEZ3I8wzWe5Wlr+Xjgvnjzasg6OT83wNskrQ3EwRxke5hOi16J2L/35u9KN2k/xEQxPAUrdXo1HXbZwhSLJDZBnDQiQaMszstt2jD8VmKQgZnWbeRIRYsN13wqb3UZI0WiQHLEUBjLnMXugn61RCa94D/2gwDsQJGDY4nFIRfWuigMEWPOo2n9ql/Vu5UwuiDaUSq0Bb1jRhRrvipYaJ2V6Stnxd3MLqcpR/WvYKbJbebeUQow6ARpLAONAGN55Pul91fm9YVPzm6DPhO6bcUl/ynJ4kIQ52SRN8FLtv9r/+7Ur4sVgGrrRrvr8X6qJcc416n6RnQi5Bi4yI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFV3RDNoZ3NiVzBKS2NtM24yK0RVRC9kS21jZG5hUC92N0l1K3E2dGdaTDUr?=
 =?utf-8?B?WklxZnZab1BZYzVSYjFsb2ZkSVdDY2F1Y2crMWZyYWZENlJoLzY2aGNQWjdM?=
 =?utf-8?B?WmJ0S0FseWprUGVZVFpHN0hPdG1obFVxZG0wbUR2WS8xcVo5NlRFK0pFWnM1?=
 =?utf-8?B?Syt2VVRIRStDL3NkV3kvR2NlcmxRbjNsZjRpRDJLSHdhWTlZdGsxQmNsZ1VZ?=
 =?utf-8?B?NkI1b1hOb0FQZWZNc2dMZ3h6SnkweEJxZDNMcnVmVHlhb1pRc0NqSlVJSjJx?=
 =?utf-8?B?VmcxUkNjUEtncmdzQkdmUlNDeFFtQVo2WCtmMnJUV01zeGxLWktkVjNRT0Q2?=
 =?utf-8?B?ekJ1Z3d2UEFidkIvNE05OUNaZytxQ2Vjd2RHdllKT2E2SEZCQ09SeXc0M2pN?=
 =?utf-8?B?SmpXUDJVWmZScnNhQWhnNjdPMVNyNEVseUVzcGZycUYzaGRWQjhVZEg4QTVx?=
 =?utf-8?B?a20yZ1dYM05SSGxsVEdYbDlrZEM2VC9jYkhCNk5CV2tSelRHdU9KN2o4L3k2?=
 =?utf-8?B?NStVOEdZVVo0MWVYaWRDd3BZekZOMm1GNjNTUEUxQmFCOXFRUUYvQ3I5eHky?=
 =?utf-8?B?aTJ3aFh2L1FHOHY1Z0Vic2JvcEF0TUV2dWJ5TnBTUmdzSm00dmhzMHU4OUsy?=
 =?utf-8?B?RG94ZVRYWXdZNVlOTlh2anNuRVdYYmhJNkVWL1FjdVNKa0dEYWZEL1AxZGU3?=
 =?utf-8?B?U3FrdXJsYWh5ZXh0eVZpV2RyYVdPdFlmbUcrV0N4Zm5GN3Fqa3VBSEtXejVa?=
 =?utf-8?B?MUNaWkNsTWV1SDJMc08wUXNTS252SFJPVXpEL2RYb2NCVFcwaXJXRnhvbUdr?=
 =?utf-8?B?UXFiMEZkYUZoTUpvV1B2WFpEZEhPdUhRL0s4TEtFNklqR2gya3VvRnEwSFlJ?=
 =?utf-8?B?cHlCSHE5YWVLVURPVkExS2NSU044OGdydm9OZktKMlEvZDJPcUtsQjlKVS8w?=
 =?utf-8?B?aGk4akpCWTZLL05GczZUV3A2MUxveGszTjRpY2tpbnNSREZqMUwwV2RiQlVB?=
 =?utf-8?B?L0ZmejJxRmRhcnBydXI5WXJLMXBVVlZPZ0d6M1Zxd04wNG1IZzA3Y05kQ0ZM?=
 =?utf-8?B?TnJhS1VQbjRsRUxDNUFHMCtEUE9FOFl1ejJxUHhoNFFkL29nNjhaL0Q4bTFr?=
 =?utf-8?B?WUt4NENTdG9IRVEvSCsrdDVJc0h1c2lITjZBODVsY3dBeXJCQTZweWc2SjhK?=
 =?utf-8?B?WE1pNlBqbHdCNCtXbk5RYkdXaGdrN1o2MHZyS3N2cWtVSk5WdXkwWmx1dDJt?=
 =?utf-8?B?OGtvMFZTMXhDc1haK3BlOXZ6TXpFSURzNWpNQjN0eFpBUTJwYUFvbko4U2p1?=
 =?utf-8?B?RW4yVWFodmdXemlRRzVDUFU1VzZ2M0dJdW5LSVBPLzVtWjBwaU5DcWdvcWc4?=
 =?utf-8?B?S0NjZDFMMnE0cE43SFFkKy9xL0pIVzlwVnlmU0RWOG95Qmpha2JqNXhHRU9n?=
 =?utf-8?B?NGs2TThnUEFSZ1BUNjhNcFpBSjgwckJoU1pidjI1OWlndnNzd0xvbjkvdm8x?=
 =?utf-8?B?dU1LODJVU2NZWXo4VmdHVVpJNG1XVWtwa013Kzl5SkpMOWVIcmxZVkhNekhs?=
 =?utf-8?B?Q0xNWnBXSVQ1Y0lWeHJkMEo0WnRHNUppVUd4OE9sZFZBaWhyd2pCNDFINGdh?=
 =?utf-8?B?V1pTQ2lmMU1aNGJvaGdERmxNZ0lUWVVaTk9jQ0kwcGg2bC9lTWxoditpU3dk?=
 =?utf-8?B?QUZZazBiTE9ka2RhQ2ExVDJGMC9OZkJOb1hBWUFUeHhGSEJKZDBIaXY5WHgy?=
 =?utf-8?B?SVExVFN6U0h0UkFlZWVKRDlFZzRYOGdVNFlSeitSYjE5Z3lKZGdyVWRRZ2FS?=
 =?utf-8?B?dDZWMHgrZk5TVG5MTU1TMDhoRytrVEd4WkpnMGthSHFiYVo4ZGJMeXB6Zlpi?=
 =?utf-8?B?ditJaE40eVZTZ1J5R3ZRdXM4K04rOElVd1htRmUwR0JMenh5K2JlNFQzejRH?=
 =?utf-8?B?VkhLNXJQaUh4NjNsNmJWMzM5UllQeDlKSnVtWWRHNnNSSC9Wdjh1Q1BjYkxI?=
 =?utf-8?B?cW0rWTAvS0RBR1owaTZBVmkyUzdBOGhiYmg3TG9hZTgwN1RYQlp2UEwzSVU3?=
 =?utf-8?B?NFg5M0xhODFqSHNNYlAxSFIwMTRzYVFlODVDemZ1Yys4Q2ZCNXI0NDluVjd2?=
 =?utf-8?B?L09IbkpGSGJvam0yYUx5a3FZU1VWaC9wSEw1aFpRWWtzRG9aL0YzcjJKSE15?=
 =?utf-8?B?a0wzVXZpMWNJNkZEall4ckZHVWN6dGhrd1JIMUxOeWFpUlBLUDRJU2p4OWhm?=
 =?utf-8?B?VGk0MU1ieGUxNXdTUEt6V1VWV1gyK2thcUIvano4ZWM4aUIxQzVDQXJaTGpO?=
 =?utf-8?Q?FMy6zjO2KFhgojiPww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56be0013-3ca9-45b9-e8ba-08df4b7a5637
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 05:01:31.5522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijsQN7wEPEaO7xr+54P0nN6lbsBNrUPMtfFYpsYM3f9RL2gA+vNI7AQlJx9ZnlZ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999122
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

<ping>

On 23-Nov-26 9:48 AM, Lijo Lazar wrote:
> Deep sleep clock levels are lower than min clock/2. Report as deep sleep
> level only if current clock is lower than half of min clock.
> 
> Show current, min, max in ascending order for fine grained clock.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 4b31c99ab7e9..b83ee7cf56e3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1428,8 +1428,8 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
>   	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
>   
> -	/* A clock below DPM0 is reported as a special deep-sleep level. */
> -	is_deep_sleep = cur_clk < min_clk;
> +	/* Deep sleep threshold is half of the min clock */
> +	is_deep_sleep = cur_clk < min_clk / 2;
>   	if (is_deep_sleep) {
>   		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
>   		level_index = 1;
> @@ -1475,11 +1475,25 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
>   			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
>   				lvl = 1;
>   			} else {
> -				/* NOTE: use index '1' to show current clock value */
> -				lvl = 1;
>   				count = 3;
> -				freq_values[1] = cur_clk;
> -				freq_values[2] = max_clk;
> +				/*
> +				 * Current clock may lie outside [min, max].
> +				 * Print values in ascending order.
> +				 */
> +				if (cur_clk < min_clk) {
> +					freq_values[0] = cur_clk;
> +					freq_values[1] = min_clk;
> +					freq_values[2] = max_clk;
> +					lvl = 0;
> +				} else if (cur_clk > max_clk) {
> +					freq_values[2] = cur_clk;
> +					lvl = 2;
> +				} else {
> +					freq_values[0] = min_clk;
> +					freq_values[1] = cur_clk;
> +					freq_values[2] = max_clk;
> +					lvl = 1;
> +				}
>   			}
>   		}
>   

