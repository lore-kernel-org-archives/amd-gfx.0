Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975F2ECAAA2
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 02:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A0410E10F;
	Fri, 26 Aug 2022 02:51:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9410810E10F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 02:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPlbkrABqDSpx/TU+4IoRRTVWyIt0vL6OVLS7pPw4nJCwfjkwzB72O3oC2Zn3w++cEtGb7LWASylc1XNvpgRVFqsTTOdppOcDaNdq6xW9AiYNK0wPrvskBTX16Kpzx920lon8psKyHcgazfC2bJfXG3wrgV/keNSxakR2RsX7sKg9H1gly3MXor+k6rwkE86RErTIbbP9HsHb7igFS16bj+kJx6wFC0rO35xgIrfheZxk4R1O3LGOCYd5GALUALxBTeJPsyokR5jxMGJWMWFaxGiAFepQ1zfbedR68qZ6IaKvr27yOPdrFt48IH6lyEtnbCWtbKzInn54MWWyfUiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1drTfQN6g2eaw9qDNKUM+opqpEZUJj0oOq9c+Yrq9F4=;
 b=bHfyuRrgWfFjjRkNvr3D2LMVDiNrucySQ+EVmuSvG47F7srrXd5XJJIvbvRNjjcEdlR6bgYHtkBScIo/hLTZf0cOZJLZh7yk6aFYVJx1t4KobyV63xNGxCuHoxeolLELhjb30DIb7DD2hOT9d0J5E4//WtIzJQTQS9NTVNhzAVB72daqrBSaab+J2c7uJpqTcgstsrky5hjuwEyqF1tN/SYpS6M7fuRnL7BCn20QXAO68B5mCALlvUeBi63JwaT8WWCGIXHdPTKYaMoXw+/dLWNzCIRaAuEFtgN1x0/LLjWKjxyVBiZY090Ps74t0EOKadJB9ECaH4s12w0HPQdpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1drTfQN6g2eaw9qDNKUM+opqpEZUJj0oOq9c+Yrq9F4=;
 b=lYamICVAJfiMWQ8CwpIFjLRZ+yROIKqv7ZizTCiVP72x9P1Q3Tkow+RaBrSNJm3qCzHoEJfVlPyFy4ukmLnLFv7zo4KiBTH8hVHtcGscvgz/UH29+BEgPtQMOXrSO1XmNjeXvAFtzxpGZ6LUCPBkZ7a0nKPGl39n5stNa2cdHJU=
Received: from DS7PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:3b5::18)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 02:51:32 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::cf) by DS7PR03CA0043.outlook.office365.com
 (2603:10b6:5:3b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 02:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 02:51:31 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 21:51:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 19:51:20 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 25 Aug 2022 21:51:11 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix use-after-free in amdgpu_cs_ioctl
Date: Fri, 26 Aug 2022 10:48:53 +0800
Message-ID: <20220826024853.3724997-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4718368b-2241-4a0b-f1fa-08da870de1da
X-MS-TrafficTypeDiagnostic: DM4PR12MB5151:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkezTXAygHGUfLBlkorwTkXZTahzJIT8mu6mSFiPPOouKP63yqnws5h9xMcFlmDAdq0c4SUN1Q3GSsPB7b8yq/V3roih+uFtyXYeEIttPMgzMYQiB+qBbpy9c3C3jqj+ORxEbtKW2npFsQbHFbxZUr1PW0b5X+wTJekGoUwPowbyDG/S+xwfK5wECr1CB7PFg2Uc7WfGYeP/hn10jCtDmxCjO0HOtmZ8F+HztWxitxkXPLRt1xnr4oePYdyYpNktSq6IEg/nZcCEpQtMQmptkditu2blLCizM8dSM9aGL2MLEJ8EUfJDflbIjFCi1o/vWBcHYYebE0xbIluSio9ZlSofCj1em8h9jFbIgMwBlJzpm0b16Znw0WHi5kdJQZgggOyTQaLGEbe2E+V0+A4B6flm5fTbbpiuPm0vgfwhxxUEJl2Y6tPUuMqQybM5RHQuJPdBjHVKFp5jDI0d9Dp+bFvXPsuSmzGIyYkpQc5k0M6K86tu2uorqYr4y1N2WnSDly441cXF6LHOVcNFZlshHyXvv0jbSSbKpx5vxrYf1+oXVYNotBVJ3+k4Ilc+rh59Yd+IZ6Ebi8jzlNsf5U9KGCRWoqcQ5MZPLJr2Os9BGNhvfZplVgkEIiztqKnQBbEtBm5fhj82A5A51a9GMmEVhmrRLhxGKZUYqstDS61mGqeCihydJLAqzIyrqFnUjUBbXtZZJRHfLmHWlrjKAEePm/YGtPaaJbVtgsOqRVH54ZsqWH66bMYo6zQUYo0yxGmiwFqIqnuXgIo1ScAoewYmAzB1zXkPEOLGFjwM2O18aQnZl0zvaJhhFatEoux+OmBS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(40470700004)(86362001)(426003)(83380400001)(478600001)(2906002)(7696005)(26005)(6666004)(40460700003)(186003)(1076003)(2616005)(8936002)(5660300002)(336012)(41300700001)(54906003)(82310400005)(316002)(356005)(82740400003)(6916009)(47076005)(36756003)(40480700001)(70206006)(70586007)(81166007)(36860700001)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 02:51:31.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4718368b-2241-4a0b-f1fa-08da870de1da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk
 Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

This patch is reviewed by Andrey and Christian and pushed into bringup
temp branch. It need to be cherry-picked to drm-next, too. Does anyone
has any comments on this patch?

Thanks,
Yubiao Wang


[Why]
In amdgpu_cs_ioctl, amdgpu_job_free could be performed ealier if there
is -ERESTARTSYS error. In this case, job->hw_fence could be not
initialized yet. Putting hw_fence during amdgpu_job_free could lead to a
use-after-free warning.

[How]
Check if drm_sched_job_init is performed before job_free by checking
s_fence.

v2: Check hw_fence.ops instead since it could be NULL if fence is not
initialized. Reverse the condition since !=NULL check is discouraged in
kernel.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8f51adf3b329..1062b7ed74ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -162,7 +162,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
 
-	dma_fence_put(&job->hw_fence);
+	if (!job->hw_fence.ops)
+		kfree(job);
+	else
+		dma_fence_put(&job->hw_fence);
 }
 
 int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
-- 
2.25.1

