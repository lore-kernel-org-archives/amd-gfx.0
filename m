Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C8AC04FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 11:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292D46109F
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 11:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292D46109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEFB6E201;
	Mon, 24 May 2021 11:52:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85D46E201
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 May 2021 11:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHTuchA7VwsBL1EuNG9EVTOkeHq40LN4ton3JJA1+XF4HVsNMi7YOBurIiCULMZnKkhMs+eH3iri/iB8YICZzzC6Ddfn3sYONtewbBx8yZb++1TFyb6anMQFkuULDPzhER0fFbeu1Usv+1h5Jfa75Oz1VXjwDlSBtGWzyNFc9tzgr/4IkQMMEzuqQ0sakyVZJvc29JgR0yI/7VONFOCfw4ErGH64e6dw80Vj0ZfSl5bI4Ed4glE4K971AhjACoFJxeFeUhnj3346zJbZDZN6UjK/rfWJm2ciQrcm8HCBgtVDFuGxmeaPNkvM+ubQ0Ux1QswEQD//E5QeewWN5Ow6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZprGmednW2Ks9kGHZPtrcgqvhS3sLDGM4poA3wdD9Do=;
 b=AsnPJvm60xAVqowTTp7bope21NMLrj0kBQXIFsuxtub0gCMVxPKNalsKPdNNzZHqDewUJkckPSAlV23lmmtAXUlN1nAB1hiyJwRKYD74vUKOviKpaAKx+OLP4CHWJ4RmFLPEM9Yt6JJ2BmqjG79eg0TJGiebgYr5V/NTqHC93pCxErO2/FxZLVVsRN80RN+yLgcPZTdDK2+xFzOARNWTrgGd4ptuee1A8PvrNtC4p1zodfSL/OFIyfghXDeVqLFYMeGFdsv+GLGEL2jIVza0vmGdj6beLvShNdDddKkmKfU2/LO8UJEbQggqvV0w5iKOEjS99MJDa7C+czAmdUxeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZprGmednW2Ks9kGHZPtrcgqvhS3sLDGM4poA3wdD9Do=;
 b=sJ07Mr+FHzp+4wF+gzk+1l5RC7Ot35Zxk5wvOwLKiW8pON7/4Wi3boG/M7bt0R1BTCLnDywARCoO+Fj8mSLXNlRdyaepKu0wvPTJAMU2N+WKvzQCD4IMplpZDe4ZBvZJk7ZcjjjZDtAcka8cFDK3Rgu3oka0heURs3Kz+9RL3bw=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by DM6PR12MB4779.namprd12.prod.outlook.com (2603:10b6:5:172::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 11:52:43 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::a8) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 11:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 11:52:43 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 May
 2021 06:52:41 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <nirmoy.das@amd.com>
Subject: [PATCH] drm/amdgpu: fix metadata_size for ubo ioctl queries
Date: Mon, 24 May 2021 19:52:14 +0800
Message-ID: <20210524115214.26792-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb6a86e-a63e-44d1-ce05-08d91eaa7090
X-MS-TrafficTypeDiagnostic: DM6PR12MB4779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47793999B1976032CFE1E063F9269@DM6PR12MB4779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRGT2RXHKvqJ6pRJyPmpjOvHjqX8ti4EppRH8sne33+5cuR1hR67CPsehUq1iGzAjpagzdXRzjnA/Ok71SsJH9w/vMZP/yMfy2BzlGiBapkoqur1ITNp9nT4IaH3w9uukxEyVvl1T9Wiju13c8yVg4WQN25eQmZPN36GoKjPl5XA8Aues2WaRQyrdKRrQXSpZYvcMnqbq6g9pAAJAIoYZOreSGwk61RjRHuvdId2zv0ti5KMcOuYRE3pYcj+rhMi6rYES7VEUGlmpKegfyBr6FOSVnUyJG2uTcjEjGil0tevTeqYpXFATioQBOj7KN0hUvv48c4TGoR7r9JujWLH4RB2Ut0J88pelHPOXqKrfKZ+eUYm4h/a6No4dcdK24yiXThCRD6WZn4eAFnBsJg/Cy+rFq5CjaLQnQUuAH8bfvDNf2pFrP7G4Dzoq1GdyCAYj0jAqGAG66B8XLcVA2JLQWOKWfQKaXil5+LVk8PSeJJSTvtTo8auKskMr7k3rACa8WYIvym0hxQfnkqxRfZiToG0WRfLM+PMWMwcz4Dn/oTlVfwPR4G0L8n8uBtFFDxNlxua7zHvCn14IRSmXKr2TQge4MbPK2ML6SRAG7bEHR6anvWYh7Uk/XF9ZCbsYksPEXftQVObpV0oumNQiU9YmMzQjVa0s1WdUfSJ+vX/oGx4mX6yccishWWEDifP89x2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(8936002)(316002)(36756003)(36860700001)(5660300002)(82740400003)(186003)(47076005)(8676002)(16526019)(86362001)(1076003)(6666004)(110136005)(70586007)(2616005)(478600001)(70206006)(82310400003)(336012)(83380400001)(426003)(26005)(44832011)(7696005)(2906002)(6636002)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 11:52:43.1007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb6a86e-a63e-44d1-ce05-08d91eaa7090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4779
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

Although the kfd_ioctl_get_dmabuf_info() still fail it will indicate
the caller right metadat_size useful for the same kfd ioctl next time.

v2: free the metadata buffer for sg type when to destroy BOs.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3f85ba8222ef..e9f8701fd046 100644
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
@@ -1213,6 +1213,9 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 
 	BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
 	ubo = to_amdgpu_bo_user(bo);
+	if (metadata_size)
+		*metadata_size = ubo->metadata_size;
+
 	if (buffer) {
 		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;
@@ -1221,8 +1224,6 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}
 
-	if (metadata_size)
-		*metadata_size = ubo->metadata_size;
 	if (flags)
 		*flags = ubo->metadata_flags;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
