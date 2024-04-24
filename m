Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3556DC10F15
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1F311391A;
	Wed, 24 Apr 2024 08:39:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ScSzOs7g";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA2E11391A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVAkBamCduHwTgQofC1fiYgsSZm5Rg7h5Tsje24czeX/P5UIVgzAICEKhn/YED7EoWzMqqJecuzRqYopqBUaeriOdksVabThfDDD4WKmAbiRyo8U/hQsKQzTK5hZFmS1dvWQEkuuJdEnoidsWdA8IN5LMirpF4SlnPk7W9pp719KwWmYU3doZpznQiAQdpjJ9TRrEYDS7ZEh4VJ8EPXPwWO2ja9M48kgqh/ZbCSi7GSAA6oHCeG4gp5yVFaXSma/KfPR6hG+tz61hAARbDSQAXVXKvageQJi18wz0aLF8Z5FI7Ms7DRv9kszrMBBcNWoflwrNl8r4PmWnCYwymtQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWOsxVAzD4XImb2s0S/h87byrhb8ODjJfR0AsI/yWI0=;
 b=O+biVM9Ik4oqeuK39dS5VDVipYdgWSKo5fDthpy0f4+U83W7Kb/zpBoDAOYXyjpeYzsKxke7DCfDIFCt+7XHttAqxBhO/blJ1IbMMEgML6ZbkszPw6TKAlxX6FH3TLpd/s3KCKr1yj2tKo2r5Zydm5SSBJaOO2mo8dhDUw+ppDIGA8xHSVohhKfXGtVVpPfp7jfGigqb6nowpBkX4hZRYZ3BQsI/xOq3TWX3ggPw+p5o+yRCqZ15FAaHT4R4akL/UKo0ASh9e4GhgFFQanBV0LdizBRUYEyFQizQmL50s7pCF4rj2VDFVJvovnFfeec8Iefi4sO7MLZH67Nc9ldpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWOsxVAzD4XImb2s0S/h87byrhb8ODjJfR0AsI/yWI0=;
 b=ScSzOs7gG3yi04pmWST1As3M2n7m99KNLMs0YfnpTlmSv8uNmL4OaTlY/vS7tktt7VRkcDA2UoWjh8L20xwGo3vfiY22aU9OZ7yYpRKvGAGgdgCFJ7OV9X73u2Q3lXlpNtd/YUaSLMPwvFwWxBdhzvuaNrPxkLn13r8zHbPNNrg=
Received: from MN2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:fc::18)
 by MW6PR12MB8916.namprd12.prod.outlook.com (2603:10b6:303:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:38:58 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::9f) by MN2PR02CA0005.outlook.office365.com
 (2603:10b6:208:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:38:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:38:57 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:38:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/46] drm/amd/display: Fix overlapping copy within
 dml_core_mode_programming
Date: Wed, 24 Apr 2024 16:31:23 +0800
Message-ID: <20240424083202.2647227-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424083202.2647227-1-Wayne.Lin@amd.com>
References: <20240424083202.2647227-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MW6PR12MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 337046ac-eb59-4359-55a1-08dc6439fbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BcK/9FN6yO/ivbu44aMKkRCvNTP52jutF/L+SlSfLPX4Q62bDnt2+Syiqsh2?=
 =?us-ascii?Q?+QkiLhsjfzSmt3u6TnORddwL8vKFv23NtbhAOsKsQqtvpuycolNWtcx+QIiw?=
 =?us-ascii?Q?z4kRSjLenZGr59YzwbHGTnjE9zORt5JQOidWiqtA4nU/arFVYVaijlU9+gnV?=
 =?us-ascii?Q?K5zjmfBzAlipyE7ae7/DE4ppUewZEzaUgI+JYA6gAddUDPxWRHRXNm5BUHeP?=
 =?us-ascii?Q?cQAl572bPQQHSND807W95fxTQebceFW9F1EJjBWOGOJkhSqIO3qXwtuw1+lc?=
 =?us-ascii?Q?ULt0/hhXdcg3AyG3HSb0Qlgh5zkytu6hilZ77gqwczpOqrH3QvdzwXBOIpES?=
 =?us-ascii?Q?O0QY21+G9477PLYhaLwuq5Fa1bZhaxSOy85u021WYgAr8qAuUOjLyz8GGhbf?=
 =?us-ascii?Q?9BHNFhgX+aiIi431+LzvzDq+MF3MAasbAcRsr0VXMAWQ/UXEB4gCplnW8RY0?=
 =?us-ascii?Q?E3fXUA9kyiV5597LGY3kyLW5KMdf89FPOrca5qSBiS3qWR7JfNHr6R3EGvro?=
 =?us-ascii?Q?We92zgAD2z1zXvKJNw/1LtqvoECRBNRUm13RXM7mqOYMdiQllhdfL7NLw1Uv?=
 =?us-ascii?Q?ZXTj5Ky10BN9BxW6HIknrd31MCyosXnHwwXrBFoz5P5JRmblK2L92XXT4iYr?=
 =?us-ascii?Q?Wm3O6exjtzH5UkxRketIsr4bUR7yI29zzoJoRgRjXpwNq4UUcGAQe/SnlWRq?=
 =?us-ascii?Q?uFzFrUm7IgwWkVyXI5PXR2AdKLWK8ZVEWUO48lX7dl829YMWPL20mvBF1z3W?=
 =?us-ascii?Q?R8pyydJKb7WHDy8APFXbLzVTSxrS3qgDed8ka92+BJ/yfPGLBlTjktcs1FHw?=
 =?us-ascii?Q?DJ171spa9XRSu7/lNU5Jop30rcOPiTkjxkueJ63i2qZGNNPxa9aax8uzwhrH?=
 =?us-ascii?Q?i17IB8cLsxqdERTW4/HZEM+Elw3gOmApb1IaTtBDnFZ7Yq0YmyGh9iFUjTit?=
 =?us-ascii?Q?iKol2z/PGzwc+9datl8qzIC1xzqQynZG4RA8n3GV1Xcgf1T0SUoej4t8ZLjD?=
 =?us-ascii?Q?C0Nt0E9/st3Vd9FfEi3uZl7/cFAPYVYJPdCGXwRNhfbw0JQrht0QDpqcN1KW?=
 =?us-ascii?Q?GDpCuegrFTqDuxrkcmwJUarbCY/6ZukhOb4uvg7b6h9XOUYWfeJjcHQ1HgU8?=
 =?us-ascii?Q?SHdZALb0qEuqcPGRKB0GCLGpsEnx7cvptnIWjGJw1lU/jMsHhf19LCMCf+mD?=
 =?us-ascii?Q?X/MhoojC7cJ4+pNDR7mE+1y2o3wfSrv+wul8CgpzBXpbbkrdt40LvMDqIbnc?=
 =?us-ascii?Q?/4xOrcZgXSB1d9lVys7F3GuOXjoORgF+Gq24eaS2FwegzTofEUa0mQQOxGno?=
 =?us-ascii?Q?eo0cuYtW3PQ5pPxEivkjFv0s6g9nYA4fYweXEp2/ywdS9RQWaonYUpKStzQ4?=
 =?us-ascii?Q?hHA4RSMFWM2lZsMKjU2yEXhWNiqF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:38:57.8596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 337046ac-eb59-4359-55a1-08dc6439fbb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8916
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

From: Hersen Wu <hersenxs.wu@amd.com>

[WHY]
&mode_lib->mp.Watermark and &locals->Watermark are
the same address. memcpy may lead to unexpected behavior.

[HOW]
memmove should be used.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 6255101737b5..3e919f5c00ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -9460,8 +9460,10 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 
 		/* Copy the calculated watermarks to mp.Watermark as the getter functions are
 		 * implemented by the DML team to copy the calculated values from the mp.Watermark interface.
+		 * &mode_lib->mp.Watermark and &locals->Watermark are the same address, memcpy may lead to
+		 * unexpected behavior. memmove should be used.
 		 */
-		memcpy(&mode_lib->mp.Watermark, CalculateWatermarks_params->Watermark, sizeof(struct Watermarks));
+		memmove(&mode_lib->mp.Watermark, CalculateWatermarks_params->Watermark, sizeof(struct Watermarks));
 
 		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
-- 
2.37.3

