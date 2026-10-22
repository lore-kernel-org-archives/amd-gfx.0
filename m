Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E048606A319
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0pok5b51
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4A1F10E1F5;
	Thu, 22 Oct 2026 08:20:32 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515C710E1F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfrcJyBO+drEfxE5fVzjIOoD/JB5LUfeSeXU28Cz5AZYkveEIGT67htY8BRkY36XHiBns0qAfap99dq9IMSxIrhKk9yWAoD7TzILykdPRqvFn+ej9U0aeq9GC3VxE/Pr2Qahy1ZYvrFao8AjGtC9cXm/MbVd6D0tqOoghZiAMD7gPWHYE+nTZP3OHBJGSIqAsoLnHZeZnEkSpysCi3mBcvU4ofJpEYvCr8d9awfUzT4nIHxV7v+1LtpgkLQ/T3QHXbvFFCEqwwO+NJS0nvgyXbBkp9DbYkEJwnvAbVD7kglyvxcosz3sjzr7jn9N6DnZwKzW0PWSxgifj5IztloOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mREm/VQfVIp8hPMlaRM27Z0yHjPO0S4xQQ0OXkQY88E=;
 b=S66n/7YRQq4pdb6cEPTZvWGwMLPCN1SON5D48NRcB+34WGF7bUEAoXy1j+I6K8d/PggdcJyFqcRb+4n5+0SlhxZl5UTLGrOy+nP2KtApKyvIwCfJx9h1cRwPI6GWmvHZ8N5io9FDKPQdTAeGgLzs+Hu5hoMlJCdLnthMC9nJuXd8yHCc5/s/Hbj7Bu3qOXOhEpSu8PjkVqVSLLoMBcsV7r6fJiF5yFZATJYwvxp8REt5F+6UKxxMBI4XiPbVrbP5xGtvAdzj0OK8Nrk2vsehJV6Lrpv0h0ks+8TmPkdqqoR2cxT2GkiIygbnhuvsfSMgvsGR52IJsvRyETum2L0SZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mREm/VQfVIp8hPMlaRM27Z0yHjPO0S4xQQ0OXkQY88E=;
 b=0pok5b51pqiNkUSA9UZ6yWvHi56NA2V4aWEQ1qGiKQVkivqQGRLSWdpe/duSzxb2pFyHr2PGbZJj/mQrV8C6FWe6nU4NTlmOBHNFZimBvRDlhFFxO9RBOnjVC1doV7nHTOyEnvFUGVTsenKHL1cDAouRq2jfOSwXLyDVcAJUuBg=
Received: from CH0PR03CA0315.namprd03.prod.outlook.com (2603:10b6:610:118::15)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:20:22 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::39) by CH0PR03CA0315.outlook.office365.com
 (2603:10b6:610:118::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:21 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:16 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 01/15] drm/amdgpu/gfx: add a reset_engine callback
Date: Thu, 22 Oct 2026 16:19:41 +0800
Message-ID: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e736d36-ff68-484b-60db-08df301550c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|10067099003|18002099003|261021121427099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: /PxyNnCXpGLxONwFqS+afq+a4EVF7vVYtxaaCyxzxPWGL9dNKajvMAN6UxvfwzYO0HddX9tO1gUbDor459LXzwyEelb2OoEzezZ7dQSIRXA8rtwhz5Bp2okrK8vjxdK9tSNAURsXHr34Gqlcwhv4lL7pF1kkUbBlOKfomq/yhspA18+36wzVBQTTNWZc8t4QAr4B0y68OmlynYQfEU+Sl56ER6/CPq8x16kLdFNzELp87AZbvZNdourjS0RR3JEvuVL21ZQ5eUVZFWm7grLvcIOYTE0WSAZVSWeXhmcjksolKt7W3wdrrXmiF3N71nZ3rrD/n4D7b5MxGnW+pMvChOw0L8RvpYyIdfpQqu9HcysGrLVhxTglBdxQwKrRG0jeOPRahjQouf5O0WP8ce7EDcvNy/nXvQcYKmQr7w45GRxT0cIbjfs6WAiITbbM95IckcDNegF3iHs71yYA4Nl1DgQmFIdRvrri25DJiw/czYbVoklIrsIOIAwFs5sFXkuzAvS+o2FItxpvx0/bQUYcrjBtedXkCwzxLpMAJFlFrEkjnGCIHd07n1w801frDd1JOB4kXg5xWhcl43zdbuWvXqY5AE4HO9ahMt1MQjy0F/zKXebZ/hFXDqRUWxsFxW3DmToGvUAV+0OKg0kovyNA2nzNeWFgKD7MzYa1ui6Uo/gpzFbn3T8UuWOXYuYUyQFU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(10067099003)(18002099003)(261021121427099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ecBR+TXemVmll6X+M3vUfSsFe9O7pOupEfaKkWetUPJhhOL/eocMZq6bxdZOhyZK2eZz2zc+oSXMKl7q51czK+TdLXBp/U/X8BFl8TRk9dRnrT8RPdUSnqUz90T7yyf9t+OQXuGxtQHrF04phBGVDiQMmCveAsyunsE7WQ+rBA3X/Ngsp+MGsaLRY5PKTNEPY3wkf8gSHdLpDmuA34d9Xd87D6dIoVt1yZwxZU8qJktLIhd7Ib7vTmyYGkpga2o94olmRy783/WjqRCv2AuOLqXdCYHcV3+GSUxud3aF8Mr/2bToTm4G8Pq+lvxDlfmJdhP3QYf9xXncI46vybNqRmME+Z4aWsEqXYW/6dlQg1ia2DnK32XIh3GtCQIw0p+qj/yIgI+PHIU4b8W3PvG5XGLR7YG/L5JSH0NTBC3UDp3kb3mLTsGbo6tPzgL3nFm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:21.6696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e736d36-ff68-484b-60db-08df301550c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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

Some gfx hangs can't be recovered by a queue or a pipe reset, eg. a CP
front-end stuck in the middle of a packet. They currently end in a full
GPU reset, and VRAM is lost. Resetting only the graphics engine is
enough for them, and leaves the compute engine running.

Add an optional reset_engine callback to amdgpu_gfx_funcs that resets
only the graphics or only the compute engine. The split is specific to
the GFX IP, eg. CP_SOFT_RESET_CNTL has GFX_ONLY_SOFT_RESET and
CMP_ONLY_SOFT_RESET, so it doesn't belong in the amd_ip_funcs that all
IP blocks share.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..8dc669e89db5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -345,6 +345,13 @@ struct amdgpu_gfx_shadow_info {
 	u32 eop_alignment;
 };
 
+/* The engines of the GFX IP that can be reset on their own. */
+enum amdgpu_gfx_engine {
+	AMDGPU_GFX_ENGINE_GFX,
+	AMDGPU_GFX_ENGINE_COMPUTE,
+	AMDGPU_GFX_ENGINE_NUM,
+};
+
 struct amdgpu_gfx_funcs {
 	/* get the gpu clock counter */
 	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
@@ -376,6 +383,9 @@ struct amdgpu_gfx_funcs {
 	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
 	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32 doorbell_index,
 				  u32 *me, u32 *pipe, u32 *queue);
+	/* reset one engine, leaving the other one running */
+	int (*reset_engine)(struct amdgpu_device *adev,
+			    enum amdgpu_gfx_engine engine);
 };
 
 struct sq_work {
-- 
2.50.1

