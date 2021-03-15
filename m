Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6071B6146D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071B6146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9376E13C;
	Mon, 15 Mar 2021 19:39:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F296E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCZ7B6IKlvF8AC3WwrSbp4PXjX4hD+QbTDjP9RAa5q3CjXi6i5xG+yQMcA+8GH67ESZK5oo2ZfeTCwOWujIIwonnQix13IkzfooT3+xYsIezEg0LZaQJOgmKjmplk4NS6yGOcGqQ6qwW4++9vltFdtRFV9eR9yZFoeTBoVDUkq/b99F+vTSB8spOuECli/jgo9L/F/kQaRTzP9vfM+RzIjin3j80LVo+jIOdHeKPducquBwt7AqSebILZu6RWoa9OenOlmL3x+81T+Hfn9jimPnTd79vqLolUPJjstqCYkSqDgcpL3E+YltMM60nPBrHwjn9mF1oTfjBd+daGMJy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dBRiRPFPdKRvwCWJ698/IboJdOhlPihVGDvI1K/Lyg=;
 b=GTDJhz48y6UgegnSfj6ur/AQcCyFr+2M7JADvuH9RXHg4G9vR8hLtXZfFDRHBkkv0me51HMOVyGNLVCfsRw/11Q2IWSrfTuuIQeJTA8y4qTZsslcbH/hxMKyD+qM9ISJIAT5YiZ/cwfjqMnYm/gcjtfLwDn4KapzOvKivmZqd6tLotVeiE8anyiivJ11VbA3SGgH0lg9tInJofCGmyfDZMF73u+LoWApe8vIP1eKIPSw5FYYXHnQqdoJ7w/Dij1+jz9thSvc1xi3Cua8/O+3U7Gd8ZjbkwbGYVLpPuqGhN75AwVvRNAslDKgyV3znfPk7VuNRAxBX822gSkUDD3ibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dBRiRPFPdKRvwCWJ698/IboJdOhlPihVGDvI1K/Lyg=;
 b=nQOU+bRHDp3Ff4un/DReAbDJDmuMfSFgU1qTB+bHwH6CdJYBSpMXGgc2oyiglK30NdixdHqlyvGxTeJHSfIso6Xdcqvluy7VGCdtw5vL1qYdsD3T54z2Lc2proKEgv/mFKdklVb0zElfQjAVIZChUAgUpAyE4yL4ZZpYcFGHZts=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 19:38:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:38:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/ttm: fix ifdefs for non-x86
Date: Mon, 15 Mar 2021 15:38:41 -0400
Message-Id: <20210315193841.1539753-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR07CA0001.namprd07.prod.outlook.com (2603:10b6:208:1a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 19:38:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56a51ff8-806d-438f-d7c9-08d8e7e9fa28
X-MS-TrafficTypeDiagnostic: BL0PR12MB2371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23714D572B57D4A213F436B8F76C9@BL0PR12MB2371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O/1J9ueLcGexKIXAG/uU6Id0+a7YogrXUQIrOj7tIrv8BusAo6he8Rm9yWGZNtMYjdPFkrO7wgoQYIzxW6631On940KCadDfBdShKTy00ZvpjPFXGp33w4vo7+2f7koyUlClvtvKO6EqSxZ2jam94lYtALx70EzNNbbpC67mqdAsXhMy/+cR7fmPJdURfP+MVuMG84Cei8p0eE2kqOaL4k9+TcbhO8mqufBojY85mdLana5bLe6pBDYbmaGItH4dCiRz7LEyU2tOBpnJKKROLSs74HIs4Ttv5o7gw51F6qE/1tDwOKkJLFG0fK6xcAjs61KVYAjD21gPZwJejxHOtwlEJY3SWOdlkM7Ja9IJxsNqcirAvraCYZuILL+e65iRR92ERyEaszxPYuP5dJNvi0zPbpu28LwmY/zIFwH1syO+/KFFPEM0HpA0yxAWpqzcUXEBFX2Ks1bn79lHcIRtlHDWFHX58jLlDlS5XbvVSiWaiUxmBww2jlsBVvIzCodOYQfRim1VmjE+wIS4mUp7ybcxEtQm1QN/5an77LSGo5rVfYcaHZI2nQUFtXLVFWj81rsj+DsbTMK7/LmBShvWAd1J5sP8dLA1+gX57T6EM5/6yf9jWbXyUP8cTGul+vQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(52116002)(6486002)(66476007)(316002)(2906002)(16526019)(66556008)(66946007)(6506007)(8936002)(69590400012)(86362001)(4744005)(478600001)(6916009)(4326008)(1076003)(6512007)(5660300002)(26005)(6666004)(2616005)(36756003)(8676002)(956004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ygoab4TVu2R/w1N4hQqmRffpjWq9IzO0ZJ5yZYbeV/8BdrAOj9oV4XQyQfYw?=
 =?us-ascii?Q?EG1ywfUhhFX4noSmU6aTN9B5lzl4gIPjJfvTiHdCAU53NZhIKn3zxKinPXMM?=
 =?us-ascii?Q?GjD9TV+go1mcSij9lLfJZKp27S0CXvmyYHGmu9EMxfCcRqAejVcU0cM0Fujx?=
 =?us-ascii?Q?PeiIFFTPyjlMwJNGnvIInHfX90et3nOwtN33IgGggtaSfi6Y3rfCdrXjcJAA?=
 =?us-ascii?Q?Yc8kphNZFzFUNaus9YSI9urNY+XdwBTdlAw5n4/SEKpXdMFSm9KfRn7Drq+y?=
 =?us-ascii?Q?mRoUbBWD9eL+7Q/hgvV+jpyg2pp/BtNpA6BU5yL3mDUYOjAtUvOPHoJhaRkG?=
 =?us-ascii?Q?F9snVXxNk3bkPyAnc1TEi0V1xbNL0XLvRIIOVESgUR9Dj5xdcjuNXd26G616?=
 =?us-ascii?Q?vYt9n9KA1ru+2dzAiVRVH79UkpMrYkQDVQVx0XzAjfoWTg21ao47RKnmmota?=
 =?us-ascii?Q?FZod1eH62qRyErsh3dT9Jj9OLx0N1KflKutGhjK6u3hoRj3ZGHX4XZmKX8hC?=
 =?us-ascii?Q?WbIKUYAI9OJs/svGe/ZwaQVY62IeD6PoQ6v7VVDtwlx9iqqEu9rBd3v8pTnV?=
 =?us-ascii?Q?NZ0OwwBYtu7Pygs83rIKudxPNyhpnFYqsxxnaVK4WpgRkwKL19uLQ4CheKVE?=
 =?us-ascii?Q?8VhG+ajiBQFTZehZZsYUmyKQv352eXgOATLAAQaO09WsqbpwwwOghoAnwDXq?=
 =?us-ascii?Q?iX42r76i1ayH9wqKXA5qJ4Hdh0KVnZKjcWYm9JMTFSuBVj/0uNqXKPT97sdC?=
 =?us-ascii?Q?TEjKf319BLZYbzpHTY6yKohT5erzhuJUdKHztk16YEg9IRt5zWobpNBI09hT?=
 =?us-ascii?Q?RTuG7Ndk6t5zQZP5rifBshn8fz47SJ1LpqlM94MPOiMEMw/mM0Lj5HsjA3VA?=
 =?us-ascii?Q?1bCraZUauzrBFO/JYwM/l8Mu91Yr4Oapak5tMtr0dFVguM0Us8pjSHq2q1OJ?=
 =?us-ascii?Q?SmfBITrg88+ZyWJJLkdiZyyMxQj9zqP9pgsktqz8lYLhiXBZ+CVeL4OFUeu3?=
 =?us-ascii?Q?+uxG0488hizVxg+z/zYjV4OndYYWOMnV3yJzHWhb5qoxnQx1/CKiMDJl05PA?=
 =?us-ascii?Q?86btis3ae7lwewuNMoUAY+55Zpl/gKKhmu7Nypvu7/vxGF0U5kqEdg+lJPlf?=
 =?us-ascii?Q?VOd+Co+Kw0Xg0/eNHSn+fNKZRihd6ewcLnbwbWP6zho4+r8u1J3AhMfYt3lg?=
 =?us-ascii?Q?4PVgvubYqFTjW/1BR1KEszKqv8Lg5ErEPqJHF40HfvF4Xdx3tUhDXfWuuFjW?=
 =?us-ascii?Q?OBVC8+NafszUgKyUuIpODMuvqUqliXvy4MYHuLttyffivw/04SGZTluLO/z4?=
 =?us-ascii?Q?NlCos9D7rzMzBtNjdX4QFyFq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a51ff8-806d-438f-d7c9-08d8e7e9fa28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:38:58.5303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkyU5mpV6f6f+quGmRHyWcH2gab267oa4BMM0zqs1ZI5l5S0AgMx/qjQNGTQ+BM0guZvJh9OMG+fZqqeUhRPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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

The else clause needs to be CONFIG_64BIT not CONFIG_X86.

Fixes: e98f250bddb5 ("drm/amdgpu: fix compile error on architecture s390")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 158c987696ff..6d5cf0525325 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1731,12 +1731,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
+#ifdef CONFIG_64BIT
 #ifdef CONFIG_X86
 	if (adev->gmc.xgmi.connected_to_cpu)
 		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 
 	else
+#endif
 		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 #endif
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
