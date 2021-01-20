Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFA3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D177F2310D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 03:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D177F2310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68A16E062;
	Wed, 20 Jan 2021 03:09:38 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700088.outbound.protection.outlook.com [40.107.70.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EB06E062
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 03:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOUULZFvYtrzN2bf0amvfLz33z+CEXyb+UwOaWJKMT5Bv1J+LiCvwyPzaI6U5CCjqnQQJvOIK0xHzBal8XT1b2bF3QFcSaU6FJ5BQzDs0lKFOjE06teZ6B8kh2ghvltIlK9W6ufrCVHdKe+I96hVOGuwCk9+yAzSEjJf9mln+DfVYavutu48N0dQBZEiRLdm/7mNB41cf6BGYTBnvk/mUFObjq7ql5P22+xPKbFLsUyXL7F0kBJKxJYgaWThvY1tKAW5s68j4bhXhv0XtvtTb9+m2nDmJijfzuG3HhgNNxqsPripn0yC8Ys0QLHKt8VscErceULQonZiDR4NwRH73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbilNavM9skTnZOVw00pyhWr2M8BFxqtoe42A2/Cs1o=;
 b=bVFVStL+gIR9jZyq0ltqd3NwYQCaapVuJDny6eXN2Hg5tbvXAEc2yMAMjiPexQGXsbRON3wI226QJyAaI48Xt345xGka7VJoQ2ZcYOr0Moz3ad2lR3JjsN+SGfpMmTRMAZCc0g/8Kq39I+KETR9JJu50kcKZKaV4L9+EYuk6MmrHMZzxNxT7xsXn+PkysmjTpG7e8wiycGoFJ12e0YN10miquct7Zw7O6tQaClaMqA7u/uWgUl0BuWjG283QEuIys7dKigrugmV5/ame8u010RjDOqaWHoEOP2IP/AuJyaBJuUr194a2uBMRhbtNMlGzMDb0j4m6JJJgJnG8JDvrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbilNavM9skTnZOVw00pyhWr2M8BFxqtoe42A2/Cs1o=;
 b=exJaaUAmnbtzc7i8RLSqO0Cm1L/BS+DxYECHrcGCqZ4X44kQYdThgjP0eT2C3Jrn160ff9R5sRUsakFpvD2tN5tundnz9Bvw2m1UhCpy6hU8TNahQoJHYg2nl96gP7pt+/WQisF+8SrPkFH70txDLGaAqfA4b2rIR2UwGMthPmY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Wed, 20 Jan 2021 03:09:35 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 03:09:35 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add RLC_PG_DELAY_3 for Vangogh
Date: Wed, 20 Jan 2021 11:09:11 +0800
Message-Id: <20210120030911.32646-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0086.apcprd04.prod.outlook.com (2603:1096:202:15::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 03:09:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5aca175-5ac1-4dda-4e88-08d8bcf0d0de
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18822220F4BC757C8AF29C6190A29@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnkFWEi8LerCPMzbwoFWiU5UWSy9dtyKq7YNvJkr4yXmxKmvjCeDiADUt2Fq1SMq+82T2Erqt3F0aR0UCt/PWiwxPdr00dvuUv/oRv8oyw4kkA8NJ8zATwPTLedeZ4vhSlSygkbv8vFg7UwRPL+NKfG2B9gsLJVpCkBPhX/1BuxdY7Dph7MjrP4z6r0tb+YSI0DOwPKldzWaToxHmWndsvixC9OjdFwMc/5ZYDOwAzBT+4WsYRHLFtcwgc6HIRbmFu25SSeCcZsJfEqvdCQWVv7tmX+1fPkJtmDm53RuoXZDki5U2bQmZDZBRrU2po3qUHZ4KDrb0/IpNu6WB+9NLucqx+gSBnX5tAFbRY7i9BvdMlEa3ygyNqBr6ubJRy+8sMEG2GPzae/dlzQ3hRfN3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(478600001)(66476007)(6666004)(316002)(4326008)(7696005)(66556008)(66946007)(8936002)(5660300002)(52116002)(36756003)(186003)(26005)(8676002)(2906002)(2616005)(6486002)(956004)(16526019)(6916009)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s/A3hLfPeUzC2kVeapClKASp115NXpeXHBpy4tz3bKM6CGEQAFuo3jUp5B2Y?=
 =?us-ascii?Q?DWKTPEI5IaSaWlUIsZ5jcFDKrKgKxp7aPJa/B16YMKvmUmf88qa4pVNuevHm?=
 =?us-ascii?Q?tnKh59xlEMm/t0AmWxb7keao1kFANKV5ghLoJqZMnLvwgnVlqmf3Kz4+XzOA?=
 =?us-ascii?Q?uwIzzGUAemoPazmVu95I+7t4IgPQmMlBaZSPoUw7kqic7/ZzO7Gw6FfGEWfA?=
 =?us-ascii?Q?LFoZMvc2m6P9okSFbqvdsYyDZdBCVS/zPOmk8Pu+yU1R/ld1d+64rzLWw2Vv?=
 =?us-ascii?Q?2tHMeimHPQI4WrYifSgYBnO9TFSR/tkn25qG19WqoRRUsX9lvQ1WJFTl0jJd?=
 =?us-ascii?Q?X/stDkfN1NazlcNpewWpUAUI9rWvBalv9Fdrd33VaYtskkhsWOX8vFVLkf0i?=
 =?us-ascii?Q?o7i/rRm+yQIBTxVBlTR5taDrHbjygiTal2BOUnf2tsupfuWJ/il0B5id3rUE?=
 =?us-ascii?Q?rLDZw76LOsk/GsP/ZNdpd+ATdkzLcRMC0RXHjsZE6sa3qMggm9+RI1hVRlRt?=
 =?us-ascii?Q?C2qH4s0Imfu7qRBs843UArMTFBFYKl/bLlhsdWFw0gvHpSN5aoOvLUuTl40K?=
 =?us-ascii?Q?YdpzkyuUlmWBByhLPdp1N+yQBW1IuTwHQODxZj9fMw8QyGC+XOwB5ufNpfSn?=
 =?us-ascii?Q?vQK8ZFDojk3wTpGrzmuf0nPGw0VceqhgS3JVRflnlXyDFN1sd2cMkBDjJJY4?=
 =?us-ascii?Q?XZZZcmJy6E/uLKv3J4oE+FDQisb2LRTxlIEjFSJpQ5Fpx1GKZC1pG+z48KZL?=
 =?us-ascii?Q?OdDrs57sbPDzyTy+njc+XJVK8Pef8H8s+laQh4qnLRnzHaVOJ2D+eICGSG6i?=
 =?us-ascii?Q?TTvrq/jD1+W0SV9AXockUBNhaE5hQwTG+KRjcMIcoATbFfYVgKy1OJW2oV0Z?=
 =?us-ascii?Q?lOEPtTxFaqN3WEpJw3DvVPfsjecf25kLrp0kFLLGLIWpQ97v0Z2CQge+axyt?=
 =?us-ascii?Q?5494JMm//UXmvRBS8YE2NUNXrXv+HZCXRU1RyNUS/pSn2wvRjoz/bf6ErQjC?=
 =?us-ascii?Q?vJHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aca175-5ac1-4dda-4e88-08d8bcf0d0de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 03:09:35.7294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMfqD3FUHEJ4IzfWL5QCCVPmAlUQqVOinj8F6L+LcQLO+8/VTQc6Qy1Xszum9/P4C8VdgU7F5OE4GmeeG73y9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver should enable the CGPG feature for RLC in safe mode to
prevent any misalignment or conflict in middle of any power
feature entry/exit sequence.
Achieved by setting RLC_PG_CNTL.GFX_POWER_GATING_ENABLE = 0x1,
and RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG
hysteresis value in refclk count.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4314e25f560..dd102cc2516a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -120,6 +120,7 @@
 #define mmSPI_CONFIG_CNTL_Vangogh_BASE_IDX       1
 #define mmGCR_GENERAL_CNTL_Vangogh               0x1580
 #define mmGCR_GENERAL_CNTL_Vangogh_BASE_IDX      0
+#define RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh   0x0000FFFFL
 
 #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
 #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
@@ -7829,6 +7830,20 @@ static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
 
 	WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
+
+	/*
+	 * CGPG enablement required and the register to program the hysteresis value
+	 * RLC_PG_DELAY_3.CGCG_ACTIVE_BEFORE_CGPG to the desired CGPG hysteresis value
+	 * in refclk count. Note that RLC FW is modified to take 16 bits from
+	 * RLC_PG_DELAY_3[15:0] as the hysteresis instead of just 8 bits.
+	 *
+	 * The recommendation from RLC team is setting RLC_PG_DELAY_3 to 200us(0x4E20)
+	 * as part of CGPG enablement starting point.
+	 */
+	if (enable && (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG) && adev->asic_type == CHIP_VANGOGH) {
+		data = 0x4E20 & RLC_PG_DELAY_3__CGCG_ACTIVE_BEFORE_CGPG_MASK_Vangogh;
+		WREG32_SOC15(GC, 0, mmRLC_PG_DELAY_3, data);
+	}
 }
 
 static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
