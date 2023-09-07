Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39BDEE14A9
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 03:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1699310E74E;
	Thu,  7 Sep 2023 03:25:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEDC8825B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 03:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj3Th2SiHn3y935jrdNOqT7HesOBziyjfnSStrfb6jZTZyTn/AuHverYffEtpHXtxA4Hxa97JO1qjMkBKfCXEcX9qzambTmxgk3hoilBELTmxen4x1MvvjPzyL7JatONdX/p/24WUvrijsNXliocqu7bAjuRIQEjnyn5wEh7fWpQnaUo+CixKKb/9kGDy9Vrkd/Mek0NMCw47wrpOVHqrDPrt4BOf8eU/fXbGDCwxtnVR7eSPh9ijWEogI8LUu0iK4Pm+C5EoqGkF0aZPOgpwAt7VCpdxPjv0kMQG0D0HhyE2Pg0rsX+1jWN+YEKvE02/9VsXimudTGWaxm1oRW95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KI2RYg+zduXkkZjIn2OKufrcrrWP+hRR5weQoCFVPzs=;
 b=DUiLJfGPELnDE9js4Jr/4Zatoan3rdx1syvGh4YSO4LPCUQAYdqw5B3hRsHrPzV1Xh6Q8vtnFHi/cEKcCyVqxLM5AXqH5a+N+lvoLeVBO0U99FUh7Ud1d4f9WxzZKGqfjieVXktZSDXDcfwPh+Olhf11W1K0Oa42rudQnIUKGPBcsVVefdtUXsfkH8JVq1QYG9u2jQDu0cITzoi7nE7qfBOlRqUrGyidLIB6oC3ptDD5UX3DhvZClr6t7YZFoshkfVsWBEh4Fo3A/gncnaaXbePlSOoHysqBDjDJUnG7Za8X7Ppz5vFKDIPYaMYZp40L4khkgJ0pi2o0HFfUoiIB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI2RYg+zduXkkZjIn2OKufrcrrWP+hRR5weQoCFVPzs=;
 b=v1vYn+LfrFXPJ+AOGhAoyC36dARlpMzAuYHFTcFVOMmxSME0CEARD/czDKKkJU6v6bwggJPNByDi/hW71soXZYfM7AyiAk6wcr62+aogRwBg8gRhT1DqC7q8SU0x3Yr2qNglZcXgUQxPuCHnwW1IohwDn5vSoYATRqppH5ySf5I=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.36; Thu, 7 Sep 2023 03:25:20 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::c2) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 03:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 03:25:19 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 22:25:16 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add type conversion for gc info
Date: Thu, 7 Sep 2023 11:25:00 +0800
Message-ID: <20230907032500.99796-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: d55c4a9e-1ef8-4af5-9a2b-08dbaf52104f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImuwEMBgg8VQq0+gDKvVamjUIVvsxTs/wf6L8sdzmDrbn1E9NZokWLT1cA0DC2G8WjTl/AwjPlXct7b8T14hTa2FSLXXLu0Lc+l9Dp8LLIrVi6aA6aqruOfkNn3+rVMrs9pBud84t+oFxXfaa/fv/svG3mDjYbOCJhJx7hVd/LTF44ZWHywRq0ZeDGDxUMFrCM3MmbMa6Iqr0P5bN4N3IhyK9+a66AmikNN8JcrFmRvi/pMtcUTtIzxBjYO7plcoAsNXUFzErldZ97Fsfwb0a8xJwd+LIyIqD/w8PcgsP18gQmGTprv7YHZzV7RwNksR9LG4rV1mhAfLmkjYfm7lgqktdpRHspqiTIzCgNmyVCwA8tD0jy57sNw2x8/RXoGOxxnMH+fbgZSMJkhHt6TDaIUUb8XH+VMZ+8zo80zwvRmT/QxyeZeBySbt0xJm3E1WgvxfyywFBURSi/WJvdY9jnhMYaGP2F4N6wmYWrJeWhQy2TqKmUUuAIxuPTMMhpldhazXfdk+KpNY8WvHyu0Ummi2xzV3vPgFQRuBVpbS5oDLFQLAvGh4zbv+AjFqF/1xeBLlJmK3SlUKGvg6wKIHEE9dLHnB76OsnrDyikyGa1HvyYCJbnuR68p06ECqrSZuWtXl6iCumWP8oF2DLO2/Qm8fyuk+Yu1+yjnL7kp5ZI77RPPzasDO+pJ96slXI4dG9QXu4SPsiuWSojra0jggim487qZ1WTKhio3q1RgQ4aycHfbkXATNL+jugO7Pndk2WJTHXciwzb5Cea6jxhJQZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(81166007)(356005)(6666004)(7696005)(40460700003)(86362001)(36756003)(36860700001)(82740400003)(40480700001)(47076005)(1076003)(26005)(2616005)(336012)(2906002)(16526019)(426003)(83380400001)(478600001)(70586007)(4326008)(8676002)(8936002)(41300700001)(5660300002)(70206006)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 03:25:19.8107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55c4a9e-1ef8-4af5-9a2b-08dbaf52104f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gc info usage misses type conversion.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5d179edcc8a8..9ab33b0bbbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1439,12 +1439,12 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v1.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v1.gc_num_sa_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v1.gc_num_packer_per_sc);
-		if (gc_info->v1.header.version_minor >= 1) {
+		if (le16_to_cpu(gc_info->v1.header.version_minor) >= 1) {
 			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v1_1.gc_num_tcp_per_sa);
 			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v1_1.gc_num_sdp_interface);
 			adev->gfx.config.gc_num_tcps = le32_to_cpu(gc_info->v1_1.gc_num_tcps);
 		}
-		if (gc_info->v1.header.version_minor >= 2) {
+		if (le16_to_cpu(gc_info->v1.header.version_minor) >= 2) {
 			adev->gfx.config.gc_num_tcp_per_wpg = le32_to_cpu(gc_info->v1_2.gc_num_tcp_per_wpg);
 			adev->gfx.config.gc_tcp_l1_size = le32_to_cpu(gc_info->v1_2.gc_tcp_l1_size);
 			adev->gfx.config.gc_num_sqc_per_wgp = le32_to_cpu(gc_info->v1_2.gc_num_sqc_per_wgp);
@@ -1473,7 +1473,7 @@ static int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 		adev->gfx.config.num_sc_per_sh = le32_to_cpu(gc_info->v2.gc_num_sc_per_se) /
 			le32_to_cpu(gc_info->v2.gc_num_sh_per_se);
 		adev->gfx.config.num_packer_per_sc = le32_to_cpu(gc_info->v2.gc_num_packer_per_sc);
-		if (gc_info->v2.header.version_minor == 1) {
+		if (le16_to_cpu(gc_info->v2.header.version_minor == 1)) {
 			adev->gfx.config.gc_num_tcp_per_sa = le32_to_cpu(gc_info->v2_1.gc_num_tcp_per_sh);
 			adev->gfx.config.gc_tcp_size_per_cu = le32_to_cpu(gc_info->v2_1.gc_tcp_size_per_cu);
 			adev->gfx.config.gc_num_sdp_interface = le32_to_cpu(gc_info->v2_1.gc_num_sdp_interface); /* per XCD */
-- 
2.37.3

