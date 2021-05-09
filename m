Return-Path: <SRS0=tImT=KE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558F5C433ED
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 05:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0421C613ED
	for <amd-gfx@archiver.kernel.org>; Sun,  9 May 2021 05:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421C613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCB36E196;
	Sun,  9 May 2021 05:35:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C96D6E196
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 05:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92/rmZ5QBHDCpcv8B5fe3To0R9RdRSHp/rKKoKQqwDMtreASOZry2NyXHPOk2l3MGO8w72Q/9W/rW3uPIPVTSMbn1QmQIZOlDokq2zFQ6C+s5O1hnMC3odLRxN06mgqMZ4F+tPKZxgbVz93imZc5Db+zfYXaJ+5lFBBxvdJ4FDGtR01H3o3bWTShjnZvqlhhUwi4LRbd3ZIMq4X9EejqedRFWhxWYo22bM6DEW3zembe+N1UhcPjvqtBjXIae2JQyK5rz7yNgCHLpLWOMOzQFkTIf8CVc8SsO+A9j5P1rv0oVvEDGIA+HMhLXB62YtesTe81CS3llUOupepUqsAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqe8sqPLfBjHr2pQAnrRY8rJwNfCvooac2jGuq7i8KU=;
 b=czQeEkrId0L2oaus4YTljLW+wct3UdibD0N60aLNGqvChECC1XUJnpZJ6HK8wbN2n5IBB9icLHmXkoUBJ69frNTYDKTfmnecXeMcdniyhy3k90fvtZUvQpZ8tkbbFhjRuA6Z4SexLJ9F1g2tqwerlC9+LFb2dcdfTdxxIhKR+KOQJT2gfdYbUj7QWRVP95WH3yJEOb9Vw+F/1D+DLXQyjxCl+R5Ayi/0OUGRho0L/xZPifJkLK5CuqkALETDbDyd2f5owNaxEBiU+7Zd8OuBgvvq63fOYW2ro0Yq2iS6oK8zsiajfOjSV7/YQREr9Hif+d3m1RABhYWc5C7b/ttQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqe8sqPLfBjHr2pQAnrRY8rJwNfCvooac2jGuq7i8KU=;
 b=Wk6uUA+3PrDENJbecLBwT5UuKHk6u72d/ktft987Vhz/NQOgmrdd27qtR3aJc81ayk1K5tJZalLd73Oi+bYQSoPfaAXLJQ9k5ui2ujJUeSSKLlvTdSImgyF7KVKp+NcBlpadl+f8up8ZCIvQ2MlpJoeu6pvt8F8Fl4xmQhl2dOE=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Sun, 9 May
 2021 05:35:24 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Sun, 9 May 2021
 05:35:24 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: Kees Cook <keescook@chromium.org>, "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXQ8KUxU02AtWA5k2SdU2Ic9ArhqrZF6CAgABASwCAAUkxOg==
Date: Sun, 9 May 2021 05:35:24 +0000
Message-ID: <BYAPR12MB28401FE8BEC74E60FBB63B86F4559@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
 <202105072117.1480D10A@keescook>
 <BN9PR12MB51616B5E43086FC4CE2B58FFF8569@BN9PR12MB5161.namprd12.prod.outlook.com>,
 <202105080251.65694F9F@keescook>
In-Reply-To: <202105080251.65694F9F@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-09T05:35:23.510Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edb83066-7b00-4ee4-d145-08d912ac3e8a
x-ms-traffictypediagnostic: BY5PR12MB4130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB413065B320BDE92C55EA5D09F4559@BY5PR12MB4130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcF6J5eBC4e78xRhNxAb3jQ9cH0aSMNBSykLFMB2tIf0uodaBa3CQyFPjRADVbH59xL2MZQKHWNChbL2hfbIxoA1aX7gsuSVMDYTrYFpDY1zqAajULjcsmdmWGH0IEo5IrrvljMGpxRM+HuxirJEoYqRF+t7v5LkvlFOXqbDtueLN39cbXGLJ7PpkSvhinFgI1iXbZpodxA/Zb6TChW3g/p9ornf/YoiScfr6sqFkAJDKEM/MUzcjwrUkSbdUMrTpTy9XGudQz6QnBhajMu7Rssya1iw8RPGK2nktMfbk7XR05p66IaQU1LYw0pnD5Yg5WLbapt04JJbuq4h4+kmrQyH4Knx6rR91Ko48dM+BC6ffFpVtxXLcKtYriKYad0U8xi27JkzGRRBendThNGDchDm1C4lMh/C+3OOLtcg/yZhl+cs3xGgzQSf3g1IQ8wKLBR0DmF9izwrGIkmt+BB7olLEGhp5l0Tw3+u0u4rpUeQ0hRDYZnqCsEE0tjpecp0N155bhx2s8hGHpsWiW/zY/gwyU6/YR3F5VVa+GxZiMSV+oEy32hnsfCiSUjEFBXkcx6on+c8nONhakhYA9FsrClRY6C7ceXh0TUweLqpem0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(66556008)(66476007)(8676002)(66446008)(64756008)(8936002)(52536014)(6636002)(186003)(76116006)(66946007)(38100700002)(19627405001)(26005)(5660300002)(122000001)(71200400001)(9686003)(4326008)(55016002)(33656002)(316002)(86362001)(2906002)(478600001)(83380400001)(7696005)(6506007)(54906003)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?khB9U+exPnhGsUnKtsgfG1Tw0Knbd53gUUgtkVSODMdEAx45Qg4wfAqlIQ?=
 =?iso-8859-1?Q?e8N4/C2cjyY8I4ySwHbfoRz+Kf+r5u7JvH2YDGVUgJt8SxM9pP2Et4drf4?=
 =?iso-8859-1?Q?fDlVh0vzmw4/q1wBlIjImZ618aWMI14YwlnaBevHEVW3zEXulNVuxrtXmr?=
 =?iso-8859-1?Q?dvJtVRa372jFbRhJoC3MNw9esCmXjMay7uzr/PBGBfADfxp4BWfLbyjo68?=
 =?iso-8859-1?Q?Rrd6M2AP60h5FK6bBMKkC1hTi75V9oqLfP8ffmvUsDD1vALVf5TOrAZVmQ?=
 =?iso-8859-1?Q?J9/qc1ickbEmyBjIotssrfCt+VmPreboWH5jt/1CKR1td9AnFp1W6j204c?=
 =?iso-8859-1?Q?lT991250N3gXMioQsxKwfIS+ILqUdcDRuoU79MaQN8mtLX2Vv/5AkmHdpV?=
 =?iso-8859-1?Q?imgDtRUw6oLxyxHH3sfHtk8Ry0kp6AFE2Fv6C+74aIoeaE0Q0NzkwnAyRm?=
 =?iso-8859-1?Q?pTife15cStc7il80jYl5EFq5AfkaUu7wWUPvtaIqnOg3RV61R3D/9vucwd?=
 =?iso-8859-1?Q?T5k7dt/m1ZJh4oJhulo+dHnQye7eb7fGbGTo6JYt/nGEmW96FKaArmkegC?=
 =?iso-8859-1?Q?0WymrOc890sTUjCPx+IXjcksjg7OjpKPcLzzf/XJcLZu+MNAwMFQkBHfRm?=
 =?iso-8859-1?Q?0IRbds/3neV33kZm+qe6zf+pRV3tEP6qSIOn5T7VL7NE52Atm6HeQq1anK?=
 =?iso-8859-1?Q?+YYFFumSSe0uOgK5C/0N7R7+8n1rcqzV/Niebaona7ehANKTcRmm9l/wX5?=
 =?iso-8859-1?Q?5n1b/0JqxqCxBG+uGp8awhzBo9VuwXl0cduLO9ZDwoN+ayULF/l088w+wE?=
 =?iso-8859-1?Q?sY44QC1svK31aPBCmbLGtZuGih3FLOzEi7As59GzrLtnGZTOuWFi5F+ifG?=
 =?iso-8859-1?Q?fbPm5EUHVwYbxlC6dX7Mu8kzhMCVzIBjzigXLVgFGbJs95j5pXI2kovz4d?=
 =?iso-8859-1?Q?daL0AeQfvXGVzA5p6xVZ3bAA+wQfUDMmUqz68ry+cKZZiR1v5dPbXY39Hz?=
 =?iso-8859-1?Q?jw1N55t+H46ZOFwJXnQeHtRRQqlFi0WQ+Twdv9rBUT2qaigGvkvQO9AINX?=
 =?iso-8859-1?Q?EN4fHDPUoIZIjM+OCSyfBuKY65w6mH9GsAw/07NL0ByuQ1DGbWpKBobbbH?=
 =?iso-8859-1?Q?s7zxiiyEquJUs4igizSTmY7OzQMNY2h43KwUSjprYfAxgg/uByPKoFQYBK?=
 =?iso-8859-1?Q?jQWdxvZPNcvwTLnOaow/yP+ZpNi2JgKBPtu/QaJ3FUbDmIU01C9F+UUO1k?=
 =?iso-8859-1?Q?m6SZ4U0oSjyHqMr3FqZBVk7RBwJ8YEqCFQRlOM3tdAaCIK0H0xCPaCOuhQ?=
 =?iso-8859-1?Q?TqDf3FuOsi8Gt6LucTbiFpjISnsCoHGJ65KAwAaVt7z/nzTg79+9QmnxFG?=
 =?iso-8859-1?Q?tMgDuLYbDa?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb83066-7b00-4ee4-d145-08d912ac3e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2021 05:35:24.0776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tei6ePdspwDr0Q5fAzM7gQ62oXZEZS1fjyRbEPYnOYQqYmnnTz8UBFvYtqSi5pn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="===============1234366563=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1234366563==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB28401FE8BEC74E60FBB63B86F4559BYAPR12MB2840namp_"

--_000_BYAPR12MB28401FE8BEC74E60FBB63B86F4559BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

The full vbios versioning information consists of the version (numeric), bu=
ild date and the name... I this this interface exposes only the name.

Should we expose those on different sysfs files or just combine all of them=
 in a single file?

David
________________________________
From: Kees Cook <keescook@chromium.org>
Sent: Saturday, May 8, 2021 2:51 AM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@=
lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Nieto, David M <Davi=
d.Nieto@amd.com>; linux-next@vger.kernel.org <linux-next@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface

On Sat, May 08, 2021 at 06:01:23AM +0000, Gu, JiaWei (Will) wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks for this catching Kees.
>
> Yes it should be 20, not 16. I was not aware that serial size had been ch=
anged from 16 to 20 in struct amdgpu_device.
> Will submit a fix soon.

You might want to add a BUILD_BUG_ON() to keep those in sync, especially
since it's about to be UAPI.

-Kees

>
> Best regards,
> Jiawei
>
>
> -----Original Message-----
> From: Kees Cook <keescook@chromium.org>
> Sent: Saturday, May 8, 2021 12:28 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deucher, Alexander <Alexander.=
Deucher@amd.com>
> Cc: StDenis, Tom <Tom.StDenis@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Gu, Ji=
aWei (Will) <JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, Davi=
d M <David.Nieto@amd.com>; linux-next@vger.kernel.org
> Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Hi!
>
> This patch needs some fixing.
>
> On Thu, Apr 22, 2021 at 10:34:48AM +0800, Jiawei Gu wrote:
> > +           case AMDGPU_INFO_VBIOS_INFO: {
> > +                   struct drm_amdgpu_info_vbios vbios_info =3D {};
> > +                   struct atom_context *atom_context;
> > +
> > +                   atom_context =3D adev->mode_info.atom_context;
> > +                   memcpy(vbios_info.name, atom_context->name, sizeof(=
atom_context->name));
> > +                   vbios_info.dbdf =3D PCI_DEVID(adev->pdev->bus->numb=
er, adev->pdev->devfn);
> > +                   memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,=
 sizeof(atom_context->vbios_pn));
> > +                   vbios_info.version =3D atom_context->version;
> > +                   memcpy(vbios_info.date, atom_context->date, sizeof(=
atom_context->date));
> > +                   memcpy(vbios_info.serial, adev->serial, sizeof(adev=
->serial));
>
> This writes beyond the end of vbios_info.serial.
>
> > +                   vbios_info.dev_id =3D adev->pdev->device;
> > +                   vbios_info.rev_id =3D adev->pdev->revision;
> > +                   vbios_info.sub_dev_id =3D atom_context->sub_dev_id;
> > +                   vbios_info.sub_ved_id =3D atom_context->sub_ved_id;
>
> Though it gets "repaired" by these writes.
>
> > +
> > +                   return copy_to_user(out, &vbios_info,
> > +                                           min((size_t)size, sizeof(vb=
ios_info))) ? -EFAULT : 0;
> > +           }
>
> sizeof(adev->serial) !=3D sizeof(vbios_info.serial)
>
> adev is struct amdgpu_device:
>
> struct amdgpu_device {
> ...
>         char                            serial[20];
>
>
> > +struct drm_amdgpu_info_vbios {
> > [...]
> > +   __u8 serial[16];
> > +   __u32 dev_id;
> > +   __u32 rev_id;
> > +   __u32 sub_dev_id;
> > +   __u32 sub_ved_id;
> > +};
>
> Is there a truncation issue (20 vs 16) and is this intended to be a NUL-t=
erminated string?
>
> --
> Kees Cook

--
Kees Cook

--_000_BYAPR12MB28401FE8BEC74E60FBB63B86F4559BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
The full vbios versioning information consists of the version (numeric), bu=
ild date and the name... I this this interface exposes only the name.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Should we expose those on different sysfs files or just combine all of them=
 in a single file?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
David</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kees Cook &lt;keescoo=
k@chromium.org&gt;<br>
<b>Sent:</b> Saturday, May 8, 2021 2:51 AM<br>
<b>To:</b> Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; StDenis, T=
om &lt;Tom.StDenis@amd.com&gt;; Christian K=F6nig &lt;ckoenig.leichtzumerke=
n@gmail.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskto=
p.org&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;; linux-next@vger.kern=
el.org
 &lt;linux-next@vger.kernel.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Sat, May 08, 2021 at 06:01:23AM +0000, Gu, JiaW=
ei (Will) wrote:<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; Thanks for this catching Kees.<br>
&gt; <br>
&gt; Yes it should be 20, not 16. I was not aware that serial size had been=
 changed from 16 to 20 in struct amdgpu_device.<br>
&gt; Will submit a fix soon.<br>
<br>
You might want to add a BUILD_BUG_ON() to keep those in sync, especially<br=
>
since it's about to be UAPI.<br>
<br>
-Kees<br>
<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt; <br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Kees Cook &lt;keescook@chromium.org&gt; <br>
&gt; Sent: Saturday, May 8, 2021 12:28 PM<br>
&gt; To: Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
&gt; Cc: StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; Deucher, Alexander &lt;A=
lexander.Deucher@amd.com&gt;; Christian K=F6nig &lt;ckoenig.leichtzumerken@=
gmail.com&gt;; Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org; Nieto, David M &lt;David.Nieto@amd.com&gt;; linux-next@vger=
.kernel.org<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
&gt; <br>
&gt; Hi!<br>
&gt; <br>
&gt; This patch needs some fixing.<br>
&gt; <br>
&gt; On Thu, Apr 22, 2021 at 10:34:48AM +0800, Jiawei Gu wrote:<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cas=
e AMDGPU_INFO_VBIOS_INFO: {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_vbios v=
bios_info =3D {};<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *atom_cont=
ext;<br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atom_context =3D adev-&gt;mode=
_info.atom_context;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.name, atom_c=
ontext-&gt;name, sizeof(atom_context-&gt;name));<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.dbdf =3D PCI_DEVID(=
adev-&gt;pdev-&gt;bus-&gt;number, adev-&gt;pdev-&gt;devfn);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.vbios_pn, at=
om_context-&gt;vbios_pn, sizeof(atom_context-&gt;vbios_pn));<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.version =3D atom_co=
ntext-&gt;version;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.date, atom_c=
ontext-&gt;date, sizeof(atom_context-&gt;date));<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_info.serial, adev=
-&gt;serial, sizeof(adev-&gt;serial));<br>
&gt; <br>
&gt; This writes beyond the end of vbios_info.serial.<br>
&gt; <br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.dev_id =3D adev-&gt=
;pdev-&gt;device;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.rev_id =3D adev-&gt=
;pdev-&gt;revision;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_dev_id =3D atom=
_context-&gt;sub_dev_id;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.sub_ved_id =3D atom=
_context-&gt;sub_ved_id;<br>
&gt; <br>
&gt; Though it gets &quot;repaired&quot; by these writes.<br>
&gt; <br>
&gt; &gt; +<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return copy_to_user(out, &amp;=
vbios_info,<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min((size_t)size, sizeof(vbios_info)=
)) ? -EFAULT : 0;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; <br>
&gt; sizeof(adev-&gt;serial) !=3D sizeof(vbios_info.serial)<br>
&gt; <br>
&gt; adev is struct amdgpu_device:<br>
&gt; <br>
&gt; struct amdgpu_device {<br>
&gt; ...<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seria=
l[20];<br>
&gt; <br>
&gt; <br>
&gt; &gt; +struct drm_amdgpu_info_vbios {<br>
&gt; &gt; [...]<br>
&gt; &gt; +&nbsp;&nbsp; __u8 serial[16];<br>
&gt; &gt; +&nbsp;&nbsp; __u32 dev_id;<br>
&gt; &gt; +&nbsp;&nbsp; __u32 rev_id;<br>
&gt; &gt; +&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt; &gt; +&nbsp;&nbsp; __u32 sub_ved_id;<br>
&gt; &gt; +};<br>
&gt; <br>
&gt; Is there a truncation issue (20 vs 16) and is this intended to be a NU=
L-terminated string?<br>
&gt; <br>
&gt; --<br>
&gt; Kees Cook<br>
<br>
-- <br>
Kees Cook<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB28401FE8BEC74E60FBB63B86F4559BYAPR12MB2840namp_--

--===============1234366563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1234366563==--
