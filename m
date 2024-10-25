Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5AD116E1
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5AD10E9F1;
	Fri, 25 Oct 2024 02:36:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0lGze/Qw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ECDE10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmPamAUI/7D0S4WAtB3LH2DoRrToods5o0qxdXoY0r+8jV8uccsQ/ur4bEOb7zAyTUvxgNax1UH9vGF3QNGbN8CkBzQUbrUcc8VPaqwEcj39aHZPjcm12hkXPfHsHhX2kvC9Vh1G2TaXiIrE1irlwir2ZM65ESWMIoBKb0dUvUIYTpncPL3L3bc7el7cGTtYsEmZaBQmOdAtfnUSjxcxkySVj5AtGMJOyRo68I5IvGLMmEm7mdwmWnfGmQbydBVdPLndtLd3+4c0dW9JtLki6gcQQRXZBS0N1Y/meaW9RhEGNsyq3ooM2Yjob6yCcEViHTTlHbEX9PQdTy7K4B/gQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzPQBqR+wUbFLieRMQh67d32xJAuFraEGM87wQj9jxg=;
 b=Uywi3pJM9md+2ndxN5IPTdiB0XBHPcmc/MTc7n6AJbc0+yKunIQemsfZtcZ3lntGSF3/fV8ADmxf2EOMiQ/8wej3vF6bh+2Uc8zzOz/CFtLCwicts/GmGuUEWOE9rgEEAq+znx0qppmMc45qtKtxyQOJcIo8nAnlhBJaXD7XdMQK33NKc5/P0Gu6gO9AtR0+rlPvwuSUl/HJqkqEkQoILx5kdFrP+drlje6goPr88J2sCYp65t8BF/8hb+JNSFT+TPxJUf1AEG8so9ETAt9VxeVn/o0C+/zDGQejoTMYKkusqFr8j6FjY2+zL2Wkm/t5r0hr7IGG2WfhgO4FbuA61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzPQBqR+wUbFLieRMQh67d32xJAuFraEGM87wQj9jxg=;
 b=0lGze/Qw5qUShU4zz+k4h0kL0/UDFVbCfpR6Dh4ujGeLjtasS/XPqYRqKhm+C7mulz+CdQS/MbkfJNRiP3yBNvTtKV6N4EuTK2S31sRhODkibkmEkanuNBBLyniogJeSJtM5dfTglYwWWSEEf4Wxj7TC//jLYObBF5bHl943Q9Q=
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:14 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:15b:cafe::f4) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
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
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:13 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:10 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 13/29] drm/amdgpu: power vcn 3_0 by instance
Date: Thu, 24 Oct 2024 22:35:29 -0400
Message-ID: <20241025023545.465886-14-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d63da52-4477-405b-8aa2-08dcf49dcb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlBvQXI2dVpoMWlwbXhjdXNTYzRHU3U3c3B2TWVGOVFicVM4VlRvMDl5V3J6?=
 =?utf-8?B?QUJZYi9RREJHOEFqSVhiMXBKQllYYWdlRm1BSTZKL2ZuSlZqd3B0ekJEbEZ4?=
 =?utf-8?B?ZzUwTzFSZ0EzTmFXbDErQUlsRzIwQVZJcUVyUEpwRmROOGNjQ01zekJOTzFS?=
 =?utf-8?B?RVlKOW5xem5sYk1EYTAvNmRhU2ZBZGRJcVpFZWFiSU1uazY0OHFIRW5OdTZF?=
 =?utf-8?B?YTZXOUZKMHM2bXRZZEM2Z0d1UFdtYkVoOEJvSUhqTCtod2U1S1E1UFFkZkNY?=
 =?utf-8?B?cG5qS0NjRDFrTGZ6YkRFSWIwR3FwTy9STTgxZlcwMTR2NzRuWld2cS83TXAy?=
 =?utf-8?B?VU50WmE5Y01KWTdiMW1rTFFVdnZibDQ0TkppU0M0NisvcHNYUjlZekFhRENT?=
 =?utf-8?B?SHpnQ2ErUjNoT1gxL2VzVFVLYmJPU3B0dlNNbS9obGRmOHYwN3c0QnllOC9p?=
 =?utf-8?B?aHhhSUtLdStScGtVODJrY2RVTTVyNlc1YkhhQy9VcHJDaGgrcjUvQ25vZ2lS?=
 =?utf-8?B?ZHBZWXd6OWE1ZkRaU25tTnUvTDZYZlI1SExlejgyMFhucm1EN05SbC9VVkRo?=
 =?utf-8?B?cWZub1VpNWltZlk0Q0tpV2dnWE5kU2xjM3oweUhlZXlPTkZmb0xTVTF0NVM5?=
 =?utf-8?B?QmNzVldEQ3c5QWlKT1FPUnlXS0dHMXN1Wk1FRWlDOE03SHVwcnMwVUo5U3Va?=
 =?utf-8?B?dlI3K2lWblV0S3RqU3ZPRUU5aTJjL2RPZGN2OExXendVTENDSmJiMmdqcDFT?=
 =?utf-8?B?NXpJN0IwOEZWQzlnd05FeStjc2d5SUN2VDFQY09NQ1M4UGJwb0dISVp2clkv?=
 =?utf-8?B?aThtNUtiRWwzQzhOZmN2N29hS3FVRHV4cTlEejl6SmtsUTNtUVB0NzJDeGRh?=
 =?utf-8?B?Qk1McE40dUlDajZIYkVFMjRzL1dyNG1CMGhjd0d1MmpNQUxvLzkyZ2xpVnJ2?=
 =?utf-8?B?a3VXTW9wSjRyaUVxWUVjNXN0VG1KQ0MzSXJLcU9qb0NuQUF5WmtFMmlUVUc0?=
 =?utf-8?B?bXVkbWJkK25hR3JhZGMweGxmOWNvc3JoWXlURTNOdHBkYWpmUllNektLdkpF?=
 =?utf-8?B?UUNTWHhRY1V5d1k4OHF4ZVBJVjFHdXh1RjJ5YzROcnNIN3EvMlpha1pJbG0r?=
 =?utf-8?B?UmE2ZEdPOERRcWVOajZ6QmxnWU9iWFFYVlhxVGM0WUdCYWF5WDNIUUNKbFp2?=
 =?utf-8?B?N1NhQUVzTmUvMDBKeTlBQTRrZ3FwY3F2enZsM3ozdTlDSGwwSmxxWW1tN0tZ?=
 =?utf-8?B?eWRQNGJRWW1vNHNETVozZ1BMdGNrb1VUcmZxckpNbjV0OHZkM2M5ZXUzVGln?=
 =?utf-8?B?bGYxNXQvVEM2SFFzVFQ1VkhrUlRqZjdLNTlPZ01iS05CaW1DSFFBNDltakZN?=
 =?utf-8?B?L29LRTVack5EZjJqTVpmSFJoQ3M2dlo1NzVmOXRnd3RkdlJzcE1QU05GTnEv?=
 =?utf-8?B?NXZJeThTc1p5N25MNjU5UGE1a3ppNjFVeDE3M3U0TDhJVHYvV1lGQ25sdU4r?=
 =?utf-8?B?amNxK3p3V05JdUl3Z040Wm0wMFl4TGRxNEI5U0UyRk1QbTBlSjkvcitDdWx1?=
 =?utf-8?B?QlVNZ3hIeDl1MWZORml0a0N3QmZXSmZpZHpraEl6bHpUa2ExM09oQWk5c1c3?=
 =?utf-8?B?T2RRV3JtdEdRUysvSU1mK2NDd050YzlLVFJ3bHdpVHpRZXFma05WQ0lYU2pQ?=
 =?utf-8?B?SUk1eWZZWmh6RXVpcUVwYjl5QTB3ZmFkaW93M3h1Tk5kRGtoL3V6akNvWWlj?=
 =?utf-8?B?dW9XNVhDVUUyc2JIR2tManVsWG1WVm5nRVZtWGhmMUppQnVJSmZUN1BnVTJm?=
 =?utf-8?B?RDBRUWZWdXFPUFllRlBGWlY3UVI2RnU3anI2SElPY1JDRS9USkpNUGNpMWdU?=
 =?utf-8?B?TTBWckVxanpYaGY5NFV1bmpXU21lenBTUnRERjVDcStiMFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:13.4587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d63da52-4477-405b-8aa2-08dcf49dcb3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
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

For vcn 3_0, add ip_block for each vcn instance during discovery stage.

And only powering on/off one of the vcn instance using the
instance value stored in ip_block, instead of powering on/off all
vcn instances. Modify the existing functions to use the instance value
in ip_block, and remove the original for loop for all vcn instances.

v2: rename "i"/"j" to "inst" for instance value.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 583 +++++++++---------
 2 files changed, 289 insertions(+), 297 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6bdd4055c192..2a606e8c6930 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2336,7 +2336,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 0, 2):
-			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+				amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3b38b67f6da2..690224a5e783 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -160,7 +160,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	int i, j, r;
+	int inst = ip_block->instance, j, r;
 	int vcn_doorbell_index = 0;
 	uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_3_0);
 	uint32_t *ptr;
@@ -189,93 +189,91 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 		vcn_doorbell_index = vcn_doorbell_index << 1;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_fw_shared *fw_shared;
 
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
+
+	adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
+	adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
+	adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
+
+	adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.scratch9 = SOC15_REG_OFFSET(VCN, inst, mmUVD_SCRATCH9);
+	adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA0);
+	adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_DATA1);
+	adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN, inst, mmUVD_GPCOM_VCPU_CMD);
+	adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
+	adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN, inst, mmUVD_NO_OP);
+
+	/* VCN DEC TRAP */
+	r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[inst].irq);
+	if (r)
+		return r;
+
+	atomic_set(&adev->vcn.inst[inst].sched_score, 0);
 
-		adev->vcn.internal.context_id = mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_vmid = mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_low = mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_bar_high = mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
-		adev->vcn.internal.ib_size = mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
-		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
-
-		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.scratch9 = SOC15_REG_OFFSET(VCN, i, mmUVD_SCRATCH9);
-		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.data0 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA0);
-		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.data1 = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_DATA1);
-		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.cmd = SOC15_REG_OFFSET(VCN, i, mmUVD_GPCOM_VCPU_CMD);
-		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
-		adev->vcn.inst[i].external.nop = SOC15_REG_OFFSET(VCN, i, mmUVD_NO_OP);
-
-		/* VCN DEC TRAP */
-		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &adev->vcn.inst[i].irq);
+	ring = &adev->vcn.inst[inst].ring_dec;
+	ring->use_doorbell = true;
+	if (amdgpu_sriov_vf(adev)) {
+		ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1);
+	} else {
+		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * inst;
+	}
+	ring->vm_hub = AMDGPU_MMHUB0(0);
+	sprintf(ring->name, "vcn_dec_%d", inst);
+	r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+				 AMDGPU_RING_PRIO_DEFAULT,
+				 &adev->vcn.inst[inst].sched_score);
+	if (r)
+		return r;
+
+	for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
+		enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
+
+		/* VCN ENC TRAP */
+		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
+			j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[inst].irq);
 		if (r)
 			return r;
 
-		atomic_set(&adev->vcn.inst[i].sched_score, 0);
-
-		ring = &adev->vcn.inst[i].ring_dec;
+		ring = &adev->vcn.inst[inst].ring_enc[j];
 		ring->use_doorbell = true;
 		if (amdgpu_sriov_vf(adev)) {
-			ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1);
+			ring->doorbell_index = vcn_doorbell_index + inst * (adev->vcn.num_enc_rings + 1) + 1 + j;
 		} else {
-			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
+			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * inst;
 		}
 		ring->vm_hub = AMDGPU_MMHUB0(0);
-		sprintf(ring->name, "vcn_dec_%d", i);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-				     AMDGPU_RING_PRIO_DEFAULT,
-				     &adev->vcn.inst[i].sched_score);
+		sprintf(ring->name, "vcn_enc_%d.%d", inst, j);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
+					 hw_prio, &adev->vcn.inst[inst].sched_score);
 		if (r)
 			return r;
-
-		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
-			enum amdgpu_ring_priority_level hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
-
-			/* VCN ENC TRAP */
-			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
-			if (r)
-				return r;
-
-			ring = &adev->vcn.inst[i].ring_enc[j];
-			ring->use_doorbell = true;
-			if (amdgpu_sriov_vf(adev)) {
-				ring->doorbell_index = vcn_doorbell_index + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
-			} else {
-				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
-			}
-			ring->vm_hub = AMDGPU_MMHUB0(0);
-			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
-			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-					     hw_prio, &adev->vcn.inst[i].sched_score);
-			if (r)
-				return r;
-		}
-
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
-					     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
-					     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
-		fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
-		fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
-			fw_shared->smu_interface_info.smu_interface_type = 2;
-		else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
-			 IP_VERSION(3, 1, 1))
-			fw_shared->smu_interface_info.smu_interface_type = 1;
-
-		if (amdgpu_vcnfw_log)
-			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 	}
 
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
+					 cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
+					 cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
+	fw_shared->sw_ring.is_enabled = cpu_to_le32(DEC_SW_RING_ENABLED);
+	fw_shared->present_flag_0 |= AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(3, 1, 2))
+		fw_shared->smu_interface_info.smu_interface_type = 2;
+	else if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
+		 IP_VERSION(3, 1, 1))
+		fw_shared->smu_interface_info.smu_interface_type = 1;
+
+	if (amdgpu_vcnfw_log)
+		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
+done:
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1132,192 +1130,188 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev)
+static int vcn_v3_0_start(struct amdgpu_device *adev, unsigned int inst)
 {
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, inst);
+
+	if (adev->vcn.harvest_config & (1 << inst))
+		return 0;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v3_0_start_dpg_mode(adev, inst, adev->vcn.indirect_sram);
+		return r;
 	}
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	/* disable VCN power gating */
+	vcn_v3_0_disable_static_power_gating(adev, inst);
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
-			continue;
-		}
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
 
-		/* disable VCN power gating */
-		vcn_v3_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
-
-		/*SW clock gating */
-		vcn_v3_0_disable_clock_gating(adev, i);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v3_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/*SW clock gating */
+	vcn_v3_0_disable_clock_gating(adev, inst);
 
-		for (j = 0; j < 10; ++j) {
-			uint32_t status;
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-			for (k = 0; k < 100; ++k) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status & 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status & 2)
-				break;
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
+		~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp |
+		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
+	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v3_0_mc_resume(adev, inst);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, inst, mmUVD_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j < 10; ++j) {
+		uint32_t status;
 
+		for (k = 0; k < 100; ++k) {
+			status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
+			if (status & 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status & 2)
+			break;
 
-		if (r) {
-			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
-			return r;
-		}
+		DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", inst);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+			UVD_VCPU_CNTL__BLK_RST_MASK,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+		mdelay(10);
+		r = -1;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
+	if (r) {
+		DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", inst);
+		return r;
+	}
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK,
+		~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		ring = &adev->vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring->ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
+		~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		/* programm the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
+	ring = &adev->vcn.inst[inst].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
+	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
-		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
-		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-			lower_32_bits(ring->wptr));
-		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
-		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
-		    IP_VERSION(3, 0, 33)) {
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[0];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &adev->vcn.inst[i].ring_enc[1];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
-			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
-		}
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(VCN, inst, mmUVD_SCRATCH2, 0);
+	ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
+		lower_32_bits(ring->wptr));
+	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
+	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
+		IP_VERSION(3, 0, 33)) {
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[inst].ring_enc[0];
+		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &adev->vcn.inst[inst].ring_enc[1];
+		WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+		WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
 	return 0;
@@ -1563,79 +1557,76 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev)
+static int vcn_v3_0_stop(struct amdgpu_device *adev, unsigned int inst)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		goto done;
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+		r = vcn_v3_0_stop_dpg_mode(adev, inst);
+		goto done;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
+		UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
+		UVD_VCPU_CNTL__BLK_RST_MASK,
+		~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
+		~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v3_0_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v3_0_enable_clock_gating(adev, inst);
 
-		/* enable VCN power gating */
-		vcn_v3_0_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v3_0_enable_static_power_gating(adev, inst);
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+done:
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, inst);
 
 	return 0;
 }
@@ -2177,9 +2168,9 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev);
+		ret = vcn_v3_0_stop(adev, inst);
 	else
-		ret = vcn_v3_0_start(adev);
+		ret = vcn_v3_0_start(adev, inst);
 
 	if (!ret)
 		adev->vcn.inst[inst].cur_state = state;
-- 
2.34.1

