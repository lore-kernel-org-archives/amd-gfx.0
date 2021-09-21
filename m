Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E9AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4A060527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B4A060527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5126EA32;
	Tue, 21 Sep 2021 18:08:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD59B6EA98
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqvFLPZAOpcNjsY7WIrzo1JlCVvp4Oxw6fPTBaeFPBlr1Gp8uuxZsFFsbi0e0+c6azbmOL0Js3fm+JG06sozbAgxqUU+xrkL5QeP0QELD0TwKeoW5INNAZ9qR8rMYL8RlW5FDAetaWEQJbNnFjLk9Bs5dibNK4ddaw9MDgGm/Gz2hxDfI36EndAEE85264iFViNS2FDsPiZE6ewEX6glOI0sX2pnX49TBYgl3so6B0Fz+wCcxWeLK2xs4Hg7SsTlAkD/h3R1K+C8Ysiv1pGGoMo+s70DqNo/INwekr9Pjd6dOpf92lFcLfrOdiHUVq1v6KBRZCgOL71ahdSvsnydTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MZVRsjuUEePLG2WrP6hkvlRPEq5aSPLfz7eTl9bBXns=;
 b=SkS37ZnJ/euG8jR+UGJV6ImkTD8Yovc6DE2qrBhqa7bqFu9ErG/W3ZdiAwdtmVXEDlK3GH9p3lTUCGrbKXAGlHa/C3lRcHzuVQ1WXGjs7EEYE0tSkHVTwaxIUT8gtJlyNnnUkOugdhwhFVsasUO9FNSGj6vzXcEadmNTCOhXMd6FhSJou9WAYLMrSCaFQW1s9W1snT0q0XaucQLqu5tf7XIiKva9VkyCuapgx7V/9b3nsyMJa4K8gGleUudVdeHmFjSJWdAMd9kvuiTgx/PRG1FXk8C4xXNy32DF7hFmZd6vap+gkTCATLAkw3hJoRaLBjKf9NgJNkNYZRzhrTS6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZVRsjuUEePLG2WrP6hkvlRPEq5aSPLfz7eTl9bBXns=;
 b=D9YX3Zu7AVoNPYDCWmEnJfSGEp+UU9dOs6kXs6wG4YjBNRuwpfj7WBMArk2pgtoVFieXBjQoYRo8mdZcjBaOsxOSOsGF1GVS8mEhKr8NN4DhjNcZWZwJuF3vQtk87FfHmji2jX8IZ8Oc5fnUJM3xuqgH35qoWzH69jOfmCAwnMU=
Received: from DM3PR12CA0060.namprd12.prod.outlook.com (2603:10b6:0:56::28) by
 DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:00 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::d7) by DM3PR12CA0060.outlook.office365.com
 (2603:10b6:0:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/66] drm/amdgpu/psp_v11.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:07:01 -0400
Message-ID: <20210921180725.1985552-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c9a61c-4acb-4846-fa85-08d97d2abfae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41382C9AB265D6BFD26D0A7FF7A19@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8MhI5j+EoV/OnG6O97s+SchxXSat5zzL+dc7JWYPeOa6BdgS+EArYGBKoeeQ1Tp0LHSOwASdkKTJEUWp+1V48slg893tQhhYnE02/eSgpQiadEyjuaZBsX+/FFfKfX0jRLLIFsjSHKf+3kBNnDBKtqKnqe+evPw4F8B8w+/rmrFuxDJiQThSyv7Z43QfCjd1Nev3GxQm7WdiYkQVyZwQf9om7p3wZWwJmsZYnUULOYjp1+68SNxYBVea2ApuSIbtg3zSIgpPKa9q97da3D2q62oOdbZQWPLnqeVySJ3FQvI/KqKQg3ZO5YJSed4DicVOnu/dniCiXmFVF584UtReD5h488QRkaRp96wzScVNShb2yVNZvm6TIvIihLjmW9RH/IULkZfg/eOOKzMMs3MMKwZ6FCB7yyQlV8xhbwM/cvWC0GjcT4L08Ds08uOmWKL6Ug3Vm9aVMX8DT7gIBw78fz9bMXvW8nuEY3l1uuOxBFqbwW3G8+XYeb7zrIUOAPZlEkgfMXxfOb9f77T20TXjFkX3GMKHY8/X1WWkli9Yk2AX3rDdS64UCACxUloKzFFam9HK0lw4nWkWQmvNBOWhEgo0MZUqs7JTQCaIDAGfSZhy6zVeWJRKeWs2RoRd3T43wPWo3QNSvc9XzWYtO8DDHeusHK70YF+pOCWhoc7gEyrdOwr4mJfG93q7e1/dR8V9nILqTqrEwfRm0vu5wfWGROQCBU33kHt8jHe6ygnSZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(5660300002)(4326008)(2906002)(86362001)(8936002)(6916009)(81166007)(356005)(82310400003)(47076005)(36756003)(508600001)(36860700001)(83380400001)(2616005)(426003)(316002)(336012)(8676002)(6666004)(186003)(70586007)(16526019)(7696005)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:00.6780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c9a61c-4acb-4846-fa85-08d97d2abfae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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

