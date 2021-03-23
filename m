Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A0D619B8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 17:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A0D619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B379E6E918;
	Tue, 23 Mar 2021 17:06:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F196C6E918
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 17:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCPdeRDsdQY3Wl2S0Hd/gFAxjOEEOY6NEWTeZDUrI/htx4F/nC/BJXuJ/i7jqJjyF8vpGaT+b+t9E8HrDgcVHUbJp4ZrAwM4Q1Ec+IsF5TJU1tNob1MycWw2rjIdJ2zeGyZQQvM6+jcLykYTqGh+2FYAnzkbcOdN3F9+kUz+ozVc0aVVhAsVRkOhg7oX88SGhG1BYefy4qkWGy10xcQLWsE4N7xzuksZJDME8JfEpdaRhVACichIV+6YOUkthb73WV04anloOkCY3BfBzSILTAiL+HfW83McAtNI0XfsKKrStUUIE8CSaWbn2S1o8Qkvco0dY2D7/OSMm0o+UhvOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLP0pF7JMzbaWKEN4egu52nQC/Wy9CnUUmlOO++y81k=;
 b=ThWtHYrDmN/A7OPPubc/E5uIZzkDx8cTlBDHpdkK0DKUvyJtCRgJYfKbPPkU8+puwgyaXxvw/fEOB0N5vabu2aBiaiMCxZahXx/w/G7assnnpSJO4sKz+/JLVtuKk9aPKTHn1k8FFo2fNSo7glC/7XzZLpdWBhpJfnWHJdb9d3ivbTOHgc8wKe7gKjRF2c9esobC7FfBu23yWtk0bHXu7Mtlyt/4hvIH8NrnA++DJcJ2qUb/RY/zWc3pIooXQL7pSQz1JaeMj4BWWBLVPe57lhlUgLR1HyfVE5Lk1VRpsJKCEivR3Z1dRn55FiJdoPWeqT2YT0MIATfqaLZzXBfWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLP0pF7JMzbaWKEN4egu52nQC/Wy9CnUUmlOO++y81k=;
 b=4QqTmHP0H4fJ+nWvio2djtyXOtmQ5fDkOyNJpwKSZkSEgWJE45F9QmfvMLFVJOZWpcmQ5hvJ/vSpXbtolDSQjWX6j6KJqnNbXmyqGCLjMYFZzQq7m5yWsBrMQSb+iv9HsxhQtqiiSPL9HSHDe29s1duPPZcbDJElH/8bCzh7jt0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:06:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%6]) with mapi id 15.20.3955.025; Tue, 23 Mar 2021
 17:06:22 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix memory leak for dimgrey cavefish
Date: Tue, 23 Mar 2021 13:06:02 -0400
Message-Id: <20210323170603.1223424-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170603.1223424-1-alexander.deucher@amd.com>
References: <20210323170603.1223424-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Tue, 23 Mar 2021 17:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 133d55be-4355-4bbe-8603-08d8ee1dfbc1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4406413A0BAC23D1B78C505BF7649@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+wJjL6FVi6NZNdyFu0tErkAwpYSxC59bOlaLMgtWJaoP9KrnnnOfvopbD2Kchu1x+Je0jrvjzBonXykdhJlhttRzvXKg2ovSeG0J3I3Jh05CbNvMO2tMekufPwajtkeptjLfGiVRbv8D8oljulHiKI7NAgiK0pbkKARTxRWuJLhmWsQeIrsRVLxsg7wM96aHaLb0Y8pG7LlL7UmBdPnhkAqZBLL+8WTuVhM/1jmbohxhNzaQvM010UZULiCMhyG5pt6Gq5UGZMrYhNAZ7XxPe36Te90laD0W/VmsiV5kRh5KZdqOKOWzYN6B7rgdGL28W81I6isp7wODiKbsj3rPleoPw1ACbFTysdG4ETLH/tFtUwjO/SuDNdXWoG49h/1rSB7QjEr/Uo3c14qb50Mj2Ro3AnqKOf4lVoG99rzQMVfNV7r1EDTBxKASardtldnHqvXOK0atAjAmAmVd+y2CEMvwECE4U5C314dAIrN7SX+x/TXjmB7X82Rmj6TpAXr6ts3IlaCRdk9u21aijol+5I8rDaqZqLLpFwRU4OgtjUcttTVFbJpqiQ/MnMO4yJaO3wperUs/ri6m8kp3lu/WhWPPQJReeRx6RUuVWCTvBH6dOhIOOmR2ap3Lzaz/E8M5k+EaKq7tro5saXBeO/lpQevDJsPIiv2hGson2IJSP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(16526019)(38100700001)(86362001)(7696005)(498600001)(66476007)(1076003)(8936002)(6666004)(6486002)(8676002)(66556008)(66946007)(4326008)(2906002)(6916009)(52116002)(4744005)(5660300002)(956004)(36756003)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?alJ1SMKervDo++7sarq/uv9Nub0Qr3/uCRboQVEJdPQu9ZEkcY59wZaafSTy?=
 =?us-ascii?Q?mVAdF8ABErbqc+vKPpL6daYYJE6jlr3gmv2rdsqy/4F5NEnmdi7LkGZpCuno?=
 =?us-ascii?Q?gNPX8qE9lNZ2u5s3DosYtOV3uipyueVt7qeqYQRulU1iHJ3OkI1obs8lgjYb?=
 =?us-ascii?Q?xJY1atcFbriH7XOq8fVhOHYCP7dCm6deGbNGZKVt2DP30QpnjT9hB7zRHLtA?=
 =?us-ascii?Q?3oHnB+bog6X81L2cNG07JqmQjAY9kG6TFpPDM7Tha5HuIWWBYAnv0cTlCD+C?=
 =?us-ascii?Q?sySzA1h5d2jaoFR0aaIZV8BaRRfCe5M8Gc2DM1NIjXQS/jSZ9bZpJHSraEGY?=
 =?us-ascii?Q?QWgAyUuoo37shc6dWCUSxuHfnTYHP6/yTtQatINyKd+YtxISBzKyfZlWrEkg?=
 =?us-ascii?Q?+xBvRSS4z9AQK+jmaSDFXN2dA6X7V7WpDjOJ19zIEIIa2rVnGgF7sWZVZEhE?=
 =?us-ascii?Q?AFS486SFKAe0pPzj7GFTnqR60YnqUYkxz0JBQsPYXr+U+Efo9WGJ3HN2XLxs?=
 =?us-ascii?Q?/pksYRxTis8C2XYn8ld2j0RuvYmt93czrbpNtLs4Pphv/D9bKdUySodoU2M+?=
 =?us-ascii?Q?sGgW/MHpC5tF99LhcXr45JrfXE4GrZyymy/v9w5SstWweSdDrDl1OQJk9z4P?=
 =?us-ascii?Q?3qISAcZOXimYf7ikYy+EQLvi+n36JxNt797cF2bEnLLgrZ1/Mt/M2ImlCtyw?=
 =?us-ascii?Q?ODwNq67BCPOSRd1hXM6AN//7VgrEe9f0x4o7XhDAdb0BSPJNSngwb8Mtb/lz?=
 =?us-ascii?Q?VEjvGlW7uG0XMKTMVvNkrCqUGvncBIyTOgUnlXTtMRH8fDpveuI5w8MiCIa1?=
 =?us-ascii?Q?zQd9pCx4l8tOs89AloPlgHaQR3AZe6a8Wjk/RoOGGa/Z3S4CaWf2T1XSkr10?=
 =?us-ascii?Q?0BgWhunTB9sco/eQolYBII91UUloOSC4MqJebyUL9EM3YbQ/4u8GSuIu20ZF?=
 =?us-ascii?Q?z129nFBFA7U5x89N8+1a3XSfFo6vjO7XnviWQV1JDPtuLVeWLcSVRivvU7l1?=
 =?us-ascii?Q?Z/ZMstEYlR6BChyUVi64ZVwQkfq220HGUq27u5fawIjQbJDEUg3QSAAtZ+wu?=
 =?us-ascii?Q?KB5dUr0NBZq7s6uVHcf0LdwuLWbqgggr63pRlgpShWXk007bG15+VMUpFK1Q?=
 =?us-ascii?Q?Ld3uIypICXnE2Vknu4vAFsK3OPIWySqY+60UA6+W+CwvG8HusDImL2EW0xKV?=
 =?us-ascii?Q?ryw1AdVFRKhcrFG6RHng+ni5PG82xC/tWfl5uNfoovbHnS71jsfwTQbV/Vl/?=
 =?us-ascii?Q?DODycAmPIvlFQ6L5XxrGDKRO/zcapJ++wTy3nnaG4sQEgPbxd5x26g2jz50R?=
 =?us-ascii?Q?E7K4H0X4Cco0Ca5S2ex4o/t9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133d55be-4355-4bbe-8603-08d8ee1dfbc1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 17:06:22.0222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHhu91tAAjCa3rye5WVVHpNoNrBq6cZ/NGTKyWsH3sSAabWzECgb/P0t3lE4KXqerhkkh693C5342xOZxljwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

We need to clean up the dcn3 clk_mgr.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 203150dd37f6..c81da30faf03 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -274,6 +274,9 @@ void dc_destroy_clk_mgr(struct clk_mgr *clk_mgr_base)
 		if (ASICREV_IS_SIENNA_CICHLID_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
 			dcn3_clk_mgr_destroy(clk_mgr);
 		}
+		if (ASICREV_IS_DIMGREY_CAVEFISH_P(clk_mgr_base->ctx->asic_id.hw_internal_rev)) {
+			dcn3_clk_mgr_destroy(clk_mgr);
+		}
 		break;
 
 	case FAMILY_VGH:
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
