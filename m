Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382BFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 01:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A03410E1A5;
	Fri,  4 Feb 2022 01:08:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2089.outbound.protection.outlook.com [40.107.95.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D71510E1A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 01:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG+xBYb9S0Cbv4/Q913T9ATkIgVO2Ft534kkOzjBVOaR9mv9fizJLXP5ZkihkcPtfZGdYubRctglRXsF+jBdMEPQs/2c0DSuxKf/IZvfAaHTAXRX5U57SC2rj8bskuB9birWFbXuBGpZk2e7foQRSwef2BxBqVqPx5p7zrkFN1Zk1I1LAhVJ/DFnKccuxtROw/GvjDm04YkLhx0z1kHSmzq9DYYo8FeiwoFRo3UERh29sHFFqdIQqk5KKvZjzf0aEtVumb+YCWrYl0+Fah+tnilAErf7/jusTkxKvpJ7NuhbcojOKaf9Ck7sSnX090S/2/bjOU9ZxYvnzwaD6jxP7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqHx0g8bwmwqXdArReDM3xg9l/rcTEX7mpstosIHTJY=;
 b=JoxdwTkfcXPqdbyqBOw8iD5bjahFQiovK3eYScoteVMQf+ApniCb5eaH+G2xT2RdxSeU/DZBJQUZjqbj7YtPzBWafbsvxwmHFdMpWClvznikZz1xlnGRVEWgdtFd921TmcgnDbuc5JCz3WqJpMWCAu69QP0y6IDybrtSBdaJ3VGX28MT8uTjZCWHioozXEefpfUwXy/eKbEI95DJZH4rLo/RqOiuAugGBJuyQPutjG3ad9AKazZaHFx07RTJq5tc5ZT+tD2RRwpYDXRd3sCJro0E/5Piv54SvH8Cd/BN5fKwtxtMIx5mY6ld58qhTjVNbPx1aFQXB7ZZl1bDoujYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqHx0g8bwmwqXdArReDM3xg9l/rcTEX7mpstosIHTJY=;
 b=G1CfB1ydDptVzkFKhAMiqxG7mWTNda5Klw20MFffJwxCsg0XXPqq5zReRfqdw4YN0ekfVnqBOX0HQcS9RxjImK35aBVXXIKCKF3P5hUgZxxeAd8ErFEczQi3Kun2BOuXPYURgRMQsRJjOXadppBum5AhbLtPe97VWk/0tyzvVAI=
Received: from DM3PR11CA0023.namprd11.prod.outlook.com (2603:10b6:0:54::33) by
 CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 01:08:35 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::b0) by DM3PR11CA0023.outlook.office365.com
 (2603:10b6:0:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 01:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 01:08:34 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 19:08:33 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Don't offset by 2 in FRU EEPROM
Date: Thu, 3 Feb 2022 20:08:18 -0500
Message-ID: <20220204010820.250829-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8af4e6bc-e546-4f3c-fb8d-08d9e77addf7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5106:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5106EF0D5D5CB9AAA0C971B199299@CH0PR12MB5106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twJ/3fURNfgjLnfiNGjYhxGQGeyZ0lIwMAmBXYH/Jw94Ghd2XiJU4CHxroXGyJMJ4gCHpCOzfRbFZ/zAwXJu1b08xfMQcUepBgCfdAwyJ6M1nE3Qb9Q/d6FtQ2Dqv5ee/cKtFPhQ3gg+7WLmvCy4YTYVMEzY5Ty+OZS89Uu9YxSG0i3nhIuQKdTVFbQB/5NuXeP5fSxhxdHxQx4evKlqji3eVrjZa7vxp++axSy0c0omy73MvbsIwWYeQXkfHlzhpZI3axXzGeWTG7tjWkr0nLeyt6jn4k7Z6IBTPDu4xO3a3LzeEQ9uleiMMlePUxJlJUKoyOmNHnGN2i/+pVlsTkSLfh61vmWGChRqHMPc74jfhSVO+mf+rtQ2nyg5OH+OPnFnHW2/cG0A4ujwQ2dFgo0s2igprEWMZaqLBrfzPhyGXE7CrfVZrHpjC/Hb5rgrWlYvocOZA8WBtzWSRT96S08+/nm3aKjggj428IXhJGT+SQcGKwwpELaCA5nLArCCQggaKw19qPgLvHzwuIzSr9BgLWDJpIyE1pkKrtNGkwc+oJdcB1UvfRAaNNRyoa6a8tVPGlJuJn00b1daIIXhNKJgUPMjlnACTU1mN7hy2mpxPYA2/HS1I4QhdUA5yUQWY6Og7x/+dqoKdMz9BgfjUJGhq6PK2RcUilyL0uS/z+6rKJb4okE0PHrYdtONj/XHuooLIhOyJTFBh98kPvnV1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(4326008)(70206006)(8936002)(8676002)(7696005)(356005)(70586007)(5660300002)(186003)(81166007)(336012)(44832011)(2906002)(2616005)(83380400001)(82310400004)(26005)(1076003)(426003)(16526019)(36860700001)(316002)(54906003)(508600001)(6916009)(36756003)(47076005)(86362001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:08:34.4741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af4e6bc-e546-4f3c-fb8d-08d9e77addf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index ce5d5ee336a990..32f38d0dd43dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -103,17 +103,13 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buff[AMDGPU_PRODUCT_NAME_LEN+2];
+	unsigned char buff[AMDGPU_PRODUCT_NAME_LEN];
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
@@ -155,8 +151,8 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 				AMDGPU_PRODUCT_NAME_LEN);
 		len = AMDGPU_PRODUCT_NAME_LEN - 1;
 	}
-	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[offset], len);
+
+	memcpy(adev->product_name, buff, len);
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
@@ -174,7 +170,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[offset], len);
+	memcpy(adev->product_number, buff, len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
@@ -201,7 +197,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[offset], len);
+	memcpy(adev->serial, &buff, len);
 	adev->serial[len] = '\0';
 
 	return 0;

base-commit: 1b768224871f72e594f41eded3a14d682e39f796
-- 
2.35.0.3.gb23dac905b

