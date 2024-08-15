Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C07C52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:46:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB80410E550;
	Thu, 15 Aug 2024 22:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UD//lUKE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE4C10E550
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdUgBMlQorOybQGb92UhMXUVcmTSdXCU1mfav0R/BucbZt92pqE64JwhdXlc5Ykwn0ckXT4IKDMY9DjyYeXn9ZvlEVEU96gXxuAYzWfoy6ouptXKvelHgVKPD5fUUrDMxGN68W6KN8HIQcAsjAx2SmlOwZh3SE0Fiq9RQMzd7YxauARTNHjuRS5gk2f9wIrpxzY4zbzMkkxRXuReCIkzJsWDAYx1L8B4TLaa73HsIoo1GfyAur83iUUQUSeI7yxQHnrKRkbTYCgGyRdlDmpMqBXqbj5u9++wj4+M4fOBhhg8sUc3uoGxFCUEBVarvxw43VB6aH24OxaGcy+ZSbiI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFsGJdm0hC8YXW6FXFWYafNPvCAQlt5Utd/iRHeHLnQ=;
 b=yCCPc6k6sNpDo46eZ5oja0RHgyIXtZhjJFBNnUxKEIbPmoPatoiMno68957dY89kYXtnQUZm3bC8fRUBx120HHF8rE+KfJTek0b2MsuwF/H7jztCiXwVl+E4mjAKbpe8b48wSqMCDbS/7bw6/D7MYqnTKxkiO6xClLtve+NaQEWjp9ZuT1T18kdX+z5Mq3RuTYwIs/tWIUVt/q5ZNyPvYcUf6IpZkQYZiNoadx0im/5sOL9ZZoEBjZCBP2n3du8SxAIarX8kWIX//Wf3bxsDU9uQQ+3PhKA/1/rGbQ/46RlfLsj/ryPJ5FUecWUNJHPFKzny1wO4FNeAF7YT8VMK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFsGJdm0hC8YXW6FXFWYafNPvCAQlt5Utd/iRHeHLnQ=;
 b=UD//lUKEiCFS8lU4q3rYwbKb+h6nMmfJpnujnbtyE1Xnw7CTRtCoWHgE8z+xvySWHofAXW3p5CWyaFPkaCLdF2YvTpNwdSe6qBW1jc09oFzskr6PtlJy6CIv6znnzWCZnN5xUlGr0mxyCUu/eo7zRo3+TgdzicsNFcE3bFSoryQ=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 22:46:26 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::7a) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 22:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:46:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:50 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
Date: Thu, 15 Aug 2024 18:45:24 -0400
Message-ID: <20240815224525.3077505-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: c97e98c9-cbaf-4ec8-0c21-08dcbd7c1856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?49MmKS9CI7PWhIA8ypv6i/SDJ5rA0QKp9uV0WvaeOx74PCb8fHjalTud0vYn?=
 =?us-ascii?Q?pdUNiznVgrVK/RBZF080S1kpmeQJkdvYgtWeYQ4Pop6Bpgr3yWoUQ+WMUFnJ?=
 =?us-ascii?Q?E6vXKrmFRvsiSqIMA2yK6J3Yy0c98X9ge09+dqrFgCtIvIZVtfyec9KBIBYS?=
 =?us-ascii?Q?R+lOKd9RaXKO8bMN6uCJRWPfxbqH9POv+KXI18jZEjL+OKMuQpTNWywaIhdo?=
 =?us-ascii?Q?r1qg46Xyx6rJCT1hWr3rd15Vbuc1k2G1C4Pz2fzu5fiQaEfREIWuuEom/ER7?=
 =?us-ascii?Q?O3yamNwn5m36IQIn0c+7LS+A52Lzs6E867ZtnqYMUppfpl3MkZh96NcRYdP3?=
 =?us-ascii?Q?ekg4fFzVk6NwGl/CBEHWURb/Iv0VgJmP3eWgL4+/sRcenfCU6lmAC3RpS8Fn?=
 =?us-ascii?Q?Fjj1aoQCx6UiMxgwNdl3P1uBw6rmypZn2o8+9w3IW24SSGJpp+ZW5LvFzCw0?=
 =?us-ascii?Q?7zlLAPDy8w6KOQeOm0Ai/n3+gBbKbVWUVpm2tZr4k2kQCcYa7ss4d+b5l7k3?=
 =?us-ascii?Q?OXp18M9rPjPXnTWpUUl7EQujpxHNbYAmI3KWAPLgjRgywDMGEOyh3oF1jqPw?=
 =?us-ascii?Q?MQGL6RJChATsiInAFvaGSxn3Q34IpKh8mIJvsQW2+915n85rzX37Pdt2ve3i?=
 =?us-ascii?Q?YZF9KQD5xGY28u9L5x9+YNlLwf8UlzheDtp6/VOc0x5oTICp8vve7nJBq7Sf?=
 =?us-ascii?Q?rPD/WRXN/iprFV8HBIJ/jal0Ayne0pudHN3H4/QE/IIWalcaDdEcJXK808k2?=
 =?us-ascii?Q?5oielqL2AsFcwEvpQ22Zd+e9TcY89Iwh8XJ/QMh8qnk/AeJ6i4L12niqvqAd?=
 =?us-ascii?Q?EjEyQWDMQOazScNUXMtcgrvIN5ukYVP1qJt7qCWqkCob2JHqSOFM3MR2mKTp?=
 =?us-ascii?Q?595McYzBmYNOBPLUxKw/gOarRB50rXSauDghobc6AqC6e2BJu5/pemaw5FGA?=
 =?us-ascii?Q?lvVCagPSxY6oewV1jqe0ug8hwZSZcSwytHqBRmz2z+PghhR4Ncb4cog7dmru?=
 =?us-ascii?Q?IhTubNgCEuPQ7EuEjibYCzEIOg8buZAKtb5PQ0Au96QK3jiF+EGXGEroKMGi?=
 =?us-ascii?Q?dNeuybL1c1yOn+JXICkbtV9uos5bL64wxj+XK8WxH5pU62A5nPer6fjJ87Tu?=
 =?us-ascii?Q?p0KnW0YxyXCUyjoDk6fl/FbHsCRm+OsqmazeMThcqzj6SfBEKYml+lZl3paA?=
 =?us-ascii?Q?3UkJCbk2G2qFh5G3QqN7nOnK4Ir8gMDZ5Ml7hv580O6Qdnm+JJ2usKgC8Wnr?=
 =?us-ascii?Q?0YltvBrQimZkrXOtiSl1cugF2LXmxkDddirfSUlPQADC2aTPmtR3S+ttCT1r?=
 =?us-ascii?Q?Jalhh9knsqSTm/y0WTmbzylJk35FD+MxovCl8r0mfiyH22Yy7+gnEU9X9pTu?=
 =?us-ascii?Q?vd5Cs79y3MgrSxKRsH1++dBwTHQVwdiY7Szomn/vUurcAlF9jCL4avGX5LVe?=
 =?us-ascii?Q?+AGYywCHFdNhRB7M36/rnctQ91haGfJC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:46:26.0873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e98c9-cbaf-4ec8-0c21-08dcbd7c1856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

A typo is fixed for "drm/amd/display: Fix MST BW calculation Regression"

Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation Regression")

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 958fad0d5307..5e08ca700c3f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1066,7 +1066,7 @@ static int try_disable_dsc(struct drm_atomic_state *state,
 			vars[next_index].dsc_enabled = false;
 			vars[next_index].bpp_x16 = 0;
 		} else {
-			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.stream_kbps, fec_overhead_multiplier_x1000);
+			vars[next_index].pbn = kbps_to_peak_pbn(params[next_index].bw_range.max_kbps, fec_overhead_multiplier_x1000);
 			ret = drm_dp_atomic_find_time_slots(state,
 							    params[next_index].port->mgr,
 							    params[next_index].port,
-- 
2.34.1

