Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDFC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3E064E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3E064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C936EBAC;
	Wed, 24 Feb 2021 22:22:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187DC6EBAA
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj5RstxTyIujAWlcvApsUGtcvRxczIToluWu4xHYYpOxhZJNXfmj42Z9mxfhKaKzHqiMrJlAmkMnMAfpIgiSbazUB/bkXXIlVrSNIKQADXJDnFwcmN69j4EKmJQch5+yBR5LIu4Ihd1CskwbXOdGcxvjbIyIOnviSaw2IKanHZYzJGbAqg62H0Us+Mw07+1S2ywMWqhFqGGmkDoobbv2eB05vR+kXm0w1TQmtRujoKFQZcc007xasT7BOP2iML79ezL+wigp22veRlu9swZf4CxSLzQmXV42wc24sDh27cEpSYuToBUptoWE5fXkqUmjTX8ZNb46K+GcUIwnZkQnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hBH41SRBKhY5s+QjFQuPloFJyPWf0usKhZPS8B0e8E=;
 b=MHJMTwx2j8HsiVrkEv/efzoThj+dABamxLMRRZskCzkN/XYh+LqxYqSKodbjquE0dRVCXFEqkCFBzVA6D5ZJUQkFgp4keL1rEXybJFeHRkGag1qlD/IncYUfjQe2+U4BoU2Z1BH+jA1dLZWBshdBgP+a+cSQ9S9KD2ewGeGs0XbGRZfHYfewMxq3c36tE1eHI8XAoKzqrROP4agOBtd/che07hO/If/spge0eoiMTOZVFsp2f6W4Aw1pMw3Ahc2Xt76N+Zg33Yr2c2Ld/01MeE3RzzM5QHDtz1PY1gEqo9E0f7vjM0oXlKH1FDsU61gbB7FTkULccY2S8D12lUspiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hBH41SRBKhY5s+QjFQuPloFJyPWf0usKhZPS8B0e8E=;
 b=g3ga7fArEypi76Et/NZXc/1vfyQibxQtm0WM7CMunHYmqODeKsR/OxWoYHGUPB/W2S0jmuGhQk7nEPn6zXcBKEpSlRRAKmj2ZTURACB1HgjOQg//c50l6FwNFabCALJCgMdbGwcM+3uHizBsu+MFxikw9lF2b8OdlBCML2PXGBw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:39 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 154/159] drm/amdgpu: enable watchdog feature for SQ of
 aldebaran
Date: Wed, 24 Feb 2021 17:18:54 -0500
Message-Id: <20210224221859.3068810-147-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7903b48-eef9-4cbc-0a8e-08d8d9127a68
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47221CA11B43FBDCCE97AC80F79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2Nd9DDQ4FzoLlH9zRiyw6OSm7qMx0vk6wvWFEHkya7jK9Bnx1olWY7dxEhCSDJ70WjFJ2SPXPiIUPF/tIvq0gU0+8mCEfrEm4D7rCqqUBZrkTBpUkzqtIjo0WJKsGKVAKyB9dLEITbCz2PKbcEWbu2T4k+bTMt122xDmzZqhJqpcC8fNgHxKLAWmUojPWcXur15PotAqwPjdwgKtEcqLT6bEnuhqsqJXsJMLIdKKBj0JEl7z+vib1UgwxreLtANgMrWd41lXb6mZ/GHqXwBxIkLbYfLnTvb7UDnU6qp1ukfWjxHjaLSNCqxY1P4OSwwcGHbMuVDG50d8c/jFMlatEMqTSOjmW9OptJGksNCRm0xOfsT9JxAMTvqLbp7Ql6AQUSrGZoe+GxzyNOu4lQ8Pfu+phXV2S3KL1cZQCzJtnESROV8xl0JbMRZSumzMK3wFEpZQ6MdAjHBqSONw5UJzEQ5ZZXtKdHhYejTVr+DqFrTJbTUMccXkWbPSa3C4MdseVG/bLMiGHGq5SAfcJAGOUlDbJOA40GjSefNB2UO4hEFFYC+eIVXVhNv56r9KtfuweTaSn9JaYPg3M4gCIS8Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(69590400012)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(30864003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bOLiFBITzilhY8ByXyqqaEYWQoDMlywTrt6QihrUosrcYUN86Fy+uPioJRmB?=
 =?us-ascii?Q?XIyO3X4upqnIWAM2aAfzaATCW48jVvnES98FZ11aYhwQuAWBqYxgm2ZAybzP?=
 =?us-ascii?Q?v89S4i4M5aGLDprfjt3kf4xzhBYIJapTNiurb0S2nxuAVE8bbykjUwj11HCD?=
 =?us-ascii?Q?ImRnvlHQvKA1lwAkNw08YGgOWIJUumrrOjsmfzEE/pMOYGWe74ArPA89TxSj?=
 =?us-ascii?Q?jhSBDy0ZmkA8YXdWXRZPH8C5TxnqMOgikyyGbEmSltZs1NaPXoVYpnQ6YZ/e?=
 =?us-ascii?Q?d1toRf9cEyoe4TTfuQxh8wW8GXrA+2H7Fhmi22IuqGoeGXD9f20famCXA5R6?=
 =?us-ascii?Q?ZAVx4ObxGA9vC5tK7gb1YEwr+etxQ9qvXy6OZSsB295venlvTv2YrsRFcfK9?=
 =?us-ascii?Q?cGfbr0uJkB7+d8ZaEOCUpZP+qqm91Rr3bVGTYQYy1csiDxfDKfT9XDrJCx6W?=
 =?us-ascii?Q?bqwBeHh41AcE1YXOLy1cmNoTthraLRjrRjFXlmGZjVXGY5eZ0XOny+UA7Er5?=
 =?us-ascii?Q?Q9NH7e5hfBwbamK1QXFMCkIwMJDvuuFydgCTO1mPrhVUjos1BL+2LdVDRQn/?=
 =?us-ascii?Q?NbGmyZ/b17662OVPD/5xFWv7GG83pjiYArbkGQU1lQs/aLKOzDJc2DtDI+KF?=
 =?us-ascii?Q?l9ApZ2EQYkEzcW3oWIMViuiwzO3b+OxZy4tW1AV86hGlWaXwhf+lSM5F6992?=
 =?us-ascii?Q?6ar+YvwN0rYrtj7QEzQgspGCM6k2mC1VJSv5Ksw6OzDsYm3yp+FAqMq91u+U?=
 =?us-ascii?Q?YhZPGcBU9LpJN37LwQWPaC+uKS2QbFMc61gBpOMm8UHbIU0BsRQnr1FHIGlt?=
 =?us-ascii?Q?x6g3amH/sc0oYoaJJ8NVfsqydIs5StD8MeNflKKfNIEkRqvszm26tNdrOuKy?=
 =?us-ascii?Q?1X2rfvCWZf1CMgE4Lt6+7/azq6/ivUfeHiQFK8L1vdJoVX3rFvCoGtUmNHCV?=
 =?us-ascii?Q?1/YkF+ig5NyFGVgzYkna+lD6gHmYVhQNxyUdNyEMbwYeaVwVaJUPZDmdxDuY?=
 =?us-ascii?Q?Cloa/D1T61JTU2Oi+WW9YvlpR7MszyBSsVY8ytSRCh3gJ5/GPP4w+xFEaGiN?=
 =?us-ascii?Q?qUAZN23nxhe5l8+bTQCTzR/vtxm6HFZb+3QK6R06RiSpcTEeDr1Hd17aoCjG?=
 =?us-ascii?Q?iqYuygrNQZcT/eyVdul9fOMlbf2UlDRadKJ8CbUbM1u2UXJ8CsBQXMi39Ng5?=
 =?us-ascii?Q?jqdlQyBZc3vR5TNKK9yHSOVWNNuKwVqy9DySeGZNeZtBiA4GWNcBBwhd9ETh?=
 =?us-ascii?Q?d7qdKr0Wgh2EIvuu/Td/lmLpEi0xJbkTRtvG0jJ3HEZlhHIgqCx7P5ZEDEi5?=
 =?us-ascii?Q?PHEaB8xKsawXH/92d70/0YFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7903b48-eef9-4cbc-0a8e-08d8d9127a68
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:06.1413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 553cc4+bgK0WzEvUiEdhIfIKE7qEiXfTvz8/bLm/27o/FZD+b90IUMzzrGHHcPV2LbXbElMZyqbQm6Hmwb4sBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Li <Dennis.Li@amd.com>

SQ's watchdog timer monitors forward progress, a mask of which waves
caused the watchdog timeout is recorded into ras status registers and
then trigger a system fatal error event.

v2:
1. change *query_timeout_status to *query_sq_timeout_status.
2. move query_sq_timeout_status into amdgpu_ras_do_recovery.
3. add module parameters to enable/disable fatal error event and modify
the watchdog timer.

v3:
1. remove unused parameters of *enable_watchdog_timer

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  18 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |   5 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c   | 106 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h |  30 ++++++
 8 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 361e84369b6c..f82ad1b8eed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -127,6 +127,12 @@ struct amdgpu_mgpu_info
 	uint32_t			num_apu;
 };
 
+struct amdgpu_watchdog_timer
+{
+	bool timeout_fatal_disable;
+	uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
+};
+
 #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
 
 /*
@@ -186,6 +192,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c4d822b46ea4..42654deb9c55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -172,6 +172,10 @@ struct amdgpu_mgpu_info mgpu_info = {
 int amdgpu_ras_enable = -1;
 uint amdgpu_ras_mask = 0xffffffff;
 int amdgpu_bad_page_threshold = 100;
+struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
+	.timeout_fatal_disable = false,
+	.period = 0x3f, /* about 8s */
+};
 
 /**
  * DOC: vramlimit (int)
@@ -527,6 +531,20 @@ module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);
 MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffffffff), only valid when ras_enable == 1");
 module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
 
+/**
+ * DOC: timeout_fatal_disable (bool)
+ * Disable Watchdog timeout fatal error event
+ */
+MODULE_PARM_DESC(timeout_fatal_disable, "disable watchdog timeout fatal error (false = default)");
+module_param_named(timeout_fatal_disable, amdgpu_watchdog_timer.timeout_fatal_disable, bool, 0644);
+
+/**
+ * DOC: timeout_period (uint)
+ * Modify the watchdog timeout max_cycles as (1 << period)
+ */
+MODULE_PARM_DESC(timeout_period, "watchdog timeout period (0x1F = default), timeout maxCycles = (1 << period)");
+module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
+
 /**
  * DOC: si_support (int)
  * Set SI support driver. This parameter works after set config CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1ab9632282d4..d92f0f14cbeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -226,6 +226,8 @@ struct amdgpu_gfx_funcs {
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*query_ras_error_status) (struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	void (*enable_watchdog_timer)(struct amdgpu_device *adev);
+	void (*query_sq_timeout_status)(struct amdgpu_device *adev);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 09546dec40ff..5805c78c356b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1467,6 +1467,9 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	case AMDGPU_RAS_BLOCK__GFX:
 		if (adev->gfx.funcs->query_ras_error_status)
 			adev->gfx.funcs->query_ras_error_status(adev);
+
+		if (adev->gfx.funcs->query_sq_timeout_status)
+			adev->gfx.funcs->query_sq_timeout_status(adev);
 		break;
 	case AMDGPU_RAS_BLOCK__MMHUB:
 		if (adev->mmhub.funcs->query_ras_error_status)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 977eeec70e1b..c37139d2c487 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2121,6 +2121,8 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_2_gfx_funcs = {
 	.query_ras_error_count = &gfx_v9_4_2_query_ras_error_count,
 	.reset_ras_error_count = &gfx_v9_4_2_reset_ras_error_count,
 	.query_ras_error_status = &gfx_v9_4_2_query_ras_error_status,
+	.enable_watchdog_timer = &gfx_v9_4_2_enable_watchdog_timer,
+	.query_sq_timeout_status = &gfx_v9_4_2_query_sq_timeout_status,
 };
 
 static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
@@ -3965,6 +3967,9 @@ static int gfx_v9_0_hw_init(void *handle)
 	if (adev->asic_type == CHIP_ALDEBARAN)
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
+	if (adev->gfx.funcs->enable_watchdog_timer)
+		adev->gfx.funcs->enable_watchdog_timer(adev);
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index b2e2026c3ec7..1faeae14ead9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1129,3 +1129,109 @@ void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev)
 	gfx_v9_4_2_query_ea_err_status(adev);
 	gfx_v9_4_2_query_utc_err_status(adev);
 }
+
+void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev)
+{
+	uint32_t i;
+	uint32_t data;
+
+	data = REG_SET_FIELD(0, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
+			     amdgpu_watchdog_timer.timeout_fatal_disable ? 1 :
+									   0);
+	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, PERIOD_SEL,
+			     amdgpu_watchdog_timer.period);
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		gfx_v9_4_2_select_se_sh(adev, i, 0xffffffff, 0xffffffff);
+		WREG32_SOC15(GC, 0, regSQ_TIMEOUT_CONFIG, data);
+	}
+	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
+
+static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd, uint32_t wave, uint32_t address)
+{
+	WREG32_SOC15_RLC_EX(reg, GC, 0, regSQ_IND_INDEX,
+		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
+		(simd << SQ_IND_INDEX__SIMD_ID__SHIFT) |
+		(address << SQ_IND_INDEX__INDEX__SHIFT) |
+		(SQ_IND_INDEX__FORCE_READ_MASK));
+	return RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+}
+
+static void gfx_v9_4_2_log_cu_timeout_status(struct amdgpu_device *adev,
+					uint32_t status)
+{
+	struct amdgpu_cu_info *cu_info = &adev->gfx.cu_info;
+	uint32_t i, simd, wave;
+	uint32_t wave_status;
+	uint32_t wave_pc_lo, wave_pc_hi;
+	uint32_t wave_exec_lo, wave_exec_hi;
+	uint32_t wave_inst_dw0, wave_inst_dw1;
+	uint32_t wave_ib_sts;
+
+	for (i = 0; i < 32; i++) {
+		if (!((i << 1) & status))
+			continue;
+
+		simd = i / cu_info->max_waves_per_simd;
+		wave = i % cu_info->max_waves_per_simd;
+
+		wave_status = wave_read_ind(adev, simd, wave, ixSQ_WAVE_STATUS);
+		wave_pc_lo = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_LO);
+		wave_pc_hi = wave_read_ind(adev, simd, wave, ixSQ_WAVE_PC_HI);
+		wave_exec_lo =
+			wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_LO);
+		wave_exec_hi =
+			wave_read_ind(adev, simd, wave, ixSQ_WAVE_EXEC_HI);
+		wave_inst_dw0 =
+			wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW0);
+		wave_inst_dw1 =
+			wave_read_ind(adev, simd, wave, ixSQ_WAVE_INST_DW1);
+		wave_ib_sts = wave_read_ind(adev, simd, wave, ixSQ_WAVE_IB_STS);
+
+		dev_info(
+			adev->dev,
+			"\t SIMD %d, Wave %d: status 0x%x, pc 0x%llx, exec 0x%llx, inst 0x%llx, ib_sts 0x%x\n",
+			simd, wave, wave_status,
+			((uint64_t)wave_pc_hi << 32 | wave_pc_lo),
+			((uint64_t)wave_exec_hi << 32 | wave_exec_lo),
+			((uint64_t)wave_inst_dw1 << 32 | wave_inst_dw0),
+			wave_ib_sts);
+	}
+}
+
+void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev)
+{
+	uint32_t se_idx, sh_idx, cu_idx;
+	uint32_t status;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (se_idx = 0; se_idx < adev->gfx.config.max_shader_engines;
+	     se_idx++) {
+		for (sh_idx = 0; sh_idx < adev->gfx.config.max_sh_per_se;
+		     sh_idx++) {
+			for (cu_idx = 0;
+			     cu_idx < adev->gfx.config.max_cu_per_sh;
+			     cu_idx++) {
+				gfx_v9_4_2_select_se_sh(adev, se_idx, sh_idx,
+							cu_idx);
+				status = RREG32_SOC15(GC, 0,
+						      regSQ_TIMEOUT_STATUS);
+				if (status != 0) {
+					dev_info(
+						adev->dev,
+						"GFX Watchdog Timeout: SE %d, SH %d, CU %d\n",
+						se_idx, sh_idx, cu_idx);
+					gfx_v9_4_2_log_cu_timeout_status(
+						adev, status);
+				}
+				/* clear old status */
+				WREG32_SOC15(GC, 0, regSQ_TIMEOUT_STATUS, 0);
+			}
+		}
+	}
+	gfx_v9_4_2_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index d7e3041947e8..e01fa6afa8e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -35,4 +35,7 @@ int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_if);
 void gfx_v9_4_2_query_ras_error_status(struct amdgpu_device *adev);
 int gfx_v9_4_2_query_ras_error_count(struct amdgpu_device *adev,
 				   void *ras_error_status);
+
+void gfx_v9_4_2_enable_watchdog_timer(struct amdgpu_device *adev);
+void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev);
 #endif /* __GFX_V9_4_2_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 52ffbea63a4f..8cdf5d1685cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -100,6 +100,30 @@
 		}	\
 	} while (0)
 
+#define WREG32_RLC_EX(prefix, reg, value) \
+	do {							\
+		if (amdgpu_sriov_fullaccess(adev)) {    \
+			uint32_t i = 0;	\
+			uint32_t retries = 50000;	\
+			uint32_t r0 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG0_BASE_IDX] + prefix##SCRATCH_REG0;	\
+			uint32_t r1 = adev->reg_offset[GC_HWIP][0][prefix##SCRATCH_REG1_BASE_IDX] + prefix##SCRATCH_REG1;	\
+			uint32_t spare_int = adev->reg_offset[GC_HWIP][0][prefix##RLC_SPARE_INT_BASE_IDX] + prefix##RLC_SPARE_INT;	\
+			WREG32(r0, value);	\
+			WREG32(r1, (reg | 0x80000000));	\
+			WREG32(spare_int, 0x1);	\
+			for (i = 0; i < retries; i++) {	\
+				u32 tmp = RREG32(r1);	\
+				if (!(tmp & 0x80000000))	\
+					break;	\
+				udelay(10);	\
+			}	\
+			if (i >= retries)	\
+				pr_err("timeout: rlcg program reg:0x%05x failed !\n", reg);	\
+		} else {	\
+			WREG32(reg, value); \
+		}	\
+	} while (0)
+
 #define WREG32_SOC15_RLC_SHADOW(ip, inst, reg, value) \
 	do {							\
 		uint32_t target_reg = adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg;\
@@ -142,6 +166,12 @@
 			WREG32_RLC(target_reg, value); \
 	} while (0)
 
+#define WREG32_SOC15_RLC_EX(prefix, ip, inst, reg, value) \
+	do {							\
+			uint32_t target_reg = adev->reg_offset[GC_HWIP][0][reg##_BASE_IDX] + reg;\
+			WREG32_RLC_EX(prefix, target_reg, value); \
+	} while (0)
+
 #define WREG32_FIELD15_RLC(ip, idx, reg, field, val)   \
     WREG32_RLC((adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg), \
     (RREG32(adev->reg_offset[ip##_HWIP][idx][mm##reg##_BASE_IDX] + mm##reg) \
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
