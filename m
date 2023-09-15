Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA3EEEC00
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 19:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A8F10E676;
	Fri, 15 Sep 2023 19:24:54 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FA310E676
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 19:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q011zfgSLBq5kw39kvcpSFsuRckMCWg27DaaIsCs1awxHqVeMqzMxqwtSLGBorKzDjHGtsnmZ3By7aYU01L+uWtexYTAtx1/cR9ukkDgoHdZYlkNASgJYCgnWg6KG5HD381b71p87HkvQrRJyg80I5QvQZTSKYdhXX8evZdu5wldp9NocwsKc0RnBhOd+gvImy62QTzEp6tRMlZHVdCKo/FGu3VRMFXXzTyRw/jvxwVzHdHYuqFDVClCR4UrocgwhERYuKWEald0NLAaqxUyDzggmH+oipkCGMGxIUc/6lKQG3ine1naR/MzwwHMSGQ5H2n/sbHQSxNdWBtLv+ZwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKlkQYS2L0SIH3ua8htZDxRSY8xqqRlU40a08BH3MvI=;
 b=aDcX3iroe+Hv7REOy3T98+exr0gImFPMKJ3xP/6OaQ3ytKtgsP1LFDcza/ueshh3Rlw0YQ2kFzw4y6Wv0CUHYQze8O/RAT6qOwHndt1ZlwCn9Tb/cSMcNLUd1d0mVbgvAkltuql/Mwj8kyJx16MdGpuPWM/cKYVawXvMAt3uqVYgPAClXzrPIw2TbjKrDBaU7v+cgki58gt1ZNNphUJxRUClwird4YhAU2iysbUDTnHQ9fVtdrFa7Di9/jamWjaC9p+ZZrkYTY2XbL3FWx1TMuRQ81+uB385aPdekSCraD60AFh7ZIswLCavhmD9eHz8Ix1GzlKe54fCERYBUj1Lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKlkQYS2L0SIH3ua8htZDxRSY8xqqRlU40a08BH3MvI=;
 b=E3SbELFzhWKeAB0pWzKMJ9mDBOz+W9wmDnx/1/RDuExrJ5IVPwbPPur01S5l1oQVM3sSwXARkgLTlh3S258Ud3AAT4pYox2SJyDCYDPbE693E9Hn4N3zZB/7qNU/EAX681pBDEirHSQOcFkN6LOKrSXutz7xF/pGGDzf+FUu0yU=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 19:24:50 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::a4) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 19:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 19:24:49 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 15 Sep 2023 14:24:46 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: update IP count INFO query
Date: Sat, 16 Sep 2023 00:54:21 +0530
Message-ID: <20230915192421.3602660-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a575b1b-2c19-4527-e269-08dbb6216dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNWvJB5cZbariHkUZnuzW9xRgfRBNSJQZJ6xeviFWb5WF9XkJ82FPMi6ygyHBr/8ph9dGNRh5QM99ctmcpIwLRhu+SOyS5yN3hs9PmZiP5LeuHJsV+yJsgdGjiyuPxJ+p/fwCkfBzcVMoOTwihz84Qe8EZTafri97zxweyv/OxKzakkv8byGW6fRxUvcXpbF2vlN9D65XmU8pseCenctWYdtCVeJACSDYH+37Y71uL+CLD23j16M743ZCX+isgX1Ekkmu+1jMjm6fqpUIrHels28nNXpUs0k82djSp9ket0Ih/1WmJE2rJVlhhtT2jV7cLuecdHWSdzMmBdt9KzDN8EOfnkXfSp7/CfUYNP90o6meu1NoQzWwG8I2MciZoSQa48Q7vtAemmOQp69Nxw7nq9AXxtG8V1CHWNx6HPbdYZi6zhs+Elq2/BwHhZe/j+kTZNQ1B3H9LmlK3pi4HwrAaKAyr1RdwOxFkRLePEqoh1AsquOoQ60BWkzg10fW0Vki92ptuG4SII4+NIGqp+afnsQRPCtvpQ1RKKZZ0piSITMj6s8rMOrpxKu1qI3u/TvT3BKHJd9O9kdmZi6Bdj60boqnuSxuYpCi/YoIzFxLrE0mnxh8xDbonSZqqXb7r933J8RCY6GYCQGYhSR5NkltM37j2+WW9WJg0yzObNkRu9gs0FkDahHR7TJn14sbDl+ZE+Y1NtpsAvDmQ2jQz19o+X4JIoBx260tfdzAUY9GARCGdlK5POoLWnz1KxxixPzZ5LbccUIf1LwrCwz05jroQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(83380400001)(7696005)(6666004)(4326008)(478600001)(26005)(1076003)(2616005)(16526019)(336012)(426003)(2906002)(15650500001)(70586007)(70206006)(6916009)(316002)(54906003)(5660300002)(8676002)(41300700001)(8936002)(47076005)(40460700003)(36860700001)(36756003)(40480700001)(356005)(86362001)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:24:49.4600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a575b1b-2c19-4527-e269-08dbb6216dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
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

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 92 +++++++++++++++++--------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 24d866ed5922..56273a7c9028 100644
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
@@ -600,45 +638,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
+			count = (info->query_hw_ip.type == AMDGPU_HW_IP_VCN_ENC) ?
+				adev->vcn.num_vcn_inst * adev->vcn.num_enc_rings :
+				adev->vcn.num_vcn_inst;
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

