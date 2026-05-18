Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEF0CD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2B9110E6B7;
	Mon, 18 May 2026 07:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZmJ84/FY";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4785C10E6B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzEw9sQ0WLCsxXQHG4rVnearLeyopjfqSpPl+LDruwC2da0oh5yTBGBA4A1p7k7n5Zuf0m1VaFRGntl+6Z3r6Z6lSyWoa+81s+dx0wd1h0zwdADt0IAJOclGOlTmDCAag0nfddSmDnmXjrDoY3vJVdqsk+3eUtfRWXVZa7v/hFhkXOLE2hmNJd3Up30DW2EBVzPBp5U9s2Tb8ipOzt6P/TyLQdM90pRKUfBb2+A6rS9qZpClAf6/6SoEoeIBItRFe5SARuvqzaLMr9Cbj6kJYuzxnUHrhvvqI5Pohtu/v5ubYfvrMOw5EP8Znviyoy/RN8xg+PxjoscrhAxq3FTr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgMUghewDWWXJFOn1oMF9GHoZix1rJTM8gzxliHi0Dc=;
 b=k9Whh2bLdGa4CikXWCYRoz5gldG9huNB/Yu3ZGBmR2ChNEQTUEhyaWjQeF/xT774go1lZe60rw0z4o05r2Sm7CV4lNNqjm1HuxDZ1cng1srdPG1Ds2GbTyBPceGD0vs8Dep/8BbSdjAJKliNTmm5n8AdgOfNJEALwHqN1S6uijNDTSP1uzgXCMeBF5FJhE8R0fbHyy2ZEi0oeM0153+qyUrA4IFK233tlMLcIB+XJ+pVfDYFkXtPdsf2WU8MnH6EF2NIiIkT8z1LUfF7f+GRf3GyNxnjNyDA3209lWDKIccOm0LFRHoFRg3mUBTTXhEvERh2dONpJBClaH/s0Fy+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgMUghewDWWXJFOn1oMF9GHoZix1rJTM8gzxliHi0Dc=;
 b=ZmJ84/FYReKwtaceSAMcGBEMSZj3GrOhttD5p0ck8Q3xBvbj0+M2bZchb/mczmJrUuORoqjp1chuJSKoq6v/gtRhyQ2lmio+n8f9q1buK5vq/3rXglbLNVx+di105QPj6SfUUV1tNGmDPZxUqGP/2wqTL/je6fM4TgH7v8y9BPA=
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by LVXPR12MB999197.namprd12.prod.outlook.com (2603:10b6:408:3dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 18 May
 2026 07:23:20 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::2d) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:20 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:18 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 4/7] drm/amd/ras: fix memory leak on ras sw_init failure
Date: Mon, 18 May 2026 15:22:12 +0800
Message-ID: <20260518072215.3647120-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LVXPR12MB999197:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b87c14-992c-4e59-73e6-08deb4ae56cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: Sl0/UxLLD0x5Mg42gFUQAqka8aXu8Ymk+5boWqxXcH4xf9hgGknuN4Lp/BA0MTC0e/EkHQOAnQqIApNWCESuEpPa9zUeeWFwXBaYA8kxlKLP/6R70skD2CooUq3eQcrlaqfeYDI1judfR6EhY2A3GKaL2Yb788utL4AGEpNjbsgplpv0riZxSeLA2dsKZLLh0c9NSZrR/9u5qo/Xhqw2Szz7rJxtf87bh7m4RrHun8uvUII3QK7gVytxchgsXpoLPOZakIAgyq09XZ1WugbGxccc3SdNaLpJ/R4OdBUDrOUClelFuI9dlP5zu2N49CwhXvdcEFVI0CYBN49PjimcDx4Y6TMea6bvGCTPANfVH8GMKR55VpDryofk5psHcFovphnKWSa3TsluEKGmRq6mB7wo9z8EZH5FgQLHbtwxH5uGqEQmecT66ntrgrGPb5nh/uTTjYWYcbrGfJEXiml5rojfZCIMnQjrmEOB4wN3P63+R1SpP9bBCj8RqrM1hM7SXb65C7+nk9DO4Ml4/6YUiw/8XM9q6GQkGztyB5yj1OJG9MWyLUFjAUxEXzz7WDCa+OqCBEotLGK59pGywCKHxzC9JJYDZbEbKiGRrUMdDofpuFfhvMEpDxBOua1M+k9clsd9V4aqV4EJzp77b8MiWh0AcNrdIKVf/7PsmaneJZQApTDeMNk5rPaA5Z4U4URgPpockVGGPp++wSXtsiI9x1x8EwxTzJSiEuk1g6yUqck=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2itdxYtmqRZWBNbZqwnscbxXtuuqPzyGnoj/0sIdWQjVVn4DQnOvHSDqMuFCmJ2dR35hki9+XJeNW39O55LU7/xYeX/8Mc029mhkfVyOcdTWfGro804LRZvxZQRvaS8fDWIRcb/8hqDdORhxmbRBcW2eWLeH1U2wNPT0Is2YOTj204ZnH9oTnbLyAw+mE7a5VW/r2LD4GGSI0q9CxYuPOCi4Y/9WS9gvs9bLGvJE3hKkcXcVd2CyjnKYX5N3LcluD6lCDx32BU9yjNNhMYCMvXNI+J14s9c2KfhW9Fg7loqqirR1YRe4zs8rxJD/zZJkZVzeTwr1h+Pdr50OPlJU44im8joyjQaRaiR4bHanMdQ8dLt1L3FtDZMaL7p1/buBnP9VE1I/9SKMbMupmIOph5TkEvEFqx4bG75SeMH3UdVGmb07+DWVlpg8pVV+07f9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:20.6371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b87c14-992c-4e59-73e6-08deb4ae56cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999197
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

Fix memory leak on ras sw_init failure.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3a819c89e2fd..cf6ce21fb4dc 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -307,13 +307,17 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr->ras_core) {
 		RAS_DEV_ERR(adev, "Failed to create ras core!\n");
 		ret = -EINVAL;
-		goto err;
+		goto err1;
 	}
 
 	ras_mgr->ras_core->dev = adev;
 
 	amdgpu_ras_process_init(adev);
-	ras_core_sw_init(ras_mgr->ras_core);
+	ret = ras_core_sw_init(ras_mgr->ras_core);
+	if (ret) {
+		RAS_DEV_ERR(adev, "ras_core_sw_init failed! ret:%d\n", ret);
+		goto err2;
+	}
 	amdgpu_ras_mgr_init_event_mgr(ras_mgr->ras_core);
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -321,14 +325,22 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 		if (ret) {
 			RAS_DEV_ERR(adev,
 				"Virt ras sw_init failed! ret:%d\n", ret);
-			goto err;
+			goto err3;
 		}
 	}
 
 	return 0;
 
-err:
+err3:
+	if (ras_mgr->ras_core)
+		ras_core_sw_fini(ras_mgr->ras_core);
+err2:
+	amdgpu_ras_process_fini(adev);
+	if (ras_mgr->ras_core)
+		ras_core_destroy(ras_mgr->ras_core);
+err1:
 	kfree(ras_mgr);
+	con->ras_mgr = NULL;
 	return ret;
 }
 
-- 
2.43.0

