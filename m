Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61ECC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 02:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DC810E815;
	Thu,  5 May 2022 02:30:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134AA10E815
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 02:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRn4MGCbqYCJkItWyNvqJ5VIe0zAUInHCj38s50Ic8uTHelMQvvvrYp09JrRCF6kFVKyd/6ZhlEV7379THLwVNwSjhLS7lfYWqiO6Wxqclm+vsPGlUZYpB7k59qz/LLBJtc2hJSkZ4TEaZfxjAcdwY369RQ8AK5ZtQ8dXYiHBrlwFuCHBIzWhhkJyNAQK50eSEXu8MDmgfny4w2u4nmSROKpcrA8Nlia0JXK3FKI8Uix1ypWP1V8pz8ot+l2njNaDR3IWcOEG3BoikM7g8DxQRCshhrAhyAEIDnpXpodjzW3s/NULcebuVKUSWEPDFoD9F112IfeXcAhkTTqEPlmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHgYsLyV+T8nyyYQ8Rshd+/bw9Mbm/9u7roavpJ9sG8=;
 b=F9Qp9faiGbflsnUBTD9lRhYHG0mIEW1/1fTeRvzrcW6bo+dXZgpK6V5NEsB0n1RBMkbz+gu/bpjHHmSYTaB5y/PK9buTBIy64mT1NbLn3euKq9L9Wy5oLQfNNwiP8Ins6s2zOTr9pZsGMaJvIW/i+H0chb+PMdKb3bvHqf5mYqffZq4/m7X1245IRp/9okAnrzn3RRgwUsm6aq/Vzp65k6kmt0iDjEFZRW/d7q3Q2/lOg5C0iDvHPC6GcP4wr88jWMmHxZwKUD+Lh/b+mvV1Ky6Q8OuW9+FGAPN+yrezWe+NPVkY/V4NopiwQ0y4E2O2XrSoShZtvh1tH9LYWDZWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHgYsLyV+T8nyyYQ8Rshd+/bw9Mbm/9u7roavpJ9sG8=;
 b=DP7+uN4+Zxwj8b1od81Dgg4yq4+o5625rpux/nzq4yImMVLJWNXYH5r25UtsShCsxC9c/2mI9ZmfcF7cQlEyilzPy60znk8CbQJOr9X0S1P7Naz1dGwUCV9XlchXRnl2QVSk0hyv7GelF1rnFzrWpXbBNxdkltdBQN+cgdCnkXo=
Received: from BN8PR12MB3348.namprd12.prod.outlook.com (2603:10b6:408:47::29)
 by MWHPR12MB1471.namprd12.prod.outlook.com (2603:10b6:301:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Thu, 5 May
 2022 02:30:21 +0000
Received: from BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::9578:3253:b218:20c5]) by BN8PR12MB3348.namprd12.prod.outlook.com
 ([fe80::9578:3253:b218:20c5%2]) with mapi id 15.20.5206.026; Thu, 5 May 2022
 02:30:21 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: Lyude Paul <lyude@redhat.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: Do we really need to increase/decrease MST VC payloads?
Thread-Topic: Do we really need to increase/decrease MST VC payloads?
Thread-Index: AQHYXnWxeOd2xl7HgE60NUW6p3v25a0PO8QAgABT60A=
Date: Thu, 5 May 2022 02:30:21 +0000
Message-ID: <BN8PR12MB334859526DE2D862EBBA0128E5C29@BN8PR12MB3348.namprd12.prod.outlook.com>
References: <dd5c63923636ec2ad78483899b1e4885e2235055.camel@redhat.com>
 <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
In-Reply-To: <ad4ce2ddd2f2019f360b501c092680c799cb468c.camel@redhat.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-05T02:30:18Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=16e93226-07f6-474a-85ca-5a1918b79e6f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-05T02:30:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ad0f5add-5bfd-49f3-a28a-071bef61751b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be1314ed-1ad6-4909-855f-08da2e3f33c9
x-ms-traffictypediagnostic: MWHPR12MB1471:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1471340A2C254574A62271DCE5C29@MWHPR12MB1471.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48mQ3QVI8aODFrASQJZkPMKehiWqw0ScMr02YdYdTA3NCz02iVDwo4KdQGU/kaf2bbboUgvWWyzLMqpOq8KqN3YUdIhAYlkJFTyGQVZ6p+ZbK7wQUb9gkXbquwE9NcJWkxpRy/FK4m8WXLk38abKr50nxgoBCDMEVGuK3YRGrmWLMBKUuGVnthNS6PNrDTWQu8Ph/RpNoCuOIlAJLylhy3yosKKides4LiNTu0wY+HnWWyoqZOPWMrAZguk1+sAMTUmfo0QWhD4xNTY69HqNABwJ16zfUMEqQeQ8HVj1Y+Swtihusiapb3bcSXITbblf4ObAvRAi7byvaAcS9tKr1iXcRXjm9smIwBzKWdijmoPtaPBOS9+vU9+5GkItpIzyMQpCmFxEuOV/poTmAOVNXhmHBVyzTyAY5FlRvDxdEjSSrd7YO8A0rSLBufk8TtcK4m5zU/DPXSxqBqyCINLoLFFSIpK+/AelIDG3IjFFVQlOu5oZblYYHh/PwbVxvewL19e0Y/m2lAUFikjJwfd14GVZ88z1+L4hZyVZMXMHZR7N/PaGWF/EMbOJ1TjjH8O2BCELIX0zBtVLKuHf2Wg60vDCClFlt6ZCAvpi1nYT9HsElubk+8wRLPhISdThJKi1F+h+g7wqnz0v9FZA8d1o2mgvFIu4sdLrt4dNTNOCAITTOKLl+CnQv8AEdHdDHS0lb5gauGTIGQcNWfGmOpW+aXiGQ1f/S8AzpLyWiMV7x5eh9z3eMRpt4Vf3UAuS/n1xDnJtFDWPAqBDgJOiUccp9TBeRTMHkGFvul1tF1rnfz4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(9686003)(38070700005)(55016003)(66946007)(64756008)(76116006)(316002)(186003)(66556008)(66446008)(8676002)(66476007)(110136005)(86362001)(71200400001)(966005)(7696005)(52536014)(53546011)(6506007)(2906002)(38100700002)(83380400001)(5660300002)(33656002)(508600001)(8936002)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sVpBpDqdHjCUFqDn7BgiyJASX/HSSO7NAAcp8Q8/LvQ2sOegfe5Dw9ztsz?=
 =?iso-8859-1?Q?tCI6HhlOgyptJEDIdnn1eFnPIVshGr9z0R6IJZQZIxEkRVoOhMvRiIY4YW?=
 =?iso-8859-1?Q?PTMPbpqSDTo2NpY+KDF9bj64hR5B1WUaqUM/2MNyQEa4rLWu7ywrrzzE+/?=
 =?iso-8859-1?Q?aRcx8WzDwRCs+wsM48aZ0Qdj6KhsS/xwZm0eT4a7hGhmKczk8MjJuaU02n?=
 =?iso-8859-1?Q?HMLSBLRtfEnwxYP1bc8tHQXvY04KxUxbrdl0Dp5gB0FM8tW+jhuAoDQ/r8?=
 =?iso-8859-1?Q?jx0WfwodvpazQNtvb+5ZGKoOic7d9I8LAAJOcIOT/aAMPpJWPUMOSoOhdP?=
 =?iso-8859-1?Q?/BBvE2ZmXTUStqDIytcZoNjQb5rvNPOD8yxdLZMkB7ELq/J9q3/d3bM6E/?=
 =?iso-8859-1?Q?FB6bhYpaA+NzDD1rezQdnXc7guZ0+Iy/QcK0DtVzTO8t4I4U8NctOjonaG?=
 =?iso-8859-1?Q?kvjpI5fQbygw2lcuF94c1fcrZRWJHMlvGutkTaDlaPegMWJvHOs4cXCYgX?=
 =?iso-8859-1?Q?lRtqNh3YE/EsOp8OXzIOAf1K47gXVmNS/nVw6HhAzK0q2cS9Q69bGacrWZ?=
 =?iso-8859-1?Q?MC13fv5emXjKFLF8Krl8FQJkY6LQNQllulfXPg8dhGq2OvtIyW/rS7rdST?=
 =?iso-8859-1?Q?aIQ8YmKPUKHAANE/Rsiknltpab8d4pdelShJkMqsbt6Ulb7OvrFd68/2NM?=
 =?iso-8859-1?Q?9GNOO0MS+TIifb5BqjJeIwlD9U9VemmoNS8l0x9sLS+zQbCs9drubLaY7P?=
 =?iso-8859-1?Q?45amy/D7uklW5VxmXljBoHdnXTUCqV/9Il6/joeum0eVZ8YxUd5mWkIdWf?=
 =?iso-8859-1?Q?j7JG62c+IcI111xYC6SxcHyVJK8oN1jw51A/ZSFjfc/MIz5hu1aaZ+MyMF?=
 =?iso-8859-1?Q?YhZEQc2u/IPvdiLgLSF4jATsfE7zevyQrXdZ4JvaOym7gxJXD3+CWhfAJX?=
 =?iso-8859-1?Q?axxWDtYQqoR0iL5tzZso0wPWx/xSPYOpqioznDsKnQaPvQwKcEpRBwiCCV?=
 =?iso-8859-1?Q?PWaUkLBnSSZe6+zrX+PgzWDNI1pywFkPXyTHKF0+3Jx8XMmK6e2edgpJS6?=
 =?iso-8859-1?Q?o1IZYsU3ZtFjvPkojMdkMsq1AMxsFKEFMFjIaZoySr9kGo2iGR4jyPwsaw?=
 =?iso-8859-1?Q?ji3nC8z35qo9/9LVG/7lIWAkv99ZP5/et/T8ISkuRd1Fw9rH4BP623yAHn?=
 =?iso-8859-1?Q?XUoRavQYYmnk5IlOPyrerfC2HAQTpS/j3bgTi6f+BYbYL/Gae0hsg6gvV7?=
 =?iso-8859-1?Q?rP9m/kcuXvXofASMExToTGJTIRDW0/tIV3gwMELeVPjQXbZ+3eWWKbQ4An?=
 =?iso-8859-1?Q?E8BTzKhfl2fTx3f99+9w2qavc1/zzxLrHzoMt6+KGt+jHgpRhahjXMRE7p?=
 =?iso-8859-1?Q?aKbApbRP6/mKsBG14HY2FipquNwEAfKG0EB23r1NjuLrf9RhVoytnTd9hL?=
 =?iso-8859-1?Q?x8WmOvmh0XiXwJETkMZzwQ+lZbtwnUO+TZMUSQ4bmvA6qIcsCyRI56e73i?=
 =?iso-8859-1?Q?BCbRx/TikObLin2ek/PLYr23+DzDM5TftBB1VwIeUjPpXRbdfb8JOP/1Zq?=
 =?iso-8859-1?Q?vxYN+s6QfqA03AY66Vv8Ph9MOUsy4eQXpDaOrguB2Xl3ib3QXKepy4BFjW?=
 =?iso-8859-1?Q?cu0tJ+CyRzajp+f2FVW8k0y9UPUWS+UlcxZzKODW/oLig7Pl3fHEO1el4o?=
 =?iso-8859-1?Q?sbd6kEoyPq71vX4Bbl8tm0m3ssFjxIn4aaaehGEqlHFZl3OGww7Pzp0QnD?=
 =?iso-8859-1?Q?tNxxnQv00ouebb2Zyw5Z/NATS/DOlhdvIu4r49vHg6k6gTmjv9YBff4lHx?=
 =?iso-8859-1?Q?+635+ZaVBYjexbk8/98ILsEnKLUWP5kj81kOCr4z/Qf5PWKGU8wQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1314ed-1ad6-4909-855f-08da2e3f33c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 02:30:21.2383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2st5bojCAomzInGijoOIajqrr9QkyFXKdZT855mHLmxLd9F/WNsKBM5/qjfnU5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1471
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

Hi Lyude:

     Sorry for replying late.

     1. The payload increase/decrease routines are not for DP2.
     2. mst_bw_update is not used in amdgpu_dm, so those two functions are =
not getting used for now. I leave it there simply for future possible hook =
up.

Regards,
Jerry

> -----Original Message-----
> From: Lyude Paul <lyude@redhat.com>
> Sent: Wednesday, May 4, 2022 5:17 PM
> To: Lin, Wayne <Wayne.Lin@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; amd-gfx@lists.freedesktop.org; Zuo, Jerry
> <Jerry.Zuo@amd.com>
> Subject: Re: Do we really need to increase/decrease MST VC payloads?
>=20
> Some good news: I actually came up with a way of handling this in the new
> MST code pretty nicely, so I think we should be able to move forward
> without having to disable this (although it would be very nice to know
> whether or not this is necessary for amdgpu to work, since it'd still be =
nice to
> split this into separate changes to make reviewing my big MST patch serie=
s
> easier. More comments down below:
>=20
> On Mon, 2022-05-02 at 18:40 -0400, Lyude Paul wrote:
> > Hi! So I kinda hate to ask this, but finding this in amdgpu completely
> > took me by surprise and unfortunately is (while technically correct)
> > an enormous pain and not really necessary as far as I'm aware.
> >
> > So: it seems that amdgpu is currently the only driver that not only
> > allocates/deallocates payloads, but it also increases/decreases the
> > size of payloads as well. This was added in:
> >
> > =A0=A0 d740e0bf8ed4 ("drm/amd/display: Add DP 2.0 MST DC Support")
> >
> > This is fine, except that it's totally not at all a situation that the
> > current payload management code we have (which, is the first place
> > this should have been implemented) knows how to handle, because every
> > other driver simply allocates/releases payloads. Having to increase
> > the size of payloads means that we no longer can count on the payload
> > table being contiguous, and means we have to resort to coming up with
> > a more complicated solution to actually do payload management
> > atomically.
> >
> > I'm willing to try to do that (it should be doable by using bitmasks
> > to track non-contiguous allocated slots), but considering:
> > =A0* This isn't actually needed for DP 2.0 to work as far as I'm aware
> > (if I'm
> > =A0=A0 wrong please correct me! but I see no issue with just deallocati=
ng
> > and
> > =A0=A0 allocating payloads). It's nice to have, but not necessary.
> > =A0* This was from the DSC MST series, which included a lot of code tha=
t
> > I
> > =A0=A0 mentioned at the time needed to not live in amdgpu and be moved
> > into other
> > =A0=A0 helpers. That hasn't really happened yet, and there are no signs=
 of
> > it
> > =A0=A0 happening from amd's side - and I just plain do not want to have=
 to
> > be the
> > =A0=A0 person to do that when I can help it. Going through amdgpu takes=
 a
> > serious
> > =A0=A0 amount of energy because of all of the abstraction layers, enoug=
h
> > so I
> > =A0=A0 honestly didn't even notice this VC table change when I looked a=
t
> > the
> > =A0=A0 series this was from. (Or maybe I did, but didn't fully grasp wh=
at
> > was
> > =A0=A0 changing at the time :\).
> > =A0* Also on that note, are we even sure that this works with subsequen=
t
> > VC
> > =A0=A0 changes? E.g. has anyone tested this with physical hardware? I
> > don't know
> > =A0=A0 that I actually have the hardware to test this out, but
> > =A0=A0 drm_dp_update_payload*() absolutely doesn't understand
> > non-contiguous
> > =A0=A0 payloads which I would think could lead to the VCPI start slots
> > getting
> > =A0=A0 miscalculated if a payload increase/decreases (happy to give
> > further
> > =A0=A0 explanation on this if needed). Note if this is the case, please
> > hold off a
> > =A0=A0 bit before trying to fix it and consider just not doing this for
> > the time
> > =A0=A0 being.
>=20
> Sorry for being a bit vague with this! I typed this email at the end of t=
he
> workday and didn't feel like going super into detail on this. So I guess =
I'll do
> that now (hopefully I didn't misread the MST spec
> somewhere):
>=20
> For reference: the issue I was mentioning here was regarding the fact tha=
t
> the current payload management code we have doesn't keep track of exactly
> which VC slots are in use by a payload at any given time - only the start=
ing
> slots and total slot counts of each payload. Which means that once we
> increase a MST payload, since the additional VC slots will be put at the =
end of
> the VC table regardless of the start of the payload. As such, it's possib=
le that
> said payload will no longer be contiguous. An example, note for simplicit=
y
> sake this example pretends we only have 8 VC slots instead of 64:
>=20
> Payloads: #1 =3D=3D 2 slots, #2 =3D=3D 1 slot, #3 =3D=3D 2 slots
>=20
> VC table looks like this, where each number corresponds to a VCPI and X
> means unused:
>=20
>         |1 1 2 3 3 X X X|
>=20
> We decide we need to increase payload #1 from 2 slots to 3. The MST spec
> mandates that new slots always are added to the end, so we end up with th=
is
> surprising VC table:
>=20
>         |1 1 2 3 3 1 X X|
>=20
> Now, let's say we increase payload #2 to 2 slots:
>=20
>         |1 1 2 3 3 1 2 X|
>=20
> Surprise - the monitor for payload #1 was unplugged, so we need to remove
> it's payload. Note the MST spec doesn't allow holes between allocations, =
and
> makes branches repsonsible for automatically moving payloads to fill in t=
he
> gaps which we have to keep track of locally.
> Normally the handling of holes would be fine, as our current payload
> management code loops through each payload to fill in any holes. But thes=
e
> payloads aren't contiguous and we only kept track of their start slots an=
d
> total slot counts. So we would end up thinking we now have a VC table lik=
e
> this:
>=20
>         |2 2 3 3 X X X X|
>=20
> But that's wrong, in reality the table will look like this on the MST
> hub:
>=20
>         |2 3 3 2 X X X X|
>=20
> Now things are broken, because we now have the wrong start slot for
> payload #3.
>=20
> Just figured I'd clarify :). if anyone is curious, I ended up fixing this=
 by adding
> a bitmask of assigned VC slots to our atomic payload struct - and using t=
hat
> to keep track of the current start slots for each payload. Since we have =
a max
> of 64 VC slots which fits into a u64, this works rather elegantly!
>=20
> >
> > I'd /very/ much like to just disable this behavior for the time being
> > (not the whole commit for DP 2.0 support since that'd be unreasonable,
> > just the increase/decrease payload changes), and eventually have
> > someone just implement this the proper way by adding support for this
> > into the MST helpers and teaching them how to handle non-contiguous
> > payloads. I'm happy to leave as much of the code intact as possible
> > (maybe with #if 0 or whatever), and ideally just add some code
> > somewhere to avoid increasing/decreasing payloads without a full
> > modeset.
> >
> > FWIW, the WIP of my atomic MST work is here:
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Flyudess%2Flinux%2F-%2Fcommits%2Fwip%2Fmst-
> atomic-
> > only-
> v1&amp;data=3D05%7C01%7Cjerry.zuo%40amd.com%7Cf669121b53414c0dbc9
> 40
> >
> 8da2e137e85%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6378
> 729585141
> >
> 60092%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJB
> >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIBn%2BF5
> 0r9WIeUfG
> > 9MUGStbACr5Kolu3PB5K0dyiiYwg%3D&amp;reserved=3D0
> >
> > I already have i915 and nouveau working with these changes JFYI.
>=20
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
