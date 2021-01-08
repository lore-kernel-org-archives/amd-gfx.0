Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B0EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BA623A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA623A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106CD6E8E8;
	Fri,  8 Jan 2021 21:50:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E638D6E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLgS7rQoPp6yHzBDdlIkuKFFbfYjRUmY8w6I6eJftAHZCfVzwykZBJRDeReo9gEO2OqPH/4XIZGC4XDFoWu11yq+cdNlqDWWSbC3Ku+2y9+edGN5sVcTjtJMA3gCmcrVkM5SCZTT71l4lLJOVtjscW/V/WMONS9LKoFUNL41/THvZYxjyYjWcM+TUu/ji1iNaS6zTG+8SvAtO9OJSJyCT0hGZa67JAmWFkJBLuxeZ5NB3lnSTsKYxvwItpdG+25R1n/vFhto3S9gM1EFkOyo+4lWUePMXhOWoIQLugJcunql8NhGr348f/EVGyHvCc6zWCPdUnhV3NE7A7ytYF26hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMai8UZK3LP6RfERNk3C9oc6EBBAyAd+nlyCk7w9vjM=;
 b=CZz9Utw0tz3m+d3RhokAj32eGo52LgrosPItZ0e/iWEN7Vv2oFE9iqZykRG1gQTfgNOaEKCturAIEzjFIa2Gvkk36onJMWXwpWiyfUVYx5wKvQSJTKGQ4UVV8uZx3H4cLIrPqdOKKGxN1ljLqgu/t1oBxcTsiySaggMDrekxmlQ2AE0fhwh958z75GzdReBPFSsyYOJao5XHtIGLFKq0ickyAWw3uS1ApLYFKiN3Flkv3vsUX7EZ9Afj/c5Jmva7A13q+bE9Dki+kCX3K/e85u0HL+qyiGBBsUqJVaxDdWLvQKPNu8H1KnQiRK9oc5rQNb2FHgL/45roPDGfJPY17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMai8UZK3LP6RfERNk3C9oc6EBBAyAd+nlyCk7w9vjM=;
 b=LJaXiswQu5D1LWWaX7uhnELd3Vhfz7Fw3MXWyZdV3JoF/sQOBa05kQy/NGia3t7KSNYUAQV8IhYI4VJFiqh0X0CzxrHayy2reISDOqprP+X4ZAyRNbkE4gAYqlo5RmRpMZEkT6H94IouFk66MukCFa4wWGjDl5mCs6woM8FJorw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:35 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/21] drm/amd/display: Separate fec debug flag and monitor
 patch
Date: Fri,  8 Jan 2021 16:49:50 -0500
Message-Id: <20210108215007.851249-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11874c84-57bd-4bdc-a638-08d8b41f6df2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882014CFCD73EFE2D07231498AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YomY/rypWjRAl0y96hIdwLL4jE9whPI4flxFqo9998mtL3c7EydoNQyhcTUqZV2sHl25c6yvCc0DlQlpfesMIebaURxsWWxe4i6q923XHZ7p2SeNYdjkR2RlJ7EaeExwHI6FZY0gor4pdMVl2OuZv4M5yG9j16DyhZ/X2nKZ0AwwbgbywXeeA5aTwP1KjJL0tpDBgIm44ahRF/sp5oPYmwEAUCjn+EDq1VBxpVuW82D0rnryfNqU8ZA5w/+CEY8ZI3g35FjyztjghY+UYWq/YGMbAMrinciN48vdAs6obtfIzYC9idvGREa1PIaQ2U6LVermsdDR1WYSBODU7UNPRnj4Z5tMhj04t5cpduOmNONAXuEsAVBCg/zeNw20JwYKM23Q8k1BRrX8cXb8xL79ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?myAc0F6Gok4/CI0vZrDVSTlhdIpiDhioqz5AXNQtw1rlRGn6O2lL7oEQMjBH?=
 =?us-ascii?Q?eKc5gs8HygmPRZCnJQsw6BuEZB4vCu14L1xDz3eZc9ekBFLoKvzrkiRx7rUU?=
 =?us-ascii?Q?HmhcPvgiNwGBX0iiBFw6Ymva8CWtPYOcA2H405egHEMdXteO9ZOtoT5gw9HN?=
 =?us-ascii?Q?kQkwJ9AGDVy2MFYXcluUtAouv6QuoBc1imtEVBxZssCJEWQODQS15h5Qqkbl?=
 =?us-ascii?Q?Anv13v4KW5k1hXX3mz/p2cXj7Y6T+SaQqT8hbic2A23G3UI3BNCiYugAd1YS?=
 =?us-ascii?Q?7Cgm3C4ZE7eC4nNE1//12/TwjIixBbw8J/if2p3lcvoafq/VHit3wSAU43cC?=
 =?us-ascii?Q?R29EmoBwuXLjCVoqBUCAKSqjR+wte/CeYv12Vabov64yncMjhtdzqlEJjuvU?=
 =?us-ascii?Q?kjydj6Sqei6ynKfI+s0xp8IqFoMWzG7x45jDSVVxKfVulLUIsp4jnL46s170?=
 =?us-ascii?Q?aQCweSvPn1994X0L1MYSOWxWj2SluuuqTYnxw648cFMH2+qT/UPIUs8Zki7D?=
 =?us-ascii?Q?NALon2QRQTKKQjf68D3gWKh45owLF8fISsYU8phU+Am1/YmTzBwzyqML54Mk?=
 =?us-ascii?Q?j29eqR24m5OeE61u0xsRtrPOqduGfrD0M4gXnVdAGW2l4+A34ao80Rb8TDl4?=
 =?us-ascii?Q?OGK4wvJGn9wUZw5wyxRQoiFFFmQNBpybOBfx1lR0xODf0XYYbKOL5qERS57e?=
 =?us-ascii?Q?pCekvikT2NnOW7rqFoCueYpH+I0g41A0lXu1YRLyMor8viFUADCPCo1201BC?=
 =?us-ascii?Q?HPQm1gEyQ0whZ4YMz+C2r/JwTOnXPjwHd/6XiZA3YyGEChAFUmG3xyuQOBaz?=
 =?us-ascii?Q?Rp6QiSNuIhwj0JpP1Dg/m7P25zsMvEKsN6+Iu6ITTWTO0NjRvVElwFdQhV52?=
 =?us-ascii?Q?7aDR09BjgNFFKYdwRE7xkPkef55S/0wCxmnI+t5YZ5batfjW1KlFUw0R852K?=
 =?us-ascii?Q?nZKZL0uJ0mh6dbuSZh1Z3YA813XTBJzj6OfvM+TrjUJj1k/HB8ulqJYPTdjL?=
 =?us-ascii?Q?WawPrx0i5dSMnm8C+bCUzMHSB1x48pWPJNgbZECdT7Ja+nRmutiZf7thiD/I?=
 =?us-ascii?Q?YfxxwJz3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:35.3100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 11874c84-57bd-4bdc-a638-08d8b41f6df2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt9pDzUcXy156zs4lNILAuoAq/gwEqPQlEhsci6lktbgmiDhnMsl1ng3G7o2sor+os5LXErfoJv3DdrEOwHGrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[Why]
Driver apply the monitor patch into global debug flag.  When apply
monitor patch, fec feature will always disable.

[How]
Separate fec debug flag and monitor patch

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 20 +++++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 ++--
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f4a2088ab179..59ef1eacc6e1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1065,9 +1065,6 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			break;
 		}
 
-		if (link->local_sink->edid_caps.panel_patch.disable_fec)
-			link->ctx->dc->debug.disable_fec = true;
-
 		// Check if edid is the same
 		if ((prev_sink) &&
 		    (edid_status == EDID_THE_SAME || edid_status == EDID_OK))
@@ -3635,7 +3632,7 @@ uint32_t dc_link_bandwidth_kbps(
 	link_bw_kbps *= 8;   /* 8 bits per byte*/
 	link_bw_kbps *= link_setting->lane_count;
 
-	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec) {
+	if (dc_link_should_enable_fec(link)) {
 		/* Account for FEC overhead.
 		 * We have to do it based on caps,
 		 * and not based on FEC being set ready,
@@ -3687,3 +3684,18 @@ bool dc_link_is_fec_supported(const struct dc_link *link)
 			!IS_FPGA_MAXIMUS_DC(link->ctx->dce_environment));
 }
 
+bool dc_link_should_enable_fec(const struct dc_link *link)
+{
+	bool is_fec_disable = false;
+	bool ret = false;
+
+	if (link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
+			link->local_sink &&
+			link->local_sink->edid_caps.panel_patch.disable_fec)
+		is_fec_disable = true;
+
+	if (dc_link_is_fec_supported(link) && !link->dc->debug.disable_fec && !is_fec_disable)
+		ret = true;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 1bd1a0935290..3cd84dcb266b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4345,7 +4345,7 @@ void dp_set_fec_ready(struct dc_link *link, bool ready)
 	struct link_encoder *link_enc = link->link_enc;
 	uint8_t fec_config = 0;
 
-	if (!dc_link_is_fec_supported(link) || link->dc->debug.disable_fec)
+	if (!dc_link_should_enable_fec(link))
 		return;
 
 	if (link_enc->funcs->fec_set_ready &&
@@ -4380,7 +4380,7 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 {
 	struct link_encoder *link_enc = link->link_enc;
 
-	if (!dc_link_is_fec_supported(link) || link->dc->debug.disable_fec)
+	if (!dc_link_should_enable_fec(link))
 		return;
 
 	if (link_enc->funcs->fec_set_enable &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 6d9a60c9dcc0..d8d659b2bc34 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -369,5 +369,6 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	const struct dc_crtc_timing *timing);
 
 bool dc_link_is_fec_supported(const struct dc_link *link);
+bool dc_link_should_enable_fec(const struct dc_link *link);
 
 #endif /* DC_LINK_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
