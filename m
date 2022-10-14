Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E21CC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 04:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9900210E41C;
	Fri, 14 Oct 2022 04:15:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A76D10E41C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 04:15:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW/xp4yVWhdBGgJ+Hg1ulIJuB9YKiwUB4yLfZNZbynx0dB1w74zaHhodQqOtsIl06TdVhn56IP/GZEoLpt3U+fJtvzdZBMXo6lvVDJIb50v9jO3o8AuTOh0jl89DHBXVZ0KM5gSd90RbbiLTkG2eVG8pWR9Uhy84s6FkmFMitpBcjBmWgmsoW6qlsW0HVB/Y0s+ysyAVNakgDq3caQlnhkLycS1VY9klqlp9utdl5VoJyVBXvZ7xBlMyZmZhhhG8IOsr4q/ul3eGUX6Yhmm7pqhINRrLeAdRWgwIO+Lzej32moTlM1uN1LMIPkIRUAx1JDnm7gd/+07fIG0VtjD+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl+5w2Ez3ZV+IWqxrLxpTimJWE6xHlrRXMtx6UXZ+no=;
 b=D8mEpHSvv3MtDH+VSGSmkXUPTT1EbQbwBWW7/UZOPHmImo0F+5E6dwJa7vuTSkOEshbPcvP/9Jl2W0f5PmS1d9WSr6FHHURKs4ojfv8aiTaxWaHZCSQD0x6MXavBGSVg8I/ukiU0ePPXp0nln12ZQJpzN6WfbZXQJD6njA672wKQyPN0sSdzzqs2YZo8jtOxe2PJoNhgz8DanN60u+rRUCnF/B3UrpkOs471bGrpaCLUtwGMGf/1G/piRjfD9yIZ4T6jTCiktvax8fXkxR6JavkgJr2f93Rc9+7iz7Fal9igdKGXGUuXJ5IxlTWeyrWgZ8uZATkTaxYwlc/pDM4p5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl+5w2Ez3ZV+IWqxrLxpTimJWE6xHlrRXMtx6UXZ+no=;
 b=T8ulmYI1BEKxYamocUMojf1MnlOitebB8b0Jg4w3ri9ZfvHswH3w95J8qjqZkBVUhJwqCTF15Vedsl+fWSQdnqywUliZN+f9Bp8RiCmlN9UrCpbC0yvXVDSBVGSXQV3EXgYkb2bCv8DFCff68oPOMZP6lHtyJKYjiku9UAYlk4o=
Received: from DM6PR06CA0027.namprd06.prod.outlook.com (2603:10b6:5:120::40)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 04:15:17 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::a3) by DM6PR06CA0027.outlook.office365.com
 (2603:10b6:5:120::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Fri, 14 Oct 2022 04:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 04:15:15 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 23:15:11 -0500
From: Asher Song <Asher.Song@amd.com>
To: <alexander.deucher@amd.com>, <stalkerg@gmail.com>, <Guchun.Chen@amd.com>, 
 <evan.quan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Revert "drm/amdgpu: getting fan speed pwm for
 vega10 properly"
Date: Fri, 14 Oct 2022 12:14:56 +0800
Message-ID: <20221014041456.139813-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e22f9c-e531-41a7-a187-08daad9ab29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFk9nIxxJjebr0+3C0+aPQmaBQrlLgS6p2nNkRIe16e+xqnpSYJsOCB12G+b6efQJgHbckaJhS2rp9SlR6bDW2oahTztL8A8qYkO+0r8BWNkbA/Pj62BHJhSrotUwNktqK/982nslpwgZxx467UHDimXUSraJv6LX5wyQFPfII/g/2GQASjPv2MF/AEFvDQeuD8QGTMTRozPy1F8ibOd7AjFu1LWZQg0oBHdvvNcUeQHUlU75adBekjB/O7rJSUz2ZmewrKaCb/Q/QGKoSSlFoPVWCPte/v56gX74iqcAVx8E7HtrxTfG2k8bS/YVFQqsGjZfdQnGx8ZLB/lh62ZulgRD3OwfZDzdQa/BJ1XyDhQBk2PGMz9ZZCk/GCrEkjCMuUZpycOfAlIppSQbLqNt/A0FKYwgWrIl7VE8kTqvAgHP3uh5MhI55Lk2Y6g2a1wn3VJu/GulTtjxq64nNtIgKVF+hEI2FRxlLCr4o1592doFouHNoubrP2TerIPuis8JIASG1YCV7OoQz87AvgURrpgsuN7XwOqbdWS5j5kL6FG13e6IXp78huFI0A4lM94kHqKZTpU0h6EJMFV1dSdHTOf5VXgfV8goroSDZ9KD+nAJngkckMjEaEU2OdVXRA+4YOdkZBRu6M9nivHosATYSx2xmJspcBW+ReJLBo/Bev1ZdI0V4v+PGSEIXWtLROwcrDiJxWFxR5OXx/UZNXPAGTj8++mr3OXhgm8QKdwuiOeor+g5niHTtwq7qY4dRb62JBQS2XoKrM/Le6pbsFf6NZ6UWZnQEDny73Z2Ilnx3ydLpngW4/UnJp7ecgr7bJ8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(5660300002)(336012)(16526019)(2616005)(2906002)(186003)(8936002)(26005)(81166007)(41300700001)(1076003)(356005)(82740400003)(426003)(47076005)(82310400005)(86362001)(40460700003)(83380400001)(36756003)(40480700001)(36860700001)(316002)(110136005)(70206006)(70586007)(478600001)(8676002)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 04:15:15.8315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e22f9c-e531-41a7-a187-08daad9ab29f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit fe01cb24b81c0091d7e5668874d51ce913e44a97.

Unfortunately, that commit causes fan monitors can't be read and written
properly.

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 190af79f3236..dad3e3741a4e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -67,21 +67,22 @@ int vega10_fan_ctrl_get_fan_speed_info(struct pp_hwmgr *hwmgr,
 int vega10_fan_ctrl_get_fan_speed_pwm(struct pp_hwmgr *hwmgr,
 		uint32_t *speed)
 {
-	struct amdgpu_device *adev = hwmgr->adev;
-	uint32_t duty100, duty;
-	uint64_t tmp64;
+	uint32_t current_rpm;
+	uint32_t percent = 0;
 
-	duty100 = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
-				CG_FDO_CTRL1, FMAX_DUTY100);
-	duty = REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_THERMAL_STATUS),
-				CG_THERMAL_STATUS, FDO_PWM_DUTY);
+	if (hwmgr->thermal_controller.fanInfo.bNoFan)
+		return 0;
 
-	if (!duty100)
-		return -EINVAL;
+	if (vega10_get_current_rpm(hwmgr, &current_rpm))
+		return -1;
+
+	if (hwmgr->thermal_controller.
+			advanceFanControlParameters.usMaxFanRPM != 0)
+		percent = current_rpm * 255 /
+			hwmgr->thermal_controller.
+			advanceFanControlParameters.usMaxFanRPM;
 
-	tmp64 = (uint64_t)duty * 255;
-	do_div(tmp64, duty100);
-	*speed = MIN((uint32_t)tmp64, 255);
+	*speed = MIN(percent, 255);
 
 	return 0;
 }
-- 
2.25.1

