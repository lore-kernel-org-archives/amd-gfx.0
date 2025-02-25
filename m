Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EABAC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CF710E549;
	Tue, 25 Feb 2025 06:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALD99e3y";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBADE10E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCvYHdooFKlVBrCzfFlCPshNO/elCbwFknpucRqlzZqurk/2ifknaSmSBObY63uwGHpATwhkNU3MVarlY1BhY+Kxp6o8iBa3LU6LXcXwYIk6aFdCPUWkHcGu+58g9ROb+f7FUbmyH4rtyyaUsHoTPoVeHxQYdovbVx/CUaCmXIGjGsjMNdyh0c9zd5p/SL/mUu3ymBeKrvyhKkWMcmLmcN6niQPlqSPUJwW1d6aK96EmlJFsxUpogIF0GnThDbP0V80g0ivXv3ZZMwhVqjQ+CKqmXgh8J+i5ISPZuZsQiPF4BujmnDUKpdbb8MOI4YAiReK97PeJfTCRxkRgA+dUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCkQG4mw3tHRzmwDzdo6ukfaywZVj+URpgG5iVtSySQ=;
 b=m5RsrEtupXUpRlsy1u97UrsJukzna0Lt7deNSlYTQD0EPfaFSIoWHkj/RnPOkmjcScCaHTYFJ1U51yGSAgtPjOjsYPhbsLum9gm+ppLPrswY5ozQoz3kiOBDtcjnUnHmzLpZzYN5p/Xhm2rw98VX+dfBSVjVx/xOYg3ukEtCQVJ83nmXj2SrqiTwGQRdMutWxf7WB0JA8Qo8CXImHIevaIIebpEcPdwdgW7GeKEBIoJnVXZ1tcsa9VBh/DO0elcTuhpA1+VKFv5hX10MLI9fakJ4XD3N4SmeNyAp4301yTGHgBUd321hRwsfQvSB0E5IwrD7iwXfmvbZc5GKFMsr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCkQG4mw3tHRzmwDzdo6ukfaywZVj+URpgG5iVtSySQ=;
 b=ALD99e3yXrlHFgzQYlmSMoxsa42HTaJ12p3vziUcQ9FU5RHE2wJMwe7oDFvOb+LHxXUn+8rqc21nq5gZUBDBRdNleY+9QLakSAqvXeVlEI3vIjxHq4hc1tExxdjk/ACsZ6QNstKeDa5GcYc/oA+SoBcTIlj/p1+glycTZlLMrfY=
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:37:08 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::b2) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 06:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:05 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 07/27] drm/amd/display: Remove unused struct definition
Date: Tue, 25 Feb 2025 14:35:50 +0800
Message-ID: <20250225063610.631461-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae0a927-b760-49a4-eff3-08dd5566d3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shprTEgolltTLxVh9edtxjns1AtyNCmbGBP3tS0B5JCWnjBNh5lRIkFtq20z?=
 =?us-ascii?Q?N+Vwq+O0xoDFElhpAYgtkjt5jeoKFm/jrviDC+EsTs7FMVDaZ/c319uNwpsG?=
 =?us-ascii?Q?Dh8r+KPWUKsD9esD5YFCzwiwX9MAonQ60ON9LvWEEis7JRsbxbLKFNHhPwhO?=
 =?us-ascii?Q?2cv51NQ1a+QdDKze6Jt6987K5kFl6tvnojuDABgJjI6IaTVC+jiDaTyaRu6B?=
 =?us-ascii?Q?gFlhXY/J8YmpmNGeP7UCbEBisBmWHHOPlo/n1WToi/wJg2zC8FYWEKzjz44E?=
 =?us-ascii?Q?cOa3NiSLtdJS5dR7x28n1NvvpKUr2AYLx0D2+axNnIkK9l6+vs9wEERQhfoG?=
 =?us-ascii?Q?QiOnmPJ6OEqayWMh+VwtOQaJXOdvtvWySmVou/gkakqz+kKz6LDIJg6/bJG6?=
 =?us-ascii?Q?ADMIXXgJwZE0yZzmx79Vg5WZ3nADUR8M0Rvq9KzTdpKdB9cFFyr6Q+ElEVHN?=
 =?us-ascii?Q?uLMK7ySjIQpuA2bCkouin3i0hsm7Y9c2fQHAbYSb8g849eYcOxtD6TGezypk?=
 =?us-ascii?Q?UCVsfpyP58xSX57cWlLdgfJRqNynw4yP80B9l3vh1lZiVnaMuwpXXTkt2m5B?=
 =?us-ascii?Q?eohNDY3u8JvsM6tVooP0kd74uX0I6DMd5XxnMz6amaPLxugi8EeLt8ocs8Vc?=
 =?us-ascii?Q?GxE7bGuxo3YSwD0CWFFeILxVGs3jgHxRUjtPd8cKL2S93kvEZqINEVrPX9KW?=
 =?us-ascii?Q?HO7IvYNZDii9oGArZEPG4FYQteEwfnRKAjvaaX7uEjyR5zywBZXLoKu9bPQ3?=
 =?us-ascii?Q?sIdON9h8QOp2Be8jKLdGImd6ioz1YjiVg866uGDJKUBD7NJBwpExDxmTmBc6?=
 =?us-ascii?Q?JWcQM7Ann0td4h9SQN5qtnwgT8WqK5niJcZt4z37KZgF/fg2Y34bnyXD3Uew?=
 =?us-ascii?Q?3JCyFEgGDM3HuV+Fk4Olg23eBtw7UNgdd+3PcXnJKl3lAT2upEeGhzyfJYs/?=
 =?us-ascii?Q?B+fkEjeWshYjhL/aTQe5QU26EfVOSaa/d+9PGUgiLSF+vdGBu0fKFBqmkPHt?=
 =?us-ascii?Q?aYOB1BM4MDdP2gWzzxkEGeN44aQZKWtNL3zgbBN+NznJ098nk2BcvtLherbY?=
 =?us-ascii?Q?beEhdj1NNW/dQCpe5Q415pCpK3Qt6uaeKLVAd5cSwc0F2Mh9MiK5O0X0+y4x?=
 =?us-ascii?Q?GftWVLwmhyymzu4FzE8/Gw7eRtz7NJIQtGUMTm12s44EwL0vejqs7d97JgtV?=
 =?us-ascii?Q?5ta6BVZFtUR+T5NkptVdjrp8UNBPSYdmtnUbVI46rEpOBoTVMgEPGWxl9ThB?=
 =?us-ascii?Q?rJNf7f3sCEJ2f6mylP33K1xM9R4Eowqu3Tl9b/WwjvbTa5H57VCHnRPvyuNR?=
 =?us-ascii?Q?n9XSojBatq4fy9lTDB/FTbTTAnIwHCIM/ST9bpboM/OlUvAuoo+2WtI6wJTB?=
 =?us-ascii?Q?/Lfwu6qPx0fKEyUstVkJ4uJXAnl3qpn9ht6zPOumNSS/WVHtKazr9Sww/UJU?=
 =?us-ascii?Q?0r7L9235ygr1BNDNBLi11cS8XCoAzzq+RVjPDBtNyxdNw9ISlNCWbvNU1om+?=
 =?us-ascii?Q?9kcCKH4Gx8Hnb4Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:08.7249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae0a927-b760-49a4-eff3-08dd5566d3f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

From: George Shen <george.shen@amd.com>

[Why/How]
The struct is not and will not be used, as it is no longer relevant nor
supported.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 22c2173c687f..d988c00f5ca4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -410,14 +410,6 @@ union dwnstream_port_caps_byte3_hdmi {
 	uint8_t raw;
 };
 
-union hdmi_sink_encoded_link_bw_support {
-	struct {
-		uint8_t HDMI_SINK_ENCODED_LINK_BW_SUPPORT:3;
-		uint8_t RESERVED:5;
-	} bits;
-	uint8_t raw;
-};
-
 union hdmi_encoded_link_bw {
 	struct {
 		uint8_t FRL_MODE:1; // Bit 0
-- 
2.37.3

