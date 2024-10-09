Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1720CF043B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 04:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609FB10E63D;
	Wed,  9 Oct 2024 04:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C0w+5f1W";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA2B10E273
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 04:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wt5fq9kc+mN6/j9D9Mg8n5q3OI6+7xOsbweIy0JRiA5cEi8FY9w4hgq6fVTc0b6wCVdV0Aod+oui3x4s/Rpwpsos+U5oldi0VlKHttGK7HqqbwAhMF7hVzWgUtINcFNOrRqCydvdZMXjN3QPcV/J1Z/9GC8bF1itUuXaGeNfg467NSJAd0VFX8QXw1/MNRYnNLPRDAqxeNY1cISYqyI7RmrDVULk7qTi3A+qhjih2htAn8a9aYCe+gHXt2ZPvwDDbBDc6SA5oVvrsa1pXvsO5NNyXXD+TF9RkH6FDzwUyru/OAEjt066nA5FIQQw+kLovnCVUDFNQ0IsM45VSwpHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IkJ3YrV0XoarHLyGDG/ctVkbbUsbG7HMAg0ScqcXCI=;
 b=uTrxpcYXO0JDXPLNAoDsBCbLMcQelGCU+6x2cq8y7XDWlq8jp/M7nXc9E0qIA/2ccTNtChcghzRbJf9zpkCRtxCCcucKUYqiSz/fccfpe8sCriMslDUvCgVp2krfQqGfzFNR5f16CT37Td9LumpadxsxxYKa/uGMNeYxq1BTQfgJ+INr572GLD6n7NTutPuvyxkTypLck9PnTBWdmw5NaVWQSxaI52Quhr3SxoyI4zpYTSN+dFUyJNkfQDMKpuZZKxHLR3n3jYX4IbXh1x862r4LNteXYgx37RmQa5B7DqsHX9MIlox9fXI+Ngt1RdDTQg9niDk9Lcxi3xwFic0mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IkJ3YrV0XoarHLyGDG/ctVkbbUsbG7HMAg0ScqcXCI=;
 b=C0w+5f1WlQW73DTbGilpslQaz6WVIfJgXsw1Tnf0BHczuxPLhzTXMR4Nj/uT7EMxXuUldDGi2slYeUoajcy3Z1Rd+xkrI2+/Y+qXIGO0DPi4/U8gVuSCHjSCCyaGisQZi4OObjh+bJs45ZXCku//NVFfiCqpRFAtBRuJYbYK9dA=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 04:07:47 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 04:07:45 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu/swsmu: add automatic parameter to
 set_soft_freq_range
Thread-Topic: [PATCH 4/4] drm/amdgpu/swsmu: add automatic parameter to
 set_soft_freq_range
Thread-Index: AQHbFnY1l20jZGSxPUejNo5Dv76Yy7J91CaA
Date: Wed, 9 Oct 2024 04:07:45 +0000
Message-ID: <DM4PR12MB516554C1F724CBF79F351DE98E7F2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20241004155738.488919-1-alexander.deucher@amd.com>
 <20241004155738.488919-4-alexander.deucher@amd.com>
In-Reply-To: <20241004155738.488919-4-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9c1381ce-70fd-4f26-8b41-c7388f990b78;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-09T04:05:54Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB7648:EE_
x-ms-office365-filtering-correlation-id: 3c33a74b-c87c-4964-59af-08dce817ee09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eqhfqUXwJgCFh/6QU5PMP38MoinH3HZgiXq6cVJ6uGVXUn9xB84BEvxjrQMy?=
 =?us-ascii?Q?Ji0xGRw3NXxYCHMR7ALM1WES3mgErkeL09M5V83C6eqMOBN1DVivlV1VGb3q?=
 =?us-ascii?Q?v+MUY8QKSq/pQlBnyG/nB17WQViVCRseYsKpaS9AkfzUCoKtXmwKT+MC/RJ0?=
 =?us-ascii?Q?kRTyYENEz6Ot5IWqlTCBjeCDfb0sIYjUZcUXtxSbDM6QWoqQOvdq/AP7TkGC?=
 =?us-ascii?Q?IZNkb8enbMj08KM6d64e+U5kEDk8MmF+LCtKVwhVOi8+DfxSDjBS/dkzl6oL?=
 =?us-ascii?Q?Yz8qBHX7UxG0i7ESShOfSbjiBdIq/9b/Ox7mfcZBrdY0KBIVUFrkVGMawXa6?=
 =?us-ascii?Q?FLwhncVakRoZtKOuHqfekSMEoMVYtM/I+NY4UXW9ARZFe+af9jmRykaqIC60?=
 =?us-ascii?Q?Y1YkFkrzy0ExULZKRvHMkwk8Jogv1MBKRV/DXA+hvFBbI4u4d4SdBtWXZeNZ?=
 =?us-ascii?Q?CnMCMEM/C9+RbmnvLWMWEAvY7jOOfBaJWqkDPWTEIZ5uddcSWcX1IroSbY9d?=
 =?us-ascii?Q?54f390dbnPQQXfClJfGoRkfrC4J4F9NVlBhibwdK+A9b77Ps8OkBN8rpY5y+?=
 =?us-ascii?Q?q+fUZJAd/fgSXBCYWUOKAKNaw2hs07WzZXzjcaysiel3mC+uyTbVKot2IQ5c?=
 =?us-ascii?Q?N7tiMZJ83CIz9lT6RovANeBDdmK8vrsTDbAcLM/3EOZEidyjT//rCozqBUEJ?=
 =?us-ascii?Q?V7DrTfB3PLpFyW69B9GDCawLPv/ga9kg2miTvzuLlavsJrZ/Xgy+ryDasXgM?=
 =?us-ascii?Q?N4ic76nIFgkiW29vlxFEuZpc3i0M4P1YDKahmzoFqNw525FzVXwBeCi/8uqp?=
 =?us-ascii?Q?9sVJQ1QkvujTti5n/jW3RJAC5MwqwpWj2ZEK23l9szvYCkNN5KNePEQoedG4?=
 =?us-ascii?Q?+dZV+Brq3WhsfQKvof5O5OvRRUvqaga54ybwzegzheIcCrv7FtJ4KZr1Jfoy?=
 =?us-ascii?Q?EvbEu8cjeybXr7OpvW0PmyP2j4NJp1PYHjbXhTpwAlEu64tegoNjfh/Y4Uat?=
 =?us-ascii?Q?CDN+KkGnSb99Pb3Ajwspbtr0qB7u4VdRGBg6EYrPlBVmetHN+wW5S7nqE+//?=
 =?us-ascii?Q?WPsdxymPwJ6XxsxMi7GjsA61VBKIm0tJTSlupsllSO+wyvsD63PG/VZJzH0j?=
 =?us-ascii?Q?yhKtcZ3ynUxVxPvLYwG2OStRtuzUcE0PlFxbr5mumWqp6FP3vXSBW6GgqEe6?=
 =?us-ascii?Q?uPfKCoXNMQxsOEoZ1VRFr9nbttoHHlRsJ7+cv/2unXQgxR0vZs4glaRlFRIc?=
 =?us-ascii?Q?ia/WbePzkFNgNh9NY/x8WXv61smQ4RiGLgOKT7oO5/bnZAJ20M/OS3vMhIdS?=
 =?us-ascii?Q?GvBwyVKyd91pyFIdr7A69Q/cSiDEDA+AzsVTMvN2xMtj7w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NtErNx2svkeIRSMVx0IwBIvxlZcy6u2x1b6Oz70KmIFPItrOuqATJqzj0iSS?=
 =?us-ascii?Q?evXjdEEKNVfwlb6iregbRgSLbZ8CWYTHRttcd7Xgs1oIfvjckwezZwXJUbvw?=
 =?us-ascii?Q?jl1bBtVTsVgpr1c3vTWoQvg/EvL0Ngy64EAcMdL1xwsOSsgwz2210yhEbmzL?=
 =?us-ascii?Q?/lgHVyS2ZxKJnTWUJLlE4VwYvUGAjQx8K2sszo4qdR5lGob7ZNq570OUbmun?=
 =?us-ascii?Q?TodNyFEEMLyj8vKa3ydSgWyd3pdLiZuc/pnByrNDnYHrrQnv3VsLHDhFJeKg?=
 =?us-ascii?Q?q9lNJ4x5r3cjPKks2xdGkdnDY7cpQKIppdRdHKKSHujGp+HOikh1TnwcW48e?=
 =?us-ascii?Q?8l92I34zof56RuB28YeqEXROiCY2HWTmnwjijcgKK9LhLW61uvJkkvk2vFQY?=
 =?us-ascii?Q?eBqrmBK9yQPyyronjdBwxJ9wV6icE7RyplpQ8jLrJSwR/hW1jcflxOy25Eqj?=
 =?us-ascii?Q?WH2gGBtkS2hKi3ZpS3DrZtxteSvKVUXJmG0vSMrd0dAvyxMuvFIS9P9gn4IA?=
 =?us-ascii?Q?h6Zngm3dp2KUEAmZgzaNztpl45EFN3iQND5hcLYPzTCXfChCNLqkRwU24tr7?=
 =?us-ascii?Q?aKzx06UpNyw0GYr6bE6WMs9kSp9CtXAlFRrQXaW8HHvv2qygTN4fX1nxySnd?=
 =?us-ascii?Q?TmuL3tUDGyBJdOnFLzkYHOrErnb1ccaLXbnoUaBfL2M6WGXGriSa2UzgjFKP?=
 =?us-ascii?Q?7xhpxCK1zUMEyBk9+iYdRea59kog3g0CO6aOQJAdrvpEjTkihZ4nnNYYG52P?=
 =?us-ascii?Q?kpVjqYItdmEphPLy1pXOPWLGS2EvsFIRCfamrTWnUHP6IbFsY0Vjo2Qi9q/2?=
 =?us-ascii?Q?uv7DVbErwVKQDBg6dQUEL9EYkIcOPTYAKp8A7qqJDC+C/F59l3rYQk4OpufY?=
 =?us-ascii?Q?rIRDCaddMl6dQENzMUGOQT3NYcq/OmwoRhK1u8SDuz8toy+UeF+2YvUSV/aJ?=
 =?us-ascii?Q?5BiFVtVfydDwPbBAc0ork2i2lea2R+LKIVKKlU8d4yD0wLHup6EDyytffNf8?=
 =?us-ascii?Q?MJViFBBtulD5EuJbEarlbe61u1hU90VYDiWXsRY2Fs2BBXUzippaGhv18H32?=
 =?us-ascii?Q?9ry9snWklzZTevIRmEHVvsXMvb/Bpsydc7UuUnabVwwKIkCDo+5MZwI8Io8S?=
 =?us-ascii?Q?mIKe0avebT1eYRJYtkuZnozmlecmWFYetwZX9I2x/Zan3RJgTXSKNGjSXRqN?=
 =?us-ascii?Q?Xar78lWSaCah8s/vf22TkK0Kt+HluPwcy/IXi8eWek8apUdqhaB7H8dPS8SD?=
 =?us-ascii?Q?m6Asxxldi9APU9QqhAfRJE02i1yUPFBd3d2pA7irbHHfGoRuYuEGUTVOKmEI?=
 =?us-ascii?Q?135Bm5jTPrmoJqGrPm4MudJk2OW03ZlszyNtsly/50xoME/VrCtQClwhw4bd?=
 =?us-ascii?Q?8s73bNasQR/iWFR6AcyABHj6Jd9SCev2DiLcE0QIGPeMLZd1Okk5SnFKhF5a?=
 =?us-ascii?Q?+zOUfF3jnExihY08XFSb14OPDtSwi7Fmj2Z6G6FtnrpCaBTItQlSlZuwIq0C?=
 =?us-ascii?Q?FyyqQZZ2r66RBHl//SzxRTAGHC6hH9pPDjCP6WO93188GFig8UV9fc2kBzrS?=
 =?us-ascii?Q?kEGfW1C1oyrurIm9ww8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33a74b-c87c-4964-59af-08dce817ee09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 04:07:45.4658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAg1nVNrpmbrWqMoIFDydfByyO3EpuyLw97wMHs4Jf1iRyYFW8R5HZiENx67g+NF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
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

Pmfw internally can clamp to its min frequency and max frequency.
So this approach is good.
Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, October 4, 2024 11:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/swsmu: add automatic parameter to set_soft_=
freq_range

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On chips that support it, you can specificy 0 and 0xffff for min and max an=
d the PMFW will use that to determine the optimal min and max.  This enable=
s optimal performance when the user manually switches between performance l=
evels using sysfs.
Previously we'd set soft min/max which could limit performance.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-  drivers/gpu/drm/amd=
/pm/swsmu/inc/smu_v11_0.h  |  2 +-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v1=
2_0.h  |  2 +-  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-  driv=
ers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++----
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 14 ++++----
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  2 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 ++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 34 +++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 +-  .../drm/amd/pm/swsm=
u/smu13/smu_v13_0_5_ppt.c  | 22 +++++++-----  .../drm/amd/pm/swsmu/smu13/sm=
u_v13_0_6_ppt.c  | 15 ++++----  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.=
c  |  3 +-  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 36 +++++++++++-=
-------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 33 ++++++++++++-----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  3 +-
 21 files changed, 152 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ceaeb0152a5d..accc96a03bd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -140,7 +140,8 @@ int smu_set_soft_freq_range(struct smu_context *smu,
                ret =3D smu->ppt_funcs->set_soft_freq_limited_range(smu,
                                                                  clk_type,
                                                                  min,
-                                                                 max);
+                                                                 max,
+
+ false);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 727da0c37e06..8bb32b3f0d9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1255,7 +1255,8 @@ struct pptable_funcs {
         * @set_soft_freq_limited_range: Set the soft frequency range of a =
clock
         *                               domain in MHz.
         */
-       int (*set_soft_freq_limited_range)(struct smu_context *smu, enum sm=
u_clk_type clk_type, uint32_t min, uint32_t max);
+       int (*set_soft_freq_limited_range)(struct smu_context *smu, enum sm=
u_clk_type clk_type, uint32_t min, uint32_t max,
+                                          bool automatic);

        /**
         * @set_power_source: Notify the SMU of the current power source.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v11_0.h
index c2ab336bb530..ed8304d82831 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -255,7 +255,7 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_context =
*smu, enum smu_clk_type c
                                                 uint32_t *min, uint32_t *m=
ax);

 int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
-                           uint32_t min, uint32_t max);
+                                         uint32_t min, uint32_t max,
+ bool automatic);

 int smu_v11_0_set_hard_freq_limited_range(struct smu_context *smu,
                                          enum smu_clk_type clk_type, diff =
--git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/=
pm/swsmu/inc/smu_v12_0.h
index 1ad2dff71090..0886d8cffbd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -56,7 +56,7 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *=
smu);  int smu_v12_0_mode2_reset(struct smu_context *smu);

 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
-                           uint32_t min, uint32_t max);
+                                         uint32_t min, uint32_t max,
+ bool automatic);

 int smu_v12_0_set_driver_table_location(struct smu_context *smu);

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index e58220a7ee2f..044d6893b43e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -219,7 +219,7 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_context =
*smu, enum smu_clk_type c
                                    uint32_t *min, uint32_t *max);

 int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
-                                         uint32_t min, uint32_t max);
+                                         uint32_t min, uint32_t max,
+ bool automatic);

 int smu_v13_0_set_hard_freq_limited_range(struct smu_context *smu,
                                          enum smu_clk_type clk_type, diff =
--git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/=
pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..6cada19a8482 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -186,7 +186,7 @@ int smu_v14_0_get_dpm_ultimate_freq(struct smu_context =
*smu, enum smu_clk_type c
                                    uint32_t *min, uint32_t *max);

 int smu_v14_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
-                                         uint32_t min, uint32_t max);
+                                         uint32_t min, uint32_t max,
+ bool automatic);

 int smu_v14_0_set_hard_freq_limited_range(struct smu_context *smu,
                                          enum smu_clk_type clk_type, diff =
--git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/a=
md/pm/swsmu/smu11/navi10_ppt.c
index 16af1a329621..9fa305ba6422 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1689,7 +1689,7 @@ static int navi10_force_clk_levels(struct smu_context=
 *smu,
                if (ret)
                        return 0;

-               ret =3D smu_v11_0_set_soft_freq_limited_range(smu, clk_type=
, min_freq, max_freq);
+               ret =3D smu_v11_0_set_soft_freq_limited_range(smu,
+ clk_type, min_freq, max_freq, false);
                if (ret)
                        return 0;
                break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b29cb74c47b..77e58eb46328 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1469,7 +1469,7 @@ static int sienna_cichlid_force_clk_levels(struct smu=
_context *smu,
                if (ret)
                        goto forec_level_out;

-               ret =3D smu_v11_0_set_soft_freq_limited_range(smu, clk_type=
, min_freq, max_freq);
+               ret =3D smu_v11_0_set_soft_freq_limited_range(smu,
+ clk_type, min_freq, max_freq, false);
                if (ret)
                        goto forec_level_out;
                break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8981302b19c8..480cf3cb204d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1764,7 +1764,8 @@ int smu_v11_0_get_dpm_ultimate_freq(struct smu_contex=
t *smu, enum smu_clk_type c  int smu_v11_0_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                          enum smu_clk_type clk_type,
                                          uint32_t min,
-                                         uint32_t max)
+                                         uint32_t max,
+                                         bool automatic)
 {
        int ret =3D 0, clk_id =3D 0;
        uint32_t param;
@@ -1779,7 +1780,10 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu=
_context *smu,
                return clk_id;

        if (max > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (max & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0xffff);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (max &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxByFreq,
                                                  param, NULL);
                if (ret)
@@ -1787,7 +1791,10 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu=
_context *smu,
        }

        if (min > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (min & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (min &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMinByFreq,
                                                  param, NULL);
                if (ret)
@@ -1855,6 +1862,7 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,
        uint32_t mclk_min =3D 0, mclk_max =3D 0;
        uint32_t socclk_min =3D 0, socclk_max =3D 0;
        int ret =3D 0;
+       bool auto_level =3D false;

        switch (level) {
        case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1874,6 +1882,7 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,
                mclk_max =3D mem_table->max;
                socclk_min =3D soc_table->min;
                socclk_max =3D soc_table->max;
+               auto_level =3D true;
                break;
        case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
                sclk_min =3D sclk_max =3D pstate_table->gfxclk_pstate.stand=
ard;
@@ -1906,13 +1915,15 @@ int smu_v11_0_set_performance_level(struct smu_cont=
ext *smu,
        if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(11, 0, 2=
)) {
                mclk_min =3D mclk_max =3D 0;
                socclk_min =3D socclk_max =3D 0;
+               auto_level =3D false;
        }

        if (sclk_min && sclk_max) {
                ret =3D smu_v11_0_set_soft_freq_limited_range(smu,
                                                            SMU_GFXCLK,
                                                            sclk_min,
-                                                           sclk_max);
+                                                           sclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;
        }
@@ -1921,7 +1932,8 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v11_0_set_soft_freq_limited_range(smu,
                                                            SMU_MCLK,
                                                            mclk_min,
-                                                           mclk_max);
+                                                           mclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;
        }
@@ -1930,7 +1942,8 @@ int smu_v11_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v11_0_set_soft_freq_limited_range(smu,
                                                            SMU_SOCCLK,
                                                            socclk_min,
-                                                           socclk_max);
+                                                           socclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 22737b11b1bf..a333ab827f48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1091,9 +1091,10 @@ static int vangogh_set_power_profile_mode(struct smu=
_context *smu, long *input,  }

 static int vangogh_set_soft_freq_limited_range(struct smu_context *smu,
-                                         enum smu_clk_type clk_type,
-                                         uint32_t min,
-                                         uint32_t max)
+                                              enum smu_clk_type clk_type,
+                                              uint32_t min,
+                                              uint32_t max,
+                                              bool automatic)
 {
        int ret =3D 0;

@@ -1299,7 +1300,7 @@ static int vangogh_force_dpm_limit_value(struct smu_c=
ontext *smu, bool highest)
                        return ret;

                force_freq =3D highest ? max_freq : min_freq;
-               ret =3D vangogh_set_soft_freq_limited_range(smu, clk_type, =
force_freq, force_freq);
+               ret =3D vangogh_set_soft_freq_limited_range(smu, clk_type,
+ force_freq, force_freq, false);
                if (ret)
                        return ret;
        }
@@ -1335,7 +1336,7 @@ static int vangogh_unforce_dpm_levels(struct smu_cont=
ext *smu)
                if (ret)
                        return ret;

-               ret =3D vangogh_set_soft_freq_limited_range(smu, clk_type, =
min_freq, max_freq);
+               ret =3D vangogh_set_soft_freq_limited_range(smu, clk_type,
+ min_freq, max_freq, false);

                if (ret)
                        return ret;
@@ -1354,7 +1355,7 @@ static int vangogh_set_peak_clock_by_device(struct sm=
u_context *smu)
        if (ret)
                return ret;

-       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_FCLK, fclk_fre=
q, fclk_freq);
+       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_FCLK,
+ fclk_freq, fclk_freq, false);
        if (ret)
                return ret;

@@ -1362,7 +1363,7 @@ static int vangogh_set_peak_clock_by_device(struct sm=
u_context *smu)
        if (ret)
                return ret;

-       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_SOCCLK, socclk=
_freq, socclk_freq);
+       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_SOCCLK,
+ socclk_freq, socclk_freq, false);
        if (ret)
                return ret;

@@ -1370,7 +1371,7 @@ static int vangogh_set_peak_clock_by_device(struct sm=
u_context *smu)
        if (ret)
                return ret;

-       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_VCLK, vclk_fre=
q, vclk_freq);
+       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_VCLK,
+ vclk_freq, vclk_freq, false);
        if (ret)
                return ret;

@@ -1378,7 +1379,7 @@ static int vangogh_set_peak_clock_by_device(struct sm=
u_context *smu)
        if (ret)
                return ret;

-       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_DCLK, dclk_fre=
q, dclk_freq);
+       ret =3D vangogh_set_soft_freq_limited_range(smu, SMU_DCLK,
+ dclk_freq, dclk_freq, false);
        if (ret)
                return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu12/renoir_ppt.c
index cc0504b063fa..0b210b1f2628 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -707,7 +707,7 @@ static int renoir_force_dpm_limit_value(struct smu_cont=
ext *smu, bool highest)
                        return ret;

                force_freq =3D highest ? max_freq : min_freq;
-               ret =3D smu_v12_0_set_soft_freq_limited_range(smu, clk_type=
, force_freq, force_freq);
+               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
+ clk_type, force_freq, force_freq, false);
                if (ret)
                        return ret;
        }
@@ -740,7 +740,7 @@ static int renoir_unforce_dpm_levels(struct smu_context=
 *smu) {
                if (ret)
                        return ret;

-               ret =3D smu_v12_0_set_soft_freq_limited_range(smu, clk_type=
, min_freq, max_freq);
+               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
+ clk_type, min_freq, max_freq, false);
                if (ret)
                        return ret;
        }
@@ -911,7 +911,7 @@ static int renoir_set_peak_clock_by_device(struct smu_c=
ontext *smu)
        if (ret)
                return ret;

-       ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_f=
req, sclk_freq);
+       ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK,
+ sclk_freq, sclk_freq, false);
        if (ret)
                return ret;

@@ -919,7 +919,7 @@ static int renoir_set_peak_clock_by_device(struct smu_c=
ontext *smu)
        if (ret)
                return ret;

-       ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_f=
req, uclk_freq);
+       ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_UCLK,
+ uclk_freq, uclk_freq, false);
        if (ret)
                return ret;

@@ -961,13 +961,13 @@ static int renior_set_dpm_profile_freq(struct smu_con=
text *smu,
        }

        if (sclk)
-               ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_SCLK=
, sclk, sclk);
+               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
+ SMU_SCLK, sclk, sclk, false);

        if (socclk)
-               ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_SOCC=
LK, socclk, socclk);
+               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
+ SMU_SOCCLK, socclk, socclk, false);

        if (fclk)
-               ret =3D smu_v12_0_set_soft_freq_limited_range(smu, SMU_FCLK=
, fclk, fclk);
+               ret =3D smu_v12_0_set_soft_freq_limited_range(smu,
+ SMU_FCLK, fclk, fclk, false);

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu12/smu_v12_0.c
index ed15f5a0fd11..3d3cd546f0ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -211,7 +211,7 @@ int smu_v12_0_mode2_reset(struct smu_context *smu)  }

 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum sm=
u_clk_type clk_type,
-                           uint32_t min, uint32_t max)
+                                         uint32_t min, uint32_t max,
+ bool automatic)
 {
        int ret =3D 0;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2c35eb31475a..f6b029354327 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1297,9 +1297,10 @@ static int aldebaran_set_performance_level(struct sm=
u_context *smu,  }

 static int aldebaran_set_soft_freq_limited_range(struct smu_context *smu,
-                                         enum smu_clk_type clk_type,
-                                         uint32_t min,
-                                         uint32_t max)
+                                                enum smu_clk_type clk_type=
,
+                                                uint32_t min,
+                                                uint32_t max,
+                                                bool automatic)
 {
        struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
        struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_context; =
@@ -1328,7 +1329,7 @@ static int aldebaran_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                        return 0;

                ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK,
-                                                           min, max);
+                                                           min, max,
+ false);
                if (!ret) {
                        pstate_table->gfxclk_pstate.curr.min =3D min;
                        pstate_table->gfxclk_pstate.curr.max =3D max; @@ -1=
348,7 +1349,7 @@ static int aldebaran_set_soft_freq_limited_range(struct sm=
u_context *smu,
                /* Restore default min/max clocks and enable determinism */
                min_clk =3D dpm_context->dpm_tables.gfx_table.min;
                max_clk =3D dpm_context->dpm_tables.gfx_table.max;
-               ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_GFXC=
LK, min_clk, max_clk);
+               ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
+ SMU_GFXCLK, min_clk, max_clk, false);
                if (!ret) {
                        usleep_range(500, 1000);
                        ret =3D smu_cmn_send_smc_msg_with_param(smu,
@@ -1422,7 +1423,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_
                        min_clk =3D dpm_context->dpm_tables.gfx_table.min;
                        max_clk =3D dpm_context->dpm_tables.gfx_table.max;

-                       return aldebaran_set_soft_freq_limited_range(smu, S=
MU_GFXCLK, min_clk, max_clk);
+                       return
+ aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk,
+ max_clk, false);
                }
                break;
        case PP_OD_COMMIT_DPM_TABLE:
@@ -1441,7 +1442,7 @@ static int aldebaran_usr_edit_dpm_table(struct smu_co=
ntext *smu, enum PP_OD_DPM_
                        min_clk =3D pstate_table->gfxclk_pstate.custom.min;
                        max_clk =3D pstate_table->gfxclk_pstate.custom.max;

-                       return aldebaran_set_soft_freq_limited_range(smu, S=
MU_GFXCLK, min_clk, max_clk);
+                       return
+ aldebaran_set_soft_freq_limited_range(smu, SMU_GFXCLK, min_clk,
+ max_clk, false);
                }
                break;
        default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..6cfd66363915 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1608,7 +1608,8 @@ int smu_v13_0_get_dpm_ultimate_freq(struct smu_contex=
t *smu, enum smu_clk_type c  int smu_v13_0_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                          enum smu_clk_type clk_type,
                                          uint32_t min,
-                                         uint32_t max)
+                                         uint32_t max,
+                                         bool automatic)
 {
        int ret =3D 0, clk_id =3D 0;
        uint32_t param;
@@ -1623,7 +1624,10 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu=
_context *smu,
                return clk_id;

        if (max > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (max & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0xffff);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (max &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxByFreq,
                                                      param, NULL);
                if (ret)
@@ -1631,7 +1635,10 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu=
_context *smu,
        }

        if (min > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (min & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (min &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMinByFreq,
                                                      param, NULL);
                if (ret)
@@ -1708,6 +1715,7 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
        uint32_t dclk_min =3D 0, dclk_max =3D 0;
        uint32_t fclk_min =3D 0, fclk_max =3D 0;
        int ret =3D 0, i;
+       bool auto_level =3D false;

        switch (level) {
        case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1739,6 +1747,7 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                dclk_max =3D dclk_table->max;
                fclk_min =3D fclk_table->min;
                fclk_max =3D fclk_table->max;
+               auto_level =3D true;
                break;
        case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
                sclk_min =3D sclk_max =3D pstate_table->gfxclk_pstate.stand=
ard;
@@ -1780,13 +1789,15 @@ int smu_v13_0_set_performance_level(struct smu_cont=
ext *smu,
                vclk_min =3D vclk_max =3D 0;
                dclk_min =3D dclk_max =3D 0;
                fclk_min =3D fclk_max =3D 0;
+               auto_level =3D false;
        }

        if (sclk_min && sclk_max) {
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            SMU_GFXCLK,
                                                            sclk_min,
-                                                           sclk_max);
+                                                           sclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1798,7 +1809,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            SMU_MCLK,
                                                            mclk_min,
-                                                           mclk_max);
+                                                           mclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1810,7 +1822,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            SMU_SOCCLK,
                                                            socclk_min,
-                                                           socclk_max);
+                                                           socclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1825,7 +1838,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                        ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                                    i ? SMU=
_VCLK1 : SMU_VCLK,
                                                                    vclk_mi=
n,
-                                                                   vclk_ma=
x);
+                                                                   vclk_ma=
x,
+
+ auto_level);
                        if (ret)
                                return ret;
                }
@@ -1840,7 +1854,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                        ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                                    i ? SMU=
_DCLK1 : SMU_DCLK,
                                                                    dclk_mi=
n,
-                                                                   dclk_ma=
x);
+                                                                   dclk_ma=
x,
+
+ auto_level);
                        if (ret)
                                return ret;
                }
@@ -1852,7 +1867,8 @@ int smu_v13_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            SMU_FCLK,
                                                            fclk_min,
-                                                           fclk_max);
+                                                           fclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 4e658abe3a20..3e2277abc754 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1962,7 +1962,8 @@ static int smu_v13_0_0_force_clk_levels(struct smu_co=
ntext *smu,
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            clk_type,
                                                            min_freq,
-                                                           max_freq);
+                                                           max_freq,
+                                                           false);
                break;
        case SMU_DCEFCLK:
        case SMU_PCIE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 9c2c43bfed0b..a71b7c0803f1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -811,9 +811,10 @@ static int smu_v13_0_5_get_dpm_ultimate_freq(struct sm=
u_context *smu,  }

 static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu=
,
-                                                       enum smu_clk_type c=
lk_type,
-                                                       uint32_t min,
-                                                       uint32_t max)
+                                                  enum smu_clk_type clk_ty=
pe,
+                                                  uint32_t min,
+                                                  uint32_t max,
+                                                  bool automatic)
 {
        enum smu_message_type msg_set_min, msg_set_max;
        uint32_t min_clk =3D min;
@@ -950,7 +951,7 @@ static int smu_v13_0_5_force_clk_levels(struct smu_cont=
ext *smu,
                if (ret)
                        goto force_level_out;

-               ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu, clk_ty=
pe, min_freq, max_freq);
+               ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu,
+ clk_type, min_freq, max_freq, false);
                if (ret)
                        goto force_level_out;
                break;
@@ -1046,9 +1047,10 @@ static int smu_v13_0_5_set_performance_level(struct =
smu_context *smu,

        if (sclk_min && sclk_max) {
                ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu,
-                                                           SMU_SCLK,
-                                                           sclk_min,
-                                                           sclk_max);
+                                                             SMU_SCLK,
+                                                             sclk_min,
+                                                             sclk_max,
+                                                             false);
                if (ret)
                        return ret;

@@ -1060,7 +1062,8 @@ static int smu_v13_0_5_set_performance_level(struct s=
mu_context *smu,
                ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu,
                                                              SMU_VCLK,
                                                              vclk_min,
-                                                             vclk_max);
+                                                             vclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }
@@ -1069,7 +1072,8 @@ static int smu_v13_0_5_set_performance_level(struct s=
mu_context *smu,
                ret =3D smu_v13_0_5_set_soft_freq_limited_range(smu,
                                                              SMU_DCLK,
                                                              dclk_min,
-                                                             dclk_max);
+                                                             dclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 52f3c537bb3f..ea9bfd026b4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1746,7 +1746,7 @@ static int smu_v13_0_6_set_performance_level(struct s=
mu_context *smu,
                if (uclk_table->max !=3D pstate_table->uclk_pstate.curr.max=
) {
                        /* Min UCLK is not expected to be changed */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
-                               smu, SMU_UCLK, 0, uclk_table->max);
+                               smu, SMU_UCLK, 0, uclk_table->max,
+ false);
                        if (ret)
                                return ret;
                        pstate_table->uclk_pstate.curr.max =3D uclk_table->=
max; @@ -1765,7 +1765,8 @@ static int smu_v13_0_6_set_performance_level(str=
uct smu_context *smu,

 static int smu_v13_0_6_set_soft_freq_limited_range(struct smu_context *smu=
,
                                                   enum smu_clk_type clk_ty=
pe,
-                                                  uint32_t min, uint32_t m=
ax)
+                                                  uint32_t min, uint32_t m=
ax,
+                                                  bool automatic)
 {
        struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
        struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_context; =
@@ -1813,7 +1814,7 @@ static int smu_v13_0_6_set_soft_freq_limited_range(st=
ruct smu_context *smu,
                                return -EOPNOTSUPP;
                        /* Only max clock limiting is allowed for UCLK */
                        ret =3D smu_v13_0_set_soft_freq_limited_range(
-                               smu, SMU_UCLK, 0, max);
+                               smu, SMU_UCLK, 0, max, false);
                        if (!ret)
                                pstate_table->uclk_pstate.curr.max =3D max;
                }
@@ -1953,7 +1954,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_=
context *smu,
                        max_clk =3D dpm_context->dpm_tables.gfx_table.max;

                        ret =3D smu_v13_0_6_set_soft_freq_limited_range(
-                               smu, SMU_GFXCLK, min_clk, max_clk);
+                               smu, SMU_GFXCLK, min_clk, max_clk,
+ false);

                        if (ret)
                                return ret; @@ -1961,7 +1962,7 @@ static in=
t smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
                        min_clk =3D dpm_context->dpm_tables.uclk_table.min;
                        max_clk =3D dpm_context->dpm_tables.uclk_table.max;
                        ret =3D smu_v13_0_6_set_soft_freq_limited_range(
-                               smu, SMU_UCLK, min_clk, max_clk);
+                               smu, SMU_UCLK, min_clk, max_clk, false);
                        if (ret)
                                return ret;
                        pstate_table->uclk_pstate.custom.max =3D 0; @@ -198=
5,7 +1986,7 @@ static int smu_v13_0_6_usr_edit_dpm_table(struct smu_context=
 *smu,
                        max_clk =3D pstate_table->gfxclk_pstate.custom.max;

                        ret =3D smu_v13_0_6_set_soft_freq_limited_range(
-                               smu, SMU_GFXCLK, min_clk, max_clk);
+                               smu, SMU_GFXCLK, min_clk, max_clk,
+ false);

                        if (ret)
                                return ret; @@ -1996,7 +1997,7 @@ static in=
t smu_v13_0_6_usr_edit_dpm_table(struct smu_context *smu,
                        min_clk =3D pstate_table->uclk_pstate.curr.min;
                        max_clk =3D pstate_table->uclk_pstate.custom.max;
                        return smu_v13_0_6_set_soft_freq_limited_range(
-                               smu, SMU_UCLK, min_clk, max_clk);
+                               smu, SMU_UCLK, min_clk, max_clk, false);
                }
                break;
        default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f7d7cae16d9b..23f13388455f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1951,7 +1951,8 @@ static int smu_v13_0_7_force_clk_levels(struct smu_co=
ntext *smu,
                ret =3D smu_v13_0_set_soft_freq_limited_range(smu,
                                                            clk_type,
                                                            min_freq,
-                                                           max_freq);
+                                                           max_freq,
+                                                           false);
                break;
        case SMU_DCEFCLK:
        case SMU_PCIE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 260c339f89c5..71d58c8c8cc0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -945,9 +945,10 @@ static int yellow_carp_get_dpm_ultimate_freq(struct sm=
u_context *smu,  }

 static int yellow_carp_set_soft_freq_limited_range(struct smu_context *smu=
,
-                                                       enum smu_clk_type c=
lk_type,
-                                                       uint32_t min,
-                                                       uint32_t max)
+                                                  enum smu_clk_type clk_ty=
pe,
+                                                  uint32_t min,
+                                                  uint32_t max,
+                                                  bool automatic)
 {
        enum smu_message_type msg_set_min, msg_set_max;
        uint32_t min_clk =3D min;
@@ -1134,7 +1135,7 @@ static int yellow_carp_force_clk_levels(struct smu_co=
ntext *smu,
                if (ret)
                        goto force_level_out;

-               ret =3D yellow_carp_set_soft_freq_limited_range(smu, clk_ty=
pe, min_freq, max_freq);
+               ret =3D yellow_carp_set_soft_freq_limited_range(smu,
+ clk_type, min_freq, max_freq, false);
                if (ret)
                        goto force_level_out;
                break;
@@ -1254,9 +1255,10 @@ static int yellow_carp_set_performance_level(struct =
smu_context *smu,

        if (sclk_min && sclk_max) {
                ret =3D yellow_carp_set_soft_freq_limited_range(smu,
-                                                           SMU_SCLK,
-                                                           sclk_min,
-                                                           sclk_max);
+                                                             SMU_SCLK,
+                                                             sclk_min,
+                                                             sclk_max,
+                                                             false);
                if (ret)
                        return ret;

@@ -1266,18 +1268,20 @@ static int yellow_carp_set_performance_level(struct=
 smu_context *smu,

        if (fclk_min && fclk_max) {
                ret =3D yellow_carp_set_soft_freq_limited_range(smu,
-                                                           SMU_FCLK,
-                                                           fclk_min,
-                                                           fclk_max);
+                                                             SMU_FCLK,
+                                                             fclk_min,
+                                                             fclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }

        if (socclk_min && socclk_max) {
                ret =3D yellow_carp_set_soft_freq_limited_range(smu,
-                                                           SMU_SOCCLK,
-                                                           socclk_min,
-                                                           socclk_max);
+                                                             SMU_SOCCLK,
+                                                             socclk_min,
+                                                             socclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }
@@ -1286,7 +1290,8 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,
                ret =3D yellow_carp_set_soft_freq_limited_range(smu,
                                                              SMU_VCLK,
                                                              vclk_min,
-                                                             vclk_max);
+                                                             vclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }
@@ -1295,7 +1300,8 @@ static int yellow_carp_set_performance_level(struct s=
mu_context *smu,
                ret =3D yellow_carp_set_soft_freq_limited_range(smu,
                                                              SMU_DCLK,
                                                              dclk_min,
-                                                             dclk_max);
+                                                             dclk_max,
+                                                             false);
                if (ret)
                        return ret;
        }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 865e916fc425..f7745eaf118e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1102,7 +1102,8 @@ int smu_v14_0_get_dpm_ultimate_freq(struct smu_contex=
t *smu, enum smu_clk_type c  int smu_v14_0_set_soft_freq_limited_range(stru=
ct smu_context *smu,
                                          enum smu_clk_type clk_type,
                                          uint32_t min,
-                                         uint32_t max)
+                                         uint32_t max,
+                                         bool automatic)
 {
        int ret =3D 0, clk_id =3D 0;
        uint32_t param;
@@ -1117,7 +1118,10 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu=
_context *smu,
                return clk_id;

        if (max > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (max & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0xffff);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (max &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMaxByFreq,
                                                      param, NULL);
                if (ret)
@@ -1125,7 +1129,10 @@ int smu_v14_0_set_soft_freq_limited_range(struct smu=
_context *smu,
        }

        if (min > 0) {
-               param =3D (uint32_t)((clk_id << 16) | (min & 0xffff));
+               if (automatic)
+                       param =3D (uint32_t)((clk_id << 16) | 0);
+               else
+                       param =3D (uint32_t)((clk_id << 16) | (min &
+ 0xffff));
                ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSof=
tMinByFreq,
                                                      param, NULL);
                if (ret)
@@ -1202,6 +1209,7 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
        uint32_t dclk_min =3D 0, dclk_max =3D 0;
        uint32_t fclk_min =3D 0, fclk_max =3D 0;
        int ret =3D 0, i;
+       bool auto_level =3D false;

        switch (level) {
        case AMD_DPM_FORCED_LEVEL_HIGH:
@@ -1233,6 +1241,7 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                dclk_max =3D dclk_table->max;
                fclk_min =3D fclk_table->min;
                fclk_max =3D fclk_table->max;
+               auto_level =3D true;
                break;
        case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
                sclk_min =3D sclk_max =3D pstate_table->gfxclk_pstate.stand=
ard;
@@ -1268,7 +1277,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                            SMU_GFXCLK,
                                                            sclk_min,
-                                                           sclk_max);
+                                                           sclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1280,7 +1290,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                            SMU_MCLK,
                                                            mclk_min,
-                                                           mclk_max);
+                                                           mclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1292,7 +1303,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                            SMU_SOCCLK,
                                                            socclk_min,
-                                                           socclk_max);
+                                                           socclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

@@ -1307,7 +1319,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                        ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                                    i ? SMU=
_VCLK1 : SMU_VCLK,
                                                                    vclk_mi=
n,
-                                                                   vclk_ma=
x);
+                                                                   vclk_ma=
x,
+
+ auto_level);
                        if (ret)
                                return ret;
                }
@@ -1322,7 +1335,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                        ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                                    i ? SMU=
_DCLK1 : SMU_DCLK,
                                                                    dclk_mi=
n,
-                                                                   dclk_ma=
x);
+                                                                   dclk_ma=
x,
+
+ auto_level);
                        if (ret)
                                return ret;
                }
@@ -1334,7 +1348,8 @@ int smu_v14_0_set_performance_level(struct smu_contex=
t *smu,
                ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                            SMU_FCLK,
                                                            fclk_min,
-                                                           fclk_max);
+                                                           fclk_max,
+                                                           auto_level);
                if (ret)
                        return ret;

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index ade3ee398e3d..27f4e0ce447d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1503,7 +1503,8 @@ static int smu_v14_0_2_force_clk_levels(struct smu_co=
ntext *smu,
                ret =3D smu_v14_0_set_soft_freq_limited_range(smu,
                                                            clk_type,
                                                            min_freq,
-                                                           max_freq);
+                                                           max_freq,
+                                                           false);
                break;
        case SMU_DCEFCLK:
        case SMU_PCIE:
--
2.46.2

