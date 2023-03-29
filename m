Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981D2C77B74
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2517710EB8E;
	Wed, 29 Mar 2023 16:05:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7334B10EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEY+7uS07HDjUSpRneF92JIjGLRp68B48ndCBGJiMJWMEpOXz0lvEPVshlg2BQVSSSTp8ZpuLTLr2oqIp+2O0vc6mnHkBfMuiePAQZHhQ01ed6lpSgYTTmmyvySBs2n6cCftnPvIIQifg0B5/cRTgMwa8SWZAL/NpMq0SxODqrFZuxBFKIvk3AXanyH9i7IRfUoZwms5IXUcWkZfD7laSGzrI7HkRpEbOQ4hGP+biNqLou+gCfn3QIDW3FYPtL+alIFGZBSKYV/20qynM9Sx4cBQyb7UcubhbIbADfQxPSGR098RKnHSG6Zfb5M+kqRFDrYUW2eghkYSwwWdi0Yeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTsr9zTZBdVQaKWsC0tiNLObROxrUVXyEmWFHdbM4hs=;
 b=N64gnOF2Gmpa6t06cwZXeyZcVxZ8fP400ODnPNjJv++LR2G1NsoYw4rqCh7IpByi8TQ9Bar/ix5CXX+mJOuOoMJxaQBfZIAnxfbsvc21Jym64bjffjnFhs4WgsFC1NlSwem5n1SgIejlqB+1P0U4I8svY9Bw/zYFnIPKRW2Rp25ug6Gqv1M8HSBzgjxbKnMNkhdOEtCnOcT1vsAJX1RZRVerPwXPEB401mOC+DUtSAbOVNxAYKobrJiEEf7LKJQLmmIKo1KiZLyiQmtSwNJ1s9NtTUaobA8U/QX9xX+MlJTcXpeOMI1annTfAFs/PVpSjo12yzWC4/l3+dndHXZnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTsr9zTZBdVQaKWsC0tiNLObROxrUVXyEmWFHdbM4hs=;
 b=krEmgzLWdlgkcJ4sHAeZX8PcCTDNNPLOoRMMN5NkEM5iOnliEEDniCSHzTLhG2/eDMVWDlH7ZwF4g56kB8RHrBkgJINKOemz6InqTluLuSpsW/1rCIPpnIyzcGvzs+j3dHtCzMwdpaj0tmbbm68yhmxgg0FyqFcncXYJy8dTr7g=
Received: from BN9PR03CA0587.namprd03.prod.outlook.com (2603:10b6:408:10d::22)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 16:05:20 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::b5) by BN9PR03CA0587.outlook.office365.com
 (2603:10b6:408:10d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:20 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:18 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 9/9] drm/amdgpu: generate doorbell index for userqueue
Date: Wed, 29 Mar 2023 18:04:45 +0200
Message-ID: <20230329160445.1300-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a94efb-1203-4c35-9137-08db306f653e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZHHnij7BuxWkb3/rtri/rlxm8yZjHm60ihj6XCEI/stdQfGdiBotZJRTu1n0zlPsWXb0okx0XQPBweDIPp99WNFvU9576OjjfowlSKYF65KWcEgdNxW+W6kzW20I9AsM9YAcg+WIYmJ6FsOvUrxF3qGQlZ2xtM3GBKu14fH6R0rJudayshE6EK9ChMDkWdGMPEHPNcvWWxEXnHibuMPqALEwm7sr9NHNYV3PRvUi7cggRBAlPIIOyiJwvGaXDSEFILOq2PSmnzFHXw/G8u0KX4+rdGlxIbTzbCpeL+Si4I5FUA66f3j7P8uaQJ0xqBvtVxJv1vC4QkaxKgfmgXLSTrQ55I/o8fm43WKhFIgHWjxPMTnWxBmVO/0I+8Pv37MixYOV9VA1gU4ewjrWPJPLX8T5nYHv8lUYzSeaz6voiNEogNwpwve+vT+WM54FIfR5r3SiI43YMvBrQFdZf4wtaE74iYiW2hzDLcQaqU7hQViIGybI2icMvWrrt/fIf0jHOv9ftk4CbheSEpM9ksBLaM1Qf9Lcf8d7wJ8r1stOHB65i2K3EAqpZfXaRws/rYG1tjIy1Jo6oEGHcH3YLUnyLRHVH9uKYLl1UYU9Gwbt24PJQwgV0+w7oaT45DjLgZu2w7SYw87T0nCtXHxF3wsLB/fLaZae/akjRZ6GgZAdwngc1n1i6ZGgRYVAX+EMSfp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(16526019)(186003)(966005)(82310400005)(8936002)(4326008)(478600001)(316002)(7696005)(54906003)(70586007)(70206006)(36756003)(5660300002)(41300700001)(40460700003)(6666004)(8676002)(6916009)(26005)(40480700001)(44832011)(1076003)(36860700001)(82740400003)(356005)(81166007)(2906002)(47076005)(336012)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:20.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a94efb-1203-4c35-9137-08db306f653e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The userspace sends us the doorbell object and the doobell index
to be used for the usermode queue, but the FW expects the absolute
doorbell index on the PCI BAR in the MQD. This patch adds a function
to convert this relative doorbell index to the absolute doorbell index.

This patch is dependent on the doorbell manager series being reviewed
here: https://patchwork.freedesktop.org/series/115802/

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: ￼Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 7409a4ae55da..fd4a2ca3302d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -43,6 +43,32 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
     return idr_find(&uq_mgr->userq_idr, qid);
 }
 
+static uint64_t
+amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
+                                    struct amdgpu_usermode_queue *queue,
+                                    struct drm_file *filp,
+                                    uint32_t doorbell_index)
+{
+    struct drm_gem_object *gobj;
+    struct amdgpu_bo *db_bo;
+    uint64_t index;
+
+    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
+    if (gobj == NULL) {
+        DRM_ERROR("Can't find GEM object for doorbell\n");
+        return -EINVAL;
+    }
+
+    db_bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
+    drm_gem_object_put(gobj);
+
+    index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_bo, doorbell_index);
+
+    DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", index);
+
+    return index;
+}
+
 static int
 amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, struct amdgpu_bo *bo)
 {
@@ -132,6 +158,7 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     struct amdgpu_fpriv *fpriv = filp->driver_priv;
     struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
     struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
+    uint64_t index;
     int r;
 
     /* Do we have support userqueues for this IP ? */
@@ -154,6 +181,14 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
     queue->userq_prop.queue_size = mqd_in->queue_size;
 
     queue->doorbell_handle = mqd_in->doorbell_handle;
+    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, mqd_in->doorbell_offset);
+    if (index == (uint64_t)-EINVAL) {
+        DRM_ERROR("Invalid doorbell object\n");
+        r = -EINVAL;
+        goto free_queue;
+    }
+
+    queue->userq_prop.doorbell_index = index;
     queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
     queue->queue_type = mqd_in->ip_type;
     queue->flags = mqd_in->flags;
-- 
2.40.0

