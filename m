Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2674C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BFF221E2
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BFF221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E5956E270;
	Tue, 12 Jan 2021 16:06:59 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3D06E270
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 16:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3m/8n+58wJKgWJgq+654NeAv6t8B+DrmJl4M5I9Vn6FBecTf5mLMjD3nC4nviUPQf4LIl2nz2io4iS+odPBpzAVSAX/tCk8wlsr6Krch0p6wu0GJ1coynJUIvwHwbWXlvf9h02RdRrTmfpQi5wlsh0HKrJCSz7Z0XKl8U32dlkE2kcvL3gEqsfwGaDH8KXhR5xW493BZtLEBW74tjbmiekEVVmj7grYnTVYWhweFbOCikZ3isC+o2OZRn5ULQ75z4R2qXp1HTdRhAFWbeM51pRkZvfFRRW1Td1awgJN8bTlWPhMIq0DwnVvajH9zfu7i9eaAeyfL1Fs1bVPSPeuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLNFYfPQ/q3SRwvlIIPR9oIN2rC3MPbV7j7aU9E9Cwg=;
 b=ZGdAw9urTet8DiGCNsCMJH3e1+XRIQ1Gbw60wjBcLS2HjjxfqXFBgVYHZOrYuq+xDkwPE3mAFamfydpNEClw5Zwr82goNmpGCJOJPJ0WG5lF1R60Narb2OLSAxSfjiZumCz8KZl0re2BOnaq6bbtY1or5P3xrfGYrSMMHxHr696S/7/KIDjLHyS5LJ3XtKYaJOE6PON0SgvqQ84VfZWm3uaatHsEbpHnXq0ud8RBiw/+8k5iZ37fLpe0pVQJlsn/mHqTcQa5ZP84hqL6vHWz2jAB+YJUX390IiJcHVembjnddospcU1lVURbNkZ8SOwodzDyQDmFM9UTETu5Gy2SsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLNFYfPQ/q3SRwvlIIPR9oIN2rC3MPbV7j7aU9E9Cwg=;
 b=AilxbvbWOiBYlm4fmcOklwY3touoA6ZB2eeaWDP2MF+2BmzGpsFbfkoE4p9bbsrfd3zA5EiLEBejgIWjfZYKqW7+0psgeiMprXvgANP+7xXb46jqcqdEkap6t6cvq67OapApAbZQIeJPWC/mXuYBWCu8eimwC55Z7boP7OSIluY=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 12 Jan
 2021 16:06:57 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 16:06:57 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Topic: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2
Thread-Index: AQHW6F0dxqWT8H9lTkW2+SxUxNeUtqojTa0AgADaQFOAAADYJg==
Date: Tue, 12 Jan 2021 16:06:56 +0000
Message-ID: <MW3PR12MB455434CFD3336676DB64B077F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20210111210236.2376738-1-Bhawanpreet.Lakha@amd.com>,
 <CY4PR12MB1287CCD6B57FD4F7AF025520F1AA0@CY4PR12MB1287.namprd12.prod.outlook.com>,
 <MW3PR12MB4554808C9AA46660B75DF722F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4554808C9AA46660B75DF722F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-12T16:06:55.916Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b15fbe8-6576-47c4-9af0-08d8b714161f
x-ms-traffictypediagnostic: MWHPR12MB1759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1759D1D2D67B8316903D124FF9AA0@MWHPR12MB1759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYnCQdC74Hp1S7U1vZwQXcIFkE/+L+EnC9J3abJQrb7TyZoh9KPF6LEngyWj7CEdw7WYfAMkTWaRNM+quC+/CeLd+JW0KcFzY3kUvKdHE5+cD2oaa19yKN6sbc4eDiGyashGslIajRp+e3qgqhG0MGJ8BaSaXVPa5dZwMKPWwXECKF3wpUCDbIohYz4/iEYRg8rIiBl7j5BisI9BCP2zFXgZsEy7F9AQgDNLfqNz9axlv6wuQxHVNrwatKOyREHmhvFUjquZpxTm0g9y/2JGlcrLPCjjdW+N5oleU1f/S9QCNoqZy3NlueGGAkwZTq0Hf1in7s52ywkiYatRitD+dKWSYxYoBRsjqTqiN3ufHBdzvrUnb6nZQeoE4Aik1ff6569YruJZmpO2QSQTXSzkeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(52536014)(26005)(186003)(5660300002)(9686003)(55016002)(83380400001)(2906002)(8676002)(53546011)(4326008)(71200400001)(8936002)(6506007)(110136005)(66476007)(76116006)(7696005)(66446008)(64756008)(66946007)(66556008)(86362001)(478600001)(19627405001)(6636002)(2940100002)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lLCqA54uShw2XQXLiq7/KgbOkcAaN22s8t3e5xfLpb/j9B9aDxnrDtI2hYnM?=
 =?us-ascii?Q?eE9DVdlluW3c30O4TupE3YpffnT+NFVCJczmVNci9BPrUGDVPCuZRtAyLiQn?=
 =?us-ascii?Q?f5v8Ew65i8ra1OZ8tss0Kk/TFnQyI976PCf+YLdCuib1p8LQ2P1TOgvOSiFT?=
 =?us-ascii?Q?h8tGXXpLdgxg7+YERVGb6GvqrpbbcUC6JMbSzpd3Yf9GHSDUvmsCJ+XDtHaA?=
 =?us-ascii?Q?dDEApbsr2O8Ljx8oFOdbqPiTN3+s9dAreWik7G8YLoFLYV07XmgxGydpju9d?=
 =?us-ascii?Q?lDlNW81R/bNlWlK0BykUl0lKbAuY9eObs8t7hzjngUtAK0bQoaaVmv4LCeJH?=
 =?us-ascii?Q?cLrYZJO6IkqCJrZY7mpebL6nSgdd9EvYgT6FI3v/09f4wvN8ARkSAEmkCds9?=
 =?us-ascii?Q?JzoRSQmO5IkM5/JmIbsRzifkO9pYHmChlAOCSaPcj04YTch3M9/XJEkWQbk+?=
 =?us-ascii?Q?/Jeay3BmxV1Z33qfCsyzmuIulfLgbmUfqWhJmo6zDe7xyy+PQluu9bagXWiV?=
 =?us-ascii?Q?eNln6SRtKTXCTt2QHVOXWre4fXxhQjZFaRE3s1JW96JwaGkpxyzNEIuiO2fa?=
 =?us-ascii?Q?uhpnrDIoGaYKgVErXfalLy8he1SRqHHwaTLq95zHo0cop6zXw4C7IWc1ddXd?=
 =?us-ascii?Q?fCGWzRYsCdrbNN9ryWpMWbM6YKEoB7A+ibrd6dCBN0KFgVLejOwoWNbFA4JF?=
 =?us-ascii?Q?WVqA1OjaDXCYNBPhTN0gufiIJa8ZjO6rK1JVRJNS/S6kE4Ywj5AU+8f3ttSz?=
 =?us-ascii?Q?CegBj6jhqv19DB8d3UumpKegwKikwqUwgNZqj9s3yL5pAQMjnlrhSqCBidev?=
 =?us-ascii?Q?bIwTMpKqVVNXWMWI8RXB8OL2+iASazNYETDwzo7hQVwyP6CnJj0fAOLELZFv?=
 =?us-ascii?Q?CsQiobek85KVxzPAAZDP9wiGb92XetKBtd/dQnEBaNwC9LH0Ghe/zB51Vtol?=
 =?us-ascii?Q?yfeSbDsZ4WIxT7Mr3wJkV8vdrzKeFkJUOILT8OdRamk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b15fbe8-6576-47c4-9af0-08d8b714161f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 16:06:56.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyDVWnjV5QYvRH51CeE/HlGwh6vQAqFjjxTj1nMJSUMiFWzp8szcy/bBl9mL/YJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1463536204=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1463536204==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455434CFD3336676DB64B077F9AA0MW3PR12MB4554namp_"

--_000_MW3PR12MB455434CFD3336676DB64B077F9AA0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

sorry, I misread your email, I will post a v3


Bhawan
________________________________
From: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Sent: January 12, 2021 11:03 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazl=
auskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

No need since "dc_allow_idle_optimizations" will not do anything for asics =
below dcn3

Bhawan
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: January 11, 2021 10:01 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Kazlauskas, Nicholas <N=
icholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Lakha, B=
hawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

[AMD Public Use]

When using dc_allow_idle_optimizations, should it be guarded by CONFIG_DRM_=
AMD_DC_DCN?

Regards,
Guchun

-----Original Message-----
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: Tuesday, January 12, 2021 5:03 AM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Chen, Guchun <Guchu=
n.Chen@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet <Bhawanpreet.Lakha@am=
d.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2

[Why]
during idle optimizations we acquire the dc_lock, this lock is also acquire=
d during gpu_reset so we end up hanging the system due to a deadlock

[How]
If we are in gpu reset:
 - disable idle optimizations and skip calls to the dc function

v2: skip idle optimizations calls

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux =
(MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99c7f9eb44aa..858c6ff173ba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)

         if (amdgpu_in_reset(adev)) {
                 mutex_lock(&dm->dc_lock);
+
+               dc_allow_idle_optimizations(adev->dm.dc, false);
+
                 dm->cached_dc_state =3D dc_copy_state(dm->dc->current_stat=
e);

                 dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, f=
alse); @@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct drm_crt=
c *crtc, bool enable)
         if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
                 return -EBUSY;

+       if (amdgpu_in_reset(adev))
+               return 0;
+
         mutex_lock(&dm->dc_lock);

         if (enable)
--
2.25.1

--_000_MW3PR12MB455434CFD3336676DB64B077F9AA0MW3PR12MB4554namp_
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
sorry, I misread your email, I will post a v3</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lakha, Bhawanpreet &l=
t;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> January 12, 2021 11:03 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Kazlauskas, Nicholas &=
lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset =
v2</font>
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
No need since &quot;<font size=3D"2"><span style=3D"font-size:11pt">dc_allo=
w_idle_optimizations</span></font>&quot; will not do anything for asics bel=
ow dcn3</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Bhawan<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Chen, Guchun &lt;Gu=
chun.Chen@amd.com&gt;<br>
<b>Sent:</b> January 11, 2021 10:01 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Kazlauskas=
, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Deucher, Alexander &lt;Alex=
ander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: Fix deadlock during gpu reset =
v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">[AMD Public Use]<br>
<br>
When using dc_allow_idle_optimizations, should it be guarded by CONFIG_DRM_=
AMD_DC_DCN?<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt; <br>
Sent: Tuesday, January 12, 2021 5:03 AM<br>
To: Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Chen, Guchun =
&lt;Guchun.Chen@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.c=
om&gt;<br>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha=
@amd.com&gt;<br>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset v2<br>
<br>
[Why]<br>
during idle optimizations we acquire the dc_lock, this lock is also acquire=
d during gpu_reset so we end up hanging the system due to a deadlock<br>
<br>
[How]<br>
If we are in gpu reset:<br>
&nbsp;- disable idle optimizations and skip calls to the dc function<br>
<br>
v2: skip idle optimizations calls<br>
<br>
Fixes: 06d5652541c3 (&quot;drm/amd/display: enable idle optimizations for l=
inux (MALL stutter)&quot;)<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++<br>
&nbsp;1 file changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 99c7f9eb44aa..858c6ff173ba 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1816,6 +1816,9 @@ static int dm_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_lock);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dc_allow_idle_optimizations(adev-&gt;dm.dc, false);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm-&gt;cached_dc_state =3D dc_copy_state(dm-&gt;dc-&g=
t;current_state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dm_gpureset_toggle_interrupts(adev, dm-&gt;cached_dc_=
state, false); @@ -5556,6 +5559,9 @@ static inline int dm_set_vblank(struct=
 drm_crtc *crtc, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dc_interrupt_set(adev=
-&gt;dm.dc, irq_source, enable))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EBUSY;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dm-&gt;dc_=
lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MW3PR12MB455434CFD3336676DB64B077F9AA0MW3PR12MB4554namp_--

--===============1463536204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1463536204==--
