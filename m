Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B00C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9CF2187F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QvF+KKNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9CF2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F166E5A0;
	Tue, 14 Jan 2020 22:23:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 657E16E5A0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 22:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTYEgs48yx8q0ZgJtPnlDf29/h3ydQWhVKiMKoAtkxpUmIPg5bUdbCM/RJhvA9src9ZAnHDxcukTXvToAgvLsDgrgn+G/Tjrjxurk0bjoKppge1Cx7gKE7Wxnzvxl6dHR6knsWAMAtp3fH5s65bcl+2HlyNBqbi5rV4hgjSkmyZQwryILOGltLZbyrOJ/7z6mqGhqY0UhHatJ8WUdj/Ln4Ug0Bf+SCbbdeLGdaYJhQAyyskGRShLw/OW8ohhiFhJrYVfGqrcDFBa4SW0OMkigL6+LBnA93eqqy79hlI5q+aQDzJRQ+Jx+zLPhq1CGd+RiDVm+1L/10kQCBEuwHI/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhYzQRv9C8V9qLg4B6Oesmnb6arAHdUiSUEQzkuSM4A=;
 b=gqG2mN6RAThd1N13tlZxOYKgt6wG1Azm4ZWltGFRCjkZ9Ay02Geey4tCrDl8RxJE4iqTGz4bTI0zSbWr8caC9xzZEWTapKBLqcN2THUVVJyG8g9e2NJa4A6NbQiqz6lNa29H7UQAhyj+kyN4MSCiCJHD20WJVM4ECKj7RtWGECEjRNC+Od2gu5HYSgDWNbGiDj0dp4uwywcTksvcfr5Qhvax0M2u7O4SYbGLVVZLw9jPRjZWgfYXu2stxPDWGWZqd5eW1ShOdhdvrGXt5pyDzOaQy+8tsvd1Rj61lqa53KalhyAqKgk0MxA7GL1FGm7bdMqpcJO3TfJ1oahOIccvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhYzQRv9C8V9qLg4B6Oesmnb6arAHdUiSUEQzkuSM4A=;
 b=QvF+KKNHvWOU+NjSCxN42AUKeJ0RR6HsGsnMWaT6p/KrdjzuP8TEmvAMeG0ZX9P8PlGwfL/iBYOGyibRNPpF6m7Tjuvin+n1k5mbyjZwijc8PyWdiXhmsA0l2YBLQ2hFMy1zXjTHfAXtW0JusacgYQ3c2KuzC4oOTX1HrwLrg/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3349.namprd12.prod.outlook.com (20.178.196.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 22:23:26 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 22:23:26 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/5] drm/amdgpu/vcn: support multiple-instance dpg pause
 mode
Date: Tue, 14 Jan 2020 17:23:12 -0500
Message-Id: <1579040596-12728-2-git-send-email-James.Zhu@amd.com>
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
 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 22:23:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e2c0335-e669-4da2-4c03-08d799405fde
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:|BYAPR12MB3349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33498C054EB74FB7105ECAE5E4340@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
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
X-Microsoft-Antispam-Message-Info: mt82HCMivWcP6cnZgrbY+YW9dFAdV6k4nHwLHejeWKAKIEpw0SLL7iz2coRh6pp0EdnfL3iuUc0vZpvtu+pxDsEVm0dHBlSh1Cqg45obnICZGTTX4wsBUFcVLcf4p7Hwnjf4NfTJenL78zOrApylFVloN4UHyyDS2UU/AZsripe1dQl0qX6rdImDw273cjEyOeFfm7iOuePCqRAZV31MU2OZ96gBKGSr8U+6N6K1CRd3JPP5jJymfiH2a3kPDiQ45Gx52+sOj5NVEIK3IMklCW4o1q2Hh+P2cfDn9IqTEwnuRnIqiGtydK9PAuqJ3U/HU856elAVpI/1FEmXUxDGXLd+iZxieNGKhO32HFMqQ7QgU/P1eKd2sfoDIBkDezoTNizqUkoOQAYVdt4J/gmy75lKCow9vV6XMk8/BrpqQwWJjQLMGen6eKKMOYlOr44r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2c0335-e669-4da2-4c03-08d799405fde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 22:23:26.4833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX2ON3DZ37Z6nc8xHaHS7XlwifMGEIddIv6TirRbbQvUVdmRwQimwp/l7p65UP+6
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
