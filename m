Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1989BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 16:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8997F6E222;
	Mon, 29 Nov 2021 16:53:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9AD6E4A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 16:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YILHnMeQFDgs8rXfUkhLCqoz97jjuBqPfTuzx6tTYKWoBQQPcbsoIL27fzYpqjhGbpSDlBlHackBcIkuBLOlWHahbDAMy7fQoXm/XHy7f1RUxcTcgk5FjVN0ynrmhh7eFLTzVQ31a7kU1qWVmZaUzudJjh2Pt7A0vA44d8zZRcg2q/8oypJc8yeRXaLLmDXKMegGiT95s5515fCDfxhzHIVjSojBza3m2XCr47kQHy95/0vF+EtteGnBgfpob/omg3srbeNTKZHSi22kKGnk0KcnHJIoaWtNgqVX7os0Ga1XzNfhBwC2rXlf/69Xb24tw1nlF4/SO0XwXEGSRgFUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+sjF902q4qu+0olWD33+AmjPbeyI/4111o7ZLDBgfo=;
 b=EK/Zchpfl93vSzBRRE2MZOOgNbcf3Z9CNjOyXy0JimSEFLcZsNWwpMObJU3J/KQ6XIVy1s4fKS/d57J3K7rX83dII0rX7Mdqcw6J0GoBMNLPDKkV1PBAaz2calIOVAA1qOReLpM7ykwpRa5s00daQwl+mhmt5B1rBJfO8kNUKUgkHuxOHsr/sN5KtzJxeWKGC1R2E8+ullL8OcOLQyq9Wbn8vBQ7Nj4uSKQt8SWXNfSutRfVSBg2++LqT4BEj2q08JZrJqs0mcuYRfh02y+N1PpkHe08Bt0GVnzoSPYeiudLzBXNsB4HReh0CRZKrqolkOAP5PjGslxHQ1pmVBUDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+sjF902q4qu+0olWD33+AmjPbeyI/4111o7ZLDBgfo=;
 b=hXmRbsvHM0ci4GkNOMP7JcP6hBPVouFZgfZvXr6raNzT3dOIULGGK2eRMRjDB2sCaO+puMc6sfgKBqh5clZ6h5Y575zMfEgdYUVFDba4mlBogfz/l690ePXTGZq9y/tkdQfhu6NWshZHptavutP+PbA8+/cVJDOLK3zBfEjYC0A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 16:53:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 16:53:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4T58rmOs/HQgS0i8gUa6s2ilbawSuvGAgADIK4CAAADTAIAHPLIY
Date: Mon, 29 Nov 2021 16:53:06 +0000
Message-ID: <BL1PR12MB5144B185E74B61A260152256F7669@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211124142036.22491-1-Jane.Jian@amd.com>
 <CADnq5_P1=kz9dDwLtH98sHGgt6=C5Y=U1EoouGJktwFW0pBG7w@mail.gmail.com>
 <DM5PR12MB24691FE17360A4A7A76D6825F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB24699B4793306F3221D6D67EF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24699B4793306F3221D6D67EF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-29T16:53:06.289Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
suggested_attachment_session_id: 871c9e54-4f4b-2689-18b3-75f690ee23cc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7642def-a5b0-4409-577f-08d9b358b7bc
x-ms-traffictypediagnostic: BL1PR12MB5333:
x-microsoft-antispam-prvs: <BL1PR12MB53332F64B805325BE5199234F7669@BL1PR12MB5333.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3MKMNgngDtfCKj2uBS2TUAOkiMfMsg3ltGHrUmJ5XuhD/QaD4749IooT31BMyZ1U1QpFM/hGxUoOXSJ8hUElDveC3ugXnyO3PNot4TTJ8gi3H74cMOnZrilMRhZkj1RnmgpP0ij3XWkKAw7rrKie9KobvDVnH4R4ZZcF4grBC7HRfI1XHmZHtVotHL7wT43+VZsfXCYMan+gpzligiDEmoCrHMRax1PUs6lIdu5i7mSdgit8Kc9f+sr+sGBcuN3iKCKv4yq9eX6YZSv6vup/hJsllvK7geavxamnDZiOk9eQ5sWUybfF+FoK+ku5WtK0dDIuIjuMLfcstkjkQCB0kUaZI8RA+ODJqyJq1zmIoEK484mFwHLLoXkmLQhzeCPyfGA/MspJtZtfd5k5Vj5/Hh3sxq6gwCJjDstIMnhX0sPDairvsGHF5IZtSXdhf+VXNN91m+Q7srefwlfyVnDLPUWFX2lK796YFx+O4mm9RPLxv1w0R5aAcpyhvVwUq8rkn85ALj1Y2ZFD5XvJuv38fHJSBCapxLI+g4Dpm69fll6hC4rw6gb8EVPifoJCdjQhHklA5kRf86UBRC2J71FBQq0sVmanxfc7UVkIqNPYynrEuwJduK6zC6suPpOEsoGtSSLjr2nt11ulj/DA3ssv+E9Vgxiz9Pdd5oITTnx1nn30oB2AaicodApgyU/vvC3JtyQ9Aywy6yiUu2Ndm2nbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(19627405001)(186003)(8676002)(2906002)(8936002)(66946007)(122000001)(508600001)(76116006)(7696005)(38100700002)(6506007)(38070700005)(66446008)(64756008)(66556008)(66476007)(26005)(53546011)(86362001)(9686003)(4326008)(33656002)(6636002)(316002)(52536014)(71200400001)(83380400001)(110136005)(54906003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zmNPR00aS8F4n2yEyBuFblw57h5hDaRH/IKjP06Tz1h4a1zbrnaha2biINDy?=
 =?us-ascii?Q?8+hh0QeigEQU1KL8ZadbXJqfmgsx4vovMFcUPoJyhaMIlCZuNdJAKjHXJvKs?=
 =?us-ascii?Q?ieQXXxxLxANKSupTrX3Vqjjk1JL0JKufxosvYfp1w30HGzCwlO4GGEYySA9O?=
 =?us-ascii?Q?RsdOo+RB45Swuiftz10UU2/03datXpK45Jt7OWtXGKFjmSqHiyaeWZWvaowS?=
 =?us-ascii?Q?tONkYTk+gAXlOSrEviejSpv1Z4+5a1JEF7rWNxkkE5rxG7/SsiRePNo4XbzT?=
 =?us-ascii?Q?T7f0hvZ8V94+F5SdDGndzNks8hMiRIkJu31Ah5twhJ839k6z4nqN70j9LBiv?=
 =?us-ascii?Q?qfko5EesGUTUstOcYtNztA//1NRS6rRmZ26jUcnkjA3rZKbTeFT3t4xWZGfg?=
 =?us-ascii?Q?YOmNTeDdw4xVcj3RkFxn7ZYWI3QianpG0fa6M58sC2/SyfFXYGmDxfwn2xna?=
 =?us-ascii?Q?G6kRgw+T+V02IyfGLJeD0D601H7HkqEZKjue0pm7XZEBBSWhz8OrXASWLdsb?=
 =?us-ascii?Q?MIKLA1TjJOlxv9Rv7wsn9y2qQ6kmUCU6MF7ehKxsiuxoAp8kRG15WJC4HhYx?=
 =?us-ascii?Q?2J0Zrl/b+C5ujmIniSX8VL5VYsxgCBtN5CqUUB9jl+eh2p+4ta5lHPuYopjn?=
 =?us-ascii?Q?aMZ+Exe8cCtOipQtG/EaOv7ivNxvM99K7+dCJ0cMppTEbXX7d1pP8nJnlRi2?=
 =?us-ascii?Q?CfGhF0e9xRDmCpoCgtEdebwnOo1Zy8hkSEw6m9DVcXTfhZ3Im00MBK93XT/f?=
 =?us-ascii?Q?lxPdRx4vYE7BMb0mAfWudf0tgBI3wo8218G3XN0G14IVot2iX7cloo9qiWOE?=
 =?us-ascii?Q?Kuw9p4QkFIfUVGKkOIxYRrYd+4m+HpjV8tJQVPIZew97bVXXuG6hJuvipn8E?=
 =?us-ascii?Q?CeeWTT7d0TqnWMqaQvEPvZKGrMaenLaup7chOnIhHMKBDkMNfdOSqNEeMclA?=
 =?us-ascii?Q?64MlksmOUQMd2MZx+xvB35vHifPJJlRApAdQ9BBPq9HcV1RA0HJap67M+an0?=
 =?us-ascii?Q?mbYIR2xh6agfrfbY5JKmExkZ/C+xjLJVFPske22X82Ua8O2cm9GSN2DMYzsd?=
 =?us-ascii?Q?PM0o+YAV4eqlkfppVMQFpfSKzEN47vOX7DFtAulszjHGPg+IMxyANZ3DoIhi?=
 =?us-ascii?Q?gT7xLBocoJSjVwCbecOKedUOGm/Eo69mx+m3PnfZqc3s3apm8jXV/FIjFSBh?=
 =?us-ascii?Q?ddmPuQnfAD3KiwKiq7eJ/Bjb5mkBhpnebYYHQW31qaloy+lNQ9BX7fZ6o74s?=
 =?us-ascii?Q?HeanHXGALfTz8GlmCJL26SEdDy5Qk84xV+/oTeZQZJDG3QdmOVvwVOenW9Nn?=
 =?us-ascii?Q?fz6ZD/3p4MV+or59w3sGS3xbpAnbpQZ7xnzmWoA06h55yHEXTGQU7AnkNwzG?=
 =?us-ascii?Q?woOqw4LpnGtoc1Zblq72iV8ajHmpNmFqWJW6EOh7SGe97QFiAELUObI0FjdF?=
 =?us-ascii?Q?4Kw829l4WJTaV3u2fpSANgUobWYIE60C3Rg7iv1jIOCZQ38lZakCKYizgsvd?=
 =?us-ascii?Q?HWrqUqsXrgpCyf3tua/WL037IKnooWZvXzHidpWgEhUva7t/SgPxSoAL96Jn?=
 =?us-ascii?Q?8c4u0fVeS/uJQxknTgxdMnD9UmhxqXJWF733mhzBUc6Mla0j7D0rWTwRLyoN?=
 =?us-ascii?Q?yQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B185E74B61A260152256F7669BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7642def-a5b0-4409-577f-08d9b358b7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 16:53:06.8692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovaEKim7MHIoljCkUpLzYROOMcz0a+XHfs9sJr3VwW9DtW9yZ0FZPNfenMLEUOUqRGSqar1BUpD9R9TsD32XMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144B185E74B61A260152256F7669BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Yes, that makes more sense.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Wednesday, November 24, 2021 9:21 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; Alex Deucher <alexdeucher@gmail.com=
>; Jian, Jane <Jane.Jian@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, JingWen <JingWen.=
Chen2@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID

[Public]

A typo.

It's better to move 'case IP_VERSION(3, 0, 192)' after IP_VERSION(3, 0, 2)?

case IP_VERSION(3, 1, 1):
case IP_VERSION(3, 0, 2):
+ case IP_VERSION(3, 0, 192):
        amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
        if (!amdgpu_sriov_vf(adev))
                amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
        break;

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Thursday, November 25, 2021 10:19 AM
To: Alex Deucher <alexdeucher@gmail.com>; Jian, Jane <Jane.Jian@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, JingWen <JingWen.=
Chen2@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID

[Public]

It's better to move 'case IP_VERSION(3, 0, 192)' after IP_VERSION(3, 0, 192=
)?

case IP_VERSION(3, 1, 1):
case IP_VERSION(3, 0, 2):
+ case IP_VERSION(3, 0, 192):
        amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
        if (!amdgpu_sriov_vf(adev))
                amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
        break;

Regards,
Guchun

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, November 24, 2021 10:23 PM
To: Jian, Jane <Jane.Jian@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Ch=
en@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx list <amd-gfx@l=
ists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID

On Wed, Nov 24, 2021 at 9:20 AM Jane Jian <Jane.Jian@amd.com> wrote:
>
> [WHY]
> for sriov odd# vf will modify vcn0 engine ip revision(due to
> multimedia bandwidth feature), which will be mismatched with original
> vcn0 revision
>
> [HOW]
> add new version check for vcn0 disabled revision(3, 0, 192), typically
> modified under sriov mode
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 503995c7ff6c..3f9b7b0bab3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -923,6 +923,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct a=
mdgpu_device *adev)
>                                 amdgpu_device_ip_block_add(adev, &jpeg_v3=
_0_ip_block);
>                         break;
>                 case IP_VERSION(3, 0, 33):
> +               case IP_VERSION(3, 0, 192):
>                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_blo=
ck);
>                         break;
>                 default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4f7c70845785..585961c2f5f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                 break;
>         case IP_VERSION(3, 0, 0):
>         case IP_VERSION(3, 0, 64):
> +       case IP_VERSION(3, 0, 192):
>                 if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3=
, 0))
>                         fw_name =3D FIRMWARE_SIENNA_CICHLID;
>                 else
> --
> 2.17.1
>

--_000_BL1PR12MB5144B185E74B61A260152256F7669BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yes, that makes more sense.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Wednesday, November 24, 2021 9:21 PM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Alex Deucher &lt;alexd=
eucher@gmail.com&gt;; Jian, Jane &lt;Jane.Jian@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Jing=
Wen &lt;JingWen.Chen2@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedeskt=
op.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check ca=
se to ip init for SIENNA_CICHLID</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Public]<br>
<br>
A typo.<br>
<br>
It's better to move 'case IP_VERSION(3, 0, 192)' after IP_VERSION(3, 0, 2)?=
<br>
<br>
case IP_VERSION(3, 1, 1):<br>
case IP_VERSION(3, 0, 2):<br>
+ case IP_VERSION(3, 0, 192):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev,=
 &amp;vcn_v3_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;jpeg_v3_0_ip_block);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ch=
en, Guchun<br>
Sent: Thursday, November 25, 2021 10:19 AM<br>
To: Alex Deucher &lt;alexdeucher@gmail.com&gt;; Jian, Jane &lt;Jane.Jian@am=
d.com&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, JingWen &lt=
;JingWen.Chen2@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID<br>
<br>
[Public]<br>
<br>
It's better to move 'case IP_VERSION(3, 0, 192)' after IP_VERSION(3, 0, 192=
)?<br>
<br>
case IP_VERSION(3, 1, 1):<br>
case IP_VERSION(3, 0, 2):<br>
+ case IP_VERSION(3, 0, 192):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev,=
 &amp;vcn_v3_0_ip_block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;jpeg_v3_0_ip_block);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
Sent: Wednesday, November 24, 2021 10:23 PM<br>
To: Jian, Jane &lt;Jane.Jian@amd.com&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;=
Guchun.Chen@amd.com&gt;; Chen, JingWen &lt;JingWen.Chen2@amd.com&gt;; amd-g=
fx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID<br>
<br>
On Wed, Nov 24, 2021 at 9:20 AM Jane Jian &lt;Jane.Jian@amd.com&gt; wrote:<=
br>
&gt;<br>
&gt; [WHY]<br>
&gt; for sriov odd# vf will modify vcn0 engine ip revision(due to <br>
&gt; multimedia bandwidth feature), which will be mismatched with original<=
br>
&gt; vcn0 revision<br>
&gt;<br>
&gt; [HOW]<br>
&gt; add new version check for vcn0 disabled revision(3, 0, 192), typically=
 <br>
&gt; modified under sriov mode<br>
&gt;<br>
&gt; Signed-off-by: Jane Jian &lt;Jane.Jian@amd.com&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 1 +<br>
&gt;&nbsp; 2 files changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; index 503995c7ff6c..3f9b7b0bab3c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&gt; @@ -923,6 +923,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struc=
t amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(a=
dev, &amp;jpeg_v3_0_ip_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 33):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; case IP_VERSION(3, 0, 192):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
mdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_block);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b=
reak;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; index 4f7c70845785..585961c2f5f2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
&gt; @@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, =
0):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, =
64):<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(3, 0, 192):<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_versions[GC_HWIP][0] =3D=3D IP_VE=
RSION(10, 3, 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; f=
w_name =3D FIRMWARE_SIENNA_CICHLID;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B185E74B61A260152256F7669BL1PR12MB5144namp_--
