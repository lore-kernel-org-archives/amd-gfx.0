Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20769D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C378710E95F;
	Fri,  8 Nov 2024 11:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39oqNuHU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ADA10E21C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlizNFT0DiaX8gm/GkzYImqn5Ka+Ol3P7V1tmxNCImQRpAChd12QXPDWjx3RoVPodaXBRpGIdAQvB6+IFx7do8Bq9ZrnVwHc42gAEEGoGt6JTWeb0gocfNbFcUUCD4ommOZwNMpPXQtcJv1LDf9c525fM/3ZpOrWDl4SX4ybuf79CG70GHAg8zhgFV6w4VSa0N2nRwCKxfe02yzYwhlnE8Srkcx8qyzKXf189kPqe7auIKi2ltBPHffhwr98B6WGr5zu5O77Usd9YpWJQ2kY8YeK01wv8qePxEHoFF0xK748NXkELehljLTB5MSP5lvV655McSeMSRn9ZTj4J8e4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaxDV+Op5HWBTRIfz7Z58VQ0r93PrJ8/bGJpR0GvV+M=;
 b=qFXfCmRfqxm2bVQfnm3F2drm/FaoxUD0fEhg95ySWQBUnKyAFbhhgCwgWr5klyC3VMQ7ZWlO3KmVhBN0/zC6QXRlztYWD2TQjcvJ5YxibwcnXbRk9PnATnWW2WYMGMHMaTvlURe2iGDjSOkBAurRM/BJ2S6fcM/OU8KxjTTNNY76Bd156iXkIj92EbIGtloxOsHagciUw4K4bGoL+HqxNKhymQyihs8eyAHGO4cFqO7cc/KQXyxrqdlv39vvB/9e4gv3DOSt8WFjX0wiw+TT7n5D4wqz9n/zxmbgJkHsY8hChCswocWK5909ZCw7RmKJ3hYK5vk3FD1U2wUEKyhQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaxDV+Op5HWBTRIfz7Z58VQ0r93PrJ8/bGJpR0GvV+M=;
 b=39oqNuHU0+I0MxKrlGMpELVq04PBnprkqpRyGIN/EoizRCXJRd5QYjfEHAHLUoeE4B0FNbmR3MTm3UPzHavunCOqhorkVZ1K6Blze/sxJK4TKk3IbPS7aMvRAW8FMxroj5xwnMlfm4iPhFecTT3shhRhIDdKK/YURyIPtB+gAfs=
Received: from BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 11:14:40 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::38) by BL0PR05CA0004.outlook.office365.com
 (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:40 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:38 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 07/23] drm/amdgpu: reduce memory usage for
 umc_lookup_bad_pages_in_a_row
Date: Fri, 8 Nov 2024 19:14:07 +0800
Message-ID: <20241108111423.60169-7-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 20118a2d-b2a8-4d1c-7640-08dcffe68a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gl9AKIiC+3rU3DXzLzPpsoMTfUhAnRtlkOpH6EZv+qra4oT3h5wCTzlBLGwk?=
 =?us-ascii?Q?L1j17kGGXGbG/8CDjZ/flXYTV/6a1S0TXIOFCJ+5J8ZPk4dGpkVbUb1CdJi9?=
 =?us-ascii?Q?zQ3fcQ52UoGhFa6tvpvoyf2T/yBziy38xxIdl4/1Q3HBiRzQk0C6uwCdvyyD?=
 =?us-ascii?Q?H9mcx10EDrlUjoDCShsAViFzbsPbGr1K50GlhPMp4jB/K/pWGPfkv7QBxiqd?=
 =?us-ascii?Q?DBeAmE/HhT8hm1HaiZt/YsnSMf/PFNfV4CYBPahvjDyY4kMRdnufeO0Yhkol?=
 =?us-ascii?Q?8x2wfRgt28tx2nKCfTMbrie7kiGjj83fSQ+3b0KJ5o1yjE5QTYEIrDfaGXW+?=
 =?us-ascii?Q?Lm8WA8huAm35sXF9xS5YS1kZQtWLfS2XViJaE9dGN7wda4t94Xh0F35W6Zxc?=
 =?us-ascii?Q?m+7BZ8KJeu1p70kSu2CEV1rfHvcb2+Z/7lUs9WiHZbw7LmTtaZzFC+lMsytx?=
 =?us-ascii?Q?Ky9q2CTY5p38R6OOYyfHctbHxLNhvR1Th2GG6CDyU3vy77owSKCzBbUxldTT?=
 =?us-ascii?Q?uOLSS4/eo6Qte4VQn5tyAyv01oLHX05xp4XAP3ONoL+tIf/f9WXkPEf/xTmm?=
 =?us-ascii?Q?dXq/DE+1N2BPXzYVtXQCMQg6LDhMlpsW/sJv4hKdb8ZhABC4JHhNe7KPyJ/Z?=
 =?us-ascii?Q?5zdUqPlQGqfBdojw0nf8axMroVC8yqii3+23I6fYrPYX5QKHhM+PTrgNRDII?=
 =?us-ascii?Q?Fb/SDyPTZDF9Vlpo1zadNOZfBLX7W9C5D7m2aB2cMDL185KbfnScNMzrQ7LR?=
 =?us-ascii?Q?Gd8TQ17dFqzePXg55c5fOjagntcFqDJHjietMaz3y0Dymlzv8Z9DNcplApsy?=
 =?us-ascii?Q?rHPAkQAcDfQ9i/58iG4SjVpUFSlgjZZ0cTO+eaSou3jMnR94vHKr9N9Mq6UV?=
 =?us-ascii?Q?RDzyystCrnfMcWK75Htfo5w42foLqDWCp27KQKvMEUBEmmpZA4zjTlESGfaR?=
 =?us-ascii?Q?KpIaOYp4oPpitrxt+TT1AWJrj1KHVS1xsAmXhFpF6YyJJ68+/9Wk7ItliNII?=
 =?us-ascii?Q?cRpTkVhZt1945VJDve2+8rHWEvhgzON9NlHbk9OfzuED305jMHE8XEQeW+ao?=
 =?us-ascii?Q?fYwIyInc4o1EK7O/QXuJZfGrjczlNnCWyFIiL+L/WJ4BavWriCapzEWEqBqI?=
 =?us-ascii?Q?UncalluTxw34zkY6rmeSow3QRbdSZPMXyObttVhyzZAGGaaj6gG+2lgf0QYV?=
 =?us-ascii?Q?vAakTY4LOXm2q61ovhAU7p1Dn4a9aEEj9qHLupGvMKQIFPA1FWH2kPgr3uJ2?=
 =?us-ascii?Q?hWDmGHKOpCBobhQbwfQ8c/lXzmtTTDbUOL/MJtP8y5JTDHwH8u808/ezfxGK?=
 =?us-ascii?Q?3vOjirI1XOWbZjjgqFm3q6tgxSut8T4jahOkFJkSy58w+lvOJiTlAQAvOG43?=
 =?us-ascii?Q?v+dlM9nHYFzSIls90g30Xvp3NBu3AG7CclZq+J+u6VUSa9Wz5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:40.2423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20118a2d-b2a8-4d1c-7640-08dcffe68a09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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

The function handles one page in one time, allocating umc.retire_unit
bad page records is enough.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 75ded3904ee7..c0433e6471f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -454,7 +454,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	struct ras_err_data err_data;
 
 	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+		kcalloc(adev->umc.retire_unit,
 				sizeof(struct eeprom_table_record), GFP_KERNEL);
 	if(!err_data.err_addr) {
 		dev_warn(adev->dev, "Failed to alloc memory in "
@@ -470,7 +470,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 	else
 		goto out;
 
-	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
+	for (i = 0; i < adev->umc.retire_unit; i++) {
 		if (pos >= len)
 			goto out;
 
-- 
2.34.1

