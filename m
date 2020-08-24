Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C4C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 12:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8551E20706
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 12:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1hvd7EmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551E20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41BF16E02C;
	Mon, 24 Aug 2020 12:39:28 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700058.outbound.protection.outlook.com [40.107.70.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B18F6E02C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 12:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTwvHfXT/NsoidO81IGS7kq9S0pXRqVNvmf/Ku908t6P+41BmaF6kGn8yJ8CqWA3gIBuLms72L4/b2rYQA/v8/SEfmWSrOc5hAfpR7RhCiwLLXTqmPZSbra+GRqcUy2mo0GswoB0ciAvRJfmzD4Yz5a2dWcWZNqenfMLaMMMdYOsZhQapjGZSvcOipmCmHrmF0pjkp2Kl5HSSDxWsG9h3Mk5Y4LwVRyitRqT4/klPyuiV/imqws5gz1YNOEYvK/FKG8dtxxEkE2n7QmVcYAzxbxLWwzOtQ9Tq/jU31nTaICQdhpYSmFn7AW1I4hhi0visX113iY+EyARdiE9KhdASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYjmmL1DY5uhcAvIefp/qN34BexIga9j1FFTpugoUkI=;
 b=SJeJkj8h2XVDczxDuijJyUxGebZbaMtheikbywp47Z8zd4zMC9aQX45S6JX+TvKkiwsAyoKdtbNXOwd/8YwIeu35eN5astiOgLMUaD/4lC21IlqvdB1BcKzWn14CnKLUkaIQLxRkxxj4YwJ3sEweFjdDO0ZorkHbnJYEguocxlYhDmXBTHCcv9oCAZ+v5+wpZZ+FJw4MSy/mcS2X7XkzeA5y6tlOryAaGHsf91sBrdkOOC7x7ICoVinuuA7CCXpSxH8FBzOZ4evprq25J4mZ0k+HdXSMRu/EiSfpQTpqvzu/hYEP/tDCh4FcSVmkfUr8H4y9+RIlfvdnHTm/w5YNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYjmmL1DY5uhcAvIefp/qN34BexIga9j1FFTpugoUkI=;
 b=1hvd7EmJhSOgKSpPi3JTH5TthCA/N7OSrjTgWkm/u5pIsoNJcvvVUIJPTxrVfpwiz56dD0cwrxhI67haNiOyXkHH9t9RwSinKmIP7WqTcDjrPOZ4HJSec9dGUGEsFgvAvQCdUbd2aSZS5w7iuGClh9xqbjb6VGLmuYatkRt/x8A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3423.namprd12.prod.outlook.com (2603:10b6:208:cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 12:39:23 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 12:39:23 +0000
From: Kevin <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amd/pm: fix is_dpm_running() run error on 32bit system
Date: Mon, 24 Aug 2020 20:41:00 +0800
Message-Id: <20200824124100.2151128-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR04CA0050.apcprd04.prod.outlook.com
 (2603:1096:202:14::18) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR04CA0050.apcprd04.prod.outlook.com (2603:1096:202:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 12:39:20 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc3c7c07-e988-4be1-fa2b-08d8482aba95
X-MS-TrafficTypeDiagnostic: MN2PR12MB3423:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34233BAA83F781598CC9FA95A2560@MN2PR12MB3423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90APccXS/3oMN0AAZY8/N4UJFrFM7d0AqSLKqkZP021WmkkGNpo03s4TtP3sBRw3iN9i88ToNKCzSWmDlxtCbrgxh83rqpj2goBsYHV0jK5zR8YlsxLbltwZbFdloKeiQM92UhQKPV9BygXurKbps06BoYp3DWThhF0eXZ3qiUUPq50yztO6cnBGZB/nwlgWq0vyzT+uUtHSXJfP7xX4wL0w3+sJ/Uz6h0lIA/wyc4SY+8k7ji7UqEnfGBLqITH/J91IdhWSl0y4pSkwg3z4yuA6MwchhOS5xiNucMg02lY5YGuymToIEXDYLr8BPcaU8XiPCXMZsP6nfMdAFah5HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(66946007)(6666004)(66476007)(5660300002)(86362001)(478600001)(52116002)(4326008)(2906002)(26005)(186003)(83380400001)(8676002)(54906003)(6916009)(66556008)(316002)(2616005)(6486002)(956004)(1076003)(36756003)(8936002)(16576012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RyIixuSZd0Dt7VciVWulGUJlFbKu5efxJSAUaVvpw2QePAY5C29LF9ZaJOX11x9G+D23fLmSZbv9xcCUiNwTnJfbcWPUHRWwwRz7SpPN/hORx4CSFpllY8IoRoAvG7a0YITHZMjiB5kBjX1H1IpuglKIkt4SLshn+pd0JWVs7bY862hKkd7pqboZzT9olAH2JWeYNUqYfSqYj90yZZxxWEUFUUGJyZVNNouyStulpV2e/26u6gg2nCam6VaStQPdXnErJIAxD70Yj1yRpOyH9Bc5U9wk/XT8FFvhMwGADiyvXP5Qv5mm3rOEVKR4/iSTDAhoi/zx0WtWdFfRUh+n8HeZppVXqEwga0a8tOL23r4FfodXTel9nVtRAMgzohfk5Biwd8wKLJXO5jm8jxhT1P55/PLDwG8dtN33N/vHo6kAMcmVThM/QVPCun+jVhhT1KdKY2BRdMppliLhkKqp5RYKCH8KOihR1tMQMJB4r+wP5X7kx8jWhHCHZU9vUBmY763VbUSDkTe/YP9b3gGJ+0hctLBlXzewiBfTd3kLKxsz8d1ayqN2YCHHdAKOg1f3j+r8LoszoKaz/i9WvfVyi7wvb61qmwi4DSHX1zGcj8MYwPqo4JxgrlLGwkzQsokZ/vHuOvmm/saDhVqOQTeTIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3c7c07-e988-4be1-fa2b-08d8482aba95
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 12:39:23.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAJwMAWvOmiwj4t5ezuI490aX8hKZxpGEXHU4M9db6HtmIYv5tFYMOq+53i5Uvgg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com,
 Kevin Wang <kevin1.wang@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kevin Wang <kevin1.wang@amd.com>

v1:
the C type "unsigned long" size is 32bit on 32bit system,
it will cause code logic error, so replace it with "uint64_t".

v2:
remove duplicate cast operation.

Signed-off-by: Kevin <kevin1.wang@amd.com>
Suggest-by: Jiansong Chen <Jiansong.Chen@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      | 10 +++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        | 10 +++++++---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++++---
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8347b1f2509f..59b245c6c4d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1844,10 +1844,14 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-			   ((uint64_t)feature_mask[1] << 32));
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 72f3d68691d8..cc67d5c60f3d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1345,10 +1345,14 @@ static bool navi10_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-			   ((uint64_t)feature_mask[1] << 32));
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 66d655958a78..b48ac591db8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1150,10 +1150,14 @@ static bool sienna_cichlid_is_dpm_running(struct smu_context *smu)
 {
 	int ret = 0;
 	uint32_t feature_mask[2];
-	unsigned long feature_enabled;
+	uint64_t feature_enabled;
+
 	ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
-	feature_enabled = (unsigned long)((uint64_t)feature_mask[0] |
-			   ((uint64_t)feature_mask[1] << 32));
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)feature_mask[1] << 32 | feature_mask[0];
+
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
