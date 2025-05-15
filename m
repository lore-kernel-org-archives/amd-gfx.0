Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8655C3ABC9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 16:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943DD10E918;
	Thu, 15 May 2025 16:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c42uxX5a";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C83D10E910
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 16:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7ZbXx5t5/i4L0rzroTW9jbvh7J8x/CncbMOfllhKN+MW3RrkpWLxRJNCuuc7BKt5/ZN8P0VRt3ZTghcVM7F/sZjl9l/YaVsuAVlbbv0E/HjYSAWT4BmKI9fT8g2yUvWVdnfOxvzqjkb34jsejslvErizdgvdbJpiiOKBDbEQULLUWE+xvxI4MfMVG/FCFtW6GZaJmjZEe/WterLIA3vhNsRsxRa0LldMDvo9CQ17ckRW8Eq/vTY8dYSbrIXoAXaTRdFE9m3G2ScdoVkG3BdAxvpqHqrvRfTM4jq4n9icZ25rEQ82+YHARfsomyvaeHf4MecdoYT2te/ytZ5fd7zeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhCSP+Jti6XDN28kcqWELdzjK2CzsKR5VKr/zbh0j3E=;
 b=JafOMy0FZ6VGrwQ/zTXhkwRsiCSoP+F4Pb3sXNWeohF02gaKkg/QZyRItyRzIO8Bq2pDD60rKmdQPojXoD98pD3FYtWCxEkXjkzBbmKdccB+ev9ogi6DSbMTBc3l8PU3uOEm8r6nuWKonnWnjLzJ6HsQ3ReyIy0gXQZfUUPqKOUMYpm11AD0oD2OGksu4V1tZ8iNd75WqCOwwIJer9RQEGFdk+/tyDQdB1kBZsWjWWcBnBex9v6pQco0r6BNGA6Wry4F+1gli1+YOXOrykSJqAA8uwawNYC0wVw0rFmQ+M2pupX349scPrDQ4OPKl1rjONo/jZq2RZg4jVRSaeAS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhCSP+Jti6XDN28kcqWELdzjK2CzsKR5VKr/zbh0j3E=;
 b=c42uxX5aQ4ddhwHT/UzgJRl7u0f9vFIUH7eLydRk2+SgpGGtO3MlBd6PB/iQCY7Uyhn1mqv1ZBYbCKsX5wL0no14rDg8B1CwpLUv1jYuxTZzYGc3QQcpC7GqO0LSgo7gv14WwwEzBL26lI83Dg803RI6LJCwcCGrsZRAkW80XTY=
Received: from MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 16:41:22 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::56) by MN2PR07CA0005.outlook.office365.com
 (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 16:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 16:41:22 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 May 2025 11:41:20 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v2 9/9] drm/amdgpu: read back register after written
Date: Thu, 15 May 2025 12:41:02 -0400
Message-ID: <20250515164102.808954-9-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250515164102.808954-1-David.Wu3@amd.com>
References: <20250515164102.808954-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba1c1e3-5b12-4410-96ca-08dd93cf536d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rOfk9eR4OmbfZz/IDxMTv8Sg0+LVSuMzhHPlYQsW6jFUX99FTH7X7E5RC2Q?=
 =?us-ascii?Q?E59M4hh9nQoIeiYx4eUhX6Is+X/EogR0QQR0v0FmrAxBkOpvs9CGr8c7hchQ?=
 =?us-ascii?Q?6XsMYrKtSIuYp8/712sS6JkGrTsg7BgiEg/eKeYuB/Mlhcehjos2l0aNSY9w?=
 =?us-ascii?Q?AF5iqdkkhX2uGo5YX08icIo8YuIs3qSHsaeof3YL2bujTgEnfEb29Gz9unN7?=
 =?us-ascii?Q?ScGVL20uYwMQ9bSuTE+WHIjk9/tqBRcciQ94voBk7bjoJJDuuxlJY7R3GD7G?=
 =?us-ascii?Q?KPAf0g6z0ZPgh3zA/6h6uWPGon5awb8mDP6VXerYJn0SOBK1Brk9w5ncj1zk?=
 =?us-ascii?Q?/+Z5jGL69Uf93005QTnSRP3K5Qh6K5bBwYxiAmiQdEJ9Us0FRfaqW/BFTkIR?=
 =?us-ascii?Q?NuJWPBtd9FcuLhLw9HLLtUXsdTBjRlyaKWpn0na3o6Zalg1dKJaOr90u/CNy?=
 =?us-ascii?Q?ZQFU1R+HN3i+PZFys8/kXagsWNp5oLwMbovIZ08demy2RnoVm6xEN8wVDHeW?=
 =?us-ascii?Q?6/SMuaz718MpCDw0Kk6nhy3pISPpDnEWHwPTeT1Um982V36VofCJ16av9oBQ?=
 =?us-ascii?Q?2Q81B1XnpGRNDB6YjWzEd/GpZrhkiSZncxioyDnCqTpBxC7w/Z3tht4Cgk4s?=
 =?us-ascii?Q?WPI6XEQg+96t1AEKRsfnYPIHB1OPN903hjzQ1B9W/CnZTfsvMsNWGvITs03x?=
 =?us-ascii?Q?mxXE0hXXIUwSe1thjm362iK/NrjSpR6nr0UAxLz2L4yWDU6DKqIqm7pNeOVK?=
 =?us-ascii?Q?gjnyOyeJ5X5RSHo+pc55bJI9EfU5Rp9RGgc7i+pL+phHL4cXJ8QQifjEXP+i?=
 =?us-ascii?Q?MqqKUzsIn044Hp4WIlW0FOS2C7QxY+elTA3B6RiCiinBnS4VOk1MlDxunseV?=
 =?us-ascii?Q?8re5qrHZip4QF/fx5dO1W1ax3/Tcq3cU5R6z4QMqD1UdZdd/Td35Dv2VGpbA?=
 =?us-ascii?Q?qh7HPukuArr6pioyu4XjKPZIEPAWCwJfqBKPDCBNoayeHo9tzz24p+S1Adwr?=
 =?us-ascii?Q?CwRu7yJDqFtKyh9mv/zk3IQwwZmpB/mlU1Ae+CEFcsuprBYofs4m86/NTKLw?=
 =?us-ascii?Q?YMLnoP6fiwM2J8TM85XD8scYcV5zHknzLVmCtnznzJzi+ptSGr5V89G/CBeL?=
 =?us-ascii?Q?1nbFPfcleF7umAA9W0aMwFWeT18u6G9oOKuza3k1GRIFmRSka6xJKmVzfg4H?=
 =?us-ascii?Q?RO+ZneI5uVXbITtihqakdCaov9gD4EqQZ8uB7F9c49QTIDS1fOj7QanY3PMI?=
 =?us-ascii?Q?Rc8KMbDNKLLW4RmZbLUJWRgXkhwZBaMKFba9iXMD9thy8Q3jY4YT9i5ktJTX?=
 =?us-ascii?Q?HKJgjj+/FvgAAFLSxtEa2ECzPYa+/FxJMIFR1pkpNWCnKbqt6sjcrAL6dsLv?=
 =?us-ascii?Q?WE+SWfUhgPfbznhQJwwsAlSQv9QPCtvO3Nis7qpThxJjpXMtaLWRQe4YZDUG?=
 =?us-ascii?Q?A6pEiw1OQImc3TTXV5qMi0yu5KPGt7HrQ6yaW2GhmWxgI9zFkxLj9i1s6kcP?=
 =?us-ascii?Q?VDytIzkp6OkpqKGZU/UiXiK0MFh3DFPJ+YMH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 16:41:22.3240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba1c1e3-5b12-4410-96ca-08dd93cf536d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508
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

The addition of register read-back in VCN v5.0.1 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..79d36d48a6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
 		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
-	/* Read DB_CTRL to flush the write DB_CTRL command. */
-	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 
 	return 0;
 }
@@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 }
 
 /**
@@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 	/* clear status */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
-- 
2.49.0

