Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE4C10DC3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C87F10E9A4;
	Thu,  7 Dec 2023 22:54:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FF810E148
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+78zlrnbK8NyNYthvzlTYpCDQP0bgQvRxgkeNTCz8adB7/gl0tJcGWC1gsUOew/P9w2wooaNySSaQFChgto6uFeoyY7W4F6hYtzJSBOCHb5HVwwo2+9EPeqsNvqecqfGFckM/iHqvMmwN9vqTPE+N1X/NH1CyiSB1oEKtJj0eTIhYXKfxv0a7oB2bP+sdZoYLXJEOVOKvA00L1wjjoPx3qvkja0gmpPeXRQLXBVuJi2cfWK2/V2hY+zx87SkAqBvuVLoyoMcFiVnYfKlxuaEqoRbIDJWnKVqD8IK4hj4AnarzXJ0qlpwDveC99xrksBR1nhjfnriKIZ58S+zLVO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=lzBlXYKyCnVFAyl+WnLJp364l67/ep2xU42Feqcm6hrUsj9oawsgigx7jiBDzfyB9crby26S8WZUZGaGW1ogSft0Y46et+HCMaXKP9apO3X5++niSRr4Y+2Sq3dEUqBTjVE88hfZ4noWSLpJDlxE0IlkB2yM1b4DO6Uw9K0QcJW10SVgwG+jC9voIgXzNiQOtldGeER/bpZRPlu75czfo+PXvpcX8JtvSLRoyaeIofduxZ2fPcyjncD0Q2XJ24dtXLJpd5RCtmRcWkb4F5UqjPpDsAes2S0J5lpw+w1MoGc6/I7M4f1tT7kCb9TxiAbtNuFqnjAIjlxsmHySvTsn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=I8Yfd4mD4obCUH1b3eto63whdwqinQLHvmfXA2EbFIQQX2g1KLG9XSvjs9xTlaRiithQuQpfks1nMMjK9xMldWPE3Nxa8wHutnTPQmOAk3G05wkYwAO0I2/GUezGz4FTkdteDbtDm84iM8vhy4KVYSEHEXt4cH2a9KyGdfHb/3Y=
Received: from CH2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:610:58::25)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:45 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::a2) by CH2PR20CA0015.outlook.office365.com
 (2603:10b6:610:58::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:44 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 15/23] drm/amdkfd: trigger pc sampling trap for aldebaran
Date: Thu, 7 Dec 2023 17:54:14 -0500
Message-ID: <20231207225422.4057292-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 093081e4-2b44-4e69-8cc6-08dbf7778187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg3ogNKX/8acoi8icdxjrbTyfghR/J5k/crWmf3QXe3RIX/X6ccNE4+/7F3TzxJAMVFVGfkauAD6+mLkPMitzMsqmJ0/fzTDp5Mh/QWMcDARq9fBXcBn1ZpD3GIylCfBzOIrRgXmKQL3lce9vuFmtH6RpVIcxKZSfl6fagNUcWS2JMUAz0kd1QaJV9C0yIRV3StehwyT2PJug1ZL+4HbqTjojN5XrZW5x/xJrZhocbdd0MZCCTbZ7k6OlIZxJgpuYwjnwZlKbVdhC13uU30l0pBLuLGn41LJN55xOAzDQtGW0OIwCW9SzT1zaM2/hny+13NK81Ey/tnSbnX6bn1TUtC/VqwZ7baEDEH9d1HhPHRgDDwbKB//EytHL5bG3WzykuWB5/aQiPo9LbwHsM4D5dGIhVAbw7Nj3mHqyaHSELiK/+0GDtTfwazq58kRM/CTxNPkirbX4vDhcGDax6Wqe4EJee60R6wl5FAPj1Ifcs9oTv/cule3LG1eAXoSiH4KKZKA/l1Cu3/Re8sPkvISOM6r77ZT/VBxk2KsSw6VncUiwzJ6Pf+2XDUUIT7mrIAdAOXMqBW9fUFpAhps+s8o1uvQjBxbu2BtEDRcgArGGg+KsXVHtyG0rpIbtyfRDUy/WO4INXk8AAFgT/KF2r3PiSJikjwrp6NA3J+DgaeDidb9jM9cjOqBs12s2ngINJPPBl14xJrSA+i07zkd7LWv/9yBIFw38Wl62U5ieOUXSJ6o7pf/fPkMI0cfCXx+QOBwPdMyTKYx5N9VsY8G3HiCGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(16526019)(1076003)(26005)(336012)(426003)(2616005)(41300700001)(81166007)(356005)(82740400003)(86362001)(36756003)(2906002)(316002)(478600001)(5660300002)(36860700001)(8936002)(4326008)(8676002)(47076005)(70586007)(6916009)(70206006)(54906003)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:44.8589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093081e4-2b44-4e69-8cc6-08dbf7778187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..27eda75ceecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -163,6 +163,16 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
+static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_aldebaran_trigger_pc_sample_trap,
 };
-- 
2.25.1

