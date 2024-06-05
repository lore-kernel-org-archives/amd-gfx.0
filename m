Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7345BC27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9300510E72B;
	Wed,  5 Jun 2024 09:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JhJfTbQH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A8310E72B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g06CSqI6/6L6SszGjrfcOXkstxLMimfVCVHllA7F//PVDBgvFvE23kTVVoEowRmVaBDPYNAPtH/6tvGnobWDtm9vqjwc67mLUI/YYWjjzlHTG+77N8gcHJ8ZUXsoieYjBuEY7lYHn8MPjmCRe0zuymSJEt/GtGF76lMlw5EFHCK5AZMWysJhwnr2xhKGLXqkWYuHS4/eWHmxvIUZCPRz+pShjOi03QpRR/zbQ4CuTs+uokA9IzZ5PZZ6kEFde+tZV/GCYY0Klx5dDmCbKHonKbObQF2a3ZpzJp065GKJlKdDXbfGcPDmVq9YkLAmhiESs20fzGu3q1cTFxrXZU94oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9oAA9nPDZpNP9yQo1hOYL616uUs3ZTGjlJNNgu5jmM=;
 b=H+NlpPlt4WjbfJm1wG1Ndx4f9WGk+G3MJBOHj+k2stUm/4wjC5paaPpjwpZU2YmFBFMfNYUz/YXcz1Mr0NqaIiCMgbQo3HRh1I/BFK8yVWvP13s0A1VYzqqx7g5zxzIffmVmAmapAGawtwEBYHUUwlhP2rma0R9nGFlPuAOpz8upUmpXo3/0ed1pMLeGU/zl8x8rjy7koiRlEgzO7tuLfZtNdtwoHTUud6MAwQbqu5ClK3FCjIXsgjM1gaX9S9koEBpsLsGRzfBKQDHAROyEzO6Tt75Nx4KLMPt81ssezKj3HUe612uOzMDNFWy50dWLde0dWRVx958jto0AGdC/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9oAA9nPDZpNP9yQo1hOYL616uUs3ZTGjlJNNgu5jmM=;
 b=JhJfTbQHrRliunhIvl1IvP3h922s30G0/MAGQzYGMCyGsODF40DixvV3O3FUPZXprLYwJn6MZMQan/bSoBsj+jnSCdy+KpB6nevB2oYd9XVFOEgTFHq7wvOM3YWERns3WX4bhhQqjQs01q79obzF/nSWlg7334/Ylc2/6kUHLj8=
Received: from MW4PR03CA0119.namprd03.prod.outlook.com (2603:10b6:303:b7::34)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 09:31:44 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::bc) by MW4PR03CA0119.outlook.office365.com
 (2603:10b6:303:b7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 09:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:31:42 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 04:31:40 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: move some aca/mca init functions into ras_init()
 stage
Date: Wed, 5 Jun 2024 17:31:30 +0800
Message-ID: <20240605093130.3045812-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 582a7523-b967-4531-d2f2-08dc85424f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b5cT3THxLkc1ddV9jP25w1k72MI+R8jvj9sjCRFYYBzZMip4Z2hEqvRwQCqL?=
 =?us-ascii?Q?Csph9EoSCUjq/+OaJlGGM5jPHC6p3GsHuu2HNvFFjBlOc0JIe1GxokcpucCo?=
 =?us-ascii?Q?bgIdBhDHH/2CNS3ZtTV89zjP/7nCjCDlu7UXh8laNwMk9WaxM/aSsy11miZS?=
 =?us-ascii?Q?CwPrXPk1+UrWOp8+IBVydk4Xxvmm6c42LwnDuYRwa2Hk/LMSBmCXZKFrECzi?=
 =?us-ascii?Q?h3q8jszt7wH6ya3+O3uzwrdHcWUn/7Vua/0DtE23GzODCjrzDCsMp9jZWVBp?=
 =?us-ascii?Q?s40JQiMAWMJnUkFxDNKYOYd8fQCfTj+DhsRyFzgXUIvhfdZt/dA9Pt+QZqCF?=
 =?us-ascii?Q?J/in73joNFYqWmg7zuKiQmVSIn+XDLhS0bK4qpxs/qreGnE4Uf5kgE6Tua/l?=
 =?us-ascii?Q?ojWmoNO6752latlh1ZriMMYSOB2oDwV/DnF3r5Wa9Y0ux4GcclJSyv7ZJYxg?=
 =?us-ascii?Q?+QKV0Zcl8VVeJ2YRGjbwpcO8bSAhW3hUBvdGCUcEP0efA96mAgWapVnst/l+?=
 =?us-ascii?Q?+dkAy61KEEI84RUxuuIso5I2glxD7GCnWDBjyHAgjtT6XHd/TqHSSujNCvx8?=
 =?us-ascii?Q?BllwSgFxnxP7TjPYDH4XZksz1m0zIrrBgiEqxorjeuAyPyjDR8LMfhzCEBO0?=
 =?us-ascii?Q?mYDY6KQWohA/UuItp8Jfhmeyc7J8wteXJrXsig737HbCvkBa+bCb/KYEsEO/?=
 =?us-ascii?Q?yahcMfR7gwIN7aOXdso+TUTlN+eLG4dst00wAqYC+RtEs5N7Cjl0oqlJe/tR?=
 =?us-ascii?Q?EiqEK5ctG7c3DKV+cEP5YLi4dOaJOQnzitDM+bBS5JkTYxyfmX/jWttQUh1m?=
 =?us-ascii?Q?VTo+X2gBxCrFIywZ0U/d/HlO+nIbUBIJvUjrt7B31yOL1DG4Gd/F9iYTZCyR?=
 =?us-ascii?Q?iAxpYMjE9GPYSKmi1qeCTzl3SOEkkF9BOJkl1OMz/F0w81XM0pJGs4wNCGCx?=
 =?us-ascii?Q?M/237ZctQGQfZ9DqskkUmD01Ty5R+M61fW974gHHtxYJ3WfjC49T1cLw8lBs?=
 =?us-ascii?Q?ZsRy5v8ruqgyNEzBQWP/2BsCYCWlRrIr+larXjlYtif0zhewKLM5OiqK/fNB?=
 =?us-ascii?Q?R13BroDI12fwGAp8IvcTAi0K9Yv9i6ooltVtObn68cZs65PFFcb4qoH3hVNL?=
 =?us-ascii?Q?fhntZo9750MYnhD8ehPJydTUMRzaTavUgOwmO393X/8//2PVwdffkmgwxGch?=
 =?us-ascii?Q?L6vtpS/q7eJXCVJozRvb8YHtmifS/k8hReiIxuF5Rl8aWQB3TAjlv3cl+Dao?=
 =?us-ascii?Q?f/xHrvZYiWPTac3+Bsm6aHNwGL6cUK2nicd8XEKWJWjCUnKwW2KUP6kwT54q?=
 =?us-ascii?Q?rWocyfvix4LawmCCJNgNuYEUn/kUGJ3jHvmWnyuzOMfTvkbrZEBaKFo1X5Nm?=
 =?us-ascii?Q?J70WYDKoDJjKg0ph0MYKmDnQA12i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:31:42.8193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582a7523-b967-4531-d2f2-08dc85424f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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

adjust the function position to better match aca/mca fini code in ras_fini().

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8dbfdb767f94..3258feb753ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3428,6 +3428,13 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	if (amdgpu_aca_is_enabled(adev))
+		r = amdgpu_aca_init(adev);
+	else
+		r = amdgpu_mca_init(adev);
+	if (r)
+		goto release_con;
+
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
 		 "hardware ability[%x] ras_mask[%x]\n",
 		 adev->ras_hw_enabled, adev->ras_enabled);
@@ -3636,25 +3643,22 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_event_mgr_init(adev);
 
-	if (amdgpu_aca_is_enabled(adev)) {
-		if (!amdgpu_in_reset(adev)) {
-			r = amdgpu_aca_init(adev);
+	if (amdgpu_in_reset(adev)) {
+		if (!amdgpu_aca_is_enabled(adev)) {
+			r = amdgpu_mca_reset(adev);
 			if (r)
 				return r;
 		}
+	}
 
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_ras_set_aca_debug_mode(adev, false);
-	} else {
-		if (amdgpu_in_reset(adev))
-			r = amdgpu_mca_reset(adev);
+	if (!amdgpu_sriov_vf(adev)) {
+		if (amdgpu_aca_is_enabled(adev))
+			r = amdgpu_ras_set_aca_debug_mode(adev, false);
 		else
-			r = amdgpu_mca_init(adev);
+			r = amdgpu_ras_set_mca_debug_mode(adev, false);
+
 		if (r)
 			return r;
-
-		if (!amdgpu_sriov_vf(adev))
-			amdgpu_ras_set_mca_debug_mode(adev, false);
 	}
 
 	/* Guest side doesn't need init ras feature */
-- 
2.34.1

