Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462BECD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC9E112DC1;
	Mon,  1 Jun 2026 05:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5gh0PRLk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599C4112DC2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4j2TgjvMfF5Mipxd/avY9v2un4xkO/O1WZ3oC2Oz/GqBNOSxjZ396cjz1BlytvroZBOrR2koG0xXDgKeK2vbD5WzPyqgKsIRCFbshNPwTe0kCWck0ujOhh/hbPdXkmjxfQk4ENftkO0y6SzRZVI5RZ+wqNcOZz2b1hkRRboy6q3H/MEiBPRZdrvDzpsvKMyNDC/YSkjpAsompBuk0kvgUxLDxwDhiEaLuBUoyklVlGcj2XfVnrhX+YOohZxWa6YtY2U1Y3K102fSOZNo5xxvSVIi6aSkbbcln1RaNvONcE9qvekqjmn4yoe+zgXgrEJGOdFNLWirFMX+ZljjtVM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uwEELM3in0fFZ4fJnUE8MTE0qqwL7WXKPxwf93ElWE=;
 b=s1PTX6+Hsr6xyKzKSXEsKefGszg66GSOtd2fUO/PdIk2cJGU8YlEy07K3kPa5t/OhvCZSy8XnxcSCpSBAk2ivsIlfFhhhwHfWYJ0Ri07Gukrw/+sZZTUM0wCUbuYzECIAlMk+oyO418sEItXOGxLpE69AXMMvexu1OPZR21VQJqYfnf9Om2x88FzukvDjeSbCs/+NJ42StOs9vjC3dfMWhD3ZsfDpE5oIDnb0Ma5kzEr1ppDikW/SAyNqv3nG5WxwPpXvaRPWWqfrUl1PJmgf9r18HBNuOi3yEZj9ijFd+kLMo3IFOdf9OzLCBxoKEkKJa0DdFaV+Ozy59uQ7BBq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uwEELM3in0fFZ4fJnUE8MTE0qqwL7WXKPxwf93ElWE=;
 b=5gh0PRLkmCdSkdfN0pl0wRlIQzVp55DW4z9VLUQMkORoiNYsX0lqGVN5MgMcLhxr4h1XdpNOcomZGwrAP1s7cB3nP+9o0xCDebuODJ22K3ENjSvwiNd8sKKrgOGB9P3JNTPTZlc43dTeFUfuS+D6v6dc8aLmpCVs6JMxGS/yvCA=
Received: from IA4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::11)
 by DS5PPF23E22D637.namprd12.prod.outlook.com (2603:10b6:f:fc00::647)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 05:51:42 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::1) by IA4P221CA0009.outlook.office365.com
 (2603:10b6:208:559::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:42 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:35 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 10/42] drm/amdgpu/gfx12: only need to remap KCQs when reset
 via MMIO
Date: Mon, 1 Jun 2026 13:48:56 +0800
Message-ID: <20260601055034.3700921-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS5PPF23E22D637:EE_
X-MS-Office365-Filtering-Correlation-Id: cdae6a2d-4c2d-46e8-37a2-08debfa1db79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WJrBfrt0iJCL8e5nFcnGLd+8udKceyntIBJOFUns2RBb/hZ6PhKQyrPrP08+0xo+u5f32pkUbtzDCDfyzAedZbCU55bud+gV4uOYVVJGGpOvb4FALebCn8ikttNecCtLS1OVw8Bzsa3fLyvCgkoKppCFvXYWx6WYux1RVTEpUIrzJg+A2O6XSPERqiD/xGy2v9FrBRynwSZszGSPFiBgPZFhuczsbnf1VFnHnwgucPM1SjCVm3IPKfR4WcMq3ip4HpObwKybuWFOTXpBJXRmfAoc6CiZSIzk8IhmIcpPa+sE/R6BnVMD0JsIELfYAROz44eY3T/gOqManffIR1AVTndFfiFUAQzz9t35Mf4DgzSGAy/UI1p1vXMETCoqmbL/QEkyCWu4MPl/gCytmQgebssljobRBJm5OTyBJb9MkQpZaaIDMfT7mxtcHyeLnYPuUmWB//OAIoXa+QRER1Kj4HhiAX+g+EH5YY2TSM1XjxRZIL96FuoYPyxnqogiULyclEoBDXt6INQM1WnHWvSkSMKQ68bJ8o3fALNDqdSgqdgU0ULYNa3JQn1ZmXmQ8Qw29PgTxrE/e7LoXzV4RM9iEcq7R8jv4yHtlmXXxy2UWV8b5h+DRs6LljRhR7W75cPFpIp44CotSBeMk88f1cs/U5PA16ofB3UwXPqaeibjhmMOZwiEPlegtDvFA3Jk2ETpCIvcpXK4dXqeZFBx+cC63N1Z7Sfh6NJXLjyQLzkTdNs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: prnmLoOjMGFHoKj6tuhOnkgh6xmwSSJAjF+5Weh1PdC5C1hqX174seYeDkss8GnuEuh1FEenL+Dwws0R7IQN63d2MXTMJCeoVduyrKLNv1FhBZ3MUTcibEugqrp3dNcMZ2If5RgV7bxk2Cz3ikQA4gN6g3MXfIwpL4mTR7oE0E/P0oBwNBOqfF3IznfanAyjj0y3fqTBUwcqqB0dLaQvM5kdLqHyPb+fQhZrH+OWsJTll6Q/rwHWzTTVDhuYgclkv+aGiZI2nL/2PvEdHHz/tlbGO7UMyDRKMsxvPXYdI1xaTYONMLfYNef+/F6QjLuI/qbFnZk1dQV+lvix90iTT1e3FOUzbHYlqnq9lzKV47WXWjO3qxOLNCJ6rNpc+qKNmiCTlFeW+5mfOXhWcKgOkp6pUaKIGS0MpAjSOw9G6Uy7+HKQtoISnaDvDYabgJfv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:42.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae6a2d-4c2d-46e8-37a2-08debfa1db79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23E22D637
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

MES remaps kernels queues as part of it's reset sequence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f47928dcd848..4be650ce1fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5397,11 +5397,12 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			       struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = true;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
-	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
 		r = gfx_v12_0_reset_compute_pipe(ring);
@@ -5409,15 +5410,17 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 			return r;
 	}
 
-	r = gfx_v12_0_kcq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kcq\n");
-		return r;
-	}
-	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
-	if (r) {
-		dev_err(adev->dev, "failed to remap kcq\n");
-		return r;
+	if (use_mmio) {
+		r = gfx_v12_0_kcq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "failed to init kcq\n");
+			return r;
+		}
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kcq\n");
+			return r;
+		}
 	}
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
-- 
2.49.0

