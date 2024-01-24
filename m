Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581C0C47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E353F10F653;
	Wed, 24 Jan 2024 07:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F4610F653
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3L7wE3zPJXaxuaYLwUis17dBejbYamefefygDh1TcHaIHoafCpW0Xg67/zwerohaQSsHHpPRpWo5Z6mgSrmWnUO2kr+o/pNKJaRqad0ffVNYKfty0zzdKUXjIrVLv2T2dq4pxBBs/E6Hu4GyNRD+HOU9c8PZb/q9EtcQgPNHm+1ABOIhLu6qdTboc/Rqh0Qjwol2hcXqFGkZfJUaH4SXz5D5/rhWwnE8K+IpHMYsn1ZsAGjB45NUHig0dDgCSUuUGk9ZxTU4UWt/yeKtEFpqJuAnX0r3Prl08g9pEFR28ePQk6Lh1PhstNtS6Lf8tmyU5j1OnpC35jS07Cnv5gWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilf7kudepsCXKRg8ZhoGdWrTwPNJX2+lsvmJ616m+Ds=;
 b=C6VtpOC994veRtFz4XREqhnArtQ3GODuBplAOAoefmNTxn+taGJZYhiZA+9Ff8VWKyPDMZQtLWZ65GQuevn+ySemeWCFkDnFfUOAAuB2XZWYh3pSRYvyRWz+jsNoxGMDVpDjN7pP1Jqvh2xEYYX8y/TFQLXnsur9QXAzfwWqe6MJGgABAgJEGOyeBz44m9KH5Cwqn5OBUNMdHWipJcNb09BG1BPn/qBFyyqNfOr7bsVap90/Zi4Y7/Ogtoyt9CY1Lr4PiydHDEvvcLPvGXc3AF2yhoEpMrpfRdBjjtEM1AuC9CmGjVe9mh3uOhHWlivnkxw3/9Rl7jBnBAfv3Io3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilf7kudepsCXKRg8ZhoGdWrTwPNJX2+lsvmJ616m+Ds=;
 b=vRw7DhRoQ4DAt4g9OePH7ITViPlRjlpPcss7dVnsUKsEQYrI/dhSWmiJ44cDeCmpApKrRPEL/BCo98ZCCCG4QJI6hPAJo/5PN1/WE29wWJ6S7qEb/EPgPt6oUTSePiqUZOJUYA12Zvpp6u3uI5neBg40N713JCPYCrCs7Ux4pA8=
Received: from BL1PR13CA0217.namprd13.prod.outlook.com (2603:10b6:208:2bf::12)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:00:03 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::81) by BL1PR13CA0217.outlook.office365.com
 (2603:10b6:208:2bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Wed, 24 Jan 2024 07:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 24 Jan 2024 07:00:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 00:59:54 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Date: Wed, 24 Jan 2024 14:59:32 +0800
Message-ID: <20240124065932.892944-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124065932.892944-1-Prike.Liang@amd.com>
References: <20240124065932.892944-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 99af10af-53db-448f-036b-08dc1caa169c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjXucDPUFNiXIRo8PbEgFb0txVctrfVCmfCf+HnmZ00YrjUWY2MyMtdGIBDas2C9Fxk3RmfM0E5mqSTTO999Gi9yDbfZ1DUnnx/wH7yjCS9YKUmCE9mRItx5uUegkUi1tSOV/1N2v5KAlZKH45FtY+Wed1b6zVDuzcG2G2SembeY9FIPndIi78tz37Q4zXs8sdTQ57ljAfafPd1gCMb04PAVyTKNCFlcBpdGLav+WM+tAEmF/h6JLkC8171Egiskcw6n56GOwW/7ltdTGaYalPhouJOb+1IYvBdUz6wFuEClDm3RFLv6ewSFWQJGTbTDPX67OCHTpu4bS6F61IUUQST1wT3vGpdbGmClVAPoZtKnYglAilid1/n8WujJzCKSx2Kbaz8OPRY2fY7ubMTl4S0ESQiC0Ikl7mYFyi/h4fjRM6hE0pWy0tWyHH6y6AOwUjbKXjI1RvU3GH30sJmxPVtrU4yz1IkukqmnIN1xoQ5HttlD9lxXGTPp74dX9OZzDm/9c5p/LHcGGJqK7NHQ9U9nSsm14Ye+vgUZ26S5H5IADfBWBIornxxVAyqjPUEBXGVVNQT+MXssEFZdPT9oqKxeFnO4ry7eeRPrWA2hOx5EL8KU9wl2+1NHcqcD0fH28Hx0bEFRq5wVVZUWr12bF8BLZu+hY7X6vSOACqzeccHHOVSrY6PS0p+s2lhervRbtg+uNJ20z/Hur62fWtSluDh1tWQnvcu3nq4yOWRrQ5HYLvdX782bfA5Y6gZ5ew1LWMOD2OkAX86ESQmbIo4I8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(70586007)(70206006)(316002)(54906003)(6916009)(36756003)(4326008)(8676002)(8936002)(36860700001)(82740400003)(86362001)(81166007)(356005)(26005)(426003)(336012)(478600001)(6666004)(1076003)(2616005)(7696005)(47076005)(16526019)(83380400001)(41300700001)(5660300002)(2906002)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:00:02.6921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99af10af-53db-448f-036b-08dc1caa169c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
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
Cc: Alexander.Deucher@amd.com, Deepak.Sharma@amd.com,
 Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In the pm abort case the gfx power rail not turn off from FCH side and
this will lead to the gfx reinitialized failed base on the unknown gfx
HW status, so let's reset the gpu to a known good power state.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9153f69bad7f..14b66c49a536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2935,6 +2935,11 @@ static int psp_resume(void *handle)
 
 	dev_info(adev->dev, "PSP is resuming...\n");
 
+	if(amdgpu_asic_need_reset_on_init(adev)) {
+		DRM_INFO("PM abort case and let's reset asic \n");
+		amdgpu_asic_reset(adev);
+	}
+
 	if (psp->mem_train_ctx.enable_mem_training) {
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15033efec2ba..6ec4f6958c4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -804,9 +804,15 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_RENOIR)
 		return true;
 
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
 	/* Just return false for soc15 GPUs.  Reset does not seem to
 	 * be necessary.
 	 */
+	if (adev->in_suspend && !adev->pm_complete &&
+			sol_reg)
+		return true;
+
 	if (!amdgpu_passthrough(adev))
 		return false;
 
@@ -816,7 +822,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
 	if (sol_reg)
 		return true;
 
-- 
2.34.1

