Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F7C44502
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F6910EE1A;
	Tue,  7 Jul 2026 15:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LcfGs1yP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB5210EE19
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG8cS55G7cLo24F52+w2IW95Mg9zRCeE+V8W++pORNfk2IVSV/bSwoXTutdUtFXotUCDu2MI33IBff5ga5zsDsY+Y7ZNidYebIPhwlDZBtyfCDIWUf26hMkwHYDX2J8fxhd3OM1L7GQRA1flomqwHzRBTDGCZCuZIMa5PK0RC/uawJQya2H12wspBa0uBiEswHg0TDNIpYFVf6r+mUG/ivl3vQopZ+b1pGxcF4h4NGL49gXWtdgsDPWpNdmdUrKT4BmiwBX6XoMUsndJbb6TP8zZclTnvNJ2MDWSD95zuo+0GhrsLtr8jByAhi1GtQsEh5/UGbnwdreqNUuKAH4RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4FA+Eabnrw2523i85X9rES6LHFCSOY/LFSGuuvDl0g=;
 b=HsMrBKkWlOfbUurI0FSy4PLocZD8nIBI/IZherp7pWdl4bdQFtpmobCb4/8u4U4tvfz1HLyq+BvK3lZOBg+d22i8s524ObugEWgGUA5z2TffW78E+aIfRqopDvMZS6OAc5IOzZucN09497vfSkJnxr14uqQzXE79P4LPAaicxShk90/s8ZEFhCHd8LI83Q2py72rpdj7lsrQ8KPe9+6Pj+ut5IZoCHVzqbsiem8XraXQjnE1xLJ/xjB3+KHujtkXueBcQ8Gld8QXaZoecIpRtUa1AzjLshwRlew693uWKkk5Cf4MoPkcSsMYMTYqf0mGZtlk5k55LjeTaT5AgIIkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4FA+Eabnrw2523i85X9rES6LHFCSOY/LFSGuuvDl0g=;
 b=LcfGs1yPppAg1c37+S4b1c6yhZFnbJOkJXxacJMkpTbyibd6x/hp7mEdGBJQbuPP56VUtPA+SiUMz+eyBxIbBpMwWLWUFombMehdmipGKDzOGqvvrbp/Aezn0vLZNI/Uozi0bHQSIrqrjYTMXBUDuBT9/N+p10znXambPr3LUlc=
Received: from PH7P220CA0045.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::17)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 15:42:27 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::2d) by PH7P220CA0045.outlook.office365.com
 (2603:10b6:510:32b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/30] drm/amdgpu/gfx12.1: WARN() rather than BUG() for
 invalid SDMA engine
Date: Tue, 7 Jul 2026 11:41:37 -0400
Message-ID: <20260707154203.2603209-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: c1e66de6-e0d9-4039-f2bd-08dedc3e5674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a0rz4FQjrPyMqtycVbjmukGJdwwAKg1aXlNtE4ly/c3ZJUymbEoXLB6U5HhR7mo0f8oTmtqE264KDOekYbRjblL8ANqGLqJ2WiwKgSGvsAsrqluqwWJErkRrw4Mx+PuSrdQtAUstsYZDlL+BVwYubTR0utbFhox03C0ek94uiMuUkUCidMZJQ68/7XtAhYXkOL2/4RB90CT/EXs/RVYtN+txHfPmpXb0bUkkwfmOhw+5JG2Lm0yAuKrHMV5kefHJXdQaYO/kljAjMSPnQ+ssP6jCM59Cwrfeys2j/FQKlo3Qajn/bI3If/23OPEPsgjWKlo6Gd3DlBJ6dvTxskXZzaoFaMYoBNM2okz2mfNPtcO08ZyzyxflCMgw9eXqL5kKYQoxTMc+QIj/qDqSRZt4fRdgLS+pXLbHhscduj8wis0yBTha1jjJZFOSpTFMamASKgLm0hjiWqLJFqh/6w4irqcI6uF5rH62jGhDvpVzsDz1b/C1HgdoH79+HRylbo4vxyaWr4Vytp1mhnPlxIl93gwIBUpP7iHVY4mOJrBM40O52HXEaA1gQ4+bax1DF55Df2yCJ1wh/3SxHGRRJG5MZqYQ47kH3JSrxJYTR+kMISwFI96P0LHClLfPr3Q8Cyfmg33giNmhvSPNCpt/tyfQm14WG8u7dhWzjognjJdg44pPWIgv4sfEanPiehQQjDS7WWSLjxhJL+nwWsiDGOwCyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZPEjguRQOWfYYw/UG0RY9B5VlHftrXemORzHe+qkEhAjmSzNIxm4nO9S1nCAE1RPtsasBa5KmYs2Yc+atSNsqMnwuPWkfmccAI0zd/fmYTgOlwyGx5sgjoKfAf1d8VanFjVvuB5Tl/kyzhs9RqRW8kiNkQhyIaORYYQQLfOXfzdp9OwUcYn8cimMqE9IyvWtUS15R56vm5ERpDV3tUZv2ZZwMqahnuQrYXc2eVGv/cRQJzo1smM6JSA1iv3A/5PwMRV3S/kY8LpEGKz8x0Ob6rPlaNEmPcgCbR+LnPWHiJOMS49O/9LuNafsJvIv9UmN3Wp0pyAKedV0JDh7IcpMlwDPdJduJ2Hmd8abaGtuUlva+FByWqADNTHZYv/TVb0L+ZQZUtV0JOfx6Zh69sD2DowY0i5l1ycGp1jgbD1eOgM4tyIDk0SpS+lobXhzrGNM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:22.8937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e66de6-e0d9-4039-f2bd-08dedc3e5674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index bcb180f9d3ff8..38ca1aea33b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -93,7 +93,8 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				regSDMA1_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
 		break;
 	default:
-		BUG();
+		WARN(1, "Invalid SDMA engine id %d\n", engine_id);
+		break;
 	}
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
-- 
2.55.0

