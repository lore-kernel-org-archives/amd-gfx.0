Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7290C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 21:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353D210E87D;
	Wed, 13 Dec 2023 21:27:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF30210E81F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 21:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKxG3s/L9uap7X/EJxwwWSsoc/rQAdH1VznqHaYKvOuLanby+Br+MUkx9CV67CUiAsxFh+h3a4rtrr+w3Q3AqzmzHcCKVWERRVOttb+MGFDP5Gn8tgsjSvWMRDYi+LvcGihLSNunzxRLGWRs7nEFFsaGoirO9yC467AsIpenHn5g381vjoJb22FN5+UEpVJD6pTqYoPCtUUmHUYeGYn9W811peTSr3goGUFLoP+aAd3gvr6Pb2Rmh8LjluCnhOXJ2CHi3GcfcEsJEYLjFClMq2P1XFrnPsUyVOakDiR0OyTHWsWfURa2KWHP8Ko6RPUkFrXz4ibHD2df+MtdWdi3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVM3ftE2clrtJcyX90bNQkdyX2NNCkVcMAVe/CHRyWs=;
 b=UWZiFfhyrLFxCHqKrNR7ZpqSFlboANXz+GYu8Qt3/2X57QHPr06x773kti6610UcNBpkuVG899XJaD3ONW+YJcH4u/miZ4HqFVZ+aR4z2FvfBRQfxeQjtT8TCD0TXsV/gBTYFFWr4ZfTeSEOw6vYIq/vpYwyH2Al2Fx4+xGrxuv4Q1scVt5Wk5TaMj5sSQWznqx3eBDp3VpLtTtnVlsMECMVyvXbkV3VjnXzgg3xWBElGb1f28tIktWQNL3RDmnrHqHJE6zBLB+zyXRIcTiW+lvaqoj2/aGa4lcd/3LfRfbwJ2xNiWTmqtAvxcBkes2dSOqEqxlrzJmWfvIidl2jEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVM3ftE2clrtJcyX90bNQkdyX2NNCkVcMAVe/CHRyWs=;
 b=G1nT18hhovBcpALTxw/8m5hzjFRaDC4UwbK2bajDbi9OAukKYrA28Vwz//QoPKkZO5EihVC51iiM56u8hdrWXUS2/0AIzBjGvXdiuCLchvCqn+QhaVxV7s/5aNz07ZMZ7fL5Udgsu5+tOkfo/MNjzzShmlSPfzZ+nhDc3IuL++M=
Received: from CY5PR15CA0093.namprd15.prod.outlook.com (2603:10b6:930:7::21)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Wed, 13 Dec
 2023 21:27:45 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::e5) by CY5PR15CA0093.outlook.office365.com
 (2603:10b6:930:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 21:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 21:27:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 15:27:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/pm: clarify debugfs pm output
Date: Wed, 13 Dec 2023 16:27:29 -0500
Message-ID: <20231213212729.1965153-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213212729.1965153-1-alexander.deucher@amd.com>
References: <20231213212729.1965153-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|BL1PR12MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: e9893f3a-34ba-427f-4fae-08dbfc2258f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z85YIP9lhDY+c+X7SXsEqyaSKbqbHTOjIH5IXcXg5yEbbR5+4UnpMu3+EhKA272GZtKdZPvI4fbuvKmSaF6srx+nPp760osSmX2u/VYcZVLzKM2TqUUhMa0DRQv0BB17Z3icEsDUVP3QkWtXTJSxt4XRd5i71MgdlI9qLo5YJ57sJ6AHclD/7ymp0mZvfNTG+aqywspDAKxFeODb6Mea2pMPYCyfYsDJ7iPHbn4lJjktHV5KiC8gNeH16DhhoRbozoZo+avNoTlOHWfK34HhNTx4q8HwNrskkXw8Q8a79MeR6jS+nFv6VH1A+Mz9tko2J3Iug3+DKX/mMLUSfPoTYS8TBWPrqtKynQigr/M7mvLz0wwqIwdaECeEAWtezSMtTAkLxqk3Uh8nS2GGhMAVc6D3Fx7YM0MXft/5ePq9N9L8ZCtsLuwsCpRE8zhQevVCgMRdqsCsJoVgx6rL7r4Wth7DqZ9/DedmDONzKblUD6qoL2YBT+qjRrETjuVj7buwUXfThwgyDXFchIw4RO/bwga6H0ja31tLxHKHGnsE96dskAS668PscxItnaeuKGy6iw06bw+mUFZ9mwN7zmqjiz0B09F97eAV7xM35vvOjt+FuI706q2aEqayw8/AC+fxAC+l4x4tzYfljkpy9LZ5sHZ3A507nW1aV+ohnMZIIGTJ1kIbHgzGAAsoUDcMwdx5FnjpUYNLAfTMTeD/ZI+9xh5WcUNxLAqm+HSrD9z+ITuj5y97eo9XYcN+O76iAa+P7oU9AavASHaDb3j2OEuFWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(7696005)(41300700001)(36756003)(2616005)(1076003)(40480700001)(6666004)(86362001)(81166007)(478600001)(356005)(4326008)(8676002)(8936002)(2906002)(82740400003)(26005)(16526019)(426003)(336012)(70586007)(70206006)(316002)(6916009)(83380400001)(40460700003)(5660300002)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:27:45.3457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9893f3a-34ba-427f-4fae-08dbfc2258f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
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
index 83907c60c70e..4fff4677e13f 100644
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

