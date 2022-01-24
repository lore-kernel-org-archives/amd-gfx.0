Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B34C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 03:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D564510E289;
	Mon, 24 Jan 2022 03:21:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55FDF10E289
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 03:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr/ZewhrPPK32D7dPkOJ0fF4IJZM9MUDmTYTEAVsVRCUHCfQNXPqkeJBGBs1LSz1DxVmYX6/vvQ/9/BIs6P5nWkvmADPBkKrz8dCrQlvYGOwDe/gxKGLWoeneZeZQ67jsWAN4tnqFh3CI2zSujbgr/ncRN6cIdld4bczE9rdF1rGlYaLTo+pM5QzcQsKshBNHTyQsP19QdRagjDCp825VNVZWw+DsZlOOgXXLiXZy2wj7GGxLjPPU56izqwu+D4GJfUX9A5fkRjp55sWQMgjJtwBieRKo/QmXjih5HhFE3m5+/ECk2jfjYCF/QDfz0YQXR1fGojFtQap+Imfei9F0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9H2caqyOkJnPEpUehj/k+PLjxbkImyS1yPYvietf3E=;
 b=UV1p/UZlr1Ezclsxd3UyOXOTW+izJ7zexbNe7s5D7l5Zv3BeLics+UErWSpbnRnvxH4Uh/P6ixhh7gGuVgkBbU0yrmlVAsl8PfkLDRp4rVQxF9fJqd/7VjjbEd5Re0mDWgXhqvs4yapvqBFu1/F5zrusAd4q7IrD3PwqG4QsO1ekMo0y9TzGSdKBO0E9+HBO6Ok6A5cIuHxBaEnZu1ZA2Ufjt0ZjigiNdZ4hnMOYjWbtBmY25rDT3kOHgV+oXOW/W3atGUV3cFyo3w8BoK7vqaM89VJvGhub4XnACjmWtv2ilaLQ7yIaX9NNi0Y2zDpEe2ktcVJ04OIWvbTMA1UcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9H2caqyOkJnPEpUehj/k+PLjxbkImyS1yPYvietf3E=;
 b=pqQm2P7v3bL1YwtU4almAG7XP5k+GYaWqawWecLORwN+6YcmCwp6AbmzZAs8P5sUMSGefv56DGYt4MJRoF55hUZ2Xyp0ztDmpsbk13bp7qgTM0XtJJ5uyyjiY+eYOKoE9b5LycfGTq1VWddYeC6/5Z3pvgx/1coRYnpvNwddwv8=
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 03:21:32 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::c9) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14 via Frontend
 Transport; Mon, 24 Jan 2022 03:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 03:21:31 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 21:21:28 -0600
From: Tim Huang <xiaohu.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: convert to UVD IP version checking
Date: Mon, 24 Jan 2022 11:20:41 +0800
Message-ID: <20220124032042.1974371-2-xiaohu.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124032042.1974371-1-xiaohu.huang@amd.com>
References: <20220124032042.1974371-1-xiaohu.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94bb5e00-5690-4767-fb07-08d9dee89df1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB46758E95DF7001EBFECC034FF65E9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7u8g7QH0q3D+wgIyo6jiYsShTKak/rzHi1rhL2l1FLUNnjCfkEDqnNiTyR7GitLqV+8zc3g7UXgQU7GZUecN0t984aQA4DPD/7u2eQwQMfGFVxY1A2/KD6Gr/8yC7DK4MkkGHjaPSvUQPjN367cShhCN0okjNT9gYsy4WGP1hOWyC0++39VouaTd1/S2udiJQViy5LWAyOQbWeAyaSJAGcjoDQlGFlH+PCj48q2IX8tMNpFbND9qTEz8LgQs4vlgAL+QqlBZsXjvtN9emlYqLvIqvkXMAznD7gRYxVhl9IS60Yqhi4/3i8u0dxmoirQi+oF26JFdJF67bKF/jljrTx7kQbQ5pSoCqNEXT5vBAR3RG0xD2yukJmwipHQ3v25VUJvAP25++jpjs6dsNUWzpEqBIbOc8KLPTXM+wNwidRp5Twpoxwqkzdkw8Fbi0QsRB5dJBbBympfetIASWycPI1y2hTq2Iy1lQCaM5l60BWgG/nRiCAVgcYY1QpvhCdcEIq6rEsNiEjsIsxMK78AM0eDa43F6t0S0RaUTb465G8QnWeB9N4ZLUzfEQ0q992ltRWPJGVRcjwdPvT/yp+p7+9iQ7/IxJ0YWBUX5y1iWibZNLaJEWFQGl7ky27YMa6ah+oO+QIJ+bmqUSy7L0MoVzo+s5NU7KQENzUh4br+nrXaZpuq7A8tuXXY8PGJLQKYvClbP5wBpgjNw3FTcW9u+/JAW+kcNjMesjbIA171ts2h5fOIsBTDWqvNx7wQWFCmrKYsNGJIyc0pht5XI34nkchVOwcBpSd4fwwqP/ILsYfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(36756003)(316002)(2616005)(356005)(508600001)(6916009)(5660300002)(54906003)(82310400004)(4744005)(426003)(4326008)(7696005)(81166007)(336012)(186003)(70586007)(26005)(6666004)(1076003)(16526019)(8936002)(8676002)(83380400001)(47076005)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 03:21:31.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bb5e00-5690-4767-fb07-08d9dee89df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron.Liu@amd.com,
 Tim Huang <xiaohu.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate IP version specific features.

Signed-off-by: Tim Huang <xiaohu.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 01c242c5abc3..c5ffb14ba183 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -50,11 +50,16 @@ static int jpeg_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->asic_type != CHIP_YELLOW_CARP) {
-		u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
+	u32 harvest;
 
+	switch (adev->ip_versions[UVD_HWIP][0]) {
+	case IP_VERSION(3, 1, 1): 
+		break;
+	default:
+		harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
 		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
 			return -ENOENT;
+		break;
 	}
 
 	adev->jpeg.num_jpeg_inst = 1;
-- 
2.25.1

