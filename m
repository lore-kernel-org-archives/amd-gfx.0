Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87F7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 02:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C80A10E37F;
	Wed, 19 Jan 2022 02:57:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C3410E37F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 02:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfcB7LodxKObMCYnsLFKa0w3QqGlXTl3xf8d4xeNFg7E41g6ZPVX5HurfzU1zd8Dm65VYQdzwzxdRjj+xx+g/aAAbv5qBCbSccE1aVEipXDXXhxC/RbOeIsP5fTnQnuXCQL8grT+y84+vjPXHunAY+kqMIDugvbgSckkjTQdtLb6DEHhC3Rcnc9UPFA26fSYkACy5LBSlh0DFvtwZIPLo0eZI9MiF7NBywVMdYf3PHBiSpofSPsr0gZCVu04+D/0Rto8ZRhZ40lpEuu9zh5i4B5gz0vAYiXwnuQEeTtIlwI9WJdLI/T7zjvLv7ViPH7gyTQG5oWFF8dk6Pag2lsb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4tlm3GBgvhd4GZNzeMZv4isz4fizjqXBuocHp3glIA=;
 b=gpXxvENz2v3ezH1NZDlz4xDfmwpOu5UmKSYedSD14XR8jmn6Bd13nBgb7bCacPhVWz/0lJpHYuywjPzkkKFqVSxZe9b27lsyPipwhQ0RDUYC6Cwqa/FEV2WGdVPKCSlWvEUfEm11gY8zDobY/tp+ZSeyhhKuMg8Fg9LfH2HY/eeWr1yhwiYdU5hYTi1Q42cS158Mzyvd1UTFSVwyHBvDD3qaUsQF41uNLFLY9VH/OpZl1kSrj3gN/poUCkrPtcknIVKv/KeEGW1+sqseTMvqSBj8QlDNGkfvDxLzBohfPzewRKQGtWkLioJ9I7cEhzzGvAuaobEMkbxt2x/leJP/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4tlm3GBgvhd4GZNzeMZv4isz4fizjqXBuocHp3glIA=;
 b=wfj8xOrxsVULIMnbkgvjy8So9NQEZV5e7b1rvkWcHKV7UN/I2yujalv0hOIU2qAvRGTqmmFbK4OeynsXrw1Z1szP7vv4mRYvpxohtSCs1J1yUBMAuVYxilpeRv+9EPDCHDKH5khqTyNMmJC5QLq0KUyAMBwq/PMtfGvg4BkumJA=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by BYAPR12MB4776.namprd12.prod.outlook.com (2603:10b6:a03:10d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 02:56:55 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b2) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Wed, 19 Jan 2022 02:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 02:56:55 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 20:56:51 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Move xgmi ras initialization from .late_init
 to .early_init
Date: Wed, 19 Jan 2022 10:55:54 +0800
Message-ID: <20220119025555.197467-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119025555.197467-1-YiPeng.Chai@amd.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4679499a-a1f8-40f9-5364-08d9daf75a0e
X-MS-TrafficTypeDiagnostic: BYAPR12MB4776:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB477632F964BF4D6A3088ADC5FC599@BYAPR12MB4776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTs7Menx+9BJJ+tu/lfazJoOfprbzGMc84lQawYyTA3+omU+QbLxt4MTekKTVQ5JIMoxRULePepXAbSy4hvu4YS4QycVgIcN+sbHw7faBnV4cSE5SBUZjNHLSqYh8zhBhBqk1yzA+kk2ZhUR77bZCTdpPjhfBXkZIiD5vbU9xWAiwWb2ePQjpG/T0KBF/wKWaz1+zsmTuw8wsTWSzRySqegr5JAYVu6mcemLxRG8wbykwXRKz3e1TkbJ9zMmQxX33UtFfSwrbNt5EfNZvXPbGEyqlh02u067h1v+bNlbUw89Bdc5n2avMgDTq0uzRiMjWF1mXUQu/L6nhai1P5CXR7RqBL/PkW7eN5ftT/7f+RTBXrEAJL/UprLEnY6WYe0/yF7YjDrKrk0IMtZG/jeNwsgIptheUY5R1HvNoCgOjF6jJkeFYwpDWeVVNXMlMD+W8Uam616evxOsIIIFOo0fMKK6m1jkd2ERRm8NPm276aI3j55Bv5gIMd+q9Mi3d4ImQuyhHKiNJgBlLjRDanIuVejg+hQynlQV7aPhYWItYvNs8+ahzVUafayfiGJ9QdQ4mTS2RqRIuMpgONVa6hrFZ46nRZAMyC51zeNukZsBGmCffJr31KD4vqkRiX9HC9mEXkxX5GhoBiSpMGk7fLUOv0baQucRr1i459TDNZjcKzLeBGxzwX73hwW3386y9+WdB8hTXRhUrIkh16GDv4U/Q2z+si3nMdx5a41teixjU2KG6wd3RkXK5vchexew/OHtKICh2M+sohHCChFeWr5oJ8azdwwPbGizPSgqT2F45kFk7ErVgBmyJ+fyQREnoAWkpngTd/H5LDGKA7HjM3x0zY8eK1Y7YYNZaM1HTLDfNmw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(86362001)(8936002)(82310400004)(316002)(54906003)(336012)(2906002)(5660300002)(356005)(2616005)(36756003)(8676002)(4326008)(508600001)(83380400001)(70206006)(426003)(70586007)(7696005)(6916009)(16526019)(47076005)(40460700001)(81166007)(26005)(186003)(36860700001)(1076003)(43062005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 02:56:55.0738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4679499a-a1f8-40f9-5364-08d9daf75a0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4776
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

Move xgmi ras initialization from .late_init to .early_init, which let
xgmi ras be initialized only once.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 9 +++++++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3483a82f5734..d83eee1984c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,11 +452,6 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 			return r;
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.ras = &xgmi_ras;
-		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
-	}
-
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
 		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
 		if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 4f8d356f8432..5f9f82091000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -716,7 +716,6 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	}
 }
 
-
 static int gmc_v10_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c76ffd1a70cd..8d1b11368a7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1303,6 +1303,14 @@ static void gmc_v9_0_set_hdp_ras_funcs(struct amdgpu_device *adev)
 	amdgpu_ras_register_ras_block(adev, &adev->hdp.ras->ras_block);
 }
 
+static void gmc_v9_0_set_xgmi_ras_funcs(struct amdgpu_device *adev)
+{
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.xgmi.ras = &xgmi_ras;
+		amdgpu_ras_register_ras_block(adev, &adev->gmc.xgmi.ras->ras_block);
+	}
+}
+
 static void gmc_v9_0_set_mca_funcs(struct amdgpu_device *adev)
 {
 	/* is UMC the right IP to check for MCA?  Maybe DF? */
@@ -1339,6 +1347,7 @@ static int gmc_v9_0_early_init(void *handle)
 	gmc_v9_0_set_gfxhub_funcs(adev);
 	gmc_v9_0_set_hdp_ras_funcs(adev);
 	gmc_v9_0_set_mca_funcs(adev);
+	gmc_v9_0_set_xgmi_ras_funcs(adev);
 
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
-- 
2.25.1

