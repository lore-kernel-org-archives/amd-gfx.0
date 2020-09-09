Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A10C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 08:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E0121919
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Rb4XsUqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E0121919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2C889D89;
	Wed,  9 Sep 2020 08:56:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FC889D89
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 08:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1erSSlog7sgxotlSQEyPCNLazcnexsNja3kajtvQ0S2ZxRttpxJxPXw8N5kkGwHmhitp3z/YaQyO8WQHgViRPBQyzEG/IzzMDdMr/j4tIW4RnIUjmnP9QfoP8KBdjM6isQmfIxU/iqLjc3oueuyFkcqdTTBWCTgwqgMlb2bL8HWzIcuircroY4SeOByaSGg0/exqSpIAH9OipBsdjZB8AM45idKVKkNizIHoHajlYHKQdZJQ1YiNmBmHRkfMHt9En1fByKC8sTp9tzZBMOlE51kG+ZqLu3PxttuCh9oLrA+uusxuidrAxo+JkiCeRsXH18a6pVEjjKBklywhg/LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUJ7i9UfF/gW9g/1v2UOUkualJMgUpDf8c1F/uuv5oA=;
 b=fsgcnMVs8LJDlkr7XnG5/iQWmEf6Cn/R1+6AYLisLxh6uDbGZ64JRZXkFjyWAyPaAEZNAOkS9awhjvB2x4huiqQa3oQcJaTunCbsnBSVjiSjg6Sk2cgqB7ZKw6OtFQPama7hg0kmTRXl4ttgYu7yRbpwpMAWKthGU6mprtFBLIztkQ6rtC7WhjcwemqXqjT06iKsISFV6TLFppB7VCTRs90LIVf3snyv2vAiSGoM8qkmyU8sDto3nDL6vjAhEiXzBcr8+E8xhyuLixlSSteQqsJP1UUpt9VaqjZC3szehnykmxz+B0CaNbH99lB3iVN09SvP1Oc4utx6er182tZ7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUJ7i9UfF/gW9g/1v2UOUkualJMgUpDf8c1F/uuv5oA=;
 b=Rb4XsUqTkqlvFPaRvdVkZjQcF2ElVZgkTISKnkIBXbFS7HIA/QPvkl5/UQrfQ41h8esoq36dKvEcntvCdPoAeeKjuNztRcv6ntH0UhQarUWHI9pduqX+IMa2DuvG61scfKCt8ij+xo6Bsf0qqjJmT78FoqVbQJEgso1L5IiB2zI=
Received: from MWHPR19CA0080.namprd19.prod.outlook.com (2603:10b6:320:1f::18)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Wed, 9 Sep
 2020 08:56:12 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::f4) by MWHPR19CA0080.outlook.office365.com
 (2603:10b6:320:1f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 08:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 08:56:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 03:56:11 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 9 Sep 2020
 03:56:10 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 9 Sep 2020 03:56:08 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Do gpu recovery when no job is running
Date: Wed, 9 Sep 2020 16:56:04 +0800
Message-ID: <20200909085604.804266-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d540d7-a9fd-4fbd-a718-08d8549e33d7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2761:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2761AB5BF88DB314B8A9D40F93260@DM6PR12MB2761.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqVPy32akVsX6h5j9ll1fvkYbgWrlSIWIJ7lp+2H3I1Xm8cdhtFuwoEhukEsfXzR0djjjSgciuqwoljg+LPJoSzicZBol8E2Hyq8oeyI3/jq94chUX6Hbh2IFUlBu2zF4WwPau+mmyHojm+/nQigCWDx+jPYAHY4xSw9vLbhC+EK1NfYXU/buI/HRvvqn/huhgQrkNyZ+PbI/A6JmupHib6C/uu8ReRSRyR4ND6GkccUu7v5hRcG7E//f+heLSFqbYKz1zOTn0UtelSEla/7vs9kJ9z1wCmF456cg4DZldRPBjUc3WZW6EAL2uohgC1UGg4SP2si5WWgK0aZLhJStNfWi7XftTB/8tcQgjGPA9WWYfuI7cSlG34Xstw0n30Wbr5om0H5kO4ptSga4B+ffA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966005)(26005)(2906002)(54906003)(5660300002)(82310400003)(4326008)(6666004)(2616005)(478600001)(426003)(8676002)(70586007)(70206006)(186003)(1076003)(86362001)(83380400001)(316002)(36756003)(8936002)(356005)(47076004)(336012)(7696005)(81166007)(6916009)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 08:56:12.2693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d540d7-a9fd-4fbd-a718-08d8549e33d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In function flr_work, do gpu recovery when no job is running
instead of when some job is running. Because if there is job
in list, amdgpu_job_timedout will do the gpu recovery.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 9c07014d9bd6..f5ce9a9f4cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -262,7 +262,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& (amdgpu_device_has_job_running(adev) || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
+		&& (!amdgpu_device_has_job_running(adev) ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 9c23abf9b140..666ed99cc14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -283,7 +283,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& (amdgpu_device_has_job_running(adev) ||
+		&& (!amdgpu_device_has_job_running(adev) ||
 		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
