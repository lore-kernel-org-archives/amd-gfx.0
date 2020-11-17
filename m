Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F22C64E7D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8B120867
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bK/m9IPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8B120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523026E204;
	Tue, 17 Nov 2020 13:31:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC526E204
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 13:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxatYfIOuB1gDYdP0zz3LkTDz0ePCQvGSVRYXBT7TN8tIbjZCPWngAzfv0/ZSGDrFUkyENhnQ5EcXsUDDl/VtquwSE85TFTesm/pZiZVlnF0XZofSvPHyMcW882JOm5fJe0XNp5v7N4w6kZ/h7TfGvNLNZZmG6ab69Et/XPOk5NayNNIyWAT4pem3ipTlPpyyyrJctriUbukHAv/XZilPucz9/hDk8wRpHtBl6JWytZwXF+19VXmy5aupGqkMVMVPW4wu8TG9/YJqzw86OT0rnTAqd8gZxAizw1cxVvkFxySjBHQzehvAqJQl7QDvmNkAWS4H+aUa7Um2/y+i8y1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4AxOpnQxjk+e/0HGNGauYs41lSbX4fzlZtTh5ttX8c=;
 b=BE7iDox22w5R3lh9BA8ANQn7hgJ3lxW0QSUSr3ldfnDLFVqmT4OWg1ICvCvCtYn5BIkI7/kKWNZrfT2nIPRzbdxpaSkbKcZH7M0UrUowyrm0NoUiI5vyhAQ0juuX900cHmJgWHig8D6hQNqKrZMsyRapmhxMVWRAoFfxRDRkDXBb+PD9P8CzZcipuSvqSdxeUr85N1JHqmbiAEjlH1SNKf1xs7WSf+j8zpGqGMOD5DWkxlvOKIrFEuqfFiCDSnQfOdHtohXPU5pOtNkY3uC14+IKK/ybL83B6jm+hve1q33VkUnxPyIH25MycdfwamxF+ngF6Kxdq7nDwerpMXy/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4AxOpnQxjk+e/0HGNGauYs41lSbX4fzlZtTh5ttX8c=;
 b=bK/m9IPLCBsczYarcVwSw26uqiWsJwdOuQraPe2o3C2LHlcreBbpeHMcjW3T3h+4QYJU6ZR+M7z49YSTcrD9za+UJNg7Wj0YQYDRoZvQ3pkHl6JMOhUPKoV9z4xUsrauxAg2J55u8DEUxZXRJQR40TCqLOLIQxj3okf1Q8QidFQ=
Received: from MWHPR1601CA0021.namprd16.prod.outlook.com
 (2603:10b6:300:da::31) by CY4PR12MB1909.namprd12.prod.outlook.com
 (2603:10b6:903:124::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 13:31:10 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::2f) by MWHPR1601CA0021.outlook.office365.com
 (2603:10b6:300:da::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Tue, 17 Nov 2020 13:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 13:31:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 17 Nov
 2020 07:31:09 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 17 Nov 2020 07:31:08 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/amdgpu: fix null pointer in runtime pm
Date: Tue, 17 Nov 2020 21:30:50 +0800
Message-ID: <20201117133051.1016-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117133051.1016-1-kenneth.feng@amd.com>
References: <20201117133051.1016-1-kenneth.feng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 254cace9-8d30-493c-c343-08d88afd0bc1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1909:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1909A5473A1AFF46E45456928EE20@CY4PR12MB1909.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/ylTFHN7EmrTe08MUwxck+18PYCIFnnVk1nBqqkqdnwGCZAGi6yyRx+/TL/88en2psLO8/vGHokjLq4CG5TmpY6jDPnW54pw2zPt0sMtpOTmozDxVeS8YrOwATVEBl7/aAhDh0XlmpGr8xn8fKN3XgvHCWbWyYex1FIq8ILzJhlNSR0WMD2WxnKOQ/l2FaOqrcCGBf/PDNRF4lQhqHXfyoYUPMPO3pxCDz96A00psNIx3TquC08bDyjV09zkOdI7OgoyFTnps525U2760rKAPeqX7eiEzJqpyiROIEldIN/q+GV6SM23gO6kaY9KB7Yo/HMEugGeFg3H9BCPzgCZOdSBn9Hw0DQDVBcnfYSSXpmXszNC19vQrDThl4bXw6TvapejpziYExao+qMUcCAiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(70206006)(86362001)(83380400001)(70586007)(26005)(186003)(316002)(7696005)(478600001)(2906002)(82740400003)(2616005)(6666004)(4326008)(426003)(356005)(6916009)(36756003)(5660300002)(81166007)(44832011)(8676002)(1076003)(82310400003)(8936002)(47076004)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 13:31:09.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254cace9-8d30-493c-c343-08d88afd0bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1909
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix the null pointer issue when runtime pm is triggered.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1fe850e0a94d..0ebba4380979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4859,7 +4859,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
 	if (!amdgpu_device_supports_baco(adev_to_drm(adev)))
 		return -ENOTSUPP;
 
-	if (ras && ras->supported)
+	if (ras && ras->supported && adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, false);
 
 	return amdgpu_dpm_baco_enter(adev);
@@ -4878,7 +4878,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	if (ret)
 		return ret;
 
-	if (ras && ras->supported)
+	if (ras && ras->supported && adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
