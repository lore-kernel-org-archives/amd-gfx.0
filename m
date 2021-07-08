Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C83C07E96
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 17:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE0F613AB
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 17:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE0F613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6366E920;
	Thu,  8 Jul 2021 17:39:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4FC6E920
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 17:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K78gXBZt7Jq2GebF7umjm2or6d6puIn0eHIEX5nW0W7mOvRj4BgxbGR6llzrdTgfqlLbJVuFx59CeubCNQtGDbQBZ02a7h0R38mhHjVej7sAUhzMeC69mjMbzttAaaRk8UBFkhk3T0R22QmCZQD9T/xvDbc8J4db4BM5hbVus5ELAm9E0m41V/5IJKDQ6w2vpdlRHJiJXgAWzY/5MyxKDfkP7ZuZPenddMn27Xi3gvWVTh94+JT4VIAQSbKxi7gAh0FsixzMvtHuJemtq7XB2nTBAl4dRLr6dxvPfDZX4sYhSPJJmhwVSND2u00X2Zju3CzKUxLzH4SwvBgWR0CL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9chlV3Cew3CMYdpN97rrkbKnAkjztojunJrFVVVxRI=;
 b=HoTkVB5RUH55n5rx0EBO02Lv6UkNsPrlZyaqUGZRzwYCv6ipqUxrtr0z+ckXhj2FeGTjJOhCC2FP8/NHL0+lwU6/0RNhPkUYe2dWi9Vrg2fg6fW8EPyGPA6wt3vEmpTDaIt87EgOaKT2WxPnZLIbsPJGfrcx4L3A4bZchAUlPxyiMoyGE7z/2O7xsn2OhGDcLBTOLbu6AbnlYDGScE1YuI95dQ92c+rZCq5gNmykxJHPtMbqRtVggG8O0Uul85P1ITkLz19YuK56rSIlgrwywMnLLy8zEFDMsNYbYTKaIKnkJWGni2jCYLqV9Iy93UciaQwFA9AxsrVZd3S2LnfNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9chlV3Cew3CMYdpN97rrkbKnAkjztojunJrFVVVxRI=;
 b=bclZwY76SiWUD6LvLwzzkO4lgI72mTiWo3j1bL07n3NflKpvIeNRv224kI0AHjqGQ9FNbZgSXYdT8j+GBu5vS4iZ+Rw4DYk34TM+NfSzS/JF5gvaruQ7CkI7hX5dKHXgTboTGmqu2JW78HhyRYL3UqzfnD14y5Y923IRZGtsspg=
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 17:39:50 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::76) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Thu, 8 Jul 2021 17:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 17:39:49 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 8 Jul 2021
 12:39:48 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Update SMI throttle event bitmask
Date: Thu, 8 Jul 2021 13:38:56 -0400
Message-ID: <20210708173856.3391-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74bf26c6-3842-46bb-8fd3-08d9423762bb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48599DD44C262C7BA58619748A199@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3e0s8M6VgXej00Ap8f7njc161hAlpnZMR2MbjREGNJ6gkrx6jYk7DkziIsK5wXr8f5+kuEA+Ri0w1Umz2IZBJJJB33UxKnB+EVeIjiszLkWunU+mfv9x1W1EBvPiEz8l/Cn0xJA2M1NOrGiv9r5v7YjYRSS8Ie91DN+ei+hjigmoRvCzD1kS/KADX/uuNchkRtPJB1ociBFto6ss7Hv/zpgPN7ATpIhZFdGqpni5OPV0FXTg+HPLCzIQO03SVYIXMXMmnbCMuRfFyxdvq/OlMfOcto9yENJgf42nR6Sf1couVQgaZjei8QmL+2qmJT8FTOqvOEASBiFbPHPYbk0rNKuX4LmEGHA/1R2/XkjwfE5gTvmx4acLsP/SsWRV7yXWhQ54CY5elMnxYt3ffo+FvY/FNZmNalLXwy5EY1QPwErDfi/4AJxdrO25mpH7OCa8gTCeqEAagkdYNG7HDxKE2Nhy7KlIXth2hRQ+B9AU2J0bGUCTBCOtW3gffVxbDQ5FJChqh34s6EI308vTVi4FMIlPLRptzpF7Wap51U44WvmHUNp2c+ycqZ4wTD5qxvddi/u/D92VmtxPoVVdKFbK1pRYRCIufg/9hSgX5O6Z2eReJO1zhoTx/wndnkvgi6jPNi2KNlK7vWR9b4AJ254xc/T/tfhV/XsoTu5vaYqA0BCL0DfpJOM4pSsO9LzrIPCFPsh90iq/XoW1Oj3wO3A9uhR3b+hbHx5MWSIAjHvsLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(70206006)(70586007)(82310400003)(2906002)(7696005)(36756003)(1076003)(86362001)(15650500001)(336012)(356005)(81166007)(47076005)(426003)(2616005)(26005)(6916009)(16526019)(83380400001)(4326008)(186003)(54906003)(478600001)(6666004)(8936002)(82740400003)(5660300002)(36860700001)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 17:39:49.5690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bf26c6-3842-46bb-8fd3-08d9423762bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
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
Cc: Harish.Kasiviswanathan@amd.com, Graham Sider <Graham.Sider@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update Arcturus/Aldebaran thermal throttle SMI event path to use
ASIC-independent throttler bits when logging.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  4 +++-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fabc68eec36a..9c505ac0be8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -330,7 +330,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -389,7 +389,7 @@ void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
 }
 
 static inline
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e937f0..5b06bc308782 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1370,7 +1370,7 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 	WARN_ONCE(count < 0, "Compute profile ref. count error");
 }
 
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 	if (kfd && kfd->init_complete)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 246522423559..ed4bc5f844ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -205,23 +205,23 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
-					     uint32_t throttle_bitmask)
+					     uint64_t throttle_bitmask)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
 	/*
 	 * ThermalThrottle msg = throttle_bitmask(8):
 	 * 			 thermal_interrupt_count(16):
-	 * 1 byte event + 1 byte space + 8 byte throttle_bitmask +
+	 * 1 byte event + 1 byte space + 16 byte throttle_bitmask +
 	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
-	 * 1 byte \0 = 29
+	 * 1 byte \0 = 37
 	 */
-	char fifo_in[29];
+	char fifo_in[37];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       atomic64_read(&adev->smu.throttle_int_counter));
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index b9b0438202e2..bffd0c32b060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -26,7 +26,7 @@
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
-					     uint32_t throttle_bitmask);
+					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6b3e0ea10163..6ec8492f71f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2178,7 +2178,9 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 			log_buf);
-	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
+		smu_cmn_get_indep_throttler_status(throttler_status,
+						   arcturus_throttler_map));
 }
 
 static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c16ca0c78e93..e1575d974315 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1627,7 +1627,9 @@ static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 		 log_buf);
-	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
+		smu_cmn_get_indep_throttler_status(throttler_status,
+						   aldebaran_throttler_map));
 }
 
 static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
