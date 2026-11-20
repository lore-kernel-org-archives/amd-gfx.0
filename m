Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65C606A320
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gHSAPySg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE46010E14E;
	Fri, 20 Nov 2026 02:59:24 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF5710E05E
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 02:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxIk/wDh/kHC9ZUqp6Cyrxf8u3Cv/ngRdx2uxhVrMVfg4NCH5GL77rEZI/YVlLS44FUq/ETPiBtxAIdpWYufDqklkS6fua1oKNaiKch/M2RROMLNLq1iEs3sE0ZaKwXai0goHMTbxrLFSYFX1CG0dDkpydbMxEiQeljpGgo9f6z4CBoBQ+YhR2KgsROicjxARrJYtUwH7jECUvoRDWcQS2JesxPe7EUJVwy2ulh7779KAsXFYDaOj1WkJEkyRU2Z/2pl7FbixsDpLfwwMAPXHddxeCZUptXMSh5B2iCD1SbtOOmIfbLIDruRv07wRC9CimGuLHpuF/NWpwEIRvRlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h30Az8yijJl9wVbu9KRJ9U1NPu3hWpZT2OtJJNapbEM=;
 b=lApsuxdmSFVYRLBiEkAJ5zp5QJrtysdrL88rg+GkGNZvFdVaqC9Qg4szlaTN3zOVEvWrGmo7cbHOJIZgK5504ltgb0cW66cVm1FhEx60Jy2knHDntWRuvgTlwHUJ0eMhfWMcJR3fvrHf2VRgk8kx0HclULxIa/ZPgz5+LXsDtokaKb1gVUxTYxt+L9vvv3Sl03gtwCnq37dOymRj0tcBsa01Vu6ZrWFy8x4ZqOyVEm3vS93l6035PrCH5jPsiDDs+pj9gxiQO5wkVM2OaMLINnWz61z1+XryPWdZFdIOghfEUwMz4nbyZ/AcKAIbJR5OHWzSFoG0OAEmgWD+cmDagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h30Az8yijJl9wVbu9KRJ9U1NPu3hWpZT2OtJJNapbEM=;
 b=gHSAPySg0r7JQhctJHIxhShZ+mgttxy//AN9mOg9nTl2lccKw6LDEEpwYI6S23KggYcwUmw7ocsoWayoNsnMbjPQDVR/zbOWiGmxPx0EtRB5ha6NbWEJRXzdaAguB14/W79q7PzNE4/VpExwblv1/8RTzO2sQqtFGYtF+DnEj1E=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 02:58:27 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0615.015; Fri, 20 Nov 2026
 02:58:27 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix units when unmapping a PROT_NONE VMA from
 GPUs
Thread-Topic: [PATCH] drm/amdkfd: fix units when unmapping a PROT_NONE VMA
 from GPUs
Thread-Index: AQHdcBKTHSwkXfyqxEq1ilJ5+wZNZbc2VbaQ
Date: Fri, 20 Nov 2026 02:58:27 +0000
Message-ID: <CY5PR12MB63691EA7F634DB2B678FD700C1782@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261109062120.2302314-1-perry.yuan@amd.com>
In-Reply-To: <20261109062120.2302314-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-20T02:58:23.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SA3PR12MB7903:EE_
x-ms-office365-filtering-correlation-id: e1fd1b96-29c3-4709-cc5e-08df46b226a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261021123027099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: 1R1kz4JxGGHlvUb6nSphekCjPeW3SxE0nUDq4qUV/adxooBj8V797/CRa7HlinNf4rBaGv8wTI5yask3D2Ow8TyE8hvCTImnUqV2AkguMGnEUKOESFKwjOYObrGl7iCBz9IjGnWVzRdLi5pvrSWOw9mPbTpVnbQF4usWTzjzdghC8JbDIl9SHVQPqSawa9NuuIa2GFb7lPRmX7N4+AQZGhwgdS74jU/Jo1ej34ADp1aFW3TiifVp7DA/LoaqsxqmgvJ783D+q2dksFmRb9jbXiaBaAzGeaB2x88+iK13luGRzdeR4peK8PECRaMJQfh5EPMa9veCWTh+tOuEaJbrgYnbsme/c8R+Q2sHA6qPtTxFNLZ93051ixkmfxvzN+AL2Ybm9TSRq4hVoH7ntHxVgwuboCASJEVxxTHhz0CncywfTkPloB0/bDUOnDGMCZF6PlwvaFHkhNxI7/wDaROVkGT4AsjTxEehJZTBDs1bh2AZMFlcGmbXEy//2/GU4I47a6TWDKLtSuaFceWC27ambEqGAc0onRDUoVOE088wIzS8GeTQ3u+y/5z14vxmtWN1pPq6yidQPb+wp/dH1688nnXUUWg3buepAilXwyQh4KHIBWATdSDrB8wD7qirxTnoPZ4tnKlJekak58vIEecKLijWTuU4hQBMobLBWwhSeoqpQ0S0EaeElu1I5dLdqwMMDH7DJIiYA2BGkrWUkLiCpxM1gV2dCB5Wg+sXfLaWOJ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cJfJSSypdjOIfRCkyka6v/NFexs6FjIKXwX9srZmPYVx5tYaGr61ge2gooAl?=
 =?us-ascii?Q?8NoLA8Ug+olw2j1kzkNKy5gjIO8PtLQqPrez/oketEh4+4PsWpvvgri+Js9p?=
 =?us-ascii?Q?Y1VIlMaNIEoLkfMxsN3d3UN8W+2gg8rjub49Vo+Vm5sLbGvyzcXiJXEk/qfi?=
 =?us-ascii?Q?c3FhHBg02DsHMV9b2URYJu9hG7OUMT6wmn2ygqLHQLHfNVJVPXCsvG5A2EyF?=
 =?us-ascii?Q?jzWbASBSXOqt1l74UXuXvtayQwdJziH/Bp3Km5Pic5KvymZjhWWdoAcLUfVm?=
 =?us-ascii?Q?GEO7PU24L6ClWffj/0t/n6bPDEdXlE7auxOTHQU5/XLYWWEb3/lGx5iXjnCZ?=
 =?us-ascii?Q?r6itU3oIS1A/lCiw/c+sedCZJedIC/9Lod0ivApG+HtDYzSvU/JvDbmcSv2L?=
 =?us-ascii?Q?VjldulzvS23O2jPcIQrD9YOyuREe+NmagrfwlehX0TSxVr3Hu5thN/PLwP/5?=
 =?us-ascii?Q?H1CTJYLXLt944BxbEn8gLR4j6EtQNim9fVrlnxLYDsp1JixVi8nNlMNc8uMt?=
 =?us-ascii?Q?Yuy8vB7q0EL/zvnwfnLJpoIiVZ/+Zuv2gi792ZO+yoAEWpn0rMGu5eyMGt3F?=
 =?us-ascii?Q?/iJUYwttuJWsXVPte4+I3nyU6dK74ECnuJAGkWCZ9gvdZyOuFQWJSeU5vXvx?=
 =?us-ascii?Q?kdcKalXrRAyv6wt5afUjhSdU9KdkcpaRfdq/777cpmAJ0/8w1nfsRzEAphxL?=
 =?us-ascii?Q?sBVL+N7SHB0ACpf2tVo1BN82oGvSpA9i99JwkLh5uLBnhVjoVXxxKi2itfDX?=
 =?us-ascii?Q?FxIXGxlgzvk6H50Z45/P9GZ0QsErx1EbSXd+2/YOlyOH7PYDvP6Mb/Y6AMjB?=
 =?us-ascii?Q?mQ+mBHgtqGDFhpMxjAi1FhW0fWVTWq83Cohxe/l9YB8UPI8RIc2DlNXt+ROH?=
 =?us-ascii?Q?+5umKHerM96VW9W2bftXf4eqs4rPwH8TzTkWXOZWbppdPkXrJICiETe4hcF3?=
 =?us-ascii?Q?ZiaQtYueJovrCG7RURDYJrN80tciw1gEFxSSRkDKzoJbar2kLfG4eytt4R/k?=
 =?us-ascii?Q?Eko/+4xiCk0Vy3vxhBsPZZsAdSeqrXaJu8pB3QkYJLgv01NLaCLMzDEMMSV6?=
 =?us-ascii?Q?sQEGdjZZbvziFPIKwXTEl7noXpM7F4Xr4WMZe8XTdlBqiDnyJmyrQbHGvXhM?=
 =?us-ascii?Q?LG3RYXXCle4qTMDb/Lp7gkSxwqlPHYTzWZ0RWg/wD227te0XPp++vnifkQQ5?=
 =?us-ascii?Q?hpHqe5avoTQmvnEAoNYzJCTu6qUTjY3i6COJOo5czFYZqCJU5Dv3PmqVphTm?=
 =?us-ascii?Q?PzN1oLH8Dmjug4f/lS+KcFhumOEtsYdr+ddAFYjwMQxMUA+6wYkbjk8H80/4?=
 =?us-ascii?Q?KVa4Jx0BluiHzwZGKjedplO68wryOmrX8qBT2BqP/bTZUcRrnVE/k00EZpmJ?=
 =?us-ascii?Q?nU84XBhkzuqOFwT7zLr7oVCm4dTLcSE2FvK7IIiOaWHtJX52R0gxVHSYSi+P?=
 =?us-ascii?Q?nSdu1yaX7H9ffecQFgo990viua3FexnStiiXmY8LcapRq3osVC+X2hevtg8Y?=
 =?us-ascii?Q?eX/BXAwF6/tKcOFR4pqnQ5/O/FP9KF8Ox5SAwTLTFUOi0OnWgrgTdicly+A6?=
 =?us-ascii?Q?jPwZ2PWxBJy/gbjVo9w1G/AC5ewkvMVVcYF78If3LTRpdga1e7mRsZw8hHl8?=
 =?us-ascii?Q?zWF9p2yIVGdp2pNb/wV/mAPyyh08WuBhm9/GI268lxdl9bVEj1Nz/K+en4vZ?=
 =?us-ascii?Q?upYbHl6Bfpfs7UQAtXX8vhRIKs04jjtC9CUKL+tIQyDdXEA5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd1b96-29c3-4709-cc5e-08df46b226a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 02:58:27.5824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBxIjT547N3yZg30H+19qRU7ri0ih1ZNlo/0eCgwDzdUD6bakHwE14lwSGFaBMCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Public

This patch is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, November 9, 2026 2:21 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
Subject: [PATCH] drm/amdkfd: fix units when unmapping a PROT_NONE VMA from =
GPUs

In svm_range_validate_and_map(), start and end are byte addresses while pra=
nge->start and prange->last are page numbers. Mixing them makes e >=3D s fa=
lse in practice, so a VMA without VM_READ is never unmapped from the GPUs. =
The bounds also covered the whole request instead of the current VMA.

Use the page numbers of the current VMA, [addr, next).

Fixes: 0ed704d058ce ("drm/amdkfd: Handle lack of READ permissions in SVM ma=
pping")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 876476046926..968ad471ae85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1857,8 +1857,8 @@ static int svm_range_validate_and_map(struct mm_struc=
t *mm,
                                svm_range_lock(prange);
                                if (vma->vm_flags & VM_WRITE)
                                        pr_debug("VM_WRITE without VM_READ =
is not supported");
-                               s =3D max(start, prange->start);
-                               e =3D min(end, prange->last);
+                               s =3D max(addr >> PAGE_SHIFT, prange->start=
);
+                               e =3D min((next >> PAGE_SHIFT) - 1, prange-=
>last);
                                if (e >=3D s)
                                        r =3D svm_range_unmap_from_gpus(pra=
nge, s, e,
                                                       prange->bitmap_mappe=
d,
--
2.34.1

