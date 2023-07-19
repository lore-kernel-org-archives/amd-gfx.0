Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B8AC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9270A10E4E6;
	Wed, 19 Jul 2023 18:35:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C0910E4E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEHqNc4Gz3pjqkfKaP5HCTATVMRxhVFDJL4vYqhONX3in956W5nHEsGzXjGzwmcRsYTweSmuHwX4Ec6ce/DuUfB7VxqrwRfk9l/RfIdUDU3Lsik23ALRPQs/NLXiBL7C2QZwrRADnQl0ru2dXC2ebCG6lLBPQljrXiCQe/k4YPw+h3+PuTR8WnTGelAhwX0NlxUHlJ7h0/ZgLmAbCSmaQFgflV+RVrSRBihOoWgMazQ4dU109H1jd9H6njl2/cdE1nFqd1NJ3y85iHV0aPo/043rVi/ulbF6sxMOZbYDbbh2JgE6wyAlspwfdp9QcLkNqOa4xb5rpVXK10/yzCT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiJDIr9XkcmqpVrBBd4PqHARmUTdDoE5cW92s4HwkUA=;
 b=m4sCGnxIyhZ1wvNPZ6QjgfEz+mF7kpMh0Fm/Z3VUniHi7EifxaN9qUQQWmTf9x71Cf0rIVfjgy2wBi/jM1Be3ocRocjbBrpqmofZ7VuRtJxTvs7uTNhwBfVGoVB3SSgHmokl61H+B5VSyKmfQB+g4fNQYDkPgTfO28pc+FbExwZYbFD6aKYqYVEBzB5MLShovaVZnhDytW3O85kTgAxP1SNhpAJUgFOxn8BO5ckb9WfRqxh/FQ36qoSLKoPf6QNs8KXu3UqsaVkKT/7k6KhV72xBxZ5uSu0la7YdfJ2mv0bp5aX8V2jzNkni4D6E5RBNZOlC54d/lMuGcWsYqwG0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiJDIr9XkcmqpVrBBd4PqHARmUTdDoE5cW92s4HwkUA=;
 b=ptNPLw8TSLTBY02lhqrAlsDMeVL3Q215SJrGr9xH1nMSA+K1UU1zmJWy9ths4s6ObqagIZt/4McBi8sGfiiq/QuTdyNw011cZLghejhV9Uo7Lv84sRBUEFvByWeFaxaTqr3g2cthj3pBPTVBSdFwg3X09EAE11Bc7NjxESUxpHQ=
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:35:24 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6::4) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:35:23 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:35:21 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/16] drm/amd/display: Add new sequence for 4-lane HBR3 on
 vendor specific retimers
Date: Wed, 19 Jul 2023 12:28:01 -0600
Message-ID: <20230719183211.153690-12-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7597a180-1e8a-46d4-aaab-08db8886ea2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpJcRbKQeosTW32Wm5BkWfm71xGHhYu/b39f/1qgRv01qXunYS5QayXqafoaRFpF4qLKejgx+XHOzYKCPsmVUdHm5mhHLzG4rbSd0NkisAAkqwBYsKxTqkoPhzua6lPFs4Y52vm0QOF8RVI+AGV5ApYB6s1OQElD+aQC96ZfIUKuQ7k9m8JaSr+1/vdPcaIDI3l0hAwPSIL97XIKqsXsY998BZOrbmtUi9+9zYZ8lssSWlDhOcqZC8I9e/fAPHa5MD577w1wft5HOtigAuBVzqEQsrm3JCo/9MQV4GcZvLgJU/PI/LsDJoMJH8SbkvssAnqbzxBwZRy8g+rhOscpqimHodw/7gPqn/FkyLVd+RvcrPOKnovDgjmx4zIgEQvLSKs3nuD1ketjBwUZXBiX2JBa+GugaQLH1CdFaL4zK6rBAS8u3IAF6UrQDiwa14KEzlvRFVRGzwZiFDOaxwc6CTcErIa8FNMBtRy6MeeQz8pgcaGVwLeIzY7YJhOGOYzokfaenrOc6cYXxwOH0Gqzlzmod3VnO1S3zxgoIx8PARIF+p6XGOftQOFfZo8eoNiKGUDGFnCu0fVW3N8ki+dOdYW/ho9CJKamI05GknU9DuUk2xcFqTNvmz/evTIcHmXdRsl4W51sBhEg+HZzDtYAJkj1fLC2jiIcub9NB1ja0OKNm9xiAAT20c2lJdu6h7Yg7DoRqWM2Zg4qZ7nh9i4p1D0IOQKX/2ECoQx6Mx80vCxSsF6LYqEm24O3yQJUdGS/r9zPtBX+Q7oe1L3uoOoeYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(36756003)(54906003)(478600001)(7696005)(6666004)(40480700001)(1076003)(336012)(186003)(16526019)(26005)(40460700003)(86362001)(356005)(41300700001)(6916009)(4326008)(316002)(70206006)(70586007)(8936002)(44832011)(8676002)(82740400003)(5660300002)(2616005)(47076005)(426003)(2906002)(81166007)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:35:23.8379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7597a180-1e8a-46d4-aaab-08db8886ea2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>,
 wayne.lin@amd.com, Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why]
In some vendor specific retimer setups for downstream 4-lane HBR3
configuration, the sink will show severe corruption (horizontal shifting)
and intermittent blanking.

[How]
Add new retimer programming sequence before clock recovery when 4 lanes
are active.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
---
 .../link_dp_training_fixed_vs_pe_retimer.c    | 67 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index 2a4f70acc7fa..ca0543e62917 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -236,6 +236,11 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
+	const uint8_t vendor_lttpr_write_data_4lane_1[4] = {0x1, 0x6E, 0xF2, 0x19};
+	const uint8_t vendor_lttpr_write_data_4lane_2[4] = {0x1, 0x6B, 0xF2, 0x01};
+	const uint8_t vendor_lttpr_write_data_4lane_3[4] = {0x1, 0x6D, 0xF2, 0x18};
+	const uint8_t vendor_lttpr_write_data_4lane_4[4] = {0x1, 0x6C, 0xF2, 0x03};
+	const uint8_t vendor_lttpr_write_data_4lane_5[4] = {0x1, 0x03, 0xF3, 0x06};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
@@ -338,6 +343,34 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 		DP_DOWNSPREAD_CTRL,
 		lt_settings->link_settings.link_spread);
 
+	if (lt_settings->link_settings.lane_count == LANE_COUNT_FOUR) {
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_1[0],
+				sizeof(vendor_lttpr_write_data_4lane_1));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_2[0],
+				sizeof(vendor_lttpr_write_data_4lane_2));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_3[0],
+				sizeof(vendor_lttpr_write_data_4lane_3));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_4[0],
+				sizeof(vendor_lttpr_write_data_4lane_4));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_5[0],
+				sizeof(vendor_lttpr_write_data_4lane_5));
+	}
+
 	/* 2. Perform link training */
 
 	/* Perform Clock Recovery Sequence */
@@ -598,7 +631,11 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	uint32_t pre_disable_intercept_delay_ms = 0;
 	uint8_t vendor_lttpr_write_data_vs[4] = {0x1, 0x51, 0x63, 0x0};
 	uint8_t vendor_lttpr_write_data_pe[4] = {0x1, 0x52, 0x63, 0x0};
-
+	const uint8_t vendor_lttpr_write_data_4lane_1[4] = {0x1, 0x6E, 0xF2, 0x19};
+	const uint8_t vendor_lttpr_write_data_4lane_2[4] = {0x1, 0x6B, 0xF2, 0x01};
+	const uint8_t vendor_lttpr_write_data_4lane_3[4] = {0x1, 0x6D, 0xF2, 0x18};
+	const uint8_t vendor_lttpr_write_data_4lane_4[4] = {0x1, 0x6C, 0xF2, 0x03};
+	const uint8_t vendor_lttpr_write_data_4lane_5[4] = {0x1, 0x03, 0xF3, 0x06};
 	uint32_t vendor_lttpr_write_address = 0xF004F;
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
@@ -701,6 +738,34 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 		DP_DOWNSPREAD_CTRL,
 		lt_settings->link_settings.link_spread);
 
+	if (lt_settings->link_settings.lane_count == LANE_COUNT_FOUR) {
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_1[0],
+				sizeof(vendor_lttpr_write_data_4lane_1));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_2[0],
+				sizeof(vendor_lttpr_write_data_4lane_2));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_3[0],
+				sizeof(vendor_lttpr_write_data_4lane_3));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_4[0],
+				sizeof(vendor_lttpr_write_data_4lane_4));
+		core_link_write_dpcd(
+				link,
+				vendor_lttpr_write_address,
+				&vendor_lttpr_write_data_4lane_5[0],
+				sizeof(vendor_lttpr_write_data_4lane_5));
+	}
+
 	/* 2. Perform link training */
 
 	/* Perform Clock Recovery Sequence */
-- 
2.41.0

