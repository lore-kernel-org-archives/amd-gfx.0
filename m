Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F91BCDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 03:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9702E10E02D;
	Mon, 23 Oct 2023 03:24:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 873D510E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 03:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrEMLKDBE6B/y4hcguxhghcf2MBq3WnNwTEoJBb/3lEhQ8r8cX6ydcDwCcBRvfZkb5FPpS3o62lFbQbemDwpvPJBzdRZrSOWIfKRDQerhnvDqLehjw6zxG8rp6eO6HrMuIzfgOoCQNXNhWN/fJnB8lm7XuFdcQAMyck+4NjZS1KRVoLi53dMS08dAn6Ui9/jZcPah/9AvWK61tEYlefeqnEsmvYkCyIn20IKZ9rhmKJkpbmj60OjrPdYn0geGp3M8Ghr7VX5PVh6rVGGRVPSJLbRmMDDjIovRFCyHKIp7KJTvSMabe3oaZ8QlDnkG728Oay7G5XCewDsBFI+zRZBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rRR+d78Ecr8oxycQxcBp2UCTNhX65XGBCqvzxUpmpw=;
 b=EnOW5HWURVbF+n6bwL6hK6SKMZ0b46M2vtrFBtk+bxee7JEh2q0ZaE57wGByNuIQroBKPdBjqH/wLmVoHaKe8akFc8OQeOObzfAFmL+fnL4NIoBnboHCwb1FVmAQ6Qg6DFvUxOTtBjFl3jzWuYjLP5yTDXUONpylIh+5uqGYyYfBeue6fb6RxwpsRH2tk0lm8ZtKsdvWXcBU9zz4CiHMAnq8dz0+qSgU1o4hMFuNC91yQRSJgiZdZxGsKBl2BbH7vyy5SCqvEeuutVW0oL70PusUqTJC2QXaSI460X4FpePqBPXqjzpzrkadIF+LwtnlGiSSXqPlP3jYZIIlQaywqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rRR+d78Ecr8oxycQxcBp2UCTNhX65XGBCqvzxUpmpw=;
 b=kPp8QQ5Pzx3mfyH9oufjqGoEHUEzYVQVhd3I3WFJMczfdnrOK4ysEa6m2cSANPOP1uZ9533IRItTqEvAVld4hc+jcKS/RNbWfNiXvzNuzgMDE93N3avPc+2XC9L45hNBpQibSMXXovb5zBJcExy7mbjcO9LROyvuzJogGaB/61k=
Received: from MN2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:208:e8::35)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 03:23:57 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:e8:cafe::60) by MN2PR20CA0022.outlook.office365.com
 (2603:10b6:208:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31 via Frontend
 Transport; Mon, 23 Oct 2023 03:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 03:23:57 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 22 Oct
 2023 22:23:56 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Initialize schedulers before using them
Date: Sun, 22 Oct 2023 23:23:44 -0400
Message-ID: <20231023032344.164925-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: e88c2992-80d6-4f6c-29b8-08dbd3777df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS+Xx0oZ6SAalKMbhLgnSoP+LCt2J/JDQo/e92jGXyCajcsihaMKfQ5AS5r/ZwNQwhDzNRkQkSWpmtHKEqt9AoT577rS1Kw0r3yKEJmXHfj2R+LVAob9A6BsHo8EWCnsBV5fTqHocrHD/NWnHY0zbz64BnCE2VK/+wOks4dLKyfWUEZ2njRYn9fTH0NlZ8hipkQqDWNMDive0OkSMvE9nC1pz4foR4OQKgQre5YTMpWwitQd1AprviW5HeRXK8XgzeRwsYsnCc0v9fhsEBLkJYl3lh9zsHFyB/6v26Z9wIcTG0OHYavNPwg/L5nRJlsykrfprNYTZILrYxc/eblI1T6Y2jPvBpEvR7v8H4wXxgFLu6wN9UJmtvMt6NpescotP05XY6GujBnsuhtsw43gti0+Cj69yYk59HjQFrqOmay6CmYHcAoaiEkew0JMzGoYEsk66I4X2nY8gfGFFvWspqEKPsWjLWPW5IMnVfNLElwRKnTuguIATXNeWZlZmudDa/oy3bKk0IgH2wvGG+uNIMjkSa+gaC+fpE6aLDnTtLr6VNyQSinskvjIaftj6XCliAeZQPXjSeYu+DHeYjFYsWo+K7nh6Ia8mVkh6mupYwO7QIb6uYXrF5ZvPkbP6qIV872Z4oZbohm0e94wbsGMYL0TBDZS1CuUWtxrwTUcPeZyOYQ3pO/q97RlY/LWaGdBo1FSAyu4zFjpMBK0YqrQniA2V16w+AXm6sadgPOdFdePwVBqaIyyaxKYFVq0l36hgy2aF+BDO5GdV1n42WA1ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(26005)(16526019)(2906002)(41300700001)(44832011)(40460700003)(86362001)(5660300002)(36756003)(36860700001)(8676002)(8936002)(4326008)(1076003)(478600001)(6666004)(2616005)(356005)(82740400003)(81166007)(6916009)(316002)(54906003)(70206006)(70586007)(40480700001)(426003)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:23:57.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88c2992-80d6-4f6c-29b8-08dbd3777df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Felix
 Kuehling <Felix.Kuehling@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize ring schedulers before using them, very early in the amdgpu boot,
at PCI probe time, specifically at frame-buffer dumb-create at fill-buffer.

This was discovered by using dynamic scheduler run-queues, which showed that
amdgpu was using a scheduler before calling drm_sched_init(), and the only
reason it was working was because sched_rq[] was statically allocated in the
scheduler structure. However, the scheduler structure had _not_ been
initialized.

When switching to dynamically allocated run-queues, this lack of
initialization was causing an oops and a blank screen at boot up. This patch
fixes this amdgpu bug.

This patch depends on the "drm/sched: Convert the GPU scheduler to variable
number of run-queues" patch, as that patch prevents subsequent scheduler
initialization if a scheduler has already been initialized.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4e51dce3aab5d6..575ef7e1e30fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -60,6 +60,7 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
 #include "bif/bif_4_1_d.h"
+#include "amdgpu_reset.h"
 
 MODULE_IMPORT_NS(DMA_BUF);
 
@@ -2059,6 +2060,19 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
 
 		ring = adev->mman.buffer_funcs_ring;
 		sched = &ring->sched;
+
+		r = drm_sched_init(sched, &amdgpu_sched_ops,
+				   DRM_SCHED_PRIORITY_COUNT,
+				   ring->num_hw_submission, 0,
+				   adev->sdma_timeout, adev->reset_domain->wq,
+				   ring->sched_score, ring->name,
+				   adev->dev);
+		if (r) {
+			drm_err(adev, "%s: couldn't initialize ring:%s error:%d\n",
+				__func__, ring->name, r);
+			return;
+		}
+
 		r = drm_sched_entity_init(&adev->mman.high_pr,
 					  DRM_SCHED_PRIORITY_KERNEL, &sched,
 					  1, NULL);

base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
prerequisite-patch-id: c52673df9b6fc9ee001d6261c7ac107b618912a0
-- 
2.42.0

