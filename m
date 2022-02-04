Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C6BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 05:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBE110ED27;
	Fri,  4 Feb 2022 05:27:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC4810ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 05:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVaXEUH/t4GZoU+64xLWxraeP/s24s0te0cLICkEv9jV2a3KFChmxy4uYrguHCtkRXSpUgT4+B9ZnTR8DsOcw0feGhf1VSP+4lT2ry0VbykeJgKK4jzkygYL7bhWBJkfkXVR7rljoadbNvt7dRzfUClhX2rEcJcg7vt/nMA8g48Gf3yjEiq/1Gz4NUKaT7Tq+kegiwA7q7F30U3n+nIycma5pRi7BAG9eZN3HhvFQ0M8298TP60ojekcRpex7h0XMJ4X/MIR0IqhIULh+XUPbx9HaKWck3jhi0KRReBmkpVv0HRIj+cO/6Zv62uf5Vi9z013hiHSZEkgF9JtmFKLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AOh56exe5NYdthGRZKaAgfsSetXf1cV0hMCjKSGWxo=;
 b=OhaoHFYkBlLMlz2M/heW/FZ/ScauGkKVDsBW5RixyVnIe6usDvicYeKoW3Ef1czqFhFGctk6lp1wtCbgG4l+WqVYkBDkJzgMhLuo0YFQcO2Dp28vSX2y9T4+CE+Cn7aSmewVXuJUZehus17koF3oLUiQ7YLZhs7gKxLHSgOWdKr0DmRTo2+GWiB/OyKaSh6IK1wb8GgdaMdzgzvhXnqHLcqaQ4G/t1JExBJra3YxVXJgdV3tCURhHfDhMrShhwXdxVxTG0yoQ6ilG4sb09wqdSoq7dL1kkeI3BxnpvjgWYcZhYfqIYZLbSwPGRiycxYp3XJLM9gwECO1FIGNAU+C5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AOh56exe5NYdthGRZKaAgfsSetXf1cV0hMCjKSGWxo=;
 b=1ittLYwwABp84PDgmMQ3tHgPRebY1iEQVWItNYqgdZ+rs7uFPUk5aiLaV5eryKyN55s5Xul6dT/MonzNWwvmgYRMGZe+zcGGdsrRrsFX+aWdnIWNf+kdPscoPDS/omXq5kQqmCnyMXB0mRT5NJJR2sd7rjvkvbT7RGYMUxABzGc=
Received: from CO2PR05CA0104.namprd05.prod.outlook.com (2603:10b6:104:1::30)
 by BYAPR12MB2742.namprd12.prod.outlook.com (2603:10b6:a03:6a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 05:27:40 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::50) by CO2PR05CA0104.outlook.office365.com
 (2603:10b6:104:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.7 via Frontend
 Transport; Fri, 4 Feb 2022 05:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 05:27:40 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 23:27:37 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 2/3] drm/amdgpu: Don't offset by 2 in FRU EEPROM
Date: Fri, 4 Feb 2022 00:27:23 -0500
Message-ID: <20220204052724.469469-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
In-Reply-To: <20220204052724.469469-1-luben.tuikov@amd.com>
References: <20220204052724.469469-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e4fd77-7cd0-4356-73e2-08d9e79f0ffb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2742:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2742B089646EBC56DE5A0E4599299@BYAPR12MB2742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KeY7Q8i9pXmvOpvxZc+urmshZFjZjnA8OC+yGXhrLw6y2H8U56GDyvq3a6DmxeePkUStvsGTwT64NfzDoFzDkedMhNuXsI4E+X+8OBIWptQgfYAFdkSzWWG2t4i1nfDDbvmWfVUXACKHNSo+XVt/s0W3OOEw6JjNsMvTAj5xrkVStThzRU/yzIxgn0cnkIhd5yY3HFnVr88B9TFsn0C44DspgAhjYUmSHgR9mJmp0kxUufFlsypEA1ZBvzLg2Qx7XO4Ip2rX0HdW8g6yQMqLAgg+D9Y/nmOh5xzIvgNNxrVPAKJNo7jveSrJKprETin5fAXdx5jZ60OKu3b1TVopdEDaIGwuRuPg57MoClwuZw8HVTQai+xJRqEmmEobBMV3DycXCFZTi+vhWfgEWNJLwwn6bKnXWPJGxW0weDwP1GvZDhTiU/ZLK8Yt7qMgC2EG3hHPzcD5ZtD6IVRDOQDyDRHK69/G9s3x1jzpvgYHSX7vlc808eOlgwyJn0eHXcfFWff8E/2L+Z3H9409/3ILyPnLMRHN1UpGPjm2NG8S1ffKuUNqN1dnK5B+W0c8pHUQMIpEeGLj3Ehri3hEHb9DBqjIRClAUnEcPp+/zAEQiJiNioDwvWRkKCLapQGjWGyIZ/I/6JQzn/yopzBy77pr4AndoVNwWAuqgcSd2E2vT0zM8pDKnCUA5wHxE9kZc0D/9d0wpdWP8t0+Va1g/mf+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(5660300002)(47076005)(2906002)(44832011)(6666004)(36756003)(36860700001)(508600001)(356005)(336012)(426003)(81166007)(82310400004)(26005)(186003)(1076003)(16526019)(40460700003)(86362001)(7696005)(316002)(2616005)(54906003)(6916009)(4326008)(8676002)(8936002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 05:27:40.1558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4fd77-7cd0-4356-73e2-08d9e79f0ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2742
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read buffers no longer expose the I2C address, and so we don't need to
offset by two when we get the read data.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Fixes: bd607166af7fe3 ("drm/amdgpu: Enable reading FRU chip via I2C v3")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 792337433a9ee5..61c4e71e399855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -103,17 +103,13 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buf[AMDGPU_PRODUCT_NAME_LEN+2];
+	unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
 	u32 addrptr;
 	int size, len;
-	int offset = 2;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
 
-	if (adev->asic_type == CHIP_ALDEBARAN)
-		offset = 0;
-
 	/* If algo exists, it means that the i2c_adapter's initialized */
 	if (!adev->pm.fru_eeprom_i2c_bus || !adev->pm.fru_eeprom_i2c_bus->algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
@@ -155,8 +151,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 				AMDGPU_PRODUCT_NAME_LEN);
 		len = AMDGPU_PRODUCT_NAME_LEN - 1;
 	}
-	/* Start at 2 due to buf using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buf[offset], len);
+	memcpy(adev->product_name, buf, len);
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
@@ -174,7 +169,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buf[offset], len);
+	memcpy(adev->product_number, buf, len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
@@ -201,7 +196,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buf[offset], len);
+	memcpy(adev->serial, buf, len);
 	adev->serial[len] = '\0';
 
 	return 0;
-- 
2.35.0.3.gb23dac905b

