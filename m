Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7A606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LPN5Xoqj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E631B10E121;
	Wed, 11 Nov 2026 03:21:36 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748B210E033
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 03:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLfqxHaCRhmgRQwNp50oPJseND+YtuwiR2rdUDvpkPi9VMWLoGoEVOjjamyaYH0i9AYYH26nlCWD6/xHolUS2lQQ/YWsXaMSeTlGzC90oNHmLtxiv+gG9Rip6pbbBNfwOidmrVDY1IxO4k9Kv+36Y+UScWBJLRCsDTs6CgMTQClAqiBzPEMMRKsYbAUtPrHW0drGO7JZf50ZNVi7dhlY2f6vJUAWuNNbIBED1ADYjynwjj4se7Az0Hg8xMMtB/b0pvJL3H5SGHNp1Vu4Y0d6Ldai/LnGmHl9zW+GfbJg16ohAulquMr6keMQcuJO8zhMEXhtF7VRTKLZ6MU2DedKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3Ra/F8Rtwrwx08Y+HZCPfJ5sv7My2MZcLsUyDpDgjA=;
 b=RH7hA4opb61c7iHfxe/zvFWzCJ9YmyBVi2QdHoKQ5scl0s/cuMniOg7L6omFKgqyqolwU9U2oKIMPZzz1qr5RxrKkrSjYiGAf1DkffXYQ0OGNfkoT6wjYf4ABsAOmGItw/kDzdBZdQzLs7foqOglIF2ReYixjL4BioAbNH1nyTIkZ1kcx0wE+3FpVTP/ANmQdPR/2i8uoiSMIZqN7B/2+HmJv7bIQgPYT5RxQr89K7HVUx2ssDHDsBVC625hSPtuetaKYUkv4gMqHj2PwA0JmhpSgYKQ7PyeAL71V/BeaYhojMvkUbLQ2OH7Rnu7QfPJOXpHBHRsFWUnWIKdr1XVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3Ra/F8Rtwrwx08Y+HZCPfJ5sv7My2MZcLsUyDpDgjA=;
 b=LPN5Xoqjg3TpdaMIYnDEnB9OyLuJzvWrigilLNARIB6sIwSGRLrAQfZpP5xRfpbIMY3dtud0zQRCgZP828LqcPXkbpczdzkNmq6ORv69tb5AHmTT7oPeoZeDYFK2IZE/s3SRTbRo8nskgmIshz6tHaEu+DN771ycPfkpqZQT2hM=
Received: from BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::14)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:21:25 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::19) by BLAP220CA0009.outlook.office365.com
 (2603:10b6:208:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 03:21:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 03:21:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 21:21:24 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 21:21:23 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx11: enable the GFX pipe reset with new
 enough CP firmware
Date: Wed, 11 Nov 2026 11:21:04 +0800
Message-ID: <20261111032115.3787085-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261111032115.3787085-1-Jesse.Zhang@amd.com>
References: <20261111032115.3787085-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 327e18be-7408-4b62-faa3-08df3fa2ddce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261102123227099003|261021121427099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h/JVDTnb4feM6O8chCjUxra2Cf2uRWK327PiI17BTG9y/+Z4ce/DjevZvthYkqfd7NHgFT+HnnvcI4oo0ygyE5EDZpZ5MqV40VEVZwhChw+olZklk4WJ0tYv5IVgXaiwHaiPQv9ZCapPykRiERMBEiAO75GwA6kXzVej/hZA7neBEMvj4V/7lKpgXpypPoYV8g5YFe48MwKNETUacbKL1OXf4MeOjYETQI4kxP9q8iNdhRMIAHRFRolzpZ2odF1um4PMWmyMRiqvYlNg/tLb/FcBSvqh3sXs8GlEJ/bHjh6HW5KbuU2YY6K2NJ5vPxIv2peFHag2yXgkXCyvcxynYuNp4yeroLGU7Zjxjj+U+iOh1GpRAUoIewKLur2A0dfDZTRlVwsZjARkyXuf5neO8tpGb01gX+ao5TtFNGK8cbr3NFREAiK7RxHC4x9gEbeQf1vPr/Z/1lFBVIpH7QInf7LkxVq7p6iIMFIknii4li4KgDCS2PCgYAnk6A6ImL+ujQu6E0VHxwZmIjNVK2+W58Sk7SBCR9bucXMWtcobLpfSNbwt/RzJcBT3KaQfcSQZEJrSqJBc+SmdG96wsUajEUWz/9u5epSbqvPyewhtW30KRxfU8PQpW9prztkWTo4xw3A0hULkDr8wafJwMDQOc8fmBimmMXOJnZRcOVR6/6cO7Un+h0jKROvJTz62cSrb/nRHd6/r9dv/1tyg5GbGRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261102123227099003)(261021121427099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IqCThUdhBCZlyFFVCoWSFWvMTTS8PbpHGN5PP8BIrJjNHNt/18LWmqXOagaP0H7IJxiPVhAhAhkz8j1ZjWMyg1LFhCHBPUCP0thtZvy2r0V0+TMazAZHmA0U8NB9kA5A8o02CKbRSKc/ZLeSz2qiqUGpVi9UOM2D+nHnkg1R7NkB0QKnluAftqip15ehG9R7kz7Dh45YVDG0q2BCPwsEoSBFzXtqSyPWBg6ZvozSMwzgl4XW219d1c3n83sRB6siwr0MvPaL5OBTlpjFF3uucOaYjJrAeJ1GxaMwDZEOEbRhrpp7+rJ0K52rxWKJI75m4DT8NLj2e6RPoBJIv8aqCTzD56ShBtH4g5aZefBieeAkeEX7kWAUzT+QR9aVywMrOOGcpPL3mBy7bzSZjvRjIpC5kuXkiLFNJxs2z4jLhB97VCoWClHTf++ib9goWf7b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 03:21:24.8072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327e18be-7408-4b62-faa3-08df3fa2ddce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resetting a GFX pipe needs support from the CP firmware. Advertise
AMDGPU_RESET_TYPE_PER_PIPE for GFX on GC 11.0.0/2/3, on top of the per
queue reset, when the firmware is at least PFP 2790, ME 2600 and
MEC 2850. With older firmware only the per queue reset stays available.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d068a9d9c72..ea74defe7fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1925,8 +1925,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-			/* TODO: verify CP warm-reset support before enabling PER_PIPE. */
-			/* adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE; */
+			/* Resetting a GFX pipe needs the CP firmware to support it */
+			if (adev->gfx.pfp_fw_version >= 2790 &&
+			    adev->gfx.me_fw_version >= 2600 &&
+			    adev->gfx.mec_fw_version >= 2850)
+				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
-- 
2.50.1

