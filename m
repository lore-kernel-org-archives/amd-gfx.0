Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7867FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 06:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F222010F02D;
	Wed, 19 Jan 2022 06:11:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 005B310F02D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 06:11:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbos4SXt4AgQ2PuPF0DvS4lxhqEn1gpp5NdRzWdfKCldvZukhoZjyVCF2bxNCSRRNHkXesWNBjeHOn1L+86QfueC88WCYwm1RDYT+XdoVeZ3g07+Roy6gYhotPeB3lmm5Vg3WheWOUEoxBSHM/H0R4i3TpfKHttLZk/n56uGhVdAyQyRx+3tf+9jeVANLW289m/w7m6NPiXJ2DM9Pf30F5j+RVOF09Qd6mR9W6c4bW/iT9JBD/k1W93IvYmfC0d8vypVTf/72h5xt97/DxbWuGTh/sYligG5AO3vKKm2NcSpXoxUnclXXiirdnT1cTL3n8j00cRoYWzE+0/kAQAY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBx9iMLiwl9mcphjtGHNFDOY31AMETQcC2WGwd5fKSo=;
 b=P1weSfoiUpTTfr2Et1nv7rS4Gk9hj/jS6n5saOJmQTeiUJsxa4gWEgAlqsAFMtIcbilQjggktxupGtP9LNv0tFGZ/UKvENDF+IyrKvUz+yH3H8GxTQZnRcOkGw4zwXzSxnPq5wIJGkg9Dk2ntClzkMknOfR+KApczue3kpt+Kdgx2nLPQYwJu31TP6Z+sJ0ecwl0ftqw8UPKe1niPXThpxcoXIBcH/y4oGlSQ+33m+4i+awd7w4LnCbHrWejT5/B85eeYyA6Z0ROPNJTM9ckiQcD8nvSe3yHhCYytfAwuI2JTojnHoKTqYhkzbETY4Jk/BcblqMB0z5+5S3swxN40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBx9iMLiwl9mcphjtGHNFDOY31AMETQcC2WGwd5fKSo=;
 b=VCwabMyVi6/oqO8f5cZ8ZLRckRc5LazVQUHZUoaIeLUgXJLM2XrfKbFJx6CrYtrYJkZ6D3TSyU8r3f4CjPGiJ+GBhnr7c/gN9nX6DvOOLIWkWQsko+0irn9ESGWNlG44onOX3biBS4xjagL/WQevnhbGy/kXiFaGIgs1CpvsGjc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB2745.namprd12.prod.outlook.com (2603:10b6:5:45::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 06:11:40 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.014; Wed, 19 Jan
 2022 06:11:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: Remove repeated calls
Thread-Topic: [PATCH 1/3] drm/amdgpu: Remove repeated calls
Thread-Index: AQHYDOA2YTfkoL722kOzO9H+MMn/3qxp3Quw
Date: Wed, 19 Jan 2022 06:11:39 +0000
Message-ID: <DM5PR12MB1770879D1E1DCCA8FBC80390B0599@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220119025555.197467-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220119025555.197467-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T06:11:37Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e8d2ad1a-6c32-4c08-af9e-6a08a3701dc7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-19T06:11:37Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 433bb31e-d8c0-46fb-85a6-72f83f6d6847
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34bffb43-027d-4733-9aa3-08d9db128ec3
x-ms-traffictypediagnostic: DM6PR12MB2745:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2745C40EEE56E6D659A59AD3B0599@DM6PR12MB2745.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BlEB7j7zF5tSxztFrCeSTe/O2otnREMEZIjrISAj7gGQqRcP1m308gWoQmB1VgqGSRh3efaoskDeQelFLg4sILEvRHC+HwT1pW1oENz1tzDj1yl32Sn+U/wpepMvfVMELpqDhbwgQdfiMnnGnG06uxprTr/E+1KoGUrF4B7wv1YEITdlNzpK0PA2H8tOy+MmoEI9NjWDuIM5KdUxOwJm3bebZXEr3pf7bzk0eBbvKUYzEksEDopL0F4Whd3Fr0LecUZ5q8OwhMCkxwIAj+kj4NAHdvlsltf2NB1l39ceyzCAUXsXbotqneqpyFY2F5v4cY+D/96YTLb8YOYlUjYUGgOu/rMvxfPzQ7TwH4CREwPDDwQ60Aa1fUnXEm1LV1aHahoTLpBec24036AUo3xjn/SGn5O2pUKyQQhtEtIoii2MKLVWQAKSEH8sqRiLOlrHZW7NIlMuwWZSaskSHTsy5I+SuqUlnh2h4czJZzp0VEmvIDK7/BLvjUvEhrGSy8ezTA48ymTm++vY7BDGOMXeW6S8Yg/01GSjYij+jserO9awT/ZKJo+B8p694C6lN21Pbax//MtCNEllXUMC6fd0cOyS53uO3WOThoIJpWzqUtAD5ACn+n/QWTlYSd3gu19ExcrRN7D4jlV5Lb/a/BBXVtWh+r0502Ucm1V619wiTVpKNrrjBXfN3tHzh2G2WWoLsBFqRYNEoZiKT/mes/vA8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(122000001)(5660300002)(38100700002)(52536014)(26005)(55016003)(33656002)(6506007)(53546011)(186003)(86362001)(4326008)(66946007)(83380400001)(110136005)(9686003)(316002)(7696005)(508600001)(2906002)(38070700005)(8936002)(66556008)(66476007)(66446008)(64756008)(71200400001)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sN1QnBnAJyOpd8MtS5vbgOW8LNw64od8OWGFePDw3SE6ggk2jIpg0uxybjSC?=
 =?us-ascii?Q?H1mopKW+9tZR/CIV0AG+IhFBOmwCZozn873n4wvas7y7Zz+U1kqsLdr/t4gI?=
 =?us-ascii?Q?UjEpcd3JwAF90MgPTZxyOkYuvvM/dmen4VLSnXd8FyDwrD/HyUc442VLwPZX?=
 =?us-ascii?Q?5QT4T+5D3gkx1p7sdNE1I5J3qfTGfJh+Eflqg5Es87sKOoPMxks+TI8Yqmcj?=
 =?us-ascii?Q?YNtc4N88GUuxJt6SiGjWFwnw9V9BBeH32DeCpMAbJ94zFPhnoEr3Ut97e2Sg?=
 =?us-ascii?Q?9jcNXD5eIzdc9DCSr9IUTBA4YY82DkAkQG6H0VFLIFhMEl+rHCDcw2bJxnh6?=
 =?us-ascii?Q?KbHbqljq6F+Pub+9qfQ575MPeAAr6AsqG/A+1goVQgdaEc1FBvamOGUfoM1e?=
 =?us-ascii?Q?fx4un2/j+Lf04R667QdZFPjsycyZLhQJKM1xdsOkViMp/ozq4vJVT6Y/rjzF?=
 =?us-ascii?Q?iW/l3CwEogrL5NjXSx9D/aP4Q7UgXiLTe1i90ER8QVZvOdDbKC3TjJTNYqTp?=
 =?us-ascii?Q?WXEk/bDeYGWaUY1bjNNBm4QOueIpJqWALBNV584D5g9SMa1RtfmaBdJhmvF8?=
 =?us-ascii?Q?jAlE/EUQv4zb8ok6A+P7lybw4yjX+ehZ42MmpObexPlYhSRFHcQnwjCmdbYb?=
 =?us-ascii?Q?OhzoPwN20FV2cN+Nk/pCzGXvJ1cftNusIGSvnk69nB/yQJ2Iv9zO9GV0uy/b?=
 =?us-ascii?Q?6I+Q/T9H1pfviFbvfT9aNmVN5CPbMn5K/RzljcqWbFzcRLhw7Fj4QsofoiMI?=
 =?us-ascii?Q?wSGjphYDWHeVze3bRvOW67chXm85JECMiUtgOH831ISg28IdciPNsuh3J+1I?=
 =?us-ascii?Q?As++H+IB1duJHjSpbCwZMCFonaTIBN/B95QcSCCgM6WATsJwOqRncJRD6YtO?=
 =?us-ascii?Q?6Hdlp8tPQ0yqJMkOcbj5iYTdtuIBIM0MpwAjSa10NJlgWtzrwJ6s3Ht7+u0L?=
 =?us-ascii?Q?JTsIUQxG7GNkcKGCIugMaKRSTGK/oIMQ/bmp5p45EhtQkMHbo8tTTt+VhqhM?=
 =?us-ascii?Q?SBd989u5jq4P/8akaLnqlgje77aMijDjDM770lxPzVqIFZOmSmEwxO+NeHqt?=
 =?us-ascii?Q?ZpLiXcven+bZfkls704F0N1Fy2VH5NRRptRw4/aZt9ZrD1cBVx3gQZfPor+v?=
 =?us-ascii?Q?oC2uwdg3ijROTc+UOdE5eoSE2oGImn25BtVaHD4MiJMq+IuSBSD+lPxZw3yj?=
 =?us-ascii?Q?plmrnuEgm4rPEx2+P/Z72gdUS+RiADXcKyg9Oxc1x+HZ8qwN9EoSEBZzce32?=
 =?us-ascii?Q?1/tbDLGrjrguFfvVNLUpSXpm84/OUMKcRL0nz/PqFX9yYgGAA5fGSaktbcKV?=
 =?us-ascii?Q?AUBV67LURg/ckgprpL2op0vhgfggj0xpBAEohg+zhlrcV06V/sPofRyELk76?=
 =?us-ascii?Q?E6GuZo8RbocIwz04cZzz/IQ1kEk+MqzAtHjZ5gw6VIhyGHgZ5Smj9fgFQTqt?=
 =?us-ascii?Q?HWnFgimYzqpnn+prHUOt3E+EoVuSv9rmRuMK9bfRTlchJnWL5iPkarFbFjU7?=
 =?us-ascii?Q?+qMwmFblsQ7DVDnfb+b9LxJcuIt6HoWTfZRNaRAykrWc30XcXU7gx0sKkXjE?=
 =?us-ascii?Q?08rGjbW+YaTudB1cR4E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bffb43-027d-4733-9aa3-08d9db128ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 06:11:39.9932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwYw+mm0RVZojL4VlQqkfAbpKNygYJ8Iv0B5bjfrq+JzaJVPVueIay1G2o+RNfH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2745
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 19, 2022 10:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: Remove repeated calls
>=20
> Remove repeated calls.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 7a1d2bac698e..4992bc554c0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1704,9 +1704,7 @@ static void amdgpu_ras_log_on_err_counter(struct
> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					  struct ras_query_if *info)
>  {
> -	struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev,
> -									info-
> >head.block,
> -									info-
> >head.sub_block_index);
> +	struct amdgpu_ras_block_object *block_obj;
>  	/*
>  	 * Only two block need to query read/write
>  	 * RspStatus at current state
> --
> 2.25.1
