Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C43C3601A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB5110E825;
	Wed,  2 Apr 2025 16:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PXXgvRzJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0127410E828
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcKNQhctbVsUVKVNIL0h1bZsW1Al5rAVzIBfhzQFeHzK7AYwLhia5hKHDiudaGgN8ZZRZx0FB9H6MTEeA+0u8tfxgHk7O1uo1DWeD4tLsGHMYGPec2CFdH2faD+zAV4A2Ekf50sWcIpiOIZTh2VsplxgVQoic13PoHp1ouxPQKfhigG9zGWJYZJqRCJ9Xsv1EkGAMQzIVojko2sj1LgUdPLx4mYeLA6BMLMVimonXKHaOe3EsAGLuKhvM3ntsLA93zbZRCwfaPcAYh/daedhMaBZAZfen12LzFo/aKsnb3Dnj0Ip8yotzfr6cCyIjXamUxDJ3M15gIggcT5V6dpa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJAEp40FvYWABktllreLiLLwXD2RwCuA3nhswbg6CZI=;
 b=fkaowQKXWAynB3wvcQEenDWb7tjSW0Vs2dqdcmc5TeEdyVeZxiz3YgOjMg64QCe/5o6p2LSgFW07sdQ91TLDl9XdKAVcOg3MhC3mA+7945Ac2mDfLJjmA2IolVk9Eg5BOqjGHi4fSUy3lTCIh7m+dDdhW8tv5zteCZVVQXjUWr1okOR4pdVrwcfy1+fnubXlV/4ckJjV6skbpkF0Jcyt+ei1nf5oNUazhrVtUaRvTRyaQMIu1VVQlv3uZsiS0+DxGY7Q6wA3iittosB5C4tCWEbNCkR2VdGKMAQCD4FsYJfhkUZ+bOjYCtpSNdnZCkrTAx18pSicWerHXKeilgwSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJAEp40FvYWABktllreLiLLwXD2RwCuA3nhswbg6CZI=;
 b=PXXgvRzJsjKU0Qg+uRnqcofxfJzr4oH7rvrM3XReWaUF2D28HZlB7y71vUhhCx+5OWyeQ5xHiF1VU08KiRV8aiL4Ub0oYWbIUsa+qlniIkIAm8qEuhfPS0ziIsDpBiWCKT9Te1I2WE+++KDHMKVfMPcHESwHGSX/s4YU7/QIDWU=
Received: from CH0PR03CA0412.namprd03.prod.outlook.com (2603:10b6:610:11b::24)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 16:13:43 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b::4) by CH0PR03CA0412.outlook.office365.com
 (2603:10b6:610:11b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, <stable@vger.kernel.org>, Alex Hung
 <alex.hung@amd.com>, Anson Tsao <anson.tsao@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Add HP Probook 445 and 465 to the
 quirk list for eDP on DP1
Date: Wed, 2 Apr 2025 12:13:11 -0400
Message-ID: <20250402161320.983072-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd6f17b-f3fe-4e3f-0c5e-08dd720156f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Cv5lH9yvEsKZLNNcJEnZfBcTAlzPluyWhR6/YinF35wBu3UUm3o27n+uvuXR?=
 =?us-ascii?Q?wqxObjqq0U3Bd8R1DafUxYYrLgErsSFZpa4/snSzFPPKs7S+oWSraY0PZwgN?=
 =?us-ascii?Q?Ihe4ncPIiMrH4SbdrMA2Kn39Q4NOMiGiWkaaHQxzODV69vHccjsUwYgbUOPB?=
 =?us-ascii?Q?sg8vF7ecUKQEMfJKCSUR9m9h4ZLQKsSOHmxuWyV8xzIJNHMsfhuQa7TlOSId?=
 =?us-ascii?Q?y55J118IyNlmxU6vNmDl60u8dakhwPi4ClWw98QSREoGNvLPCiOrWIIoe/q0?=
 =?us-ascii?Q?4HqQQZR2zNMAfA8T97vBIy3QOYuZ9sKNcTeJjbq6cezhG1wrWemiucp9aWZ0?=
 =?us-ascii?Q?4zflrtiPbsKSbnz8vmFJjkYgANUq6XtT/RRaQDllU+p80NTeSi8V26zgQ0mk?=
 =?us-ascii?Q?8f8wIUINKQwAB2N6cuYiTQ0kqi9iVnG6kVFQLNwjJl2Ep9K7borpyknXgHh5?=
 =?us-ascii?Q?cuzlMbvIcRZ1kJSTMqDJZTX0U0QTmRLJi2u6+LARmFhCGI/4TmePbMBE0UgE?=
 =?us-ascii?Q?yauUQ4n6zhZuVQeXIsh4nipA7W/RzHlvocbWczNv/PhjZltROmmkGfNCHboU?=
 =?us-ascii?Q?ZTmShLpzqRPvP3JkT1N2ZQgYYf0oLnEVBfg3M8Fb76Qlvn+bBlPcPY23CMwT?=
 =?us-ascii?Q?6XITjuu2nIf5h3rJ5bXQjY9DiyTrRkKB4jceHMmSkmWsut4DGlcrWaD6IdM8?=
 =?us-ascii?Q?74IaCII7tD4qMcusr8HQEpqQEWTPsGeOKmMPLz3wD/WQadu5YQRIlRiUIcGa?=
 =?us-ascii?Q?kBITdN0M4x1pgKGZS+kdjEeBNlfr9p9W5oDq/aQ74Aw0ia2h0uPO1OAdL00e?=
 =?us-ascii?Q?dxvQcPX5EykcQel+/Rd+jRjTKTfaWQKSYqP88NYh/v9uY/zjLhS+kf4EO1B6?=
 =?us-ascii?Q?yqC7THww3QfPxK0r4vMAsc46JgOo5KdRAKBxG8ysSEp8+18NyzopSvTs05FR?=
 =?us-ascii?Q?aSfJ8RfaMfRuSpG34IbJuBROSlxfrGc2xmG08ZgEvn/FvkqMdwA3aNF8HucH?=
 =?us-ascii?Q?7dgGeX3pWyNJIwXZTM1AsllGGN41rrtLjxBbgcFtpCH2OL/ls0PxaUMWFrXW?=
 =?us-ascii?Q?Wo2wPUnK36o/9nsFJeWDXp2sxmrfepeVITeIm6Fv9HhZpZNlYG6MwHAnQ+5K?=
 =?us-ascii?Q?GTLvuC6FZmpOkns7DG450GviaZiAq67WR98/vHB9oGBCoMBaU3Elmzn4waic?=
 =?us-ascii?Q?89nEC/fhUzL2org7mgMNteqZCgzYHPPXQP1HzfWKPF5//atLgDngnXc33pOD?=
 =?us-ascii?Q?pfs7uMNat5jDOt57Z1E8+Ybqk1f8znpTa3BCdKkOsC3OC1PP6j1W5g8pUNfQ?=
 =?us-ascii?Q?y3159nNJRSrAbaAj4uwTZXqLS4HLsrT01rEfPJKAZu5eW4NmVfZXHEQWM5KG?=
 =?us-ascii?Q?wUoftSGdP3nfFbLz1XwxqdtaXdukpXpnhVcg9s4sU7bRwJIb3hUPxyXxgjE6?=
 =?us-ascii?Q?Po8kBSI8+J0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:43.4803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd6f17b-f3fe-4e3f-0c5e-08dd720156f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
HP Probook 445 and 465 has DP0 and DP1 swapped.

[How]
Add HP Probook 445 and 465 to DP0/DP1 swap quirk list.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3995

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Anson Tsao <anson.tsao@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7cfb6fb89fca..b2bb2f92db00 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1767,6 +1767,20 @@ static const struct dmi_system_id dmi_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
 		},
 	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 445 14 inch G11 Notebook PC"),
+		},
+	},
+	{
+		.callback = edp0_on_dp1_callback,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook 465 16 inch G11 Notebook PC"),
+		},
+	},
 	{}
 	/* TODO: refactor this from a fixed table to a dynamic option */
 };
-- 
2.34.1

