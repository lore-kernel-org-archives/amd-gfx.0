Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B525C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 03:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088B011ADA7;
	Fri, 20 May 2022 03:05:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD7F11ADA8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 03:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kokvDeYldl8p+LDHplduDY/12HpNtNBpHEQPICaLjalOr+8jLWWGEJWaKmQEtslgKlCwl5UYZfDMEW6XPFgMhJKQvn9JRY6iKtw3LV9szTkQyP+UwKcfTJjmMVdpiyi5A860+O6IgcgZLKkUc+88bkagKfOz6n96OZSkBrbnb7MWaXY/UaQIbs6SMppG1frgRDJ9XYve26y6z/aAe1J4fIa2yJRtbuqIy3vvt8m36Ewes7ojPi9WpzoU82Bm62IAIbc3uwQA8Lc8jVEEmlo9gg2e0HjLQDRTqzdJtlcLvIpu4zG++Svpo6pS41XhnHGjxg2GE/uA7yEwPuU7pFiHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POKF4jr+l8a1d3NoQCaI9XcXFcDyctyx43aEoNqLDzA=;
 b=X3bRAVq6InBmM1CtXvVZ04HEiYorCSC3oXMrFtNlPZsvUJ6ixv25Jvw/bpfngLYi+XqshLuhXNqzfz13/TMSXyc8cXhbe3eWr91aJguSpCWs+osSxCB32DByaHx5Ey+KLGBdz/M3Iyl3i6/eIPQvB1PwGkaAZ8yDkb0BouQJUc/Myyhfz+WnDf0vld6AcDMKhw+bYl9tvlqgzuTYpUsPFtJzmra8l5F5Igb/IQwcIsAkC93mgMO1Y5Yrnwj23f1hRP8Efmnl3mp70OEedX/C9mS09Aasa/P2GTOV1uyy75+aSJnNa5LzQn9VIrj6Hj9mRf/EW/SV9SZI5h16AybOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POKF4jr+l8a1d3NoQCaI9XcXFcDyctyx43aEoNqLDzA=;
 b=yQ5HG8+H20ObTedTFo5FnIsJpHs6mEEeFmIZF9It2O4SfT6M47VDg331f7dQf+RcrytRZyS2C3bNhsDfD58u8SUxqJKCKiQMGT8LtCOQkhhWnHtJhBQFDQtTFrx4b3YV75wAJPUUwt4YzUaBM45/U4DUH5MBhSUEvga/nSP/Zvk=
Received: from BN6PR19CA0119.namprd19.prod.outlook.com (2603:10b6:404:a0::33)
 by BN6PR12MB1586.namprd12.prod.outlook.com (2603:10b6:405:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 03:05:00 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::ee) by BN6PR19CA0119.outlook.office365.com
 (2603:10b6:404:a0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21 via Frontend
 Transport; Fri, 20 May 2022 03:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 03:04:59 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 22:04:55 -0500
From: Huang Rui <ray.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use the callback function for reset status
 polling on IMU
Date: Fri, 20 May 2022 11:04:05 +0800
Message-ID: <20220520030405.1308133-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220520030405.1308133-1-ray.huang@amd.com>
References: <20220520030405.1308133-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2533bb82-046d-46b3-92b5-08da3a0d8703
X-MS-TrafficTypeDiagnostic: BN6PR12MB1586:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB15867C66DBC05935A95C55AAECD39@BN6PR12MB1586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dbb0YaMKYvsIAWsM+PR7IreHVhjZdr5W/yQAYDfkHSJlbPju1t0QVFUmj2B/4Fxc2LLkZSRm050yDoIJD/JBbn7RNKjc6WASKezrYtnhvSJFMCqNFoPOmquqwuDM8FlrP6+Bap+GoIJPTaWIyxt4dA9Qyq1p7QOTJysn3rgG8LQjEQz0BUEXhmuIyhda8UxRRHxXXtNSFSjFnRT3cUiqtL0jljm9lFGULeEyCBFKgeQHfAW5iBXlwuOq9DzqRsxeMWH0DqAGtAR1zpSjZ9tvJJMztd0nkY/OUo+r3w4gu3D4j/6GCCIeiGsgUqeedwio/4dyvwSjfNYwX4UcYcxt3RAllxKfkskYk/Nd+NpzqL0HgO0JKhVBmdILSvDXWgUFNMTeayKpyftqPcfgys8w9DJXt2L46ANO7ysT3HXOta0xS6S90IM+QRcM9PNfvicRUU5XYV6qkVKDvD4+B9uDq1M+TvagdyViaiyeNSZ+vlH3GLmnDUWEtOOybioD+C3JFEfZOXTLppWK+RAjBNZYUXfBRaEDaE6ZAXDeObel2Rx/1GHJ63pIuJPLuG9CMVRx6HFEx8xNKKcqKXI2yWfXhe71wa0lz+Y6n8aE0unoQgh+ff9Sm/B8oPgWYLDfkZwqBl9MB3PRIOOq/T4pk8wsde0tOGcoZIqfUggOlP1Jbrdx15HabKhyaaFnaRwD/jsclSZcs4K91PjtdvpY95OkAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(54906003)(81166007)(8676002)(4326008)(6666004)(16526019)(86362001)(2906002)(356005)(6916009)(5660300002)(26005)(7696005)(47076005)(70206006)(336012)(426003)(186003)(316002)(36756003)(83380400001)(1076003)(82310400005)(8936002)(70586007)(40460700003)(2616005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 03:04:59.9709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2533bb82-046d-46b3-92b5-08da3a0d8703
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1586
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Switch to use the callback function to poll the reset status on IMU.
Because it will have different sequency on other ASICs.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h |  1 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 35 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index cfc4a92837f0..484e936812e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -35,6 +35,7 @@ struct amdgpu_imu_funcs {
     void (*setup_imu)(struct amdgpu_device *adev);
     int (*start_imu)(struct amdgpu_device *adev);
     void (*program_rlc_ram)(struct amdgpu_device *adev);
+    int (*wait_for_reset_status)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index da18d6724125..64da0ad688d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -117,6 +117,25 @@ static int imu_v11_0_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int imu_v11_0_wait_for_reset_status(struct amdgpu_device *adev)
+{
+	int i, imu_reg_val = 0;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
+		if ((imu_reg_val & 0x1f) == 0x1f)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "init imu: IMU start timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static void imu_v11_0_setup(struct amdgpu_device *adev)
 {
 	int imu_reg_val;
@@ -146,19 +165,8 @@ static int imu_v11_0_start(struct amdgpu_device *adev)
 	imu_reg_val &= 0xfffffffe;
 	WREG32_SOC15(GC, 0, regGFX_IMU_CORE_CTRL, imu_reg_val);
 
-	if (adev->gfx.imu.mode == DEBUG_MODE) {
-		for (i = 0; i < adev->usec_timeout; i++) {
-			imu_reg_val = RREG32_SOC15(GC, 0, regGFX_IMU_GFX_RESET_CTRL);
-			if ((imu_reg_val & 0x1f) == 0x1f)
-				break;
-			udelay(1);
-		}
-
-		if (i >= adev->usec_timeout) {
-			dev_err(adev->dev, "init imu: IMU start timeout\n");
-			return -ETIMEDOUT;
-		}
-	}
+	if (adev->gfx.imu.mode == DEBUG_MODE)
+		return imu_v11_0_wait_for_reset_status(adev);
 
 	return 0;
 }
@@ -368,4 +376,5 @@ const struct amdgpu_imu_funcs gfx_v11_0_imu_funcs = {
 	.setup_imu = imu_v11_0_setup,
 	.start_imu = imu_v11_0_start,
 	.program_rlc_ram = imu_v11_0_program_rlc_ram,
+	.wait_for_reset_status = imu_v11_0_wait_for_reset_status,
 };
-- 
2.25.1

