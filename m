Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECFFC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A2410F64F;
	Wed, 24 Jan 2024 07:02:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F278E10F655
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqyuVIFVHMt3jESJkwpwmSjuDzun4HK70QXMnzT7maefkvRZO0JVSS2v2juFa66eM2alWyqO/SwcaRsW87LjhMdu3r80HB1AuIoWpwK93C4HFLp4blCL6NisSy01V6J3whQhu8Zmy1Yljqp5Ww47ttVsiNGtEmqdACIvVeNGT9EwnZgaDHn91SksLtIF9d+CW/Dns4XdbdNfDe+MQRZ7O9diY2t4fl40mtQuvBevqamHHyv6J9PK0HtcLoDvTPLxarbe/mL5ncT4G6L4f1QJ89DKjCYsKV/GH3dGwjIUibEDXJ1WTukbDGbTbr0WBvreFgZlW6bKFNrRNBILg7hZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug2T5XiFEV0iuDwWBJBqf7DXdish8aMsnT/P3hXEIvE=;
 b=ee3dBUCFEXeO4yMKWmCWsNpRs5r5t4I1doGA2XUO+BC4i63SN/hofxA3sLtuYTa1l4g6i5F/jUc+5sxzukc6uzHmyezXuaUqwCPRqRnXCUnabELA2cHR1xtZOgH7/mwmfdX8m0qkorbV2VfGbJ24TPD52kgzIxAHh/U7Ettk7jMzP4jTAyQtESU8sPliYv23ioaslpIXwBLSC4o3O+73YukV8nv5iNKQe10SBPHhfB5Fobq/iNs1N+6y+7frHvUe8CSiYjaxjEKCqIVragZRRc6flN+KNmNewz/DWGjCvib116w07mKSo/tsPBbtMLXPXtEu/t3WPFcL+LDx5BcoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug2T5XiFEV0iuDwWBJBqf7DXdish8aMsnT/P3hXEIvE=;
 b=QJrZFDpd/Ap0XLRS94b3lMCHDVgFY6FH/hDDFLx/I9zWRC5k/fOZq6SXJWdAzaUSoQ3P+ooBtg7qsfY5ye7CjbrBjrg4gAIYqillMNXuPwBPWBOCo2FWVg1kBt/NM4aCFcNRNOszf/eQmnTRdQZQKQELOZ6zutfNhirkI8ysX6g=
Received: from MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21) by
 SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:45 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::19) by MW2PR16CA0008.outlook.office365.com
 (2603:10b6:907::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:44 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:41 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: refine code for dmcub inbox1 ring
 buffer debug
Date: Wed, 24 Jan 2024 15:01:48 +0800
Message-ID: <20240124070159.1900622-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
References: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ee4f6f-3b36-4d88-39c1-08dc1caa77a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DULlS47K727LwEZU1cbOlsCNtZxP8CyDyG4Vn45GqlfFlxXB9uWUjED1Jk2srfXZzcpK/sfFu7aSUx45AwICqAOX56Ea1MuVR5sFgd0jMH/E7Mv17UK3vSbWbtYis7Qn9WveMl0VDP3yCy7tdZ4ejsOMK++nrl0hXcyQjglSgzBmyYYd4YCEL5OobmUlrRzZpG1nJDkCGtXP59RxBYeheYW3yHhkzqUJuI3q3czQngpJC50fu5bLMmaIuLOqe8lwWbdJ7RtbaxzFWDY1CVzfcISz+UGnHKOm7riaxXeHSX3CdOgQuSObo/7UHRhU4+2+dhrZtiaQGaep+T8XF9CPLI+YM+2/32r/FFs38UCiF3h1SvSPtqX/Q8v24Xonmu4k3HhwWEzYw61UNaKTI199KSWVz8qU+SGDn6Ayn9bb6LSgNxqXBMypnhjwkVTY7S+LRsIONsS9BCSa7svSmq9lclwdq5CKrOrC+Bcn8OXzFXxsQZeopR6yFhj95sf/ekjNkSljhxHaOTS2IeaKErSZtlF+IHRZviDuauB7AH+Dw8muKoyC41/58lqhGf2gknfvIfz71S1QbGJgx0XO1SIP8bhEjgeoT7CorcTJULpdaR54lesykHO6u0b5pnR1t3OFXf0aYrxUdXn2upLR8n0Q0dLwHXP+9kU6rIhTe0myFhlyNZLLAXBFwDeUuHE3QuORy7s1W9uH1vnmYFFtNf9Qob+sr7/bEgWBIhhY6n7Q5t6M/QTpw7VrVaFXmcja1SBKN9LBGsne3AtAZaMsEMqrpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(8936002)(8676002)(4326008)(2906002)(5660300002)(86362001)(316002)(70586007)(70206006)(54906003)(6916009)(36756003)(36860700001)(47076005)(82740400003)(81166007)(356005)(7696005)(478600001)(83380400001)(2616005)(26005)(1076003)(426003)(336012)(41300700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:45.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ee4f6f-3b36-4d88-39c1-08dc1caa77a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
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
Cc: Fudongwang <fudong.wang@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fudongwang <fudong.wang@amd.com>

[Why]
1. To watch dmcub inbox1 ring buffer cmd type without tools
2. dmub_cmd_PLAT_54186_wa 66 bytes

[How]
Added dmcub cmd type enum: unsigned char for debug use only,
also fixed 66 bytes issue by using unsigned int in bit
define instead of unsigned char.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Fudongwang <fudong.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     |  4 ----
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 410420683f31..0684a0b93637 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -78,10 +78,6 @@ struct dmub_srv_dcn31_regs;
 
 struct dmcub_trace_buf_entry;
 
-struct dmcub_inbox1_buf {
-	union dmub_rb_cmd cmd[DMUB_RB_MAX_ENTRY];
-};
-
 /* enum dmub_window_memory_type - memory location type specification for windows */
 enum dmub_window_memory_type {
 	DMUB_WINDOW_MEMORY_TYPE_FB = 0,
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 89717076933e..49bc1e41ac67 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1265,11 +1265,11 @@ struct dmub_cmd_PLAT_54186_wa {
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C; /**< reg value */
 	uint32_t DCSURF_PRIMARY_SURFACE_ADDRESS_C; /**< reg value */
 	struct {
-		uint8_t hubp_inst : 4; /**< HUBP instance */
-		uint8_t tmz_surface : 1; /**< TMZ enable or disable */
-		uint8_t immediate :1; /**< Immediate flip */
-		uint8_t vmid : 4; /**< VMID */
-		uint8_t grph_stereo : 1; /**< 1 if stereo */
+		uint32_t hubp_inst : 4; /**< HUBP instance */
+		uint32_t tmz_surface : 1; /**< TMZ enable or disable */
+		uint32_t immediate :1; /**< Immediate flip */
+		uint32_t vmid : 4; /**< VMID */
+		uint32_t grph_stereo : 1; /**< 1 if stereo */
 		uint32_t reserved : 21; /**< Reserved */
 	} flip_params; /**< Pageflip parameters */
 	uint32_t reserved[9]; /**< Reserved bits */
-- 
2.34.1

