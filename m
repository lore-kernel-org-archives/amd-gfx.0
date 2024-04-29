Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96FCC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B51C810FF22;
	Mon, 29 Apr 2024 14:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRDixknB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D69710F908
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8kONHIh2ZmfbPkhKQlkFOSG3Lu7Pj9aRPFX/EYwCu4/wOvpS3BNg0C1Fg/veQpezOKYYylVLXv1ymQUuXCyukCCzYtIsLsDGqE6nxPi2LQzCL1a8il3uqv8erSosrzWIKzKQTaNkC/gAflHgbmzdBZXPq10QgnqG4DiHNG4ExtEdrlT0SpFssXuK692npcNgsaTqHNUcExX3xvW7wDo798oHDoIIwnqItqqyMEyH6JFc9tUab590nyGoEggj64SIxtupWzAE4T0z/0rZGh1P3g8BtOc9286kKaM7oTkQy2ZxvJB5GaMAZLSAN9cJGIPlHgQu9NRaeo/epLZe5SXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhrqZLXjY6leHUrua6WYpPNd1ay/gO79GFHIhAvV6ss=;
 b=aoDBE89j4X1rleAyohIpgfgaqKBE6vI9RixBPhZkH+ddQZpYPTSxXXcfgkBNrWgwbtCqvS+MvDXlGYaNOWo4PQ+/ydTWBOQ0PIbHRtaW3oEGyiYb9xi3hQU7AezmT6IioaFPSWD5UzIzgpmlBMbrlLKUJwv7wSYCqmRJaEVV08T7VYErJbeAjYhGKtYM0K/zHB6IVu8fKx4ngeYmSZkKdRVEr82x58n8Z4sfP//CRWL5xLdWFBYKZ01x/pW5J/GJQAsNicXDqabuwFO9Ak3afGJNCXW5fZM7FWfcQGXENw3TZHClEaRr3LWdVWzFTPlPhyX2yt1qnTYlHMXgKi95Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhrqZLXjY6leHUrua6WYpPNd1ay/gO79GFHIhAvV6ss=;
 b=LRDixknBa+W97AaxAsuKr4bpsT98gaZeliI9hB3+05L/BX4MR8zK6vfD/XkH9H5b/VdwVGsfuIhg7HEWwmuReyvasJ65TLxXTCPOZvY/fyW39DaebpaAK80CS8TtrfVjm51B1mjXv6NRi1yQKeeF97e/LPrKmzRhDSAxT42tURU=
Received: from BY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:180::32)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:54 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::df) by BY5PR13CA0019.outlook.office365.com
 (2603:10b6:a03:180::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/14] drm/amdkfd: fix support for trap on wave start and end
 for gfx12
Date: Mon, 29 Apr 2024 10:57:21 -0400
Message-ID: <20240429145726.3459450-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429145726.3459450-1-alexander.deucher@amd.com>
References: <20240429145726.3459450-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: e70bf09b-5439-4cb3-a062-08dc685cbfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OzKk8PZPZDCqsPGdTmIW+BTJQZqBRrutWy+JDe3suQ8UYUObuIBgyU71QHIo?=
 =?us-ascii?Q?C8Llb3h2rOgyVfKuwSOX4dALGtGf1rSW92WUrlyld4YJg+EYfrMPrgVrxBd2?=
 =?us-ascii?Q?bdBp9iXYbU3rm6hRj7n3N+n5Hpyozt9VYMqj1M6vTqkNDqdK0q+a6d4Ca5+8?=
 =?us-ascii?Q?b71/Z703Aw758goGbvt9fUunnBTRm/iklTVdIy++xcURQtHm4WBMIiFSAyY7?=
 =?us-ascii?Q?WTBJa1EtHUxKThNDvWMdT5LCd3nioaqA7S7vg21cdzYWwCiFcBk7TEJ7pf8v?=
 =?us-ascii?Q?IJ8LkHZB0ZKCV6okBewwioBUMD6SM2cBrrueptHtgJuGItXUDQeLznB8RB0D?=
 =?us-ascii?Q?t0FcoCOdDXUB2tL7F7ymOZE3/GPnjaRQFIP+XVaxbH7VqkoFC/aVOTYs3qqY?=
 =?us-ascii?Q?LNguPsmz+4uQRfmuRTAiDwvife9Jmrydna+5/tP2XkokMnTtF0bpnF2+zVSK?=
 =?us-ascii?Q?hoL5mUqYCTsS9BAn6rqN56wPW92dsjRxpt7O8wA5yuwN28lMq4UslA1s31uR?=
 =?us-ascii?Q?Vam5sRAtDtfRXqoOn0uHwElh431cgYhVJVeyMpdgrO43DXGAxYS0XRRRc1au?=
 =?us-ascii?Q?ziNHYVO3R8WN9U+dgN20w/3DQRZIMOb0/5Ryit+S+senrp/uvbtClDsMhAci?=
 =?us-ascii?Q?W+NbORs1yG+XFWICyfWnwKbMqyaX2Gff3DKD+a4nB8GraD3JJtaLAJtjUl4R?=
 =?us-ascii?Q?WSXb4vr5fIwFpFyifvtA3pmek6DNatyLmOj7ErqXxB9fEoP8Fa4r8sjbdEoj?=
 =?us-ascii?Q?S+yT2PMhMAXbbaGE34yFzHG64LvvRhC5ZLv3mPOYQEWZinhSZZS0uFyokgXC?=
 =?us-ascii?Q?svWEceCp5Mq2EU9PI+7jn5xFmJxzuNQYR3Z5TIeGsCQ5en5RLD3bw4+7RxY/?=
 =?us-ascii?Q?XPyx3Y5j4KTO0F8Yd7nVNTwtYiSA1SYZWXYks8+e/DSfhu2iB1ve0uiRuakP?=
 =?us-ascii?Q?VnG2KvSTROTG+vx2OGCycnJaZcjjDTijhQXk9DL/oLwzGrpIAgha0utFcsbO?=
 =?us-ascii?Q?EjU3Ob9aeKOSzzvy6SfuIVTMDXsRgzt9Gg/DT5alXACAsEVw4rRgzEbSwtAu?=
 =?us-ascii?Q?Lnr8sk9+L9GO+KhVVuUeuE1YqUqmfWR0DDS3NxVEyaaT9RNfbUm/+r2j7CE7?=
 =?us-ascii?Q?gXsHSiSsS+xui1xGQ2k+7jI7ggpSb4we4fBzi06JPPtuT9FN8LThf2HVHcBk?=
 =?us-ascii?Q?zLOPmF4qnGZCc1+JvzB5MGqZsB4rYS1vER21Cj/vU8EF2sm74DcQbHtrQOK5?=
 =?us-ascii?Q?/dZkXT1tBfbKt0uwJn6yw9ON1/2iEgUkIQ8iSECeyn62dE+juaJp4ioa1+v9?=
 =?us-ascii?Q?1l6KnNxajUls6sotXjIlAslewD7a40AZGFAh83sSfxH2lkhG7u/rrAJByqTx?=
 =?us-ascii?Q?aF/xB+kCRFKj1f3jJH3h2lmdaS9S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:54.2454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e70bf09b-5439-4cb3-a062-08dc685cbfdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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

From: Jonathan Kim <Jonathan.Kim@amd.com>

Similar to GFX11, GFX12 supports trapping on wave start and end.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c    | 48 +++++++++++++++++--
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index efb4bed2d900a..0dfe7093bd8a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -224,7 +224,10 @@ static int kgd_gfx_v12_validate_trap_override_request(struct amdgpu_device *adev
 				KFD_DBG_TRAP_MASK_FP_INEXACT |
 				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
 				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
-				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION;
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
 
 	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
 			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
@@ -233,6 +236,41 @@ static int kgd_gfx_v12_validate_trap_override_request(struct amdgpu_device *adev
 	return 0;
 }
 
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+	uint32_t trap_on_start = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
+	uint32_t trap_on_end = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
+	uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+			KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+			KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+			KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+			KFD_DBG_TRAP_MASK_FP_INEXACT |
+			KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+			KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+	uint32_t ret;
+
+	ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, trap_on_start);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, trap_on_end);
+
+	return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+	uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	return ret;
+}
+
 /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
 static uint32_t kgd_gfx_v12_set_wave_launch_trap_override(struct amdgpu_device *adev,
 					uint32_t vmid,
@@ -245,12 +283,12 @@ static uint32_t kgd_gfx_v12_set_wave_launch_trap_override(struct amdgpu_device *
 {
 	uint32_t data = 0;
 
-	*trap_mask_prev = REG_GET_FIELD(kfd_dbg_trap_cntl_prev, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
-	trap_mask_bits = (trap_mask_bits & trap_mask_request) |
-		(*trap_mask_prev & ~trap_mask_request);
+	*trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+	data = (trap_mask_bits & trap_mask_request) | (*trap_mask_prev & ~trap_mask_request);
+	data = trap_mask_map_sw_to_hw(data);
 
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
-	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, trap_mask_bits);
 	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
 
 	return data;
-- 
2.44.0

