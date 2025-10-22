Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B5CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8155F10E704;
	Wed, 22 Oct 2025 07:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnvg+kTY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42B2510E702
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D57s0eKNJg5dfzJrxmSt3L5MCtvTB/1NLJmRvdRrDJWh5eDQW780zSUIEvjX4p36gfXbNRBSNudllZsxpBPHR+/NXKlhZ1QlASREt/zNrE6qVKDWSPz9Uk9cm0iEDvJv6t7u4ptskHo0ACeuoNurTUy7SRl+YRd8kIhgGuQx9+tpQQnLnxkCiZT5eGkcdsUMBaCH0U/YxV1lZQVR2t8Tb/cXRC16wqQg0/YyDFxixj7Jctxcr/I7GUz5FdWOSVnGvzhuPWQPrpBONfNRTA3QNEeMORbNepUIR1xqOb/7F53A+9bdYda1HlCvF2b64X6TH1Jo9Zokwat2YAG2AjVI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2Qr4/HZE8BthzFlIbUr6XW5o0xJAPdFsDjHPAkCnfk=;
 b=A7EpCyNUwXjPgFnnlLjk4WgxydUcv13k2GVFXY8WYw3F9THRRw4xmL1RxQSGF0ZixvxdvDRB25zin8wR2kgSzBGNGo+P7j/eqEZN3GxgOiaX/g9tMs3rTlWTlAjC8rygSukZC1TUJxIgLH+PDMwlBFmPJZR/PsW84O5VAbPP/eWqhXspb6pxNv++TZbh0cC2/cFq55FAW9HouZqD07mVZbB32E2oIU0G3rz8st0FOBrz+RnL8xmtgIv/DxQ6wgkpAnBCQGPQph4mb+gg+QxtkxBE701EqiQ4561x6xXAVyRJFgBk0x5vYgFd9weNkkm4/BiaeJotOLduMyhYid1mIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2Qr4/HZE8BthzFlIbUr6XW5o0xJAPdFsDjHPAkCnfk=;
 b=xnvg+kTYX0gDB1elFR7VPKk3Uuk5FezIbgK7Dm02Qwg98SM3Jacn0OQRZmb+aPLRPHBEBO51EmjFJa7TRI/fMTP2xrP4/yCAUCAa/74M6YTWpw9mF9CclxhbpelsJ4Eek3mrt42X3c415CxQoqCzBpGGJoga7WqM61ZU8gh8pTQ=
Received: from MN2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:208:fc::39)
 by CY8PR12MB9034.namprd12.prod.outlook.com (2603:10b6:930:76::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:35:28 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::42) by MN2PR02CA0026.outlook.office365.com
 (2603:10b6:208:fc::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 07:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:35:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:14 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:35:13 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 00:35:11 -0700
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 18/20] drm/amd/display: Fix incorrect return of vblank enable
 on unconfigured crtc
Date: Wed, 22 Oct 2025 15:30:30 +0800
Message-ID: <20251022073332.666119-19-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY8PR12MB9034:EE_
X-MS-Office365-Filtering-Correlation-Id: b333ca8d-cd52-4b85-15a6-08de113d9219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sIcmeveT/TMsL1IH0Yh/grgloTqRo5MXMA6Pkp8IQQGsSOW47BMEM8Vj4MJe?=
 =?us-ascii?Q?M8BD5DuLg9f0ZjHjQup9G34RR3AFxz7Hrwnh4Q954LbDHLv8/e2KeVwlFtQb?=
 =?us-ascii?Q?cxiDBD3LLeegcV4awbt0Kjo5hu5eFYRiKTtF1SPA4AZs93SllGvhEG6+QIKu?=
 =?us-ascii?Q?9PBiI0AjysnHUen5j7/nt0Bcv0GPRMqYP1SwkM+l/fS7lhfeIgpY5nMRGDG7?=
 =?us-ascii?Q?gnhIUqHaQj3l5b9/TgdVV1UyaYDqFgzjBTqgh/wRZ44vlT9CloVqwHqkZg5b?=
 =?us-ascii?Q?dO4D3D6RBuNexWj8hQWMdkD22XUmnWnoYz22VMLONWgc2UDGKbMf0jPfOjG2?=
 =?us-ascii?Q?+oKXnAZ59nJ7m0W9AW0zUrxGJSMQEdYAwEGyNUPN6a2fWwlzMEqPsArbyUyh?=
 =?us-ascii?Q?FERKsa4EnN2LszXbSRReCOYuqMOrP+htrUuuHMjBoqSdJ6w2hJIVTGiAZVtC?=
 =?us-ascii?Q?bf1tTyVHtj/Q9kbXp4F9l+tqA8EPGGeji4Y2RinIg3nPEvABrn7XArlaa+UK?=
 =?us-ascii?Q?8vyRa5tyhA6SrU0CYYbV1GDAs7JZwy0+0hOy/Ho/Cq3+QlqZ/kjvJSOpxeTg?=
 =?us-ascii?Q?iR5iDPE3HWhwJdptyGQ1D72YW5JyvOnCeqDQYo4fyFXAs0iqZc7mbzQxbZXV?=
 =?us-ascii?Q?LlithqHk40NlyLcrGuYtjH6Zm/qr28AsWauA6ent1jhjkh4xgSOorNqj1hEf?=
 =?us-ascii?Q?UrFy+QliSk0txb4v/Dmr5zPuUhVDJ9ChDb5qkNBZCVR3YWjRjDxVkqkgKT4v?=
 =?us-ascii?Q?asQYSB7TG99B0aWu/eIg0L2G5gHpRfvnZXc1pOdyAEj5ZLidhsblCIiDRykX?=
 =?us-ascii?Q?4RI8DZJ/3uHgvexEG+gjzU33Ud2kzUYTSGwLeaI26j2orIjAaPsUV0NY2FTp?=
 =?us-ascii?Q?M1362wleRjZ9pIY+kdCopACP791p7aw1U210TJ8VHtesjsLlf8/Ylo9PZaE8?=
 =?us-ascii?Q?5wYDLA6CZkHzY32jb/8933ZqzoSPxm8S8OMl+qDNRLddhFwELhVdtjEndP++?=
 =?us-ascii?Q?Yj4wLlDtO0IniZCuJcr4U+Cot0quS3WEoWgex55F0VA8ntt16Ci06qmDoBki?=
 =?us-ascii?Q?ebv8hnaVow+o5MSdy/lqMlixjm35C+bpIdbZISJQB3OlKNe/TV/G8NuFc9Na?=
 =?us-ascii?Q?/Kq4VaINOTH1aUkVlmFHostcdsE750r6cuPbN86fGhcRpgS17Iqgn8f78G7O?=
 =?us-ascii?Q?KaDEd1xo5E+c3ThKD2utMK1wBbEhH/Mr2Djuv4eZhXrnYJtezp3J/Rbpn273?=
 =?us-ascii?Q?iL/LY4PyGE2TGNddkgZ+QoG98FTNbBRjAfHvh0J72YprNzGdaODenQbMuglI?=
 =?us-ascii?Q?1tWggkw8VhZCZ38Hl+bJnNo6fugYUo9HamrThlA2WUMcnf251sVPdNjZZghH?=
 =?us-ascii?Q?I6oFKdJKxiky/rigQZzugxRNzuVidxUHTshi/vqfOAGyHIoxXqLm+rM5MXFZ?=
 =?us-ascii?Q?zrlJHazMZzPlO2MHXedGWuYWaj7iQHY34U/IL0k+hIvUt2J5zJQDEJWzVNES?=
 =?us-ascii?Q?uIGUDMYSr0EPQ56xsPNghofIbrfY8hN1LlT9aQ0pM6Oy7lh4IenFolppKA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:35:27.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b333ca8d-cd52-4b85-15a6-08de113d9219
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9034
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Return -EINVAL when userspace asks us to enable vblank on a crtc that is
not yet enabled.

Suggested-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1856
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index f08121a2b838..38f9ea313dcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -308,8 +308,12 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	int irq_type;
 	int rc = 0;
 
-	if (acrtc->otg_inst == -1)
-		goto skip;
+	if (enable && !acrtc->base.enabled) {
+		drm_dbg_vbl(crtc->dev,
+				"Reject vblank enable on unconfigured CRTC %d (enabled=%d)\n",
+				acrtc->crtc_id, acrtc->base.enabled);
+		return -EINVAL;
+	}
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
@@ -394,7 +398,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			return rc;
 	}
 #endif
-skip:
+
 	if (amdgpu_in_reset(adev))
 		return 0;
 
-- 
2.43.0

