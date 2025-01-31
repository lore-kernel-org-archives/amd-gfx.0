Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCA0C0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E1E10E201;
	Fri, 31 Jan 2025 16:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tiDcyfTH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A7F10E201
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtZfoAItu6Xn3245l/Cz+XkeZjVszn3kncznWPsTslp20texpBG2Q3DvkvR3acL1wfwUu3I4kot2q/FiFXS1Gt97EXRFbNCfpTEqUFJG+xuaxGi67V84PitkxbJUl6DF9fpuj9nIjqsPKoupA16CoKRej9I3y/OqaLqp5W/XCOsqiFU4rx858Au4j+3dFur2om8G3RI/XQyotdCdMKgDaLtxzfAr3GaTRAMoQivAxocKCJGmoQWbqLo1OqoI2wNG9XOqvSEZZ53KKfmoUN6hcJyybiG/RMqBvpx2cyBnf6Wd0VKDEh0Sd5PuRQHhLJ/eblq/7k2vl5a9JPcODqXfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjxTUpD6Rv0HlcSdKfHpFiRKhPK5swZEoaQX2PZ+wm4=;
 b=rfg9ErHnpOIs/2qOASlM31DY3B5OFVEbRIQun3yw5KPwmipFU2ls7s+NAL+pDaG+6g11kv2jQ+6f0TIQpuY8peMdcC2+o/eotYXBduHGcs8yn3CZwDNApHiXT7hXpXnp0f86Dev9fNkISOSTnucDdCG51bWnJqZ3DsZJDcBczG8xRg5iUPf+/05U5BN0EQayI0F28T00AJG4qeRfstHCcZVq4mgsRYFEk0ZT8Ahz9Q8ZzZMNfKa6aa1GOcIL1kEac0YvpfNBJ75y1y+FWfyxpWlRKHPawYZAbwJYJLxUUfT7y5RWCzHVv+pWe0UA8VBK1rZmi4Egv+rS04In0Yaz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjxTUpD6Rv0HlcSdKfHpFiRKhPK5swZEoaQX2PZ+wm4=;
 b=tiDcyfTHezDz2ZZ4OR7L3NYFLvH4ohy4pS+LtzaK0hqSeQfyvJE2HGpNaz4mI/wXqDyGnFzFa4BiJJiEoMVNhUq4vTGjWRoG1U+BBXOv6kZ7RpDSU3Kl9xftnzLYNrtiuagtw2+vOkG/+71+DhnETsRLs6TwBvVba7h18d/s0sI=
Received: from DS7PR03CA0138.namprd03.prod.outlook.com (2603:10b6:5:3b4::23)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Fri, 31 Jan
 2025 16:24:42 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::69) by DS7PR03CA0138.outlook.office365.com
 (2603:10b6:5:3b4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Fri,
 31 Jan 2025 16:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:24:42 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:24:40 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: Add ring reset callback for JPEG3_0_0
Date: Fri, 31 Jan 2025 21:53:18 +0530
Message-ID: <20250131162321.563314-5-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf82d02-f7c7-4c05-d7ac-08dd4213c474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTZCVDJaOXhQYm03eVpXYllBYjBGdXNzR2o0RTlxQklLcWMraGhoV2NvbUNy?=
 =?utf-8?B?dmpkL21wcmx2Wjl3Z08rM0d1bWZnRGxseHJVd1NaM3J1OXdOaFRoTU9IY1Za?=
 =?utf-8?B?M2lFRUx5aUhITE5hTERYSiszd2VtSThmN2VxUDh1OGhUcnQ3Sm4wMmJ3OEVQ?=
 =?utf-8?B?Zlo5aVJFRU9hVFBBR0ZDSHpDcExybnZpM1QxdkdLSnArYnQvUncyVG40RFk2?=
 =?utf-8?B?N0F2ZERMRTNvcmFqQ2hORi90RlZQcmEyamNkR1lncG9UelV3b09QVzlORWJp?=
 =?utf-8?B?ZGtoMTFwZ1I5OVBwUExOMGtlNXBaWVJkdUo4d3FIWEIxRDNyZGw1V0VBeWlm?=
 =?utf-8?B?Q3V5RTNVWS8rYWYwb2Vmc25NcUhiRXR3bmxpT3ZFOTdMQVJmNmhvVFh0Snlt?=
 =?utf-8?B?WS9oWldOcTN1dlduUVh4WkQ0Snp3ekdwYWlmcFdubHZMU3p3SEQxVndRckFR?=
 =?utf-8?B?cFArdjRYUWhwYVRVbC9zODhOZm1hZTR1M0Fkd1ZsYXFUeFlhM0RneG14ZElT?=
 =?utf-8?B?Tzl0VlVLUXhRWDFZMm1iMGFGZmM5UW9HbXhNY1hxNWhhQUx4eEp6aGpSTUx1?=
 =?utf-8?B?VjIyVjFVQytGZHZLa1FSZ0xBVXdtalhNWU1KSWgwZWVxaDUyNzZIWnUvaEFU?=
 =?utf-8?B?cFF0a3JWQzI2TG05QU8waFN4NWI2ZXFqU25NRktxMWxBRWp6aGQ2WGoybkwx?=
 =?utf-8?B?ZDVLL2Nvd1RtYlNxbWZSQU1wMnQybWwvV3pTRUFvaFhpWG1nNExPS2pTN1NV?=
 =?utf-8?B?akIyRFl0TXorKzJ5eU0xbThjNkh0ckJPb1BqaUlaSUxjQjR5OVp5Z29xQjdO?=
 =?utf-8?B?MzhCS2QvTjdlaHNmWmFwQzFFRzY3TzdZQjBmdCtxbjBTMzduMUNaVG92MVJ0?=
 =?utf-8?B?UXR6cFJHUExIMVFZWCt1RDJiYldCVm8xZWNDclh4cFRFQlJTN3lMS29ZRTZL?=
 =?utf-8?B?aDdtcHJkekVZWFRjVzFESkwzc2lDVkJhOWh0NlZQZGI2TThUQkFGK2tYWVBZ?=
 =?utf-8?B?UzhvdC9tcUg0emRxTEdmTEpLSzUvcEZ5bkRkc0w3bytld1dEdmc4WmFncWRL?=
 =?utf-8?B?SVF2TWJaaGNScUlLSHZ3UTRYdElDWk43aDVPbVU2R1ZxdlNXOE9SUlJCRE1k?=
 =?utf-8?B?SUgzQnJpUG51eWNEamFIR2Rldk5EZkJXU2c0SkNBL3NGNTdIRno5WlVMUVlP?=
 =?utf-8?B?ZFo4aGZuVUMzd242cFN5UGMrbEhNTkhBazFtdmlLcTRoZXVBOVRwUmhXTjI2?=
 =?utf-8?B?UXhORDV1L2VtWk9weGNPVU5QVVJyM1R0Z1RIcm82aDlhMElyWkw1aDNjLzVn?=
 =?utf-8?B?bzdoenJjbWlqek0rd0U2NDVwZ0E5TUk5NmZpMGpZWFExZVgwZHBpUGRLUnZV?=
 =?utf-8?B?VzBCdnhmMGQ1SVl4TzE2T21LZWlLeTNoQU9yTjhQODhZRUwvSllTYzlsa2pH?=
 =?utf-8?B?Sm1VSHdyVGo3MTN6anJvaWxtUTROYnVzUm14TzZVNkFCbmV3S1FKYWRmSGVk?=
 =?utf-8?B?U2tVVlRzTVJ3dnNyQVhFbHZ2MG9zQUp2YzhweWM1S25LeTI3aEwvWDlpZU1v?=
 =?utf-8?B?Q0tWV2VUekZWb0docFYxT0dNSFJYMXgrUFlhQW1KNzY0aDVhN3daWUI0WktY?=
 =?utf-8?B?ODNUdmZMRm53VitWcGI3ZDlVc2ZtNEU0RlRrL25mMWVwOEpPc2l0S1Z1RVdi?=
 =?utf-8?B?ZWdWZDhtODVUMHo1MDJpeXlmTlB2emkwYmJsQmJDK1ZkSWxLVjFWZmVEdGhm?=
 =?utf-8?B?eFlRSkNaMFlsV0ZzN2x5Y0xzMndqUmFwR05KWnJtWFlXQ0FjRW5TR00zWGUy?=
 =?utf-8?B?Nkw2eE53NVEwN1JRRUljNFZCQWJndTgrVFhxZUlQS0M0QnRnNExUN21PcnVL?=
 =?utf-8?B?aDNXNnBKbUd5c2xEcnkxUmVwMTkwVzlmUk9ucTJBZm9DZENIQm85VXMrdVAv?=
 =?utf-8?B?UUNBVng5K296QjhKRmlVa0tMcjlSdGhRQ3hsYjZucGIzSldML3g2MWIybDZv?=
 =?utf-8?Q?XA0h8IQkEwgpkYS0+VGFN3CCn8M0fI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:24:42.3188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf82d02-f7c7-4c05-d7ac-08dd4213c474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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

Add ring reset function callback for JPEG3_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a4acb7cb7ea0..16ea13aef4d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -132,6 +132,11 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_PIPE;
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -151,6 +156,8 @@ static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
+
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
@@ -550,6 +557,20 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int ret;
+
+	jpeg_v3_0_stop(ring->adev);
+	jpeg_v3_0_start(ring->adev);
+	ret = amdgpu_ring_test_helper(ring);
+	if (ret)
+		return ret;
+	dev_info(adev->dev, "Reset on %s succeeded\n", ring->sched.name);
+	return 0;
+}
+
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.name = "jpeg_v3_0",
 	.early_init = jpeg_v3_0_early_init,
@@ -595,6 +616,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v3_0_ring_reset,
 };
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

