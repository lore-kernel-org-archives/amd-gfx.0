Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F2EE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 14:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003FD10E79F;
	Fri,  6 Feb 2026 14:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0XROpdw6";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8E910E79F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 14:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etknBtBbNKhRfo0ec5syv28NffzYHu5lnEvvNpW0+iJGqIrdVo59vjy+lkJJP9K92gPDuwBdEboDUALONxKw/4F0H+OjtchPyT04iXHRRZndOojEg2w3hvuENxP3iEJw1w9XIGzRzw9E02ofeD+z99Ec1ehszQ06RTppMS+o84dvk46nnml6dDg6c1Y5MdO5EeuBnNuxazWs2und7jXtmTGXDq8B8izvTY6Qeh4h0NNTW1CYX1TE3r7oKmy3Orjg6YP4YsqTRHtcE3jDeM940crVI1mhY2yz0fM3DCkjUV3g+0ifSXM11cqVYqOf8yu2Af3nC68yr2qiQDW/rXwcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OqBpDTjSQUq2E5HHL8EfGgwkBat47oJR1JoJNxT5Ss=;
 b=NcE4SZJymxVfJ88VVvQRjqB1ycV0QA9P7CReseMBFVpZChJT/R1MvOTL0Q6F50nfgyMpG8Gplj9Vh7NAOFVNgR86HLtrKejJd05cx3tgcRpHNwu1aOrRUbMRHHgstEc9y/0HTsXOWM0UAfMCjbG7IkKG85iC8VtB1nAC0sfMkBpiYIL4hs0azxj5nDLFBGhoIPT7TeB/vtxDPZJwZC1TeDckK8o8Mfl56cSXZhr5OXPJA9FQIzXGoo+EOG61r77ZJ6+EqIewYNEOHEQl+ZDiNpXdzHUEBfH8CvqxT0oQUThc31BgHu9zNEZGPurJ8XKFYLWgb3zCmbmsUeYz+uFB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OqBpDTjSQUq2E5HHL8EfGgwkBat47oJR1JoJNxT5Ss=;
 b=0XROpdw6/u6wVZU/Grw+rK+2A3PQdwC7TBXyddOeBEYHluMSNcCoQxkZKUhZDERHRRcuO0oP4RN6I3ICy0yrVQzVwGqWbfFP53oEv6c1pZA1QeoJK49jYUh0fibNY9WgnuHtZxibE849bmZiS0CuPcMC6RIS1uclNA3+wT4F18s=
Received: from MN2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:208:23c::8)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:01:15 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::9f) by MN2PR18CA0003.outlook.office365.com
 (2603:10b6:208:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 6 Feb 2026 14:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:01:15 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 08:01:11 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Fri, 6 Feb 2026 14:00:42 +0000
Message-ID: <20260206140049.105294-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
References: <20260206140049.105294-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: f073d480-3987-4632-b026-08de65883176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vXq6dzkZT0MJTFVyr7I7u7cmoRMSeLKYkUdEQcSbhGJoN0m/nk4q5jyzneqO?=
 =?us-ascii?Q?HSd7osIcs4qI1bhr0SQk9+eFimKeBOIRhDU2LrA6udBrB0rUq7d6mtAEzhWh?=
 =?us-ascii?Q?GxmwTVKfdvRRzYS0bYXr/ud1WsOxcBQtRV5amK1fGriqtG9MCE0I0CRt+7st?=
 =?us-ascii?Q?4DngKxQqqRYQJMTa5KtslaikavYdXCyIz/bGIA+SVX4SRu07OAR/JAgx+oDf?=
 =?us-ascii?Q?gLJe50uqs41agABWg2dr5nsKeQTvbruQyrI2eYZGtQS7eKMyPqoqf9HPXvJt?=
 =?us-ascii?Q?zapM/N2owuweJRGONFHoDLnfpLuZkUgYZun5p3BMPNoY8yxIPZK6NDS1taZl?=
 =?us-ascii?Q?daaa3lDPngUrZnCyce6qX8NnHokubC4vSB7j7hoNWC/xjkGX9aUp7i2vhVr9?=
 =?us-ascii?Q?PVpSPWOQPqQYnZjPJFwNuE2tVrTGOXSBlxBzRpsHHWLyUEbH+lNoZH/T4ux0?=
 =?us-ascii?Q?CHHdVUJ3R8qmIJbDkNEjAfA094Mj4oZd/Zdmq2+1klVEss0uHse7p/bX3cug?=
 =?us-ascii?Q?kvB0au2Q4HsNAW6UbV6opOaiBSFaii/ce+0qE/tMEMjAyTL+GzhlDUamqPzV?=
 =?us-ascii?Q?0aPBSoMXlG2JmlR21wcu+d6n97wXodce2yoMDc6hdpb1LyScgCAz+541TiWX?=
 =?us-ascii?Q?jeAo891Jx0FN7lzKhUPziSjFmvcIdVWaMooaMRdySIbFt37fVIR6liQBw7kO?=
 =?us-ascii?Q?I/SIkORp5pFvEKgYcNPgeC08eDeUuxDrBO1d1LnA5R8qgJnrC4OASfIvkqlH?=
 =?us-ascii?Q?zXUWH+PYRieck7gAy+q1DPk4qXoj2hlFXDMMnRFo5Qn9bGqnZIEPHkLer08c?=
 =?us-ascii?Q?MjtaUqeAeXA1Dr1XKEmZasrvYQvTfsdjcEP/6F8kjdyMu6vj9/3IO81sP2Dp?=
 =?us-ascii?Q?mWhEtSxf3gXewmul8NVNjAfxDjCSrr4HNDVmBIkfE0pZDBQ/vyM2Lx5ixicC?=
 =?us-ascii?Q?RB+8vzUK2P2yLBk9/6EiGvhIVzXZ230dOVmlnf1CrTVpZildY4ArQyzgUBV/?=
 =?us-ascii?Q?If9yw9EDrRegAZ4aBQdnhxDHJVrHou5l7EyIZNPnNwrJgIRTwX/yOqcI1xZ3?=
 =?us-ascii?Q?YFZJM26/zpcZpimVUm5WCWGJt4CBcoRUzDUHvkXOlObKYtVbUXpu1db1GDBj?=
 =?us-ascii?Q?jcE5cK6FVEKMlzsp4xuRVN0ldpXnObw7QyAZWGQS1S2OpDFefH/NfMlt59zC?=
 =?us-ascii?Q?2Hw3zbXKzMH+132Da7DDLYH6MXOXXBxfcUsoMNpbVmLQ3uM42yZHSauiOS7Z?=
 =?us-ascii?Q?0UZyNZEAOeMQIGPapBlHNiErGUm4IGD3muv4foxHXmh0uuVneDZWy2dIUXt0?=
 =?us-ascii?Q?3WG8tN6H2xnY9Yz1n9bS2Q7KJDix/PCrQ0BFxtcw62DTpvIzUEZ/09sg5jCG?=
 =?us-ascii?Q?Rf60JmB5zOEAQsmr2ETeFxLabsspdYeo8dj8QREcmTV4ABcn+n9R42PLuC2I?=
 =?us-ascii?Q?t777Rl+UZUiPVZ/o1+dPNdMLAlGS22yErzNkCzhnqg4linwQu4nZ4lrLFCU9?=
 =?us-ascii?Q?yiFVPIuPJm6Fk/YaDpd1W/nJvTmTn5S7f6SYxn8N5j0YQWIZaIrR2RYsDazv?=
 =?us-ascii?Q?uE7DBBqurgwUK0jQCKE7UKVFVF/7yx80ecC9LSUYbwoqaNX5Y/X7g1cW6TPd?=
 =?us-ascii?Q?UZa+sfmEucea5448ifJWYLiD6qwpBDHXLiOvfebSjm7Dq6PKtQDecs7RFTC3?=
 =?us-ascii?Q?49S/MA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KJ/8Q9hATfrao7+csoAS2nHsyPRFxf7lcypkbkn7aMOzd19ScShXO/IewIpr5wVSERO4etti140q+2nngxCD2catd2MGQeaUAA74aL6JXkBZ45hx73eC6WH9TefVzk+iqrEOpTfXOUtvaFG+OIY1hEYntXZMaHmq315DQRVgmE91ZlSkE9RhVKK/5q0cFJbvjkPoV0qGWe+QWLLblmst9yuUd98nZT0S4/tuGO41g/tNudC+uF7dKFFamocaxax0GfeiCh9FuidYPrzEsBl2QudnyuiH16LrC5lr0OJUoKAgMVYIEO9dVuwCfbMqOZooFdanYUPblP4x6WEV7jZVsx8gMmVFklTD3/z1mnD/G/jM6dh0WKaZgyLVReJupdfTqGZM+jb00HnbouSeki0YEysZ/UAJL2h/HGx7GLT6f7FpLWt/oXeFP/EzmH5mV3cB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:01:15.2521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f073d480-3987-4632-b026-08de65883176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 70dd5586c53e..445943c8bc94 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1790,7 +1790,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

