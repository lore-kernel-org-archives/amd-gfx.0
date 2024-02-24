Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DAEC48BF6
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Feb 2024 06:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B1810E16E;
	Sat, 24 Feb 2024 06:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ZFR7l5L";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABD4A10E16E
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Feb 2024 06:39:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG22xZ3H6rfIZqHemQIV34qeN3VkCTYUrrUyae/hY/wAsoIrxiev6ENGdYOotn2EABkUW7+YfZACqBIStWpecyOdTnT4Vx2Zvr421LcZ9lTz8dqvNCboKoSs0vNPZhdlsHGd4HdEvrlWBLhxnr/1p/Drl7hUo8mSpQKcfAZgWj/Z0Gc+lUnssp6qHJQ0yT4i+FMjqkMASgeYM8PzWFS2MauCKEZKxuoQdjOhyIwRJqGZ3EHcgmo4mJSElFPJuHawSVg1Tz7cEIEYXEaDopbHky5lZfo3e5a5Wjq9LkMF93DB81O7YA/qcKB0A7pnK8wIdYRMdMMykTdnX2XNJMsxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KlRm2o1WguJFpQIQ8XIYov3auuFpY9G6KYjwk5GgXg=;
 b=OKXLbqUqf/EDPuWS0soPIS1PSwO3y/iuyokVdk/iodt/SoyUWb3JER2bT21jy0JoY+eE4ANpnbwQH0JLEc5GV5xn7K79QGxBeDmjKOd+CPlCMyTXpU/m/3GPptxrl9ssx3RrCkGJPDxc8RaVAgBpVA207YWTDZeQcS3jEETmSLS8jBvpmSdSnBwOhDcOXsUMZfMrDwsNhH2tO4/RKaw+Lrniv1Djx4O7t2e0zn9yd+9afgYg/s0shZzw6+5+zBy5AWKss95DEtiPMkV5hDAz6QPNlADdwUfupEE04I34Kx+efUZeiIKkgfyVoYWe7i//adigMvCxXBEGJ8UH7/qFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KlRm2o1WguJFpQIQ8XIYov3auuFpY9G6KYjwk5GgXg=;
 b=5ZFR7l5LOlBSIBYAGGPZl/W6n/63a3eHwUtutFV5QkiqEMtegS1MfkaPvowXjgAwlnG8rilUKVXMEDWu9w8aL2xL6WJSRocBT5WmW26FSzGFydDK1e/mD4RebwiNGM0D4ArJgeCHf/sTlOIYmTbuVfAW/B28Mz6MDsSyvCAy1+o=
Received: from BL6PEPF0001640F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:16) by DS0PR12MB8765.namprd12.prod.outlook.com
 (2603:10b6:8:14e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Sat, 24 Feb
 2024 06:39:55 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2a01:111:f403:f902::2) by BL6PEPF0001640F.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sat, 24 Feb 2024 06:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 06:39:55 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 00:39:53 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Improve 'dml32_TruncToValidBPP()' function
Date: Sat, 24 Feb 2024 12:09:37 +0530
Message-ID: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|DS0PR12MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f623a8-eed5-4ca9-7b98-08dc350369b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0A2IdQfNRUboZfedcXx5w0uRJEs9ar5UudDkpTsAQtvKSqAs23XfydKzytLnv3qQf11Vs4OhqTO0qDmYWe7yIHxD3ESDnK6QDsb2oeBLpN0ExWZKtd1YgO35zPAEmm78GiCT1kfPd+g8szHO1wtsNcNA4GcnMoud7wGqpx6z7mEQimGwGUjRNIeSs7+BKvyGkBfyNQkMDQ5EREv53hgxrbGvcYRiqov8G/8xxfBkSCkDgW2C2EX77BCL/ShdbDhm2NqOZx4Qv1JuQngPoIKH3MI9IsyzDpH2lAJG+H53z1rZIgtNeazDrvCebTXh8aemP+dIJnhIKGD/BEFM+FmHNAEUN4ENnm4RfRhrkqfZZb5Xx0u2J4IkH8H+4/O8D5WFSfCKZb9wCChOiEkVlYNefanA8WfNxaq4Tf/ZlgC4YLfPp3AgVIEW+4xpLimxnq2VzHPOU/VNcAdV/jGeycIUJhJrpX4nKmWfvzdDC4W+XKLPrlFJT/lGCAXV6DZLaxOXiQdOiLF1XscoriwGBZn1OWqOQCa6PeeXr5YtqaIQiEQXX7ZnMGC4xKC04N0FCoN8vNkMGhv2ef/rNbHcyJ5zoR1xUQDbc87DZz9PliDHefmSIyBKlVp6IJkTsJVxeJvl+oIs448gX0rM0ahX4hgF0yvS8oZM02zTe96KAEwhfEU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:39:55.3777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f623a8-eed5-4ca9-7b98-08dc350369b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8765
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

Refactors the dml32_TruncToValidBPP function by removing a
redundant return statement.

The function previously had a return statement at the end that was
never executed because all execution paths in the function ended with
a return statement before this line.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1680 dml32_TruncToValidBPP() warn: ignoring unreachable code.

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 80fccd4999a5..54ac8242f7b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -1678,8 +1678,6 @@ double dml32_TruncToValidBPP(
 	}
 
 	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
-
-	return BPP_INVALID;
 } // TruncToValidBPP
 
 double dml32_RequiredDTBCLK(
-- 
2.34.1

