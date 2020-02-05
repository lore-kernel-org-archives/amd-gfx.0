Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961AC35254
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DB4217BA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 14:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CGQ8B815"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DB4217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962E56F5DA;
	Wed,  5 Feb 2020 14:45:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983566F5DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 14:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egXG6hzqRZHs6ANiUCfWoUQeCfF001nTKaLc5y+XVI13HT8taFmgIDma+MsQ6+l+yFNRZpxNrIovJEa4EjP4kO60xnL66JeUMn7L+KI96ofjUScuwJlGh0uodEr093H6D0RNRQ76aYLvukDgr9bM248bgEZ4gF4RV0norVOISlDYfW+dv52UPXzMAiu1l+XcIfI77XZbB/7LDlnaf7pvnQGoReivCxhao+wjSWMIutPaLgv4PfJyOHfh0A/WqNjxUmkeRgKUC0HPF6S1Km0tnATX8XDaEsv/wnqDmebYkpMCdem50YOnB5RuFQNNa1bTuW8jqefeNzW3kA8p6QXG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh8KAzeTVB+/aynXL+B40/ZAFGm9Obgl1+RNkA0l/FE=;
 b=gVkWA89XawJPydB/jmCkYXVEIaL1gHoW+EDE/UodkEzn/zkhbEQtae+kBzrBsXWdbOOcQzXzyVvY/gKJ7OkRv2zMrsLnmsnEwgOGys59zSfuo4D/MlLPeZz1TXz8BS0cT0Fo1kl8mCAWtjitFqFYG71PZKWg5QOVvEQEN5k7+YQwwqk3rAYQn0z0U3yOhfNrR9FmGxGFib7xx+GC95F2gi4p5GXgnWSUXPwWzaD01ApemZGoSr0Fj/NbpLc2rBByDMpQJ5mPUKUOiAr1BrPX74C37mP1GzjMG05zou+eqnQLpZbEtMjUGAxJ5BbbXs9KJ7Uv82+0LbNJnJph7Z3OOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh8KAzeTVB+/aynXL+B40/ZAFGm9Obgl1+RNkA0l/FE=;
 b=CGQ8B815N42eYYWVAAli+JQnbzt+Ei/ULmQGPoXgZ/W5cFW2VRTaOMdnjb5n+GWgJVovngbK6wTGZyI4LlvQXI/y7iPQqS/GB78OJ1EnmyipeRepT1YlpjEonC1+bmLffmQIxIm4/mC9CUuWjZgypNGctlOr97jntMZuMY2cbhA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3479.namprd12.prod.outlook.com (20.178.54.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.28; Wed, 5 Feb 2020 14:45:28 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 14:45:28 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn2.5: fix DPG mode power off issue on instance 1
Date: Wed,  5 Feb 2020 09:45:18 -0500
Message-Id: <1580913918-12026-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YQXPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::25) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YQXPR01CA0096.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 14:45:27 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 732a48ff-b70d-4570-0ae7-08d7aa4a0aa9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:|BYAPR12MB3479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34792837B17CF08CFC865742E4020@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(2906002)(6486002)(7696005)(26005)(52116002)(2616005)(66476007)(956004)(66946007)(16526019)(66556008)(478600001)(6666004)(186003)(36756003)(5660300002)(86362001)(8936002)(8676002)(81156014)(4326008)(81166006)(316002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3479;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuXeZjfJ3ddZNvKrZpa3V61IwCkGVcrPvJdOaJ2tJD+rwVGdz7ugoKP+UQOssM9HklC7a9uG3VVp3n++FHU1/xkI9CHyjnpnIu3LiwydlkRoyOtv6kz6mdb2NvTY0Utm14W8/tYWg1XLFfpkYkzh+PRyn7k52uMXN5naxnjPzyjw3RnvRMhFx63qt7rKR/RgM5h+s3b+lUiTpGdJweYhIzfroUv4FSeOGzIS4Td6pP00BOh/v9Bn7t4PnF9nb1P2LvSRYgcEtfeqQHXRIbk8pCPCLRwnEZhRxYK6DJ4XumsP+wBDcvfy1AEW/m3eh1/AxmdFptuuKSBRr4z9zfNL/cP8CINZhLjCLqo2RxLybYiC0kiOvZ3qZm5qm6ZYAqOZhdh/Ms/iiIWSVcP44QBnIxhMFwG+1zFjsckp01nb3XHuaS6Plfa3zKOgqi1o0OcO
X-MS-Exchange-AntiSpam-MessageData: 6DxR4uI4DZnRQNVZD88yNB5VaKVtFGUJEE7LQ44EZfSPh491CKxUnXvo2LJn4BNIAkRI6O92M8Li1spVnaiqSBf1rN2+kxfDrEzT7YcQMycPiJD7SZQvk9AgwQF+21Y8gVjww0/fx+qtrBXuX8yq/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a48ff-b70d-4570-0ae7-08d7aa4a0aa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:45:28.0836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUlzL6l9rQyo/f2ojd4T6/RnUaPZhQI7JkDB0HQAQ5TDxV+jbARieFQrO0G7AJfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support pause_state for multiple instance, and it will fix vcn2.5 DPG mode
power off issue on instance 1.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  6 +++---
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d6deb0e..fb3dfe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -179,6 +179,7 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_irq_src	irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
+	struct dpg_pause_state pause_state;
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
@@ -190,8 +191,6 @@ struct amdgpu_vcn {
 	const struct firmware	*fw;	/* VCN firmware */
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
-	struct dpg_pause_state pause_state;
-
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 1a24fad..71f61af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1207,9 +1207,10 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring;
 
 	/* pause/unpause if state is changed */
-	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
 		DRM_DEBUG("dpg pause state changed %d:%d -> %d:%d",
-			adev->vcn.pause_state.fw_based, adev->vcn.pause_state.jpeg,
+			adev->vcn.inst[inst_idx].pause_state.fw_based,
+			adev->vcn.inst[inst_idx].pause_state.jpeg,
 			new_state->fw_based, new_state->jpeg);
 
 		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
@@ -1258,13 +1259,14 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
 		}
-		adev->vcn.pause_state.fw_based = new_state->fw_based;
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
 
 	/* pause/unpause if state is changed */
-	if (adev->vcn.pause_state.jpeg != new_state->jpeg) {
+	if (adev->vcn.inst[inst_idx].pause_state.jpeg != new_state->jpeg) {
 		DRM_DEBUG("dpg pause state changed %d:%d -> %d:%d",
-			adev->vcn.pause_state.fw_based, adev->vcn.pause_state.jpeg,
+			adev->vcn.inst[inst_idx].pause_state.fw_based,
+			adev->vcn.inst[inst_idx].pause_state.jpeg,
 			new_state->fw_based, new_state->jpeg);
 
 		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
@@ -1318,7 +1320,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 			reg_data &= ~UVD_DPG_PAUSE__JPEG_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
 		}
-		adev->vcn.pause_state.jpeg = new_state->jpeg;
+		adev->vcn.inst[inst_idx].pause_state.jpeg = new_state->jpeg;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 4f72167..c387c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1137,9 +1137,9 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 	int ret_code;
 
 	/* pause/unpause if state is changed */
-	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
 		DRM_DEBUG("dpg pause state changed %d -> %d",
-			adev->vcn.pause_state.fw_based,	new_state->fw_based);
+			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
 		reg_data = RREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE) &
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
@@ -1185,7 +1185,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
 		}
-		adev->vcn.pause_state.fw_based = new_state->fw_based;
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 70fae79..97ab44c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1367,9 +1367,9 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 	int ret_code;
 
 	/* pause/unpause if state is changed */
-	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
+	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
 		DRM_DEBUG("dpg pause state changed %d -> %d",
-			adev->vcn.pause_state.fw_based,	new_state->fw_based);
+			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
 		reg_data = RREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE) &
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
@@ -1414,7 +1414,7 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
 		}
-		adev->vcn.pause_state.fw_based = new_state->fw_based;
+		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
 	}
 
 	return 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
