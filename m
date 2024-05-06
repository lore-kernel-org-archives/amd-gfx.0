Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D9C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 18:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE628112305;
	Mon,  6 May 2024 18:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19pTGUrv";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE34011230C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 18:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9o8llm7QcPFsBQ7S9Zs7lKaSi575NNNrbdx5rtbhBFut+nbwsAqkyfspWRmgteaE0DouYqkto1czWaJHMnn4D1r5z3y2PMFWMSTFd3t4TlH7TrLhcprCXlvesCLNAz6zMDB0UF6LclH1JXMdz2eu/qhVw0JVSOm4QNQm8IPj3PZ2gUTUQnVBdOhUtERsdZJpeh/W0YJm+qc4tIj8QmkIT0q67afbGuqvF103RjxQR7vxn43AJUDIgPoYd+R0FQv0HWzThqwWqaA1N2fI1mrXBmhyQeJurtSzorefwbWVWihsiggE6EWDoF1/T/+pUGZlg3WWsR3/PwwFVz6+Im2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/UsQxGHcwwpMoeiiTvvARMtboWjQsGQxaL5HJt1R6A=;
 b=W1mERXk5xB7z5l0CfP4612u9V/nBpRjDXLPikPJZ6MimYYl0lEpnoBris0BqrKffsqOl6bo/FEE8+ta5Dot/RZAu0w5dQQ2M8HPzurTEhm4LRJ/jdqd5rXg4KmeVs8tTTvwjnhDqwnBfSmL51T0LflhC+l0pgY/pwrX57DwTwI/2s7SH7lQeqtM5WZckNdhFFkHodPtkAx11l4pcc9iqqALHjqvdAMeNHr2Xx1ItQ4RYXY5ma/KRwzKWUcgzxumPmBNscV3ZAchMOpBrUVYypG2l2uHD1c3UE7bn2HgMJ+qLj8vnE7n2iBtGYBhepMTAuZP2EApTBAeYwSwiohxM3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/UsQxGHcwwpMoeiiTvvARMtboWjQsGQxaL5HJt1R6A=;
 b=19pTGUrvO82Xf93ZpKuxHNe/drpI1CLbX4ZjM6yEJ47ZFbdfmn60cQMsak+hTttnajjZ2mWa9jwBauBz5c16bSTgtLtsNDpjpAaIeRDQqXxKWVtf+8IymiLXThTcTsHrylmvDUidwcuxYo4txdTqjlhINMgY1N1M0smV7COhpKQ=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 18:46:03 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::38) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 18:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:46:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:45:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 07/14] drm/amdgpu: add set_reg_remap callback for NBIO 7.2
Date: Mon, 6 May 2024 14:45:32 -0400
Message-ID: <20240506184539.1669157-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506184539.1669157-1-alexander.deucher@amd.com>
References: <20240506184539.1669157-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: a7639277-7744-45e3-9b48-08dc6dfcc7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AMpX3sNzpNIwM+DIAH3sewTjNaoCk5gXXFhiAQarjYqOqSxlA8Qs6/sbBJBa?=
 =?us-ascii?Q?FtdR8oecBUj++Iz67A0PLH+NP37YVeZI58Hk/H7cEGSuhWzFK0bmVBRyYSOa?=
 =?us-ascii?Q?UR3zNG5nbr50wApWA3s/GDQBoDfVU2Q4AiEa4I6hsdIHi5CCWlpJmdjMZcA1?=
 =?us-ascii?Q?EKOLkmecIpIBz8oauMM8DNmgWpN4EUlNYHniaeyKfvDvRJNDMjpbvIi0LL50?=
 =?us-ascii?Q?9IIcH3iOtbHXgEShLCxSt7+9IiAHyj1fQqhC8zwLaNUM8PCY/A/c2TQNeJpe?=
 =?us-ascii?Q?n8NPEwhD7wG2dDdzKkhlFeb3W8jU/O+x5s1PRQ4D8XVXe8tbK7vtR4zBjadC?=
 =?us-ascii?Q?ieRkQS8TP7AzkiS52F3sGeGt0NoGiiSkN2W6YMUcG+9ZnCJc4Uu/Hb4pMaME?=
 =?us-ascii?Q?BtbiLT/POHj+zPwg1WK+hjhAGiHla5HjtnX6RC9rqHxV38K1NrkEjJquPYUB?=
 =?us-ascii?Q?7HBIcZxde916p/kwKZja+Ga25L2+qbvG1K91zyE0IW+0GG4c5IzlQl/Jt9BN?=
 =?us-ascii?Q?S7weRHQ79Gp/3CN2eUgHTXQ76C2FViS389BJxTAYy7G7q/YEdNYR9cW294jd?=
 =?us-ascii?Q?lL2TOsH12p9lxVZvXLm3BaYLaCKzx20RoGDILFs3BlUWNe/hu6iaxpPEKB+3?=
 =?us-ascii?Q?xAEiAUkG80erKPUlUqrD4vhkR1HT3lGnoGO5d9ttm5YuF5pbrqADTwI6BUjL?=
 =?us-ascii?Q?YSicFBBBCRSa1a0TgeRHatuehvEGoFn27anoq0LgmwQer9wPSy1eZfnnQqOy?=
 =?us-ascii?Q?z2eM+eXmEykVs3e+uDctHshLZrwyZPriZ50uMCzqVqz96VdwW4qNCCsX0sJf?=
 =?us-ascii?Q?nbdBaesxCzIR3+dNDs6vVa1uVHwvs7Lp7+VsRyFguDHDZPjVDZqp4to+Db7n?=
 =?us-ascii?Q?G47alaH8sa0myophDKB1UJq4Sh/3jcJdKQSw2Cgg9/x+r5T7jzNZWuv6TFxZ?=
 =?us-ascii?Q?KhGsKPleHvSmeoG7X7rw5ciA6q2+4/rON0znPRJ88WMDluDXAOkjTprfTCsn?=
 =?us-ascii?Q?hHsuAGPuopdSMXWDmKB2icpMrOoM4nnZqzSy1fdwdtJzLJrQnGfmBspz3Ikw?=
 =?us-ascii?Q?pd0b0hzCHS5hSkiidvr7wLNzxF/82Zq2ISDqeqni+GONGYCHMrnFuMj62fNk?=
 =?us-ascii?Q?aseiIIN3G9UKzF2rMOw0XH4QvSCccRo7SZqY21LQ3UGJAhLEnOfYMx4moLkQ?=
 =?us-ascii?Q?AsQU+hfotTaUlT3VVcEnWttRA3ZlLXAwwxPGiX1GUkWC2BGC9ENnZWqf8O+u?=
 =?us-ascii?Q?EzNFpYivuRxQgmc1TcN6sKkaIUHIsHNR+1WGAXvt7kAQS8Exek0rpak3NVBq?=
 =?us-ascii?Q?1lp/2T+DvD8/Lq7HGjO7YcqhUt/jj6/xwF245MUXlYgT/F/e5Jj9I6BIYsoG?=
 =?us-ascii?Q?xasXUgazJnOVPWXZrDSo1Tet+q2B?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:46:03.1835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7639277-7744-45e3-9b48-08dc6dfcc7e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

This will be used to consolidate the register remap offset
configuration and fix  HDP flushes on systems non-4K pages.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index e962821ae6a11..52774a096350e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -408,6 +408,21 @@ static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
 }
 
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbio_v7_2_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(NBIO, 0,
+					 regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_2_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_2_get_hdp_flush_done_offset,
@@ -429,4 +444,5 @@ const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
 	.ih_control = nbio_v7_2_ih_control,
 	.init_registers = nbio_v7_2_init_registers,
 	.remap_hdp_registers = nbio_v7_2_remap_hdp_registers,
+	.set_reg_remap = nbio_v7_2_set_reg_remap,
 };
-- 
2.44.0

