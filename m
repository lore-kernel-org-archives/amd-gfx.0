Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A58C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D9B613C5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D9B613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A2A6E413;
	Wed, 14 Jul 2021 15:25:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73316E416
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3eopvziZN6k/DYqq9iXk7ZPrNsbPZ1RQ0P728ZcmdoEBuXlLiufZtTXPHCEhe/HSffH4U8D30E4FCNXiBzHmLRTIFBjOh6OVpTkZj7jl0bWvtVp+KYiP37bUbiFlcUmWw9xLJeRAPA0YE+W6g5fsrlsiMdLArOOxRljusz7EdijWtLMrPUzQyW05Ssdq8v+5dNZbQyRYAArPPBFHt1qJIRWM9Wwn3urRjKdyDgbCC9BLlE7w3o/pYBUAzVmDJGE1rthdv6cUKQnGp9L8t6NoymDOnH5ngWzelGocWexECM02X155b50qIVRoVA8OG3a5V6cabGrm7FBLM9lTsmRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/SEdkLdrBxO7lq27zNDbKDSV1i2PGejrWkn08pEN/U=;
 b=UV0Tz6+hlEN9hak3G0NlzwMwuOp5wJvCkrIB1xZNRsxJBjlNDTBu3+EPKtGvAVrikL7ZQ1YxgLUUuAPXuTAwkgz5C8Qb8oiDjUkwRXFqr+ZGy+5fkjnmYie/501viwDdANJuUQvWIiBjyCFpL/W5Ahk4sWp95DI9rc9FnSZN4YtgkN3z+WDh25YJ4utICNpX1jMZA+hNMvfLphuWqC8QnroBViLXOWslLhofSATWsuxQPOXbOyn9ER7/Wt4fCyy/0LRAxY63JRubKFLJYhTzWtUsbEOkconh3gzCGfgIiPWr2C/hVsi2Q5o/bE1KZXkCana4riguHvKdewiW5lA4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/SEdkLdrBxO7lq27zNDbKDSV1i2PGejrWkn08pEN/U=;
 b=DQTo2yB/FkQdq9jFs/lhV/VqgPcXBHuY2OgCEcNTcjxLtTc8u2rrwpLnssfn6O8axsc8OK3O4BodsAekTC0M5H4Bdof14T+E2luWmS9bUodtS6MVnaIA6q/aPnwpOUUD7hvR7AO5xrw8H55O1zs0QubRpGCfICto516RmjmgK7E=
Received: from DM5PR16CA0005.namprd16.prod.outlook.com (2603:10b6:3:c0::15) by
 CH2PR12MB3912.namprd12.prod.outlook.com (2603:10b6:610:2c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Wed, 14 Jul 2021 15:25:54 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::35) by DM5PR16CA0005.outlook.office365.com
 (2603:10b6:3:c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 15:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:25:54 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 10:25:50 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Fix a printing message
Date: Wed, 14 Jul 2021 10:25:42 -0500
Message-ID: <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55dfff94-a65d-46e3-1d6b-08d946dbabf4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3912:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3912836401E4A58EB51FCC2080139@CH2PR12MB3912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMc9VjrNYzg4PGxYed96IBco9MJvXxj8Gf6MqiIJ7+XCl3rsEgvO8aRH3Iq7D3pP5+syfYm6LYFA6vW3/pVQm8uHoWuL0EKTePEcgFNmPPJ3LT12ZPlMN2VquQmKa5rn4cm60ExkQIBe9JQy5Mkd/DmQNubwWEeRDsnYmff85AMW2bHP+/hyICjx+EudyHVeYOusBLsCopGpqY6TlPDqU2h0iUTi1WAIgwA7o9sAREHYwk6bQMQs/NQi1XiEmpc6/AVDYl05OG3oMDPxlv+0HovdBpXOFEkbJyBDBPDJg7wgLtMiDp8Nk+KfK50FfJzy1P3ckPyrCRIaME2usk/Wn5FfRjS7KHyiY8UjomZ5Krp8QpVTsCL7FTUnTmBVsqY3b6xDAlIzhoWSicmBg7+RpwgoSmwhSoaHtH62iWE6e4teEUrj4dopmE2DyPchFHRRdku1Mh5b6wzww15nJSVocVJ/MHd6TKj1mQLg15yEQYHlzE+IRXic/SX9wZ0Ad5nm5heYMWlye82rOeJ3pigr2oLKYy+Odog54RcbZjw27w5QL76UnB+Ay62Ojp4zdYE5/V7JzcjCUQZfMKhX4191hhgjgHiT53jlEAvovby5fAK/RzvvWQCtJK1JtPx03SJFU9ESh4CpELXRhzyhEACH/6DNCQk4htoILntjdem5gVEL15uE5f7bwxnsP3LxreE64R2fGN1IxSs4oZpdSBYlVHy/GjURxh7V+mm0dK5LG+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(8676002)(6916009)(47076005)(36756003)(8936002)(336012)(356005)(426003)(82310400003)(4326008)(2616005)(82740400003)(83380400001)(54906003)(7696005)(2906002)(86362001)(26005)(36860700001)(70206006)(16526019)(186003)(6666004)(478600001)(316002)(5660300002)(81166007)(70586007)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:25:54.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dfff94-a65d-46e3-1d6b-08d946dbabf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3912
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The printing message "PSP loading VCN firmware" is mis-leading because
people might think driver is loading VCN firmware. Actually when this
message is printed, driver is just preparing some VCN ucode, not loading
VCN firmware yet. The actual VCN firmware loading will be in the PSP block
hw_init. Fix the printing message

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 284bb42..1f8e902 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCN firmware\n");
+		DRM_INFO("VCN 1.0: Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8af567c..ebe4f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCN firmware\n");
+		DRM_INFO("VCN 2.0: Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 888b17d..5741504 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading VCN firmware\n");
+		DRM_INFO("VCN 2.5: Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c3580de..b81eae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading VCN firmware\n");
+		DRM_INFO("VCN 3.0: Will use PSP to load VCN firmware\n");
 	}
 
 	r = amdgpu_vcn_resume(adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
