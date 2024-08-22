Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7EBC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 19:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E37010EBDD;
	Thu, 22 Aug 2024 19:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myb1RH8E";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5162610EBDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 19:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8QHxRIaFDijJ3HnToD+V3pMMMGZ7iB3RJOf/KUW2K8pr1VcTNGZR9mLiwOQnysS5ejyfrA7ihu+OTZIwkY8k/YB2HbefjxN7YtWl75l8ufKFSqaaf6UG7kthwJv7uptGeY2dv2cGXJrentSaP/CCqoZWsR2MFLwtGzAHI/bJFo+/2blsXrvkV7otrsVPV9ppa0vIe+F9uZK3FnfMNOcJYwystt4jQadp1Vkm8sZXsJhZnoC8DpU89pKBH4reFRX+MIYxp8F4XFxcQeoR+lNEQQRFM4CaLpzHb1Gf6dPi0Got6n2CRMQRkwuPopKC8fTiHp69YzwROdrvgQ369mUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOuLCdIH0Vu19trzIhbGaQ1Yglhg37nz0/UK6/0K5ZI=;
 b=t1JDm/9DJ5UeYB3F1tjy69ijcYUF3aCkXgPpv7WGX0NmIn5Av/0wUcIkp2Fuc5sQSgZFzxnkNbmNhSaupewq+Mxw/cMRltXzuhqI5ltvv3KQ525G5ezaZ1OAUu0XYN5xUER833nwn/iDSYnxD9LTjsMBjkrl/bI8qTKdHX0ETrSBDHdoAEc2UYvD1tEWjLMIUId2K8Hy+TkTF654T2h0JTzjBBLyCUE23iwVxa0EkS29DFG0PtP/EGU5x8aSsuo4cPBelQ3dSu0phhU8g8GKgovtYQg95EgmogFEzSx0H46Qq2xN2MeGHEirGtRdKrCWqxckSlnpGHI7v1ivboi6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOuLCdIH0Vu19trzIhbGaQ1Yglhg37nz0/UK6/0K5ZI=;
 b=myb1RH8EcENixdJ+M0yka39Fv93EPPfvKv4chEyWm5ODrWhIMlHwtHx0qRP86fANimapMYUYx0i1aRiefApvukEZjhRakjSV7EPBZ7vihxaISgzUa3rh2KKAtyglDaPfDfeJjzgnPo3/vfPq5DTp30YWHSmOR5ETDMrGfhNtnIw=
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 19:15:30 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c7) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Thu, 22 Aug 2024 19:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 19:15:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 14:15:28 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 Aug 2024 14:15:27 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <jirislaby@kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <roman.li@amd.com>, <hamza.mahfooz@amd.com>, <wayne.lin@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix a mistake in revert commit
Date: Thu, 22 Aug 2024 15:14:16 -0400
Message-ID: <20240822191417.622336-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822191417.622336-1-Jerry.Zuo@amd.com>
References: <20240822191417.622336-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 40af326c-1ac4-4d3f-8fa7-08dcc2dec94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2Sta9sXFLL/buOIszlgasrMvJjx9sCzacw70VkU9QZj49EWWmh61buEwjKPj?=
 =?us-ascii?Q?SjOma6t1JJBrK3KhjB6sxcV/PivixHx0dWnp7GiCZL7FOWGlVuL/3f8AAaIS?=
 =?us-ascii?Q?YBxdeZUGzvgjv21XhsTs20J9a06knLL48puWIr8g4F3SsZe9C1nV4bEH2jM0?=
 =?us-ascii?Q?ooTsLc4b6Y3FiF441tULJ07uPNp1sCdT8uFe017VEeF+G+uH4qFpRYSAwUc9?=
 =?us-ascii?Q?KX586HRgn4WMFtbj10TBauBNXLi81dvJ+e9t8FHPzNSJqi8gAraUo2WD7B/a?=
 =?us-ascii?Q?VScnptcSgh9f9veRKCZIfDFV3yqDS4hZ5uGaXSKJ1MEbkLYATk4+/m0gya+7?=
 =?us-ascii?Q?TsdlmUJU6Oo2VUM++aDyKBkmyp32C4ZxYgKNbEwFKx2SLd9PtzPxX1nC1B/c?=
 =?us-ascii?Q?LsqDuqwtYNZFroN6e7glzYdnlKZu1+imR+95R363Mj97g9CG/WsIHLAyqVGd?=
 =?us-ascii?Q?axn1byUsrmt3ncAc8Do8P0tpKge3cz2VJhwMpDy+XXR/dAQceQeEGys0HWOO?=
 =?us-ascii?Q?As2MLMEEqb5qGSO+peBqFnFd4M3wVYsMGj2B/KlaLhgzPT7JV3xPSjantIbA?=
 =?us-ascii?Q?HREhHufYEgK01R51TiXlBh/Kt8n0JrnPPBAfrNlu4B7MWRPRIrMOPQX3fExR?=
 =?us-ascii?Q?juuZ9iLMNiZIVxhGYdsDS20eyLUsLbm3/msh67dk7RaEZ7nmWFV2ddeOMOxE?=
 =?us-ascii?Q?DWLKRi7Ipaj1aJY9kXkYkBmauh/l9R+1HK/3L4NFVKQSbU16mbULW8ZZDaMY?=
 =?us-ascii?Q?/HdzE7V6DqS1eoPFvB/JMAMKLfOWjjGz/nFoBzBO5Q1QC7zwi0pUC69NhLC1?=
 =?us-ascii?Q?h0XlVGYsHyFk+8Pw0aUqX2yXbpZZhGPSBd0Wpv4rYJo0CKU2OOnkXXGoetct?=
 =?us-ascii?Q?OCaT/Ha0Wj2jCqRzD3132s9b1a7ZbdJa42Qwmtdxdac+QPOchkHZasjR33SC?=
 =?us-ascii?Q?OaW6AWqzisCfzSSFL9tJKER8pspn4SvpQTRfKNZu8Hi5T3FVNk7TlVN6lK5J?=
 =?us-ascii?Q?hRzfIjWugDV0tiQx/sSOwW645KuUV/9PlgTrNh99010SGp63O1TraNoIgI3i?=
 =?us-ascii?Q?JZod/bTgMidcGcxZPJFqi/Ul8JG99iT+2Mxs4x+of1K1Wx/6e5Xo+1JfBAO2?=
 =?us-ascii?Q?XldnFBpkRQnG14brpHKnQfCVYbI2sGyvK8lBe+kb0nF+aTQ61uZKpKxwrPXX?=
 =?us-ascii?Q?HTJMTCcqIB4TOvNYX9ypt+e9SsU5CD4nHm1/pZiSo/UMBuRRmgGrLm6yc18S?=
 =?us-ascii?Q?j1LC3CnfWtXyxtxOMJe8+TMVMKAKDkucsnXVfYizDgL3txdXmVtBwAB/dPqp?=
 =?us-ascii?Q?JCAX+5dNebQIudxy3tvK0j5DAURDWm4U3tt3aDXrWqftEd3hLsNkCgxNa1RU?=
 =?us-ascii?Q?1/gBi5P7DBZkS2DJMLIzfZC7WrF3Kzkd/f+whAfbkCOnuqLZ5vjrcLbpr7yi?=
 =?us-ascii?Q?VlHL82CLRyY/IxUWGRz1ZxqDmV+hWTLP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:15:29.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40af326c-1ac4-4d3f-8fa7-08dcc2dec94f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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

[why]
It is to fix in try_disable_dsc() due to misrevert patch of
"drm/amd/display: Fix MST BW calculation Regression"

[How]
Fix restoring minimum compression bw by 'max_kbps', instead of
native bw 'stream_kbps'

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
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

