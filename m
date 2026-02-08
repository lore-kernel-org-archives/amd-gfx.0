Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD3CEF06E3
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 06:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E0D10E113;
	Sun,  8 Feb 2026 06:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAwVwgP/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65BD10E113
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 06:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbcTIqY+l6peFx3okTet+PrWWQRWDslJ09L27iAyTjcHnU8VM3uYT+rEJ2OTSAfJBx66DrlREW188w+OmpSRWFt1mBGzzFTnnguqlunllWQg0IJ8GM9AaywTDroxMIBXgdHZcgrjiHAHwNV1AwNqiSh1DxLE0E3Gy9ytlEE+WA4o2hg2f7iDpjCLojNoegtMI9tp3ECKrA8aM88dGF05YCKe7QmkB3a9gOkzIvPqZvtxLILG/6tMavgLVpYCJ9aUQd+lNCa7duuHtek+wTFKWJTFLIlmMGkInqgcGh7Mog+8pH2iqhS0jqRzwNpWyMWWsvtnNUjD/pAfqzPOFKZX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z/eGGB4+Qx2wcBHP9PbBugxz3HmMYT4GKeKLzdt4+I=;
 b=Pwt7O/oRckAZiCRZk42XuiTlGexWw+PdjlC+VdHnNzEZk/Sm2nRrFkGbWaOLeKCmPiAtlDAVfRleF7aavx5hk1h7wf4cWbFwu7yTIcvMznEXuyrBnK+GtcLXbUt44MC66FQSRwLgvWpzMBR91Snu36OlNL53ffUKK2PvK5GwvvpmRNPVfhCTh0n6sOCZfo5TTyc9pZxyyGk8JtNH7pEGghLFxGnf1sJf0rDZ2cjOlGmlGJK7uKAv4UYbN2gk640bmXp8JIW4X++oNcp/e6BzBWse9xCqCbrDaoZZyCUnqpC5v7TnDP8GIRevdHrCtsARvUC1F4BQ/A+w4/u5pI6cEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z/eGGB4+Qx2wcBHP9PbBugxz3HmMYT4GKeKLzdt4+I=;
 b=IAwVwgP/XT1E7Kr1rIoWA3DpZB2lBat8SzrB63+dUJpxFga0K6oD1Lbu6LalxHYxJVeNWkFmu9/n8m/8n/DUFdUiiTBjt/8tXx8lX61KQuZdtrUMQl09C4EDIgWunk7o3SJsY5INpUUjtCclBq6b2CRe5dx6R/yak1nBqiP8Kck=
Received: from DS7P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::21) by
 LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 06:27:30 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:223:cafe::3f) by DS7P220CA0033.outlook.office365.com
 (2603:10b6:8:223::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend
 Transport; Sun, 8 Feb 2026 06:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Sun, 8 Feb 2026 06:27:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 00:27:28 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Don't propagate errors from amdgpu_vm_flush()
Date: Sun, 8 Feb 2026 11:57:13 +0530
Message-ID: <20260208062713.1500367-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0660cc6d-4c0a-415b-dffa-08de66db22bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2o2K25rMWhVN3d5VEJEaGR1M1U2QzBxek1wNkdwaUo1dWxIVzUwUU5hci9h?=
 =?utf-8?B?eW0xejI1L081dERqNzhndll1NkZTSjZRN0FzSi9oc2FvWU80akhURTNhNWdT?=
 =?utf-8?B?dmxwQXg0ZzA0TDRoWEE1cXVMdHdoOVphV2VGZlF5YkRxS3BJdU05Mjlycm8y?=
 =?utf-8?B?RlRJVytaZ2ZURDJvZjJrdWprZkRxOWJxZ09waFNXSjB4V09YNjNTR0o1VHp4?=
 =?utf-8?B?V1F6L2ZxWjlrMXRtZmxpYlU5S2hYYXdocEpONGM2bE5DZE9tMmNrMlZGYmNE?=
 =?utf-8?B?M2s5d2xnZWNBY0hlWk9wOTZEbGpSTC9jalB2NnZmZS9YZmIzcWxtVVVlbXBE?=
 =?utf-8?B?MGxTMGdZRDUwcTBaVVF3U1YyM3Z3NEY4S0Qxc1dSU3NsVC9aVFc5MG1YSGpV?=
 =?utf-8?B?anp4TGYzbDljUUF3TktrcUVjWncwaGFMbzBkRWFTdFRWME11bUJZcytzMlBr?=
 =?utf-8?B?LzY3Z1FMUXVoY2FiSmtMaUtOS1lIOGt3U3FnVFcwaGliSUR0bDBkSHFKcll1?=
 =?utf-8?B?bWdqWVczcWFDYzFCVkt5a0xGYlpZQXJveHA5UmkraEJ1Smw2UXFBMjFCbmVD?=
 =?utf-8?B?VjJvTG9uYzhtVzJKcU5RTDZFRzdlaEo3NG9UNGxYR2c1dGVLODBqZFB2SG45?=
 =?utf-8?B?NU15SjQxMnlJK0hGTlNEZ0NraXRackhtTTVyOWNMZjF6ampDQTM1ZTVDNk1H?=
 =?utf-8?B?NmljcVA2eUgrclN4N3JCYlBBcS9INWpqSTdFZzh0d2l3UTZLNmxMUDNjbi9K?=
 =?utf-8?B?ZGZYTzVndU9DNERPNnBvSG4xc0FKNEwxbU1mNmpTUWRDejhrN2gwdjZiUXF4?=
 =?utf-8?B?MFpaMVBhVkx2YkpzdGpZRmROMXdzYzAzbGEvaTd5TzlNQnMzL0VwUzRRdEt2?=
 =?utf-8?B?eEV3NUZRRW9RVStibm1QOGMyM2JYZ1p0ZnFCNUYxSGsxeVIwTTIxWVlGaUl2?=
 =?utf-8?B?NWxxQWhjK2VsWmQzbzlHOUFoM2dVanVKRDJFZGtBM0t0aUhnNjFHQ1NHRUl0?=
 =?utf-8?B?YWhkUXFIN21FVlJVRjlKT0VIcUtzOG9jbjRiTGhrRExsVUFZQkhhVEZTRTlq?=
 =?utf-8?B?OHdGcUxwYUZvVVFXRUYydSszcnZSRTIwWVliemhSV1lGeU9LQWhIWDl3SEl3?=
 =?utf-8?B?TjZlZGdkMDIwd1R1MXloR0U3akJIWWxJcitjVGVKbzQvRVAzeVh2K1MxU2Fh?=
 =?utf-8?B?WmM2RG9naTNKSnc5cjhCUFYzMHVwRG95aUpueGF5c0VzR3JheG1wVWplSUh6?=
 =?utf-8?B?L21rRExxOEZpWEhTYTc0VXdlajJUT1BXcTJLMXMwSEdzVFhYRzlLamd2RVhq?=
 =?utf-8?B?Tk9QczZRYU91QmVPSTh3MC9WWlluajZKSjA3RllYc3JwWmd2K0kzMnhjWExF?=
 =?utf-8?B?S2d3TlVEeWpxNENlc1dQdm1XVEhZNDkzcWQyVXhzanM5OXdaUzNDeFdsOFFx?=
 =?utf-8?B?VTRXTUw5TkxLSCtZenFwandCaW0xbTJIWVB0dUwrVFNmMXkzamtkend2RHBm?=
 =?utf-8?B?a25zVTBXejcrZjNDbjVEcGU1aW9tUk5YczdHeHUrald4TEVQaUNhY0ZRenh2?=
 =?utf-8?B?S0tMaFBJcHROZmlXMXpDS0RTYVF1M0M1K3J6VmhLQXhPNnRCenVWL2FicVlM?=
 =?utf-8?B?MG1WTnBMZU1Gd2hLWXBRZkxtclgzM1cvWDdIWFpvSkt4a1VpMmo3eHBac1VV?=
 =?utf-8?B?ZXhYMHQyM1FLbEowZTdZTUJqNVJlSWNUMnh6MzBUdndFUFA3bm9OTFhCdGl0?=
 =?utf-8?B?clI1dFVaL3lFSXlOZjMrSllZUHdkV3c0bUR0UTlJNmd1WWhoSHI4RCtNZ2Jx?=
 =?utf-8?B?aFJRUzN0OTV1M205ZUhtZ0NyNmdreEtSdzIzME4yYjFVWVQ5UWF4bm5vYzVF?=
 =?utf-8?B?cXZWZjZhM3M1TDJUUmtZYnZzWXI1WGhUME4rYVJLSkJKZ3VTaUdseCt5a2h3?=
 =?utf-8?B?YmdCeDNpUEx5RnJUWGtaSCs5NWpmamNhYUVQcGEvcUI0aXQ1Tm93MlJuTmFi?=
 =?utf-8?B?WHhvZ3V1bzdUTlkvN0ZsTk9oRkpmUXp6bE1TdytjRjk3aW1XS1drbVQvck5L?=
 =?utf-8?B?SlQzSEg1R0FGWlZpZFpVMDA4Q0NnaWE0ZEVEN0N3SmhJZ3hpVG55TFNEQ1hK?=
 =?utf-8?B?VzB2WXc2cUZNZFFVSTVPc2h6MC9jQVIybHVHMU5tUGVweGVPdk9RSytSeXJp?=
 =?utf-8?B?YnViY1p1a1hna1NuTmZKNG1hR2Jud1lSYzBja3ZKUUxxanVSbmNVZ29YUUNw?=
 =?utf-8?B?dmRIZnNJZURSNzM3Z3RLeW56WnBnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fCq+uxptMGzmAcqc6tgZ+g+dRpi549kEn/p0K2vwowuL3QTVy2s+Hz0H1f/k4H8+XArpm3C+xEWiTeRl2ZIBQfvc/wIJ9ibYuxmE7f/HioCkTkB2s6f7TX8CjZMKzOapYT3c5BZ7r8uXZ5BO66zZhC6AD6Yo4L/u48+6s48iVl1gfintYIbZw9llFN8I4h0ezm42Q6eNJiHJyy1JUrt4fVP2YwNxFcmqkUwhc2CqwZUIlvlk4UVetCC9rxjppWCYkirp0fy4gCd/j/fqYar4nfONVSLX8uPMCjAyKlzcxWpIH4Fk4GegYFg+DMZNHEGtL9k12/+5+sFR0QO23afF8sgoSTCUKllthKtVUBRhGEP6SCvXCPnyHMj7Hsjs+5yjMT4UzDq+vAodrYEPt9Myu8OHBMfOEcCWhDZ8Fg89L4iy6lsav81MSV5xMBw8qb49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 06:27:29.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0660cc6d-4c0a-415b-dffa-08de66db22bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802
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

amdgpu_vm_flush() only returns an error when amdgpu_fence_emit() fails.
That failure is not expected and the caller should not have to handle
it.

Handle amdgpu_fence_emit() failure inside amdgpu_vm_flush() by undoing
the ring and return 0. Drop the return value handling in
amdgpu_ib_schedule().

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 25 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 44f230d67da2..e763b2c1a386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -225,13 +225,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			return r;
-		}
-	}
+	if (job)
+		amdgpu_vm_flush(ring, job, need_pipe_sync);
 
 	amdgpu_ring_ib_begin(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 807f8bcc7de5..2698a3bf7970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -764,12 +764,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @need_pipe_sync: is pipe sync needed
  *
  * Emit a VM flush when it is necessary.
- *
- * Returns:
- * 0 on success, errno otherwise.
  */
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		    bool need_pipe_sync)
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		     bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
@@ -783,7 +780,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	bool cleaner_shader_needed = false;
 	bool pasid_mapping_needed = false;
 	struct dma_fence *fence = NULL;
-	unsigned int patch;
+	unsigned int patch = 0;
 	int r;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
@@ -812,7 +809,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
 	    !cleaner_shader_needed)
-		return 0;
+		return;
 
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
@@ -846,8 +843,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		if (r)
-			return r;
+		if (WARN_ON_ONCE(r)) {
+			/*
+			 * amdgpu_vm_flush() is not expected to fail.
+			 * The only possible error originates from amdgpu_fence_emit().
+			 * If it ever fails, undo ring writes and don't propagate
+			 * an error to callers.
+			 */
+			dev_err(adev->dev, "failed to emit VM fence (%d)\n", r);
+			amdgpu_ring_undo(ring);
+			return;
+		}
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
@@ -892,7 +898,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	amdgpu_ring_ib_end(ring);
-	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..322193b97d3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.34.1

