Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277E9CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67E510E588;
	Tue,  4 Nov 2025 08:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a5JN9zpr";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EDD710E55F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 08:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arWSUPew00GNiO6Qtzxv7z99xweVixfd0J8UjZO+QEcB+LjEGbdawUK5UT27MnXUYjZa+yZw0bkL41VZyGKOAtvUd4huTqUmmgFCH75sVR04MlNc5Gc3O+jq/mZMqd9ZEQh15r8+QcR0Xjggap6fBBMH/Rslu4Jrk6W9Te+debM8IN8jXRXA1vV2hsG2UuAS8d8PMdn0U1rSD2k0xpGaJrdcyb5RM+xkiY3EvQFLUvIVFCJaz4Bfk9w+bdCYkbrodXtdhrN492D8nXuELjuObrhlAlRqWWDRD4Pe/CPESggb4IIe5Pib4IOzYAwUhNZtOEt8q35DpnJHQgsZS9+nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPMnQ5Ab9vhXww444T3in2aYz7t3LSmv2pL2xDGUF3A=;
 b=HpMrW0rnZZTr63t18mJF4sCmu5huBjoVwsgG3se2vstH/1gyymN/rq30iWkq6U03ff06DM2pKcjd4zA2K2tW92fuwqDZOD1etA6z468xxBZg1L0G8EEsAGtf2tGbG62eA5bl5F1266izNqQn3ogudtphiiJ/c3YwNnwOT5OChWbTByxW3cUmPNQpcnHGTLKxp5TsTRzHAPnMqfkjhG4VFaQo4bxDyN8lC5D2FVl1PCElivREm8NpzS9ng+mU0XKuoXYXRpGMisvvyhHW4pAshPCpmxYcyesLgyQrxHknVm+SoiWI69rKXdzVls8b+YV0AvwmdmXkSR1x561HazqiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPMnQ5Ab9vhXww444T3in2aYz7t3LSmv2pL2xDGUF3A=;
 b=a5JN9zprCWlov9x94RFFq+S1caQX42X7TnHwJPHwbGwW+sk6VFgnXoR9t/TQFuAzOYrfFtqMxMo2nMZ3BYWOrHiyWiZBI2+K9+qb0aIDe3nCA++ARxPm3XBU7L3jjNP5MgYHoVr/e7X1TOkGMj4ZdRQ9IoUZ3ZrUCBlRdVloT4Y=
Received: from CH0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:610:b2::31)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:47:19 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::29) by CH0PR13CA0056.outlook.office365.com
 (2603:10b6:610:b2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:47:18 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 00:47:12 -0800
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 6/8] drm/amdgpu: get RAS bad page address from MCA address
Date: Tue, 4 Nov 2025 16:46:55 +0800
Message-ID: <20251104084657.1412130-6-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104084657.1412130-1-tao.zhou1@amd.com>
References: <20251104084657.1412130-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: e11bcd9c-55ee-43ea-dc9d-08de1b7ec34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0P+FqUUiqM0HskwfHA/h3PSnR/Wjb0Yoyr3Bvnavwo/B8ItdY7JEPJEU9pAl?=
 =?us-ascii?Q?JGPihxGBVwtwqVbNKKgDw2JnUYgtWcO5FTFIA6+X4BzkyUUmBpGjMCYtPkl/?=
 =?us-ascii?Q?GYW+gCn7pF8SwS2VGCtA0AtGkJ4g5yQNsann1skVZ7R2O7hf1EuGreSWO7gW?=
 =?us-ascii?Q?CXK+3qyF/alkqXgFsAYY7zcEcCHBTI395zdXr24H22X7HKxDUsrALvNobqVD?=
 =?us-ascii?Q?B+DqtB50UuAFlXV68njWA2ccz5i9lu4nN/wCf5K/gIONQEBnF1NlzUGlpE8Q?=
 =?us-ascii?Q?RLDVFOwTKK+xB4YfIEXFYXxFnCLklunUiFfAYRzNLdWhCoNQCWU8kZr18f4e?=
 =?us-ascii?Q?EFm0xX3P9BcLhomicUsNGlEjdYsFmAlHKKJHlAMUZ8Ahnp8FpyxWKwINPfxy?=
 =?us-ascii?Q?gxuU113x6o620Rc0DP2GR6IX7P7Pzm/ksGtR1apICDiyYn8FExrDI5+/kE4+?=
 =?us-ascii?Q?fc05DXWgLW/KABk9sgzcclLEcNPLBvdXkQ7emFr9IRNwiwk3s0VdFCA9Bnce?=
 =?us-ascii?Q?r2+fyl66EZODOUGJKQyhJaRpBOaZl8pwCczmPUvcY17AiIctr7z/qqvG8yDR?=
 =?us-ascii?Q?O/Mal3URJsqG3aUaH2nyZacZsmVN00mdxlM0Bv9hjRoWEQERugKtUB/WBHBo?=
 =?us-ascii?Q?ogExuFsH8xcNRx6MS8PxCH7sAnFCH7G5Hn4EsufgUvDNDe4hUiYmBerii3K1?=
 =?us-ascii?Q?VUsEDogP7uD68Aelp4FHh/iulpjmfjzFQfTLUC1vrsbixLq5BMAThHinsLTJ?=
 =?us-ascii?Q?lhy1w/9gsfhFGx1AITF2fsmDKVyj9cKLiojol3qMwFrLdfM5aGdZ+Ew8LeSM?=
 =?us-ascii?Q?36R7zuEoWCNypalcF4+oHu70BmXDZk+yrmniabv4+JEMWUdTKratd8SIozcK?=
 =?us-ascii?Q?bHHhusrW6jITSOG3yr9YCE4fMnJHflc26tAp8lRnArTfJWmPbgysHQl8czN/?=
 =?us-ascii?Q?Bo6oTaoE3hfT/28S5q6cHFCkfpp1iGj8OJirdhY6II3gHmCARzh8Jmlk480h?=
 =?us-ascii?Q?lgNhdrjKHnQhTa14RE1FIEoc3xaN43Rx9DjpugjCsGEcDXKrwiYlkYN9hNcs?=
 =?us-ascii?Q?AmcgLKUslpOsPkJV9F0gxBKGDRMIVA1KpieM87lowGP3HvNV/8b177XkvDhD?=
 =?us-ascii?Q?P/QbkR+2d56fPn8C9o0zugMXm0sKp6DBFQJZe2uoNKZ3MkPOqCDTFyRMM2l+?=
 =?us-ascii?Q?WgggxZmgNh5IFJhV3kwtAS/zTSsTE4TE22WVnDkMRvyuUHDG5xpmlTSP5jNT?=
 =?us-ascii?Q?1JPdy5IkJJLdla8kI/3XUtRT3T99RFLNZ7n6eu6OccDzPq6PYuuRkFGLf22b?=
 =?us-ascii?Q?GaDQyDgnZvlNni2IEYmDC4X9zjj/FXhyMJHPBBwpjd9x96HTAr08WDzNDi7j?=
 =?us-ascii?Q?5hTuNBJvRBa09r2jXKeGyeji8WrXd22EYWWiOr7F+umbz0grO0yDoklfBI/N?=
 =?us-ascii?Q?jjqn8h9fwE96EAXo7m8iuXnq5WzsAJZj/i3frHkya2wJqkhiuApngZ35Hi0w?=
 =?us-ascii?Q?wJ0EYy3rN+XpT4KLhMDYnlNhublLsZhv7+M0TQoCZ2WFnIB8zUOQ1E8mk2QV?=
 =?us-ascii?Q?0wiqWi/JjYLoHtNhFWM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:47:18.9071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e11bcd9c-55ee-43ea-dc9d-08de1b7ec34c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

Instead of from physical address.

v2: add comment to make the code more readable

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3e372c254bd9..ab9de49c352b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3024,8 +3024,13 @@ static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
 	addr_in.ma.err_addr = bps->address;
 	addr_in.ma.socket_id = socket;
 	addr_in.ma.ch_inst = bps->mem_channel;
-	/* tell RAS TA the node instance is not used */
-	addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	if (!amdgpu_ras_smu_eeprom_supported(adev)) {
+		/* tell RAS TA the node instance is not used */
+		addr_in.ma.node_inst = TA_RAS_INV_NODE;
+	} else {
+		addr_in.ma.umc_inst = bps->mcumc_id;
+		addr_in.ma.node_inst = bps->cu;
+	}
 
 	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
 		ret = adev->umc.ras->convert_ras_err_addr(adev, err_data,
@@ -3172,7 +3177,11 @@ static int __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
 		save_nps = (bps->retired_page >> UMC_NPS_SHIFT) & UMC_NPS_MASK;
 		bps->retired_page &= ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
 	} else {
-		save_nps = nps;
+		/* if pmfw manages eeprom, save_nps is not stored on eeprom,
+		 * we should always convert mca address into physical address,
+		 * make save_nps different from nps
+		 */
+		save_nps = nps + 1;
 	}
 
 	if (save_nps == nps) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 4e6c1d55ce8a..71eb5c2210b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1019,10 +1019,10 @@ int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
 		record[i - rec_idx].retired_page = 0x1ULL;
 		record[i - rec_idx].ts = ts;
 		record[i - rec_idx].err_type = AMDGPU_RAS_EEPROM_ERR_NON_RECOVERABLE;
-		record[i - rec_idx].cu = 0;
 
 		if (adev->umc.ras->mca_ipid_parse)
-			adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+			adev->umc.ras->mca_ipid_parse(adev, ipid,
+				(uint32_t *)&(record[i - rec_idx].cu),
 				(uint32_t *)&(record[i - rec_idx].mem_channel),
 				(uint32_t *)&(record[i - rec_idx].mcumc_id), NULL);
 		else
-- 
2.34.1

