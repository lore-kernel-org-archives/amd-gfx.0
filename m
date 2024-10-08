Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800DECF042B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CC810E5CF;
	Tue,  8 Oct 2024 21:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v/oONAW2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AFE810E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwr+nIX0rqQrkKQiYDYyVqh9r2uJaTZbA8oL16Qq/DV5Vdm70zVygJkhY9RLkX5+BXnXYt94yeOT5C+A6i0TezfY2+0VwXV+4QVPzUtU+ZLmULbQIMx6Ahuex62dZirPt5iDtg7qZaybxPhdqasj/0OCAKd+4uyl98/kzYCXf8drsMf2DObckKU0geOESCDfdjtIJXFuetW3TUCCvKQUCO0eXlBXessO0fkujUUOv8AeNtiQPBQP3h9IGtbenRuI59ZxADpNwdHDkx7SgY/2R1DBeHTGxLyvR6b8bTFr0XrRSmFqZ3J7g69By6PnN42g072VUeHejkqWVBF6Raq43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT7jcobAkFcC/r3KlIDhp9xC8yUzLRF5jcbGDlewVvU=;
 b=RK5Os989WJiHNRNqSgrSAn+41FR0jnchfByGOj0OGf+gCsWnQ1wW8rUeipsWaF/MwuAKRiiDhCbFxw5frmd5vLcMkBECSN8pFN1lgOboY3RiOdpvoSSL3ZU1L7aDyx+y6qwyXePMMlv+DVChZM+AsKd8I4Dznv2fIaeGdZ3A2XJCIVp7RSPlx40wsTvzwSpjKPU5wifF7OZJIMiwFb5LhmuqVBxWuFaTxxmS5oshAPOSxWUGDkBhZYZcx221aV9S/I6Snq1Lqq7M411Sv6ua8erh+U0Gju0aDMSleVuQc5K/o52PdLwMSMjjm22YHLqPNFcrleOYXsPI0gquKEmNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT7jcobAkFcC/r3KlIDhp9xC8yUzLRF5jcbGDlewVvU=;
 b=v/oONAW2wk2yVU2fqaB1c5bZE4H6p7YbO8n2SqEph7Md3j0HqrS0drnx1xfi0DcvK66upe2xaG/rujwlUVEC+v60bTtjFvnh1h6Zb9nXo4tdF2UNv5XrY5aBjBnOMyWs8O8PYhJGkxKpf7+3m5Vy6YB+fK54GVGOK7IqcYZnzfA=
Received: from CH0PR03CA0413.namprd03.prod.outlook.com (2603:10b6:610:11b::11)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:16:27 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::4e) by CH0PR03CA0413.outlook.office365.com
 (2603:10b6:610:11b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:26 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:22 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 11/32] drm/amdgpu/vcn: separate gating state by instance
Date: Tue, 8 Oct 2024 17:15:32 -0400
Message-ID: <20241008211553.36264-12-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa4f295-7a95-4012-9305-08dce7de7873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rBtkkHtaG9l1529oGIVlgQg/oAPeLjAqEKtW3o6nnplIeHR61PFWIwJFOArI?=
 =?us-ascii?Q?IXO3hyagvwkCj3IhH8bLGlf719pEWGYtfCHROI8IMRTuAYifQu7olDZ6FEAZ?=
 =?us-ascii?Q?9s3HWNjKAq/eqCSffU3zWq8SIUPXkBTjdmGsy7H15GIHMUplxsrfyki9kM8a?=
 =?us-ascii?Q?2na1yQcXwBVoLH5IYagaWgpzBIthIk8JDIQMsAcY8ImXgEts1FhPvSxQaV8v?=
 =?us-ascii?Q?6ltCsZ0Sj0ZQsRbfWO+sH88o0CJUZOIOcOAUjqJdz/Vp5/KxoTyTGCi6I4SV?=
 =?us-ascii?Q?4xMfn/kaaMQbRoTwYECP7fHFpoHjTRjvDPaEb3gYtcSS7xc/hOvrNjU+ggUv?=
 =?us-ascii?Q?m9wyKyb+F0y3lQIt53Vtd7pRdXBUd6y4bLgs+F0hGit94sh22J3P47WNXCeG?=
 =?us-ascii?Q?xYFhp238b4G2Hp5w0W2IrmDHFgFTs4SQ/7VkBDYFW6mZv6fB0sZOz/M1taAx?=
 =?us-ascii?Q?64Clhrxsy9CqA0hIWtIX8c47Cpu0rXa8DgQ9zMVN1tqFIie77C6q46w7nMF5?=
 =?us-ascii?Q?CZ5eP4NlNNmWa93xF6OxwC8wRVTRdIPNxLKtl2/pE43bzuH0FhmoM142TQUr?=
 =?us-ascii?Q?SMM+l08fbDBh3ZKohYOqCYRfEX1aZfDJ0e5Cy9x+k+M2vvREShM7up1PDZWK?=
 =?us-ascii?Q?JQ2l1GY9HrJZGu7VMllawPQDh9d3qYEOOh0mGes92ZYWIu9PIPIAs9tzp5zJ?=
 =?us-ascii?Q?+PT2sALx1IIm8/SBbTDU7tWPo6iVfTlJS8MYRrL69o2roG18Ki7eWl4FA6Oc?=
 =?us-ascii?Q?OSU97pE7iZvJeG0LYl8KSnob5Z7QTcOYgLppOuyOt+V5N3osrhD+1DB8ziTZ?=
 =?us-ascii?Q?kUV3PFP4prej9ojI9mF6WUN51VOFLkLhTiH2+QIpgeVD2qQy5YGArlz1iB+M?=
 =?us-ascii?Q?dluSIbuZ/4rLdJatac3kbr/vyRGtuK9KKYbfUhl75mxbXpCK5Cp2bbv9T/69?=
 =?us-ascii?Q?gpt4LPEEXsqWPBZ1fVwc/UL18ZejOjme+OAENhgWGdZRM9h26hcvua7dtUKY?=
 =?us-ascii?Q?nxrGtEOV+MOmLoqN76WzP5k1np8vmHkYekgTaXKkTBWer5N4lC07y90KiffB?=
 =?us-ascii?Q?d1xwTdb0HNSU9o4Qm2OJLs1lTw8ajwqV5nSL8MVZYSZlhWCTMoHA1cVbk1jN?=
 =?us-ascii?Q?kG88Qi6Nk6VmgryGf1Fj/KusT9UgHE8Q6/CYXo4UHqazaQHrkrotxdgLHvz8?=
 =?us-ascii?Q?qd2IhOF/+5x3CCQ5SjzLrMYDVzmF40EwtfoYfNqNZqmWlzKOtCEaYvy++v1a?=
 =?us-ascii?Q?JcW2jVFDSFEAA/6BocT5nlJpJo3yr6XZxnGzWXd545OmZkO0adlTTxnjbPLR?=
 =?us-ascii?Q?819J1phhln74z/IgjIBi4X1aOdos/JZV1M15JYWeM+ovhx4HSDah9q3maGaF?=
 =?us-ascii?Q?W6s893U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:26.7332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa4f295-7a95-4012-9305-08dce7de7873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  9 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 29 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 25 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 31 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 24 +++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 ++-
 10 files changed, 84 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index fc2efa53f3f4..0d882ba59b22 100644
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
index 553ad1efef03..407b0b5146cd 100644
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
index 670b8b4c89f9..03eaae64c356 100644
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
index f9d34b8de874..8f9e5535429f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -388,24 +388,22 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
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
-		     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
-		}
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
 
@@ -1831,12 +1829,13 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
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
@@ -1844,8 +1843,8 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	else
 		ret = vcn_v2_5_start(adev);
 
-	if(!ret)
-		adev->vcn.cur_state = state;
+	if (!ret)
+		adev->vcn.inst[inst].cur_state = state;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 79e5adddd97c..a5648089ba05 100644
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
index 8ab02e5bcdd0..14640d9352a0 100644
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
index 323ad6e34a15..ef246bf9d15c 100644
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
index eceed8cdb3bb..f0e48e9bd839 100644
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
index 234f245e2792..8e716165cc03 100644
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
index 15310f74c483..61c700e2c47f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2034,7 +2034,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
+	for (int i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
 	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 
 	if (!smu->pm_enabled)
-- 
2.34.1

