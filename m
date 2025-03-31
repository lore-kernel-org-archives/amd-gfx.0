Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B789BC3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 18:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFB810E167;
	Mon, 31 Mar 2025 18:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyog3YDB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D4910E167
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 18:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNVBkx8U5NCCLhBTMfeeP/flbjZqPmrdu0wlMmyj865+Nn6FMDkSUnvUk91Iyn3g/IUObUgtz45ljTnNKUvuF4u9EwfC/mn2aRQZ/jplXUn2zkC0X3YaP0+siItdO8n8C5wpPbNaBcjIuHNtUFN4g+THRP0AK3YXaJo6AJgRH/kfsQR8UxO0bImHvxK5l5/iGcG7LizZyv2wLeC8OigRJkRq7FDYWv8z7vOCyh12IgE8kbDKk+C9P4/1ZfYzPzecmjaF0UW2XIF9sXdDH8JXoEyqlbZNq0M7B0jiS8LaQyLRFB99prCu9DxZ3yB4PF1C9NIkZSwEWVBwmM5lgDP+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC1bSExIWt4D7NTIgSU2HCTc3myNqc6P59oILPBawL4=;
 b=eb9J4NSedgBbH/5+lMuTkpS/4e7fdlVD7qMyNBX60Ak6Q7U3UFywOrDZMuah5U65JFTlRtorpxcmdmgJpozkbTb1L2ZJa/8/Qr+CB54Mzp54OzeipXWennM8PugNe6b5BakTUGStWtB9fvFfRe2h6a/wh4thCxpwpnnivwSZmlERaA07rHjGnXk0xEATMSi3+zmEolC5ihj1T6sktyHyhxHZGHZZl9C27ScUzoZ5l8ahwHPrwDCeWMJ6h3q0rk57HgL7Bqyx/jidjFyMGCGbQqVsf3PFxq4DBddAem8MiB3bz4WMHKlalFzlnMdkNOO/SH7gYl4QKxJz+pKbBJPL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC1bSExIWt4D7NTIgSU2HCTc3myNqc6P59oILPBawL4=;
 b=cyog3YDBIiU1D2SsCzuL/T0P2xzE8pUnhYQdj8ISK2M1S1h90NKrUhhYgtDvxb/UMGxcTO2SsmoM5CTVDhlMStbe6kXf7NBOVTO+Xv06O7UCnxvifs7tfwTjmNs/yumcz+3mwwBX5BhRPe1Mxacrn4QMfoVcGqt00i5tAzes33U=
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 18:07:37 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::7b) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.38 via Frontend Transport; Mon,
 31 Mar 2025 18:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 18:07:35 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 31 Mar 2025 13:07:20 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <shravankumar.gande@amd.com>, <Victor.Skvortsov@amd.com>,
 <Ahmad.Rehman@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Add ret in ras_reset_error_count on VF
Date: Mon, 31 Mar 2025 14:06:57 -0400
Message-ID: <20250331180657.11808-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ffaee0-6760-4523-b834-08dd707eea79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?krcTxEcXAIx8Xn85/YwUbyvoh80EwsGjlN+hRlSr+oVit7qUeVToNeT7FViP?=
 =?us-ascii?Q?QyrJlLJniow7BMkrRRJaE/a/ocOk1dCJUlcYfv3axgrRNgf0eRnodRns9eeG?=
 =?us-ascii?Q?Q0NOEE/aPA8BAj6gQTfOT3FZR2puYBx+1GKTNhtbLE5y3TQgHari/5IvKIlc?=
 =?us-ascii?Q?ERsVg1KeNnVkPbPIG2rHKuf0ivb+v0VzfMpydPC2zjbT2HoSX4ZBi0MZq28N?=
 =?us-ascii?Q?jxXF6P0rcG6z7nkuXVaqO7dH6YOai4QLVmTR5AxelH3Wi7cWCnlAH/2MLkqM?=
 =?us-ascii?Q?0yXl7S9BajFqJpQ+5er9BhBjBeb+jbXZYcbuj3nQYD5izvZCYPvJZNHmLlEn?=
 =?us-ascii?Q?CRe58Vn70b+0TYplxoz/Kh0llxEovTKOOqLO09uP/4h4CPE0/bx7wn1wGT8Z?=
 =?us-ascii?Q?RTdyz3GtAX6mV1cxBhWY7Oj6W4Axas4LgsunPMA4hJkJ6MPGnE5O/tEUYA6T?=
 =?us-ascii?Q?ml+YA/TJKG1vQDr9tloM2yJFepVUwaMG8GqZ5rafy8HsyxpvVV3Et8cTkFod?=
 =?us-ascii?Q?gGzUF97XgjuXulodzN2Kg1tgqoA899BrN7KYe736CojP1unPKVuzmxE0E+R5?=
 =?us-ascii?Q?OueY/f400QBWsBu2YH6ekmyWfxkAybDCoClvDi6yZf+2JHK1LCHE41CMviRc?=
 =?us-ascii?Q?moTb4ePhr4CLQiF14A1XMOn4W4FVzLuVRw8PTdPu+eW8zBUtgGJRHX4RP49Z?=
 =?us-ascii?Q?u0BVXopbR7dpL+U0FwS1x6TtWHnB053kcqs/3JTdkC6YVHBDpZN7MVcsAkl6?=
 =?us-ascii?Q?mG3hhCZ5ip1bbx9YKN3Sa1i1JkF/zaxvpm3E0VxCNLLueyDKXXXdLGp7iY5o?=
 =?us-ascii?Q?77HGR/ox09CyV/+hHJ4ccSxc4V9EVO/o6unrR8Odu6NBuX/gNASNx7PjbY10?=
 =?us-ascii?Q?wsy817NUCvrtiNmQvIDWct9APS9qhCRvILuKni69g6I6W4kbxO/wJ9DcS8g0?=
 =?us-ascii?Q?9euyCoLjJb1rqgz+IxR9fXrYPc2e7+BhpkNfk3Uex3WtPm0BadF9wLyGGiV2?=
 =?us-ascii?Q?Z0Tn6OdwFVJe7SHbnWrkKnJxTdoFnGeHgXyjQOjLAOlQc/VQntzkxDJ5gflH?=
 =?us-ascii?Q?qfJ46Uu3FwrCoOwflNsLgkjeBSzsqgjyHr6ZgWKjkeKhXvHH80Xyhlblhrl9?=
 =?us-ascii?Q?mrwQ+eKYvhFH5v+/dbhYNIFF4/COCYapOl2amuoc/RvsH7AOGT7jgR7SbRXg?=
 =?us-ascii?Q?m+K4j5fYqkhG6vZ7ZLR9s0n79l1SmcS4Hl1+BGTrVbRRsMs8RyoVHInup7uH?=
 =?us-ascii?Q?v0Xf110cVFnnoFn0JyuSBUHFnUqN1uugplru0dEx4m3KxiNAVS76h6/EAiMa?=
 =?us-ascii?Q?NDSZrYoN+4Wuq+Cc2mg7+3C1UYWbNBxLE4nWSOLAQr8LlMYASo3opCL5bv7m?=
 =?us-ascii?Q?w9o3/6FWjlOSTEaf/6hTpz2oH2SXsxbdCUgyKbb5u+VKARO8Zoxo/6frEVaT?=
 =?us-ascii?Q?613GmMJJYZnzyle5J0LIoNsXtxW4dlM2cFg432MfJO6vCNxY/zPELXChEeop?=
 =?us-ascii?Q?wMofnlqvaX1SgSM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34020700016)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 18:07:35.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ffaee0-6760-4523-b834-08dd707eea79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
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

With adding sriov_vf check, we directly return EOPNOTSUPP in
ras_reset_error_count as we should not do anything on VF to reset RAS error
count.

This also fixes the issue that loading guest driver causes RAS register
violations on MI350.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebf1f63d0442..f8cf9621097f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1498,6 +1498,9 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	    !amdgpu_ras_get_aca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
 	    ((smu_funcs && smu_funcs->set_debug_mode) ||
-- 
2.34.1

