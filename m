Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE51CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F01B10E682;
	Tue, 26 May 2026 14:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7pWmCP3";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B68510E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoFmIDqc5yMFCOl9gjSHKiwTwwIX1eneE0ODNZA5ZYBjFCHyR1yqaP8TziRDMebH4+kfrxLUFVApGKWWNTf6cvYndbM+Q9Jh5suG9a9ur8hIGV+gymGV/X60WYcqU/5Ud9lQHzntGx8C4555s3eUzuxN838GTWGlWbIh/8x/HLyyoFAlAuaxzOWLyDvy5dJ4BrxgzjNkufhGKTiTTqr+Lnlj8pEQE2VrLvnS90KLcgG3ZG42LMG9T1QM2kMmcWJTqpH95WbMoDNzm1Ghlwu1SnZbSHcHwlhC4a/1lvwzypSmruDIcafrT0SQaTh/Cc4QSxCb0Mn0fisW4oVj4A6Hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0ljdr0f8H9diuEszkYs9fJfuA0pD/6JOKhkd0qJrMA=;
 b=EghPoZBXZH7gE/ORQ6m8Gf0XDSBpGzuQLvwxwIyfPa+Of1J6kA8bShUHiWZqtFijJexQsX76O5CwPoq5mUDCOe6ruIEjbGs5w/W8mVM+eSDkDa5v+JZFPScS3D1XN3G30nNoMG5x/8x8Rm+uVe2ozmARUKe8jWXZ438mV9cfg7lA5+pkMY/JZ/4kR55BpckGM3zLUFVRrGtGq+E9mUWpo9CHuk7rfxxPFKzV74EXq6aRrvyCpALEMcpRUO0982RQU0dZ82KXe+Dh6BW5P+wKjQNv+vqYZf9N8/X1s9xgLpPCs54OPG8h56KicGrZb16vEpbIu1tDzvfJZNOErb1mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0ljdr0f8H9diuEszkYs9fJfuA0pD/6JOKhkd0qJrMA=;
 b=w7pWmCP3/e3FflxrEMsVOG/mTPYlLPd69jsMB+z3Ak9fN4rBZPH+CYH/FhuRFE3kGLceTlXt0HPl69PIzJhwdgrzGQoQNmd0Wzc67WnGIFwaWF6O7XvZh3pS1ZKLKGk5E6uL4M5mj3RJxDS0oCfCwGQbdqhUmp1ZEiKyNqxG4qQ=
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:11:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::35) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:11:57 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:11:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 08/17] drm/amdgpu: add profiler/spm interrupt handler
Date: Tue, 26 May 2026 10:11:20 -0400
Message-ID: <20260526141129.592886-8-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526141129.592886-1-James.Zhu@amd.com>
References: <20260526141129.592886-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 32673191-819f-48b1-0a72-08debb30bf61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: HbOqx8P7wklLotWQGMhAmKDiqXov70+yds3WoFZ801nwHxHkDaB6iDF32PVstntLv9TjIYAvHIfItNQOKxDoXG/wkUk6g5elhXJgQTuvp+dFsMT+EYigbiy3O0fjuDsB35zLb+z7SjS7B6RZl7Ooglqonx5u+GqHgYo+ZoJrBXZ/9K75DeZcLYtN2Yly6fwqRM8QPfmkvbU2cix1pIvyIm0xY8AMyyGkj9enc/VqWcRR67AnJX1qjJD51eAbWDnXyX2DB1Kpb7f1EzmbG8bH36iDCSyEGkzXysoprWhbSUxH6bznc4M5N7/W07p8/LkYkE236M+34gFihH+nM0LJsWA6pg5nhz+t0ji8zL1YnVW21Li/IczFPMGhNPp8VwYJwTsxbuI6rPWvyvVk4iy8yjc1oboHHAfsND5wMWHpUlM/3fX9MaGKn5mTzOI5MbwIshOwvS3RUGNR2GsNNzqR3SsX7uyB2FL86kLK3m2QS5Qv3sYX2ZwtVPV7riEZEAv8fDi263wyxvp5Xlmw3QctevEt7RlhFDPK26hR55vJcyqfBzxfwGqSPE7QgQBbRt/NGNmHrQ1WKqDEi4ZazCAZRuyNC7f3MrHzBXKRyQ9jzE29qHCzJE1WxMpFgXUxh5KukS5872csVA82mnu48X8MOvX4/Aoi/UFfxSE2GJ8poC+PQyvlTd7jJTyvnQHBgGQFKvpqsfOvigztQYBKSmSrDLgJ5OAVaYrCzCWs3fufyss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: triw665c6xlApHoRADlpWOzYJJBoLdy+XUigyNSoSYbtsRP1tDDBj7lR9IEpvDfNJiPADQ0oXXItaHffqvZucRkLVIqGRwYYwf2Gg5zbmfgQ3x05ybJdatvo8M39QyZHpQtvK+kusQV+Vf0rMiJJ7kU3khmPqECmOF/8YtIaLwXRKypzwdQSLCKMYSoad3x7C8FGAPaHdLWLRUy6G82Jbz0oTt1bOnvBo2hfVvCayoF5rgNDtYEeyRdXVaHT4/dA+5MTgaK+RaniIcX0t3dg1fwwca1R/XWEGK7GSTYtMqXZ0Fd9Dm5DsdXAYYTXJ6ruZQtRpEznn2yrBB2QAwpfjxsYDm82EYWHboYqic/aK1WwWKCQkn9ip/3txLkCsS5wwpb1k4uQhlPAi94Dq7LibDu0gSqpqT8A2aodTVEFIuSn6tL+/vqMDRnvxjawJsDN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:11:57.6409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32673191-819f-48b1-0a72-08debb30bf61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725
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

to complete the amdgpu_rlc_spm_interrupt() stub by wiring it to the
new SPM-layer interrupt handler amdgpu_spm_interrupt().

amdgpu_rlc_spm_interrupt(adev, xcc_id) is the entry point called by
IP-specific IRQ process callbacks (e.g. gfx_v9_0_spm_irq,
gfx_v9_4_3_spm_irq) when the RLC fires a Stream Performance Monitor
interrupt. It guards against unconfigured hardware by returning early
if adev->gfx.spmfuncs is NULL, then delegates to amdgpu_spm_interrupt().

amdgpu_spm_interrupt(adev, xcc_id) is added to amdgpu_spm.c as the
SPM-manager-level interrupt handler. The implementation is currently a
stub (TODO) and will be completed in a later patch to schedule the SPM
work queue for draining the ring buffer when the hardware signals that
data is available or the ring is near full.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index faf2a34df42f..fa89dc04d072 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -671,5 +671,8 @@ void amdgpu_rlc_spm_release(struct amdgpu_device *adev, int xcc_id, struct amdgp
 
 void amdgpu_rlc_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
 {
-	/* TODO: */
+	if (!adev->gfx.spmfuncs)
+		return;
+
+	amdgpu_spm_interrupt(adev, xcc_id);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
index 27f4ed1aa1e0..af7ee74aaa35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -60,3 +60,8 @@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)
 		spm_mgr->file = NULL;
 	}
 }
+
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)
+{
+	/* TODO */
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
index 06b4f6dba41b..ade50abfa590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -30,5 +30,6 @@ struct amdgpu_spm_mgr {
 
 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr);
 void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id);
 
 #endif
-- 
2.34.1

