Return-Path: <SRS0=wHtS=JH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC7C43600
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AE6610CB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Apr 2021 02:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE6610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5616EC77;
	Sat, 10 Apr 2021 02:05:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 997066EC73
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Apr 2021 02:05:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGFx2u0EiIq9/dv/xpyA1A8HjJHCMFFFaijnJpMAE9OOszdQDjSnbCqEAc89Ns3AHtqvcFnazcB4Kq5CYpfXAbvckMQsfuWflNMkCsaDkqTFh0ociO2+EiXXvaDI+NUXfpZKXM9aoyATpBWx1XSYdPIFxyNGs9ANFsCpL3mVu3Cy5DxxNpzUXhWJuqRekPpw10bz0ioovygQ/BcrPCweOQf++hkBEKOh3dd3a7MNeWBqmDmu75Y/bAAA36pTBpea9jpK+nCKP1Qmusu4tzuqLxJhtR7gf1TffUe5VoD8j8QHMFZzT3KPyOw3EANx1OBz3dQZNjNpbUj6aoLkttpr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQzLkEMozA6VO0EY8lV7oo8HJNDzJ36IB5D7y33kRSA=;
 b=c5fWjtbJED7dq66uSK0VpsZT0GBGSzoyYDoiNpqFytWcRFKjxZO7qfNVFa3RNnQ927IgYzz7JIJTeDiJubT4rSUU1ItXjPPTs+U8sNZn/tthXVRY4yb4tK9zkw7Xz/M7NXJJKDz+hII6aNJ8af76a2KOuONZ9mO9EvvH1ow7xrImDFFitaqs5edVOlHeP440YCXC+iVs6c+TYFiwtU9mhCs4bRtLxREDM1gc2PQbdQHi6JUma9vY57WS+czRUwGGtCbIYYQVcO1veeW4ZwhJkKz+QBUQoTqeTdwYslDyLbx5FT9zNXGRWJCeqSahMcD8/tTSetl50EdfBAwpuV3/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQzLkEMozA6VO0EY8lV7oo8HJNDzJ36IB5D7y33kRSA=;
 b=onr6v0t7jfjzst1fSR6RZ8ElmUsiEDYWlcNKtmKhZJS7YfH/GgCXPz2S4Nsj+UuaWcpJbUAjBuLi1wWw3M+cqr8gOjH/atuLiDaIQEKS4s/Uzqm5zsxqkrN7+Oz5a3zl5ncIfau3HNvBUwgIkIRkpQQZ8Xhueu/0LnpAGFt34yg=
Received: from DM5PR12CA0058.namprd12.prod.outlook.com (2603:10b6:3:103::20)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Sat, 10 Apr
 2021 02:04:57 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::99) by DM5PR12CA0058.outlook.office365.com
 (2603:10b6:3:103::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sat, 10 Apr 2021 02:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 02:04:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 9 Apr 2021
 21:04:56 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 21:04:50 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Add debugfs to repress HPD and HPR_RX
 IRQs
Date: Fri, 9 Apr 2021 22:03:55 -0400
Message-ID: <20210410020401.1100228-11-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410020401.1100228-1-bindu.r@amd.com>
References: <20210410020401.1100228-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9028522b-f27e-49ef-363c-08d8fbc50a71
X-MS-TrafficTypeDiagnostic: MW2PR12MB2473:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2473059CE0A36FCED6EEDA0DF5729@MW2PR12MB2473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IClNgBufKhCOZogtLsKqz6TB4JnveCuj0jUcH4+InnmXPMBikC5kwSBmv0+D3wVrkVy4klbVD2zwtOITQuzyAWVxL25yT6mFr3n7Tw/ZpF/ohFvr3VevrLT1NDxupqkg8Nar7M0vLdktZGdRn5uyWJK9Bte4uG2FYmSoixlHWXuz6Q2c2YBk/DRkeZwJvdVaEsBG6RbvUVr1NtjEMMrLzfVhtfQ/Ar1s9RF4/zb3xzVqSGO97raZR0bgFpIVG5hQCHEy5Oy/v5MQu1l+ny7H2axwM8wfU6VXQ/iKMa71FuKrwTBE6tkHkvI/IZIKpxAa7bvafSggdAA0/taBlKTV02YVoCDdB1ex6Wd87kVi8AH23YBi6wQ/8Ve4oOHOy4U5PWnh9rMgi65tWrvPtZW11fb2qBQzip990f7psKxulcR7FbSsKNos9nrUJuyikvHCa8s3d6VutaQbrJhEnyHQ/rBGz6CKa/hnkiBTt/6d1rPWSgiYMLUwmbCFkNuE1eOOtG0yA4JawQdmEF6saOLKQi2tVQ4b2WoHY93G9Y2Oi4FpRSeNxioAF4KknwQR9apawJ3gaica4IwYWcJ0YAGqevNz5PdGe0kIoUI3Ck/UtW9sDeYoN5jbECOcOhC3U9/jlcRkBzZwJr8z0dVa1czbgB5wWBv/b7hh+suwAy1yMyg+m9Un2qehEVxhy/AAmxba
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(336012)(86362001)(2616005)(2906002)(36756003)(83380400001)(5660300002)(36860700001)(81166007)(4326008)(6916009)(356005)(82310400003)(8676002)(47076005)(1076003)(82740400003)(478600001)(316002)(70206006)(7696005)(426003)(54906003)(186003)(70586007)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 02:04:57.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9028522b-f27e-49ef-363c-08d8fbc50a71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bindu Ramamurthy <bindur12@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[Why]
For debugging reasons it can be beneficial to disable any hotplug and DP shortpulse interrupt handling.

[How]
Expose a debugfs to set a flag to bypass HPD IRQ handling and skip IRQ handling if flag is set.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Bindu Ramamurthy <bindur12@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 35 +++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7dc7389e337f..e29cb2e956db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2553,11 +2553,14 @@ static void handle_hpd_irq(void *param)
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	enum dc_connection_type new_connection_type = dc_connection_none;
-#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct amdgpu_device *adev = drm_to_adev(dev);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
 	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
 #endif
 
+	if (adev->dm.disable_hpd_irq)
+		return;
+
 	/*
 	 * In case of failure or MST no need to update connector status or notify the OS
 	 * since (for MST case) MST does this in its own context.
@@ -2697,6 +2700,10 @@ static void handle_hpd_rx_irq(void *param)
 
 	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
 
+	if (adev->dm.disable_hpd_irq)
+		return;
+
+
 	/*
 	 * TODO:Temporary add mutex to protect hpd interrupt not have a gpio
 	 * conflict, after implement i2c helper, this mutex should be
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 13f3db14b265..77e338b3ab6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2015 Advanced Micro Devices, Inc.
+ * Copyright (C) 2015-2020 Advanced Micro Devices, Inc. All rights reserved.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -410,6 +410,7 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 	bool force_timing_sync;
+	bool disable_hpd_irq;
 	bool dmcub_trace_event_en;
 	/**
 	 * @da_list:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 9a13f47022df..529545045a3e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3077,6 +3077,37 @@ static int force_timing_sync_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(force_timing_sync_ops, force_timing_sync_get,
 			 force_timing_sync_set, "%llu\n");
 
+
+/*
+ * Disables all HPD and HPD RX interrupt handling in the
+ * driver when set to 1. Default is 0.
+ */
+static int disable_hpd_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	adev->dm.disable_hpd_irq = (bool)val;
+
+	return 0;
+}
+
+
+/*
+ * Returns 1 if HPD and HPRX interrupt handling is disabled,
+ * 0 otherwise.
+ */
+static int disable_hpd_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.disable_hpd_irq;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
+			 disable_hpd_set, "%llu\n");
+
 /*
  * Sets the DC visual confirm debug option from the given string.
  * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_visual_confirm
@@ -3213,4 +3244,8 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file_unsafe("amdgpu_dm_dcc_en", 0644, root, adev,
 				   &dcc_en_bits_fops);
+
+	debugfs_create_file_unsafe("amdgpu_dm_disable_hpd", 0644, root, adev,
+				   &disable_hpd_ops);
+
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
