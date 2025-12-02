Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564EDD1266A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 20:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5AF10E0C2;
	Tue,  2 Dec 2025 20:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVpQLBzJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010010.outbound.protection.outlook.com
 [52.101.193.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2412910E0C2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 20:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bwz83Qcc1UPgW2/rNIj6lWLTG0Ty3DVdToU4UQ53/UJqlaNmCWfZJhYYQNp0sOp9OgMLReQ/7D1ln29Y3wZwWZ2OOkrZWp+NpDaCSLlxZj6ACxid9kU51m2kbiXZEZFrl8xBE/t6E9DJp2M481outYFLZpitK8cfGNoP6DnazUH0BLxS3/ZwzStz1iMy88cB0lxK9m42ZGvQR2whpyTb8g/rGRKdv/Dc2UaNYiFhyDWDc8ojOgPt7W6hKvD45nL631q7Uw50iwJPDSbONDK+8785d5A0DoQ2//uOwoWyJUC84PG7Rfauo4L7L4YzBW+5D3licdbVRkdV2yd6S7ghHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOES0PGpQmOzKpXiefY6mYyb5TTrZLQdnaaDJwB+EDI=;
 b=plWbxaYX/YEZgGEHr9jo1gvaPSckcsseRgQ+To8+aL3nc57X2TKyLyROOeCfOonWxNGj1PduyGsKofL0ytHMA9daRZjriU/0IURSsDxDKYUoYFxlbEq+rEm4AHmHa/Q72wXnGRfYmJ8Y2AnNTFmfTdBZZibzmWUvgQXqwdEwpsIKghco+xXpspuMoRPjSv/ycUYVe3jsoboIuxtK79ZRsuRT4LFjfmsyrYeXYpHwLAKbaz/+iZJoBehTeb/YtZBfeKyXmW6Yc6IoQqQ90TlRJOnxp+wmIgPxSJ8LkSDRuFFGixWRSOFiZP+VAdPvo0OLzc0sf0ys+1zE/3C5WQ8SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOES0PGpQmOzKpXiefY6mYyb5TTrZLQdnaaDJwB+EDI=;
 b=dVpQLBzJ57zTeDhFOdVQ6qZljda51fZKZ4F4h9ACoBXaVQBrtGaQMVC7fZVgNOcV/Xx2yLimkbCHifLltXAuOImyNYov0FEmHV9KhQJ/GJjxznFYbfJwDvHnr2aR9KQAap4OgFr/mAX2g+WfsYvQcD7I57ylA7Dc9aS2Qpz8uOQ=
Received: from PH1PEPF00013309.namprd07.prod.outlook.com (2603:10b6:518:1::18)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 20:15:18 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH1PEPF00013309.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 20:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 20:15:15 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 14:15:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()
Date: Tue, 2 Dec 2025 15:15:02 -0500
Message-ID: <20251202201502.2038707-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ffb420-ab6a-4df0-e400-08de31df81d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?atabEjzbNbV2b5PTzaVW/Z7hVxJWVp0c4KaKFzuixzWjtQgBEvcq5s/jKJ+6?=
 =?us-ascii?Q?fRF9b2CuKESswH7Ho0OldbcJrshQ4aT4QYk8iRRhXTrTXbkMtKc/VueR3Smx?=
 =?us-ascii?Q?t0+BxCcS744ziXvEdKmtlxjIGHXq/wpjQV0RXzZkE8pZph70k8k3I9fkQrYd?=
 =?us-ascii?Q?F3c6vh/eDRN0frkPGhJioAw+ffOCMilLRm0uTKDfEJiFaF6VUuINs87WioaL?=
 =?us-ascii?Q?UveWComSAJ8Y9ipvIWyVSQpgsTW/e/z9Wul156gog4yDjp8JPHCVuulCb6Iw?=
 =?us-ascii?Q?PBK3akAVvsR7dg3Mp6dEOEEcD2LWyQDuDmyZHqODsl06CwAdgWGF/lKTzBr/?=
 =?us-ascii?Q?Hl+42gDL4Ji0NKP8n8TqSnvwk5U1FaAA6sfljtRz4+aMzOMYf9kXO+CAPYu2?=
 =?us-ascii?Q?dV0h342U3ifuiESA8uHLN3wGCL9+gtXPEA18/a6WaYhnu2mO4Q+bXqWZX5eU?=
 =?us-ascii?Q?d83BUNzD+lBupDtPZE1sIDmIOYgzMZ0qV6Dgz/O4HvlWGgQwejZ0gamVGSdr?=
 =?us-ascii?Q?3ynbUi75dl0piJiS/G99oEcGS6WB+Se0ZINPd5yVVjM3M+2EGikHGdwuvIjs?=
 =?us-ascii?Q?CEKmD3Qu9x8D8ifllw27lxW9LE30oQXBulLUFJ2lGFaVVxt7MopVfMuxYwd2?=
 =?us-ascii?Q?7fDZBwC5cNNG9JaHecIUDdThw2DBXRY2iYn6KFjkV+nBiUciGyoMRvliIWnw?=
 =?us-ascii?Q?22UaW9CgtDOdfBl2ZiFUD1LXiRTY0WzpigqEdSiBlFv4sMo2+qSdm3w18tDt?=
 =?us-ascii?Q?tfnc0FM8yiRZXszq0toyQ+xc7X8ZBXakZrHhwHDTxrxjTEW5NXNekBZ4ra2t?=
 =?us-ascii?Q?iwkDfQLkMYVEjzkFYqKhNYXduEeTbCj9frWvbg1fsVWqMto9vLWF5aXFg9DC?=
 =?us-ascii?Q?ipwJtBBlx6GyjyAV6QpD5Ba40p+pF6pbpwM6p0dNXz4ijzDayBW2lDpCGcc7?=
 =?us-ascii?Q?lJAhHoNmbKNt2pS7l81HeM4ZsxToQ220Ju2wrL8in1uRQwXOIFGqIgpB94oh?=
 =?us-ascii?Q?JzABF9vsblW7N+bx9di1ZIJo2d+m2kvcRpXE6UDPlcvLTR04KShxVoF5lQ9k?=
 =?us-ascii?Q?S3vNqZ7XsyK6FgL0OntCtM0RwRTnUhgQuW46IdNbH+x2ThdYvTic3OyEUp8L?=
 =?us-ascii?Q?6yEsyBxbcB5BGGOgimsmXY/0G/vMuuZOd+aiZ+TCf+kJrelMNkKuAjLPXBAm?=
 =?us-ascii?Q?aWIFIMwdl4f7UlLgpcUILFE7EIfG5CgxdQVstvWeXQj6SwCesyknXYN3B0pw?=
 =?us-ascii?Q?vMBDcppGm8Z6TccY88qr0gVzKKlGp9rZsEUaV7IR5ndApqIycRiJKdwngaFM?=
 =?us-ascii?Q?YFDq9ZgsIync+NUqHEhokGE0Xv/SZ1Z022AJAqiW5Z0VUwS913F6zLgNbdjM?=
 =?us-ascii?Q?zyYIE05v43BNfjkRLLE5jhVGQVL5H//PfI73rIZ3ZpTZYA1FIVohOVa5f7wj?=
 =?us-ascii?Q?0k1N/Ikfs1qImUGgiuxSXph5HkFkvAnr0MtwfXPPGL1Mh6aaRiCCP9a7hOkO?=
 =?us-ascii?Q?mA7KJOg/0fOuUx2kwoGmuIFXS7bMIaw/L3EP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 20:15:15.8556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ffb420-ab6a-4df0-e400-08de31df81d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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

This can get called from an atomic context.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4470
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 922f23557f5d9..0971dfa258454 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -86,7 +86,7 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
 	struct dc_plane_state *plane_state = kvzalloc(sizeof(*plane_state),
-							GFP_KERNEL);
+							GFP_ATOMIC);
 
 	if (NULL == plane_state)
 		return NULL;
-- 
2.51.1

