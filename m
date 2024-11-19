Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA8FD591DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A63710E5D4;
	Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vtY7hhTH";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A704910E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA7BJXWLuVWL4K0h+DY8K8/iemieDAJP4hx0beviwkrVBWiH0CO36jPBUpf5yeLwmT1wpDZeG3XcToNC65m00fNcdzQN9C5pD/fQ9nU6NE4XRsVFWRsqMEochJHfn2Bcu/IKFMbhjrDYhgcLWzTi9M0QBf2RJidd2kALTb1RcO/HMknKRmZyse9e97bV24WqyThlrytOJGgbkQL1RQRVqH/88mPKcyrkcXYhlAbPodXtn4qdXpLTZrzM++R0P46zUJdSEQwOzVSzCPaGDg6iGCfoQ/33M7hSHDNxTo2pGfBTKuP7nPUZWpYhIsqE1bdtqtSvenCWAbbEGigDgx050Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yszM0rG9p80I5FF2hRMdLth7NVA+b5BNYo1uB5wKbew=;
 b=cr73P4JBP0yPPrgjZQwNb8KDnuGNl2/iRmPyHdduJw8gv1gLtHuR3sZmuoIoWF34KFry76d9CWi+FJPezk/1cv7zFJwzzj1e5PSU/eJ8a8/Ldj46wXPpPJ2Qm4RAmXvGf5kye+Lw7CSw4PjnCIgpByrS75OpgNWAxsgi12hYOGYWY3S9ADVv2j2wkmj0C+Qmc/4jDSVCKQa/egOt541zIeTRrX+VTNFjQ8N0yEqseabHJKF94zpr0IeMz8tksiR9Gk2M2Vwyxde1J2WdDF/syF3Jrj+ZWpmoC5cbhQWr9BqEsGVP//RecQVJJj2By/jClJkV8dX4EKXANI9ZOKgdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yszM0rG9p80I5FF2hRMdLth7NVA+b5BNYo1uB5wKbew=;
 b=vtY7hhTHcyuD+MlPygFVPLzInzt2YzJYjdTvtbyJwaqCi9ACVFYh0FK5GuPhPd5vE2OdNMgZsoJK2c9BTISHEzS3L79WjfQJQs78h4KlA84elx2Qie/C0oezpQqem+9KZajLB0zJ7wgu1jrrBIMDZsZsu2HKktQ0SsGRggngvUs=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 06:36:39 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::c8) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:39 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:37 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 13/21] drm/amdgpu: support to find RAS bad pages via old TA
Date: Tue, 19 Nov 2024 14:35:56 +0800
Message-ID: <20241119063604.81461-13-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c4ac38-4fe6-46fb-86c1-08dd0864862c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vE4dcye5gVMnEn1WL5fgsBK//MAjW9OaX9d4WI8I0EjQdOFuTrE4y96ejhRI?=
 =?us-ascii?Q?Gxvf9cldLiYJcdt+fswSsrANXYR25K4TAj9bkxKRdpc0LYkGi6OJ40kX2uUz?=
 =?us-ascii?Q?xavfwDdHZ2Bc6SRSZXLPc8jmM+RG4oVN2aE+utb+dPNaevuTET7z2cO2eStC?=
 =?us-ascii?Q?+4YAxtvVqT9Y/qYD6wfzsf0m8mkc/2WRdgcJ6k+j4R9dwG6KR/ZXM2ys9C4R?=
 =?us-ascii?Q?RB2kQi9GLFTFxV26Ry39RnP0u4Y00Yh4MsP9IRk04JENGKcPYB7yr+HlZC19?=
 =?us-ascii?Q?frYcBn0E67gorEuGvdkO4G2B9E/Tgrbboc774jEXZQJKZdK5fkZ1AqfRIjs4?=
 =?us-ascii?Q?2cpywNYOsU0Mn/g5ssg1Rq+FOt1DjMjkoJGHCleRKpUhpP1xWWBIzt9XuTxX?=
 =?us-ascii?Q?T2LJ0uMhHRzm8AleC1hCjE8ZTNLp/FtgKFhpM68K7tVF7gnBQep138loR3/k?=
 =?us-ascii?Q?ksGuEKT80L5Nao3B2bPzmZLdODCRRvioUffBWLF4hBvaV2oAyc4knknKvioH?=
 =?us-ascii?Q?kGr3UfkwRfkII55tM1OhRKr2GAUIzUJbmYNOqwUk66BXDdF0ehtNpE8FOetV?=
 =?us-ascii?Q?KoBJTeT57HWTu0woWB1VNvmldw4F1jh47GR9nx6Zbn2sazjJchW3XRDvsSC1?=
 =?us-ascii?Q?thIakvknpg3tifuPexo85JGjKBACKQWj15giMdnh6lrkzer1JR1hq/n5735J?=
 =?us-ascii?Q?WBjG2Gt0SZCZx+5RcAfBV5lzcE10iBmK8J+oCN+Mpu3vaqPYi8oFR73YKtO1?=
 =?us-ascii?Q?bmUtNUZAsfoVY+40NselJlFXiXkgahvsptQ0mXWLFDqFxhpzNjRr1WHxmcsm?=
 =?us-ascii?Q?58zWUMALUnU+pA0NKZ8icqlVtuhe+y/mJj3pNq8wHvB9inj5Ps6PFG/0fBap?=
 =?us-ascii?Q?9UdmciYPpZrgtOB8JyKQiLRsQYXG/CUbZreNiRdVPOcxY3vSQaOc1cNOEccU?=
 =?us-ascii?Q?zrVE+8/ayFcaSesydMKaw6IRobYpHZ3YNHpJ/ic4DssAZLokDnbvZK1JR8Ay?=
 =?us-ascii?Q?N5VUkAj2b9bFiqKbhwYFk8Rju1uaSV5utXfrs7ZK/6LMdpJjGOlF0/mB3FY8?=
 =?us-ascii?Q?bGnQkOevXKMktyoklysZuIScDJaAnJVPrxqop8OBiVHwXSuRMEm8Hub2y1fT?=
 =?us-ascii?Q?d3zrKlsNtFiWh8nN80AfoEm66X7S/Yzet3Pqh20q3CqZuersMoZx29bdhk63?=
 =?us-ascii?Q?Tlff8T9xgs8wP4NqrQeOr1K0XwZv5Xhz6dfWTeA0m8zWvj4mz6itM0oFEhOG?=
 =?us-ascii?Q?eN+Dyi/ZdXYJEar5ScgP6LIcajXlN2/c+MWRv8YoADfjNWqEvxRTyIlJjxHQ?=
 =?us-ascii?Q?xLHKicU1uAVsevtJb2LANUF5x2HVkCITa458d8F2f/OSIcewwdIZP/s3GNWp?=
 =?us-ascii?Q?MPYFwDB+y2l3BZ2wyR5Oh0r7bnIkOqscuqkl4B55tMvVdqcANw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:39.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c4ac38-4fe6-46fb-86c1-08dd0864862c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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

Old version of RAS TA doesn't support to convert MCA address stored on
eeprom to physical address (PA), support to find all bad pages in one memory
row by PA with old RAS TA. This approach is only suitable for nps1 mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 26 ++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c0a011a59d59..681b756f6428 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2703,9 +2703,10 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	struct eeprom_table_record *err_rec;
 	struct amdgpu_ras_eeprom_control *control =
 		&adev->psp.ras_context.ras->eeprom_control;
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
 	int ret = 0;
 	uint32_t i, j, loop_cnt = 1;
-	bool is_mca_add = true;
+	bool is_mca_add = true, find_pages_per_pa = false;
 
 	if (!con || !con->eh_data || !bps || pages <= 0)
 		return 0;
@@ -2736,12 +2737,31 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		}
 
 		loop_cnt = adev->umc.retire_unit;
+		if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+			nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
 	}
 
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
-			if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data))
-				goto free;
+			if (!find_pages_per_pa) {
+				if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
+						/* may use old RAS TA, use PA to find pages in one row */
+						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
+								bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+							goto free;
+						else
+							find_pages_per_pa = true;
+					} else {
+						/* unsupported cases */
+						goto free;
+					}
+				}
+			} else {
+				if (amdgpu_umc_pages_in_a_row(adev, &err_data,
+						bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
+					goto free;
+			}
 
 			err_rec = err_data.err_addr;
 		} else {
-- 
2.34.1

