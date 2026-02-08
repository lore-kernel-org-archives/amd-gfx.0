Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BFDEF06E4
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914E510E2C6;
	Sun,  8 Feb 2026 16:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AUExF/fp";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E4AB10E128
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoqncCVNlU502Qh2y9tHTFSz3qnhEIApa0dJ3RzYt5B8FWzv+jtIwWD5PAa322zMgEtV01WTJZp5fyhatL6QRK8zveVhHAlYoFg2YoSzNHEqbrFvhR6fTLZ2mAJ/XeEDfjkK61bDzXf4BoW2AlaoDFIjRxeqUoiDHgkF7KTiUNrLzRXV7b44Shsa2GL7nmHc2wntXlA3m5uvF3hEJ7bagMh5E2c3I8Ll6gejOL18bduv5lyZmyOcjnw1R9Si1rxg+736wOma2HZfdFIyoBKDSFGqAqWo8HAZIMM5TshfHuVhgHBCgVuEL96ID/o7nVD4N9Sdui10e1Rm8dFtG0nNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y+JOOL37YqUGarudNnGRqRnz9pBI3y0w6ddOKu6fi4=;
 b=vegSie+be+z+0/U8C4YagSL4mM/e0uxNkr9dE+UqqSFrbJxs9KNmJueplEaOJ60vV2/X/cuqYmnAyHCm67+E2dNdZleXZWGpqa/U3zVY5MbXPS8SAOE0q67vyV8Qw/vL6S1Blzmj0F7kX/ZgnnLPmZbc2UAnZ3QX+fP0sDdybvRtX+2huqB1VQzzaHcHSIlgR/bcroOtjTFBQAC8y8bxhYr7IYj2GCrfRHEBXgkrUW/LHDTyutX09AZsLz84VG9AbaVMh2aW7Ul7GED51Twu6oFo/PBgpwIsvkL6vP6ThC/Pfi+d//YsLWiv1pltgNV7RkGNAdsRPGUY3NfbWmUSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y+JOOL37YqUGarudNnGRqRnz9pBI3y0w6ddOKu6fi4=;
 b=AUExF/fphN3CLmAj+zLJGx75WPQiX77UF5eBVCMdunPGFxRoL0onxquBKfVm8b509/E6zOT4e9cXdyZC/IMdBBWTpdLZoSYrpb6ztkAERB0mGXdA29Y8//GaBA36XXAgYgO/LfBRfpuEY6HchFvmh5Gt//SLeuRsZQQJ2b80xUA=
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 16:43:40 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::f0) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:37 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 04/13] drm/amdgpu: add PTL enable/query gfx control support
 for GC 9.4.4
Date: Mon, 9 Feb 2026 00:42:03 +0800
Message-ID: <3102978b893754f824b1123f845273cc7fb1dfcb.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: ed93f9df-136f-44d1-b324-08de673136b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dpo4LE5JT6W1J+t8i/X9BZgnhmIjpVi5ynguLBcPzciA3S4mckYwkImu/2Un?=
 =?us-ascii?Q?pJP6Vmj2Jv7nBOOO2iRzww6+ipRHv7av/9M5nXruuWQqh+/maeBXlbhtPKJi?=
 =?us-ascii?Q?xISzQZC4qz6dBg62hGw/emzTaKqIjwGfiatrYjlczQ41Tl1J2ZcrLB5OWIwe?=
 =?us-ascii?Q?8PiWB8jKQrCFy/dQERmp2ZOQQuv7VzAeJsYwpC6upR3sxoiQl3F+hFQiOT7/?=
 =?us-ascii?Q?ecFyQdSB+z35fBvOfYFQ2EKR9T8qBICjCm8FPN+vXY8N4I1vpQQ47+C2FR93?=
 =?us-ascii?Q?fHllWDs2iKdMIx5bCN/oQuOXHS29YlEjCEDLr7+F7OFKMlSdnpIYexkQ0zks?=
 =?us-ascii?Q?WZtPpZ42vzAFKNax80zD/jXlzdUcGLYBQBIBnRCarbjqxv4WssZ1qqeDP9z6?=
 =?us-ascii?Q?kf0xtqSZDd1uM4Ird5rYqIvJaPPToA8KhE9h8MGBYSUP2aDUa2CpoPY6a/vP?=
 =?us-ascii?Q?0dseNL27TFyjDm5DnuiozQwjudU8LqM0+qYzD4g30FuKFcsPfG2WTX/wTLop?=
 =?us-ascii?Q?7GfGj3nFC0IAC+ErWr5ia7DvDuibjAgFUuPgA1zTVfjAAjSf7wNLvdCyipDw?=
 =?us-ascii?Q?nbL1x6Tott0RMdcf2dsApKrmJJuzvHkbwFd0DHkFq3YXDxE1SF6jYpXTmSzv?=
 =?us-ascii?Q?NkpB2iMXjKixq1EfRiftTt/xy9IZs3E6ZBWIW3aAELBv/dKEUXRMDjd6V5PP?=
 =?us-ascii?Q?/wKuLh44PAROmr1ZHcBmK7YVMKF4epqIYbazd7RRVozgZzEE4u/4DmZb+oJy?=
 =?us-ascii?Q?GNw58eiJEvcrXRhvZSq9fLMLPIJCb67h1/4hxPWL3YOHQNV1v06ladUROLZc?=
 =?us-ascii?Q?9HdLCVq3Yfo9Ti4sgYeDaplwMspSBVJB89VEGkAkMGV8fHXFpj9L94bG5bNM?=
 =?us-ascii?Q?qBLkWaDaNYbZlyb1AaXiSinKWqWbLWk1tqKTmACm8TEkKT2rE+xwb5oyjWhh?=
 =?us-ascii?Q?TkUqqFQsKTLSeJL3KlduFqkN1jDwp5gVL/SazCkMIX9iL3EukxvEwBGWfIIr?=
 =?us-ascii?Q?DbuLiWaVbNgakOXFJtVDHhSSwJzMiE6DTb/LVj0wjb9Mz0AZTHW3PureofPd?=
 =?us-ascii?Q?57B0ZJd57YuoAkkh63GunRd+IK6D4Y+35DwsP+1rRKD2BXZ14BriQT029iuU?=
 =?us-ascii?Q?xWss2YFWbNzaqKHUcD1hZzjRtgLNGI3p6cyb4tmEU5U2loM+vee8POhjtqC6?=
 =?us-ascii?Q?kshbJoKqNCix3BRjfw9gQd0tz1MtwBeBkIP+OOirOpLV5RcKA8I0eyaET/JM?=
 =?us-ascii?Q?FCbezyOFIXwRYeBH0NZUVeD3qx41NidwyVNh8JC/M9vB1bY9CfDKPly8Oefw?=
 =?us-ascii?Q?1P1ME6mRiLbR6OMqOD8qwJ3HP/pGlzL3hTZ4IDdF+G+UoOV4ioa4BD7fruA+?=
 =?us-ascii?Q?F9BCvM0gFUmmd6erGj1+EhO548n6cuYepIsEgwZXsnKwEzLAQ+GzeaRyJcMz?=
 =?us-ascii?Q?p2aR/rodxfpYg4kxmgi3Rin4337Jgd71u448jRwc8Ca5DJ5Q0jac2T3xSzho?=
 =?us-ascii?Q?UNqfInXO63zStmVZYA4kRfX2FFm+eDtFB8WNuuJY/0gaapQPOOvl6JstdnAD?=
 =?us-ascii?Q?+izFCztu7jrm9P9IrjrM/w8Be1TGTHkttNyMHCYHrtj0vUIMDxChjXHDuW35?=
 =?us-ascii?Q?DfivJoD/uMo9XyFZqH5dMxkjeAGzt3yZJwNgU2u8ZFizwBPHDvs4Vd/qHhGl?=
 =?us-ascii?Q?3uz2rQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rQVDvsRfHi8NfxtdzapW8PCxD0qYyiTWbqZduRIe2Tnou1d8P9BmoelyotJ6wWfqVSrm4NU0Dow7bjwG3zAiuKaFQEd4agZutWvuGczV/QzFiALytEUIGYrJt6ZrExxJvcqE4/3I/uelibB8cKF+t6JIAd+3Mp9KGZ7lh2pCOws/L3Jex6IdGhsZEzJGCDHFpZBMqHxIE7leUd51bX0ghLf48WZnEPS4dfun96juxJaA3yVWv4zQS2IYCIzpV+QWAYmqyGQ8zHkasp+PXfYVh7i4h3L6IsCEkGB7pttdJ8GwMZR+SHjAq1no8SNi9Men4xBbghBOBSy9OjO1opwztnK3A22jmPeIfHP3U7m1Epu9U3474vWSxTadcxMYHHCX2EMeYPlW4KYKJqS6d/DXeSkkdawkdOqrNwlm59S76uSqKH+8IpI5I1GSV6X5rWMt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:40.0699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed93f9df-136f-44d1-b324-08de673136b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888
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

Introduce hardware detection, runtime state tracking and a
kgd->ptl_ctrl() callback to enable/disable/query PTL via the
PSP performance-monitor interface (commands 0xA0000000/1).
The driver now exposes PTL capability to KFD and keeps the
software state in sync with the hardware.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345..aa9307d88fde 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2370,11 +2370,43 @@ static int gfx_v9_4_3_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool enable)
+{
+	struct amdgpu_ptl *ptl = &adev->psp.ptl;
+	uint32_t ptl_state = enable ? 1 : 0;
+	uint32_t fmt1, fmt2;
+	int r;
+
+	if (!adev->psp.funcs)
+		return -EOPNOTSUPP;
+
+	if (!ptl->hw_supported) {
+		fmt1 = GFX_FTYPE_I8;
+		fmt2 = GFX_FTYPE_BF16;
+	} else {
+		fmt1 = ptl->fmt1;
+		fmt2 = ptl->fmt2;
+	}
+
+	/* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_BF16 */
+	r = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state,
+							&fmt1, &fmt2);
+	if (r)
+		return r;
+
+	ptl->hw_supported = true;
+
+	return 0;
+}
+
 static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int i, num_xcc;
 
+	if (adev->psp.ptl.hw_supported)
+		gfx_v9_4_3_perf_monitor_ptl_init(adev, false);
+
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
@@ -2549,6 +2581,8 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_block *ip_block)
 	    adev->gfx.ras->enable_watchdog_timer)
 		adev->gfx.ras->enable_watchdog_timer(adev);
 
+	gfx_v9_4_3_perf_monitor_ptl_init(adev, true);
+
 	return 0;
 }
 
-- 
2.34.1

