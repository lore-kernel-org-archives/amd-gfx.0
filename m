Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4FFEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 02:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F8F10E39F;
	Wed, 21 Jun 2023 02:11:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 380E610E39F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 02:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/YtDCzCINqb2ZG6AclGm+aVSJtu9UbyAnCq9nCJOpfxSZ1N9cv+wqPdSeMXeQGGMIwyB8nVfD1Q1QQ2/7uXB75GBbd3umcVizIYFdsoUb3tCF3ijQSxa5uhpQsxmIcI3WXaxfPi7hYeBJ5ZU+H6QLa0Sg5HC3GLaRKf182Ei57At9VvmYbfiu0XwO+TvhvxgQiJhoQ+V5ebZGCPIEGJe7ph07GEcjU+moll50M7E0cc4sFFlhJVpePKvHcPAFMk+17Of6wNyqQnR4e5jaFDInFvLDaqcur7VOt+knzyM0gNEn6uzTiEOG8YMvaSzchDHYmy+Eh7NrRb+X4OP+V1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2i/vUeR+zOKR1IwB+qSEAvV7WezOSt1wfUJ58u9rSQ=;
 b=KA1GB3zvLi3G7WEHooCWkLnE3ZdmNKA0TmFcVDGee5J4CI0oMN1f+xOFeZbMl75ormSSqNzpiaCO8t9ji1Gc0f5Wm1aGSxNFY2mcMTLaTdKHyY2Gq4E0fpJSXA7dWFNvlfUVUG4ay+rrPmdJTiRBY3JkEkYcFc0pHu4u4GPDqB5jlgRgHVYAinlD40du51Gpft6KL9HOxHbf+CLd0+QXlrtOJcTiESGz9sfeUkTBASPzbuneVTUS2C+R09zbxW0FdExM+wAeIQ41tanPLGDTBHfU8DrPKk1x66SMzs2+/KfYB2qT3XBGbTGbx0DOhfmc4NqGqQ7dHGjDv7f79lz1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2i/vUeR+zOKR1IwB+qSEAvV7WezOSt1wfUJ58u9rSQ=;
 b=Dr5d+WpgNBcZCXQnYa8CY2igfgfI5LJ5JuC7fLCbYUUGXRqiDKUfbr7Zm0C8Ax91r34O7RXVCPIJYZuCfChXcFuptGteu+0D3b6FOKLUysYBWB2a2WGs9ZKjSIV0Tt2vrrHmOFMu3RfwzFORUkHnGTqsZCQrAjVjivw1GpJTCa4=
Received: from CY5PR17CA0055.namprd17.prod.outlook.com (2603:10b6:930:12::26)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 02:11:50 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::ec) by CY5PR17CA0055.outlook.office365.com
 (2603:10b6:930:12::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Wed, 21 Jun 2023 02:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 02:11:49 +0000
Received: from KfdLnx23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 21:11:48 -0500
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Access gpuvm_export_dmabuf() api
Date: Tue, 20 Jun 2023 21:11:31 -0500
Message-ID: <20230621021131.2449890-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: f57bcdae-0761-4644-fd39-08db71fcdf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkEJxh5Df/moOUyTcKyq0RvbJnDqlrA5gPr12JtvovObTwy3Wh9or9kBFlWdL8YJWWn8Cmywtxqv8ccvJF0bzfeiI5ISn0RIqFhjVpN6h7q1mRIRMfrPy90yPOwRlEFhxQHSC12XHliwoMXX4Jke4Nfgpt7T0GOh5XGJqluoOxZy7GDvI/6OccQfjMPY60rnvqk2fG/6szuM2ElHoxudZMaFpnLKQBk7B5OzWNfX5ketr9MZGkUqAP8/M/YKR4SiMLPZ7IJ8A+rWQhKY5eIlxxf20QUXWcXNw0DvKbjBjVowVmVwUi7LOwAADR+qsDcsT2uQt5V5hPCTuuzaeTyD/USYtqq6HG/kNTFwJbx6E6TKEWhTt1wskcgchkZ+XBvgOQijYHx2LlHBwPZZP2szdh2RKXyEX7ah3mbovZcnY1rguVMjQ4y1uqBgategfVPz7BLPLaadeDkZxhV4ivB7fSL7X5DoqRs1JqyhQzESGlw6XlRl2tgMEUxY9sHpGcoEoNG284Gt6Qi9zAtfNsSaEV3OezwlQx3dXJ1TiPxD+YeRZ9+Hr0hl6N4K6OqEnortb7zlpb/IMtt4HJT8wCqQixiz/aUGtSBkWP4HWGXF+1CbC5MbVVKNneBBCWspdxNoUJwsbMXnsWtOwBy3dP/FxAJvrt1F3ALZ3GsENoNAeuQtCfXAfEWI2ofXFE6gwwVwckTDblk7zKi4VI8W8PzgYkhRFbLxS1684iedrI2BHIuJC7Q7Csv1EbGW52JLzjYvyQwSybXN9hOx5SWdMr03cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(2906002)(5660300002)(40480700001)(6666004)(316002)(41300700001)(6916009)(4326008)(40460700003)(70586007)(70206006)(426003)(336012)(7696005)(478600001)(36756003)(82740400003)(82310400005)(86362001)(186003)(2616005)(356005)(81166007)(16526019)(47076005)(83380400001)(1076003)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 02:11:49.6934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f57bcdae-0761-4644-fd39-08db71fcdf76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Call KFD api to get Dmabuf instead of calling GEM Prime API

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1db0ab3471..c37d82b35372 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1852,13 +1852,13 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
-static int criu_get_prime_handle(struct drm_gem_object *gobj, int flags,
+static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
 				      u32 *shared_fd)
 {
 	struct dma_buf *dmabuf;
 	int ret;
 
-	dmabuf = amdgpu_gem_prime_export(gobj, flags);
+	ret = amdgpu_amdkfd_gpuvm_export_dmabuf(mem, &dmabuf);
 	if (IS_ERR(dmabuf)) {
 		ret = PTR_ERR(dmabuf);
 		pr_err("dmabuf export failed for the BO\n");
@@ -1940,7 +1940,7 @@ static int criu_checkpoint_bos(struct kfd_process *p,
 			}
 			if (bo_bucket->alloc_flags
 			    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-				ret = criu_get_prime_handle(&dumper_bo->tbo.base,
+				ret = criu_get_prime_handle(kgd_mem,
 						bo_bucket->alloc_flags &
 						KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ? DRM_RDWR : 0,
 						&bo_bucket->dmabuf_fd);
@@ -2402,7 +2402,7 @@ static int criu_restore_bo(struct kfd_process *p,
 	/* create the dmabuf object and export the bo */
 	if (bo_bucket->alloc_flags
 	    & (KFD_IOC_ALLOC_MEM_FLAGS_VRAM | KFD_IOC_ALLOC_MEM_FLAGS_GTT)) {
-		ret = criu_get_prime_handle(&kgd_mem->bo->tbo.base, DRM_RDWR,
+		ret = criu_get_prime_handle(kgd_mem, DRM_RDWR,
 					    &bo_bucket->dmabuf_fd);
 		if (ret)
 			return ret;
-- 
2.25.1

