Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291DC54EE9
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 16:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6999E10EA10;
	Thu,  8 Sep 2022 16:42:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7D10EB72
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 16:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9mzRt0pqZKWAfbAOCJytmw3uMWk63rn07pq6VuOQGt3mN7ROvPFgDg2BWGCo6CRRY3d9u1L6sV8fe51OBEpbZ2pA/cHgvXSsFmnJOPXDJ4Op+8AeY4nkuic3TwbwCczkqOZe7NkQDYiA2VqnU1xulMywG9CxKJEZ1TlQpCQeqYLy8S/6I5UXfFnLzb7Dzt3KDodGP99GQJKEuPi1woCoBGjP0yWv317MChJ925TU17RDUTH9cqi28I8KsDlKtTt0bP2/Q9Pp2mj4BiNehGl2antIANkxzME3HBZ6GHgBEGXpoRYCJyrphWJ2BA3sgiy3IOuyPp6VEwydBRTBNx40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpiIN35MOtdRynj9ogG77gTVelE/9h8vfzGV4tPXCaA=;
 b=U+a0Gc+wFEEXlJ2179UyfFosoOx8fQwV8j5gMAoytpibdXd5fNUAh37Q4KpzSuoIKmaNgz5/Qrv8/oQwgehU1kSWZMxHQb55TNlJxRJ14NP4BAdz0RUHMVCFIanjJLPNdGgvPGtNRjqbtG0hnOEtLAecmnaJp+DY88EshIR/WGSPquxMAMQSRKRZusSPeaE50siViODrv5OhuMEIz2iTMWOr9Np3tVSJmS2KLszwD4F/HO0+zSSkLRvr1WOfjMndmUB4IrWDjmjbI25HC49YUhDXTMuRIChSUrzWSsfP9YMAQYK/+5s7m7urwL0I+lxJrBFJNiVyiqFDv7cZZ26gAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpiIN35MOtdRynj9ogG77gTVelE/9h8vfzGV4tPXCaA=;
 b=W41E2ER/yXPuja9USAl6yx9lPFFCE7EkqyoU62hkIJLBHVu9OVtxHil9OGEHYCf+3BCUy4SIin0WmuF8GhO4SNdAv6GttA+kjL5wHMBXQBnlF+3O/yYA48WAPoU9CfpHZLfGju3+oBudTgIboq19GuandoVtzQq7XP8Ik36Nyo8=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 16:42:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 16:42:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported
Thread-Topic: [PATCH] drm/amdgpu: Don't enable LTR if not supported
Thread-Index: AQHYwzKEk9S40Dct80Oh1dlexbtsna3VtQQAgAAD3YCAAAOD/A==
Date: Thu, 8 Sep 2022 16:42:38 +0000
Message-ID: <BYAPR12MB461445ADFB5D36D863AA3C3C97409@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220908032344.1682187-1-lijo.lazar@amd.com>
 <20220908161152.GA200598@bhelgaas>
 <CADnq5_O-apd-22NRT3VGcAeEQeimuywSsMynCAxTNDUbqfVxRQ@mail.gmail.com>
In-Reply-To: <CADnq5_O-apd-22NRT3VGcAeEQeimuywSsMynCAxTNDUbqfVxRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-08T16:38:15.7599054Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|DM8PR12MB5493:EE_
x-ms-office365-filtering-correlation-id: 4e2a089d-27dc-4e97-1c75-08da91b92414
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xB88QHzXtN6hQ1H5Cw/1gk438kgvPPSkPwl0Q9vDDIGjdRyXhrpX0nmKtc/YRiAv3BmRUHOPaN7QFyvBXAqWac5hFwGCbjaGvtVZAR4SbKTtevt9dUy+oD4ztaNfyP9k9eJExQ1ra5MU1ZYSUcKeOMhsuYv1DvgLCewzqudNYGaGQG2yZf8H7iYZsipGXMhERA1oJbXcL8mRPoJdMicCQalMULK9R5CaB8P0xgh87YpxE5ZCDMJSXirOT6sgtleiG4TgNeBT/wMSU7A3CUgtC7s+zpWcBOozq6OUs5BLCs9oUSeW+HCvUCggpHU3U9JfVvuVyiqPnfbb0cHTan+UFubfes7S5Eza1N+SsREeail6dQ/W2VJgrd91KVy/YOXhONXHuEHpgWd+u3NU7Pxdg/9o6mbmFP7vNNeBARRLi2ktDzBWgwxYjR5IgWcp8V1Y/fcE3FI5mF1sKFtFf/9IkIBKbnZi5h4nsN4VphYOspybjvjmzNH9zWyjjwacXEkvghTocJXe4ZuQpq62jiBk7AyfEshdmuwLhZ9qtUn6LQ5fo5OSj17tW5+Ij1MnbtY6H/MQrGGmDD5EYHeUWW1efwAwn7TDU0sP1tp3XPerq+ty4wGJ7yRzokSFkcQs7c0OHlHwk6yfb07dZUY/LRrJ5OOtFzryPhbPqrx7TgEcX9XPepDo11EsaeAdWi1C82rXHPP9VWkaOUQAvYtaiXbaGVQc/2FbmhC+O8/KcyooCTbSbHiKPzA+inEbi3V1st7GVJBGR8ziQxbRlcz+ybof2JTK0YBP6qTgR0BxMX2Srqg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(71200400001)(316002)(110136005)(54906003)(45080400002)(86362001)(122000001)(83380400001)(186003)(966005)(478600001)(166002)(41300700001)(53546011)(6506007)(9686003)(38100700002)(26005)(7696005)(38070700005)(33656002)(2906002)(8936002)(55016003)(5660300002)(52536014)(64756008)(4326008)(91956017)(66446008)(66556008)(76116006)(66476007)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AOZ4EWjVE1hEhRohojLsd8F7larns+QTD128YCVzueTEC8O+J7EB/Bb3iByF?=
 =?us-ascii?Q?6EEg3m8LNxoFrTIMZQ86df3OP7IVVvIsGq7nMJAaJhPoUslksFDf94QULmax?=
 =?us-ascii?Q?XESLEEIkPhPoQP6C8bsOhflr1ZSkuSIg4YeyaheslWu7hCgRes6kS/sUDOg/?=
 =?us-ascii?Q?lqVnQGjBX26PztwuiFAPvi10KucQjVzy4PcAkpyWLYudqSbIFt/5TFG0nirk?=
 =?us-ascii?Q?dMQ7PGxxK9skky5hUE+1EzK9oyeUlp2RyONUvt/BFwCleQ0SJBqwYAcQUkDQ?=
 =?us-ascii?Q?W7ymcwuvyfbH/ybjkebJXaowYzktd9E6y3WHaIrlmDqd571AxOR3ETr65qi7?=
 =?us-ascii?Q?J4nYcOffaq+SAaY10nTrNe+U8yeyUZ+mioWjoGMcFduTJFKWmHdaBjD0fG5f?=
 =?us-ascii?Q?Du5pLcD4cg/V+EUJ5BdMc81d8ZvY0bcdlPR18SvomNVQfRukvxRgJ76vBbxu?=
 =?us-ascii?Q?g9ofdLnnDjAIEkIiLG9+kfaO+LifGbJV273wg08zx/Bv1V3qf1liGb2iSXxE?=
 =?us-ascii?Q?iAUFfKH/9Dl+k1pikWCV8EkPWsxqk05sJQkUKjtUiiEti5N88F2XfdDZr0P0?=
 =?us-ascii?Q?DYzLRWXc7FW9uCLPxnsEBeCxRG1LJ46Q99btBBzruAFoJzXpqLtlM00gLVSU?=
 =?us-ascii?Q?4cTEnF5wJeA9YaaX7rbqALGO2yN/rDa0lRJM9LGL7391vokiAR9KAaETG3Pw?=
 =?us-ascii?Q?BbUtwJrHK5aZkuY8KiCA25BJ4Kl5mZOu/NymxIm9QydNUZ6wQEOA/v5fCaaB?=
 =?us-ascii?Q?GH5wq16mwB6jsctnocR9bkJ4apFIuiZNYJ38usRbvzyIXZNvof2Ye6Q2MdC2?=
 =?us-ascii?Q?qbuACHU2te1LmFmS3pAOZ5qpxQtAnWFoCRfEN7wpBa4tkQ9G1kUP7neBF2vv?=
 =?us-ascii?Q?HqyNXq8esw0jD1AD8PukREsnROrP5dY9VKRyMO4WUOtR0iAnD+5OtQYHfcsq?=
 =?us-ascii?Q?axke09mI55lf+Gc8/ySOtpr94u5oxMEn38bvVsMlZmPJXMGiVPTKYx7bYTea?=
 =?us-ascii?Q?5EMoIGQybz/c0r2IfdXYcUf3KuFD5jQWVcWQ/LSrXWRE1wVGEwlqRQElU72i?=
 =?us-ascii?Q?FqFkBbuEDJOby6qAQuxx9LsXgVSDIJs6GzMGd6TZZRqXMm9CvfPqVbHgms0m?=
 =?us-ascii?Q?+6Zuxv4WzD5d3gCSDzad0CG/h0v04inwtjDke51INwj1PMUHGKY1ORSQhGAv?=
 =?us-ascii?Q?xAPkSBXt3JMQOoGh8Db5Msor4nVS60vc22xhshaIaSFLlljobRQ3mUrPBF/+?=
 =?us-ascii?Q?vAue2SXq7YYp/tqHe0cD7yhmMi+7qlTrxgKwlF3AZjul1p44rpCJIvaUPYJU?=
 =?us-ascii?Q?2cEh10XIK573g5u12Xq8fWlao1DDVz1O+yG2M2dpzHm2xbHHt26Cc/JVtAcr?=
 =?us-ascii?Q?vs86qG2C/j7Ya4ZredmOiul8m8lavnwnMEoJcHXCiY3F5PUI6prqRC/m044y?=
 =?us-ascii?Q?GHTNZcVUSZ7X4jOocCxPBeDQwo5KDi8EYPcz87LGgbYps0enZxynLR5YJU37?=
 =?us-ascii?Q?eZ8TnBev8XVIoJHWxmngkY5f/PEi7vMzro6eXSHjaJKY+dRjzQrUoTeC3ffh?=
 =?us-ascii?Q?L4zBEJ4ofu7TY2Ao233sl2f6WnyVHc+6teMF0gpIoupVRAudZ1bQFrg0fp8y?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461445ADFB5D36D863AA3C3C97409BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2a089d-27dc-4e97-1c75-08da91b92414
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 16:42:38.6309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk9ZRhqVW53aPB92mtY73z2tdJNzMCEJjLQivd49QGCwIz94eU46tB2HtdPC5PFF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "wielkiegie@gmail.com" <wielkiegie@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461445ADFB5D36D863AA3C3C97409BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

I am not sure if ASPM settings can be generalized by PCIE core. Performance=
 vs Power savings when ASPM is enabled will require some additional tuning =
and that will be device specific.

In some of the other ASICs, this programming is done in VBIOS/SBIOS firmwar=
e. Having it in driver provides the advantage of additional tuning without =
forcing a VBIOS upgrade.

Thanks,
Lijo
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, September 8, 2022 9:55:41 PM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; stable@vger.kernel.org <stable@vger.k=
ernel.org>; wielkiegie@gmail.com <wielkiegie@gmail.com>; amd-gfx@lists.free=
desktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.=
Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported

On Thu, Sep 8, 2022 at 12:12 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Evan, author of 62f8f5c3bfc2 ("drm/amdgpu: enable ASPM support
> for PCIE 7.4.0/7.6.0")]
>
> On Thu, Sep 08, 2022 at 08:53:44AM +0530, Lijo Lazar wrote:
> > As per PCIE Base Spec r4.0 Section 6.18
> > 'Software must not enable LTR in an Endpoint unless the Root Complex
> > and all intermediate Switches indicate support for LTR.'
> >
> > This fixes the Unsupported Request error reported through AER during
> > ASPM enablement.
> >
> > Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216455&amp;data=3D05%7C01%7Cli=
jo.lazar%40amd.com%7C1b7a9338c69d494ff04508da91b6cd07%7C3dd8961fe4884e608e1=
1a82d994e183d%7C0%7C0%7C637982511562535915%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi=
MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&=
amp;sdata=3DVmk44BHDQGoZTq%2FGez8Kh7rrp%2Boz%2BQYEHGRaHMSyUOU%3D&amp;reserv=
ed=3D0
> >
> > The error was unnoticed before and got visible because of the commit
> > referenced below. This doesn't fix anything in the commit below, rather
> > fixes the issue in amdgpu exposed by the commit. The reference is only
> > to associate this commit with below one so that both go together.
> >
> > Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_p=
ort_device_capability()")
> >
> > Reported-by: Gustaw Smolarczyk <wielkiegie@gmail.com>
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 9 ++++++++-
> >  drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 9 ++++++++-
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 9 ++++++++-
>
> nbio_v4_3_program_ltr() checks pdev->ltr_path itself instead of doing
> it in *_program_aspm().  It'd be nice to use the same approach for all
> versions.
>
> I really don't like the fact that amdgpu does all this ASPM fiddling
> in the driver in the first place.  ASPM should be configured by the
> PCI core, not by each individual driver.  ASPM has all sorts of
> requirements that relate to upstream devices, which I think amdgpu
> ignores, but the core pays attention to.
>
> Do you know why the driver configures ASPM itself?  If the PCI core is
> doing something wrong (and I'm sure it is, ASPM support is kind of a
> mess), I'd much prefer to fix up the core where *all* drivers can
> benefit from it.

This is the programming sequence we get from our hardware team and it
is used on both windows and Linux.  As far as I understand it windows
doesn't handle this in the core, it's up to the individual drivers to
enable it.  I'm not familiar with how this should be enabled
generically, but at least for our hardware, it seems to have some
variation compared to what is done in the PCI core due to stability,
etc. It seems to me that this may need asic specific implementations
for a lot of hardware depending on the required programming sequences.
E.g., various asics may need hardware workaround for bugs or platform
issues, etc.  I can ask for more details from our hardware team.

Alex

>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/a=
md/amdgpu/nbio_v2_3.c
> > index b465baa26762..aa761ff3a5fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> > @@ -380,6 +380,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_dev=
ice *adev,
> >               WREG32_PCIE(smnPCIE_LC_CNTL, data);
> >  }
> >
> > +#ifdef CONFIG_PCIEASPM
> >  static void nbio_v2_3_program_ltr(struct amdgpu_device *adev)
> >  {
> >       uint32_t def, data;
> > @@ -401,9 +402,11 @@ static void nbio_v2_3_program_ltr(struct amdgpu_de=
vice *adev)
> >       if (def !=3D data)
> >               WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
> >  }
> > +#endif
> >
> >  static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
> >  {
> > +#ifdef CONFIG_PCIEASPM
> >       uint32_t def, data;
> >
> >       def =3D data =3D RREG32_PCIE(smnPCIE_LC_CNTL);
> > @@ -459,7 +462,10 @@ static void nbio_v2_3_program_aspm(struct amdgpu_d=
evice *adev)
> >       if (def !=3D data)
> >               WREG32_PCIE(smnPCIE_LC_CNTL6, data);
> >
> > -     nbio_v2_3_program_ltr(adev);
> > +     /* Don't bother about LTR if LTR is not enabled
> > +      * in the path */
> > +     if (adev->pdev->ltr_path)
> > +             nbio_v2_3_program_ltr(adev);
> >
> >       def =3D data =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP3);
> >       data |=3D 0x5DE0 << RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__=
SHIFT;
> > @@ -483,6 +489,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu_de=
vice *adev)
> >       data &=3D ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MAS=
K;
> >       if (def !=3D data)
> >               WREG32_PCIE(smnPCIE_LC_CNTL3, data);
> > +#endif
> >  }

--_000_BYAPR12MB461445ADFB5D36D863AA3C3C97409BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
I am not sure if ASPM settings can be generalized by PCIE core. Performance=
 vs Power savings when ASPM is enabled will require some additional tuning =
and that will be device specific.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
In some of the other ASICs, this programming is done in VBIOS/SBIOS firmwar=
e. Having it in driver provides the advantage of additional tuning without =
forcing a VBIOS upgrade.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;">Thanks,</span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, September 8, 2022 9:55:41 PM<br>
<b>To:</b> Bjorn Helgaas &lt;helgaas@kernel.org&gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; stable@vger.kernel.org &=
lt;stable@vger.kernel.org&gt;; wielkiegie@gmail.com &lt;wielkiegie@gmail.co=
m&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;;=
 Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Quan, Evan
 &lt;Evan.Quan@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br=
>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Don't enable LTR if not supported</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Sep 8, 2022 at 12:12 PM Bjorn Helgaas &lt;=
helgaas@kernel.org&gt; wrote:<br>
&gt;<br>
&gt; [+cc Evan, author of 62f8f5c3bfc2 (&quot;drm/amdgpu: enable ASPM suppo=
rt<br>
&gt; for PCIE 7.4.0/7.6.0&quot;)]<br>
&gt;<br>
&gt; On Thu, Sep 08, 2022 at 08:53:44AM +0530, Lijo Lazar wrote:<br>
&gt; &gt; As per PCIE Base Spec r4.0 Section 6.18<br>
&gt; &gt; 'Software must not enable LTR in an Endpoint unless the Root Comp=
lex<br>
&gt; &gt; and all intermediate Switches indicate support for LTR.'<br>
&gt; &gt;<br>
&gt; &gt; This fixes the Unsupported Request error reported through AER dur=
ing<br>
&gt; &gt; ASPM enablement.<br>
&gt; &gt;<br>
&gt; &gt; Link: <a href=3D"https://nam11.safelinks.protection.outlook.com/?=
url=3Dhttps%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D216455&amp;am=
p;data=3D05%7C01%7Clijo.lazar%40amd.com%7C1b7a9338c69d494ff04508da91b6cd07%=
7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637982511562535915%7CUnknown%7=
CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn=
0%3D%7C3000%7C%7C%7C&amp;amp;sdata=3DVmk44BHDQGoZTq%2FGez8Kh7rrp%2Boz%2BQYE=
HGRaHMSyUOU%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbugzill=
a.kernel.org%2Fshow_bug.cgi%3Fid%3D216455&amp;amp;data=3D05%7C01%7Clijo.laz=
ar%40amd.com%7C1b7a9338c69d494ff04508da91b6cd07%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637982511562535915%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;am=
p;sdata=3DVmk44BHDQGoZTq%2FGez8Kh7rrp%2Boz%2BQYEHGRaHMSyUOU%3D&amp;amp;rese=
rved=3D0</a><br>
&gt; &gt;<br>
&gt; &gt; The error was unnoticed before and got visible because of the com=
mit<br>
&gt; &gt; referenced below. This doesn't fix anything in the commit below, =
rather<br>
&gt; &gt; fixes the issue in amdgpu exposed by the commit. The reference is=
 only<br>
&gt; &gt; to associate this commit with below one so that both go together.=
<br>
&gt; &gt;<br>
&gt; &gt; Fixes: 8795e182b02d (&quot;PCI/portdrv: Don't disable AER reporti=
ng in get_port_device_capability()&quot;)<br>
&gt; &gt;<br>
&gt; &gt; Reported-by: Gustaw Smolarczyk &lt;wielkiegie@gmail.com&gt;<br>
&gt; &gt; Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
&gt; &gt; Cc: stable@vger.kernel.org<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 9 ++++++++-<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c | 9 ++++++++-<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 9 ++++++++-<br>
&gt;<br>
&gt; nbio_v4_3_program_ltr() checks pdev-&gt;ltr_path itself instead of doi=
ng<br>
&gt; it in *_program_aspm().&nbsp; It'd be nice to use the same approach fo=
r all<br>
&gt; versions.<br>
&gt;<br>
&gt; I really don't like the fact that amdgpu does all this ASPM fiddling<b=
r>
&gt; in the driver in the first place.&nbsp; ASPM should be configured by t=
he<br>
&gt; PCI core, not by each individual driver.&nbsp; ASPM has all sorts of<b=
r>
&gt; requirements that relate to upstream devices, which I think amdgpu<br>
&gt; ignores, but the core pays attention to.<br>
&gt;<br>
&gt; Do you know why the driver configures ASPM itself?&nbsp; If the PCI co=
re is<br>
&gt; doing something wrong (and I'm sure it is, ASPM support is kind of a<b=
r>
&gt; mess), I'd much prefer to fix up the core where *all* drivers can<br>
&gt; benefit from it.<br>
<br>
This is the programming sequence we get from our hardware team and it<br>
is used on both windows and Linux.&nbsp; As far as I understand it windows<=
br>
doesn't handle this in the core, it's up to the individual drivers to<br>
enable it.&nbsp; I'm not familiar with how this should be enabled<br>
generically, but at least for our hardware, it seems to have some<br>
variation compared to what is done in the PCI core due to stability,<br>
etc. It seems to me that this may need asic specific implementations<br>
for a lot of hardware depending on the required programming sequences.<br>
E.g., various asics may need hardware workaround for bugs or platform<br>
issues, etc.&nbsp; I can ask for more details from our hardware team.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu=
/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt; &gt; index b465baa26762..aa761ff3a5fa 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c<br>
&gt; &gt; @@ -380,6 +380,7 @@ static void nbio_v2_3_enable_aspm(struct amdg=
pu_device *adev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; WREG32_PCIE(smnPCIE_LC_CNTL, data);<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; +#ifdef CONFIG_PCIEASPM<br>
&gt; &gt;&nbsp; static void nbio_v2_3_program_ltr(struct amdgpu_device *ade=
v)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&gt; &gt; @@ -401,9 +402,11 @@ static void nbio_v2_3_program_ltr(struct amd=
gpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; WREG32_PCIE(smnBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);<br=
>
&gt; &gt;&nbsp; }<br>
&gt; &gt; +#endif<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static void nbio_v2_3_program_aspm(struct amdgpu_device *ad=
ev)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt; +#ifdef CONFIG_PCIEASPM<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t def, data;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_PCIE(=
smnPCIE_LC_CNTL);<br>
&gt; &gt; @@ -459,7 +462,10 @@ static void nbio_v2_3_program_aspm(struct am=
dgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; WREG32_PCIE(smnPCIE_LC_CNTL6, data);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; nbio_v2_3_program_ltr(adev);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Don't bother about LTR if LTR is not=
 enabled<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in the path */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pdev-&gt;ltr_path)<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; nbio_v2_3_program_ltr(adev);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =3D data =3D RREG32_SOC15=
(NBIO, 0, mmRCC_BIF_STRAP3);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D 0x5DE0 &lt;&lt; RCC=
_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;<br>
&gt; &gt; @@ -483,6 +489,7 @@ static void nbio_v2_3_program_aspm(struct amd=
gpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~PCIE_LC_CNTL3_=
_LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; WREG32_PCIE(smnPCIE_LC_CNTL3, data);<br>
&gt; &gt; +#endif<br>
&gt; &gt;&nbsp; }<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB461445ADFB5D36D863AA3C3C97409BYAPR12MB4614namp_--
