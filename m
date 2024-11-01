Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A539E6B27E
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E20C10E9C5;
	Fri,  1 Nov 2024 13:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KtQiD6Gn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BAE10E166
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwiP+ziKDN8VUncH9K0KIWU7DfpkKQJkMgcOvLch3eHDAWstYfjKInn6e62YetqSjhg3zKyTMHxMlAv3d3cVrr5FuH8eOQ55cg4VtR04RhJ+iNYyLHlTuVQwDsRCo8Piw1SNypZ4alWBg9VrdcND46IGWp0qlxiVvLttIH2eaqVOMF7Iqxs89eR9+DUI9ko/gOh7XZSIi6NlRjN5ZK/2aPGDqzta8A3fycud0vmcRe/0Z7B0fUHy5h7M68VfP0nOlovIfMvs3KD/PeVO+LkVe6dsoyVBM99aFHOKsNgpE0CcMX+LhwtP/PwKxnYDME64NYOIaRUWZdpJKr0wXaI7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfXI2sKAa8Z6BR7CxDL/ubWUbgUkN0R9mMJvY4f7wUQ=;
 b=ULlkwopDPp2xKRiIFrEPSGoKBs6fJ+0LVVTKtXnrLXgK1gGCgXAR7DIWlA2Vzvgi8evQtUmB4tb8yaXlT4/2Sr6V2Zf0YDCoj7MA5D0IJoH+B27CalfAjueZM86WJKrFYRzn/Cn9oynwb7A4xOa0EONSpnij8Oar1RIHzzoc90OmJk+Yn2dMuLe3adiljGUlEljafaTKZSQTT2Y58ulwBIGcqm6fbXKnOsh/gQhJ7gJ78dyodPS+0xlnCY+lsTZXMsawT1hwdxAFcp8JCnx0nLIr3xRJXAHB8UX8QwfsmqmlAOQJNkUBkL2zxfL5U7S4JufPSeoxcIt3mn9o07KIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfXI2sKAa8Z6BR7CxDL/ubWUbgUkN0R9mMJvY4f7wUQ=;
 b=KtQiD6GnBYX4IwGvojeQgjJp77zsXRVTAvCSklYbsLKnUF+A6VXdqbilWXwFdBah13r43dDKjMOZKIKOyBXNMuuq0Ad/rMlWmk8n9QrpJ4uGb/W8R0QE/de45KwTGWuzwgnlkJfUjcqCGU1MrsJ+VdaOEgUwU8p6mo2nncUS9ys=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 13:50:09 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::a0) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:09 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:07 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 04/17] drm/amd/display: fix rxstatus_msg_sz type narrowing
Date: Fri, 1 Nov 2024 09:49:27 -0400
Message-ID: <20241101134940.1426653-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 66264e8f-288d-4234-be78-08dcfa7c19bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huZFJngesgqbpCoZeb+RxZjCGs1k76CdqKQHETPVEQuJwcCyjZHrHrE32jdH?=
 =?us-ascii?Q?vJNYRj01ySja7+8k/AFfjPDTBYOZovsPWdCeJ6UOVJ6pNvO2lomYUj8X9IKA?=
 =?us-ascii?Q?VtQVXcjJnWqfO8XycESzSbXbU014ik1oZIjLDvmB5Bprk5tSVO8ZQhCwWs2y?=
 =?us-ascii?Q?vobJmwtmcPkn9KNJQKgisDjyN13mLuwqETPSLopKlG/HWhS96nvERDOnD5h0?=
 =?us-ascii?Q?k/72t6hQlAg016iH+PIgKTtwz4mcTezZa4BVtp3Q/v6umZlXG6XlSQvSAwkp?=
 =?us-ascii?Q?ce+U5n15k3z0S+k9hNrYGVwHw5odXVmKWCH6O9fJr0uLn7OVm8hJrya3qxFq?=
 =?us-ascii?Q?6HED68R4tPzFvyr4ScoWDA/Fbkeqlh6l6hoeWyUa/4OvWsJtZln9pn5LGre5?=
 =?us-ascii?Q?q+t3tZxCLT1hrmmJsyHVrIQ9ASOSQVyIT/2kI9t76U4dB6BBJ6HRHxSeBgo1?=
 =?us-ascii?Q?cjFTfl2kzZzdT6m+yO6Q83LgOX+Qyhha3guqdos1Kb9AAOLWOmRsIny7oNTE?=
 =?us-ascii?Q?hUMvHASJqNIcLrhHI8kZQ0jWvJKclo643jgmIg5WQ03ZmlmVCJyiqmrM3GZL?=
 =?us-ascii?Q?XK4sqiPCgVMmQemnEegTbUamBYoarw000hl8xU4hNEjlIHLxQZRdxStUaToM?=
 =?us-ascii?Q?qM2FJ494HTcvuY1h7T+3QydpJGZ5E7X5ABTWRrX3TwicsHFCY2l904JJZ/MP?=
 =?us-ascii?Q?jABGf1cHyE+iGBf6xlW9Jy0Cu0ER3ymcyLuijRBGn8tM4CgNt31dRQZwg+W2?=
 =?us-ascii?Q?fEV3qoKMWrKNzfTzu4KlId5euJ+DgolOILMc02NS++6Vr+93M2XMoCiFzPLl?=
 =?us-ascii?Q?WnLsrnFuEEtR37Ra89DJDrC65e9GFdiNpKLdy898Zl1VuIKoyqKscS8FsbtH?=
 =?us-ascii?Q?yEs7mQh715SVrQFRHRHvcwOs3aeQrDKSwHTq8FhoUV01+jBWo9JcTC9whgaP?=
 =?us-ascii?Q?Y6jZ8uZhWDJZwVN1hSwDR8X37zKmL7yzibQafJXXk9XPU7fcksTM9gnNp5cR?=
 =?us-ascii?Q?BrKRvtwaQKesxgV9xbDJvqnvSDHn1/WaUQstZ7ZS9xgOvNwWx8MIO7AjWJtM?=
 =?us-ascii?Q?LMGBOSY6jqSB7hEtTd6BZne79tYVwWOieQm9zvbO6vsguxQzV4/NMWnHNomS?=
 =?us-ascii?Q?0AqPiTvKmL7rrMSS6EXf582g1otbGgRAWJQFXzDQl5fBqTfO+89gh27ObUs/?=
 =?us-ascii?Q?w6ZMHg1Kb1icBr18yoykaYKNRlz3VwLWESmviWVeWTpfmBM0xM/8C73S8lZr?=
 =?us-ascii?Q?vBw8+sIDJMeljsNgO/r1aJ4fnmOsC7mTU5B9rArLmbrFq/FyJn14bkPvShie?=
 =?us-ascii?Q?P4sRaTlpQxqeqNeFy/w3a9UQP7tQzqjIt0b6zp8L4p3AXBttFft1U8nMIgB0?=
 =?us-ascii?Q?emtiqKnP35HD0WvMQNQUUJyJ7iNSEiYUktm50JVKwRu3sVMw+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:09.3832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66264e8f-288d-4234-be78-08dcfa7c19bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Code reading rxstatus message size was incorrectly assigning it to
uint8_t, despite the value being 10 bits long (lower byte plus lowest
2 bits from upper byte). This caused the highest 2 bits to be ignored,
potentially missing invalid values.

[How]
Change all local variables holding rxstatus message size from uint8_t
to uint16_t, as in mod_hdcp_message_hdcp2::rx_id_list_size.
Replaced untyped HDCP_2_2_HMID_RXSTATUS_MSG_SZ_HI macro with function
hdcp_2_2_hmid_rxstatus_msg_sz(const uint8_t[2]) to encapsulate entire
calculation and return a typed result.
Removed spaces mixed with tabs to fix indentation on modified lines.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../display/modules/hdcp/hdcp2_execution.c    | 31 +++++++------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index c996365e84b0..1d41dd58f6bc 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -27,6 +27,11 @@
 
 #include "hdcp.h"
 
+static inline uint16_t get_hdmi_rxstatus_msg_size(const uint8_t rxstatus[2])
+{
+	return HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(rxstatus[1]) << 8 | rxstatus[0];
+}
+
 static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp *hdcp)
 {
 	uint8_t is_ready = 0;
@@ -35,8 +40,7 @@ static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp
 		is_ready = HDCP_2_2_DP_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus_dp) ? 1 : 0;
 	else
 		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[1]) &&
-				(HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-						hdcp->auth.msg.hdcp2.rxstatus[0])) ? 1 : 0;
+				get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus) != 0) ? 1 : 0;
 	return is_ready ? MOD_HDCP_STATUS_SUCCESS :
 			MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY;
 }
@@ -84,15 +88,13 @@ static inline enum mod_hdcp_status check_link_integrity_failure_dp(
 static enum mod_hdcp_status check_ake_cert_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
-	uint16_t size;
 
 	if (is_dp_hdcp(hdcp)) {
 		status = MOD_HDCP_STATUS_SUCCESS;
 	} else {
 		status = mod_hdcp_read_rxstatus(hdcp);
 		if (status == MOD_HDCP_STATUS_SUCCESS) {
-			size = HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-			       hdcp->auth.msg.hdcp2.rxstatus[0];
+			const uint16_t size = get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 			status = (size == sizeof(hdcp->auth.msg.hdcp2.ake_cert)) ?
 					MOD_HDCP_STATUS_SUCCESS :
 					MOD_HDCP_STATUS_HDCP2_AKE_CERT_PENDING;
@@ -104,7 +106,6 @@ static enum mod_hdcp_status check_ake_cert_available(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_h_prime_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
-	uint8_t size;
 
 	status = mod_hdcp_read_rxstatus(hdcp);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
@@ -115,8 +116,7 @@ static enum mod_hdcp_status check_h_prime_available(struct mod_hdcp *hdcp)
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING;
 	} else {
-		size = HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-		       hdcp->auth.msg.hdcp2.rxstatus[0];
+		const uint16_t size = get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 		status = (size == sizeof(hdcp->auth.msg.hdcp2.ake_h_prime)) ?
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_H_PRIME_PENDING;
@@ -128,7 +128,6 @@ static enum mod_hdcp_status check_h_prime_available(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_pairing_info_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
-	uint8_t size;
 
 	status = mod_hdcp_read_rxstatus(hdcp);
 	if (status != MOD_HDCP_STATUS_SUCCESS)
@@ -139,8 +138,7 @@ static enum mod_hdcp_status check_pairing_info_available(struct mod_hdcp *hdcp)
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING;
 	} else {
-		size = HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-		       hdcp->auth.msg.hdcp2.rxstatus[0];
+		const uint16_t size = get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 		status = (size == sizeof(hdcp->auth.msg.hdcp2.ake_pairing_info)) ?
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_PAIRING_INFO_PENDING;
@@ -152,7 +150,6 @@ static enum mod_hdcp_status check_pairing_info_available(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_FAILURE;
-	uint8_t size;
 	uint16_t max_wait = 20; // units of ms
 	uint16_t num_polls = 5;
 	uint16_t wait_time = max_wait / num_polls;
@@ -167,8 +164,7 @@ static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 			if (status != MOD_HDCP_STATUS_SUCCESS)
 				break;
 
-			size = HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-			       hdcp->auth.msg.hdcp2.rxstatus[0];
+			const uint16_t size = get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 			status = (size == sizeof(hdcp->auth.msg.hdcp2.lc_l_prime)) ?
 					MOD_HDCP_STATUS_SUCCESS :
 					MOD_HDCP_STATUS_HDCP2_L_PRIME_PENDING;
@@ -181,7 +177,6 @@ static enum mod_hdcp_status poll_l_prime_available(struct mod_hdcp *hdcp)
 static enum mod_hdcp_status check_stream_ready_available(struct mod_hdcp *hdcp)
 {
 	enum mod_hdcp_status status;
-	uint8_t size;
 
 	if (is_dp_hdcp(hdcp)) {
 		status = MOD_HDCP_STATUS_INVALID_OPERATION;
@@ -189,8 +184,7 @@ static enum mod_hdcp_status check_stream_ready_available(struct mod_hdcp *hdcp)
 		status = mod_hdcp_read_rxstatus(hdcp);
 		if (status != MOD_HDCP_STATUS_SUCCESS)
 			goto out;
-		size = HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-		       hdcp->auth.msg.hdcp2.rxstatus[0];
+		const uint16_t size = get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 		status = (size == sizeof(hdcp->auth.msg.hdcp2.repeater_auth_stream_ready)) ?
 				MOD_HDCP_STATUS_SUCCESS :
 				MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING;
@@ -249,8 +243,7 @@ static uint8_t process_rxstatus(struct mod_hdcp *hdcp,
 						sizeof(hdcp->auth.msg.hdcp2.rx_id_list);
 			else
 				hdcp->auth.msg.hdcp2.rx_id_list_size =
-					HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
-					hdcp->auth.msg.hdcp2.rxstatus[0];
+					get_hdmi_rxstatus_msg_size(hdcp->auth.msg.hdcp2.rxstatus);
 		}
 out:
 	return (*status == MOD_HDCP_STATUS_SUCCESS);
-- 
2.34.1

