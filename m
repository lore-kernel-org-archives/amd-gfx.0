Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2072CD1284
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680281125FA;
	Wed, 10 Apr 2024 21:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cy2O3v/g";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A12110FAAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVOb3LHDyut0oLomHa3P5ULl7kd4KoxIj9WaFI4SAvCmg9c+Grn7GNkVWBWrlAaFJE8uMCq4pN/kNWINpNDvFIk90dRix2c3ZVvwxitNzSi9pdwhsW9J7Q66x2pSCU+F1ON3gNTFrdMzmMquG/h+tz/PYkg3LDlTMER1Brca8yqoLjISFNDfWL4W2LbFDCN9nIa7DQjzU3CXnUy0NjHF8I1LRpBpmK9XcQ9XTQ/cyj2h0ClTeifERNpm9b3rboeBLarWKByl7mN3o4PACmblz8kdDrMJtLrjsEY+bEYxBsW9P2GjOX8GJEB+OxtmraNhQTkRmB+gdnAGOOaZUngQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+JKGE61rj6AxX+5sPK2q/PkPkJnPv621viCShHNlyg=;
 b=ED1vh9S1G+MaNRYvuuaUsC1muQugtYEhbv0cZY4v++/Hs023Kb2Fq/K57DenCFiIn7W1J/MOouKavy/0B8T3oD0Pk3n9pOEzHWAqJJdXgNqeu88QGQ/a9Zx+Iz34odm/0sTCI0JEgPMXg5v4ZLhZYXdCMXseS3swvDvUwVJYxGRVHPHbh26qfsHUcxDhPX9YJGf72KDlnC7ILHiVH1BrsN0QBO75e/EZrEDy1q7f5VFV7TjG1rnCdxsIEl4U8yFc572A0Ti2xPo9BcBCaJyIetSSHKQG6ERgpsD4BhBjX+gj8Cn+/gaFJmQpXEkuSC3Az0gL+G3J2jh94Eh5IbI9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+JKGE61rj6AxX+5sPK2q/PkPkJnPv621viCShHNlyg=;
 b=cy2O3v/gtLvmPZKa6Jx67HWNRGYoDkNDDlZWcnu7rP1jcdzbvCZ0pRmJzV+QaZFAwAkLR47MrWi5qcou0BnSXLaF5WJzsxV5c3ulARhebgOWxUUE5j3h6iLBMR2C4L6Sie11FBwTW7wJM5U22/MjCn6i3wbs5qFNL3v/tuFGv0A=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:28:24 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::eb) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:24 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 21/25] drm/amd/display: Move REG sequence from program ogam to
 idle before connect
Date: Wed, 10 Apr 2024 15:26:10 -0600
Message-ID: <20240410212726.1312989-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3cd6b3-dea6-4839-cf24-08dc59a52750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkCrcENIf4LHgiLW895gjnAVOJ63T1HCroMbxmadHfTFWENO4CciTnGJVjf02E+3p8gRS83zq6YbROwg5AJ/mdOxCn0kIJWppozU28+0uwYGu/EtfQSfmuU0mMdI1JC0y7iOB3lzbtR3oxK2NLKLZA8awufo1zK0YMW6rEjLFfpp/KVs5vT7Yo0D7TvFyWOqokxZjXoqx6x6xqNSq+Xb4inoOP6Gwgj85mqyJuwZ56AvVIA1wT8WYGXMnnIQ1DtnsqC3Tp2+6w6XceJYXonXCa3thUq+H5kauaAbGzxYYOBF+xolhYjw5K36h17Tz+dLeddtZH2eXDHJ8kRJz5YCasKTDGZOVk7FwkHJIdvAfwz0XBOTqaYD6At97/ZOUxmd/TbUDpt8cCGFOhWDMVSi+3NjvbwAZZaZyon7g2l5oTxvgdVyjZidqMWx84wb9lLeZjkACdIeUD7Jud7xFoRblnhJ6BkVBF6ev28jKbyzwM1XxTbo5pxOh7saCW5cWkEVT7YIX42NgRTASGV/FyM1HHakqfq8Fg1rQ0qwTAl1HbIoHvV3hImLKhrkiTMRldpoMWr8bUcNQpDd7qLoT3jg1DXfrfYHOrl35QGT2JF313cAOdIbdDSUKhcHDjYFBgvzdXs6UNPUrh7Ac5mMlJa49aCpvVvDsAjCXJq0xzFiKCNtXA1U6Xs0UyJtD9HODvBVDVfwr+Xm29ZS0rcXDU3x6IWgaLJTYuiVTjar6fq5//byDp5mCXnZNDJCQBoENQxI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:24.2601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3cd6b3-dea6-4839-cf24-08dc59a52750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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

Fill ring buffer before offload.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 16b5ff208d14..ea73473b970a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -395,9 +395,12 @@ static void mpc20_program_ogam_pwl(
 				MPCC_OGAM_LUT_DATA, rgb[i].delta_green_reg);
 		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0,
 				MPCC_OGAM_LUT_DATA, rgb[i].delta_blue_reg);
-
 	}
 
+	REG_SEQ_SUBMIT();
+	PERF_TRACE();
+	REG_SEQ_WAIT_DONE();
+	PERF_TRACE();
 }
 
 static void apply_DEDCN20_305_wa(struct mpc *mpc, int mpcc_id,
@@ -501,11 +504,6 @@ void mpc2_assert_mpcc_idle_before_connect(struct mpc *mpc, int mpcc_id)
 		ASSERT(!mpc_disabled);
 		ASSERT(!mpc_idle);
 	}
-
-	REG_SEQ_SUBMIT();
-	PERF_TRACE();
-	REG_SEQ_WAIT_DONE();
-	PERF_TRACE();
 }
 
 static void mpc2_init_mpcc(struct mpcc *mpcc, int mpcc_inst)
-- 
2.43.0

