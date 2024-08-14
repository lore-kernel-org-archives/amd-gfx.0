Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A95C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 23:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D709C10E040;
	Wed, 14 Aug 2024 23:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkuSVh3f";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF62810E31D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 23:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS2xjplfGR2/XdRaaQ7fp+Jc1w2+Kn/P85hodQhBFg2PUmWqUnAko1iK2RfT1vP9PYsAdCsMWGGF6aOxssB8ixjiVQeEbQlgCd/hI5dFYzqNYlGYEb7ffv2NlC7vsUf35/Lv5HI2FVmuUIp/DGIy/PoM4u4c89BtI5vIN7IU+kB4RUAARqhh4FFqj2HUB363TIAnAA5nCIyNu9Iu2MLFE3HNbY7FmQzuykaoXyu2oSi2cnu9uzjtbjF4rlthqvHEWhfNrG1mBpty11bM/Ff3O3CmqTIrgv6+jdNCRLcGgB2ocpMGwlRknF8XXUUByKK9sAnk+LCgWULWsQk39SvQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn+zAkF4LQdcjVOoEb2vDuzabvsj94bOucXS5U/z/PE=;
 b=Z8+xNOGY4gDoFsN8lrEcpo7njbdmGYnXtNJqVRxdsnuRp34QkyqUnM9UJT7Pp1q4pbshoAkopXmGgh4iiTZdS4EXjkdMG93uLTgG8fPYiXTMIvOBIvT4ETRsHYvRJD4Ue86rj67zLxRbnRUqNVkQxqC4Wjx50y6+Pd8wJybzAjh1uViSv7eeittMUrEJ0aZGFnWREFOpqgKY4PIK6MAfcBRVM4Lley1mGr8E6VCdXj9hG47W95TxrUacAE12jgYFVZKBOXrQqih3KcWdWLspjGD8kD+JmOT5lAjZZxlkh+9NkDxQyX/s++CoXYuWNZnh+s2X0ZSfRFNLdf+Z2fLBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mn+zAkF4LQdcjVOoEb2vDuzabvsj94bOucXS5U/z/PE=;
 b=BkuSVh3fgqK1itxeKK/kjtaDS2EwOAkHwf5wVe2eDeyrSpkRtQ0zjz2MRJEUJiybWomGOzpK9W2jA99CNLqMEBOHSdSt55UHydfC9fzWDl2z3G+Cb8crCs6ZIedQv2KV7XuVq0jYAC6kjbnjJvIma0rnAVY1cOsvFx+rc4+s8YA=
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 23:28:50 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::79) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 23:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 23:28:50 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 18:28:49 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for
 GFX11
Date: Wed, 14 Aug 2024 19:27:52 -0400
Message-ID: <20240814232754.1119319-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c8a1d84-c7b5-47c4-acf7-08dcbcb8da71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U+b5TC7LCqwnwvdGIpdRPtabL6NUOV2DQtwiFf+gm2w8NKwvvABcUbZDSl3g?=
 =?us-ascii?Q?ElwcLzPZ+X+blc+qyEXFgZDR1fZ9QcP3DTcySKW/3SNnNimBEZBPj/jPupXs?=
 =?us-ascii?Q?xskZnotPRpZBaD3fIk71A6EnURuNEbLmMIwDC0d9w0IcMAcNKY8s9ZawagCE?=
 =?us-ascii?Q?sc3Q4Eg2a+0HVRyKSXBGZZlgSiYzQdD1Aw36r0YmWB3nuOKykmlZTtAUyewx?=
 =?us-ascii?Q?SGIXFT93EdAHF4wO5vq9s8CANbcS5KdSROScUBRPv+RmZHhhLhAWllUMNDV/?=
 =?us-ascii?Q?2/ytrZqPBbyTVRAVT3l6NUoMM+D1r0iCPRswcMZGFXr5OkMAxa7acvEZqmIn?=
 =?us-ascii?Q?c6+PYQv87vWG99qLtXEp/fs4mPJ57UB11f4tQ3a3x0vcDM380F7DZgNZjeUg?=
 =?us-ascii?Q?CIuwh0b54xvbLxgDRHNv8sYJnmzYhfRTPAPA/ERxVfngik1GD8moZaLfvKNz?=
 =?us-ascii?Q?SlJS9GVyZrtyRTlnpXbCzQgXHDHgdYypBulTmCfUeZT6zm9U8SNPjjh908JZ?=
 =?us-ascii?Q?Rh+wotvcrszlmt/vQVZy7cd9bZleGtezP7byxWN772esFBzmPlRAlyE7zK3m?=
 =?us-ascii?Q?e5FqqI1IHC0t3RopaujvmjClrtzCt10gpEdCB/8pqhN/7+BylI+astYaww6A?=
 =?us-ascii?Q?+Hhpzkzlru+LXkzFpaXfupiRiHtH3TXcsXzpE8c16n+uRxieD1qbhrlXUmyj?=
 =?us-ascii?Q?HaEk7AfhRaLez9HVFvqHStanFdhO5fHphIdjYUGnoapbQ1lLzM1DAkeXpAwU?=
 =?us-ascii?Q?3SpwRIstcKQDlcxxIN0OWHtQmOaOQROHdHMOiGHdhBUb+fN1K/nzR+r4sjzU?=
 =?us-ascii?Q?ECuEfyDiUYQbsazqR0t50o6h1FYtSpvss+x6WrmMyRnO+TxZJ+RU1z8G9foV?=
 =?us-ascii?Q?yICZQZtoef9p2rQwX8ylIKgoYSv5T8M/KHlM57aziABZvf86lCzMUIttfrsh?=
 =?us-ascii?Q?6qXgmSyGXYXfY1RcanzncYYKp2m9FyDhH+AEgTGAe2ttql2ayULbmVkp7eIy?=
 =?us-ascii?Q?FF55NJj0fiQQh8DHGdx9aaFXZ94QFOT/xlXMRVcDtuADeY5Ll0Z6Vmc0lpnG?=
 =?us-ascii?Q?J4rg+5Im6oObMCyst14ISTeb0qd6Z65nDz7sp5rRsRj2MsGPHSzCwlOdWe5j?=
 =?us-ascii?Q?RVQHUq+nbPPisvSQYGrK3LiRxKzURNtxTW9B3ZBE7NRAF5qLS7FytM30AMP1?=
 =?us-ascii?Q?azqPtHCYqyNZIhgl0S4gO50b6yKibu0gL9OWpggp602PqKEH6H3t6LZ66fWJ?=
 =?us-ascii?Q?3Jwi/iTU5tJWefZvnf/ukaZApF2c5kMp0v74vJntU9lhiG41ZDWePJDBqsqE?=
 =?us-ascii?Q?nCSmIZ9UtCj5qPTzg0etKBCZKkze6b4zwrB+rcG2eY6eyDpJ7Kr8Eh36WKug?=
 =?us-ascii?Q?PZGuLhsHT/9gKRmfTa7ATB8M2PzKTqg/AuIV5rXZwJw7TFUlCPueb0681EoR?=
 =?us-ascii?Q?7nW4ou5UIH2DrZyZ4dlLAPrZSva0nGkG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 23:28:50.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8a1d84-c7b5-47c4-acf7-08dcbcb8da71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

Add implementation for MES Suspend and Resume APIs to unmap/map
all queues for GFX11. Support for GFX12 will be added when the
corresponding firmware support is in place.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Add MES FW version check.
- Update amdgpu_mes_suspend/amdgpu_mes_resume handling.

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 71 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 32 ++++++++++-
 3 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index c598c3edff7e..e551943da77a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -501,60 +501,50 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
 
 int amdgpu_mes_suspend(struct amdgpu_device *adev)
 {
-	struct idr *idp;
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang;
 	struct mes_suspend_gang_input input;
-	int r, pasid;
+	int r;
+
+	if (!amdgpu_mes_suspend_resume_all_supported(adev))
+		return 0;
+
+	memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
+	input.suspend_all_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
 	 * lock dependencies.
 	 */
 	amdgpu_mes_lock(&adev->mes);
-
-	idp = &adev->mes.pasid_idr;
-
-	idr_for_each_entry(idp, process, pasid) {
-		list_for_each_entry(gang, &process->gang_list, list) {
-			r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
-			if (r)
-				DRM_ERROR("failed to suspend pasid %d gangid %d",
-					 pasid, gang->gang_id);
-		}
-	}
-
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
-	return 0;
+	if (r)
+		DRM_ERROR("failed to suspend all gangs");
+
+	return r;
 }
 
 int amdgpu_mes_resume(struct amdgpu_device *adev)
 {
-	struct idr *idp;
-	struct amdgpu_mes_process *process;
-	struct amdgpu_mes_gang *gang;
 	struct mes_resume_gang_input input;
-	int r, pasid;
+	int r;
+
+	if (!amdgpu_mes_suspend_resume_all_supported(adev))
+		return 0;
+
+	memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
+	input.resume_all_gangs = 1;
 
 	/*
 	 * Avoid taking any other locks under MES lock to avoid circular
 	 * lock dependencies.
 	 */
 	amdgpu_mes_lock(&adev->mes);
-
-	idp = &adev->mes.pasid_idr;
-
-	idr_for_each_entry(idp, process, pasid) {
-		list_for_each_entry(gang, &process->gang_list, list) {
-			r = adev->mes.funcs->resume_gang(&adev->mes, &input);
-			if (r)
-				DRM_ERROR("failed to resume pasid %d gangid %d",
-					 pasid, gang->gang_id);
-		}
-	}
-
+	r = adev->mes.funcs->resume_gang(&adev->mes, &input);
 	amdgpu_mes_unlock(&adev->mes);
-	return 0;
+	if (r)
+		DRM_ERROR("failed to resume all gangs");
+
+	return r;
 }
 
 static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
@@ -1608,6 +1598,19 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 	return r;
 }
 
+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
+{
+	uint32_t mes_rev = adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
+	bool is_supported = false;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0) &&
+	    amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
+	    mes_rev >= 0x63)
+		is_supported = true;
+
+	return is_supported;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 548e724e3a75..b2db62e50454 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -494,4 +494,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
 	memalloc_noreclaim_restore(mes->saved_flags);
 	mutex_unlock(&mes->mutex_hidden);
 }
+
+bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
 #endif /* __AMDGPU_MES_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c0340ee3dec0..a5c582674db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
-- 
2.35.1

