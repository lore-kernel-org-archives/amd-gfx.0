Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF5CE71068
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 12:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E576610E07C;
	Thu, 21 Sep 2023 12:50:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB9C10E07C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 12:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzrA7W6U7RYRyIQJ3QuegpKZrKpFfdxoCBRVk6UHIQbJs5m9OpuAIS6SYUPK6vBlJSiadphCvrdSdvW2DLtYueNcG5GxO859YkE0jR4+rBq9Mi68jjzVaFMXtdrEKTX+fls+BuSFlP7Nbp/7XzmIehO+dcjSDaxv4AJmog+z97KcEmQJkMnfEItUFMTBLyJjXbPnTVxJHjQzrpVppuaAEwyOBq23NC4+elYi2PV5JWe5P/cBas5977W5bbJ00TZXWy/uvZG2csAcLKr/UOYbx+OrjDjnidl0EHyZ8aJulI4WmoEWwVD3lShT+jug6QCdj/cc8+wZISGHmaK6yUZe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE3CEsiMtCSyHBi1CpI9H1wayrsfTGY7l3MAYTGEa7o=;
 b=RWpqFJPlkBllecrspAOXK6GiN/axufH5Ij9YxEH1py6D5JrHBvS3nxW7hJ0K+SnFuwnvbU0Nr9dZjYLO9VmI+cfpV4khebe+tfPgVOL1p/WgpiSnKK6ZMCw2SNiQ11MNzvUYumTOFYShbDXp+NF3OhOf/QaqmrNOdLwH0GgTPF+sxfLTr5+Vntd/Pzk/3IPErIxr7ogl1izbCqLLcA62KAt98EE/LxnbdHw0yLnSb1ZdKIEfTg7xKBwRg0tiwIBiLhD/ofUmxDOkVFQO1RWMmU+tAjP72oenUSkKWdmP/3QYHIuJZboqrzTXaS9YuC5Ej5uzW+G6MYAihBuABK+dDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE3CEsiMtCSyHBi1CpI9H1wayrsfTGY7l3MAYTGEa7o=;
 b=a0WPKLSo5bAgCVg4V2TIptsYT3Gjc+qFKtTBcAYIbGudob7jlqFNKExuBkAjHh52/naWlcQsC6JYVMyX0mjJVPXYexGLoQZ0rR2KushuiceYvesluFh32tLufTY3oz8EZXOHdRg3RtKYNVn31Qb2o0ZCU3GtNEECn9ZhdTJ5J6U=
Received: from DM6PR08CA0054.namprd08.prod.outlook.com (2603:10b6:5:1e0::28)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 12:50:01 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::24) by DM6PR08CA0054.outlook.office365.com
 (2603:10b6:5:1e0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 12:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 12:50:00 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 21 Sep 2023 07:49:57 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
Date: Thu, 21 Sep 2023 18:19:29 +0530
Message-ID: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|BL1PR12MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b7806a-58c9-4e3e-f09a-08dbbaa144c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mtu15teFBWv3M/4xEjXdsX/hzJoxsw0vxM1HP6ld90T/DmXXaiMNfUnkOeIRXTjsueyppcaBKsH/nh/QEtX9a95ZYbrlis/7BAf9U2+gg/JmC+YHI9CEJIBZLU5Owz2hOJDLf6YP1v+1U2NfFvINqDSrZg4gJ3OYXopD82UBJ664R2hLQ2D+m3s0RLej4nZVP83i0FOZs+1y4QYZLOghVv50GMonNIp8javk3fZCSnAybhmDUBUuq0s2jH8VIPZqEwaKkn4LEzXJZ6qWwmaZqngfq6gr7VlKRyg8PuY6LwcvaJ2ovfeRnNOHCDF5KoUz7LqKNcV50TMSumyZ+IaLpq+4JQSNL+xLe6uIUw2xPLAZcHfiyuEzSDJ3/1mJskQB5ssVby0T8WrJEdFVB9jQ2yG7zcQbBHxX4hKGvwk6+tzCooSF2lG9nDWCFzdbBQt7NBXibQfl8MQ/LXFr+p8PDrqCELqPoJJ2Qa/NIGgVe7jUoE30qn00k61a7O3ZHajYoXnj/UF1MBKUfqh7dyUveFWPZxyT9dS5bTHGfKeBIOUmDI8zuCJ45J5I1mkI+jcJ4g5kuH8Hl62jGC22UgoHVJZKtFsYbb66H5rfrQCbESaf9poMfqGaXKtffr7W0oLaZBHPDbSz/JN6KMWc0tisLUlDhVzXcuIoL6DEBJkn1x6v4ECcn3EZh2NB0eC8tNm3DMtQHIolWKIcm1Jzwbf/wNDs4B5k8yYvfK7DlUTh3cT729Loq1SzYE8wOlrKkdu5/0//8BtbqXoVBi6ZpA9PhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(7696005)(6666004)(16526019)(36756003)(356005)(40480700001)(82740400003)(81166007)(86362001)(36860700001)(2616005)(1076003)(426003)(2906002)(478600001)(26005)(83380400001)(47076005)(4326008)(5660300002)(41300700001)(336012)(40460700003)(316002)(6916009)(54906003)(70206006)(8676002)(8936002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 12:50:00.8599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b7806a-58c9-4e3e-f09a-08dbbaa144c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Kuehling Felix <Felix.Kuehling@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix wrong ip count INFO on spatial partitions. update the query
to return the instance count corresponding to the partition id.

v2:
 initialize variables only when required to be (Christian)
 move variable declarations to the beginning of function (Christian)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..d4ccbe7c78d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct drm_amdgpu_info *info = data;
 	struct amdgpu_mode_info *minfo = &adev->mode_info;
 	void __user *out = (void __user *)(uintptr_t)info->return_pointer;
+	struct amdgpu_fpriv *fpriv;
+	struct amdgpu_ip_block *ip_block;
+	enum amd_ip_block_type type;
+	struct amdgpu_xcp *xcp;
+	uint32_t count, inst_mask;
 	uint32_t size = info->return_size;
 	struct drm_crtc *crtc;
 	uint32_t ui32 = 0;
 	uint64_t ui64 = 0;
-	int i, found;
+	int i, found, ret;
 	int ui32_size = sizeof(ui32);
 
 	if (!info->return_size || !info->return_pointer)
@@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_HW_IP_INFO: {
 		struct drm_amdgpu_info_hw_ip ip = {};
-		int ret;
 
 		ret = amdgpu_hw_ip_info(adev, info, &ip);
 		if (ret)
@@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return ret ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
-		enum amd_ip_block_type type;
-		struct amdgpu_ip_block *ip_block = NULL;
-		uint32_t count = 0;
-
+		fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
 		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
 		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
+
 		if (!ip_block || !ip_block->status.valid)
 			return -EINVAL;
 
+		if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
+			fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
+			xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
+			switch (type) {
+			case AMD_IP_BLOCK_TYPE_GFX:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			case AMD_IP_BLOCK_TYPE_SDMA:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			case AMD_IP_BLOCK_TYPE_JPEG:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
+				break;
+			case AMD_IP_BLOCK_TYPE_VCN:
+				ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+				count = hweight32(inst_mask);
+				break;
+			default:
+				return -EINVAL;
+			}
+			if (ret)
+				return ret;
+			return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
+		}
+
 		switch (type) {
 		case AMD_IP_BLOCK_TYPE_GFX:
 		case AMD_IP_BLOCK_TYPE_VCE:
@@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_FW_VERSION: {
 		struct drm_amdgpu_info_firmware fw_info;
-		int ret;
 
 		/* We only support one instance of each IP block right now. */
 		if (info->query_fw.ip_instance != 0)
@@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		struct drm_amdgpu_info_device *dev_info;
 		uint64_t vm_size;
 		uint32_t pcie_gen_mask;
-		int ret;
 
 		dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
 		if (!dev_info)
-- 
2.25.1

