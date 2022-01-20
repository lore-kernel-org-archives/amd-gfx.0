Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C625C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 11:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDCCC10E34F;
	Thu, 20 Jan 2022 11:26:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A648A10E34F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 11:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVycG3hNkumShHBhKewTrd9MtQ3Sfhf9/SPMS468k66fcn378WHf9E9AbnI77JWcXOprsxtZ4ai0HoLapmKbO45sTswgirQUPCJCypvTdNMJy3P7T1Nqs4+d6in3HcDWPx+SMY/ORs2pg31RffCWSxDJ7bwnwW4lv1kMjTLrEHWaCkd4ud/AXXGIN61ndpHd8KnyuPeLey8tPLt0CeR8rQyohiMBJfvpmn7LqagmmQl7wFjk1irRZP6cMoz32bAQePE56oiNCBAwdPhbvnaF+po7b7FjMJEoqCPao/uQ2vavd+97c3743tjCIyIP/3D9ZrBzJv6Xu0Ybv1pWywtj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otPilGCauDYjDSAHnflwJ0L41BFOOn1f8n0ZlTkCZm8=;
 b=gHT0gfAZC0EtW4ZvgulX2zFEvWevVSfUiDQ0KTUoWc6xNnOPpqTjrIPT7IZ61KaIu5XcoED996o9T9xuiZ6D0tPC39MontzAOCB5werqo3TE3axBfjhYhmDNDwedzF/uuFI00man8TlfiioT/f3PvBh0iZL2qAVA3fzZdud4hrG/YE9EkA0JXuYBlaGReadrxZyS4mwMZO6hQtJ2A7beGIy/qcg9FaiLnb/S4ld4d/BizLSzg4CtPbbltkq3R6PCXldPRlh+8HfZTKOfCW/zPD3JG74F24uLBUTCRSa6sSgA318j+BgpnClVINl/m2P9GNxrh3Dra8FE79y8sZQpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otPilGCauDYjDSAHnflwJ0L41BFOOn1f8n0ZlTkCZm8=;
 b=WzmtqpRq/v/TcbRGqCnIKhYhp+kqcJaJ3wkU2Qd07lgMNGwNB0R/Ecj8hGYPMZ4mezvzquXwY2ePEsci3U0D0LptMB2pxk4mHf2OJASYZuhhO9dyx5mhCpBGjdCTyoyDcdmy1JPxIw4VGsehHNMn5gMbuatLkCQboqbWHI4HjUg=
Received: from CO1PR15CA0051.namprd15.prod.outlook.com (2603:10b6:101:1f::19)
 by DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 11:26:41 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:1f:cafe::8f) by CO1PR15CA0051.outlook.office365.com
 (2603:10b6:101:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 11:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 11:26:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 05:26:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 03:26:39 -0800
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.18 via Frontend Transport; Thu, 20 Jan 2022 05:26:38
 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: switch to common helper to read bios from rom
Date: Thu, 20 Jan 2022 19:26:35 +0800
Message-ID: <20220120112635.11904-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a844ea00-e8ef-4b96-af74-08d9dc07bb28
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB519961D56AE81A5C08711D55FC5A9@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pbsq3rN5JPyPIzT2Uac+p7g5szjGN5d8PaFzBPnQvgwzYt6EvkgIH6W+Tpu8AYQ1e1nErlicbT3D56sbYB67DAMx08EuQQeDRPPvcgnKxLA8i461LBfwUURcCDe5Y939IqcCnOx2LCPK9D1TD9zilMOb9pS2rPOhCY9iC6hqXqyGzFPgBX3GJPhD0/FC3LQGL9uYU77o1+Dr6GXzsR9n8T2q5Sg5bEltMphLP3bqB8BdB9lH1seT9bEMTRaLp3IEKkbMfoktEL6AwKjZPY6RoutL/DAqk5QKu7F1DH7lAcHLStcWr8hviDt8mWNcP76w3a73LNnkGaB9KWqDyWXVkiST29/b6ybfBKLNUdU1CPkR7P0P56D4/5bAg/0omn4vtMcA4hrI6UbS2zA9hoEb2PT2qy8jf2pByd+3o09OS6eMA7idzLCFzOLXlxqULxThGx25dJLKWpz4eNYdXFjXCt5raJTW6/cSGNRuCnW+NAB9ZL8PNHUaxnfcE7BUVuglraoXC/fbb3P0DsdEMrrnic7peoCdzug7Wx5M0dkS15U2JbQdt5tpiIgYGeWWGms6XyYG3EF8/e53vrA0tq79ZE9UuSESmmi/qMmBW6lX6MKNpv8dyH5DZAwzdCKncLzOTJ2SvAjBIEZUsiRm0JWSOb56CU1GdpcZv5IV+t6tI74MMfBCJIcIV423S3mIYPT8lv56ZIr32+7FEuryNRSgiy6U1qN2/PR8ynPCU4NKCKy9thJpJKknDwiLS3vyDpTYY+yvHOXgMlSg6dSRrtC9y7+jGYbHpvdiJr2DMDoxxoQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(336012)(8936002)(8676002)(40460700001)(6636002)(110136005)(47076005)(316002)(356005)(81166007)(83380400001)(186003)(508600001)(36756003)(86362001)(5660300002)(36860700001)(1076003)(26005)(4326008)(426003)(2616005)(2906002)(82310400004)(7696005)(6666004)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 11:26:41.0804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a844ea00-e8ef-4b96-af74-08d9dc07bb28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

create a common helper function for soc15 and onwards
to read bios image from rom

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 38 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c          | 34 +--------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c       | 37 ++---------------------
 4 files changed, 43 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8a7759147fb2..b2da840f4718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,7 +378,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
  */
 bool amdgpu_get_bios(struct amdgpu_device *adev);
 bool amdgpu_read_bios(struct amdgpu_device *adev);
-
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
+				     u8 *bios, u32 length_bytes);
 /*
  * Clocks
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index ca0503d56e5c..a819828408fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -476,3 +476,41 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
 	adev->is_atom_fw = (adev->asic_type >= CHIP_VEGA10) ? true : false;
 	return true;
 }
+
+/* helper function for soc15 and onwards to read bios from rom */
+bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
+				     u8 *bios, u32 length_bytes)
+{
+	u32 *dw_ptr;
+	u32 i, length_dw;
+	u32 rom_index_offset;
+	u32 rom_data_offset;
+
+	if (bios == NULL)
+		return false;
+	if (length_bytes == 0)
+		return false;
+	/* APU vbios image is part of sbios image */
+	if (adev->flags & AMD_IS_APU)
+		return false;
+	if (!adev->smuio.funcs ||
+	    !adev->smuio.funcs->get_rom_index_offset ||
+	    !adev->smuio.funcs->get_rom_data_offset)
+		return false;
+
+	dw_ptr = (u32 *)bios;
+	length_dw = ALIGN(length_bytes, 4) / 4;
+
+	rom_index_offset =
+		adev->smuio.funcs->get_rom_index_offset(adev);
+	rom_data_offset =
+		adev->smuio.funcs->get_rom_data_offset(adev);
+
+	/* set rom index to 0 */
+	WREG32(rom_index_offset, 0);
+	/* read out the rom data */
+	for (i = 0; i < length_dw; i++)
+		dw_ptr[i] = RREG32(rom_data_offset);
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3ccd3b42196a..e52d1114501c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -358,38 +358,6 @@ static bool nv_read_disabled_bios(struct amdgpu_device *adev)
 	return false;
 }
 
-static bool nv_read_bios_from_rom(struct amdgpu_device *adev,
-				  u8 *bios, u32 length_bytes)
-{
-	u32 *dw_ptr;
-	u32 i, length_dw;
-	u32 rom_index_offset, rom_data_offset;
-
-	if (bios == NULL)
-		return false;
-	if (length_bytes == 0)
-		return false;
-	/* APU vbios image is part of sbios image */
-	if (adev->flags & AMD_IS_APU)
-		return false;
-
-	dw_ptr = (u32 *)bios;
-	length_dw = ALIGN(length_bytes, 4) / 4;
-
-	rom_index_offset =
-		adev->smuio.funcs->get_rom_index_offset(adev);
-	rom_data_offset =
-		adev->smuio.funcs->get_rom_data_offset(adev);
-
-	/* set rom index to 0 */
-	WREG32(rom_index_offset, 0);
-	/* read out the rom data */
-	for (i = 0; i < length_dw; i++)
-		dw_ptr[i] = RREG32(rom_data_offset);
-
-	return true;
-}
-
 static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2)},
@@ -707,7 +675,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 static const struct amdgpu_asic_funcs nv_asic_funcs =
 {
 	.read_disabled_bios = &nv_read_disabled_bios,
-	.read_bios_from_rom = &nv_read_bios_from_rom,
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &nv_read_register,
 	.reset = &nv_asic_reset,
 	.reset_method = &nv_asic_reset_method,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0fc1747e4a70..e5a1950fb862 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -375,39 +375,6 @@ static bool soc15_read_disabled_bios(struct amdgpu_device *adev)
 	return false;
 }
 
-static bool soc15_read_bios_from_rom(struct amdgpu_device *adev,
-				     u8 *bios, u32 length_bytes)
-{
-	u32 *dw_ptr;
-	u32 i, length_dw;
-	uint32_t rom_index_offset;
-	uint32_t rom_data_offset;
-
-	if (bios == NULL)
-		return false;
-	if (length_bytes == 0)
-		return false;
-	/* APU vbios image is part of sbios image */
-	if (adev->flags & AMD_IS_APU)
-		return false;
-
-	dw_ptr = (u32 *)bios;
-	length_dw = ALIGN(length_bytes, 4) / 4;
-
-	rom_index_offset =
-		adev->smuio.funcs->get_rom_index_offset(adev);
-	rom_data_offset =
-		adev->smuio.funcs->get_rom_data_offset(adev);
-
-	/* set rom index to 0 */
-	WREG32(rom_index_offset, 0);
-	/* read out the rom data */
-	for (i = 0; i < length_dw; i++)
-		dw_ptr[i] = RREG32(rom_data_offset);
-
-	return true;
-}
-
 static struct soc15_allowed_register_entry soc15_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2)},
@@ -925,7 +892,7 @@ static void soc15_pre_asic_init(struct amdgpu_device *adev)
 static const struct amdgpu_asic_funcs soc15_asic_funcs =
 {
 	.read_disabled_bios = &soc15_read_disabled_bios,
-	.read_bios_from_rom = &soc15_read_bios_from_rom,
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &soc15_read_register,
 	.reset = &soc15_asic_reset,
 	.reset_method = &soc15_asic_reset_method,
@@ -947,7 +914,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
 {
 	.read_disabled_bios = &soc15_read_disabled_bios,
-	.read_bios_from_rom = &soc15_read_bios_from_rom,
+	.read_bios_from_rom = &amdgpu_soc15_read_bios_from_rom,
 	.read_register = &soc15_read_register,
 	.reset = &soc15_asic_reset,
 	.reset_method = &soc15_asic_reset_method,
-- 
2.17.1

