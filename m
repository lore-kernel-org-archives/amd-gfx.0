Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD6BCFC50A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 09:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54A110E256;
	Mon, 14 Oct 2024 09:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7gr0cVj";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F86910E256
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 09:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohCzd2H4zmldmxeZtuymJKNYSUJpIc2SUb9U8FIjtIWA4ZLqWIbRKQ/nCYO2/3tr/Afi13O29k57VvUACHmW9EKKbaoN0iLpJ++7oQflqBAwb3c+Fr3GhkL9xJ5CAFjpXnRz2y00avq2LmRcuRUNOttHDFT0A/qtbZSYfKT8z5kfLXrdmW4dA3ENCag4qpocyuoa/JXHnWzgBiNaqFebUoDKQ21HrW4HwoyiMldFVlVddlTnSqIGgzGQo/Y1bVegDiS3HSaLlXPkpKqCyKBACc/ZDoqvzGfdTYsuVE6lY2V/ChNUiAY+A/yz/Ozh5c9t1gpvfzN2CsfOVQJgTwFrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMpzMh8tELi3OqaQf7pV8NIRA8ob0zlZ0+C+42sFTNw=;
 b=tEktFXXDZL2ejmlegVPwWVXBiuy792mDVqv9fQCiV+H/6Qrd021SJD1RSk/bHH0WvWInPnYTFoXUh+p58CgILjdteU5+LkUAbE5qq12EsfftYQrezJuaHTrZMJrEtFemqkXtpeZy6Lj5uVmhvj1r+O1GPsM/nIP3dN7YYje7LCtgeX6tQhaRaEwhMou/AaMbAjV919o0LL3l6s+9Qs+o51ms0TXYrd13xDDvIovrhEYx+/kCrBfnWiJKemGJT0W0o28BLAnNOLPLarPVXx+GEhlVpKaBCeGlZooly6cgG7EnNziaUYiNgJ+aZ/x1hpnetHW9FnJpX/UbRWpPbw/9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMpzMh8tELi3OqaQf7pV8NIRA8ob0zlZ0+C+42sFTNw=;
 b=b7gr0cVjOndkbxMMzLxQtYeDYgQfbjn+gCgIuJ31jl3valGOA5f2j4CZbGKeP0ZEKzSrmewrrEd4HhRdBDrb+fCDj1LV2k1YAGLk/8LZcQNH01c5uolgE9z9ESw5qCShQSI9WdvGQJBjj9sxpXMwQaAHf3VmDUC3Pk1lnyeA+9Q=
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:19:29 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::9b) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 09:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 09:19:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:19:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Asad.Kamal@amd.com>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Hao Zhou
 <hao.zhou@amd.com>
Subject: [PATCH] drm/amdgpu: Use SPX as default in partition config
Date: Mon, 14 Oct 2024 14:49:11 +0530
Message-ID: <20241014091911.3036389-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: fa01f1cc-6c03-4843-98f5-08dcec314e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wACBww+QeYy3T8WRylWrYiuzfSA86C9l/lYN/UQWNy7x/Ka03RFkH+ysS+AA?=
 =?us-ascii?Q?j0h0rscfKCHipvrnJ/2opyUWFkA5UC05T3AGsSNtTLomUFbyCGUm7ugoB7tm?=
 =?us-ascii?Q?Oyhwglpu3YaNdd0fG0/nuUw9F0qSK6NYj51c8ATM21qc4pVYJLhtfFmbQtD9?=
 =?us-ascii?Q?DlHV3BPIsM9v9Cwrz2rViEmTEFkbEMU0U/9/NbrzccPrx6XLyi0lxBWCuVmM?=
 =?us-ascii?Q?U0CZTbiKTVeASNgOgC2VG8MscAz7yd0xEAjEHCBYxUGea1IeZg9Z8P1b//NO?=
 =?us-ascii?Q?WLgdFQqgYZDEktytHyjo8eQCepQd9HuT0Ha0lguWJn8DGzKQU/Fr+28AU93l?=
 =?us-ascii?Q?gmtlSVc8mz/AUrR1csUYzgNCfpD9TH/7h69c94hAYtv0OfDhsrH6IB4O2Agi?=
 =?us-ascii?Q?x2+xneY8ggZ43oL+J8ri+Uq2zrURYRMntGVmYUSeBs/gRKm1WHR51iDqwxOj?=
 =?us-ascii?Q?ZjBz36sw+dUI+xBtLPVyypAwGoLMQarAkQiNzSiU9sKbpkd5jcy2Or76cLKX?=
 =?us-ascii?Q?/FfTF10KMR9Z9WyzCsesvsGb7DoJGtDDRyhBDNyAGVUVTgFd5iDPRhwiwjr6?=
 =?us-ascii?Q?nyxMGITts8Cu2x+b38iSeRYpykwJR8rxmx3Kuwqs/CdI9jss55dLS0TMTxqd?=
 =?us-ascii?Q?/L54PtzUE6LwUoOPgJj36nSZPFxisgpKxIJGuzGjOm8RmAiTwqg+XaHkfDVb?=
 =?us-ascii?Q?n12NWdgxCdqx6oqIC85YNjmV5p5rwS0EDf7sI3SPwHLuMy3d7V4Q14fs/Z7E?=
 =?us-ascii?Q?RULwQqk8wHYPwWWCGorliTXB4PWayXqTwDc3MSsD3OoCAZXPiVlP5gmx6LEn?=
 =?us-ascii?Q?AyFXB2ynwecQ+G/Pn2fi+NA2UUm7kLt7NNERUvru7v/YIg4t+eJsFFkRJfsk?=
 =?us-ascii?Q?IQx2Ticm/bz09Yi1rgJKOcAnD+z7D+arEudOX7+IJpMtqpQeTGJNjMJP3usC?=
 =?us-ascii?Q?7F2yvwyhHwBbfRPPXu/ETtiRCCb82nvc0TX8jVKUB+pii+xNtutVWmqG9LCD?=
 =?us-ascii?Q?fI5gT6ab27xNg1GYKMhyIUlc3By2unuy6o7zaekq6wh/RtqCH+YHL8sTrwlr?=
 =?us-ascii?Q?fWzR5iNaMHFts12A0QHB30JsXBZBPXg2epOrWgOcWEHC8BUMAQBMgy+6V9nR?=
 =?us-ascii?Q?Kp2WHSbueBmvbfK4XsMAgIwbhow/QnPIfGxX8p3MkGv9a4KDFDWrnu5dgrOp?=
 =?us-ascii?Q?7Q7fCYhE6AECWyyEHTlfw4iL2xzdCAsu9JWXyXjMwZCxxAX1M0HdejdGy5Gs?=
 =?us-ascii?Q?9mRxRXGpDr6OFcJdQ03iMc3R01ou5lSD+5vcxqPDWtkoFGKulEFgYM+D8YiW?=
 =?us-ascii?Q?7ehYBwzeARfjNSC7qz7Iap1bkcvx+ArI+yEjQZ3N+0cITEz/sBB0MqWADXcB?=
 =?us-ascii?Q?wrRSAmZI3Fdjf1DtebCPSA8nucxn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:19:29.3655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa01f1cc-6c03-4843-98f5-08dcec314e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
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

In certain cases - ex: when a reset is required on initialization - XCP
manager won't have a valid partition mode. In such cases, use SPX as the
default selected mode for which partition configuration details are
populated.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Hao Zhou <hao.zhou@amd.com>

Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 111bf897e72e..83a16918ea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_res_details *xcp_res;
 	struct amdgpu_xcp_cfg *xcp_cfg;
-	int i, r, j, rid;
+	int i, r, j, rid, mode;
 
 	if (!adev->xcp_mgr)
 		return;
@@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_device *adev)
 	if (r)
 		goto err1;
 
-	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, xcp_cfg->xcp_mgr->mode, xcp_cfg);
+	mode = (xcp_cfg->xcp_mgr->mode ==
+		AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
+		       AMDGPU_SPX_PARTITION_MODE :
+		       xcp_cfg->xcp_mgr->mode;
+	r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
 	if (r)
 		goto err1;
 
-	xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
+	xcp_cfg->mode = mode;
 	for (i = 0; i < xcp_cfg->num_res; i++) {
 		xcp_res = &xcp_cfg->xcp_res[i];
 		rid = xcp_res->id;
-- 
2.25.1

