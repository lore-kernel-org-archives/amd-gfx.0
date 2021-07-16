Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12901C636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C353C613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C353C613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7004C6E8D4;
	Fri, 16 Jul 2021 01:25:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D07526E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXxZzWnkHZjss4u2Ffd2+FcwmpHh8WATGlghg1hZImc5ECuczIEzWW26lsGZfqdIJawxCAsaDO+9g/mXcBCCxgiu5ypUgGkUKy3jSQ6mUya3vUBbNJBUfpxAo3u7gTzRUvoJh8dJwrD3CDY4CmQye/UYYkv2wROdt9HGHs4FL3eaDi4RuIfeRNcY4N5i1xCeLNGiYVCBVfQQfu8tKCokvC1xAUd+Gb3Il6DDf73Qc1DusNiNPLQPg9TjBe1d+3sUCFfar8CKeTe+cETifPFXzS2AsfiPjursFtpW4pV/NGv8JcCKcjqUQSp0L1Nx/nc4A5UZH2Iw+dAa/tmnfThUrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/SEdkLdrBxO7lq27zNDbKDSV1i2PGejrWkn08pEN/U=;
 b=NEnBD8awQy7akCicR6Sx4OymdEDwgO82J5kxl8k+gl0CeiA9Mbu14mAKqxWPAR3n7lT+Sa8qq//sY8Hog/a20M8aQRwNtPtjw6EJEr4Ol6kykh8na3caBOu13mDJnpXUvGGvmH4jGmEQ0yo5bzmGptZYffpk77pn86xK60WufrXOB2o9q3lWXGSwNMBu++ppfUz+TYcQTjL37awW9N/QxxOb4SDm0vqG40hqDIOv7gEXAH0h+RUn4Tt/wpdHFX0/wAu0vnT3VzzTn7jWQMdwduST8g+/eJd5dzLl+Mfae+JR7WvJql3KlSJGvsPZkvyeKpn4HyU8+GEgLR2JgiO7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/SEdkLdrBxO7lq27zNDbKDSV1i2PGejrWkn08pEN/U=;
 b=CKaG+MSpSTbbGcR3JE7RlYV51Fd2bYvB/MB1zLJDIpUtc07g7UXizHAojO18xBkuGYjMHcBpIVtbQwxUAEB3tWLD/cR7UN+QAGxgx7kZAMSUJwy0PplKNR5sY2Kpvq51zPwqv64u0zs3Q4oDpLgat0RdtZCBjTvex6sP8ZA3AIk=
Received: from BN9PR03CA0248.namprd03.prod.outlook.com (2603:10b6:408:ff::13)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 01:25:23 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::b0) by BN9PR03CA0248.outlook.office365.com
 (2603:10b6:408:ff::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:22 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:21 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Fix a printing message
Date: Thu, 15 Jul 2021 20:25:11 -0500
Message-ID: <1626398715-6419-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a48b41-8b35-42d4-e093-08d947f89536
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708B63A0E3F2CE968F4364880119@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySlFetQs2SKVsNkMGyA9JWHaz5eJ/Tlb9SeV6vVDcwGylhbj1YGyFIPEvA/XhECVOEjUFBh4rEcKgcTS3HxGE2RPMrK9JyU56t4cE+ivbwOUJPRI2MMLud6N/ONtZZOX+QNvHrFVVZiHH3HWGFEdC17Q8Z8t72OrpQsNUg01JKDiig9k7o5K+H8Zgqe3fXU+F7Trt8DC52XUhUxX/OVLb/WFORSs1/IhOVqn3MBJ3xNwp6lD02sf8fBXVvQQi0X068NusQ9h2BPJFcXgNCAm3pxesgsdF0sUIdkOlvxGFZYmMULo5nko/WJbWDctTTtBnUXZrH09JWuIQz4lmH4+zlvPQGl+vuSD/+5lE/xJ3Wg8dbPwcBPxPWjKNTNNMiqMi1Kjw6KtLIWKUS+I67cj9KmkUpiWhk6a7KfTfbCfYo21bLqVp+TSPyfiCu+gNpbB1CHwq73coATBhaYZkD2h3rl73HMWNcQrB7uDzcue/L2F6qbSArzjm1+f5eNhZlAxlHo+HK7z8mdr4PrJcYOxyONYmmE15wKyjAZsjVVG0y+3Y7WzBqquXOWbM2wVL0oQRsRMeGOS0kCMT3NbMUb/jD1i+e7XFOlfWPWgu/4FyZFOxKypn3WbXRpM3fqv4mm+DtCs6EJipAvmDc1vOojKanKXDBPMPiinv2R7KBXkjLibldfmSMbhQkTr7IZs72sGMi0k7ourj2N7bmfEJr7yeB74s81diMxl41woMO9ebnw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36756003)(8676002)(36860700001)(8936002)(2616005)(316002)(54906003)(83380400001)(2906002)(47076005)(336012)(426003)(15650500001)(6916009)(82310400003)(478600001)(26005)(70586007)(81166007)(186003)(70206006)(5660300002)(16526019)(356005)(7696005)(4326008)(86362001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:22.9929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a48b41-8b35-42d4-e093-08d947f89536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
