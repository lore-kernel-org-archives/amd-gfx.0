Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D5C5B543
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199BB10E0F0;
	Wed, 28 May 2025 02:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gljwQMhq";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F207F10E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K86Hs8+OYMia/zRicz25itSgUEQasoLumvLd4Om92QEO5F5w0zGxdv4OaABeSmSqZ8ejhci3j+8ASVqquQYbPOWR20mOIdVfLmA8+AyyGKE7moJaJxRaL/JhC8Ya5dnX9iCQabDtgzO8qNIgRSiczXRWTOBlW//ED1yGl3pZEhLh1zHrasfL+TA4XDyNHBkzaDQRm9N41jG7CH4TxvnlEdg/5kOy8saIx+B31ZXwdK9JWHMykfrp4quWTDTNsLG1RDDqdybaILsra6BxFW70R0lxkdX0Hp2R+r+6AXkHVq9qsdbq9fEJYeScHfXf0yeS1S0iZkiyqqzSLKZPtTG3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC29URVMKH3O0hKud8W3TBkhXByNHIxCK+Y0qUBbI4I=;
 b=LSZz9rXT9EWyNHziZ5fEVyCfG0kHdNgYnSM8ixeMAz81iSt6HsmcKNQKzxGOqYbAKOIdsc6MiYd2Pc97HpF1vKk3jmpUVf+H2+ddVze7iLrKlQUUa/s6rTA+iNn9YuC/4dAHe9KIx4ptaAuwosiuUSZFodUpd18EQMM0/ORa4x7xg79hWRMCB2SOEOM5V6BXheP7gb9iMBAj7gogjsbUrHxSx0+RglEo3rzP/BFYlu9PfPieTxprrv7fXgQcDGVCCivrIaANWUnvKVsqgrOoMKQVkwLKWwwxztaPIws4Mkegc31Kzpylx3jeOL5kj50mQfxgGHMv4aiDJY15P8DjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC29URVMKH3O0hKud8W3TBkhXByNHIxCK+Y0qUBbI4I=;
 b=gljwQMhq2PFoBkU23iCz6tJu3izSOLGxT0/5XPN78FjuZwVavBMsO93rZTCuH6zDsk5r7los3KrVT/y1a9XLkEcfI2g98ghZ1WPGOWEszuwYxdplJAYKVc4dH3dYERnoQqklyuQlFc0W47CLMKdscPXKf92Esemgcmtt/IE3Pno=
Received: from CH0PR03CA0407.namprd03.prod.outlook.com (2603:10b6:610:11b::34)
 by DS2PR12MB9711.namprd12.prod.outlook.com (2603:10b6:8:275::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 02:52:27 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::86) by CH0PR03CA0407.outlook.office365.com
 (2603:10b6:610:11b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Wed,
 28 May 2025 02:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 02:52:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 21:52:26 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 27 May 2025 21:52:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 02/24] drm/amd/display: Re-order FAMS2 sub commands
Date: Wed, 28 May 2025 10:48:57 +0800
Message-ID: <20250528025204.79578-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528025204.79578-1-Wayne.Lin@amd.com>
References: <20250528025204.79578-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DS2PR12MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 74683e27-9498-47ce-f650-08dd9d92ae5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ycBvsN5fshy1PXEStRnpRmIyLGmOcqT9a+Qw+eHVYgNvoHkfCAmbP39qFXiK?=
 =?us-ascii?Q?5/KMmDHBR6PEuCiQw9ibm5GOF6twiQWetW56C3KX/ylSoxlLRlUdxnjiaURO?=
 =?us-ascii?Q?c0Y9Hp38kTMsdpsbfytMjYNrEQkIaWqXWTEwyIrmBqFVZpW70yfL1SotSeLV?=
 =?us-ascii?Q?t37gd/GGsQVLVLuDa+XH47BqJQQexZfS19s2G1lfxuRQJpCtXKBVCQIBJhMw?=
 =?us-ascii?Q?vOvKYbBNCXHV/pRwgR+rTmIKwJyEup16sxuPDOdRWIQRcpPQj01xspp5z7Za?=
 =?us-ascii?Q?1mUYo2MePuyIJRCaXP3jximhFJgcOCZcDu0NyOyGMgnTowJp42t4g71HD3yg?=
 =?us-ascii?Q?jhdCg8sS3OBEhXPEIl00l4UO3UT/oQ2Owhhsp9kzzIH+r/giSby4i6KH/qwO?=
 =?us-ascii?Q?lMujziufLs+8EaCRM6idsbEpwt3W4un+npkOf8LRQoH/YhENe1e0VQ0MgKVc?=
 =?us-ascii?Q?svjqDWcmGUM08lVjdiC/yfoXQFX1eN8X02Of+sBcrrHlPOeHxPEI/kum63qu?=
 =?us-ascii?Q?KrinwagVvPVTWaz4ZgXVSDJvas7YZvXcOsuUCRVPdjT7ErhCjUzyGYyrV69P?=
 =?us-ascii?Q?8Hf7TziiKshLvgwRIwU9vV5dDYYv3GUoIqLDmevmKG9sHnU5GT4YYSjaLlkM?=
 =?us-ascii?Q?4K8xBiBQ2BAF+eUfV5D1VcpgnBp96ks54xdpGxQnQdmxzvU7EgpduCkkY4PN?=
 =?us-ascii?Q?v8BDXqun2Nxq7qd20h0qZSfl794qw4HBJB2vxgORtjAteoIdr2WjWYN8dYe/?=
 =?us-ascii?Q?ChIO0eGhYd5WfM3G2dPQQSLYvgTQzd7Dug2sZz3qxW9RXSozxFYyiZ4/LO1Z?=
 =?us-ascii?Q?sUjsJ6YVxZPaVZr33WNbo2UavBgeMUQQWBv2nMbeu1ZGD4jMObGd3wa8zQki?=
 =?us-ascii?Q?3NQOoFkAezNfRyvvCRDm5fkXSoZX97PLNIYXAS4uSjPo7eCU2yefizZTW/Yf?=
 =?us-ascii?Q?uFvnVqtO4NlqQilBiebNd6CSxXi5JUZCXgNF2LirpgfU5J/gEFyNj6l4Q9hQ?=
 =?us-ascii?Q?xSXqqyut0+SY7cLkN2wv1HEGEHf2GoFdQODnivdW4pe/zTzxFSre0J5/uqVk?=
 =?us-ascii?Q?B1UX6cvgwEllIIc7tNvOA6+DulvYsiEMasiQgzZMDfUEOKtBB23WUECTpaLT?=
 =?us-ascii?Q?ts7ZPzCEvDM9cTPDW1u8/PpQe6Iwb3bM1qOiqjNOlsNmGomYENlQpRhYTgoG?=
 =?us-ascii?Q?3OYe81hvTE4eVLB2wlQleXTkR4YFnJkg/tkRuzUqs6M7vjCg/A5k357Ukn92?=
 =?us-ascii?Q?zF8uu+gZ7NmA5UYci2U+kY0mFQEx0wT5XWuVC5uYTvpfO06uQD3cMDJylQOc?=
 =?us-ascii?Q?7G0P1J0QITEjJM5CLUK6mVY/tm1d4eVqkeGoD9q1YEeEpzBZIH1jV1WZfbqr?=
 =?us-ascii?Q?2mghJkyquceWH5t1KwKj/o5u9Kd7MO7Rnpiee6NFUDxsPhexUzuGURdsAyDm?=
 =?us-ascii?Q?1OlD1p+8rRK2OD9bFEcqkuIl8Du6VhYHxF3etQtbDTxVRrffQ6RbKphPR6f5?=
 =?us-ascii?Q?eBYEh3Re6yNcQnQ6xgY1VlXgQgPVN3UC7izq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 02:52:27.2248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74683e27-9498-47ce-f650-08dd9d92ae5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9711
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
New enums need to be added to the end to avoid
back compat issues.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 57fa05bddb45..202904af4682 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -2957,9 +2957,9 @@ enum dmub_cmd_fams_type {
 	 */
 	DMUB_CMD__FAMS_SET_MANUAL_TRIGGER = 3,
 	DMUB_CMD__FAMS2_CONFIG = 4,
-	DMUB_CMD__FAMS2_IB_CONFIG = 5,
-	DMUB_CMD__FAMS2_DRR_UPDATE = 6,
-	DMUB_CMD__FAMS2_FLIP = 7,
+	DMUB_CMD__FAMS2_DRR_UPDATE = 5,
+	DMUB_CMD__FAMS2_FLIP = 6,
+	DMUB_CMD__FAMS2_IB_CONFIG = 7,
 };
 
 /**
-- 
2.43.0

