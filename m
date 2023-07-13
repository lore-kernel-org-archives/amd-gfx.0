Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C86C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 20:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A3810E1A5;
	Thu, 13 Jul 2023 20:51:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DA510E1A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 20:51:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lswd/WZmCxouoPKeMsOvnwlE8KUa6fYc+ciY9r9gO+UvzWXh9oRoX4FBya4xKVt4AakjOhUP2+FUUo3KBtsP/ZZAhQbZhcImoXOc/6Y95KoZDyQMo+Yc0KX64kiTh29HzJX0nBgQQY1hv+Mndc5S2iju9ggOTdZCS1tbgdJcB1qjPfiFhdaOmINKmQ1Yu3cI8ic6F0q9XNVrxzQN34zfm0qRF0A45gAXvzqPpVj2A0YY46SevXmvFPWZVL7SBhEclrEn/S+p3SnP2pJ8ws9xTrv6BM3s3VLHhxagF6NM+GgmdtGBBBGdt9exmb6VKdFGySBpKwnJfKpRTEQGFw0VrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDRDOFcQJ6Gx279vELqkufMOvDgMRrw2hkf7wjBvdTM=;
 b=MRwHnkfiIClWUVU7aLFgrRMIQoVhZ4tWMEhwCREvYQ/uJsqDa8Rxildb7H5v63Nk5EBZFxGaF885BEN/F7ZZgY/mCZO+RY+lLalIZQF9M4qptJDETUO0E0pcn26Yp3QJFjfOdhrvqJg8+gLVERtD3QF/fNUAKQs/0zM7x4nWvXLX1KMeLU+wazjhXdx+RJD5wUBS3P2wjbTduCizVlS8O69DZ3RVfEi1OrCno9D67dF+OarRJq4tE8jyVcwdY6XVFz1XCaRYWG565g4538vps8EX49CJpDSeOcryUqyeRHmRPOv1e4sHbnRGUGZzJ7QqNiIOgy7kuxcMz94MbONTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDRDOFcQJ6Gx279vELqkufMOvDgMRrw2hkf7wjBvdTM=;
 b=lDOvmvBtwzRzGiFY5p5LIXwoFPqnRAH+scEat9L/Oy6nUC+fhsP7HuTdnZxbb41LBc8QV5nz1q1H4hgHYXhbqJqPDlSbUzFns2EaxOHbehv+q46Ru8Kqfxf/anpL/Yvxt0ZFh69WKYdLC9AD0O0nIQCT9ZGxB4pDuxtRlAt89kg=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 20:51:16 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%5]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 20:51:15 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amd/display: Use root connector's colorspace
 property for MST
Thread-Topic: [PATCH v2] drm/amd/display: Use root connector's colorspace
 property for MST
Thread-Index: AQHZtcR4BNVZGSjCvU6tjIL6RjncVa+4K92w
Date: Thu, 13 Jul 2023 20:51:15 +0000
Message-ID: <CH0PR12MB52844C472EFB8963CDAE7A308B37A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20230713195850.165198-1-harry.wentland@amd.com>
In-Reply-To: <20230713195850.165198-1-harry.wentland@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-13T20:51:14.755Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY5PR12MB6130:EE_
x-ms-office365-filtering-correlation-id: f6ee0f14-c2c0-497d-4545-08db83e2e689
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1H6L/NE8HjciGUf8MQhQ9rKvaxgZgzrR5R6gSZLfAjWfI7vmf0Tn5Ddz8CicEMk0g0Wrfkc14R1JDzrp1p2Dt4J5fY/QYepImHUJRGZYXAGywweZyEvLZ2TCK2fsRfsiyFhGO9e/8gfuybPYtKb9la1UI4BtiSn2/bhfd9ACpbZX7k5yJwJbjIs5zub5D8/oaPLXxLdMOeM2/R0nO2RBxAxHiAnupGyzQ6o4xGWeisvI9Sx3uhJ88uJC1aYj9oEMT2rHy0OlpU5zIEYhtY1WmTL1uQm2fSvMJtsckVAto/X4seCJH8RzC0TDEkPjm50+OO88svNjd5mrCIkS5+e+w7dYudTCETaGwbdw/Cs7a2xetFTrSzanIKX5FNkQ5843XY2cXevfM6Kbz9WtDOuIvv9Ou+59mvYgbmG+7WWeHuoAPyO3+On0I8vQpyI/0Ynucje+dijiLhvCzbOCdpH0EjACX1J701fbGdEXroPI5PABaoeVBpkmDDIsa/G28p/+wOpw3OCgjuqtNrJn4TXd1bEVGZopbkVtzYfu+1DT9U0fDlI5Csp+4MshDvGcA3km9ZclDbdsPIAPGUsuiTB8oPnkLMqbFLia+78Tk/AdJSryOCLMqSHUsQ4wsRcUkAt0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(55016003)(71200400001)(41300700001)(53546011)(26005)(186003)(6506007)(83380400001)(66476007)(91956017)(76116006)(316002)(66556008)(64756008)(66446008)(66946007)(8676002)(8936002)(5660300002)(7696005)(52536014)(110136005)(2906002)(478600001)(9686003)(38100700002)(122000001)(33656002)(86362001)(38070700005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LnnJIzjwC4CHvQE8On2W4ETJma5OXpxCp7aaddpPhXqBNYb8C1yuSt3yuBk5?=
 =?us-ascii?Q?adOF9z6/VOkrGks+RuF7TztCQdqCcYgbKwecEl7amn0E5T3b7A6adBXRGZe1?=
 =?us-ascii?Q?4SB6xXuqkX1KDSJDuTCRixDjhtI54rG4Kb+L9q+MdCKU2bazr3ExIaA2kskw?=
 =?us-ascii?Q?sDeP7st2cqeWZHtr1kg9+lK+qRNjAwZbK3cB58Duh0sFXllfe0xTpUwKckdh?=
 =?us-ascii?Q?vKMKsK4xBMg9MkFuH8rtHsddU0SA+V4rAAuCjfPkQlMjkyjkJr0hziFaTFMz?=
 =?us-ascii?Q?wzTGiT/d8gUEQz/t+nsI/y8KmUl2IIhWjTb1wlVOI+P1caIpTLIp4V5LnFFv?=
 =?us-ascii?Q?MQIEKb8GNgQSiRGiojxwHimzZThNOdMVdo7+Gr1dJtXTJEPspUp60L9YFLgE?=
 =?us-ascii?Q?SgYHbIajQFRuhkNCU3WYMLpeHwkIuRXr1PGyKAPrdiBvwbLhPMQ/45ctGizN?=
 =?us-ascii?Q?0gSSxtaXT0poQVaqNVqs0zzChY2zgB/57ntvmk7rbogpCS6BrUwntkQSR5Mz?=
 =?us-ascii?Q?F59y6Y1P+359InMnn0VAVsFlggCBGkiOuAf9ElXKqegxbFXRpxZnKObxGJhe?=
 =?us-ascii?Q?uk+69RtRtHrznzFw9JN9FxfHrE0u03xr2kcc/rf2e6MbWCz1No8vEcxKJh3P?=
 =?us-ascii?Q?CIOBJP27tMhM/+loDezSHq8mq7t118rZG1xIq5/h7mdtySWzx1ox2L5ZfyEK?=
 =?us-ascii?Q?qKmWJk+OPImDW1DPNkC7pqD6j/8GCT72bo7Zb0VZWnW4D4BFCCTiru7BkyJl?=
 =?us-ascii?Q?Wx7bkG1cbSSLcw+WnWlDnW/6KIo0BZ/R3CNKDXMmFH6VhAVzmk/1xxoVtOic?=
 =?us-ascii?Q?G/dzzVbAuGFSiQS+XA1jpjXNYBlxVi2MxGr3tdT6XWzo+CQAST47Y3ncWfyY?=
 =?us-ascii?Q?+WHIjzK/dfUDe1GlOW9MaYXQFT7Lz/qhk6qL9EQ9am1Ttp3jA3CJ0Nv6inoQ?=
 =?us-ascii?Q?oKCgrEAB8xt2huB2aJNZHDmPEx/NUzFtRjFMZ3J6T0XlaKSJh8Ofo1JvP+gx?=
 =?us-ascii?Q?4l0xGjRrKdznp246PsWDzgMk0scoR54a1UZAZHC5cL78XmTWWM/XIKDc/pfF?=
 =?us-ascii?Q?uSwrlfiI4rMj1uqbnITDbz28vxWCd8dGrkC9OX4waN+IUQZrz4Bicufcgc03?=
 =?us-ascii?Q?O0wdZpH0UY6QxK2xShkaeAtcLy4UvLdwpchBNjAHz9gMxGhiQO/74HxaMsyf?=
 =?us-ascii?Q?zY5MdnolZ/HEW1oQKmKEgHaiqYRL8fo4QLDmV1K7rBtuhJ43BDv2r5UUw0bi?=
 =?us-ascii?Q?886NL1YPBTLmgRuaU7MUzJ2VGEDPt8hZLk8NcpxjqzQdOuxjlF2qIH4buAcH?=
 =?us-ascii?Q?3WBm6dldrqINJQZKkKTd13IbrWKjG+C6PTqaZ3Pb4NRIuhJPRY3NONpCkh28?=
 =?us-ascii?Q?1/q0OiewU8kOecWq912UMj8kRBGaNxlDDRTlkiz9IkgUYbw5ao+l2sgZ58ld?=
 =?us-ascii?Q?UotTRPS9JbWBxcemS4cZ/ZmS5JCAqiEE9j3jMO5HUdOKRXK+G2aSUpq0bPmc?=
 =?us-ascii?Q?hnNzwPymP+6o6udE1VL2pRO3SUG08Ou0fx29xMmpXMRL0JZI9rzLjGj2FeJL?=
 =?us-ascii?Q?leraJ/liZh+war4dCc8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB52844C472EFB8963CDAE7A308B37ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ee0f14-c2c0-497d-4545-08db83e2e689
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 20:51:15.6055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWsX17rwc5ps2EcB5Ce5l6vdzzq6eUtZ2S3jAm8JMugIEqGCaOVhglBj/O+GjwlpF8raTyOL0+ny5+oAN3i+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB52844C472EFB8963CDAE7A308B37ACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Harry We=
ntland <harry.wentland@amd.com>
Sent: Thursday, July 13, 2023 3:58 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Use root connector's colorspace proper=
ty for MST

After driver init we shouldn't create new properties. Doing so
will lead to a warning storm from __drm_mode_object_add.

We don't really need to create the property for MST connectors.
Re-using the mst_root connector's property is fine.

v2: Add curly braces to avoid possibly 'else' confusion

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 28f8ac6007fb..f6dab6226b29 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7357,8 +7357,14 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_d=
isplay_manager *dm,
                         drm_connector_attach_colorspace_property(&aconnect=
or->base);
         } else if (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
                    connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
-               if (!drm_mode_create_dp_colorspace_property(&aconnector->ba=
se, supported_colorspaces))
-                       drm_connector_attach_colorspace_property(&aconnecto=
r->base);
+               if (!aconnector->mst_root) {
+                       if (!drm_mode_create_dp_colorspace_property(&aconne=
ctor->base, supported_colorspaces))
+                               drm_connector_attach_colorspace_property(&a=
connector->base);
+               } else { /* use root connector's property */
+                       if (aconnector->mst_root->base.colorspace_property)
+                               drm_connector_attach_colorspace_property(&a=
connector->mst_root->base);
+               }
+
         }

         if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
--
2.41.0


--_000_CH0PR12MB52844C472EFB8963CDAE7A308B37ACH0PR12MB5284namp_
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
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Harry Wentland &lt;harry.went=
land@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 13, 2023 3:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Use root connector's colorspace=
 property for MST</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">After driver init we shouldn't create new properti=
es. Doing so<br>
will lead to a warning storm from __drm_mode_object_add.<br>
<br>
We don't really need to create the property for MST connectors.<br>
Re-using the mst_root connector's property is fine.<br>
<br>
v2: Add curly braces to avoid possibly 'else' confusion<br>
<br>
Signed-off-by: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--<br>
&nbsp;1 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 28f8ac6007fb..f6dab6226b29 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -7357,8 +7357,14 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_d=
isplay_manager *dm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_c=
onnector_attach_colorspace_property(&amp;aconnector-&gt;base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (connector_type =
=3D=3D DRM_MODE_CONNECTOR_DisplayPort ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector_type =3D=3D DRM_MODE_CONN=
ECTOR_eDP) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!drm_mode_create_dp_colorspace_property(&amp;aconnector-&gt;=
base, supported_colorspaces))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_at=
tach_colorspace_property(&amp;aconnector-&gt;base);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!aconnector-&gt;mst_root) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drm_mode_cr=
eate_dp_colorspace_property(&amp;aconnector-&gt;base, supported_colorspaces=
))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_attach_colorspace_property(&a=
mp;aconnector-&gt;base);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else { /* use root connector's property */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector-&=
gt;mst_root-&gt;base.colorspace_property)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_connector_attach_colorspace_property(&a=
mp;aconnector-&gt;mst_root-&gt;base);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (connector_type =3D=3D =
DRM_MODE_CONNECTOR_HDMIA ||<br>
-- <br>
2.41.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB52844C472EFB8963CDAE7A308B37ACH0PR12MB5284namp_--
