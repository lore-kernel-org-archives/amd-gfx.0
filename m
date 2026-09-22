Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9A8C982FF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4140710EC12;
	Tue, 22 Sep 2026 09:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VsWYpQmA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012020.outbound.protection.outlook.com
 [40.107.200.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B196610EC12
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR1omptIuxxl3bqITjMyKzS63D7OFufgcC9a9uQkD4pMsGGcFQezP4SYuEmAR/5F0NZIRu8dXIx9QZ3Q1gHErwnTE2B/HSHpJhHdMB+gG6ar5UeKfPrzuRfZBY94xnGPPz9TC1yFJbArAifboNjvJYjKqyn0S2kixGdTGCrrt+lh8YNPV+oqgAQ7imLblGhsKz0VB85IjP4Bj00kXZQX1kG4+7FEhdn/glX6FwOY+13BpSUPFLeIJSB39twb6SztKeGJMdVaULXlisKZkEmmo8CYjRpoqWvqmumjsdYbfkdJ1qZOPCZ1wTPTHx7osOL3hHYf9OqmveQFnzzkoq99jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URX1P1joXgz8jrA4sLbMu/r+/1h5xbRrYo0tLw8cKU0=;
 b=KUxGtNCAtzEu6wzvKsNBN3lGREogJmAmXCFBKdAVv4Ua4+fYlWxjA062S+8PXIyWCuiJjcDKBTeczJ27VWkU/XlIebl+EzHBLKMzhg+O0N+KJtdpNnaPXLrjM7u/H3LMxTgvp0ZK0is24vRnde1wyklQv4Hk2VEma6U+CT95Xby6pit+W4f2rQrzZh7ArD2V8/3M6qWsx12edjREVDxM+Y+1zCJQg5yprnQZS68zQHUnXf/TPgOPv42jPxZFDBqeU3RoN2RRlOaKbbkpS1CevUqM0Ee5YKaqu7fCKFDBCfOI+J68Cis6pwpX7x2bJKdYPs7ncor+U2Grz/tyWlBVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URX1P1joXgz8jrA4sLbMu/r+/1h5xbRrYo0tLw8cKU0=;
 b=VsWYpQmAaUDTVBjWkmzG5C6J3RLJCVuDO5PuPPVJ3Je+wZxs5+Po83AiS7W8ZZ1yErjFvYKWxRAXsSnzOmhU70/FuX3/aZUXZYLbTyqLxbq2ogN+nCvyNGYKRKjgt4/HUFnxzusd+1jxq/fhn2wfsKd/jKFb/8Hk88a27bDkBh8=
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by CH4PR12MB720178.namprd12.prod.outlook.com (2603:10b6:610:50e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:34:20 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::7) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 09:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:20 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:18 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 06/10] drm/amdgpu: GFX11: set mqd->perfcount from mqd_prop
Date: Tue, 22 Sep 2026 17:34:32 +0800
Message-ID: <20260922093436.596947-7-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|CH4PR12MB720178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d21499c-5b23-4170-a716-08df188cadd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rYdE/lrAFb5HjiStxOyMseIZV23oBF2P46MF5LX+txWgiloSO9ri9RO4351piWTMnDTRyCj/Ce2ffJEkrAVBuZxU9WGzRFaJGj2pgvymeME06CGV7wy7zSdTPwnxTNyNL9xDcTeJXaDLNf+g4+7Pn8nTOw3MJmCoK/DfseNRQQAQGN8Hz6Na9JKoKblEL3B1QeQQCsX/vfYuAl2b1wEZCIcOAS6IjeCJyvhrhroSPyqGeYrgQy2wnoO0gNwXX7ZgtA39emFdC4egswOs4I7UzVrm2JaMqgnMvMueGxBvs5ikljkARPJDi6g4vq4yEpZyoXNQv8DrcsvU2tufJ6gnlkGLosh8iSAaRUnQDg8Aby9JpQXUKhKxOyRS2n89yVYk1ZPlvo2J3tSzblB4OoktF1gFbfYGGz02fwaOhghR2fbFw5lxvqKrkrainzUhMcDro9WoL8MChLIufcEA1FSoBoAWkyApvsfHodRQxJey+raQ/mTkDY6iTg3ApOkuDHJdsATpr4kUVTJxxxpZ9D41WRqz4kfgE+5iIDKGqmqCFTCZCM6Ha90kzjVhGLPZXscEaketRDq0wY93aWSFgXp5CuqCTfqX9AjgRb8eYnbLdR3hGJ5hCMmrwqjpfHQHI0NXsXojBYqzDUQRD2F3f1MzekivulODTN11sQwBAGD3txP+gLLkVIHxQDUU16qM+5ji
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kArsVUB+3lzPPF28MYD4J7nhjhHWSwDK0T/TkWcDKglfLAgkBIgg6i+A3nYXQkctMQWU7HZ2gBWcq1XPqEYTglPUSJXT6nONQh8g8s3IeoCkR/5gcvqbj7PDG67ax/IJLnaxWFIcqg3HfCRmMY28suQjL7jv1DRk1RPQEum6Vq7CLrBs3s3euLGVh630UiRso3cpfPQ91IFIfCw9VQu+bM5WHPN/525/yWT2+bXIplA6EWjP3xoKwEKeJO+rIbrQxTABxyl2B06bL4qYekYhaaNzvnN+Bxv/Q8dZETKSGj8y3xL5ulY43aeRTt/kJ+zO0+oGcwSma1vGwUKhcXzbTD7XE8lc5fY0Nn4yY7KIL/ajxySIAoXVJRb6V3+5+Nfu3ecrkFtcnJcmsxfbusbudRG7Vy+c3r4w6JSWQgsR94tJ4bWmzHECs7EtFbpyCNRo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:20.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d21499c-5b23-4170-a716-08df188cadd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB720178
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

This commit implements a new callback set_mqd_perfcount
in struct amdgpu_mqd. This callback helps setting
mqd->compute_perfcount_enable from amdgpu_mqd_prop->perfcount_enable.

This is a per-IP callback and it is NULL if an IP does not
support PMC.

This commit also implements set_mqd_perfcount for GFX11.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 7a5499ec1171..f7ae3d5484da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -479,12 +479,18 @@ struct amdgpu_mqd_prop {
 	uint64_t ctx_save_area_addr;
 	uint32_t ctx_save_area_size;
 	uint32_t ctl_stack_size;
+	/* PMC compute_perfcount_enable that programmed into this queue's MQD */
+	bool perfcount_enable;
 };
 
 struct amdgpu_mqd {
 	unsigned mqd_size;
 	int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
 			struct amdgpu_mqd_prop *p);
+	/* Per-IP callback to set compute_perfcount_enable,
+	 * NULL when this IP's MQD has no perfcount_enable field.
+	 */
+	void (*set_mqd_perfcount)(void *mqd, struct amdgpu_mqd_prop *p);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 254a72f26ec5..252a1096b4a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4323,6 +4323,7 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -4459,6 +4460,14 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v11_0_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v11_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v11_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -7263,6 +7272,8 @@ static void gfx_v11_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v11_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v11_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v11_0_compute_mqd_set_perfcount;
 }
 
 static void gfx_v11_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.55.0

