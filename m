Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A07C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 23:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B1B10E203;
	Mon, 21 Feb 2022 23:06:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF91910E203
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 23:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBtAqDNt8VMAMP/kP/NYU1yC87JtnExoYGViMMggOWJzd5JNGT5PnTd3DcZO+quqbhCRF/oTtOcvEZmVQLAWhsVQjOzaP4s6B/TsxXvtnQ1Mi+qn6kSGUe1vqugLiguBDbRT3SUH7uTFbSfu0cIG3bVgbZN/8Cb9+sq8uVv+Z48cHZ3fjXd7TT/MH+sGQ919TYtlfTgGCGZnr/+bs3S6SvcYC2b0Jm73Clq1cv0Ea06DaUEMax7rWCA+ES26dR+xtE4TUbxulWSL4qtY1+oCON58Y7KD8bUO8wBH5Uxgsf3jujmeuE/F+OH1YZGLx5Z9M+FCM+sfbGAfOIgwR2NsKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVOj6mhDn9vVGne/gSAIrKPbgdrxc2enaPWOC1X4cM4=;
 b=A7P8biMSWSPmyxO2u+WXUXpVg9LcC307fg/4bz0s8FBJH02VRpDezq4G+rWrTep3YGkiv3PU9fzZoUkioTFAfM6HD04pa6gj0dWtlYlhJvyfxSxWMOy+bkRy44sJmTjD260T7oRWFk7tSI9ZCqthHawlftPcIUogBBhyEDbitaQJXwHUXFrBUI+5RBEkDJxaUpoz7+WB/qgdcN3cmAifknj66gpULnETOCB5uxhEEe+oQVCilbuOR/vJntBONRr1BeQh7ljDXP+WlPN0RDa2R6s7e214yEiYViMWcia4/QUq1D648GHbaXAJxusfdOGnNHQ4GGNZca2k42V193a0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVOj6mhDn9vVGne/gSAIrKPbgdrxc2enaPWOC1X4cM4=;
 b=IOZev+xSDAEGNf1sg4iYcBY1svLaUdtAmS7H7euv88HrCHmHNC61KseIkQwRAH5O4QOCmlqQ7M2NbGoRslPNVGShUIWsRHe0Lt+LhFfym/9ownXtKtf2xXUHyCP3Bwkd1WxDNROU8F2P86/rHXVhYhdzRwyTcEwKTkWRRLyp0lk=
Received: from BN6PR13CA0067.namprd13.prod.outlook.com (2603:10b6:404:11::29)
 by BN8PR12MB4596.namprd12.prod.outlook.com (2603:10b6:408:71::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 23:06:06 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::ae) by BN6PR13CA0067.outlook.office365.com
 (2603:10b6:404:11::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.17 via Frontend
 Transport; Mon, 21 Feb 2022 23:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 23:06:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 17:06:05 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Mon, 21 Feb 2022 17:06:05 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to fix
 applications running across multiple GPU config hang.
Date: Mon, 21 Feb 2022 17:05:31 -0600
Message-ID: <20220221230531.1246382-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd060fb-a3cf-4047-ba3f-08d9f58ebd7b
X-MS-TrafficTypeDiagnostic: BN8PR12MB4596:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4596AE7973E33C1ABC618D62E33A9@BN8PR12MB4596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sgt7K/282zc6/TuJKO8mvpHtzoT6ULdWQaMN3kgkTfGDZZhO0AR1ffmiROAwbhIXKdnwQ2K/bw8id+XmUmqUOQI8fiNqxi/21PYjfHgAnBzBPM6OJhc7bhDmEm3w+xf5x04Hd4bHmQJO10iDPDXVI07Ze0DxQ0eXQdrDWEM7/F8Tc1iJDBt0PeamBHhexcf7uApfDwimcz0WUaRstJdFYbxvXID7nHHirkS4au2t7In2M8mvOVqsCjJk6/bX7Jc7WM/+uB9UzW7uck5ld6CZSGh2c68ojQ6LgH3XdKvcSuRw2FhIAPLmmlRpMopfO/k1qXkDn0UMLxOvQ+0voVVrc1YXmtpT2K9gvazb3qwb//xscTn4W003WaOk3fmx13Z5VzYNSg71opcr0VbKvDpyZHq+GT/uyRVmJ/KQ4Z9dhJFOexMB9w4oVK/CpaDQOBpLppcMB3mjXlgPYGf1kn6tXSAIWxiRYiEWdr2jESJa+w9np6LbaWET0+dCajCzFJBB0pm0BuUdREPLDTkCE15KJ3PLZaSINSL6L1QkPiRUcFadyX+qPGuGzZEOUioep0ytiiY4Iae8sjtR6ZqY76Rb9BiKisQIlbHfXtxp5fus/DC+IaDKsRX9XlyxSCzUSQHQ2jXtbNkx5vm1aisGp2hQDCGkAbBxAOjVF2aYapa+1yEAhw2ScrYTwnAec4yDW/dHP/X1vktnGW38rHgzULMHdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(5660300002)(6916009)(4326008)(70586007)(70206006)(2616005)(508600001)(6666004)(36756003)(7696005)(83380400001)(316002)(47076005)(26005)(426003)(8676002)(336012)(8936002)(186003)(356005)(36860700001)(2906002)(40460700003)(81166007)(82310400004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 23:06:06.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd060fb-a3cf-4047-ba3f-08d9f58ebd7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4596
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
Cc: xiaogang.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                      | 1 +
 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index d7811e0327cb..aa2c7c3f721f 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,7 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 	}
 
 	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK, 2);
 
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
diff --git a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
index 25e28691d62d..65c91b0102e4 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h
@@ -104,6 +104,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024__SHIFT	0x5
 #define HDP_MISC_CNTL__MULTIPLE_READS__SHIFT	0x6
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES__SHIFT	0xb
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK__SHIFT 0xe
 #define HDP_MISC_CNTL__FED_ENABLE__SHIFT	0x15
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY__SHIFT	0x17
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE__SHIFT	0x18
@@ -118,6 +119,7 @@
 #define HDP_MISC_CNTL__OUTSTANDING_WRITE_COUNT_1024_MASK	0x00000020L
 #define HDP_MISC_CNTL__MULTIPLE_READS_MASK	0x00000040L
 #define HDP_MISC_CNTL__SIMULTANEOUS_READS_WRITES_MASK	0x00000800L
+#define HDP_MISC_CNTL__READ_BUFFER_WATERMARK_MASK       0x0000c000L
 #define HDP_MISC_CNTL__FED_ENABLE_MASK	0x00200000L
 #define HDP_MISC_CNTL__SYSHUB_CHANNEL_PRIORITY_MASK	0x00800000L
 #define HDP_MISC_CNTL__MMHUB_WRBURST_ENABLE_MASK	0x01000000L
-- 
2.25.1

