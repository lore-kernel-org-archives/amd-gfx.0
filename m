Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0CC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F9460F57
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04F9460F57
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83F06E1C0;
	Thu, 12 Aug 2021 06:16:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DE66E1C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:16:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4IxGHxKdkfwmBpAYEJxy14qAZQJjowY+Zd20TpirFLMp3XjJ7xS7EynbwnCfITDmqJ/oVuOCPAO4aW383WMJu0IZUcPwyqld3ZRU944nvNpsr8V/O43Q9tS43cIX9cxZssYF2bVcofFV3aCxW6wDtJxsTesY1VkyQe1EKMzTIIzGBPyzTwQVZmuoTFUSNCvx/6Y3B5jzbKsMMUMUcRWJ7GiPTVtFTV6AMFNPSQC6w8w8LFTKJT3K3FiTHkXai7vvWf/Kag+iUOlUbg5sskJwXn6U73hYaDZr6ei97iG24hH5yyDt0LSltZ4FeMGmQV+iKCQWcVTp3ZEP8OL8VhVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHMkn6e9M7J25z6wfyuMWdVCjm1kZYiv1rsAS3IW9v8=;
 b=M4uEusi/9cfzYUY0W0+26G/wr4dfoVnftSSrK3HtTWjW1JnFo5bOtf3nX7JoDZdFEs4UD5y7ZsDGd+oVgoaLZJyC1NqmUMlYY/T80okJqRF6fR3xntxVp6Lgmtat1aKMdkNLbAxVei9Nn89RXHHQvpF1ThAQQ2hC398FDF0Sn7dQTC0+WDvGBmXZrKz5o36Zn+lanShPb5x4mqYwD69Tk8WIC6yzwzvAQCHI+YjDneIfMPTtEhB5kqQIkyEtogvi+I+2Rhnuaat4zahhqaFBVph2LFNdOsm2noKIQtdwkPqrC6PaPFKyKf7ejMS+l8+GMyd0e64VSu75VtsKNgmx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHMkn6e9M7J25z6wfyuMWdVCjm1kZYiv1rsAS3IW9v8=;
 b=JVmGSBH9Pu1R3ifzFPMU+Tlbgwc+Gm4THSZy7b0KUG1p/fjiiATRRp0v0VYV2BxfXJn8I9Hqv0VU4B7f4S024wjDe9LDlRHzyqumPDhiw595fTUXBTTX7dO4ayhGtdcxjZ8S0hUpyT2aKYZdZF0EkjGtTKdBuToD+cNccODdKDE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 06:16:11 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::4804:801b:71a:a8ed%9]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:16:11 +0000
Subject: Re: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: nils.wallmenius@gmail.com, Guchun.Chen@amd.com
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-6-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
Date: Thu, 12 Aug 2021 11:45:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210812040110.1293682-6-evan.quan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::21) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 06:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3045f42-4df7-41db-e623-08d95d58ae5a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51801FF1A3A4CCC3805DA55997F99@BN9PR12MB5180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+CVZoBNNBYKV6Q4D650/fB+/G7HbexHAzi/ovPKCfD1VZaR3mZkCd+vgrQZUr0ij2suYEzF2OHta4GbvtslwnzKEhYRr6/PIBP6myLOMdJgXGIilyIgD6zJ347sGRgZownATXLT/WJyL0LZKNxbECqMKFXQCTMjbv9aT/cKsRC0Mh8bqnYS8134+sgX+cV1CrYZuTJ3s7yQxsX3MZtWtv5yj0gipJCH2GhXOXS4ETRiuMLS9JrLGCBDE9ICCMBaFEbZexsPZcdTDb2TLiUOWSKeYVnd5f+aBL0kl7Xw6g7sCizc1M78dQ/gGnGizg5t7+FmwEBSqIVZehKcz0mAFImhyp/EAOol1/fACm3SA6+kAzH+KGR6+2P9FGp+l1nDpd55SMz97N89oCI/N91Ypm0SKvPwgoTUJyCp15/FZaI1tdOh2ODeSUClTTDDU9VOIok4LnquLtkxqubfz0SoA5LKufIc9hUf97s2CSH2EtL9hyMjUZcKO31MQaUBPSs9oNBJ7yMsDyTRz6GhYFrAlCcw/YSSIsHdbFc4Dl7jnEqQ+RMSLb6KWE+6GMFf3hpOQpseUjc0S9RH8zyf7DXpT4sBljpbKAst5rSKPL0wgaTEwmtwB9wYluqEpC4walKrxzBinobWyOJf1pAuTvRtoF6hzwjqm3uzAcv0qXDZZV9p/eCCgH004rzUA7vlJh2PcpVDCzNaqNJ7/9z9fCTaLdC/M4cPHvBfzYKidNEsPWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(956004)(2906002)(5660300002)(2616005)(31686004)(6486002)(83380400001)(316002)(6666004)(4326008)(53546011)(86362001)(16576012)(36756003)(38100700002)(66476007)(66556008)(66946007)(478600001)(186003)(8936002)(8676002)(26005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBpb0VIZTNKc1NLNzMxMUExcTBYRDRoUUdkeWJXbTRPRnExS0lJWTIvZkE3?=
 =?utf-8?B?ajBnZVJjUk92VjRBeHFoK1ptdEZ3TFlxU3VLTWJnSWZudE55U2ZYa09WS2xj?=
 =?utf-8?B?a0tRSkhiYThOWnVzMW1zbXp5U3pzRktwSkJvWVlFTk5Qd0wxR1dMenFUWWpp?=
 =?utf-8?B?RVN5MkxGUXF3VXdoc21teGJ1a2NHUXFmMmNpM0FDaGdiQmN6eENxMjJaZVN2?=
 =?utf-8?B?TEI0czl3bTU5YmFGNUNMV2VpcHl5SGJiM3RJU1c2RDJqNDYrOSttTXlPV21G?=
 =?utf-8?B?MERYWnUvd0J1UkpXMUxwaUQ4bFF2eCtjaVZaeSttcXRGVkNVNmhDZmlwWkZN?=
 =?utf-8?B?S283ZDRJYlNGQ3ZaVjhYMU83b1IwSWV2R1AwTVByc09YNTk0RThEQkZubzI5?=
 =?utf-8?B?WlBWcXQvUTVXOElKZ2prdHZZOXcxWFppTE9HZmVEMDJWTmt3aUxrQzU3bmp1?=
 =?utf-8?B?R1k4ekVQamVLand2R045WEo4eCs5ZkNWSTlPSHlYblRNZU1HYmFzS3N2dVNm?=
 =?utf-8?B?RlplWDM5NnpEQTExOHBUUWVJWmhIc084WHljeFNHRzJ2WmY4S3Rob1BldDhY?=
 =?utf-8?B?SStkaFdYdWpBdDdQZDVjV1o5OG1IN1haQXlIbC9CSnFqenFTRC9aM3AwL1Rr?=
 =?utf-8?B?TktqWmJxSzZNOWZIQnJ6SnhCanllTk90YlVhNHBFK21CL2l3ZG5HOWpJSG1s?=
 =?utf-8?B?RW5TcGpCRjFWMStTU1JxeVFZOXJibHBpVG82UTFiaWxkUFlXd3gxdmI4N2t3?=
 =?utf-8?B?Qzd6dkxXTUlzRkdMK0lzL05VOFc2UERINWV4VzRIZ3JWWlFJNEVHTTFIYnV3?=
 =?utf-8?B?T2dubnVSOHlwcmlkYVRVVVFkaFlmbTNYVFpjUEZNMkxDRUZwSUxNVlR6Mnhn?=
 =?utf-8?B?R3hrbkdKMWVlZGE4WURnVGswcVp5MGk1ckpsY2xjVEZ3Z1RaZkJucnBjZ3lQ?=
 =?utf-8?B?Rkx3SHp4OFFYYWV4ekx2OXI4WmNLak90QkZtZktYT1ltcDZPOEx5SWgva3I5?=
 =?utf-8?B?OFR1cStTWHE1dTVwbjFkV05WeEYvRkFKREJIYW4xRkUvaEc3NTE3emk2aWx1?=
 =?utf-8?B?YzlLdDJucDNkUG1xYmNZYTdIYTBYRkF3UmNMcStsWFNLUWt5ZUtFZjF0L2RJ?=
 =?utf-8?B?UjI0enZHMkdTd1FSMGJ3V01wRzgySDhpNkVnM09raE9WNTJldEhROUhvNU9Z?=
 =?utf-8?B?d0NVaW56SHd6TXFMblVka3MrcVBnbTdqSWhaT20yZUFDckdRRWg4MWhoc2ZO?=
 =?utf-8?B?OUNwSUFpTE1SUk1ic1BSSWNsa2RHNVhISFdkMm8yeUhVLytkT21hREErV0xa?=
 =?utf-8?B?U1Z2Z0tHNnJTRXJEOTArSW5GcEtZcE41M3l6amh4WS82WUtOVk1GSDVGNlhX?=
 =?utf-8?B?RDdMeSt0M3R1N3hRRGtnRTdlakZld2M1TVZRMER3OUxHNWR5L0lLM29QQWZz?=
 =?utf-8?B?US9qcW1zYXYzUjNhTkFvdUlKMVpaVmRqbzZLai9LdFdjK3RXOUlMQlBNalU4?=
 =?utf-8?B?M3FHdW5rSVV1S2ZvMnJ3amE0eWQ1U2xuM20yT1VrQTFYbmZ3NGtXTit3RDQv?=
 =?utf-8?B?TXpZTGoxeE1qenRUeHJvMis1Sko5TnI3UHNxMmlsTzRJWHVBaXdIbmhBbVEw?=
 =?utf-8?B?NWsxaEtMQTdyUVpVTlJEb1lVNVpnaTNacWYzYW5SbGpQKzd2dVkwbjlyQzZu?=
 =?utf-8?B?cTBYbDZSckUwT0hzbDhnSkFjOHBzWlBkbUZOaFRQVXdWZDRGQlRlNU42MnFR?=
 =?utf-8?Q?/oQV1p8EgvQf+5glr/eptHEQ5yu695CwYX6rnP5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3045f42-4df7-41db-e623-08d95d58ae5a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 06:16:11.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpqyEJ3EwvoIgsKJ0mmBaeNBV+BhvQKiwfd60ustnTbUVIt2Od/oo058WvcnV5VA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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



On 8/12/2021 9:31 AM, Evan Quan wrote:
> As the fan control was guarded under manual mode before fan speed
> RPM/PWM setting. Thus the extra check is totally redundant.
> 
> Change-Id: Ia9d776141ec4aa39255accbf00d7e7ed81c8424d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 9001952442ba..20ece0963f51 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1208,9 +1208,6 @@ smu_v11_0_set_fan_speed_pwm(struct smu_context *smu, uint32_t speed)
>   
>   	speed = MIN(speed, 255);
>   
> -	if (smu_v11_0_auto_fan_control(smu, 0))
> -		return -EINVAL;
> -

There is a FAN_CONTROL_NONE mode where it is set to full speed. Is that 
affected by this change?

Thanks,
Lijo

>   	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
>   				CG_FDO_CTRL1, FMAX_DUTY100);
>   	if (!duty100)
> @@ -1237,11 +1234,6 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   	 */
>   	uint32_t crystal_clock_freq = 2500;
>   	uint32_t tach_period;
> -	int ret;
> -
> -	ret = smu_v11_0_auto_fan_control(smu, 0);
> -	if (ret)
> -		return ret;
>   
>   	/*
>   	 * To prevent from possible overheat, some ASICs may have requirement
> @@ -1257,9 +1249,7 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
>   				   CG_TACH_CTRL, TARGET_PERIOD,
>   				   tach_period));
>   
> -	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
> -
> -	return ret;
> +	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
>   }
>   
>   int smu_v11_0_get_fan_speed_pwm(struct smu_context *smu,
> 
