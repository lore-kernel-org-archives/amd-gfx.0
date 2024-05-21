Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C9C25B77
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 03:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5664C10E186;
	Tue, 21 May 2024 03:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TT4RLDeM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9426010E39F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 03:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKz0SoQ9jOdARjZA9BKVmqogCzPxm5Vfkoe4OC0RGWxYy/lQINNOo4tAbZUEynl9dvt4Cvplfjfxq7F3I2cuvRgbQp6PFBL+0vLEecP5wxJR2wspS8uxpy8ia9uiQ9G41pTkJ1rKlPqXG9+eJp2tZWYZp6ZZiQOTK8LWMtboEpT401wRfCL3jIcLUJCpXk10BGcejCTJRCu13DxIg8fFwiC2UQkBg/V8cv0DON/USJrjs03mcRwTjoWwNeika/SdIIV0dy5n7q20ZyyHoFWFggQbaHXQ6K1ydQ3M6kPh9zJAabMqk1TeYeLTH/QuXbbfKdGZTxc3LcRnaPwVfsveqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clA8YnPrbxHwq3i1LQP9MwwZc0c2s8vPmgszrGA26gs=;
 b=lcePiB0FXlpsJBCSFbRSULIVBQoqDMny3aCxZwzZWwkjJLIxxY5adXlQ91qgbttLjSLEWOC9uE/yW4ZiL9wMbuR9TzII0MPXHuB+5i2fqzPTwWvZdwUGAbJ4vRkBWMF/6ZA//4PypAuWKR1XBrzNkFyfR5sosh2KqKMj+yRoV6+EiHTYYLXmN/vJ0F4jTV6JmlIbHk3gUf+KmDX3cW/lHGgd30n6w0wV/tR67PANI3s7+LywPv2QgNHLn0mQDTzWTu7uT7NvAJVvL7q7E09JkJsD36iOTDCmwFS7YJ6h8Pf9H89zcjujwFEdF6yM5k+HaurF3J2sAMhjHg9IJ2d0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clA8YnPrbxHwq3i1LQP9MwwZc0c2s8vPmgszrGA26gs=;
 b=TT4RLDeMYYjCiChF+IvTrTXHmUVJnTWqT2bWPC5ztDmSUnjuJXTVYMdk1CZBLvBJMgXIGRnR7IiMaacH4GqbcNbaco4Lyij/h1FjsUJUUHO5FS1yOVWzRlJ9K6byraK+hQlOITBc9/JNzwb2iyefqiB51sqi/4qYTuTBYhRGcr0=
Received: from BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49) by
 PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 03:17:42 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::a5) by BL0PR01CA0036.outlook.office365.com
 (2603:10b6:208:71::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 21 May 2024 03:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 03:17:42 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 22:17:41 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: use u32 for buf size in __amdgpu_eeprom_xfer
Date: Tue, 21 May 2024 11:17:24 +0800
Message-ID: <20240521031724.2612-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: f336bab1-76bd-424f-1272-08dc794493f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0w2UVxXj+Ahd5npNKYNAwegfkYQu9czuah20dAaa6pykD1Gg1KQ5wvCDBGZL?=
 =?us-ascii?Q?xyjTqNspHM/k6jIoPDXJ1YvVlpwemPLCC49jwEjEc9RIkTCp5X/qY/2gZNn+?=
 =?us-ascii?Q?4r5OdRHs5lkVlSNuMOIPDWAVtcd+L30ht6QRpmxi/WpCqokJIp/42zIOUTxh?=
 =?us-ascii?Q?CnkcdUxW78Hh2QtPC3Wl1HQzwuHnWFTY6JlffKbBK5QK8vig4svrGR8trrFg?=
 =?us-ascii?Q?ED4kQ8Egsp8pnUOnuOzFSvGCZK6b/kibyiwCDqbrtFBOPhakvDNGGght2apY?=
 =?us-ascii?Q?fu9XcBxUKBtgTXyYxtE0ncmyIV18M8vP+fI7ms9EgooHmDtXe7+cCfnr/S0h?=
 =?us-ascii?Q?nWfJ7fIYc03JRlNR5967dTq1NPqCcv6Spyx12JEeiTxrASAxyhqc/BqULZql?=
 =?us-ascii?Q?hrH3pxl6da0RhXDvY0esMEbdhYFIS8c0iEouWJmpiBCzOSW40/KEKYX4o+cO?=
 =?us-ascii?Q?iwWomK1kHVNns9GSqHh/G42I+3frukUISOZUXhfNnNJGxQJLo9NZFq8FjckF?=
 =?us-ascii?Q?ckDCNpuezDfo7J0UPtSCM2RLb2Vi3JWZnQouVDn1k7pQCuYeoH4Ar1l4kOgF?=
 =?us-ascii?Q?0dH3hV67Yxfy2PVu6qgQ/LXoRUp0o247KBat8M/+4bDWzvpxoKGRLHcBoFXf?=
 =?us-ascii?Q?5hfHiWaWyUGpLAwgWpce+p5fR/Gijfj+N3ClpSUC1wcXwxXH+7YoE210uN+a?=
 =?us-ascii?Q?M3hxYnm9BFpwg2V/v0MgDnfiG5R2YxvTdaM1jhUXfG2+/ED2gvpeMCfEMKRT?=
 =?us-ascii?Q?u4HXAlwPurye+KrMY4MtnQQ7xu6OtvU3oL4TK2tRQfH09xeRTenhgERLBCNo?=
 =?us-ascii?Q?j3hpdzJ+JzB6F1pyB3yr2+qdn2aQkhArn/kKlmwK3uqW1ta+cjybCZwNq58O?=
 =?us-ascii?Q?ouqHOSacgRYPmHvTmUFMNn5OmzajmsdsRZscK9mDhSJXbnFicmIVDEdSyp05?=
 =?us-ascii?Q?4Md8TWl+CTfHiArYh5EXnDgbSgiNeDqW4Csqc8lKFLnpr1sLw5Tzm7IvaxOu?=
 =?us-ascii?Q?VaX2fNcbT5mnqeyVdZnS2yvGgZE1aVdbVlQdCX7+fn6+8Paef0Qt2Ed+ZLEs?=
 =?us-ascii?Q?3xB1/5hqSXVIR0S263f/O8LwHlBwmPbN2Huo26ykOkYc+KS1/WHs/wvztqN4?=
 =?us-ascii?Q?pw3zH/P7gVJ+EOniVO+Ww8eq2ksl36oOl/fVNPw0L6l4NgWunwHZZ/0xJTNw?=
 =?us-ascii?Q?g/tJXO3OzZ+9OGr6MI/+3x0in/KKpwrm8/t8XeMXD+RW4cV5L+QiouCAuOnt?=
 =?us-ascii?Q?HGDvUppmrmNnGxMaOoEkahOsTz8GoN32xtkStPnpnbjtaudELInc+xxFvTdZ?=
 =?us-ascii?Q?jyjtCKwDyQ0I2mvOVuRU4i9IjYj2PwTLS7wbtLoyuh9Ub1xLUDoPLYXACPg5?=
 =?us-ascii?Q?z94rLXY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 03:17:42.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f336bab1-76bd-424f-1272-08dc794493f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

And also make sure the the value of msg[1].len should be in the range of u16.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 09a34c7258e2..35fee3e8cde2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -90,7 +90,7 @@
 #define MAKE_I2C_ADDR(_aa) ((0xA << 3) | (((_aa) >> 16) & 0xF))
 
 static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
-				u8 *eeprom_buf, u16 buf_size, bool read)
+				u8 *eeprom_buf, u32 buf_size, bool read)
 {
 	u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
 	struct i2c_msg msgs[] = {
@@ -133,15 +133,15 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 			 * cycle begins. This is implied for the
 			 * "i2c_transfer()" abstraction.
 			 */
-			len = min(EEPROM_PAGE_SIZE - (eeprom_addr &
-						      EEPROM_PAGE_MASK),
-				  (u32)buf_size);
+			len = min(EEPROM_PAGE_SIZE - (eeprom_addr & EEPROM_PAGE_MASK),
+					buf_size);
 		} else {
 			/* Reading from the EEPROM has no limitation
 			 * on the number of bytes read from the EEPROM
 			 * device--they are simply sequenced out.
+			 * Keep in mind that i2c_msg.len is u16 type.
 			 */
-			len = buf_size;
+			len = min(U16_MAX, buf_size);
 		}
 		msgs[1].len = len;
 		msgs[1].buf = eeprom_buf;
-- 
2.34.1

