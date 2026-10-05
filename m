Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3077FCA5FCE
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 13:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A362310EA1A;
	Mon,  5 Oct 2026 13:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuiIjRgv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D596410EA1A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 13:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/jCi5dQVAgTMFvmWZS2I9X7/vXB3d5ESnybOaBtd3i1WXoGxT+mj5KBFWwTUizykX4TBzhVdotBb4EHFgyGtwxLdgiXwEoShxycimmfBQu0+FJaILPe12PD1hiQAfh84CIiAs9XnSxtteUQ98xZX8W7XD1KfBtauJe0sVzD0S+r0NGz7NLaYIRpAx4BP9RcqG9rhxkxRGMLv+qSkDN65GJLvcn8q9Rj/rPf2fLImBOQ1DL4mAmDKG5Fy3F9XbfagmHTibmaP41SWXnJEDeBT9S032NpmzMmyfX5SNmGn94kSTPz86byZ6MaMv3VKJWDlg/ODOLvtt5E1Dsyg9lStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NCIDS+IvElP/jBniuZzfzAkaxNtIDMtGLWbu8yGU38=;
 b=qzoHlVFZrG63S5EstSW6bIh+zmEPDF9XDcFDEErhbcLP1LO/EPwi8+fL+RNjW8HptOWz/kuX4aWQ7c/wygInNtyvgRf+AfcLh0tsOgDKiRjxiHhsQjdVQ0OQwx49yuFbJvZi93vMFQ3Jq5Zkfa4/AjLgpGBfDDAMkfUzwNl69oU8cm3gbz9bKqDcMPX+rPXVjJWB7RZYe28wou5QDAzqS5zR8825SvvtCH+3LhtpGS3zYqkrMGxLgFOAghGIJpMXa32+4044Lr4lITVoT/+piITY3XbBGgBy553Em2NK5ANhUMQKlVAoQLbPd2tmKIn1LdA2mx0KMSmaNDkGL3r8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NCIDS+IvElP/jBniuZzfzAkaxNtIDMtGLWbu8yGU38=;
 b=nuiIjRgv1Gw5gDb1c6L0V2Tk0IVCRY5OLsS+pwmss/Tq5UQggzm9gquitoOQWCfuo6BVJnMG+lAUU6VnyQu8h1boNm4p7Mmw1T7qgvmETj79Xx40bDLQRD1Lqn5oXRlykRusMkjiU1iTU6OfVw3Dn+p9KZusRgRE+6TxRQn3/iA=
Received: from SJ0PR05CA0108.namprd05.prod.outlook.com (2603:10b6:a03:334::23)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:28:33 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::2e) by SJ0PR05CA0108.outlook.office365.com
 (2603:10b6:a03:334::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 13:28:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 13:28:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 08:28:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 08:28:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 08:28:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Ayhan=20=C3=87i=C3=A7ek?= <ayhancicek@gmail.com>
Subject: [PATCH] drm/amdgpu: make Mac FB workaround generic
Date: Mon, 5 Oct 2026 09:28:22 -0400
Message-ID: <20261005132822.2486852-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: e0702d59-637c-41dd-692e-08df22e48c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: FUhHownHSqrwbUKDZ5A/fKzcUoxbGjmkhlBwHMdloItHNRZ6fQHb/BocFvayCE75TKhmfDUMK9ZZOCpwC5IrJyPp2SXMzu4NpawbtoT+zr9kYnATbOpy08A9Iixm97Rmc5DD9pZl6zUrNQAErgPbw+lUL94/vOrS+pnCti/QPrUH5FIUIN4RuvBjffyOlhSW7On94eeQoa9S8nubt+NzdAOwfwV5btXBbfycBtEl2ALnNu8C1KEXK37WiK6dJyJTPmZORNPFHoCvLm5BG9crBJl4LpzRVK1dpfkWe4fZPR240l1ZP9vMkFawqgBsbgtpMfK/u7ZevpDtunoy88nqx9zqBYLh7rbk3qQvAm/2ecEz+WIvA+icD+2ZobBQ+wS3w0D0tT054H8zen8DUzZe9iNJ8zw3rm+hJZFJwXlmys55Ccd4OhE0VAFyDX/L4zhnYWCGSwSYeBSRgPbngq9nNf5pplRqhZgUEKZwE4Psu7MW9HloBgXMO+g1F5mllunz4uDg1hUIqP469/O0kPjlNqGj4UX+pInU9xiG7ZfWOq9pjWuhzJwIi2XaUFTp0XSNTThGpdGrhuvXpdOYd5WOsDKrSc0A3YJCfd9J+90WP6VC2tR28sNnWq9Z85vj0Om2Dq5ktYrmJUNiiDKKZAyC2zU6HPn6lPtZyUgrEkkJpRGZ99IfRKvbEsgHooo5Y3xZV9k0cHB2vhHdsusWzsCBMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cTEQnuaRp8owqaPX9UjGv/FYq2YgjqhgYuR4DA2lFW0evjh3dBdiIbalPo8Vw9Gy0dHr+BGl3JR6kYbugSmtWFVcq64T6Ot4+5sdGLE0rGhETZQ/lM+QcBRWKJnAZRHCkk2Uun9eemveuJUZNaMX1QZcrHsasGl0Vb+FDmoMRtbA8jGW0nYb6vCtXW472ilfmvVszda5gifsbIblGykqioH1+adJZPsqumAFSwTbe8s5DJYUZsJ/h1MYYtMKtpmY4KQEcIT7pe9TahLHI0Bup+lGPiAaaa1mQ6hTqhe7swIhliPGbwPWDqXmw38WWGQJpEyV5/IHN8OkO8v4/gP6YKBD8GYMh4EvO/NC+HcGAu94D1gMq/ltjMTTL6cbVpK9k1FLNA7D0CLKHxkTUVUwc5cP+G+zXehm3Bw4Qqnz0WnNgiweB7LkBKM4IAwGpPsh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:28:30.5876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0702d59-637c-41dd-692e-08df22e48c0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191
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

Rather than adding a case of every chip where this is seen
just check if the FB is at 0 and the ssid is apple.  This
should cover all chips which fall into this case.

Tested-by: Ayhan Çiçek <ayhancicek@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d25ca903e21b8..5d4276cd0f7d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1190,20 +1190,17 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-		/* MacBookPros with switchable graphics put VRAM at 0 when
-		 * the iGPU is enabled which results in cursor issues if
-		 * the cursor ends up at 0.  Reserve vram at 0 in that case.
-		 */
-		if (adev->gmc.vram_start == 0)
-			adev->mman.keep_stolen_vga_memory = true;
-		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
 	}
+	/* MacBookPros with switchable graphics put VRAM at 0 when
+	 * the iGPU is enabled which results in cursor issues if
+	 * the cursor ends up at 0.  Reserve vram at 0 in that case.
+	 */
+	if ((adev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
+	    (adev->gmc.vram_start == 0))
+		adev->mman.keep_stolen_vga_memory = true;
 
 	if (amdgpu_sriov_vf(adev) ||
 	    !amdgpu_device_has_display_hardware(adev)) {
-- 
2.55.0

