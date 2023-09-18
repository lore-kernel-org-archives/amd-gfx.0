Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F8CC46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 16:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962AE10E041;
	Mon, 18 Sep 2023 16:55:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1E010E041
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 16:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l79Q8w/zpIC+RvZCoaPXO19K+j0jyKiGXoK7rFtFLZbVJkeywfLIjsDQu/4dt3IvMQYEbFsDio7UT5yu9jH5Gb6w9FdMVTHzkpmzqKOgG+e9c2Aog76xT0swadzYEicF3N+iyEfRTbHkNAy6Ynv2ag+Z4KPbRXvyA6+Bs+UMF+O/BpfgSrSFQVDc4wAPpyih78wA7LM+YoI72B/cB+mwsDr57r3nsdZ0KljWYibV5QxvgXWmBsHtmsTiHzaxyeS2cyyFxDmZxLyQFvlWOGkCCTA4eqDwMiqVVqRdPAjmcIOuh/Bo9L5DJG6fdN0VxLUHjiD+/9+KQ91wsH1kBidh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvlWffvAut8fRdeNu/4lCVse2mjjlXon4gY2Hje7c9k=;
 b=elMnUgXw42QXXuiTNtxX+UMU9YLmyPRuVdG0fB9C8nbKG2ejbJKf3BB+9XV5raVrvyGsnCzGkYaFPGYSDqTqYadGrV1B3U5TELKqoOCepwQWOqjscBQhEziiFzQw24L7kgkDecP2sNAaTfi3REcIBulisnaBekIyhfpWhmhXM2UrjIDaU9XSHKbZ263TxFbz7pFykcv8mECdpUWFJ2cBBBtKTLbVnksG7S79Xr1dy9hXV5rMmWU7/INZsKOaw0cqw7lmrEC9wdZ9N+d0oXMTr5JX6bBpGjQzBG6rUwKcTZqmqyV+iaDyvbHm1yjja6SLX1pp8iFhkXbodckyTFVMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvlWffvAut8fRdeNu/4lCVse2mjjlXon4gY2Hje7c9k=;
 b=Bsqgd5yABsr+GTn7I4qOJu6rsitKLX5AYmq/BGq7+tzGPw+IDgnt7ZzwdT5Iu9MyOXdUs9prHA2NYD+CULxf+mOHEfJeGcup7ZypWYC6RM3/w2h9/zKjfEK6GZGZ0wffJflCXX/Ynv+f78C11zsayBNB7hCxsesut39DEa3rgR0=
Received: from CYXPR03CA0062.namprd03.prod.outlook.com (2603:10b6:930:d1::14)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 16:55:31 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::f7) by CYXPR03CA0062.outlook.office365.com
 (2603:10b6:930:d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 16:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 16:55:30 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 18 Sep 2023 11:55:27 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: update IP count INFO query
Date: Mon, 18 Sep 2023 22:25:09 +0530
Message-ID: <20230918165509.3852910-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f590c88-fbbe-4887-e583-08dbb868110f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j44drJhdry4JBg4V/OTaSNoLYlXh2EXzwaOU9RVVzP8JJtwGHfP8RD2A7WDL6eCsmX5T1Vmm25mbsWSeE/DG+z7EiWHYYK6zHkjAnF5cFDapIE2d819KoDb8Kj8dnoNdegedDmmBcvJBgHC/iB3wVGI3SkQ8lr3HqIILM5pfuqeQXqX4olv94VvWw4Yk/QNvRX5PpSyWep3rjkeJEyATzVbv6kht7U6bjWXXNNXmTuAQ+WnUWpr32WGpp1DDO4JPHOGZ7v7u502KkQQ8tqSFFiw0Y4nKqSZzBk3n08Pz9ziEMS8qLKv3Tm2OqJkqcr3qQquagGK681IDPqoJlye9CGf7lsvpBDsJHHEmACqt4Fp67OljUyMqg5szShZZvXQRBsef/hRh+1xAE8j1Oaiy6STeHwtMnPFjjxmlp+7PMWLrr50Osg1Rm6wrBIN698uGCB+xvvr8kBby++o6RuBKe4QGwkRbp+2e52aZ9EcK1ZX8zhylPGh9Z+pcmw5ZNatL9/cAHaPWuTXzDrsFZgf9ethOv+i1kPsJ2GIqUYMMtTUJ2thwixPFZZ8CTshHmdNVWqLvpKHqz9J6Kmv2saaIpQSnKzsgj8Bu2NSEmt4D5BjFRdJFzK0VEDQhfMkUshTdy59M/IIXrASnfzokleVRQltrxUEsbSI6fAFTbrJHiHiQxlRP5u6AmusPBNjgQv5Vpw0XYP241TpJnSj4cP0aZlhwWlz6/6cu5SBL84aWRdo9Vl0/YwLlUddPEp5Oe8cmMD0am4vAr2+lJCK4PvHYTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(7696005)(6666004)(36756003)(81166007)(82740400003)(86362001)(40480700001)(36860700001)(16526019)(1076003)(26005)(2906002)(15650500001)(47076005)(426003)(336012)(2616005)(83380400001)(478600001)(5660300002)(8676002)(4326008)(40460700003)(356005)(8936002)(41300700001)(54906003)(70206006)(316002)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:55:30.3858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f590c88-fbbe-4887-e583-08dbb868110f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update the query to return the number of functional
instances where there is more than an instance of the requested
type and for others continue to return one.

v2: count must reflect the actual number of engines (Alex)
v3: fix wrong number of engines for vcn (Alex)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 90 +++++++++++++++++--------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24d866ed5922..9d36f4d3fecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -200,6 +200,44 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	return r;
 }
 
+static enum amd_ip_block_type amdgpu_ip_get_block_type(
+		struct amdgpu_device *adev, uint32_t ip)
+{
+	enum amd_ip_block_type type;
+
+	switch (ip) {
+	case AMDGPU_HW_IP_GFX:
+		type = AMD_IP_BLOCK_TYPE_GFX;
+		break;
+	case AMDGPU_HW_IP_COMPUTE:
+		type = AMD_IP_BLOCK_TYPE_GFX;
+		break;
+	case AMDGPU_HW_IP_DMA:
+		type = AMD_IP_BLOCK_TYPE_SDMA;
+		break;
+	case AMDGPU_HW_IP_UVD:
+	case AMDGPU_HW_IP_UVD_ENC:
+		type = AMD_IP_BLOCK_TYPE_UVD;
+		break;
+	case AMDGPU_HW_IP_VCE:
+		type = AMD_IP_BLOCK_TYPE_VCE;
+		break;
+	case AMDGPU_HW_IP_VCN_DEC:
+	case AMDGPU_HW_IP_VCN_ENC:
+		type = AMD_IP_BLOCK_TYPE_VCN;
+		break;
+	case AMDGPU_HW_IP_VCN_JPEG:
+		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
+				   AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
+		break;
+	default:
+		type = AMD_IP_BLOCK_TYPE_NUM;
+		break;
+	}
+
+	return type;
+}
+
 static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 				struct drm_amdgpu_query_fw *query_fw,
 				struct amdgpu_device *adev)
@@ -600,45 +638,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
 		enum amd_ip_block_type type;
+		struct amdgpu_ip_block *ip_block = NULL;
 		uint32_t count = 0;
 
-		switch (info->query_hw_ip.type) {
-		case AMDGPU_HW_IP_GFX:
-			type = AMD_IP_BLOCK_TYPE_GFX;
-			break;
-		case AMDGPU_HW_IP_COMPUTE:
-			type = AMD_IP_BLOCK_TYPE_GFX;
-			break;
-		case AMDGPU_HW_IP_DMA:
-			type = AMD_IP_BLOCK_TYPE_SDMA;
-			break;
-		case AMDGPU_HW_IP_UVD:
-			type = AMD_IP_BLOCK_TYPE_UVD;
+		type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
+		ip_block = amdgpu_device_ip_get_ip_block(adev, type);
+		if (!ip_block || !ip_block->status.valid)
+			return -EINVAL;
+
+		switch (type) {
+		case AMD_IP_BLOCK_TYPE_GFX:
+		case AMD_IP_BLOCK_TYPE_VCE:
+			count = 1;
 			break;
-		case AMDGPU_HW_IP_VCE:
-			type = AMD_IP_BLOCK_TYPE_VCE;
+		case AMD_IP_BLOCK_TYPE_SDMA:
+			count = adev->sdma.num_instances;
 			break;
-		case AMDGPU_HW_IP_UVD_ENC:
-			type = AMD_IP_BLOCK_TYPE_UVD;
+		case AMD_IP_BLOCK_TYPE_JPEG:
+			count = adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings;
 			break;
-		case AMDGPU_HW_IP_VCN_DEC:
-		case AMDGPU_HW_IP_VCN_ENC:
-			type = AMD_IP_BLOCK_TYPE_VCN;
+		case AMD_IP_BLOCK_TYPE_VCN:
+			count = adev->vcn.num_vcn_inst;
 			break;
-		case AMDGPU_HW_IP_VCN_JPEG:
-			type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
-				AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
+		case AMD_IP_BLOCK_TYPE_UVD:
+			count = adev->uvd.num_uvd_inst;
 			break;
+		/* For all other IP block types not listed in the switch statement
+		 * the ip status is valid here and the instance count is one.
+		 */
 		default:
-			return -EINVAL;
+			count = 1;
+			break;
 		}
 
-		for (i = 0; i < adev->num_ip_blocks; i++)
-			if (adev->ip_blocks[i].version->type == type &&
-			    adev->ip_blocks[i].status.valid &&
-			    count < AMDGPU_HW_IP_INSTANCE_MAX_COUNT)
-				count++;
-
 		return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_TIMESTAMP:
-- 
2.25.1

