Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D37C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 20:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF4460F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 20:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FF4460F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AA889E69;
	Wed, 28 Jul 2021 20:35:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E186E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jul 2021 20:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOgwOUWBXjP/H4yxYn984ToPdC1QOlTOjPH8f+nijonfGCJ3CZI4/o3PChGX7/FzSVVCi7NMZi1hARHNJjwRPWnyM/XrqiAJFGlZ7Fau5spm0qnWDQJ6KK1Bzw8P9tejIPGFz33lKZ+56bHmEgBa5ldmK93ehNba2e284kMtmipSQvKgehTLgDPyK+1fvjc2QA/ExLGKw0/dmHDwjLdi9D+WcFCmhG91egeQeev+3QfqWZQjZ8RdEWSpTab4b94gBVBgci/OhU6CkBu5J4Nzq6cLky2xODDCAth/r4iit6TN8vy15VVoJI77R2xGLfSibRyfLew0qEAuDnSe6Jm7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYqQcv+6fiItwxE7jOuONq2lsPCdcPEjCUKwsKWgTUk=;
 b=Yl9lwizp9BisXSDwRPwC9rdqRkyMMSBMV9wwbzej8Rlyao0tftsFwuO2kunX7YRMiZHOizgwPC9DdbVjcmSc5zG0Xuy8UUvCdWNQuBFrqohAg1hfI21oQhAHh78q6AH51gwnckjwUx/jICcpkVfBRTrJEgsaFy5MeHpR2xsnfKPnhYmhfFZg1nud8D0KRDa4aiu0FZzN3NuRmcQWXz7cuxB8aOzdABNpzW0eahfrrL0m0TtycQ2wUOJI4h1P+ZIWeDVMWE8XJN1FJb1GDxTQSi1dx0vh7bl8+Db32n+cNuy2atEi2sHw4BH37pFTB7KC0vWjPpecC+rVJorgr7rc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYqQcv+6fiItwxE7jOuONq2lsPCdcPEjCUKwsKWgTUk=;
 b=YeG6IEWOtE+wLttVhIlJfCS6bjZ9OUZz58KAkEdmTtkCbe30PtbdH9br6kFeA716X2DE8YVamAIACWjxX0W3vlDAFH8lzunmEQmjj8BGWXNlpdHt4/EU85oeAe4/Cwd1X4Vmm0UqLVbAIyYE6xAbni5eqd3EqZiSWFZFbPCm8LQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 28 Jul
 2021 20:35:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4373.020; Wed, 28 Jul 2021
 20:35:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: protect dc_dsc_stream_bandwidth_in_kbps
 with CONFIG_DRM_AMD_DC_DCN
Date: Wed, 28 Jul 2021 16:35:18 -0400
Message-Id: <20210728203518.1460001-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: BL1PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:208:257::24) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0049.namprd13.prod.outlook.com (2603:10b6:208:257::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.6 via Frontend
 Transport; Wed, 28 Jul 2021 20:35:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e26444a-47c8-488a-87e2-08d9520740b9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5554608ECE4F9F22CF085EEEF7EA9@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD1GWAhTsiT9PBsX1t6LM0C+V/4mt+4TZuIxflC0qSMbfH/zVlSilii+av1P3sH5S/87+MSZTD6swT9nMK1aXQ8CXH5KRH72E+wP5ukJOq0mg1HEYt/cwrEPivMePe0WLOiHVgYfeKD/jPymg44/wV46QUlZKyMtq8w0/MuXoz0R/8p1B8HXMIzBcQIhbzRTlJ0EmJo6DMP1xFiq8hhKDbPpsAXUTqUOTv8I/3Nv2pd/5OkOU8rcN/5bcEgXylS8my8RvQAY2aG7uTUNpflH7XzI9bW9PC/Xk8WcmgBn6bf8T9CZiWzUFYgeQ87DwLyqHsJ+7/uWpfQDNvaDEAZudHHFUk1G633eFa1sjooHFnTogQydA94VacG6wJuNN1R75zsRtn3vkrWxgYqBXChDUyMKSkz7qZ1oMjSbWaoOjK7a3akGIWkAp5T4C23UrNG7PMCeOFPJzrXGnOdOO90OAPD+zAL9ZPDTDoAyPv5m7UDb//k45yr33ioY1XfndAdFxCI2NmHeoqq3OKbBNZGney+uppc6xgLNXprZG15wCafwzubEIfpHLEvMaSafBWyJaxnYlYwObLrP+izOft/gCHYhacxswnFQDEZfvjZ5H1OnZ0qDdGHtqfayugVB6JdRJR0FGA0g50Wyifs5YiZ+Lw9Gz0Dtu+RSmmLF9TNFuCWw6eIQo2HCMZ7oijpA1PGAlUFgW7C5lO8IdyfiCnkTNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(66946007)(26005)(8936002)(4326008)(186003)(6666004)(52116002)(2616005)(7696005)(66476007)(66556008)(6916009)(316002)(38100700002)(38350700002)(8676002)(6486002)(86362001)(36756003)(5660300002)(508600001)(4744005)(1076003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3HcniJrnc2EyqGvRIuJ2aN9NJIJh3+SKEqwBLmiuo3dkZXPT5pSISzSz3W+?=
 =?us-ascii?Q?k0OxHwP4+KKxpx4sWA/8vuDZrsi22d01hI9/LqkPAwDckhgbE3sGz2nCv7GK?=
 =?us-ascii?Q?PsnDStBefALmEshToSCyEEgO+Q7eaVlAW18xd/qVcLdAYu1QnnlUJhjFwaRs?=
 =?us-ascii?Q?sbuwWX9WDEPPyvTUKG6jhUvsvDYRL6Jeps7kOWkJNL32xMqM3LQE3bmjiuqi?=
 =?us-ascii?Q?SpJL6+8ysgw6Dq5NvIrbWQ8LmDu7Ve7CYeimzvcWFTeo2SxXHYbs9BcHDqne?=
 =?us-ascii?Q?yTVEnfwzJIxves4pR1sA+/bX3hztN3ZdhRkWsa267i28Lx6Hg7FXblAa5/s6?=
 =?us-ascii?Q?tK8aqAFdIKCmRxKfi6aUoPsOjbRkKKwLv8E6iOVXfHfUguUYVtMNyQrdChTx?=
 =?us-ascii?Q?JJKTSglSEKfRqI822VBFWoCTPcc8MNutNqEiBk2syebK8ORZL47AJEuNgzyR?=
 =?us-ascii?Q?xOfSlvTa6KNloLNLFMk05AqTb73+lOYuYsSg592LwDQ7i+9qKgWu6+DK9XMt?=
 =?us-ascii?Q?fS5Y11Woe2YZFOhjrS3zr3xZ1GX6FRfMt9wSOdb8BkgzaYEGW7jBiv9iLDQI?=
 =?us-ascii?Q?Ez2PZKZXj/pE59q021qXbWASYxml+baadwMkpjsh7Pk6U1gn3gsLRJ8zRggO?=
 =?us-ascii?Q?qpg2VQbPEI/aPf//K76mb1jynObCJ8ai/7oJ0tHX2fg6Xgp/yEUas7vVCsX5?=
 =?us-ascii?Q?gF5U7i3Pq/5yda2+ALBBPDV0s4X8zLqz9qd3VLZn2YHe5FbzTIbP/EZHJJUH?=
 =?us-ascii?Q?svIXwlyCiDj7BhCmZBMrMFq+jddiAFpHX8w410DGTbK0LRBnH4/26MNzsBuq?=
 =?us-ascii?Q?aqQA9UuL+hoY1SAAw+/82edJdGvyBRSbUkEzqF7EGtckFXjt0fb2zYYgysAJ?=
 =?us-ascii?Q?tP0x5hKeNMVIYaLN4/iq2aLkStQc6ttXJM/TrN0b09VM8wM/AB5X/TMyFJAR?=
 =?us-ascii?Q?/U0g89PxOXiA0fOuzdJG3+opT1SiWW2e/2ZfOOVihmxLaqv4dg3xdB/cVL0+?=
 =?us-ascii?Q?ayFR5qulZpjLPARPruRBdS2TrrAWbPIXSl7562joCTrJQtvTsh80X8flaqsn?=
 =?us-ascii?Q?PsmPlIGbbDcM8Sz3lSdR0tJo8cgWQpgRYqULZZC3+xbCctl4n4uZHTKE47Lu?=
 =?us-ascii?Q?8ZGA+9+9VlBjTsKoH4LEZ4kueRLmziOZpnBemKe334OhLcxyUXVHjpIpq6CZ?=
 =?us-ascii?Q?F7xQcEuLDmBtAmlgIcW7ctZzo17YMZAxFE+Or8x7KMTGJLdffRvsPrz0DaZT?=
 =?us-ascii?Q?n8DacGMPnAZXoPAKLHPalGozDYSuhgZf+CkJGzxlZF4K+2/Vlon+JR76J2Cj?=
 =?us-ascii?Q?u20koR7OcO8/jw6zD/caIPzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e26444a-47c8-488a-87e2-08d9520740b9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 20:35:35.5886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMy12WvENOdywVYCmDItYbOnFM+wujrYSpB35J0bZQeZGJZyr7wcpiqVHZIVl034zvLfNckkZvOcXIBkZpRzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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

It's only used and enabled with DCN, so protect it.

Fixes: b6b76b0315ed7b ("drm/amd/display: Fixed EdidUtility build errors")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 5be9d6c70ea6..8bd7f42a8053 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3729,11 +3729,13 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	uint32_t bits_per_channel = 0;
 	uint32_t kbps;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (timing->flags.DSC)
 		return dc_dsc_stream_bandwidth_in_kbps(timing,
 				timing->dsc_cfg.bits_per_pixel,
 				timing->dsc_cfg.num_slices_h,
 				timing->dsc_cfg.is_dp);
+#endif
 
 	switch (timing->display_color_depth) {
 	case COLOR_DEPTH_666:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
