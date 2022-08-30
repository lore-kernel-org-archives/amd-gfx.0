Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D844ECAAD5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A8A10E398;
	Tue, 30 Aug 2022 18:40:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA5F10E379
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILGroX5+U3oy3pJtH1hVIeIve0AfzQsDt3u2BLHVpFSocybno9PJXUyjdSyvHmwCdoxnW7c9ZDOT2barMWxe1Cyb0sOqVfcagyNb51j36ZWrieTLtU4uKVUbS5PKuP3ExH1MbitchcFSA6FezDLFFJeiXu0xcKfaxlyZPOJ9oyCc1ttO8l0JzdukpLp37JZGoGFuu1mz/EGDMTayNniMv+vq4kv1TbDPrXf2SmENRql27sF6/MpfzccsVieWuxZfpaVOz2ecBRVT0S8ACKtY0vPoBUKREBSGilmIDBIeao3HYMfZflSq5ryM7pSL+YtncDB4KQQlXY3zRUZonYA7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KIw5c6yOXU9bZUg9ERz8i63sWhZfJgmwhvqTbmgPPg=;
 b=bSXZjzW5goh7I/23ImLrpRJbarTXWmU3bthVhJ79g3iWnlylgkyeo97Gqqf22UEgCFpXcSXdgiu1Me2R+rhb2xgnhKeVRDkx2rmW2wCHtiRs1RVW+wdU0XVs70uO3NDbmCshhKA0Xny+hYRxWcg59Kdq9G3JwjZtYPBu8y0ryECD3jn6qIMsR8a2wJIGl6wpHCvImLZSQCBkygTQgLceeXYYbfhTgNvUc/gkiaUlzdYhnzgKgoOJDjQceg7vOHq7MZ8c14ml54aRCAONLHwD4esY9sEruyOyQlbehGM66EPSt9xra4sUbaIJgxp2SAUjGN+uqr4kfxiCHWYrcEnecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KIw5c6yOXU9bZUg9ERz8i63sWhZfJgmwhvqTbmgPPg=;
 b=Zu2bS7037dlF848h1qLIEV0BJaWwQvgBv5xQw25h+v6cobVS7SRB1Ph8IVJe9p6n8U54qIHPuM80SBLix3jYr2UjuAg/GEuYDOd8/dT7d7Xcb5534qKCkudSu7lJLAPXORBMQa5qi/GxcpPUS8W2cJRg3hBF4ShP1cnwr4KaVxE=
Received: from DM6PR02CA0088.namprd02.prod.outlook.com (2603:10b6:5:1f4::29)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Tue, 30 Aug
 2022 18:40:37 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::95) by DM6PR02CA0088.outlook.office365.com
 (2603:10b6:5:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/19] drm/amd: Skip smu_v13 register irq on SRIOV VF
Date: Tue, 30 Aug 2022 14:40:08 -0400
Message-ID: <20220830184012.1825313-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1406e3f4-254a-4b8b-47e5-08da8ab72169
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6807:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7H1btJ2W7KLI7olJqp3b6WubwhfSHUoa1rPkOelS0GKwd2le1thTugLZyquFq22pMLmltUvi/mvcqNVHonu6db3XmPCkqhGrZWA8Ez4SceiQux/1YCeRsHvD1cCQsyM1/wtJlpd7oxEFfqje0O/R+GlwMxfrXmloIHHWlBBXhOaR3SST4jNq19CSb0koC27TmonYKWtT2Qg7lnjVqaoa9YaPLMSvk2WSwkQ2tOE4TGlns1FDUEGmFZHoNDPFtCzS2jgALGJBWLRwOKYrVZLkQLvF/vZwEjj5PL7zZdcjrdA3/4dOVIkRDc1UShKLqHViv+0SDjm2O7OB0ZlfZqIoNSCFHx2fZuvVwh703Ayz0kimnSuAs2NbAoLGkgTwOT6/3Gp6FQ8SUiVHelZVR0lvxMCbzhURXOytMkZ+TZpkCjOhc/tBN0aKM93wcv8+4kQjrcLcUeZy7U3L7sRly2wgbT+iJaHQvjTF5TqlOQb/GQYfMin8oJPGx5c9MlmkwawqogJ5etqUS1y+VmdQOCC+vI5FIf1xFj8Mihm2JYFwNkEX4SZ5oS+hCsqFw/7I6Vy/tLur/+ZiyYtslJXxTxEZCTuXBCE5+wYKZvJJ9i8UYDVFfWZmY33ZxF/rvG/rOGodI9uHrb+a7KGCz2/JjCtqDJtkOEeGeqpJHbRa++SzJ9lwgVuS4qVwsJ5bGzcQ58CJJIfnDypzpA9IgbEoLrmRvJFI7dvKHUZ3rxOjty8J3BLSO4vhHQHPT7koeeHaRZ7DLvHvyUaQO0p59Hxm9ZpkTSnKh2RHQ5TPV0n8YncGHt2tWzyAqO+RXZxzg7bHNR6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(40470700004)(46966006)(36840700001)(356005)(8676002)(70586007)(81166007)(4326008)(70206006)(36756003)(82740400003)(36860700001)(86362001)(47076005)(83380400001)(336012)(186003)(41300700001)(1076003)(7696005)(478600001)(6666004)(26005)(426003)(16526019)(40480700001)(316002)(40460700003)(6916009)(82310400005)(54906003)(5660300002)(2906002)(2616005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:36.9605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1406e3f4-254a-4b8b-47e5-08da8ab72169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zha <Yifan.Zha@amd.com>

[Why]
VF do not need to handle SMU IRQ state.
L1 Policy will block VF access THM_THERMAL_INT_CTRL and MP1_SMN_IH_SW_INT/CNTL.

[How]
Skip smu_v13 init register_irq_handler under SRIOV VF.
And add irq_src check in enable/disable thermal alert
to avoid thermal alert enable/disable fail.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4fee391f4cfa..bebcd668a766 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1108,6 +1108,9 @@ int smu_v13_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
 
+	if (!smu->irq_source.num_types)
+		return 0;
+
 	ret = amdgpu_irq_get(smu->adev, &smu->irq_source, 0);
 	if (ret)
 		return ret;
@@ -1117,6 +1120,9 @@ int smu_v13_0_enable_thermal_alert(struct smu_context *smu)
 
 int smu_v13_0_disable_thermal_alert(struct smu_context *smu)
 {
+	if (!smu->irq_source.num_types)
+		return 0;
+
 	return amdgpu_irq_put(smu->adev, &smu->irq_source, 0);
 }
 
@@ -1488,6 +1494,9 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 	struct amdgpu_irq_src *irq_src = &smu->irq_source;
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	irq_src->num_types = 1;
 	irq_src->funcs = &smu_v13_0_irq_funcs;
 
-- 
2.37.1

