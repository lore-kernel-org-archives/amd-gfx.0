Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76964C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F413510F886;
	Fri, 29 Apr 2022 18:02:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8D910F886
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4tcrKS4FH8Z7LkNo3yt5Xps3MPzqaUVIjT9r5mvPxo5mqajyqtlZ80l1wMCgZGSRtoo2UhJcU7OP6nC2D+LdMuAVMpJqmhPpotS3/6KiwEnRaYoUzk83E5rE6g25Ukzy7X9UyIFUu+PdGMhgnqAci1Rbkyy28WRXP/6jLlzZA6o1SfSevOcwZ8xiAaA/xoH8EKPd2dmd290DaWn3LnIv/o/d4STgHL/tpl37uBracJR21zjRDIjCdhz5e0Ml9NHJ8kP4awJ1DoJGXFywHZKSvlCaHZLYof2yOhczhvdqz/4In0U3N6VDILyc3desZig07gX/MO3y5Mfn1MSkCU44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jRNzAN2nB9XkvK5k1cey9HJKVFadKHuofJKnBLxqXc=;
 b=WDYyqQ50jH+kP7pjdmS3LRleCmV7WwVcc3b9PhrRpWBjWdjQLKnXg96fozXD7fF4NCpRns1dOU1MacqLFxudE2iu1b2T9lf7KaA1tnbS1nNhNhWjgRPtDpdzIN6OSHPHvNftd1aN1iWzrW4xhqjAPSIXpEw7503YjG6LUhVVjPUXBKL4zXIO46h/42AACebtSvLp5J40KaOeViX05yOAns0mQno5COjuvngYF1Gu43BCirElPEsn+Q6PHL7wN1Fc0q3zcKx5xEconETNaloyaJ9L4Gu0HOphik5pDS+OOEaJJ/ed24qaFXO9hf470hStIJYAnjmSQV99Y8sqadpO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jRNzAN2nB9XkvK5k1cey9HJKVFadKHuofJKnBLxqXc=;
 b=PqcSbh47ECDGdu4LtcVdSoBxdpX4MktwPIqTLhoyUhQCdcz3KKJpN0XkkwKCEqjeSKO3gO6YC/AuPArZtWUvVSwpM3MWj9ubKtR0GBZD8d0E/9Juleqx+G1haabn5OZnY9/V0fWEUcIx2/LNhmqyCWKGvbkvcc6or9U0QnI18RU=
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 18:02:40 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::fe) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/29] drm/amdgpu: support RLCP firmware front door load
Date: Fri, 29 Apr 2022 14:01:58 -0400
Message-ID: <20220429180226.536084-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d879486-f79d-478e-ef17-08da2a0a7387
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25914CCCF6DE74FBAF4D26EFF7FC9@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT25TA+QNkYseLsLRxWOSDPCTrYSkFbbW5DE2zUUgQ0wlHkNxNJnGwYDxGE6Vs36ow8UV2nscr0px7vlhHFRzahC7cbkXVLUfCLa9jlhY4KQdOWa0h09VQ79kIEH/hPtAOUUdSqtXApeO3/R4u1SXpKrqd5LwPQJ/Z9wDi6ER5GL8oUja/qpOhireoCHPvtTpZmIoKADUk8e27TPoHoJQ83J0j9Y6WVB0tAK7w+Ns/+bbpE7Y3VXt5WjF8PxEPZorc0uOzlY5wbNCRZJLPT2tLkwIKCHRSqpO4q9IJ8iC2Xx5Cr5az/2hN2NXpnUjJLucnWxT766+yhQUc+ErK+Wp8b09DBOKA9KnRZy7YKm1uAzUhtCN2HBgAioquQx4ZIPFHs6wjsqsfEGRJeQDB4OyQva8cKzS615ryN6Opq6NEZdpD2yBhWXd9B5AsD9K64bLxdCL3hfJZlGK2xTCmYM4WCuEt5q0ftYui+YTgysj4t6Wwln0NZHEacGreu/ShZ0KKPD4TioS577q62jxsw2NqShiswUhaEDnT/BZkMb/skaa1DhscY2CnSZx4PVfIkfVat1jJCj0/4R6se38OFJOaS21ZuXy4kAHE9x8nW/9aR5ZRReNYELa6fEpgVXEkhd87/+hUJBYju6J8t4n6tbsH+fzXsgpDQx2Z9LiKdxibUFkzW5psZ3bDpmbMOgzRpmgtL3xcorYnCE/xq2vkxDsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(26005)(86362001)(4326008)(40460700003)(5660300002)(6666004)(356005)(70206006)(83380400001)(70586007)(36860700001)(2906002)(2616005)(8936002)(6916009)(82310400005)(16526019)(508600001)(54906003)(426003)(47076005)(336012)(186003)(36756003)(1076003)(81166007)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:40.0955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d879486-f79d-478e-ef17-08da2a0a7387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support RLCP firmware front door load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d0fb14ef645c..9b3c23a22059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2217,6 +2217,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_CP_MEC2_JT:
 		*type = GFX_FW_TYPE_CP_MEC_ME2;
 		break;
+	case AMDGPU_UCODE_ID_RLC_P:
+		*type = GFX_FW_TYPE_RLC_P;
+		break;
 	case AMDGPU_UCODE_ID_RLC_G:
 		*type = GFX_FW_TYPE_RLC_G;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index a67f41465337..7af9ca069570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -701,6 +701,10 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = adev->gfx.rlc.rlc_dram_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlc_dram_ucode;
 			break;
+		case AMDGPU_UCODE_ID_RLC_P:
+			ucode->ucode_size = adev->gfx.rlc.rlcp_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlcp_ucode;
+			break;
 		case AMDGPU_UCODE_ID_CP_MES:
 			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index fb88f951fb3a..554a4a0521bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -400,6 +400,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM,
 	AMDGPU_UCODE_ID_RLC_IRAM,
 	AMDGPU_UCODE_ID_RLC_DRAM,
+	AMDGPU_UCODE_ID_RLC_P,
 	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_STORAGE,
 	AMDGPU_UCODE_ID_SMC,
-- 
2.35.1

