Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94C606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KcQUGs8g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A112610FA6C;
	Wed, 28 Oct 2026 08:58:34 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2559310FA6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpz19uuvM76XRyTXG/+Jo0Qg13UA6WXdwZu8lg3AXLzIrVVoqyIS/dyI3eEHs5iv/maAyATRORUGamkVmuuU9CXNd/TtpbQGSDZT1FhPiY5x4noZstkHQN6Ashp2mFkMbuYSJRl5/Zvhhfaui678XwREA3l5bi7KohiVfAHath/NafTVKOs/HrpZ4duODBzjCvo3zIfD+UuqrhqInGMk/BNvb+E0djSb18TKKfY9MyRCfFEz7Q+NwCwI7TqIt9CLuUwm4+oA/tu2ta6zpnFeIk2r9B19eKguRMgo344AbVGoAGliagWKTX5yldIQka2KDoBLiWfcElwNnfqtvCA/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pl20o9Uo/mUrechgyWxcMTcEoEq38JXGgyranjxaro=;
 b=NUozZatbmY6Nml1asSLp5mTEYsv13YrhN9Lqaj7Nh6M6n1sNK63Vcn2i5sOyzr4G0h/J4htyomDjzOHulo5BJQjfPQl3Vis2hdj5wJ3msTCupgmiMCOeykyC7sQ7qizonZdQIIlDKzmm+P5bECo4UfLSkzx6jb8vvmHCxpDRdcFtmQ/G95fA4ab7AyUiQSUeyBiDc0C+06xPT7IbhbGCp6kGIN19qo7yLRBqsJCS4YVzPEcZY3BV1oqz6LwdFI/bdz3oOZ3p4HBHxeRLGc6onZvEhotSFlEYta1otDSFH0n9/mVx7LwuhED2jB7lLtuGZ2mgAN1MHuqHn/qQkZN5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pl20o9Uo/mUrechgyWxcMTcEoEq38JXGgyranjxaro=;
 b=KcQUGs8gPg7cUp/GqKspAExXZvGoxyX2MNTmhCAMsx2gjz7dfTYAZRq/bU6rhCEU93gaFvpiDe7PeYWoI4TyX5pJCYiPVNB/PEr67QVKMJjM5Qa2saElgymPbbDvRHF9JleWBjYdYLIlw69zJeQeBERmlonVoP9QXZo13IpDWD8=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:58:22 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::89) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:58:21 +0000
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
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:07 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 13/15] drm/amdgpu/userq: reset the gfx engine when a gfx
 user queue reset fails
Date: Wed, 28 Oct 2026 16:56:44 +0800
Message-ID: <20261028085736.3808569-13-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1b5d52-ea65-43b7-911c-08df34d19e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|10067099003|261026140227099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: GIEzQtayQeI2a3soNE57osg2GqO2MDJcC/qyRUSr1w03diGroR7f5Ma/EzTwDLPbafgshYdDreJeetO0YNA1dThP5JNCkqr65rdlUtKpfHZAvMf0zEnFu3b8otPFGw+JI1Q94tAvmtKiIusYygPLh9P6Mc4sE9aXXEFP96eD8fKoBmTzqlj0OVDkkEu10SdUnrrXxf44Fj2ejkW/NEi+ZIv6ZvIWe4cXNKpEP4ES4PKB54J+iBmxYFdk4GJ7hiPC60zEdhNzJUGuzCAGUJ0Tt6NU5gRqkkYMcSmTi81BxmAJ1wpb6O2XBLJGCi2U/FGYkTPqTnqN24ZZL8jeExDJR9pAOEOvDuDzwqEnyNL+aGsQ31iZLcBjhc3i3tjGAnMzld2u1HA+fl4g0haSubuwKk+bfsEciriZbHyGlRnKfqJB3K+jJCfL9St02nQeASNwPXvx4FLGqXHi3DhJ4ajUEllJD5ur6yCMTfub9IlSOCgacTlSP3kBrY9KpxfjIxMYcBQ8zZlL1DQRyml8yqdqB2ut4HxWbLL12SjjfYwqHzdKp9frBE8h7+MraWqS0y9HOLfOOPYGJPNtDsm7Ea/5tY0x2ToujgutGFM2FMqISprp7n6lWSgFPzSV1C2qfObC5lOfSQUExfOZD6BehkEh6eTnSK1k9xLOtrV6ynWEgQOEXunNXz4im8pkgDKgH1pjxmpgzS/1senjS+c/g/AYkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H4tvnPQiExqgk0UjmVDCteEvuM15RpEGaAK7L56fFadaNuUZnEg0wQTb2aV8DE7jP1GDgkML3qg7U0p+BodRp3jzTtWCP4XRlNP2ejUOWFBVjZvVh0QwxUEgA2IBgONm9tvpPP6jSXRq9IbnribGU8cpbcQ/3bXABB2EQkKEmA0nLPZPJK93WfceQVg/gmnGJ/i9mKJZn7O0Jn/BAoi5S45YwH88w4W3KjEJsBLuKwFsLg7CK8DE67EfroKBIfY4OE3uAeHKx8yvpk2m73KPvVJ5DRoOayH4DE+sW0RgoF8+E0lGlyPc69d9T27rtIznWlF3soWVCJ3wiEXLDEgd2DD9A+7nXrvprAFmnTBl8bgKTrXbDShJ1T07iT3QEVSgB720eAzBk3gfqUhyd7D9Ln/CdqraNe9/jhg5Dni6Zfw5n240KP/fb8tCvfrjkvea
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:21.7637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1b5d52-ea65-43b7-911c-08df34d19e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12
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

When neither the queue nor the pipe reset recovered a gfx user queue,
fall back to a soft reset of the gfx engine before a full reset, when
the GFX IP supports it. A hung kernel gfx queue gets there through the
IP block soft reset of the job timeout handler; a user queue has no
kernel ring, so call amdgpu_device_ip_soft_reset_engine() directly.

The hung queue can't be unmapped before the reset: pass it to the engine
reset, which unmaps it once the reset cleared its HQD, and hangs it,
while the other gfx user queues keep their state.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..5589be68d600 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -235,11 +235,27 @@ int mes_userq_reset_hw(struct amdgpu_usermode_queue *queue,
 	return 0;
 }
 
+/* The hung queue can't be unmapped now: the engine reset unmaps it after. */
+static int mes_userq_reset_gfx_engine(struct amdgpu_usermode_queue *queue)
+{
+	return amdgpu_device_ip_soft_reset_engine(queue->userq_mgr->adev,
+						  AMD_IP_BLOCK_TYPE_GFX,
+						  AMD_IP_ENGINE_GFX, NULL, NULL,
+						  queue);
+}
+
+static bool mes_userq_gfx_engine_reset_supported(struct amdgpu_device *adev)
+{
+	return adev->gfx.gfx_supported_reset &
+	       AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
+}
+
 int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct mes_reset_queue_input queue_input;
+	int r;
 
 	/* already reset by an earlier job's hang-detect; just signal and bail */
 	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
@@ -248,8 +264,10 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 	/* A GFX pipe reset also affects the kernel rings on that pipe. */
 	if (queue->queue_type == AMDGPU_HW_IP_GFX &&
 	    adev->gfx.funcs->detect_hung_queue &&
-	    amdgpu_gfx_me_pipe_reset_supported(adev))
-		return amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+	    amdgpu_gfx_me_pipe_reset_supported(adev)) {
+		r = amdgpu_gfx_reset_mes_gfx(adev, NULL, NULL, queue, 0, true);
+		goto out;
+	}
 
 	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
 	queue_input.doorbell_offset = queue->doorbell_index;
@@ -277,7 +295,12 @@ int mes_userq_reset(struct amdgpu_usermode_queue *queue)
 		}
 	}
 
-	return mes_userq_reset_hw(queue, &queue_input);
+	r = mes_userq_reset_hw(queue, &queue_input);
+out:
+	if (r && queue->queue_type == AMDGPU_HW_IP_GFX &&
+	    mes_userq_gfx_engine_reset_supported(adev))
+		r = mes_userq_reset_gfx_engine(queue);
+	return r;
 }
 
 int mes_userq_reset_queue(struct amdgpu_device *adev,
-- 
2.50.1

