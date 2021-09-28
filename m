Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F61461266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F61461266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062546E8D8;
	Tue, 28 Sep 2021 16:45:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933696E8DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6haIKgrxICwxU7MSbcC6dgOdpPGyoxdsQKOW83GMziU00vRe6YVKru6WF2Qc3R1sFkaQMnv25CLmAz+IIBdAOvoZIKjktq17GtrwWM7629EK0+rDmzuXqtMHooc5wTgTdpPjJ3QANu/cA9EY+6zJlMLNIJcSqaFDb7n0xejp6up5QnjGI30+W9T/FTM6vtw8cEaPSv2Ybo+yLL16HK7YPRPNdyqmuO7wjyeCAd30spPdfjIQAH123NVyK8+9UtQTWrO/Nk+VoMezBsGLwXyUOHw8zo59cNZJDXQcNy7ypc+N+bBo7xcmchbIWxaBKhCJTT2hEt0oaaeDoKgz3R2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=LJrQ7Qt31W/yyacMgoRGj11XUI4zpl3y8d2OUzbrCe4=;
 b=hJZoEOHrYhnc7CG+P4ku7qq80osgg4fV00FkhrWDCEjqhjXMLmQKDeSZ7STm9J7uCkgKdvxvIFQegE50S5faogSSkdgGt+Hp11b7g7xylYKzMrGhnsCTS66QOX+SUd9YgnZkT9k1vj5IaXH+X6CSeihjGOYD4VFH/ul1GxkpkyK7ULVOZgTXXWmCkEYQzwR4m8vQNtr71k5cpID4sq8+YbGXOSyq723+j0fSsvkB3a4uKSOPkMVWXlF/c2uFhP2HRHRkS+l4ii57XXyIm20gkmbf6ddCK8lOtN617wDNz/WFTa96LPdqihAhdnnfmd4w7MgjLpH5BV8AkHfSgzLdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJrQ7Qt31W/yyacMgoRGj11XUI4zpl3y8d2OUzbrCe4=;
 b=wJtT1F/uCqHASPxDMeEZ7ziO7el/PU0SLrSWSHgtv02LcNPOMdF4eyp0kCzjRwikYv6D9wa41pjFbU2Vez5SHde6jV4B1i51L6UyWp7lhhJrJ3HO9PlKWcIDWeXlziTvatwEJgIy/kuhzjISCpSK7oUcNs9nUm+WyKYd/rPPNjg=
Received: from DM5PR07CA0127.namprd07.prod.outlook.com (2603:10b6:3:13e::17)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:45:29 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::51) by DM5PR07CA0127.outlook.office365.com
 (2603:10b6:3:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 41/64] drm/amdgpu/psp_v11.0: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:14 -0400
Message-ID: <20210928164237.833132-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04af6339-fff5-48eb-0581-08d9829f60cb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB452814FCC0F731F801D9FEC4F7A89@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a5Jq2ti4xfSM91H6xOxAFlYAR5AnIA26mj6eDuLAMGPBokYpwJ0aSuNYVjA4wI3Q5woBntQupAr/9nJuXp3L8Oz0uPvx500YfrczQh6ZnYl3qExsyG8QeuH/QWv0ZeI2+MIACzyz6iYvRmQjf8UWpD9HcFU1u7xM8TOg4lWNh99gmNpUIcjCRiPoI7jS1/BrTBf59+wXk5Wd5ziIQP6fCgqtW+zxF4o0GJ76Q+SEDYTPmY8jAcUnPaa7CmEBFsEVPHzhlKHumJ/NHXOrPdGSRJlpfLYymDi4lZYyYvyh3oqfNsGGMBKSrq/PD8dJmYgoo/uHe+7H4pI++G7WnYSFFFg3/R/yshE68+yxcdZyeZI7uvilJIsex1j59quiSALhBuK8TJGmR0iunYRSKUPEOiYGM9QKYh2N2yJCACYsF5K9C8JHrHZsf+MqLFMgNODFjX2EJGu+EQ6c81tYwWlQToEfmKz2pP8gjcwmVf0JZ5+JLFyY9sib1dOZHX5OoHZfJj750w2YkItH6bXykROaBQ39mLk2NPO/aabVzL1iRFmQEbDOt5eg3lI8AlRVe5m+VkyeR4bUka8JchZ647gAPnBGiZ0m42BHnMBUJWNSvfWRYHfukr52nOFApgiTy2IIuiico6nBz9/GQVUhoHSzus5nIlBHLkeOR+W1hyM+kmIKhllJtIw3qugY0k4LHcPekTBpEVMCDbDvqwxShYi3rH9D3OEWHCIqGt/fPmy7tQY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(6916009)(36860700001)(8936002)(8676002)(54906003)(316002)(336012)(426003)(186003)(16526019)(2616005)(81166007)(26005)(356005)(83380400001)(1076003)(70586007)(47076005)(508600001)(70206006)(86362001)(5660300002)(2906002)(82310400003)(4326008)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:28.4245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04af6339-fff5-48eb-0581-08d9829f60cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 3c02e75fd366..13dace5d2855 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -93,35 +93,35 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 
 	DRM_DEBUG("\n");
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(11, 0, 2):
 		chip_name = "vega20";
 		break;
-	case CHIP_NAVI10:
+	case IP_VERSION(11, 0, 0):
 		chip_name = "navi10";
 		break;
-	case CHIP_NAVI14:
+	case IP_VERSION(11, 0, 5):
 		chip_name = "navi14";
 		break;
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 9):
 		chip_name = "navi12";
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(11, 0, 4):
 		chip_name = "arcturus";
 		break;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(11, 0, 7):
 		chip_name = "sienna_cichlid";
 		break;
-	case CHIP_NAVY_FLOUNDER:
+	case IP_VERSION(11, 0, 11):
 		chip_name = "navy_flounder";
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(11, 5, 0):
 		chip_name = "vangogh";
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(11, 0, 12):
 		chip_name = "dimgrey_cavefish";
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 13):
 		chip_name = "beige_goby";
 		break;
 	default:
@@ -129,9 +129,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 	}
 
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 4):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -168,9 +168,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				le32_to_cpu(ta_hdr->ras.offset_bytes);
 		}
 		break;
-	case CHIP_NAVI10:
-	case CHIP_NAVI14:
-	case CHIP_NAVI12:
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 5):
+	case IP_VERSION(11, 0, 9):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -213,9 +213,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 				le32_to_cpu(ta_hdr->dtm.offset_bytes);
 		}
 		break;
-	case CHIP_SIENNA_CICHLID:
-	case CHIP_NAVY_FLOUNDER:
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -223,7 +223,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(11, 0, 13):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -231,7 +231,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(11, 5, 0):
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.31.1

