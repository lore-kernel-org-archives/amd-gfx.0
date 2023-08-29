Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CD4C71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 21:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF5E10E08A;
	Tue, 29 Aug 2023 21:07:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A5710E08A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 21:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpAixW+JRHV5eexf8rv0o2OcIY4/XwhwZ1N7yGPYLT7Y0vyJwf8yu8vYJCwIcndW9OWlwWnQIRP4ieVwaRGtvwB+oE9t/vnX3B+3+Zg+hwfYhqwKG4Tub5Ml2bPaT3OikNx6xp0DhP6cvSB/MW5sflkhuSP4jsAGXHKyoZJNasC+wobjHFg8a7oNdvd26XetQP3FtcCW37hyhL5NKTqAjK8VOK/zbuRv9d78JQ/ncrcpoviRqq3Nx6XOuZomEj0s81YGYrZYJ8GStfSuQcTXfsmZXEHktAJhur8zy4Rj4zs+YXTqHBnLfldJE+b1K0G6V/fukPUYXqorogOUU/ytZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WBmiGHG5X8nCl3bOp8JnTF9F7dTQwqtVTpEU9H13Hk=;
 b=bWVswobqgEFTdcA5DUDPWv7lZV2xhOlo0HoI/Qrtetwx4zO43trFBxiZ/HHtYhnzSR8TlE2OnSi3lGSmE5xieNh3RQLT6utxdOYm45k4uFGJplAQZe9Ev+JT5ekPxADNL8BNXkjZZr0gsrx7BgGNIH0RJqxGPnCjlv5N3Q/DmU9K4zN4XASMVqEFF6P0YtHVKLMzaCq/SrrGbqUikkHO4FrVkcOEKbvMDNVgRfTTKH/INIVg5gXixmdcQ64ygfwFINYIkkysW10A+Ayi8JKdkrCxaNqgo4+d3OZLjqsJPUPNbMpS6fsaFdLgVCAazOvoj4z/29jDcD4rHmrB7AMcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WBmiGHG5X8nCl3bOp8JnTF9F7dTQwqtVTpEU9H13Hk=;
 b=G7GB6kvxbs9KRLboNuYLrYAH/D2ch36HRRAezjIp4JQbs0AimYwmGPZpcVzmhaOQFWgUtOTQNFTRuqaiIJS4OaP/t/UW6zkKIgRYG2TnUN4bOyLVcsizar9Q/2nV1NmWIz+76ObVycnslX2gV9oysJKgQ9StB+bNXbbTb1blpcc=
Received: from DM6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:5:60::43) by
 PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 21:07:52 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::a6) by DM6PR10CA0030.outlook.office365.com
 (2603:10b6:5:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 21:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 21:07:51 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 16:07:50 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
Date: Tue, 29 Aug 2023 17:07:06 -0400
Message-ID: <20230829210706.13329-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bba7fb-7641-49cb-470a-08dba8d4018d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUDCEnoxPzxwhHTyWKBXoXL//34u3tpZkPQs//m2gwfK+zVHNwTc2vARub0nKLbK01vpj3nxXIOUjY3JFxmlWUQtcyQu1j/VfefiALfrCA9Vpaz8UCPTBBXAlWjPkMKJ7jASbIasnkyNb4DXOYR4iE7gjZp7vmuRVuiKG8nx6VwGRzpkti01cLW73mHuDBI3JLWGgSSwGJyn4VZojRP2cgJcYkihmMw87TDal6jqJQWGTbpqNwaP46XA8RcyBHFU9+yfPnOBYc95vgWg//xySXRHFv22IEaat5DxFuegT+pOkHErigxT4Hdd9V/C1ixbThte5ENC2V3AvsM5S2CqPwBXMC43WT9/LYiDbqigbsTRUmg2ubfIhvxQZ7IGvkZBVo1x2rIAjDtmXIOWVH0IYfo/HTcJ8VMlwirJjowe9WR0/H0eGuEZk0f0dyroRkC8x6r0XMU+17zAA6MUTYJqOodJG6NYGg0lmG/pXZ2SyHpO+viQPLe/DrFs6WBjvtkkGukq7Pkv63/FilENNqYOut2R2Yc/R9RMEOFf5XbRXH7wghjzyNSB6OsRlJ5O+MkneYHiGIP8qPo5kRSG4Xo2lPp53S/TybTtmbgRYgEEFMc42TtVoOG68bpU32XZ+BVdCvOAz2uk2pFRis+NRmQh3oetZjp9sff8kSEY5MCSXzWXjtofECYTZ8IrOhDXewGFd4M7Fxq1RCuK60Sw6Nr1gKhU1k/TMjdrp7cTHwNICc3/N/41uoH9fev9dA0Cp7uSOAGIwZ6SL+WHm3m/9PKMvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(356005)(81166007)(82740400003)(8936002)(6666004)(478600001)(70206006)(7696005)(54906003)(70586007)(6916009)(316002)(41300700001)(40460700003)(26005)(8676002)(36756003)(16526019)(1076003)(5660300002)(2906002)(86362001)(2616005)(40480700001)(36860700001)(83380400001)(426003)(336012)(47076005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 21:07:51.3751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bba7fb-7641-49cb-470a-08dba8d4018d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.
Add an "xcc_id" parameter to them so its uses the correct XCD's engine

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 24 +++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  4 ++--
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de074243c4d..798248677849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1136,12 +1136,14 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
 			    uint32_t inst, uint32_t reg_addr, char reg_name[],
 			    uint32_t expected_value, uint32_t mask);
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
-			    uint32_t reg, uint32_t acc_flags);
+			    uint32_t reg, uint32_t acc_flags,
+			    uint32_t xcc_id);
 u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
 				    u64 reg_addr);
 void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
-			uint32_t acc_flags);
+			uint32_t acc_flags,
+			uint32_t xcc_id);
 void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
 				     u64 reg_addr, u32 reg_data);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
@@ -1177,18 +1179,20 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
 #define AMDGPU_REGS_RLC	(1<<2)

-#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
-#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
+#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ, 0)
+#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ, 0)

-#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
-#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
+#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
+#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)

 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))

-#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)
-#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_device_rreg(adev, (reg), 0))
-#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
+#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0, 0)
+#define RREG32_XCC(reg, xcc) amdgpu_device_rreg(adev, (reg), 0, xcc)
+#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_device_rreg(adev, (reg), 0, 0))
+#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0, 0)
+#define WREG32_XCC(reg, v, xcc) amdgpu_device_wreg(adev, (reg), (v), 0, xcc)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
@@ -1236,7 +1240,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		WREG32_SMC(_Reg, tmp);                          \
 	} while (0)

-#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
+#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false, 0))

 #define REG_FIELD_SHIFT(reg, field) reg##__##field##__SHIFT
 #define REG_FIELD_MASK(reg, field) reg##__##field##_MASK
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 533daba2accb..7290e79f7584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -394,7 +394,8 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
  * Returns the 32 bit value from the offset specified.
  */
 uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
-			    uint32_t reg, uint32_t acc_flags)
+			    uint32_t reg, uint32_t acc_flags,
+			    uint32_t xcc_id)
 {
 	uint32_t ret;

@@ -405,7 +406,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			ret = amdgpu_kiq_rreg(adev, reg);
+			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
@@ -480,7 +481,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
  */
 void amdgpu_device_wreg(struct amdgpu_device *adev,
 			uint32_t reg, uint32_t v,
-			uint32_t acc_flags)
+			uint32_t acc_flags,
+			uint32_t xcc_id)
 {
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
@@ -489,7 +491,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
 		    amdgpu_sriov_runtime(adev) &&
 		    down_read_trylock(&adev->reset_domain->sem)) {
-			amdgpu_kiq_wreg(adev, reg, v);
+			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
 			up_read(&adev->reset_domain->sem);
 		} else {
 			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2382921710ec..91a652175c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -908,12 +908,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		func(adev, ras_error_status, i);
 }

-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq, reg_val_offs = 0, value = 0;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;

 	if (amdgpu_device_skip_hw_access(adev))
@@ -976,12 +976,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	return ~0;
 }

-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
 {
 	signed long r, cnt = 0;
 	unsigned long flags;
 	uint32_t seq;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;

 	BUG_ON(!ring->funcs->emit_wreg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 395c1768b9fc..0668cb6f22f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -525,8 +525,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 				  struct amdgpu_irq_src *source,
 				  struct amdgpu_iv_entry *entry);
-uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
-void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
+uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
+void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 105a1fdff2f9..7ab35268074f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1077,7 +1077,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
-		WREG32(offset, value);
+		WREG32_XCC(offset, value, xcc_id);
 }

 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
@@ -1092,5 +1092,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
-		return RREG32(offset);
+		return RREG32_XCC(offset, xcc_id);
 }
--
2.34.1

