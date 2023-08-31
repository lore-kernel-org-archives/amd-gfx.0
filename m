Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E92C83F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 06:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC10510E56C;
	Thu, 31 Aug 2023 06:27:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E226C10E56C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 06:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM4mBDMyyimX1jM0V+qtnUOOUh2IJqDZKSODpSHJHZlpNq9HtdBbyEivu+zZnYW5V2qyBbVavbFQ/+vA5yUfHRCL7m7hMZ4ytkcu1HhdCibibNcvBvF7lW9DitZ79ngnUajETaCL67BIPNNwWFAfLTkju20NcQZLJQhTFgz4rCtYEp0Wi5Yv6W/Vmog4BXjKIak+AX8ToH6S1forRIsuGpIZrbLzzmN7dAppv83ZZK8rydg8OiZVJjta5mxIbmneekgNxMnNyHiydoxUMEBJsTDGkUwcUAiCUb0RPk2NdEAdFd0aHRtiZak+DF6mIVAuCDpzYUl33TstaC5Ko5qPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVMTA96luVXKr/RnFBSgb9duxPM9oZde8NQFO/Llomk=;
 b=fd7cozvT6pJKvhAKfnjyMxXtZbf/W4DVKCffWBT7qZzLpoQgwcQTPtk+3dezruvZMOTXvKwkIEc19o9g9T8xH4uC/brjRx5CpDF/Q5IVPfe+PJ72yAk73vEX5UNSANA5QMZnZyatpugAqpx/Ef+3o/+XuBZ4MIuVtn9Po+N5R6SlVX9cNqvdW3n55UL7cNlua/I84HbyzxjhMdT3kp0DEpo2M6XLDszzCVFn0hNPCXENM9PuP8yeW7wEGf7Hvqw2+i2d68UEqt6/i0DNMfFe39YvEHcCEZ90g49rX1yJwUk2SVlhPBPTVxLF6rlVHX4GHGkHFPA2WfUSC05EcX6cSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVMTA96luVXKr/RnFBSgb9duxPM9oZde8NQFO/Llomk=;
 b=tyCcmCg5PWAMGoLy6rJMG8FnQayd2Rka3YCs5ugE18n43nHI6yGwONsZMR+CsrzM1hs6DVI8GFjUFqeeKoqGrUwsOLc1+Vze8I4aDHS0QxtMdccrqInHDzCwHGU3gucP0qrDfxtDLdEDjTBJEIjvdNXktmvm08yqdhwaIGkFZJc=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 06:27:33 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::77) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Thu, 31 Aug 2023 06:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 06:27:32 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:27:30 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/pm: only poweron/off vcn/jpeg when they are valid.
Date: Thu, 31 Aug 2023 14:27:12 +0800
Message-ID: <20230831062712.4122679-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 55483b51-5b61-4943-6041-08dba9eb5bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlLGUlBcbY1Lad96YNlHC4vzYLxm+syt8K4sjrKwoGUbRtLF4FJNpFO0HX6I8hl8GdnojtQNs2ea6QlYLc9XtYgJbDY3NU7O6Wt0NlNLRwh95vKlKiA2xZRnMr2aIxwg6lP7XT/NomQvn0SQlvM8Y0lvDHOnv89dNJVSasewdEoH6O6Vy0glEW/2Zax6FHXNThoAXql4IwuqJFtEKcJ03DQYVj3PRT470VWsd9x1hqAuoMZjhNdRFKvs264IE8UqrYCAmC9u+UnXhKAU+BZPQRr1SgRsLX9h+vUqrrrTbm3wSJ507R7NMMbBwUrJbXfHnmWrIPrWCvScXmpX6ak81frNO049sYUhZ43fh5jUbahOJzeNSvm1vjk9c6+oRUim9uHrXnSbfoxDs5/yWPS5QpsOSEkYLD79utA9oKNpeXPIG6HN3cBawgtUDbeIv6MsOV0e6sf52CmVms7bnY+qXYrJR5IaQzWJkutaO7poiya8mUomXUlQqVLFUAjo3w/IDqLPUjjOF1wvag2b3mBaXP5O7EdBm+UO4OAGbDUt47IIHZ/ng9dzHAHHabaJ6KdC3sc5woqCYkq4oyqSys7TFUTSXPQLukxwK/zfY40VLEWLw4y3BJG4fFv1OmdiEuKzzFdhgYDIFgRgeGmbcWtmkP1JxG5jnT8xVYDC1MbW2rwfA+Snl/5E7yhHpBJ8GT2UWRjUBesvFhCikNFoJOtQn73g6CW5pVH9JJk0u07nhomIj6VSTHmLOnNq41gOM9pJX5A71c+WxqQjvlgMm1t4MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(356005)(81166007)(82740400003)(6666004)(86362001)(478600001)(2616005)(83380400001)(47076005)(336012)(426003)(26005)(16526019)(1076003)(7696005)(36860700001)(40480700001)(70586007)(70206006)(36756003)(54906003)(2906002)(316002)(6916009)(4326008)(8936002)(8676002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:27:32.6448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55483b51-5b61-4943-6041-08dba9eb5bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Evan.Quan@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If vcn is disabled in kernel parameters, don't touch vcn,
otherwise it may cause vcn hang.

v2: delete unnecessary logs
v3: move "is_vcn_enabled" check to smu_dpm_setvcn/jpeg_enable (Evan)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f005a90c35af..e3e1f69643ce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -215,6 +215,21 @@ static int smu_set_gfx_imu_enable(struct smu_context *smu)
 	return smu_set_gfx_power_up_by_imu(smu);
 }
 
+static bool is_vcn_enabled(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_VCN ||
+			adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_JPEG) &&
+			!adev->ip_blocks[i].status.valid)
+
+			return false;
+	}
+
+	return true;
+}
+
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 				  bool enable)
 {
@@ -222,6 +237,12 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
+	/*
+	 * don't poweron vcn/jpeg when they are skipped.
+	 */
+	if (!is_vcn_enabled(smu->adev))
+		return 0;
+
 	if (!smu->ppt_funcs->dpm_set_vcn_enable)
 		return 0;
 
@@ -242,6 +263,9 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
 	int ret = 0;
 
+	if (!is_vcn_enabled(smu->adev))
+		return 0;
+
 	if (!smu->ppt_funcs->dpm_set_jpeg_enable)
 		return 0;
 
-- 
2.37.3

