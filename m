Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC4C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:47:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9732613D6
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 09:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9732613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A626E09A;
	Thu, 13 May 2021 09:47:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D9E6E09A
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 09:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkF0fcqQ9BY+8kBdQV7hLtwx70L0vEEyN8vBqSP+8KPNVxlCyVOeNxnvVBMIJEtSnbFC1E93PozvI6B9F77Hs1YjcSfFei8+/41da8LQmCcMSm1Hq+DHJJbY9PYG9haWxBTE++qw6xFa49upMo7svCaZFGzJ0zKR5pFnwJfLp2IS5CGqePbynM7Jsu/4aGXYsP63UQI69teh9rytmAp9bHnqSHugsfp0x0ZcU00NFpu/+X0TAkHe1yQHj+JN0nbvBR9WYZl9OmFwCKAw4f+fuoTYjtRgrJPzcZPGqsJA8fYe+kCA5BBM2Ns9W3ykQ6DLPkP9maFzCls5+sJHzDE1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCbuzNAQYjrnWodQmI09TYMWTYY04JCWXP84xALsnW8=;
 b=m6jZHIgFOXDg99uzJnrZ6L9aJv759YYN9+4abf9WqlMkI6fggbvfoIWFzXCC96xEVXLPpY7ZFvnkAF0D3KMpjJhCfyl+GVMJA9sT7a9X0AWUESTdnmgWoJnSOEki8Bjhj7vl6sRD00S1OSRr5P3y5HGJrbSgnQNL7m5ouE/UJ0wLZPGLFCsvYjGXKEXkNBfk9PgYxQdEkZXdd3e7SZFVdxior1tdO3u6KnoFPKA4yXXneYzKNfqbzNsouxg5KAiX9FGT9965bY3e3reSqyrQsRmw7YQrY5zYBSoeBs7AZD1DVYio+1lr2bmES/XFoVEBZS7pXtmChcnPEQ9X8+oMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCbuzNAQYjrnWodQmI09TYMWTYY04JCWXP84xALsnW8=;
 b=NFG+sIWgR2EyxaadDm+G7FqXyS5WY+F1DkwMy5aoBRLmcHgiifyvZLSKXc6WO67/aHDIeHGO2FuhAzMX2PEbm2xW4DmlILiZeeAqnPuKMea69kvYvV0Vu2TlL9PvME4Bpp2J52LuGBLCi+oIr6DPJWsovPuTENi2KVJifBPuDE0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 09:47:46 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 09:47:46 +0000
To: amd-gfx@lists.freedesktop.org
From: Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Fix showing incorrect frequencies on aldebaran
Message-ID: <cb35e9cc-26cf-c9e7-b747-c24920d788d6@amd.com>
Date: Thu, 13 May 2021 15:17:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.39.107] (165.204.159.242) by
 BMXPR01CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 09:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103f73b8-3b9a-467c-f5e8-08d915f42975
X-MS-TrafficTypeDiagnostic: CH0PR12MB5299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52992475306AF4BACCC73A3697519@CH0PR12MB5299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXATI6Tbxa2RFO5CrFbTDsV508d8+C08yfkrKHDd+CSdJKLyIRWGvHpsMrSbWgXi8SSI499VZD8SFQZHhHzSjOnHu3JgKTRlt7QD2whoU9/dq98xUh9j4kHAb347NlCdZVl/TTAGJIw+njfa5s4fpLDQwmZmULsNg7W5dcO5aDZ4swlpLRtAUuZZE35mOI1PRtk6LrSmnVXibzJVTvqAA6OttxFt3ebHJ8ss4qiLogzGKcHeocmQpf9hEjUXD6nmJBl2/IDLVWFBM/VX0vlHtoaNwGfhqIttSt1FWXhlEe6mOodC7tdLxdD7qdzYh29hlYD3OLz/zdNZeqXxWo+IHs+dqbSFbYL99NdkArQGoVpm/0LNIWb1mfmqu2cf42oDEI051Hw5FOSluXPK0Sl746moKzojmyUNSrQ4jj3FZLM25vmbdU0jnLaCSfxNL/pWPoWulhFYrHsjkz7xfFEBenBMKOpwWeusXJ6yvnviokGDSsPfVwsHsrE2V1NZhxhNqyAhg8dsmFTF4h/pEHbpD9uiSirA7FrxLH1it7ReWQyDXQjRGjWktQXmIh0QrZIyrJO1IifXkwv1UXkvEoK8f/vUv8MFTF6Lxc6PHvb27NZlC29m2nl1uTN3iPqRl1/eMmL2Ea1oJbk8I1KEvQdeix7q5JETtyimbelcnlb7OwRk4eCPlniWZG9U6R7lATBHZRqOuXaS6V+F3DxLj2U5yCOgYJF9NAQg3eGTuNReaQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(44832011)(956004)(2616005)(31686004)(36756003)(6486002)(5660300002)(16526019)(16576012)(6916009)(478600001)(186003)(31696002)(66946007)(316002)(86362001)(26005)(66476007)(38100700002)(38350700002)(8676002)(6666004)(2906002)(52116002)(66556008)(54906003)(4326008)(83380400001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVpMQUhjMnJ2Kzk2L2crWVJsczVScWhIeDRBTFNvT3kyekxiNFZRNlM3bE9a?=
 =?utf-8?B?ZVhpWE91ZkFsb3BVeVFnWjBJWG5LZG0xajA2OTVWRjhkUm1rUXMxMnYxMW1R?=
 =?utf-8?B?dlRzYWl4YlhEcXZ0NFRmcURkbS9zc0dBeHdTbGd0Z3FtSEVlY0lVdW5ucGMy?=
 =?utf-8?B?NXNhRGptNmlhN01TTmxwcXVDb2lrdnAybUxLNkhQUklTVEtuUDNob3dQczQx?=
 =?utf-8?B?QkFBYkhaNzR0OXE2bUlWNFlBaWsvOHlhamlqVW9WcnBIbnVMUmF5V2NsVVhL?=
 =?utf-8?B?K0hCR3c3TG1zUlFZM0Z2T1h6Ukx4cTArWnhqMTlrZlk0cXRxcjhTQnowU1B5?=
 =?utf-8?B?T1VPS0JFWjdQdWFKTnZoUFFPK0pTNHEybTZ2ditSakh2R2hkRFN3Z0F0US9h?=
 =?utf-8?B?WjdPaytQdG1mQ0RPMU5JYTdaQXp1MFV5N2xMaEFZWDVGcXBNcjhQY2E0UW05?=
 =?utf-8?B?OWJTZnhEQ0grVUx4NmFBWDhZanFWQ2ozZ2d0d0ZXdlJEYW5TZnFUSWpzdldO?=
 =?utf-8?B?MlZLMk8xandTVHk4cERYd1dWUGtPSVF0YmlKVHNMdzczZzM5a1FEcG1lcEpT?=
 =?utf-8?B?UUtWaUlpQWE4SEdoYitEa0ZrTFVKc1d5Qm9xQVBpSGdNQmZ4MUJSc3YwbFla?=
 =?utf-8?B?eUVJZTU0U3RtR2ErWjArcGFzRGlETERpNG9JRzQrSzNRRTFHTzVqWTh1WVU1?=
 =?utf-8?B?OTRUUWJUN3FCL3JkWGNPSHhWZXhEWW5PL1ZXZ21EQ1VWeEFNaXNBRU1ZKzFG?=
 =?utf-8?B?dnJsdDE5V0E1RmFNM0RsTnlTdW9LUUk3Q0tNK3VjelpLNXZDamQvWkswQWc5?=
 =?utf-8?B?U2hKVFdmKzdpSTNET29jWWFPdndtYUUya2pRTUFjNFlNSHlFaENjOUhvVEJW?=
 =?utf-8?B?Nmw4OVc0NFVUZmdQOFFNRTA5blNIVjZ5aGtUZWZZNmdleXBJaTBscTBZWkJ1?=
 =?utf-8?B?WlUyNFZCSmh2M0lJdG95a29sVkROOFF1MWp6Wk1uanE2dDRaZDlaRGtiQW9a?=
 =?utf-8?B?cmNUaGtTVUVEcHBocm8rck1FcS9RdXpBNHNWc1N5Uzg4WW9XSXdPeTFzTEw5?=
 =?utf-8?B?Y1g5YnppU1dTc0JrR0YreEgzc2J0c0w0T09PcVI4blJ5aTYwcTNIRHFzb0Jh?=
 =?utf-8?B?RHMycEQ3RWUyV0VNNnVmTWErTFFtZHNhRHpPVXdSNGoyVkN2d01QTXZEdnFS?=
 =?utf-8?B?Wmc0MVlpNVZ1cUZSM1dMNDhrWTBDNDRsTVJpeFhFdmg5S0xYUSswZ2tNbXVR?=
 =?utf-8?B?N0V4TThBeG9XYnRoMmh3ZEVzcnRTem1rMlhKMk9ZR0sraFFwSlNRd0JyTFFw?=
 =?utf-8?B?WlFkY3RoL0JULzR5OHhCdnlxVDRJUTR0Z3NKdzJ6NjJrT2Z4bXl6aHdFeW41?=
 =?utf-8?B?WE5iemZvL2IrVjgwRTJ3a2VNQlRhSzNORXlRaUMycE5rZWY5dFlLcER1aVB2?=
 =?utf-8?B?NjQ3a1pZM2ZuTHl5Uyt5akpRVGVWaDBiTElnVXRxTTFHZllpeHhuZnU2ZzJH?=
 =?utf-8?B?QVhWUVlxVi83cm0xd1hzaFd3U0ZhYUJZbFpmUDVBUTJUSXROb2VMNDBLbTM1?=
 =?utf-8?B?WWYzU1oxTmk5ZFZUYjRkMENIMWJXemtNdWZGMHowSWVrbXAxV1ZxczhCbVJt?=
 =?utf-8?B?SGYzczR2VHRPOFlaN3FaYVJMMDVUVnJjeWwzYzU5aUtVdDdqRGJvZWFBbkNw?=
 =?utf-8?B?YlhlTTNycW5GZGJwaUh1aTIwdVFXSDJma3h6UktETUZ4dktabWsralRHR1Ro?=
 =?utf-8?Q?fth7dp6m460seFn2i5PK/yFQ0pBN8Un/aM1P17U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103f73b8-3b9a-467c-f5e8-08d915f42975
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 09:47:46.3138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pdAznpB5J4F3GnY3cep0TRGc42xKqaGhCzQ1rKoXtOzJPyJwBRCa9u92DTfXgvX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Use the current and custom pstate frequencies to track the current and
user-set min/max values in manual and determinism mode. Previously, only
actual_* value was used to track the currrent and user requested value.
The value will get reassigned whenever user requests a new value with
pp_od_clk_voltage node. Hence it will show incorrect values when user
requests an invalid value or tries a partial request without committing
the values. Separating out to custom and current variable fixes such
issues.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 65 ++++++++++++-------
  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 18 ++++-
  2 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 5d04a1dfdfd8..d27ed2954705 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -78,8 +78,6 @@

  #define smnPCIE_ESM_CTRL			0x111003D0

-#define CLOCK_VALID (1 << 31)
-
  static const struct cmn2asic_msg_mapping 
aldebaran_message_map[SMU_MSG_MAX_COUNT] = {
  	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
  	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -455,12 +453,18 @@ static int aldebaran_populate_umd_state_clk(struct 
smu_context *smu)

  	pstate_table->gfxclk_pstate.min = gfx_table->min;
  	pstate_table->gfxclk_pstate.peak = gfx_table->max;
+	pstate_table->gfxclk_pstate.curr.min = gfx_table->min;
+	pstate_table->gfxclk_pstate.curr.max = gfx_table->max;

  	pstate_table->uclk_pstate.min = mem_table->min;
  	pstate_table->uclk_pstate.peak = mem_table->max;
+	pstate_table->uclk_pstate.curr.min = mem_table->min;
+	pstate_table->uclk_pstate.curr.max = mem_table->max;

  	pstate_table->socclk_pstate.min = soc_table->min;
  	pstate_table->socclk_pstate.peak = soc_table->max;
+	pstate_table->socclk_pstate.curr.min = soc_table->min;
+	pstate_table->socclk_pstate.curr.max = soc_table->max;

  	if (gfx_table->count > ALDEBARAN_UMD_PSTATE_GFXCLK_LEVEL &&
  	    mem_table->count > ALDEBARAN_UMD_PSTATE_MCLK_LEVEL &&
@@ -669,6 +673,7 @@ static int aldebaran_print_clk_levels(struct 
smu_context *smu,
  {
  	int i, now, size = 0;
  	int ret = 0;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	struct pp_clock_levels_with_latency clocks;
  	struct smu_13_0_dpm_table *single_dpm_table;
  	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -703,12 +708,8 @@ static int aldebaran_print_clk_levels(struct 
smu_context *smu,

  		display_levels = clocks.num_levels;

-		min_clk = smu->gfx_actual_hard_min_freq & CLOCK_VALID ?
-				  smu->gfx_actual_hard_min_freq & ~CLOCK_VALID :
-				  single_dpm_table->dpm_levels[0].value;
-		max_clk = smu->gfx_actual_soft_max_freq & CLOCK_VALID ?
-				  smu->gfx_actual_soft_max_freq & ~CLOCK_VALID :
-				  single_dpm_table->dpm_levels[1].value;
+		min_clk = pstate_table->gfxclk_pstate.curr.min;
+		max_clk = pstate_table->gfxclk_pstate.curr.max;

  		freq_values[0] = min_clk;
  		freq_values[1] = max_clk;
@@ -1134,9 +1135,6 @@ static int aldebaran_set_performance_level(struct 
smu_context *smu,
  			&& (level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM))
  		smu_cmn_send_smc_msg(smu, SMU_MSG_DisableDeterminism, NULL);

-	/* Reset user min/max gfx clock */
-	smu->gfx_actual_hard_min_freq = 0;
-	smu->gfx_actual_soft_max_freq = 0;

  	switch (level) {

@@ -1163,6 +1161,7 @@ static int 
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  {
  	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
  	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	struct amdgpu_device *adev = smu->adev;
  	uint32_t min_clk;
  	uint32_t max_clk;
@@ -1176,14 +1175,20 @@ static int 
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  		return -EINVAL;

  	if (smu_dpm->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
-		min_clk = max(min, dpm_context->dpm_tables.gfx_table.min);
-		max_clk = min(max, dpm_context->dpm_tables.gfx_table.max);
-		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,
-							    min_clk, max_clk);
+		if (min >= max) {
+			dev_err(smu->adev->dev,
+				"Minimum GFX clk should be less than the maximum allowed clock\n");
+			return -EINVAL;
+		}

+		if ((min == pstate_table->gfxclk_pstate.curr.min) &&
+		    (max == pstate_table->gfxclk_pstate.curr.max))
+			return 0;
+		ret = smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXCLK,
+							    min, max);
  		if (!ret) {
-			smu->gfx_actual_hard_min_freq = min_clk | CLOCK_VALID;
-			smu->gfx_actual_soft_max_freq = max_clk | CLOCK_VALID;
+			pstate_table->gfxclk_pstate.curr.min = min;
+			pstate_table->gfxclk_pstate.curr.max = max;
  		}
  		return ret;
  	}
@@ -1209,10 +1214,8 @@ static int 
aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
  				dev_err(adev->dev,
  						"Failed to enable determinism at GFX clock %d MHz\n", max);
  			} else {
-				smu->gfx_actual_hard_min_freq =
-					min_clk | CLOCK_VALID;
-				smu->gfx_actual_soft_max_freq =
-					max | CLOCK_VALID;
+				pstate_table->gfxclk_pstate.curr.min = min_clk;
+				pstate_table->gfxclk_pstate.curr.max = max;
  			}
  		}
  	}
@@ -1225,6 +1228,7 @@ static int aldebaran_usr_edit_dpm_table(struct 
smu_context *smu, enum PP_OD_DPM_
  {
  	struct smu_dpm_context *smu_dpm = &(smu->smu_dpm);
  	struct smu_13_0_dpm_context *dpm_context = smu_dpm->dpm_context;
+	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
  	uint32_t min_clk;
  	uint32_t max_clk;
  	int ret = 0;
@@ -1245,16 +1249,20 @@ static int aldebaran_usr_edit_dpm_table(struct 
smu_context *smu, enum PP_OD_DPM_
  			if (input[1] < dpm_context->dpm_tables.gfx_table.min) {
  				dev_warn(smu->adev->dev, "Minimum GFX clk (%ld) MHz specified is 
less than the minimum allowed (%d) MHz\n",
  					input[1], dpm_context->dpm_tables.gfx_table.min);
+				pstate_table->gfxclk_pstate.custom.min =
+					pstate_table->gfxclk_pstate.curr.min;
  				return -EINVAL;
  			}
-			smu->gfx_actual_hard_min_freq = input[1];
+			pstate_table->gfxclk_pstate.custom.min = input[1];
  		} else if (input[0] == 1) {
  			if (input[1] > dpm_context->dpm_tables.gfx_table.max) {
  				dev_warn(smu->adev->dev, "Maximum GFX clk (%ld) MHz specified is 
greater than the maximum allowed (%d) MHz\n",
  					input[1], dpm_context->dpm_tables.gfx_table.max);
+				pstate_table->gfxclk_pstate.custom.max =
+					pstate_table->gfxclk_pstate.curr.max;
  				return -EINVAL;
  			}
-			smu->gfx_actual_soft_max_freq = input[1];
+			pstate_table->gfxclk_pstate.custom.max = input[1];
  		} else {
  			return -EINVAL;
  		}
@@ -1276,8 +1284,15 @@ static int aldebaran_usr_edit_dpm_table(struct 
smu_context *smu, enum PP_OD_DPM_
  			dev_err(smu->adev->dev, "Input parameter number not correct\n");
  			return -EINVAL;
  		} else {
-			min_clk = smu->gfx_actual_hard_min_freq;
-			max_clk = smu->gfx_actual_soft_max_freq;
+			if (!pstate_table->gfxclk_pstate.custom.min)
+				pstate_table->gfxclk_pstate.custom.min =
+					pstate_table->gfxclk_pstate.curr.min;
+			if (!pstate_table->gfxclk_pstate.custom.max)
+				pstate_table->gfxclk_pstate.custom.max =
+					pstate_table->gfxclk_pstate.curr.max;
+			min_clk = pstate_table->gfxclk_pstate.custom.min;
+			max_clk = pstate_table->gfxclk_pstate.custom.max;
+
  			return aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, 
min_clk, max_clk);
  		}
  		break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 0864083e7435..755bddaf6c4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1624,8 +1624,12 @@ int smu_v13_0_set_performance_level(struct 
smu_context *smu,
  							    SMU_GFXCLK,
  							    sclk_min,
  							    sclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->gfxclk_pstate.curr.min = sclk_min;
+			pstate_table->gfxclk_pstate.curr.max = sclk_max;
+		}
  	}

  	if (mclk_min && mclk_max) {
@@ -1633,8 +1637,12 @@ int smu_v13_0_set_performance_level(struct 
smu_context *smu,
  							    SMU_MCLK,
  							    mclk_min,
  							    mclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->uclk_pstate.curr.min = mclk_min;
+			pstate_table->uclk_pstate.curr.max = mclk_max;
+		}
  	}

  	if (socclk_min && socclk_max) {
@@ -1642,8 +1650,12 @@ int smu_v13_0_set_performance_level(struct 
smu_context *smu,
  							    SMU_SOCCLK,
  							    socclk_min,
  							    socclk_max);
-		if (ret)
+		if (ret) {
  			return ret;
+		} else {
+			pstate_table->socclk_pstate.curr.min = socclk_min;
+			pstate_table->socclk_pstate.curr.max = socclk_max;
+		}
  	}

  	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
