Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBDCC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E5210E6BD;
	Wed, 14 May 2025 17:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nkipdpuf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AF310E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlJ4hzbUDa/+zhCL3KhrNnDEfYeOqh/e3xUAojXLhclnSon1Ics/C7vzGC0/kQ5DIrCSOF11/jbQqj79oNFi/z87794mZJtvrbVKMDE/XBU71XsSxiFK7cRq9f6+ai8ckdTC4U52u/dQTesLZtDMf10LBxwpJfsSPKGzOCNtkOI7cf4ef6yuztas0HsY0o1C/7qLGK00gRh2TlqbQKOL/v6zEG2PvbelnTa6sP+aUed31k3zj2o9imRY0QK2OgikI3mEjXlMXIufvk4iq3WUvO1R7565Qv37W0yl5uqJaVDer2ACF8H4u5rMYrPZz4vZP7+LmJ444LLoV8cqpWYEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oQHkHNUiwJbiTVYxhSWVbGBrCL+PIvLSXLurP1ct7k=;
 b=E2foPfPnCRaE17DurRv3bWb3O4g1VCEyPUbAoykiIds4j2AyDURlVvN14emtD0hqpQRZagA9hHVy5yWS0OkrSoPhumYmX57v16HJXNLbDUx5iuGjbJ7XFVn5uTlhybmdtF1kXZiT5lPCPGyWkY5e9j/lINlU7Y7J1X1/Zw6GY+ntlXTtJF6X5mNs61LGL6tDFD+0/gd2tb0bEGcbcJZXXYBlcyPqkfdD2dedzrJa4muihFjp6J7pDIXIEsUeTEC6L8IImEPW8unxDdjNHukBAqGqhLUM14fo62Jwcu513ozwyIlq4PiHi0LNK3PH8EWwZdGoUXU4JPpvFmXkDEXQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oQHkHNUiwJbiTVYxhSWVbGBrCL+PIvLSXLurP1ct7k=;
 b=nkipdpuf+uE96Yi2gdWI+vw6E53AQ3cVWL4TurHwsKmhzu6xbEJhlDQysg3McWelv1LN8T+sQ2xkrgkyApOQ8lg5XWDkTl2zdg1+XumGYJJrLb+StgJWoLjjR4VbzGs5a08Z9s0uxWK8IgzyYs471kFjdvejFlSj1a0YYvPv/iA=
Received: from SJ0PR03CA0295.namprd03.prod.outlook.com (2603:10b6:a03:39e::30)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 17:23:08 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d0) by SJ0PR03CA0295.outlook.office365.com
 (2603:10b6:a03:39e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.31 via Frontend Transport; Wed,
 14 May 2025 17:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:06 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:03 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 2/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:45 -0400
Message-ID: <20250514172251.726484-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
References: <20250514172251.726484-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d625270-3a3b-4e17-f666-08dd930bfd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3D520SxWcLTkSslCNMw2jat9h2YqMws3JP+HR8HlaoJ4Atrxs8rynK/cBpz1?=
 =?us-ascii?Q?gEixYJXSVPtq4Xz3G6jJUD1BvK6ZfoZMdbQlOWbpq0ODxYnAYxgCdQYdhzR+?=
 =?us-ascii?Q?OLcHQUcQX5Cm5FWQvbvm6fVsBcWLU5td08oexlQu75b4XC+0WgwNgMOrfWAy?=
 =?us-ascii?Q?o8PW+GU4v3K3RefdiiK6ZtBGxo8ka8/bkfC6+w68U2uT4fqCSwqbcEsIaVih?=
 =?us-ascii?Q?VNiP8DBJKtSvMfgxC9cbmFk0aZD7o4hePtmfoB5oUwmTMEKsm6YwsC1PhVHr?=
 =?us-ascii?Q?00NyZMOgSlu+JCMol/1oV0ZSWDRAisk7D7UNa9yrBCBa2NodOXE/tbkZY0kk?=
 =?us-ascii?Q?FUOuRJtlf1Y5Sw1DftuqJE7Jxbomb65fSCEbUdFtjJdFTKTRtVif2ZDpBCOr?=
 =?us-ascii?Q?ghkMYAnVJ4jfhGo1e9pxvz3kYOcexrAKYXKI6qeXgJHpjwN8hArlairkp+Hx?=
 =?us-ascii?Q?UvgO0eItEIjQeabg/PvzNwlBfBCSc26fG/ctnWjftG0qdiG7BTvu7RSXtBak?=
 =?us-ascii?Q?yb1oVa4XAfqk1q+1F2PqNgxQ33BXnrHRjDU3CHhS5mFVJf4pGoyb7WOSU6YL?=
 =?us-ascii?Q?CZqS7tzGhU7fnM9RWOJW9EUxjK9N7/GanoJrrxLb6OJRCs6Ke7Q1rFuJ8SQR?=
 =?us-ascii?Q?czJ8ck3rEBpixcfsRFtGB3wG3RvMaH0PUh4fszSodVEJtHFsw2JTcUl+9qbH?=
 =?us-ascii?Q?nkChbxE4oMhg+ckpKg76h9eN/4mrGKKutNjlgb61mOkS90pcInLHCpCGFDPQ?=
 =?us-ascii?Q?BeZvsVl/3iYcMSIS6WKe6lVSncsRxPIuExiQEZljvmDncnn8LmnzSQOqC5bw?=
 =?us-ascii?Q?YeBp2/X5F+4OdloHvJrpWePM2fBB+kkfvkhJnG0Rniua7KJqjDG41mZRNaWE?=
 =?us-ascii?Q?rOdNDvmHvofdW5SPK+eVWiYXSb92rJBIFmcaaUxJeA/OqDwq47X4gCDkDPW5?=
 =?us-ascii?Q?M1Nx5KpM1DTBCuVsXJ2EXXyupuwBb35rhzLAH4khHKli4NNvO6va/esz4X6p?=
 =?us-ascii?Q?RMQxp3nhy2RsQGpRUpJ2jPJ/lMIUuJzB4LRh5BzYW3zn+MEkWyo4ON7LNG0A?=
 =?us-ascii?Q?yg+8KeD5jWW/IIrxctUAFX7GaoHm8ILiVG6B2qxWrE5m9GbVf5cCaZcA+H8S?=
 =?us-ascii?Q?q5GBMGj1x4Z9BHqXub7oYgKo/wNdz0doqV6HEIb/z7QnyWFcA+DS/iOoggls?=
 =?us-ascii?Q?lR8VIkea94zs3QKZTFlY/2SnaF6SaGi7geKc1NCGVIbTF5laS4BUxoY44Tys?=
 =?us-ascii?Q?PgcrNpgu9aYJzz8R2Y0wHpFdgokfvZAjvY0SmsdVaIGoteaQ26TvbICtTmFl?=
 =?us-ascii?Q?TQCC/LWARNkxvwzmLTEBFxE+S4xsJ3jlOH63cXRfH6T6Qt92fih7rK8LaWfR?=
 =?us-ascii?Q?jjrejoy+5arZlIYpL6YbxF2/s5O3KYYbbw8msZ/ugP4nSOa6/2wtpr+utK2I?=
 =?us-ascii?Q?vNMSOa9do+uDR9YPWe6zTPdeJDeqcKg4K5BRw9EglBmiIS4Yr1PcX0lGD6gY?=
 =?us-ascii?Q?lqjLjNkX1HobC/X8fAWg8WFAN1704mWY5xR0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:06.0720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d625270-3a3b-4e17-f666-08dd930bfd69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

The addition of register read-back in VCN v2.0 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index b8d835c9e17e..e6a008d7e67c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,6 +978,12 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
@@ -1152,6 +1158,11 @@ static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done, otherwise
+	 * it may introduce race conditions
+	 */
+	RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR);
+
 	return 0;
 }
 
-- 
2.49.0

