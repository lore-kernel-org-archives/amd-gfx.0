Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E3AC61DBE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7656D10E87F;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cr6IzGAw";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF94E10E86D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyeTJeNGuX6SkiV9vzWzyzPERn6FX4sSC57cWbg0lXHxUTr5iDmwM0mbFJOkDjfE548mWffbbHr5vue/8R2Wr9I/uAyPKxv50M2uEtuUjOyqWnpbMoIQ8ZKmbHPP6ed9H2XhWGDw8dGszdJwARy/vAO+OP3pj5atbaNJRO9nCI43ktBNoRkbliLSkw/tpJSpw5qpr1+JL10VhU8z4/MPPDGLB1mjVWUY15T5j05FMHBao7krmi7SPal3Ct/P3MZMm6EhxcpH/i5qcA0SMavoCltvMDH04b0waKVsDf86S4cVRTy5vCf/Mq2fbeQsFrf/LF3dJney/bNfFPFIs9wUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=053jmGdbblWwKto8O4t8VxxHtKqHgofC/WpsQCmmzZg=;
 b=H6b6n/Cnc6tDSCuTFbPaUwI0NdC8RkLm45fZOJp9LwgJ8F57lmA+N8L//dGurquD99LVHvuirB4dDncl63Aw0ctUO6H1ag0T1T+JSRE35XIfXsk5tdbkv2FibdLcDY/YrPIARl3kvTzj8bdRfYI4N3zdy9u1aXR5J+an1NP2x2Eel77ybkAEoDacyr1bEDGvEbGniYW8ah/qECz4YUe3L37BdjAnlaS7pnyUUxCDT7cOa6FbD/9lO5qqLYM6mPIlcrpprvevJeWW9m7BwwFVB2zc1ARMJAs3PYbBjiDeu8vEW3fKlK7Dzn1ehEeC0Q7XsFmR6LxHMqxuHyVoSuWmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=053jmGdbblWwKto8O4t8VxxHtKqHgofC/WpsQCmmzZg=;
 b=Cr6IzGAwEMQst8MuT0vzTp7wSlJs1Lw9fn+QxZCZmcvJ96u+zyz1O2j8pXbTHoohB3SGKVIxlKvhn8E9RnzLJ8fDTjxPO2S0AC/epiLgneRkW/13ONAgaTpY2/+fxAe9vGAbwGvl2MD7xrb9rVJJVwJ0aCwd0mRRMyf/TQt4gqw=
Received: from PH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::31)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:20 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::43) by PH0P220CA0007.outlook.office365.com
 (2603:10b6:510:d3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/30] drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
Date: Mon, 24 Aug 2026 18:13:48 -0400
Message-ID: <20260824221352.1793542-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d08c43b-72aa-48ba-796f-08df022d0b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M4XCuGk2Ed1r84ZustaUCvoT/n9kV1x+5W3dlMJlDeqyhxLLudY/Mnd+p8j+bdlFkPwcAhPMfxWZScUFR69JyhspsqkGhFSZVyUKiaNt0fcc3OUbgdziJS/kw3vdqBO1KTqEXBk9Am3bLSKSQXbQ/U+z2u18vtQjNLyvvD/iPZxNWk3BnvQ6S4BTXwqExAdr13+AgbXgvtncdKHvslfe5m7dq/l9JNVpaCLMcD0E5LdnYr97tzBX/5qrae0e9wBqZo2BFYI2kfd8rXrT4DBghZDq/39a0+5Um2V550xPNVCkPKuxZLZ8rxxpW4eQ4BKSf7mHquUrQO+5YtW+FgiYzQ8eGoje6OOzCzNJXrirCPTrZD/ubAXeXObYZIhdmpujCb169SYlyibv1euRw9FyN85364jKK0/UOltkdcwouHqRWgzzU0cWnl19fSG5RJ4np5KgadF289xo4pe+HAscD2pBjXjJcM7FNHLT71q9bM9SuxYkH2u2/AlT2onu5pbRhO5B0ThxwldLmDLBVSpRVuzRINyrI9DyzKnEShIybpCtHfyNO4lb1M8oScb8nQqImSt5dgX7LQJg3BkcHJHNjJw1mXEztdfTBcakE+Z13/RGlCzAQ9cX8Ks0UvGfUTwTjSPyu7/FDoF8J0pWi64294FYD5S97y2EU8TmQ3Es4QS1l5eEGDmV84JxpKKogl/qvWzZvk8j81zjZe4YjD9k8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hEKmsUWR92Sd7raI3289onx3R7CDTzSurBjFlEK+TGsfQcI8FVo5TnuuImk1us6zqTfDTbTpWo+K+09fH63dJzZc1QWNajlIBVbwYf92wBBt6gzrg+/gAIJInmro15fzNtUF4E8Dkk9/yOgrQ90K4j/I38YPMJif4A1aIfCOcvBFpUM6RWa/VycVaGfOcWzal7l+sVIRSWDTQJ93CPM8lfF413nqnP4Q5b4tFZ/ssyoM8GpPtxOmK+mUGcTXP8UGbKrojY8lVVIf7mP5Sgy6qWmC9EhOTqhb07j74Bal0netyLaSYcbQS3AL1TpzWuizsGLitf9IbGkjXKquGrSHHBi+4Oa6BF+MPfNa1hsrlZCj1cnE3PZ7SlYOLkXmbUqRuIb1YKjBUtpgxXlMXrMdfGqDuMcC1u0dvlXuNPkZIojO5uMkaSItJAgs2bhGF+0O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:19.6018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d08c43b-72aa-48ba-796f-08df022d0b4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

Use SDMA rather than MMIO.  The avoids the need to
disallow gfxoff when invalidating.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7eb34d55565cd..e716a86ba2913 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -974,8 +974,7 @@ static int gmc_v10_0_hw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
-	if (adev->gmc.flush_pasid_uses_kiq)
-		adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_KIQ;
+	adev->gmc.pasid_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 	adev->gmc.gart_inv_method = AMDGPU_TLB_INV_METHOD_SDMA;
 
 	/* The sequence of these two function calls matters.*/
-- 
2.55.0

