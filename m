Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F76E7718B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2025 09:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A107510E064;
	Wed,  1 Jan 2025 09:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3cj5RGsa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6776A10E064
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2025 09:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGzxN0od+P2VHg3hJ6jStXVxzgyepXuBUICMheYSuVpqxZh2UqVOsT3+Uqn1GyEa9Qg1pemHFW1XfakbZuv9bfQMto4r297f8Z/SswHS4IKwAuR5Kad2f9S5hjuu//BbaMGopFCkixYHVpARGdDV/4j6QC4dIaPovWEukAmq9VKUvoBREmtxyVJms1KM8FEbAPw4rmU9B2MgiUh0rEb0YC5Hf0xitB/Jzp37u1Q8uz/zM907m1eciEPv+/+yCAfGealkIoLAV3syMp6twH9lIiOE+X6LXjQ3hvsSAKdgei8PKMumAFqcu6RR5+P1xQ7080YlKjXp3LUyR1Gs1ZTH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJWIVNYLhrZGV6qb6hJxVP7tMKaHrIAwyuzDy76ymXQ=;
 b=vpi5/2OcL47aBq82czeNhNbjC1dHKF0DeM/9HSwQQBtKiMW0kDUdqK3HFCAr1+OXBzt3LHYdf3y3XAcDZI105wBLea2/16S63AQI216cNd4DlwVxVtuHyQLk/durY0doucIMP/cPQIBMtd5SIst5/BEdcbssKtSX6QCcaQ/RJX1lO00wo3+58oApgdD11tDPdPHPrA6gfPoAv3HqmQhS3RVhJWHInoqcMjOwwaP8firUfGh4r+OquQh+Fv+qfKjs987wSI8UQCBuwsT8VB9BfRSsRuzKzPM71IROXDQCq/uMpAnAQjrJnb1aZ6SitFL9nocLlnKN7aD50IE/ojHl5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJWIVNYLhrZGV6qb6hJxVP7tMKaHrIAwyuzDy76ymXQ=;
 b=3cj5RGsaQTekGGqXl9qD90o60qZzRNpKYZ08nbvrOT/GIqASLdbuc7PgBVXoMIrZrw+ccR6eGilyBOYWOOckKutnZKaBfziNXrn7CZJ8mwTtj/Omhsg+ZkMTUuMR6+4u+kadxwdWr+3SXyz8ZqWh2CoKvNnGNSFlYzjdWXMPqvY=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Wed, 1 Jan
 2025 09:58:19 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::51) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Wed,
 1 Jan 2025 09:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Wed, 1 Jan 2025 09:58:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Jan
 2025 03:58:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Add handler for SDMA context empty
Date: Wed, 1 Jan 2025 15:27:58 +0530
Message-ID: <20250101095758.847057-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: f028e657-7e48-4e8e-e0f7-08dd2a4ad1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4PpX8w0UVIBCmMO54TuEZQlHWbFp6bcjj7bOB1cJv/3tdxU+Lq1R6u0aPFLI?=
 =?us-ascii?Q?k/KckoIpyN7TN9aD+bnOLIHXBSoGcBYCUkr6HIz0ayPZAvhvqz7SdP90sWb3?=
 =?us-ascii?Q?vmAvZWCmMxUHYkjMj3O6zrHvs0WL3s0pgYRFztD6CB5cxUUMVip0sj9lz96J?=
 =?us-ascii?Q?q16xjpgBTm1LWKAVyOGO3ujBOJmNbHsNhw7zvWLw+2LYJ/Cd2MIk6qePRc/g?=
 =?us-ascii?Q?TgV0CQASverTpWQp0Bz1+a8uKLvPH1RAvQ2VRj3SXJQgWBtNeD9sEEmDiY9O?=
 =?us-ascii?Q?SVX8k4RoiYEWcFkkOZVbenQ0U0TgTwiGCkGjMz4UjLcflmYC/aoMMCQM07ru?=
 =?us-ascii?Q?ntSH4gPtAoSqECQfF6r7WIex46zOqVnFF6cbg+WfWH998JWhl2mvBSTlzAMW?=
 =?us-ascii?Q?fVN02ZGGan6rOgBc0wBWpFDw1rrs7rG+/O9r8jh1ZXavL3Jl92PKFuSFchJG?=
 =?us-ascii?Q?E7KN8EdIDJqWwSOdn6mbeQGEXSUXv2eZLM7vHxVg3VOyXF9b4sIh/PeSmf/k?=
 =?us-ascii?Q?RqR2C0n5x1bKrxNvCHYEZm4UzFPiaIsuhdVMQDIhZtM/4DdK06WKk5OO020i?=
 =?us-ascii?Q?+bgNIqUYONKd6kjxbT1rGO5rEWNNlFKQYWxMVQSd7ESXA0xrZZh3VeFz0CTY?=
 =?us-ascii?Q?OzbD1ZCwsPjOrC/2LCQRMEjnJrHNlOGWxH0LhqEc958E0CPcP9ZF2EKhMuaE?=
 =?us-ascii?Q?vEtzYQuGRF7VpUGgLvpllxtPkTE1WD/YlSYGZxIYHOzc1/ouhCHjtQwLbvmW?=
 =?us-ascii?Q?+Hd+dOBFp5XaH88vh7mon6NhKpqwK38HlICLNH+VGVdf2akFMLg9d9IrIzxE?=
 =?us-ascii?Q?7w+s0gFOVG0A3AL7m0d+ufcozhPR5JqzIuJbj5dlV9bAwZ3/mku4+6TLAZNf?=
 =?us-ascii?Q?9mv6fX5qEkmDF1jmGyX1uL8aVUwI7Mrs7m+XF1EB4IwSdPeJBiz7hMqruDhj?=
 =?us-ascii?Q?kpThzuG5rv7j923V5rxm4vvo/1h3hkj1kB4r/LH4NIkE2GtM8UVjn61vaVQM?=
 =?us-ascii?Q?aDgk1EwH6gLh91tqEc1r8TXgzTHEXzY1M4It2Sk6FrgDkfSCVXX+gtyht46v?=
 =?us-ascii?Q?6XmemrDzvd/Rq/fonzjqT18th8CCkBNpv9hrW6ddDKNqyZntJCmCb8wkTBiM?=
 =?us-ascii?Q?JkrSaltcClQfkLI9FOGgzdz1Ea7Gu3d+/nEgqY8iaYMUXi+sLVyYwXu2BMJf?=
 =?us-ascii?Q?MgrVSVyo6KKvKu1L6D7eVzSQ00baW0ZvWAXLmvrEvqdwi333hjUZ5PLY3rdd?=
 =?us-ascii?Q?2q7wOCNEgH/7xsd9zarQjDOAEyBMD4csCUIkwtOwPCnszj7cXg9sLZ8D9yrC?=
 =?us-ascii?Q?PpKeuT3SITI0YdvEHToeBr1QKTJ64pwS0sXKLpEDnNwHn1o5tTatqoLhbmnW?=
 =?us-ascii?Q?3gMZT8wNslQIcyWJXaku8looWnOuCqY44H9iizaES4SiHUuVBTtsHTkQ0a8j?=
 =?us-ascii?Q?Skld06/cQ8sQUT8FUFNkyFLlC+v2PccmE00FdkmlyqYMa0+8xCv9zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 09:58:19.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f028e657-7e48-4e8e-e0f7-08dd2a4ad1dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373
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

Context empty interrupt is enabled for SDMA 4.4.2. Add a handler for
context empty interrupt so that it is disposed of fast, and not
propagated to KFD layer.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2db58b5812a8..5f60736051d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -107,6 +107,7 @@ struct amdgpu_sdma {
 	struct amdgpu_irq_src	doorbell_invalid_irq;
 	struct amdgpu_irq_src	pool_timeout_irq;
 	struct amdgpu_irq_src	srbm_write_irq;
+	struct amdgpu_irq_src	ctxt_empty_irq;
 
 	int			num_instances;
 	uint32_t 		sdma_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 56507ae919b0..5f1c6ae7202c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1406,6 +1406,12 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 				      &adev->sdma.srbm_write_irq);
 		if (r)
 			return r;
+
+		r = amdgpu_irq_add_id(adev, sdma_v4_4_2_seq_to_irq_id(i),
+				      SDMA0_4_0__SRCID__SDMA_CTXEMPTY,
+				      &adev->sdma.ctxt_empty_irq);
+		if (r)
+			return r;
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -1814,6 +1820,16 @@ static int sdma_v4_4_2_process_srbm_write_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int sdma_v4_4_2_process_ctxt_empty_irq(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      struct amdgpu_iv_entry *entry)
+{
+	/* There is nothing useful to be done here, only kept for debug */
+	dev_dbg_ratelimited(adev->dev, "SDMA context empty interrupt");
+	sdma_v4_4_2_print_iv_entry(adev, entry);
+	return 0;
+}
+
 static void sdma_v4_4_2_inst_update_medium_grain_light_sleep(
 	struct amdgpu_device *adev, bool enable, uint32_t inst_mask)
 {
@@ -2096,6 +2112,10 @@ static const struct amdgpu_irq_src_funcs sdma_v4_4_2_srbm_write_irq_funcs = {
 	.process = sdma_v4_4_2_process_srbm_write_irq,
 };
 
+static const struct amdgpu_irq_src_funcs sdma_v4_4_2_ctxt_empty_irq_funcs = {
+	.process = sdma_v4_4_2_process_ctxt_empty_irq,
+};
+
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->sdma.trap_irq.num_types = adev->sdma.num_instances;
@@ -2104,6 +2124,7 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev)
 	adev->sdma.doorbell_invalid_irq.num_types = adev->sdma.num_instances;
 	adev->sdma.pool_timeout_irq.num_types = adev->sdma.num_instances;
 	adev->sdma.srbm_write_irq.num_types = adev->sdma.num_instances;
+	adev->sdma.ctxt_empty_irq.num_types = adev->sdma.num_instances;
 
 	adev->sdma.trap_irq.funcs = &sdma_v4_4_2_trap_irq_funcs;
 	adev->sdma.illegal_inst_irq.funcs = &sdma_v4_4_2_illegal_inst_irq_funcs;
@@ -2112,6 +2133,7 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev)
 	adev->sdma.doorbell_invalid_irq.funcs = &sdma_v4_4_2_doorbell_invalid_irq_funcs;
 	adev->sdma.pool_timeout_irq.funcs = &sdma_v4_4_2_pool_timeout_irq_funcs;
 	adev->sdma.srbm_write_irq.funcs = &sdma_v4_4_2_srbm_write_irq_funcs;
+	adev->sdma.ctxt_empty_irq.funcs = &sdma_v4_4_2_ctxt_empty_irq_funcs;
 }
 
 /**
-- 
2.25.1

