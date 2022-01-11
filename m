Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61357C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 14:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F09210E343;
	Tue, 11 Jan 2022 14:41:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D6410E343
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 14:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwafoSQlb01OXIQ1BXl/Ndrr0Yodbsc0DArBirP59XfKhkoguoo9JffCjNwsyQBv6hd0G5d6X87K1pp925Q2gNDrm/soU/PCxqaypQwnxE1p1LIHs7tF2qjd7ASUbn/vvkNxSmWHMjiXw5oTHPbkczkDEKp99d0cLDnUb9ttiKDqWsSnZWLbKXWVHYVKhyOOvOGq8f2FgzaxDxCavnOxKJjccjVlcigEceeBlzulmW+Arq9HO7Gb514vXo4dwko4GMDgSFyw6CTmf9osiieIMjVuS0hXIxKiqDduX1PLWTF4IOGUOk/AZjbRp+kcJRXqu4c5AobpYnsqiCVXxb+ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkeLIfyJsQFILWQC6cw+mrXv+in5j837BVlvdyqNV7c=;
 b=k/BMURxLWLRaf8crnlaH34y6rKwqx8f1GGdihNk+JnxT8uAufVu7cvs3URNjLZt3aG1ZmzatQn8LQMK94IIAoVtfRp0AOeOtrADL9PDLqRzI4rkG1fUZgKoUMZm3Hpknmu7Hp8bWlxZGlCI8TM5vjrs5UmnbohYhEnnTJs20tjt6NyL+fxDJ21mv9Y/LIy6PQdvkzhmZLYJsZDkEsjTNb0CHa1FGexBfJSH4KPyc8g1maIWFVIvoKZpgd7CS8heGU3wD7iqm5cTosA9Ejk8Kpd4zA4yHr0ao3/hvijxuL7RNEQMUV/3MJXbMdZMDIQ+NjSadMv2dKylzw+Po8GpaeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkeLIfyJsQFILWQC6cw+mrXv+in5j837BVlvdyqNV7c=;
 b=tN8ZgnfgsnYCAEQXjzpfDUCmllZPbtNrXgrfKABCHqBfE+zOmr6rtuypYPG74inEzCbkvhGjiXJMzNtz0Vi7JXQGuiF/gDPHBolwAn/DEGM6tbm79LZQKDaLyU6oUCEqyuIEl/NfJp3bGgnRoij9dEGFJOLU08zn/B5a7JxSrQ4=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Tue, 11 Jan 2022 14:41:27 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b975:de48:9987:2ea4%11]) with mapi id 15.20.4867.012; Tue, 11 Jan
 2022 14:41:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Fix DQM asserts on Hawaii
Thread-Topic: [PATCH 1/2] drm/amdkfd: Fix DQM asserts on Hawaii
Thread-Index: AQHX7A1F3siUq3ywz0igPvDBWTF6V6xdJ+eAgADyjuA=
Date: Tue, 11 Jan 2022 14:41:26 +0000
Message-ID: <DM5PR12MB1308E57D25AB98B3F724585D85519@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20211208082531.918062-1-Felix.Kuehling@amd.com>
 <007286ae-5d08-ff6d-123f-9c22a5f29eb7@amd.com>
In-Reply-To: <007286ae-5d08-ff6d-123f-9c22a5f29eb7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d1a3643a-6632-49f6-ae20-4fc495df7b2b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T14:41:13Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7f440ba-cbc7-4438-9237-08d9d51072b6
x-ms-traffictypediagnostic: DM6PR12MB3324:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3324BD4DF702A503A84BFE1E85519@DM6PR12MB3324.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9yZHL/UVLCor/mfhDkMr8VU+4vN76uybKRsX8x7kVyr4a8noVAvwwVo/6YT0VlIuAoQl+09uTxd8ZAP7vLZiIZd52g5BjlXpWVmCaEhpNAYvQPhq2J9dOzrT/Zm2LovrUMgE3tZu22XqA0Hm4LetJ+w9PnqlmlYqHTf0fDJdlDjvvZOmLD++oqCjwttf8omNtcpAJ3aMFKSjSOSOpTQtCGxOYYdhiR76GsthPrJ0Wp/F/t8ppl623VKJ95D+5NQ3mlpp4PQg3MUlWLslLnZaKXkIGHrVsarbsZZjJPXn/GJ8yMiD4nOg2PtU/uJcANH0i7+IV6HiyWdb/z9HF3owgaaD0QsYgF40KX9mu2/DxmYXdNDlXMsNDG/jymRyeq1unc1gUd9vzGBY/vyZFd8xMROhQO9BQV5HoHvFU3MLZEIsS6PJQHGWeVBfjC771bkC9g0GU3y6c+cMyggYz+kgxmWCSisRh9mi+WkNQU1cvRvl+IVt4qvZoVvtS67/7Q9mNfeGVRahND1Lyc8F7WMwbzkcmNoufnM640Ev5Dy6ChqvnsO+wgyaikhbXtCxtahCqT8RFNaqKu6qHtu6QZZu+Cc0F+5GkVZq/gvYimL5g1e7D24+WSh2OxvKKGAbpd6OQFF4DiM3zrSHMoribmJXLvBxM8wDaAVLRMhOwL7VlsNP+84fCYlXmdbaI6yY91FPCWKJzWW361wTF38CqGhmEM2cavZDcdoo90VXqL4LcLNy5wJzxZA1Hp9Q8HBnqZZlbOnrG7yglt9+cB2lUtRLjBfHxk/NKEhe7TUvvIBaxA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(38070700005)(8676002)(6506007)(86362001)(8936002)(7696005)(53546011)(122000001)(26005)(508600001)(55016003)(38100700002)(76116006)(966005)(9686003)(110136005)(316002)(83380400001)(2906002)(71200400001)(33656002)(64756008)(66556008)(66446008)(5660300002)(186003)(66476007)(45080400002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1yl2XLc13Ykojwe3EuDMZA3eoVIKFgoTKxtz29t0EYaM0WFGuEkMdVbZjU61?=
 =?us-ascii?Q?vLM7/qYs2H3wXrenqrBNybZHtEodGbRq1uAzSzFAIwHEDPgbqFMgwjyo63R1?=
 =?us-ascii?Q?Hu9t9OSWM3zu/F9vm67zsLrirqxc0ybFW93P21S9QIIJb0xHnIrlz0w1NybH?=
 =?us-ascii?Q?iq7xS2biOwUDyh20yJmtJMMyhPP3iLgHLYF/cQOGd7XCt/Wtiu5h9IC90wBj?=
 =?us-ascii?Q?8Q3o44smaNK30A4bFsIUxTGTYGzOE8NL9D1C4+7XWaDTttwxru6ur1ibrKyc?=
 =?us-ascii?Q?EFZyIVwqF1LDcbJ4w3wMNbnn75R9qdjwT6sI/aumdGvWG1paX8BNYzt/nx6F?=
 =?us-ascii?Q?+dBRYWsTpSijEYAZh8IloQ3upbCFdMoMKRnUFFBLxU3yv7iD/jB2HJfQGXcC?=
 =?us-ascii?Q?uCMpJD+X8W0P/3dS8WIX3WQ1C9vGfhaoq2kzcBu7WVSOSbYFmQm7y1ml3bNh?=
 =?us-ascii?Q?WVTN4qiIm6pop0tLXUUfHeMjtFWTMG48dPh70Mqsbu78PZwo9HQdkNB1MmG5?=
 =?us-ascii?Q?BwxN22DgKz3IWVE8N66+c8jAjWFaAyVaYl0vXZ9Otq+D5AX9gC6j8pY7d6lf?=
 =?us-ascii?Q?VW8qVOCH7A5hjJPZChXjycI+m/u2ylVJSqPym5a+KGqaHx3TtWTj2I9SIgGJ?=
 =?us-ascii?Q?h80+X54Ktug+G3YOrxP7EG4Nt8NupzzYpOrBYt6Z0yMOTyva2BzJzp1hpQRp?=
 =?us-ascii?Q?p7VUXGcxHovch7U3ffY71HnhW/+nXWZD//Gkb2jKd15QF1nJgPQL77Lmzggm?=
 =?us-ascii?Q?+SU4dYuoL/S245+nNVRLpiXhx8L4JySMvHWmWL+9TgLuNKsdPdMOGk3WUIz7?=
 =?us-ascii?Q?tru8kWw2n/0EQ49RjQCezwsmkE6YIcbEglnlfWnyGIrea2MF0pK3ZbA8QhY+?=
 =?us-ascii?Q?UwdNJpGeuFS3GkUTwSmntiUvYl26/HUDObDLygXz8terNZrjFqT5EvRp6WHm?=
 =?us-ascii?Q?rcLpeNh0Cer0uCMUaaH8t6RoGRQRQYm9E4qlq+ijdgF7Wu5+riAzFsuOdTmj?=
 =?us-ascii?Q?NCA6usVsvN1dNwb7xjj1+Fg3MZawDEB1wPYsLukE5rbLuhOd4Y4/d8F8YHR2?=
 =?us-ascii?Q?N/FAVUPoVUYnff9vXVF+eSzSD9zsXKAl3kOlxXm+OEn310Xu64xaNmw1d3IA?=
 =?us-ascii?Q?97CTVXHSKMRriJP/lRmiVbvFRPVgobElEImx+bKKaDSdchArXQD1Jh3/ZzfU?=
 =?us-ascii?Q?fyLgLQQHlsbLcISPYs5LJL3+IQy5LQ5equSD64nc6HYHCYOTu4Qeoh/D5VoH?=
 =?us-ascii?Q?1UnC4GhaNrsgFMgpXaREeW2IrVmleVX31dwT1wgOjELWhwuU3DgjsyngCEhI?=
 =?us-ascii?Q?H3lJ4u+uzKGTz/Vnu+bFabYfMk0yS3Ou+fwyUzYkjTUVkxMU1Fyo42ZRXPjd?=
 =?us-ascii?Q?ZG2WFhA/xAD7nx+8nDRErUKYJ4O1ZJsQk4PK1iv3WaDOoLPP07RQDm6lxNtx?=
 =?us-ascii?Q?f9d7JUlkkBFuQHCmGLCWvxEQcNE5Xz9LWHQ3C5y6GIodJv5lJVzUNpL+GCPn?=
 =?us-ascii?Q?guQhukmVLoHgTmSi+r67i+pF/PWQwN5/aGve6LHN6KAbRDJN5/gDfHXd6BBR?=
 =?us-ascii?Q?CBfK/WAWFg8o5yfmgwiHKfTYE1XTFSY4s1QjWUjO7Qco3UCU2tI1GZgd/B9G?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f440ba-cbc7-4438-9237-08d9d51072b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 14:41:26.8990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csQVdPJ3/Pw/4Ay0/axse2Fu9snAcxziDYL7fGMJ43m8xjuYkJPKihUnMy6GEvj9x35k0x++wjZ1X/FjmFpmAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3324
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

[AMD Official Use Only]

Reviewed-by: Kent Russell <kent.russell@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix =
Kuehling
> Sent: Monday, January 10, 2022 7:13 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdkfd: Fix DQM asserts on Hawaii
>
> Ping.
>
> On 2021-12-08 3:25 a.m., Felix Kuehling wrote:
>
> > start_nocpsch would never set dqm->sched_running on Hawaii due to an
> > early return statement. This would trigger asserts in other functions
> > and end up in inconsistent states.
> >
> > Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FRad
> eonOpenCompute%2FROCm%2Fissues%2F1624&amp;data=3D04%7C01%7Ckent.russell%4=
0a
> md.com%7C44c423a1e21b4676d29c08d9d4972868%7C3dd8961fe4884e608e11a82d994e1=
8
> 3d%7C0%7C0%7C637774567959648449%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DIY=
VH4ZU
> UOL1cVzCLZfvoFkRO5%2FKlHsSd6H8RRUP73Nk%3D&amp;reserved=3D0
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 ++++++---
> >   1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index dd0b952f0173..104b70e61ba0 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -1004,14 +1004,17 @@ static void uninitialize(struct device_queue_ma=
nager *dqm)
> >
> >   static int start_nocpsch(struct device_queue_manager *dqm)
> >   {
> > +   int r =3D 0;
> > +
> >     pr_info("SW scheduler is used");
> >     init_interrupts(dqm);
> >
> >     if (dqm->dev->adev->asic_type =3D=3D CHIP_HAWAII)
> > -           return pm_init(&dqm->packet_mgr, dqm);
> > -   dqm->sched_running =3D true;
> > +           r =3D pm_init(&dqm->packet_mgr, dqm);
> > +   if (!r)
> > +           dqm->sched_running =3D true;
> >
> > -   return 0;
> > +   return r;
> >   }
> >
> >   static int stop_nocpsch(struct device_queue_manager *dqm)
