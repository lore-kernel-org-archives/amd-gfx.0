Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0422C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 09:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B8C64EB2
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 09:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B8C64EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016CB89D1D;
	Mon, 15 Mar 2021 09:11:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C3989D1D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 09:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5tc1UJ3ULhan2Dt08snC3ZTPEwr1o5IHsIXRiKTRJHcSpyKXQkU8gDIkvcojF/dKPCWUHbsGvxefQVuTVh+WRagqC6AfjG48Zl6ytysV5w1AQP+P785UZfbEDdh1J65d4qOzCE8nmycxH4O5tqsesNp5lkndf8c7km+T5XtkIC39AQv1Ooh098F4YMATiAEJAiCQFCc3KSRqrtY1c5fmuvj0b1H+YJxZou+ojLIzRNcyT3QYNEHhLUH3Y007WGHPGzpJ6RNo24/mlk0Kg6ZzrsFsbai0k4Scvzoics+f6tekJT+UH1xikwGB0WMfLI92iB4BmPMuypioLSlZNCKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytRtD06EgmZ/KDoTLkn9V8Iiq7Xp8qs6l5S1njRp9Sg=;
 b=NgUxB0iYXkDYaICrW4ScDpHi8CmVZqL3bo5T7sKASeJdKWTL8nwR+fybwH+U/MxJUgnFaJ1jGpBIcoKuD0wIw/iC+MnMtF6U/pohq4T59NH5jwdzKirOzCTUbI3pUROZ0M/FeVvLWkmbUAfE4+jkZXdofEWB4IupG2Ainld21nuAcedRXPggQuWT1zQBTm1WpYzPA3swWbo4HugHWNuiskwvBKy7ObaVcCUyhpb8vUjklivNMfNzQsO+DaP8rKnjUeK69Dv0eyOa32qawVsGC8oA+xifuhb7pbHmp0g6PYS66gGKBUqbVluVbuJzGiQH54b5v8juXWwjEj279zQmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytRtD06EgmZ/KDoTLkn9V8Iiq7Xp8qs6l5S1njRp9Sg=;
 b=voGFkXDPVdDEGdDPWxdCzKZxROR41Rw44+WtiXfl6Ar8yLVCeQGAYkt89bi3dRFV+VbDVuwYuvXNv4dsvZ1O8xbFt1Nsbxk77KrkCX7UhEbnxZ3BIFn+M7z4pGGEFM6ZSVK85I1lgBawmNjUJKL1RAi6HghBCm2m5j7EWRum9M0=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 09:11:14 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::c6) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 09:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 09:11:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 04:11:13 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 04:11:13 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 15 Mar 2021 04:11:11 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Use dev_info if VFCT table not valid
Date: Mon, 15 Mar 2021 17:11:09 +0800
Message-ID: <20210315091109.18574-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4721904a-00b7-424a-aaac-08d8e792489b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4581:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45814A773F100054DC40B44BFE6C9@MN2PR12MB4581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxqZFEDfb986oT8xD6TU5Qj5Zkgq6hG2F7z082RbR+yKB68oeXNnr/g+dNJvsRimuba/sUyEtKFyy6JD5CS0HhZi1dBahRivA1OnbfwKN/Jx/H7Q09MNTmWVzKWSrgpKNhM/3hBgEvkqF50BBPMdZqP3vl9f2E35g0yNgeuR9JdFnuOMaTj8RL+8T8XBR3cbH56hifwLg46GSsYVkCb4+Fz5oERaIDRSjFT3dTv3zXLkcUmRt6KC6nqCZ7ooitd6hrTzHuYni/+MFCS8JfBilVA2aJvkSixWcT4oUKJtfNvxuABdDflg8FXmciU+g6BJI1fjEyL1NOoBUR1aRCY0cP5HxpkKyZcOrkSl49ssxJtdWkiNwk5xG5VyqsUw5v2hSrxlKYroam8iLJpnKee3TY91aBZYWZbnvP9TP2WZtU+otZVbCJ0OoCx50dvuTpQ4g/Lbsr83TvmlcR7eK4pdz7tFrYA4T3XdejKSugrGrZP/w/0tFEH+X91pL88oGy0XzdRkD5vATSfOnnADjcRjayzbZqTQKQNp3f2rfw5wdKr/gYzFdmhWQuTXDT47Xo3rRc2qJ4VBRWkkAR7StroUPnuGkkG5Adwj8LqVlpXzBdZbpVyZFupkEnxmeDAfYC03GM6Hxdw83zpsgK2tvACbNaS1fTAAnBpfu8QQMwTvAidnSzw9oH6r2Vp7i7DBKwHG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(2616005)(5660300002)(70206006)(82310400003)(86362001)(426003)(7696005)(36756003)(70586007)(186003)(8676002)(81166007)(36860700001)(356005)(2906002)(47076005)(83380400001)(82740400003)(8936002)(54906003)(26005)(6916009)(4326008)(336012)(1076003)(316002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 09:11:14.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4721904a-00b7-424a-aaac-08d8e792489b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: Alexander.Deucher@amd.com, Feifei Xu <Feifei.Xu@amd.com>,
 Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some ASICs do not have GOP driver to copy vbios image into
VFCT table. And it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..a5e98d0142d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
-		DRM_ERROR("Unable to allocate bios\n");
+		dev_err(adev->dev, "Unable to allocate bios\n");
 		return false;
 	}
 
@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+		dev_info(adev->dev, "ACPI VFCT table present but broken (too short #1),skipping\n");
 		return false;
 	}
 
@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image header truncated\n");
+			dev_info(adev->dev, "ACPI VFCT image header truncated,skipping\n");
 			return false;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image truncated\n");
+			dev_info(adev->dev, "ACPI VFCT image truncated,skipping\n");
 			return false;
 		}
 
@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+	dev_info(adev->dev, "ACPI VFCT table present but broken (too short #2),skipping\n");
 	return false;
 }
 #else
@@ -457,7 +457,7 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 		goto success;
 	}
 
-	DRM_ERROR("Unable to locate a BIOS ROM\n");
+	dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
 	return false;
 
 success:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
