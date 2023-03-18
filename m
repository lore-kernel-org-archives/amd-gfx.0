Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FB7C74A5B
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Mar 2023 07:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786CF10E23C;
	Sat, 18 Mar 2023 07:56:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08AC10E23C
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Mar 2023 07:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emcZfriZywJfcNrDsO0Ai4PPomEkEYNlecH2YpXKsy3iyVAOtVp2SLOhU1pGxcYF5GCUkSdr1agON/QtpXbCCq5hzaWuK17hCBPVIRLzJNbqEIUPyb62Nle7vGHDCLkfD15ZM2E5xRZr7caVWrhSfJxGH+5nnpQ5TWxtnz11iBIq/qNuVrGwysJWujkcDyzk0bgH1mLt6h5Rj52tBc3xrSOjmjd011LqIPa4M9KPG6JWIEcbpccFUGmjJEJoyepVbY0o9Vd7PzjZvwHtM8jGwQrOgLYPExFxf1J5eyOJVmOc3DKnv5bus3lVnjzDtY/eBfNzgXTirfIuWNfU8/nfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4TURhOcV+tihRDX7P8JN6Vi9SFtedr78GglNauoHM8=;
 b=fOFyy1Le2eGfHiB073q90WbFAqF1nnvOD1Uk1maMMV6fZNgsJmICbkmyQ7TtAfv4Y90zD9BKBEmmqx9B61cEy5oojjj2jSRufq23NmfR5CgogGhn9PH5Vvi1NZWoP3Q6JoDj+x2hTb5gDgLoZqiG6FdJBPKG3jMyCJM5fYWze3Y9Z9AOa55+ieRae+0fQHebdWbtKkdL9hBafzI7IVRX0NMErocsuk2tnIDp0XjRBrTZgX9el5ziz9E3zsUDXc3NHGYUc4jQeXB3SfRp+BjkLhcrrWfTSPnv1dTBxos3XC5gvWCHBibjk5vxo15DUlJoy9aAxhSczzsPv5rfND7tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4TURhOcV+tihRDX7P8JN6Vi9SFtedr78GglNauoHM8=;
 b=xW78axXOSHJqXbVyZAqC6A89WFFBCoApMrI9K7tHywe6mWSRPXHuiFxT4ls+G9d2LU+hC6M0WT4CseDcwDkn0xeeK5/A3uZT8uXBbMhj7B2kph2chOG0/16olNGPd3tDaL5fRTsT8y5CFvzr+i36SLMyOYo8Zyn/RNgeRcC6zl4=
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 07:56:45 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::67) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35 via Frontend
 Transport; Sat, 18 Mar 2023 07:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.11 via Frontend Transport; Sat, 18 Mar 2023 07:56:45 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 18 Mar
 2023 02:56:40 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: remove outdated 8bpc comments
Date: Sat, 18 Mar 2023 03:55:58 -0400
Message-ID: <20230318075615.2630-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230318075615.2630-1-qingqing.zhuo@amd.com>
References: <20230318075615.2630-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6301078d-fba0-4707-3821-08db278651a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA2K/eQswtBtaET3t43tV+qMoheCB+UY6lyjqMEKOH5VqwnBf8nItP6vMGr6j0/hawreFGYv3YB9E4lQmpha7J6NQ9MCNt1WdxmSwyBb5Mt8lOUVRZ4itv96M7AsUV6lfPli9jT60FQayRxPcje9NSPRVRNeJ5hJH2yxXuXXpc+8QwNmcHsk5iVyVFCWpjFuoxxnpPuKIjQeVehr8YLCf9Dw5JcBXjKV+uP8/MyUoiTuAubrTTEq+lO73x2yE1Od1xVnm5E1Kg0KGEjZMf3tMAkcYQuV/qSjJgZy03N6zVY5E9PeKHMeD0G5jEij1ydQSoew388NOyF/56ttb28Xob/UjHQ12W56N9CUQeg9T3FUKYSot6bD78VcJuHLUzWxNa5QObghPfphi5MSN7GouUmUoH2XO5FaTAbvVI4vBP4XWsxeICzfIBDu+VW/CA0OgwzdMya7P4oYeCUB0N9WV5Ub3qWMj3IdH2zaxWFm2BoRo5PWIjGEW/bDHeyRQ1mOR8024Pimk2G2wBppTea4qcHcXzA2gX9m8NIUO7Bsgzf25lBzcGG+GuKlRz9pAPV1qW3QV0I6v7IHdDE1EeC+tU01d9tMxnFnXuEAoLPrwNa+6ntoqyuAZdif9IRaq3RgBY+NaJvLy5HMZ7jhHXGt/R6QDiEPeoQgp2d3glI+7ELG3byYpcMvxjqOwrbw3wFqsCHpn16WykCeJtFHyXdN3qTJ9IL1fliT1AARrl6q2Mg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(40460700003)(36756003)(40480700001)(316002)(70586007)(70206006)(8676002)(6916009)(4326008)(478600001)(83380400001)(54906003)(186003)(16526019)(1076003)(26005)(2616005)(426003)(6666004)(47076005)(336012)(356005)(44832011)(8936002)(5660300002)(2906002)(41300700001)(81166007)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 07:56:45.1275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6301078d-fba0-4707-3821-08db278651a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[Why]
The commit ad9adba9d1cf ("drm/amd/display: Don't restrict bpc to 8 bpc")
removes the historical 8bpc dependency and sets max_bpc to 16.

[How]
The comment that states "8bpc for non-edp" needs to be removed as well.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ae0a223b90a1..724c565ae688 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7283,7 +7283,6 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (!aconnector->mst_root)
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 
-	/* This defaults to the max in the range, but we want 8bpc for non-edp. */
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
-- 
2.34.1

