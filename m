Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E175C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 23:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6431B10E124;
	Fri, 28 Jan 2022 23:07:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5180E10E124
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 23:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtB9JIDd81tkghTWiLJleeupojswDU5eKkFthRCcbcawPsJZ3S3t1r3nHZEiaGvqx7pR/KKJZQMMrx+8zYaxEXYVbrfXs9zTL5+yd+OvHB6/Baxi1x3az4bQnTx7r2jX5DReGaU1b2dYDsam1bz0DKkGydfqK0m8M3cApmmj5IMS7qc4n+lyWiZ7CHvBes9t0X4001A/Z83Sb5LQe0hCfp6kiVM7tTMnVyMY6Da8Cn3nxoTMJeR3Ka1DZyhj0eP2ZlcxQlLPgDjYaWJptS/RG7uRC0ChzWiYdTezxC9Wbmj0ZU9RLL3hBcUJxHgGOZ6OyzLXEu4P8rkACpXQSB0UrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcwkXtmbzzjzoLUzs8RNsGwvUf4XjwQMG26ByFiwj1k=;
 b=lImeGKXF0gRT21pShkI/MLHsEySoKc633O+MoQLb7aom8ijQsKYmvMOcVTsGP5zVZMy2iEX8Cb7CLditbAIPcJ+0oO48TL2RQ6+vHTGr+H0Y6B8t0U405JDRCb6taqcgliWLPgEclAfP+o9uSujiE/UGlTdnyV70T/lAu4zguU1RVq+IrQmFNW4oUzZwkpxxK++tacDVpF4yG6s7/nfq3ruASYHcFhfD9POh+21pTKGYmeOmgp7EGMf+RVlJN1tFx9Jv1cmCzlmp37nNkgt3AfDXmJKyLi/8H3SYf+GUPdkxJoYmrJDwH/YChHqIUdn7w5ENN4bnlBGNPKXo38elgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwkXtmbzzjzoLUzs8RNsGwvUf4XjwQMG26ByFiwj1k=;
 b=m40ArjKrcTEiuVmr4QAobEhALI9h625FC6H3a/avj/NRoTdxSlsdiqPK6Jx5XN30zx6QMQdUhCgV7YppxX4xV0B+5igHcEYdE16K8zmxduXD9aalu/Qp2E1an6bVwo5pZA3fQLVrxjKwS9uD+P4y8fj0gfJzP3u886Xh0AeBNyA=
Received: from MWHPR19CA0050.namprd19.prod.outlook.com (2603:10b6:300:94::12)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 23:07:30 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::c0) by MWHPR19CA0050.outlook.office365.com
 (2603:10b6:300:94::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 23:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 23:07:25 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 17:07:23 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aggutier@amd.com>
Subject: [PATCH] drm/amd/display: Update watermark values for DCN301
Date: Fri, 28 Jan 2022 18:07:06 -0500
Message-ID: <20220128230706.6205-1-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4793f569-7f98-4496-f203-08d9e2b2f2ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4401293021C7282E637D250DF5229@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTIPd5+ggMuhtDO99jgVVxgeeBc5/81CppReqeMnafmM1Go6FcrMQ03Bo2I8noDhOluBpAWH7Kw6vwxSb5+tNzep4BNhEfRrYOhMFLGqGloZjZADzFdWXFtYlRwnYnkAYm8ZOFn4DVaxjVLoWtSs7VXcS7EVhNylDXjTfR8f5tdapZxDjRBUzPzVLPUGdVcZDF6z/wOeZ8GfMDx9g0I98cBvtUEtLzKp1GBrmIkqbL2+clG0k0Aaacht0GRPquS2MOIYcSa61iueWK7jJgHxGnpWfYL1m/QuO5/j15s2n2r/tuNrEFT649kY1zXajJkUvbaHIbrXI4b6zGir/DVMkSXx+njMjH+k3mRpCC4oAEqYEZdvvgaKk+fdh3hU9P8+VvEvekzQ4JXidEQD/CRYjF+XjcQLfI3S+69dOdwtVdGtxV4n+4kiVXoYftmbT5dczFctW8rVonpA0VCS9eOJ7nMAeWGTYG254+fDYFE1CoaIxFZJ9nSDGAIOJrbGU0EVqkJJBbLHBbHOsIRj/PiX69svkEccvZvk59yVFWPqLCbIypYnqPAXYqR86wQKUfGC4WCbaUq0Eg0mZ/POEpzWgfz2vyMtb+77fsV+/rtuuf7lEtIn46GK4m9NF9caUNdgRaMstkno1J4sarSRBCBB6E8bmaXUMJ7vec5Z4oDG00gj23NT9WZLjijtNF9cUlLGmH9sNg8DEXM06rpUrnykFATrKeMSDwhSWfugD1Zo4PI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(6636002)(356005)(70206006)(5660300002)(70586007)(81166007)(2906002)(8936002)(44832011)(316002)(8676002)(40460700003)(426003)(26005)(86362001)(4326008)(186003)(36756003)(82310400004)(336012)(47076005)(1076003)(2616005)(508600001)(83380400001)(6666004)(16526019)(36860700001)(2101003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 23:07:25.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793f569-7f98-4496-f203-08d9e2b2f2ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: Agustin Gutierrez <agustin.gutierrez@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    [Why]
    There is underflow / visual corruption DCN301, for high
    bandwidth MST DSC configurations such as 2x1440p144 or 2x4k60.

    [How]
    Use up-to-date watermark values for DCN301.

Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 48005def1164..bc4ddc36fe58 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -570,32 +570,32 @@ static struct wm_table lpddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 7.95,
-			.sr_enter_plus_exit_time_us = 9,
+			.sr_exit_time_us = 13.5,
+			.sr_enter_plus_exit_time_us = 16.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.82,
-			.sr_enter_plus_exit_time_us = 11.196,
+			.sr_exit_time_us = 13.5,
+			.sr_enter_plus_exit_time_us = 16.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.89,
-			.sr_enter_plus_exit_time_us = 11.24,
+			.sr_exit_time_us = 13.5,
+			.sr_enter_plus_exit_time_us = 16.5,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.65333,
-			.sr_exit_time_us = 9.748,
-			.sr_enter_plus_exit_time_us = 11.102,
+			.sr_exit_time_us = 13.5,
+			.sr_enter_plus_exit_time_us = 16.5,
 			.valid = true,
 		},
 	}
-- 
2.25.1

