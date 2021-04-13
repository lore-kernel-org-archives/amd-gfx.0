Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46DC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037CE61139
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037CE61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFC26E1A5;
	Tue, 13 Apr 2021 20:42:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9E36E1A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hb56uFe+QQwPNoRlMrmWZT8+G132vi73TaD+MgdmbUJJnBwfmajlEplIt9Ra/E+Srj/H5MP2Kc3EgN20YJnol0KdOMg51SiYy+3oXM9nMnSU8/cFMIUGBN9RvIdSLtPbwsWzr29IVTs5UcUylHA8uDf1mugV/iKWqwtwPaSyA0AGUWrdJmRy/aBHQRfNQ5NQDw3EJGZUVmwg8J43ZRiyUSCDG/alYM3wg4bm/j8GHL3phlfIq2L+b9y7BgZPRSxkdvKgud7iwj3okrK+qf3TDvifC1sHeq7dNb3JKF+ZgXSGbZptD/UHD9YjBENCJILVv7R76m9V0PAmvLgzy6lmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc3tc07PMajP6fT4Y6yklx2mtRyFKTdv+wlmcs/92Go=;
 b=hxMR7oa+BBnLzZfodS7F+a0AXMTPfXyQqxdTG7byrRiZXRQ7Ut624DpfQVGuBWy/b5LCPqLsCRSbvAGWfrWY4xdO4q9xyoXGeRsDLlXg7sB77obSdJ+6uUcz9e4brTwNetHB6TKf6RHun8veuN1V3EYrJplsJLrsLcSfraY999ji8FBw2ez/P7QAHCfpDb3iuqZxmsIlkxJF5hnOMQgJDlVukklUYyeVQ3cICzbO/MFIRTrj2Rgh8oLXYVHHyBIHSorbS++QY6Hc1VMGBCVTeefJSXeMtpb4AqydI3lqsY9zd1w5QXYGfDswA+AyZBWr10NvaH7/nDQeViyIMhAbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc3tc07PMajP6fT4Y6yklx2mtRyFKTdv+wlmcs/92Go=;
 b=ONeKpqVB1vBVYK58onlhAsZ7wPYKxhz+6qxUdYcVFyyyJxMVEvUGk9T7DeIY6AEZ3LXefRKZCPOtFdWBhTGAehHKodl/q8yahdTcdUYd/UO6HZLLsB74PHtVjLg20y8/xyhegrHfLzbMbqrQkRHaAmvemE16GPz8I30ikjR2O+0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0232.namprd12.prod.outlook.com (2603:10b6:910:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 20:42:29 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:42:29 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH] drm/amdgpu: use pre-calculated bo size
Date: Tue, 13 Apr 2021 22:42:13 +0200
Message-Id: <20210413204213.6405-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [217.86.119.233]
X-ClientProxiedBy: AM3PR05CA0125.eurprd05.prod.outlook.com
 (2603:10a6:207:2::27) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.233) by
 AM3PR05CA0125.eurprd05.prod.outlook.com (2603:10a6:207:2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 20:42:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2790cafb-f3d2-4e13-442a-08d8febca754
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0232C53BF196EAE9A5B144CE8B4F9@CY4PR1201MB0232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9AkN7OuKauiHZ9a177Bw+rAhoZ7Ti0Gabn1Pkf5rqx+v48uzTD5Nhb8mB9ShenoZtsf5VfihZ5kwMRAlyOH7K7qzv+cYxE9VV08OtPgmcnLQ+ya0Bg9PnRxPYZaFZpA9s8wKxE+3aP5s+kkknD6IDigD/QBxMU3zUL2xCtzdMXvQEc9wknt5GHSD9gDba8nwh9eeVPQTQqYsx8Mz/XPhrh8Til8qz7grLP0W82VcHbupIRXuDm57PRXLNEMLVGBA8BWMSySGQf3DG4SBnfT6jr0LlQqu+9awC0xpkxO5+JefUtvQVhM7UhGvbZpI55by+Kp1dO6objgBXkz5/xP/Kjod+KtfEI+KLJtkhMll9ZMg4/+/3W77R22Tx8B11Q87xh2OZbJUvUYz/UzncjtlKVtPH7H9Rk9fBXJVFXlI8KA64PwfVG5Fwiyp9aV2hRvxWHpVetuM396CMGc36sB61EK5fFFIGFBg4IJVjnYuI2QVECG5MEFEDOOV4cAhbCyrgBSkITMpEQluk31I4xlCksFkngySLfD7apHpMcPCZOEiVhvT0Fz5YYplB+CzPHKFYfXTvtEV0AL0IiI8tgpoL/5vDidRiFeD4TNNzKfEtWcVQHkXUVSgcrOr/2o1/W9nK7esviRbIUWKLpYgXs7Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(316002)(2906002)(186003)(66946007)(6486002)(52116002)(66556008)(36756003)(956004)(86362001)(44832011)(6512007)(16526019)(66476007)(6666004)(4744005)(8936002)(5660300002)(38100700002)(6636002)(38350700002)(37006003)(6506007)(4326008)(83380400001)(2616005)(8676002)(1076003)(26005)(34206002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q7l6gtDmeaxIxpVn8xKSzB0ripj9Do8IgRm09aWGcQA8VFw8T6jVllsDZCWC?=
 =?us-ascii?Q?yNjg+wIZKVvc+mVkazVsvELLH1EndUqN4DJWEan551qmpuQrLkYpjO2XNLFK?=
 =?us-ascii?Q?HJk2eh01RWrJkSgHfHya/CqiVg0e/nyFxXQQDruPsx9MLvwoMThwsaybliJZ?=
 =?us-ascii?Q?mUFa9wQRChXdxzpSWSnMl8RBRA/AhW1iaXKUL8KeLgOjriwcG4tV6gqq4ytG?=
 =?us-ascii?Q?c8WZulVSitj++4OanUOPMGobm6/pAPJwvuyMebIBE0QQUqNQ072bweUJihaH?=
 =?us-ascii?Q?4hJhJNeA4hTDEpO9Cz41BVoIGhSitQ1nNz6pLi0mnAjy3PZqVkYb7UEspt7i?=
 =?us-ascii?Q?+BtcDhE9mrabTjukVSCguKVBeetpXMQ+mBiY35y3OU2ecnF6+ApAewtXtKZj?=
 =?us-ascii?Q?4l/RmCXnltMK7defHhER7xMpNleBtl9Q+rLIyQey8LKrpgOOyF99kocEWwKD?=
 =?us-ascii?Q?6a5qzS2rUxiKCIMIDNuKdTsVD+z//FH/57FQx//IrSesmJpiC4CGorQ6ovVe?=
 =?us-ascii?Q?3SSKvFSA8ywU4/KjrU1jDCueXrhthlE/8f7JHicJPg32xgX/7tlnhqdN1Om3?=
 =?us-ascii?Q?Ys8pidra7V6z3s0vHEMSmyU4nP/YAK08wfjTIGZt0Kj4G5Hes2MSfkcbjpVw?=
 =?us-ascii?Q?8O6aCa+/4A8gAtuEczKbOnZun2YmZCgad2CWYGJGjZKgo0O1Bm7ynGgb/nWD?=
 =?us-ascii?Q?9nbi8fJmEFbb0p1peQKF6p/PDruwPXgdcg9GuswyGUbYoNuM4EdotM33aYXh?=
 =?us-ascii?Q?j64+t1G9koO7rDe6lI1/TsQl3g2FYYep6+ZT+uJt8ptfCgCcqPEhx+QNSqNA?=
 =?us-ascii?Q?+5t0rg5GxFDgOKCQNuy0aiaAzI1Fnq9HLkrVOhKAIEafhBy2+nTYw2m2H9I9?=
 =?us-ascii?Q?rFE+MMiCpCHcWkuk3323aOKryzbqgSnc2F8hB4GbT4cZtJMw8XukhYgkNpBb?=
 =?us-ascii?Q?m7wX1Yf8uqKMC5a2Hxg5GveTfmBox0waoCARNhk/VGUAdK26O4VwdlRDVD5y?=
 =?us-ascii?Q?nRuwVSa9HuTzqYZvDdapry4wkapOFiiYrVgzZva48MTcGk/vuO+ElB6zJ0O7?=
 =?us-ascii?Q?QDkSiN6EKEZbBifns0GMs8zSj4+a8nGRdxgD73etaPSLCfow/EjkN8D6jc0q?=
 =?us-ascii?Q?3Ghbf+CKTYuOzAzqUpLAHghsjCumb1LEIpIjSd+Dr1ymql/B45nWJtABSptm?=
 =?us-ascii?Q?uNUIgzL/E5pgiZXEOwnnxXNsqDqMVJWF3kg7wk12V1MMldrn8meSXlFFUk3m?=
 =?us-ascii?Q?mA2YR66mqPZHZXSLLPkSMOR1N0T9sPnXzXc1BaZQN2fTepMqpVklgZm4y//C?=
 =?us-ascii?Q?OD4gW58qNzGHSwoObD6nUKaX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2790cafb-f3d2-4e13-442a-08d8febca754
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:42:29.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztVuHkIDeolkNWLFVqKVS1r2uVsMYPl0AAKO/6SKwl517ZU+GEAPTav+ROKGLAxBmwri0USW0Is6ViAytNHrJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0232
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use bo->tbo.base.size instead of bo->tbo.mem.num_pages << PAGE_SHIFT.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 936b3cfdde55..26deace78539 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2048,7 +2048,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			return r;
 	}
 
-	num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
+	num_bytes = bo->tbo.base.size;
 	num_loops = 0;
 
 	amdgpu_res_first(&bo->tbo.mem, 0, num_bytes, &cursor);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
