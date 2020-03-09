Return-Path: <SRS0=uBoY=42=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220FC10F27
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 16:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96AE20727
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CgrUA3xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96AE20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE686E061;
	Mon,  9 Mar 2020 16:58:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27C66E05F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2020 16:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPEDKQpN5o5vv2u+qLbGH/8HHTV0hfuzG+Wr8gT73AWS35B/9RHy4m9rNNQzK/Bp2XFac20b8C1g6uALcyTEwRxYOTC1OVA5xrYPpJ07y7jTCetxXDT6PMrq9uL7CymzqZVErmf5obKit3v7iub2vDSdgWb03z4KOo0KOUWeHbaPhQ38hqL5dmCjewhJ0S2C+dAscpL6Znaf0K6Uro1p131LpXCWjFqS/4tmIZRM9QR46fJJYws/iNERsDw7As3dRW9vYCBwa7k6bNFHvfYIGsqQgPtmHdWd1RpWL76qV0g059/7g3N936+cQGGayOMelALh6S9JVMKZQFN5Js7k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4KL7d2ztiZMZF2S3LCTQ674QToCI5ChX5XRsjcQ6iU=;
 b=F8SkY4hD2UYwj/4h8DVgSph1TLniifX49McdyFAprcX+X2tCIV/4i1q8qpK2s0+/Vh1dtR2oiK/voYzypTGUA8ZefEbNW3CtTGUMu70mDk4FWdtMLGf0YPEwxKhyq/BjBr1kHfop/WDT/zu9OiZVR45VhE02MfIsMrXwh64Ji1UTbhlfHkj89nvZtvZMv6SZq5Mq2dJPSy/UxAQhdjfxOLN4/zwHjHPx0dvClQ0GrSOvEMwbOlJx+R8kApeoX3zyV3/hs9vW8V2qK4fTZMN/MpRM6LZH1eP2cnjboqZAKLTorFZOb9iz7qjET6HXq1YN0jspZ34s5kDh3Gk3Mo5OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4KL7d2ztiZMZF2S3LCTQ674QToCI5ChX5XRsjcQ6iU=;
 b=CgrUA3xXmE7RcdbB4iUli9qrPxZg5KoY/5x3oRB3a9FgtN7DwJcv7XnJUzAfl7p93yiFUeSuGSZdmbWWcAQfx+Mpv9krf2umzdNj2kwM/pshTOcUbE/vS0hqCn58NGhHJLr+ZAflSyUFo8Pd8MDH8cFwvizhRCB6vJP0FN8K5XQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 16:58:31 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 16:58:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/4] drm/amdgpu/vcn: fix race condition issue for dpg
 unpause mode switch
Date: Mon,  9 Mar 2020 12:58:24 -0400
Message-Id: <1583773104-16025-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-2-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-2-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.14 via Frontend
 Transport; Mon, 9 Mar 2020 16:58:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47124181-bde1-4c90-8809-08d7c44b187d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:|BYAPR12MB3527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3527086A3F97C69EB2DE3FD5E4FE0@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(5660300002)(2906002)(4326008)(956004)(2616005)(26005)(66476007)(66556008)(66946007)(6486002)(478600001)(6666004)(86362001)(6916009)(8936002)(36756003)(52116002)(81166006)(7696005)(16526019)(186003)(81156014)(8676002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3527;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EsX6qX5RkpAjjn9FnPomFZq0SkW+u98tlmfJDPoQgLaCNQrG17yZIIb4EnTiguKRHzPK/uNCO7u/RMZNJNRS6JetDHa8i31Yg1JLX1/JDOeO84K6g+hh5f6rl1L9EwcVpyQbjMLEq9zlx+XIQ3+pXkRQ0AQz+EgOLVj6qnLR4qxoenIf/r8FNwg1Wx20xJC9jZAqjOIXHebadnTau7QH01M8oWH/qvC4FsSlG2WjGDJhPnDUQX6UqIbeRB35s6o07Snr3erwWf7ja5QkIpqQV99Zz4/9zktQc2za6nK0DiayGbkKpWhnSGdC1/eonaCmiMfgeHhXK/zSN+tyLOojWQxg2RN+Jnu2CH/TaxsI3A4vT++yfT5qcg8uEiyg5XGYW9SxxwkS2VAAKEL66W1KfToVIlvMFnp7n7tkeHRcR8LJ74Ajbl6m4oiYvTxTc6Gd
X-MS-Exchange-AntiSpam-MessageData: 0jDVqmaUqjkdP0GMlhlMftjeg02j48h+MIbyMg/LrnmpqaSn2X6m6FTzEnuqL4TrDHsvKY+ObQR7eHa9Ms/5OwbY3q9adMyqKRO441jbq0ZFgZFjDj/WZAbVhnb/S0MTSJxNoF8qcFLUQSmMjB3e4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47124181-bde1-4c90-8809-08d7c44b187d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 16:58:31.1004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2At0kDIcmGi6MzK51PfwgdQidWN5FTyDyABoJWLBmlMzP3QJtTP4VSiWQv+19ieC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
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

Couldn't only rely on enc fence to decide switching to dpg unpaude mode.
Since a enc thread may not schedule a fence in time during multiple
threads running situation.

v3: 1. Rename enc_submission_cnt to dpg_enc_submission_cnt
    2. Add dpg_enc_submission_cnt check in idle_work_handler

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 33 ++++++++++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6aafda1..8b48f18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -65,6 +65,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
 	mutex_init(&adev->vcn.vcn_pg_lock);
 	atomic_set(&adev->vcn.total_submission_cnt, 0);
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -298,7 +300,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 			struct dpg_pause_state new_state;
 
-			if (fence[j])
+			if (fence[j] ||
+				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
 				new_state.fw_based = VCN_DPG_STATE__PAUSE;
 			else
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
@@ -334,19 +337,22 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
-		unsigned int fences = 0;
-		unsigned int i;
 
-		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
-		}
-		if (fences)
+		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
+			atomic_inc(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 			new_state.fw_based = VCN_DPG_STATE__PAUSE;
-		else
-			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		} else {
+			unsigned int fences = 0;
+			unsigned int i;
 
-		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
-			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			for (i = 0; i < adev->vcn.num_enc_rings; ++i)
+				fences += amdgpu_fence_count_emitted(&adev->vcn.inst[ring->me].ring_enc[i]);
+
+			if (fences || atomic_read(&adev->vcn.inst[ring->me].dpg_enc_submission_cnt))
+				new_state.fw_based = VCN_DPG_STATE__PAUSE;
+			else
+				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+		}
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
@@ -356,6 +362,11 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
+
+	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+		unlikely(atomic_dec_return(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt) < 0))
+			atomic_set(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt, 0);
 	if (unlikely(atomic_dec_return(&ring->adev->vcn.total_submission_cnt) < 0))
 		atomic_set(&ring->adev->vcn.total_submission_cnt, 0);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 111c4cc..e913de8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -183,6 +183,7 @@ struct amdgpu_vcn_inst {
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
+	atomic_t		dpg_enc_submission_cnt;
 };
 
 struct amdgpu_vcn {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
