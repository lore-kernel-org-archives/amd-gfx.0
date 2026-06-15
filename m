Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AEACD98DA
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB1210E771;
	Mon, 15 Jun 2026 23:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cmJgB4ym";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A64810E706
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 23:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t25ppL9XIchzpEGZ8axJeBtnAqa8ofMt8Z60GcgDyqOLBHJuE3+a4qjC90OmNUJUjbsE7S2+OiZU0grkQXMZPW5S82AKBrYP8mGbr9Iu6Y+7y/AVs9LR1E7z02HPciPHE5FBFRtZXfRRa4mWwCdKOiA6I+N1gbS5JiTVodqt37qYsZVj9FXDU9UEAgQhpnInhv03qRK5+aQP391BnQi/T0AywGcP+9mYxZRRcueWO605B5yU5F+RrUjIZlm5IJ7VBJRboXbx2BxvJhMeQkXdjHLev5Q1CchPqR4RXMNXqQ7yF2yotJ+rqnDA220d10WpqyHVo42IjQY+solICAPYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5ogySWppCNP5EXx/bKqme8B+vlkoCU2vPRC9H+uepg=;
 b=EgBr5mR9I5Ni3RExLWutxDHqZz4r1gvV8rZe6TSulMfOBe7+i7BlHhMaN4GhzZ1kZm9umjaM/d3np3HaFIQ3vxqg8+RPKFJQyp781xd+QRq5nvZSe/JEPhzlKuxjBV9Vp05UwLlTfBp+cHwWHqS33y/EHi4U71bfu9OWhP+qlTRS2hWP3m7yC3DZbbZyh5UMJ35DWLNQF0R5iYfYU871F/dt4+QDWnbG+sil9qPP5OJjz2/i/azx1rpeCH3qQ9QpeSP3IPqGt4WTyQA2A90T7s7LgTaaFYEkEz9F4mbYHAiT9z0VHcLWfCg9lGPAWeQWnQILlSC6uN028iVimvOynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5ogySWppCNP5EXx/bKqme8B+vlkoCU2vPRC9H+uepg=;
 b=cmJgB4ymWglK4JCRYYgbIUbYdRX0F6AVtMmea61JI6HXbU83kkyRo/5xv5bY5UKKFSj0dnVNnDX0YE+VOKqNmOV4yDDQ/bQ9fueLPHf97EfFm28HjKdvudMT4sJVXaB41acRiOZqAudL5BKSGrePWX7AI+fw6c53JCZ7lEhExRo=
Received: from SN6PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:805:106::34) by IA1PR12MB8079.namprd12.prod.outlook.com
 (2603:10b6:208:3fb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 23:57:02 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::a5) by SN6PR2101CA0024.outlook.office365.com
 (2603:10b6:805:106::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Mon, 15
 Jun 2026 23:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 23:57:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 18:57:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 18:57:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/43] drm/amdgpu/atomfirmware: WARN() rather than BUG()
Date: Mon, 15 Jun 2026 19:56:20 -0400
Message-ID: <20260615235645.737189-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
References: <20260615235645.737189-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dc893e-2b81-49f0-3e0e-08decb39cb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: JOR5/mC5ex0hh7KUVc6JhCmfVSb/XLTaonrkBw297NNB+mgMFM0PC/VDq/5Pf5OT85PsHXLtJ3AgDL1R3ck0vjFnP74a9fhMVzp9ofio+s5E4BQkFcGlF4JdVSslirRTtjgf6KY1lhgC8hbd0xlq7UZT6Z+dpSKbxi6/fuWv5PTJCwEy9VfIrBQUH1mpGq+IDASLaGzpUpZRtbLG0IFZz9bPoiSYO9mw7v2Ro63O1FFWRlW/ICZhH/fcKAvUcKUg1FQpJwjY5CpP0CUR93APPwqDmc1sPradO+LLWN/9A8akAzRCW8nnutuxLHaWJi+gjIs6woUv8aCrubTNo8D494E6GPO/5MtJE8DhtkM4L9gFUAXW7hp6D8tvg3WXayof/Erh/GLbAXXtHDJfZ3anxxHaDjMQNEgw/mtamnkH9ySg6NCier/SYCJ3Rqu5bz/knsdO+sBhNaFoGEbDvdY05aeNjOMCU38EmNHpxbWV0Y8NG28YXzr/b51EO9fmIKa8bno2ZsM6ZE54+JVt7ln5ZW0+nXV5ro75gzvX++ljrxCL7B4w2d5UGV8fK0/YimPKp5AMqOs/YeMwqS46mwgIHg2uuSWKAFxE40TWW2sJXP51Bent8Rl5yfJaeYPAtXZJSkR8e2v2s29R0T6d1rhm5SE1KacTZigqhA1yXH5Pq7gMTPUb5NaRBLEhAOsQJ9qYN+V3nRpkZxokVN0SEHjFL8Sb3EE+BDglUEJ+wZDXSus=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: irFmnc6txQDqnyA5WPtZeLR3KIAZH2xm5ylorAycEqrQOOgsu8RXmkPiTPIC55rj0om1PeyaFPBG5BzYhJ/bBR+FX3LaTqy/4kaKLelTsGsQ2O2fnLp9Y3L4V/DXMN8wmCiQ5bbkjJfwY433Df6z0id959NUjuKAxQcpbuc3buhLEwYZsx4I4X1bNSHutywfF7Qs5Lz+6IOS/KB6slO4poqxFJJ03itG3FhAG3K0P87Il7OCKkpckpOBbrZYNaar27B0XlYL/8cIiVsMPki72WQXTxrPiSKCcPNrdBpAlyrKDc/aP7XjdAABi1F6I7tweB9hkHIwF5HBEJibdFcYhnAYCGq4XWYVCnPyeugdOtorIpKiSaEw2wVgxN+FeZ4Hw8B+1D4Diapi6PQKLilXTY+f5UQNHN0t9Shw0lhG5ni9hPaHmlwkWZoCeZBxduAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 23:57:02.1895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dc893e-2b81-49f0-3e0e-08decb39cb9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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

There's no need to crash the kernel for this case.  Just
return an error.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 6860a3a4d4667..1e21e3444802b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -917,8 +917,6 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 				   (crev != 6)) {
 				spll->reference_freq = le32_to_cpu(gfx_info->v22.rlc_gpu_timer_refclk);
 				ret = 0;
-			} else {
-				BUG();
 			}
 		}
 	}
-- 
2.54.0

