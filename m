Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE7C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DDC61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DDC61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196F86EDA9;
	Wed,  2 Jun 2021 16:50:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BCED6EDA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDBcsj07+/O1nCmKcFNg+L/G12LmdclI2r2NL8AflawZxiz6vdVPXwOrTQmzUDIMYjaODA8GfZJ9xYN1ohAuoEFnOIMfjnxSHSpZrxen7UGTbqE5BqXpJmmObQsvHXNMJ7xjh+9Cn982rnwkPGeqy0jvUpLj+hwSwoQkri80GnnjTtYEIJS4hlJfK4pQXFF3V6KernpNkH2JBHMzyHF9lI6TkUKWFan2EY7E5J26+Ui6ZMOZLbLce8NY0Imkqgk67aomzte6P/Z3VWWXzDWfYXKUiZKv8OfOnGMPC7s7ZCEze7YQbI6J55jbJ6ySqqVmZPt0rD26+8kxZ00wBm2chA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56P1zKEoO7AH8wou6WGJnhaMF+Y1BcyhUywa26UyRTc=;
 b=L2yKC4GY0jZP2g18gXa+Anhrzo4tlC74240jWXoyUcew9utnTzfrnosI18UzhPXkQ1SVtqN2pf4SvBgx8syjZPoIXmr4WjwYcuJh/in2Xaf4oBZCUUhzxaXpLxYHiN2cPYBLdpobGVTJBFe4N3X2GrKqNZZuKx7MnTsQ2Ed5P238TDbQp8fPm5pXPQyp3wiiwtMEDRe+PR9YRqw575IjWsj8Vmn5iy6ml0qB0Ig//ZD35qUAo4ely3nCk34U2sxI6KbK1nGv0d0iyNp9bf6pKQAJGIqhGFYW+lWYM0cJk6UhkyTgdvhqB6XgkUpXecN3JA97UBu7iAjRRcM7biV8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56P1zKEoO7AH8wou6WGJnhaMF+Y1BcyhUywa26UyRTc=;
 b=CpwMmcZW+YbVxyQ7eB9kNoXUpRnPTbqYlzGgnQQ/x4ZgxCrS2LsMGw9+ksC0noQcEvvs9br2B5KkGHKJI/1ObgixO+n0zZ9hFP89XLU0tpVwSAhDneq7+LLCHFNLGrffAbUw1Itj1JyQwfKDsAieVqjhcKcVAR30Bjofw7Zurf4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 45/89] drm/amdgpu: enable VCN PG and CG for yellow carp
Date: Wed,  2 Jun 2021 12:48:24 -0400
Message-Id: <20210602164908.2848791-45-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6171c3a2-8c9c-4e7d-9f20-08d925e675a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534EB27F05B132C329108EAF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ZF0qWTYIL/FTAd0pcmPXOQhpMRr1AVv4r7JXixNyZMhkm0RP+FIaivH9eUj3i1dvuZT6QRtc0w34JxA2NFghP+pxzxjKrHUHiAy/ExDQNcvgc4pP2NIpQ1m/QqfSvD4ibT0eX+NPkzgMebtqvew3+TlKngfRWDcEkLjBJqe87sCrYh3X7EDSMG6edgQ4bW3ZWYETmmb6KipQZKvUT292ZC+od5I1j+ztKMjiKEjAY7WPI4xbCkWqiX9EGFNRLkCcDrCduZS6t+KkpAzAByzsHnh5nT+1n4Df7yG/PfB4zYqrR2oAEj3R75jLK/ABDQmZiV9SbyArT+wV/eg7H4htWeMsNuqIg5N8D6ymH/Cxrxjq2Ny+qEZBhQ5S0OzV4pgo2qlKbcx37xqU6357/jE7nW02PkNsdyI1F1sGzy9/Oc7u09dRQEyz2EqrRis2muScz67AMe+3Q7syDN9+hlQwx0GfTdgLygWSyrEm6qa+w86OHmCkjeiwf2hI0ZZje74xHEOXYxL/E9wvOOWnJOD1uMLWtK5vg7s6KDVe2LtAzAPOI+dw0VIKZVAav2JN6auV0mcBjOJddZtFN4IrW4Lmqf5MDb82107r8kTyTRTYFtGK7MV6+EEkJezbNpQmhwAmjw+cgEKQtcyRoWcd2pIM7FUg8ck4oPw7yA6M7DZRgs+zDVyVtDCxctpwt6GsFUz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(4744005)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kL6VLOnOE3GKQLg+jKyUfQjDaluJtuIjLs5Pd+dpV8x7+I81MZKjRcFf7IRr?=
 =?us-ascii?Q?mru7s9K78zTVjQwcGWQ6F+2kTkm5MQsVsc8muDOJXtUnE2MtlHCjW6lAMmS6?=
 =?us-ascii?Q?9ULDyB3mQnyBYyHCNMNquqe/+YNwqRhrDsUOkPQUODg4rG6QR/c22ugHQ/tq?=
 =?us-ascii?Q?6uxkTymRw4bB5zb1p2GlpMy/mkal1VOefbYJXFlJd2Gks7vlSGDUUD22mwq6?=
 =?us-ascii?Q?1fC9KJMrBNsQXtmRu9RyZ4RIvEhhK6i8H/Ejddbg2alUw/J+YRm2wtg30ALa?=
 =?us-ascii?Q?5ix+IlLTLNSU+E7gkxUvxtqU2LJDsYawXSoXemm2+E/9iWTjwhytT/x9w2oF?=
 =?us-ascii?Q?/KbrboJKa9OCkSzUOAD34KbcdECuUHJC5thFvu4K4lipHZGsSufYva02omYY?=
 =?us-ascii?Q?6gh6UcHEmOnTqvlsLsTb/28kLgPj6Yjc3iW3Ryojcv9cUaBXmlGiK0No0vJT?=
 =?us-ascii?Q?NhT675PBVt8mNksCQkZaNXMfW0Y3ncUwzQi5B631qj5vINY5L7w4SphbiS6x?=
 =?us-ascii?Q?CCA7VKWSpF0JS1FeEZ44cvuBRSFgY/K6wAGrv7yVye+wPTkBrW2EPvSCtTtC?=
 =?us-ascii?Q?BOHg+Z6BVvAxcbyj5VVUEB5VGoA2BVnydtwKz1ttR+FDtIkikUlWXEBkwJmf?=
 =?us-ascii?Q?U2Y5rMNzaCX5Gqcmapzm23rHC/WHJu1/DLnsitwjwRpLjb8FW3ujZwpo6Qjp?=
 =?us-ascii?Q?5C6VJ7sTqTJbQkWKMKt6zR6CyNqu3210yD1Fc81HQo9ynkxSN+m8VXaeN6k3?=
 =?us-ascii?Q?c5CM8Aqs3bHHweLul3jrouaFmESsFadpVlXHyivz2R6UINm0BwWSK5n4Kdvz?=
 =?us-ascii?Q?GkkR77nOeL73u5msNAmE10K1HUsr+jQyz/CkYT7YTtDsSAJXA88dE/Ht0Ggh?=
 =?us-ascii?Q?e4XyspBeIdiUj7iPpOXxPYjqZAeB4OV+6+sRmApjZEB/O/cm7hBgCXrwiWJn?=
 =?us-ascii?Q?l43xWtWAdBS4D/WjCawsVw7Y5MK+UImHQWT/LLihhpbPjtvzIEMeLWORDe/K?=
 =?us-ascii?Q?sajx5+5bbOsOUUCMCZaPGFkt7+v8R/S1ijuVBVFSHqqANDoAlNkfjdEokMmm?=
 =?us-ascii?Q?ASzjQKg8aVF17wvZg0zdIh4I56NfHNGhuJPNDcAqLbH4E57Y3+vSgfMqJuvm?=
 =?us-ascii?Q?bUNPqsKgPQgMn8tX+pnQYwYEi5MqP3p/zoLjuvTuASrImlMUg6UrgdNqGB5F?=
 =?us-ascii?Q?oVP5fG6LcGOA52v3C4oxJrktw+cQg0Aqtj04/ppduTQiAEwnUlIrE0tKVqxV?=
 =?us-ascii?Q?FD0fx0UESI0qhIQIMd7Va6c+gs9VMkVny7SrmffoSBxPCE682s4vD/jbuD39?=
 =?us-ascii?Q?TSNykZU+pI7F3WAZnVfAaqW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171c3a2-8c9c-4e7d-9f20-08d925e675a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:59.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGT4Cu1qtVN+h+JDMaO2y+KBSBsfZ1zi45ZYX1xuwE9Acea45Bc2E2rSRNXaMOhVU78XXEdSLlEK9OtpJ4LXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Enable VCN 3.0 PG and CG for Yellow Carp by setting up flags.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4c49708aa9f7..fa2f0cbcec8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1344,9 +1344,13 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
 			AMD_CG_SUPPORT_ATHUB_LS |
-			AMD_CG_SUPPORT_IH_CG;
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_VCN_MGCG |
+			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG |
-			AMD_PG_SUPPORT_VCN_DPG;
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
