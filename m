Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B32C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DABF20801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oxWNPLJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DABF20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140D16E46B;
	Mon,  8 Jun 2020 04:59:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594B76E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRgGXBWl/3AL4MQkcmfsjwvNwvp01oFVm7IGjN+oi8+vlCmTHjhTuo0qBLl0TmDGH/C577RsUzFaZ/ZoxolbegqEGyNkwi5OEHkweHnw/N+k+BD7MlgKzOXT2JvqwIIkKylL3JdWujB+K2e0Mr3oR/lZEmuY3FZ7J3GohFkKjJvTWQfgNEJcUTzFSqxXXvY6IUl3N4el7IpeNSPprFjywWwn7vJumg++0IlEhQ5NFE4VKfbLwJ5FLhvEfvl5ytdLxmY5+Kw7rYntUAou5iT6J+IA63V24LuHOlJ8FtWlsWCE4xFyK81KnEOjlmVzgTUuXi5zULGhMD+MfnLRkusnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXyPECH2oWb0iEM7TN/nbg+YXQsgUeYSDvnz/lXNsZw=;
 b=XlEFN515qUER+jxKrBHiWWLt3/d6RkHo/xy0d8Iwy0IhzEe/XYjp5TID4TSOQ9DmHflzYrnS5Mq9dnFom6os35zHn5/MMh6yAbVfQiqQwK9LYdfN5u9O8oaAOKMgSHzNab0ZMKvGnB1Y1SfhwLs8f9LVXlnaKmcFgBaqlfLEa2jKm0QRxaJQDEvpZ4pa2U4P99C/nMmjR7npDlg5ynRP7YUgdiZicdXg+miw5uBU2nypC2VSebRxlJmQN/ovXRLiLwzALi3GAvyasIA0j5oooC18VVuSrGkmF/zYTsw1Hj3lo4ia7X9sGuXVoZtmNWZ2QJHWB/ESGDoZbNBTHcbLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXyPECH2oWb0iEM7TN/nbg+YXQsgUeYSDvnz/lXNsZw=;
 b=oxWNPLJ6rS/4gHNmaO0xnZ9nOZSi+oCIIjnwTkUHxSXJU3nIP6U+nheASpHLEWNHSzJ6R5S4hOBog8x/w46uK5sTUGAL+BWZDXttenT5x/Rfb3uULUv6zXd52JDHXwp3NMv+GionXTzeAsQAgKcnqQqqWRzuhBLAW6Ypw0vzZlw=
Received: from MWHPR04CA0036.namprd04.prod.outlook.com (2603:10b6:300:ee::22)
 by MN2PR12MB3583.namprd12.prod.outlook.com (2603:10b6:208:c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:51 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ee:cafe::cc) by MWHPR04CA0036.outlook.office365.com
 (2603:10b6:300:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:49 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:49 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:48 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/28] drm/amd/display: [FW Promotion] Release 1.0.15
Date: Mon, 8 Jun 2020 00:59:25 -0400
Message-ID: <20200608045926.17197-28-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(6666004)(86362001)(316002)(81166007)(2906002)(70206006)(186003)(8676002)(82740400003)(26005)(70586007)(54906003)(47076004)(336012)(356005)(5660300002)(8936002)(6916009)(478600001)(1076003)(83380400001)(36756003)(426003)(2616005)(4326008)(82310400002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8338b004-9483-4505-e7a5-08d80b68c6af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3583:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3583EF93276375CEA844E24FFB850@MN2PR12MB3583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHDsS6Ns4JlIV5Hi0RruNKiVnoE7qaZ8xFYTlu0K2U4uymdwpUx4vaUFnTRukO6FDlMJNgvqcM5SLFfkYrNb7sF4vrsEVkXhr4tjw0zxPsgonD4DcJzJ5qgdK4bCW3JWnDZ9zOqgA1k4XTeS/USXOfHNs3qAFnqzVhQ9m7f0JxW0s2padOP7/Dr16kcOgvWI3mMLjAIyl6PEcBD8K8fW/+MYeX+rBhNtIIWJooCYj/uQ31L0sfi0ofcRJJFp+XkpXlIQKGiGghrRwfnEW8H/cNB8rHdewmzYkcJyC6P7DBCnuy01cGvv0iTy3eV1raaPEB3EGZf2X1WTwSiXQ3W9Z8cNLY3YtkAUqdwPDwdAiVR6ZhqlHJQOPqqidOhjlZXgVWPS+dL5LBioqQbKWpJQ5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:50.9247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8338b004-9483-4505-e7a5-08d80b68c6af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3583
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
- Add new initialization bits for driver to check
  firmware status
- Add command for HW locking via DMUB

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 68 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 5066c639670e..7c03c4798348 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x5470fd231
+#define DMUB_FW_VERSION_GIT_HASH 0xee850bb2f
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 14
+#define DMUB_FW_VERSION_REVISION 15
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -137,8 +137,31 @@ union dmub_fw_meta {
 };
 
 #pragma pack(pop)
+
+//==============================================================================
+//< DMUB_STATUS>================================================================
+//==============================================================================
+
+/**
+ * DMCUB scratch registers can be used to determine firmware status.
+ * Current scratch register usage is as follows:
+ *
+ * SCRATCH0: Legacy status register
+ * SCRATCH1: Firmware version
+ * SCRATCH2: Firmware status bits defined by dmub_fw_status_bit
+ * SCRATCH3: Reserved firmware status bits
+ */
+
+/**
+ * DMCUB firmware status bits for SCRATCH2.
+ */
+enum dmub_fw_status_bit {
+	DMUB_FW_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
+	DMUB_FW_STATUS_BIT_COMMAND_TABLE_READY = (1 << 1),
+};
+
 //==============================================================================
-//</DMUB_META>==================================================================
+//</DMUB_STATUS>================================================================
 //==============================================================================
 //< DMUB_VBIOS>=================================================================
 //==============================================================================
@@ -230,6 +253,7 @@ enum dmub_cmd_type {
 	DMUB_CMD__PLAT_54186_WA = 5,
 	DMUB_CMD__PSR = 64,
 	DMUB_CMD__ABM = 66,
+	DMUB_CMD__HW_LOCK = 69,
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -453,6 +477,44 @@ struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+union dmub_hw_lock_flags {
+	struct {
+		uint8_t lock_pipe   : 1;
+		uint8_t lock_cursor : 1;
+		uint8_t lock_dig    : 1;
+		uint8_t triple_buffer_lock : 1;
+	} bits;
+
+	uint8_t u8All;
+};
+
+struct dmub_hw_lock_inst_flags {
+	uint8_t otg_inst;
+	uint8_t opp_inst;
+	uint8_t dig_inst;
+	uint8_t pad;
+};
+
+enum hw_lock_client {
+	HW_LOCK_CLIENT_DRIVER = 0,
+	HW_LOCK_CLIENT_FW,
+	HW_LOCK_CLIENT_INVALID = 0xFFFFFFFF,
+};
+
+struct dmub_cmd_lock_hw_data {
+	enum hw_lock_client client;
+	struct dmub_hw_lock_inst_flags inst_flags;
+	union dmub_hw_lock_flags hw_locks;
+	uint8_t lock;
+	uint8_t should_release;
+	uint8_t pad;
+};
+
+struct dmub_rb_cmd_lock_hw {
+	struct dmub_cmd_header header;
+	struct dmub_cmd_lock_hw_data lock_hw_data;
+};
+
 enum dmub_cmd_abm_type {
 	DMUB_CMD__ABM_INIT_CONFIG	= 0,
 	DMUB_CMD__ABM_SET_PIPE		= 1,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
