Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08175C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA60461934
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 07:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA60461934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 393B76E30F;
	Mon, 29 Mar 2021 07:50:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E38A6E301
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 07:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ7HDawSFvQBBwwP1FyFPvQsDbAPMZDZIzLagiefJB9eXxLGDUVkYontXIdl9BMUBJpkj0VFh1lLTyM5vJieLalagTSio9g8yysjDUx1o2A12vdu/P6KCt8Ot1IqPV35MfowbrWC9E5Xlgxc7EpyZNa+s7W0vnda1rRjFf/POeSAAVj3Xms/LEHDLV95PzWYE7NME5PdXgvnG1EmtC9vUTAGvkJBvLqdWOnxOau2va2ez1tOEDaRxFbcSl+EhFLlVXABBSqpjB3Hq8IXVkPJ83RAFYfg9SgZphSvex2VQUD2y8Z9qt93g/fOWKayh/Ht6FchoTRgPKK4it+ZgEmC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsOl43f9EiKbFASYZpDRqXClYFkrhtTEoL1XzvFlhM=;
 b=iJTHTKZpXHFN2stgSbAdQwp/x6XHD6pxyFTIM3Q35luS5fgI5VuVsK7MH7Ef0DmL7ZgUX0SbRkSG+HH4qMoeyN2VcpVyns69vqu1P4Ecsg0eVns/2LvJM9FML47POWR8uL54skypryj4n1SJdIBpT6cRLW0TQHNLwcPbcoMUZVzlJMj2lLBMlFQC36FNRtbWVe2l2xXsYIRCnVPbJ19wNhbY2DExE6aZjtgYrFJt3JCrHQfhbCIyQq654qlyJf2hfSl9g/iYeaFOxE++205CUbVzrpUEYqPB9MNWJgfkWHFm0TZh0aZ7Rdl3UvMOWTxPS1QlVir/BOJgXPxpZetdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AsOl43f9EiKbFASYZpDRqXClYFkrhtTEoL1XzvFlhM=;
 b=ilJsFdCLEiX2VllMqFu/foEW7oEoOBZrnNnAEUgH1/CErVOcThZBk6wBEdcIMCE6gWUJxhEvcaLH+t3dvEM1tc2uwLnAnHqxrB8e4D67fjjYeNP+Fg3U0nAiyhry8TE8VHlG0p8sG+KfmgV00bekwBKT43NfQ0FIIXy9451iJ20=
Received: from BN6PR19CA0091.namprd19.prod.outlook.com (2603:10b6:404:133::29)
 by BN6PR1201MB0145.namprd12.prod.outlook.com (2603:10b6:405:4d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 07:49:57 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::7b) by BN6PR19CA0091.outlook.office365.com
 (2603:10b6:404:133::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend
 Transport; Mon, 29 Mar 2021 07:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Mon, 29 Mar 2021 07:49:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 02:49:56 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 02:49:55 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
Date: Mon, 29 Mar 2021 15:49:35 +0800
Message-ID: <20210329074935.10822-6-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329074935.10822-1-Emily.Deng@amd.com>
References: <20210329074935.10822-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f78b189d-b99f-4af5-2124-08d8f2873f90
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0145:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01452AF2A4A7BEFC04FECFB08F7E9@BN6PR1201MB0145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br1Md7vP/4u58VIhks7OGOpLTIfyMn0w2Kcc26ptQMKvNuWoBBGPRfnrar0Nw8MvZi0VUpzXDDgk8X/reGY2yloWOVclQx5t1AtpRaMeAIbsXtAW8rdx96nFzPgY4D5KJeIjQPfUT6mIYPnFZuWMiRWvAnvbW2DQybN46EH49FMmUvNw0C563UyNRoxK1CRsZaoGFgA92sO+/Lk/qEAgmT4n2XDULxLKRzsARjLeOWic7GFshi1gu7J035hG1eJQkQSkPI4l70AsGsYGlKToQrVOUYzPbWMr23nzgNiVLRNR8jpmCZwFmjZ/GKGuhdyE8icDTU3heOBhIPYT66n26MsGmD8O2Z7LAjhQLktZSZGfbPR8Tti0NQ5u227T2pYkFfk8XRwnG4xitIbywuZ4ohPCKU/wy232//bFYqEs5Hr5WOvIAZjoYa7qo0mH0OEs4W3NeKwy8ucRIassLoUkS6YyL/YDupU8AgDQdbv4BSjUtwbSVuBzbOe/w3ZDZK93hjwB4/9YvUb9vmdcN4L4V2ZOaBwkCUjQOFBOyvHOJz+zwpuK29qpT52FMvRDJPOdVdJHPlBDFBt4KyOe7OPjNFMRENPPq2boYuJR8x3YEa1CHHYmCAAXtnHor7YjdGlx1tPRZN6xwFDiMe6DyX3bvtQSs1sKjPyHUWDqkDPx9H+vJ7BJhUpZr42vXXHjuzEx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(356005)(316002)(8676002)(81166007)(7696005)(4744005)(426003)(1076003)(86362001)(6916009)(36860700001)(36756003)(2616005)(5660300002)(336012)(186003)(8936002)(70206006)(70586007)(47076005)(2906002)(478600001)(4326008)(26005)(82740400003)(82310400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 07:49:57.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f78b189d-b99f-4af5-2124-08d8f2873f90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0145
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During driver unloading, don't need to copy mem, or it will introduce
some call trace, such as when sa_manager is freed, it will introduce warn
call trace in amdgpu_sa_bo_new.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e00263bcc88b..f0546a489e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	struct dma_fence *fence = NULL;
 	int r = 0;
 
+	if (adev->shutdown)
+		return 0;
+
 	if (!adev->mman.buffer_funcs_enabled) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
 		return -EINVAL;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
