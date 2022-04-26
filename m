Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2CA10F064;
	Tue, 26 Apr 2022 18:27:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA3C10F064
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5QMNFtxjCGoZqg7N76t0q/SnbXJroDJHy45NxDfTC9vIwVRKDib1OQXOjWMgT7mJiie59hARwekK+Igv3udNxVDD6lcqQV4n7MU3KcXdfiztdp0qmzVgI3JPJjLsbEp1yxCvBjTGl51u7Kau5ISR/O8O1ZS43YoFVJvptl+qTRN+je029g1NgFNf0Pj857EhSXwcOiHs9wXWMVFr1n5dAYZcvP+PDaC3SKdsRbBO5lIyDSI8jI4RCetBuhO9KdB5b3HNME8jLGBoM1I5GOI10Kf7wJpK2TpFCmjqXD9WjjJ3UlWj7SEd3dN2vLOUqVYllYmbfWGqGg5wG4sXr8Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAcKxu4RV+fEevQCIJXAsekJA0N0u7cmVQfS5dxa2qA=;
 b=dtJrfRq2Vjf1TloDeRqmcArNYxm8K0CfJ818Zct+108H6mv4TheywNxGJw2Pp7YXcnJEX7nWEAGDFqg7ukDNOcX8QPqbSq/OdWNTHtQV+7C3FKgrRTsubq9RICiAnl19fugcBSVYPbiHPOEb0ud6x5LEMbFCXWoghA2/4uALu2Tmb6azcRAjfytdSGLf0dRRNG4MQZAqkLzlxxzCshsBD9KxdARdQI4q5r1ZZiP9WuePef8lA8qAFDZ2tO/Lp2VQvyeaQgBhoYQQEs8f6ZZEO4145JQACd735RI8+vBjYblMBhgINQBrmclUwftAuMTXHFYpf8chbr/n0wOIxU/DBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAcKxu4RV+fEevQCIJXAsekJA0N0u7cmVQfS5dxa2qA=;
 b=LbKWKtaVQumKZMNMziDWw4daC2GfDnJqNQt1wSVNzgINuCauIbe+lSOnbeBvbdlEQHn5hKNFNr4kOX4K/FqbIX587zWPde+FZjVTBhTslNf6OGBorlnfcKPirosiDXBh08TZs5IyHz+Uy75q+Ze0M1upMDGm4vU9cITUevOAhD0=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by CY4PR12MB1831.namprd12.prod.outlook.com (2603:10b6:903:128::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 18:27:50 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::b4) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 18:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:27:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:27:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu/discovery: add a function to parse the vcn
 info table
Date: Tue, 26 Apr 2022 14:27:26 -0400
Message-ID: <20220426182728.3006737-9-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fa0017e-96b4-4c3c-7b8e-08da27b2780b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1831:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1831794E966D0523844354F8F7FB9@CY4PR12MB1831.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXDdMi+bN2hhgPAcBjKS266mstfx2wO4EkzrLn7+5h8xzTIPrLCGuXhkz2TdzJgurcmSAEzIuzMbyR9Xq3UHB590fC/VeQgKVxuxJUS43ajYiQBVZtQpBbgK4t1xfOo9dYYzCsEYjDV2wFkYFXsheFo1oDut2uPAc2Fl/697OjAM+lmg6LcS7CD62jtIQQ1NhQXpnQPID/r2TcbauAIB0ZXux9jkO5ddlMm8rigD1Vn+7IdlKu6rgp+0aDuSd4TteR6/JFKdRgcteTme8glAUY9yAtUJMHIoRfoLE4qYxgEk7WKvw5vS9RruYcJIp+36p2by9533zVdu6b74jMF5u6xkxGH0zxsCshklZLsy07/AcvT39AQOEI7aQJ3ZWsuXGMClgl/Q9FdMZSb9DOAA1UdloBWyEZWgdoFZJq1c5pJcBIS+u+jQoAKyaTQJLDc6GY/aGylkKmCtrKIkSUjuKaArKwnC8EJ9WNeXBDJxiIYLm0WLCwPkd4k59fjbzgX+yzN6ktkLHxcO1MwLh+/DrAsUebCpGo3KcNCjw/oQpo6I0oIBgXMbvlQMgVrOL43uvtD7WR2/qEWQH3xIl5o2Abm4m2G73mmihLWD0M/iv/imXe4vCk6137w2aRuqcEVFyL888V67sT58FQlg35AGqV5YkUFwNv7yZ85nn9oEk1OSB4CCttI/+c9LnDY6jmbrlSg1PSPidbFiEFloYAjHjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(5660300002)(2906002)(7696005)(336012)(16526019)(8936002)(186003)(2616005)(36860700001)(1076003)(83380400001)(36756003)(26005)(82310400005)(6666004)(4326008)(47076005)(508600001)(316002)(6916009)(70206006)(81166007)(40460700003)(8676002)(70586007)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:27:49.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa0017e-96b4-4c3c-7b8e-08da27b2780b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1831
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

To get the codec disable fuse mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +++
 3 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a9b5480a1d5c..a676685c103c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1396,6 +1396,54 @@ int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev)
 	return 0;
 }
 
+union vcn_info {
+	struct vcn_info_v1_0 v1;
+};
+
+int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
+{
+	struct binary_header *bhdr;
+	union vcn_info *vcn_info;
+	u16 offset;
+	int v;
+
+	if (!adev->mman.discovery_bin) {
+		DRM_ERROR("ip discovery uninitialized\n");
+		return -EINVAL;
+	}
+
+	if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
+		dev_err(adev->dev, "invalid vcn instances\n");
+		return -EINVAL;
+	}
+
+	bhdr = (struct binary_header *)adev->mman.discovery_bin;
+	offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
+
+	if (!offset) {
+		dev_err(adev->dev, "invalid vcn table offset\n");
+		return -EINVAL;
+	}
+
+	vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
+
+	switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
+	case 1:
+		for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
+			adev->vcn.vcn_codec_disable_mask[v] =
+				le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
+		}
+		break;
+	default:
+		dev_err(adev->dev,
+			"Unhandled VCN info table %d.%d\n",
+			le16_to_cpu(vcn_info->v1.header.version_major),
+			le16_to_cpu(vcn_info->v1.header.version_minor));
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 {
 	/* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 752fb2e46849..3735c535d27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -35,6 +35,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 
 int amdgpu_discovery_get_gfx_info(struct amdgpu_device *adev);
 int amdgpu_discovery_get_mall_info(struct amdgpu_device *adev);
+int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index fb39065a96bd..5f7da4c19822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -166,6 +166,11 @@
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
 
+#define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
+#define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
+#define VCN_CODEC_DISABLE_MASK_HEVC (1 << 2)
+#define VCN_CODEC_DISABLE_MASK_H264 (1 << 3)
+
 enum fw_queue_mode {
 	FW_QUEUE_RING_RESET = 1,
 	FW_QUEUE_DPG_HOLD_OFF = 2,
@@ -250,6 +255,7 @@ struct amdgpu_vcn {
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
+	uint32_t		 vcn_codec_disable_mask[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
-- 
2.35.1

