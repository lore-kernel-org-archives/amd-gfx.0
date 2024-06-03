Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DE5C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 459D710E31A;
	Mon,  3 Jun 2024 08:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fiD2HtX0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443D410E321
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdtY6nT/EFhFkicZMgvlVFKtG7Kpyt5xm64G2K1exVxgiYB+947f5rcABpoxxNw5Pp6y2A3ZM2Je96FHQrmSaL7BPHmJFx2X/crUsFqmnnaW8/MjnkgKSABbd1EbqGd+2ZYmW4lwAUiHZrWMjijWhnmHcBZVARC+jUJLQzwYxkuJrY0utnywdQsZ1hmvwdbce6nOWuFCagTD80u0iVXgLeTnRKsHQo1EVBYPELMyDLlqNYh/E1XcaRjWGCR5YT16T5r9p1ElQYT8mFZPygPsBvNG1iFPrPFXCXE24A68ZiBeDfGao0qDEL0v0bj4YwHRjbDW99EmaruwJ7+8gS6sFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z13vtwNkYg1AyyOaYQeNSPl15Dp3/XfLr7ZeqiJHNMw=;
 b=VP8HpfSZCBXTIGm2aaa7SiTjRUsH5BFe5mZIL7rI+gyReCP9MK6DImixSBSAaURQODK1cbRY3zc2c4mdNOuhisxF/p4624PKDb83XjRV+ytQ5Yab8kNjA4BaioD1OSoxm0PRLX9e+kJkOJ8ggNvyu8Z5ovoiZeqULo78WaUyplo85Mmxg9/RS2ZI+FuU4cvGU0wbJhcvfnbpanRvyVvVYcsWAs8zgCfXUDr80crf9yG/t2ibf8WukjVo5owcXBIHNEgBCGNIeusVpLDYdzZ1+/l4tiNhP6eHraWFb9ZoYD7YYxBRIn//fF9vDyJ+nLUuBTf3Y9cCKNwzJpUXTVdNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z13vtwNkYg1AyyOaYQeNSPl15Dp3/XfLr7ZeqiJHNMw=;
 b=fiD2HtX0Y2KrXdiEsTEHaZV9CCF6xep7bRoQFRm5hTjvP9R5bNEVzr94vIIrq+BzEBsDry2uPKwsyfGAOphG/9magwnsV5UR2FOGvAPCTdrG+t0uskmlLLR+GPGWeqDlerdlWCFJz9DE2S0LAGzuJ1bmIoylmVAjp4xB/3dSMFI=
Received: from PH3PEPF000040A2.namprd05.prod.outlook.com (2603:10b6:518:1::56)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:46:37 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH3PEPF000040A2.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 08:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 08:46:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:46:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Jun 2024 03:46:29 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, <Tim.Huang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: remove dead code in cik_program_aspm
Date: Mon, 3 Jun 2024 16:46:28 +0800
Message-ID: <20240603084628.2569810-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 504f8129-2e9e-4eaa-642d-08dc83a9ae0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jAqydKG0fdVhsNATPEfJz6yeNscp3LMXLbfSfKsdVDSbKNQc8Ba2Cy9GvSWh?=
 =?us-ascii?Q?+E0Pfp1dqnC/ladh70rTlYRSQ7bKNzkqBLWtmyzFktEFz4bap5d5g5Rvp18H?=
 =?us-ascii?Q?3mEN2g/NPJ/NK6LMMmy+60MPQOrsfi5AZYuqhgr00g7Ftvp0kVqnUNahZKWb?=
 =?us-ascii?Q?HQT6ubVGHfRkyXzm1xI89xBksKeP+oaH6YxePytTTEjIXifeRi72K+/bfmnp?=
 =?us-ascii?Q?puOzYmjxwFYhkvJGG3w4pks3Nevj7n2Bhyp4oeuqx4i8srIypMHEzSvojRUj?=
 =?us-ascii?Q?xApx8jzH870EDI5oQY4I3FWg/8jHRdPLsGEZ4YRyXQbMMOWtbsWnfLldp7Ci?=
 =?us-ascii?Q?9XOc8de+IsdsKeQewPSvgtGXhqwW79xwTbmRwLjYtoQywEk0sLhw4H11AJ3i?=
 =?us-ascii?Q?SjR+m5aplIDycltsaZ1/LMYVegggFWqjs7ETQDuiSE8nhgjCXdQ7TrOJWjTY?=
 =?us-ascii?Q?NWkzHx8jpoDDr/zS+3UmakHWul3UCNjpLvHZeJgv3qpuIMbZlBNTeWZKH49o?=
 =?us-ascii?Q?NhkBMS03TRXU8ZYZqCQD8dDtVRDN00L2ti1AcYRMsvzhVza4YvwaHcWiihKm?=
 =?us-ascii?Q?GlF5gxwkWnA9qMEwddu9TVOsqm5Gnbo6mI5bRCisA9ARygHiPRarPubfOjAO?=
 =?us-ascii?Q?fjv0dql7VkvKDbHP+AwMBx/Dw+plZsqqS/ur+xgq1LRen8xXRBzg1z6WIvoZ?=
 =?us-ascii?Q?lD25zdXAcyvUKqYsvo12nSuLwLP+mNe605YR7q/EENRw8qubk13RPxKM8Hz/?=
 =?us-ascii?Q?tE74dunmNqZ27ktcEwemD1/dWDH5JJO6qgIkQV6CcIIVsZxqN8yQWZ8T4EHK?=
 =?us-ascii?Q?srTLAbuC+dSJa8w2+WaIw0vO0UcMBrPX32wZ51LHa7319gVlwWfq+0Zdvj5v?=
 =?us-ascii?Q?UxNsaFhwDWp1x6te0IunWaDunECbLfsfF3BYUc4jqBwCbbfJmAeQ9p/9XvaS?=
 =?us-ascii?Q?t+6FtuYbRtl/DjNm5Qy6jSqmrg6amZ0/duzKHQZsWhckxvMvLZL+H+5hNMxc?=
 =?us-ascii?Q?C3oB9N/mal6AS2lDzM8RBI3I3L93UULPb4tJbuFhK9oxqQDfhuau3SOKAQ3E?=
 =?us-ascii?Q?JWSXQMGOp5SuU5iDS2w0eRDUCB3YgXKzA5FToY1alnJBONR3Y2w6r/fHMKXI?=
 =?us-ascii?Q?JLnu1wyzEcRJMF28u0KdhTOrOiMGdwe3min4t1UV5as0dpJOcL9wQEEywjtu?=
 =?us-ascii?Q?NgvNpSn2dg4eX8mIVY7EX20DU8jcYAQ8enVxULLJjGY/EERL0BbiO1BYlycW?=
 =?us-ascii?Q?uG6oaa5VpLndUE6yUkOoKdgI2vbXyNLZ4VfkAmdkI8fXCYjFkRVMJsUa607F?=
 =?us-ascii?Q?vBrpM5D1WbYAqHYrq//+Oxm54y8cMxyqkIVNLlWeHs6ogHQCqxyTscUAmEOd?=
 =?us-ascii?Q?ZzbNixxTQ0ZmjJzePqtTTzOlQgFv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:46:37.1629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504f8129-2e9e-4eaa-642d-08dc83a9ae0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

Since disable_clkreq is false, execution cannot reach this statement: clk_req_support = false.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index cf1d5d462b67..5428fd4071b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1777,8 +1777,6 @@ static void cik_program_aspm(struct amdgpu_device *adev)
 				pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
 				if (lnkcap & PCI_EXP_LNKCAP_CLKPM)
 					clk_req_support = true;
-			} else {
-				clk_req_support = false;
 			}
 
 			if (clk_req_support) {
-- 
2.25.1

