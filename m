Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040DC48BCF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B6061410
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 02:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B6061410
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747766E435;
	Thu, 10 Jun 2021 02:47:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBB86E435
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 02:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvUp69LQFa/qgVsiVkmOczpINSjQ4tdjPnijr4zYbR+3bL5d9Qw3War87SIl/sgHYgsJSk3b2SgU0ygmkP6rD05UfMqtI4/ksCNddsefhU1bAcgc63KMUCljcfXG1DVUZQTeOcpPak6FwVkEvVDgz1THlnM39EXsizTH2LmH5o5yJbIkpBng2mEmVx+SGpombG4gi8cNxA4APTq0TuIbe67lV8YQJoQWfBq/rN9UA0CadThLYDnb6A32Db3XTaLLGhxhrh5SXORhjEWvy8GJMe2dwMmp27K3Dw94EEw0vYmiH5vmSm1mLFteywHWRdhVNdP5DupNIsMzcS/LY2XY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw5IzftQHCAhQ/uPG92Bf08+ZpgrHMVtctJ6p0QDAAQ=;
 b=jl6bq/k9vYb1LktK8RLpKpKMn2y2t9s5LsR6VoavylykWBqhy03jJX+nx/c/2mmLUDLVt/USCiMq4zCKSVM0CUfGxK9O2Yb+DcTa35pSVN/p7XkkSy+3D7NDDIygEOIUbm6SZzd3LIls0p4gGSB2PBB0UEsvqF7NNJTAY9AjyGQtWNBO+uYAvxs7SsqCEnC3A1q3FYe2vCXUZJFO89lzf4ACbyXRFMWoRvg4sMTKGF4uQBQ/8at7Edyrt9SfgDUcuCeg8pfU55s2ryi2QMSywrJFgEXWBzzplr6znDw8IAPt8j0ThWF55j7hRjhRYUfwiujQmCVCfL7i3hLPGYOZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw5IzftQHCAhQ/uPG92Bf08+ZpgrHMVtctJ6p0QDAAQ=;
 b=QAXOzyCqqGNpKiTDzR9V6o8XNglR/PsAz7JTHuiKD+VmHYzef8E7CZA/y4Sy+zMlVRqG/7HIp4PR6cYF9TgALhrfH1WDE400AzIA0/iO1hAdHPX6LYSX9592uQ72HiwDkGbofSKtM38ejeVg/4FjGmfQjvhHnpf4Ng1ObZ2ocR0=
Received: from DM3PR12CA0097.namprd12.prod.outlook.com (2603:10b6:0:55::17) by
 BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Thu, 10 Jun 2021 02:47:26 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::b6) by DM3PR12CA0097.outlook.office365.com
 (2603:10b6:0:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22 via Frontend
 Transport; Thu, 10 Jun 2021 02:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 02:47:26 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 21:47:24 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <luben.tuikov@amd.com>,
 <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: use adev_to_drm macro for consistency (v2)
Date: Thu, 10 Jun 2021 10:47:01 +0800
Message-ID: <20210610024701.2984-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8582242-5fe0-400b-b960-08d92bba14d0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1539419D738FFA9FA23AA74FF1359@BN6PR12MB1539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bJ0qX4aBdb5SJaCtCA0HH/fl8uFdpQSlt0aobGmb/CI91oNRgOW/VyywiSwqPGRfy1bxz9w/8ImQL/uQ3EojFuyzl0jsGqBQc3DqvBufaLiZGkgURX6E8bWPCnKYLPZZuAlhaAifc9ObllwKzm+PXEVQs892CPY3+cnI3wSt7SBUd9d6efd4k2hADCxducDB9UcIYrFTgFgkk6lcNORwdw9DJWZCj2vIxZ/EgjtNdtPrTVe1onfQp4XPJZ/Xv+V1Z6RH0jdpgrHyMLYen55aAzEjG5+h/zWtL3pQzJrrIhGb51LPianMnAUau25FpXdl6N5jHp3g9/gcmeLfl78oC7sDW0KENMvF7QaQBcHu2oLq+pMoej9DyoHFfAHM2nzb1PKRdEyAQejqvdQJY5Y8QBoTaXT4TJNe5gpEDOHWeZ5kU2jQ5aZwPlmO/8n+h3CfbwZSHwp7sD1Sp4j7vFNQEialV2dtXtWfRr08rPHKiPwbaNxowY1Xs8R12dQFZY0sfPDz+yWzUDodd4htlP76Fs1FV/poHEUICiiYVmi8AbqPhshWx9s4Zb500+L9gLjBFDXvDpN2u54kUnL7mhkyhPRs/Tqzw5UdiiWB8kro8Ebbzo9ECh/fQ/Eq5bSDeExow6RBgwSmEJy5+3oIdJ6OnHtP6ogBLf74d8a19EySCOFyWTXq+m8klh2xEtLwL7k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(70586007)(47076005)(83380400001)(336012)(426003)(44832011)(5660300002)(86362001)(110136005)(36860700001)(16526019)(6666004)(26005)(82310400003)(70206006)(2616005)(7696005)(8676002)(2906002)(81166007)(36756003)(82740400003)(356005)(6636002)(4326008)(8936002)(478600001)(1076003)(186003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 02:47:26.1581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8582242-5fe0-400b-b960-08d92bba14d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use adev_to_drm() to get to the drm_device pointer.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 016815b7a773..fb6bcc386de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -639,7 +639,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 		}
 	}
 
-	gobj = amdgpu_gem_prime_import(&adev->ddev, mem->dmabuf);
+	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
 	if (IS_ERR(gobj))
 		return PTR_ERR(gobj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec936cde2726..bfbcb9ff2453 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2122,7 +2122,7 @@ static void amdgpu_ras_counte_dw(struct work_struct *work)
 	struct amdgpu_ras *con = container_of(work, struct amdgpu_ras,
 					      ras_counte_delay_work.work);
 	struct amdgpu_device *adev = con->adev;
-	struct drm_device *dev = &adev->ddev;
+	struct drm_device *dev = adev_to_drm(adev->ddev);
 	unsigned long ce_count, ue_count;
 	int res;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
