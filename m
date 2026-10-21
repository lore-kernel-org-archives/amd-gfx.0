Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E69A606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hCHSgltY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181F710F97B;
	Wed, 21 Oct 2026 06:30:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E222E10F976
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p89GCVbHUM4atPbyIQVdn77LlNnuEDk5mIZhcINYiERxO3uP9tbRzLl2gZ2eoLQYAPR4glY2Q72RUaiTujp65bWIdCIfo0Nfjz98F4eBMT0na4A1Fz0m8m4PVpn8coDaNfkgHHkF7BcMNMdoKs4OXBVlPNlCA1KBcqFZjHlO9HKz10Q6MeQzz56X/bz6ZpdphghXO1ZGnRX3Z6bG/kJnI8tZgrtMqxCHYLLmImFBHWVmRyZiEjQN0Z+mxhhRrOe2iJCw8ew/VBHqitN8MKXSPfMXeYXkVKT63JTXuzNDTqChvIgYmN4Ur77m1aE0UrghJ2tli2EKpcbiaHDABNO9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19v+WTz9Y212AsvHi5RL34Lo33SazZBdYdPbjBMBYxY=;
 b=IUKLrTo9Rl6JyszquvEWn6l/G7F42i/MEDgPl5ZEImCtmNk8QSzmSrtTK8ThAuiePPcm5fXoHgTo4qO02iwwlB65paQev8JVFWGgibOoc7lr6rFrEox8VzhtsHaR8kYoIzTQ62vJc0zreSsHzJ6qsN0MnGkNp7meHEnr8I8cHPW0h9pu9Cyvv+09cKGNJSpdyCW32gds/1/qeFhwRCpDHoOZ/QH5ofu/lhPYkMwhfopv9J7hBZLPckHIlUHFStLA/ItEqjpt3VYO2WankQ+2DTUoYgzYVhm4H5FLlWavnnm3LnciLzShjnGF6RizLmBtWLAdLMqep9OfOOdrn/+PWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19v+WTz9Y212AsvHi5RL34Lo33SazZBdYdPbjBMBYxY=;
 b=hCHSgltYrMl+S9Aer7zw6DTDKttfX4OA3Tz6DVc9Tfahx8YtxB/7QHPuwL0d5VqWYzc112djR3ymw/JnRJ8J779KYVT4U2UVbPztEnYnQGIKUVGu1UYdadtLGJjwtj7K6W2ALfq48QixY0ZbG7ExrFpcJHpacr7s+Zx6g/t/GmQ=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:27:57 +0000
Received: from BN1PEPF00018547.namprd05.prod.outlook.com
 (2603:10b6:408:112:cafe::91) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018547.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:56 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 41/49] drm/amd/display: Use kunit_kcalloc for arrays
Date: Wed, 21 Oct 2026 14:22:47 +0800
Message-ID: <20261021062519.674697-42-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018547:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: c9577f7c-bcd5-4ed6-e06c-08df2f3c7238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oE9+TFvMss/Lcv1EHIL59yupHOto1UdjVglChaY0vSkhOe6T3IHxUsxrLBU6pIx9EthcskQXn1V5ARqcxzAusCmdSVMT6uQWVcOIJT6+qwIHBZy72itQw7aL7eSh1u8zD4fPggHosYMVWfGNBlHm6hrbYaaOWrSb13g11qvdP64HkQ5SivjSaH7Gl3Cv1csLCkH5ac+2uDfCYn2b+ZeCMYhCzQBcH0xIbASgluQ50RqlsOUL9T1GwehZ8zWYx0BhSb7K7z/DCjs0w2w1vWkgcQeFCLxVkVJeHRe9F5/F+gHmwf+q8koqK9kcAzPlUBmQvMivCaVaoxcfKsSOz4Jlyg3YmbQgmI5HQIIt3ujsYZN9IXYY9lXXlH+vHbzGTsvajKzf3HnzFzx2T/zlQUMBFNwe8sB6iiECxPiGYOKhNhtEgO13/hTIY6n+sNy7O9RqFvPJqhjlIJTXCOjEFpHluBmgAbejQppj5XMsQ2mYwzsGzYzoek119ZbIRUaP1kIWdIynYKPzMfjaq78Dr+Fh4SHW2bThtie3naJqm4xUE4mtRYOzLD51Tf0vGV7HLmrbpXdSZksaVPyObuxtol4qqgdZB6POeUPivqM2IYcA5R2keyn8JyfKcEFpqYkO+eT+4K3sekyS0r6Y5hL2peYafYEU/IxtK6i4QZ8zfIKA86Rc30h2pvUkHbwSNakrHCk+/wsXZvP3gjblCVyIfSEx5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yqdXpRdiJAJefp3vUsQiOdGVErayKYx0tlwsEUe7Yz6HBjGN7RQ/NTGBVDEy/h74BaXxDyhVTViRxVRaw7w4vodmVE1TkloA14CE3s7YEUUOnBJGJ27vtn6FcXqNlt62o3UX2bC5rv/48hmMFx2KSpLy35G+lHQ4GZssuVvp8Zqd1CyPqUZPu3Vedgt6Itz0D7H6yv9+NLDMGKFijDCpSfmIjuEq59qY4Jm4Reys3dXcyQro8WwBif/IUQfyLOk7gRMYYwxdEmSWUNbnHDHjAKEreLExyl31W37+oTESPMvbcwuAhDiLdmiJo9v3YuAwnZ3uAb4n0n0JbN/pdoEqMFSilrIF6jD2h9LQMuF5wl4wZ5msDy4pEsOxIzFJp9va1Y8o+9k0DqZnh7fCRUMxSxmVxfuyX8Nsw31R2csxIyUDhZGZtuikABauACK5gE8r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:57.0344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9577f7c-bcd5-4ed6-e06c-08df2f3c7238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018547.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Several crtc and irq KUnit tests open-code array sizes as
sizeof(*x) * N in kunit_kzalloc().

[HOW]
Switch them to kunit_kcalloc(), which checks the size multiplication
for overflow.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c | 8 +++-----
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c  | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
index 3fdff1cab243..3ea252ed1259 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
@@ -525,8 +525,7 @@ static void dm_test_crtc_set_vupdate_irq_enable(struct kunit *test)
 	/*
 	 * Populate the per-source info table so amdgpu_dm_irq_set() succeeds.
 	 */
-	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
-			     GFP_KERNEL);
+	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_vupdate_irq_src_funcs;
@@ -1060,8 +1059,7 @@ static void dm_test_crtc_enable_vblank_vupdate_busy(struct kunit *test)
 	/*
 	 * Per-source .set fails so amdgpu_dm_irq_set() reports the source busy.
 	 */
-	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
-			     GFP_KERNEL);
+	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_vupdate_irq_src_busy_funcs;
@@ -1480,7 +1478,7 @@ static void dm_test_count_crtc_active_planes_mixed(struct kunit *test)
 	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 	state->dev = dev;
-	state->planes = kunit_kzalloc(test, sizeof(*state->planes) * 5, GFP_KERNEL);
+	state->planes = kunit_kcalloc(test, 5, sizeof(*state->planes), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state->planes);
 	state->planes[0].new_state = NULL;
 	state->planes[1].new_state = ps_fb;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 18a2409c5a69..f15eb14f64bf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -436,8 +436,7 @@ static struct dc *dm_test_alloc_dc_with_irq_service(struct kunit *test,
 	 * Populate the per-source info table so amdgpu_dm_irq_set()/_ack()
 	 * succeed without touching hardware registers.
 	 */
-	info = kunit_kzalloc(test, sizeof(*info) * DAL_IRQ_SOURCES_NUMBER,
-			     GFP_KERNEL);
+	info = kunit_kcalloc(test, DAL_IRQ_SOURCES_NUMBER, sizeof(*info), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, info);
 	for (i = 0; i < DAL_IRQ_SOURCES_NUMBER; i++)
 		info[i].funcs = &dm_test_irq_src_funcs;
-- 
2.43.0

