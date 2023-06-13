Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C7FC77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 13:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED8110E14E;
	Tue, 13 Jun 2023 13:25:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EF710E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 13:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3QELMgxBpOsCD/n791nfSoNzF0paPffQs3NU4oFmbHFSRP9IxVJZMI9NaIIQL3NBm04ppDYyLaAOn7YcEHVU4BMbDhP/PuAOXR3c1hIpC5EXvE+X7ERd4YTJSUWLtwvq4Xy2x1CT0K08YPUNy7ZNumOtEF38I4x/pheXZbGpYVGY6Tb688Oug00F03/pWgVIP9+jy/0YadDr8kHL1er5CM0lK6Atbf5bkcN2ABOVeEKEGtQAeMFcbz1V0dgZk598kF4kXwuKPoCGyf45j/pkRxe8KzDyISHMfcUst5XsPvXvNfaZzMwSFNQfpFIYpzoSNbYMv+OaUs6lJZHl4eK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgbX564y1/uv5miM/MGpXF0xmhV24X6jaYTTzDvaOOQ=;
 b=mO83Cal0req9UIFArdzGmozPBzkQ+sfHPLLL9WdAcVo4sAc3J3tOpMwhUm+uASGoSpt6P7P0Us/hlvbT3wB58XFYiuFljh25vulhdwWRp469S7JoQIViKRQ71m2AFePINlgkP6ke6MZYIgDcEViqTAB7+oigBLEChWYcDsJfPuz0WjpuZ2bZdMiDrNZ3vTPPNg/2DMm5Vz7l0FULV5B532jiZb26so3n3HT/6Dbi/AJlur/aAKJzVNAe+IjxNc78oW+42uwMhKKyzUl8sbRp4r55OB4M1bkZB5eKlEkP70gPndSC7AdZ5NwpLl3NgCHRi1NmY/LrgYOvkVX5qLCDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgbX564y1/uv5miM/MGpXF0xmhV24X6jaYTTzDvaOOQ=;
 b=nVbjj4sQrXfMwf1J2+r5fVrQ3TLyVqNoytN3BIXPeKNSOAleJ2mQA2J9Xby+NqJt2AL73Z8ZT7Qwb7jPR3ibDf1O9+db2w99KHNDStpPV2Wh+//94ut7OiqntaEWnpAokAta6FBsOkdytLGIFr8+RooRPk1tHrUnuhHnnxAj11s=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 13:25:51 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 13:25:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Topic: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Index: AQHZneVlsFJsx+LSWEGf1mE5Nc86ra+IuUX+
Date: Tue, 13 Jun 2023 13:25:50 +0000
Message-ID: <BL1PR12MB5144D9F55EA2C1E8DCCAE572F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230613105354.1561876-1-lijo.lazar@amd.com>
 <20230613105354.1561876-3-lijo.lazar@amd.com>
In-Reply-To: <20230613105354.1561876-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-13T13:25:49.935Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6200:EE_
x-ms-office365-filtering-correlation-id: 148532b9-1f6a-4299-d306-08db6c11b4f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AEmqqvRDXsFUcNT8aP0uyaCd0Skm3i5srmMnEXTATmwQCsXiug0dUT2HDvluqnjEo+3m+zcHDj/zKiC3TxdKtkenL5eg7sAQNiqKFsG92McMo+Fj703P/lP7Wl/58iLjOjpiUmT5vICB9YZC1zci2BEW1UsAliHrSAGbHNCVOdaO9W8/nwnPlKPxuRSQxBzXfkpTEJ8LevPPXTUPjitpVMOmYjXmU/INHwFnv4tO8M1a7uA42xCVHuPhps9cTKnUUzeCDonTFiawwthsQlaC5G4juLFPM8u0i5DM7nDffsWaCszpwjIQTKqq2QpUq8lENqaCLXJ90IUemTES32f8aHIhaJFTVePmtzkO3tphIfVPcZlYH+mZDefSO4W35nbC/ro2p+DB0UM44Q8s+jSm9/aLiJJ1tciSQGb6WczKcB8Jb5GrIHSOAl9lyheGh4YdwVmd9wEVMhKJQONll7KoSVGMxDlLEbpV3J0focsEHEwPo10yMQm07YsSvppZLAt2GNY4h+OTtXaM3h0GpQjwCeLYStI9U3u68HFR2K7Jq77EMtGhlFiDsIY+aa25Lv6wxXhLPqzjpS5SGTxf2qK0J6UZ3eKLN7a6Br3uS+wLz6MC8niEAacKZMNW8kJdHMRP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(19627405001)(64756008)(83380400001)(55016003)(122000001)(4326008)(33656002)(316002)(7696005)(66476007)(66446008)(41300700001)(38100700002)(38070700005)(71200400001)(9686003)(6506007)(53546011)(66946007)(26005)(76116006)(2906002)(86362001)(5660300002)(478600001)(8936002)(8676002)(52536014)(66556008)(54906003)(110136005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7haVnTDbgHPHC9pJRpO1B+17AfQuAtGFAasDRuMkwjd/c7WT87OPHWo4y6O9?=
 =?us-ascii?Q?vDZ1vSQDm0q8kTq5vL8lPR7v5GOeFZYuAe4W9mg3NGRr5NnEHY+JrZd+CgnZ?=
 =?us-ascii?Q?bTu+l/GSgXLYvOWXBaOL5IoVJtsztIcuHyZzcqjDSKO7ONhZWni354N6Rx/g?=
 =?us-ascii?Q?CPROFXYW04LPDW33cMeMxqRD4UKnvVqrzW34SHQAfCeS43qIQAvJSJwwnLdT?=
 =?us-ascii?Q?XAYgMGk5urSkqxuwR8g6qWde7xuY1FJM4npeqOXtjw/8AZaGgt+9i50/rk67?=
 =?us-ascii?Q?Wj466mHsCDZLSm0InLF1XlqNqvC5i7vQDhKLQqCCKn/KiKwxV85w8QaDh3Lg?=
 =?us-ascii?Q?rQpuCy5rt22KmzFYcWyXt+WfH9i6A+efr2xKwAhreVSYpkO/uMHcw7G/RtKY?=
 =?us-ascii?Q?4I7ljYcTICtKHMMW9kMPkvLpfXgn0TVhoTSRY+8GjMaE5q1vyuEK1XjXbJ7F?=
 =?us-ascii?Q?1byjoRYAchuIqXcARmHAoE/gfVe+ToYUtDqSfd80B39ivGJcLZ7s2BXocmRZ?=
 =?us-ascii?Q?qM1gk3B5e1sPpYgHtHcefew8w2zPCb6XHOYBm7JUt4r68inFt4AgjjWsSKES?=
 =?us-ascii?Q?JCfKv9+84Lm3fYDIfa+qDcdvcyBseYuDR4ofcfjdpZWOO33e4r6XGyojmq/P?=
 =?us-ascii?Q?ASssdRHYURyEBDtLZc4YSYdq/U7y5mzKP2e7Me0WDiC4uYyPssNeVo006nSW?=
 =?us-ascii?Q?RIfZ5aZ6Y68Yu//HWDpfAETnC3cOczCIMAe9EoUa0kBmuMFqpWWBucR7PiYI?=
 =?us-ascii?Q?2IOI83CtapgiblAYJM+OoTAs5dxSvvN+weq6gvHagYl+jXC+OiLoAFud8D3h?=
 =?us-ascii?Q?IRiTcFfwtYDb1sCc513KfsVUcHMPDgpQKVcpW3zkUMr8/dSrvRXQsHTdh1N+?=
 =?us-ascii?Q?bDyQYZfOdI6IY8i2t9mAMxct+Ky1OpKlaJ9p95e5APqmQz2ShcyLKxkQIF/7?=
 =?us-ascii?Q?B2YSevdft4t4LIMYLrApqI92aWL/afdPb4wQuYYSpH/rFneHHFuvRPffWZ35?=
 =?us-ascii?Q?geZY3hRs7IFo0iqArMQrE+1hCflv5cAxedDkPbmN2RwXgW8/rvc2MZ69u2zK?=
 =?us-ascii?Q?N4Xk2FVc347acXRgQ31p0Pg7gyhmXukW1nSbpjEUZfqw/lIua5+fkwo8tmtP?=
 =?us-ascii?Q?S0DLNBeUjriuqOjE4TCtw59NAKRWM8jCnkWyGpLy/sPuLnIZnYSSQ0fNvz3m?=
 =?us-ascii?Q?DcZxBeyvSmHfepDcG3z5DK+v9p3k5hTN+zMldMXQETJzduLQ9DgYWrUnhrmA?=
 =?us-ascii?Q?RZaI6soUb4TXbsIHnjqo9se2NCBE3sdvP9iGciUK7/FBhKjVH6RhImJJUqH+?=
 =?us-ascii?Q?iK34a78WG27wJYQl92O0bZHFFRZ0jXBC7N4R3I50kjJ3FhcwlCVOAJBmHy+y?=
 =?us-ascii?Q?4dcrYNtfMGWTepgtgxuvvJMuLM+crT3cYaDxF/Od3TCBdVF8kr3yQrfi031w?=
 =?us-ascii?Q?ciyCVJ4ce78OlPFiJm5LE3PpZWOf9YLQaeJFVLRrl+XgT6sY6CpXvUrJuT6f?=
 =?us-ascii?Q?qraTXBWM5VTFQBge61AhixffLXYNl/t/h/hYcC+O5oH1TOGsezgtHk/wiYZN?=
 =?us-ascii?Q?F4tq+9xH+gpz3gFtnPY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D9F55EA2C1E8DCCAE572F755ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148532b9-1f6a-4299-d306-08db6c11b4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 13:25:50.8750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtAxIc0pCorHN4KHHrwQL+tMekoU5i8en/zQCZ4u0SWYHBgwbePO35m+3/lUlg5waV2l1JkePyh+X1Zrl5XzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144D9F55EA2C1E8DCCAE572F755ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 13, 2023 6:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface

Set compute partition mode interface in NBIO is no longer used. Remove
the only implementation from NBIO v7.9

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index 095aecfb201e..8ab8ae01f87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {
         int (*get_compute_partition_mode)(struct amdgpu_device *adev);
         u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
                                          u32 *supp_modes);
-       void (*set_compute_partition_mode)(struct amdgpu_device *adev,
-                                          enum amdgpu_gfx_partition mode);
 };

 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index b033935d6749..cd1a02d30420 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)
         return px;
 }

-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *ade=
v,
-                                       enum amdgpu_gfx_partition mode)
-{
-       u32 tmp;
-
-       /* SPX=3D0, DPX=3D1, TPX=3D2, QPX=3D3, CPX=3D4 */
-       tmp =3D RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATU=
S);
-       tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-                           PARTITION_MODE, mode);
-
-       WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
-}
-
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
                                                u32 *supp_modes)
 {
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
         .ih_control =3D nbio_v7_9_ih_control,
         .remap_hdp_registers =3D nbio_v7_9_remap_hdp_registers,
         .get_compute_partition_mode =3D nbio_v7_9_get_compute_partition_mo=
de,
-       .set_compute_partition_mode =3D nbio_v7_9_set_compute_partition_mod=
e,
         .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode=
,
         .init_registers =3D nbio_v7_9_init_registers,
 };
--
2.25.1


--_000_BL1PR12MB5144D9F55EA2C1E8DCCAE572F755ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 13, 2023 6:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set compute partition mode interface in NBIO is no=
 longer used. Remove<br>
the only implementation from NBIO v7.9<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c&nbsp;&nbsp; | 14 -------------=
-<br>
&nbsp;2 files changed, 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h<br>
index 095aecfb201e..8ab8ae01f87c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h<br>
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_compute_partitio=
n_mode)(struct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_memory_partition=
_mode)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u32 *supp_modes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_compute_partition_mode)(st=
ruct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; enum amdgpu_gfx_partition mode);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_nbio {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c<br>
index b033935d6749..cd1a02d30420 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return px;<br>
&nbsp;}<br>
&nbsp;<br>
-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *ade=
v,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum amdgpu_gfx_partition mode)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SPX=3D0, DPX=3D1, TPX=3D2, QPX=3D3=
, CPX=3D4 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(NBIO, 0, regBIF_=
BX_PF0_PARTITION_COMPUTE_STATUS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0=
_PARTITION_COMPUTE_STATUS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PARTITION_MODE, mode);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_P=
ARTITION_COMPUTE_STATUS, tmp);<br>
-}<br>
-<br>
&nbsp;static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *supp_modes)<=
br>
&nbsp;{<br>
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ih_control =3D nbio_v7_9_=
ih_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remap_hdp_registers =3D n=
bio_v7_9_remap_hdp_registers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_compute_partition_mod=
e =3D nbio_v7_9_get_compute_partition_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_compute_partition_mode =3D nbio_=
v7_9_set_compute_partition_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_memory_partition_mode=
 =3D nbio_v7_9_get_memory_partition_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_registers =3D nbio_v=
7_9_init_registers,<br>
&nbsp;};<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D9F55EA2C1E8DCCAE572F755ABL1PR12MB5144namp_--
