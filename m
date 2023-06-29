Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D28FEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 10:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA5D10E0D5;
	Thu, 29 Jun 2023 10:01:16 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2520F10E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 10:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDfLn9jW5g+yIlsh+i/PkL2OlH8HhptjdelC34NTMl7HaJlXiOoDfEEY3c55ZUd6As5tMn3vKXZYdBIsdJ7D/ltzKbRvtYmbQ7MpNfletWO0g+ka0IuCMwhZqPM3CrT0Xf06yWkP/Fc2XJK6YgcUHb6L5ipqcNuQLkIHn1AqH5L5IAPFtUkXK527Ttbq0mLVlDPgX0CaODts+i+XDuCuwXQOUKkaCfSHFln6wykvQnAPNWcHygH2w8inbwoiOgSORTo6nHUZ2JCkcEFY09hyjxS4taTrU6fJcLfDe+27gE0ExMeH423EeMdJrz06KBu28b316c1ylhe/mm+kDbSxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksLMYmJrvgAS3OKfJMBPLnCH2trF5GTn8sMOjlCRz4A=;
 b=KfBMGZtPReLDCPJ2Dcd3JccCdxhPkAwrC6QWTC/dyiSA5vF/tUAZZoZ2arnhclIGIvzsf2M9Pc9if1ESduS7lszXZ0wobUbghUosxJyobZKMLinBSROhjRMgwN/f0NZmFeI0foWIkpJIfw9yK87LEsTRpeQrFj80Y37y9rvEF4MDDTvbZ1CMwweQdWnekM1vJLAFsVZcvSqswxVH+Q4kKJRjw+nUaPSt8HYS+OCpq4HaWqATUDgYiOU0IilMogBwLcXDMopK0CAKyXsCuoV+hPjNKlvEY4TMKu0d1miGLdR6Qo2dLDQHW6VHTScofnYGWpZTgDdjwG/sHbIeZLZ2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksLMYmJrvgAS3OKfJMBPLnCH2trF5GTn8sMOjlCRz4A=;
 b=MX1iVza/eWgjXCytHtUIscwRNaiOHu2YMXhtycbkzy0l/tib5iDeL6PYNjFoLeIWQZUOjuHIrCn3cCVz9sA7SerNvqJcRMzxlWPyQ9o3Doa+5MNOiL6QcVWA04/N5j2KPDw2+MAnX/4ny8qHOaB392h5WuuxqlMQAj7mXAKyFwQ=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 10:01:13 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::98) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 10:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 10:01:12 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 05:01:10 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <candice.li@amd.com>,
 <hawking.zhang@amd.com>, <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip address adjustment for GFX RAS injection
Date: Thu, 29 Jun 2023 18:00:56 +0800
Message-ID: <20230629100056.7516-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|MN2PR12MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c1ca47-6b09-4860-2856-08db7887c53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k12GSBxTvH92tIpV7LLJ2zKzLNG523c9TndAQpS2vC/HdDYrAcYwfpAeFh+3R1RQaNd99IeXZzk+6q1uvCkILNn/4ZgA/B0O/mA0/cCSaDF01ns6Rc2fnYgIGAFdZ2vlCZHHwKbToMhy2SfbxEWSeubJo9ITopzJ7MDjBWSAmNJ9CeQR2Np7gsdB/nS0I4vgtL0yV4dGC9Ne0kMVlhCoM9F5A+1cdIUT6WFsM1HOP84zucCGmaLOFFAlyxH8c93foFzLYZsUcCWitojEFkYw6QiZH575E71IIbYGQncIqX8Hr6Cm57TyxJy2+66W2HfmQyf6dsiXGSNxAFt0qgjkkbWJUNbBM2UIg71cLq4DBB2reygW5bYX/vFMk1fpes20KZ6txQhRLkkeg1R22v5qPZLasswlkEJWddUSUw0rkoJQsRYHLpX3tucOTAqfkYWvv3qL8180ssNLU01yJwJnhtrIBMx+n+y4v3rFBsq2rrYL/GFHLfluXBhurn2i94neqcNfjVBb+SRAgJaWS0RNr4XInMsuQ4GwTwv0191tNSjTwoe5YgYjsA552dFQpZSxH4M4IH/D1K7ljjRCWwSbdY2Cm7JYAaL2kmQFO8cbrK4evgD/QmlhT9GeKPERdBaT9vPTVv2w7rY8P7H/qhL/jDNjUmLdsuY2RghT7OBenpUvbGnfQJAy1AzCcm0oMK6R2pCZF45N8GhEGmXy5UWJGFwUjYzKU6aGw7S17mK1iFXTteXoAn16Q5pgtZjLIcX8gZjchzc9SHdRat/5S5WS+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36756003)(36860700001)(82310400005)(47076005)(336012)(26005)(6666004)(2616005)(426003)(83380400001)(110136005)(4744005)(186003)(2906002)(16526019)(7696005)(478600001)(1076003)(356005)(86362001)(316002)(5660300002)(70206006)(40460700003)(82740400003)(81166007)(40480700001)(6636002)(70586007)(8676002)(4326008)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 10:01:12.7560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c1ca47-6b09-4860-2856-08db7887c53c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The address parameter of GFX RAS injection isn't related to XGMI node
number, keep it unchanged.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 046659bd4f9e..5371fbd3fe17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1163,7 +1163,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 	}
 
 	/* Calculate XGMI relative offset */
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (adev->gmc.xgmi.num_physical_nodes > 1 &&
+	    info->head.block != AMDGPU_RAS_BLOCK__GFX) {
 		block_info.address =
 			amdgpu_xgmi_get_relative_phy_addr(adev,
 							  block_info.address);
-- 
2.35.1

