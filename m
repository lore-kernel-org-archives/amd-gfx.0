Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AFFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F1010F104;
	Tue, 26 Apr 2022 18:27:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A4210F160
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikd4CsLlptmS0Hl3WX6H9q0eA75RSkjLbBWF51hsNDLv7oZx8axpEJOlto97raAS6n+IT4qnXFPGrvRzIIHBaM3LzZ4AJi7W6h6CbehDcOTjfV8i2p0mjft8cWIp3VPtq2nxG4ekIGXuwEJehZpAtHaQf2Enra5WV6hnwEr8u/BogdCeiBD33O78MvjTIVUNCFN/DaOYaZ0AIhBtXX1tGCOi5/Fizb/u3worg8GPwonL8tGldpb5/5sizG7/sK04HjIyV+78oKvBY1QDB9hcplOVUuoKt+nYC+kNOMAWLMWovkdoRvJG786mPUovwm6x+3SJ+W90/sVrlkVaqXiAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uNbss+jORJvETUrpC+btoucHn4M4gEAATspJur2g4E=;
 b=iTnTMavcuwUEDVvC2k4VVbKGlsHZfl6OeV7iSmbiMfVr9uze4BDTXCgfeIAge6auqYvVCerMSoE86XmPPoxuTP8+fSK+YZw5xRTlyFcbJtmxZj9WuPm9xCV/bLXx1o9+nUyL/UmOr5nIPac8RsO+B/TlpFZ8S+xGI/XnxlfxoV4WatYUwkLwMFJajnfqYA5K24QHEk5x9TOCKmxZR4+Y3sSiHRqcXVb7W9y339XuHfUD1PWyKaRNS0Ix9UFDk/whclEmynuJdnXpsLHej8QNHWFvIwS0z0CqBqWiir+OpaTueNJfaLtV9vyBmcYZQRZQAE8cQ/gpkAJ4yeGJPLFvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uNbss+jORJvETUrpC+btoucHn4M4gEAATspJur2g4E=;
 b=imnc77+vlBoUDiVfd7PSMCpbuf6pyxMeHgc9BCCTf5J4jwqST4NJs+o+YOXpVT2hhf1xMWmpyYrnPDUAf3SJsd0LITEw4ZfUuNv8LIOHeBZdsVMlCS3tL3WtBkjuTjYTuACx6tkvOGhtgauvIepvhDE0eBOV0eymzEZ8AWJe7oY=
Received: from BN0PR07CA0007.namprd07.prod.outlook.com (2603:10b6:408:141::24)
 by DM6PR12MB5699.namprd12.prod.outlook.com (2603:10b6:5:35::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:27:55 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::e0) by BN0PR07CA0007.outlook.office365.com
 (2603:10b6:408:141::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amdgpu/discovery: add a function to get the
 mall_size
Date: Tue, 26 Apr 2022 14:27:24 -0400
Message-ID: <20220426182728.3006737-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182728.3006737-1-alexander.deucher@amd.com>
References: <20220426182728.3006737-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c3e912-5709-4fe3-7803-08da27b27abd
X-MS-TrafficTypeDiagnostic: DM6PR12MB5699:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB569980FE0E2FEE082366D357F7FB9@DM6PR12MB5699.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9+0G9zClYZz2oyjSBeC+MQZk1EuGOgxZCAB9Nj3SldzMlqpo632cVEhMYOG9//aP+8QRrgUQZRgtyMwcWNWxwJ5H4QFNnLJCNUztfWozHRc+l64pEksMPSHv8/zL632+7+Z3SD4jAgvQuKcKUcJkn7c8uJILtc6njIyrfKy0APCN3GXBVtbKlf0KkvUi3LH9FpEHyAEuLmKZKtFBAs6Juz/v/BaMbn6zC/c1GoP/UCIafXrU9QD054CrvktPN1Z0qTdgVrIKscB8QtGFkEO74rjsKl6T+69lcKD/rXtU+9BV7vXEEehsEFrnaSuuckErlvrkx4c54i2itF3yBHcxBVrDINL0JKDyCklvO2Y2+LgC8vElCOw4LpGyTsKE7EKsPEaibWEMcKCo//I569mMqn8Ug599OLfQo/D1L07Ba8A6U3+qfW9WZoekXZeIcsSkCx+pRnk2HK+FpoqKcj/O4XUSLUQu3VjDs3PfmBnGdOaqEeQE2HIIkHh08VNdXdyRQhBvjb4O1aO77OCmApALSsvU1saoeivLLW5Uqa31kb8SFk3AGxIbEdp0b/x4tfGc2yrHPQk0u7jbSdmnRprj6xG9RAXpfngkL6bdsfA8GMzcTHbn78l4SNeycV9huWCLhb2cJFKqcq7hZTHCPnY8Uj4TsIgb6GlRIpxeFvs7Yi6kNzNBD3O2ko1jaN/vyqqShijaN2cKzPwrjkYTlSVLO8LWsDuUTMGzMOE2Z58lEQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(8676002)(4326008)(36860700001)(2906002)(6666004)(426003)(70206006)(336012)(7696005)(83380400001)(356005)(1076003)(81166007)(5660300002)(82310400005)(508600001)(86362001)(8936002)(316002)(186003)(47076005)(16526019)(36756003)(26005)(40460700003)(6916009)(2616005)(15583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:54.1527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c3e912-5709-4fe3-7803-08da27b27abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5699
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

Add a function to fetch the mall size from the IP discovery
table. Properly handle harvest configurations where more
or less cache may be available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c16239e47141..402e125649a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1250,6 +1250,52 @@ int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+union mall_info {
+	struct mall_info_v1_0 v1;
+};
+
+int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
+{
+	struct binary_header *bhdr;
+	union mall_info *mall_info;
+	u32 u, mall_size_per_umc, m_s_present, half_use;
+	u64 mall_size;
+
+	if (!adev->mman.discovery_bin) {
+		DRM_ERROR("ip discovery uninitialized\n");
+		return -EINVAL;
+	}
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	mall_info = (union mall_info *)(adev->mman.discovery_bin +
+			le16_to_cpu(bhdr->table_list[MALL_INFO].offset));
+
+	switch (le16_to_cpu(mall_info->v1.header.version_major)) {
+	case 1:
+		mall_size = 0;
+		mall_size_per_umc = le32_to_cpu(mall_info->v1.mall_size_per_m);
+		m_s_present = le32_to_cpu(mall_info->v1.m_s_present);
+		half_use = le32_to_cpu(mall_info->v1.m_half_use);
+		for (u = 0; u < adev->gmc.num_umc; u++) {
+			if (m_s_present & (1 << u))
+				mall_size += mall_size_per_umc * 2;
+			else if (half_use & (1 << u))
+				mall_size += mall_size_per_umc / 2;
+			else
+				mall_size += mall_size_per_umc;
+		}
+		adev->gmc.mall_size = mall_size;
+		break;
+	default:
+		dev_err(adev->dev,
+			"Unhandled MALL info table %d.%d\n",
+			le16_to_cpu(mall_info->v1.header.version_major),
+			le16_to_cpu(mall_info->v1.header.version_minor));
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
 	/* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 14537cec19db..752fb2e46849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -34,6 +34,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
                                     int *major, int *minor, int *revision);
 
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
+int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.35.1

