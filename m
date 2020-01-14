Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C726C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F9F24673
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gtLH47Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F9F24673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF346E43D;
	Tue, 14 Jan 2020 17:58:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2816E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpPTAHXl0WEJyEU9tVwl8mg7zYcvFrBlW9pNwDYKVTZP1r7W691cZKPA86emjshteXVC/4ITaQqO4cvJOzv1BKEXBD/90DyrQSnlcriAi43DQuB/bw/DsgtpQ4L+TpAGeh3MDJdxIFBnlNhUvTTnN1ogBcyc+ylmZAYwmAsRQk7/liRyOf6cAjMnKUSH3j2CnPZhZ10YGMGSkYqU6q3ETVfxp1s8wmDop1ywnzIdBVMqDC6Iyderwm0/s9myvAvVwrnLH+aqWBeIHfEdpu0ypifVwWIocfx+P27fpD15Va2dBVwQbSNfAAFqyVKnIv/z8IzLQp95x0AENZ+i78JIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhYzQRv9C8V9qLg4B6Oesmnb6arAHdUiSUEQzkuSM4A=;
 b=mMzwykZSpV1RLUZzaUQZKe+FeXwLOXhRJ5KDqw68AyTyp1zBzk7DP1ZvH+qIqEeB3vFhasqultNs92gtGorf6G5dCV058RXhYmBM6xBIJpUmVvzFVgbIBzdExTvZiKznQn3g82VRL48aBWEe9kFv3dw4FUdgXPp6LKsvAX8gDuf6ohr2FpwmfW6WznMouRc2EGVc9sJtbPk04zzWmVRCRqgaUEtL1YdJi7vpndNATP7NsBOGvbIIZWi3tk8hYAU8AVkGPGbOwsLdW8zhPXyP/VK89dQsvgpkcaezRyxFsTFjATPmiRMnrOVu70rHU2mv84PAdrmGfGmZajxx8WryZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhYzQRv9C8V9qLg4B6Oesmnb6arAHdUiSUEQzkuSM4A=;
 b=gtLH47WdC0/I2SJ1lFdxv+IJ5//fagVUk0AUw6Os6wT3f/puZJTOXMKkEpzlSD87Rv2lWS70ZFz/L2ib/NUnGxrGG3xlYh6u1/Gz89u1XRJeeC4LQtT0ODqybuuloOZ2Y+nzGMRa4Yl0k0vEJMGm+JWCTcQUxH4nXD94L39RHUo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3109.namprd12.prod.outlook.com (20.178.54.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 17:58:31 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu/vcn: support multiple-instance dpg pause mode
Date: Tue, 14 Jan 2020 12:58:17 -0500
Message-Id: <1579024702-27996-2-git-send-email-James.Zhu@amd.com>
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
 Transport; Tue, 14 Jan 2020 17:58:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8c58bbd-20b4-407c-414e-08d7991b5db8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:|BYAPR12MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3109EB02B6FCE079C6B8583AE4340@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(6486002)(26005)(81166006)(186003)(956004)(2616005)(6666004)(6916009)(7696005)(52116002)(16526019)(66476007)(66946007)(66556008)(4326008)(8936002)(36756003)(2906002)(478600001)(5660300002)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3109;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AEOsro42/2jj62k0tsVqRcV20ra17VWkHXx4+dM5YOYaASna6cTqah504bXuK+SIVs9ogSRdKvYsux2205L3oUWLZv2BbOmnTBrFP3AU/Qs1Bvo1E5QDX8qPW57Qbkiy1qP7S0+dSsW8wKa0KsCNxRm1cep830QC39/+YL5Xz1dc/RCp2pe89vrFeq97e6XyPosYpK1/LIsH/2WwlxIxbN4Va7odrLJJfCqJmkMlAymjqIYFP2mwU1XXdQS/IxKoiIp6Bwye6O373pVNNPKe27AMx+OMVxr/xPuBE0h2Oib0ffpkHG/DAQzUqgTbloMk5XdQ6lgu4e6z7oiNl89dU0RyV9hcrfKTfpuWavXEc7OXkHWsRIaf+ebbhPs3sS4GrB/upoFRGKXRRSDFz0mAouMnnDn/j5Ua1apa4/xccCPwRQCU2gO5WfJ7nQXqO/S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c58bbd-20b4-407c-414e-08d7991b5db8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:31.3396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgMAKrycuZnNTzLuI6/hUsfdqxt2WPT/6XF2NZkb9uWixaAUhIarQ50TGYaFyuRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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

Add multiple-instance dpg pause mode support for VCN2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ed106d9..99df693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -298,7 +298,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-			adev->vcn.pause_dpg_mode(adev, &new_state);
+			adev->vcn.pause_dpg_mode(adev, j, &new_state);
 		}
 
 		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
@@ -341,7 +341,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, &new_state);
+		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e6dee82..26c6623 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -199,7 +199,7 @@ struct amdgpu_vcn {
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-		struct dpg_pause_state *new_state);
+		int inst_idx, struct dpg_pause_state *new_state);
 };
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 3b025a3..a70351f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -50,7 +50,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v1_0_set_powergating_state(void *handle, enum amd_powergating_state state);
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				struct dpg_pause_state *new_state);
+				int inst_idx, struct dpg_pause_state *new_state);
 
 static void vcn_v1_0_idle_work_handler(struct work_struct *work);
 
@@ -1199,7 +1199,7 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev)
 }
 
 static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				struct dpg_pause_state *new_state)
+				int inst_idx, struct dpg_pause_state *new_state)
 {
 	int ret_code;
 	uint32_t reg_data = 0;
@@ -1786,7 +1786,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, &new_state);
+		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
 	}
 
 	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
@@ -1840,7 +1840,7 @@ void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
-		adev->vcn.pause_dpg_mode(adev, &new_state);
+		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d76ece3..dcdc7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -58,7 +58,7 @@ static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_0_set_powergating_state(void *handle,
 				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				struct dpg_pause_state *new_state);
+				int inst_idx, struct dpg_pause_state *new_state);
 
 /**
  * vcn_v2_0_early_init - set function pointers
@@ -1135,7 +1135,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 }
 
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				struct dpg_pause_state *new_state)
+				int inst_idx, struct dpg_pause_state *new_state)
 {
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
