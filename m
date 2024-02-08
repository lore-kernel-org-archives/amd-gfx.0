Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99913C4829D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 20:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FF410EC55;
	Thu,  8 Feb 2024 20:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="smoFlIao";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91FE10EC55
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 20:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aG2NnTGdNpgRpRcOy5ZLuCIf7Wj4pY8LJW37hSNK/CbBHUxJQbxMBytkcE1T33gGr8hDHWYAfXf8cgcDSDj74hfszgYG6tbIBFHCpjyUl6c49AZH/8gzfrmQh/ZxQWqEJ4xCqAvnGtsJEkIvVHNh9lVKvBM601kwOAIR/x1TWv+8SzaSYdRR73oTXFWpByZVCLE7MyKraoj7qyrIlCe18+s6Igd4mSzYqGMSaMRniX3Z0ygmrc7SYoYw2qmrVo6j7/3816E6W+3Z0K3nKjpe6iaAWLrQDtCJwfjXnFXmj76rMZ41M7ZSUKGSFvzSdumt7Bo0IWUYFBrN+9+43mjOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUhFCgy8NfQ6LB8dq7Mgyfu+pQFqFlFg1dqFi5x4wNE=;
 b=iqPcciNsI2ZoDJ8hCCDa4FoItjQDBPICRFuJHwTx4/qkKmXjYfFD7BqSViZ9HleNyVeh3dXGvQ/iyzLIHpzmms8RgAiEnFcql8puIQtR0jTnmUp3tSo84oAkM8jC1mAW30bd0G9amxautDj9NvNuLQsi9VgP6lRgfAOyjrUu0XDbuSHNZwKSSEf5+GYv1oqDkKtlr0YDCZfdETRZfBCFK1k1SEhnkaWKTckyiPyN7aOYaRUfKGfq8p1XGTZ4Glm4yddlLuqIk+mGvMf4aPhZXj8eMKvIOZ/gwVtbqch1tLO1GGMdj4HfXrANO/PcBid3C639hWTbAD9f0qxN+gsYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUhFCgy8NfQ6LB8dq7Mgyfu+pQFqFlFg1dqFi5x4wNE=;
 b=smoFlIao2XrwZnRVLZg1JWwuh7ANcLaXCBYZKb1TbVNxqChb+PiZLCX/BF7+6g2X0XiUaETL+D80FwvxLxXz2X7HUM3q7epG2ZHWFY19kp8NZ8cwkGazRiZM56JyMSfbVu6XsgyKH5DbfGr0OwNhR3pGxZ3phDeQDLq4IKyNQUg=
Received: from DS7PR03CA0133.namprd03.prod.outlook.com (2603:10b6:5:3b4::18)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 20:03:10 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::58) by DS7PR03CA0133.outlook.office365.com
 (2603:10b6:5:3b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 20:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Thu, 8 Feb 2024 20:03:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 14:03:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonny.jiang@amd.com>, Leo Liu <leo.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/jpeg5: add power gating support
Date: Thu, 8 Feb 2024 15:02:51 -0500
Message-ID: <20240208200253.409130-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240208200253.409130-1-alexander.deucher@amd.com>
References: <20240208200253.409130-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cef00e-13c9-47f9-49dd-08dc28e0f99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP5MvlMrTn0YUwj8X6CYtgkj6DL5uHr0dcYBUYAd50kEqNUuyQ/6mDrqGmXMK1tFieYG34FjNmAHQi7xAsKX7zyjzsfGe+pnW8czhqw4yyyhTIwUvwAAf+66M+J4q7GSTLkaCgmebsHHHYZgbfRbA9ULL2GuOP2mYLaeqlRLOlBtybJX5ygw3DD3fTvAgVYTzx/iSqG+OlrnSRArTX3Y1UewqbuCdR9OehjXlJyejYh1VsxVRLnwr8Cikk32JX8W9ZbHC7Sz/cHOjhMag6YzZRch+TPv8LmNv3Qpq+289kz+2wij8CQrH+lfFIQYt1b04+J1cwNgS8IMwNwENDSetSeKS6TBbW6NYGGeIBYP6341ENWo7K28SQ5Zs8oq6C/wU5qfxuUxESH47TOTc1RYxv90koTozmaQoz/cpIeUWAHWx9lxeQxJcjIEM2d8FGU5u5hjX/6TfCmwpTP+Kh7ViGSBeEBLiQXIp4+/lC4d5R+zJqANCHixFBS+T98ZMn+gxVL8Hzm4CnerKUwg63BWZT5Hw4TSmGm3FETnpM5QggbEq9s3UqavW2bH0cCOjjTBi/40Y1xG6Qjelyw4QxZbHOtWT7YswD2zat9mmnNQNvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(36840700001)(40470700004)(46966006)(41300700001)(478600001)(426003)(86362001)(36756003)(54906003)(7696005)(316002)(1076003)(81166007)(70586007)(82740400003)(356005)(26005)(2616005)(336012)(6666004)(8676002)(6916009)(5660300002)(16526019)(2906002)(70206006)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:03:10.4581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cef00e-13c9-47f9-49dd-08dc28e0f99f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
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

From: Sonny Jiang <sonny.jiang@amd.com>

Add PG support for JPEG5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index fbc987e299f8..71c28cc06605 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -261,6 +261,14 @@ static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
 		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
 		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
+		WREG32(SOC15_REG_OFFSET(JPEG, 0, regUVD_IPX_DLDO_CONFIG),
+			2 << UVD_IPX_DLDO_CONFIG__ONO1_PWR_CONFIG__SHIFT);
+		SOC15_WAIT_ON_RREG(JPEG, 0, regUVD_IPX_DLDO_STATUS,
+			1 << UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS__SHIFT,
+			UVD_IPX_DLDO_STATUS__ONO1_PWR_STATUS_MASK);
+	}
+
 	return 0;
 }
 
-- 
2.42.0

