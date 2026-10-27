Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B31606A320
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qZ1ooald
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F19310E419;
	Tue, 27 Oct 2026 13:38:10 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C05C710E419
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKe8IYRiBVs7QDXV9bzrtytyHlvUpG5XkhRWnox6ESOi0McCC2V+h6sQJxQn743mjozZJ4wVkTh2MhZmOqMZUNWERc79+h7SrS+GRb39a/hD5nuYOJkoSeyaZKp0PU7ziTlKl7vpi1G85vDbaDCiUenZFQh/tgNY3cKisTHOLVsjTU+aitqPZXhCQbAt+5D7nftjOwa8fsnZdl7eZfJCeF3TYtV34Iv2rNX3dyuAh8nt3W+wiMyWjy4c+CwyQydkziReiPDROLlb0l81A1Tz3IlYzlaELC2Q6nvnSlQu81eUbsgBZbWThOuFvvowpYIooBgr/a4cbPM561SvsLbhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtJu+QQrOVw4pY5ISwdWLrcLGeEln7UpX18q1tVNggk=;
 b=fQUEtltRzPjjRD/TaUqXh4pnt2+y+/tU2zvVsoxwKefgdakYdt/NopoQ7ctORIr3oUJa66FeqwcBRQa96tYHyKIQ0YQg+wJyvaupNgp9STnYnR3hooDDpvIzQVnLQN0qxPhsDasu/zT5bqzKsEPMhvzKICih5bw3xaQseqquanjHWp1RdlvtZMm/7nXyasbsDF5UcVTUhwUZUx6iV/An1qeI1zzuGhYZl5OVroKV2y8Bl4QF2GRybghl9ZkPS0uK8bUvRtNgKpdanf1nz/FrLqE4Qd5yYZnVUsXwfY4NaKq9ZKY03Zd6eBPdT0oPktobpZQFZGR3NJg7r7Gts6ne9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtJu+QQrOVw4pY5ISwdWLrcLGeEln7UpX18q1tVNggk=;
 b=qZ1ooaldKDuxV62+P+kmg80cWaNNOqRWm/LtJTXRRe763TQrb8wHfKFshr4MdaQYgfiXdPuRoO5cyt1ZBvL/1EB0r+iUMXxc6Scj/dFCoJtS677mv2mfhL4u4JUXVV0jCuAbb4/L78FK7+0FjiHUb+dMSEcBHE220QB5JIkW/+Q=
Received: from SJ0PR05CA0111.namprd05.prod.outlook.com (2603:10b6:a03:334::26)
 by LY0PR12MB842067.namprd12.prod.outlook.com (2603:10b6:404:215::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:38:00 +0000
Received: from BY1PEPF00026968.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::53) by SJ0PR05CA0111.outlook.office365.com
 (2603:10b6:a03:334::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.3 via Frontend Transport; Tue, 27
 Oct 2026 13:38:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026968.mail.protection.outlook.com (10.167.244.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:38:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 08:37:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 08:37:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 27 Oct 2026 08:37:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: avoid MMIO access when setting gfx MQD
 priority
Date: Tue, 27 Oct 2026 09:37:44 -0400
Message-ID: <20261027133744.4114143-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026968:EE_|LY0PR12MB842067:EE_
X-MS-Office365-Filtering-Correlation-Id: 1750f2d3-5f5f-4222-a748-08df342f848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261026135527099003|261026140227099003|261021121427099003|261026130827099003|56012099006|11063799006|261009223027099003|261021130227099003|261022105027099003|261021135927099003|261022075727099003|261022115727099003|261022113327099003|261021133027099003|261021123027099003|18002099003|261026121527099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Zg7niZnx7gFo//Icpj2JIqBCv/Bs/gAqxkFuoHnO6O4bUuxQUqiS0KRpq5/BrOvI+pCB78CSsyg4RzqJnMJ/rf0rYGzV8IWc9jg7xCh/RjgPNHmAstxz/bO6aPf2R351VbMffGdM7UbcbNm5mMMWpUQrTJAw6rmnSQVKi3NOryoeggglgOCqv2/S/SGcjufXrspSaOixPjOqX+XKntyrM+psu/9MVue5/Z7mKJdbiRqI3G/PMThBS/v0Os8Fnj1mCoJR8JgqtI9O4+1z35AdfE8ZwdrFUVvrJL8REGvUjQmwr65DjejcxweqUyGXIQuMoCLkrfl8CeNwqVJjkS0ZKeuOeKy6IXLXt3wJcHfKZWLTu0N1C28SQmwOjrHzgSfdYJAwc8Y/tqmtinkJQ5OuqKHlRXBXTT4IOvObPUi4scJwo9YuT0KEDfVPdEU+zB1HD0qwJg1VTI7Tn/hWRHVQkGOCDxMuZK3cMwU03Tjvh99dMNFvVX6hE2Zvoc6cUdWKe9sYXjG9PYQQac+xilALAcXzVbBehoPqQw7VgY66G0/uM6qMYN1TsNrBbAM9aZDkJTQ3bXlhqRTFy4MB1dFf4DwnsGbKk/JWOcG8SYyJUMg2DCL2cZbV9oV9xw/2LgIpdKbR01zLdQH7hN2rhtLTyubxZmn6/x7T2p0xNRWRta2EX7S9MPGySwDR0wvRobAdOspJhorjkpQPESulI6bZWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261026135527099003)(261026140227099003)(261021121427099003)(261026130827099003)(56012099006)(11063799006)(261009223027099003)(261021130227099003)(261022105027099003)(261021135927099003)(261022075727099003)(261022115727099003)(261022113327099003)(261021133027099003)(261021123027099003)(18002099003)(261026121527099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CYCGMkhDK9Viyo3r6CPhTbdBZhdtVEPVxaLZ9JTm3ry8tw53JSop+7VxCrKS55vfe34DttjSOYGIA17WL05INAK7nCa7942l1LCwCnic38aC/V5yRp533JFM/YyIicGTkp4EeLr0XCXWSH5QTRjGxbuUeBEnUng5YiG/P+JBVKgClfSk1OArqjvPuCgU02yTggFi83IZxuPlnh2MhgjPXgG+vDsbAt7HWsKl7btPMHp3JLf1nL6tZd1+HDNRWe4zfRxBzE184B9aD9OrkoP0OZHzrQ098GAotvqPl8NE2IGYo74u4O7l8hCDm/jfkH+o/yh57XnCBQlcS8cirzf+XnmKfGUzRvC1EfPTRFHQWQHuJ13to0/HispiOgMc4GBWnMOqt5AO1GO8264l9rq02I/byqe57HKN0tKsljKGMx72Q+0v9u5lv8OgFTr/jvGG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:38:00.0651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1750f2d3-5f5f-4222-a748-08df342f848e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026968.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB842067
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

There's no need to read back the register from MMIO.  Just
use the default and adjust as needed.  This avoids any possible
access during gfxoff.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1f9332ae52cf0..d73a609db217a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -187,6 +187,8 @@
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid               0x4ca5
 #define mmRLC_SPARE_INT_0_Sienna_Cichlid_BASE_IDX      1
 
+#define mmCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT            0x00000000
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -6630,7 +6632,7 @@ static void gfx_v10_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
 	if (prop->hqd_queue_priority == AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM)
 		priority = 1;
 
-	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
+	tmp = mmCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
 	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, priority);
 	mqd->cp_gfx_hqd_queue_priority = tmp;
 }
-- 
2.56.0

