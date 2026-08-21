Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A749C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C5C10F4DC;
	Fri, 21 Aug 2026 19:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q94msjm7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEC810F4DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zwm+2Gxi4khNqq7RipEj6n6uh/Xc+TaTNUYk4cCbrRcZI5jcu0vD+CiK18V8hIalOdKlXO0NxYk8hVToMn4Z9xG1zD2n+5JGadnY8+bS71wYlbX2Rr2EJh8/a5QnwqTLQiYUGIHil/vYbJTNslyIvXVVDJMyZblvDIE3qqks9wZvXWA1bQdsXZWTMUDrkluEwaXMTcyQqiA8QVtv77FHc+G+DLL1CYhjvRy8eNS9NrxIWu3pp3iKgXjOovJPipmQQK5UIkhYyVCMo5Nav7DcV/YRx2L5Ren0/f0sW5ITPFX8TXQWkhds2mprGK7yybUmKLf6FLsYtTz+fNv2z17Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4xfXIG/TWs5Zjq2fCq/42z9p5ApwhYjX3DSbFJSAZQ=;
 b=GgXJd6dmEtBnwhPtHehM6vaQZf0te3M1g4ChWyjWN0nxYqhkGgUGmIGKWXQKtS+T/q28AVLl99Y9ZhP2fWTzuYiLiNHvvnabxc6CkwdRj2UGjXJltXh1Sb3WdVsPP9QpC4MWtR2P0yxAqVPJTd6Vu6NfJgqRF+pcTLRCJmAYJoQwtEhxdG8tMcuVrx9k6gA93z6OqEcxCqkCPWhRNA1nKheq8/1L5av7ZsWe84MC9P3EmNHeAw7oMarwg+3BzqcCRfMxTNaONg3nso2oiYR8q58eWY5EOuOfYVogB99AnnaPdMC3mFchmFL7ZOoawjF8LC3WxGIbIpkMcEF9BbNr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4xfXIG/TWs5Zjq2fCq/42z9p5ApwhYjX3DSbFJSAZQ=;
 b=q94msjm7dvGDMcyfZcw5LERQZGlKDZ1W5jWYBLi1U/PAopBX25OW3bHM1kQKIHS8SfWpIqvMrfie1D2aP5nry5p6EH/mVVM4yUAF+fH6TnpQCCufEalO6zZp8KO9fZf6CzHlzl2ws5GpvSk6NaRlp40A42+1MPSuK0790nLrPkY=
Received: from DS1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::19) by
 IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:50 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::8f) by DS1P222CA0010.outlook.office365.com
 (2603:10b6:8:454::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/95] drm/amdgpu: Create a drm client for UALink NPA BOs
Date: Fri, 21 Aug 2026 15:34:07 -0400
Message-ID: <20260821193458.808626-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 690a8afa-2a88-4c72-243e-08deffbb677d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KobcjedSlBGrbxJ8zK5A1Rj7+1hxo/WA5bQ3SemjRSWoWuFbBwsPjAjm3d7lnJU/vy6lTKdXMaadoXcX4mrVY9nnqQxDwE6VUsr3kwz7uDjNgAz+8HOmAWsc51UEJ6qA9aqs+dO//n2F2WnehR68R/vsEBCrS9rAOHSPPM504e2YcCxUKLYKRA+zxlOX4q4QJplqWb+bpfsr4Ar9zkN8s6/1Ux3Q5k4sy6qBADB2VjolSSNt1DI9d91eeFYHu68XVERBzBzGYoL+ZdENcCIGCKIxrOTTwJoUdCBJyRxs7gbNnU4p/j3CQPbW/1BCZ2jny7C/By157tQjAnnRgjmbSTixXdPbFLHDnz0lU4k3mROZ/DMDSnw61vVbenqcv5C3TCob5cINDzNBGnk9/WSi4I9xHB34OonOlS+pD+7mfTouORlZsAkWt2oJTG8cbbleLBX1SIzLub+Uk9zW3Y+O/4FJVUU7YgrUuF0rQA5VEwFnG/JSj0ehH/mBf+qFK2qaiSVv81UOEkmoy1xMdCNi10k5l8NNSUbd85aELoGe3Qw8qgwTCRaE02kv+ap2L4+k10J7cY02ZLxPYeDZZX+ihentRXTPUnyV4lrUIdlMasA3dRcO+gEAg7RTxlE9SbgPuikmokh/I4gNLyrN0lGAg0FF+zmxth+wHfKp1KZivOlMsY5REFymQ2KBax/4lpZk+/xvdNqG+IiU2qnGRqTMCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: moCB+/r9a1D3HNajLOpXGBevJ2pJkvvLGQEAfKvyZIOML8S0ttWJuI3aSMia/y9jToRMDVdWirwZtv7CXPjZgwpYkSP6ol4cs4aRwCCRvi4bCJ8Hdytu6JAjPg1iGyKxxQog104HTq4ueVkWdHzo/zzkAT/EWImkZZSJaMf7PUvxIs6ivdAy66l4toFV3uaHjM9ui7lzY5KqL/VeBFUQ2Ft6/U1queGHfeucbeef/KaRs9NcWmgSlcDfjuapsAJFW0GkqIqqbY4uJ2+o0cMdB/hZFIuTpLSOgu/1EoCpgWwSQpDW0MtW8QLT0WVbLGNSWk4h5VKRRFjz0rdqLk2D0b6XJkS9SqTb3hMpMAKwdv8oh1ApDn9doxBpM+VZM5hYKxMBhbqLzaWwATyoSCzApC+F7f4nDdXfYE4bJ1fXu8Nw1EZyfJ6Pj+uInL9fEsqo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:49.2571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a8afa-2a88-4c72-243e-08deffbb677d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

From: Mukul Joshi <mukul.joshi@amd.com>

Create a drm client for storing the GEM handles corresponding
to NPA BOs. We always want to keep one GEM handle alive for
the NPA BOs during the lifetime of the BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 5cb80f01871e5..059ba29d9b5cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -32,6 +32,27 @@
 
 static void deactivate_accelerator(struct amdgpu_device *adev);
 
+static const struct drm_client_funcs ualink_client_funcs = {
+	.unregister	= drm_client_release,
+};
+
+static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = drm_client_init(&adev->ddev, &adev->ualink.client, "ualink",
+			      &ualink_client_funcs);
+	if (ret) {
+		dev_err(adev->dev, "Failed to init UALink DRM client: %d\n",
+			ret);
+		return ret;
+	}
+
+	drm_client_register(&adev->ualink.client);
+
+	return 0;
+}
+
 int amdgpu_ualink_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -63,6 +84,13 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_ualink_drm_client_create(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
+			r);
+		return r;
+	}
+
 	r = amdgpu_ualink_init_interrupt(adev);
 	if (r) {
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 187d42af27dcb..333de2058f5b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -182,6 +182,9 @@ struct amdgpu_ualink_mgr {
 	/* NPA-VM used on the exporter.*/
 	struct amdgpu_vm npa_vm;
 
+	/* DRM client for UALink to manage GEM handles for NPA BOs */
+	struct drm_client_dev client;
+
 	/* Sequence number to track the need for TLB flushes */
 	atomic64_t last_flushed_tlb_seq;
 };
-- 
2.55.0

