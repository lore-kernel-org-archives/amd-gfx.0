Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8DFC4709B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29F061C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29F061C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A30606ED91;
	Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2BD6ED8E
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaz7Mw7UV9Ufw9dLDWUy/5jB+1WIPgZcHA/tenantWFbX10PuyFAgGB0pHiap36Q9Y4NgQMIq7Zk5Ksh6+fb6EYSSYElFVply5hHsaZABCP7b1dtxu86+25di4KlY4KclLzVsrU+k+vygdDdtXb3/4Cfs1gVwKq5UGwMKtgNZy/Gr1PAHz5DfM2IhDKS+QnVWz4YWp/YBxI9JaTSbLaAaiMz7DCwbkmkGwoIDXHIks53haZxrcoiDXAKBjc206fYOF/8kJdD1B36HMKN9mKfS+IorEsDUlkSBjAebKqLGf3iLq8PW+DUY24WIH4+OBrxKMg0nwogeatwj7MCJ/LZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGgnPj6/YpiLQbcqBXee83eeZ7EHgO2k8xJrh0tAOHs=;
 b=MJoD/KLvSfOadAlS+NA5VxwulJawHvuiXMezJXemJVopfJcZVOF/oA3gBQ5XFJyeufrpoLUl03UD+oErCyssB/q/94EtBMg1G30+VTXvRQLWaH9P2TZVnuhpej+bo3qo4yg9ZfcgtPE71ARhSyrS9bESZZNbujukb0UuCDas7R9hi2KdgzeqWOTJAkkc7cHA63OqF+ROQOatXVIeb17ByoALprqymPTRDuhEsQkjivTCzgCpuHmoNQ4O+ADVMdaV5pAZ8NDDCRJ2XCYclr9kH+UHKwA4lWrvZDDqFpVjsX7Tvs6dguYifP1bSrSCfycp2BtJohunVg87qHaOp0Pv8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGgnPj6/YpiLQbcqBXee83eeZ7EHgO2k8xJrh0tAOHs=;
 b=VCG25+wsJi1HKniLLCJ4RJbPtERmO9rKNi2+bFCK0hvIEgJPUvHg6pfE8q+8lyEL6L7JDupINJct/miGR/qs4G3kk7RRj73djuyzAAjVqnSnZFpR3bCO7zJ1w2xhKbvRiNL0v+2RHaMvA8Z4FObkcuYvekpG2lF5ZpXwaDRzOWM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:44 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/89] drm/amdgpu: reserved buffer is not needed with ip
 discovery enabled
Date: Wed,  2 Jun 2021 12:48:03 -0400
Message-Id: <20210602164908.2848791-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7dabe7-43cb-44b7-7b7a-08d925e66ca5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4063E46215F7B9C54A47B56EF73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XjFGu5VXmg+ZQ65lumNT1uV2oqTzupuJ+tbT3fS6HWbDjskTblJEsMpkV8cryQZW+MZ7SgEDkDdP2uhNxaIXtB7tVtwD317J3g4yb7XaSo5xqhFnfTUjFWa/h/JnB4UUSqIeh8NE4UHmIq3qz4NwVB41M9KFvmgN6k1GTkV6Uk1s0kHYYrFoo9IMH2QgjYKqOKNxdGi/8RBmxv6nMT81JdMBuiZxNx6j1BwPTGH4XrAkny4CfcTTA+D93IMHiWhTlicLO9FJLBnW36otf7SBEwnG/1g8R2L4VJyBr0RyUiS2XvU0SKWdIJRm78RPRvJUFRgJS7n6RUSPffWLva0kwap3cbOe7wqYSXgmVkpGWKGXyawvMA0MJNUELXDg386ECofh2B6hhfbsslBRnLjzM+JNESV4l/C6OUiyWkMG7DsiJFuk7hkbANCbyDrek3Ey1NnKFeofndP1kTRgdcLvq+TSu4N0GfbhzUSDx8eUJBOM48B82myKmEFIrYjoV5fDr+834pAzV9Rt/Zr7zLBNo1aH9tkNIgye3OY6s6ap9lCynI6VCzcDQ4W32RhFbHiwgnZlkWXtvSBJdW+9U+a9cnSxNEs5WJWTVo0eSz+p4+eMzU5K2SWSWRV90B0zdqJ5iRP9YSpuFLIGeXE9B1TqrnR6ay0UyOQxau8H44TSYSrUqitF+YhBifsqvrrA0JG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nd1DPMTodFvljipTZQrNkmxBqZdfJ1CXfTjfmoL/BtjAu//ikDNRM4nKTFuo?=
 =?us-ascii?Q?OReykZ6s2xtLo6dRF506T//IQWPn1LMpNtAGNjATJZlB0dHAhx5SezBjqjY+?=
 =?us-ascii?Q?Wvjah9FdLZ3k0rGb6yVjfWYCJVY0NICD4q9XxoWYiRX2bJ0doGlewSblf7bE?=
 =?us-ascii?Q?qQVNfRMy0IAkgBQMdzaNPXDocdRWs0BOw0Q+IiWW5w8XcVVuVWqTruKuJUyH?=
 =?us-ascii?Q?GAWe2Kov8VAe86JVoxKAQaRvH8u2DSg2Cy4L71ZWY/PvpUEIWkJsiUyh7zOK?=
 =?us-ascii?Q?a3dscajf+YL/PMhbgp1fgSDnD7aFD4hXlZio3tLgtkEm1Km5LwzOc3/ixOUT?=
 =?us-ascii?Q?/oqsEUPx1yAurSlyn7siav44xKcvQI62Qvg4ITf4EZBB29IZKYut4N4F8Gox?=
 =?us-ascii?Q?6leUx5InkaUm1J3ncGB2aVhwQMNnihTVktaj5frx5/TkV/kZ050uMJmTlemB?=
 =?us-ascii?Q?Fg9/FILmk0NUpfYyLs0JnUkcvFb3JrMtQd+qiHUbc7XtGsjFYUbLMhp5fIcy?=
 =?us-ascii?Q?+l2ig6NMLvFuWfX2mMNlWI8apOvVo1UeLguV/QFVYRiTQF4rNgjC9Q5RDZIQ?=
 =?us-ascii?Q?Ko/m82/2gx83QH05ZMX53FZ5mUE/1kzfau4Muip6q/TbJ54bK678wr+9zDXb?=
 =?us-ascii?Q?acNSK4fAWF/ytqFh+4HhMrpiSH5tOAUUdQYzF1nM7vfscLMMXLaktk83rVka?=
 =?us-ascii?Q?u+zuQ4Czz+omudQ5UfqvvRzW/7CB1vZUMa4e9aU4g1OkbStT9zc54omnrkYe?=
 =?us-ascii?Q?f/dHod36+wA+12wb0BP/+EcckinzFdLt7UdFpHrD9efIgI7m7xJYgRMv+03g?=
 =?us-ascii?Q?PsDILmDzx5Y6Y0w6cMnhe1I0dow8xIDSDg/Sh5yEvLuPkx83OkCYhwyQMnn4?=
 =?us-ascii?Q?Tho0/G3n63KUNcyaOUE+dmRiOx93siAq9Jpp02HdDeVoNNLVQS0fDgT7Xmya?=
 =?us-ascii?Q?Dcjy7YQEWqb/AW5b/lcfabBm5wdbzSLecztL3HqY2YBZSedywbfE+euptq78?=
 =?us-ascii?Q?bCAXhvB5lKMYOz+rJfY95W22OuCVSGWE1PB6TdMEEORTWZvkDqUikEcLhIH3?=
 =?us-ascii?Q?j8zo9Y1y+F1sjjbrpcYnLvGw5JeRUHRTeCevqxLR1S6GHw7Lm/A2WBsgvxik?=
 =?us-ascii?Q?7Vjw5oYwYgI9U06JTh3cpKXplIdJQRpy7Db/bbUfGpIjeL6gyvmFbg15y3bV?=
 =?us-ascii?Q?LSlv4aOLsL6tpFry7lG2m2plEyQ2nHnSGrUAndl+NBpuDlcNS8tvZqXfNszh?=
 =?us-ascii?Q?5//q+mgMfewOa7rxI9WZiMVxbb5zkQgX3bU7A+wuxjFmbbeWhkEb8sFkr5lV?=
 =?us-ascii?Q?6IlVyg9IxaBATfRpt5yIewTM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7dabe7-43cb-44b7-7b7a-08d925e66ca5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:44.6948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn5hEcbyijAsdnKNjRMCUELyiWd9WvRGeoD+SHVO13kUTr7glL1QMQXkNo3Z2TQgtn8eRSGMsZIrZhz5JbTxLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

When IP discovery enabled, the reserved buffer has been alloacted.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f1460acbab3d..3014985cbf47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -782,14 +782,17 @@ void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
 {
 	/* Some ASICs need to reserve a region of video memory to avoid access
 	 * from driver */
+	adev->mman.stolen_reserved_offset = 0;
+	adev->mman.stolen_reserved_size = 0;
+
 	switch (adev->asic_type) {
 	case CHIP_YELLOW_CARP:
-		adev->mman.stolen_reserved_offset = 0x1ffb0000;
-		adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		if (amdgpu_discovery == 0) {
+			adev->mman.stolen_reserved_offset = 0x1ffb0000;
+			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		}
 		break;
 	default:
-		adev->mman.stolen_reserved_offset = 0;
-		adev->mman.stolen_reserved_size = 0;
 		break;
 	}
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
