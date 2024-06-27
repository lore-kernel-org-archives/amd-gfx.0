Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6254C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CAE910EB62;
	Thu, 27 Jun 2024 21:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pnogLAjt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7548510EB5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2B7ToqhYCUZm2vBr9YQLMfNwwptYHNVca/q7BhFO9EHMIpsuymeb8LJmm+KKmtME3o7oWWJ6ZmFxhRoLndCUB/jP6yokuytGrjXDr71tKdTO8yejCrpKhTIvouOrO743A5jtkglEQ1RRn2yKfVT6PqrYRGbND1CM5p731T9CizYMV5t+tuZeNqbVRiC/eJbQzu7yMbvumRxSV9MXT2EBc76jfK+RK4mh71AQnKIOEKfTen7q5PVdLBIOg/tdpxgWFs2FxTTpiA+3vs14IDFhWtNNltn2GfJ7bWLoj2SvkbIQ3gnm+rmDNkBTxESFUhEmoD4jOFiDPMmTlzki0G1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQBcC/aL4HYGwDzW0AOA5jm0Xz4ArOr/d4UT5ykpxNE=;
 b=YL/43JBqqlHobsYUBQIe+Zxm3IiGIiTwSvn4oo7VvP6BFhiodOVhW8yWXpfoxjm5D+lxwOSp0BRENuiZH/3/Gm3kR6gsnKrOYltzTjzKo4OtVvVpcSSuxu9fTya4Mr2kbfJrPa4zn/A08iFYagg64fNWA/4ei5UvAUP8yFz4QeTu5wJqWSpIgDm1b3EoJoh+ikQHsIW19jGvDnE0JF0wG8kueNWth0ddRzgUfa9vl+EoDS2qThuwWluIWoGkUePlE3BPRngS87Xd/baRlMZduXF2rkdHAKrbiW/3fIITq/iPN6HQxcraf1D+iKayCDb7vPdM+5JI0GEFZRwzSA/JcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQBcC/aL4HYGwDzW0AOA5jm0Xz4ArOr/d4UT5ykpxNE=;
 b=pnogLAjtwQuEcLFHLygAUIzvzB4mi8YK2p+4GcNZNkwQrs4D0cijA5ZyKfOnIIZw4vVVJ/TJEsHhqHw7rdwe8YXelF9NHPAk+YNMFeAi1j3jDvtcG1oo3XFzeok23zajZH0YEcair9WgXDykAWLAlkn6WDlEdKdni0HV/1Guf6U=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:14:39 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::3e) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:37 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:37 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Hansen Dsouza <hansen.dsouza@amd.com>
Subject: [PATCH 17/26] drm/amd/display: Add debug option for disabling SLDO
 optimizations
Date: Thu, 27 Jun 2024 17:13:20 -0400
Message-ID: <20240627211329.26386-18-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3042afbf-776d-4776-49f6-08dc96ee27b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vDhqsmwRzD3Y/X/Vms62Psf20rl5ZcfnB+4CIFrXlqUI8hgp5B+P1jUyaPeq?=
 =?us-ascii?Q?LsGAWZoUE7ZRKPiawehSJVZBgsA7lMC56mrrG3MeSjbELHBLBTpU4Ntiz+b2?=
 =?us-ascii?Q?NC43MlzRACTU5xVqChWc+YTphyaAXI38KUDPhJN1vE582/PNrZ+7ORMTzYOG?=
 =?us-ascii?Q?1mBWWrA2m5glR6IiEVjbDLy6DHXztTFDZJsg8ubAUF5dNXtJiZQyp3LKFFxO?=
 =?us-ascii?Q?uYaUFHpLCmXFs38aZgpgwDEiCyrcSbTuYHhY7TD3ahwdvdUKALaHyg2IcD6t?=
 =?us-ascii?Q?dmmB+QYj7Mlz0sO3S11qF5xQYBUMqxv320Y8uiaGreDF9idbjQ3NfbAWH/Pf?=
 =?us-ascii?Q?qwhtvCSFWlpZBuohKUq41wMic6hOQ5r9N/CnnZMC2dEGBF/HmHAYDMs/gJKv?=
 =?us-ascii?Q?QR+4/j2WZSZzpU2EX8vCC2GcjG5f03EvelQjPn0m3hMT0itS0nDzL+bPe+s5?=
 =?us-ascii?Q?zrDfEkEdgxnldiKsfXpUZXskxW/1tEN4SURVhF0VDikC8hQN9r+Yk9rgtwpd?=
 =?us-ascii?Q?IzmhyRjuw1mSS8UId9CWh175dZvpGhQig/vRQ3lhlP4wPUn3aS+U+7h84PkE?=
 =?us-ascii?Q?F63jz2NNFxu/0YYHJdK95HWWjYegjmvADHgMyUJv+ugONXtPzBUMRGHz1hyk?=
 =?us-ascii?Q?7CoO1fD/RnyuSKZ5sP49WEMK2ZGEBwkwputahVVfNdKCk/cFQSJgr42/mSqA?=
 =?us-ascii?Q?+UAPDVriDguHxaOuIOYDCq6msBtU4ZmCh394m3Qw/Pa1+i4cMYH3OUsq6hbd?=
 =?us-ascii?Q?is5qOd6hXig6/6/gf83ICpmbVcL0T3KI5um3y6+vaiXvaZUJexgIDu1iC/ZF?=
 =?us-ascii?Q?lGnQPK5AscdtEVqRXIVYmV68ih7kCW0I9/DBqNrBgGNu6JEcBUCIOe9W2ris?=
 =?us-ascii?Q?b4X2ENT6KGz1AEJWnI4+IZ3kqRKA4dh5oWT6VuK72Ji4hKbLFgZ76BPKzoeA?=
 =?us-ascii?Q?trdWak10RgwcQv5ZEjicYFjWh2UDN5O9qKvoGWpzPL/tMRe2TaNE655cSo51?=
 =?us-ascii?Q?nsTeW5hXTO9nKHM1B3FxZ4JNgOowz3VB55DU2avGOrvL7G6cCmGsEDyGOy6G?=
 =?us-ascii?Q?D3q23ly3/oQ908RyLOPsQLagDxUsqZ1uivHxs5Wei6+rn65CUcJ3dAx7w959?=
 =?us-ascii?Q?zrKezHg0AUxLuxHOjbUIAQMnYB0ZQntGH92wTFjbrlrSiGIcnrosQVYX3Rmg?=
 =?us-ascii?Q?PV+iQoYfrSN1NSeJ3hK1z8k2Z6PbMca6RZS1P9BFoo5mxxKOeB81hN7LrnrX?=
 =?us-ascii?Q?I+5MWRP1Jfx0lDMXJDuZhH9vJxu3fwF333eCJUJeoVSiCErxk78mv8YVAsKs?=
 =?us-ascii?Q?xN8sMpSdbcxF247t709czSFx2BYOFKa7x63un4m4xWU3RWG5CNiPAsYPWYrD?=
 =?us-ascii?Q?jdS18A+/kcj8/wchMBXcYV0v4HDufi7nfhhfwpAlMGF5BsdOqxgbU+57Xmus?=
 =?us-ascii?Q?i8W2oH0RJR7365AlwzhmWzUs1SGIyzVr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:38.9671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3042afbf-776d-4776-49f6-08dc96ee27b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DM can hook this up to disable SLDO optimizations in firmware during
DMCUB initialization for debug purposes.

[How]
Add the option and pass it through dmub_srv.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h       | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 3 ++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 85dcf6b4fe92..6589bb9aea6b 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -299,6 +299,7 @@ struct dmub_srv_hw_params {
 	enum dmub_memory_access_type mem_access_type;
 	enum dmub_ips_disable_type disable_ips;
 	bool disallow_phy_access;
+	bool disable_sldo_opt;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 605dd9d45167..5ff0a865705f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -684,7 +684,8 @@ union dmub_fw_boot_options {
 		uint32_t ips_pg_disable: 1; /* 1 to disable ONO domains power gating*/
 		uint32_t ips_disable: 3; /* options to disable ips support*/
 		uint32_t ips_sequential_ono: 1; /**< 1 to enable sequential ONO IPS sequence */
-		uint32_t reserved : 8; /**< reserved */
+		uint32_t disable_sldo_opt: 1; /**< 1 to disable SLDO optimizations */
+		uint32_t reserved : 7; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 80da117356c0..916ed022e96b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -424,6 +424,7 @@ void dmub_dcn35_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.disable_clk_gate = params->disable_clock_gate;
 	boot_options.bits.ips_disable = params->disable_ips;
 	boot_options.bits.ips_sequential_ono = params->ips_sequential_ono;
+	boot_options.bits.disable_sldo_opt = params->disable_sldo_opt;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.34.1

