Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A5CC38142
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Jan 2023 08:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C1510E347;
	Tue, 31 Jan 2023 08:24:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C4310E116
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Jan 2023 08:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXJrPgrvJd3EF+tFbnLq+Fn04IBIBSCxOuyLe9v0+iAKIRaSuOe6UYAy/ZiMoCasMzLoLPtsCHRaskKDBLAU+nc+oUassQBYnIBm3E+F7c8DtIL2xxu/28T9pm/d6U/J+rfYFwtQ3sgq1RQlKIjLCOqjm5Ahdulvr3ferzQ9KwTHCuszaSgpFFH3e6bOxs7aXMBGIec6ZxJVAGYQG5pA87Ay/5zNOnXH6CFUT76o+XPbyAAF2iudUubFX3n27RMDM7NxECHzBIkJJdqh/dOPOpMANJKLTcruPS5wf1w+CGIs1AJhW6Y4edPzxSbzs6nWV20Ms/hM5uB2x1Viqa9vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBJjjF9rRD4MMCW8ORnP1zvpFZvHfz2Lv12l5Ir7jkY=;
 b=k27CxDMzCil4D5QECp/KzgYZsa/6HH7RvaoccftGBRcDpgI4wdcnzI4L7UC4vS6x574Tgn3ZlGnLOmkOB7nob8tUY2eOM+psqpWV781PiCgCkTAsGXA2VF1bqiWkKb8JCJ246gK9phC3xbiteiUvPgSQILGrKtRkotHNzW5U2fWE0e7yk/6sohq/eIiTSitgb98aD+QbfiL1POuABF+yb0N69uPis+i/ll9DBIpfHF55PXgCdPJp65JwwYEAdj6dmqt44cPeyLGJMoFYJTRqNMAGdCFofc21xnCCjLj7BZFLWnW4M5tIItyXE8D9oCFS/ZXtcDMxF/uI3MuPJTCRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBJjjF9rRD4MMCW8ORnP1zvpFZvHfz2Lv12l5Ir7jkY=;
 b=Op53yf1ggM/U+la06yB56BPi35gvSSk5DHvf0IDaQBzN+vwmb4ReljsTmlt4ONoCAkEDEN3dylYpJzt06kyo3ujqb4XfB3onRWODfPHKoR4gn9zWs6PU5t03kqjLpWu0T+dfB1tCqof1RHErwYpWYj8CROielXKGkWHG0iRe+4s=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 08:24:12 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::87) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Tue, 31 Jan 2023 08:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 08:24:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 02:24:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 00:24:11 -0800
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 31 Jan 2023 02:24:09 -0600
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable vclk dclk node for gc11.0.3
Date: Tue, 31 Jan 2023 16:23:52 +0800
Message-ID: <20230131082352.3315913-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: c57b7b7e-e1ec-4a6e-6904-08db0364882b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s59ZEFRZNjA4Orbph0HZpnEll5in20ehyKln5c+NRlWgjKwqkgKnPs8+zzf281+mUozh/FsvP+OrRgYuUt1whn3r3PlGWdqfmFAyZvGKEfxtGX4R3Iq4aUJFfiDsKT0r9YC40uzHDBNmlNTGMp7KxG5LXTeLL5EmpsCWkj2kUDqeMbyuicgCuKPzjIQrgelOo58RQNq8wKEDuojEEkV5A2K10u6uIVy5Rr9tWzloDpkfoi6/SyLJyNDPWA5/0oYkkzgw6sdXSwKPf/eNJPTNgzZjjijFiZpfdQIsUTFTc1rPn0DTD4UOzswo2o8Sdw+pC/98R2jz1auN3QO8KBbESJtQi0BkUSM/1jvZIRGVCZp36RMBbKmnB3INSvLSZluYsBY++Bipfv6J91lBKtSsvM3WCAdH+04NjFHBW9XnOYIV6DjpyI/Kg0AhLJI28ORZdCXFD/CPj3uxuWG4a49o70w0okaJ5ZjnEXgFdXK8Vp/D6UfVtzoDbWnILoorZf2DwSKtuNMiPK4FmzUshzjT6CT+dqI+fmAhw88PN1yqbKht9G8qImu7KdMLBsHMCeCHzBdzY+040VV2ohPIGpnsuJMvpbj2fAprtXzFbm28j9x/EuTESRFbO7XwMFWoJrt0FJakJm9i8/1SiQO8Uwth15DE1U7EdmkH6O34YjHwVrabueRsfkvQ2r+loQkgxR6Bn//ayDXsiTsp+sQ/jxS46eNg/kpk6ugr2d4Y2qgqbfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(54906003)(5660300002)(2616005)(316002)(7696005)(44832011)(2906002)(41300700001)(8936002)(70586007)(70206006)(478600001)(6916009)(6666004)(4326008)(1076003)(186003)(26005)(426003)(47076005)(336012)(8676002)(82310400005)(83380400001)(40480700001)(356005)(40460700003)(86362001)(36756003)(36860700001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:24:11.8435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c57b7b7e-e1ec-4a6e-6904-08db0364882b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: alexander.deucher@amd.com, Yiqing Yao <yiqing.yao@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These sysfs nodes are tested supported, so enable it.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 76b9ec64ca50..bd060697d982 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2007,14 +2007,16 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
 		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
 		      gc_ver == IP_VERSION(10, 3, 0) ||
 		      gc_ver == IP_VERSION(10, 1, 2) ||
 		      gc_ver == IP_VERSION(11, 0, 0) ||
-		      gc_ver == IP_VERSION(11, 0, 2)))
+		      gc_ver == IP_VERSION(11, 0, 2) ||
+		      gc_ver == IP_VERSION(11, 0, 3)))
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
-- 
2.34.1

