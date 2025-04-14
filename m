Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702EDC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003E610E2E5;
	Mon, 14 Apr 2025 17:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0ttbG2G";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA0DD10E02F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHG+ZykEU3Yrw8gS0sKdZmfLgZPUGfUE2QLyxzD3ym3nP0GLJ7AStt95MSPq7kfLGnJCpgNK/Dx8wgerzvcwB+YNeEB7n4hSnxPBzqh1YsxLI1tBCCkZnewLOWQO1ImfXejUYw8Oxnep/HhWAJfPbN8GUyZbarNlvCAjexfY3u50N0PJxyD0T9I0I/NaPcGTESt2GBOlYRhxjXC1y1eNZf/2tkl7CIk/GVbZNuNYHuPGrNUItNaOg4Oeu9VZ5oTphJkoKH/L18EtjF67Es9dMLLo9Ov21Oapi/bx7I788ZLHDMUsanG7q24YFoARtbtjIft4uo4eF024NsNEPUg1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0n5MVkQxTePiiZ7FsLUnfPjJ5tzSJSNjV4nwaZOsiE=;
 b=M2X+2olKK5iwFliBDqzUBpPwhXKZGfBa/jLGX2DzBXiTaHTrCiZ+gmMSc2KTjb/7aQEuIf59gCJ8qkmaaIl6q9vM4arFmbylsV41FNhHC331CnsxMrxTATyBTRo1l637Z1y4CiwshCuaZAXbMOkW9knQwMY79z4H5fanzS1x2y2jo3CzaQIkPvtBKcfIFwsy9oQS7jh7bOJcZikosJWrhLocZgdoJPgPAR8kUE49Nae+rn8r1BI7/+VfLP/lXKJeOlC5bJ+y8BS6ukEOX5zhMFKdtspL9Xq03QFr3zQo8l1TSvB0lRAoipj1m0auebCXjEYCrvd2CaQKmG9gj//biQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0n5MVkQxTePiiZ7FsLUnfPjJ5tzSJSNjV4nwaZOsiE=;
 b=B0ttbG2GFZarC/fBn507kM0OZCChE6Og2oFGSEJEQ2YGGKN3pe14DK/d6brsSkoeLWfFZ/yZ3jXqX2vUaIxvy2/yMzmxlbxsZ4WdcVEH8gRUIpsZWR/TaIqDHtBQAab7VOsiW7RbzLH21JjIqk5MZRkRMETJxvcI2F0K6aagzn0=
Received: from BL1PR13CA0326.namprd13.prod.outlook.com (2603:10b6:208:2c1::31)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 17:13:13 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::9e) by BL1PR13CA0326.outlook.office365.com
 (2603:10b6:208:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.11 via Frontend Transport; Mon,
 14 Apr 2025 17:13:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 17:13:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:13:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/userq: track the xcp_id associated with the
 queue
Date: Mon, 14 Apr 2025 13:12:56 -0400
Message-ID: <20250414171259.2996574-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a5033c-2c49-4328-2605-08dd7b77a39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QQa3AYHUc6J6GXThsxtgF2gvChgwN/wB9iBVN0hZa6uneiyW2bIUm+fX073d?=
 =?us-ascii?Q?uOe20ybXqhWfcQPZg0PV0S5qEWAb4UMKjTiNMyWEa18lNreAM5eu0IZD6my/?=
 =?us-ascii?Q?8BTpdOEEoVNQFpaCzNwkXpR6Gejz6tCp/nf29vS2rkI+J8Lun5hS0tY42cFr?=
 =?us-ascii?Q?4D73qRIlB5mjgikcBStIn5bKT8oaCyRErL45wMONN/Q8J2DjFBCN1emndYYG?=
 =?us-ascii?Q?+DHEDfpKKRpjeIY63u/O2cEMo+TDI2d5GYPzsve7pnlES27LgCme5L2tUkmG?=
 =?us-ascii?Q?Vk69bsY3Lukx42U6pfZ29zqD00nRn85L7rT/0HIcUgNEIUIv7PKQs4+HLlga?=
 =?us-ascii?Q?WOwi53FoumNN8P840CDWa7gf+PCSafv605mfk28gkkgyIAKFzQgKGmaIXrYD?=
 =?us-ascii?Q?zmWT7pF4uGffTuCRs6FMD43PXl4UimCi16f2F52n3F4gpegzGdDBDVAcrhLR?=
 =?us-ascii?Q?VmXedJNUd4CyZ1kSdNdfW9br2855fFewZSghJGPeQl5F4z6QMQeT4Q9AntDk?=
 =?us-ascii?Q?IQwyI8Wg7HGPhrfj5JKqBA/FKyumNqxga+pSRDIpAz3VsItR8viw5o3pXnTE?=
 =?us-ascii?Q?e+EEq5hXjQwrHcB0zHEZGJIT0nuNaHBkosew/Fpbcs50nkzCzHiNbw0SEfrm?=
 =?us-ascii?Q?sJ6DdRMTt7h4B4GkTdJzUQcSotEJjXXu7JLbogNdMaGxS4mu6dO/Gw5LQ0ai?=
 =?us-ascii?Q?j+o3OIHSViH12fDcDZuTXFhgJgLSgtacTiNX2FroeOT8peDihQAMU0PYEG8I?=
 =?us-ascii?Q?fPbeBcc8e4AxgNyQKXBQnWsrolzA+2ivGRycu+IMjjK8uFaekD14q/JNDQ25?=
 =?us-ascii?Q?pQ6zC5pzAHtpLQGaheo8V93FFUab7t0IojqyQjgPYOl5kw7jfndd3wJPRUwo?=
 =?us-ascii?Q?tsWt9hf0QPdAOJ0XLFcBnmkZDXPptiZoxQslsi/Bhe6AtPsyyNV66YGGbU0d?=
 =?us-ascii?Q?ZDeWgK6kHOB4+oKlt563fmOOsWHkrkO0u5os/xj9JLJVblH7jxFvGrwm5K2o?=
 =?us-ascii?Q?3Wfr7nc73CIypsq41Y12s/FPWrq4ACOMFZHunoeszdIHuKIr2OTosF+QgTh0?=
 =?us-ascii?Q?ITXDQP0QfXL6pRyF+vvq2mVpsz28UvGkailcw0xDQDzkUyz0Dn9GgFroRpsg?=
 =?us-ascii?Q?CWWWPvYumpSs/EMwvvQSSVJoznhXpHCdgv49ZwXrnjgTRREMB5ff1c1C8Y4h?=
 =?us-ascii?Q?1IqWc4H0+ZdRcs04nKZaomq8hHT0ny/I/+BlbEyWbypXDc8jB/vQSO6UmX2J?=
 =?us-ascii?Q?RHQJpBLdd9dLKz7QNSuF5U4jf2i7pJhyPWCsRWx6XUCinbKsTuITp1TaLfBJ?=
 =?us-ascii?Q?AnqvDyhtks4AnZZa85cGwtWJKMUrpPUObYDE/jll0svrUJApoQaU/+EmJe2B?=
 =?us-ascii?Q?tqM10zd4t1q3ggLFl+oBMjaKvdtQp1AyQIf5fTZI+pQ84YZ2fQMH35C7nMCy?=
 =?us-ascii?Q?SYvUAwKaaAo7GMw5iLuGD+KRFnjpdB/wG/H05a91dDUddjXItAkIU6MQDXpH?=
 =?us-ascii?Q?0kZh6RV0t4pRyEFlJriEW/53c8VdAa5HhBrb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:13:13.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a5033c-2c49-4328-2605-08dd7b77a39e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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

Track this to align with KFD for enforce isolation
handling.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index 381b9c6f0573d..db79141e1c1e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
 	struct xarray		fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct dma_fence	*last_fence;
+	u32			xcp_id;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

