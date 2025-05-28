Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CDC5B555
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 04:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5686B10E55D;
	Wed, 28 May 2025 04:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6KgAgFQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5DCB10E545
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 04:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnYEcrXswtnPMhEAeAwJJ+jdOLW2IKRVNW9GtGnlBJkrR1zA2In9dgKVJeGO7DNgtiTIzvibQgDS7uOmfeQmT3+B0WRyz7tlNAjasOWfija4VuHlcXvlJijodQPFJ4IWEIvPjKmOZUZ+TTXa5kMTbSKr2YJJiMVmLUTn0HOOWFh+/IlW8XS5IVcbrUvPDb+aR/GyJbgsufa460Ev+VLJDK8q31aG4xFUy3jHa5rpBgEV8ZDvhzzEHY9zzG8b/ShWUSV5UPusgOumHk4feKaruGzwl+rkvlsHPRWPQiuqRrS9k/mNCirsYSD3KDyBALa0mvjYCrD8Mwlc/tAptQUKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=iYgwS8Fsz4jQu6sTASJ6IPNMfFoumAx9MuIt+TEE8VVSDJpqdxGXh5UGcHE8/+ginm81EwJ5JjUiCJMmwX0zf4gS4uSGD5QXxhv/QWpLumBngnJ8xGjmR/eGg3MXugF0FwFIxlUk1NeWyjb2bIGTTG9+EgHv8vCsz5zvJRX10i3NEDLttdGlogTJTmsqLfFln54526WzzzSiJ03cqT/UGfm3y+7EAMO/bvSX0Z24vd9BiH8eHKSguydeLZ7qUj+e/u+AaKF4o0+GY22uBKmBWSaxUiBVMsbbQiAXq7lAcRU29tg5ehJbDfW5BkrH8nOA2C9khihhxYlI/wxhH4531w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs0sKwpVKNfA7zpf0zO/cG91hGXwWQRsMxZHvzmqmyc=;
 b=n6KgAgFQUQPvfUHEERMcWlEKOFEMUinLBATS4usVb3/Gt0C7m8nIqWMYqgIGggml1WfoHPaZEM+ZWKDGHnhPUz0U00hSR6Y8RRtGPZL1SwZFW4T99GO5xVi+1K2hqSQ2hGgT0UvsTtMjCeSOJ0o7Im9vipVvsvPt4hcWQSAdfPw=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.25; Wed, 28 May 2025 04:19:32 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::79) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 28 May 2025 04:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 04:19:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 23:19:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/19] drm/amdgpu/gfx12: enable legacy enforce isolation
Date: Wed, 28 May 2025 00:18:58 -0400
Message-ID: <20250528041914.5844-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d161d9-e60a-4d3d-4f22-08dd9d9ed88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qziO14QVP8pc6WTAPwLj+nDdQodVsEAuNGRiENfDUghvI1KGbvY4ZV7DqE3J?=
 =?us-ascii?Q?rJwOG5rnf0YWV4/rlbf3IogB9BuQXO3eT01akNJ3wzKQp7wpD4m78ZVpf7y9?=
 =?us-ascii?Q?Ow5LIBa3Q1/xLhLy4o+WeDDBL1uqO3DQLVGbVCvvM7GB6mi/DrvDRsvHESPA?=
 =?us-ascii?Q?T2O59sZzhnwNKnjQ/zLck+hxlzfbs1BJHchedtobyabi5fL18wZzs0BOJi8K?=
 =?us-ascii?Q?M/2TMyUItRjXk35yDEiTYGy/Fi4rweLOVIJxGnwWxdI44uhdowG3sCblJEMV?=
 =?us-ascii?Q?67hxpXqUe/gEFL0Pb2d4iKmxm7DNF2MmE6KBxSAx0SJtX5RFDDbdJTwBlnLc?=
 =?us-ascii?Q?G2D0YoQ8Mm0LSHfDxbTHJ9sgXCHJFfI+9S1fuGG3JtfZS31qQM15lXWbhF/m?=
 =?us-ascii?Q?pLQ3mycfbsLJdejHx2/6+ZIyTUT8ZDJix766FbDCdn4pAvs4NAUQZNgoZC7h?=
 =?us-ascii?Q?bhdOVUl/SE2x6QIigU96GyF8BS6vFeTMZCwF0SIp88989dGmXO3rTGylTCgo?=
 =?us-ascii?Q?zRp18IcMk9iy2H62RVzy7fxMR7majr9rSIyAkQtj6E5EFvdsg6ga8mop2ub7?=
 =?us-ascii?Q?L9QHHwqZpcB+9gzgOGPs9NiydptC2dzp+vBHS3b4QaNqxyPA8LjQmyR2dFxG?=
 =?us-ascii?Q?wSxl1uOGI2NJrHkLCyHg3EjTDtFWLMO19eSWrGrsQKlRfsoeSlbuObO1hGqn?=
 =?us-ascii?Q?oknN0yc0yfF9L2T538pDzNi6Q1SGJAnU9bey2berEOgmABvWQHkRAdhm4eGc?=
 =?us-ascii?Q?0aPbKM+Sps8Pxaw13kipC7v+3H8nyrq+rpHEqUZ4Dg2S33V/J8b5anoU6ivV?=
 =?us-ascii?Q?kn/rmUj6fjuZs+ozqKXwywtrz8xRVvr9PSoonBHtN+gjtszJXVXOT3PYQhzt?=
 =?us-ascii?Q?Su0HM6DpgTUekNL6+GiQ837dhlyjYvOuTaFqxrVY4nH7uV7oEKsCq3Hm5gBS?=
 =?us-ascii?Q?gM4IMoQ4R6XOTTS/snPUxiVLNbpHzT/zZfcwWZaAi8R6mfc6IMbw/FntLa9b?=
 =?us-ascii?Q?7sCaxyu3fy64Vh2cuqbDLQyf0uxFbC6PyaSmsgk9nR20p3u3lLfTnh/Wbuy7?=
 =?us-ascii?Q?JYE01m1jcuk8REFMftDavtMj/U9JHF/YRvC7XQH90h3W46HmOJp2f3IhS2af?=
 =?us-ascii?Q?0o7nbEkCEbfPDR8v20hEQ9LrXFbTacPVmtlBuNoNw0kJaVpSfusWjroW89xi?=
 =?us-ascii?Q?4mkuTHRWoOXUmY2LTRHnnC9dwHxNUrUmfG9f3aA8SkDhiFhdeXfUEe9o9vyX?=
 =?us-ascii?Q?gRCPZS7N+t/uvpnxo9Z1hbo2/kCL58N2J/EDadcEUQJ0ggcogqJaCaJRNBEe?=
 =?us-ascii?Q?sfD1G1kjLwaOfNFyXdg36X+CeRBUihf3NwssQrhEYkde4kuOMvbIX7kXIJbt?=
 =?us-ascii?Q?VwNCSstNgTjKm3cPgqoBGghDS8vNy5TNDBw08biXHvrPgXtzrKsDWz5rF4cv?=
 =?us-ascii?Q?/YekZThWTstYSn+OTRvRKWPxVK/KPP4dB2qTBGw+NdIodTqonwejn+hF4j1q?=
 =?us-ascii?Q?2wOhsa108agY3IErAwbM6Nf727hlAaJ835YW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 04:19:31.9072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d161d9-e60a-4d3d-4f22-08dd9d9ed88b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16d..855aeb7b1a89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3823,6 +3823,15 @@ static uint64_t gfx_v12_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
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
 
 	switch (amdgpu_user_queue) {
 	case -1:
-- 
2.49.0

