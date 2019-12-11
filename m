Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391A9C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 19:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0684A2173E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 19:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P2Kkcla3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0684A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67C589D42;
	Wed, 11 Dec 2019 19:49:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D06489D42
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 19:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emoHTfvF0BMeql9wXIbl2TY3okZFg/wdIiV5rDbCVPTv4H7u2vT6KSUKsoE4zIoQWW7iz0GqsNzFitu2oNQGZsn4bDhe9Ny9K/WG4qrTdZ7aoP05+OQUr5j89bn6ngy45AvW2XcumSJEN0lkaccRUPQZBoHTF3eHddqkvgzdX1O1JRbIVs6+WLyRnHiMp6BdS5KYPc31NeEuesF3nf00m7pz/DISYfgEcwzaLh8x7asA6uhLjIHCjpa6iIq8Q9fcw0LW8CqgdLFpdYUtr1dxheIgnHdPmehUB2guuYZ+lh6MUbUmXJAkkt+zTjzxE3OWSf484ErQnX4gZ9b4jPNgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvtNL71uySaOJ7abYnoFrbNi8BHTNMCzHDwkgG+T4ic=;
 b=DLkrujieJbhxYJVj1a835gd21K//6J8YekpJJKVxZVib7lQFRaNFIQacVJ5OKFrZI8PXXxPz/fExKF6S1ckNAqPAs4FDKnI2R72dI/3PwpcF66ddDArY7C7b0x7E5PeVBsANjiRW1NRj8xUzOZthiWIfzt4yRU+g3+zjmwYXmKQQY3/RaiI2pUxWh4zw7v3k758zD632OYFuqRy15u3riSG92CblTtYUpH3tusL3G/bdpJmuVVMyTC8rT4hda59CN2prs/Ymnjz1gm9UNjOoDznSX7FZje9fZB9fontZMRLOLRxyCkeidijqLVM2epbHzEiWiCOYTCvcYwLrXSvvcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvtNL71uySaOJ7abYnoFrbNi8BHTNMCzHDwkgG+T4ic=;
 b=P2Kkcla33zB2rxNYSy7SYTddX6/4Mojn3UWzrRagEjSeS1JwDataA6RHVoOiq8HJrb4lQicNIZPE7Up3cnb1MKtEnELdqJxHyQI+VgWkgnTIuaW++bEE9+WEC4JbkCAHntAMRJ5aGXh4ULhmdL4cipJUKVDpvvfS8wS5FSPONDI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2582.namprd12.prod.outlook.com (52.132.141.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Wed, 11 Dec 2019 19:49:07 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::5c07:10f2:d913:b03f%3]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 19:49:07 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add JPEG check to VCN idle handler and begin use
Date: Wed, 11 Dec 2019 14:48:24 -0500
Message-Id: <20191211194824.11146-1-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15334d5d-0bd2-4072-fd11-08d77e732f45
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:|DM5PR12MB2582:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25828FFBF759D25AB83521E8E55A0@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(36756003)(44832011)(4326008)(2906002)(66946007)(6666004)(6486002)(52116002)(316002)(6512007)(66556008)(66476007)(6916009)(81166006)(81156014)(478600001)(2616005)(8676002)(1076003)(26005)(5660300002)(6506007)(86362001)(8936002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2582;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+9X79h2/LS83mL30rrJeN6TENgQfON8PocXz8OkmWP/LcFBf8dm1iq0FVt4Umr6rp/mriB6XM5M8SYMvMlpwB6Bp7Sx/Tz4Tg8fogRwQz8VidNuFCIQYKGIQi+JTYykiSHjnscAHAAgehO1JfFZVBcm1jsQqSZFM+PtuU4599W1jPu2Pi2QTIYRcT12l7Hjmu80+oqUqXvN493GksRkV3GloJubdc22tP6bNOEICGCmjpy11nUgFXm7VJzDeSCbC7rT1Dm/9Q3YzQ4fTmnVDkl5R9L8FUX9fPyjUDd5cKsE94sjFirtb+LOSxyOJHTRR9o9c8BxcuerbjYXQvn10AWtTR94A4n5eUwWHVWFg1b8yboDvvAD0r/yc7syF5xWu3jv/qJBpqknwb8S7OwIkT1y8aX2tsGhJ9Y3Y7o+jNWOFrtI2BQe6AUhOFn7/OYD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15334d5d-0bd2-4072-fd11-08d77e732f45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 19:49:07.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhXXDB1WvbXMPZohJzEBdK1Wc226emMEbIQuLRfFBv//Gdngph0pVJp39AmPV7ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since it's only needed with VCN1.0 when HW has no its
own JPEG HW IP block

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 29 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 428cfd58b37d..95ac721f2de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -186,6 +186,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	adev->vcn.has_jpeg_block = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
+		true : false;
+
 	return 0;
 }
 
@@ -306,15 +309,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
-				new_state.jpeg = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
-
+			if (!adev->vcn.has_jpeg_block) {
+				if (amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec))
+					new_state.jpeg = VCN_DPG_STATE__PAUSE;
+				else
+					new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+			}
 			adev->vcn.pause_dpg_mode(adev, &new_state);
 		}
 
-		fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
+		if (!adev->vcn.has_jpeg_block)
+			fence[j] += amdgpu_fence_count_emitted(&adev->jpeg.inst[j].ring_dec);
 		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
 		fences += fence[j];
 	}
@@ -358,14 +363,16 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
-			new_state.jpeg = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+		if (!adev->vcn.has_jpeg_block) {
+			if (amdgpu_fence_count_emitted(&adev->jpeg.inst[ring->me].ring_dec))
+				new_state.jpeg = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
+		else if (!adev->vcn.has_jpeg_block && ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
 		adev->vcn.pause_dpg_mode(adev, &new_state);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 402a5046b985..9a2381d006c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -192,6 +192,8 @@ struct amdgpu_vcn {
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
 		struct dpg_pause_state *new_state);
+
+	bool has_jpeg_block;
 };
 
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
