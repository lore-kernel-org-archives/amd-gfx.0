Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB0FC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 08:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 380D910E326;
	Mon,  3 Jun 2024 08:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ER1ZZmBW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED83010E326
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 08:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGqJcKXZtcKxT1u8FmghI55wbEttAmTt1C6ZHRdPMxUeVRnzJj4rmcYEfvYO7uWLaaPQCAyJieMYaXSiNbYxYZgnduX93BfOjcwya2vGzR0fqZyUEvd32wx0zrJnqEpXhiQPY+Y+FCikFa5661yO4f3UC1imRcUy/V30EPux/Ef0N/5AxlzuiZm69KWhd5fhx7DNcaTtYQdhRdbhpYDZkyy8G8Oz5rPeq30CNs0f9clFMV+rnXlXGmCN50YhnTaBrjXTRqwJEp1hdYGLfCvWUVk7nTAncyR4A4/OFoEQgrjQ+6JYWaNMP6lJfxY9XSUAwXDtQ/lJQcmu9wi5umQ7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TYCyLkz7x3F81ELSw/WccA+17UbFi541TS71ib3YNo=;
 b=Rmves3Hy1uo6fuUt/0XHeQw6dIABslKSh1ND5ACEknJzrVbwlgT/aHALQUHfBhdZuutsv8QaswuPRn8xio7o6SyQQDhE7DGRdevGl5rOOD/lpWOitXfricaLj54M+lFUx3fCNmaM9adGskyYO8TLsdrRLsA+2yyhBRgTA/1I0XwuW5DI4shtfndToWdzRKLGyiZjbLv7cdH9jzBDKtc4hMkuy9UeX8kgfvD6zaZHKMSPAys6WOQPcpazZItWCaHHjPS715G6t4O9SlN8ebEasonULwOkV0t/l22CW0nxx3S+iAxFbe5KtUQlhQ90OT5A4gM7Y7IRpu39A6736MkzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TYCyLkz7x3F81ELSw/WccA+17UbFi541TS71ib3YNo=;
 b=ER1ZZmBW1bJfyfPRkymwLorsW4i4PJkAH4v+EHAwEHucE+EMR12mabLaQkMHm7uUyzzQEMxkaKHZ1OvHoP9k9ZKxaloxRMVWhlVS7A7rZLOVUuDACbELD6lrS1pT23p8A28CswZ1iD8YVRBYiT6W1Z+FvRt8Xvkn7KPjSJJk/Tg=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 08:48:03 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::a) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 08:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 3 Jun 2024 08:48:02 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 3 Jun
 2024 03:48:01 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 2/2] amdgpu: don't dereference a NULL resource in sysfs code
Date: Mon, 3 Jun 2024 10:46:10 +0200
Message-ID: <20240603084729.15135-2-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a582b36-c303-47e1-2684-08dc83a9e122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lBTX/Hz4MzPPGIFARUPjKxn1ZMgOXIQwAfNbsBClezG1Ib8dcsQJYr9BDQxt?=
 =?us-ascii?Q?lUz9Jf41T9G2R1HaUrC6zFj3omn7JrroZo41aepUQz/X4qnJVA0y41WA9Bju?=
 =?us-ascii?Q?ARmR8rXlUZf7sMyHx1orHo7ihvEFH7eV4JHTI+Rnz1cD/h0a88m4D2LDSWRG?=
 =?us-ascii?Q?/1QffN6rs5d+iIFY7BnUdWIgOplERpyL58LuLHSYRTvgnarjgTTYNlTmF8hX?=
 =?us-ascii?Q?cDSsveLftZMfSpfXnjq+BtglR2VknSEbjmP+N6HMnpk3uQrO/19ndiS+nMRH?=
 =?us-ascii?Q?R+cT2dC+GjUrPwGgCrohzXMl6acf6wA7PVW0Cf6XWjnrFxHDuLO+8/4Mi3zd?=
 =?us-ascii?Q?TiUyHC0FbAQ4gkZyofmIlU4i+9FMsSp+tehhPnvVHo89FD1fk7t+FPCNxIq5?=
 =?us-ascii?Q?aT8KuscLoIEuELVpDLL/gyL1vsb/Plkhji4b6TED20w/5SbyMvKQSO/FdPGh?=
 =?us-ascii?Q?jQwBRCPG+GYjad6U5Z5WPpYRKxC8xaDu1LBZq7kqi1TDjsYmtCGY/JTKn8Yb?=
 =?us-ascii?Q?F2ZftPYkqAwVpahf3TnUOmYtnwTZMAwynL3vznWE96VctkuGX3FqvEioAsRA?=
 =?us-ascii?Q?bmKufDcRGHYi4OMpeNCEPjV7VLPukriDnm2ECAQ5pcwJ+qTKpr0BIqJzLIIx?=
 =?us-ascii?Q?TjYYHwv0653BruA+IMw7NSPzD/I1V/JBFILJ5tsqSo57Ux5WW9hxfK3RN9Du?=
 =?us-ascii?Q?qYt4kvuRfs/o+SwGsjAt9NCHng6VxBZNb2k+OHENZM5lnQhwnjHZiXk60HWE?=
 =?us-ascii?Q?fm5/zY1CFakLsAEKaP4aLho1AC1U12x1PPVY+b2bZm+FVuM/CdcwVhkYODby?=
 =?us-ascii?Q?lEk5Ld1ORf7FM+nEIkoCj/7EV0NRb4tMyqVCTC836mAMNILWygz/xc8D5/sq?=
 =?us-ascii?Q?7bTgjrWYvoAmCQ880LmAQo6KKeQA9kkqPKbeYWntsPu7Jrhvx85u7q10xnfJ?=
 =?us-ascii?Q?bIzN+i3WKewiUfKioeKXmRvlRW0M4HOl02txtDFJjWH4LOWWjNaHsKYjNPym?=
 =?us-ascii?Q?ZnD1TyfcSA6z5f2yI+3sJqqx39zt0ejLboy/xb2Rw1wVZjDJPQh0cd3qRBSc?=
 =?us-ascii?Q?3egNJeNav0U1QTrbnrpbjnRzD6pv9qAuueevwr14hCpjLwNyq5wHRugk1MGs?=
 =?us-ascii?Q?xMLBunj/xFG66LjKI/aszisFp/sJesZBW+xZBx6vCLuvEeTOBfr8+dEbMkjL?=
 =?us-ascii?Q?UfqOIIVlh+bzjg74AuBQG/vvJInROvGA7XlXcUhjYfrj3/T7XIY+4etDrPe0?=
 =?us-ascii?Q?jvrYADoeL3mnXQFtL2AxD0Nsqj+mA9MM/STiv6Dk+ADzMuNKdp+qEbn/r1Pn?=
 =?us-ascii?Q?WIO8xLG9zWt0Zukl4rRL0uWTg8e5Sb8p6OMupZBfwSrvyMBynSpkzn3nUh4W?=
 =?us-ascii?Q?anUKMAirWmjqBJiUb4jTJmNV/DMU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:48:02.8966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a582b36-c303-47e1-2684-08dc83a9e122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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

dma_resv_trylock being successful doesn't guarantee that bo->tbo.base.resv
is not NULL, so check its validity before using it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 63 +++++++++++-----------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1eadcad1856d..6faeb9e4a572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1594,36 +1594,39 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	u64 size;
 
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
-
-		switch (bo->tbo.resource->mem_type) {
-		case TTM_PL_VRAM:
-			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
-				placement = "VRAM VISIBLE";
-			else
-				placement = "VRAM";
-			break;
-		case TTM_PL_TT:
-			placement = "GTT";
-			break;
-		case AMDGPU_PL_GDS:
-			placement = "GDS";
-			break;
-		case AMDGPU_PL_GWS:
-			placement = "GWS";
-			break;
-		case AMDGPU_PL_OA:
-			placement = "OA";
-			break;
-		case AMDGPU_PL_PREEMPT:
-			placement = "PREEMPTIBLE";
-			break;
-		case AMDGPU_PL_DOORBELL:
-			placement = "DOORBELL";
-			break;
-		case TTM_PL_SYSTEM:
-		default:
-			placement = "CPU";
-			break;
+		if (!bo->tbo.resource) {
+			placement = "NONE";
+		} else {
+			switch (bo->tbo.resource->mem_type) {
+			case TTM_PL_VRAM:
+				if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
+					placement = "VRAM VISIBLE";
+				else
+					placement = "VRAM";
+				break;
+			case TTM_PL_TT:
+				placement = "GTT";
+				break;
+			case AMDGPU_PL_GDS:
+				placement = "GDS";
+				break;
+			case AMDGPU_PL_GWS:
+				placement = "GWS";
+				break;
+			case AMDGPU_PL_OA:
+				placement = "OA";
+				break;
+			case AMDGPU_PL_PREEMPT:
+				placement = "PREEMPTIBLE";
+				break;
+			case AMDGPU_PL_DOORBELL:
+				placement = "DOORBELL";
+				break;
+			case TTM_PL_SYSTEM:
+			default:
+				placement = "CPU";
+				break;
+			}
 		}
 		dma_resv_unlock(bo->tbo.base.resv);
 	} else {
-- 
2.40.1

