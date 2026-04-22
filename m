Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF1CF94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38BE10E1C1;
	Wed, 22 Apr 2026 03:56:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EiOzMqji";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1369210E1C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI4stnkV9eWQQgbUOO16Pj3sG1xQRXa0I+ULZO6jp5C5XXwSN3wsd+kLai0jLRaHHTtSLo6hKeMLFBqYnLCxyARBc84c3cW6cJCuXKcSMs8A4+JuoOhF18Rbesft4PjVKpP4/Dko0t8JUZ/vK90ekgU2OaamS6LDt6oakEBvFDPeS6Qw68IoHeHkgs/rhgOS4nU+a4TSAkd4MDgdBgnVN6PhC5KAPJlNqlZ9IKtxaqSiGjH1b0LtxIj3AwiEZAE7Xswibx/0lhX1Bu8Ean+uQz9d/SH6KhsmboXigqyLFtlgfhPRrXtvh3t5EkJb09n31uqMz5IObTBxICql4GByZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbPBVjKciTwTxD4Awd3DkVroJYW/TSJXZ6IcFiWMMAA=;
 b=jFxeu1SJfN+YsAY4iHzk4IYpuv43i4RKbH9jMkeo3dFg71bZ9W4iMqJo5XdJHAYBfg3tI8pkGEMgCtlnQzb9ipopv7TemLujBAG7U1pMqvN4sbwEgyg9FJpCuRbDCxW1O4vzr0wMj0tTwhKU7ALx0yOhQOo/SLiWbX7NHCO6cG8pD363VXF77ACyXph4ATAJY1D4jzYQoZQlXfjHOjCkwRRdK0oxV61A/pmsZAAZXjEAMCAF/Q283DVo2srEcrvnLghZqyRiSA0Yz4M8xB8DDtFV9FQwzo3URqMc37K6Fvs4XbGQhQysADXR3DsYE6FtPY/NOFN5K27m6O4GEJ5tQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbPBVjKciTwTxD4Awd3DkVroJYW/TSJXZ6IcFiWMMAA=;
 b=EiOzMqjig525RCHyq9+VMokoDT3QJQnrxhyS5dqEdU3trZ5/7qu0/5kUTvrYs9poqrglN031uPCgM2k1q9LuH+vHeJ161CmWFvYp8QJ0fDRcUwkVeemNIYbJuoL/lp1NWSeRiOWVuyuNBG3KFTzkIQQAnd9Q3yQFBmMN4bIUePY=
Received: from BL1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:256::27)
 by DS3PR12MB999216.namprd12.prod.outlook.com (2603:10b6:8:38d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 03:56:31 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::50) by BL1PR13CA0022.outlook.office365.com
 (2603:10b6:208:256::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:30 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:27 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Dillon Varone <dillon.varone@amd.com>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>
Subject: [PATCH 02/14] drm/amd/display: fix hubp tmz field define mismatch
Date: Wed, 22 Apr 2026 11:52:40 +0800
Message-ID: <20260422035611.1870316-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|DS3PR12MB999216:EE_
X-MS-Office365-Filtering-Correlation-Id: ab200cd5-7eaa-46f5-de70-08dea0232369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: tEz82JXzUVOsHBvrbmF6qi773/QyAw80iXj3UooX4ZqZh237omMRtHEU/kJddwaf1NLDhWFfwyOCbl9znHSQYH4ovTbXu6smmf9537PUcU99wANlYtlb+hdV3k7yAuYAKh6eSbF6MbTNiOajQMP3OVr9psiSWFybNqMw9mEVKna/vfwgAdCMqNZggeP7QnPsqThjeYb6pkDRAFMiuO3skDr5zG04ejTkH2IQhi7PUFIYzQyqmxUcs4H+ykVf7l/KRbxufwmYTs48zi3P0g5GWiBgXvh0ke05EwZYfABqyWOCUXHs0tIz4RJuPintIcaQujjuqJqLq8JW4F2AQ+i/ELEIdLJwGgndb/e6Op+ROTeYRKeJuzOMOzvNx6Df1r6AXQKWKDBU9c9d56Yj71aKVqNM5Vqi8LKNa1oqATBbNkdsVYWkuDEsitgnWe9/uXIkWLQvxUk3NOIBBDk0ItJk3ChC/rmMY0CIY9C8vTLYcvyZKESvbbQiZ7tGryJmg3DL4o614Y2wqMCM02SOTsbCss24X1ZTq/4BzeIiCbPA/ce6jkge6RqQJCrymhVCxr24EdntmgVlIk/nNjGyFNxPcPPLVbohMPnjJfi07M+vpiVegRPph6nYXepbwZucv57aAgcfusz+ddezBqC8DB60un3zfcLbecxwq0uXkzZTxY/pYPl530HJBT18xC9cSOWUAWQIV8fc04AAXpmnDYLzJV5Nf99wfQo4AeIo+h0wFojrqE9q7Vu7qUzI3mvP9o6I8s9PFbP2q6S/8+mewHG3eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TKP0yg5EDN+RRyj7BZInAo9nJBK6HWT3v11kvfTWvF073U3f1WlLnvrmtY04q4uWWbETe+yYAshQ4I79U5Z8HBREkIWYppGgCPVrN1oqV6Hg9UVveshdtRGUY7KCzU3Ku8/MA7QzmZ08ajslzFYQtsXnMRj547nBJGMdITvznvrBX32e10CF4ram3TjoO+ZSXI89VyroHbJ03ye7UgoUO5O2NxDEksw355HjeF6lYLVcj8aGsbJ1XywxSjWP2MhnuIwYmu1mzbFzD8imULVpnQzko5ikji6K2EqhUP62xn1GCTcEu44O9mNp2awsVXAxwe40Yo6WaRRlizqaUUk/S4ElRswvM1inAn8QTsNL1q5p7orgIT9NUPUbmzE6n059fGhv0oTeXqRZyxtLzgDhL93jNfWdN93bMy8Q0LHsIWvLs8g8B2DSvb98QWJ9+vYr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:31.1178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab200cd5-7eaa-46f5-de70-08dea0232369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999216
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why & how]
to make hubp surface_flip_registers field define mismatch
with dc_plane_address

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 2a5a81d15950..71f6c5350e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -133,7 +133,7 @@ struct surface_flip_registers {
 	uint32_t DCSURF_SECONDARY_META_SURFACE_ADDRESS;
 	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH;
 	uint32_t DCSURF_SECONDARY_SURFACE_ADDRESS;
-	bool tmz_surface;
+	uint8_t tmz_surface;
 	bool immediate;
 	uint8_t vmid;
 	bool grph_stereo;
-- 
2.43.0

