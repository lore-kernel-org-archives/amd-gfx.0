Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D292BC10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5070206C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="toW8Y5bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5070206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4700E6E45C;
	Wed, 11 Mar 2020 15:04:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AED6E202
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 15:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfEk1pGw6LgHgpGXM1PRtIM3R65XY4Oh6WtcGdaHCNd7pOKRcfniUvdCr/plgLvmff3DAjIuLKWyss7g2Gyu/3Se5vcibhGU0U4Atiu+aX/qJcP9UjWPllIDWyEVUZWeMyHru5QShP3N+L1STZcS+IRbsmx80Jxf6DC/rmVTermRgF6bhrg9DE9o//p0ngRANtApfqnrhUR8pF+Kkel/f2IfljcUDVxlzgdwwUEELVpD4ClsUCy84bDiCg/J7pPXwodoHtpFH50y8Sj9+/dw+xdp86nXWQHT1A6PRVg5IfsqBQNyQU/kM0RpkqhIFKLAdv7zHr+7fs46IvosZy3WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVM9dhNMm5jDMcNhtRzsL0sUzaCoo6Jfv6AAGuk/Byc=;
 b=J6h/U3t9R7tE622FDOQ6wkLPBYYYFI2kCxbWpNythFTDmvDmy7dfweQsAEzYxDzw7Rs26S099mWxh1SwAPUbR5ZjNc8VnDcqt/8qCs0ux1Jj1dxLAiOnARIFrNNW5Ar6kSEKi4JSiTH2ZS6gtd2E0TJg7+3FWDXTGR20f4jBWPxgpzddZNN2bS9OaK/2lXCXVhmYvdUO5J5p5xw3KmB9hQDFljtGCllMzvcCcTnDKn6X2Xdfd8k+vSnLXJNybQ1/xJiHZPmQr05hSiYy2pgf/Tbgdy0j3a+TKbtTgd3BBDv4bKU80z6GxKaINtr6LBpiBAwqj4mSc4TxUo7rSIOGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVM9dhNMm5jDMcNhtRzsL0sUzaCoo6Jfv6AAGuk/Byc=;
 b=toW8Y5bseSuN/KdyMpfAi3k07dbBnmv7dBPcnSZAreKETHTXMz8+iYPVEVPsE1244+dhNGy4SxJG5v2p3nauXAgSfRGTJogdcBzRtgM2m6VuKA4ZBcar9TjsbzqhP5og35LDXTzoyLJR+puWIt9rmf1LUuxTFVuTkXSRqjiS38g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3445.namprd12.prod.outlook.com (2603:10b6:a03:ac::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 15:04:14 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 15:04:13 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Wed, 11 Mar 2020 11:04:08 -0400
Message-Id: <1583939048-3354-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend
 Transport; Wed, 11 Mar 2020 15:04:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c25d119-8368-40ff-7320-08d7c5cd7602
X-MS-TrafficTypeDiagnostic: BYAPR12MB3445:|BYAPR12MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3445D24645B82EFE687FB772E4FC0@BYAPR12MB3445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(86362001)(4326008)(5660300002)(2906002)(186003)(66476007)(6486002)(16526019)(66556008)(478600001)(6916009)(52116002)(316002)(2616005)(956004)(7696005)(8936002)(81166006)(66946007)(26005)(81156014)(6666004)(8676002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3445;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yji0wyrKS/oQcVuLG0hx1X9POJJe3qxLufT4NIbng0Pu2EvH2VHXtWumWvI2xxk0QdzpxIBoOr2Pt+A8s7cA8FmGvBvXMyiGR7JeKLF6tD0qfOkR6FjFZ5MS4m16KO8Hhfr+R2d67A9pvu+5RKVjoS9YmeQeFfsLs/YPmMUgNGcTR0P+3dFmNGyh29FwAXM+Axp9RmlDDwxF9n6q+TW5DcQ3LLmvuY7IVOrxqunqDEjLlcBAcHccq4uAJUGN9FkQFJEJAE6894RfdhR/jBQAYDKbnD/Zxi0fsAbIKpYrAbCoi8a4ZoS3XD2UkFv6Cmx9s0cp+tqqm1bODdGBcG0sA7BTHOCcd/Hasqz5ueGXGkwYepOEQTY3gHcGZlCUpm8zplJkEAzkHJtDSfYSoGajhlKZMCu5tnWWdtYU5U0eP5h/zbgGSJWsnPI5m53aivjK
X-MS-Exchange-AntiSpam-MessageData: o3til8yVMZT0jA3YqFmobJ4yANVx31QrgY3QwQ7/z2FokmGNUXlV7fToB1zIjEa2Ln8UbKH7W5swU8kKYr+UT8UZCg1oZttIYLbfghmkVvU7PCY9tnTsGYvpLfckh1W5bVpclau7lqpXYy2U8bELEw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c25d119-8368-40ff-7320-08d7c5cd7602
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 15:04:13.8232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkc98HRDRqR/yCMkhx5ma/y15JugdfknwyYKEdhjxS5wBbpHcKocjO7noz08LjIB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3445
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 21 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272f..6dacf78 100644
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
@@ -307,7 +310,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		fences += fence[j];
 	}
 
-	if (fences == 0) {
+	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
@@ -319,13 +322,14 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
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
@@ -345,10 +349,13 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
