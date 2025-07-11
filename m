Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD44C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B0410E9DB;
	Fri, 11 Jul 2025 09:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d12NHXQA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EA410E9DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqAP2QxFk+6hRwhLoRgWhRJ0slRafKurgcc0nUg1ZWhgRBG0Vh++gOaOPYr20QlvCjBtArezrzH1Dmq1FsUP6cwIghgEokyo4fmuHx9WXqL+L5I1yV9ep/i7zMSc12ET7K29Vyl1VbItpxsPcPZQEyLG6w/DHQeE9gaV3YuZvnV1UEuzMqy3sPaNMLWaQh3nE8bAkVdYZv8iEFxQsNTQGebDxdS0j5nL2W4Rk9vbQIjGVf00x8Di+wPwDfoc+jWupNUqrNC91jTdAQj1SEmFgXmYq8++S+Rggt6/pdY5MxlS0iqPTzdzStN8NwSFNnMl8PABXY93a8MgTM66WSjnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndjiU/4DmAlVduLB8sVTNqJ4DuIMsROHGOtHUfjmY+A=;
 b=x9kRXlrnFzB90N33fdBBvJx+1sOSb8/07/fLQPt8YJDQfD8N3EbzvAQIGWMTCaTPe/PQhevkcDQSvXGMTJ2j+Hoyv+nblKdWGwrLj5kbOchKWziq56smMWdYLfeBNPuSqlLQ5tFH97TLZxcCPK3JUPckLLm1hKeoc/PcvRLzBjdp6Pih+wpVgyh2P4+QeLM20SrwjideedqXNr1RA2snAC8GhZZsHGV2cmV8BowjTh+8KvKq4HhHlUt/bQFciPNTaP8BQ0HUDURp6zIRmcLJV3E2pFw6WpdbbEdmCm4ciM3M0BLr7x47eiRQiu4w7a3XvT1m1SzZ+nGov/c7ZKjlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndjiU/4DmAlVduLB8sVTNqJ4DuIMsROHGOtHUfjmY+A=;
 b=d12NHXQAVmMkWUn6Fsoc12ukKAu9Hk9r/NR4b38KXCLzPmXiOM73QCXuxGXzKS0mJvGnmk6xlZvr97B9OQAkEqWsizbvVHM6EdDRf672/izTI7CiLENAnOT7A5HK3x3drCQ2AoADMW8pJGC2rNU70Km0rUe1bKGnun5kjWjnMO0=
Received: from CH2PR14CA0058.namprd14.prod.outlook.com (2603:10b6:610:56::38)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 11 Jul
 2025 09:35:46 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::7) by CH2PR14CA0058.outlook.office365.com
 (2603:10b6:610:56::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.23 via Frontend Transport; Fri,
 11 Jul 2025 09:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:35:46 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:35:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: Use cached metrics data on arcturus
Date: Fri, 11 Jul 2025 15:05:23 +0530
Message-ID: <20250711093523.1468431-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711093523.1468431-1-lijo.lazar@amd.com>
References: <20250711093523.1468431-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f6702e-c95a-46d7-3fc5-08ddc05e5044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zTzJg4bvEq58rztsjxlUtKycDESRBun9Jfxq9daE1y0vsPom2+0ILIq9kwq?=
 =?us-ascii?Q?4cPlnVaNMKTJfSL+atQ+pLNB14XW+U2oqPSvoCQMJphqtiIGkHFGPCEALaAp?=
 =?us-ascii?Q?rNMNUSc5eXo3zmmMUtvpZpz7DuEsaakbPEJn0yS86y59ketsjsWZ+BkpyM7i?=
 =?us-ascii?Q?YjPblPDcDFtsvzOF/pH9ZpbVpn8jk5bC3Pg4eAsxsfXR3R7RWE+PJKDl5g4s?=
 =?us-ascii?Q?30OO/N4hBxct0M+OZc0aVPUG20/P3ywW/ZUv1sBdJtuv3fMBGmtrS4Fj6eYD?=
 =?us-ascii?Q?e1TCak5dpygazWAt4qDZqZcMzyN0gdsSak5R+nyg4Yp0DT/Wi7TC+dJv4fsw?=
 =?us-ascii?Q?ymIFB01npM+Q1LSLUuiFeueQcpXnYZq3KbsrcV7KcUYtHVbhy2yxQQ6qZzRG?=
 =?us-ascii?Q?6Tjk6MKzBugy6QHlmJ+ArPNBr2jTIo0zVWZBk8QGBVZQyiCSTUua0PInHEoh?=
 =?us-ascii?Q?OfFStW4Cz4SOv11EXUUmOaykfKAFvtGJOBjyWLclP1W3Lw8q+nWOl0j4jBSE?=
 =?us-ascii?Q?x8MJxMvibsrRJHIbamV3pvNoYSLpeNO/djAGIe+92J8NVCklTLKplkI9nXcN?=
 =?us-ascii?Q?I64HsgcfcHxb0fUCoRXPUlDwE4W+kFtfzRhwoMPXiYNMzH68k+l5uXeJOVh0?=
 =?us-ascii?Q?7TKDOzcFMOsuVHXMLYBN3dwHemvn3PpDxuZ1iUgIQUpwgIasOoVJNtHALAX9?=
 =?us-ascii?Q?/ml94qyCOx351z/J3eT2VdftRtmsik1uc5YmF0j6BU1aM3vpa8GKqeG4p4fa?=
 =?us-ascii?Q?E1Ls1Lf4JehyfRWALO5SWtdYRfg9OjNQCgTE/wtu/sYt3oIJ4Cuz+EB1dz3m?=
 =?us-ascii?Q?E98TmBdOOKgv12RD5B+p6HsJy0musMYFggsIG87twtTfuBVTy0FLpLYLLwwe?=
 =?us-ascii?Q?qV1SeyXGC/ifqnSB4GxwwVTIIl3OXjmV/Kk+ipW6iNCGesxYQFGCUwySS0PY?=
 =?us-ascii?Q?c4zrFnl3C34qOcqBEQRLP8Ndzyj0kRK9J5zICr7gl6F6Peo5UGOe3jVnKgz0?=
 =?us-ascii?Q?MrjiPWQIRG+Z+oTrJpcf2i1SgLGdlOC/+q16LqHPdbs0CFPzdcKMLzT7IubH?=
 =?us-ascii?Q?FqcszC53JU2UxEfpf2GiMVlfhVl1gDO7SY4lPZH03bx6R0pw3ro1dURXjZor?=
 =?us-ascii?Q?AH5qUxvPJOnsceNy3eBkbcUmN9Fh7APhI6uDD7rxJvMc2BPLUgGZ6sxtzbcp?=
 =?us-ascii?Q?0xdugOEY97Y/XLpWrBtJkalSY5DRcwT3CUGpAI1rhpE/HEvb41hH4ZZh2cI1?=
 =?us-ascii?Q?fCjxrtG07bCEIJzn+YjgNw72GURLpZssKex0AwQ5gN0LLaPLfVyEQYjnEMUD?=
 =?us-ascii?Q?joVSXDmSCv7Z/ibs2DuGkrUGouBiHYafVzkb+tgwIQD4XvLEaDiNykmXSkiJ?=
 =?us-ascii?Q?+u2iugRRxbhYLV4+6jYvYSWB9ZxuKxFxh4P8/9eQfZMDK8BEdm8xnXBuer8P?=
 =?us-ascii?Q?FA1zyDIRE3aC/dm7WW9NtjPL2YBGqwoqMX9VFDwvSjWj0Sr6Z0nBn1hye+iG?=
 =?us-ascii?Q?DvDfCjyaYzWtwiIdymQtMp9cze9TqHApTbhb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:35:46.2055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f6702e-c95a-46d7-3fc5-08ddc05e5044
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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

Cached metrics data validity is 1ms on arcturus. It's not reasonable for
any client to query gpu_metrics at a faster rate and constantly
interrupt PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9ad46f545d15..599eddb5a67d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1897,7 +1897,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	ret = smu_cmn_get_metrics_table(smu,
 					&metrics,
-					true);
+					false);
 	if (ret)
 		return ret;
 
-- 
2.49.0

