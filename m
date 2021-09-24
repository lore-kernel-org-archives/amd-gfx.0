Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5120C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B3661211
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76B3661211
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 188156EDDF;
	Fri, 24 Sep 2021 05:49:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3BC26EDDF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:49:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQJQxmorYcJyzfKd/IpmenRc8ikB0NQVkXPPI21OhPJ8YKUZu85yX98YCbRakWkV8E7vZwgtATSiBf4vExHVF10xYcOYmYawiHGs+OCxPAtSvMo2nGMq9DghDEM5DAqupPBb751B1YCIPM11LJ4ykUMMb7Kc+/pIUPRE+fKcadKdEdmqAJIaE/a1AtYWb9y4NhbkdR+/hbWb9vnraf9J0iCFEzyaG2qSGXJOHtDaX5ulyj5+1glomAHMl9pFIcCO7B3bL2Tmzeph5V6MaBqcfTmIZVjioFwPxaI/rpdIxLA2hVMc43Zs+gFbFpmHwrc1fBCZxI8N/gsxPR4r5eAEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=iNG5F5k1g67ZhBois73Cx5iPCX9vdJMr2iSS0LUpVTo=;
 b=YOCLHrzEPJvp4fiythQmSzYx5iAfRakx7RsNkrqWQoSixPPrLJn72M3gm6fzyhB1QNw0xxXL2E9TM0pRKbGU0qU7HfrLf0SSRh2fnVz6wpzYbXNiqprgv9XW3a4atUbO7BNzlJLe/KjHc/wshsRaVzCsPbPb85iwtQZfncghh20kDdnpvVNqrrCWTp2uqX/E3Q+CAbXqmpatk43q29DsJ+YSKF4d7hB6CFHF3IIdAy9Q2/5asXfiBV6t4eNrb/mPHQZIonj2z/P8ZhVFBjAmv8tpv8g2o1qxTVOE15Xy9GHSyU+6y/w2KexCOKSAkbWH/78SUZnriqQcvtlOfIMX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNG5F5k1g67ZhBois73Cx5iPCX9vdJMr2iSS0LUpVTo=;
 b=zCqwgRWHhBIyHeXjB22Ui/CbPO0pUlXHmO9Z+huT+wsJTUk4IKG3EPKNHoE7hRH+Zo9ZPRw0z5g301U0GWC97PJXbKG2g+r7NzU7P2/neS79HkOh5RCAXXIsm8AzC5h5aYO9QS9mIlT1jvpPVdq5WkRsjkLPZOc6XmZVhIGxDpE=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by CY4PR12MB1671.namprd12.prod.outlook.com (2603:10b6:910:c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 05:49:19 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::b4) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 05:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 05:49:18 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 00:49:16 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: remove redundant iommu cleanup code
Date: Fri, 24 Sep 2021 13:48:58 +0800
Message-ID: <20210924054859.2301209-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1a5a7f-16a4-47ae-d584-08d97f1f0cfc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1671:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16713EB1289CD0AECA7B1823C1A49@CY4PR12MB1671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdAyhydgLvc4a96E6ORaAMSA6aI+u7VGNbH+4nKwDybymUYrj9/IPTSJJqC0syi+RrcWgbK/K/wT73OHcyHgJIz3lrxWZTsMBqNOZcmkjxy4b2ovIxXU6fIeRWaoVI75lKUK8bRlkmFGffJAITG/nANqMdZ98l5hL/SMtJMOJ4J+UMrL+5karIfuvcLp1VHvftDDye8EFD6olo0HuzUVFZ/uNdZm7yDiEz5/uCHbpc2HxOt6KEat+jl6l+P00N9gFjd4xnr678adV4BWPR34DZa05i5J5wyfr+EjWwc5eKVoNlAM9ZZw/dd+FewPM7TulULVmjMsjXmlLUHGlWlbmDbZ8wmahajkPpNsi0eKDsY9f9iq2V0NJiUzy+GXg1oQ30O99Z1xbufRK60Xe3qz+odQ5vyvfSPwtkNlzan/p7AFzlvEgL4LOur2VUe2Xpc+K7XPiu1aQCZMrl3hqmfhzBaCZdntKh0jF/FO3zlWNNnxp6iZpVTVQm6bLJGTtCZLRuCMGwlKppzb5YEUmBkaiTQCfQi40x3rMuEuE+dW6hjCqXqj2hnR/ge+x0towQ7+ATGhwMDxTNY7RuDU7Q8qcSb9SYXVlj6DJCwW1CWa1/8J0KsYw97+m3zd5lQd4uz9hQE1nM14mKqZslOTzWVvuoRg4MgpktMwC6uy5/ltYY/RBA3qtw5tP1b4BOcA8j1P0QWuWGvONDRhwnXaRWXlhn5UdlN3l54KzTJSXxmRhek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(36756003)(5660300002)(186003)(6916009)(81166007)(1076003)(70206006)(2906002)(336012)(47076005)(356005)(36860700001)(70586007)(8936002)(2616005)(508600001)(4744005)(316002)(7696005)(83380400001)(54906003)(8676002)(4326008)(426003)(16526019)(82310400003)(26005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:49:18.7826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1a5a7f-16a4-47ae-d584-08d97f1f0cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1671
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

kfd_resume doesn't involve iommu operation, remove
redundant iommu cleanup code.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c2a4d920da40..4a416231b24c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1085,18 +1085,12 @@ static int kfd_resume(struct kfd_dev *kfd)
 	int err = 0;
 
 	err = kfd->dqm->ops.start(kfd->dqm);
-	if (err) {
+	if (err)
 		dev_err(kfd_device,
 			"Error starting queue manager for device %x:%x\n",
 			kfd->pdev->vendor, kfd->pdev->device);
-		goto dqm_start_error;
-	}
 
 	return err;
-
-dqm_start_error:
-	kfd_iommu_suspend(kfd);
-	return err;
 }
 
 static inline void kfd_queue_work(struct workqueue_struct *wq,
-- 
2.25.1

