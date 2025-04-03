Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAFDC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 14:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1100110EA05;
	Thu,  3 Apr 2025 14:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZvRBepj";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD7D10EA08
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 14:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGvdFlHpJR1lI+fE61vPhDUZsC2AQBqTsvBmk++ktAbc7IZIpTlD/lQrNi8M/0AnEhHkSafJhiKvgkths1LKWjBuf0adk2ff6gBe5Aujl2JCi1EGLM7WP0LPDk+VBn8zbzmYI5qkMFt813AqMQ9C7u5O1/kauOcJp31uHOz54RtbmSCvtr6804hW1dt9tJfmy7r1ec7JBZAlnjqa0IzSzR2FPkE0iFqChZuXI6cfyTSVlDLzibnBxyQHeBkRuNCuPV+7FrDUZky9fE1zu3+LEzOo8gCW1S2a5krZpR0eBDspZDTJxoq/PMEsbGWwtkM+A7qZcsFLVkuLZFbo8C1+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqQKb/pUOoBs9MhYxXfZwLyQS82EPvxm+rYJXF/zlFk=;
 b=B0t5MQPWgYCKG9sMaVDEbADQe34W0iIk9LFhQ5iu3r+a7ps8zz9/eCYua3X1Fp/+1DCxjbqsln5R082TljYuRu2ny/Q9x2s7jp/UfxTcrzhwQsH/xZNmS+LQ0xuRm5x/CuKO/TVDuw6bpMpv3cfiXvwVBz7rURqZF0FO3z+WoVuNqLaoffzP55LxcQf8Mv0+EStPrxGGejSVbAh7gSJzERwikGmxSBurmDqLg08sxeSP067v40yqrr69N5U+ayfzj8vD3m/C1kMBkPbx5WwatWNwF045yRc/MMWKPy901fQGJJoiSe4PEGwSpgUIp7Z7M6MjBupMQLpJS4mPn3AA3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqQKb/pUOoBs9MhYxXfZwLyQS82EPvxm+rYJXF/zlFk=;
 b=hZvRBepjvbcI2rq23b0uJMvlw1VAFkYS4+dzeNccWvPACvf+MRJUSBaaXnAMNllnSbqAlV7dlnk9eB6BB11ZxhWlPRqTQxh3VhOKKHI9I4ZC9AkLDL+TMmJUrMPDdQG7gArD9sJILfR14KsOF+2WeTSsOeadn1jbPTXlOpuSnW4=
Received: from CH0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:610:b1::15)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 14:40:35 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::5) by CH0PR13CA0010.outlook.office365.com
 (2603:10b6:610:b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.8 via Frontend Transport; Thu, 3
 Apr 2025 14:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 14:40:33 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 09:40:27 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Shravankumar.Gande@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Direct ret in ras_reset_err_cnt on VF
Date: Thu, 3 Apr 2025 10:40:16 -0400
Message-ID: <20250403144016.30030-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5f7fe5-0640-4a35-512d-08dd72bd7dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?El4MJvRtqNTlmjzqrga+Aa6/4oshgw3Kso64YOronUsJvBmPq1wVI+cfK5yt?=
 =?us-ascii?Q?lVIdtqAaQE1ig09wNmU/OATWh0HJ7g1dNWG4UmfqbiKgk57mPbet3O3lAMIL?=
 =?us-ascii?Q?j9FXUCweAP3xUIwAKe7WOidjqEdVsIjasmTqWMu/bka9NdJV6OxvsuEAL5mk?=
 =?us-ascii?Q?lGavX8YF4P9gpccpLPHtTtNhlxcBNkazcZNUU2TtEziRAe+JPNp6PruC/UCj?=
 =?us-ascii?Q?79Hql9tpVK60NgCAqchPpl3cbrlB6h1jV7gKS/Fj8oHJ+StX6fKCsw5wRQEZ?=
 =?us-ascii?Q?k237CQIufdgvi5/X8GscqWIvl/ADGPsmIlUzzSyklkK5lMEeprmGWq2SlwKb?=
 =?us-ascii?Q?jQScfmzrgZ8lzfsFzH1U6jAnOCdd3xCAcK1xk7qUudnEnnourW0kGwqez3ma?=
 =?us-ascii?Q?lYydSdAVFlYdqF5Wh1Wdpx98w3S5mXlfIXBp3HYVikVkz89UwPMf+DoUkJDr?=
 =?us-ascii?Q?RF0ySx6K7Mw3ZSp6f2M7SN41DOQQaNaSTwLIVBhvrL/vZmqWzIKpQDADgkTK?=
 =?us-ascii?Q?NnXcuT3zofcQJXE9LbAUx4KW/J0HNV0nVhxmEpOg+0i9W2Ifsju1ZZ3+zasw?=
 =?us-ascii?Q?f0KVjn8EklrqyfdxfPwDTG4G3+AeSXKtS6Jjp6v5saexlFKTqO3s20yFTuwM?=
 =?us-ascii?Q?qVIVIpm6MapSgHlI69Qq+pm19E+HuhP+laNmwT+CjJH0hL7pSTTQ75BWhT+n?=
 =?us-ascii?Q?pmW9/wfSSNkVwjXr//83whHt6qGQgD5et7nK4K0TCbOSTzZvwARKW1WhX/2m?=
 =?us-ascii?Q?k+29H+6wEgFy1zkF1UO/AWOGl7yX/aXCcs0e9Gz0aIpZgJMoV8zb9+52fmZz?=
 =?us-ascii?Q?9PgK/532sVevE+IenycTxfJUZU7CgMVJsAsdTCWx/lDaMQDbJW9YEF1A6Ehs?=
 =?us-ascii?Q?BoRkTv3AL+SLCzWxb+R2Z5xwpYPhU5L7gPcMZ4JE1IKg9cIxGkusaGwyJeaM?=
 =?us-ascii?Q?2/OXNwc2C6BU7BSYCpJkb5lhQ2zvuUGgzOSUJanNFDA/yS9WjGFDNYJ8bUPK?=
 =?us-ascii?Q?NEYSDh+aS72C2/6oFa6ZKZoni+PxzaB5AdawpLtU+9TP8YG1MZxPbNB3cVUz?=
 =?us-ascii?Q?qs6hIHtjD7UxSdgBCVwN6UL426cvDs7y+UQARM1242EXFBDfbDMNImIi5HDJ?=
 =?us-ascii?Q?2BwVBCPSQE8OGBbbOGA5ffMCcYg0f6ZBBd/0Zqo0V73dpG58ixCFBbDRyIbb?=
 =?us-ascii?Q?iGZUsIe57QNXBxMvqgMveMS+1O64rL/QE1S5kmYTirUXO1J4DBUFQB+yrxzV?=
 =?us-ascii?Q?BrQzob5Jqq5vZsXMvcC3hLMSmrTWUex9op8Gm+B42g6eIfaGq6E2rau/+0XT?=
 =?us-ascii?Q?g2w2wJG7mTj8r4vBta6uQo2vZgSi0TOlk2jlXLdVU1hH0vYibfNSSQARHdNZ?=
 =?us-ascii?Q?B0J27hwKGZzJI0ftSM79YnGNgRYkFJ0IV0xejTa2e8v6EH0+Gx3Dlv4YVpIJ?=
 =?us-ascii?Q?QiLW37g7uhp6DPH/lxvhI/JQ56YVn5Mg1S24D83npUl/v0DX/NeZL3PmJnzH?=
 =?us-ascii?Q?WgZGaCCbKWlMknk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 14:40:33.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f7fe5-0640-4a35-512d-08dd72bd7dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
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

With adding sriov_vf check, we directly return EOPNOTSUPP in
ras_reset_error_count as we should not do anything on VF to reset RAS error
count.

This also fixes the issue that loading guest driver causes register
violations.

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebf1f63d0442..f8cf9621097f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1498,6 +1498,9 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 	    !amdgpu_ras_get_aca_debug_mode(adev))
 		return -EOPNOTSUPP;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EOPNOTSUPP;
+
 	/* skip ras error reset in gpu reset */
 	if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
 	    ((smu_funcs && smu_funcs->set_debug_mode) ||
-- 
2.34.1

