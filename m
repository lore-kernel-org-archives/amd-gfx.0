Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF55C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 08:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D572910E9D6;
	Mon, 11 Apr 2022 08:55:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4F410E9D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 08:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwfU/cWC+rL0+sV7MX7eDr9JnjNhJCnAPyVWYqPvqU3QQO3ZM7HxaY3aGlqr7+y9HJmEybhBpS4fAwlx9HaWpOnOc9eoliAVHjm6vK+zsHj/ThJNCPqoNZG9svehT6woZlp2R7OH0umfZUcW3RaHQizz1MYwerbEDqDBCJduEO67aj9DQowLKWprLVJjTF4k2IaZ0hHSSUPCMp9p+i94lXg3qyy/BnBJV4PCnjy8WIlCTEhX9QUWK27i3E/jUXJjqLnV776c8Rlcuk6yKA4UUluAxVL605GcpkWKlP1w2KC/qNTor1CuAyewj6OIwnevoK9lBM4qRBvYcAS6ntyJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jpk/yRUMpUd7sTZFmTgz7jLZBT/RAkDt5eofbH5Cdss=;
 b=ay4bCzuh2IT15679lG5yFiLdRcM23pbY5Ebxh5+E7bdJCjO74Mrd5Pwrgay+GWfEYIYVp25nsKQ6X2cpw0DTkBjvSvCwqs8NsURuFgy3WdBEX4puWiVFpQJ2tltCGjPprI692r7zbWf4Qr826cUWtshJvX1bo+Sh5GrsWF0+c+/6HGILtA94NXTffs/DmmbwCG8gYR+4gR4SAFEj6rUpYv9+WZHEva3MR5yGqinK+nNmhEgrrgkVcytCHYgD6kyA3e6XaADK43Hzuqs8auJEzZ0bGdZ0qDEkMQ8RA2MocEleL6dyZ+WJuwSCxqxNBEmIPWR76zzeGXYfdDREQk9unA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpk/yRUMpUd7sTZFmTgz7jLZBT/RAkDt5eofbH5Cdss=;
 b=2oRpznj+NAcRYlGqeM2pfK/tgnuxwO3/+FmYOfTlB29n/opJjODnzCriMAD8iRlW6Fvl/A4rYbrPiwAf3Ow7ikxTkZmTsQqNuqj5/UEHQjaBm1FkXW+eCoUu5ZVhjBg6I7KEAxLhis+im2IXQEw3lzpcHETMZYwkIrHdP9gjiFw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 08:55:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc5c:3ef0:1281:98ba%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 08:55:55 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Thread-Topic: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Thread-Index: AQHYTXh4ixSDzBpGM0Ccv7AWv9u2KqzqWRkAgAAPzNA=
Date: Mon, 11 Apr 2022 08:55:55 +0000
Message-ID: <DM6PR12MB26199BCDC0375648B87661CDE4EA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220411074732.36486-1-evan.quan@amd.com>
 <78cdd8a2-4482-7b1b-2df4-a2983c1b2887@molgen.mpg.de>
In-Reply-To: <78cdd8a2-4482-7b1b-2df4-a2983c1b2887@molgen.mpg.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-11T08:55:52Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1968ba2e-d4b5-48f7-965e-e328c1623acf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8036cc36-9377-405e-eecc-08da1b9916e3
x-ms-traffictypediagnostic: DS7PR12MB5958:EE_
x-microsoft-antispam-prvs: <DS7PR12MB59582A68B2D6FA92A6A215AAE4EA9@DS7PR12MB5958.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6AEcdU+iKUQ4mEGXjksp7KJ7YwUQUsiVNLFM1mkCmYqmfbfR7tuwRcFTTWF0TNjm2d0aAEhEyxk1sl22opWBsQl9NzBl9ltFq2D3ocxBTex8Uwpth8dsS42H8Z1z8mHevzFy7Ul2z9jSt9hg8kmqq72nNjIFKn0Wr6qfbmcFLVm6kvRdua4LXfbDckYZ9WC81GzfyBEMMsgjibk7wZdOwdZ/DXD+Yhc3lC7/ORDmd5j7RqLcSwDS56E7NP2cFkylWbJ/IRZw9haHTt0ZY7m5fDF/SpC9YJAmVR2a1/R4JT32isVZ8VhL4CgOIJtr3FIJCEPh1VR1uGuCNWgoQ/tCa7G+os3dQ6Q82BevtvpQ5PSwTHg1nS46AvioacLRPgqO9AS421JCSuY3RMZ836Fi1/bs/iuLGsgjPM9M2HH8M0GtGTqYNNq1HC8uOqVezR25ozilm6hT/Zs86DJ29+sR7PwGJ5RLoSLtaghor0hjMfJW7q8tNIfIX+7EFdzDF+1nwNVe9oaLqbndgWOR7/qngvoGmQVrwtTUWo73lQnyTZUYSgftis+HKXGumPyWWaGR4QEMvMubi7r4pwwYmKxfL0zDgl9kXD+MmQ4KYnXDCHBEcXgE0N2YpUl5Fdx08tx2Nq+hsGEwvJ68dL2Inqyn9Mu6+zIRogdd3aDSxejcGEECQ8kiL8LuZnDdV0ckE5pUmCl5auMxVwI6D4yvcdrp/ZgsIMveDv35NZ0n3haDHGDOLMWYgTpw3PYWZx48h0ZX8qNoMeRs+m0HHJlIthiwVRYFbGl+apfti6JA1kpCqP1A8/J31JD7Ldwr39ZYmMq9DC9B4Jujl9LH3r/99PFscubdPIWA9QYWbRoSs42CeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6916009)(54906003)(86362001)(76116006)(4326008)(33656002)(66946007)(64756008)(966005)(8676002)(38100700002)(508600001)(45080400002)(8936002)(122000001)(52536014)(5660300002)(26005)(66556008)(66446008)(66476007)(186003)(38070700005)(55016003)(9686003)(316002)(71200400001)(7696005)(83380400001)(53546011)(6506007)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlPAihJxtp6KI4Xm8b1DmKYqv08xTe9ffs3Z8DqnVDFSrsjy8vIur7XGo+A5?=
 =?us-ascii?Q?ZnIPKCUcG2HIcB9d8xbVZ1PGJTjRSAv34snYSJiBiUD1sd2x3S7hutPIoOZv?=
 =?us-ascii?Q?ce0oTnrjGHd20eHPPXdroNocuPYiZGrXlOtSkrJBsJWNiNLY/lHYlaknvIxH?=
 =?us-ascii?Q?V87v6/ZVAJULuQCTE7bFogA3gRA5keKktn9zkYuQi/KFj4qCjA94ybK705aL?=
 =?us-ascii?Q?EZUT+OqBBq8bfXIkD1QohTEzas2Ajyw5Pmtk47LDvRpCbQJLOQXURRw0eaJo?=
 =?us-ascii?Q?/xuuRElhyBw2CSbi8Leg/fh4NIK9D6T/6hiMED8GfpHo9WX5bfOL95wViXR7?=
 =?us-ascii?Q?I29bcInB7LmxOhxp8Qjmv4XS5Jy5+vCoStp+d2aC8hR2/edxA8Z5qLEOTAS6?=
 =?us-ascii?Q?VW6FtIAbQ4mY0kVQ80vtSvUawrHLapI2KjoQKtCmCYZYRl2oz3+S5gx+wDU3?=
 =?us-ascii?Q?ILkesllt8aeKZfmM5zkiL+IW0z4mf8BvUGFCU4SSYfLpShY3bgfNWA0BW2Fa?=
 =?us-ascii?Q?UsWK0ZLvPS0k6Hj/oYiPrQQpfgnka5XGIWtBu4TtZiUf4Zqsz4qcKLgowDW5?=
 =?us-ascii?Q?Y7FTT2eHvYgtVeQmj4nWpMlTZaqIdnzS8CfJ35lzfAzBuNcF6+gTA/0cOPhB?=
 =?us-ascii?Q?G7PzYwavD27OVWp7hUh+JnvMT4iW8MKB4iyvN8fJ8MP9MeWiqfk1E1sBo7p0?=
 =?us-ascii?Q?QAf6e9BEIK0eELIM1qajoDA+47khYjMN3d8KvS3BZhFLjDvKlblobNZfZvU6?=
 =?us-ascii?Q?TU0imTw7k/rCE1TiBQhBHVf6J+2kC1ZzBmekWzPvaXnUO2yoybOLuumTcyXi?=
 =?us-ascii?Q?GVhrtQ4W7iQWrTjca3BzKTHXjfK5u3ihXk8ZQrYzgnl65QWI832dj9FEqa6k?=
 =?us-ascii?Q?S+FPyljlJ6g51/bZJP1EV5F8h6BpxCQn7sBW4IrWdjTbmFi8cd0hsZdzUe0V?=
 =?us-ascii?Q?L7e4GXABYuOVvYxAcDcdbedZr4W0aM1RhUGIfXorp0zlBKXIDjh1AGoZlzGf?=
 =?us-ascii?Q?k4xQTVsayTUuQ0vRzlBZ6hMcrwBKz9uNG7bocJ/PHD+cJz67NW3gt0vD/KZJ?=
 =?us-ascii?Q?/Y4ks8z9sWAuntk5uANBJzwjzdjY4ql14RVvg5d/BldaU9u7bSdObhYE2XGv?=
 =?us-ascii?Q?VXBDeEqRri9aKSapYbbikTITbBj1mG84tMbYs+9H3Kt4hh4eCb31mX3/Vhwl?=
 =?us-ascii?Q?0A8KpfkVynFDIUiXFDoxAsSWwqZ80sNXpTu0Zydzz8la3/Iqot7csggNTCPw?=
 =?us-ascii?Q?FjIsmspJODoAybuJdnfjOw6GOKuF9Vyxq4V+QsFhxzmhqM+FnBV1N4oXAkoe?=
 =?us-ascii?Q?kF6Piij/ef2HJvXVJUa80F5cD4Xl96torBvOL79e+WNQZV6V+QiufiZyBlM7?=
 =?us-ascii?Q?lAuK7JAvioycaKjB861I9tlCDjgiW6xZcfE/nawPaD2Yk9Gc9uBXOcOWQuAR?=
 =?us-ascii?Q?s7SJe+U6xP8s93L9trXlQfEvrxBcLcxS/d8jBsJl57fqtd8xZZwQPZBZ7oCK?=
 =?us-ascii?Q?1xvGr+Iea7yQXBgt+rHZWm10faZRyx2jfo8J40xT3DRGpV9CM0p1FYy7lKgB?=
 =?us-ascii?Q?NEc402SEG5blS8ySA/kfW57MhTep6m3/jmM9NTQCibpRyJUW4r4F7XGvFzrN?=
 =?us-ascii?Q?/yagKGHtAFQDA/VWObKv/yAXs3Jn3DEgkj8GUzAlujpU3L9FUnBsjieTuy9H?=
 =?us-ascii?Q?zQ7aY+Rv2aCuE4co98P84O610j3dmIRt8lFAKEviQP8YWZG0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8036cc36-9377-405e-eecc-08da1b9916e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 08:55:55.3860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwoyPl0eDVfajnJNV6SftOY3eknY1bKvlmhXaM6wqxeYVKYLcOsGeQ//95hs0wmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "arthur.marsh@internode.on.net" <arthur.marsh@internode.on.net>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please check the V2 version.

Thanks,
Evan
> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, April 11, 2022 3:59 PM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; arthur.marsh@internode.on.net;
> regressions@lists.linux.dev
> Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
>=20
> Dear Evan,
>=20
>=20
> It would have been nice, if you put me in Cc as I also reported the regre=
ssion.
>=20
> Am 11.04.22 um 09:47 schrieb Evan Quan:
> > By placing those unrelated code outside of adev->pm.mutex protections
> > or restructuring the call flow, we can eliminate the deadlock issue.
> > This comes with no real logics change.
>=20
> Please describe the deadlock issue and the fix in more detail. What code =
is
> unrelated, and why was it put into the mutex protections in the first pla=
ce?
>=20
> > Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
> > amdgpu_dpm.c")
>=20
> No blank line needed.
>=20
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: I75de4350d9c2517aba0d6adc12e1bc69430fd800
>=20
> Without the Gerrit instance URL, the Change-Id is useless.
>=20
> As it's a regression, please follow the documentation, and add the relate=
d
> tags.
>=20
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
> amdgpu_dpm.c")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2F9e689fea-6c69-f4b0-8dee-
> 32c4cf7d8f9c%40molgen.mpg.de&amp;data=3D04%7C01%7Cevan.quan%40am
> d.com%7C27d20f9b6ec445d34d1508da1b912981%7C3dd8961fe4884e608e11a
> 82d994e183d%7C0%7C0%7C637852608491368980%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000&amp;sdata=3DwtBav3WwrD17U53AArdnONjI0GBJjHI4OhxU0Z
> 4ymfA%3D&amp;reserved=3D0
> BugLink:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1957&amp;data=3D04%7C01%7Cevan.quan%40amd.com%7C27d
> 20f9b6ec445d34d1508da1b912981%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637852608491368980%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&amp;sdata=3DbbrWm5C03R1PcDAY%2FDWeEBnirLsXVgo%2BTTl2eIsJJdE%
> 3D&amp;reserved=3D0
>=20
> Also add the link from Arthur.
>=20
>=20
> Kind regards,
>=20
> Paul
>=20
>=20
> [1]:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flinux
> -
> regtracking.leemhuis.info%2Fregzbot%2Fmainline%2F&amp;data=3D04%7C01
> %7Cevan.quan%40amd.com%7C27d20f9b6ec445d34d1508da1b912981%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637852608491368980%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DRAjnkKPFbzmUp2w2aKz
> UlgBNtbxblqpTqMMZ86Fpx2A%3D&amp;reserved=3D0
>=20
> > ---
> >   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39
> +++++++++++++++++++
> >   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
> >   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
> >   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
> >   4 files changed, 39 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index 5504d81c77b7..72e7b5d40af6 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct
> amdgpu_device *adev, enum amd_pp_sensors senso
> >   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
> >   {
> >   	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> > +	int i;
>=20
> You could make it unsigned, as the variable never should be assigned
> negaitve values.
>=20
> >
> >   	if (!adev->pm.dpm_enabled)
> >   		return;
> > @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct
> amdgpu_device *adev)
> >   	if (!pp_funcs->pm_compute_clocks)
> >   		return;
> >
> > +	if (adev->mode_info.num_crtc)
> > +		amdgpu_display_bandwidth_update(adev);
> > +
> > +	for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> > +		struct amdgpu_ring *ring =3D adev->rings[i];
> > +		if (ring && ring->sched.ready)
> > +			amdgpu_fence_wait_empty(ring);
> > +	}
> > +
> >   	mutex_lock(&adev->pm.mutex);
> >   	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
> >   	mutex_unlock(&adev->pm.mutex);
> > @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct
> amdgpu_device *adev, bool enable)
> >   {
> >   	int ret =3D 0;
> >
> > +	if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
> > +		mutex_lock(&adev->pm.mutex);
> > +		if (enable) {
> > +			adev->pm.dpm.uvd_active =3D true;
> > +			adev->pm.dpm.state =3D
> POWER_STATE_TYPE_INTERNAL_UVD;
> > +		} else {
> > +			adev->pm.dpm.uvd_active =3D false;
> > +		}
> > +		mutex_unlock(&adev->pm.mutex);
> > +
> > +		amdgpu_dpm_compute_clocks(adev);
> > +		return;
> > +	}
> > +
> >   	ret =3D amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_UVD, !enable);
> >   	if (ret)
> >   		DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n", @@ -453,6
> +477,21 @@
> > void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
> >   {
> >   	int ret =3D 0;
> >
> > +	if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
> > +		mutex_lock(&adev->pm.mutex);
> > +		if (enable) {
> > +			adev->pm.dpm.vce_active =3D true;
> > +			/* XXX select vce level based on ring/task */
> > +			adev->pm.dpm.vce_level =3D
> AMD_VCE_LEVEL_AC_ALL;
> > +		} else {
> > +			adev->pm.dpm.vce_active =3D false;
> > +		}
> > +		mutex_unlock(&adev->pm.mutex);
> > +
> > +		amdgpu_dpm_compute_clocks(adev);
> > +		return;
> > +	}
> > +
> >   	ret =3D amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_VCE, !enable);
> >   	if (ret)
> >   		DRM_ERROR("Dpm %s vce failed, ret =3D %d. \n", diff --git
> > a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > index 9613c6181c17..d3fe149d8476 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > @@ -1028,16 +1028,6 @@ static int
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
> >   void amdgpu_legacy_dpm_compute_clocks(void *handle)
> >   {
> >   	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -	int i =3D 0;
> > -
> > -	if (adev->mode_info.num_crtc)
> > -		amdgpu_display_bandwidth_update(adev);
> > -
> > -	for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> > -		struct amdgpu_ring *ring =3D adev->rings[i];
> > -		if (ring && ring->sched.ready)
> > -			amdgpu_fence_wait_empty(ring);
> > -	}
> >
> >   	amdgpu_dpm_get_active_displays(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index caae54487f9c..633dab14f51c 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct
> amdgpu_device *adev)
> >   }
> >   #endif
> >
> > -static int si_set_powergating_by_smu(void *handle,
> > -				     uint32_t block_type,
> > -				     bool gate)
> > -{
> > -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -
> > -	switch (block_type) {
> > -	case AMD_IP_BLOCK_TYPE_UVD:
> > -		if (!gate) {
> > -			adev->pm.dpm.uvd_active =3D true;
> > -			adev->pm.dpm.state =3D
> POWER_STATE_TYPE_INTERNAL_UVD;
> > -		} else {
> > -			adev->pm.dpm.uvd_active =3D false;
> > -		}
> > -
> > -		amdgpu_legacy_dpm_compute_clocks(handle);
> > -		break;
> > -	case AMD_IP_BLOCK_TYPE_VCE:
> > -		if (!gate) {
> > -			adev->pm.dpm.vce_active =3D true;
> > -			/* XXX select vce level based on ring/task */
> > -			adev->pm.dpm.vce_level =3D
> AMD_VCE_LEVEL_AC_ALL;
> > -		} else {
> > -			adev->pm.dpm.vce_active =3D false;
> > -		}
> > -
> > -		amdgpu_legacy_dpm_compute_clocks(handle);
> > -		break;
> > -	default:
> > -		break;
> > -	}
> > -	return 0;
> > -}
> > -
> >   static int si_set_sw_state(struct amdgpu_device *adev)
> >   {
> >   	return (amdgpu_si_send_msg_to_smc(adev,
> PPSMC_MSG_SwitchToSwState) =3D=3D PPSMC_Result_OK) ?
> > @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs
> =3D {
> >   	.print_power_state =3D &si_dpm_print_power_state,
> >   	.debugfs_print_current_performance_level =3D
> &si_dpm_debugfs_print_current_performance_level,
> >   	.force_performance_level =3D &si_dpm_force_performance_level,
> > -	.set_powergating_by_smu =3D &si_set_powergating_by_smu,
> >   	.vblank_too_short =3D &si_dpm_vblank_too_short,
> >   	.set_fan_control_mode =3D &si_dpm_set_fan_control_mode,
> >   	.get_fan_control_mode =3D &si_dpm_get_fan_control_mode, diff --
> git
> > a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > index dbed72c1e0c6..1eb4e613b27a 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void
> *handle)
> >   {
> >   	struct pp_hwmgr *hwmgr =3D handle;
> >   	struct amdgpu_device *adev =3D hwmgr->adev;
> > -	int i =3D 0;
> > -
> > -	if (adev->mode_info.num_crtc)
> > -		amdgpu_display_bandwidth_update(adev);
> > -
> > -	for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> > -		struct amdgpu_ring *ring =3D adev->rings[i];
> > -		if (ring && ring->sched.ready)
> > -			amdgpu_fence_wait_empty(ring);
> > -	}
> >
> >   	if (!amdgpu_device_has_dc_support(adev)) {
> >   		amdgpu_dpm_get_active_displays(adev);
