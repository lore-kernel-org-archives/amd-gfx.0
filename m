Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C7B10E31F;
	Thu,  5 May 2022 20:08:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70BD10E263
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikEN23TWZ2KdZgouM79GgEWMICvPEj5G+11rSOZ4+gsXY+DH3sop/EnxsJjHg5yLZeNZHHya6rsBXvg+SaeFH49GO79xngzW1V29+jDrDwszpxxHLOQJoR2h7I4We2+TwffrUFE0tM3MeZEeZ3wMIL5Rmuan7OBgA0rVSeuzUehTLRQ7xEwi5Xcds2ww0//RY+dCr/aqqaZdb6/ZTHvMTsOWJbjKwtjHymnjo4z1Nfl812/Kc87VlkCp5wawbCOk5ByX12kB4u4mPzkN+zC1RvTpBO72s89U5LufXOT5iMtofQSk3dSfxnnh/5BeYFylzYUcKIfyWA3HHbSYRor1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUYgwDJ9YpFfICt9Y5fMTWUb3+jdNXwvr85W85jOA0o=;
 b=SgcDPeVYCsbN566YxOUUKt8UNBOqxmBDYljTxyyxuEOeph9m2X0plxA+ny0wo65P9+0KTb1+XKAHlmUW2IlYzzNlRzW8hdyyatvM4ggYoZPNdjdh77GROG1VTVVlGkL+mz2KUY+mIzpiigmA/tFuqFDZwF9GIlGEI5LARTYrmIUMIgBFjTYSUiPpj/DwiXuRB12TF6COXsAdjW23/j6eUcTU0Vpx4yh1o6TGT3VYar1GE2cVCn5nSs+N3bUa3MyMeebkluPjAadoC56JHNZ3d8E6wHpYdJqHGqs56yS/ECQj0wnivrds7NTmDdiSAEQ7b2B/zZhWv9Tk3ho7fN+wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUYgwDJ9YpFfICt9Y5fMTWUb3+jdNXwvr85W85jOA0o=;
 b=gydP2h+Bpc6RKrHRmZgoe+/h+gpGE/LsqSL0sqtFdu5L58L5P2XhYcDW4cDU1XW/L23l1ynN50Du4lsxd2vAzCHsvEozWO/K2PfTeLalvyyuiE646x0qTmxiOSwOEXm94kAPYyK6M64XLIUggpzbQK2orboTJ1ioOCn48zCh2ME=
Received: from DM6PR06CA0070.namprd06.prod.outlook.com (2603:10b6:5:54::47) by
 CY4PR1201MB0008.namprd12.prod.outlook.com (2603:10b6:903:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 20:08:34 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::7) by DM6PR06CA0070.outlook.office365.com
 (2603:10b6:5:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable UCLK DPM for SMU 13.0.0
Date: Thu, 5 May 2022 16:07:39 -0400
Message-ID: <20220505200750.1293725-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6920962f-abac-41c5-8a49-08da2ed30891
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0008:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00083741D7DBDEDEDC8444A8F7C29@CY4PR1201MB0008.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQJE31JTqX/PSdRChzJtcedKV9R8xk2+ZizLprpmuA8T3ICX3teX4NHIPiLBxCT/b6dxENmZ0m0CCQOOxyJRrVgUfVgv0j8qSE7mxwtmwIAKfBs3sQB6OJ5W/77Z6Q88V0fAA0mlP6pHwfhxkBYyLzIshS9TrLEOdsQtVQrYPXgcW06aGcYcfPCde5mL/H/pdQxPt4dbgY9d7a2Zp9e8rCCxD8i9mnUkPN1mjIfa+Reg/JjX+UswVwFugghtAFaoTl8Gy1JjtRIyaEmaWydhiCDwUdJPpO94oaWuuYzIgVxIrLybF8wZ0y/mUETZEtGgKl1fAe0h1Y9OQNFeA0D7z+1+It3Ymy5b2yt96l3bGPw0aTU2JwHvSMeQAks5wL8MbAyDM0/wCTswQqWM3NP4Mz5RkBlWQV6DOdpKA7LI3zVgc2lo4FQu+OcD0Mhm3L2ZyrAmc7ksmjdvIw94b+ibwjZMz7y35Ok9Qsz0L7oDkYMpmnyOOhxCTwmRxfsEMn3a5f2afv2P/2KiQGrUlQGF3vdrlTrDd5IHKaa+CEW9pSx0BFJLmYcidwpRzFmzqOwe/HD1S/173n7c+PjzJwq3ovQ7HWA1oMSsa7z92cICWRkNRelD8BwJtrvy//bOjVDTOcr/vOSVycWmd9R6Nt00U3WIkwXUdHqMFV+ddawChCjjCUQTZc0TDj7y3j7qVLNqrMxSCxkc2DZC0utQV97TVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(81166007)(2906002)(508600001)(8676002)(6666004)(8936002)(70586007)(4326008)(356005)(36860700001)(83380400001)(2616005)(316002)(86362001)(36756003)(82310400005)(6916009)(26005)(47076005)(54906003)(336012)(426003)(5660300002)(1076003)(186003)(40460700003)(7696005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:34.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6920962f-abac-41c5-8a49-08da2ed30891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0008
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Enable SMU 13.0.0 UCLK DPM.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 44da7e06a012..e3d3cf4d5c54 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -236,13 +236,13 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DF_CSTATE_BIT);
 
-#if 0
 	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK) {
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_UCLK_BIT);
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VMEMP_SCALING_BIT);
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
+#if 0
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
 #endif
 
-- 
2.35.1

