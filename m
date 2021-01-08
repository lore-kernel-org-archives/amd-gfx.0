Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7A6C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAEF23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAEF23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76ED46E8F4;
	Fri,  8 Jan 2021 21:50:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016826E8F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A71Rlz2BEmekRGASmmYVcfmhDtwYjCZoHL+7p7oQ6Lpm4lzCRKTvQ21z3AQsN0rw2TbtOjUSxjkebLPL0U6KSkhl8klaZSoShndW5p1yOsun/BSFAgOc9SGWCEzkmhOIkyrwOlkLX4QUSduWNnpnrCy3oS4fklYq6VNqIsvLi8imIpgL07/lk51YTS34zKKnApLOaFNlB7wBmf60QPJPx/JML2mCWr7E7ZEMTDSEdXWSZBx5nf5jhJqmihkSbbKtGgzer4CizdXbvktpe+J4juaGmT4mD6fjysucJnLSHcp7Ssr5TKyqEAPOaVImOqEm6u2ujSwjli9+vRQxVHpPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYOAvyC/nmMEY0RDbecio59F1xf/nbcFAUG4eIFxp8s=;
 b=QBmmpCqbavUI1S56tOfYl9LzfHfQEdAV/FCo3PgCihdr5QtZVq9uJ0sN2+bDF9jHbzO2f1MVVAoyVmqA1b3TJKnYYAXLxbUV3UPgTkFrWH4SdLURcCoMksj3J5hHEJoOmmpRq6d4+UPk9g+tpvLi0XlUUD1LbRwEq0NhhGl+Ml62CokqmZPmBh4ke4vaqY6vAX5Q1LylYkxAnWyEwMdr7Ty2ceeJOlOeqycTcwRfRK3SriP3bpJ5u64bvJYsmYuyY9vHizWUPNaPRRuU9XD4x1eUc+2JB1FMIL3HR9HtT8hEN9HriwaEl+IQGgztxxHsZGgupMdlupwh6LYjku951A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYOAvyC/nmMEY0RDbecio59F1xf/nbcFAUG4eIFxp8s=;
 b=Iv1ocxWAQ2kT1fOcpFp6vpMfu2Xf1XUsT1KG/QWz0J9oluZQGX6rvEJJBxroB3z2KcvE518NNEiilgXxcN0aFCafYb7AbUPtDD31+zD+aorxyZNsTG9NcjQiNxos3dGpFjirIVH6mviXssIFb5ENo7uM+mFoKItG1TkfVSlGyfk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:54 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:54 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/21] drm/amd/display: Add a missing DCN3.01 API mapping
Date: Fri,  8 Jan 2021 16:50:03 -0500
Message-Id: <20210108215007.851249-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0ef227a-2c1f-4b1a-64dc-08d8b41f7923
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882DB5CCAA0401D8B2FDF1998AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hay+z6Ub4N3sM70djBDo6PeQqQN5rGxkgS6dNTHg55tO5pvk5zfhT0JA69PUbQla22DNre3aKIwzko7WM8ew3IoNv3pnbx1lwxqKsW4AyTJ3uvVSLQvfC3AVo0Dopb4BsCXb2D3PMSqpauS/bAVfMs/pSHegon60WuGHYK8zSv+VjfMT1O8Gq7ayY4+tSKxT/k032dh+Srdi/KfX7bSDfDERZQNCsdnWh2AcNrEyvEzAAWwadlo/Vnj2cflgAKlRUm6JjV40ldVhpotsVIFs1pFQodrZLpCiVAkbwgHzgAJV4HgJhSkIL/aEZ+rHD/Mc3jhwzPg9i536WjNU6D7xsSOi/72mo73YJy+deHkLyKi9z9RU300WNOHQJDcdNc2+nvGVHdvhZS8VIOxYMCKXSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(66476007)(6486002)(4326008)(52116002)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wA4XkQ3psImiNtHxUD3NGEOvjTJpy8VAcoo0hoLwAcNqDbzVXilzDI3mjP1k?=
 =?us-ascii?Q?QkIw2PwcceZwl5a98C0UQsM38vYxkUAlZ7VuHOGXquR91DXGT7zhw+Ojh2aI?=
 =?us-ascii?Q?eNObeOfRG+llfB4om0ImWD1qdZgtvp+65HTpyX+mEoW+zVaMYceh0rz2lC2q?=
 =?us-ascii?Q?bnRtXk9DIgsnmg1GC2gm479WFZXlV+xEQ5gdTlzqjMqiqiX1gT8O3cXXj0ZA?=
 =?us-ascii?Q?XgweYvc4qwwy3Sz+xxs4ZfBJwu7Mb4XoDpox5rizpWb1ijzI2xXf4ZlR+Zya?=
 =?us-ascii?Q?w9kwxDXfxtztQ+v9ceuowmSfF476ibUnRoM6JR3R1jz1WHct9Rzzhs0PZiee?=
 =?us-ascii?Q?kUk4wUmfE11FgfuDiSUCkMyebaxtWcOyJzGENqEdA9XC4wHhpzkgdsZLqxXy?=
 =?us-ascii?Q?7nZpZkknKPmRCtoQFwdmADLSIkY30Soitzh44LcuXl08QeAB8JE3banMOeW+?=
 =?us-ascii?Q?PmVQaoKGQWsIcK6f1DaGHzaottTBvo6Vk1/ToAr0XTGUsNGiBImadtCvwmz7?=
 =?us-ascii?Q?nGnd747SduTYnO5kQMndY57zeocVKGfCiF/pcJ9iCUIk+0RqSv+ZUjzkeijH?=
 =?us-ascii?Q?qTTAzOR6UNKXdEUEFe3KLk5ndIinmiIppsNH1RySSp2BJA54ty0wKeJXaeBW?=
 =?us-ascii?Q?sJ8V5ClrQ4oGfwaMsaNIgrXitL1M4qQrwbornHYsyXUmgyHG7q+Ig+Gx2Zts?=
 =?us-ascii?Q?l9IcmTiQ56LkTCnAFlPtYyLbj7mhzJsMzKSir9MNdS2i5wskgqHD9cwsfJer?=
 =?us-ascii?Q?91mViLUoIHQYLDSySiAWi0RRbMMNhbpYv5y/VMXsjmxbu8uc+ryHUBx74KUg?=
 =?us-ascii?Q?J8TnIv5On8yIg2dTFAGFGxRntwx1sEW7oW2oCNBinrVPIIH0YUZLDrH4mlJ1?=
 =?us-ascii?Q?bUQGm0DOOxgvBO6PYA0ZieoLvvXktqGj4HaNPuzbDvmBepu+XZlz80LJSLAC?=
 =?us-ascii?Q?x45rVGlV61h0yGIYWlaATQjy+zIZNuyZCr0SuqHe7lpiEqFlB1psSQ+dmQfU?=
 =?us-ascii?Q?FQPizA513hMXtJhxHfD8gSZPkcPwlF0skBQAnSTal0gWGs5J/rxVPx659PbI?=
 =?us-ascii?Q?sTk1HImC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:54.1044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ef227a-2c1f-4b1a-64dc-08d8b41f7923
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+iyiayiTYG0qpBdUTaz6VVqdolA8VESBm+Z6ZlpQtwGpBTY3ILi64WiVBf4Re6ox+T+rFcguErUIxVu8l44zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Zhan Liu <Zhan.Liu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Nikola Cornij <nikola.cornij@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Required for DSC MST

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 4825c5c1c6ed..35f5bf08ae96 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1731,6 +1731,7 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
+	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
