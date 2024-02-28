Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B1C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA2C10E318;
	Wed, 28 Feb 2024 18:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BJnKnljr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D73010E318
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd6ZgZWuMw0ZyC7dapljHFigKCTrjfxCBMfRY9YmzTsT5uyONmWDfWW/7jmonDd0eOBXVLf/P7b5oC8rXbLl6+GKm66SUe7hBGJEtZV/erz9C6Lu0ze/sFtX1ORKcZVcIitVaMSZUodRYsEOdXDAK7RnVr+chlEArZv7fUVs5fS2hKj2SeQTEdiVEfgEsoEXfDSDsgFnLlmUG6EOYxDOROPNyU6BcdXu0n2dWz1dSY+9RdiTyfKrB4QkhCttGUw+3nrDpTLkR1fQyoo/RA4GtMKzRaVNag1ceXKiUhvnZo2EV2a83FKA80TLeDwU5cN8YiYdsCidfXaTTE5CLOwZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOOE+tTx3kZqqpoaVOJOEqIr+D4QfSQzVPl++ZwMKqs=;
 b=ZK81hHyC7iGJwxI+/P7ctHPRtvw4NXcb5W23uFZbQN7mJRIrDfIbk8vroQeeYrgaD83rOeI89F0qwKqnd3EZj9spsp5egOX2SjuoAhYgCunZy0j0zT9sXfw/33ftOY+phA0b8c2aydvJsPkOK0sP/7aCva6OdGG0DGZf+ZXrb4GdBzcqRpGEHJLc97O6MM8R/iA3ajb5Yo0sGGc8ttupcHzggM4CwJ9J3wyjY8iH7V/POIv2CIrp03L2nzT6LOMNm0oU8MjGDpgmw3e6wUjB7+vwDM2HaU/BlC6eBvc0xNjqEdOTByKWftcPNdLv9357B+HgU6y5jJ+6I71RfwOXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOOE+tTx3kZqqpoaVOJOEqIr+D4QfSQzVPl++ZwMKqs=;
 b=BJnKnljrjTAUhtYgvjUg8c/j5Fdc8ptf4kxyJBleHL+YcuNNN29SYrnaJe7Q+ean1RBetkehGnEHq+Z7TeB3migEOHGqoYqPOCsCmVCdT9nd4G7jqeFGWriziD7g2uORsqgqPXUBz/hdftXxh4B9P2eP6KSdRIDih8DLM/qFJG8=
Received: from CYXPR02CA0005.namprd02.prod.outlook.com (2603:10b6:930:cf::6)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:41:41 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::ae) by CYXPR02CA0005.outlook.office365.com
 (2603:10b6:930:cf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:41:40 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:41:38 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>, "Alex
 Hung" <alex.hung@amd.com>
Subject: [PATCH 04/34] drm/amd/display: Add DML2 folder to include path
Date: Wed, 28 Feb 2024 11:39:10 -0700
Message-ID: <20240228183940.1883742-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 399bbec4-0897-46d6-a9c7-08dc388ce75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUTF7fYQJgMrQcQFqLrC/EFpr0uMVgi8pcCEFITJYj0ymGjuyW0JvTSHwtJX/0hkIUV7CKL6LKaNjCTgOKtIXvCt3bUch3RT7af//5xJ18snCH2pN9yTUx8vTgaSJaK5KfRJjI6+r1mro+Qrs/d5Yn3FbAnUqYDEbpmDjuHPGVyIjUYU2e+/8JaVDeVelO/cWkrFl/CJIV237yWX+iGzdTCVJXjfG1kVQfSXDc4A/YELUv4SxF+a/BHGnrcGwVG9QrMbS2GsYaSZLBYJJGH8SHJlGxi/pUvEcdPLyLu7SzitoPMb5vYcbIjJf5sESg+LQeaCIQ6yXb4yL55IFUIbdKbf8gQA9B8CGrofknzzNa+JxQFh3bPE2GZKIJx3ASZlf8SHs9ACQz618KK8v672kltV0R1TDOSewzw6sjsHA2pxSRKUvbOOhiM0HpK13cjDgOcLOUEtyK4FdidafQqEPggsKCZUZbgMBtwi5RofGdvBYXIz1ZrDBvd/v1Jbn3LWXBIiYmSeOg81Qfx3g4v7qRWdZepcxDla3baxhn0NaxFLx24sPLsL3Ad0jjfOXYZv9dnUcmdImHgLGFO1LdWx4lG8icnPCndJPbo70kKfpenY1SW+mi+GrybsdcupeJDNorikJr4cHhlcq+vZBk7bsRgh0QH2Nd7WsnXskM146Hfoe60e/LaeNC1vemHC+fXoxzibdBQ4YUlxYa29eBRILo4Ycln1W4PSKegHhGC9LZrrE9B8I06G2dM7hSKb3dHI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:41:40.6991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399bbec4-0897-46d6-a9c7-08dc388ce75e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add DML2 compilation rule in the Makefile.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index acff3449b8d7..1c9498a72520 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -67,6 +67,7 @@ frame_warn_flag := -Wframe-larger-than=2048
 endif
 endif
 
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2
 CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_util.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml2_wrapper.o := $(dml2_ccflags)
-- 
2.34.1

