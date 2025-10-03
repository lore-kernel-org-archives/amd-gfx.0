Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1E1CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 18:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197310E14C;
	Fri,  3 Oct 2025 18:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2Lz+KOY";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B26210E14C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 18:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btJ1TBqkavwO2NeWcD44rmWCOOXq15ntUOto9vIo3XUTTVXiOhSnldomUR483JSydTF//8LqTiazZ1x81qJEheJ+MsdmGmpJV9YZDwM33tDt5fV/kCGPAEP//cubwPmE6sZ6nDJA8TUAV2o60K6D195jFc8Gj4Lhoz1s5AeJPS23hzaJOiyWqtrEtNEYHUlgt2RZOgsObL3HYsWrEIk5eSbmibdPzpZr1OAxdKFYOq7W315NrbVRw4dw+H0ZUOxxKvQm5K/j6uQKl6kqQNRmhxxVMIoCT0NMFfDbudqmfd3Sq8Wcs+C3NUo05JyW2mdepPNM9jhHYZ5GiQfEJT4dcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzN2thAb8vTGKaAz2dIVVnRi6Vfxaa/F3Cf+8TSPOSw=;
 b=vPgXkn7k0jcrT1u5pO+BaWOh3MKoD096I5PgglxMWPgawwkSX82402GUCdjzAUAteEh+AYwo0KviIo038+KXCnSmpwUQZWTYU/05k0f6Pfxq9rck1YpWojptkVXsj+cbtyNdnJqY8fEibKc0P2NdtiQiXnEcPtzFCmd/zpsTHk+Iz4mq3a3avacuYh7KlXcVp7Af/V6LRXBHqIYVFCJz4jd1qePh0Jf5cfRYFq3YeyLCb/oIuW61mW2oltFStsKS9hKbw02pPuPcE1eOoreFy+DTTG4fGXJ36w57v1pB3LF8bAhBDGjDS9xMl4aLROd+wdqOSAh1ZYY5geDyWPHlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzN2thAb8vTGKaAz2dIVVnRi6Vfxaa/F3Cf+8TSPOSw=;
 b=R2Lz+KOYlF17lQdeuY/AwuwherCB4aQ9bNf5KJ6Mde8OkQIV8pO1Mu2ZD/TLUbgNk5DkVGmuFY6xR5fMHhzrBAYdkg/DgHD7PRVV0nS/uIr3v1j5Bn3Rttoh0SEPlhlVDCm7vTuqJ7SnXyOJx+384El1iEDZPiYO0XlsKG07wpE=
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.17; Fri, 3 Oct 2025 18:22:02 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 18:22:02 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: RE: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
Thread-Topic: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
Thread-Index: AQHcNJHBKakY3rRvRUKRe7OiMl40nLSwu9GA
Date: Fri, 3 Oct 2025 18:22:02 +0000
Message-ID: <DM4PR12MB656658906DDEEEA2D86AA64AE3E4A@DM4PR12MB6566.namprd12.prod.outlook.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-3-Philip.Yang@amd.com>
In-Reply-To: <20251003181518.24270-3-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-03T18:21:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6566:EE_|DM6PR12MB4089:EE_
x-ms-office365-filtering-correlation-id: c0a511fd-b865-490b-aab3-08de02a9bfec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?rOdn0z9hBmwXcTOR1A8yNtz22FEhGZUIa/KJzfErn4a0VjnJE4gxMxMcOXxb?=
 =?us-ascii?Q?SbREQtLMCn2GR0kHR03tfU2asEdC1cxd6fP+sLxXzg4Fl6V6EjxiQdgfI9u7?=
 =?us-ascii?Q?bsTsS0hSdxd5oPznj+seUMr+cYjWrQVTQ1MTny0pePktMC4DY901y8D9l9ck?=
 =?us-ascii?Q?/6geZLM831Ioh6oZo8X+VE2falP5Z9VkxjBo4r3C51fmCCnzEa9LRiic9osj?=
 =?us-ascii?Q?NyKqGhGuuEjWKLmsJSHdrayNe1E1MZUTp1uVMFKFSQF8CGT6oZOVfhdsfWL6?=
 =?us-ascii?Q?SXLoHpEx+0C6y0XiBGWgjQ2ovjC3wBhagXdJAtK93hbdcHgZjjjqRYbunwX0?=
 =?us-ascii?Q?Ga80C+bEHiNqZR/XzTohAzBTFxLFonwFL0vvbtYjJkAYrEqTxq3w4LRrIFE7?=
 =?us-ascii?Q?qKCH/hW3gVdmE1gM3X/JfIUCBi8eR0UtTmFxrDAW/YVlRfH5jUeJS1BKifJ+?=
 =?us-ascii?Q?zfQ3kLkvQaG/SFdrEzQRBED233IIgxqjz1Seop6n8gsxs5mgYKKwi8j74lj9?=
 =?us-ascii?Q?i2QHccL6jVTJV0iYC8yjLKyj1eiImvM+DFwv/AEIb4/J23EtKNlc+oSYPum6?=
 =?us-ascii?Q?RnMLm5T7NOMfAdIwN8dndB8G3RPlFlfCxQYkRe2CzOAT7+907v2TCSI6LE2E?=
 =?us-ascii?Q?+/HA4zZ3159ijNdbdYIVP450EFtgbGGIG9IiKjuo4HKKniLE1mMuHeZk8rAi?=
 =?us-ascii?Q?IHKXLi/9CaPvOdXkb+8C16obHCZKpeWdzqghuqhW4z9k6ynQeZfvQS3RcHT0?=
 =?us-ascii?Q?w/LTe5BwcL6Ef7zUI8RB3UtYHq/mguZvg1Yrj1aUyPFuaqnY5k8seiXnsmSR?=
 =?us-ascii?Q?XdHUvU0dYWt3rGFyEH/6kLFh18kO+gO6CCchCVXk6y5pYhtgf6V13hDLCGFL?=
 =?us-ascii?Q?KFysjIQm8FfByZmu9SLVrOUNJYElVALCSJ52qhAqBYiKTfaZY4IjsHPg/iUN?=
 =?us-ascii?Q?wrk4hitmjyRRPQ8ntPoTtCMW6qoH+fvE9EkfGyEMklTKhDfw7yJnoemjZBIU?=
 =?us-ascii?Q?oYEwzKB2rUjwROpBK/yRPyzR/29sm0k/PhauJxLEbnkVt+dy7pKUmq74RPum?=
 =?us-ascii?Q?UHEF2WNXfub/5TWbTmGeNDYWaWBLZx/IT3AIIRVz8ipqXXskfoKQh1m2uMbb?=
 =?us-ascii?Q?GXr8m1FgKqqDMq7zgjUfEV+oCmeqTWwT0nJdDhs4yBZeDYo2heiWsvOWMuE4?=
 =?us-ascii?Q?7H6zktnW8rUJk0QVebr+lgpbtCPP7bRGMSBZEY+2VjS7QsKVia8Imkrmnm0V?=
 =?us-ascii?Q?8Cwhr0otwthe03h8WujtSknwyUU1X5QUqerNPQ1In5xosw33D74aDYLg0Kpp?=
 =?us-ascii?Q?QTIzj0y1fqpdewQdJJEfkmNfQ35bd8IXEXuuyspOI3Fa0CK55gbkr/LgggHw?=
 =?us-ascii?Q?EKsgcXmMp3/CycQ6+xE/peEX4s3g7wXfdPEoFfGnWjI0GpM+5kfOvzI1tbsc?=
 =?us-ascii?Q?tPoFqiTD3Jo414Nsid+oAJOG+kLlHGq4OURkzYaQAMXuXArA+y0K8n4CPOPV?=
 =?us-ascii?Q?68sQj53uIPIIX7yy7qCOALNg+p3oB80cjvgb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rj8lGdM34qVH5kwQnKFXwgHf/jeoZvjpd6ZgW6LxxA7mquwCqgk6dT7IWA3Z?=
 =?us-ascii?Q?iwcKRssjQyXnZBTeyo0muRbNVpN8Q2WLMX2QBkBnet4TG+3OHGuAsuPchqGK?=
 =?us-ascii?Q?EvzV1BTzhV8nNLU0FzGFWg8qqqH+MzQcx3fad6o5dHlbhu1oLxwvh29kNGn1?=
 =?us-ascii?Q?XC03iUe6hhWzd+5Lg8ruSpOA1FAee1x2QLnuNkcJK0YMd9W2wgzXKhdvN8KN?=
 =?us-ascii?Q?5mZBZ5ByLILnHCXw116MCz0QsMZaIGNIwh4sGik1J4h0Y04SR6JZKQf4kqlG?=
 =?us-ascii?Q?b6lvzik69AO2ay9eqr9XfBkae/0At2+ONmgmBxtpYAwf4mjjKB2UtnH+7kLU?=
 =?us-ascii?Q?wP9sBcIcY8IiMEnptQrvc/3NtZNXUBKCSs7etjYpmDc/3wvBDI86tPBSxA/8?=
 =?us-ascii?Q?rRufNMHGlsmJFanZBKZer2TDx0NKLHxldRm2lo/H2+Y/DK0y/3RZeibKoE9A?=
 =?us-ascii?Q?TZTl1R9UJU4Nb6teWuXdWblt/tgyyOlJ1aCjlKKoLTzi0bU6Qufi6nTagtmk?=
 =?us-ascii?Q?edJP34thsV0d8+9eSHqxVOz8kdG+lFw/SaS39A+uFTazQxOStKgowYkpSdYE?=
 =?us-ascii?Q?BCIsB+WQw0w2mtdKOW5FFcz9PNcrO9GACdruDmz7tsV1GMurGxq9c9iC8Sp7?=
 =?us-ascii?Q?r2pYJtB1LSLFpNf1C1HGWul1b09km6JNLhuB0h8jXsO75HQxzseRrYjDskge?=
 =?us-ascii?Q?wxCT3/smEPmWhEXKIIHVuJPab06q2x6Y3BsBsBqJUciuUfSUUyXMoFtpjKY1?=
 =?us-ascii?Q?Y21BxQysGthV0KPmU+gB7tzSrI2NMVKsfp9gqxJ8AGdzjZgPrJbXieZHTFQa?=
 =?us-ascii?Q?6oiU/isky0/HO8Bs5/6DyZiyRN18Nc7pzqBeGbiqtlxM+3/qa7Z4AtP4IiGA?=
 =?us-ascii?Q?PIV00etqPeO3DuyT3oYXg0lgkPQu0ckRWbaHYOtcgqB4a9gOu6QtFT5ndcrz?=
 =?us-ascii?Q?c7BnESC14/BKx88wiL09ucqWKA1cqVW8eHrcdzGHc3gHq1SRmV5Vso0lHjRx?=
 =?us-ascii?Q?yC4skjSIOdQWzw+y+ZmDwOZ/9NIyzfyy2b5ooDw7v30tOmYlgMvW8XUlKf5A?=
 =?us-ascii?Q?71X/Qw0AL3+VpZB6IZM8Dz2rnY4luUkmt43+9xX//YV/Aws08UWNhZ/M39wa?=
 =?us-ascii?Q?GXxqpE/9UT+4wQv/V3b2/dOjfkelVXkDtzRipLf8PvzISnvnRGwrrLL6SJQQ?=
 =?us-ascii?Q?ntiUQ/eJkV+kaXbM+IZnvBJlOXhIR15iSJEWawMXMS3C43RvUQxZfCViSfXC?=
 =?us-ascii?Q?55KmNHdDOhbJWDMR6wYHHfB5v2+s2jpCcFykzKXPLStBPbMdYpTU4oE339Pf?=
 =?us-ascii?Q?YS9ZP9YClX5coQCEx/SSY6k27K57WbMhtcvDcHr5orR7JYCgZAfFLAMvMYgb?=
 =?us-ascii?Q?CS6YnICLP0bvH9Dst5OxjpqZrlhcYG6AEOt/Lg0JS4aoMkkLKa3iWBHVZE4+?=
 =?us-ascii?Q?ggP+Jm3cF5cos4NeZ5hsrxd4uObNV50LBMRODH8VD7677x3ddFnhlGapBhHZ?=
 =?us-ascii?Q?mbtGM+orDM619P0DRkI9s6TJeQjNXZXKT+PWjOKSW2MtyEEhBwzkfWoKrsqb?=
 =?us-ascii?Q?V5B4eTb2BCOqBLXx4NY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a511fd-b865-490b-aab3-08de02a9bfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 18:22:02.5459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slEVhb0F4p9ItiMawL7zlrO/TnGk8FZGUJMdoGI4vEwklztYD2YoUMwahs0o4jkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
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

The MADV_FREE is handled at madvise_free_single_vma(madvise_dontneed_free) =
from madvise_vma_behavior at mm/madvice.c.

It calls mmu_notifier_invalidate_range_start(&range) with MMU_NOTIFY_CLEAR =
to notify registered vm intervals. I am not sure how driver don't receive t=
he notification. Is there something else cause the problem?

Regards

Xiaogang

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>
Sent: Friday, October 3, 2025 1:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Hari=
sh.Kasiviswanathan@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Yang, =
Philip <Philip.Yang@amd.com>
Subject: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker

If vma is not found, the application has freed the memory using madvise MAD=
V_FREE, but driver don't receive the unmap from CPU MMU notifier callback, =
the memory is still mapped on GPUs. svm restore work will schedule the work=
 to retry forever. Then user queues not resumed and cause application hangs=
 to wait for queue finish.

svm restore work should unmap the memory range from GPUs then resume queues=
. If GPU page fault happens on the unmapped address, it is application use-=
after-free bug.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 ++++++++++++++--------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 0aadd20be56a..e87c9b3533b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct mm_str=
uct *mm,
                bool readonly;

                vma =3D vma_lookup(mm, addr);
-               if (vma) {
-                       readonly =3D !(vma->vm_flags & VM_WRITE);
+               next =3D vma ? min(vma->vm_end, end) : end;
+               npages =3D (next - addr) >> PAGE_SHIFT;

-                       next =3D min(vma->vm_end, end);
-                       npages =3D (next - addr) >> PAGE_SHIFT;
+               if (!vma || !(vma->vm_flags & VM_READ)) {
                        /* HMM requires at least READ permissions. If provi=
ded with PROT_NONE,
                         * unmap the memory. If it's not already mapped, th=
is is a no-op
                         * If PROT_WRITE is provided without READ, warn fir=
st then unmap
+                        * If vma is not found, addr is invalid, unmap from=
 GPUs
                         */
-                       if (!(vma->vm_flags & VM_READ)) {
-                               unsigned long e, s;
-
-                               svm_range_lock(prange);
-                               if (vma->vm_flags & VM_WRITE)
-                                       pr_debug("VM_WRITE without VM_READ =
is not supported");
-                               s =3D max(addr >> PAGE_SHIFT, prange->start=
);
-                               e =3D s + npages - 1;
-                               r =3D svm_range_unmap_from_gpus(prange, s, =
e,
-                                                      KFD_SVM_UNMAP_TRIGGE=
R_UNMAP_FROM_CPU);
-                               svm_range_unlock(prange);
-                               /* If unmap returns non-zero, we'll bail on=
 the next for loop
-                                * iteration, so just leave r and continue
-                                */
-                               addr =3D next;
-                               continue;
-                       }
+                       unsigned long e, s;
+
+                       svm_range_lock(prange);
+                       if (!vma)
+                               pr_debug("vma not found\n");
+                       else if (vma->vm_flags & VM_WRITE)
+                               pr_debug("VM_WRITE without VM_READ is not s=
upported");
+
+                       s =3D max(addr >> PAGE_SHIFT, prange->start);
+                       e =3D s + npages - 1;
+                       r =3D svm_range_unmap_from_gpus(prange, s, e,
+                                              KFD_SVM_UNMAP_TRIGGER_UNMAP_=
FROM_CPU);
+                       svm_range_unlock(prange);
+                       /* If unmap returns non-zero, we'll bail on the nex=
t for loop
+                        * iteration, so just leave r and continue
+                        */
+                       addr =3D next;
+                       continue;
+               }

-                       hmm_range =3D kzalloc(sizeof(*hmm_range), GFP_KERNE=
L);
-                       if (unlikely(!hmm_range)) {
-                               r =3D -ENOMEM;
-                       } else {
-                               WRITE_ONCE(p->svms.faulting_task, current);
-                               r =3D amdgpu_hmm_range_get_pages(&prange->n=
otifier, addr, npages,
-                                                              readonly, ow=
ner,
-                                                              hmm_range);
-                               WRITE_ONCE(p->svms.faulting_task, NULL);
-                               if (r) {
-                                       kfree(hmm_range);
-                                       hmm_range =3D NULL;
-                                       pr_debug("failed %d to get svm rang=
e pages\n", r);
-                               }
-                       }
+               readonly =3D !(vma->vm_flags & VM_WRITE);
+
+               hmm_range =3D kzalloc(sizeof(*hmm_range), GFP_KERNEL);
+               if (unlikely(!hmm_range)) {
+                       r =3D -ENOMEM;
                } else {
-                       r =3D -EFAULT;
+                       WRITE_ONCE(p->svms.faulting_task, current);
+                       r =3D amdgpu_hmm_range_get_pages(&prange->notifier,=
 addr, npages,
+                                                      readonly, owner,
+                                                      hmm_range);
+                       WRITE_ONCE(p->svms.faulting_task, NULL);
+                       if (r) {
+                               kfree(hmm_range);
+                               hmm_range =3D NULL;
+                               pr_debug("failed %d to get svm range pages\=
n", r);
+                       }
                }

                if (!r) {
--
2.49.0

