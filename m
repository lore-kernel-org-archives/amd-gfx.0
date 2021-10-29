Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D57C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 23:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37E660F92
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 23:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A37E660F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE586EA98;
	Fri, 29 Oct 2021 23:11:35 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324BA6EA90
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 23:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7knHwzNw//TpwfOgn5/S6eT69Vk7GwTkGx/ESStlBCnQ873ygr1cF8m0AG+A8NJ4o39mH3mEh19bOmQB0PbyZQYhbedV9J1oV8ZKwAsTGzEEmDyJa166FlKQESUy1zg7JfMgrJ8IZa5FtLl3weJ78eJCzkV3uQnwN0iePnFhlWIcM0J14UwkwD3odTPd/FTUmWRP5MGTQjz2Wh5mpw0JXassEnz6yqphDhgsKMWxpBdv+JLvKVpvVPLLO1g7rcpOuf7HDGLZ8dHEGlmWm/GovxyFRqf1Ere4T+YUggS0C8s5msxmTkes4xlAVDcpzjIgbjid0bNbzkJSJSQK5Hesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW0NHUOxFZAzfRUpYAd1loiEyKWZP4RYFEqL/qwH2vI=;
 b=ADHIzakyWOWLFhUIPm3aCWJfmXtmYlq6/5JBGLiUerS2BKEB0O5YgonTBlMcNa5TUVUY3u39V7t0QX30GUuQW7mz3dZVmMr2JrU509RxBxILQaacN378Lq7e/c4xS4m3t20YBdxHJ+eiVVCQm9xSb79Hsj81yRp2F1qYBktMiopKm6KjK9rWojqXKNjgqflyKXZxR+FQoNyfXRUj5yoH1axN1RxX7uYbMl4sGoJcoiTBzYPjn2jSZufNF9naKJQbdYOirIGbuvcPjOvgl2PxhkoONCUqrIeStdIIblVTNUD7GJXP/PFg0IxgTsuOG6j/UrcRk4HAr8OI/r0X6wH58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW0NHUOxFZAzfRUpYAd1loiEyKWZP4RYFEqL/qwH2vI=;
 b=zFHcsPj372O1Z3l5sFxeC8Ek+yjG/A+0nsMVg+GwmVoDuJVEddp17wRqaT7gWbsWb6b/sGw685UarnN1H9V6X/uQnWwEuxYtK4OjKcU/mCbUMOL9gbSNa9Oy4ET9UPDuQUErFNv4YR8CE5CNEOz1FH6n02vPWttATxogpY9tLKM=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 23:11:31 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::dc6f:56bf:4457:147e]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::dc6f:56bf:4457:147e%11]) with mapi id 15.20.4649.015; Fri, 29 Oct
 2021 23:11:31 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Thread-Topic: [PATCH v2] drm/amd/display: Look at firmware version to
 determine using dmub on dcn21
Thread-Index: AQHXzQQotmbcaVT6f0SSAO6E95hlDKvqbq8AgAAK3aA=
Date: Fri, 29 Oct 2021 23:11:30 +0000
Message-ID: <BN6PR1201MB0084BB61B03DF72CA37E323589879@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20211029203238.4486-1-mario.limonciello@amd.com>
 <CADnq5_PYO6ikVUV4Qy=b70MRQFspd6nmQ5jJ6mFXi0pvHu+1xQ@mail.gmail.com>
In-Reply-To: <CADnq5_PYO6ikVUV4Qy=b70MRQFspd6nmQ5jJ6mFXi0pvHu+1xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cc3897f3-093e-4998-8ad8-2523318ca706;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-29T21:13:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27acbfa6-bd39-4a06-ee21-08d99b31718d
x-ms-traffictypediagnostic: BN8PR12MB3604:
x-microsoft-antispam-prvs: <BN8PR12MB3604F305D53B8AABF2230BEF89879@BN8PR12MB3604.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMnJaoWMcZN0S/7bba+0BNemY1+tBdIjFwux3OTEKV5vMdLxOf/RMi+AZTAR8QTzsYcBxa6b4q36+L+6Iu178HCh13wsZWfyTrpj4mbJ4BSGC6UKvHfvpw2H2wWenfSFxsvQwWQYSG9VzNLENjVO1MzqaHcUDjbAzdJZ9YipcAPXCjfpsc5jFau/Zq9o5+zKPFVNOSLNr1gVvozUcWlwNWGqlF6gV16LCgvdyinksiOuheU39xxayx2y6/iI3EwZ89+PhoR1uC3b0QwLK1qMTcDt3CZuzbgTWuvtJoIXT/oME9kOdKVcRcYxA7+o4/wdN+ztvbuov465tKGvW0RV/zXIkJ2rwW5cu33++Mo5rq/XkIgCpIl2SMgYsBjWQcGSpAu7zUvfbl4dHmnpNbpgZv3MMrqd+8Tkc32qoF4ZYMU6e2rU3Sg4NIbxlE8rK4ussBlg9xtK60cmqNtZg82O2gL3ymAZ9J1IA4ykwdyt/cJlbI+I8Gh3LXmsex1lddYA008BzvWGrO0I9eEN3tT7Hmrm5OIKhpdfSTbp3e0vrq3xBImWrax5MdXjTyFCPtnPW1eTjvDN+avFqwrAbzcw/TYFUur0bNXy4Ts1vSSe6v1q4NIPjeAyiZ1+sbz6J9kNvm+qpcr/41SYX7/CFwSJFmAiLQZKDLa9G68tynz+IuIIw6rnypb8mz66gFAeC2N0I+AdncJQMqVz4Kc43d2+13agQXXH/VSsHkqa0FR8gN+jZMSXWIlFYNjF/D5/S4ExXikWbyOAzYnCNWHLSgavioHeiAazWlWdfSJtRUSFJJc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(316002)(110136005)(2906002)(71200400001)(66946007)(66446008)(64756008)(966005)(76116006)(55016002)(6636002)(9686003)(508600001)(26005)(33656002)(6506007)(53546011)(86362001)(66556008)(66476007)(52536014)(7696005)(5660300002)(122000001)(8676002)(45080400002)(38100700002)(8936002)(83380400001)(4326008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yC3Fh8ad154QbRYAdQzTFv/EMHldXrCj763NIoKUffJbbuRC+xL9QPZflSWk?=
 =?us-ascii?Q?xGeYuH7ZAYm9vHA5P7ViIv5Wk0g3F5kHi7iRB/rmaWs0pvjfxe8nBvq5IR53?=
 =?us-ascii?Q?xzIv5GDpbGxm8Glwx1Fmxz4FBJI+2g+C2DzCGMjul+AVcTBppCiB96IK/081?=
 =?us-ascii?Q?AM8sO6Ug2nqCAyF36rufpxwivnp/vxGTXw4JeWrGbrIH24009M4EWLfxRz8U?=
 =?us-ascii?Q?1KMuB1zYZcCDUvCWCSjUnVSxZlH1aBeJz67jqQFH7gmn+cYZQ/fjZi4LCibx?=
 =?us-ascii?Q?RWgOiN0FEzGehO22uxiyu8tyw6IXZhQKXH3+HR9DNkLJu1JUjTNSI//QthW0?=
 =?us-ascii?Q?zqOJKABwoLg3iZMPIxd01MAQ+Dyd7AzbdGbJ0Mgbd7QMJovtiRw1pKSJQz1S?=
 =?us-ascii?Q?JMV0WBjrS7E7UYDQE8n3BPT20gxDEJGK2UuSPLfHdnpZa7RCZp6wOmXuzdqu?=
 =?us-ascii?Q?jJ9xpCOzLZgHatEo4BEPG0Jfjb5B9xfeRir2Kaf+NPy+uMdSFNQ8xvTe/vwV?=
 =?us-ascii?Q?ter/qXd977ACovDKJdzU0IfsKlLK3sWZxNOaQtfmHFHGQUU3NWDIEut5I9A6?=
 =?us-ascii?Q?sL2wOk+jwSCvXA6v9IPZ4466ekZDQP5fe65CwsuebxZ3sNYdU11yz4WGX/rZ?=
 =?us-ascii?Q?icJwaAXX1QDhxPqWBMykIWvhhwcUttMnUJjFktZRJZN0FDoW9PjDRviRhdVw?=
 =?us-ascii?Q?t9BhJX5SNrnYKZ+6baNr/6o0qUO0zaaiIkPs51GIpGpUPVP3pAxxYDneDpNt?=
 =?us-ascii?Q?CgM26hu6YN5ggoCqtssyJ2nm1ZImw6c4C9ufMKUbfUd7ElCY+rjZiv8owI9B?=
 =?us-ascii?Q?mI8QWCheCelpw/5CkRBgJpA4J9G/Tn5FkS841b11+56o3F5wW+ligJwgzAQX?=
 =?us-ascii?Q?Rmi4brmxU1ORiGB0IqYn3Jd2221AYZZ8YptjiNiNkqXZRXyz5c6zIs7tDRvv?=
 =?us-ascii?Q?ugKs7PxKjJBRHXezaOvhGG+b/XIGLc3pgJJTJfhLPj3q9kPwYyzrMOMS8p31?=
 =?us-ascii?Q?LYtWs3HPE4oSawDZIhxWKuazUF0f6oe5Rj5fhCTRsHHknyLG3YxZJs62SStX?=
 =?us-ascii?Q?J36D1SAwuGkR2RnPGUYHRv8rHbdZEsluuq3ulXdPxghU6lNgwXM+bW9urBa6?=
 =?us-ascii?Q?o3deqSy3CT1UkAHN5zYOUPuYiXrc5gpzeQgSzidF6Yj7on9nVdd86yKZ8OXn?=
 =?us-ascii?Q?183Z3XYmRsU0oTDf9ebvJwaipA3WoMfSgkWqR4EzffKaVdzn9TCc5q/hy8Zb?=
 =?us-ascii?Q?c86S0gLio4MR7HzYLi0fdxrptcJargyQftIbt28/dxNVHsdZoqe6POJ0Gtms?=
 =?us-ascii?Q?PLpSeWtNalPvqirmhOLBz6sniNaQHGylpdexVcO1T7HX9qSk+swS2/BFwaII?=
 =?us-ascii?Q?zT5a5AfnWUjsphrPIXzRn5zH4N63fI9KOZEHfGi8Uge6mQH+w+oGbE1aPyrH?=
 =?us-ascii?Q?BPxwpW+eo0uCo6m+5fCd5TEW7mcqnfokPGN0zGOmvfHz8xCfuQaCTYYpQy02?=
 =?us-ascii?Q?ZzxtT0QpBwPoz4JHh0a69Ygf9YmRnMAbzkON5rp7Oav3/Y0KeHWpnQirLeFW?=
 =?us-ascii?Q?+Fqtr2u8ARHb71zlGw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27acbfa6-bd39-4a06-ee21-08d99b31718d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 23:11:30.9096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMOagA1Xt9oWAvAI/0JTPefo3U9cMAGCi/E8xj8ER7oauEqbghb8n5Ht3W5+yC/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3604
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

[Public]

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 29, 2021 4:34 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Li, Roman
> <Roman.Li@amd.com>
> Subject: Re: [PATCH v2] drm/amd/display: Look at firmware version to
> determine using dmub on dcn21
>
> On Fri, Oct 29, 2021 at 4:33 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > dcn21
> > asics") switched over to using dmub on Renoir to fix Gitlab 1735, but
> > this implied a new dependency on newer firmware which might not be met
> > on older kernel versions.
> >
> > Since sw_init runs before hw_init, there is an opportunity to
> > determine whether or not the firmware version is new to adjust the beha=
vior.
> >
> > Cc: Roman.Li@amd.com
> > BugLink:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1772&amp;data=3D04%7C01%7C
> >
> Roman.Li%40amd.com%7C4e27c983112e4ffdd36008d99b1b860a%7C3dd8961f
> e4884e
> >
> 608e11a82d994e183d%7C0%7C0%7C637711364793611804%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C1000&amp;sdata=3DcFwunb4aAJbFkCe6lIFMY4oWfbkCVWAGshe8lB0rg0U%3D&
> amp;res
> > erved=3D0
> > BugLink:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1735&amp;data=3D04%7C01%7C
> >
> Roman.Li%40amd.com%7C4e27c983112e4ffdd36008d99b1b860a%7C3dd8961f
> e4884e
> >
> 608e11a82d994e183d%7C0%7C0%7C637711364793611804%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C1000&amp;sdata=3D%2F9sfVD5PN2tsl0bXkctPzkrHpJKQoZDex8xCDt1bVPg%3D&
> amp;r
> > eserved=3D0
> > Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > dcn21 asics")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 6dd6262f2769..e7ff8ad4c5a7 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1410,7 +1410,10 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
> >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> >                 case IP_VERSION(2, 1, 0):
> >                         init_data.flags.gpu_vm_support =3D true;
> > +                       if
> > + (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> >                                 init_data.flags.disable_dmcu =3D true;
> > +                       else
> > +                               init_data.flags.disable_dmcu =3D
> > + adev->dm.dmcub_fw_version > 0x01000000;

Since this is the only fw version that needs dmcu, it's safer to use equal =
condition here.

> >                         break;
> >                 case IP_VERSION(1, 0, 0):
> >                 case IP_VERSION(1, 0, 1):
> > --
> > 2.25.1
> >
