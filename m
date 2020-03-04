Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0AC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A944E21739
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rdvHNRuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A944E21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D806EB39;
	Wed,  4 Mar 2020 16:35:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511D06EB39
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyUGOocTrAX915skFXHCXJFgqeQ4J7QAu+pq12TyqyiQ+lo3NwNB7Jsu4NY5jX17tN2ynzKMnjUGtrAGPHBhF7Xxo2JG+Gqol1b8cmkQrdlSdgW9ToI82oBGtEWKrVXGMcow8j99h+MWGMsy0BC+Orb+JqOeYCdL8ssuDOIoojsyQv0YKBp/ST8WM/Bw+s0OI0trsku25k/73f1DDeeTO9OoyLO+LlSoOatJcINIYwt93sx+Zzh53erG+UeIsfcJ4Nb1iOHU11VxPlFF/X3Ya/6S/GTLt1WTGCF5kyS/cWHkhPgBUJUDRshwURIfac2buCOEL2tObyu+mKA9zv/L4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PUgUgXxr/+9Nk3Md6cJW4NgeEApgRQ/ub16DF5ijc4=;
 b=NKHsgCJYhxp/pZ8ALB1bpiWc2ZsG2UaxEIdpavN4X94+kB2ettaJ+e24dZs1L9xR9Hgf1T3CyoxVEloUBr5xwL7sGfuUYsbQn93eJXNK8T4ND3tgorHTSD53o+T+68B94hnrsEpD4B36MBQTuu+zn+MKMllHiTV4iRbZ+y6JjkvSGNanuH5vAfvF18DwZOE28JXSzS5vezGWLCl96WHcLcKnxiBIizxiksoDP0s7/dk7D9Uj+JRd8es1yE/OKx0ZQcxIMGrU/IbP9xFNtOnRnMtDWLXW4JiCvwwueT2eUtobvmpzcAhBilqmfVIPvOWrlWMRuy/qPx4b4f8j3Vf/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PUgUgXxr/+9Nk3Md6cJW4NgeEApgRQ/ub16DF5ijc4=;
 b=rdvHNRuzgSQp/q3JsgDaD6y0sMQmObgRsfGXlMlJjiNtjapYJI7LVHko+XxaniKbG96D0nxtglvCSjudnpDJftFKGgS1tVefycxrZyskbdflATbJ+Q0PhnKMTyIdGmWmMHiEP2lf7foXJq4vSs83Bcz/yTbK51a1Fvu+pnveSOY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 16:35:09 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 16:35:08 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Wed,  4 Mar 2020 11:34:59 -0500
Message-Id: <1583339699-11332-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::29) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:35:07 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df2c38f2-f8a3-43f3-190d-08d7c05a004e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:|BYAPR12MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3576BA3A904AAE495E340896E4E50@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:188;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(7696005)(956004)(52116002)(316002)(2616005)(478600001)(6666004)(36756003)(2906002)(186003)(16526019)(26005)(66476007)(5660300002)(81166006)(8936002)(81156014)(86362001)(4326008)(6486002)(66556008)(8676002)(6916009)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3576;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XbdAsdlGSTlxKh9F1VuwCnnRbBEbLQTivtbis0XzQ+e4JtEITv2jM9UEcFfWjHrynzghi37YjvD3hVGKPEVro5NHptKw3BZNLRLcCFKrzHXeFkTnzghIEoxEj4OQppgOUW/A3E71Sfbr38wpGvVaGgp8RWpXE2f+cxge46LF7S9j9LBYpFP56EFMJPgrZIWLw5qG7pQkDC0C5//hDADFLcG0+vpow4nrqU8Zbnd8tTFuhwz5chXNg/tD4Re8kd7XlbdLZInrsCVCD9ec1Aj3X8ueN1NySglrrgtU/wN5gvDHojcynKMgknZPv5TFOYCbn5rQxSEIpkTqR8z91jG7DtALQ6SvoJNt2/TRND6Aj3l89dHOgJpaDykl6sssda3oHkaHaJ3qTCRAEkEGt2I3fq/FgANgRQ5TZVoDwrB5EgsGpxGfMwI1EeZxujtrW6Ky
X-MS-Exchange-AntiSpam-MessageData: tG8qfmNLBWgnbmYj+01wxgDHzJX7O3wzeO/1EeDJoCg0cXAQOGQ2PZ/PoeKX8XtLJNpnq6zDP494ZDDH30rtm1wYNRZUih1NlhDF0VoR2yMiyAVoqlHswQwLaSK4xuhXVwv0OY/aHcg6vadJHy0lGg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2c38f2-f8a3-43f3-190d-08d7c05a004e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:35:08.5359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV7h+6BHwPBg60hZINRl44Na+Qg2eZ1maenKP15zxNuk5Vd10UGIFhE+jDam007p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f96464e..8a8406b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -63,6 +63,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	int i, r;
 
 	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
+	mutex_init(&adev->vcn.vcn_pg_lock);
 
 	switch (adev->asic_type) {
 	case CHIP_RAVEN:
@@ -210,6 +211,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	}
 
 	release_firmware(adev->vcn.fw);
+	mutex_destroy(&adev->vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -319,13 +321,13 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (set_clocks) {
-		amdgpu_gfx_off_ctrl(adev, false);
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_UNGATE);
-	}
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	mutex_lock(&adev->vcn.vcn_pg_lock);
+	amdgpu_gfx_off_ctrl(adev, false);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
+	       AMD_PG_STATE_UNGATE);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
 		struct dpg_pause_state new_state;
@@ -345,6 +347,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
 	}
+	mutex_unlock(&adev->vcn.vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6fe0573..2ae110d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -200,6 +200,7 @@ struct amdgpu_vcn {
 	struct drm_gpu_scheduler *vcn_dec_sched[AMDGPU_MAX_VCN_INSTANCES];
 	uint32_t		 num_vcn_enc_sched;
 	uint32_t		 num_vcn_dec_sched;
+	struct mutex		 vcn_pg_lock;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
