Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BEFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 08:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04E310E6C7;
	Wed, 16 Feb 2022 08:09:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1571610E6BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 08:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT4fPY+p6PVb3LvCusll+ZlpaeeTSyO+ceRhdyAw4mYQGOUqMXzl2YmyIK91QHv+AUATlA6StRhLo0mAIExvmfZ4yyQxS3q7r06zKd3vF8qwj81139mbaIGEQvrJIie0FFwUTWtYUzRYCVAZtwktXBMFqrRoNxjyUYHKxn0nmsQt00/vwnwe9zvhBdWrCGB/ZYMNBuD9akxutL9LaibyVYx5Y4EEbsr0mqWkSlCz4zShKgSKlsgIC5nXHlqVS6UOOaIQgFqVG0KNAgblEzvicK5YAG/pqp+HB/uxxLRy1RPWDSqs9JwOJIdFTtqGAC9ACoJ8P17B7HkM8AKIMJoOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuXKJXjlwTEUPDmwfVWglG8m5c/5mzNiKIiocosVrvY=;
 b=cskN1kJwukbJXOX2+9uFFaSqJBq2N65Uu0wpIRy/hzdcc2WFUtR37qzNlx40r0Fev+Nf4rp05gG6mTkwwHoXUfMr8PMa9/gZHgL/eiUgd+RW35pbQYIkT9tiYFS8Z3ByV6anw6YqShZDm7CVwhNIkZO939yHDvhm9exCeceVncXp63+Nj40cohQnUNMtPeWmajK2M1yY/zwflPSnwNDoJ3E/b5c6MB386PYA10w+CEGGpnclubfh3nt3sEDJ6fJxhSnqvUoET0sVaSFROcIUN1UEMx+VmoyTXgkRH0DzjsATFsz5VClnKbf49xfg/ByEYGzshHxgMa3AK3jJr5Y7HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuXKJXjlwTEUPDmwfVWglG8m5c/5mzNiKIiocosVrvY=;
 b=JKXfHxUf3/14DIRKSheS2pSy8MdnPuFPeBOw9HlVUYLeBDnemLVPxt+B5JO/TXyIrIz4N2vpBWhLdkcXkyw0e8dy8o1wgfzCgFthaUv8dwspsMlFioZSI0c7TynZCSUHP+1pfy22zzRLMx6ApXSrQILkt6LzE9MiVek9DcdaA/o=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by MWHPR1201MB2556.namprd12.prod.outlook.com (2603:10b6:300:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 08:09:10 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::73) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Wed, 16 Feb 2022 08:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 08:09:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 02:09:06 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 5/7] drm/amdgpu: Optimize xxx_ras_late_init function of
 each ras block
Date: Wed, 16 Feb 2022 16:08:02 +0800
Message-ID: <20220216080804.3560484-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
References: <20220216080804.3560484-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af35979-2a05-4fc4-e312-08d9f1239cb4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2556:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25563ABDFDB2A6D47C617D33FC359@MWHPR1201MB2556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:226;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCZYwC4SunYJQywO0AahZ5l9HHaCVoaPyDi1kQUqSCRphQeMGULw8x9xinZJPzm33IMh6QKsb9jhFmLQtVuIF9Cf5ItZW3eNSRI7SMzuQHHwCiIxgjkjhZ4d3CHcNONTS+TInXh99pVRY11fz2rvVEZ8dLNvA3I6dVbBNB85uXUMY0vuXC6XbPFo9I7vqB4fT6KaBHWb58ydo/Mad8CxiwSdmI8q1ZwHDHIcpig5Y4sJjPgGyQrrRIJ1bFBKg86jBYpZ78IhirBOQRXbBAkC+64AFoKYi1X7A295dBOBGZZFNrcElG9PtuMm26wzWhE0sSL8cHLV2OwbGDsQEkG/mlsf/a2GaTmpT3OdVirnU/+jIf6PzRRWu1/ilMvpZOlC5e5uphJ7zAybE2BnPRSgRF+SMBVKEg+vcd4U+73U5tXQH0ph1J9SCdlf+fN2fHTRF1lq6LY2I2ygE0NjCK+sdJ8G6If/+ZFQNUCTf5YQxAu4UEhITF2bCndXiSXycbo6QHPk05uxfxFSbtBfJaJYooEfEzlx81lmywRhBuVOuHUk56/DvZ87SP3u7SXgtFaUVS7WxMEafN+DnlA5Bf3p+M/iyKijsNOIq5AtkNldH/mZzEgcKzNdd/agzHlK8eTXW+HL+CKF7I93PLU0jlqtPI0aH/fSIZ+Va2oOMP/URk5RXMH3nsAupnv+0oCgprzG/PRfljtylHgoaNxgJh2py998E+UAfuI5J+xluYe5P+La82qhAdbb2Baj1I9l4QakASA4ikkn7qq4W+lgCyMONg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(8676002)(82310400004)(4326008)(356005)(7696005)(8936002)(2906002)(16526019)(26005)(6666004)(186003)(86362001)(81166007)(1076003)(83380400001)(2616005)(47076005)(316002)(36756003)(36860700001)(336012)(426003)(508600001)(6916009)(40460700003)(5660300002)(54906003)(43062005)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 08:09:10.3010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af35979-2a05-4fc4-e312-08d9f1239cb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2556
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

