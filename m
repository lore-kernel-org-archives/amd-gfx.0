Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C534C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D764E10EB4F;
	Fri,  8 Dec 2023 22:53:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7AA10EB4F
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFViTOsf9gR5nypYTj7uFWJ6FvHgSRALCKHSGdqOUqOswfrT4REI89P+ubCTlBFw4uadS+h6sU5Mo4Ly7G/Fs5JJittgEKy9rk2t7llVJpc0ClOncMuI+uXqqxC/0XTwwNezFtEJXcB56gkylpsakRIg2ize8r7wJcoOSgW7uJOMZ6PeSIvQs702QW/MyGYFKYOU4weuakUdgiHForompdXPolJo3/VzZrsTJ9giaP4fVZODvM2aA0FNQ4SlG7Lxts47oVNCn/qErgsotZtXBeh7mrzTJV+i8k5i/IzZ33v9CgjZPwxaDgqLVf8YtLHcn5S62grQ7KMg2e0X+ObB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXf44zhAVDAFHBK60q0VfMnCR8pAKut0p1igJLxv2vs=;
 b=E68p/MNIcUbYgT6GRhYjfxNpMYVvIv3UZakqi/85eDBhmzZmAB5Y6zT3FUBpXLaZ9lz5BumXT2YVXBDrejw7jk+uMkPCoVoHxPkprylUsqgWPtnwxe8pFIfSOTX7kqRS6CRaFNJ7I2Pp3X6N9golAhHSlk1PLSMfYuoqCBtK6OLWk4HIooiaBgn1BOQ71ELFD/HXKPck2B2Ys3ZzjAHrXUp0sakL/c/oD7UhVQ1F/9iNULacskEAMas98BbpVCOxihv91xTEADFiTgnfNcXImKsfWmDkv2eZjH6xa14MEfBz0o+rtM95TZXyEEyVVtN7ZAiMpfs0oBarR2JVbOrNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXf44zhAVDAFHBK60q0VfMnCR8pAKut0p1igJLxv2vs=;
 b=KECyiH6N8AbQCWb9CkwTufzLTN71eyATNenw7+T0PMTMRWM7OCTzYbMA+Lnh8niGdH63J3sPZormvwPmmCyxXVMUrFzCbdI8AulqEto6JP6dF4pk798+8bXSVFBXUQGVAIFRaF7rOnHblSaxaj9f8i+jfEiIHRl20wpoVH+LkmQ=
Received: from PA7P264CA0359.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::19)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Fri, 8 Dec 2023 22:53:47 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10a6:102:37c:cafe::31) by PA7P264CA0359.outlook.office365.com
 (2603:10a6:102:37c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Fri, 8 Dec 2023 22:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 22:53:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 16:53:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks
Date: Fri, 8 Dec 2023 17:53:28 -0500
Message-ID: <20231208225328.25651-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: b30c507c-0123-4e1a-372a-08dbf840884e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WO3+WzNSgE/HAZBQAfVRzdz1N33O35vmHzJSe9Sj1gB0mKxQ+4nh2yOU5tZLZ1axh4Teryza8rshYXYM7f5FS33nOl4xhV/21CDeOFWwr6MlIF6sjAmu6aQ5onmQlcx6R8eOgS/vzCAc0sVbs2kKdtSUXtlp/RatbYIB/TxjP7w3WWMQaYg+GyCgIZoC0qN7Ir+AWGyWdFvYVerOQ7dl1P7s7w9bxHmUI8C+3+IjVoYoYeQMuk/69rCEApcWLMG5HXU2sYzDCDVNIgJ40orcMJ2LofcSF9BOijWbIK3h84j4e2uGm22JTidBdmktk9QveBVt8TA181IMWrj15oO/692v8X5Gr9ChBaK5FSbGO7NBrt+lUxKapWkS/oPWa4e3uqaCCEG8K/FZRkPYiTjFUnCzxaBbyY5nsdz0lHc/OcqdZP689tDd9f9wGfS3Jmz6ti2QpBhmL1PGkkoSyCWpPik+RAO5XatkWZ+RSYGtShKSPKqvv6mqAHOOEXLAtlMT25DUGnP8IubOdwX8Lz8K+uDR+CenBQ+TbKjlhQtyss/Uk+A5e0m8SpQJ3nlZOC/FWHmkrz2hbpYr4RaSrHBTUvXKOPAQRKHUVUHS2x9eaVvP2Vu0Bm1AenAP2ujLIUAgts5eAKcdC3zjGcTbefXRc5x8WJDVDjaucd+1scKevmgu3/ZoQ6ABp6rC5o+p4b/KH4k9RCPdiQM44pSY7V6AxkFFy4MLoQ/vmuuhl/NXST9DrziHeUD2uS5GqE2xykjV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(47076005)(5660300002)(36860700001)(41300700001)(86362001)(36756003)(81166007)(82740400003)(1076003)(356005)(2616005)(16526019)(966005)(26005)(336012)(7696005)(8676002)(478600001)(8936002)(4326008)(6666004)(83380400001)(70586007)(70206006)(54906003)(6916009)(426003)(316002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:53:45.0854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30c507c-0123-4e1a-372a-08dbf840884e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
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
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add begin/end_use ring callbacks to disallow GFXOFF when
SDMA work is submitted and allow it again afterward.

This should avoid corner cases where GFXOFF is erroneously
entered when SDMA is still active.  For now just allow/disallow
GFXOFF in the begin and end helpers until we root cause the
issue.  This should not impact power as SDMA usage is pretty
minimal and GFXOSS should not be active when SDMA is active
anyway, this just makes it explicit.

v2: move everything into sdma5.2 code.  No reason for this
to be generic at this point.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2220
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
Tested-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 2e35f3571774..89f7955739f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1643,6 +1643,20 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u64 *flags)
 		*flags |= AMD_CG_SUPPORT_SDMA_LS;
 }
 
+static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+}
+
+static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.name = "sdma_v5_2",
 	.early_init = sdma_v5_2_early_init,
@@ -1690,6 +1704,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.test_ib = sdma_v5_2_ring_test_ib,
 	.insert_nop = sdma_v5_2_ring_insert_nop,
 	.pad_ib = sdma_v5_2_ring_pad_ib,
+	.begin_use = sdma_v5_2_ring_begin_use,
+	.end_use = sdma_v5_2_ring_end_use,
 	.emit_wreg = sdma_v5_2_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,
-- 
2.42.0

