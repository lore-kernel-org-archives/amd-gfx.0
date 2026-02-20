Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB206C5AD57
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D52210E376;
	Fri, 20 Feb 2026 19:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uVXNrMSI";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAC010E375
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wN6WbGG84sZMC93PjyF9qJqmJ6NU6khFdvA9jN9zJSGZt/StDXwoFJsibqAR3McIkFLjk7miGg981a9DzMhJNWxY2pQM0EQcst6Gn80b4c4ee2L5AofMIKqnK1UYQbXw94czLbHR+W9IDhKmxo5xuwJDrbIN4eKnlRVv0+yJiHusRixdRiRgkaJlRYkmR5ed6K4QtgkxEOfR19tcVoVMYAEA1F3XqlhSCvl8L6zvsKBVxL58a88llJD+as4N6w28YcO2VzWDz80qHWV9gvBhYHnFW8JdemKVp8fBeW4gfYT1bBkuhghbkxuH46kWl4B0QhWkTKkEowig0BrlDN7Cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsCGMH4HAKvwKne33HGiTHd134IJhGdSCkZ8FuUL5hc=;
 b=rQiDoRR3PJLGI8jC8008MP7+lRFsmTaeXxvBJaX3xDkRV0y0a2ChhUMvb6v+K1rs5Kbab0teur4d8FqyXAmtKIsRiEviUhXzQu7f1mQvYoho2A+Y7+kVeoPN/xYobFdvApPfc/OACrd/XLUVaC843YxSeUZJ1MxGkCN0R/mUD5Kpl1twRYCmDyY+0P52qrTYM4f7S/VnnZx1eHldBwQDYm2W5E/aoFJ6Hd5/QJseoL8iZnM7sp0dpQ54Xg/76gm4rChulB6GvyLBSK8tqvwdfsfzkMkymMQMh2l1jaLPzX0rLqyhqLGBIBh64JqblL6FrqSpZOluqJMfUvdVuMkgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsCGMH4HAKvwKne33HGiTHd134IJhGdSCkZ8FuUL5hc=;
 b=uVXNrMSITST85TiGHwVYY0aDe0ajpPtSY6HBtsSFYXyPDDhwxcJOZAVmt5OXQonV+LlZ+PjFNT52cOWfkqMeFFL99TQTI+ujsgOom/uLtLTM86y/ivw0jJ6853GSjSS/qcCMn1wCvcoOo7cBLCvUjFQe+B66P073d10v9ckJFMo=
Received: from PH1PEPF00013311.namprd07.prod.outlook.com (2603:10b6:518:1::c)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 19:23:03 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF00013311.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Fri,
 20 Feb 2026 19:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:23:03 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:53 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 06/17] drm/amdgpu: add RLC SPM interface to
Date: Fri, 20 Feb 2026 14:22:25 -0500
Message-ID: <20260220192236.3121556-6-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: b61dcbf4-0de6-482e-1a28-08de70b577f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c23xMjPGt/s7V3f2o2vjEddQULTpU7vcC57isQ+pBBil09EhqjF1XWs/0P/T?=
 =?us-ascii?Q?uk+Adx/kOaJXmfKg0x4Is71M88j63bEk4P9a0UQTq9oPkW+v7ka484jwVBWl?=
 =?us-ascii?Q?DQkjMjyxp6EBnfCJrUXzA8m23Y6tx3fd7JZMnvqgmgU6GrCbGTrriMI+SVch?=
 =?us-ascii?Q?qESfS6Dt47ilIy0U954y9vB9nJrbelJ65f69TK8ehvy4mwhPvbN9cQCJFEly?=
 =?us-ascii?Q?324Yx2f8tsf+2A7Wgc8jWWNRWgvlAUKhBtIxNKQoeGgyX3NW0czKz5+z9nWw?=
 =?us-ascii?Q?ZkHAAsCFTizmAx0gV/hWOUJYsqmC5jUYsy6UgAaP6Ix7QN5da/YfgpI/Gogj?=
 =?us-ascii?Q?k6I0gTDk4T7LR/oAqYILVnK+oDgYS3l0wswtcY78b315QTmf1b5kua9/C+uX?=
 =?us-ascii?Q?9lzFcRMTEzLHx5C3LAEYXp0K9MeNeuYU/mQ6hJdYzy+0OWaGXYIMpR/bm0JN?=
 =?us-ascii?Q?mhJewHi847P/AFK3FVRcB1vnVrxGLdnX4ENuQjvssrvlC/0CmQbB8kkiDxPb?=
 =?us-ascii?Q?QWDScORGvRM2/gblksmFi6r6rK3zpEa7vaMX3QQXaePEnAjtMfGzGmu/LEy9?=
 =?us-ascii?Q?5FEeS9D0iCHwd2gRRdgUIDWClDETWS80x1tU4rhf69kd1s9+Qs3Nt4EhvXAR?=
 =?us-ascii?Q?dmFFrYitVH7GqyErTT0D57O/TjfblZGjZR96FI001hHjSqmwHdgMAUs8xcMI?=
 =?us-ascii?Q?hspflB7ymevvNXUOXmfB0P1L8URhL3xhygNJ8LTiREBP3l517bztjcHBBqk0?=
 =?us-ascii?Q?ILflU9Om4odWer7SLVg+cVTbaibqj3c49PQS+obNx3iXIhvbwursrK8MtV/P?=
 =?us-ascii?Q?NHSVybntb+olnFmliUwWvflv1Ql/hlqIGhTP+aF3ncJ/XkksMXMtSJaf/iUT?=
 =?us-ascii?Q?xmqZbZ9kyD144rRx+zRSwFvO0vPNE3xaBbRCBei8xpme39iRoNqDGtTclNNZ?=
 =?us-ascii?Q?sTPtS3SmyMmeKvaGNWO8P1gArZYTM+u09/SdQOaF+fJ4D0lyCBU8/5utYCDN?=
 =?us-ascii?Q?0P+UBNvwX/JlMvxbJqBJBvu7YPW+Pr0Mo/Xv7HXopDw/W0U41OicpAu4WoAM?=
 =?us-ascii?Q?qR/G0qeWBigpQtEvhi2VzLJ6+2eXU6GPsGd6sDz+lJshGpw0W1pljM0pny20?=
 =?us-ascii?Q?R25P0EbqoVfh4wM203WJ0gk6am6lkxkMFAz6t9mUPEfht4WYqsJvGvLR8LA5?=
 =?us-ascii?Q?A8eht9s92kozBDDjk26IEvWc9fX3t96eBQhq0JETu6z8nZgHLbAHwcw5IPNI?=
 =?us-ascii?Q?deC4aYrXZ18Iz7hSaGOeSgToJj1UvSp2GPTHO8g7psb4e+bBMN7jIc/dROat?=
 =?us-ascii?Q?N4siiNL/Gcu7oLF0AExnvOSFs/kGDi4sQ/0Ohr4MP9b37WN0i3LtZVekTk4t?=
 =?us-ascii?Q?OhyieI8R8NanMJcKypbLShrZN5PvejAd1Nynb/tY2MzMllTAj3ugMJDDwwm0?=
 =?us-ascii?Q?P+I1+9cpnpR80y6E+rpThpTFC6wQ4F7FJFvWeWswAsmFnnmJxCYxGy3JrssO?=
 =?us-ascii?Q?BNg96NoJcL/RL5rjQfTIrtuoVvjPuOV9xuB3CZk2wJwfRrzm2NCT0DjRWbEZ?=
 =?us-ascii?Q?VyixDhEt4vtJJbx3z/A2mDBCKvm8RanZZ/8jiJWBwGa4v4OklfVu/vUDBWhx?=
 =?us-ascii?Q?tBsBzNDmCV1fuHfJS9YX8wbZkRzHyXWishhkLo3b0MbJWAWZ36Bk6PjaBCAi?=
 =?us-ascii?Q?syDI+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G6WeWwBJNhlSsk4fA49NF2NpXX9+0JHNYtRxD4+kxcA6BGlsW9aPllVrotl+BSeOAAUZubVmwgmhDNkN271OEclwiZ4j3Rq0DGnMXYtykphgBfabNgTnYXWq3zI8dl95cPopUYcRPvvu1fmDzSjvea4k7HbBTwTzXwB0hMdD4zVLrb7T9PwDZ0d7g4C7m2bP2i0GpZvfzc9dZqOskiKCNRZot3LlPMxMiHnkttF3tW+l78ipqC5sKwbW++ubvBA5dY9V0zm3QWnjN53UaWy86sY2roSzgvEfVdghFAuVu9f2AJeDpbwLl9tseJpmSXb+xfFmkqkoP9CIHsgyUPoXrqUI8GFi5hZIGWJciqXeIvEifJ4mLtjK4V3nATS2gNs96Djp9wmhClDZ9T36b2jr6SgM5lZvwxNGck4JTuaoIRY6hNSJ9z6xZVy94JxtqBsu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:23:03.5922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b61dcbf4-0de6-482e-1a28-08de70b577f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513
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

support stream performance monitor.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 72 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  6 +++
 3 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index eebad3378352..685ebbacf14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -164,6 +164,15 @@ struct amdgpu_kiq {
 	void			*mqd_backup;
 };
 
+struct spm_funcs {
+	void (*start)(struct amdgpu_device *adev, int xcc_id);
+	void (*stop)(struct amdgpu_device *adev, int xcc_id);
+	void (*set_rdptr)(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+	void (*set_spm_perfmon_ring_buf)(struct amdgpu_device *adev, int xcc_id, u64 gpu_rptr, u32 size);
+	/* Packet sizes */
+	int set_spm_config_size;
+};
+
 /*
  * GFX configurations
  */
@@ -416,6 +425,7 @@ struct amdgpu_gfx {
 	struct amdgpu_mec_bitmap	mec_bitmap[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_kiq		kiq[AMDGPU_MAX_GC_INSTANCES];
 	struct amdgpu_imu		imu;
+	const struct spm_funcs		*spmfuncs;
 	bool				rs64_enable; /* firmware format */
 	const struct firmware		*me_fw;	/* ME firmware */
 	uint32_t			me_fw_version;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 5aa830a02d80..08d62183b2e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -548,3 +548,75 @@ int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	if (cntl)
+		adev->gfx.spmfuncs->start(adev, xcc_id);
+	else
+		adev->gfx.spmfuncs->stop(adev, xcc_id);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	adev->gfx.spmfuncs->set_rdptr(adev, xcc_id, rptr);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+}
+
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+			struct amdgpu_vm *vm, u64 gpu_addr, u32 size)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+	int r = 0;
+
+	if (!adev->gfx.rlc.funcs->update_spm_vmid)
+		return -EINVAL;
+
+	r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
+	if (r)
+		return r;
+
+	/* init spm vmid with 0x0 */
+	adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0);
+
+	/* set spm ring registers */
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	adev->gfx.spmfuncs->set_spm_perfmon_ring_buf(adev, xcc_id, gpu_addr, size);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+	return r;
+}
+
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm)
+{
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[xcc_id].ring;
+
+	/* stop spm stream and interrupt */
+	spin_lock(&adev->gfx.kiq[xcc_id].ring_lock);
+	amdgpu_ring_alloc(kiq_ring, adev->gfx.spmfuncs->set_spm_config_size);
+	adev->gfx.spmfuncs->stop(adev, xcc_id);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq[xcc_id].ring_lock);
+
+	/* revert spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, NULL, 0xf);
+}
+
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	if (adev->kfd.dev)
+		return;	/* TODO: */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 3e2d2e333907..b526f256ad30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -361,4 +361,10 @@ void amdgpu_gfx_rlc_fini(struct amdgpu_device *adev);
 int amdgpu_gfx_rlc_init_microcode(struct amdgpu_device *adev,
 				  uint16_t version_major,
 				  uint16_t version_minor);
+void amdgpu_rlc_spm_cntl(struct amdgpu_device *adev, int xcc_id, bool cntl);
+int amdgpu_rlc_spm_acquire(struct amdgpu_device *adev, int xcc_id,
+		struct amdgpu_vm *vm, u64 gpu_addr, u32 size);
+void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgpu_vm *vm);
+void amdgpu_rlc_spm_set_rdptr(struct amdgpu_device *adev, int xcc_id, u32 rptr);
+void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 #endif
-- 
2.34.1

