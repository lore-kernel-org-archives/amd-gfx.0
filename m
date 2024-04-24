Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9CEC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 07:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E7F10E279;
	Wed, 24 Apr 2024 07:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JIW1/Yr4";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4380E10E37D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 07:52:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6wAXR/MeZXKw94jg+vcWdwgafNGYQkBMU4A+g2KeJTEX7ugPCl1UO/xw2nKukwb3/IRZpxFg3G7h8qya3vAZ6liF4twFDhhtVpvo6x1R2njfSk8BB2ICbyAw3X5aboawbQaVx43X80LoTmp+znY4bGFRcmo0pG6UFaHwfb/4aQ4z5+igf9PXMp543DZxFoHa7AbFosvYcW6vFs1LKABOuri8kQ7Xsa9Ne7yct1hicT+gU6cwBVrWowYCSI4/+3YiXK3uQLQNbVS/hXD/EA40osCnlvOky7iVypb7CpAYsJfNGDRuQRE2CKolDlfz2e9T6y8u8ICRgZWRJcB0fMqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrpZ40WcV2pAlI04r3HOfSgqVGavtbuBgkOTakHogKM=;
 b=Sa/MfqlYu9iBXogmjFWn/anAqmi7jc81YPCM9AG9aP7LyoioXvCjTNEAiZzJN997TTyvfquJgj/eAncoCTPEhvd9njZytg+8QN2jlsd+zUbvrZiOLhomMOegjsh6OQBTDUaIxHOG+1/40VcjCeHjB/CFYKq3qgopPNMUEL/donWLzUmfu5qWPMeIU+G7DqJY7TKoxFnslCC4KEoGzqm+tk2zQExC8jgNhmpA2ITzbiTbUEeyCceOku8CGg14BmyFyP+uFYeEini3Vp6x4YJ/q/FiDlNluByeroV3qcPyJ2oytxkGUyIhY7NZCG/K2nC93rU3ZJhK1nfLa8TyfJhHqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrpZ40WcV2pAlI04r3HOfSgqVGavtbuBgkOTakHogKM=;
 b=JIW1/Yr41/JGUCXMYMTvs+7Z22gxLj7lZgd/H2SgscejkXdVCcMvcQh2hKkQ0ju3jFQf7TrojmqMwUa/h4QgSsO/zC1FocYfWkHCTiWcU4Jp9Zti9Xz5YtPwSayQLMDG55Ni7J7eZWJS8QZs9KOsF0ciZrbE0Rw3e5S9P6r9aFg=
Received: from PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::24)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:52:50 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::fc) by PH7P221CA0027.outlook.office365.com
 (2603:10b6:510:32a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 07:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 07:52:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 02:52:48 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 02:52:47 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH v2] drm/amdgpu: add return result for amdgpu_i2c_{get/put}_byte
Date: Wed, 24 Apr 2024 15:52:41 +0800
Message-ID: <20240424075241.49101-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: bob.zhou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcde1ae-58bf-4361-d103-08dc643389bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ggNcx4rULwe6p3mXCkEqPEAP9BTuHTsCrXOTSQptZMNRdqlYxjKlcOZ2vrWn?=
 =?us-ascii?Q?vQbqponBCDVjqWk5yhi6pRG3ba4Op6OEv8u+UekdPFLDF5v14aVe6IzMmSco?=
 =?us-ascii?Q?hbNdsB8U0FElRUSyCZFDEBJZ87FoXlzEamM0pWufdzsw5Xu7pQ57HOFp3YLf?=
 =?us-ascii?Q?OcVck+THL319OEFEMeLYjOgKrqzBBYO9mqwOd0w6RtkOrnBdekdGGwer27TR?=
 =?us-ascii?Q?AB+BqsboaL47A7xGsCUUD7yjzkMnmgc2tSiSZUWdRdtWDz6xO2ooZn9/Amp9?=
 =?us-ascii?Q?furU6M+20pksooBG2z4QVkH3+lum4qXqzy2JEEi7GTxXbLVOoPCJanMgrXuH?=
 =?us-ascii?Q?8jnTsHlm2j8I9DAYL3RSCGv+Ie6ZEE9+gjr31Gd5rkCBdJFuWauDB+bfm0/w?=
 =?us-ascii?Q?qFug26rhNxUUnj6p5Ysm/Zv0EAKIlb9pzsBTiMQHCySJDrXJB3NEqQDpVl+X?=
 =?us-ascii?Q?QS3dZ2Zj6kOEIuNP0/tT6NiUBEjnwXfv83pPFxYgXNzqV7QL6T5BLqz4IcH+?=
 =?us-ascii?Q?Ir3NDTwba4vM0YTX4uDE/32X79C5S7kJdeJL83e5S1HtgMDSj4Awa+CaEzgv?=
 =?us-ascii?Q?TVfCzlrUBieocrbjb+AsEO8PXU99KbgugbZH0656CZ3iARbxVtpr2UwIm5/m?=
 =?us-ascii?Q?KM1VvOrejflEvLUTWzi6b/2qegdDvbV8chu9zL1ZBzRn9lIGvUdWIJeVafOU?=
 =?us-ascii?Q?YDTC+Oy/kGlizvngIgozkwaanoX/kZuAsxEQVz3vGOqTN3nQQLfg3FBB2uG1?=
 =?us-ascii?Q?QLrVztXsbVP4CQbsiWM8gR04ZJQbiwYx7E3DqyGV9bvymemmp35TCBT1D6dC?=
 =?us-ascii?Q?UTsI2LIq792ftApIb1drKsQHU+d4ucDD3CCxbl3noF4FNJ/yOIDE2/LKfZ1Z?=
 =?us-ascii?Q?rGFJdS5oawhfpPph9RP8Fh9bf6On+sLTDfEcpbJpyN4jHumRJykfq8x+DWOu?=
 =?us-ascii?Q?du6Sf7tpkQemal9PmB1UfQCNfFF6Yh73slp8JXr2sPmvfyCLuj4xCkVG1X7f?=
 =?us-ascii?Q?YkihCqTpFHfZeQiPp6eYiFl1ZwJPjUFp4LHaIiiT9qxGvS3W2SbgVoQ09+XC?=
 =?us-ascii?Q?sTmwRUzWn07Wm+FgkEApE4YXBJWethfUVvtxE+FYKvKm7yjpRXYxq4xAQwKZ?=
 =?us-ascii?Q?JKgGXRla0vBd9GOe3nlEfyAYfzua4tdDMZf2F93/94SA7M326R1JQpxIojqE?=
 =?us-ascii?Q?a174kurSBZZCUxDsRWrWgJUKnr9OGq9BxpQfnzSZ2giJLlEV3Q7kDsNkkwkc?=
 =?us-ascii?Q?Ba123N56z+Q9hhKG4uyja5ZjPEy9t8ybmsqg8swdbLZJIMtE36gIrdTqVhmw?=
 =?us-ascii?Q?fE/RKdmy2l1myn1p10rd1uruMW5CUtrdc7JJsts5ohn7qSSnUthjEgIMDVqs?=
 =?us-ascii?Q?y28U+V+oH2cZbm8eVKcPIjrwUM7F?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:52:49.2340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcde1ae-58bf-4361-d103-08dc643389bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After amdgpu_i2c_get_byte fail, amdgpu_i2c_put_byte shouldn't be
conducted to put wrong value.
So return and check the i2c transfer result.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 42 +++++++++++++++----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 82608df43396..c588704d56a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -280,11 +280,12 @@ amdgpu_i2c_lookup(struct amdgpu_device *adev,
 	return NULL;
 }
 
-static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
+static int amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
 				 u8 slave_addr,
 				 u8 addr,
 				 u8 *val)
 {
+	int r = 0;
 	u8 out_buf[2];
 	u8 in_buf[2];
 	struct i2c_msg msgs[] = {
@@ -309,16 +310,18 @@ static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
 		*val = in_buf[0];
 		DRM_DEBUG("val = 0x%02x\n", *val);
 	} else {
-		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
-			  addr, *val);
+		r = -EIO;
+		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n", addr, *val);
 	}
+	return r;
 }
 
-static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
+static int amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
 				 u8 slave_addr,
 				 u8 addr,
 				 u8 val)
 {
+	int r = 0;
 	uint8_t out_buf[2];
 	struct i2c_msg msg = {
 		.addr = slave_addr,
@@ -330,9 +333,12 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
 	out_buf[0] = addr;
 	out_buf[1] = val;
 
-	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1)
-		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n",
-			  addr, val);
+	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1) {
+		r = -EIO;
+		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n", addr, val);
+	}
+
+	return r;
 }
 
 /* ddc router switching */
@@ -347,16 +353,18 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
 	if (!amdgpu_connector->router_bus)
 		return;
 
-	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
+	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
-			    0x3, &val);
+			    0x3, &val))
+		return;
 	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
 	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
 			    0x3, val);
-	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
+	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
-			    0x1, &val);
+			    0x1, &val))
+		return;
 	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
 	val |= amdgpu_connector->router.ddc_mux_state;
 	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
@@ -368,7 +376,7 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
 void
 amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector)
 {
-	u8 val;
+	u8 val = 0;
 
 	if (!amdgpu_connector->router.cd_valid)
 		return;
@@ -376,16 +384,18 @@ amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector
 	if (!amdgpu_connector->router_bus)
 		return;
 
-	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
+	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
-			    0x3, &val);
+			    0x3, &val))
+		return;
 	val &= ~amdgpu_connector->router.cd_mux_control_pin;
 	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
 			    0x3, val);
-	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
+	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
 			    amdgpu_connector->router.i2c_addr,
-			    0x1, &val);
+			    0x1, &val))
+		return;
 	val &= ~amdgpu_connector->router.cd_mux_control_pin;
 	val |= amdgpu_connector->router.cd_mux_state;
 	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
-- 
2.34.1

