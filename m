Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A5C27C7B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFBD10E6D2;
	Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EUZ6GUKI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4252610E6CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1v3mAdq/8qYDer7x/SJGuEAdUv51ppMHAlJslNgjGNdMcoj6J/87D7Bs4YZUIH0R37OcCS6Puhg7xlEjHMoRH+1m5hX88fgXUxmlbWrUCi0oPrFMMYX5NvvJb9dBD1Vmd5zbuonNwjepPboPvhWvKocKQFSkNh23TnH6G1T+pT40GcIIM08gVFlxd0fGjhU/+cvdOhHvBR3f60hH/eygnHtIiiXkIKZcaaZBx/eAlEYWxXKYQXYDBnhOQd/54P+g7UEBbC+FAo7Q24BOhkBKgyADjIERLIr7kGUb8fOD754HocVxF16xKIW+Exkrra2iO88YkAShlDpP1lCKSejNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdqA3RF4X8ZaYBNAxDiJBlGG4BmxiZsC0jlkLyKxlOU=;
 b=maVk4XswkkMAuFJ6oATVHT0Emzp8TJ7ci2nJswzH6nQq+n5f4BjRm3prO+K8l32uzViWUg/PB47SaOzDr9e/zzKVjXQArtE5tSIcnVB5EapuLGcdjPcCINdNQHTSEFt4M8b+xfBQJYuUfugJXalZN8exzIWFKYhMjZ4m92ObqG3PzpCTcE6LSPKm08LPDW5dTXWzuKJT98AHDKSpd9NMXqxYoBxvm03vRbtpUOFVB62bVv++/euSaMJlS+GePUk6wDf5YgpytUsSk5SZdqfCM3NIi1IQHJmr8od0+9arkPNSFBdRTxBKlh2XvPuvTu0vNkMiP8DdNkEDXEGL4BnABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdqA3RF4X8ZaYBNAxDiJBlGG4BmxiZsC0jlkLyKxlOU=;
 b=EUZ6GUKIZdHrCfdr3G2iMXADGKrcIc58Dma7xpTKsqqnCXOTCNgT1WCDZO6k0LhQK5M6oyYt5kdJHUVcG0L8xaQr1ZXh0FDD//wijQTyfXLYfW4tsUN9ndQVy55PQPYv4d5AffH0vG3bsBCUdQjvNERmn/a39CPylFrQUh2f0mM=
Received: from BN8PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:ac::40)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:25 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::5a) by BN8PR07CA0027.outlook.office365.com
 (2603:10b6:408:ac::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.19 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:25 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:23 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 07/36] drm/amd/display: fix minor coding errors where dml21
 phase 5 uses wrong variables
Date: Tue, 11 Jun 2024 12:51:10 -0400
Message-ID: <20240611165204.195093-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bc60a1-be48-4445-6736-08dc8a36def7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZJJmEO/hGiuYC31hP3VL/i0bSAge/qPbaTQB9g8EktiWoQdNKfl+Da3aMdsq?=
 =?us-ascii?Q?9Mgg9tkTFgwz0v+m5xOuvjHSbKSG6sGK5MZ1OIOVIQ84jM7GzOFZKvcnLF17?=
 =?us-ascii?Q?6vpF0W/EWdM8or1oHzSWuNOtJo2um20EEZLbjaYeFwcTxZwDhKFml5/9hpVy?=
 =?us-ascii?Q?ccG0Eh1/SYmqohVFNxGlcG/NfQJka/qRns5b4htVl/OjlnUJ/cxu2od0Shu1?=
 =?us-ascii?Q?i++GGuKUoCl7KCMFPNzf+BeBPd4mmBSHcbgR7CvIOYsm6LeLf/60yUlftMXF?=
 =?us-ascii?Q?7zHCafY/2q58wbZXvr7OF8StjS9ZR3nNsqB5w6GJyiDwoz8munnHnyglAcjq?=
 =?us-ascii?Q?Ikmtd5VBKRA2s490DJ6JxUFFzUzFcWLr+z488ybtop0ZOZrRYCawLFhfeDMW?=
 =?us-ascii?Q?0i3PW6r7AxCGZNK3MAdvLRVMPstYj36dWmwC4VxoRv6P2hmwd/ONfjsU+C0Y?=
 =?us-ascii?Q?ujf8ZcIESUHK3AJBPn3hfEGnJBqve1y5HaO1qVtkiUGu4ZcUWfSr3O/ZLWcg?=
 =?us-ascii?Q?O0LxIo1BMvFM/HKl2hDMmh4LT6hIkQ9ntisAdU7kEOgOsD4Ia/ur+8qxFrKo?=
 =?us-ascii?Q?/pYscJil3RbOIrEVEsxIhdgdNFvryZhv54XrkRaHY3hCEemLT79559GbD8Kw?=
 =?us-ascii?Q?BQtXBZjbK5dExiAZrIgtv6+kewevhPZmRnO+DSuPjDJZNO1DLNrESn45gsag?=
 =?us-ascii?Q?vlYQMFB2xnbAh3BgOxLrC0XVkLkrX008GLfSSmEi8v19tidUgb2eduyt9Qk0?=
 =?us-ascii?Q?ZHFzuQCJKxDclul0apyqCseGHGzqecRhCZH+6qfzKWoiDr2ryifl5AxAcZuP?=
 =?us-ascii?Q?B18VkmVv/FELyRR6Y3YEujSX5tm6xP7KzZdoC9a3QfRlbLoTKhqX3ywVSesN?=
 =?us-ascii?Q?ZWbkShndOV2T8tXxftT1VMPQWM9AKEsJJbhvz8syguSDs+2PDddZvtUh3DDG?=
 =?us-ascii?Q?hCXYoCll6V8E3oNgF2d+rAOp/4J8IquMHZy6RTn+I5qUIeYpLJuJsCXVGv1S?=
 =?us-ascii?Q?HtdNzKqEH/UhINfXdNtHDHR++IG2LzeQQ6JwLHC3qKUUAAPwQWVikwsdrRBU?=
 =?us-ascii?Q?CKbjVIpuOzVBVURCoj1Yns/qaroCePJ0jw8eab59VCLdBSEABbdzp1Juks9R?=
 =?us-ascii?Q?V1enHbNMGJVOnmFuLuz+S0gauI8T3+nMeIC4QQ9PdNNhsRm3eVJGw/uQGdF5?=
 =?us-ascii?Q?C/52VuMOzI2/G3cbWDZo4SNf68jqWq31JIucDzRPlej263nVBebiDlk2kt2a?=
 =?us-ascii?Q?h1NEXBajGOH+nAP5lISe5Jth16A/+YWIW2/mVu/kXfDOQwbo9r2QIVOvSyKc?=
 =?us-ascii?Q?qcHi9iIrFgVB4oSii5HXBTMNynuo1Ndpm82m/dO1FjN1KhsBQlvoZdFimRyv?=
 =?us-ascii?Q?l1zh87Yf728sHp9H1Q8KHXjkQLYRHcod8giFO9R1lP7p0lv3zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:25.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bc60a1-be48-4445-6736-08dc8a36def7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

There is a coding error which causes incorrect variables to be assigned
in DML21 phase 5.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index 1142fdade334..6f334fdc6eb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -259,7 +259,7 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 	/*
 	* Phase 5: Optimize for Stutter
 	*/
-	memset(&l->vmin_phase, 0, sizeof(struct optimization_phase_params));
+	memset(&l->stutter_phase, 0, sizeof(struct optimization_phase_params));
 	l->stutter_phase.dml = dml;
 	l->stutter_phase.display_config = &l->base_display_config_with_meta;
 	l->stutter_phase.init_function = dml2_top_optimization_init_function_stutter;
@@ -272,7 +272,7 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 
 	if (stutter_success) {
 		memcpy(&l->base_display_config_with_meta, &l->optimized_display_config_with_meta, sizeof(struct display_configuation_with_meta));
-		l->base_display_config_with_meta.stage4.success = true;
+		l->base_display_config_with_meta.stage5.success = true;
 	}
 
 	/*
-- 
2.45.1

