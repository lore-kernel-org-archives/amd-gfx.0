Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E535ECAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 21:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E35510EAEC;
	Fri, 26 Sep 2025 21:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xQufNYtz";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013007.outbound.protection.outlook.com
 [40.93.196.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C54E10EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 21:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baGvpyYYFZ0mBGUE1qagOU8RtUGLoSbO3XChMbNhqLOmySvsItyXeQZ4elD7ZsfGdEQtpK/PZ+SBeB5hatRi3SJujVRsJ96SWmyIKJ9rV1vjhyC2MQKS7mNqLdOff/9xhGLFJccFvMwmKn4eScbQA88EfM1/3bpfr6vsZqWd9RPZk2zIpTbc6CyytyJ2I8zVhz3mUC9akub14/RybstohaNReDbMgX9p5+2kM9I+YzwPah50hr5YiYZXU6NLE07iLICHd/+oCS7/H29EarJ1Oyl8PPk32ho4oQKE0iGTpMxzq65jfiZdjBGTMe84OJYGbJCceWNSaBgcLlWFvZRg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ/GxqOgSoG8zFmqXvGpdsuqDm1vz7DDfcKRTyyTWrE=;
 b=ql7dKOwSw9cDz//B8xgcQrsstrru2BmbWiPw8hPCQFthjvXaPtWZgj9DSMh7DTmxmZP+8Vo+8jBbXGwoa4g9LEcj1nSFHSiVbR6VgDDatiTe2x4ihS2pzEWBT2iv5FahB9f5MxS+VoeO+T3gwV9/SCMSAlTSHCvtJ9OvEktsxlRnKLNwNkkrLe39IgdTlLfDIkkaauti7GcYluWPqqIFIpq/GKBW++bGVDUfGfmM0SbVxUQk5WIDxj1PHxluSBVnOXRYiin/UqcHiJ2sX5Hdk0kALIuGqkwmLLen98sVS0O1tZQk9sPHjb09kUmAAs+ilOYzSwmieioyYw8FmH+HyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ/GxqOgSoG8zFmqXvGpdsuqDm1vz7DDfcKRTyyTWrE=;
 b=xQufNYtz9aDT8tugR2/N2W97uz5RUFu+ErULLWnGxmqqILLCgSH/kvAULSpD06vC8ud/MySV6KeAypVz5upDhcmRZKJsF+Vzwhug3iTEXWcwTqNZ6cJqKrZlVD16G67DJbsjZBhtLXfym29zbubzAn1iANDjHymB3h4IMI1hPYo=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 21:39:00 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::9d0:6f92:2101:fbdd%4]) with mapi id 15.20.9137.012; Fri, 26 Sep 2025
 21:38:59 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Thread-Topic: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
Thread-Index: AQHcLykjslts+IX7k0GRvZEymQ8MvrSl/YrA
Date: Fri, 26 Sep 2025 21:38:59 +0000
Message-ID: <CY8PR12MB7099315B35DAA3E0282A84F68C1EA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250926210331.17401-1-Philip.Yang@amd.com>
In-Reply-To: <20250926210331.17401-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-26T21:38:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|BY5PR12MB4036:EE_
x-ms-office365-filtering-correlation-id: 099fbcb5-006e-4dd3-780d-08ddfd451a64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?R+nfdQPwvSUDFDuRbsdbFA1nQ2V5TGMhAhnlSWZqUVQqH4D8taXma3HXH18+?=
 =?us-ascii?Q?hf5uiujnKohnJ8hkyFe3tOQOqvBmLKKfZjZjrSByDAJrrG8y0MM6QIo48TeT?=
 =?us-ascii?Q?xYhuDanNhSMpmlLAnvGoNSWGt9+/NYl4rW8eREaLLyXqVpMebIWhTQHLA9Hn?=
 =?us-ascii?Q?73rg6Vp/fH8X4yIhz9nFKz699pZrtUil7QtmJ6NXiIhfsQ+dH9zqsnP9Bjwg?=
 =?us-ascii?Q?Vvlemho3k6dnItV3aXBWfXRdfU203xKtHXgQwhnraX/21yya4z0EeQZk5M/M?=
 =?us-ascii?Q?9DuoUoYBwpScviu9bk8H4kZpOag9aw4fA6gY7wMuKXhlkmlDwVAhZMJAMbz4?=
 =?us-ascii?Q?2CxdMg8P4JAJ3vbDnbJid9/3wTR2Fs0uoC4JxzOqeullszLe43ZGIIZRodU6?=
 =?us-ascii?Q?7SK3vw5cwAz+FUFFrk4nHn0D1BLubGDZRSYliOkn5Tg8vA0f2RmJSAshuWHV?=
 =?us-ascii?Q?xFB7itEdow86KG2tkcFY23KiwxGq5ucm44kRm/smUTHMdwvU0mpjaB5SRE1q?=
 =?us-ascii?Q?5xcG2tKCmmORJRrKiBTQLd7gW02+l5oWWl7nZ0HXlP7I8sKxkyjkzg1JhoY+?=
 =?us-ascii?Q?dTADvyc+0IOl8PoOaqMCy3Ofn9Xulpq4UpTuY8+39beZhfNshPtzJktsk9jB?=
 =?us-ascii?Q?TRckxP4eAwXzFUi9hMabTsr8gO0QtDmPocigCApiYAIHLTEBCPjX8/tPRmwh?=
 =?us-ascii?Q?sntbQyEs9UcWmTau8RpLW00uFKgOw7UAzbhzCqpZ32L10yNbs4OAdUi9pKDM?=
 =?us-ascii?Q?acH5aEMR6XT3xBqPe/J6d0ClKTEx4j8mXLEYfmvHpUK6jKE+FZLXEiBi4+OX?=
 =?us-ascii?Q?3Cvwsy+/E5R/TmFSJmy0rri1kTty7x7JljYIPjeGyuuhYjA9QONOD6Xzo7xo?=
 =?us-ascii?Q?oJqzE9rQuY18PB0UlihjOn+SHvdKre1nNEg7HLFrZDoKE3O5vJLk9tWVZBi/?=
 =?us-ascii?Q?/ffXGwuaaEYSmpnsXxNe7r3B6MDDyY7qxxLdux6lrLFqv7Rjb2//RLBops5i?=
 =?us-ascii?Q?ScHEUT2ag2L5uvS1gqNsKgEQOsUM3JsdjiNurZz5M+h9I8F7VEEuUBDCf8K2?=
 =?us-ascii?Q?HLyXxunBKEOdcJQiQPXmxROlUZTcJKu6vfDfeOrytCvfHr/juPhpwKFHIooK?=
 =?us-ascii?Q?kau9tFDe1KZLVo/GAWlmZtzm0U8jy9Gb4B2EqD38ci6Eye7uhHa3E4m32ObZ?=
 =?us-ascii?Q?U1OrpnRLde/14/pdDL5j6Arg1DkHX4uHnetaD5Q3bITtCdfrM06YHxIvCtAr?=
 =?us-ascii?Q?MkenaBWzi1NitSzYfqp9Ox/AY9bIrOFx4T0JSnjDBEazeKkXjhgN5w6esFnE?=
 =?us-ascii?Q?WtY6lcfYeTWUOTZ8FiWPPFSk1DWJxjA0fvL9PT85M2v/FaV8a7hdHqre2BY0?=
 =?us-ascii?Q?nEyk6BUHirL0xeuEVtgmKZIMK9gO/W5Gh+0FsKZ/xqijCHgSB6ET4WqCFNGZ?=
 =?us-ascii?Q?GIOoFPgmWX6PuFpY+tLQiTbK8M1+eBnmG8cJsBBP6MhGl0TDmDlkBMb2N+UT?=
 =?us-ascii?Q?x/wvxiSlHAaCs74SUOnWkPEmcf3/jjgV8Pfi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7VlOxFWnS30jVQW2ilAiu99Tm22GPhzsIWxYso8jnaA49rwj2u1xyucTdDnx?=
 =?us-ascii?Q?1B6eprsIx8qZZNSerYaHihcZOX7MCIl6oXezNKX4m96jVlKoC78tew2M94c8?=
 =?us-ascii?Q?Lqjq0PI2kBVvucI1dORCND9GAs2ugiP42MzDBrqEW4dLRRlIOQ27p4NcOPpf?=
 =?us-ascii?Q?TfcFWMWkl4erzGrZPh3qfRUU06iC2afmcwOTjZIi7283D+w5wQmNqxivoyZn?=
 =?us-ascii?Q?nYMJQDg+xaPnvf30h/3cnUeB4Z1/gGVLkxEQu7yYlEyl0QVV6MqpbhSz8+8T?=
 =?us-ascii?Q?PfSp+kjDq/wQPL6pu42i1tTXKa2Gg2JrgqJf8amb0Ql+A62P+3Ktrd0KsK8k?=
 =?us-ascii?Q?WzZKF2pitdbhPcAgjOEdH8RV7N+0qbAVruNOkdCY1l5znO3Jijapz6dvf8ei?=
 =?us-ascii?Q?83w+VP+cbE+W4BJBFwYiuFJMwBi16KSRh4/cGng/MNQB+EglKMwomKZBoP+b?=
 =?us-ascii?Q?+pT5nqi0O7f2xLUgWa8A5Y0gwCABYDXCcKwtQmy8BjV5sYKDffz6sa5mZSO1?=
 =?us-ascii?Q?eMqC6MaGh7xowINMk4ZB9Lq3wxoQ/JLSpgyEyKPaix5A4+nqruUjJFL6daSe?=
 =?us-ascii?Q?FDqrXyYLKHPc6BkZm+m8UQYboY5oQhXGtVu3k/SQP/GspvwTRSzohDV7Izm9?=
 =?us-ascii?Q?oOjmJaf7wb6adHyGPbNUGiwW3/OUlrwM5HYyt06cMhKw7qMI702lvBcy2fBn?=
 =?us-ascii?Q?jkLsjaTIX3vQ/svOJlQ+i1TheUcAMGqj2AxsWS+NjwV2j2wmph+64gcDjSZZ?=
 =?us-ascii?Q?6qSiUYwDiYdoQWY1EjDpaGZAeigbO+hE9bCVZC9sksOXkYqlkZI2tjAElBUw?=
 =?us-ascii?Q?Y8xA727Dy6JkYOb8l2YFas+MPvf2Mcgcl6QfBKa0H1EjcgGrB3RNSFsNn5cO?=
 =?us-ascii?Q?zuYEIDLy3iEMRG65de2dEfKMAix2i2v7TuFH3Q8xoK5DU2y55dNU7+dXvbaV?=
 =?us-ascii?Q?HktA4FadWaj6LeYJkbtrl3O54JzDn7z2q9Lmhf67qkiLSqC/zaDfR0GVDd9e?=
 =?us-ascii?Q?BfjXrmHCG+6gGuWIPGE6C9toSt6w/bKeQbuiW/awU8moPKXz3RCcY+8TPhEG?=
 =?us-ascii?Q?jg1J2GTgUz1WkzZR7DidwmKTIDPGCQ7XAcvRxsoG9pM9w+wAvW/DcfNJzCpt?=
 =?us-ascii?Q?Phw6jbKseFxkbcD6RF2pzRu2UKt/7m3bBeWk7He6dWddfTE27J8QotfILgcN?=
 =?us-ascii?Q?ynpoGiJCQCINu+S4FjnQmwA1sUrq/AwBPWkzOPJv0ckrxlSQII1H41OKGq0l?=
 =?us-ascii?Q?zMXS3aqQmq/lI3H3sylOivN3mvwTRJIn2JaJ7S0rPSWlwz4Uo6Ia5JMDBvwj?=
 =?us-ascii?Q?OZXKufA2kL9mfLkJSxUk8mp7NdQ6e4nxlbVZDI9CGwbDxXJ6o65fdJqkIGE1?=
 =?us-ascii?Q?JMpULRAOvg8QU58h6xFmEwsCjF+c5cllaVGOObafrFfTy8OYf0XjCYqbvltC?=
 =?us-ascii?Q?jrsGoKSfNVz0cELnFsy5LmJoEn1+/MfhCDqLPMM6hCkQXqWhGu2lQ4/5cEI5?=
 =?us-ascii?Q?06VNJw6y6XZ/1HjrMtHzKV+pzjs6YJZQbfCOxy7dEmHdsSa+M9UonPuc+9sg?=
 =?us-ascii?Q?YRJ+pDDGeTZjoHV5U1U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099fbcb5-006e-4dd3-780d-08ddfd451a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 21:38:59.3455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35UrWU4E9du3yNdRE4UHZxHa9qUmh2Qu//AQ42tu7JuY/LvoxK2nZB0wqz8/FSO3c4xrwBYoMKUVtPzhyuD3NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Friday, September 26, 2025 5:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>
Subject: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount

zone_device_page_init uses set_page_count to set vram page refcount to
1, there is race if step 2 happens between step 1 and 3.

1. CPU page fault handler get vram page, migrate the vram page to
system page
2. GPU page fault migrate to the vram page, set page refcount to 1
3. CPU page fault handler put vram page, the vram page refcount is
0 and reduce the vram_bo refcount
4. vram_bo refcount is 1 off because the vram page is still used.

Afterwards, this causes use-after-free bug and page refcount warning.

zone_device_page_init should not use in page migration, change to
get_page fix the race bug.

Add WARN_ONCE to report this issue early because the refcount bug is
hard to investigate.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index d10c6673f4de..15ab2db4af1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, uns=
igned long pfn)
        page =3D pfn_to_page(pfn);
        svm_range_bo_ref(prange->svm_bo);
        page->zone_device_data =3D prange->svm_bo;
-       zone_device_page_init(page);
+       get_page(page);
+       lock_page(page);
 }

 static void
@@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint=
32_t best_loc,
        if (mpages) {
                prange->actual_loc =3D best_loc;
                prange->vram_pages +=3D mpages;
+               /*
+                * To guarent we hold correct page refcount for all prange =
vram
+                * pages and svm_bo refcount.
+                * After prange migrated to VRAM, each vram page refcount h=
old
+                * one svm_bo refcount, and vram node hold one refcount.
+                * After page migrated to system memory, vram page refcount
+                * reduced to 0, svm_migrate_page_free reduce svm_bo refcou=
nt.
+                * svm_range_vram_node_free will free the svm_bo.
+                */
+               WARN_ONCE(prange->vram_pages =3D=3D kref_read(&prange->svm_=
bo->kref),
+                         "svm_bo refcount leaking\n");
        } else if (!prange->actual_loc) {
                /* if no page migrated and all pages from prange are at
                 * sys ram drop svm_bo got from svm_range_vram_node_new
--
2.49.0

