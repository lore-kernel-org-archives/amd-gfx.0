Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C902FC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 20:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A8F10E614;
	Wed, 24 May 2023 20:35:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1823910E60A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 20:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+6OzbRc0i5TX09yWwcx+dX3Mp7IhSIMffOtmPlxlIn1eiKfyhroO/y8hWw1nYOFYc8dTANHSTKT4BMkmTRwZfc+4KaR2W2EK+LwbH4ljEHUbSiOtxMFe34obd6HIDJusuZgKFhSjRUaSSWDLc/fF7Ev3+QO3dLVL3Cm4p5mcWl7CEqz4KutCf37nTl+kAXWuqXO0O6H2RXtPOfZFfSYFU0YLyn7+9IzBDHkUOiA2j5rdkCWCP4ho6+J/TTDQ9ZF+zRb3NETrmc99O7Vco/K6j2+HOLCxdVhsU3VWxC+o+BL8g1Ld0yAs/o85S3pAYB/npLBpzMLd7LKHXfSrSVxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUPK6NzWjOfx4C9NEXahvxlQp2GTHDU/CpPMqewuQqY=;
 b=iJqOQCIZ0O5mNS6hGs4INgnPPLeXKMmYnDnSnkOrAd1DzS3FL9Sy82Y42yGkzkaMBjXlJLHoqRIYwQX2k/MDxjphLAqASM/tuF/qpORsc3fr9vLVPVhycsQXqy0OU6sb0MKufFmdYopFW3nLJT0NFl1WjWucaoEyqqIg/S4/8qg2k30HNiw7F6C2KY/njwBg0y43JH5+dL2uTZ8DoY86ZFwKwkpl5FE4dupyCQOwjSVkmMua8OB2+9PT8q+z1Hs3/qjq7HofJKwRLy93SiL6hE+I+Bu7AzwYXeiSKkAPvW0HH3DHn9eZTJs5F+Y87elVEQdXpOhaEBc0FISoL+UjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUPK6NzWjOfx4C9NEXahvxlQp2GTHDU/CpPMqewuQqY=;
 b=Do+g6EnDfCUctLMQN4gE7gdVVNfuQNlFr3JNE5stYmclHq6k3elhONZGRzBoT6WNropZXOvmPHxlGSun9kjLt0SbvNBZmnjH0M71uC5GoWrpjYROJ808/p8q2Rea06i2uo8P12U3JfJl8GPPrpb3BdKg/wG8T2YTmI5+JbChweQ=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by BL0PR12MB4899.namprd12.prod.outlook.com (2603:10b6:208:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 20:35:18 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::8e) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Wed, 24 May 2023 20:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 20:35:18 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 15:35:17 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <ying.li@amd.com>
Subject: [PATCH] drm/jpeg: add init value for num_jpeg_rings
Date: Wed, 24 May 2023 16:35:04 -0400
Message-ID: <20230524203504.3568374-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT060:EE_|BL0PR12MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: a35d2974-b0f9-4695-252d-08db5c96632d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1oNjwhAQlM9RZ5ec3W0Vpv9KxqgBwueGodraxJNHWnS90aTqY3i5dwIwEeteRYAvXKUgyRa16+hXQ3S0/R3C7ZutbcBRueus2d+xiTLDKP9dIv943GWaxQrui8Ch9qgF5vRaQ3hFVdtuFylZ8KU5MIAucWxKAFLXrOTABVgXB4AlfoFfklbAjIyt64LDJ3r1MTK3g7L+DF5OBPlukrt3nKLCfUPuh+F1U0oRHEbJD8IB+g/551o/1aJKP3IePuGSPqJ+5bG8gUzFnqQzt5pgwOTC7l1xwQCJt4JhzM7zMSuPnwoeMdS4yJmTtfQpUVCIWob2luXDqXWzAFDPOLnKSh5yAlizYL4vVWbXmdiPvBgJzl7bvxDndcOiDoaCvVx3e/HN/HW+Vja8n6V4cYSonEoX+Esg+ixJ/RFEosT6HrDxCH9LsBwrFR6PIbkkuVPvlcIp1o9U1jPmtV+Q8x28fqA85Gb1EyH7Aiy65aLh0n55NaFzbC1xMBg4BCUDOzQscYLib/KYqtPVJv0e5P3ZVF6Swg5KNP0mhqNawqS3PAKvjrfICOqzq8C95j6NgL79DSJdBs1ryMENYJZXUDz83yZqVqd0et2g6BN1NwVdOA/5RPWEg5Sdy8jBNjGjFelfXzCUdJDVvOvH9EQlaPlI1jpCjbDQH52ZAQyAB2loW76ETUM3un+hwzWdntbHF+Hu0kMANPGc2U5K3OKQ8eOBcIhvdJ/Fh+A4MesGm5w0ljQaRAJWe+ZTxh4IbocdgRnSi70PR0vkM8f/2i3qEkoRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(110136005)(6666004)(26005)(1076003)(70206006)(70586007)(4326008)(316002)(6636002)(7696005)(41300700001)(478600001)(5660300002)(40460700003)(8936002)(8676002)(2616005)(36756003)(86362001)(2906002)(426003)(336012)(356005)(82740400003)(81166007)(40480700001)(82310400005)(186003)(16526019)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 20:35:18.1028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35d2974-b0f9-4695-252d-08db5c96632d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4899
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
Cc: bonnie.deng@amd.com, richardqi.liang@amd.com, jason.wu2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need init new num_jpeg_rings to 1 on jpeg.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 1c5b60604a19..77595e9622da 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -460,6 +460,7 @@ int jpeg_v1_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v1_0_set_dec_ring_funcs(adev);
 	jpeg_v1_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 3aeeceae34a5..c25d4a07350b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -49,6 +49,7 @@ static int jpeg_v2_0_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v2_0_set_dec_ring_funcs(adev);
 	jpeg_v2_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index f533ede484d4..aadb74de52bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -60,6 +60,7 @@ static int jpeg_v2_5_early_init(void *handle)
 	u32 harvest;
 	int i;
 
+	adev->jpeg.num_jpeg_rings = 1;
 	adev->jpeg.num_jpeg_inst = JPEG25_MAX_HW_INSTANCES_ARCTURUS;
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
 		harvest = RREG32_SOC15(JPEG, i, mmCC_UVD_HARVESTING);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index cb5494effc0f..79791379fc2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -64,6 +64,7 @@ static int jpeg_v3_0_early_init(void *handle)
 	}
 
 	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v3_0_set_dec_ring_funcs(adev);
 	jpeg_v3_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 86383fbf9358..a707d407fbd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -58,6 +58,7 @@ static int jpeg_v4_0_early_init(void *handle)
 
 
 	adev->jpeg.num_jpeg_inst = 1;
+	adev->jpeg.num_jpeg_rings = 1;
 
 	jpeg_v4_0_set_dec_ring_funcs(adev);
 	jpeg_v4_0_set_irq_funcs(adev);
-- 
2.34.1

