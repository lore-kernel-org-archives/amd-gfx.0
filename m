Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C32C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BBB61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BBB61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 552966EDBA;
	Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAF56EDBC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkFCX6tKkVdIyPtbeDv2YA+FeJu6zAi5DHDhc6dKX4Grn0BR0hbY6AfZcP+GpcddejezPOXBlAhtUfb2KxY9Q8qvpePK2pD6wyu4ITK2zHXTAaQFzViNXnbt1jwuq+YjzuV4i1rATyXCV45DJIse6XuNhOzTgnFCZrYLd6u9kLdVv6Wkr5IW1G16V6/kxzk0o1ysEGmwGVfQJhM/avj9atf11YpGTaKl3PHiniUSvrp0ft5UGS+dwaLmSZK+BpDcom62rpmxypFbSL73rMYwt+VsIJxu/Joi9Uz8qZXji9P6sn9g0qZwx+M9kD1Q6jeQsYycGxb4Al5hyThhJjCavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORfagO/69ragbixpJAhYQS1uc3u+nm7L9nO0Feo74mw=;
 b=F4FhUbvwarsdzrE2bAZGbY76X5wf3ovuD5at5pM+ThBH0nyoLlBqBQWgFXh1RdDCyXB54j6RpDjukREv3cFyx34LSaWvVQSeD3INfrdiSdkJWUONznqHcC7ejIzeIGl0nj9g0uOKg3UJ8lKZS/fRxbGN0JYu4TL6I5pCT0ZmRLh+8rctra7VU2598OwazTW8yxdaApQp5vneQ1vT6PLvIK5fkwHjMJBWTAfJInswjH+LtRKKsiFxE3EirVpbXflbxVYIsKoi1BPJ2DgvmutxfTkIiu/7jvcbuoTqbsyZsPYZmm4J3srrXsOmxXGB5nclK7LB3xXQw7fwKR4PdibYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORfagO/69ragbixpJAhYQS1uc3u+nm7L9nO0Feo74mw=;
 b=T53rUbHpCpzTdANHWVsOeD9rNknmH9HXw48p6VO20D4rzutXzMY9BzBxHQKk8nPn4zbr7Ak41kQwa458S/MF9nZwxPUJ0pRGvVpHR9DPHFtN02evzJ1ItLS9gDASDb6i5jXmWKEtnkLfdgGdNY4tOVxzTXc0iic/UadbSyfYrMg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 58/89] drm/amdgpu: Load TA firmware for yellow carp
Date: Wed,  2 Jun 2021 12:48:37 -0400
Message-Id: <20210602164908.2848791-58-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc6e5de-6ad7-4f8c-c150-08d925e67aaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534F12654E0E5169D440074F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJrp6AueGytN7OkX7tXr0cjcZJxGoAcIy3kwcvfq5fBi6sACicQVBqO3DDcO7HiOlKU7K8hAHAMYp35rJjQrdxWY0fV6Ac2tiDdy3gIkWyGJPkOcPvouUMhZJX3oazqZzsVs5HJO/H0YssA7BDtBpvu+vFb6JydmNKzOeq+gwPCu4TXcoUz3MALD9JHftawjsGS9tIKw8F7YAl+vZlwzJMuGSNQ97JMO468TehGPHC4PZDD7RbHhISnLMKMLYZTi3turcuPbz7tML0E7fo2NuakoKNwbS6rxpMf7TEwIojzAZZHP+T8yCz5TMeDd3f3Vpu1mdnm5LZ1Ezn/7z+SRoNFkoC4dexXzeZOzMgRoyGgJ6uDHzcy5snfHrUp9MPFJSHDMZoFAOXU1lgQZD9/c5kCTWNcmZsxheAgU+8Em8jya9pDZnxAykJl3VBvf2Tq5YidT9+ChW+CDiNGbt7zQ/Yi14zUHkhfBJFmiW7gTni4uGtaCWay6P8OA3Jrgw+FaymTOn9Pzqixp4XAoEwfZLHjpiyR56d+TP/e8Td37oO6piPCQ/nE2fSUMyvycRvSc+q8A0BWy9TemokpVaHKpzrazHBuXONBhIzLru8PxWDUSb2q64VKXT8eM1W1+R2R6f3ipWcQQzZOwuudizeUlIYR2iHbhBOFdTuDoeQIlyKuD2LQqq0F4GEZSlVLlIhO7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P8p5YVmzuErrUs7jQUkM2Vghha25cloweu9oj2aRBCZgn0IgX+Kgo7H+t1Jl?=
 =?us-ascii?Q?wi6lXSTer/X3Pb0QI1rkeYES2/7JS1NbxBjtPtwr8MIu5SAOFQYK3p7MF4Xr?=
 =?us-ascii?Q?SRatoQ6Yx7sU7FFSaEaXry/GAA5NHwSfmjktGJrZ7d1+izBWHxWLcl86/bf2?=
 =?us-ascii?Q?PFJK5o+6rgYpcg3QhPvcTWjZetdc7q44qcIaVihdb2xt7h/9xcqGo9zNSk3F?=
 =?us-ascii?Q?4t0qE9Gs1tEakZLHz5bpPeG03Hq2bwyvUfIGfUVrcmbI0kkDySpw9pcMqa2S?=
 =?us-ascii?Q?4K25ZkbuWoxKqozxAm8LbH3YDrI85SVXFKGCElsvZiKkqXiqYcKTNGzeF05t?=
 =?us-ascii?Q?dMX2R7/O5V6J6g4BKbp7oEyd6BAHWwWubkb5FJwegQGFyu8cs6H45uG42WV0?=
 =?us-ascii?Q?pL98vEqsTktA2Q0Gg9qh+NjARZ4Dj12tSsjO/8PHUpM03jG31zr1//SzmamC?=
 =?us-ascii?Q?yDn8eQRw+uTb8brv6SaN0TCBKLYtnYCaotut/v/aDhzMRiO3KvzxiP9M8fhE?=
 =?us-ascii?Q?AXlMl6i5Wm7XtqC1YRsMr8ula6+nCzQlE20pl+2foqMf/9OM5kFES5zmeBld?=
 =?us-ascii?Q?8BmKc3CUhWJ4OW3/q5LOwW/69Oll5nuQeberryfOpoR05DVCnBrc+UnBDi0E?=
 =?us-ascii?Q?EaopiZ8OoQHq/zusIi7IhaNxQSa4B2ooInGXBcM/R2Bb/QCO0mhpZdjSeZOP?=
 =?us-ascii?Q?BmIX+BMnTz0Q3vi21owEPk/T2eNYGwNq+DSFRpm7AlwQcHa/MA+0J2JsMktK?=
 =?us-ascii?Q?r3XMHMHo6LGFkPyy1zODGbRc/sftGW27GWan2Zxk/h+4QT7mLhdIfF8wDbOs?=
 =?us-ascii?Q?S2WroJu04MIAnCE7y0VHDgbqSs0Y4eC2rACXpJKUuiNrsr3XmSDOGAKr0zmi?=
 =?us-ascii?Q?HgvpTrLxMH67M7YRHhP77BTnw0mrV/bfk83rBNfsjrs745NjfWthv730i4T/?=
 =?us-ascii?Q?u5zch4b7bxOjtm9bhRHzG2scPBiSHhJ056P1E+JEEsv6FkdwYDpCDJmSGot4?=
 =?us-ascii?Q?o7P9Ub8tbfTV8tRt26nwWK1PBRUxJA4G8nYb5xth+DxppId7JyouxlhoQZGU?=
 =?us-ascii?Q?pUuD31cgqh3Ec6Rvxhjx60BYXbQpFn98kAYizMX9jLdjVJ4ZfeDeqNpKWBCO?=
 =?us-ascii?Q?iQYNt3S9/Qkbp1hV1jxe4Jsw3hvZSricdCbTTrSG3x1ZYPPNDXEIqfYWoCwz?=
 =?us-ascii?Q?qntnN9NpupccSBkP95xHUv2TWUD20ks83uGo/8NrPeaOmAnTCIQ2UQURTm8D?=
 =?us-ascii?Q?P1ZUoi15mSNWRHLY0+VrSA/dxeS6UDHOFunklfXGr9U5TylK+SlsxseV4Sjd?=
 =?us-ascii?Q?QELx9Usd5NO/hremhdO+Jo00?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc6e5de-6ad7-4f8c-c150-08d925e67aaa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:08.1786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViKNeAV7LiaB0k4nQ2dZfVGYKu2UZ7WIVB0Nx1pwGHh5AhrM9WPgA6eT/lw78BspFLtVZyTicoCyTOz9DPlCeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Add TA firmware to module firmware list for yellow carp and call
psp_init_ta_microcode to parse the TA firmware for HDCP support.

Cc: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 2b4916ab684e..c8949add88f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -33,6 +33,7 @@ MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
 
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
@@ -64,6 +65,9 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		err = psp_init_toc_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
