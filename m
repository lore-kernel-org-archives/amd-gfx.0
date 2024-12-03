Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291A4E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD00B10EB63;
	Tue,  3 Dec 2024 21:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2eK5MWzn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6325010EB63
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM8fK1X4MhGxzYd8mMrCoywBjuYb7UyQ7MMi/O2ts2krkZHqdX6FtzdBrUQj8Lq0Xgd63vt89ZOHQrUF4DiEfa+maASx7IrkD50b5R0LruUYEvwqA+g8zFHZaUTES78g1rVfKWmGRwi3gQoaTC1d22sjGaiweJevpozFuq6fayLVEoJdVFliFwbNcszQvQRwL5W4GE2Go2SPCN2kohK38UUMuPbVaFKULQD/UwC+THtyvik5VD+9q/OKR+tzpWXv0CrefTfm+eGwlCTk+U6lXBp/vPLLcgmyKhPhgPDq2uo2CHM6QOBCgBg62XAfdU6GFcN7xvnc3T1P9LAS6RL6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mUsVYM0IObc3cJr7rHbRddF3ozNM+80PP2UqqMf3NA=;
 b=DInE8GHVkiA1Og/bTBq735DDF8xaY0pmH4E+HXftywOj5xU8k4xN0gFkqyG4A6uYF2mEy8Cxpw/tjJ1r3gPxda33CeCr10O0QFiZ2kJW4AodVV6Co/5Og4IC267NMIBTjggQrPHOGQj7CulmUdH5/QDMDPiiiM9AmTANLc2wncQaJXVY66OjrKf4XWxxYa4+DjDwf5s8dyrbO+DUBcYQBqUY+DHhT72Tj4VXA/0iRK5+XApQQ/83LEuFKrX7boGpDXm9/LY+PKfTNr0yhR+PrLewh9fh2slVhbSbe2T0THrsr4iTad2UQjpu5/Bx9unMzEDwce1o/1PTZkWS92+dZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mUsVYM0IObc3cJr7rHbRddF3ozNM+80PP2UqqMf3NA=;
 b=2eK5MWznoHQ4dNep1DSC+aAO+M/MvxH3qbFyoT1KgQ0Wjs7VWiC3do5Dl5QrZX8SgIljSj17VzTkyi5p3u7apkIS/abgKqgoN/3GrROljxIjAoOEg8IVPxs5jh7CMnW9qtHQ8ue/i0p6ULY/kA4BAIOw47sqQogLVXdSLWuk+Xc=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 21:41:42 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::34) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:41 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:40 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 07/19] drm/amd/display: DML21 Update Prefetch Calculations
Date: Tue, 3 Dec 2024 16:39:45 -0500
Message-ID: <20241203214120.1161810-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 37779aa8-1ea2-488c-558c-08dd13e3466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?InGq7R90uHIK2vxPDQxlLrIOzrdOGcHvHBDgmrX7VI/gJh30gIxZZL0mxpuO?=
 =?us-ascii?Q?jOWUjHLdw6EG9oHROE6vy/zJLx7Wanm0SSgyQavmOFEKS4gDn+q/epqAZXkH?=
 =?us-ascii?Q?SePS/jWo/e0j19nnj8VxecMscbntGSnCpleTUR0k4/uUKLz7BPu0bn35MDHJ?=
 =?us-ascii?Q?lgPQ1CEfugdDCm1JQBLAJMIdU3hXms4v0wMUZrF0SyzgmtsxK5nFgXOOLGyh?=
 =?us-ascii?Q?PpERMbihnt1veIA+q7+IzaZO2hu0jdZZOYWiJkmm4osHPwxh1mmjJr03i/5w?=
 =?us-ascii?Q?IckQ9IEoLj0JMvPOnKHXYd3jNzUL9MqsiSZEYTYIUNdTGC23YKZfZYxpWLzJ?=
 =?us-ascii?Q?a+ecMs07q2sR9KK93wA9bNJ4ckPrG+w9Sq60muu+IP+heWA0igtqdR8/tanK?=
 =?us-ascii?Q?lpC5YNajeoU/SewgyN7eHpB0pOsuQxxer9sEPXS+jSIaQAufEP2CyO5P0dCL?=
 =?us-ascii?Q?AMEvLPzGTDMwDJ0ZkKhpYHEvzLwsFlP3FCKf6yMMEAHxNJzyQ2A1IQdNlBDz?=
 =?us-ascii?Q?VHk1byaoClTnUKT3b6tNrp4ow+HPWXLdLm/pHYNd3Zp4omr1cZe5Q09eXJte?=
 =?us-ascii?Q?y1yBUD3ak8KmDU2L+KGjv1RXJHiAOU+KVR6PfdyuoVNNbQJwBZhL469Fy9xZ?=
 =?us-ascii?Q?M2L/uQRLgVpl96AJGGor+0smi3IqzPZUU1jfbQAjsudZ80qHwSN+a6vpNY1c?=
 =?us-ascii?Q?vdQlWQSUIIhryKkMIn1TcoWRnbyw582qt6QFR64V9xCMlcgE0HyjHxlrV3lB?=
 =?us-ascii?Q?vHpCdLHUMSRLhGyyb7fizq4decKelXd5HKiDYGOc7AE8eYrkof7/z6vzGCbF?=
 =?us-ascii?Q?NDTrcAXJcjePciZg6zuV1Q1Fdagk0Pn4I95eHrYJWfXMTLMkke8yZ/8sF9ws?=
 =?us-ascii?Q?uxdPoN/Ro0/YquZu3j+oPUSF3k/4fm4hCZ4QEbUhOX+MRrDdOhlaw0n3+G+6?=
 =?us-ascii?Q?KrHCMNMrK5dKndFndy24CJJqhtUMUG2diNCGqBhWuT+nqgf3qrUDI0VNWk6a?=
 =?us-ascii?Q?Ve/nWxgpSMdvnExkdlGy+1JgnNicVWYboNDYE9G73Oaf91ekDk7raEntoaAO?=
 =?us-ascii?Q?rHFyfIVvskKZiuMrGbVqFarV1jxObLUuPW7mfOf1ru7KjZjy1YDHdVfDB3Js?=
 =?us-ascii?Q?hESM2agwCa83m8aPukJw/5vqw2xydn62eBxf/g5wdHS6XLvZqZ5LGS6b8R2Q?=
 =?us-ascii?Q?ZnacN3+CDrQiTgZV1gY5VRtUuTYzgESHZ0xTKf6U+OCUysBHYr8KzqFvtF9t?=
 =?us-ascii?Q?tIRI14ZaBgySDevJAIigCLUpgym4q4mZsJUupMVSfFVTgsMDOYCx7oteVFb6?=
 =?us-ascii?Q?ne82L7dRK0xZXgpHTVm6p28SxoWUOk1ydlMpNS6tM01CkNANGnKy7+k5v003?=
 =?us-ascii?Q?R9067YP8MuhnQli3+prxUuyPWd6ctFk9sC/aOnvRn/k4bLnGNOiUwrM7sOWK?=
 =?us-ascii?Q?kQLZaQ4IKS4Bc8EpVr7HjL8hZL1nYOgO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:41.5927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37779aa8-1ea2-488c-558c-08dd13e3466d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why/How]
Mismatch between mode support and mode programming occurs.
Mode support would calculate higher row vblank than mode programming.
As a result, mode programming fails and hardware isn't properly programmed.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 601320b1be81..5fb91b882453 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12,6 +12,7 @@
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
 #define DML_MAX_NUM_OF_SLICES_PER_DSC 4
 #define ALLOW_SDPIF_RATE_LIMIT_PRE_CSTATE
+#define DML_PREFETCH_OTO_BW_CAP_FIX // just cap prefetch_bw_oto to max_vratio_oto
 
 const char *dml2_core_internal_bw_type_str(enum dml2_core_internal_bw_type bw_type)
 {
@@ -5302,10 +5303,20 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 		vm_bytes = vm_bytes + p->tdlut_pte_bytes_per_frame + (p->display_cfg->gpuvm_enable ? extra_tdpe_bytes : 0);
 
 	tdlut_row_bytes = (unsigned long) math_ceil2(p->tdlut_bytes_per_frame/2.0, 1.0);
+
+#ifdef DML_PREFETCH_OTO_BW_CAP_FIX
+	s->prefetch_bw_oto = math_min2(s->prefetch_bw_oto, s->prefetch_sw_bytes/(s->min_Lsw_oto*s->LineTime));
+
+	s->Lsw_oto = math_ceil2(4.0 * s->prefetch_sw_bytes / s->prefetch_bw_oto / s->LineTime, 1.0) / 4.0;
+	s->prefetch_bw_oto = math_max3(s->prefetch_bw_oto,
+					p->vm_bytes * p->HostVMInefficiencyFactor / (31 * s->LineTime) - *p->Tno_bw,
+					(p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) / (15 * s->LineTime));
+#else
 	s->prefetch_bw_oto = math_max3(s->prefetch_bw_oto,
 					p->vm_bytes * p->HostVMInefficiencyFactor / (31 * s->LineTime) - *p->Tno_bw,
 					(p->PixelPTEBytesPerRow * p->HostVMInefficiencyFactor + p->meta_row_bytes + tdlut_row_bytes) / (15 * s->LineTime));
 	s->Lsw_oto = math_ceil2(4.0 * math_max2(s->prefetch_sw_bytes / s->prefetch_bw_oto / s->LineTime, s->min_Lsw_oto), 1.0) / 4.0;
+#endif
 
 	if (p->display_cfg->gpuvm_enable == true) {
 		s->Tvm_no_trip_oto = math_max2(
-- 
2.47.1

