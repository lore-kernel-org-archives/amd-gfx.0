Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485BDC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0697A21D7E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pju0zhbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0697A21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB48089E0C;
	Wed, 11 Mar 2020 14:15:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF29289E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1SdL6DJBtiU3iNS1msCwpNzTPUrC3Gt+0wiqg7jJmY+zJYlXKoNkHeobypIS9Z9Psmn+D6bat6+HMpcAxdpLUA7avtkNpQJbfXqmTUHQ+7Rf0ho76Cly/LgcbC03EGM/UFbn45+tX+EZykEtbZtdb+DUp5lLFGIbih/HOnK8QBsWPsf/UqxRky9Babb+1R9R3J3CNdKvKsrmDhr0YYFJ749WKXXy/bjLwyYyIo+K4LoC12hebeXdgb9QmCSpshhk9Hd3xjjAXxE1UeiW01MwKW+XSO5+nQK1yKECyDye6pbvA/yxu5+pzWyn9ajjj9iJAYv4VO3U7CMpPkG3X2uBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZT07XsptlgKMVtpb4Ea+C6W+JU/tES+flw5AW2DJD4=;
 b=QXU7ld0Bo1ItqqsCc4Vg3nLKZoEK7KS/I5YvxM9ZTS5T1qqY+RcOzzgbaNSiqE3S2TISSuB4PAdhcNayLXvP+4LXr+FmXuLONg3rvUFzk0KJe86kMrR6V5FvDVcYRRng0xCBD/6YTO/bDVJokoeGRhR78j5scyqg7HsvcQlMVFYOAvu5umETmrFPiEVU0jbPUvyqziJ/KH5u5MV1txkq21NZgzOTPUz97MJlF5ZIuk9aWnqCKXfRmLY+6PKvhffbNlO9SuwqJ5kpfObm4EThR16VKvffQKXwkurdAWG0xaCYTayja7ylmHk9q7s5LMpuAzKloLfeTWn7KnK209nJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZT07XsptlgKMVtpb4Ea+C6W+JU/tES+flw5AW2DJD4=;
 b=pju0zhbSIQfPDpXJAPlTQ7Kzae2hs6wWvXv7FY6escCED0F2PI0wjGUrZwrA8O/Dr/U7nJh8vAqt02Np9bpRtcQ0tautmahjjn3hLHH3quKhwGxaOncZkMM7efchierA6QUf+fcI3O8e2gGvngED3ERn1HaTB5Zf/bfn1KWarRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3590.namprd12.prod.outlook.com (2603:10b6:a03:ae::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 14:15:21 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 14:15:21 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Wed, 11 Mar 2020 10:15:14 -0400
Message-Id: <1583936114-706-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 14:15:20 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6ae2c6a-8f8d-4d12-9cf4-08d7c5c6a1f5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3590:|BYAPR12MB3590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3590DAD6D0870BFF3E1B8472E4FC0@BYAPR12MB3590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(66946007)(52116002)(7696005)(66556008)(6916009)(36756003)(8676002)(26005)(8936002)(81156014)(66476007)(81166006)(86362001)(316002)(5660300002)(6666004)(16526019)(478600001)(2616005)(956004)(6486002)(2906002)(4326008)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3590;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgWlubmWWBd5m7IwhtqZkLbEhSAY4En+WqwFJ7qPzL2/ySoDilp7qOOJqpon/u5JCELSnL/3/PX94gtDaqdKjX6RjjuTu6K156dbOrK4bThN0VzCyChhonSjBmsMzKBkevT0gIn1P65ERW3X4H4C8QFMIL6ZMi4mbb5MicHRp0hPRq1vvVPKeDRtX7buCzm9VTy9/DatG0MKeJt1lukKVHzYFZntH621tLl+6NFml+QVmmusAE4YMz4d4HfjjY0lzF8hfyAKy3gr0sbx71h5Ni8Ez8beGEqoezKhUi34Mdj/aH/BfS/KF6T3bCob0eCjQxyRbfu+wJT3kgEzEWIAHIDxHyqn9PCrxnvgHgCczP5eUfdGKxILBU9cQjuC7wA2BYCtEUXx3lt9YCE0EIbCO3L8cdruU7VMLN30Gu7WdFP4zCJ7eNNLmPT33WjMtpPQ
X-MS-Exchange-AntiSpam-MessageData: M5QBxn4mSl3jgFRBBgia7GYZac6s5MzfpR58SQWOGr0sAkmcwqGf6XI/oWHDN8gx0DF7qwp4EObaWmyl6FDdQMTF8U6DoUx8isLx8Ovzd7TpV8Ih38iboyFcUJIsBkv8vvBSRYE3zuqlrQJxQFsusg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae2c6a-8f8d-4d12-9cf4-08d7c5c6a1f5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:15:21.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n40uWwJBEbgzBGIVsjq1b/kf2DHYM9ZvU8uei7md/PsxzMjqJALwO9l04cvXkqlm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3590
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

Fix race condition issue when multiple vcn starts are called.

v2: Removed checking the return value of cancel_delayed_work_sync()
to prevent possible races here.

v3: Add total_submission_cnt to avoid gate power unexpectedly.

v4: Remove extra counter check, and reduce counter before idle
work schedule

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 22 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272f..2fa2891 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	int i, r;
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	mutex_init(&adev->vcn.vcn_pg_lock);
+	atomic_set(&adev->vcn.total_submission_cnt, 0);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -210,6 +212,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	}
 
 	release_firmware(adev->vcn.fw);
+	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -307,7 +310,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		fences += fence[j];
 	}
 
-	if (fences == 0) {
+	if (fences == 0 &&
+		likely(atomic_read(&adev->vcn.total_submission_cnt) == 0)) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
@@ -319,13 +323,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (set_clocks) {
-		amdgpu_gfx_off_ctrl(adev, false);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_UNGATE);
-	}
+	atomic_inc(&adev->vcn.total_submission_cnt);
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	mutex_lock(&adev->vcn.vcn_pg_lock);
+	amdgpu_gfx_off_ctrl(adev, false);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+	       AMD_PG_STATE_UNGATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
@@ -345,10 +350,13 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
+	mutex_unlock(&adev->vcn.vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	atomic_dec(&ring->adev->vcn.total_submission_cnt);
+
 	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6fe0573..111c4cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -200,6 +200,8 @@ struct amdgpu_vcn {
 	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
 	uint32_t		 num_vcn_enc_sched;
 	uint32_t		 num_vcn_dec_sched;
+	struct mutex		 vcn_pg_lock;
+	atomic_t		 total_submission_cnt;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
