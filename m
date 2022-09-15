Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161EC6FA86
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 17:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9F110EB85;
	Thu, 15 Sep 2022 17:02:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBDE10EB85
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 17:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tl+RrbUSqUx9iWdSqzEKU8YKxi8madKJXiEpWDpnquCfMZU5Fp3f//RiIbDW0QDN05gqMozmANC0QmJOfIZ9v2jc/6ZTSYpxf/HT+VV5ZFyoO228PCs3EqiVh9DwW+EMgVsk5w/CRldKYehsvaFmlcomJTwgmuB2sRmoYsW6Bt5tj9E7XltUEkmXzOeRRtNPRNHu1Y7rh8+zfuFwXSPqWAp069R0lXhadibe6fCvW9xufxrFSQHtm9+quAiSwywAYjVJtovDrZjO/Arc0vQ+7TzkVR/1Q0OG1A1gYs5sncGOyoNMGemmM5LT+KThLMiy0GsbHKt02x9AHJZUyJRz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPswT334sthfY79U/U/zAt5oDKzSacox2AbRf/UHsJc=;
 b=j04q2noIKcqP6RWjm9y5khLHeAy+jK1G2YG2sBktT6zqedrDEBkebMvGpdOINlrQaOa4oTNREkuzsf7ImONGvahSj1YdtJyMEdNQdrZch+e5UDPZAK5ejrkJHDFTt5NR5lb5l1IK7Rr0R+8fQQqPDshah+l8LBOoYHM2O6s3o1yrNSx6LM9OUftDIipksSB0mYtUGt96NQZbeISs4kZbrsnSKtYUkDdpa0kHHHjjf16/2ZKHIoTkBPH8CxTcgephfBeaBK5xiX0DkC9Js4XQ0n2Ik1VVLYrHdKg1OOe4EujX3yYlz0Tv/U+MFlutDYj9SlpYtGSNv0NsTH2/Aapt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPswT334sthfY79U/U/zAt5oDKzSacox2AbRf/UHsJc=;
 b=25wLRfk8ddVJafvPXC/lESg1h7OlSaNPvWPNfe00FSWEt2y0Wc/VoiPR1jdV+I3vCclYijAm5+t/x5alYg0naOpbZ6Dy3//aJjvjbT55nRR3H0flzcynRQE3YNg3BJzm9tklgu6uCRMo+0i2cFnVDSbbDlLlMGST7jSSVRsR3N0=
Received: from DS7PR06CA0010.namprd06.prod.outlook.com (2603:10b6:8:2a::17) by
 SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 17:01:58 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b0) by DS7PR06CA0010.outlook.office365.com
 (2603:10b6:8:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 17:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 17:01:58 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 12:01:56 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: add helper to init rlc fw in header v2_2
Date: Fri, 16 Sep 2022 01:01:28 +0800
Message-ID: <20220915170135.23060-4-Hawking.Zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 188bfe09-1ecc-450e-4164-08da973c0014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41RdxTssmNp1YDj1VGBLy/kHaSr6M0i9Cw1hMnfrKQKcVh7pYDKCReYWQUL1hAm4wZ20Vb90mQFcggun7yQ6lMgti7cOJNsXdM2OcEGihL98HIlZd0s3+dkShgPkgBCCvwA6c7bgpjxSnZzfi0bPPAHEBH/3vmgAprZOTAO+SIzl3xQvTP6zXJdRQ/gXUYtfLO9xLA2LP6stusWlNm0ftfelhbXaZY5pgSjs4qhs631zg0jx5p394GQH5piP1v97S7TYBnwgeuXFubAWS0R2waHBgZDQvzi0oNK/rVPsmuCtxDJbxBHjbBbVPVpyBksvsYQa4H7w/fNKPcI+SPTMhmxc4mKFuB+n1mpHEspGfQ3tiicdDLrIqb7vjeZX5tUnm3H+9mas7JaebYAFPcEm2aHk0s8W4PwmAhW5eKMleQOfoXu7gUvBUaF2v+qL+GeQFUfllBZ63IYeTCnqvUcJgVxb7v4LVn1XsleREEqBB/l8jSKX9M/kJym9l1eVOwQtcDLUTNhqELZPE8DYdFE/ZKYieFCBHvxU0SV6kSC21UJQetWWbifmqW8DkSgnvqw3HTpBOkE6DoMn4YAsjZ5efFrIIj9+Fw1VDYVhaqd9QwX52inxXyNddWj8D2nwothpCGFZ9tKGgwQ6XPVCBdhKFizjzx5sguHZHdJwOJu6KMLN77KYQrrcOQHL2dRQKAoPGsSxjdPE32tFw+OneKGh5qCQlN88FaMa66hJPUhtI9cxG5xmdLphvD9qetXM2WROmBr9Mw7kdpC1DBdC7z3tnetkIInqX1TybLkWuMIbSLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(26005)(36860700001)(2616005)(7696005)(16526019)(336012)(1076003)(186003)(426003)(47076005)(5660300002)(2906002)(8936002)(40480700001)(40460700003)(110136005)(6636002)(316002)(478600001)(82310400005)(41300700001)(8676002)(4326008)(70206006)(70586007)(36756003)(81166007)(356005)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 17:01:58.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188bfe09-1ecc-450e-4164-08da973c0014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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

To initialize rlc firmware in header v2_2

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index 04bdb885918d..a055818d87f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -376,3 +376,33 @@ static void amdgpu_gfx_rlc_init_microcode_v2_1(struct amdgpu_device *adev)
 		}
 	}
 }
+
+static void amdgpu_gfx_rlc_init_microcode_v2_2(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_2 *rlc_hdr;
+	struct amdgpu_firmware_info *info;
+
+	rlc_hdr = (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_fw->data;
+	adev->gfx.rlc.rlc_iram_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlc_iram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_iram_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlc_iram_ucode_offset_bytes);
+	adev->gfx.rlc.rlc_dram_ucode_size_bytes = le32_to_cpu(rlc_hdr->rlc_dram_ucode_size_bytes);
+	adev->gfx.rlc.rlc_dram_ucode = (u8 *)rlc_hdr + le32_to_cpu(rlc_hdr->rlc_dram_ucode_offset_bytes);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		if (adev->gfx.rlc.rlc_iram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_IRAM];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_IRAM;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_iram_ucode_size_bytes), PAGE_SIZE);
+		}
+
+		if (adev->gfx.rlc.rlc_dram_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_DRAM];
+			info->ucode_id = AMDGPU_UCODE_ID_RLC_DRAM;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(adev->gfx.rlc.rlc_dram_ucode_size_bytes), PAGE_SIZE);
+		}
+	}
+}
-- 
2.17.1

