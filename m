Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8003BC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1447E610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447E610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F666E486;
	Wed, 26 May 2021 03:46:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8E26E47B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 03:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwun6h3f7RsbGIOPd+a2TDZMrEgxSm0wnjbYYev/MQMSUz5vH7ibJFAGeBGDISyF0GiDUe0H2/ThfmWMKqzl1gikCtsSSlIkNpDtevlWQf2VOqEmBQJljKfSMbbRisbh9Q2eGeW1DK4b/9BEViVNzJCiiFXPFyo1Snsjh42YWnfdcfPsbwfcfzK30s3u6vogQVR/nnNyBYE6/aCkMNRJb+MeWk2tf+htcXj44njUUqxAQeomR2cb1Toy9ZGy1L3YlVS3IxhY62b91bhuJtONd4E6PVijLtqMq5Dh/RgWJgkiAAu5kme21ou5s0SfViM3dFA2HSpklKWdMIrqH+Swpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8x92zfuh1IOVyoMbwYRh9FYV9MXAO8arHwhpOiog8w=;
 b=NFNgyDvAEWBQcCO23scHyn2krOFndcsFSO30lSrrL4WNXctJQqYLVfpQfOozMk8JHjIpA++Y0B+yNVDm51b2NYpXFd12jPfiyr+P1Eg/m3ZDcsn1IlF4fLO1ogNEac3bNn46TnST6y2z/AGzVMzFT40dRzFN7kZrtVgKYEzk1iA3I+n7J2OipP+iZFNWj9qQGGCQ6lX0HMCzA8NyCF3+Api2B20fQPr4Ka6HOzoEtCTK5Fstdep4nLsTohwZqAf1ZHih2JGxA4HYHQ9jjBSpLXpkoCkwLFAYNVPf0k6Yb85HbZqtJnuxvly1OBwyua+BMjRqF4ZFIO22LS7+9qYPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8x92zfuh1IOVyoMbwYRh9FYV9MXAO8arHwhpOiog8w=;
 b=FzLETaQ5Rcsd6W6bPlp9UV0Z0JyIlmGeRTAH4f+S6o6WwjKwVV1fDLJDN88kdgB6r/0puqECGToJ5dBwirFGTL5ETuKxEUYAK/xyTJfDcJFDcilo4AvWtKa/ejfQhUiAUgR7aTjagYZ3/tLFDV0odi7KAIzyGhUINiEzti9hFn8=
Received: from BN9PR03CA0650.namprd03.prod.outlook.com (2603:10b6:408:13b::25)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 03:46:39 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::cc) by BN9PR03CA0650.outlook.office365.com
 (2603:10b6:408:13b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 03:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 03:46:39 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 22:46:38 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nirmoy.das@amd.com>
Subject: [PATCH] free the metadata buffer for sg type BOs as well
Date: Wed, 26 May 2021 11:46:25 +0800
Message-ID: <20210526034625.5805-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70b631dc-76b8-4aa9-6e58-08d91ff8de58
X-MS-TrafficTypeDiagnostic: CH0PR12MB5073:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5073A95029D4BFC7732B6D50F9249@CH0PR12MB5073.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cgqfvq6DkBAo9FjHSF11gNBwtZdfbPYTDf33U9SlVq2pmbxVOx84AUGykISn1Ek0f+RrwlU7iUkcXk6QyZqGY+5l9uVlBiJFSlD8mcj8u9dwg10QHLoZDVCw0SIgMXgC2syTExtzxP3FG5aMC6zhzgnok6T/qmg4IIisaVHpnBKLEpS+eitN266fqEK8nSe6vFMBqmoXnc8rBqAar7741VZo+aMBZc7Hqzqg6rjhSEp0SoqeHJgE3+LaoCk4asrQ4i3x1T9KkVRnjJ0T/38QkBMmiMAi8woxLdoj3obCM610t7NbZw1t2NXB4DxY/x2qaIa7Hokj0Zs7vy7VqIN81F1KV/1wB6mrE3HsdCgfJftoCnTAVXFE8rtHe1Ep+CNEdlNW55CMF6dpKMlyJpPqsRY5W/J1r/dv4F/SqQO+ZMcgyP8WbEbLVzFrO8EsL+Z3pI+kVvYNvirGPj7TWvunzi/rFUsKxHZNDcEMABxkHGRESPsma1j8qub0YtuhvlwZ9hFB2pqXZ9SNa0UjE6lUckMeLqlnsZGpSesDeOhbiBfa+4idWe4lHZhgpc9JnfVGMjDoBw9TOtNzqX/tzo1IS9jw/qtRb2qfWWFfksHTVlftW/k4sb/bawwvNuj3MA1efCJU33iGR0jxpBj5aGtUjcqp3XzgWEaHvxzMlw4STo/rGFqTxru7IRX4i2cw0h4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(83380400001)(26005)(2616005)(36860700001)(6666004)(82740400003)(44832011)(2906002)(7696005)(82310400003)(8936002)(47076005)(336012)(70206006)(110136005)(426003)(356005)(316002)(86362001)(186003)(5660300002)(8676002)(16526019)(6636002)(70586007)(1076003)(36756003)(81166007)(478600001)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 03:46:39.1893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b631dc-76b8-4aa9-6e58-08d91ff8de58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2d876e1eaa7c..e9f8701fd046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -95,7 +95,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	amdgpu_bo_unref(&bo->parent);
 
-	if (bo->tbo.type == ttm_bo_type_device) {
+	if (bo->tbo.type != ttm_bo_type_kernel) {
 		ubo = to_amdgpu_bo_user(bo);
 		kfree(ubo->metadata);
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
