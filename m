Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76877C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 02:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DF210E1AE;
	Thu,  9 Nov 2023 02:12:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5628210E00F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 02:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKwkzLfcOMGiLiTpjJXDyqhsTFozuEoXGaEPtlWqagWr2pb5tK5Ecb8QoVEKFDtwY0aYlq4mPStFYMoNRSQwDKss8srY1MSeT8UXdvaFIUVUnxpM+dEsaA4jEgAORP3MMuu9M3WyVkd4HvEYJSBEqnJ5epz0ux1O8iverOIvVojzNGDU4sA97WJ6Jysc9l4TM8PHE4fVAdf7+CK9syEzq6Q/3cjzv9jJznVLAocfwmAVavdVVg+G9Y3nxVQJA+n763GeUD7go6zZBIVjjRfdSjiakX7qeA3VqAcspvS3Y1sV6oEOVyn5dofCg41+qjBozGFQNZVsOUx5WqBEZ/TZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD1FAi0ka9WlTfrgKhwKN610Ap2GR1r1lQj+cKkO6e8=;
 b=i9bQObnKJ+13XB1BvvkvZqoF1Gzw3SLWKQdxK7dJWN8scmx2pNyRARQTGbXt8n9p9NGEicwYmCpJP3ApgeQXKKx144GWlWTym5JuyfVsqI0DZTLu6p+FrYw0T5miB76K6QRCTA9vvdgAq7xv3rpUqOMKQh8hhmsJT2ZP9XBBibNE3TO5bEDF4XAqjEucbxEACI9l7g6a5yd5YYfZ99SL0SzVwauFUIRuycTNszay9OQpICC5bCy/YZgKPda9VlAsgx8wHkz35K32xkMasDOUtwiNev118ckjwGxpJnMT7FbU5+nov9OdYxH6AiZXMHMMlmsXYFt0k0GASvlS2QP8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD1FAi0ka9WlTfrgKhwKN610Ap2GR1r1lQj+cKkO6e8=;
 b=wLAaAkH8fCQrX+knmmeeERFgYkGCqICS89Y7MOYQVAWGHR/74PsH2w+rXQX9Z/dfkd9t/DqBIEZufiIbBaSVJ9sVTP13wxF8qtn6w380lpVq4ielA5Rcr6P5c5v0EcFxozJE4ycGG0y1yJeEE9x0gajJA6tG0tyZxEeeMHdKGyY=
Received: from SN6PR04CA0074.namprd04.prod.outlook.com (2603:10b6:805:f2::15)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 02:12:40 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::c4) by SN6PR04CA0074.outlook.office365.com
 (2603:10b6:805:f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Thu, 9 Nov 2023 02:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 02:12:39 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 20:12:38 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kenneth.Feng@amd.com>,
 <Alexander.Deucher@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence() static
Date: Thu, 9 Nov 2023 10:12:21 +0800
Message-ID: <20231109021221.4055378-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fff142-cec7-4676-cf0e-08dbe0c959ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVaql5DQsZbCfuocS2oMuWo8qvWblMRcbeRGfOfufBsGH5QoiQd/oQRdlZ9HvXbj2wqjUroS5Frcg2oM5C51MNG0+oYfZpUACEND261rKdR7qPqwUisL6Qu77raS65L3DMmDMPUZMc2JldorneDN47lE1iUIEwcmM4BmTAgDW05CFNLEoWa6zitd9WAtja1fAlGqNEuEK4U+ikUN6xNLyi7PrlyG1QGc7Ks4zxsbo4x1w5CPGtvoan/VEWz12a0ZPhUAYe8YS9UxYF3pO3cqjlgnNHfsfrWsHbwc+ZIjfedhjuShSwQeR8KNh8OA5ndoendZC39qorgm6nzg2pNOSypXFcDi+U0SBTjVA5+wgxYt7EzdVStOa/OHBsfR6i1MP76tILogfrxb72jv4WTmHvYCRnKTj0qGWgxUZljPtQ+OG41tMGDT8vcWHM/rkrIynFat/nuQ2vCoHzpuN4m3S/WKctLcVRPtpex9f/kZixjuetoUx6EsEi76ve8jqptZzjKtXiEl3lC6O5jozxo9QOXNLVY84dlJ3jQZdTDFsWRUAYW/261qGMPs6zZ05ZC+RC/6opwzQjOb3DOTbxAzXThq0jq7tMfX0r+Fp4FPldAOFQ7Iqksul16nMfVgANWbJTJtgCnuUCOkwKb6m96KxS8BqzzoVveEtbnilzf23aQWL8OKnFns5LD+PE3rdGOr8+G0BrPTe0dh0yeFUE+cQtq5EFKHNeDy34X/KqcpAk6LED2AUoegkKH/ZgRmV1RntybSKflOIB9t4vBR9pGL/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(36860700001)(356005)(6666004)(7696005)(83380400001)(81166007)(40480700001)(47076005)(426003)(40460700003)(26005)(2616005)(41300700001)(86362001)(2906002)(8936002)(36756003)(8676002)(4326008)(5660300002)(70206006)(316002)(6636002)(110136005)(336012)(82740400003)(478600001)(16526019)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 02:12:39.9952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fff142-cec7-4676-cf0e-08dbe0c959ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

smu_v13_0_baco_set_armd3_sequence is not used by other files, so
make it as static type.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index f307a7965941..5e7b8f29fecc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -210,9 +210,6 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu);
 int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
 
-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
-				      enum smu_baco_seq baco_seq);
-
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
 
 int smu_v13_0_baco_enter(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 891c3fddd7b9..5e86d874cb89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2198,7 +2198,7 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
+static int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-- 
2.34.1

