Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA9C02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F83F10E842;
	Tue, 14 Jan 2025 02:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oN5EqcsX";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D45D810E842
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpevTLnxCbk72dlU0KlwqYNeN+b2SXFeexUCDVgH4LEaRQZ6pOLEpVFASUowjiaFAHFypIH3H2sBDwnQceo+4riiYiiqn4ebXHKscHjSXhXPhrAuia+WMeWQHdKY0kgiKLSMeb5AuRADBS+PUhKCphfW1oRcP0worIERAk7eHnEFOito4626g/7FWdk7xf/WZ8NlnomTXdBC1Ay6x8kD5OGuov0e4oOZraLqoYfJPjoQDbMOKDZ/h0fHlfzQde/bP9kYu9u6hqwr24JFZ20IC3ULTJGQvQqYRSn7rt6MLAk2F1vUue7GR0NRg7GNW3qDkmbDlOCNSN3fPnQYZpB9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq9mAcuetUoMWbXf7G8R8shYYmNTm94IKEBMVMLIdZI=;
 b=IgzWE277ww4eV4ixTYaWSFf+tNTFEROvB44wywehmqV6yACfaS/4YK1C+n1Wzrm2/5gnV0Ft2HuBJ+W1tjnSPlabOAvYh0wkpFlrF00aKFH/LtXIXNgffWu0Pu/4bFmJ2BmxDaXMpSUm4yu5gojLknQbOMf9XGmH46iZcRXLIDa8RPzY9UQpj+YbMjClP001RoSpqOkw7jf56pPIJUqFQW9iU9zVrkurC8CizeCDzpYv4jOcfdyQdXFoxQTFkeM//8slnj9LWWmT/vOhKBlQPDkg//xqyGkbHDhYZAAUJsvdtaeiROHVSITWlvaU3N39JptTViiJTJ9sGztk8ByEKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq9mAcuetUoMWbXf7G8R8shYYmNTm94IKEBMVMLIdZI=;
 b=oN5EqcsXFkBboKXAeOTqH1/tblmEDUCRfWNklNN1VZ+z2hBtuBdhBlSWxh1nfA3uoXLDh8Yv91iMH0Wi9DHDw+aLAxtGypDNDwV/PuleOyu3l1sR/3fjxLa26kOh4yKiXjCWa+ShtAVYRLfIMhjKOOeH0KxAiJMz+FhvuZbhPQA=
Received: from BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 02:10:56 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::30) by BLAPR03CA0135.outlook.office365.com
 (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:10:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:10:28 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:10:00 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Use Nominal vBlank If Provided Instead
 Of Capping It
Date: Tue, 14 Jan 2025 10:08:54 +0800
Message-ID: <20250114020900.3804152-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0869faec-800a-4799-c111-08dd3440ae3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LaOXt+iQDtTQvit7rFdTJ5WwuvyTL3tBk56KYDtjr1ywtaxykkfjQ+UQ3M46?=
 =?us-ascii?Q?jE6EF3zoZfZS4bniZi1hR5k+V+pLi5O62EUh8+4FwDRd0Y5/gcpfD4ej8o02?=
 =?us-ascii?Q?YIeZ+kHxm9hs0fapQgu+hOxuy1qhjNf2aiTtVZQjrcfoNWegP9FZmUuvBUUR?=
 =?us-ascii?Q?9mpo/6SAZTeXsp5AXj1EFzUVsSn1xms9oGG2wam/Fmj+7AoF0efibJUf8aLd?=
 =?us-ascii?Q?xIZNw6nuqWnn4KH8z93yb2WlwOyt7pNggIrDCBxth4EEbK1zrRxtB72BZcG/?=
 =?us-ascii?Q?wpzlhqrziVdPcb7nhwTuxheQ/O3Er7YBKPbkNv/0ba859hie8rj+Qt4txh+p?=
 =?us-ascii?Q?0G7eacaxKO4zRZ7CJqHUPU1HrdbTSEDuZBZoQ+SHPbdoGnAYjEqjLGDIvELP?=
 =?us-ascii?Q?2NYropNndReTJ5Wh1wROLvukGV0+gSYRrlywAld9lSfRJ4kLOGSXXmkbo7UJ?=
 =?us-ascii?Q?+nHb/ruCd98bbGuA/ZusonmQedM2BwYqJjptXLe9aNHZKhZUHIC6E0+JV2fi?=
 =?us-ascii?Q?KdWjSe38knqazn21gx6rFdFbUsh5Y4onfV78Gl24NvKUpYN68UWBZEEce6Ej?=
 =?us-ascii?Q?dI+nyfDRfPpy4rmJ8eWP/VfUV9trwofPnElaQqK3Pla/oPQF+SGlZfA04Erd?=
 =?us-ascii?Q?6jSfDI/+BGB4xb3LQZuCdFrL0qApHbQ2RFswHc7tLmKqJ2QQ8FPczj1urZY1?=
 =?us-ascii?Q?IKUZ7KWpe0Mt1LBdRpyaxhOHMCadTJRjnCIZlGFRwNEylQjDPMfFmrsSHNfE?=
 =?us-ascii?Q?U+KUHBOTllD/5jWdXfPq9whFvLzR34LaOSh5Khf2TYH2kubfjExBR5FS0hiy?=
 =?us-ascii?Q?C/f7PW6+DJZ9dQhq13DpyaeeLCUjq0ijbAmt4TiMahP1X9QFVNzDPfmZjZAy?=
 =?us-ascii?Q?W00sqQeJxFU+FdQNdGiAciGT5VkDsm6ShFRuTCTuwcC5NsislY6Oe2VNBLCI?=
 =?us-ascii?Q?iWjTCQPWmzcRWJNoG6z+0MhSJ2J0rFRJeUR0Zp4EeZrS82CfVWwefisrgih0?=
 =?us-ascii?Q?gSrTkzlYFwPayvECyuIQvf6FD9V3y9XOo8ws+vH0l19y47xHAlpZgB4jyS0Z?=
 =?us-ascii?Q?dHymkxVjR1cemRdc5Zkx93rHoCqE+kQrLjLf/CIlF3YClf0jeJwTlP4fBTfh?=
 =?us-ascii?Q?c7lj6+gaX65N3fHXgyX/elYmmOdwXJR1Ldrm2C4AhCIQH2rp4IWfIVJIhfvs?=
 =?us-ascii?Q?w9gg/LOHNDBsf47QH/IS+9+lcmlW7l26NIGpfpAyt137MkBpfAEbJG0UB9NQ?=
 =?us-ascii?Q?J/ACW8t2UjD2N4k4OBf+Ulu34IMzyjTZbgUUsPNinDuG7i3QHpsw3/+XVuzv?=
 =?us-ascii?Q?K7FQUjE6XcanH7G3sPPEo5OblBnC9naUlxOZmAk4nEPOfzN9XyH16wLhy4Q9?=
 =?us-ascii?Q?2i0w17sLt3ScZC02P8V6AtlxlaYGP3Ao5m13LaSMFO+LZiXArIQp6yigxstb?=
 =?us-ascii?Q?LVTO1CRDKd2c1NW+dj5hAqN3Sw8m/J+Bv6FIksAhVki2Sk1dbKB80A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:10:56.1490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0869faec-800a-4799-c111-08dd3440ae3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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
vBlank used to determine the max vStartup is based on the smallest between
the vblank provided by the timing and vblank in ip_caps.
Extra vblank time is not considered if the vblank provided by the timing ends
up being higher than what's defined by the ip_caps

Use 1 less than the vblank size in case the timing is interlaced
so vstartup will always be less than vblank_nom.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index c4dbf27abaf8..b1da89a5e5e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -3709,13 +3709,12 @@ static unsigned int CalculateMaxVStartup(
 	double line_time_us = (double)timing->h_total / ((double)timing->pixel_clock_khz / 1000);
 	unsigned int vblank_actual = timing->v_total - timing->v_active;
 	unsigned int vblank_nom_default_in_line = (unsigned int)math_floor2((double)vblank_nom_default_us / line_time_us, 1.0);
-	unsigned int vblank_nom_input = (unsigned int)math_min2(timing->vblank_nom, vblank_nom_default_in_line);
-	unsigned int vblank_avail = (vblank_nom_input == 0) ? vblank_nom_default_in_line : vblank_nom_input;
+	unsigned int vblank_avail = (timing->vblank_nom == 0) ? vblank_nom_default_in_line : (unsigned int)timing->vblank_nom;
 
 	vblank_size = (unsigned int)math_min2(vblank_actual, vblank_avail);
 
 	if (timing->interlaced && !ptoi_supported)
-		max_vstartup_lines = (unsigned int)(math_floor2(vblank_size / 2.0, 1.0));
+		max_vstartup_lines = (unsigned int)(math_floor2((vblank_size - 1) / 2.0, 1.0));
 	else
 		max_vstartup_lines = vblank_size - (unsigned int)math_max2(1.0, math_ceil2(write_back_delay_us / line_time_us, 1.0));
 #ifdef __DML_VBA_DEBUG__
-- 
2.37.3

