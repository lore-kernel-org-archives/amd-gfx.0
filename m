Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC80C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93AC61075
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93AC61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C716E9E7;
	Mon,  3 May 2021 17:21:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80A36E9E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 17:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq8aW+qHZrCEReebNPrCYinDMXd6xCF4C+Km/i3fqiBlbRizVDATf9XAUizpRGW7XuJLfsFpqSmvDk0bch+2tfEGDRMdPpCRSFZZyo/sV7wytzcLvFTMuWsKVlf2mDZFExvzGTfEscrx2JKW8DFpikLuf2fjAZO4izNjzD4DoZkT9jgNyFkC7+wzGwESn8EBLe7gZ9GL/kqdnwLiD3P835+3R7rHFluywOk5PVkJXF1CuKpsFXdk/zItGepU0cE2FYOyZ/YOmYk4ocXM/eLz2/mfXUw98M90iapf1kJygv891TiCwmjROWWTLNa76q2gpBzjDutz9uUMpJ6haP7RpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3ZamuBBa7h1Y897maXaodW0GjYaGfZRzCPpKtZHXNI=;
 b=XlDI/Cil9gMvbB2kNw9XCqZ69AMt687+wBhz2t8qMFtWr3vzybgzk6Z+XuoDSaLw1pdM2+RtiEr5v6RnQlpW5xBfcBoMA7mSvJHY7fNF56VEsZrQR+/no9tXF0t06DitbJg44mDFEj7gWjnQ2CSRnj2hp4N9mw56wEMZTg/E6KiBeGEAfDeifKOpVN8Q7aTJtpRKvQEJqfq51n+piNBDbHCO6xG1CZy7qhiyc58lVudQ3ABdTYiiacCNE7MOnwk94yiDZ4gALlazXgSC7mvKUlG77/DiYpAYMXATK3bZukgrMoB7xzIAJLeHE+2rhZtftUgY7+Qf0+G/P+YNrgdZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3ZamuBBa7h1Y897maXaodW0GjYaGfZRzCPpKtZHXNI=;
 b=iCunyjsczOBuvUi78JiihiU8e81eFCFDaPagHF7G5TnSXNaC227IIrCqkFSfufmUn5RkWpA/qeJMKZZ34QivG3H3oxIkD2HPPrSswPvm8ovQ3NbQiP8On6HN+9NL/WbX+tu+JxJPiyaWC/r6bir7/RPaVcoFgwMrLFTFzaqUY4U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4676.namprd12.prod.outlook.com (2603:10b6:207:19::30)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 17:21:24 +0000
Received: from BL0PR12MB4676.namprd12.prod.outlook.com
 ([fe80::50c7:783f:720a:239c]) by BL0PR12MB4676.namprd12.prod.outlook.com
 ([fe80::50c7:783f:720a:239c%5]) with mapi id 15.20.4087.040; Mon, 3 May 2021
 17:21:24 +0000
From: Nikola Cornij <nikola.cornij@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v1 0/1] drm/dp_mst: Use kHz as link rate units when settig
 source max link caps at init
Date: Mon,  3 May 2021 13:21:08 -0400
Message-Id: <20210503172109.22877-1-nikola.cornij@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To BL0PR12MB4676.namprd12.prod.outlook.com
 (2603:10b6:207:19::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (165.204.55.250) by
 YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Mon, 3 May 2021 17:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b823dfc8-a758-46b9-59bd-08d90e57e09a
X-MS-TrafficTypeDiagnostic: BL0PR12MB5010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5010F15E2B8894054B597004EE5B9@BL0PR12MB5010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rU0rhks9k5RLZpa+4d1kYArv6qXGCPFIKEUTU9QroR2YzbBXswEAf4dZ6VmzbI2++Ub63UhDYVhlZ8Z9XHsg26F8xkq8f+2wcwpF1DEu5lFBNcUXvCGZNBdBlPy36RP9tBLaqBVNcOLjfWzoueb7yJYRRWreUDz83PjmSuaDDuoRKe6AaecBPo6d0s8fXhh1lIN57vJq9nChcbZoqWm41sa2ISxLqxSATL60XsVKVzKhHMAzk9ZYPH5LHBlJs1FM8o+L+LjuaGK/SYypXIEmEDaroaiTJEen1q6xrcADUDHE/EW2HJBECrR9kVVajkPbOieRUX85c4o9FTfb+2YzIvaeXrZY6jDxlyAg53qzA+75+zNnjVObv/WwEzWNzisAjbKV3/NKkN2Zhi1F/rYVxjfl6vEAWBjirKqAbXpBSKbNnBj5j8U6JnYBJiXRtDuMsV8TtHRINEl2M3JEQp4GrgHpQThK2kYg+R2GhnhZkj0MZBIUm9zeJ61ig/MMZd72c7l1H1xUyPnaoP/HoENEhblhpHQZB6kiwzCct5DnuLpOQ8trjXzG9dTBBhFpb4+jQSvxARzwmtuHISUs2uXWb1wqcijU5TJs8zsZQP5gCMkY9VpqG57UYzfp2LP4R9HAuJZL29TY9UYBFnQUQV5oTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4676.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(316002)(2906002)(6506007)(44832011)(8936002)(83380400001)(6486002)(4744005)(36756003)(38350700002)(38100700002)(6512007)(86362001)(1076003)(478600001)(4326008)(6666004)(8676002)(66556008)(5660300002)(2616005)(66476007)(186003)(16526019)(26005)(6916009)(66946007)(52116002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9UgBcaJUlRTEGZz4F5z1v53MupZkl8NZX/9K2vfoyQz5pn+CnZWj2CfaoSpF?=
 =?us-ascii?Q?hDqpmQFNBS3tiuHraI6SKJt3tMbuhD0kBPGZQeAELCoxanL32pVNJ+aoV9bM?=
 =?us-ascii?Q?GKcyH4uOU6H9KN/3dO2JJ+Ab5wYDTxtymfMx225ugxmst6+CwfLtOK2vRloS?=
 =?us-ascii?Q?4an3HAUFJyjCy9anM5yLPWO7W9Z3ltnXJB9Hnybbh+B0L1CJTMFSt0UufkF/?=
 =?us-ascii?Q?yFOfV/51+wcqtw8gcf8uRV2KjJUAyGZowx9hiUBdk0r08yiuZL+7PEg1SFAw?=
 =?us-ascii?Q?Q+9x2sewD7LXv5iMTSrPAwgkV4gq0/SIv4ENN8ZJwp4LybFbEzSLMd+6phG1?=
 =?us-ascii?Q?GMSU7SOhT+HHNfWMDJgayzyFC7FokXWZuyuT4POwHXYDTAYGBuR1iBYvUJ1u?=
 =?us-ascii?Q?BbKBPDOzrDZTsztXiBwt3VW61PfzWCAZvl4jt4pvmQkjkXoIfema5OCPoBwh?=
 =?us-ascii?Q?uYqf40gFqQbrNeC0g7i0ZueDK/z8kfAEH14T+30Z5en20G+pVQ+gssUSTs9M?=
 =?us-ascii?Q?CrA2SHgqT+k8cON1CJlxD9wk3CVP4GqxW/zQTn8RU5W4BlSZmOGak1aAxVMU?=
 =?us-ascii?Q?vNaGXFyxRCMB9L8E7Kc7bf3KKAJGBKZpCD1/m3mm4kE7G2ROIG7GBZ5gooCT?=
 =?us-ascii?Q?4hXCxTVd58bsGzOn0uFqJBWE5WfqyJDsrvt0OSxZBPic4IsRb838hfz/gh9d?=
 =?us-ascii?Q?1KQ7iBlwUvBIT9v3QVkQmpBCLdWchOi0hnqelyWcAV/fuaFn/8F14KtelFgb?=
 =?us-ascii?Q?kVQG1U0//o60DES9HQC20suCUajmigz4wfKtYV0r6g2KG8Cqq4pA/+RNdKDq?=
 =?us-ascii?Q?93ULx3ZlCG9bpIM4e8275mHSYLo/g7sNhC0OrpXFWV7dxxvcokLSG4/Clrsa?=
 =?us-ascii?Q?/SeVPrAW4NGlzpD3uovr8z9kzulrirzLGTM0dKfhok3icvzk7hdUI23gIFKr?=
 =?us-ascii?Q?x/eTR/O8l7neXnVdR3wF7fPpKj1cgx68kGmaZK2cPp5smVdyjhpEuwHxnYbn?=
 =?us-ascii?Q?bv3NjOUhb1kRdvbOKeJpuhXu/GM3TvuaYiHZmfBWHqHJxPB3WUja83oYNX6w?=
 =?us-ascii?Q?2XcePpLpzA5t5rCvNeoT+db9lC6oyOK5/nPGIMy1BTQhoYWdJNjlKRp1CzLK?=
 =?us-ascii?Q?Yxz9lPHrBASeAkLecDv1hsJVoZlzY36756QnEcLGV7RgONxWpB16nltesCzS?=
 =?us-ascii?Q?EV6F0qbJpht3A81iXXtq4pmqai0xJaMqsv6RHi6cqe4Az0/GqfQ3uEBQcbhI?=
 =?us-ascii?Q?6qbU3tEVUbz/+PZwvgP4y/T0eCLortX2WG7ztfiECymqc6DnCfS+I6+8BtS5?=
 =?us-ascii?Q?P761UXWqW+p/U897xO3qviaw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b823dfc8-a758-46b9-59bd-08d90e57e09a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 17:21:24.4740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Utj//Kt44R3dorYZgWJYs1ycppKJ5yueaGj1iXR+vgf2InGIk1TmHnBgos+ZTCjJyaDZF+sWStTP89by7VQB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
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
Cc: koba.ko@canonical.com, Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A patch that uses kHz as the link rate units when passing max link rate
to drm_dp_mst_topology_mgr_init() at initialization time.

It should be a 2nd and final follow-up patch to '98025a62cb00 
("drm/dp_mst: Use Extended Base Receiver Capability DPCD space")'.

Change history:

v1:
  - Initial

Nikola Cornij (1):
  drm/dp_mst: Use kHz as link rate units when settig source max link
    caps at init

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 ++--
 drivers/gpu/drm/drm_dp_mst_topology.c                     | 8 ++++----
 drivers/gpu/drm/i915/display/intel_dp_mst.c               | 4 ++--
 drivers/gpu/drm/nouveau/dispnv50/disp.c                   | 5 +++--
 drivers/gpu/drm/radeon/radeon_dp_mst.c                    | 2 +-
 include/drm/drm_dp_mst_helper.h                           | 8 ++++----
 6 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
