Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883DFC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09B610E963;
	Wed, 23 Sep 2026 19:28:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBirrhHv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E17D10F12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:28:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX2TfolkbC0iu3PgbUpObzW4+ZkRL3BpITiUdBHqzj34M4fjxoO41jN5wL58GVUoWvc4qx8V7+HRJnEnw3MQXv068sh+WzbXLWlA9wQFr2nqnOrkk421mJncpAFAZJ3vIiyrgSrgIc5jR821nz6x81q/QOZ3v4tU7IPZHqLpo/Wubz+GWO1aiY/5ELwUu+Yk1sUgU6yDJeQoWcmwvufyulcLWL/Rkx5vTR7KnBk+rNYT+ggcsotJDfa8hZXu74Vk11x5RJN0/dgJKZTBbf1/c71BElFN1j3fOrc5pWr01doEtoxQEoQbSWX1K7x8nQYcZF1bqjBYMvHq27JnGy5/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cF6tKcQhx5/49urE/t4iVO4Ezqu5wmgbw3rF03zAnM=;
 b=mvJ/WzLbuIJToxtfNVvp75reCINR14kY0YLDmrQGOlAo+s9e8mZh45jK+NydWp6mugm2Qn5RizsPkqcoBz9d6m2f/ESXagWhBNM81VugPGGBqzsn+TwiJeaDm92JAz40bhDXuhAgO5ZfEV/48RRRFg6Oo5waKjiQsEqX8fczwzBwwixK1gOqDXg3N47994iH4Zj2wWGTyxwDZZs9Rj2K8sPEaUufZe7JuoAHHpmoquCOcEDGwMN5B1m0Jc8Ia3RMfj3FHVpUkJTgF1ic4wm6LteZ5gZZPgeQnFGPDPKSmmFYUzaCtSwRMPS412YBvsa2cc0IEHsujg2API0LaM4xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cF6tKcQhx5/49urE/t4iVO4Ezqu5wmgbw3rF03zAnM=;
 b=aBirrhHvII338vKD++mk3/vTqnxv1lhBqJCpek/bhxRoyoL1FrpiIGavAfICPpkmWuHjowLGgPdl3t1TzdZYuG9qZ00nmLxPWf+D4raUBJDz9HAvah0kzXGZ+61g5cq3iP2NHTcFf7L7HVH4fvr7InTJAVNfglrzULn8eYqWXqY=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:28:16 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::38) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 19:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:28:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:28:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 14:28:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ivan Lipski <ivan.lipski@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Bump frame warning limit for clang builds of
 dml
Date: Wed, 23 Sep 2026 15:28:01 -0400
Message-ID: <20260923192801.193726-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: d471e5f9-1b99-465f-133d-08df19a8d0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|5023799004|56012099006|11063799006|3023799007|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: aLjOMWed+GX0bq9Z6MP+zb5DjhUHSXLRggkoZ0JI/ohUV9lQmiLclQ8AcsV7+Vm/idfiNJglRI/5UKhIKK5TTn+KmfodCcSU6mDwj6uDH9Il8wZhUfEvD9Jtw0OIxk+6LbKB+mHHvEUypLn+wGqZqzcNbbnLX4oMO9UPsPbBjtWkk1zNmer3JwVSnrMIQEdlWhvrursb82/W3H9sjrQPuj3R7DDcWnlhNZUXAqPlZwoA4eK8AztVL8PJ62aUnVq08aaUsW2LqwWdwQrOkDpA9cXL+k8AX0MbNB+6pUsC8Ejnl3sSTZO/T7VKEtj0ZHuJbanIbDbYcXaACNIzU3ApEWJUF7FfBdIGU7Pv8S1yuxBOE2p9Y943EZq78+FwofsCV1Z0/iZMhBiy6kv0ZreCA3eZY6pEZ5sXPpVW8qyqFkThu2B9oU3KjQRQNfRd6D3TyzgrvesvD41t09Rjds/dT2m4c+6B0erBJt6E557ihU/xi0DDU4WaW6FiF9n2lXrxdU4KDt7rJswV+DuEbTr0ABezhhLMyK/072cuh10XzNr0j7Xpc1zjk9l6LqSOc+phV1viktYpK9wcykBakJ0ob1A2l8KRcNmhRUnYAVrdTUaekpBQFzxFKqeolkKG2VNYzYgV25cG0GMgOesUwfQSUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(5023799004)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YexKeOTRVzz7y8m+qcgB2k3J0BdJg1tx3QgjDFipoz21bjYsn5ViF27lUBkEHE1x1oPaZsoO9fqI5Pgc1/KdsB/K84wQzfdu2EiqVKSQvgvz2Yx0CMeDbkJNh35CMyPf6EY2lhjS3CT7sUm/ZqgsQJS6pPhTSghOaszTaoOeYXWBGOv3OjiS1s3B+nhLpa3JCK0jVCmm32vCfrClhA31YAz0za+fNB92JBF+PE+MTXRtgbX13vtoNrhBUNeHG3Oj4xGQa+R5yVtbH4V1qCVlnl5P/MCwXSaQ7Cyk53empqOML5XlAFDL4jLPD0exQ/yMfgKFWheNDuyjIHmi0YxPYXqIIZ/87sRd2QKQYlMyAQh38xVp50CHk98BMF9bvuIji7my5mfiq0nkBaeU9eGk/K/83D4D4ePeVcvJRRQGih/Pz9qkj605B+TwEYdrE7sm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:28:15.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d471e5f9-1b99-465f-133d-08df19a8d0ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
When building the DML files with clang without any sanitizer or LTO,
the following -Wframe-larger-than errors break the build under
CONFIG_WERROR:

  display_mode_vba_30.c: error: stack frame size (2512) exceeds limit
    (2048) in 'dml30_ModeSupportAndSystemConfigurationFull'
  display_mode_vba_31.c: error: stack frame size (2416) exceeds limit
    (2048) in 'dml31_ModeSupportAndSystemConfigurationFull'
  display_mode_vba_314.c: error: stack frame size (2392) exceeds limit
    (2048) in 'dml314_ModeSupportAndSystemConfigurationFull'

Clang consistently spills more than gcc, pushing the frame past the 2048
byte limit.

Apply an existing approach of increasing the warn stack size to the
non-sanitizer path so plain clang builds use a 3072 byte limit.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5642
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 096520bd27c64..79eeb3721b996 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -36,7 +36,11 @@ ifneq ($(CONFIG_FRAME_WARN),0)
             frame_warn_limit := 3072
         endif
     else
-        frame_warn_limit := 2048
+        ifeq ($(CONFIG_CC_IS_CLANG),y)
+            frame_warn_limit := 3072
+        else
+            frame_warn_limit := 2048
+        endif
     endif
 
     ifeq ($(call test-lt, $(CONFIG_FRAME_WARN), $(frame_warn_limit)),y)
-- 
2.55.0

