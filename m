Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F9C47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FCF61C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FCF61C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5706ED9F;
	Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72006EDA9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmKFSWd/tBCMWaEV0mC7g9nFFMpTUBdEZUnzUnCBGoa1B8PoTP0CLY+qMuiZ2QP4FXkcp6KfDeZ90tC6jUrpGV40MVxB3dnNPOzrPR1SiXlsFyMVr8PfCM7mR2Xz6Hqr5qHnY03/kyp97WRYYcdfXQIKNiV+6dAmtejEkh+tOg/CTtVeN613bSEpIqA7TTtUgcykx2f99tPlRAUzNaHSwHBNKd+uFUHBfBqI6j7vfaEZbXmd+sn7lOj1GrxmJGCo5raHixNwD7n73YBBAVIoMOISoYoRcwKo2GbdNA1yMgiRj3Kn+yAec3rdw7Mg6FAQBLfjsImi7ZSOVCs9SsKd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+cq8KLSDuZG02/uIdmZqhVfuZw7Nl1I//GlQD1QJns=;
 b=VZZge/SitRu8KWpfNmOye93kEuYIDUJxDhpauXMhL3Na6dGYBu3abgJ+IcoH4KlUwDb+IYU7qkb82Apgz54c6I01hAxi5KjTYyyhg6Nuk62KwRmw7hEQDXeF/PoTc3S8j2r6KK8HvkMPnlx/z1XX19uDa595HT0qB+wMfyGnb+BqsX9pXKeIDi3kSOxhM47/rhrNWKb3ZsfauEQq7j4OT2ET+7hQBZzlVbIhl+KZ4+Km3xPOHZrwJZ1LJP06u513PkYIyffBK0UBDIgF8bLFRH03HClFq97anXW8Agknwe+z6MrbYUtCn0X/vgO73flZo/XGkz7hWccn9+XUdM1F1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+cq8KLSDuZG02/uIdmZqhVfuZw7Nl1I//GlQD1QJns=;
 b=goUGEm3AoJxzSc08ayMYUlc6WP0b5zuReiTB78KjBeQJJD5wS/HwXp6C4Ddy1fEa0pH+BWMJRojE9FRPKUm/r1WxUNJV5nKUSOvLX5RNriri0DTV179StrXVCEfrMBP/nJy6fY3xqj7OikDPdVCSIxAvqsmAyKdeOI45hOsCkds=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 41/89] drm/amdgpu/jpeg: Remove harvest checking on
 CHIP_YELLOW_CARP
Date: Wed,  2 Jun 2021 12:48:20 -0400
Message-Id: <20210602164908.2848791-41-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b40cc53-9172-4103-9328-08d925e67403
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675C4683178FFBBDB599F2CF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ak8kx2Bf3Y77Aq3/+4Sm5/XlrXmUqLNC/mdqiAyayWaeu3vcnmJr8eLjj1itSxHrlD3hZG7pR7E5VhS/SXjOrLNH6wLinKjm5kjbEgXoqJ6nnqtzT+2FUT7fGGH6MNUycpkf+Q4LvP6g2qGroN2CvKQM4nmwBlI4vY6+Ch9Y7pCQToPubzcYta6rdAtCdMd25yy0ZuCxkdB4oXrfb1PqUt8i4PeQp07ObqccQd2QVRy++pzhushjL5kFJeYfFGpICo7xBctQUBbGQTsRs7oZxJLGbMJFb5In3Fe0RZvZYMhHcTsNb9SYwbcKSin7AVsnJxWcMucQZG5RrrQoI6lFLJd826hL79IB9se+5eGImQFh2Q8Xpz+4XxhdbQoLaoInlL+/uxG4NZHGMQIiReYTp8dMhTAZVJ4z8EQY64RhWQ/Z5pbTsrIplxKLpYiO+a4bmzkRAeEa86KcidkLl8G4SM/CRAgAQ2k7WyxqNHQ4T7b+NZcdxtO2k6ytzDPK/AtuRkTcl5gzeesNBvMAncvaG0hxrHsMjDrSMKi7EuL/6o43TPnR3EQzlj2VadVkTsbx6J+PZ7ZCHKCBqdKbV7378EdiaeJp3UuYtADIGtHZyjjA6Af5xP1fhEdy75KpT3pmJKZI0CkAbtl8BI5Pj0pzXmv/ST2UfsEct6QwSCsHQQOmC3PDBKL+RQTJ+8LYgaa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?88rbaQfPKbFXcRDDg4b1akShUabjb9bxFK8FUCnahlgpa5oMYSZuAp7jT5T3?=
 =?us-ascii?Q?I8LiCPIofWxaYwB0LM1unkOmKlAm3Jb/Cuo3uwU7kPVxdmAcQW7XQOpuLFob?=
 =?us-ascii?Q?2jf6vHrbhd0J4yIZm/HZiJddc9HnNjz5QUm7eobpUJu8y3i1Kei7NMT0lf7k?=
 =?us-ascii?Q?QEJqxwMtfl8OEbJxyzhboTzpj60BDOm42Agg5nGmrg0d8rxkD4klSymfdhDJ?=
 =?us-ascii?Q?ZSh9hg9I9NXvQy5eLwRGjmIA4e5Zvc3lswB3YCC2W6UQLQFHY5P9P5ZwrYTq?=
 =?us-ascii?Q?pCmaldgnNELKlniUYJB0x/MFoP6wuK99wmTDjZHFPve9l0vEjLYkOBnOgl16?=
 =?us-ascii?Q?3s//1jWW6rDlxYfT8MQfRWX7/xrXJfEQcmpmuWEhUDER0KJV5QUs+yqXa46P?=
 =?us-ascii?Q?rAZqcExHossFMU8ieOl7C4jY7jr96vckiZ4bMNWwsHry9bgG4sJ7qZTgRHFm?=
 =?us-ascii?Q?Gq7eM+2bfXfYJF2VwT8hyh8DQBoZjQfxU/fhmMdi1BOMUV7NR763ji0YtFUy?=
 =?us-ascii?Q?2USqC3GU9L4hECkuBfYc8ANMdFF6fPrEowKLWawUiXyRdv1leK+sfWytbbvh?=
 =?us-ascii?Q?f3ibKPRMDEVapYMbMSt5eONOj7bkx/QdQtIBrooKshOdkI0RKZcSpNvQ11vc?=
 =?us-ascii?Q?5u6f4mjgHJNUmaQiFHi0t+PjltD8BIxDHdbxzwQu4SpIOVZ+dBsnQmQl5+hF?=
 =?us-ascii?Q?7QmBsypdos14D3IiZ38u+idd4OlZU9BZP5xKtM3w+ZpRMH3VTXQir3amEUtl?=
 =?us-ascii?Q?Ukdjd2p9WBphjmnY5QWRkpTpRl9mf1meFNHRtD789DR3zRRX7W+4yoGMd46+?=
 =?us-ascii?Q?RlXbxcLZTuLZj+j9l6keYBtSHQtCxaTHOlo0fngTNQoa58s3qYKE4aNV0rAc?=
 =?us-ascii?Q?QrfmyWnUynIN4NTlqw3Uom0K1R9Q+i9zhRTvkdB1f/TUac3MonESo1SccnR7?=
 =?us-ascii?Q?nb8VE90plB/rSaDqB1itGzcaCxFPMCOO+cHM1+aKGxNSuFmBVUstKqXw+82F?=
 =?us-ascii?Q?2yI8nNX9IaARliRzbEBL1OHut7zgD40e2+FwkU4t3+oET7kD1GvB/8zKWKB9?=
 =?us-ascii?Q?+h+tx0YLwYWBp0p+Ooau/FvHXEQmO4tSx5jGoCQYhXqSKgoMssiQ+sYnvQAu?=
 =?us-ascii?Q?0n1gK846tStyPRa6XZKZ8R+iDmtviAn1eQaDkeK/6ja8ahkChIqesqF7vmfJ?=
 =?us-ascii?Q?S3lPSflUGN0YzkTKWq8WTT6JU0TqAwo95X7BEOtpA0msfh8EZSE2GCaF19QK?=
 =?us-ascii?Q?QNo0By7+b4H/4Gg7aKicNLbn3RZStN3zb0EJQlnxUZzFQdcGT7dmFR4/dVb/?=
 =?us-ascii?Q?3q5ae6QSXF4mAbCNlSfr9gto?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b40cc53-9172-4103-9328-08d925e67403
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:57.0694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loZwXLlSDaJeOcRJbok2NRlDAT6RnG5uc+bvO4XDB3Vju+c3UHKBDMOHiYwXzHbJZDGVOd9xjKhFlvjt7sQ/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Register CC_UVD_HARVESTING is obsolete on CHIP_YELLOW_CARP.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index bd77794315bc..01c242c5abc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -49,10 +49,13 @@ static int jpeg_v3_0_set_powergating_state(void *handle,
 static int jpeg_v3_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
 
-	if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-		return -ENOENT;
+	if (adev->asic_type != CHIP_YELLOW_CARP) {
+		u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
+
+		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+			return -ENOENT;
+	}
 
 	adev->jpeg.num_jpeg_inst = 1;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
