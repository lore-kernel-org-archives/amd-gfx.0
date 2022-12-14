Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A740BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 09:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F59010E39D;
	Wed, 14 Dec 2022 09:42:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF2210E39D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 09:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmP60hQ8IFH9u21Vjrt0V+ltvk7ISwu638uIAj+zodM2h/r3DXh3ImDQS9/a4QRX/2FXHg7KAYbtyVsskP3stY0P5N0pT8+v4Ev2Vh0IhfctjPzTqbElLuyUf/xGabT5+Ivbmqgj3CRpo3llXfCfAm71s4q717UF7X4tDhL6FBTdR4drPF59DAb/UsssEgz79IFfRF4MtFFqgfzkh1Lb4d1+rxZ749oDukirqbCsrOZGCcfnBIqXPBQktpuemm8Bq0GCry1S3BGkM33Vk0aqNzlogWMtvbVvmb/9voN33eA7hBKvGNZc3MCzTe2ii/8li8dSI6Pr3ZF5w25jwJE13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gna0OgHsIni2DIEOAfUOmqCwD+P1Zscwiss1lJ0x1UY=;
 b=hCay7UHNl/wPZrJwyhM24utIfVcanqS5GFEOSXd2oQyrybko4g1RnJ722fS7GzYr5O28WoHQUBtbSQx7B5MvR4XxXv8Nx5/oc7SGB3gjGwGjAF55jaZwJi2Tg1mEyyZRMr8d3aHrOvwiZ93TRO9+KH3Mez8/k1cw2AhOAXcmaCQmMMxiDVU1zMtnJcVeFn7uGG+EtKa4JfFrwSS+G39nNcEamVC2F52UAwTBmAaWzgc4cWMcUZwANkX2zgqTwo3ULnfsNEbkG6n7l6Y8d27Odpvfguab8N3ZZa7Mx4XkUN3SWGMHA9kZtwENJoaOLp0uWgdwoHAS53RIO78c1H5Fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gna0OgHsIni2DIEOAfUOmqCwD+P1Zscwiss1lJ0x1UY=;
 b=SijHBTsFr3b0rifDFXl5AcodvBawaFApS+5ZHkcARM+v+LlLzqiOWcWepfmqKSnx6DxROvsP/I6bxm+4R8k7MV+czmXB/VUY9ogCCPuKwwkK15dDLm8Ea7qj1fXCrFFylyHpxmD9nZycBKXEjZim3ma16ZuKEWxM/1iyRI6VTko=
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 09:42:07 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c8) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 09:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Wed, 14 Dec 2022 09:42:07 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 03:42:04 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: Fix size validation for non-exclusive domains
 (v4)
Date: Wed, 14 Dec 2022 04:41:24 -0500
Message-ID: <20221214094124.160353-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b04650-fb3a-4f1c-c68d-08daddb77708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlGJDlwxug57kLYBx0I1fbOvWfZjI+KSEbQtWakrtsVhhf8LMjEVnnUKFRNiKS7oUxjQN/1NzPNEW0fXfWJWQGpLUBJnLvUzqK+HmDyi7wAuZDaPL+9FuuOAdabkSdJ2zku0lzlsE+uYT3gupg0KLreFw6ZIYJ4Nu+PJ0ES9zoPE2hJy9MQcyUKaw9RtmQSSCvyUYA+MCSD88Rmy5RL2MNph69yJF50HRadNYYoFZHk5ijMh6coSPs2AYCG/US0FT0vkgHXUWH6UHTl26KUlXeVOsOA0Jj4bstzcNbPgSBK4/1rOJoiMvFv4FDjLLEP5MJY2+e0ui17d8KPyS2lHhGWgjWSdDehmay4fKOrEpiYkidRDsiXhUpjVhWFFIEdTStnIB1jTdOmSZEzWKBqeFw16l058q8gU8e9Mq+635jRbAInN6sOeQUa8+4qFfczsoFqsaNtoBRKAZQR6YJeauE8SEM7j5lXJHpUdMfFBWtqS99+tVpfvidlQ1XbrItOTxIvjCd7NvgURqFOJi1nN+sd1+91f8/QLw8DzIPfTl+sbbUvYj3BaUGHWpdPBGHbxdg7tvSp/w3MiQE+nzjNKKlcKpTRjlXBMS9U52h5HMqSqclngii2rEBKN0eMDam1xadsekXTzJCSkVp90WB+iZCrDf8Y8z1UEDmNQ0TdO9WcuAC0kPQUE7wv+XE1oBwFVMz9ES38eU9AoRdsc0TH8gWABCQKUj1lT/JpZy09yJEo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(83380400001)(336012)(1076003)(2616005)(16526019)(47076005)(426003)(40480700001)(86362001)(66574015)(82740400003)(81166007)(36756003)(356005)(40460700003)(44832011)(316002)(2906002)(8936002)(41300700001)(70206006)(70586007)(5660300002)(8676002)(4326008)(6666004)(478600001)(7696005)(186003)(26005)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 09:42:07.1695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b04650-fb3a-4f1c-c68d-08daddb77708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix amdgpu_bo_validate_size() to check whether the TTM domain manager for the
requested memory exists, else we get a kernel oops when dereferencing "man".

v2: Make the patch standalone, i.e. not dependent on local patches.
v3: Preserve old behaviour and just check that the manager pointer is not
    NULL.
v4: Complain if GTT domain requested and it is uninitialized--most likely a
    bug.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb1f..983a12cac329a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -448,27 +448,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
 
 	/*
 	 * If GTT is part of requested domains the check must succeed to
-	 * allow fall back to GTT
+	 * allow fall back to GTT.
 	 */
 	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
-	}
-
-	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+		else if (!man)
+			pr_err_ratelimited("GTT domain requested but GTT mem manager uninitialized, for size: %lu\n",
+					   size);
+		goto fail;
+	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
 		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
-		if (size < man->size)
+		if (man && size < man->size)
 			return true;
-		else
-			goto fail;
+		goto fail;
 	}
 
-
 	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
 	return true;
 

base-commit: 84abaa3a855571ebd4e57a7249b867a2fa3763da
-- 
2.39.0

