Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9847CC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 05:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFB810E591;
	Mon, 25 Mar 2024 05:37:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o4tEggAb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FC810E591
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 05:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgVUOQb+hjgqdqXNAVo+RofIY2B+WfBSDbHzpgyi7C/ffumuTFTMv89taBUc/oyx0H58rRJtqR/B9OKUKMWI7iQe7S4DKGGrJ06L4Hd8PvnsmmEn/CiOL/EIe0KMdRyjhxu0N0mKhcQHyJTEvJeQ1X7uW4e9ROkwTIYEZOWzka9dfP0rEivpsM1NwPkHb5jLHFSXvcWfAJC2301Fv6Ki1JmHQE+zBOZ9csePGG2OuV/LeP2vqs5+Sg9YxJgTXgKW3RSMdDU9ciH4daSeUhVU+MqcjZO0h3JfGQMmOobJcE4Nzmxrxbb3gFAiBRpAFAgo2l4/CmB48z8NJxbesTZBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7SnsvW2tz7zCPnobOBOy0vjfX5dSSDUJZUghohQW5c=;
 b=ZtOP0wXRsYA72CJhIR86tVmO/jMfzcW0XBm8fWtGBVAQmF+iSU9By0L0AZTBzFAvIoU8YrqpjhOK1mwW2gP1hT5es0rvQKkH4P3A7gETXy41DOKZpCW5ZM2QLY2JWMhiUvMElxv2srZ37n+Vmd4/ySFWMxlOi+U5STTVCJ9fTOBAmXC9hlQYqPQ7JN/IPPHW04bNnjp66BshP1XEqig5DE6uBaJxFWwfxSFEyWOZPUlcM0xUHRQDGUC11/RDwTqw7XCZJIpz0S5nqVSiKXYGOoBN7JROIlnZXGtEI1nkseYUYpMVdCyntuDAZ0PtHIE95447ru3fgV1YrTWQ1iT/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7SnsvW2tz7zCPnobOBOy0vjfX5dSSDUJZUghohQW5c=;
 b=o4tEggAbAYh2xsznqtsE2geTEbnt1EkP0J+3U5bo+hIr818jJf2ffNzkNlT/5vo0VGXDXlkMCVYvhhiCNA6v2zNY5pYWeZU0fQzv4xrpleK0y/60zv9ODTpPIhLsbm3LhGyMvH55Atn+f8z5BsBCqdi2zxCUnhWrIfiIhgJAZ3A=
Received: from MN2PR13CA0035.namprd13.prod.outlook.com (2603:10b6:208:160::48)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 05:37:39 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::a9) by MN2PR13CA0035.outlook.office365.com
 (2603:10b6:208:160::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 05:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 05:37:39 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 00:37:36 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/umsch: reinitialize write pointer in hw init
Date: Mon, 25 Mar 2024 13:37:23 +0800
Message-ID: <20240325053723.3183224-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: bf15b091-3a98-46aa-5094-08dc4c8daf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umX+1f7xFxjmx25pER8NhCABvmC0kF+Zwr7FZQXW02rUCEzM1hw2hVLLa0Qwgr03FN2KDl9pm6TxnTqv83ygkcynCfHk+Bu1ZTgTB6YUvOdkFI1FFVGYpNXN5WpeoQ1Pb1QfL2oJX3+ei6AXRGloRgyLTe0yCOQSCErt6g95lT6p+zK/5RKQjl0klT3jDrQ/viM6bG20luXuZuEw/zfbdfBdOoMqOvbCY40jGAk/MaYKA9PswpYVy1JZdfNjCagCI/F4g20D56FwJDMTXqQO5KdzebouPXHsmMvaxjNNfcdDRs+i40u40HyfPxlSmm0EOWd0q8+nM0r+wKSbwLkvZ3nktAPb3wlNc7OsgcTZnrhjyx9zVepobH5vdRNkVGCK8XG2loKUm/l3qDNmdkjRvJ9X7+5b+kMlrmdi8wsNQNJz9uqrxXEvdix29nv63sL05AswdMICYijBzn2yhUp6MUeLP9gQRD/IJaga/T0Wd7G7jke1m30dXiRYLQvOaWyt+osuByn3O2bELMaeGjDLko6hGE7gMm4QB3LOSK172KkbKBlv6nELj/vk3Dd3f6gQKZlPlA12n2QmkQZwteImToj7o+nAb5y5MhUmzUvnVOtdlahU7YnmJlzmivFddopbc9E6gvUx1MxCEdeQ73NjRtsuPp6rEST8DQt/yoEIikeOWBGLoh+JSRj5bv/8SJCZSUiZiyvJZj1KpFUxU8fiHtHM5ljtDDcrpwzgVqIktD7o0n4i+ucFDgZMrE8fT6Q+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:37:39.2577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf15b091-3a98-46aa-5094-08dc4c8daf30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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

Otherwise the old one will be used during GPU reset.
That's not expected.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
index 84368cf1e175..bd57896ab85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -225,6 +225,8 @@ static int umsch_mm_v4_0_ring_start(struct amdgpu_umsch_mm *umsch)
 
 	WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_SIZE, ring->ring_size);
 
+	ring->wptr = 0;
+
 	data = RREG32_SOC15(VCN, 0, regVCN_RB_ENABLE);
 	data &= ~(VCN_RB_ENABLE__AUDIO_RB_EN_MASK);
 	WREG32_SOC15(VCN, 0, regVCN_RB_ENABLE, data);
-- 
2.25.1

