Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61D7C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 10:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A61310E746;
	Wed, 10 Jan 2024 10:13:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E159610E747
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 10:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1T93HStsqZeRDtJdlsy2HjBrGzqQ1WGJ5zXXshE5hT9KubuhJKzYTgS3t7Cbe+TtvoysIacpym7R0XluT4Zo/swG1/locU8tXHWreSyfNKrWWXlvloUl5m1fJpjMmkl83vtYQQvGJa9szKgmDoJOLdIIpOaQ6/2Z1hOYQ3Cz/3RO2OTwm30OJkaNGjSX8/diZzGP95ENT5cZxFnxfeLkZpaPOlF8dwXE3A/+1tcEbBJ1WLhye9ffLfnfJCD+ba8avl09bUahLhxeZ2npRtYS5e+BlAfM1vE21VqWxFwJFlYBx6hYiSsiQ+QzwXKEoQ1g1eCE0akU6YaGQ3WLz4UUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8TOrkNm/olB/YPtFUTzGoef9BBf3+EbiyVr0YEm3/w=;
 b=Iy+aB4S6HaXDXskKpPNLJV2Wl1prLrrfoxYqUhbecfWxi+JecxwpL3YSueoUipe0yfEylMmivQN6SvObw5ddB9WBPmOQYx/9vi///WJ9GDgdOerlMur+69LFTMGCAVo6giL7xcMsACjFISxHI7NcmSMw0Sq9eG2xvZ12LpPerzVg0s66nOQIkUNl1eToa+XWwCQ1S2913ioVuPBjsS+ODVDw9Lnh3sBE5UnaeunCUyaDig263Pw9mndyWEXPAofVbSJLQWN6iab7CGMvqBGJ4c6ChzZastKarQi2rHwiDxVQ3SsZzj/XXfsWI5qqaCrK8mwW7LO9Fsx6EnBGNtarFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8TOrkNm/olB/YPtFUTzGoef9BBf3+EbiyVr0YEm3/w=;
 b=oMPU732cHi6oy30vmmsvewdG1ds9qA6CqLZCPxRSd7wBFc/YmgPgdcddjHEdIh8kT4Izy8JGczIz6+NS6nNi2qjeLANNu+Au6QSVKZg5mOYoCkciy2Su8QsZSATi+U2s74NFCZhSkN1uYt4rdQOnYiLfVFMlcufs6v6gejTNqCM=
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 10:13:52 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::cc) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 10:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 10 Jan 2024 10:13:52 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 04:13:46 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH v3] drm/amdgpu: Check extended configuration space register
 when system uses large bar
Date: Wed, 10 Jan 2024 18:13:19 +0800
Message-ID: <20240110101319.695169-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9c827b-12e7-4e8a-6ef0-08dc11c4d872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6mqqmwvtBO7iMJZxv89jqoZr2fgUt3R/nTqrgbIPT1nCX8k4M0r5QGI6yF9f2DEI17goiKr2u/hpKdxj4XpfOUQln+wqEShZrt2CTUt+9rHjyvyqp/NlRPIvW7SUPPFO3p0ktz2yzBk96fm9gKEW5PHQE/HpmNPcEKyJvQVZDgraWFV5mleVpgEoIFRSLxPvO4drZ+LOdz574hpjIJc5n2YFo9S05rvRh0bzHASQ9N1dbuOVEui3uhDh9AMZWgBcMSyNQXBFH7uKja6Z+9pGpv7dePPZY4TWtzX0lDbTFrZrYcKo55jqzOdeSaSS7zlQSYG2m5irfpHFXCbgCdxCMYl8+EpygD2XwM8+V8WhltTxQjpEtN6FlOlOgq9o2PRpa2DL5U4SxZvOsBD8f2hfwp+q9PRzkiEC9SIrAxC/K0yAvE39Z2MiYvnOrDXsMvJrYbHZL/mc5RCkFffINndAIYfxhKuZ8Hyapby/twOjgp4dEoBbalMkgQROQkTd9ArdS4i8jVCV1kkdblwyubdgREzeRD+TmlSxqfVaWRk4JzFrNy0whQSlnJVYdDWk9h7I0NoCFjTlKVqOrJAjNoXllS1z97/K5NaLw/re6i1hVWcgJ391aoxLmOb+N54BMoloHilFbml+2HSz0MpXKmih5gQYQ7Cz3aVJ8E0tMP/IaHkfuL3VxRxzHo+n7lEraioj1IXp3RJfadXxMbD+9cwei+BtY/UzRGeJfCs7A5SErZ/7dhXq8QGuNA2hQmA/ZG90oTHyA4G+H1Qch5aEruxmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(16526019)(336012)(426003)(70586007)(316002)(6636002)(478600001)(70206006)(110136005)(7696005)(6666004)(4326008)(26005)(40460700003)(40480700001)(1076003)(2616005)(2906002)(5660300002)(83380400001)(8936002)(8676002)(47076005)(36860700001)(82740400003)(81166007)(41300700001)(356005)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 10:13:52.0845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9c827b-12e7-4e8a-6ef0-08dc11c4d872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some customer platforms do not enable mmconfig for various reasons,
such as bios bug, and therefore cannot access the GPU extend configuration
space through mmio.

When the system enters the d3cold state and resumes, the amdgpu driver
fails to resume because the extend configuration space registers of
GPU can't be restored. At this point, Usually we only see some failure
dmesg log printed by amdgpu driver, it is difficult to find the root
cause.

Therefor print a warnning message if the system can't access the
extended configuration space register when using large bar.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
v2:
- Check the register at 0x100 but not resize bar register
- Modify the commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..629de7f2908c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1442,6 +1442,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
+	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
+		DRM_WARN("System can't access extended configuration space,please check!!\n");
+
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
 	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
-- 
2.34.1

