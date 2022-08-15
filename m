Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB21FC00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 18:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C46CD0072;
	Mon, 15 Aug 2022 18:18:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1DED013F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 18:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc4rj5dlThW4EJqyS+EtU4wAoOcOMvDoF/NCM+xIkx6cwxtPwCEBBO6jgh9T136jQWMwntw6hDWhfI+oXGiPjBrCnSkGMYedXiOneItDURMGd3MdKPHUu/fQkncal58QNzNvYlSfah+DGv5ZiCTQbSTvdcExZJvAyZHOiEa7bWA7Cs7fuDuT5nDCDc4Sh204OVCahHQUhQxewFz8Qw1tGniKbF+oSQO6szRwa0rizInMlwsdGHcymsh9qrqw0pgpepDSqUPfYeNTq2Ax2s45A9WKZWXyxJ1rV2RI/V8ShU8PwbVzje5HDDfalJrJ4IlgZQ/hwIz4Rl4U9fX/oMugbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuCadXKaQ3yTWcAWCXCep8xfWlWdKQTndFB3pftzCRk=;
 b=Ak1ax/zr+rk1BVABWW6+fY2D3KptDJ8eQYnMTgm3FJM3mLMTqwKCxYJ5yXHAsV2IyEwF68BebLslU2Mb+qp/8Q8Bg5rF+3am6d22Z9+94YW1Q25NvXnc941FxXEL71NmVI9Y6+TGLUq6dgGtVaKuGFQC61r8GDxwT+nVhnqMsbp+gWCJxqbILN7PtX0/finy/kGHV6yTJy9h/QtFmwL8O58PhT4Mnqwum2r9bwpmyI8FU0W0AGx7kRekM6HFC2Mxb9PYIUVfECT9SGqdig6XO2WwXzllOzd25JnI2GhhhRxPcDi3FARC/m0knj1vbrysL1NyuJ5Rr8dUhEVtjGsk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuCadXKaQ3yTWcAWCXCep8xfWlWdKQTndFB3pftzCRk=;
 b=3d7Ph5Ok83WM/OrY7r4jS79yt3xi8txf/Vwb8MIoeoF5LHMwZWI0gEGT0h0fWcuh+YBFFa20MD2l39/ehnf26/7mzbpS4ki/SCXhMvsEm/KJ9DzF0IRf/MnVSoZPnLDHPyNURaBKkoPIgx+9BMq5wjBtgQlfRjab1n0gqRwsjpE=
Received: from MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::11)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 18:17:43 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::2) by MW4P221CA0006.outlook.office365.com
 (2603:10b6:303:8b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 18:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 18:17:42 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 13:17:41 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add decode_iv_ts helper for ih_v6 block
Date: Mon, 15 Aug 2022 14:17:16 -0400
Message-ID: <20220815181716.918439-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e89a64-0035-40d9-60f0-08da7eea7218
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2aPhfykU3btO+z2pY4YyxRq/Lz4BFYDBmb/fMAFUvMKxyrPa4PH0zqnSL7e5O4Iy7Eej7Eb5lJ8hsg7tn1Nq6fjovWJM+Pj1T4hya4ToCVSo4ddZXdrCbuv//6Sdlpa0LwbxCc/EjhBXnCS251LbWPzl/xbVs+4C6beQPrmgn78/qjkuHq066VRe70Hw8s5vbE7L0gMfbMlT0J/aEr2fo/WjkqUM7nkSVyqAaYKkZXeqchAsIS2akE9BLwdGKftzWHN2DYgrp6WqawN4zYt+eqywoEvldYD1EErvzVLxZBynlHFdzruCsjEQ/P2E7zFKNxLNSaKgBPf6RYdsrce1r4W37W2LZQU9tfN/NleyCZapPFEAdvF+/3bN46kneks3Cx0EIUWXHeMU66WitWSAkuhwNmsKj5B1oloIN6ULutA6K2hW+GFHnblNGT0qpVyKt32BjajEXS6omGlciCZmRV19he5rR4qFa96QtJqpdXH4n7fNiL3SwdUjPTxkM+C3xgDP2sGMwyCGUK1y+6dIMiIlD/M7qQ1EAMUALaD9t/jfbGhz8PGDePuiy+qLHUZwvMve4vvYMsJw2vlEzpGNQTPKlMYAZsNE9G/0XrZXoXRKt7BBdqA7NiRPfFPn1gKNRW6TqZgk8NZ1F3j38NLcC5KEJaHvTxI4HSIGB/WHsrAWK6DVPORPGG59FVXci8u6HDxgwkzjaCZlONJgpQptLrSHsgbrVtySctg4iGsHnu8EmEjtDn3Z7D7LReHlZztGjqWUwfv9fRg4DgDLQMubdsFlI7xy4LnbKq/dJx+KVMwLXLD7fUJMCzXHvO8/L2otZXVxwO85FJJkupyItWZNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(2616005)(47076005)(426003)(186003)(82310400005)(81166007)(336012)(36860700001)(356005)(40480700001)(82740400003)(478600001)(16526019)(316002)(6666004)(41300700001)(70206006)(6916009)(70586007)(5660300002)(54906003)(2906002)(7696005)(8936002)(26005)(4326008)(8676002)(36756003)(4744005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 18:17:42.6118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e89a64-0035-40d9-60f0-08da7eea7218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 92dc60a9d209..085e613f3646 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -727,6 +727,7 @@ static const struct amd_ip_funcs ih_v6_0_ip_funcs = {
 static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
 	.get_wptr = ih_v6_0_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
+	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
 	.set_rptr = ih_v6_0_set_rptr
 };
 
-- 
2.25.1

