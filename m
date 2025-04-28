Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3BDC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E701A10E53A;
	Mon, 28 Apr 2025 13:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yovFszcJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A8510E53A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnueYpnmyIxBL5XUoVLC/2av+jyGnv0mMXjEtIHbRufx1Mr+/0IhM5BUO1mBGw5Km69ym7I78hZr3ZCZjkSY4AlkkkUmCdGu3SbfY//wM+K3nzj/J2JyZPmcNd+M1H5U3dXFVRo/jtlR6UgHnLruzNK14DDnTJ519OOm+rXjmWZXwQ87i8ThU87pWnPmvyxX2z/92M0crKdsXokHIItm5m82kDg54SPdgA8nRGrg7Z6mMO9W4kp2pg2OijIbCesXBq+lP+5++ye6mlcd66n5anFgJ2UfPrJVFHKhCezhgMTMsdwG/RfBylBHxwbZWHAXn32eax7jPJhrGV8MNDuqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1tj/0QdP8Fol89ZUOiko3MmTmjT5a4Fhc0ZyYJGFuI=;
 b=WUXhaeqzL9DKw3e8bvYnB22Y1CSO36zEZSJIt83H2HLk/6Qv/5jp6/nJwssiDKuZjt4CbpjPbbZCmOtX/I7k036J5p1/RNBY9GI6nKTk91rs7pm5U7TTKCbdNLmlM6vK0hnpFMdVDkt1he6X6w1qnKeDwgYEwuXrM2Ql6xod9+5HAEomoQScZMYQS89r3qG5jbcXKYav68Aae6k5WCZJGZSCZW3D/cFjOybgnWDC964leOzpTlqi2XlNnQ/PD4RDPRJiwLvOOtPI90CKbXHa/x7T7Q2708DWbLQ3sArLB4NqjzOoAmbvTxiBdQlqflo9Fvk5YcxPILa6EvnF/ZOUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1tj/0QdP8Fol89ZUOiko3MmTmjT5a4Fhc0ZyYJGFuI=;
 b=yovFszcJUzmhuNgjPT2Yd9m2UeSM1a22UAElqgAHQv+nEmJ/Oz887aaA/wuC2PQeritxfliAB2/Dh68INgDoeEFU+lUsNtehxaE3gl9OpQ/OKDZ9XC72I6t+vm58knNBLQ9pCMw4oGituAZiB3TdaVUMfudDqtsEKa6HGdbaBM4=
Received: from CH2PR05CA0053.namprd05.prod.outlook.com (2603:10b6:610:38::30)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:56:05 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::75) by CH2PR05CA0053.outlook.office365.com
 (2603:10b6:610:38::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Mon,
 28 Apr 2025 13:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:04 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:02 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Remove redundant null check
Date: Mon, 28 Apr 2025 21:50:35 +0800
Message-ID: <20250428135514.20775-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 297b5c77-f649-4172-b9d9-08dd865c6b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XIaX2z0CDmoIPEVHL0512qte86O9xojd7Ki5LzxfOwFIGwh4xMhcGA8YMPHa?=
 =?us-ascii?Q?c3Y+i/Il71rCm7PD7GKhzQactVjXck2WmjxCkipCyysRsQgnzfzERcizs/sj?=
 =?us-ascii?Q?8njfSDib0hVEQaWLkDKWRd96UFjW8Cn9JzHVnqohH+Nt5EfP6SI222etPOvX?=
 =?us-ascii?Q?0VistBo7dd1YiTyyW2fLFUkv2r4yNBX8DGZ5T/nkSzBbw0nqO9QMP4GNJtlT?=
 =?us-ascii?Q?T+CQF9GYi+zL5abmcnhRA5E2ZO7ynkYrL44CRdM+KM/eLzpOfqFsMVHJJxJb?=
 =?us-ascii?Q?GTPIDXhclpDwSY+yYdVN2QRD0QP+PzA0HFTJWOw13B3VU7tra8vkCWli0Q3N?=
 =?us-ascii?Q?wfkkSnyTCwPUEyyyhPa6Z/YMJX1vRHTMmbdjI7lgRB2diNW7P1hf83A4IAuM?=
 =?us-ascii?Q?lBTT9I0jXEAxJmaWtMhondpgX0/Y/3HhT4CWfz8CWsms96KiTsLu6mBmJ7Sq?=
 =?us-ascii?Q?T8vGXMEbNZhy++TKxpaj50aq7Id3RSqrhnb0B0EoBRHxaSEhqFGWRecI8CXF?=
 =?us-ascii?Q?FTQ+A3n7e+oX+DZnaohHsdoSTKEOWY/ei+1CxmKH3RW9DH5AAnSnE4mM5Ee5?=
 =?us-ascii?Q?OVluZC0w59bO6aymwrq3Sf5lOCg1v6+b+y23FIGSOdHu5D6N/JlpMdi9oeUS?=
 =?us-ascii?Q?3woDNoACt4WaY9ryPndHVxQBOI6jDWgxEmJmMYODCFR+V8yRoWytkzYgIkmG?=
 =?us-ascii?Q?e41ydy61jZzqGQJS1/BozgW39I1OJjSNm7vWwr9tfZePoLuWYtPTv5YVK+68?=
 =?us-ascii?Q?Ps5c4HrkfyTxWQbg3329Ext9rBBMe9CuoGGTH1lN6e/NdcRuT6CVdja7y1AR?=
 =?us-ascii?Q?sf/HrTAdL6uf7hmbLIqijcZgwmzi4kaoZ2duFwuSN6TxcrjI1c/kJnovOkr1?=
 =?us-ascii?Q?ebdHV8fztVHYujdI9bU/2AQRop4Mnx5TOmXJWxAvB065qUFjcDCaQuB4/gsg?=
 =?us-ascii?Q?8L2zvpwzvuX6pC9bE5C+3rtsgqwHOyC51HQvMnl14OQKpfbqxrexi5DJVhHs?=
 =?us-ascii?Q?0TwSa2utVV0cpoAsHBI64f8h96IhZs8yq+nnG8HhC6HgcdGngMk30uP4Rdd7?=
 =?us-ascii?Q?MlyMUi5PCgIvjwNVdsKCS7ajUceWZbgxBO5zuGkjASy3lBmA5ntygp1txWZG?=
 =?us-ascii?Q?dV/XEGHld61o9ccB1G9VlHhjOMDJT3cxHOqc4Cv2Js+40LojjIMeZLcaaxTS?=
 =?us-ascii?Q?Xl3O7GgNpfUfBwy7E7u0Q+EFW0unoMb3ESgwVdFO+i7kenNVz8rC9cZ0Jclw?=
 =?us-ascii?Q?141O4B3SR0hKFXvBBi/CLW+N70mnX3XC7NXjTwxs5FZFm7OXVRzLKkCkIvoe?=
 =?us-ascii?Q?2uIIQ0L/mH/IzO31ibtIRbuvs68inHoUbvm3qGzKdqk/llgd0fqUNKSY7q6s?=
 =?us-ascii?Q?jnvcDTt80I/qvaORGd/OS1b3TKenQq79l50f6nEOg221/Q9lIFTUyySrctI6?=
 =?us-ascii?Q?cLmgJQqKsjxgHoOq1W8l9oPqPifaYuUXuIM4aJbg35c/UFKnBc2/nGCTqZ9A?=
 =?us-ascii?Q?oGRx9E/eyaERBQK6u/GCz+Argf8hmyUk245N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:05.3962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297b5c77-f649-4172-b9d9-08dd865c6b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
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

From: Alex Hung <alex.hung@amd.com>

[WHY & HOW]
The null check for connector was dereferenced previously in the same
function and the caller.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 89a43f33e8a1..6cf02d2f536f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6989,11 +6989,6 @@ create_stream_for_sink(struct drm_connector *connector,
 	drm_mode_init(&mode, drm_mode);
 	memset(&saved_mode, 0, sizeof(saved_mode));
 
-	if (connector == NULL) {
-		drm_err(dev, "connector is NULL!\n");
-		return stream;
-	}
-
 	if (connector->connector_type != DRM_MODE_CONNECTOR_WRITEBACK) {
 		aconnector = NULL;
 		aconnector = to_amdgpu_dm_connector(connector);
-- 
2.43.0

