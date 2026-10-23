Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63628606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mr42Bod3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0906B112A55;
	Fri, 23 Oct 2026 09:09:15 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD822112A55
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKrzdh0AnWWwoRbpAS/tdhmh1U55KQpjUrj366xGbZmDiXpqNzpFImFu9T3Vusts2tZEX2ISzqUGKzekfpBUplDSJypMtrcEoLRYI6zP4cvZx9Cxu7k/Q+iOJyBiUkPXJWRlN8C5Xt/xD+Kyy2vYiX5A+JAL/GjnaX5i5PR/0FtnJVREyR1PuinScfQxmRQu6oDZNstm7qU4Anj3PMf0sid6+39QaroPTjBrr8hdlXPKpvEu+R83I+FNfx/KdnQhphnZhW0+iqSfjjlTGl/6MKuy/XmO7RqDvsF+Ym4jdgyHKhjn40E4XonlZYdvucQpzw7F39kjQ2snTKibx17OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euhkz2A8F+RbUDgGMt3pFMQDAMAwrSxFBtbAmOs4aWY=;
 b=G7DM+b0lL/Rce9UF3xCvhs+ugrAnmEeRNrATVDuXHLAz62hb+pT9QIBuDQPSNmSUrUcniu7cAaqiXeww0KiBQ6FQZENt1/bNUZ/2mExVNDfzvJIQiMjcCwT0TrKSu8oBeJ8IKsgpUPiOF8VtJiIjT4LbOHApBCva8JGQ0dlSO7RjVWWmBeVJkOY6CYap15VkKcpfrtlanQK2QVgvuhZBRLA+nTPMOGnoDKU6IQxnMeBGcNkgq2nQNStzjXRnaNAN/W9y0S8l+Dy75JE10UJ+NWZwPkZ74T2rOM6RdKKMFv3ouHYoxh7CnCJzJ0zWabPClxi85GPeFFiso1pv4X2m1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euhkz2A8F+RbUDgGMt3pFMQDAMAwrSxFBtbAmOs4aWY=;
 b=mr42Bod3Eqts2E5hqh3wi5Z5OcY/ROEPyYZlr3yCzX4781yA15qwq2q1A3Obs2KAUUBpI86TN3ONYpIPxRuchsHDA7MF2JiJbwkHCY+GTRPk6KliwskjgkkcDwQYv1lwkzBROeNKwOO085dH29Y3GOXMYAoGLTbzuDu3gSAIvng=
Received: from BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 09:09:00 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::a) by BN9PR03CA0803.outlook.office365.com
 (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 23 Oct 2026 09:09:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:09:00 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:58 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 11/13] drm/amdgpu/gfx12: keep CWSR registers when modify mqd
Date: Fri, 23 Oct 2026 17:08:43 +0800
Message-ID: <20261023090845.670581-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f14d265-435d-4c74-6fee-08df30e54705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|18002099003|22082099003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gllDQ5CjlMLg//9/ogU2fUxaC5lLyIaihdXEqil3gPQg0djA6ds1tiW4noiR68EoCp1aaZ6xPNhnKARthoB8RmH1+JwYA6KCb4J5Bjq2QHiHBLegzGodLapW+WrfkqHfIcOwE0UGCMtRUR6rmZ7F+ZB04IW4Ywk4kus1RwqgrsYuaWKhse6h+uBXIBg4Ivg0YSt4I6r3ZR2sKfHKec0izY97TEICLoONjBvMjk8ZDMsBPkfzl2kWuUhkvK1jUdVMT9c23UvrXj+EFyf+kX+NJjtaKLrRHDg+d9bQ/h8J0mwT11YQ5U4ldhNTQY7bFHy/F8c9N/8VtLvf4HRELlKaJ0eICkwwbJWZ8WmNxIiv1qDXrTFZNp5TyXR5a62R8XkJ2mVgjC2/mqNmq4jvl11k/IeCXH1zH3FAQFwzH+ZfAwKewQVjtrjZX4Z++2yKghgWeweGH8iO5RpddF0DmYKdHH18pntP5vt3ZtatvERm8RzY5w7iFdSqTUwVAwtvECSf+6qOiCN2rYOnwQTZjVy7ULsQVYwe+FzcrZ2sLoFUnaX0rgsyqpAuuYhbfml1WlR2lfUXLeLOf8nhU4vXstf/h4GzQK0q+gB/raVA0WMdMYg98AMxMjNWSKotz7UcG+hA287roCFyr1AEh9XfEv1JgWGAX8oyS8hKm/aVAzT4ghaC/RaOPhtgEeJ5NuL1R8hi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B4TnD9WbY5Sgk7JfHIseM3fwW0en1hR19gFvkmFMslJQB+eI8m3n7pto54c2jgWkt5sHF2uLA9ZzH6SBRlT6rbV806mRBWOytN0aW1ZmHijYGaI4GQq8hGhbKar6EHTyD3qzWN5bOf3mXfQyVAxrKOZWNd+HRXUkGG1Ckwesd3I+HLfZDf9bCkMABB73TWQQKzApAJONz3Wa9wfPV9DIZwOjsPV3mDPdNWd5dudFOVMbD7V/ZVlDUkp9uSvmcf/ctJXcbeFPKTBM1J7ZRBktDpy8Try90cJaUfL26Bn+xIl48FuIGBwqQF+lyby3++2uGyNvsYBlTu/YT46W9NQQeoGrbuwaCI6JfniGfbPj/WqJYB9qfrU428ves5yZxxci9ngO2KH1ILNDMkjX9isCCLIKqJrSG5yNPM15eEMmRihz1f4NLF7lebaEr/pnK0Hw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:09:00.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f14d265-435d-4c74-6fee-08df30e54705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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

This commit keeps CWSR registers when init_mqd
with modify == true

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index fe6e9ac7b170..e49c1f55e34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3313,8 +3313,11 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 			upper_32_bits(prop->ctx_save_area_addr);
 		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
 		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
-		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
-		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+		/* MODIFY keeps the firmware-saved CWSR offsets; otherwise reset them */
+		if (!prop->modify) {
+			mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+			mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+		}
 	}
 
 	return 0;
-- 
2.53.0

