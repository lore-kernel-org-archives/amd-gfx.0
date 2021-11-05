Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E2DC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 08:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04C361076
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 08:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F04C361076
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0766E123;
	Fri,  5 Nov 2021 08:05:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF696E123
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 08:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G26WQw0C2ZtJOxsrTbaLt/03dV0/ViWWOJvNjp/FAB079kFLy3P6jIpcaq+1Aoan9MeB+WqEa+WdUq4HjWSM4GfnWUD16eXzmLhLs76aQfRsr4bJQsBH0mBwI0HJljMK9Ep3rGJefgiSFHGTtjuIDODBm93QJ+6qyl3/iyH0CBJHfHHPvC1D9amBuElU7DwYqO9ApnHbUNvOo2BJbQJSLhf8tqTL0TjQVrxLobpKHp+U3BKjcs4TSvUPcbNWzlfteydys7hww8hn5Tg6vCwjo023uG9Ntl5tD/C+2hF7meRNVsBXyf9HEITDAfH5/VKjpxY4EA77x1pP4OrwqPPCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ55KQ9s/HLfOv9AHHoFmLEtjmmWQJFDfDO0yzJE5wI=;
 b=JSNmhpYpqnryejKQfZNo4q/7x0i7TWtmmxwFixSSiCcjx6M2O3rwCkA2mxlMYmqholRStzhLE1s/RPFr6nzjNsWJAhmL4ge+JWEKPd/zHvv87TVXlPBmoIe5ktF2VNiXwj4pBK7hJ3Ktfg8cF2DzkQunPVZaOrgKZxQfT8mGTdQMbfInmMnOBH04SoXwyEI5hrfuEOOq40NwQGW1QIyHGRV1DTKI/RbZVaBdGa5veNXvqS5pJnHPOuohGpp3IUhdUcIqrlK2sZxuVEq9aMKd6LAlbjvpP6nM+0IDQLgxD82mcegxSgFyf5KkZo2Zmbb1omHv4YWCX6YoWNiDJ9xjdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ55KQ9s/HLfOv9AHHoFmLEtjmmWQJFDfDO0yzJE5wI=;
 b=NXzCXV5xbjYJsSjQRFOWD37tCBINmZaMHmAlShCjATs2xrUPkwThf4CBrg9y146wFwvW0CcddAOpillHbH4b34xq7cMrsrbhi2i009g9zMfRjuxbdknZ9pVHbQcIIgniZJsp3X8mfhkGitQo5UDx27d6/MgZWtYA/LGYPp75ZXI=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4777.namprd12.prod.outlook.com (2603:10b6:5:16f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Fri, 5 Nov 2021 08:05:42 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4649.020; Fri, 5 Nov 2021
 08:05:42 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Borislav Petkov <bp@alien8.de>
Subject: RE: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Topic: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrCAAIEAAIAADb7AgAAExgCAAv/N0IAAmpGAgAKexJCAAASygIABFY9AgAB1n4CAAZf1QIAg6e3w
Date: Fri, 5 Nov 2021 08:05:41 +0000
Message-ID: <DM6PR12MB26191DEE9CEF9A1E49E62634E48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YWBlVzZK35ecQHNZ@zn.tnic>
 <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFaUjKEp+5819O/@zn.tnic>
 <DM6PR12MB26195857D2FA0946C9833F19E4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWFp2qHwbWHEqxWh@zn.tnic>
 <DM6PR12MB26193B59E0C5971F458E17C9E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWRvl6ymevr7+kiB@zn.tnic>
 <BYAPR12MB26152EF8CD43290EBE40C165E4B79@BYAPR12MB2615.namprd12.prod.outlook.com>
 <YWamNaMAxaw+/9Az@zn.tnic>
 <DM6PR12MB26199D9E4AD854A4DCF562B4E4B89@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YWfxtUusQ5w/1agx@zn.tnic>
 <DM6PR12MB26197151C642B89A9C824AA0E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197151C642B89A9C824AA0E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-05T08:05:39Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=11c4db7d-33ed-4051-b6f3-c9d3b6979e70;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56b40a39-2f54-4029-c8b5-08d9a0330fe4
x-ms-traffictypediagnostic: DM6PR12MB4777:
x-microsoft-antispam-prvs: <DM6PR12MB477759B51EBFE0A467AF756CE48E9@DM6PR12MB4777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdMre59yg7O4SpSfItoGipsUBoUhnn3aoBrexiJiT3f2Fn5IBAJHiNgjwGf4iSdfF82x4XfFIZOXhWIDMxFzl2GgGwCE/SYEZdGRCa8O8VDMkeuqrswzl6rLhiFxi/y9X8R0cO+QqExRZdMfk4AesnIKWN6O0SVpQfY2q4fQ9+1Ggr4J45W5RJL7i+NIJpPT4Chdluss+KyYIun7egl5cX4uKnN9mLBT6F7RkMFL3BnTC/d2CG+xJTvo6vx49LBXTmhTCzrULF6rBQI9Lb8yDs7CkGephLamQ8Bq9mnRGh9iCfG5/agbuz+52NVKeX++n/I1A3occa2Dsw57ORAYfPyIz5vwVydMJu/p4Rsv7/i85PvwhcBchXN65RfPAXrTle+MiqRfX55lwSgeJIA4WNV7HgT7SOqV19PT0aLmIR+BJmagOCMFmmPy4aiQ5FP7GwAuvQ9HnrX59Nb9g22KQtvFt40KwDbFAszPuaEum/CVIu1DSwtDZjcc7vyLkfIBmVXOzLCuIZA8U1bTdSoDFleDvkdJKiRBm4BLpfoBHk/2X7gQqC/Mo337BDLguJDJw3k8hwjn9Jo+QyEcEaqyRca2PAx6a9nP4RrzLnxxPyI9LCBWWHPC6np/RcE+GMDcuQLARC+54I+GvDVDIIvgIb6iuWuIdxs6AH5h2WrvLEpDDggzSa/52KrSoaxL8k7SMQcbKmRV1nWY7gOhftnOCJ7qvKj0k24PI5KMkwB5PxzWdxaolO416vQstVUaL6YGksVVonl1jXrjXInb6tU65mHoJQXWf6kuoae9P8w1egM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(99936003)(186003)(15650500001)(6506007)(26005)(66556008)(66946007)(53546011)(86362001)(64756008)(2906002)(5660300002)(76116006)(66476007)(33656002)(71200400001)(122000001)(4326008)(7696005)(6916009)(508600001)(8936002)(9686003)(55016002)(54906003)(66446008)(38070700005)(52536014)(966005)(45080400002)(8676002)(83380400001)(316002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B+BOoPj/HlDEts3czCePBP2Pg2BbzqFtCGht3MqNmQLTfDoIdoF4fIzoK/nu?=
 =?us-ascii?Q?YIyQKmjMOZv55hHnt+V6pTXDmGPES14u2sHJGiGfQVPPq7/gDmz+qsvjQH3S?=
 =?us-ascii?Q?YlmTXV3lwPp30nLOgymwDlsBASqwzw5muQrjrXhOhwR9Rx+Kr87fQCw0yjEC?=
 =?us-ascii?Q?5wVCeSYWWPYMIYdYmfab1iJSSOEOaXbUfZl/s2cKPPZLfw6fRj0ayqr7i1i+?=
 =?us-ascii?Q?S7kJhD5MWboWh5+28FhND6LFqDLZznk0H6rGJE44dp2l0WK+MuwxkfEXS0eF?=
 =?us-ascii?Q?xN1yR/wEj+Lm8dsaq2Ql2A5+CmvHS+EM0i/QembgNZsCzmLRs870oMMwYHAL?=
 =?us-ascii?Q?n7ecUjOZu+/aZBJMCKrDDsCox9hU3jW/ADHeaA6u1tNK93mHz+RwwcSqYXpp?=
 =?us-ascii?Q?sH9iibI6JuutX7PHpCj0DPvmadHRxfVOlRHOn3EvvFIz5QIqxdOJcjcpfyeW?=
 =?us-ascii?Q?NnCerTgm5Pua5mw0dlCPQd8ORpbXBOCLeMMVg34f8Qutu1K72P9DHL10z9sF?=
 =?us-ascii?Q?ZPya1Rp9JCZcSIXB/sPRZ2UFmHvQSVfY2Rp/F6N88jtbFpkdu5noMJGFNWZC?=
 =?us-ascii?Q?Mg/EPNCGRrAd5HxXD/Ceg4nB/9GuoBXHsIwoZaPFAat7D8yEjmXKhC3YCAsU?=
 =?us-ascii?Q?kvo8kcehMeEGJpjUaZp9ue08Cp4Nm2opEkG1CDTcuaHDi2kolKKwZvLq/8Tf?=
 =?us-ascii?Q?tq01fJ5axJDwiMyqKQ993W8SESS94BklaGSdBB2blJwtvHEHYHu0WYa9rno1?=
 =?us-ascii?Q?5UvybHqioT3CA95KNpcQDYWe79Sh5scN+0Xvjr6cPAIWv29cp86Tk88EwEc5?=
 =?us-ascii?Q?BvntmaouLWoerZPHr2Z1BLfJoYif+BT82HOTW2+doKMYpBj+pUHUaml5Umi2?=
 =?us-ascii?Q?50c0a4sBda5l0m4Wcf526NEYoGeocsukpt2N9ig3lnVpiC1MYUk9mrqGbqix?=
 =?us-ascii?Q?ICrXFxd+upQPtDVhCETADzXq3vrKf2Fxg4leLPF/DRjY5G2h2WvNbJc+1WrW?=
 =?us-ascii?Q?aFCHu6rmbk4x5wcKu3SBt0oREECFq4s8jNZdjo0Y+BBBFeB3uFlFH6y7CX0r?=
 =?us-ascii?Q?F40VxXeERTFnsGpN9xsCzYshVOUxSRYEMIsGiI328IpbNj+nq4lSjWpQz5HD?=
 =?us-ascii?Q?nQSsSszzIIbb3s9BpYxqkfAW68fOFzlQzXv80kfFLkrwWvwIaVD3A8vezzzR?=
 =?us-ascii?Q?c52MPErS5k5e/8An7KTqWXwVG+UeQqM+L5b6FhCkJpQab3SiwLuM7xb9uztb?=
 =?us-ascii?Q?2aCf87Wy1PL2rvSyV46pQpzHapS42LO1OjYO7Qaz3AEna0COQg2JbFYPVjmQ?=
 =?us-ascii?Q?WcJm4FufVxSaeDENTbRlK1K6ejwJntCPrBuO2y/KV5Dtr+v68CZBMLVsyzYb?=
 =?us-ascii?Q?4iLmKqN4ea+TuNUTFGpTUxN98NAjP1QGecpHfnMKVtbk3RKHratmDvjSThYC?=
 =?us-ascii?Q?80XMbKu41Z8IOrC54Zr3ddSy4jERnNagR8FBZwK6ujPdZPVuX9s7kQfYVy+r?=
 =?us-ascii?Q?pVaqI4KJUmJDvPM/bQHYablNwdP5Qhu8utSuGpmu9rtxr2QiVQLrfzwV+PZN?=
 =?us-ascii?Q?uVCHJyXmS2ic4a6i0Vg=3D?=
Content-Type: multipart/mixed;
 boundary="_002_DM6PR12MB26191DEE9CEF9A1E49E62634E48E9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b40a39-2f54-4029-c8b5-08d9a0330fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 08:05:41.7945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuyJl5kj8hYZafPude54bokF4ofUHoxP8JEaiOinbQzt4caL6yPVuZxGJwK12sDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4777
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM6PR12MB26191DEE9CEF9A1E49E62634E48E9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Boris,

We are finalizing the solution for the issue here.
I'm wondering are you able to give the attached patch(alone) a try.
Since that might give us a different approach(more reasonable) to get the i=
ssue fixed.

BR
Evan

> -----Original Message-----
> From: Quan, Evan
> Sent: Friday, October 15, 2021 5:25 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: RE: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> [AMD Official Use Only]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Borislav Petkov <bp@alien8.de>
> > Sent: Thursday, October 14, 2021 5:01 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Alex Deucher <alexdeucher@gmail.com>; amd-gfx list <amd-
> > gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> > <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for
> > Polaris12 UVD/VCE on suspend")
> >
> > On Thu, Oct 14, 2021 at 02:02:48AM +0000, Quan, Evan wrote:
> > > [Quan, Evan] Yes, but not(apply them) at the same time. One by one
> > > as
> > you did before.
> > > - try the patch1 first
> >
> > Ok, first patch worked fine.
> >
> > > - undo the changes of patch1 and try patch2
> >
> > Did that, worked fine too except after the first resume cycle, the
> > video didn't continue playing.
> >
> > Then I restarted the video and did a couple more suspend cycles to see
> > if it would not continue again. In the subsequent tries it would
> > resume fine and the video would continue playing too.
> >
> > So I'm going to chalk that single case of halted video with the second
> > patch to a resume glitch or so.
> >
> > Btw, I don't have pm-suspend on that box but I did suspend to RAM
> > assuming this is what you wanted, which is done as root with two
> > commands:
> >
> > # echo "suspend" > /sys/power/disk
> > # echo "mem" > /sys/power/state
> [Quan, Evan] Yes, that also works.
> >
> > If you want me to do more extensive testing, just shoot.
> [Quan, Evan] Thanks! That's enough for now. I will prepare an official so=
lution
> for the issue.
>=20
> BR
> Evan
> >
> > HTH.
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> > ple.kernel.org%2Ftglx%2Fnotes-about-
> >
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C08df3d5453
> >
> d64ad40dfa08d98ef119ec%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> >
> 0%7C637697988457790715%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> >
> sdata=3DzmFVlmUBv6byoDYyUhSgk9J9Zmvexz5IqG7xBxwiR3M%3D&amp;rese
> > rved=3D0

--_002_DM6PR12MB26191DEE9CEF9A1E49E62634E48E9DM6PR12MB2619namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-pm-avoid-duplicate-powergate-ungate-setting.patch"
Content-Description:  0001-drm-amd-pm-avoid-duplicate-powergate-ungate-setting.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-pm-avoid-duplicate-powergate-ungate-setting.patch";
	size=5932; creation-date="Fri, 05 Nov 2021 07:56:20 GMT";
	modification-date="Fri, 05 Nov 2021 07:56:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNTFjZTYwMjU0YmMyNGM4MmFiZDFhY2MzNmQwZmU4Y2YzNzBhMDQ0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpEYXRlOiBG
cmksIDUgTm92IDIwMjEgMTU6MjU6MzAgKzA4MDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bt
OiBhdm9pZCBkdXBsaWNhdGUgcG93ZXJnYXRlL3VuZ2F0ZSBzZXR0aW5nCgpKdXN0IGJhaWwgb3V0
IGlmIHRoZSB0YXJnZXQgSVAgYmxvY2sgaXMgYWxyZWFkeSBpbiB0aGUgZGVzaXJlZApwb3dlcmdh
dGUvdW5nYXRlIHN0YXRlLiBUaGlzIGNhbiBhdm9pZCBzb21lIGR1cGxpY2F0ZSBzZXR0aW5ncwp3
aGljaCBzb21ldGltZSBtYXkgY2F1c2UgdW5leHBlY3RlZCBpc3N1ZXMuCgpTaWduZWQtb2ZmLWJ5
OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDaGFuZ2UtSWQ6IEk2NjM0NmM2OWYxMjFk
ZjBmNWVlMjAxODI0NTEzMTNhZTRmZGEyZDA0Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1LmggICAgICAgICAgICAgIHwgIDcgKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCAgICAgICAgIHwgIDMgKystCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2FtZGdwdV9kcG0uYyAgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKystCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgfCAgMyArKysKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2t2X2RwbS5jICAgICAgICB8ICAzICsrKwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvc2lfZHBtLmMgICAgICAgIHwgIDMgKysr
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyAgICAgICAgfCAgMyAr
KysKIDcgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCmluZGV4IGI4NWI2N2E4OGEzZC4uMTlmYTIxYWQ4
YTQ0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAorKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaApAQCAtNzY3LDkgKzc2NywxNiBA
QCBlbnVtIGFtZF9od19pcF9ibG9ja190eXBlIHsKICNkZWZpbmUgSFdfSURfTUFYCQkzMDAKICNk
ZWZpbmUgSVBfVkVSU0lPTihtaiwgbW4sIHJ2KSAoKChtaikgPDwgMTYpIHwgKChtbikgPDwgOCkg
fCAocnYpKQogCitlbnVtIGFtZF9pcF9wb3dlcmdhdGVfc3RhdGUgeworCVBPV0VSR0FURV9TVEFU
RV9JTklUSUFMLAorCVBPV0VSR0FURV9TVEFURV9HQVRFLAorCVBPV0VSR0FURV9TVEFURV9VTkdB
VEUsCit9OworCiBzdHJ1Y3QgYW1kX3Bvd2VycGxheSB7CiAJdm9pZCAqcHBfaGFuZGxlOwogCWNv
bnN0IHN0cnVjdCBhbWRfcG1fZnVuY3MgKnBwX2Z1bmNzOworCWF0b21pY190IHBnX3N0YXRlW0FN
RF9JUF9CTE9DS19UWVBFX05VTV07CiB9OwogCiAvKiBwb2xhcmlzMTAga2lja2VycyAqLwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKaW5kZXggZjFhNDZkMTZmN2VhLi40
YjllNjhhNzlmMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRf
c2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaApA
QCAtOTgsNyArOTgsOCBAQCBlbnVtIGFtZF9pcF9ibG9ja190eXBlIHsKIAlBTURfSVBfQkxPQ0tf
VFlQRV9BQ1AsCiAJQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAogCUFNRF9JUF9CTE9DS19UWVBFX01F
UywKLQlBTURfSVBfQkxPQ0tfVFlQRV9KUEVHCisJQU1EX0lQX0JMT0NLX1RZUEVfSlBFRywKKwlB
TURfSVBfQkxPQ0tfVFlQRV9OVU0sCiB9OwogCiBlbnVtIGFtZF9jbG9ja2dhdGluZ19zdGF0ZSB7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jCmluZGV4IDAzNTgxZDViMTgzNi4uYTZiMzM3
YjZmNGE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYwpAQCAtOTI3LDYgKzkyNywx
NCBAQCBpbnQgYW1kZ3B1X2RwbV9zZXRfcG93ZXJnYXRpbmdfYnlfc211KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LCB1aW50MzJfdCBibG9jawogewogCWludCByZXQgPSAwOwogCWNvbnN0IHN0
cnVjdCBhbWRfcG1fZnVuY3MgKnBwX2Z1bmNzID0gYWRldi0+cG93ZXJwbGF5LnBwX2Z1bmNzOwor
CWVudW0gYW1kX2lwX3Bvd2VyZ2F0ZV9zdGF0ZSBwZ19zdGF0ZSA9CisJCWdhdGUgPyBQT1dFUkdB
VEVfU1RBVEVfR0FURSA6IFBPV0VSR0FURV9TVEFURV9VTkdBVEU7CisKKwlpZiAoYXRvbWljX3Jl
YWQoJmFkZXYtPnBvd2VycGxheS5wZ19zdGF0ZVtibG9ja190eXBlXSkgPT0gcGdfc3RhdGUpIHsK
KwkJZGV2X2RiZyhhZGV2LT5kZXYsICJJUCBibG9jayVkIGFscmVhZHkgaW4gdGhlIHRhcmdldCAl
cyBzdGF0ZSEiLAorCQkJCWJsb2NrX3R5cGUsIGdhdGUgPyAiZ2F0ZSIgOiAidW5nYXRlIik7CisJ
CXJldHVybiAwOworCX0KIAogCXN3aXRjaCAoYmxvY2tfdHlwZSkgewogCWNhc2UgQU1EX0lQX0JM
T0NLX1RZUEVfVVZEOgpAQCAtOTc2LDkgKzk4NCwxMiBAQCBpbnQgYW1kZ3B1X2RwbV9zZXRfcG93
ZXJnYXRpbmdfYnlfc211KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1aW50MzJfdCBibG9j
awogCQl9CiAJCWJyZWFrOwogCWRlZmF1bHQ6Ci0JCWJyZWFrOworCQlyZXR1cm4gLUVJTlZBTDsK
IAl9CiAKKwlpZiAoIXJldCkKKwkJYXRvbWljX3NldCgmYWRldi0+cG93ZXJwbGF5LnBnX3N0YXRl
W2Jsb2NrX3R5cGVdLCBwZ19zdGF0ZSk7CisKIAlyZXR1cm4gcmV0OwogfQogCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93ZXJwbGF5LmMKaW5kZXggYmJhNzQ3
OWY2MjY1Li44ZDhhN2NmNjE1ZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2FtZF9wb3dlcnBsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9hbWRfcG93ZXJwbGF5LmMKQEAgLTM4LDYgKzM4LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRfcG1fZnVuY3MgcHBfZHBtX2Z1bmNzOwogc3RhdGljIGludCBhbWRfcG93ZXJwbGF5
X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyOworCWludCBpOwogCiAJaWYgKGFkZXYgPT0gTlVMTCkKIAkJcmV0dXJuIC1FSU5WQUw7
CkBAIC01Nyw2ICs1OCw4IEBAIHN0YXRpYyBpbnQgYW1kX3Bvd2VycGxheV9jcmVhdGUoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaHdtZ3ItPmRpc3BsYXlfY29uZmlnID0gJmFkZXYtPnBt
LnBtX2Rpc3BsYXlfY2ZnOwogCWFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUgPSBod21ncjsKIAlh
ZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MgPSAmcHBfZHBtX2Z1bmNzOworCWZvciAoaSA9IDA7IGkg
PCBBTURfSVBfQkxPQ0tfVFlQRV9OVU07IGkrKykKKwkJYXRvbWljX3NldCgmYWRldi0+cG93ZXJw
bGF5LnBnX3N0YXRlW2ldLCBQT1dFUkdBVEVfU1RBVEVfSU5JVElBTCk7CiAJcmV0dXJuIDA7CiB9
CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2t2X2RwbS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBtLmMKaW5kZXggYmNhZTQy
Y2VmMzc0Li5mODRmNTY1NTJmZDAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2t2X2RwbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5
L2t2X2RwbS5jCkBAIC0yOTY1LDkgKzI5NjUsMTIgQEAgc3RhdGljIGludCBrdl9kcG1fZ2V0X3Rl
bXAodm9pZCAqaGFuZGxlKQogc3RhdGljIGludCBrdl9kcG1fZWFybHlfaW5pdCh2b2lkICpoYW5k
bGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKiloYW5kbGU7CisJaW50IGk7CiAKIAlhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MgPSAma3Zf
ZHBtX2Z1bmNzOwogCWFkZXYtPnBvd2VycGxheS5wcF9oYW5kbGUgPSBhZGV2OworCWZvciAoaSA9
IDA7IGkgPCBBTURfSVBfQkxPQ0tfVFlQRV9OVU07IGkrKykKKwkJYXRvbWljX3NldCgmYWRldi0+
cG93ZXJwbGF5LnBnX3N0YXRlW2ldLCBQT1dFUkdBVEVfU1RBVEVfSU5JVElBTCk7CiAJa3ZfZHBt
X3NldF9pcnFfZnVuY3MoYWRldik7CiAKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NpX2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9wb3dlcnBsYXkvc2lfZHBtLmMKaW5kZXggODFmODJhYTA1ZWMyLi5mMWViMjJjOWJiNTkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NpX2RwbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L3NpX2RwbS5jCkBAIC03OTE2LDkgKzc5
MTYsMTIgQEAgc3RhdGljIGludCBzaV9kcG1fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiB7CiAK
IAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhh
bmRsZTsKKwlpbnQgaTsKIAogCWFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyA9ICZzaV9kcG1fZnVu
Y3M7CiAJYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZSA9IGFkZXY7CisJZm9yIChpID0gMDsgaSA8
IEFNRF9JUF9CTE9DS19UWVBFX05VTTsgaSsrKQorCQlhdG9taWNfc2V0KCZhZGV2LT5wb3dlcnBs
YXkucGdfc3RhdGVbaV0sIFBPV0VSR0FURV9TVEFURV9JTklUSUFMKTsKIAlzaV9kcG1fc2V0X2ly
cV9mdW5jcyhhZGV2KTsKIAlyZXR1cm4gMDsKIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9hbWRncHVfc211LmMKaW5kZXggMDExNjhiODk1NWJmLi5mZGMyNWJhZTgyMzcgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCkBAIC02MjcsNiArNjI3LDcgQEAg
c3RhdGljIGludCBzbXVfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAJc3RydWN0
IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211OworCWludCBpOwogCiAJc211LT5hZGV2ID0g
YWRldjsKIAlzbXUtPnBtX2VuYWJsZWQgPSAhIWFtZGdwdV9kcG07CkBAIC02MzksNiArNjQwLDgg
QEAgc3RhdGljIGludCBzbXVfZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlhZGV2LT5wb3dl
cnBsYXkucHBfaGFuZGxlID0gc211OwogCWFkZXYtPnBvd2VycGxheS5wcF9mdW5jcyA9ICZzd3Nt
dV9wbV9mdW5jczsKKwlmb3IgKGkgPSAwOyBpIDwgQU1EX0lQX0JMT0NLX1RZUEVfTlVNOyBpKysp
CisJCWF0b21pY19zZXQoJmFkZXYtPnBvd2VycGxheS5wZ19zdGF0ZVtpXSwgUE9XRVJHQVRFX1NU
QVRFX0lOSVRJQUwpOwogCiAJcmV0dXJuIHNtdV9zZXRfZnVuY3MoYWRldik7CiB9Ci0tIAoyLjI5
LjAKCg==

--_002_DM6PR12MB26191DEE9CEF9A1E49E62634E48E9DM6PR12MB2619namp_--
