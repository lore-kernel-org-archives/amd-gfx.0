Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A0CC47DDF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 03:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C37F10E4AB;
	Thu, 25 Jan 2024 03:23:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AAD10E4AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 03:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMk8b0I+GzuF3xXLKGMZ/Ua6zMqmC0CEdwaiHtH5HNIhptQteb2oX0qF8BWggRyXtWuli9ZXBLdifm5QRBeGTmx7Q3XsruKZ+0Y7HGboW3KNZUqV28VLt/V4njlGzAsid7wEDNurOcvUNOCvWrvc9pO6OF5138OeW7SIC5bDtRlx/GD+o2ip9eY3JIBc/umchOjIsJD+4Wj8TYryFEHms5EU8ILLKqstYBF5sgkRyBG3wid3F72NT1bQUfGqh2faMPjA++KPIZHaIqREK85TQur5KBH1Lp4wCn9pi5iyocepT4KainmOAkTqOuL458ak7HDtx3bfz1MrmUtsuUGiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL31lBtyxtjQ2fJD8KYH8h+Jc+LFy1qioHenVi4/608=;
 b=H3NC/iPM+XqFL1o7MCRtCNIyeyrxTXGvuEH0n1KQb/IBk7e3OZfw3n3W/ED66qYHZeSRpBIP1eWsDyEbluV4a+bcqmrVCJ7NrvmOo5Bkkebhbik3fJw9mEfdGFAOid9nXun64DVIsEDcBtkukk8CC3BKuJqnEQ939WU6xLTcDvRnlOz8lUWBOC1c0m0Jyl5qweKYC4N1QYrsHAhQ3AHNVQl1/fiaM2dCXZHLTZIqFY748c28wFjGKKUULRD1bvF4SFAPGTAed3DS5o9QzXJtIGXhauHYUuoB+KpZilQvqzfZ4FIQc3dpOqbx47jMGn/0ftDVvcYHZx7IF13Kxjw2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL31lBtyxtjQ2fJD8KYH8h+Jc+LFy1qioHenVi4/608=;
 b=ZeRWDnihnOH5HYODGjeUUJSnZYFRD5SK5fq99Lhp+NTVTQAjEzSr3KTBPpXHn/wjex0AdNUtvlBAd1L9xHd+qVYBtkRGK4uAMNzkCnNZqDlcWxUkt2gfriXOzhxbKsJIMCDGiyPqHgOi9/DyDrr9RpHMjRUrFPP+uS2rQPbyJPI=
Received: from MN2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:208:15e::42)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 03:23:10 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::7c) by MN2PR17CA0029.outlook.office365.com
 (2603:10b6:208:15e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 03:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 03:23:10 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 21:23:08 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reset gpu for pm abort case
Date: Thu, 25 Jan 2024 11:22:55 +0800
Message-ID: <20240125032255.898308-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032255.898308-1-Prike.Liang@amd.com>
References: <20240125032255.898308-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e7c814-6bce-4263-ade8-08dc1d54f4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOLoBekeIFKAuhivxq+ZoRLrx5iZm/118isng/QyajHEp8+AWa8/7MikoGBz/nAXU6CqRxkSMgpCHeqi8OPQfT5tOqA4TyCuB42s7YXL9gJ9UFomGTJ5pYypBJgkkkOG8xt7z82Rjax5Yc2mw+tSukr6uf0skNTHxdUxdDtPXITuF++uVes4hf2jQA6yJYvThw4O3UUMTkSEafDUdyzs04gakXHGiF0hUTyM+oKS8svMm8c2A5ekAuK/jUVQ6OuzYkeO14HAZ8vG02wgS3rrB4csqSBtxhZ96pg0rfnIDdNMOnYj88Yt5j/ha1tqia8ia3tsCyFjCX+BYhuNHdwT8rygbkr7g/WAnXbXfVvqMJiQN6AfElND/hcSZFtMKULNGG9UKhIPQ5h67mXKNq4i2E/eDkUiaw4eaBaMWCYRzI3PoVYrQT4Y0X63dp2iweeBhbHE/uNTe/88MAFdmrS1CQuvU6aPrQoAdUwcn4qYogGdBRKFd0hSYmTteqYNnnzJHEpLPByWveot668EzMecOkA1SUMGcLmsyaSelRATb1RaR5fxNHVEkakb3frGhaKXJZK0ZUFNFICZndWl60jQ2/Wi8EQ5SzvEX+HuNlk9OvowYGI0ks2ViswmRtRZ0ebrZPr6gw/I9eGEQbzEs88XeIlIvcazAb7KouKobF+56+j5wKKUyBeWgoVz9Lra4Sf8PXuTEnE+VtTxrrcdoYeadPqLS16qmkRfULGzbogAu5ogjj3DmPul2XYaAXHE5/vj1vdF6hvQ+c+8Y+yEdm2V8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(26005)(16526019)(2616005)(426003)(6666004)(336012)(7696005)(36860700001)(83380400001)(5660300002)(47076005)(2906002)(41300700001)(478600001)(4326008)(8936002)(8676002)(54906003)(70586007)(70206006)(316002)(6916009)(356005)(36756003)(81166007)(86362001)(82740400003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 03:23:10.0943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e7c814-6bce-4263-ade8-08dc1d54f4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 56d9dfa61290..4c40ffaaa5c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4627,6 +4627,11 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 			return r;
 	}
 
+	if(amdgpu_asic_need_reset_on_init(adev)) {
+		DRM_INFO("PM abort case and let's reset asic \n");
+		amdgpu_asic_reset(adev);
+	}
+
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 15033efec2ba..9329a00b6abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -804,9 +804,16 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_RENOIR)
 		return true;
 
+	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
+
 	/* Just return false for soc15 GPUs.  Reset does not seem to
 	 * be necessary.
 	 */
+	if (adev->in_suspend && !adev->in_s0ix &&
+			!adev->pm_complete &&
+			sol_reg)
+		return true;
+
 	if (!amdgpu_passthrough(adev))
 		return false;
 
@@ -816,7 +823,6 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
 	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
-	sol_reg = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
 	if (sol_reg)
 		return true;
 
-- 
2.34.1

