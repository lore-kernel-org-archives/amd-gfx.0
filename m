Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9855C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BE0613F2
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BE0613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5F46EB33;
	Fri, 23 Apr 2021 03:23:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3578F6E06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 03:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYF07N65qnMlm3Dh1M7soawkjKlpj2UXAVmjtGLFa8UXtN+xt9fcU3PaEIELUOWUt0eGKIMftu/phU/jLJ43b/1WDpGu+Fgdf0loIG6TAd0Gyf3XZpstzViweKRyKc3ZLH6LPXsVzUBzpc/HyoSjyYWTFDkWcAVVj0/rJbbGB1VQe9hyurInQRHdoobRDpbNk1adKsWnXS46eEG00eA7ZAOcV1IolQXZxWrrjTkRjC+nmLykUh+j+JN13ygk2fJntj/u5onSRCNeqYW+Oa4RlBhrssxzQQD3uXYwL4sH2nK+894kFp61K2jV+vL7Gh5iP18lPDN7l+2po1aWCrSO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFkCAwV9Mc7w6rq5cqyBROwXUwsvxAjI+C0iWWHbKgo=;
 b=Pc68qlZhq/djpL5aE9bqGE0JlcIc7AgomiQYNMgM6nwMylLQq8Q8Un7cNZ6DRnreIEkEH7lvP9O4YlN5pjciJrSM7qxKaK94y/FBWkdVJ4P9EtWl0lJjNQY4jtlYqtx0m0qf68UoImNXyCGBY98pHDNjKzsIjkN7onvxa9WLenYLjZxlDLI/D6E48F/MPJEFwhgcWBoSpuu/8ZFk56iqQnqEQrjPFNW3td+C8J5mpKHAt++Kl7410oPFIFMtadzJ0SYYbWLP712fdXfUVakaIYDEIRdFCQOt0sg9PMkL+yD+/ARkG0KYQLT3cCupasEROo+Dz72BvViu2sIdTdgJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFkCAwV9Mc7w6rq5cqyBROwXUwsvxAjI+C0iWWHbKgo=;
 b=cRJYY4yJ6HpWtVf1VXbac+5rAUPOYiXqg87Jw6wq+VOK0+dXGmJkDvyby7yiMmgRv7zb6a64NaRBZZu6Mjk6m1w+4xkNm1M4/pl95nIl6Bahsdtv6QebkW9h9nnBWNV6zHbpTNl/YYF2ZQ3ONpI6/q+bbnHCFM8enfOYxrvCrFs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 23 Apr
 2021 03:22:58 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.027; Fri, 23 Apr 2021
 03:22:58 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] amdgpu/pm: set pp_dpm_dcefclk to readonly on NAVI10 and
 newer gpus
Date: Thu, 22 Apr 2021 23:22:36 -0400
Message-Id: <20210423032236.6379-4-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210423032236.6379-1-darren.powell@amd.com>
References: <20210423032236.6379-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 03:22:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd936254-11c1-4a28-73b0-08d90607174b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29568A348E77C218F07522A3F0459@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArN7TOD/Ny9uQ2nqv6h/ETwWlH1S7TRU7lSGRVbjY4YqbixwNhJu1ZF0+tEOpmN4XbS/ydRKds4BYLAAyP0P+1otkmOPoNDPqf31UrmTvoIg3Dsw3qekTc1DaskvoouBphQ1XvIOBXg0e/Io86ro1dUn2wV/UgNgaFvSzaxui1/oK6LZmccGgauiA8WgjREvM5tQ8MRxIqhvbGBOmwHnUGf0AtvYoN/VsHNxpoeGV/ZXdL6QKHydOnQ7PK8siLiMGVH4ZEGi7RUOFbMk9fTVgiL9h99JkTmzoRe2EA8PCStOZjdGqaYjuqe+N6pu29A6TQe0R+3Pv63FxM7OgTU1NEsxqRRyce2tsxs4tGvCYndcOxRStlGfmB3Oo1xe/H/HtKP47HLWTmXwyRo28t6eyA1NxBshk3sEEMD1CCUFJ57krpldQWOGZSxTZx7WOB1+DQNyjop6x4B3BK9WbKdUXI07xk3t85+QwAWpm3876DGohQ46LzSWpZY4WmZgRs6GMorhnac7r61UwS/s0qzRJFOgLjkizDks8j0nGv3qQbyHDtX+Dsvae0KazRrNdCD4lCSr8gavQ+Bp3XEeOf0okPDdpmtoRBVKjDBUW0kY1APopermKvQwAM6WHPcioW7kFja3RXjrN0Z+eVa/fvU3IRv6YM5yBaCogddpe9i9FW1BSbE8oAlIfxV6lVGBV4UI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(86362001)(2616005)(4326008)(8936002)(38100700002)(956004)(16526019)(2906002)(6506007)(6666004)(26005)(52116002)(8676002)(83380400001)(36756003)(6916009)(478600001)(38350700002)(66476007)(66556008)(6486002)(44832011)(66946007)(1076003)(54906003)(6512007)(186003)(316002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5fbD28ZHWMjAxPji3vZjzw9zPda6DUh1IVkjJ7GLE96+452n4+h3+FHJnfX/?=
 =?us-ascii?Q?FbVKdBD4i0u0+dG2yYMDxzySKtrmZhUpOb57klO2Dsy/2h4ws5IastdjrHLd?=
 =?us-ascii?Q?QqUPF3fyuHnFhIJ08nECR9vgqKwUWyBJuh65h8LbC7XGBJFm8N0MInzzprVV?=
 =?us-ascii?Q?HNS+3K/3qHtK2tJePJ8K6XFAoOPNCoHly+JcYcqNzfJcJ0xSsrFdlpTKALoI?=
 =?us-ascii?Q?MPlFxSQzRSxNDGLX9TaNq2mwqBUlCPB2nc4V6AwbvJIn0sg0H8zmA4boje5M?=
 =?us-ascii?Q?xsuvbYoTcolmKMZvOU9bRh3eLrOMmxLceU7IKXAoqaNWw2mBAa4BNihN3agf?=
 =?us-ascii?Q?kNY7M0xwv7MSc+Qrrb74ra628c6/4TaVzumyB6hNHZi9AdiKKQqVQQbQ+IiE?=
 =?us-ascii?Q?q1/1EQYIUJ4ZxRyZRFkkb2QA5kPheucrpZc46xf8T8SUxt2z/nVYLBNqtiTd?=
 =?us-ascii?Q?fwC2rmfvA8qJ7106gyQlZU7c/VEBQR1nGeyfyIDG/bNjaRHNmqyDfmJFZijD?=
 =?us-ascii?Q?oz+SwsvffAIlMXZMDJGRP9yosZqsujnUwlQxfEyEwi9IpKpFbHA1Z5Rsi48c?=
 =?us-ascii?Q?bXmBTnz223MaXlSaoSEUE3OJPHOQZ4A69igFcr7R/afrNcsh414VX45Q7Rs1?=
 =?us-ascii?Q?8w6Pkkr/z38aqbVDuQetd0IzaaKTfTvFtyBQyLb+SkwV43r51zNew59b5VQO?=
 =?us-ascii?Q?muyvWMy/LbdwCuQ3O8WTibU2XQ15ZQPmzxpYPtU5h4SRKx2/bq0p2rvZ+Wvj?=
 =?us-ascii?Q?RMApYCkpQ1CpQOd+izFEmANhWvhY4UMnbbuMvsTny6xQHqLu3//z9I0Ptfs/?=
 =?us-ascii?Q?aA0xC3OeXj9MHVuaJJXclqlxXFBdNukVOoJQUODJwvw4tUKrsLNY3EUV69Js?=
 =?us-ascii?Q?sQhNe+ly4Gyguwx5lwasesjNmA8GykCxx6qpBDNQtoe9obsVx/yXRA26dyHp?=
 =?us-ascii?Q?9BhI/tkCDBarmSswaJKaZzOiZjko+LKbj3llK9k29JTQUMqVPkJZswYSvmmv?=
 =?us-ascii?Q?JYfgg7P9kJVrkiA2JQVBFgGJmkML1VA457pBufvL61qIQ/irNqSJTsbaPvs4?=
 =?us-ascii?Q?TV1ZGaDH/WhvwdsARf5f9EXYyTLCtsLQNO753Xf4iPaFX5J9xJAGUZvGCCTv?=
 =?us-ascii?Q?TpIiteGddq9PDOVPm1A9bTt48w5JyLkvUqOiYrhaax5BB43/zRgJJ4RTn1SZ?=
 =?us-ascii?Q?hfUToM9q1cRIbdJ8brvmIGji6ek+hSw9yYqsuf7iyQc3r6JFUz+yMDJM02OQ?=
 =?us-ascii?Q?G/Mb2s9rGcIkkc6ux27hFSguoSwoSjthrECVipyhs/TbXtQoErBM4PVv5Iul?=
 =?us-ascii?Q?Hc5J7MVWU118vIbc8Q0Ccz7a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd936254-11c1-4a28-73b0-08d90607174b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 03:22:57.7283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wtlI9GQUE0YqdjPIr4mFmS5zjp14qCCOLZqbXx5k0v7p8tG2GjLg8bPoLLXwQUMWr1KpG6J3bWDPSCvrmWb3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
Cc: Kenneth Feng <kenneth.feng@amd.com>, Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v2 : change condition to apply to all chips after NAVI10

Writing to dcefclk causes the gpu to become unresponsive, and requires a reboot.
Patch prevents user from successfully writing to file pp_dpm_dcefclk on parts
NAVI10 and newer, and gives better user feedback that this operation is not allowed.

Signed-off-by: Darren Powell <darren.powell@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8128603ef495..4e459ef632ef 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1893,6 +1893,14 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		}
 	}
 
+	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
+		/* SMU MP1 does not support dcefclk level setting */
+		if (asic_type >= CHIP_NAVI10) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+	}
+
 #undef DEVICE_ATTR_IS
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
