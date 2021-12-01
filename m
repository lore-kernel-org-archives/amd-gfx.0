Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EC1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5026EC23;
	Wed,  1 Dec 2021 10:53:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88CE66EC23
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCrEBAqX1IdwHPaZt2n/+ga3NvfiW3ZVprv3QIEg0+6lsPtYpqiFG1Y8DvGcz5UZtbEbnLGM/lyOBdTplOImUkZEgpZJaH+9XmExotcttptZmhHkurlt0U52ejghAnM3upKsfBbANF3S0lUHIhfXpO9yi+x/AP1mD1vPnJbERannGhCbVXgv+9XkPh3R1Zx+6GemmdrRNnOHcLaPIq8tExAxGxOlnHsfpnmbJ1IQs+2Gbg326tKDuy4ufe4HGHKST9K571p1afYNCBv/tY9z9mJAx2E1CMqzBfGCDrTXusruhOV59DcA6ah8LuXNAj3CIXGIPuA2rVRQbUWJTl8Mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7e/7OG9BQh/DgevvXaYo06QbWISy0nPDS0JteIFLpA=;
 b=QGS+DYF2CaeHQmTdg0rAaDNrVLO0zCH+umIjosbYtfF5DkT6oBjp4OxoHU/p0U/VtMwRQASwkozkRfIFIQSgd6GZzKA615n2D4Bsax8usM5fK8voSLi4drYW44MJ2UfoxrgvdgBW0HsQsREKNQO5/s6BXSn9J/Z299nyXGaS6eR8iHqUNrgG7l+zXlxLdPp3YeXcYlVAvN+I0/xS4jn/9l7mvYkwx1tlXeT66IPN2SJoDamkNJF6dad9+wswUWR3XP6fYfOJn7U8stcd+oBn+UcNeUwzB8k8aVA2rYu/ycgl5tkHkf3+bodYLGz7pwK452N06yL6GrryPN/qH4jWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7e/7OG9BQh/DgevvXaYo06QbWISy0nPDS0JteIFLpA=;
 b=2VuZKNGPbaktJF4ayjx+nmN1Xuo9xKyOesfU5i7uxDTb89cCY0I6U+X/JasSXFPEl704R6rimq+0UiLKChNXI1gAJxbei7KM2UaSfHnDq7VgaeUS/yKtmdPhWhjuuOan8IxD/36IMHA6e6UTc9NtnI1OTyWHZ9IG9r0AHSTxshQ=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by CY4PR12MB1288.namprd12.prod.outlook.com (2603:10b6:903:3d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 10:53:36 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::bb) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Wed, 1 Dec 2021 10:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 1 Dec 2021 10:53:36 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 04:53:34 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed problem
 when other ras blocks' .h include amdgpu_ras.h
Date: Wed, 1 Dec 2021 18:52:41 +0800
Message-ID: <20211201105250.298525-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201105250.298525-1-YiPeng.Chai@amd.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 425bad19-3cee-410c-7468-08d9b4b8d358
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1288761E8CC096A310A7ED53FC689@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKKhTyBfnn2Jv9W2a9BDMJPY2jUaPFFy/+llm69Rdm779WoE1I/rxvCWZTCfckYQBT/Kda5Lw5ugHymKuWEqmJKAtWMxCoxTfxejK5d5w4PQ/eWTVrCfdjf6v/FUlB69Q81vgxsSwa2ZFrIcLqMpxTNAI8Th7oygc7/NlLvEiGlziUMjChpmevy7L9qSw6DDpKIXn0QIdCi28zp1NiYSCFp3ABpAVdFzg0G47lXDKNemaxolr0iTE635ayycQwL/0MpD/BtNv/Ab8Iq3yVIZROXk+tdLYRQnPrhLzgFuPcWzW8JcxZV1UOVi9N5SNQIW99IVPFMDiPXxjJJIN4pVStNe3WeGEex1Bq+TiN+ubzfwadBr7GxA4NDiY0pRiX8/qWlvrqNdxsy6cLbSeH39jiZoAlSEQoeuSH3mxG62w6MGROY6e9nX1SxNyuN6umdTFw93rd0VmxbZE7OXQ8rzQEZk9m3bAImCFUAde0UVoIdstKgQ6Q1FM2O9q2DmvggyvrGRtO0/Lad/Za8Ek1YOHIdLuJG22M+TgWDEU2UBmHoPOtS3if5yPq8v8fCbOgU8hdtjbD8NQY16Ow/94+TaAuXCOU3YpLXxTUjYBgJuD3hxtQSftyJACsTJJMmKbuPHvYgWeA7bhLpDy1bl84MofOIGQufQ4JcXqXMOKRMR77Wj7LDpdpJv1u3ElrQi0amoFZH8KgGlPRnHMcpSy77OjeETSiQgheQ2fALvxA2xCn1zG/WoI0rJFQ8hYxNafCtGoaeVt/L5dK1Uw7I3flxjcktYAenbeZU/mRtU7pkPCIWkEmCIrMXKX3RHdki73sIPdyz14CjqAMmuSxXlKDedcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(186003)(16526019)(2616005)(426003)(336012)(316002)(81166007)(6666004)(8936002)(70586007)(40460700001)(47076005)(6916009)(26005)(508600001)(54906003)(1076003)(36756003)(36860700001)(86362001)(2906002)(356005)(8676002)(83380400001)(4326008)(70206006)(5660300002)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 10:53:36.1938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425bad19-3cee-410c-7468-08d9b4b8d358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, yipechai <YiPeng.Chai@amd.com>,
 yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modify the compilation failed problem when other ras blocks' .h include amdgpu_ras.h.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 23 ++++-------------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8713575c7cf1..1cf1f6331db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2739,6 +2739,28 @@ static void amdgpu_register_bad_pages_mca_notifier(void)
         }
 }
 #endif
+
+/* check if ras is supported on block, say, sdma, gfx */
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,
+		unsigned int block)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (block >= AMDGPU_RAS_BLOCK_COUNT)
+		return 0;
+	return ras && (adev->ras_enabled & (1 << block));
+}
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
+		schedule_work(&ras->recovery_work);
+	return 0;
+}
+
+
 /* Rigister each ip ras block into amdgpu ras */
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 		struct amdgpu_ras_block_object* ras_block_obj)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index d6e5e3c862bd..41623a649fa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -514,16 +514,6 @@ struct amdgpu_ras_block_ops {
 #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
 #define amdgpu_ras_set_context(adev, ras_con)	((adev)->psp.ras_context.ras = (ras_con))
 
-/* check if ras is supported on block, say, sdma, gfx */
-static inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
-		unsigned int block)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (block >= AMDGPU_RAS_BLOCK_COUNT)
-		return 0;
-	return ras && (adev->ras_enabled & (1 << block));
-}
 
 int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
 
@@ -540,15 +530,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 
 int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
 
-static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
-
-	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		schedule_work(&ras->recovery_work);
-	return 0;
-}
-
 static inline enum ta_ras_block
 amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 	switch (block) {
@@ -680,5 +661,9 @@ const char *get_ras_block_str(struct ras_common_if *ras_block);
 
 bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
 
+int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int block);
+
+int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
+
 int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct amdgpu_ras_block_object* ras_block_obj);
 #endif
-- 
2.25.1

