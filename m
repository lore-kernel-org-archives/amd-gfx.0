Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111EFC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 20:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9871F10E3AD;
	Wed, 16 Feb 2022 20:03:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D9010E3AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 20:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwtJ8j3HOAc0A1rfjcks6pjj1XFSUkYhSOB6YUO0AMpdmb0wamfnRks7R8gYBs6lcRoJzfyrQSJzd6VLLuHPd6NQRvAXbIp/KePn4dx1qeADVVI8cU9VYaUGKhf2IDSKTgqaq+lEdmoZTqU8vHGsf3N2NqEc83e0e7nn5lMAsVZoGG4tftvL94up9zqs++AQ9gvIgM5zgEs/nNQInh9ooArkdZIE44NHzFvxesQYbdVEjRH2M1omWuxCESVKBEiRdqxNRcR+8eR97Np6RmhliMkScAQYY0l0PEXYkdrN5HedOQ837MlOFk0RKis7LsqjK6/XlXUNVGGW2BtXciTL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFk2kzwagipFUCesd8l+/p8RY7pj1yHRezAjswd2ZEY=;
 b=Xs6AYOlRZHlZAHL9yDM/EuZKSBZzwfE73BrioK0xBNq4LpfH5Xpi/fZgYO+d7YlZbr/JRdtuQ1lzjxNdSXbIapDdz66fWdKTLEjAcxVuyy0JieLKTfuOUyv28W6zN6mMCdt1jR7cx8Y2Z5bJe3cGTvh/fmfJ64U/I9eGmZq+PxjjjRkxD1rmmLc65m+4j6k4AyvS+47id1rAz5i8ujDTseEZ4mLRbHxDG5FceC2TdkuUo4FrKfSzhkWtBSgQvqqoXzHmwzxV0RI89MJBsdO+fxGdfg5uw6LPL6QQ3lPkI9pQFfX8FJGUiX80f48XCKoj8lfmdd3F95dKQRqeTdNCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFk2kzwagipFUCesd8l+/p8RY7pj1yHRezAjswd2ZEY=;
 b=q6Q8hKAJE2LAfbAxFRte9GNUGtOH42bho60w8gRavlGr7EfORoXRCG8a52oaohQfTwpFf7dWYjzqw99hyATN5JB2WcHirItN44FeglLgZaalHTlZ/eJ4tZj+1OQ8TppC36UquEo24+B9yN5GywS9y3l14wWUKw6EIdNbpCcZ3Yo=
Received: from CO2PR05CA0002.namprd05.prod.outlook.com (2603:10b6:102:2::12)
 by MN2PR12MB3439.namprd12.prod.outlook.com (2603:10b6:208:cf::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 20:03:44 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::3b) by CO2PR05CA0002.outlook.office365.com
 (2603:10b6:102:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.8 via Frontend
 Transport; Wed, 16 Feb 2022 20:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Wed, 16 Feb 2022 20:03:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 14:03:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add support for gmc10 for gc 10.3.6
Date: Wed, 16 Feb 2022 15:03:29 -0500
Message-ID: <20220216200329.2693231-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76fbde6-5596-465f-a1fb-08d9f1876efb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3439:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3439CCACC6A32F46CE7D8520F7359@MN2PR12MB3439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIHyHdWd7XWVAlGHJ707fEJ5S0qyLXHh/x+vjsVp67P/3/BI2jXzWXZQThdsf5Eq9zKwu7TexUii8v1NjGjwihxCO6ZNple+0CcezFDC656zM9VBzgeT9P/LDBxtBvRaoFSY3JgYeo6rAkU213OOp4J3/q4zCiW+zjQdYT0DrmdiIBCeNQtwhErk0JF9e4H/XNx9PIjC30clvKYEUYnUTtQMlYwjz8XkvEIDzeNsIOLb54SLC3bc14BLKiH4L8DFLX1Bo8cb8HXqo1Jk6/PXZVvuTpBB1J6UbvnOlzpR3OoU2IGVLegq/Pge4aOg/r86sAOlfItnoCcAe1DdBn8F6MyrJdUnPLpvMJxXLYYb24gDRKjFH07op6qkVBZMkJiobA4lEJdzcGDptvIv0HzdL2etXXyr7P8gidiK1y4rc0d6Jx9ziLqRvHJY64Kjgnwn2DE6L1MW7g0SMencKvMtFXQcxQLtGyGZ8+L5jHLm5WRKREK3WrSM+9f0eVB0CeJfIw8+4sv8e4/Nl2/A0LEARrbv0kSoweaiUGjOxiYDYDWqmBrXFr15QZr1/V4+VszeVEaGIv8Iy3nnsk3y3wa6Q8EKf5ayocEjOKfpdi9l3Yg16VCS4iLK70icJW/csx6v+sC6bNN0Of/4P0Dag6ueC+qZTI89j6iWZVoh1GEYn0OUFiIlRxe3eZ4w1ow2B5UeyZnfqMxp+fPxOMLkXS+30w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(4326008)(2906002)(8676002)(5660300002)(86362001)(356005)(336012)(426003)(16526019)(26005)(186003)(70206006)(2616005)(6666004)(1076003)(82310400004)(70586007)(7696005)(81166007)(36860700001)(36756003)(508600001)(40460700003)(47076005)(6916009)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 20:03:43.2468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76fbde6-5596-465f-a1fb-08d9f1876efb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3439
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

this patch adds support for gmc10.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index aa08431c1a99..56f89d55e593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1220,6 +1220,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 436374fc1f98..e7add2020d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -697,6 +697,7 @@ static void gmc_v10_0_set_mmhub_funcs(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
+	case IP_VERSION(2, 4, 1):
 		adev->mmhub.funcs = &mmhub_v2_3_funcs;
 		break;
 	default:
@@ -713,6 +714,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
@@ -894,6 +896,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
+	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->num_vmhubs = 2;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 9e16da28505a..1957fb098c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -93,6 +93,7 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (adev->ip_versions[MMHUB_HWIP][0]) {
 	case IP_VERSION(2, 3, 0):
 	case IP_VERSION(2, 4, 0):
+	case IP_VERSION(2, 4, 1):
 		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
 		break;
 	default:
-- 
2.35.1

