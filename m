Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516C5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C426112E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 23:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02C426112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7AE6E5A0;
	Wed, 10 Nov 2021 23:26:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7D56E5A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 23:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7xbDnW6yY8aSe5tCFCoTiDucUOpTPcgYKUcqWMFBbOQ8YRX3TOSJSd+nttc7dmPz72yOo1m5dlng2OdSbpSiQymlZV54iHY3kEMMXLOBE9ws1ApvMjZYjsFKprl18vRgANtijLyR41XrlqIXdlIRPoQvyOTPZ8et68PXMVaQY2nL1CxlaE+T1EYDOhaNLIEwj1xPkTEvaQpUX2fMI6WJIMHE4DDNXgjSJ9V1yYlePThcpkkrOZ9IoXki7Q7lKs1/mrGDOAQ8RlYrQ1+qxPovUgjYr/Jn5i01guL/AUQtyPs76cmWYwJLaSq8erwusDgpR+7Lvob0EleLCg1Tirxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPDEJqKecmSmJsTC64Agd9ppEZn52z94GQi2RlaHhEA=;
 b=CXFGn1nZpdB6lKvj5ubEa4Nt38dkDWerlY3OX48Bx85MEEqFcvptFQYGJmFtvE4tdQX8oGT/UcPd/KRf4vhhMNwx1rjgjQEzoSddb2iNbGcPQnpSc+bzJcx3yWAS0BIsLJtAqsqNQF4VNzEom3AV61u2fsQd7vQT4ABe8IQPVHy6TMvpdNLXBtCc5uI/SzHQXe/TuMfUotV7l0kKaouZJ4n3IWw3/K/GAtG8EBUztplm/zTT7gc4rN+XLmheHGHjKaKP74nuKTeMAD8kJrYyyc19PVeNQyQKgHdJ4CFa3f6lJWtYW4y+fQMssolNjwpQD10HZgcwAVoju+d8GvSW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPDEJqKecmSmJsTC64Agd9ppEZn52z94GQi2RlaHhEA=;
 b=Z2YP+NPmMUdxFx1BE+UzMKBINfnz+hd2wyEwf+0CoiUwJdJPWrG1RPqTS3vBJSOvEOmT4vlQX6EtywPB6yWHz2wAMsio5qvI0XhSV2E0lO3SGlOgFBsPVZz7urqpKfjFG0EDbhqz5DcFwYmD6IFHHJ5fffJaaEKdDTh0HfYmdYw=
Received: from DM5PR18CA0055.namprd18.prod.outlook.com (2603:10b6:3:22::17) by
 DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Wed, 10 Nov 2021 23:26:33 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::24) by DM5PR18CA0055.outlook.office365.com
 (2603:10b6:3:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Wed, 10 Nov 2021 23:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 23:26:33 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 10 Nov
 2021 17:26:32 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: replace asic_family with asic_type
Date: Wed, 10 Nov 2021 18:25:53 -0500
Message-ID: <20211110232553.3815030-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aec6360f-0213-4e79-3d23-08d9a4a18843
X-MS-TrafficTypeDiagnostic: DM4PR12MB5376:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53760C9C524B87AD2332E7088A939@DM4PR12MB5376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oos6PJSrRi3BYOkXaQpHdCbofd9Eki4n1o/Uf1qBepM26R3M0UYncTni4WGbbIePh09rW35GhVAHSZDLGJMP1vBA5K6mKV7SQLJ6r4WonlOEzr7tgdsAOJ3QfJxDpUpoWu6VKFKAd18081GXxd70FKxmqiNEw0G2sYm763NsW7fsW4Qvjl9Whjn1/VEJkwMD7pOm73+QMA3D64eLtGGacOhsWCeQw8z1ckLn4Oyb6KaCZYYbzgNeqRsz0F2f8hVCPcbdcVXRrzyI4xEYhlMIub3hId9aDBUvm4sbgYTs4IbltBsIl1ioXpAbJBdWERyEaQFCPpH1Hw4fgc+2uJeyBx9veD8WK0jClP+dCHsHa0DlX4lOliAxnwbqbk3Jafam92BFIkPwXzpfzz7n9szDYI848ZsON9CUoMQHWy4ExMxib95Bf438J4AgPD1MT56PAKWzceGmct41gwhWeKwPpWCrxmo4ejEbw7I4Vekbh+d8JQZwvOkJAEwqVeAhP0LG57MXQhMaioRJnRXPe9cs4mKo7UkzJ7GSVlsdSsQNKSpReaGs8pCiu/Nir6+cRpAe+rH2XrShtuTdPTimQyqQUmRRjhjkYaNdl1uI/Zs9i4pMnD3Oja7wOM4v5gGq68E1rMNbWVvLAh39M97GVs6FPf5bKk/PIyYwnk1kxlz1WCSJ+pxKVCu0E32KWeiHq4X+IRu4Wxh4oLSscclh1mSJcFvQvmvz5+uVhpTVAihsjOk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(5660300002)(508600001)(316002)(336012)(186003)(86362001)(30864003)(2906002)(83380400001)(7696005)(26005)(47076005)(8676002)(6916009)(8936002)(356005)(426003)(70206006)(81166007)(2616005)(54906003)(6666004)(82310400003)(36756003)(36860700001)(1076003)(70586007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 23:26:33.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec6360f-0213-4e79-3d23-08d9a4a18843
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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
Cc: Felix.Kuehling@amd.com, Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

asic_family was a duplicate of asic_type, both of type amd_asic_type.
Replace all instances of device_info->asic_family with adev->asic_type
and remove asic_family from device_info.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  8 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 29 -------------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 12 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 11 ++++---
 10 files changed, 22 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index e31ea107e998..d60576ce10cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -43,7 +43,7 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
 	 */
 	if ((ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
 		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) &&
-		dev->device_info->asic_family == CHIP_HAWAII) {
+		dev->adev->asic_type == CHIP_HAWAII) {
 		struct cik_ih_ring_entry *tmp_ihre =
 			(struct cik_ih_ring_entry *)patched_ihre;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f70117b00b14..4bfc0c8ab764 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -580,7 +580,7 @@ static int kfd_ioctl_dbg_register(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	if (dev->device_info->asic_family == CHIP_CARRIZO) {
+	if (dev->adev->asic_type == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_register not supported on CZ\n");
 		return -EINVAL;
 	}
@@ -631,7 +631,7 @@ static int kfd_ioctl_dbg_unregister(struct file *filep,
 	if (!dev || !dev->dbgmgr)
 		return -EINVAL;
 
-	if (dev->device_info->asic_family == CHIP_CARRIZO) {
+	if (dev->adev->asic_type == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_unregister not supported on CZ\n");
 		return -EINVAL;
 	}
@@ -676,7 +676,7 @@ static int kfd_ioctl_dbg_address_watch(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	if (dev->device_info->asic_family == CHIP_CARRIZO) {
+	if (dev->adev->asic_type == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
 		return -EINVAL;
 	}
@@ -784,7 +784,7 @@ static int kfd_ioctl_dbg_wave_control(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	if (dev->device_info->asic_family == CHIP_CARRIZO) {
+	if (dev->adev->asic_type == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index b6d887edac85..f187596faf66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1340,7 +1340,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 	int ret;
 	unsigned int num_cu_shared;
 
-	switch (kdev->device_info->asic_family) {
+	switch (kdev->adev->asic_type) {
 	case CHIP_KAVERI:
 		pcache_info = kaveri_cache_info;
 		num_of_cache_types = ARRAY_SIZE(kaveri_cache_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index feebd652a7a1..ce9f4e562bac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -55,7 +55,6 @@ extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 
 #ifdef KFD_SUPPORT_IOMMU_V2
 static const struct kfd_device_info kaveri_device_info = {
-	.asic_family = CHIP_KAVERI,
 	.asic_name = "kaveri",
 	.gfx_target_version = 70000,
 	.max_pasid_bits = 16,
@@ -75,7 +74,6 @@ static const struct kfd_device_info kaveri_device_info = {
 };
 
 static const struct kfd_device_info carrizo_device_info = {
-	.asic_family = CHIP_CARRIZO,
 	.asic_name = "carrizo",
 	.gfx_target_version = 80001,
 	.max_pasid_bits = 16,
@@ -95,7 +93,6 @@ static const struct kfd_device_info carrizo_device_info = {
 };
 
 static const struct kfd_device_info raven_device_info = {
-	.asic_family = CHIP_RAVEN,
 	.asic_name = "raven",
 	.gfx_target_version = 90002,
 	.max_pasid_bits = 16,
@@ -116,7 +113,6 @@ static const struct kfd_device_info raven_device_info = {
 
 #ifdef CONFIG_DRM_AMDGPU_CIK
 static const struct kfd_device_info hawaii_device_info = {
-	.asic_family = CHIP_HAWAII,
 	.asic_name = "hawaii",
 	.gfx_target_version = 70001,
 	.max_pasid_bits = 16,
@@ -137,7 +133,6 @@ static const struct kfd_device_info hawaii_device_info = {
 #endif
 
 static const struct kfd_device_info tonga_device_info = {
-	.asic_family = CHIP_TONGA,
 	.asic_name = "tonga",
 	.gfx_target_version = 80002,
 	.max_pasid_bits = 16,
@@ -156,7 +151,6 @@ static const struct kfd_device_info tonga_device_info = {
 };
 
 static const struct kfd_device_info fiji_device_info = {
-	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -175,7 +169,6 @@ static const struct kfd_device_info fiji_device_info = {
 };
 
 static const struct kfd_device_info fiji_vf_device_info = {
-	.asic_family = CHIP_FIJI,
 	.asic_name = "fiji",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -195,7 +188,6 @@ static const struct kfd_device_info fiji_vf_device_info = {
 
 
 static const struct kfd_device_info polaris10_device_info = {
-	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -214,7 +206,6 @@ static const struct kfd_device_info polaris10_device_info = {
 };
 
 static const struct kfd_device_info polaris10_vf_device_info = {
-	.asic_family = CHIP_POLARIS10,
 	.asic_name = "polaris10",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -233,7 +224,6 @@ static const struct kfd_device_info polaris10_vf_device_info = {
 };
 
 static const struct kfd_device_info polaris11_device_info = {
-	.asic_family = CHIP_POLARIS11,
 	.asic_name = "polaris11",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -252,7 +242,6 @@ static const struct kfd_device_info polaris11_device_info = {
 };
 
 static const struct kfd_device_info polaris12_device_info = {
-	.asic_family = CHIP_POLARIS12,
 	.asic_name = "polaris12",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -271,7 +260,6 @@ static const struct kfd_device_info polaris12_device_info = {
 };
 
 static const struct kfd_device_info vegam_device_info = {
-	.asic_family = CHIP_VEGAM,
 	.asic_name = "vegam",
 	.gfx_target_version = 80003,
 	.max_pasid_bits = 16,
@@ -290,7 +278,6 @@ static const struct kfd_device_info vegam_device_info = {
 };
 
 static const struct kfd_device_info vega10_device_info = {
-	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
 	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
@@ -309,7 +296,6 @@ static const struct kfd_device_info vega10_device_info = {
 };
 
 static const struct kfd_device_info vega10_vf_device_info = {
-	.asic_family = CHIP_VEGA10,
 	.asic_name = "vega10",
 	.gfx_target_version = 90000,
 	.max_pasid_bits = 16,
@@ -328,7 +314,6 @@ static const struct kfd_device_info vega10_vf_device_info = {
 };
 
 static const struct kfd_device_info vega12_device_info = {
-	.asic_family = CHIP_VEGA12,
 	.asic_name = "vega12",
 	.gfx_target_version = 90004,
 	.max_pasid_bits = 16,
@@ -347,7 +332,6 @@ static const struct kfd_device_info vega12_device_info = {
 };
 
 static const struct kfd_device_info vega20_device_info = {
-	.asic_family = CHIP_VEGA20,
 	.asic_name = "vega20",
 	.gfx_target_version = 90006,
 	.max_pasid_bits = 16,
@@ -366,7 +350,6 @@ static const struct kfd_device_info vega20_device_info = {
 };
 
 static const struct kfd_device_info arcturus_device_info = {
-	.asic_family = CHIP_ARCTURUS,
 	.asic_name = "arcturus",
 	.gfx_target_version = 90008,
 	.max_pasid_bits = 16,
@@ -385,7 +368,6 @@ static const struct kfd_device_info arcturus_device_info = {
 };
 
 static const struct kfd_device_info aldebaran_device_info = {
-	.asic_family = CHIP_ALDEBARAN,
 	.asic_name = "aldebaran",
 	.gfx_target_version = 90010,
 	.max_pasid_bits = 16,
@@ -404,7 +386,6 @@ static const struct kfd_device_info aldebaran_device_info = {
 };
 
 static const struct kfd_device_info renoir_device_info = {
-	.asic_family = CHIP_RENOIR,
 	.asic_name = "renoir",
 	.gfx_target_version = 90012,
 	.max_pasid_bits = 16,
@@ -423,7 +404,6 @@ static const struct kfd_device_info renoir_device_info = {
 };
 
 static const struct kfd_device_info navi10_device_info = {
-	.asic_family = CHIP_NAVI10,
 	.asic_name = "navi10",
 	.gfx_target_version = 100100,
 	.max_pasid_bits = 16,
@@ -443,7 +423,6 @@ static const struct kfd_device_info navi10_device_info = {
 };
 
 static const struct kfd_device_info navi12_device_info = {
-	.asic_family = CHIP_NAVI12,
 	.asic_name = "navi12",
 	.gfx_target_version = 100101,
 	.max_pasid_bits = 16,
@@ -463,7 +442,6 @@ static const struct kfd_device_info navi12_device_info = {
 };
 
 static const struct kfd_device_info navi14_device_info = {
-	.asic_family = CHIP_NAVI14,
 	.asic_name = "navi14",
 	.gfx_target_version = 100102,
 	.max_pasid_bits = 16,
@@ -483,7 +461,6 @@ static const struct kfd_device_info navi14_device_info = {
 };
 
 static const struct kfd_device_info sienna_cichlid_device_info = {
-	.asic_family = CHIP_SIENNA_CICHLID,
 	.asic_name = "sienna_cichlid",
 	.gfx_target_version = 100300,
 	.max_pasid_bits = 16,
@@ -503,7 +480,6 @@ static const struct kfd_device_info sienna_cichlid_device_info = {
 };
 
 static const struct kfd_device_info navy_flounder_device_info = {
-	.asic_family = CHIP_NAVY_FLOUNDER,
 	.asic_name = "navy_flounder",
 	.gfx_target_version = 100301,
 	.max_pasid_bits = 16,
@@ -523,7 +499,6 @@ static const struct kfd_device_info navy_flounder_device_info = {
 };
 
 static const struct kfd_device_info vangogh_device_info = {
-	.asic_family = CHIP_VANGOGH,
 	.asic_name = "vangogh",
 	.gfx_target_version = 100303,
 	.max_pasid_bits = 16,
@@ -543,7 +518,6 @@ static const struct kfd_device_info vangogh_device_info = {
 };
 
 static const struct kfd_device_info dimgrey_cavefish_device_info = {
-	.asic_family = CHIP_DIMGREY_CAVEFISH,
 	.asic_name = "dimgrey_cavefish",
 	.gfx_target_version = 100302,
 	.max_pasid_bits = 16,
@@ -563,7 +537,6 @@ static const struct kfd_device_info dimgrey_cavefish_device_info = {
 };
 
 static const struct kfd_device_info beige_goby_device_info = {
-	.asic_family = CHIP_BEIGE_GOBY,
 	.asic_name = "beige_goby",
 	.gfx_target_version = 100304,
 	.max_pasid_bits = 16,
@@ -583,7 +556,6 @@ static const struct kfd_device_info beige_goby_device_info = {
 };
 
 static const struct kfd_device_info yellow_carp_device_info = {
-	.asic_family = CHIP_YELLOW_CARP,
 	.asic_name = "yellow_carp",
 	.gfx_target_version = 100305,
 	.max_pasid_bits = 16,
@@ -603,7 +575,6 @@ static const struct kfd_device_info yellow_carp_device_info = {
 };
 
 static const struct kfd_device_info cyan_skillfish_device_info = {
-	.asic_family = CHIP_CYAN_SKILLFISH,
 	.asic_name = "cyan_skillfish",
 	.gfx_target_version = 100103,
 	.max_pasid_bits = 16,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c894cbe58a36..42b2cc999434 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -292,7 +292,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 				struct queue *q)
 {
 	/* On GFX v7, CP doesn't flush TC at dequeue */
-	if (q->device->device_info->asic_family == CHIP_HAWAII)
+	if (q->device->adev->asic_type == CHIP_HAWAII)
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
@@ -1016,7 +1016,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
 	
-	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
+	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
 		return pm_init(&dqm->packet_mgr, dqm);
 	dqm->sched_running = true;
 
@@ -1025,7 +1025,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 
 static int stop_nocpsch(struct device_queue_manager *dqm)
 {
-	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
+	if (dqm->dev->adev->asic_type == CHIP_HAWAII)
 		pm_uninit(&dqm->packet_mgr, false);
 	dqm->sched_running = false;
 
@@ -1861,7 +1861,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	if (!dqm)
 		return NULL;
 
-	switch (dev->device_info->asic_family) {
+	switch (dev->adev->asic_type) {
 	/* HWS is not available on Hawaii. */
 	case CHIP_HAWAII:
 	/* HWS depends on CWSR for timely dequeue. CWSR is not
@@ -1924,7 +1924,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		goto out_free;
 	}
 
-	switch (dev->device_info->asic_family) {
+	switch (dev->adev->asic_type) {
 	case CHIP_CARRIZO:
 		device_queue_manager_init_vi(&dqm->asic_ops);
 		break;
@@ -1953,7 +1953,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 			device_queue_manager_init_v9(&dqm->asic_ops);
 		else {
 			WARN(1, "Unexpected ASIC family %u",
-			     dev->device_info->asic_family);
+			     dev->adev->asic_type);
 			goto out_free;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index fa3ec3ed7e39..2e2b7ceb71db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -394,7 +394,7 @@ int kfd_init_apertures(struct kfd_process *process)
 			pdd->gpuvm_base = pdd->gpuvm_limit = 0;
 			pdd->scratch_base = pdd->scratch_limit = 0;
 		} else {
-			switch (dev->device_info->asic_family) {
+			switch (dev->adev->asic_type) {
 			case CHIP_KAVERI:
 			case CHIP_HAWAII:
 			case CHIP_CARRIZO:
@@ -411,7 +411,7 @@ int kfd_init_apertures(struct kfd_process *process)
 					kfd_init_apertures_v9(pdd, id);
 				else {
 					WARN(1, "Unexpected ASIC family %u",
-					     dev->device_info->asic_family);
+					     dev->adev->asic_type);
 					return -EINVAL;
 				}
 			}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 64b4ac339904..406479a369a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -91,7 +91,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
 	kq->pq_gpu_addr = kq->pq->gpu_addr;
 
 	/* For CIK family asics, kq->eop_mem is not needed */
-	if (dev->device_info->asic_family > CHIP_MULLINS) {
+	if (dev->adev->asic_type > CHIP_MULLINS) {
 		retval = kfd_gtt_sa_allocate(dev, PAGE_SIZE, &kq->eop_mem);
 		if (retval != 0)
 			goto err_eop_allocate_vidmem;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 88dc0e451c45..1439420925a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -223,7 +223,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 {
-	switch (dqm->dev->device_info->asic_family) {
+	switch (dqm->dev->adev->asic_type) {
 	case CHIP_KAVERI:
 	case CHIP_HAWAII:
 		/* PM4 packet structures on CIK are the same as on VI */
@@ -243,7 +243,7 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 			pm->pmf = &kfd_v9_pm_funcs;
 		else {
 			WARN(1, "Unexpected ASIC family %u",
-			     dqm->dev->device_info->asic_family);
+			     dqm->dev->adev->asic_type);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 352709034acf..1d3f012bcd2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -195,7 +195,6 @@ struct kfd_event_interrupt_class {
 };
 
 struct kfd_device_info {
-	enum amd_asic_type asic_family;
 	const char *asic_name;
 	uint32_t gfx_target_version;
 	const struct kfd_event_interrupt_class *event_interrupt_class;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 641e250dc95f..a3f590e17973 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -515,7 +515,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 				HSA_CAP_WATCH_POINTS_TOTALBITS_MASK);
 		}
 
-		if (dev->gpu->device_info->asic_family == CHIP_TONGA)
+		if (dev->gpu->adev->asic_type == CHIP_TONGA)
 			dev->node_props.capability |=
 					HSA_CAP_AQL_QUEUE_DOUBLE_MAP;
 
@@ -1217,8 +1217,7 @@ static void kfd_set_iolink_no_atomics(struct kfd_topology_device *dev,
 	/* set gpu (dev) flags. */
 	} else {
 		if (!dev->gpu->pci_atomic_requested ||
-				dev->gpu->device_info->asic_family ==
-							CHIP_HAWAII)
+				dev->gpu->adev->asic_type == CHIP_HAWAII)
 			link->flags |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
 				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
 	}
@@ -1406,7 +1405,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
 
-	switch (dev->gpu->device_info->asic_family) {
+	switch (dev->gpu->adev->asic_type) {
 	case CHIP_KAVERI:
 	case CHIP_HAWAII:
 	case CHIP_TONGA:
@@ -1432,7 +1431,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
 		else
 			WARN(1, "Unexpected ASIC family %u",
-			     dev->gpu->device_info->asic_family);
+			     dev->gpu->adev->asic_type);
 	}
 
 	/*
@@ -1449,7 +1448,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	 *		because it doesn't consider masked out CUs
 	 * max_waves_per_simd: Carrizo reports wrong max_waves_per_simd
 	 */
-	if (dev->gpu->device_info->asic_family == CHIP_CARRIZO) {
+	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
 		dev->node_props.simd_count =
 			cu_info.simd_per_cu * cu_info.cu_active_number;
 		dev->node_props.max_waves_per_simd = 10;
-- 
2.25.1

