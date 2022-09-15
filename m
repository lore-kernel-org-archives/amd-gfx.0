Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD5C6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489A710EB8A;
	Thu, 15 Sep 2022 17:02:15 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903CA10EB8A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiNRGf2JYRdnKash5GUgGf01EYpSoFjU69diG1ORtcgkTRbLkq/3J0q3FvqtNAJpfR/ee6Taw8H43kLlZ/dK4fl9esfK+zJP1Cee3GX12HI/Dt9PTdJ3DN93LaJUzEzgFjlX0PP18RUOk2rlb71pbViKOb8fgGLlMwXZ9cIxDNrncZg5hPUAobNPDnYN3tFrmERiaHTxc5pYFPWkMW8d2t776MUsCEPEpGqCYLMH5VWJ8tI63SjmWsyH5vQn+4bPNtRw598yQgeQP2A4T52TL9UDOE2sEosFjD2+6K53t/9SMnFSOscLwCuIfjmB2u0M5MQAG7kXnAc03ESGzlKgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rydtns89//glESi5LAB6GHsPXCdWK7wX+0Fj6gdpZ1g=;
 b=M1GC3sM6w9k6m/pf3VhzHEgg3LY/dNNVaG05i99PbDp2NBe4ttRHs1rWcI46X4a2P6ZNw8RaSosOq5PKEHbaDOuAHezEuokitWoFtnFrg8N4VNVdH2WQlacjwdW3hoPrUIwT2Robp1tNBFbjfvgswzu74INLdoTN5sarphYxzAAiC/k7KRJjxukRbbMYT9gOHCBCj7qU+/U9XEEUNL7Th6F+p0hyH+6arqUhOFJxwX9We61v4lvQhAQs3TIp5bYXvx0bK2tF3j92IWH1k82okU6MCzrtCveNTxobDnAWxEK/1btrlng6rssYKmMKnco6A74ak+YzNtKTyI9sE6q2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rydtns89//glESi5LAB6GHsPXCdWK7wX+0Fj6gdpZ1g=;
 b=sL21lMlS+HMU8zbWkpwFtI6Kd2ZPlgiaH+M1DF9Pn2UNYGBssjWpNGwhSWM4Abgd7BE4/RZCaKGsieyFCOo4hDRqJDcnrU3fmVjlMSnRWVux9TOU4Pgtq2yV14ECrCrocbIYZ/0LVAsLR2HP0SOBAY3+TeDGENZkiyBAVSFLGNg=
Received: from CY5PR15CA0020.namprd15.prod.outlook.com (2603:10b6:930:14::27)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 17:02:03 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::dc) by CY5PR15CA0020.outlook.office365.com
 (2603:10b6:930:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:02:03 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:02:01 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: add helper to init rlc fw in header v2_4
Date: Fri, 16 Sep 2022 01:01:30 +0800
Message-ID: <20220915170135.23060-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220915170135.23060-1-Hawking.Zhang@amd.com>
References: <20220915170135.23060-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfc0acf-9ec1-4c45-0021-08da973c0325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6dGmEJYNHZBPU5EuzzwI1baZuzoAtV0ANuHjBIr9Kt06ixOYWnN3yOpD6uRm3RKdwkK82H5r+pUKD+CZUU8zeUb0lxTjvMTHwmRpfyw8mD0n7+YuFpAmOAN0sLCsYJWXRHk99SMSxgYZyP1NlXqVowP/5DCuf4to1mpP7mhqR4AF0SRRGzTMVVpZFDFXet4+XRnnhnZs3D8dAfuUdgk7HV/fvLcjKFfjm5mdPf1vpDJvSDn4KmSvvRdD/kNmqUmPk0IhIEfwP2m5mC9Z7qPuWaM7Cnww0O3SpQ15jUSd0d80mJilxwkJZwgSoXSJI1vka22T1zzJjD6CdOiNiuZaQBHlvUku3m8LIIUA9tbiwfa23swJwXSu4DchSb7sByAIPNsVkE342X5JFRtkCtCEMYmWQ1pt1nY34ZOtTgeD16ZuWsulOfP6FEmYwVZlks1FyX5DkMcrLST2CZuAO26CDsntWb9pTYL84+0Pl3gu/eTRJmjOYL953xRerxGCtYIzaLfugkd5AhrzYyY0Fp61J23BOhmoKZDqIq/wuz6mwJeHZY7yiYfYVaGnSH/ZNW+Nq36oHC1m2K1wv8g11idt2U6l60ae3P8/LLbst0U4yPROYALtQHKxodqyl++PwzkYLxxDtjbis+IvvmagNrc5DN1gnluoStAclj6WsGz3ASFWwJMoxEkRi3wnhcL3osPK5uxBccICyhKvxfLjKYBsPcNu46vEAEopqBfWLbLf9URXh6xwOEjLoieqd2fe1R05Eayy5qNbqq5mHvE78Fg9I8FFcUBBvrfHmQpyD54c8PMfcgWLRbO2bCxwF1MnOyD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(41300700001)(40460700003)(82740400003)(6666004)(186003)(82310400005)(86362001)(5660300002)(110136005)(81166007)(26005)(40480700001)(2616005)(8676002)(1076003)(356005)(8936002)(2906002)(316002)(6636002)(426003)(70586007)(4326008)(478600001)(70206006)(7696005)(47076005)(336012)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:02:03.1059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfc0acf-9ec1-4c45-0021-08da973c0325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To initialize rlc firmware in header v2_4

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index adbb9bed86fc..34b3290de746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -441,3 +441,63 @@ static void amdgpu_gfx_rlc_init_microcode_v2_3(struct amdgpu_device *adev)
 		}
 	}
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_4(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_4 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_4 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlc.global_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->global_tap_delays_ucode_size_bytes);
+	adev->gfx.rlc.global_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->global_tap_delays_ucode_offset_bytes);
+	adev->gfx.rlc.se0_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se0_tap_delays_ucode_size_bytes);
+	adev->gfx.rlc.se0_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se0_tap_delays_ucode_offset_bytes);
+	adev->gfx.rlc.se1_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se1_tap_delays_ucode_size_bytes);
+	adev->gfx.rlc.se1_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se1_tap_delays_ucode_offset_bytes);
+	adev->gfx.rlc.se2_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se2_tap_delays_ucode_size_bytes);
+	adev->gfx.rlc.se2_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se2_tap_delays_ucode_offset_bytes);
+	adev->gfx.rlc.se3_tap_delays_ucode_size_bytes = le32_to_cpu(rlc_hdr->se3_tap_delays_ucode_size_bytes);
+	adev->gfx.rlc.se3_tap_delays_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->se3_tap_delays_ucode_offset_bytes);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.global_tap_delays_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes), PAGE_SIZE);
+		}
+	}
+}
-- 
2.17.1

