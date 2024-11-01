Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05832E6B27D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D32410E9D1;
	Fri,  1 Nov 2024 13:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mY0i2ap3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE2710E9D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNPYjCHD3ejfIrd129G15IebL+VTf2Zmm+L8+++jEVQ2KlAJIPWkaIeluLWxDHwmKpv61GE5e5tpM9V8ut6atCiG9+LijJsqQtpWzdGVNapqxh2Ye9t5fzECxFcy5balWSzN4Bl3If+vXYj1XixnJau9OVVL7sAJvsliIChBWWGnfg+Rau1rKszefbl0aBCD6W6mAfzv+c0MyocFwCHApj8Vbh3SSwjlEd0tqOgQGkgsEU3f/6lIvB8eYLsh/PlFfi93PuFTzi5Q/4OlV4i5IhfmPoI125jryP+Qxo8i/tEz2valvEDNK9KcLR4ZaHyx5ThxxDWEXvIeGheRqISVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAcD2i2v609fPAq8rcvJWeS0oJrfIHnp2CA4wPb5L+I=;
 b=fmlhpvwRLolR3AFcVL72pYlgZeyzrGq0AipSGi1/fbScsikwGJPZgVs9ksbUj3Ohtnkpe6GRErC5N1aeTe3keHD9+UQ++75nh0QRGkCZ/nAjTFI62mHTtcTbJ41Ajaa+55qj2fgLhjQGK3PytNUY6lWUfFhdc01ZgvfVZfKlkTlP4y+JWc5brKo7quAAvofzuWPtpdJtMxph4ukMn/6Kxt21xYAImoOO6VmeK70XG1tlVorx3cBp0qWhidzM/7KfeIC3c1JNh5nbj5oN5SJx6nGByB8d6226jNLA5JZGBExJmuAN+dXA41eRf4kNRh1Dz80ivtH2ois0zP/LL33EZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAcD2i2v609fPAq8rcvJWeS0oJrfIHnp2CA4wPb5L+I=;
 b=mY0i2ap3qS+e10Li3i+tdi+RW1l/KsD3+yNFZmmf2u5WJor9A00KuKWY4upLvigy57pievV2LSdQZZyPfOhVrnmJmGZwT4l4IbOADPHQqVuOGlDhA1IAcQIRjWKfXlupIjg/75Rjjl2O4or6DS3Yssa6+NbUot2XXOZo/F6M9mc=
Received: from BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Fri, 1 Nov
 2024 13:50:25 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::16) by BN9PR03CA0067.outlook.office365.com
 (2603:10b6:408:fc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:25 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:22 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 14/17] drm/amd/display: [FW Promotion] Release 0.0.241.0
Date: Fri, 1 Nov 2024 09:49:37 -0400
Message-ID: <20241101134940.1426653-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed7ee9c-2255-47c3-0021-08dcfa7c2325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wJXHuZaL7EwfCeHQMFxny1xUs080LZIjNXzzNy9si2xl4daopeIATQNMWTbE?=
 =?us-ascii?Q?kGamO6r6tRMeEePHm3QH6qsh8yk0JSubN+WYtspk35nQiiqwEJIOXh4MJGDY?=
 =?us-ascii?Q?qO4zaQ11NYySlb2E98zqqPDg4CrvO8bO18Xifxh6kfTB7U64sPVPk2eq2v1m?=
 =?us-ascii?Q?JSs//j7464fFdm3IMvI9ThOMaWjTlpaj/DyXC58/MCd+iMemH8+D98xZltgK?=
 =?us-ascii?Q?SWO42McAAmYaXIovwPt7Vb2yZ6puJkM6b2RsPMXAjMbM5V6WUvkhWIL962kf?=
 =?us-ascii?Q?NPH0l+B+Q0I18xcxErDQ9Hg+o4RZLdUy1+JjLVbuY+patRCEsJmX47e30a4t?=
 =?us-ascii?Q?cLFmIyNRdQSLJQfTfLQLielfXiasSs4m7/ix39nvj5dZ/Rqb/ERkQfR+Zd+E?=
 =?us-ascii?Q?jxhZU51TabX90MFFFzWKljPUiNFfOHbJ1g0Clnyoym+psj11L6qfYVXJK+y3?=
 =?us-ascii?Q?vJXwXZwcnn2vjd1x3i9wnDQX5O6ux9HsMF2KysN+cpvaPlQ8O8bTiEIU0qkT?=
 =?us-ascii?Q?In2zznCziZrgrrCYfOG2k5rFfZmFG6MKFkSsoj+OSr647NuXXcaRmQzIW7FA?=
 =?us-ascii?Q?XC2FQg35Sdrjahq+ke9S+IIBjVEkPEKv26QtK7hFCv59zbg5UkWjWuwzrUWd?=
 =?us-ascii?Q?Q+4ZZQQQF/dCZGXqn/3cZv7b32zZHFQ5hDaNWWPAzKwBnPruY/3TnBMhHotd?=
 =?us-ascii?Q?C5qOfLVthow1Dhv86peDR5F/YhZ5o51X1r4JpZP4yEoIB9UYxL68Vl2fRPjw?=
 =?us-ascii?Q?9wycYWp4TmQ7N2fbu+on3ry8RoQhc2qSCqpCc7qdQGe0Vhctu0UWtMrqsZeu?=
 =?us-ascii?Q?EQeONVXIftaQxWLJikoKzKwtI5015hoWWqLoA0GNZS2VDtV7cAxADZPP7k3C?=
 =?us-ascii?Q?eSHMn3UZVUZLf1vWAiO4lvAr7b/RDNyBRXuZaIaoOuTF348Ol5m+gaKJk5+9?=
 =?us-ascii?Q?BzNmBCzhxLSoIpgyi3f/ZnRBJW0uaghf2tkpTqUF9NhTg1OGz9JfGcPjO9Uy?=
 =?us-ascii?Q?JM5bIHozEwh3Oj8R+2yDg8F9UgYolHIK4QO7+NxL4qyzPWQjbJjqHtKf4aij?=
 =?us-ascii?Q?3+P0hozbdu2yINulAeXnpXWCNQRLz9OxpP9aSciq6KoH+Pi2z2/ZGbPjWOM/?=
 =?us-ascii?Q?lB25uLwaAN5Aq8zn6XORiKCadbHW4E3gxxKOIs9O1XlPT1EPBWLU62+kcwWD?=
 =?us-ascii?Q?cH6ZgdBRei0PXcjyIQGr1zgTfLkJhN/KvEN849hTZlXoN5/LO3ldQK36v/Gl?=
 =?us-ascii?Q?DoAVQrrzqSZ8lfZXjIwTEZoGd4v7bl9bLr70LAmWPfbvMoiuOpZ01okf/Nya?=
 =?us-ascii?Q?dh8LUewUu2YC79h/LM6fuln2Z3PskqcZMFy5gdPaP3DVD7iNzU+g5XPLsy85?=
 =?us-ascii?Q?0iKStmCSR3opjojkVPJ9EGrcssozPDnJLbYpNO6cAKh9Hs8F2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:25.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed7ee9c-2255-47c3-0021-08dcfa7c2325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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

From: Taimur Hassan <Syed.Hassan@amd.com>

- Add DPCS health check
- Update USB4 PHY SSC
- Fix FAMS2 SubVP Close to VBlank changes
- Create VESA Aux-based backlight control path
- Fix PSR1 CRC error during CTS test

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3aa6c60588b5..a9b90fa00b88 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -495,6 +495,7 @@ struct dmub_feature_caps {
 	uint8_t gecc_enable;
 	uint8_t replay_supported;
 	uint8_t replay_reserved[3];
+	uint8_t abm_aux_backlight_support;
 };
 
 struct dmub_visual_confirm_color {
@@ -754,7 +755,7 @@ union dmub_shared_state_ips_driver_signals {
 		uint32_t allow_ips1 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_ips2 : 1; /**< 1 is IPS1 is allowed */
 		uint32_t allow_z10 : 1; /**< 1 if Z10 is allowed */
-		uint32_t allow_idle : 1; /**< 1 if driver is allowing idle */
+		uint32_t allow_idle: 1; /**< 1 if driver is allowing idle */
 		uint32_t reserved_bits : 27; /**< Reversed bits */
 	} bits;
 	uint32_t all;
@@ -4460,9 +4461,9 @@ struct dmub_cmd_abm_set_backlight_data {
 	uint8_t backlight_control_type;
 
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * AUX HW instance.
 	 */
-	uint8_t pad[1];
+	uint8_t aux_inst;
 
 	/**
 	 * Minimum luminance in nits.
-- 
2.34.1

