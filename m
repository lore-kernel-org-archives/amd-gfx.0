Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CAFC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5B010E438;
	Tue,  9 May 2023 22:21:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5E110E431
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gniprr0AcoRXS+vb/Oepc6gVpYXythbZkuSuRt1ba38rvBJYzqixWSzhBiZq8WTQhmv3Myv9GG8NKZPpYm5fR9Vxf7VH5SkxDl+0/VfoOyOqgO6fk4e4MMHe5G5GBtW+2hYk1VcXo89L1O4EiiyVFL4qholMMsUbMr7PUhzdmMrFiR/Ad3YeBz8maM9qygN8pC/gYrt3KfiYqyHtfX3OGvKLyfRknk6I6kYSmoK8OrpseLx5/i8xi1ngMpp/fcuKRUXH93Tozexnv4BCaTDd8zSgiyrrjfDizZ/Jmscs0sDfCYWixwsaIBSiqpphgeMswxawUB4/krmPNIIt9Y4pdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7kmAFc6rTA779+vkt4V6tDdlk/SwhY5cAPk8MTKxes=;
 b=dlQykunm31j/5Vzlg0wMutfZFckkCq9DXgm7Q4FrwzLyPLxZlbxkHv6ChN49jGIylFM/TITeOpI8/8qV1MYkJrbIr/pdJgAF+H2r3QYxplqMlWpH7zypdjSb/+mkZJWNE16KSjsc5iYRi49EueDzT1E6U7GQsL45yDn9stXGbKxF9ZFgQm5JOUcDzmlVpQ8fBshlYJsy0SWcvCJBTZZsqOcq5QbgeZGnSjEnnrwubzlN/4uOAiCxV3cjgCT7UeM0VlTrSmxXZqUjNo1BFFW5AgtPqoeINUf0B8CXXGvNg45GzDr91ECyFL/HleoD4KWQhR6MLQKYfLzxpRnzqPX6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7kmAFc6rTA779+vkt4V6tDdlk/SwhY5cAPk8MTKxes=;
 b=2Y2+TcgU7bKLwsgf9YyeQfEe3OpGYoIh1xEOozV2y0JcxFdBRmxQit+6nFtYZNb0rVJSBKuTDdZDZTyimyHE+rx2ROF7j1NT1VyPg+TXN5OzDb1+lJpizFY59rBXJWUiLNBQfiKWZ8o3xbw8zXFsdiwXHdx3cXYis8uUE6QZwco=
Received: from BN8PR15CA0010.namprd15.prod.outlook.com (2603:10b6:408:c0::23)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:31f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:21:44 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::fd) by BN8PR15CA0010.outlook.office365.com
 (2603:10b6:408:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu: Initialize jpeg v4_0_3 ras function
Date: Tue, 9 May 2023 18:21:25 -0400
Message-ID: <20230509222126.477847-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2f07ae-95e8-46e2-4da5-08db50dbc579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFxk4/ulm8mYSD0ssS3v8jM15/FOlrRmnyG0f+aqGII6W9OXoHzV5kqbgD7TnsRJbrLWjvbjmonDpdt1lWpE8grvXcr4iKdJ1Vd6TWRzxZSXGejm5okK5RfW+PzZw2E2naSk7HSoKQlEiK3j57feyOhQCX+5PKwDVVZ/E3rAubtc/YieLt9gxP42/yJ/jJSww5IVvhu0dzeL3XUTVcplEBWejjIqJkCdgYrsERCodBLtilMvEvkzDny4Y+dWcX/mEHzOMQ055Vp1WVS1XrYOxxeRIMeqw/EFe+bZg/xeUhiYjwR2pmogk/4UfAewD5acRg9EGkDlKya6WMl1ajGpFy01zpeu8iUADS7cutAWZmzbTwSEytlMP7InPGqARaoifMTKDk2n2ZHmTPA735xJEVrr+7eqTqBcWhOH4q5qSvZjzS58LBf+rVI6xnjPzmZHKmwOyHe8a7DyE7Eh7vxxjxGYiaSoCRSDQRsfyHKCWZzRl2JXpI7KirmXKRoPAqmsKdJZgr6rUIvJ4kfBm3jF72XodMEGdOXKnfuMOx97H7XqkUEw/sbg9e3I09n8HeQJ0L02o/BPbZlrJVH0dsF1zVG0P/ePtMdtzoxd6ZSa3ay3LLuD6ASf6kEK3Fq9SloCmlatIrdYBIxg+ejoMUmN9fqjGYtVPFRbdgkiAMQnBJOxH9M2k4Rtf9Iw5kTRXdyiEAzu4ABXVuPgNBbEOqgmR7BSHK5TiSicOi1CRuAqF38=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(7696005)(54906003)(6666004)(40460700003)(83380400001)(426003)(36756003)(82740400003)(356005)(81166007)(336012)(47076005)(36860700001)(2616005)(16526019)(70206006)(8936002)(8676002)(478600001)(41300700001)(186003)(40480700001)(6916009)(316002)(86362001)(26005)(1076003)(82310400005)(2906002)(4326008)(5660300002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:44.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2f07ae-95e8-46e2-4da5-08db50dbc579
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize jpeg v4_0_3 ras function.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 21226d6d26f8..ede15a3a4701 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -40,6 +40,7 @@ static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_3_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
+static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 
 static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG_DECODE,
@@ -67,6 +68,7 @@ static int jpeg_v4_0_3_early_init(void *handle)
 
 	jpeg_v4_0_3_set_dec_ring_funcs(adev);
 	jpeg_v4_0_3_set_irq_funcs(adev);
+	jpeg_v4_0_3_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -126,6 +128,14 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 		}
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		r = amdgpu_jpeg_ras_sw_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to initialize jpeg ras block!\n");
+			return r;
+		}
+	}
+
 	return 0;
 }
 
@@ -1046,3 +1056,19 @@ static void jpeg_v4_0_3_reset_ras_error_count(struct amdgpu_device *adev)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
 		jpeg_v4_0_3_inst_reset_ras_error_count(adev, i);
 }
+
+static const struct amdgpu_ras_block_hw_ops jpeg_v4_0_3_ras_hw_ops = {
+	.query_ras_error_count = jpeg_v4_0_3_query_ras_error_count,
+	.reset_ras_error_count = jpeg_v4_0_3_reset_ras_error_count,
+};
+
+static struct amdgpu_jpeg_ras jpeg_v4_0_3_ras = {
+	.ras_block = {
+		.hw_ops = &jpeg_v4_0_3_ras_hw_ops,
+	},
+};
+
+static void jpeg_v4_0_3_set_ras_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.ras = &jpeg_v4_0_3_ras;
+}
-- 
2.40.1

