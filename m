Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A429C44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9647C10EE2B;
	Tue,  7 Jul 2026 15:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="McqYfSmM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C38710EE2D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQPDbaQr25jeJJ3ueXyV/naoxQQKYc7oj/XnfwMARluq7oLCHl1FfmtmqWTfj8icayJY688DIeDQbRLLplIC3RZKuTs0kdae9MKaKyyuXfQ5FqgQqIWAuazC+opNncht1l+xcl3sGysjnj0RXouIr6QA1UpIlIZqEYUex/Qa2fiEEraP2FWaX+jk1P3KHWFnQwvmfBNdGiPdsEDpCqEtEuupwgvAyYEDd3O8/Cz+uBBVkgf5uF5TTbEkqr7aMakHS60NdUqZpzhE49kIR2sNIoqJ7e7hVL+YwRLWLPHT8pkbTWckGB2UhU/kc34ym9KKyo16Xs0PoLkM3ukl0lvxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41mcQjAvN3YMP7wtRD7prJ1T9SeBRneeN1IgEnHlWSU=;
 b=qVKHNWCbni61f7rQ1RKDa3tKvAmatnK8tmPwFbi9psxLVbHOQZTF6uU8IAqfORKP9R+PtC5SYzvft98ayUc+4RBbGh5IODQV0I4XixpWZ5jc9Y73vFyvvZHB7uq9qhd2WjQ99LdliAHcvbOzSVR7aTjGjhz0oiPJD3xUpa9ilHlzOp8qUlRVZ8G+iCAqywyviFAGPTlcJugZnVj5u/lonSgoeXL/8FGAPtziywVdWRtMSjH/CaAb2lXczoQRQ68kyju5Jb7FIAFWOenDdZlf47stJCc3cCxkpkYMoPKwjEQVCkaR3TyvT3vv4LFlIixA+0+gQrgmqnQ8kRjCHwBLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41mcQjAvN3YMP7wtRD7prJ1T9SeBRneeN1IgEnHlWSU=;
 b=McqYfSmM5dSlFOjpSvs5AoS3d003GuoILgROldq0vqmTan3wIZB9xo55T86HYsHji1RcVT8OzXqp/Y4NGOCBvCsz3klCZ+bWBTspOgVtBh330/mAiNFNACIIIv5xwgEPDLR2k7PRarLrHzN6W18nmcV37DMCG9Io40/n+8Mc9PY=
Received: from PH8PR20CA0012.namprd20.prod.outlook.com (2603:10b6:510:23c::10)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 15:42:47 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::84) by PH8PR20CA0012.outlook.office365.com
 (2603:10b6:510:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/30] drm/amdgpu/gfx9: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:58 -0400
Message-ID: <20260707154203.2603209-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f40560-6b09-4727-e911-08dedc3e649a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: cnOgmIIsq86/2VeaRJ9YqP9SeGQ0oMTjaGUPO9OXAVqCi2OcnnqRJF42P+GS32+uKwCyXSpOuiiKb1j4KqlQxjZf3Rg+HkfVeaRNy8cO2TEp1Ru+cmJjJaP6wsIwz8XI0aa2Ro45HrsuJ479VFYdwt9ythex9sLwjq0kLIzsuK0/KvRbk1YXO+h5sRs4cQ2Q14o+kUwD2pB/BQoVPywRLdZpQ+WDhsscHQxcmsq1DoQBWocC6dmTcFeU0+BIuetfreUJ63mV1t8BqwVNPdlXrD5terokyfQRs6sGaMIkeZcbxR6yKYypnr0eyBf+btYK9yNXdJWLnIkjB3gwdU+bLKk0SJDFJHuNhB4J4JMID/LmgAyf3G23qROc6HHOoe9mYHgaKkZK+Kc3KSWBQrKim7ND/YdYD2qKba2KZIm8US23BU6z7UPXJELNsDPxzO9tjAKtV2YuvU0cNiDHTCU9/+vJFwvzXzz88tbQjNYB9fmOGgOWcVjJcxWFjCwhDxozRvb9Nag+lLULcq/QHjdKDmwMvak8rs1tu1IlbMexaQcYKynAimFNfg7V00zV02o92ExZT2VukBD3YvOYlpkhqmHOHdUYW2o14io/ndZMuevLqoI2zGIThin3lagFkEk27qis+JKdXAdqgO2GOwZonCMJIf3GLcpCfO45xqC2EN9yQA5xRsYXifLTSGarZppTEPyfN3rJK9AwtOJUSsTmsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F31p2NIPi1tJVIYhdfoiu3Ye9H+SsHjsNDjGQrqZgxVtaIyiCqRkBXgqJkOCR7YVGGA9rM4QHmI0beIlJ8TFOqghzNasDgqDFoexBlySC3NUmo/hhHXNqS0boiyaQfH+D3NFF4z20piv2ywBi6ViuatsiCPB42G65isnWDsFNPdIBdIVdf/ZufYf+rz6teGLbX9vDLfaA1cFfygneiElQ8z6dygRkUQKk4GJd7VLLvGRXtMfP13G1UdtKVxfD/asRP55c0LhgM0xfx4pdV2JIEV13iULw1IP2MHeN3HTT5tZF+stzi7Z4JhcOsz8wJ6eW9iAJs5r2XOgckBaaSmqXiCZEzZgu7/OPVVN8OHxH0RDQLmXGAoyq6gIC601+WVugUiZcw8cvhf9FZIbtqzOX+brC0OIMcrb2sTs7tYBg19mfE1C1duByY7XE7dGaed5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:46.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f40560-6b09-4727-e911-08dedc3e649a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 556e5cb3f4cd0..7e13023c324b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2107,8 +2107,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 			return err;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	adev->gfx.config.gb_addr_config = gb_addr_config;
@@ -5681,13 +5680,16 @@ static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v9_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v9_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -5699,8 +5701,8 @@ static void gfx_v9_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
-	} else{
-		BUG(); /* only DOORBELL method supported on gfx9 now */
+	} else {
+		dev_warn(adev->dev, "gfx_v9_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
-- 
2.55.0

