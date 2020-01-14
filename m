Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E43C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870BF24680
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rZTvDKXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870BF24680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08C26E448;
	Tue, 14 Jan 2020 17:58:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C90A6E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lr7dK98pl0G7Iem1VvkNjFmyB+VNISiybZhLwZl+7o2azckx3oii0sCl7XsPfBqdSgk2NeJVPZdsyJrafBwzr50rPcSCg07r5Kjw3fZs0y/OPtFYEz8DxALVBUfWYco05JrEU4N3R4j32aQ6l6paOU0GIaCE/3e1qLduNgtaiW7A3h4DTf0S4+Q238gletHDihHq855LDV2rNM7NOxo8STrPZgiHV249fP9/+zjK+P9DuUpLS/nB99mpSL0Se25t1qyFoRftOeKNx2wjB3N/1HVeOO4d5DjPNr4S2lovSA7qYkMTyQtVThPLtx9G4ndAvk4ZV4s67JyR0uHe3SUg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/plhWqSBRiDfViqEKFvrDTHzD6L7hqQ0+bgg9F4/nM=;
 b=O/JlwybikcuuQ6rPj8M0qgvkxntFH/yse3VCFasB5eFdJP9y6sNlNKtCSkttBDLek6eynVnDBU1dtJaOaY+BbnaGCjiZN7dIfx8h7KZQ0HIq/hgSZ+dvRDRx2RRc7e4+cbl6TUOzGeVmnFTt98GH4qBpTQt20HFNUVu2eVyYHfVZPlclb7iGHi2arSKx7BJND5UhZ3SIvJ3OIccqMXHfUGTHBcmtWU1HrzuES4LypyOAufYVHHw2XeVp1sh23TYliCIpYJ0+zMvxecXIsAPBFZDKqUSF0V1AlrA4R83ROIaMe3rSZlNUxhf82JipmYpBVqWh3NOhAr8L35qtWXztRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/plhWqSBRiDfViqEKFvrDTHzD6L7hqQ0+bgg9F4/nM=;
 b=rZTvDKXsMdgPapEShJJR+dkXZVmsmjqmgNPBUtR7rySP8Vk8QVHWHp8nPdj9SeqHvDWr0dUDP/XQJChUUQ58zqeabiIeKEolZpqTaztebZ3YCHMpn7lJsgWWW96ECu72Cb76xLQHaE9Jis8JbLJ3kZUOwkUJXEo8c7EEZK+ArgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2677.namprd12.prod.outlook.com (20.176.255.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 17:58:33 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:33 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu/vcn2.5: add dpg pause mode
Date: Tue, 14 Jan 2020 12:58:20 -0500
Message-Id: <1579024702-27996-5-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 17:58:32 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a899ef1-3c91-47bb-332f-08d7991b5ec4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:|BYAPR12MB2677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2677B6BE5E49B505120DC5E7E4340@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(6486002)(86362001)(81156014)(81166006)(4326008)(8676002)(316002)(5660300002)(8936002)(478600001)(2616005)(36756003)(66556008)(66946007)(66476007)(6666004)(2906002)(7696005)(52116002)(16526019)(186003)(26005)(6916009)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2677;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ld5iBXnuImC6yK0HmSvBQSLwP1FRZ85eP4ZIYmWuo9biz8pSeIVLq9qFvexOPuDeIfk8WFp+dpvjiOOyNHNY5YqvZ85vNnIqf9fahyjofbLOgAThV3m5n5FnRxL1YK995RQZ6aNusmFXFPJ2Kj01gQEqboFCH4NmScsOFQj8myebst8Mzo/dHE6AzSKTA2k/tAvWCf4r93JoAiP3cydYhobk8zQY+J6WejtIxa0hW41yfci67xDsZCOKwKe7MeOVdPowSUblm0lLaLty8OCOY4S0HoKh9TqdIsugymeuAr3ZJrNbQqp/K17bdxMf4UUj0EruBo20Hf+Ldy9Muw78Lk96o8RmpL/9mPqHnnug/62n2NZt2UuP2x0Se/MQ88Ck2AyAexIsW3YA1WOF9oEul60kwyf+cywGyydCmO2gCJ+IjZ+a+bY8DG5WtrKxzhH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a899ef1-3c91-47bb-332f-08d7991b5ec4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:33.1386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI5qERbIujODpkRF/kWx59YAuiyxALCeSBKYZH/mM4A/X672kRqKZlvAzkuR+giU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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

Add dpg pause mode support for vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ea70aa8..8de51c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -60,6 +60,8 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_5_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
+				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 
 static int amdgpu_ih_clientid_vcns[] = {
@@ -217,6 +219,9 @@ static int vcn_v2_5_sw_init(void *handle)
 			return r;
 	}
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		adev->vcn.pause_dpg_mode = vcn_v2_5_pause_dpg_mode;
+
 	return 0;
 }
 
@@ -1327,6 +1332,67 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
+				int inst_idx, struct dpg_pause_state *new_state)
+{
+	struct amdgpu_ring *ring;
+	uint32_t reg_data = 0;
+	int ret_code;
+
+	/* pause/unpause if state is changed */
+	if (adev->vcn.pause_state.fw_based != new_state->fw_based) {
+		DRM_DEBUG("dpg pause state changed %d -> %d",
+			adev->vcn.pause_state.fw_based,	new_state->fw_based);
+		reg_data = RREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE) &
+			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
+
+		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
+			ret_code = 0;
+			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
+				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+
+			if (!ret_code) {
+				/* pause DPG */
+				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+				WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+
+				/* wait for ACK */
+				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_DPG_PAUSE,
+					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
+					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
+
+				/* Restore */
+				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+
+				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+
+				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
+					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+
+				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
+					   0x0, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+			}
+		} else {
+			/* unpause dpg, no need to wait */
+			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
+			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+		}
+		adev->vcn.pause_state.fw_based = new_state->fw_based;
+	}
+
+	return 0;
+}
+
 /**
  * vcn_v2_5_dec_ring_get_rptr - get read pointer
  *
@@ -1369,6 +1435,10 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+		WREG32_SOC15(UVD, ring->me, mmUVD_SCRATCH2,
+			lower_32_bits(ring->wptr) | 0x80000000);
+
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
