Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E50C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 22:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D482391DAC;
	Mon, 11 Jul 2022 22:45:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D033791DAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 22:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m59pW8jtgNU2baXgTRfshmdNA2pdhVgCq5E48l1qWu5zXYJWW7mMJhaOQfP0u3+f8MsrwKCLrH1BtASVbrlrPi/QrWbuLYT3WjhUPSdxvau6oj9eaxp3Exdw6kcX2n2wXYvzEDFt1W9EDN3+3ZXBAu5iZGDNns8dWeXqn/WLXlo8MxWgDagvNbrisFzzz9JomQwm2+vz6BcDpv7OFcO3aCZbWyQ4f1k0vYigGCSurXlqAwDiQNwiZS3Bg9ISooTsw9oXqpecL150Y85RKJrgNAraEB/ieJ+SaWt9oWHYKZTGe9C0zsWzK/vyVGijsc9f136xECpebpCr/pd9Neoxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SUXZn5WAuzroM4ZWeKsYqB0QsEI+h6hRDmVP2ovayg=;
 b=QsXmrbm/JIdqIjQm3sgfXncXNlgiSL+nrpDqDwjW5Vova7d2jiAMUwN5/6vNQjJ9Ps/zhILd/2kisyPM+tWfvk4GQvBBmNOjqB8rpIoKG+GkvOtLL+pYhnK3KXFm6vgrp6jzwDLGn0zZfvBNIE2F/roES/sM0zHFxCDTVuvfEMJx8ld7SC180TZTXz0Cqdg/L24SlkTyseg8QcN0Nh3g7AdyO5sdOf+0Bl7uTdctsVOxrQrwFaPO/8LTmkOFS1ZpwMAjffu5hdDefGlaewwQKDZWdw0O0sN6kQI7xmzRGuSFYafGkx8M2BCL9xomUKgYGVOpWGrci68Pfa6+szS3bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SUXZn5WAuzroM4ZWeKsYqB0QsEI+h6hRDmVP2ovayg=;
 b=ShkD3acnPhj9mupkx4+leU+MboDPd3B5hHAErayFkJvi15EpS7Mx6C5djKtK2uf3YPOlbkPkhgt2DLEyHXZdM5CJDtz2OCMbCUJPJKAsdpzgAE/+QZehLz5ut/EI+mecHEhX+RGMJOdIx/TWaL75yNsX0VzKvC6uRHxJ78pWGww=
Received: from BN9PR03CA0195.namprd03.prod.outlook.com (2603:10b6:408:f9::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 22:45:03 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::1f) by BN9PR03CA0195.outlook.office365.com
 (2603:10b6:408:f9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Mon, 11 Jul 2022 22:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 22:45:02 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 17:44:59 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check BO's requested pinning domains against its
 preferred_domains
Date: Mon, 11 Jul 2022 18:44:43 -0400
Message-ID: <20220711224443.1157747-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7824ad40-27bd-42a1-c054-08da638efe49
X-MS-TrafficTypeDiagnostic: BY5PR12MB4001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cn8SNAn4c9dCwpnBEdd8mLZHTjKjxVYVDlXUp/ZlmQHCcCM+mf7Tf07rtsxQz+YtfdaH8pNbMWQdtoApEF4IBUMEp33AyjMPDnxcs/zaBSCl6DXUibeDbvgN31zCuTfeHKFrHIQHflX9UP0JPcfxkAwyjTx1z8fRV4MU6aLSWm43bH9CkhHmQ8IWiw2MbePmZCgLllgQbOJy0w6v6NeT4ePwns3vQv9qa9XAAHNB7v0lhl5fcwHHmXVr0Ae4tpCTvh36QcbFl03vkygpN6Q0evWfbJVMMPd4GrydYOLnr25LelEX81XUihkZIlurrD9wIGptevvntBeyDRuvufUJOzI8wLsj0hss6snVvJwI11kVPV6KdiI5PT83/if3I8F3PA+Br+wUH9BSI2Wr6I6SYG40dPHqwzc8yKvmigf02ZHDxtR5KI+tiN6XS9kUmRFIFhaC93rTQGyilCBp+4d21/Cm9ihia9tuOrkOt8H8WDKEvRBKJDJvY+QaeYzsmdsZsufYCVqrgo6P/zRuskVKbVFWYl9dsKb27sIp2NOF2Q+c0if8jS/Ci/Dkmts5xcSkHQr/XUoveB8AykbEcjKIZQYxA5vo1gxtcSviRzozoThNsroGbd7NZpe17FGkLNNl9DrMQtP1KhhXkElovo/+rf57YZ94saXOqccHCa4Jvh5i6CcHcEiBqkwAfcnlSuKhHHIiQFTONXS9ShN9/iyQzB51ZM3i2CFXDaBU+U7seLQE9sMXqcLB7DrEsvkOaggg/WVGhwrGQFEBe43iYK/dvhSuFTAtbg3Yhg0hJHxVG57FM0qLJbILttRyotpMG30xfGi5K8bKnoI60maWUhHQf6zci2RryWMAhqXN4jojDGY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(40470700004)(478600001)(36860700001)(6666004)(82310400005)(8936002)(41300700001)(316002)(83380400001)(4326008)(70206006)(6916009)(54906003)(36756003)(5660300002)(8676002)(81166007)(70586007)(2906002)(426003)(1076003)(2616005)(16526019)(336012)(186003)(47076005)(40480700001)(82740400003)(356005)(40460700003)(2876002)(7696005)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 22:45:02.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7824ad40-27bd-42a1-c054-08da638efe49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: Leo Li <sunpeng.li@amd.com>, Leo.Liu@amd.com, Marek.Olsak@amd.com,
 Alexander.Deucher@amd.com, Harry.Wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

When pinning a buffer, we should check to see if there are any
additional restrictions imposed by bo->preferred_domains. This will
prevent the BO from being moved to an invalid domain when pinning.

For example, this can happen if the user requests to create a BO in GTT
domain for display scanout. amdgpu_dm will allow pinning to either VRAM
or GTT domains, since DCN can scanout from either or. However, in
amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
adequate carveout. This can lead to pinning to VRAM despite the user
requesting GTT placement for the BO.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8a7b0f6162da..50400d70ef12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -883,6 +883,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	if (WARN_ON_ONCE(min_offset > max_offset))
 		return -EINVAL;
 
+	/* Check domain to be pinned to against preferred domains */
+	domain = bo->preferred_domains & domain;
+
 	/* A shared bo cannot be migrated to VRAM */
 	if (bo->tbo.base.import_attach) {
 		if (domain & AMDGPU_GEM_DOMAIN_GTT)
-- 
2.37.0

