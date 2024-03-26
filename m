Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4E4C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 03:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E93610E63E;
	Tue, 26 Mar 2024 03:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cqanawj+";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2093.outbound.protection.outlook.com [40.107.237.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F81210E5A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 03:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XllwSlx0OPW5Tq9qU0bLmTXKVm0Krdvu0pUtup4TSjJ+JrhcOfQBYU+DI9XWTVSQOrkOBxSD2ZyQgT8AfFJGpCnM88/2CCAgcx0u/2bLeOC759vaLeOqwT7cJX1RACQUmwLwNmxie3y6gyIvEpKrG90g1W/A0a6n8wgAQkaiiaKto9f7iyUT8fo8thqLeKd5EJCEKcFig2u9TlqeoTmNZgGGPJQF6/dSW2wTNj4bWijwNcvLv4PMsqVB9NzIaNEkBR+J7d1i6vu4T8hYqUp36DqwznR7n7iFEo50WyOfiXWCaYvQ89dCsybtI2EvXtagtbn2hj6vaHkD3Po0XGJYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckMxBcaCi8Eqoj10KtOyhq2g7nrI02oUHhj/NaJKVmQ=;
 b=WYhKzU1FXmhznOFH9pswOSRsFtLr3WXOdRkgJc4MhKskeDBVfarFg4h1CpyWpjyQhhg7eqr0qmGUqeM9o5QZiykUorLNMG/LubbZZ3b9pnOCAFm7AxyKly96D5IxEHzXo3XaRrlLmWVD355fTzZGamNRl2ORcK55GN5Xtnhnk0c/am1zBZbvjy0YaVts/yrbo7u7XkjeIIm4jI6HNmauydTemK9g+HSdvGYgyFBHUiTZztc5RYrEr62yETKrBTAVhuyJp2qFmGNt93lHDTYfRCD+PQcn9xKRk9ySDjHJTpQiyadm7SLAjTpv+omKMpCDZxqKoQ6tc52vwLwLLTp0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckMxBcaCi8Eqoj10KtOyhq2g7nrI02oUHhj/NaJKVmQ=;
 b=Cqanawj+ubBnnS5CkbYj7HZtkzbEGd+/gZSxnnke6W5jmraxPIM5gSY58xQ7zCIQ+7+Uct71gGKbmAbQnl9oiZ7rev5sBcoRyPORy3eySRp7tvdVopMvawOrdbAcPwi9nFVVEdoRMR3QG4+P80JpC+UpV3GJtbaa465Up9kQR+k=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 03:22:00 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::640a:8c9:386d:ecaf]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::640a:8c9:386d:ecaf%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 03:22:00 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/umsch: reinitialize write pointer in hw
 init
Thread-Topic: [PATCH 2/2] drm/amdgpu/umsch: reinitialize write pointer in hw
 init
Thread-Index: AQHafnaedQuXT5pwQ0+VXjuwImV4CbFJXG5A
Date: Tue, 26 Mar 2024 03:22:00 +0000
Message-ID: <CH2PR12MB4152883E7D07ED7C9263C985FE352@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240325053723.3183224-1-Lang.Yu@amd.com>
In-Reply-To: <20240325053723.3183224-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9dc579a3-151b-454d-ae6f-cc0649a16f35;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T03:21:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DS0PR12MB7509:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +cUh7oIGHxZ7RayX2kFwtnE7J/mO9iMQLntOpFXH5f4v2NgzUCj27pzTGWyIhbWN+kdl0sYYIMFFd9Pubrg0cRF+K2jtd4ZA2kBrMozu2XRYa0O0U60+sVTaIxHEkZxfwyf2ru8xUrol9pt/AYNQlxzheasvXqgRSWGHlVDPfhmCvWKRm45yIofdIKoITCW0uSL5kWYnHzXXllyy+XVUSRFihs67F9NYUpow19WNVGJMhVEJqm0dO/8nNsmdjFIAeK9IC2MSsTlM+UJGMon1mcDW3MdIr725M4863LEOfyimFlChjGmiNXkQQprK1SknivWfF00jDbhPjxSh7aQ7dzkqMxQN+dG50VKwvfx1eOEGBlcrXU3P+UjFx9LxChFsBiO5YGIfmWih4GhmXW3KRXnd7I3FxO8BBgZcbqMkJQUEG1UWUQ0EPsezCHyVS/2Rgu/okfvB0xNxjaZ2YI2dCQP7cEJyzhJuYMfRyfWmJGOxPPa5UthPaSXkY3oTxoLkQ0nxyf25oCOmTbq5/KQn1ChujVL+sNeDF2Rp57Sy5QScE2s97deRuUDZobRO3l8KkmnynfgAn7vSDhRcAunCRO2WCNGG2ZS8+zNjCJmjbGfV9GJucYf7XzmaCjHCX/7EJs9kkLy1r/SYAkGhY7WvlN3JAFGL9razpXZt/EdMQiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BSAcREgxSuFKau+zZBktrfoOumiQByaAJk/nBTNFTod1QRi7lu9qU+fgewHc?=
 =?us-ascii?Q?SVjBiVXUpNd6GkCzESGjJdbVGLrN/8DEmNOq2HptuUOWiKJm3U30mgNuH0VA?=
 =?us-ascii?Q?4IMAVkrJH4dMrZvJK5u4y5apWPp2RJ/yaAJH6N65BbczlzRf3ATmoAv2YHhQ?=
 =?us-ascii?Q?TyTmBJxPLv7qb2iFk//QWXaraqs7/1QQ/wPlNhbYW3r7JSKtyQoASgDObc8V?=
 =?us-ascii?Q?UwmyzeMIZElrSzM6Ykwvqdup87mz7vJCbKl9oBGpIw2vVw8/po3lnaOcLWnl?=
 =?us-ascii?Q?Ta7KmnndCpIjFUz1e5oGIx7NQG2NB1wVSarom6Nrs8r40DmQOhk75ojF70d6?=
 =?us-ascii?Q?4DSM7N1zSjwk9C0V999eRJGbLFfLh0jfQVKFWcl6QAKb+La6sJvJReYkxIt4?=
 =?us-ascii?Q?bGKviwSVAjzXoyttW70YD1n246o8soqene17pQQzTxK7Pj826GtsiqVFuUZG?=
 =?us-ascii?Q?esagEnp6oyDOaPXt3f3FgGkiJdx3dctjeibI/DlNEh6BGd15KkQBAwBpiZlS?=
 =?us-ascii?Q?Eu0DqSSbsJrMlzdkgksaUJPhFy9rpg5ErGNFkf1sfTI9n3ysza8oUmv8Uf0A?=
 =?us-ascii?Q?LnM4aaI802aGvGXDLsiT+/E3wKpGqnisrd2HLKuWkRM8PBKvmlIGWmVvHjyz?=
 =?us-ascii?Q?hYIWrPkjsLQy4XIgofF0BjjJHhQM9jddIHFoHTNOGZEGEEx16eH+0UQp0cK+?=
 =?us-ascii?Q?iqwkaC7cSkJCLEXeXQyBCpoAlxrD8V/HcWUPCNFDBn5hpWj9h1HZ8hh0NlO/?=
 =?us-ascii?Q?94sMjlOwQqANo4G4TtjeXVjNfr5PneBxpFct63Tkpzqm0ca8XRsX6Bl5DpGW?=
 =?us-ascii?Q?mXd3H0cB5VP7PtIXoX/Hoixz37XRWUfUGxhJMGUfeXs3k+wPFQkwsqvjHVTU?=
 =?us-ascii?Q?uCj6K0XfyAZnie3QexBXzWPGCfT3YsH9RsFua8xFkGq5VcE+OtgCf6w9wcbD?=
 =?us-ascii?Q?meuXyyK84NwPqVNB+qpcbsaS0LBf82539Cf+jbDBwBEjxp7+sjesiPyfaLKq?=
 =?us-ascii?Q?BlCjLjrxMf37jzvjd2ZvWzCHUBsxBsqY+aODeuuhfhpkOwSaG6K+Q1h89mdx?=
 =?us-ascii?Q?lDslTcZSxx9P3xV3NBUKjaUe6+yU2yiTzp5PvNeo+xv8dyD4WHeBxkfB6Bmb?=
 =?us-ascii?Q?t2TwUhtNk3Ngns2zhGnIJtdLFawOpH5S4ZMLTksb0k9ZfV1WHkm8IOGjJNb7?=
 =?us-ascii?Q?Tq3lPkHDWRPChua5kVJsmhp498PBiVYb2JOtzoiVjPrBgPT/bwRuBquISILE?=
 =?us-ascii?Q?ZwJk0R0hodIiyLD318OMvEsyC9UysgIWWsuxb6KVnasG8si/hs+A4AOBYddO?=
 =?us-ascii?Q?TtysJ3NfAmxGSZE80IdbUqRW0JG/aOeHFdL163Z47NOgQY1iel7jD3iwq0uf?=
 =?us-ascii?Q?aLrktF5omfihIlNrd5VXk88B6lPzCKOle3d7DLZEuvsjDnzJplEunGucjYAL?=
 =?us-ascii?Q?y6YBeNE2GfSg467hbQ2BIssUT8ofT3Xxf+bG96hrolB4sDI3gkCFnR2hqmZe?=
 =?us-ascii?Q?cLdrPtl0xBJ426Uqoxk8awZJ7lkMWJCIUq8+AFGJFe76RmchuHYcrD74K6UD?=
 =?us-ascii?Q?r+fmM3U8ccfeojvFsec=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5993e039-d11a-478b-603f-08dc4d43e651
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 03:22:00.1850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxz9Vox7cBZKy/nDBe28OwXFm6CAZEi8X2LBCnDExMx0ZydNsCSeBM7wo96SGCsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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

[AMD Official Use Only - General]

Series is Reviewed-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Yu
Sent: Monday, March 25, 2024 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.G=
opalakrishnan@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/umsch: reinitialize write pointer in hw ini=
t

Otherwise the old one will be used during GPU reset.
That's not expected.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/umsch_mm_v4_0.c
index 84368cf1e175..bd57896ab85d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
@@ -225,6 +225,8 @@ static int umsch_mm_v4_0_ring_start(struct amdgpu_umsch=
_mm *umsch)

        WREG32_SOC15(VCN, 0, regVCN_UMSCH_RB_SIZE, ring->ring_size);

+       ring->wptr =3D 0;
+
        data =3D RREG32_SOC15(VCN, 0, regVCN_RB_ENABLE);
        data &=3D ~(VCN_RB_ENABLE__AUDIO_RB_EN_MASK);
        WREG32_SOC15(VCN, 0, regVCN_RB_ENABLE, data);
--
2.25.1

