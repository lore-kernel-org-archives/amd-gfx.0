Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A1EC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A0760E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07A0760E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC99D6FE5E;
	Sat, 24 Jul 2021 04:11:33 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B736FE5E
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6oVasemRt/wfJtxmx4MgeyiuqCCWCdGS9GfHYr1s8A9tJAo9JMUD8X/V0xjjseOBSEyqniC6QhTZMRhPcGX0vuQctbk6Igjzd7SGXg2XizZImtglUdoxw7fU6EwrgEi/1s4BeXinrI54o8PYilzcH8uACitf971MXup8NhnNsTAFeil3Qr1FpQNR4w14f+oVqlfq6vtyVXeZ7Oy/Px06/cLX15ZFM1Kv9LZF6/WjoQ/wjWUlcGbtNix315H019qcrxkxNX++ZZOo8FrgDRyNIpS0tNfftejY8TvNUG58YvQ5xYbzKrUfZeO8Zz+s3pmOaVvGB6M1VbNT1VWLliA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwKRebJQ9d2yMsWDR2bCg3ts1bkZdDdpIvZOQNDkQNA=;
 b=glSx0loRB4jLpbXuLwu+nRErqNlZ8XO0ttcMuCocPUMFG9DkSYwadU3vPnYrx7d01O0MCmUUJOaLW0pHiPKr95uVGJpRtOnGun3gv9kUkXQwnUnDwfCk9+2Mw7Be1bTYL5QEuaKQ0XixOb8MRwL8UZ9WpexI6CAejTB1RH3GNfNNJQFTkRcqC4TBc6bVt3q3o+DYceQFOZYxgz8CnmnnJ+BhSRDa8/VVFYt/zAaHsN1rTpHrOFreT9ux8Uzk5uf+8dXDO0FqB9km8wHmo0ZUJQH2eW0xTGoMDWkwf2RVwhoiwRXR2rj5CqgdTGR/TumB/eVQKaREcIBulF8BzVq48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwKRebJQ9d2yMsWDR2bCg3ts1bkZdDdpIvZOQNDkQNA=;
 b=iTqp/5qfMcpocaDyIiqnUpiECKYiEop0Do+eM1AKkddnZ9hLbuZN1SivBbTKUg19mH7ZMkVkVxJNVqcENpSggPPk37ZNZaGP77GJeGNR23w5iNT15sh6Yrz7Eo3mZ/ZT3c96vU6obg2LZlIjhJXGmFDH38bFDkC5aFGjLbZxtVs=
Received: from BN6PR22CA0045.namprd22.prod.outlook.com (2603:10b6:404:37::31)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Sat, 24 Jul
 2021 04:11:30 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::8b) by BN6PR22CA0045.outlook.office365.com
 (2603:10b6:404:37::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:30 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:26 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: add update authentication interface
Date: Sat, 24 Jul 2021 12:09:55 +0800
Message-ID: <20210724041001.3875757-9-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db23e156-57a9-446f-2809-08d94e591d58
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR12MB525406FBC05330A1373FCC8F97E69@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUsgYY6yk3bmu5VGjSwJVW4OcLuZLKH0/1bVBWUSjO6l2NGWE7lmuE9FgMGiieBeqEQM3+TxPS43Kkw+DdoHDJdZBkaGMA+Zh90NF16sksSBlIyEbLMylPQqCCnEqDGZRo0N7IYRtUkHWq36PeXNP/91P3Kah4Q1ALcvMskmzK/SwIwoJGPBVC81Z44HOIQRDlHs2Q2YOB9jkL7BhOJrRpWzygDwq4JY2CEAFYZXV0TlwTDqHUeYf1hCNUc753GSRglPEZD5TkSkLB9qdWKXErYtAuk6JwZ2Mez3YJM3i3yBhExFvbdw/VfFS+k8Eru7ybwqtVvuI58hyQ7zkTRHt+HYnBA32LQ7Joum7iu9glUgd3GEfQUiBuCsTSvlqkEjatbJLm5b1iEk3uBWEMMs815k1gZrpAtUW7V/pr0ld6Wih9gYho4F//tNR3NH0CaXvdnO7ly6ENlypg9kVr3McAt5TQWvsjnMNZGxy1ouqHE15ORPmNT7VRChNUAS/WNMroaEz6mp1MgqyiXOtolPVwahkOmnH8tJPXefjZ9t4qygLTTdei8StLSjl4EWUyz41op1SHYnGbHk14jVwBagx5KVolTzAaaGrODxffhpixz8LXxFq1Gq251fzKOZ25FlOBNTdfN+N6XChrXtzarU/gB8goxjZqA+K5Wx6djo31HK/54dO5OFRPM6dH7iFr1KDw88fvUMdtaqVm1JUqw/XtubAUM/TyGTuM+jflyhvuE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(336012)(81166007)(70206006)(508600001)(8676002)(44832011)(6666004)(2616005)(70586007)(54906003)(426003)(316002)(4326008)(8936002)(186003)(47076005)(7696005)(26005)(2906002)(86362001)(16526019)(36860700001)(5660300002)(83380400001)(356005)(15650500001)(36756003)(1076003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:30.0478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db23e156-57a9-446f-2809-08d94e591d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Previously to toggle authentication, we need to remove and
add the same display back with modified adjustment.
This method will toggle DTM state without actual hardware changes.
This is not per design and would cause potential issues in the long run.

[how]
We are creating a dedicated interface that does the same thing as
remove and add back the display without changing DTM state.

Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 64 +++++++++++++++++--
 .../drm/amd/display/modules/inc/mod_hdcp.h    | 11 +++-
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
index b963226e8af4..2bcab9c9b96e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c
@@ -39,8 +39,12 @@ static void push_error_status(struct mod_hdcp *hdcp,
 
 	if (is_hdcp1(hdcp)) {
 		hdcp->connection.hdcp1_retry_count++;
+		if (hdcp->connection.hdcp1_retry_count == MAX_NUM_OF_ATTEMPTS)
+			hdcp->connection.link.adjust.hdcp1.disable = 1;
 	} else if (is_hdcp2(hdcp)) {
 		hdcp->connection.hdcp2_retry_count++;
+		if (hdcp->connection.hdcp2_retry_count == MAX_NUM_OF_ATTEMPTS)
+			hdcp->connection.link.adjust.hdcp2.disable = 1;
 	}
 }
 
@@ -59,8 +63,7 @@ static uint8_t is_cp_desired_hdcp1(struct mod_hdcp *hdcp)
 		}
 	}
 
-	return (hdcp->connection.hdcp1_retry_count < MAX_NUM_OF_ATTEMPTS) &&
-			is_auth_needed &&
+	return is_auth_needed &&
 			!hdcp->connection.link.adjust.hdcp1.disable &&
 			!hdcp->connection.is_hdcp1_revoked;
 }
@@ -80,8 +83,7 @@ static uint8_t is_cp_desired_hdcp2(struct mod_hdcp *hdcp)
 		}
 	}
 
-	return (hdcp->connection.hdcp2_retry_count < MAX_NUM_OF_ATTEMPTS) &&
-			is_auth_needed &&
+	return is_auth_needed &&
 			!hdcp->connection.link.adjust.hdcp2.disable &&
 			!hdcp->connection.is_hdcp2_revoked;
 }
@@ -392,6 +394,60 @@ enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 	return status;
 }
 
+enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
+		uint8_t index,
+		struct mod_hdcp_link_adjustment *link_adjust,
+		struct mod_hdcp_display_adjustment *display_adjust,
+		struct mod_hdcp_output *output)
+{
+	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
+	struct mod_hdcp_display *display = NULL;
+
+	HDCP_TOP_INTERFACE_TRACE_WITH_INDEX(hdcp, index);
+	memset(output, 0, sizeof(struct mod_hdcp_output));
+
+	/* find display in connection */
+	display = get_active_display_at_index(hdcp, index);
+	if (!display) {
+		status = MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+		goto out;
+	}
+
+	/* skip if no changes */
+	if (memcmp(link_adjust, &hdcp->connection.link.adjust,
+			sizeof(struct mod_hdcp_link_adjustment)) == 0 &&
+			memcmp(display_adjust, &display->adjust,
+					sizeof(struct mod_hdcp_display_adjustment)) == 0) {
+		status = MOD_HDCP_STATUS_SUCCESS;
+		goto out;
+	}
+
+	/* stop current authentication */
+	status = reset_authentication(hdcp, output);
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		goto out;
+
+	/* clear retry counters */
+	reset_retry_counts(hdcp);
+
+	/* reset error trace */
+	memset(&hdcp->connection.trace, 0, sizeof(hdcp->connection.trace));
+
+	/* set new adjustment */
+	hdcp->connection.link.adjust = *link_adjust;
+	display->adjust = *display_adjust;
+
+	/* request authentication when connection is not reset */
+	if (current_state(hdcp) != HDCP_UNINITIALIZED)
+		/* wait 100ms to debounce simultaneous updates for different indices */
+		callback_in_ms(100, output);
+
+out:
+	if (status != MOD_HDCP_STATUS_SUCCESS)
+		push_error_status(hdcp, status);
+	return status;
+}
+
 enum mod_hdcp_status mod_hdcp_query_display(struct mod_hdcp *hdcp,
 		uint8_t index, struct mod_hdcp_display_query *query)
 {
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index c590493fd293..c1b485f5fb71 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -282,15 +282,22 @@ enum mod_hdcp_status mod_hdcp_setup(struct mod_hdcp *hdcp,
 /* called per link on link destroy */
 enum mod_hdcp_status mod_hdcp_teardown(struct mod_hdcp *hdcp);
 
-/* called per display on cp_desired set to true */
+/* called per display after stream is enabled */
 enum mod_hdcp_status mod_hdcp_add_display(struct mod_hdcp *hdcp,
 		struct mod_hdcp_link *link, struct mod_hdcp_display *display,
 		struct mod_hdcp_output *output);
 
-/* called per display on cp_desired set to false */
+/* called per display before stream is disabled */
 enum mod_hdcp_status mod_hdcp_remove_display(struct mod_hdcp *hdcp,
 		uint8_t index, struct mod_hdcp_output *output);
 
+/* called per display to apply new authentication adjustment */
+enum mod_hdcp_status mod_hdcp_update_authentication(struct mod_hdcp *hdcp,
+		uint8_t index,
+		struct mod_hdcp_link_adjustment *link_adjust,
+		struct mod_hdcp_display_adjustment *display_adjust,
+		struct mod_hdcp_output *output);
+
 /* called to query hdcp information on a specific index */
 enum mod_hdcp_status mod_hdcp_query_display(struct mod_hdcp *hdcp,
 		uint8_t index, struct mod_hdcp_display_query *query);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
