Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3856CC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF05710E285;
	Tue, 17 May 2022 02:06:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B4110E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy1SWbAWQzFjMK2zXP7Fmci+G3+/mhCJu//alOh7PjV1If8trptTM9QN7iWyWMPSMP0bbWwafXt47BXeATBr1COJiZ/G3vNqr+KEmJ/mxnX6x1ZIzBkHZXJyFR0/STiks1SIl3kHh22teDAb3JtdWO83R/xdpLpXOiC3FKBf4S9hWPMwVDzjMDeGBR2iEKaMIamL4wCdt4w/IeyugxdU3Tc2joH/QGGey0Ek5uSCa5MreOZtWalnEz6iQymZQKSixK77L3B+1GloH2rdoaK4AoTycOl8OSku3bsf7zFbdq7hgYIwLSZTmq5IOGld1V++c+tWq41MH8bHDy0rBQiyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GE8wNc6QgF9BvEFupuXwdtJIdxcXMV+aQLNb6R+mYY=;
 b=VmNonqAZey4/fUATSvLBUrym3LlGcEnCB0YWYwXLilk4R/HrKd1tub2G5SHi/BrMf/tBvmcsJtW6Y1y9yPp/AX/af3u4bd8sgeGA2QXScufUJ4qVbxPJwJdBai4pLly+QM3g4iI4tFBP8PBnDmcj5nqP1xn+iIQQ7tIwl4RigbPeNq5S1GkUvz3Gv0XX5/sPPyfZDjs0K5aB/8Oj2oRkZ2NxgNTIfKIUR+UjDOqVm1QqpFEvCrsiugRGu3LvxkTK6LXCvOjFjAEzGGzvYrW3b8ZwnPG68ogCDjG4i/bJfpCEbJYkyoTwNcmjgfrBuwd5XaboMbohhAEpxw783TXbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GE8wNc6QgF9BvEFupuXwdtJIdxcXMV+aQLNb6R+mYY=;
 b=UaeVNKl1w6WGIGUyCWd5uYLUhIvjUdr4DthgGWKdD/ehs7lwYXAKRIiDULFny5/oYnl5EKhk/ilZN9Ijl+mbve/y1WiEZD8tBAedV6Hbs0nalwO/1A6Kaj8XEc/0TYQ6zGBxfuLPGtlUIJ4sXrOMwruoS10Ct5w7PeBnZN76b5w=
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by BN8PR12MB4769.namprd12.prod.outlook.com (2603:10b6:408:a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 02:06:54 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::c) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 17 May 2022 02:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:53 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:52 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amd/pm: enable memory temp reading for SMU 13.0.0
Date: Tue, 17 May 2022 10:06:02 +0800
Message-ID: <20220517020602.160108-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220517020602.160108-1-evan.quan@amd.com>
References: <20220517020602.160108-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf7109e-a803-4a4e-230d-08da37a9e9ff
X-MS-TrafficTypeDiagnostic: BN8PR12MB4769:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4769B3E7EF2D01DE554F25C2E4CE9@BN8PR12MB4769.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKHSZpi8iTe0q9YS4mr2pjtHDAUiB39qIc6D9vMWXLDoG1Dsd4BU2R5fWKtQrR7vuMymk3Z7EcgX6NrwQJkdUgXWRaVaTbeoNOpMcR4cXt2NK22SAqUSpTPbqEhEHNYlT0zOtJSS6nbni6Q3FV3eZaXo4T1aMl3CTS4XG68j04RlDpXXukR1SeVGoQykql0ShDVGS1cv9f8GfI6ht8IlJZAt4v5mN/QNjCa1eoOwJSRp/isKirgz14vtR7tGHnLqk+2IuzCiYn5gBz/lDxg+jlgjUCVxD70JNLwvG7jsJ9Xr6zREztsGsdIyRwTe0vxdJfu8vPneiKFtqdqQ0+41gKbEBfTZN3cMgukwzSbgZJB+Fe/G5jzgHqo47LMUDJDRV0BqS4yUrXQ8bIql9gDbe1hQ831u0aRT+XM7BtkvjK9ippcMAWLP0u8xrmB+2Iu/yESCWWujX56qsHQC79u07xJo+++vmT1IUfTTrHqlhcq1fZq/olleU8ldHdnjMBupSSPXKAhND3rNeC6ZBOPkQ9ab7oef5IOZWrvW0fKFKa8jgIANpGm6RVcb2hSnX6yyrSLBBG/wIEt1oBL8DopJwHQ1Z/v7LCUttpo/6m7BvOuoZEDAkMx2EnuCvcSj70DgTm7XRBFbNhL1fhPxAIL6gTeCOubT072oQeq6NVH8lzzUNyo8JzSq+br096L23idfwtixEdIDklgSFvxN0hLc2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(8676002)(4326008)(7696005)(6666004)(2616005)(36860700001)(47076005)(1076003)(426003)(4744005)(86362001)(83380400001)(5660300002)(8936002)(40460700003)(16526019)(186003)(36756003)(82310400005)(81166007)(26005)(336012)(44832011)(2906002)(508600001)(6916009)(54906003)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:53.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf7109e-a803-4a4e-230d-08da37a9e9ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4769
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With the latest vbios, the memory temp reading is working.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I3b4679f03e5ff7cf8e0b68c095d210e608149fcb
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 7bb2923eb819..7432b3e76d3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -275,9 +275,7 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_VDDIO_MEM_SCALING_BIT);
 	}
 
-#if 0
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MEM_TEMP_READ_BIT);
-#endif
 
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
-- 
2.29.0

