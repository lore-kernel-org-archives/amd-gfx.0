Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A0DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 14:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C1410E2F8;
	Mon, 24 Jan 2022 14:17:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4020110E31A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 14:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSVMOtoPplX7berLNGiAE70vDyIm0SDqVOOq4tVNf6ODs+46pkrhfpJt7Pn4k9J5LC6u37qpcXBsXITRVidO00xfh1rnw8IyhlqPjw2K8eM7P2wKos8qfMa8xTneSBiSMRT2DNLnuOFzzL7mia9rVNQfYpDZq8Z7ik7WeottU+YL/FB40jFaXykcbE9IbAI1CLf0Tjto70XzYV+GZhKc41cwTR8Buj4pOpUbb3wcIt4nS3I34jMsbo7JiG4dTFdd74iDc2ui0JREQs0wjJ5RXZUjqzob+zyyE0VJmillkkaM816RQqBneq6Pthu9gqUnpzQ8rFZIxGuz1g5oS8RlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM8E4Hxj/xiWtNWSuDhrCg7KPQckxCJIEY45tXmn+a0=;
 b=ZaOl42FGO+3HJTFIJ6AgtN2+fBUBDFZZNoC2MQQOnlfNxDhDh4yWUS6TrBWMxV722nBruUL6ADqCltfbyzd/lmOtBhSxTd0NH40WomCkEDhWKFP3iW6U5jdJXzXFjoWECDRtvBBkMiE3+lj5qsVSX+pN6Vomx+4vBv9DF84R0XLsRFEn361ggS+fdeqhYHa7022OZUU2knX3+6uNQRYEdN2NP1Rv3TarqBfWPNoM6CPsPYXkQJavYCCjcyo825RRrBijDSv3JQm72YdepQupxUaD58pfaxS8r/FnOKhtKVgxTcoFx0KmusCKx8QJ0iewe+NwbW/00FDIbzc2IBMeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM8E4Hxj/xiWtNWSuDhrCg7KPQckxCJIEY45tXmn+a0=;
 b=GZkvbEnIdWsCx6a++ORRb2kAIOBd54GZqZisw+n1ttMszEo1iyuF5OXQc0cE1Hw8D6ZSzusHL/HZ35+hTLyOTyKO3wJ7fiYeHePvlG9ILqXl9j0V0zhk+Vh5JmKqGRQY2E6FWeKB6NQA7c5gnBmKOp2qSD9SfNa3p6evauQ21K0=
Received: from DM5PR15CA0033.namprd15.prod.outlook.com (2603:10b6:4:4b::19) by
 MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Mon, 24 Jan 2022 14:17:28 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::f4) by DM5PR15CA0033.outlook.office365.com
 (2603:10b6:4:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Mon, 24 Jan 2022 14:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 14:17:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 24 Jan
 2022 08:17:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: To modify the condition in
 indicating branch device"
Date: Mon, 24 Jan 2022 09:17:14 -0500
Message-ID: <20220124141714.1199710-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14a33737-3697-43e6-3d66-08d9df44403a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1454CC12AB5F3795377356F0F75E9@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdPsGw2MmsWSUR/MY2/aqnKPr/kXY45wDS9Ku3qgyTRsLmiTEkUI7m0ELxRsxl0L6bvr9hmgkDHwtUlHhWrps1zGZgtfFZ+jp8254daCqg/Oz7JAtCY65wNiq3VvpJOfhd+1SxMXpkDRAfPIb9sJg26jYCZtYbwkYJT/88UfCjdRwoIpaMvTmeCoGWOe+2fmuhG3hRIHKeVZeCbnWBVEQ2i/DosWs9iVSmVAh+PrKboCoKRlhxESvMJ6oss20WstMCsCUb7IVlCMHqJCWyEpT9k9VLgCrp9dgegHorfvneTd2VLUJ/5rsPPkYNpR3TK+IyBnEewLvijRoiyJJoc3ll5rR3BYxjw7/jawlhUWnqJtiN+rNywaueHCbhQ/rcXxzcULiIyPQKnhpIe8I8+vsmnu2Kt37jo1SA9qGejUUqWK4e8CJjbtD3e0MP0TyXr9HYIMOEkslwyY0MOlX05GqMLyWfOFzEQnHKwTRqTrIDQRtvDHv62axaHa9zjef2nkSKEG9YelUHxlKnlsnXUA0a1QSgGgkhZpa8g5J0G68InK9hFy3vdGQo8Iw58GAvk1rVi4b4wCKc3qVVUuiZ5pmDJ2yRzgIWDIr6j6k+gP6YrBETBZ+xZmDIg5IovbJQGaQ36oJD6GW6nO+2kj3qTP9D7czm8NbFe8xgWMQN1lrzpQc/CQcFXMd8OCdFAYZVd51AqD10xE3b5qaYbxUCObVtjeoUvSdbUCDNtffx2GsTZ3FT4+oajn6ydnsw3nnuU4qHssV68zFO1qIlh8jHn+xYDhZRBowBFc2DjXLvFaEnU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(356005)(7696005)(70206006)(36860700001)(6916009)(83380400001)(966005)(82310400004)(8676002)(1076003)(54906003)(336012)(86362001)(36756003)(16526019)(186003)(508600001)(426003)(8936002)(6666004)(2616005)(81166007)(26005)(70586007)(47076005)(40460700003)(316002)(5660300002)(2906002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:17:27.7183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a33737-3697-43e6-3d66-08d9df44403a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Martin Tsai <martin.tsai@amd.com>,
 Bindu Ramamurthy <bindu.r@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This breaks HDMI audio.

This reverts commit 9413b23fadad3861f5afd626ac44ef83ad8068ab.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1536
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Martin Tsai <martin.tsai@amd.com>
Cc: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6f6929435885..eb4432dca761 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5039,7 +5039,13 @@ static void get_active_converter_info(
 	}
 
 	/* DPCD 0x5 bit 0 = 1, it indicate it's branch device */
-	link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
+	if (ds_port.fields.PORT_TYPE == DOWNSTREAM_DP) {
+		link->dpcd_caps.is_branch_dev = false;
+	}
+
+	else {
+		link->dpcd_caps.is_branch_dev = ds_port.fields.PORT_PRESENT;
+	}
 
 	switch (ds_port.fields.PORT_TYPE) {
 	case DOWNSTREAM_VGA:
-- 
2.34.1

