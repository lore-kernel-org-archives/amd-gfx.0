Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D65C7EE2C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 May 2023 07:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E9A10E7CD;
	Thu, 25 May 2023 07:46:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B741F10E12A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 May 2023 07:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwHLNyYLJmrBdF7tOVqbSfGxD17jy7DHK81GBybkkbyEWZ6AtRQ1ZLOsY/DoAY/caGtCgMD4TJpqnHBu07KGZpuXd60JVzhPzsmiFzexJsaxS0lzpXcmZRgujhGAhdHDvZhdCZX6WpJOZ78hYXAn5PvwTib3omeUVxMbqwTK7COSiV33aX1Pz/Vg7Z+EccpB4U+1WTOhrHy+KHn6F1mweiS5x4Ghdv/i7WZUTYlA0O1iZyEKkN5wBoR+hElRofYH5NQFnhKZtkDq7T6m2LhzUqDYOwKBxpyc0EvwwB9/tFCkVz8wM2i15oUkFuAE51YSeiftQk9htNewwyKEUOWhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUpHT99ODRseG+mJ2Qa1DyGHDwZFfbvTM7ZV3g5/3Bs=;
 b=FLVajcPUY8ygqpqTZKV4p9442K6a2GhNEYah45n7bpXvZkTPBeQxEsWtbZ5g2zqgogf2C9/8RCXFl0LmlaQTAlYUiqhuvW87fMFwz2U6h1idd60S2uPWaXe0DBMhr3QarpDVKPRjL2pRu5YWnER9xUOxQphU96DeoIHOUFJTA14BUHh6jtV2zSw/79SV6gI2rI6p5Gc1xeh0Yk9Z3ySuA6OiEl2ProdoW26Xwa2L8V6oTLho/XG2mC5vL8vRDemXiyA8WCNYAlIEIcDxBVM4pwEB+9EFEnIB1l3BFRTYUABL3k6mqCUj5JaHN6nRKc/Tirbjeqn+C2pAohpRJHAW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUpHT99ODRseG+mJ2Qa1DyGHDwZFfbvTM7ZV3g5/3Bs=;
 b=mMBogheAlrZkk0FEiHEC84+1JLlhrOeyOegm2iplZMz6yHN5D+6/R94AEyx5PjA9LJKfAy5ifCvvKqvtsKLsGG+hV4bZ1q8n57EkoBLsW30EOC7cIH9zkmvAVOqq2UgovuJmV1fJqZBh2H+woadqhkFx7G90Lqap0+OMPQFyM3I=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 07:46:42 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39e:cafe::b9) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Thu, 25 May 2023 07:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Thu, 25 May 2023 07:46:41 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 02:46:35 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add the accelerator pcie class
Date: Thu, 25 May 2023 15:45:44 +0800
Message-ID: <20230525074545.24166-2-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230525074545.24166-1-shiwu.zhang@amd.com>
References: <20230525074545.24166-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: d058d943-b657-4383-d963-08db5cf42e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afSco0dNDGnO+4wfNxVIVDGrEyLRdpsBx+FLDb2wkCUYNaqdo4mQmjLqcPxxeLjqqsvHhlKAZPvkpnFjE1McUa1zNMlDQbbWk7rGrjXuYZAgJ9hbcQ7uWpAdImuZPFY5CjasqeidpnMlovpW2JSI5VoGwlQykqMO6K6qLYqwotqVD48MIORA7n/3ytzL42e+D11XZHVJh3rO2uWtTXYsB9KigBl8uMNrCl4N628CeOtQxJJM7v1onMBsQY/YXP8z1OurA919Nlt+jIl+7a5mtNASomTSVUQiNCwvMnw/AC5PaDx8BT1hVUJ71sAlee9i0EZHkIu8V4XpGzBiEUUzctDCY0Uxr4KSv5RGR/jZXD9LJaNZLiUieteQB//TWo+86ro0Xhr5W6qpSzGfY5ie2i7oLyuiFXWp7rJD3p8tn7DyTfXLfR0kU0tYgu5a9BbcVv+6DgEpcMMzoq0iSiYXKJLa2zbcUFRPhys9+kk7Bba2pBWrwWqrPjwWrgFHK8P1U6cO8NLPetpQpOYDkaNX2nGEeHCNpVG4sPFC4suNCB6nXfagOKOhhm7Ih/+ogCu82BDoZLkLJe5vwNKD5y7/izTwDMMbIVQxDN4dt3Prj19iMmG2Kgs84Q3CqoH3LeB8pSL5HooIONxGRb3tbUWjpdN9+QpLmkWiqHEfO97m+ez8fiSonOBlTnCRcUCO6I49oJzLogiU+s+6WDLMVmXB306hEkgKLPZk3ZRs4i/3DWADZVmnqmhq+bUSTHEirdTNydV7oZYNxxfIZACXeNB98g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6916009)(70586007)(70206006)(478600001)(316002)(86362001)(36756003)(47076005)(26005)(1076003)(336012)(2616005)(426003)(36860700001)(16526019)(186003)(5660300002)(41300700001)(8936002)(8676002)(44832011)(2906002)(7696005)(6666004)(40480700001)(82310400005)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:46:41.5299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d058d943-b657-4383-d963-08db5cf42e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
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

v2: add the base class id for accelerator (lijo)
v3: add the new pci class in amdgpu tree (hawking)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 5 +++++
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..7706919c029a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2042,6 +2042,11 @@ static const struct pci_device_id pciidlist[] = {
 	  .class_mask = 0xffffff,
 	  .driver_data = CHIP_IP_DISCOVERY },
 
+	{ PCI_DEVICE(0x1002, PCI_ANY_ID),
+	  .class = AMD_ACCELERATOR_PROCESSING << 8,
+	  .class_mask = 0xffffff,
+	  .driver_data = CHIP_IP_DISCOVERY },
+
 	{0, 0, 0}
 };
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..57d95e2cc54b 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -27,6 +27,7 @@
 
 
 #define AMD_MAX_USEC_TIMEOUT		1000000  /* 1000 ms */
+#define AMD_ACCELERATOR_PROCESSING	0x1200   /* hardcoded pci class */
 
 /*
  * Chip flags
-- 
2.17.1

