Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F84CD98DE
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE0D10E789;
	Mon, 15 Jun 2026 23:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WHtnTR7g";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C2C10E780
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY2e21T+onIJsOKBpzn/uzE24URJIgea2VkNkZXYrrJ5OvAHIGb/0nxIgY4PUnVNyL+BUUOhowXi9+Nf0hLcC38vvdt+FCR5YTyIdsfCYywHIe7SsKwzB15T9I7wXzA3H2Lg+QzNMzKnQMI1cVFoMn7w0xQxryB2T+WSgqyn2uD1KR0Oav6fJtbmzPilYf3roLPveQQhE8dNkqWMaAKzI6KoyF1JsSxKKPK04i0Vfg3/rzLUr8hOIE5ltCH3B0v7hMaT0qeUFe38O+UNXUE56TLq7B/r13D2KRr8AhJHS9pOtlQYRYuSc4HMKollQZTOcpCVpQonVRr5zGBokOtQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjyXO9dwaXR3qfXup8+7d1RxXtzwH6bdSxN2q9e3il8=;
 b=Rs97oWiMmdL2KBJneRJ/D3JqGcrNLvGqXL6eCnCesrS5c8CcYtoFGUmSdP8Ui7qGD7M5tiqpWxuJGxn0QyREgArO1ttdhLcy7gUXTVedG3T113437d7fm5ByUaiX+nbjcap5J+dXb0XmShSDb5iw4FfhK+LInZY70opiDeEb+8NPDUVq8V4veUGIWuOQnzFudJ2d1aggLyAOEvkwtbcSM2ylDomGfS7YknCD9TOjRWJhp8zs8y88HezXeyYuHSKMyihzAKO8HGG3KsGA/Sj8L4xogEBSyJOJli2sbbEEbNiuiYGt9juU7+r+POkBf5JKjgPPgK0B21y6o9Q24GwR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjyXO9dwaXR3qfXup8+7d1RxXtzwH6bdSxN2q9e3il8=;
 b=WHtnTR7gGkSi3ogPHpV+FpcSO5X1EhEPHniEK2EMCxRWEChRqDkdvyY/3hoOans9bCLIkodDPIDfVNt6qqp/dXbmgUmR2omLLtReiiQCfxaRFrstA/ZFpuR4usFfq639Y/aiFvrpIj3Knu29flR0k6QPpR/3HrVfEzJeBkUTTZ0=
Received: from CY5PR22CA0032.namprd22.prod.outlook.com (2603:10b6:930:1d::20)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 15 Jun
 2026 23:57:11 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:930:1d:cafe::a2) by CY5PR22CA0032.outlook.office365.com
 (2603:10b6:930:1d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 23:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/43] drm/amdgpu/si: drop BUG()s
Date: Mon, 15 Jun 2026 19:56:26 -0400
Message-ID: <20260615235645.737189-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bddc3b-f41b-412c-6398-08decb39d0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MagOC6xOPME+YrEyxcuj50AWforYx7grKKwrAuOOIw767Gcfbw/9ZYud89nx4Y1PFQmlHY+0R98Y/rzhEfHuYBqcs92B00vyn3ABtw0xofdIDplVL+UMhXWduX5PJHFKFHIncVA3hvugAPt4Bfndq/URvfvQvxhYd0iH3e5E2x5uzZdsKuKVogKs3DxnB3Uw5SVbhIbNuZxEu8WOJKcBMVkmVFA7COFKIos9NfFwmRppypNG167jYYQJGa7HGL1UxZNgNxLNHqBcGkiakaFu5y5Trw1i2w63v7IEiSKGwlDrTDTDANDKwJwuLBWo8I2PDNZndEwKiFsXIp6sxSFrzXbkObhtqjtRr+vuVmM0ZQM/gHV7Whd9Ve5lkwX6cexHLAY/e3G09ASAvzcQ4CbxsERLMgSWqYsJIXeTJLvn3uu+7yyGFh5Cvm6SygYYIS+5taUuEgFgXVHin/Jr8qSkgGmYEP3iiuo0U5Ki2Kvcs/5pzqZ12Y1caFCdYGfyZ9G1G4sT0MoKr2wlZNYhQRe47htvrzTH9lxvxsRy5Gq9XdnvadFoNVFuaOF3axJe9KEaQKi8532QQjCunsoKzJsYfcl/eISsiIsJbEXIpPGwBnhiQWY9bU5bQt0xTZpasGLHXyjuTdLyHld8UUAAKTj6l1kwZJnfQS4n6VRhyMpRicAzWIr7/1ZslOWsbk5F3V3mDl0e5g/qYeB9Wr0pz9yM4uRGbaiAswQmlhd7N2Z0aXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XKoI0takMcZhoKJ4JPYh179kIBD/Tjzzx3qRQGvk84xofwd5vbzszOk3ku1vrtmSH2/O0+3t9IqB0OnAA1rNKFNopxlZviK2L/ldzxYrgrnVMtLCVlmI0kGSNXMVq7ybOZkUevhweeRON3kFMFt2GVZnFvYVQxotrYshKc12RxzBMOrAqJ5VIHaSLSrqZ4a3K5Mc8iQM+/Vo4SIJbnkev3XOmq00ra0t+iAqViz+Ty5LPmEmCv/JrQrQwkZhl9um7ua+G3hqVeIis6tVyHDoLbHq5GCnIoMlWqCVcxY2GnDTTMYOzrZY/PXutQUf+s96FTHGMoOORAVRDFCZbfmIqOJybslFy4mbSxo4pVc2htOOypKq7GpU2jGKNnLvI353ZYinb6mx+kIU0feQ/SpXDLt8TexFyrZJWniC80eVncxZniHomuoQR6ZXEt3e7Tgf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:10.8854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bddc3b-f41b-412c-6398-08decb39d0c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index c26cb3e8bff6d..dc7c3ef628eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2224,7 +2224,7 @@ static void si_init_golden_registers(struct amdgpu_device *adev)
 
 
 	default:
-		BUG();
+		break;
 	}
 }
 
@@ -2741,7 +2741,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 		break;
 	default:
-		BUG();
+		break;
 	}
 	return 0;
 }
-- 
2.54.0

