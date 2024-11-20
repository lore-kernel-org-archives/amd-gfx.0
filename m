Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA29DD6C2BB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2024 00:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B7DD10E383;
	Wed, 20 Nov 2024 00:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IvaYeLa6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8863510E383
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2024 00:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNyLQwq75Q4lcNkJlvMlH12wIXTmlInLPvVTem8cE7IqynQMxLLclHGnd7K92A4ihFTgjKbN15EmrzTmLcMV4L2VcmocENZuIazof7i9AH1VijcUEUwnxQDC5x9sV7sYNPqdujVmVLPwnKqa/p4aUHfhAMtuX5svC1QhRyaFRyRjI+AIIAjbW4/g4a02MFtMeOcDqhraOtdUVBRdPTQobMSgz7fxkR/wd5iaCtswg7+s4qlb0gbNVvzyioT1r65M7sRFbgKpohMQtDEdGSlKHb2fOwoRVDwpgZGwCLk5rB8Cyczz/BdABDvCHXxOHM0aa4jXwB6q6EQFe/haB7YAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUog0GhiroIJgkojONp+UfsOyNscMiQmsOXgU/nzDXE=;
 b=g2vz+CDiViCAseGlvLRyONjv9t183hMomPSRZ4PPPWS1Fm39IluoLwnG+g4kj4Xh1wWJpAtQk5MHFumBDfvq76mz0cJju6MfaYM0LmSEhDwe1HUF0klIV7IPn39Um2Tj8PtZXHy/kkZnL9hZ5rh+TY/YWqWmRnryT/uw17XfsdgmxZOQ65KphFKahNaVNP44XoE//QMj8n3UgsD8FkttwwezVKARZr7VbjLBkyqyoVuUfXiDGAx5j5hcGzyMo8SdT0o59jTxpD3qnAgKc4avPkVirZSKLTa078dxmuYoAR9lNEESexxGWxrf+uGkT6fPs7OMkUKRYhCtlnmdbjL5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.12)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUog0GhiroIJgkojONp+UfsOyNscMiQmsOXgU/nzDXE=;
 b=IvaYeLa67L/dijx0nxLuHGB14vMTC0UqC/VatQjGYSxTXLLCd+i/wj91gzwDK/A1wLSzMe1TxZrp2t1G0aI35v1B3CieyRZsQMN/VIR3HbdsFtvWlzxk9ZaLLPV5bj0ZAkFjZrqkV1VBnGr0I4TESzgx/45DzC/8hA2CQ539oM4=
Received: from MN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:530::17)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 00:34:00 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::28) by MN0PR02CA0025.outlook.office365.com
 (2603:10b6:208:530::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 00:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 20 Nov 2024 00:33:59 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 18:33:56 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Lo-an Chen
 <lo-an.chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6/9] drm/amd/display: Correct prefetch calculation
Date: Tue, 19 Nov 2024 17:28:34 -0700
Message-ID: <20241120003044.2160289-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a863c99-f6a1-4c21-e3db-08dd08fb0663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CaHGQE7zmvyktEm//qrS/RtMSMA+WSYoLwbCnwAxGJIQHerWhVGJzU+EekAn?=
 =?us-ascii?Q?yz7hCJnzhASGYM+C4lBjNOa1KCw9ZFXdkCCXguV8j1xdxpdGTTRMNEqVU3yS?=
 =?us-ascii?Q?FNusIoEZheP5T/nQPH2kYKarCAVTpk7HVuxGd3+RH7kO6HZEBy9nYJd+jVBi?=
 =?us-ascii?Q?U9QLmbrlt0oG6q+eCHWttXFZtktfPCiQcVZemdYyYVaGnjN7rvfBgigElBwe?=
 =?us-ascii?Q?8+0hkpVYRGF8C4Q/IIuPyZApcKFJsZDdjsf+fT/A4yEfiu8m2hy7GzaGsj9v?=
 =?us-ascii?Q?PDSh6qKCsBNK0Iy6WrFpi58/aYRJTsCpH7HOuSWoI3khBq6O3ACGBHRe5NuS?=
 =?us-ascii?Q?loemeyITbTidqziJeelP6AJKqv3K4m3mzV6qoRKtKXEqy6RkLs5kLfsPlSex?=
 =?us-ascii?Q?4DWTLhkwTRQw8P5812OGC924BXj6FIWq8hRSfd581ekPopOJ/pKGIQHU9mdK?=
 =?us-ascii?Q?VWS2EtBqG5KROtYr1E17tm9W5levl9k/AClfr+pXKRsFRTzlncKd4vr6Evig?=
 =?us-ascii?Q?rBqz6tQwbjgiPY4W2MAI5U39auuQuNxheA95pLuW8K3nCF+SLjTh5+z+pCZw?=
 =?us-ascii?Q?yHteh6Ez+MUzWJ4a86CE3OAIFSHHBnB6VPxAMSUkepz/9GXehJP7efU4uuXv?=
 =?us-ascii?Q?VoilVzGMdaaBICGrDzd3qlFG3NNxjAiwGdL1f7bk8mUAKeThF2jgXzIUA35U?=
 =?us-ascii?Q?f3frsg2UhVguBEnEhbc0OKCFWoGmUi8LWwvWyzv2FasSdO3dKZeojFq/YShs?=
 =?us-ascii?Q?lDG9+xdeTZK/Ox1LgONBxHSjJ6jodunnXpQGE2FyxXZy0LNJVVoGviRa26q8?=
 =?us-ascii?Q?G2sCoCQbKO1Nm1Fe+NzDwyfXCixjecpVstRVlWq1Q1lahhLZ+DquJp6P5XyO?=
 =?us-ascii?Q?W09LqQTqFc6abbfSFUI2mxYSzGsRmAdKEP2XdVo409wj/8+nUN/Sjrt9Xuqt?=
 =?us-ascii?Q?ZXCuqfMeETgyn1vxGNUccHT1Hu9v69xQEZlkjBIM4MZOGJU+9BrTZkFnAblN?=
 =?us-ascii?Q?VTOvhhesCRvXwxMsSCeWwsVwWZMNRKhUCLPF+Fnmh4eP7wS3R5TwH/RfMYg5?=
 =?us-ascii?Q?yQPC3VlRtkDDUoJi24PvOB/at47ZdyBDKik3nFShTvxkxLi39gv7PDe8Yvt0?=
 =?us-ascii?Q?+McpgNrAuyI+QZGoDvz/yfpgnKH3DhwFOEE9h186zUGLBy4Hx4/fG+0/lQXY?=
 =?us-ascii?Q?ZDoj0MN/Yjt8/a6O4vnid9UqFAf6f9FMjiByGtQhmu0hHkk25/WtCbYnMRI6?=
 =?us-ascii?Q?mQu0XkhiVC/WzvItfe5d5YWMAo5DJAet6rFSqhPY/TaQJQ5EIlZd44wLWUKh?=
 =?us-ascii?Q?nxmBv36DjR4KD08O3LS8p+8LI6bwxU20Ny6sAqNvvXt7T98ptFau81p8aBx2?=
 =?us-ascii?Q?btssiukGsf1zPvMSuBqKiPzxVdGRjp816t+DhT/TAzZjpwX/5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 00:33:59.2720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a863c99-f6a1-4c21-e3db-08dd08fb0663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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

From: Lo-an Chen <lo-an.chen@amd.com>

[WHY]
The minimum value of the dst_y_prefetch_equ was not correct
in prefetch calculation whice causes OPTC underflow.

[HOW]
Add the min operation of dst_y_prefetch_equ in prefetch calculation.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Lo-an Chen <lo-an.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index d851c081e376..8dabb1ac0b68 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -1222,6 +1222,7 @@ static dml_bool_t CalculatePrefetchSchedule(struct display_mode_lib_scratch_st *
 	s->dst_y_prefetch_oto = s->Tvm_oto_lines + 2 * s->Tr0_oto_lines + s->Lsw_oto;
 
 	s->dst_y_prefetch_equ = p->VStartup - (*p->TSetup + dml_max(p->TWait + p->TCalc, *p->Tdmdl)) / s->LineTime - (*p->DSTYAfterScaler + (dml_float_t) *p->DSTXAfterScaler / (dml_float_t)p->myPipe->HTotal);
+	s->dst_y_prefetch_equ = dml_min(s->dst_y_prefetch_equ, 63.75); // limit to the reg limit of U6.2 for DST_Y_PREFETCH
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: HTotal = %u\n", __func__, p->myPipe->HTotal);
-- 
2.43.0

