Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B222DC678D5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 02:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF95F10E77F;
	Thu,  9 Mar 2023 02:29:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF6910E77F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 02:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYUf8jqE705ISAA68YfAGoW0BYut0NzALYJKsYEiO/MObPsZAwsTGv1LbsLd6Acwl7UpflO4HVAT5utQXWLML+HEB2ti3K1RoMM4dadp3sDQRVYFTG2oimcZxxX0po5zT5b5t+MzPN/tQBY3PlCc8zpKyl4MzeGaff3ZimjRLO87L3BxnUJd9R2zDNyX/SJhWim/PVbQg3Yeve862ReQWf2TTMOFEOKpRLNVM0k9tWAOs9TyowDdulcOj7CWZcSeCnrRzFQPc7ScX7d9PYGyg+1wdYNmSaK0GiKGhVM0Kxh8fF+G18lR9+onLFwUZ2Fe7rj8/cd/5ba8Mr1ofK19uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fXRx6SkTJxhk1KN2UpWHhib8bM+SN+o1upmi/+K/5A=;
 b=f6X1mLwXi7P4CZKLQ3gcWQXsQ3MR5ZLSNEaLBZA5Pz1F0IhJ3ZchyLbSSiZ1z2R2lq2gsM5P7mlALJg285sSln5VrSA42rPB43dZumxgQ5daBF00h2xH0jy+aAK6sjCUESOEoovp/bzSxtnenVIPK8IpAPsE23s3FvanYbTKyjGMnPCSlmSYGxwXJ5YneGtTefFLncE4evjCM47opOgfob0J5xv9Sn3jgoxSNv5+Fwcyo7+ltn04NzSUomK2uAsoKo2m1CdbIEqOV1KMGNfJTwNn5OGiApoh1RPRpfxNz5iFb+7K5QyeDMY1OlUOYVxRJ3WQIdPzlD+kCobB7Odakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fXRx6SkTJxhk1KN2UpWHhib8bM+SN+o1upmi/+K/5A=;
 b=4baEewTB0XToZOmvfmi84KaFuHDNCc2Fqtcdk2lfoAWpAPxg4Iq5SNZkKdSGZs/YevCQ10uuuvYJjQCboOFG3Klh2Fxwk4mKj4AEDj/yTZYIGTZ6IR5IJU3GuIJLQhs/vc+1xNQmkPWySLHKKreJ0QBTW9lK0HbN8meH2vtBKZU=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 02:29:39 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::78) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Thu, 9 Mar 2023 02:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Thu, 9 Mar 2023 02:29:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 20:29:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Mar
 2023 20:29:33 -0600
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 8 Mar 2023 20:29:30 -0600
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Date: Thu, 9 Mar 2023 10:27:08 +0800
Message-ID: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fa85ca-75e8-4778-3c1f-08db204621c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/yGwwPFscZAy9eFfrbjvF1Pvk0O+sw96LaJWOAvE7p0oyM+Sn8TMxEE0rK4bo7Pg+pMWC+dXXLNVnioAjcfSizZe06RmtHOH9/NyzVBzrE1Ttwu7VSqj2zp2TfN2+jw5LJzlTP90jsmlu3Z1VsOPBqo41Jx2QRLO94xn7Ykd795zD2Gwo8YSfbtDmxHeiRI/PJ0Sm7gh30gB85ou3E24MqekOJpZpBmZ4R+xd+FXy5eF0iBGEVtHbp/EWQPhRdg6HV9OhrXmyUlZSDxB4cWBk9JZFzyQ2J3vd2AvII8eR5GJqkTfTt0pEQeaqgq6NPhb+v/o5zo+Wet5JlLgfLLL0xSbVOYmsKVLYUac6soEl2ZoFC/b09/r0i0dZim6TJqQN47i/hKGAOj1FQ/aiUs7meOzhRj86pQbBsBYYA8FMpsBqFOgbb+p+JVk5e+Q886ig1ud+AA5fVFaGIqgcbxfpxHP1I1lye33KPxQ7biXIFAJrKWtHz+Am7P/H/rvF0hmk0KY+zFNTYpYX4xnEnsq9Ej4kcrsGdp73vuWADTm1Kp3RdrWoXgmiigN5hg2fEjYB3u5HvZ4zT7JU038OjhwMlZIatVhkiFwSQCgM1P1JgQwuOMrFuNxkf67S7NFQpZ4rB0QxAVXT0nl2tHTmwl09AgG/qNWJSZi1hK/ImH3j0bt4N7N1KuzRcT1UWNIe/VC8IKH/1TT3e8HytsTqfdGWc/HePNEVZF/y6LsnACadA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(336012)(47076005)(426003)(6666004)(54906003)(36756003)(40460700003)(86362001)(40480700001)(1076003)(356005)(82740400003)(81166007)(36860700001)(26005)(82310400005)(186003)(2616005)(7696005)(316002)(5660300002)(8936002)(478600001)(4326008)(41300700001)(6916009)(70206006)(70586007)(2906002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 02:29:38.7384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fa85ca-75e8-4778-3c1f-08db204621c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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
Cc: YuBiao Wang <YuBiao.Wang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2: Add comments to clarify in the code.

[Why]
For engines not supporting soft reset, i.e. VCN, there will be a failed
ib test before mode 1 reset during asic reset. The fences in this case
are never signaled and next time when we try to free the sa_bo, kernel
will hang.

[How]
During pre_asic_reset, driver will clear job fences and afterwards the
fences' refcount will be reduced to 1. For drm_sched_jobs it will be
released in job_free_cb, and for non-sched jobs like ib_test, it's meant
to be released in sa_bo_free but only when the fences are signaled. So
we have to force signal the non_sched bad job's fence during
pre_asic_reset or the clear is not complete.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index faff4a3f96e6..ad7c5b70c35a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 {
 	int i;
 	struct dma_fence *old, **ptr;
+	struct amdgpu_job *job;
 
 	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
 		ptr = &ring->fence_drv.fences[i];
@@ -680,6 +681,13 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 		if (old && old->ops == &amdgpu_job_fence_ops) {
 			RCU_INIT_POINTER(*ptr, NULL);
 			dma_fence_put(old);
+			/* For non-sched bad job, i.e. failed ib test, we need to force
+			 * signal it right here or we won't be able to track them in fence drv
+			 * and they will remain unsignaled during sa_bo free.
+			 */
+			job = container_of(old, struct amdgpu_job, hw_fence);
+			if (!job->base.s_fence && !dma_fence_is_signaled(old))
+				dma_fence_signal(old);
 		}
 	}
 }
-- 
2.25.1

