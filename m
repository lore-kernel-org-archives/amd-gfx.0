Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE4C369D8
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F5810E988;
	Fri, 25 Apr 2025 18:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGtzkMFG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D419B10E979
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwWYNaaO7qnkqjhL6t30WfIVffvlErl6EymJj/IMEjTazOblJIf09ZRYk0WylQv9r3Ody57oqQG8hHUdwNiAT/2vjTl42GuyQ43O4Ie0RQDxMTHjgfozEJ0yhG2QtdaWVLrU413EW6j/E38vT22trnrQOHRInR6Nixt5VEj3dN73Ww5abSPxj4RohmCf1Ru2Qv/mGOPAmxMeutQjy+u0mE1TLJWZVUDc/bABOFa6/KDHgWQ5fctcxd6MrrgIL3Cxtl9AYfrRAQKABr9nMdFfN9G7gpPjb5oJ4nVeqyejrLD0SfjSXsCTEpsLIjOKRfMKWQPeh5YJhj6chw/2KqXUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haLJbq2ZIGb9Iawf8vuyHcl9IB4FffsLdfI/ZApi2W8=;
 b=HZ5TZte2nQ55b8sk3G2z38tEYlrWobOMNnCpg6Ad7Fwk57fFZ+pXpZWMFIsN5cbE4oEGshpDVfxWegi3omkRuuzsFs0qSDrLl9msiPUeX5NjDUjjVX675jcbJU/xii5vCLrBeitwsNQ77LQFK8ajdF+sL+x1XpWUuSjcibj7JMEo5uC4BDJPSHGuWheaLdCUP4JN84h3IedHMN/QuJFy5oOYH21vSXrhXEVSPJbjqtINKCv/eCp4rHqfa3rSBMSioupGvFTGBij19vref21HftBdSSe4903DmK9NdbSusqb/qFaDTM9kVwjvDfhU54ijnxcgiZxf0NLE5WgSWsFMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haLJbq2ZIGb9Iawf8vuyHcl9IB4FffsLdfI/ZApi2W8=;
 b=bGtzkMFGvTjyLRUdQXxhANGJml8S+M9hUTLIQebPM2oX/jkq4n5M14h3LPPc01uOmdfLL2MbZr+b+f2qXhhjcWPpRrLdm0Ovs/yK/8h8Zm071iXNmWE4dzSvg/lx6rsbHRO+laIUrPzNN2ti2B3+nADanljLurbf/pO6HpFPwUU=
Received: from DS7PR03CA0305.namprd03.prod.outlook.com (2603:10b6:8:2b::25) by
 MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 18:39:14 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::fd) by DS7PR03CA0305.outlook.office365.com
 (2603:10b6:8:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 18:39:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:39:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:39:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/userq: implement support for query status
Date: Fri, 25 Apr 2025 14:38:55 -0400
Message-ID: <20250425183855.165199-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425183855.165199-1-alexander.deucher@amd.com>
References: <20250425183855.165199-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 1791e50d-d00f-419e-08a3-08dd84287a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d2UXTn/6JbFrLJ60zOCddm0UKm6OjF70jOxAY4X7UHOHW7Pj4db7q1HJX5gM?=
 =?us-ascii?Q?zbo3O6fOXy8Bi/9ip9pGuUbTaRp2A/ta5jkIqTtiEnjaaH14K0PDobH/ZA6g?=
 =?us-ascii?Q?033WS628A9+Ahm9cabjnZMNW48yGt7/AFXJmTBVO4VaPj9uw/j76gUGs+QMM?=
 =?us-ascii?Q?lJ1nUPVcCv1nTY051j2BjrY1yZEc7wC66K4yWSFiJpisleXxDUYqrNZj3mdi?=
 =?us-ascii?Q?DACKgTi5CMnbj7ZBRNZw3vsrh4mcJ1mg+IBRYRYMLUQr4mp0jpzQrkCGcFRQ?=
 =?us-ascii?Q?EaQrJd+Slnw2IVrQO92rcjCED5PPO4A3bJ2OhYNs1s+hgd6JHV53xvFchraA?=
 =?us-ascii?Q?H883YJrti+AauZl7z2jE+EBICiVI3u0RyjxKhHO+ZQWhStl6i33PiggkIyJK?=
 =?us-ascii?Q?ATfp8r1GOjNM4ZJQJadOcNfeLnRd1GMiVRdfCbO5qgCk6oMS/XZPqlxtyp6C?=
 =?us-ascii?Q?Hr8UhQ+C60YcBZgM13lbxJHvwMagQxcr9NS5L3GaOrCsi4mRHThpGHnwxdd4?=
 =?us-ascii?Q?wUXmclpb35+sH2jV3KHZndvD38y1NW0GSMKV5l2pY8HL5u/RypfbRu8mxKYI?=
 =?us-ascii?Q?ADRbW7Mx0X7B01kSats5Xjf6JHuY6rpRJsTOO77CunPQvFXi5mVCRxCi1+Rd?=
 =?us-ascii?Q?Fw/ohERNq2BYD0P+v3qgs45NvF283xVFMgvR41+Dy4GaISbXv7hc8+vuWlsw?=
 =?us-ascii?Q?pl5q3zApYZY2Tf+V2tefLNzan1TINoue0UC5fFz6WMQMMIX4m9q0Wvim6cxm?=
 =?us-ascii?Q?rCq9LYu9OykDp7tLJzP4I6rYeHqbKIyERn9JEnlEO6+wvIjkX12QXsktU6yw?=
 =?us-ascii?Q?Ia29Z9IHlajwrwiSSkl9I+JgGYs+hC9LdZZeqtcpdq6IpOYOjdAfsslb56FQ?=
 =?us-ascii?Q?dozVKfT4hjAfinh2AAPDKoxSRHRVKjl9N1I6T7B5KgLnjw7PWpEVRPt+SFDZ?=
 =?us-ascii?Q?bups9O1RXnFq65g/60zOENea+NiGYcRheGTA0InFf6MS2f9v6xWHwAt64HIw?=
 =?us-ascii?Q?MAK6hPWmNLOAiU2CVABlbBpbcKPguq0nB3/DUcP35o9dy1zRISc6kCOgMlWr?=
 =?us-ascii?Q?znK9wrVRQ4OUPM9sHzhmsOits/jEjrn1mgAstGcZwk0F4sGqOLst8KzRT5ia?=
 =?us-ascii?Q?nlZ0Xx5JUoJsULaZ2fdMpspnd+fV5XofJtjvl6D0kDmIjWj9pMA68E7TG8x1?=
 =?us-ascii?Q?brCn8A4kMwKoargrsdrbqvzSKmkOSXYtCbude7l5JiI7t3TIGKHKHxkg6g/5?=
 =?us-ascii?Q?Jfb3mEs5PRmXbGqpaT478QFlGZZFfBp8WRDIm7y3oYKnqoUjXzuDvQC7iSzv?=
 =?us-ascii?Q?/aTEd5voqWW7oLTl0AgtmK0fOUJwpC15YclsBQC7sXH0rLokMBXXZD3pzPuz?=
 =?us-ascii?Q?Q17B0DqfMt8FsLacJaWmUPE0MuKq1eyfQN/NRmesBlcw9HCa88pacauFUyRF?=
 =?us-ascii?Q?EezXPlc07wsHs9h2yathIhYHloWTZ+ypwEcgMQYR/5Q+DeArnMBaHZZ19J77?=
 =?us-ascii?Q?xdB0LQiSxzeF9W/SLxrFv6r/3M0UizmIXxrc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:39:13.7651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1791e50d-d00f-419e-08a3-08dd84287a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 47 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4be46fa76ceba..e56fae10400db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -460,6 +460,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -532,6 +533,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+		dev_err(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -565,7 +594,23 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			DRM_ERROR("Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		if (args->in.ip_type ||
+		    args->in.doorbell_handle ||
+		    args->in.doorbell_offset ||
+		    args->in.flags ||
+		    args->in.queue_va ||
+		    args->in.queue_size ||
+		    args->in.rptr_va ||
+		    args->in.wptr_va ||
+		    args->in.wptr_va ||
+		    args->in.mqd ||
+		    args->in.mqd_size)
+			return -EINVAL;
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			DRM_ERROR("Failed to query usermode queue status\n");
+		break;
 	default:
 		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6ede08dd821d2..35a08ee59d893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

