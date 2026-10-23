Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D5606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ehMWAPgl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDB210E5F6;
	Fri, 23 Oct 2026 09:08:58 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E2A10E5F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 09:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb4r0KueKb+cyMW4eH/ipVDufX/+JvnSHMbCHq+5K13K3sn7cg3BB7HL/bl0GWTsfpQKcTLFuut6ZrX4EAwJSoE2VvaR8Bhez2hRDA1RfvhrdL6OJoZAT9ZY48oTaP+Jh/5T0r4T8Yb6ZkT+NlEQ1DLdxvr6ArV2HU5TWCt3ux6pve1agJqxzIMOQwSbBzHRyMgRxeeh4JVBzUW4bptH/5leZ1QDzNeqAw5QquEqwJo0KC/STfytg7n2DE9W1uWibrda/VouMDJqFHWnDkGpyTIW9WvA7DBVZK8XkXkpALNUzqzDA9cIO3QrIdGMvignjCIAqGWX+739WemCQTJakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul6ITLudjdJVGw2BcR09yRdxtkpyjQK0uCnl5d8sORM=;
 b=Xd/EX+LUuaEOTnH22C+e6vgqyle6dt3esq5vDEyLwnUL9O5Nn3KuHa7hc+qGfz3QrVnLLTETxuKAiY2n/NbDG0ripMtOTQVhNJRbCSVYZrLXnGlCTNsp6ZOzRq7IACGUFFPCaVWGN2r1F8wbobA56tNCIDwsTXMjpS94G7CO8fNfchwAxMhBiOKIfKdv23vlGYtwd8b5JUYbKDezBWEy9LeCqOueBI3adAnrAYF1DNXm+zU+5zA5Kour8SNzKXd4lhA7zwuUd+9fV6XWOOnkekz7ZBAk7wrSMZE/l6nibyxOZhIXeWhaCO7gKklDDgYSaPLq5MhXHAwkQb3cq4uIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul6ITLudjdJVGw2BcR09yRdxtkpyjQK0uCnl5d8sORM=;
 b=ehMWAPglK/bqUD9pHRvXKslrf6FGO3NB/RDaJzQSUxTaaCtwBLfCaS+tQSC7PK12NJmLyuSShHLCyzm8du+wleF5PI0cbEYj5JUouz2RnVwf48trJcRbAH9KsSxFrRYljip2G9Rb8SsbOhS5gAH4kuj3oiUptNpRSGFxrJni4B4=
Received: from BN9PR03CA0646.namprd03.prod.outlook.com (2603:10b6:408:13b::21)
 by IA4PR12MB132465.namprd12.prod.outlook.com (2603:10b6:207:129::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 09:08:48 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::a5) by BN9PR03CA0646.outlook.office365.com
 (2603:10b6:408:13b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Fri,
 23 Oct 2026 09:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 09:08:48 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 04:08:46 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>,
 <Benjamin.Welton@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH v2 05/13] drm/amdgpu: set device-wide PMC enablement indicator
Date: Fri, 23 Oct 2026 17:08:37 +0800
Message-ID: <20261023090845.670581-6-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023090845.670581-1-lingshan.zhu@amd.com>
References: <20261023090845.670581-1-lingshan.zhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|IA4PR12MB132465:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab7d8bf-ed68-4f35-2f04-08df30e53fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261009223027099003|261021121427099003|261021123027099003|10067099003|56012099006|261022105027099003|261022075727099003|22082099003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: PRtIHvUUGJKZXOC+m20JFncfVViYS9bt1TEz/Vo2enyneUgAtv32Wjv7RxOAzvvG3vCuUSu+8FdUhkpFMkXoS0pr2f5c6XF2OpgHQ1XlBCH04QpuY8DnLr7+vlFDBi55DcQH4gQA8Oezdhh3Amy21sqSUmz+s0JsHjkVDy2HNpmXrk6ZdKRkiEpE1ve+MEO+nRNWQb1ZMLj1UjYtbXp33Lq6XPGfnYEsCsjLPnN9nvK70SaVtKt302K1cV4jzGZqNM8Cn+hiEJw+a5QrlXkcyfLOX7u++stBdxT2yuDR2HBa51o4uPy/voPfLh2sFN6S4o0IigJchfzvo2JAl9aKunX7wjNhi7gico72rjGybHb/WE8EtCEgJK4ZW4M/Sw7wfOKMA/uhso123iT9dEof6JWDL7gtCefDWV/ZCjfIBsD8qcYUmuW+wJEXhAwDHk6VS7LyOYA9MtMo1msrtvaBCEt/e615ItCURxX4qTXhme2JGSpPzLTIyrbZdc3KcmZw/F8cULWX/Zhl5eSnts9URm7Yj3IaykhLjPDm1f7zA5uF9kIgjrRuWvJ4N7PUqlfpiK19JgqBAmIGcBKGslgK4SO3plrD8Dc6iUldDbLz+fVhJL8hANkNOk8g54/0WaSWFamUJFAqKaIDDj4g6HYjjcXqISJTJgo2u10E9TJc9paul7h8WKZsmbD12nSMNPy0K36VftZXD2FtYbCvFtNobA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(56012099006)(261022105027099003)(261022075727099003)(22082099003)(18002099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4av0rLCh6YzFkKw4/bkYU7xm1bkL6HswACdwPzApJTs2HY8lw6xGOmFQFqRSO1UXueyjnyNfTaOfKCoOkM0S3Y4HlG7JIwoF4YU+Z+BOXe8U3yHiySVufM+jG6m4l1K25KGzySo7cBYC+2S1311Vk85OUJWXzS6/FF/sin4s/ZZkxD0DqfSPyily6WRhTDo+eJZy09ip7ix+aFE4lih+okdXpL4TfQZboSMgRsIq8yCv7snW5vZ8T8pv8qOv2J2gJsJvr94KpSRVCIik4iJkMVDvXp68DBRLqG23zQG+mapQ3aTzVC/oOj5jR0NXyuWRme3HhfI+no3vkxU8F62JphmcXBtPqNAbWxXIA4tCeRB0gqcTrBrVslAlQ8PBL53V/KXB6Ngf+2QVzupX6PvCNwRaqYUfmFQATDo3iMuGt4xyoqRPJI0r1p81Ig8SFe8g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:08:48.3963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab7d8bf-ed68-4f35-2f04-08df30e53fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB132465
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit introduces a new function amdgpu_profiler_set_perfcount
which sets the device-wide PMC enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 32 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  2 ++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e441eb171c1b..f10d6ac49bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_set_perfcount(drm_to_adev(dev), file_priv, false);
 		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index a15149720d52..276dc75f0e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -79,6 +79,36 @@ static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
 	mutex_unlock(&adev->pmc_profiler.lock);
 }
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev,
+				  struct drm_file *filp, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner != filp) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (amdgpu_in_reset(adev)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (adev->userq_halt_for_enforce_isolation) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	adev->pmc_profiler.enable = enable;
+
+out:
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -127,7 +157,7 @@ static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 	if (ret)
 		return ret;
 
-	return -EOPNOTSUPP;
+	return amdgpu_profiler_set_perfcount(adev, filp, enable);
 }
 
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index 048ce84f0ef2..532aa7881191 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -30,6 +30,8 @@
 
 struct amdgpu_device;
 
+int amdgpu_profiler_set_perfcount(struct amdgpu_device *adev, struct drm_file *filp,
+				  bool enable);
 int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
-- 
2.53.0

