Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E58CC77B76
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA10410ED50;
	Thu, 20 Apr 2023 23:50:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E914A10ED50
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9h+9zQHeVnG+PyQG3DI7pkuhVDQvq3m8Q2zmxoXjdyVjUfrJlx0nC/flLmuTBjCAy8eXqMwtVRKdJSGMQlCfZek01zCvrbcWvxZZd61/acwVflUfQwiY7DP1bjU9xsv+xdSAv6b0jF8oZznInmQrBu+t7l3p1Gciv+B8+iv4CE7QkbxUKfkT0tbMgCyg45fS03LFO4mlMDPOUwPWAAwnjSyIupc9RgXD0TiLtBuNM6T9DbbP0rVKQJxbuLVdrFAfqJbR6ayKsD2HlF5JALe0soAawzN5EJMU45M5RZwzZpa25HPjSBaIwd0N1AdvAbZ+ljbYGNGkoBbKSlNeEYlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNSWUkeU3eVePCWVClCJJQ9aLfEUZBtKNqpmSHl0m14=;
 b=S0v6UJUy9TCSKwQJN3RFvltey6jiVO385upV1PA+Kie0t+j4j5CQ+r7dn6Qs5gpO2UHZtAtrSai/Oh6dRiatB3KDIr18coOhhlcHwGjMD+wLL+VQF62IHk9/3N9dfrV43iF1p2qmBWUNrCwfP56RMlivjUojYkSapxWBJnhat+lUvXFgdfsNDu9sFRHfluZNklnYKNiAbxOeCd25yu/1IdrSz/ZKY6KPRM1aHjmn9XgKPLVrRAPrjfCD52tyjH6rPlEq5QO3Ox5IqSyx+gQldMR792JaWjo88t8AJ30rIj0JL+aEfGQGdwUDGO/nQE3ZjGyg+GIeTJJ+1GeU1IYMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNSWUkeU3eVePCWVClCJJQ9aLfEUZBtKNqpmSHl0m14=;
 b=eRBJpMWrwxhgxMkcv0DIXIsyV9FpQJsn1TOXd2qkzeBZg5UtvBziFfbxXkMNAHoOjhA/40CYrjYUmr/yIioKwx3ViTl6CRCRd2vcUEOnYWgkWjkWGAnMr0pnFtQqmJ4i4oJNvEllq9p63lwOqHm5sMV0hx6bi4i7fvZZirJlaE4=
Received: from DS7PR03CA0210.namprd03.prod.outlook.com (2603:10b6:5:3b6::35)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 20 Apr
 2023 23:50:20 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::66) by DS7PR03CA0210.outlook.office365.com
 (2603:10b6:5:3b6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.26 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:17 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: Restore rptr/wptr for DMCUB as
 workaround
Date: Thu, 20 Apr 2023 17:49:37 -0600
Message-ID: <20230420234951.1772270-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: e0527620-c478-45c0-fab9-08db41fa0010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CINW6P/f1g1O9RLqomChPbG5nJ60HEXO++nrYJft4E5pcO9cQVEoXUrGU9XJHA9K6yBSBSgVdSnBvFEy/D7ZgDMdsGzyYhrMCIGhtKEi7JEwiRI5QN4LZ/55+TXQety88iPHJGYLPf1w0t9oE1HaIpdHYSNqTL4SDIqRaI/tQYOzkZzYe9lx8TyR9Wu86XPur9ADndQZ2O3R/91+2w1kGHnxtghAjX3+dD6DKjFBtumWeAB5uFxwKWa4Ak7UjS+Bmd/GfW5UC22tVcUkyKAVTAg061M45j/fspkXLAffNPXtHI8FkUEeJ+zi3tKlYuz6W8jjYZp97+lvPJM5CkeaFYetyXZdOGIIMVp/vwZZ5CPOKFRl2ZhY/T8ProFp2CVIVs6wg/OqrxAji7fV3m8V37dc9e+m7ngARkIDvhWIjUVDp9pwK1HBahaRWjphWSP8X8nJGFP4+rGFpJZ1ukJMESevpnUPznmY7qyQm8+8UhNQ8tGNujY1X8BMQPQ2qQSS3V0W3T8CKLy1EZNVoQ5bB60M3E7SeHGRHxVH8CfJHwNbsNTeGsBuLVWsvqnFSlvUBcba7Jghhzhb/jUzbC20kcOUdN0UdrzdhpwV0DZz0HQu9jzbWBnldvidE/bNAYApBFnQcTuxk+LbuDnJKyGAXN7g58so7ezGKOwu7YTWLuv7fZTDnfsBB7I1Pw6RkSsYR/8p3qlQc2YNPI6FpyrAPDJJYDkFkmtlUPYK8cJDsB4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(356005)(36756003)(336012)(83380400001)(81166007)(47076005)(40480700001)(82740400003)(26005)(426003)(86362001)(2616005)(316002)(2906002)(36860700001)(16526019)(186003)(5660300002)(1076003)(6666004)(4326008)(70206006)(8936002)(40460700003)(8676002)(41300700001)(6916009)(82310400005)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:20.1018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0527620-c478-45c0-fab9-08db41fa0010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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
 qingqing.zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[Why]
States may be desync after resume.

[How]
Sync sw state with hw state.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 14 ++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c   |  5 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c   |  5 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h   |  2 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c   |  5 +++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h   |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 17 +++++++++++++++++
 8 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 719bf9bb168a..d35432c21856 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -340,6 +340,8 @@ struct dmub_srv_hw_funcs {
 	void (*setup_mailbox)(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
 
+	uint32_t (*get_inbox1_wptr)(struct dmub_srv *dmub);
+
 	uint32_t (*get_inbox1_rptr)(struct dmub_srv *dmub);
 
 	void (*set_inbox1_wptr)(struct dmub_srv *dmub, uint32_t wptr_offset);
@@ -600,6 +602,18 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
  */
 enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub);
 
+/**
+ * dmub_srv_sync_inbox1() - sync sw state with hw state
+ * @dmub: the dmub service
+ *
+ * Sync sw state with hw state when resume from S0i3
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub);
+
 /**
  * dmub_srv_cmd_queue() - queues a command to the DMUB
  * @dmub: the dmub service
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index a6540e27044d..98dad0d47e72 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -282,6 +282,11 @@ void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
 }
 
+uint32_t dmub_dcn20_get_inbox1_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_WPTR);
+}
+
 uint32_t dmub_dcn20_get_inbox1_rptr(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_INBOX1_RPTR);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index c2e5831ac52c..1df128e57ed3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -202,6 +202,8 @@ void dmub_dcn20_setup_windows(struct dmub_srv *dmub,
 void dmub_dcn20_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
 
+uint32_t dmub_dcn20_get_inbox1_wptr(struct dmub_srv *dmub);
+
 uint32_t dmub_dcn20_get_inbox1_rptr(struct dmub_srv *dmub);
 
 void dmub_dcn20_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index c90b9ee42e12..ebf7aeec4029 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -242,6 +242,11 @@ void dmub_dcn31_setup_mailbox(struct dmub_srv *dmub,
 	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
 }
 
+uint32_t dmub_dcn31_get_inbox1_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_WPTR);
+}
+
 uint32_t dmub_dcn31_get_inbox1_rptr(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_INBOX1_RPTR);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index f6db6f89d45d..7d5c10ee539b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -204,6 +204,8 @@ void dmub_dcn31_setup_windows(struct dmub_srv *dmub,
 void dmub_dcn31_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
 
+uint32_t dmub_dcn31_get_inbox1_wptr(struct dmub_srv *dmub);
+
 uint32_t dmub_dcn31_get_inbox1_rptr(struct dmub_srv *dmub);
 
 void dmub_dcn31_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index a7d5607459ed..21dd6cbdb106 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -266,6 +266,11 @@ void dmub_dcn32_setup_mailbox(struct dmub_srv *dmub,
 	REG_WRITE(DMCUB_INBOX1_SIZE, inbox1->top - inbox1->base);
 }
 
+uint32_t dmub_dcn32_get_inbox1_wptr(struct dmub_srv *dmub)
+{
+	return REG_READ(DMCUB_INBOX1_WPTR);
+}
+
 uint32_t dmub_dcn32_get_inbox1_rptr(struct dmub_srv *dmub)
 {
 	return REG_READ(DMCUB_INBOX1_RPTR);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index 7d1a6eb4d665..f15336b6e22b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -206,6 +206,8 @@ void dmub_dcn32_setup_windows(struct dmub_srv *dmub,
 void dmub_dcn32_setup_mailbox(struct dmub_srv *dmub,
 			      const struct dmub_region *inbox1);
 
+uint32_t dmub_dcn32_get_inbox1_wptr(struct dmub_srv *dmub);
+
 uint32_t dmub_dcn32_get_inbox1_rptr(struct dmub_srv *dmub);
 
 void dmub_dcn32_set_inbox1_wptr(struct dmub_srv *dmub, uint32_t wptr_offset);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 67c53f7e589c..ea3bed70a229 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -166,6 +166,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->backdoor_load = dmub_dcn20_backdoor_load;
 		funcs->setup_windows = dmub_dcn20_setup_windows;
 		funcs->setup_mailbox = dmub_dcn20_setup_mailbox;
+		funcs->get_inbox1_wptr = dmub_dcn20_get_inbox1_wptr;
 		funcs->get_inbox1_rptr = dmub_dcn20_get_inbox1_rptr;
 		funcs->set_inbox1_wptr = dmub_dcn20_set_inbox1_wptr;
 		funcs->is_supported = dmub_dcn20_is_supported;
@@ -235,6 +236,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
 		funcs->setup_windows = dmub_dcn31_setup_windows;
 		funcs->setup_mailbox = dmub_dcn31_setup_mailbox;
+		funcs->get_inbox1_wptr = dmub_dcn31_get_inbox1_wptr;
 		funcs->get_inbox1_rptr = dmub_dcn31_get_inbox1_rptr;
 		funcs->set_inbox1_wptr = dmub_dcn31_set_inbox1_wptr;
 		funcs->setup_out_mailbox = dmub_dcn31_setup_out_mailbox;
@@ -273,6 +275,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->backdoor_load_zfb_mode = dmub_dcn32_backdoor_load_zfb_mode;
 		funcs->setup_windows = dmub_dcn32_setup_windows;
 		funcs->setup_mailbox = dmub_dcn32_setup_mailbox;
+		funcs->get_inbox1_wptr = dmub_dcn32_get_inbox1_wptr;
 		funcs->get_inbox1_rptr = dmub_dcn32_get_inbox1_rptr;
 		funcs->set_inbox1_wptr = dmub_dcn32_set_inbox1_wptr;
 		funcs->setup_out_mailbox = dmub_dcn32_setup_out_mailbox;
@@ -642,6 +645,20 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub)
+{
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_funcs.get_inbox1_rptr && dmub->hw_funcs.get_inbox1_wptr) {
+		dmub->inbox1_rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+		dmub->inbox1_rb.wrpt = dmub->hw_funcs.get_inbox1_wptr(dmub);
+		dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
+	}
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 {
 	if (!dmub->sw_init)
-- 
2.39.2

