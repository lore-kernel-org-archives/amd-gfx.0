Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D38EEAA53
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 16:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AD8E10E144;
	Thu, 14 Sep 2023 16:01:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FE610E144
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 16:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3rqXztTiiwiuL4PPSUxgja8+hW2SkwHS10otKIQmEgEnog4n3eWJgBa9EFk1wEc9IukFojL53oYwydFfBT6z+/2twH3RUi+1L39XogZ0CG/kAEL8yjfLbHhIXa4IXNPemcsu4JnXirVuDsnVb2SeYtkRxFZgc9drbr9NiQulyYBX2tY7Wnk4bX76xxwx7ndmaCF4DhrxtCCmlfU600ZlaB8UywQ3M3LI2KmcFjmyMrdo6WPURAhTTy6PQ6yog/1qPnodk0kvirdJDa4kANHvmR2OOfgjloL4r5yTUDdE1JWqYAE+4HgCi2NT1hNrQ9O3bXDjvJHPdLmmOTOWhslmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDD3ZniVsBa8AHKtnUM/rx7OFl17tcT5ZXLtPDyuYSQ=;
 b=k18HnZQIZ1s9Wy034hNUe+t71eK06q1dR5R/keulp6XuC9j9aQPUDJadg5ijWodCa3iMkQ4p1ztvZk9i/U58b4/JGHh2ZIHZUm4bla5QXZqIJQgAopEy+j6alRlZsEkalZTGFwbZOaYtNaz09riPO5RseJBMp59RMhaxXK0PzUWzhQDhOWkxfdP/6wuqrfRg5+LS4OONgxiBXIO4SWVSVVzaKWpTJN46NfVy301vOMMjOHyeTYYz/ZrEQ5fKez9ffEf2zkcLvB4eYHvEdocS0BDh7Qjzv6UVSMSI9fOsKGPzaHrKP2LqGu07jwRCIkLukR+QWnuBzSCDFI+G3xPjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDD3ZniVsBa8AHKtnUM/rx7OFl17tcT5ZXLtPDyuYSQ=;
 b=fc8aEyOggOUXM5TXEJOHSw0oTr4MG6DRBw47ZvwCYhe/UtPsqZOANlvNliKbigMSyu9e5vfU4OAxfafOe7ZiHh4CpwXjCea7FHlcYeEGBDgH/WMzenMJe7x6ge7sIYBXe7/aXmjFGykYJalyNE1zOMTZP2YKvAcze6BfiyIwwAo=
Received: from CY5P221CA0101.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::36) by
 LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Thu, 14 Sep 2023 16:01:14 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::7c) by CY5P221CA0101.outlook.office365.com
 (2603:10b6:930:9::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 16:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 16:01:13 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 14 Sep 2023 11:01:10 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update IP count INFO query
Date: Thu, 14 Sep 2023 21:30:50 +0530
Message-ID: <20230914160050.2672457-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d53bf04-0d91-44a8-a077-08dbb53bd227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfNT4ZOcfEmrL2dX4xhdOp/Ftz9HZbnDPMh1rrWnMF7d9vUx2qBOrZyHE1eR0duXhoT9u9VjNeE2VVe0d9j4y4Ny2z3jp3Oxs7A1CGCI/aIjs8HoCLoLc5Kp1pdjXrjy8nZVt+dd49weLJIvMY90+Vf7BmsIzY+QM8e3KZEIKSEi4DMnLZJwevgfXK4HnY1TAa8omGS0l3iFwS75W3qzKLqwOdC8AIWInhwjFohfPe8n4h1C6RskE4fg/2Q2SQ/behmvMK6JQJ1i0s9MoG/1wVyzaK55FrP7oNmZsiE16TpQmukLYB9Aa5uFJ2Y7WgwRe4mD7LZpqNwDxycfQdK7B5FhtsJ21niUxFPX4Qr2uJIqg9MZt9REFGUy+rY7I43omibHOTBjs4ki56WKg55nHj2tDayL1OIcLNyeubOzEuafUa5jY5Ist/k6/0icSFNfQIL8gAJZLrKIX0VqarIl8CY0RHD8nNIVNlGFgtHwJYRk1eNZiJd0ZZ11u1pTATd/4a/6OOzHesTc5G8Xguav9ugpm5iXRzpg2vujoxZK0sSoBsiv/cJZjoA3gTrP03EvKUnNE5LGpHeyYftE/it2zEyIv3Lwb6LtySGgQxOH3L37U/KlarQevk/fezPB647Sc//cJiu+nr9yHzlAEUZcic5YWDpKeimZ9skQ1oKN++ZcrKwGjcr0M+ruwLk3lWZ3oL8gFTSyVfStB7+X4QoEoTHOgVl4gJRv86XaOj0Vq5p5KvlWYlvnToOhEKYlkSlKFHEmV9AmXU0vEnwqC5m7rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(8676002)(4326008)(8936002)(70586007)(316002)(6916009)(70206006)(54906003)(5660300002)(40460700003)(41300700001)(36756003)(36860700001)(426003)(16526019)(1076003)(7696005)(40480700001)(336012)(26005)(15650500001)(356005)(82740400003)(6666004)(81166007)(2616005)(47076005)(83380400001)(478600001)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:01:13.5473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d53bf04-0d91-44a8-a077-08dbb53bd227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
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
 Sathishkumar S <sathishkumar.sundararaju@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 Koenig Christian <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update the query to return the number of functional
instances where there is more than an instance of the requested
type and for others continue to return one.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 90 +++++++++++++++++--------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a48bec10aea..9521fa7a1bf9 100644
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
@@ -592,45 +630,39 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
+			count = adev->jpeg.num_jpeg_inst;
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

