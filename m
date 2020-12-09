Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5396C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879DF23AC4
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 15:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879DF23AC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399B86EA8B;
	Wed,  9 Dec 2020 15:29:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC7B6EA8B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 15:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uaau/jGmNF12l0Gmq65vjwkt2IVtMp9UWU1Ijzea5YyZz8u1tmnEYy58XVujgsW7bbZHfRb3UxAEGfm9UYXabxCiJ95CDGaRqd/xKfec5fJbbXhhpZcgdaa/mHwpgGvWb0O79IQX2VS2u1ZFNvOERrxtcdki2uYB2BypYiVKczSRdxXTQn7FYvMdv4w+d7vCLtYkTrQKpS2LGTr8iYnOu4s/dvDQv4gJZDOfjo6jVF2iv7DccQF1XvVJM6ZNVpE2C/fYJjm8z3R42TI4s9tyeNfviuvta3pCwjHhVsKdX6ePG7lDcE7tqOGXCZ5ZRqND7SAXmKe5UNOv5eId0NClcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY8Z/MaQerxPinK938tBX0W3dxtkdRAULPZAk2Zs8NQ=;
 b=e7rz5JpnxQ5QWxDf0NcG423xDzgxgHSa+UXtSKra4wyHz0Q1c5dg5Ndplo2pYzq4cZHzbHE4J67dtrlSE2W6YE3uYJxSYwKrYla1+zsofuKJ7VTZvHbb8iKCc/At1OJhUndEbjrcuQWbPZ4MjH9YGUGp0dbVnmxWTPfuGDLY1JQdJQSJIwCGjwz6oWqP+TaIQuKrR6lRJg/XQUOPfPpgULwKcjUVoK7M2CnZ7nDeDwEIknTimgTneTTPuHE83KEHsNzi3PGFTanmSnEhiVmZv1FNacNcvItg//MIckgI0kqnZylIgHfMWSbHJmtCOyo46pBBRrmBOcqLIAf9WF6H2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY8Z/MaQerxPinK938tBX0W3dxtkdRAULPZAk2Zs8NQ=;
 b=x0t7af97IvWPsJB9rhetTPnTXycEIqDUy0+PLHHBNnX7u4hUiNof/N1Q+MLYF1dXtyzYUOGxzC3/8W6OF8aSiuYrvWuJfGCRGK4ZhPOtou+mvMdaZPQbYu5xovri0tAU+AEM3ta4mCi6ru4KKGCRhX3ZF4BVyZCoKi7MKhLFCpo=
Received: from DM5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:3:7b::17) by
 CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Wed, 9 Dec 2020 15:29:17 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::4d) by DM5PR13CA0031.outlook.office365.com
 (2603:10b6:3:7b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend
 Transport; Wed, 9 Dec 2020 15:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Wed, 9 Dec 2020 15:29:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:16 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Dec 2020
 09:29:16 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Dec 2020 09:29:15 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: remove unnecessary asic type check
Date: Wed, 9 Dec 2020 23:28:11 +0800
Message-ID: <20201209152812.3215-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209152812.3215-1-Hawking.Zhang@amd.com>
References: <20201209152812.3215-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 411637ba-09a2-4500-7e8c-08d89c57313e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1606:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1606DD3187729BA0E008DAB3FCCC0@CY4PR12MB1606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Skb3aAEk/IiC1ib9IjA9KN1rk2pw1UI1rvCLlAmjAkZUrKIb55zRfVEoUhazyfxamqjyoHkxedvL0TUj3Kr3FEcHrkwwe8DKe+zmRJvGizWHpnp04ONmL0lIuEWc9qndblj3URWojjvo8K6ImaCL04wIXoGn+eRj6iy53KQ4ZBzqbvRPGF/IsIQbTB85KZqZD7AU3pp/RcgLa0H/wHyiAnAGkJ8LXRFcVxqTeJ/yg75QrOQfDBytQYkYzJKG02c4DHsFFMRqla5qlXxjxM/Aj7c69/ojvUZXfy/HVmr9X66tLhEoLUfbaT/6BH0J3nyEVnT0Bb4NfwF8s5jzYMQQblXFdEcyJ55qCwGxu4uhazZgsqciVPtSJSU4Cejg5FJ0D3EVzebfE5ftctfc/OwlSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(1076003)(356005)(81166007)(70586007)(70206006)(36756003)(2906002)(6666004)(47076004)(5660300002)(508600001)(83380400001)(2616005)(110136005)(426003)(8936002)(8676002)(6636002)(26005)(186003)(7696005)(336012)(4326008)(86362001)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 15:29:17.4212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411637ba-09a2-4500-7e8c-08d89c57313e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1606
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The number of crtc should be 0 for ASICs that don't
have display engine. Remove the unnecessary asic type
check then.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 07126b2b46c2..f34d39e43ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1579,13 +1579,10 @@ static int gmc_v9_0_hw_init(void *handle)
 	gmc_v9_0_init_golden_registers(adev);
 
 	if (adev->mode_info.num_crtc) {
-		if (adev->asic_type != CHIP_ARCTURUS) {
-			/* Lockout access through VGA aperture*/
-			WREG32_FIELD15(DCE, 0, VGA_HDP_CONTROL, VGA_MEMORY_DISABLE, 1);
-
-			/* disable VGA render */
-			WREG32_FIELD15(DCE, 0, VGA_RENDER_CONTROL, VGA_VSTATUS_CNTL, 0);
-		}
+		/* Lockout access through VGA aperture*/
+		WREG32_FIELD15(DCE, 0, VGA_HDP_CONTROL, VGA_MEMORY_DISABLE, 1);
+		/* disable VGA render */
+		WREG32_FIELD15(DCE, 0, VGA_RENDER_CONTROL, VGA_VSTATUS_CNTL, 0);
 	}
 
 	amdgpu_device_program_register_sequence(adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
