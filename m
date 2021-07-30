Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D8C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 04:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D5C600D1
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 04:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3D5C600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C78F6F3C6;
	Fri, 30 Jul 2021 04:54:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521CC6F3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 04:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF8z4uhimED/N8QASt+tp26RR3rK3n7RFF1i8dDOY+VhYgemgToNBTRrBFgn5WYrGG+lCT18Wk5I0u3YdyC1p4gQt5EG0wyEqQtOBvo7CpIQBzYF4tLcHb1EelwPzNvHLhOsfaZnj0s+zEK4ZuFAqrbcjXanH2MdyGbzcI02a+P2rrc5m3Cpwc22YM8VNys88p2SGKtW4q7mXw6oZsCvvkzeY3rmaGthVSTKNhnjeB4ZrHuVNC5E+9b5ZRUnQ5mT4rUIdn+AV+81HrX57ZLDlUkaEjYsJ6CGTrTUASltSvTN+uPPWkkmmhfV+2/7fabmKBSDrz22b/6sXL/+WTsy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ns6aeheCuTmL3K5tbHhWEFxxX/0n7BdPzIrK7h1VXQ=;
 b=KedbEVj832fo/x+MSsa4jQ8PUIUAARh43qHF4SV4gzDCO2C0A57U2n5ZJMkinzn3OHtyC2scQ2g/rsHUKiI8J9ug1mYGt/qBQzPcgTdhZF9sWn/KkuvS3JrT6ctpyt0nQU6RsYhLQcOkCgGAK5tz3lmALbUSGBs5VpHJivAW9V/WYe5TV+EIZnPJbaOcwZqSvVPnIDpbyOldzaEl5qEA+nbf8sj+FXkreVAcHCCDeR/Rc27OSW3HHehHXVfY+JxnDD9GYKjDjpF3NHu4D6jY8fLL6oOEUxars+dlz78kboeFDV4/a4bmhMXOPZBUW0aNDsB4VeCnSXYP/ZcZoTATuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ns6aeheCuTmL3K5tbHhWEFxxX/0n7BdPzIrK7h1VXQ=;
 b=yUvbmNthVT7iKWimDh7LFk9CfdwPFblrIhe+soau3wgZiZF5Dj8/NCRKLwNI3YcA3AiI3jDgYrKn5hXoocVNLBSWnO16RX2TkJ4SEl5RJa7FQjQnAUMNhCoIhxSW35QVU32akeizhvbfUlHj218ild3RA8e88BQRBMF6YYf29qo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20; Fri, 30 Jul
 2021 04:54:50 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::e1cb:9940:1924:50f2%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 04:54:50 +0000
Subject: Re: [PATCH 3/3] drm/amd/pm: Downgrade SMU mismatch information
 messages
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210730024050.248-1-mario.limonciello@amd.com>
 <20210730024050.248-3-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <a8c425e2-7b7c-d122-f184-9380993d6c5e@amd.com>
Date: Fri, 30 Jul 2021 10:24:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210730024050.248-3-mario.limonciello@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PN1PR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::34)
 To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 04:54:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f81290c-6e6d-4d9f-4d17-08d95316299c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51630E283EEC49C244FEE99497EC9@BN9PR12MB5163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUxw6hZI8ANPhYfdUYwGopwQjrVBVzubCvEsckg+tNDq0NwZi74IxK8YGfnFfy4bwhIpZPPK3tAXP5m1qqkEyScOdyam4XhdZLVdlk3cHrl6L0mlV4ztHPZ1DLSkTF0Q6MpumFO1cIpQUhMItzjKn14p/mDIVhxLid9AK5LwhBLRHEYM3MhmETIJlkIwvoaQ0ZHK1MFug9EiNfRwvMlmYp/H8BISEHuNoxWyYhBLHJ+2Wd+fWNwcHYDGcse5ojbk7aNc3XjZofBShK9Lh5UxMDPOHZ6tAcrVL43nntIkAQWafAuoRPjB7EoUlKGJlqRm4j8W31zUXrXplG1ktQwBEy0L50F/QUIQtT15tAPU+SKcw8YtUVbJgQhoNPE2iTc2DuSDVDYQD009IzKXeZC8CBNawbOWh63rlq6dSGhHJmNfleaRmpQTuhNGoKyVKMoXfjLvRR9aAu1D9VEhVpIsp81bi4U0xE60q8dlnrv8rpEqvWviq15AvYzAP2f7ZYctRTQx5ndnrASrQ1MMbdj8Q/uxPVzVXOAO2zlNhbD9ODXUFbz8+8+JRE70DKP7oB1882rJIhHbY7WMGBI7DSivPZ8xOU8MlNU7h1LB5Qf4w/rJTJpBRvCUTX9rOVZ5PAx+ftFsdM/8RhNxTmOY1dtRSSqz8oEZQ63eKBhgZX/PP3wOj6ZH/+pU+c8lpXIv/tNPMpCEl5uyiyLvY/UVxY0q7Hb4ZQvptLNnbt3P45NKcIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(53546011)(36756003)(66946007)(6486002)(66556008)(15650500001)(66476007)(83380400001)(508600001)(31686004)(2616005)(2906002)(8936002)(38100700002)(26005)(8676002)(186003)(16576012)(5660300002)(6666004)(316002)(956004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTV1dXdmQUZvMVVpdWRSRlNmcFZ4cVJSMWJkY2tnU3pUMFBFMVBzMThwR1Fl?=
 =?utf-8?B?N1JqR3ZBS0tCZFRTeXYrMmZFOTVBeUZWUFFoMzhrMy90ekhKR3pDSWFqeUlT?=
 =?utf-8?B?cXlrS2g5bmJ2Tm5VZlZ4MWx2L00ydk9aY1E1Z0pyd3BSRWZDaGtqRElhL0pL?=
 =?utf-8?B?cTFtS1c0UXNyL1RKMnZNb05DbmhXNEVXL3VPZmZJNWNLbk5QV1dJK1FOWWJF?=
 =?utf-8?B?UkJBalpISUs5U2VJUkErLys2bE1VTGQyWDVrQXBTaDlsMUtUZHZCTFg3RXow?=
 =?utf-8?B?NCs0TnEwRmZwZCtLak9NM1phMncwSG9vWDk0RTRFSWNrVUNZNmRZby84VmlK?=
 =?utf-8?B?OW56ZFR4elJhaHBtMmJvRllNbStvNTdPNGRNUkthaEJoNkZhKzFQTDBxcWVG?=
 =?utf-8?B?NFFNaDJKNTRLMUhVYXZ2ZXJxSTJkL1hodjZvTC8wcXFLOHBSUUJCMEIycFht?=
 =?utf-8?B?bXFRWFQzMXpZV0h1ZzVPYzhxUjVPRDgwOGJJa0ZrVVpaN3M4L3ZLVUdsNnNr?=
 =?utf-8?B?VTBEZ0JwRVRxenpsR2hoVGtLaHpSMDVrVFNCYyt4R0VYVC82QVV3QWRpbDFC?=
 =?utf-8?B?YlZvd3ZzUFNLd1FSRGhUNzdQQzdsNzY0WGdUTmV2U0lOblJhUUlaRmRXSWFj?=
 =?utf-8?B?R05BQ0JHbjdmUWtSYW15RUVlVzR1YmQ2YStNUTdDeGk1QW5DTTU5NlVnamNL?=
 =?utf-8?B?UVpodEhUSEtXdmhnUUhxU3BrSkI0eTk4MEZIM1QwU0RidjFYMUJ1cTVIYkRj?=
 =?utf-8?B?bVR3am8xOUQ5MWJjZWl4cVp5Tm1US2dPZVJLY0ltaGl4Z2owczNyLzFBL0pR?=
 =?utf-8?B?NjQvUzFFamFqQWYwRHNHSUI5clpLREl3dXU2NWNpZmsvbk9pOHZaOU5tVjFk?=
 =?utf-8?B?RGsxNHJYVUZJMDVuYld3TkhWd0g4R2NjZmppVFZZWVU0MUI4RElrOGJUcDVO?=
 =?utf-8?B?T3ZvRWFGZkRwN0lZSmlVelp3T0F1dmpWaVBqQjQza2tvMVNZeGhqSUROSllk?=
 =?utf-8?B?SCtQZWFEbUJwenYwUFh1UG10QlloWW0yY0VRL2FRU045Tm5PVCtseUlnVTd3?=
 =?utf-8?B?a2dnQzlianYyMC81dlhWY1o4bXEyUjgzeGlaQmg5M3A5dWxXU0dVUkR2QTFF?=
 =?utf-8?B?SldqR0hHT0I5dCtXRUFvcDlRVktRNFVJUGNFUjhEUngrSHlpVkFHWEQ1cndi?=
 =?utf-8?B?SlJLT0RsVzRQVkpGQU5qS2ZPZnpVcmJCTTN3THhUMlZoc2d0M09CN1ZYM0NQ?=
 =?utf-8?B?V0pYMUdoZjZvL0xHV0tnVzFQaDNkOVJHZytGS1lkWnZaS0dOZ2xQNnloQldq?=
 =?utf-8?B?ZDRlR2hJakpoYUZtcEJ6VUc0UlROSXNxczNkREJMSjJxVHdJaDRnd1V4R096?=
 =?utf-8?B?SWROd1IvWjA0cW5Kd2lzUE45eXlFd0xtVERJS0NhZXhkUW8zaXlQTGlhbERK?=
 =?utf-8?B?OFg2eitvUEt2djNCS1hJcHUxY2YvUmdhVzEwZ1hvbzN2NkpBQzA2QTdIV3VI?=
 =?utf-8?B?RUVOZkMxTEw2dnFYNVp4eFR1ZU1HbmR0c3ZRRHB4Tnh6UTlqenNzK3ZKYUNu?=
 =?utf-8?B?S2FYZGFUOTJ1M2lqb3RDeGcwVkdqWmNzZ0xBTE5aNVBKSWx4OFBjNjB1RFlx?=
 =?utf-8?B?TDQvT3BHK0l3d0hUdndhMDBlYnpTZWNlVDBtZWY1cTArZlhIc0szQ05tTmF4?=
 =?utf-8?B?WmdMU1YzYnQ5MUtURUJVVzNmeU0vc3YwTEFVOHlCWkprZ0dSaW5PeW1iUkdm?=
 =?utf-8?Q?u7Qz0TioApb0maYb/G7HuTtZaTkmU7E/C7R1wTr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f81290c-6e6d-4d9f-4d17-08d95316299c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 04:54:50.4002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCFtyIwjlYfMekBt8gDceRujuFfVcgBbEtiM7uZlJKZrozwpdEGwu/3NWwFVTXDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/30/2021 8:10 AM, Mario Limonciello wrote:
> The SMU driver interface and firmware interface messages have comments
> indicating that they are backwards compatible.  Don't output at WARN
> level and scare people there is a problem.  Instead bring it down to
> INFO level and the details about the mismatch into DEBUG levels.
> 

That comment is misleading. We are more lenient on Linux that at least 
we consider it as warning. On a Windows driver this mismatch is treated 
as error. We need to keep the warn level.

Thanks,
Lijo

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 15 ++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 15 ++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 17 +++++++++--------
>   3 files changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index b5419e8eba89..1fb2129899e5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -224,17 +224,12 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> -	smu_minor = (smu_version >> 8) & 0xff;
> -	smu_debug = (smu_version >> 0) & 0xff;
>   	if (smu->is_apu)
>   		adev->pm.fw_version = smu_version;
>   
> @@ -284,11 +279,17 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   	 * of halt driver loading.
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
> -		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +		uint8_t smu_minor, smu_debug;
> +		uint16_t smu_major;
> +
> +		smu_major = (smu_version >> 16) & 0xffff;
> +		smu_minor = (smu_version >> 8) & 0xff;
> +		smu_debug = (smu_version >> 0) & 0xff;
> +		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
>   			"smu fw version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
>   			smu_version, smu_major, smu_minor, smu_debug);
> -		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
> +		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index d60b8c5e8715..ddd6bd5c78d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -74,17 +74,12 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> -	smu_minor = (smu_version >> 8) & 0xff;
> -	smu_debug = (smu_version >> 0) & 0xff;
>   	if (smu->is_apu)
>   		adev->pm.fw_version = smu_version;
>   
> @@ -97,11 +92,17 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
>   	 * of halt driver loading.
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
> -		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +		uint8_t smu_minor, smu_debug;
> +		uint16_t smu_major;
> +
> +		smu_major = (smu_version >> 16) & 0xffff;
> +		smu_minor = (smu_version >> 8) & 0xff;
> +		smu_debug = (smu_version >> 0) & 0xff;
> +		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
>   			"smu fw version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
>   			smu_version, smu_major, smu_minor, smu_debug);
> -		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
> +		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 9c99c51740a1..242d3cc6a79b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -194,18 +194,12 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
>   int smu_v13_0_check_fw_version(struct smu_context *smu)
>   {
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> -	smu_minor = (smu_version >> 8) & 0xff;
> -	smu_debug = (smu_version >> 0) & 0xff;
> -
>   	switch (smu->adev->asic_type) {
>   	case CHIP_ALDEBARAN:
>   		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
> @@ -228,11 +222,18 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   	 * of halt driver loading.
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
> -		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> +		uint8_t smu_minor, smu_debug;
> +		uint16_t smu_major;
> +
> +		smu_major = (smu_version >> 16) & 0xffff;
> +		smu_minor = (smu_version >> 8) & 0xff;
> +		smu_debug = (smu_version >> 0) & 0xff;
> +
> +		dev_dbg(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
>   			 "smu fw version = 0x%08x (%d.%d.%d)\n",
>   			 smu->smc_driver_if_version, if_version,
>   			 smu_version, smu_major, smu_minor, smu_debug);
> -		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
> +		dev_info(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
>   	return ret;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
