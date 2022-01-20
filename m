Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8220C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 02:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED6210EE99;
	Thu, 20 Jan 2022 02:37:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AF710EE99
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 02:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3lzuDh+sv8SRqGrhv8RRo3VFko2WS6IQXgTvLWBbPVPek3yDwxcJZ53MK+czBCNzDKNP5gG9U/qjgaVTCF3xJBJIgP5uD0pOK3rOW0hNQnx3RxDjx72EdhMScZQahK9RD/T4mlXd4Kje7EEZK5Ha90xnLsUhaPwELwBlSVk1ylrIZgJTXj1qQfAXW9vIryLu+QNzp9e22bWg2gLjnlPQ4/YhnG4l+giqj23umZ8xkhhUfeT23j2h6tlVTn/RKLOiNkBwLapWS62z5086m+0sq026xSZ9SZiPY0vuj0GOHoy0s4dta9e6agEAppElgAlP7omHl9QEqNE7e7Lug91Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn1h5FyfPpZIT4lh5QAN+FUxqjrG8uvn8taD/ibNuwQ=;
 b=YpKiuvcATEylqSoSWgI3r0CPhuDDiK1/CAWm7m4ln4GsvyXz0YPlT+38z6dHECWa3fT28sfXz8dHtd7bGvMEQbA4lKR8E5DNmn9yQpT3Eut6j449hHuLkDnh886TU8sCHu3/GFmSCPiBwnwFgEyCNCIBz4q+POx4GERXI0xyqnb9NNrWm+rF9MmTqZWgntYnFdbbq5qHoUduCVqiwBULp7alNlaWLhtGF/WZ1fbDxOor6vbg2Fv1l6YR1uNpD7ZDkDREAN4nyksUZmRKBf6DmfQJ5Bf9zhn/7FiD1lO/eay8ujlS+4Q9XeU2JQwrWE+fW6LRNIBF04ohY7nnKvImlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn1h5FyfPpZIT4lh5QAN+FUxqjrG8uvn8taD/ibNuwQ=;
 b=CpicBdz+TUsjwYhLGOj1NOoRUvN0jBAFQoWcyXRW9Gr8WD5rOO/W0S5082aNPfjHAD6BTEm7sxVzdwqMgvDUCibIM7RgQfws6990i9uxhbbL5w50kKBRG5J5J+V17HSq9dDx02z5R4AYJ6xOY5dSpqy1KHA5t0znJ+SvTaNp9Pk=
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by BL0PR12MB2820.namprd12.prod.outlook.com (2603:10b6:208:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 02:37:04 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::cc07:fecf:c07d:403b%4]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 02:37:04 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
Thread-Topic: [PATCH] drm/amd/display: Shorten delay time to 1us while
 resetting FIFO
Thread-Index: AdgNgnXaHjkBOvHIRT23qnPD9UzUcQAALKxgAAjVXVA=
Date: Thu, 20 Jan 2022 02:37:04 +0000
Message-ID: <DM4PR12MB521443B5E8E8452B88ED4A839E5A9@DM4PR12MB5214.namprd12.prod.outlook.com>
References: <DM4PR12MB521400998515602D0F8AA6EA9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
 <DM4PR12MB5214DD41D3E2E2271F732CBF9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5214DD41D3E2E2271F732CBF9E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5d442e48-a6bb-4d26-b007-f22afc8456bb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T22:23:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3779eb2e-cc4d-474b-66d1-08d9dbbdbeff
x-ms-traffictypediagnostic: BL0PR12MB2820:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2820D3C4FAC36B5D95A27D2E9E5A9@BL0PR12MB2820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WBSj5DOGxjOD9wZWGrGghAA4+CsoYMbEacxUHrPQ3KJEX2vSRYElV0ISpe0RUGgSIkXoDXHxjGoR5cVYJe/x5gh7WmdqjbpWiFxQQFG+f0iRFYLoBbFsoDOQ5234I+aQ6On5gZKgWIR9CrRYZYEjSQBYEYYmpJwSuin60bX3YcR7A8xLF5pi0KgjnevgS/e/2COsB7I3iKbCSD9HJG4OHockIpTmaQ+0efuVy1vgDlIS8DMb5LdsV2xPneKcH35L6AgfUI/sSSxSzTNxIyNDxOWHUNJyszPfDDQUFItlMHpQFG4N7AVjwKam+Vo4xVBndyQvSA1KqfARE4vh4IXsbAevvkjg9irklkpnnTEmzcc31Pbu8RjzrPrHgY/FAyb8qKS130+s3BloyQ6eQe7+OKHgLtUmPQ11upKaSf2s02spHLR6TKiKgx+By3BQFWEBryOHyyFidAnDY7RWOfwQUR8JQxz5mKtz5ojIp7DloeIPkIEI9jM5DIBBOjsDqme5kDCWPvIyyEedTb8uvJBUyeNZnaV1Y+B9RyaDgXiudFpgiHH7h4DZpXTAFSGTOUp4EQfmnUbyB25zAm0uE2KUa5vL2Oo1BtzvcGGzJrqMJe80bC33751HyUpsB4BYrXevVURQCNzQf59F0IZKqeF+ir6q/Q1H3fI1dabsFpRSRbcejk8T9o/X2ItT7jD/dx5n/YVKojQnoXYe0T4s9MQhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(38070700005)(66946007)(316002)(55016003)(9686003)(66556008)(33656002)(8936002)(76116006)(52536014)(64756008)(66476007)(66446008)(26005)(53546011)(86362001)(122000001)(6916009)(54906003)(83380400001)(4326008)(6506007)(2906002)(8676002)(71200400001)(7696005)(508600001)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IeX4+wosbxoeFNojAn1N1PfHDytjq4oFrI7e9IXZMF3lbRNhWFUP9bovs5Ba?=
 =?us-ascii?Q?TJXfEMTT5ytYqRcXDLj0DRGpcx18I8EFisQEP+wM6+rWuTHmyfEy8v2FWugL?=
 =?us-ascii?Q?iP4+fh8i4yVtvjnhImkOQrbS4vDc/TZTILLeqzJ61MxDi4sSl1ZFJqK2q8IV?=
 =?us-ascii?Q?aoAHFMWrZqZ2q/ceVHhDCq5Y7+8IX43iMR+5MdUw+g3vljVFT8PVFVjj8Jyo?=
 =?us-ascii?Q?VNs4iEpXS/XKfwu2OY2ZlLjn7MG+up9x77qEF5Kf2waUxbeKMob9GSXSJO87?=
 =?us-ascii?Q?02dKoCqN5GZmvvQHig7/zcNYVEcOGW72xmA4CkuJPujfKtK7BgaI5bXeOs8p?=
 =?us-ascii?Q?O/HWWTs8lsqEilo1i6KjhidxoYse0BTHdVAGdqWoK4HJKrBCM4gg2B+qSiqW?=
 =?us-ascii?Q?sFGwVUPi4qnGKvPOl7JLf0bCgFldCbqsmMj808zk5b7ZYa2f7eavfeuF+AaM?=
 =?us-ascii?Q?oriWvPAwVlIcjFNssKVPg2+Tojyt96wsddggbFHG739xssm9laHRgr+aca8v?=
 =?us-ascii?Q?1jsfkLOPnhMDXZH3pe9rWDEJPl6LCrqQ/VF7TKpXuIBI4xhC1BQ/177PivW6?=
 =?us-ascii?Q?wYaDeb/VGS1UA/BQ/ukuVOwnJj7AnNCbxjgxi/bykqs0+Z8reqQ2k2mSQNnn?=
 =?us-ascii?Q?ngfUdrE/UZ44Bf0fnxqzPTSjFbKlU6NQsoqoz+C398Jz1rTk2oe/AQpHn6h1?=
 =?us-ascii?Q?6qLC031eqQO9g2+QrJta/KrP361pY3vbshZ6u7AX+pm+HK8HkU77oi2VTCaS?=
 =?us-ascii?Q?VB3SN5eivZO4rT+s+Vts1xwhG1qQfUUydRRFKLwLvfTHylPfzn6CpXU8bKZZ?=
 =?us-ascii?Q?5Aq0aufc44uei39pvEbTNHO5GEReKK6c+92lJt54/NJTznz8Vlm6EvgvUYxS?=
 =?us-ascii?Q?1gZG3qA81bUANsdoIjHyUHiLoSNiBQLCG5u3eBKGgdmPiCAdKnbcrwdNJhMx?=
 =?us-ascii?Q?Rsci8pQNsKRAzvQPHX+akKo7XvQvddWPfwc6VnwKcgjWhDME65vS0JGAaWP/?=
 =?us-ascii?Q?0Hiu1KOGlTgF2EFoIb8Dmy+eQpiXS3NcMm2q+MW3YC+SXF+oMIfiVcI7k4dT?=
 =?us-ascii?Q?pBVfa7UEjFCtW1m534TZptJg7a9VroTJUWZvshAbnr8HqarUsGLv2IFFw9sa?=
 =?us-ascii?Q?+79sV8URAznTtqrVCEmarKdHaRDQts2os5fBwBUXWEaN64IfhERVtpUNH7D0?=
 =?us-ascii?Q?oEh1TzOn0boxtm10k2iQwVh2+lpD4kcc29mzgMht/yewhZXvLUVglE3MVBg8?=
 =?us-ascii?Q?QCa85sp6rDnK0WdRg9ujCs4qTb47i4SIFzfZhnJkN3b9TMilMW1n8hiXf5eT?=
 =?us-ascii?Q?VXtkzHAtvvK7AMu2XaRJAcc1G1vBP3r8BncvZI+3HTpB87sbjMPHMARFgylR?=
 =?us-ascii?Q?tBNhCqf8ldu4y7ZzPY9etB+5M6PFamHlfJ3CuSpHrA7b26ZonHYVhrl4I5bV?=
 =?us-ascii?Q?7gyLXsKbaXQiMKZVIWHxDpJ2p8KzbQhBA9VhnG/W1GQ5zqbjj92qNqWbFA8G?=
 =?us-ascii?Q?0iNSzoVh2J76SeGteESV93n9F9b+T86TLmwS0XeouwkTlbk2c7uKBJg20nB9?=
 =?us-ascii?Q?G8oo3pwl5XAk1H1ppZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779eb2e-cc4d-474b-66d1-08d9dbbdbeff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 02:37:04.8878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rw+2LJ6xCp0DHEk0JCDZBswF8EAYBTH9T39HBmh4x5OOImaLNHtLs1ogGfrvRN2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2820
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thank you all for the review. I've found a better solution here, so I will =
retire this patch, and re-submit a different one.

Thanks,
Zhan

> -----Original Message-----
> From: Liu, Zhan <Zhan.Liu@amd.com>
> Sent: 2022/January/19, Wednesday 5:24 PM
> To: Liu, Zhan <Zhan.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Charlene <Charlene.Liu@amd.com>; Kotarac, Pavle
> <Pavle.Kotarac@amd.com>; Pierre-Loup Griffais <pgriffais@valvesoftware.co=
m>;
> Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Cornij, Nikola
> <Nikola.Cornij@amd.com>
> Subject: RE: [PATCH] drm/amd/display: Shorten delay time to 1us while res=
etting
> FIFO
>
> [Public]
>
> Apologize for sending out the patch with the wrong sensitivity a few seco=
nds ago.
> I've updated sensitivity policy to "Public" here.
>
> Thanks,
> Zhan
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Liu, Zhan
> > Sent: 2022/January/19, Wednesday 5:19 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Liu, Charlene <Charlene.Liu@amd.com>; Kotarac, Pavle
> > <Pavle.Kotarac@amd.com>; Pierre-Loup Griffais
> > <pgriffais@valvesoftware.com>; Gutierrez, Agustin
> > <Agustin.Gutierrez@amd.com>; Cornij, Nikola <Nikola.Cornij@amd.com>
> > Subject: [PATCH] drm/amd/display: Shorten delay time to 1us while
> > resetting FIFO
> >
> > [Why]
> > Current FIFO reset delay for dcn10 is 100us, which is too long and
> > will fail atomic flip. As a result, there will be no display on boot.
> >
> > [How]
> > Shorten delay time to 1us. This also aligns with FIFO reset delay on ot=
her ASICs.
> >
> > Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> > b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> > index bf4436d7aaab..2077c22befa5 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
> > @@ -909,7 +909,7 @@ void enc1_stream_encoder_reset_fifo(
> >
> >         /* set DIG_START to 0x1 to reset FIFO */
> >         REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
> > -       udelay(100);
> > +       udelay(1);
> >
> >         /* write 0 to take the FIFO out of reset */
> >         REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
> > --
> > 2.25.1

