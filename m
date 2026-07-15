Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F0CC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7F510E198;
	Wed, 15 Jul 2026 13:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isehLsRh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012023.outbound.protection.outlook.com
 [40.107.200.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEE0410E198
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/ykycR4RiE/XXdk8xp0HbkENtWyPnypFWSV5mmXSbL/MyCc1XABBFD3QwIjsb8fpp7+THUYwJjCvZgarKpdRudYn3YdzTtYUtYQyhMxTegMfc+kva51zoxVlt2QrS304ST0MDvmJeojha/ojZpQ+uHfOLQM71Lgnnqg1e9lEVO5af1Tjxlb0ulmteA/hP13BmZJFeC7M7GpYYlAgxKoDNft4iryuhRvGfa0z/7yDw8LHZ7K6Iawf5S9g6u6aMx2OOrcFCliioZ/TOfc0iOrN0uqJY8QOrZVWWe21lBTTTionKSd76yUByqIQpt2KJtOUuIaC6hqYUl7AGIrQM6Ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRtGeJCeBSfAwro2cPjS9mudVw0pbVa8pTbzNsvD1zA=;
 b=Ra0EvuZJ7bpVz3E6e3mVZIfNfVwNsKeRk/+YNFjdSSCfkuZo0VgsBqYqGjr85Tfm9bz7dF7yclPnl01utBkxCWSYcVGkRYsaz2Zoc2T0MySEMG7aZpjAMp23XrMMYh2iygJXhrfvoi8xfkBupln8wyXGoQMy6t8X3uK+HLJGf07Ht+fU3n7qPaxqmNLXdKvA5+K4SAA4iExW62hwMbmknsgBVvDH1rqGu+SvE86NnwBhvnQj3iYx6ovF7znKLfmezwP39sF8BBPn4STO3ye0F8mT3nJN6HWZujtT/jaeZYfBtuADKmzefdymEQe+T40ieVeqrIDEuZT7NzSix2mEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRtGeJCeBSfAwro2cPjS9mudVw0pbVa8pTbzNsvD1zA=;
 b=isehLsRhvOWHJoLeYx/WEVDK/lXZ/vUbU3mBb8lOa144HJ/VTuJzdRarmfP0iX7piYoHuWyH10+fS84vLI+w7fpuUYlNl/AY0AtSkyAQ2Orxj0Ark5boQOqDaHaYrmI5QbzVyyGhetmyfwcP5jQrKY42N666XBMsfuIJXxybFXo=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by PH0PR12MB8175.namprd12.prod.outlook.com (2603:10b6:510:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:55:38 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::49) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:55:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:55:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: Prefer default discovery offset
Date: Wed, 15 Jul 2026 19:25:18 +0530
Message-ID: <20260715135518.3947786-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH0PR12MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fea709-67cf-4577-3529-08dee278c013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|13003099007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6OnNDzqCzKHpFcViOVrDIUFwzaUfRuk6iqK3omfv7b7mhJOf9f4C0N8vF3v58plafztxtVesZAbGF8ydRJU+2hxrIv9/bHbvQaC6kOt2lBuWkk4IaZSFyTawrDwCBLj9VclKCzucCOlol2eAidmzv/hz3+wzyb+Ju/afQc8YEc9ns4UBLNrzJO8FLUy0n6f/xyaYl3y7VYU8Lhigt5thLstzYYSfgN00YLu+MMHK+5qW7KPn0wQsjY8e4xowSTSbG5LUjUf25EzBFiPbfUCBLO+kh0Z4GlGQem/V2CjuwVFUDag6RG9ZSPP1S8Wtqk2j1qLbA1I21Y39NXaglhokgLShGrlntFQwqhcrhr3vLy3qmmMQO0kiZx8jlNwdkpgUOh+7hL/H6x8tY2zMCR9BphJRvqPZY/5kkH+4/ZJanVJUkgL96jq0VrlWTUL6FmaeS3FoCNeu1CUHjf6Vn3z+r0DrILx64PiEIs+TmHTfB8dwEaFQtH0KR7yOIc+a0x2Ta12fREahXhZaR39TdykyeOzP8RoG3VuGKdEaSIqAApaCvXopsY3FqlrAmDSVLW0ZQcDPbuO3qrBdSr5DIteZi3anetJB71GJNLwQzLyuJ2R7MoGzOMs43Cy50f2LPwArMqpkBGX8Q7MpHGYUtELIOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(13003099007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a85MBnK/I7Sf4DtMkU+pQQcGAsW7Bi0wEpcTy57Fhq59l8l5Mzwbl7M9eHl1xD1JxU77XXwVtQT1rLQinjnQNBXZFI23FroZ5UAETmaEw2d4y5MQ+BpYlUHa7r7MxCZik/5dClXSezA7zfqmJxBHNe3nLW9N4sI0Q2kkj5lCB4HtwClpmXOW9HDRuZwWvLTwGoTNaw2CHT4EDKjzUIoiYjb3re5ABW2hBrCDFJAzqzbCIjAoBsd/0i/eIWonX6fYH71QcA//KP2mZ5zp0OYQvLzzx9am/XUYzcoWN+Gw/D11RpUuxm2DnLCmB51R7pOHuDeeakDZAG0L6CIpdEJkojubNWcJ51Kfjvk9jrJYvsXr3/iZPjJtjLOEBoudXgLSYmAHziphdmqtQiHV7IEezIKxkhcdG1yrJKoCWZrT2uY76jGHvq4GQmKrj0osqOqK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:55:37.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fea709-67cf-4577-3529-08dee278c013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8175
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

If a valid signature is seen at the default offset, use the default
size/offset for discovery.

Fixes: 01bdc7e219c4 ("drm/amdgpu: New interface to get IP discovery binary v3")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5447

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 44e7d2e3e6df..186661c94d8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -334,6 +334,19 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 			goto out;
 		}
 	} else {
+		if (adev->discovery.offset) {
+			u32 signature;
+
+			/* If VRAM holds a valid discovery signature at the default
+			 * discovery offset, use it as-is.
+			 */
+			amdgpu_device_vram_access(adev, adev->discovery.offset,
+						  &signature, sizeof(signature),
+						  false);
+			if (le32_to_cpu(signature) == BINARY_SIGNATURE)
+				goto out;
+		}
+
 		tmr_size = RREG32(mmDRIVER_SCRATCH_2);
 		if (tmr_size) {
 			/* It's preferred to transition to PSP mailbox reg interface
-- 
2.49.0

