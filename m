Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E327C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 15:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842CE10E35B;
	Thu, 27 Apr 2023 15:27:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B92B10E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 15:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTdZENwKKgLBCkor6JbVtJGZfanD4Cz0C0QEAPtoDMnEMrz59Xjuwre3tcxCneyN7dbcbSaUdL5K5QXcNL0ohZ4pB/8eI3OcuO5iCWWVOSwcgSx2Ibq86GjIRjWIGybQ0PCy+sWahC5Xe3/b4dmGCNVk22Y8wlAUlLa+EsW4As6YMRkQiyqNzQfVjEOjphrR26YU1BgPBbdH2ePKONjddsxrDndt8GjSbGHzAGK3y83JrxKOayDOLV0JbO5n3XrlEsxWWKND1K3rYtUNDe++z0CxSEb6HP91uF0x1L3JirwpVMPRSxVyQWI+QYD/I3v29Mf6gs5OP1keaZsYpOf9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guMCWK+zXozuenlXrEYUbErfptCAUqx7sfFEIMQ+BzA=;
 b=MtTj+fpus5ih1F/lug9psgZ205cy764w76LGsK+KK2eU0odLy0UYmseipJPHbb2V7G7gDycChznQQ8Ld5a+R7zwV/uvoimECNCZFuUr9rb+bqtfIq/AY2VnTTXSdLVmlESodqMV4avahq9yxXhShEK/xfwGYHxqW/bFKFZimcAkcy6Tvag79v45SmkYBrxW+hgwHew5v56FwVtZSYeBTztgWTiT677qutNbNfJg7c1xMkvQmJBnD8MYqcXX1sjJs1q2kCZp9Svua2NyilnGkAHQOGGfmrC/X8aFFcTxLaVUP7FtuCEirdDUYM9ENF8mvOH9glCRfJSZ2tECBhFaEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guMCWK+zXozuenlXrEYUbErfptCAUqx7sfFEIMQ+BzA=;
 b=0kuh6vDBNItixkdepuM09JvBtHXa1XiSwyh6+4ChcP70wI1EHT0L9eRVglV9sojGigLBHRNQjPltaJJaWNMZ7PzLD5Z/WDb81Tc+3K+B2Fgh6GpN5Wz+BBuXeV9UKroltOKLZqC8JBczZFgaPwzvUFQ+5soL2aPjVG7qu80EerE=
Received: from BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::26)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Thu, 27 Apr
 2023 15:27:38 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::56) by BL1P221CA0014.outlook.office365.com
 (2603:10b6:208:2c5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22 via Frontend
 Transport; Thu, 27 Apr 2023 15:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.16 via Frontend Transport; Thu, 27 Apr 2023 15:27:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 10:27:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amdgpu/gfx11: drop unused variable
Date: Thu, 27 Apr 2023 11:27:04 -0400
Message-ID: <20230427152709.7612-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427152709.7612-1-alexander.deucher@amd.com>
References: <20230427152709.7612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f5d2de-1e8f-4e6c-1166-08db4733eeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALJaX8wzMohhPoSCGnQFf/6cdmNm6D3xiGMETuIqct19ggZKxyDzKOn/myY8evDFdkj0uFppktgxWas9pv+1hWIPQdtz5rY6CnI/9ZmMZRixLpB/KgRfSn3rJGjYsZ6TRvxY9TiClA88FIxAxJjZXuQVEI9XYn3FyFasofyZoGCIgjDzPIHrF2HF919Mn467q48WmYCjNnwP/jgkmT5xjWEQ8vKVe7Uqz8X/tgXKiGmi6IdMKdBp8/5JBz7SszfdH6Wob3KO935Ar+O7unbgbyns5CzBxEe4RDaUNaOWG+YotLXdcj8esctNGuoQmsfqw8pU1h/tEi5osDP9LxrUiIY6S5eyFyN+18izQqEAFw+6rF6157e7lmJussrj7mwVpPdCfRdDIZrDt76UiJyvr1OpZLE3815PDjeyGU0i9NWzGCtxAqMX4Ao2Jl/gD6tHdnL4ySovHk6VkYG0rT3pA4sCfht1p2fPSc4cr9xPQ0VJDrp5KXcRIS59tTuAqW/13htb/QaLspS/Ac3dTvlFMDGQgsYBwOAEp1skkpdhlbadwEZimb5vGck0ORe1TVu1WRwn/F+8piiCZCHE1xhP4yeO4l/FjlGAUZO238siRqnjkUM6tL8GO2iBxsyxGAgcGQbYdQgVXKfBXmrkiSdksIAKZtq7HynSGh3I2S7Q2X7Noit/ApFrubfjiB++L2XkKjMelYYz7tTKpZnh3k4AT81easQ67GVTdrZORIMGE9A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(186003)(16526019)(6916009)(70206006)(82740400003)(4326008)(4744005)(70586007)(2906002)(81166007)(356005)(41300700001)(316002)(5660300002)(40460700003)(8676002)(8936002)(82310400005)(7696005)(36756003)(86362001)(40480700001)(6666004)(478600001)(1076003)(26005)(2616005)(426003)(36860700001)(47076005)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:27:37.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5d2de-1e8f-4e6c-1166-08db4733eeb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Just check the return value directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d36d365cb582..256014a8c824 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4373,7 +4373,6 @@ static int gfx_v11_0_hw_init(void *handle)
 static int gfx_v11_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r;
 
 	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
@@ -4381,8 +4380,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
-			r = amdgpu_gfx_disable_kgq(adev, 0);
-			if (r)
+			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
 
-- 
2.40.0

