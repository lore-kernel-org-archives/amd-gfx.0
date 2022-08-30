Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6969BECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430FC10E399;
	Tue, 30 Aug 2022 18:40:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD1810E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkTG7P2sDRNBWfpM8AJbJdxirT37Ed9rY2vRcupCMftgbdWHf6Eb7lK9jda0hrF8mlTFnijKixMGaoYpz0UM5S2gqtu0UiRyUKaIT/yzRti9mRmDyUsBq76o2SLBjJR2N4lRRkuotRp8nUBehvzcHGzQiRXVTlHnDMI+XTqzTUanCksSaecA+OElqIzJSAZMmDfX6CnPPPhu4p7KopL1ciDYBdZrbm1V8H1bS4mPn6d45V+dXtdvCu0MG7bsxMd7AcWiFxIwVb+YsXOzG8VrVfLv96V8JZ7K54dsb6xUT0twv6xanCIXar0pGN5mtFiXv1ffuwV50TqJ3wYh4eMh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqEz/Ooxxcz7P76xI1mHi1GR1hJWtxKezaz79eIu4U0=;
 b=JVI4pTbHFlBOaq/MtajK6PlpnzzIjdHwiefPaK1TFct9+QCCAKlrTWxdcfBdG4+iOLVcC5S1G9UrlASO05zOvR9gTNFlK/s1k9m1mJDlqtjnG/5QHlYbna1R5z2bqEyyrfnjiM/QalE3lAqYx3dPbaU4JgnZgiRu83SiuH2Qv9kkPcdIsvDVMIMRza+UIFJ8Ak6qzhBggP4GtuciwdfdW7+F82QsFKwQGb3o25T1q4KW9HroCUhuJKAApQku7FHV8T+orVq1EzqsKeUzsRCKfudDI6jMmHafT318JMdIFY26cilcnYkWXt5s9qYi/l2RQ2AnJAeK/QocNCHgw84XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqEz/Ooxxcz7P76xI1mHi1GR1hJWtxKezaz79eIu4U0=;
 b=vi2Gt1FBdD7naDQdubs3pQ2VWFtHEb2ODcbd7q7tlprj9Z6H/xZgxhAgv8sShWMua52P7YjwBVQ7wrsokxRK7M6s17DaU42EAt4WE4e/XmZ/5wkAvG0OaP7bOx/0zpkNHgxfQxRCyvNZosbeBPIDKXbDCUwJ3n4LMlAqCbP0NE0=
Received: from DM6PR02CA0078.namprd02.prod.outlook.com (2603:10b6:5:1f4::19)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:30 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::6b) by DM6PR02CA0078.outlook.office365.com
 (2603:10b6:5:1f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amdgpu: refine virtualization psp fw skip check
Date: Tue, 30 Aug 2022 14:39:58 -0400
Message-ID: <20220830184012.1825313-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5194181-b2a6-49af-b4a8-08da8ab71d14
X-MS-TrafficTypeDiagnostic: BY5PR12MB4902:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFMAAd+epzIz6Oyu77hCxmOG9QkCnAdfHJSXdP9Dd9IA7udpYB6nsRCW31gzaOa3c+n0fAkRWrS/sgdZJCvEmECmr4sC6t9j2zEDv/oh6dON1BuhFyqn50vB/Vc+u/vPttQ49b+0fLl1gwMm8L9vXKRzdJBBfeujZjTMXBIVsvjLkPghwDuRXskg3Mswu0iO2X4ASTDaIiXkB0X444QX9bYqbAxp80DpQYXa8RhWMy9oXZACnpIjU01lr3WIkGwbirpHsFcRidj0ngxWieJHY3rrHlLMyVK59HqjpNcULxTnL4RvELS0SWGKb6tEHwa1d/rDF5fUNeAxT17OdhyHEKwgXLj+mURib5A1oHrTPq+7KTYkk+UXCn6wsavHVzNiWDSFKYFjM0+kh/aEVGxvNS5qXpUArDdqP1v44WDXZy7w5KTvL+MqO8he33uJDwZFwH6OAhRfOYmOP/aIG1yxwt136H9V5rhqbegoimALbtQS41Gm/dmLbWIPAwuRG2deVQRYfQSRBttWoavgLtMV5NZtpMKHHPuu2BJY55+pO2wpo26ODCw5e6h88lNrdvLvH7uwGzeqbqZQEJu1SxQPY01PvUzQXZsnDWK3oG4Een/mNM0iQyJwVCrxwA1sDPsg0ss1DypwHLtdT5amigCr4QeK73KKL9NhBiC9RKDDb9rBd40EMBkxVCukhzM1Wqcr6FSRNCbrqp7xjw/2h9rfE5U7s8HIzt0L8xSZTwO6EqcGW4JxVOzWcOwaQdKvwWPO32/1WSbGFVzDJl0kV7VnSJXg5WfBCA5EYvy+NUWSF31B1eLDuFhPNrjiEYqt+oSv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(36840700001)(46966006)(40470700004)(36860700001)(356005)(40460700003)(82740400003)(40480700001)(86362001)(54906003)(81166007)(4326008)(82310400005)(8676002)(70206006)(70586007)(5660300002)(478600001)(8936002)(41300700001)(186003)(2616005)(316002)(6916009)(16526019)(336012)(1076003)(426003)(47076005)(2906002)(26005)(83380400001)(6666004)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:29.6953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5194181-b2a6-49af-b4a8-08da8ab71d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

SR-IOV may need to load different firmwares for different ASIC inside
VF.
So create a new function in amdgpu_virt to check whether FW load needs
to be skipped.

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 17 +++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b007371df59c..d00a9fe542bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -340,11 +340,12 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		ret = psp_init_cap_microcode(psp, "aldebaran");
 		ret &= psp_init_ta_microcode(psp, "aldebaran");
 		break;
+	case IP_VERSION(13, 0, 0):
+		break;
 	default:
 		BUG();
 		break;
 	}
-
 	return ret;
 }
 
@@ -2412,19 +2413,7 @@ static bool fw_load_skip_check(struct psp_context *psp,
 		return true;
 
 	if (amdgpu_sriov_vf(psp->adev) &&
-	   (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA0
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA4
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA5
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA6
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SDMA7
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_G
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
-	    || ucode->ucode_id == AMDGPU_UCODE_ID_SMC))
+	    amdgpu_virt_fw_load_skip_check(psp->adev, ucode->ucode_id))
 		/*skip ucode loading in SRIOV VF */
 		return true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0707e4338e65..79f1e37caaec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -809,6 +809,35 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 	return mode;
 }
 
+bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
+{
+	/* this version doesn't support sriov autoload */
+	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 0)) {
+		if (ucode_id == AMDGPU_UCODE_ID_VCN1 ||
+		    ucode_id == AMDGPU_UCODE_ID_VCN)
+			return false;
+		else
+			return true;
+	}
+
+	if (ucode_id == AMDGPU_UCODE_ID_SDMA0
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA1
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA2
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA3
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA4
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA5
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA6
+	    || ucode_id == AMDGPU_UCODE_ID_SDMA7
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_G
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+	    || ucode_id == AMDGPU_UCODE_ID_SMC)
+		return true;
+
+	return false;
+}
+
 void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
 			struct amdgpu_video_codec_info *encode, uint32_t encode_array_size,
 			struct amdgpu_video_codec_info *decode, uint32_t decode_array_size)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 239f232f9c02..cd6fce05978f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -343,4 +343,6 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 		       u32 acc_flags, u32 hwip);
 u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 		      u32 offset, u32 acc_flags, u32 hwip);
+bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev,
+			uint32_t ucode_id);
 #endif
-- 
2.37.1

