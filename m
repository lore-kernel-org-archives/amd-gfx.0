Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573FDD3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA0710E4AA;
	Mon,  8 Dec 2025 17:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tlcmhwMN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4576E10E48E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8/wPnCcOQ+iehAkV67Rk4g8WFpVQ9uWjHheegL5HI7TuBN5fErgJZnK0uQNIMUUmyhThopTT07F6BiFI3tk/iAx6nC0f6Bbmy2CJ6jKAUC9THiF4DNsC4Sw800XzAQ5Uz/nG4RbYIFuMWFSPQzudkgz3x8PQn9Lz6H7El4K8WWvay6tHsKxjCic5vyV4xHuGHi+ISymPw7SK+6q2qZmjujcVVqtxHGKURk0/2SGFbOaI9rLhDL+9Gib3EmB1FoK+WwSDCtWvXW7jze9Gl6qKXustK37LWXuLPZZhFps5mHYn6spVyeQIOJQwWqWFssFn6V4PQdRpZ2PO+y9mWxGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI4+H/fTSf02mvhpx2jE+HpnBMMe/V8OXmMN1fq45gc=;
 b=a1eLa6Xi98Ebf2mANmTE0XKf8Gyi0GQZTN0AbJZrJQ8i4SVobIZ37Y5MmxFTMVjjRIVHVwkCDvhjBnZRYTNcaIW5p27AL0VLvFLTQ+zl61f23yR58LVKiLpz/N1g5Hf5Wuu6WSBCornPoJ0lAJ3/pyNoFOqPggGnMdKHODKEWgo+wiEBYzC5bpKq7P+yqJ1Wf94lbOgEY8P4Vvmai+jeghxkEw3zvW5UXsQMoegH9Mb9VP7YCsqrqQRdXCxyrse/T6dk1tW/WAtocTCaf45txVO6qhpTw8KpCldjsBv2S6EV8ZF42H3SkAlxVWklqeuSqw/kw8jUovVIsdA2Q978GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI4+H/fTSf02mvhpx2jE+HpnBMMe/V8OXmMN1fq45gc=;
 b=tlcmhwMNxDXyDjaDXI2ECQpBAzOdydMb6OcD5YDOvT0xKtIoswjOzoBUZH0cRzyjJgsd93gWbxRAWQ3aNjxOaO24+pPeqkl4bIZHeP5iANbYxd7rMAfgOg0OGj31nCchZIJvrSTp536JM4ek/TMLdi5F0ntdPZ24JxRDWeN2MPE=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:51 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Mon, 8
 Dec 2025 17:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:50 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize memory ranges for gmc v12_1
Date: Mon, 8 Dec 2025 12:17:10 -0500
Message-ID: <20251208171720.153355-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10e14d-d7e5-4d16-20ac-08de367db6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OmXBVS3rxU/jGGApyw4gntCGWHqvA7v6oDAwr5JEpQBINBWX71G2E5zZWLlI?=
 =?us-ascii?Q?0IfvL0+yBg+2PubmSWZp2rF2ZiM+jt6ZotfyPD/qLXw+Cb5z1lO6RheUZr2l?=
 =?us-ascii?Q?fytTFJpfbL5sIip17ALI0rIvcZiNOKdiiVcLUoKOW4yitpB9S4FhY3UKq3sM?=
 =?us-ascii?Q?qbTOP5xdL20oiAzryovxnD35WtFZscYET3rc7r80zTVUwq2+GiaE8UI9C6yb?=
 =?us-ascii?Q?xAz6zAxN8EyKz9kqdoZ7rM3QMOss+916dDtV2QQ3sXT72xv+q6ZFVd0cDAzv?=
 =?us-ascii?Q?0F6cueumzi2Flp+5RLk+i1ljEXDUb1N8H2rX2Cv3ueeoI9tggKEaCanWeL1r?=
 =?us-ascii?Q?hxznisOfH3VptZnPzzbfZeYWmc99bw9fBICmJenFu70iNX841FAAfCxzvJEf?=
 =?us-ascii?Q?nb2noRFxJ8Af6cFzIYvTvoP66kmKco6CrK0Ev2vg/50TAZ5gXCQ3FfTAlB3+?=
 =?us-ascii?Q?AbRZVxM4fnAA3qPq910jdXDR2vuvt67Bwx7C5Rroc9TKMta+J6kDW+K2VKrX?=
 =?us-ascii?Q?uKCkBVfa3kGNY1PrVHjSeCFMMUZbzCynVhfvdYuITEmJCZw5Vxxuf5MYW9q6?=
 =?us-ascii?Q?aHThqtZQeHWHqxnTGjLXYvBiOTkUPB49ZcYykB42z3o9MFyfNU5VNRLn8AmL?=
 =?us-ascii?Q?//AXMT2fENyHcUI14zwDDCVAptr6h0Nda+lvcgB+MKRrljlTlsDOsczGck+Y?=
 =?us-ascii?Q?rVmbyNDqcBx/E3LP0wnhAlCIUw46Zj4T9qSaNTjertA9kjf1QKzkHcfV99sw?=
 =?us-ascii?Q?glVOQDNPNRxEnPwl8S71vG2PD+291nTzYWVq9D+ZjLvOzRlrqlyXI6qzWaPK?=
 =?us-ascii?Q?Hp/2poWnWpziKKnz0kc+FA4A2asJFETa26WtzKEX05RW2SSjBDZS+Gj9iliF?=
 =?us-ascii?Q?QGVJ7V87RyW15eLy/H7HfcvOALsSKCaSCPav/59JvEJNI34/3RLiFjqq6S9R?=
 =?us-ascii?Q?6G4iLd8Nx7kAeF0x92zgZLwNTm93e8CJvkhiiFvE8QiX2LxH3dFiGrISUrQ/?=
 =?us-ascii?Q?34vmFQpnlH1RrFX2cpimJU8J7LBgWo8FOW93C2w4qIBbPrnJb2/62bElKJE2?=
 =?us-ascii?Q?zuTocq7piUGH1bTzhumJWI+75MkPZE2f/d8iBGTUN9MAnYwH9fTVenOUCfBo?=
 =?us-ascii?Q?b1n8dkn6WBdMqoI87n5bKP4toIgtpBPUW8OYxesPOF/WuZGUNyiSoO0NoxXU?=
 =?us-ascii?Q?oGOHpqiblAIFq6ljngBM64FCrVym5g+9N9ET8TGO5fvtmBlvBEs36MJH7fBI?=
 =?us-ascii?Q?WxqnsDUPwFm29GS+rSqNsnfGS2OUsZ4Gpd+n4fZUeBjjPXA5K7yLBeVSDcyG?=
 =?us-ascii?Q?639F1Gl17Fovl4Fj7V9KL/dNXhNvu5QE7De/9naxSZtOLF4YM6RoTW71dPKn?=
 =?us-ascii?Q?pM5G+AeGyhf6Lyz+K8WCmdn8lSa0tDsuSrcy8RcMTKq1aS3+BmGIbfpkTd2i?=
 =?us-ascii?Q?2Qnj9T1v7HhL82YJwT7Oy/Tf28jYdMNKiAHtpMajQNIlxyFynfP4xbkLNjsA?=
 =?us-ascii?Q?DI0/VVD07CAxL9UthVdetbAfdnbvDvAUrHF1Mgs2XdE+a73WYlioUiFirmF0?=
 =?us-ascii?Q?nfbNBaxfPsd60DTaPnc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:50.0166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10e14d-d7e5-4d16-20ac-08de367db6f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize memory ranges for gmc v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index dfa5181851161..8e3e2d3c553fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -878,6 +878,14 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_gmc_get_vbios_allocations(adev);
 
+#ifdef HAVE_ACPI_DEV_GET_FIRST_MATCH_DEV
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
+		r = amdgpu_gmc_init_mem_ranges(adev);
+		if (r)
+			return r;
+	}
+#endif
+
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
-- 
2.51.1

