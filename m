Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A80C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 02:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABE8613AB
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 02:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABE8613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0554D89A8C;
	Tue, 20 Apr 2021 02:24:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8531189A8C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 02:24:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9TY65OloDdQpGprfu04fYhN1zVWDTqwgsAZdTsqGfEjfTSfEkLHMTBuaFg9/zlpwgB7hKJBXvP+kSwcXwdN4mPgwk7U5UcrAQiFrbV63VfXHUrakWjvj5Ib5RlCq8ANIW1B2CGHZmfywi+92JJ4bKQ4+9lFwXJ5DIbSIkyB+l6Ae3iVih++j+2wVdnBoGGzr4iuLLZjMmdWa97nt6MWMzLWRlPNqSx9t6U8hy35xtXLd1k5jCrDG6LRej9mGHhXu9Fzo/kZEWpPYESJci5avliSz0sOPHxyap5fWQlaKrvQgIfP64xhpej4T2yy7ceD7A7tltC0gJelMrtVRUmyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpQtNsBnV91dB6rmbL5p2mRu70mI8M9gp5czchHaqro=;
 b=K2PApr1qlUaiio9HM5CYK/JkmxplgmsWR9a/SWs+aez8YO0DPSm3kT1MmXmVrSrDsgL1DXSQ8RkhujPWieatWzMw1+9ebMyBiWSIdFg1B0DOnnxlTfF1vnJzIDcOfOb1agUBVz4nHqNFGQH1JNJ+jFYn/PpGXDYR8xAtvIMEEdurbhA8Dt7jPRZN20BE5Fuj1a/uWZqLMdBHKrariGWaNswpBtmL7YWQR40Bs0SfkcvpFDbw9n6wlriCmT49aCxExhTqNiAKxqJZMNNALdQxfbuSqnPi++T4TwO02W41hQd2T/xosW+CBu1h/wGxa/Oryj9nkiQMwcb/chghB1ELfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpQtNsBnV91dB6rmbL5p2mRu70mI8M9gp5czchHaqro=;
 b=QGnG/Kjj2ZtyZVj9OsZnbuZviaPdeHrz4zB4zNKDKuuzn66Kgjv50px8YcnRoGjsKiji8cV/dGhNEM8GhImNgYY6weFqhZcxB2IsyJNHd9gcJ1c4asa9EhmMbliqA1Ax0VGzaBNEhGzXj91nzXIu0LqAdRylv0xHCVhZCRieMCU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 02:23:58 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::3cf9:ffa6:9371:feee%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 02:23:58 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add mem sync flag for SDMA IB test
Date: Tue, 20 Apr 2021 10:23:40 +0800
Message-Id: <20210420022340.365464-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:202:2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 02:23:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbae38ca-b239-452e-d27d-08d903a35a6f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42503E989B388BF01216C85190489@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XA4HktDXehHsKlqGSXfSVTse9ZE+sYXgfkUHRUNv3MtqOVhZgmbB4rIayNWk1P16hx2e/lvoXn2e8U1sz1OR0Qjony6lnftwMcwpQNWhFaHTaQfmBNFeVwcDlY0dE9JaAB7j/1aKU+fHYB9/3jAiUugUu7g9X19DC07jOethPQFlYKqXwnqLHrygnlIO3YsxglZMtYDynELPSY+HdyQn0fyHfOLgMtc6txcfchtyV6YviH6ELBHwN3lDIu84QQ0E884hGmTKJlXBZ9dKEb6jRytfhG29iYJP2vzhI9caFZzzdJszNUhvXH5xeRNVmpvxT4CjSUcO7tY1YI9WB22ClwZV3koEzOejOWbT9WNUYa3+hfQwwU1k2O4nlMrvhokXd1ubtF72zcfghk3mQJSg4rVMYJcne2GxEdK4hu+2BNMExjcp17LWtD5bsqSJiakzvdx7LFjW10MSGHeox1+Lm3ah4uCcWkl6HBzuOjw6cZDOS52De6/li1X1MLBgduKpTSSN7wNzQis+zwD/U/VwpOlaFmfT7WQ3Je0D+YZ34vgLY7W32YYjOSHV78UM90Pgg04Qw5Z2yEtZ+yavsx5hSpG1EZShdIMa+4RgJ0ZzLPyH0atD0CYfgNx2f56wmfNh5ockCAxJy0bJ6HqgSzx3k3qXPN8iIUcRJkQ6WYIBUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(6666004)(4744005)(2906002)(956004)(38100700002)(8936002)(5660300002)(6486002)(86362001)(1076003)(36756003)(8676002)(4326008)(478600001)(66946007)(316002)(38350700002)(16526019)(7696005)(52116002)(186003)(66556008)(26005)(6916009)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pPOoG/xBqvI+aMde1/vdqNVqpHA/WEl1PmpsNCCEScF3VHvreD+AEg7fvupR?=
 =?us-ascii?Q?sIJVHb3PZ87CY2jtnf0RKxa+n2xORdatzIubfbd4t+yaSfQMlHuZrSoWG+qv?=
 =?us-ascii?Q?GoPCrM5kBcIZVWoSzUciz4VD3hv0Zmg0rlerLWeI0eWdfLaHGZfsQ5ChhFsO?=
 =?us-ascii?Q?DO78C6xJ+fXfUKxHw40HeuyJKun4V9KswMA25sFYCTAcpul07SBof2+hamai?=
 =?us-ascii?Q?GibaZ6GSHFPI9LU2/9a/E1CtYMQZSjCSskZDO4dGunV/2e3XqRYixRZHULa8?=
 =?us-ascii?Q?ui/6rgfbONInL48q/4ER4w+UBahmdrDgaaJEcJfGHGi6fNZRB6S7MEioRglp?=
 =?us-ascii?Q?nYsnW6PMl8fsWpxmN6FBI/8DE3npPNPnRo3hmWxh1mGC9EBwDJGh8CwHqorG?=
 =?us-ascii?Q?6gFO5Y9zJLiSSv4ThBgMPtZe3RE6XY0Hi7yEfJJb1C9DX7QjREablNEPQTIK?=
 =?us-ascii?Q?MCa2jhr7B900rzcOdOvlXOzCyq+M14RmfClBqkh+SNTzwLs8k0J+PDrXoh8U?=
 =?us-ascii?Q?C3nI/OM2VucPtGRza5W7+0QI0ORfQ361Id2Jwg6Fo7Uh0CDBZzJLso9YDpmM?=
 =?us-ascii?Q?eTOPeFJbqFtaR/cQGtdFt1nV0sYhQvradsGq0hDoIw2iBa8y/r9Ng9c3oMOa?=
 =?us-ascii?Q?uE00aCNX/S5K63sV6bwXuruo5u8jEXT75/kNTPuh9+gubjd14nY7OCVnRi8Q?=
 =?us-ascii?Q?kHErJiQwBMWln4IXSwloRK9RuNLcKSYREa0D5O4P+GTrdmac9m7W1AkOYQRK?=
 =?us-ascii?Q?/RprCayU5lZ1iMoLl6HnZRzkuh6+dwJQHyW5qwaOeuFdZarpAvcPh0ewopSY?=
 =?us-ascii?Q?3ObiSmBpTdoLLO8EoIFbohKbIenpEM5CPmrtaUG3ZbGjPYN4hy5TESWstKuL?=
 =?us-ascii?Q?jS6jGBcZQz/a3hWnPLh3nVEj5HDiAVvEuGrtQhra2FDgBWirwlCv/OsgyU5O?=
 =?us-ascii?Q?qqFfUXvJitq06b68fSknrSqZjcMpaVK7iRcVvZsbRsQcLD0QucP0KiKKUcQq?=
 =?us-ascii?Q?WE7gtFzJEI8JmDXoRD707jYy3Zbqsa1SP5pbNteLPvHZj/bFgSrOSV2KKHcM?=
 =?us-ascii?Q?NWOd6foyC2HBQBcxYnulSMtE8+fe2K8lAzdTp5WkVAgVbu8o2oInizAdkEnQ?=
 =?us-ascii?Q?NmGHXmnvx1CMgKBFuXNVXrWvR1jWIqAaquOVC8e6U0vLNJfIbQoQ8xb9vLoW?=
 =?us-ascii?Q?VqBs5o9gQBAG8SAOitmZSU8jih2b8iEZsCjEE3M0e0aeRHI7mPICK0cWL7Gy?=
 =?us-ascii?Q?7r06aJNWtRsreg0O7zaOIjj5qL/1jqUgUorave2sZ420/tsC/abycxunFCPV?=
 =?us-ascii?Q?CEIh7whk5bp5RcyGNSst8kdY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbae38ca-b239-452e-d27d-08d903a35a6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 02:23:58.4354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx/KoJWzZc3P+UY7dexaDEajVcebasSuRBQrVWG75nc+7+QDMbQ6oYcVk2pZ8Ki9j76+bcRFFr0RngGvP5DW3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

The buffer for SDMA IB test is allocated by sa bo
which may be used by other purpose. Better to flush
the cache before commit the IB.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b1ad9e52b234..da67f440b102 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1000,6 +1000,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
 	ib.length_dw = 8;
 
+	ib.flags = AMDGPU_IB_FLAG_EMIT_MEM_SYNC;
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r)
 		goto err1;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
