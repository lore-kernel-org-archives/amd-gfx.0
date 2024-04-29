Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4A2C41513
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7594810E962;
	Mon, 29 Apr 2024 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vp3qJ2gn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246EA10E962
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVTe+5Q/S0LOzUyibO3QmqPzcUctkX/VSRViN/qpYaDeMVLODLIE1SFXM+NEQw5h2Cc2IApSrLDxX5toQ82VJrz1mYP9RMpolJLhZx8/Nx0X/BRtgLTwG3265yO+SQfPYNXrBKnyuG747NyjuBpGgmqqopY7uOdFPHbMeCIWumjWRfhNBiflSmF4QCIY8MVYS99a2KIRwGvcDt17QUKhYHgZEfYPtIpB8aEM5tlHpEPM2Y/aKJFxudeFrThzWjoj+nM1XqxWC8NocDWBIpprLftaX8xUjot5YCmHn8jvm/WC1E+Nsqwr5WfxlLUU803Zvr+I89JVxQWvp41zYu+d6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oigNbtcLTiAD1IGJJUlYI/oSEjMSDe+/4EAbv9+gpOg=;
 b=K05M43hO5rXgUtKqW67Z6TxBRRhH+O5+dYKjX6CkndiEan92R0DS3tTYdey+6ths6qtnyx7WcXoJIQuhbFH3MisYc+A61KP88rYSS5FW+QLN22IZ+F3Jq/ZZUEfY5JobHSop3iew3dZFiubeDFSkjWYys52M0zrUy0sDAKpsW70qu0hmrlKa3Zk5Sy15wnXHwrBsg0sTATiU3XmthDJ0SOYp3JUgOgkwu9Qmty4qaWm6tyTRv8fCDBNMh/LavLyt0uIkpg/fDRj7fPVsAI68eqnJFsZ/m3Hj3VcNnnz5k0T6UZ46PtoAE130tzVXFYDKLtVvdwIkBKdvA9+PJbq6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oigNbtcLTiAD1IGJJUlYI/oSEjMSDe+/4EAbv9+gpOg=;
 b=vp3qJ2gnLbCWD6WqWJIYye0diqUmis6UYbnSulZDx6XSSNA3TyPd2ZX0RiD5cHnJdLmcbKch6hLD9hKy4iM9GLuqO2XuTgd7f+arjd24K1JfNFX2oTxjf9GfxSb+LbJhbVzouRUfXGwH3uZA4aqf+F0TKB4tqPvH8iMB6CXLRiE=
Received: from BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:15 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::e2) by BYAPR06CA0021.outlook.office365.com
 (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 13/31] drm/amdgpu/mes12: update data cache boundary
Date: Mon, 29 Apr 2024 10:33:21 -0400
Message-ID: <20240429143339.3450256-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bb863e-929f-4554-ec6c-08dc6859718a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZwzJU5rAw5j/9IR/bATZiI2W5NlnXOPRlQR2xGvKxWIcCio6hpFBT8Dt+I1L?=
 =?us-ascii?Q?2H0B8EtK8NaJNTxxdvKUkaEu+RsMqjGYstEgUj0T4p8PbuULAVq3TAB/V86b?=
 =?us-ascii?Q?oA8JtHFJrelFfvZtnkONzNajZ4Slp3T3J4XJyfXdfE6ivfJ/c5yg4cwDruvN?=
 =?us-ascii?Q?PuU/SGs1yJBH/XQTA5963N44MnbSHu7Rj7Ji+SHBqu4hJhBeBbATrliyjTbe?=
 =?us-ascii?Q?KwuWPZvyjO4+MPnniLvl+wLr6AXWH9D0R82Wq1hrQbcNUHEtOUsl33TK1irK?=
 =?us-ascii?Q?/h7EOEDUKvxpAYavExr933KSq0oshqXxfWKgQU/NQAwlvzOlnUw07xUfUuwn?=
 =?us-ascii?Q?8acCidVvE3WIfxL8Z2Tk0g4KlVVrX8tlnCGD7GZkvW3mIVE1nB6OEJxYjEXc?=
 =?us-ascii?Q?Wktubu2mxNf8+AbClkRKxE1hdKo5LlzzpOFsRtWmmn0iv/XwUlvVQNxGsOat?=
 =?us-ascii?Q?7OTWbjlnN3wyRTDO7GaDn5II9NZoAWm6ZTdGDYYiD9YVbaKzGIPhd2wFEP9Q?=
 =?us-ascii?Q?4JYXnS8t0aunBxjEqWbC9OHGavP/2R1Vwfc7uH0+ucj2n9ya+ZRkCPJWiQX7?=
 =?us-ascii?Q?+tSMf13hG8em8a/PllOsY5B7CWjgorhHNZhPse2p+qXPXCR+2Q38UedawRVJ?=
 =?us-ascii?Q?cgi/2Tk0xEJ+PIqAHEZO/cS8IvPySnV2ATKRJTlNTP+doFYXTtRwFokfVZ/A?=
 =?us-ascii?Q?h4yBsaPwie411XJeUI1xPs3PrKgqqWnuLtI9FiVJOeSFbgI52Z7ZYlFHLYG4?=
 =?us-ascii?Q?w8Sei3xRGDr0+SehQ+is6XZArqjHXqwjCBylca03HDxuBaSYnvNhT1rMeNgX?=
 =?us-ascii?Q?PjUzftAN88m3l7S1mof31NJ35MWJnL45yM02yyUxO/L+l8Ysq3Tge47XKLzL?=
 =?us-ascii?Q?cO/zwgJ1iAWU7xKqf2dU2NJMiaIX7fE2SPV29Tx8zG+zE5GFL6coIGxHuyE+?=
 =?us-ascii?Q?EWgJBPLplv6ZZt6RgdBTM6vJ4fL43m1Gn7qRwg2DjYS2sqcZQW/s/ZXrRVh4?=
 =?us-ascii?Q?GdSjncR+Is69ZvV2ahXqg1Ksvc/Q0Ioe3V9shq1lvJsXeKhAwDaz3P0As3BY?=
 =?us-ascii?Q?sdhbCHQORIrrge4aaxlerl3Lc+T+16YJRdUbBvYy22R+/5cS+sysMJi9tKCB?=
 =?us-ascii?Q?Krw3x3cPdSg307x0VdI7rlIiSTi87fIuA0B66NPEtr6tEYFnuSk0Z9cqJ2XR?=
 =?us-ascii?Q?qJtR4eyCHAuO1+gn4FD8ril7mATDuUevzJGrSnya/wv81bmGU5KvI1xbRF/Q?=
 =?us-ascii?Q?CPd7v53ZSCdD8A4CJYXPcVCRA73dL0B/MXM6IC1Lj85hhQS8ArP+0q/K/FE2?=
 =?us-ascii?Q?lu7kTO/rZ8hQmiJurgfpR9kxEInPPUbXeG6AZ9oEY/KTaGXL79i9d1vr71Fw?=
 =?us-ascii?Q?OfrtXOGTJL/3Bj/exOuxQyzYvEjU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:14.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bb863e-929f-4554-ec6c-08dc6859718a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

From: Jack Xiao <Jack.Xiao@amd.com>

Enlarge the data cache boundary.

v2: use the fix data cache boundary.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 8ab85e6231922..2d713e7b976aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -685,8 +685,8 @@ static int mes_v12_0_load_microcode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, regCP_MES_MDBASE_HI,
 		     upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
 
-	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
-	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
+	/* Set data cache boundary CP_MES_MDBOUND_LO */
+	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x7FFFF);
 
 	if (prime_icache) {
 		/* invalidate ICACHE */
-- 
2.44.0

