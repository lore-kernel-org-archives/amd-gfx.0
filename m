Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A735C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 16:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA98604DC
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 16:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BA98604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50C073106;
	Tue,  2 Nov 2021 16:09:09 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545AC73105
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 16:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjRJv5svDmZ6z3F5KMvbPqDbt8WmW1K85CZxpM0S0ZQGQpgArCs6xL0B0mBw0djGbJic0Wy3MJ4HdQlsx03lRmRFeFGWQLgKjRPcjMX3pX0priT6QIGELIQCJNSmimaP27aDZVfi9rRWbOoaZVXHEJPCbTuVwum0rXGGEGN3fvZpPlqYH8zx78rcZHo9iHyGGk6zwWaMnkwKntvrxyWQ+MHJyJROhDVVYoH+NIbwMiS4YTTmKf6hUJazZFp2dRV2OPhChBalVqojwKgUsea+u7rvbHe/T3893nKR+zoJ+Z6e8XUsXyRACpSpV8yjNqx0JQbmaVfYp+eXjkHrb8yIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1iCU4chp0/hXhENhH3nqmMVq56R6mwE69aZgLPvlI0=;
 b=IIE9b9el4inIsVRzw7r5Wphvwbe2pmLp8VIJn9Cv21a/slNzyWRyjF5gwGhqGLYdVRHq+HzHg3yHbwJCE1dr9vUUR/Wot89h8tLjGFDL8YXqgX5zdKLsaftI1AYuaSrZsrGBYrQx5RFlDdrVD/U72q9ebFCZsFuaMDCshwO42duW30bF/WNrzLVDomO2UVMcG9h30f4xDRmOkZPrscuHdV2lJUXk3/xGnH8Cwrygae6vFfNLMUdGrSXIyFWTILOetPxnl0H5eumIA7kpQDi7ONw/5CwfD2am6h5p2ygGTLINxn36nOhviN4cECQFHnlQGL0lyi56QtBQY5Ns/9Tt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1iCU4chp0/hXhENhH3nqmMVq56R6mwE69aZgLPvlI0=;
 b=Fl7T8GvIRjyhcw2nJLDTAvyrH/QtQUJZgOrimiPx+eTaGwFO1zN482AVGFG+LoDEWIZixNoB4+acfnyDBL8Pyj5NvmxuaDUEJ8T7SUvcCrwnB0V2enRD9HRgUixdlHzhHrkpDYgFI/rxGSz3mnG7DTn2wFW23zsdk3WeLj7zcIU=
Received: from DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 2 Nov
 2021 16:09:06 +0000
Received: from DM5PR1201MB0091.namprd12.prod.outlook.com
 ([fe80::f11e:37aa:e94d:d7ec]) by DM5PR1201MB0091.namprd12.prod.outlook.com
 ([fe80::f11e:37aa:e94d:d7ec%6]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 16:09:06 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>
Subject: RE: [PATCH v3] drm/amd/display: Look at firmware version to determine
 using dmub on dcn21
Thread-Topic: [PATCH v3] drm/amd/display: Look at firmware version to
 determine using dmub on dcn21
Thread-Index: AQHXz/sAK3Hxg1sprEuYUGWgL0J6cavwZMeAgAAC5tA=
Date: Tue, 2 Nov 2021 16:09:06 +0000
Message-ID: <DM5PR1201MB0091A33AAC118652C8D027DF898B9@DM5PR1201MB0091.namprd12.prod.outlook.com>
References: <20211102150437.19370-1-mario.limonciello@amd.com>
 <CADnq5_P6osKedfyZoENxx471hg7jbsjEfP=2n7rniDq2+fHp3A@mail.gmail.com>
In-Reply-To: <CADnq5_P6osKedfyZoENxx471hg7jbsjEfP=2n7rniDq2+fHp3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=79e156f8-1c7a-498c-aaf5-6ff1f58d818d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-02T16:08:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d241156-1ce5-4764-2ce9-08d99e1b1899
x-ms-traffictypediagnostic: DM6PR12MB4401:
x-microsoft-antispam-prvs: <DM6PR12MB44012AA33831FF6447B94D47898B9@DM6PR12MB4401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFHg4+rxkvphmEYwT5sRKpTK1egWDNp8quqyHJ2nT+4V40D4zSYjMvQ0Pni0rEGgWWNaP4cMP+M9z+ga4toq4FUaYTOLRBmwp9yO2RO1qBgj3xZBgCFTWXtZbDt/VlVrnxP8o15C0DCm7zqgGofXlJ820VPiOBKvfesmfv+YxnWlwFbFm2dkvDsb9OyNEK9qbv55LrwxtBDIn/y+bN0cUaSWrrOXwvI/U4HEvhJDb6sgBKxHU5tYCYdnwqr84JnzQUK11jUowW0pIWB+tLRcQenaoPfFDGtkJ7CfSrzc3QJQdvUuocIAYZiIsP8iWczmosn95s4HU/03gZI7JhJ2Z69rfYFuXotp7wPZ6/nGpt9RiU7yjNEaS//oQaV0hRnjVZ+LF31GdNYkHWE1MhSAuOnpl2pehBUiDDjffCqbCaIHZE9E7rdcWTuzfpjF3KvdU7cZG1sURAnuIF8FKHzElHpKi5CnjSPdjE/s0Z4x21KJa5sCPxd1T/t4khNG8RgaiQAjqsaRq44VrKJQ72dX76iaQez4874tu+Da+QVrY8tprQMwlNbtcc1F8042XZ93lH2ZJOlAFU+TkN+5JazmgkR45Tfu1l0WQQNb7bDvs0QmZ+fx06401jQpnuPgzQ/u7AChDPm5l3x/Y8VMNpHxyWMQeVOtgbNdpfUHFNFGwvGMH+NxQ2WkS7LqJvcQi2GCojoS5OddtFz/ETkSqd2/LbOsek1TtXWijDnLFhns7llLLdls5f9scoZFsTdGk0DKEpzxlQgXtb3exHXqhTlGQHGcPVK7Emeg0GNWalrnKHU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(966005)(26005)(122000001)(5660300002)(52536014)(38070700005)(8676002)(86362001)(186003)(316002)(76116006)(9686003)(110136005)(55016002)(38100700002)(33656002)(4326008)(71200400001)(53546011)(64756008)(2906002)(8936002)(66476007)(7696005)(83380400001)(66946007)(66446008)(45080400002)(6636002)(66556008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wg3+IWf4BUU0HTYNKKGY83ppkVwT2dgcDad5d1NRPB7lZ+WvtXDbKYiD1+x4?=
 =?us-ascii?Q?2DRqO9YlQP4FR3BwkF7wWywfP2CQk1efzuWypcFi3IhJvuTzEiS0di7fh5dH?=
 =?us-ascii?Q?R+JbacoW49JKhoY/iZ8jJGEghXokFqtAx4WeU/M3hXdkBLSx5clIann2uNbg?=
 =?us-ascii?Q?UWLhiLKEsDqp1Beihdkuf2TUELtsEo4Ir0nPgRRuMvgSkkr5cbv9wj+lCXTM?=
 =?us-ascii?Q?EO+Qhxjkz2ou/ncPC5vXSYnalHWbsN6ADMHixfi5gkedOl6hArDznDiTWBa+?=
 =?us-ascii?Q?yeRF4EcV2l7kBLms4ORJeaujfXT3q812FsbCe/ej/zpIwXpf7zKzdIqJN6+8?=
 =?us-ascii?Q?c71ygbulNSTU9bCchxLGVCI2I+V0r/fMfx3ulHk+EXVRD86v7ZdSa71dSaHK?=
 =?us-ascii?Q?pfzlJ8YIaXcaEKxcZPveOqey4NimHwSYJD5QnLzqNekaesPiwYYDmOGX/IaL?=
 =?us-ascii?Q?mWv9oLWBelWSEwdmYL2vKO1djI3zFv/wAxphzFlBMl81Q5YHVamhl+lpQg2Z?=
 =?us-ascii?Q?2uZu0qtYx50e7FX20q4SmQ8v4CeyZ48pF3tVbHWtIdV4yGaCgQPZ/9n8f02T?=
 =?us-ascii?Q?IMJ3D5uc48TuJYt4EQbUcxyrVkG1t4ttUHs7pe/7goDjfoxNSlWapoOQ9RBI?=
 =?us-ascii?Q?KoaNSdN5RMhEJn4xBxXu2hxu2BF1cTKxtG4Vy1vwlVoPjwOXiiGfcG1B9O9B?=
 =?us-ascii?Q?yDhv69mnJO3/Xbk2Lo6rxBgEfYcE/r4dn1lAwqTc7p/puTe3CobF/iNSrbVh?=
 =?us-ascii?Q?dPiF+mpJDU/8fyJYG3JjX6mCyVh/iVlQ0S2LBBoJsICrDkdhFusNf5/TfQSM?=
 =?us-ascii?Q?Zc5RFBSegCfd2OVXj6HACMGfUZvgLn7EU1x+NrLBhg85ojFB56Yf5pQaQIhH?=
 =?us-ascii?Q?kPeDXZ8S3/apgSKqka4kaMYaNV8Njs9mlebRJ2IAM+uxNYu4e4PODQdhnU9N?=
 =?us-ascii?Q?2kX3BZLOTTbg1wV7CiLxVFz4IkJ/t4axgcuJAD3VgPb5Uv506PlhQvkFTzba?=
 =?us-ascii?Q?wlA5j7dov1+uUwpU95wc2VvwL0ToM0oKJZq5Y3gdYIX8Qo1dcYWD+5J9d+jY?=
 =?us-ascii?Q?R2xMNSP6HBOLPL/BDvLI4uX4o8wPdjuydM36ylAB8MRzlLe4KOkvMSc8V0XI?=
 =?us-ascii?Q?HurIaKfIGsCM32cIE0HlIUaEX5Fbn1T9rxk7DqKiy4z+6iyRug5134SAemdJ?=
 =?us-ascii?Q?XzVr6n7x18eY5f4/reMZh2byzP2txDbzYC0WxAsCUyUcejbJFmeZtZg51fXi?=
 =?us-ascii?Q?yibdKeqEwRfYuRWZ+lG866QcNq1ff+LbGxGA9l+5GY20svazL4AMOnVLVWcv?=
 =?us-ascii?Q?0yuwXOZ1u+kUQRe6oT1HdBg1FCs+cL3STRIAySL1nQjte1j8mmbAKhTQYaRu?=
 =?us-ascii?Q?UQCMnGReJG/rOlJBmDDN92yv6K9pzF8yYYCHsxsiMZYjpcTZSHZWUpmPDaRg?=
 =?us-ascii?Q?j+4NveOa4L4Vmn9OyRcsLvvYbshXgkTPvCWOwbzssEJ4uExthb4gWUf/HObC?=
 =?us-ascii?Q?ledwgjLgwmOCiQO7wjZD198KWf6aL0XN53R64Achw5o2HI1wN8huGMu3MG4J?=
 =?us-ascii?Q?2iOGe8PT4jFj7AIFtLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d241156-1ce5-4764-2ce9-08d99e1b1899
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 16:09:06.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmsN1jOigW3tsMe9SDj7hLNY3zWwvjnjR355j8q4wnDp1bOJMJHZrqooUJvCacwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Roman Li <Roman.Li@amd.com>

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Tuesday, November 2, 2021 11:58 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Li, Roman
> <Roman.Li@amd.com>
> Subject: Re: [PATCH v3] drm/amd/display: Look at firmware version to
> determine using dmub on dcn21
>
> On Tue, Nov 2, 2021 at 11:04 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > commit b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > dcn21
> > asics") switched over to using dmub on Renoir to fix Gitlab 1735, but
> > this implied a new dependency on newer firmware which might not be met
> > on older kernel versions.
> >
> > Since sw_init runs before hw_init, there is an opportunity to
> > determine whether or not the firmware version is new to adjust the beha=
vior.
> >
> > Cc: Roman.Li@amd.com
> > BugLink:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1772&amp;data=3D04%7C01%7C
> >
> Roman.Li%40amd.com%7C29e4fd818a2446e0cf5208d99e198897%7C3dd8961f
> e4884e
> >
> 608e11a82d994e183d%7C0%7C0%7C637714654774196023%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C1000&amp;sdata=3DNrV1aszBAZkJ%2FQELpzxx7NCKXjWKPEvgk6rEAwfhWYk%3D
> &amp;r
> > eserved=3D0
> > BugLink:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1735&amp;data=3D04%7C01%7C
> >
> Roman.Li%40amd.com%7C29e4fd818a2446e0cf5208d99e198897%7C3dd8961f
> e4884e
> >
> 608e11a82d994e183d%7C0%7C0%7C637714654774196023%7CUnknown%7CT
> WFpbGZsb3
> >
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >
> C1000&amp;sdata=3DEqjhSIwtkgo%2BtJFwUkf%2FDTY4RiSNVSh8DjXLu7LAszM%3
> D&amp
> > ;reserved=3D0
> > Fixes: b1c61212d8dc ("drm/amd/display: Fully switch to dmub for all
> > dcn21 asics")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> > Changes from v2->v3:
> >  * Don't special case Green Sardine / Renoir anymore
> >  * Special case the two Renoir firmware that have this problem
> >    (that weren't released for green sardine)
> >  * Special case development version of ucode version
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b48f3cb5ddeb..dcc97ef28c50 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1410,7 +1410,15 @@ static int amdgpu_dm_init(struct amdgpu_device
> *adev)
> >                 switch (adev->ip_versions[DCE_HWIP][0]) {
> >                 case IP_VERSION(2, 1, 0):
> >                         init_data.flags.gpu_vm_support =3D true;
> > +                       switch (adev->dm.dmcub_fw_version) {
> > +                       case 0: /* development */
> > +                       case 0x1: /* linux-firmware.git hash 6d9f399 */
> > +                       case 0x01000000: /* linux-firmware.git hash 9a0=
b0f4 */
> > +                               init_data.flags.disable_dmcu =3D false;
> > +                               break;
> > +                       default:
> >                                 init_data.flags.disable_dmcu =3D true;
> > +                       }
> >                         break;
> >                 case IP_VERSION(1, 0, 0):
> >                 case IP_VERSION(1, 0, 1):
> > --
> > 2.25.1
> >
