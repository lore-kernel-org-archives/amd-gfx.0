Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC2CE8E9C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B876210E9D4;
	Fri, 25 Oct 2024 02:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zUQkT44Z";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3366E10E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwwOqyGeF0yFvpQciObn6LPEuhwULfUVWccGYGFGIxaFwfID/+tK4ZBDNN9EsJjc/eAlXjosO84gbfLnjiltzwgQ+vLsZCB0hOKAmjwHW7MgUEQRFkaFbWyY4q1Us31ouNcCv8yA+Q7JmzWYBuO2E/c1ttoBvSl6oncVNyCfLKR89382IVgrUzbSo4txhAos2cde8iZLlc/N9rp1AhOmiWPMEmmU/0MZEjFQ5pZmzY6pizKIWXLefH/53h0g6RauucZqKgT1fLrlvdNTgwww+jCv8787a6egoEqauaovQcaUh3ddjCGTVQ37S87w32UNsGXY+tt3YejODpIfCCcOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrQbhrKbkfbX7OSZ43hzcIXJSPcUPloE2i0q2xkctnE=;
 b=HbJlQZuEpdh8tS+h69WcSbg03Mu2cJlMEm3sMpJuZPNdM1R3m8TlteyjZG6q3mwV5okmF+yj1wh3rSgaC8wCI/h97FLBpD5uI0r2SoLumuG+bffhhzo0Jjce5Ng699NwcD4Vxlq3qXFXi3vW7l7dImDim1owZMMTMW7VikvY742mbjruWmTS7AyjIVquIYLUS//9E18JOLBEdzU/BmIsU5vAAXZC5nRYQeIYZ0f4UhE0ykPCsTbhtnXmos94zjX44F4JPHHYdzVZ2OzG92B74mIwg3L+Y4LGn145EK2C3JSKrBlrDBSoLoqacy16nqURtPQiS8gzt1xzssOSrW0YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrQbhrKbkfbX7OSZ43hzcIXJSPcUPloE2i0q2xkctnE=;
 b=zUQkT44ZIkUOUL1SI2NZf8BfqwNBw20FGytEPn3CX9Pm6bAhDmZA3+gMEESpa3aNzIVKVVn5oQVCifkJJ/cm3XODZLIW5Q56LL3cdzI3LBBDulJDbNVbESnIpWZGR5Ipd30Ad/yzYBLlzKw4muAPuxkJJyUm5GtvbfKLObFRMfg=
Received: from DM6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:5:15b::18)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:13 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::19) by DM6PR18CA0005.outlook.office365.com
 (2603:10b6:5:15b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:09 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/29] drm/amdgpu/vcn: separate gating state by instance
Date: Thu, 24 Oct 2024 22:35:27 -0400
Message-ID: <20241025023545.465886-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: df4176fd-acb0-4b21-0541-08dcf49dcad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TndqQkdnZDZGZ2lPeC9tNDVSSFFETlJUZ2htSGpPTGl6bm9iVTB2T2lsRHZ1?=
 =?utf-8?B?MllzYUhoaUdXclhXR2w4YXQ2aEhYTjNNL05oMWkweVBtZEEzWVorTzBsZlpt?=
 =?utf-8?B?QVhESUJDczMyV2h5aHl2TmlRUmdiUDNsOTJPMEJTeXV6aFJzeEFubnU0WmFS?=
 =?utf-8?B?VTJna3lYclFRdERHc21BL3g2TXB3REZEQzkxRkRNc0RzMFZmNTFvR3p2WGRR?=
 =?utf-8?B?YUdLSDlWcjV4dmlBWUxEOHhvZEdvM2RBa1BFbUlCSjNCYzA4dno3UHl3Q1Jt?=
 =?utf-8?B?cUJPSlZoRTJRZVI4WGR4bnl2VTZmdFhLSE1TakY3VDNGK0t5OUNIRDBqc2lC?=
 =?utf-8?B?OXJyZnNKR0xUTk9DUldzQnhjVUc2aDBxd0hRQjJmcmdNRVIwWmpwb2g1dDli?=
 =?utf-8?B?SnF6UWwxcDRVTE91NGFhYnY2STQ4MXR5c2MzY2ZoWjB1eEhyZlR1bDZMMlVH?=
 =?utf-8?B?L0cxYno4c0p2c3ptaUw2TUljWGVQeW56MjJsZXZRZFNmRmRXTHBObWlvZkVj?=
 =?utf-8?B?UXVkdUlVY0VKSjF6M2NnaTRwN3hwTnVJZTF4aVgxZFJOZ1lXcGJWYk1vK2Jv?=
 =?utf-8?B?cy9kbDZxZHNSV21kSUFSbHNtcXBaRkF0R0YxaytJNTBnUGhETTBIUG9LOGFw?=
 =?utf-8?B?dXF5YXNJZTQ2T0VZSXVKVVNOM1JUWUFYL1dQN1ZLYWlEc0RsU2swbmphM0M1?=
 =?utf-8?B?S094MXY4aElaTHlHQlA4S1ZoZFkwWkxyaGx0RENMdkpaRFgrcW01MDVIdUZ6?=
 =?utf-8?B?MVdHWlhrTUZXOGVPUm9paUVsYW5laHNacGlPODAwaFpkNkExUTRWdFJkSmF6?=
 =?utf-8?B?c082RVg2bXdYQWF1UENPWGdxQzdYMXdWTDcvWWlRMTJhTkt3a1BSOE0xRGlH?=
 =?utf-8?B?SzNyT1UzU24yd3crQjZjZTM5YjVHUW9kb0R0S2QxTzA0RDhTMlJvVHM4MVBL?=
 =?utf-8?B?ZWhqdGZ6c003Sm03STRFWXlUUjNtQ1NtZERrZjVuOVZjVkJENm9MQ1JGTHNN?=
 =?utf-8?B?eGNpYXB3WWs3WG9OUkd6RXhWUHpmS2duTWlYZVl3WU5XbnYxMkVsTlVaVHQ5?=
 =?utf-8?B?eisvY3pnMnROMytqYWFpZ0JxZHJ1SDR2bEVRYVhJVStLQXdjbmNMUDdFenYz?=
 =?utf-8?B?Wm5yY2FVdGVWbXVCSXpnc3RvblR2ck9neFN1MTh4bUZMc0s3ZjNxYk1pbHJK?=
 =?utf-8?B?SE1WQWh2elY4S1ZlaitwL2p4V3lDWkR0UnNmNGkyMURwejR6MmRGV2xPcFNo?=
 =?utf-8?B?bGpBQW91QmJrT1lIbnhVUXFHTnNuNldrWDg3RnZObndSQkQ2UmlQak5OUkda?=
 =?utf-8?B?MW40K05uUlc4cTk1MnhjZVZTK2tKZUdQaExuREdwVmdKaTI2cEh4cTdaNDEv?=
 =?utf-8?B?UUo1UURiTGdCcXU0ZWNLZjhZOEdQZ01YcHd4blVlRTNCSUVvQm5ISm1TKzZM?=
 =?utf-8?B?TkZITnFaeUpLelh2TXNLR0xrNFY1RDUxUXloRkptSkVJNFlHWWNlWDczWlk3?=
 =?utf-8?B?TVF5QWJoOXdERXJBLzhQRTRTanBYRW1oNkY5bDFhQ1NidXRFR0FWWG51cVZ6?=
 =?utf-8?B?U01MNys1ZkVNd2xpM2g3NlB6OXVTUlMvS0JLS0hha1ZXeXNOUUxCRXFIdnow?=
 =?utf-8?B?UVIrS00vVlUwWnNiWFVGd2NNOXJ4dEFUWDJkcnZoUFozNFJoUDBsMG9Rc1Fx?=
 =?utf-8?B?aU84NzkwTnA0NnFnYjFpWE5hMHBTYzBCTHBqQk1vOGpQUjU5V1NZK291Q1J4?=
 =?utf-8?B?N0RENzNFNVlXdW81b2hNTmtSMnlxK01VUlBnSEx5Qk5GdGRDQkFPNkJiemFh?=
 =?utf-8?B?Ni92Mjl0NGZRa2RRNnZnM2xxMmxCa01ZU1drd2x4aE9mcmtNMFhPNEZsUTFW?=
 =?utf-8?B?OWk4UGR3alFVbUZIMjBINWVjVlBWT2NtUk10a0hZU3R2VXc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:12.7868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4176fd-acb0-4b21-0541-08dcf49dcad7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

vcn gating state should now be based on instance. For example, instance 0
can be gated while instance 1 is ungated, or vice versa.

Therefore, change the cur_state to be an array, so that it can track the
gating status for each vcn instance now.

v2: remove redundant codes in v1.

v3: move cur_state from amdgpu_vcn to amdgou_vcn_inst since it's a per
instance variable.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 28 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 25 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 31 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 ++-
 10 files changed, 84 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ba58b4f07643..2b8c9b8d4494 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -298,6 +298,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_vcn_fw_shared fw_shared;
 	uint8_t			aid_id;
 	const struct firmware	*fw; /* VCN firmware */
+	enum amd_powergating_state cur_state;
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
 };
@@ -310,7 +311,6 @@ struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 5ea96c983517..c2eb187b0a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,8 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e42cfc731ad8..04edbb368903 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b518202955ca..a14b634c433c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -388,23 +388,22 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-
-		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
+	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+	    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
+		vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -1830,12 +1829,13 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if(state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1843,8 +1843,8 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	else
 		ret = vcn_v2_5_start(adev);
 
-	if(!ret)
-		adev->vcn.cur_state = state;
+	if (!ret)
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 63ddd4cca910..3b38b67f6da2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -420,20 +420,18 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
 
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
+			vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -2163,6 +2161,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2170,11 +2169,11 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2183,7 +2182,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v3_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 1a6257d324c9..87c8f1c084a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -348,24 +348,24 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
-		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
-			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
 	}
 
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
+		amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq, 0);
+
 	return 0;
 }
 
@@ -2042,6 +2042,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -2049,11 +2050,11 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -2062,7 +2063,7 @@ static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 23a2a80129bb..8e7d7318cf58 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -315,10 +315,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
+	if (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1627,6 +1628,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1634,11 +1636,11 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[inst].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1647,7 +1649,7 @@ static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_3_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e49ba5bc7fa0..9c5257f370f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -298,19 +298,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1536,9 +1535,10 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1547,7 +1547,7 @@ static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v4_0_5_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 900ca8ababc1..4ecf0aea156f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -262,19 +262,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int i;
+	int inst = ip_block->instance;
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		if (!amdgpu_sriov_vf(adev)) {
-			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-			}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (!amdgpu_sriov_vf(adev)) {
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+		    (adev->vcn.inst[inst].cur_state != AMD_PG_STATE_GATE &&
+		     RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
+			vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 		}
 	}
 
@@ -1263,9 +1262,10 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int inst = ip_block->instance;
 	int ret;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[inst].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1274,7 +1274,7 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v5_0_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6f2b8ef07a41..0dd9bcc54e95 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2048,7 +2048,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

