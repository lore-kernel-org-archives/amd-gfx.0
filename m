Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 06:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73C561481
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 06:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C561481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A495989CB8;
	Mon, 15 Mar 2021 06:45:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A6BE89CB8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 06:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWUJ/Qw3n5aBU1hdKB1fr2FfYoOq/d4wge2DNd7Ok6/6nvsanO+IiujmM1Ak2sn3ytscRkAOcotdtHuZQTcH5EAjzZGzpN15sRT+0arLLfJ7AZIlPWGq1JZPUYnWoLZrVofE95kBDiKGlcEel6rcmTHleEZAy5qNxktcLih/oCUCJn6Qm0fvaGdspb6tHDH3picfFfyuEog3yjD4FOPbkGE0ZYMCq8/rGEjjTXkx+PANzkkAywqA3jp5ijtVVEAi03FU1tZlT1bBRLtxY5CV8AWaqXmU6ClVshDYCLClgJ9LFMEHaosbEU1PiOEqea30K4/jjNUCce4QP+eSUdkxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGFAPawaWDr6LzeOlUj6E+c87EkMz7adC7YuOhLUvek=;
 b=kiSPYk9gbOjL6LE5EwT9X28rIkfWctCWX68eWeuqIV0SoJB/ZBQVO4U9dGYzXXTSs1+sHR9wnrgGjG5y6OIR0oZzNI8q1atiW3CYezxKdhGIkciSWmkdDJjwWC7ACYpi9cJOO1o/O2apT9rdkxHmgpmiaZbXCprldxPO/0M0+KGUGF85Ou9RMRXCeimWTFFqD+euqRLxgQYVJyJ5COLQ5/ve2VrFQYIwm9O3iSB+HNoUkN8S7kBvdHpTou8XKvZxeTyDtN+hNOAbkEMu9KpLaV/dGRt9rTAYudZ02xKhqLFuxNB3fBIQojMmj/vRcHmlOBPS6A23Vj7ATHhYIL1w1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGFAPawaWDr6LzeOlUj6E+c87EkMz7adC7YuOhLUvek=;
 b=mofmG0oBfQntc6JNkLbaCl+c64PjxYZnh9kJ/K7hP2hblQ85dISB9QkGLjtVRsIbcyk+BRSvG3crTdp65uE+JKkVtPUbKKfiZEIMmS+R82/Sy7EoL35iGhAtvQ2BRTDkij75NmzBBtmI/ngnO2THMsfnUmbWoRQLcWbSKO5dyBs=
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by CH2PR12MB3719.namprd12.prod.outlook.com (2603:10b6:610:2c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 06:45:46 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::14) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 06:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 06:45:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 01:45:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 15 Mar
 2021 01:45:45 -0500
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 15 Mar 2021 01:45:43 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use DRM_INFO if VFCT table not valid
Date: Mon, 15 Mar 2021 14:45:41 +0800
Message-ID: <20210315064541.4620-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3506c01-41a4-4e33-3e56-08d8e77df61c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3719:
X-Microsoft-Antispam-PRVS: <CH2PR12MB371933CC45BB4CF663908812FE6C9@CH2PR12MB3719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRZBKN/57W1vVqGrA38xT8F6TJy+/0jddgs3bQpjs3BUYvVO5cgnWEsIXUgJqHuosiXq2VToHg9SwmtDjB6JDANJqJ51aC9q1RcWbBI0xyhyH1+8lONj3F9XoNehgUuDvCPwgC1bvYvUAaan929rVkuK9seTJzFnxkfhSdBwdFuH/KOuxygdn61zjkZXMf5uUMa/krx7YJgEOso/W/0T5RoExPXzZ5K8WR4SgsUruY6wvYXjbkdC5PzpPtnTfKUH0RtCGABze/EfCpqt8hOwMawTlAZtIku28Vt6aipf7CNDODmHn+4nptxGtFdE/Et60p8VrHpivgL+RHALk3ssUSc6ax5+DwVAz4j94Otz4yLIy0bCvMXy8azoKjMUNTUnorNPpBI5VxdrlyGGZbZ1GxsMykakt6a+hy3hn6p+4NlR3BZC+bvn4UJhKfqbJ6IekzA4B09dcfWfkEnfNFMBAs6QY3eZ6kKp1XWWOOwf414FIQ0MBlL6kn1aFHv5C62pqNRysssQuoDW4P4menyf4Cew6xBaSD0cNY+s/+CGlczYl525Vnn57slBY8qc9XLL0Hda/Vlv4zmxnFUjtDS1rA7srrzC7t3WkN4Qrw7yYcAYenpOCeQn+wBb41d1xigESHTTp0NiuMFs87KR4UlYjQeMKyD/JrFFN2qUQJSnjcVMYPsnQCB4bbmtL4YInQ7e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(316002)(8676002)(36756003)(478600001)(4326008)(5660300002)(86362001)(336012)(186003)(7696005)(54906003)(47076005)(1076003)(2906002)(8936002)(70586007)(70206006)(26005)(2616005)(82740400003)(36860700001)(426003)(81166007)(356005)(83380400001)(6916009)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 06:45:45.7290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3506c01-41a4-4e33-3e56-08d8e77df61c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3719
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

Some ASICs has no GOP driver to copy vbios image to VFCT table.
In this case, it will go to next check.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index f454a6bd0ed6..dde27b26a735 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -320,7 +320,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 
 	adev->bios = kmalloc(size, GFP_KERNEL);
 	if (!adev->bios) {
-		DRM_ERROR("Unable to allocate bios\n");
+		DRM_INFO("Unable to allocate bios,skipping\n");
 		return false;
 	}
 
@@ -368,7 +368,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		return false;
 	tbl_size = hdr->length;
 	if (tbl_size < sizeof(UEFI_ACPI_VFCT)) {
-		DRM_ERROR("ACPI VFCT table present but broken (too short #1)\n");
+		DRM_INFO("ACPI VFCT table present but broken (too short #1),skipping\n");
 		return false;
 	}
 
@@ -381,13 +381,13 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 
 		offset += sizeof(VFCT_IMAGE_HEADER);
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image header truncated\n");
+			DRM_INFO("ACPI VFCT image header truncated,skipping\n");
 			return false;
 		}
 
 		offset += vhdr->ImageLength;
 		if (offset > tbl_size) {
-			DRM_ERROR("ACPI VFCT image truncated\n");
+			DRM_INFO("ACPI VFCT image truncated,skipping\n");
 			return false;
 		}
 
@@ -410,7 +410,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	DRM_ERROR("ACPI VFCT table present but broken (too short #2)\n");
+	DRM_INFO("ACPI VFCT table present but broken (too short #2),skipping\n");
 	return false;
 }
 #else
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
