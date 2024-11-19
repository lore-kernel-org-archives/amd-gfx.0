Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707B0D591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE24510E5D5;
	Tue, 19 Nov 2024 06:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEMsdlt4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF97E10E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbcvIJrqORSkE2h2ZA8Fvrih2M1dW8PfQ9EEh2UWx3adKYbQvtZ64szwh7i4tUkl+TZDbE5Q5wGyh/srXgmM1X/9WxEPzV6ziUplcKo2CJrQQs/XTJFDWtELq9jGSwOvlOaWayZ4TZ3fGfr9oqcEtU0t3qG4NkWAAwMqLuAbn8ZAD4bdXhNBUX/sD+QG7HMFt1jRW8eVERR8lmU64cmEBirvWhOgy8EV45cMAr6kYgipE7XZZ62mWkQL0lyWVjcqERWXC59pweR0Fe4rA1ws0vf1Jkh/boSpjeCU/ueRmckdT7XwojBi6h42voMjKuyfkKQ7Sfcx3cTCSI7la1ketw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AULSyBVP5IDPIyxIooWyrtCLqFCgSzhUctN9+ObPrh4=;
 b=LZZ+aXSrdtfRYKsW3mxk4hH3azd/GoYTPRAUUSF6aT/axJBDu+uDAxG5tbrZ2URg3SRwAABy9ImYILRp1uh3/bSlILDvylEiqFTycW+47VbbBC47/+3e9ASzSwrQWQVardJAWeGJup0HUjcVXbbLSy/mIYJ9GSBAlimwnoxGARpL6339mmtv/CUR1jd9LcM9EyNdy+gCc/yLJqGdaaPmN6INoxVCYGIzyWkn9MZMuABj1KlEZfaV/aWKkuJlxNatgu3oHU6evyHqboXbD0me+0EQMndaktA43vph50sY9UlYGU4EzlgUKBQOswsD2XUgywHw0pAfSy0db3E0UT4B7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AULSyBVP5IDPIyxIooWyrtCLqFCgSzhUctN9+ObPrh4=;
 b=lEMsdlt4aRdj7x4i/giuj3ns7EcEQyrOr8g5n2gAIVm1vqDs9XlSmOkwXYosNI+XFLHKPh4KfiCBvvet0EGZ6bUYjLz7iZU7lrEu2JtX2ksIsBxJai+BYVenRUL+qBmR+5YsgBHpdMNCQKQ1TZgFFY6ov2oRwOQSPDv5aj8qzvA=
Received: from MW4PR04CA0074.namprd04.prod.outlook.com (2603:10b6:303:6b::19)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:36:50 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::99) by MW4PR04CA0074.outlook.office365.com
 (2603:10b6:303:6b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:50 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:47 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 21/21] drm/amdgpu: set UMC PA per NPS mode when PA is 0
Date: Tue, 19 Nov 2024 14:36:04 +0800
Message-ID: <20241119063604.81461-21-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b0ee8e-d7b0-4176-c43f-08dd08648c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OtFglaRnqsq7Y+pl78Xytqma1Sm2gmc/amVy7I/3T4zYBw3zaqo+XY/eeXFR?=
 =?us-ascii?Q?Yc0s/ilj17HZOemVnPN7H8ceh+BWcpH82upl7vZBQwmNacDDxyqDcLeCwPOQ?=
 =?us-ascii?Q?7svm8HQbix29NeOn4A2W41kEfzNOgGiof1uDJefKwDCnO16z51EtBZp48y0U?=
 =?us-ascii?Q?1VMVGmBSSdTrrNXgdObnj6rXwn1ejWOU3b6oOcnKv6TMgcqQC27VJjKHy9ix?=
 =?us-ascii?Q?M5M+w061SYC3lr4KD8jT4EzeI0iNMR4vd1e3kD1FVXiD4kSYgFk40d3aZPMh?=
 =?us-ascii?Q?Cc7uuj2gOK1Oicg+KTT6Q1ScbD+KyIO6L7jsyBU4xfD5w/2oPMDn27gauFpw?=
 =?us-ascii?Q?oaMOKDuq0v9IfiKbtR3L0bTYmD/PcKJ4kV4BtRSt5WIaJqu3O2P9JXlsaIqf?=
 =?us-ascii?Q?IeMwxN32/TALit6La9i4QdA77hjHgDcO3xvFEqnkBTcgh9y6DbmcLfGUnto9?=
 =?us-ascii?Q?bqaJ6USuKyIQ30dFqngycQscaYYhoTPNe8ilDnuJQyzFF4qpenZnSJDo02zw?=
 =?us-ascii?Q?O9lQa1piCkwVOQr+mXpKA7IcFfyTod3MOu47tHD4L/9cYsQUQAarp8GHkJIS?=
 =?us-ascii?Q?0rWJpSggH3SNMbJydVXC5AlvEbaqcohAleixWT05RHH3j4YR6hzOzdUOeLIz?=
 =?us-ascii?Q?M/pujRIGLGpbIlDPKapn/L4Ag/Sse8b16K0YkGo3Fny/0Xx3eAge/GnDLaQ1?=
 =?us-ascii?Q?kbRNKkHT1FCrtQBRM+oMJNfYlYsvqZk+apH36qvBMH+/xFCNHv1ezix1Dsv2?=
 =?us-ascii?Q?YrgLeiTpQAk6wBqZFup0CChuXhnKZnEIBFx2iwpyuap6iCk5hWhHpkQKw1g6?=
 =?us-ascii?Q?z0T+S0vlqS8i4OAXyaebt35TgIH5lGX9aA9seykvkJOghVT6lx89iixYpGzi?=
 =?us-ascii?Q?rWxBodC5Yp53V+x3JqI/OGRYKyp5U4PyxKxKHwLAQT8FECQNaFz+p6Ly3Ohk?=
 =?us-ascii?Q?vqDWrCZoX+yA5ZFV4LoYj8ZxI9EmCSxu6TxodDAtbAgSODSAY1jRHPQL61iV?=
 =?us-ascii?Q?5yfntHlgiqpJVN3iKr4NgsrddbqHrA9GoFM6slqaJoO4uxMpq1qiG+uKpnCR?=
 =?us-ascii?Q?RLa2Bo4By6o9UwFaVDjWLK1lvewEg9A71+tU8iwYPCQnhQTJbWpuCeOr/qnH?=
 =?us-ascii?Q?zJzt5pQKyCSdzTv/S+pUER0JTjck+tGAmGNSuO+tjYtpJW0jzJX/EhtAfYhK?=
 =?us-ascii?Q?toV0s+xIiIhPD7JbGLieU6EZruEdA/uUYxM6g3mqj1+x0NerGzxn02VzcqNL?=
 =?us-ascii?Q?NHeqBT9+w5iEo/mVFNPurf/rPZ353KTmmb3f5nMEphbY/ILTXEx1TjcP7wX4?=
 =?us-ascii?Q?H7+8/ZoVkbyKye4ZIt6vGjEVIA0tEDdJrqjDfB3LGn79VyACLgsyhUcQjnOe?=
 =?us-ascii?Q?rdlYBn/JvBeiD5TrBgjAlxQ+klL55XDQDZV0LK2YNxXZGPxGJw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:50.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b0ee8e-d7b0-4176-c43f-08dd08648c75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177
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

The shift bit of PA varys according to NPS mode due to
different address format.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 30ee4cb9aaab..a7b9c358a2d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -467,6 +467,8 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	uint64_t err_addr, pa_addr = 0;
 	struct ras_ecc_err *ecc_err;
 	struct ta_ras_query_address_output addr_out;
+	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
+	uint32_t shift_bit = UMC_V12_0_PA_C4_BIT;
 	int count, ret, i;
 
 	hwid = REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
@@ -511,9 +513,14 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	ecc_err->pa_pfn = pa_addr >> AMDGPU_GPU_PAGE_SHIFT;
 	ecc_err->channel_idx = addr_out.pa.channel_idx;
 
+	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
+		nps = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
+	if (nps == AMDGPU_NPS4_PARTITION_MODE)
+		shift_bit = UMC_V12_0_PA_B0_BIT;
+
 	/* If converted pa_pfn is 0, use pa C4 pfn. */
 	if (!ecc_err->pa_pfn)
-		ecc_err->pa_pfn = BIT_ULL(UMC_V12_0_PA_C4_BIT) >> AMDGPU_GPU_PAGE_SHIFT;
+		ecc_err->pa_pfn = BIT_ULL(shift_bit) >> AMDGPU_GPU_PAGE_SHIFT;
 
 	ret = amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tree, ecc_err);
 	if (ret) {
-- 
2.34.1

