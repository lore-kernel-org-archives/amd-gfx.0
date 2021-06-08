Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63DDC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587E561249
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587E561249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6666EA97;
	Tue,  8 Jun 2021 04:35:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4C76EA97
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/R838wxp7zxQZDUSZ0hrWtKMRHQ81EK2uJYOcY6f7oNzfMcWnfbHNXLp0AgqJmsw6ggnomnRmoMzdA6nbQoKzIncsohoVJmdLLaDqbZctYUTKWJl3nW1gq494ZxTnYUND1jzDlOXytINHX+GqnibfF43HCigO/lqoqAadiSxE1hsa0DrfuffHwME5jfD1O529mM0nI4f1v2ujhprje9E9Br62132xqu9hJztWePInzhDDTTjz9zlRVhZfWQ5UlrGHI5qeN7eClAFfO7e8c3LwbEuPONznGFIJYG3l9irD3jw7Sik2dLrnc+D4f+r/VPYnz6Bj4XbvEdNBMzVWAWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFkPD0lEeCD7BJTbQCJJR8EYpYBe2rk535ODOUgIXVw=;
 b=f1sXlKEjbUQ5/90kIZynv/IipGl7bi6M3U/+u2jluCS+FI1jrhye7POLqyFpmyaiG//9AXsHGmA1qaMzlQIzYYcs38sXBScrh7WNak7djx/44fBV9tUw7nHKEDNjuF1OTla+HzjpT7IPvV/eoRAsnopYdbQs5CNgYkm1XazduuYZmDKpjmWezVbUT6ZtaSrnbKA3HsnSxnLtUkYWIXOY9/zyAvWD/3kDN1NkXreUvDX72X9k8Zt/0W0ylgG+zuOpLB9wzRu844AitxAESuLnJAf+kt6FO4ffC90RsRUDps+6rsIUpXt0cQJY7ImUA0T1PQpbBHn6PyemllmjDCqaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFkPD0lEeCD7BJTbQCJJR8EYpYBe2rk535ODOUgIXVw=;
 b=xfAW7J1YFp3WnNqCU6q5HDiNo6vNcrwdRzqbc3tXdh/2KoZff2mUyWLDg/eCZQFNU+8aPcWFIYY3uvwTP3umxIjhbHGp3Tu8M2d5Bm309fe9YxwBVDC3VD33cX+1DLkVLuro72VShNXFnuE7IECiN38fU/Jkqfz8/EOgSpGcNGs=
Received: from BN9PR03CA0408.namprd03.prod.outlook.com (2603:10b6:408:111::23)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 04:34:57 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::3c) by BN9PR03CA0408.outlook.office365.com
 (2603:10b6:408:111::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Tue, 8 Jun 2021 04:34:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Tue, 8 Jun 2021 04:34:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 23:34:55 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 3/5] drm/amdgpu: make audio dev's D-state transition
 PMFW-aware
Date: Tue, 8 Jun 2021 12:34:29 +0800
Message-ID: <20210608043431.1855151-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210608043431.1855151-1-evan.quan@amd.com>
References: <20210608043431.1855151-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: badefb8a-12e9-4842-4cec-08d92a36c51e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333558A9842ADC3BF3078C2E4379@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uza+btl8npRQ0L4gh0ei2O/BfMrn8PqM4S4kuGg+IEocuAms+jcq5V+4budtuSCELmUMy97P9EzGW6o8M+oMtE6RNaKXIEf7eTIl9aA6DMHoAabgMB6F0zWBHAXTObGNp85Y1MIFmG2x9Io0iDBHaISm3QVUKNpW/MoyLTGd5PTOvYJc/8ag+F6dBZbONK0ow0L6yeEwnySDKkeTmzVwmGapVzgJbI8p0YOGGG/0XjVX1k/+tXcgW+/f2dnkxJYAgelzBIl+4ey2DrLkMyFuoby9S5RRFqBRpuZet/95PQWHRHkEKb3TF/IgDAimkV7xT3Pc3XSBAplwHYaS62Bt2GqzYcHYHfWzws7VnPk0xcBFHxWrWXupGaoTB4KP3AzLsKW4P+S6L7/WwOdLzE0aN9aHu0d/9SYhxlfsM5ix1nmecz7a08kWvdxetCMDOATv4xrC5K/BgP2e8qZUq3Sesqk5sBfAPEJ/UoyIV+mHGEyNViopVzIcaHFjUN13AOqO1jNTVWNWPyH3mC5AhXz3llbK4kfoLFIvTG3w/LPBOBgpeWvjSfbC0uEhDYjUkdwEmn+6P7rUxepaxwQ/euTWpqGroD2RjxvQEOBaK2MujNpYe7qenVvbE+Wl/7rojv/tQYdIa3AgU/5hHqHmDXWInHZcpUVPT/KO0zznGb5KHY+GzqapirrcvH2HCc52WNbj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(36840700001)(7696005)(478600001)(47076005)(336012)(6916009)(4326008)(2906002)(2616005)(1076003)(356005)(16526019)(70206006)(82310400003)(186003)(81166007)(86362001)(70586007)(36756003)(44832011)(5660300002)(36860700001)(82740400003)(8676002)(8936002)(26005)(426003)(83380400001)(6666004)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:34:57.2903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badefb8a-12e9-4842-4cec-08d92a36c51e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To correctly kick into BACO state, the audio dev's D-state
transition(D0->D3) needs to be PMFW-aware. So, if the audio
dev entered D3 state prior to our driver, we need to bring
it back to D0 state and make sure there will be a D-state
transition on runpm suspend.

Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - Lijo: include the code in a seperate API for better readability
  - limit the change for Navi10 and later dGPUs
  - comments more about the background
v2->V3:
  - Lijo: update the code comment further
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c354ffa62483..131ae2a17abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -123,6 +123,22 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_unlock(&mgpu_info.mutex);
 }
 
+static void amdgpu_get_audio_func(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (p) {
+		pm_runtime_get_sync(&p->dev);
+
+		pm_runtime_mark_last_busy(&p->dev);
+		pm_runtime_put_autosuspend(&p->dev);
+
+		pci_dev_put(p);
+	}
+}
+
 /**
  * amdgpu_driver_load_kms - Main load function for KMS.
  *
@@ -212,9 +228,35 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 						DPM_FLAG_MAY_SKIP_RESUME);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
+
 		pm_runtime_allow(dev->dev);
+
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put_autosuspend(dev->dev);
+
+		/*
+		 * For runpm implemented via BACO, PMFW will handle the
+		 * timing for BACO in and out:
+		 *   - put ASIC into BACO state only when both video and
+		 *     audio functions are in D3 state.
+		 *   - pull ASIC out of BACO state when either video or
+		 *     audio function is in D0 state.
+		 * Also, at startup, PMFW assumes both functions are in
+		 * D0 state.
+		 *
+		 * So if snd driver was loaded prior to amdgpu driver
+		 * and audio function was put into D3 state, there will
+		 * be no PMFW-aware D-state transition(D0->D3) on runpm
+		 * suspend. Thus the BACO will be not correctly kicked in.
+		 *
+		 * Via amdgpu_get_audio_func(), the audio dev is put
+		 * into D0 state. Then there will be a PMFW-aware D-state
+		 * transition(D0->D3) on runpm suspend.
+		 */
+		if (amdgpu_device_supports_baco(dev) &&
+		    !(adev->flags & AMD_IS_APU) &&
+		    (adev->asic_type >= CHIP_NAVI10))
+			amdgpu_get_audio_func(adev);
 	}
 
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
