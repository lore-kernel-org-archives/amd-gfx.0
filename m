Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880AF506CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 05:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D694E10E012;
	Tue, 17 Mar 2026 05:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eI90A1+I";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122BB10E012
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 05:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTI/WNu0DUW0Jd4xlzUgch+01yxFitUR1hsTrCoNnvPkirEEOlWEfQcraqNcuKP9sHgUBpNRPmgyz5HnWgAF5uqz77kZ2uPCwdXbRpjSlUe0MbPgQ0aPE7+HgVRJQcCU/ByM6CUm4MnsRnox8Z27O+1gylL4Soky/Kv+2hBXTp/5lrAAiNN9OfLZHEyc847zjoRDCNXyZgI5XdMqhjuRUmANe5oE7scE4Rpm1WhMGxzyaCJF1Bp2fC0b34wMjt6ikvrT9255GfLo2ADaoCVzrxNSQPwBg+QNH17N1snwIm18841tHHogd7j8e7jRErUmHi3ViQx0lHsEDwVz32e4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYRpJiWVBECWV3ZOZQnA4LFNmhN/q8qnNHv7UVEM82s=;
 b=nSTFd2kP46yHQg3VhmPNsc3JL2HgZ3IwHWsvDBl6tjJ1t1LEy3oL+8PkZ5rvvmvvLHHgRvCil4Fo5Cn4KtcnTHirixQzG/7nOd6eOtHKLqpyhrnQC/KjIGlJDyJQyWfdZ1GxPX9/KAcKKAJmgpkOdYTSaEjZonQquPcix6O6nqDjdQkWFItwvz8nsVQakcj2enWpoDemWy9XQRSaz7UFiRU8bKkEbdvRLLQkF37qD6GFfRmxala97yUPnc+HDfXVky3MiS3rTRrC7ShXxN+xInHmrOaLjhfNY+iGG/mWI82WDHch1JVWzskrXlKhneMrOrIFxVqyW4f80z1FUoMIuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYRpJiWVBECWV3ZOZQnA4LFNmhN/q8qnNHv7UVEM82s=;
 b=eI90A1+IBaJSM5CusDV2ZVhFrg60CwdMnwmjeUUfGQ6ZdDZc7UOTD+DDqjkrwXr/LPI9ARj2HtiPdxivQdx6OM2idncJnSOg7J/PMmgfsTrkYRpa0loYdRPp/uhmcFo0TS1E5ZbGNC4VTbLc4rDx6sOiB07GXpJcDPP9oHLP1uU=
Received: from BN0PR04CA0166.namprd04.prod.outlook.com (2603:10b6:408:eb::21)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 05:35:27 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::2c) by BN0PR04CA0166.outlook.office365.com
 (2603:10b6:408:eb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 05:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 05:35:26 +0000
Received: from BLRMANGADRE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 00:35:24 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu : Update psp 13_0_15 ip block support
Date: Tue, 17 Mar 2026 05:35:04 +0000
Message-ID: <20260317053504.708689-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2374c1fa-91ce-4999-c9e5-08de83e6fe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NXX5hJ2cEgqERa6cjUk6tUziX9rMR1AY0PZig4FdT3X6XgpNTiBQ3n8f3Bn50kwf+uo9VZEtYBxeYSmZ6E7dbXXR/5hut5BKJh5WK67gvoO+Vyq1X1MacYUXYLD04abEuSGeLFQ/6ihOsXpcTkJretYlbrA6yB7VjUXfQ82Xprh0Vl8xKf0t2Tyk2wvm/KV6YAf02ty3XYKvSDDuUF38kIctpWv4D4ScWBk3GIeKy1LCGFeMWuVFHhZJHzzXMJactspmsS+wctJRGMtXYPwaTnUUHv+nYuNOQg0ZLBiqHEfnS0s5Ra2vxRwYAYHPARTUzdQBXQuzx7qQ+V0ra+vMPeKxPQsxcSkmJMAxwH9Klj7ks2RcP11K65onm+AvbaRef9FthxtaO8BnZj5tNjJ3UUS1ktLoyyfkQJa4dzRx5+GGgmQUYK9vd6SeDPnw/tPGrBpoIhCPIj1TK48YalVJ9bf4SEUAdDny7We8/6vFEBe7SJ8ec5zVixHYej1rXWDeS9HUJPpZLVl9hY46EQ9qoAOpFp8GMisrfs0yEmprsCTiGkzMy2qVXIefBwmmn7Gz9Otdd+IozhWQQVKXzvFRLa33jlq0S4G/9zkMwvVoog0dWEYYVRYakOCdTTw2K//hmbDJWKo59r66b01XAjbcucniZgrLXrHZKlCAK1cbVjuxA1vErBUu6WITNbe3oryPXLofDk0yDMzz/M49FMrvn9n5EsEZyS028PEUgls7ZVbyImjnaFJS/z3zyGUc0XtZ1DiMs1BnT8OpEB0/f0h6Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m4OFNvWEj98DO86SbpUzdk/njl62tf2qOZ1ZxCtVoyX3RiVt7sJTEnRsNLPiu5+VzABG9AAVDxPf2k1xanhtlfTKsZIkYb9yeDsqFViI4/+muFtXFkZen1uRrP4Uq7uDM8AwhjL0PRU3EgtY/UUJ4lI7HBZ5KBFAt59V9uOI3E94j9OUJMVxTvqJeqyixJdBmlyJ2M3iDEPI3DIxStgpysHw+XthGPXE6OlzLY3dzKz0c87ZDntvrpzlyhwZapwMX+hHp/4TXBF/3fYz1nbRDgOZMINSiNOmFH9VRHV7Ygt6Rj6ErL7Ag7VRj190YJapdxsUvk92h39h4C31KjEJgotbOWZF1IsFwn5TXU8SDKPHgWNOuaZlcVkMAcOQszQZF7vW1KTNR+Sf3uQc0ug5xM8swvYAaajUEy3KaIulVgoAnPTskjHOJr3Yf1HFaOGi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 05:35:26.4465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2374c1fa-91ce-4999-c9e5-08de83e6fe45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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

Included psp_13_0_15 ip block for RAS

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a8981dbf26ec..2faeaed75e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2249,6 +2249,7 @@ static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 15):
 		ret = true;
 		break;
 	default:
@@ -3999,6 +4000,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(13, 0, 15):
 			return true;
 		default:
 			return false;
@@ -4012,6 +4014,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 10):
 		case IP_VERSION(13, 0, 12):
 		case IP_VERSION(13, 0, 14):
+		case IP_VERSION(13, 0, 15):
 		case IP_VERSION(14, 0, 3):
 			return true;
 		default:
@@ -4181,7 +4184,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->aca.is_enabled =
 			(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14));
+			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
+			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 15));
 	}
 
 	/* bad page feature is not applicable to specific app platform */
@@ -4269,6 +4273,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 15):
 		con->reserved_pages_in_bytes = AMDGPU_RAS_RESERVED_VRAM_SIZE_DEFAULT;
 		break;
 	case IP_VERSION(13, 0, 14):
-- 
2.43.0

