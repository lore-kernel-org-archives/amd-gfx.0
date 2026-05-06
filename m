Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C87CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A2010ECE8;
	Wed,  6 May 2026 07:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkVf0BWJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A932110ECE8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3XRqqn0oGsPwJGO5Pfl+P944Zbl5ttPP22+t/jtxVHdRm+C5uCTF/G1hb/qtg8zR9dyi7MtnvhZybXDU9ZXh8bimzigIPxWQLnDPQl7tDDlpeNsRPDKbH/U39fpYtOZt+Pq4pY522yFcn5FB5DBX51Ny2l/A17A3SIa9jClG46WGLEeTgSjwvQiGSdvY4u2vgVG2oR7+tTO/TYYRWdTOO7IJ+aP3AT4fNHQH9ioajKbp2aTlYYahcBJ4ui32Qjn39poFD6OwO8I7+bjoW6/VIJUkC/6WIby+46GODkiCO5+DuruqIPeSvE3n/D71haDprxT6E4kTcEU815ZEd/ovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV7RJJqBTb70I8pUDnXjBtgqnYzsEjc4XKZHmxZjWcs=;
 b=Kd2/MecAinXHpOMk+KYwcHjdurreCPPwPmIjQpSDDdTnVv6NdGLZ9uRf6FN4g5fBY27f0Dfi7X3eLuNNO8GlzUqYiOKICrAAaczk/nvLpabXSzjAIqmtlEV5H6OAmqYyKe5Ci7LDAAmVSrrPofkKrr0Ou+L91smpW282Xm+ex6k4gx3eMLzb40a5lrAy/RefI4jNcfSqYA0P+SXYxvn4lYaBKuD6XNXLA+BXjknhNHwhGSuSWuvPJcH4qJpDFXxKqvUyYlFtjVtkZujysNwoDnpSlWsIDqA08RFjeV8I/L9xWGJ71X6FYBi+av5U1KCkIqe8RBKTMEboCtyAZgX50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV7RJJqBTb70I8pUDnXjBtgqnYzsEjc4XKZHmxZjWcs=;
 b=bkVf0BWJtyglcgYItzZ5eppETGCMNyGzAN6Ut9zGrROomV5K06JWIUDHJFeCgEaitUbZ1SOd48C7adKdQFg9onzKbiZTJn9JVneXL3tg3pDAlB3kibUqNAdSBkxR342snNF5tDaGiOUyBk2GoAA2H/2+U5ow03hgNFhzS2tBa/I=
Received: from MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:05:55 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::7e) by MN2PR03CA0012.outlook.office365.com
 (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.28 via Frontend Transport; Wed,
 6 May 2026 07:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 02:05:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 02:05:50 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:41 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leo Chen <leo.chen@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 17/20] drm/amd/display: Revert "Enable HUBP/OPTC/DPP power
 gating"
Date: Wed, 6 May 2026 12:31:15 +0800
Message-ID: <20260506043342.2164710-18-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8494a-05c3-49e9-1508-08deab3deae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: iiAmdlxLvo0S2exFbuAoECVOR4Kjsh6uZGEfC2CLookWq2HJcf/hH4KQHYtVbVfgPWlaLQS7MRG/+JBgs8yuAin0uac1iGRZuHrX9TCP+jGMh7w2hlS0eXlrad9KPR/m4yre6zAJdZ65a2iQ/aZuwJ7BlCMSBPmUcqVmCK156P2JEkW3i1BXkLtaQUidUEB0lmKvtQkY4lx6KCRL7Thq5gX0peaH8/GLRlPDkGjdglOSbbEXXtujMCK4abj+C8rZO0xRexAtBJmV5jJqiDO0qsNz3PQ0agHMslVTgf/l3GEOh2BLzbQUb6m/ABQy2gczajnr5olgn4FKFohcsnYJzls9zK3cKWbUO0iHYM4jIIeOIKYmXBthuZBS/iXMyh6zlgB2ggqUjxe0RtZUNEibdN7uZsC1F/bLoBxBdZNX4RSXSeoXt2Sz+9dwZ2mC2ZBUhpfSnkYJHadtV2hOwFXHLIRK6kupNXJubRUmh1/5/mOJjmiHh3+WM5OiT25wqzbfZ0haPugioMbsZc9uWyYULznxk5Msasggicz+0JkwfFkmx1nT3BHZfnUKOpibXOw0U8OqzDz5pVXWjFnsOrI5GbltdCExAKKxmezKEfMguTXROApQkqHBIZSR8XJlWp9nZ59O9DkM4+QRJ/07oY+o4o9jt4EW59c2tfshqEMHRlMJrvcbp02jNXLr4RJZQ+7v1nCa8Q3wvRcWr+K4ic6kVL/+5lD8anta/LGYPeK98gc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BwU2le+QPfPImhzyewQMOd4SXHQqIeIs4BpMzUkfoJgcgxmlN2jupCcRqWrMV40VtZ70vcJA0QPZj2o7n86zTJrGI7K7QF05sAMNikWnWE5xy9pkz5Lyhkr2K1B30rgbpvHXdrRNy8VH7RYZUSNgIbSdh7dqPry6l+nSX/NvrYNntCB3Scg6YKg5pHu8Vcf7oggTCsDqaImu7eJsshSZaNPlxrpLwVL75Z31gDIoJ9MDvi/ZQgYbk4uCS2oQWRCOQi3FpEwtMBT1q6xFgK3FUIamUQW/trDyv86hAZOfkHb0vo/7m0SJOn3f2EsybfwkwUcikhxM0gOCEoy9fvXN08uQ/dRk1KhGufZu3KnB4WFVq3FKyfymvK31FFuQj6vi8hdXRIbtqHPshGfbQMJ2VkjE7qINBE3IVA5OTKd/HtUDit/GA4ogMupqv0Eh2EGq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:55.5051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8494a-05c3-49e9-1508-08deab3deae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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

From: Leo Chen <leo.chen@amd.com>

[why & how]
Pipe power gating is causing regressions.
Revert to unblock testing and promotion
This reverts commit 265d90d95554555d18350e623ab823f3164bd462.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 01a7639da80b..52a1996a654f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -694,9 +694,9 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.clock_trace = true,
 	.disable_pplib_clock_request = false,
 	.ignore_pg = false,
-	.disable_dpp_power_gate = false,
-	.disable_hubp_power_gate = false,
-	.disable_optc_power_gate = false,
+	.disable_dpp_power_gate = true,
+	.disable_hubp_power_gate = true,
+	.disable_optc_power_gate = true,
 	.disable_dsc_power_gate = false,
 	.disable_dio_power_gate = true,
 	.disable_hpo_power_gate = true,
-- 
2.43.0

