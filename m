Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B16C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF986069E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEF986069E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 949106E12D;
	Thu, 29 Jul 2021 20:37:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98A66E12D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTCmwKqULgSqMyLDeKH6aD5cWDkjdJojA2/hQyhYOPpbjT412Z14GCtV01aOnLPrngLheinUEL1AcjGw2OoWY5OPzyiclOG/wgChAT0baP73iFQ6oonWlt8uE69/zjDxNfpl75Zu7Qf0gwspaluovlMhadxGw4n5SdumNF1lHGdr3QBnbOLqseywmtI1Oh4v1cjxxkl9kddr6GkkmKb/Q/1TwG+K9PREGVPlLL6lYWGvWfwi5uFcM1xZU8gN+p84Xtd26s7bsG8cFeIBwsBjQFQ5eWHKDCeyRG+Ft7pM6e/2U2yEbwjwpISXGypNyjy4UthktW8xqvvavH/bHqmoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgWJ4UJOTIW6ARCM7OMnQBhD76/NuHTNkhdD+k6H+Sw=;
 b=mcPjPpbvxK8bIv8xtZPf9qvRgmYUHf1QdCL/QpOh9hgFyFR22id/UlSpe1hKV1rMD7okkQK8LcZhEr7EFsQtGRuIt7T3zc9LoVH/gpd05wPlPP2NWyYa/v+/wkCjp6GhZgRq0EKjUzsbktu41lbnTE6dcc1k6U1Jvyj4t+XenThti3RhZODrtu6Aa6hYEUb+JB4vDFRUdTHfUqUmjWrLxS2BiUkCQJsP4My76j4T4WYQahSx4YOdeQmNjdeH6vMnrQIYNlHUff0H5cdS5cQBMuqxvLJoFPZx3m8SKh5qp7oFsplyx76zVYfYsAyv7RgKAhXDhGlfPon62Ytc6sWY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgWJ4UJOTIW6ARCM7OMnQBhD76/NuHTNkhdD+k6H+Sw=;
 b=BxZ8gUhscYSu/wYJJBAby1yTWLi8FEkX6OKMN+IZFyup/B+BPKJW/248cwPJJaCSItdxdHYawJRfE0QMSqwpvZgrK0W7+QgLVnF4ihhyQv75QDTxfbCvQDJtQ1YM+XkBN7YMHCSvN8t4DDPRHDWSlIFSbRuOlX3poaADIoLDD2c=
Received: from BN7PR06CA0060.namprd06.prod.outlook.com (2603:10b6:408:34::37)
 by BL0PR12MB2386.namprd12.prod.outlook.com (2603:10b6:207:47::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Thu, 29 Jul
 2021 20:37:13 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ac) by BN7PR06CA0060.outlook.office365.com
 (2603:10b6:408:34::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:13 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] DC patches for Aug 2, 2021
Date: Thu, 29 Jul 2021 16:37:03 -0400
Message-ID: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7d95c72-97b7-4d2b-8ee9-08d952d0a5c6
X-MS-TrafficTypeDiagnostic: BL0PR12MB2386:
X-Microsoft-Antispam-PRVS: <BL0PR12MB23860FD30B2655411985101B8BEB9@BL0PR12MB2386.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHpWN6uZJGv3GELgBh7HEOpXNfCXOYA0idhZZIbwJmo8daDUZq3GcLllwTWvlOEot/xd0W51cjpId2u3mDQMYGTORIQZfM4T/xaD/6KYbbpkUubPVXejbFTYTfdN6+TtJtgHRkjeSRNwwHOl0yUW2D+jyKbh7n2pDImcIrqJgK4+K8apGRvO22zmFfjJCFydF6CvxzJUtRjBkknQTlZEZAiIvGPRMuuFcuosqI6NnTRTSGVyCX43FIA/jeFphXmT6MrzGRyvVWVHA5+bEqvKbvOmbMgDNKDJKD4YrJhqrcQstIpSwnPLhXstOh/SIWzWJChtLEk34s5lFcBQ3TOlmI93HpQlj3ugSle8pG7w6xg8NLt6H0VMxauJ2IsFVZq4egpxUl4biehuEzynSH7mWn9duY6VTO/1Rzc+iEuq0MVa1DALEFbz9grLD31RYhm8WqDldGELXwo8EieEDtKYWwuwR0AjPhnB9j8CJLaLKYgN4Z23mBS5rLTskcc9SmzVpGbX3cGUjszL5KpXcF/b7fRU2RKIgAS8cYkVDhnrD4MTC0V3C8XAQCtZIkapx4H3BOhIkWi1ytRZ6noieRxiVdgXKAI1bh1xvuko9TqKff6J9YQozV2a1pyARcDcJNmv8PMJx7FFw32mSS91kazMeaZ2J76+qXMOm1OvUg9hqpI3TZUJ8SUCtkRs02+Frb4IjlQVXO743UHWQYH78+LJOCnVMQs0cguJ9H/b58jM51s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(4326008)(36756003)(70586007)(70206006)(6666004)(8936002)(186003)(26005)(426003)(2906002)(44832011)(86362001)(54906003)(5660300002)(336012)(8676002)(7696005)(6916009)(2616005)(1076003)(316002)(82740400003)(82310400003)(81166007)(47076005)(83380400001)(356005)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:13.7144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d95c72-97b7-4d2b-8ee9-08d952d0a5c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2386
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Its a small set of changes this week for DC. In summary, we have:

* DC version 3.2.147
* LTTPR, MPO Improvements
* General stability and bug fixes

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.77

Aric Cyr (1):
  drm/amd/display: 3.2.147

Bing Guo (2):
  drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
  drm/amd/display: Increase stutter watermark for dcn303

Jaehyun Chung (1):
  drm/amd/display: Add check for validating unsupported ODM plus MPO
    case

Jude Shih (1):
  drm/amd/display: Fix resetting DCN3.1 HW when resuming from S4

Qingqing Zhuo (1):
  drm/amd/display: workaround for hard hang on HPD on native DP

Roman Li (1):
  drm/amd/display: Remove redundant vblank workqueues in DM

Wesley Chalmers (1):
  drm/amd/display: Assume LTTPR interop for DCN31+

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-----
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  4 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 21 ++-----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 20 ++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   |  4 ++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 16 ++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 ++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  8 ++++---
 11 files changed, 61 insertions(+), 35 deletions(-)

-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
