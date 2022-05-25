Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E12C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA8710E238;
	Wed, 25 May 2022 19:05:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58FE710E238
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJ3RIZc9pjDbZAzHRms8rSVYrOfbUaxwb18ZMplWC8AoO6gRpSja8KTyX78GTFs5BKIiXs2ld8/fyGQGBPU3wm9cWiJFgLlD5Y1dRfvYGTaRmqQrjDdHYwq+vFpRYc8QBSfuoAZq/DfbwYss9W945IcyiMOwoJp4G+JNKsKwi4iq4E8X1u3/tcbXB7jj9tynJ3SRyrg6EY9ZjV3ppjNACZ7GvqxneWpIt68dMV3Ukq44fdNWnyH5elRVzvd7/W4Sx5KLKgpqRfLqN1QrX3qiOJONUTlO/PxtvbFIsIxZeORAUD1KHMSOI+P5s0MaMj9FcoYZpMvZrGbYuOJsNJX2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgGz+cJuCz+/rnqXr8lJx9xeHXLC2tSEmvfEdGGIjV8=;
 b=Kn62X/uCypXKs5J/0K89G43hnN8QKJc7K18QGRE5hiuZ42olXE+goL7oj6dB1IB4+rRfFnxFaRYsK6BfPqtRkpyUsQppRbJvtpJXPJjUTm3izBsR6JQDQSIpXAw+m7XOX2uig+sOv8eYSfOo8i+qBsidCXoJaM6AZmIYM47Tsi5K0GpFdA9TVxF+f70mwx6TyubWmDI/XeHdkVxnNt7xV7CQEECixIS5XkiNTw/xxIKPEc3IL7u7rC9HYRQemzye00aUZoN2v7kfb3SM5gnCDmrpODpIRgXT5S3zxHr8kWoIteUpqSRS6WQ8QWTXK5UvKN/4602Nc9p6Mxu64F9F2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgGz+cJuCz+/rnqXr8lJx9xeHXLC2tSEmvfEdGGIjV8=;
 b=BBBzY1nJgtbvVd2IyaOEvUXyt/+i/Yoht2Z0CVmT2aHCVZa5f2WKrrcT4Oj40l9L2MCUGKQBDj0QRnhjDmytQlCc5AVoJ/IQ5O9bBCUNxK5wWzLCgikEiJmBxY8QUwTEZWmvKXxydJbZh/rxyMhZBPUSUMF24nuLQW2N6MFxDmw=
Received: from BN1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:408:e2::33)
 by BL1PR12MB5094.namprd12.prod.outlook.com (2603:10b6:208:312::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 19:05:14 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::b6) by BN1PR13CA0028.outlook.office365.com
 (2603:10b6:408:e2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 19:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:13 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:12 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/7] drm/admgpu: Serialize RAS recovery work directly into
 reset domain queue.
Date: Wed, 25 May 2022 15:04:43 -0400
Message-ID: <20220525190447.239867-4-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdfd1878-f0cc-445c-53a8-08da3e817f91
X-MS-TrafficTypeDiagnostic: BL1PR12MB5094:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5094DABC8DAF20FA4FAFA407EAD69@BL1PR12MB5094.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eU/cHZlQC7xM+OSSfE04ISNW0k+BOVabpUx8cixOfwrFkKOsFVQ6qK+i8P+wnZnLoaMKJsVXlgUbHubnII8iVD1q0G9bmNDwEsZVu+f3MBYqj/ke9dWxnJdr7W7tERUowp7M8nS7wt+SzwRM0HzAAw1D12kjvRQIx0+wTRvX2Bjza7TOkzrzSMt8V8zHPsYEqPbBnXGJPkS6Ga5PY2Z6xX5Mqo41oDdXowSU8wRD+VxAe5UCtSVpF37ZHjReLW5GWo6Hhhy1SZTyJXtctZVY5VJJEW+MjoLJXv7ozfpQR1x73uq2Sef+Gv7n+7xfWM11DxCim/McfvdUkin/WUciswbqvfht5nXym+yuFMDrcBI7aauTCM1989pIIwRcAkXS7VyTtA+rxhgrxl3x4FFO0C7W41x1N9TFw4wbUgFE0UV0dxlJTfx7NfO8I8EFge95oTiCjmdsOlLDB0kJfw6IWoiZmGgcrpkPRa1hoQr+IbBlw8oIxRD5YdRWtjMmtOZ1vq5wa4KCbzy8TzdBfWujdzS3j7WOjdr8qH4WHaFeFZV1WH0PHrVPtDfCv20J6BQIcocyaffz+vUvwgllYaN3QovDbhY9yaNSJx3dh6orIZaiDP6H0JTID4p8SrGARpQASqjHZwe0sdfAOlJ/00f1ddtUY0wnYv7xMuczznoNkI4agUJCzVO5QEDzdxO//t7AW1XCyeugqAep+AHB/RCZMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(44832011)(6916009)(81166007)(316002)(5660300002)(8936002)(54906003)(2906002)(70586007)(70206006)(4326008)(8676002)(356005)(83380400001)(7696005)(26005)(2616005)(508600001)(336012)(186003)(16526019)(47076005)(1076003)(40460700003)(426003)(6666004)(36860700001)(36756003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:13.7499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfd1878-f0cc-445c-53a8-08da3e817f91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5094
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Save the extra usless work schedule.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 31207f7eec02..a439c04223b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,6 +35,8 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
+#include "amdgpu_reset.h"
+
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
 
@@ -1920,7 +1922,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover(ras->adev, NULL);
+		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
@@ -2928,7 +2930,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		schedule_work(&ras->recovery_work);
+		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
 	return 0;
 }
 
-- 
2.25.1

