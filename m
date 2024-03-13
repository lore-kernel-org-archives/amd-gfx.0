Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2464C54E5D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 02:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84C3410F374;
	Wed, 13 Mar 2024 02:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZU05XS2N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CD610F374
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 02:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMBF/dVLHoQDH1qIl4sIMvcPkc8JfTW545ticztdlbfjtkzcifgx+BId7RyH2Jf7fzmtxa+d5biTUvlVtdHz3N+3CireXdOykTP8EogjiQ+/e2kW3/fZIlwkX+g8ZH6x86+W55hq+Hs+CUQ/M5dm7Bvz6K6Ag+/7L92SA16nmemwqNIIaen+/APlPgqsjRkb7le3dhonTa+vJ0QdyTiw2tDEmHR3BnNHP0lcZEkK2K7zcCROCpRyvZim7hfw/RQXCzuXOe5bebN3qCdlDMMWUvizkEdn+qHtii8LehFmrgVQXsryvvkBXxsW6KPi5eIGLU4GpeOh2jPLwJIcDa/xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WIZnvQyz4cueaq4+7AQWBgNdN4qEgZYSrr5+1IwUwU=;
 b=lYrp1KQUHgk8a/lKXqyVzihwunAajINQRyDhPeZZ/FVB3uGniHTZ+2gb72j2Ljes7qGN6g7MePaTkYUKKQbYPk7Byi+k2gcidOMQ3EcQVabifaYWXjqy6QMz3n5IHvtlFRa4oHlGONwQ7xyHy4ql1oqp2FIbhCQtlFwo07QqTqoh3PoR8ieIBIR2y4ABPK5lzd5ujKZZuLhsb5sUBA/hBj41j7WywquNVsNHg44dKN35ju+ZkoXdWmQ7iD8kw8TL60V1jDb7ogjysx6n87CAYv5GVjIvMI7qwvubf8JxL4VevjxCqN+1WZVVJgLrHs+jqahR//QEXQw/DWgXqSKamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WIZnvQyz4cueaq4+7AQWBgNdN4qEgZYSrr5+1IwUwU=;
 b=ZU05XS2NfXKYiRjprWduQ2ZqdohbFtgVvrGJ3aMUaiBsZsYVdgsnNEo1w2+JxH28lvtbXCgxHvCqa862ne9P/JwHqm27bq+yWSaaCJqhq5ZkryZGUqNm2HrycIUe/10G0eBI0HeJe07Q8VgEA74OUak4MXXHruzqpOYniVmhttA=
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 02:09:11 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::17) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 02:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 02:09:11 +0000
Received: from MKM-L1-VSKVORT2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 21:09:06 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <YiPeng.Chai@amd.com>,
 <hawking.zhang@amd.com>, <zhigang.luo@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip virt_exchange_init on SDMA poison consumption
Date: Tue, 12 Mar 2024 22:08:43 -0400
Message-ID: <20240313020843.223278-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: d7390655-78f5-4953-d852-08dc430292cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/0FmeCcFEDvz78TbA7m7xVbloIV+Z5cRh4bJSsC5F6jBSPsTPR0csbPOZbMv2rVM6oaeU4Zm0Xmhq2xYOEvEw0LMLWL86bST2eyGeSOQ1Rc2oCYDYKOGdiLQef4CmmKu4zaJpQZrfjOnKLuUMq7X/a+ANvogGdxCtANVmBJSKlg2RUktvKjdsAbppX/M4XON1jSKyLJzC4awweV9myOVUzdb+GsMbeRzn8KbnO6qrHVaTKQV0pxA/uaP5SCuis5HD/RxY0Ab4YUCSun06ZjY5BcIZf/IAT8A2Zbu+w3xH+iTj6W8dxZdON3efmHDKQOwoki58ZoWRES60zR6mVeELaYEhR0mn/YJSQIynmTvEVs4uh5jfKgRYpWaFbL5jle8DrIrOkQ1K3idRnO5ChtX3rUzTsE3mj6XUYh6x1l5jPBrkTe7lU20ZaTGfcXoFzS5eOESRiRbThbW50QA47MRhrpgMwmjSlwTQuguYDgesKxtRgYFiP8hF4A6Wp2h3feG1oW1g0fCHVSrlUK7ENOSFGn+zGHYoAfC9cQzkzJlf7qGCRJseWcxAQi0K1qI/GOe9riifRHvCn43wXRezTblwJKtggdpQnVraGhYwW6Mz19ciWYc53/ZoviJVOMI2le3ntrlICuKQy+u835w0onCHrkJU5hDmGAtrAkiRlQNH3ZbEuUl14gL+tNlB4owth2z8WPQGdVGTVOx1akgCR6/feJiVEtZnlo/fi0D3hCNvCRDk+Xz7veuG5H+8KTRnsF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:09:11.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7390655-78f5-4953-d852-08dc430292cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

From: Victor Skvortsov <Victor.Skvortsov@amd.com>

Host will initiate an FLR in SDMA poison consumption scenario.
Guest should wait for FLR message to re-init data exchange.

Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 77f5b55decf9..a1bad772d932 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -444,7 +444,8 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_device *adev,
 		amdgpu_virt_fini_data_exchange(adev);
 		xgpu_nv_send_access_requests_with_param(adev,
 					IDH_RAS_POISON,	block, 0, 0);
-		amdgpu_virt_init_data_exchange(adev);
+		if (block != AMDGPU_RAS_BLOCK__SDMA)
+			amdgpu_virt_init_data_exchange(adev);
 	}
 }
 
-- 
2.25.1

