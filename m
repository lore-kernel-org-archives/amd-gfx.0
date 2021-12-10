Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27686C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 02:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAED410E210;
	Fri, 10 Dec 2021 02:52:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDD110E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 02:52:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+lFLxSK8Lw/7tAqfGpiOGfrNVLOQBhtxrmBnZk50iNWuZIy7yztnb3iyV23gPbOrS22z60xfVzpSCW+wMYX+BHEcjjRiZAe3KhFC/oUWOFWHZVhvahxqACZ9zxb0AwJZeYvQ/mw17IffyFFLLZOWxY8ozToJy1onj44VaV8V9s9gnMEreE4grMiS7doy3l2uoviY32ra8Mw8Gt4CljV4Enz2VlGjIzkM6UXGWRvaJa73w8KD6jRd4he7VqjC7Ee4Jq+rxkuJwenxTXJa2Lz4unihhwUVTE98QmnmvL//UAVX6ETb/u9LXEmFooPUxrZBX3609N+L6GZKlKmpG5LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZmDAbhUob8iy/pV7N0Gamrh9gVam0JmspF53xrZ0jY=;
 b=gbeCu+Mi5sg7pYoj1F1XJhNcX+DJ8rJSpll7P3ojoYE6hMEK1YnHI6vhH2eQ2bo4vls0UCdEbmhUK1l1+wlJEBPDyLKqjuoTrOQt71M/Ah1durZmnzQ1gGlVHLUYmdPCbqH+S0Pb0MDXHbAuk8FojOQKib8bNhTZnVGQLHd+VlEg/8EeM81kdztCvFF2F6AF2W/aa8EI+FIt99avvjKIA00MRzcPAB01l/reyOU9UHgI7IBaRr2dKeT/02FY/MwrkbSTfrsibtAbJA0YL934g7RVjUIR1lIj7BdrPHRhjWif9tABq144gqxsPkjcPsQiD6FmPuo0l9b2SAx1npTQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZmDAbhUob8iy/pV7N0Gamrh9gVam0JmspF53xrZ0jY=;
 b=FHymS8xuqXF0QpsTKUEZKTsf+dp9Fl4wLCRbAJNul20VU+ZV5b5+ZISELDiIzm80Ea637WQrAhKPXD6acPPbcXzo3vmE/8WbWApwW94GluFASpVgd22cEMhb7rXrzCXxTJ7CKoipD/NrWdQ2LtYSmRTruBKqIJpUXS32sV6xwdQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20; Fri, 10 Dec 2021 02:52:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.013; Fri, 10 Dec 2021
 02:52:03 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Thread-Topic: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
Thread-Index: AQHX7R3v1iwa+CVypkGTJSNpw3lfa6wq+MPAgAAJxoCAAANjIA==
Date: Fri, 10 Dec 2021 02:52:03 +0000
Message-ID: <DM6PR12MB2619F67E8A6A3D230A5D6E52E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
 <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbK8lwgodK5VutKA@lang-desktop>
In-Reply-To: <YbK8lwgodK5VutKA@lang-desktop>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T02:52:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9b0d600b-344b-44dc-b86d-0cfe8e844957;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ecbe167-251c-432c-c842-08d9bb880bcd
x-ms-traffictypediagnostic: DM6PR12MB4297:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4297BB802497CA9AB1F77C18E4719@DM6PR12MB4297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 80VFIeD1dKdp8lbIM+m7ZhaFsjkgwZ95uo5/VMQARxNU7WgaRrM4ur60GxVwqef7KUz2gpqQ/EytJntZ/GwDufse8eHJZfWF3+r6aM9goy3pKquu2/WR0USLAn3MUpIOwBOw9lkdx/lxxu8VWcSRv1D/gJtrTAJVCy428+12xesqO4dDy4qyZJ+7U3KXoj0dBUGY2FpZWGUbf8vXIfQmtLG4D6Z+Uw2uM4TgnL67CAjCOygrxEOGAtFBIhdb7WIoEWs/T/k8YlIOU/zKLzSQpIyUKYdHcsvhUyiguBm6a4AGV2crFhWyCrP1KBfsce/vDUslENfPX0atBgHYdED+qJvdkG8/YW6auGUPmkB3dHKUedmMrFP1GpA1JhkF8249RtrVncxhkPtRJY2ujhBhy1PX4jNxPO4Qv8UfikCQaKdgaL+m3KaZ7k7v0d/KmuGP5czMW46n806NZ98w9DEo/l2pQeY3LYT+UZv1mmHFR5Wona9IDDDitjkDDXVEWlnHk+k4QmtgCQ+EyS+gWn7gkyd5t69UE+OGpX8mPgNT5MqS2e6SWKfZeQzjQMYIwepJONJj1W/m5+JntRz/zEdUas2r8erpksI7zHuGeuy9VxDSNOagXratrDiCAYwrgigI8BG7lYEbnUeN/P1SEAm5r706RiN7YNhWYQ3rvNGCb/KC4RmvGdhPAkPa0gP87YS4Rb2NlOTHvXOzIytFG4ta7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(4326008)(6506007)(2906002)(53546011)(38070700005)(6636002)(83380400001)(8936002)(86362001)(9686003)(7696005)(5660300002)(64756008)(8676002)(66446008)(38100700002)(508600001)(55016003)(6862004)(122000001)(76116006)(66476007)(186003)(52536014)(316002)(26005)(71200400001)(66556008)(33656002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bO8c8tcid1mvgwE/RDKN7zONEt+h4gUc9CR6B5zB/q89PjeCSKXsqXH6LZf6?=
 =?us-ascii?Q?YmWXI9SgxvX64FRmb9yxkZi9JTaZC+d2AIcn1yaKKrnPkeMW7q2SvODx3KFz?=
 =?us-ascii?Q?mh0umuxdU0H2roQNf4VOrgZmj3nfzfcArrWnfi9lYDWiQ6hktT0TUH8PcGTx?=
 =?us-ascii?Q?jmy4hgfOjDrp5C6gjSHLjES9Hy1uXLYZRcFBB6oMW7UVVArMfdRDlqkn3Dl7?=
 =?us-ascii?Q?iwTtBSDZSHitRZqVowIlqkC5cBdPz7OXAM+EDOjPmDGSURycj+i44fkvrN7K?=
 =?us-ascii?Q?5L4fwEYIovTzK0wAMSZIpn428xsKp114g16xiv1tvkZKJL7NPvmkXsbjUzbd?=
 =?us-ascii?Q?VaWjTeJ//oQ2SFbIJ8y9KWx7R8fT9DFzPMhyfSGPJh9wTTr1u5XvR2pIt98N?=
 =?us-ascii?Q?Udi9v0PW9OO695p6EHvDMR01Fuzq7iIepxegucFi9ge86nIePXojb3klqfZF?=
 =?us-ascii?Q?zSwQyAy3ctYCXVYbTFugHFxPwimJGURo4MZF8bTQ5csdl1YyYJXkaIebvQ0C?=
 =?us-ascii?Q?99yRh0nPqvNC0c0VIfA4TUnZn1A5ZXW1mbeO2vOba70tbj/8arTO2wFoBe10?=
 =?us-ascii?Q?aIXlmZask0k/MC339fRpplZOb+dGEcI3FpXSnm50ociCG+8+Hmt4iAqsQ2qv?=
 =?us-ascii?Q?GZHxeSly83IBA6k5RA1CcB9cO2RFEhF5CFAcXMysis6XAgO74HZZHDYSTYJA?=
 =?us-ascii?Q?XSuN5ZswycE8pj2T/LO56iDtzSBJmeM6b5oUulw9cg70OYHrb2Or5NeOu85v?=
 =?us-ascii?Q?ooQNVKOxuVBg89Z7iOR3N+zDSUh8mfNng97SGO53ENSBpvaoD8HO+8xhAvfm?=
 =?us-ascii?Q?kVjsHqvvSMj1F9yg+XRthkSCYZ+/7kERCgQKJ0j4OrDuOJ+ocXWrXING/xPN?=
 =?us-ascii?Q?74sED9EdLtLRJnInV7mL6nK6/9uKJCl/fwUsFdOUsz4ZBp89RQGCnb4Iw8r3?=
 =?us-ascii?Q?8p+8tGOLyy8m6iLiJuODob0pfET0NhBA/yYWHTJ5aSyZp2NwypRVQs/WKDGO?=
 =?us-ascii?Q?n5tc9liRfxXWa9g6o3ATRUXwD0Ga9J15OonHXI3vr//ZBG5xYHpH4iYDJ9ju?=
 =?us-ascii?Q?J76f8AcNTRUahWQGuZJTrbCgz69zQA3RBG0DDQe4vzYIGp7h0LZBoOUDTm5u?=
 =?us-ascii?Q?zRyPT+JE2jns0lcVrElsbHTCGLhf9o3Mc9BrPt1nvTwAoI7s2AswwXy1Xuu+?=
 =?us-ascii?Q?XoiRDC9cs9JLlxvpU1lMrZ1IjxKA0QlCbAldWOhBcWF/3eU0SaRs77o9MpNy?=
 =?us-ascii?Q?4VE+fXWcrRx8PRuvCtl4OPI3LkUmY0qZ70MZzCsaQLq07a916IQ86tF5jqCa?=
 =?us-ascii?Q?7/XP8HQ7NSBf4JclCBmogd4ZxqmbnAUgDCw683fvb51uAFPsfad+SEbX+fZJ?=
 =?us-ascii?Q?jzY3F1OAMZ/U7XSDSU+1UHbLUk3xyx62SJGz7+Ufus1UZmR6boc6jnIOIjXz?=
 =?us-ascii?Q?i5VnkVxNAoM5DZD3WpHrls1BpaUMg3WlmwvC3kPYNJ+B160nvwAx2wCoXXK3?=
 =?us-ascii?Q?bTtiL42OTYmVQuaYI8w2YzfQuRgOBlSl04kHv+mmXQJGaB1O6P4yJ/gSuuXM?=
 =?us-ascii?Q?Jyb/OZoyhL6pjIYubcs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecbe167-251c-432c-c842-08d9bb880bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:52:03.7138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/M8SSWZg5GY7F6PWxvkSDQ9mDtr2QhoG3V6rjGLrcF/BfWtId+dga9nTbNDMXoz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Friday, December 10, 2021 10:34 AM
> To: Quan, Evan <Evan.Quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
> <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang,
> Ray <Ray.Huang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
>=20
> On 12/10/ , Quan, Evan wrote:
> > [AMD Official Use Only]
> >
> >
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > Lang Yu
> > > Sent: Thursday, December 9, 2021 4:49 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
> > > <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> > > Alexander <Alexander.Deucher@amd.com>; Yu, Lang
> <Lang.Yu@amd.com>;
> > > Koenig, Christian <Christian.Koenig@amd.com>
> > > Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
> > >
> > > SMU firmware guys expect the driver maintains error context and
> > > doesn't interact with SMU any more when SMU errors occurred.
> > > That will aid in debugging SMU firmware issues.
> > >
> > > Add SMU debug option support for this request, it can be enabled or
> > > disabled via amdgpu_smu_debug debugfs file.
> > > When enabled, it brings hardware to a kind of halt state so that no
> > > one can touch it any more in the envent of SMU errors.
> > >
> > > Currently, dirver interacts with SMU via sending messages.
> > > And threre are three ways to sending messages to SMU.
> > > Handle them respectively as following:
> > >
> > > 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
> > >
> > >   Halt on any error.
> > >
> > > 2,
> smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
> > > for longer timeout cases
> > >
> > >   Halt on errors apart from ETIME. Otherwise this way won't work.
> > >
> > > 3, smu_cmn_send_msg_without_waiting() for no waiting cases
> > >
> > >   Halt on errors apart from ETIME. Otherwise second way won't work.
> > >
> > > After halting, use BUG() to explicitly notify users.
> > >
> > > =3D=3D Command Guide =3D=3D
> > >
> > > 1, enable SMU debug option
> > >
> > >  # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > >
> > > 2, disable SMU debug option
> > >
> > >  # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > >
> > > v4:
> > >  - Set to halt state instead of a simple hang.(Christian)
> > >
> > > v3:
> > >  - Use debugfs_create_bool().(Christian)
> > >  - Put variable into smu_context struct.
> > >  - Don't resend command when timeout.
> > >
> > > v2:
> > >  - Resend command when timeout.(Lijo)
> > >  - Use debugfs file instead of module parameter.
> > >
> > > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
> > >  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
> > >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
> > > +++++++++++++++++++-
> > >  3 files changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > index 164d6a9e9fbb..86cd888c7822 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct
> amdgpu_device
> > > *adev)
> > >  	if (!debugfs_initialized())
> > >  		return 0;
> > >
> > > +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
> > > +				  &adev->smu.smu_debug_mode);
> > > +
> > >  	ent =3D debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
> > >  				  &fops_ib_preempt);
> > >  	if (IS_ERR(ent)) {
> > > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > index f738f7dc20c9..50dbf5594a9d 100644
> > > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> > > @@ -569,6 +569,11 @@ struct smu_context
> > >  	struct smu_user_dpm_profile user_dpm_profile;
> > >
> > >  	struct stb_context stb_context;
> > > +	/*
> > > +	 * When enabled, it makes SMU errors fatal.
> > > +	 * (0 =3D disabled (default), 1 =3D enabled)
> > > +	 */
> > > +	bool smu_debug_mode;
> > [Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that
> in future we can add support for other debug features.
> > >  };
>=20
> OK.
>=20
> > >
> > >  struct i2c_adapter;
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > index 048ca1673863..84016d22c075 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > > @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
> > > smu_context *smu,
> > >  	__smu_cmn_send_msg(smu, msg_index, param);
> > >  	res =3D 0;
> > >  Out:
> > > +	if (unlikely(smu->smu_debug_mode) && res && (res !=3D -ETIME)) {
> > > +		amdgpu_device_halt(smu->adev);
> > > +		BUG();
> > [Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and
> Andrey can share you more insights about that.
> > Do we still need the "BUG()" then?
>=20
> The BUG() is used to explicitly notify users something went wrong.
> Otherwise userspace may not know immediately.
> FW guys request this in ticket.
[Quan, Evan] Won't drm_dev_unplug() and pci_disable_device() used in amdgpu=
_device_halt throw some errors(on user's further attempt to communicate wit=
h our driver)?
Also if the purpose is to raise user's concern, WARN() may be a more gentle=
 way?

BR
Evan
>=20
> Regards,
> Lang
>=20
> > BR
> > Evan
> > > +	}
> > > +
> > >  	return res;
> > >  }
> > >
> > > @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
> > > smu_context *smu,
> > >  int smu_cmn_wait_for_response(struct smu_context *smu)  {
> > >  	u32 reg;
> > > +	int res;
> > >
> > >  	reg =3D __smu_cmn_poll_stat(smu);
> > > -	return __smu_cmn_reg2errno(smu, reg);
> > > +	res =3D __smu_cmn_reg2errno(smu, reg);
> > > +
> > > +	if (unlikely(smu->smu_debug_mode) && res && (res !=3D -ETIME)) {
> > > +		amdgpu_device_halt(smu->adev);
> > > +		BUG();
> > > +	}
> > > +
> > > +	return res;
> > >  }
> > >
> > >  /**
> > > @@ -357,6 +370,11 @@ int
> smu_cmn_send_smc_msg_with_param(struct
> > > smu_context *smu,
> > >  	if (read_arg)
> > >  		smu_cmn_read_arg(smu, read_arg);
> > >  Out:
> > > +	if (unlikely(smu->smu_debug_mode) && res) {
> > > +		amdgpu_device_halt(smu->adev);
> > > +		BUG();
> > > +	}
> > > +
> > >  	mutex_unlock(&smu->message_lock);
> > >  	return res;
> > >  }
> > > --
> > > 2.25.1
