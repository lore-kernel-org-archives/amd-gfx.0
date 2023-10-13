Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A460ECDB47E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 19:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD4310E605;
	Fri, 13 Oct 2023 19:26:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA1D910E605
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 19:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBTqEOU82Zs4xDlA9iXUe4DpsGvpsOm3guYFpuWrq4U06VI36lmjflReAh8StrO/muoA98ryaeZ77s20rl/nEhbl/VWmwtS0Gk2lU2YAxd7jrwathX984Abc8B3kddaj3vlujIdnvAmDxmkvAW8mSYyBJVhTs7Ehk0w1HY/XHqmPTrzP2notfbRsNNM9ETJIgX5kzHKe2+KsVgTEnTMT6o/cZfNaxEsM/LY+qOjTnuOeBBa/2auSd15A7K4V1ARypamtSZxFjoaNdPI/ufhjxEmErLQwrKSl9SrkuatPhhlQjcjVwcJXBCffrWMsN3o7/M+dEq7mXL2ayZ7OeyjxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBeNA0NV+WBm+KQLzXtt1mZElW3Q6+fnQ6+JmauqXR8=;
 b=lHdicuLdLmNSM/hDW3VEtw6rjQG3Cl1oQwQRNP9CGsL6JhKvwiEo557Mi3ccZ24bU9o2A6WiJFHvqmbikUDc6QkDR0VFP1bV2WTpiIjewb2C1Ki5lUjnrI9tnj2flNn2LGAEs4P7CixbOJt2nJhtz1bheZibfjUv7mNcuM0J9dZPdUI+2CVMcwjy/A/vzPlDOo2+V2elx2qbAYMoL7We0XMVIvObnZe9QcNkBiuuZlsJGc3ZF258SVqz2nM2bo2cuD2tqRhs0PWzJ60PW2gupsZt0H6LdYSU2RpqXrWd0onmhSZ4WrGm0jOnXgmRPszVwZ8yw7lu6k8B7WfotsV2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBeNA0NV+WBm+KQLzXtt1mZElW3Q6+fnQ6+JmauqXR8=;
 b=NmSQwT/S5JB+wmwToaQmH3c9kDjwjbId9A4r/HZs8ERJ0pQJ798os12M3x5v63hfPNGSNA9vXiqhlmqKbEa576cv/BL5EL4gopoi8z4NHFx9TS7aZbr/QziP2+cexl1VFsLPj6kKvArtmbF2bwNy7ZQVxYLoDWeA0PJ1lI9is50=
Received: from DS7PR06CA0015.namprd06.prod.outlook.com (2603:10b6:8:2a::26) by
 CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 19:26:38 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::9a) by DS7PR06CA0015.outlook.office365.com
 (2603:10b6:8:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 19:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 19:26:38 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 14:26:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd: Move microcode init step to early_init()
Date: Fri, 13 Oct 2023 14:26:02 -0500
Message-ID: <20231013192604.200515-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013192604.200515-1-mario.limonciello@amd.com>
References: <20231013192604.200515-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH0PR12MB5153:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b79899-2453-4a48-d1c1-08dbcc22526f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cwaqm2xEfffLzHHBCSQtBLsHC119VqgPRxGhvLNOoDQBKkYZFjjvBjmuYdU/zAiQdUvZMxIAlK/LzflHWexZT27C8vGTW3ioISJ22Z9BfHwY09vpcPeS6yb1s1x0SLbQAXxdL6DloCFFJ7CP0JK2QMaAIPYH7hNVyIfaDBkhZ3pFtjEQGJMFzo3BMsJXnUgWNqfl77U9wpLzDhaZBFxQkLSJRLM1uMQ0vN42EQD50pKtTkZuBWCTIh8pq3ToEec9ENU/8fHh9zYABh+DZq1HQh7JjJIVGpDWqG6lmz4sBcge8SoSIcZ8NabAyMNik9S4EVCAoDfKQsLTdpCvfqYLNO+mny/hV4j78g6aKoh9egng3UMx4pPAr55YFjsLkswQwn2af07HyJAbY3jeb3S0096saMbAqZNqxmCVe4KW9ASHtCa+gEpLvioZM/ASOuO5dO317hW1emk+9qJ+wI9+LXze2Gez0eGQp8gY2Cv6A5JRulgvqAbY0gLoMeNGNMcnTwYfTsd6TetLH4w1WzCZjvqoMIvb7sSX6h/X3IWHBQR7sJPw6wVlk4/yusN0mSEbY2ItxTch/TxNi6VnxwpbZFJzrchJqYjRq7zBbf6bsVsrK0Ea4zlvXqVtXgwonEBDiznGTtzu5wSXn7Diriv6BfbbZ0iMHDz72zjaL6YrK1B/TeHLsGtpZXRwqYtHf2yCqToivqg2mkMgYMbAl2su9ZsfO71cBGYfK4aZhIZxYxRdDAAilISuoSMlT6hyEIHz89ZkQtEXZ1z+wtsZL47Ong==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(82310400011)(64100799003)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(82740400003)(2616005)(81166007)(356005)(40460700003)(478600001)(36860700001)(7696005)(83380400001)(2906002)(86362001)(47076005)(36756003)(1076003)(336012)(426003)(16526019)(6666004)(26005)(8936002)(4326008)(8676002)(70586007)(70206006)(40480700001)(41300700001)(316002)(6916009)(5660300002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 19:26:38.6290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b79899-2453-4a48-d1c1-08dbcc22526f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The intention for early init is to find any missing microcode early
and fail the driver load if it's missing.  Move this step to earlier
in driver init to match other IP blocks.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 27b224b0688a..f0957d060750 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -589,6 +589,14 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.mec2_fw = NULL;
 
 	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
+
+	if (adev->gfx.imu.funcs && adev->gfx.imu.funcs->init_microcode) {
+		err = adev->gfx.imu.funcs->init_microcode(adev);
+		if (err)
+			DRM_ERROR("Failed to init imu firmware!\n");
+		return err;
+	}
+
 out:
 	if (err) {
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
@@ -1395,14 +1403,6 @@ static int gfx_v11_0_sw_init(void *handle)
 
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
-	if (adev->gfx.imu.funcs) {
-		if (adev->gfx.imu.funcs->init_microcode) {
-			r = adev->gfx.imu.funcs->init_microcode(adev);
-			if (r)
-				DRM_ERROR("Failed to load imu firmware!\n");
-		}
-	}
-
 	gfx_v11_0_me_init(adev);
 
 	r = gfx_v11_0_rlc_init(adev);
-- 
2.34.1

