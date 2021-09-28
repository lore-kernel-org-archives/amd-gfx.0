Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E78C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65CD61262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A65CD61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421846E8DF;
	Tue, 28 Sep 2021 16:45:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37146E8DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzyuUr6e4CyV3IDVeHt2hi3dINN5bFbM4s0+2JN2WzCO5Bdl55hE3kUyvsCmjRxORbgNPbJDeHUDr5qzMSUi8nga6QzGXsGDD/P792k59AoB4IPeakrzaVk1oy8qkuFLioWQOVXRDKZTnMsludEUGh2PKd6xdtdzHzDPN22w48LLsn8ZHKsGxFu3lUvT7PPW8HV2G0Bgj2CZyc/qAh60fCyUNfF1BnmDhS57NKTJ2HrdBuwqZdLoGAvnSq8IAHva3OpGBkhhEbHOR3Ps635AUqCCJ7zM0NQT0vEpWpMr8aMw5yj+WFTnILsBZVSK6Dxai9liMcbgS9zn28QMyxx8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mej7GS8+WcuUB9p3GGOb+07xuVH0WZX+eu5W+aTY87k=;
 b=DgZmzrJVSiQPYc+Ji4KiA3LP5A16zQk3ydpRoJZsmKFgQZjzlbSgy2iESyT7hi/GUOEwF3+8JtA+6tM8Lb6NeSIKP+GVrlk1EtPDxbwsCGBPPzGYr2uWpjRpOqQogH3Sc8Fj5EyT+ZDVYrd92Y3QV/pS3BVCP0xsSjY8q6Ptxx934ANaL401cAsSz7+GdyOI+CkY/C4rpyXC2j8ZlBaa9C/qWAQjiBXDDmXtC7xbUcXDnywUwkNBg8hXYcWI1XjiTO/HIbpDX6VaOvQop2sZitu9u0022vt1CfwxuKmUUXYLUt/npCgPizmwJlN5KA/k9jsjTtvDf1MP5JTxKhNe/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mej7GS8+WcuUB9p3GGOb+07xuVH0WZX+eu5W+aTY87k=;
 b=eSKsPXig3qcGfrexCoVn6HsAHJaKDAT61Q7pbjndtxAYNJz1S57Fzb0rPbDlgP0Z8z4hDKMlhSLaLmW1HOfxtoSXKsne0hL5WpRpJ/nimUL/+ohy7UprnNQH2tGjLAF+yLPAt8VHKPoHzQdEjyF0A70N9Wox6T7i/Tf/JbE2rJI=
Received: from DM5PR04CA0044.namprd04.prod.outlook.com (2603:10b6:3:12b::30)
 by DM5PR12MB1898.namprd12.prod.outlook.com (2603:10b6:3:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 28 Sep
 2021 16:45:46 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::c4) by DM5PR04CA0044.outlook.office365.com
 (2603:10b6:3:12b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 46/64] drm/amdgpu/amdgpu_vcn: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:19 -0400
Message-ID: <20210928164237.833132-47-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddd1d02e-42fd-45d3-637f-08d9829f6b61
X-MS-TrafficTypeDiagnostic: DM5PR12MB1898:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18980165564C875AA2EC55BFF7A89@DM5PR12MB1898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSfvsxnDtZeZsU83wMjMlkGPIMZa60fV8JfXX09jGEs35wqzeOlCzy3rpH6LJ40aWa8tCKUzFRwJi/d5JcSfvduJhTZgTeCMzhzvYiNcrOasMuNcaK82eeNKpCtkIEllXHz+tBNelBhzbEEiiHpjn6V43rWLqkO9yZ29dyhV8apmZw+g3QndrfEQRPWRkRlhiXLz/AsBbcMdMJKLfxK650HMPXFw7upVQ/km6ctP+grVuiq8ArINOpUl2KVjxkND1h86SmDtdF8BNxrHpKwcS2aP82GCTzvYB3UPXspoTkh9aM2Y180uaH3QQcScQKXiIjMpD4rgV5NKDKVHTGG2O4vbjVf0zSS7QybJ0TdsazCH2q+xq5/OAG5X5P8JO11edBMA9Gf7d0FdwAXAbWtmJ9YEu1bgEJLmpj2Xl5TBAovtb5yRWrOIUNMCYalPVDyhLiNoYhKpq9zaufOUlQBE9ax18/NxNtYzjR9X5sEefdqRCfGlRmWodmgTl0tYvlXlNKeW244IzJ7/36FfdlEKzVBojxOPTQsMpRBRPbJkzNRX2obk2T0m2YpDzvpT8Xg3K0UCvSs345ND9c1oZ0b01K4f0N+hGXrqG6w+jGynWcxNAQnKnVi5UNpy6afALuxVWbaDdpNgP4DBBazq1frIhoMeIZw1EuySSpyqRqhIcUPqmK6aZvqbLbRilI3ayE8vcYQrKCNTzp2Rc0HWbLO/jQzvWWtXNGzE/zJKttLPfk0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(8936002)(16526019)(8676002)(83380400001)(6916009)(186003)(356005)(81166007)(36860700001)(426003)(36756003)(70206006)(2616005)(70586007)(86362001)(26005)(336012)(82310400003)(47076005)(7696005)(54906003)(6666004)(1076003)(2906002)(316002)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:46.1801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd1d02e-42fd-45d3-637f-08d9829f6b61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1898
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

v2: squash in fix for navy flounder and sienna cichlid

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 +++++++++++--------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index b60b8fe5bf67..9724f5f5f702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,8 +86,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
-	switch (adev->asic_type) {
-	case CHIP_RAVEN:
+	switch (adev->ip_versions[UVD_HWIP]) {
+	case IP_VERSION(1, 0, 0):
+	case IP_VERSION(1, 0, 1):
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			fw_name = FIRMWARE_RAVEN2;
 		else if (adev->apu_flags & AMD_APU_IS_PICASSO)
@@ -95,13 +96,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		else
 			fw_name = FIRMWARE_RAVEN;
 		break;
-	case CHIP_ARCTURUS:
+	case IP_VERSION(2, 5, 0):
 		fw_name = FIRMWARE_ARCTURUS;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_RENOIR:
+	case IP_VERSION(2, 2, 0):
 		if (adev->apu_flags & AMD_APU_IS_RENOIR)
 			fw_name = FIRMWARE_RENOIR;
 		else
@@ -111,58 +112,52 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_ALDEBARAN:
+	case IP_VERSION(2, 6, 0):
 		fw_name = FIRMWARE_ALDEBARAN;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVI10:
+	case IP_VERSION(2, 0, 0):
 		fw_name = FIRMWARE_NAVI10;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVI14:
-		fw_name = FIRMWARE_NAVI14;
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = true;
-		break;
-	case CHIP_NAVI12:
-		fw_name = FIRMWARE_NAVI12;
-		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-			adev->vcn.indirect_sram = true;
-		break;
-	case CHIP_SIENNA_CICHLID:
-		fw_name = FIRMWARE_SIENNA_CICHLID;
+	case IP_VERSION(2, 0, 2):
+		if (adev->asic_type == CHIP_NAVI12)
+			fw_name = FIRMWARE_NAVI12;
+		else
+			fw_name = FIRMWARE_NAVI14;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_NAVY_FLOUNDER:
-		fw_name = FIRMWARE_NAVY_FLOUNDER;
+	case IP_VERSION(3, 0, 0):
+		if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 0))
+			fw_name = FIRMWARE_SIENNA_CICHLID;
+		else
+			fw_name = FIRMWARE_NAVY_FLOUNDER;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(3, 0, 2):
 		fw_name = FIRMWARE_VANGOGH;
 		break;
-	case CHIP_DIMGREY_CAVEFISH:
+	case IP_VERSION(3, 0, 16):
 		fw_name = FIRMWARE_DIMGREY_CAVEFISH;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_BEIGE_GOBY:
+	case IP_VERSION(3, 0, 33):
 		fw_name = FIRMWARE_BEIGE_GOBY;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(3, 1, 1):
 		fw_name = FIRMWARE_YELLOW_CARP;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
-- 
2.31.1

