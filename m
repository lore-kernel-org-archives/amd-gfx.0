Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651A4C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0047810F127;
	Fri,  8 Apr 2022 17:27:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8236210F126
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8b8w0VemODEur7uEq62v+JZ4k35O8UiwLghvHsbCYp4IC3GIEuH7PtuD90LO1bFeyNtNQ0bg2zZwqLE1J9mnln0mV25Voizc+8p6cxMuYFrVAx4e687hwPQNoZVoMZpSd5B5sBnpmtF4/NckdOio93DwxztEGOz/+OUuHRmX6KDrtuP+D2rMYk/SgvpDwmO8dxgMdndsyOkMjqwquvsSO9eFT3rdowF0D44vIFYSka8Mpmx4z+lw8SzkAzIPPn8X5DhRzOdhDHvHkzwU3moXBL73aOYGjeJIWCdMdb/OgBT4BzL6ulvg7YJQSTOcsDMemZ++VYghrlRWGjHgIMjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrnhK8UUgDImUpIjatA8QtaQBHMFxK60PAmAdGqwiGU=;
 b=mwmWP+Vv/KewmDZgfJPtFAi6tCkqvO9PUmdvt/UWzDfnDE025IMrpIZ5NRWGEJL5cFW7OqtifagwYNQ3i/DOJS3i42kUGJSzmGP3M4InNZaqIR4tKAFZmnBWMdAfYPzsX34XX+yICpqUWz125HKbxtRz6/gbo4DZDGgAlc1q53V5ShW/0sKqgsc8Jv/wreW1Hk0J1F5xVjyJKrzVTiLYsU7dL0OCHgstU799lnvdJvGTP9LcYf+h1n1GRrlS8ivfGhHsekGg47uLJyoGr14paqdiWA/lapKdiH0S0VUvm/D/VpzQ40ojuNNIYCiESJ0APBKBOHwVvxuvFy7w3pqzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrnhK8UUgDImUpIjatA8QtaQBHMFxK60PAmAdGqwiGU=;
 b=UpDw9JPlC2CJtRy8Z1SCQgk792D5tx1NlA/n4/wwY05d587gZEz+1RjpYHA4BvcCFCiGaiDfD+Vlzu0JSmKhrSn+nMgJzrhsUZdXPAbQkoD6EAhkTpjRLkkdlYmfPaXP3HwGoJ5uo+b+XyOweuuu9QzEsz3xPyS9bCHP+7mJRY4=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 17:27:53 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::ad) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 17:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 17:27:53 +0000
Received: from lnxpromo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 12:27:45 -0500
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/20] drm/amd/display: expose skip_detection_link_training to
 debugfs
Date: Fri, 8 Apr 2022 13:19:07 -0400
Message-ID: <20220408171911.601615-17-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
References: <20220408171911.601615-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72563c07-c88e-4d17-4818-08da19851d1e
X-MS-TrafficTypeDiagnostic: DS7PR12MB5720:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5720FE48B71DFA497BF4AED7FCE99@DS7PR12MB5720.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsWEHvDzx/lwqHx5XkkdU0FyB+7SQkRcveJGYjIX6DBRN/De8I/nZC1MgCSqFS4+4q4eq3efbJ1zvr54vroVlDdYWkde6AxfcyxuUUQD4le6xXUzi7F7ULvFPS/5cxwasE/CdBPskHfpFhfZamCLO+OBPy92cGv3TPInihX1z0+9uV2XWOh/1B9ibnM5CTQLtBkgP4MT7yWiuNeKEdPqzAnYiqxpBONWZOqz6/A7fhbevc+spIrIAAgkoWVwwFxbDxvg5X101duf1ErwwaYDeizrCm0B6005/4ptpcDQ42a+iTuUzgbDpI0edUK9Zdeuq2VHxk0HU3Iv+ejci7fPM7uJgnifDJCdRpuco1C2OWLj99R3EZWOWidpuSMfei98xrQRpajpvNmYDw6+25/A7IzyhXsE/609I+1oFm92sOOAXpZNMiavr4zmZgkTPbLi7ZOp99xXkSIy7bY/sdU+NtADjw6PYN9FeUEZXTjcvYaVJy1hM+21Kk3xXykBsStZvGypzQVhurTYq9an28r6Hp6+UExihcD/cBgIOCKfzi9dSrirGaWxVBR3HMhrGjZSszOnwmY5IFDEVSIafukHPCeupTMYaS7b7LLCe7SaACH29/SXFFIQ17y3CE/yRwpWFkkbQRxqLcRdPbZGgb3Je9IDReEO4CUrTCunjHl8zDI73KUM88szzokHGvOW2rCR2fbqo0NcAxBum6AZOIAfDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(2616005)(356005)(36860700001)(82310400005)(83380400001)(86362001)(8936002)(47076005)(6916009)(54906003)(316002)(81166007)(40460700003)(186003)(36756003)(26005)(70206006)(336012)(426003)(16526019)(4326008)(8676002)(70586007)(5660300002)(6666004)(2906002)(7696005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 17:27:53.5121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72563c07-c88e-4d17-4818-08da19851d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why] within dc link detecion, dp link training will be
executed for external sst dp. for debug purpose, we may
need skip dp link training.

[How] expose dc debug option to skip_detection_link_training
to debugfs

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: hersen wu <hersenxs.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index d881e695d97c..5193afb067d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3495,6 +3495,40 @@ DEFINE_SHOW_ATTRIBUTE(mst_topo);
 DEFINE_DEBUGFS_ATTRIBUTE(visual_confirm_fops, visual_confirm_get,
 			 visual_confirm_set, "%llu\n");
 
+
+/*
+ * Sets the DC skip_detection_link_training debug option from the given string.
+ * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_skip_detection_link_training
+ */
+static int skip_detection_link_training_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val == 0)
+		adev->dm.dc->debug.skip_detection_link_training = false;
+	else
+		adev->dm.dc->debug.skip_detection_link_training = true;
+
+	return 0;
+}
+
+/*
+ * Reads the DC skip_detection_link_training debug option value into the given buffer.
+ * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_skip_detection_link_training
+ */
+static int skip_detection_link_training_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.dc->debug.skip_detection_link_training;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(skip_detection_link_training_fops,
+			 skip_detection_link_training_get,
+			 skip_detection_link_training_set, "%llu\n");
+
 /*
  * Dumps the DCC_EN bit for each pipe.
  * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dcc_en
@@ -3588,6 +3622,9 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
 				   &visual_confirm_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_skip_detection_link_training", 0644, root, adev,
+				   &skip_detection_link_training_fops);
+
 	debugfs_create_file_unsafe("amdgpu_dm_dmub_tracebuffer", 0644, root,
 				   adev, &dmub_tracebuffer_fops);
 
-- 
2.32.0

