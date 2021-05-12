Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A3C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372F961419
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372F961419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC7186EC8D;
	Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D517D6EC83
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv9yG6bTFxvhyiolCiezxcnFl625XEYcSvlsAYB1ZeuCBNr/7qUs8cg4xzaW0Efg8bDrd6FZNQUlfNGxcPthU8heStSyzMOBigl8m5kKxeiCo/nyb12W9t5ZlgfoeqWpilVxopj+pSf2sZqLhpertFuC4zn3hKg0LncmgF57tL3aLpgfZQLkhXEe6E71XxGXrUwYt5U1WEQjsePxZgHO9OyV28Afd/kyg7hudieyge/aOmbDDsO2U7KSndd2Ftq+woxaz2sKK8es5gbuPWhTsE1mPhdP5VBifiiriYC71sQW5xMv11f7svNUIW/hBCasQBj/CXJhy1NZMiJr1eNRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QERV20LxcrFTloziO0ki2Q1sUsjvi26oAHYsGF7hvk4=;
 b=L8/b08YXigt40w7cXZl7G7wWGv35yBzX7iH50Z9CILIDd6YYLwoyezcFzVN8nmbemJr5Ufef5vNikwIpqRKjLNF5EzYOyi3XKaABaCLQSBHt+9EbwQ4YfKyUotkwoe7OiKcuaigQvdWgmu/XR5dCz7giilKzDL3ps8LO1bts1ua88mL3cJpM3/rZX0QxJqnivzRkz5mMniDX9YjDda9oLxGzzpNXldIiuewOdJXDqeyc+tO7WcRNS8TVqR+w6uF6b0a56KXlNHtDn83axaVnS9ScHgocKEs3L1X8AIKMvlIyHskWdNItWz85SpKkG/5WklN2EuUGhQSWS6j2TzKvAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QERV20LxcrFTloziO0ki2Q1sUsjvi26oAHYsGF7hvk4=;
 b=o76wABL+MJ6yIeOxzXoFk/1VtJncpNt+YSlqLEhtlJ1NJDcAJ7o6of8Bk/pJUjCBJkF0PXjW13qG/UKNTp1pPtpAknXMmTgLi3xFwEEoMVkoDmovyu7EDil2vSYqf9iqsUsqj33KrzGxs90EAPnstE64ppN9woMPR4UzVteuldY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 17:32:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 47/49] drm/amd/display: Update DCN303 SR Exit Latency
Date: Wed, 12 May 2021 13:30:51 -0400
Message-Id: <20210512173053.2347842-47-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad8e834-f3d8-4bc0-1c4d-08d9156bcec2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4567A6FA68F6BBE470C980EEF7529@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzHMdgRO0RvselF6J/3tSRaAyHXbAUHc0NCMyXI6rbdypeIrvgOJ4LzU2KqsMo2CT6U8stYTNhX1VMuEVrXvqjtY13Uqn62gJas6RwpOqWlEdAvBv7aqoQspnp7we67WvTGVgMxPR5NhwEL5btacvuuNwGRtcHLW9mmCZBs/hpiDPEnTRdh6J8yT1syvjbKxW2Vd+OdFrnsuKttUvcxb7mbTVi9GLuBKYgKVryQOis7N8JcGOOnq8Xh4XQDongbKQhh/A6A2faY5mfU7ru40yJLC9Aa6Q44Dcx1t/ySM5mf5EA894wU/pA3mxIFTqb1io25lWYiVdAHVCjkYI4PLXNTHEVHv/G1rHauuzFaIXEhMJpbtRIhm7XBgR8MWDdzB6UtGq9yv9UsUMybmddOmRfuF/QZf2RlL1Vx3F5G+quCv/DobOHEyXAV7aa30aqG3lyY0MWe/94PnsYD464CF3Cz89CKMNZjTDfpbHMaBshRpQ8ht3p4sSjXoxQA35Ce2xwkTU/6YXjtSJY7/TedZLbysN+BHBE1hL0VyShgV6h4v72ycehJErEdElmnlWdI9oDGTEtyH048sPBvMluS6g4fYwnsmftT52rtoh4S/CJQsF+O8coIDy3GbW+Rk1ljfk9IgDnZf6/Tel5wc5EvS9BhrDa6TB8Ex/Xb49FC5DAXm/wFRR43Mi4Hzn2DwmxJh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(4326008)(66946007)(16526019)(15650500001)(54906003)(36756003)(5660300002)(26005)(6486002)(186003)(38350700002)(66556008)(66476007)(38100700002)(86362001)(6916009)(478600001)(956004)(2616005)(52116002)(6666004)(6506007)(1076003)(83380400001)(6512007)(2906002)(8936002)(4744005)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VTbXJTvDOJQ6BVjx0eTP8f7d5TqdxVg1QwVGTBqoVhrzs7Y+tXh0WmeYKLo2?=
 =?us-ascii?Q?xYJcC7SZrD0slLdy054ljQirMslXTQz4anOKYffJY6RsxiNE2pueySvW50Yw?=
 =?us-ascii?Q?iQhPXP7KMKPgD+dfAwTwZu2AIY83RgCqbrEt5yVWsDtcJykENMP6oHuCi1uG?=
 =?us-ascii?Q?iIKZcEw0h6mLGbq3PWvlf4yXHA+GWsVNRII6rZYlhtoeuU7P2WmZW3gKbAO0?=
 =?us-ascii?Q?sf08pNCG9gVU3SlwasCkLIO8OGk8C7s5UC+X4X/mZRW5wyqYz8cpCSmKuHBS?=
 =?us-ascii?Q?nTOT0m9e7UxHnPmFcgd3Urp62I5OCCldrDMMskOtfV8FkHT0bfI91lvEs3vJ?=
 =?us-ascii?Q?E+BH++6Kq4FbFB0/X+cy21vF9K0ex9vCY9CZdzD+nc/R4NYQHS1cL0i6krvX?=
 =?us-ascii?Q?owq57HquEl25iH7YmJSmyHmccHh1AwwJtt96PJNdj/Zr6qf/ZPsgCC5vom4s?=
 =?us-ascii?Q?odFyFSRfuWXnl7UahTrqSIkcuCXqUkkwO8ekBM7tum1VoCrpgZsQ1o8jT234?=
 =?us-ascii?Q?sZPcuGiXR4BuGNvTI+2stc9hih0ZSTSDGKZiNv5/eySN0x0ZFD71sOnPyFVS?=
 =?us-ascii?Q?lxWI3Dn4CzoBp0baXFcI9/3iQLPeuTl23qG7MSbGrzHKs4DrbwQl0RFDtD+j?=
 =?us-ascii?Q?ihaUrjO7hEWpvMYUO/0zw0oz7Or9ZVJn1KOcb8fmXhyyS9/AIZApxWGOTZZ6?=
 =?us-ascii?Q?AT2IBBf4TlFiSGNV0nDXqzKqfkb5E3jY4sD8JLwB7HExwypEyxoTKUHW1sVf?=
 =?us-ascii?Q?tPzwaFMds1vCaWQpmasNix7nJq9YKWmlQJ2RnS8/P/MvEXNfJzfGXEV4lWzT?=
 =?us-ascii?Q?aFInOJ+y2GyXWQrB4t0b0QxQqpLsCKipaCGxNbJr+WQ9JSNqMme02BBOChh9?=
 =?us-ascii?Q?SlJ0upQGoelbhHr8OMdBOVAaba2ASaEZY1AkNYBQt3JZLlLJWJcskIheCMjO?=
 =?us-ascii?Q?V7Kn6i0ri5EXzNPzBDQ1RdoPzHYpVfRFvKblEOxd5Jj4ZwdbqWi8JF4m+K86?=
 =?us-ascii?Q?+7Efgom/EW8uBCAwV0Yzvve9FBAOqGmvStBdHrcvOSOWH5EevJNBfBHnCjow?=
 =?us-ascii?Q?Iwuy7lcerx2/wgo5LGfdyo5qZE6czzV+LaOyOSNyn4QKBoIt+u29FtM759cF?=
 =?us-ascii?Q?C4E4atbjUw2VqzOb7Nm/ryH9Hfk1+1/K2Z+BUhXaj9BAAqt1vqSI7B5mRuwd?=
 =?us-ascii?Q?b+1Vhe0Uq1OnbjBuT/iX9s3oWctfrT/nkcQFYRX9YHm+8R0wA2+aMEPKuCmv?=
 =?us-ascii?Q?A+tmeJ/TXrUxP5XhS09AwDe9kPVhmU/KJKaPpvpCi/Qu4OGun41FmOURjH+n?=
 =?us-ascii?Q?SMcqJqQW5OHxsjAXi77oIqNX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad8e834-f3d8-4bc0-1c4d-08d9156bcec2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:42.5989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8JKfSyhqNUL6ZBinb2fayfmnjuUYR+GTnJ3is8S73rZ99RSQIauvH0caPq7c/4oYBqxJfrkoPdEugewWKocvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
 Joshua Aberback <joshua.aberback@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
This update was made for DCN30, but it is needed for DCN303 as well

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 59548a6e1a50..5bdb01d2095e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -146,7 +146,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
 
 		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
 		.num_states = 1,
-		.sr_exit_time_us = 12,
+		.sr_exit_time_us = 15.5,
 		.sr_enter_plus_exit_time_us = 20,
 		.urgent_latency_us = 4.0,
 		.urgent_latency_pixel_data_only_us = 4.0,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
