Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FFBC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F18C10E197;
	Fri,  9 Dec 2022 03:49:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA8410E222
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoOmCic1GXHGPQKTvyAf+7KD9iy61ZfEC6cokUa2P9B0uLtOnJYyItlYDUEAsDqf/l9KG9drpo7AOxQ/BIe/yQGaVkBAWfv/+b4wMERg3d6KNtuVVc5Y7pgwmiFOs+tlP3cekdkifE4oJumygSugv3lZC9iJlvEbyGdjYIpHuud+eqcJqanjwIiIeGf8ikViglJ3vRN/eG8bwl8GnV3tv5j4qqKJdHoMZALY1u0lv1JMvER+YN6uXYjYOf2tti2XIGsaGshVEU4plXXqU8W7aKr7/GA1J5GHpcceStcsh78IBwh/Mb2OQbbKprin7Ro7n/MUZlLqSoFZzgrdK8Tflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dffcztJ1ANH4xcRu4yqJMWMwA4OKGqmX1Xa4167cFEA=;
 b=Hd0nutCLrIaPeREOwn8WaPW/SqrptA7eKCChDeliWAVGBJVymBDM9aZhX6wUhHZZBuUf3EkEU3U9omtkV68/QbzLEMROd/w/bGS7TU36t1c06bEWF/fAOaBnFDr8j3h73PQwuBHy0wdiMEy6x4EmAnQejmF12ZT4zScl2Utxq2ZoVkKNn5Dbb5TZ4Ym0CqZfdGQy5PbKGWDxKMpFy92KjYs0M2NvTwCB8C2IXt6PYjmDglN277LumYPOYNMiohH8gUkxFB0RotZYcQtUjkWICCxS1HpCUkKJnZX6+zj84YsP9i1LU/k5Y1xaUb9pDv19rucWb5NBZUTYr27dOUaHyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dffcztJ1ANH4xcRu4yqJMWMwA4OKGqmX1Xa4167cFEA=;
 b=OdUH01pCWKp5K1zyCYRicyKbH5vkAdvJxUj+8EjduFJziW57MWtNZ9mpuByvJKwkEG3LUf2zVJ17QaxKoMvjN/d7NjqkBZNVUXCogkHSp2el0Y6tzUP/92i66e3E8U8NA1uJKsn1t6SJJGr57olSlB5f2FktziVxmbNmv2zxZaY=
Received: from BN8PR16CA0006.namprd16.prod.outlook.com (2603:10b6:408:4c::19)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 03:49:12 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::b8) by BN8PR16CA0006.outlook.office365.com
 (2603:10b6:408:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 03:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 03:49:12 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:49:09 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: bump minor version number for DEV_INFO and
 SENSOR IOCTLs update
Date: Fri, 9 Dec 2022 11:48:12 +0800
Message-ID: <20221209034813.2373727-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f90cb7-d435-47d7-4d6d-08dad99855a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1Q5DFrHw5Fd/A2YDfWFw2AB3c+udf0q6Bum88n4/kTbdK4YLOiSIbsNgOncQSGcqkoxV6slqygnoM4b001dZQcSkK+/oFUKvutkPp1HvZpYixDK+o7dqMWOeinU4fW6MkO/dPUSsGLooVaYZP0MLLVhsWXDMmkXLJf2wzDxf94TzVn43AO9ZB2p2Bn8+TcooNyqNwQBl3suJXRhYjlX67gZ7JpdtFrIIevXTLHnOVVx0oUlG87PB2QDCf9tOIn2g0edwk73iHsfDEAwHe6cnrTxZcjJEMhVl4VaEqfUPu8s740L+9yx89i0IOVojMFRSTDKuAseBdFBySYlLNhMavq3BJX/dxZ49zsrulVYobIFv1iMPKQs08GiFrxsxye9e2wVJBTRcVZHRT8krcNyvFiyqaMq0haj0LeaFbm8NfV4Y1pp3xYPm2jAZGACwNhw6bkGONrPnGkRp29Inrk7MFpC2PvXDoQlJxw9nwZ10iyk6K+3nWqOhod/QZoJiV0FhTLCQoxBihzp1m/kMzi6nl7yGSybxX/YztAT298b7pTClZKMexcyTDYd43vAdEAmGsYKYH1j76hhNHNZOxsF3VTreAINkNhEw0mmfE5QDXUn9LAeyxXNUvmHmGsWfqdrZoWb+7DsthUhZeQdglWonY0FrK6owawE+jNpsWhIvKAyKjwShEHZz7o4GIprerapACRKZKDADvc4vQ5KvWLgurclS1M11DCIDfSre8gc+bc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(356005)(36756003)(82740400003)(81166007)(41300700001)(40460700003)(8936002)(86362001)(2906002)(15650500001)(44832011)(4326008)(36860700001)(83380400001)(82310400005)(8676002)(6916009)(70206006)(70586007)(2616005)(54906003)(478600001)(5660300002)(316002)(47076005)(1076003)(40480700001)(426003)(336012)(26005)(186003)(7696005)(6666004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:49:12.0718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f90cb7-d435-47d7-4d6d-08dad99855a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update AMDGPU_INFO_DEV_INFO IOCTL for minimum engine and memory clock.
And update AMDGPU_INFO_SENSOR IOCTL for PEAK_PSTATE engine and memory clock.
User applications can better utilize these IOCTLs to get needed informations.

Increase the minor version number to indicate that the new flags are
available.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2fc85ed8046391555282c0629d88c875488c2b97
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0826b0bca328..fb1720d171de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -102,10 +102,12 @@
  * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
  * - 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
  * - 3.48.0 - Add IP discovery version info to HW INFO
- *   3.49.0 - Add gang submit into CS IOCTL
+ * - 3.49.0 - Add gang submit into CS IOCTL
+ * - 3.50.0 - Update AMDGPU_INFO_DEV_INFO IOCTL for minimum engine and memory clock
+ *            Update AMDGPU_INFO_SENSOR IOCTL for PEAK_PSTATE engine and memory clock
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	49
+#define KMS_DRIVER_MINOR	50
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.34.1

