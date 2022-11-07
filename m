Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807AFC4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 17:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EC010E506;
	Mon,  7 Nov 2022 17:23:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C20010E4F8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 17:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/HcvNQb5yvs/n63Ypq8dD0GNAemAD5tDBnXDmNQ8vL96fF0mTnznBDWYqvg+G/UQuK0KNU4jIzSI+LpD6jhWlKlE56EvW8rRUM3exeiPrwUUCjjGtR1ozY4UuU5eWxAO2pMliHCiW9dXRRx5Q70FPr3wW7xOhLkFVylTztHmn9+5aZQcmVaFbpvsZftcMzbPR2cspHk6X2fZYBWmObL/lR5ii/6w4WHo1STWR0r0pd22Qx1Bu2YzKfQVY0JwQ2t+nRD9kjdMK07LsLWGJN6bEzOQgKH+jpvF2NEmgPQ2w2P+CBw7X3hp9D4YrZtSn5BW+S2JuNuxwRyVylua2k/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoZCOCAkQkyM0vlnaVrVFn+BgG6c6R4f0qIdC0L9ilQ=;
 b=HcM5MCFdCervbnIU3IdPh4Hiy8rS7Z3KtqgFZJ5IYYm1rZytBE8wXJipaxiUKa6Cvt5eVemSVl+UZ3bDJ5vTA45hg3JedvJUZ8uPhFdQHIwUiZbPbbujvHjcvkRs/n7cN+Q7w1sFdky3dkQ82WaA24t4J8uDOIDDB2Kfb+HCl6n//Hwhx47/6xiHvMWjpVaig1eLQ2tZ9TxDUzLaim5L3Yb1B2ycE6UrT4bu8ouLeEzyvr2p5MUl4EfjScKmsfZMwvf8jE+xBPmh9rSYUyVzrvNf46agp6y8bAE8yPNV3sSz8D7ivcZTW9f//3fBDP4Ahpekzub6u+FNPi+Ft/meaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoZCOCAkQkyM0vlnaVrVFn+BgG6c6R4f0qIdC0L9ilQ=;
 b=atq2JfxlqGv84DQC1VTVeEtwTn7+zrFJ/gV37DmiOQbhAX9QRHbZ4MfPdMi0tRR1uo1T/OXII2nP/l1lTp4tbIgjVN4omT7u7FsWqHRVWrdKrgSFrX1p57qRMdeUqXZjcYtxTyddIjm00sWokJPvtRR7i+DVnr03QsK+Tg0Z3OM=
Received: from DM6PR08CA0039.namprd08.prod.outlook.com (2603:10b6:5:1e0::13)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 17:23:17 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::df) by DM6PR08CA0039.outlook.office365.com
 (2603:10b6:5:1e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:23:16 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 11:23:15 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove redundant I2C EEPROM address
Date: Mon, 7 Nov 2022 12:22:53 -0500
Message-ID: <20221107172253.155475-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: d169da92-5bed-4f98-89de-08dac0e4c22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXyE2sSaY6u4j5g0QVsGwAKVjX11BUvB0hatarHEvFY3xxJXM32dsOsXgY5wtNB/hJdSC+4Dt+R9aMHFSjq0Orq5cBMNjnYT4Qy0hwSb9VCqD5EwfzRCP9Ff6MhO11+qb2H4XC+eb895Em49Qdx8OKF0Kg/XrjcwxUWlqav9/pWmG7HoEIe5vG93w11aswTX+XGyqdKdcx5Qz9eDYVqL101QXSQKLuzsilKJxgcWeguKiDN22ZEb0uRDjCyLYaC0mGprrIHTH4cdIU3sKcTREPmCIX4eCtcQnzZvWuMIAgCGH+UvXsfJzQiyBw5H0b/+UqJHmhHobib0p+qHwvxpLrUl0MUVTFWcuHb2jV8zFbZ6ggGUBn/bAqTAMSvKKdKgnBBiJ1bwVq8ndBiZfhO7dtWMKlGA1KTbkPWbHw6zJA0KpFCGFupCmwBwzqXGPkAadIVKyGCC3XbjPKxVfYSkOnNEuA/H3EHw91gIXmpoXrYpuVmdcPw72UGpiTJDnBnbu5/nZS8Eq1j4TyT0eMnzOvF88bz5syFFs0LkXrIX23tRPk/c2cTwybZbZnD/5seYoQZs983JHtyB5nCrHPeDNsn0uOImJs/Nta0LA0sbHdwiKJA+KrADwg35lEJyiklArZe/cfwd9coJDtk/gKV525t67unaIg/wok1ZdgEkzwMyetbzjADvq1eIf8my4b1w4BakqG1huWm2kr+AvKYvI+TUPVEFI/Szb81p0ui1CtMZqipOvdQr/S651JEL37+edruXT8gfFOAEHlzJlnKDKBpSMMBZa+ElaFLYa7ikMPZdpq8vfsLzB86cX4H4gSas
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(54906003)(6916009)(6666004)(5660300002)(70586007)(4326008)(8676002)(40460700003)(16526019)(1076003)(336012)(2616005)(70206006)(186003)(41300700001)(47076005)(40480700001)(8936002)(36756003)(86362001)(316002)(7696005)(426003)(26005)(2906002)(356005)(478600001)(44832011)(82740400003)(81166007)(36860700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:23:16.8406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d169da92-5bed-4f98-89de-08dac0e4c22d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove redundant EEPROM_I2C_MADDR_54H address, since we already have it
represented (ARCTURUS), and since we don't include the I2C device type
identifier in EEPROM memory addresses, i.e. that high up in the device
abstraction--we only use EEPROM memory addresses, as memory is continuously
represented by EEPROM device(s) on the I2C bus.

Add a comment describing what these memory addresses are, how they come
about and how they're usually extracted from the device address byte.

Cc: Candice Li <candice.li@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Fixes: 367a1ebddde5d0 ("drm/amdgpu: Add EEPROM I2C address support for ip discovery")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  2 ++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index 4d9eb0137f8c43..d6c4293829aab1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -79,6 +79,8 @@
  * That is, for an I2C EEPROM driver everything is controlled by
  * the "eeprom_addr".
  *
+ * See also top of amdgpu_ras_eeprom.c.
+ *
  * P.S. If you need to write, lock and read the Identification Page,
  * (M24M02-DR device only, which we do not use), change the "7" to
  * "0xF" in the macro below, and let the client set bit 20 to 1 in
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 7268ae65c140c1..1bb92a64f24afc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -33,12 +33,30 @@
 
 #include "amdgpu_reset.h"
 
+/* These are memory addresses as would be seen by one or more EEPROM
+ * chips strung on the I2C bus, usually by manipulating pins 1-3 of a
+ * set of EEPROM devices. They form a continuous memory space.
+ *
+ * The I2C device address includes the device type identifier, 1010b,
+ * which is a reserved value and indicates that this is an I2C EEPROM
+ * device. It also includes the top 3 bits of the 19 bit EEPROM memory
+ * address, namely bits 18, 17, and 16. This makes up the 7 bit
+ * address sent on the I2C bus with bit 0 being the direction bit,
+ * which is not represented here, and sent by the hardware directly.
+ *
+ * For instance,
+ *   50h = 1010000b => device type identifier 1010b, bits 18:16 = 000b, address 0.
+ *   54h = 1010100b => --"--, bits 18:16 = 100b, address 40000h.
+ *   56h = 1010110b => --"--, bits 18:16 = 110b, address 60000h.
+ * Depending on the size of the I2C EEPROM device(s), bits 18:16 may
+ * address memory in a device or a device on the I2C bus, depending on
+ * the status of pins 1-3. See top of amdgpu_eeprom.c.
+ */
 #define EEPROM_I2C_MADDR_VEGA20         0x0
 #define EEPROM_I2C_MADDR_ARCTURUS       0x40000
 #define EEPROM_I2C_MADDR_ARCTURUS_D342  0x0
 #define EEPROM_I2C_MADDR_SIENNA_CICHLID 0x0
 #define EEPROM_I2C_MADDR_ALDEBARAN      0x0
-#define EEPROM_I2C_MADDR_54H            (0x54UL << 16)
 
 /*
  * The 2 macros bellow represent the actual size in bytes that
@@ -130,7 +148,7 @@ static bool __get_eeprom_i2c_addr_ip_discovery(struct amdgpu_device *adev,
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 10):
-		control->i2c_address = EEPROM_I2C_MADDR_54H;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
 		return true;
 	default:
 		return false;
@@ -185,7 +203,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
-		control->i2c_address = EEPROM_I2C_MADDR_54H;
+		control->i2c_address = EEPROM_I2C_MADDR_ARCTURUS;
 		break;
 
 	default:

base-commit: 03b61a92efbaf17ac3d9f82ae81aa4cf8ed40608
-- 
2.38.1

