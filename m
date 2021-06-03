Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DACCC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2103D6024A
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2103D6024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D92C96F39B;
	Thu,  3 Jun 2021 04:56:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106B76F39B
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 04:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh9JJE4B1nHnt3PE2yo0nbC6EbNZy+PKRSPHWZVuJoJl+oIsOoXQEO+KPZn9BwGXE4ATRqG0OxXFf+fI8ov/xy8B4ytuelOhtgovTFoxFFs/7FyjhbPbT92IMeVmq5aBxhgz7JHEZLQIvqligM33aeQ5pkV3cNdgazZZHMEugvfMOVPg8tYKUWks9B+E9CjzbgbRn1e43Ou1YNgyjUs+Q0Ur87gYNEIOerBS14lmqZj2hXpki6XXh+5KU/VGIIQlyT4B1j+4E1WNnRrZm8WCFlq8dJxvpJghEA62NnwIgt+zCqcMhloZQP229axtGLmeLrN6JByDTEsBJwC25DIb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wXwErMsYB3PBIRtzYQC4AvgBSSk5FI7tRftkWcuACM=;
 b=nQgxWDvpgyaetkzOJQaLzJXo/yIGNiMKNvfSRmiZTRUYkF0GVk3oj8FNwvuQe9syg9dbFPwN5l7jgRLbzCiC6/pc0usrvZ8yuHRhLkkr+IF5Qu3qctKbF49/19kc9W/udZbH2FfiEHVbUBhxhbHRq8tywFAgoh8AXAxc0gmg+3fQ9ckEVISV1QChA3iQH8mNJrheqZMNCRQoCWigZFlNiIbsIw7gDdiplhNpPeZVeoudGh+W4BHAUlEXmGJH2wDyzjpqsefdH7Du8758jBteUYt4uvueHPFssBvUiBZ2Sjc5aq3GRh7/i5pXlRTLUSwlWWY/OP6FI6gQ+mPwDBKGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wXwErMsYB3PBIRtzYQC4AvgBSSk5FI7tRftkWcuACM=;
 b=GLP5GLH6kTm9jblrkgUsLlIOrtdM5cdxZE8RDD8FzmLZcjH/JrE5houqlXRLi+nQ3updKa8ri/lmNbEQcQwyfkPncQKdZtkdLbe7KeqVFxhLY3J+p5OfuCVtXBXxD6NQDO2Zd2MpuuMr4b4I4YHljIGKl+GNAUKQJzKeOozID0Y=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 04:56:32 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::79) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Thu, 3 Jun 2021 04:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 04:56:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 23:56:30 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu: correct the audio function initial Dstate
Date: Thu, 3 Jun 2021 12:56:01 +0800
Message-ID: <20210603045603.977998-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210603045603.977998-1-evan.quan@amd.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b079d0f5-b169-4610-960e-08d9264bf4a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3623:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36233149441C275DDA8EA116E43C9@BYAPR12MB3623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOD5OVt/5hLD7pNfj99qDYh38udym+4xvN/ops/akUfvmGYVWmTM0UEy1DpaixbfuYI1o5LR5mP2LXZXRxkiO4Vgw3YCawsTnz6XIo3BV95o5wuFNZS9HzqWmRXHbeED1Gdc7eWzUwASh/L90aqY4q2jWoB666CM9PS4YkPLUFAO/7UkQYptV+qnB2OmHZfpTESDq7AykHEhdBuQ3ea+QGI9J+bva2nAzWxyfogXFJQUhJvHDl+9FeQVp/XRjFwBmOlJarddjFoARDC6YY5t874vy2uHKadoozC0eue4yj2tMjpySQH/hZSTw6sqjOcUULXXHSuhdUl03zL92K6IeXzyjZstRhUfF/F59JQv0Mu9dI8NaUOhNnq/L4toHV4zmK0jaizB3JvGPWv45rQfdFulFfnUgkwEbKVMqWBCYwnbtTGpnTT6buz9zGOb1pfd2/CTj7pUKCbRZALasNbBj8Nv4VUOkTvK1TAVn5cztV2orzk4Q6CTUnGG4OjOMsYJtsELNqXNhcACnJxECRDGJrAgit0vD4AQk2cFU2Ev1YATfAJgU9TWxbY1Cluvj7SWez1YBvLjYONrGYk0+Ocn9etQMDqplWl3IjWsEQ4TnVveweygkzudSzHUJZwkunm+kBYyMZRngQzyHbf6nKn9ncn956xxsmuNLiJ8jJz1EqSr7HloNLPWWpWEQ0VdU/hS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(16526019)(54906003)(26005)(7696005)(8936002)(336012)(86362001)(82310400003)(5660300002)(36860700001)(478600001)(316002)(356005)(44832011)(70206006)(2616005)(1076003)(83380400001)(186003)(4326008)(47076005)(426003)(6916009)(2906002)(36756003)(6666004)(81166007)(70586007)(82740400003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:56:31.7783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b079d0f5-b169-4610-960e-08d9264bf4a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On driver loading, the ASIC is in D0 state. The bundled
audio function should be in the same state also.

Change-Id: I136e196be7633e95883a7f6c33963f7583e9bad1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index c354ffa62483..9d497b4f8e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -137,6 +137,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	struct drm_device *dev;
 	struct pci_dev *parent;
 	int r, acpi_status;
+	struct pci_dev *p = NULL;
 
 	dev = adev_to_drm(adev);
 
@@ -212,9 +213,22 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 						DPM_FLAG_MAY_SKIP_RESUME);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
+
 		pm_runtime_allow(dev->dev);
+
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put_autosuspend(dev->dev);
+
+		p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+				adev->pdev->bus->number, 1);
+		if (p) {
+			pm_runtime_get_sync(&p->dev);
+
+			pm_runtime_mark_last_busy(&p->dev);
+			pm_runtime_put_autosuspend(&p->dev);
+
+			pci_dev_put(p);
+		}
 	}
 
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_LOAD))
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
