Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12153CCF9F8
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 15:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F4710E931;
	Thu,  6 Nov 2025 15:34:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C//HUTeo";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B712410E92E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 15:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egBlmCoCW4DbLbw4VLAUoOfXC8kiZl2tpvFPtpHn/7WTZimpSM5MXX4hr77ZsAh7AbBDwgD1i4mnN5iqXrjsTCO0V6IzhyZUYrG0RZttKiP5uHfc3ccQn1e64VGhQKgHEPZbxhsuK2FZ41p06obyM6A+jYBoStELkV0RqZR4MAOwE2W8RHjevNBkSl+ygOcDjC801/oeclgktFOmGbGMa+D+aXGUWY0I6bQNReCzB8VEu0mnxl5nw7pHwR0lTD+sPp6TLzlJ/MpWb07cyiaOLAUW7KVpPpaRomfu7aJfMKAQionoyhR0ttbgV2c+SYBiQf+TEjhGD4PKuVaKMNKkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JnrTZy/1USllXtbKGoKlps8TTS+7l+Sl0xMB2T/Sn8=;
 b=P2JvQrGpAoH1RlaF8368kv9fmoPOg+LV18OLoRBVeAPclwcyoF7bLkM57DbD8RFmI/J4umNdw/2oXgJ98SYG9HEmzj8oh4T73QtNbmv46ovDEK3C+Yud+wGgDZXpspZXn7i8BcGkyTPe3JjJcJYoWICYrrqUro80Gp9VzWjldSiTLRZGdg1febfrA3vFUd/yodBE4VNvDxmWBCsMYODFiA03W4/eQRhTUQlIcBhnRE26SpecuuQHu32xhQn6u+9JX1BSA/PGJtO+fqw8i/lEAj/XAKwUZDZlMBorGkph8kQwL1EwL0pJeXCQfTxMS8ut9L66VyN/L3M3mhS2B/Cuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JnrTZy/1USllXtbKGoKlps8TTS+7l+Sl0xMB2T/Sn8=;
 b=C//HUTeoAG1YVzjjBtfDMaDkTRiIMMKK/SmM2APHUAgwTrDypIduKx2cZA2bFTsdEjIo64mClAHxHLVMAnOGIHDzeOwXGmkW2S2g0YXYVi2SYNeWLAiNqe1yLdFIG9A402lD83isjSNX3D7GtqbwvbD7hcYWexpv9ndO3c0XjkE=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by CY8PR12MB7148.namprd12.prod.outlook.com (2603:10b6:930:5c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 15:34:11 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::a7) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 15:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 15:34:10 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 07:34:08 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v3 4/4] drm/amd/pm: Enable ppt1 caps for smu_v13_0_12
Date: Thu, 6 Nov 2025 23:33:28 +0800
Message-ID: <20251106153328.3783505-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251106153328.3783505-1-asad.kamal@amd.com>
References: <20251106153328.3783505-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY8PR12MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e2219a-1234-471a-1f13-08de1d49eeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SL7JzIsVb6dUWjQRENxQ3XpfZ/02N4c26TlO8M3ASExJrpkD2Ru2FmMDF/7f?=
 =?us-ascii?Q?Xhvv0rhPsLJVk0dTp5hfR/WOd3FwO/MI4aX96733amzPnm3WxwayNYT5Cd/2?=
 =?us-ascii?Q?4+wrHSuH6HejsbEbH+eLYJQ/CeDoVuHSN2+RnEFD2wiC5zIyultKzzacUwm5?=
 =?us-ascii?Q?OCmkz3g+AHcMRP+lg8W/Ws/UrKTmI8KzLvdVgcUYc2+eRweGAP5FRp2XtA4d?=
 =?us-ascii?Q?pwfGYabZRsX160GrkCNjLtCwaitWZX6p2pH3vSkUp/SMmaVuGpx+DI5kVygh?=
 =?us-ascii?Q?e250YIGiiDyIlemXOuvZ0SEFNyPGR+1sbkkgRCDiSIG6oqW6+oRyrniVbxgF?=
 =?us-ascii?Q?/je8RLmf9l3fAKSBxlTEIuUs+c/GMC/dK0nOwZpy2PV1XgpoMvqcd6p2o8p2?=
 =?us-ascii?Q?nNFzLYot7oIjjKbTdin76g7pldzWtOkQc9bgcQ3bP9kUCgjhngQfrtPiCTD4?=
 =?us-ascii?Q?sRZYkDzZDFcFwMFJXaNEz7kEEY3OTBrm7gX2kn1HjHsRkWqP9P3wR4tnv6kL?=
 =?us-ascii?Q?ffPXEYvSiInEHo7Xnfc1dTNN0orhXbXg9VRjbZ2yOz9e12t0qSwj/T1bjsxq?=
 =?us-ascii?Q?4EDtRajGZlpHrCtbS50VrPj1iDdRJKtWkVbBqNvPkIIskcq6M+SG5tuHcOi7?=
 =?us-ascii?Q?VppWoLuN4wyTjH7PksPBMA9RmO/TgTBsg2kza9CcpLM5NkFkWq6VQY1+qg8e?=
 =?us-ascii?Q?gSSYA6gC8AAEb7kN2nm2SI7LJrvNA8aPTl+A6OvwQeFtjjkw84c1zI5YJ7Xz?=
 =?us-ascii?Q?YKxxXXXvoOcmp5FZxwhUyMisriynH6RZee152fQr7quoN2O6kf79gRBBUacs?=
 =?us-ascii?Q?gzonzc0kzP405Gstc6SddXpYLtw3sV7UryQBBgZhoi2LA+WpH84lCU5UJMic?=
 =?us-ascii?Q?PntfLGsGc4cmP7XY5ubiM0mBqmJdJboh4hYqVnvc0Kuto1k8Add6okbZ4D9y?=
 =?us-ascii?Q?QYa7bI0n747g0u/7OKZ8xsi3vLOfr+Ip+Ez6aDhXnNdVWnZKu8Tlz9+35yVd?=
 =?us-ascii?Q?JkXYvGUBvRZU1E46VnZHNiVNskoqondbmDpUjhuaiI8HgxN1MiiOxkc9jJfW?=
 =?us-ascii?Q?22T+3Yce5Yph7UQuKEPoL4RfdWMeskhRWOBiIduicM3VwMHX0NXSZ1D2Kzun?=
 =?us-ascii?Q?Q98LebhI/N/L7msNzhFC0Hfel1GZiAUR0bscYQ/48253hth1gOVk+aQdux1n?=
 =?us-ascii?Q?aTNo7bUhOKCGU3fCZ57oyBJ5H3QV+pSBim3x4DwclpFtf2miU4NxjkeDYdYa?=
 =?us-ascii?Q?SpqjtJ4lKtFItXsbDeXhkbnYi0x5x4dmXU5yFVrb+T4JNEpHBuegPAmWQVtb?=
 =?us-ascii?Q?Kfj4tKrhgi0AQ2HfNOTjJ3WVzSfMSjBk5f+WmmmVJq29/P3jngM8vjvFYMX8?=
 =?us-ascii?Q?r7sxpOb+BU7LfOCDnYUfWwAT+oYzAwq9N5qgFsL9I8HdOCmZNE3nhAJ2vX8Q?=
 =?us-ascii?Q?NOF6Ue/xRkNXGB8NH/KSpaCTh+8zcrVUreudDrNw4Fe+wcrFlpjdTTVKLmY8?=
 =?us-ascii?Q?S9lh5Eqphxf8yQo3sGY728FreXUPexmOmz3xRDTfUgwUB1tPjaGJBJXvc2kC?=
 =?us-ascii?Q?8nIrXMerm4vXjXc+sqw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 15:34:10.7251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e2219a-1234-471a-1f13-08de1d49eeb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7148
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

Enable ppt1 caps to fetch and configure ppt1 for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f9e04df7e472..44e1cd821eec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,6 +356,9 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver > 0x04560900)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 
+	if (fw_ver >= 0x04560D00)
+		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
+
 	if (fw_ver >= 0x04560700) {
 		if (fw_ver >= 0x04560900) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
-- 
2.46.0

