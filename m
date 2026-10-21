Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC0606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NzH0g5T6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 502AA10F96C;
	Wed, 21 Oct 2026 06:28:21 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C803710F96A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT7+A9n2cixCKEFGBcPJl1wYiO5Tv4Aql9EFIypK2S2O1AcMniCq/z8x6H2lF2dV+eKJy4+AJdzO6xPMjXEWKTerqTOos8hLs1udZqnOnYpQ+OcpKRi4THdwXKz9mKeu7hm5HM6HVfvW/RnAmiJTCqbP8Edvf0z428gTe/9vxR28OOKfDVNYH2zrn5yNsiCVNYXMfv/n96D3cCrpIsMC+zuwil/bp9qwAm+5fXjJVfIijwO3qN1h/gMj/LWq25GlYsg91QouprKMgCk+8HcJBhjuJiLLJHZIDdi2oN6WzeBvz167akTRFpKoZ21BMB1AQrAHZp7vVXEs3cFGvzywIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idMOr5TOkceZ/b6jD7dpOKtPOgAhUEt35kBjMN40dEs=;
 b=PN5M4yuEaJYU7/T6bT32VjBDFii0V9GO41aoICK2yVrTFqLkVI3uw6xsb+FDz1emdwD8WUU87ExTzgBfYoYkml/Ic6XDy9Wwf6+Av8t/x+M+JMBdvWuBeyKscgX9sXWZhvfOgkgZwQlbs8l/soyIJNKv9SOGdaNwz7aIDXqQ+HupJ7fcr397yZ+twW57FryuJXulSs9iyAFnFDm4dGv36lZl1ASg9Mx6SFqTxWM7HFZfRbHHKK+Lrckmz44rfuJjKvbUsIY8am/qjIGeY3OsG2jheKAVtqflLco8xSH39IMPVJ5nfdGKvuFY/XH4TqXtvkO20pEEZJ+XHu6f5L+PCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idMOr5TOkceZ/b6jD7dpOKtPOgAhUEt35kBjMN40dEs=;
 b=NzH0g5T6jOyIUkUjC8xQeNjVp1EC2VQzT8Y1IxNyaA3/AUKzwqZYqy7zIq1kvxUgSScjzQ47NeYCK9L83drvnRr/zMJ6K49G/QcbV2mX+vuoXU1ip+PI8E+KdgNmVzl75YjRI1QOto47VJTxxLl8cEB8r4R5lAXP5D2ZOuaq9ns=
Received: from SJ0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:a03:33e::14)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:28:07 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::31) by SJ0PR03CA0039.outlook.office365.com
 (2603:10b6:a03:33e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:28:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:03 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 43/49] drm/amd/display: Drop single-entry kcalloc
Date: Wed, 21 Oct 2026 14:22:49 +0800
Message-ID: <20261021062519.674697-44-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|DSWPR12MB999128:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c43cb4d-d274-43f5-b945-08df2f3c784c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IvIS8LKAXe6FRsxU21o9c0c+E21td1w6p3oylNQrz7nGkMN496qNRV6vCO1aY1CKDTGLu6AhQSB/CbxXKc2ErCKy4s0dwHjNFHJU6c6inuPwtDxcIaTl9NH1yVbTSCYnQ+Y1rHU/Novbj69iTyOhvvkn414DLECjm141McZ4xYQnNNAJVBPLBvnxNztTi5bZjWRh32qBmHrv+lTQi8OBxSfvzT0UlkIJ2y0UPqDtw7RHBycLknTpU/CXFHKIaX30OAsaU72rT6EHEGS9XmTs/CwbSkoGATs1LHuhinJsPq09SiVqK0os7DlYUANowECX1e0cVzLK26DWQijfj6OPY3F0tw7qnVP5Xk58yppbQP9AN+BvIKC4ZGBPB2bXFL/ifohk4dxVmwIaiLkMcs4S6FV2s/4XQUjvI+dswdStA7LVYK4k5ekqRJM170C7pIbYv/sV9WxfKI+mRpfEl+uIzx54e2qZeZ97afeDG2SorkKUDFt68EkJeSV4KXbQj6qu4PO9s+Ze9ZhOuc1Ozx440GJZq7SaIXhPBQCnPVsjYmVttxS+Ft9B4ejDYpndi8vzKwTwd9B5GNjq+jAQYvVfOC7ChOdxip6DRS920URmXITXB6EvuJOy2WbvM6eu6ktG3niwo4rk9I3NZivNXc88Bt99zZCVCtT5O1REMMHrw9NId/hXr4yj4UiHgdenKNv9kn2SrxuT2EHTxInP7ccYKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xT8NA6bCd2WImisyS9Pnqy6ohd+8sY+LXLxG4E7wl8ZbGadSqR8Wd06K4Z+tm/wMEap/Ip4H0ILDko7vRLeECp8jYE/bd0am9ksfY7H/4kU1z1r0zr4gqdAzmLRwcPBVjsUJ8nUYbEt9PCQmLm7jrvFoixzQVuwyacQ0ODvWtFM0veTXhglUTfYD1oLkJetVLk/114u65ExoKtWGXKp4zBHYUKg/IIsv1YuQ6p4TnEwxJQTs25u/9lAxWAcmoZLNv7JzvB/mDxI5HE+VVUZfow/NY4Eu/pgYViMy2ydn8wSewa1IWJbMRxGUHopLKruM+SFsanZVJmbycGlTBOLcVZZhAqSnusMA3EaxENM3s1Cj42ggRiIWSgEFS/CNfZRU2EyALwZPkhrGrOUrtM/HM9T0Z2vjKU8HxZ9Bwu/YRObSVFV5n6HXLO6WyYY1HL8I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:07.1724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c43cb4d-d274-43f5-b945-08df2f3c784c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
The color and connector tests allocate a one-entry array with
kunit_kcalloc(test, 1, ...), which gains nothing over a plain
zeroed allocation.

[HOW]
Use kunit_kzalloc() for these single-entry allocations.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c | 2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 8c2f7ab5f8d3..4debfe3b49a4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1871,7 +1871,7 @@ dm_test_colorop_setup(struct kunit *test, enum drm_colorop_type type)
 	KUNIT_ASSERT_NOT_NULL(test, f.colorop_state);
 	f.colorop_state->colorop = f.colorop;
 
-	colorops = kunit_kcalloc(test, 1, sizeof(*colorops), GFP_KERNEL);
+	colorops = kunit_kzalloc(test, sizeof(*colorops), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, colorops);
 	colorops[0].ptr = f.colorop;
 	colorops[0].new_state = f.colorop_state;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 0c678471142b..a2ddcc2a53a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7398,8 +7398,7 @@ static void dm_test_conn_ac_bind_crtc(struct kunit *test,
 	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
 
-	ctx->state->crtcs = kunit_kcalloc(test, 1, sizeof(*ctx->state->crtcs),
-					  GFP_KERNEL);
+	ctx->state->crtcs = kunit_kzalloc(test, sizeof(*ctx->state->crtcs), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
 	ctx->state->crtcs[0].ptr = ctx->crtc;
 	ctx->state->crtcs[0].new_state = ctx->crtc_state;
-- 
2.43.0

