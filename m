Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C38EA3F03
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 05:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F94010E4B7;
	Tue, 10 Feb 2026 05:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/RA4FCL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F6010E4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 05:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEHVJ0P84q6pKorpyDFx/dvdpDBkMopoQpaPC4RFRogZKlsD9JgMD3LIc+wA5z3AZCZ5Udl5APQuGo1JA31Z+I5zuHCDGgaAlgjGUYgxW8Q4Fc808f5s6a6v1OYF+UOVuMGeOolucZLlMDjTFg18WO/7GtkkWmFEQTYdyvTG6j7rrGsLQB6J+v4rugtIvD/XvvEyhK8cQh0wqd5hx7QDMo7ZB8hooCrDeK+iui4Ew4BAHoGRmLB7Yr+N3NnLCgTDwdzWQN0kQJvkxJzZyNzkzvj6A89KlwzSOQ8pywCcfr3CrbWk8Do6FIjL84Irqz6tTHz0sa8M8vJSfDbAg3qeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96UFYrNkKhZzQkpZTZmZ+T/zckhZc+4Ne5myrOibFUU=;
 b=ZX0Aa7Uhf2tDjdLvxs4jmrSQNbUsm1OnpVQm0sdjPkIVd5WOCL86ig1T+yvX24u8n7/b0LTGp4cVkMLae4r0khdIYlPFsh51HOP09Cta+g6XIOtBQdORYAA6grERe+pTd3+iTnatXPp5owW43hK/VUQQpgO3TZotosmvUifRudIK6WkVomvV0YO+mKcKIXLMbkoXxiZtMIMSpvvIrk3JvOlINB3pQgaRXj/LIvnW56Y/7uUJpE+zXXPmqcIZGipaxYXCp7pBhoJon+vPRP16/v5RyjQy99u0vNgjMmgeMy84aoSbJ24uUH5IuELArQML9U5Z1Bf+22GRdQUA/xFamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96UFYrNkKhZzQkpZTZmZ+T/zckhZc+4Ne5myrOibFUU=;
 b=d/RA4FCLl/SxZHLcqsEK4FWRlaAy+6WSnpsZHrMpZ/pEuVTbKwEOQS04lHsPDicHrOrELcuzKzXiKymE5MT2NckD1V/QI4MgjHmzoDf+ascds/3miRoPlmypsZ1Uh1sTffWEY1hbgRVk28ZOTRDu+12Usl6Av+Jh6af7OQq3ytE=
Received: from DS7PR06CA0019.namprd06.prod.outlook.com (2603:10b6:8:2a::18) by
 BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 05:11:29 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::fc) by DS7PR06CA0019.outlook.office365.com
 (2603:10b6:8:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 05:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 05:11:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 9 Feb 2026 23:11:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Make amdgpu_vm_flush() non-failing in
 submission path
Date: Tue, 10 Feb 2026 10:41:08 +0530
Message-ID: <20260210051108.1514514-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
References: <20260210051108.1514514-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 07468cb5-8f18-4f7d-8d41-08de6862d865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWpaQVk3TnhyQk9FbUZMMjVRZ1ZhRkpPOG9Xd240WGFWRzljWHZXYnRQSXRu?=
 =?utf-8?B?OUVOM1hUaWpKY2ZRZUZLYis0bk9FWUdWNFNjcmlDSjZMNURxZjNkeWRCRUF5?=
 =?utf-8?B?TnUvZGg0cG5TY2UxZWZLL01sUmUvTUZsbnFNTlBuUTdnZStXdWNUQ0luOFZW?=
 =?utf-8?B?RmlZSlhFUU5ZT0oxSTlRRmJHdWVRb1AzKzV0RnZWbTVFUkg0aFBwV1ZIeHJn?=
 =?utf-8?B?NmtJRW1HeUNkcmo1NjRmWUdGVXp3Y2Y1aGlOMkJWN29lZjBMSjFqRlJlY2VQ?=
 =?utf-8?B?WTFjU29xVUFjTTJXK0hYRnBIbU9sZktiVkZOYlJtbFVtekhRUU5GZ1l2ci9l?=
 =?utf-8?B?TnBHeXFyWmlPU0ZtTkNTcFdCTTVCQmE1c1Q0UzJ4dFFxdkdnR2ROTm4wYzVv?=
 =?utf-8?B?RjZ1UTJqOVR5N2VmNkliV3JPVHpCM3BtY0h5aTZCOWI4SXI0cTZGK1BDZ0Rt?=
 =?utf-8?B?TmZ5TWs4UUVxTUpYZVZENzdvc00yLzNjWGdwTXZQUWlMNnRoeEc5WEZSTzlQ?=
 =?utf-8?B?Ump2dlR5TERQQ0pLQXpVb2xhZG9UbTFLdlN5MDNJRE5HbUdKMUo0cGIwcGhO?=
 =?utf-8?B?UGt5M1BMYXEzRk1lWHcrU05ZdDFGcXV5bWZCdmMzOXYxcGNCZGIydFEyb0ht?=
 =?utf-8?B?Q3ZVWjlmVWhOd0Rnek5QVGhaNHBTbWtSK1dwekRWWVBzZnNTN1c4cU9rUGJt?=
 =?utf-8?B?V2FOSFRjWGJVZXVoWWI0UDJSUmJuZHBHUEE2RXFJMVkyOWV4R2ptZjNqRDlC?=
 =?utf-8?B?dGs3Y204c0tGUmJSNG5UeFpJc2QxZm5RQXRJaTVGZVlPMHVkSzJIMUJWS0JD?=
 =?utf-8?B?d0k3dEtYcko2QzlYWlRldGtxUTA5cHNTUTJFdkhrYWwwM1hhZW95RHlrWC8w?=
 =?utf-8?B?c2xqY2NZd2YrRkRVRktTTzd6QXJBVEorYjJzSFZUZjJvZTR6ZEpmQURVMlFE?=
 =?utf-8?B?ZXVNdFAwdmpTRHRwR3IxMjZrYmc1WnNKV29iRzR3ZUVoK0VpK2tSR0VKem1T?=
 =?utf-8?B?SURNQ09qNHAwNHY0aXpuNi8rR0s3dVFNOFdWYXNWS0dydStzTlYvOTM1K2pU?=
 =?utf-8?B?TGZQejgwRGJMbVFpc0VEcTFRaGYxRTNrNEFRdmtlcDMzZTBXMmcxMm95YTBa?=
 =?utf-8?B?Y2lNRXorODRjZzZINDZ1dUVQSHdqRmNDK2JpWjVXU2prRUxDK2ZhTnRxKzM1?=
 =?utf-8?B?VGhHa3JESzc3MVRiMmJ0TlpUeS9FaGlRUURMbzFJMEdHS1NGL3dlVjNwR0ZL?=
 =?utf-8?B?TUNOdnc0SkYzOHA0S1FGaWxSSG1UdThUR0hQYytFVS9jSTMvZlB2VnQ4eDRx?=
 =?utf-8?B?aEpNMDR0dWh5c1FGejgwaDhZRUt0KzY3dW5UanN0L1ozR01Gb3dyaHE0MXF0?=
 =?utf-8?B?eXVTZ0tJMklNUS93dHNlcnE4b0FYRlBkRVk2THN1RFVzQmxTS1V2enVRdG5y?=
 =?utf-8?B?ckdOU2ZqTlBlbXB0NDBnTElZT1N6bnU2U3hUMVJDVCtJaW1ob2tqNWZRandn?=
 =?utf-8?B?MC9laTJtNm5kUFRaRmxzT2NMSGFZcEd4cUJPemhEWXE3SnNPNW01YXUxN0Nj?=
 =?utf-8?B?Z2VvUVpNWE9oM1pyQW56WFdFRThPcjdQTml3QlJFU0JFVGJUem9FaG05NW1T?=
 =?utf-8?B?QlBjY09RUkRmTjIyakg5TXpTdGxlSlMyTHVWZ2RFWndRK3ZCcEN3M0JIRndo?=
 =?utf-8?B?M1dJb3dZZXJaVCtaS1MzK0JtTmpIUUhIeDEwWmZiOW5EZmFZbFRsTXRQdXYy?=
 =?utf-8?B?NXRRdGVKcVFROUFJeml4OU9DbGpleU5naVh3eFVsOU1ld284cDN5ejhrRGwz?=
 =?utf-8?B?Q1YyRG5ndG54dDFiQ1ZrQ2VCTDFoT3hlWkVXeFRyajlrYWt5UlUrcDJuUnlU?=
 =?utf-8?B?RDhCQUsvUUMrME50ak5SdGIra0xZNGw0am54RDFtWmI2Sk0xZ2JEbDhtYnJW?=
 =?utf-8?B?by9vUkZmRDB6YXF4cHFtVjcrcEVDdE8yVE41TGc2cmZKTXlteVNBQ0pDcUJG?=
 =?utf-8?B?bVlSSjIrZ0RDYnZ3VFFGa2kvSE5rRWtnNkhvWC91WVllb003KzdIdTZFZHU5?=
 =?utf-8?B?ZW5ZZlNwcHVSa29XbE1CNU1kcS9CY0NVYlJQOFFWK1IvM0FPUGRhRFRLWVpy?=
 =?utf-8?B?eW5NU1l1aEhpaHA5UElHeU9ZK3hhVlczNlQzK0dFSStVMmlYRGpUdjZpTTJJ?=
 =?utf-8?B?RHNYaWFOcldadm4yQlpwZjJ3eHdzN1Nqb3ZDV3JhR2Roc1h6U2NVVjlRaitB?=
 =?utf-8?B?WmN4Szhrd1pUUThxZ2w5WHNzekNnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l76hzMEwxubljZmcjYPQopJkRoboLS2q2/wJLFSaBXJojEfMWlRrwyjMtLEhkSPsbbrpZxEK7jEGkesk6F5wtGGetjZ4HDC/oQCrymXbXLm7sG6VmRSga0driehy0rvMQ9f8VceC8dC2eIJItVzxn0h3MBTVr8we9NeHgIzMxORagnb85Nz2/jWcDxiMbgb710oP5ZKOvvUsnaQnXowtZoG4sxFBPcgae0AzDEFdpW6RCaS8ABs373mrLgrcphp2J0tA/q9PT6nFRl9pbfYrQGiYNGybbvOlTdNAyx+jsaTRJXQ2iYArQ1JkmlCw/reaGg+7sOKeokETmUfuUAB3emT5eTvccBlHQMDdNKQMOP9FZoTRf/R/NfAW1cxS//mCdZ9z6zFl5BWuCIgnod0i73mDqzKXZbVl/iil36i1kHZ8Jt4tVXauN9v/3koUssrV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 05:11:27.8956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07468cb5-8f18-4f7d-8d41-08de6862d865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

amdgpu_vm_flush() is used during job submission and is not expected to
fail. Convert it to return void and simplify the caller.

Initialize the COND_EXEC patch location to 0 so it is safe to call
amdgpu_ring_patch_cond_exec() when init_cond_exec is not supported.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bfa64cd7a62d..e763b2c1a386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -225,13 +225,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	if (ring->funcs->insert_start)
 		ring->funcs->insert_start(ring);
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			goto free_fence;
-		}
-	}
+	if (job)
+		amdgpu_vm_flush(ring, job, need_pipe_sync);
 
 	amdgpu_ring_ib_begin(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 807f8bcc7de5..5875a65f4760 100644
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
@@ -846,8 +843,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
-		if (r)
-			return r;
+		if (WARN_ON_ONCE(r))
+			return;
 		fence = &job->hw_vm_fence->base;
 		/* get a ref for the job */
 		dma_fence_get(fence);
@@ -892,7 +889,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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

