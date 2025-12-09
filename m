Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D07D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A7610E4E2;
	Tue,  9 Dec 2025 08:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pIX3CVAy";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9EC10E4E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iG1w9PiTjBibfZN8DgkOsuGz5uQttRCJwHGrkg9KF0aFR1Yo8SF8tzk5yy4InJu2YClU2ClA5Oc6INXh2X/y03bHbHm8A+mbMIL9+KEXobgSE22f1VZk0DMtV7P9e/s6PiEOjH3lEQ0IiOu8zSppCI8nnAgfk8iMU1vLs6l/9yC4xkXXwvV/N/gQ6IOCcAg2yyo6TTT02lzSMaFLvcvv6bS5sn6gNuHMu4TTz0b6ND9IU9S0PZXxC1fn7aYJKJxmpV7RfXOhJCzO0/Fo2gzrgIWpqVBHgkMwOGqwDtdHTvof9+vGIbk+RQYypeySzR5ELpCbvrDuRDxpHQWXdtRMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgdv1ixSYwQCTVY5xowqwZz16W8DppJd5WHXTDbSDFI=;
 b=AjTKw7/bNaEAORqO7kGXfqvkDpJDIfU2nq5H/n1qhvMpmgW6dCZUDEC3KkI7vMqC8cViFNRUyBeriID2IQyb8V7IDZ4npndGsEfOB/hRGQa13RX4Ohimrl5Qri/7dL9SFzyUsFEb0/gMEm34RjBklCfQluOYhBF4Br7n9Uxe3u8lDVlnYctMZbCjGSz1R3IwcZbJJ6ZMoMJiRnNpOIzA0ZkBejZn0HmnrT+f4uuCyVWpuHFttlbJFbmRlPgEzktvncnqG3ZeyXz5/28kloAusjBac4t8eztULq1hlNyoZ1Ty4r9z8hs8b0Az7wngZjfCuSjtYJUbHxI5Tb0J9SNFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgdv1ixSYwQCTVY5xowqwZz16W8DppJd5WHXTDbSDFI=;
 b=pIX3CVAyePAalv+Xeopth5T0xfQLBxkA4upVql9FDrHnLDEmBFe2FsJJEl8pN7loa1dTa2utsT/l9yENmgxuzu1sWL/Rq3jYhppu/iD84QXOa+hZ+AbxjUzzHWHB8HwTfft3mGCHPC+1TTRw2/tTf3/MOrv7GKSPKvpqZROpBaQ=
Received: from CH0PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:32::18)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:58:51 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::6a) by CH0PR07CA0013.outlook.office365.com
 (2603:10b6:610:32::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 08:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 08:58:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Dec
 2025 02:58:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 9 Dec
 2025 02:58:48 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:58:40 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 15/15] drm/amd/display: Promote DC to 3.2.363
Date: Tue, 9 Dec 2025 16:55:18 +0800
Message-ID: <20251209085702.293682-16-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chen-yu.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: e94a1672-19a2-4d8a-d11e-08de37012b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BX2UQ3jrlkF7rooI7UV9S2/he3ynHH4WFp78JDvsmlAfsXtfLgLJRy4yIbKg?=
 =?us-ascii?Q?/oZCk0XgyUz2tswNaBK2JghTjWxCzXoyzcN8GInji+yKBVEb6X1jANVSVNil?=
 =?us-ascii?Q?dqYwjzOJO7aHWpahsu++d90aDC3k4uVnxFycfwPP7eAHYD4+beDTWrWSDOmf?=
 =?us-ascii?Q?oQ3YDsLdeyK41ZJ+SeMcacABCLZe/g4G2dFQMD7s/tv97keZWQY74eeLKOLQ?=
 =?us-ascii?Q?DCg4BqNloBCXyXXCKTSr2sgkhh/INPdHBj09BbTA3PG3Ge6iea2Pwc0jv/ec?=
 =?us-ascii?Q?JolP4HUSj7fmIJ9Qtv+ttBjD4igiD8ch9zVzmne5h/nUtk9oZ1PnhenIWBfQ?=
 =?us-ascii?Q?DI72l1gX6T4TQqzMgYrWAtvm4Rk6l4SPE3AHzuJXA+AUvh/QZjBWa7wlEejF?=
 =?us-ascii?Q?02YAGXRkKwGxeX3yREINzdcb3ylk4rBnKHPZ6fRg0MqZaAbZ/ZLkCZcfbNmD?=
 =?us-ascii?Q?VcxCD0bNeqOzpcfEM3SqJdtLcCy1Bwjj+pryB5OYSzMas1c1/NkJZT6cR+aL?=
 =?us-ascii?Q?rSX67A+uukpIQ2EiHwg44YjF3RuAYWxRWE7uIHbOJ40ACwEzJS/JN9K5WqJZ?=
 =?us-ascii?Q?x7pUibiFUg1JZR61dtzIv/rNzT9HCZnW17g1LoaCupL7rNAdrn4u0I1uMg+Y?=
 =?us-ascii?Q?3ejXN27ttwoEN8e7cDX/3KIMyF1Jh2K6AGRm2PE2iI9xdxirLlwTkO1pjNNQ?=
 =?us-ascii?Q?MCFnDw7C2wI95DHkvvEifbns9Ni5M0+ysQCjH8R1OrqO5Y/e4YwdWdQ7wJI1?=
 =?us-ascii?Q?PkGCF5m92IH4qgVeHcbfMEmeGPCtAtjdsWNR92pM+ki6kbwQeaDGeZzzyIGW?=
 =?us-ascii?Q?bPfaWP9LQAQnnag83cXr9cRlZ41OsBo5Crz36dh3uExgdPkXX/zGnXKWCIks?=
 =?us-ascii?Q?WMqMz+E2SHNxuqISXNjSqgfzQYTQ1jNDRXH1U+HdVXlQmDeoaP0EpEZN70V9?=
 =?us-ascii?Q?DoQqpnyT4kO3KnjDrfu7+6r8t4dEJzS3YUg8oqi1kNVFrX1R2fOi2ysSM45Q?=
 =?us-ascii?Q?82nd7NojkbNs/pHe+yHjbCb6XxoEbpVnNb6r9s5cGk5+REagWTDl0W540WV8?=
 =?us-ascii?Q?v84YCkMKU11asGhzgo1ylJoOExS6yYvrGWPS59/p9M7EqYTWVXLaDchmtnNQ?=
 =?us-ascii?Q?H0IcFojPaexKvZ+tBIoDmhTjbBCpmVhGxpm9mA+rVDvxaT4f6x5DM+0Zjhv6?=
 =?us-ascii?Q?67pWnpqYIrUTKnnebgfqQ786Z9oV2B4Vq98s9BmVdZuzs03kEh6EqaieBPsc?=
 =?us-ascii?Q?3LXWwWtX7CQI8haNgyXa8sregwj8AmqUw1qORlQvIa8iTUM7z+i97FzvSpAv?=
 =?us-ascii?Q?42QSjREVTYen7G1DnYNPXbTeDMjkkDDlfnfaNb2nYBH6HKzphmzgogFcB/4f?=
 =?us-ascii?Q?gRyC+eGqbDwOLlInF5Gs1AFbpdPojf+zQODK9tyHRmGT56bsYaidJQB/7x9D?=
 =?us-ascii?Q?e3KqFL0Fpk9zqTG0DhV+SWkmN++sLX0lKJSEH2VglfP42VbXNB+LkSh91YRh?=
 =?us-ascii?Q?HapUhDjU20cFxy+UBymjtc6t3e35XeS4M34bBK/50jHluvJVXzVfUjRbETkm?=
 =?us-ascii?Q?wPdr9RWRbN5ZhnviAhE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:58:49.4379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94a1672-19a2-4d8a-d11e-08de37012b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the following updates:

- Replay Video Conferencing V2
- Fix scratch registers offsets for DCN35 and DCN351
- Fix DP no audio issue
- Add use_max_lsw parameter
- Fix presentation of Z8 efficiency
- Add USB-C DP Alt Mode lane limitation in DCN32
- Support DRR granularity
- Don't disable DPCD mst_en if sink connected
- Set enable_legacy_fast_update to false for DCN35/351
- Split update_planes_and_stream_v3 into parts (V2)

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 93a60fd9a08c..6d8e6c3531f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.362"
+#define DC_VER "3.2.363"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

