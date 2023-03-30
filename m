Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F127C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D0D10EFD3;
	Thu, 30 Mar 2023 19:27:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C0310E54A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj2ei/hXAG+22tpTU5rYb63yoV7jt2FFFgiQ2x8vHTMbT7HeqJ202Lyvmlckolux8BpLcGSF1qnpRzUMpeNmFJIQDlcf5l2JoJAPNuU7yIT8rkyt17YtcLia9c9ahrDhvdkbn5C2N9LicJmkKntyppx0gpXgqnojRxs3kJsNgBQKh7FcJurJMKYgy+CzCLWAvXehBJJAqngDDDrhLa7YiaHPcHokcrSANRw5P924wvR4ynoD8vdk6vGixLP32LVAaLXnl2JCmMfLlrvhYwgEmzHY22wnKhsAiAsRaY7nvmSJC6q8fFSv7kMmLd8OfIZMNXdx22tekmGVwYEK0WACMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GyntP1Rit8Hcieyu246eg4FbI57nEhYwoHmhjHxBWA=;
 b=IEEQX5LA0f9oWZrs+vX2V+s4UXKOe/906BNR4HtChLIEs1b7k0hHrtzk2bZLWa0MFdeyIBqPt6S6dxEVrAW+Zi+ceBO7mij17O9vEWQNYjbb29VgBRaPvPAeY/gcxsIELySXdFyWNO3KjrDtuKeZfNkYOJYRnlNPfIfBE82gNoflgoUZhbElPSgRe55Dhht1PnQLq535nMZPL2PWaCQyh+C5Jo/ooGCZ7vRSnTp3jb3GhxIxPrKB7Jwk4T9AZ6oNigDF9dxGi9RiqEWOlvgneVpPlmeKzZYT5CyfBPGRXCPtQj4vtS3P5W0bf3w5VjK/QZmwau6eViZ5fjFMqw7qpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GyntP1Rit8Hcieyu246eg4FbI57nEhYwoHmhjHxBWA=;
 b=oNFHvrpEVx/jS8CeC9ylQcTpNsapzW/8I/uZ/+w1hOA6lr0FZObmkhWuBwjmPHp9lk8pTA9gKVFIusL0dYmSLdbHHkp4mkpbODLn9nBBY3OMh1OeKctUN1HzmVhK8cVIkfMWFUz1Kfy7LzwTBX2tnZtVrJGGsAQiBG8Q6rjIIrY=
Received: from BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 19:27:15 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c1) by BN8PR12CA0012.outlook.office365.com
 (2603:10b6:408:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 19:27:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:27:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu: Check APU supports true APP mode
Date: Thu, 30 Mar 2023 15:26:56 -0400
Message-ID: <20230330192657.1134433-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330192657.1134433-1-alexander.deucher@amd.com>
References: <20230330192657.1134433-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 57adeaea-3dfb-4a49-7969-08db3154c4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwRWTEeXio2LDtBm+9Je6PZ6bUqUVpwK6pxzp1jCRqn8UEgROssMYFSuiHB23StyZSBGJ5u9dtRYguxjXzA9pRe84+f1TNoZVSvUyH6KSblLeh+czrqzzMBHtUnJ9QsdiS1X4OLTLBWsT2ETBYrIIbYXzNrwW+AM6uRnupOGFwqt5wA3Xdxjx2xMRM8lMLR5KhMY3DPl3UdtX6sg5NtFxpu+SBfau3yqXtC98ZypaoTBoY3kupTJOkGpQ5ivHIDOzUDoaQ6f3gppZBvDSBHiN3/U99QKutkjxEHpFzDd7cVgooAGCY1ZOW4UyoYElcsrbD/XwgAl2EKyH+e6uoZqe645c8Dr+ieNKcRTan3PtmBi6EHlO8iPOm8+31X6vUQ9VLC47MzKJnrMdS3R/fpevG3L5/5LUBNrmG+9sHYR25MpFO4IOUF2kIBy3DlYRPXEcItOEZrbbpuJv6ILMXa3czTRhxSKKVpHWjM/+S7c2hJokpxkV8pXqr6pgdyX24lAv+tIxzbtx7kcTIvMNVzGRCNhjMT10WdsCSI+E8yRguzmPTO+kqHBHwWrFoCtI0yAia1YXuBP6nE9kWAHv/eElkP8Gb49jMOs+uhTURZ3pPTblCZYh0TVngXZjx6ff115PSmiX+eu91mRf6atXVjmoRC6nw4trj0V4Uy/QndY4usV9xqCFUfkZyE0mjEJe+UwGJFj7XohOOqjn7HCA4lRQAHq8avMHSuEL2WZP3dyz9g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(7696005)(316002)(4326008)(1076003)(186003)(16526019)(6666004)(26005)(8936002)(5660300002)(478600001)(2616005)(336012)(70586007)(8676002)(54906003)(426003)(6916009)(83380400001)(70206006)(47076005)(82740400003)(36860700001)(2906002)(81166007)(356005)(82310400005)(36756003)(40460700003)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:27:14.9502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57adeaea-3dfb-4a49-7969-08db3154c4b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, Graham
 Sider <graham.sider@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On GPXIP 9.4.3 APU, in no carveout mode there is no real vram heap and
could be emulated by the driver over the interleaved NUMA system memory
and the APU could also  be in the carveout mode during early development
stage or otherwise for debugging purpose so introduce a new member in
amdgpu_gmc to figure out whether the APU is in the native mode as per
the production configuration. AMD_IS_APU cannot be used for Accelerated
Processing Platform APUs as it might be used in a different context on
previous generations or on small APUs.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Graham Sider <graham.sider@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 5c1d68bec0be..88649701b30e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -250,6 +250,7 @@ struct amdgpu_gmc {
 	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
 
 	bool tmz_enabled;
+	bool is_app_apu;
 
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 016adcfe8c49..1a43276de338 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1424,6 +1424,20 @@ static int gmc_v9_0_early_init(void *handle)
 			adev->smuio.funcs->is_host_gpu_xgmi_supported(adev);
 	}
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3)) {
+		enum amdgpu_pkg_type pkg_type =
+			adev->smuio.funcs->get_pkg_type(adev);
+		/* On GFXIP 9.4.3. APU, there is no physical VRAM domain present
+		 * and the APU, can be in used two possible modes:
+		 *  - carveout mode
+		 *  - native APU mode
+		 * "is_app_apu" can be used to identify the APU in the native
+		 * mode.
+		 */
+		adev->gmc.is_app_apu = (pkg_type == AMDGPU_PKG_TYPE_APU &&
+					!pci_resource_len(adev->pdev, 0));
+	}
+
 	gmc_v9_0_set_gmc_funcs(adev);
 	gmc_v9_0_set_irq_funcs(adev);
 	gmc_v9_0_set_umc_funcs(adev);
-- 
2.39.2

