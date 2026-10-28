Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCB606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3nyKFl/t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F3E10FA89;
	Wed, 28 Oct 2026 08:58:25 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 725E510FA89
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYQ8RY9eHAiMeTnHE00XRZEK8gYf/oZxpQHH6SQEbH9tl/RByCVM5TgIr9EfVpBb8K4x8CXfO1Za2f9Ss9ivZArXs8HGq/sNvonj4WQKTfc5Mc+2pgZjR7OGciuK5/HkecpDB+dMqELj2w1phiBw9R4Pdnq/vENpq0e2TNLEpgLBRcZu/osWSHTzjT8JZLGI9NKsjQ1L+f28N+aOiloW7DOw56Fd380aLkhhKmEVm3vjQoQ4ljvFx6BSMpcUlgaPv7Vgmsp126ddDiEKLsxMU2nUMOWFTHi2tbhHGwReltehwvoMNijGtt/rnLw6MkKNPRplcqd5sApqawIPUI5UAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQp/DfCFDcsQVOdrp7vPPbbc/yvjKNeXrIX4Adm4aJI=;
 b=TSA+mG8iRxGBb4kNNog+LfN8JfQeiiXFDjDN/4RRBxUALTQNfYN8UIXWZuCTu5wNQqtPtmW0+bpAHn6JQ98OLVDilB5V5Wma+NGKOpRMu+D0VXJUqWAZPIHR2cq83EqxodPk/iGegXAu+1RqgdPB6QF4YUApWqMJk6r2dNQsavJ7xAP+VY6mQ2W5cBLQz1qX5f8fM/VR1rrrVYaOommnkaX7iol6HU99Sofht38tYe5FYRvEV8Bglt2X4LDSbr2lUrZdQCUnTG3wHz4q6eUY/bq9us0k9zLLEcs7L3G1tZSREIkQbbaORbibRBMCjyFlA6TwP89UUnALEwlGmAA3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQp/DfCFDcsQVOdrp7vPPbbc/yvjKNeXrIX4Adm4aJI=;
 b=3nyKFl/t27HizZ35D0DTULrEZa4rwCEWuZZMqxfa/yGVgMpFqYAr0g2mVuH1biWEbVm4qy0wnHFLJhXPtgtLz5l8RyB6emY/KQXKjAa0LgQMw8jhvHzlXYSytqHHJS4CtevSzZEjjgk4nW+kTt+xDlFZVA4RssRcrsA0QNrTxNU=
Received: from MW3PR06CA0027.namprd06.prod.outlook.com (2603:10b6:303:2a::32)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 08:58:14 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::28) by MW3PR06CA0027.outlook.office365.com
 (2603:10b6:303:2a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:58:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:58:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:58:07 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:58:05 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 12/15] drm/amdgpu/gfx: add a gfx engine soft reset
Date: Wed, 28 Oct 2026 16:56:43 +0800
Message-ID: <20261028085736.3808569-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS0PR12MB9447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2994f94e-3fe3-46ae-439c-08df34d19943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|3023799007|261026140227099003|261021121427099003|56012099006|11063799006|10067099003|261009223027099003|261022075727099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 1xUjX4a4rzLshaI+Z+PsRYDOHhdo1tNOy8vegXcXVyOxG/ZYREDOV2avsE69JmFm74JTxoV1nhIbRb1n2UPK1DS5Iw4msMgYgK3F5GZ8UZXCLMpw3OyeCiuUb3TKa0ULZzJjP5cnUZcjPPjXT/Ih3YxAB5Jovfhi29o4OFN8AE2yndxS4YQWEuVEod06Pf5ga4qegDid3ivbRgo9mWOE5na3fOVhucWR4SD5aySEvh9EnRuY2uTfP/71f986glL87YYul/lZSc0W7Xia13YeQRm//d4vm6d8ppDAWCFZUIxU0MrV49wMTY3sdfx7fGF0yXT2PGZRbop82ew4q2OoVndkf/Hrk4Bulhe2YuryxgfM2jseVnGiGkPsqryJfMzKWcG/V3CvG2X1zPXIvdQOdMR+Zqi5whZacKTJos847yNSXpCT6a9PwJ1fcvXXaYaEK4gKCgn+hA7WOQyddviJaaX7U8DHaksg2B7100oOq6kWERJ45/0N7F3klNa/38Mj1+cOmAl80y9d01HDp+4gP7karcZP7xuybgYfqiv3JacbuqgeSGJT9wSu7GqoJDLS6w7QUE/bq2f1x5a1Lgej4MizDRCWq2NRHOXs/mY8o6L/wqnb54+wkkJI+U+g2xeKzH4RseOX2jYinQIdiuMg8AcCTtjzOwOsSFnSKxyFicLJEELDYhM0DiP6aNppTTKCptcRFuAZ76UGecjUs5F63A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(261026140227099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261009223027099003)(261022075727099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mKI+gKhJbCcmIJbsYljlbvWSTOKGmdSTRk2E+2SEgp24W8b7EoUrTH/aE5wooUvqBoaBRv0DaBsI2B6ADbNpbmiK2RbXdqH7uZXLR+1dzqXxnoH2o1aDpLyCOzN7kJ7w5SHMxFCbYCPke+YQzR2/OhjzTct7TeQfoyzSt3pSYnexe1GNGrinPa0IHUQ5/ZBS2r5G0wJ1NJWkWXKCe6vqG2GcdPryfim3MkIkh4S9xUC4C+lEPlOBb218bz67So7gCg+bj3Ht8sJQ9IdSgwamqyw95Zawg0kOtig+axokkNOzTyIff0Etq2bmqb5ev2IG5EgoiSdjerSTo04TvuaQWMxYYRKJ1fCYh6bISr0gO1oa0Y1mqL6w1XokSdK3J68J75abezpzrM0MPbztmW5sOv1L2i4R1D5MLyfoAzK30xcjl6XEEHd2ZrCbO5KPlqeQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:58:13.2779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2994f94e-3fe3-46ae-439c-08df34d19943
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

Add amdgpu_gfx_soft_reset_engine(), the soft_reset_engine() IP block
callback of the gfx IPs, around the reset_engine callback. It only
supports the graphics engine so far. The IP block soft reset stops,
backs up and replays the kernel gfx rings around it; the compute rings
aren't stopped.

MES is suspended across the reset, so that it doesn't schedule or map
queues while the CP front-end is reset. The compute queues are preempted
meanwhile: their work is only paused. MES
fetches its commands through the CP front-end though, and a hung gfx
stream can keep it from completing the suspend. Reset the engine anyway:
the reset frees the front-end.

The reset also clears the HQDs of the gfx user queues. Call
amdgpu_userq_pre_engine_reset() after the MES suspend, to save the ring
state of the queues still on a HQD, and amdgpu_userq_post_engine_reset()
after the reset, before MES resumes, to restore them. @guilty_queue is
the gfx user queue that hung, if any: it is hung instead. If the engine
reset fails, amdgpu_userq_cancel_engine_reset() drops the saved ring
state for the full reset that follows.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 41 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  3 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..f1a26e4eb06c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2181,6 +2181,47 @@ int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_gfx_soft_reset_engine() - Soft reset one engine of the GFX IP.
+ *
+ * @ip_block: The GFX IP block.
+ * @engine: The engine to reset.
+ * @guilty_queue: The user queue that hung, or NULL.
+ *
+ * soft_reset_engine() IP block callback around the reset_engine callback,
+ * which resets the CP of the engine. Only the graphics engine is supported
+ * so far.
+ */
+int amdgpu_gfx_soft_reset_engine(struct amdgpu_ip_block *ip_block,
+				 enum amd_ip_engine engine,
+				 struct amdgpu_usermode_queue *guilty_queue)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	if (engine != AMD_IP_ENGINE_GFX || !adev->gfx.funcs->reset_engine)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->gfx.mec.reset_mutex);
+
+	/* The suspend may time out while the gfx engine hangs: reset anyway. */
+	amdgpu_mes_suspend(adev, 0);
+	amdgpu_userq_pre_engine_reset(adev, AMDGPU_HW_IP_GFX);
+	r = adev->gfx.funcs->reset_engine(adev, engine);
+	if (r) {
+		amdgpu_userq_cancel_engine_reset(adev, AMDGPU_HW_IP_GFX);
+		amdgpu_mes_resume(adev, 0);
+		goto exit;
+	}
+
+	amdgpu_userq_post_engine_reset(adev, AMDGPU_HW_IP_GFX, guilty_queue);
+	r = amdgpu_mes_resume(adev, 0);
+
+exit:
+	mutex_unlock(&adev->gfx.mec.reset_mutex);
+	return r;
+}
+
 int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6bbf53359a49..d63d9f5f5b96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -740,6 +740,9 @@ void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
 				   struct amdgpu_ring *guilty_ring,
 				   u32 me, u32 pipe,
 				   struct amdgpu_gfx_pipe_reset_ctx *ctx);
+int amdgpu_gfx_soft_reset_engine(struct amdgpu_ip_block *ip_block,
+				 enum amd_ip_engine engine,
+				 struct amdgpu_usermode_queue *guilty_queue);
 int amdgpu_gfx_reset_mes_gfx(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
 			     struct amdgpu_fence *guilty_fence,
-- 
2.50.1

