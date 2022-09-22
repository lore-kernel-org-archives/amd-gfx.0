Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4729EC6FA82
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 15:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D52D10EB98;
	Thu, 22 Sep 2022 15:15:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EF510EB98
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 15:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKW1h0XttEfojbTBUwx6GwVtog2n702aGAhFxR1SEttDu+tuygbL1ZH/n31Xy1Fb29SekZKWY/GYYb9jFz+blt7J9ZSG1YW5dCL0d6QBb3BVyHfIole+RpGTff4BWR9xSvrOlDCRZmqSVdOe8K3vAcfMcTYlC/y/O9EzLzugpQtvFz1rXz6gVGNvqY2thnf+A75OnFRHmNKqMYP/R8qNOQ5z0vxZ4VICOXVhSefrLAK33QuoX3Bs6wYtfpL240n/Y3dBmVURTo7yAUsYZIKKNvWJeLSKWEvIQ5RgcOtgOwGbfNrSi5/e9xQlGYTFsimd6ZaNs+qx9B8SNmBAEgKRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi43h/6aJXTV3/jM8EuAsu2uDzjMYQ5jp8rIqQTxYTQ=;
 b=Xc0r9gU2yKGhv7FMm5T3f6KznEaAoz5a1sLd7UWEMX7cG5AHYu+r/mBx3VvTHxSJMfyTB8pkoqD2YGOIrmABZ74wY1wOAQWc9Sid3ci+1+mzYcXbCfTlovS1uY6HD0MLF/IWZw237Ik3YMqx5bmCke5lL2M+G/cFMEl5md/FOEB+g64igpBhge+vis2T/11d9QIALdjdPENxCewejDxO+bvWr6cJoXgZlWIrekY7rk7p88Kh+HIXRYtt7YRaiHRilTYgEUt+mlCZhYimIPkmwTjZSdmXxGGtF2LugKdw8WfaTynIu+vUGy++HGk3DVfLEpbdbr0EUExsEsRXzJPV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi43h/6aJXTV3/jM8EuAsu2uDzjMYQ5jp8rIqQTxYTQ=;
 b=xRWNPByIuWPR8I1keWXxRcb4xnQRzg0jxZo/QOhPxUFklq4IAZYDzc8X6dIU7U1B8eFKJaapyWlbE5/r9qa2hnBolRbJqQOI7dfFU3x4G1z4CEtMceCYgZl/tFlqymByOqpvndhePtfvyE3CWfsSOlgolBF5JA3H+068RSlRrG8=
Received: from DS7PR03CA0098.namprd03.prod.outlook.com (2603:10b6:5:3b7::13)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 15:15:14 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::8a) by DS7PR03CA0098.outlook.office365.com
 (2603:10b6:5:3b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 15:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 15:15:14 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 22 Sep 2022 10:15:12 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix VRAM eviction issue
Date: Thu, 22 Sep 2022 08:14:47 -0700
Message-ID: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c3b2f5-86f5-4ece-4e90-08da9cad401a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obLlEI9fOy15b4ItcQn9tQmiHtXMobPJLxgua89s++CnXulq3hcuXtYmVBDx2ipyOGzPBIkpIPgXIlKFssiI3LWOS5oPdAZ9xwMmkaX8VOtnNB2jB6eZ9/RHLF+d7F5+qIsaoqiojvCRKb82zSxcnmv2+qXUpA628PDOu+px/uaF4VO08konS8HqkmK1n1KQ+jsOVSlXxyBosFWcW+1d4rysDWDX3Gos73H2Za/3Mpls/qe6RrtSFi5WdMbKoXLZIefxVW5nzCVWm4QBCwrBFeP701LUtXMgQUaG2HADZQdkYm7nMMR5TOiUohjI1WNIVLKNNlF0zKgpUaiN9hPeIyFUNPiXlWfTz69M4oRWcScwQAxLg7hPv4gK4Kl4kMLO3+Jz1lCKKE2ArRHt11kfXvPlXpn6nE1no7LJEWA06EdI6ZAjyw2aZBlP2XKt4xu+PqjRBL0EwWRBMYz16WZqMSjIfylpmZwomNFwWTFI6XAquvjZQjtt3zuMLlCVFKzjHtZITpbnJtXDqZ2yzMo2s83k6M6sQDmcMl8TsXAISGT2hhgY9itmeLmj4SEFNJO8izwKR+NMZhFcZ9MeuPYFOrT59oTrMc+vsepu4WOUWfMCsVmR2MwKVJHzhrdLl0KeXBB+Sgg7sLLhBD4ii5DbaQaZFM39EuEp5AAjXhiLrkv2o4fvQSxgjxGCpYp/qdWRcGFnpecloNXZZndKms5Zv5KcduTgwpaw/5Ik1bYt7VDN5Vj5lk2PleXqhSoXe03M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(5660300002)(6916009)(82740400003)(966005)(41300700001)(86362001)(82310400005)(36756003)(40460700003)(2906002)(81166007)(6666004)(36860700001)(8936002)(70206006)(47076005)(356005)(54906003)(7696005)(26005)(4326008)(40480700001)(336012)(316002)(70586007)(83380400001)(426003)(2616005)(16526019)(186003)(8676002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:15:14.4150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c3b2f5-86f5-4ece-4e90-08da9cad401a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A user reported that when he starts a game (MTGA) with wine,
he observed an error msg failed to pin framebuffer with error -12.
Found an issue with the VRAM mem type eviction decision condition
logic. This patch will fix the if condition code error.

Gitlab bug link:
https://gitlab.freedesktop.org/drm/amd/-/issues/2159

Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible functions")
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index d1a2619fa89f..73a517bcf5c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -746,7 +746,7 @@ static bool amdgpu_vram_mgr_intersects(struct ttm_resource_manager *man,
 			(amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
 
 		if (place->fpfn < lpfn &&
-		    (place->lpfn && place->lpfn > fpfn))
+		    (!place->lpfn || place->lpfn > fpfn))
 			return true;
 	}
 
-- 
2.25.1

