Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A8DF94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0248F10E286;
	Wed, 22 Apr 2026 03:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VBkyfn9Z";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8DA10E261
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJTNiKH84Xgj/5Gwee+ck7eZuInyjYRTXfqI4AIdcep5jY7DPLO+chP4psF1A3OMv5YxNFWeYGVmbveC1V8PSgFiUJ4l8hdNG7R4sfFCV24TfKpMMEDYZ/+R/DGeWamwkoYGKM9vy96GsJhGWUVihzOL0Zc+ZhI+wka3cq+elotMw0oM8sm3Pnt5MQ/+Eai8ud9G58o4s4hD7UHPxLlXDwzRDupN5t9OwCxrt3iXzPp3SqRO6NrUpuucL4Qbm8x5Y429RY51H2WfIDssFIXxkG4IIMVYi+54SIjl4OJcQXm3xTcJe0UCn+lVYY86BZ8xDvBjMxmuj5Dt1klxMYOMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLDIwwusQvXVi4q8dGEpkbOFbDD2e5hvhzlWocu0kdo=;
 b=RYm/okpQAdvd3jkmWkTD8H7iWf0rBGPjQD1VryZXH1SicSxyuXAFrQbtAxhHvxHFO1POcvG69zlS6yTZk1YdWkM2eupM6NQWdiPKjkc5F/kDED1yNW5IPrSPMoEyiaEOiAXZGAbFpeDR5rloySLOkTs55Q504IyPxYrhOAEf3cniv2cvI95U23Pu9oRaFCLATvcg33uhBJ94cn7DrTxNv53JZETkZ/BQHEkhWtGWikRXGriqiEJ1dnzWqyDMVdFTG0Vtmc10tm32zR9aqgkXs6/fdoEHGrYF19vvErZdRu12D9pzMp///C6H0366eilPQKlGhxn0I/ODp4n67WKzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLDIwwusQvXVi4q8dGEpkbOFbDD2e5hvhzlWocu0kdo=;
 b=VBkyfn9Z7mq4dJtBSW9aybrI/jpUFuFjAgvWWd/QTW9RZ23ecRj84V+6zi46ok2hNfm8kr4XID4vNJJlXXkyps4PiIXGYWcFw0M5LmnnR4nRH0HrsW8f+Ts51Zqvc0jqOVE8UHmnOw0QQgyXKlp4Iih2dldKAHcnuYBKSxhrAdk=
Received: from CY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:930::32) by
 MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 03:57:29 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::33) by CY5PR13CA0022.outlook.office365.com
 (2603:10b6:930::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.19 via Frontend Transport; Wed,
 22 Apr 2026 03:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:57:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:57:26 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 20:57:26 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:57:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Taimur Hassan
 <Syed.Hassan@amd.com>, Alex Hung <Alex.Hung@amd.com>
Subject: [PATCH 14/14] drm/amd/display: Promote DC to 3.2.380
Date: Wed, 22 Apr 2026 11:52:52 +0800
Message-ID: <20260422035611.1870316-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: d203f380-f006-432b-3e0d-08dea02344e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FO3qeJsCRsENg8XlwYmU5gHahAe9gQQquyBDg8IyBSIdl5hTmY9YTvGQ1HQLoRvwp8HuwVkclZ3OtFkEdX/b4bersFK3F8GSV7SE7JJJpTrwfi1HTbIB84xSirjDy5ZtWdMX2zw2CI7AY8ZkrowBkyD43UU9CEm9hdTBQ03u+6/HkLYm+6678F7h6Ype8Yx9UHjZB9548f6o8KNuUKIJJVki4Rhso9kSnwgUmqY2BICwLCDOkd8N6eFukLPj5oWEz9t+3EX7ZsfzKXfakAY5mTUf1QUy1VeDNRqgOgYDaZ5VVcdi7nr0BqTGcQMedaOSQG66ZBKnxPrcR9QsUajjJ36d0Pl4TzYzdmCefxknknIu/G6ef9RmUjcaBOWiMuDfhyLB2GEOUFWSAfxydlqegBWSD4Zgoca99LW/XOCZRtZNpRSieH4A+QA224BzSapoCsfIidAWS2O+iLOF6wZ8l8/yKaHktWpVlfUroKhTf7KKVnkIXl3wZd1pIw5YOPyFuFYz6QoXuWBAGht2y3oRrAn+mG20Ycn/nueD5OVQh3QQ8awWhUAH5g08KZh2SnRkLx+FbbavRROrSSy00AiSHci9k4IijzeIdWEzHBKXdZj1JiOgJ1X6KMtt/ZXWGHheiUAMN9P3OVVE9Nx/ikrBic5p8O+6oybZ8ifo/U1AqAj7/ElOOaKGN7YzwfJT+Ts98fBhoJnUlq8mH+V3wYd318xLLkcPHlbNspFIYRsjQFNFZ8siKmmQQBMW0EweCMfMGr4gYQKxBDtCGVjgXkdODg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bi7gRNoYvZuTqsl930yigrwXkF/5uif8dGtN96b2NiF4b1vVLCPa6oha2OXWc8Ogl6Tf7SJF4WkZ0ES4Geabh96I3kLkyh7wAX7FU23aXmYy2breLUUG440GKRcJ2E7jRySc3R0/00HPUB2eIlbcPd5NUjZ9bwpzXxr9KX5sMpRu4fTYkfxvWLj3WD1STCTq9IBvejpWIdLKZt2SVBSkMuPIMVSbyEZau/yDUf6XD2AvYTTXhouuNSTy6rOCNp+6zrtJBWXGYpJPWdUxH2Qj6wujB+WN268j6coiAMYSZVq4sCgxI5iJ0J3PwOmw5AIm+9y1AahEh1DHDu1AOvjfZiKlSZbCaLHXGZpJX3BV+JWxqtLf+56USy4LIRd4mhNtOTZyZWzbxUAhyrcs4HwGPAV+Sf3BfWc7yn3Bi7ry7tBolz9yFBgtgXhACpp646xP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:57:27.2684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d203f380-f006-432b-3e0d-08dea02344e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

This version brings along following update:
-Fix root clock disabled when DSC power gate disabled for DCN314
-Enable RCG on DCN42
-Enable/Disable some power gating
-Remove Mall, SubVP and MCLK from DCN42
-Unify fast update classification paths
-Fix narrowing boundaries in dml
-Update MCIF_ADDR macro to address IGT DWB regression
-Fix dual cursor shows on extend desktop
-Fix hubp tmz field define mismatch

Acked-by: Alex Hung <Alex.Hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index db5fe8238c39..ca1b23a44e0a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.379"
+#define DC_VER "3.2.380"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

