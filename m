Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68517CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE6B112DE0;
	Mon,  1 Jun 2026 05:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TkJviaDY";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2CC112DE0
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhBEvNEVbowTfkD06EDmh6W1ilrXi/5YbSEuxoMK9/gBG/JCUbvl86lfsVDaJmI2/tu0Ajo+uip7tabsAtwF8rd4TqP95/catFY9RdQw8bcKbLNg/AeKZrZMHO4SrzX7ZlEtGdccGSRixBlw3dENGTiCMF835cWeefcIWuUWI8LMMu+AjkhynVgYqXgTuByGqnJdjjawimfAPLVVdCNvJnvXQTHyqR7vBGwR0aF9G96nlhQKf40c62HIWb0b/laHaOtwJLT6s8NvfTV2bSC0HG88U16Xl3a4gWUQo+ydwvDXTj3zQ+JES1rqEOmIKr/Ps2mj8Frj2D2h23+YssVziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWM8rNDAgMu7Eq7dXeuLGDvOMeZn5Myb6ENn10UPNFc=;
 b=vbeSaJyJegwtY535RdQ1MlZ6qAyW+ij97YrNa52BuCOP7rEr0EeTZrofTsyHuLS7VFnR7VvwA25LmG6pVF9gYl71/lUBegzABLbBb/uiFqx4c0QoWVDG9fcN8lmI91u2+O+9Ysr+5pBLL18dLYgQpVAbifRnbyqofHBjlfq6wpgzs/E25rzD0BQb4BBT88uN63Qsqm+Oo8AOBg9yx/ZGZELVFqxgsnL7Xt74LdhZrk7nmOOtOtAzfAXEQZzX1l6VN0HQEVKa33xrjgBSxAzeNBFVoChDkYg5Bbjfw6ULCWZcbcWmZ394Rj7FBzSLMDExd73/yb2R9YyQ9alSNLCbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWM8rNDAgMu7Eq7dXeuLGDvOMeZn5Myb6ENn10UPNFc=;
 b=TkJviaDYMHJxEaOEozeDjBz36gi8lBYYbOUJltEKxum1Ihx8NYuaCe2aPzCAmWsbzrL1sEZMt7JEzxFnZBNzvxjDVc9JwDHvpkkZ7+d/mRbsjtNZN82DqV1fsEBxfzxb8DuQHd0UUH5LSLY0MVXfYuIqkvdAMffoHtgjPEJxG2U=
Received: from DS1P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::17) by
 DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 05:55:23 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::21) by DS1P222CA0006.outlook.office365.com
 (2603:10b6:8:454::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 05:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:21 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 39/42] drm/amdgpu/mes11: enable compute MMIO pipe reset
Date: Mon, 1 Jun 2026 13:49:25 +0800
Message-ID: <20260601055034.3700921-39-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db93973-c9f3-4f74-ce9e-08debfa25f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: d/+8VCxmwtBUzc0ZPNHo8XL/P35Ncl9WKhBJ5Z6gA+KhMCog7lhI9x9Xuo9DIr42t+aIQ4GAXUW5YK18BX1Q5JaDTn9lDtrijMQJTP83rMqxkk4ZsQ53aWK16ecl3ai+5Db3WsSLZtzE9z2/HVhJc+5mLIAOy2eCpRMFFpmqa4YOhbOQ99vg7Ok842iH8OvGa3tc7HoHBCTFpIwYPJ+ETFCmv2hV7vshvKlKdooEtCttREK2UPRae5NLHtDvhA9ltUaZbDIULAJX2vioeD5I4pRh2A895GNOmnDK9OQze6WoSwH0Qwxdk5D2fQin+FmK+ebl2iJVFqc6jjkozv9tG6fC3jfyfwHeSwWZEccfAsXS7ZBGXsMsEntP/krmcJFfhUqCYiIOP/42tD3j8mCgujPa4A8CI+RvipQm3o7kxsYPkV41fFVg9W6enVNhMzugCSlpxeQTix37IlTOVHvafCnaxBOXTXACgturPp8aIDoelEEVjpHResSCzdKitQD5UNgK0gA4ZAw+TtvafcaPA9Ei2Zc0tmLL0vRR+StCmCF5uSLvZ8tmaiA7EagSH0qi8EAfQyerlU1HroGoUs+HN20eduKN6TiZBgzNxzozA6wFknd9t8HybYTS74wJDEXJb3CHLgv7dYEjO58W5FbJIstFLzI16PKLv8kWKO7kwYV9VFPVVjFJqlttgRI+DoAn4JWsXHvZoMz2TVM/HILo2BEiPD8rR/aSFb/YrJqrMlA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Udle1LqOrtR1uDVet+o+seLMcPPxbj8rBeLoWQZ/m3PC/TgbzTDkE/p23I+Au0KtlVqM1tDgQ2lb3VFSLM1n3Oy9IJFXm3ECXtoWufYRqQr7TYltPooPWrzyuezS4ga+HV1w3T/sslqqoVu0scbf/NcNTKXJBadiOd0iBfnqb33S8SUeZlArKhoDEQanKUKo2/Iv65QhDFnvzmtuzecBhivsbtUEfq8KSO1BTcM0pl4rN/0yNnyfjFbbQPBvqK0czXt2vbLmva0O1eaTqtnH1SAoNgD5fhDxJjLzK8tIO/BVOzmVKbrn93pcAGAWMXIauVd90NKMzUKkjskDgA1qXHUZXNgvl8jHiTrHtXMuYvsqDopl0Ovv9Cx0zamSCRQIv2y/YiQJ/7UDbI8Krwdh0DSNhT1Oj4mQB99easb0ZS2N8NmqpBIumbxn7t1WWt/z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:23.3448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db93973-c9f3-4f74-ce9e-08debfa25f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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

From: Alex Deucher <alexander.deucher@amd.com>

Enable MMIO pipe reset for compute pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 9fe8bbbadb4f..ebfb80e80890 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -477,9 +477,6 @@ static int mes_v11_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r;
 
-	if (!mes_v11_0_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, me, pipe, queue, 0);
-- 
2.49.0

