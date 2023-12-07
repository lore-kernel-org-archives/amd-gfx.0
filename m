Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC822C10F05
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD4C10E939;
	Thu,  7 Dec 2023 17:41:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D91910E938
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Akv1e8eX6WgxPyuqgZywR3CKAfJZ2vGPJO4drqpGUOXusqw0cTbifUmEZTBjNI677/3rxSXPgp8pFTmeCAR6o19WK4lomupuchINqzr+789ThWpvgj9HsDk5NiAa58qJMocJoJvas6sQtXpsPZCBYh4WCCm4sT16JFH6nhD3OycnDaSvxCZE9/uUWwIN7kwsrpnGqQQfmJKFMZsTeOklnqeawLcPcfBRTWbndc2m0q9CmxEdyA0Lb1zR4bQTiJXH3fc5iteId3b5VBqF1Kj2KQW699yULHmpCYUQRacHPzwtMY1t2dZvl0EjnhvSOtpTCgtoPN/Sso/edte3fN6x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KXBANg/GtHsiKJ9k155hl0YS5HnSL4OXOBEWyETQWs=;
 b=TAxOZiCDlFMMIRviNkwif0ITDa2afKbpFOC26JNlu2R04FZhfM+ULAkBXJ6FT+0sS5xfZwMe8Az4ycdRjwn7AxvbcsXXQ5OBXkqqNDeBRznUTwe9vO8ld4aqTh6txgUhx8cRJG8d8Xr2I5cqLBXrRFAMDMBQud/9fvdGR8Gd5g9lNDnFuF0RQfMPvBBPBEWq5FVOFxbCGqDJDIiZut+iFprdL1RrgOzfmPexfIVG2GeVRscXNuLWSkRd13dQOYor7xvE9YY4c7az4XuLEgYrgJm9iv8eaZZvTEHqR0yUWHFoBRqUKdbKPc4fdC/EusIstECgtbZi0V698di30emuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KXBANg/GtHsiKJ9k155hl0YS5HnSL4OXOBEWyETQWs=;
 b=AcIjKW/boSFd7BQuVaSvNpnZB6u/+W/sj0t1iYY+uw//HiJd4AbbEyOiAKGY6o+FSESPqi+H8q7kJUnSqleLft/GCC6NCZMTVTNnPHdOlfGThUZTEbtUoBpLwNXg4dp79UNTUx1AFmPCxtQI+85tpPoRnPV6bk8afUE99A39svk=
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 7 Dec
 2023 17:41:08 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:610:75:cafe::1e) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 17:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 17:41:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 11:41:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/pm: clarify debugfs pm output
Date: Thu, 7 Dec 2023 12:40:43 -0500
Message-ID: <20231207174043.395159-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207174043.395159-1-alexander.deucher@amd.com>
References: <20231207174043.395159-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d82d94e-11df-40de-9262-08dbf74bb1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: av0+4UOyVsrFAcsMXXTRlMIEGwyKmr/QbOfhdXK8OhMhf9e4fov14pE1NGQUOffScHThg06/5IJEo4CU81aieZKlKsS8VjPPZ6dkeL/0cYiqBUACI59gxDVWIs+0Soh8DCsRkIAhsrsOj9LM0yhxSV61ZG/2XTCJlcmO1cu5IZAo8MAzE9rDbxHpgJ/oEFTkxLSKTeAC7Rphkhs7YcL6rzEyQ4xQiAehgze1ss1OW+jClspjnUIwP6HV3wP6GvDzl5WipLltuetcobCkoIUFqL28wiSc1bi70xLO7rxgMUTZkwFhEbmIDvKWYRe9bflQ1bwKJFU6RrKOje0x8VrEpyxW87Ico2khrlDQnS3FmuilE7aVU7A+N6M/2otenQSFPR9l0XugskCqZWgv6AGn6GhFmWt5RNqi0cHP5XgAVtx3qTk4PqEF6+/azKKzxeVLUn8+knw8sgYmLGM+ImLQmsjU62D8NYtuQ/mX59QF4bMbfuzxiPIg9EAIr4Ot0ZoEUnETkvskD1TILO3+rRmUav+6IYK9ShjUhYpZ7iWvPRy320P0m5oqEnv6p+zmaTsXB8FkjapvrXmWdlSVwMb3B4r/3yzqXnagcN37Lf6qrjOSKDn8n6V13Uti9w/fbVH2vhaYtBfCILPhGeyc5WMlS0Htn6FbFr1icQ1WMbjeCze4DmDWUsoPKsUPd7UfLpp6dOlKTlwVe1dDfarJG75bcW+Igr9CX9OgzavQnEsWN5j0ZczKyrRyMZ7GAJBa/Q4+wb+MyKKj8N8hBt1bg2jznQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(36840700001)(46966006)(36756003)(86362001)(5660300002)(40460700003)(41300700001)(2906002)(83380400001)(82740400003)(47076005)(81166007)(356005)(4326008)(6666004)(40480700001)(16526019)(336012)(26005)(426003)(2616005)(478600001)(7696005)(1076003)(8936002)(8676002)(70586007)(70206006)(36860700001)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 17:41:07.7594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d82d94e-11df-40de-9262-08dbf74bb1b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

On APUs power is SoC power, not just GPU.
Clarify that for UVD/VCE/VCN the IP is powered down,
not disabled which can confusing and lead to concerns
that the IP is actually not available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 204e8d8aaace..063a8d09defc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4353,11 +4353,19 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB, (void *)&value, &size))
 		seq_printf(m, "\t%u mV (VDDNB)\n", value);
 	size = sizeof(uint32_t);
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%02u W (average GPU)\n", query >> 8, query & 0xff);
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&query, &size)) {
+		if (adev->flags & AMD_IS_APU)
+			seq_printf(m, "\t%u.%02u W (average SoC including CPU)\n", query >> 8, query & 0xff);
+		else
+			seq_printf(m, "\t%u.%02u W (average SoC)\n", query >> 8, query & 0xff);
+	}
 	size = sizeof(uint32_t);
-	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size))
-		seq_printf(m, "\t%u.%02u W (current GPU)\n", query >> 8, query & 0xff);
+	if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&query, &size)) {
+		if (adev->flags & AMD_IS_APU)
+			seq_printf(m, "\t%u.%02u W (current SoC including CPU)\n", query >> 8, query & 0xff);
+		else
+			seq_printf(m, "\t%u.%02u W (current SoC)\n", query >> 8, query & 0xff);
+	}
 	size = sizeof(value);
 	seq_printf(m, "\n");
 
@@ -4383,9 +4391,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		/* VCN clocks */
 		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCN_POWER_STATE, (void *)&value, &size)) {
 			if (!value) {
-				seq_printf(m, "VCN: Disabled\n");
+				seq_printf(m, "VCN: Powered down\n");
 			} else {
-				seq_printf(m, "VCN: Enabled\n");
+				seq_printf(m, "VCN: Powered up\n");
 				if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_UVD_DCLK, (void *)&value, &size))
 					seq_printf(m, "\t%u MHz (DCLK)\n", value/100);
 				if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_UVD_VCLK, (void *)&value, &size))
@@ -4397,9 +4405,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		/* UVD clocks */
 		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_UVD_POWER, (void *)&value, &size)) {
 			if (!value) {
-				seq_printf(m, "UVD: Disabled\n");
+				seq_printf(m, "UVD: Powered down\n");
 			} else {
-				seq_printf(m, "UVD: Enabled\n");
+				seq_printf(m, "UVD: Powered up\n");
 				if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_UVD_DCLK, (void *)&value, &size))
 					seq_printf(m, "\t%u MHz (DCLK)\n", value/100);
 				if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_UVD_VCLK, (void *)&value, &size))
@@ -4411,9 +4419,9 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct amdgpu_device *a
 		/* VCE clocks */
 		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCE_POWER, (void *)&value, &size)) {
 			if (!value) {
-				seq_printf(m, "VCE: Disabled\n");
+				seq_printf(m, "VCE: Powered down\n");
 			} else {
-				seq_printf(m, "VCE: Enabled\n");
+				seq_printf(m, "VCE: Powered up\n");
 				if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VCE_ECCLK, (void *)&value, &size))
 					seq_printf(m, "\t%u MHz (ECCLK)\n", value/100);
 			}
-- 
2.42.0

