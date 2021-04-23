Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA8FC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 20:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D29B610A2
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 20:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D29B610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263FA6EC41;
	Fri, 23 Apr 2021 20:49:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B16D6EC42
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 20:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKwiJded7x+Xdhar+dlHwWpeQHmuZ5uO8js8Kc5r4IMDeAYFPh56/SMlPljAK5dXQ39WmlD0Kas9AFt3WpGYYWlkFo4ux7rLkK/RpIn3fDsScveVe2rW8aH0crfTgqKQJHr1elsa8Ukp/2FP6FPQxmQZqOcvljHzYhCQmkNy8ViiXp6a+htyS8lSMprPpcZo2GEciTmMDdrdfF45wDj9iWCD9NTtmcmCS3Ud+fL9ptlwMV3CAjf/9QZxi3oRPh7SzOjMjJEzaBbGM3ZxWEjzKjKgeMCOXn3Os/XQCCGjCnun7x4KptU0M22RiBlYqoDTBfmXx9IqRr/3d9134ULifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QQcI4O6ui7qBrTLyIuKGy5TN6qOuFyKU7JYV1ooi4o=;
 b=isnKcP+kVBFSRQ0Qxz/PZ7+XPf8uRq/wLgp1BRiGwil9A9w7iDaTDIH1xmDVJHWYb9jKEs/53M6+FNKWHnXp7T4COV6ep2/FKjkQsig2SIY9WzYRwJG2vmxWJEFHHOBsEPEgQL5xJ8hckiPAFW6sl97Oz4EpwZNOTOMHik7q6YR0LSdHWDlXlx7+j81s3KToIWVhXuF3fmaIEqEf0XhPUoebusZ0vUqRes8qJ3mG9j0Jg85GPg2B8ma2p5h8ItDg7ZDYLq7elxklo63r1J8i64pNjCG0NbGP+AkSearCkkPryw1QL74LKO/xt4QHYv9sR7lbZYCKOg5ZXxHARhIuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QQcI4O6ui7qBrTLyIuKGy5TN6qOuFyKU7JYV1ooi4o=;
 b=xc3dsTS6gCtha8/KE2c1E50hu+dDTX1LwQAqzhsTUkdvDrF7Jv05kWN/gUyMTv/36NFtdY5OmEDgicClsPSW9O8RGm2oneKOUSPCOT2c22CTJ/gUo38ISeC7z2QAQbkezlzWHax0uO0t9NQr9oeXZxeYLMk0A9RGckV505w4368=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 20:49:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.023; Fri, 23 Apr 2021
 20:49:52 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: add documentation for
 dmcub_trace_event_en
Date: Fri, 23 Apr 2021 16:49:31 -0400
Message-Id: <20210423204931.428241-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423204931.428241-1-alexander.deucher@amd.com>
References: <20210423204931.428241-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.19 via Frontend Transport; Fri, 23 Apr 2021 20:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e7ef91-96e3-4bfd-31b2-08d906995785
X-MS-TrafficTypeDiagnostic: MN2PR12MB4160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4160AABC08A11BA3073DA9CDF7459@MN2PR12MB4160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Uyo/56d/SaQO74X3NDqEu1bNBhLHSbaNP8lxRfPU4jY1tfhJWkBPQzg69oU55y/JV+kcLJMRquOnKxomigbVECGY37tthT8W2PwUOdtxONmFsHgRTYrVtOS1ji1b/qZLz9U9jdUjy640SsMWeHghMVIRjij482dAINtBR72VAt9AZFZ8keJUZ6FNuqk9s6Gp3AvFYJZQ7ZWVLP/cal4UxQKVbPJbM3jOaMydfxcxboc4dfz3tVgojjM9b3qyNh95avFbITgpUipIjy4LvsWJMThbxl1ltXTC+rUQwg+O4ifDHvvwY9wlbrHvDqNv2oD6Fy6nfuXTX+oRsC0hN9pboHO9mG9+KsvWThu0nZ3Dlr8gIUaxvOlgb+aEwIGx8wIvpMha6aTjuuR8t3q69bpCPP8cHwBv7SB4EYPgyVWtLl8uo6SK3geAKuY3BLAGAKmO2Ducd8KLKQQ+N8CWJGIkx+U51A/nN5jPkZtAHF52N2kV4HXdXfQQ9uDk1NGAuie0FVRjkmRnMww9h4h/QgnNn0lhKF+FHRJ7IRCBlmmMgt9d1ayZaRztglCk11bH++lcarJTzGC5TkCWSIBFKqyFfyRjMmznz9lOm1ftlkCDVgjK1YakZYps6m9bOioL95wgWHARTuhlD+E82exT1XXWyxd0WP22AYzfWRUAz29uqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(478600001)(36756003)(83380400001)(66946007)(52116002)(8936002)(316002)(66476007)(6916009)(7696005)(4326008)(6486002)(66556008)(4744005)(8676002)(26005)(16526019)(5660300002)(2616005)(186003)(38100700002)(38350700002)(956004)(6666004)(1076003)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7jLUdoyYYW9ZhfqAvtVl0Ma5/cxVunzrf8CWOVpMFpqa6ysC1r6fjXOMd3av?=
 =?us-ascii?Q?OGUhRdgTVvojyQcw4cN2UfYlspDF8MCOJqDt1ya9GcyZoAqd/l9841QDmS56?=
 =?us-ascii?Q?S5p6IdzWsTRLvJrxcDRKnmcQbA6BapOFRGhc9a2SEMGaUbRIfEoOAP5NiLYb?=
 =?us-ascii?Q?r4Dp1SZrptcCcWoGQErOSppmsr4syXQb7/CGdinX9z7T99QAvjJSx9rl/G27?=
 =?us-ascii?Q?hS7Nosq6ZZZ7wpkhYfk51hqFAEL22R3gzFv0RXGgZuKRsv9kMsorWHUa1XWr?=
 =?us-ascii?Q?91XGf3Hw3mLREFybHDIKnoIC+X/1SJrJb8Juw38KyVlFelZhbznbzBGxu86r?=
 =?us-ascii?Q?qRlz9HnslakQ/dhO18uFPI/KFcATVLfhRTIX4whvPFQAja3DUCe9/OumO1Ku?=
 =?us-ascii?Q?aHYsi+c4D1IgoQZ2Wn4KrFNrVZs7EQyyqeXPpWi+roPseXwE9X/BKWCqq2cI?=
 =?us-ascii?Q?R4gY4wJ6Gsyn5cDEPYpSbRajxXQO/JxOpwJv46LyIPZSlMcerE7IYgx9hpvN?=
 =?us-ascii?Q?o55ioJXOoB1ts+qZHaDmPbowOo3wwg66+mSnHXcDDIuMJZq4je0ryfVdXZ9H?=
 =?us-ascii?Q?XQTh4yIMCQlRls/lrNrFXPKbjlYwfelpqCYmDFJlV3NLh7oqzn11cyivsnqm?=
 =?us-ascii?Q?h56/z0buw2DQqbPJY5Ll8edKAE1LEcmvT97Un71e6KR5EBFP0i4m9tE3ASG/?=
 =?us-ascii?Q?G7MrJGOySD6aD5GUyIFln1T65a4hd81b5BF4lCC0aB0/hxnS3Ag/CCYVj2O5?=
 =?us-ascii?Q?J9E2LPNgr4vdQhxEEhdTDbeQLUuMA4lzw5B21Pii2nZIy161xNsbMWG8prw2?=
 =?us-ascii?Q?axycpbvU+EECn7HDOeL/w6ngug2OMOtY6Fl9WczptbPycAlv5NCq6a9cXBQB?=
 =?us-ascii?Q?DsuI/f21D3jevkse4EdBuCC58eSRcVQ6eVdxF4rT9CACwnTUcbOP6kP2XDZu?=
 =?us-ascii?Q?6P9sHBrsMo5ZVYgTLtayseGNz/Qgijn87XeROGgoq541k+AnjRFMcTHqgUD6?=
 =?us-ascii?Q?TyjpQ338O8WnSEuXvxjRTw8ye4gxK8Glvrv89F7C7AmiRjqOkQi7fNt/S8cL?=
 =?us-ascii?Q?z0+uic03SdeZJvBBK7u/MQsZ337mFrjwHrTjcJQy7g7LybjaLqLbuxKKmseU?=
 =?us-ascii?Q?1vsXJIPjSKbcsv8kEz4IWpidkmP2IRsvUZHoTCuJ63AuWWGvRcNOWoI+DvCd?=
 =?us-ascii?Q?yuXDEZEsEGvBpUTTXcDtgrrGgUYNkZcNM34wj6RklgD7x4++laMu5ElpQpll?=
 =?us-ascii?Q?SVFdSkLWmZFYkmXlBPHi+zlILB6EbKnSe5tSksWlQpNeTBNpZch9QylZMJMr?=
 =?us-ascii?Q?usLWR22HIsuG8Pz8QqbG5B4D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e7ef91-96e3-4bfd-31b2-08d906995785
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 20:49:51.9776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov49SIdy1EHv3tW0OzR82AqFqFOxolLcAyO8l1RQgwoGpTj39N3cvtziLq28X1pBRm/HA/0qm77/2mvT+Aqyww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

Was missing when this structure was updated.

Fixes: 4057828a1283 ("drm/amd/display: Add debugfs to control DMUB trace buffer events")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d6a44b4fc472..fc13e8b6ea5c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -168,6 +168,7 @@ struct dal_allocation {
  * @compressor: Frame buffer compression buffer. See &struct dm_compressor_info
  * @force_timing_sync: set via debugfs. When set, indicates that all connected
  *		       displays will be forced to synchronize.
+ * @dmcub_trace_event_en: enable dmcub trace events
  */
 struct amdgpu_display_manager {
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
