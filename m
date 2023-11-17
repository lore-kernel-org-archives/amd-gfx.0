Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B59C197A0
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 03:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587EB10E715;
	Fri, 17 Nov 2023 03:36:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 365EC10E715
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 03:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4FfJjAmgYuUG07R9GzYKRc/ah7ut6veIyVOlmanppA9n5AO/07J4+g7S+APQyPCRLUD2kBmPYkzV4d1+zJ2DE8WzjdheJ6VPGti5XVpi1qCXblFWGapj7q7Jtkn2k4LFzBi1wqiJARe9fjOfZfYd7OTNGX/ZSQuzTF/yALvqIRFyWUj23o3HBDaP5aPLdux/0Qdf7EcqROfUQjB+50yzHYtcx5WTP8RfJ/HQ9LBDWiGmE2rPVaGNcI0xgje9GKNQ4p6yxAXwxLs86b1noL0N9tvfATx1YSmdO1dW4H1k3KMBzodmunbub2IGW5Lum8V5bSnkDw03U02j+ZDzyA1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UtR+huFnHwE3A+mh4um1eoxAyr3UKVKkNAjQttYL8I=;
 b=E0zUXlCHZDwdes1lZWQY2RNMT/2ZV62Uxk6+Rbo/M+OBuKK0pOG1+X/bNpHIAgtlUCkCzQGjHv/QWlPFNsdcuv6SvdK8vpjmdY7apUMSC+WO6O/2Qud3e+UMMgJUQBb8DEKor2l7uLc1uIVy+9ARF6q34gdaw+C6oeSIk/kqn3vbB/mrAQI9dxKJ50Gm32iAGQKiGl0WcroOYo7DY3Quwj76LzW6k20ExKj1tOd+V/IGL01p3IY4TmF3XD0uwM4bAKeJz2sgL/QJ/lMNgkSHI+T413e7f7zJlwUqLHKRBmtSAOju8t8SZDdqqdlqmwOmAVmhW+CfIJBrdKItcLToFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UtR+huFnHwE3A+mh4um1eoxAyr3UKVKkNAjQttYL8I=;
 b=H2rVVIrM8POkwyEXyJtOsMiEGmdSBT6xv3bLR2gG86hrzawapsJwtEVbW8HbSBlMN16/M06zRn7FlywF4KBrfCGhpxUCekAIX8MOwtBqNc7HXC4hOwHsRtcO3nMWAVjcH80V1A0Fwb+VNbWEqVPM8Zeq741nQ8Y5Oxd2pXCoYhs=
Received: from SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 03:36:36 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6a) by SJ0PR03CA0378.outlook.office365.com
 (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21 via Frontend
 Transport; Fri, 17 Nov 2023 03:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Fri, 17 Nov 2023 03:36:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 16 Nov
 2023 21:36:25 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: correct the amdgpu runtime dereference usage
 count
Date: Fri, 17 Nov 2023 11:35:57 +0800
Message-ID: <20231117033557.1820476-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6c1497-48e7-4eed-cd48-08dbe71e6677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDVVj35ZrXhKGhbp1XBeCs0tcSD8ZdKVbsLy6Sd3CN1/mnCscjYK+8moIPwi0MCRv6uhbqbzME3QEzU+VPuy/OalJPlV3LAdprtGgDLUA3xMj/Zvq4EyIM5yElPXCanzCBjMnHrYyqeNun1JODWiSmktJ8odLjZHzG7rW9TfCupAdXlZnf73H01RiBll2P6Fuy/SsaBzrA3POWqRmM5XL8ZdL9vExvKGZotRmR+6ZBL+rnn/2qdf49zUAVC8b2onQYHazpR0sIJRw2CIez27fIDrC3wi2n14eTaozBfWHxrvh4FOczuy51WAABKJlkMbYpmiONzPzkcjJ16olHoEWphJmAnHUkxcr3C8tJdjV+SHRS9nArKbgNonltMEw9Yh1MiKFwXwO+/mCHKN+epE0rOVoI5SbJQ7NPkkZfnQes8S9j9kzaVaHEuCHfP2mkeQW9KJgbO18j+LwBsh2ksrEzZrOHx+L3ZAixJgIVrKyARKWQ7OnNzeXaT9l36+0QRJocP+osqTGGaAzqVzYdmISz+dDJYlGwv8b1JgAitMW6pdT41E/TOfDkI1TgWWCuttQ3dnCulneb94zvA0ovDycwUg1KTSfxhI+LzcqL1bs0G18qR26Ucw/PPp08LCwRAvLd7VOMpY5yB8UrXhnR2UtuFB9zmMYlg4uHbgv+Uxd74gMICAaTBdHFqKwivTmqTFojt7YuReDxta/fXbFOmI3cQHE2DupEEo6Y9MjaZc/Ztmt3FPms6iln3ajWrLtHy89a9c92376/x886fRm+szfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(336012)(426003)(6916009)(316002)(70206006)(70586007)(54906003)(1076003)(16526019)(26005)(40460700003)(8936002)(8676002)(47076005)(36860700001)(5660300002)(4326008)(36756003)(2906002)(83380400001)(478600001)(41300700001)(82740400003)(356005)(6666004)(7696005)(81166007)(40480700001)(2616005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 03:36:35.5657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6c1497-48e7-4eed-cd48-08dbe71e6677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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
Cc: Alexander.Deucher@amd.com, Sunpeng.Li@amd.com,
 Prike Liang <Prike.Liang@amd.com>, Kenneth.Feng@amd.com,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the amdgpu runpm dereference usage count.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
v2: remove goto clause and return directly(Alex)

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0cacd0b9f8be..b8fbe97efe1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -340,14 +340,11 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	 * we got before
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
 	 */
-	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (!active && adev->have_disp_power_ref)
 		adev->have_disp_power_ref = false;
-	}
-
 out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.34.1

