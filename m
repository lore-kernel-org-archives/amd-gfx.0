Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13949CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC56010E386;
	Thu, 11 Sep 2025 14:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sppnjrmM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A57A10E36B
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIz8AGCwxxdjnGLQgQR4q5fkvNDOi8jkHDqoBXMOAYhdRFznaDIEq0/fhwn1wFcm3mZzFLDDpyqoEFi/pXxlOxjq9gDtFvf23zRSyQdG71IXgAA7D4gdZS+csTBpJcFgKWIzQqYZHaroIhT3yrYVOi0XeQEWmd4nz1oBrbkwYZ53PMIO/LMHCbvs7b0XaSW4Dol5lQZi3K3feF0bCOvBvYcE4zuZh52byDRNsaR/IGxdSprCHS9tcDbBukIC28gxuEfgw/3EsubbeWrPYb0L47ZoQpMd1gW7M5qjWqX7107Kwi+JWD3yKUdd9PxotQUIW1LUlTccvcbfyyHtxVOkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8idCVQw+IVeJ1ldHxLGcSZyLHl/4hVAuPz5+rasTYrw=;
 b=hfzdREgiLKTvhM8S9iYiGXY8w8FZCKchhCWhuF8XjOR8HxNHmzdJWfDJsYehspNNCNINDHl/q0//I55zaAKrmP/9nft6+K8QWD89s9oxG4PcAdLGG3dtkrdYIeMTzsU635KRlJSa9KjTLdAmcru96KHUEe5zrFlAjyfRve5uNYemtHfaveOpyOnl9ci1MxwoIReLkGTE87GQPUf3dFdFLaNnoj1YtcG+DeBFWTDyBqDU+64UJnZYKh7PpDiot44KosXslqa4Gkevmnp6gC+K46DypNot9CacZy5fpPdeDbRp+nfS+v/uNzGFwmq4oiD3CqAgrWE7fBsmzmGy0IUAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8idCVQw+IVeJ1ldHxLGcSZyLHl/4hVAuPz5+rasTYrw=;
 b=sppnjrmMgISNIT4SxtrFJk+fSqi9X31jhbCRIWr5SNtqSm7fkXl8nZglnTe0Ukldgrb6dzoG/PyudRuo/gK3vXOtOR26qTHF41eswz2/t3Exb/NtQqdAf0By52fHIvXpkHlcEDL9lDCZDGxFwLtxjCjWhAMa+e0oTlN2hOAt6g8=
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:46:27 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::bd) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 14:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:46:26 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 07:46:26 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/sdma4.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 10:46:10 -0400
Message-ID: <20250911144614.3338953-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2961bc9b-f17e-4695-e140-08ddf141fc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xFa7SCIJu1pq97XnIFyNOud2n1C9tuAwAle/IwDkfMcGm+dUZKwGijCCevbg?=
 =?us-ascii?Q?PdwY2cfsQqWggXh9Qv5rSJRlDN8Vtye6eq7C8fsMPgKKuE0lrx4+HRLO8QNa?=
 =?us-ascii?Q?fsdwZ6gunXQkRf2OhxKFw9pj/FIdO+zFpZ9xjcgOpagWDVMkLFbfES6oMsTy?=
 =?us-ascii?Q?A3djkzSlm0augCCnxsrM2p0klsrpiY1eFw4aLTRSPicThkrPnnioUZ6nVfRy?=
 =?us-ascii?Q?uZAuVEkhLky+2WEFJIjsr7/i3kVLU5WeBg3bGdwxmgVa+Ul5wtPQjY6H7O5t?=
 =?us-ascii?Q?L3xsTAkSru3f6ySidNDpWSJdLAnI7s4a9X9jbj9F/ldoBEJMtuyPpld8iyDR?=
 =?us-ascii?Q?/RuiFwnDrAtiiaQkVxKT0EHbMzn6U6uODOkEHu1Roji6IFoYvVzGgJFVPRMk?=
 =?us-ascii?Q?m9R+bs9OwoMsW6lrYzAXHgw7MQkWFfAeEvqYvO1j492SOKQBFWKF+h7OzYlk?=
 =?us-ascii?Q?tK/MAOpLTx+tfPim9EE4OI+W81qJkNUOgQwj06MkrM9FGZ/MhnUb9Xv242Ce?=
 =?us-ascii?Q?ZDu2GQ00ShM21yJ6VJBJPqXU2lN5fikgtpzQLRDdzVwpfUmQcp9gwDNgJNYq?=
 =?us-ascii?Q?Bd3HNnfvyifu965dFX5/wV+ImowFo2WwFrRJmf7nqCvL6hPX6lLDoqm9IQGF?=
 =?us-ascii?Q?Aq5ixGxKm+8CvmmRvnJVgeWRU0tt+orKMHawj61oSVD5ID6hytJRXOVHz0ZE?=
 =?us-ascii?Q?nTOFfDZkUIu/ANNX2UtZu6f/Hi7xRdSMv5C84e7DKAMJv7ecvDtdgLBjZudZ?=
 =?us-ascii?Q?IYpOU2t0+Iz5GzeFeRhXbkLes9yCmqFT34LDmDVjtvqGVG2XjX83QOwsZJ07?=
 =?us-ascii?Q?/bo6yoUgJ1yYCV5ra2EhPgyBeDi6l3vyU+mB2nSY5ig7a9DHGw+xECFibUAw?=
 =?us-ascii?Q?Y18dew7JRkSH3LLHLepxAQ+laVHfmXWNi/aq9+9/1KJynkbk4yifdvJH8R+C?=
 =?us-ascii?Q?/k2gHo/OnvRRZhVrTqEwH/ysLg20TtOX0gHY3Iktu7PqSHiuPxMIJLVzGpln?=
 =?us-ascii?Q?jXZMsaYVWdm6TzZnDy563+rf6BKSUp9hmcTnLdMJnxssV5TXZ0NZmwszo+fn?=
 =?us-ascii?Q?DtiqFelDXxkswX78ZmOEw4moEAVRpTJxXjD3KumR6/paiwQ/0Li0KsPsBT0G?=
 =?us-ascii?Q?SWZnlGV2OX2jDG05HprKFhZhxIkFmU6i8+vZch2YPLcpuMSho6HJzdGcL2V1?=
 =?us-ascii?Q?1M0ttixD5gDKN3Epw10JIBa44qskn1cVeW5ivwnW0lvp4U3CFlaK+xXVlkzq?=
 =?us-ascii?Q?gDN6/2UlqrCrSZD404bG8PJp987pRuL4Hag3X5YS/8i4adSZJA7WV2MS+wNN?=
 =?us-ascii?Q?apSQlgue6mQ1Hi/YAgfpOpL/osUphpSuDVVeX4antJUP1EL2FNGBS2TnoHh8?=
 =?us-ascii?Q?kX8pwWMLEIqnCPuINP3A+l3fgPHMXIpZdSVIMno/W7e4pDFgB2U0gNdu63KY?=
 =?us-ascii?Q?k2JSMMoa8LCZjmv4h5GPaZMyac2fFPnPs8Bwi9uyiCTADNigN+vYj35M84J9?=
 =?us-ascii?Q?+kt5+uB7bWoUGlhmqxNXd/jngLazyOMOJSPh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:46:26.7983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2961bc9b-f17e-4695-e140-08ddf141fc87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

SDMA 4.4.x has increased transfer limits.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f38004e6064e5..cb6e6257c8fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2606,9 +2606,22 @@ static const struct amdgpu_buffer_funcs sdma_v4_0_buffer_funcs = {
 	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
 };
 
+static const struct amdgpu_buffer_funcs sdma_v4_4_buffer_funcs = {
+	.copy_max_bytes = 0x4000000,
+	.copy_num_dw = 7,
+	.emit_copy_buffer = sdma_v4_0_emit_copy_buffer,
+
+	.fill_max_bytes = 0x4000000,
+	.fill_num_dw = 5,
+	.emit_fill_buffer = sdma_v4_0_emit_fill_buffer,
+};
+
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev)
 {
-	adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) >= IP_VERSION(4, 4, 0))
+		adev->mman.buffer_funcs = &sdma_v4_4_buffer_funcs;
+	else
+		adev->mman.buffer_funcs = &sdma_v4_0_buffer_funcs;
 	if (adev->sdma.has_page_queue)
 		adev->mman.buffer_funcs_ring = &adev->sdma.instance[0].page;
 	else
-- 
2.51.0

