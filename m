Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yujoPIvM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEEA10F8C6;
	Tue, 17 Nov 2026 19:24:48 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A2B10F8C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAAGHCh9ak8cZd5reHG50Xxw4Dn7To65IW0WiVYX6xuyly+uFHLvN8eoaQ2xcBZ1+mbQpOPzfqrE98Lk7uGXpNfnwUlc8llxmTnz2edSORMNk4n2SOt93cCw5j8vM59TmylSJs2K/fvT2wGBpQqY/QIUV4o/UcrqJovse96791m25wQgE9vkejL5BxdTKe8VyS/625B0svbqbSaOR/SIhIxkuH639Aw8k4fIj/KjoVvQEOrvjNYvl5WW4spTMfCxdTjuqCkC+NiNwo5svJO1gyCJTh4PbJcXUBkANohbu/5keMnzCqen1j3KY9ZL13VSISeRDG3+aZ51+kE9SVkrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9CNKVHFRAjr1QZ1TBGz9VHRHgwHmzPuUKHVH/dHjm0=;
 b=eb4pqF4zJG/1CbPyss/Op8/10ihlkPthX0s6hR41eXNutp8zzIg89pv0qKPLuzDkviarqSdeo0vvFHccwoHEXN9WyCAq8lizwnyZhReefXMx7Bg+/XJ5XSaOQXr8sUNYAC+gH8CkIxG0VtDGZY3mS2oEE5fREa8I2lQbq7D2iQI5UEC238TGQo1zFLFvlGTM1scd23sWGrqYZSjDDY3jp6bBAh3D44SV0T1AwDN9FCPFsLFVVvuQgUgsaCNZOHMaLpgjRtAhTDC3vwPGTNL+s+uVt0fKF/kO7HpS/1PGq4VjTNxm4/Ip9NmodoqxB2LEir15xjgq244YTEcILp1ZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9CNKVHFRAjr1QZ1TBGz9VHRHgwHmzPuUKHVH/dHjm0=;
 b=yujoPIvML+ywaRube3nC/LHErHH05LKL3PubeIonXR2IfWkEjStNVX08+RsoDXynAT4Y9Cke+QlgDl3AdVaC5HRmlSew35sOLKk5qlvZklrar3J7RU3jx2KDHjp1vISNJHCaKrq8APNDVYqRlRxcpJJBBueCTzcOs9wVgV10MDw=
Received: from MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::15)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 19:24:39 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::1b) by MN0P220CA0004.outlook.office365.com
 (2603:10b6:208:52e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:24:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:24:39 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:24:30 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 13:24:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yogesh Mohan Marimuthu
 <yogesh.mohanmarimuthu@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/userq: enable support for creating gangs
Date: Tue, 17 Nov 2026 14:24:15 -0500
Message-ID: <20261117192415.810117-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192415.810117-1-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: 02bef86d-1446-4864-6075-08df44e06c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261022075727099003|261028144727099003|10067099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: IK5h7uSkGZ23AgPyLrOmP1eJKOITQehXgejzP5CttwYeaOpbOogi0KpCsMLqcCcumzLe25tjmdwMBaNLzwElOJuEfwfaO9w0oaK0iWyDe4I9lmpCCOit2CIbLTkmVP73lgDJy/c6hrPzAFffr+nlh1YyGu+MJ2GYDtof3GzNdmvR4CDYAgYRR5hsuBAsmDds+5oc7MNLbe0PGvDgIzEL4nsjcTsATUplohYvaohNdUkV95XMAuGf8EhiDS4LpF/AascFoEGidN4Q8+Y/sttNhV4EoytOBDqcMt7mKfp1VoXCPlvRe+n4jaIpbDzrp40NvzfXwSQzO34o/GkdTLCkd4MzmL+GCWDrylSOs6PVO/Lbr60QZSEVymq7s3Mzod163T1QF5VZN0zLatWzavoawdy69EICWW6wOCSoGkd8eQUdQc8rEMpP3v9IcqSq3taQIF+4SUYtKeu0yzRBhSgFVPCw00yer4KaTkqoLvcQZu4AGLA4pKvhq2Bjpl6GBgP836o7z8UIb2GLdv3b3L7owG4KHNxDNxUWqODgj51jxF3dabBbZ5AtvhxgRsD0qx+OxrnJPhcNA5ZC0kCJ1NDzayc2mp+5fykuD1Gfg2nEJDPpGendH9v2dxCMo/FpxPdXqHYnUAb4blIST7C9Dy1scNmWTVVRDAxqff9+iIOBfEDbLjioSdYi5TJvdv4O7rKqmrXo1MeI64CEfEon3bhbkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(10067099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vW5yD9sxOUu3zlPx7Sy8s9uNKn5cWuXmfnpLwi2rVoJPW5wsQWSpRCJj7KvaE2aACwQxzFasWXk76zfNAtp64g+Acy5/hhHOIUSuAJcNzsHwYi7eayERzceFQ74hxrtqiR3peA8raNLGGMUarBgf1ManVFFWW4RomjxPCTzZxjX6mOV88ooKDhBAwxMSbjLXU13nsulZe60UA1XTU4CsPJP7207Cz05IwIeSz9XqA0fp8VTWLvnGV0oZSrua/ud3944tBNJ4F0tv9djE4JJqV5KnPFJ8AKbATTcBrt5jViao/5KCWoAFFGiOuFFXfSek8sR1g0sX3b+U7tB6YbkGkKnWbdBg9tCaTEWRu+pp8sobYus9JugpfllJVg491oEil2Ed+1VLb9fGYeT0IPxfkmDoE4GCJsoMvGj3i3VN0szWkMMFscoDcjTvtJuGPyNA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:24:39.0836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bef86d-1446-4864-6075-08df44e06c5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gangs are sets of userqs that schedule together.  You
specify the primary and secondary queues and the scheduler
will make sure they always run at the same time.

v2: handle setting up the gang again after unmaps
v3: split the UAPI part from the internal tracking

Cc: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 69 ++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e41f0e10c8a36..61416518fd702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -896,6 +896,67 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_create_gang(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_usermode_queue *primary_queue, *secondary_queue;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int primary_queue_id = args->in_cg.primary_queue_id;
+	int secondary_queue_id = args->in_cg.secondary_queue_id;
+	int r;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+	primary_queue = amdgpu_userq_get(uq_mgr, primary_queue_id);
+	if (!primary_queue) {
+		dev_err(adev->dev, "Invalid gang primary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((primary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_COMPUTE) &&
+	    (primary_queue->queue_type != AMDGPU_HW_IP_DMA)) {
+		dev_err(adev->dev, "Invalid gang primary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if (primary_queue->in_gang) {
+		dev_err(adev->dev, "Primary queue already in a gang\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	secondary_queue = amdgpu_userq_get(uq_mgr, secondary_queue_id);
+	if (!secondary_queue) {
+		dev_err(adev->dev, "Invalid gang secondary queue id\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if ((secondary_queue->queue_type != AMDGPU_HW_IP_GFX) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_COMPUTE) &&
+	    (secondary_queue->queue_type != AMDGPU_HW_IP_DMA)) {
+		dev_err(adev->dev, "Invalid gang secondary queue type\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	if (secondary_queue->in_gang) {
+		dev_err(adev->dev, "Secondary queue already in a gang\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	primary_queue->gang_primary = true;
+	primary_queue->in_gang = true;
+	primary_queue->gang_secondary = secondary_queue;
+	secondary_queue->in_gang = true;
+	userq_funcs = adev->userq_funcs[primary_queue->queue_type];
+	r = userq_funcs->set_gang(primary_queue, secondary_queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return r;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -1016,7 +1077,13 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		amdgpu_userq_put(queue);
 		break;
 	}
-
+	case AMDGPU_USERQ_OP_CREATE_GANG:
+		if (args->in_cg.pad)
+			return -EINVAL;
+		r = amdgpu_userq_create_gang(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to create usermode queue gang\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
-- 
2.56.1

