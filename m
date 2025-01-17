Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56209C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 01:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BCB10E16A;
	Fri, 17 Jan 2025 01:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLC6Yfps";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0888D10E16A
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 01:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2hisO30uFEEFEHqHza6+hjewnRkBTTVsMBA5OgFC4EqV0Kvs2dy+Q492boUMlDEeEah09jaw8Q4Vonp56gG/LbwpiEqtohojbzjbIUcpjefK1bmstQ79gLViuGdx4LPQtcWBu5wCeHRhmGt3IOSxFHlvGXR3w9wPaUm6M+P/88Rfz+AktI+eKRyIyOERtC2E6OnNVu4Y6GwQgYdCnB74ChoKvMmaoHF26pMHiASXP5az2xvkhvHsByoedF2geHkfrCLCyR7AwcqFx8VzRNCNQ2SdXYEgX+DpMPdo2c1P8ApwnsEBIX4Msxp1BAPs75eVxOWtXXwI4QZ0NKpgVlHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY/4YLq1lymdpD8NkKQM0VLp2KENfIsRpwe5gwRXylc=;
 b=I4Y/zVVRfsKTSYw15loQyDC/fhZP7cRRlq8i7+E2zNSZKYtY5zIJgTDOjfLn2LOstx1uNVKInVsLyUxUHlVzQOIacjd69pMRAaM9IKDBUuD9Pxcpt2xD8fCDZRPW7n1V6YN9wQhHfQyGrwWJlmCy8v7zi8I783vdykdIi4NCV9mDdSVMiexRc0RPiMXnRZ0XLG2LDuqQMeAfW14ipIJUj8eWjTMuCCWgLrDMpdT8dJxAN1zcLLe08E2PvFABtVCyfknudY7rsp/AkArRLal8QUlqt9eRpWkuvzCAE0leGgf0PRLuGLOv3p7xtWQNQIOYsMllEczEYqHNOLayPaTJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY/4YLq1lymdpD8NkKQM0VLp2KENfIsRpwe5gwRXylc=;
 b=WLC6YfpsqXybyFgkJ1aVgPlavq4MKx9u31HvV0MQM4lZAC5pBBEucj0xUr2rRekkKkl1RvnPrvcMfK/eaI6tlCJnJ78fhJbnlchgjLrXjb5WGTauMsQzpp6j88Pt90tbsxXQr5kFoMm4H2qJtyDT081RvyY7d/efQ4Fy5UVUf6s=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Fri, 17 Jan 2025 01:19:51 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%2]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 01:19:51 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Jiang Liu <gerry@linux.alibaba.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>,
 "shuox.liu@linux.alibaba.com" <shuox.liu@linux.alibaba.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
Thread-Topic: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
Thread-Index: AQHbZVxuWPjv6RWFs0SkPlA/QGdzt7MaMNkg
Date: Fri, 17 Jan 2025 01:19:51 +0000
Message-ID: <DM4PR12MB6012035EBD22172BD10AF6E3821B2@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
In-Reply-To: <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3a8adba8-eee7-438c-9bcf-0b3aa521683f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-17T01:18:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|DS7PR12MB6007:EE_
x-ms-office365-filtering-correlation-id: 639849c5-4536-45b0-4547-08dd36950ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?8Q0boqNmstk1D+mWB0GtlyspatGPYdAYUIDPtdy8TymjR6se6OJtpFJiEC02?=
 =?us-ascii?Q?h7yyu62ob79YN7p6C3aO1VhDgfD45epclf0H0zLl8Van6PuqYiq9TkieHf2m?=
 =?us-ascii?Q?nAJC9CMCrgVQsN1F7ESRZK/owAg0ue5ALOXmVF4YOtyz9nZ9Mx1tx160efeo?=
 =?us-ascii?Q?LucPpZEHvp8gs5haVrq2IjVTR2TNTkm+XIgW1adfzrM8ir9anepQgeoRJJaN?=
 =?us-ascii?Q?Al0Le7ggI19LfjB1vOAvCAQqntFuq8a5U+BmmE68skGGp1wkiPy1hnddGvkM?=
 =?us-ascii?Q?PUDFFpY1KU/ZOK/Mlfe0vu447g7LcB674bIgkJzFhoCrfaElyAUloUoqbLI0?=
 =?us-ascii?Q?RZFoFRmR/rcAMkAB117+35BpWQEXwZxo/GXwZmEiQI12NQMINCpZ8l0so+gB?=
 =?us-ascii?Q?ypGUH4Mnr99NDckBTFf6Zjn0zxR82qS1HVLR02yznTBus5dkC6gcDUjpt2u8?=
 =?us-ascii?Q?xynQFrKfYU6RsnAM4b5FaNuSAQK7kF9rVEO2ZQc1vagsnCG+yAuj7DD99U2d?=
 =?us-ascii?Q?p79re6BSQmNr/HTeNyMS0kM+UdjSMsNhNLaQc/6oRpCHQuIA9MU1Ig/P5TsA?=
 =?us-ascii?Q?TVp1CIkXA1YrAH+Vtxl1dyf84M2JYUVB2mY5/hseZUSp0c5yUJuAgF/rEWw+?=
 =?us-ascii?Q?zdg7PgySy9tSnEGxWXAaG9rmQSHicvfXt85Nv1tPwc1UOqao/e8phwk2NBiC?=
 =?us-ascii?Q?FA4tv840fpvqKN57aGPgiD/BUciu8aV7qSkhbHKwAOEcSQu/3LCxmsi6l4KU?=
 =?us-ascii?Q?hr7Mh41jBpcrnkqLWX1tjc9ThxD1zcyV6Mu41JxZunrRhbRgiiSxjRh2/+yr?=
 =?us-ascii?Q?70spxsdWB0/GOtHRuiEqyFdCFgiAvdGsavkEN7H+2eevAZo6IZMeU0yCxxa/?=
 =?us-ascii?Q?QyccveFUF+ThPZvqwd5Q5erSqCsdE2Tl4YH1bY6qCOV5msZoaX7lwhmk8qVa?=
 =?us-ascii?Q?nzSf/Y6jo3SXneLwRybneIFAtQrIt6NZYDlSWUWNj6I6vShBkCLbMjTkwmfo?=
 =?us-ascii?Q?Vr46Mn5u0RFVlkuQzSGI3g8YJceq9la6XIbXirgLwrU+wWifOEVEClGPop3T?=
 =?us-ascii?Q?VS+zN0x8k0FqeQSwHNiY0qyQaOUEIOgeArhf2yUyCYaGPmBQtmvkshZhKMs0?=
 =?us-ascii?Q?SPUB4KfXVKsZ9xY29bFjnjYbdTQ4zzr6iehPVJJTiJuu8PmSH2XWzvFKdVrH?=
 =?us-ascii?Q?67XHPTBbfX3mF2L6Ln+oTUoO8fbxu5M4HZHTXSnZ/ppiHre70eyNP3fBskrU?=
 =?us-ascii?Q?PfpAdhCZoGzBQVrwKZZ+zw9+u8KiBM1dKaVv8q2CqjnhoX+X0+j6pkHEX7Tn?=
 =?us-ascii?Q?FXqVN5MJ4NbSwmAdWTuxpBuLyV+F7Y4VEzih6Sl34H8jtnUCiDBoUU5Mh4Rz?=
 =?us-ascii?Q?qFr2uhn024TAeW9HHIM4ism+kKGx2HoprUUH/ZVmHDZRxSikVEfwlMkvZSeD?=
 =?us-ascii?Q?3XQqy6lDC3yi4bOGTe3Eevfljcf+tkiA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?plzXE43UQRsiwMMiCaJVzpTpOjur9ObzVFZO4O3IuB71QzxlizCdG/cQGf32?=
 =?us-ascii?Q?24lU+2r1tSD8bgRJWTpJpYRZRDgZZdDmlwscQb3fqi3xdqZ/oCmRmzl4vl+h?=
 =?us-ascii?Q?5llidFc4tEZt4VAI2L5tAxVsE/9SDkR8NgoBuDhlqZv7WkZu3DKbTPoP4GxE?=
 =?us-ascii?Q?B80qPa1fYz/Qeql3+PlIjKPuJ2bUm8Kt4IHlCewUBTBuG3/GgLnAXJVogLyv?=
 =?us-ascii?Q?wCHdhE4/rdNKis7L6/8FRzjmi27Nz8+zABuNHKulS+vDy7uQDcr5XRv85oJj?=
 =?us-ascii?Q?go4krreKUiuo9uN91wkgizgtOskCKcUvqPc1FD5VQaAo2ewib1Ck90I6YUw1?=
 =?us-ascii?Q?fqVllTWt/juTIb8fEqSxqr8gbLzva8gpVe2HiphoEnANvKTtCP7pQmYkwfgm?=
 =?us-ascii?Q?ICUMQLTjUrDN7Zc3ufJEGB+3rYo+tarjY1PnUvkhBAOHiLt5/5LyTVn/t46q?=
 =?us-ascii?Q?YN/H3zcJF0zbTSNHyE1h8NHx3pTEe6p4Nt3/wVnWenR2OCwYxfv+L7TJpH7x?=
 =?us-ascii?Q?TZY2vneudUxaurv08Zwmjr+FiU1IxZlFP3WEifGwjz0ya515m/46adlsg3GJ?=
 =?us-ascii?Q?Wv2C8ucDr66I+t4CORPBN3IotwjtfCQRrOgbGrFiSjcD9/Qvqle5+c6/a3MR?=
 =?us-ascii?Q?35Z9KCK9Xt+qtgaxhFnX+nHKJQDUfG3xpXZCvtk11XkIfBhHqNpouvduv3hd?=
 =?us-ascii?Q?+d+DFnj/M6ru96YMfahb3nGXeDuS6Hd6HF2+CXCv+NEaVJsiLGng3Z1NvrLL?=
 =?us-ascii?Q?2bPSnUK/1zwpZLOyNjoAqer4w26s6d5e2GXA0rqpOwrRgVUBSfQ77ZxS7kNQ?=
 =?us-ascii?Q?ZNcxzOR7QUHpjJUHNR11DwquAC2/x4YEhgt/bsL8Xkw2WFTI/xCAjH/rV+Xy?=
 =?us-ascii?Q?4j3b7kf3U5R0SImvKHA2i+62+WLr8pJmchzABMUY3ziFs3FkTqQPROr87x0B?=
 =?us-ascii?Q?fF56C6W70GzWMoiFzTBm+h2AeoF45OKu+FblWvxKLGBajkRX8QnX5nj+MxzR?=
 =?us-ascii?Q?QYR2eDWSp2Crb1ld1zq/WI+C04TVjl0fhgBsO6Nuqvxmu5X2nTtkWy6V/l7u?=
 =?us-ascii?Q?S1EegPhh713TbhRXHh0Ty53nelIdWwULUl3yl5LMG1szhSMyjsj4mZ/cZROW?=
 =?us-ascii?Q?8grtAROSITfvE9mRwALVb9NXNtYaw5Q5375HeG0A9o2dcsXhu1ZomtUvoYCj?=
 =?us-ascii?Q?cvA9fI599piPxhptrDht+Nso+96oJiaXfw/UL7jbSLSsv61pIOW3vs+glYja?=
 =?us-ascii?Q?LztvTdysjCuh39SFDI3FujpiCkvsriu+J582AkZXPqu3yohzKCOr2S+HacLY?=
 =?us-ascii?Q?66i1es6zCG9Q6xcGt/Rg88HtFrJlm0mXGXvQ3p3vrK5TRiMrJUvMiK664yI/?=
 =?us-ascii?Q?G0gGuqd3UNA+T12RNRVPDvMksN/2yhLG2iRqjxvcHI6uhawdzr9AdkPxaagJ?=
 =?us-ascii?Q?w50VnO+F4yhbS4KEYxvyXDx3nXj4OQ4/ycLZZJ1XCqhqxITWRlYKJaxuU6IJ?=
 =?us-ascii?Q?BmObcBTVsfNua9Ba2glprdqzGHhHRMNb90DDr9F8YNT9seM3KN2rtO9/gzXe?=
 =?us-ascii?Q?kUtzSZrnPuHWFnmTl1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639849c5-4536-45b0-4547-08dd36950ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 01:19:51.5834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSUoDgTTXGNchm4Gu8J5qTr3GoOcpMH8wYesLApKHClnwJS9piVgDKn+OnM6pqXT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiang Li=
u
Sent: Monday, January 13, 2025 09:42
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; airlied@gmail.com;=
 simona@ffwll.ch; Khatri, Sunil <Sunil.Khatri@amd.com>; Lazar, Lijo <Lijo.L=
azar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Limonciello, Mario <=
Mario.Limonciello@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Russell=
, Kent <Kent.Russell@amd.com>; shuox.liu@linux.alibaba.com; amd-gfx@lists.f=
reedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_=
ras_early_fini()

Rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini(), to keep same style=
 with other code.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  2 +-
 14 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2bfe113e17c7..6cbd19ad0fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4613,7 +4613,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        return 0;

 release_ras_con:
-       amdgpu_ras_pre_fini(adev);
+       amdgpu_ras_early_fini(adev);
        amdgpu_ras_fini(adev);
        if (amdgpu_sriov_vf(adev))
                amdgpu_virt_release_full_gpu(adev, true); @@ -4705,7 +4705,=
7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
        amdgpu_xcp_cfg_sysfs_fini(adev);

        /* disable ras feature must before hw fini */
-       amdgpu_ras_pre_fini(adev);
+       amdgpu_ras_early_fini(adev);

        amdgpu_ttm_set_buffer_funcs_status(adev, false);

@@ -4922,7 +4922,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l notify_clients)
        cancel_delayed_work_sync(&adev->delayed_init_work);

        /* disable ras feature must before hw fini */
-       amdgpu_ras_pre_fini(adev);
+       amdgpu_ras_early_fini(adev);
        amdgpu_ras_suspend(adev);

        amdgpu_device_ip_suspend_phase1(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e..2e7c09530ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -918,7 +918,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev=
, struct ras_common_if *r

        return 0;
 late_fini:
[kevin]:
It's better to rename above label name together.

Best Regards,
Kevin
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..80248930082c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -300,7 +300,7 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *ade=
v, struct ras_common_if *
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.c
index d085687a47ea..c75ce91f94ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -71,6 +71,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev,=
 struct ras_common_if *

        return 0;
 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5ac63f9cffda..b11e3eb2b100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4124,7 +4124,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *=
adev,
        return 0;

 cleanup:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

@@ -4135,7 +4135,7 @@ static int amdgpu_ras_block_late_init_default(struct =
amdgpu_device *adev,  }

 /* helper function to remove ras fs node and interrupt handler */ -void am=
dgpu_ras_block_late_fini(struct amdgpu_device *adev,
+void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
                          struct ras_common_if *ras_block)
 {
        struct amdgpu_ras_block_object *ras_obj; @@ -4156,10 +4156,10 @@ vo=
id amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
                amdgpu_ras_interrupt_remove_handler(adev, ras_block);  }

-static void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
+static void amdgpu_ras_block_early_fini_default(struct amdgpu_device
+*adev,
                          struct ras_common_if *ras_block)
 {
-       return amdgpu_ras_block_late_fini(adev, ras_block);
+       return amdgpu_ras_block_early_fini(adev, ras_block);
 }

 /* do some init work after IP late init as dependence.
@@ -4267,7 +4267,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev) =
 }

 /* do some fini work before IP fini as dependence */ -int amdgpu_ras_pre_f=
ini(struct amdgpu_device *adev)
+int amdgpu_ras_early_fini(struct amdgpu_device *adev)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct amdgpu_ras_block_list *node, *tmp; @@ -4284,10 +4284,10 @@ i=
nt amdgpu_ras_pre_fini(struct amdgpu_device *adev)
                if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
                        continue;

-               if (obj->ras_fini)
-                       obj->ras_fini(adev, &obj->ras_comm);
+               if (obj->ras_early_fini)
+                       obj->ras_early_fini(adev, &obj->ras_comm);
                else
-                       amdgpu_ras_block_late_fini_default(adev, &obj->ras_=
comm);
+                       amdgpu_ras_block_early_fini_default(adev, &obj->ras=
_comm);
        }

 disable:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 35881087b17b..3a6f70b75e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -711,7 +711,7 @@ struct amdgpu_ras_block_object {
        int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
                                enum amdgpu_ras_block block, uint32_t sub_b=
lock_index);
        int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_=
if *ras_block);
-       void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *=
ras_block);
+       void (*ras_early_fini)(struct amdgpu_device *adev, struct
+ras_common_if *ras_block);
        ras_ih_cb ras_cb;
        const struct amdgpu_ras_block_hw_ops *hw_ops;  }; @@ -825,13 +825,1=
3 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);  int amdgpu_ras_late_init=
(struct amdgpu_device *adev);
+int amdgpu_ras_early_fini(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev); -int amdgpu_ras_pre_fini(=
struct amdgpu_device *adev);

 int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
                        struct ras_common_if *ras_block);

-void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
                          struct ras_common_if *ras_block);

 int amdgpu_ras_feature_enable(struct amdgpu_device *adev, diff --git a/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_s=
dma.c
index 174badca27e7..1a1834e47b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -116,7 +116,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *ade=
v,
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index eafe20d8fe0b..dd787f5f2f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -336,7 +336,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev=
, struct ras_common_if *r
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 83faf6e6788a..3ab80399d2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1248,7 +1248,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *ad=
ev, struct ras_common_if *r
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);
        return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..825c331f48f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1174,7 +1174,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_de=
vice *adev, struct ras_comm
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);

        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 2ba185875baa..ce70acfbf22c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -5080,7 +5080,7 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_dev=
ice *adev, struct ras_commo
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);

        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 88f9771c1686..28bc2f946e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1311,7 +1311,7 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_de=
vice *adev, struct ras_comm
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);

        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index e646e5cef0a2..467283165a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -789,7 +789,7 @@ static int mmhub_v1_8_ras_late_init(struct amdgpu_devic=
e *adev, struct ras_commo
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);

        return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_3.c
index ecdc027f8220..063b3bafd134 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1996,7 +1996,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_dev=
ice *adev, struct ras_commo
        return 0;

 late_fini:
-       amdgpu_ras_block_late_fini(adev, ras_block);
+       amdgpu_ras_block_early_fini(adev, ras_block);

        return r;
 }
--
2.43.5

