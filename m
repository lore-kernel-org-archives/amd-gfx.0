Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B64C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1F12083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eMR1HClW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1F12083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156C36E964;
	Thu,  7 May 2020 09:59:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8C16E964
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:59:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQleSo+xl2SGHZHS5jHZlGTEhAyv+R9u9F43yVgOwab3mg2Mhy5lYfT+T3X8NqewpJl3D0aF5VNe3NmLnLXXZ9I4kFhXic/xmNEvXKCFvlN0tuGxtkdby1EZR1BimC3ayqy29sLyTS4JfQt5jnsN3Mgkoe0du/Wrqi8750OYau5jxYyA3SzF2RhUQLBU3S6cEebhDAomq3HdzkhZVtjcxPjM+NrfoyD0ntdmAgXrLqUjiyrigcpK2XpY412bUlWkP6Xox1D5M+5NbfVvyb27M4ULgqxUQepyNDIMuAnPtHh3V8OQ6NKjCdqEe2E/qUYTK/EJuM7xDtc3KU1k6dinTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq+pegckfHpNKTWoiGUhNskdkKrWMzH3XXoEo/3S8vk=;
 b=XgjdRZyJY8J+jXaoiCFPe94Gilyx47qZVUV7sg7y7A4IKZZ9uJ7OrabKuTC5dk8LlMldszMkNA7OqTfLzNerBj7sSFc77CfZm9sJipm2/mwh5fiOTobuBY4PIzPw52uoGx/50pJiyJVrSjkBiCle4+VktZXggrdE3jS/MM7PWimhTJEF+UlZIa+f8rQIa4i07CkV7zmXE7qbE6ySp8oAkeBdgbptGjH8uEn/EgnV4EJf6wVFB1tBK6VmoKJYweHmfLsv43wW0pueDBe/1jwUuqTUuCD1S+WuCvqDLRiFBnkS3vl/OrkSJLWFiVpSt8WUR2XInVRpsDLBcfvt2O27BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq+pegckfHpNKTWoiGUhNskdkKrWMzH3XXoEo/3S8vk=;
 b=eMR1HClWEzFVLtk1UejAgYJSkFjVFgzt9+d2Eypz+6TUglYURG9oNQFRqPfxGFXPO2K+8C3KnGB7RsWRWVpVcnYMVocvXF9m/PE7tA41Lmp0qgqahwnNkg+U9wdr1dXZKqXLz1yaaitetwcwI3pin83XCNWNPQ6igQnSDJNAZog=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 09:59:17 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 09:59:17 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: cleanup sriov mode check in internal swsmu
 driver
Date: Thu,  7 May 2020 17:57:04 +0800
Message-Id: <20200507095704.25623-4-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507095704.25623-1-kevin1.wang@amd.com>
References: <20200507095704.25623-1-kevin1.wang@amd.com>
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK0PR03CA0098.apcprd03.prod.outlook.com (2603:1096:203:b0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 09:59:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9ba5595-bbb0-4677-1e50-08d7f26d4e34
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:|BY5PR12MB3666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB36668DD9121518ACBF9267B3A2A50@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzW1ZrfA76XyxGmN+4j7to4c5uLePLjJHOVO1+fhIyZZ0zK5R1exHzlrNOOiCZ8fXXEIRHqA2LYS8VLK9EqNwV+nQ7CgxbGHILmm7/WS3CExybwhFJwLY9eeitqtlzWv45aGbUstBMVPAeYph1tX/ggIcMGo1S1SXRD1GfbcddzXxSMpplQrVkJdDOJ89uypo1Oqhq6714CmvtlYEhR5Cx66xdzRzFZ2oUH/L04tk6fw/ch04PQ6k1Myh//9EeeBWb0I7mcOCaAvgKSb2QIMGQRKJYEJJv0/gYhix0HEvNBvUpr0yL2ciruIAgWlVlq3BwahwH8fwaziNklHBgi88XpueoN4Qg9+vmekju6uD9Q7G1B20EIoTFNZG0joS9vgIbUR6EcLLwXSGxTaA1hlraZaQhx9z6OjZ8+4ZVLH61NRwCTVZx1xdMqyFY8RoU7tB8uD/28l+W4L6EDpV7sL1G0e9vb8OdNgibu1wrdUDCqpS5zbTrDjwGqVGkXp/+Imaq1vvx9+GtPWDyjO3QV7nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(33430700001)(33440700001)(316002)(83290400001)(478600001)(2906002)(26005)(83280400001)(66574014)(83310400001)(83300400001)(83320400001)(16526019)(7696005)(186003)(52116002)(19627235002)(6916009)(6486002)(86362001)(36756003)(66556008)(6666004)(4326008)(8676002)(1076003)(8936002)(66946007)(66476007)(30864003)(956004)(2616005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZzIn05hpAw1GuiCpBfFKyRvZTaJF41ErJ6mLwMbAcG+FBp9fSke/MpriNr+xqW39EyfUYgj/lLCzUiCdvOnC8vMlt5jz3kVY6yDcICn4CDYsw3rirHuSvDyLHuLSOhNAWjRsno6kro7iXz/7Ng4QKa4nUY8skMGbROt9LLDMv/7wD+eGE7IHnDs3sjAf5K7nSErCA6tk4bx/0BXAqh1AlP5nCjlcJtNjVR7eMiVMCDvRCCZ99I8MGSmDKpruLfVZ3m1mTXu5zmlcz+3+E499whLazDAi60CALJpOtxNllVicyDU0TjiDev/V3rq3PtHPGnF3qP+3GtbqNezQbxVOFWomDaLL+GtiumvKi5yG65WGHAG7oRYy3GXUdRLjGbAXg/KoiAXnwB/0hgP9itTjgJPsqYqq9WXBi+UWuJZPWfFrHOzaM6tt/2iu9v4j0rhvj8nNPPGgWL08rJdK0IA+VKUu22v5AxmtkB0lFP+5pNsf3n9yaytB3cqG9hpDsgdkxlYKJWv/093t9CsJq/iseK6Dhcf9qigD9y6b17ub9O14+LFV4HHyUSUv2HUTkk3Olftn8q3dXwOtzxMKob9AjlJeQnGY9LTP7BAiBpVgeaGxY9RFOR17VnVB2pMSYLet9pOKCL8sXnDQjQZoQ+zh6WmHngrp6Mh3FP5IrZidthAebbYgeMKeZxBgjWbAy9v5PwbX51EQkLVRQEyeYAX37358oGfefwuMtrxAEQW9rPGwse+yhfWDgxnsPJ2AEab33CS9g4OljFckb7xxFfP/TA6vdClNuKYtyD5/S5S0KJc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ba5595-bbb0-4677-1e50-08d7f26d4e34
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 09:59:17.6507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1eB+x2VCt80MsVmlYhWsLKc+4ijgaV4XG0GKuD+/36IQXWYR0xgtDAz0q4jtN3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 kenneth.feng@amd.com, monk.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cleanup unnecessary check in internal swsmu driver:
1. cleanup amdgpu_sriov_is_pp_one_vf() check logic.
2. cleanup amdgpu_sriov_vf() check logic.
3. add sw smu ip block according to different vf mode.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c              |  29 +++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c   | 170 ++++++++-----------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c |   7 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c   |   6 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c    |  24 ---
 5 files changed, 102 insertions(+), 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 9c42316c47c0..cef516b89a34 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -452,6 +452,7 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
+	enum amdgpu_sriov_vf_mode vf_mode;
 
 	adev->nbio.funcs = &nbio_v2_3_funcs;
 	adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
@@ -494,12 +495,22 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
 		break;
 	case CHIP_NAVI12:
+		vf_mode = amdgpu_virt_get_sriov_vf_mode(adev);
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			switch (vf_mode) {
+			case SRIOV_VF_MODE_BARE_METAL:
+			case SRIOV_VF_MODE_ONE_VF:
+				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+				break;
+			case SRIOV_VF_MODE_MULTI_VF:
+			default:
+				break;
+			}
+		}
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
@@ -508,9 +519,17 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v5_0_ip_block);
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-		    !amdgpu_sriov_vf(adev))
-			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			switch (vf_mode) {
+			case SRIOV_VF_MODE_BARE_METAL:
+			case SRIOV_VF_MODE_ONE_VF:
+				amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
+				break;
+			case SRIOV_VF_MODE_MULTI_VF:
+			default:
+				break;
+			}
+		}
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		if (!amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 607ff0270aee..8b305498a084 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -569,10 +569,9 @@ bool is_support_sw_smu(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_VEGA20)
 		return (amdgpu_dpm == 2) ? true : false;
-	else if (adev->asic_type >= CHIP_ARCTURUS) {
-	      if (amdgpu_sriov_is_pp_one_vf(adev) || !amdgpu_sriov_vf(adev))
-			return true;
-	}
+	else if (adev->asic_type >= CHIP_ARCTURUS)
+		return true;
+
 	return false;
 }
 
@@ -1131,59 +1130,58 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return ret;
 
 	/* smu_dump_pptable(smu); */
-	if (!amdgpu_sriov_vf(adev)) {
-		/*
-		 * Copy pptable bo in the vram to smc with SMU MSGs such as
-		 * SetDriverDramAddr and TransferTableDram2Smu.
-		 */
-		ret = smu_write_pptable(smu);
-		if (ret)
-			return ret;
-
-		/* issue Run*Btc msg */
-		ret = smu_run_btc(smu);
-		if (ret)
-			return ret;
-		ret = smu_feature_set_allowed_mask(smu);
-		if (ret)
-			return ret;
+	/*
+	 * Copy pptable bo in the vram to smc with SMU MSGs such as
+	 * SetDriverDramAddr and TransferTableDram2Smu.
+	 */
+	ret = smu_write_pptable(smu);
+	if (ret)
+		return ret;
 
-		ret = smu_system_features_control(smu, true);
-		if (ret)
-			return ret;
+	/* issue Run*Btc msg */
+	ret = smu_run_btc(smu);
+	if (ret)
+		return ret;
+	ret = smu_feature_set_allowed_mask(smu);
+	if (ret)
+		return ret;
 
-		if (adev->asic_type == CHIP_NAVI10) {
-			if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
-							      adev->pdev->revision == 0xc3 ||
-							      adev->pdev->revision == 0xca ||
-							      adev->pdev->revision == 0xcb)) ||
-			    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
-							      adev->pdev->revision == 0xf4 ||
-							      adev->pdev->revision == 0xf5 ||
-							      adev->pdev->revision == 0xf6))) {
-				ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-				if (ret) {
-					pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-					return ret;
-				}
-			}
-		}
+	ret = smu_system_features_control(smu, true);
+	if (ret)
+		return ret;
 
-		if (smu->ppt_funcs->set_power_source) {
-			/*
-			 * For Navi1X, manually switch it to AC mode as PMFW
-			 * may boot it with DC mode.
-			 */
-			if (adev->pm.ac_power)
-				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
-			else
-				ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+	if (adev->asic_type == CHIP_NAVI10) {
+		if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
+						      adev->pdev->revision == 0xc3 ||
+						      adev->pdev->revision == 0xca ||
+						      adev->pdev->revision == 0xcb)) ||
+		    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
+						      adev->pdev->revision == 0xf4 ||
+						      adev->pdev->revision == 0xf5 ||
+						      adev->pdev->revision == 0xf6))) {
+			ret = smu_disable_umc_cdr_12gbps_workaround(smu);
 			if (ret) {
-				pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+				pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
 				return ret;
 			}
 		}
 	}
+
+	if (smu->ppt_funcs->set_power_source) {
+		/*
+		 * For Navi1X, manually switch it to AC mode as PMFW
+		 * may boot it with DC mode.
+		 */
+		if (adev->pm.ac_power)
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_AC);
+		else
+			ret = smu_set_power_source(smu, SMU_POWER_SOURCE_DC);
+		if (ret) {
+			pr_err("Failed to switch to %s mode!\n", adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
+
 	if (adev->asic_type != CHIP_ARCTURUS) {
 		ret = smu_notify_display_change(smu);
 		if (ret)
@@ -1236,9 +1234,8 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	/*
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = smu_set_tool_table_location(smu);
-	}
+	ret = smu_set_tool_table_location(smu);
+
 	if (!smu_is_dpm_running(smu))
 		pr_info("dpm has been disabled\n");
 
@@ -1337,9 +1334,6 @@ static int smu_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		pr_err("SMU is not ready yet!\n");
@@ -1396,9 +1390,6 @@ static int smu_hw_init(void *handle)
 
 static int smu_stop_dpms(struct smu_context *smu)
 {
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	return smu_system_features_control(smu, false);
 }
 
@@ -1409,9 +1400,6 @@ static int smu_hw_fini(void *handle)
 	struct smu_table_context *table_context = &smu->smu_table;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, true);
 		smu_powergate_vcn(&adev->smu, true);
@@ -1425,33 +1413,31 @@ static int smu_hw_fini(void *handle)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-	if (!amdgpu_sriov_vf(adev)){
-		ret = smu_stop_thermal_control(smu);
+	ret = smu_stop_thermal_control(smu);
+	if (ret) {
+		pr_warn("Fail to stop thermal control!\n");
+		return ret;
+	}
+
+	/*
+	 * For custom pptable uploading, skip the DPM features
+	 * disable process on Navi1x ASICs.
+	 *   - As the gfx related features are under control of
+	 *     RLC on those ASICs. RLC reinitialization will be
+	 *     needed to reenable them. That will cost much more
+	 *     efforts.
+	 *
+	 *   - SMU firmware can handle the DPM reenablement
+	 *     properly.
+	 */
+	if (!smu->uploading_custom_pp_table ||
+			!((adev->asic_type >= CHIP_NAVI10) &&
+				(adev->asic_type <= CHIP_NAVI12))) {
+		ret = smu_stop_dpms(smu);
 		if (ret) {
-			pr_warn("Fail to stop thermal control!\n");
+			pr_warn("Fail to stop Dpms!\n");
 			return ret;
 		}
-
-		/*
-		 * For custom pptable uploading, skip the DPM features
-		 * disable process on Navi1x ASICs.
-		 *   - As the gfx related features are under control of
-		 *     RLC on those ASICs. RLC reinitialization will be
-		 *     needed to reenable them. That will cost much more
-		 *     efforts.
-		 *
-		 *   - SMU firmware can handle the DPM reenablement
-		 *     properly.
-		 */
-		if (!smu->uploading_custom_pp_table ||
-				!((adev->asic_type >= CHIP_NAVI10) &&
-					(adev->asic_type <= CHIP_NAVI12))) {
-			ret = smu_stop_dpms(smu);
-			if (ret) {
-				pr_warn("Fail to stop Dpms!\n");
-				return ret;
-			}
-		}
 	}
 
 	kfree(table_context->driver_pptable);
@@ -1558,9 +1544,6 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -1568,11 +1551,9 @@ static int smu_suspend(void *handle)
 
 	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-	if(!amdgpu_sriov_vf(adev)) {
-		ret = smu_disable_dpm(smu);
-		if (ret)
-			return ret;
-	}
+	ret = smu_disable_dpm(smu);
+	if (ret)
+		return ret;
 
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
@@ -1591,9 +1572,6 @@ static int smu_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
 
-	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f55f9b371bf2..1e8e9db240fb 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1346,7 +1346,6 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
-	struct amdgpu_device *adev = smu->adev;
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
@@ -1380,7 +1379,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	if (result)
 		return result;
 
-	if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
+	if (smu_version >= 0x360d00)
 		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
@@ -1397,7 +1396,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+		if (smu_version >= 0x360d00) {
 			result = smu_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
@@ -1412,7 +1411,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		size += sprintf(buf + size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
+		if (smu_version >= 0x360d00) {
 			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2184d247a9f7..c94270f7c198 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1817,8 +1817,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
 	int power_src;
 
 	if (!smu->power_limit) {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT) &&
-			!amdgpu_sriov_vf(smu->adev)) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 			power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
 			if (power_src < 0)
 				return -EINVAL;
@@ -1961,9 +1960,6 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3e1b3ed8a05e..cfdc255af901 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -774,9 +774,6 @@ int smu_v11_0_set_deep_sleep_dcefclk(struct smu_context *smu, uint32_t clk)
 {
 	int ret;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	ret = smu_send_smc_msg_with_param(smu,
 					  SMU_MSG_SetMinDeepSleepDcefclk, clk, NULL);
 	if (ret)
@@ -820,9 +817,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 	int ret = 0;
 	struct smu_table *tool_table = &smu->smu_table.tables[SMU_TABLE_PMSTATUSLOG];
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (tool_table->mc_address) {
 		ret = smu_send_smc_msg_with_param(smu,
 				SMU_MSG_SetToolsDramAddrHigh,
@@ -842,9 +836,6 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return ret;
 
@@ -859,9 +850,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
@@ -890,9 +878,6 @@ int smu_v11_0_get_enabled_mask(struct smu_context *smu,
 	struct smu_feature *feature = &smu->smu_feature;
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev) && !amdgpu_sriov_is_pp_one_vf(smu->adev))
-		return 0;
-
 	if (!feature_mask || num < 2)
 		return -EINVAL;
 
@@ -948,9 +933,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (!smu->pm_enabled)
 		return ret;
 
@@ -1113,9 +1095,6 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 	int ret = 0;
 	uint32_t max_power_limit;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	max_power_limit = smu_v11_0_get_max_power_limit(smu);
 
 	if (n > max_power_limit) {
@@ -1841,9 +1820,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 	uint32_t pcie_gen = 0, pcie_width = 0;
 	int ret;
 
-	if (amdgpu_sriov_vf(smu->adev))
-		return 0;
-
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
