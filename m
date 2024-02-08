Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8041C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 05:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C6610E13D;
	Thu,  8 Feb 2024 05:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SzL9eH7e";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364E610E13B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 05:53:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLySTcpQdEP9iJZSw85XzQZn/plS7AUAx3XsdFpWk+1TVbRff7AG9inFksTytJPwlyXPA5T05DabiyxWBibjxNjYqLFi4jg5D3KweB/FKMrJi1evNIo8W0NKwgJ8/1oNPbkhh+3TJm/AIu41pQa1XOKOGKrCf/ZtWtK8zlz7/1gYDY6FXplVkaPpR7dymgwCWcN9eddPDRJZzjwSmh5CCEsUAZXlvBtSJLE0QvFOwYD3/LqS+ktltc/QNrxoxizl2PmNX9fS7RT/Zs8K0LAmyocLjdgb/VZSSHY/SXZrj0xkpY8FdccznlNhsQJJ6uUfs+UQHH+gBCHDE5zqZ9q57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3POUoZpB9Th4DP7C2jjnkW0drv/XHLRoO18X2uyadKY=;
 b=i/JvQsy61DswLa7DOQV5n/5DeCxm+ex+aQC/+Ow0T6MCc5YB5F0MrapjJMLtoH8rYRMGcd2QnzpS8bEZlSmdCOnrJb24RDyoyXUDEzVw4BSGCMXrpmcDqs9indXZ/2RVDOBCwca1wXLY0bJXKuhSBIg4UVqeqrAtKU+q/wDxUqJmVqtrTIyX5yAJkSv7T1wVCliuEqq8ZX3amGeyimpZoyzHup/eVhk/Li036QAENut+OilTQ3UWgzw84LZ4bnUQXMy9G1CYvDIytZT5PI81JEsU8kF9ULYf3Aaq3xk5QRSoWfcyERJFsJm6yF1iPhBJoHBHa1umMnJNqnxo3HI+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3POUoZpB9Th4DP7C2jjnkW0drv/XHLRoO18X2uyadKY=;
 b=SzL9eH7edzJFkx/CyZhLjoUatZeRWJVe5XbPWIxF+k0KuC37qICawIxsD7wWSwbtPRyqjfNF7ePFoHu6qUQlyJZYUl/EU4Q9FsOlckJ17Cg+PyzmSXvWVMC7meS8zS1HavlyWWCPGb3OIw2S3WN8Q78GPfowmwdCkW9HDnxvHV4=
Received: from MN2PR06CA0030.namprd06.prod.outlook.com (2603:10b6:208:23d::35)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 05:53:15 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::6e) by MN2PR06CA0030.outlook.office365.com
 (2603:10b6:208:23d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 05:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 05:53:14 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 23:53:10 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 1/3] Revert "drm/amd: flush any delayed gfxoff on suspend
 entry"
Date: Wed, 7 Feb 2024 23:52:54 -0600
Message-ID: <20240208055256.130917-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6e1d14-9600-4b40-77df-08dc286a3d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbzUqC+vyvg7pP6QC0jedb9Rm9WtjFUWldbdlomYBVu5ektUQ2cT+JPCCZ7v3HzD9/08xX5OUWYUpm32+Cse7/xWdF6MBlQMHUJT5ZVaMjkLj4xft8DuleybDjgaiZ0cIZxzuXyBm+OqfxokCSXfK8EfuZ1FuO/qQDNlXqytHwSGyLGrn6rBy+RQ/F4pR0FhuIVqH4+rDZ9IeiS6dfrxbNh4Og9j8zpv5NdFsfCDa/ZD5HHKmcgHk3t341pNPAgNk2hmt7WzmeHpKO2N30iyEJQgxjn30y0LRDup+I8PizlfSZLo526NMKB7O8zsoiypg48kig1TCVP8we6uzX421z+w5Gu7/gTSitMoYXaN7thAlQycL7+7S9hHpsHT2LXOCRPLbN1OSQGNKmSsRY4GV26vgRH8jnqaqHc7VOtD1255X//wuO0Zey/LhMqy/B6zoCSiFCpeF/uMsLFbKxIr4mV6nlOcAexHx/1+N+fsNLVsccWkotsMhtojZvSjBMPw1HFodj17eGmgi7BvrgKk08lEmSDTihBJbTtw/HdUoerBknMmgxK3J8RS52YPRS3sH8WzaItKPq+qnwjYUSsro6OmIRcQYXRMiiA/u+lW874=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(316002)(54906003)(81166007)(6916009)(356005)(83380400001)(7696005)(8936002)(16526019)(70206006)(2616005)(26005)(6666004)(426003)(15650500001)(478600001)(82740400003)(44832011)(336012)(86362001)(5660300002)(70586007)(8676002)(36756003)(1076003)(2906002)(41300700001)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 05:53:14.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6e1d14-9600-4b40-77df-08dc286a3d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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

commit ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring
callbacks") caused GFXOFF control to be used more heavily and the
codepath that was removed from commit 0dee72639533 ("drm/amd: flush any
delayed gfxoff on suspend entry") now can be exercised at suspend again.

Users report that by using GNOME to suspend the lockscreen trigger will
cause SDMA traffic and the system can deadlock.

This reverts commit 0dee726395333fea833eaaf838bc80962df886c8.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Fixes: ab4750332dbe ("drm/amdgpu/sdma5.2: add begin/end_use ring callbacks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 ++++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 670ecb789d59..2bc460cb993d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4573,7 +4573,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, true);
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
-	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
 	amdgpu_ras_suspend(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index aa8e1d29d10a..9831dd854532 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -727,8 +727,15 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 
 		if (adev->gfx.gfx_off_req_count == 0 &&
 		    !adev->gfx.gfx_off_state) {
-			schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
+			/* If going to s2idle, no need to wait */
+			if (adev->in_s0ix) {
+				if (!amdgpu_dpm_set_powergating_by_smu(adev,
+						AMD_IP_BLOCK_TYPE_GFX, true))
+					adev->gfx.gfx_off_state = true;
+			} else {
+				schedule_delayed_work(&adev->gfx.gfx_off_delay_work,
 					      delay);
+			}
 		}
 	} else {
 		if (adev->gfx.gfx_off_req_count == 0) {
-- 
2.34.1

