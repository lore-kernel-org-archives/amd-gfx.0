Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC93C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 02:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A9E61029
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 02:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2A9E61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6868C6EB2E;
	Fri, 17 Sep 2021 02:58:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE246EB2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 02:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXNVZuvM/XqgMSzSXTp6lCen2wXJ2X0lXiXsOE13xbHOORcd+7/UWnw9Z/ls+DJ5KOA/iFnoChhQfLPYBE0O6o+qNqhrCWOraA6VB3KDSXm7vs6PVtJoOsFI1rLFBHTp4XuZ5GwD4T16sdx9UAzRx9wUAHd0M6SIiFnA7BtvLCV6TM5TdsJdIlRDhFjcQJvwXICVZKV9HjwzcwTNw0fkoo8VRTqayzZpde39qM0Wyzr7D6trtePUuEgFv6c5M/oGZtz0LaKWz5m8geLcOb6stHIYhKsSQ/U1SvJT08LYZNP55twC9IwQ+ZUHq6RaF1MKjaRusp+hcY8vBSYmcDvA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DTGMzQUOD2OJNskstipaPyUtos4CtPyQ43pzEC2sEhA=;
 b=AQVhGry9oJ3XYV//41rz09QneFMJSZ4CGs+u4FN3wb96HbVFTZ3c6h7X/ByU1auBgi3TwV1tbhlQL8E52jKPLk6FTaDUEIR2pKBxb0cHOcuamxFoWOSpe04EBiSWuWTVmu/dX8hzIfHPCAisorh4R7Vo5obO1Pp51gA7I1HaYEbE13ooBQdx6ai+5vnrH23Jtg6gT7nG9QAcUGHyxtLF9HXKakkscRHJWLt3ZVQdh/RwtMkp6cAsfo5ly9H4e856aIcaBn3UnFjbrzUtzzokTRp2zSYQ7Jwk0Dh4hcOB8g1Co41AN6TWzL80E7LnnmNiGzHywWshVDWzMQlKB7RQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTGMzQUOD2OJNskstipaPyUtos4CtPyQ43pzEC2sEhA=;
 b=prks7Kr3powhKTHblvM3NRC07aV0KwrqdKSE+seA3gOSvjWSHe7L+y+e7DkpSG5T1rNINXJ9Jn4QrzfGplhnq1xE/iWKgBa6NTmKb9fzp9z7k903ygKYa+vHSja0xfSY1zO9Pzvr1XZObgFHcOIfxbYeesNqJC6Cba8nmNgM5RE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Fri, 17 Sep 2021 02:58:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4500.020; Fri, 17 Sep 2021
 02:58:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "'amd-gfx@lists.freedesktop.org'"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: DRM IOCTLS come regularly(every minute) still even after screen
 off
Thread-Topic: DRM IOCTLS come regularly(every minute) still even after screen
 off
Thread-Index: AQHXqsPmEH1x+1W7lEiNslfBldIfHqumT5iAgAE5qKA=
Date: Fri, 17 Sep 2021 02:58:03 +0000
Message-ID: <DM6PR12MB261970C1F0CDB0D1D91EE7C9E4DD9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <4ded93f1-e6b1-06c3-9f03-b6135911392c@gmail.com>
 <d8293063-6f0e-b808-2636-631fe2f08fcf@daenzer.net>
In-Reply-To: <d8293063-6f0e-b808-2636-631fe2f08fcf@daenzer.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-17T02:58:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ffd62a98-4182-4ce4-9a8e-29db029f1291;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf5d7102-51d8-407d-82d6-08d97986f75e
x-ms-traffictypediagnostic: DM6PR12MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3692A4C632F8FB91E0D5D790E4DD9@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFdBkwUweYPp2KCJyeay6AnFYeHf3nMvhcmv4yM2a2N6q4iUaNy31OOdneMv9W6tLvVBDlxJ6FQvCBFSj/ykcB1ha5LFq+Alb6YsFafFn2LzeDXFDBypoN8IgW2QbFXUkSvG89w0lbODTTFIiYahQwBxij/ivikf9IGcl3iUdtzE3rhbh+qaTC8X8nz024px+3tb5vWeGn39GmibfaO+exNR/ZV/vYbvRhqLnFVFScZI/vgbaI42FkwujSfp+iDfQzFW8XxJT1PtximMl6wwi7PZtF7FgK5pkFQVpLEmEUX6kGOt6r5VuBPAAvcRzxz1sI45S8oyDSphEdqNW3HVWxaUXEuYVVEipPIfNcyorzwrrJwMW44ayn30r8qrJlysUJYxAECe1GMuE5ejPg1K29jQgsDPwmzaV5FFv1XNqzSL2eHDA7tvR6mszUn8gnyI+plNOZnI2K54kazZ/hFyo65VGpGXxspljcezTX9otpk0vWQsn2CAlPSoCDP/Q+R0PINV1sXdafRAVrMGlfMWKBqvCYBZiXutA+AtlvTnqabw/VaRAHiy+6yaVxoHZhUsRR0ZXorpJDucnWn/JYuDmqeN0lu6H1hqxF2qLfKtXwyh3wyw53FiKH6pEoo3Lw6IWPmhuN8YLVlA0vQoS7kCCF36wP3mU2ZkkB2BLKgYTwenLTQIj5cQvqh+2c+3/GxmBWm9/+5CyK+WurxDp8rEkdWpXg8JxnSbrU42NpO6Ve6HQbpKtxZatRONkhxPC/DxWAVPksQ6efWNtZ09eppitxcT4GAETFdQ+HfmwqzKh9M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(83380400001)(5660300002)(478600001)(38100700002)(8936002)(45080400002)(9686003)(38070700005)(55016002)(6506007)(66446008)(53546011)(66946007)(8676002)(86362001)(122000001)(66476007)(76116006)(186003)(71200400001)(52536014)(2906002)(4326008)(7696005)(966005)(54906003)(110136005)(316002)(33656002)(26005)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eSsttNzsgnIbhLQaqEPvQxsxpWST25ez0tdrRfu9U7vrs5kfHW5TCXvLA+?=
 =?iso-8859-1?Q?fhod1Vh90CS0po+Lu3pXgggIuIAFuEj3luJ0A8OWfHVJ2XNO7QVuW3OaVk?=
 =?iso-8859-1?Q?lWi1vHY/Vs1MnSfwUbNf3GO/qHIRHDHQBMtqcJeHDTlJQjTtMOYiDLZymY?=
 =?iso-8859-1?Q?6L6GsdIz7QZmNRYBVUdtseISyXTv+l1XW7KBCav6Yc5Zh7LVLY9sSHefRM?=
 =?iso-8859-1?Q?mWaH2hTXxoNbBrHcw91jki5S2kOPlDrsTx3YZEb/OTtBuwVTZFQMBFRB1m?=
 =?iso-8859-1?Q?sMwsYj8knCizYSnV3uSEmE5TrNUPABX26uJPzzGFgneBcM20Y9ANkSHPGF?=
 =?iso-8859-1?Q?wz1UB0op7f4Btjv5ytGC0/QiPyFR6CYzkihylTLq0jNZTVvJcZ0P4eIh3Z?=
 =?iso-8859-1?Q?VJORIj5dBq9kI/Z9BGA8ZcAaOYDbXxnEcs/YlohKqvJeq9ydvJ2zC0R0J/?=
 =?iso-8859-1?Q?qCxINCS30EcVhPkbo70TR/XQ9Tpiqdq3itxdKJTt6LGImH15saJ2jnKHBU?=
 =?iso-8859-1?Q?2Eh9regOt1+DPGKI97z2d1+oQMJq2HNT8fJowzMOBHyIPYPldxyMs1y8gp?=
 =?iso-8859-1?Q?nZWZ5S2kG9aCzG27qgNgSYn7wGQF9qpSik10bN8X0SxD8ee64tJXDr6r8z?=
 =?iso-8859-1?Q?NY7UktTWFYYdJ0qTSInRtP75GfDGWXyO/sd7VkGxIW2l29JpW1ynCCYF5d?=
 =?iso-8859-1?Q?PI1KGyeElrA0PkzdvENpneFKQZMuAGZAcpqCfGcDwk7sUBd5W8Tlcd6gCv?=
 =?iso-8859-1?Q?AVUtNNhI/W+CtZ9vE38ASvRcV/GzgYuBzdwcVcC5oLHcYM3m/PsR5jh11h?=
 =?iso-8859-1?Q?VD2drHXriNVjVH34aQD/DMQLFGSkEdK1/ykxkFShWD/9otAg7RF/66Ds1I?=
 =?iso-8859-1?Q?ZaxGwsaV+OaUyf4f9v4oR4U4irjwYA9A8kRg0xUGsEPewOszqYZqCudu8Y?=
 =?iso-8859-1?Q?8T8bNXCO6nqcKU+ekqKVY3z5Cd3g432AU2n652YKKUEkZ6AEmFozv0BaPf?=
 =?iso-8859-1?Q?jzMYV10Vwyh1hEs1+ANq19ga1FaCrAZtEjeKUF8N56ichP/ioCBtw9nKJs?=
 =?iso-8859-1?Q?0paOc+T5ducpszTycnr2iTFAgGB+UzRsjtyUSqAYSUuvmX0VBYUW+veRov?=
 =?iso-8859-1?Q?DnfZ3iYkne0hIx0NtVea3IggyXWvpjBe6CdZ2p/jE55pDYfmmGS4+Bvrsg?=
 =?iso-8859-1?Q?enSMi4zRDPFCc71deAu67C6V6SU4j/gBl5ETEfmY+gX2IXSAg34h5e7Ho0?=
 =?iso-8859-1?Q?txSW9hrXvheCFmz8icyMMFx3qcJum8QRan3ZO0CgaqAX8+ZXJrocYi8UAM?=
 =?iso-8859-1?Q?kmW0sJr/woqyOe9UjA5jYSzFj3qE2Sc0q60gtp4rWPC3H8BlZu85HkWi4b?=
 =?iso-8859-1?Q?uxXPQlxYeR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d7102-51d8-407d-82d6-08d97986f75e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 02:58:03.0411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkSnYp5+3qVZzqkswddB8rbjV4jLdFCU7ePs4dUnujaJMAxBQQd1WruKfgNvnxQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
> From: Michel D=E4nzer <michel@daenzer.net>
> Sent: Thursday, September 16, 2021 4:12 PM
> To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; 'amd-gfx@lists.freedesktop.org' <amd-
> gfx@lists.freedesktop.org>
> Subject: Re: DRM IOCTLS come regularly(every minute) still even after scr=
een
> off
>=20
> On 2021-09-16 08:27, Christian K=F6nig wrote:
> > Good morning,
> >
> > for the background I advised to contact you Michel since we couldn't fi=
nd
> an explanation.
> >
> > Alex explanation might be correct, but the CS seems to come from the X
> server and is always roughly 60 seconds after going into power save.
> >
> > Any idea what that could be?
>=20
> For the DRM_IOCTL_MODE_* ioctls, attaching gdb to Xorg and setting a
> breakpoint on drmIoctl should show where they're coming from.
>=20
> The AMDGPU_CS ioctls are probably from glamor calling OpenGL, most likely
> for X11 drawing protocol requests. Note that in this case drmIoctl/ioctl =
will
> likely be called from a separate thread. Pierre / Marek should be able to=
 help
> you find out where the OpenGL calls are coming from.
>=20
>=20
> In general, Xorg only ever does anything in response to:
>=20
> * X11 protocol requests, i.e. on behalf of clients.
> * Input events, i.e. on behalf of the user.
> * Other kernel events, e.g. hotplug events.
>=20
Thanks for sharing these.
>=20
> FWIW, with only xfwm4 & xterm running on Xorg, I'm not seeing any drmIoct=
l
> calls during DPMS off. So the ioctls you're seeing are most likely trigge=
red by
> clients.
>=20
Got it. Thanks!

Evan
>=20
> --
> Earthling Michel D=E4nzer               |
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredh
> at.com%2F&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C296d316427
> b4469f8eb908d978e9b46a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637673767426116632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=3DgBj4idZGCuaPdyaH1g1mfuDqPCcKhFMjPCbqpM8drlg%3D&amp;res
> erved=3D0
> Libre software enthusiast             |             Mesa and X developer
