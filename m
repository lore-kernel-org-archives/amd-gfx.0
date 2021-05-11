Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7119C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6886860C3D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6886860C3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6436EA69;
	Tue, 11 May 2021 15:44:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1862F6EA69
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 15:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LycJMhWw2O5Bxvbm7UBXGiTydl8OKjShXwB54fNMYbDuQkvB3JYj+F5tiBICc/bjZVsK8++R2vxCVlPBzdvbNg+VOmH1ynvW4T75zbPc6bf33ECcIC78xoSPWAKQFjoI3Z0wDCFYsKIvGMXQIsxkDh2A/t2mFXkIQOVhO3TKvqJfcXncvMK9UTrUinLA1xeQLgQKHzvIsG4rwY7T7ASpI+mteul2C6y1Yp0HIU9/4HeiVkaIiVc73+IhZm6W1H7DLQzXQam3FALRfI9mdyW802Kk5+59dPt3RQnYuOXH4DmQJIntFmUXWfCtwBNxd3hI5G1CDcuYCB+eKZ8K4lXKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d4t5LRaKJi0hQ1dhE+2O17oAg0nraDTN7/hRo/L6WI=;
 b=gxSziVr1QWqkgbdTmF7UQiX988jn8U+PfCgWm4C6tIHvzvofTyMyH+o8wkGBBoXq8kfWnMpvKAjXq5HxmEeasj/1a7KBpk6barudgM8n9pWUItYHxp8sTsuORLf6k89FOhy7gheMKZfVR7n5ss7fdqzGBSa/rvXH3TAgsCGdGRb3SmqRXnJjybp8b0L0agrUMYr3ynrpPkMHZj2Pgu5R9jtqZ/gTsak+wukisiD5p05SmqSKgvOYmcLmYr2HgzY9OqiWHza89A77p6xww3rhfF8H92DjOApfVmKS+mgjcCcUGwZIz2gEjjkIIha4hRPjq6l36tZl4O85s/GoEWiYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d4t5LRaKJi0hQ1dhE+2O17oAg0nraDTN7/hRo/L6WI=;
 b=dYH0a9VRZVgJiudbHYvUs28lhoCDM5S5FeGFaVNFTYoGn6e7hY6NStP/05cNaowcGm0RL0X+rG7hBU2G8JF43Mwxaqdjut2vz6hLpOrbGMI8h/oyzpFjacuFnrNevnYnACfK9JmuTqn/vVEEA0NaAdmtuaq2Y5kSQeW1taGkQOo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 15:44:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:44:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: restore the backlight on modeset (v2)
Date: Tue, 11 May 2021 11:44:11 -0400
Message-Id: <20210511154411.1281317-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511154411.1281317-1-alexander.deucher@amd.com>
References: <20210511154411.1281317-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL0PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:207:3d::40) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL0PR02CA0063.namprd02.prod.outlook.com (2603:10b6:207:3d::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:44:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec63b04f-f629-4e99-9fdb-08d91493a915
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4437C38B15F3E3CCE6F91CE1F7539@MN2PR12MB4437.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cZkh7dFs/3f9PD1aEhsFt/91ut1CIrk4zZMquxeRWVHPv6ZjQK/E8MU5PQKKDuOexoLXk3rJiR4O1eXj0v3D2wAKQiJhtf6cgW02PP/kRSjg8h1soOyJRcqQLhubmRdRyTnxAx33Xq4Rgi8B3PgkTAGa0jsZ99HUrR+38JefnCBTFE4xj+qgK08juqh0Rd4qEjzLJBAZWrDvL4RRGmNRqVQnJqluN81TK0p19Tr0niOboooW6FqqbFUhYEKIx/0n19GL2/T2JMpJKNE+H/oXwBEMmBcJIjoJXgNhyGyFUUxpwX6cEag5JEmzLWdVp8egwlBAxbPfLxJm0uRw16Z5zep7qojF2jraHEsAYIvlJJneGke8EA/f5EiAtfBNQiTzWFALh5EKWtac7wIkqNfndzkp1SN4jES5z81+GmqL2AJ9JsyITYnSPYXhja/QUIRr078Sj8HytHhx0zWgEOxCk9fIfg/4Wx/4VdTzejGJ4d5HXFnEzu4zpeaOjSymf/e47KwfB6WZGk9VKB4u0dCHm7TNbRdqWFMKDHwA7zr7KReZMBSIj81vX7zkQS/N8bETCXfbZ59tET6oCN8H0EvCgp+BpPLR4rEoaa0AOK1mC2+J8zX0WVQiHnhfzhHbgVQzr3u6VVT/Auy3qOn1mMaYPAubHG6z3Kiawvrzd5z1d/cNazsSQxcjPWL1NVDrQOz3FJ4/sk8e6qCzoVbozlCL2URRAlg/d+D7eBEGpRmaDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(966005)(956004)(6512007)(52116002)(66556008)(6666004)(66946007)(26005)(498600001)(2616005)(6506007)(2906002)(6486002)(86362001)(8936002)(1076003)(66476007)(16526019)(36756003)(38100700002)(38350700002)(83380400001)(8676002)(6916009)(5660300002)(4326008)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8YyQ53csX4kGdvmW1UagUPnJD45p557x+PdrYDso+qC8heLlI/+JqqLsEXYB?=
 =?us-ascii?Q?0fZLOqzOw6OMAsY7AYwUcKrA8EPici+MK9koEA3kQgGPJ1jDDTz0n890NKQG?=
 =?us-ascii?Q?uVsabv5OcDjjbzUmX2HIM4C+rIDRBUW/BLOuEwLy/CXHwJwBRav/4CiqxDBA?=
 =?us-ascii?Q?1iBeTYBB4Ix+LtesHPaQ0meNpOyc9i0uYy/rVMfujoJAuoCKxZ8n0kb4jgYl?=
 =?us-ascii?Q?fgeUcHmeu9WyS8TONHLsxpGskSYX/Arnpz++d7jNIIgGSyPiPNkP3z3tVcPA?=
 =?us-ascii?Q?WlRRtbwIWJhxm1DW0nf12HbR9giCvIId92bgOHhcJZA0WP0cm6Q8Ihy4mBIg?=
 =?us-ascii?Q?AWSA8Bj9EFiPL80ndwvVCjHB3vscO9CD28gOqj2Lwqdg4LHKkBcPUgi+xpej?=
 =?us-ascii?Q?Ky6RboZ9Sjo1V67YhjnedUtyk8MDDyJ0O1mRQOVUobbSxRhhcpDmitnxwKa6?=
 =?us-ascii?Q?+36p4b62wOOYS7iIlEk7TJ4R6tUR4s09f+phtaJ9N48xoJRLAGyyFS/79vQ6?=
 =?us-ascii?Q?o0tQkGRptucjSOEQpiqc9NRkWtVmbFX5JWXhB6OPGaQZg61pijjYAWKcWJOw?=
 =?us-ascii?Q?p/WyQhbnWupNztJ71WG48GfhB+zfm/6bi6ZZ3Y++ua9p2RakAbVLZ0FdoGiY?=
 =?us-ascii?Q?UQIcqv71Z0eXhH/uDwtRwRhPjPIOz8de0aN8Q28grkAjRxhdTITNb/MbtA0O?=
 =?us-ascii?Q?K7myzO7I8uoKmze9RB4MMA47Ygp4CzR+lEKjU605ebTFr7oMCp8yCepG6qJO?=
 =?us-ascii?Q?4M1fNHSCiekS475vwrD9UE757k+EVYEJIgLgX4xhOGKw+RZn4XjuCyzhlwwt?=
 =?us-ascii?Q?3e42uYx04hyD7XTWaTm0uS+HSaiSrAUnuVHZ5ns9cm5nxSbg/c2IYF4DpKbp?=
 =?us-ascii?Q?F2jUTB8g2dGJCA4HMPhvvwfVAnJjQa2GXP2OK3h4gWvQT3mPA/8bQcGY3otm?=
 =?us-ascii?Q?ynwGkt+sg931SNLzgzmirTXg0yWXaKwo1bnHYa6fjjqypDFbJPDnatagcbCb?=
 =?us-ascii?Q?I7q2aes7AA0gzwK1HSON3+mJmBEwwq5b4Kz7QcSW7rrQL0XO1QAmwl7xrEjD?=
 =?us-ascii?Q?7B54FQu5Dihk5GOjfrB4UAb/d+SPBoLRd4d3BaI0tPywX6021qEZoThBhO5P?=
 =?us-ascii?Q?kXsMsE52X4BEtmF0J4jJ1RHi6Im85EE0+vfbhzUQW1xfRQZFwWSSMikx8mz6?=
 =?us-ascii?Q?vFf6Tm2ijYgnefELJk3CJC9LHEIus45TVHPLstdDtilO0WLFjYSdUc39brZa?=
 =?us-ascii?Q?uWTTN4opA/HOwJAwDyxyc5fOWeYo2uChhBakmx5J+5gO/Q0CcD6DcbR7f6HN?=
 =?us-ascii?Q?ImUqtCJJ/nS7afDUMRTJl58J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec63b04f-f629-4e99-9fdb-08d91493a915
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:44:28.1440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WdC7krKKKA4q2+Devoq9pTrKBnVR7Zz+xF6d6inRXTpf0af/sOht8QIQ4w+1E5EsbxUPL5ojJVJb+Y9uS44lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To stay consistent with the user's setting.

v2: rebase on multi-eDP support

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1337
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 167c8759fbc9..979e4dafa735 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9075,6 +9075,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
+#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||		\
+	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
+	/* restore the backlight level */
+	if (dm->backlight_dev)
+		amdgpu_dm_backlight_set_level(dm, dm->brightness[0]);
+#endif
 	/*
 	 * send vblank event on all events not handled in flip and
 	 * mark consumed event for drm_atomic_helper_commit_hw_done
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
