Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1C5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 06:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2EB10E64D;
	Wed, 23 Feb 2022 06:25:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96B510E64D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 06:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7gBflX0j/XuKd6r5tdD+wzKXoX6Bu/mZDXQXxwStC3NdHPfE2LUIvtt3trSTVFjjroxSlpDiqO/JlhlYA9TH3YZhQCo/EvXvjfPmy12RJmAxtU2jfQobasNppCYUvudhh0JUcEX3QTO0G0uJCzBjWM+OJO92pzLHbkAH1znGDVKoYiuFsuC9G0DpYgSzcjcTxSoyYWvFtm/VBHbRuSeO3qsoXBZsDC0unaBr8eKcpGjgs5I6KJ34FsXdQ7cdnnmxMqi/1MTtsIBhDo1cjW8Odsmepcos+42vTPtQXsXoT0vqk+ugrOuNzAr6Rxi/sIhIL+QUVVhIfLyNt2dafAfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wFKB9wZ4laVqwIUFmlclSyrnz1l9xpP7C+J/+Ik4Cg=;
 b=JQuhZjLEEPL4l0w1hfBCq+aibFjU11cBKLx9MzMDUGZhdUR9VuUDBsHEUfcHeY9zZMP4TK8wpNNN9KmbR2cYyqietOLzbqH2YfzrWCufytfFKPqY+kOJkGIYRoRgMxOD567VwMN3lefoGoUPVPD4kmHBie6NBFEoYRMEbu0pcNkfiXbkEV58QBPcBReKGuJxnphKPsgad6ZZMbQ7lBqfxdJmxSCY+++YY09s0b7Tb1pMPcw1Bup7d6jr+/zIMRRSG7jCqRtJOH0V9r3fWhzP8V8Hi/tINlDxBFJ4ojofvY103qRoyDd5t9Pqq340U7sxumvv/5hlKpTj/ZW2gjgTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wFKB9wZ4laVqwIUFmlclSyrnz1l9xpP7C+J/+Ik4Cg=;
 b=rOoFnVhMAh4JHotupN3a7ppHfC0vfcaeGkG3LvFuR829IaNglezLGaPZlGaEyn2dEcIs5+6NEQFHIdGy440v6gi/KLDmDwBPCpaldHgG7c/HczBL+pLQlP75GvqBMJ+oZJFyZ5hsd/yJzYODxcmGQGFF5qXjZVOqo0WYNTomH4M=
Received: from BN0PR04CA0065.namprd04.prod.outlook.com (2603:10b6:408:ea::10)
 by MN2PR12MB3885.namprd12.prod.outlook.com (2603:10b6:208:16c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.23; Wed, 23 Feb
 2022 06:25:19 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::3) by BN0PR04CA0065.outlook.office365.com
 (2603:10b6:408:ea::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Wed, 23 Feb 2022 06:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 06:25:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 00:25:18 -0600
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18
 via Frontend Transport; Wed, 23 Feb 2022 00:25:17 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: config HDP_MISC_CNTL.READ_BUFFER_WATERMARK to
 fix applications running across multiple GPU config hang.
Date: Wed, 23 Feb 2022 00:24:10 -0600
Message-ID: <20220223062410.1875224-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edc1725a-57ec-4ecd-6913-08d9f6954355
X-MS-TrafficTypeDiagnostic: MN2PR12MB3885:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38858B9077847CEE3F8CCE78E33C9@MN2PR12MB3885.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3zga6lxPQRDlffqD+klBH1q9WhkhGH7iENx/659fNb0fasE7ZFAkk2WWcsEJjO+0oTzMoCYhvFA2gJ7uCm+t+78rMLHJTwAWT8YPhjjMCvbSURG8BmIg6dq/Hbs+UUIdkWMaQ4xi33WUmENUlrgvxFWkVGI2/7ooTo2wjShYug5GxqVmovDZSGNhxUHLbXSaOQ24t1tDn1jFxDi9cGGxAokAMkOKww5KCNKjHCdtYR5vaJw+GIZeKzoKi6rId6a2Bas/S8wcxDTxCOOakK37EQDNG0G/oXWgiLXEJ9DB9l6va0ytEv4+EsPo6dBRgVAyRuGwhveslpzsPpCgFwLwfh3vTL1E8uvKmfzzYomI+kERdMysB6Z3YWPo8T20mm78A/5zlc6EWwfG0RubuBCCxPwkhekcefk9peWGGS5STx2dGmqV9Qz/aZb6OroOgH2tRrDl16fI28+UyfA1F8HwHCiCioLV96A6NQilnWRIS+/ZDnAbO8rWarX3Ca4JAdzrtUaGC885i1rEK/n8xHlaqFKv7ohk7GtbhybRLVAtalUDGjp4v8u7jJgxqjPEYqHM/CYhkhz5FbByGCvo1m91NSBGTNcYDKJke0dhli1q6PupCPGAul/7EpwBlCaS6ZF6rJMu6ZwT1L8LUTq/pnkchPG0oOlB7OrOEOOCq32TOeSR3/NsGpZbPiWnh6kek+kJ4DBVO+XakHaRQdQ2IJ44A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(83380400001)(82310400004)(2616005)(26005)(186003)(2906002)(426003)(336012)(1076003)(356005)(70206006)(36860700001)(81166007)(47076005)(70586007)(8676002)(4326008)(8936002)(7696005)(5660300002)(36756003)(6666004)(316002)(508600001)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 06:25:18.9241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc1725a-57ec-4ecd-6913-08d9f6954355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3885
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
Cc: Alexander.Deucher@amd.com, Xiaogang
 Chen <xiaogang.chen@amd.com>, Harish.Kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c                      | 3 +++
 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_4_0_sh_mask.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index d7811e0327cb..02400d97a95c 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -146,6 +146,9 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 
 	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
 
+	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(4, 4, 0))
+		WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, READ_BUFFER_WATERMARK, 2);
+
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
 	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
 }
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

