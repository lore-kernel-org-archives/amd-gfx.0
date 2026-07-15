Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366C0C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B2E10F051;
	Wed, 15 Jul 2026 13:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIX/L9VY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13E210F051
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwwGsyjmurRwrVaR6v3Lf2u+mKK7/HU6wSZ8pQJK6Him/Lkx7ezdmyHwFtABOfLnlbY813sbUztKE7HmIYEZNg319ltkeWZ/k6r/ZzySr2O8EWdmBmWjO+0rNnJZgpUDEOkSd92qBaMb0ekJHu/Oy3dHv9wB3ired7tuNL2eBFmkJ8UwKfNY/SYLvMR4xIinA0tkViR9OZ9kpuweRjJV2vwmRIUAqViF7ewPoAs8WDgK/WOrZqV9/ansbndzZsREiC9YqDAiB8vTvNPdrrnaUSd0URrT6cyisGRxIUCrhKa+LQwMpH+BxOQOD/9/606OASr2YapiLCmO2Z6Q5Jnp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5mxMGIU06LHMXgEtZYQ7It9MSzLfJLLfNP/ATzCuZM=;
 b=BVUASw5/pQW6P57yZS78EyhWaRiLmSLRt0+NdNx+xIclhyroD+BGnp2mca3Gb/o0rRLS9eJqdNWyT4JWajwLMLALVMdv/WsXDI0I3UuYIqAVAXubpOcpiKUxgO3tuYsc6Quy3YtUNdw/cCr+Suv4Pf8jATo2ojfBoyyJCBtXJpMeZ2afF+bBVl329kvPjMNiX1PCTpKBL6XUuqA8C3lF8/5dN1p+6q2NQZDn5Mn4sTmVPqcZuH0s+A1IeLspDp5nwydMutoXOuyrBIuVNkip2CCmNzoMKx+HpJSykwr4l1HAZtTlrpiqjxF5Mzp3fxo93iDXQ06J8vLNbQQpX1YMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5mxMGIU06LHMXgEtZYQ7It9MSzLfJLLfNP/ATzCuZM=;
 b=IIX/L9VYMBQ8zXsLynRJqWbcqoAhw5OOOCVC2S6Ua+uB6X+tAjWzFSi8q31XoKYBP22cjkUSP7SIyIGj0qABZB+t3klxbhWcIsR3lnGZh17Cx0UQHugt0YAXuacxdIQv2zzYZ0wS6mDZZSMEy68vacr1aD3zr28rE0cdXV9hzXI=
Received: from BN9PR03CA0148.namprd03.prod.outlook.com (2603:10b6:408:fe::33)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:17:26 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::21) by BN9PR03CA0148.outlook.office365.com
 (2603:10b6:408:fe::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Wed, 15 Jul 2026 13:17:26 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 15 Jul 2026 08:17:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v10 3/5] drm/amdgpu: Remove queue-scoped WAIT_EVENT records on
 queue teardown
Date: Wed, 15 Jul 2026 18:47:02 +0530
Message-ID: <20260715131704.3452312-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
References: <20260715131704.3452312-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: ea874ce6-c74c-496b-25b6-08dee2736a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: /RG9WfFe4uH3urM6GzuutmRcQxbyYHdOikXAk2HuNRtvcLBM3t54sw8qLgMiG8dJwJE3ONmH0eCQUnKdleVcyFX7QhXWldn5FGt2bBStBff/2dy8wAQ22Kki+hmrsNoIT401ub45Jepr4a6rLkKHgW3ch1ERV7ThBMiTnHH9aiewbCN7SVQQF8skDX7ekONJzmWUpIQo489HBcFne8JTPjy0kFCMuA8WuQc5jqcEs164D3gnzUMz2J1Sa7vrd6coHkQhPvAc0fdXYUB5L5/uTB9NFBDGZz2xTOYTgDdKojoy5oy3iqqYYlhCtLWFz9DBlw8sMbG2ieGNeHw1mEDkWJPvbqQpVMn2nyvRsmxJZmK2mon4VlqK7TZKsZLwSiwGBmodKjN4VgbANUtHMroaLpcFp0/QWo29UxFYkOw2NssWw9L/39aKHXX+FgpQAVJ+ektW8vug/x++R59qdDaag4ywCt4PTKxxDmmiE1Hl+HGqnYEzZg3AZF6tufjctavMVihCIiPK3Ow+Lyx9OBDp+ZKGbJFbyMwXdepB6a0vrtMAQqZZalHo3TOUoS3LQoMTB0kPKeZ7X1XpR4c8mQAWyLmD9HQLFBrP/gNYe141DqUC8X2or9G1/qnH4iAB6OR6/TRqyKANy+3EroqTOooJFMJ1zvu4qr9P8kATov6w2QrGlccp8+XbPda9llQcgpBOhTZVQoKmlAJTQEVwR4Zd6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MrgjfugRPiVH2hmLV2d3eWf9mAche0uAlRrpbntk2St5g4egAquJNfCol4wCyW/Dni2TgKBYAO5ZyrTpo1u3As3XL8i8Oj1U+RtIcJkOZhCCn6LhFbjupxo9Temvky5p6YORjZ3Go4ucoqZ0qXqY8GsVoTD/Pp6gBZ6RvEJKt2h8SWG2L5Bx2upnwy4TCvTgU/plab3tn7QFC28x2Zh0D0bYYaSl4Cyk6KrHMYw1DsB0eX5VXiXbLkfYy4QzEFLOtUwK+cI+wLak9HhcMd/H0WnsoVWwdu/AaMc9VR5e+Tcupy7mTWgmnyZUR8jnAScFDuCzoiryYsqIjSRtIIPaRP+xIdQw0hc3gmkY9h9AlGRrFd5/YRGWIBPx0c6iDQMCt5oYVavul6d997giUIwRxzrp/6QPO+3rf20y2uTWKYVM9QyFeaq/FcpPw689w5T0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:17:26.8321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea874ce6-c74c-496b-25b6-08dee2736a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

Pending WAIT_EVENT records for queue-scoped events store queue pointers
and own queue references while queued.

Remove all WAIT_EVENT records associated with a user queue before USERQ
drops its queue reference during queue teardown. This mirrors the
EVENTFD queue cleanup path and prevents pending records from keeping
stale queue state after the queue is removed from USERQ ownership.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 65b20d7a4b18..aa17e55d52e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -56,6 +56,24 @@ amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
 	return &fpriv->eventfd_mgr;
 }
 
+/*
+ * Get the per-file wait-event manager associated with this userq manager.
+ */
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr)
+{
+	struct amdgpu_fpriv *fpriv;
+
+	if (WARN_ON(!userq_mgr || !userq_mgr->file))
+		return NULL;
+
+	fpriv = userq_mgr->file->driver_priv;
+	if (WARN_ON(!fpriv))
+		return NULL;
+
+	return &fpriv->wait_event_mgr;
+}
+
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
 	int i;
@@ -1035,6 +1053,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 			return -ENOENT;
 
 		amdgpu_eventfd_remove_queue(&fpriv->eventfd_mgr, queue);
+		amdgpu_wait_event_remove_queue(&fpriv->wait_event_mgr, queue);
 
 		amdgpu_userq_put(queue);
 		break;
@@ -1421,6 +1440,8 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 		amdgpu_eventfd_remove_queue(amdgpu_userq_eventfd_mgr(userq_mgr),
 					    queue);
+		amdgpu_wait_event_remove_queue(amdgpu_userq_wait_event_mgr(userq_mgr),
+					       queue);
 
 		amdgpu_userq_put(queue);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 526e007e300e..5d6d68d26c90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -204,4 +204,6 @@ int amdgpu_userq_input_cwsr_params_validate(
 	struct amdgpu_cwsr_params *cwsr_params);
 struct amdgpu_eventfd_mgr *
 amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
+struct amdgpu_wait_event_mgr *
+amdgpu_userq_wait_event_mgr(struct amdgpu_userq_mgr *userq_mgr);
 #endif
-- 
2.34.1

