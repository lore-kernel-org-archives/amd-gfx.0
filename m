Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB76C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 20:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D8610E033;
	Fri, 15 Dec 2023 20:27:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B9E10E033
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 20:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4bvzpDYbwIxlzbz/4+o9gk0j9++7XmbFKDQBwHAnFjeycR8QnnHFlibHd3kEpPW7z07WtNtX/OWrZjHVcJHo6NSWQvNqQCitNCqaAuebRLuEt5ibnvdCyFYkbjtaAkmfHVCN5X4fqypwFO4LACxCeftNfllWXZW3yX6Z7P8+OZ5UsxF23OfWOzJ/vk65nxArBqMVRJlFgzJBX6lbj2kiMTAjXw0V/lrxISfir2szCAaYwPp4qA6UB1qgl/kVqKltZBijK4HKcZQ5gwRZ8IDSS4UK9EA9+4iR8kMGFUkIOXwI10XQ5oFp6c4rt1+7zBK/QG9l285Kt/GTduGKtykaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UD/A9VUj5/C1nUR/8wB6CWdLBw9QIZpN8RCw7uuhiPo=;
 b=I3CTf9QnnpDmsUOQJBKUQxN0qFyzj9/6iN39sK0Lz5V3pp7lxGyK2B2OlNMMEq4hEqrAGjwykUkZExO4PXYhwuVBsnKTs+KayuxVJkuVke2mRBcviiDGHRTdEMgFSXrgmHJJ2WmQ2LNfUNsKxGCZ5+7+z0bvuM7cUMr/4Pb7TnrSna/UmZlQ0BPBXQkDWZRQFJuM9r5ka6dM259bAVB1TxZH+nQb8mR3Vzvyib/HCLri4Tc1IHycS46YfA52BCNBR3qTCcOjWUWARdGrDQw09V1lLNnkVJx+jFa64euNF1j9KShWm3oFekp+GS18eKh+CDO3YST7EpMKDXGjYKVsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UD/A9VUj5/C1nUR/8wB6CWdLBw9QIZpN8RCw7uuhiPo=;
 b=ihVxC+wxi3sPeAHuQoPrZ+X7sW7YyhMSRXcfMygx0TcT2LFLGv7chGScJmbfVUC9RcDG5YwtFVRaH3DzAm2ZeB4393QL9b6qcJ7xTTFk2qe9duEH5kgCbfTAJE/ZSJkHe0Q8nlKDOmeZ7hmboWsGsft+3YN2cKWDfpAtdtGrU3w=
Received: from CH0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::17)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 20:27:08 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:610:11c:cafe::7) by CH0P221CA0021.outlook.office365.com
 (2603:10b6:610:11c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 20:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 20:27:07 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 14:26:57 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Move IMU enable pm mutex call a level lower
Date: Fri, 15 Dec 2023 14:26:48 -0600
Message-ID: <20231215202648.20960-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 304f5427-55f5-4b59-f454-08dbfdac358c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EEOOeWNNB9hRZJw9P1aIwjLbbmgK0RqKpAL0hpuQA2EX4q2lsav4VcNNT1imtMNg6VqUHJCsnuP99qVGBpAXNzmmg81hCubnjn4bnYFG9pKrj0LDN38A+Pl4Gnk3KZSQauA3bo7dQdF/2IaYndXTgrjmqthl7BcCfpxqodTzd/HLeKsrkmI59EiGLewkuiDvcUvE0rFxAXw5VkVXtBP0fS/in7p92Uv8inRELmfdc//DSgkugemABvuUAZ8V5aJVm2Y+wvuqcu0NfZJKWUR4dJif9jpp+F+GUmDCXnzXWIPdaBKR5gWSaRGeQvbJXPFLZ5PSH3lP3wzOjio0d7Isz3CwwuM1wFOBeg0ypk2C31S1G4Uxza+ICJJPVbj48JzXhVn3zoVAxdPaqMS3i++TeIWiiDOi/EljAjqiE+SDecf5g2sB4gRMHyWlKF4fYN7rsPAEZ4lLSd8ccU5ANrh0DAAbAJdI45FWWsZstQf9qoi7tMnZMwspQYaH+HYRlly5oJspITMGjkbFQbzt6VRnbYC/LWGBX0d3iD216/8HKUN9uBFw4xvUSx2ch+USFpE4YUfTq7nBTZDwYcP2SgpvJAf8Sm+XoAf8SJ/2v2x0jslMk4XkakYJEAHIMdkSIe3tXtrW1o/hx6wbSEyh7UPHMGbwmteYkZHtI/E4REcJQLMlJjg74xQONk6B/AZM6BI0wrI6MzL3kRUSdK34C6IT0MYLA91nsnNJ9jmwnyyTCuMoGvLLSFGuk1XGPJ3u78wb6mXuNeaxdgWPK4hI4tjuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(16526019)(26005)(426003)(336012)(7696005)(2616005)(1076003)(356005)(82740400003)(86362001)(36756003)(81166007)(47076005)(83380400001)(5660300002)(4326008)(44832011)(36860700001)(6666004)(70586007)(6916009)(316002)(70206006)(8676002)(8936002)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:27:07.7064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304f5427-55f5-4b59-f454-08dbfdac358c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_set_gfx_power_up_by_imu() is called by both
smu_set_gfx_imu_enable() and amdgpu_dpm_set_gfx_power_up_by_imu()
but only uses a mutex in amdgpu_dpm_set_gfx_power_up_by_imu().

Move the mutex use into smu_set_gfx_imu_enable() to protect multiple
simultaneous calls.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 6 +-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6627ee07d52d..54906be6e15b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -113,11 +113,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = -EOPNOTSUPP;
-
-	mutex_lock(&adev->pm.mutex);
-	ret = smu_set_gfx_power_up_by_imu(smu);
-	mutex_unlock(&adev->pm.mutex);
+	int ret = smu_set_gfx_power_up_by_imu(smu);
 
 	msleep(10);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 59d67cbd98a0..5eb46b6bad43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -168,7 +168,9 @@ int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 
 	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
+		mutex_lock(&adev->pm.mutex);
 		ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+		mutex_unlock(&adev->pm.mutex);
 		if (ret)
 			dev_err(adev->dev, "Failed to enable gfx imu!\n");
 	}
-- 
2.34.1

