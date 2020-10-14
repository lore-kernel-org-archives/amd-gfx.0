Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47873C433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1FB22076D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hoi5ljvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FB22076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8566EAA4;
	Wed, 14 Oct 2020 13:53:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02F76EA9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:53:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYPPDV/DL2Oqmkm/bl9JSTgsdctWFd8r/P2LRohYoZ5/w54AYkvbW18bDKukSUMmhtepn1FE1pjI85VPCqKQghyg/YYs9BBaSWRhnG7FMqr88aqOJ/7ZAwmm8uJUfWmVhvYBtgWCbmxRtmteo8uUfts3pQiJN/R33y8swqEAJAX981h40BDT8U2Uv1aHRRYuyQiFhcnExQydfUPnalewYwqOpB9d/Z7fAcp2HBsb0N5XXJUMkAkPgXPe8yVfaKx7yGXj9NhwcF7iUYrHVaZ+Ge6ygA3QhjQNxcw79thXKQbLpV4hK+jCfM7UgzF850BndcWFGYpJn/eqaPeq73zYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2OxonlUK3f6TzkNpuwbZKrV5om5eZ0BHs3YkwUgvq0=;
 b=Qw+x+nbHmgYDcrhaCEJRXYxokP/6iV+ozGtWjpBPn9/0/vBbxiKsDEeBIof56rTtOL70h2iidIPzRdc9F/vDhT5RCondaoTiNP3ee1+5ziXOoOgDSBt6NrsHE4LOaFhWmoFNEmggNs6aeRzrN/K+Jl8LUy5CHfv3ldlK2AbReMXU1NlJyOPeCStJXHQEbEGYk4AewilSdwgL/a/SNBlSXAjNVN/1izGknXIcoUqOBYxXyKZNQ+WJUDX0lTggPV5E4J/LFjb4mRu1nYBn6RpYJyJNsRJiVFdE6ya96hBDxlLm2fls3BhJv4zfPJjiQVkOs/R4cL0D6ywxL54691qNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2OxonlUK3f6TzkNpuwbZKrV5om5eZ0BHs3YkwUgvq0=;
 b=hoi5ljvoysej6EjmxxtUBLRXsVZoxvvj0wqTbOG43oqUmIOvtX50XIgtyJ8UMoEqqqMYBwRlXw6IWMcyRv3RJW9kjVASm1nLZ2e4hIkjAu5ASoo6Nm8BY+BAIPK5yeCmHHi1UHFzrZOpzllZsu82hCkinRd81mqerTe2yX4A+eA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 13:53:05 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 13:53:05 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm:amdgpu: check before setting hw priority
Date: Wed, 14 Oct 2020 15:52:41 +0200
Message-Id: <20201014135242.24619-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [217.86.103.243]
X-ClientProxiedBy: AM0PR05CA0083.eurprd05.prod.outlook.com
 (2603:10a6:208:136::23) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.103.243) by
 AM0PR05CA0083.eurprd05.prod.outlook.com (2603:10a6:208:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Wed, 14 Oct 2020 13:53:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e852b544-d44f-433f-f481-08d870487944
X-MS-TrafficTypeDiagnostic: DM6PR12MB3163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB316355EEF1CBAC75F234D8B78B050@DM6PR12MB3163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: empXW2c3LBMWXoRWi9DZYOChnKJOg+qhh/BKbH+YFB3BiK0Z6eKBbcQekiukgKyJYd9wjj+CJo9hEjrUcENZJOergbk7KT4w0gBuGawGu1zPEO9WoukZfOnJFc/p/I4XPw/wsrI9UEN9JAHZPoPqUdxpu+mn/MjX9esv9wKo4p6hVrIk5bMiSZLDLYTBSPiHcoizZuoiyl5ZYgzb0kBGXNzmiFJcSt4ZPLOzCGiWQPLsbc9sHxzshQzHSzNClET05tiLa5Q7JAoPQr4g0HsFFloaMbxwk8PXzNqWAe3iFg/j1qkm/8QpMhar5Ggb943V5jgkKKjKoOVnbIg8QUclSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(52116002)(6506007)(186003)(16526019)(6512007)(2616005)(2906002)(316002)(8936002)(6486002)(26005)(8676002)(1076003)(478600001)(6916009)(956004)(4326008)(66946007)(83380400001)(6666004)(44832011)(66556008)(86362001)(36756003)(5660300002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SY+dj6X0URkan8XkE5eL/k+diuq39z1ULDX5gRXvq7l2fukSTe2ommTxqtwXoFyncKqDEDzjmsrEuVnopxx/Rg5OylPeT0BG/JvQPqtqHnuswpJHW8TNP5slCdLFWAWzeVld8e6xsD+DEtZBdjdHwM9C95cFhGHslqoMhNC+RIGdGFlv+errKbxRJSMMfx0zq7BsXnd27MarNX3eafQJPJKSraCXteTynT4RQ8TDLJc4cme5ApWxOCiJis2AMXejfR1WWJQXPs3S/UU7DYJGoTgxncFrC1BfxgCHVVCvPFMSXtaM9orhqnbEB2vhPPN0a4YwFTLmtKgzFjtq42fC1Me+uMouscAY0JpIHoKM8TBRz+vAIcUVU5X3zggiXm85IvqDcdpSeQ2ZOsMAghojkEB4Bf8Huusng6Q5lIMer8O7PfQI/SwAdvPNMU96Swk5aY/H4sKqxL7SluLd2Mjo3EaQMmrSVN09tRLXBZ2QPPetrVXtI1FcNfG1aYxa2A0icofMWgJjBZB6RDVo7zkVJH8vRLTWwkvcF8ukDVrdl/MVd4qMJwbFQUDMPyY5fSDvlgZTr3c2p61KcUnyjjZlMt1IMpyrDsSXM8OVfAwGoYl5mTY/yL8qalVFrOf6eNXkCPZo8Lo6aup/yxCBYf9D5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e852b544-d44f-433f-f481-08d870487944
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 13:53:05.2180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8bLy5O618p8deJql8MJTjpcpFA4/64XF+7+WD8Csit5w6iwdF2cCPM2GB1Ej1fxPmlAOEokUPfd6u8MkYvO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3163
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com, Guchun.Chen@amd.com, Aaron.Liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check validity of drm_gpu_scheduler before setting hw priority.
Also fix a minor indentation issue.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index a03398c87344..c8da0978d4f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -504,9 +504,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 }
 
 static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
-					    struct amdgpu_ctx_entity *aentity,
-					    int hw_ip,
-					    enum drm_sched_priority priority)
+					   struct amdgpu_ctx_entity *aentity,
+					   int hw_ip,
+					   enum drm_sched_priority priority)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	unsigned int hw_prio;
@@ -523,6 +523,9 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
 		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+		if (!scheds || !num_scheds)
+			return;
+
 		drm_sched_entity_modify_sched(&aentity->entity, scheds,
 					      num_scheds);
 	}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
