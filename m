Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC22C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 22:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E23B10E405;
	Thu,  9 Nov 2023 22:14:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F58010E404
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 22:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FztlqDnkgwSmLl10Wm90Uc8oABW5u5fkOL14Dn1VFjypT9mFksmvM9RCR3nm1EfDY/uDs6XpT7wZMl3egun/UIDrXpYuHNg1uIH/kCGOBhxY79RBrcYc+8yMU1YNpwKtnONfOGbkLk1A3sqPJxR+fVrOsP+4qR1p0Za84Ni7kp/pi0j6aEqxEA6fkfzEusx5O3il0s9TRbjaTc3gIj4HkttXlEi5PSzpLlRlkyU4kz/DxLCo1esBiPaq/rR8xY9VWAupErTwvldvXdE7ZNWtvCFpjSdbj/FILh/hjX1kBrF582nZPlX1LtU+6o3vb4b/mjGNnfv9UEmxU8rc5Me4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw4/Sp+xDHqu0zl4i2lc8utP313cEJI7D7HnoYr0dmg=;
 b=C2CwG1XX/Ymb24QbNQmHmkxjdIFZhJwBpDiUHntI2rIOVnADgUV5Q8zUXJ8NWSMmkY9rQZPGEbeUcYPr0xpvpcvu8cENdNZnscb4FsQtUnr/QOY/ZXPVHtrmTo5EPeDNIlEf8hNPX9/wyu6pYbfiravzH7kLcsgAkJCqooXlPu+KtS6KhP2kbefM2w+InuSNUtWRpwqHATgx1bnUw+mKnj0z+MCwp+TekxjOQW/q6O+0DguEgRZQoW7CliMRK+RvZs+2kwv8w2CzUL2ZCgveZrZ1IYY/W1G4fJNoyOJUymhYUUBDpQgjK10v8TfDd2PbrbhlNqEJMMthaQbcJ+U9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw4/Sp+xDHqu0zl4i2lc8utP313cEJI7D7HnoYr0dmg=;
 b=Kgs7+NIziyCaFU+Ca+t3V+3XuRHWMavLTZ6HlK9AKWjftWgtk6s1iD2f6NXnMhJ/5t+Fsky2yiMwyAhxYhe/ykf4bV3fiRHRh6gxyXOfgTwW1Ff+BvECPKujix4eee9loGMW4NwOkM136NwriDgLAodaMFjHKY4qB9oRQbS3Ty4=
Received: from CH0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:b0::22)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 22:14:15 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::e) by CH0PR03CA0017.outlook.office365.com
 (2603:10b6:610:b0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 22:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 22:14:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 9 Nov
 2023 16:14:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix avg vs input power reporting on smu7
Date: Thu, 9 Nov 2023 17:13:58 -0500
Message-ID: <20231109221400.936847-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 20153960-3970-4cff-cbfb-08dbe17135bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udfVA9mCnMvu+qCLVwQ7zJi080M3mb3UZEbvoiPRgEm1dgfYm7Aos2JBye5IG7BPCTk/yG61CKXBXLhs4nHL8gVLOKmCrisVX7htsSgAWvwj+BphUknzfP2PhR+O43U6d+n6QdIMIWTYcczTzB0wdFE3rbloTlFt8un5T17KOpC7vbQOD2uWoH88uNUinQ+WqunN0P4zfZogop4SAIJtxVNXFq3TpJU6UtPlkN3irjBrrXUoUJ9RQWsEOQSXK7vc5dpBP4yCRQw4H1YBTrbBdMDG9L1DQ0igoHRc6ynpHLrWDT9ZBsM5b6M6W4xZ/zg+kMcVYJZgotIizrdpkMRHfuIGE6t6HVjpNToxVDkfqcXveV+dxZhL46rOzKpCb+qJf6LbnBv1+iVuHaUL67QU5Z5GP+R6lDYJOU6em78jUvMhGpVnAvmVhzs7MmloqDTQ2CTzJuIZSLY98aX+Dd2VbGcNFML/PGtXIGFyOkFoftiugpYJBq/jmbAdU8wL5xea112sOHGT/1zMDD7WCflMqWz/tKHA/2HYqPS/29uqmK2XlItiRxFLpANYMs/s2p/PYVULniHwHlLrh7O9NOMDkTzkzmuPjmpzIJ/12sR04LMfkFnFCDwFQr8cUOTe4HZjBUvYl6uW4iKoScfyTaMFBSJVBglcpNkOfeObMkTIWDJ8CFD4Yo5N3E6xuwsPIpzkQE5ZNgPWCKleK9Spppbf0qp+7l5KESTEINbrykNdpUmP5oauYeRSe+/3e5R2FAHEVHnrcDjx4PtkLPKLC4q9NA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(6916009)(5660300002)(86362001)(316002)(70206006)(8676002)(4326008)(40460700003)(36756003)(41300700001)(70586007)(82740400003)(1076003)(26005)(16526019)(83380400001)(426003)(336012)(81166007)(7696005)(2616005)(6666004)(47076005)(8936002)(356005)(36860700001)(40480700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 22:14:14.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20153960-3970-4cff-cbfb-08dbe17135bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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
2.41.0

