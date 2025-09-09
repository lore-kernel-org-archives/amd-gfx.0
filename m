Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1E4CAC585
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF2410E614;
	Tue,  9 Sep 2025 05:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FLEvcziC";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD86C10E614
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/kQlI2fnoBKWG5bwI6C1PG+gPjYzg48G0ty324g9KSI+qU6cP1Zwe88EZRM0hqZxqCyM0INb3fX6PrnRG3PhN6Td5/aYUPSY5tv79+efsmqM2L4DXRwSg+UxKvzDWABN3PHOydK+2GIQHEXCITGC2QaAP/iCmPja45WKN5ZgH6hjijQpmkU6YEqbUm4md/EkSz+yPQS7o54Zw4QULuOU76mZfCjGuv8Z/KM+KRh/8Yj7guHSFe1ruRFSv7E6kXcskdgUImq9Rfz+yFc0/31+MDb5HBUEyI7lc8Dwp5l44vwJhScUUhbRJhXIYkVJMcHXUctHVazDRbpYUqDaHHKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lns9SuXBLNokLX1pHKaYbs0Ab5fpFp7wgnpNF7KILCA=;
 b=ZAkEy+NjpR6w3BTk7kKDksPe9LRYn5Zv5ccKd0C+XG6ZtJG3IclOH15f1qAj+JQvpjTggqBrXXtGEhojHPhV/Q/NUA59LROOV2ELrS/lAI45YO0ke3yrJuRD2W8PfVDpy2BL2tAY/HGTMZX1PORg/nxb1fHnw0DFKGcM8D7qkjXsiebEx3ZFBHFlMrM9ZJUAfx50l2DOPD4Sp1mgojD/GkJcI+2W3TxtHSakyDGdHVhOlhizcrr+L2FZ4FKPbJyctPEcXKNlBqqncVSXY/ENKvOVZ2qUC3bAVzcTAxk2ah+b+mkLG3FKDY4ODivpi28CpbVeo2HVs73FDWrKvqh4WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lns9SuXBLNokLX1pHKaYbs0Ab5fpFp7wgnpNF7KILCA=;
 b=FLEvcziCsZw3P6F/RbH+BkNFdSUCXdfZ/fnE+4BT+k7j3tEYISideJMGFkWsZdg3n8kTKvwcno1zaUx9GK4eayvkdkUVwc1He2y0ZVgllKCEpjDRN/23zJ8uckuBCX8eRYkRn3EYK0OwWlU/MCNlyhRrJI1RLhuOfRhrAwvNuCc=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:11 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::51) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 05:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.0 via Frontend Transport; Tue, 9 Sep 2025 05:50:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:50:05 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 5/7] drm/amd/pm: Add schema v1.1 for parition metrics
Date: Tue, 9 Sep 2025 11:17:35 +0530
Message-ID: <20250909054933.2911159-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c0b7e1-83ea-4d72-6efe-08ddef64bd4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Twkh3oUDkrJ/6LzHKlmZbMu9uJfTm7Qj7ftZebqxE9j51DDjLHcpaojSkEeR?=
 =?us-ascii?Q?vakQ1577hbgxU8mdLG+gm/WqalFQRwJEUbDpicEanUFtHuDBH39543Uqxfj9?=
 =?us-ascii?Q?+qm05ryGNBsIkx/228+DTRJn8+wy8khyJqqBk9eIIyH4QmTWd6hRoXVWAbCw?=
 =?us-ascii?Q?oQKFtq/Tk/+VKwdhs110dc5JJed/oC+EwE8gD/PDI198vHZV7BgjT35piEYo?=
 =?us-ascii?Q?oo4VuoUYDT5Cul2ON1DrZCsZE5ooS0VFIFbOFbGIqFrXQpCvFSPnCNEbgpQQ?=
 =?us-ascii?Q?WDKm12d03wYwU2wowpxP+yt9nkeMPyr2/wIc5kUvYXADWTSrjIpxPT4rZlgd?=
 =?us-ascii?Q?xG07u6qQMpC9zDq542m4TXQqDowIrg88KgCHG14MT9iTtV5gl8r741nbOQRi?=
 =?us-ascii?Q?PMJ8/GypWX3gdmjEIGrMuW1VIzZgAe6O0aq3VCopJ71PbigRsjCBQbaMTDSj?=
 =?us-ascii?Q?UwMPj7AmSTmAozRgTczmfhy+Fy+dUM70vVLyAbyuBFptchCoVMRSNeojHaMo?=
 =?us-ascii?Q?pceMt6rM/t6aNKoQa2sev0Yj/1FWq3NvuTFAPjb3x+051nlHYuyBZuwxZTFq?=
 =?us-ascii?Q?iLCMMNKOEBmUqpQX4kqPtxZ8Qitt+EMpBDi28H95jMqkeW15l9+6cXsl0o+0?=
 =?us-ascii?Q?JbH/+5noyT+wZ73RhatMYuAQutBp/1M6pFKE/gG1mlR5aSAnM/1q6HJbj4tq?=
 =?us-ascii?Q?7AIMCWyDPMyWOyvHAjgQv6nsT2W2lPZAT/vy+9+W7eOuG7p1CFBOuRNyglaX?=
 =?us-ascii?Q?2d+XBumzAjKgg9vcC8xOn6LoTScO8uZIMoBw0f+2XqocZGdro4ocefevktYv?=
 =?us-ascii?Q?bCguGMNC11PFVGdq2SwUt07cGV+wlVooT1nYM8ktD68WI/JsK7LDp0OFv6rJ?=
 =?us-ascii?Q?h3ZeldG9+yIV03dsq76vFmgHBm3qjo0XUDdxy3mZb1CtvTifVrYZMAisXxbk?=
 =?us-ascii?Q?KFce8r4Q236mG7dRwsMGKvtvkaIa/8pY2MKyk9BMN3MHlb3rBPM2Qt1fWLsg?=
 =?us-ascii?Q?OwezLVemTARBqfdGvbwEMqjRuy8A2bAAE2gOc8VIXlZqj1GGbcYrXN7YMnTZ?=
 =?us-ascii?Q?vGMsyEUDpXAUaJdIEW4iX6JjvI4tBS5NzoBf59AZ/IptLAo8ODREG5c29rBb?=
 =?us-ascii?Q?ICi0SNV865xKn/HVmMqdxUDSIU3LShE/rwsVzmJXP5T/B2GcP4WIFU+QMvAh?=
 =?us-ascii?Q?XAcnyqmfpMmdGbyMCDGz+cgagvKFqnxrBkDCMDoHsN9I/iVsASnlWvBLP0Nj?=
 =?us-ascii?Q?dCUSt8ZGQIYxEkjVLl4OGwTJ/uVhyTNEYf35pNlspl3T+itYL343hqPhGqJJ?=
 =?us-ascii?Q?bwyJubojbPHJgWjzRhLpRXnQdkRnS/Ak5EwqYSY8vuIspLpfBOk5HAjYS1J4?=
 =?us-ascii?Q?MJkeJF7CiIYht7fliPtbEAd+BGTyntlUDRrnCQr2yAoy1xmEmHJeY6Z45dVQ?=
 =?us-ascii?Q?LJy+NrzaTzI4hR1OmILRpHCS54XSRRvU2+M/Vpdyjf92JD/SAyWfApJZT5tS?=
 =?us-ascii?Q?j+uQzqRdzeUs/7ZM5GsKRFRI5fRPuq99N/v0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:10.7607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c0b7e1-83ea-4d72-6efe-08ddef64bd4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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

Use a schema similar to gpu metrics v1.9 for partition metrics also. It
will have field type encoded followed by the field value(s). The
attribute ids used will be shared with gpu metrics. The structure
definition is only to distinguish between gpu metrics and partition
metrics though both gpu metrics v1.9 and partition metrics v1.1 follow
the same definition.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 5538c7c671d3..98de12b404b6 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -1816,4 +1816,10 @@ struct amdgpu_partition_metrics_v1_0 {
 	uint64_t gfx_below_host_limit_total_acc[MAX_XCC];
 };
 
+struct amdgpu_partition_metrics_v1_1 {
+	struct metrics_table_header common_header;
+	int attr_count;
+	struct gpu_metrics_attr metrics_attrs[];
+};
+
 #endif
-- 
2.49.0

