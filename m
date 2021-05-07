Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5893EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A31613F1
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A31613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6F06EE4A;
	Fri,  7 May 2021 14:59:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8126EE48
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:59:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzAQ7uYyhiUJODk5llXKknOOOnK/Ja44P8Da4vlGthFiR4tHfm5H2JPdiZ3sCS/MhllsE8sY4oYUJSViKiy52hitlk1waPeLlHvXmj0c637s6VkuC9RJkA0PYroKW9EjXZ2zevkVk5Y91n2ekb5Ql7YubUEmMkLCqrJ18k5lkxfe3VP7bhw+3sjoCf7DrFJfwm3E9cZO7sa0doM1/9t79mf7HmcyuzXQlEud1AVwwd1FlYe7IhJLQ/6fs7peGay5V8YKUF//Mz45IUU3c6vDCfMAIkofgn24Y+89s/yT3sriweNVEX8BH1AlyYip9Iq/ohxV9bEP22tqreWrjyszZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVZWljZTN1DFlxRGv6bcngPmvB0Ro3EzRf3bsglOxRY=;
 b=WZ0rHHTO2mY576m2IhtT2sW6f/MBGCkpCdOOIgMZUOJuUghrAZW4amyl4rT/bZAxETkLROyY5WF47b1b/wnUnDzFLCGwVHuSgu00uOA45JxmUsKdLfsIPrxBQra1TGV85lm2XQnxMy5BpLULHenktsDQehif4mnWLnVNkGzn7GZYO4LvdWJMMSZJfn8YrT50NWK4k4YJWgDwjvMwYqNEF8I+YmoO1XBw2qg0yKPswI7rn1Rr+COHqVowd8cCSu0xNIANbYW/mx04+/1Yl6u8e4jAsrSxi5lcRvS+IMqBnpuyy3jzQFb1eVQRwKS4LuQlmILUv8j75TQVE7Y/TlNLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVZWljZTN1DFlxRGv6bcngPmvB0Ro3EzRf3bsglOxRY=;
 b=JK5olKZRKhTYPGqmmEFR6vsMXpA0xN/Y9bT1pUs0JLgIGlT5g/iLOi6r6hmsUWoAkkCV8sAxHZG4xJ9aDrCYrGW2Daret20aylRz3hyetpfUtVXT7rJwfTa3AravHaIBBFkAlWVwoz+Oq39TLLfGDvTGZUKh8kBtTUZo6gz0E+4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 14:59:47 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4087.044; Fri, 7 May 2021
 14:59:47 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/14] drm/amd/display: Fix clock table filling logic
Date: Fri,  7 May 2021 22:58:16 +0800
Message-Id: <20210507145822.248029-9-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210507145822.248029-1-stylon.wang@amd.com>
References: <20210507145822.248029-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR04CA0045.apcprd04.prod.outlook.com
 (2603:1096:202:14::13) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR04CA0045.apcprd04.prod.outlook.com (2603:1096:202:14::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 14:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35e82aeb-904c-454d-ff7a-08d91168c15f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1786:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1786C96A7A02F84EB39DD848FF579@DM5PR12MB1786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ekb/q0ZoA4TN85kqq6rthhJHpIs/1nYFE5fHC6oSdZa63w9/O7qVaL3tfEeJ1Ot42cowoCExwpzlbnynfdswwPV4Sd3Cg1hqOa2cnFVW3mwBr5vouNjT9LV6EfDqRsqxl++zkHBmWMOYbDEw2WlmzpvarcQylNyP52Nf9BV1pUZ51GAQx/DopzdN9e2E9jYI0eDVff+6VJS4LsPqaiVK6gwtdH0ujQl/KQApiw/ZnAMKX943yo0pOdJZm4q8VE/yTwP4P91Lu5EpUMxWQ04zZCAi1UQB9iH5W59T2ZsNHwSQqB4p4AiBEGwQMwHc/eUAg3JisnIujfUWlDevOA5zV8Ed7UWvpztmycqOiE4jlxGXxzxrzgrxeVd8DatOBQ52LWfaG6xhoOyvXRGd7QvYl1Bj7z14YFh863StPt751a2R9EoBNLEUz+pTL9FL8ZMpeVwfleMnvJIACRiWt3l8jvQFg557XrLkixK1+CcLX/TSEqHAZWxgilQObom6TqprMWmtPK19BavZ7y72eZuNckBu3VrCjke7G+46Up6E3slQzkfq2az3PBfo43Hw0ux44cvbuFo9P826FPCdd2Tafi5BVx1523I4dA8jnOvC8gwSBhxz0O7alqP5zJBlgdJTIGjhvxW+S7j8iMIKx5Ys+03owBVEkmqPQUX+q6f8xak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66556008)(66476007)(66946007)(6486002)(54906003)(83380400001)(26005)(6666004)(16526019)(86362001)(956004)(38350700002)(38100700002)(316002)(4326008)(186003)(478600001)(2906002)(6916009)(5660300002)(52116002)(7696005)(8936002)(1076003)(8676002)(36756003)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w8EuYWwycei8/gAg534fy7rcPq5DK6CVhbZ5fGzB9/Wp/syMWhU7geGycvCr?=
 =?us-ascii?Q?96Y9tqJ9FsGNz8oQhAGxiVw3uKOSrZmEy+mZ+bMRd7eC1heysOODKUspkd5X?=
 =?us-ascii?Q?mQ1KTa4fhosjo4I4vtE9iRb1hBbRjG6Csrd2j8dhYfJZALDck2KrhbZwNpSw?=
 =?us-ascii?Q?jadq26r+F4nncElGmqktlxLlFf4CMN0vl+g/eMb3j6onnxqAVvUXI2FQh07v?=
 =?us-ascii?Q?nl+Jhy3uDgY1ejQspqlJeEMZP8i5e3rN4PqHQZaCIiEydJ4ZRHFeG8RR7F/Z?=
 =?us-ascii?Q?b8xHCNZJIZfh1LSM4lvnSrQ0J+i/bL/rxqPtljcQ2A2pYz6iyh6efWAVC9I/?=
 =?us-ascii?Q?4IOWz97Yu2LKgHo+oa7nBHtAho/VzcHqT94/OgwHOzLmJRfhMcteaC1GH6Od?=
 =?us-ascii?Q?04ZwiSRKBffSesG9mmMTTKuESng6m51mjr/PS4oZfTbBH0fESVNQ3VddQZ/D?=
 =?us-ascii?Q?skOqtuw+BBMM32J7QkMXe0HtALL54mxnQIUFkTHm5uezIyR1xryn1UffhTFB?=
 =?us-ascii?Q?rW58tjlkwPe4Eg9CKi5qKSBW2XeUpkG/hQ8+g1/g9kqVlwMbPanQGt6S0q2u?=
 =?us-ascii?Q?B9hd6BJtVwRqM3b1VedU2No1tcHQjLPuO6XqjMDwrWSv+jiin4OrMw/M6jSH?=
 =?us-ascii?Q?iWZho5S8XKAgHxb0CbjCpXSnH+YvGgeNGrvvvJN8bWGLo9nxbKM8S15opLAk?=
 =?us-ascii?Q?4eVeECWyOEKDZPsI9zuU2KhlAZKhJ2bxokoLlumwkN9TIKTKTDGZ00xg8DFF?=
 =?us-ascii?Q?xHRxwhT6Yqm/4vYvnjNHEcBDaG9ck6/mttR8I6M/EEm3B99VW8kkn+RmIhuC?=
 =?us-ascii?Q?SKMDFPtoIzXXU/8a/Tfcdz219T0vrYV9irHI4BARNlgVWJBwsEsv6pV/Zv8e?=
 =?us-ascii?Q?OomnINHffeiqYjTwSQqr3DM+/COu09xOkzvvtz6eJf0NpPlNsg9j+xXWMKek?=
 =?us-ascii?Q?amtiNPQpB0KVDrGERRrS0ej9K1A1hc3Uwm5U9zt+9PzfXeBzTUfqKNP6mIlN?=
 =?us-ascii?Q?xFSgVxtQlcT4pc7SO9dS2P5wL5NC9m/c2kRp1WIZFBCA0L5FRd3Q+K9bqVoK?=
 =?us-ascii?Q?laXzXnSA8uIhcvrfcq5fve0OMTGuw0+CggngwDD0d9RvdWRcvsdRfHt+mB4e?=
 =?us-ascii?Q?35sS55KVjKthbl9E+f1D9NXieVxW0KeT9WB9fXl37zVPkmluphiaouzNJQNM?=
 =?us-ascii?Q?CnnLNELGJfLjxLeXJBJZgx8mhwwf5aU57jKdZuS3dnvQ5EDzUJeF/NY2Gfl2?=
 =?us-ascii?Q?jIoGNJBFIqxOyY9IyYCblLRa6vhn9RU4UsfEn7iHjNKy0Y3Wld9LEsuWPxAS?=
 =?us-ascii?Q?jSxxgTxWtKDcaKyKO/4k9R4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e82aeb-904c-454d-ff7a-08d91168c15f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:59:47.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzYHLNySyFMdCf5Zp/Y6d+dvPpvsd8SkmuxHtjsL1MEjlYecC9IE7D8hsj2J0+5qi5sVqHPBP/OQS5KS8+tyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
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
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Currently, the code that fills the clock table can miss filling
information about some of the higher voltage states advertised
by the SMU. This, in turn, may cause some of the higher pixel clock
modes (e.g. 8k60) to fail validation.

[How]
Fill the table with one entry per DCFCLK level instead of one entry
per FCLK level. This is needed because the maximum FCLK does not
necessarily need maximum voltage, whereas DCFCLK values from SMU
cover the full voltage range.

Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 80 ++++++++++++-------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 33 +++++---
 2 files changed, 74 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 887a54246bde..c2d0f68dbdcc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -797,46 +797,67 @@ static struct wm_table lpddr4_wm_table_rn = {
 		},
 	}
 };
-static unsigned int find_socclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
+
+static unsigned int find_max_fclk_for_voltage(struct dpm_clocks *clock_table,
+		unsigned int voltage)
 {
 	int i;
+	uint32_t max_clk = 0;
 
-	for (i = 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
-		if (clock_table->SocClocks[i].Vol == voltage)
-			return clock_table->SocClocks[i].Freq;
+	for (i = 0; i < PP_SMU_NUM_FCLK_DPM_LEVELS; i++) {
+		if (clock_table->FClocks[i].Vol <= voltage) {
+			max_clk = clock_table->FClocks[i].Freq > max_clk ?
+				clock_table->FClocks[i].Freq : max_clk;
+		}
 	}
 
-	ASSERT(0);
-	return 0;
+	return max_clk;
 }
-static unsigned int find_dcfclk_for_voltage(struct dpm_clocks *clock_table, unsigned int voltage)
+
+static unsigned int find_max_memclk_for_voltage(struct dpm_clocks *clock_table,
+		unsigned int voltage)
 {
 	int i;
+	uint32_t max_clk = 0;
 
-	for (i = 0; i < PP_SMU_NUM_DCFCLK_DPM_LEVELS; i++) {
-		if (clock_table->DcfClocks[i].Vol == voltage)
-			return clock_table->DcfClocks[i].Freq;
+	for (i = 0; i < PP_SMU_NUM_MEMCLK_DPM_LEVELS; i++) {
+		if (clock_table->MemClocks[i].Vol <= voltage) {
+			max_clk = clock_table->MemClocks[i].Freq > max_clk ?
+				clock_table->MemClocks[i].Freq : max_clk;
+		}
 	}
 
-	ASSERT(0);
-	return 0;
+	return max_clk;
+}
+
+static unsigned int find_max_socclk_for_voltage(struct dpm_clocks *clock_table,
+		unsigned int voltage)
+{
+	int i;
+	uint32_t max_clk = 0;
+
+	for (i = 0; i < PP_SMU_NUM_SOCCLK_DPM_LEVELS; i++) {
+		if (clock_table->SocClocks[i].Vol <= voltage) {
+			max_clk = clock_table->SocClocks[i].Freq > max_clk ?
+				clock_table->SocClocks[i].Freq : max_clk;
+		}
+	}
+
+	return max_clk;
 }
 
 static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params, struct dpm_clocks *clock_table, struct integrated_info *bios_info)
 {
 	int i, j = 0;
+	unsigned int volt;
 
 	j = -1;
 
-	ASSERT(PP_SMU_NUM_FCLK_DPM_LEVELS <= MAX_NUM_DPM_LVL);
-
-	/* Find lowest DPM, FCLK is filled in reverse order*/
-
-	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
+	/* Find max DPM */
+	for (i = 0; i < PP_SMU_NUM_DCFCLK_DPM_LEVELS; ++i) {
+		if (clock_table->DcfClocks[i].Freq != 0 &&
+				clock_table->DcfClocks[i].Vol != 0)
 			j = i;
-			break;
-		}
 	}
 
 	if (j == -1) {
@@ -847,13 +868,18 @@ static void rn_clk_mgr_helper_populate_bw_params(struct clk_bw_params *bw_params
 
 	bw_params->clk_table.num_entries = j + 1;
 
-	for (i = 0; i < bw_params->clk_table.num_entries; i++, j--) {
-		bw_params->clk_table.entries[i].fclk_mhz = clock_table->FClocks[j].Freq;
-		bw_params->clk_table.entries[i].memclk_mhz = clock_table->MemClocks[j].Freq;
-		bw_params->clk_table.entries[i].voltage = clock_table->FClocks[j].Vol;
-		bw_params->clk_table.entries[i].dcfclk_mhz = find_dcfclk_for_voltage(clock_table, clock_table->FClocks[j].Vol);
-		bw_params->clk_table.entries[i].socclk_mhz = find_socclk_for_voltage(clock_table,
-									bw_params->clk_table.entries[i].voltage);
+	for (i = 0; i < bw_params->clk_table.num_entries; i++) {
+		volt = clock_table->DcfClocks[i].Vol;
+
+		bw_params->clk_table.entries[i].voltage = volt;
+		bw_params->clk_table.entries[i].dcfclk_mhz =
+			clock_table->DcfClocks[i].Freq;
+		bw_params->clk_table.entries[i].fclk_mhz =
+			find_max_fclk_for_voltage(clock_table, volt);
+		bw_params->clk_table.entries[i].memclk_mhz =
+			find_max_memclk_for_voltage(clock_table, volt);
+		bw_params->clk_table.entries[i].socclk_mhz =
+			find_max_socclk_for_voltage(clock_table, volt);
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 8e3f1d0b4cc3..38a2aa87f5f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1575,10 +1575,12 @@ static struct _vcs_dpi_voltage_scaling_st construct_low_pstate_lvl(struct clk_li
 	low_pstate_lvl.phyclk_d18_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_d18_mhz;
 	low_pstate_lvl.phyclk_mhz = dcn2_1_soc.clock_limits[high_voltage_lvl].phyclk_mhz;
 
-	for (i = clk_table->num_entries; i > 1; i--)
-		clk_table->entries[i] = clk_table->entries[i-1];
-	clk_table->entries[1] = clk_table->entries[0];
-	clk_table->num_entries++;
+	if (clk_table->num_entries < MAX_NUM_DPM_LVL) {
+		for (i = clk_table->num_entries; i > 1; i--)
+			clk_table->entries[i] = clk_table->entries[i-1];
+		clk_table->entries[1] = clk_table->entries[0];
+		clk_table->num_entries++;
+	}
 
 	return low_pstate_lvl;
 }
@@ -1610,10 +1612,6 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 			}
 		}
 
-		/* clk_table[1] is reserved for min DF PState.  skip here to fill in later. */
-		if (i == 1)
-			k++;
-
 		clock_limits[k].state = k;
 		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
 		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
@@ -1630,14 +1628,25 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 
 		k++;
 	}
-	for (i = 0; i < clk_table->num_entries + 1; i++)
-		dcn2_1_soc.clock_limits[i] = clock_limits[i];
+
+	if (clk_table->num_entries >= MAX_NUM_DPM_LVL) {
+		for (i = 0; i < clk_table->num_entries + 1; i++)
+			dcn2_1_soc.clock_limits[i] = clock_limits[i];
+	} else {
+		dcn2_1_soc.clock_limits[0] = clock_limits[0];
+		for (i = 2; i < clk_table->num_entries + 1; i++) {
+			dcn2_1_soc.clock_limits[i] = clock_limits[i - 1];
+			dcn2_1_soc.clock_limits[i].state = i;
+		}
+	}
+
 	if (clk_table->num_entries) {
-		dcn2_1_soc.num_states = clk_table->num_entries + 1;
 		/* fill in min DF PState */
 		dcn2_1_soc.clock_limits[1] = construct_low_pstate_lvl(clk_table, closest_clk_lvl);
+		dcn2_1_soc.num_states = clk_table->num_entries;
 		/* duplicate last level */
-		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
+		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] =
+			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
 		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
