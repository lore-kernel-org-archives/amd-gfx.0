Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20DBC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4902910E42C;
	Tue,  9 May 2023 22:21:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE2310E42D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ3DQCpNsyyPG4WNgUxYFnYP20k5VALtR9NVA461dhT5rYGpKe4zLb0l9zLh6G/Ub8fhLPfTTQUHYqS7QbFTBYsCMFRtF4COaJVcB4EOpBRyVri0nbg1khxnnCW54FhVa+uA19kHfsI7v/3hlr4vUnFiAHDG+EWzU8X0Hv3CaAavf0BSQ36vBzd2P+a66swH9/6WTzhtVaedbpMvBwzsQAhVNuLBXdE3QSZ88KFV6V4ENagN/dsx72tGW7aIeww/OuZ4yn40kBtQSR3PGik+TGCcxfxQ5zPKAmO6vFgznuGyjDdKanRYDZxo0blBfyWWSsGMOToeP670OQurZnJaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxUVv5DgcLlDR1yLyU3lU7LNAZ7EUcfy6BScg+wyvZc=;
 b=kjfbBqLwombw9MU6oVD5fhNsS2QZv9fN+cLqqaUCTzKG45b5OkwbHBvfemzwF9kVWCiW2/r+9fQOQQPrZ5ELFGzw1irJzoQ5R/Ym0tWg0yBJZjdHtKsOOrDALDxM4+5SKqwp0LbITq/YFPvCP3d+t8w67vsRs8UFaSVDEGpYZ34Ebh3U08YmZsVF1lSP/iqlWMDqH3+Zu+7KEeLPnTWyWGGGgPbyqDJmVGRvqa4YwprwY2KetdA/Vl4320py+hY+mXqidc6umXpj2/qca7J/0TVx8debSF55od2aYkzB6/QcLr9BqPwSJnfrbKMEheaOar6jg7yrn+hKhEmrICT1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxUVv5DgcLlDR1yLyU3lU7LNAZ7EUcfy6BScg+wyvZc=;
 b=AhB0Bc5T45xpjoRLMHeGz4zLsptTQFiUXW0F1LxCylOJbjjswYVpSwL6MwAWG8qWJoNI5OpnP0q/ugDd/+PrT9KLuwA+BF8g3rgd47VFnyhaxZ5MA5YgbM7cY8WNW2UWb3OoHEwe+J9xzQnMl7LvqtQZOH1C41o9ySon4BrKEOA=
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:21:40 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::f0) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.34 via Frontend
 Transport; Tue, 9 May 2023 22:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:21:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/9] drm/amdgpu: Add query_ras_error_count for vcn v4_0_3
Date: Tue, 9 May 2023 18:21:19 -0400
Message-ID: <20230509222126.477847-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: f8db9459-c49c-42aa-fa30-08db50dbc2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5tOfBbbSrdZWucWPw1xqAIRJ/tS7+MpOptj2Fqv06aJvOD/IbSQo681RvUAr/ZApeJDntWi64OL9aE1emwGbRtiCEJS+j9FeUS6m9VrONIPpvFpsQQLsCnnHh7nc4hPWkUVD6ulcWy+YVZbSzRpkE3Xr+oGa27U4VPD59r5EBGoaD+Xue62511a/9lsLyUHYYMMhptcakyN0qLrIU+lLIWGn/34gk3clKmrJ5pcFPyWEoF6cs016eqDPogfStt3HJHevrsmyqZ1R2QJGOs9SNNj+vRYk+xfzcGE0REnLw9vPX41KcT8zc+/wDC1v11i+LmLIGTlN+IbvuYGeOyKg/qS9Bkh9K2YUI25PwO9CiP5IIs2YmyOYMa1OsQJ8VldV2BFakQfSW90LVgrsSB11hnZx/fJx1ktbD224Km21k++NpIg72F5dy6BIHL+U5+2usr6x8mB9nHJi/qoZUxH7YgggcnZHBGFl0TSdGFS7R01E960FfReJvSqRsddDvqhZcGBGsCwK4y2/AONiocl5fRFUeMmImzaSw2dT1ZKck9XR/An5v8ZmPBYIQWrIO3Z5EF8qDt42tLJ+QuqMXqYAIcWqzp602QPTfpfG6zvStYlVoEzDzfX5FPBY2WOlLp7Mku9ZHwV86K8SyDiSaSikg/oKIpdvbeJYbp0+0unVY/0l5fiBuaxoMsKQRkYsXYll6PXci9juqCyWWz6gu463LSSUOjV3zKFwtIA1o52Zz4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(316002)(54906003)(478600001)(41300700001)(8676002)(8936002)(16526019)(6666004)(2906002)(70206006)(5660300002)(6916009)(70586007)(4326008)(47076005)(1076003)(26005)(40480700001)(356005)(186003)(7696005)(40460700003)(82740400003)(83380400001)(36756003)(2616005)(426003)(336012)(36860700001)(82310400005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:39.9900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8db9459-c49c-42aa-fa30-08db50dbc2e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

Add query_ras_error_count callback for vcn v4_0_3.
It will be used to query and log vcn error count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 9d0c3dc76547..e5037d6f884b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1430,3 +1430,39 @@ const struct amdgpu_ip_block_version vcn_v4_0_3_ip_block = {
 	.rev = 3,
 	.funcs = &vcn_v4_0_3_ip_funcs,
 };
+
+static const struct amdgpu_ras_err_status_reg_entry vcn_v4_0_3_ue_reg_list[] = {
+	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDD, regVCN_UE_ERR_STATUS_HI_VIDD),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDD"},
+	{AMDGPU_RAS_REG_ENTRY(VCN, 0, regVCN_UE_ERR_STATUS_LO_VIDV, regVCN_UE_ERR_STATUS_HI_VIDV),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "VIDV"},
+};
+
+static void vcn_v4_0_3_inst_query_ras_error_count(struct amdgpu_device *adev,
+						  uint32_t vcn_inst,
+						  void *ras_err_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+
+	/* vcn v4_0_3 only support query uncorrectable errors */
+	amdgpu_ras_inst_query_ras_error_count(adev,
+			vcn_v4_0_3_ue_reg_list,
+			ARRAY_SIZE(vcn_v4_0_3_ue_reg_list),
+			NULL, 0, GET_INST(VCN, vcn_inst),
+			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+			&err_data->ue_count);
+}
+
+static void vcn_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
+					     void *ras_err_status)
+{
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
+		dev_warn(adev->dev, "VCN RAS is not supported\n");
+		return;
+	}
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		vcn_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
+}
-- 
2.40.1

