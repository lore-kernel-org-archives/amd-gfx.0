Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1082D208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y++mMPDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1082D208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64406EADE;
	Fri, 19 Jun 2020 20:13:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2736EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3uYOjszVNC7ZZV9/JWMp0FkfYiPs+YTGfcYUzervwJ2Oz6UNygeorUj54G45JB7EItU7OcmF+GbIRT0KT/qx0XUuxhwDydu0aug+9tl4bHqIXz07Ta6GJynWStYjXnu822HvdlpBWBs98Q+Jxu8A3qiclcVyv5U3nmyzIc9uvsl1RikcpVLxdcxBnJ4Bdj+bA5giESQIE0UavB9fWYjwV/u1oeE87IW5wPGNEKIQcfxVolUvHgSGZyMXcqxSCQsKTwNYctLQj46VPyBR+56a4URC7RLnT+clanAk47tky7w5aGOWIEVRlHTyReWXUNsXjS/1gMT7/eVrqxNV3gOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuf79i2nBo0PfZPNSETF12k8vjaxKYFiNJGpf1d2Sj4=;
 b=ZjilUWnpl2Mqm11fNu/EELTjoXHRbSkqzyZDz+b8a72ZSKVjEBaDzzExgIFEO9coW5Jku2mV/bNWV7ZLMBPb0hHs5TCclGk76KjrVMIeSAeEwHhOHHD57KGOdzFspSm3G9aXo+GEG5kzhlpEc/SZ0UWE6DMc0iPkk2rqhvjzwYCEzZ6ZUl9IKElYdEceH2SnzM2W/732Pb9UkqJr7JhXx/LyFcHtSGvmySolVecXIMwSMlSkSs6amizSVgEodHa1zeL+V2c/fFp3q0HnGDUVEImpr32WVY6BmHu+nA0xlnJz59+Xev0olqZzdGcEp79S6YRkLoxOlgNfts/nyIdJUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuf79i2nBo0PfZPNSETF12k8vjaxKYFiNJGpf1d2Sj4=;
 b=Y++mMPDFHAZhVKOvbRgkOiQNgt0ZOHsz4yVuleWAvZvYwVtBRTOtigqQ/c97+Zyk8MLxIUW9Ax1jz+P3BYVXiKP8AlD2oZMCnALcuLuo7lGDEEzV0rGVcoqn6j8HKExy1KQHEey1TCa8VIBjXPrz/RL4gRMbmSDqkY2vzDxUB58=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:54 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/30] drm/amd/display: [FW Promotion] Release 1.0.18
Date: Fri, 19 Jun 2020 16:12:02 -0400
Message-Id: <20200619201222.2916504-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:53 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ee01590-2484-407c-97cd-08d8148d268a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4087215ADDCD3593DD9EAC9C98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DF4sn7WEc8gGcFAYigjdvaPRJH5QRCHpkn3Vyh1P0mZOP1w5Uanx3ZYjA3qmpN7BKfPFfurQqwOzR2nQeoDu79OuYu5XJifRypBLdAdDFKh9NHuRCkYtvTTJur0cmd5NFpqNqgz+k66CxoVHmQ1xqOlx73g9Qtp9pA3vXGZnxcvPUgCNSuO/Eg/hfbub1AQ6ixGK9oobavmVoRdxyjYwlaVUHduqYqfsSczGFZt2IaL05mWhM1zXjDXjKO9bw2AUs06IRWS8cwAlPaTgc1IElVxBpttg2MhOZsbsV/5lpLvuF6cUl+x2AnrDX46DP/2GFbdFlI4uw0xiogjeT1z+fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DjctQAWEHovpFkJgPT5O6PVoxGRVNZTkuI4WmXCb+tzQCgB6IP3OU/3AFirllWEFQRbz6K2APa5VblgpXvjASDDo0fiZ8pq1yBAGB30FkJ9HD8s7HcnbOeWg2Hri7mxngcZUZCUbGaOfHy6YT8ekODPvUFdCmrCl91YEmmdBvXgKTW1TU8MivDUmGmoXIm7uMAEqrVG4YBJvNVql0QE6rzYdCarJBHhSP5hRzUjYLZDnbbOsrrzUATagLViJzF+kpdNgRx8zNjdjkSswnkozIYq/FndO3qwfTYYTqRwHboi/UJIoP8ZMfXKLzdifLMpARtzPtARLNUEc6bczmZeUL/WkrBnaq3/UG3sAPcG8rpwr/YiD9bjJvPgzQvQ4CRlhSXEbIO9hQ56ohdQNRIuqcdGbJX4XeslDaFUDxx0haPZUNcnELLwdknrr9/DPgvLa6R8ZnX/MhI5v/S9c262JysI/oMthv8KJtJkpg0MZjkW3Galq3rnEBVOEmGfQFn4B47jeGA0Rb9NJHHTMD/TEIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee01590-2484-407c-97cd-08d8148d268a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:54.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryqaaALwYqfLjd+cTpxaBkMW632nTWxr9Y+SgC/EdRZxIbnPEWNYVmquVteYCFyyKylLTw9ymHpMYYwSIdAw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
- Update scratch information for boot status

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 45 ++++++++++++++++---
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 2b399b836aa6..96e1379c4cf8 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x6d5deb31c
+#define DMUB_FW_VERSION_GIT_HASH 0x67e8928df
 #define DMUB_FW_VERSION_MAJOR 1
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 17
+#define DMUB_FW_VERSION_REVISION 18
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
@@ -146,10 +146,8 @@ union dmub_fw_meta {
  * DMCUB scratch registers can be used to determine firmware status.
  * Current scratch register usage is as follows:
  *
- * SCRATCH0: Legacy status register
- * SCRATCH1: Firmware version
- * SCRATCH2: Firmware status bits defined by dmub_fw_status_bit
- * SCRATCH3: Reserved firmware status bits
+ * SCRATCH0: FW Boot Status register
+ * SCRATCH15: FW Boot Options register
  */
 
 /**
@@ -160,6 +158,41 @@ enum dmub_fw_status_bit {
 	DMUB_FW_STATUS_BIT_COMMAND_TABLE_READY = (1 << 1),
 };
 
+
+/* Register bit definition for SCRATCH0 */
+union dmub_fw_boot_status {
+	struct {
+		uint32_t dal_fw : 1;
+		uint32_t mailbox_rdy : 1;
+		uint32_t optimized_init_done : 1;
+		uint32_t reserved : 29;
+	} bits;
+	uint32_t all;
+};
+
+enum dmub_fw_boot_status_bit {
+	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
+	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1),
+	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
+};
+
+/* Register bit definition for SCRATCH15 */
+union dmub_fw_boot_options {
+	struct {
+		uint32_t pemu_env : 1;
+		uint32_t fpga_env : 1;
+		uint32_t optimized_init : 1;
+		uint32_t reserved : 29;
+	} bits;
+	uint32_t all;
+};
+
+enum dmub_fw_boot_options_bit {
+	DMUB_FW_BOOT_OPTION_BIT_PEMU_ENV = (1 << 0),
+	DMUB_FW_BOOT_OPTION_BIT_FPGA_ENV = (1 << 1),
+	DMUB_FW_BOOT_OPTION_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
+};
+
 //==============================================================================
 //</DMUB_STATUS>================================================================
 //==============================================================================
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
