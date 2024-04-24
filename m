Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E61BC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 09:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046AB113998;
	Wed, 24 Apr 2024 09:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pcw3AxYL";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810CE112BD8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 09:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEmglB5r2Y2SvkEmDLoWIT9hd2zsfYJEWSgwAv0AV0I6eJcGF7qjaYoFO+KptuqHVhU4huJb03ILOq6ZR03UpWUULDnsMmuBToyt+GsGcn43S7JjLaR/T9SfpupIm60kp3vU+IGksxP+L+SHhNgc+/N/jb37I/ftA9OC58xyYo18MCda6u/TBDe3Wu4rpKp3pxX9p6u9r+wzcBJ3TyZ/+4V5E35ZH/bZiJaENvSNkPrZXhvux9DyrCW+lUc5DiuaV6EsYk9G7T6ZoS96iV0xfMpRx77bNfNh5lUkFjTs2qRF6ZkCUkZZMNirEwV/PotH10nnyu5n2hDleS2Ew77Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE0j4s4suJWyEZIkyxUwfUjkErI56xPRfvGduPezrmU=;
 b=VY8N0iixLKEHST3dDkXiomD6e1ibpYyWyclhPWGsXOY/coS6ZmAMTyTKWY3nBuq2kPU5O/XyntzYR+tOEheDpNd752gvCXkyX3eJKWnF9C9SixWApVZLgts6W/v/gP3cwazj5bvArvt3JhagMAp8OKQLGUkImVjnYrH9IkDKbVqWOC8PNnVw3pbBfulOOpDnZOeW2ISW2SODIL0lihm5902fzxzhIdRY6+PgvZFzVDyRHTsG2xUW5q1eJPDxZX8mi0yzVavcXEKnnY0hCU9EogLJ2jaHEZ2liq5k8UdYbcBV0tr/eAkPqLbMxYw2eQncFOVmEJdgl9QEuiLanjcjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE0j4s4suJWyEZIkyxUwfUjkErI56xPRfvGduPezrmU=;
 b=Pcw3AxYLBMta9za/jIGdWxfT+jm1URqUCsFLTr1kuYHehNThoVxnf+lUV/NL1xGZgu6goGAsMNXIXaPNigT1cVHSDtE9m0+8R7syzQdYn/da9ZIVqi354XOyqic9aqfzG2dXLBf1tO8c3diSoDkcTd7A7PcqEB8DgM6U3w32YG0=
Received: from BN1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:408:e2::31)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 09:36:49 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::39) by BN1PR13CA0026.outlook.office365.com
 (2603:10b6:408:e2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 09:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 09:36:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 04:36:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 02:36:48 -0700
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 04:36:47 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Bob Zhou <bob.zhou@amd.com>
Subject: [PATCH v3] drm/amdgpu: add return result for amdgpu_i2c_{get/put}_byte
Date: Wed, 24 Apr 2024 17:36:46 +0800
Message-ID: <20240424093646.59783-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 91170dfe-8b9c-478e-f9ad-08dc644210fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STFjL0tjMVpwWmxrc2lTdWFUTGFKc05SWDZ2TjJGSjBxZ3k2TGZ5QW5TUUV2?=
 =?utf-8?B?RXJSNVluQTJzOUpzSEFtdUE0ai95OG5aTFl1anVOUlkra2lLNDRNOWd0SkJB?=
 =?utf-8?B?VnBnUGtYZzhLUG12TUZuRFhDS213MU5scExST2RLUVNaUXphbU5EY1JHNlVm?=
 =?utf-8?B?dHk5Vy9UZzdVOVhvb0srZUhsWnhVckVjeDJPSS9QMFlMWmpqZE1kcisrMTlD?=
 =?utf-8?B?Q0RlbjVTMHl0eE0rN0NRR0J2a21Td0p1eGJzaHVORFppWk9WWkhnZnBXYUxv?=
 =?utf-8?B?UThQV0p3UHdtOCs3WXRBckxodSttcE1LZUhCRWIzM2ZlZHdNdC9BVi96Tlow?=
 =?utf-8?B?bEtKTWRJdTc4blhuWkY5bUl5NjFXZTJXaEN0ZmVuN25uQzBZamc4OWIyTmUw?=
 =?utf-8?B?bUh6WExXKytSUm1MQTFGVGRaV1hQWmNOelZuekV0MVRnRWdNN2p1SDEwemFB?=
 =?utf-8?B?dHZkQ0FOdDdZdzg0d0VTZTdmY3F3bzJtN01EZW0wNDhVSkVqcVNLY2N2MkNZ?=
 =?utf-8?B?TUtPMENWbXN2NlFvYllaaVR6Q3RScnVMR1o4eHErbjFtK2h4OEFlNU5rcW94?=
 =?utf-8?B?bTdiZEFueWI2c1F0clJ1Z2daZWtGVXAra2pWN1ZWNjNlU0lmbkRaS2hlZ0Zt?=
 =?utf-8?B?M0g3QnRaSkFiMlVUYnVKbzR5bFgzSWh6UTRMOVA1OHV4OS9vcXhZU28vTHM3?=
 =?utf-8?B?R3ZSY1AxcGlRcklMdk9oYlpmQ2xjaXJMSUJ1RXVCYk1YNkxzQncwNjA0Z1R0?=
 =?utf-8?B?cTJQUk1zM2FJajNVeTg1aVNRMTZiVUEzZ2JzUUt6VDdjSEcrK0pxZ095Mmh4?=
 =?utf-8?B?S0N1bkJIbFcwaUJnaDlEZndTSEtzYWcxV05rdzZyMkNia1RPcTdGbXN4VHBI?=
 =?utf-8?B?aWxBOWg1VFJaVk1JOXFUdFFaSXBSczA5NFJqdmVqNlNpMDNLeDZ6bWNlSmFO?=
 =?utf-8?B?aXNpdVJFL0cyUUJNZXZNOFZucFZUNUpNYm13c2h1cUxLMHo3Vys5N2QyOWpa?=
 =?utf-8?B?QytxOFZQUGYwMkJOY0lsU0RJMW5xKzBVVENsTFBGV3BSODRoL2lSeldaMi8r?=
 =?utf-8?B?aXZ5MEd5ZW40WUpFWnZaVlBhME9Sb240d2VZQmp2QzVWWGw2anhhbFFKRHE5?=
 =?utf-8?B?OVJCZ1ZUWENoSlpCN0hYUkZJdVdwU0VOTmxHWUlOSlJTTkQ5ZzdzbksydHdU?=
 =?utf-8?B?S2U2NVFhVGFmaGZxbDBTR2p3aTJCS3pNV0FYMnZ5SnA3bXl1UTRhbjlsOVc5?=
 =?utf-8?B?WTdoTFF6cU5DTjM5aTByQUkzQ0tBbCtXVmF4VVJ4a1RZQXM1NkRSYWxsR2xr?=
 =?utf-8?B?RGgyWGZVak5TandVdytkZ1VXODJUdDRwTnpwTnZTekJlZWpUQ3dwc3ZuR2h0?=
 =?utf-8?B?S0xKaU9jRlVSSFlBZ2RSOEcrcHFqUFU4bWFMbXMwd0ZpYWJkWEI3NU5SNmtW?=
 =?utf-8?B?V0NOUU5EU29KUEE5YkUzVml6SzRsNnE1dW1YcDFkNVF0ZkNNalpyVkNnZ1dx?=
 =?utf-8?B?N2xaVnhvUU9QYW00R3hXZzhkZ1BzWGlRUzdLU2t5bXk2T3Y5NXJBRTZiWmRh?=
 =?utf-8?B?VUd6L0Ixa3hhL1ptK1ZFSks5WEJPU212M2VuV2xCeGtXNzU1S0hqdEZlSkd0?=
 =?utf-8?B?azNVWHRTbEFQcW4weXppZDZzQ2wrK3dWTEJya2I5YUlia3kyWkdYNTNtY0NZ?=
 =?utf-8?B?eWtIYTJmUnNyeE9sZFF6QU9HQTFHOG9wbXEyRWc3NDRiczVDd0k5bnJDMjc1?=
 =?utf-8?B?dC9qUUFhODhvb3FBQW13Z2hHWURiSnlYNTJRSGJuZUdyOFIxcGFhRTRoaUNI?=
 =?utf-8?B?YkU4TkxIaXRyMWh1R3dxcnJtU2Ird2VFQVU1aVhQNnc1M2x2c1JVQ0NtbTgx?=
 =?utf-8?Q?BHQx6OpuVckon?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:36:49.4932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91170dfe-8b9c-478e-f9ad-08dc644210fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 47 +++++++++++++++----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 82608df43396..e0f3bff335c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -280,7 +280,7 @@ amdgpu_i2c_lookup(struct amdgpu_device *adev,
 	return NULL;
 }
 
-static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
+static int amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
 				 u8 slave_addr,
 				 u8 addr,
 				 u8 *val)
@@ -305,16 +305,18 @@ static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
 	out_buf[0] = addr;
 	out_buf[1] = 0;
 
-	if (i2c_transfer(&i2c_bus->adapter, msgs, 2) == 2) {
-		*val = in_buf[0];
-		DRM_DEBUG("val = 0x%02x\n", *val);
-	} else {
-		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
-			  addr, *val);
+	if (i2c_transfer(&i2c_bus->adapter, msgs, 2) != 2) {
+		DRM_DEBUG("i2c 0x%02x read failed\n", addr);
+		return -EIO;
 	}
+
+	*val = in_buf[0];
+	DRM_DEBUG("val = 0x%02x\n", *val);
+
+	return 0;
 }
 
-static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
+static int amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
 				 u8 slave_addr,
 				 u8 addr,
 				 u8 val)
@@ -330,9 +332,12 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
 	out_buf[0] = addr;
 	out_buf[1] = val;
 
-	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1)
-		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n",
-			  addr, val);
+	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1) {
+		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n", addr, val);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /* ddc router switching */
@@ -347,16 +352,18 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
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
@@ -376,16 +383,18 @@ amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector
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

