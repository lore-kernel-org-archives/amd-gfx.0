Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD04C88E59
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4BA10F6B3;
	Fri, 11 Sep 2026 17:56:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7w0hfA/";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3E910F6AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pc2PHOTJSKYKxvhHWfCzoTCOPIbmCahW8Dt5Ze9/7A1qeajF3oavg2PEq/v8Nvg4pWywMMefuJstT6x3keqXu+ptSw57qiAN5/ysRpAI6M2E5Z7kdfdG85lLY88x4Rvu+gFE2dFf90E9GgxEWBAIKuISLEmf3WVUxFao1+T+SsOHm9PbqrPoN+pbaBqasKnpr4x0WLwwZ2U3YI2ognFZM3RMRLqyj8vU0jjOX3jeGCP6bF6xYPn1cK2MM88yM93yNYm+K4xncECaLa/LYJyf83QOW2EYRpdZ6idrffp4ne5OeFuKik+qxLF7P/XAq6Gu4wlNUCoVUW7gIe0hfck9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgu2fTzhxDTY6CRmezvYrGh1up1nE+yaHyqqhRua6N4=;
 b=HpOKEvQ9/6VH+Udykng/UCAUfsotBfQ30vrT82tHUxbeZcjl4PKWl5cdvCEb8UhKRnlme5vM9mPqDE7Rp47Op/xnQ/b/c5+f0t739MEMTtdJH4EehnetgdLfvrmtw3q7v4sSzzu7zy3jJMV1U8foGWx3MNsIVTpsZp7Facl1110dl0y3jDr2tJnD9SVA5tBA1YJpTeQnChEgsLuaWxnnLwdJfbPZMhbzUR+3JZAtD6gWHltcJcOBTJqRrSbH2cWOmhJazhX7rvIFXSA25g39SfTwMOqAgtUazj/jacMi/I8OwPsVP4ZdEDdlE1qR5ytalsQY3gxA7/frIKbVnPxuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgu2fTzhxDTY6CRmezvYrGh1up1nE+yaHyqqhRua6N4=;
 b=d7w0hfA/WLM/b4aB7cgFqYoK6Q1htZMyo7PTlDuErCtoIOb626WZ2byKrLDHzlYw+kDQDEVCgzc1VtvSd5mfKrZfr+IWC5reEC6I5wH5aAgqQc0nbB7bMgTszBQbPEZkpYXkm+aJkBmNbG9hp8mnVUdXsnUnlUYz8CK5RDq7/nI=
Received: from CH0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:610:e4::7)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:56:17 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::3) by CH0PR03CA0182.outlook.office365.com
 (2603:10b6:610:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/23] drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
Date: Fri, 11 Sep 2026 13:55:39 -0400
Message-ID: <20260911175544.1314467-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5aecd0-64fa-4a34-cbd8-08df102dfaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3gYwp52jPrgvYEsSXbmlQr7jA98Bwbal6U0Tg7Up2fdi6Uh3pWTCG2S6Ju0ZCjvAPkNecJSC6Biu1G1loRtP3D/2kT3nhyNpHGrBfCOdOd8mH2HqGw7BP3pFm/grmRAgHj8qQhuZF3Df0we1cc6XWt3WEI/PxdHOBmATQm0E67BqskaUn3BydALiyaORqQAKq02/H3YljFYJ0hUd4jZf26qHocAhpkQmBNYsQq1lpLXzypWQVrw5noT1ph7V8n5vb0vIdz6HPOE6KUjyVS3QCE8wOzm0uHeyrQM2iAGPh/QRhGK9L6fngcoyBi+1Q5YUVuHbYHD/7uA1h+ysbiuxEYQTAAW/qzft+X3laLz5l9Sa2V3rCwKnsaDbu3/eZm5M6YusFkoBwYS8+TVOIbF5dqaVZkShg8lGUcb9pYXJ6xgkW6Ywcn7o2B8aIudwooQ9D4AFKHrzdNfLBa6+NI7ZQ3cQHTh9Hz5L1TaDFWzzuyTIZGMbhfXBaA32Y0yQliMydxMPCb+hHI3TPrj1xA0GPPOGvte+oNXdLxD6N/QMsTkRePCxoXCcy+8ze2XvhZt+8Jkc5YWNnOFX8A7jkBfmVMudsQiCgMkspzHthHBrrSBgNZ1iqCIfCH6rJFiMMSRQZv4PDlDbEU2Eyxwpps+sPVVPkuBnaKGdTQ8R/rM+lDyNKituZ+UXzE+sOj8ubF+pZqOn0vG5P06EuPtJ6jqUJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wYD5kBDIhlzUU5brb4KQWUjXD6tmYaKsVdrhlidoD0ePO0VrjX5KSGEX7QYPZ7EIPjIpBa9IfFRukdMOibkIL83vJn/SlbyPiMHUfdpa4b1XSNhUW2VbhERf0bgzGtSjde5eIm3J3TqUp892esXPa3rkMjjaZns19ARigTNC8ZQWFgZXUYjEXbarsvMu7pbekqWsHu0XGKANp5l7iFo2vuqZm86I02YbZATixUPWKxf2BYvRkEF5yyyW5aIvityrz0gN71xO/WlAsNW3//5Us3/iu3s1pzEi3oy+5YV9VrqUQIazyJ+jUioYJWDD7DEQL9CUKXj8jHWovJ43lt/TG9e9OEimzbA227dNrlvNpuNJPF3YmBc8bRid858S8/9Bc7j/jjYhiOm6GCJkwwELWVu4qXLCb7MhEt2AYEks+sy+0lZ36G288r4NZZ9MnjCr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:17.4216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5aecd0-64fa-4a34-cbd8-08df102dfaa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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

Use SDMA rather than KIQ/MMIO.  This is recommended by
the hubs team and aligns with what other OSes do.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 3d545e0ebfd86..fa0fc4dc724c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -788,6 +788,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
-- 
2.55.0

