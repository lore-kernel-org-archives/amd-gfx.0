Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C5C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3D060FE8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C3D060FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB0F6E069;
	Tue, 24 Aug 2021 17:06:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F7716E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fk3K5M9qGiTtgP/708nlL2icQbtHJ1hOQTVf4rP2QhYz2Nb1ayZpU/xwsH/DZeSqw+BcvQhrMlmfQQfpbFQzToKTu6cOLWNLOYVCDxlf5jEaiBiMjdLy/neC2vDtwVgkkA377OsXgFqqwV5+Jk1GPOc/e8nu+1TJM897nhANCF4WsJ9o6uOoB3UIi0BF7mDkhpKgSb8FahAS5rcb8lHC+e9xP/kN0Hn04uUhyFwgdEyh2vOhoUTj7P05FuF7Q+8PT9yUzgMO5mIcltHRk1Tmw/9P5Ii5q8BRkd8EMAAiWaUfWQXb+8mToprtopZoI8QIIE8EZ3Q24qvo77ZJ+8ZPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eG5eLn3oILucJg02BWnX/EfofT+aFb7aSlzupyIN/o=;
 b=iJ0N6yJ1g4rYzgLSqDJTzIM+D63PACZQMUxJ7K2V1se8qkvWYcyXCLxuV/+y9UsutoBzEVnyORO/kajTvPZ13t//tm+3bc78OiTGeaC2lN5PyN8yPTJrp452EljumKnDYpruBxmEU+IOtyWRsKOi7bmMi7S5lHwLLRncIB7Xbgtb9Iq2SSHgAFSsclqq9tuUH34eREqMGAfDwUz9py83Kb6l9WDR+cFoDbhvi+9QHBvLYO8hkORxU+3NPOjwJ5MnaNIq+osjJqcuhL080waf/nRM9wSK1hxQlkecczmPT7W9vVn8F985FKH00SRVYMZsUymjATuXl3wHDDcT0g1Dvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eG5eLn3oILucJg02BWnX/EfofT+aFb7aSlzupyIN/o=;
 b=21D7A9F2cZC0dV2/n4lYOUy5DvaqSBEGq83iFsqhOG7nO0OdhfyqRAkdgtfX+IlqkpC1scXvrzE3QctGit4xQI0sCDXBsOH/pwb7+Rpssa8POBJ9LCEr9bdCKCQke2H32QBXu5PBzT4Ki9GL/famtYifmjblUmRRZ2COi7ntACA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/8] drm/amdgpu/display: fix mixed declarations and code in
 dp_set_hw_test_pattern
Date: Tue, 24 Aug 2021 12:50:58 -0400
Message-Id: <20210824165105.1913700-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567bfce4-d1f1-4b44-e4c4-08d9671f65e7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50454C9E2EDC5BA8661ABF00F7C59@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydVCWku9CaIEMy0byNfd84wT1w0rCciRQ7bsGEdTAd/8tJlzUgeQnP35uV0wixZIAf+XXclUGWl3msSNJpRSOcLW9agx+oK5S7mCYK2ZPtP+OOtYCv8U09ZP/sNeaoZs+sa7cynaNT5H3su42k1kwA48998v0NIbBbaYP2+LZJrhqZ4OwOuAX+bc5WNzpFN3EO6AZ28JBDNoDaDK5z+pwifexcGQ6Vito7aNpqcTgLa47yvfA1bUsKbwi8rCaKldfIC7U00JbKiQI8M0e/9REV0GdCfPXKYUYp7v/lYkM/V1jrwOFRbRSOlcZkkn77dhsQeCQE7f7+mtznBEbdSiFS3DPjP94uueY4E/W5VDTAuAaB1xuhlVIJ/Y7ziomHeaC/Y1OF4HC95y9lYEtmerSHDzjAezkbeWdT0I1ue6jPuF6N5rzQFvt3TuuhtxodgZx5dbcEEQ2lGnFFnFKIG+ZmrYtfYhlyEcTiSGZVkIvzi2H6qhPloEYdA10mYXJmIVrEm5Ne3FHx0XDgFCntQqEKWlR6NdOyiBgP5lxwhTi80J0/ewUN92kM26iBpt6lZA6fOnc8GyVgwn/M/2G6nkJt0ZFT/J7Lxzwi/Pug5pwbZtc5lU21RWULRcfPxhXX0JfzLxZDQenFPCGJ/RW9ix5dOYpIav+SEaocg1TzAJx8CVnNjQAhpAoFZ80AgJV1Gq2tZoFXBbLqOw7zp/IoZvhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(8676002)(956004)(316002)(8936002)(6916009)(2616005)(2906002)(38350700002)(4326008)(5660300002)(26005)(186003)(66556008)(66946007)(478600001)(66476007)(38100700002)(6486002)(83380400001)(36756003)(1076003)(6666004)(52116002)(7696005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5fIAfl3anlw0bk372rXvcp6Y3XmSBZfgNUHLlO+DiDv+QrqllRv4z9WhOV9h?=
 =?us-ascii?Q?JPfLzVOu4WzmGLfOsVL1wmfrE1EHJPIUwd59m8A6m4oVWcOKx+PCE1eMZnXC?=
 =?us-ascii?Q?XDco+oaLhwNjZWX8wwjhG4fue1BGGoKvKmhGpvuNBN/vfeKHRMwtKcpbJ49g?=
 =?us-ascii?Q?ZT+gpDwIwZP1gejMKXFFo7YFMxV00dwyvGPGIFPj2TilpDpDGTR9Q0YrpWtA?=
 =?us-ascii?Q?gzRZZ6YGiDXCWl4VfPfj3nopS5u82bnBCjlbWzq8bMhquMl26NLJWhy73xUh?=
 =?us-ascii?Q?yv6mlHQ2ArJ1m+iSy1NyiOZgR2N7vB7jWg3AxTycKSi0nPlGp809uiqt2BfX?=
 =?us-ascii?Q?fGkcgdPKRasG4JhcBlTuPrmQkHeyRGFvEERDhyy6FUHPN5UdjwXsB0brrDe6?=
 =?us-ascii?Q?dtvwMLQxB0kcQc8dG3Hx/XTqoh0znxJCcT0G7asboWw+hW38NesQNRrEqdMY?=
 =?us-ascii?Q?JuIZX9MZe2Bq7DJzDcbWqhSQQthdDj1Hm1pRK3hsHciKia8c3N2BidNImw8k?=
 =?us-ascii?Q?m7XYxO1i13DVgEE+SBCKyFcs2ZplIEM5VVVyPw+UE9O57Nvp49omP0ktFEaL?=
 =?us-ascii?Q?JYgYIqtVOxgfrR4NDNlYoWUV2tvavWvDpwV/xRTJHufn2Ku4EuABSitzwUTZ?=
 =?us-ascii?Q?jyuXBsyre6sNrzI+e7XCfe2wEdqNwjjZcKJmxYDf/0D9OpAamcFo0+9lSLV4?=
 =?us-ascii?Q?t7Ls06RGDmsqHEz+YHS6Kdef5PiZhCajI37j6QrjHDVyVaoVODqMI7Bb33Y/?=
 =?us-ascii?Q?e4Xz0RGyxIaF7JDYOtMeLESDPxctHe1bxRerz7pooBUvleq7NtDAyKQIV9qi?=
 =?us-ascii?Q?sUphu3+GZkm3SYFf7yHhfSFCzXE3R2A71H7hT5yLa56MSGLb8b62HnmU7fut?=
 =?us-ascii?Q?+yGdl6gDHlkJ3GfkDAGffo71wDlN+3K1HYLy5QxxR2fY08HC0wQ8D8r+M2v9?=
 =?us-ascii?Q?T664fT8tTm9pig2u1+hi3+90AQnF/MnWBRN0f1630cqe9hOd4vsFwhy+AUB4?=
 =?us-ascii?Q?gfcslNDLVLxXWBtKJvIjIZo0s+PhtYWQfEw+nDTI+18VEfgF3QMVTtVOvxHj?=
 =?us-ascii?Q?9oRPqhSLrEClxIUTHlpUWwGuxWxT0UcS2hBy0AwSHMuumiGaMswprThRu6oQ?=
 =?us-ascii?Q?2CLMtn1OzWd8Zub0e6uDwuM52RDrRRJ0WM5G4qBy49S3W3iTraBl1ngCYFHs?=
 =?us-ascii?Q?nQ3Ojz17ubv/4h575PvzRlW3tiJOvjNgunYmEF5jVn0djvdfXgPwjrduulom?=
 =?us-ascii?Q?mxVgO3EltLlJ0FuaPrixrO+Vz34P3FfJGXNQm1h5lX8nMq5GS6W+Nzyzh6DF?=
 =?us-ascii?Q?Gx1yPAhxshJzEw/91/aJyFYE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567bfce4-d1f1-4b44-e4c4-08d9671f65e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:20.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA5goO/asksLcn6H3DWBj1UxbwN+eHtCW6mTtQlCpKkvRJmqz2ICZhSkoHoJrkkv6EsYSzMuF037eIq+e9ox2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 0d3800896333..97de1c5ab3a6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -372,6 +372,9 @@ void dp_set_hw_test_pattern(
 {
 	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
 	struct link_encoder *encoder;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	enum dp_link_encoding link_encoding_format = dp_get_link_encoding_format(&link->cur_link_settings);
+#endif
 
 	/* Access link encoder based on whether it is statically
 	 * or dynamically assigned to a link.
@@ -388,7 +391,6 @@ void dp_set_hw_test_pattern(
 	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
-	enum dp_link_encoding link_encoding_format = dp_get_link_encoding_format(&link->cur_link_settings);
 	switch (link_encoding_format) {
 	case DP_128b_132b_ENCODING:
 		link->hpo_dp_link_enc->funcs->set_link_test_pattern(
-- 
2.31.1

