Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD5C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0999A21744
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w7v1hoQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0999A21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89856E4DE;
	Mon, 20 Apr 2020 10:17:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72856E508
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC005Kxt/FGcgntW7E6k7dhJ2SUcXC+Q+sKns1qmKlsyv8ZxWGkpTjrmEUqdBw3EXKgfsqaWsrs0R1YwcDO4zT1TqJKz1BbsNuRER3SYht47e0JT3FnA/9U6CGYJk+TWooxs05t4l0nSg1L0Eu4az8p8IAcbekWh9nTYaGVlmxu1MKQZVFE5DujX/DMNs4xv+HYQUc3FqFihGADR/TuKK9Lu+T4zwRfV8D2R73gyacayC0qHwE5r8iWeO7f+ae0OQSPwAQdB4FjogPC1FbRF4JUhJCaGIr6wTrKYAeAUzPNvFIGv0cXmPxk3FQr4Z4VYKhNR4QqacDANk/ghd+5t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92T9lSbEiu+IfJTyfbaplFWlCufeW0woJZXtqYQnJUY=;
 b=gRwWKZIoGOp8WsJCO9LpMBVY99P6+autGXcWCgvMbl/7Ak0IBjFoHWdA5OmVIhqBlmnWELFTySnS+l526bQzcvY0LaPfgcjrQgu3xpU3GDkxKvcxsWqMqBPcYl4Ar0fc+PQ6JbdPiLhzKEqLaFfj4lutZ9fQHWSqQ9m45Fc/O/L5PXgFkGhjC+bd4h1tTEIcgvo4SzrIXGI7H4Gf3HNVKuHnidD8FAHGrDCEITQgJhdVDtp+yau1yVuWWDPqU0lsOC2t2d1gUkf7wQ0er7opRb10qh9wn4kxHYkpuaG1UZzbcCr4Cq0CnVoZONmILlIOi4NKw3Pf+JJGmT4oBDUjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92T9lSbEiu+IfJTyfbaplFWlCufeW0woJZXtqYQnJUY=;
 b=w7v1hoQwfu7uro9wfsAvNcOSLKVbqUYzwN8FLHLq7T12Z1u7VTUc9o1HhGnupwbfGVG4BENliqCMjt1xL3dNHA4BgSVUHDapgfxcvm+x3/jROyi2mkNkiErO6wFK9a+ojWwBKfWme+glY1M8pR/5Vf/sbC6jU1PdbjT1qL6IHxw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:17:20 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:17:20 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: retire unused check_fw_loading status
Date: Mon, 20 Apr 2020 18:16:39 +0800
Message-Id: <1587377804-3836-4-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:17:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7a783b6-28d1-47da-0f54-08d7e5140241
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225520E962156316D0A2A70FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(30864003)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpy3Un/b2edg6PlkROHPxwioV6n57pVLYD4AitB8D2G4pg4jMzh1EBrL9DY5xMTP9E9M2c+s/iH5pfVr32dCzh9CptFbEDcj7RXbzmQyP+n5mowt/Q7JtuMR7ZbvzOpOnWnqJ7+iXXASusxT4/18rDUHv1eEJnxjxmNMj2iPRMV5PEqM+8UslZ4J/DeJSGK1gc/eOkxanpOezJYaCS8jgoj1SrfGZ3xeDu9uQVBq5YFx5htM0GBIbXq/edvCtxXuECu8doUXFQuwbcqlcFZ843esn+MsD+ALQGis8KVGMhkPe7KPL7e8tU3R8GbUgDNDHgcMv3Th0R+0rHGdQztfddUmWGRBGRL4BX9l1ZFJYkoNABMx3TIIISi7SLEI72JfEs0PIpcaV39hyewXw8LjgWLxGWKRaCPFZ94JJI8/M4sar6McBDFVFpgw1YnlNQKQ
X-MS-Exchange-AntiSpam-MessageData: WRgSbiot7A3xNRoi7LbSoo6xVv+RP+TuHmKYByyMCTLUZWsVLlthaiMYQM+rxXDBW3JdGxpeInIEc49X75vu62kC9DU6IZG6MiIPNoKExTI1iR/3fyXjk7x9sbSL/CnhSWhLd9yFrIPfgaJLrwolwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a783b6-28d1-47da-0f54-08d7e5140241
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:17:20.0888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf2YyF6J5XhpVjEBnHQyq7wPmmFCrOekCFHYGjo3ISlc64OQ7PK4V4hq97WETGS184LPm5cX1phXkk+fAfNR3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is not allowed to read out engine sram via registers
to check the fw loading status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  34 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |   7 --
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 124 -----------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 133 --------------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 123 -----------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 123 -----------------------------
 6 files changed, 544 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 901ee79..7797065 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -37,8 +37,6 @@
 
 #include "amdgpu_ras.h"
 
-static void psp_set_funcs(struct amdgpu_device *adev);
-
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
 
@@ -82,8 +80,6 @@ static int psp_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
-	psp_set_funcs(adev);
-
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
@@ -1487,11 +1483,6 @@ static int psp_np_fw_load(struct psp_context *psp)
 				return ret;
 			}
 		}
-#if 0
-		/* check if firmware loaded sucessfully */
-		if (!amdgpu_psp_check_fw_loading_status(adev, i))
-			return -EINVAL;
-#endif
 	}
 
 	return 0;
@@ -1849,21 +1840,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	return 0;
 }
 
-static bool psp_check_fw_loading_status(struct amdgpu_device *adev,
-					enum AMDGPU_UCODE_ID ucode_type)
-{
-	struct amdgpu_firmware_info *ucode = NULL;
-
-	if (!adev->firmware.fw_size)
-		return false;
-
-	ucode = &adev->firmware.ucode[ucode_type];
-	if (!ucode->fw || !ucode->ucode_size)
-		return false;
-
-	return psp_compare_sram_data(&adev->psp, ucode, ucode_type);
-}
-
 static int psp_set_clockgating_state(void *handle,
 				     enum amd_clockgating_state state)
 {
@@ -2000,16 +1976,6 @@ static void psp_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
 }
 
-static const struct amdgpu_psp_funcs psp_funcs = {
-	.check_fw_loading_status = psp_check_fw_loading_status,
-};
-
-static void psp_set_funcs(struct amdgpu_device *adev)
-{
-	if (NULL == adev->firmware.funcs)
-		adev->firmware.funcs = &psp_funcs;
-}
-
 const struct amdgpu_ip_block_version psp_v3_1_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 65a7d0a..f8b1f03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -93,9 +93,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	int (*ring_destroy)(struct psp_context *psp,
 			    enum psp_ring_type ring_type);
-	bool (*compare_sram_data)(struct psp_context *psp,
-				  struct amdgpu_firmware_info *ucode,
-				  enum AMDGPU_UCODE_ID ucode_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
 	int (*xgmi_get_node_id)(struct psp_context *psp, uint64_t *node_id);
@@ -307,8 +304,6 @@ struct amdgpu_psp_funcs {
 #define psp_ring_create(psp, type) (psp)->funcs->ring_create((psp), (type))
 #define psp_ring_stop(psp, type) (psp)->funcs->ring_stop((psp), (type))
 #define psp_ring_destroy(psp, type) ((psp)->funcs->ring_destroy((psp), (type)))
-#define psp_compare_sram_data(psp, ucode, type) \
-		(psp)->funcs->compare_sram_data((psp), (ucode), (type))
 #define psp_init_microcode(psp) \
 		((psp)->funcs->init_microcode ? (psp)->funcs->init_microcode((psp)) : 0)
 #define psp_bootloader_load_kdb(psp) \
@@ -340,8 +335,6 @@ struct amdgpu_psp_funcs {
 #define psp_mem_training(psp, ops) \
 	((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
 
-#define amdgpu_psp_check_fw_loading_status(adev, i) (adev)->firmware.funcs->check_fw_loading_status((adev), (i))
-
 #define psp_ras_trigger_error(psp, info) \
 	((psp)->funcs->ras_trigger_error ? \
 	(psp)->funcs->ras_trigger_error((psp), (info)) : -EINVAL)
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 7539104..6e041b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -230,129 +230,6 @@ static int psp_v10_0_ring_destroy(struct psp_context *psp,
 	return ret;
 }
 
-static int
-psp_v10_0_sram_map(struct amdgpu_device *adev,
-		   unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
-		   unsigned int *sram_data_reg_offset,
-		   enum AMDGPU_UCODE_ID ucode_id)
-{
-	int ret = 0;
-
-	switch(ucode_id) {
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SMC:
-		*sram_offset = 0;
-		*sram_addr_reg_offset = 0;
-		*sram_data_reg_offset = 0;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_CP_CE:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_PFP:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_ME:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC1:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC2:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_RLC_G:
-		*sram_offset = 0x2000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_SDMA0:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
-		break;
-
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SDMA1:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_UVD:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_VCE:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_MAXIMUM:
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static bool psp_v10_0_compare_sram_data(struct psp_context *psp,
-					struct amdgpu_firmware_info *ucode,
-					enum AMDGPU_UCODE_ID ucode_type)
-{
-	int err = 0;
-	unsigned int fw_sram_reg_val = 0;
-	unsigned int fw_sram_addr_reg_offset = 0;
-	unsigned int fw_sram_data_reg_offset = 0;
-	unsigned int ucode_size;
-	uint32_t *ucode_mem = NULL;
-	struct amdgpu_device *adev = psp->adev;
-
-	err = psp_v10_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
-				&fw_sram_data_reg_offset, ucode_type);
-	if (err)
-		return false;
-
-	WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
-
-	ucode_size = ucode->ucode_size;
-	ucode_mem = (uint32_t *)ucode->kaddr;
-	while (!ucode_size) {
-		fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
-
-		if (*ucode_mem != fw_sram_reg_val)
-			return false;
-
-		ucode_mem++;
-		/* 4 bytes */
-		ucode_size -= 4;
-	}
-
-	return true;
-}
-
-
 static int psp_v10_0_mode1_reset(struct psp_context *psp)
 {
 	DRM_INFO("psp mode 1 reset not supported now! \n");
@@ -379,7 +256,6 @@ static const struct psp_funcs psp_v10_0_funcs = {
 	.ring_create = psp_v10_0_ring_create,
 	.ring_stop = psp_v10_0_ring_stop,
 	.ring_destroy = psp_v10_0_ring_destroy,
-	.compare_sram_data = psp_v10_0_compare_sram_data,
 	.mode1_reset = psp_v10_0_mode1_reset,
 	.ring_get_wptr = psp_v10_0_ring_get_wptr,
 	.ring_set_wptr = psp_v10_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 20fbd43..f633577 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -554,138 +554,6 @@ static int psp_v11_0_ring_destroy(struct psp_context *psp,
 	return ret;
 }
 
-static int
-psp_v11_0_sram_map(struct amdgpu_device *adev,
-		  unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
-		  unsigned int *sram_data_reg_offset,
-		  enum AMDGPU_UCODE_ID ucode_id)
-{
-	int ret = 0;
-
-	switch (ucode_id) {
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SMC:
-		*sram_offset = 0;
-		*sram_addr_reg_offset = 0;
-		*sram_data_reg_offset = 0;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_CP_CE:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_PFP:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_ME:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC1:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC2:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_RLC_G:
-		*sram_offset = 0x2000;
-		if (adev->asic_type < CHIP_NAVI10) {
-			*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
-			*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
-		} else {
-			*sram_addr_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmRLC_GPM_UCODE_ADDR_NV10;
-			*sram_data_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmRLC_GPM_UCODE_DATA_NV10;
-		}
-		break;
-
-	case AMDGPU_UCODE_ID_SDMA0:
-		*sram_offset = 0x0;
-		if (adev->asic_type < CHIP_NAVI10) {
-			*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
-			*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
-		} else {
-			*sram_addr_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmSDMA0_UCODE_ADDR_NV10;
-			*sram_data_reg_offset = adev->reg_offset[GC_HWIP][0][1] + mmSDMA0_UCODE_DATA_NV10;
-		}
-		break;
-
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SDMA1:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_UVD:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_VCE:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_MAXIMUM:
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static bool psp_v11_0_compare_sram_data(struct psp_context *psp,
-				       struct amdgpu_firmware_info *ucode,
-				       enum AMDGPU_UCODE_ID ucode_type)
-{
-	int err = 0;
-	unsigned int fw_sram_reg_val = 0;
-	unsigned int fw_sram_addr_reg_offset = 0;
-	unsigned int fw_sram_data_reg_offset = 0;
-	unsigned int ucode_size;
-	uint32_t *ucode_mem = NULL;
-	struct amdgpu_device *adev = psp->adev;
-
-	err = psp_v11_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
-				&fw_sram_data_reg_offset, ucode_type);
-	if (err)
-		return false;
-
-	WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
-
-	ucode_size = ucode->ucode_size;
-	ucode_mem = (uint32_t *)ucode->kaddr;
-	while (ucode_size) {
-		fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
-
-		if (*ucode_mem != fw_sram_reg_val)
-			return false;
-
-		ucode_mem++;
-		/* 4 bytes */
-		ucode_size -= 4;
-	}
-
-	return true;
-}
-
 static int psp_v11_0_mode1_reset(struct psp_context *psp)
 {
 	int ret;
@@ -1190,7 +1058,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_create = psp_v11_0_ring_create,
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
-	.compare_sram_data = psp_v11_0_compare_sram_data,
 	.mode1_reset = psp_v11_0_mode1_reset,
 	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
 	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index d3c86a0..42c485b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -324,128 +324,6 @@ static int psp_v12_0_ring_destroy(struct psp_context *psp,
 	return ret;
 }
 
-static int
-psp_v12_0_sram_map(struct amdgpu_device *adev,
-		  unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
-		  unsigned int *sram_data_reg_offset,
-		  enum AMDGPU_UCODE_ID ucode_id)
-{
-	int ret = 0;
-
-	switch (ucode_id) {
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SMC:
-		*sram_offset = 0;
-		*sram_addr_reg_offset = 0;
-		*sram_data_reg_offset = 0;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_CP_CE:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_PFP:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_ME:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC1:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC2:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_RLC_G:
-		*sram_offset = 0x2000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_SDMA0:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
-		break;
-
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SDMA1:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_UVD:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_VCE:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_MAXIMUM:
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static bool psp_v12_0_compare_sram_data(struct psp_context *psp,
-				       struct amdgpu_firmware_info *ucode,
-				       enum AMDGPU_UCODE_ID ucode_type)
-{
-	int err = 0;
-	unsigned int fw_sram_reg_val = 0;
-	unsigned int fw_sram_addr_reg_offset = 0;
-	unsigned int fw_sram_data_reg_offset = 0;
-	unsigned int ucode_size;
-	uint32_t *ucode_mem = NULL;
-	struct amdgpu_device *adev = psp->adev;
-
-	err = psp_v12_0_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
-				&fw_sram_data_reg_offset, ucode_type);
-	if (err)
-		return false;
-
-	WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
-
-	ucode_size = ucode->ucode_size;
-	ucode_mem = (uint32_t *)ucode->kaddr;
-	while (ucode_size) {
-		fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
-
-		if (*ucode_mem != fw_sram_reg_val)
-			return false;
-
-		ucode_mem++;
-		/* 4 bytes */
-		ucode_size -= 4;
-	}
-
-	return true;
-}
-
 static int psp_v12_0_mode1_reset(struct psp_context *psp)
 {
 	int ret;
@@ -512,7 +390,6 @@ static const struct psp_funcs psp_v12_0_funcs = {
 	.ring_create = psp_v12_0_ring_create,
 	.ring_stop = psp_v12_0_ring_stop,
 	.ring_destroy = psp_v12_0_ring_destroy,
-	.compare_sram_data = psp_v12_0_compare_sram_data,
 	.mode1_reset = psp_v12_0_mode1_reset,
 	.ring_get_wptr = psp_v12_0_ring_get_wptr,
 	.ring_set_wptr = psp_v12_0_ring_set_wptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index ab03190..9ca37d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -398,128 +398,6 @@ static int psp_v3_1_ring_destroy(struct psp_context *psp,
 	return ret;
 }
 
-static int
-psp_v3_1_sram_map(struct amdgpu_device *adev,
-		  unsigned int *sram_offset, unsigned int *sram_addr_reg_offset,
-		  unsigned int *sram_data_reg_offset,
-		  enum AMDGPU_UCODE_ID ucode_id)
-{
-	int ret = 0;
-
-	switch(ucode_id) {
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SMC:
-		*sram_offset = 0;
-		*sram_addr_reg_offset = 0;
-		*sram_data_reg_offset = 0;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_CP_CE:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_CE_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_PFP:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_PFP_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_ME:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_ME_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC1:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_MEC_ME1_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_CP_MEC2:
-		*sram_offset = 0x10000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_HYP_MEC2_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_RLC_G:
-		*sram_offset = 0x2000;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(GC, 0, mmRLC_GPM_UCODE_DATA);
-		break;
-
-	case AMDGPU_UCODE_ID_SDMA0:
-		*sram_offset = 0x0;
-		*sram_addr_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_ADDR);
-		*sram_data_reg_offset = SOC15_REG_OFFSET(SDMA0, 0, mmSDMA0_UCODE_DATA);
-		break;
-
-/* TODO: needs to confirm */
-#if 0
-	case AMDGPU_UCODE_ID_SDMA1:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_UVD:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-
-	case AMDGPU_UCODE_ID_VCE:
-		*sram_offset = ;
-		*sram_addr_reg_offset = ;
-		break;
-#endif
-
-	case AMDGPU_UCODE_ID_MAXIMUM:
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static bool psp_v3_1_compare_sram_data(struct psp_context *psp,
-				       struct amdgpu_firmware_info *ucode,
-				       enum AMDGPU_UCODE_ID ucode_type)
-{
-	int err = 0;
-	unsigned int fw_sram_reg_val = 0;
-	unsigned int fw_sram_addr_reg_offset = 0;
-	unsigned int fw_sram_data_reg_offset = 0;
-	unsigned int ucode_size;
-	uint32_t *ucode_mem = NULL;
-	struct amdgpu_device *adev = psp->adev;
-
-	err = psp_v3_1_sram_map(adev, &fw_sram_reg_val, &fw_sram_addr_reg_offset,
-				&fw_sram_data_reg_offset, ucode_type);
-	if (err)
-		return false;
-
-	WREG32(fw_sram_addr_reg_offset, fw_sram_reg_val);
-
-	ucode_size = ucode->ucode_size;
-	ucode_mem = (uint32_t *)ucode->kaddr;
-	while (ucode_size) {
-		fw_sram_reg_val = RREG32(fw_sram_data_reg_offset);
-
-		if (*ucode_mem != fw_sram_reg_val)
-			return false;
-
-		ucode_mem++;
-		/* 4 bytes */
-		ucode_size -= 4;
-	}
-
-	return true;
-}
-
 static bool psp_v3_1_smu_reload_quirk(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
@@ -596,7 +474,6 @@ static const struct psp_funcs psp_v3_1_funcs = {
 	.ring_create = psp_v3_1_ring_create,
 	.ring_stop = psp_v3_1_ring_stop,
 	.ring_destroy = psp_v3_1_ring_destroy,
-	.compare_sram_data = psp_v3_1_compare_sram_data,
 	.smu_reload_quirk = psp_v3_1_smu_reload_quirk,
 	.mode1_reset = psp_v3_1_mode1_reset,
 	.ring_get_wptr = psp_v3_1_ring_get_wptr,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
