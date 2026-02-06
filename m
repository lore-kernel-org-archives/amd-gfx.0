Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA53EE2093
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869A310E1D4;
	Fri,  6 Feb 2026 11:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vQQUrp/+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187DE10E16F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkXT08lpGFr89P+DZlIIIfi6kGhgkCcMRxrv87LVDXcGeEpevTwiqkZ8p6RP1500Q0D9jnyH8eMibk0N8fHoxiqEpnXPPSS8agcG9iXE18bs1oIJXIpMFwfOyr7GKpTRZuO1yi0xSAQyblQMZZWNR6AyeNQwwjUfIEmX1U+ajU7+VsTK7xSc86g0ZvxA8D6LnY7PnQJXo+fXw9vcjuwbWOuyCHmM6nOs2FMZhmYLBaQgd4s9JTicf5x75ctdJoj5xd95188nvFb/2qkjcCoMO2ld+htS5/V0MwcazBbfRlnZ3OEhwXelGfILzSToVae1xTnWUnpJ046MCXu4pDL9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=E3zkihOOv2TnEe9M/ZaAjr7Zx4hhVyfwaJsDLAppuc058viky1eqD1Wuvr8axru+asbRFbVVXD+105WQNszplsExe2Q/WEfRY5w3B2YOJt3QCcPQot87ugaXC5shakZq92tSlJAYU4sdJwGuIR9C3xj0Nur3tV6riaeW8U0eQVikdS0fyrVCon66dQ7UkIX7XgDHrAt4IRcb1rAcwbH/H9Y7BLbrfrJ9ObCxlpIopROHxTU/W91VTQc29/j9S+l/iy4sQkLNYUzF+3ominW/6viGhGYlT07P9myLnbRm3FdTh5Dnb7xAn2bkdLhkA71X7LUM5GnMXxSkKEiav5VWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ/r6F//Lkv/+r9iJL45Q1YRrqNMibnrHDBYlvZFoYM=;
 b=vQQUrp/+Nh3hLE+fNPqsXA6mrVK5LTTTpat2E7uhKNhTeyBkQ1+8181a/FjYSU8+BfcoRHuORhTWrzd00JS6Nbx/gbDuq9M7o/gdnPG6UhIe7SwrZO6UECnGktsRVVAqDiLmfS2bov3voPS9IzZNXUc513G2xsvylQ6WapTEbIg=
Received: from MN2PR01CA0032.prod.exchangelabs.com (2603:10b6:208:10c::45) by
 LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.14; Fri, 6 Feb 2026 11:25:12 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::70) by MN2PR01CA0032.outlook.office365.com
 (2603:10b6:208:10c::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:11 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:05 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v3 01/11] drm/amdgpu: Load TA ucode for PSP 15_0_0
Date: Fri, 6 Feb 2026 11:24:39 +0000
Message-ID: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a12911b-af83-4c26-5ac4-08de65726458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2nJj6+BFEazCNBeLHBKs8UG+o8zQrFRCxbyOI6pbjj8Z0skHu+qdIXk6t1u8?=
 =?us-ascii?Q?ljouCdhXNwtp4MHxyY8LXd9dw3VacEXlmHx7wp/zJjTPfQ0ZNIaXFHLtAA2M?=
 =?us-ascii?Q?E03OjE2l24/kY3lmST2rJvT7jwuw2up0Elot3FCh/3mw0LFrS9TcajRGFpUk?=
 =?us-ascii?Q?kYxr7vr6v8KTPVzK4cjEwNxKfC0ULlf/YpONljz5RpIHIknkSZ2JoLdekJ6I?=
 =?us-ascii?Q?k+4fKZ/Q2jFCNXw6ho3OGJ0qDkx2qggvRsV8T07oJ1ak+GQBX5VaSskbBMld?=
 =?us-ascii?Q?Ng9tPpuv3+WLFaQkhEC5RppDF2qoE7k0u7P3lCi1o4DaHRXKOEMCiMife/Oy?=
 =?us-ascii?Q?uU9hr8LlKhWB/csSfYziv8jPuRaEia0JIz7qW0461kaMzPKtLySnQQIFifhT?=
 =?us-ascii?Q?pBAuz/cqo0FzdEGPIwFRPq0ILNC2j+Gioh9AtQIlEJZM8xuC6wf+nW+2bc+Q?=
 =?us-ascii?Q?MYdZ3Y/l6uBb954590r+3vumzNyLzi1vCpUoqXR880rUA4K2oBmR8jeHIERS?=
 =?us-ascii?Q?jc9vnKZ1AGCtJedccamadSeVhn0bUIyufgx6tCtAZxEdWDiAJC+KQRzh+R5w?=
 =?us-ascii?Q?tpe3LWe7Ctw4Ze53yDeVqT9gBVbJMPhoU9ovOF/Q4m5WoCQY59ee+yTE7X2a?=
 =?us-ascii?Q?su8YACzpnoL8hxE1MDRJMRSUp/a8MSwK52CtLZJK0+u8Ip6hdzw+fowagkBJ?=
 =?us-ascii?Q?Aw0JSHdRi0PYzVVRLzyYq8hi9sRqKrKusZw1HJb7x7Pt4imDEzJugHZZF69g?=
 =?us-ascii?Q?3LRj174cyEmtFgFiiz3C7UKWqQcWV3GWJu/AaSk/ueLvkwPCqmer88wCoqwL?=
 =?us-ascii?Q?tLfvPAj9De3kLJt5xIo75WSRp6AqgKs/0CbOSlGF2sHcl1qT5J6WrIXD56Xe?=
 =?us-ascii?Q?ousnwv5GIZKMg4hBfYw3ZpSz+S87lLrpOgbzbkPMc18B1EtgVNpux3DpJuse?=
 =?us-ascii?Q?wt47muCHnk2f2fM0Ua9SsCJJ0esmGykVHpEEd4OUtLWNKKleJkm8vWMHDVX5?=
 =?us-ascii?Q?tdB/EeO4XW63Mt0lm75MvuN7Nv9ZcPgG2pwK2/qfHCYCHZFBDVGJGJTXJFB9?=
 =?us-ascii?Q?aWfwXDlUUh7MYpT7PiNoaqnOhgSk2jIDfgsPWVP73LZzhhdJ9LI/w962qrv2?=
 =?us-ascii?Q?44h+5mkD6FYMBE5EstW78kWp0quvwxYdSFTaX3HKs6c0pGKLS+SOG3TqmKFW?=
 =?us-ascii?Q?WqvRnPyh1ly3mD5aG54funcyZKd4hG/Vz+SZ/vT5PVLO6kiZJCevZ5G9vn6+?=
 =?us-ascii?Q?cYVLIMeGzmb6ccoKDDCqEb2/KQZXPt601P9WKfJ3QfQbGyNR6jZQoLDVqLXi?=
 =?us-ascii?Q?ZfVRaPkMwK0ftHuJmNxFnXxJwdYMRkj/EuWHgw8atZC0/7dQNmnsEloD+peP?=
 =?us-ascii?Q?Ik2ontjbL9EogBAEIFVoyDyJknJkt8ph0ZoggkSnzz2alBWSqrpDcyOfGaw6?=
 =?us-ascii?Q?sO6SJAc9Qes+ygNLnIry+Tr+WV9QX8tYEn7S49YCRnqKBiy89ZDd+dlzk/nB?=
 =?us-ascii?Q?F1bditIv84A4oeGW6b4VxEo/s7UvRy5WrwW6kCznKvYIZnlRNRur3jyEnL18?=
 =?us-ascii?Q?a9wgr10DnpO0wn4fMkeRE/i8ZRJZpS+aKmFBMjeCLSbUy2mqRmD1syzO8paG?=
 =?us-ascii?Q?O52GDJVt6ZfMgVfXCWyZ+bKQjTWkz7OO5m7SzH70b/SQ0Gnfnn7P07J46vmU?=
 =?us-ascii?Q?DBR3tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I+44YALTChTu6DuanjcMgFZljk/HAz+FbT9crQSZJ4EqrQR2NVHKyMm/U1deLNSjICcdSI0yqqSwsL6OjRUEtMTjsNbwnG/Lc5nqo1d/Ije5mnDh8uNB3MWmX6lkI7MgB14iD3sDVR8fWpuo+12RQ2NJDQ2qb7Av6QCUK6DJhXR3yTDJNd+ZS5iteBIy1hcuBo2qT/jZRYItLf9j6rkm14z16lQFgpaHbKdlfhfLxQXi0fpkM8Tb02tCKHr5DLpGfSvOqLxCfBqD31bJvQSuq0LrOMibZpAQp/WpCsd7yKZSyagaUr9jRg+ep+b8CDDYZQPSLF1sUWQOdyuWfAV4yfPO4wwhUqq5O3hAzCj9Irb0ju8rX/o2mzw3y0jcgJMtebjvChgqHpUeheohiw1DhtCuNqXAtznLj6yifBbWGZOzZMqJ2tP84XdBdaiJ5wfW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:11.6929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a12911b-af83-4c26-5ac4-08de65726458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

TOC and TA both are required

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 3aca293e2f0c..723ddae17644 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -45,6 +45,10 @@ static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 	if (err)
 		return err;
 
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
 	return 0;
 }
 
-- 
2.43.0

