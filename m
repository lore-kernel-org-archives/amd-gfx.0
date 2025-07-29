Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC28FC87FC9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 21:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8488110E29D;
	Tue, 29 Jul 2025 21:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NppQQPd5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E311810E29D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 21:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCa7SKPmOdzeQRLT09HU+/fCm1uhrrXVqfElGV+guUGLBgkGJaF1UB6xZSxVAJx2b6TCevE5LNXTfPSc4W282ZLBpN+/WKmZEPKfSkEbA2GXj1Odr0inNjfLdhoOnK9dLIS7wwGO5vpzWKI0GJev3Z8PeG7lJXQe7rqQsvnQk7QFGj2xAe5eLZEAKn0Ng3itrrLi7c5UKHV3zS1fXzNC6zGixafosrfM4MMOzDzpVZF+4j+MNEdkbbd2NVDdou4D+f0LM2dB6xqkT1mBi3jinrT0EThVpKdbLrcCl9j+ruvRye6Gq1+wZ05RkFqvmiSg3FqXfUbiVrWU3TInfmMl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzV7qCmiIbTzgAvmo30cytm+NlCur38UpDM4hLWVeE8=;
 b=HjGnkNV1zvPo1t5E0FSQVSlfCoI7RnzZ68U26EE0W9jK3C6TNPuvl3zaIA85ocJEbMH2gV+YOQymFVB3S2bELhBST8d4VnTU791c3qMuDn+lkB6/2GvsX7IfMYS7BKGvv83RPyDgM9aWWQuMV7lZuqAanzp19gjo+SAor9jgHLW+SIFQGqpvZ90XOoAymlHfGyl5u6Ibymzn7qDR/0Z44SE/x5J77RXxtVlfN4ady/5uAS1nty4IuzlfbC6KOB9bx2E/Da1JissiKFAvDvP+O8epDv6v9jxgDpu/LUtgYIXzHBufQHxL3LWAZd8hYwtrjF+HzBTbYlSRAtyMR8hjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzV7qCmiIbTzgAvmo30cytm+NlCur38UpDM4hLWVeE8=;
 b=NppQQPd5qPHMawF4OIwFTsH0x0UKFRy//3QGnaT/vyEzjSOJZDl77cyht1mXTg6mfsMWCzHc/6kuVX4ABFHmTVePCQfwyIFbvYfRRT964UxDF3UjlJjmwOhaymT0jsJxFerHmbNl+Zfb4EcGib5wIIzaP/bFueRMlCkvX49rB/I=
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by SA5PPF0EB7D076B.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 29 Jul
 2025 21:08:10 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::9d) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 21:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 21:08:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 16:08:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update mmhub 3.3 client id mappings
Date: Tue, 29 Jul 2025 17:07:54 -0400
Message-ID: <20250729210754.2304695-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729210754.2304695-1-alexander.deucher@amd.com>
References: <20250729210754.2304695-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|SA5PPF0EB7D076B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4c7e86-d2cf-4831-0a04-08ddcee40595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EqgtRo5dnzB/x2L+7zW7ZZU0zYB/IVIRwb7lu7shnNz9ou2SQ1TlsDP/PxOo?=
 =?us-ascii?Q?Hh/ZASS2PyTc1i8Nj+N9fVh2BRs3f20hdwD6jL9tEzdNkXGliYsXFC4PWej4?=
 =?us-ascii?Q?07ztduiKNRxke/8O31QbEVknyoTEECfGZAIgo3T0Ory+LscC0y8O6kWb3X2c?=
 =?us-ascii?Q?laxPs1el31dhMJVXwYulcE4VzoWBWfPRU2UMXL+DsD0AuDxn4ETDP76m19mi?=
 =?us-ascii?Q?hJvkVrSuPz+/QnMN7YHPIHcyhhFzEltw4j9t0bKfWRu3zdupGV6IsCzW+IIF?=
 =?us-ascii?Q?qfK/uFI0k+zDZSVJIDuDK89P4uW8D2jl5aMECKUoxiNXQl09O3wr+MB3oQzL?=
 =?us-ascii?Q?DI5Os5zmLDlj172u+MhjSk08gXKRvxu6zmNnzB+jnBrMfdAn9DhhO9nsvQhq?=
 =?us-ascii?Q?p5QcQT2eveZKXwgL0SmbB41DAA9CfsI9iW2AUd841oOURlL94uHUl/B7hxPb?=
 =?us-ascii?Q?hzYD0S/KhNWwl3/dEXzNAhovAfVyr9zr3wF2m2DHQCJPYVgOr3S3OdrBmcNT?=
 =?us-ascii?Q?JoZbY++Gsj7zpsaOKLIIUNbtAb/FwKU/fBD7khB7EtLJ40xTuNqBPi/ho6bn?=
 =?us-ascii?Q?ENj+/otNFg28Z575vRxmtokIUA19AcQdntOtZwPTUu5RG4LVlIJUGXgvFrYW?=
 =?us-ascii?Q?0o7B3OS3gEOD3bxm0os2Fr3++NKe3IF/uZG+dD/UswrZeEM+fehMBSrl8YqS?=
 =?us-ascii?Q?JtbNOU4ucr/kveCx56kVomF9fHIGVHVHQrwtYUrjGt7x3T4Z+IDk3IqiBKa1?=
 =?us-ascii?Q?6l32EO8cxiOz7wt8pN9UEpd7wWRHxVdMPWN4k7ffY6MeNFQ+mZ2truJpYEXi?=
 =?us-ascii?Q?/ork7QC77I/A3l9Qdm1ZcsTlkM9riM3/k+j2ejeq55nqxNgY8AAQuV1UyUnw?=
 =?us-ascii?Q?bX7YaspL0xeYPuTsm1DGIBOjnzv7FrLq7CfOJIuqLYE/4eUIRil4ygl+e9Ep?=
 =?us-ascii?Q?QBGwRX+FN0Wf2/bDaSGXQE1yg8pjMPB6Fy8X0S50ZuzZ5A5zbvIEpnaF+xFa?=
 =?us-ascii?Q?5sviwUJo7jrBw+jycdIrc0tCsh3NG03et2ba4Zb9MNYj6PmV/U/Mnxl1HKJY?=
 =?us-ascii?Q?01zW9X+FlhBo6a4ftJJjBJIcuHM+m+rhNe1q/J6uvU/Sa/ur7aG4jqkDoPmk?=
 =?us-ascii?Q?L7RdWuu+dT4FCb+ZM18QCJ1AWg+yZpHU4M28HK2JIF78UlwQmWOnMS/lEsk8?=
 =?us-ascii?Q?1ZQ7jcVp9otTrQutJDbJ5xkU2h4PK1UzN7tlf5cTvswR8P5Bd9kxRIZCmhu7?=
 =?us-ascii?Q?vUxOf72UNFAgWQoWrTR3iPPtsU+kWeRZBamHtUNFeehLNb5IzCSbgNQ20hMq?=
 =?us-ascii?Q?n8pprCacenC7vvjviUutm0q0Q+XExl5t2HqKddSnTbO68VbEjSfTebSYRvCc?=
 =?us-ascii?Q?oAaCfVVYcm5SxgVPYRc3zphA65Io9FWUgz/d7Ig/2dwvG65ZNRJmKgfGm9Jy?=
 =?us-ascii?Q?b/8w/1IbM7YUpqUlsIBWurh0Q+F3LNd08Qxb+EXfQH+rCZqxkOCHYjeeDzfy?=
 =?us-ascii?Q?SEFqyGv6y5cLnEG9kgd4YN873AuV3WqFl+0H?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 21:08:09.7577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4c7e86-d2cf-4831-0a04-08ddcee40595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF0EB7D076B
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

Update the client id mapping so the correct clients
get printed when there is a mmhub page fault.

v2: fix typos spotted by David Wu.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 105 +++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index bc3d6c2fc87a4..733bc76a0f3f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -40,30 +40,129 @@
 
 static const char *mmhub_client_ids_v3_3[][2] = {
 	[0][0] = "VMC",
+	[1][0] = "ISPXT",
+	[2][0] = "ISPIXT",
 	[4][0] = "DCEDMC",
 	[6][0] = "MP0",
 	[7][0] = "MP1",
 	[8][0] = "MPM",
+	[9][0] = "ISPPDPRD",
+	[10][0] = "ISPCSTATRD",
+	[11][0] = "ISPBYRPRD",
+	[12][0] = "ISPRGBPRD",
+	[13][0] = "ISPMCFPRD",
+	[14][0] = "ISPMCFPRD1",
+	[15][0] = "ISPYUVPRD",
+	[16][0] = "ISPMCSCRD",
+	[17][0] = "ISPGDCRD",
+	[18][0] = "ISPLMERD",
+	[22][0] = "ISPXT1",
+	[23][0] = "ISPIXT1",
 	[24][0] = "HDP",
 	[25][0] = "LSDMA",
 	[26][0] = "JPEG",
 	[27][0] = "VPE",
+	[28][0] = "VSCH",
 	[29][0] = "VCNU",
 	[30][0] = "VCN",
+	[1][1] = "ISPXT",
+	[2][1] = "ISPIXT",
 	[3][1] = "DCEDWB",
 	[4][1] = "DCEDMC",
+	[5][1] = "ISPCSISWR",
 	[6][1] = "MP0",
 	[7][1] = "MP1",
 	[8][1] = "MPM",
+	[9][1] = "ISPPDPWR",
+	[10][1] = "ISPCSTATWR",
+	[11][1] = "ISPBYRPWR",
+	[12][1] = "ISPRGBPWR",
+	[13][1] = "ISPMCFPWR",
+	[14][1] = "ISPMWR0",
+	[15][1] = "ISPYUVPWR",
+	[16][1] = "ISPMCSCWR",
+	[17][1] = "ISPGDCWR",
+	[18][1] = "ISPLMEWR",
+	[20][1] = "ISPMWR2",
 	[21][1] = "OSSSYS",
+	[22][1] = "ISPXT1",
+	[23][1] = "ISPIXT1",
 	[24][1] = "HDP",
 	[25][1] = "LSDMA",
 	[26][1] = "JPEG",
 	[27][1] = "VPE",
+	[28][1] = "VSCH",
 	[29][1] = "VCNU",
 	[30][1] = "VCN",
 };
 
+static const char *mmhub_client_ids_v3_3_1[][2] = {
+	[0][0] = "VMC",
+	[4][0] = "DCEDMC",
+	[6][0] = "MP0",
+	[7][0] = "MP1",
+	[8][0] = "MPM",
+	[24][0] = "HDP",
+	[25][0] = "LSDMA",
+	[26][0] = "JPEG0",
+	[27][0] = "VPE0",
+	[28][0] = "VSCH",
+	[29][0] = "VCNU0",
+	[30][0] = "VCN0",
+	[32+1][0] = "ISPXT",
+	[32+2][0] = "ISPIXT",
+	[32+9][0] = "ISPPDPRD",
+	[32+10][0] = "ISPCSTATRD",
+	[32+11][0] = "ISPBYRPRD",
+	[32+12][0] = "ISPRGBPRD",
+	[32+13][0] = "ISPMCFPRD",
+	[32+14][0] = "ISPMCFPRD1",
+	[32+15][0] = "ISPYUVPRD",
+	[32+16][0] = "ISPMCSCRD",
+	[32+17][0] = "ISPGDCRD",
+	[32+18][0] = "ISPLMERD",
+	[32+22][0] = "ISPXT1",
+	[32+23][0] = "ISPIXT1",
+	[32+26][0] = "JPEG1",
+	[32+27][0] = "VPE1",
+	[32+29][0] = "VCNU1",
+	[32+30][0] = "VCN1",
+	[3][1] = "DCEDWB",
+	[4][1] = "DCEDMC",
+	[6][1] = "MP0",
+	[7][1] = "MP1",
+	[8][1] = "MPM",
+	[21][1] = "OSSSYS",
+	[24][1] = "HDP",
+	[25][1] = "LSDMA",
+	[26][1] = "JPEG0",
+	[27][1] = "VPE0",
+	[28][1] = "VSCH",
+	[29][1] = "VCNU0",
+	[30][1] = "VCN0",
+	[32+1][1] = "ISPXT",
+	[32+2][1] = "ISPIXT",
+	[32+5][1] = "ISPCISWR",
+	[32+9][1] = "ISPPDPWR",
+	[32+10][1] = "ISPCSTATWR",
+	[32+11][1] = "ISPBYRPWR",
+	[32+12][1] = "ISPRGBPWR",
+	[32+13][1] = "ISPMCFPWR",
+	[32+14][1] = "ISPMWR0",
+	[32+15][1] = "ISPYUVPWR",
+	[32+16][1] = "ISPMCSCWR",
+	[32+17][1] = "ISPGDCWR",
+	[32+18][1] = "ISPLMEWR",
+	[32+19][1] = "ISPMWR1",
+	[32+20][1] = "ISPMWR2",
+	[32+22][1] = "ISPXT1",
+	[32+23][1] = "ISPIXT1",
+	[32+26][1] = "JPEG1",
+	[32+27][1] = "VPE1",
+	[32+29][1] = "VCNU1",
+	[32+30][1] = "VCN1",
+};
+
 static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
 						uint32_t flush_type)
 {
@@ -102,12 +201,16 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
-	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
 		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
 			    mmhub_client_ids_v3_3[cid][rw] :
 			    cid == 0x140 ? "UMSCH" : NULL;
 		break;
+	case IP_VERSION(3, 3, 1):
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3_1) ?
+			    mmhub_client_ids_v3_3_1[cid][rw] :
+			    cid == 0x140 ? "UMSCH" : NULL;
+		break;
 	default:
 		mmhub_cid = NULL;
 		break;
-- 
2.50.1

