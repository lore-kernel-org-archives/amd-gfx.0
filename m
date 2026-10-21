Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69A606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bt7pZ5Tt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B96F10E2F5;
	Wed, 21 Oct 2026 13:16:12 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012071.outbound.protection.outlook.com
 [40.93.195.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 937B810E31B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9cVTLuuaym5M0gMZ5TY8xASvVbDsON1kA7nAwqqVGf+QIjacP0U9RbXaa/XfDT1nH76QZyPTtNUfBMUr1akRQetmcqBVmB546tMcqq6kWuX9eYvf8vp70wdLe8KerinbfCPWPtKBg2ujHp1Q2+bchBnypezGcFc/sJW/OxXdyyuglolKhUI5lufqMV+CMmePlzwBkBWu2l/bCi2Adb2yWFlL86s2QZl5XnQsOsYAfpRbrKqjW+fzGFN+xcQOFXPTK/FVhxPTqQYBS32BHDx87/qXGJYtPX2EW0TDBICRetCgKXbyQnfV8h+3nKGqa1kdBzW6gQxPhVIhp+81BQrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SihceOZa4kcUpjgnwuumhLzkxYRfb8ABzicDDw1fvUg=;
 b=VrPevtGV6EWHH7gj9wePcLs6YFiLOPV6ne/Wz8AxVn/xoSN5tPEGZn65I0OCyejhOjIUy5FH/J7MgH3EdaFmEcjV35/A+ebSwHmsxDiFUI+fTinL5yDZnfAiVsAoY5xdVUUQRpkuhXEorAip0Nn94jbdxJSwZ+bG2p4zi4GjsCnIxBgKBAuYKUl4VpP3Ot9InkE7lP6oqb4r7/ebXB9d/0JPssp8qpCk0WhI0tiBafKpqdHoO8vIO3pSw0icdNqtnrtYJDsZ7VsEIrMZADfCpQKC7F6qwTDHLSBZJtQmveCyVbq3n/LESLoO7Tob3GIos4uy8261BG1pAxY0Ibq/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SihceOZa4kcUpjgnwuumhLzkxYRfb8ABzicDDw1fvUg=;
 b=Bt7pZ5Tt21D6Vn1ucq3Ar3NjIPmzJT1+JJvFtO5B5PMKsuppYmP9t56KuQehnmt+wlpFszd0V1/DDjr9EdrdTNDQJi1sMT4KC01QUi7keq55R9TuOHwkIHDbGDYe1f4OU2REHepGdo4ITEeEnvtR+IXlMtpeEjRpiMz77w/E2ew=
Received: from BN9PR03CA0504.namprd03.prod.outlook.com (2603:10b6:408:130::29)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 13:15:58 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::11) by BN9PR03CA0504.outlook.office365.com
 (2603:10b6:408:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 13:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 13:15:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 08:15:57 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 08:15:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu/gfx9: rework kernel queue priority handling
Date: Wed, 21 Oct 2026 09:15:39 -0400
Message-ID: <20261021131545.1962601-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021131545.1962601-1-alexander.deucher@amd.com>
References: <20261021131545.1962601-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 231bc97c-0943-48a0-e2ee-08df2f757234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|261009223027099003|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fu2qVVZ0I4YKtCbFpftEmZhp8KlM+GKWREfuR63nlxJMcv9kWkZVq8BgEgEibzs6cyUHa/AyEy/DvAln4wUWD2pXT403vpiMge71BE+GhYriJbJg0xlNZ5SlINXc5IDD2ep390BJaFXQw2f8eZa6tpEBhtIm19tJKYoOSnNImkvz7uTBCqcy6wOt7pjLht2f6VMW/HcyA+wNqmDq7M4jbkpBXV2YQn2JnjmDZRrfBHW+UhbDbksHMzKqkdb7dARNKDF8UDZOgRKw0ImijH+C7nXqb1CMF6RwESCnsQLyRhZ/QWqusoGdc7mFymsDvzEq3wvv/ppDgzSza2bS2Dloe1ME4mcu5nm+iGHKEbXLN0Ird2yrZ61rw82ToNplaQ+7v5DdXqXdV7ut/6FVK9LZrdkAChSi9tno4K+vVWvdMXFyFM5+C/lEoa193n5lCG6ilVgqS3U+7+lPtmB5LJaY6tv4PbVYlXJ1ADv+RLS0FTByNxDM8co7rmiZ6204jzD7xEPPGMsEHti0eILw8CctdoXV4xEYSPcOpH5uwGvldBc4IcxWQ+h+JjzD1BE6GmXnzrA3gO+fw6z+7hrwfkykT3STXNV6Vb5xuiGpk0ZphlsL65ofhM0tGMpVlAP3Nj/cCnrltp2o8Uezl5FCA9hQ0EQA7Rji7VlFx6axH1irG1rAiBQYB/FYwbEyG3LM8aAY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(261009223027099003)(11063799006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W96kiZ6MSuhJletGqUrBiQp676SSIHSO5PXCVrVWMvoK3vL9ajUYmemcEDHGcQyDEIUbcYOUmfyrKqcYe4p9480Mki+yNOuo1n10TyKQBG8WWdXmwNvLsE9av912CKqhO8qkKb5beXnNgB0gHjtdrobQrapVKKbq7h66xX0TYv/rHq+rEDllkuakUnT2LD+yEVKwtIdANeOiwRSYHEY7C/Q081zO9MpAyVdQ9tsSc5DUqUmC2d4LS9n8L5bTDw4b/0taqaKmTr9zkRsRZnelkrIH8H/8ii7Di72CxcfIbDoRl8H3kePMDLlrf4181XY2V+epMKYYaXbotJDD3znHL5PmP0U4pRzNduFn6bTiRhFlWfkdci06aBB6bxrC9tNlPGY62U5CPB8zlXUp6Lm49tZJQpioNqIS+h25DDEXtpMMcHqc552e06NDHLy9vThC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:15:58.3216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 231bc97c-0943-48a0-e2ee-08df2f757234
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
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

Rather than setting a higher queue priority which could
starve a lower priority queue, enable longer quantums
for high priority kernel queues. This will avoid
starvation, but provide longer runtime for high priority
queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 75d1bbdb421ff..020315156dad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3668,7 +3668,10 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 	tmp = RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
-	tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
+	if (amdgpu_gfx_is_high_priority_compute_queue(adev, ring))
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 2);
+	else
+		tmp = REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
 	mqd->cp_hqd_quantum = tmp;
 
 	/* map_queues packet doesn't need activate the queue,
-- 
2.56.0

