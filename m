Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49414C10F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 02:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A1610E2E0;
	Fri, 10 May 2024 02:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWhG+oGc";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08D510E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 02:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1ZRQTPi9anOixviMjcOVyjly7huz19aSi/sYuCsg1603qbcOWQyGgfUdpkygbQN9EjbFN7i+z+GknDX2/ADjJdDaRUuuODJMZV5AT7uJawCJwptXYqNdWr8WN1SGFpSUNu1jLJdXiqi+S38D4nUxwtjIOqhJbIvoiIvEgP/Qee5tBeWkXFTCzGEabDONheGKaDjoLdWdB9TRpYxRWCgKlbBdM2XBoKeaUoPo8iGN3E623Dx0/0SQaZdNdoEodxbI7Og46qyoCHvKo+ozpmDkujNj2PPs+xr7gJsuHdH0V/U1w4iQ6qqlBuqMI4PWtCeXBzQraJEJHp8HOV7keouBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmygyJYHslpVbAZRaZ2D5wy2POp217/Wy39d3Y69kL4=;
 b=TzTQsnAYXyGmBnTCpdk9jw6Iab4uxPNThVkWRtrDHhjt2tGEeoKDc6b1siPMXYuHJVGxowLM8fCOfPhoJtKcqW2QdbgwFq4fUVKrdMsRsmXkjHgRkKhKVax4aIOLY9vyU76fUeQuhMteIyV+JWyKo2P+oCilftMGccDBP8F3P8vA1CQL4kSDOAQQZ6H6Y5ZFXAkAeq9OlB9Celg3CmWN5ptrKu1MmPZ1IXQuCzg3bFCexcZIXONXrmgPFWnu9OI4+KXd+ZP+Mi8X+SJE7ghrbYRijB05VPpU1GotUK59rb3HMSFmyVZmTBjzaOka690l7mjZrAB47yarPsxGAwHulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmygyJYHslpVbAZRaZ2D5wy2POp217/Wy39d3Y69kL4=;
 b=yWhG+oGc70ybrp/6BTJaMa6f7vZqYFzc96nyAzhXGFUctKXo4EsGzurFpVSVDdQQ59JcS1bwLH2XIWnJMaBJo0Zv3+2DLZnrUGIiUh2aUEE/dPMf4dEh0gUL63qEf6va3ecuPna8FvsvW9MNKs9KbMVm39eJHAtqRnlYckpdejc=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Fri, 10 May 2024 02:54:33 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::4f) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 02:54:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 02:54:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 21:54:32 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 9 May 2024 21:54:25 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 20/22] drm/amd/pm: fix get dpm level count for smu13
Date: Fri, 10 May 2024 10:50:36 +0800
Message-ID: <20240510025038.3488381-20-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510025038.3488381-1-jesse.zhang@amd.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9bfead-0c0b-4576-c9ef-08dc709c84fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FC72W22mVBPo4A+2elZnZjOjzzx1T7RchAoL86IiU2G097qT+hirgUzNVkzb?=
 =?us-ascii?Q?eGcGpLF4Tcyq/LavBBHix6A6IVdZWbX7VFy1Oh05ZFYIWa4ihyV087/3IsOv?=
 =?us-ascii?Q?8p9XedD2rwivFZqr5UzBDqhMoOtP65liqYr/BeZMTu2YVxynPq9ULFEdhFBP?=
 =?us-ascii?Q?Vgiff+pvfLKwepdPzXcbN6r/M/fJ0nY7V63Gb9IhzG0ghLvavZmrpqanzydB?=
 =?us-ascii?Q?NehDGSqyd5uRQi7ZRuIvBgwYC0EAaZBuN73vNs+o4TJlVH0roiBuoxiHFMhF?=
 =?us-ascii?Q?PkUI2/IwXT9MuyiwH1zCce4N5aN8PbMuQLgjEhG8roxR3F2Fa73F+rVxPeiq?=
 =?us-ascii?Q?xY5aQe+KBn8obH7VfcOEjkVGMr3GlWKc/Q6wakxkci3/QpvicSLUI9ysrwGb?=
 =?us-ascii?Q?SOzAa+FFLLXvaOYIftGOf0HmubZX3+EdfPpnsM/OR2smMqch0YKWT7jNAka6?=
 =?us-ascii?Q?gbFvfDbeIRV3dfQOLZDbTqvsHZg9uM9ltMl/MhvZqR29nM4fiKxPltVx9p3m?=
 =?us-ascii?Q?dMr9Ku3PAZQv11W+Wu1OX1l/dsw29dcy+5jYH6zhNNbP42ZzZ5tAl7+IoqJv?=
 =?us-ascii?Q?ODLZjRwyyzB9x4sm1dWCPuUKhLL4JLB7UXHJwrKQYBtGiBWNASHqNQcdv81T?=
 =?us-ascii?Q?S1u8+nJOyOpgZdhQwo/WahEW2m/X6Ok7XwFo0MtTVnYAJuOvA3kAtOqAwMyx?=
 =?us-ascii?Q?uyCozkGDrAsI/YTQIU9VGyInx35w3Z3I025Bs8TOyEgvNnZA8dSR6qUCzUVR?=
 =?us-ascii?Q?WHsjfwKr22G9k1N/pY1UU2q9tlxIpTMXdWKkpIfntipt0GQ4vx2VbgKxtPkg?=
 =?us-ascii?Q?B1rVEGBEL+8zH2NbbfBZ2+zB/1so9b81ofNOR7/Cx4emA3kMIop9i86tFtEI?=
 =?us-ascii?Q?9lcBf6V5BJW91N2F6gbPiJ9WaF97Wbd2rIOmG4Uw0S/T0Nxjk4px6jFG6TY4?=
 =?us-ascii?Q?vTWLD4G9QGyOIhLb+mcs85MrK09YB6uns3T7OG+cmWngc0bPwNzvU+pMDtZP?=
 =?us-ascii?Q?nQoKrkxwOnccRb20uqK0fU0G+EgBdIPPwEMOCs14ycr3V1U2XXOTMSvtOkRW?=
 =?us-ascii?Q?oGHx+qQRmsAJDUMT/+EZRcyLrGqD+jGgTvJKBDUu7buf8PZ4OPia+lzRRAx0?=
 =?us-ascii?Q?7hwY7tJHRkcepKHHxtj6uflSqWJ2QXrwecP6YtTSo7/dl5nLaMzRjqEfTSTu?=
 =?us-ascii?Q?z6/hRapknwrJVdPhYs0rZ1GvNtk+Kqq8BcRqj+XoW2VQ91g6Pu1qa/SexIAh?=
 =?us-ascii?Q?UKTxLMi0eFvU8B94/iiautfK7LtAEHxN0ivFEEl/n/34YsYZkAWKIgo4qDIi?=
 =?us-ascii?Q?/gTjC1fdzSMXFMbTpGwEnqVpEF873RHmVwHCS4u29CO3kKJo98ILdEvG7w3c?=
 =?us-ascii?Q?585Ug2II770F6TdQiQUGtOvpFt2v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 02:54:32.7486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9bfead-0c0b-4576-c9ef-08dc709c84fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

For invalid clk types, return -EINVAL to check the return.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 59854465d711..9c2c43bfed0b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -643,7 +643,7 @@ static int smu_v13_0_5_get_dpm_level_count(struct smu_context *smu,
 		*count = clk_table->NumDfPstatesEnabled;
 		break;
 	default:
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.25.1

