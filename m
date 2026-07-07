Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D64C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C9F10EE24;
	Tue,  7 Jul 2026 15:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HMnxQw2b";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20F910EE24
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOLG84m96uRLFHxTQtHb1B+wgCWY4fcbkDrEIQV++CWs0CnnNvfa118jZaGP392OfGQX2fMpGSphhWg1JPL5tV/2cHAi+IFkxVPKiM5gSaGLIbSF8N5WAik92mEBrnTpmfnZKJ4Wzjx0w4QEOJWLbKtv4RepCOL1gVQJ5on42ikCJsvsdevlSptnIVhUHWYhV88+3C13eCD4I9Iv2BgUfUigxhsXF/JxGsCMAoCdfS6wxed90NQDHjIjGkDTvYFb6DpZ4yMnEOef49Sg2q3OUTJXOREYnQDfQoMlLNNZLcoZEewNhD++iC0R8zWQ6yvumt7IbdDfX1BM/hvoAszatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ysnX7t4Iq4l3MBpy53h+hFIRxN1iobnMTrDpp6KBtE=;
 b=GHri3Xa7qZGGOFucfrg0Uf3egVINy3K7oE8J9LbYh8auKVfJPWURmOzHfR0pKDR/n6576Q8CJJWVYFM++kqlO/9K+GRhkAcLXj8l4kMgEHyOQCsRrWdXTFVEFfRJKzDDAH3RPsaPvFTceseVaFyk1m7nUkD2hXf7u8ootuPZY9X/YYj1mGx4p3N3CKYCSuBaz0cPcrT+Dc3pyQTxH4syxuwpViuc+WFVVuCa6wQd3D7GxzXGSllnLbK+y+DDqIIxxe+rJ6Ol20E6GNdh1Uatrc9YekpaeyWSFkZxvM5wt0STmcIYH1RSL8G+dq+P8xZeUyhKiZSed3Dap08LkVjUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ysnX7t4Iq4l3MBpy53h+hFIRxN1iobnMTrDpp6KBtE=;
 b=HMnxQw2bMCR+UT7N371itFoTDdMfUzCcoDwEDGMMv9qV1XBqH3l6Ajt8UwmG5yMMbNRixrKceUSypgL40Y/W5fsZjVGeJSudKYYZkT3cJew58reB6IBvjzNKbx4pZmaGgcVpOsuprttuhbdCb6DGsG6KAlPrh0u8U5ULQTX8xZc=
Received: from PH1PEPF000132EB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2f)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 15:42:46 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2a01:111:f403:f912::1) by PH1PEPF000132EB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:45 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:42:30 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/30] drm/amdgpu/gfx8: drop all BUG()s
Date: Tue, 7 Jul 2026 11:41:57 -0400
Message-ID: <20260707154203.2603209-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fea7576-007d-4d02-ce1f-08dedc3e6413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bR+CNPA4triYF+xzqH6i2H+bJLbLjxmM1mwDsCHtmEIn3m4gHKxxi97cSnAXAIofGk4HJ/VWN9o9/r+cbz27zTEE5rIhlpPurGbHsjV0fPAKraNVGHhpfgNgLoYj/DFU2H0pnrFTy5Z3Ve5jJA2G/eu9XFXNZxKA1a+BYbS/6ZHqhJQu/IaXAOBFw3hE1BwQ7s+cMKNHx7oCWoh60OA2bwTQuL6v7m5YrVQJon6u2m37byZb8iM/+M6UZuIco3ECb/pVjCXVt/IQjnXM81WMB8f0U7b6ESUqXxNtss2bL2cJsclpivLoyCcj7MhUDCs9fxXcPsZ/fE+RuE/3+IY4bx8WNwQK2fgdpf6m43EQSe/EIpBT6j5gEKlaPPwMs6zfG2EEvVHOo6O3qOVuAl1fZBrGHTcvBMJYJSsxyQYrB1Vh3F2JwD8YUrXg2SUNLp0+gzZK+CQsqlJoK8K6vS5xgGlL1/oKaNH7KxBauElfF3UGIBIwpFJYpEmk1gSTlXoj7JLUB4o6h/5LQSzAegNENyu7/ZIRRkz1dkMsWzWkD1H6ukLQsExzB1K+XRwHHym1UzHH+pdPldBdEYvvkIVF8GNBSjnQ8ks8ofk3B1s5i6DE2ckDojbNAbKx/kRLtCRjxEbh5PcsL92KzWGTqYJu5jmLXd2ZmbBH9tZ/1QJPk0kSzWgqptddqHHXkk3yTVwz4q1VSMNPFYlGPrdgwTZ06w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6DjdipM1p2jLVOsUwXCk6mvBRdBz3zut1/vJFIA0EUtjMsIi/BL2e8Fgbzf8ZvdMEP5E3z3nJbgzsL2kf9KDHudS6mZlk+CuvUUO74XApIM88fwpJiaTvtgj49FB4nWWdpp5KrE/TN3lqSbXbVtAEJ3J6jv7Wq0yycvB3W/kBKezkPKXX1AETicTai0mb+lNN6T0Lx2QfNvEwMmFHLg993vwyM7V9C5U+i++O23IQUexX8mW2XG9wSlaZItVqj+IcQL5WhEUfmS2VMfhmdJLazBTzJjHIdE6RMlIGHUnEPei2uTV2nC7TuUXf6tg9s3WuLC3v85m1TGELXgtvBjRzMeEVp5us2nVAJP7j7OZd+z9Nn83x347yIGPd0tyv/gUR3VqEApSsY+ns2/YyMwD2fxgP9C3DGEUsxra4kSU6S4Aelx7R59cRLw2xJTipWdg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:45.7486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea7576-007d-4d02-ce1f-08dedc3e6413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9e0840df88497..15084c0c98c85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -977,7 +977,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "vegam";
 		break;
 	default:
-		BUG();
+		return -EINVAL;
 	}
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-- 
2.55.0

