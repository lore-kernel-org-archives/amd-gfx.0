Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FABD2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7454910E563;
	Tue, 20 Jan 2026 07:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UJXY8HFU";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34FA10E562
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXn/RuGfH4eUvSbpGBnsDTppgX3a36fTcINWYdK9PKwnpr8ANfS7Cap8R7X49UuEAx10WI23kyv5TL9FFlU43NkAtY8rbKCF7x9J3ehJxhi/CB9U//mExx1OXiXo8hgIOEavDFzZsBvEY42ZBQ7i/JMDRbZtiX1zFxMnXa8S5a67VJdZL4lmge1XJ3gsWCyvoZvrHY2U/QjNGJwHQmXClSoCEqoP1wlO1F8+/n7659IVcAvQWjX4tYLe7KnfRygr4EvQYIMJNNKtiD1XyJzCYW6qZEZ50T/7V0xBTqg1EMaJJzGjVownz2KAjy5J73nNm5es2i1cxCVWWcRNZKJXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC7sYLZ9F6+a+7V6FLzxGKdPFUT5pI5X3IH6N9dakNU=;
 b=OPEXh01KbtrBT65sUYfPVWLgt7PV90Dn/Ny7SdI4Qtqum5GNjwcv0O5VZyeP1eRVn/SnAobbBBaHn9C5fb62uaSMbU22Q4tJqSZgIj/MZ++4UqQ3lT+Ee+jokc6WQdUZ3VydHF3sK4fTZIkxAZEUKXRK3futTqJun6VxwXq1a7p2BLvi2gdX/VDA2RTSQIvnVuciqMyd8Csd9X69pApOaZGdlP9lk1lGHx79dxP0kv1lfjDfiIEPgtg/5pVYNrGBJ24qXHxUdJRUL24hODAZjYf2RV026KxIK/byAP5Eb/CNp5FWM9riz4cS5Naj6qFvnoxiLrkcG511IV5gWT6VRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC7sYLZ9F6+a+7V6FLzxGKdPFUT5pI5X3IH6N9dakNU=;
 b=UJXY8HFU59P/M1k0jB3Ne40KosA7QziS0t6HkKxby/JgSGgmufYqPWYqOFXTojmOfXOz4AUDwt1FUv9rr1+UuI8SLDgMSsZhH6HZRp8upzP11WM4GYHjIUixHBK8f06lKPB16n4Yh9R26bXzH/0QVehWgO1r9Txt2WTh4qCogD0=
Received: from SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 07:00:13 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::58) by SJ0PR03CA0048.outlook.office365.com
 (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:00:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 01:00:04 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 08/15] drm/amdgpu: Add pciep method to register block
Date: Tue, 20 Jan 2026 12:27:42 +0530
Message-ID: <20260120065931.1300054-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260120065931.1300054-1-lijo.lazar@amd.com>
References: <20260120065931.1300054-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: e2590725-5119-42f6-3b8f-08de57f18eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DeJyUvS8ccr1XWuGk0P+EKL1nsPWbZdUzzomhdKZEYrHeneWR37VYxidSgf5?=
 =?us-ascii?Q?BWSOprbZlZfad8sy/IB3cF6QPaJlnRjO7Tg1WBTyaKl6YPa5hka+C+2mupo7?=
 =?us-ascii?Q?AMl+fTcbwfHk5qQm5zbsj/l/JomNPUYwrKTcI3IKSR392MlnI7u1TLEuaqRg?=
 =?us-ascii?Q?vrAM/lfgYvdUI8bTmdx4UujFkSR9Sonhx8/ZaEb/YDgluXg96xlliTrIyG20?=
 =?us-ascii?Q?FvIZwWSvAaKqCgHSTdvMZIfPvb71NxhPt1J64Y0z+HKRxzIJb182O2wdoS1H?=
 =?us-ascii?Q?DhgW1koQwZOlSrkfO+4tnmF7uqb52MmxlmzsQU/wSkub5fBeTBhiwGXlk90n?=
 =?us-ascii?Q?QydHStfoiQDk8Z/bnT5os1jW42MokwomRF5HvKHOOuwp78T8VMqA9aRpJ2ku?=
 =?us-ascii?Q?oc1sjB3dW7DyVwyo/cqqGWEUfswdM7WlAohXiBoy9+u7SCtDphiX5geOSpIK?=
 =?us-ascii?Q?/sejle8VOWK3+Lu+Ue2k18q50hv4qfkhTjEwl0Pveci6r+wl+IsbAK21nMau?=
 =?us-ascii?Q?n8OAocSyYQybnj50dIDmB2mgfd0GMlFkz0cgUyL4JBmPyrSEBdyRU+JKhBz7?=
 =?us-ascii?Q?QeHVvs1LuxlvslL8dy5jPtyOop27vPe+tZSCtmqw5PMRjS0kE8bvXhckd5KV?=
 =?us-ascii?Q?4kVXrXXJKhXiR93ve4HzGnZ6Acq0zM6LoEMH51xboxzptMYnKGfW24mtAIFT?=
 =?us-ascii?Q?xADDB4Yj/S3IgC0I1A/4ngef/V9X8KVc6yAFz08vLVlwEB0+4C3tl0cVVHIG?=
 =?us-ascii?Q?78+MBexEQ7Ccs56tIHtTGjGlmTAZ/VVKrXeKPUWyHxnwErY2sBEgFaNnxWpq?=
 =?us-ascii?Q?zNwJCTIT6/Qyr4xdOUPtnA+jAxUwDTBiZlU97dN2EBnbFOYsWpn8PT6blFME?=
 =?us-ascii?Q?hh06cfSwtOXvwlLm92yZkHE/Dl3XCp5bfTup48TfWM+kOtevJo0KhX06A0zn?=
 =?us-ascii?Q?AQlff6JF1JEasb8/IAI4ebgYFQSCRRw1NR+FRmx5VKqZzmYZj766zP3SCQVB?=
 =?us-ascii?Q?ZFG1Odi1S5Ld0+P6LdXeMZe3py/mwsJMU+FZa6LrWUb/efRxcHw5h42aP4Lq?=
 =?us-ascii?Q?SrSMyvvpHsxKsrYrPTGlohxFY3uyrpPmbdBNe92wWx2AuCU+j4GeSsbrZZHG?=
 =?us-ascii?Q?B378LabO710xdvKbo4lZzN/hHCGUVEAgofpPAgNN/Se7JnSpu5udsKtjAQaQ?=
 =?us-ascii?Q?leunq9k9JvPg4ZRfTcAodA0b6hwqgyRsMSRE9BnB3w14jCtujS4za9dVSfa4?=
 =?us-ascii?Q?wThNGNOtg6EUe9ZyEBL65mPWuT90brp6crKqTSKwryKeBtJffa5Efo5HeiTR?=
 =?us-ascii?Q?D3CsboNZMeNLpG9yQphRVajzPMdhQKGWjXht+tjwpRE0xF5Vwv8neYeSqw3B?=
 =?us-ascii?Q?J0oMiaBtCRlqhevsVEQn5QJD/EvF/OFtP7xJU/qpYZgAqg9PupGgPvcrehI1?=
 =?us-ascii?Q?MzKwA10kOevCx9ncs2foXJDLhke+HClYERUA5ScQ7m5m238j+OYAQDPChTHA?=
 =?us-ascii?Q?UEiCCNZfo25lHkqnA4wGPiXsgj5C5brC5M67zUG6ho/MYJQwIBvWbl403TxB?=
 =?us-ascii?Q?a8v9zAOSuMqdgDN3wrClL6FcPgtR+JjAdYryc7A6axr4VGsV//tQh2IiUVo9?=
 =?us-ascii?Q?gyp80M7ugpK9zupwxvN6b/cijPR1OmHC3oBjDYiEa+3njzClx0ygPU6qgYi4?=
 =?us-ascii?Q?VgmtNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:00:12.8670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2590725-5119-42f6-3b8f-08de57f18eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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

Move pcie port method to register access block.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 --
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    | 21 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.h    |  9 ++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c               |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc24.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c         |  4 ++--
 9 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 29d0f9a756b3..9678fddb8ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -898,8 +898,6 @@ struct amdgpu_device {
 	spinlock_t pcie_idx_lock;
 	amdgpu_rreg_t			pcie_rreg;
 	amdgpu_wreg_t			pcie_wreg;
-	amdgpu_rreg_t			pciep_rreg;
-	amdgpu_wreg_t			pciep_wreg;
 	amdgpu_rreg_ext_t		pcie_rreg_ext;
 	amdgpu_wreg_ext_t		pcie_wreg_ext;
 	amdgpu_rreg64_t			pcie_rreg64;
@@ -1294,8 +1292,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define WREG32_XCC(reg, v, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), 0, inst)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
 #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
-#define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
-#define WREG32_PCIE_PORT(reg, v) adev->pciep_wreg(adev, (reg), (v))
+#define RREG32_PCIE_PORT(reg) amdgpu_reg_pciep_rd32(adev, (reg))
+#define WREG32_PCIE_PORT(reg, v) amdgpu_reg_pciep_wr32(adev, (reg), (v))
 #define RREG32_PCIE_EXT(reg) adev->pcie_rreg_ext(adev, (reg))
 #define WREG32_PCIE_EXT(reg, v) adev->pcie_wreg_ext(adev, (reg), (v))
 #define RREG64_PCIE(reg) adev->pcie_rreg64(adev, (reg))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 247565abcf67..88e2cc27dbea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3813,8 +3813,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	adev->pcie_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg_ext = &amdgpu_invalid_rreg_ext;
 	adev->pcie_wreg_ext = &amdgpu_invalid_wreg_ext;
-	adev->pciep_rreg = &amdgpu_invalid_rreg;
-	adev->pciep_wreg = &amdgpu_invalid_wreg;
 	adev->pcie_rreg64 = &amdgpu_invalid_rreg64;
 	adev->pcie_wreg64 = &amdgpu_invalid_wreg64;
 	adev->pcie_rreg64_ext = &amdgpu_invalid_rreg64_ext;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
index 563b155b15c6..175fdfc5229b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.c
@@ -58,6 +58,9 @@ void amdgpu_reg_access_init(struct amdgpu_device *adev)
 	spin_lock_init(&adev->reg.audio_endpt.lock);
 	adev->reg.audio_endpt.rreg = NULL;
 	adev->reg.audio_endpt.wreg = NULL;
+
+	adev->reg.pcie.port_rreg = NULL;
+	adev->reg.pcie.port_wreg = NULL;
 }
 
 uint32_t amdgpu_reg_smc_rd32(struct amdgpu_device *adev, uint32_t reg)
@@ -179,6 +182,24 @@ void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
 	adev->reg.audio_endpt.wreg(adev, block, reg, v);
 }
 
+uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg)
+{
+	if (!adev->reg.pcie.port_rreg) {
+		dev_err_once(adev->dev, "PCIEP register read not supported\n");
+		return 0;
+	}
+	return adev->reg.pcie.port_rreg(adev, reg);
+}
+
+void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
+{
+	if (!adev->reg.pcie.port_wreg) {
+		dev_err_once(adev->dev, "PCIEP register write not supported\n");
+		return;
+	}
+	adev->reg.pcie.port_wreg(adev, reg, v);
+}
+
 /*
  * register access helper functions.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
index e19b7a531906..eb449dbb8fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h
@@ -49,6 +49,11 @@ struct amdgpu_reg_ind_blk {
 	amdgpu_block_wreg_t wreg;
 };
 
+struct amdgpu_reg_pcie_ind {
+	amdgpu_rreg_t port_rreg;
+	amdgpu_wreg_t port_wreg;
+};
+
 struct amdgpu_reg_access {
 	struct amdgpu_reg_ind smc;
 	struct amdgpu_reg_ind uvd_ctx;
@@ -56,6 +61,7 @@ struct amdgpu_reg_access {
 	struct amdgpu_reg_ind gc_cac;
 	struct amdgpu_reg_ind se_cac;
 	struct amdgpu_reg_ind_blk audio_endpt;
+	struct amdgpu_reg_pcie_ind pcie;
 };
 
 void amdgpu_reg_access_init(struct amdgpu_device *adev);
@@ -75,6 +81,9 @@ uint32_t amdgpu_reg_audio_endpt_rd32(struct amdgpu_device *adev, uint32_t block,
 				     uint32_t reg);
 void amdgpu_reg_audio_endpt_wr32(struct amdgpu_device *adev, uint32_t block,
 				 uint32_t reg, uint32_t v);
+uint32_t amdgpu_reg_pciep_rd32(struct amdgpu_device *adev, uint32_t reg);
+void amdgpu_reg_pciep_wr32(struct amdgpu_device *adev, uint32_t reg,
+			   uint32_t v);
 
 typedef uint32_t (*amdgpu_rreg_ext_t)(struct amdgpu_device *, uint64_t);
 typedef void (*amdgpu_wreg_ext_t)(struct amdgpu_device *, uint64_t, uint32_t);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index dd8a85679f8f..b3abf6554386 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -639,8 +639,8 @@ static int nv_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
-	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
-	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
+	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
+	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
 	adev->reg.didt.rreg = &nv_didt_rreg;
 	adev->reg.didt.wreg = &nv_didt_wreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index bf9ad3ce4c65..a517c6cd0711 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2041,8 +2041,8 @@ static int si_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->reg.smc.wreg = si_smc_wreg;
 	adev->pcie_rreg = &si_pcie_rreg;
 	adev->pcie_wreg = &si_pcie_wreg;
-	adev->pciep_rreg = &si_pciep_rreg;
-	adev->pciep_wreg = &si_pciep_wreg;
+	adev->reg.pcie.port_rreg = &si_pciep_rreg;
+	adev->reg.pcie.port_wreg = &si_pciep_wreg;
 	adev->reg.uvd_ctx.rreg = &si_uvd_ctx_rreg;
 	adev->reg.uvd_ctx.wreg = &si_uvd_ctx_wreg;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 4048c8dfdd4b..968d9be033d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -586,8 +586,8 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
-	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
-	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
+	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
+	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
 	adev->reg.didt.rreg = &soc21_didt_rreg;
 	adev->reg.didt.wreg = &soc21_didt_wreg;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 11e0264617d8..7c59d9b0a541 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -366,8 +366,8 @@ static int soc24_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg = &amdgpu_device_indirect_wreg;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
-	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
-	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
+	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
+	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 
 	adev->asic_funcs = &soc24_asic_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 0be52dba6a26..8c808a6d08a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -256,8 +256,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 	adev->pcie_wreg_ext = &amdgpu_device_indirect_wreg_ext;
 	adev->pcie_rreg64 = &amdgpu_device_indirect_rreg64;
 	adev->pcie_wreg64 = &amdgpu_device_indirect_wreg64;
-	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
-	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
+	adev->reg.pcie.port_rreg = &amdgpu_device_pcie_port_rreg;
+	adev->reg.pcie.port_wreg = &amdgpu_device_pcie_port_wreg;
 	adev->pcie_rreg64_ext = &amdgpu_device_indirect_rreg64_ext;
 	adev->pcie_wreg64_ext = &amdgpu_device_indirect_wreg64_ext;
 
-- 
2.49.0

