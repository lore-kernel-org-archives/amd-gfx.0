Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF416C369A2
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 05:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E78610E009;
	Wed,  9 Apr 2025 05:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qaQ2FC4R";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C9710E009
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 05:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aS2/6ykz0dh1etRqXILjOzHiZ8I0v9OuKq3MDI7xoZLOW7mz/B3hQfIOHVAXIfP9VosWkgaVaBwyUadPaQvcxmNY52xK/Er940kE4v3ZreAgZwJZaw3j3dQNcxFvLbAjoNU4Pw1nk9lUGi9zGvckOk5t8CoHa730Wc7J0djBs0IFdJUZblK4N5qlP11w2jRPqPGGrQR6qfx0mnRRU4/BdCZq3s7OW0zZtLjQV2KXlcZHLdRAEsuoBGhfTcPcAgjfKI4AtzyTh8DHTQCulmGBBrAfgr52rFFYrrZvoKOhw4mxz1DFnhs1+3clgL3BaPAQMQL75L0tODnxndPLJlEzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bERWKZJAmJZU7aZT8tA3Nz/CGo7nrtI8bc81sUokeLE=;
 b=Cja0gh4i/NCBPiMHoz7SYYRTNV9MUtvVJRCbkGfGcZkSTIVq3Y/6UW+aj2aD/Mryq9gfiGIJgbZLhWBhc/IgawvWp2PcXVJXxuD3LZUQf7G44KB+iO+JphmR6GViVtTfj8aORkGIlbtIDYRjbnSJVOlki17DucO1D+zFkBJt5po82k3IcMpwSbWleeB+XCQkuo3fuhcxfoS/Cd70T+Wfgeoep0HsDDQ6VlGb9kPwkg225lUP+ADk/Aaq1KHefeten2jXeCEE7P+0Z9aUbWLQ5VsQI8dACKYJZ+oKkNWrTewu7b5gJ7uBIU2d6mH/Zh3N/bSoiEtmR6uTRervIjzHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bERWKZJAmJZU7aZT8tA3Nz/CGo7nrtI8bc81sUokeLE=;
 b=qaQ2FC4RXMa2bSX2O3GpjH3/X2qT5M35kW9Xoq9nBvIG1o3FsenPmFZgbucbmyTfbjmlrO0k5UsEUA8gEnQy+1SpD+KQN/4G8zO8Fwn42lM/3e0tOiJVjD/9ZopXKdIT4edYIIhc46wMsl7m35pHQTLOamxl1G7g9gaf6B5Dsg0=
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Wed, 9 Apr
 2025 05:49:16 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::e2) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Wed,
 9 Apr 2025 05:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.0 via Frontend Transport; Wed, 9 Apr 2025 05:49:15 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Apr 2025 00:49:13 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 2/5] drm/amdgpu/userq: Add lock before accessing
 dma_fence_is_signaled_locked
Date: Wed, 9 Apr 2025 11:18:27 +0530
Message-ID: <20250409054831.2411-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
References: <20250409054831.2411-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 166b87aa-1fc2-425b-4568-08dd772a4366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TiNUsXAJEnxN+KZlRFnUpZmc4usE9dsLTYTYviDgmgZ25b3m/QFg9jnNiUmB?=
 =?us-ascii?Q?yBQzoY5wEoFiwadCCmgCW99hAjQSj8+HwrV+WT1xIQyv17Bok25R0SgZAQQc?=
 =?us-ascii?Q?CgPK/9PHj/XZv/UOzAvx/WcoZCAFkACp89LICHRc6sAeHOxDhTixyVdynOIZ?=
 =?us-ascii?Q?mJYW9+VVHBUs+/e33U2lbRQmx+szqlBRGHoTeXVoWEqvDACq/Mzl736Xtwie?=
 =?us-ascii?Q?ZWkQA8S0HRNTvZZJqZfbKc3NQqy6ij5LWDf96i+YnILIqqwXrxaTtzzAELML?=
 =?us-ascii?Q?vipm1Cu26/QhCbPIrN30G2y8zfJxFTlnBg/XmfFSMnCHD/hEAOqyzTR953Sf?=
 =?us-ascii?Q?6+O3x0RWWFvmjVu8oasRiAZUuGsZneXTwuJBQ1tTrSkrNFcSv9k+1fdaopgs?=
 =?us-ascii?Q?fvIbKENSKKmc8gicGlxDtF64FJ6k3NiN2TuX03XUTgp/mcz39Et+R0/4iIMr?=
 =?us-ascii?Q?nmjisxLTODPE3YPSoGRnIs4iV266uKMrreWo0HxjXur3zz8yiNeTRuxxsJEP?=
 =?us-ascii?Q?uJSkuVILP0SrzEa/psI/5FeTueQ9OLh9Oa711CA/gPNLl5h7+qBWhOXI+IlR?=
 =?us-ascii?Q?QAO+6NTmtB++EUtWCgzXfFdd8ZXRkWNOx8XQOeMWh5WQ+d3XGgX7dXFwZkT9?=
 =?us-ascii?Q?Ieljg0mluWxZVL715I92KwXppv3LrmNxpu8NgjWF+gs7Du5QWGyC0rQfU6Ir?=
 =?us-ascii?Q?WCmomIN9g6EnJukfg+euK4M1D3DRL8kv9hxcYKW8+t0vE10a+1zAMVCnTIjx?=
 =?us-ascii?Q?MEtXt2AcOx6M96KfeLcMqoBcZtTPWfeR+ZlQHuEk/4AQG2EEIVsSpiyaFsCk?=
 =?us-ascii?Q?Aef/2BbPMnbUtksr3FyvZV52vnlz78jWuUw2K2G+16kwfICO9sdeQYBshDQR?=
 =?us-ascii?Q?QmeDa4SIBIyZTRkfO9xpc5KHWJ9LxCtuzikq9WfQlbsQxbExU4Ly88K+ColP?=
 =?us-ascii?Q?SC41P9lYX6zqfCxM4yWOZKQvJPsCQ868nRBchxIO0a8J4sFClYE1USy1Cv8B?=
 =?us-ascii?Q?kuIAATRkWf2LITosy/0tO/MrhBIq8wB2q3OXpJx9Z10ANoRRMAC/TtP2pJY3?=
 =?us-ascii?Q?uGxj5dR+Kupku7OBqM1/mW4Gz8uT3yqdk89QYWiD+4PBiR9twkccxcgVUgX6?=
 =?us-ascii?Q?T5l2QafLbEXk7PObJbPge467CS5ZQRZB9CJYzBk8DrUcOPoWznRIFfAYth7V?=
 =?us-ascii?Q?4o8FEENecf52/it5s5hFrjwL8xXFu+wsRobpJ+CVBMbu6LwsgsGCnmfeBqlm?=
 =?us-ascii?Q?U1inhaEYbntocyfl3K0U1z0tjoUD7/i5X7wiZyu1YP9zIinlB4KcYq+mwzWW?=
 =?us-ascii?Q?wfQYQ/js1UQ75IVwV5NfOVq/5C9I4zczHaeqlZrFz/OcQoahg89eJYNlNPpA?=
 =?us-ascii?Q?BbK8CnQDxaRB2LyYfGpJPtj2cNRIZSRFbUY5pOQavoACSU5orPbRlzgcS2P9?=
 =?us-ascii?Q?5RKLQP5jverQmUoh4wUdzO+RHE6SAoyEHC0FMBb8XZnLXSnR9S/uc1tyKPTz?=
 =?us-ascii?Q?gsPFQbn+mmJSqH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:49:15.8038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 166b87aa-1fc2-425b-4568-08dd772a4366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443
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

Add lock before accessing dma_fence_is_signaled_locked.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 24d19b920100..d5b35b5df527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -259,11 +259,13 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	/* Check if hardware has already processed the job */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	spin_lock_nested(fence->lock, SINGLE_DEPTH_NESTING);
 	if (!dma_fence_is_signaled_locked(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
 
+	spin_unlock(fence->lock);
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	*f = fence;
-- 
2.43.0

