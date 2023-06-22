Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D36CEB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 11:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF7A10E524;
	Thu, 22 Jun 2023 11:01:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9616910E524
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 11:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEZ7YAPO3qRLJPRWUuFb4anEvnQwmcr+GZa+GmMC6C6zheGRFlnIswtFRElQ4y1Q/x1eWyHqBe398KyEHoMbMPcdeDOHJEQD2a8Fu+G4sb3a0//2z5VOEBrfpFnuk+nEj0Z0PYbjeDUM3x8an6VG5H8wr3cnlHRv0ZRHL2SpVf+Ojpkbcx3w/1FiC9iaIDBGmDCyMoUKqCgXsi1rYoiwSc90AETzd7sKntMYL4ywiBjq+nnHQJjFM9kICBHaqJHvO7X90gm3msT8NC3jqwXy2by/4PV8HQ6bDtNOL8YJ9WpGBkvmqPRX9jt8QHJuNt5VEHoPX5kl+wjrzhvVCetWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8GVLpE6FujO49FaqB2TKKNl4nrZTpTWYSB7iikCZcE=;
 b=BOhLghuEmOrP0id9pvcH06FgNnmh6W+Qm7vt0p/UuOcR1fxBNi+p/1haNOp5f7Uq9VWmA7Ukq0sW4S8I04Gb/V1pSXSTDr4NQ0mx5u0pONn935iRaiIfmyQpe5stf6K9+xdvJwyYNYKDhyBnDBBB3OgrirGdSff/URWm5DkVb9pb1cmLLEsPA91SP+uAgRNp4lmQcoo1ecVmT4pCdECT7gpXNQ1Jn2iSjR+Gd+uFlkD9uu98m5zCcnGvqyQ/93sngehvTuU/3UsBM1NMWuRHcnb/wMQSWLqA6/p9ocNpL/yG2NxRm8PK7PEUla7mxbMalqwcBB2Kw7ZBYjgutUXOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8GVLpE6FujO49FaqB2TKKNl4nrZTpTWYSB7iikCZcE=;
 b=XkQeKQKPb+VWk4lO0/lDrH/pfSAXQP3dHOeOAwxQA3w2QhQ4KwwPF2mcc5+D5VUnG3gx5A9xMIgSYzsTPJ8S3G2ovVLkfO1Joxcx/kzFiMjD4EEQ74WgRN5B7kn3/3Drs9O9V8inSFgniKvZpOHB8Zwoaj8mGCy92tiN50w3R9M=
Received: from SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::20)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 11:01:09 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::e7) by SN7P220CA0015.outlook.office365.com
 (2603:10b6:806:123::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 11:01:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 11:01:09 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 06:01:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Remove spaces before tabs in amdgpu_dm_hdcp.c
Date: Thu, 22 Jun 2023 16:30:37 +0530
Message-ID: <20230622110037.1091075-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e193abc-79a0-4b0f-1c87-08db730ffbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3G2XtkaJUM+6M+QjuUqO32MeIYaMt0KTQ7j2jYGq6JebVTDZVE1tVUKqxWF9UvHjcK26naFjoEMBRVzYOucNmDMBOcHHwEC0A1yhDFi3OviQuKP1uzg64HG6vc+YtCswZP1vYAE+OPhxr6d2hOJ6HhvQImmWWCmARUQLxo8cHv6bBbRyWl6L/BMI80EtBLtrPf8eBnqO5NvBUyOFpsHskL1IVMRqtGZtlBU7BVUBpEM/mMP6yrG9iY3uxNDxI05BpTbrdQ9cAw5/gyaIeOgusHJKYnprZem2stOpWZWOMl0vNLHT+JVRV9ohPy6sYYG8d34QjeNn8ZXlBE/dbWQXWMe/Hid0ntZxTXD/yInrOIpnLT8G4nF5cL2I2LFDUgRp3ALF5XTEpuRX6dB7xif7gSd5CFTs+7MkDzZtsVO9yqifvMrX4hbn2dRyThI/W1QGIlPEQmuvLU+ptHCJnoQbk+RMNI+gEsV+kB6TZPEGCMmAXzl/ig2Mkf91TZ2ESjiP77jL1scHfP2ze+tPbvYLSqAqqyboTzyHDU/v84BOpmLRPdrDFoeRAfuOQkLk606FLG6DP/gS+OV/wmqDzJQvf/JQqTc5iiWL0saL8hECv8DvZR3nI3XKBYUhRvR09bjMyVmbzKJ0TvRavyVWPJFsA+bN+Qzrd102OGiCeTuqj50Uz0FLoI00ybAV43Tw7rkkesK2QcwCfSfMj+ES+cwFnuVVQtT1mnwysX/DnuU41U44OzAq9InnBhfpeGDiVyCJKhv1ONSNRGENwLRXd4VcCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(6636002)(4326008)(36756003)(6666004)(2616005)(54906003)(316002)(81166007)(70586007)(82740400003)(70206006)(83380400001)(36860700001)(47076005)(44832011)(1076003)(86362001)(426003)(2906002)(7696005)(5660300002)(8936002)(8676002)(16526019)(26005)(186003)(40460700003)(336012)(41300700001)(40480700001)(356005)(110136005)(478600001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 11:01:09.0428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e193abc-79a0-4b0f-1c87-08db730ffbe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Conform to Linux kernel coding style.

Reported by checkpatch:

WARNING: please, no space before tabs

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 5536d17306d0..3f421107c3b3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -591,19 +591,19 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * cannot throw errors early as it will stop the kernel from writing to sysfs
  *
  * Example 1:
- * 	Good SRM size = 5096
- * 	first call to write 4096 -> PSP fails
- * 	Second call to write 1000 -> PSP Pass -> SRM is set
+ *	Good SRM size = 5096
+ *	first call to write 4096 -> PSP fails
+ *	Second call to write 1000 -> PSP Pass -> SRM is set
  *
  * Example 2:
- * 	Bad SRM size = 4096
- * 	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
- * 	is the last call)
+ *	Bad SRM size = 4096
+ *	first call to write 4096 -> PSP fails (This is the same as above, but we don't know if this
+ *	is the last call)
  *
  * Solution?:
- * 	1: Parse the SRM? -> It is signed so we don't know the EOF
- * 	2: We can have another sysfs that passes the size before calling set. -> simpler solution
- * 	below
+ *	1: Parse the SRM? -> It is signed so we don't know the EOF
+ *	2: We can have another sysfs that passes the size before calling set. -> simpler solution
+ *	below
  *
  * Easy Solution:
  * Always call get after Set to verify if set was successful.
@@ -612,14 +612,14 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  * +----------------------+
  * PSP will only update its srm if its older than the one we are trying to load.
  * Always do set first than get.
- * 	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
- * 	version and save it
+ *	-if we try to "1. SET" a older version PSP will reject it and we can "2. GET" the newer
+ *	version and save it
  *
- * 	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
- * 	same(newer) version back and save it
+ *	-if we try to "1. SET" a newer version PSP will accept it and we can "2. GET" the
+ *	same(newer) version back and save it
  *
- * 	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
- * 	incorrect/corrupted and we should correct our SRM by getting it from PSP
+ *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
+ *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
 static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
@@ -684,9 +684,9 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
 /* From the hdcp spec (5.Renewability) SRM needs to be stored in a non-volatile memory.
  *
  * For example,
- * 	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
- * 	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
- * 	across boot/reboots/suspend/resume/shutdown
+ *	if Application "A" sets the SRM (ver 2) and we reboot/suspend and later when Application "B"
+ *	needs to use HDCP, the version in PSP should be SRM(ver 2). So SRM should be persistent
+ *	across boot/reboots/suspend/resume/shutdown
  *
  * Currently when the system goes down (suspend/shutdown) the SRM is cleared from PSP. For HDCP we need
  * to make the SRM persistent.
@@ -699,8 +699,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin
  *
  * Usermode can read/write to/from PSP using the sysfs interface
  * For example:
- * 	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
- * 	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
+ *	to save SRM from PSP to storage : cat /sys/class/drm/card0/device/hdcp_srm > srmfile
+ *	to load from storage to PSP: cat srmfile > /sys/class/drm/card0/device/hdcp_srm
  */
 static const struct bin_attribute data_attr = {
 	.attr = {.name = "hdcp_srm", .mode = 0664},
-- 
2.25.1

