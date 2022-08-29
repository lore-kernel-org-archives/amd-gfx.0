Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1556BECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9164B10F2F2;
	Mon, 29 Aug 2022 14:31:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B412310F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+fJppBIgKXQUMVzxdg/v2qBXoFA71qfmBCnGTAnBvN/YuoyUqAYhuIJ0XYz46DcSaGFzc+oQzil0XXE5BKwpR8b3KpVnxXDmUmRyGx35wsXEDTtiuA95F4idMmKBOX2mWYfYcYZsL4RcxRoYGcDlT8AqeILh2sfoBPK4Ry9rGMCpeYE2gzLoHmFaBK/DsCf4j+MVQOthhnmQ5wORUcFo+LntQFJSrJhwayU+/l6NXOs2ibgmVPDrYT8GP+YgZUNvvEprR6pBOvdtbX+11cJJ/4IKFwUqBt6Vo41UgF83scr1spspcdbdDIfxA1qcv6CK+FS+pn3lhyRlJMizsYkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKeyMNGClL5Kovckq1tKlNrIadoAHEm07b5o3s0HdL0=;
 b=jUE5ydlvxXXOpV83egqG9OKbQ7gvwy+PJPxZLTXMXIK4DVd4juwpSpGso3xsflhEtLoFvhi+fhQ6Cy6b356nwoc1CalqTBC4o36Qhs+Tp082vpCWLHIg1JBMqHaH/Cu3bbiNSzcwMM27RMaO2vUbKmGTn0j02sYB3cYGLLUpIHpwV7ICiHCFAeP5/U+4tBp5TVYEQ6FZRnD7ximz5sRlll2P8cnplcp01RzhlgOVYjVgWS6nUqdybSn4XmofYrM/z9aBQyZ3AOFNftbRyJVcdFQXDowGPhDBxFPI//zZ+DcT5V3qQVGZuHhfrKuTCbCsQFcp2qRYzbvZJf5v+9JHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKeyMNGClL5Kovckq1tKlNrIadoAHEm07b5o3s0HdL0=;
 b=QKj5KK37Z7EsNmJVs2sf8A1AgD+Q0V5ucXdbpRj3JqwOxaY9Dn/CnVNdYmmz/jVsV1+steI08Res3xeGN3zynjEqpRbbLE34Ltdd4KajWvUV/U9ueDXJNwEeH/0mLWEY4ZPmDkTkNkBVZiSxwaK20vF/2wa2N0JZpYf2p3Il9LI=
Received: from MW4PR04CA0323.namprd04.prod.outlook.com (2603:10b6:303:82::28)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:31:16 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::28) by MW4PR04CA0323.outlook.office365.com
 (2603:10b6:303:82::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:16 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:10 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/29] drm/amdkfd: add debug set and clear address watch
 points operation
Date: Mon, 29 Aug 2022 10:30:20 -0400
Message-ID: <20220829143026.1509027-24-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbac8b18-0327-488a-ab97-08da89cb21ef
X-MS-TrafficTypeDiagnostic: MN0PR12MB6175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42ReOCcwhkhw363AEs2xCCRT/QCKtvbeb+Pcw2FC80aPQTvYTxjYEJ1dMXlbFT0VeCVcFr6h2fA0TzvFHj0R5OuukS+npw6qYl71a4FslYJwAb+5NXCVP+1EYzeb8VKz8YWiVv4kk+NQ6y8BJ7DKTL2euwEXgbMgNrFW4L523IKgoZ7aQJ6I1setITrSTvnOAWAsEH/p8i+kXiDrJ0Xxd46hIpGdYSh6hSr1a2obfqpRpDRSXpzWK66Q8+Gh2rW0MC/uVnkzoglo6jL4FACdk2u6WliewZkQiunNYnlbajqWWo6T0ZiEgBVzWj6PYpX1LLkirmlo4/u0w/W2cbcTeygWxE9XQk5Ja4QJEW4BP9xwyNa86nSe+tMu0rsx5tzQ/P1lw8pLlFzESB8KcR1vUvidVeqqG1VDxoIH3osZo/Gcv2ibBrqZFZBAsAavA57mbpp57dnvUcXXtcpDPVESKhOIl0k204ivCvLiEA1VW6TwgVNpsZ52oQkzlICsvkoHpowfxtqeiv+zuMZrCPtP/HSJDQJmL3465pqkOySvOcZy29qua/dx4RNiH1D7TNhhFJCWdyWltTly9io4C8pGLJJlR5AsuOB5armWl8RbFObnI7DCv+0XUDmf/haMLamWEYV9duALv9JF+T7SOI2UHNictKyDWW6dnYTFvtB2ahQ5+lN9/ypwri8KmjVyA43mhWqMGlvQKl0u48FkNy2Rc3IaFAhM53AAqvo0nVNvS8CRizkbQQ/ww2NyH8TGYjj/5nU+HRDgyQHDTaz+NsZzcJoeI3j9Cqtsa58GpcCKoA+vjSJncXmoZXG/yae0YS5x
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(46966006)(36840700001)(2906002)(26005)(44832011)(82740400003)(30864003)(6666004)(2616005)(82310400005)(7696005)(336012)(47076005)(83380400001)(186003)(1076003)(426003)(16526019)(36860700001)(40480700001)(40460700003)(54906003)(6916009)(316002)(8676002)(4326008)(70206006)(70586007)(41300700001)(81166007)(356005)(36756003)(5660300002)(8936002)(86362001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:16.5193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbac8b18-0327-488a-ab97-08da89cb21ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shader read, write and atomic memory operations can be alerted to the
debugger as an address watch exception.

Allow the debugger to pass in a watch point to a particular memory
address per device.

Note that there exists only 4 watch points per devices to date, so have
the KFD keep track of what watch points are allocated or not.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |   2 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  78 +++++++++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   8 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |   5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 128 +++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   8 ++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  24 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 130 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |   7 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 +-
 12 files changed, 405 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 91c7fdee883e..8f9b613e3152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -138,6 +138,8 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.validate_trap_override_request = kgd_aldebaran_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 10470f4a4eaf..5d6bd23a8cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -400,6 +400,8 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 3404a3d785aa..958fa3ac6d6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -880,6 +880,82 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+#define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H - mmTCP_WATCH0_ADDR_H)
+uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VMID,
+			debug_vmid);
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	/* Turning off this watch point until we set all the registers */
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			0);
+
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	/* Enable the watch point */
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id)
+{
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+
+	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	return 0;
+}
+
+
 /* kgd_gfx_v10_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -968,6 +1044,8 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v10_set_address_watch,
+	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 34c04a2bb83b..334ff16e25db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -39,6 +39,14 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
 uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
 					 uint8_t wave_launch_mode,
 					 uint32_t vmid);
+uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid);
+uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id);
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 8627c5458973..ee36ba045dcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -676,6 +676,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v10_set_wave_launch_trap_override,
-	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode
-
+	.set_wave_launch_mode = kgd_gfx_v10_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v10_set_address_watch,
+	.clear_address_watch = kgd_gfx_v10_clear_address_watch
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 33aef8bb50ff..4af8ab94568b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -810,6 +810,132 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
 	return 0;
 }
 
+#define TCP_WATCH_STRIDE (mmTCP_WATCH1_ADDR_H - mmTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_set_multi_process_address_watch(
+					struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 6);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	return watch_address_cntl;
+}
+
+uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+		return kgd_gfx_set_multi_process_address_watch(adev,
+							watch_address,
+							watch_address_mask,
+							watch_id,
+							watch_mode);
+
+	watch_address_cntl = 0;
+
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VMID,
+			debug_vmid);
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 6);
+
+	/* Turning off this watch point until we set all the registers */
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			0);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	/* Enable the watch point */
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	return 0;
+}
+
+uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id)
+{
+	uint32_t watch_address_cntl;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		return 0;
+
+	watch_address_cntl = 0;
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_cntl);
+
+	return 0;
+}
+
 /* kgd_gfx_v9_get_iq_wait_times: Returns the mmCP_IQ_WAIT_TIME1/2 values
  * The values read are:
  *     ib_offload_wait_time     -- Wait Count for Indirect Buffer Offloads.
@@ -1081,6 +1207,8 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.validate_trap_override_request = kgd_gfx_v9_validate_trap_override_request,
 	.set_wave_launch_trap_override = kgd_gfx_v9_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_gfx_v9_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 2a2ab42037e4..ba52b61b68c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -77,6 +77,14 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
 					     uint32_t trap_mask_request,
 					     uint32_t *trap_mask_prev,
 					     uint32_t kfd_dbg_trap_cntl_prev);
+uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid);
+uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id);
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 40260cecd756..7448c3e50620 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2767,6 +2767,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 	struct task_struct *thread = NULL;
 	struct pid *pid = NULL;
 	struct kfd_process *target = NULL;
+	struct kfd_process_device *pdd = NULL;
 	int r = 0;
 
 	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
@@ -2833,6 +2834,20 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto unlock_out;
 	}
 
+	if (args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ||
+			args->op == KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH) {
+		int user_gpu_id = kfd_process_get_user_gpu_id(target,
+				args->op == KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH ?
+					args->set_node_address_watch.dev_id :
+					args->clear_node_address_watch.dev_id);
+
+		pdd = kfd_process_device_data_by_id(target, user_gpu_id);
+		if (user_gpu_id == -EINVAL || !pdd) {
+			r = -ENODEV;
+			goto unlock_out;
+		}
+	}
+
 	switch (args->op) {
 	case KFD_IOC_DBG_TRAP_ENABLE:
 		if (target != p)
@@ -2886,7 +2901,16 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				(uint32_t *)args->resume_queues.queue_array_ptr);
 		break;
 	case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
+		r = kfd_dbg_trap_set_dev_address_watch(pdd,
+				args->set_node_address_watch.address,
+				args->set_node_address_watch.mask,
+				&args->set_node_address_watch.id,
+				args->set_node_address_watch.mode);
+		break;
 	case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
+		r = kfd_dbg_trap_clear_dev_address_watch(pdd,
+				args->clear_node_address_watch.id);
+		break;
 	case KFD_IOC_DBG_TRAP_SET_FLAGS:
 	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 14b606a3dff2..8195f1d9da8e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -24,6 +24,14 @@
 #include "kfd_device_queue_manager.h"
 #include <linux/file.h>
 
+/*
+ * The spinlock protects the per device dev->alloc_watch_ids for multi-process access.
+ * The per-process per-device pdd->alloc_watch_ids is protected by the debug IOCTL
+ * process mutex.
+ */
+#define MAX_WATCH_ADDRESSES	4
+static DEFINE_SPINLOCK(watch_points_lock);
+
 void debug_event_write_work_handler(struct work_struct *work)
 {
 	struct kfd_process *process;
@@ -227,6 +235,127 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 	return 0;
 }
 
+#define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
+static int kfd_dbg_get_dev_watch_id(struct kfd_process_device *pdd, int *watch_id)
+{
+	int i;
+
+	*watch_id = KFD_DEBUGGER_INVALID_WATCH_POINT_ID;
+
+	spin_lock(&watch_points_lock);
+
+	for (i = 0; i < MAX_WATCH_ADDRESSES; i++) {
+		/* device watchpoint in use so skip */
+		if ((pdd->dev->alloc_watch_ids >> i) & 0x1)
+			continue;
+
+		pdd->alloc_watch_ids |= 0x1 << i;
+		pdd->dev->alloc_watch_ids |= 0x1 << i;
+		*watch_id = i;
+		spin_unlock(&watch_points_lock);
+		return 0;
+	}
+
+	spin_unlock(&watch_points_lock);
+
+	return -ENOMEM;
+}
+
+static void kfd_dbg_clear_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+{
+	spin_lock(&watch_points_lock);
+
+	/* process owns device watch point so safe to clear */
+	if ((pdd->alloc_watch_ids >> watch_id) & 0x1) {
+		pdd->alloc_watch_ids &= ~(0x1 << watch_id);
+		pdd->dev->alloc_watch_ids &= ~(0x1 << watch_id);
+	}
+
+	spin_unlock(&watch_points_lock);
+}
+
+static bool kfd_dbg_owns_dev_watch_id(struct kfd_process_device *pdd, int watch_id)
+{
+	bool owns_watch_id = false;
+
+	spin_lock(&watch_points_lock);
+	owns_watch_id = watch_id < MAX_WATCH_ADDRESSES && ((pdd->alloc_watch_ids >> watch_id) & 0x1);
+
+	spin_unlock(&watch_points_lock);
+
+	return owns_watch_id;
+}
+
+int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
+					uint32_t watch_id)
+{
+	int r;
+
+	if (!kfd_dbg_owns_dev_watch_id(pdd, watch_id))
+		return -EINVAL;
+
+	r = debug_lock_and_unmap(pdd->dev->dqm);
+	if (r)
+		return r;
+
+	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
+							pdd->dev->adev,
+							watch_id);
+	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+	r = debug_map_and_unlock(pdd->dev->dqm);
+
+	kfd_dbg_clear_dev_watch_id(pdd, watch_id);
+
+	return r;
+}
+
+int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t *watch_id,
+					uint32_t watch_mode)
+{
+	int r = kfd_dbg_get_dev_watch_id(pdd, watch_id);
+
+	if (r)
+		return r;
+
+	r = debug_lock_and_unmap(pdd->dev->dqm);
+	if (r) {
+		kfd_dbg_clear_dev_watch_id(pdd, *watch_id);
+		return r;
+	}
+
+	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
+				pdd->dev->adev,
+				watch_address,
+				watch_address_mask,
+				*watch_id,
+				watch_mode,
+				pdd->dev->vm_info.last_vmid_kfd);
+	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+
+	r = debug_map_and_unlock(pdd->dev->dqm);
+	/* HWS is broken so no point in HW rollback but release the watchpoint anyways */
+	if (r)
+		kfd_dbg_clear_dev_watch_id(pdd, *watch_id);
+
+	return 0;
+}
+
+static void kfd_dbg_clear_process_address_watch(struct kfd_process *target)
+{
+	int i, j;
+
+	for (i = 0; i < target->n_pdds; i++)
+		for (j = 0; j < MAX_WATCH_ADDRESSES; j++)
+			kfd_dbg_trap_clear_dev_address_watch(target->pdds[i], j);
+}
+
+
 /* kfd_dbg_trap_deactivate:
  *	target: target process
  *	unwind: If this is unwinding a failed kfd_dbg_trap_enable()
@@ -241,6 +370,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 
 	if (!unwind) {
 		cancel_work_sync(&target->debug_event_workarea);
+		kfd_dbg_clear_process_address_watch(target);
 		kfd_dbg_trap_set_wave_launch_mode(target, 0);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index ca3ab1f01985..ad677e67e7eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -50,7 +50,13 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
 					uint32_t *trap_mask_supported);
 int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
 					uint8_t wave_launch_mode);
-
+int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
+					uint32_t watch_id);
+int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t *watch_id,
+					uint32_t watch_mode);
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
 					unsigned int queue_id,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 8aebe408c544..733987de595a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -395,6 +395,8 @@ int kfd_init_apertures(struct kfd_process *process)
 			pdd->gpuvm_base = pdd->gpuvm_limit = 0;
 			pdd->scratch_base = pdd->scratch_limit = 0;
 		} else {
+			int num_watchpoints = pdd->dev->device_info.num_of_watch_points;
+
 			switch (dev->adev->asic_type) {
 			case CHIP_KAVERI:
 			case CHIP_HAWAII:
@@ -424,6 +426,11 @@ int kfd_init_apertures(struct kfd_process *process)
 				pdd->qpd.cwsr_base = SVM_CWSR_BASE;
 				pdd->qpd.ib_base = SVM_IB_BASE;
 			}
+
+			process->max_watch_points =
+				!process->max_watch_points ? num_watchpoints :
+						min(num_watchpoints, process->max_watch_points);
+
 		}
 
 		dev_dbg(kfd_device, "node id %u\n", id);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a07bbecc376e..ba08d1b5153f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -348,6 +348,9 @@ struct kfd_dev {
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
+
+	/* Track per device allocated watch points */
+	uint32_t alloc_watch_ids;
 };
 
 enum kfd_mempool {
@@ -796,6 +799,7 @@ struct kfd_process_device {
 	uint32_t spi_dbg_override;
 	uint32_t spi_dbg_launch_mode;
 	uint32_t watch_points[4];
+	uint32_t alloc_watch_ids;
 
 	/*
 	 * If this process has been checkpointed before, then the user
@@ -907,6 +911,10 @@ struct kfd_process {
 	/* per-process-per device debug event fd file */
 	struct file *dbg_ev_file;
 
+	/* Allocated debug watch point IDs bitmask */
+	uint32_t allocated_debug_watch_point_bitmask;
+	int max_watch_points;
+
 	/* If the process is a kfd debugger, we need to know so we can clean
 	 * up at exit time.  If a process enables debugging on itself, it does
 	 * its own clean-up, so we don't set the flag here.  We track this by
@@ -952,7 +960,6 @@ struct kfd_process {
 	struct semaphore runtime_enable_sema;
 	bool is_runtime_retry;
 	struct kfd_runtime_info runtime_info;
-
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
-- 
2.25.1

