Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22608C761A6
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6179D10EC5A;
	Wed, 29 Mar 2023 20:26:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE1D10EC5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8+cdX4AsMBwC24crH2cER5fqIhX0hFnIqW29+w7m8C+RMkxx8heiInzOTIv5qf9YxsuuOhyYYx6U3wy3HcQXmCGZWiua3EecGLZV3+vlqmyMtudSAoZXBbTg4Luj996Ey3CTYAD7/bw1JlIPf6nCelUpd+WZhRuzaVR8kHEs1ShY5cSf3yMJMpbYuvThDIVLADpu4zw95CD3yMMwFYQdlTq8q+z+k2TWQ1SMPi2udleeJNiYzXgiLAxZwQm6LpLNku6or6ynZgaRGGMNvcSSNd1/e44e+sdQqHoz5n50ukkEe2BtcuEL2m9MjISBIjzYhnkWtRaBVWima4yWxtxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD5TiV2lfpG900LvFyVIOD6x265k8imLEyOBy7yYhqM=;
 b=fvSZ6GsNYigE0zwZoGyr2vBACBTzYfu4N2FPKczNI71phRatUHU5uIrJxu4j5Si9/CYOoV8UuITzcyYN5UzAeB2Oat6RcyyZi6gGNHqJpwCqtYtc2X+joUS3ClufTlUj8nWmW6iPrRwusyPUsc4JH6oIuFUAVxIDVGDhtK3oRT4/73UeUrMUsKU+/2KTyK21Vq4Cw3E6sRCyRiJxcQW9Ha5dQpwPSO90pDL5DhnDj0W9cPquTwGTvx8a6DpkXWupbXRqAb4dYl8BbOHiUi3FWOKmjRuEqpRuFCZQFRdMXWlFblsYs5p+8/DyklWVRDNvGFanoGd7norjFs25adxEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD5TiV2lfpG900LvFyVIOD6x265k8imLEyOBy7yYhqM=;
 b=oR0GZzZiEjYSlZbLAn8kni6fgLlCCvhCswntDxVbDG2x5v0iEhVk3RLtgxC3REIRKrKpCA7zlXj5YsBp6CLjNarG90klrrauY/yQBBMlhaOOn+rYD7K03ML0YwotbJbSemv09vb7ZBAwv4BTUlsItLg/qP3RJJxKiso7jL954BA=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Wed, 29 Mar 2023 20:26:05 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::cf) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amdgpu: add helpers to access registers on
 different AIDs
Date: Wed, 29 Mar 2023 16:25:42 -0400
Message-ID: <20230329202548.1983334-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d19d4e-ab55-4706-6f9c-08db3093d2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7tjMpqYbbJ6jHfi3ZJt3VbTiGUZ5ii2/rjbqq3+O0kVgdeBoehXrLVTjc+ixrhfbBl7uoFdyiFN430q9PluOxmr23w3NGEtOj3uJ1g78t4IthjOwcIYQzvTpn68TM6+SApwGlMKp8FMBYOuAAvMTzvNH4ajV6mK8n5a9hRmrCKXGEvSpRBlr24njkOKGH78f1qxtCHLdfovkdmqisu67RsE+/KfoOSx58oN/VB/xVEWzGt1qLzfEzhkgGhsIihIkVGhB3wzwSu20HUDZIqpOWLWc0qk/K0iwudka/MBYXdt9IhjGgo9c1mrsn392+7xgaON8gxlAnUYJ2JaRNE8LcawtaZ4sskRZBdWALSUaqKLOf4YiSAaix9IbO/iPUccY2VPSDZYrfG++9FZ2BNsNePCS6SjCLa52DkfEzGz3wsOx5A4QCw/GYmueHB+VkyRKZPACyke2/U+vzkQYc30+zRGWS38EDUFvlPEvs4JsdKRyLlBgDzIpHaB09/F0NTxrsUAh7ym1N2HY9FxIr2aBO2+UXOFUBB3iUK7d0t4PyU6Iom21fhLhLo2CoXUUAowsrvRzFNlaeLJKQ2e0rcfN2SR1seNZn4HHy3U41EmipcShL9LG17KUKx1cbaWlJgpZ+SzcYodFY9/yFNeOQLg9vAidW4EpmICDufnw34hO6sSprpo6/PxvT8E31lDJlUA1MNSt29uE46b2WnPz2YQURLBmtGj21900GVyXs79C+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(2906002)(41300700001)(70206006)(5660300002)(70586007)(478600001)(7696005)(6916009)(16526019)(4326008)(8676002)(6666004)(1076003)(26005)(186003)(336012)(82310400005)(47076005)(426003)(2616005)(81166007)(40460700003)(316002)(54906003)(40480700001)(36860700001)(36756003)(356005)(82740400003)(86362001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:05.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d19d4e-ab55-4706-6f9c-08db3093d2cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

SMN address which is larger than 32bit has different indications
through bit[34:32] on different AIDs.

v2: put smn addressing of different AIDs into asic specific place
v3: change to ext_id/ext_offset naming

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     | 10 ++++++++++
 5 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4ee79bddd0f5..0d5a327b0d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -595,6 +595,8 @@ struct amdgpu_asic_funcs {
 	/* query video codecs */
 	int (*query_video_codecs)(struct amdgpu_device *adev, bool encode,
 				  const struct amdgpu_video_codecs **codecs);
+	/* encode "> 32bits" smn addressing */
+	u64 (*encode_ext_smn_addressing)(int ext_id);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 12379c374457..2616bdb40418 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -100,3 +100,22 @@ void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev)
 
 	adev->ip_map.logical_to_dev_inst = aqua_vanjaram_logical_to_dev_inst;
 }
+
+/* Fixed pattern for smn addressing on different AIDs:
+ *   bit[34]: indicate cross AID access
+ *   bit[33:32]: indicate target AID id
+ * AID id range is 0 ~ 3 as maximum AID number is 4.
+ */
+u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id)
+{
+	u64 ext_offset;
+
+	/* local routing and bit[34:32] will be zeros */
+	if (ext_id == 0)
+		return 0;
+
+	/* Initiated from host, accessing to all non-zero aids are cross traffic */
+	ext_offset = ((u64)(ext_id & 0x3) << 32) | (1ULL << 34);
+
+	return ext_offset;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 6800a85c5966..76c159f90775 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -881,6 +881,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
 	.query_video_codecs = &soc15_query_video_codecs,
+	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index 9cc2dda087c4..dd48db09aa51 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -112,6 +112,7 @@ int vega20_reg_base_init(struct amdgpu_device *adev);
 int arct_reg_base_init(struct amdgpu_device *adev);
 int aldebaran_reg_base_init(struct amdgpu_device *adev);
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
+u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 39e4406da4ae..1c9e924b5f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -188,4 +188,14 @@
 #define RREG32_SOC15_OFFSET_RLC(ip, inst, reg, offset) \
 	__RREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset, AMDGPU_REGS_RLC, ip##_HWIP)
 
+/* inst equals to ext for some IPs */
+#define RREG32_SOC15_EXT(ip, inst, reg, ext) \
+	RREG32_PCIE_EXT((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) * 4 \
+			+ adev->asic_funcs->encode_ext_smn_addressing(ext)) \
+
+#define WREG32_SOC15_EXT(ip, inst, reg, ext, value) \
+	WREG32_PCIE_EXT((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) * 4 \
+			+ adev->asic_funcs->encode_ext_smn_addressing(ext), \
+			value) \
+
 #endif
-- 
2.39.2

