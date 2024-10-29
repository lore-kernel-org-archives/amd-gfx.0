Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21E2D3A67F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2956710E6D3;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qm7Sb2On";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22AB510E6B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ4OnUHuDg0P6Q9ntStGo1qreSxeoMmSlON5yenKA+UmiXzr4ORzaRcCbd5NZqEKe3fzo+60ki+KCt2AdfZFwrDHMZ7scB7F4PmYhTJPMAgjsGcCouECtwy4HlCLt4qUX5NE3gIEGcAnoJhlBjAdSREPT05nnJhzhYxsoOCICOEHwN5lQCSh0E/EQGC7DhzixOdDNYW71C13hvbjhd59WEFirhlO3JM/YO9HHgmzSu4mguDZUPiz3PeMK1kniJBrC4jc9S3XGInSSgODFxNPVdgw557zHM3HJT7SAfW4ArQnR0MgwHPyv4zy5qR4xDRC12hOQCJdlyxIsNSxpxOvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aVLhwZXWq5ViF6ABp6q8V7eq3+mcMtzaD0V9Xhr5jo=;
 b=OvHWgCj8XLsOrkLluQ7jluy4srtfoP5VxCyG4Tq66QQ86o9fHe4R0aqUoCqYtf4CmO3t7lvhlmaO4hvA7GxETjDcJvodYZNs4PVfaxumDd0lT/kJ8sE4ehFvFtFOzb38cyCmrqiQjEdzFax8HcSPkD7aMnUUnTyQ8BGLAc2R2/K9Lt7uQ2xVQfUpScKnjCI1HEEZ6uOYK+L8+nIw0V1hHdC6uaM5i9i+GlwETrsKAMk3vHcosLuyePqyfJjjw5zyixjOozIjN9wIjET0AiDc3I54hN2ZjaaJVJlqMIu68kKAbGFebfLwxtMNELeoic+PV9ElzhOf/neRvwyQAF8Giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aVLhwZXWq5ViF6ABp6q8V7eq3+mcMtzaD0V9Xhr5jo=;
 b=qm7Sb2OngXOv6Lu3a1EoDgmziY7KghHZZJt1K3igoYPdQEfDlcoLsnHXNQocG19Wd9/5t1CKaOlyGCD4vhvqjf4CSAo7mod2Wg1peRiTcWAjM3XKQAd56WkByll3b6dUjlZudVTUitPEj8/QSXXchDzr2GjZgtn5XxYYPy16JSQ=
Received: from SN6PR16CA0055.namprd16.prod.outlook.com (2603:10b6:805:ca::32)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 17:43:03 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::9c) by SN6PR16CA0055.outlook.office365.com
 (2603:10b6:805:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:03 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:57 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/29] drm/amdgpu/vcn: separate gating state by instance
Date: Tue, 29 Oct 2024 13:42:22 -0400
Message-ID: <20241029174240.682928-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 296fc507-594d-4659-6c32-08dcf84123e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NERYaVAySlJ1OHFIVlFpTGhmZGdxcDBOVjVpT0x0eTBpYVcrMTgrVFFsQ2Ur?=
 =?utf-8?B?SXE2dDFpSFUyR0t2Z1A5cXI3YWpMMCtqSENxMG81QVlqUkkvZUZXNWZXdXlh?=
 =?utf-8?B?ejJEOWhPNUtNRjRPYVlOZUdHN1cySS9MZVZDeHkwaUFRVXE3YVZtbVhiVnNE?=
 =?utf-8?B?N2cyNjV4Y1N6Q2tnbGh6SWNSQU5YeHBwaVBDVVNmR3Q5eFZndFJScU1mZVpt?=
 =?utf-8?B?VTExK2RudDd1bWw5U2xjUjVsazdrZlp1aDVZdnRlcThNeW9FczFlNDBGQk01?=
 =?utf-8?B?Y1RkQXZka3NvN0FlSnZiWHlZSGhmRnVYaDlwTzYvdy9WRXYrcm9hbEQ4d0tH?=
 =?utf-8?B?WUhPdlhQRUEza0ZQSGlteHJGSTd0YXVqcmFTNjJJTFBpTFI5aU82T3djRHJQ?=
 =?utf-8?B?WXdoeU5PWWtTbm1jRlNoTzVFKzkrWWVJenZvbHhGMEY0T1JyL25YTkpOU3pX?=
 =?utf-8?B?QUY3d0lwMDdEZXRxQldTL3I2bnhRWlZjeGdpdHo2cXFYOXpMUDJ5M3ZvNHBn?=
 =?utf-8?B?bGJORDZtSzNsVFVnU1NaTTdNRHJkeUpySWxlUWE5OTVvcURLSWJQd1d1aU1l?=
 =?utf-8?B?V2FJV2hQcm9RcTdXcHAvTmdveUdLTDRRR0h6K1JCRS9hU3B2MEdNL0gxZ0Fw?=
 =?utf-8?B?WE9wVEkwRHlSS3hOekpmOGhiRmZzZGZ0M2p3N3d5M3dzQU5wRjVMU1FhUzVM?=
 =?utf-8?B?RWd4NkpPcW41OTZkeS9VM1Y3aTBpSTUrTnp2N21rQjdpRDVEN0lPYlA2WE9u?=
 =?utf-8?B?Zlh0K2ZBSFNxbkpubFBmdE5zVnBJVWgrMGFPMDVab2tvOVU5b0dTYUZYSXFP?=
 =?utf-8?B?VWZUSFJtblhFVnBySUlMLytXYTJ0aWthaVF4QUFEZzQ5bUdtQ3ZjazJydkhZ?=
 =?utf-8?B?cWNialVaZWZLb3VEdlU4bVU3QXJCR1NNTXBsTXJSY0xHRExia25HMHMwakZm?=
 =?utf-8?B?OTROYk02OVlhakt6MmZ0bTdOWFNIMzY5MzBsOGdpeGdGcXV3N1VRWUJqNFlE?=
 =?utf-8?B?VlhMaUJCVFJIVyt2VlYvSnBPSS9YZk10VDF3Wll3NDF1aWp2SWxrRjBGS0ZU?=
 =?utf-8?B?aFlXdG1QaHJSOW5iaUFyaWFpTytnNklDR0RKeHBkQitmUitlYlF6YVhTMEJm?=
 =?utf-8?B?UkhlNHd1LzNxVlhSRlpUSlJmNlZXL1l5Sll2dEJtajk3WTYrWlJaUEVGRVdp?=
 =?utf-8?B?UlNES1pNR1VjMFF3VTBVVTN2eWp6SkkramlmZFJDRTlrRTZRQWo5WS8zYnV6?=
 =?utf-8?B?L0lBSm01RW9rTU5KUVcwOHdoSkUvNlhwSDFyR3VCVm1nY1pZVDhMR0szVW41?=
 =?utf-8?B?dEd4NmFVbjNuL0tMdlI5UzZpb2d5aEgrcjZUdkw4OGpCRm95VVF0a0Q2eUxX?=
 =?utf-8?B?U0hrTHZSV1ZLbUpHYjVNL3hla0NoSTg4bXF0bnRZWVZuMXpiQUluQzY2cCtD?=
 =?utf-8?B?K3lERVpDeFpwUS9ETnB0WEdOSHdtencvVURKSnNiSkN4NjlidEFFK1ZZYUtn?=
 =?utf-8?B?UW1xMm9CU0t5RDNPNnBXYTdySGdmQ2dWNzYyRVNSQ1oxdnVIVG0valhHb095?=
 =?utf-8?B?aWNYdmtTUURmRjMyYVROSHhsZWw3cEl0bFVLVkJkNjRaa3ZjbVBHUkg5cWlQ?=
 =?utf-8?B?K2F3MzZsVWhsQUJlczRiOE5INktSYWVjenI0VEFab1dvazdJbnAvVDBYZnVk?=
 =?utf-8?B?aElFN2JhTGM3djFhME1iSGxtUWEwdEpvS09sbk9vc3JQWHI3UkhPSWt2YnQz?=
 =?utf-8?B?RXR0dUgycjBVS0RiUDl0MXVEeEQyZ0I1d2MzNllkU0JBRXRQMHgzTFpSMFh5?=
 =?utf-8?B?bitZWXI1OUJST1NMWG85ZWNnamFOYjhiaUIrS1NvbjZGTlgxYzFFclBLSTUy?=
 =?utf-8?B?QWpZWmJvbGUyY0wrYUdSNHBzNFc3M3pJaG51MmdUb254NWc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:03.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296fc507-594d-4659-6c32-08dcf84123e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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
index 0805936bdcaf..42c75bd8a3c9 100644
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

