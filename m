Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80B6C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ECF10E942;
	Thu,  7 Dec 2023 17:41:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0134910E942
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE14Qcqoj3m5l2it6kuRAWvhrp1wByZI5Fd0LfNgRFN102K0lntJp9GoNkevOoGgeiG//bnbVrqR4ZtbyrC1VOMXV7dQEhxaWkkm7AMGBPIkEyE9WyZFd9keGRNTNqz7MJctLdE9G0MULrJt3LRt2J7g/f7WThAPq7OUAlz1nxCQ4rPdX5ziZjbSwlEMKfc2Mee4Cxe+ZqYACRT5PDWkvVWM/VnkI44Dw0X6ASG9Nv+IGJnOU9ZOXMofrgxQ4Dv1dXcLanvS3ZLgIQSvDmbpTpVfF06W9A0+PB0tZKVz/rwW5XBdGZk566W6bbl/ROIwG+VqqqZoSsgM1CzfBL2kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmcZBLOzEFA2zOoF9o34OA4ZnMwxGc401E8QBpt5t0A=;
 b=i9+4h09gl3w6C7wEHp+HkjJewQJYOy62W7tyL4pHmlHXeLAAOodtI0vY6AYB41fy7i2afIbz5h4764gQkbmMJqWaUcaOstNLVOlhiz+L2VBNFD5WEql8LJUuW2ThJuwhUlthrEZAyo1Q0Kkmp9JhQeE/bSG7MTgGhHQQgIhSqQF4NGrDANRx3L7gtcCd4AjO37QU0/am+VJ7WC8wjATe6HQZzz3mzOQUm9XvjLU5YaNsSjtQZi02rpcYx8JTB1jElLii0WyZpa9+FbZL5r+JcUZTI1Okr6C+Mhp9JriGtPHfkKHvl7QJzReg+vVtNXLc3gFKwidLmyfJgQumEcxP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmcZBLOzEFA2zOoF9o34OA4ZnMwxGc401E8QBpt5t0A=;
 b=YMtePPORYCv8PaOSoQITtjeQ48L4j+id2x4OyJ+0ZJW1jOLVcCtmRhBZ8q9fAwBDYr6Gnw6vg4rSKL8n4Leup6NalbiBwCgrF1jVwWKD4c7vGxszPR9554659T9LlY3U4LVowGBbCw5Lt2hldDVTKKqaO6ybaY2Ykui3q/Eo3+U=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 17:41:14 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::aa) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 17:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 17:41:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 11:41:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: fix avg vs input power reporting on smu7
Date: Thu, 7 Dec 2023 12:40:40 -0500
Message-ID: <20231207174043.395159-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4e67a3-7951-4490-ae9d-08dbf74bb510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3BZsO7VeAznr9mECt1CLogKnWYKYSo+ei7AVaF14VMlyvK/fzSNKz5g70dNA3que88ptoRi0kWCMsMRuVQnH7+202FqjrV2Es5AV3MyUP5CwE+ud3w5odbxJthRt6NPM6n2qM83je5vjwTpn7tjxiPGmLY1UpfVowoeKYsIVnQ+W1KuBXAw/tW+Iin5APec+XSqSziH58F1cH3tYi4ievk1oYquQr0GKPJNyBxHy87QkM2ESL9kopNQPzHjSoEGh7H+1McNi3mBBA9ZNPo6Y2WpCjcb6yuDc+kDJRS5UjJhMCNz2VXxft0BXBWHVewq7s67MJ1MW43bAIGYX70pC8QfS2WIJz8UorLs0ys3a4DkwrkepX6xBXgtEugN8fpNrSsDZ3mRIsHg/xjHvwk9vJkMeGZtXQ9resdd74O87N3Ap6dyXdTc+Rng/Sbgpcq5iYsNmlMAI6uXkALI9JKh06ncIP5L6TMWEqp1ZPxNNpm0yY06bWbpo6wOCeqLIoL59uVqi8Fl0etsF/ouLrDic/Z2Bpw+cJY/nP3pjBV28eaIFrltXV3P0VuE7++Rv+J3vc+2VIDIcRw47vn6Pb4EfP7Tqt27pBzDVf/mJaiSACODnrtvHOCRI5Lptm7MaIAERulkuGe5lO03hkYs5m6HzxfP07TbsZLLLUxl9Jg4aL7Gz5Tl/3l61+NGJoonflrsrmKsuiqBWnGFsiB0y/tvMpz6y3ZF1M4K/A/+g69WovTWrj9qqU4+2FZRYFuB2yygpeS8tFds3XqUnuhd1kvn1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(5660300002)(2906002)(36756003)(356005)(81166007)(36860700001)(40480700001)(7696005)(47076005)(16526019)(26005)(426003)(336012)(2616005)(478600001)(1076003)(83380400001)(6666004)(8936002)(8676002)(86362001)(82740400003)(4326008)(6916009)(70586007)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 17:41:13.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4e67a3-7951-4490-ae9d-08dbf74bb510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hawaii, Bonaire, Fiji, and Tonga support average power, the others
support current power.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 11372fcc59c8..a2c7b2e111fa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3995,6 +3995,7 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	uint32_t sclk, mclk, activity_percent;
 	uint32_t offset, val_vid;
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	/* size must be at least 4 bytes for all sensors */
 	if (*size < 4)
@@ -4038,7 +4039,21 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 		*size = 4;
 		return 0;
 	case AMDGPU_PP_SENSOR_GPU_INPUT_POWER:
-		return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
+		else
+			return -EOPNOTSUPP;
+	case AMDGPU_PP_SENSOR_GPU_AVG_POWER:
+		if ((adev->asic_type != CHIP_HAWAII) &&
+		    (adev->asic_type != CHIP_BONAIRE) &&
+		    (adev->asic_type != CHIP_FIJI) &&
+		    (adev->asic_type != CHIP_TONGA))
+			return -EOPNOTSUPP;
+		else
+			return smu7_get_gpu_power(hwmgr, (uint32_t *)value);
 	case AMDGPU_PP_SENSOR_VDDGFX:
 		if ((data->vr_config & VRCONF_VDDGFX_MASK) ==
 		    (VR_SVI2_PLANE_2 << VRCONF_VDDGFX_SHIFT))
-- 
2.42.0

