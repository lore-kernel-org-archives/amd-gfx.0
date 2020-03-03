Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D9C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5295C20656
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yQ/nzeTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5295C20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F05FB6E939;
	Tue,  3 Mar 2020 18:16:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C326E506
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 18:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVfXZQNk2nRNKe9TaaloW2mUr3M9UKg394OgeTrmVMIN+HTqHJxhpPNkoBe/qXlGdsGBMhWi+Nf2bm6GvWTIumYDPNgpsT7OXfyzmUaY5k2Tc9zC8LHAfobNGLxJja0sVYjyPbU3FHvo14Chx15oBA9LhWnqsRnRTjxX4tSvQE4pfmJNziPE6ljmzOvvXtlreI/cBIcDeybPlX13MpJLMdAvKSitYnVyz6VFB0i/TmBjhNz0xoJqTkxZ+0ku5CUCHhUB9xX62cBWgOuJqrKSJyLgk/LH7fwYbrTZqT7BNF+b+GwPxUJ6ivRsC9MAaK3kDOGIdxiDfGGF270SgPO8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iraZFE0Sr/PyYWklo0LeS67A5amd9s7WWSUGaAVAVL8=;
 b=Jikb4bzOQH6EoLY900UHy7cESobNLYYictu9HcRb8UrXYCm97IG2ZcjPpTwm8UTbuerZvgNwFcHH2Aikl9ESb2u/glgAXbP+E+CiMOBGBs7weV9/W9ZzJnYS7/+1CdY5q0NVcDWLYoq4yXgISkD2Avxseip1/wUrlVmsOG6fzj9tc2cMjQEDT+rVk/oSnv03EWOmp5u61McIzt8qJunEj4fHTH5JcuMO6OBbdrslQDfkeuLQYIVcPkRXRysJ67TMkWj0iMsc6EXWNuYDbXJ4gOuCHwAQXwMA+lACSmVWEbKvXvpiRC2kszH4uzSpxZ7PANKiTiQvpdz2QPfjl8VMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iraZFE0Sr/PyYWklo0LeS67A5amd9s7WWSUGaAVAVL8=;
 b=yQ/nzeTtdp7qa1awZQAY8Jp/0aNcF4oX9ewMQJ5hVm0/HylYZFYI9JL/82M70zegVeLfICWMU1BefzpP4tXLIZqNbRytf6XcGU12sMjDe3aKdBs6EHX0aIIg1nxaWsRnR532422EZD/6GWvqyJdBaMpPWZhyoFiOUYQJn+kWcXA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3622.namprd12.prod.outlook.com (2603:10b6:a03:d9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 18:16:38 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 18:16:38 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Tue,  3 Mar 2020 13:16:28 -0500
Message-Id: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::29) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 18:16:37 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8658fb43-4051-48c3-898c-08d7bf9f03a8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3622:|BYAPR12MB3622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3622B3B9DDA74B2E7DEFDEDCE4E40@BYAPR12MB3622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(6486002)(8936002)(86362001)(36756003)(6666004)(4326008)(8676002)(81166006)(6916009)(81156014)(478600001)(316002)(66476007)(66556008)(66946007)(26005)(16526019)(5660300002)(2616005)(956004)(7696005)(186003)(52116002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3622;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G7c53/gerLHX7Q65RvyuYkGM2GUuTLJofs8pYiVXEoItKHuIG/96y0/8WdnEcAkS8ITnWzO/+KmWY6Nih1YFc6E/j7gaWhXR1cnjWApLMPbqvJBmOq6lzakuqMr2ZK8XskfeQtfKQzSqUgWAHhasDUwUenn6M21SLp0C1v0a7TdG/Mn7nn8uZnggDMTAK3jcAbpafOZJ8CmalwNYb0f7cmPuhkqXXKurug/czin+S69IQAhTlr+aNEb+HrLPiWMyqqLIJQauPN/cw/ODU8u5JGtQqPAMn5zMzlgMM3OtUIMT5WsTz2+SZtcCWpfy8YDav3E0VOdoDgIiRVNN8DPQ5B8Q1yv8oOMhqJjZUQxENhymx4FkfroRCujyuPu0ZFKSQ62gd8w4tOV3M4Aa+D9w8q2k6nXaiwtsKV7bjg7ZIBTa/yaeyOZFkcdbMs3UWsv
X-MS-Exchange-AntiSpam-MessageData: CRuk19fqcus3kQEizGxbZqOTCpYMvWSCnFUreOX8x3P7p7xe/2fRLf+tADH1V+RJunPZpEa2x4uOA7sVpdIrBHmkT7nmJkMFse+6N+esUfgqOgO6Rr5RzhuTxEP0uEz0SyTm0sGQxF3rzoEw7WzE1A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8658fb43-4051-48c3-898c-08d7bf9f03a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 18:16:38.0395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jksFXLsnCKrxkEXPsXZPy1bAfm2DcePzS9YLHrlYxM1C9gYWV+gaKrEoSaz9z34V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f96464e..aa7663f 100644
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
@@ -321,6 +323,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
 
+	mutex_lock(&adev->vcn.vcn_pg_lock);
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
@@ -345,6 +348,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
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
