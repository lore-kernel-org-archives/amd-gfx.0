Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D35C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 14:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBE910E200;
	Tue, 11 Mar 2025 14:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8b8tyQx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7766E10E200
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 14:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7iwBWfRsTVc5KDoNks6kiwCMXE5uyXuk/L7Fi+whp1VZZLSo2bp2nHzUT1MUg1Xnih2Z95qp448Dx/U9rMnKkubK9wowIgY7gFfsHeuGUnTlx/C4q1Jqt15fy0npEWDNlG0f82ylydB7JRYccEgfBKAiZFB0AktR6qIlUx6IOYOKeuoqdePedbaVejYSn187lhTytZ84wMryMQ84d1ycdV47Ap5EAvefRHjamrCoMBTC3ehzt05dAUhTtPye3CyTflDH7BZPdCjV5ijDDOTwnnMMIz95bl9YjksmmKM1+vh7C+pWFh3RfOCgoV9Qd0V3waSQVyBzP/OPSN/fQJlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVlhpFivPmPHdxR6xnNOT76tT2sy+54ZoXJD5VKrX+A=;
 b=EF6RGWlAKBLDOIVC9XvV50JuJcoO4ynDq0JfY5pjMVQYXHtN4ldpxrjbWq6eUjeUpFIZWqmUeBdyAwxNcim7WRjLCNP4K7nmrbNG5mKeyK69HhS/o20WmL6LYWS2gRCbsfaVfDLrFqmki1LI2KebS16Z2RSoNgIJVNKXWvgAx26LUPBKIMucJhCT6fNYEfXsQljWXO9r1fPSBFOWgqDaugz8EcwjRUQ21surfRFDRHHNFKb5sdq+F9P0Iu5cKjbKRDOk9I3/vE3ap85UkBHS6NJD8hXZ3rq/9DLuhDy612hvt72pNX9W6LB5xLS/qC1ikGYTzhQSMZT5z6mSjKCZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVlhpFivPmPHdxR6xnNOT76tT2sy+54ZoXJD5VKrX+A=;
 b=L8b8tyQxCh5SrtRbooPl/n70BwF41Wm9Y4hfxCacq4oGEmhA1hxCpo0RxhblU25NTYxoVeoV9yFmq8bxuhGxuSATWbsNU8jQvq75ctSS0Q9cf/yabuwiDmTmtP179iSjFzPqRuatg3I90c60Zd7vxEv+3kFgV92xmPKU/zDxUEo=
Received: from MW4PR04CA0165.namprd04.prod.outlook.com (2603:10b6:303:85::20)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:17:29 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::ae) by MW4PR04CA0165.outlook.office365.com
 (2603:10b6:303:85::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 14:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 14:17:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 09:17:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/vcn: fix ref counting for ring based profile
 handling
Date: Tue, 11 Mar 2025 10:17:10 -0400
Message-ID: <20250311141711.1911564-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311141711.1911564-1-alexander.deucher@amd.com>
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ebcba0-dea8-45b0-ca49-08dd60a774ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFMvd0tWMjNZU1pUNEhPSUVkRXdJR051RXJJdUZGZEhldi9RUk9oOU0xb3Zq?=
 =?utf-8?B?L05qSCs0YnZqN2N3cWozU3J0QUY2dVJGYzgxS2Rpc2hPcE9PYnV4VzdSVVBC?=
 =?utf-8?B?MGlpV3JRMGw3RmtZMFpNVnlJQXVkY1hyak1qVGs3a2ozUnJrYm1aQWNlTGZw?=
 =?utf-8?B?QzVWSXNUZkRXVmM4VFYvbE9ZcjhnaGl5aUpqRll0bFJXR0xaSjdlSHFkVmNQ?=
 =?utf-8?B?ZWR5N0I1eUt1V1B3UEd3UHZ2WSt6ekhzNng2YkV1Q2IzbG5WR0dyUk1oQ01W?=
 =?utf-8?B?OEczUURUYmJOekNXZVJmb1BtWFowSm5NYzNVZi9EajF1aXJ5UGdCMzlqK3M0?=
 =?utf-8?B?UThLVGJlVHhmSXpDQW1OdHJYOHlnY0Q2ajZnemNRRGE4V1JjdkU3TENPd011?=
 =?utf-8?B?QlA5bjl0R3dlbTBuOXdoNWpqT3p2V1BBL3B5U2lxT3V6S1lsTXFlTHRNeTc1?=
 =?utf-8?B?VlgwV2o2S21qSXNUMGhrOUthTkF5aUVOUFZDbkNYd3haMFBlNUhRWnlDaXRY?=
 =?utf-8?B?L3gzR21KMVhSWitIRVNSUUdsNnBKTHNrYVZwRzUxcVZZNmZEM1RmMUNIRFpp?=
 =?utf-8?B?RWZBRzkvSjlIMFFPUFdnSXhEMGJLajRMSVVOMENSZE1aVFc1Wk4zRGlYbThl?=
 =?utf-8?B?aHNVT1JWMXZKNDNic0RMTGVkY2hQWmJ6cmd3OWhLVXNnbEtLK1FtT1RxeFFN?=
 =?utf-8?B?R05zaHhoc2QzdHMxdUFWQ0NMUUx0U1hnekp3Wm9SQXBpM0p6SUdpdzU0c1Zi?=
 =?utf-8?B?Snk1SVorSkszZWN1djZLNlZ0SmtveHhNRHNCNEhQaE90MGhheVpDa1VvMU5D?=
 =?utf-8?B?U2gxZ0tIYmNJNE9USnlSVStrS0NZSC9mYjQ3QmFObFpzbDBzWkhjN3V6Rkdz?=
 =?utf-8?B?OVBtQjhIOGZ4blVvOFd0SERmMVdBSEUzeUhaVFdSS1RCSnJWaXhoOFVLQU81?=
 =?utf-8?B?cEp3WFpubnhvVldxMHNPUDRDblhtZXM4cUIwSis2WHZlTEYxckFqNVhaLzhi?=
 =?utf-8?B?Z0MzSWlJNXRCRWs4MnpJbzlnQzRGWlFrbVJjdTV5aXNYcVhwUGJCWHd6SXVs?=
 =?utf-8?B?WVdEc1FqZ0t2bzNjOENjWG1nUkR4N0k4bXk4empVNys3M3NrL0Q2Wjk4YmFR?=
 =?utf-8?B?bUVJaUFhbTRISG90NVA3dnJRcldINFd2REY4aFg1K1R4VGxlZW8vR2RtZGhI?=
 =?utf-8?B?Q2NqTVI0OTBCMmRNMlN6WFNFRmpkUTRoZjZGL25SVnNEQUQvTXRrenVZMmta?=
 =?utf-8?B?a3g5MTdWeFd4RkUwaHpURXhiNkZKYlg5UzN2ZEpIV21ZY1ZuTE5zSzhyRkdk?=
 =?utf-8?B?ZnArMUJoQzdraUZuRDJIai9SMGU5anlHWndZNTVLMzZ2TTU3eUJwUHRGTkJI?=
 =?utf-8?B?M2phOGxZTmM2eEk4RDIxUkY0VWRtWVArMzBMcWFLeEJydEFXL2I0b1dPR24r?=
 =?utf-8?B?V2VSeFhtQ2pjWGV1MHdjejBEanZqQmdMZHV3RXNWTXFxRW96blBaeElHRUt1?=
 =?utf-8?B?R0pXQUZmQlkwT2N3SXZ0RTd2UUE3MEV2U2E5NUNOeHpMamtRSTBiZjd3UXBQ?=
 =?utf-8?B?VThOU0FpSmZuMzdPeEFLRy9ZSUdzTHptUUhDNzRvZy9ya1Yvb2hpS0hTV2R2?=
 =?utf-8?B?TGlheW1DWDZCQS9sS0V6K1RobTUyM1p6ZlRTYnljS1RUZ3d5ZVU3YlBjaXp1?=
 =?utf-8?B?UTVSQXhqS21Udlk1VloxUEQrN1dTWjZCbUVmZ1diQzNiTG9HNlh6TmloaGRD?=
 =?utf-8?B?STZOZ1dyWmFSZDRES0krK0g1TWs3dExxVUZHNXdZS2xkUFplSXMyRUdjb2RP?=
 =?utf-8?B?NmhLY0dnUWJrTCtEOWxMa05wYlFCQ3hKKzFPcjZFOVRmZjhLY1B1ZGpDZW1i?=
 =?utf-8?B?WmZuMFlSbEdCYmFBT05aTTFHZy9laWRReFl3QUxITHJ5bVU5UXkxUzN3MXBJ?=
 =?utf-8?B?Z3lOTlU2RnJHQ0ROMS9XZGZqUWNBZjNMT2ZSYzZpVW84WWtnRVg1M0l0ZVB5?=
 =?utf-8?Q?bzwtSB64RJjoK6LqZOhEMDlYnJhvJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:17:29.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ebcba0-dea8-45b0-ca49-08dd60a774ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
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

Only increment the power profile on the first submission.
Since the decrement may end up being pushed out as new
submissions come in, we only need to increment it once.

Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling”)
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8d8b39e6d197a..1954e276799bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -451,17 +451,23 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
+	unsigned int fences = 0, i;
 	int r = 0;
 
-	atomic_inc(&vcn_inst->total_submission_cnt);
+	for (i = 0; i < vcn_inst->num_enc_rings; ++i)
+		fences += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[i]);
+	fences += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
 
-	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
+	if (!cancel_delayed_work_sync(&vcn_inst->idle_work) && !fences &&
+	    !atomic_read(&vcn_inst->total_submission_cnt)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
 	}
 
+	atomic_inc(&vcn_inst->total_submission_cnt);
+
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
 
-- 
2.48.1

