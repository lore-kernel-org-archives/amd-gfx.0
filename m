Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75617C021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259DD10E9D6;
	Thu, 13 Feb 2025 03:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="01UU+AKb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057AF10E9D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJZqb1mA4cSONcgognM0n1N8YPwFNKayyXwyUt7AAj9tAvW6KQgJK6lIQYJtPRIT9G84N2xU3N5sRjvhSZCzJws0iv7L7EezjEsweygDso7d4fTrTrFdotFKVnvMLiy4s0y/OvXKZHYHTQ7YutCvbapAbSNpHa7pKDCoge3gjOHYUUpjAfdmMR/u+gwHZzM/71W2ilanxOQjIoyT5CsIefOo2p7/vX9jW1Q6x2q6SjEWC+Pk9qs9Fkl/zUy3LQcPYJfaGh5pTzGBLN0CSUrzb0mt6yUVE4D1oz8WbBk5dlSK2nvUfpvC4nKL5+cdgSijh8PZfshPXlNb5ontbcTmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40qjl4U+JPjYwyY0zedCNj69yEdlsARKuw4xI6ho8EI=;
 b=sp0IbkRr5Jy3MwRZltzXiVveW4eMJdl6BsC0Kg3zy9Zn/7DJtIrm3UQzkwiTnu3wJREo9K0pjDqHtySvkV05rnSnRbCqwtr1r/JVp3z8ljDkeIYNuyLb8xGKUlKXAOoDvsAC4aIrjSwHEy6XRpoTYuY+MIQxIGJZVTCmmSKVHMivZVU35IPbc5uwcOF8ned4LYS5QN2EyM2+M8MOQMTCPhfkm0bGW8t+VVgFYSt+xcCywkBt4vFmGx4Nlz9HOFNqpuEk1JgXLQVrzEjz9+QXj3t6HfTm3/F9u2qJFX9ScqZkDLk9NuFAuPcxYiovy95ZgFJMuRANcJktwPAB8lmtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40qjl4U+JPjYwyY0zedCNj69yEdlsARKuw4xI6ho8EI=;
 b=01UU+AKbEXzBAHONXwbatrEOPvDk9cEgeJfijTgyptN0mCgTN8vs9L/ZDXsMIMsjkcm+9wIFKANvk/W1cqRGjalTV1ecdM+hqWI7H3YJwzEZkueZMG86Bh/WjW44kOoLxMsUjC6TewZCx2B67OiSgMB0kpRwoihdE9bkJm9FQ7c=
Received: from CH0PR03CA0314.namprd03.prod.outlook.com (2603:10b6:610:118::29)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Thu, 13 Feb
 2025 03:08:01 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::d5) by CH0PR03CA0314.outlook.office365.com
 (2603:10b6:610:118::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 03:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:08:01 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 21:06:47 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 6/6] drm/amdgpu: Add ring reset callback for JPEG2_0_0
Date: Thu, 13 Feb 2025 08:24:08 +0530
Message-ID: <20250213025408.2402828-7-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: bdad5915-4931-48c4-026b-08dd4bdba027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG5rRzcxN1FCWXhveGxmSlg2M1laQWdUVDVUSWZBRWFRMXFFWGw1b2o2Q3RK?=
 =?utf-8?B?QVM0TEFqS25nZ0tDcFEwem4zV3JVa0cwa2FZdE1qaGJSeVkvSVZYMk9sMnlH?=
 =?utf-8?B?ZVd5SnBSMjV0MFo3Z20yZUZEMEZLOXZZbFE0bGxMRk4zWDA1SE55dERZSUFE?=
 =?utf-8?B?QllyME9IUEFQcnZURlVndmhKNEJYMkNYYlVKWW9VNk5jWGg0TzBDWTZmSVRU?=
 =?utf-8?B?bUV5Zmgyak1nL0xTeEpRaVZNMGNMdDJHZ1FPaEJQWnRjUk1XQkl1QnRtem9F?=
 =?utf-8?B?S0tmOVdNM1ArSTljT1RFQUpkQjRzd1BETWJoUnJqMGpsdUU3anl6a3ZTeWs4?=
 =?utf-8?B?RW16Y2t3SUhBaGpQVmRDRExySVlwUVcvYWNGZlh2RUlXcFJkUWNheGZra1FR?=
 =?utf-8?B?ZFFLZCs3eE5vRXJzU2pBTHU4WUpVL09wWlZaZmpLRjdhaGMrWjlmeUVIVHFD?=
 =?utf-8?B?RGRPNVVSNU15V0pSOEI5YjFEZGowSklldWRaUEIrbXJzUk81M1h0bGVPbHN3?=
 =?utf-8?B?dXZ3MFU5aWhWSEYrOEI3N00xVkMwOEsrdFJFS29uT3RwTTRCNndzY2JNQ2Zi?=
 =?utf-8?B?K0VGT2ovcGZEZ1hQN3pTOS9JeXE0bmYybVlUdHJCeFJ3L3pic1VreGhHZTRZ?=
 =?utf-8?B?Y3BZVjJpcGxFelVXaTdPV0dBa2VnTE1abllmV3JOUVV0WTJEQ2tCNjd3WGRh?=
 =?utf-8?B?SHBscFFadE95RDkwbGQ5RlczcWhDOUlCN1V0a1F4RitneEtIdVF0Rkg4ZW5v?=
 =?utf-8?B?NGRNSG53R3RjWWdwMEJ2KytBbFZVVzN1OG5ublRVN2ljSmprdkpoWFRLYUFj?=
 =?utf-8?B?SlZOYnhuT05tL1lIWVVENHByNmkwSlJtK2VUVTVINjl3TVAweUJJbmpVazh4?=
 =?utf-8?B?YUMzdEFMYjdla256UVFObm5jNGNSL1k3QS80cXRzTktDZ3ZyYmRrbVRrNmxL?=
 =?utf-8?B?QS8rYjhIR1RLVEk2ei9nTFpmMXdISGk2cm5sNzBrZzJZNnM2ZlQ1NGZPL0N3?=
 =?utf-8?B?RnFMVklRenU3djM1M1R0QU9KNGEzUzVjTHJNdGFFZi8ycERad2VLcnZ4YVk5?=
 =?utf-8?B?RVhmdlQrSlBPWmhpa3ZBeks5K3ZJc2VXc1FONjhSQnJFSG5yVDVTb3c0ZWJq?=
 =?utf-8?B?eGNiVW9jS21XeHZ2Q0pRbFBoejNER3Z3U3Y0VC8vaWZGY21yQ2dSdG15Y09G?=
 =?utf-8?B?TFRERFBsRWNHMzBndllUMG5VS3p1cSsyOFI5MW9RdVRZdGl5cnhKTjJXU0NW?=
 =?utf-8?B?TVZIQnFhYmdaTVBRZmFVNHNkNUF4V1F2dUh1cW5XZ0hDMXk3SlUrb0p3UytC?=
 =?utf-8?B?dTdBZjY1emRtZGFJVG9xTnJUbWpZWGhRZzh2NzIxd3M1WHhpK29tVWlhQ3Bq?=
 =?utf-8?B?cjhoQUNBcUxiVnNzMHJGVS9NbWV1Tkc0Y2dxNW5mTzBUQmsvNnNnOU4wUVd5?=
 =?utf-8?B?dkxsUENJZitvT3Vucm9BVTdUblB5VHh5bE1FOWpGUnVPVVRYWm9jZXVHL0xj?=
 =?utf-8?B?UDQ5blptcXB5d1RpNStKdSttT3J1MnV6K3JMV2ZteUFseXd0cnN1K0RQejVC?=
 =?utf-8?B?SzNVS2RtYWFhQjBTZXR1WElHUlhmMURlV2daRWtidUUyaHoreUNQaHBlM3Ns?=
 =?utf-8?B?eVVYdnFndlJTM2g3Vzh6ODBNTEM3OWdHcXZPMXpZL0UrYkUwVWhkWmNtdGpk?=
 =?utf-8?B?MW1NWWJNTFh2WTF4TGVadGh3SlJNK3pWMzVzM0xJTkdZSjRHN29zbklISHUz?=
 =?utf-8?B?WitTSVUyN3YwRCtXeXI2aGZnNmYxekhZenZDQ3Q3Y2k0dDFDckh3ZGhCT3Q3?=
 =?utf-8?B?VmtrWFdzN3oveWVPNjA1c3lMU1diNUI1ckptN2pOSXFUN0Nybnl6RDlnSVdI?=
 =?utf-8?B?OVcrTTZ6bk4xb0lMNEJ2NjZGaVREaE04YWVMK2JWRnROVnFtWThHcFFkRThM?=
 =?utf-8?B?ZHdjRnpjTTZseUNpdDFJOVZJMTYzTzVzdGJDZFl2UWhzMUI4NHE3SDBBcjRY?=
 =?utf-8?Q?3CDIuVpWE+WR+yymoVEQkvyzvjmtwQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:08:01.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdad5915-4931-48c4-026b-08dd4bdba027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

Add ring reset function callback for JPEG2_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 8c61081746c6..75843a0e3bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -118,7 +118,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	return 0;
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+
+	return r;
 }
 
 /**
@@ -137,6 +140,8 @@ static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -759,6 +764,13 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	jpeg_v2_0_stop(ring->adev);
+	jpeg_v2_0_start(ring->adev);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.name = "jpeg_v2_0",
 	.early_init = jpeg_v2_0_early_init,
@@ -804,6 +816,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v2_0_ring_reset,
 };
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

