Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69421C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 13:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706ED10E490;
	Tue,  4 Jun 2024 13:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pTHJwmcA";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EECDF10E490
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 13:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5vD7BdsKeIoJDeYLCw2gsEEneNunQBpik8E9bAROrbKdcj3NMn9iCxJHi6+930Cd6DabzaicQsccNH9KPq9V1plgfN91KHLNsAwVHeF07MKw7ZieXSBPIlE+AONWFxlv6284ExiQC3nA4DNb6CKlIZDbdAIgTdf/4ghj2roe01StZzF3Z7V4pHEvoX+r7da8qsJzI029JmciJ7WUzNRN49ttVZ/jbTJQpbzynVwure13/QBeJIwWmY1EVISgtGkesLV4uVL3CGvgFnLB8vX3JHqCtIfc4+kl1m68Adig7EJeN4GqgEjF0FbaCiixozgWH3CQC+CkIv+SjZB3mVnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy4LzgcJGLPB7QUMFlxQHfiNTXeybBVSmtCMjoojKcw=;
 b=hu0EPwHP0WPoRDEzzPgWsBjwNFbujw4Kq2GAv4smCHUigxcR2BSaPLkxEO3xWgfp40QmOW4WLyn4ayzHC9L/Mr1DtwUgDDQbGGEvknb19h9GXayD9vgr18ttZ2jgTA5MaRUeNLJwPzamTWxJBUmmR8AOq/4pPxy8tCxjozdVRirDIgcKu0VTZbK+Ai8D6FjqgBK+3zh4Bw0E3zJIMNJcNyIUQXACKXWviOMYX7xrjuM5LEbGJUUC+T2hZootSkRGS+vZ229lsXmS1x24KaLXWOTGb/FiHCk8J42Z++3jQ8MKr8mpfrVBtuiayYmRQpdi21D+htZ5YX+auLVB4bEx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy4LzgcJGLPB7QUMFlxQHfiNTXeybBVSmtCMjoojKcw=;
 b=pTHJwmcAUk5ueIVJshsJEkoCXqBe5CNvEpbkJWSxEYAlAauvWoFEiZaG3XMopdd40DsNayDnX/1t7kdLb5A8Gjy4+lZTyhF8MTv9zlk6qpc17qN2tMEves/RraAuUG42bFePxb67sF12u4kYA8M0ZEBYhBv7XxtuCdgd2ssYrj0=
Received: from BN9PR03CA0383.namprd03.prod.outlook.com (2603:10b6:408:f7::28)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 13:50:42 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::2b) by BN9PR03CA0383.outlook.office365.com
 (2603:10b6:408:f7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 13:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 13:50:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 08:50:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: use GFP_ATOMIC for bounding box
Date: Tue, 4 Jun 2024 09:50:15 -0400
Message-ID: <20240604135015.479910-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: c800470e-d6bc-4f1a-7a4f-08dc849d532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6BSRQY3TSGy/MAfuiHEyKdnWot8nbo6zuq1SWae03dVNFOUEkHOkiNlicim?=
 =?us-ascii?Q?sOxNoLfHjciXcjoLKHEpUPsh9yDHj18GWAkPigmIbXDBpz01NY2lj+9v9K92?=
 =?us-ascii?Q?rE8fhQul8b0S2HWHjL9HX6G+/otTslYr8KqEcE679O9sdkG/qvzD3p9kdq/F?=
 =?us-ascii?Q?1W1sY+ZhPINNs4hDt22TGpoy+R13VvCg8VrQVN+fPQv4src/yEEYm8Lxdh7W?=
 =?us-ascii?Q?NvT258PWunMW+lNWP4oS1BWvn33zVuOpLxkaRO3J4b1oGN4/1UF2fxtuXBHf?=
 =?us-ascii?Q?6zJ3WWaE+R+h3DxrSk349mrjyj3ertUop/bF1Cv6V5tw9yHCOIcCwiwYd/bq?=
 =?us-ascii?Q?3d3Ftb0/wBqZo5dN7dJfon+/KxpLeMAdhhm1oF+SGdLjQyL6VrF91eMQQV5F?=
 =?us-ascii?Q?qeDaN+NxNFRma516GV669f2BeeUI5t0LaM7Nh9oMECiwW2Dwy8a9iYhGJTKz?=
 =?us-ascii?Q?FuqDxGBtQaH1OvI6bE7ViXZQ0bopDP2kSvCjDpXTWygfDnedLnpsRvFQQioy?=
 =?us-ascii?Q?p1m6tpA4FHFCY0oZTJB3fF/X8o1PftgTjW91fTDzRbxRPGIFNJKELYkOIK4W?=
 =?us-ascii?Q?8Hrfp651NOM9HIWZvsE0hQv8WqgL11TEJjyycl3dzuwhxr2AGQpcDYh45jmY?=
 =?us-ascii?Q?hWkTKCesiLg/JQw7OrY7jxiLYzqt5KRtVBw23mCOs33usWyIK41NRgEM3Gio?=
 =?us-ascii?Q?Zi7mZhJmJNomIiUqdVqP6/36mhS4QqlufYVpiWzRRFT885LpOpC5z6JHkcP9?=
 =?us-ascii?Q?roz/r0guXX0kH9YvlJDqrtZMk/RagCC0jvXCZLeNw5RbPZI3lP2xlza8igC7?=
 =?us-ascii?Q?23a98wwd7DDwiJbg+us6lFIA7g506usC2RQgtkVtVA3umDKCYgaZhwKSJPhm?=
 =?us-ascii?Q?pNevZrWADnj9sDQQgfmNv3Rt9dG5EskH1EspmFZzZI4YpAJwGnx4q4TZT8L/?=
 =?us-ascii?Q?LvJNKWYVR3I5nvhNSPk9OTyoXVlBvgcqHY7N4/X+mDEuOuJMmpGdIGNnVptJ?=
 =?us-ascii?Q?KxYIrJLx72Xoz/w4nokiD0/3obi/gHJETpvxL/ijBN97vZm6h9KMFAPU30Jv?=
 =?us-ascii?Q?m8EUhEIv+1bFYBAkLjdjlx9UZk3dJB+EY3bdbtKKkjtTnHPTkNGesWIAsmka?=
 =?us-ascii?Q?VVqHWPb7XNjOqooz3oTHSSgcmAoDD6+6vZvaFk1mpCFWWIR7FeN8diAIlV3C?=
 =?us-ascii?Q?P5mruD+0PsMvh2HWhfo9pjCbDBRzCXkQn62EyMB1HD7OUh8boDWBy7ZbFUGy?=
 =?us-ascii?Q?b8sOm5ReoBjoYfsbJwrOdei/KArbLPntAa7UnWGusynxV9xVPui6jB3GbEfX?=
 =?us-ascii?Q?zOpr54PjC5osqxdTOEs93ZJYpvKEcYb6kp38qt5fwC+rhB/ZDgjCqDf6NKd7?=
 =?us-ascii?Q?6TtPScftowjXpqB7pPbx21v2izfG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:50:41.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c800470e-d6bc-4f1a-7a4f-08dc849d532c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

This can be called in atomic context.  Should fix:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
Preemption disabled at:
ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
Workqueue: events_unbound async_run_entry_fn

Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 0f11d7c8791c..3fe0d5334145 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2009,7 +2009,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 {
 	struct dml2_configuration_options *dml2_opt;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_ATOMIC);
 	if (!dml2_opt)
 		return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 07ca6f58447d..a61cf5741275 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1583,7 +1583,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 {
 	struct dml2_configuration_options *dml2_opt;
 
-	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
+	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_ATOMIC);
 	if (!dml2_opt)
 		return;
 
-- 
2.45.1

