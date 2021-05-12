Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A71C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8F9613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8F9613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE0C36EC82;
	Wed, 12 May 2021 17:32:14 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C42E6EC81
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N03vCk6tI+UvOFhceMXosh4T33sJ5fc0Sk4PZw4rxP3gUbKD9fx0UuBWMpwL0C4xDEVWG53HvymDH8iRp/9t77J3IuZ2Tl4C5qSaZCkoUV3X8hoTRnktuIJzKGfgQ5fkRhbAf4Rlt1LzMEKdcA4W25cHPgscBzxJmnEeJLAMEpa37W82ZY/7G+uLEIEBCQDWqVgOazobIPYoPZNwjf83L2TS1mCzmsRxbKUb1qOzP1/cG+qiMQPGEHeKe3qXIEZtETHnPpsz7jXkVLd8BnuP7mtVlDO6s2Rib5M1EHdXsquFF+UnpEmKJw3e9L80knuJAyjujVvfyBfrEzip1DAydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wrM/O7TpBNYtgHx13mxpDCEPtbGASag9RC8gEXz5d4=;
 b=C9MGBt15XhvCpC0N/skLbJqwB7xXGYJM23fRg9kY7hcxkNQxwQgbcIoisxfQO1Y2F6G3j+enI3ak2Qf7J0xkIGorgC3xIzMfIdGd0KX2ZB2FhVQ/u7+0kZ3llhDIlHQ5T5I+GThRM/Wlf5uF5GvYIfrImM2NpJfQKBH+KyPVOjQbV1TIJVTXMdWSNBS9oginvrMMPEcvMSdrD0ge7t3lfRZYePRYpUop4Y3j9vNnsJUrnhNFJv+BqAxSW6NRZ6Pa9BmSFpXinNDdMcRV2FT4Yz78QNU7IdNM5Ch4PsI1TIKEqFsWnpF1nGz/Xzr5ibmQfIGIhbUdv5ZPJsKoLrxCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wrM/O7TpBNYtgHx13mxpDCEPtbGASag9RC8gEXz5d4=;
 b=r7PEDhaJxouZNBZ83xc+iV7rIpuvBDwWEn5B/PBa94mXaYS8/15aSnFHTZqzbmYCDWtFFGPQ3k5YTNzrYoJ70JAd2BjVK6Wp6W/2AMYO5ZGe3iBMI6szd/ka0BCJMWYFAokdmMbvjQyOUjfF2njPg1RtYDroTHB1pW5ItFajZi8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:09 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/49] drm/amdgpu: fix GCR_GENERAL_CNTL offset for beige_goby
Date: Wed, 12 May 2021 13:30:44 -0400
Message-Id: <20210512173053.2347842-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab766a0-d987-4d91-185a-08d9156bcc58
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2564B72E482BF94E4F88E01AF7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mlyhkz3x115macuvQhuvYoJ0Si1kp1NHbVOW+e5lD5ju9ifs+F1wUf0jWr4p/NbSiVaGQWq0AT6i/JPEBuEVFz36Q971Tvxr5QSPjvALABmoRI897eshUa53hA2eMZpoOhK8gIuGTmTyLbl9BOekw49rLNdVkCqvxK+hd8dEiwe+AS4grmRELRqOt140weiPKLIsDScQ1qj4wqLi6fQLLebBJkSMF2WjWFFU2sqZIvcn1fky3AOzLmeHLLY7fjjiqK9HDWRIPwC6zfMp6vhiJjq/TguZBU6pJOhJEgDZEl/zrVovLZotvcgl++Rq1lqclmp1HFzM7DaCOVfaBpI/c5Xut3Adm0PEQFfhSW34kx4FpO23qQO00r+bItgDhSBJN8Wp7NgpGIlyJX/yN6iEBe6D0y4sYcQ+J2+u+oBrdjCKIvs1eeiLzCr+58tVByBVXz7SuwrycNgZKqG03fwZSf4RZgpfglpYTzHRhFQaZFrJ9Jwq7r4V9Pq3GPqaNeomaVI7jxZXX+4VRNPm7q1W7tgBCFwljoonvsTQGzvplsMR+3VBikW4Lte+UZ0EXy8D11MJRjpkN2enakZ3y+2YyCPEza2cbf6H/9YGdGxsTDwQZUYBxz0TJvyjVIcOxwy/wVyMEK/0ZngHZ58LzOFPS+whCi7j59BmeKsbj3vkikegOlxDmvsTWOZVry88/XxK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(6666004)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RnjbyqJLhu+D6N8NGyXd9QDAm9Mf1dEKUZPFC/r8iipUzprJmEXaJ/xjOrgA?=
 =?us-ascii?Q?kvMUssmJeb8iTmhbAxW+C2usXUciUq/Y9G5oEBkEKwZ6nyhtLvAOYE68gIfp?=
 =?us-ascii?Q?89RkimsJORCpHSlwoAFVUCc1ivurTwAfjq840a1RtgFhKpHpr5ZvKTsRqqw6?=
 =?us-ascii?Q?HiCoFsIQwyw6Q0ITqNqfkPnD6oxjWvvFptKNihyRbruD7zm4EkbdBE3PNLKv?=
 =?us-ascii?Q?iHLZg5JvYaARMATr8CCcNzSXYe60b0d03pqKlMpCdI9DvPzhpvk3NtULsFOS?=
 =?us-ascii?Q?4D3xpwQwBXGwtNj0onKWdAyszqZq6TrmzzpxZMkjbxyVLcd0/4cf1G8PgEX2?=
 =?us-ascii?Q?k7oUQMx+ZJQkbBL7pei5sEwIbDJhsThiUjSrMSgIsmWg5JsFXscVCDCZ+aou?=
 =?us-ascii?Q?ft/lfhO1pbuPQDuslafKFAGMeUJFuLwiado2EJRQc12jM57C6cQn1AgDR6s5?=
 =?us-ascii?Q?kV0hPaCtHJamFymZVspkrSIjCtsulsnRyW4K0yRZnM6Pm+XaQm5I2d6WsPkM?=
 =?us-ascii?Q?7c+1CA128m0cJeoUfFdjGb/W0Bk3i+qsoS/cdnYAjpcmdjBvjkFRzKGzhE/x?=
 =?us-ascii?Q?iWat96jbhkXFO2wHHb8JhoN/mVyLXvxGlkFyPGihEi7JRe5RFuCDJHKnFcU+?=
 =?us-ascii?Q?5FkyjEBfb5Yf1je7suxsRZZMgqxcph5QT2dhuzj26g7k92oFB/CauoDeXPxm?=
 =?us-ascii?Q?J5feoTIbLKK9kw/nOI3Jqdek1foRohT9Hf/G+Irkq7exiWTwlN4NIUtuOrq7?=
 =?us-ascii?Q?FzkMJFKXW8TmN/KfrLlzmvUL9+JqV6b0h+aAKnhBt8LnMwIbS+lX6rI8lr80?=
 =?us-ascii?Q?eQdJdfZJuQIqX63/Y0SSduSJaGxZBZhNLuCRt22r9jVVSW2Yx2umeFAGK9fn?=
 =?us-ascii?Q?g/AF6eifyFVbUCe4zSvayBQojLvcXfZSVzXBP26aDjwWIHabydHbIoCpm7w/?=
 =?us-ascii?Q?L58cWGrV6lFJyM9juui2bezOU0lSsnuxW7Jxly9M8VRKw8MU0TAehr3TrfTE?=
 =?us-ascii?Q?FzJ7YRwpmm5F81eKt7A4Z1V4bqrNwHS8LNqOQo6v+lcKyuDKNY+wb/MDK+W/?=
 =?us-ascii?Q?veDA4SYGSrFX2UafOmEmumSdiaXBL2a410FKBaprQHbzShur6tmSYhQC30LR?=
 =?us-ascii?Q?A5uv1zk5N66YU9inAnTHAyVUFx8q6BiWloE0BdkrI/agW2Pw/8Ci3zlwqPxy?=
 =?us-ascii?Q?nLqH4kza89TXxee8vyz3pk86zDnQeX2ATwbyljHIZBewpBpNGU9IIicmpnHA?=
 =?us-ascii?Q?v5h3Q44JE8L/QqElNtrTtObR5piPekcgl3UlvvBYacRdBWKatiNngyDIVK3p?=
 =?us-ascii?Q?oyqXGrMjcQWnir9g6pFdrryz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab766a0-d987-4d91-185a-08d9156bcc58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:38.4620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoBBLW5hgxczNp2ckpILDbmv+r0fEDo1PG2/QSCDW2HQQFzGtylz5d+/+dBzzpI3hb8+hYX3aUH7hjHG9XpDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Gui <Jack.Gui@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

beige_goby has similar gc_10_3 ip with sienna_cichlid,
so follow its registers offset setting.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a04010e0e21b..be49722b60e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3422,7 +3422,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_5[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
