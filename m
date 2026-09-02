Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A5CC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 23:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5082310F374;
	Wed,  2 Sep 2026 23:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AeMZihgK";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D6B10F374
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 23:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUlDh48NIWWDt6FCjvZ5Ot2QHuSZFCUdzAzz07S7jVmYjtXMk9Dzhgu57f8ccBSN2OSbxtsY7IopKZN3PGEu7/cwPkKvSpcMKfYTf7rutlAhRAW/TgAQRU2B8EvMwgn9622AKX6F28s1bgTToMlD1g9OO8Uj0k+JkjR7FO+p1rPfXsU6sd9sr8qyr1MYiUtUPr3Mx5uPI/zAc9LAY829PpZOzI+RKJBDrN3nM6yagCTmNFqrN6+aGBhg0O9qH/+Sbth7XRSRgIsE4wbv22rtGBv7IY7KF9C67qa9qNhRgwoxTjWp9GTd0IPOxK8sH4k1sZ3fLG2jIF/KiJvppv5VTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C6wFST8OaluWppc9KI2cYWYFziSmCDC1+AIUs0HXps=;
 b=EwuUMXjobWaYV1tXyWcjh2a6+eRiGyK5XUJ+a02i55sGfjmLZPPUOItQ0hIO97Vif38IHcUgkDEkteH/DHwpwZNHiSfNEZ46N4JIY4Q3/oA5WZTUAfiIBahYiuJ3RsjUBiW4pAG5eWjIPnsys/vlsCrj3mlQSNHsQ0dXDJn45MMQAXN1mDYjcKeditziNnfhAyicRHoklVSEiK5TXYzzAdQ3IDxqu47Zq7wiBGfVuDXdhSB+WFUcTMU8PcWWugM9dG3CLiwUmJTa8fTLzNfcl7maMMrDUrWtuDFBlD7Kf9uHMeAPNaHCII7uuOeY3qjyTTPMBweTd6yAE1cJ62iZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C6wFST8OaluWppc9KI2cYWYFziSmCDC1+AIUs0HXps=;
 b=AeMZihgKSAU3h4c+L2wTFvWXJIE+CqdbCPmT69UlotSdxHlLGToitkTIzYCT/Y7oPFOjm/4XcPcmyWY/Z2WE/mYwPhpd5krl0Cxr/WZB6B3jQI1q1LhjNB8dkFPocYcFHQWT47jDBf0HAPvNs5ovas/tm0j8R+Vg5Mx3JxG63hc=
Received: from CH0PR03CA0428.namprd03.prod.outlook.com (2603:10b6:610:10e::23)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 23:08:24 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::48) by CH0PR03CA0428.outlook.office365.com
 (2603:10b6:610:10e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 23:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 23:08:23 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:08:22 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Don't hardcode hqd registers list size
Date: Wed, 2 Sep 2026 19:07:44 -0400
Message-ID: <20260902230745.3093556-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e65e353-176b-4e8b-40bc-08df09471669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: H5iwE8E1zhlo1o2iaRE7r2uFtacy2ZTn0PE7Rx7/j5f62Hz2NapmU2EpufKUhS2OGSIZC3fbc8IKbdGnIjJBP2Pc9g0UGL6dyJj0IxFqHGH9HRfb3oJlZu0EY7EB8QxhdzE+CBBVoXSIO9Q87+xk9jtOLuh7OabUk7Z23ZNgiwqcXzzTVHY0WcpTRP9dNaCecrOjXGPUZayMgJTijLNaSKF1QuFKdCMqsGmJm4JKIy673Wt2QgxtRKzzNi3MS4RlRRHgjY8HqmfG9gIXtGsW1akFSxhNpBuOKErTd6eUZKsj5tRCoJZV5iRuzpZCs5v/MSX4QgZ6OcmVQxf+m6kk2O2eGe/Tj8KlTw4l1Ss4r3ATzBCjXqLc5OYOG/WE/v1qP86fovC2wGCp2tR+su886DdWGmwsAyWEWc2Q+V/jtd2EnD2oJgiPePVYdEqe2Ktrqb9CDcGULczfn0aO8aKEynIQdeDgFUxF336wCI1VkvHvWFINGLMONqwZA4hshzFz9rSyT9QxxTuZMfVufc12uFR+kxR6+oeg+dvYGrp9YwYX1H4ZdhkVhQ2AfHOOyKIoiYMtuXb/v0+2ROrrKndnyEKi6PkeOzK4Bklbn5fSp95V1mLi7wFialAhkiuza41JS/bCeJIcbTkT9Y7j/nfDyieV+hROEsujVp1flHNIdyeYFjacJw5rDbVoXwqaIUlMCHUewdYEz/V5zaNB0ayxNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C6Z++7wu/LbAaK+B4M10+YFh8RXj2cO3Xl+gPwIulnAaslFkrEnS9SWHL0rJZCPT92qSO83WV4vcrIGSnkctYIZsTtVYUsqjqHqi3Wsne1yPuBRPSV5N71Hbsr/kz4Tm9gZiBwJDfCma2Hp2QCqYACwpXktnQuvIisWpCRup/wGCkzA4Evcic0lUxQqG2wlxaCwGSvtLsnDGjbzS4vinfbiQmm65yG5N0oMu/f94bH8AUZS/o4jzOZ+jywOGg3n2mWmPpYO8nFyab4KzJ3iXAcfZT6osTPTIhYoTBzAHySyez8NGTUQKLKlo8t1R1hEr1ITeW30hhiI0aBS3NOtQyzGlItLNHrCuvlqX9QsJTtpDZk3877K4VU9hSXEIyY4uG8wBgsMpBsdUoGX64udwN0fPymn9bpYzrRJowZhPQg4kie+jDxRD2T0mxK4WKuyO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 23:08:23.2604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65e353-176b-4e8b-40bc-08df09471669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
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

In hqd_dump function

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index 0694bff871d2..bda9578c4035 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -111,7 +111,7 @@ static int hqd_dump_v12_1(struct amdgpu_device *adev,
 			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
 {
 	uint32_t i = 0, reg;
-#define HQD_N_REGS 56
+#define HQD_N_REGS (regCP_HQD_PQ_WPTR_HI - regCP_MQD_BASE_ADDR + 1)
 #define DUMP_REG(addr) do {				\
 		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
 			break;				\
-- 
2.43.0

