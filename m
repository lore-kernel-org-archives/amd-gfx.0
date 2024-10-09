Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1088CF043B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 03:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A9010E147;
	Wed,  9 Oct 2024 03:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+YD3AC8";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A555210E147
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 03:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSXhUvWuNQ46K5oxSVN9PyH2nc+j37wRfTda4ZD03/YESHHVai7VvKvY4lVtBDJ+gcNTglWOS/K5UJQo8upOBvVMGJtHolhrEvHRM4yMRKCOTJo4rWRBCcZqib4AT3a94K35nxOz7kkwtqBcfEAxkDdGgVhhyLYWeQ5PL7zlzBTzjPTJ76hGwqVhB8YsS+vsg+IVCw02TRbTU//QruoZQ3ww4tHr9AxQiOfaX+rTkjetSWruY+2NFn7hqe1ng8U20UERUwFv9N+pfk/KjaeNWBTRZFM9o04z1qzU/iO4gUNk8Jx1v6jhgzaDwq7R3KnbPel/Z/Zr4lVhQPrhU4VTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=QEqteKQbeYtTMILcSI3pxVVasUF6QOH1f5WgYbBRLNjJ3oqoMqMD3Izk1VXnYo99AtERum50tIfysneZ9uTLRP0fGU5nshJXXDAL/6PNaR+Ehbc5UqId5MiCZ2Vn+yOSKai/uzOpRQyMB4F1btpc2WC2I56Ta2ztJO+1UgwQN4HjPZs30AEQ7hMth5r6HCUq+PKc1a8uylQp+3klZveAmvi0me5MquWZxAEUJo88Vq33A1mm2NLET+ya1S4kbh/WFHolOt/KVzt96xC2wUpjq+IJIW4Au4i3pnAN4f7rCp4K4cm2s+zcOcscCPFsmxINgm1KYnw87Q+Vvm09N11IWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhhQEudBm8Sp60D2o7Q9iOrPZ09PSJoiNhEWmY+4cMY=;
 b=n+YD3AC8D3/xxhM5W4+MCcINDb62daKDlSqfzzQ0CztRI06RHxJZaCRg395oLBqY3WKKYtovLnnfCNxldPN4TVCsRunBN1ETKNT6QtmnnEZWPS05Ah5YbddRreE/fqVPbUAap5oC+DcbV2Rgum9Ch1TID/Y3KYZoJEPW4pejYiQ=
Received: from MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 03:46:00 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::14) by MN2PR03CA0007.outlook.office365.com
 (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 03:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 03:46:00 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 22:45:58 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 1/3] drm/amd/pm: update smu_v13_0_6 smu header
Date: Wed, 9 Oct 2024 11:45:43 +0800
Message-ID: <20241009034545.543736-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 581c0e8b-5289-4701-910a-08dce814e435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THx6r85WUQnclp6J06X8oV2O6KhSw2C3WKSf00BtIpiuoHoiXZ5PxR7DXEkR?=
 =?us-ascii?Q?usn9s6fbXR3nQ3p7wlon4DRBY9fEdTjHRIqO3nZpjNx2w8GuAZc9LYn65W0L?=
 =?us-ascii?Q?90xaXggDLInDXFV/+9K3q3oxElPg10cDLbGsXLqL3l+sC36+Bo1Ub4xrj2Xe?=
 =?us-ascii?Q?WYzBdyD1vUO1+ukWMPWLGej7hZvlKzYWmaDMXdnU5P1wgebXjbWg/AW5cnxr?=
 =?us-ascii?Q?1WBt+ghpvHdmXaH03XdiNTe77aHfcJzw1lOjPRU5lE9fPZlZu7vgmnGoa+nO?=
 =?us-ascii?Q?ntlEp4hOWqw6GDC6zI7fwM3wSJ3CKRa92y3Gp+angU6aw5JtIDTLNcpePrfv?=
 =?us-ascii?Q?L0Uil+DOacTF46+TA2TgoJSkbNROVvovbwYhXpFCoDxPRXPXD7CkwOahH8Gr?=
 =?us-ascii?Q?P8EwjbSCWuot/grrQbB/eFo2AZbqc1cbXO70pwuakqRf+fAHQLqTFIEcZVk8?=
 =?us-ascii?Q?Q36bE4l0FBjSKmPSGoVEzSUYnWWtiyw502PBar27UOACjCYFbcO6r3xk+l7M?=
 =?us-ascii?Q?IxnY1PosXuMQmCORUlt/Kjm7urowM01rXL9QWsFCZShhsiYGnAE8hlWlh+A6?=
 =?us-ascii?Q?Qg7kzt28om+sAdc3F4BpkXkhDpzgckSSeGjAAqDPk+Gcdl4Fz30tzspFmCTd?=
 =?us-ascii?Q?wh06mJGRh32P3RZ8MMvHgEOqcQK4Hd1eutrTAddnaEgSYlIbBAH0AHgwo4KV?=
 =?us-ascii?Q?WUgyFMwYTXFIc0CHSimdL42fQPzua/O5f3YOhbJH5xG/oJEyZhaAW6y7vIfx?=
 =?us-ascii?Q?sa1qFg6KU4UzsbCbQk49CAsrGSIr3FLqJ89WGdJAcZ1SFuoxFjXHhapM7xnb?=
 =?us-ascii?Q?3/XwDPKbK/ePu223Au32nLoscRsI4GS6dHH+YFPGGlHzkyF5L3EOeNOGvLPS?=
 =?us-ascii?Q?Sma3GbRdCBPJjZeflfHCl8A+lrSGZqVvPrm6ga7JiNsFcdrGPegd4C7cMsxF?=
 =?us-ascii?Q?irOW45468ZhhFQDXPqq3SkoHNtWUIh1JtaJaljYwYHjZnjacxq8R5WpX10Ua?=
 =?us-ascii?Q?VsMEu8wZExC5UHuNtOULlbO+5FA1vYEPrXZ58NUPHg9MGy62EAuEAfIFLhsK?=
 =?us-ascii?Q?7YEtVG/S28mvbfp8KBq5ZGvv6T9t72RHhIYkjA1HUZ379jA2meLwSAEonBU+?=
 =?us-ascii?Q?GduKVs8bwUIBAZB8L1eqg8yENSRK2pSZ0t1grfcGs67bRPQLfvC1jzgM2/2p?=
 =?us-ascii?Q?vvWg/DlV0TiduitrDi779/a/Fa09R0qSKRtxn5qp8dZku1Xz48zxkqGOQcrC?=
 =?us-ascii?Q?37vFCvZ0FDDF5TGy2S/44RcqGSe30LCjNgg4jfIc6+T7mk6Ddn4tooY9EmrH?=
 =?us-ascii?Q?8tgej/cgPL1hGiXo8e0p3ok4SgUYDT47EgYQF7T22gTF8/s173MCn9hxRDLk?=
 =?us-ascii?Q?NVvijc4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:46:00.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581c0e8b-5289-4701-910a-08dce814e435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

update smu header for sdma soft reset.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41cb681927e2..147bfb12fd75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -93,7 +93,8 @@
 #define PPSMC_MSG_SelectPLPDMode                    0x40
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SelectPstatePolicy                0x44
-#define PPSMC_Message_Count                         0x45
+#define PPSMC_MSG_ResetSDMA                         0x4D
+#define PPSMC_Message_Count                         0x4E
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.25.1

