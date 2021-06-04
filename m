Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C4C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4916124B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4916124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5933B6F5F5;
	Fri,  4 Jun 2021 09:59:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA86F6F5F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNpvHpyKLkYl5rl6sB5IK+Bjit36cLNOKdxn8WXd+XOKPEjQtUVu5/sm0wNKZe9zOP+BV9gLYVRZ5T3y+GuWKjMOPx+8BpnkF92GN+2TmAFwZ7UliamWU1s5QB/ub5DwltRELvTHOQHy++/kW5Buh+jag59h+NZK1bvzAHzr4RTFcapdxs/OUTtxVTMB1yNx/6x2VIBIO2uePsBgCbycObOYn1Ck3CGqwM7B/KUKTj87Z4Kaw1pesJFQtXjWOY9slCiy6ICz/rGNqXaZqVOwXWw5XR33EH74lrd2dIGbkzLeAcYPplbtvWmHYi8xN5W9xN1E80KSxwuEQNKUkaqUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxC5f7R8hWXQsKr384+9EMciTXCCSGzXGXenqI1aric=;
 b=TWuIulhtFaKwUmWuUFeKcVlHjoWqAJ6pfWib6lOZvH7O7q4xLETa3+Ocu7SPiRz0u4rG+isNoGVg8fo5IprGE388WO4rsfNq2j9rCP8Szrql6z5YaamsDnCeqCinRVaTeoa1UjZ3y6PLdBbDxWhhyg6sQ+J7Y/NX1NKs79nc+9A7wx1ZyYIyRCey269ZsBpgG6ZRDYsruGt/q0Fh5y15cF10t8uuXjVTkWKso6UT06xuYMZol76oIWwMsE9hQEFmyRTc1zrc4jVSVlpbDtjy+3SOanTiye7hkvUf22oujU+204iZICb01SSXO3j3mFlD3ITnJHe1602qAQDnz9sJHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxC5f7R8hWXQsKr384+9EMciTXCCSGzXGXenqI1aric=;
 b=jvRjZHI7INR/FQCYBvaSe5BEVcMW8WH2LVsjWUTStONVCwcVWA3exQrNMyG8KA5U4CmCTNrvKmOP5f71y/ZCzc4stvh1eXjZVaz0UMV4rAu7Q1er7JxcJ9gK3LwpfwZKK5Z99J2wemQPXblt5aByiVhiffOy1FW6bINa7CNLf/g=
Received: from BN6PR22CA0063.namprd22.prod.outlook.com (2603:10b6:404:ca::25)
 by MN2PR12MB3310.namprd12.prod.outlook.com (2603:10b6:208:aa::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 09:59:16 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::c8) by BN6PR22CA0063.outlook.office365.com
 (2603:10b6:404:ca::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Fri, 4 Jun 2021 09:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 09:59:15 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 4 Jun 2021
 04:59:13 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/5] drm/amdgpu: correct the audio function initial Dstate
Date: Fri, 4 Jun 2021 17:58:21 +0800
Message-ID: <20210604095823.1403271-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210604095823.1403271-1-evan.quan@amd.com>
References: <20210604095823.1403271-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc5d850f-d273-44d0-4061-08d9273f698a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3310:
X-Microsoft-Antispam-PRVS: <MN2PR12MB331045A516401884EC92A92BE43B9@MN2PR12MB3310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkisZodx1GZE2XQymvyU/5irIV6fjtbzYFjNE7lajoOnZeDj7Iq3NARQense6UQM1KU4ID71SMgTI045Jlod8UYS3aW4dXAmk0ZgC2wYjXvbzIWn7sF1I5lKx3qzAa4/2+sIwyXKlbtxFabhSpzlWQfrx6hJlG+hyn1SPsPXhytEQglqwvqKUN6ayO2vBcKLKNx19V8W/GorJBn2UROcBKBHuq05RU6FXSLo7xiX44uXIlZdojNKlhiEpDBq4Xr755hbK5UW0c+FIXojSiX/lz6wCp/ew6IB0MkeCBWE8axCnBjM3YBUKre1NqbutcnB0mK0zr3UT9PJAX97bG6Yn0trVjCuPaMyv8kT7VpFERFi0HUb0zTTpr4uofNMf2C5sXXu4ei5TKFREWc87vSdwsGR6q4+WA3KLPPgpYuQh4QmqrSSNeF/pLncSAtO047OIeA+oO4u3kBVEqYl1bTXzxNRAbBHrUbympRl4jMCDimWi0qYiBK7skT/7WftB16U+2D4uz1eB06W/bJAmkabtWyx4dYukjH13n0CzsDcg/0PyvKSFPHOTS4BYH89mV9TCGGhL9nCHAbs8hRoSCIP2c+N/03KQkvvKeCsdeEnWorfSSVXjMTq/DsVtnVti6y+Wu+FsyeqC8x3NjLeWpIPZ8JYVCzbufd8yuS344jFYIv2UuuorcfR6JBrCJA3o5X2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(82310400003)(356005)(2616005)(36756003)(86362001)(54906003)(1076003)(316002)(82740400003)(81166007)(44832011)(83380400001)(8936002)(478600001)(336012)(26005)(16526019)(186003)(426003)(2906002)(36860700001)(8676002)(47076005)(6666004)(4326008)(7696005)(5660300002)(70206006)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 09:59:15.6297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5d850f-d273-44d0-4061-08d9273f698a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3310
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

On driver loading, the ASIC is in D0 state. The bundled
audio function should be in the same state also.

Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - Lijo: include the code in a seperate API for better readability
  - limit the change for Navi10 and later dGPUs
  - comments more about the background
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c354ffa62483..e9f2161738d1 100644
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
@@ -212,9 +228,33 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
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
+		 * and audio function was put into D3 state behind PMFW's
+		 * back, the BACO may not correctly kicks in and out.
+		 *
+		 * Via amdgpu_get_audio_func() below, the audio function
+		 * is guarded to be in D0 correctly.
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
