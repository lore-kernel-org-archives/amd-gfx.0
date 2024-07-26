Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73CFC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 14:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83F7810E99A;
	Fri, 26 Jul 2024 14:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POwU6a6t";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 442C710E99A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 14:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUL224Ci163AnCeh1FHNx2m9RKUxTkJKrmRp1O9QHvzcT75AuowzES4TSUzw0yGtIIU8mpNU7fFugMsPzIn7CLCmTuAl0goQUOxlY00N2Y8z0a8zrBespm9mVIn5bJ6J3q1v+MOtrivJM5mjJIlXot+wTZi895R4erMKjUPURh/C7MK0tr8JWeJfF2vUMCK9yzReYxG5eq1YtXUw3mf7D2RtBcASfoUAwHAttxk/ukkOOinv1tOV7b/4SEWYHi+NXfEQ6ZOq9km07b+7KbBmgenoXP35E6e1+Ty7CpLg+37TsDuUeyNrNApxFxd14EnKFvi0a6BMTFji0b335UAK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+evFO8fABF+DOVHqjQiEQ7P5vCqTy545t0LubLzyJHw=;
 b=p1ugKWU8RKxAvEQdpIeZdyk0t3sxEuF806/bmf44jxbMcc4IaUvHDQfPbhSG8sDecSU7+EYuC7kxTQ2QfGRbXrhvStpeC6gM1SZSOSx5zPJmsSUnn/PTX7INHjPB9fQKDkbr4jNPySmby61zrhQD0gllNwhM3/WFG7lVFORVYR+mJE67cq04J46xktJXfpBd3mIh4unXgjJkOO/p+SmbqGcExshkeYlbGNeuSOZbY1wsfP43UVKwsS7osIpzdsthCxgrWNE5ygkeUeBwy/7Hx/GplEmT3Ik2TxuH+8vlB9IHujgPq5AKrb3mr2cHAK80daAflp8mvYRyCeT5szecsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+evFO8fABF+DOVHqjQiEQ7P5vCqTy545t0LubLzyJHw=;
 b=POwU6a6tQtZSVZaPdUsZhohikYjbHf2Ou2aDK8ShWcpPYkMyFXmkcbA0HjfN1AskmBwf5QC6SgozxoOcxaX9pNNY/Yby2rA3XKNthLSMr3dcWHoc/JNqPD9cTSaEQzBUEEHBSvWMYegbigfclVIkdDkgMOyiGzfRLUKG9qA74xM=
Received: from SA9P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::29)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:03:29 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::99) by SA9P223CA0024.outlook.office365.com
 (2603:10b6:806:26::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 26 Jul 2024 14:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 14:03:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 26 Jul 2024 09:03:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Handle null 'stream_status' in
 'planes_changed_for_existing_stream'
Date: Fri, 26 Jul 2024 19:33:09 +0530
Message-ID: <20240726140309.2409761-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 514ff495-379d-4e69-3d4a-08dcad7bb9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5n2wWgTnfh73Dc3VlmwJ/88BJpfkeqJs7vqaK7wTacrPFm+giQSAx0WBVztS?=
 =?us-ascii?Q?ic4Q/8EIomb1xhlIVnEpla9NUSNJMKrlpT0POLoWZOQRQYh2Vx7/idLiFG3r?=
 =?us-ascii?Q?8y7ulFNBZf6kiO9SX5YNMgJ6GralGw6WnTBlatFFq4NfWYl9BfPhTkuWylLu?=
 =?us-ascii?Q?7wm39unrJPLA28cmpK2KbgILl1LW+wf+9hxlTqyS6ygIxJSI7alLPTxlPpRp?=
 =?us-ascii?Q?gPSwF+haPuhIGiodriHJ0EkBxFOz2rrj4vsCgbwBwd6q17NFFq2EXg4YulA/?=
 =?us-ascii?Q?/H1KM6g/7i8hqmhsONS3RYFwRnoNX63AQ/CWTd8lS9J5vxmjFocWrrKkES36?=
 =?us-ascii?Q?V0DCDi0ezudbFyw4OaBfrM1PhzeB7RMVWNZCP4crsrQdTCLi8L+mgmgSE5ac?=
 =?us-ascii?Q?nvV9FPswtBRzWBYLIHnAm2T7CFjqOxbHAlKX5idhBOwRExEolzppt/tKhm7v?=
 =?us-ascii?Q?KjWya/Y8vn6/Y8twEGc2JyhVCP7ACHUWy/fri3iJFKwVxtWfpJ/snOe5S30k?=
 =?us-ascii?Q?HRfxwwedT1JbGQwOQHgN1tnJpJvk6+JwhGHL8YmFSiErUBtw5/wX/fHVftOx?=
 =?us-ascii?Q?gji9DWQg7mn5mmOxHYBcHUhaUP8YEDliqzOmAZGkG21ANM+JocfJZKaMaoBu?=
 =?us-ascii?Q?tTZ44o1I3Gi05iW6QcXag9BBNXHEmcytZbZXhMI8EuIKuLur+CCs1VNnXdNt?=
 =?us-ascii?Q?EU7mtpAQvudYL2bcwhoP8pDIV1/OSemyEhTUmOr7d3KKCiaeWz5BRaobQtBG?=
 =?us-ascii?Q?F3F8o/vr3R5H9Kc/yxTZO7CBeQyKYY4+dzU6OqRPunQHB1zZiDGwgWvFevDX?=
 =?us-ascii?Q?dUr/WPzbq8MYOeFBK1lpQ8/AK29naAKVYZzANaWQvC1RLVF/RO5Pi4POMnPW?=
 =?us-ascii?Q?sXUoOKJdUfil9nKObpeOnQUtNeCVgK/EbfIhE1U1KR6D9rEfjTOIsinBGo9W?=
 =?us-ascii?Q?3tBbZJt3yUzpOX53/+IdUId6SeRdDC/DLnnWE2fYX+Wim2L0lJ4lPdxf7YBW?=
 =?us-ascii?Q?ht/hisQvqCrlVJyNWgVzInEaeRrrGo8l0ZTAH9dSeUISFleicbxRq+1/V2u8?=
 =?us-ascii?Q?JGEmD/YPJJVPbVZPW0pWwUlAKdpiWc1M8inw8U9qTDyeOCTiCCUBC7j1iIav?=
 =?us-ascii?Q?bBAQXwDRZn01F7FrOGJqvj9U9plN2B+8dWKtL6EKWg2duQqjIl7PuEGCmxPj?=
 =?us-ascii?Q?TcrTBbc3QB/0tjCxLRnkOm+fbHd6or8u3dMwEdjwlQjlASHJzVPmWYk9bkhd?=
 =?us-ascii?Q?g6r6R1T31Y4rVjNYiueP+m3qaN7VVWg+GphDJeBb5o6T0i326XDot5eTeZNQ?=
 =?us-ascii?Q?bcdJXwlkxXu/FCd/2tASqX+MamPNJkY5ymceIZcli5KXmq1SnCeW7Ru4Miz/?=
 =?us-ascii?Q?ze6mmic8X+orYklq0FsRXGpUgPStvguTIST0oIKQUNAINs58zebpyK7t0XiP?=
 =?us-ascii?Q?PsvkN5W2q+YkFbB2it0/0dKiBkslkxBN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:03:29.0312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514ff495-379d-4e69-3d4a-08dcad7bb9e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311
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

This commit adds a null check for 'stream_status' in the function
'planes_changed_for_existing_stream'. Previously, the code assumed
'stream_status' could be null, but did not handle the case where it was
actually null. This could lead to a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:3784 planes_changed_for_existing_stream() error: we previously assumed 'stream_status' could be null (see line 3774)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 5c9091f2a8b2..60d34c696b18 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3771,8 +3771,10 @@ static bool planes_changed_for_existing_stream(struct dc_state *context,
 		}
 	}
 
-	if (!stream_status)
+	if (!stream_status) {
 		ASSERT(0);
+		return false;
+	}
 
 	for (i = 0; i < set_count; i++)
 		if (set[i].stream == stream)
-- 
2.34.1

