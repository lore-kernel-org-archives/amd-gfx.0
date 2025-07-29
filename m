Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD32C87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 21:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85CE110E2A2;
	Tue, 29 Jul 2025 21:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pt+Bk43L";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE88210E29D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 21:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/Zic1CTLkHus+lVuKAG85CIGWVPCcmv/1le5/P/iVu/6oLfa0RsugY6QfrLAZzv/Mt8RQrddHkpYmS2sfVm+TrRPIE0IdfnsYGGLQ42zmQYliP0jlryIedezKaJiWbeCIY+rPF0lieSdVv8hQj+R0JqINHS9MySxQxzTduVkeosqa1TuAgn5m/jngi5dUtsDVrro7U3BeffQgwWJkPZeZk5auIkxXitQKrk2HbEsYpx5VWWZs1a/nkpW/5E1nGDdPsMXY3ffZBA19QXf+EWszK1o1dexRxnh+VorpU4sUwSTaTUooDUbS8TdTtoKRHREC8ZHmgw2FBWcr/o/bBuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h/vvLTr3vp23UIWRG1caB1uXy4sSnpqNlISDykx+MA=;
 b=GqqcvnJDnkAehGWPt0lW2aJU7v6pZhpo/OxDgpZNQJVSvLHyiUqgPYpDr6GOc4mDvwlgsAouQZXDH9Ly/eGyNeoM2s1QnsTHqWll+BN/SSNZPuqhptxJdgk97/bEZoEu6lpdCG98J9/Qnzxnwdhmh9kMAPDbO8w8g5nz3Sv3yUQqtmYYkGF4s1B9EUza5iMiCpnp+Lcnf2V9M7hHjRZLWlp+GWInd87dm3s+M5EYQmpGA/bOFBPzzZ0sRBXkprfXo/dpE8kpAFreUQlsv9+xHfXaC78yVQJ3TGPdEulDZdZbRCG3cKib7KFyITbRGwDnIhjsl1g5JFl6tkSPjhbdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h/vvLTr3vp23UIWRG1caB1uXy4sSnpqNlISDykx+MA=;
 b=pt+Bk43LRqwAwvM9Co8eEPLP4+kiBtxzSF74SUW54EaZMVvf0Jd7Jh0YcmPIgdWQH5YEE4dDaXwFldrYGpY7dkAGG7LRsOE3Jy+LOw2Z/+gYvM0dI0/9Je2RtIdJtGi3lW1957XQrT4N5BUOTWqd7DFZ/DcnuM7Oaktv+HShLOk=
Received: from BN9PR03CA0451.namprd03.prod.outlook.com (2603:10b6:408:139::6)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 21:08:10 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::5) by BN9PR03CA0451.outlook.office365.com
 (2603:10b6:408:139::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 21:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 21:08:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 16:08:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: update mmhub 3.0.1 client id mappings
Date: Tue, 29 Jul 2025 17:07:53 -0400
Message-ID: <20250729210754.2304695-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 524285d9-1673-45c0-ee91-08ddcee404ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/vuPQRHcNoARxMb7TCBwKvjnVD17Kkrv63nRdUbVMVKfaaHMsJ6MHZ2T4kzn?=
 =?us-ascii?Q?HVqDgCzKYxF2kwAu/YWDcivYOPWLOGX/+18ga4+gbYbp5EaY4pQBWHTAi7Ll?=
 =?us-ascii?Q?1ZwnxKN23CMyav03VA7Zn/cxxZbP0UIYhO2z/01V+9j/p/o05lR53XOTvbLj?=
 =?us-ascii?Q?GkRv/EQgWambtSsLSvv0FqF31p0mziOuP9nPvGC94lsqpkeSSaMQFhh9RRvA?=
 =?us-ascii?Q?Ln35PYWES+ofob3hFRmNMIVFhO1mL5LcKaSF22uXlOu7O5qrxzalBjyzQNTD?=
 =?us-ascii?Q?LB5XOa2HfShblS3qNHYx6iTkfZkOFea6/FgH8gdcCWp3XBZzVY/d6N4j5nZt?=
 =?us-ascii?Q?IUMlWMlW3ySmLcVOmd8etjklvW9W8wIRRpUSyUqHJ4WbiATmeL3XJH7++xXK?=
 =?us-ascii?Q?L/6kMVAXsNvwk3yOGKh5w2xhWtR7j/H1WbSuhs2B+Qvrlkl5AZAeHLN8SMEg?=
 =?us-ascii?Q?xLWOgrBDP3TeOu56gM6hnqyaKLOiBt8JKJaTAPWL64E+aQuURATG9CsXs1gq?=
 =?us-ascii?Q?KN5WUfEgb9L8w7r9kvRQKa/t2NuLmw/ACoVcuR2G6hJ0mOKAbIrWTCIsfe8Z?=
 =?us-ascii?Q?lX5wkhoQfezfMVRHgvvTtprgxAr63b0bJ9Hv1DZ4RFK4XKsOoxn3ifycMox+?=
 =?us-ascii?Q?qLv9p6HLLMHnndNrNMdxGYTp1j6dJl60WklYRfnyjQceCXibQWLpNs4l5guP?=
 =?us-ascii?Q?fUfY2OqXDSQYXrd2o79gkqtRsYN1WGrraagSxJU5qSzMzKZ3FOYUH+7bOG6z?=
 =?us-ascii?Q?bBJdgUe45Uf3O2gFJbH4O+DafpE75w6pxkgHjZt+B/xqv04LAwSOyShTO4aC?=
 =?us-ascii?Q?tbf1fj9snsW5ToSX31o2AnJFBfnfL7vcev736LGKBjaLR99bWsPuXOIobkCk?=
 =?us-ascii?Q?8spMAZifZNpImhfB1kZBCuvmvy8xtBawRBdtL44DEHqZyVuZP+KIqOxMWKls?=
 =?us-ascii?Q?inGj+0CmpObqNACWNIwhw9fIwZK9oBXfKvr6actFhMU/FydlZW0/iMpj/5r1?=
 =?us-ascii?Q?PETsjJbIz5QZKqS6PD0CfAFx8/KDbbQqa8jb6NgYscDebO5PoLLhFDRykv+E?=
 =?us-ascii?Q?ZZ466ODIy1GLMZgTv/NMzWN5iZSKVkA5az4HB4CIGzDA9JxJR9SbI6WZ9Paa?=
 =?us-ascii?Q?rynw/kCsdvn0rB4kyWB9j3MBLDi0Il7ejyF5OeQD54XGuVmCndHFZN+Q4LlV?=
 =?us-ascii?Q?xguYlv5Nfw2OVYUPAWJafsAC+bjDxexqPIzyVTBrMUCvcKtVC/OULbdLhb8W?=
 =?us-ascii?Q?AftoMBwTDvJA3PmFCkeLm8gIqCqE0jawjh6L9nMyiMOvP5g1p+axMWuE9TYS?=
 =?us-ascii?Q?gIo7xJZrg21R3ELPiFH0rse2LotiU/FVNM69nNolgPd3ZlbKb8wlYRQ1ZWXl?=
 =?us-ascii?Q?43LPda0IQHo955unl6feAOkyeWFMYbpQ45KdGyBf3U41A8LP758VQL6Z5nq2?=
 =?us-ascii?Q?LGAEspL/5OT54GznQ0mG4OhsyZSRxEdGYmZ46dRl6EhZf9AL3UUn9tjFH54t?=
 =?us-ascii?Q?YKnkXMGg8t0y9zIK5y05UXRyPoXzu2aAPiDR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 21:08:08.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524285d9-1673-45c0-ee91-08ddcee404ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 57 +++++++++++++----------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 134c4ec108878..910337dc28d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -36,40 +36,47 @@
 
 static const char *mmhub_client_ids_v3_0_1[][2] = {
 	[0][0] = "VMC",
+	[1][0] = "ISPXT",
+	[2][0] = "ISPIXT",
 	[4][0] = "DCEDMC",
 	[5][0] = "DCEVGA",
 	[6][0] = "MP0",
 	[7][0] = "MP1",
-	[8][0] = "MPIO",
-	[16][0] = "HDP",
-	[17][0] = "LSDMA",
-	[18][0] = "JPEG",
-	[19][0] = "VCNU0",
-	[21][0] = "VSCH",
-	[22][0] = "VCNU1",
-	[23][0] = "VCN1",
-	[32+20][0] = "VCN0",
-	[2][1] = "DBGUNBIO",
+	[8][0] = "MPM",
+	[12][0] = "ISPTNR",
+	[14][0] = "ISPCRD0",
+	[15][0] = "ISPCRD1",
+	[16][0] = "ISPCRD2",
+	[22][0] = "HDP",
+	[23][0] = "LSDMA",
+	[24][0] = "JPEG",
+	[27][0] = "VSCH",
+	[28][0] = "VCNU",
+	[29][0] = "VCN",
+	[1][1] = "ISPXT",
+	[2][1] = "ISPIXT",
 	[3][1] = "DCEDWB",
 	[4][1] = "DCEDMC",
 	[5][1] = "DCEVGA",
 	[6][1] = "MP0",
 	[7][1] = "MP1",
-	[8][1] = "MPIO",
-	[10][1] = "DBGU0",
-	[11][1] = "DBGU1",
-	[12][1] = "DBGU2",
-	[13][1] = "DBGU3",
-	[14][1] = "XDP",
-	[15][1] = "OSSSYS",
-	[16][1] = "HDP",
-	[17][1] = "LSDMA",
-	[18][1] = "JPEG",
-	[19][1] = "VCNU0",
-	[20][1] = "VCN0",
-	[21][1] = "VSCH",
-	[22][1] = "VCNU1",
-	[23][1] = "VCN1",
+	[8][1] = "MPM",
+	[10][1] = "ISPMWR0",
+	[11][1] = "ISPMWR1",
+	[12][1] = "ISPTNR",
+	[13][1] = "ISPSWR",
+	[14][1] = "ISPCWR0",
+	[15][1] = "ISPCWR1",
+	[16][1] = "ISPCWR2",
+	[17][1] = "ISPCWR3",
+	[18][1] = "XDP",
+	[21][1] = "OSSSYS",
+	[22][1] = "HDP",
+	[23][1] = "LSDMA",
+	[24][1] = "JPEG",
+	[27][1] = "VSCH",
+	[28][1] = "VCNU",
+	[29][1] = "VCN",
 };
 
 static uint32_t mmhub_v3_0_1_get_invalidate_req(unsigned int vmid,
-- 
2.50.1

