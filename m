Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56393D591AA
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 17:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC10010E270;
	Mon, 18 Nov 2024 17:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LM/LcTPK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB5510E270
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 17:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpl8HHQZyLGctb0Yhq1AWlyR4AW6KSJEdilnaO+bx+c8VTaeZMUae7s+P8s/8RTV0ME9AssWUpacxU4OdziiqfhBuCvmbA07APotGsOKxj+amw/opWz63WCpq5PZIVhv/ByvVB/jq+VkxvkdZfcdn8/X8o+mhDVit3o7wh9oe8xAMTLXeSAF3y5qyOJ3ab0X5/4ksByjYHfWiwuwLPi08jJj2VnoiAayRLRimL5J4bET/1TKXCA6/muxk6ltFS4YAjzccyfsbKsmqNz6q1Dw3beQNE4j3ohW5c8cScOzTHKDv1PpqwKjkdlTFOGqK4bGWBnj5QPN4cx/A31eQzqyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6Vpuoy0BwB0U6Y5cLyZXDSZyjvw1JVSL+sFxhnV05I=;
 b=un9STmPrT9xW/0KdgUpo3JTcXGaf1QXNJc6Ls7s+Q2eOSR7Iut57Q045HfjrqkWBICpUnC/MMzAbWotMyXCbhdwon0T212qbuJ9qLfOsz2LCiQC13Gwp4yguC+VzA2rFpy2KMgxcFCHBfRl18fx14toOZ8qhKtKGioEGN20MvbnwcGPFc2cCS+KNoj2XdE2h7PlPcsvl/HKIdqK+5Uf2mexvilwIMtuvdm1ObTQ9HDYSHR7TWqdVrpgn1PIqNiMfm7fkucOrlzKESdJUtOYECWX8yLKJHfwiCZ9saURg7P0JyqnjQPdy7HUQXoHHDjWzmG53wNhChVPBQilx5Bkklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6Vpuoy0BwB0U6Y5cLyZXDSZyjvw1JVSL+sFxhnV05I=;
 b=LM/LcTPKJH4WgwlGcFwnTrR2+hHJ7wWTZtj7SKYJ8HgoEBtCprnzsIQaNj1/LFJSjnJn3h+pWecmdQ479vUc8Jk6OuCwXzT85LlCBvV0CwVvNNv5T7Eta0EQuTlgLWFBORq/HvNHRN5q7PZqpH+z0Q/83GwB9eUs2EOdvHHHyTY=
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 17:46:28 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::95) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 17:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 17:46:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 11:46:27 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] drm/amd: Add some missing straps from NBIO 7.11.0
Date: Mon, 18 Nov 2024 11:46:10 -0600
Message-ID: <20241118174611.10700-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DM6PR12MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: d22ddd37-f31f-46d6-242f-08dd07f8ee03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLqhi6oEp/+vm2DcOdMG+jfJMq+GIehyA+EenuqaH/dN7Dn+Lz5Ta1q2MmfB?=
 =?us-ascii?Q?OxgxZ/3IN44GyTXHLzx+LhL7kkQnK4VRPq7x/mG7FfdgIo/8s/UCygbOscuk?=
 =?us-ascii?Q?SytJdgue3/S9vsRdGAOFgpN6f/H1K+9x0bg3ZI3y7KJ8Ie8AO7BdzSSSvyJ6?=
 =?us-ascii?Q?vueTR1Gf0GJ8COfvpl5hJwh1TkQN3dK2D51NivFMzvOmIUmCAO7nn7xD1bP8?=
 =?us-ascii?Q?hPlLyiMsZHyJbyODCuzl+me7n+BWAlkqJUmlMh/FrL8Z2+haYj5jLgsp8ant?=
 =?us-ascii?Q?ClKXSoePg0zjnqykCnDGt45yvoKue/iGKBqccNeW8sMEOliuh7KXJ6SUf+Ty?=
 =?us-ascii?Q?QfFYnz05M2uK397NrPmc7U0qZ/2kcNq+aWIFFGBx7UPittskuvf5SOIIMN1+?=
 =?us-ascii?Q?Fb/c1xABW4lBugvEXAFcBQ0ZeKH9KvwvBudsoupsQCoi3TzLmtcuV+BoeNB3?=
 =?us-ascii?Q?+CNOES1WzGWsG+gOfCsnmdwl6EtOja4vdXnqYi/GRSuKp/vo2cSjix4TS/CW?=
 =?us-ascii?Q?6K17G8qYrEQRRkmy9O4Ocg6MTmD/a/7t6iipA0O0esiVuF5ibCQueMjHv1Un?=
 =?us-ascii?Q?aSu3Q4UVese3B7CMycwe6V0bUQhM2C57gVsUGCA6LkBrgrvFL+mph/Am7SkG?=
 =?us-ascii?Q?FVCFbu8QuPrzCPM+zJCQIXSfj1TdQe3ieqUIBafWULHu0+XHZFzl4HuWc6FI?=
 =?us-ascii?Q?91DQ2JBdbt8ZizEK68qzUud5sE1JYB1I6yn5Tev+QJ+wZd6fYsegvOx6f626?=
 =?us-ascii?Q?qdAgHEJG1ixnBv+Q5KKOHfj5bW7oXpePbfcjwM4jtie/9dfKGONP6WpQPz//?=
 =?us-ascii?Q?hqwvqWiBMp0dLSRZJjHuUyKtSjplj+r+52Cnq9RapwJC3DXRuCvRbL3JFxSn?=
 =?us-ascii?Q?bNpF4CkaF4l9nCu22LpzZQE8LDbHoOImrTeStfhmAeY+0QZeG7OOkV5DhCM0?=
 =?us-ascii?Q?Gw2PcsshJgbh4gXf3DUdw+pmqZJmYzTsskvO1dHNmaaVxWfyyvITRFhXhMrN?=
 =?us-ascii?Q?8C4OzAYDMiY3BGZQakKReo7cFNRc/JEpXY2b92t9uE7MX5IC4rSmAEpT2diE?=
 =?us-ascii?Q?oag57zQYi74o/95TaWt8usomJ8z3auwzalKodGZ1n9wA680kVolkfuryfdmv?=
 =?us-ascii?Q?Owpj9BBVoi4tEtZfx3mu+itr66sTEeVMu+VVJrTDhLLd05YR17zUk8tD5Bkd?=
 =?us-ascii?Q?8cJWutMro7lqwEVj95UxVgJ6jx2ZEDPMALWcBpIrMhoT85NJGqcKgYx5dVdj?=
 =?us-ascii?Q?LaiG+z+1adpjGIyBGEfgrtxWA7XbXpa9xXCKyEaHNPO6ZlljGnicHuph/ohE?=
 =?us-ascii?Q?At+u6vlQxsmYtpvAGwWcFhwrOlRyWjPCq43QgjLGmojXWWyD+RKvVSsvCS9T?=
 =?us-ascii?Q?t5AMNcZqsdXE1QbMjCsJnHW54AJv5UyzgQDqLVzUoVdYgfIytA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:46:28.1851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22ddd37-f31f-46d6-242f-08dd07f8ee03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
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

Earlier ASICs have strap information exported, and this is missing
for NBIO 7.11.0.

Fixes: ca8c68142ad81 ("drm/amdgpu: add nbio 7.11 registers")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../amd/include/asic_reg/nbio/nbio_7_11_0_offset.h  |  2 ++
 .../amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index 5ebe4cb40f9d..c38a01742d6f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -7571,6 +7571,8 @@
 // base address: 0x10100000
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0                                                              0xd000
 #define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_BASE_IDX                                                     5
+#define regRCC_DEV0_EPF5_STRAP4                                                                         0xd284
+#define regRCC_DEV0_EPF5_STRAP4_BASE_IDX                                                                5
 
 
 // addressBlock: nbio_nbif0_bif_rst_bif_rst_regblk
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
index eb8c556d9c93..3b96f1e5a180 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_sh_mask.h
@@ -50665,6 +50665,19 @@
 #define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D1_SUPPORT_DEV0_F0_MASK                                        0x40000000L
 #define RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_D2_SUPPORT_DEV0_F0_MASK                                        0x80000000L
 
+//RCC_DEV0_EPF5_STRAP4
+#define RCC_DEV0_EPF5_STRAP4__STRAP_ATOMIC_64BIT_EN_DEV0_F5__SHIFT                                            0x14
+#define RCC_DEV0_EPF5_STRAP4__STRAP_ATOMIC_EN_DEV0_F5__SHIFT                                                  0x15
+#define RCC_DEV0_EPF5_STRAP4__STRAP_FLR_EN_DEV0_F5__SHIFT                                                     0x16
+#define RCC_DEV0_EPF5_STRAP4__STRAP_PME_SUPPORT_DEV0_F5__SHIFT                                                0x17
+#define RCC_DEV0_EPF5_STRAP4__STRAP_INTERRUPT_PIN_DEV0_F5__SHIFT                                              0x1c
+#define RCC_DEV0_EPF5_STRAP4__STRAP_AUXPWR_SUPPORT_DEV0_F5__SHIFT                                             0x1f
+#define RCC_DEV0_EPF5_STRAP4__STRAP_ATOMIC_64BIT_EN_DEV0_F5_MASK                                              0x00100000L
+#define RCC_DEV0_EPF5_STRAP4__STRAP_ATOMIC_EN_DEV0_F5_MASK                                                    0x00200000L
+#define RCC_DEV0_EPF5_STRAP4__STRAP_FLR_EN_DEV0_F5_MASK                                                       0x00400000L
+#define RCC_DEV0_EPF5_STRAP4__STRAP_PME_SUPPORT_DEV0_F5_MASK                                                  0x0F800000L
+#define RCC_DEV0_EPF5_STRAP4__STRAP_INTERRUPT_PIN_DEV0_F5_MASK                                                0x70000000L
+#define RCC_DEV0_EPF5_STRAP4__STRAP_AUXPWR_SUPPORT_DEV0_F5_MASK                                               0x80000000L
 
 // addressBlock: nbio_nbif0_bif_rst_bif_rst_regblk
 //HARD_RST_CTRL
-- 
2.34.1

