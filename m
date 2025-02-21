Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F62C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA7110EAC1;
	Fri, 21 Feb 2025 15:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TbQS1fdU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418E610EABF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXB7R18qnzahQg00jQHOcMq9Lm06yoIOWcK3Mk+eROVed9hlrw+NOBwotcto1hnmIkR2YYekPFxMpd3BQHjH1v3KmpRgghVHovPx1POCz9Yte6UuaP7TEprE+Z2B5lLymZcJ92QbF5ouJGRYUk2AzY1+HU8OqqEk3Ef6R+qg1I2BMadFd8NcbGW8qI1apSYV/dzgiipeCYSmfmEZBjMlycsG0Kvy4TNpDtivDuHyuS3KGYwfL33xKDyc3TWD5qKi1I9HRNahfKzXMJRkyYDHO8HwInAuG46V2jqiyfOG31JQSAR0UVDzqz2u/MFIMAj97ccSsicPOydlF7h3ZXYi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=CaBBEpJMDA4AHO7LMsIoPnSydW+SJY4/XM8ps7zIbsljPSwFAyMrpANNkFSn2TaZHIfvNpodHehMqDZSjDW0xH3N839VOk0mirVn1ftK6FUTbojPDkMD7e4UCCWNUymfpf+QiRGJHkGa9jUmIPXiQGh05F+8I1i8rAvjBw01s8nAVF4m7PvxsH2FX1/HgD6PhN1uHOPQoM4/dIAxiynLY7mLLRwva8B/LUvcynfyV5p1SO5oUGF56rhF4u8KknwnHwnV+sAIAkAydNVTDvtPSoSvHsEo4rvmZ6+1/kDPyxPsJI2KRuxSn/cDBnfhK4dmNE/nk5vLnVmlPsZeRUy9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zkva3OIzTY6VaYUVsGElxy7oQ5Lu+lbw5SIPfLbhE0=;
 b=TbQS1fdUb+CK/TbubFIlAK+jMibfKKHKHPGz684hAjHubZWqIn0cigMubeTOQplLSMIQKGJfPlGbI2nv/a0htA3/LyF26lQpNAN60bUpC9a127OUv8nvpyTUxMztCMv1SD+LnZ1Jt3PEojAr67DvjIFLwzPgz1bqRdr2pYNbZRo=
Received: from BL1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:256::29)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:57:48 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::98) by BL1PR13CA0024.outlook.office365.com
 (2603:10b6:208:256::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:44 -0600
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
Date: Fri, 21 Feb 2025 10:56:58 -0500
Message-ID: <20250221155721.1727682-2-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b65d5d-ef7b-453d-39f1-08dd52907d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b5Iim1eK0WS6mw2IS09Yv15PN9NP0Z4IjYr2aNbx6HfoUrZQ7Ps+GPyTUT0x?=
 =?us-ascii?Q?Rty/5FYgGjVsLmGTxTYR0ShGROSF20ary7b5tZ1wWpOcdkCGQsboC2i+n7Vg?=
 =?us-ascii?Q?zVXyhWHKYvjMfpW8ueKbClpxvgaL8KwhKs9t43akbhqGXp3SBrC0yRiY2M7S?=
 =?us-ascii?Q?/upSVXyVDH6vcLtt2U93ZtiT95p0YchGxYlcJ7fFkFG/TXWA2OFYe5Y9gXK8?=
 =?us-ascii?Q?R3nFqGG3LlaMCyzho+Ob1zYlq3axz8ZIhZdLj9ppq/0sdExfWZ/blC/JrIgu?=
 =?us-ascii?Q?+74QhSqKosEQKQgdKr+YzPUxlVqDKZ7r8zO0F7MAOC0ikTGLV4WTtxMtxcRl?=
 =?us-ascii?Q?OnXBhSEP85fLped36pP+AmaLYboL668/A7MzxVgR4Ggz6ffEIIjunAZQuQ6x?=
 =?us-ascii?Q?oMdn67B3Ub8RKOxwCLqS51DhzovafdYaCCiAdgFBchqJ2KzXi+Irahdvfcz0?=
 =?us-ascii?Q?Qtv8LPz9KSc2GOADMpKlo4mnkHWJUSR5+qdrdk1Wwbt/3CgQeIPX5f1AwoLx?=
 =?us-ascii?Q?Oq6UBelWD0oi/0Evp+wKsDlOfIEpgaIX33im8Ss+iMivx8NC8LMOMGWewsac?=
 =?us-ascii?Q?jfWwYyccMwq5RkrD6xOBC45lrVoXDGpKPaSFU5PIe9KCB+Lkg57fHJ1FHDaE?=
 =?us-ascii?Q?De/akPWxM5i0NsfAwRC1IaztBWUMYS9z/fgWzHXpbL6rkVzxfiP4VTEPuNbE?=
 =?us-ascii?Q?7OBsNsJ/FsMkADw2oqjGbKyAJ/6BlfhAA4kdxiw3vIjefw4zpEl/dnBHk9Ut?=
 =?us-ascii?Q?gkK2TZBtPNyt2qLz0qOtxDebee58mDp2RDhX0q0jGd8pLyik6Eztip+7j/HP?=
 =?us-ascii?Q?0tDrGvGmY65k2wu+TFylij+Uxwx3CCcHA+0OnQjv6mMtCyRbVYgnjBefHnkR?=
 =?us-ascii?Q?g5AV+Nrc5l1k/HfYzcl4z7m4VHTGEjTFLP42URp1Avt2BpkMk69fyFyeBv7F?=
 =?us-ascii?Q?u0EC6xsoZmbS2doIqVbCZdcYfoEKkA0lDnXJwscf4l762K+xtIxXhGUTlM56?=
 =?us-ascii?Q?ep6JQYYN7ug9iuDkwsWpIjYvxeN5ztjaNZRK7LAP5Qt8szsSAXNJphSQpV75?=
 =?us-ascii?Q?fKsfpBe1TqNBqAkZVP8Gf+zGtMQ/EmBsQt/CRRvsAqCtC2hcD+OYZh8XPAsy?=
 =?us-ascii?Q?ct+k2sJtP0wwHpFi9ZZqIyY52z8ghM+cgm0XelSh/ulSUAn9Mfkx+tCeoe5l?=
 =?us-ascii?Q?dWvJqhQuVoO/pYt5QGG3+DN+jsK4F6RlLzauP7h3OVpQttj67ShD58Hycr1V?=
 =?us-ascii?Q?0T9WdEpwr49ObFRdbFtusNCY+sXVn6NsqRnlmA0rybht79kRy5f/LLkNbix3?=
 =?us-ascii?Q?DZbxZGR0N8P+7i21YxeQFaggOXMOTrWibJV4h0rOK/5ex+ueTXmHplrcCD51?=
 =?us-ascii?Q?70J8h/MVRkaaloBqjjSf0KFg/O6cYPM/T9u20r6zL0NCuKhrmGFgddK8K6Ht?=
 =?us-ascii?Q?TDYkBVKLlX5jiWzs2FjtAFAYu3DO7qVttCUkVH+yMMNDhLu67KppOWFuAeM2?=
 =?us-ascii?Q?1LLpSqSkIwX5tOg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:48.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b65d5d-ef7b-453d-39f1-08dd52907d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

