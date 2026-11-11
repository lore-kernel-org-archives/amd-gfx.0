Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A8606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BKYFd1n7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA9010F8F6;
	Wed, 11 Nov 2026 01:45:04 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C39510F8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo2hyXhSUMUup0Uw/YXGL2F+b5NH8VN51K1zPtL+GV3FasvrJSPOw82ZJEGxNVfvHKPtD+UlseoZ/iOh5yNeLf+GHxsC+AbyXHK+EimmmXHFe363ACRBAScF27YMrc63Xog22DyLrSmvNevXN+w8g2czEAFuFEZ7Fi2KSpF1xPvkb9O8E9TtaJ5JYo2iSO5EpfCgk/QD/BIptAip7IxOaUFzhhiOn58DTJIb0jRnYw08zg1SWCpIbL2WaXUoV+hz7xYAgwlDcXaxQEHfckzrTZnLy3934Wap8xoJsgCIJKKFiFhBhxZ3zZhWojUUIaGQBnbLmb+Pmx68IoCE/LKv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT6woF1xvf0IbMVxdPXeTa38eM31EUsFe0+RLw6MMho=;
 b=bVCeMbyeq4DQ+9c3IVtah0wZPG2jzt7Qo8rhZ7RoKt/X4bO0Ps9xeRb/Jx1sRKQWTf9pShrHQlZVpqtgmET/uRq+iCZY65F/uFOJGfh8w0trvP5L199sxnwpKfxIVRjWFT6nXA1jzXYYC4dzjaOR9EVgcPUcO32wxhl9q4ulyM+1Iodb83dKcakcNhvQzvyh4DPD5zZ/8AYwH4bhPocwhU31Y8JpC0SkrKK3s1zigtj259nmRYfhn2olS3vX7KT+Z1JVo83y7xDd9htGjUVAwfX2h2x5gaxRvudaMNovqS9ybU/wJMyhRp0CHC2VO8B8LBvE4qpBaAYcxa+QSKoBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT6woF1xvf0IbMVxdPXeTa38eM31EUsFe0+RLw6MMho=;
 b=BKYFd1n7g4owvEH3rsIfzu7tvd7hlX+HoooHfmIUdrwKAhpBMQAOlBdyt2dBeO/RIAW5RNuMRKMPnX3rII+RUvS7liE1+Y2EOyJtGvYYYaBpCe2OKI6Ezd9NRPskJcgzneBRqBy+LC8VZCyDkgJjVKG0PovaaQUTOS2jiZ347fI=
Received: from MW4PR04CA0156.namprd04.prod.outlook.com (2603:10b6:303:85::11)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Wed, 11 Nov
 2026 01:44:52 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::4e) by MW4PR04CA0156.outlook.office365.com
 (2603:10b6:303:85::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:50 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:42 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 63/74] drm/amd/display: Expect VRAM|GTT for the DMUB
 framebuffer
Date: Wed, 11 Nov 2026 09:29:09 +0800
Message-ID: <20261111014100.3596072-64-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0729f13f-49b8-48c9-b91c-08df3f95610b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261028144727099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261026140227099003|261022105027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 15Osk04TzpQESmrXsh9sK7LC86vkEvV6csApnDYyBUKRy+cPl2bDyOaaCWmnEajDse5PP4rjH0QVxZTfBRwvKq0Ri8FFwfylLxQg9qEPfBHUZy2Pzf+WIOR6+TdNVvPKcPocgxeo1ZtY0lW5ZfrtFz0rFfh4T4IdSpVcGFqYPRhmfYwTEqyLa+Sq8eDhyQAEe6ObnAkztxbKWNq/707mSi4oNZ17H5TKViW48uDrFr0SAEHxw3oYbfZ2EdmLGR1YF+czpW2FDfwC2rCXHl4vOs3+sa+pRBdKIcO/QphhapZBv2YW42CXbKSWXGY8ZNMIpZvLQJFWZ5eUHto88ji/+FDju43lmJkXfutKZehD8799uS0DnY0af9LSZj1cLIZOj5xtiVZDtkW9K/LUf/835/2jA+MCJ0Je28eHzKEk82ayDK3T/d6rE0yIlhWSW9jucs6NOwIp2MCxBC/M1mpMJ6X7R9fD1H/bDahWgwe3mQEuHr7DpfJtiq7rhktrK3ZFPx21DtPOobdG4nPNo7T7iopOvtkLNa/X/MrvSieEeh3lX63SUt+0QKjR/5w68ObuZ5luF4gZQwWPnle9l6KZwYTfO50wkw/d8lkhis2fVpmP5vnw+KKsoXQt+8mcnDaE8/11/jwBQoulz3TzCqZJNTUD2kGwyGqruy+Z92GI2ROtsQuf6W1hvK5i3MyE3XffECTztqboS9EiX7GyGZZj5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MxxJIp50zKXq92/FcSocd7za2K3vWKV2v/zll0LLVutYZtPC5yCXi83iAMXjguxHTD9PYw4K62BveAb+Y9pWq8y8SZd2EI4LoIZNYk0cNq1lqBq9LYSV/RUshOK3fExKyEtPdUK2qV5WdMLu0CUKwhFMphlONpVg+vElGdsDLSzNiBZ253igb2vuy5cABGc+4AlXBtuwXkDEmzMElVffJoNxBegc8/1+L7TFEaJIrfVNAvCwfGaWOUcVg1r09AmWxZlKYN1WrJRnqkrFoQ6aGq6QV7ssf6kwqvVjudeSWfgSjSfS3/ciNzV3JAVQuZD83iXu4sZwQ/p2EeOzQhVmkdPwHQA/K2nDk+xj5A+Q+AMr12chYMuBMvcA9ZoPMEFXW0J4ju6rD5bnNGIap9PpY82p5Xzt8NCyaoSsTeLiTCXs3z+vsXMoI/U6DijfYmQN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:51.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0729f13f-49b8-48c9-b91c-08df3f95610b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DCN32 GTT-only framebuffer allocation was reverted, so
dm_dmub_sw_init() passes VRAM and GTT for every ASIC. The KUnit
case still required GTT alone and failed with domain 0x6.

Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c  | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index b48c96ec4250..595a7dcb57ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1816,13 +1816,14 @@ static void dm_test_dmub_sw_init_asic_mapping(struct kunit *test)
 }
 
 /**
- * dm_test_dmub_sw_init_gtt_only_asic - Test the GTT-only memory domain
+ * dm_test_dmub_sw_init_framebuffer_domain - Test the framebuffer memory domain
  * @test: The KUnit test context
  *
- * DCN32 and DCN321 keep the DMUB framebuffer in GTT; every other ASIC also
- * allows VRAM.
+ * dm_dmub_sw_init() allows both VRAM and GTT for every ASIC, including
+ * DCN32. The allocation is forced to fail so the test records the domain
+ * and stops.
  */
-static void dm_test_dmub_sw_init_gtt_only_asic(struct kunit *test)
+static void dm_test_dmub_sw_init_framebuffer_domain(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
 
@@ -1830,7 +1831,8 @@ static void dm_test_dmub_sw_init_gtt_only_asic(struct kunit *test)
 	dm_test_bo.create_ret = -ENOMEM;
 
 	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), -ENOMEM);
-	KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain, (u32)AMDGPU_GEM_DOMAIN_GTT);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain,
+			(u32)(AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM));
 
 	dm_test_free_sw_init(adev);
 
@@ -2000,7 +2002,7 @@ static struct kunit_case amdgpu_dm_dmub_hw_access_tests[] = {
 	KUNIT_CASE(dm_test_init_microcode_request_fails),
 	/* dm_dmub_sw_init() */
 	KUNIT_CASE(dm_test_dmub_sw_init_asic_mapping),
-	KUNIT_CASE(dm_test_dmub_sw_init_gtt_only_asic),
+	KUNIT_CASE(dm_test_dmub_sw_init_framebuffer_domain),
 	KUNIT_CASE(dm_test_dmub_sw_init_success),
 	KUNIT_CASE(dm_test_dmub_sw_init_bss_data),
 	KUNIT_CASE(dm_test_dmub_sw_init_psp_load),
-- 
2.43.0

