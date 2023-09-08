Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D538EEEB569
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 19:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4711810E941;
	Fri,  8 Sep 2023 19:55:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCC510E941
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 19:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XokcXyt9685gG390dzUNRUV0uVHsWv7cS7QStBCdr+CKd1XqN+dpMEOl3Q0mbhUp7DEjVbuHyGJA+xsZOd9wMKBktQdcWQUSErwPyamv+XmLsyWcL38kGsETsPq83Vs07K4l7zFjq1Um5uqcwUie/8fDiX7gD/vkEGEsq8wK73S7Jm3QcTQLXNoFjLnFQceWxWMB0v00ySPEkr0TCFcIyfh5gGclKxdASmNzFsE/4SRj3BqKVgCiWQH0Yj1OahhGir2YuxfX02IM+9gTAWGFbRR9Ij2CL2FZc0UR0z3XkuRbQ1GDOS9RbbzV2HGFUmRwgju42CcMarkXYflpOfQN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg8+4mOQneBEMF12ukJ3IfTzDxWO6GkbrPLjP7TIuno=;
 b=Rgvx81Ah5CpfDWmgkdNo9CR273mk6n+G/tuGAk4sSkaDiRJkh/QTXDefKW3YKA4MFMIvB3z1eSIYXUEnJPOXTzKjfUECMkEcozvmJVU6JRWF/u4dYh6pa5B4riEAGcWfATjY5QYBgFKUHTbku94BRK5cQB7LosOXG5FPa4+o37NlndFuRx6mY2rGm58Vvc7crVrrA+RYEvtLl4G3wyZt3K/qDDQXPn8AeOEyHzQ5zwyE+zi2P41Y9TAsNU6Yu9moMtlo90lWkW6DSYPGPk0Xq73AYMZo4vm5ej8rcg3EHVwT7GHsmTVfntR+4XgUV84MGZmsNhQBVJsPB6OzBY24zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg8+4mOQneBEMF12ukJ3IfTzDxWO6GkbrPLjP7TIuno=;
 b=nYmgNFe00i/MRL+u7YiKV/9PVUrnhfBIasBHX93TXHqyJDDL3ImKe4cgiIq1bg9o2anFjeYlDeRAmVS1R58c62iJybuNsJO3N39T2LXLRmjh/LVeYHixBc4fGqiEIhEnTiFt02MM5KEZ14CKPB1+anq4t5euPQS6//Hp0i9Tnec=
Received: from IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 by MW4PR12MB6900.namprd12.prod.outlook.com (2603:10b6:303:20e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 19:55:37 +0000
Received: from IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::2ea7:3e66:b686:bdbc]) by IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::2ea7:3e66:b686:bdbc%3]) with mapi id 15.20.6745.030; Fri, 8 Sep 2023
 19:55:37 +0000
From: "Tsai, Timmy" <Timmy.Tsai@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for
 SR-IOV
Thread-Topic: [PATCH] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset
 for SR-IOV
Thread-Index: AQHZ4cQtSTi9F+wgEUWS4fIXgbK1GLARV3qxgAAAyyw=
Date: Fri, 8 Sep 2023 19:55:37 +0000
Message-ID: <IA0PR12MB871302C006C3A0398C03F10698EDA@IA0PR12MB8713.namprd12.prod.outlook.com>
References: <20230907194712.501666-1-alexander.deucher@amd.com>
 <DS0PR12MB88130DE097FDBDF8DBF03A83F4EDA@DS0PR12MB8813.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB88130DE097FDBDF8DBF03A83F4EDA@DS0PR12MB8813.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-08T19:55:37.102Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8713:EE_|MW4PR12MB6900:EE_
x-ms-office365-filtering-correlation-id: a35bed55-97e9-4197-63a1-08dbb0a5928e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MuyVlAqHjO8ZDdhWDsXkklhjU89CcIPHR0f0t4bxTP8//43s0t86fwKh0GCKjZSOvH3y46a0DyE8/1WtUuF0t2ixyweJ6Oy4xDDN/GBdM6SirrnFATCMGETUIlH1OuimScVMtkvK1jst8CmgE+3bZ0q/7KXQBYaeGOKaLlZFWhoqb27rNMygX4VcIhL+hkF6ltuOCh/QItSuXzpGQHoFWGbKvZirYasqHpFlP8Amk2WViRcv1dVoe4WhEQT9i1juJyAJj7qm+J59Q08NFgHZJX6mn+5HzzxrrcN12Vn9KfTYfSQK/sRhlydlGq09UsnGeHFFlPR6ke/8IRY5A1E66itxw/3KIqG5CmeHonTzrWzsTTdlm4kHWPwqslopRvbZgP+tXIwz0IUMfkEYsaIy5u905/4EEsUqup1qiOmbBl8379jri2dT+el0PKwPdnZ/1ybaKhNOyOnybGNheIFUEjhSYJeE9J1QOUcNksh8fR25illsN/I46izlerDnexlD7TGMR4qHQ/Ar7NFxsjbE7UKH71t1Zgd9RLDXcGaKwBlUAIP7CEP9oFOewyhkFEdLbBC9ITre7u4SmWOwahrLvFne7XcCOS138HV0R6K8H3aVj+tKnisEtv/KYMZ38h/t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8713.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(1800799009)(451199024)(186009)(38100700002)(55016003)(38070700005)(122000001)(2906002)(6916009)(91956017)(71200400001)(76116006)(66446008)(19627405001)(66476007)(66556008)(64756008)(66946007)(53546011)(316002)(6506007)(7696005)(9686003)(33656002)(86362001)(478600001)(26005)(52536014)(8676002)(4326008)(8936002)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tfML1VDD7bnBjaJpocQ6veOMZOzLEvArxGyPGsiWQS4NPJobguVfP69F3e?=
 =?iso-8859-1?Q?iN0JIxNuzYbgy+uGTSeVmX6HIvojXaVV2UiBTfWorw33lnWg2pl2BceCVd?=
 =?iso-8859-1?Q?j4jQOlmu6DuRn9IjitxXbeFj92Mn8+o6z49YM14SWGYiBN5OaeHEqKu91L?=
 =?iso-8859-1?Q?iqCgdK20eeyckuUhaUikj/k8nD8XTcX7LI2bQmqQv2cl1mhL1VwNvIRrZG?=
 =?iso-8859-1?Q?kpjsWcDhyL3giSuoM6X4GEzluXPGv/gwgEGAJ5fgC5SxoFxkjwirlaJTl/?=
 =?iso-8859-1?Q?nn0yiirqnt8RiAlc83FypBirIQaa6JcjaHvSIMHYkJZ9axtOjUw48g3flN?=
 =?iso-8859-1?Q?JkD+4ubxPmQVWJzPE+f5MA2rBLH5MHU9ssBkYAEoBTT3pwBb28f4pIuGqK?=
 =?iso-8859-1?Q?C4MGvtcHu6XLqeGpas+xMgmbE06DE//ZHYK9ILt+cd5OlMA5MuSmRlrE6J?=
 =?iso-8859-1?Q?Ft32uAK3NrfaxuPyBt/NQsD8a4G17F25lud0CGH2PeUSeMdpa5T7AuadEj?=
 =?iso-8859-1?Q?0+M2QVJ+8dPfSf9va1ytaWUw7scJsTHiRwcZ0NoIpKrN8mMGfNpSq6Mo7A?=
 =?iso-8859-1?Q?fbRAB6UanRzltTey2u1u1lX242dRMkg4fXpAeTL9sZ71oYKaILSIZaRyyk?=
 =?iso-8859-1?Q?8vlByaBHE4+d7LSkgGVWP7+R//L3HWioYGtyg46CXiKnDch28Tb5gk8Dfj?=
 =?iso-8859-1?Q?WY/UFDgjleO9ai+kNc91maULzhV8C2UGx+BQtX5CMnA8dmj2durEMvpvX3?=
 =?iso-8859-1?Q?avo99hSfJskGdoKZM61CUo9v6zgTbu5iaKHP8YIAAAyZx9FdO8SN8qOKUX?=
 =?iso-8859-1?Q?svXyM85s5qHtJahOGrO6wBAwZbBTq71IxOp2ke6M9nJGkwJS3mGGX043VO?=
 =?iso-8859-1?Q?WcTC1q8cB30yfh6ZMEDaKUHFkaTFFBkLBhj8E5Fg+EdfB6gee3NgujeRr6?=
 =?iso-8859-1?Q?+yOphL4RK+xzhsHWGsC6+0VrjkDpFIZHTk9dflN+WIwUom3LiwyEFv/WZ0?=
 =?iso-8859-1?Q?qY5EhX//J1jRhaZ8oOMw6ywcp0Yy9L3SM7MC7h5bQ/tvf6pjx5w0bk9rmH?=
 =?iso-8859-1?Q?e7x2JbytqOl8++z6G6axqivjD91HjvuNZ1Rgkxlu50nR6+OsJeEqad5daQ?=
 =?iso-8859-1?Q?F+mbp/K0tPBMJqDOlin0kql1B+C2UJuf6Kz2UdrepRMAeZDecQlOCMYTZE?=
 =?iso-8859-1?Q?PnyCr7PKsJIAto1ZvBmaKU7i/2kjGIZVtuQVzfV6jK+MDS5T4wrY7jZNvs?=
 =?iso-8859-1?Q?AKlF4YF8zQpaqmEN9BBRpvYGSXKVomf7kYB6V8t7fQmWduvRMRQ3jxeJIS?=
 =?iso-8859-1?Q?79al/EjrkOSh903s5e2t5WDStMX5bapt6NL6wemljP3S2JPmUZjmFLwBmx?=
 =?iso-8859-1?Q?V8MNIRpumhdJV2s+/htJ5Fhr1e+ELazu6zNeBbauazZsgl7wOwFj1cpj4p?=
 =?iso-8859-1?Q?lqV7szGCeq/nDVSuPVvRoCvACK2SpejXHJs1mOYkIbvTcd9Wkc39qufX+6?=
 =?iso-8859-1?Q?dzMyvsvcySuG2wK8mMNjaJSzhft0ckJCBojJHZlrNx5vpbB+7x7447M+kR?=
 =?iso-8859-1?Q?T7CPLbiQnqI/LAOwtPKWzQI+5PI50lzYc0US7hkC9mxb0tnwLugJbEj8wl?=
 =?iso-8859-1?Q?ZPcbGtoQr/euc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA0PR12MB871302C006C3A0398C03F10698EDAIA0PR12MB8713namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35bed55-97e9-4197-63a1-08dbb0a5928e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 19:55:37.7477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61YU7p/X424lz3atMziHgxzBk9keo2XEconME8hCTAUgRkyPdn489EL0qUOrhd9qRbLrQp9dnZ6BmnTaU1PNiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6900
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

--_000_IA0PR12MB871302C006C3A0398C03F10698EDAIA0PR12MB8713namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Timmy Tsai <timmtsai@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Thursday, September 7, 2023 3:47 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for =
SR-IOV

Needed for HDP flush to work correctly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c
index d5ed9e0e1a5f..e5b5b0f4940f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -345,6 +345,9 @@ static void nbio_v4_3_init_registers(struct amdgpu_devi=
ce *adev)
                 data &=3D ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_=
F2_MASK;
                 WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
         }
+       if (amdgpu_sriov_vf(adev))
+               adev->rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,
+                       regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNT=
L) << 2;
 }

 static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
--
2.41.0


--_000_IA0PR12MB871302C006C3A0398C03F10698EDAIA0PR12MB8713namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
</div>
<div class=3D"elementToProof"><span style=3D"font-size: 14.6667px; color: r=
gb(0, 0, 0);">Reviewed-by: Timmy Tsai &lt;timmtsai@amd.com&gt;</span><br>
</div>
<div dir=3D"ltr">
<div>
<div class=3D"x_elementToProof" style=3D"font-family: Calibri, Arial, Helve=
tica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b> amd-gfx &lt;am=
d-gfx-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexa=
nder.deucher@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 7, 2023 3:47 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offs=
et for SR-IOV</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Needed for HDP flush to work correctly.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c<br>
index d5ed9e0e1a5f..e5b5b0f4940f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c<br>
@@ -345,6 +345,9 @@ static void nbio_v4_3_init_registers(struct amdgpu_devi=
ce *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RE=
SET_DEV0_F2_MASK;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;rmmio_remap.reg_offset =3D SOC15_REG_OFFSET(NBIO, 0,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regBIF_BX_DEV0_E=
PF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) &lt;&lt; 2;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_IA0PR12MB871302C006C3A0398C03F10698EDAIA0PR12MB8713namp_--
