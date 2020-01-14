Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C6FC33CB3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AC42187F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Cw6T3yA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AC42187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A4B6E5B0;
	Tue, 14 Jan 2020 22:23:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0326E5A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 22:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXeDU97D0cdmzAhdQkWZHi3Ri/eItcInfMKHLzb7GgzppZnBpukajMrLAEu02F9XKa3owi5xubwNDIoN0vNfzRQIm6LUpNd8WO0cMCji3f49UWylGc7+CFZG4MeE4iuCtNwfjQihZi2BekRf0STpBaaQxNSLRdgDwMq7o0E1CzHGMZxQne/Xj5TBmtdnqx1OaP64YqFcR02ohVHtUY/m8neIPcVJ8R4eqYrMnGv5mnDR3ZnUDjBZJoJ7Bwj4HSdqsDi9pLRboVdiV9rRxv+972cxn035Wlm0LBpK4ICHrSRdj/fUVu2q9w3nSFBN6XTD7ILJt4tmOozrgcTGYvJfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB76g1nW5RJqbnUe5eZg5asYs26Oz32yrK+li7zbqNE=;
 b=RvQQSzYR02w3scdfPTFc0Y6segzvg8rCIMnrlVbkmjmrnLSZ9/0TA1Ik3XFuGyKWi6RDWdZtnGrAugf/wQqRX2bQUdXWX+Tc5VV/vhFxI6pchcKJgWVYPLP8uyjfpuE/EL+3rxti2FWdSBAdL6/DuF6ZNCBhtOuq8xTr0FDDSPhBEVkvKwHhOM40nDhy+YKAhl2KtZ0oPYoxO2H8JnW495JNS5/y8Eo44YVgBREEDNRu2PojiW4RL0PwIpD8VQsNwQt+US3Vfzbq/o81MhcaTcoGajIeXO0Sx3R5Byfw1zbzwc8xwuy5gYxaSvxNStQ8UoggX0bFJOHlo8+mIeFliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB76g1nW5RJqbnUe5eZg5asYs26Oz32yrK+li7zbqNE=;
 b=0Cw6T3yAKeGDAPsfajwVRnIVYW8iBj7UIBpvZjlj2k+sB/Z/zI2hVCQ2i9djL4zsk2yR2Yl+kSwebTtT4R50jiWgaJTITf0p9EyBevf+/0hACK9N0IGnM9L50l2MrPW6U7YKS0QjuXJ1Mqz/OupKFoPcKveIjVUdPMNts2WnV50=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3349.namprd12.prod.outlook.com (20.178.196.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 22:23:28 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 22:23:28 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 4/5] drm/amdgpu/vcn2.5: add dpg pause mode
Date: Tue, 14 Jan 2020 17:23:15 -0500
Message-Id: <1579040596-12728-5-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
References: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 22:23:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf33bbeb-cea7-4a4a-f375-08d79940612d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:|BYAPR12MB3349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB334968AA319910D72E1C98C7E4340@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(66556008)(6486002)(36756003)(6666004)(956004)(2616005)(478600001)(26005)(186003)(52116002)(16526019)(8676002)(4326008)(81166006)(81156014)(7696005)(66476007)(5660300002)(66946007)(8936002)(316002)(86362001)(2906002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3349;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt44rbNHWQDlrL6LfPK7xESVjFhwbbj+3/4SwcEwQVwjigQn6CbpX2VA7t6ZmM7edzzkZdjHZv1JPCb0mZ7zpYFbi9GIDo9EeuYb7UrJ9Po7s/UQQ7tR4+4OitRGybomKxOM4EqP0QHESexMWzfC9W2IDmMRDdHAfDZG8kg1lDHjQxT8UDW2Wy9IwEbIHCrclDHEsvEuNu6EC6KD0Nb5Joz99I29C5zpM9/gthzC1Tzh4GKzWymg5hnJRtYBjYdz2TraOWfq3Pdk7/Sg4L58KGbDANl4THnqHakRx6JuU0T7CaRTn8gLpk3yg6V2CyaLSMWTPDWdz4ti5+bviccrah5pqB2+JQLyE16mhWexclNygUuYRYHcFdi3cG1BZdNhTGas5Ckh7csQeW18NTX5feyTxmwzsi5BbuxlkzlNYtIdrFPsNVm/bApUdiaJN1eJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf33bbeb-cea7-4a4a-f375-08d79940612d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 22:23:28.6121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM0qkEP0qqAyKR5Xi3T6xKUQR+l02wu97/E1w6aiGM6EOl2h8IM/EqIUTZZXezI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
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
index b3ddf68..7ce5a9e 100644
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
