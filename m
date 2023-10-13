Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80690CDB482
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 19:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E91310E059;
	Fri, 13 Oct 2023 19:41:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C813D10E059
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 19:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPbIpfB7D7U+wJNaqBfiPqmv3DYCTW57+Hq6MjAYQ7DXeimMqHg+E4H8T68Z+VqLWVt7ey+gXhfWgVEsdclPv+RSdwFjenxKMA//WEw4B7DQMOghCsUT6Khkp0MsPzzRZZjAgkctr2GCriEHEZp5RohXnGM14nakp8FrrMEw82r6QFQFrXSFRtaTTkDRvog3KAcFxGcUSozKNcxvPXeldb0SjJvJS7uEiyAtOvM6yjyYgSOGRV1CvRc8QDE9DDK8LTbLH94vgXtTJuv/EcHKHK9UXDSDhvxxTSgLNUy4t7P04bKwRRLfMgJApvu3kf0/HYQCnk4+J9ZZ2ljX5OEq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDlCip3BBsfaDe47kC/a9ywjDOEGjJHvlIeJyw5Wda8=;
 b=T46p6NaN/pnpKZYvxZUE/1w4c+rjpQRbmu+LulWqxyeUkXu5qOn5Ui/IutMwcziAH6FdsmDLH0fVYkcsDYqyIKh+ka7Axbyz42yOYZAlAAz+RQkhxlhktWnFvJofytFLfghZ7p63oSBkhMGHc4Q4/JSu2NKLoMZCeRgL4AnSGiTUKM1fjn6ijpmDlKtAexqsgal7YmkmjbyUNLbFwI0lvElMlpKQPwjkmPXEajke8sLVkl7hJClo7M+Q77QTdeJ5pezcXXUSognO9np6CjfpNOcza8O3rZHW4NiF6zv4eqdE89sVuz3VlOw3D5r+V+ogpMiyx1R3+5CXuOU1qKyMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDlCip3BBsfaDe47kC/a9ywjDOEGjJHvlIeJyw5Wda8=;
 b=3T9APy/S1CuBBSh8WNeLgnzlEg6ERd1JcjtREv9o5A6YSx2pga3ype25JNrB6Hx9Zi0ebF8KIs5WybpvPK47yDNzz+ln0EsnlVFS98FiYZ2Fud4bYX6Wp87RnMose6z7gSnu2p/dTM+nZl0iG5bJh+mHR4as5g0FwxgSnh1qD1Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 19:41:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 19:41:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amd: Read IMU FW version from scratch register
 during hw_init
Thread-Topic: [PATCH 3/3] drm/amd: Read IMU FW version from scratch register
 during hw_init
Thread-Index: AQHZ/gs221TgjVn2s0eMX0WP8AaQFLBIHmf+
Date: Fri, 13 Oct 2023 19:41:40 +0000
Message-ID: <BL1PR12MB514422796638C36C8CE9313BF7D2A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231013192604.200515-1-mario.limonciello@amd.com>
 <20231013192604.200515-4-mario.limonciello@amd.com>
In-Reply-To: <20231013192604.200515-4-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-13T19:41:40.047Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB7344:EE_
x-ms-office365-filtering-correlation-id: 0f13d80f-9e79-4f31-39f0-08dbcc246c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVzRGUNT++Gilibip0nHBTNXg8YbbYvrJ2WCgycznY0XnUsZFlPEtO2cDTE4r0FwgkKkOydr/6VUBRH0XhiKEr3lGFO2R5Vo5W8vocvOanw8C0wCVAaQHfk/CeILE4fWeFSx4tye0rXka2r7ODGwc2ouN0wnwMUaWF2aLcTAnaUN0yn9sXbQoZA2sZRxeZn6VgXwDAZ7H0PA2cDWqSHyfyrcjml8d+V030wp3iTcGcCF5lp3SrXXshPnh3hhKQRQlHXFt4HBAeds7vYRCEG9MLeY0rpr8v00lf8wGEh9URV3kDLZGHFNMjCz1lYjplPvm9PXR0EYhC1YXNk2qzrx3ZYKqi04hvOPjOX86ZKWLqNVh2yRHkp6vnJpJF7bDPREdbbOGZ8DgqZ9qCRmAAr2YEHmbCgXkgb/5WRJc/pkMTLAVn9dDtI5vvMvAawsUhxnrmHdJZgwavgi0vgu+7cMVTsFXbzfBac32XrgOqbU8HRn07CAEV+IQFEflSD/cymJplWBSlX7NEY/y7M94I0srbQiv62uOmYqwDAMPS1ZBP+U4mBqwhOaXbeqB8cpoxp2+nVwDEEl5qr+crMSUGR/KGm+Djo0QY7AhBWds9Uy/550AxZPCh5+7p+obPSRT8U4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(55016003)(66556008)(66476007)(26005)(64756008)(53546011)(66946007)(110136005)(316002)(76116006)(66446008)(5660300002)(41300700001)(2906002)(8676002)(52536014)(7696005)(478600001)(71200400001)(6506007)(8936002)(9686003)(38100700002)(33656002)(38070700005)(86362001)(122000001)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?McAAwk2T7pNv9mABxRUml9OqCRKCzViISwdzdrLId70dX60tR0w9r1tPRq0U?=
 =?us-ascii?Q?E0Dy+BzvjwBjCoIFgeqEVgDUxGFfEcvHk6s20qSPxrhQaJ5gxVXgME6JqmHx?=
 =?us-ascii?Q?Vo1WHQyjpN+CBixpr69uxMr2g6uQidy3MkuZoZIYHgXryc9qgXcZKBpqFSGp?=
 =?us-ascii?Q?LbmQckTCoFovhRSdAK6bvozJONT7omacuNpgnSR/B2UmEKnYJKy6Cgq9e/Uk?=
 =?us-ascii?Q?CNhGDtRhVocf4ejBIBpUP8yFEz7pWPcVqV3UM1OZAKJJHTkBQmEAus+yyR+P?=
 =?us-ascii?Q?Aec9pkyJ53RVdBlOoUCpjymDMiI4LSEj1VaGS+FSVif7sdng67SbRCwBOUFA?=
 =?us-ascii?Q?2hXAXUV1dKl6h3WYdxMYyMoefAZWLDgxbxESV0SUtfV5hUPaHTkZtmU14xfX?=
 =?us-ascii?Q?/Gk7nrvsfcC9l8U+WUNhBgXSE+MHq7goDGsqog6Zcs2TuGW4IeO0N60iPkSo?=
 =?us-ascii?Q?Wk0ch2peVEs3s2jVC5/FwTSXMlW2cXJln5PZm/ZNxgAh5hwnfS+uv3SSmum0?=
 =?us-ascii?Q?ctLTRGaqH8jsR2Y5NNKyzUDHOt75wfD7gL/eKWs0L6BAIMMVkEi2VhnOG2IF?=
 =?us-ascii?Q?TK+bk2ube3n4lVXo94COK1kzOeHHZtKrhI4dhu4zZkOrnTS3mFdCbzrfazaD?=
 =?us-ascii?Q?0R+rie56Nq/+5Gjy6e8KB6Ou9+v8FMt9/4RlKbI8knxv5VcLILMpzvXpKVKC?=
 =?us-ascii?Q?pg9GBYEkAwUF0wGKm3KHjk59p/FN0Ok3MZXd6O8mPu0mCKkUjQxGEOi87DP8?=
 =?us-ascii?Q?xdhIe0zWQCswSRlA47xAWcN01bDt/Ot86IcurcmuE3lLpIdDA++JingDBDkj?=
 =?us-ascii?Q?CkZpmu3v3Z47DWdCPyGuu9XRX7p6AykwUYyFUzXUBlVtBxxDv8TRD7iKgaKn?=
 =?us-ascii?Q?98QuQ2HxEiSHrSdAUsZdCrQMLi6o/FWL6MfUMgyn4p1fZcnxg7VnWmnwwKQ6?=
 =?us-ascii?Q?cOA9y4z3kCrv9SKhcygEFCeFgQ5O3YJJcNT2BR6OLFYKbpq7i2tbdY2yXiyI?=
 =?us-ascii?Q?isjmFoFvepzqzVqmQgZYbYJE5HAQ8dNeiScafLDubHkMyQrig2sdQAdF5Tkt?=
 =?us-ascii?Q?SERwIBjlU63Gl+i/gdC4CVM8yM6qyKpfAfqIn3qCyeZYtBS8P1j1Mbj1v/mR?=
 =?us-ascii?Q?p/gUSfzUWxU/y7M0d+tCfIurxUkxvgP5xmsJMA73SKemRlwkhSy7AcLiAtt6?=
 =?us-ascii?Q?UTd4pD0KchilGHUOB3xbCOjA72nQSGy1zcREWApWUFMEafeP28aorYde4MzR?=
 =?us-ascii?Q?uQ+/dUTsVFt4mg9jEUjAILz+6vxkHAZBjUreR4qajvJ80Tm2nRvbJRUPLp5G?=
 =?us-ascii?Q?LryuWSsumhfSP+jm5vQ+Kzh8q326xrOHh5NKa9BVGzFy78HS7bYLKdXoA0/v?=
 =?us-ascii?Q?XwpFs0iFEIUTXEzNJGgs9XfkYlhpJNzVvZbwDU83eakq+t1mSo7BgrTJFhUI?=
 =?us-ascii?Q?MvHks0lHbolgVIw63nNgORZ2n5CKVrrhftALi9D13t3E3Xwz/V9fqnj7fdxN?=
 =?us-ascii?Q?X9LJISWcl464cN12iXg/3/gghDDskTTB7k6yF16JmGuecN3KB0+ZHuKdiW41?=
 =?us-ascii?Q?gSrlVxdqvEUF2QkCxLc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514422796638C36C8CE9313BF7D2ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f13d80f-9e79-4f31-39f0-08dbcc246c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 19:41:40.7262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 069EzH5F++t2cj5BjZ7/wZw2+gvtoCAa31A/qdhsq3J+WBQ/XchBMgL2HUz6YK+NyRuLksT+XgQyGhis4PoMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

--_000_BL1PR12MB514422796638C36C8CE9313BF7D2ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Friday, October 13, 2023 3:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH 3/3] drm/amd: Read IMU FW version from scratch register dur=
ing hw_init

If the IMU version wasn't discovered from the header, such as when
the firmware was directly loaded by PSP then there is no firmware
version to show to userspace from sysfs or IOCTL.

The IMU F/W stores the version in the first scratch register though,
so fetch it in these cases to let the driver export.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index f0957d060750..154b20492123 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4373,6 +4373,10 @@ static int gfx_v11_0_hw_init(void *handle)
         if (r)
                 return r;

+       /* get IMU version from HW if it's not set */
+       if (!adev->gfx.imu_fw_version)
+               adev->gfx.imu_fw_version =3D RREG32_SOC15(GC, 0, regGFX_IMU=
_SCRATCH_0);
+
         return r;
 }

--
2.34.1


--_000_BL1PR12MB514422796638C36C8CE9313BF7D2ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Friday, October 13, 2023 3:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amd: Read IMU FW version from scratch regis=
ter during hw_init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If the IMU version wasn't discovered from the head=
er, such as when<br>
the firmware was directly loaded by PSP then there is no firmware<br>
version to show to userspace from sysfs or IOCTL.<br>
<br>
The IMU F/W stores the version in the first scratch register though,<br>
so fetch it in these cases to let the driver export.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++<br>
&nbsp;1 file changed, 4 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index f0957d060750..154b20492123 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -4373,6 +4373,10 @@ static int gfx_v11_0_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get IMU version from HW if it's no=
t set */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.imu_fw_version)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.imu_fw_version =3D RREG32_SOC15(GC, 0, regGFX_IMU_S=
CRATCH_0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514422796638C36C8CE9313BF7D2ABL1PR12MB5144namp_--
