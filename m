Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD87BC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 14:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDF7113404;
	Tue, 23 Apr 2024 14:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7TTZm4O";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AA8113404
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 14:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWn3XK3I584FieF4JGuI6A0qwlBalSVh/DLAQcE4gJp1Fr6Z34yg/3Aj6HWPtgfKHqopFDRJcPr+ibQQ4TVdFDoDjuASQCY3NnMdPtJ7Iqo3U6KYb8+zTSFZo/8MDtm8P9jGZhnooJEyoaquEWLTfW8Ifsbf7FyFFO2WphDivY4l7vU2sR7QdgMArlk5wuFVOf0EfEjNiIptZM8YfTKM4QjFLQV5c2+fPK0xK1AW5yuvZM0vBUQQfiGha9d/5ekBWsYQ0WZSQX9El2siK8YWVtCfGILxKgfPP2RnlvayP0NN6G+yp0Rr522h+qmN/CHSVkBB1ewMyNFSfQb7MYVYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVbpiD+Q+zTGR8wRsCOthJHMovFCWjt6eO8H9HTVXhc=;
 b=mtJa1F7pDmPgGYiF76Ui9t/Di5Vn3DhDI7L1bDmT9u0hJbV4R2kQT+e3Bs9DFAKrtY+gaOXW8garBUlo1bQkpYLkQM1oRzs8Xh4LaUjjiPi/Sxt8z3NT5FGpAJyCBoeIJlIe4YMpjuEioClsimsnF8eLYmTwpuaoH0cZeFZzaxtkI3BEXYBMeuST+6DHW8LzYHn4cSAOpnkQP/hg4loFwvLcxqrlvdgkO7d8D/03wa0W2ZxQcFyqPhpYfK90cmjUSycPtaDYYULjgpd/94XqMVLNfc/F0lgxnhSNboQh4m4RhMJ0dyuuY4xd15lwWwlVjrRGJ1VFzpHmgHWJmrPJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVbpiD+Q+zTGR8wRsCOthJHMovFCWjt6eO8H9HTVXhc=;
 b=j7TTZm4O7is6au90+bgNszhS2vBsS4E8ha/iey3S5zccmgPATddxPJtIIh94M14Uap2w0nRQDBiAQy9DNKyyr4k39Ocd5Q1IgqQPMd4wXVxPhD22RXeOgMEzmJjdkQI3ze/GAV64arECunn21wI3OPAjPJPoYHuEn4lx4kGqMkg=
Received: from CH0PR03CA0433.namprd03.prod.outlook.com (2603:10b6:610:10e::18)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:31:58 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::1e) by CH0PR03CA0433.outlook.office365.com
 (2603:10b6:610:10e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 14:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 14:31:58 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 09:31:55 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix uninitialized scalar variable warning
Date: Tue, 23 Apr 2024 22:31:09 +0800
Message-ID: <20240423143109.1288890-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea68817-924e-474d-45cb-08dc63a221c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8OXZeFy3XkHRXAAqhqulKY9Z7gZKVu3SR58dk+XXN9cXy6E4FIC+c8n/ccHo?=
 =?us-ascii?Q?bcEBEf95Q8t/Ayx6AkhajtR683NanIwqkkfZ3kyWBojuHCAwMATxf5AMBGyA?=
 =?us-ascii?Q?Tks5UQFHPd5tROPCI2Zb4m4bBuV5ZP8FE70B5E4N56bUww3orTOjsfv2awrX?=
 =?us-ascii?Q?BnJLpOlmW4BSY6FMtQG0daPxDzf1aFKhN027X5tvBbdVO2yKdv4faNW3eo7d?=
 =?us-ascii?Q?2BwTv2MDaqN+lkRus0mNQB4p3CgRaSPe8pIaJRs2q3a/92O1L/SC4vO2wsuh?=
 =?us-ascii?Q?AkchdVp6Nu6+Fpd1PhrJK8NXstf7l2B/5a37bg1NQl9nunNpfqEGXk5MG7EX?=
 =?us-ascii?Q?soGKwpk616U9k4wVi5ESKS0Q3mPfm7cftamEApG/Sfg9HC0zBChSH3IbDPrp?=
 =?us-ascii?Q?3hl7lOnsTnyTeVKTRkwZOhgLVjfDvCgj0xEC0lH4ZvZRQOAhh6B0QBoOGleh?=
 =?us-ascii?Q?o/jVRHK/+artO8jDusfjUitIx+h4dcpSotDvUfuPsVyl7/MSYFjVwl9kNL0Z?=
 =?us-ascii?Q?MGQUBczm7Ucx5jiYKJi9sF4xegHwUhz6k89koxjcJ40rvBy2jOVhTaUEeREv?=
 =?us-ascii?Q?vNHkMJnjN1SKXXlszx//Pn06l+Kzbcr2bCowJ6+cjiBJFdCXqsC7WeJZSULH?=
 =?us-ascii?Q?7LRvHEe4UxwnWuE32WThKvyhlaxQCVlx3gMhdludFVm9uUf71v0w3PDC2X5m?=
 =?us-ascii?Q?2L/4+DxOWy6H1ZdL4mLYAcO6FT2Qe2ANF711pVxTl1G0J70bv2CuUmruW01d?=
 =?us-ascii?Q?RELCSIgG1XjnJaMFgV/EQMH7xMe2Qa6Z8FHsVKM4ElFvi7rwPMFzkPSwBOIF?=
 =?us-ascii?Q?7P+aMf8O8Jliu38CdvNLvFNDe1e2O6bHVyONHKvCmR5gQdHoO6G1xoxYv3M5?=
 =?us-ascii?Q?/8eAF80jXnM9/NTkmtsAsFBsysjkPULoC6zQukx7dpekNHiiK9YoekZedbKA?=
 =?us-ascii?Q?4Klw6YQQ+sF46+e8n6wY5gf133yJ/jtgL6NbEisURv8jNLYxg9baUZgHVEqM?=
 =?us-ascii?Q?Mk2jay+wCeylZkkFQhEkA7JTcxowHzXgax4uMxKtp8ecgbD57hRZXVwrMgJI?=
 =?us-ascii?Q?jJ8os9CQv/uM7JwqDjBbAgV3Qjgn31rDbTqRhlGam6ldRfyZBYEBY2mYuOAY?=
 =?us-ascii?Q?BGrhF6ORL+utr26d0TDf4hDjxckRQ76hSpG13BPJQ6X5HaSUrBbC1pyhF7wA?=
 =?us-ascii?Q?B19XuR+m8NMVBqH/5BjV+Cd+E0m7v6IUZjX4OPNNt52DCmENeRDbDXCs38VJ?=
 =?us-ascii?Q?9x/WmxFu5X0TAzg+GS6Qc8PHYkk1S6QDwUJTSt4uFS4ntZINE6fsXmbBLOGW?=
 =?us-ascii?Q?aMEURiv2fTHgx7am9d2TjWdlXIYhP9skIGLGYAOcYxqHj0ayHZDYa93NS3D+?=
 =?us-ascii?Q?gwqAk42KLr1ldNKlDNaPGS/ddpM2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 14:31:58.1767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea68817-924e-474d-45cb-08dc63a221c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

From: Tim Huang <Tim.Huang@amd.com>

Clear warning that uses uninitialized value fw_size.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d95555dc5485..fb5de23fa8d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1205,7 +1205,8 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 		fw_size = le32_to_cpu(cp_hdr_v2_0->data_size_bytes);
 		break;
 	default:
-		break;
+		dev_err(adev->dev, "Invalid ucode id %u\n", ucode_id);
+		return;
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-- 
2.39.2

