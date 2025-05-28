Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA294C5B553
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAE810E575;
	Wed, 28 May 2025 04:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bgiRwifL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0654C10E161
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl9+5c24afO95BpqFFEjwgTRdy3tApubVl1NRMiUC2arRUDy7t2a4f/Igzdj7mHD7Ps9MIaS4z2TEH2Fpq0li7daLNpNqSZ7kWhD+nZmoGWCrBpwUX5UYoZ0s/dlBJ89BeRyBfROEQ6IX0HluIKxMk5q4RmZnZDvMo5nficQblZacjhnzvg8LINu+zCKa5M3f2zKd3IO1ho0HrOZyhfXqaYyjbQBNX1hwTn80v8CjZbCram5GwJXFEz+VUKhsapGY7LZy97drqhahbna7qv8/ydYgYmS22nklNCMb73WMdeiCgD1hoSKUUXfB8RVQKdA+Am6VgPy0EjvUNTN3uysJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29zvxUUtpy/W+gy0AW0aBtI5N/RT5jAFNNdSTDNR4KY=;
 b=bwJi04F0uM1pNGddAdBZ9fXNVeQZFPT4qEG5DrGcm+9/rucX7tckhVP0s2l5Bd1JEUMIKAzMBbOZET0MbjBNZZAyfiLwZLuZttzeKDRONrjopjDWUCkOj/iXhiuG7gklcbAAG1qyqBReASGDcYolxEGUZ4HhGFrZGC43fLQP0iWxKbQXBF4A80LNnBUKC3lmJ+kSm6bZI0o08BhD0ff+3msSQxTuQj+NHRZvLPWoEeQeqS00SEjoHEJLDUeFUepS8NM5Ttou08BPPjNwSwrzOa40hvhNexopmdGLWDebed6G678mN2RVqUZ/QRWa5kElilsNSBSZZx+mmR4nJdFGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29zvxUUtpy/W+gy0AW0aBtI5N/RT5jAFNNdSTDNR4KY=;
 b=bgiRwifLS1Eop1fy3H8DrL2pw7139RXpfxXDI0SlWcEpIF7z/aMyF8H0KnnphjO0354uqCVDK21Rfx/o+DstDiWhbcDVIe/5ee/E+PFQCRmv6C0pTGhju4DpUCIdpJlsKUm747wJrMgDrVYASrdk4lc1/4fljVfJqIdDzR9bqq0=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 04:19:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::37) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 04:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/19] drm/amdgpu/gfx10: enable legacy enforce isolation
Date: Wed, 28 May 2025 00:18:56 -0400
Message-ID: <20250528041914.5844-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528041914.5844-1-alexander.deucher@amd.com>
References: <20250528041914.5844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb4f937-08c5-4ce0-0519-08dd9d9ed7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jU4igBha6Jy98jpzDfLVSJx7haC1Ul2fld7/lnMPn36Y9rf7G0b5twJdI5Jh?=
 =?us-ascii?Q?Jp8b+vRt+6VXRTcCQXqRhGKxZGzEYqEFibQe37SWJP22iFbFJXxVFjpWiJpj?=
 =?us-ascii?Q?lhLR8IxdtkrMsRTks9CCwy4b3+h0IwGQiIO+JG/WstApWyV+9fnKi58DUGxF?=
 =?us-ascii?Q?YwMjYsm38/TtNz4v+TjVk5xchlB36ohriXu/QdWDujvvWLSWTNggagzoO1eQ?=
 =?us-ascii?Q?K18Nhcm2jGRpOnSd124qCaej5k+78dvSpysdEz5rdPjLj2DgeXz5s2woPuhI?=
 =?us-ascii?Q?h3YNcd6S6HrvNzzJe/dJpEGamhsAoqOLSw84lGzNsqcJT4ehWZy4VBh95SyA?=
 =?us-ascii?Q?bOhn8rNZZIeXpRb89Ak346oD2cXA4xYqOYSY43WrKqvxDrsQ2KOWYgF0N6TS?=
 =?us-ascii?Q?G0HTfLbV+sQh6TsPd+zHjMdrEc8EkE/K7+nYwLGrgTZsadNY9IgpwfIF5SQG?=
 =?us-ascii?Q?eXFGOtoS8m8yDoDBiYUsaD/8CvXDmMfBAYIJjBW57JBhuGugqbgcpGUwv2CN?=
 =?us-ascii?Q?mS2l5kg2vArze3uqEtWSu7ehUlSDS468gMV5qRq6bS1bRQWyCkUjMzlqyLF1?=
 =?us-ascii?Q?JvV0QJL914OdpzZoU1aBtekH/udnkla/OTY9kM9hiO8AC8SbQ1xjpZSjEQ8O?=
 =?us-ascii?Q?N47dN6pdFXAnmjhN/yoLWsOWI1xgG9WyT+28EdoVDd0ADoEBJ5RPooBSL5cw?=
 =?us-ascii?Q?xxXRMRkzlS4qD6Ckn9z7Fi97O93UDl6CbMhjaoTTka3bzUmrUC15wML4uOYP?=
 =?us-ascii?Q?891Ewy41jjQn2E2o2wx/3JFLFls7uZrDCfEtQv711cpIlxQSikXMXK1QZyxh?=
 =?us-ascii?Q?xT4wHB+9MheVFS8FJBDBRa0Th/pjzfunsOTtRQ1g20MSKa1qKqFBtm7LIQxE?=
 =?us-ascii?Q?QsZsBbN5N/MN7b6Fk1oro6tp/+d13KAWfS8Tz7PVruzPTHGVG+P4S5o7Ezhb?=
 =?us-ascii?Q?sE7oshKNTzdfl5DAElFNABpTSe8ecL7Ncn8HexQdZv2TyQZDJxx+Oi4qI8Vl?=
 =?us-ascii?Q?74vcyXy3lJPO1Q27qCsg1evlaSuDiVxwPWDmfxcUj67cYsJkCrH8FZC+NKYi?=
 =?us-ascii?Q?gW6HVPdmBqHpROimneAXx1vL6ZWgJxIg/lnF2VW17CbTbu+vJv8a1ODd44nK?=
 =?us-ascii?Q?0hYMeGfs++DHwD1NUfGiYH8GDeG79rV0MbMW1QLqaiqAk0TshCPbqBF86hFU?=
 =?us-ascii?Q?Uvy0Jkm79jIif1+Ff/qVRyodRpHRXMzdTzcumCtyltiWGdIn0uChsbQ1Zc1q?=
 =?us-ascii?Q?vIEYZUEPmY8za68sgeo0Fw6FSKN4LNJZlCV3udILpKt/2399Idmpa+F+FY+F?=
 =?us-ascii?Q?Uz5HEUkPOh9NxxDhykuTXnYI6+uLe7Y6VvlZfxvUv0cxoF92zm5ErVRzuNE5?=
 =?us-ascii?Q?5nid2+X4hdIGEVLp/hMfi2YOV95jtI2CRGZ8CxTH07NtFnbDEuPs6Sj0M//c?=
 =?us-ascii?Q?NGsxK1cLsmx33nYnaL1GRfw2wEYXYbc3P4sXVgBtL6YYEjNn0b6eKlhZ/wLW?=
 =?us-ascii?Q?Pb0UdSbqga3+wzImJsOEJCKx7S5odHO1dH+E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:30.6548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb4f937-08c5-4ce0-0519-08dd9d9ed7cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

Enable legacy enforce isolation (just serialize kernel
GC submissions).  This way we can reset a ring and
only affect the the process currently using that ring.
This mirrors what windows does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..3193eb88b6889 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7788,6 +7788,15 @@ static void gfx_v10_0_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v10_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	if (amdgpu_enforce_isolation == -1) {
+		for (i = 0; i < MAX_XCP; i++) {
+			/* enable legacy mode by default */
+                        adev->enforce_isolation[i] =
+                                AMDGPU_ENFORCE_ISOLATION_ENABLE_LEGACY;
+		}
+	}
 
 	adev->gfx.funcs = &gfx_v10_0_gfx_funcs;
 
-- 
2.49.0

