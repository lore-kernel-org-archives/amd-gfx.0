Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58FFCD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C8410E5A8;
	Fri, 12 Jun 2026 05:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwA308yq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E74010E5A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaAlFZM77H5ord3hQs/GMmS7/am0TOn+o6rdIJXdwapnbbB0jMk896t+p+t3uYqxbOgHRvZGm6ZDDubNj2yKJFh7wr3J2OdaU2GeUP+mb91huHNgvtBbP4HEAXmLReNhWFARoXxJ6NacXa+3HsuKGf1RYFd4L+/P6hZseIag9tebHzgdR4EI6heqttblm6oXaCA7w3ay/xKN9pEAQIATXDYIQIdnzR2QVsJhwoJK4vS66EwLD95m+GhVjDQW/dSgj8IhFINuNA6Wp+OPSL93zh9fF1YGloEaLrvwP7sKD2PMWLrprwG85UwNROKldJIxzArMPyC0Z+Fcio3Ta3dpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yYVlmt/FQJKX7QNnNZMOWBeCgPRLX24uRrDH1Am5po=;
 b=vvbim8ANGmVGhtIWD1FIThubeMCMVXEXk99rf9J+RMu93gxpMqEUtoznjYawMZMCeZ7TAkbpkknkeFChK72zXgNfVCgjrr/HV5WdC4RNHQH2lrf0oH1MsGVyWrbIpzQ6qhm/vLsuTZqynXtbeYSTBWFum8gfgTOIdUg0wqEW3A7D6LsF06eG3a9G32DkT1P4ql/qPTuT9K11cOC7u9wou/mm0CkZ3DuV0nyalELYQrhBMML+fBVmu1X+EL+nUjFKwUuz94kgQNiKK4ZswSLLcLibAa+FwPTJlqXF/ErIHemuw5rR/WRQqCzpNoJkwDUhQplZHMiQQL1XAvLNaOebHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yYVlmt/FQJKX7QNnNZMOWBeCgPRLX24uRrDH1Am5po=;
 b=uwA308yqIVQv2t6C2WehRu42VgRrnvscwCxhdk5oNgR185RMcoULDpFL24JF/EJcRNB7Tk5R9OrVLS1DKAGwkVI8xN5st2VnBt5Fd6zFvKQQI4uMofCJy2hADSHW+n/0+m/TfrYNcH3VZX49y0s5Nhlg3CcRClWHzl7yfK1k7hY=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 12 Jun 2026
 05:53:02 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::7d) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 05:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 05:53:01 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 12 Jun 2026 00:52:54 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/gfx11: Signal USERQ_EOP EVENTFD notifications
Date: Fri, 12 Jun 2026 11:22:22 +0530
Message-ID: <20260612055226.2879270-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: c7110453-d4f2-44a0-ce53-08dec846dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: FixE5LepV9kMwsbEU3M7KDHsNEYyPvknQukL55hu7u8GbZxDg/HccUC87LZSO3hsAyeOLnUv5lyy2367Nf2x0IVtKhKeYsvLdvv/bTW7J/otFtnJU7+E3m1VZUUgwyFCrTTkBclmxJrJ+rPXGa4n3mOl81UHNOLlcotti7Oq66eVbYywJDqCbwcocg/f9m+4KBVVAEzwQpYIG5PBA7zccGykqbmqQBDo879rlw8BxJ5tD+mZDktJ0M7PbldLExQQqk/anYQKdcE6nBlHVk/Nm5EjwkgrOwNdgUsDYJvCIT+2fjR/2xVfyHQAvLTDbjTAJsklfLK3mbjXjvXpgBg7NNtPkc8xstMSdoYDeLMOPRqWRDM0nMGGuuAbfQQU8DbdEXMmlKbbR6tolakWtH6ekHC9f1ktOwixGiY9WCZzRTM8IqwCSVvbzMYrx+g261lpgjWjbwxFe0gptkZ6L+b9DsHR6sYS+Rea6cHBMcwzCkFxc0gQ+PSeaTElAQyINFHuz7zbLdtKKbSaoS7S6ANQKJmp1Wx2J0HxvihKd0ZynbF0Oe32yPuAamBF76B+MS/P8xfzNegykC5G6J8sWdcwPSCkoVWjkTGHvNraU/W5e772qP7gSoOj4cFzVMNSY5RcVBJgQOSiXMqhqguSAuL/u1qMSi7hKa31uQxFFf2s0z2fEs0mnXd8JvmoRE1iFdyIXE3O2Z5tE5YbZI0obonw69Xt6PfqJ0p6e2lUIf1Dbx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ihAL4d7E4f2pnoVQl8f+RtGpjvpkkzbk0agkc4hmLHRXz4OgePGBO4MhEfq8xR+mQR5W+5+mmogckhxJw07eLiMB5kOttonBeoDv43vb08TWuDXKj616qyzDUR8PP5pDojysP/9rzquvXbP51tpmXfzHZ0uf4edXvXETmYGUVsvwfNOmtSyY+gtWW0v+D7I+E3WXPaXH7tZD9kGyqLv27IFRaT7+OIgOH579dtig50xAlTTp6mMpNclFT+3T+EZHaoXABQmxN204r2GpiL/fqi5rrHyVZQ7XW2enHPqD8fqCEyhApto2qWWKUumUxSPvurDBtklbcMvD73tFF6u4h538OXSs4aIJ01TbcoGinrj05yTI2vQG6tOFE0VjcWBye0IONT7nmv4DLXYQCd10sIrVLhEQGOhqAUeJNlPM2sMnpFbRKek5uXNYniXKe5BF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:53:01.2593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7110453-d4f2-44a0-ce53-08dec846dcfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320
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

Signal USERQ EOP EVENTFD subscriptions from the USERQ IRQ path.

The EOP interrupt already tells us which queue completed. Use that queue
to wake up the matching EVENTFD subscribers.

This keeps EVENTFD routing based on the actual queue object instead of
queue identifiers or doorbell offsets, avoiding issues with queue
identifier reuse.

EVENTFD remains notification-only.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1941bfbcbfbf..565447d7790b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6488,7 +6488,22 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
+		struct amdgpu_usermode_queue *queue;
+		struct amdgpu_eventfd_mgr *eventfd_mgr;
+		struct xarray *xa = &adev->userq_doorbell_xa;
+		unsigned long flags;
+
 		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
+		xa_lock_irqsave(xa, flags);
+		queue = xa_load(xa, doorbell_offset);
+		if (queue) {
+			eventfd_mgr = amdgpu_userq_eventfd_mgr(queue->userq_mgr);
+			amdgpu_eventfd_signal(eventfd_mgr,
+					      DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
+					      queue);
+		}
+		xa_unlock_irqrestore(xa, flags);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
-- 
2.34.1

