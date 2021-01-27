Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C2FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A270320709
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A270320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED9A6E511;
	Wed, 27 Jan 2021 04:34:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86C06E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo2f196ui6MnJI9C+lIeHbzap12rQrWyEkoXMVYuwJW+XuNdPwUwIUVRSTS0TVIj9Yzi7RXsRiquD+QVK1/BEpZDgclKPHpWLejx29/HTwiilw17/V1w8fqFyzY6bL0vjjaOesme2A61LPZ/SipasfG5jApvleAp5sA7g0pDO7PrRiJu/yoF0U8U8txMr8LXbuDGysPvR2xTqSia0W+DQEJnjgygt4en9E8sXzRYeewfya+bJ79lQqOBJYjvEOPaIMUdXvAGP2X9fzh5mcckmAvvCkJLWoL0E9sYFRlAlDebmLHFaXVsGGESFXAqhbSeP33jvVIuS7AFkmRA6A0mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T5ByPr1W2CUcvleLNiziPCdJqaxDyDzqgKDDfwgBpI=;
 b=M5Ndjhud0Iol7qL4XGZ3kRKIQymv0Z9hOxrXBomquAXtAPi5S8hZYkqcphFeZhXW2wrdMpIQRmA6SoNJR2yCTggsHlL4hWkL8D3HbaUr1Pcp8w7zS2uDkVIvfWQk4ecGmNFF3bRxas9PSeEeJh9MWS9b8YK3vYOfUktK7QmJcK0OQqWljLbBCEvfe5g2aoqI4sj85bTz7MRfLFnUA9UfmD296IsY/WWd/sHGRAJdGNdrLkRRIc5nntQH+/3u/k6ZOK8kPNBJjxic6X6tMYbXlL9YKSYolW8aANYK2mVksySEgkuiz4UzMZRaHGI/KX94WIOsSlCYcPkWiFDC7Hz44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T5ByPr1W2CUcvleLNiziPCdJqaxDyDzqgKDDfwgBpI=;
 b=CbmHdovqjc9ceUlmAhzLuSCOWgt20l5fKmG24oO1eDmJsPUwktp4Pwg1LbirqZncGG52e9wwPQwnc2LKtoHQN7xto6FuL+Y26XJsadUWwooidURxTQ3flrS4QBQqQWh7hoEfMwdqSZaoI43VT5of05UOLtvH3lfHJtC1X9ghLr4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 27 Jan
 2021 04:34:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%6]) with mapi id 15.20.3763.019; Wed, 27 Jan 2021
 04:34:51 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A98ZxpgT84YPE+wX+X9OURxBqo61ZoAgAANYYCAAAAU9g==
Date: Wed, 27 Jan 2021 04:34:51 +0000
Message-ID: <MN2PR12MB44887DFA0177C949C1F99166F7BB0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>,
 <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287945849A59414A6B38144F1BB9@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:34:51.151Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9bb16c3-f1e4-4499-cedd-08d8c27ce349
x-ms-traffictypediagnostic: MN2PR12MB4270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4270250982C8F7F1210E7F44F7BB9@MN2PR12MB4270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQcps1JO9g0dxhOtjJ/0pXFKJnkdsEjQDw5KdPwFIHbE3WZmvXf+TzHCWY1VqiHyEzdUqdV4EBDkx1KDNdwCvL6FeqnYL1RyaBRVjUjjXchAtvbP2B2r5gFhJuF4lwChvnD8++1G4/TB+at/V1TtC32V5/oSLceoVw31Mn2/K1/oJ7A51CuCeb0mwGAMLQNoaCOuv+dNnB4M6cuRH/PFtPNTVWyod6VWESMcaLj3eeZ3bC8In2zxdnnSOEYqcDSiAUaWFCMC0AxZM5YoB7pqLAUw6IlzWyyP6GWKaPOFex+VSI+YwObqVZ0rzmliWQ0427VqJ2yDyl2RQ4dKlzPca2UU6l93b5Q8xR7FTqaHdYSd6XSf5ynFYK7LifVmlf4H/DG//k2Omf5wIwYjnM1K4KLowPDTjKZrNF0AsqIwifQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(76116006)(53546011)(66476007)(66556008)(19627405001)(64756008)(66446008)(66946007)(45080400002)(6506007)(26005)(478600001)(2906002)(186003)(8676002)(8936002)(83380400001)(7696005)(52536014)(166002)(966005)(55016002)(86362001)(110136005)(9686003)(316002)(71200400001)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0z/Sm/crc2LgeBkqw/0KK7wEgN6uQqywmWbp1HRHtay75DhdbQl1z8q+Xjuz?=
 =?us-ascii?Q?elcqdQert75BpnEr17ujicmwgwMQNG0Rno4R0qhh3TkXxGFwwmbgXVHqXbTs?=
 =?us-ascii?Q?b5GRNbxO+pfKNGRpSsQLHAer2okAZSvHdx5FGJ9nNEf2g6KFpYtT31AowQ3c?=
 =?us-ascii?Q?v348/lXNf/yHSVRileuJqkZKIrwG3HRd4TxGyjSAxUIV0Up+Mu5rLCIqG8xg?=
 =?us-ascii?Q?zI0gBh/b08fk4qXgjD5G0oDCSRbH3AXQcmHRDEMf2KQ68O5wsHxf7NP8+48i?=
 =?us-ascii?Q?39Bv8M/lysNGB2AWse9K8XAJfWR6wcb1QSDr27Va+SMxG20BCzOqXzB2Nqz/?=
 =?us-ascii?Q?jizsZkCDa6cpGxXDY/645Jl4+vUAeDGmfqogy5f+XwcElSprS8mMA76CCzde?=
 =?us-ascii?Q?O8mmfrl9JBE5VT/E5KQLtrbfzqv4ZuwJeCUZVq4gxzDzuE6/w13GMZB3LRFs?=
 =?us-ascii?Q?6Hzs0/EU7m79W5I4vtQsiM+/TEt4DCH3NFwS+DhGvvGNOafLYSgVkAg3y0Jf?=
 =?us-ascii?Q?HoTKAv4k5XDkKyw8xAw7i6hH4OT3BnQimpLw4b7Ke54z35Iuwa/+T4y9JkfT?=
 =?us-ascii?Q?rDeA+iOT+DJwswMp2mzPHWg7y7uwGgZ9Bm/M/FkyFuY6ESTwgfyTKInZmh6X?=
 =?us-ascii?Q?iNSDzrGOuQvbL9wTiQis3HKapFnIZrIdUTDAWFZZNl5hit+gDL1kg3gXX0Uz?=
 =?us-ascii?Q?Czk6m6/Pv5kjQX0r+g4lWWY9uN0yjsARUvW2dSRFzWdPdarp4RURq9N8sPpp?=
 =?us-ascii?Q?5noZzzke3JFiClGujaFx1kB+RrnFT/PsQ5tQSYwV0NuvnKsFopWpq2v6k0gd?=
 =?us-ascii?Q?UKhhnTnTrt0HdO/xcjUCei1G2cppF6LsSzJqk1oi9nImzmX0D0J/AWwEbbnn?=
 =?us-ascii?Q?p8Oqo5Du1d+ipmMsrbR3dFiUBKDAF8XhZIdtXtvwDC0LSUPpLJKguNIZAs2F?=
 =?us-ascii?Q?tikfKAnjR03ugOJA0xM8MADsuYEFOjjzdZ7F4eRRCeXu00UQ8Vykbn07um4V?=
 =?us-ascii?Q?8GCoCZUNqisqN/ZAr47DURv1ChaqS/3rKgb432UtxjipG9k3Bs1mZqaUD/DK?=
 =?us-ascii?Q?eFS1Ob9J?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bb16c3-f1e4-4499-cedd-08d8c27ce349
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:34:51.6091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOcTVNyd4x4aPTKUrP4FcP2SEIYRTuX4+4yiHD6CjRb51/HjF4lGYKNJ1fj991qL+9gUK1hxBD305zsAqVadJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Content-Type: multipart/mixed; boundary="===============1594319598=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1594319598==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44887DFA0177C949C1F99166F7BB0MN2PR12MB4488namp_"

--_000_MN2PR12MB44887DFA0177C949C1F99166F7BB0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Is the xclk really 25 Mhz or is there some divider for the fan stuff?  Chan=
ging the xclk value will affect other places where this is used.

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Tuesday, January 26, 2021 11:33 PM
To: Quan, Evan <Evan.Quan@amd.com>; Alex Deucher <alexdeucher@gmail.com>; a=
md-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Public Use]

In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.

If (adev->asic_type =3D=3D CHIP_RAVEN)
        return reference_clock / 4;

I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Ev=
an
Sent: Wednesday, January 27, 2021 11:46 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <=
evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;

 tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_=
period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3De%=
2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dlp=
9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;reserved=3D0

--_000_MN2PR12MB44887DFA0177C949C1F99166F7BB0MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Is the xclk really 25 Mhz or is there some divider for the fan stuff?&nbsp;=
 Changing the xclk value will affect other places where this is used.</div>
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
<b>Sent:</b> Tuesday, January 26, 2021 11:33 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;; Alex Deucher &lt;alexdeuch=
er@gmail.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskt=
op.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readb=
ack</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
In soc15_get_xclk, we have independent handling for CHIP_RAVEN case.<br>
<br>
If (adev-&gt;asic_type =3D=3D CHIP_RAVEN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reference_clock / 4;<br>
<br>
I am not sure if it's better to squash the patch into the asic specific fun=
ction? Then we have one unified place to handle it.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Qu=
an, Evan<br>
Sent: Wednesday, January 27, 2021 11:46 AM<br>
To: Alex Deucher &lt;alexdeucher@gmail.com&gt;; amd-gfx@lists.freedesktop.o=
rg<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
Actually after switching to retrieve fan speed from metrics table always, t=
his API is not used any more.<br>
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan &=
lt;evan.quan@amd.com&gt;<br>
<br>
BR<br>
Evan<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Al=
ex Deucher<br>
Sent: Wednesday, January 27, 2021 2:17 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback<br>
<br>
The xclk needs to be divided by 4.<br>
<br>
Fixes: acab02c1af43d3 (&quot;drm/amdgpu/pm/smu11: Fix fan set speed bug&quo=
t;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 147efe12973c..36dac106ed4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *=
smu,&nbsp; if (!tach_period)&nbsp; return -EINVAL;<br>
<br>
-crystal_clock_freq =3D amdgpu_asic_get_xclk(adev);<br>
+/*<br>
+ * crystal_clock_freq div by 4 is required since the fan control<br>
+ * module refers to 25MHz<br>
+ */<br>
+crystal_clock_freq =3D amdgpu_asic_get_xclk(adev) / 4;<br>
<br>
&nbsp;tmp64 =3D (uint64_t)crystal_clock_freq * 60 * 10000;&nbsp; do_div(tmp=
64, (tach_period * 8));<br>
--<br>
2.29.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3De%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&amp;amp=
;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473159431451098%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3De%2BzrZgRQDkOb4ElNJNiLWP%2FHBM0cIQl4GwKFuYfvsP8%3D&a=
mp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dlp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7Cguchun.chen%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637473159431461091%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3Dlp9Gu3pJ7GdDbF1BJNlIQr4Z0TCY%2BTVDGtDWzZ2bR2Q%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44887DFA0177C949C1F99166F7BB0MN2PR12MB4488namp_--

--===============1594319598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1594319598==--
