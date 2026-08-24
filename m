Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB080C61DBC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FB110E879;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6y3KNsN";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013059.outbound.protection.outlook.com
 [40.93.196.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1488210E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ja2ALWumvL6HU68846X/m9ZtvZ6LEP47osC+p/wupS7k+TZikf8fkEAKKqJsdp5llUrNWeJcAXodaP5XB55Nkd9Ne9bNtnk4mGE29cCY1EK0CeipiuUpnWxjwS1R1MXiCNoucjw6Y3j6LByGc1VEQkkIvLjKh/FVvT68enfSmPurdmkE3jaziFnj8yqwUKDN3SRZjl7kaJ3kLIkfd/5D1A2Hqxn9X5yYeAhsu7z5hmR1Hz+66b+8mXLG+Zxoo+tgL2+GF6wgzIStdx3Z4FF1CiIT1uZFP6c5l3RxCUGZ5o30Vb85uJi7thIiDG+YLQeiJ/FVEOjYNsqtNq23HquFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFv3TDGl8c8AOSbifSatSoez5ILbuhkmSBUuMTe88Z0=;
 b=rIPGGq1cEjARhOjzmxbxzsz5ItYM+t8pRXsQndC6aXBswsRr41iaAfuVPW6l78Rvx5N1jH+LCc8i6I4d7sS8H3n4TtHsU1qcZs4q1pZRN4SW5I0cTcz3AHFaQMYuyVwKdVW8zT2GtcqXmuJpmsYx78IkikRHlUK/G/bytWfHKTEXz/vqaIAiAJInuG/yy4CGXkkhn6YLsGVosJqjlIz3hnBc6WPBYLhdUPRJU6NnhT6CZ2gsjOy89/wyjKHvIHM3IDGOee3U0GEoNJHdEE7f9fb/gYt0UitJmSE2pplOfcR5AqyP/ETbKjBU6UiU+Om7oS3tiNL0XBXRr8mLFwA60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFv3TDGl8c8AOSbifSatSoez5ILbuhkmSBUuMTe88Z0=;
 b=S6y3KNsNRqdzqHu1T8trE49Sl+NVMdSepGhERmib2NnLiWNOeqRIs+FVNlNYsV/IdzRe/X2VkfT3h9tlkdZHNxjlca2A8QeNPRAF2dshIX54vS3YKK42tENIDGvlJ2BlXKFukMMwf5k2tg4w4A+Z6dojgvAKf9VtxdjKLBoxQb4=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:21 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::4a) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:16 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/30] drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
Date: Mon, 24 Aug 2026 18:13:45 -0400
Message-ID: <20260824221352.1793542-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: a1417a8c-f762-468d-85fd-08df022d0c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z+c9KD+crGj9qbN8sWgIAetncMNFDPknH/0a9foJ+/P9GfsjGLeNtJbjGAmGn7h3H5XHa+E28BcpP62hlI6DTgR2yFhQ6Sn1MO0Jmog6xsciIsyQLomh4t1EEyl06qFbAjMBsRqPrBCQ2uloz0g6mp/QHONlywZnU60sljcZTXx4gS8+JKGPS6o/HCrR0IZXhR0IkGFWp6Bl7V5cXjGOxPNQS7vZ5NRsy4L23jhOp+xfWDfhT0fCRx4orpizFX4Dd5t/GDMIY1Ms+1J8zt9N1kMXHUbhXRhQIoJ/BTaWhIW8LdpE8C+2d9VVV9kqBTuAZzi3hplopsWG1wlk5vuMqz6O8bVyFauicKx9trs6vhPEgeLLR0nLLpJ4aFw59uZTXVx3IJgBsBhT/EsKrsIHdC7czouRORCgOlvGdhkN+LdavnoYTOV+Ns49NMVXEEXc0ZEVBY8VfRaaXherXDJzlPUE1hIpa0/dGocNZHL/XoXV1FCLUTVKWhAMU9+eOhAvb7DF30geVN/X67xxp2klhwIMPO1ev/pfIGECoJXWA8xwYKhB0nfAQaEhQM/v1iSbFdb3ga4RhnschBzFDRk2uKbe+ClH1IRFNrHm5SSOTWseXAjM/qU2kdvKzitJG3WDPPbpbkhuLR5jLgXGigkU57Sq4tuT0zGeZfSmLnwEIKAvsSieVOMQnalJP0dj2bcspZyuXJvRs6OGUWM3nP2d2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O6sizAgfvsvQjIdofsxR3iYaZ2HADtiG1P34dFOpsHFV7aL5YqyisqozLHIMaPkjlQA9hCx83Y2X/b9aoRIOXxnkbSAKal0jU4SEM2SkYnrULrWDLlwjeUJSw2YWEziaAd0wOgzVxsdC/HCPfPlc4fi1rZ8EEUEu+6+Biy6+yrN1PS4QbfZh50Cttde4WcWEDNlssYGQgKEG1vHtEGUBL/+SGcVBI3oGVkuZpNrEiNGjzIYiMmxSlTK6c4x8XDxiKg+EqR3ZtrtO0RdNCrvzxYx7aBV5PfScIpwrrN4+IhVNanAuvL2OEIoiqgQmkYUeCQfc7Vnd6JOdg14DDQk1g+LZLySyEuxXcOZOZDdtv4utoJo3kOxfe1sW7V6O0NuZnQu0iAImBc6vtPcMTmMOi3M73U0gcT4oG2U1kxiL/vXDiNhoAwN9ESI9SwoKCP72
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:20.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1417a8c-f762-468d-85fd-08df022d0c00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e7c529620199b..7eb34d55565cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -976,6 +976,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
 	if (adev->gmc.flush_pasid_uses_kiq)
 		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v10_0_init_golden_registers(adev);
-- 
2.55.0

