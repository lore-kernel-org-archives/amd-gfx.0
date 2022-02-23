Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AA5C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD5010E735;
	Wed, 23 Feb 2022 15:19:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B142210E9B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljn3CJMxaAW1R7oWPQt1iRBU0gQMv5+fzt3DA1+kalNeGaq3DhS8/o8pemMBzrHTcJAPCbQvox8VqIntkpgfnHdVdbZWGxVAtJpN4cl3gdmgBdpCxaMbzdAcFXPCjLIP46S8b16yk8mn2qJWsi7tJBET6hwT0FLDX2M8lfld+3iHZDUD9xnxjZlcLq1Y8hu5rOsvfrgj3f8746Une7KTKLSIx/pXiGKJE7wFXInJlVCkDSK5Y7gC+3c+/9c85dmPKfGIafbBXI9HRLrNK3tDgC0+dGTSowUuKoJq/ZGe5SyM/0c7FXS3uqJtR/yGKkUupqv1Y6hK20FQ9Gjc+FMmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8AAC26lpr6I/hOPJfVfpqrGrhn2tgWqJkaIIe8QZpo=;
 b=XJr96DHD6P2DrX6NHFpOSAdjcOH33z01s7nlkyxXubqkPZamqB7x3ryAD1MQ5WnR5bpSZgfbzPmr6Tc+11tF1fIoC8mDM++I9hpC1p28BRRbGfiFH6CinR0WtuCdYgKMf/o/aqjlDMNcTlvADkVYmd75gjPtAdamftGR+u4G2ZCZ7Govq3hCAtPOx4OuQlfedrwY5xwhOtG4tOi5GcvfEaJoOlK2Jf8sbc+fLRhIQBKfTBrQIm2uPnjqUFvH+5MzGyQ/MyxTRkFubxm2O51rvOU2oPtsCErdwi04j8a2p48Nnd5N/Fzj/b8Jsd2otQ1Ye4PF05JG4cRQPXFAfAXFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8AAC26lpr6I/hOPJfVfpqrGrhn2tgWqJkaIIe8QZpo=;
 b=deppR2OlmwYW+P46FfP9TKtEVfmS3a0P2j+m2arftLhOujlXcJhLhCcwaa9yWJc1+jMfvenNnRld/+cPndjBwMpx7XXvT4EpiGhLWCcSEURair8OZgfXC71lCtque+MKY4gFBkzJootch2fTUc9WFjNc0wFjt+vhRHuf0UNr6ZE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SN6PR12MB2848.namprd12.prod.outlook.com (2603:10b6:805:77::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Wed, 23 Feb 2022 15:18:57 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 15:18:57 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Thread-Topic: [PATCH] drm/amdgpu: install ctx entities with cmpxchg
Thread-Index: AQHYKLqq0V3JvdyVZUSQMErnbtLFnayhPGUAgAADJ6A=
Date: Wed, 23 Feb 2022 15:18:57 +0000
Message-ID: <DM5PR12MB24698390D11135CF1347D9ADF13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220223133829.21443-1-christian.koenig@amd.com>
 <BL1PR12MB514438D37ADF99A28A0A8F5CF73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514438D37ADF99A28A0A8F5CF73C9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-23T15:06:26.436Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54d881de-8ce8-41ba-fcad-08d9f6dfd017
x-ms-traffictypediagnostic: SN6PR12MB2848:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2848117878614798C8EF11A8F13C9@SN6PR12MB2848.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7b4ncI1XLVTrwDBzoPdtRPny262zKtQfTTs8Q4YCMOwbtqAWKFSi4Ntj4LpBoJy5CbXFQr0mRUh1X/mfncVCxpHZqr8ePFf0Ltos1Uh5NjVZyNE/5HoA/N10NGjKQ3VXhWYmCknenTdxGdhXaAmOCHy8ho/5dCkOP/H8UoZpdNMW26jHvOQgCOJMFkpw2zmVouicA0tecc0b2vFsD9A/NN/PUK//dDTia2FXYzM63t9t0AXhFsY5b2+XSvblAdb5xRrb9aRdJnU2n7zWVabgZJgMZzyxZRoGr78Xb4AsuaTPaiv5UnbDmSFBbToy2jwM9ofTqrAnKA0OTlTYEPhRQh6bamMyKJ6fAlvVJgAHaDfFKp/J2zRm54REb/4GLLRO6kn3HxynPvb9sQsfhcL66OPxxeVJ5YEQx69r8T1OIRMUo/RNis/gy+Xbwgk1yuH2FhvNpSGVmCZ88sVsZG1R6AGh+ZTIq7UKvvE986Sb58GL22iHzABz03YVs7aybAXYWizmu9Z+DypF050Tqn4cHLiqNebFQDCYV7NH2X26EjH2A7qE8dX1FAFudBGRdibAZnP275Es+6C5bIvQO3PXdVHQSTRCZ9vGHjOOE+gxLhVtIrBhE0HkkQZd3sn/6Kte1xDy0cJxGJavhOnXEcM9JrlKmSAz3YlHHAnzkHbaVPdRhBZwQN6/5gZMej/Q7K9da2KpgnDvQwj+hy2bb33ugIVmt+T+qPrCTGVgLhzg3iBBhgGFjfW2pdFFOlJp/MkagYNxaswvqr20SU1r3Sw1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(9686003)(110136005)(186003)(7696005)(83380400001)(8936002)(6506007)(5660300002)(71200400001)(2906002)(53546011)(66574015)(86362001)(55016003)(66476007)(66556008)(4326008)(122000001)(64756008)(38100700002)(38070700005)(33656002)(508600001)(8676002)(66446008)(76116006)(316002)(52536014)(66946007)(54906003)(17423001)(156123004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?94xuVx+rxS1b6fvY4nktITcP+DlR9dmBpSNAgDySrcCgqjZlyjH8h/fSg2?=
 =?iso-8859-1?Q?jnk7mrobX4IBFsMXJUsxWikH+GCzfkpKkkabGE01boFSLgo6RI8PY3lnWq?=
 =?iso-8859-1?Q?l9O5Ka1+ySXhrwvNRttJ6UHoJQI+EdAGuA4KBDhlPn1XFgM11oFnuGZRO1?=
 =?iso-8859-1?Q?86c/T75bkTE9ErtoezFHD5fXQ307Rn9T2jRapZMSjHY5tvyODghIv/QMqe?=
 =?iso-8859-1?Q?GL6mcVCzfhGRWUGT/VQXjOoJN6VX/FGyOL+J6zhM2QFiO2JaJocjbEAkeG?=
 =?iso-8859-1?Q?CHD642dwLrlbjKOvwUjaXpIILOwXWDeL2znPwXkTG8+sEAoJixS1p3vKMH?=
 =?iso-8859-1?Q?yKcJaOJamn1zWBtj1x9H59j4P4+IrabgT55lyWzEt1JHxP4ZN93uTuzJHW?=
 =?iso-8859-1?Q?Uah7JpqQvy10p0E8JYdzh4myK60eg0U8RbxeuXjr/XqfVAtqRuWT/QCwXW?=
 =?iso-8859-1?Q?Sg+dO1lkl0iIYj/Lf3sopm2RoAYi41SsZPjycREqjQb4OiEi7KLrgJzYuK?=
 =?iso-8859-1?Q?//J25p6kp9TgWgISpsIrY2wJemP7KFWVDcGbIZ5wmLXWSNg2kXCcZu/BS/?=
 =?iso-8859-1?Q?ZX0EWAcjg8eR3SuxrSPl3J79gShwKgWHIPNkXwY3yLXZPXO/UncTbELcSJ?=
 =?iso-8859-1?Q?qvT60mIqI9vbwr/NTmW+OxfQKW3Dvm/IBUvdidwAZy2y+OM8KZOXp73B5x?=
 =?iso-8859-1?Q?mPoJNphNBA7mrDM6xatMcIxloreH0qV6nUItr8KsDXovxaFjW6k/2Z95cA?=
 =?iso-8859-1?Q?NT4TSNhkN7nX9gQ2OvxLZ68TSMp6T3aujkLomXCAOYT7oh7W771xEHnpq6?=
 =?iso-8859-1?Q?nnjKVLq5+Y/zc8mjD/dP4FRmiFIpO1nFBAqLJWRc83Qw5cl9B1vXHDJlvP?=
 =?iso-8859-1?Q?lkVW6ESN0YGxiTPDfTJtAqw9F3+BW1U2TlJXRjU10MhizqEV0ktW/C90SX?=
 =?iso-8859-1?Q?9rX7pDgbWYsefEk+wGC3u1Yyi9YZmTB5uR4IYrejBBqi8FS5qy2Bhl8IfM?=
 =?iso-8859-1?Q?1GJTnWlHGJi8QoPkBP3IEwsMYWh96ki4Utc5KDXqKlzj06tasIAmQEnaXL?=
 =?iso-8859-1?Q?2mRSoVX3zgj1iXZWurr/AnHg6ZBNUbtTbkto6pS7oG9QacUg+qyrdozyip?=
 =?iso-8859-1?Q?x/d77/rs/ATrzjiauQWYglTzy4V2EZjdwtb4Ksduu1Fr/x3tRxMzyahPNF?=
 =?iso-8859-1?Q?X7kONouR7CNA7Nc8AyG7JtZS5lanfYnpgIzgdKFigcq57ieydrS3GrhJbd?=
 =?iso-8859-1?Q?dBBVaa9C+M3LmE8316XznzQsHcLYrMAFgUvGp9jJGNO/S+DxOegVpqFAcl?=
 =?iso-8859-1?Q?yTR8Ksyy9RoNkcOFNFDHRxUUzW5wKUV96vyl44H47wR3VbMTHTV8CQijul?=
 =?iso-8859-1?Q?6U+h1PdUppM+k31s8xfHaHPW8pyi8RaRAlDMsgZLn4Qn1AtDSXouQ/1yHq?=
 =?iso-8859-1?Q?1nhTkJaBUum0ga58gl77jG4fwRLD2IOrh2hpkWuDQU+VfQeVI6M2oUlmsJ?=
 =?iso-8859-1?Q?0skAptv7u4CiEXfQTjZDBw5Wr7OUr2N8B97R1Yuey0QyyGcMZAH+yQwmqo?=
 =?iso-8859-1?Q?0qBEVRA1pDQMV9XOQI3HWgk3sE00c39zP4lJL5+K4+d0UaiKVhgYcy7k+P?=
 =?iso-8859-1?Q?qTCoIpy31w0CftCsHhCpfqRDPxsfxBo5Bagfc7fuxbzip7tEpXYv1oMVMM?=
 =?iso-8859-1?Q?NZtAyk2Z0Cm47LSupE4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB24698390D11135CF1347D9ADF13C9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d881de-8ce8-41ba-fcad-08d9f6dfd017
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 15:18:57.8539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlVnkxTW9I6F+AXyIcs4YiEgHKhlajTqhRUYPU4Wz3EBevuLgCPY+UMhg5m7CAqd2r67P5BmSbWB3ofoxJBA2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Xue,
 Ken" <Ken.Xue@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB24698390D11135CF1347D9ADF13C9DM5PR12MB2469namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Shall we add a print to aware user when failing to install a new ctx entity=
?

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Wednesday, February 23, 2022 11:06 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.fre=
edesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Xue, Ken <Ken.Xue@amd.com=
>
Subject: Re: [PATCH] drm/amdgpu: install ctx entities with cmpxchg


[Public]


[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken@gmail.com<mailto:ckoenig.leichtzumerken@gmail.com>>
Sent: Wednesday, February 23, 2022 8:38 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; Xue, Ken <Ken.Xue@amd.com<mailto:Ken.Xue@amd.com>>
Subject: [PATCH] drm/amdgpu: install ctx entities with cmpxchg

Since we removed the context lock we need to make sure that not two threads
are trying to install an entity at the same time.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index f522b52725e4..16eb1ee600ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *c=
tx, u32 hw_ip,
         if (r)
                 goto error_free_entity;

-       ctx->entities[hw_ip][ring] =3D entity;
+       /* It's not an error if we fail to install the new entity */
+       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
+               goto cleanup_entity;
+
         return 0;

+cleanup_entity:
+       drm_sched_entity_fini(&entity->entity);
+
 error_free_entity:
         kfree(entity);

--
2.25.1

--_000_DM5PR12MB24698390D11135CF1347D9ADF13C9DM5PR12MB2469namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Shall we add a print to aware user when failing to i=
nstall a new ctx entity?<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Wednesday, February 23, 2022 11:06 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; amd-=
gfx@lists.freedesktop.org<br>
<b>Cc:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Xue, Ken &lt=
;Ken.Xue@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: install ctx entities with cmpxchg<o=
:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com"=
>ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Sent:</b> Wednesday, February 23, 2022 8:38 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;; Xue, Ken &lt;<a href=3D"mailto:Ken.Xue@=
amd.com">Ken.Xue@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: install ctx entities with cmpxchg</span=
> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Since we removed the =
context lock we need to make sure that not two threads<br>
are trying to install an entity at the same time.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@amd=
.com">christian.koenig@amd.com</a>&gt;<br>
Fixes: e68efb27647f (&quot;drm/amdgpu: remove ctx-&gt;lock&quot;)<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-<br>
&nbsp;1 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c<br>
index f522b52725e4..16eb1ee600ed 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *c=
tx, u32 hw_ip,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_free_entity;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;entities[hw_ip][ring] =3D ent=
ity;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It's not an error if we fail to in=
stall the new entity */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cmpxchg(&amp;ctx-&gt;entities[hw_=
ip][ring], NULL, entity))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto cleanup_entity;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
+cleanup_entity:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_fini(&amp;entity-&gt=
;entity);<br>
+<br>
&nbsp;error_free_entity:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(entity);<br>
&nbsp;<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB24698390D11135CF1347D9ADF13C9DM5PR12MB2469namp_--
