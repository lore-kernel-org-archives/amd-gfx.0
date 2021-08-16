Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A87DC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214060F14
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4214060F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AF489EFF;
	Mon, 16 Aug 2021 20:12:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348D689EFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 20:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaD8vKz7cfKLlrOZ/v5k+WJDuDPCzMqvxqGpDprrxrd0Xvc2DFjFsljbsZUDZlCncvnusBcRN1rsm5v29syicBnO20UqsDjgV+/19VlhB7PPDiRuQl7igp92pVgBujF6v+IWrb9xWlCHDIHda4/LShjRtnwFUMEjdb19e7DuJy3t36jKjHt1TaR5bF7XStmQn8Eko3Zfy1i80BPbpYrJHvlztwaJGqABCftDFNyUyJEt8u+ZCyxC8MTTqUT2RbnuBJgfkYA5oZ+GSVy6gz6eqM8//e8/An/DBAMHIHt/IYVva88USQaboB9nGAlLhb03+vHEo1XCfLuaGUa0GC7wdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sFgrii0Bn5jWAyoefWqzJugfxeQNeFXmIEjXbP7FFI=;
 b=HCNP4E3R4Y+aH+1HO9dDTFJxpZAzDTq3qx2mzYaCG1alRx7tlO5dpKy0uarlJ6j1fizyLjZEFYNnQu2VqliRtqNCX4jB2UeSjy56gXL59gaG9ElcQzkHAVpMGHJDQZZpW2VgCkmrP7GOWyOyG2L4bTVkJ2M9xCQS3+WY2fHlgjrAJarS1E1BxWxqHx0c+LeV9zTpr+WoaSlUR5lLYWkWN6e+lEHYBW80q94szqe8ySQxNRIzKM39eJwFCBJ9sm6idrtNmJvqBy2T7/ljNeMuLwNZr8bG84n4ffzChFBbQhyS4XhbIjFsy9hl8CZdZvhRgK656IOgLgeP7pG9XaYUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sFgrii0Bn5jWAyoefWqzJugfxeQNeFXmIEjXbP7FFI=;
 b=fP0VHiczSnjqCUexN1+sW/4nykUvkYtIKthiCE+YfNT8GU6qqIRt05SSXnG2GD8+6dHkQNIWIP+/Bqmh/tTgHxsfEJ/ejezHEM75Qy3AZBnYSf53Ax6r6cezeXHCv1Q2HEemeTZxcvnz1GxlLe4pQMPzGPZ6v8moJ3yKedYgZh0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 20:12:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:12:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix leftover CONFIG_DRM_AMD_DC_DCN3_1
Date: Mon, 16 Aug 2021 16:12:01 -0400
Message-Id: <20210816201201.879662-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.191) by
 MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Mon, 16 Aug 2021 20:12:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97e78603-74de-48b3-db2e-08d960f22500
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126C470C71CB43450EE0A25F7FD9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r0gWXtH3Ik91VIigUjepR8f+jRo3KgUh8CrJuaVAMccf7B5CUCPrBXfLsfoZ1w5QrbV+w6RmopR9CdMa/JssA4wFtaAMOlIDBKBN9KkQSVHja6tHmrRrDUiczuY1etg+RES3rH+UqC/To80+eCBsOvae1vK4PNq3jYaO3/OwMyx4oXnmRmpFhdLT++j6miPTRjHMSEyMWIlsCLJd2yagb0WZ5WBzurbRcRiuW2F4qAhwQWE/NmkXUbx+T+qWqYwnDwji/41cb0pOjQuENYAzT69wOhzJhHH9L3erLAR/COy2ypzChqf2bZJDoP8LKN7/S6De2Q/xtYgYxodN6ioRCP80iUnkBaHU3reznFpbT073NeA+J8Ak1enF/U1c3OtGZ6U9meFQmwZ7AhCtbrJRRCoG3Jp3/sFq8xOWA1spKxcXvmrCgD8d7tXzSkycuMTBGy5YJJgnUuU0xEZ64hlk9DllqgiNwWcdohMCxtdlpxqzA9rFJJHUDoFI3Lw6afdBYH3yrXnkeS69094toiUykH68DVurVYMdDk+w5dGZHPvtoN5GJ5x2by2feKBdvxYylovIdZYzCbGJLCGFk25Z2Vd4IqtNrmp5WFqbKn0aaW/kqhZW+xIqDiqjpQWWd0TSeGq9omcV/nWBkgvzXMzG4ei7XxyMHtQkCSV1Kky8/Bg26yPdLccZRncTgNsLiNEsXAl6ybTXBsr9gJK0SkRZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(38350700002)(38100700002)(66946007)(478600001)(6512007)(6916009)(956004)(2616005)(66556008)(36756003)(8676002)(186003)(66476007)(52116002)(8936002)(6486002)(6666004)(26005)(86362001)(83380400001)(316002)(6506007)(4326008)(1076003)(4744005)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vek3rSK91JcHAXjd7C5sxLjA6KAXPOXaKNwIKamVVvAsuCakHLDCB/tmMDNA?=
 =?us-ascii?Q?VF0baNHgMlXaeAS+w9HM8om0DC05wKtojpwsDBTfOr/oRPMbou8McnhXM9s1?=
 =?us-ascii?Q?/pqM+bOgNoeqlTt9X0a6gTpliY4FikkktQqpFShYbfXOw38RFjo8acuUO+UA?=
 =?us-ascii?Q?jFKj5j005thLZD9Aiff/9DB/Q4swTtbS9ArmqnzwWTNR0y9nl61YITMAAgpQ?=
 =?us-ascii?Q?41uDLduZgy+yCwuIaGiHa7nqvYjGFCyEW76IjBU5JjEW1sO5dURR9nxvbFsk?=
 =?us-ascii?Q?a50PZyZzkT/JbNzHSQIDR5sTChzHlKQfLVLCqavCODfdSVtd6csTHXyk3Zfv?=
 =?us-ascii?Q?wn5lch6GJSKqt3f8CuHTlV8b1Oka2daq1MhXBd1ZjGJTkS2LLCWNFSP1ksnC?=
 =?us-ascii?Q?4OVginVEcwdDMVGisMT/V2ng1bhnZkhXlzUHTiTylhgX5/5YyDyRds3QO3wi?=
 =?us-ascii?Q?4cpUxHAzaMJyD1qNb3NmAJVhSC9HP00fbna9Jjq71p7xqxpwYjCeox4hEwsX?=
 =?us-ascii?Q?YGTG1XffvYL8fowfdxnqzrlB6wB6BVUO6JmmYJMWpoDrApvwB6BJezLZ7fWb?=
 =?us-ascii?Q?z3QMfEN2PR7IEtiJaNOjzZC1aJNe+qlo+n7n3XkRNcMttrP1rdi+tW6RbhM8?=
 =?us-ascii?Q?LYIqwIEjmneiJCPARC4fZZClgYdLs1QBTQgsXGBB/Lxvp/ZwvUXi0+Fi6arU?=
 =?us-ascii?Q?ll16VREJC0xDfnrUSWKDBbxA7H1M7ElZRaryagJ6pX++tUoJpRzvVz1Tie7T?=
 =?us-ascii?Q?tI0CHnCy0aRb1xq0Fb5F/LltoeHbL+OyhqFHh5WF/IGJ5lqZ9AAuheB0vt0s?=
 =?us-ascii?Q?IShremz7JBbJWSMk2qfQQKP3pHp+1KrBf6IXBNn7UfGvNqKz2+fr0pOthTxn?=
 =?us-ascii?Q?XUqGmkOh3n/AKaWwY6+BKuwH4VqUvZmfNkaBr0imVucUUz/Id71MCBeMS+2f?=
 =?us-ascii?Q?SsDk/LBTXHaLWG6njj5eGbuE+IS2N9yNZ+JAr9iB36HQy0JwQQlOPO3BrSxn?=
 =?us-ascii?Q?j8LOOK3YDq78B4A1jVyquV2REsxpm78/FTkTVJlHuKwJeNWeikUpwj9xnil2?=
 =?us-ascii?Q?6mBU/OKj8B+UhONwrwj1Azw174cbOZ7NxV8RBnRU5nblOY2H/VzD8Wcdvy8y?=
 =?us-ascii?Q?EzElUnZnlo9rrOR0rhwdd1o54n5iNsgPI5FB8BqY8uEs5mWw/EbEEJLOOkPl?=
 =?us-ascii?Q?LbA74ZFzRWPxFGxvTMX2fRSB7lrW98xoA3pb6kd2gQbgo4VArBp5RczDM9Na?=
 =?us-ascii?Q?KlhIWVzSSfs39oqwo6K5OjasIUsJ7rhIuK4ANwH2J2xb84WzkmKbibBPz6CK?=
 =?us-ascii?Q?1HZ53bY5fuj8bBZR7rvIViip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e78603-74de-48b3-db2e-08d960f22500
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 20:12:17.1499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfvAyDlH621R02Oaav5j9uo64T8oc4dXwEFrmKCip5Zb3RquG3EmvHfzVz/O999j4epkv6bUcPzPUDLyxjkmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
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

These were converted to CONFIG_DRM_AMD_DC_DCN, fix this case up.

Fixes: d7cecec64d07 ("drm/amd/display: Ensure DCN save after VM setup")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index 80c752ca4a5a..cde8ed2560b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,7 +47,7 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
-#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 		dc_z10_save_init(dc);
 #endif
 	}
-- 
2.31.1

