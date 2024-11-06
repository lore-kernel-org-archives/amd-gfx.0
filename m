Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82321D36129
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 02:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F97910E645;
	Wed,  6 Nov 2024 02:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LftVmk+8";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83CC10E645
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 02:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHtpI6rRJjq1cBpAQNgAtcjDuJHWCZUEa1lqwHGcn9bsiNjJFbYNQLuWgEIt4QuqIgAdIQGFGrd130nHK8EpMAEOtqrb1JjTVSd12WNW4pF7p5Pi9C7m9TBvNGj4He04LNlcnzBYsBqeYD+gjYQfqw9Rn0Boco3Rz7NZII0swNXMiafnba9v1kjzjf8w0AeaPzvl4cCNkuQrdSzaWj9hWezi7kkQQE5HoAI0jziJkSyFE3pUVYo9MWdN3FCjlUw5mu2Tt/WxcRiS5RZ5FCncG1wVI3PGcO4xt6UqbofoK2al9WriLUMoVfxHwOiGBz0XfmBolod8OwAsNXAse23yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWVwJTLbs88lWI1G+1fR3xgzsgY1VbBp3lbyHwWTCnY=;
 b=BthOO9sON1WrnH6E944g1jbrOSVHxVKEs1jBddt+GM1PZPIfVhdKZFXnGJW24qKeXyfbWc/y6qsRpeoRq8lFyOGmMdbykFaWg560apPJK3Srxyp07hwrQt7LUeE/Rtzmuq3Hylw9vLEw+j97TN/gSq8dqH++edXjOZJ6GiBZg/QY6sXuPn8kHCXXtraQjIZJ3ZwWd6RGUz7qfZJhPO2RHFWF57Dw8DuBP2P5g8sl+K6jHcTJ4aS+i+dP27WXSGRmesBFq9bFqtEx/Ig66dv4/56mLJs8pzOu2sjX1z4Z8q2OV7P+aKtAY0m+c4G92wpORZHQ1DrwkDiIch0QAOzEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWVwJTLbs88lWI1G+1fR3xgzsgY1VbBp3lbyHwWTCnY=;
 b=LftVmk+8eu6S/b4FBfDCTD5qD9lmEYfeCJKhb5osFm0UBTcdat+8aa1Bb0toXEE8iIUi7u+fv6GBrcTgxkcZ04Jnko+tsSVgwGZbget3ckGPF6zN3ly9vfou2H9DJ1du2HRXRdkBFmbCsx5KhEKORW/40DOyluhA+bwIkD1PGvU=
Received: from CH2PR18CA0014.namprd18.prod.outlook.com (2603:10b6:610:4f::24)
 by DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 02:09:34 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::65) by CH2PR18CA0014.outlook.office365.com
 (2603:10b6:610:4f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Wed, 6 Nov 2024 02:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 02:09:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 20:09:31 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu/vcn: Fix kdoc entries for VCN clock/power
 gating functions
Date: Wed, 6 Nov 2024 07:39:18 +0530
Message-ID: <20241106020918.4086736-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 026b7a82-1313-4173-dc10-08dcfe080ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWtHZlNGSXlSamJvUENvZGI3Z0d4anZnSHF3RTUxWGxTMU9PclUzNUNCL3NM?=
 =?utf-8?B?WU1xcG5zbFV3bFVjWTBrZUZxZ3JSdEE3VjBHRkYvQUxyNTdydkhlVW1SK0pE?=
 =?utf-8?B?NG9tcDBwYzI5N3dCUHg4TWdJbFBrV0NoZGF1QXRjK1pmajhJMXBpK1I3WWRy?=
 =?utf-8?B?ZGpyaHNlcG9UcE1kUUkwY0xoSnBwZmFueHhSM0pvQlJ2eGlQNy9VRGd6aVZG?=
 =?utf-8?B?QVhqOGNpblpaZkVIMm1NQnhUb0xDMHBqektzbVFXQWpGSW41ZGg0V0YxS2Vy?=
 =?utf-8?B?bFBMVnZtWjJ6QWVtcmVmMHRsWU1sdjNHY2JkZ2xXZVhSUzdaQ3VnTmJreHMr?=
 =?utf-8?B?U205RElyUnE4YzlqeTJMMFZqdEFsY1JVYlZIUHdwMStEdUljQVFNUGtwS0tO?=
 =?utf-8?B?VndtWWw5Q1RVUUM2dTU0YTUrZ1ZLRGtXcGFqaGlKOEpvWm83eXlHL21rUEpw?=
 =?utf-8?B?dlBpeDE4dVJTVTdMSmNkbm9kbmNSZVdJb2g3UURXSTRPZnl2NW9qZmVjcmN4?=
 =?utf-8?B?K1RLNkJhSS9mcUhSdmh0a3N0NndZeUVWVXA3Y1I1YXAzeHR1UEtPcG1Eb2xI?=
 =?utf-8?B?SVJvVG1wU1N1K090VUhYRnBzMGtQSDk5MWtXNUsrZnpsQWNsc1ozNlpVd1dO?=
 =?utf-8?B?Si8yTkpITFV5RlRMN29SM3lmNEJ6YktPaU1GaWpRVVg0cGNVbGlxWUdWL3Nj?=
 =?utf-8?B?T0FMdFhldWthek9HMktmRFpaa3IvTjdPZ0p1ZllRUWNlYWhtWWRuMTZheDl6?=
 =?utf-8?B?dXc5K1lSSWRaVWxEd0ZtOWpOYlZoZVZDMGp4SEcwS1RDNnp2Nmw4Q3g5RnVI?=
 =?utf-8?B?U0dSREQrY1ZicnAzb0VWMGFVOEVXbnA3cmlHZUYxeWlVOTFuL1YrU3A0dUFn?=
 =?utf-8?B?Z01ucGJlVjdIQVJ6clRlYlFIcWpTQlRrWmErb1RnMjlDZG1zb0JqK2VJOGJI?=
 =?utf-8?B?ZC9BVmp6TE9lanBOTXNTa01USEd3VUpNMkYxbXZDK0ZzcE9FeFJka2dodzFQ?=
 =?utf-8?B?c3NZQTdoSUNWSUNsL1pkamgra3NKa0N6REp3ZVgyaldsVmFIVzlQcE1Wa1pi?=
 =?utf-8?B?cUI0WTBQNmpHWEFlQ1VORnVSaERQS0pQM3ZINzRJTE5qRE54S01uTk0yNU05?=
 =?utf-8?B?QWZiNW9HdWpWc0hrRS9PU01iczV0a1l0N2ZxWGIwR3BvLzUzWkVPaU9nRnJB?=
 =?utf-8?B?Zkg1R0Q0dXd1WlZDV3RnK040NUFqL2tEeTZ0dk02UnFFcUtTRE5IVXZxb1A4?=
 =?utf-8?B?MDBTejA0bU16MGV0a2RjOGtGZzVnUGJEU1VzR1E2c1dhUWxwOFRPdExPN0xx?=
 =?utf-8?B?TVJRWDJEQlQ0bG14RzFobXdkaDRtaGhDTWRwRDlzOGJjNjlaU29Ja3pWSTJ5?=
 =?utf-8?B?RmdyaXlVeVMzSGNPeFdWbGpZVTAweVYzanRFaldjMHdtWkdWWk9PMjdlbU5m?=
 =?utf-8?B?aGtQRmh5L3JaNC9nN1I3ZlFPNXhPaGhnRlUrdFhaejE4am9IM0xYSUtNcHRp?=
 =?utf-8?B?VDBaRzJGby9GR0N0S1I4S2d2NFZIWXpSQkFKV2o4azFYT3NPZTRhMXJVMVpJ?=
 =?utf-8?B?NUZqQmtPQWJWdEhBbTl2QUF4YjB5ZVZLeUhVMjZKdVFiaG0rb0JtUS8xZ0JD?=
 =?utf-8?B?d2p1UVRGc2lOSTJZbUFLcnVZU1VCbzNRSUwvVnptR0RZd3FIZUtmalVnWTEv?=
 =?utf-8?B?NGpQQWFHbTdjN1dQMlY5U1RLMEE1ekd2ZmJCaDlqUFVjMEYzNFU5bEN3R1RR?=
 =?utf-8?B?b2FPSXd3WklZSWxmZUt0VXFIa25ENXllbVhsZ0NuV2ZiTldJQldFMG5pYU5H?=
 =?utf-8?B?WkRScW9MQ0pSNSt5Y3lieTVyTDhjR2JXcVdpKzVQallqZkhJYlUxR2Vma0Z2?=
 =?utf-8?B?VlRpMzF1N2VXL0lRaGltWThIQUxKejIzV2ZMNlZOMzRMSGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 02:09:33.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b7a82-1313-4173-dc10-08dcfe080ec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
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

This commit corrects the descriptors for the
vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_clockgating_state and
vcn_v4_0/v4_0_3/v4_0_5/v5_0_0 _set_powergating_state functions in the
amdgpu driver.

The parameter descriptors in the comments were mismatched with the
actual function parameters. The non-existent 'handle' parameter has been
replaced with the correct 'ip_block' parameter in the comments to
accurately reflect the function signatures and to resolving the below
with gcc W=1:

drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1232: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v5_0_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c:1263: warning: Excess function parameter 'handle' description in 'vcn_v5_0_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2012: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2043: warning: Excess function parameter 'handle' description in 'vcn_v4_0_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1505: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_clockgating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_5_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c:1536: warning: Excess function parameter 'handle' description in 'vcn_v4_0_5_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Function parameter or struct member 'ip_block' not described in 'vcn_v4_0_3_set_powergating_state'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c:1629: warning: Excess function parameter 'handle' description in 'vcn_v4_0_3_set_powergating_state'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 87c8f1c084a5..385596df47aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2002,7 +2002,7 @@ static int vcn_v4_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -2033,7 +2033,7 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 7b0f350d5fca..ac0e76cbaa2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1591,7 +1591,7 @@ static int vcn_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 /* vcn_v4_0_3_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1619,7 +1619,7 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9c5257f370f2..98d0ee299c74 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1495,7 +1495,7 @@ static int vcn_v4_0_5_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_5_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1526,7 +1526,7 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 4ecf0aea156f..9cd4d70058ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1222,7 +1222,7 @@ static int vcn_v5_0_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v5_0_0_set_clockgating_state - set VCN block clockgating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: clock gating state
  *
  * Set VCN block clockgating state
@@ -1253,7 +1253,7 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
- * @handle: amdgpu_device pointer
+ * @ip_block: amdgpu_ip_block pointer
  * @state: power gating state
  *
  * Set VCN block powergating state
-- 
2.34.1

