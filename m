Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CCC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C5464DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5464DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0BEC6E165;
	Mon, 15 Mar 2021 19:39:41 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750044.outbound.protection.outlook.com [40.107.75.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8ECF6E165
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA/eQMwaGNqc4XpfeylLSZeqtg8yMYIt6+owRY/wDaBoAb/QDUXTtN6yJlQUVU93HqWwR6vVYhUhlhiGf1G1YRKFG1SukFXBSqn6Fzntk4//iu6I1WdM7u8ks4pPEiqUdOWS1WnDu1uToygNmFoIETqTBGzZ1xqPE9dOnWqz+N80G/4WBtfBRCReZkWi8r5rnni6vv0nlASrX5y23QA83keTaxuDRxck1CCqgPVnOGLXBPYhtVqHwHs+3CDC4lsyH2Qar8Fk+X41zNVWPPbk1mkWP8iwAjmCooM4nn6QbVLYT4nm7MDPQUrUVSpAZa7qI593zXxNhm6/vRaLozdiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5izZS0g8FMaKdd40YfJK7uYg0d6DTETFPmScymQ/n/U=;
 b=mYT7dh0IbXCyh5wCb9463xVkYRT1vEDTeJGm7L6X6t4E8GxbhYOl9VEyPxIZBW6AXtpbl6gSvPXFe0WtTxDtJXmFhYqyN+avILcdBKMjqtfMAfCM+0ZB86xSp32YRKh29v5Kwz3k8jmC3gqu8sV4zQZ0mUSPpYE0qdCikBFrKHw+38WKezgLz/3UkQsXEJAjYdMzqZNKAwO1yARiSnUJl7G7aFmmZqLonjQ345+PjvptxQvL5mQo/B/bN3TcK6afiAJz5OeJBc0QAgkv12O7lqRfIMGwCLaFPCZH8dIcKvl1ivdOWuh33GpwuVpQTnZCZipcMfDV9FEWBjQokrSPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5izZS0g8FMaKdd40YfJK7uYg0d6DTETFPmScymQ/n/U=;
 b=fnCEuO46jaC27N0eoeggAD7wfcHqrOReCore1cTt3F/MXJXrgwGjGfgCtbze2rTk6BQFUR9f6Pxf9UibfkEr3SgN4dgLFfWCG/gL4V84fxd+zUIUKzvm/ReN85k/4B6DK9LoZWOtbOg+tmqqnxOxlv4VI7BU+v5WQsCrFXoarvM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:39:38 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:39:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das, Nirmoy"
 <Nirmoy.Das@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Index: AQHXFia5I+1Uep6oqEqhvw5i41r0XaqFaZuAgAAAwuCAAAjXAIAAAaYAgAAEnmA=
Date: Mon, 15 Mar 2021 19:39:38 +0000
Message-ID: <MN2PR12MB4488FB57C4A65A1E9D7C8747F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
 <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
 <MN2PR12MB44889671D32DD33422D00820F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <d05f8abd-312b-5f30-5045-e17b7e4066be@amd.com>
 <MN2PR12MB44883D9863A8FDBB15A9927DF76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44883D9863A8FDBB15A9927DF76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T19:39:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=08f35100-7ffd-4862-8cab-1697bdf84123;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd010ecd-a241-4d9b-ddce-08d8e7ea1244
x-ms-traffictypediagnostic: BL0PR12MB4915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49151B815FC6806E7F9DB0DEF76C9@BL0PR12MB4915.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uT/bs1hEGy9Ad7+kSQfVTtLON3Lmi5MjIecxBW3k4CfU48Psz3UNjRi4hUD5UGoWS3jmNVQ629VirmHtvz/XMTyQQ8DQ/ecmUoCjWlleCHU8CY11n4tg9XU5zEQuWbLM9ImSw6XPD1GeR7uKXMh3Wj8Dezdw56m7lYlS3Qt8RofZdkM0TQhXwQFKTQ4OBQkonH4iCrroZdkYKCO+7Y8U5WKv/5oLxWNa6OyCMqKKj8wmJxYoPOJHMCBxmLlyJN2nQIkdLNzfd0Sweb2PLXSs8zpO1f5kcYGamUoiOqYtUwxyA8of7ElIh6rs/+1A6C64wkzakEWApQgtbsoaJnpK8MuAklUhzq11FPd1PxDtCGZpD4ugcuu1wGF+k13HLcOSq6XQ4dEClq5PZH4dKsF7Y9qzZ5dBPtm5rtDR4/TE7PLjfA+35Hags7kapF/JBjHBUagIst8GcSgX5hDNsuy26MMTiWCxaRbl5SvwrNmFOGlXppZZLIzLwO48G/uCFL29MPXdy/cUkMZpq02nhUf7YFbFXyJeTD+KXpb9+nceKIhbxb24en7N1FX72wIWEiv+WIOW+d+3fKHimk25o39hlmNLaMU1b+9OuU+2Wpg5jJL+/4vEtKpaFla/WCDsJbsdo4ISSBK9DkWLlq+URfhLIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(186003)(53546011)(55016002)(83380400001)(316002)(110136005)(2940100002)(2906002)(66946007)(64756008)(33656002)(9686003)(45080400002)(26005)(6506007)(52536014)(478600001)(71200400001)(76116006)(5660300002)(8676002)(7696005)(8936002)(86362001)(66556008)(66446008)(966005)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ts7+aoFlJQko27MIQdRpdNb4kp3iS2EEzKEDHcLoQG+b9O1SHoiIelH4ZjYJ?=
 =?us-ascii?Q?pxvj7KMVqYJSNtCj9ZsDp8uHWbLoUC4/ktSWxET6jQak3USjPbEL4weuTqqM?=
 =?us-ascii?Q?a4pcTWFO71645BIzvdzuw+6pB3AniOuDlXMZ3EOTPVqebr1O6mKwyMZ2uW0L?=
 =?us-ascii?Q?1fI6XH1M4e6pYPyDqVWWEVV2bMU1OjR9xNkicTLkvfzdk9GVrj4rbA5fTYyF?=
 =?us-ascii?Q?Z7zAxvIlENk5uQCw/0FqeBYTetMv7IKQpa4cgJ1i5Y6aCYXYh/+bG6ssonzr?=
 =?us-ascii?Q?i1WE4g5yagHV6JfGqoMSSFtTnAEF7D1c2hTlPx9WBwWqcYW+rswhgY56A0yT?=
 =?us-ascii?Q?Aa1AvXMrWtpqnvPRMK8Lg1KCF3DXkaTvRUpArzSnE20FKflSVOMs3Vn/6uUW?=
 =?us-ascii?Q?i4b3Sdfws0HC73plr5M/LEnVEn1MkwG6EKd3ICLi2JfnxyyghtE7R6MinZoa?=
 =?us-ascii?Q?KblOvXXG802yIL2LPCABMuvvtxZXQwg0q3XemYDG5J9szCTdqRNdKaIrK2mP?=
 =?us-ascii?Q?B2rl/87Sbrs/ObNxwS9l/dr+dWBK9W7cHvoI9nAwf9N8SxKTP7RsS/a5ZaU3?=
 =?us-ascii?Q?m1SqU5YeAwPzxR0vT4AjGUwF+pF6SwYE/g9lDaqrsAmk/8JOCPv9rjydV3ro?=
 =?us-ascii?Q?LurjsDL+x0ZNT5R9ZMsEctR9v61kCPYaZj/MAOn2MCaDsZVEPspNo8xDEsD6?=
 =?us-ascii?Q?+D5sFIVDdWXVtgYtT9r/0/s+25f8jTmhInADUI4zLSi3/qNFcsTcHdLI6oru?=
 =?us-ascii?Q?hsK+MaL+3zJp+P+2fTWe6MaIsOzv3bJf4ZQf+zA3uT3Dio5QpPAm6A9sZWyR?=
 =?us-ascii?Q?zxJziOuOMG4Ex/xNawu/F8cnh48C11JC9aYnRHR8GlXxALZJ/3CVEtRmxDi5?=
 =?us-ascii?Q?DokHcmZpVNH8sepLAV3nsaXKwfNDDyNDwb4RAGs+FXE/qub7/GHllnLEx74W?=
 =?us-ascii?Q?M4LxPca+vpWupPj2ifrvRh0Buts4LOGf9iwuPcJiXv0K1NBmUdubOfCSV6+p?=
 =?us-ascii?Q?lJVq0FvFR4dM5TzQKR+0eTIWmLVYniZoJ1njdkrV4N54m/DMs7YKJRz4dMIQ?=
 =?us-ascii?Q?rs+ynhsAqQsUirqIh4Vue7kIneeUCEfjue6T/O2rn1xRakR6j0DTZ6Pa8OaK?=
 =?us-ascii?Q?AO2m3jKhnB/kJQzluvZw0gq/8HqpaNZ848k8gLU2y934Q6q4FekTvDmzg79M?=
 =?us-ascii?Q?gJyCvcoLx5atzaAZMhAeu7VhDWP/qjl0mnsfakeDKsBMgsgGd/liv2OhVXVE?=
 =?us-ascii?Q?RauShnb2l6Q/oMqIdtv4PrzLPdP3EBTmlrSqD540R5RTcPJLAQXMGryQLxJ6?=
 =?us-ascii?Q?Qk/xVMMNH22sLyJ8TDMMT5uD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd010ecd-a241-4d9b-ddce-08d8e7ea1244
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 19:39:38.6537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTAdqLNps0ZYuVaBo3YZJb08rLZYYL390Bw+szmqHsQYcGVfdYTBGL4JUL6JGaWouhhYMINdQmv6LXVbhX0jdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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

[AMD Public Use]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Deucher, Alexander
> Sent: Monday, March 15, 2021 3:24 PM
> To: Das, Nirmoy <Nirmoy.Das@amd.com>; Zeng, Oak
> <Oak.Zeng@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
> 
> [AMD Public Use]
> 
> > -----Original Message-----
> > From: Das, Nirmoy <Nirmoy.Das@amd.com>
> > Sent: Monday, March 15, 2021 3:17 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy
> > <Nirmoy.Das@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture
> > s390
> >
> > Hi Alex,
> >
> > On 3/15/21 7:46 PM, Deucher, Alexander wrote:
> > > [AMD Public Use]
> > >
> > >> -----Original Message-----
> > >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > >> Nirmoy
> > >> Sent: Monday, March 15, 2021 2:43 PM
> > >> To: Zeng, Oak <Oak.Zeng@amd.com>; amd-gfx@lists.freedesktop.org
> > >> Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on
> > >> architecture s390
> > >>
> > >> Wouldn't this restrict amdgpu for only x86 platform?
> > > This particular case will only be x86.
> >
> >
> > If I understand correctly, we map all the VRAM at startup to avoid
> >
> > mapping each BOs. Can't we do that for other Archs ?
> 
> You are right.  The else should be CONFIG_64BIT not CONFIG_X86.  @Zeng,
> Oak can you fix this up?

Just sent out the fix.

Alex

> 
> Alex
> 
> 
> >
> >
> > Nirmoy
> >
> >
> > >
> > > Alex
> > >
> > >> On 3/11/21 4:29 AM, Oak Zeng wrote:
> > >>> ioremap_cache is not supported on some architecture such as s390.
> > >>> Put the codes into a #ifdef to fix some compile error reported by
> > >>> test robot.
> > >>>
> > >>> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> > >>> Reported-by: Kernel test robot <lkp@intel.com>
> > >>> ---
> > >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > >>> index 37751e7..1091585 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > >>> @@ -1817,7 +1817,7 @@ int amdgpu_ttm_init(struct amdgpu_device
> > >> *adev)
> > >>>    	/* Change the size here instead of the init above so only lpfn
> > >>> is
> > >> affected */
> > >>>    	amdgpu_ttm_set_buffer_funcs_status(adev, false); -#ifdef
> > >>> CONFIG_64BIT
> > >>> +#ifdef CONFIG_X86
> > >>>    	if (adev->gmc.xgmi.connected_to_cpu)
> > >>>    		adev->mman.aper_base_kaddr =
> ioremap_cache(adev-
> > gmc.aper_base,
> > >>>    				adev->gmc.visible_vram_size);
> > >> _______________________________________________
> > >> amd-gfx mailing list
> > >> amd-gfx@lists.freedesktop.org
> > >>
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> > >> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > >>
> >
> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6fab18a743
> > >>
> >
> c84b8abbd008d8e7e21e10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > >>
> >
> C0%7C637514305648085244%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > >>
> >
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> > >>
> >
> p;sdata=KLYRSc45rllptRvyiOF18qA9IFt5zAGXL1zsHasgdLs%3D&amp;reserved
> > >> =0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7Cb8ba85a6c5
> 2449ad7ea908d8e7e7f43e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637514330707623225%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=k0wrS%2BIRR7D%2B7%2FA4S%2B%2F3Hcrb6VWJueVibaFaKlStNic%3
> D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
