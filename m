Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C3DD35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C128310E5FB;
	Wed, 28 Jan 2026 02:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gr4x0HQe";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662D410E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1SuCXFHXuUbjgeJfFPB419Ln77ursDM9Q3Ut6ZfjgQuPjOqf/6xWhduxAdmdfGZXi/c/n+4/XKtrOgpJyH+UuzxVa7YpAUWb89FQXFyfeXKKitve5PFACWcTpiuOqgjuCish7AnEMuj05cFsouR0V9GMdWhhzcsQ6nqG58Z1Kh23oX/2D7aQTUrEyxwSDi1YCJ8hxxU+7qU/nzwqT0cgi9aDUwKNyvvCpXRmAcHr810oD1pgVhxSyjo+/QjKQYKwF/kcJBUVeJnEUHH6YgiaRW9r/YqHrjV3dKDlytlzBQ1VSuR/lCwDcvgACyjlEf3zDGqSxfoRW2PKP6OQkDZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BKqQ3A8KLBATd96q0nVsAlrm/NXMm1cJGrrVV8ACAo=;
 b=A/PBOpK7Xa1NFeDDmU9Zr6ZvMUMS00FGI6uN0FmUYDxyXRWksCeDiY8rOCmvFaPjNlqlEWIH62YpauYi3cYan+Hm1pWLcXcPWFPeNBwaPzgI0bDdB+RECaMtcrntJd7A+ubAyZkT68UWP7jjw6a8QEfTTd6i+6ABGpkLGuYuhyZw2bi25i2sZMy1PPCIKobaGrp08+h4QeHCRouZpnhulFerkZVewA32Bls2JFoYv+qdrV2YTo6VCphRHpNg7pYgCev/s1l2ALmAbmO7sEWonjWzwWU3xAtQaa4DYzcRtyJpbH45bgc7wXX3P6SMP9M8/ux26B6nvZP+BJtL7bf82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BKqQ3A8KLBATd96q0nVsAlrm/NXMm1cJGrrVV8ACAo=;
 b=Gr4x0HQeozSfSk2PMPm6rU+vLE5Ga2ybwfkkuCdShdKpyWgwfa28BBtLuv3ZXfsF1IlUBcFl8FUGlLhf24KEBKQWJ6e/M41SU1OD+bVjF8M6mPYhO/Kxk7b7ze5f/y3YYDF/wh++W16UpFck+EptV6ikkBLqruh8lmtJzGBMqW4=
Received: from BYAPR02CA0065.namprd02.prod.outlook.com (2603:10b6:a03:54::42)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 02:00:17 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::a) by BYAPR02CA0065.outlook.office365.com
 (2603:10b6:a03:54::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 20:00:02 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:59 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 12/21] drm/amd/display: Fix a NULL pointer dereference in
 dcn20_hwseq.c
Date: Wed, 28 Jan 2026 09:51:37 +0800
Message-ID: <20260128015538.568712-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5769eb-6b08-4da8-289f-08de5e10fb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HAUWbk3maJOF2Hf03gRZKL3CHMokHZzdJ8oNcYR7kxPgEfXsOm9ThOSaCP5O?=
 =?us-ascii?Q?wKG6b2i7jLP+M87YOV/Zb6/FcrJ/VpFdkFfB1Wlb7Inqnq6TDtOiTCmnCh0C?=
 =?us-ascii?Q?z9VOjXc3ELu/1yxXjfIu/UJf2DDMOohCcgJ1jL/2T6ai2dqCB6nSscdEV3E1?=
 =?us-ascii?Q?iwxZhEXi5SmjD+majFTJILJIJLXIonKzMkIbcpCJmIDk9Jwkliixh6g9Mfxd?=
 =?us-ascii?Q?W8df5kOKvHoLTGdQGLo2rHNx9Q7poOMiUZUlZ8bkU3z/M1auWvgCuLo4F9td?=
 =?us-ascii?Q?JNYVFFxUgqRhDMceS3+5ZdHg7cGmjdGZVXJS6dQZhRdfK8Ar2dEyyY0AK09/?=
 =?us-ascii?Q?sKlD56z90alkJR6dIf15eek2DlBw2B4Fytpt9WwkUVL6Q8c3xYvgx1v2ntFr?=
 =?us-ascii?Q?pETWqfrmVA6AXhyQbdePVu1y3BNVEsfm/T7XbpGJ0f3Lu+UCYGaor+dqpHwC?=
 =?us-ascii?Q?vq3xTpegLgH3n/lEmRuyNFhWkh0D+DoYcw4oDCIvHwKgep/yDEzf0O1sG94U?=
 =?us-ascii?Q?TBCpppELAAzcptaFEoNN9QC/CxHMHVWgyiD/DnIs3iOmxB/aJMIDHWDBYj6H?=
 =?us-ascii?Q?nEb2n7/NVr3yPsTn1KWscBpAJ+KD3Wa/aObNxfdTjMOiUk/bw3obkg6/fdHQ?=
 =?us-ascii?Q?vciPXTBVwTvN94PK7tJlsddOPyPOAnBfXYK+fLrqgojYR43ynyQB5MWPk+d0?=
 =?us-ascii?Q?VrZz7LvxgXizRocal2bKWSGazL9BAUrUsQYczZUxnX+70qxVVOrlGC50WqRz?=
 =?us-ascii?Q?FtDs+Vbd712vg0tn+Ob/vkqiT/7i4cyhqG3DUb+WNq/zxR1/bL/yMfPb+YB4?=
 =?us-ascii?Q?IkqNkl2gN+J6NPeYUNB5xRVxkrfcrak0ZeLWChbr3awfJuYCSVE3R2SCCBhL?=
 =?us-ascii?Q?GsP29ca7oUUpi4Ye8S1Xq6Hwr7SD0KRRxiiTKryKPFz35oJv5jGRHunNlPOn?=
 =?us-ascii?Q?Crng8hm2vwvmV8P7sfDyoJ1XNFzV+5kXoDfoBkzZ4xd81/0h3YgkfG/Rx05w?=
 =?us-ascii?Q?epb6VGKHT2QHXIkfjIZW0dep0+tI3crl+RNiThPNM0z5Tp9ZDdk8wxsW4aBf?=
 =?us-ascii?Q?ICNrhQhbn0Qj46P1yvtpBp9I9JG3UIbnPoxp0hZ61Ze2pZYLPja4rwJQnOVe?=
 =?us-ascii?Q?yb2Lw7MNT2mXsd7RN6Cwqwzn4iE7UNfyljao3fAxSVC5FwP/i5wcuBqlYb48?=
 =?us-ascii?Q?Pif4ik8X4OyMlIITjiShalKXY036jmDcJAnsX7V7wMH9bosvX+HSBCArKUFm?=
 =?us-ascii?Q?KcH9ILyPB3/0YGh3sI/DGA0WYC62LmdPRFMTVJ3SR993lYvtoAkUokawXGaV?=
 =?us-ascii?Q?Nziz5PnDaLPDhfFyz9tuuhGNyQO3oQbzFZItb3AN6Wd03pJXakiu19/0BFRY?=
 =?us-ascii?Q?Ea6ECBgz2ivhWvrZDhn/6gm/Vh/Z0BrCoi1aQb1P9I50LOnRDfl47J3g7Mu/?=
 =?us-ascii?Q?W/R4wjXjm1XuofHy9uTAl4mVoXcqT85Kxz5o5Caq+nfuWdyevsx0iSuFkqRv?=
 =?us-ascii?Q?M+dFWGGwsmzEnfxeFsHt+HjdbcjNXdPwltwr1hK+HB+pBGyZsWOJ/vmC09La?=
 =?us-ascii?Q?20Yt2UdoaklODTkN7XzVZwj/UMibvaSGNZoC1+1m8akhsG3PJZC2Y7vrcELl?=
 =?us-ascii?Q?kF4QOpOgsHmA9WDwz2ADiYKob7a2r+TiWYbYLIBAijTMATkGSzuaFA/klwkD?=
 =?us-ascii?Q?3BZ0fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:16.6325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5769eb-6b08-4da8-289f-08de5e10fb9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
hws->funcs.dccg_init is accessed without checking if it is NULL, which
may lead to a NULL pointer dereference.

[how]
Add a NULL check before calling dccg_init.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 87a1dc27def4..307e8f8060e6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3140,7 +3140,8 @@ void dcn20_fpga_init_hw(struct dc *dc)
 
 	dcn10_hubbub_global_timer_enable(dc->res_pool->hubbub, true, 2);
 
-	hws->funcs.dccg_init(hws);
+	if (hws->funcs.dccg_init)
+		hws->funcs.dccg_init(hws);
 
 	if (dc->res_pool->dccg && dc->res_pool->dccg->funcs && dc->res_pool->dccg->funcs->refclk_setup)
 		dc->res_pool->dccg->funcs->refclk_setup(dc->res_pool->dccg);
-- 
2.43.0

