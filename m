Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44BEC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 18:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5755310E411;
	Tue,  1 Nov 2022 18:49:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1B410E406
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 18:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crlXeAc8CNovmxaBimodnCLnmyVQeB9uzFqtQMwutPbMLZTzlbfpAkDg0NH6jwmzKGX24N9h7kbEhzV7XX31P5G8+RyP23JkGiy6Q5SjWy7m+SDlffmHiEeZ96bJyCgTi8EDtpfKoVz36mWaR2DN7DvgtaSz7M/S0Ad8IaShqFbkzoMrL8/61OU7XhsPOWzmKsn4fBFF3fw1vSmiM67pX4K0vhp4xpL2sdLeWg+fosU71fcbQBfXcLu3bEI0SrTIDP09eJIhsabFeCSkxKykcW4h86BEIICEViDjOfs6mJC/Twz1TIMDWqG5jnYkkUOaekyyS+GLkg16uRDr6j2C+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LNMLr2pBLQ+EyUgKV+C8i6/Y++NFxX9z52rj17Paww=;
 b=YfGmpxw/bIFeK6vC/m3hfMN9Ta+WF0c+IS00UnFF2YAUoi8t+Axcf7hDjkCxGfDLzTwgNereTbpLSQt2e1CCNBNyRCVjR16AOesV1Kj1T4qgFUsG7sHfhRdbJ4folYKe820UTVaBIEsIDwTqk+Ta/vP8nuIS/pciWQ8197zl1SzLL8wIQKV7Ee8FTcegaRTEWhx1UkadY9i9xd3NGErWb/ZQ5+Q++xjIV2dbDZuXDjbINH0c6nbRPJz0jp1ZPhiHCMZwciDpTeajhFQbDOzyeqLZS6DGZj/gO0GVrEsykEFOOkp1ZUULhgtwdK1C+Vubr9aJD8Boj6psJ3pSQw/3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LNMLr2pBLQ+EyUgKV+C8i6/Y++NFxX9z52rj17Paww=;
 b=Q/fz6BeFe9SdH0H7s4G2OH1IraFtdIPcwMqheN2k6etDYlmSrZbqxpKEpBvdD3kxcRuAe/ghOAPV+YGo8cNRPXAettC7vMEEvNukO4PEcUxJ7Xbsm+xYHk/qGJ01Ylq7eQCb7sb3TwybFi/qh0dTwu6zJQyYnSTzv7kqd1Bw2eU=
Received: from DS7PR03CA0127.namprd03.prod.outlook.com (2603:10b6:5:3b4::12)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 18:49:32 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::64) by DS7PR03CA0127.outlook.office365.com
 (2603:10b6:5:3b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 18:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 18:49:32 +0000
Received: from vm-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 13:49:31 -0500
From: Gavin Wan <Gavin.Wan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Check hive->reset_domain not NULL before
 releasing it.
Date: Tue, 1 Nov 2022 14:49:13 -0400
Message-ID: <20221101184913.62291-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8515cb-de96-469c-6ab6-08dabc39d07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRSUZP3xTtaOVzOikdwVvNa/RmLtXFbgUY1+Po4+6VmTqmGhMKr7vypKPJhNnBIFCwnxIfOWq7dlHgQgEnE/MmcgpexDZ12NbPCEoEcLaqoj4dVyUB4O00Z0e7U+u+6XTetjqy9FfjMsAiyV94tFVfNwch/eiM52+eGvB6FYrdDjwxKOdloXYwixchMjZo6AKtLQY9zHyEqf576io1hLSfmHt2qH507naonh/Dlr56ouHUlB9jdu7nmwbeKjtG5nzdlD6r5x1FV/Lhra57iZGikupHEXTyXGrEnyj4TdPiVtaxpqsBwRjUCCp5gwY6uixh5Yv3+N9R6N5eZCwbqqWl/1H4CcQbBmNMOmyubtriqkN0skrc+Q8DyaoNtM+oEdveKZMCgMOxLIuqzc2duC0W9lwYtIDklE0/xs/1TR2JYuOjenXdARBj6f+XAQeweaJXVW+K7tdR8X7aPeq8xv/g54Nr8p7djJQcDeDbwYrAtA9/tCYiIX9paCofrJ6h+OYxCnCmRxOGd6Fc2kK8txZm5lgkiwIPQjRDJfRoyFBaT+fMXeazDdvnYZgBGEUNw3VLCdxcUNpxafKv5lCgVXtGAtRQNNQlLg81OANa7+zC3U02CGTcFnDRPbjBHhcLd0jIjvp4rRGCDU42lxj1UgVOoGFVd7JusSGIkx0Et5hMMgjQmeVZi3BVXwQLJv5PGxgd2Ezv9fv1Jv9Y8CARFuV84YCO0B3EdidsTvw7u4gJ4Dp7/G38GUhZuVdSg43A5PpekKC+QvHxWeTsc4vyt0qKfXXpe9kd0Lp3CWvgpA6R2ttunpTvisc+27wyYPjcT2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(6916009)(316002)(478600001)(70586007)(41300700001)(1076003)(16526019)(186003)(8676002)(70206006)(7696005)(4326008)(36756003)(8936002)(5660300002)(26005)(2616005)(426003)(82310400005)(336012)(2906002)(47076005)(83380400001)(36860700001)(6666004)(356005)(40460700003)(81166007)(82740400003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 18:49:32.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8515cb-de96-469c-6ab6-08dabc39d07c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The recent change brought a bug on SRIOV envrionment. It caused
kernel crashing while unloading amdgpu on guest VM with hive
configuration. The reason is that the hive->reset_domain is not
used (hive->reset_domain is not initialized) for SRIOV, but the
code did not check if hive->reset_domain before releasing.

The hive->reset_domain need be checked not NULL before releasing.

Fixed: d95e8e97e2d5 ("drm/amdgpu: refine create and release logic of hive info")
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
Change-Id: I17189e4d7357e399c6b70e43c24051356c025a3a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 47159e9a0884..371c4f1aac2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -217,8 +217,15 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
 	struct amdgpu_hive_info *hive = container_of(
 		kobj, struct amdgpu_hive_info, kobj);
 
-	amdgpu_reset_put_reset_domain(hive->reset_domain);
-	hive->reset_domain = NULL;
+	/**
+	 * The hive->reset_domain is only initialized for none SRIOV
+	 * configuration. It needs to check if hive->reset_domain is
+	 * NULL.
+	 */
+	if (hive->reset_domain) {
+		amdgpu_reset_put_reset_domain(hive->reset_domain);
+		hive->reset_domain = NULL;
+	}
 
 	mutex_destroy(&hive->hive_lock);
 	kfree(hive);
-- 
2.34.1

