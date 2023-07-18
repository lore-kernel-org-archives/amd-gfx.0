Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF846EB64DA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 08:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C9B10E2F4;
	Tue, 18 Jul 2023 08:31:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD70410E2F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 08:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB3wVdT4SqI11ghuarN/wOvKWJQembqh3Wq58p6HGbz+jxe+2rm5wjHvvEKDQBjyNMvhqWo4aiZ20zmq41aiBtwqT1kajh385bFVgdDXfWM5TYbWylIbZKkf2BOkVWjDYehHqA08t9zPlYDDXEd9sIR4wl5uexIM2A4y/mEVztRo43ULQrLEwDiTK7ZmRyPbnxHxiFxbdsxlDBsMt9gUzqg8Leax8egA2DxEwUac7SEy/mfSHL2Oy1Vm9ibBjtwwooFQYEc4gVr5zr6TalXRa9GPx5ncK1gMPienl9mcgUG0lOnDpc6J/xqjuuUskDH508uIm48Ck3nLI0tc5MNj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzqEh/ymR8zkk6kZfu4Ca3VBdVfokx/cn/S+TS2gXxg=;
 b=BRNarW4KhKnRXN8oh2iEfbGuN3Tn6WOCsCOMKrlcc4+ha6/RxERSp+RhjwOBVenFSHljD4gdt/8FIRBocpSurbZHf3lcLrHk+cqFa+HVmJpTJcpuTQ/QZtCSNHEG1GuQS3zo/WEeKD5X5WSinQ1kSiqycyoT2juI8uWg3Ac1JHh9dDYGDGNkB8oMIUSujUYfxBpLopdgl0VJ+2VVDVba3IJ5oBjvIbiHxXuuPi1/MaVriS+QWByh48VB4qhKtRBw6pLDjKsB8HGFLj2ivvZPM+cHPl0blzz1Gml4gbrIcNbfVdcs/IsA5C0VXRrqmuFQekTY1oQTmKHZHbw55ldEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzqEh/ymR8zkk6kZfu4Ca3VBdVfokx/cn/S+TS2gXxg=;
 b=uMz/Nep7nvM1OqXbOHz9g23KSKFargrp8NlEipgLOQSuLQ/vtdeJz8eYpBxPNz06SuWH+OkBP9tmhMlWbVB38O8mHIqDyUbHlQpvGVpQoU0u3E/cn8ndDym7T9pOdnYRyFJxFEwPtxgTdn/R2WTuLVkoAj9ykN+ezU3Jo/90HgY=
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 08:31:04 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::2) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23 via Frontend
 Transport; Tue, 18 Jul 2023 08:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 08:31:03 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 18 Jul
 2023 03:31:01 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: load sdma ucode in the guest machine
Date: Tue, 18 Jul 2023 16:30:50 +0800
Message-ID: <20230718083050.5417-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8e6b64-f8d7-4b21-a89e-08db87695314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJAalNtf+aVFrS2JFYmN2T91u75GNIfkIKLWlbj2oCEl0SsfS7VNNsAxj3iWPg6IuZLDay7k4m+pSdsZymnHWE6qGu2RAsb63Inu/1MkrUjVVRP5OzOIBuC5sO+IcZWjNlET/hBuxHCIzXKsvVX5DQwgE9xStzsuXPrX1nfND5f4iqvgzcpfsfENvZu7UvesWY4xtIPURcuPaVveky2WxOGZ0UIzUQa/0jmzUF3QAg9Of+uOCGjq75CYfo90XA9izePOWUCMqds4WG0k5AzzMrG0664pBGLa+bVRUSQu078F7JyI78du8WJO+KXw9T2VIdjlX7ZBEaPj1bhpjycvbLg0UwWvMZAWoqVxvwyOCCEHfXIZUL7ZC9rsvBsDkvIdwt10oojXPymauOTG1OCnI8DnsIcYoEsZtyDejfYXhf4A+KROYSybXqTMQlSb5TTy0ncdezzYmI5S3Z7NeYWyUGUPntilEWxFCxexoYDdpNbWAJAXhss2fywhn5KH1dDNtENYFd2ef3uUadijTTox7q/SgwPicAmjNnjnOZs0RM18GOJWAReIJG73fBFemm4dKZq5DqsICK2R5F2rtzS1FCu6QHmN+BGQaQClZIRFKJHe17EamfVu0AfHA2cb0FUUdSkOX/MSp8wpAOE8aiLhg07BJTs/UYwtr2ewHYHOQX6WNzCt/LdPOFFPt3O3ZAx4nW5uZXRCVOi7KXWqxypAf978LIbe0bdCNPpAoguD0DfQF75U3kBv1HZKAA6dlYI4YS4htJmV2MhOrj7hOTR8JQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(2906002)(36756003)(40460700003)(40480700001)(2616005)(186003)(16526019)(336012)(36860700001)(83380400001)(426003)(47076005)(26005)(1076003)(82740400003)(356005)(81166007)(70206006)(6666004)(7696005)(54906003)(316002)(70586007)(5660300002)(6916009)(478600001)(4326008)(41300700001)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 08:31:03.7454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8e6b64-f8d7-4b21-a89e-08db87695314
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
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
Cc: yuansmao@amd.com, horace.chen@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
User mode driver need to check the sdma ucode version to
see whether the sdma engine supports a new type of PM4 packet.
In SRIOV, sdma is loaded by the host. And, there is no way
to check the sdma ucode version of CHIP_NAVI12 and
CHIP_SIENNA_CICHLID of the host in the guest machine.

[how]
Load the sdma ucode for CHIP_NAVI12 and CHIP_SIENNA_CICHLID
in the guest machine.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  8 +++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index dacf281d2b21..e2b9392d7f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -239,9 +239,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			       sizeof(struct amdgpu_sdma_instance));
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 41aa853a07d2..3365fe04275a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -845,6 +845,17 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 			return false;
 		else
 			return true;
+	case IP_VERSION(11, 0, 9):
+	case IP_VERSION(11, 0, 7):
+		/* black list for CHIP_NAVI12 and CHIP_SIENNA_CICHLID */
+		if (ucode_id == AMDGPU_UCODE_ID_RLC_G
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_SMC)
+			return true;
+		else
+			return false;
 	case IP_VERSION(13, 0, 10):
 		/* white list */
 		if (ucode_id == AMDGPU_UCODE_ID_CAP
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5c4d4df9cf94..1cc34efb455b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -237,17 +237,15 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 // emulation only, won't work on real chip
 // navi10 real chip need to use PSP to load firmware
 static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
-{	int ret, i;
-
-	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(5, 0, 5)))
-		return 0;
+{
+	int ret, i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ret = amdgpu_sdma_init_microcode(adev, i, false);
 		if (ret)
 			return ret;
 	}
-	
+
 	return ret;
 }
 
-- 
2.25.1

