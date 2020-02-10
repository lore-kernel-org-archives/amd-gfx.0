Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AFEC35254
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E09C2082F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B2XxCr1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E09C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D863D6E9D8;
	Mon, 10 Feb 2020 18:07:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCB46E9D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI6HoJ+qT9kKtET7RFKHLTHqT+p0NeOBzcwWfWrFsELoU5+5gg9GzzCkCHGmiJh6YuLszmA6xrocEPlutbCGdhWiGxcXfkdPZCAbJy6lyT5rJO6izU94kKtatjyP0tjnn1vIjAqvnUZsK5WlYP8b29cGN7En37ofM4CJuIN29JsBwzmTQpKbwCx4bRYJj38p1p/C5YIDiJB+1acvPb93mnMm3IzrQbx2xx6l+GuUeAEK/RNqjN8QNxyzklfHWmosllzh73y+Yu4ATnu0rcg6MtvTcv1c8KV/UCh1nomH5doSVcAlIudjCoAgaM4LihUabJ2ZjxcGBcKtoK4wVo9vIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iraZFE0Sr/PyYWklo0LeS67A5amd9s7WWSUGaAVAVL8=;
 b=gw+KXT8SnBNU3hjxnAlnEArgir3fi5XiGtIA8XcvrbJK2bAXcCCJwDXmeL13TwmAy+rTvd0QU5PA/sqMjYGcnR7yHg+cNsxqc7EWEO5Zt+xntoklOdxe6knJYK3a7NkcjcHKjufWzxzZMcsdjsfIooLhLzp7w3VmzZaQeha1TG4uXA5awBw9qqDSKSjkrVU8B9Csuqhb6b95xPm1xxfd+Q/5cQYgLHsXppEuSnVTbRo1XJkvtqJbeLynhaYM0ZmQS0OGj+c8Jc8g3UVER0qEFXEDX0dvcWtlVG8GyNkbbPptKJXg1Kwh8NIcUSfonBtDlGCfM2xlnoY5Pux2Z/voHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iraZFE0Sr/PyYWklo0LeS67A5amd9s7WWSUGaAVAVL8=;
 b=B2XxCr1StNnDciDFHDgQmZvN7q0R3qBiVfUSN1d1dQHyFoxekH2LUBbyJfWj7qmatWr2SvlyqxgT21usu01gczPbCnmkzu/a9CJstouIoojWBrdCqzeKKcwIXeVhOmqQ5laz9imMAo0vFxyNitmHl+ktioIq0/l+svgLUX0Vr8E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3477.namprd12.prod.outlook.com (20.178.196.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Mon, 10 Feb 2020 18:07:03 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:07:03 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Mon, 10 Feb 2020 13:06:55 -0500
Message-Id: <1581358016-8986-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 18:07:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 475cc81a-2c85-4e38-fbce-08d7ae54080f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3477:|BYAPR12MB3477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34771EA722BC9BD02B8D083EE4190@BYAPR12MB3477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:15;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(199004)(189003)(7696005)(186003)(2906002)(2616005)(956004)(16526019)(316002)(8936002)(8676002)(81166006)(81156014)(478600001)(52116002)(6486002)(6666004)(36756003)(5660300002)(4326008)(26005)(66476007)(66946007)(6916009)(66556008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3477;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xf794d9P145aGQE2DB4Pkg6RbwAiOIoaCchOAd1ziU9WNun2T6yH9qZuzzE93yiO6W/J1Z/qTvyqLT+SjocXMUiAJ7GnTWuxGyb1MMAyuxEeQjh9MEA72vKM8CbjBaNEK3UAv8Hitw5Vss+crhG1ZanF5LOnz9wSr2PxX3u1Hsyctd2KgczF3rOq0WjzPq5mQ0F1g36OzurHOHZBZeFD/k6wbaPv0gjZf6F8p+YdWvvl9XcIZHcQYYoyqc731lLSEHRzCYlHCrMHD+EqLRpbfrivwbQURjgdNnTNmUronrcfKdBn1fPwXZLEVZX1DkzJgkNO5Qkww+Q+ONA/m3CVH46LXDBrSH+59SIDig74V0hu97W+KbMQ5XBkYWeX7abELhHw5Zh9x+44vpFnydPKCExrzhtgCEZapUfttzgVWRaJ01escG1aIrc7SnRumtGl
X-MS-Exchange-AntiSpam-MessageData: NruRdXwJjl6DbcswjlgVy8mmgEWGJx7gq58zlMq1FZY76DEd3JhsOmLobOPoo5SB1TKQKqO6wNN0vFujuUqUV7hnXJFjYOZIBNq9BiZNdRqBZRuGKa/RQiu1mWcQRYRqXIkHrX0mrkkP/mjzf0rXgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475cc81a-2c85-4e38-fbce-08d7ae54080f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:07:03.5553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUq9F39DVl0Gf0Wgdxs3+uPu9xivQ6QiM2A0MGvu/aVJcHiZKYX/8UIav8wqhgA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3477
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
