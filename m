Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A19EC4743D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1820613FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 20:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1820613FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E01A6E328;
	Fri,  4 Jun 2021 20:07:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC88F6E328
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 20:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1lXB6BJjSd06CJomzReq3km/7JKd1YAF+ic/VaYU5+RpPVVpwb0pX4wqMv7lGRPji1JCpDYBG+koi7D3euL/fuI25yZ6KubTiiFj/ZKDMMIoV7BKUDCsg54cgZ2eXarS3Kmk1RfKV7mjGko6l6XaGNC9/DZbfjnbgRD5nnbC5++MqJlZAVMQ5VPvaDWHJb40RHvubPtq52pXzH15Fzj4NFDj3SMNK6Q0vnPv45AKed3/McdbjfMWtE/0emzhZguhwzWS8pJztBPHOoGfcXJDSNoPC9e3dL8MYMEtPRghETQDwf7PBz/U/SeFqdJ92C5asGE7yLbU8zMW4jwTsJevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cph2FVWDmXTHtkj2g0rBkxBN31vGQlUxT0pCHo/Leho=;
 b=VWJLVCDWPAbmZA0j1n8G9QCxpHllXfqMC2dqc1liCw9eYEENIUP6YvVA3j8RQmZ15W/Qh47N+PC/rOJMFXjF2FG58fZYd79NodtQRQammR+2IuN6+7XJsE5BocsE85558yFftuZJ4WOXhZreAoQc0QTObniG8ZPhn7s1EyF3dPvxGn6btR1gaDuGuM79TKu2egUuPG+keLJJuWPjVePbOXtNdgaKYvD5BmLWn9Z1geUW6jVWo9hU37++geseNWV+lY8q6ES54FhBfmhzOM+HmFx5Uw2oYLYRwBmdSIqlLrKKxjmLX/9bCSjJEgMc24XauNOIoj1cjz6YrJlBCVfi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cph2FVWDmXTHtkj2g0rBkxBN31vGQlUxT0pCHo/Leho=;
 b=UXaVLVuGg90f9c8CpKi9LbD83UuFl3WAGfgdek9MzpOGMGP2AM5KiU7LhqujzFFj+B1IixG6c3wWbTC0YeDJz4stefQD+FdqofEcrvjN2FDqkK8IL/0eohITwblkoxYWHGfZBsWRxuHJdiiATrdMxa9Ywx7/F+aldd+RVesN6SA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2818.namprd12.prod.outlook.com (2603:10b6:208:37::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 20:07:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%9]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 20:07:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/dc: remove unused variables in
 dcn31_dio_link_encoder.c
Date: Fri,  4 Jun 2021 16:07:31 -0400
Message-Id: <20210604200731.1480447-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::18) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20 via Frontend Transport; Fri, 4 Jun 2021 20:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f09303c0-a5fa-433e-3817-08d927946d64
X-MS-TrafficTypeDiagnostic: BL0PR12MB2818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB28181B911DA3D82B7296954BF73B9@BL0PR12MB2818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1uIf6ee3XogzL4BpvFCo5LKyS2KgSbvoVInY5P9pEIDV8ZyUkZouLZNUjoc7ArOeKAnqq9OVUfihwYhQZrPsNyH/4AmcoC4xLuyw2P2xh/LpB1m99gYH9Ivy3EuvRMPMPymPpXiXzmQY1VN9OtRp2MDEHNmBVC93ZAMqqtoPzDU4mxM8uXHtIRb3VHVaWWMFX3u4yRUTy4COYvP9XflFjsFTv6aZnONPXdZWcnPmd+r3Qbn6JvaQyAbxJdF9MyrAQrfI6Jg0vgzJOVZ69knrLqnXwC1VY/LHyXvJsIuzaHFrsXvchfP7ZqHtCnCUw4sHjUrqOm8MnhWgyunnCQQbH5b6978gJXiHLV0n2kAS10Tc83ytMBm47Q0iSXEIHn+la84lj9GMLgr8kvBWFWXyng9zDVAiPJaSR0RWX7H2o4Ulc7c0nVdYKZyFe4w/KkcZv+9yK2qjvPky5Hz0BU1loQvHXxg2FSPCy1oJ6VJ1QtECQ2T5RhNAWFcwU1BzW20oENb1oNprY7dd7nHH8K4MophpmtwPWjtZaWGH61I/1SOJB6GVhLHgAwoX7RUNjNByQk+EhnmgKB3UeALQpaHcUhb9V1VhJvrlBVSsy1OSsxLPXx2xjooqCvqtuQt8OXgeRsuV+4aNtuSy922C26jmGBhWp29wH1k4+Lpt1yx9uyvK5q+vWLeI7ndH1mh8C1P/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(36756003)(52116002)(6916009)(26005)(4326008)(316002)(2616005)(83380400001)(2906002)(86362001)(6506007)(1076003)(186003)(16526019)(6666004)(5660300002)(8936002)(478600001)(38100700002)(38350700002)(8676002)(6486002)(66556008)(66476007)(66946007)(956004)(6512007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5rvXp6SNoeTyvGgBGK3it50Ykzyo0VaRRM6rYwmaP//9v0i6v4SHm6zkS/Nv?=
 =?us-ascii?Q?cTvkV68RAuLEehT7A+c0QAKuRJiBYKQqgbd+3pyyP6Iolie4uw8btCn+tLPB?=
 =?us-ascii?Q?mH7Z+efZzKcQpX3oh4FTwNXqmnW8zQQ7YIHDISSEZwOHB2a5mUDSXSBC7JWM?=
 =?us-ascii?Q?qDsl3E2gwzyjGfnFTZKcducawk7yHaswLBwVq2Tp/qE7dk9fGvDA6IN5NZfU?=
 =?us-ascii?Q?0EuxhpYVNxcHsHzAZosUtk2a95dE6aJSuqovUpXHv02826af2dZdCOqgQNrU?=
 =?us-ascii?Q?Ezx8ygB82PW1HRg9ALhI049nnksRQ9N+4NmTb/JV+2tqzZt/C5xwNbWu7N2X?=
 =?us-ascii?Q?hK3tj0XHgvh2Nn5VVPEBFqL7dmipx4jhwoi3j9nUE0GFopPA5eW1djx+mZrW?=
 =?us-ascii?Q?tkarCwHjce+G2v4gvCxeqJTkmf5dF8myXoxKLHW/x3PK3WyP+KW5pL1At5pp?=
 =?us-ascii?Q?x51HruFWG7SWUtYIRg2VXIXLr1YsZVIKgYfQsUZU9qS/MHpp9VYklpH5/Dsl?=
 =?us-ascii?Q?+lOCjVdIgyfLoIDaMHbUUDMetM6TzG8Ay0g/2Ph98O4cdkyHTv+QmJkeCT47?=
 =?us-ascii?Q?VI23KIhIhcwG7t0YZGnQ6KIMNiK6xMLJGtOnQ11qXcQ3Vvu0r7ZNVJXFL03P?=
 =?us-ascii?Q?yJPQy52cyuhY4kyJmoGsjTYAcHCZFuVmVCOHmvUIOwmZr8OYQWo5t8Wi7RVJ?=
 =?us-ascii?Q?8rIRVVmkhimgZSU5QpISaUUmJPcAtxywXhaS3IZ/oBvggfzK1zN/2Wd9OQ8k?=
 =?us-ascii?Q?5hh5/uPstGzuhpCin4hGCsLyqPDICJ+q+URovpxIFgHS6tJzl+nr3ZMFJdU2?=
 =?us-ascii?Q?SFw6hA3ij6nKhX43SynukeQtbzt+tcXuBn7PU//9q6pegdjjuP+ruTB/7zsJ?=
 =?us-ascii?Q?kUI+WAnuqNv9WISR7rkrxm+z80p/sBbTe359PsNqiDGOFCfIhUFFgEhpk4fE?=
 =?us-ascii?Q?tbu1WGoBkacKLAhkFFQWZ5b1iL1txXl01FAUzHpWYcAxcyBoBqbbfb5obKQ8?=
 =?us-ascii?Q?8EjH2gZdWXgWmnJRvutZ7ej0TWnaCK/vJr+07pz89tvHC1JDOe5eR6O+mLla?=
 =?us-ascii?Q?su6TdoxSlysmqqTOuDBrS3jCSNlyxsgC7d0JewGSyyflVjuQYsXEOl19pf6X?=
 =?us-ascii?Q?+pQdmFMl1omgTWsvpsBr7RzE3ACawlzgTlt0ITRzSXEC+UjRLvhBdjjStZw3?=
 =?us-ascii?Q?yptXuY40M/w0EdG1tWjaK5NcQfe5LpIbvwCWXZPN5GYcacDpgcvS2PHPNfQt?=
 =?us-ascii?Q?P10oNwxFBI5jWGJX8gqwIEP7cR+vv98BfGdWckAdvA7uA1DCA3XE+NSMNg2F?=
 =?us-ascii?Q?xDIDqYO1gZcCW+4pU7TfEYvA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09303c0-a5fa-433e-3817-08d927946d64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 20:07:49.8272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZssR1UiMvQSbKO+w4Nm/ReR7QSghlTFz1LKb4BK8djPVw1T6AqY5tneJeCgrJ1idIk5e5bgiZVLt0F2ptBjtXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2818
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

Unused so remove them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c   | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index b281a4ad152a..90127c1f9e35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -362,8 +362,6 @@ void dcn31_link_encoder_enable_dp_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
 {
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
 
@@ -380,8 +378,6 @@ void dcn31_link_encoder_enable_dp_mst_output(
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
 {
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-
 	/* Enable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
 
@@ -397,8 +393,6 @@ void dcn31_link_encoder_disable_output(
 	struct link_encoder *enc,
 	enum signal_type signal)
 {
-	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-
 	/* Disable transmitter and encoder. */
 	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc->current_state, enc)) {
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
