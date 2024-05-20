Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DEC25B75
	for <amd-gfx@archiver.kernel.org>; Mon, 20 May 2024 02:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEFB10E021;
	Mon, 20 May 2024 02:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NUTIDsal";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218AF10E021
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 May 2024 02:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxnThE2wmHU0Rf7e3xJJWr1cS9yg10HkFA0Gc7Wgth8f1Lo8CaZQxxwE5FXCzAPRaDWAGU0BZgiIu6Rz1qgFkv6I84CYygcMqocW+MQgfnoBRrNhMyX3BNa/wPwmvDOeVCFeEg2JNOFAzr8pdHcxz1tS0N6W2432yeCs5xQrOQjng+lYpyR6I80prtyoEvtO7SK1/ga5xnd2MJNEw9aErEFOp3i+LKoyOSqVejDHg+XJGscwJrQeCwUbHAv2MwSo2TxxQ2coIUShd6DIk7v2te8StSyM0uErsNorpNVpu5PNg91D7syqaK1ZhYhW+tdh5Wzu7UU4+4xgJsMpNFk/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrYORophP6us8BhGl29guyrQVHf6i2c6xpjavtMfSw8=;
 b=Unmo8Feo9E/W1FrQ2wwLznF61XA/Zxwz0Gvs25voMWp34GMMenFIVpZRdljVXGxhthAD8LvPdhS6dmvuGhv5RMtCgrLz2ebgCW9jfYt7W4ZXNOZnglbZ3MYEHFDV/Is64alRLhEIVXJ94ymephbO3Er1KVvpZbLcjJKIeqHqcPAZoxkbsOBo6IZ0vP5xq5eeCklpQJO/GpHxXYtVR2ogJWt+Pf3aH87jb3q3XVwG4itipLfAKm5pQh5Y1eXGZbON2OQYkGVXKc/CRxbOj9LRyfMM/Jsh4uqFK9VujK39OiLBOSN5oHPUtEStdux63jhSZtleRcKiWuLbAXDmX5VTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrYORophP6us8BhGl29guyrQVHf6i2c6xpjavtMfSw8=;
 b=NUTIDsalvtjLTD+9JC3Ix/lV6VV1YVcedinP1CyS5zm3RjsBTfFsHUfdTS9TjzUzaYfDOrJIaqNED3pUuWqZmmu58tg0e2clEVLMAfnUmQ78ZbjaDemFf0uNPzqouutCsX3MCNaCKLXe2hC98mwHL2x5p7FWQiibU0KhBpjZl5o=
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 02:45:56 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::4e) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 02:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 02:45:56 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 19 May
 2024 21:45:54 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: update type of buf size to u32 for eeprom
 functions
Date: Mon, 20 May 2024 10:45:46 +0800
Message-ID: <20240520024546.23403-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b38d57-4029-4679-231e-08dc7876f936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V7W8g0DyntUmZP7l/1YPjslOPXd6z4MmiZK3tIsZ4DgwZpqw2jUTV0z96dZ7?=
 =?us-ascii?Q?zVIN0EGm++CQhVIWw6J7UVWMF+DiMGyIcTKdz/54bx6tUTyllszKv4nEC0Pp?=
 =?us-ascii?Q?jxCTL92RhE7/6+m+hhBLTMyccPBFgnyRLhpRW2ekZ6CtC2Di8I8S66F/UYjJ?=
 =?us-ascii?Q?4D4I+QTMgFMp0O/gPBDzdOad1QhBb9QYQGOLs6sMOAaa+oM1bNVa8BJKdC3P?=
 =?us-ascii?Q?1gGxciKRH75qDPQeFCjsuLPrfauT3yASoMWubdcYBaUfN1T9wOsRgnZRUdnJ?=
 =?us-ascii?Q?QjHftrEk4LWfkuASlsT+OZMEMaAmjlZMh7psy7jSWmShEX/gUpqwnYe+pPhi?=
 =?us-ascii?Q?L/1KXz++cyxluW62BK726R3bvaY5/jWk9rlBaRFHPmE0rODY4d8c894Q0GxL?=
 =?us-ascii?Q?DzplgHL3jELRWhzUiXRViNy6Uvuh8TCQaBXR8kZZXZmg4N2pOvleid4ofL0s?=
 =?us-ascii?Q?exbLHq/sM6Li7Auex9qgQbZaU6icXtFCiDxSXk2xs6mO3iR+hvnB0Lp5/VxI?=
 =?us-ascii?Q?yPPvhOU1+VvJl/pYfd6m+DI1Yt4ub64RPQa9DswPlGYe4mVB/wVVgVXygeDm?=
 =?us-ascii?Q?pGBwNbPfr1pMkg5oQmdsb864V5DwR3vPmQG/mBxJWiRxXbAPggLy1NIW9pph?=
 =?us-ascii?Q?0BcByboGARql7PISaBG7YGLWWRs5h68sl4J/A0bBmgPSphzXlhUWkysnjAtr?=
 =?us-ascii?Q?0yZc49euBwOyzw9aXMDG6MM9AjrmvHivxDsvwJYmUXvgpDqIy7evnIY54f0V?=
 =?us-ascii?Q?VX8Uwyfr+OT9uRFfIiNIhsioCci7LDWjkHfWTOmySuSYXVfJJtGechZpRIDf?=
 =?us-ascii?Q?akej5YLxnXtdsEZQTD1gecq57uLH3Puy9tlJ6nizzsZSs5O3zNOdYbrY4Zyi?=
 =?us-ascii?Q?fG13J7VQFsLdxO4qmulN0IeR1QfWoTXhke9P+yw0Vzkp7JqdZTza4ypmkM6p?=
 =?us-ascii?Q?3kIU3BNmeGNzcX/55r0UBQvkMFqrjpNowvAMi/aKzyQ5xIuZXKIaINbXvMer?=
 =?us-ascii?Q?5XkeuR2QtFzX1JKQLjbx8rbrLEfvonz6sxq2lT1y2GWTVFKKUw+odP/jpUKJ?=
 =?us-ascii?Q?WHlTb5tw//stQEPRiMcfAnwR0YKmc34XY3bfPPVqf/QmUFbzZhB5G56pLLmP?=
 =?us-ascii?Q?Uyyt7LbCUW+9q3a7m7SzhGx+xcTgNDd3k7khMIkHG6PUTt+3Yrk3IfQA1Uai?=
 =?us-ascii?Q?ASqZR2KVXMVrHJRnS+e5EfMVx1sbD2bCS0ZvtvIj2rUIuMVV8toOE7B6PF/q?=
 =?us-ascii?Q?bK5v0dhe31xD7oA+hFTItTbETV+RQC5opt742CeAu8POspTEWDIzZLi/NY8C?=
 =?us-ascii?Q?RQWOdaeJ0FaIB3cUW6SNax4unRgoI9Mik+6KESuaeKxymXW+FJf7fsGMPESj?=
 =?us-ascii?Q?BDCrHCZLfUFFHn76osK+UudfHLtr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 02:45:56.1691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b38d57-4029-4679-231e-08dc7876f936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452
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

Avoid overflow issue.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
index e71768661ca8..09a34c7258e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
@@ -179,7 +179,7 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
  * Returns the number of bytes read/written; -errno on error.
  */
 static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
-			      u8 *eeprom_buf, u16 buf_size, bool read)
+			      u8 *eeprom_buf, u32 buf_size, bool read)
 {
 	const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
 	u16 limit;
@@ -225,7 +225,7 @@ static int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap, u32 eeprom_addr,
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes)
+		       u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  true);
@@ -233,7 +233,7 @@ int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes)
+			u32 bytes)
 {
 	return amdgpu_eeprom_xfer(i2c_adap, eeprom_addr, eeprom_buf, bytes,
 				  false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
index 6935adb2be1f..8083b8253ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h
@@ -28,10 +28,10 @@
 
 int amdgpu_eeprom_read(struct i2c_adapter *i2c_adap,
 		       u32 eeprom_addr, u8 *eeprom_buf,
-		       u16 bytes);
+		       u32 bytes);
 
 int amdgpu_eeprom_write(struct i2c_adapter *i2c_adap,
 			u32 eeprom_addr, u8 *eeprom_buf,
-			u16 bytes);
+			u32 bytes);
 
 #endif
-- 
2.34.1

