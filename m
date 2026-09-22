Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DDFC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A639610E68D;
	Tue, 22 Sep 2026 09:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xMK+ZTBS";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E7610E68D
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+QnSVnqi9sXqS+cUxM+fy0BzUhKVCrxwiIaKRyjEjNieUptdmi13oQMr1Fw9t1EqBayjtx3VamkwOsui0aIjRt/1TWDzbtrDmP/qkcBV1GeDPft0XNB20NIh6UmMQqAUjQzL/A/y3yN/WlBd7yHdkEoE5mFK0EvI1ZnVUIVDgekM56WbX976BaXX+JfmPtEkYVrQMpFkNN361ks46kX5/LHhY27BPMBLjIKHvnlkX11GGo7N+qB/slz+mFShiKNwugxiGCSaME+twd8oEhDAns16+6/p9z/4skeEl8JMWlyfrp4ejuwNEsxm1ybGu+k+97dr1KhbUtZUvu4D/z//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L0aZFanjSVmy4GHCfn9xjrAIQ1cqfKx6wsH1w/s3RE=;
 b=eg/vVjNIq/z80dpSLTFmUYhNVU6ZHUrOhTHoIoyt0DBjszdqom6xqg7M0Vsnsd3Mlyxjy016vaojNfn1zWpjKGvHolT7KGAGibAFsvTuzTvwmFA7uSiS2gckEwZfTuaBqwkdbrDvfUgy1JsUY3S7Mkm8xsBPn8QpukFjexHCZYQX/RzMB9X5vzvC1rJeVuufaMS9N+GJuT0W+Z2W4bB8hJqRcRRYndjDNGWtR0K8EkzME6mtXOvUEhwywk5o30HFh3xpJ57UynDA6ICSaZMiHEVm1n6c2FVl1G09N+7bpHBkDKTum1OcvD5Hlg5qb//LC9qj+qNNW3Vtfta+7qGlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L0aZFanjSVmy4GHCfn9xjrAIQ1cqfKx6wsH1w/s3RE=;
 b=xMK+ZTBSN+Ezs1C+CawJFwHOGlzdySK+aADhbUsbWwJvLNBgDMkaC5KvaeL0nL/mdQBJ4WKVh3T5CurS4rISGedWgIqSJtNc2X1JgK0RxuLt0Qla1rlH70CGHUxtogikh/HwdSQT1wBBYX4RQ8a0KeMKduGDNxGSIiFOpT3KWmk=
Received: from BN9PR03CA0548.namprd03.prod.outlook.com (2603:10b6:408:138::13)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:34:14 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::18) by BN9PR03CA0548.outlook.office365.com
 (2603:10b6:408:138::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 22
 Sep 2026 09:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:14 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:10 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 02/10] drm/amdgpu: add device-wide PMC config
Date: Tue, 22 Sep 2026 17:34:28 +0800
Message-ID: <20260922093436.596947-3-lingshan.zhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7a9439-50ff-43f3-d155-08df188caa90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CW4JWC6dH6TjEbaPyb/zSt4/7bKaBz0H2oRrJgoeDNYUsCKsWeCJUTVOSOBfD2reECztPmJeB7WohsFZO0UqMdZKlWxGdFGVZGPQBotACfByhUNbaTZ/wVTIIQFbhj8WAyhop8r5UuDzbqWayNglgiJb+OFFA7oWVAwOK+3u5kj9kJDg9VG0hsexbyMPKzjizzkyhhGR/wIj2mnr/rfrdH8+XIOG1Lcpvru14U7MHKiW4Cg8MZhcp2u1s38bOIu5J6ICRUmgiu3uT/1ytpB1AoZcfOpgi9e30I2P91nW4VB6OdkilOIZnyLqbZg7vUSwAuYNUPRO7hp51FOdoSsEtTQT/ThttM5co20vlx7ImIvfcma/xH205wOWEEwL7kKWJH2b3tuMu4euEJf1Y3pbG6qePjkE2T0c9FbcyWaG/pDl0yoL26/GhEcWql1feBM2ZI7uX8lcX50pgVkfUzA59vnRgfXEZ47IeBJU9ulnewOh1XO5/WT45QiplD4OaZLCKx7uMjPG3LCXjiEEuzUKWGcWnXmZBrCrsW8EtYCbSig9pin1o6NlLBCDcdimcnsw0USUV8eF3LJXUBiVhWhcQl58Att+rW6E7ML6MqnrnPjubdCMktyKGGwD0aqInA/PP3J/vhFKH0In8dkE9DRWxUJbRhZpHcOfHDDtgmWCCXunJK7CqeI5YEobiCbLJ5xpI+VXTWrawCdNeLgz+bLJuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tbvr7Y31TZ8T7ae+lCwkDDxrin6pmokWQnGEM0y951fNFU+nAEXC6jxyWxqdAKc2I1Yjyy4gV1WFVAAJikLm7nNlTdlWagYflf3VZrHDwE7PSyw7WhTIaWjCLLmqoYgIgtuikqNjBEX0VusWDRffXsJUy1orTVVnziYp634Vecf7hoo8A/HW7lv7m5KzAKSwrsIlcQUZibGrUegX192KzYneqOzRXVoP6CdHmwOphI+Gd7HJxQ7mTJFy+mRctvfm6rrAQlb3Jw3ouWm6S9d+/5zgsDY/SH96SsWhS2UI+ohzjmqHSWRznWoFDbBLgUvDf6v0ldYqkbg5XCEk3DxPR7wuJzZYVLG8okyQuBbXVvAAoQvD17GlvrXuIR6MGAyjQwhSEd/We1zk0ukNoGPIbAhQoIAJ+pbXfy/+n7CbHT6oYeFXGUMRyXzgUxWpUF3q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:14.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7a9439-50ff-43f3-d155-08df188caa90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
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

This commit implements a device-wide PMC config
for amdgpu, which including the profiling owner,
and the profiling enablement indicator.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8eff6b9ebe81..45897dca802f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -620,6 +620,12 @@ enum amdgpu_enforce_isolation_mode {
 	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
 };
 
+struct amdgpu_pmc_profiler {
+	struct mutex		lock;
+	struct drm_file		*owner;
+	bool			enable;
+};
+
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
@@ -818,6 +824,8 @@ struct amdgpu_device {
 	 */
 	struct xarray userq_doorbell_xa;
 
+	struct amdgpu_pmc_profiler	pmc_profiler;
+
 	/* df */
 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c924a55fd16f..74ed42e53264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3673,6 +3673,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 	mutex_init(&adev->benchmark_mutex);
 	mutex_init(&adev->gfx.reset_sem_mutex);
+	mutex_init(&adev->pmc_profiler.lock);
 
 	/* Associate locks with lockdep classes for ordering validation */
 	amdgpu_lockdep_set_class(adev);
@@ -4244,6 +4245,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	kfree(adev->pci_state);
 	kfree(adev->pcie_reset_ctx.swds_pcistate);
 	kfree(adev->pcie_reset_ctx.swus_pcistate);
+
+	mutex_destroy(&adev->pmc_profiler.lock);
 }
 
 /**
-- 
2.55.0

