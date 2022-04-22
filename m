Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 08:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1186A10FCF0;
	Fri, 22 Apr 2022 08:17:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDC610FD34
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 08:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVlOpAtftZBrY7U7IhZkV035ZEj/uzSdxnErSdjitsKkaTi+fQrjYRObcLZWoSgW99+MVQKwzDIvizcuoWwKwLCzuUOGxY1w74xOqIzQ2l95ZIIpJpwnNsC04S0ZO5ld7KCQ+tN6gJvT43+AWM6hdhWl26yGPp9l9aihzhY2+FTEeIAi+L7vAkZqTocMSt6KgETywl/A7sxlMSM08yo7Dn+VSnay1m54uQ0pxgAXevpl8QX+DorGvcr0439XQJrIAeixSo/bV4PkLzK/5yYezH1cUwOPWksSNbiytqGCSUPqhsdHR37bYsfHOZtL9ktxPDrxAVUQiRpXIP+KHBgYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0AmnoFlA2URmufafKUmvbEgL7NWw7hgzDr9bCBib5s=;
 b=WAgh8e41rMvq+zo7pojlOsdJR9ZRWDab70ix5PX+OlU7NAFRMszB61I3WamyY7DCPNvM7DbJ4lOYPdrIBqn93cWW++aFsr7fYq/S899z/uQBve5VGepq8fQwwboCrMEWakSxKRCibxjYGdUHkvSCya8Lkr1ditaAI23Qn9K98feyZSNnO6q05N8tdIJ8S4HGAi2UAQfFuOfJU0Rqo/tGyfHfcuVbbTGiO6j3VCca6eSOXwrZBoKkohqR55oS4kZNvaPUkfCteoCq8JR8nc1a1JibaQre1xc4jrVMsyQqOuTBwjn/XxhZzktVXhMo9fztrtWCinJWpqZGfHre8RXVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0AmnoFlA2URmufafKUmvbEgL7NWw7hgzDr9bCBib5s=;
 b=xEYOsUbmh8aR8SEq/8cIqsUPTHtKe92K2gv0PXstn7RJLPfYJHL8WQ89h1VWMLif94LtE/MKuFztDQc5oF22gPumwCfd9l12IwknCoHj6b4QsD2hjaXKhZdwv+q4mJRLcRYMS3v+62fLLLJSHKHbnKPmDgv5kJrDYzth0JBkkUQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 22 Apr 2022 08:16:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3%6]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 08:16:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Thread-Topic: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Thread-Index: AQHYTYHgfs1EKjpJg0KMdZLy10ULmaz6GLqAgAGOkQA=
Date: Fri, 22 Apr 2022 08:16:56 +0000
Message-ID: <DM6PR12MB26192947CF5E84F5588E9202E4F79@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220411085453.38063-1-evan.quan@amd.com>
 <44570dcb-edae-9a92-b5a8-cfe9da4e9b29@leemhuis.info>
In-Reply-To: <44570dcb-edae-9a92-b5a8-cfe9da4e9b29@leemhuis.info>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-22T08:16:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0d9280a6-e6b9-44e9-8f5c-053ecb353b9b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 721a8990-d907-48ff-0b33-08da243877ae
x-ms-traffictypediagnostic: SA0PR12MB4510:EE_
x-microsoft-antispam-prvs: <SA0PR12MB4510E768DCC3E2238A0DB844E4F79@SA0PR12MB4510.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5D/T3t7Ab2KkBD0Y/7QDp1Bh60Jf+yvxAQJXECedPyzz0t9qmt1OkKu3f+oa3VtLT+sO/B9Z7qJ4UOiHwUPMR1+qOR/mQB+6Bfj+ygqufPUdHtwSLNZ0M1if2U392vx+0FX93f6qYYKP+b5FapnZSlhUIujhzQ6Mn4NwEV5MvsPejBeOIq5onS+VIIbFI5cydMm03UTDc9+OB4rjv2HrHyMQqLXuOC4W90Nusz7T9TVKh/3F7tmUVD8FwYC1Wa+dsFqmUDd9a483q4HCKL589gpe1EkF6/mAN0Bg9Su6jBDUqdKjWV004KIhsSqCwvPpCv+c5aUgBjhpVavGyCXd9pkzv9pOqNXKMZS6vuvARaX/UIp3XUghjDYmuWaq6t81jd7QWgZvO/3UZ2vgaM4Jhyhuqqzd4GtSeHfEeaG66lZQFHDoJZZo0JGKbANumEeuiCYkG9e65fk+ZCAMsBTX6HNGPsIbe1Lo8dwoSBcNYYkERKWlzaY2TMwnhrbIXNxO813Q7xqQ7JtvU8zDT0zPjbfWF2y76+ZYePvR9rkYKTcfr+cDq7iCniaQEdNXuF0p5pg6f04dEdJkBGltzmAZCguali4pAghO0ut1MThV3PSc2/R2/qwPTRcf+h9OCQa7IiAiZsogYvvycuScaku1uCdaNZDkKK/ARXorMDkGmvTTx//vuHiD8Zym8vO4xdoZQbKjvSu6Q3bN3NFP4mvDNOgtBw+3s3Im5+25U9gKrMLaLq1t9adSJoqFSc74f/yhDHH1As+w8hKSvYSdVsqA0BSATEYcEzAZL707Pvwp+wkNkoTMAdrr8lLqzWzKFCS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(53546011)(9686003)(2906002)(7696005)(45080400002)(38100700002)(38070700005)(55016003)(6506007)(186003)(83380400001)(86362001)(33656002)(26005)(54906003)(110136005)(76116006)(8936002)(316002)(52536014)(71200400001)(966005)(4326008)(508600001)(66946007)(66446008)(66476007)(5660300002)(66556008)(8676002)(64756008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hg4rsxqJj7/LnuZ3VXSM4Um2l9YPRKkYGnuanb4bNd0SjnB1au7qwQhUFG60?=
 =?us-ascii?Q?fkn0oLXpSSkeYKUm51N1mb84zLzoLP2MgS02U9vzHLZESlKYWtpQ7RGjd7Qx?=
 =?us-ascii?Q?cDq1zvdIACygpJzRGuSlfU9TAyTOWqIKEh5JrM8UArJYkzFG29ZdbuYZiaeT?=
 =?us-ascii?Q?u+D8pfvcfn4U1OJrgRpJVaj0g0OdyzfGAJDjW5cDO4L46BJ6WeOVuLmRhZDH?=
 =?us-ascii?Q?ERRKB8EHsQq3VrHIV3JCH/8hdIY0kQG62D4WVKcY6c5+XMR1nxjzkcqIrSV7?=
 =?us-ascii?Q?bhv1bnPL73YCMxE7Lud553/P1X8rEGAJQXWvwFgPGsh3msJ5xd9sQN+hQXzb?=
 =?us-ascii?Q?fmlmi3b+3X6/TniF09sTGkXUyuL5zPG9tdrxVQwAg1cL/P5C7h3CDwiNuiwP?=
 =?us-ascii?Q?5Jj6MNXz0MQ1lXNnbjug39w7sgnEuVCQia/UbkfuyDpC4byl300vdHBPzutC?=
 =?us-ascii?Q?+z/vpI3kr0SGHzRdr5nAuwKFM7zMyvZvwdUZ638TqaDgTQjrR4gYqsgXWN2k?=
 =?us-ascii?Q?arPWKfgugZPjMIPAjofA7V0vHYaY0lxBu7frkiDvzm+h2u0ItqNVhiOzNhZs?=
 =?us-ascii?Q?/FfNB9mtj87eR/cPmJZQQLEGh6lewuYNjJUNdQoLfFJw3QfC2brGmLeIFEl1?=
 =?us-ascii?Q?Kpx4uGuFrnNviSjKEilrP2hbo/Ynf9ID98b3zvwdQY+XgrZEaDcTMLuhEKdM?=
 =?us-ascii?Q?CeJq+sgXbe1x8RwfXC1GO5pBKNyvrfFA/9ytJCtvllwiLMHEx7pOUz6A8xgI?=
 =?us-ascii?Q?xWtS0Bu8zP/HC0XUJBC4Izofqe3agW7pq89nJU+tcdL+BIliMK17JuRYLMgb?=
 =?us-ascii?Q?nHFCw3bsksWX0Hy2W/I38mSiqHCXuOWwcHuemWwyC0u4PO3Gpg1UD9odWtZD?=
 =?us-ascii?Q?9ub9NzJMv5S7F6qjYCTtlgbYszIjS9VNTUheCTffIedaosSSYERb8mGjoKs6?=
 =?us-ascii?Q?aq+Fu2i2TEMTEAE3YOKeGN2QT+8IwwMFdXzV10re5p1rUK0jS61HYp+2stFT?=
 =?us-ascii?Q?R8+WovObYMPcOGW2b3VVLylrVOCNvC8KuBZVsXnxM5e9PVEBrAm2QIiF3Dbj?=
 =?us-ascii?Q?9qWHndNkH3JteMz9sVOyK0LYRsclDczSboioPSD9wuYalxHMWzDEakTYL3as?=
 =?us-ascii?Q?7I92+5ibhyE6+Cx0SVs2vbjqljbclWKilWial9o4vZB9CghtTxV4TlkDbPsb?=
 =?us-ascii?Q?O3fVILxT6v/08WZtGxQADDPty+DUUmbsHGprAT5vLaAamuk0W5uTsvaOPcNt?=
 =?us-ascii?Q?TqshDxS/Mzg/BDPm2TteBQi/aFKPmDbAhKYkUN0hHXwrlnsT78kaH7k4S56g?=
 =?us-ascii?Q?WsmbwMWADLMwuMjoS2TZLaEQXrxaLVHuSyGorXCx7U3EOdtkP22BnL9nVZ58?=
 =?us-ascii?Q?HW93maXsQPVCIzKy1hvOt6cnPvnNzJZ5+M/8Z5YQqFht1O+h5nSlAi5i8C/G?=
 =?us-ascii?Q?vB23S9korwQ3BNqswiHeevgjXt4ltIhw8YybEeATLAwwGoJJcNgp+DJiAhKT?=
 =?us-ascii?Q?os1SbUCRPcJgOqqytdAA/DJOMUeD8501lNzYXJ8OwFK4+p9iq/hodHjwKtYB?=
 =?us-ascii?Q?pVoPYIX8Dpk4rfqbHOSxklHwYo32KqPXnqbDLGfFI9BFSssuWEor+AnSOuXw?=
 =?us-ascii?Q?f+kT7c96KkXlslw8GW417xA+PLIqQW+ln40bHT4OEfYdpAuwagb+I0nPi3UE?=
 =?us-ascii?Q?gKcW3IhgAjSoNAVj+ThlogFcIByrU5fq2+VmduJRpzhjDDC5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721a8990-d907-48ff-0b33-08da243877ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 08:16:57.0541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7Rh3KJ2mCf+dexe5N9Gm8rG/IuZIUDvMZVexYz0diS4UbOi2YSkansvnzrk1Zx8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
 "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
 "arthur.marsh@internode.on.net" <arthur.marsh@internode.on.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Thorsten Leemhuis <regressions@leemhuis.info>
> Sent: Thursday, April 21, 2022 4:29 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> pmenzel@molgen.mpg.de; arthur.marsh@internode.on.net
> Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
>=20
> On 11.04.22 10:54, Evan Quan wrote:
> > The adev->pm.mutx is already held at the beginning of
> >
> amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_
> enable_vce.
> > But on their calling path, amdgpu_display_bandwidth_update will be
> > called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They
> > will then try to acquire the same adev->pm.mutex and deadlock will
> > occur.
> >
> > By placing amdgpu_display_bandwidth_update outside of adev-
> >pm.mutex
> > protection(considering logically they do not need such protection) and
> > restructuring the call flow accordingly, we can eliminate the deadlock
> > issue. This comes with no real logics change.
> >
> > Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
> amdgpu_dpm.c")
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> > Link: https: //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-
> 32c4cf7d8f9c@molgen.mpg.de/
> > BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957
>=20
> Side note: two spaces sneaked in there. But that's not why I write this
> mail.
[Quan, Evan] Thanks! Will fix that.
>=20
> This patch is fixing a regression in 5.18-rc, but it looks like things
> are stuck for more than a week now. What's up there? Or was progress
> made somewhere and I just couldn't find it? Was the review comment from
> Lijo addressed?
[Quan, Evan] Sorry, was busy with other stuffs. Let me check.

BR
Evan
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
>=20
> #regzbot ignore-activity
> #regzbot ^backmonitor:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F9e689fea-6c69-f4b0-8dee-
> 32c4cf7d8f9c%40molgen.mpg.de%2F&amp;data=3D05%7C01%7Cevan.quan%4
> 0amd.com%7Cf8885e7025e9445db6e508da23710586%7C3dd8961fe4884e608
> e11a82d994e183d%7C0%7C0%7C637861265579473039%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D47%2FiLxh3iw9jN%2B0KiUfcO
> 79u7kpjaNKkueZE%2BMEDtl8%3D&amp;reserved=3D0
>=20
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > --
> > v1->v2:
> >   - rich the commit messages(Paul)
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39
> +++++++++++++++++++
> >  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
> >  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
> >  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
> >  4 files changed, 39 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index 5504d81c77b7..72e7b5d40af6 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct
> amdgpu_device *adev, enum amd_pp_sensors senso
> >  void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
> >  {
> >  	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> > +	int i;
> >
> >  	if (!adev->pm.dpm_enabled)
> >  		return;
> > @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct
> amdgpu_device *adev)
> >  	if (!pp_funcs->pm_compute_clocks)
> >  		return;
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
> >  	mutex_lock(&adev->pm.mutex);
> >  	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
> >  	mutex_unlock(&adev->pm.mutex);
> > @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct
> amdgpu_device *adev, bool enable)
> >  {
> >  	int ret =3D 0;
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
> >  	ret =3D amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_UVD, !enable);
> >  	if (ret)
> >  		DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
> > @@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct
> amdgpu_device *adev, bool enable)
> >  {
> >  	int ret =3D 0;
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
> >  	ret =3D amdgpu_dpm_set_powergating_by_smu(adev,
> AMD_IP_BLOCK_TYPE_VCE, !enable);
> >  	if (ret)
> >  		DRM_ERROR("Dpm %s vce failed, ret =3D %d. \n",
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > index 9613c6181c17..d3fe149d8476 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> > @@ -1028,16 +1028,6 @@ static int
> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
> >  void amdgpu_legacy_dpm_compute_clocks(void *handle)
> >  {
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
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
> >  	amdgpu_dpm_get_active_displays(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > index caae54487f9c..633dab14f51c 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct
> amdgpu_device *adev)
> >  }
> >  #endif
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
> >  static int si_set_sw_state(struct amdgpu_device *adev)
> >  {
> >  	return (amdgpu_si_send_msg_to_smc(adev,
> PPSMC_MSG_SwitchToSwState) =3D=3D PPSMC_Result_OK) ?
> > @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs
> =3D {
> >  	.print_power_state =3D &si_dpm_print_power_state,
> >  	.debugfs_print_current_performance_level =3D
> &si_dpm_debugfs_print_current_performance_level,
> >  	.force_performance_level =3D &si_dpm_force_performance_level,
> > -	.set_powergating_by_smu =3D &si_set_powergating_by_smu,
> >  	.vblank_too_short =3D &si_dpm_vblank_too_short,
> >  	.set_fan_control_mode =3D &si_dpm_set_fan_control_mode,
> >  	.get_fan_control_mode =3D &si_dpm_get_fan_control_mode,
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > index dbed72c1e0c6..1eb4e613b27a 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> > @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void
> *handle)
> >  {
> >  	struct pp_hwmgr *hwmgr =3D handle;
> >  	struct amdgpu_device *adev =3D hwmgr->adev;
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
> >  	if (!amdgpu_device_has_dc_support(adev)) {
> >  		amdgpu_dpm_get_active_displays(adev);
