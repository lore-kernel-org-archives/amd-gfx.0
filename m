Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67013CA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A3710E570;
	Mon, 25 Aug 2025 21:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5G6rVhqQ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C18710E568
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss8gD0H4FprTOm5yZFYhxatz/QcBdXUiN7RbIqU4yHNtquwNR8zqwMQvhZHgmmMcZuiimPnHyGCrJEfRGQxuU+u4XSjPba9P09pRhFnjHQn/3CYMxrsUVhTxT1ch/ZCxJrm2i2YfrszD3GCWnVhGPUkK5XqMUCh2iKibZFvd9FhrBPp14rPFI55uZL+VwubUtjDHXmEEdXwY2lQeev2J3cbjPrbhYEhoUonUYMa2iOS4jZYSxTF7YXzdhRCtYcQyyAF6UmLQ1etOKwQCS8L3bCTIYp2iDa7c79mBm4IiXpaDvHWGLGoVGmnV8P5Wm6WSPK5t+8DMK/sSC2AoO/MalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aqZnmZO6PEHjKQ0cafO76dLf+IvnxZYAmMcuYM90F0=;
 b=DyHhqaX7IiFb6RHRvnOnf8hRLcT/WiGBKUQz77xE6DCiSsOZJO25GuH/AsiXD/HgyoriXhKNjhj80/yBCRuwwSpJX/7LzfSwzzfcqz6fAWqrtqcM3nEWsd9EpDV3f8xzr7BghRzU51qGHwOHS1Ha7kUE6aIKaFAujqC1ugxIVXVn0RwqzBjyQJGXQmPxSWmPbHrxrugoicaVoKQ/f1bqJXi4D3O9YfBvXAYUlLDoqrq8tQLiKLLBWzrHxampJ1lQk2rQ2lrWWsyWuSwyP8X5DtNsk2W423UBbxVu1SIQPNfRbEjtJ6ew4rI9aQBpyUKCDa5kHPzbopo5VaijTrGK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aqZnmZO6PEHjKQ0cafO76dLf+IvnxZYAmMcuYM90F0=;
 b=5G6rVhqQiok4yTQO6ZWsZRrtRsVSaLYDgOeSFCFB+gDKukbBcKd6gQ+Pmo6eZn/OiY9YlIyOHE5qhophq16NIpoQAupH1Jss0pq8+fGnwt0YCvebyBeJrzFswAIVZnhdQ5YqDtqAxTu2hO8GlK1iH7nCnGgEYmQ1TFcSYs3LCKk=
Received: from BN9PR03CA0147.namprd03.prod.outlook.com (2603:10b6:408:fe::32)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 21:01:25 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::c0) by BN9PR03CA0147.outlook.office365.com
 (2603:10b6:408:fe::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 21:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 21:01:24 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Aug 2025 16:01:24 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/vcn: remove unused code in vcn_v4_0.c
Date: Mon, 25 Aug 2025 17:01:12 -0400
Message-ID: <20250825210113.182727-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825210113.182727-1-David.Wu3@amd.com>
References: <20250825210113.182727-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7aa289-0695-438d-52f4-08dde41a8d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2RvIRrGQ9JtwKC+pVywl71MdyheMv0SsnbcwRs7W1+MhgEzLZv1pWu46EBO0?=
 =?us-ascii?Q?dX+L+eK4teZOuk6qJcNcUzn9nugTX5KTcGvYYI1e7JlzFl9zeu+rh6lGSwJX?=
 =?us-ascii?Q?2oZVXRyDx0JZduNJOOCex9t7lGdx812QLVJ29ZCazP5ggoXqxywsVqx4eisC?=
 =?us-ascii?Q?JCHUNwnA6Ob3fKloVaD8c9/a+cDmIfEpe++/1dZiWSXF3hmXM/aovYcRAf+2?=
 =?us-ascii?Q?sy2mMZs1jI1RjKMvJAGEjZNuEAkzGbk9Dz33N9sfK+XzD6Kb/oMbAM6FHSiJ?=
 =?us-ascii?Q?3kM4NpIElWrMHhHIo2KbY3xnOlwJkXhVMN8O8FukK/VfJxv7UuBYERVh4WhH?=
 =?us-ascii?Q?iwdFU9hb4ZR4ESoN4K6SiywMsI6WHTpDtTvLSbk7VyY9m9HWxfsL4husccyz?=
 =?us-ascii?Q?pUDsOv+7WOzGKDXcWVeZAd5huM9bJ+Tq8PtKJkUjad/OSUgw9JDcMOIhC6yY?=
 =?us-ascii?Q?YgTHFo8Mv2BoaDGy87bHLX/o6ZE7ALReWJUZA+sLicYRygyl9gErc1T3SoZ4?=
 =?us-ascii?Q?GdqtQezVJKxxABVieeaW4tXWGklhO9X+xtHZTJh1tzeYDVbP/q1G8gQmo9am?=
 =?us-ascii?Q?0fcjUNngQwBgxBvP6pwmbjv9aFTCaZaa6d3uRTZiCS4Y5BPbzB4O7ybwB+Ue?=
 =?us-ascii?Q?HVDAQn+5zleMzR/thRORS6WHn0UyObwWdjW2FH3Rf1CVj0ef454D2U59mBj+?=
 =?us-ascii?Q?yYEwC0AojY/1QzovapXo/JDmdyUjvpddDA1M0jZfcAjSYYy5t4e0N9TxDKhT?=
 =?us-ascii?Q?CGDJcaang0UFURui3SXOI3nsCJ1hAy3rhO7bi5hSbFrrEmi3rpevXuwUsslr?=
 =?us-ascii?Q?5SM/wT2H1xVN/1ZW4brZNzuahuBKkmITIlVZa5jJb7Y/agFUU1lYd9E/Lpmc?=
 =?us-ascii?Q?WzVvSIVw5MPTZF1762QrWpzKGiIvObR9xu19Q971j7mkbsc2nx888TByAHBn?=
 =?us-ascii?Q?fz0zeG7ip2bzoOCHNqjAtum33XI3DYMAVA22IyhuWsU7xKbxHPI50FNzDLNZ?=
 =?us-ascii?Q?E+U9RZqQjEwp7dQVUtstvv3chKchZkJweRbc/wZAylVebnpNNNyxducZBl2A?=
 =?us-ascii?Q?cFV67edC3uZtDROhlanyGrlVpfD3y4sWeehbdgzqRyaYqh7NMovm2XSVfFG+?=
 =?us-ascii?Q?QHwZgIafDAjZWl9wPg1HNE6W4e+Kg1KBby2OeNne86lOd3D2A07Unm/S7qAV?=
 =?us-ascii?Q?f3dI525QN+ruyfhQekRmN4vGXTFUqVu6V1FLmhjVeX1PgqzObJKIRJ4c1MLt?=
 =?us-ascii?Q?lTv2Yv4kklSbkl2p9Pl3/OBIc8KZW6gtIWg+eAih95/8fNOc2rCXdzTrWk3E?=
 =?us-ascii?Q?G+eVgvqBu+c0yGMdspSLUGzcsLTeCdXgLv7xeGhikawtH10Ef2sq39H7vmhX?=
 =?us-ascii?Q?0RPNifLrs9wNb5CtPV3m+1We7NfyD2W0hUKId9cxBCzo1kMPFInp75W/YNlC?=
 =?us-ascii?Q?OY8AykqJP3pB5odBqekRhs+59uULBOAARlywwF2SgEH8r8W4ZgI4qsXGn3JD?=
 =?us-ascii?Q?xfDnbJmHHKNx3geJQkT9U7tviYU6xuJPvlvl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 21:01:24.4025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7aa289-0695-438d-52f4-08dde41a8d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
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

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1785786a72f8e..d0d27790b73b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1621,7 +1621,6 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
 		vcn_v4_0_stop_dpg_mode(vinst);
-		r = 0;
 		goto done;
 	}
 
-- 
2.43.0

