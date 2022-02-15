Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5282C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 07:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040A410E3BC;
	Tue, 15 Feb 2022 07:42:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618A210E3BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 07:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGK16okl4C4ibuGFj46tAIzPxFU/s9keeUMK1yqTKK6JLi2/ooITsma17pW2WgPYs4PNjHd5456xW4lQPLW0Rn823yhzHowfKsDqEzYgn3kWxPvU+N48/Ga7HKjzsNItO8/FWOipCd5qfPOF0vNH4HFi8mBBvFwZYF5JQmhXU2SwRzikmcbtolX01fAdeBC5vqGOVMo0iVjrJ2plW5EDHLNiU/TqC6j4g+9vDC5FjT2v4qO9xvKPxpRS0ywzVNG8hJRlNJAUlG8KJ+u22yEU1th7B/H3cgeb9AVLmKNCHWoQLfBu1VFobeMtDlHOvD3+ARoAV1db4M4cbFKnT7c/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUSJHtEy2gGQJYTLlDON4HC8hLr3CXewfn0uIh76GlM=;
 b=Ul/kjMfzyoV/iSyBr6mif8kNcl93pi3hMEdOwYBmY7ecEbs2MZasQAqMtBvJMiWS8KvG7LGiaMt8poOGK/v4VNc6eYO2OMHLyN+R49Cyeb0MwrQgqzHjQmXcE1a3OtulVMRcf5hS74psoGUbIP0YnczGwKb1hFykeucNUxW3exPqDJGU6cyfXcv1HN+mp/cowRr8Y8/V9TkjNP/TfhB8CefTZJxQnheRWwlMm6BASRPKiwXFn/9hszaWADJHqpMR8hAVPx+9zbaiTBxwbGY9OGMryZjAum6geUwr4uUgyIM9K1bg2N7ssGvL2pDQBtmdMyDU+H8zTJpYyijVTH3rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUSJHtEy2gGQJYTLlDON4HC8hLr3CXewfn0uIh76GlM=;
 b=5rZ66ceVF1FHYKFUhKXoBZNF1HBxmShNpF+Hvn6I/TjupZ0Ca5dbj6qovQJ9nj5z4CEu1pPWQsZFL2wWFoCVYRkxXOyxPw4UGE8x/9m+cWWhZjLOshNSBBc08KFOAZ3WVXY52ItzeDUfjALt9thjnu+rnTs52zVb2iT18dSavNY=
Received: from DM5PR15CA0028.namprd15.prod.outlook.com (2603:10b6:4:4b::14) by
 BL0PR12MB2817.namprd12.prod.outlook.com (2603:10b6:208:36::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Tue, 15 Feb 2022 07:42:10 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::21) by DM5PR15CA0028.outlook.office365.com
 (2603:10b6:4:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Tue, 15 Feb 2022 07:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 07:42:10 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 01:42:06 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: Remove redundant calls of ras_late_init in
 hdp ras block
Date: Tue, 15 Feb 2022 15:41:19 +0800
Message-ID: <20220215074124.3411761-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
References: <20220215074124.3411761-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2ff54a-b794-487f-b690-08d9f056aca1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2817:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB281765D04F56949FE5BA99D0FC349@BL0PR12MB2817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2E42m6hMfBwss5qBNG3Fq6Q39J5Tubb1YtQCTa3MREbYp50jNODifQ/+yDWG0Er/HScVjha8/EHdcw/tbmg0ziUAp+sjRpuSTlTDkrOdqswGpeotPf8+wVl9Olvx9NoJo8MoaIiNnST0V14XBP4fVUfgWMMmPCh5pgOtiUY7Sf/uhmvHaVTrnsO/RF3MLAbVqZlZY4zZhCFrFgFt138ftYcKlAXP/cTUFLu134W9mSCcuwJfBuqN0/b2fXURnCE398+11SqxRF6Nm4/76j1d4hYttUp8cmLplGuv7sbvODIEu/ALX8UYk2E3H/jeODelk/9HEYpP46PXyq6GNb9ieQtHZyU/CMkVsbC4FaqCDNG94SqMD+OGvYpz00m/lfDsQvHsOQIGXbsn9DqtmM0ToM3Pa6n6VD2TgyH+Ka4ttvIhFGWdDIneMKUUgr8XFiTN03vKal3NSCLGH7FNQhqh+qOi8cJegBl8kfGdiTBdxi0b+jNf898/Yz3pCv99AHpJY+amI1D9BEone5XjbzL0AkH0xpQjEA59u80hpaeeKDMSeEZ4n9SMUwT5dG13X3pqgLbgIbf3MmvjOWoDYBqbepEU/Ial3+jkL1Tf2SJdVec5usEQTV67HXOn9bYUeBb3mPkmlYh/DgjxxFYpkA9LMaIOJuBu2PJvsHcndRddoyMKk7I+FLFsGsGGHtb0oJ89Y0IcPmAgKcO0r9UF1xAiu2SHY881lv1NFGacqLkd/Sc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(6916009)(54906003)(82310400004)(40460700003)(508600001)(8936002)(36756003)(86362001)(47076005)(70586007)(4326008)(336012)(70206006)(36860700001)(356005)(426003)(2906002)(8676002)(2616005)(6666004)(26005)(81166007)(5660300002)(16526019)(1076003)(186003)(7696005)(83380400001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 07:42:10.2987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2ff54a-b794-487f-b690-08d9f056aca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2817
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant calls of ras_late_init in hdp ras block.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 5 -----
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 956cc994ca7d..67a7d1cb89d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -470,7 +470,7 @@ int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
 	}
 
 	if (adev->hdp.ras && adev->hdp.ras->ras_block.ras_late_init) {
-		r = adev->hdp.ras->ras_block.ras_late_init(adev, NULL);
+		r = adev->hdp.ras->ras_block.ras_late_init(adev, adev->hdp.ras_if);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 70a096160998..b7fbc114a175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -24,11 +24,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 
-int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block)
-{
-	return amdgpu_ras_block_late_init(adev, adev->hdp.ras_if);
-}
-
 void amdgpu_hdp_ras_fini(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index a9ed4232cdeb..c9e931f046f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -163,7 +163,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 			.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
 		},
 		.hw_ops = &hdp_v4_0_ras_hw_ops,
-		.ras_late_init = amdgpu_hdp_ras_late_init,
+		.ras_late_init = amdgpu_ras_block_late_init,
 		.ras_fini = amdgpu_hdp_ras_fini,
 	},
 };
-- 
2.25.1

