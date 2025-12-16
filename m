Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7673BD637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E4E10E892;
	Tue, 16 Dec 2025 21:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v22r098y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F107C10E88E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWNS5q02It9DBy9fBnMtUaLPir3xL3zyRhlvfyqsfdfd7l4/tg16S0nAflRLMRwQW4WkqgfliksYZUqsvRDCMEm4gpaKYCJAkWrWYRnDEx0Jy0sfg5q0xVJj2yoNSzXJ68VgUpA/Yu4KDU3+Npueg0+a34ZqwxKB9fCd0COlCgqrAqBfd++4Rd8QmtSV5iXT5DMCKEOQmtbxObbpJLlkkImOKe1s9P8bp8gLTAVxZLqk3RTsK+86e3x0Ml/D7/YQR/0GWCN55TUC695QsEw395Q4RiOt/RJFGsrz7ZDsegziBSLfZgDTPFWuQkLB1Fh64UBL6tqBjN7oa778EEkseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LCPQXqhOzowD/1ELNtffAoFqGhxoWxUTrALBd/ZG9k=;
 b=XXGM9t5ALt7GN9dOZF3R/Izhak3e0tHvJnprxFUgw2+kJHzerP6lj3RDRW2XfMDvQ9A7/oKsj56B6lD9rJPd4EtjedQAHUncSVORH1AhFcDrRQi7PWg2hThdxAsjJPnybC9dSY7l4tn6tTbyNxx/N/03B/bSXIKkf3peKlG1LG/hMrBF9jCG+km6lbDYGCJovcJqwb3Ftcuj5rdBZHLADCs/oNKWz0uZJ0ycdIAFjCe3hpIkIZZSm2g4YdCIwnTV7UBkhHGXIuECGzll5vOhVY12PcvXOa01mzHu/b5uEfbNdaKRq2BUNF0zrzwwVV3hYOIr/RzfSaiDa0wOXifpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LCPQXqhOzowD/1ELNtffAoFqGhxoWxUTrALBd/ZG9k=;
 b=v22r098yeIELgqCvHJ3c93PwSC9Qjy5wpafC4VHLiwCqPoHJqNiTr4s6XzhbUfUseK4Dhm/cZqVyAzCT81ntK7dxKYhUudIdfiM/Xe/8azEFyFAHZmLXJLRE5gptv7ALnMKdoxsFtYRTmw1WPhgALjEAfnn8kqGasLK36uKdVsk=
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 21:04:12 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::bb) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:10 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Disable TCP Early Write Ack for GFX 12.1
Date: Tue, 16 Dec 2025 16:03:36 -0500
Message-ID: <20251216210349.1963466-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 330ec527-f429-4d9c-a62e-08de3ce6a888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M+ysJw+DqVMsoEYIe+hwpH6+OctgSgoEZiCp9qXqgMdHFHIo+lvs/nd9RSQG?=
 =?us-ascii?Q?PNkpQvFZnvYl348HXWiX8arLxyVOsrfHRbuQ0NAfLTC/a8ZSSwJkvEY3DjME?=
 =?us-ascii?Q?BYS5MEehbYE7P2Lxd3zDESHpZkl7+W2fIS9FyN8ZvQJ9utGCshFC9sRkzlAL?=
 =?us-ascii?Q?Yi1w8qj7A7QPuJG4qpkH3X68tcKK69zTt2s8FtUVYUDKnPlNZNYITU8nvh4E?=
 =?us-ascii?Q?yhenSfVjJVImIfDrVetq+niQAzzxxEY0Vzm8H/IrZpHOylXykIaAmvqyvv9A?=
 =?us-ascii?Q?sKs9RF5e1ZWnVoivcORRwtN9WUAYUY7OWebXkRuY7UuuVNi/NOqCUr7/Z/3x?=
 =?us-ascii?Q?2wGdpH3q+PGcd/AOqlIfBaRpMNoafNLxOu7HoSWGnlwGeUJCRzQMVipbonIy?=
 =?us-ascii?Q?vtlT8PHsikpaQ3epen1SDLAqCgPdeknQVFrESd35BVWxD924xQ1MXAXwLald?=
 =?us-ascii?Q?03TXzv3pv1FgVAmN3pGBdN6h4MjavE2E2iuYfICUI49PPpnajBsZXMst4cz5?=
 =?us-ascii?Q?v8DB/z4Q0xBeS+G1JEXaYY/Vwg3MZWR1Zd7weGue2IKDv9gigJwakTB7Gwbd?=
 =?us-ascii?Q?7b+8tQ0ubpWj90ICaMijsYwKfW/uDYaz1RYxyF1AIFnUcawVebTRzf5HePgV?=
 =?us-ascii?Q?Ss1GCIOay7MzteY8eFz67LOPfuC5cJ0AAq5HAnW+1y9/oer93pm37k4bOP42?=
 =?us-ascii?Q?ZOs5YCOBCgSQBEwr9kC58GsrE65jqctlxwP5kPoIsRbawBgLU9sssA81J+f9?=
 =?us-ascii?Q?UG7IsCD6FpQB8rVjvEn9S1tefUyjbGpfyzb/ojXJs9DufwKbNiwMwAOJTN8P?=
 =?us-ascii?Q?1lkYFV8mHUdrY1OF4KXUpJ3agCm5DhJT2Lk5eBcJp4jhTIrB/0peYqfXqENK?=
 =?us-ascii?Q?lxrkNd37M1vizCiSwD9Gw9wB2IsR+Lpp14xNtT9NvMEVXtp/tTlr36Od5pav?=
 =?us-ascii?Q?040vts/Zg19r/PfsbU7Xy7sVz+6YaX3fCZc7ZjNi8mU+m92du9ZV1eIOdLVT?=
 =?us-ascii?Q?Rr3GonGZknjS43mgPXSvXN5Er3cuxourf3XAAqSZrONJp3jMdhhpiR6CiFrY?=
 =?us-ascii?Q?1BzXssmuKirlZ+iqS1eLm91rPPL/vJmrl286PZVTiNmU3EotM+yaU8v+3O2/?=
 =?us-ascii?Q?bY3NpEbck4pxnmaE/CJUMTFErVfvXKnwjOQtxHisnu1GVdlOL8LKLYPOZy88?=
 =?us-ascii?Q?WeKQKY4/6N20h1CNVnWeLPWBdYmmIFcP7XqyO2cSDk0Du46L0cu/XOvfIyjA?=
 =?us-ascii?Q?VJRpI44fqY09qoupZc9fr3HFq9ACSd1kBPQVXPUv6eDRjAzZ/PvB3zDZrWXR?=
 =?us-ascii?Q?I9lUC19n5vhIIIBrGYQsQK8GG1863pancNT/WTzgQ/oML+IR3onGRm1VOpLo?=
 =?us-ascii?Q?Wk2i1GNyvH4clT9Fdo9Nj8kODjeUjCkko2hjBC5FMTnSbMGyAiBjus137s8d?=
 =?us-ascii?Q?4AutcHE87F+ch4DSATH2cCwRcubJrCUefdrMYKDOUU7VvsAQpOHPE2XDPULX?=
 =?us-ascii?Q?zvumvsYU+Ws9DmaByikwBVwhx+IVEI5PihgyCtX3MCaV8Uq1yrcGXScu2/MJ?=
 =?us-ascii?Q?k76aNprRBbQBeL6XZ5U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:10.0421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 330ec527-f429-4d9c-a62e-08de3ce6a888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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

Disable the TCP Early Write Ack feature on GFX 12.1.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c2c4cb6154fb7..6196c679f4edd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2657,6 +2657,17 @@ static void gfx_v12_1_xcc_disable_burst(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGLARB_DRAM_BURST_CTRL, 0xf);
 }
 
+static void gfx_v12_1_xcc_disable_early_write_ack(struct amdgpu_device *adev,
+					int xcc_id)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_CNTL3);
+	data = REG_SET_FIELD(data, TCP_CNTL3, DISABLE_EARLY_WRITE_ACK, 0x1);
+
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regTCP_CNTL3, data);
+}
+
 static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 {
 	int i;
@@ -2665,6 +2676,7 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 		gfx_v12_1_xcc_disable_burst(adev, i);
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
+		gfx_v12_1_xcc_disable_early_write_ack(adev, i);
 	}
 }
 
-- 
2.52.0

