Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E06C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDD210F1FD;
	Mon, 21 Feb 2022 10:17:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABBF10F1CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrEa2e9A5+OGZqhblLFRrlhIhF2HYsc4r96oiaDXP9IxMszUznA28qietu3E0kHJKAFfyWHgWLAChiXHhVHyeFsSDX6WJytVkwqkv9E5hVZmRsZtsqOeTErIbZJv7fhOPh3QDBNo6JUAGdfUNlmNjksoRi1zS2Rfu+gVEm/3OnRvqF9XYOSkWKsDPZmreCsmlAv2zaZS+gDEmnBBi32MgMOf8IzPZGoUk5CGrphLiPUOUmTkMBMtsv8PmrrpFkXZgDSwvnArAPvXhak6ZBK1K5nG1l+uu4T24OrLD/H0hJD88llaybk784W5SpXpd6pklbDGG5eZZgV0i0fePQ9TwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1CCpuokoysqX8pC1Udik1qgEQUh27a5/ay26rFCpQ=;
 b=i14tFx3lQeDhifRryS2vPwII4KPaWQOxx373pBadDQsknyqUCx9g7dTNg4ctISaZDpa3YeMw+4lpxiT67DcKHKfGPrrxOKtDqvxdgGv/GtJWUF/s06pFrelBhJm9ma4IM2XerLNS0U6wy2nbUv8SmbqjyQaaIEvL/BdkxYP530qLKjguMTufyHJYAU/HI0cenAtdhRS9nzk8AgFfrxqovfgpKi2KFTo8M/iTVDVjkZ1j4sA6WOwbGPJ+8D3KWHaIJI05e6ehh1pysZrhmvVb6BY95X+Zl7wPGQpIwP58t1cD6zBzJkFTfSAKyXeKG0q7tnl534E90++qLsmNvspomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1CCpuokoysqX8pC1Udik1qgEQUh27a5/ay26rFCpQ=;
 b=Kf2A+3coW1uU1MEgne6fjF4IGyRh62+KNi439vifTkKov4UpcF+XJkBNpckFa4F1vgTHBibIwmuBprbgzXcF0frvXp4N+j7VGwSc10PF2yReE6xtjTNFOYA9PIcLRnEgkjsX4V2FcI/8zj0t+/aqRGPTr59rei7l4MkNs3FWEis=
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by MWHPR12MB1902.namprd12.prod.outlook.com (2603:10b6:300:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 10:16:58 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 10:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:16:58 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:16:55 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amdgpu: Optimize xxx_ras_fini function of each ras
 block
Date: Mon, 21 Feb 2022 18:16:10 +0800
Message-ID: <20220221101620.3269611-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
References: <20220221101620.3269611-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0e891d5-a93f-4eae-4276-08d9f5234b2a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1902:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1902A5AFDB97ADE9C1FEE92DFC3A9@MWHPR12MB1902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKWduLlKu7ifYEtJoUY1QqoI4qC/Pou2LiEHEVpLlHAjgpdIp9kflMYryo4on1nNS1hCPasaeziF5MUCv2uLE5SqQbZdvg9vD0hINJbG810KtazOhpeUljxCqbIuAVsyV2QL0B3KkYkqnDOoK87xG3MvPe6bacxqn5GV3joNlH7+/sIXMkwGadHpRVA9HtHqLwP9IlpdiEi25I4reUzSgQDun7VvJusssT/YqhR7aZAA1kbRv+wZU6PUC26bMNoRyMKlZiyZDYPe1Em6pYyebcWb2fIYGj18fzg3Kake2dNlcK0rWrl3ML0x3Jco3i2I02+rdKoGG8DXTrnEnnhViwYDuP99t4wrsqlY/PE0o5h5FTqdPjwpj56WrbCmSRFa+6erxsrp/7wOsGny0wPtDBsBn/hyhV/tmH8wjsmp4gnzhH6DjgwGGOFXCq4S8h51d9sPy0as/ldpcy+njmtW7FZ6dbrLFRq5CRj/mL9mrbXZVDRRK1sKO5//faaoQ3DjEo0mmKsiXanQoZSOx90HDnBRQtdLYQTkw7HIQhDp0Jie0CGULQD0/2RwcQKbu3Wnn3VXHbbxuANBBQELyJZZtrcbq9MLkst/O8EYypjkM0mfl9d40I7RHw6GNC/fIePKRoZCAUab4EkvY4yJwkp4fo7z20NeBpnqUPR/G+ygJJusuxRBJwYaluA4GZ/iN748LaKCiRErQ/57UxhBKOhi8Xlvhm1+JlqV336ebgHO9/zzp+PgMIxY6IppgsqbASHKR0SfRh8ds8M1A8L2n6eZ+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(336012)(316002)(36860700001)(82310400004)(70206006)(4326008)(70586007)(426003)(8676002)(508600001)(2616005)(5660300002)(7696005)(83380400001)(40460700003)(356005)(2906002)(1076003)(26005)(186003)(81166007)(86362001)(6666004)(8936002)(36756003)(54906003)(47076005)(6916009)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:16:58.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e891d5-a93f-4eae-4276-08d9f5234b2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1902
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

1. Move the variables of ras block instance members to
   the top of the call to xxx_ras_fini.
2. Function calls inside the modules only use parameters
   passed from xxx_ras_fini instead of ras block instance
   members.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c        | 2 +-
 11 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d020c4599433..40f7e29aa9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -647,8 +647,8 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 void amdgpu_gfx_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX) &&
-			adev->gfx.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->gfx.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
 
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 5dcb341cae19..4823c42e0e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -455,16 +455,16 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 {
 	if (adev->umc.ras && adev->umc.ras->ras_block.ras_fini)
-		adev->umc.ras->ras_block.ras_fini(adev, NULL);
+		adev->umc.ras->ras_block.ras_fini(adev, adev->umc.ras_if);
 
 	if (adev->mmhub.ras && adev->mmhub.ras->ras_block.ras_fini)
-		adev->mmhub.ras->ras_block.ras_fini(adev, NULL);
+		adev->mmhub.ras->ras_block.ras_fini(adev, adev->mmhub.ras_if);
 
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_fini)
-		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, NULL);
+		adev->gmc.xgmi.ras->ras_block.ras_fini(adev, adev->gmc.xgmi.ras_if);
 
 	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_fini)
-		adev->hdp.ras->ras_block.ras_fini(adev, NULL);
+		adev->hdp.ras->ras_block.ras_fini(adev, adev->hdp.ras_if);
 }
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 0f224e21cd55..5595f903c17a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -27,6 +27,6 @@
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
-	    adev->hdp.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->hdp.ras_if);
+	    ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
index 6dfcedcc37fd..e7c3b8fff868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -27,6 +27,6 @@
 void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB) &&
-			adev->mmhub.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->mmhub.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 0de2fdf31eed..54a5a15272c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -47,6 +47,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 void amdgpu_nbio_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF) &&
-			adev->nbio.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->nbio.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 863035a94bd8..1df8de84386d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -114,8 +114,8 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 void amdgpu_sdma_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA) &&
-			adev->sdma.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->sdma.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
 
 int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 41e976733c57..2623a2d30703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -165,8 +165,8 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC) &&
-			adev->umc.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->umc.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
 
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 27421811f2f0..7d18c5d22e10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -746,8 +746,8 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__XGMI_WAFL) &&
-			adev->gmc.xgmi.ras_if)
-		amdgpu_ras_block_late_fini(adev, adev->gmc.xgmi.ras_if);
+			ras_block)
+		amdgpu_ras_block_late_fini(adev, ras_block);
 }
 
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 3ecb238c6483..e8446967a4d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2433,7 +2433,7 @@ static int gfx_v9_0_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_fini)
-		adev->gfx.ras->ras_block.ras_fini(adev, NULL);
+		adev->gfx.ras->ras_block.ras_fini(adev, adev->gfx.ras_if);
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d0a9012e53d7..222d25a0413a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1997,7 +1997,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 
 	if (adev->sdma.ras && adev->sdma.ras->ras_block.hw_ops &&
 		adev->sdma.ras->ras_block.ras_fini)
-		adev->sdma.ras->ras_block.ras_fini(adev, NULL);
+		adev->sdma.ras->ras_block.ras_fini(adev, adev->sdma.ras_if);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 34cd5cad7da5..0631ebd39db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1215,7 +1215,7 @@ static int soc15_common_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_fini)
-		adev->nbio.ras->ras_block.ras_fini(adev, NULL);
+		adev->nbio.ras->ras_block.ras_fini(adev, adev->nbio.ras_if);
 
 	if (adev->df.funcs &&
 	    adev->df.funcs->sw_fini)
-- 
2.25.1

