Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB67C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3B2613B6
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 19:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3B2613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33696E9FF;
	Wed, 21 Apr 2021 19:52:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17706E9FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 19:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiefYTKyAby2Uw0/v8ERusF7SzY6Z8subNiyYHoxs5Ud1MZxdj6h551mpZcYRBQwg16ALbPmgygD4moAASMAwnv7cnNDc09qr9km3IwL3aEVI8mxd6oslVly4kBwdmJwDSBkKAT4soMGH6uuV6Qf5McdjZ8i7U+PHShqpfbC1/6D4nfElaJ3hGw0SZ8dzpPRIQW2QGXTewsRVSton+lkRItU367pZO5UQCwqe3zSFxE4RNOZY1eNynKGz/ECNbaEMRbBbNFzAD0xUhR6yLxxeFtTtQkcdSIx2JgwYhHIqsznFj4Aj/qhHudZ2QPtv8vTtbp2znxlh+kVc/hXH4heLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIU5bQYxgE5szFwhsbfippA6/tCN6jR0hDtJEZ4HceE=;
 b=AmFmpPpmk2EaNpiSfPiJcr7nTxhY2iup8UWSGjrHeGjZFLTLR3Lprnmwd/8JXqXHRYUUVXRwLRiG045ERIse9NifUAGK4JO3nD0b4EnB7Pd/ByrvDBrFttx1s5JMhUNmcZ7SqkjGqt+s9FO8S+8dV//PEqWY+vRMQrMoRBv2AzWNvh6nOayzgDnhzIMNWxhrWwc8H458okHjY6Q4pEmuDCi8i9D/ToNfNS8gNLucprA/kFdZGF12Qetw2oqEiDpzv2URaavlLgHrxRwN+h57YGJye20w3LKzh77BMXfdxjot7+0sgt0yfnOofaec2UT7fn3VlL0INm4Lbzxe1gRwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIU5bQYxgE5szFwhsbfippA6/tCN6jR0hDtJEZ4HceE=;
 b=3FKdnfYCCRQR3lU4XyIJvyYV0SBJRuxA6zzWVr19WTlGLwjSAhsAjT9gIi0tifGl91yjiTgVvWrJ+amp8A8Hjhjg0BEdoxFZqM7YPSVBaogKsLuZb+kPdwxy4KrhQ0AXXZUDH250eLzqjbdyTQIYVcDej+6rIDx0Vx5NIpt7y6w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 19:52:19 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4042.019; Wed, 21 Apr 2021
 19:52:19 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: set attribute access for default ranges
Date: Wed, 21 Apr 2021 14:51:56 -0500
Message-Id: <20210421195156.24250-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210421195156.24250-1-alex.sierra@amd.com>
References: <20210421195156.24250-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN6PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:805:de::30) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.8 via Frontend Transport; Wed, 21 Apr 2021 19:52:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e687e5f-0455-4fee-dc8c-08d904fef8f2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44298A7DD37FD474B551570DFD479@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDqQx/w9DQAGT46YkrLC3S+lYa0xw1UJdrf1lMaZqDNK85Ey/hjtTUXh2cmp+AgYrKOtYcBTjy7qnmthiE9yqecMidy2efb8gOAdO7m6xh41Btte6NJFtGHXs1h6ySzI+igM4y5Wd4zzZablBbzPVidrVVsG5AMEQepoAMP3s8By86txNjcN4ONmrpRvdarVg2xS8Mz2/5WzFU7nl78rO61JqGPmvRW67j+6c4+rGcN1v29omoCHmCDs39fpzVBQmxNT+TEY+cHSLjBPxhWCJXVSmr/UsKY7cTM7Lo/PO68xtmDVtcbVa+JvycVdKEP7Dvw+9ikcPY6H6/s3X57fa7+k/gnuxUzlE4iKBwjjQzhgESzGRBdZJeC6n781eZ5MkamDLNHN40SwtdWBq2Tv8MO7+cgL7uYwLW4KFMMPmPZQbzUE0+LeK/KDL1TChg8m5uDoOXAAXscC5T8Q0ZSvCjC23eKeXIbHqDT8DV3Iks+J4YBYalxxPD3jbc3uOq6WUdTGWx3GOndkpgZ0VkVrtaYzduTle78x3YGdOVJILDuUjDTq889ZrL9UVzYtJ9MfzDR7JLKSHBD3qnoHtFw1y4NAJxO9xBsB49DP8Wj85XJKkkUh7yy5nlxgR1WmQzohaQ4OMYX2zeCMZR+Has+VdyGw/cJ3E7Vyf/ODCZEtz74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(16526019)(66556008)(83380400001)(956004)(86362001)(66946007)(8936002)(66476007)(4326008)(36756003)(316002)(7696005)(2616005)(38350700002)(44832011)(2906002)(26005)(5660300002)(38100700002)(52116002)(6916009)(6486002)(186003)(6666004)(478600001)(8676002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pzwlG8BcU8+TbbqM01P2KNoStSz0xKHH0bkFD5ZFM+OnVgDlI1bnayMCe3KB?=
 =?us-ascii?Q?Tf17PWEFRV64XtwKT4jad1+dZynn2jhYevvvHH9XmgmeFy1+E3UovfhNQ5aq?=
 =?us-ascii?Q?ylS66bbJcIrgAuczkNVFpWBLm0W2i8KeNvPPTJOmTVEp2KtZ7Bu6d+3DveN3?=
 =?us-ascii?Q?pwqnbGhs+n42QSSLrDIsOpM87VOR9GBGzjjjR1af+Ap214NFyglYNizo0uul?=
 =?us-ascii?Q?oiXlQDRb4g0wjbdPqDsnu5+3sZ1mz9qSdYM/Rpshm/wxUnfuORDP9zYbfBxP?=
 =?us-ascii?Q?1hOlLNDw6OtouhKitJJIVPKMrJW6YjCxfXqxSmtIAk3QKoSHsLqKjd154y62?=
 =?us-ascii?Q?zOhfpeGe+LLoaG2bJjK4pVqBx6fBd9aiWt8lnzk0uyrWc0rZuOHRimZiwzkc?=
 =?us-ascii?Q?5cJ+PAp1DsT+6m3w7Gfe3kmQn4du5iQmSr7Rcy8B4t4QKMamUlkIy9ategjC?=
 =?us-ascii?Q?8HKAf2ALtxPnyExP2rF+7klQ0OT/MPUAH3ncqaAsSpxygVRlXOpm687rjnjZ?=
 =?us-ascii?Q?agkviYNCGee1+dqn7PgHKjL49V3EYR+3ebM65LtPryv5UgtRfiKLJXIwdDrJ?=
 =?us-ascii?Q?LoDsYvWsthOLUoVoOROj5gxJ6LiMNrnI4PTwIApuBuxt2WeWCCN4P5ro/hAL?=
 =?us-ascii?Q?6k+AbCLUYy6OH7NU3OYdwomxz0sZNtSocqJIntkmd6hNDbI5+xN5DabTF1So?=
 =?us-ascii?Q?dXVmhWLBHEyJc9wXm6uBv7sWpUSpzaky6NnqabOFMfltvBScQxlZntUOOjaz?=
 =?us-ascii?Q?sdqNO1L5YJ/J0xIJp+S8Z22q2QKb2u7ysGkkdgl8Hj5BJKvdLb9eO91FhPNP?=
 =?us-ascii?Q?+85/ad9UrGviI0ptCPFnBaLZaAUWRoPymjhCoXA117rLqWyMojeerE1PC71W?=
 =?us-ascii?Q?4cPtZNL0+huBQclWBiOSOtoIRORFl34erOgNRgHsJl2eJWVK7PdU+m8DMI3+?=
 =?us-ascii?Q?jwZGSHfMP9cXIhShY80dYHa1+uyi/FRDOwWd7SrmSK43i7SdE9sMh6PRsbRE?=
 =?us-ascii?Q?Otr5Jo1s8R1aebi1zxyOtQ+Vg1yjhPtivKOLfmbWuTg0wwhf7Xj62i3c8BK7?=
 =?us-ascii?Q?6EbjeVcJhobZi+BmS/I2F7NTFk3CW8A8gCB4jUhDRZ6g6EHY4qdwgwfx3R+3?=
 =?us-ascii?Q?kpBqsCVGVDuV8cCz1H9yey//MbRdl4FTcEDNHqZ8eidPnBpibsvNlRiHecaV?=
 =?us-ascii?Q?/G4YD9XkFBr6PjYU6HNk83uMvGM0QczRW7wMJ8ihurLRT5rLCh+cJbwkYnaJ?=
 =?us-ascii?Q?rsc9KPWyw4Z1WOonpYHMq4PprimeCMFrXGcSBkjY2M7kS+NHaLy+5cdhQNHN?=
 =?us-ascii?Q?kIgnhdRrDPYeNmz/699LPrXW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e687e5f-0455-4fee-dc8c-08d904fef8f2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 19:52:19.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnzV8YXLxw7YQ2WiIlBfH0Q8rJz2PAAT7tGXbK2YvDkdzl6NVuvp4pXlwppXqbvftA+AfuYxoEVECDO1iDr2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Attribute access value for default ranges is set, based on
process xnack on/off.
XNACK ON has GPU access attribute for unregistered ranges through page
fault. While XNACK OFF has no access attribute for unregistered ranges.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cb025a6f30d5..62cf342d254c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2963,12 +2963,11 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 		pr_debug("range attrs not found return default values\n");
 		svm_range_set_default_attributes(&location, &prefetch_loc,
 						 &granularity, &flags);
-		/* TODO: Automatically create SVM ranges and map them on
-		 * GPU page faults
 		if (p->xnack_enabled)
 			bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-		 */
-
+		else
+			bitmap_zero(bitmap_access, MAX_GPU_INSTANCE);
+		bitmap_zero(bitmap_aip, MAX_GPU_INSTANCE);
 		goto fill_values;
 	}
 	bitmap_fill(bitmap_access, MAX_GPU_INSTANCE);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
