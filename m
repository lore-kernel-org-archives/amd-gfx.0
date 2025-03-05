Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE18C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 05:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12E210E6D0;
	Wed,  5 Mar 2025 05:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z8zBYmui";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1217910E6D0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 05:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3tKn/GyBBtWAoNfJP1oMT6L+t+u9Ha9Uf1vtMlrO6h21ufrvnR2IAuUpT7kk0ZYI69L9maCHmdmBfuzyELMsCzvB891VkpzlNnQNNfrAsVL75OACBhFoAOqWQrGzkalrngtukkRtO7P3XGGbYrY5AFXWxRhS+/pqkVoRjOueIDpRTEy1TkS02PM0Gme7327KMnaTUxhhuimK38nbc3eCLQt6R/5F2apsImoBOWtBEAS8jbtBvrf8u9pBwfGtBFSRlXN7GsvO+mHhSYtgHBfWgd9SoyD7RPbloLPGwXIWMTsJK5xwQyxsortiK8c4wH2eHVifTntz6WnJrous7Bs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNuYiJJ5+5Dwj0c2F+ta67JnB/u22E4sKZo1c7zqsGc=;
 b=n8tZzqCR8m7FFUjy6SKGk9zvxP6eXuOSBJyjH2cBskPAqNREG5HoAW9opZAlfqNLTzWexH9XOiAd0C2L4ZpeaCHGxmgJ0VrfevopxubuSDKyZGIwcpKFo/7BUfEOpdG0QJfwQK0S6oEbCIux+Tscvyc6P9xuSEeUMaw2IyNsy7X0E973nrquYMSQyTY6s5AmRCYDJI9i6aKEDhSChzk27yMk4egiz7eQQ+0vqBgqQgFmwR0+d3oDdGkSLRmYM4S/hhcwcEhAMy6pq6wMn17525lKXmLI4NNzQAhcFhJczJ+MvaXvQYk1pjHQlPR8sLCQUivRcyYSZcY3Ofzj7GO48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNuYiJJ5+5Dwj0c2F+ta67JnB/u22E4sKZo1c7zqsGc=;
 b=z8zBYmuixQph8isOjSFoMySaDhGbKaOOxHloGcJM8VbZwB1WlHjxG+mXecGRR/0HSqsCu9Mp7apC0lrBbvrQ49RDc5JOEgYamIXbv0DZ8rA/Rx+PSzOZKioTBp84M7mNF5o8pMiKFLTK8TTIHILqTtYlc6+ND9OMdtWVQesrJPw=
Received: from BL0PR02CA0066.namprd02.prod.outlook.com (2603:10b6:207:3d::43)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:15:53 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:207:3d:cafe::f6) by BL0PR02CA0066.outlook.office365.com
 (2603:10b6:207:3d::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:15:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 23:15:52 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 23:15:19 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Cruise Hung
 <cruise.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>
Subject: [PATCH 08/22] drm/amd/display: not abort link train when bw is low
Date: Wed, 5 Mar 2025 13:13:48 +0800
Message-ID: <20250305051402.1550046-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
References: <20250305051402.1550046-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fb4748-bc97-4bb2-ee07-08dd5ba4cd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lqShTKIoXAcx9sv9ln/4yyt7ZwCwru2issLzJGcdWNxQQlEwpgBXhuNTLMXA?=
 =?us-ascii?Q?I06Pi7sgHGD4XqHE/2ulHTJ2x7f4qfUrmpTu3LfGtGesYfiuZ3Uf10crhBdS?=
 =?us-ascii?Q?qPSTTTd9oo8ts0Y0sYnnMgWL6knU/6ER2aLEyMGt7ZP5YWTWF2vXsgp7m+u7?=
 =?us-ascii?Q?iiLPsSAJ0HqSomBFAZYtKEbBNy5K/4kgMxmms9qE571lA97a7u4CzoCghyQV?=
 =?us-ascii?Q?v3EYiKD6H/VvV4Hk7UMoPDW/LARLm3XXTxSgbMbZYQVZ4F7cRXLWi13SOSGV?=
 =?us-ascii?Q?bWZCE8mJAnsaURekdV2PAQuQm7TzCpo0iOGreqnEny0lUN2HT4PLT2iqQ6xy?=
 =?us-ascii?Q?iumD7m1MY4GfwTptwa/o9MCtHCtJjJ9+Uf/T8Iw2UFY61N3SeEt3UoWxIxn1?=
 =?us-ascii?Q?pQLq90ODJaa2mLRF7+0+VecnL+RzEtHEeIsvAAhvITn9mZh3Os7xnPjtqnfT?=
 =?us-ascii?Q?WYtPotK0zDQdFaYDp6WIdD6di1QoEvDFveQ6FL0umY4itNrvTpHBGcdmuZoM?=
 =?us-ascii?Q?WGlUKH/bojKDmRnBqqqCGr2CPsTWDfpI9flHpjaLtz21tkN6FoopUVsZlLX7?=
 =?us-ascii?Q?f1p6Fh/Ix5UZlVqmaCQvRsMaXA549tCT4hQ8VivGc651B0qg6FrLOxE7sEJO?=
 =?us-ascii?Q?YlkJUrCCXek44nAhjWyiHDWDTxt1fT5xHaSzkHqGnxCIFz6hTRAzLpC+gYAz?=
 =?us-ascii?Q?4zWKJbFoum+CRyyk7q325XWwyML7GjjfMWNHji7RIUV3mc4MtLNn658Hp02u?=
 =?us-ascii?Q?gOYL/QGSoLXkQnfA2diYsOAHPnKZXUXA6IuODfgffg0syJ6pP3Osnnm7FNv5?=
 =?us-ascii?Q?1oT1AyOWw4hbhx2Gga/yedfPUFLqnsgYV9/6RD+OEPn0adXXqf49frcvJc9W?=
 =?us-ascii?Q?kNSKEAtuoTuE3tMFfV19Bv441qfClfgvDn8BcPbknTa47USwJu9hV8UREfxI?=
 =?us-ascii?Q?0C6nrOAVjovfkVM39uOQNcRXwVUJHOu0AieHNFhOWo3ERyErKFbtgUHFoZLq?=
 =?us-ascii?Q?8VvuwfXR4X7BEWt9hpugCJKoXoaE4qe5GixpVQ1JKZekY/LJUuGJUVWHy7lf?=
 =?us-ascii?Q?JtEmlnpDy24UKZCw4CGs/7UnxlqYQEPYLsSuqizYAqd9O2DeJrF55D6E9lW1?=
 =?us-ascii?Q?WafY9otv8KiB7GoDOclGq7QTrzXN6J21m+AXyWRk7r/pq3aQu9dwrdQIXVdD?=
 =?us-ascii?Q?3n3SXLjSLbxOL4uJsTELIWRcDJ6SZPnAXFUd+JacgS/I71rm2+NieojsYJ03?=
 =?us-ascii?Q?9gXwOaNyDxeQVsGuweosKaalCoAOl3szVrA8wi3i78OHpK+O8nN8GlvSr8/x?=
 =?us-ascii?Q?phSs+IAr00NDDS9wAbgZSqDkwSIqCIiKC1Aqa2Aj7DiQK57cvofAoVtbi69q?=
 =?us-ascii?Q?DQTnhXSaK3mYBC2GmYIktR0ch/tUp1cx7MtJmWVTxfp665+YNbU5hxYQKljl?=
 =?us-ascii?Q?gSJxIZzI2KEpCL6t5gzEaDdgbt8La1aumP4adVFajy9ix/Z+ICBSu9hXD5f1?=
 =?us-ascii?Q?4BIcTMrxlFiiSMM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:15:52.9147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fb4748-bc97-4bb2-ee07-08dd5ba4cd0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
DP tunneling should not abort link train even bandwidth become
too low after downgrade. Otherwise, it would fail compliance test.

[HOW}
Do link train with downgrade settings even bandwidth is not enough

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 613298d21d03..ef358afdfb65 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1789,13 +1789,10 @@ bool perform_link_training_with_retries(
 			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
 				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
 
-			if (is_link_bw_low) {
+			if (is_link_bw_low)
 				DC_LOG_WARNING(
 					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
 					__func__, link->link_index, req_bw, link_bw);
-
-				return false;
-			}
 		}
 
 		msleep(delay_between_attempts);
-- 
2.34.1

