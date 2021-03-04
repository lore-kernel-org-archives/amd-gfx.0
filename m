Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A507C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CDB64EF9
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 07:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CDB64EF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB466E9EE;
	Thu,  4 Mar 2021 07:35:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9156E9EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 07:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giA5bAXYl9SHVqGEw4VOKLkCMVTMMNjSEkeCCCsiNGE7TyGCLwj2wwX5J9xeloFe9upVne4daJx1LVb8Bo2jCCGN0QgGOARV4G9lfDNQvi5Q0AkGEHn0U74DKIEe6R5goV4nwpjNBMi7ipPpfwOoRKv++4nTp0BbB5tSldTjge6qTkCfpMTCPqyp6ePvAP30cKEEgVMzhK+DyMr927eE4Ux6/RhTxO1DTqEibx72f62Y8caBOXgoElUx0nz7Jwp+Sf4/kkRjtKRt1DzGfFMW0IYxw57fD5jGQTUBakCrYQR5KSN0X2EK+80j/kjN6fz7KwYdlM7XsFXI15x2orVHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/7QLCGYieJ151cSDLToBxyUkFxHDj16UG24rP6SiKY=;
 b=If3WNo+/Wiia/FlhvCfCtN2Ip4VnJBu4CfLdMl7Gb83zILP+Hesi2eEFRIt7MVYgC6O4fFigyCwEJsY2odlbPu6e7+EbR8SEE6NALxyvvt0wUkAsL9SX6BGZT84pH0vCVNdzHd2KWRfyqlK5qRKbhTShqOZDGXyL/11ZhWNEaXSyLjDfueSwzjo6IiHsbrFtivzUUAZL5mOtVahnwApLEjtnKp1UTv/wUldGb2ilbvafwS4B1TaYlUm+oQ1PJJ6qS5HmRz9x870iArWvmDODCiujvcg3j63cLXbFcBvNdkSHBdngsNwRbmW+MgU2irjsAxmbx8HC8gcv8ovM6kNnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/7QLCGYieJ151cSDLToBxyUkFxHDj16UG24rP6SiKY=;
 b=A0qyk2GwIkftZNz/W0uY9VK8eoCYqBK9z4kEUf2Ypx5hZ8lUYrYtzBGzjCaHsbD62t3i2JWnQEUvBgMoEi8ICVc8JovMaAzzT0/KKCHLbn1eLysmk2j27/1wIWrU59lj3p5FNboyCldUpIj7zJdFt96VZcMu7pUrCEtDKm2X5kQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3456.namprd12.prod.outlook.com (2603:10b6:208:ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.22; Thu, 4 Mar
 2021 07:35:47 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 07:35:47 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask
Date: Thu,  4 Mar 2021 15:34:45 +0800
Message-Id: <20210304073445.15143-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 07:35:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 585a866f-f9ac-41d4-a450-08d8dee02068
X-MS-TrafficTypeDiagnostic: MN2PR12MB3456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3456534E9E8827AF63496B69A2979@MN2PR12MB3456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZ1DlmVQ9L67leN2uEMT0tpBtI88xAaeTkX3ahRAeVyKwCPKt6A+PJpFXNKvVpF6GSdqbpCxctUqy3FC7YiW8rTSkeuuWhcBcDhDu/HCJrcc+kNsSroc7Zf5KOfhm28tg6z0sYNbYtvqGiuNiLKKGZrQOKgi0XWtOptPUcHBhTWJ2xM0gc5AU7keo52T1FLi1Id3BDBkuCBSyCchcEwi0k6vjTAn5wYtLruF31i5JXhOM0HYf7gUgf49vALV842Qn5nVTUYaXD+z0MF9gdsGLgJ0B2xE+wtSgdbsTFoibsUbL0CLErYDA/p9E8BkTf9wOKHefUQAW9a0cplUrfaIwGv/g0GaYxMJXtQOl0u/9w4t5psw+NU8GQvyOmkgbSCP7kBYOwr6RaP02xoonD2oY9I4+CG4zDYa5WeIGf48W6hkJUAnhDlVyJr4rOKYb5i2YZz1SiGoPnDPWHxvLJe3xXB1ue41gbDF3iQn38QChrkwrTOWjJNb5tOANDYsWXeNfytDIqk0yAavjekejTNCRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(1076003)(186003)(26005)(8936002)(4326008)(52116002)(6916009)(16526019)(86362001)(316002)(7696005)(66946007)(2906002)(6486002)(36756003)(2616005)(66556008)(8676002)(66476007)(956004)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fYJdWDkvf183gnKB2gpy0dBMGjJS7YiTbfBGqo9G6uLPZGSlt75EvKINKmgg?=
 =?us-ascii?Q?ZRU8rJlXaMx+KvefydT4rLHikl4Y1IExxsKNI1XX2G4PahSEcFbaUztvY/Az?=
 =?us-ascii?Q?SyIaJwraIvF3dD4u4u9rb+utr2cjcZg5JJ/XgU8k9DraNLHv4qeBOyg0lxHw?=
 =?us-ascii?Q?UzO+up2cOgT7rq6rzUsKG/9TgSjbo4QQr+4Vm4B7nsiTTIpqIUHgSbkqbJSp?=
 =?us-ascii?Q?/nY+80QMx2+VL/ZAos976WATLdRA17e1D1Fj/qJbKfAN135RBfffhQnSdpHJ?=
 =?us-ascii?Q?ncaTcQn5z98MC+4otVYdDTPCIBtj4nZXPexN9UrqsmQQfIlmREi07Vrlh5Dz?=
 =?us-ascii?Q?K6Sq1CQPujYIEnBkzFuT66MSHbmD9RUt5IfNZpQQHSEEtpkI+ckgo1fiyysD?=
 =?us-ascii?Q?Cv+MosLtjUoZHW7d+hmGinuT/qJQBdF+QOyHcs3c0Mdj7yaz/rw/WKv5vF5A?=
 =?us-ascii?Q?1AsuhRpdvBhA/D6I4V885ovmq29wpks+UyRJ2R5AdZR44WRXqlnXDwx1NVG+?=
 =?us-ascii?Q?5y1cepu+qeAkvt/w38IFphBfHEjk/N7wk8jBUdOc0Aeetjy9VOmyWIAFUR3Y?=
 =?us-ascii?Q?HnFzUKW7hogzkPGxOMi+DVH5mtrBrfQpvUaQn9YXuZc926wTUJJye2j1uvGM?=
 =?us-ascii?Q?df82CDeYCXu6UukAzdhwG2RSPy51w/At40K57gBGGCHqFg+GZBevohUdGzFj?=
 =?us-ascii?Q?JOAuJounjBWfS2LqhafsiGLYD81aB/fHI6wFPf3K0Zy9PAXVRwvvXOVUUZOm?=
 =?us-ascii?Q?e33X4QF4rLFy45zQWX9BVKqhM1UBfai7H8ay56Xz3McwgjZkmh+N/f5ppio/?=
 =?us-ascii?Q?xfH3lNsbZZMm/6BEScmc+qAtiXFoPX7g31ZfVs9s/iHLY1spZi65pEgghwTJ?=
 =?us-ascii?Q?S11P74R0teVCoGYlYL1fp69m9c3lyoIJHG4rf7jY0hfC2H00nCQamR/pekdj?=
 =?us-ascii?Q?cHCXVeMFRRMC+EUsGlV9S0x1Vp4eWixsl4EzvjC5RJxg9SwSVJ4gyERd3RkD?=
 =?us-ascii?Q?RIg+GSANt5NdQdxAc+wf27hqTBCIYUQYE17x8N9R04SqOWibxVVOl9amyHUc?=
 =?us-ascii?Q?OQqpFrnEQAr7ZMCHeOyMTkxaftTI4JZVgrawtKzXO3FfYDnUop05u/XHni24?=
 =?us-ascii?Q?z9KmGb87dfQNm3JS6JIIyNPcZQnDd5k06w3p35vIH76zD/LaMA/GgcqzQjb2?=
 =?us-ascii?Q?wk6r3JyKGrolV0y0a9cZnhlbuE3jK0oC83TYLQV5ZTBg+VYscd5azXKIC5Bj?=
 =?us-ascii?Q?D9nH8GNKMt8QT1mdNvl8pwYlletBjrb7OB4ww0yL3KXEaUuiNDyBBr4XtEWQ?=
 =?us-ascii?Q?u5su7+q9sjwHmkx5YN9soFp+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585a866f-f9ac-41d4-a450-08d8dee02068
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:35:47.2693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe/IHQxIAWQnJjt8MOA2jGfMD1DQmvft8784sUICnTckg4F1tst826peEWYu0vlG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3456
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
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

replace SMU feature XGMI with XGMI_DPM.
it will cause show to be incorrect in pp_features node.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index aa4822202587..f9f45b6764fa 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -282,7 +282,6 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DS_FCLK),                       	\
        __SMU_DUMMY_MAP(DS_MP1CLK),                     	\
        __SMU_DUMMY_MAP(DS_MP0CLK),                     	\
-       __SMU_DUMMY_MAP(XGMI),                          	\
        __SMU_DUMMY_MAP(DPM_GFX_PACE),                  	\
        __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             	\
        __SMU_DUMMY_MAP(MEM_MVDD_SCALING),              	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f76d1b8aeecc..8189457a3ae6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -162,7 +162,7 @@ static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_FCLK),
 	FEA_MAP(DPM_MP0CLK),
-	ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT, FEATURE_DPM_XGMI_BIT),
+	FEA_MAP(DPM_XGMI),
 	FEA_MAP(DS_GFXCLK),
 	FEA_MAP(DS_SOCCLK),
 	FEA_MAP(DS_LCLK),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
