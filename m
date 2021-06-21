Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F8AC49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF28D60FEA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF28D60FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE176E202;
	Mon, 21 Jun 2021 16:04:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C296E1F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyMlAA9BzYlj8nH2URyc7HS0VmS9k7oSVCUau65M3ypX41kg26+aoOOs2yRNp89GMchR23uWHCLLUCbwVhRRKnuFOJxYDpSXK5kqOSKyDGK7XKw8W5GIj4BYNDQQDdlmmL+ywgAZnRr7Zk+2fJ8CsJRnykeHVGipx56wYPuVA/v+So3RaPMV1ZNNr0hpwWbtvgAmin5OlTYhRxGbtJlpQj9qgM7agfojaTw52WPeM1/ILafS3VgT9okLksFVL6kr/7mBjCuY6Cm/7skWUnuXxlHJ4GiLGeKF9ZI5M8s9qaJ8RQmfSP7w0pS0Y3NXxvF2mylp3YL7eugyv9frRx8PfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JChlU9DdAEbQXiWknpoByIFeYtTKE2YE1G46UuNFUOg=;
 b=i/XZxsKuHVJNp8gdChSDwnC0v6/i3Sn2pPrgCjZfG1JlLxn8tGjFN/VBk/+kCTEWIkitLeon0JG7Bs6bawPLzIGEpkwQ9BQlC7xCP8UTKLHwN9tCLKV0JDQS67hjm7WR3nwHE3myvIJnl9Cuc84FcDCcYrUG+xLWUch19ROeFf00DJRAnr1u3iSNJ1oeqFiDPGD2ehXvd0B+QYMKUDP6YNbJNNRig2odilEL27ladUzx+a4JnZUMrjHbrs5ZV+w93BVQuwUAw98fPse4jZCdRhO57GHTo+4agAyS/kvQEtO5r4VAm8ISGMwlUlDJ2RFiZpMZZnJpmropUJuoVu7ChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JChlU9DdAEbQXiWknpoByIFeYtTKE2YE1G46UuNFUOg=;
 b=o70fDic6p1PmDUBXW4Z9nHvgVHhvCGpbeFrxp9M05k1q3imixDNeFbKsneddfmS2cutdULUmw+9Kw5/nKt1lOgrEPw+avtnG+xgNNwJFGlKHTYgdaxxOKY/HdLrsQsDaMpsLMFggt80Ima/MAg645BmP1Xdokqwk2+a8g101Da8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 16:04:40 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 16:04:40 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/10] drm/amdkfd: add invalid pages debug at vram migration
Date: Mon, 21 Jun 2021 11:04:21 -0500
Message-Id: <20210621160423.3517-8-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621160423.3517-1-alex.sierra@amd.com>
References: <20210621160423.3517-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:806:21::28) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 16:04:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2dbb6d7-ca59-41e9-2b88-08d934ce46e8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB244735FABE40900A090B9CCDFD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLPedKiflpxVkIL5dGWkqAcbs/fHTiI4v5kcD4LDrld1Y6qlfuNwUHE/j7t5BfcU8cgA+nLb0tp9zrvWXmvw+SyaEazW3lXAwJd9juiDjyC0gSxtmNfjX6SnuiZmimmmLCghUxPFYO/UGXj7qjOjD7STOj3WxEhc1QB3zPREwnPbQI0+GPwIrAiLA8S/JvnrryKlZZroSoPfV56jxrZvZl142/Nze0PBWm/JX1gGcBYtZl2gEgUmB3NdBP/hH8mr3hX5d77uuR502Us56wKJHAQqcG0BHcw0ADPUbVdoaQLrqdGZ20yg5m//x25VlH3qQuyUMLh2qDx03jHg1f+bSS9RRK25+0+q8I4fOGz3TXkawJA8AvZTXE0g2wnQxRavuVYm8kDwOTNe9dfF5gxxSH1Wj8FmapbVK+EJlvegBzlXs4jcIYOGPggGWYvZlfrsPqH3o9obMp+s8VunwNU1KsqlxZGGFm1+74rmKP78vn/Yn83tmwexnyFSwOuLcCTZ6WBQLyZkYg3hTsUeceLViLjgWMSL4ZOx82dSLKKaGnSG4rvRyUd0N8x5RhbEfm4na9J+7zZn3/l8Ew5dAceL7GemAlq3IG3dGzWNfxL63hrY+2KfnzdQQTTQ1w4WE9S4seLvQBeGTv6I/FQUy4womQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(8676002)(186003)(5660300002)(44832011)(66946007)(6666004)(6916009)(6486002)(498600001)(66476007)(66556008)(52116002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQ3ShczlNrwI2PCJ2iqO9n3fLwuoDuoP9z3rx7yf7jx65CUUUY+3QodDsx08?=
 =?us-ascii?Q?T1uXO/i6fxGwv2rQ7srkJrhseNRKLRIIkkovBLwV7YjjISJr3O2PFgeJ8pVY?=
 =?us-ascii?Q?xYsoqCsdjso1nZ2vUuAkrjCz0WUke/VA5/CtcmD60U0Vm86Xucv8ao9/wIeX?=
 =?us-ascii?Q?Zzf4HgLZy8MC42LVnyp6SGeKG9ypuCAPjV5hw/avVRYlVHdkK7X6LZeh3V1c?=
 =?us-ascii?Q?V5P7WVU4SyMkSqZ5RBSVZ6uZ5Uaq6wuBJ4kCMFLNkjGZN+R2HWAKDlaaIdCp?=
 =?us-ascii?Q?SnFfkV66EvRADKavTM0u9zu2rpA2iJt/+E4GKTIasqDerez2BfkXNWvPLuwO?=
 =?us-ascii?Q?6gIPhGfGPqtJ2p/ZQyA5z7JleTP2JW/lZwd+hoywYhN6DYupp35SUjvIu6LO?=
 =?us-ascii?Q?zoMIOMYqRPf/plDrdpEmMJEV4p25YAvJf3oVxdws433t7b77pL/kcKAxUdSx?=
 =?us-ascii?Q?c/TKJieHip5zOVs92fTOeLQ0DKGW0Q8Cope08gaLT0gHCYNNzF8fllJp2PuX?=
 =?us-ascii?Q?AZGP2gVc9IumediGmD0ZrV/o/gIEAeqatUDTAOuasI/tQKrDpjwtQgnIF092?=
 =?us-ascii?Q?2By+kA+ur28xQNm9cXmJxJ41VGBWR4FcL6nqXathBfPPXf/IGMTnsh7MKEg+?=
 =?us-ascii?Q?/I0nlec5xN5Iw69e4WQ8PMzbLLk3+mQboKGjsKkqU7+XeDak6XMfKMkuEU19?=
 =?us-ascii?Q?4+tChoLfmpSVXcjv6t7AAeTJvXsPmouDoRRIwJwDPn8aOHLPN5iFOfwNu+/m?=
 =?us-ascii?Q?fr8GY5GsPfHVSTf/egpdEd84Q2ZISvdUQCwcgLczdiL7T7c840JBFUUhU7pU?=
 =?us-ascii?Q?VWWB0MyZEdxiwbyYXFDmxETlnjtAC+HK0G73DdSyCyZFCjUE48pfdRwv3h4O?=
 =?us-ascii?Q?0LA3KxnOInMeviCI15oWbCnFMNLC0U+mbp8XRO7HcvKTKNl01tWm7i0eAYxT?=
 =?us-ascii?Q?syhTAFRynHQPuCfxDsVv+4uEhGqeoKzy13l0O3VSCh7jI/KbvxV3EIBKfsKZ?=
 =?us-ascii?Q?XEicL4phPN1bNEWSJUaWAjO+d5ec582C82LglDoui+u/05zLAdHEfRSqAq6/?=
 =?us-ascii?Q?TGpgj+Y3At9UFiLVXfRY8y/FK1DkPORCfkKFz958+qpbVI9qOIt4XZ8PToxl?=
 =?us-ascii?Q?Vj2RqEMcPESoUrYf+KM8MlwxjNj6OyWlsrL/UUTQQ4W53vqXCVJNXWb7eQfk?=
 =?us-ascii?Q?i3UCOJjLn18TseOTap31POa16XfMFudjiraR2QNBy6uU57sTjai9giCO1Xp1?=
 =?us-ascii?Q?MVu/a+IimL3zEup2Bq6ay3bedqBE0TC9hG6a2U9XBRTcNWA5ECcUtHIw8fcD?=
 =?us-ascii?Q?vtL8lyQq4+ydgxr+6vWLU50k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dbb6d7-ca59-41e9-2b88-08d934ce46e8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:40.8697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgsXrUhxOyh4qDDDsYJpOKVakKgpt2WtXLgeUkk2BcBKQL2EmrpNaMVwcdlZgowjJhssCCifCFnhx1/EY/ud0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is for debug purposes only.
It conditionally generates partial migrations to test mixed
CPU/GPU memory domain pages in a prange easily.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8a3f21d76915..f71f8d7e2b72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -404,6 +404,20 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		}
 	}
 
+#ifdef DEBUG_FORCE_MIXED_DOMAINS
+	for (i = 0, j = 0; i < npages; i += 4, j++) {
+		if (j & 1)
+			continue;
+		svm_migrate_put_vram_page(adev, dst[i]);
+		migrate->dst[i] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 1]);
+		migrate->dst[i + 1] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 2]);
+		migrate->dst[i + 2] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 3]);
+		migrate->dst[i + 3] = 0;
+	}
+#endif
 out:
 	return r;
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
