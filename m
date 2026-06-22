Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5693CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 14:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513D210E737;
	Mon, 22 Jun 2026 14:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGLD7NwF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A17510E737
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 14:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtgUjn59LRmLNBh7vjitdlFBUi4Ab9j3iSA2r4AmhrIvxm3fxZ7dH4HzLxQCyqFTSjAHGh0a1JpJfCDO8p3B3nD0xkr393lVsAled0CdtsbTjgNPtrnLqIvDlVeXvgq+iMKPAPrsn6d9z9V+OkllRx/zlCARRvExOxReiPYkVVIEWOBee1asifatW1Xt8JLx6OGLMDtqC01DkndofPqhya7zLIrt4YKl4vKhOOEIrk8Eu63zoOVsB7pUSq6ZEgInFgOGozvvai0XUEcKUMpMnYfYeJ79w34l0FEybuBLgc3kGgacFK2L7iXuxJwP3Jv4K6F8gEIZqTIzVCALK+8V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZmmg7ssHEtbvNd76SUzQLwFu33mE7Nv+VBmgGlYivU=;
 b=a3zKBs+SmZJcGm1Es7BIl/alEg+ySS3KYdELWHEoOiV8hStefIMKdl9aZZ1pgepIHTM7xBGf4sNMtKcVdWSKVUSHDcYRWSwdlCwVr9IDpGrk8vLKsESsdaYZgVb1iCW9kMLYM9V55eGBdEFn1bp6VO32jYlFLsM9iKF47wQ/zcs9Fx6PxryPZuF0474N14HzZ6QPbKpPCtqc5+aua7J9koPEl8C8AMSJunXHGl8ufF9Ffyyb7SNwt98qQuEyXff7LMDAZHA7Rrfyb6gdbpX+6sRLHLLPf6I68WFzihA/Ow3fswDYeY6BpzlIBIEHtcarCbnNVf3NHlgLqyHLPN3CCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZmmg7ssHEtbvNd76SUzQLwFu33mE7Nv+VBmgGlYivU=;
 b=tGLD7NwFtOtTZusyKe3AYCyhOfJ3jq2qprYvZabgL20QX7UFAq8u+uuLkFdLiRepjY56als5bNUPzW/Cx6gu/5jwKiUSDqn0C1YTOphs6PGRLD0OoLzQrpYX3bkRYoRi1REqjXan8Vx0mqWoy5rDipRRbEmKGL+9FQDd4uJ+Ktc=
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 14:57:27 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::46) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 14:57:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 14:57:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 09:57:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: bounds check VBIOS date extraction
Date: Mon, 22 Jun 2026 20:27:03 +0530
Message-ID: <20260622145706.1382846-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260622145706.1382846-1-lijo.lazar@amd.com>
References: <20260622145706.1382846-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f23858-86c3-4c9e-cdb4-08ded06e935b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dsmMJxvgsFFrOUpU7jkHxu8sbtjmmm9G4Zz0Lxb/gY7QPmYQB5vt6dCI2as1nPmtyt7AJ4EMNAlsMzKIx2zxDjPq0f7knr7uC/zZ0DDyIfDv7L0tOmgK2PX8n55pda71ZiwofzLddQe6fI8Eo6X47kAbFwGV4IE0e3QSE2UnWsWTVgsFlIJ6BMrcLUHSfSOkytx8mh58UNQPr+dqIumhlnNdCgCtRJjUxadiEZEGb9JWU87m867rTu8KMouNE3U2bYtwUg0harsOnTg75gOPnPGQvYD19r4VT7QXuL3SoskxGmEqAE3lcOAofaEl7pkJcxPYJMevPUI+wfMfwz18Tl+eJz9YrQmmeUSNHNzLHepoQPOfG4ltZD6CBHRbOHM2lOm8ha7IimjfgT2zNLMeMGsM6YU5XJQGwNsr9zkkAMF3GMl9ZXfKL19gjH93xHZ4h6CtF2PLEp/ClV/VFjq+JnxBywWMsVF1v/GB+c9xl9nxxBdCq7GFWDTo7O6uz/LaULT8J6sikX9I7d/uLZvNZTmNob9bBGCoEn34+fAQfd1U76+b2idVqah4jAJ3Z6W+6elPVVs66BrA12/aDvvPQ/kk2jkx4Z5g59TnWI4j5RkeG3FnYhwcmLC4MkC9iOUw2K+9I8x2dJ61tsNvAfE36XorFIUJY5r4/W/EfiJtuUGxlR41CvGW9er+W5v+5lLw984aMJjUWqCEySXThSWCaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h90VX+V0OnKxN7C5no54DskhaGXPRmmxel8jTAh9Yzopce/rgUlyohWlTZ2fbYG2w9VQNLgNumed0ETxMyDuhwTv9yP7qTTeUvrTIBpfnPf9DsUkRptEfN2zaT6wsmniqvxEBm6s1vB4HQauXtmVsl6DKxkK0xQkaoLEUbuUbLotg0cu65aPUcte6pxzzTR9SDQJumB4O23azwfAG2v3hQ3oiJ94jfxIHgqx7uHjzf3uCvgdOgAFcxeOUcM7u+hk4AAiFID7IRPayo4WRCpp5+nk75EqkcCqYzsQmQ8guCl64cF9HP/SkZIn1qKealJBlfEHF6hP3Q5UO5AavL9mhXpVanUhvtmOYpF9NjoBx7BDYDM+ElJtmWICvvXd/u5EBv5yO8x6L+ViCQR2ua4R+CzObgRuRoYJ+6BlPGjHUC32plg9M/mnSKQxc0l/BQG+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 14:57:26.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f23858-86c3-4c9e-cdb4-08ded06e935b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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

Bound atom_get_vbios_date() by the BIOS size to avoid out-of-bounds reads.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 5a4b06dfd096..d18e46422520 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -59,6 +59,9 @@
 
 #define ATOM_CMD_TIMEOUT_SEC	20
 
+/* Number of raw bytes read at OFFSET_TO_VBIOS_DATE (indices 0..13). */
+#define VBIOS_DATE_LEN		14
+
 /* Limit ATOM command table recursion (calltable) to avoid kernel stack overflow. */
 #define ATOM_EXECUTE_MAX_DEPTH	32
 
@@ -1420,6 +1423,11 @@ static void atom_get_vbios_date(struct atom_context *ctx)
 
 	p_rom = ctx->bios;
 
+	if (OFFSET_TO_VBIOS_DATE + VBIOS_DATE_LEN > ctx->bios_size) {
+		ctx->date[0] = '\0';
+		return;
+	}
+
 	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
 
 	ctx->date[0] = '2';
-- 
2.49.0

