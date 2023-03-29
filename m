Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10ABC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8489510EB6A;
	Wed, 29 Mar 2023 15:48:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA1F10EB6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeNw13BjH233rX/60Bq/JkFvaZYK+rlSUmQvz7JE95jqaJmt7uDBAdOGEz6mGNFm5C1nZuoMV7c6fsT0OHhQ8+1jHccMGtbPjO8/0+T9xuebKonfYj+HtkaS80ygo9adnbDFzz5KXej9QIg6bQk7OWwLSPXJx6f8Qvz6u3WD2dgvGIYN+ZWxuZoK58vd+fGFhdHZgGzx/WGXGZsgPd5YVK7c+SmNhPOq0Sa9HdeaJH9T46JQOsgVDXHcEfE2UAAxeDEbsNv0ZcDJs+2OUNPOqpVjJK4IyjbU1bve0NiApjknptRI7mJyhia4gJNYMXTD05dUARRvxi6WCYH5TpLskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+iW6GblJP03bqWQNMHhybvrXoxXVBcl5EJLbFmbi/0=;
 b=JbyOJK4ttEIovFyS5F/loJnto2M4udtSL1pQxOJPSHsKfjg/l3s9+h2baOBEcLAJ79SPdD0dr5wktEOZy0FfEwJ/b7kkuetw47GQlfjYVZrw/qoJMW6P1Xb7wpUiIE4noLKh/QxgqzrGk2EFNydvmY4JUWhyu0WeSQLhVrpKr6l6TciZCYb6YmWfLuqW5wgaSCAAFHo+1S3XSD+vHtT81kwHhdZYHZQOwtTsp2ylPcS6XLScz5NHa/VT17BAK/VkhflJ1DM1feTTwnb/FpLZ0OlcABGZB0DfoO62Z2TDQUAasW725kHum1lYLS6UbuZJvX/LENg1PhpQ7eoSELtylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+iW6GblJP03bqWQNMHhybvrXoxXVBcl5EJLbFmbi/0=;
 b=ydXWhCTMtAZEO5PU2dSpCBg88k4kqlw+fHQ4y454YqTpP66OhVUNPHsdrqhZ9/xXwjX0LM6rThWcpINlqVfwsYvZRPQG3Ai86BrVHY6dKaHpW5bHeV8LjHl/PH5pL3b9X3xizii0J/b9TY2q1P2JS8trbXHyziU/Wi/yQTCyQu0=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 15:48:21 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::6d) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:21 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:19 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amdgpu: don't modify num_doorbells for mes
Date: Wed, 29 Mar 2023 17:47:41 +0200
Message-ID: <20230329154753.1261-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: dce2ae95-caec-402b-9b65-08db306d064f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NpmKS+LZW0wUsEuFu6TsxCT86tlEki+H8vH09zg568gAiodzrtLd9sXH5yB9hwYMN+4qjNmhdIPJiLpr/qx7FhSGQX/VSC8Kz5FHrdyQ567polmSbhKq+RaVnn4UXySBwuRXGp+RpKEzfoqCyrDxcZ9jIxo88q+QX7BYo/eeA93XevwieCuInUG4H5/nMj9mh3QfzD3Odn5ROkTBZAZr01oEVHVNm/uYyzjQwYOPnnZElxkFPJRU5912bdVFvP6ia03jHPMzjR8O9NxgevMr2SFn6ivB72Ssw4yVdt1OwTzSKa7HYQ/Pi4TEwfSpCiQBKFIJUWBdB9kPs7LDL+MkLWy3Io3qpFEic6mz8xurUrMKKuuvCjxAqL3vpXsxkaB6UhPlToFVhHWiGx3TETSmzaa2vaZMnRA/CeWl43Fia2VAORTa3N+uuS05cBbYidJ8RlBbiSX1ke81f7RZmlOea4QAwG8TVlT9NwkBLybKzZIIqp5EzYkVGwMsDeZAjHZta3KAvKqN/jmQNYsDC7uAGE+tcsx5Wclur4awuFiuWG+1e9C3jO/Ox/X01/BVR/hc1I6DVCu/9P8Xu6Re/9SqvauRo8J2+F0lIUADsCp1w4Q354TvI0EjJXMzpaAjPJSY4KZcTwgq6X9ZcyKeoS0uHJ8jUtX9FvoSSR+sZ2jhkYDYs4/Dfcpk2rP0zFwY1dF8n2pMieDlrTQHqCFE+wiNh6zrXhvBhxh22ASo8M7tUc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36756003)(86362001)(40480700001)(40460700003)(478600001)(16526019)(70206006)(7696005)(186003)(6916009)(8676002)(36860700001)(41300700001)(26005)(70586007)(336012)(1076003)(2616005)(83380400001)(426003)(82740400003)(47076005)(6666004)(2906002)(4326008)(316002)(54906003)(5660300002)(81166007)(8936002)(356005)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:21.7724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dce2ae95-caec-402b-9b65-08db306d064f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch removes the check and change in num_kernel_doorbells
for MES, which is not being used anywhere by MES code.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 2206926ba289..1aea92363fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -143,25 +143,21 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
-	if (adev->enable_mes) {
-		adev->doorbell.num_kernel_doorbells =
-			adev->doorbell.size / sizeof(u32);
-	} else {
-		adev->doorbell.num_kernel_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
-			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_kernel_doorbells == 0)
-			return -EINVAL;
-
-		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
-		 * paging queue doorbell use the second page. The
-		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
-		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
-		 */
-		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_kernel_doorbells += 0x400;
-	}
+	adev->doorbell.num_kernel_doorbells =
+		min_t(u32, adev->doorbell.size / sizeof(u32),
+				adev->doorbell_index.max_assignment+1);
+	if (adev->doorbell.num_kernel_doorbells == 0)
+		return -EINVAL;
+
+	/*
+	 * For Vega, reserve and map two pages on doorbell BAR since SDMA
+	 * paging queue doorbell use the second page. The
+	 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
+	 * doorbells are in the first page. So with paging queue enabled,
+	 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
+	 */
+	if (adev->asic_type >= CHIP_VEGA10)
+		adev->doorbell.num_kernel_doorbells += 0x400;
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
 				     adev->doorbell.num_kernel_doorbells *
-- 
2.40.0

