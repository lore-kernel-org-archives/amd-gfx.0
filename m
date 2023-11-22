Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D649C61D92
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 06:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3050410E11C;
	Wed, 22 Nov 2023 06:59:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A2210E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 06:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj48maFaN3ohyo7dPbg92al73tN/DjPlGrT4tE0eVRoQ/YLBqrCM0siyfSTUIrI6Slq9mFfr/7TaZSRBAPZXvKMxNnelTfADkIeaKzL4zBmdRpsMolpolJ1MYygBMzzO7R/FdTpl7bUjzUlZnVy+xcEU9d3SZ4J2HIjPrmTUPfvcwgsj89UIQ7hQVNx1TPKcr+pzgLc+Y5zs0wk+OgsthFUJZ9dS3kOuvsljyYOSnc+bYJc/MZQ9B8yC8oGdFctVlIj+Gj6/kMxvqrNb7x2Co4xDALLxw6skLRwhlc+/OdHuF4FtJk2ngH/Zo24bSDYEKDaZVq0Tk/Jo6URMKHooVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80jbiOMS5KQS6oTCXxoD2+TWFcBgsGuXqoo19K2QM6A=;
 b=BEkm4A3CTkzDK6feKhK3t/EmQZLDuLCb5h697Mq3rDBYGT7jDBlPrUmw9s3Hp8/Xj0Hj8f4/O91OAaJEAa1shgslanrT5n6JcZLSHZrIbOfVm9++hPPqsoCSty1KLJcW2SLiz6BZAyre2PG4Pv35J8A9L1pOpOc9goMksyQp6yNmStoSkZphlJNWMS4nOZaOieszYxp4OJmKqHgmMR5QRpr3gCuyfC4QaUacnz9RCSKOrMgwOzVLPfMq1e5h6zbxBFSb+AFE4ngu3XWYL0z/QVcNI5uCgZO5GZZ55Ct0amfugaQh/pYRGDKr+g5w1INzr7+kaMuIOMepxb91o00Xiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80jbiOMS5KQS6oTCXxoD2+TWFcBgsGuXqoo19K2QM6A=;
 b=YHdVqu84Pt4YIhWJ8mX2jAVpQXSN9Ak+btHZbhkuRy9JHhSoTffEaAvmGjK4E6d7Vm4s0Q5b1GS8uANRB1Uly5mBcBWodZUQ4mOms1pKuW0D7xtmgvpBr6xCdKxYijnAFSN2yUNbKCV8m9TISOmycTj4s8HQtuGHW9JeQgt4njU=
Received: from CY8PR10CA0025.namprd10.prod.outlook.com (2603:10b6:930:4b::17)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 06:59:32 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::84) by CY8PR10CA0025.outlook.office365.com
 (2603:10b6:930:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 06:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 06:59:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 00:59:31 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 22 Nov 2023 00:59:24 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/display: Update Fixed VS/PE Retimer Sequence
Date: Wed, 22 Nov 2023 14:58:37 +0800
Message-ID: <20231122065841.2267110-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
References: <20231122065841.2267110-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 36435ca5-ee0c-4fc4-c9f2-08dbeb28944a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 669n+Xqp2YDP0B0k6jgCNCi0/erAd01uI29fDcnXoirQxjtd2sUQwHn4KcjEBT6TAPm0qONGLUIjb+Eyqbk8OsZ/Cp7b69TjJqBCXiwxktn0C9QQougKf0L2hD2YIGS3KBKvTON2Y2gr0y39C0HzrhzDnsHziLRJ0LtRP+Pc52C+GQaCXlNZo3DenmdRK8U8NPz8U83sinyouuoJv2IzwUA2kasYCxahZDJ7S4I48Dml2x2gpfQCYt/aZ/kQGpj+AaLdT8RDO0HyJ84U7KPMTwj2Y7v7NGlFF1e3mZWbeNBUVVP1Lg1TFpOIbl2kFFd1Ju/SoPF71uQ8W3/p+FbMcrFHTsc/BocFA3Z4OHSKgfrZPAUykZ0hPdf0XGANxR1PbQl6QDVOaOeXoNQoMk4DDDAzVWFDTtc3UM09EpqG6FuSWLhOKwjLtxlwzIkFzKfLb7eDdFyu2U3CiZ/e5yh2sRp3dhO4rLXFzFenhJcj/LlZtT+t94iuqAm8SjlgmLBvQ5Fzq0SjJkQIs+TE+aBuNpKiZcxxYkx6A+EAIkeii911oieZiJwzkXuWysYph3npB/jLMEh1xLID2fQS01EVVf9y16GS2dH/p/ZPvhV8LtUT25XzPEz4iGKBhYyzUqXkcWEveY0y4CQqjA9DWMHe8gYbxaXfYgfcHi5gs53IPtkRX1tULW3NBBilOpnPa+KHeRR4tQpRXjLky3DUEp3q9geyRUgChWn/hDv0OgiLV4kmBLKV2vcSfIbGVq4E61hDltix5ui2TYP5TqrG21J/ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(40470700004)(36840700001)(46966006)(7696005)(47076005)(36860700001)(26005)(6666004)(1076003)(2616005)(316002)(6916009)(426003)(40480700001)(356005)(478600001)(336012)(82740400003)(81166007)(70206006)(70586007)(54906003)(4326008)(8936002)(8676002)(5660300002)(86362001)(2906002)(40460700003)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 06:59:32.1111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36435ca5-ee0c-4fc4-c9f2-08dbeb28944a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Michael Strauss <michael.strauss@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY/HOW]
Add a new AUX sequence provided by vendor to improve
interop with specific display configurations.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../protocols/link_dp_training_fixed_vs_pe_retimer.c   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index 68096d12f52f..7087cdc9e977 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -205,6 +205,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	const uint8_t vendor_lttpr_write_data_4lane_3[4] = {0x1, 0x6D, 0xF2, 0x18};
 	const uint8_t vendor_lttpr_write_data_4lane_4[4] = {0x1, 0x6C, 0xF2, 0x03};
 	const uint8_t vendor_lttpr_write_data_4lane_5[4] = {0x1, 0x03, 0xF3, 0x06};
+	const uint8_t vendor_lttpr_write_data_dpmf[4] = {0x1, 0x6, 0x70, 0x87};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
 	union down_spread_ctrl downspread = {0};
@@ -293,6 +294,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 		DP_DOWNSPREAD_CTRL,
 		lt_settings->link_settings.link_spread);
 
+	link_configure_fixed_vs_pe_retimer(link->ddc,
+			&vendor_lttpr_write_data_dpmf[0],
+			sizeof(vendor_lttpr_write_data_dpmf));
+
 	if (lt_settings->link_settings.lane_count == LANE_COUNT_FOUR) {
 		link_configure_fixed_vs_pe_retimer(link->ddc,
 				&vendor_lttpr_write_data_4lane_1[0], sizeof(vendor_lttpr_write_data_4lane_1));
@@ -552,6 +557,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	const uint8_t vendor_lttpr_write_data_4lane_3[4] = {0x1, 0x6D, 0xF2, 0x18};
 	const uint8_t vendor_lttpr_write_data_4lane_4[4] = {0x1, 0x6C, 0xF2, 0x03};
 	const uint8_t vendor_lttpr_write_data_4lane_5[4] = {0x1, 0x03, 0xF3, 0x06};
+	const uint8_t vendor_lttpr_write_data_dpmf[4] = {0x1, 0x6, 0x70, 0x87};
 	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	uint8_t lane = 0;
 	union down_spread_ctrl downspread = {0};
@@ -639,6 +645,10 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 		DP_DOWNSPREAD_CTRL,
 		lt_settings->link_settings.link_spread);
 
+	link_configure_fixed_vs_pe_retimer(link->ddc,
+			&vendor_lttpr_write_data_dpmf[0],
+			sizeof(vendor_lttpr_write_data_dpmf));
+
 	if (lt_settings->link_settings.lane_count == LANE_COUNT_FOUR) {
 		link_configure_fixed_vs_pe_retimer(link->ddc,
 				&vendor_lttpr_write_data_4lane_1[0], sizeof(vendor_lttpr_write_data_4lane_1));
-- 
2.25.1

