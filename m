Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE3C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323CD64F20
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323CD64F20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E58D8981B;
	Wed, 17 Mar 2021 16:22:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680045.outbound.protection.outlook.com [40.107.68.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6004E6E59B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 16:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms43Cr6aOy9od/jVyWD2qjAPQoOXsKBIwRxCiqL6ZLDuwpp4Kyyc3pOwGmf+4OodccKxvxBaI4FZJtq/JoA+ZDHGQAGS5sc97Koi7gbdpqwxK2X9Gb2arLm/oZeUKXOJOTWkb+MjYwH5jWIs9NBOYqxsexqN+G098Lg5E+e2nu/C+4+hGowDMMiAYN700q2oMtzGvvm71y9RvdJ+Ywms0V7pNlp8x9nlcfs7du5OJB70/SxFMoZwd0HCDPBQnRobgIIR+4iuwpiexdW3y/wmbbhCp3gWMCIl2sY3IOPOx9SYtjZNg1AaGu5Oc0ESvdhgItHKGYYMvSjcyv9cBAjLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ6pvkst6TrA7QLQNNwZX/K9w6+rC7UU1YfKVXMBHno=;
 b=b2W79EZi7NawC07mYnqlIY4to0J5Vkv68GGl9dZMebp4UPdh/ejXKWF5IxCT8y4B9RGUSEUjbht/rMggS5fhU885PVsuNjCu6l6lunOR6k69EPhnBCe4KSgu8xvIiSfoa4lT5LreoNrjHJDf/k/SwzL99o6U/l9D9SHMV8IUc/ph+etEzj7SnUSN9gXSDEqWUEekI2UgUmJExJi+aEdFMhxV6/8/1c6/InpqNdZSctxja0UdDjyt1ARk9X6AURFlgmS8B4Bk6gJvA5LMbkh2RnakQ7/G0igkuwTjnyTawj4/dhOBPfF8egIuRVdFElNQslf3KUGQHprhqyW+uEMZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ6pvkst6TrA7QLQNNwZX/K9w6+rC7UU1YfKVXMBHno=;
 b=XwN+wZdur+w/gGA9DHe0uWSggiQzmzkEjdrtcQKRn9d9UUI/CgYqybSWzaDoziSSJosZD2EkjjBdKkqkKPIvYzR2+OfZH7reaHXDRfWfq1g6By8XIY2AJD+RQ6oWK774mBcFUFKIZR3glV63AZ6yETjot7KTN/GjBqQjp9gJ4+c=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 16:22:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 16:22:16 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add irq register entry for dmub
Thread-Topic: [PATCH] drm/amd/display: Add irq register entry for dmub
Thread-Index: AQHXG0mPz42j7rDAB0q8kh4mc/8hRaqIXL76
Date: Wed, 17 Mar 2021 16:22:16 +0000
Message-ID: <MN2PR12MB448875BF7AE8910917EBE798F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210317162105.845084-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210317162105.845084-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-17T16:22:15.713Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef3af14d-7305-420b-fd7a-08d8e960d46d
x-ms-traffictypediagnostic: MN2PR12MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB458470FBBE2191889BB7E6C9F76A9@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7mW8h+VJxJ3Ph7SBtR1ZTeJ0Y6N6me4fBbJLN8hiMp2fZMpmRwLO8a0mBpOXQOPYtCawj9jeBh0j52J3AeuSHhQuGQBkuwnWCiXHmKCm0qLML9WYUqv4rA0o+Ji7rj55NgG7IDBQ9azHseiBW2QK8mWZzLtbI9qg1nN1TAYpkmiUc8ndkCXwGuL1Cg08Uan7KFLpOkw9EzYDZGb3tyn0S4DDGeBDsTVedx4+jsEuirBcQJDHxc27xxMW862svDWL/GbGriLNZ2D5PRkFt7ziQGKz2A0XVcERE1Y3ZS+xrWO0tnTf4OidMgkKLofIixdij12TfDSt15YN/SWCLp81ojYxDrgFGTkTZy5pHQNmT5ah9pbyGMqEPOXAY8Tud5+Ijl17Bn1NKEXlJE0ZMxMXe9Q+NwF0xE0CAY2EOT1Yyq3J3rnbzVcCcDHbR66MspDlL6ZrTJMwVmUoaLwQAgxh8Latxvu/xIV+OzTjFp4CgE1SjrpTOID0SvjVQtb6ujmqNjKwP8UoR4n9Fc1pH1l5OSc8ejGVWbGkyzJZ4mEBJjrdBIXa9eOg8Kyo7H432269
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(83380400001)(186003)(54906003)(8936002)(110136005)(33656002)(2906002)(19627405001)(6636002)(64756008)(52536014)(53546011)(66556008)(6506007)(478600001)(7696005)(66476007)(66946007)(66446008)(71200400001)(4326008)(86362001)(316002)(8676002)(9686003)(76116006)(55016002)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jCShaH+TFidEHcYHhKTHNudiQkpKJARs39g1qSSrp8n+Pj+r1GadGkJv5VES?=
 =?us-ascii?Q?8D5zhOSAE4ei9vxHuF7NTt3UkEJdfOEq3NAoyq1Zp5eGP6pX7jJcYtIF482u?=
 =?us-ascii?Q?kpZDgOzA/xeK+0DOgB5WPO3m7Ky1PVEdmZN5iBKi+kn9SQcyUaO1NqG4xT64?=
 =?us-ascii?Q?LV5u31GYe43R/e+KnQJ6dCthMrqGfLpacagI8/t2IEhF5setks36rw4rg4XM?=
 =?us-ascii?Q?6XCLd28Xh0uP9GA8daWc6xvtARdOpYVJx+2xmPbsIrOSqkVQh+8b1WhIYRqc?=
 =?us-ascii?Q?f1INT5X3aQm/P4a64VXVs2ZSLXkBge1ZsDyo4oeSM50sa4ewF7dr2WJLxaqn?=
 =?us-ascii?Q?eoNo8lsQlIHigeAD9j/WQwXNrk0YhFNnR0YKLqWVOrMiIUN/D7xdnCTeO+zD?=
 =?us-ascii?Q?uxGeCJmnlSA5H6g8gREda2ca586ZRCbF+MKKjpDtp4JhlPWgbXtk5C0fsVO+?=
 =?us-ascii?Q?Dt7V3OxqqJdl4u52Mrs/MtpmwUPfVxogMmkyfjQe8OxJnOGD2pUwQyqVfWBv?=
 =?us-ascii?Q?3ZQ9dGMR5WCIDh5X1BCBbYjivQufT6iSzUiLiyxDcY38duUCij5mmVjhYzu1?=
 =?us-ascii?Q?mx+3T0COS34snolOiczuMenXKvTTDqiu83y0rwCuK4JsfmTFyGf3mvPv2Guh?=
 =?us-ascii?Q?5RtCZP/ejhugZ13hiYsCHR5r3OrGziTIIxw8hk7dHOhZ7UPhnIE6zPxSWOag?=
 =?us-ascii?Q?PlbuousF22KzxlYD6qFal0SYcrJtZjksEgvzmxxZGheSEr0DHF3/+hOoSCcY?=
 =?us-ascii?Q?qMhJyZUHZspJd17OQcCRAt90419iD4jQwy8DE8Z9GQnrs+q5+wh/lpcyLimJ?=
 =?us-ascii?Q?Yx54r2P+eK1q3LYl9qW1fLFO8v+nHtwnvJs8u1PyVQ0d3tyWG2U+4NKTTUGi?=
 =?us-ascii?Q?c1flB/kreaTji02eRjTT5AM9+sMbpWQ85uRdYoHdn6hvoI3E1ZnGyVYa3d/9?=
 =?us-ascii?Q?DJO0i7h01UMXcm6p5Ogsw93gMd2Wv3EFR2cVcQJbOcvu/1/pscnRG8L971Ai?=
 =?us-ascii?Q?7a1qaSnMQbPrfoxdfzDT+j1UngttjXp0myrFPc2m5Vc4rZrg6A/qEV+PT4ev?=
 =?us-ascii?Q?hiJPtlXrS438vT1fcWuzEksgUQkNzkkPlSugt5zBhaG4J6OmuMY58OvN+ZcN?=
 =?us-ascii?Q?AtVR8HQPNHYTFh1LvY6gkJXtuAMZgSCSiZUpsAld8ZAKlBylFCNo2Qx503dV?=
 =?us-ascii?Q?3AS/YkY3lRjJJZ8xhrGStIcS01jXk8ImbT+tFrxnvbce46uoK+lTGP9cfwZX?=
 =?us-ascii?Q?SrXfHgCMnoeVqMMJ9qsvtKPt65x/VFl0nfC3cmGxoLxqeTEOy4H/WyN0A+Eo?=
 =?us-ascii?Q?0+4u/bAT3rrkH5ZzsmeRMlQi?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3af14d-7305-420b-fd7a-08d8e960d46d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 16:22:16.1651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2wE7NBbQLftg6cvEbzz7kWhtD/u+/bSPcKJrseWYUG5NHc6IZJ5ATprBukev4OFVvr88C9PWXMnqkR5Xsk/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Cc: "Chiu, Solomon" <Solomon.Chiu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>
Content-Type: multipart/mixed; boundary="===============1917209959=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1917209959==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448875BF7AE8910917EBE798F76A9MN2PR12MB4488namp_"

--_000_MN2PR12MB448875BF7AE8910917EBE798F76A9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, March 17, 2021 12:21 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lin, Way=
ne <Wayne.Lin@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>
Subject: [PATCH] drm/amd/display: Add irq register entry for dmub

DCN2.1 and DCN3.0 are missing some macros that register irq entries
which cause compilation errors. This commit introduces those macros and
fix the compilation error.

Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Solomon Chiu <solomon.chiu@amd.com>
Fixes: 53e9c0f651421136 ("drm/amd/display: Support vertical interrupt 0 for=
 all dcn ASIC")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/irq/dcn21/irq_service_dcn21.c   | 17 +++++++++++++++++
 .../display/dc/irq/dcn30/irq_service_dcn30.c   | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 48a3c360174e..bc1249a9858c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -209,6 +209,23 @@ static const struct irq_source_info_funcs vline0_irq_i=
nfo_funcs =3D {
         BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
                         mm ## block ## id ## _ ## reg_name

+#define SRI_DMUB(reg_name)\
+       BASE(mm ## reg_name ## _BASE_IDX) + \
+                       mm ## reg_name
+
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+       .enable_reg =3D SRI_DMUB(reg1),\
+       .enable_mask =3D \
+               reg1 ## __ ## mask1 ## _MASK,\
+       .enable_value =3D {\
+               reg1 ## __ ## mask1 ## _MASK,\
+               ~reg1 ## __ ## mask1 ## _MASK \
+       },\
+       .ack_reg =3D SRI_DMUB(reg2),\
+       .ack_mask =3D \
+               reg2 ## __ ## mask2 ## _MASK,\
+       .ack_value =3D \
+               reg2 ## __ ## mask2 ## _MASK \

 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
         .enable_reg =3D SRI(reg1, block, reg_num),\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 68f8f554c925..5af52ad49d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -276,6 +276,24 @@ static const struct irq_source_info_funcs vline0_irq_i=
nfo_funcs =3D {
                 .funcs =3D &vblank_irq_info_funcs\
         }

+#define SRI_DMUB(reg_name)\
+       BASE(mm ## reg_name ## _BASE_IDX) + \
+                       mm ## reg_name
+
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+       .enable_reg =3D SRI_DMUB(reg1),\
+       .enable_mask =3D \
+               reg1 ## __ ## mask1 ## _MASK,\
+       .enable_value =3D {\
+               reg1 ## __ ## mask1 ## _MASK,\
+               ~reg1 ## __ ## mask1 ## _MASK \
+       },\
+       .ack_reg =3D SRI_DMUB(reg2),\
+       .ack_mask =3D \
+               reg2 ## __ ## mask2 ## _MASK,\
+       .ack_value =3D \
+               reg2 ## __ ## mask2 ## _MASK \
+
 #define dmub_trace_int_entry()\
         [DC_IRQ_SOURCE_DMCUB_OUTBOX0] =3D {\
                 IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_R=
EADY_INT_EN,\
--
2.25.1


--_000_MN2PR12MB448875BF7AE8910917EBE798F76A9MN2PR12MB4488namp_
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
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 17, 2021 12:21 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@a=
md.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Add irq register entry for dmub</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">DCN2.1 and DCN3.0 are missing some macros that reg=
ister irq entries<br>
which cause compilation errors. This commit introduces those macros and<br>
fix the compilation error.<br>
<br>
Cc: Wayne Lin &lt;Wayne.Lin@amd.com&gt;<br>
Cc: Solomon Chiu &lt;solomon.chiu@amd.com&gt;<br>
Fixes: 53e9c0f651421136 (&quot;drm/amd/display: Support vertical interrupt =
0 for all dcn ASIC&quot;)<br>
Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
---<br>
&nbsp;.../display/dc/irq/dcn21/irq_service_dcn21.c&nbsp;&nbsp; | 17 +++++++=
++++++++++<br>
&nbsp;.../display/dc/irq/dcn30/irq_service_dcn30.c&nbsp;&nbsp; | 18 +++++++=
+++++++++++<br>
&nbsp;2 files changed, 35 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c<br>
index 48a3c360174e..bc1249a9858c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c<br>
@@ -209,6 +209,23 @@ static const struct irq_source_info_funcs vline0_irq_i=
nfo_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BASE(mm ## block ## id ## =
_ ## reg_name ## _BASE_IDX) + \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm ##=
 block ## id ## _ ## reg_name<br>
&nbsp;<br>
+#define SRI_DMUB(reg_name)\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BASE(mm ## reg_name ## _BASE_IDX) + \=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm ## reg_name<b=
r>
+<br>
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_reg =3D SRI_DMUB(reg1),\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mask =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg1 ## __ ## mask1 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_value =3D {\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg1 ## __ ## mask1 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~reg1 ## __ ## mask1 ## _MASK \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_reg =3D SRI_DMUB(reg2),\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_mask =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg2 ## __ ## mask2 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_value =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg2 ## __ ## mask2 ## _MASK \<br>
&nbsp;<br>
&nbsp;#define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_reg =3D SRI(reg1, =
block, reg_num),\<br>
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b=
/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c<br>
index 68f8f554c925..5af52ad49d7c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c<br>
@@ -276,6 +276,24 @@ static const struct irq_source_info_funcs vline0_irq_i=
nfo_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .funcs =3D &amp;vblank_irq_info_funcs\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+#define SRI_DMUB(reg_name)\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BASE(mm ## reg_name ## _BASE_IDX) + \=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm ## reg_name<b=
r>
+<br>
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_reg =3D SRI_DMUB(reg1),\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_mask =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg1 ## __ ## mask1 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_value =3D {\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg1 ## __ ## mask1 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~reg1 ## __ ## mask1 ## _MASK \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_reg =3D SRI_DMUB(reg2),\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_mask =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg2 ## __ ## mask2 ## _MASK,\<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ack_value =3D \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg2 ## __ ## mask2 ## _MASK \<br>
+<br>
&nbsp;#define dmub_trace_int_entry()\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DC_IRQ_SOURCE_DMCUB_OUTBO=
X0] =3D {\<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTB=
OX0_READY_INT_EN,\<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448875BF7AE8910917EBE798F76A9MN2PR12MB4488namp_--

--===============1917209959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1917209959==--
