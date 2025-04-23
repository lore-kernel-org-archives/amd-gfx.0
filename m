Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF23DC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 07:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FA810E425;
	Wed, 23 Apr 2025 07:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTNkJSdt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1699410E0C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 07:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5jkxjUWz31P0VULCWCOPDcg/N9nem/X9D97Nnt8rKGk/K1kqL013ofhW9nXXCDjcQk/9lpbyJjVjLhyfRbJhOz/aCX5BEp0/p508kiAzUmAkaBMZu/qE92QvI1N5zaByplWZOLXJZlivU+cK3ipnqQIQu6vhjQIsDaZqqdIVEie49UrUoM5mpWxUl53xw1Z/4X0Ule42i6mgOexcZ/1gPaRd5ZDfBlDfeB0m68up4w46NXEBom27SXph4iLKfjaFRQMAI0jgE6sWAj1d6P56fQewL4rpJTJuw0Gp0o+k8KPEd6zDk3WSERtK6nvnPV1+4BCnY0nZEvgqLGaV1ayzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GTdArgfQpV+lntWBwk7yHKJY7Ge1HG/grrpbpVfUds=;
 b=TMwHTOz6R7HiCRSSZuBqTATqi91oApvG0LS+bStXDq9WZ2PBLwxsYL9Sad0WuuajG7SHIWx230ri6c8vdkEQIzwtbRPaRUlYPdCZSDqRHdtcP+JVNdQ+2w2l0I+y4LIFcyR6mA+Ub49BHqwf8Kv0ZnFxwNFGJTgMHMth4BqE0FePMMi1RFmjMV9z115m9KmTk6CNPaSR4dKexMcX7sBykDRgErc1iUvovdgHfiJ14yDuBfaOGI93V23U++647bBnb+jiyoHKAuMyYb0xQ3+j3NCG0dJXzIbJ6OxPKWG8IfSYm1aFnKttZ6AXvowyuWnHdfWRpnjCUmPWLVclMELyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GTdArgfQpV+lntWBwk7yHKJY7Ge1HG/grrpbpVfUds=;
 b=XTNkJSdtHiqL4RZAAPAEDN+bTn8hD/N7GGis8aZFAjuYnLvF5zJtBkUa2URWqdxx+Sian/aoNJJx8wihtK1uuf7kev+EHOJAblp8v3jUSXpas1x5Je88NQbBcbw+XKMOEgsJsDGp1pZHNe2iAaRkZyRYi0i3Bo9kk8eGU4GKmOY=
Received: from DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) by
 SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 23 Apr
 2025 07:25:37 +0000
Received: from DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba]) by DM4PR12MB5937.namprd12.prod.outlook.com
 ([fe80::c847:70c6:3c78:54ba%7]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:25:37 +0000
From: "Zhang, GuoQing (Sam)" <GuoQing.Zhang@amd.com>
To: =?Windows-1252?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhao, Victor" <Victor.Zhao@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhang,
 Owen(SRDC)" <Owen.Zhang2@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Topic: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
Thread-Index: AQHbrSrMwUAwzOUgZU6XmBWROciIM7OmUzmAgAqRErQ=
Date: Wed, 23 Apr 2025 07:25:24 +0000
Message-ID: <DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2@DM4PR12MB5937.namprd12.prod.outlook.com>
References: <20250414104655.336497-1-guoqing.zhang@amd.com>
 <20250414104655.336497-5-guoqing.zhang@amd.com>
 <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
In-Reply-To: <0a885441-fea1-4ac7-aef4-9761f24b2b33@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-23T07:14:12.1127681Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5937:EE_|SJ1PR12MB6122:EE_
x-ms-office365-filtering-correlation-id: 94b21809-179c-4721-1348-08dd82380b18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?I5KGOJ6vLbUKZCL9plQ+rXIFL+qJLZRiU27I/arZhqwSP7wYfMQU1XCN?=
 =?Windows-1252?Q?5D2brHDU5rornLHfbYxOfQGBkzjOnpQoc5qR5qJYqwwIpKKHRiXU13nm?=
 =?Windows-1252?Q?l8fSje7buT5cN6/mZmw6YSEzHozO3TTdQ0F601uWcuhZCWBO408c6os9?=
 =?Windows-1252?Q?VFuBVP0tdbZrNESnnIKylswbc55fsyKS+RdGQPm4bnGr5RaVvTmLkTnt?=
 =?Windows-1252?Q?W0zWAtJKnP8AX+ajx3hNGSGeUh4bNQ2PVLtz2zrglyjHbOKD6FcSOlKu?=
 =?Windows-1252?Q?Jt+Wheo83DXcoy0jDDVS0DLEt39AyInL5sfjlbD3eYq+34Dz03cwf5Wq?=
 =?Windows-1252?Q?u/ETNnXMOLpByr19PwLYqXU0z+JAC8q350KIF1z867/kLcwArmDSASra?=
 =?Windows-1252?Q?8HUgaIHliZl8CN/7O/nod9ejPmYy41C9O0EVk+wwkJHmZHoMH8tS/LIC?=
 =?Windows-1252?Q?h1h10V/67jdBHR+wbRq8bzI2F5thj0AMZwv4G9rimWQRg1lbZ5ggGN4E?=
 =?Windows-1252?Q?z5e4QDkN86eQl1XknM7RhDhQDKSJNvVFLXrsKLtsws+pR+6nfk2/B2fB?=
 =?Windows-1252?Q?K137CQn9ddGG2B/gtpVD5S45CMqH8lsBrzeuoPkhh6oQubP9IU4bDCqQ?=
 =?Windows-1252?Q?g0l5oMR5zMlJORhm3fFGyXdb3WjnOLstWfyzIfkEc+9voSNYqmz3TkJb?=
 =?Windows-1252?Q?CxQYm7NELlyk1/gHzlOULayGVVFDibsrze5b+flW/CsAO1Qc8lAmVfAa?=
 =?Windows-1252?Q?fEzzmPZA/0DxLMmx1Ww0QZGHFHabShyBphtxMN6O5JCi0u/5TCOATim1?=
 =?Windows-1252?Q?k6rCwa/o3MzjxxvcY2Gqooymb0gHk3hazSNMZ3fH+JpM513MGCfl+GPl?=
 =?Windows-1252?Q?cTo1L64fxZ4ARAywI+8LHVZaxaw2U52oUTAZeuF50m4PenDdm3XwH/BL?=
 =?Windows-1252?Q?M6szU10zLIcDM3e0vP1Mx4HjpOhxgiPxzQz5VpeqJhCruntzagbbSFjd?=
 =?Windows-1252?Q?K5PYZCPL1GzUTzqO37P3ptIsAUr3u3AwghATG5HW9LZfosFMbV2lVrHV?=
 =?Windows-1252?Q?k1O+6Zwjcxh75F1iduXZ3gzSEZGnIIW7FW0II16A+Jqdlsc7sLgUwtal?=
 =?Windows-1252?Q?k0YL/Hcz2tCtGMh7Nk7VvIExMsQLdmFXsrV+HEM8bzY8k/P1J8pfFV41?=
 =?Windows-1252?Q?NT2qxq1VX1YdJGpvMzkdqbhkw+I/GfO0RWzDMUN9GBRhTlwyWREzZKXT?=
 =?Windows-1252?Q?+Dk1yxXIrLNoZ+d+ivG5OoK3fAYSIqDGdUEiolAHPMyts5jynXsOX9/6?=
 =?Windows-1252?Q?d5wFSrxaGwjSeJACj3O6UDr4sLhDW2wjO/Uz1wIgrCU+yxZZIBya/5Ob?=
 =?Windows-1252?Q?Rf0t3622uxsv0vrqz28vijqSfR5tm9BgkfOarUiwl9LhgKZpyrVdbhNU?=
 =?Windows-1252?Q?tARuNdB7HZ1wCHeqdglHkpmk1iG1EmeGX9KjXGtGd5eGiXw45LXAlY4F?=
 =?Windows-1252?Q?e1vPRqyO5c536S/bGu+B36S51sIXO5XFHteYI+Ph80uStnE3RzTRHGet?=
 =?Windows-1252?Q?FwYQPs3m8S2ehmtPoiqFzDDUqhtu5LZhWBFLl4eZxVkDpGEMywwPgwBf?=
 =?Windows-1252?Q?yio=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5937.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?d/EJVHd/NpkUVwPBlQwYf2uVwC54oj54Bp25q/bDxK0GBOiGQDRONf0l?=
 =?Windows-1252?Q?B66K5jSYEz26P+Nirq1A1lyDar1CoKW9Zs/ksno7lWrGM+hWwR9/3tBY?=
 =?Windows-1252?Q?/XhUzk/BrX7p4SOzdEJe/TIeqFZiOdl1S5AjpuOSx4L4Xs1UxrcA8I9a?=
 =?Windows-1252?Q?DNn9SFG7D5czOyJScRUCdoAFE49eTy1Kf41iJLrowelp7G4oMEHPcXdh?=
 =?Windows-1252?Q?gQ85QCnrk1hV5+fp348Oy2/2onSBrwrtTR+rgP/fk2lxJIXsdFHK3bIf?=
 =?Windows-1252?Q?63HulabowcCQI7YaSuieCxTJ2C9uG2YIoyx69PYOpOwCD8EXNmGqx+v3?=
 =?Windows-1252?Q?pKS4lD2uts11PBApVChoArs+dzVWMIT9Z868XwiYnCl2FM6G+hgTsEKT?=
 =?Windows-1252?Q?x7oQV9VRPuzYd68Zho83vlNCVKJxYOQQ/cuRofNjEb7DYs26bzgdHldq?=
 =?Windows-1252?Q?9tdUvsHI9uYtXve455jX2v+t9XsRywHbFmo/qL0svF1mMdgQWe3U9Xp9?=
 =?Windows-1252?Q?ugwE5X1k+UWLj+vSIr2UvKW+mLbmmNCLtd93LqUO2dZoswMiiJAxZmAx?=
 =?Windows-1252?Q?/EaYTI/Yl7Jetsudy3eLRhq9uduqojF1FqbWpiW3+NUJjcHfxTfoOUsQ?=
 =?Windows-1252?Q?ePkkJSWKegDGmpUjpwDN2LEKdgy8IILvQTN6ZkZCovaVNLmI+i4vLr99?=
 =?Windows-1252?Q?cFm9s4dJHoWuuHLAtybg9S10Gb78zaEH0uYPLhSE5SAWusZl9OeInPxw?=
 =?Windows-1252?Q?F4pwVM5LhwwU8Xt4oeLOecwAmUdJfFjJXfZcUcPIURBSHeUATOJiPVoO?=
 =?Windows-1252?Q?+6rPstJ30awsmRdxTIsky8PrctT+N0qu26Pq94BB/YIErCIjvGfxP1ym?=
 =?Windows-1252?Q?pdq18GTBXqmJAmLW+/2fndnuVSCLriYoFv+yh/XX/izorHUUF8bNeuzN?=
 =?Windows-1252?Q?Jtm6p1nznrUpOvlS8xQ5qhPaBrf/C/e1IVRnN2FdcBb0fp8PHpcTrTjE?=
 =?Windows-1252?Q?ha5FvOE7dwqo/Jg5jzYrxnYp5wY7XPwfePszZ8rs7khIH2oGWw6Lubi0?=
 =?Windows-1252?Q?crzxupm4K9iYTumXcqZIh3kaLPo0s+v4OtV9lqC4gSRRcK24hMihLg8u?=
 =?Windows-1252?Q?NpsQdICuypYZndeXiWnw5qTfDU0ra9RyVh1lIrzLuor8nGJQeqCHbCVL?=
 =?Windows-1252?Q?40GOmrFjml1wiV0rygBL63WZO/tiliCDXDebrCmzpiClVButAq27jwOr?=
 =?Windows-1252?Q?GDsmpI/VDKOYtmGi52ZRp/0zgYVrcs7OgFzhZsXNu2h3eFNrd+q0KtMt?=
 =?Windows-1252?Q?LS0LMbLwwwCDRld3k4LtxznVH/F6Wi2JS+31xpkrtHB1agW0sUo1fan8?=
 =?Windows-1252?Q?ohHeY6MGnXi9d5XvH5xuCb18EDCrlESi0UaIMsVvetYB5BqB7CswYd4a?=
 =?Windows-1252?Q?MhvexH5mC96HqV0dUZXkGFRhCMZLiRoObKeGpEzAjsPn+dVmjc6bPIBc?=
 =?Windows-1252?Q?xBErajT2RkllOUIYw1NIO/Km6fa8qa+2rZgqrx754Opl3VisbzBV7Ed0?=
 =?Windows-1252?Q?oBzrYbAP2TrgeuhfzFT9jg4nmUdR9pxzVIEHCEDL+Vu5KR9fJCwdR6nn?=
 =?Windows-1252?Q?vEBi+D2GtCYQJYrsrq7NIooQEOsFaKREvRjw6I74MryHaLRENIP25yJa?=
 =?Windows-1252?Q?yJllLo7hVLa95XfXn3svFJu7xI4Pp9ER?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2DM4PR12MB5937namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5937.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b21809-179c-4721-1348-08dd82380b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 07:25:37.1907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlrsUqnw3C+TLwlQat+81bYWvrs8n20ysADzfiZ6TSHWWp63G+cB1R5uTeT6ZH1y0cCsqoLncfSLN1c1BQbshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

--_000_DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2DM4PR12MB5937namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Christian,

Thank you for the review and the feedback. I will update the patch accordin=
g to your feedback.
Please see my 2 inline comments below.

Regards
Sam


> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
> Date: Wednesday, April 16, 2025 at 21:52
> To: Zhang, GuoQing (Sam) <GuoQing.Zhang@amd.com>, amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
> Cc: Zhao, Victor <Victor.Zhao@amd.com>, Chang, HaiJun <HaiJun.Chang@amd.c=
om>, Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation on SRIOV
> Am 14.04.25 um 12:46 schrieb Samuel Zhang:
> > When switching to new GPU index after hibernation and then resume,
> > VRAM offset of each VRAM BO will be changed, and the cached gpu
> > addresses needed to updated.
> >
> > This is to enable pdb0 and switch to use pdb0-based virtual gpu
> > address by default in amdgpu_bo_create_reserved(). since the virtual
> > addresses do not change, this can avoid the need to update all
> > cached gpu addresses all over the codebase.
> >
> > Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> > Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> > Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 43 +++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++-
> >  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 29 +++++++++------
> >  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 30 ++++++++++++---
> >  6 files changed, 82 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 5b60d714e089..e706afcb7e95 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct amdgpu_devic=
e *adev, struct amdgpu_gmc *mc,
> >  void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdg=
pu_gmc *mc)
> >  {
> >        u64 hive_vram_start =3D 0;
> > -     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_p=
hysical_nodes - 1;
> > -     mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.physical=
_node_id;
> > -     mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_size - 1;
> > +     u64 hive_vram_end =3D mc->xgmi.node_segment_size * mc->xgmi.num_p=
hysical_nodes;
> > +
> > +     hive_vram_end =3D ALIGN(hive_vram_end, (1ULL<<adev->gmc.vmid0_pag=
e_table_block_size)<<21) - 1;
> > +
> > +     if (!mc->vram_start) {
> > +             mc->vram_start =3D mc->xgmi.node_segment_size * mc->xgmi.=
physical_node_id;
> > +             mc->vram_end =3D mc->vram_start + mc->xgmi.node_segment_s=
ize - 1;
> > +             dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%=
lluM used)\n",
> > +                     mc->mc_vram_size >> 20, mc->vram_start,
> > +                     mc->vram_end, mc->real_vram_size >> 20);
> > +     }
> > +
> >        mc->gart_start =3D hive_vram_end + 1;
> >        mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> >        mc->fb_start =3D hive_vram_start;
> >        mc->fb_end =3D hive_vram_end;
> > -     dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM use=
d)\n",
> > -                     mc->mc_vram_size >> 20, mc->vram_start,
> > -                     mc->vram_end, mc->real_vram_size >> 20);
> > -     dev_info(adev->dev, "GART: %lluM 0x%016llX - 0x%016llX\n",
> > -                     mc->gart_size >> 20, mc->gart_start, mc->gart_end=
);
> > +
> > +     dev_info(adev->dev, "FB 0x%016llX - 0x%016llX, GART: %lluM 0x%016=
llX - 0x%016llX\n",
> > +                     mc->fb_start, mc->fb_end, mc->gart_size >> 20, mc=
->gart_start, mc->gart_end);
> >  }
> >
> >  /**
> > @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device =
*adev, uint32_t vmid,
> >                                     &job);
> >        if (r)
> >                goto error_alloc;
> > -
> > -     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> > +     job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> > +                                                     adev->gmc.pdb0_bo=
 :
> > +                                                     adev->gart.bo);
> >        job->vm_needs_flush =3D true;
> >        job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> >        amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> > @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
> >         */
> >        u64 vram_size =3D adev->gmc.xgmi.node_segment_size * adev->gmc.x=
gmi.num_physical_nodes;
> >        u64 pde0_page_size =3D (1ULL<<adev->gmc.vmid0_page_table_block_s=
ize)<<21;
> > -     u64 vram_addr =3D adev->vm_manager.vram_base_offset -
> > +     u64 vram_addr_first =3D adev->vm_manager.vram_base_offset -
> >                adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_se=
gment_size;
> > +     u64 vram_addr =3D adev->vm_manager.vram_base_offset;
> >        u64 vram_end =3D vram_addr + vram_size;
> >        u64 gart_ptb_gpu_pa =3D amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> >        int idx;
> > @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device =
*adev)
> >        flags |=3D AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_siz=
e + 9*1));
> >        flags |=3D AMDGPU_PDE_PTE_FLAG(adev);
> >
> > +     if (adev->gmc.xgmi.connected_to_cpu) {
> > +             vram_addr =3D vram_addr_first;
> > +             vram_end =3D vram_addr + vram_size;
> > +     }
> > +
> >        /* The first n PDE0 entries are used as PTE,
> >         * pointing to vram
> >         */
> > -     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page=
_size)
> > -             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_=
addr, flags);
> > +     for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page=
_size) {
> > +             amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i,
> > +                     (vram_addr >=3D vram_addr_first + vram_size) ? (v=
ram_addr - vram_size) : vram_addr,
> > +                     flags);
> > +     }
> >
> >        /* The n+1'th PDE0 entry points to a huge
> >         * PTB who has more than 512 entries each
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index bd7fc123b8f9..758b47240c6f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -307,6 +307,7 @@ struct amdgpu_gmc {
> >        struct amdgpu_bo                *pdb0_bo;
> >        /* CPU kmapped address of pdb0*/
> >        void                            *ptr_pdb0;
> > +     bool enable_pdb0;
> >
> >        /* MALL size */
> >        u64 mall_size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index d90e9daf5a50..83a3444c69d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct amdgpu_device=
 *adev,
> >                goto error_unpin;
> >        }
> >
> > -     if (gpu_addr)
> > +     if (gpu_addr) {
> >                *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);
> > +             if (!adev->gmc.xgmi.connected_to_cpu && adev->gmc.enable_=
pdb0) {
> > +                     if ((*bo_ptr)->tbo.resource->mem_type =3D=3D TTM_=
PL_VRAM) {
> > +                             *gpu_addr -=3D amdgpu_ttm_domain_start(ad=
ev, TTM_PL_VRAM);
> > +                     }
> > +             }
> > +     }
>
> Please NAK to that approach here. The GPU offset should still point into =
the mapped VRAM.

This change is to change to the default GPU address from FB aperture type t=
o pdb0 type in this centralized place so that I don=92t need to change ever=
y callsite of amdgpu_bo_create_reserved().
Could you suggest a better approach if this approach is not acceptable?


>
>
> >
> >        if (cpu_addr) {
> >                r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm=
/amd/amdgpu/gfxhub_v1_2.c
> > index cb25f7f0dfc1..5ebb92ac9fd7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> > @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct am=
dgpu_device *adev,
> >                /* In the case squeezing vram into GART aperture, we don=
't use
> >                 * FB aperture and AGP aperture. Disable them.
> >                 */
> > -             if (adev->gmc.pdb0_bo) {
> > +             if (adev->gmc.pdb0_bo && !amdgpu_sriov_vf(adev)) {
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LO=
CATION_TOP, 0);
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LO=
CATION_BASE, 0x00FFFFFF);
> >                        WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_T=
OP, 0);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index 7c7a9fe6be6d..73ac05b9a1bf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_=
block *ip_block)
> >                adev->gmc.private_aperture_start + (4ULL << 30) - 1;
> >        adev->gmc.noretry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;
> >
> > +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) ||
> > +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4=
) ||
> > +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
))
> > +         adev->gmc.enable_pdb0 =3D amdgpu_sriov_vf(adev);
> >        return 0;
> >  }
> >
> > @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_location(struct am=
dgpu_device *adev,
> >  {
> >        u64 base =3D adev->mmhub.funcs->get_fb_location(adev);
> >
> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0) {
> > +             adev->gmc.vmid0_page_table_depth =3D 1;
> > +             adev->gmc.vmid0_page_table_block_size =3D 12;
> > +     } else {
> > +             adev->gmc.vmid0_page_table_depth =3D 0;
> > +             adev->gmc.vmid0_page_table_block_size =3D 0;
> > +     }
> > +
>
> What is the justification to moving that stuff around?

vmid0_page_table_block_size is used in new code in amdgpu_gmc_sysvm_locatio=
n(). See the call sequence below.

gmc_v9_0_sw_init
- gmc_v9_0_mc_init
                - gmc_v9_0_vram_gtt_location,
                                - vmid0_page_table_block_size =3D 12, **new=
 location**
                                - amdgpu_gmc_sysvm_location
                                                - use **vmid0_page_table_bl=
ock_size**
- gmc_v9_0_gart_init,
                - assign vmid0_page_table_block_size, **old location**



>
> >        amdgpu_gmc_set_agp_default(adev, mc);
> >
> >        /* add the xgmi offset of the physical node */
> > @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_location(struct am=
dgpu_device *adev,
> >                amdgpu_gmc_sysvm_location(adev, mc);
> >        } else {
> >                amdgpu_gmc_vram_location(adev, mc, base);
> > -             amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_=
BEST_FIT);
> > +             if (!adev->gmc.enable_pdb0)
> > +                     amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PL=
ACEMENT_BEST_FIT);
> > +             else
> > +                     amdgpu_gmc_sysvm_location(adev, mc);
> >                if (!amdgpu_sriov_vf(adev) && (amdgpu_agp =3D=3D 1))
> >                        amdgpu_gmc_agp_location(adev, mc);
> >        }
> > @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct amdgpu_devi=
ce *adev)
> >                return 0;
> >        }
> >
> > -     if (adev->gmc.xgmi.connected_to_cpu) {
> > -             adev->gmc.vmid0_page_table_depth =3D 1;
> > -             adev->gmc.vmid0_page_table_block_size =3D 12;
> > -     } else {
> > -             adev->gmc.vmid0_page_table_depth =3D 0;
> > -             adev->gmc.vmid0_page_table_block_size =3D 0;
> > -     }
> > -
> >        /* Initialize common gart structure */
> >        r =3D amdgpu_gart_init(adev);
> >        if (r)
> > @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_devic=
e *adev)
> >                if (r)
> >                        return r;
> >
> > -             if (adev->gmc.xgmi.connected_to_cpu)
> > +             if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_p=
db0)
>
> Drop the connected_to_cpu check here.
>
> >                        r =3D amdgpu_gmc_pdb0_alloc(adev);
> >        }
> >
> > @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_dev=
ice *adev)
> >  {
> >        int r;
> >
> > -     if (adev->gmc.xgmi.connected_to_cpu)
> > +     if (adev->gmc.xgmi.connected_to_cpu || adev->gmc.enable_pdb0)
>
> And here.
>
> >                amdgpu_gmc_init_pdb0(adev);
> >
> >        if (adev->gart.bo =3D=3D NULL) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v9_4.c
> > index fe0710b55c3a..13b229d07ac4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
> > @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt_regs(struc=
t amdgpu_device *adev, int hu
> >  static void mmhub_v9_4_init_gart_aperture_regs(struct amdgpu_device *a=
dev,
> >                                               int hubid)
> >  {
> > -     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> > +     uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ? adev-=
>gmc.pdb0_bo : adev->gart.bo);
>
> That can be written as adev->gmc.pdb0_bo ?: adev->gart.bo
>
> >
> >        mmhub_v9_4_setup_hubid_vm_pt_regs(adev, hubid, 0, pt_base);
> >
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +     if (adev->gmc.pdb0_bo) {
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_STAR=
T_ADDR_LO32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.fb_start >> 12));
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_STAR=
T_ADDR_HI32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.fb_start >> 44));
> > +
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_=
ADDR_LO32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.gart_end >> 12));
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> > +                                 mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_=
ADDR_HI32,
> > +                                 hubid * MMHUB_INSTANCE_REGISTER_OFFSE=
T,
> > +                                 (u32)(adev->gmc.gart_end >> 44));
> > +     } else {
> > ++            WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_=
LO32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_start >> 12));
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_=
HI32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_start >> 44));
>
> When you indent the WREG32_SOC15_OFFSET() you need to indent the followin=
g lines as well.
>
> >
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO=
32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_end >> 12));
> > -     WREG32_SOC15_OFFSET(MMHUB, 0,
> > +             WREG32_SOC15_OFFSET(MMHUB, 0,
> >                            mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI=
32,
> >                            hubid * MMHUB_INSTANCE_REGISTER_OFFSET,
> >                            (u32)(adev->gmc.gart_end >> 44));
> > +     }
>
> The programming of the end addr is still the same, you don't need to chan=
ge anything here.
>
> Regards,
> Christian.
>
> >  }
> >
> >  static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_device *adev, ui=
nt32_t vmid,
>

--_000_DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2DM4PR12MB5937namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.apple-converted-space
	{mso-style-name:apple-converted-space;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div style=3D"mso-element:para-border-div;border:none;border-bottom:solid w=
indowtext 1.0pt;padding:0cm 0cm 1.0pt 0cm">
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span style=3D"fon=
t-family:&quot;Aptos&quot;,sans-serif">Hi Ch</span><span lang=3D"EN-US" sty=
le=3D"font-family:&quot;Aptos&quot;,sans-serif">ristian,
</span><span style=3D"font-family:&quot;Aptos&quot;,sans-serif"><o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span style=3D"fon=
t-family:&quot;Aptos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span style=3D"fon=
t-family:&quot;Aptos&quot;,sans-serif">Thank you for the review and the fee=
dback.</span><span lang=3D"EN-US" style=3D"font-family:&quot;Aptos&quot;,sa=
ns-serif"> I will update the patch according to your feedback.
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span lang=3D"EN-U=
S" style=3D"font-family:&quot;Aptos&quot;,sans-serif">Please see my 2 inlin=
e comments below.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span lang=3D"EN-U=
S" style=3D"font-family:&quot;Aptos&quot;,sans-serif"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span lang=3D"EN-U=
S" style=3D"font-family:&quot;Aptos&quot;,sans-serif">Regards<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span lang=3D"EN-U=
S" style=3D"font-family:&quot;Aptos&quot;,sans-serif">Sam<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"border:none;padding:0cm"><span style=3D"fon=
t-family:&quot;Aptos&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Date: Wednesday, April 16, 2025 at 21:52<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; To: Zhang, GuoQing (Sam) &lt;GuoQing.Zhang@amd.com&gt;, amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Cc: Zhao, Victor &lt;Victor.Zhao@amd.com&gt;, Chang, HaiJun &lt;H=
aiJun.Chang@amd.com&gt;, Deng, Emily &lt;Emily.Deng@amd.com&gt;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Subject: Re: [PATCH 4/6] drm/amdgpu: enable pdb0 for hibernation =
on SRIOV<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Am 14.04.25 um 12:46 schrieb Samuel Zhang:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; When switching to new GPU index after hibernation and then r=
esume,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; VRAM offset of each VRAM BO will be changed, and the cached =
gpu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; addresses needed to updated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; This is to enable pdb0 and switch to use pdb0-based virtual =
gpu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; address by default in amdgpu_bo_create_reserved(). since the=
 virtual<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; addresses do not change, this can avoid the need to update a=
ll<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; cached gpu addresses all over the codebase.<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Signed-off-by: Emily Deng &lt;Emily.Deng@amd.com&gt;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Signed-off-by: Samuel Zhang &lt;guoqing.zhang@amd.com&gt;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; Change-Id: I2b20b9b94f1e41820a013ce5d05bb3fa96859b21<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; ---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nb=
sp; | 43 +++++++++++++++-------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h&nbsp;&nbsp;&nb=
sp; |&nbsp; 1 +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |&nbsp; 8 +=
++-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c&nbsp;&nbsp; |=
&nbsp; 2 +-<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 29 +++++++++------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c&nbsp;&nbsp;&nb=
sp; | 30 ++++++++++++---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; 6 files changed, 82 insertions(+), 31 deletions(-)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index 5b60d714e089..e706afcb7e95 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -248,18 +248,25 @@ void amdgpu_gmc_vram_location(struct a=
mdgpu_device *adev, struct amdgpu_gmc *mc,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; void amdgpu_gmc_sysvm_location(struct amdgpu_device *a=
dev, struct amdgpu_gmc *mc)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_star=
t =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.num_physical_nodes - 1;<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.physical_node_id;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_st=
art + mc-&gt;xgmi.node_segment_size - 1;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 hive_vram_end =3D mc-&gt;xgmi.=
node_segment_size * mc-&gt;xgmi.num_physical_nodes;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; hive_vram_end =3D ALIGN(hive_vram_=
end, (1ULL&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21) - 1;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!mc-&gt;vram_start) {<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; mc-&gt;vram_start =3D mc-&gt;xgmi.node_segment_size * mc-&gt;=
xgmi.physical_node_id;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; mc-&gt;vram_end =3D mc-&gt;vram_start + mc-&gt;xgmi.node_segm=
ent_size - 1;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM: %lluM 0x%016llX - 0x%016ll=
X (%lluM used)\n&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vra=
m_size &gt;&gt; 20, mc-&gt;vram_start,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_e=
nd, mc-&gt;real_vram_size &gt;&gt; 20);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_start =
=3D hive_vram_end + 1;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_end =
=3D mc-&gt;gart_start + mc-&gt;gart_size - 1;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_start =
=3D hive_vram_start;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_end =3D =
hive_vram_end;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;VRAM:=
 %lluM 0x%016llX - 0x%016llX (%lluM used)\n&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;mc_vra=
m_size &gt;&gt; 20, mc-&gt;vram_start,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;vram_e=
nd, mc-&gt;real_vram_size &gt;&gt; 20);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GART:=
 %lluM 0x%016llX - 0x%016llX\n&quot;,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;gart_s=
ize &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;gart_end);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;FB 0x=
%016llX - 0x%016llX, GART: %lluM 0x%016llX - 0x%016llX\n&quot;,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mc-&gt;fb_sta=
rt, mc-&gt;fb_end, mc-&gt;gart_size &gt;&gt; 20, mc-&gt;gart_start, mc-&gt;=
gart_end);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; /**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -677,8 +684,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amd=
gpu_device *adev, uint32_t vmid,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &amp;job);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_alloc;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_=
pd_addr(adev-&gt;gart.bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_pd_addr =3D amdgpu_gmc_=
pd_addr(adev-&gt;gmc.pdb0_bo ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.pdb0_bo :<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gart.bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;vm_needs_f=
lush =3D true;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;ibs-&gt;pt=
r[job-&gt;ibs-&gt;length_dw++] =3D ring-&gt;funcs-&gt;nop;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_pad_ib=
(ring, &amp;job-&gt;ibs[0]);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1041,8 +1049,9 @@ void amdgpu_gmc_init_pdb0(struct amdgp=
u_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_size =3D =
adev-&gt;gmc.xgmi.node_segment_size * adev-&gt;gmc.xgmi.num_physical_nodes;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 pde0_page_size=
 =3D (1ULL&lt;&lt;adev-&gt;gmc.vmid0_page_table_block_size)&lt;&lt;21;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_mana=
ger.vram_base_offset -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr_first =3D adev-&gt;v=
m_manager.vram_base_offset -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.physical_node_id * adev-&gt=
;gmc.xgmi.node_segment_size;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_addr =3D adev-&gt;vm_mana=
ger.vram_base_offset;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_end =3D v=
ram_addr + vram_size;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 gart_ptb_gpu_p=
a =3D amdgpu_gmc_vram_pa(adev, adev-&gt;gart.bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1056,11 +1065,19 @@ void amdgpu_gmc_init_pdb0(struct amd=
gpu_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_=
PTE_FRAG((adev-&gt;gmc.vmid0_page_table_block_size + 9*1));<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_=
PDE_PTE_FLAG(adev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; vram_addr =3D vram_addr_first;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; vram_end =3D vram_addr + vram_size;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first n PDE=
0 entries are used as PTE,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * pointing t=
o vram<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_=
end; i++, vram_addr +=3D pde0_page_size)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i, vram_a=
ddr, flags);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; vram_addr &lt; vram_=
end; i++, vram_addr +=3D pde0_page_size) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_set_pte_pde(adev, adev-&gt;gmc.ptr_pdb0, i,<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (vram_addr &g=
t;=3D vram_addr_first + vram_size) ? (vram_addr - vram_size) : vram_addr,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags);<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The n+1'th PDE0=
 entry points to a huge<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * PTB who ha=
s more than 512 entries each<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_gmc.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index bd7fc123b8f9..758b47240c6f 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -307,6 +307,7 @@ struct amdgpu_gmc {<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; *pdb0_bo;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* CPU kmapped add=
ress of pdb0*/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
ptr_pdb0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; bool enable_pdb0;<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MALL size */<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 mall_size;<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index d90e9daf5a50..83a3444c69d9 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -287,8 +287,14 @@ int amdgpu_bo_create_reserved(struct am=
dgpu_device *adev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unpin;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr)<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_addr) {<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr =3D amdgpu_bo_gpu_offset(*bo_ptr);<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; adev-&gt;g=
mc.enable_pdb0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo_ptr)=
-&gt;tbo.resource-&gt;mem_type =3D=3D TTM_PL_VRAM) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_addr -=3D amdgpu_ttm_domain_start(a=
dev, TTM_PL_VRAM);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Please NAK to that approach here. The GPU offset should still poi=
nt into the mapped VRAM.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#212121">This change is to change to the default G=
PU address from FB aperture type to pdb0 type in this centralized place so =
that I don=92t need to change every callsite of amdgpu_bo_create_reserved()=
.</span><span style=3D"color:#212121"><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"caret-color: rgb(33, 33, 33);font-variant-c=
aps: normal;orphans: auto;text-align:start;widows: auto;-webkit-text-stroke=
-width: 0px;word-spacing:0px">
<span lang=3D"EN-US" style=3D"font-family:&quot;Aptos&quot;,sans-serif;colo=
r:#212121">Could you suggest a better approach if this approach is not acce=
ptable?<span class=3D"apple-converted-space">&nbsp;</span></span><span styl=
e=3D"color:#212121"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr) {<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/driv=
ers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index cb25f7f0dfc1..5ebb92ac9fd7 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -180,7 +180,7 @@ gfxhub_v1_2_xcc_init_system_aperture_reg=
s(struct amdgpu_device *adev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In the case squeezing vram into GART apert=
ure, we don't use<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FB aperture and AGP aperture. Disable=
 them.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo &amp;&amp; !amdgpu_sriov_vf(adev)) {=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF)=
;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers=
/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index 7c7a9fe6be6d..73ac05b9a1bf 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1677,6 +1677,10 @@ static int gmc_v9_0_early_init(struct=
 amdgpu_ip_block *ip_block)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.private_aperture_start + (4ULL &=
lt;&lt; 30) - 1;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.noret=
ry_flags =3D AMDGPU_VM_NORETRY_FLAGS_TF;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, GC_HWI=
P, 0) =3D=3D IP_VERSION(9, 4, 3) ||<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) ||<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_=
version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;g=
mc.enable_pdb0 =3D amdgpu_sriov_vf(adev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1719,6 +1723,14 @@ static void gmc_v9_0_vram_gtt_locatio=
n(struct amdgpu_device *adev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 base =3D adev-=
&gt;mmhub.funcs-&gt;get_fb_location(adev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu || adev-&gt;gmc.enable_pdb0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; What is the justification to moving that stuff around?<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">vmid0_page_table_block_size is used in new code in amdg=
pu_gmc_sysvm_location(). See the call sequence below.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">gmc_v9_0_sw_init<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- gmc_v9_0_mc_init<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - gmc_v9_0_vram_gtt_location,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - vmid0_page_table=
_block_size =3D 12, **new location**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - amdgpu_gmc_sysvm=
_location<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; - use **vmid0_page_table_block_size**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">- gmc_v9_0_gart_init,
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - assign vmid0_page_table_block_size, *=
*old location**<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_set_agp=
_default(adev, mc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add the xgmi of=
fset of the physical node */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1727,7 +1739,10 @@ static void gmc_v9_0_vram_gtt_locatio=
n(struct amdgpu_device *adev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sysvm_location(adev, mc);<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_vram_location(adev, mc, base);<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST=
_FIT);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (!adev-&gt;gmc.enable_pdb0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_ga=
rt_location(adev, mc, AMDGPU_GART_PLACEMENT_BEST_FIT);<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; else<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_sy=
svm_location(adev, mc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) &amp;&amp; (amdgpu=
_agp =3D=3D 1))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; amdgpu_gmc_agp_location(adev, mc);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1838,14 +1853,6 @@ static int gmc_v9_0_gart_init(struct =
amdgpu_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 1;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 12;<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_depth =3D 0;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vmid0_page_table_block_size =3D 0;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize comm=
on gart structure */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gart_=
init(adev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -1864,7 +1871,7 @@ static int gmc_v9_0_gart_init(struct a=
mdgpu_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return r;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu || adev-&gt;gmc.enable=
_pdb0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Drop the connected_to_cpu check here.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; r =3D amdgpu_gmc_pdb0_alloc(adev);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -2361,7 +2368,7 @@ static int gmc_v9_0_gart_enable(struct=
 amdgpu_device *adev)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to=
_cpu || adev-&gt;gmc.enable_pdb0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; And here.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc_init_pdb0(adev);<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.=
bo =3D=3D NULL) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drive=
rs/gpu/drm/amd/amdgpu/mmhub_v9_4.c<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; index fe0710b55c3a..13b229d07ac4 100644<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; @@ -74,27 +74,47 @@ static void mmhub_v9_4_setup_hubid_vm_pt=
_regs(struct amdgpu_device *adev, int hu<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; static void mmhub_v9_4_init_gart_aperture_regs(struct =
amdgpu_device *adev,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int hubid=
)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd=
_addr(adev-&gt;gart.bo);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pt_base =3D amdgpu_gmc_pd=
_addr(adev-&gt;gmc.pdb0_bo ? adev-&gt;gmc.pdb0_bo : adev-&gt;gart.bo);<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; That can be written as adev-&gt;gmc.pdb0_bo ?: adev-&gt;gart.bo<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmhub_v9_4_setup_h=
ubid_vm_pt_regs(adev, hubid, 0, pt_base);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.pdb0_bo) {<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_START_ADDR_LO32,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.fb_start &gt;&gt; 12));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_START_ADDR_HI32,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.fb_start &gt;&gt; 44));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_END_ADDR_LO32,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.gart_end &gt;&gt; 12));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CON=
TEXT0_PAGE_TABLE_END_ADDR_HI32,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_IN=
STANCE_REGISTER_OFFSET,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;g=
mc.gart_end &gt;&gt; 44));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; ++&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 12));<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32=
,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_start &gt;&gt; 44));<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; When you indent the WREG32_SOC15_OFFSET() you need to indent the =
following lines as well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 12));<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; WREG32_SOC15_OFFSET(MMHUB, 0,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; mmVML2VC0_VM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; hubid * MMHUB_INSTANCE_REGISTER_OFFSET,<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; (u32)(adev-&gt;gmc.gart_end &gt;&gt; 44));<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; The programming of the end addr is still the same, you don't need=
 to change anything here.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; Christian.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt; &gt;&nbsp; static void mmhub_v9_4_setup_vm_pt_regs(struct amdgpu_=
device *adev, uint32_t vmid,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif">&gt;<o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB59376B41F123C09AB3DDDF7EE5BA2DM4PR12MB5937namp_--
