Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C7ED35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1506010E5FE;
	Wed, 28 Jan 2026 02:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Msb/gL39";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B80010E602
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVwXsmRP5m+t6Pwn4WvFJAouLC4irUatIcg0uO/4Xn54hPhHszFQ90v/GZ0W4LeWEORP+R3xTZz8o9GnvzRZF6NCmlF2G0mKcEruV5bGWj2Vp03BI2bdFFlCskz4jlhSlsmLluL5jq3ApbvhiC7WNFOUph2vQa1S/klJTB2hU/wQWVw39Z+QwTjBNy2y0SpVyBJhAGin/Moll2StYLtz54fGIrNXyPRPIX/c5DsDO+qjwV163Xx9LGX5GXnvYucRE7LMt5ARmdG6grZeCm/i1E/VhuRadh5RqRvPqzhhtGx3YwMfUromcQgBr/+DGCcrRWambqMvD47F1SmlhqKZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JDq3UeQ8PnviPY/WgGe1R8sAjy6ujUe1G2/Oj8xId0=;
 b=ZmsgCII4oUJEz7x92F5M1Kdr7/twSZS+0Vw8Q+LKTz7jW0gWDo1WrxUkZV6V5o+NlEGlSnwCIgPs8Czf47lgbSv6+FDaQkti+/EdFxl/7dGikBBIMwTbR5m9570UcVBZFm0fWPqpy7vXLlIgikSE/6w+4Sh+qKxJcepoSObf0EyYIk8Ge2Sgd6fG4XqoyjD/WmGF3kOLAStj3MmorvvLcmLDQL5ijJbduWOGs9LVybGVAYcsKJpLDbCpx2XH3MZ61JKfqdrvUMYKy7Unzkh5aWXnEs36r8y634VYtf+ZnyTZzYKlLCfyc4Nd4Ix52NcgOzRWjvN0WzJAc6Vwlj71+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JDq3UeQ8PnviPY/WgGe1R8sAjy6ujUe1G2/Oj8xId0=;
 b=Msb/gL39bv7D+DH8ibiBy72AnScBC++z3PdvTTVlbc2EWIYYS8xJHL/NvhoK3tp8Q0KKNMjnlA2nyb8TWfDPX+tbN5kArgYe7pdHvdZ9UJ+xPP0vdXlEeUS8snu3YXo+gnq1JlUfNqw2cV/Xzp3zrX/zWab2ghBvpFvLXFyKlxA=
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 02:00:33 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::96) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:24 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:16 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 17/21] drm/amd/display: Init DMUB DPIA Only for APU
Date: Wed, 28 Jan 2026 09:51:42 +0800
Message-ID: <20260128015538.568712-18-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: f5091698-bc00-4963-af3c-08de5e11058f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v1/CYA/kRpfUo6jRPhpk/Bw2zG6mL5YeQ+R4vdWFHOJ1bZMij3pEVb10pKHJ?=
 =?us-ascii?Q?m+UmhnGFgI7P6mDV7Nnf89gMfGu5ahq24QLBhwEiBfmH+Vl+gabep5q8Vett?=
 =?us-ascii?Q?nBM4+x7CmI5csnHpqriPK+gwuGf0kaW0varz1iN3TqdkAF5biB4ztkbO6U6S?=
 =?us-ascii?Q?u2TehcluC++tWT6cmzPrIfz9vjbxjByCasq93YsfroCbW2Au1FI8YNZCMDu1?=
 =?us-ascii?Q?PDaC6V/Egkfnx4m7wQ33uj2rXLzTVN6tuJ5QNJ5T2ycFnuYgM9mrjntEY6EE?=
 =?us-ascii?Q?jIYUitgtUdx1o69FE/8m0cassRIRU4f6eFimW+0LJonFGaFaMGXVs0Jis3VW?=
 =?us-ascii?Q?bjKRj4KF/r61iRQx5eNnEbYmcP2USdKvd8UX0cxYk0hI/8RxamvkmtWGsKyh?=
 =?us-ascii?Q?EHgaBCfAxxIfKbo0p/s2edOgqk1Ck3U9BPznUBu9X+kNK8e9KcozNgNcJtbf?=
 =?us-ascii?Q?wJSqJqDjxnLvsFciWRqr3ERIzPO28new/N7l93IxFQg7kLfOTQqoQvHu6Adq?=
 =?us-ascii?Q?OkfKNy4m73HjKT74cciAAKvXgzZolg9tvIrVN5rOaq1HHzkkfRvousg1nQc6?=
 =?us-ascii?Q?LCbTKXmfbBYD1+1iT+E+6MjTZKcCc3aHjjd0XgKTduZPdo6Wbw8FIuxF6jhU?=
 =?us-ascii?Q?p8D/MlmTLGkCt0bRMAq9XxA6clkJCMqJqyaqNsLAkiq4uD8fqLSF8FRoFMCZ?=
 =?us-ascii?Q?YAMH0ExUd44UoEn5/uoxYtz7Mv0tlTEVgm472AtLXMLo6nrBo4bGBJKt+Ua3?=
 =?us-ascii?Q?2Yh0z8bJkln8nVZUF674cRJPuSgTczaTVVcaVJRWgQZrmidyovQA8dK7iWQZ?=
 =?us-ascii?Q?w+ztsrlc398KX7sNC8WGzeO05GYSzd7A0e/U1GmzXCfZlmsana7Zu9L+DE/I?=
 =?us-ascii?Q?vLwsUWJLnKKRQDCrrHTVaEmg4s7+gVfR3fVBRCB/3HZBlonEpLjjR6ZkVCTN?=
 =?us-ascii?Q?i2WThl3KPdX5tcBYC6sBWwhsM0o5UUxUxRC8KgPjiWSpLsl6rNuMdPqP3VC7?=
 =?us-ascii?Q?8a00bEtP1IvgX9rnNWAXjBTrdBj8D/7s4xoc2s6tfzUdN1K4oVToINVguH/k?=
 =?us-ascii?Q?9k5vahjauM27DNc1iJ9KYfdPstyzh6Nkaony4EggBEkEi+eo1eFhIQw2OlnY?=
 =?us-ascii?Q?ZBnDmedozMTuNM6LgnoXPeHfYxShyejYJIdmYWq8oexacnugtNZY1QCwb02/?=
 =?us-ascii?Q?92Q8GGherKg1A1Wkzcau+zZy9pwEeZyzjjwonN6N49NRTAgH3k6VuXf3CMvM?=
 =?us-ascii?Q?BnnLbVLRWbIan3rr/6muLEJ9mYW4kUGO85+fD1s5bDFKxeOx/xhOUF6HV9Rx?=
 =?us-ascii?Q?YqpWWQZLJFna/X/odzzTwUQDc/olkAK8Wm9dS60OGqDZNEZhr+sLJhKnchNQ?=
 =?us-ascii?Q?hyBZ8YnxT4KCfCF1h0pXbCph2rAYbJqejpgXPTxubzhYUhuXtmEnDM7CO0Fb?=
 =?us-ascii?Q?r7gShfw8xS+xxWnqZdXi4PZVHSDqea3D0YVxsBej7XsXxZtWuXFOW5gfQzON?=
 =?us-ascii?Q?K4bL/2s+DBDcbbaviw/97oYZ82WWMCGJJe+6xLfRjt4DV3JO95cfIkawXpU7?=
 =?us-ascii?Q?cspvB0YTYhn4vmDAWvNxQtZOfHWdGJVs2Wi19EQDSstwggXZsIpCxvlT2ivg?=
 =?us-ascii?Q?UL+hJA2pJ0V5y4tLg0rmEnd27XvkZAPC/wpigPHPqgx6Dyt110rd4+89A1NZ?=
 =?us-ascii?Q?5Dt9aw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:33.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5091698-bc00-4963-af3c-08de5e11058f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

[why & how]
1. There is no need to init dpia in dgpu
2. Add additional dpia flags
   a. dpia hpd dynamic control
   b. consolidated dpia link training to dp
   c. dynamic bw allocation support

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 333ff8557732..917224075ca2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1244,6 +1244,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
 	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
 	const struct firmware *dmub_fw = adev->dm.dmub_fw;
+	struct dc *dc = adev->dm.dc;
 	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
 	struct abm *abm = adev->dm.dc->res_pool->abm;
 	struct dc_context *ctx = adev->dm.dc->ctx;
@@ -1349,18 +1350,15 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	for (i = 0; i < fb_info->num_fb; ++i)
 		hw_params.fb[i] = &fb_info->fb[i];
 
-	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-	case IP_VERSION(3, 1, 3):
-	case IP_VERSION(3, 1, 4):
-	case IP_VERSION(3, 5, 0):
-	case IP_VERSION(3, 5, 1):
-	case IP_VERSION(3, 6, 0):
-	case IP_VERSION(4, 0, 1):
+	/* Enable usb4 dpia in the FW APU */
+	if (dc->caps.is_apu &&
+		dc->res_pool->usb4_dpia_count != 0 &&
+		!dc->debug.dpia_debug.bits.disable_dpia) {
 		hw_params.dpia_supported = true;
-		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
-		break;
-	default:
-		break;
+		hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
+		hw_params.dpia_hpd_int_enable_supported = false;
+		hw_params.enable_non_transparent_setconfig = dc->config.consolidated_dpia_dp_lt;
+		hw_params.disable_dpia_bw_allocation = !dc->config.usb4_bw_alloc_support;
 	}
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-- 
2.43.0

