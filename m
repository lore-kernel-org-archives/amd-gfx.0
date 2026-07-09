Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A3BC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 06:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952E810F3CA;
	Thu,  9 Jul 2026 06:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gPSDgK9q";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010014.outbound.protection.outlook.com
 [40.93.198.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B4410F3CA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 06:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKnhz108nYTvPRQl/oGAcEKgFtdgAjl+rr9xZC6LNtXK4YNwNicB1egsKzua/hQACZT7bMANY+cv9ktobl7UxQeJLLSPbjXG8wRz1uXnmAB/pW2yMcM3bebF13Fnbd/OAJgRHUQNtyoU1B8/XWc/PgxnO5Vc9FBtxi4I503KOf0jWRrYLuD4ay+zTUqMRR979buekmJ89OCSb8965gn53p3Te6BN69J+zAUNwKY/pKa/F7wmQH6tPm0NcUl9Ab2UINQ/FmTt8suA58JW5Imb+IP1QE7o07h4E6U0i3rfWc+fgyuTKEYeuBizQPvHj5/WLlDtoe7sZZGU0scaiEfibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzKt1B22GQmX6oFwmxvRsZNqMGC5/qzpK0RYpXU14MQ=;
 b=sgpdlL21U8HXzhR5GwbAh++lyIyY8mI0P0Nxi4O+NTYjVYC3TFXhZZ8BzGeqrthJStlHNYZlqQBrY/DaK+ZJOoeGINCU3aQtgZ6AMT+VI76rG/16fJ+hYyqDPuMVvQClreypPhZ4DBWdqpb2K/Tqq0lZpzqmpOG/oz7oZOFs7LAyulxrSBe8ciQhgC0ZZWLHIR4VG5uf6DjvT08Gle/vDPDfAv6wiQ7S45knGum+Us6hdaXwk3L36EGl8tlI7wo16Lasp3FvKtDpCovUTVRWN4FQzSn5oGBLgEMOaYv5heyQiTjdzDX+rUAzeck2jc75KS6Z6gjs+hYyo1rs0g6Pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzKt1B22GQmX6oFwmxvRsZNqMGC5/qzpK0RYpXU14MQ=;
 b=gPSDgK9qcVTfTHf/41RddCCZfoUuBJD0AA4ULxG5Y0QROYWp2r/p4mxuXW5Ep8QgGkEGU7reXCTCed4cB2uqASkOXh+xB4Ox4p36F0pG5a0F+QvPFnelATvHlE7gr6We/iz1ZSo4B/q9OgYMYm0zokgC848D1Yl6O/9YtE7q8+I=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:59:08 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::11) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 06:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:59:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:59:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Michael.Chen@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: add RS64 local memory context array init/fini
Date: Thu, 9 Jul 2026 14:58:51 +0800
Message-ID: <20260709065856.472296-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dae7650-a89f-487e-8b07-08dedd8791dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9LhOXuyT3oGMJZ8Z+KSbhnd7o9yQebEUaJqHYiRGtVg1izSvgwpZ9WgSozVx32S/RRwX2moNrO4tSAAzgzTSjKJM5qPzumfIhhfeUfk6q49NGKEgEaevNXu/4OcsDtJIUmw2PiWh1Ot5glYa7Jf9jnuTupcj0+6sXU67SMx7ebzGgaBzGJ7DOJ9nL4uXUVlznk7XXKi7jLyAd1mcsu3LC63AFLFrbLNQKIurydmbZ/4ICNpoz1/EPcDoy/D4b+Thw6o/x4314jLls2VFU7HnyOQPWajKmAZeoY9BkutadFDbmEJPO6IBIQG+ljnsmXjeXx9nF1avKiiXg/y4Vp4OpNua3D8xzeK9qpTCzsG4LoTvcrKRMYu8WMvZbRtKXgnqCdtWc8PCVW9EiULgkGr4VMV3eU6IacNHfxzZma1pgc8osjGnUIzfAVIOPzpx3Ey3bkKSufjBqEFIkLLnjn3xUuuV135CCQQUJkGrLCBJkXsY7ggGRjwalrFyQspmWw0et1Too7ziwHC8+lXd+NH8W4vxKL18Kg9TZPv9Me6+NGxLi+62tGDk5MXnmlSLFm50Uwox/aS05gNjpFkgPA9jkaVXFCipa2wv3G8ldbpd71OC1Hz1XmkVmcDC9zMGlDbUkTXT6zYQve6XTm9kJKaX+X8z5dicW0w2+qiqE9vMd7ArIotBERTFhNOeD0DyjeyIzPgkTDvZ5ErFNR5cPCCUhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sekoWgdT8WtjOtGZM8VUZEobuYmi63Qig4vJ0gFNKDb3TpicHil/FL2vbSo2vRuPhc9V2CJqHDtO7l2HqLODPcg1wnHu6DHtgRd689NuE5W2RgsJmvZNXVGk+oDcGAGwgqxH5KZtOc0An2qL8/iq2LW6d3NaJs9ebDjYxvfc+3sfwADF8fNHdhT7T3mPXR/4Vw4FQ+Zjg5ErwaweAle2BLp17SGxJKf32c7cW4PcNZMynRD8jZrfUZPu2aXJL3YEfsU/M39EIYPBy2eNUw/PRRIzthtQPA6GRRabLGycLHUZ3OzmKUvEm/H2rwHv8Gi4A3dP+nEJwfmY3RvQQsZri+9EfNKdeY0QDszlR/AYyIQzRyUhAEwT0hFYs2FQZZhHNRJSchCTyctIHkUIWTa4FjgScbo2yweQCj7VedsqzqRcve8Rq8OdEsTQSxm3kS7n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:59:06.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dae7650-a89f-487e-8b07-08dedd8791dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

Add amdgpu_mes_rs64mem_init() and amdgpu_mes_rs64mem_fini() to
manage the RS64 local memory context arrays used by the MES
scheduler.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 44 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  7 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c66e69b62361..8ba1c941c03d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -921,6 +921,50 @@ int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev)
 	return r;
 }
 
+/**
+ * amdgpu_mes_rs64mem_init - initialize RS64 local memory context arrays
+ *
+ * @mes: MES instance
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = container_of(mes, struct amdgpu_device, mes);
+	int r;
+
+	if (!mes->use_rs64mem)
+		return 0;
+
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &mes->ctx_array_size_bo,
+				    &mes->ctx_array_size_gpu_addr,
+				    (void **)&mes->ctx_array_size_cpu_ptr);
+	if (r) {
+		dev_err(adev->dev,
+			"Failed to allocate ctx array size BO, r=%d\n", r);
+		return r;
+	}
+
+	memset(mes->ctx_array_size_cpu_ptr, 0, PAGE_SIZE);
+
+	return 0;
+}
+
+/**
+ * amdgpu_mes_rs64mem_fini - tear down RS64 local memory management
+ */
+void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes)
+{
+	if (mes->ctx_array_size_bo) {
+		amdgpu_bo_free_kernel(&mes->ctx_array_size_bo,
+				      &mes->ctx_array_size_gpu_addr,
+				      (void **)&mes->ctx_array_size_cpu_ptr);
+	}
+	mes->use_rs64mem = false;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 389e3324caea..520bcd8ee202 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -171,6 +171,11 @@ struct amdgpu_mes {
 
 	bool			compute_pipe_reset_enabled;
 	bool			gfx_pipe_reset_enabled;
+
+	bool				use_rs64mem;
+	struct amdgpu_bo		*ctx_array_size_bo;
+	uint64_t			ctx_array_size_gpu_addr;
+	uint32_t			*ctx_array_size_cpu_ptr;
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
@@ -617,4 +622,6 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);
 
 int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
 
+int amdgpu_mes_rs64mem_init(struct amdgpu_mes *mes);
+void amdgpu_mes_rs64mem_fini(struct amdgpu_mes *mes);
 #endif /* __AMDGPU_MES_H__ */
-- 
2.34.1

