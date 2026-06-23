Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91FFCD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5D410EB61;
	Tue, 23 Jun 2026 14:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efusNzcs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF88410EB61
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qz8Ejy/uwgMjCHAuPnbGvmKb6qZOVI0+TQRISwyhzAiqWnT4/5Yh9c3zmW2AWeBW87NIKTvemQGMxZvanT5c8YE8qK/tqZIoDs2zv6CghUXYs3zk0qbpULuaKPKuaG47ie1UygC6eBM/IWBdsLBVvcSZLImEwXU+d6p5dEIRd5afs+PEHgB399acjAU/3gfd5ULFESTMroleiC7kHzMwc/M9Tv+W4kq8MSkYa8+I5Bkw7j/PINRJC7t2LgNhAysG8n8fEhwnKRV8FVSnOGcgqIHYqgthQoaypnfMe0FJDOWhLgYK3sSy7mlCz+bUCsUQ5ODKIFHJMydc8KNcmmcCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROI0coL+EpDbgcY5vTLR3fIEdGt0D2swZuyFPf+CQwc=;
 b=cS+EsaT/vIHWZ5Uhmmpjiwa2DitgK2BTqT5L+SZIpgaE6oeolofBnyGcPY59iaSjx8M1nDoLr+24y7yOPGrP8BYNjlvWJyQSZL9Hsrx8sf5wbsnBAeNM2ZyRZPonQUwHhHYrdHLpoxdIufPYb2n9ubrNw3Iel1emX+ON5QifHxylph5fGoUnH/FoAq5AheIdh9/qoOGBkaivE8CPp2GpQe7dK4SkGYkN3JeM6oBvuRQ/NYF4qUm6QZcoMyaQLiNzN4UXh0mk2Sh6ojGnyYOBOYDDmU7DoXQmaCn147zzhtUnWLbCpokXhRlwuh7HZo64A84KnHgozFVwOIz85n4Gyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROI0coL+EpDbgcY5vTLR3fIEdGt0D2swZuyFPf+CQwc=;
 b=efusNzcs7ctGOehTiMVh/3VvU8C4IzDIWD5+ApuZyhEzKKN1lUBBXzrlq/zcM08h6bmodGA5hqkFpvkPoVG8RhftFIhQV8cicvzRx7tmBHrgbI/lbpbnFe/5LPJGR7uilrtVkfGvyYOCZ9lZnpNiFc8b1el4OczNm5U65YN5XjY=
Received: from BL1PR13CA0251.namprd13.prod.outlook.com (2603:10b6:208:2ba::16)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 14:08:44 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::95) by BL1PR13CA0251.outlook.office365.com
 (2603:10b6:208:2ba::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 14:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 14:08:43 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:08:43 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>,
 <Jesse.Zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH] drm/amdkfd: Add gfx12.0 queue reset support to topology
Date: Tue, 23 Jun 2026 10:08:24 -0400
Message-ID: <20260623140825.71342-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1670c321-9634-4920-1a29-08ded130ef53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: NqXAJD8aXU2qVLXWbrH5LoqzhO/vqFL8pNvo7HqNasUd2gdX1othUf8klJfPDe9BI77XIcp+OmCFjpMzmVUcYs0O4SZ4bRh7ymzQoER7gDD3zMggjqboeggwcbpJAyIZB8g5s//g/CG1t6ZyiARYbDbz3Y8LkOivkRRXlLoS/h5CjGPhuUYBON0sgD19m7h1pv2RftE0f8ae5+RoDj+iHQtgsJeZCBzyQoA5DtcqUuUtiWrD3naNoDim2bcxB/eKz7IfKhEAnpUPyXUPfXguunRv2JJNSi/MeTDSLBwLV3DUUI8gC6xhddlZ9T+lW/p6PY74QY4QZeg+DwSm6CApvM85Tb3WmnIEuXLcgptbuiMzmbluVAJfdXjapFV5yL0C4KVYMMK38sJtU852dGHTYKgg3pAR/aMFs2Y/wfTx2aSuYgsZ9YeQ+Yr7StV3G3P4PPUkd29C5YtU0C5WfbboPVx4aAUe9stiG88Gpsk8AZZU+vp2Uofk3NXglw7BEeEje+zlkSIwV3Bi+lfCmfz8qokTd3UlgX96rfpyR020bNGBqaae+s5a2UuNvmgSpCykp5GI661TSyziFGNFBP9/rsSqbe3aNbui6qvLZoll+KLPKTxqr4Dcq5pbqh7tU7lqEWRQ+7K/T+pMU9drayZUX0lyjCqGOUzPF75ntwnImPD2rzTKJBgMrLZL9h/Ac91hv/RF9TUg+KO9EwxC93c1uA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SNgoJyyN9e8HTS+JFjb60F8uV6/sq9ENYNQmKoGprReoqmKM9SWTuKtgrbSTD9wMnmeEKpzqeSHyw29tbHaib2FunGH06K9gWH/NHZ9qqXVy6dBGj7/q3JB5Dxq/ETEzwZU1+kLeMJaR+TDvocg6Jv7Z+WrPDzp2kX9EWXzqDFMek6BRVBuDTFq616qDo/UGGNHLqvlLrNPOrl9vWESr6o60Zse6ej/8y4vDqOUWmJxGudy+dJSoJwHdAjJITsA9HI5f+OF9U2bnZ2r/MYp+e+LYI41DTbJIubAyMwR2YbXVPc4U2hoSY4felqJAPq0q0m8byYxZXkrvGiTCx87FZG3GQ/5fucMr6F4JPfc+qgnPxNcRMFLwYj4g3Bk2HsPm7iW1i7ugtueSfPqRfJKODD6X24MaFU/NUwhdNIGiAEycYYu4SwKWamg97i77lSgO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:08:43.6595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1670c321-9634-4920-1a29-08ded130ef53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

This adds queue reset support in KFD topology for gfx12.0.0 and
gfx12.0.1 on non-sriov mode.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f56b55ef1edd..80f7b14a2e47 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2020,10 +2020,12 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 	} else {
 		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
 					HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
-		/* gfx11 dGPU */
+		/* gfx11 dGPU and gfx12.0 */
 		if ((KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 0) ||
 		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 2) ||
-		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3)) &&
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(11, 0, 3) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 0, 0) ||
+		     KFD_GC_VERSION(dev->gpu) == IP_VERSION(12, 0, 1)) &&
 		     !amdgpu_sriov_vf(dev->gpu->adev))
 			dev->node_props.capability |= HSA_CAP_PER_QUEUE_RESET_SUPPORTED;
 
-- 
2.43.0

