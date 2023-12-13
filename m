Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A66C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A61010E81F;
	Wed, 13 Dec 2023 21:27:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2197D10E87B
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWy/Qsro3SprAGUwKuoH/bho4FPssq8EDj9Q0cG1Gcaopay9mkwK++M00/jiMRsLpf9NyatvkXnFEYdvP53SiHEjb2XRld4V2d0cRz0Ori4n2TS3TrDg3c88sZ1s6SmX99NZ9mDDI2daO1DrZvavy350ppjbMdrsVReBlLrQIpQW1MGYcUpWjVRAYlmlNLR1uGKot2Fu6o7i07wOxvYyFeOKe5sivkYnAn3Klj9nPtoDFKQYbyKU6EfWVYVooIlM6DbhjdFRtnzkTlnPRxA/IAzVbWiqf/AbS4QGZFK40VmFPjX9+N1UXoX5Tk9p/fm7KfwBSrFvxk/J8QybSs2ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmcZBLOzEFA2zOoF9o34OA4ZnMwxGc401E8QBpt5t0A=;
 b=fxowrCYP0G8Ev7dV9kYAwk10i0EmmIQnLxqUoyN2wCO0a5J8c+rcx+s0OyCwU7vVkOC/5RaSRK+tDvPiRQn6ZlKntKuReMIMhD2417rjVHxD8Enj4bel1vCBvBiybTe274sizuz8gtB1Qa2+Q+D54pK5JVK9n7kbUnRtCCa9BU/5z2xGKehfybKz28MvKuOpR2do9A1W/Ms3hkkDC6gKQNfr4zZUM3F+ccqA95vSeVEH+oh2SE2jDRg36I9ELaQ+IbadtvNUzEeNrAOnMCJTITtVUr6NZnZB2ecDO2gqHTJTanlzbwA/462vnBDw1YIS3ksSoAEB6Kq3bolL5t2/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmcZBLOzEFA2zOoF9o34OA4ZnMwxGc401E8QBpt5t0A=;
 b=u7QKf3FE5GMCTHVk3ACz3Z9isMkatrroIKWAqKYAWvtCCFwTJG66oybvPFB9LDDvCtIW4QCcc/xBuWUbiF6h4dwhr8eNePHh2GzGGNt85ISwVTLyJv8dIxoISuDSULgelq3AQE4bJlWpw+UzfmlWpq/zO3Caul+2NpMyJ1b7Mww=
Received: from CY5PR15CA0094.namprd15.prod.outlook.com (2603:10b6:930:7::23)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 21:27:44 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::cf) by CY5PR15CA0094.outlook.office365.com
 (2603:10b6:930:7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:27:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:27:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: fix avg vs input power reporting on smu7
Date: Wed, 13 Dec 2023 16:27:26 -0500
Message-ID: <20231213212729.1965153-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf30d2a-b483-469f-0b5b-08dbfc22580d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdW4f6j43FdwZ3E48EXk5FGQHJSR5Rr0Rue29uX1mslENUTqbXJ8kFDVuXnGX0JdelU9sMk+N81gqc9WTvCjzLz7m/kLDXJp1RqR5kFewM3wdHVtvjSnhc2/twlMhbldnevN3mnygTOVYLjHEJDFmi/ncfRwPgmLRIiy0Pu/ryS730T36NBmkMGa4cQd+XIuWkEIsLHWWU+HJql5NPjThAPzbmQUegrm4+KW9Vekptq1Sl4UWPmSXzekX4Dw3reVVsZ7F76wlutY3Y4JyOUf2EhZZUulL4JPKTdz2VnBssN4twETjS/fS7ozshhDXV+rkoqfb/YoZ+CIJGcM5yMWdiHqSWu/wfe0qAJ3WKw3t1KkbNPQG5WvHi2OsadEbbHxXGibo8CI7Yxj2MWI0ATLi4OzINk8ESX1kDAc1vTVGj4FL85fBlEUcJ46CmOhTClf+/60vENW9Jsm9TfS3L+wYgzQIc+us4vewLAPciqOIOMLRfZuEFlbq11h4V4ELRSjsHYSjkTBNXuZRB4VLOEEkbF7CPNXb/y9YGrAAH4iEHv8scXeWTBzPrh+5lkvILNF+5ybdoc54e0J/S+gZKSrHSIdu0UzsRqWALO585ea9U1+LAYJ08/cMueuWLFNb7XDEvcK1644w2yFvR6b+0fZVnwP3TKZq66uT22CCkuVyLrDH+DR9S3Ownp0l7HCgF02zYYj04IVNYqmI/HWanNu5lDyItT2M0+WUEqGN9ijIugJr/cMp/gRuK/dzA/EJMEjzDi8mjl0JI5/NE0JRStWrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(82740400003)(36860700001)(16526019)(356005)(47076005)(81166007)(83380400001)(8936002)(426003)(4326008)(316002)(8676002)(86362001)(6666004)(7696005)(70586007)(70206006)(6916009)(40480700001)(478600001)(5660300002)(2906002)(36756003)(41300700001)(26005)(336012)(40460700003)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:27:43.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf30d2a-b483-469f-0b5b-08dbfc22580d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977
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

