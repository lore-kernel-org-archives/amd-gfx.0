Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA524C5DF88
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 06:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B7610F20D;
	Fri, 21 Aug 2026 06:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PiI3bWAx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B3510F20D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM91KW9zKTnFgdESA5FW3OWxXPXJHAmLEE+K409M7pNNtaj5+nlMk1pOqA962quwCXOKlcYAyUhNe1Qo4ZBby+2Ho1tpJEGchxvOsoyjPz/dt2UJ4dh/Aw0H2ywwTAIdh01qXMm62caM5yn62yRX7JAZBsWLlj1xGuwRd5wXEghNUAMaVWeZAG4i5f6YI80hlyGxP3Zip6duH/KmLWp3mIRIthMvLv6DTilnPEDcztsqevzNowWYKQ2W4Hnw06d1b12mvs1Fakti5cA7FFC/og0PUWMMF+iuriXVV2cMac/cxiWrRw6C7fTKdkbpcPKJaRjxq9wl7k9/DvbuZfiwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5z4ylwMDdlcJrzT1bv5KfyCz9VCmy9rC1GQv+9QR6Q=;
 b=QWTaBQAJK/0W2BdNc+28XvqmcwXd8GCxMqjzhr8k5jcttepkznuykbbO8zIepuNorsrvtSeXNoM2Q3jR8iotMPbe27yjqwT0WxMMgcoNEJ8byud7tCfL8OanB/SSDP1F7R5KcoWf0Hka5KBuHsNn6RrUGiWDZjAD33ijQ+T5Y9fvYnE7ds92Y00UB7ZL4kVwrk8bMSIgtIFRmZGne6OqRCR5VazImaGlE0qgDgrlp4aWrcfdN5mXBWSaROksTVe7X/looinCrDAjefFnunmoUyj7DHdXfd+6NK5jsKEgDrst4enKl+SMxFSr3ILeGZ/mUjuQNIk2/+4w0ngitCmhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5z4ylwMDdlcJrzT1bv5KfyCz9VCmy9rC1GQv+9QR6Q=;
 b=PiI3bWAxAK2+5knCNwUOox68cs9xM++zRUGDz4eDlKuZJkAZS4pQOOSBdnPcoWC9Bj+wV1l2DhSTSAH7aRCRPuZ3T+eLseunkSNiumRvMtbqJsV8G33Fu2k6Y4aC+KAKm+EYli0dP4WaxxEHGG1w+KHOM75UaJ0bhlE3W1kBMzE=
Received: from CH3P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::29)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 06:03:44 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::2e) by CH3P220CA0023.outlook.office365.com
 (2603:10b6:610:1e8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 06:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 21 Aug 2026 06:03:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:42 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:40 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH v2 2/4] drm/amdgpu/userq: implement support for query status
Date: Fri, 21 Aug 2026 14:03:26 +0800
Message-ID: <20260821060328.461383-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821060328.461383-1-Prike.Liang@amd.com>
References: <20260821060328.461383-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 8813c6cb-573f-4670-5d46-08deff49f54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: D9qms3Dhnw5TB6lUynx9hdubp64pY8HdX4Au2dGE1J7u2Af7qAx15n3Q4vjIn/Q2YgWbx98gwHxRDpSEtyCWqfAfeOqWNn+mndo+tRh41PVCXT5LXRwPSPQMuWjmEqJkrgQERnImr4f/p8iZ5RnJ6EUP5+MrmxJso0GnoH7nKKjKoVxbmncPofEi65nJSFxPs/iU3Z7RuLABfm8Ko2w1ruUpgPU4b0dlfqC7jH+FAhg1kRwDt0vaT6ISidGSLfbaPdoc/ydtSzsW30wWjWSorzB2FfNfbxQ+kc1gzyyX0olxxWJqo1NAcKGNnrPGc847TIgmX/BPmXOqfUt03uHT52vSJl6a81NSFMUf8BPDZT4CnLClNE9VZ91fLiApXKjm6CpgneTMFDiMRSeUGQGTDncoySpgxBme92HBx9aH9tS8rKAmMop43jdmsswJ2mWR5RpF4NB2aLnX5ifcxPF+qjuoK0pSFOoG6fyGJVXG1FJcNzASfBocEU/NPoTXIbJGHplGlWAPacSPM4e6/Kvi3oY7jgInMnrGbVQBhS+Zl15HBGygy5kdGonUf5/u0dLDwwT27QgrJVuF5j/lXtfp611+T/OPu/fn0JK4o2JlWybla6qDSkWDTIZjHHv1A7OWxuk0YF83y39o4YIzoH9KGMiK68WAUt8y2sqOATN2ejmFk039zzXeGVj0Rl/J43wq99z9Z0sxVun84nIz174gfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 838bOrWPf4yWCeAKl9Wqv2HrU6vOUrdGhs6oxmoSznvhD4Qd1DBEw25h/EThXjpTHlC5MgwmjLacAefpojioYXj1CFSgUHeIOLWgilz2tOkGgKVTTBHFZj4VuW75iYb0PIuBEaX7SaTTQ+R1TLildrw/tf4a2KEyEGjM6zxK9SuviZ7hBEjk3Tb07ZQmt9prDWdJvxba1ZC+9xTEMGhaEoZln/UXVZPWKLXEfQu8JpbIMXxOy0HnGCke+LClZWz8GbnLwd5YLnwCS7eKxDsMm8HSYJef2RLoxoujvPFxO66NnA/peR71JwCzndkvVE85QAvxcMu1k19XCdJrOp1IX2yY7uAkRTei9mSnRQUFyxuLwc24FLdRJnP4BKn854YbxU/ca4kZebxlKJCV1iNhxynX0GvBuPPPIwymsoF18XRN3CEBF/C5efYxbymJxyk+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:03:44.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8813c6cb-573f-4670-5d46-08deff49f54d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bcfbd7213dd6..911b4abfd126 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -799,6 +799,33 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -914,6 +941,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_dbg_driver(dev, "Failed to query usermode queue status\n");
+		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.34.1

