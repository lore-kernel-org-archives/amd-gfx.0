Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E7CC46467
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Dec 2022 19:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BA310E223;
	Fri, 23 Dec 2022 19:37:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5220510E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Dec 2022 19:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUboNRZx1wSfMmwSCOidMqUa+K8y8qxZ081gicNGk2yIh9kVQMJB3y8RT7bIiDPoMJYvptmKoDHHzTO+iUKjtTo8mQvh3fVA8t+5guZ71oC6q+no0vkJVr2zHZjBoluN5MH9uq7CjYRqUnscN24sXPvOizjoDoiCAa39D8JEhV9yREShsXbfB8nLHEcFYsFdoz41Z6XvMZNBUBwK5m6FpDlJGPYPn4p07bESQC0U8/p26s2A3dolY4z6G7imahwHlk38kFRmKzvyFvD3YDEOMx2b3yLlxOR6pbFvnQPDELNtlyhUp81+WCCqIG8kJ0EN/ScLny2w427VMcFqPH9ncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cbhy2GYvQDBWV87ZWiZlOdBXOF/wQrLV21ifi59R1G8=;
 b=hkwlaP9WMMjdW2yeo11V918Po8lpQHttiuCag769HfKkvBKjNPZnd7kC/kDPVTH0RcKv4JObnWJfJg4AfTjSf4Quh1LMRNZ6TLJZmPLokbVVbKLNUgiNx2w5P0hmsNjCn46lXYNEiargulP6xX5pDynCsFF7CuGfpkXG8Dq/5gno5T3qDB53ZfWJ0V6EDd30jKS+wFdBJyuqKYg1tRBmMjsug/nGmW6BsYHr3Ym7/WIg+0BEYUESZ1o3wGE3hGdrWM7k46JUQn8t85BSWxE5GG3a0agR9tJQrYrzatP8nxtsQ0dIMeRreIwDvtTvmBdFkrcN2cHmQcFoLdu14h0CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cbhy2GYvQDBWV87ZWiZlOdBXOF/wQrLV21ifi59R1G8=;
 b=w2m2siajYZ+5L1QZp6ajMOleZc8lEgWUJUU1WhENGjMft1lfHKK0b6uez2M5tjREE2BnOeHdmR9hevyI7fTFwtZqL67BmsubfCSeW71tMRuR4u3g9x0bQRvZ60zgykiniraQ6WJdaDLbOOaPk5DbL8AlAlqwJzr0jKbimQCRbj0=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 19:37:31 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::b6) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.11 via Frontend
 Transport; Fri, 23 Dec 2022 19:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Fri, 23 Dec 2022 19:37:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 13:37:28 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 4/7] drm/amdgpu: Allocate doorbell slot for user queue
Date: Fri, 23 Dec 2022 20:36:52 +0100
Message-ID: <20221223193655.1972-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT055:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 82217688-54f6-4c58-9b63-08dae51d21b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22KM4mK25E5yd+Otpy6NQkN2iQ27kZhWTXJjDP37QDm6X8TADViJ1TlDc4FXMFr5NMO/M9gQwKeI33vSfszAafmgwpJEAnKXLTzLiuzaj7hi4KKTPwjs6tk4rHrDJnt2DA0urbdXJVIquRgxnwazzXvgHeNagcx7I0CrhwCop3hTVeHvHYq7yS79ssWpTPX4WxEfoFvNoQB9hmgGHJKcKJRSfsvjBUwcRWxcYG74t5DBkWWZnr5lliGUqnh9LnQ2c4a8SY7TQL2Bc9AZXk9rL88Ht3d1PPa7qUakG3Uy7QEZ03HWvBPbtvf51anNy3Zb8JN+n+FCKUE8vCAFjdHP7sZFxIr0D9eGvw1ix9ZT3wti05Ruwkj0/V2W66fysZTVX54xsXAYZHbWsMJcijLJkBL2aaS3cb0EoVmOSKRd6cKE2jRhGNYySyomOuF8l+UezNOu+NdNMM1y5kekYxS/Z0g9R7MGEaIzmxX1AEwLbP/DnbsRunyVTzxI8rO/iA1znn3xCLJEVdzASlj74piJurb8u8NvSPkHnnqagBAktJVNQBWThqxlA69y/y/NBfv5A+46Jn7AQKfhwiCTkpn/ocsKMHT5moxrJ5mcB2xlA3wok2vuD6mmaB6N6fdXkwDLGOuwvvZ/8zQOJsDV8nWJGMdhlB8cxe7qjYdCXTZPKw0mM42uk6xHkEOp4WnN69k/R01XHj+THZGqirjcHUnO8PbnbuiU0FWF8MfRIMuFJuA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(4326008)(8676002)(41300700001)(1076003)(82740400003)(36756003)(40460700003)(36860700001)(47076005)(5660300002)(81166007)(8936002)(83380400001)(426003)(356005)(44832011)(336012)(82310400005)(2906002)(478600001)(6666004)(7696005)(316002)(54906003)(6916009)(86362001)(70586007)(70206006)(2616005)(26005)(40480700001)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 19:37:30.6727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82217688-54f6-4c58-9b63-08dae51d21b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch allocates a doorbell slot in the bar, for the usermode queue.
We are using the unique queue-id to get this slot from MES.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index a91cc304cb9e..b566ce4cb7f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -50,6 +50,25 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
     ida_simple_remove(&uqg->ida, queue->queue_id);
 }
 
+static int
+amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
+                    struct amdgpu_usermode_queue *queue)
+{
+    int r;
+    unsigned int doorbell_index;
+
+    r = amdgpu_mes_alloc_process_doorbells(adev, &doorbell_index);
+	if (r < 0) {
+        DRM_ERROR("Failed to allocate doorbell for user queue\n");
+        return r;
+    }
+
+    /* We are using qnique queue-id to get doorbell here */
+    queue->doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
+			    doorbell_index, queue->queue_id);
+    return 0;
+}
+
 static void
 amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
 {
@@ -257,12 +276,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
         goto free_queue;
     }
 
+    r = amdgpu_userqueue_get_doorbell(adev, queue);
+    if (r) {
+        DRM_ERROR("Failed to create doorbell for queue\n");
+        goto free_mqd;
+    }
+
     ctx->userq = queue;
     args->out.q_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&adev->userq.userq_mutex);
     return 0;
 
+free_mqd:
+    amdgpu_userqueue_destroy_mqd(queue);
+
 free_queue:
     amdgpu_userqueue_remove_index(adev, queue);
     mutex_unlock(&adev->userq.userq_mutex);
-- 
2.34.1

