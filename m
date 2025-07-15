Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9340BC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E8610E051;
	Tue, 15 Jul 2025 06:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QxnMe2NN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A5D10E051
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0WuE8e2qSaBQxQhHHfsv0H80Pf7ojgta/vdPXjltZuUkh8vBjWURhuHbJcbfk7/XPLCMYxpEQ2iGL1OHZ8pcXVglOUWelLZBbWiQ+cuQMxJZOaJfe7ICVQQ8ZRQJF72ik1+Lk+gmhohA/NRzu8QUngxpGb3L30acb+aVlV4oe0mTUvjKyTK+y1WLQEBLJCRBfnvEuVVm+95+ZMURvQ1IuB2EXKhXHhYfDtmSag5JsHPeCuW7Rs+1oiX4zSiwTMaLthEfWiTLHUltbbPJHXneLFv9mr7OmeJRHiGkvoWNOCCH49fqP8UYdozHJipo0lPv6+h/Ooo6EX1N1BPpUFzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjbtOREUzpisbP0OEby9iDHmnx9FG0sHt/Asnuvq6ns=;
 b=T9UtRoizNO8rIkEb+5ScGrWWvzA5w7lFmmTr7IkTtZw8NvnImziVGGePRx3BUPgTPMpKGd43q+5GmIs+npIbyECOpzw4S+lra69nEn85SXybiCQS0QvA0YsLJpOk2A+4WISbCiya3LMiOu9Y3z7YJ1RpEz7yanjs2VFm16e2C0xPp2rov3/148aVlCXrVwbR4qCnxEhjaDoun4wNpMebCRD4RhJHand0B+i9rBM9n8g7eA/+KtDqAf25vclV/uIUTSe3ppQuExVWlDnVI1ZJbP6Af5WAAwmAfkj6aEXO7wdT8eBlye2c8a5TiKtaUMrvDFEltNuOgvsKex5wiGg2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjbtOREUzpisbP0OEby9iDHmnx9FG0sHt/Asnuvq6ns=;
 b=QxnMe2NN5Ef+gnJu2PpLG+QjALAe3IqLgIfJECHp/+hp8kKXwhezeuV72oVHjB5JFcFKTTYT2ljtmdFNcpncm1bwxylQBLPsp65BFbuxwDkwyM4M/82BIv+tKHViEk8tL9/KdQeze84fxeqVnqlY9qpmUx+UnLdQQOQhXK0Yg/4=
Received: from CH2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:610:4d::38)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 06:52:52 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::1e) by CH2PR19CA0028.outlook.office365.com
 (2603:10b6:610:4d::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:52:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:52:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:52:51 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:52:42 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, waynelin <Wayne.Lin@amd.com>
Subject: [PATCH 00/10] DC Patches July 21, 2025
Date: Tue, 15 Jul 2025 14:49:24 +0800
Message-ID: <20250715065233.160043-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 370b6e17-6575-487e-9244-08ddc36c3849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gQCseDSelfz4nKQsgiQlzl7p1xzBpugJt+BZQwU9DUcxyCpX7iObhnoPHAeP?=
 =?us-ascii?Q?pU/QvzEKmFbcNw6fwpabIrUFHi8U8q8UoscfNbVR1pU+0JhRABA8+tNh3BxM?=
 =?us-ascii?Q?xdqnAKdVw1vFlsnzZ2ObTBmtCnf7i6TS798fomLW1OglFORd6PRd5RHMeFMS?=
 =?us-ascii?Q?ImfjBxP9d8I8SDvUSGiafliKp52dhpHIm5iuHUJzGlV9+WCCkeHBklgqd5MV?=
 =?us-ascii?Q?rYakfEWU+a//qD7Dibx8FrKNj/Uf/QhzdY7SIn/83pWLvb7aPZp8VTOzyh08?=
 =?us-ascii?Q?kvNYLG5WD0ly05tzE14YDRhZ3JPcl+XXV5YXMIW5TQrLGyw6XUTKKYyOqsCK?=
 =?us-ascii?Q?2CSAH9Z2FuDALoBbKMIniBNrQ86ILPRnFHjq8u25juferj4TtC0D4rT0qbhZ?=
 =?us-ascii?Q?LWtIsB8CA7ocBAg3emPAXnEenBWcqgbNtF3ETUUs5jeKm/MNVLcUQ356cEAj?=
 =?us-ascii?Q?SZG7wjLuCq9G03stvLxnxlxQIQyhsQsxV60HyGqRLAcRxa/hpVpPXBtYc0WV?=
 =?us-ascii?Q?ZZWxobkHVKSprJIt1iH2Tid0GvsSAaB3zr4NQxpvkajxTa1cQDkKtBVJeVX4?=
 =?us-ascii?Q?JOTfgFlosQPLvyCRaqSjRkn4FhEimbJTh3lc3LgGrgtc7Y1JRo2fayRQV4pA?=
 =?us-ascii?Q?kRT7Yaw+nw5Oixrn/NVPZYufpPdFd3t6yIrJSh+hkfXkLvmc2jrjjsK/Djyq?=
 =?us-ascii?Q?FGI5msUYgiWoYDn/1z25nsp9GH4MAA5u+ApAMOiL1KQpnHIikzY0SY5o/dUw?=
 =?us-ascii?Q?x3dNaBLus28ROja0fe0cQBGRD6zwik+0Wbk9y7DiH8L0A8LNb8Lq7sO5XAKN?=
 =?us-ascii?Q?kdyD1T/yXvkXzsmkbJTIYKUB0K+ueONHjIBCin2AUyMPCBCherXGHq/tDiVX?=
 =?us-ascii?Q?F30/vHj9gZv/Fzi5l09WUmavh0Bx5ZF3PHYqXsuCNOoGv8Y9kSEFitxYPBET?=
 =?us-ascii?Q?5iY19xJiWLmiTHtqvSRzCYpkrHv03HzII77fopE1ozgxAT7AO0RpSCoDkhev?=
 =?us-ascii?Q?DuL7UqvDyVBkRnTMVSQnTToEhSnlyEcj4Wj5uwRyJ7eXPXbjKUu4tPil0z29?=
 =?us-ascii?Q?MKRT+5nkbt553+4um9Us7p1nbyAO8P0W/hONSazuKUa6VMJmF7I60Ac1Fr8v?=
 =?us-ascii?Q?rONggdXHsPeMSTHyuONLeAABvHCV7OqA+pN0R0gqK0REO9ObuycJ2HJb9/Aj?=
 =?us-ascii?Q?Tw80dQaFJMgVDcjMB/lNby08guyTU0ghYv58P24wvmWhp0/ZLsgcA8+M3rea?=
 =?us-ascii?Q?CBiGRUfGkXE8TES/S6opxk0lv3LGHvCcXJEEk13biVMM4tMrVuNbi1jYTIbs?=
 =?us-ascii?Q?pWoU+kfYR/OaZZCVGHfDwNXjXx7aZf3QMyF4D2PPG5zufz9WH4u/e3nsvOX3?=
 =?us-ascii?Q?JQS/iqVm/QR829NnJrztXE5A5wOuVLwHfAewmKh4pUtDa9CsDX/HkjwrTfDh?=
 =?us-ascii?Q?hnCS2DGQ7dN3Q1bKQsIAdRw1H+1i5xNJaYA6zNoN/JR/QiNf1e5HyMpMV4Vm?=
 =?us-ascii?Q?DcDTC2CrmbiPdnYUzqnvnFtUw2w5mGrtLrMRctGcfoO5TIFvS+WLCvMEIw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:52:52.4048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 370b6e17-6575-487e-9244-08ddc36c3849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Fix divide by zero when calculating min ODM factor
- Ensure committing streams is seamless when transitioning between topologies
- Fix condition for setting timing_adjust_pending
- Update DMUB tiled to tiled copy command

---
Aurabindo Pillai (1):
  drm/amd/display: fix condition for setting timing_adjust_pending

Clay King (1):
  drm/amd/display: ensure committing streams is seamless

Dillon Varone (1):
  drm/amd/display: Fix divide by zero when calculating min ODM factor

Gabe Teeger (1):
  drm/amd/display: Revert Add HPO encoder support to Replay

Mario Limonciello (1):
  drm/amd/display: Drop unnecessary 'rc' variable in
    amdgpu_dm_backlight_get_level()

Ostrowski Rafal (1):
  drm/amd/display: Update tiled to tiled copy command

Taimur Hassan (4):
  drm/amd/display: [FW Promotion] Release 0.1.18.0
  drm/amd/display: Promote DAL to 3.2.341
  drm/amd/display: [FW Promotion] Release 0.1.19.0
  drm/amd/display: Promote DAL to 3.2.342

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 16 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 43 +----------
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 29 +++----
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 75 ++++++++++++++-----
 9 files changed, 95 insertions(+), 82 deletions(-)

-- 
2.43.0

