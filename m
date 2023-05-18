Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D400EC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 02:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D65B110E4CB;
	Thu, 18 May 2023 02:27:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE51410E4CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 02:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTWeUg6JxQS6A0QIxRITmvkblOPLegDpMrJL/PpO+2XUL4aVH+dcfG+Ka5oavDoNaGySZYfMGzr96/3XGsiVU8nvBCiMKY+ohvuIXxM86you617IiUnY+3+vL3AW90TaWHWhKMpCNv9sqj54TQ+O3zvUl7v2YzBm5K6a1j9mxcSHsxCt6351spV7F2mV4TSZE6XUW1oYKN6LqtIaxx2vLuT+WyyMp9aQbIC4zDP/MKQ+paklUoBIHa642tsS6wP4yOu6dBehuSWK3Srd19ic6YVsXuR3KhplraRAFrzV9L3ZRe0aRxJtGSCgOMSOYh5saH7tLWon193ebpMtZigE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XD5FaGOkPdgbDClMeNf1MV3W0/v8w8BLLJ4C49tXwk=;
 b=E5IQR9NCb2mFHYMWp68A7REB4Y751JWsyhzjDV5m1WdpxPVAgVUbrq/Od9kuZkENCt7cLagZn7knEvEtNIPdzzDsl2mdxJVZmKN8q7D1vtrhnMVqEpX31jEqou1yqLH0Lmp7dlbQCZ3JUfieqoJrvMxAa1K57xv08yRZWtwM+03VHERN+mgQIlgOC4iwgg/AwV9PsHLTMXPFh/+PCQkA90EdZa54eTXAEHUW1+QB1Rk01cCTet6ZwDCqermOtG8jIVy/fr2RRgVFcNYPSPSGQ6qarOUJ1SXSjXhxjLLnz9aqkdKMfk8p5dh/shi8GDBo/sPH8JyWrMBwNyvMC1O2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XD5FaGOkPdgbDClMeNf1MV3W0/v8w8BLLJ4C49tXwk=;
 b=w1L85MLXfmj1BtFozPetyTRUdldBfOVFJWZfuQrzDT0uimgx4u6aNRrdxE3PFiUH4AEA1DkYjmDhhYV8Q7tIarxytOqDZxRFdzaOXVRD9iLCMYzAFpPaqrtRk5iqOb5S/2egb4eBbXJ2ovg5Ah28AKl0JRsFmnVdvJ5btkR1SQI=
Received: from BN9PR03CA0892.namprd03.prod.outlook.com (2603:10b6:408:13c::27)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 02:27:20 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::75) by BN9PR03CA0892.outlook.office365.com
 (2603:10b6:408:13c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 02:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 02:27:20 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 21:27:14 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH] Fix warnings in amdgpu _sdma, _ucode.c
Date: Thu, 18 May 2023 07:56:45 +0530
Message-ID: <20230518022645.2535481-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: abfaed82-169b-4dee-9ca5-08db57476806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o29ynUQYKbE4gMpJ+7XmipTuWp02x65BaGfhp6bjokHYhYM6iAjiR00n9njsaFp+2AuQaSaRCzNAOOLnsZWtCCsGDbzY+AvaneFR+56aW+0ReO1rb43yj7vISY6beG98d1T0LFX2H39O0cRqjs3Vot1uZLGtvlE8rwTjAajPyZisoRNAP5oeQkust4QqErGMkwuw3dRFd4lgIRodECfITgV6IlQ2QYHFsylYxy8a96YbtBBqYw+VWG+xuHXokbbIuqMogUthGCKTMau8fzCKhehE0NSHW0/atcnEQMn8IAHQ/0uq2X0AN28goairh4yD8v0XGto9a6xvGBpZJ+TFe9Z3ZBYJMdcBtiNnlek3gcWvtpZMxUS0lwS2i+vLTgq1CdNgUpWGSq8XRsh+IO7VGdQwjRBURf3NOwscHmKKWIJT29iqEkGp8ihubAmGBU1Z/VceF3U2UBESUpIZKqTN9W/ZbEqc63jfdqp+VJHb6rOYnAeghV4BrVtj62UmdGIceEOwoVz+h5zgLbnue82MK8gK+qGHgmeGBsFk8urWLshSnAK6HhedZPxZPAdrj8+SjKcPHPfq0mR2brlIj24z2Inp1nufcwiHpxIY/er83oaz45v7cOJSsYHTdAs6eKtloxz3jfU5N4s+hXkUrjegcjYVHSrZOpdg9ucDETDms1EE6i/o1vZgf121acgO5oURi0t2LCncyvztQJN74EQpN88j2UikbQ57Cr4zoCs4glhmU+nhGYvfosDLYt/JTSKMEBreI+eVlC7rUVOsVHSGRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(6666004)(70586007)(70206006)(4326008)(110136005)(36756003)(54906003)(6636002)(478600001)(7696005)(316002)(40460700003)(82310400005)(86362001)(47076005)(426003)(336012)(186003)(36860700001)(66574015)(2616005)(81166007)(356005)(1076003)(82740400003)(5660300002)(40480700001)(2906002)(8936002)(8676002)(41300700001)(44832011)(16526019)(26005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:27:20.2146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfaed82-169b-4dee-9ca5-08db57476806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below checkpatch warnings:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: Comparisons should place the constant on the right side of the test
WARNING: Missing a blank line after declarations

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..9568adaad5cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -64,7 +64,7 @@ int amdgpu_sdma_get_index_from_ring(struct amdgpu_ring *ring, uint32_t *index)
 }
 
 uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
-				     unsigned vmid)
+				     unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint64_t csa_mc_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index f76b1cb8baf8..16807ff96dc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -748,7 +748,7 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 	const struct imu_firmware_header_v1_0 *imu_hdr = NULL;
 	u8 *ucode_addr;
 
-	if (NULL == ucode->fw)
+	if (!ucode->fw)
 		return 0;
 
 	ucode->mc_addr = mc_addr;
@@ -972,7 +972,7 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
 	uint8_t *src_addr = NULL;
 	uint8_t *dst_addr = NULL;
 
-	if (NULL == ucode->fw)
+	if (!ucode->fw)
 		return 0;
 
 	comm_hdr = (const struct common_firmware_header *)ucode->fw->data;
@@ -1043,6 +1043,7 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 			if (i == AMDGPU_UCODE_ID_CP_MEC1 &&
 			    adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				const struct gfx_firmware_header_v1_0 *cp_hdr;
+
 				cp_hdr = (const struct gfx_firmware_header_v1_0 *)ucode->fw->data;
 				amdgpu_ucode_patch_jt(ucode,  adev->firmware.fw_buf_mc + fw_offset,
 						    adev->firmware.fw_buf_ptr + fw_offset);
-- 
2.25.1

