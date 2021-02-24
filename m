Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5354C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8101164EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8101164EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC826EB65;
	Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628466EB65
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7gGkDHS9S76fifviIRO7sJ9lkmaMygkyQ53niPz7WDl2CiuZUkzzS1UeiZs8DQi42w+0fqmh4+QXWEZ1cvE0UjrePrUagNefgoMEvp0/3yc32XOWsUd+T15OFYLV8CrPbDtFLezjvt9Dw85d6kgPkPIUBgBHnK2jvBYZ6Fs9O9/MEKbWt1xp1hbtf5lF3zZ7N1X6GoUSjjK/PsPZ4KX3U9PhW8YcJjKbX0hL9j7lKRYMUh9EsXgr3NQCKL4U+22X8fMmTYCxi8RXWNbnB2xKbKkaQ3ejXk1Yozlb8xEzjNPjb3pN8PMwE3uWC0okVn7tvDw09lj/9rDeVMwLd266w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dBHs2gjqgDMeDW/EbSDJkrqSnEnjgwDOr3N5OsbAhM=;
 b=g7FiBMWZ4JSy4basNG3nWiDOWoZgmA4hN3cF9IDfwBwJE1ZvhzBerRUB8efYK//JzAYOoh9Lj0Wv3hUyOTu1ts3YqdwZgCT4D9CoEFLNMOfB2Uzy+o7yyDIn9QKhnEPgA44sM+ndj94uaEFhL8299pSV73X3LoL3YSikNwhJ8mARWEzgE2Fi422t+fW17q/fVHORAgdSF7RCDCrg3lAGt/pDg9FWFc40OpFGAEKGFe+C18691M3negI1ZH2Fm1yscVM9kcgbmxlyJ67kn+aJ5ybVwUoPG5+EpYZ/tIF7n17QUVuVX72megimpcQYyedwy8TYRW0BpBhmZAgNazl/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dBHs2gjqgDMeDW/EbSDJkrqSnEnjgwDOr3N5OsbAhM=;
 b=yNrcda5nAVX6m7yy5bEMum83fLqjsVWnYVmrQ/03DKCK0o217sRLHSy5f0REs+vrP8GYgmvRjD7bDH9fi6ScFP8N/pXujjS+u5IhrbUXbbMlGV6+uY6nLnW7ME+uDjR+vfMghUI2L/bJNJIuEe6bPI8diwGcz12kv3PhBowXFnk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 100/159] drm/amdgpu: bypass hdp read cache invalidation for
 aldebaran (v2)
Date: Wed, 24 Feb 2021 17:18:00 -0500
Message-Id: <20210224221859.3068810-93-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c3c4968-9608-43a4-37c6-08d8d9126651
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4798B8233E1E11FD28C8A6ACF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKwkrK7QAf8xIf8ZJa2hj4gju8Rqq49y1kt0R+PDU3/PlUcbBBQWdyKAlbBAcuy+TW52tzselLi1eJ+uOiSVq02q337v5Ze8i46hZO5M1p7TfACp1C3S0c21u1+yQljeYu1uvGAZFu0nJbP27Kcq/7Z8DJcVjkIjKwHMRwKzhobgQQ+M63pWqMT3/0GkRTjWFR9wQZvYqPQ3Xepa1Ap5qT8EVQx3nvttE+VVw1PEsDScG1KOA/Dhz9QpWJTQm8h1jsyxOAyBkiW5GJpSGLpW0RCZckswSNT6lCIxYKEVwASNZZLbM4PY+dcFFEzeE8FjZrbkyLDJfXfxO3MGNmSMbQYNhcsSfA26QXF5Nhc4VvjNXcX0tSrM72LE+iw+y+JuGEGDWZsD0KTZ52aVX6OzqOgBjeELtSp9TkM0xv7gMzNN1VmSHawAImZeDbPjP5OUZJeEpQ+XbyJ5+0MrcItKtx8nMluscn8iUzvQfjIWKCPmbvXS6LK+oHxHAxzQdThCTO0iQSRtqDgmKCEQ7x7o7vWRyRPjRa14m5KPcbUqJemHMZnu5Ws2Qdtknz/TG5wHRwTqScP9FVrFi/ku9JOa0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(83380400001)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jz53JUj6GKKe1Np4UUNKUYlFGNqRxuCpyywvhUF0+w6f4cWjagJ+RcRvfh9y?=
 =?us-ascii?Q?MJ8PuBXn84yBubaxvZA/FChWYhls6Rp4oxq/rDhTElsT2IXaBBXrPhunJMV7?=
 =?us-ascii?Q?q2nJ2Nq/DeqUQuCa1mPMw37+EcRkwCUOBmDV+1Tqx6dDthBl9HuTGKDhtcPl?=
 =?us-ascii?Q?Da3iHQvZIfjj7krqJy/QEqbcOP89GD1tnGqlTaXbgsF/qnuZV89mYqAPlUNt?=
 =?us-ascii?Q?OtHC8IK9Uogr8UQ1aEM0o8z6sSOBw5XUvSHZ4bTemjovsBFUXpbGmUTG0oj6?=
 =?us-ascii?Q?r9WvbDUcu3XSmkHqgZEY+mOMr4B0iowWMGp//H6eKlfajZBoEjVSG3jOCWsQ?=
 =?us-ascii?Q?Bb4nKDk97zLts+oaCrEdkUoWq3N+K+Fehy6CbBjaN2o9l4ypPSr/AQtYHCw7?=
 =?us-ascii?Q?rUZw0gnUCTSL1J6JiWnK/PEZ3il814WIdU0p8rjkHeo6JjWeMQfqBzQ5WyYG?=
 =?us-ascii?Q?mVkJhfiAwl0QbmJzPf+ickXZfFbX1IrqwFwVcrxTRKzjXQlpGAUnjKyK1RMd?=
 =?us-ascii?Q?Waf/Qr0isSaVTniqroWX7FnKXxMKa92R1CYqfDQQXwTMktf2ek4iBiS0mO6C?=
 =?us-ascii?Q?IYfM2slngsWSmu5VZe/Mp1ttkYlF01vHbJTmisMcgMR7AQHUcE49BhmjVFpI?=
 =?us-ascii?Q?htEVElQooDV9Z60sOe0gvvahgrVsJKJj5MGsKdTAuRBTHjMsStPQj+f8ig+z?=
 =?us-ascii?Q?7FDsBLBOp+mbxOcQgv9FyvuetY2y9vNrySNeMTFdQP7Yb0ZyyXhbFu7yCwDY?=
 =?us-ascii?Q?UKOWYN1cwBzgtc5wdYIJjHbNnqBs2OS1c/akMYNBJaB3R3lLIQiUir11s2N1?=
 =?us-ascii?Q?RgOB+wzktSecV9XEruZ07ysJ+rKDF8SJNwYqIBPs1ItgkxvLwDgfWrIH7izv?=
 =?us-ascii?Q?5PwJrQKJc+spCqPfyQsMJpqPxGtcetZyDz37rjIDhQDciNNAtQwq3iFcif5W?=
 =?us-ascii?Q?ayQLUQVbtmUsXnQPhVnzo5d1lw4BkbzLt2V9buDJqHZHvwc9C76dR3tUp+DJ?=
 =?us-ascii?Q?8mxGSJfR6FUwgQKm/FS5bIFqzTv3es0fRsbfqLV7bjzSqbd/AsIz6hKoiK5s?=
 =?us-ascii?Q?523IbNbDe/oWrI+LcTmIdrLsH/GqSc8ZfDQXEXnV28IN3/J3HooJPMAQiZHE?=
 =?us-ascii?Q?rZO+1xtDUSFbIB4u7Nb3bh7DCjFpXG8iZOTwAuTXk8utrLnkRI3JPtg2FqoL?=
 =?us-ascii?Q?76g4C5exaRXLwa1XojroVu9HiLfp3YIB1xTqNem8xCR6AXzlp44M68CNRjH+?=
 =?us-ascii?Q?P11boJV1lkdr31ABe3dBkrJGHYlKVT3UhI2AaD4krKSQXOgHAnbV65/a2IUX?=
 =?us-ascii?Q?pZfrOmVRENYKRtDu8wHrGzWt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3c4968-9608-43a4-37c6-08d8d9126651
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:32.4034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJ30ZQKnQrxblJd0E4qLd/7c8pE3LXROhNsgxzETNTxMLEAHOMBdkwCiyiHQNJTxtCqCmVEo0b0DT8ptkBaD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

hdp read cache is removed in aldebaran. don't issue
an mmio write or write data packet to hardware.

v2: rebase

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index e46621fed5b9..edbd35d293eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -49,6 +49,9 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		return;
+
 	if (!ring || !ring->funcs->emit_wreg)
 		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
 	else
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
