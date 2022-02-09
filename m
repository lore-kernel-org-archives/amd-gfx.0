Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB15C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 05:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961B310E229;
	Wed,  9 Feb 2022 05:58:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E714810E17E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 05:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HypIsMxJ+02gyDqTBn/PipPxMarxnpsLPE1C1Ikoe4eQh+1FQ2cmRRXkOL4M7oCA77mB2awXjdrNYhOwhNok/MwJmeKKqGH1zinejp/oj8C9BHpwesbHUnP/mBV6I4ctolQpL64R6sOf0N2QHXkZpiFyoEI1QWgqY7K2Fi12bOLMN9zfwjCOp5fMwm+Esr7p3Yq+nIWfRWHb3hpePfHdPTJa6vqeRtn2pzrKp8Z2sHgAK9ezivyVaQsWBKFtJ7+xoIClAJl1j76jkbewE6ih4ayZZhjxJIO7E9ggJc7ByQSRDxH/AXFg5EiTywH0QURzokt3BfnIAXqI9AALD1I5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlO6i5qOzPSPO1KepXa9y4qosphGHy3obSSZIxTcGv4=;
 b=VDXCRWqbcqY9U817ouh5iVPdUf+p5O0gcv4O0BVouKKNLWDXFY45XVwUoC+T/G/xx4nNfFmSPhZUMXEHhebO611BZJrMu7GQXAwVSZMte0DKdsXRhjB1cIf0nN7szJyKkTUHQbtWSoAjWCaYuInCg7G0ol0zt/jt+Twr+91M9Cu0ql8drsvuID46Xep4mTJY+DbaE5FwfV50vL7e5gL0j+wTOBVnCOR8wcR0l3WcqjBM2lqNJZ4nTj7GVLZ8w+MdEQc7Yu6UcLnMX+VQTi3XibXPJuJHmIPKIkYRWATBRaE8yHXDjkD+IfF4ZB793U8guU4XXqfYExYI+qBuw5Hsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlO6i5qOzPSPO1KepXa9y4qosphGHy3obSSZIxTcGv4=;
 b=UIlwp8EjftIZ7FUVjEfYkdDM0eInJpGNj9Dkpu1fQmG0Iz4ly2TgBENB9T5QNiH4GAkjsb19/pTCwclmY18TQRE9cB/HP2fBmRVqIhMxdpHCpUThVFfO6pixAGlaBVpMIGNplPO9/bGKk55Gr+cDRaZ4DWSHJ3lJZ/VQs1RIMTI=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 05:58:05 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::78) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 05:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 05:58:05 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 23:58:02 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/11] drm/amdgpu: Optimize
 amdgpu_mca_ras_late_init/amdgpu_mca_ras_fini function code
Date: Wed, 9 Feb 2022 13:56:37 +0800
Message-ID: <20220209055644.1873011-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68060517-0d12-456a-ab7f-08d9eb9123ca
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4522DADF82D2C556D381DB01FC2E9@MW3PR12MB4522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2RQJyz1rUInEQKCQVmPdM6p0oYyhGK4GUqqsx7cykJYbrSZs+3TUcccCg5W4yedh1/sdfRf2kvCD2W6ttHrf7VZjCbhLdC1HDI74UUTOxkdtxVve4wtdiP8TA1hPQ5LBBssYfsaqZCcHw+wN+q4J/4wS5zbqCLNDsH7T3DLhAVN55oT1OI5k0OYBoaHDSiCn3yjrE/LwmgKeoiGcjpkV4CWevZh4wsxQ+QY39JYl63ttY6ruBsrd+no7oa+dTJeBeOrwODoefZ8z3MRrOE5uFTkMn0WGNGskATxPpGcl9v207dWFlhEo+XR2tcLoWiIWRZ2PssbxkDUIVzsY4WNnzuERTJ2j4F5mJGdBdTP+235U53EaUlyGIUzY6vfKBIghDNEgyV1IEsU+LzGaMdLMsITAOsFL7hslGcEgacQ8yYv2O3Sfx1Rf4O0n2Nu89Mw65pMc60L6XMi+zxntjvY4g2+D/QjLO0D6hfaZkOCuxJSNjfp7ZvBwhVHR3QMSb3eEN8fg8VY+hCeF8TrkukdYilG1PCv1RGxE5wF52z2lCiyxwaCGYGLs8aOoE5W5GiPbNa8RrEdKCfwErPvjJ9oXv53A8DEAh1qnPhDmmYcCh6Fasi5zmwrpMvlEmlUVrJd9nLyTuLFAx/1WJ5uKb5AZHh536RYIyb+U1DDWaWB71UlPHil2D+1tplM1Exff3GTrXQGbeDvOIg0guY6CV0XxQri1wwc+fP/nO34kIXZReU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(70206006)(7696005)(6916009)(8676002)(82310400004)(316002)(86362001)(336012)(426003)(2906002)(26005)(70586007)(54906003)(36860700001)(2616005)(47076005)(36756003)(83380400001)(81166007)(5660300002)(40460700003)(6666004)(16526019)(1076003)(508600001)(186003)(8936002)(356005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:58:05.2280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68060517-0d12-456a-ab7f-08d9eb9123ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize amdgpu_mca_ras_late_init/amdgpu_mca_ras_fini function code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 41 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/mca_v3_0.c   |  6 ++++
 2 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
index ad057d6b2c77..1c77fe7e9e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
@@ -74,48 +74,11 @@ void amdgpu_mca_query_ras_error_count(struct amdgpu_device *adev,
 int amdgpu_mca_ras_late_init(struct amdgpu_device *adev,
 			     struct amdgpu_mca_ras *mca_dev)
 {
-	char sysfs_name[32] = {0};
-	int r;
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-	struct ras_fs_if fs_info= {
-		.sysfs_name = sysfs_name,
-	};
-
-	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count",
-		mca_dev->ras->ras_block.ras_comm.name);
-
-	if (!mca_dev->ras_if) {
-		mca_dev->ras_if = kmalloc(sizeof(struct ras_common_if), GFP_KERNEL);
-		if (!mca_dev->ras_if)
-			return -ENOMEM;
-		mca_dev->ras_if->block = mca_dev->ras->ras_block.ras_comm.block;
-		mca_dev->ras_if->sub_block_index = mca_dev->ras->ras_block.ras_comm.sub_block_index;
-		mca_dev->ras_if->type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
-	}
-	ih_info.head = fs_info.head = *mca_dev->ras_if;
-	r = amdgpu_ras_late_init(adev, mca_dev->ras_if,
-				 &fs_info, &ih_info);
-	if (r || !amdgpu_ras_is_supported(adev, mca_dev->ras_if->block)) {
-		kfree(mca_dev->ras_if);
-		mca_dev->ras_if = NULL;
-	}
-
-	return r;
+	return amdgpu_ras_block_late_init(adev, mca_dev->ras_if);
 }
 
 void amdgpu_mca_ras_fini(struct amdgpu_device *adev,
 			 struct amdgpu_mca_ras *mca_dev)
 {
-	struct ras_ih_if ih_info = {
-		.cb = NULL,
-	};
-
-	if (!mca_dev->ras_if)
-		return;
-
-	amdgpu_ras_late_fini(adev, mca_dev->ras_if, &ih_info);
-	kfree(mca_dev->ras_if);
-	mca_dev->ras_if = NULL;
+	amdgpu_ras_block_late_fini(adev, mca_dev->ras_if);
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
index 386416378a82..a307f336f7ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
@@ -71,6 +71,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp0_ras = {
 		.ras_comm = {
 			.block = AMDGPU_RAS_BLOCK__MCA,
 			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 			.name = "mp0",
 		},
 		.hw_ops = &mca_v3_0_mp0_hw_ops,
@@ -108,6 +109,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mp1_ras = {
 		.ras_comm = {
 			.block = AMDGPU_RAS_BLOCK__MCA,
 			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 			.name = "mp1",
 		},
 		.hw_ops = &mca_v3_0_mp1_hw_ops,
@@ -145,6 +147,7 @@ struct amdgpu_mca_ras_block mca_v3_0_mpio_ras = {
 		.ras_comm = {
 			.block = AMDGPU_RAS_BLOCK__MCA,
 			.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO,
+			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 			.name = "mpio",
 		},
 		.hw_ops = &mca_v3_0_mpio_hw_ops,
@@ -165,6 +168,9 @@ static void mca_v3_0_init(struct amdgpu_device *adev)
 	amdgpu_ras_register_ras_block(adev, &mca->mp0.ras->ras_block);
 	amdgpu_ras_register_ras_block(adev, &mca->mp1.ras->ras_block);
 	amdgpu_ras_register_ras_block(adev, &mca->mpio.ras->ras_block);
+	mca->mp0.ras_if = &mca_v3_0_mp0_ras.ras_block.ras_comm;
+	mca->mp1.ras_if = &mca_v3_0_mp1_ras.ras_block.ras_comm;
+	mca->mpio.ras_if = &mca_v3_0_mpio_ras.ras_block.ras_comm;
 }
 
 const struct amdgpu_mca_funcs mca_v3_0_funcs = {
-- 
2.25.1

