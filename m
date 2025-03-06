Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DE2C282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 06:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2484910E8F2;
	Thu,  6 Mar 2025 06:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FGsAk5RL";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01D9E10E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 06:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWOSrkR3yV8lbElQylimQzn0HjCWb6aIA+/f+1ZGVVg/p84GLBdM814KS+769IV35RZEYvoSFXGWyRcnCNVsRfCpfxlIfGqi3su+K7N22Y8YL3wwZDkAeN81xYjJaaeywGp8TGCPvxFVJnv+a+39H/z7tcCiwtNKplHjORa51ki94OVY8BAMsy4KVQjv1hWGp8xfxiZVAz5P4rdevugs9bV0y9KyKjECekuLPidr1SBJye+A2pUDvLyJPZR/F8WDhKr3zB8hZzwghj1amo74bNUvBGg1BG0Mj4djtxX0mr7siov+zwlNveDwTG6W9QIPFMRQoH3Txf9+IXP/otkkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM1TgaBmNybugtwCsuM1UuWlGBhZJiLa1ASxSeWfi3k=;
 b=LBAKFh3Z7I56ojNXuktMDnx0k4Dhi5GzDC8OjiDUFAKfg7ebAMMo5AeJc0QOCjG6MZcMFVfT4M2DFTGZ5NZ5guufGmxwOmxYTBmxwqKLWWaOn+aMXHjmN6gidID/7KdtxLhrnrw3ietv6FObuUMxF/aLHjqvL1FfKa8rU/zTtMM0UIaJx3N85TVR0Zc58f5PEejyrVKkz7HPzjz8oL/CVfUdHzQOaA+ZXyPhqSyslLlYrEfjIt2UmpQbTsM50DP63HbN5TO9YblAJCfcqRR2Rdr51MzC86Cg6QO5RywQQbtOsr6CvYpGbBv8MY/r34CQVd/aEp+7HklyV3QN32g9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM1TgaBmNybugtwCsuM1UuWlGBhZJiLa1ASxSeWfi3k=;
 b=FGsAk5RLLnqEtXvzohweks9gavmDVrkRynriKDQcLZZmtfrzU5MfL81K67POcOKLFxpuj097pJBdoA6B/zKu//sWkP3WYJtdUdYdpxQ0JzvQ99utqtReRDvP/uu7oq4yIfO7NKVrnXjMKuQkNk6swxXmMaLMfMdJmUJv2Ui7SZ0=
Received: from DS7PR03CA0135.namprd03.prod.outlook.com (2603:10b6:5:3b4::20)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 06:11:33 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::f5) by DS7PR03CA0135.outlook.office365.com
 (2603:10b6:5:3b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 06:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 06:11:32 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 00:11:30 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: increase RAS bad page threshold
Date: Thu, 6 Mar 2025 14:11:11 +0800
Message-ID: <20250306061111.270701-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 123cd65c-58f2-4b66-887d-08dd5c75be37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ceXIT8tRqRXO8XtNnjhbq7/7tic93kajP1GSnQO3BspMxMkQ0CFGU5XM4wLl?=
 =?us-ascii?Q?wSlyup8jyUQ4EM1dINJdQm0xgn7SweZGVCC1x/k38U8U3/xp7KUUyqYa5xVa?=
 =?us-ascii?Q?s/3JPus8lw+J7j79+i4SHOab76a/XGpPNCoXVzriiniIEkn56zYOQYVPqZIe?=
 =?us-ascii?Q?M7xWY4km7DZncWhLm14cjRtdNP68z67iQW5owPv8mYdZXXqt/fwvdds7dDnT?=
 =?us-ascii?Q?j1S141A3aslk+v5+5meA2bnt/iDZ23+CmbETW5dL9VyoMMYc474VwFJfmXHS?=
 =?us-ascii?Q?OTE2TFJb8Kh5WXTJ652RLBKkMhbT9QqTK6lyuxH3v/07O9pVYWulU/pxP7BG?=
 =?us-ascii?Q?KQ5wRYlMqwZE/93oz7zrheHsOJc3n2sW6DeZDEoMRTWewzE1d93Q6WZlTPXY?=
 =?us-ascii?Q?CYqWmBEMYkmsRn//n0qnx6HTtMCB91qXyjdrHX0iqHqHo9Hld75QBA9MtV50?=
 =?us-ascii?Q?DRoerq5OAtR7na8ul1/aJrZu/qv2FYUJ8z/0RxWwTTXaDjW2xrd9Ggab2UYe?=
 =?us-ascii?Q?p7HsYp8bp1X/G3ECQsjT+lDVBhLUU/NOKik+L/3y1Q3FyI5Tqv8IZqbFhBYB?=
 =?us-ascii?Q?5DgLFPFcGxM8k445Gs6lBxxuO13u6cd+aGYaGhX67y/j8h4aH3395YMkiyFv?=
 =?us-ascii?Q?74qeaPKyI9ylTTjvfzfocNQTw185hxsIjRi/M/bdcAONc6NPU6C64jurEQKs?=
 =?us-ascii?Q?bg6DJPfCtiPkHMb5Ba/cF8PxU3/iplRHll2Jm89M6cBu8jikt4g1arWUlwx7?=
 =?us-ascii?Q?QTm4CT1aUIsATumg5/KmwCfXssdMtfUoBLZ7EZFa4OUlCFH3iy2z8FGoQdVF?=
 =?us-ascii?Q?YlULVq+nEWGqLO2YANaXifNnC0AQbLod+d0Zjjo4RmYcgi5e9VW+FlbYLnKN?=
 =?us-ascii?Q?ik+0NlZXpGJF5+9+qAKPdwC2hlju1Xx65Zt3YfT08D+HV4QJEIqNzpldSwHi?=
 =?us-ascii?Q?aMv6/3b1hReNqq4A4tt/m9tx5kcbU3R1fXLlu1FDGo9qg6ysO5G8E+574+VS?=
 =?us-ascii?Q?Xh1/tGPlvoQZgw7e/HcU8ruHMw1hBY2JwVTYK3kLcQdS0tFpFQGXvhtLbZNY?=
 =?us-ascii?Q?mk7AMM8n3Xxupmu94TD2MwuriOSbVQaUVhm9rgFdGd5Oe2JO2bwXeTHFekbl?=
 =?us-ascii?Q?tZ/r3IyTebYRSfd3KJBsmPGJVENXUnRY9QnLWVpBxeKGKVu5S8xMbBh1QfH2?=
 =?us-ascii?Q?ad4kyckWNn8KkW2/shdVEA7Em6WwwGN9yRwOq9AACUJrUEgFHjwHlLe3F5+q?=
 =?us-ascii?Q?oTCq/ohbhjF4Nzat3i1zU2cr5vpCobibmkuSUHZTEYZzvtRdNxbfTLNSc3hg?=
 =?us-ascii?Q?Q/gNZIdxKTz8EBwC6Z9RE100VCO3B57skF7M/Ohy6Ic5mI9St2VKdGAVGTpd?=
 =?us-ascii?Q?kY1MJZp9eAvoFi3pDOZ8SCRWxo2LteOYju4HwqpfdxSzNiJ61kpiPB4KfP4P?=
 =?us-ascii?Q?HbOWc+mQgeJvEPu5TgZ0j5OU5fMOxv9waS3bcAQGhcyD24EZNsXxgsUfXI7F?=
 =?us-ascii?Q?3uk30huvp5BFWgI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:11:32.6842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123cd65c-58f2-4b66-887d-08dd5c75be37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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

For default policy, driver will issue an RMA event when the number of
bad pages is greater than 8 physical rows, rather than reaches 8
physical rows, don't rely on threshold configurable parameters in
default mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index ab27cecb5519..09a6f8bc1a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -747,7 +747,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	/* Modify the header if it exceeds.
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
-	    control->ras_num_bad_pages >= ras->bad_page_cnt_threshold) {
+	    control->ras_num_bad_pages > ras->bad_page_cnt_threshold) {
 		dev_warn(adev->dev,
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
@@ -806,7 +806,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	 */
 	if (amdgpu_bad_page_threshold != 0 &&
 	    control->tbl_hdr.version == RAS_TABLE_VER_V2_1 &&
-	    control->ras_num_bad_pages < ras->bad_page_cnt_threshold)
+	    control->ras_num_bad_pages <= ras->bad_page_cnt_threshold)
 		control->tbl_rai.health_percent = ((ras->bad_page_cnt_threshold -
 						   control->ras_num_bad_pages) * 100) /
 						   ras->bad_page_cnt_threshold;
@@ -1456,7 +1456,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
 				res);
 			return -EINVAL;
 		}
-		if (ras->bad_page_cnt_threshold > control->ras_num_bad_pages) {
+		if (ras->bad_page_cnt_threshold >= control->ras_num_bad_pages) {
 			/* This means that, the threshold was increased since
 			 * the last time the system was booted, and now,
 			 * ras->bad_page_cnt_threshold - control->num_recs > 0,
-- 
2.34.1

