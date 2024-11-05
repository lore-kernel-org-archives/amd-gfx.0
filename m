Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7408AD1CA3A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A2710E117;
	Tue,  5 Nov 2024 06:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ww8hE1xa";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E979110E117
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 06:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUc7/7KwpeU2lujulQBEN1nXYItOMNcbuGcaMnEvbkT9HWS6lXPXOiSdQugow9YpIfdxZf85YvOn4P3bWOdLdTs/240+4lIkLaw99uyEV/sRhCfl063kc9HUqmWw2l3VpE2JJMTBtz1dzLMAWGKwCPhsv2CyRyMPhUWys9p81GOUizkfNBnIo9fV8ENythPzTMmwtzPyi2jP6UbhuTDvlRGwj9PhYxBAM/4qZo5Z+IcxO2p6MzNuuuQUiZEt6IodFidhi27JIRizBBuxy3PVsMxt8+C0HrpQpaBShDqoPRC+0EOFwPedac1F6K3foth5Yy5g6n/OP1ssYQq/Dq+VGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sXEZzczU/tcZquXchAO4GL7r5Rt5fCwo41MF5F7xyk=;
 b=FwjUFbdmKgpKArcmBHLxiGO199RxOhA8Z+erTo/VC/8xgdzAOi1nc+g2o8UmNFdc1dUOrhteWK053bd7UL2iSGxULQNAJ/jimXBgrty/caHvV4YaJ2wI3y/jNGoYDJMkaF9nq6zGKFoX13rA0hGk4prcnz+gr+JacI6KzfR1PTL+CT4XOESVJvTfyZxlMvnNY4RZ3zDoTsDe7TlSLJACU1+LnhNmQ1NJh7UAXXuqpKS9szEuGeB6+AszhSYt0gkgLfglXArPEDJIfgo8CKAwQ27LW6SnobrJPgoPpxQt8pAcH3PdOqsP9wG8R1+IG6fwDzpzjC0KFFrvZMbJ66U/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sXEZzczU/tcZquXchAO4GL7r5Rt5fCwo41MF5F7xyk=;
 b=Ww8hE1xapvn5TvT0x7RJT3WembyyhQeY0m13g9n0yp4XEP+Zft64AsPaAME/rRbT2HigoN0acl+t0R2Y1F7lHdeQm4BZDEu8StLeTCsYHXhZJVJ0yD9wZ8AyVuqZ2bO8Mjwqs7ETd9bN7BSvyPxLjoP3h07O5vAk6CYqXVr+es0=
Received: from CH0P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::13)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Tue, 5 Nov
 2024 06:48:26 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::d9) by CH0P221CA0005.outlook.office365.com
 (2603:10b6:610:11c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Tue, 5 Nov 2024 06:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 06:48:26 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 00:48:24 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Normalize reg offsets on VCN v4.0.3
Date: Tue, 5 Nov 2024 12:18:01 +0530
Message-ID: <20241105064801.519923-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d83557-a759-4f2c-b3df-08dcfd65d98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmNkeERMMmh4a1cyeFFHMUFtbjVpZXVNL0J6TC85SUJTSDlFekc0Qzd6YlBN?=
 =?utf-8?B?WDEwQzduUlRaNFlOZlhBU3RlVDBZb2l2QWFxaERSS2JRWVk1SFRIZkxRQi93?=
 =?utf-8?B?bHh2NkNQVytQdTVZRnVNc01qYVoyMjlkWUxyOXpGNnl6RE5WSnRvMlZ6dGE2?=
 =?utf-8?B?dEdlWlNNZjk4NGZCY2tINzRJQUZqZTVQYkoyN2Y0REppMVdtUVdEcGxnYjJJ?=
 =?utf-8?B?R1V3dmJaMENNY2hoSFJCem9VMmtqa0NnUHNqVGh1bDlXdjhLV0tyVFU2a2xQ?=
 =?utf-8?B?ZWNqYUU1NERPVy9OZVhmSUtQRWpWeXpBWXlVSFgwTTdVNGY4dVJlWVZXRFlw?=
 =?utf-8?B?N091dUtpV0lHbms3Z0tXbHFyUWRCL1FnNDNxUmtVNWQwM1lGUU16SXdjaktx?=
 =?utf-8?B?eG5LeHkwWU1LN2V4QTJiZndYSS9QaTV2TUhVQndlMm4wSitQMDY3Sm9iNW1U?=
 =?utf-8?B?VHB6Y1JPL3J1ZlNEU1NKYThzZU05OGJHbEJWd3N1SGF1OExXLyt2bWpBZWxm?=
 =?utf-8?B?MEVCczBoQW1KL2tNZ29qcnZ0TEMzc2JpQ255UkxzOExTOU0vdU9PQStBLy9U?=
 =?utf-8?B?Z25VZldML2VpcWdURHR5ZmlOTHM0bEJ5V1h5bU5VbzlXd09yNHdQWktRZURo?=
 =?utf-8?B?YWdLTGFuY05icXl1eWdyTmpBbUpZdDVzOVExcGc3ZHkzdUpCWTFSWjJXVEo0?=
 =?utf-8?B?ME4wMGRjMkhUbGU2SXhxaVV3ZHVQc0NqRTFsMytkNnIyNFQvaThmRG5ocjNY?=
 =?utf-8?B?L1Y3ZVdzcW5lNjFkMGkxUE1ZWUVWZGRJTkkvczJzWjZJamI3WHFIY0IyMC9Z?=
 =?utf-8?B?UGJsaXZ1bExCZXpIV1Q1NHhuSnhCTjRmamhMM2E2bHg0M0owTmxVbzl5MmYw?=
 =?utf-8?B?b3JCa3ZMbGlscjduaC9qZ1F3N2ZWSmU2bUQweEpvUFJLazVtOHNCL2NjcGg4?=
 =?utf-8?B?TnF6bVNVZU1QRnYwYThtWXBYNUhaZkM5eXpkMUR3NDM3eEs0b0R6YWZjdG53?=
 =?utf-8?B?ZGYybHFxeklqZ3grQTdrNmZIdW94UXU3bU1ya3VNZEV5a1NQVDdkKyttYjVz?=
 =?utf-8?B?Y0VNNk9XZVplQjFQbldvOVplZ0liM1N1bjhuMjN0TklUQzJVbUpENnVkV3Vv?=
 =?utf-8?B?UW9XYkxxeUl2ZUdvK0pBcDhSZG8xVmZJMUNZdmVSNSt6SldCaFhTV0QyMzJt?=
 =?utf-8?B?M2toZkx2NGo0NWRXdlJXREl5M0NNWDUweDRiSjBvbktzVUFOTU1qekZZU0Jq?=
 =?utf-8?B?bTdZYU1pbXRKb3c2M0h0dkFNQkhUQjNBbjlKN2FFSHdhWk5WOGJ6dVpvSzZ1?=
 =?utf-8?B?VE1lWGYzSmZacXZQOHJ6dmpsQnRsZ29SaWxMN1BVVlpvSXQvd3FLMFhXMHBB?=
 =?utf-8?B?ajJWb244dGgyb2VqYnFUbm9CdHRRRXFlQ1JNZ0VFUGcwRTV5U3l4ZlBiUHY5?=
 =?utf-8?B?QWRkcGJrZTRQL2wrNXNYaU9adEFUMEJXNlFRYm80VUZ5b05Oc0dPdFRMUEIz?=
 =?utf-8?B?c0NQVkF2QnU2TUh3VCtIUVFNbnRmQW9xR2phajQ1QVROTWdpU0lqNnNlQ3Z4?=
 =?utf-8?B?c2VJNitRek5LNXVNTDBGdmZlazRXZWJFZk9rSnB1aXIvUXN0bmRUVzdzY3ZE?=
 =?utf-8?B?MWRqQytBcGppUTQzaWl4YVk2UlYxZkJqUGJSZjhPZFRGS1FzWnpVMHQ3TFhP?=
 =?utf-8?B?YzNoYkREY0NRT2NUTEZ1S1g5MjI5OGJQY2pzV01YeGFiMzBXa0ZkR212SVFz?=
 =?utf-8?B?ajdMRU9qQVUydGhSMWo0MVFHZkk4SUFzRUpWdWhabTRqbVc3cVFRcWREdVps?=
 =?utf-8?B?WE5tSU9CTUQva1RoT2xSNC9rRTczeExieVd6UHZkVzhjMWZyTC9VNENYRm02?=
 =?utf-8?B?eFJpV20rYkhXQ3FGNDRLd0RYKzhaMktRUzk3M3BCbDRib2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:48:26.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d83557-a759-4f2c-b3df-08dcfd65d98e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

Remote access to external AIDs isn't possible with VCN RRMT disabled
and it is disabled on SoCs with GC 9.4.4, so use only local offsets.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8a1db8b33ea0..cacb19c74aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -95,6 +95,13 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
 				  int inst_idx, bool indirect);
+
+static inline bool vcn_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
+{
+	return (amdgpu_sriov_vf(adev) ||
+		(amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)));
+}
+
 /**
  * vcn_v4_0_3_early_init - set function pointers
  *
@@ -1432,8 +1439,8 @@ static uint64_t vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
 static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets when required */
+	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_VCN_REG_OFFSET(reg);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WAIT);
@@ -1444,8 +1451,8 @@ static void vcn_v4_0_3_enc_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t
 
 static void vcn_v4_0_3_enc_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
-	/* For VF, only local offsets should be used */
-	if (amdgpu_sriov_vf(ring->adev))
+	/* Use normalized offsets when required */
+	if (vcn_v4_0_3_normalizn_reqd(ring->adev))
 		reg = NORMALIZE_VCN_REG_OFFSET(reg);
 
 	amdgpu_ring_write(ring, VCN_ENC_CMD_REG_WRITE);
-- 
2.25.1

