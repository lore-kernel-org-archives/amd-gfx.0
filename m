Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484BC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B7D206E3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0u6nZYmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B7D206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032F289E50;
	Wed, 11 Nov 2020 08:45:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C6589DED
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 08:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJxb7/MKh/PDUH9Bn/ssIDj64Kyvq2at/bxZkOO5w3EgzlbEw8SC8HnM7OLIBIiIl5Az4QWaxcXyHkVG9kRZe4Ek63l/n8IQEg887df6XpLCzWyqnjq5F3oXUTpndDeaFjyhKV1VQQdC0aL849gR91acB9zrn3KgtWRNxSYrCu3kvbLnurSgm7ouio/SaJDDyYEr30pd3O/7b+Gjn8qQoYmXCVs+gyBQzGUrQ5vN6CIkSqa3NJduFXc852nNXOwf1QPeYS+kiPchHURrHCNBUlnnK9qXd76O6wHpFZZ+0ZVBgR34cEKLDwHVJVgEkVZfYBDhzdp1eOLCPqeGx8PLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAv6Tkl6SsFIQDGAqeo2UvMNEhT7NKjla2mXhpZXNww=;
 b=kFPGIv4fyqOZoBR44hNhJFgzvmsqjBTvFa34chkStj9oVh6aQcQTOOuQdo4QvHcl+PVv1isLL2zbXl0SYIcwlRknzy7qEAxXhcPIVUc/Jy8CqITxb6aOyCGzXelaAKHuQcvjkOGmRaWwUrCIxM6zhnSUUzwbVqD4YB76HRes1+8dDx1574xpkIOmuihdjApopxXzH1PXXyu9PAfJxCUnHaxCo0Ph/G2CuqiVPSDdOAjR99q+bvm8BKghkFRonueJxRFeWWrmB7GW3ZywRbV2+j8S7TPj9oYId7YsnUp35LHVyTSmRb7A5CPLJnKfflUmcFiEHGCYuzlEVlROmrkBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAv6Tkl6SsFIQDGAqeo2UvMNEhT7NKjla2mXhpZXNww=;
 b=0u6nZYmQKrYwP7GPXW/8mITnHcQ/n2tcsphCFjcMhjetJose17fU+Bd7rdVOdrTJnCrkoVRNXYKLdSlyWoe7xrkhxdnD0/1/j4CV8wVOOHK3sKhaiWhyjsOsqn2lqw/NzZ1t7qbAcm8sEAroKqpHs0MAV6mDnTDR0ILNePzI/+c=
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM5PR12MB1225.namprd12.prod.outlook.com (2603:10b6:3:7a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 08:44:57 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::8874:6c82:5323:923c]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::8874:6c82:5323:923c%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:44:57 +0000
From: "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Topic: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
Thread-Index: AQHWtzYdSWsDn+fVRk2L68si+uR7mqnBbMwAgAAhTACAAARvAIAAA5YAgAEHdNs=
Date: Wed, 11 Nov 2020 08:44:57 +0000
Message-ID: <DM5PR12MB1226652E58533CA35137F64EFFE80@DM5PR12MB1226.namprd12.prod.outlook.com>
References: <20201110074912.54097-1-stylon.wang@amd.com>
 <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
 <MN2PR12MB4488F51CB06882617DE3BD60F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <511c08b0-713f-2cb1-c323-5ea65a7f954a@amd.com>,
 <MN2PR12MB44888EC743B809BCAB6742B4F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44888EC743B809BCAB6742B4F7E90@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T08:44:53.135Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a773cf8b-dfcf-43f5-ea3a-08d8861e11bc
x-ms-traffictypediagnostic: DM5PR12MB1225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1225D054743E795C62CADF9EFFE80@DM5PR12MB1225.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhWC28HR+/ofBmaYt4t8uLESHq5ziUbJ8cHqj8ln1wPNiMaTUqtMSSBU30PgMUAkcQ3FLUyRj5vX5aiEAJuGrDQKT/czazDly5vA7pbpvINQYIvGKTkxYYx6snkgMR7k368ANNdga4lWFVFsQBc8TbwIxeDaXkAtwh+qTvdRxeGIeMJYMzZuIhzWCZqRBcg3t7LJ4oLvPj8JnwtG8qA7IK4FechNuL06lDgAYumQYJhTABHH5KCtbhKbArBcEKHwDVJvmU6cVAA3TzpKz8+eRARpEMn+K6xzFH8SAwgaTjiv4Kc2Nn7LspbJPoxDxcrPoFDIAmJpdgwZC+mGU78CWEfuzmV6GCHSovCMr13CROSczxz5fioZUR8bT+OGrCCZ6gsIcf6+CLick5lnNGyZ0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(6506007)(55016002)(53546011)(2906002)(26005)(33656002)(8676002)(166002)(110136005)(83380400001)(316002)(76116006)(66446008)(64756008)(66556008)(4001150100001)(9686003)(186003)(86362001)(91956017)(66946007)(19627405001)(66476007)(52536014)(5660300002)(71200400001)(8936002)(4326008)(478600001)(966005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: me8uGxXC9uF+redKUWuexrXtBiJmr4GEwdh7vlmq0JMQ4CPx51rLAP6Hu/Ajeryy5kynhSvVm+g2bZm1IZmmFvXFlhaJ73OPrSUyi1lbWfZVo5RFXAH/hJEJk0wWnyIeE30e3v/sdIQw05rA0DSaZkfcSzeYEv+BgVodaUzJ0/CE8zkU1dSqJ5bXRNckKPslY/SlnsIuncvzpSCZm02+6pluegg1SHsfztmeMgiC0DCc1vkMqDjy/av1kqsGjR86xEgnjpdaZatEvA3f/zlYCktp8eNTKVZ69hwicsX4Tgw32NcqRokpL20YrP9/05UwP8nf68eg6NOZDYiY5/96OfemZX7VXstgyJyJCKNI3Y6u9uDIH/KhLFyqZHZYwll15Pezhnz04Pvg836Lei7sqgDM1mQP1myaa2qlTG36O0D6tdhF5r/DhYlgrv96hK8kuRny6zljHsGQZ/o1INusWFc/uVn8Uzy40nIl1O3ImrRVTBKdXP4PpuynIiIkQod74viyd2v+AokdV2PBmXpjYKzWOjuwp/bMOrTKasJGLvvZ/FkmqS/ID6S7FfdKR7NW+sSig7GQxmqeAejryguTULV3tZTbGDg+2p+lAlUXRWtE8fzHP3N7+YHiWAfVmKWVzGb3vkUvjAI9DT23kuXva7bbTUknDBPF0I/cjOMJJmGeEzRvjzmHoENZf7YmAzRjG8Yw3XvawbWpFStoxlBUEnDaZEyZzftDqZj+gosTKFItwSs/qpVXsQZdTEvKsqY9PyagjeYZSTJnwpYDhF4ObIJ4oq4l7OTpBSRct+rzlWftEAm0Vr4K3WPzB7X69tXY2SB9wgkbokTiPQINb88oIVn9atJTWT0683wpmoZYN3DpRXfk0StstABDhoNPuBfUbF6pvDJfBZcLTtUEmlL5/Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a773cf8b-dfcf-43f5-ea3a-08d8861e11bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:44:57.6050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOAbLsCfCRUWIINxaATOowKFnMC89Tyb32l/CllAwFYTCnpnkVy21VxjyZxGpwOJWUO1IGjJB/hhAK6USYlPGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1225
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
Cc: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============1655632642=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1655632642==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1226652E58533CA35137F64EFFE80DM5PR12MB1226namp_"

--_000_DM5PR12MB1226652E58533CA35137F64EFFE80DM5PR12MB1226namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Harry,

Checked Lee Starnes's patch. It does not fix the issue but does preserve th=
e tradition of assigning the number of probed modes to aconnector->num_mode=
s, which appears elsewhere in AMD code. I observed in some cases the memory=
 leak is not reproducing (or not detected) even without mine or Lee's fix. =
Maybe that's why Lee thinks it may fix the leak.

Another way to fix the issue is to not wipe out the probed list by calling =
INIT_LIST_HEAD() in amdgpu_dm_connector_ddc_get_modes(). But I am not entir=
ely sure what other impact will that do.

I am checking out how everyone is handling resume from S3 so would like som=
e second opinions.


Regards
Regards

Stylon Wang

MTS Software Development Eng.  |  AMD
Display Solution Team

O +(886) 2-3789-3667 ext. 23667  C +(886) 921-897-142

---------------------------------------------------------------------------=
-------------------------------------------------------

6F, 3, YuanCyu St (NanKang Software Park) Taipei, Taiwan

Facebook<https://www.facebook.com/AMD> |  Twitter<https://twitter.com/AMD> =
|  amd.com<http://www.amd.com/>



________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: November 11, 2020 12:55 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; Wang, Chao-kai (Stylon) <Styl=
on.Wang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.=
org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume


[AMD Official Use Only - Internal Distribution Only]

Ah, sorry, I missed that part of the patch.

Alex

________________________________
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Tuesday, November 10, 2020 11:42 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Chao-kai (Stylon)=
 <Stylon.Wang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freede=
sktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

It's missing the "drm_connector_list_update" call which I assume is importa=
nt.

Stylon, can you review Lee Starnes's patch? Is the drm_connector_list_updat=
e call maybe not needed?

Thanks,
Harry

On 2020-11-10 11:26 a.m., Deucher, Alexander wrote:

[AMD Official Use Only - Internal Distribution Only]

Lee Starnes just sent the exact same patch yesterday.  Please review that o=
ne:
https://patchwork.freedesktop.org/patch/399497/

Alex

________________________________
From: Wentland, Harry <Harry.Wentland@amd.com><mailto:Harry.Wentland@amd.co=
m>
Sent: Tuesday, November 10, 2020 9:27 AM
To: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com><mailto:Stylon.Wang@amd.co=
m>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com><mailto:Nicholas.Kazl=
auskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alex=
ander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume

On 2020-11-10 2:49 a.m., Stylon Wang wrote:
> EDID parsing in S3 resume pushes new display modes
> to probed_modes list but doesn't consolidate to actual
> mode list. This creates a race condition when
> amdgpu_dm_connector_ddc_get_modes() re-initializes the
> list head without walking the list and results in  memory leak.
>
> Signed-off-by: Stylon Wang <stylon.wang@amd.com><mailto:stylon.wang@amd.c=
om>

Looks reasonable to me but haven't had a chance to understand whether
this is the best solution.

Acked-by: Harry Wentland <harry.wentland@amd.com><mailto:harry.wentland@amd=
.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0b6adf23d316..715e0bd489f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
>
>                        drm_connector_update_edid_property(connector,
>                                                           aconnector->edi=
d);
> -                     drm_add_edid_modes(connector, aconnector->edid);
> +                     aconnector->num_modes =3D drm_add_edid_modes(connec=
tor, aconnector->edid);
> +                     drm_connector_list_update(connector);
>
>                        if (aconnector->dc_link->aux_mode)
>                                drm_dp_cec_set_edid(&aconnector->dm_dp_aux=
.aux,
>


--_000_DM5PR12MB1226652E58533CA35137F64EFFE80DM5PR12MB1226namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Hi Harry,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Checked Lee Starnes's patch. It does not fix the issue but does preserve th=
e tradition of assigning the number of probed modes to aconnector-&gt;num_m=
odes, which appears elsewhere in AMD code. I observed in some cases the mem=
ory leak is not reproducing (or not
 detected) even without mine or Lee's fix. Maybe that's why Lee thinks it m=
ay fix the leak.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Another way to fix the issue is to not wipe out the probed list by calling =
INIT_LIST_HEAD() in&nbsp;amdgpu_dm_connector_ddc_get_modes(). But I am not =
entirely sure what other impact will that do.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
I am checking out how everyone is handling resume from S3 so would like som=
e second opinions.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Regards</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
Regards</div>
<div id=3D"Signature">
<div>
<div></div>
<div></div>
<div></div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><u><b>Stylon Wang</b></u></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black">MTS Software Development Eng.&nbsp;&nbsp;|<b>&nbsp;&nbsp;AMD</b><=
br>
Display Solution Team</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><b style=3D"color:rgb(32,31,30); font-family:Calibri,sans-serif; =
font-size:14.6667px; background-color:rgb(255,255,255)"><span style=3D"marg=
in:0px; font-size:9pt; font-family:Arial,sans-serif; color:black">O</span><=
/b><span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; =
color:black; background-color:rgb(255,255,255)">&nbsp;+(886)
 2-3789-3667 ext. 23667&nbsp;&nbsp;<b>C</b>&nbsp;+(886) 921-897-142</span><=
br>
</span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34); letter-=
spacing:-1.4pt">-----------------------------------------------------------=
-----------------------------------------------------------------------</sp=
an></b><b><span style=3D"margin:0px; font-size:9pt; color:rgb(242,101,34)">=
</span></b></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><span tabindex=3D"0" style=3D"margin:0px; padding:1px 0px; border=
-width:0px 0px 1px; border-bottom-style:dashed">6F, 3, YuanCyu St (NanKang =
Software Park) Taipei, Taiwan</span></span></p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
<span style=3D"margin:0px; font-size:9pt; font-family:Arial,sans-serif; col=
or:black"><a href=3D"https://www.facebook.com/AMD" target=3D"_blank" rel=3D=
"noopener noreferrer" style=3D"margin:0px"><span style=3D"margin:0px">Faceb=
ook</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"https://twitter.com/AMD" target=
=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><span style=3D=
"margin:0px">Twitter</span></a>&nbsp;|&nbsp;&nbsp;<a href=3D"http://www.amd=
.com/" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin:0px"><=
span style=3D"margin:0px">amd.com</span></a></span><span style=3D"margin:0p=
x; font-size:10pt; font-family:Arial,sans-serif; color:black">&nbsp;</span>=
</p>
<p style=3D"margin:0in 0in 0.0001pt; font-size:11pt; font-family:Calibri,sa=
ns-serif; color:rgb(32,31,30); text-align:start; background-color:rgb(255,2=
55,255)">
&nbsp;</p>
<p style=3D"margin-top:0px; margin-bottom:0px; margin-top:0; margin-bottom:=
0"></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> November 11, 2020 12:55 AM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Wang, Chao-kai (=
Stylon) &lt;Stylon.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-=
gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Ah, sorry, I missed that part of the patch.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry &lt=
;Harry.Wentland@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 10, 2020 11:42 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wang, Chao=
-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; amd-gfx@lists.freedesktop.org &l=
t;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<div>It's missing the &quot;drm_connector_list_update&quot; call which I as=
sume is important.<br>
<br>
Stylon, can you review Lee Starnes's patch? Is the drm_connector_list_updat=
e call maybe not needed?<br>
<br>
Thanks,<br>
Harry<br>
<br>
<div class=3D"x_x_moz-cite-prefix">On 2020-11-10 11:26 a.m., Deucher, Alexa=
nder wrote:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Lee Starnes just sent the exact same patch yesterday.&nbsp; Please review t=
hat one:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<a href=3D"https://patchwork.freedesktop.org/patch/399497/" id=3D"LPlnk2605=
81">https://patchwork.freedesktop.org/patch/399497/</a><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry
<a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mailto:Harry.Wentland@amd.co=
m">&lt;Harry.Wentland@amd.com&gt;</a><br>
<b>Sent:</b> Tuesday, November 10, 2020 9:27 AM<br>
<b>To:</b> Wang, Chao-kai (Stylon) <a class=3D"x_x_moz-txt-link-rfc2396E" h=
ref=3D"mailto:Stylon.Wang@amd.com">
&lt;Stylon.Wang@amd.com&gt;</a>; <a class=3D"x_x_moz-txt-link-abbreviated" =
href=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_x_moz-txt-link-rfc2396E" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Kazlauskas, Nicholas <a class=3D"x_x_moz-txt-link-rfc2396E" href=
=3D"mailto:Nicholas.Kazlauskas@amd.com">
&lt;Nicholas.Kazlauskas@amd.com&gt;</a>; Deucher, Alexander <a class=3D"x_x=
_moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">On 2020-11-10 2:49 a.m., Stylon Wang wrote:<br=
>
&gt; EDID parsing in S3 resume pushes new display modes<br>
&gt; to probed_modes list but doesn't consolidate to actual<br>
&gt; mode list. This creates a race condition when<br>
&gt; amdgpu_dm_connector_ddc_get_modes() re-initializes the<br>
&gt; list head without walking the list and results in&nbsp; memory leak.<b=
r>
&gt; <br>
&gt; Signed-off-by: Stylon Wang <a class=3D"x_x_moz-txt-link-rfc2396E" href=
=3D"mailto:stylon.wang@amd.com">
&lt;stylon.wang@amd.com&gt;</a><br>
<br>
Looks reasonable to me but haven't had a chance to understand whether <br>
this is the best solution.<br>
<br>
Acked-by: Harry Wentland <a class=3D"x_x_moz-txt-link-rfc2396E" href=3D"mai=
lto:harry.wentland@amd.com">
&lt;harry.wentland@amd.com&gt;</a><br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<=
br>
&gt;&nbsp;&nbsp; 1 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0b6adf23d316..715e0bd489f8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(<br=
>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_con=
nector_update_edid_property(connector,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;edid);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_add_edid_modes(conn=
ector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;num_mode=
s =3D drm_add_edid_modes(connector, aconnector-&gt;edid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_list_upda=
te(connector);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aco=
nnector-&gt;dc_link-&gt;aux_mode)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_set_edid(&amp;aconnecto=
r-&gt;dm_dp_aux.aux,<br>
&gt; <br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1226652E58533CA35137F64EFFE80DM5PR12MB1226namp_--

--===============1655632642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1655632642==--
