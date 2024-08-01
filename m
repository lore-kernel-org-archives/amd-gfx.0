Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA45C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D4FD10E8A4;
	Thu,  1 Aug 2024 07:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5UQW+yZC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7455810E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KScHCDmRTiflLXmATHhbjfNyBDVrHQ77Pfap117SvIursG37/dc9WZQzG/G3JlXJ9Olxjuc/egcJSJHPC268jpuLzJ6GqMhZSiWYMCc2v2rNy3b+5krpyM6hqoQ/fEHqObhvNS/3tWF8r8L+K29u2lpbqe6OQ6jmLJysFHdPKlIonQfeWl/63p8jnZUrJFSjSLW5f20M12zKR7hdRrk8IwVt9ZMgZyL3B0VIVWH12tn/0bNe2fGgOyFc58dFqMgLQl9qyfsr74Dtqie5QsoovDjmes8jpqb0jAQnC+nZNXFytMarF/gn5ovugfHJvVaFkPl8tOWaWuKIFQCMRKnxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSwUvV6Il0SD6iEyr98eDF1uUSwnffgTyraBZM+wCCA=;
 b=nggpJq6xdyWRoqdkuXzk41E5YKVI5islqVFZEoFWoYdDxrIX6tlgKvCsJUjcrXhOAiY+kv6qLPm25muAzIbTKPJ6Y9WT6JHfbPdtzYwihKOPRi1yK9FjPR/nkdKUiIIidKZc34SorxthyU5FsuKhE9afKmYb68tCYHCcEanRP+CEWVifJDyN2e9T9YMyQ22XQWdHNPgDbijtpiuTNT+kPonODSCMpwZqbb+YUH1XV1op0TupRL+UouXDphImxZllA6irRbUihTWH5sFSNiUk4XmkqSjnbmIqk3uxSXPzPzD2QEEcQo221fKfVPblnaG+ZI+TrROBXKBmuAYLERCkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSwUvV6Il0SD6iEyr98eDF1uUSwnffgTyraBZM+wCCA=;
 b=5UQW+yZCMa7XyxBh4TxsVic0S6YbRUJ2zv/y38jVGF/KeoXXp1744qqNsXC9+TqqSfoKUOenFvj3rLU4YmPISX85HUxUmRoBWi27iwCxlLf509Z8bxdnNPY7zwB02aDaEVtw1PNH+PAJjBlzdGVCJbU19LXSZL9p7pgk9pl07iQ=
Received: from PH3PEPF000040AC.namprd05.prod.outlook.com (2603:10b6:518:1::5b)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.29; Thu, 1 Aug
 2024 07:27:50 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::) by PH3PEPF000040AC.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12 via Frontend
 Transport; Thu, 1 Aug 2024 07:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:27:49 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 02:27:48 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Trigger Huang <Trigger.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: save the funcs of gfx software rings
Date: Thu, 1 Aug 2024 15:27:23 +0800
Message-ID: <20240801072723.1193504-1-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dcb525-fb06-445e-a703-08dcb1fb72ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g/pq/YTDwJIaDJuu0khd4K3U4AC8O8nYIbuTGziwrTRo6UYeCwPmrFvXLwaJ?=
 =?us-ascii?Q?7bm9ivIEF8X4vtE6w4nc59SRwN+7V58NOqKOlAWgpBTvcocdvne83zbVj3xl?=
 =?us-ascii?Q?VLELvZoPAJK7p6CDb9ibtkkvyP8OicBplc0yvs+3LeHAb3ypsbriPf+VSxoy?=
 =?us-ascii?Q?Wi45fHUwf/+SWNsTlqstoAP7cCI6r4GSnkZYJhzZ2ywnQLEqC1VABg+KWR/0?=
 =?us-ascii?Q?I32ftqw/ANQL11KOJxe+3on5BByybSjHc+XeI64oduAQZ8n+wMNOpiKENRJR?=
 =?us-ascii?Q?0Z7f8a0CcfvN2GMe1FfSVAmlEB2w6hzkjkJr37KKUcx+uS29hrxmeoAmh4/4?=
 =?us-ascii?Q?oDa/bvDErnMMYF+5Kqze29QUHs2iVxmzFm+PqCim+KkAGKrBZNOzSy2uqsLP?=
 =?us-ascii?Q?5e+IpdRHOMFXJwjTQiPZJ+zo00/TgR1J03U7Yr+cl/n8u+KB2hy15MoXM9Jp?=
 =?us-ascii?Q?4UcRvQ9Fq93Wkm+gdaUHFErbDnWkx7v3GMUi3TyvCgVkLCRV/N6gYDwLE6mo?=
 =?us-ascii?Q?5CLJJNczSYRwsIOnDE6dgRlJXMnyAFyRcz/5WsyiCD3XGxYCs0kQNFyrkGoj?=
 =?us-ascii?Q?RCI/2EDzrm8ERPZdKqGBsacRwZbM9YR7JLeCflEfXXfrsmiXpeUc3lG+ei17?=
 =?us-ascii?Q?7t2+hhgvTDV8TpXOKmuNEbwCTU5j+Q6OEdUgHwNLeVf332WeVZRTfw1moh6h?=
 =?us-ascii?Q?Z1N+Gblu/7OsnX91pT217nMw3aCIuUp++vUxyjSwfXwLUFkp/1/a7/vUaAJV?=
 =?us-ascii?Q?VjRnUAGmmICjQxinV2QbP6+XWbzjUg0/iqjJcDnGeTFyaxTHNISRglvyab1D?=
 =?us-ascii?Q?O1Gpmpkx+XCOF3/KLLBDk2PaAmoZAXoiZL+p6kkb68NhUo8lOnk5/c5MEPdj?=
 =?us-ascii?Q?8QxMGYgSf9zAScU+zI5+jOJ24oH0kMy7URTumMObPEyywiwLLQtBd59C63ma?=
 =?us-ascii?Q?Q73d7ZO8pAurYE4BurRHTG93AOTwqrBXuFjDDqHSasrKJmmQlY0dzvNBFZau?=
 =?us-ascii?Q?SKIF0JEa+6+yl/UxD4ljISmCU0RKm326QsDGgYU1n85SZg3bDqIPDQ915ilh?=
 =?us-ascii?Q?ALSgWm57BDWPzn/Y6Mlwk1EVjG63psD3OrgKpo/maBemMWOSJab0Qb174PKW?=
 =?us-ascii?Q?tFIY1sDtAZBt4I50yQM5jLdQOUlU4N/kGJQcy8fcL4koY6l50ORuSBq5htm6?=
 =?us-ascii?Q?aplfQQ2PUN9S+nF0qoLQsRpyw4ij6iU+FY/HjndQxn6DH9yt2b+yitUk5CpM?=
 =?us-ascii?Q?0Cc7uTfKCJSgwrKIKSW1T7wcZftjHawkHvEAJ0YcgKfyj2O2gbyGV8QlD4IM?=
 =?us-ascii?Q?7qRd0+BSYQnJFRvqDEGDHOvcuyf8ujyjg1vnfQl28nBf4WZUzRe3eJnPF1X4?=
 =?us-ascii?Q?mvWAlL6Fq0JkPh0Pds6hQIWPrWlJglwLMw4u4/61kufxq1brIdJie5fPdmkt?=
 =?us-ascii?Q?pCuWeBYsj9W5f6fL77l+QyLu+VrcWis1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:27:49.8527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dcb525-fb06-445e-a703-08dcb1fb72ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

From: Trigger Huang <Trigger.Huang@amd.com>

Currently the funcs variable of a gfx software ring is not set. So
if it is visited somewhere, it will lead to error logic being
executed. For example, if we want to call some callbacks in funcs of
a gfx software ring, like per ring reset, it will be failed due to
funcs is NULL.

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index d234b7ccfaaf..4dad03a07492 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -202,6 +202,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 
 	e = &mux->ring_entry[mux->num_ring_entries];
 	ring->entry_index = mux->num_ring_entries;
+	ring->funcs = mux->real_ring->funcs;
 	e->ring = ring;
 
 	INIT_LIST_HEAD(&e->list);
-- 
2.34.1

