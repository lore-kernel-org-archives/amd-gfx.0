Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305CC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 05:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3DA64E85
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 05:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3DA64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E896E1BD;
	Wed, 24 Feb 2021 05:33:40 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680081.outbound.protection.outlook.com [40.107.68.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5406E1BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 05:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvb9H6RmtsGvvs2MZtDR/0pJT7DvsnUInpcL6A4YSlp6hzfePQk1Raop3tohorcCKW/eECyyand4GC9HPtRpgh6kkzq8V0WYsTKehO8Ol1om9cpm5QE5Uxof2o5RezQGrYwboJgwv5cYYKZumUtUw96o50WXUt59zIbQDedGGpjwpBSpITkuD59ArB3NjnbVM+FeCGg+IiGBl+7C9N50tkIcnj2ETis3HTrExUnXN/MA+I+BcEKZlHvhWJ5QRmNKP9Uy7YUZUAWS3smaIBZ/Kkz00lZB3Abr9LQf/wE4ek8NcJ4OSg7BEJsJjje8zwGP4XCrpWY7LdiYmjs5+H6UXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpNO8QyKfs/dI2zRUoy3uvNMMBNl6LsvXp0rYK9cJvg=;
 b=NYnAEvmjOY0FJli3CjacP9UQbW+XqZez8hAQ5kA7QAoTzi4rF13rZL59YETQXIXXLljwTiBpGKZseN/aihYT6twLGfQU1bVeY/ZMHQXIOjewKavL+fH5lleGpc05YsnM/0p5wkUpz7z+ulTBJoKxxGPkdql1fAH70Y3vARibPL9z2K1Hdh7XBlotDtzP5XatEQL4G3ODY9iGjQ4v/5bBg4xcttI3OCaO3U4hPYOA37VRAL9WYzGdf0pDYO8sFasyhylGOQtWMgg8HLOpSQx7aD6BHY45WTTYS8bjF/vE4rYPRooUTPdiwNA36PddfiCqOR8AmC4jWe9fSNJ6u7VC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpNO8QyKfs/dI2zRUoy3uvNMMBNl6LsvXp0rYK9cJvg=;
 b=T5NmMmHG2AZJjAJz8NQDyVgk8xEqFyzKxBhAmUoF4k7c/fRonWTubjqaiAzMTbEX41Rvfvzmyp8AsiiE/MA9Mjsn6GUBqrbWolTMIvvdOTjFwslQGZK0iYbvk4KQyUyOHgpLyvNb5Zwoy2E4DxhvYNO7QqRRPn2F7VQHuiHK66E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4796.namprd12.prod.outlook.com (2603:10b6:5:16a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31; Wed, 24 Feb 2021 05:33:38 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::1490:780f:1494:d66%3]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 05:33:38 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable SDMA MGCG for Vangogh
Date: Wed, 24 Feb 2021 13:33:19 +0800
Message-Id: <20210224053319.29985-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.3 via Frontend Transport; Wed, 24 Feb 2021 05:33:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 375e3a20-eda8-422e-6b26-08d8d885bc55
X-MS-TrafficTypeDiagnostic: DM6PR12MB4796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB479698351DAB94D4D783CD2B909F9@DM6PR12MB4796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/l6lDo7gXpmlfS81l6Yc424m4weTBdvjDaXDT0iofZY7aCuYXSzUZDd5aaobCm4UHV16ibyAtuQlwJLc6123DAdgF8IENGD3btfY9qWGWSIS8/yvWyr73PGQBfb/pmVKMQhJ62BY37dsNdertoP/Upwf034ZO8zPw/CJ3oQbl+dVSn/tGCk4Bne53dle0Mu2Sd+AnFrSaR3U+wM4x8D+VMgXYY7I7RURQWVAzABK1Xt/vHnhmlK3aAX+7rOQ6dO1GCKso93BlwzesVyq9YfsOihlDRWj9vFQpMg1BGsllf+PQEeEhEmZfZfoVD5QerHwiK3rtVUqb93Ac4JQhG9m3kPkPJcd9TUm6DDGjhja2RFTmqgogYWCeFBs7IVfItE2QZbcvDy9oUmNd7eMY7H6HIQAG94xOl2DZnCb8hXYGr6lxkTn7VM4hz4TIktH6L9hSi2pORV+KiNF40uk8CpBIWiwEDn/84RBXcFsunRDdaOurhPGI+Lcy46tKfM7Vx3JFk/186SMuCizsCQSVEcdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(186003)(26005)(8936002)(6666004)(16526019)(36756003)(2616005)(956004)(6916009)(1076003)(6486002)(4744005)(8676002)(66476007)(478600001)(4326008)(86362001)(7696005)(52116002)(2906002)(66946007)(316002)(66556008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MBNrAKXEEX85RM0hG8fNS27bKmJ0QtHkBS7txqA3wxBJfXZtGak3aXuvoTK6?=
 =?us-ascii?Q?HUlnPMjeOG5bqgmC39mgMbLFZq80zVO0BK/ogOkPkCXnpp7vVT9o244Qwuxo?=
 =?us-ascii?Q?9Z/K9AfFcuAZCihgViIFMWcJL+bLWakUDcKomcID3mjNfJp7SwcZa5Op47HD?=
 =?us-ascii?Q?OzR27AuxnrcvI1y/OvfvQ4FlAqWUYGgPCjvfCRQ+/TmOggkYKyUgcHjO4yzp?=
 =?us-ascii?Q?rYSyihZMUWUYlrqANl0wOKx5JIGAvr9VUKcjwEdCT8ixT938fgRhdSF+GQnb?=
 =?us-ascii?Q?69iFX4VFAKZChhJDau4jZKiJoJ8gGCqeJQRwqI6QvT3tMcyvFSAzh+JRHv8G?=
 =?us-ascii?Q?zBaT+aO9ZX/fkfSy4q40vLmhtEHhpZ2bGWRQuXW4/J52kZzbYqodLfxMcJpJ?=
 =?us-ascii?Q?GkcTvvfl9Xgz52Pp9n1FEAde3j8VkRfpkLwA22GybxytO/7Wpe4hZwu+K25k?=
 =?us-ascii?Q?tnD8DHzOlzH+xDvwqRBweUvr49/XfwMM6ZNgVnkM0IgTm/GVbILaOFA1UMra?=
 =?us-ascii?Q?1AEhy22JKUupA8WVC/DnhjeyTvAAMwdTywRzzsYhdxYhR5DVdNWeEEPLhb6u?=
 =?us-ascii?Q?3t6Gh8U/dsQa1kHb6lUqKZNdg2EQoH3wnurJRoD9l+StQMzR+Glze33Eb0SM?=
 =?us-ascii?Q?IlJC7dFfknFqzekbk/ERM2NSQUOWbKx3tfiZerCCdyrIeFpVA03CpzdaLJrZ?=
 =?us-ascii?Q?lhUcfwlMYg6dmMjJFbnS5dy5NrVIf9BDR27Tt8U6YCxUZbPQCA8H79+uXr8r?=
 =?us-ascii?Q?a56+o2tKEsQjuum445TSd8HHUbMG7QBWBmU5KuLgl2FQf/6inPr0XLqoy6xC?=
 =?us-ascii?Q?Foa6WQfueaRCbYMfokQuTQGfvQuql0JCTgsSQvqV80ZxMZHH7LKdYf5hUea1?=
 =?us-ascii?Q?ca6k578nkPrVV+n1jg4oJ44J4p6ZdthoOjyLDCZzMu7RKuM48Oc9II+wRIo6?=
 =?us-ascii?Q?gAsm37BzCnYqZXPrWpM92YnF2fKAt1o+M39jmUfE24v1VDZnQ08xjv8Qb9Qb?=
 =?us-ascii?Q?LHIAQ8+4wLl4oLlx4rd6IwFeshq4tvfW53mHd4Dzur3OKapLtx+YIuCfUw87?=
 =?us-ascii?Q?Qfd+VD3vBxKPlQnzsZz4eYtNVT3qnJwtccTEfPqNxTE1FBBvNx2t4lFZxuAP?=
 =?us-ascii?Q?sfn/pPcJF4ZhxLIejDuAK8QrkFIXjqfnGMoFbBxs8v7kQ0UjFza3NBxT7pS5?=
 =?us-ascii?Q?PViEysRhrAJtfJOve/YrLEFtYW9QXONr59K9itFgpDid5FqHs8KRnmEOAjkO?=
 =?us-ascii?Q?Q1HkPOFfwSPb9L94qP6HyA+ZJlKAcNsk6PH6ujJFM+HJaCJMB4EA2kx3aX9C?=
 =?us-ascii?Q?GKizFZbgxC0AWasuB77Hbc5x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e3a20-eda8-422e-6b26-08d8d885bc55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 05:33:38.0716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U2V8wPzaAzWaeshyT8OtrNpkuxGeZijp4OFdZI2kspJdzH55q2xqCWfAIEA5QgmUQRLaoxmqYVql+AtCNQsGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4796
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

Add AMD_CG_SUPPORT_SDMA_MGCG for Vangogh

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 160fa5f59805..393a0d5905ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1003,6 +1003,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_SDMA_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
 			AMD_PG_SUPPORT_VCN |
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
