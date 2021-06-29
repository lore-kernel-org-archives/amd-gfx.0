Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E75C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 13:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD88A61D90
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 13:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD88A61D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DE489700;
	Tue, 29 Jun 2021 13:38:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D068A89700
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 13:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9np8akS/YaFSgIt4M9Aw+jmesrs28yg67V4aF1WAe3XgJ9SvyDLEAv1SJ04ZL+QI7hOrwfhMMBNkXhSQs/irYVDX4hnxu8ae8DUg4bW93oG6hAs8ZJVEnu7MUyWvp9CdnJoL0xxbqwMhn7OaM0UR1nYVwsPSMBP0q6GemqJDuttux+fdexHShB/esCsP89nV8LE4qZCA7W1uQO2BUr9gjadJdzSM0ekfttFC+3lgWLaBEKrbImFHMTHDEbXNq7PCJnK/TajRAmG1N0sqsW4wUVZu3A/++f8IGjGXvqkFCsTjkH6EuknGPIBr5OsKBNICWOsR1tNmdOgdX05gqHzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkTg2HABqKuosuosVI/AmHmX21qWhQE77T6lDjl3KAk=;
 b=QX+poQVLo1cNweE2qR3Sw6ihqh0blYik3G7R6wy/GLJSByE4MKB7B2aXEntvMqBj8gTMCUbixUzfBtCsKiznZQIC9PONDr668ZVUZdnkvplQaBS4+R2WByRSJlfFmSxg0WqE5iUi2Ci1JZedVJjVKyxrz6cq01alUAzUSrIUEmg9WRO/WsfN8BSlQgYeq4AcOtxL4/gsCvx5UaUGBnKYNbxJadZrg7F4sPB7phUl++9glZO+UYA2CyhhuSfuFd9CYo4NhULWDUSGJddqBIyQ8Lc2w1oqkxzpPS/gOB0LTXWirkqfgYY3r6TYN9PVrro14emte3kyuFbgM6RQJ4HlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkTg2HABqKuosuosVI/AmHmX21qWhQE77T6lDjl3KAk=;
 b=lknRydRFMZJ4V8K+XTotBYV+Metdv1lSB/RSJpHwj6CPKmlK3IYDJASWjKeJyifhRpwoKfAiLwA85KvfdBxP5ZOk/Gt2v9EnevNzb48sK1DjbftDJ8Z4ZcTYHXN/wheMEODzVgJB/yBuYuJgReWNxujDAoGLMsWdjlBhS4Oqu8o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 13:38:39 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.022; Tue, 29 Jun 2021
 13:38:39 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210625081203.978006-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
Date: Tue, 29 Jun 2021 19:08:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625081203.978006-1-evan.quan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 13:38:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2962ef8f-202a-4942-98ee-08d93b0333db
X-MS-TrafficTypeDiagnostic: CH0PR12MB5250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5250FF6541F39EAD99036A1497029@CH0PR12MB5250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04lk9+EaGRGKa+UQQ7zdTE9Sq5cRF+Z/yjNr4FT3Ls3QUjglfn7KemhILdCUcF3gsDJJRn0EOHyNnLsRQM+D3e91qnwd0L4y18tZachAzFJIZi5HubMQkT8gXSAXqBSLBUx2Q9Vsxj4C5CGJltzR2D0vhzC21dQTErDntg95UqJ5nDva+HFeToqaNJH4tpKwUbMVv8/d9Oz68/3wg3noAojCWfBKmy383iMKXGXjmZci+YbmkWp8k86vffp3OBPVofM6SVUCr75BfpKn85AUkf8Ia3NmnAzbUdKfu4X8deXhSpf4WqS/3ZbPSN0oYiJkCd6SciJ9UtdTlaLjuMQ6LqOIN3+nI9EswQzwwvrEKHxTzJs9eFtMgx8a+aJat/YNdBb1vXFIfF2Jn7xfeXWxcqykZ+edcy3i/4mrv7FOiE0cOxLlLKlQIYofvC/SuDHTCV/v2/jBMnT4p4feaCzWONTCQDrD41D0yA12J6cunIVVv9XOMlo0Pwyghqaa15E4kDrlwsjrKa/F/MthaorNIH4qyACGH6rG5pnAc6QtwRT3eoFC2Lk/7QJWoPGtZTYwAg9UW0dh+7e1YAFGOwQw8HSHRsp7g2U1+/mAdIJ16MLftOt9KqEFZ3puP3qkAg8k4uvJ/qWeFDjO8w6P9F3XVtUdtIhTZnTRGqAVPTWaXPvCemciVHUb9uZTQvnNkxFWKf2aCPu4O0J2PzVYLYuL0vOCTiB6IhWCWPoqTzWuCG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(30864003)(4326008)(36756003)(16576012)(53546011)(316002)(83380400001)(2906002)(86362001)(5660300002)(31686004)(956004)(2616005)(19627235002)(66946007)(66476007)(66556008)(38100700002)(6486002)(31696002)(8936002)(8676002)(6666004)(186003)(26005)(478600001)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdPZnJ6UEx0T3d5V1pQejk2cFB5SHpYVElZbEljMXdsNDdXUWVKQ2lzTlZp?=
 =?utf-8?B?WStOaXAxUFN1N01WU3E5L2VLTEhKMklWUjZWZm9tL1MzdkZHYzBWSVJIcnRQ?=
 =?utf-8?B?dFRSUk5WYkgrcmNJT2dNSGhrRTR5WUV4UUljakxqcGNVOEhvamZWdHJFZHZX?=
 =?utf-8?B?TEJXdkd3MU9oQUFpczN0K25CcFFMekFJYnZyeHJzcnlEVCtOU05aSjkvVmRN?=
 =?utf-8?B?djZBbnNMOFhBUTNGeW5jeXdyQ2VPVmQ0L3R3akZWUmwrRis1ckJJMWEwa0tv?=
 =?utf-8?B?amwwN244bDYxMGd4V1c3WTlBUXZwQzBqT1FvQmJSV29DK2EwY0F1MS9lSGdh?=
 =?utf-8?B?dGFwR09FK21BZVRrQzBuY1JmdXVzWXRnaDkwTThpSWg2aXYrOUFCVHZueUVF?=
 =?utf-8?B?aGxQWW9ha28yNVVITVlOYXpoU20rWWxkeTQ3eE0xN2NBZld0NHk2eG1zMEh3?=
 =?utf-8?B?cU5Ub3RBK2czam9DTTljWnVldzJhWmxuTGtwTS9pTE5WdlBkdENqQ01Wblor?=
 =?utf-8?B?YVg1eXJjcHFrUVVxNmFKcTJla3F4MWgyMTVvR1VwZE02enRNbDdjTmlWTDVw?=
 =?utf-8?B?OGZ0Nys0WWpHY3NpMnh3bzEveVQyU0FIWEMydXhKeTU2ZEJkRjBtdXMrMURV?=
 =?utf-8?B?VkcxYTc1VFl1MWpDRlpOTFk1cWp2czhXRHV5dWZSOWs0cEtHbkJWOGQweFp1?=
 =?utf-8?B?SElJOWE3N2YzUkJ6QVRhVCtpVjVPc3JVYjlvSkozQmxSYkxzUFdLb281UWc4?=
 =?utf-8?B?OWRZZmtlZGFSSndhVGFNUmRqRncrUEhCYUZJOXJvOUM4Y3lCN3ZJVmtFT08z?=
 =?utf-8?B?a214aE4xS3lBTk0wNlpDWklLTUNBY2FFcVJ6MzdDdmhVL3hpMGFYd0pxelFM?=
 =?utf-8?B?WEdjVFdmUURDVnovLzd6alg1WThUSHplWEF0ckRTeEFkYjVXeEF6OTU2WHdS?=
 =?utf-8?B?dGpzbWZRM3luUGhSY1kxZGZBMUZtRzl1VWZFRjR3WEZKRFR3UldHWDZpVUJs?=
 =?utf-8?B?eit6WVpCbzVHWmxzTm5JRnhKUjRtb0RGazZGYjNPUWVwbldDSUwvQ2VPRDZE?=
 =?utf-8?B?a3BlaHFJdkMyUDN4elE0cDB6Rm9GWElDWDVreFFZcTZqWlNNMFk5cTdsN2xk?=
 =?utf-8?B?WTl0V3Z6U2xGUWNlWlRkZ3dFd0tuam02dFBLOHczSmRSODF6bVFnVFFUL0dF?=
 =?utf-8?B?cXZhRDBGN0FnZmNJeWNQNDV2a2FsaW1GUGNFbnQ4cW1zOXg5bEJ2Z1NmL3FG?=
 =?utf-8?B?b2grNjFScnV5YnJpVUZmejlIa3doNkw2dm5HL3BDd0FxMndYTlkzL1Zoamk2?=
 =?utf-8?B?M0s4aGVrYmtrWjNORjMzQWFRb05SSUpBYmZBWklCOHFjREhwYzhNbHZVc1Qz?=
 =?utf-8?B?am9vSGoySkZVVlRkRHBERHpmMkN0OU5Wb1V0dnZ1SkRSeURYVjBYc0RmRXg0?=
 =?utf-8?B?WTlmQ250VzlaN29KcFhFR3l3cEhOeGFrc1cyaFZ2RUlRUHlFMXViN29NajdH?=
 =?utf-8?B?c1B4d3NwM0JsYmxMRTZnQmRRdVpGUkpTRWxhc3YrZmJpNE90ZnhpQjhpSGdu?=
 =?utf-8?B?MFlhS1NTb1QzMmNYSVJJcmxrWmNLdVRCSlJlUkE0K1NtTWU5dTd0ZkVuSmhC?=
 =?utf-8?B?dnN1U0MyeXljTUxLY0IyempWbTB6cmxhalRUQThlU245SlBFN2NlK3diYjkr?=
 =?utf-8?B?Mys1T3dpc2pxUVA0YmFWcEIvYVhsNmgrZ1pKR1lEZS9IR2VOOWZ0ellibWVE?=
 =?utf-8?Q?9HqGFPYQ9e6HxTYvEi1J4Aiql/0u1O7tAjk1O21?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2962ef8f-202a-4942-98ee-08d93b0333db
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 13:38:39.3871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAWFChsWHMQQlpYkp4NuZzh+l42/dwtQZ4sRSOek7RDtlXsjOTcqTdwvuzsVFWLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/25/2021 1:42 PM, Evan Quan wrote:
> Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
> uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
> 
> Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234 ++++++++++++------
>   2 files changed, 222 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> index 61c87c39be80..0b916a1933df 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
> @@ -211,6 +211,7 @@ typedef enum {
>   #define THROTTLER_FIT_BIT          17
>   #define THROTTLER_PPM_BIT          18
>   #define THROTTLER_APCC_BIT         19
> +#define THROTTLER_COUNT            20
>   
>   // FW DState Features Control Bits
>   // FW DState Features Control Bits
> @@ -1406,7 +1407,67 @@ typedef struct {
>   } SmuMetrics_t;
>   
>   typedef struct {
> -  SmuMetrics_t SmuMetrics;
> +  uint32_t CurrClock[PPCLK_COUNT];
> +
> +  uint16_t AverageGfxclkFrequencyPreDs;
> +  uint16_t AverageGfxclkFrequencyPostDs;
> +  uint16_t AverageFclkFrequencyPreDs;
> +  uint16_t AverageFclkFrequencyPostDs;
> +  uint16_t AverageUclkFrequencyPreDs  ;
> +  uint16_t AverageUclkFrequencyPostDs  ;
> +
> +
> +  uint16_t AverageGfxActivity    ;
> +  uint16_t AverageUclkActivity   ;
> +  uint8_t  CurrSocVoltageOffset  ;
> +  uint8_t  CurrGfxVoltageOffset  ;
> +  uint8_t  CurrMemVidOffset      ;
> +  uint8_t  Padding8        ;
> +  uint16_t AverageSocketPower    ;
> +  uint16_t TemperatureEdge       ;
> +  uint16_t TemperatureHotspot    ;
> +  uint16_t TemperatureMem        ;
> +  uint16_t TemperatureVrGfx      ;
> +  uint16_t TemperatureVrMem0     ;
> +  uint16_t TemperatureVrMem1     ;
> +  uint16_t TemperatureVrSoc      ;
> +  uint16_t TemperatureLiquid0    ;
> +  uint16_t TemperatureLiquid1    ;
> +  uint16_t TemperaturePlx        ;
> +  uint16_t Padding16             ;
> +  uint32_t AccCnt                ;
> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
> +
> +
> +  uint8_t  LinkDpmLevel;
> +  uint8_t  CurrFanPwm;
> +  uint16_t CurrFanSpeed;
> +
> +  //BACO metrics, PMFW-1721
> +  //metrics for D3hot entry/exit and driver ARM msgs
> +  uint8_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
> +
> +  //PMFW-4362
> +  uint32_t EnergyAccumulator;
> +  uint16_t AverageVclk0Frequency  ;
> +  uint16_t AverageDclk0Frequency  ;
> +  uint16_t AverageVclk1Frequency  ;
> +  uint16_t AverageDclk1Frequency  ;
> +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide full sequence
> +  uint8_t  PcieRate               ;
> +  uint8_t  PcieWidth              ;
> +  uint16_t AverageGfxclkFrequencyTarget;
> +  uint16_t Padding16_2;
> +
> +} SmuMetrics_V2_t;
> +
> +typedef struct {
> +  union {
> +    SmuMetrics_t SmuMetrics;
> +    SmuMetrics_V2_t SmuMetrics_V2;
> +  };
>     uint32_t Spare[1];
>   
>     // Padding - ignore
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 0c3407025eb2..f882c6756bf0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -80,6 +80,13 @@
>   		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, field));\
>   } while(0)
>   
> +#define GET_METRICS_MEMBER(field, member) do { \
> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu->smc_fw_version >= 0x3A4300)) \
> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu->smu_table.metrics_table))->SmuMetrics_V2)) + offsetof(SmuMetrics_V2_t, field)); \
> +	else \
> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu->smu_table.metrics_table))->SmuMetrics)) + offsetof(SmuMetrics_t, field)); \
> +} while(0)
> +
>   static int get_table_size(struct smu_context *smu)
>   {
>   	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)
> @@ -489,13 +496,33 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
>   	return -ENOMEM;
>   }
>   
> +static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *smu)
> +{
> +	struct smu_table_context *smu_table= &smu->smu_table;
> +	SmuMetricsExternal_t *metrics_ext =
> +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
> +	uint32_t throttler_status = 0;
> +	int i;
> +
> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
> +	     (smu->smc_fw_version >= 0x3A4300)) {
> +		for (i = 0; i < THROTTLER_COUNT; i++) {
> +			if (metrics_ext->SmuMetrics_V2.ThrottlingPercentage[i])
> +				throttler_status |= 1U << i;
> +		}
> +	} else {
> +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
> +	}
> +
> +	return throttler_status;
> +}
> +
>   static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   					       MetricsMember_t member,
>   					       uint32_t *value)
>   {
> -	struct smu_table_context *smu_table= &smu->smu_table;
> -	SmuMetrics_t *metrics =
> -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
> +	uint32_t *data_u32;
> +	uint16_t *data_u16;
>   	int ret = 0;
>   
>   	mutex_lock(&smu->metrics_lock);
> @@ -510,78 +537,100 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>   
>   	switch (member) {
>   	case METRICS_CURR_GFXCLK:
> -		*value = metrics->CurrClock[PPCLK_GFXCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);

One problem with this style is the need to track the datatype of each 
field. Why not use the old style?

metricsv1? metricsv1->field : metricsv2->field;

Thanks,
Lijo

> +		*value = data_u32[PPCLK_GFXCLK];
>   		break;
>   	case METRICS_CURR_SOCCLK:
> -		*value = metrics->CurrClock[PPCLK_SOCCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_SOCCLK];
>   		break;
>   	case METRICS_CURR_UCLK:
> -		*value = metrics->CurrClock[PPCLK_UCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_UCLK];
>   		break;
>   	case METRICS_CURR_VCLK:
> -		*value = metrics->CurrClock[PPCLK_VCLK_0];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_VCLK_0];
>   		break;
>   	case METRICS_CURR_VCLK1:
> -		*value = metrics->CurrClock[PPCLK_VCLK_1];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_VCLK_1];
>   		break;
>   	case METRICS_CURR_DCLK:
> -		*value = metrics->CurrClock[PPCLK_DCLK_0];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCLK_0];
>   		break;
>   	case METRICS_CURR_DCLK1:
> -		*value = metrics->CurrClock[PPCLK_DCLK_1];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCLK_1];
>   		break;
>   	case METRICS_CURR_DCEFCLK:
> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_DCEFCLK];
>   		break;
>   	case METRICS_CURR_FCLK:
> -		*value = metrics->CurrClock[PPCLK_FCLK];
> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
> +		*value = data_u32[PPCLK_FCLK];
>   		break;
>   	case METRICS_AVERAGE_GFXCLK:
> -		if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> -			*value = metrics->AverageGfxclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> +			GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs, &data_u16);
>   		else
> -			*value = metrics->AverageGfxclkFrequencyPreDs;
> +			GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	case METRICS_AVERAGE_FCLK:
> -		*value = metrics->AverageFclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	case METRICS_AVERAGE_UCLK:
> -		*value = metrics->AverageUclkFrequencyPostDs;
> +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	case METRICS_AVERAGE_GFXACTIVITY:
> -		*value = metrics->AverageGfxActivity;
> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	case METRICS_AVERAGE_MEMACTIVITY:
> -		*value = metrics->AverageUclkActivity;
> +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	case METRICS_AVERAGE_SOCKETPOWER:
> -		*value = metrics->AverageSocketPower << 8;
> +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> +		*value = *data_u16 << 8;
>   		break;
>   	case METRICS_TEMPERATURE_EDGE:
> -		*value = metrics->TemperatureEdge *
> +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> +		*value = *data_u16 *
>   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   		break;
>   	case METRICS_TEMPERATURE_HOTSPOT:
> -		*value = metrics->TemperatureHotspot *
> +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> +		*value = *data_u16 *
>   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   		break;
>   	case METRICS_TEMPERATURE_MEM:
> -		*value = metrics->TemperatureMem *
> +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> +		*value = *data_u16 *
>   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   		break;
>   	case METRICS_TEMPERATURE_VRGFX:
> -		*value = metrics->TemperatureVrGfx *
> +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> +		*value = *data_u16 *
>   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   		break;
>   	case METRICS_TEMPERATURE_VRSOC:
> -		*value = metrics->TemperatureVrSoc *
> +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> +		*value = *data_u16 *
>   			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>   		break;
>   	case METRICS_THROTTLER_STATUS:
> -		*value = metrics->ThrottlerStatus;
> +		*value = sienna_cichlid_get_throttler_status_locked(smu);
>   		break;
>   	case METRICS_CURR_FANSPEED:
> -		*value = metrics->CurrFanSpeed;
> +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> +		*value = *data_u16;
>   		break;
>   	default:
>   		*value = UINT_MAX;
> @@ -3564,68 +3613,103 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>   	struct smu_table_context *smu_table = &smu->smu_table;
>   	struct gpu_metrics_v1_3 *gpu_metrics =
>   		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
> -	SmuMetricsExternal_t metrics_external;
> -	SmuMetrics_t *metrics =
> -		&(metrics_external.SmuMetrics);
> -	struct amdgpu_device *adev = smu->adev;
> -	uint32_t smu_version;
> +	uint32_t *data_u32;
> +	uint16_t *data_u16;
> +	uint8_t *data_u8;
>   	int ret = 0;
>   
> -	ret = smu_cmn_get_metrics_table(smu,
> -					&metrics_external,
> -					true);
> -	if (ret)
> +	mutex_lock(&smu->metrics_lock);
> +
> +	ret = smu_cmn_get_metrics_table_locked(smu,
> +					       NULL,
> +					       true);
> +	if (ret) {
> +		mutex_unlock(&smu->metrics_lock);
>   		return ret;
> +	}
>   
>   	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
> -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
> -	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
> -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
> -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
> -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
> -	gpu_metrics->temperature_vrmem = metrics->TemperatureVrMem0;
> +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
> +	gpu_metrics->temperature_edge = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
> +	gpu_metrics->temperature_hotspot = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
> +	gpu_metrics->temperature_mem = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
> +	gpu_metrics->temperature_vrgfx = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
> +	gpu_metrics->temperature_vrsoc = *data_u16;
> +
> +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
> +	gpu_metrics->temperature_vrmem = *data_u16;
>   
> -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
> -	gpu_metrics->average_mm_activity = metrics->VcnActivityPercentage;
> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +	gpu_metrics->average_gfx_activity = *data_u16;
>   
> -	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
> -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
> +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
> +	gpu_metrics->average_umc_activity = *data_u16;
>   
> -	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> -		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
> +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
> +	gpu_metrics->average_mm_activity = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
> +	gpu_metrics->average_socket_power = *data_u16;
> +
> +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
> +	gpu_metrics->energy_accumulator = *data_u32;
> +
> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
> +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs, &data_u16);
>   	else
> -		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
> -	gpu_metrics->average_uclk_frequency = metrics->AverageUclkFrequencyPostDs;
> -	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
> -	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
> -	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
> -	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
> -
> -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
> -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
> -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
> -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
> -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
> -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
> -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
> -
> -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs, &data_u16);
> +	gpu_metrics->average_gfxclk_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
> +	gpu_metrics->average_uclk_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
> +	gpu_metrics->average_vclk0_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
> +	gpu_metrics->average_dclk0_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
> +	gpu_metrics->average_vclk1_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
> +	gpu_metrics->average_dclk1_frequency = *data_u16;
> +
> +	GET_METRICS_MEMBER(CurrClock, &data_u32);
> +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
> +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
> +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
> +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
> +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
> +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
> +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
> +
> +	gpu_metrics->throttle_status =
> +			sienna_cichlid_get_throttler_status_locked(smu);
>   	gpu_metrics->indep_throttle_status =
> -			smu_cmn_get_indep_throttler_status(metrics->ThrottlerStatus,
> +			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
>   							   sienna_cichlid_throttler_map);
>   
> -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
> +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
> +	gpu_metrics->current_fan_speed = *data_u16;
>   
> -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> -	if (ret)
> -		return ret;
> +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu->smc_fw_version > 0x003A1E00) ||
> +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu->smc_fw_version > 0x00410400)) {
> +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
> +		gpu_metrics->pcie_link_width = *data_u8;
>   
> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
> -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
> -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
> +		GET_METRICS_MEMBER(PcieRate, &data_u8);
> +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
>   	} else {
>   		gpu_metrics->pcie_link_width =
>   				smu_v11_0_get_current_pcie_link_width(smu);
> @@ -3633,6 +3717,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>   				smu_v11_0_get_current_pcie_link_speed(smu);
>   	}
>   
> +	mutex_unlock(&smu->metrics_lock);
> +
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
