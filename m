Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4287FC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF6C89A5D;
	Tue,  7 Jul 2026 14:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/OePpbb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7167689A5D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 14:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKgo2zZCauxYuyVHnxd9G6c3tLQnMAYiAr891IQ9DqLGEqiDzRIswOst9v/UBL4NuEBjLv+UgF8l7kmG+Gieuf6uocGS+wzTMAW4rNRA2wPtTZksRUSyH7zRJhP1eh1vL+OjSG6fnJ43sGrecKF+mO02KxCfe9m+9hoHYglOxtRodikxp5+iXJKelqSbX5cIA9jSoJPl0SfgZGGvnDVwIGCHN0X5s/tQrbY/VeFaLGpsBt2rAT3S3+Ck3eJfQ2GQL2BPVBACDlyS6j1YhdpWDs6L9pKWFn4A4rUSKt4he0rrpsJBIiid9t1E7nMGhuN2o029Vj9/JxN8BNrlUHWkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkLwDJdjdOzZ33m5HZHza+b4SyVmJxtv8tL4HGWH/lo=;
 b=IScW689qRs9M7k+TP7ZyX3Vj0Q+wjlX//jZ/1cuIvv77soQ88P2tkxtxZnnz0nWGlc7ROSfWGInRPkZoH7uHT/7mOZkuYZwkJTYgfe0qV4wg7VI8pOEnTbNKCXzM5oYyDfQp8azWhF+ip4bw2F2SplmfbhV5xOeIBOwN9jbf6T5w5Rs2mcO9njw9+vmAopdd9uxvX5DsPmqGfXO/tfITTJr7YJbFf7IVYAGjyUjQIPD+iib2du+2rivvP0JY87+KVfya1LNapLDPCLm5djPaZaRa2crwYnVGlTVQ3mx6v1H/70WWtRsCMeTmD0cgxvp/loXw71AsxPq2xcS56ZPllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkLwDJdjdOzZ33m5HZHza+b4SyVmJxtv8tL4HGWH/lo=;
 b=A/OePpbbitaTzneDL4YV33EWoSz+az+CgoYu161tlYY/236qqCHZ5zPqYCIEgYr3UOh0xAbAomvUwKV4ay+DDLa1eUtRGC0gY6mRBb5vjan/Bv4xLuPZL1ETp90XEuBrbjOnI51PAtWEZ9fPN4CkNT+jg2Ou4dSESZa9UOIwvEA=
Received: from BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 14:34:30 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::72) by BYAPR21CA0004.outlook.office365.com
 (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.2 via Frontend Transport; Tue, 7
 Jul 2026 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 14:34:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:34:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 07:34:29 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 09:34:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/sdma6: don't do MMIO in MQD init
Date: Tue, 7 Jul 2026 10:34:15 -0400
Message-ID: <20260707143420.2104857-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c7fd65-5957-461b-27f7-08dedc34daa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: czsyaR9fiUNnx7IOQ3aee8yUJaZ1//APDx/8JHVAUIWpYayvji08aoeiFRdUNMkG5m5FGjp9B0wbJTeMxLh5vuyCUezjFDUx5+CwkBKont2rR0wJeRkJpeLjmz6ZhjA9n10sz2+dBuWoann5/IgjfvaEZ2DpXKM+NbaKpPTipn89t/rzggryidzFmBwugWX2P00dFUlT+8x5uC5d4siqu0PDMpUzbbOX0k2QTxYrPuXhmzHNgfh9E0y4iXH8Tq0KPMrR5ERPxqN+xe5gWHNlrDv8iLGhBJjQ7bg6klSkr46lZptomjJfHF4hAyVPkQLji175uPPYR5l5iZBCwiiNeA/6lq3a6IG/GIJqbTztMMTC0LsLJJe9sOd8C/HrnrfU9sOdZfnFeV+syHDrWe+Ac22Apxx8L+eAB39nif3YAvhKcnytd8M5bf/P6gIY7xyWToaOZArNf5EwJXvpYydbLVeosu+7r77sH0S1MW/ZjFCzh5MtE4EjSK15yiHCc+GeGzEone3LVjHa1JUSfnpyIIzm9oWttE8Cwc2p80UL7IlubbU41QiJ8/g5bdPz5MiHY9wrdTam3Uq+5UTTKGzvfCX9NDZx/yR5WxjtubtkMZk6OvNMTLbQxXm8t7w6TR/CMTm3ASkZYQgLdQEIpF6GUDiDeLOQSdR5MU+BAQmJs+kbGSdY3LtZARRkp7RFgyu3f7hGVKD9P3lI6JMXGS2pag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pJsktkflBJxAE/3P1Xy3iIhuRv5Q20lhZFRcgAYz7Z3F8e8NlR8KdOFWYvBFKDngCxp+JM+fr+9RBR7rm2aVbZJGhjuy20RNyJuEJWHZb6Qc8Wxm2ZSbAeZvW/eq69hcJRytp0ND/E4F145zLnm2aQl9LWjDgnSIIh147dpEh1BgOFSAB2IAU4gGsQl2mDLkknQ9kpsXRb8J70hqIHRHH8Rwer7+qSD7WigsAl71mh1Ti7hbf88W/X2WdR9XTeWQv76KLgDWSjJDMzYa/3t9IzmXjUIFPt4UTxpBxp3B+/yMPnMm73JTxeycqZGlPS1CzbaGrkeo/SX8fp4EktBbUlpAwLPC285F/wPua7lKLO84OPjMVVAfvcnDBHPB/1l4vzNw0IZ9dwZK28B7PZHIeVv6scM5XENZtOuCLLp0/Bd4bgS0B8qaBP5n0ubVqt4u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:34:29.6500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c7fd65-5957-461b-27f7-08dedc34daa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 96c350d5fef24..8d3bde9fbb426 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -860,8 +860,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, 0,
-							regSDMA0_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = regSDMA0_QUEUE0_IB_CNTL_DEFAULT;
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.55.0

