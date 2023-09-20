Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22607CE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01CB10E432;
	Wed, 20 Sep 2023 03:21:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A89E10E432
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boR35/tV5MrwcNXE2Lh1n9bw5GkvmF5LrLNhIetvrCvSIQv+loq8MBkYwUUfGBUrOpLe2ltwCoavFZMWXXwbU/2wywqqZF0zfjbQcxrhsJqsQBMf19Mp14BXrB/jVYuZSjD4pXvqExWmq3w/MtAj5FrWAO7gSUJ/lS8IFzXBVZAIuGuX0yEifiDMMNWQM6uCeSmwDzQ3Dy80Y+XbfjbDa9FOrucRt0arl5/Z8MKzWkfF6hFPIt7XKJnJFXA40kpuibg7prdAyXYMk2zG1mKZaozUTqG5i7gRXUs9XjrQXCa28iyFtaLSAT5gE/cbipIIYVcQBJcJgiGEGumx/9ohyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZYZoyI/yb0XK8GwJVP/bTdfplUOCz7zC3QDqrebsUE=;
 b=eVw4dz86eA8NYgE+u8uHk185EeYuBotXRB9378KttLWFxyPXs4iO1+jBhu5RKPJD8TNxM1LRHrLmBT5WGBoCKiL04gVoEu3vlZaTowYmvCX7YvU6ieBvj9lxBMTPs4FU/djBLY6P0JljN1Lg3W7vgx97/eZhGUttslQ77HTBarkedCSljpfk24cdr5ZIDngUZ8C0Ou2MesKLOv5gT3LF2xmUnp8PvhuaETbt/6wpuydqeEAh3+p+lPdjfR6EPcdKVW17Ktz1HAxcmaDrILtWWL+3pb9WQNQD6x6kdh4zg5iZiRDdKHNj/5JgwsU7xzpC1q+h6qIQm8VYnl2ttQJmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZYZoyI/yb0XK8GwJVP/bTdfplUOCz7zC3QDqrebsUE=;
 b=36G5fa+C0TDjO0BzvFIkEVGxvlTrDOoOfRauG1eIzijrJHeANGo64ESbL/AMzePVOWdBI0SDM81S9ZMdT7SeO/CjIc1CBcIwEbwVrK/qPb8vxEzb+7d59P1nddzAmpbV41/QZDfrO/nytK1R8JwkXFO4qqpbxrss6U6swhuxlas=
Received: from BL0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:91::18)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 20 Sep
 2023 03:21:16 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::c) by BL0PR05CA0008.outlook.office365.com
 (2603:10b6:208:91::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24 via Frontend
 Transport; Wed, 20 Sep 2023 03:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:21:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:21:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:21:03 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:20:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd/display: add missing function pointer for
 DCN321 resource
Date: Wed, 20 Sep 2023 11:16:20 +0800
Message-ID: <20230920031624.3129206-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7457fd6e-24fe-4af6-dd07-08dbb988a68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVME/V+bGNotqsmyq1W5kzgB4Xz8WUtBO1zaurMphi+mPknNjdpzmwMYnQ+FI9BA7UAxMNu7sWAxhmM/ZlOaHLCtUbxHSLlhooM5B9LbpZrn4sLBsJ3jLsZQeTPhsjMiPOZyQcNapLi2Y6ale8Q8JmLPBjYIjFRfcBZ7/9CwvJhMTH2cRNBoTCDrpYBmffEJ/ldx+N1oRpnAGYtzSqmSmACUFqGcaZxKWi7i7iWK5KxsqTetVg6wJPA8QEfWj5pX8aH3MPbRMfml6/M26fEonFVlGHVXF9kV5TcWwhrkDx7Pkr4X+UwG3RS1UwWIffJv8E15md+pRawRNjlcyl0KBt1IY5dvNUmkmKQr3jPK0h4tpiBUqZL2UBQCO4annw+DShibRMU7PXMWv+YfwRLGx88V3c8XKNHR8pI4b5kzGIoeN2g9s4OoogoswSTRNvUr8Cbptd+Kwr2JQ3Y0eh98KTkNQn3Y6tL0flqdZ1RTnG4u1eWFRtYh6JlHKVwYKnruLZqaMG6s7H0lnO5Alc2Ws0hNrYQJog+SES0pzCaGvrlLvk5Z/T2U9GRR7Wol1GjRoRQw+DMHpvc1LraJ5gSamcs0TdloocGA0XudEx/dEYLzxCILKIQTAxbNYQmCLx8cp6if0OWutMuN+NUSy1qNWa0TQqOliqxYhN4qnnKEkzHZ4iZGGSwoMYqv8Ke1lx8anRmznllX2INIpilMseRYX5ZKwFodKbgNFtCuVC3uL18/eGDOCrzxAIIk1rVOUnYAsHD1k/VPkzpEgpfTo8XBfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(2906002)(8676002)(8936002)(4326008)(41300700001)(5660300002)(6916009)(54906003)(70206006)(70586007)(316002)(40460700003)(478600001)(47076005)(36756003)(6666004)(7696005)(1076003)(26005)(426003)(336012)(2616005)(83380400001)(40480700001)(36860700001)(356005)(81166007)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:21:16.3725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7457fd6e-24fe-4af6-dd07-08dbb988a68f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
acquire_free_pipe_as_secondary_opp_head function pointer is not
assigned. This causes ODM mode to be disabled after enabling
windowed MPO ODM capability on DCN321.

[how]
assign the correct function to the function pointer.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 7d40fb6156f3..f11ff6f071e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1589,6 +1589,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
 	.acquire_free_pipe_as_secondary_dpp_pipe = dcn32_acquire_free_pipe_as_secondary_dpp_pipe,
+	.acquire_free_pipe_as_secondary_opp_head = dcn32_acquire_free_pipe_as_secondary_opp_head,
 	.release_pipe = dcn20_release_pipe,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
-- 
2.37.3

