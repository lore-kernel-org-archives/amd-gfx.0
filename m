Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AF1CD129C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D5D10FEFF;
	Wed, 10 Apr 2024 21:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xnr9JNL1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A12F10FA91
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnA1C5UpPnVjWeQQlbmOK31KNdzQsEpm4vJpyPJ5tjwB4slyeZ3L9y23mLSvCggzHQG/g/ow9vFUbvYNT7k1C9B+JXbPZtLIV5FUUljRdSW5Roaj0TYk+3DHutv7VQHgu7vfPwo1Gs8YccC8a69R6Okb8gscVdPVtDmiPUMvnpHhCkNTQUBb7l2cNlm3MzcmM3AtfWTx069JFqWXJQcM5V7SAR0wtjpcE7e5EUUrFCNeZS+0voGoY8qK24JaPWSeOY80+Ts4CKfO43d9URI2exJRn445TrK0cIEowSlAP7GDJSbP4/bUIUS9Xp0ab0zJhRX9U9psaXmMmuf7cIsREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP7LKz+tgDW3nK7pDWZgwHzxOtlyNHQEEA/e3umAhGE=;
 b=T+TvEURghkI64zMEA6lEshozfpz+QRMwHft9KDGPPmAXlt2RbnlhValsSG0cZ6yFTesWK5MNQN0CXwos99/uJSZHNBvh/uu1oJUHQ7M/mcQx3jvlP67MSna4vDOWH8p6dXrMNMcb2QHoRxq6DElW2aiqp2HLXR1ecXhp646wXyGOmrFfU68R5579TLnQALdxJ6N7VUXgBBcqC6CIX9T5jYghrbQrb47oEVW5rQE3yTIWBaXfLlnD/X4JPAvnTfSIbykaFMcgAeFztXr2PqqY83lz7oel2PT79ad2Kdm/5tcZ1Htb1BLhba6d8gEfmRhRDDmtUZrOPz0XCX4/yNNzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP7LKz+tgDW3nK7pDWZgwHzxOtlyNHQEEA/e3umAhGE=;
 b=Xnr9JNL1wv1nYupiw2pnyMY4ygGVyfpVyjEbkQbBog07TSBB8xqodrf6h0DhSF4QLxHrXq2SAT5tWfbV4xr1apZmXfhxec5a9FMlYHe1FxV6pWf4B6kcHgfsvmf1IpsF8x96nknNE1cNR4KvNhWMpk4V9cp3aCoiIoUixOXkC4M=
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:27 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::79) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:26 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:25 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 23/25] drm/amd/display: Add missing callback for
 init_watermarks in DCN 301
Date: Wed, 10 Apr 2024 15:26:12 -0600
Message-ID: <20240410212726.1312989-24-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3c5af6-9934-4b1b-616f-08dc59a528de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFNACvdyvRldJaEPCsit1pJj2hQmr4ZkAruHNZpn0qpOrxoH/eH7tRmY+R8Y6rDjh20F6UIR+CIGYJi0S6UbhcjOwo1P1IOK464dMo0hfgCAhkXDBQzHCZe9YUk6f7hOFGGGg/8huMUaTgupVXKMVEoxiHe19i8vcPWYZETFzxzP3jgbu7MfvNRScJfIf8OJt43VoRrq3a88DNmqrvxjRBZX9uPsaUd8s2AEt+eh3UFZ72dlw8kddq6oXvmDagnB29V0JC6JJlCGcuUWOGB2jG12ZP1wRdZu+6d23ifsGQfUEurQu35JAvopXJgKR3pbC+tsT7JqwM+zynJ8guwo8H917Ga0hXdsW2EYle00qMMg/ffuPrBL5EuAhnsndo24geJv7ZrBLH7LxEe0125xCf8ewXKm1YnVzhKwSWsbV60teNIuqBRHx9QK5cqgmqzaGngsIGeTl1nZL5Tqvb/tahEGpC8W8rnB/0FZwyRCX5L/cqc07kPpNmpGmeYz1OytJT0IzWSb+14q0vvZ8fYhkaQxg1MR7YDhp4a5mp8FlTBnuEznacUfgasFTV8Q8eP7vSMFxYRIdreK/W4Qrx6AujIVkmBEXJLpq6PeZi8sD598v3jzAjJ4S+FaAMyWfkHBNviwbrkGLF1YEfcU1wom4KogLrwlpM8TkRqqYi8i2Nh876DsH4UVaPOMVWZolZgpIa137A5aREhk4JxcmTtqLTzP5sJwDPRStDiBevEU2hkfKe333U3d7VrMcX0ZdqVi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:26.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3c5af6-9934-4b1b-616f-08dc59a528de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219
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

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
index a046664e2031..c1959672df50 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
@@ -63,6 +63,7 @@ static const struct hubbub_funcs hubbub301_funcs = {
 	.verify_allow_pstate_change_high = hubbub1_verify_allow_pstate_change_high,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
+	.init_watermarks = hubbub3_init_watermarks,
 	.hubbub_read_state = hubbub2_read_state,
 };
 
-- 
2.43.0

