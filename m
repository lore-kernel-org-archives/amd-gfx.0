Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143ACD58B0E
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Mar 2026 06:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977E910E471;
	Sun, 15 Mar 2026 06:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vz5fljk0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 243C710E471
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 06:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTUM1KYmp+utc4TeLZk4WqoCV3F1bCr5rv3bXiZjUIpmfYCYGskDov4q9CtZi3hi0NlanrMxP/jKTahiXJA4YMqb6IKPQBikLTuMj3baStfbjzIwQbPDJtuZlAQ2YFh1nVhZahdFg6L2/6w+uCGKhvzvHiUMJwvUW7goo7kSdQczKFRYIut8KrdHAGLhXYVGzdJCGxb+TpHwttef55AOFE9aDuJPhVaDjV23iZrhofhLUy7c+DjsgRxC4D02nGOLJbx7thvcZl+6i0Jq2lJv5Rxf7gC9t2ufZYp0906H6IbOnjBYDdtCuCTL9XjcyXTauyo03xybPG/NWbTZIGI4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg45a+dDqPagyO7vsE7XJFTzb6hh33qviQUrDg6jVVQ=;
 b=icP7MnjlbeSNo+bobsztSHTEhLror9YC+eBgkwQp+g6cFFGgfyjfN53/jXIuke76mnyxYhIJOhGwcmX46GOKN+o/902+8QW2fwFywLoP3qqsXZjoVSBHa9x2g0lM8KhuXhshr8q2JurjBeIgU17RUGG9EqYfvQ89Cq2JQJawsmBVeVURR0lseDz2t9wOIZfTybHKatv/lSNoo4bLiGuC+724+MIs8fAgoyI7Zeaegl2v7qKjJojoLsvAAHp22zoaCdPZ/9JDGYNnnRK3Scz0YoSWIocz5uym+xlb1cijoISOwLT58B1s06XKqwipy05yUIAUkDP/MEPZlOSffCxkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg45a+dDqPagyO7vsE7XJFTzb6hh33qviQUrDg6jVVQ=;
 b=vz5fljk0pmDGZvX+Zi4K3fSxIYUZMm2T6w8X9DIXBmevOYLfnGwvXQmWixNSLVitb1TKkXNEL43JtBoD957lUzdofrf1fxHIPDe5IktQIauQ5pj89EmNvuhdWhslPUdpbFaA6w8wMo6MvvGFb4sVYFug3aYYTD028v2VXnyuiD0=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sun, 15 Mar
 2026 06:26:10 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::16) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Sun,
 15 Mar 2026 06:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Sun, 15 Mar 2026 06:26:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 15 Mar 2026 01:26:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Tao Zhou <tao.zhou1@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/ras: Fix NULL deref in
 ras_core_get_utc_second_timestamp()
Date: Sun, 15 Mar 2026 11:55:59 +0530
Message-ID: <20260315062559.1931470-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ef82c3-2023-41ba-9ebf-08de825bbfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qoYbB4gtHiaJej/ZfHUMJ5FYl25HPaTgtSsWSlJe3qA17HduGniUBVMF4PkwnJHxALujEPLuPqjkyuUCVpbV/ddmXWJNKl27an9hSJCxKyeNFDGL4zifTTSfAnPdD56+tLHK51Sy12/c2kxSgxLXfude+v2/bukM6A/6pbwcYFwdAPU047FArQVZZ1gHYj/5kGieGllIELETDpLDOCgNH8dYl4NnpSzP/lxWv3SmY3eDRl0nLBBEw+Jcvs/qiLJVVg4gIoKmKMO+Ky6dbseOoRwA38G5lEkgEMQo6McCGMr6yCrrj2v+Njoy0GAp8CSVNFkJXdCpfnXTyapnNR3oRfPsIAiTPI40YW4+5OBJAhwrkcXCTuAd58TgU+BGA6APXNkoLlLfsT4TUq+kXJcxOqrKjaduqEWwcQM6mqM01851F1T0+ibXML5apVz5q0bp+7rIGPb3qCE+qH8L+JKDJphYvyNtjU56dbKvrx8aVWC48Rf3hBCxFwsIoATWegBrZ1T8JzJFtzA8v9CYUzLhCDQ1NjssYwvlYoGr3b0AgbbHDn0R92z5M2Py6bU/AKtpmTqatMym7gj5mYAK5TfxsfaW2Q1P5zAuxmpuqWxmLOpPCvww0dWF/B2ispRs4cAWsQ6966uVr6Nepgt+DhcleAtKFr0kwmZMtgcQmabPS90cerhW7BU8rn5h1y/UY3aR/Kzv6dy/rJNjwH/u0AZFpBeKW84unRuLQVkMqELnDfLzKQM7JhueuH3M/yacTedq2BgRttxlGuLpIMdp9o/R4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vfYEpzsWHrrqD+yNg2ManEOPmEqYl84ZgdWf3WONpL9ecj6w1/eu7aU83TygbL1AHbmEHryf73gCECDHRr8fAqyIk2KHXgC5nFcZpq3JSJiW/sGw6qsOG1PBYw2tuaszguAbgJ6SE5+MwrB3cbCrZPTkmhxc0Xr/96BoozMBMvwd5nDDWhU7TNXlVZ73SPOKu9M+646KisQ0HNgAo3xAoYxmN61qmy5ff5ilyHINH3LIMWtxtGqW1qCma/v2m+023lE0cV5upGYy2PxdRlFQR+J/JdVo/FrA9L7oXZW0k4NFjwMyt47PaOnnpgkr26xcRqwgK/ZyIGMYdVfhi+zDfZMNVug81Md85vFTPRtmWfj3Dvrl5SVdN7+ilflm/HZ65MQCTbEXfPZlGKrwhe0aTlR9JlR3MBPJKjzDKPWj3548NGtHYnQBItx8As82T1lO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2026 06:26:10.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ef82c3-2023-41ba-9ebf-08de825bbfb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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

ras_core_get_utc_second_timestamp() retrieves the current UTC timestamp
(in seconds since the Unix epoch) through a platform-specific RAS system
callback and is used for timestamping RAS error events.

The function checks ras_core in the conditional statement before calling
the sys_fn callback. However, when the condition fails, the function
prints an error message using ras_core->dev.

If ras_core is NULL, this can lead to a potential NULL pointer
dereference when accessing ras_core->dev.

Add an early NULL check for ras_core at the beginning of the function
and return 0 when the pointer is not valid. This prevents the
dereference and makes the control flow clearer.

Fixes: 13c91b5b4378 ("drm/amd/ras: Add rascore unified interface function")
Cc: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
index 10cd398d4ae2..844720e4a275 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -527,6 +527,9 @@ bool ras_core_is_enabled(struct ras_core_context *ras_core)
 
 uint64_t ras_core_get_utc_second_timestamp(struct ras_core_context *ras_core)
 {
+	if (!ras_core)
+		return 0;
+
 	if (ras_core && ras_core->sys_fn &&
 		ras_core->sys_fn->get_utc_second_timestamp)
 		return ras_core->sys_fn->get_utc_second_timestamp(ras_core);
-- 
2.34.1

