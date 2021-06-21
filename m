Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBE0C49EA5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6E260724
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 16:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6E260724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D88B6E203;
	Mon, 21 Jun 2021 16:04:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63376E1F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 16:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDvbvRW+eroTwxEFeSYXZb/f+UYsZqQK8UjXdINGP8efw7SGPgX1L+hZ233K9WUsZ+Ljm578frJ4Ef0IOiqCo1SFl1KnLI0IdnwIk3Uw383f2LBn5+iG6OhPk35AkWX0h7W386sdNkQmHckW5IUQfZHUSFPv0vUpj0xEnu4wvL/XpOqc/icb5BRLENMaAoJQ53vpJ/R+N2S1wyvOaPcJz5AkYPOTU2geLOg3d9/bxf5mKrRTIKit23HjitSVbF8Zy5ZVym0IBY8GMC0G3NOKW3qiFyPcsKtXSV6GcqbNtkakriKNsMdAQtOyacVH4eWu8RmHRahZIeM3rd0yYrYsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWkuZBPhksy1Brawnb6Lp9Om7hRHl6U8RKVVqGmCXxI=;
 b=XnP201UzMo6q/oBaS57DXn8IROBGiQ7tSvg+vZvMPqqJKDaFuoARf133A3AnLUWbdeF113eERtTSO1n/EL6QQsd1IDQySxO8rV/wov398LhTyO9bBXicUp6mpD+l+Yh64QR7hgZLm+LKvUcv30wMf5R2+6VETMsFGimiX8zibniqADv/uRbbg9wceoLjnSbv+HOEeXB+6aik1c5MimjRgocxa+//sXLUVUr0zp6M4nu9VZFQXv4YSWOhQyKVS26xDEp7/bVdiM5JWKDgLspeig1mn1NlXDl21rTxsu8GlSJlA55NYcFSEYTYDl5zRArx8g8Q/BjD2L9v9rFgYjjNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWkuZBPhksy1Brawnb6Lp9Om7hRHl6U8RKVVqGmCXxI=;
 b=3gnlDlU7eu8i6OWdbXrx+XWIoRE2t1MSI1QzrCVygXhduQJskmrpxN3eMsajtGlrSq90kWIjlu2oqjkqupmQfaBNaInyblc2JzgGr2oXZRQqG0aQ9A6RJXabNA5hV8uDsVat94EZ0AFNCraLUwrucTaXOoh4P10AU2c19o+iiNo=
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
Subject: [PATCH 07/10] drm/amdkfd: skip migration for pages already in VRAM
Date: Mon, 21 Jun 2021 11:04:20 -0500
Message-Id: <20210621160423.3517-7-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 896aff73-1bfb-423f-69cf-08d934ce46a4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2447A7AD4E81A55A96860EFDFD0A9@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs3ct5EOmGWLg8xRk9B4OiR56do90pbL6w5fMj8a2ddf55dtI8BmgQTtGW0WxRMK6Qlgj4fhRsQpG61pQrBZmEMJRjZk7SMBTx7YWpTET4hqUqtLIJCotVGCgmvzZMyVZtgwya90aZhon9PX5t1lxRCkRm0vTBmgQpgngxDctUMidvPJpzSBMrkera58tIg12UoDS2s9Q6KYgzvWWanhn0HoUSGgwDLVWRlZNDgTCkBhK74XtsNiflvga07VWTaRnGVWbWUwWBhCvnI7E18byRiExLdFxSRB8IZmy6PO4b+2yoTGi5kB1cCNkk1C5xcDC70Hsn7ifksrn++MtIfnb28lpiSKw3F+R4QSi61qSvNKuZ0LxWZUB0UnoMfo4rkLtEyhgXSUDLQUPvhwhEiodHjumf09fIa7Iiu/VvMZHBjTg4ecuojTE/iN2Mb0EW0bGx8ed6yIPI+xNQnCpeX4g68HnQxRMoQb5+ghfvf0L3aqtPcJJb7j3aLf8CKx12R4WeNedpWbXnDGQ8KDZ1owg/fZo0929on+VGvliuoQp1+k6bh0Bw9xj/1lSGkrCsTPNkHeGhs5dF4sdxsCwQ1tQsb5Y3Hx+Ds7XiAdbiqZXjvO1DIMfblBUbeslfbDXtsDbuNKklCq2sU4u1SLqdKEFu73sez36i9iVecK+Riith0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(26005)(38100700002)(86362001)(38350700002)(36756003)(956004)(8936002)(2616005)(16526019)(8676002)(186003)(5660300002)(44832011)(83380400001)(66946007)(6666004)(6916009)(6486002)(498600001)(66476007)(66556008)(52116002)(7696005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4/IvRYqhFi4s/rx2R4ZxUSB2rW8RlNXYM5THQ3ZEZddI7rARWFsLlKUpaKb?=
 =?us-ascii?Q?id8+su1aAEywRzgerciy1az/gexkGRhp+GWR0IiWLllnIAFCMpS9Xa1rVM2x?=
 =?us-ascii?Q?RUMf+eUgNeeny/jpTzFsdEg0gFYOHIGYbqTKPJk4Bfe+Kd8lpRMfnSa9+bnJ?=
 =?us-ascii?Q?9DpCMHz181H4Kix/1ybQEYrbUqhtIBGk4ciqBaWTUcTw6ppVwcGJRtOEwSLy?=
 =?us-ascii?Q?ZfWmCV4z4EgFP36+8iKpgh0RvWucZ2dH6kPFUL+141Mdrv218C2oRn6IDjOM?=
 =?us-ascii?Q?6ZsR3EnQimsV8NWshOQBtOvrc7eAaJUUcdJd3BLZr0l4Z1aAaSp7S82yOxdq?=
 =?us-ascii?Q?Fd/BjpJF6aUL0J2+TjQG41tZFl10e2vr64rGoed/OKDwoOzRTHo+gzFmNdhc?=
 =?us-ascii?Q?o3uwOx7xJUlNDt+iGWGFxIpkckYE63cMERhL4mLtHYTapza7OCUtjkV/HfoV?=
 =?us-ascii?Q?lRqKr3ruaYWcBLpNP8QitcTWH8TB9yIT0659ZP4on7KY5fLmKEhI21B/RAcH?=
 =?us-ascii?Q?7eCTp+t47DxRS0bUaKAJL/vM3Lc+6pq8sLxQE1WAyW9AtEr+3Do6aCtjKdDc?=
 =?us-ascii?Q?zceuP/m0hKbLxoB3WUAQ94SdZblrF+/OD5w8omeJdHQqGjFl2oo/fMa+x7bM?=
 =?us-ascii?Q?LUjvpUmLS+3UPzAdAYV7vhyeCoAVWIiScRqmsLy87geGuFP8b1nFgNvieo8p?=
 =?us-ascii?Q?Fsz7vO/Vw0fQkRpshys+ASExXAX98De1w3iGfO4xpC0542Xhs/CT84ByJERF?=
 =?us-ascii?Q?/vD+itxXkAu2rsRnGZK52/t9+IBPONMHGXfoagcXt6ZiMAm8lqWl58gXEI0c?=
 =?us-ascii?Q?FHtsU13yX1mF4ZNwCGdUbvRNcdVNPmjG5hmUea9jf8lQJ313hWH5FaYbRdza?=
 =?us-ascii?Q?8FSRBLnZkYUoJMOzd7ji/ziGk2XHiKhlQ+l1nki/2kH66/Yt513DUyWIKBOa?=
 =?us-ascii?Q?6Q8nT9412/yOOzmtPOT58mj4x0l3x9Qh0KzgvSewHT0vklnIKMNF9SHYLKM7?=
 =?us-ascii?Q?jJcSbGIOSzZgICE/b1P77Lpf9NPv9MkgiPp9HOpHiUnf/NCvE7Ci6GC7mR66?=
 =?us-ascii?Q?BaN+ck8NPTdKzIOQMXtVYXiNMwz6E5AJd6VVERK61S0ZVAfGM4/18e/ZGl4Z?=
 =?us-ascii?Q?FvbN8wREEp6lT7aD9UFAQi5dKcPfaemlELe7iBhFVg9MQCoJ03eexWty7cP0?=
 =?us-ascii?Q?Q2SUt5UP5XlU64g0Pg5AWAeFGHtpjRN/5kbu6dP9gmB/cXNtKWgQ46YP5BPz?=
 =?us-ascii?Q?cYE41lVJvMpvpsp0+HDZqPf5Nz13P04rgENGkxR6/OY0dTUFCt/q5x7Usquc?=
 =?us-ascii?Q?HDhvh5W/s26qNY4U4SPmmFoc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aff73-1bfb-423f-69cf-08d934ce46a4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 16:04:40.3758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeKf47bd5f+hE0tbiZIRLAYmxbo03DTe8YxDpCzNJMWcr98088O7UxSnCXw5XupxzjvI9Z2NkRGQH0uWIKaWww==
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

Migration skipped for pages that are already in VRAM
domain. These could be the result of previous partial
migrations to SYS RAM, and prefetch back to VRAM.
Ex. Coherent pages in VRAM that were not written/invalidated after
a copy-on-write.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 6fd68528c425..8a3f21d76915 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -329,14 +329,15 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 	for (i = j = 0; i < npages; i++) {
 		struct page *spage;
 
-		dst[i] = vram_addr + (j << PAGE_SHIFT);
-		migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate->dst[i]);
-
-		migrate->dst[i] = migrate_pfn(migrate->dst[i]);
-		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
-
-		if (migrate->src[i] & MIGRATE_PFN_VALID) {
+		spage = migrate_pfn_to_page(migrate->src[i]);
+		if (spage && !is_zone_device_page(spage)) {
+			dst[i] = vram_addr + (j << PAGE_SHIFT);
+			migrate->dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate->dst[i]);
+			migrate->dst[i] = migrate_pfn(migrate->dst[i]);
+			migrate->dst[i] |= MIGRATE_PFN_LOCKED;
+		}
+		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
 			spage = migrate_pfn_to_page(migrate->src[i]);
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
 					      DMA_TO_DEVICE);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
