Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B1BC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700E610EAA3;
	Fri, 21 Feb 2025 15:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1nsw+OZS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E94D10EAA6
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaLZhR5z8qCXinNfLKBLluMJC2NryeShGKM+FlopGv/UGhtWuIov6XS4oubx0uAzMGaJ9G2SVoxxXhrG2HJE7TVPyk3GjCs1QvM3YWgoe3Cq+1fO/dSdnbdbrzxcCJILbQGasK7WznDxAJ+XGcDihM0SjZiQglFJMIWBrog9SZjQyqvRX3NOu0iHLg+AmM7xrFUu2hLeRv4iuGXLZeqsFzvpM2SFaMmVIh4e0Cl9sWtHtKleVfLNUklwot8ROz8SIXkgTc8igrLYOVWQO7eFYOPbuOffQVRWI6uYJgKY7Sb6oWQ/PYFFG9LZgNCu0cr6wHb64y14FWG6X35Mn9p34w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=Ar72jZt//Q+IJaF41MyvcwEmnNsXCmX7qOGE7BzMb6APZQiCSLrhPcy6xkdhsRn021jthyyxx4iYeGkp+3YxmOUd3Zrrw41rDo7Grk31GyNnf/pbh61+kBzmPSXmK2bZs+AfI6/7DFRFvOmpMMXu/BG85EmKhK+ZJLV1DcVCqvzJ6ABGAPWv6JVQau2HNNAE2QAyIIm+0TfnPzwwGtv6RE9pOMVlki69ckpKi2ogyf4ja/0bymJvNMGpnStv0+ZJhp7u0h94PZmlaLN598jiRaSomtUfntoNrvwb1Ngdip0YMcmheQk4QaNRVZdsRUuB3OlJjLDqUrki+vc3papLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=1nsw+OZSEdzLyjUJmJ8Div2CMGdhXGGfyDAv8HXw3AowAdJLm0d6SS/JZufe6nXBoPN3FQu0KEyuRxId+sWpvVoucWfRvFDRYMBDao9xQSAes0f8LdLYP+U/pvirupa3zH7MgY22oDJ18PbsGQiULJwjJaRRDffxjwJ8M6BKU6M=
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:43:35 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c5) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:35 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:32 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Revert "Disable PSR-SU on some OLED
 panel"
Date: Fri, 21 Feb 2025 10:42:49 -0500
Message-ID: <20250221154312.1720736-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: bea21d3d-8720-4667-920f-08dd528e80ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8t4z9WqkkgjN6uNSiMbFIv0ivtnN034hEfjibciKV03aXaKs9YTTk0NvQhq7?=
 =?us-ascii?Q?7U4YI7qxx5gUNZbebUp++10DbShVlBb0oLuSOPWG/sQD8MXwkvwJ80RBTPik?=
 =?us-ascii?Q?Zo59Xtg7ipqngndxdjKhvCVlqnWLsr8oKG7GdoYQ63eJ5HHfSb2yVBfrAbdD?=
 =?us-ascii?Q?skO2lOrQA4oGwV2y59x2Vbg09UrbWQ+PC91wW7i9CtDsjTWnkXDziex4Ef4y?=
 =?us-ascii?Q?S264HKQqU8kKt3jH38chEJth8pkm0ZmRazR/JqS7wDmj+ln9/tsVTOkEJYFK?=
 =?us-ascii?Q?F/WmBef1JrYuWteM9oB0R03t5wOSsnHY/yi1s0J9URZ72ENha2apP+SYXsCY?=
 =?us-ascii?Q?icVrG/Zo/B/HU/QpLlOZYkyW68iCWsVn8EXWMjlT2h4K002ARryunlkjKT6/?=
 =?us-ascii?Q?NoeBmUkjI4aRIs4RwaEbbAHbUYN1aTf8aLdw6wohiRavwzSd4ZSGR7P9WTSx?=
 =?us-ascii?Q?6cg61r3gkN4xxa+W8hmQHGM+30oJ53l8Rmgi95nDYD0/O6ssquOdDlNPgQ3o?=
 =?us-ascii?Q?3bUkX/3WxJh//NQWUc0IpWbR7ej4nsIUQJyD/n1qwlOg6zGpWgFw7J5mYZYe?=
 =?us-ascii?Q?4yQpLwWE7D+PimizLTDfwl47A6SGkImB1vxUtdquyePzM0AwHCuR93Q+FE8F?=
 =?us-ascii?Q?T2FhN0tNneGHjNUsEMlLqRuAt1NIyZY/e/yxMgLjW3jiOa/8uAh+K+U6fJKo?=
 =?us-ascii?Q?0xfQLidx17xZmhC+MyPdyqcO60Lpg8/Si7vA0Pot6GrI6qP5O2FOFhML3NS6?=
 =?us-ascii?Q?KYBfRvAE6jkXsYg8wRPYtVmnmt1ixCDW80O0+gqBao/tKaTBAFrL6f+yti6q?=
 =?us-ascii?Q?eO+5NMekwyNzYyl8MQuCEAtZuUfgzLLnF+fNcyQ0vJPVDgRHoqypYpuCLJkK?=
 =?us-ascii?Q?IebAqHNm2lgk09A++iP6xv3dKFzoEmsLYa4YbTGlGatTbWzBx17q3hBN9/BF?=
 =?us-ascii?Q?rPzlDcu4rOmDRui261CneXoWfW47WMFSEr2gT1eJeucYwE4qlUJQ3kVZYESr?=
 =?us-ascii?Q?lm5jSAYPi7wqr7KLl0h5hV/CAJGi91p0UqELlCiM+v90hfit9GPDxVbAbZpJ?=
 =?us-ascii?Q?XCdnTXd2V+QyD6bOjPOCJ9QUIE3Lqm5E99KggKj/Y14TO4KvSmg16Kb1IX/7?=
 =?us-ascii?Q?XS1pgfbHO2EA3ZtcQTbfrVlLT6TaLfUs+izRs6pZ8haZmLeuPoDHLV2RmCPQ?=
 =?us-ascii?Q?T2eZ1Uuowr+i4HpJDlk9lv80F52vHSvbPO5/MmyzqlU5RIwY8Cn94AKaTtEr?=
 =?us-ascii?Q?qzEmNHrIUDRcc4o0KlECrG/ilaC4FqKx2EMg3rdUMhFzE0WguhiSkkqDN32/?=
 =?us-ascii?Q?5W6XP4oIYVgMCr0+We5iV59jlwT1wxsD9FckwP7yPKRuIkuKy+HNMKxE1FqE?=
 =?us-ascii?Q?g5oXa44/b8v7hhfO13oc8EXH2uZVHw9pwIHi7NPBgPlHYKArtI//p1tkXucR?=
 =?us-ascii?Q?6OM7IM1vIFhOQBMsTqG2xmRe7d9eQ8lnYe0V0/aFeq/b2pzQtujTn7+M5ND3?=
 =?us-ascii?Q?Bq8JJzBQzIW5VrA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:35.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea21d3d-8720-4667-920f-08dd528e80ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423
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

From: Tom Chung <chiahsuan.chung@amd.com>

This reverts commit 9b908d788090911d339a217c015e0022e8020b75.

We planning to disable the PSR-SU and fallback to PSR1 for
all eDP panels not only for specific eDP panel temporarily.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 104f03868266..45858bf1523d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -30,23 +30,6 @@
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 
-static bool is_specific_oled_panel(struct dc_link *link)
-{
-	if (!link->dpcd_sink_ext_caps.bits.oled)
-		return false;
-
-	/* Disable PSR-SU for some OLED panels to avoid glitches */
-	if (link->dpcd_caps.sink_dev_id == 0xBA4159) {
-		uint8_t sink_dev_id_str1[] = {'4', '0', 'C', 'U', '1'};
-
-		if (!memcmp(link->dpcd_caps.sink_dev_id_str, sink_dev_id_str1,
-		    sizeof(sink_dev_id_str1)))
-			return true;
-	}
-
-	return false;
-}
-
 static bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -57,9 +40,6 @@ static bool link_supports_psrsu(struct dc_link *link)
 	if (dc->ctx->dce_version < DCN_VERSION_3_1)
 		return false;
 
-	if (is_specific_oled_panel(link))
-		return false;
-
 	if (!is_psr_su_specific_panel(link))
 		return false;
 
-- 
2.34.1

