Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AE5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 16:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60B310E6F4;
	Mon, 28 Mar 2022 16:23:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA62A10E6F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 16:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs0kkeS0JyeHZzChIl7s5cpI7QzYsBCctOXu6DBIOyPrzes1XDujkP8d4yH4YXyVO9kLwJfIoRctfBS7Z/xKb85HlJ3Sq6Q8WdBW1j0hBL0kZdBFGwe4HWFXZPhTw1TEzbUTyMJ+YF/qLpthqqC3a+VToEiA0Iv7S8ghA1sN7k0WzFIwGLSBXiL+IFkJ20aMe/KFA5otRsY5dZhkUjgngHAMJ2lybNZrtyTVXKYYT1lMWe5cL87iWgeRsM8Tf4ABdhSnwj+ytXhuH4Gn9CfUMto/wqDZMPn8wlVdBfoQ4nZo+gloLzxtgGi+7iseVUeY/QwC334OyhdR5bNqlfHbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7RzNDI2Rf5sJS4QdFUK1gh+kEJBqnyesTuvZOVDOvM=;
 b=kyn1cCiOLadzHKwk2ctdmohSZBaFHGHWH0LkQyeEpf0wli8e5zqW1j/N1q+GMcY/tMwz6qNv93Xgkf+LNcJcJA4xPUteFom+k27BZ2m7enjev0/Hu+pRNQwnNtRdQDuoxjaiReQ6jhRkyKkKrJAYqau24LG8RhQy/vHxHVnVhD1xStlxmT35zO6FANFVnuM2KtT1MJG9xAomhJlOXkiOoEtHD2QEiyaiQ57HUJ4BoaAmCSWIe85MrKf2cHuIWe2eGk9ln4+XaFsCiNXR9jq4j0pHY1CX/qv2fh6WpzazcJLFmsV+Zex1rqaN1jngoMugaBY0OspTWQMR4edwMyTPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7RzNDI2Rf5sJS4QdFUK1gh+kEJBqnyesTuvZOVDOvM=;
 b=nWPNlpO0OwiHtOb5Msy0u3p436587Efe/Q0JabPvzkcB7xqn3GbLSRIXYceRg7JPZdZbYwY4WZ+UZOdwjAhSh04w0RFkutsdsHYzK0jetT+KgzldydsFN80zxcjT3tL2iuaKEDZmrpPAygWQVY6WZXerGekSOfCgmTtLCXTtRPc=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Mon, 28 Mar 2022 16:23:14 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::e05f:3a9a:b740:aa75]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::e05f:3a9a:b740:aa75%10]) with mapi id 15.20.5102.023; Mon, 28 Mar
 2022 16:23:14 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichlid
Thread-Index: AQHYQrETM9TbriXgqkWwcn6XPgnv7qzU6IsAgAAF2MCAAALEgIAAAGZggAAFBQCAAAPToA==
Date: Mon, 28 Mar 2022 16:23:14 +0000
Message-ID: <DM5PR12MB1308E62E8701830E28ACD382851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220328143518.1253762-1-kent.russell@amd.com>
 <20220328143518.1253762-2-kent.russell@amd.com>
 <80529a89-effc-368a-da12-14d7e44c860d@amd.com>
 <DM5PR12MB1308FBF96617FF1DDE124158851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <c319f4e0-c01a-d355-9878-7f09a5f33b49@amd.com>
 <DM5PR12MB1308F91A509695ECB9CA6C8B851D9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB46143E0A5A0F64D2BCBA68B5971D9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T15:49:54.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb4d09c9-db4c-462c-4ed2-08da10d7425d
x-ms-traffictypediagnostic: BN8PR12MB3108:EE_
x-microsoft-antispam-prvs: <BN8PR12MB3108FF75C62ACD26B98DB286851D9@BN8PR12MB3108.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MqzYsvxLOwzzoEHIFnd0jFY6Y4Jjwmod6iFK/arTjBCaT+qZI58h/rtdp01xLTbQqGVyk9ActmZO0EO/xiT/4bjfO20Fy8/otPWQeim9zX/NrkmggijHRZLe82OpCK/GbtnR6z5zXT/YeNw6UHgXnza2Bgb6gJVd4XLlx4+jeFmHdqU7M3O2p02OjA7pEboLNzFpM5Jnw1mVRaiEgdcySBc0XLMC511g9BlZBBgF3KPe3htASrWWoblYJLzAnr/y7waQSKijeB7vYnYF/H/BACYCmANGqrHDXKxBLxah3j3Sl/e+Qr9nz+Pv9hh3r9D0rKBwt/8HY7uhII5vUKhBDDSzEDJyh1PU57Mi3RDSGQCoEcQ360dlCO5EN1F7IaJkewHNQx8i08jMUWp2yZBVxtaaQZuqUeH8SzrPkaOCCrdzrQMxSe7U30kul3J3yWV/qsrIKOinQmjMaNab/Pn+EMS3MbqRlUfxzM2xN8PY5lMT3/OzNqXRCgC+UaIprV3M3sF56tQpkHb0EiHb+1I5cda2olesxMPXVk4Rd6X0HtXuXiPl5+b7Pqkn9ve0E5J0Kw57DmAlejdt3NQFKsh3i89oGgltDd4blzVCzyCDxzff7nqlmedo4O6vj6OoYoYsdpqudQLQqDELkKcGJ6cSxBUDeTS/iIRGUfc57RtH12H+TexU06vIIs1Z/fTKkqJu/qrTJAzXH9FEIiwD6KMqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(110136005)(186003)(26005)(316002)(2906002)(86362001)(33656002)(55016003)(38070700005)(52536014)(122000001)(53546011)(9686003)(66556008)(64756008)(66446008)(7696005)(6506007)(5660300002)(66476007)(8936002)(38100700002)(8676002)(71200400001)(66946007)(76116006)(4326008)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zlLGzKn2n5rdZhAeSi//Z/rv99u8PGRhtC35fdgNSWj+S5BkpZxtsA3GLFas?=
 =?us-ascii?Q?Or16MrAYsu48DL8KQCfdhIQw4D7lzQYIjBxUKhwpeJ3e8YG2BIgk8+FxCst6?=
 =?us-ascii?Q?DGiNmEkheCYcDlb/0XSCLAkv0NzvYg2TphmXgFuZi494Yi3DX5SNmKxLXvOi?=
 =?us-ascii?Q?R2YUkJHjl0ky4sUaTU/npbyo0tIQGgIbgjHs2kJrUL3mY9dMYFMGVOmkrt3h?=
 =?us-ascii?Q?EPHm2Na4QO2IcRAGrfLv3/sVTQHdCqIBAoKANpJxOD9/NBnGf2rht0aSOqpT?=
 =?us-ascii?Q?A0fhI/1EqhqfulFZJ6H9hnUpV5RHX/RDSRh8FscfseLkwo/JYeX3Jp1gO0/Y?=
 =?us-ascii?Q?UFlt8y7rF4WYbMHUEIuOT2IfHH5Cfurr+0F8910op6Wq3pwZ5hxGUe7zSVct?=
 =?us-ascii?Q?Z3u/wFony46sTBAMAGzh5mAD9I5O8K5YqiXJyzXNZqrkIFplFUtzSiSIcJtY?=
 =?us-ascii?Q?RoA5TqsoTgqv7NbyHmyYJrstGYKCwKojfNp0Qox1fQWqNUOu9B2thcli7WAI?=
 =?us-ascii?Q?kY5sUAlG8hEsDEt8y1alxUZPFdw4hNu18hNnYVnErY/rbm4XoDxjzqXeeoA7?=
 =?us-ascii?Q?dW0NV6qf5UYlVvERLrWTEEEcfQx+DFei3+PfnXz3qoVLnwY5vcv2dD5qG93g?=
 =?us-ascii?Q?9TdsHzXUnIj56ivNohgA7b7ItY27WUzvLp00Qxn6kz+1jtSqFjw8TR/jlj3N?=
 =?us-ascii?Q?b6pOupikZa4NK6OKkBBWvjXLLOV5LLPKOe/2rY3fscym3/LjLXQndxgMmcFn?=
 =?us-ascii?Q?EkShxiu371n/p4lVudq/9IkjQv30PVnLkgcWKOzhunKwSOG0JzAdbTLfZHl2?=
 =?us-ascii?Q?bJN7d2m3OkasJPRAsYJgyVT1lfDcAcHrrC2LrVmgJy0j4QeDEf/D+HN+OTqC?=
 =?us-ascii?Q?EQ0DP/Z15gTUF96W4wJn6qWkbQrd7L4e07kiyNo6qN9EiM+6UnfUsKYuSXvq?=
 =?us-ascii?Q?a0EYcc7Zpx1e2ZJ/AtWd/CZ2PAwxOcM4l8h0dhYfPXE6pxKxkocx4p0a3MhK?=
 =?us-ascii?Q?gu5Gp8Kh4q2iUM41yJUY/Y7KVEpMyDom31wqPh5dsoxzO7GuqhJRpLsYlhWS?=
 =?us-ascii?Q?MdeN2J7ieEsjZFHJ23rjaKOKyZKswetPNC8uZEjPAFKCRrBeOUhO+a5/piq+?=
 =?us-ascii?Q?ZIQKbJQALH7FM+Gp0Vzak/d833kBHF8fZu4PgT86m5gub7eOnvAxq9PXPMey?=
 =?us-ascii?Q?pesWd15XwZqDlQV23XxBJLiWQ52nam9dCIgVUl13/7OZUyL8JpHlR4vonAgQ?=
 =?us-ascii?Q?iWfXR/FEellqhviYYSh3CrLTVjMOIaw4aYxDvyKJsN7pCHahTCagZAvmkDyt?=
 =?us-ascii?Q?iH5fGrq+bFI30dksoF6PhThIXSV5JPyYJ93P8krOBLByYFLQLP99yJ1JUMa0?=
 =?us-ascii?Q?Xrgo8lNm7CiRBiajLwD2VQHjcEsQFOlH1zEbkNFpveYwTMRwjDPEHiX2FZIA?=
 =?us-ascii?Q?LD4s0IxlNDP23nYRTrw9P4/FEYFLwVdBGOFq/YPT1oWpu9T0zZwiK7fXqzcn?=
 =?us-ascii?Q?biPkkdS7dcJhedr+k8MbwHzbw7WyGL7CY3N/O3H01pp0OkZ9dm6NryqGMsGv?=
 =?us-ascii?Q?LU+CwtEK+6/8IvfK9NbCstT88DlsUNuGocN1piVHa/JC11lKsQVeFYEqILfg?=
 =?us-ascii?Q?FkLdwEnj9610ssCaP4eP9WpayTVbpVRbVG6pM0o4zxcFSOUIpMWN8T3R5wdG?=
 =?us-ascii?Q?89z1RjMIbgBndNRGdIvlRXyprVsDdzwSC5Z/Ju42kstxcsEe?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB1308E62E8701830E28ACD382851D9DM5PR12MB1308namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4d09c9-db4c-462c-4ed2-08da10d7425d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 16:23:14.2364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: naMzZeOOS99WAZQ63LCSUPlugLyghR4hzMN0BrQlWr+ozANqMOCFfr3l2ormhNSZCV8POBcrfzp6EkL5vGtWOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB1308E62E8701830E28ACD382851D9DM5PR12MB1308namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thanks Lijo, I'll do another revision to drop the PMFW ticket (I saw it hig=
her up and thought it was standard practice). Once the PMFW gets officially=
 released I'll test it out and make sure that it doesn't get corrupted. I w=
ould assume that it would continue to work, but it's been a while since it =
was first confirmed by the PMFW dev I was working with.

Kent

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 28, 2022 12:08 PM
To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichl=
id


[AMD Official Use Only]

Yes, that check looks good.

A couple of other things -

PMFW ticket as a comment is not needed.
I remember Satish updating the same struct for smartshift related data. Som=
e additional fields added towards the end. Not sure if Sienna struct also c=
arries those fields. Regardless, you may check if that affects the placemen=
t of serial number fields (whether before or after those fields).


Thanks,
Lijo
________________________________
From: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>
Sent: Monday, March 28, 2022 9:23:36 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cichl=
id

[AMD Official Use Only]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> Sent: Monday, March 28, 2022 11:48 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>
> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna cic=
hlid
>
>
>
> On 3/28/2022 9:12 PM, Russell, Kent wrote:
> > [AMD Official Use Only]
> >
> > Responses inline
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Monday, March 28, 2022 11:18 AM
> >> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>;=
 amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deu=
cher@amd.com>>
> >> Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna =
cichlid
> >>
> >>
> >>
> >> On 3/28/2022 8:05 PM, Kent Russell wrote:
> >>> This is being added to SMU Metrics, so add the required tie-ins in th=
e
> >>> kernel. Also create the corresponding unique_id sysfs file.
> >>>
> >>> v2: Add FW version check, remove SMU mutex
> >>> v3: Fix style warning
> >>>
> >>> Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell=
@amd.com>>
> >>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander=
.deucher@amd.com>>
> >>> ---
> >>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
> >>>    .../pmfw_if/smu11_driver_if_sienna_cichlid.h  | 12 +++++--
> >>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 36 +++++++++++++++=
++++
> >>>    3 files changed, 47 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> index 4151db2678fb..4a9aabc16fbc 100644
> >>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >>> @@ -1993,6 +1993,7 @@ static int default_attr_update(struct amdgpu_de=
vice *adev,
> >> struct amdgpu_device_
> >>>              case IP_VERSION(9, 4, 0):
> >>>              case IP_VERSION(9, 4, 1):
> >>>              case IP_VERSION(9, 4, 2):
> >>> +           case IP_VERSION(10, 3, 0):
> >>>                      *states =3D ATTR_STATE_SUPPORTED;
> >>>                      break;
> >>>              default:
> >>> diff --git
> >> a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h
> >> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h
> >>> index 3e4a314ef925..58f977320d06 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna=
_cichlid.h
> >>> +++
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cichlid=
.h
> >>> @@ -1419,8 +1419,12 @@ typedef struct {
> >>>      uint8_t  PcieRate               ;
> >>>      uint8_t  PcieWidth              ;
> >>>      uint16_t AverageGfxclkFrequencyTarget;
> >>> -  uint16_t Padding16_2;
> >>>
> >>> +  //PMFW-8711
> >>> +  uint32_t PublicSerialNumLower32;
> >>> +  uint32_t PublicSerialNumUpper32;
> >>> +
> >>> +  uint16_t Padding16_2;
> >>>    } SmuMetrics_t;
> >>>
> >>>    typedef struct {
> >>> @@ -1476,8 +1480,12 @@ typedef struct {
> >>>      uint8_t  PcieRate               ;
> >>>      uint8_t  PcieWidth              ;
> >>>      uint16_t AverageGfxclkFrequencyTarget;
> >>> -  uint16_t Padding16_2;
> >>>
> >>> +  //PMFW-8711
> >>> +  uint32_t PublicSerialNumLower32;
> >>> +  uint32_t PublicSerialNumUpper32;
> >>> +
> >>
> >> Is this the case for other ASICs also which share the metrics data wit=
h
> >> Sienna?
> >
> > No, only for Sienna Cichlid. The PMFW guys didn't implement it for Navy=
 Flounder or
> Dimgrey Cavefish.
> >
> >>
> >>> +  uint16_t Padding16_2;
> >>>    } SmuMetrics_V2_t;
> >>>
> >>>    typedef struct {
> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> index 38f04836c82f..550458f6246a 100644
> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >>> @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_pptable(struct s=
mu_context
> >> *smu)
> >>>      return sienna_cichlid_patch_pptable_quirk(smu);
> >>>    }
> >>>
> >>> +static void sienna_cichlid_get_unique_id(struct smu_context *smu)
> >>> +{
> >>> +   struct amdgpu_device *adev =3D smu->adev;
> >>> +   struct smu_table_context *smu_table =3D &smu->smu_table;
> >>> +   SmuMetrics_t *metrics =3D
> >>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->S=
muMetrics);
> >>> +   SmuMetrics_V2_t *metrics_v2 =3D
> >>> +           &(((SmuMetricsExternal_t *)(smu_table->metrics_table))->S=
muMetrics_V2);
> >>> +   uint32_t upper32 =3D 0, lower32 =3D 0;
> >>> +   bool use_metrics_v2;
> >>> +   int ret;
> >>> +
> >>> +   /* Only supported as of version 0.58.83.0 */
> >>> +   if (smu->smc_fw_version < 0x3A5300)
> >>> +           return;
> >>> +
> >>
> >> Since this is shared with other ASICs, I guess this check itself may n=
ot
> >> be enough. This function may be skipped if it's not MP1 11.0.7 or GC 1=
0.3.0?
> >>
> >
> > Since the sysfs file is only supported on Sienna Cichlid (10.3.0), is i=
t a concern since the tie-
> in won't exist on the other SMU11-based ASICs? And this function is only =
referenced by
> sienna_cichlid, unless I misunderstood something (and someone else uses
> sienna_cichlid_tables_init).
> >
>
> This function also gets called as part of common init sequence -
> smu_get_unique_id.
> If PMFW version of Navi Flounder/Dimgrey ASIC is greater than Sienna,
> then it may go to the path which is not intended to be executed on that
> ASIC.

Would it be sufficient to just confirm the IP_VERSION here too then?
 e.g.
/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid (GC 10=
.3.0)*/
if (smu->smc_fw_version < 0x3A5300 || adev->ip_versions[GC_HWIP][0] !=3D IP=
_VERSION(10, 3, 0))
          return;

Thus the FW has to be that version, and the IP_VERSION has to be 10.3 ? Or =
is there a better method to use? Thanks!

 Kent

>
> Thanks,
> Lijo
>
> >   Kent
> >
> >> Thanks,
> >> Lijo
> >>
> >>> +   ret =3D smu_cmn_get_metrics_table(smu, NULL, false);
> >>> +   if (ret)
> >>> +           goto out_unlock;
> >>> +
> >>> +   use_metrics_v2 =3D ((smu->adev->ip_versions[MP1_HWIP][0] =3D=3D I=
P_VERSION(11, 0,
> >> 7)) &&
> >>> +           (smu->smc_fw_version >=3D 0x3A4300)) ? true : false;
> >>> +
> >>> +   upper32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumUpper32 :
> >>> +                              metrics->PublicSerialNumUpper32;
> >>> +   lower32 =3D use_metrics_v2 ? metrics_v2->PublicSerialNumLower32 :
> >>> +                              metrics->PublicSerialNumLower32;
> >>> +
> >>> +out_unlock:
> >>> +
> >>> +   adev->unique_id =3D ((uint64_t)upper32 << 32) | lower32;
> >>> +   if (adev->serial[0] =3D=3D '\0')
> >>> +           sprintf(adev->serial, "%016llx", adev->unique_id);
> >>> +}
> >>> +
> >>>    static int sienna_cichlid_tables_init(struct smu_context *smu)
> >>>    {
> >>>      struct smu_table_context *smu_table =3D &smu->smu_table;
> >>> @@ -4182,6 +4217,7 @@ static const struct pptable_funcs sienna_cichli=
d_ppt_funcs =3D {
> >>>      .get_ecc_info =3D sienna_cichlid_get_ecc_info,
> >>>      .get_default_config_table_settings =3D
> >> sienna_cichlid_get_default_config_table_settings,
> >>>      .set_config_table =3D sienna_cichlid_set_config_table,
> >>> +   .get_unique_id =3D sienna_cichlid_get_unique_id,
> >>>    };
> >>>
> >>>    void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
> >>>

--_000_DM5PR12MB1308E62E8701830E28ACD382851D9DM5PR12MB1308namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"ProgId" content=3D"Word.Document">
<meta name=3D"Generator" content=3D"Microsoft Word 15">
<meta name=3D"Originator" content=3D"Microsoft Word 15">
<link rel=3D"File-List" href=3D"cid:filelist.xml@01D8429E.97E62CE0"><link r=
el=3D"Edit-Time-Data" href=3D"cid:editdata.mso"><!--[if !mso]><style>v\:* {=
behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:SpellingState>Clean</w:SpellingState>
<w:DocumentKind>DocumentEmail</w:DocumentKind>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:DoNotExpandShiftReturn/>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<m:mathPr>
<m:mathFont m:val=3D"Cambria Math"/>
<m:brkBin m:val=3D"before"/>
<m:brkBinSub m:val=3D"&#45;-"/>
<m:smallFrac m:val=3D"off"/>
<m:dispDef/>
<m:lMargin m:val=3D"0"/>
<m:rMargin m:val=3D"0"/>
<m:defJc m:val=3D"centerGroup"/>
<m:wrapIndent m:val=3D"1440"/>
<m:intLim m:val=3D"subSup"/>
<m:naryLim m:val=3D"undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"false" DefSem=
iHidden=3D"false" DefQFormat=3D"false" DefPriority=3D"99" LatentStyleCount=
=3D"376">
<w:LsdException Locked=3D"false" Priority=3D"0" QFormat=3D"true" Name=3D"No=
rmal"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 3"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 4"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 5"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 6"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 7"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 8"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" QFormat=3D"true" Name=3D"heading 9"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index 9"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 1"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 2"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 3"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 4"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 5"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 6"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 7"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 8"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"toc 9"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Normal Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footnote text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"header"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footer"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"index heading"/>
<w:LsdException Locked=3D"false" Priority=3D"35" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" QFormat=3D"true" Name=3D"caption"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"table of figures"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"envelope address"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"envelope return"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"footnote reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"line number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"page number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"endnote reference"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"endnote text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"table of authorities"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"macro"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"toa heading"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Bullet 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Number 5"/>
<w:LsdException Locked=3D"false" Priority=3D"10" QFormat=3D"true" Name=3D"T=
itle"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Closing"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Signature"/>
<w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"true" UnhideW=
henUsed=3D"true" Name=3D"Default Paragraph Font"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"List Continue 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Message Header"/>
<w:LsdException Locked=3D"false" Priority=3D"11" QFormat=3D"true" Name=3D"S=
ubtitle"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Salutation"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Date"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text First Indent"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text First Indent 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Note Heading"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Body Text Indent 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Block Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Hyperlink"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"FollowedHyperlink"/>
<w:LsdException Locked=3D"false" Priority=3D"22" QFormat=3D"true" Name=3D"S=
trong"/>
<w:LsdException Locked=3D"false" Priority=3D"20" QFormat=3D"true" Name=3D"E=
mphasis"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Document Map"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Plain Text"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"E-mail Signature"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Top of Form"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Bottom of Form"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Normal (Web)"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Acronym"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Address"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Cite"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Code"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Definition"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Keyboard"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Preformatted"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Sample"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Typewriter"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"HTML Variable"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"annotation subject"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"No List"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Outline List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Simple 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Classic 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Colorful 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Columns 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Grid 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 4"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 5"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 7"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table List 8"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table 3D effects 3"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Contemporary"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Elegant"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Professional"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Subtle 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Subtle 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Web 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Table Web 2"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Balloon Text"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"Table Grid"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Placeholder Te=
xt"/>
<w:LsdException Locked=3D"false" Priority=3D"1" QFormat=3D"true" Name=3D"No=
 Spacing"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1"/=
>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2"/=
>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading"/=
>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
1"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
1"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" Name=3D"Revision"/>
<w:LsdException Locked=3D"false" Priority=3D"34" QFormat=3D"true" Name=3D"L=
ist Paragraph"/>
<w:LsdException Locked=3D"false" Priority=3D"29" QFormat=3D"true" Name=3D"Q=
uote"/>
<w:LsdException Locked=3D"false" Priority=3D"30" QFormat=3D"true" Name=3D"I=
ntense Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 1=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 1"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
2"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
2"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 2=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 2"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
3"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
3"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 3=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 3"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
4"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
4"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 4=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 4"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
5"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
5"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 5=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 5"/>
<w:LsdException Locked=3D"false" Priority=3D"60" Name=3D"Light Shading Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"61" Name=3D"Light List Accent =
6"/>
<w:LsdException Locked=3D"false" Priority=3D"62" Name=3D"Light Grid Accent =
6"/>
<w:LsdException Locked=3D"false" Priority=3D"63" Name=3D"Medium Shading 1 A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"64" Name=3D"Medium Shading 2 A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"65" Name=3D"Medium List 1 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"66" Name=3D"Medium List 2 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"67" Name=3D"Medium Grid 1 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"68" Name=3D"Medium Grid 2 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"69" Name=3D"Medium Grid 3 Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"70" Name=3D"Dark List Accent 6=
"/>
<w:LsdException Locked=3D"false" Priority=3D"71" Name=3D"Colorful Shading A=
ccent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"72" Name=3D"Colorful List Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"73" Name=3D"Colorful Grid Acce=
nt 6"/>
<w:LsdException Locked=3D"false" Priority=3D"19" QFormat=3D"true" Name=3D"S=
ubtle Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"21" QFormat=3D"true" Name=3D"I=
ntense Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"31" QFormat=3D"true" Name=3D"S=
ubtle Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"32" QFormat=3D"true" Name=3D"I=
ntense Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"33" QFormat=3D"true" Name=3D"B=
ook Title"/>
<w:LsdException Locked=3D"false" Priority=3D"37" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" Name=3D"Bibliography"/>
<w:LsdException Locked=3D"false" Priority=3D"39" SemiHidden=3D"true" Unhide=
WhenUsed=3D"true" QFormat=3D"true" Name=3D"TOC Heading"/>
<w:LsdException Locked=3D"false" Priority=3D"41" Name=3D"Plain Table 1"/>
<w:LsdException Locked=3D"false" Priority=3D"42" Name=3D"Plain Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"43" Name=3D"Plain Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"44" Name=3D"Plain Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"45" Name=3D"Plain Table 5"/>
<w:LsdException Locked=3D"false" Priority=3D"40" Name=3D"Grid Table Light"/=
>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark"=
/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"Grid Table 1 Light=
 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"Grid Table 2 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"Grid Table 3 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"Grid Table 4 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"Grid Table 5 Dark =
Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"Grid Table 6 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"Grid Table 7 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark"=
/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 1"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 2"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 3"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 4"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 5"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"46" Name=3D"List Table 1 Light=
 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"47" Name=3D"List Table 2 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"48" Name=3D"List Table 3 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"49" Name=3D"List Table 4 Accen=
t 6"/>
<w:LsdException Locked=3D"false" Priority=3D"50" Name=3D"List Table 5 Dark =
Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"51" Name=3D"List Table 6 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"52" Name=3D"List Table 7 Color=
ful Accent 6"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Mention"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Smart Hyperlink"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Hashtag"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Unresolved Mention"/>
<w:LsdException Locked=3D"false" SemiHidden=3D"true" UnhideWhenUsed=3D"true=
" Name=3D"Smart Link"/>
</w:LatentStyles>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:roman;
	mso-font-pitch:variable;
	mso-font-signature:-536869121 1107305727 33554432 0 415 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-469750017 -1073732485 9 0 511 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;
	text-underline:single;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-style-unhide:no;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-font-family:Calibri;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-size:10.0pt;
	mso-ansi-font-size:10.0pt;
	mso-bidi-font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"tab-interv=
al:.5in;word-wrap:break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-ascii-font-family:Calibri;mso-han=
si-font-family:Calibri;mso-bidi-font-family:&quot;Times New Roman&quot;">Th=
anks Lijo, I&#8217;ll do another revision to drop the PMFW ticket (I saw it=
 higher up and thought it was standard practice). Once
 the PMFW gets officially released I&#8217;ll test it out and make sure tha=
t it doesn&#8217;t get corrupted. I would assume that it would continue to =
work, but it&#8217;s been a while since it was first confirmed by the PMFW =
dev I was working with.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-ascii-font-family:Calibri;mso-han=
si-font-family:Calibri;mso-bidi-font-family:&quot;Times New Roman&quot;"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-ascii-font-family:Calibri;mso-han=
si-font-family:Calibri;mso-bidi-font-family:&quot;Times New Roman&quot;">Ke=
nt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-ascii-font-family:Calibri;mso-han=
si-font-family:Calibri;mso-bidi-font-family:&quot;Times New Roman&quot;"><o=
:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-fareast-font-family:&quot;Time=
s New Roman&quot;">From:</span></b><span style=3D"mso-fareast-font-family:&=
quot;Times New Roman&quot;"> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;
<br>
<b>Sent:</b> Monday, March 28, 2022 12:08 PM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienn=
a cichlid<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;"><o:p>&nbsp;</o:p></span></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121">Yes, that check lo=
oks good.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121"><o:p>&nbsp;</o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121">A couple of other =
things -&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121"><o:p>&nbsp;</o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121">PMFW ticket as a c=
omment is not needed.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121">I remember Satish =
updating the same struct for smartshift related data. Some additional field=
s added towards the end. Not sure if Sienna struct
 also carries those fields. Regardless, you may check if that affects the p=
lacement of serial number fields (whether before or after those fields).<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121"><o:p>&nbsp;</o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"mso-fareas=
t-font-family:&quot;Times New Roman&quot;;color:#212121"><o:p>&nbsp;</o:p><=
/span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;">Thanks,<br>
Lijo<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"mso-fareast-font-family:&quot;Times New Roman&quot;">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal" style=3D"mso-outline-level:1"><b><span style=3D"mso-=
fareast-font-family:&quot;Times New Roman&quot;;color:black">From:</span></=
b><span style=3D"mso-fareast-font-family:&quot;Times New Roman&quot;;color:=
black"> Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russ=
ell@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, March 28, 2022 9:23:36 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienn=
a cichlid</span><span style=3D"mso-fareast-font-family:&quot;Times New Roma=
n&quot;">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-font-family:&quot;Times N=
ew Roman&quot;">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><a name=3D"BM_BEGIN"></a><span style=3D"font-family:=
&quot;Times New Roman&quot;,serif;mso-fareast-font-family:&quot;Times New R=
oman&quot;">[AMD Official Use Only]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;<br>
&gt; Sent: Monday, March 28, 2022 11:48 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
">Alexander.Deucher@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support for sienna =
cichlid<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 3/28/2022 9:12 PM, Russell, Kent wrote:<br>
&gt; &gt; [AMD Official Use Only]<br>
&gt; &gt;<br>
&gt; &gt; Responses inline<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Monday, March 28, 2022 11:18 AM<br>
&gt; &gt;&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com"=
>Kent.Russell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deuche=
r@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 2/2] drm/amdgpu: Add unique_id support fo=
r sienna cichlid<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 3/28/2022 8:05 PM, Kent Russell wrote:<br>
&gt; &gt;&gt;&gt; This is being added to SMU Metrics, so add the required t=
ie-ins in the<br>
&gt; &gt;&gt;&gt; kernel. Also create the corresponding unique_id sysfs fil=
e.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; v2: Add FW version check, remove SMU mutex<br>
&gt; &gt;&gt;&gt; v3: Fix style warning<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.ru=
ssell@amd.com">kent.russell@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt; Reviewed-by: Alex Deucher &lt;<a href=3D"mailto:alexander=
.deucher@amd.com">alexander.deucher@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<b=
r>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../pmfw_if/smu11_driver_if_sienna_cich=
lid.h&nbsp; | 12 +++++--<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; .../amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c&nbsp;&nbsp; | 36 +++++++++++++++++++<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 3 files changed, 47 insertions(+), 2 de=
letions(-)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; index 4151db2678fb..4a9aabc16fbc 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
&gt; &gt;&gt;&gt; @@ -1993,6 +1993,7 @@ static int default_attr_update(stru=
ct amdgpu_device *adev,<br>
&gt; &gt;&gt; struct amdgpu_device_<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 0):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 1):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 2):<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; case IP_VERSION(10, 3, 0):<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state=
s =3D ATTR_STATE_SUPPORTED;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;=
<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt;&gt;&gt; diff --git<br>
&gt; &gt;&gt; a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_si=
enna_cichlid.h<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_si=
enna_cichlid.h<br>
&gt; &gt;&gt;&gt; index 3e4a314ef925..58f977320d06 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driv=
er_if_sienna_cichlid.h<br>
&gt; &gt;&gt;&gt; +++<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_sienna_cich=
lid.h<br>
&gt; &gt;&gt;&gt; @@ -1419,8 +1419,12 @@ typedef struct {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieRate&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieWidth&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t AverageGfxclkFrequ=
encyTarget;<br>
&gt; &gt;&gt;&gt; -&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; //PMFW-8711<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumLower32;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumUpper32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; } SmuMetrics_t;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; typedef struct {<br>
&gt; &gt;&gt;&gt; @@ -1476,8 +1480,12 @@ typedef struct {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieRate&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; PcieWidth&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t AverageGfxclkFrequ=
encyTarget;<br>
&gt; &gt;&gt;&gt; -&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; //PMFW-8711<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumLower32;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint32_t PublicSerialNumUpper32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is this the case for other ASICs also which share the metrics=
 data with<br>
&gt; &gt;&gt; Sienna?<br>
&gt; &gt;<br>
&gt; &gt; No, only for Sienna Cichlid. The PMFW guys didn't implement it fo=
r Navy Flounder or<br>
&gt; Dimgrey Cavefish.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp; uint16_t Padding16_2;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; } SmuMetrics_V2_t;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; typedef struct {<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_ci=
chlid_ppt.c<br>
&gt; &gt;&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<br>
&gt; &gt;&gt;&gt; index 38f04836c82f..550458f6246a 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c<br>
&gt; &gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_p=
pt.c<br>
&gt; &gt;&gt;&gt; @@ -481,6 +481,41 @@ static int sienna_cichlid_setup_ppta=
ble(struct smu_context<br>
&gt; &gt;&gt; *smu)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sienna_cichlid_patch=
_pptable_quirk(smu);<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +static void sienna_cichlid_get_unique_id(struct smu_cont=
ext *smu)<br>
&gt; &gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev=
;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; struct smu_table_context *smu_table =3D &am=
p;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; SmuMetrics_t *metrics =3D<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;(((SmuMetricsExternal_t *)(smu_table-&gt;metrics_table))-&gt;SmuM=
etrics);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; SmuMetrics_V2_t *metrics_v2 =3D<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;(((SmuMetricsExternal_t *)(smu_table-&gt;metrics_table))-&gt;SmuM=
etrics_V2);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; uint32_t upper32 =3D 0, lower32 =3D 0;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; bool use_metrics_v2;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; int ret;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; /* Only supported as of version 0.58.83.0 *=
/<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (smu-&gt;smc_fw_version &lt; 0x3A5300)<b=
r>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Since this is shared with other ASICs, I guess this check its=
elf may not<br>
&gt; &gt;&gt; be enough. This function may be skipped if it's not MP1 11.0.=
7 or GC 10.3.0?<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Since the sysfs file is only supported on Sienna Cichlid (10.3.0)=
, is it a concern since the tie-<br>
&gt; in won't exist on the other SMU11-based ASICs? And this function is on=
ly referenced by<br>
&gt; sienna_cichlid, unless I misunderstood something (and someone else use=
s<br>
&gt; sienna_cichlid_tables_init).<br>
&gt; &gt;<br>
&gt;<br>
&gt; This function also gets called as part of common init sequence -<br>
&gt; smu_get_unique_id.<br>
&gt; If PMFW version of Navi Flounder/Dimgrey ASIC is greater than Sienna,<=
br>
&gt; then it may go to the path which is not intended to be executed on tha=
t<br>
&gt; ASIC.<br>
<br>
Would it be sufficient to just confirm the IP_VERSION here too then?<br>
&nbsp;e.g.<br>
/* Only supported as of version 0.58.83.0 and only on Sienna Cichlid (GC 10=
.3.0)*/<br>
if (smu-&gt;smc_fw_version &lt; 0x3A5300 || adev-&gt;ip_versions[GC_HWIP][0=
] !=3D IP_VERSION(10, 3, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
<br>
Thus the FW has to be that version, and the IP_VERSION has to be 10.3 ? Or =
is there a better method to use? Thanks!<br>
<br>
&nbsp;Kent<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt;&nbsp;&nbsp; Kent<br>
&gt; &gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; ret =3D smu_cmn_get_metrics_table(smu, NULL=
, false);<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto out_unlock;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; use_metrics_v2 =3D ((smu-&gt;adev-&gt;ip_ve=
rsions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0,<br>
&gt; &gt;&gt; 7)) &amp;&amp;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (smu-&gt;smc_fw_version &gt;=3D 0x3A4300)) ? true : false;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; upper32 =3D use_metrics_v2 ? metrics_v2-&gt=
;PublicSerialNumUpper32 :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metrics-&gt;PublicSerialNumUppe=
r32;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; lower32 =3D use_metrics_v2 ? metrics_v2-&gt=
;PublicSerialNumLower32 :<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; metrics-&gt;PublicSerialNumLowe=
r32;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +out_unlock:<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; adev-&gt;unique_id =3D ((uint64_t)upper32 &=
lt;&lt; 32) | lower32;<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; if (adev-&gt;serial[0] =3D=3D '\0')<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sprintf(adev-&gt;serial, &quot;%016llx&quot;, adev-&gt;unique_id);<br>
&gt; &gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static int sienna_cichlid_tables_init(s=
truct smu_context *smu)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *s=
mu_table =3D &amp;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt; @@ -4182,6 +4217,7 @@ static const struct pptable_funcs s=
ienna_cichlid_ppt_funcs =3D {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ecc_info =3D sienna_ci=
chlid_get_ecc_info,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_default_config_table_s=
ettings =3D<br>
&gt; &gt;&gt; sienna_cichlid_get_default_config_table_settings,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_config_table =3D sienn=
a_cichlid_set_config_table,<br>
&gt; &gt;&gt;&gt; +&nbsp;&nbsp; .get_unique_id =3D sienna_cichlid_get_uniqu=
e_id,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp; void sienna_cichlid_set_ppt_funcs(struc=
t smu_context *smu)<br>
&gt; &gt;&gt;&gt;</span><span style=3D"font-size:12.0pt;font-family:&quot;T=
imes New Roman&quot;,serif;mso-fareast-font-family:&quot;Times New Roman&qu=
ot;"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1308E62E8701830E28ACD382851D9DM5PR12MB1308namp_--
