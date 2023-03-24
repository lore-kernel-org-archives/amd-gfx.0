Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C06C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 07:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2007210E027;
	Fri, 24 Mar 2023 07:09:00 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72F410E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 07:08:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGGWsxNhgU8k+mp1WE5oRUZ3eFpsj53QIfyIgS7emdphTKECcF5TF7hjQTaClZhUuE5lJOhhUYufNit4+8oeT/tifdx0r9u54rQthXoXrPmmr3SslgvZFus1DxxRr1B9Spb00X1hlZTzosGl/7oK4TE/vJu+OmOkWTiJHMopf4Nu80OXAYwsiECQDXBdgDIiOqJJYQgXAhI3NlgfTJMmGeN+rkhtgGtVy1WNxUFmTlfwgB8essMV9MHtUSLs7+xt3oFZgsY36gciH5mlG0V2A5loQkPJW74Bjg2SQl29ifNn7KV+zZW8S1t3HJlScFb4H+aNgMTnVf09qVtilIQSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zylSXr2korusF9HXgbwcWEXuDsQE4X0nRKDuwMlqbzg=;
 b=lASVbsPCll8iNh08eZaFTIt0M6qG69XPugo4hB2d4xKyEpX7nNQxdzwYqLG6ywi0M+snX3Y0j2kLMHf5cfOhfm91jjhG/RIeMIV2nLqhBWw0S2tTdKlPGxTWoumhIsw4XeK8AeuceT8TDOJB0unwGhnRxlYKjZ7Y/dSR0Xb+PJiYQEa/cHG0Wc4ZIAUIaMXEGhBwV8IvUiSfdhrMFG2ZcRIOcB3eeQ1DXHdDTpeowXQe0P7t8Wm+5kFwhACYcLt5yGMorAD0TPmuVZQM9mSCffhpFz8cnNwSgHELGqDuWkD1UtU8A7rPWcrsHFibLGEfF5i4SRKug+qIH3jQ9O7uhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zylSXr2korusF9HXgbwcWEXuDsQE4X0nRKDuwMlqbzg=;
 b=KpJB3I2BugbMWJZkuax4XFw0qLrCIsD3bee09FyTdLjyH3OvdQu7MnlW88CgheWH0TSUX8PwQicNRRsZwyM+FmWcPwZ5h1fdF70w9xSL86PnE7X/c60va39MscKSJw0tuNTueCM1J26Tx9RYBV7Ph1g+uy2kzwtrTw3Kowcikc8=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:08:56 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::74) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 07:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Fri, 24 Mar 2023 07:08:55 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 02:08:53 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: re-enable the gfx imu when smu resume
Date: Fri, 24 Mar 2023 15:08:12 +0800
Message-ID: <20230324070812.1304117-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 21316dd4-e493-4537-fc9d-08db2c36a1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MA+KB9jk5Fr9rpW12MUhWoIr7ZCsUR2AzMbsPmP6cwUoi/UcHJl5lRXsf19Rv/uuSzK6YliiQBT1MlkSUvskMT/qY+iRDdlcjS8LJMPgiyjZeCUrsLSmeWwa/3xyFyHW6C+mvC7EhRZnOdNQP7VcXENE/NbCql8fVDQhxWyd1QAPYuzIjjxCNMkAOJ2dWJG8wFM2s5YXfn/XiRypDG7kDr+F+5se3+rlehbm9ShPLCSIonOEKMvXgz3bsYplBFKhRyYBGACKFdAFRG9WAf+BcgrNj5Ifc7zpnz2+B0LFbj/3uLJp0axfDJO/PECv7reehC0C+Qb3lYuf/DlLCgA7tjOJVQu6x6Lhavi9PoXL7jh+b1mmB7bO70X1CrUbolUz5m1HxJflZ+xkCmJXdl+mQzhbVXMZn1zrJGmpExj4lbgVvO+8V54HqpmczSlOxb9PSX8It6rhoH/eje08rdRCA5QyBdjcZjQKBlKKCzgHTry60R+9kX3XaUwvKk0DFmV5qcuPKyTohOxu0h7Ce4bH3yIx+5trdSpM6VgqhBrrCqo/TgPw/JFmv+Zf3yp8mUeaIHJXo/mK8DLaNdrYx1yXSYghSXfT415gQms7GMaue9Monj3wmseV/AiQo+LrwFLwd5dIdNvxrcAhS8ILo5scjKL/FkVpJyhPnWhbgjcOxRZkuQVUy2NcxWqeHwQ4U5ySI1gYQZaneaPO8Mup50s4+t0YYnA0coMBzjiYJvHS/l8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(40460700003)(36756003)(70206006)(70586007)(41300700001)(4326008)(6916009)(8676002)(44832011)(5660300002)(8936002)(478600001)(7696005)(54906003)(316002)(2906002)(82310400005)(36860700001)(356005)(81166007)(82740400003)(40480700001)(1076003)(16526019)(6666004)(186003)(26005)(47076005)(426003)(2616005)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:08:55.8124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21316dd4-e493-4537-fc9d-08db2c36a1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the gfx imu is poweroff when suspend, then
it need to be re-enabled when resume.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b5d64749990e..94fe8593444a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -162,10 +162,15 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	if (!smu->ppt_funcs || !smu->ppt_funcs->set_gfx_power_up_by_imu)
-		return -EOPNOTSUPP;
+	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
 
-	return smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+	if (smu->ppt_funcs->set_gfx_power_up_by_imu) {
+		ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
+		if (ret)
+			dev_err(adev->dev, "Failed to enable gfx imu!\n");
+	}
+	return ret;
 }
 
 static u32 smu_get_mclk(void *handle, bool low)
@@ -196,6 +201,19 @@ static u32 smu_get_sclk(void *handle, bool low)
 	return clk_freq * 100;
 }
 
+static int smu_set_gfx_imu_enable(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
+		return 0;
+
+	if (amdgpu_in_reset(smu->adev) || adev->in_s0ix)
+		return 0;
+
+	return smu_set_gfx_power_up_by_imu(smu);
+}
+
 static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 				  bool enable)
 {
@@ -1396,15 +1414,9 @@ static int smu_hw_init(void *handle)
 	}
 
 	if (smu->is_apu) {
-		if ((smu->ppt_funcs->set_gfx_power_up_by_imu) &&
-				likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
-			ret = smu->ppt_funcs->set_gfx_power_up_by_imu(smu);
-			if (ret) {
-				dev_err(adev->dev, "Failed to Enable gfx imu!\n");
-				return ret;
-			}
-		}
-
+		ret = smu_set_gfx_imu_enable(smu);
+		if (ret)
+			return ret;
 		smu_dpm_set_vcn_enable(smu, true);
 		smu_dpm_set_jpeg_enable(smu, true);
 		smu_set_gfx_cgpg(smu, true);
@@ -1681,6 +1693,10 @@ static int smu_resume(void *handle)
 		return ret;
 	}
 
+	ret = smu_set_gfx_imu_enable(smu);
+	if (ret)
+		return ret;
+
 	smu_set_gfx_cgpg(smu, true);
 
 	smu->disable_uclk_switch = 0;
-- 
2.25.1

