Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39933C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013826052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 013826052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D9C89D89;
	Sun, 24 Oct 2021 13:32:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C1389D89
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5+RMOUbyv3JeDHDsZ9545Tx9/cmldVGLOyWPMwHsHZ+1wUJ5h5JElEC/HkGt+1BDo95tx6jOMxtfBne19ZraFm2i8QdFpO9QuKBtjnYt5xG/r93tmvH8KXBsq5S/AoqyIvMCY9bCEevs92NyE4OiqACNwi07+AxYs1/tmkzUx/A3dn0W6p8YdWvB0fvzXww7ItMQOYaRPkysiZcYYIhZLwd0u3/CZHe6Zka1jAeE0aaPT+MH+zbW8alDYxzBPno0mmL3OhXN7MYeIpsaCSIpf5ayes3IJ87YvdYKPYAvs58Dqi8wyTYLn+YTj53wYsZe89WQFWzlBWCD65hntbJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JvQcqw6Hfhlg2gBVTUSZNJxzL9DVx5GDdtkGEPw6bo=;
 b=ZjcUckAhgjyiGaS6UOFtMfZt/nJkUTlxF0aWSApKbk0fsiP4Hp7ue33xr8TaiBdZvVV9OVEFeD8fyt4V8z5CabQbxzOE9P1x8hCI/vSK6qlrUK7on9fjka78TBpIqOgJJytrLvAKNcoEQcDiZdjNXT3gDrpAIDUNoDQ65lySohiTqe6HfvgHR3bGz8DwQzt0ENmMc5mh2nzXrAdScdII70j54d2yB2FhU5+N5K+3Jvqj4boCI/vP9Vzn4eWOe0nUCm3XEDB7nL/9AawMOb9Un3Is9i8nfsER8fq+RM6FjWlH/r6igftBkRguKjGkRiaxxPQXLoI8wa11vg/01DKTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JvQcqw6Hfhlg2gBVTUSZNJxzL9DVx5GDdtkGEPw6bo=;
 b=xniYu61i2Lj30ks1JlFTHkqrda2be00fptuQ7Iyx9qrNNeyp1TRrOz7ViuAxsPrZG82UvE1tfjMo/LKf63UQB1ZPJLkd6u2L7vs8IsQ/5LBEF/kUFxWlQ1yYR/Na8UiFH7imJCKNI/x19eGEqpOILe+Gx8v+C6RwYC4OuwT2J+M=
Received: from MWHPR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:301:4b::25) by BN6PR12MB1652.namprd12.prod.outlook.com
 (2603:10b6:405:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:20 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::ce) by MWHPR1401CA0015.outlook.office365.com
 (2603:10b6:301:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:19 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:16 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 Haonan Wang <Haonan.Wang2@amd.com>
Subject: [PATCH 08/33] drm/amd/display: Set i2c memory to light sleep during
 hw init
Date: Sun, 24 Oct 2021 09:31:16 -0400
Message-ID: <20211024133141.239861-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a267e924-29f6-4610-b9f6-08d996f2b415
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:
X-Microsoft-Antispam-PRVS: <BN6PR12MB165215737FF7FDE5D791E70998829@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jtgaPj3DYud5yrDR3YSEO4bwROaW0WmyV/tt28/7YzlZ0Zvl+OgjHj2iiV+is54SQXUfoXMJ74EGVFY+HQdilAD4cJkWwcMRQXVKwUjPy1K5WaBEwiuEGU89DUV/m6xJfq0rWLXvwzBR2cHfDVlJqURhOxIWRK08zFcbdxJOyq4Rl4TcyP0xEQC5ETxOGdG1c/2P/ki2MCHaEa98xOAkiiMdFe/lb7wt/u/pIKaFLP5EN5JNgj7uzP0IQijI6mj8PkjJ/1qssg5aCYslk9Sl4BkWGpcwI9hct+BWT+HfZEg8leY4jFDWL0CMTlz5QuiGADm68VaKafLiKm/dU5qmvmk/wzvZ0IuZ78D0u8938k4q0VK2VNt4QagMPzmXHTrsUR+DiQleor3zVsC+cddL4fiabYKrbvZGP+UlV7d6UIHfkWjkJn0xmxj5n2jDi1DQd3jWLfahrDK4jd98RoaVrle+Yw1yyZDjSg+J3tgvxjWO/Iv1v3EkbzT3Vhjbq2bk8/LEZ2aRi13eCfUe5atT/c19SYYXcGKQ23pzLbaYryOsWBAPC8g0YWdYn6nTqQUfhjBN9QTGAF1Y8wCRmdmSJiDMirMGo/AJugTNuuwzLuB1skbF7GHJlLkQ2pIw8EPBj4Dya0HaAnE/1HICvg4HlD4u4xVaiuFz7WRCLqsCXRvmDAa0GwtayUbXJ6hmJBgsU0xYKgJnQ65XGR7LTEfN08KsQcwDFt9KwQzD1HLOYw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(16526019)(36756003)(8676002)(186003)(1076003)(356005)(508600001)(47076005)(26005)(70206006)(70586007)(5660300002)(83380400001)(86362001)(336012)(82310400003)(316002)(2616005)(2906002)(6916009)(8936002)(81166007)(426003)(4326008)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:19.5661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a267e924-29f6-4610-b9f6-08d996f2b415
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
i2c memory doesn't get set to light sleep on hw init as intended

[HOW]
Set i2c to light sleep after reg gets zeroed, ensuring memory power
control doesn't get disabled for any other DIO memory

Reviewed-by: Haonan Wang <Haonan.Wang2@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h        | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
index 296b2f80a1ec..989f5b6907e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
@@ -1151,7 +1151,8 @@ struct dce_hwseq_registers {
 	type DOMAIN_POWER_GATE;\
 	type DOMAIN_PGFSM_PWR_STATUS;\
 	type HPO_HDMISTREAMCLK_G_GATE_DIS;\
-	type DISABLE_HOSTVM_FORCE_ALLOW_PSTATE;
+	type DISABLE_HOSTVM_FORCE_ALLOW_PSTATE;\
+	type I2C_LIGHT_SLEEP_FORCE;
 
 struct dce_hwseq_shift {
 	HWSEQ_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 9a6ad1cebc85..d24ad7754d71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -50,6 +50,7 @@
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
+#include "dce/dce_i2c_hw.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -259,6 +260,10 @@ void dcn31_init_hw(struct dc *dc)
 	/* power AFMT HDMI memory TODO: may move to dis/en output save power*/
 	REG_WRITE(DIO_MEM_PWR_CTRL, 0);
 
+	// Set i2c to light sleep until engine is setup
+	if (dc->debug.enable_mem_low_power.bits.i2c)
+		REG_UPDATE(DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, 1);
+
 	if (!dc->debug.disable_clock_gate) {
 		/* enable all DCN clock gating */
 		REG_WRITE(DCCG_GATE_DISABLE_CNTL, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 12ebd9f8912f..8b4a97e39f1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -899,7 +899,8 @@ static const struct dce_hwseq_registers hwseq_reg = {
 	HWS_SF(, DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
 	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
-	HWS_SF(, MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, mask_sh)
+	HWS_SF(, MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, mask_sh), \
+	HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
 
 static const struct dce_hwseq_shift hwseq_shift = {
 		HWSEQ_DCN31_MASK_SH_LIST(__SHIFT)
-- 
2.25.1

