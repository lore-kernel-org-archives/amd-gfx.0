Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242C3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B4A10E3C7;
	Tue, 15 Feb 2022 07:42:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C5B10E3C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epca5y7eaU69jHUC4xKTsRhpiENKhAvkpdPCfBpRb97u5ApE2J2K9J7UjLWcP+SzMIHfCVb0eukgvYvePBRvl8lj3/84rUx3LogYL6EDmoBySnoG3hKEnBeL75r+g+6ho1Me05s3oQv5ItyRid9Ot2U+XETS7b73W4kUZ2kG2o2F3ta5uyaGNNXacw7NFVLF3HjPiIptFkmNkpiXrZ9UjF0VNmWJOnMdGG49wApXgFT4x2slxCfwZl9h+ILfb3A+HxaoFoJWtQIarbkm7Nw2CbRJ1zBpiaGV+5/QSGHtjenXuFElCxILY1mtSzzLWL7Z5d+osHx/MtPkqdxCjmfkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuXKJXjlwTEUPDmwfVWglG8m5c/5mzNiKIiocosVrvY=;
 b=DH3ePYoTLNMdZbmRlezFb5Lrw85mXNYLfevxj03BBpW0pTHlFNeNv4VVK6+3T/Urf6kX1rwdRt0bokJj22CkNgv9V8d3Xk+ZSrkqevZJu/SEzHDwEQEj8HpG6S6qjHZ3crSrWXojHOJIX51zFdGRrqY4LAYrsKWTEFqEpshOd1VyfSr+YrSIBRJtmzVSa86Kg2irrxojZceL/9L8o83sM4mGw/CBj0/nPoATHbVBnhYf/huYYEKsA7RSQdMIcchYxfmM+Y4Jvag7sDZqUDe0zFgx8uHvAYDo6B8DQF5cjcExO2QDpR9rUJpdZovnnYKeTGigGne8ujIKgOQtNMo83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuXKJXjlwTEUPDmwfVWglG8m5c/5mzNiKIiocosVrvY=;
 b=eegdgK7Erkq+s/oZknKZixlcH5ecrxljMIU1dov9h0DdflF8n5SokueNHqOLVQl/bFpJUuu7TVVDccF/0f6nRpDYmeQq4t7UHbWbM3EfH99iWhA8xXh4ZCO/dnDv+HJ3MT2EhL16uLmSU952eBz2Zm5rykvVkQ6nA+UoaWqxWxs=
Received: from DS7PR03CA0176.namprd03.prod.outlook.com (2603:10b6:5:3b2::31)
 by BN7PR12MB2804.namprd12.prod.outlook.com (2603:10b6:408:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 07:42:16 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::68) by DS7PR03CA0176.outlook.office365.com
 (2603:10b6:5:3b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:16 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:13 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: Optimize xxx_ras_late_init function of each
 ras block
Date: Tue, 15 Feb 2022 15:41:22 +0800
Message-ID: <20220215074124.3411761-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 417a555a-ade1-40c5-b65b-08d9f056b02d
X-MS-TrafficTypeDiagnostic: BN7PR12MB2804:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB28049F48D2AF85956368F8E6FC349@BN7PR12MB2804.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQLLwYDKO26oF+kKkS8I7uXK2x3quQMqBQw5wDzEkC3Bz9tOfvfz7ZvUeTgjKPbekEEm7n6TaA+YqNvcCoSETZnWqWhPjsnloI50e8iSg9b3eS+GXDzDCBVeClaGKUB2FsnRvYSLIcqeRiUUKpgHLwhJcCEm6G6QzPnn76+u/2bkKMzUPCuxVH8tgbJW2k24QiYUMVQRr2ikaYSGyEUXTmtMakn0X336o59wrRbJkGB9kTz5PCcGVCoddNA8r6ItuHnrooUs0kEm8TjRdLGKdzQOMQndTDPlrSh7rL+NCnPWx7xM2PsRwsU0A4huyWRFmSJh57p8dxcVYbwgeB/6FLLNLt7Uwx9kM0NQ5o07akun7G0az7DEq0QNutLdL2Celsq759jA6/ufVhC8U18uAx6Lbhn1268vZcxYDk1VsLaocbYUI1j1fAHYDXCd4MpJMNc9Ags3ZvWlkQaHKnEXe5Vhy8Tx3jw6b3FeWJOU2PfVBZshyfaa8SigqoriEsCZ51w6c6OH+u5T2gri6EFpaZDZp/NEQ9l08LRHf1ZJFNz4g2RvUx7rpOaAv9kBxkbxzGOOSEKqfqypctgccoZp3exW1gWhcENNBkv6EPAHMYV28pQcwGQuyBTy0cvLldfMcTNnXar7LiM8eFAxus1500S/ZtpqHwzUmvrv6Qn6yobrnoSzsLErpD4JAEfHS2VdmqxHb3/oKkefmILwVLU7CN2ixBN6ycLfz5wp35eeaEAlAmJlR1WOpmbVnlf0/T3r3uvrvkoNWns+ftfNftZ9HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(86362001)(2906002)(8676002)(8936002)(7696005)(5660300002)(6666004)(83380400001)(47076005)(40460700003)(54906003)(508600001)(36860700001)(356005)(6916009)(81166007)(4326008)(36756003)(316002)(70586007)(70206006)(26005)(16526019)(426003)(186003)(1076003)(336012)(2616005)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:16.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a555a-ade1-40c5-b65b-08d9f056b02d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2804
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

1. Move calling ras block instance members from module internal
   function to the top calling xxx_ras_late_init.
2. Module internal function calls can only use parameter variables
   of xxx_ras_late_init instead of ras block instance members.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b7470ed7bc25..52912b6bcb20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -625,11 +625,11 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
-	r = amdgpu_ras_block_late_init(adev, adev->gfx.ras_if);
+	r = amdgpu_ras_block_late_init(adev, ras_block);
 	if (r)
 		return r;
 
-	if (amdgpu_ras_is_supported(adev, adev->gfx.ras_if->block)) {
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		if (!amdgpu_persistent_edc_harvesting_supported(adev))
 			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
 
@@ -640,7 +640,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_late_fini(adev, adev->gfx.ras_if);
+	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d42e05572db5..ebf4194b0699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -452,7 +452,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	int r;
 
 	if (adev->umc.ras && adev->umc.ras->ras_block.ras_late_init) {
-		r = adev->umc.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->umc.ras->ras_block.ras_late_init(adev, adev->umc.ras_if);
 		if (r)
 			return r;
 	}
@@ -464,7 +464,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->gmc.xgmi.ras && adev->gmc.xgmi.ras->ras_block.ras_late_init) {
-		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->gmc.xgmi.ras->ras_block.ras_late_init(adev, adev->gmc.xgmi.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index 92fd4ffa7779..f09ad80f0772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -25,11 +25,11 @@
 int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
 {
 	int r;
-	r = amdgpu_ras_block_late_init(adev, adev->nbio.ras_if);
+	r = amdgpu_ras_block_late_init(adev, ras_block);
 	if (r)
 		return r;
 
-	if (amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		r = amdgpu_irq_get(adev, &adev->nbio.ras_controller_irq, 0);
 		if (r)
 			goto late_fini;
@@ -40,7 +40,7 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_late_fini(adev, adev->nbio.ras_if);
+	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 594454dba4c1..3b5c43575aa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -91,11 +91,11 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 {
 	int r, i;
 
-	r = amdgpu_ras_block_late_init(adev, adev->sdma.ras_if);
+	r = amdgpu_ras_block_late_init(adev, ras_block);
 	if (r)
 		return r;
 
-	if (amdgpu_ras_is_supported(adev, adev->sdma.ras_if->block)) {
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			r = amdgpu_irq_get(adev, &adev->sdma.ecc_irq,
 				AMDGPU_SDMA_IRQ_INSTANCE0 + i);
@@ -107,7 +107,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, adev->sdma.ras_if);
+	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 7abf9299e0d7..9400260e3263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -140,11 +140,11 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 {
 	int r;
 
-	r = amdgpu_ras_block_late_init(adev, adev->umc.ras_if);
+	r = amdgpu_ras_block_late_init(adev, ras_block);
 	if (r)
 		return r;
 
-	if (amdgpu_ras_is_supported(adev, adev->umc.ras_if->block)) {
+	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
 		r = amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
 		if (r)
 			goto late_fini;
@@ -158,7 +158,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, adev->umc.ras_if);
+	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 91f788f6f6b5..77b65434ccc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -740,7 +740,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 
 	adev->gmc.xgmi.ras->ras_block.hw_ops->reset_ras_error_count(adev);
 
-	return amdgpu_ras_block_late_init(adev, adev->gmc.xgmi.ras_if);
+	return amdgpu_ras_block_late_init(adev, ras_block);
 }
 
 static void amdgpu_xgmi_ras_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e57b90d5b50..bb40ab83fc22 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4792,7 +4792,7 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 		return r;
 
 	if (adev->gfx.ras && adev->gfx.ras->ras_block.ras_late_init) {
-		r = adev->gfx.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->gfx.ras->ras_block.ras_late_init(adev, adev->gfx.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 82f6b31a1904..af5a1c93861b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1895,7 +1895,7 @@ static int sdma_v4_0_late_init(void *handle)
 	}
 
 	if (adev->sdma.ras && adev->sdma.ras->ras_block.ras_late_init)
-		return adev->sdma.ras->ras_block.ras_late_init(adev, NULL);
+		return adev->sdma.ras->ras_block.ras_late_init(adev, adev->sdma.ras_if);
 	else
 		return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a0235f75dbcb..464d635a0487 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1192,7 +1192,7 @@ static int soc15_common_late_init(void *handle)
 		xgpu_ai_mailbox_get_irq(adev);
 
 	if (adev->nbio.ras && adev->nbio.ras->ras_block.ras_late_init)
-		r = adev->nbio.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->nbio.ras->ras_block.ras_late_init(adev, adev->nbio.ras_if);
 
 	return r;
 }
-- 
2.25.1

