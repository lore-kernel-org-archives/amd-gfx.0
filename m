Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742DC433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED131613BF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 23:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED131613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE006EC77;
	Wed,  5 May 2021 23:00:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A2AD6EC77
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 23:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpJyk0GSmW+VB3S7qkMu2+n+5dDm+T69l7wVx6F2lP6u390oecG6o8MuQPJOp+LKsIk7imz3hVAVpWPgCCK+LfVlX5QFGR32RX7W6Y2hcEbCCIuqsxI1wIDjntpujdJCiuEw59QrkGDyJcT0s5J3/Oqol/WRTFKFGt1CqiqlmoTz2tM/t8c+g8XJl6GDk/2kjPbj0ZWn4wLVNruMc40XoZuV/KHUuf4y61wCnuBJGeyCfo0yDfZgnDcOV5b77LCRulmi+spHbaRzMMnL0Gl13k9sncPcl+IDiqbLOB/tTTvxgnfHEXySueoUghKz3VBMUPKCJErJf6Fy8TicBfYdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEK9OeSRaB3mK6x/BOhJue0ikuhG+RzyMmE9WiRrpuM=;
 b=EQ7Ulv7I4rIIFT8bRCBSKrBui01V+G4fWBLDBM/5sKYZkyYbjuNk+rpLHpR/fhO8pJTs7Z1R4UMYBWL0/ZHMaFrwZ6zlcTSVRe+IEjOMJa1LdQ/hVaSPECC+w4tyKtrfRpH8bSX0ajlQ1kXO2xtAqpIiDHTZOUlKwubTWYcab7OL5svmmjLi/1GeAMMzQdxvx2r/SXnPJvoBDnsmM/8sV5bSMhpz2z0I93rD+vnNAvbn8f5zcKwMYDMzvVEWp/6XKEL97xnZg/NthvDkkVeFoMZDHuAu/p3vIXweF7a8VjpT3OAtUPFU6C/XVNQ/m5gEOk5K6Uyp3qKPIjSDsqPbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEK9OeSRaB3mK6x/BOhJue0ikuhG+RzyMmE9WiRrpuM=;
 b=5d0OS6UFdPns/iGZzbNbBhVyKB+45g+K7KybYQiL3Bphp77IJfI/PMFK2LVeEZvrnl9+vBrbdh3s071X2Y+xM4NCEuwYGQKd/gpR6xjT7t9BcGaA9Y7/SLtFy2EFGQpXds38YlHRFCT6+HCa/snupq9n05MRKQp0KOTs8xb8zxU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 5 May
 2021 23:00:18 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 23:00:18 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: device pgmap owner at the svm migrate init
Date: Wed,  5 May 2021 17:59:42 -0500
Message-Id: <20210505225944.4425-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR10CA0019.namprd10.prod.outlook.com (2603:10b6:806:a7::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24 via Frontend Transport; Wed, 5 May 2021 23:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3077cffd-e24d-4d35-b2fe-08d910198d37
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26407C9FE3FBAFCA9F0274DAFD599@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDixQzh7hI+HnIuQwj45prU7KNBJQU/11+nZTPNRtfBWYbNSGGZldVZMg3+aNpqrn2KOyGFl/Muc6hGpUy3qOUWyxpmvz+CJyPZDZuGMBQEz0nWXclm6dMBSb2e2/tTapgxSlJ3/dNTLOhE0+WCVVEshTx4LLLmML+QLuPzr/ZZJWG4V1LocY9R/XfeyL/kgBV5te4OOyMbDZUHbVSgUO5zDFDb+5D9ajKCHNXKQql0UkIjE0FO3R6ACxsM6jvQ/Qnr8cKqwFkgHMBs0+wwhz6O0+RMJLSYC1ZgEF7pkfoWy7XB4d+AKAoohxPwIf05TXRVZwT4CzwFnpMYdWB+8A7fJI7iyUAlEYeVmIbrWwQpILi1ELauHGa3va/AQ05/O3D4fVHXYJ3mZgVQJTaqKiwGNBisq7Xbj6eCa8/OeA8pcJD8U8E8+hwOL1DT0OKUQlV8LX3C8kXtZjif5Na9I4OFCmiPts1yu2OIsz0wyC/CG6p8r49xwZ9Cu/JYRBxfwSN5CYHV+y/5D8pRko8l4SM8D2ycliZoGO/dVUeCuaCP9aRfOMWfsITAOV4nSxeHRWkDofSv+Z1kaYVUVVT73gSUkUf9wf//puUWAyHMk4ThBTpSpSikPpQHYoaLOiY7CLQASztR+75GbomqMFseIPMsqLZNFGNIIz/wPeF4vYjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(66556008)(66476007)(5660300002)(7696005)(52116002)(8936002)(44832011)(478600001)(36756003)(6486002)(2906002)(6916009)(8676002)(38350700002)(66946007)(38100700002)(86362001)(26005)(6666004)(2616005)(4326008)(316002)(83380400001)(16526019)(956004)(1076003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uO16IE/Cp80LaACG0ui6GEqHioQTtYQ1m2yGLp/aZ2K5+4NSv2LjLTRCmM1+?=
 =?us-ascii?Q?EHPeMlqlJxDK/Rdh1Uq51pvJOyWAIyOdQxuepvEZaFxyEkJPjpUpH8Lrh95P?=
 =?us-ascii?Q?sz8YsmdnrCyByefGY6GQ7dqY7+gEvp4IC/9FxZYo8w/wm3hE/wG5iuq7JuN2?=
 =?us-ascii?Q?qmiDqtS53p3atQNRI2tsxdCGc2FSA/M9RIFJSC8Gir8QQjN3b5c1uzVZYYHd?=
 =?us-ascii?Q?zMabM/mOMvxhsgJ2ad63CMA7ZsIVz0LjNVp66h1NN0VgRJDBM7pRZQrXVCJP?=
 =?us-ascii?Q?wYXKSLouTkp9FNzmRdw3Zm9cUof14G/2jKv2WsPdfQTtO1KsM+8UthiqiPBD?=
 =?us-ascii?Q?nS8vwJxbRXlfbuUHsy39favL1aJYhYSLJgfHbI336ahP6EwywRHTpeASxpX4?=
 =?us-ascii?Q?HBNIZ97ghiX/pqoN8oc4mYx6zWKRg8UIoOY5ykqaLYO+QgnvzCGwenSdmtb3?=
 =?us-ascii?Q?B5zsRxg9AeX+wEEx/5tDewrEaTzM/ugsFhltsrpjzZNLzCTcSj8R2qcByIgF?=
 =?us-ascii?Q?RIYnPhmG9ZZqr4zNrEDnJR/s6JiXM+NUinC6R9UhKJZ2lYOxxXln1t3IBlXe?=
 =?us-ascii?Q?eEp9Wy/R2oYTy+qSCmfSDDY7JL/t7WypnuXIbiTwS5PQsRa2kM72OoV/ZTBH?=
 =?us-ascii?Q?i/UkX7uVigdOlg3bJ+5SYM0CobE3dmWFv92KPU5tVw30WXZH5oEG0e1VpTyl?=
 =?us-ascii?Q?MYLBYT2NtjJqNKalUBXq+cQKIY0EtVpP2xC0/ob6OclhPbz+kDu9GrFAnRZ1?=
 =?us-ascii?Q?rAY9pGxTq61FnnEoekui4N7Fv9rZ/OvwZkkFiwgWR1ITd4sVrLmahXOItHI5?=
 =?us-ascii?Q?YEb11XwQqiuORTJ9aZUu/7v3veD0QvUigm7mVxGDo4y/zWytJHoNYtN+Aq2i?=
 =?us-ascii?Q?Ne3wKmLImnN4rnINwqiAr0w41kQ2uVB7ESv5Kk3Gpyywr8fkc/YxCE44XtI0?=
 =?us-ascii?Q?GTxvQbJy8odwl8G1gtp/IRoUo471n5m0C/U1000HlvYvDn1CllbRwRadpbWF?=
 =?us-ascii?Q?PN7dHHfwnzQ5wcsXnfPMGOc3mrDmnelOcLGrR74cKEWb+D7Am0KllKZLQDck?=
 =?us-ascii?Q?SeFAGeUf2r6GZjaWJyqHtknXcKh6EcRUfQRuK2rzb601htYFNKgSbORpM5fq?=
 =?us-ascii?Q?AcKyRgvHSokdsxzcVBDfMufUZTDE1OOGcsf3Xr5n8x2kOZiZAAmiHiH/d0Dk?=
 =?us-ascii?Q?V08jcPeLoe2Bc39cAh+5wfIkDnT7bKUg40aLnAdBbvQ24AhYLYelbOWzLYRG?=
 =?us-ascii?Q?9zFAb0ASzd5wIl1liBqfJHSC7xMSai/buXykX3THsL5mY0611jfjW5C6wNPd?=
 =?us-ascii?Q?5thmqOcH7Ni363HIjF80CHCC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3077cffd-e24d-4d35-b2fe-08d910198d37
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 23:00:18.1050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/67/VDgr9+1x4uEoOzKl+eLuwhEb8os+256NcOwKmO3jLieyKFMwhpqs50xgZvpRN0zQ+32OFexzNE1ns0ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
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

pgmap owner member at the svm migrate init could be referenced
to either adev or hive, depending on device topology.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6b810863f6ba..5723c6bc2afc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -426,7 +426,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_SYSTEM;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = (adev->hive) ? (void *)adev->hive : (void *)adev;
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -641,7 +641,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.start = start;
 	migrate.end = end;
 	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-	migrate.pgmap_owner = adev;
+	migrate.pgmap_owner = (adev->hive) ? (void *)adev->hive : (void *)adev;
 
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
@@ -907,7 +907,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	pgmap->range.start = res->start;
 	pgmap->range.end = res->end;
 	pgmap->ops = &svm_migrate_pgmap_ops;
-	pgmap->owner = adev;
+	pgmap->owner = (adev->hive) ? adev->hive : adev;
 	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
