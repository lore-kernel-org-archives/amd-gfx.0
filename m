Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730CDC3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E9510E37A;
	Tue, 13 May 2025 11:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7gHYHzV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5680410E375
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8sqFr9ISmWR2vdezxxXwJ1PfGQspiEmfhAcaPgECm48Hf5zkXF+xGWOepUKfZTa6TSWKlb2ZDNvWtFJugZCkJTpuSNn7Ino/EOAPYgO32Sn08bdHjRsILbnzUsfYmX4FDsIvsq6L+WLPbqszQfT5XCsZWNUhPheq40HohDCxsGUozPW2QBZAh7S5pjlCasapRT9uJKtjX72sP6q1Snk1xCLpAGtipc9xqG444TTQq3sQxYcBQFVyAXcD9wLVzEEcd6LJkehqZhOwNAsS4OWbiBomSYkZX/gMBqbtbSl7q5DYNG/i01/oJScX0UGujzBIMGHAWkBc5DTrp5zgbmryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yq+w0Idi9hN9+4wscypfWwdaNvcq21nv68FUup5CNn4=;
 b=GGiifY7JvTcTdew57FMY+hiGPztuSE/HRRtQnhQPmlUbTYZP0AMvWwhKaADPkz39LkuZRZbEDxTiuoegTSZGZ/sL0sUzxoPe5qvjnkwDqdIIJVitPvognTsoP1Tm++BejOZpM9xJQ4HqLZcUA3dRyhGmuIZk9UdW18YOmTZIDTAyZvk+67tOPvwz++pWgt33sdAlwWiEx5kOdJq21MX61ep/M2IKoR/SnD77dcVE2uOaumnbCJKaRtFX6aPWXfTJkIMMhSe9ofUQoyWt88fi1Yew9u3Z1yXmeilAZKFW8yLmxKB1WPHexNVLw9m7IIDXiiqSpDlqn2iVEpICYvVabw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yq+w0Idi9hN9+4wscypfWwdaNvcq21nv68FUup5CNn4=;
 b=Y7gHYHzVRmykqIPMMGgDfk1Uf83/ZpV/zNj97g/j6U1p4rvrzeOozSKa/u7rdGmOgUWME496xEsjNUgOpCE2tNe/g9VJkykLMVDsgyLgPI7yiHGy67oIE6FGa4VloNsvD4Yx+/TG0e8jKHCkBVAuCcUdia6lw2Fhlo6mkPUiuYg=
Received: from SJ0PR13CA0200.namprd13.prod.outlook.com (2603:10b6:a03:2c3::25)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 11:22:06 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a8) by SJ0PR13CA0200.outlook.office365.com
 (2603:10b6:a03:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 13 May 2025 11:22:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:22:05 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:22:02 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amd/pm: Update pmfw headers for smu_v_13_0_6
Date: Tue, 13 May 2025 19:21:38 +0800
Message-ID: <20250513112139.88355-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250513112139.88355-1-asad.kamal@amd.com>
References: <20250513112139.88355-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: dbde23f4-ce5b-42bc-f744-08dd92106452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K+nXRKi2WtOJcyTGQKJUNUUJNMDz3Ea+jpTpAckapM+cocAM1kF/OOm+ThvG?=
 =?us-ascii?Q?GiRN8W83Rkt2DrVTqpxmS51gLQRb3WrqY7lldpKpGBgn5gODwZAmetbHnpJH?=
 =?us-ascii?Q?EF6PA8cnClfOapsG+Y+lsIOiKL0Lc0pCcK1eWa+7amCIr9N1TaXAsbxfUQQp?=
 =?us-ascii?Q?6mU4iX/7yOkq2A9j2tPMuZsR74YbE7bLSXdaW0MvVJr0Hz9+MjiEj/L3qFY7?=
 =?us-ascii?Q?70k8X4Jc8ZvKJDmzFLofQb8eA95JZb4EnotsdrGvI5IuyUDsCwgJMKFYT/3J?=
 =?us-ascii?Q?ixQ+Pj1uB1bjQjoMvp3SnsjmcEREYtGA/ONJerEDzQ8mwuGAK84g9D9+uyNI?=
 =?us-ascii?Q?UCZlfePtcTJu8y9PZf1D6tli6zGvC0MQNV7E9i0htTSp9eGAkla2eraT6lnA?=
 =?us-ascii?Q?v04GoMaMGX+Ash3XNbEd6VNx/SqbC4gyrksQ059fDp0eQU3M7yhEIa1eSbvF?=
 =?us-ascii?Q?DRi57ObJMLQZ83TvNjNEJQRAvWOIBuURwYYQogHqD32bZvFIRMCkteNcKRZB?=
 =?us-ascii?Q?eXgNYPk5JPajamHI2NZoALuRL3/LowS/7C7qd+fa2MY/Y65PyaBNEaoyDFn6?=
 =?us-ascii?Q?P00l3aex5OTvt2kY0fzGY1PO35gk+Pqj0GhMfCpFsiZ7yz24kfmUJPQP+hNk?=
 =?us-ascii?Q?CaEBq+EFGz0kHr+sxykh2M9F8Ms4SsDqStawyl7zHN7ABcZ4bb8E1N+sXL/O?=
 =?us-ascii?Q?DK/YTO9Kuwh0DHZN3f2YyzlULbck47FtVRDOuSBYR2X7rKjXTqRcHKxuK7fa?=
 =?us-ascii?Q?6Bk7KX6KRNUTOC4wLWN5SlAM63KtV4nqQyPnG5gtztQ8hinkAMllYbSHZhak?=
 =?us-ascii?Q?Cm/J+YFoGvGEKlcoPB92fmR+uQwOSj9PPgxAb4Pj6oAwvgIzToXe6w6f8Ts5?=
 =?us-ascii?Q?JQYgwYRujRMl+pwSHmLgSt5w7pVmBkFf2MzmEeVMJdTNvUMNAuA+lz1OPpO0?=
 =?us-ascii?Q?pu1GiNBTHShb2jW67jrMumDlnRVlahrQfRfzW/RbCIELIbAemFvk7SpLPRFD?=
 =?us-ascii?Q?XJdPfGUcCKkJCDR6J1c4Ln+f9Ved78t0lGyuK++cv0VfPupFKyKLZyeWWGJq?=
 =?us-ascii?Q?HDccajZKUKw5c7rTeVGmSyyEPEMcJ7WojxzUKeGmbr9EtiKtNQMpzDAxEpF8?=
 =?us-ascii?Q?tlwVdBMzjwhQHNl3UohNeqJLrQWv/Ju+KKle6SULU57r1pkHzCJHotIGVpax?=
 =?us-ascii?Q?f1xfWwN1dmLA3wTWuMirEZL00n2sHLZBYZ54SHzvnYSeW2i1TqaNZGy9bMpb?=
 =?us-ascii?Q?8oYceW2bNf//zqdQmpO9oqOSWyFQDZDQj5ka43hgG19vKApiUHADJcquAjWo?=
 =?us-ascii?Q?xv0Tb7AMc3/liua97mL0CEaXdSXxoaeeqfSE67l5emx7NHfDFUTRLg3hUkv9?=
 =?us-ascii?Q?i/vi1GwurKxYcKaeva0g3T7hJGdXVD5Y0hcqiBGKTH0K1bIf+chiUdDNICEk?=
 =?us-ascii?Q?WiByRXtr6GtzaKH2hHxzpouMLLk1RgV27V1hOu6DRI3u1d2+HO4gWC3TBQOE?=
 =?us-ascii?Q?PXxE4AoTq2VF64Md1/QxpaCXfKKOdopmLKj+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:22:05.5403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbde23f4-ce5b-42bc-f744-08dd92106452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

Update pmfw headers for smu_v_13_0_6 to include pldm version
as part of statics metrics table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 3d9e5e967c94..01790a927930 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -127,7 +127,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x10
+#define SMU_METRICS_TABLE_VERSION 0x11
 
 // Unified metrics table for smu_v13_0_6
 typedef struct __attribute__((packed, aligned(4))) {
@@ -463,6 +463,8 @@ typedef struct __attribute__((packed, aligned(4))) {
 typedef struct {
   // Telemetry
   uint32_t InputTelemetryVoltageInmV;
+  // General info
+  uint32_t pldmVersion[2];
 } StaticMetricsTable_t;
 #pragma pack(pop)
 
-- 
2.46.0

