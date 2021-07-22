Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ECAC6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51A56101E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51A56101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596496E88F;
	Thu, 22 Jul 2021 17:12:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C756E88F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 17:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPqIqmeghrwsYmP4Tw7kW6GUYyVO8cDziZ2Nfe4Kz1h3pSWCRtxgSB3Ta25Z1kUszPi2m77wgi3Tq6q/ff7VYIYFtRJQuTblXNXe3PM/1oglIuBa+L5LGJaWQmBIgt4MowerQCi8BTrqeYZT/YdRj49NrYZWga4mlA9xyiYFLelryxTvwQcV2IjGmjlqtCIdO81A5kWp7EUYU8KEc/w7w4WdpQaOIyYqZ+mKq8GCUKNc3CtPxitgOGGBH8KbbTFRPOqW5atE+evb5FnnDImWizYpvIc7vttRxw8RAuAokYlyS6E5uID4hpX07dFckg7o/ltbHPqdHTagnHOp/OcDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1e+Sdpgf4i02wlyjrwqmbbPEHCG/bOV63Ys3u6NDF4=;
 b=et7fuMAtAcvq6Mxix0D5UzcKsRdlc/DX1F/d9yTo8t52X7dZUtiPxLT4NmGjX7NF24a67MKoSzh/U3GmFzS1k+dGEX9BVM5ffOsgmxnLey9WAWZ1+vBg2z3oJBzOYxwv80sGCsFipzYLxeFfIwish0Kc/WGq0Ea9IZ02S/pAvGSjndDn6D9X5F9uguP2/23dKPxmhqy70IYKThkkk1zz/3qOjXu2aFPP+xN9OTEEp4kT9KBDC2AsdWL78PzD40MZj61LJgJtpdfoXfBNQAGktqSqu4R/A1B609Wced2frtkK2jQYEkJWxmvgSGX/rF//f0cKmYPyZLWAxFhMdsZJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1e+Sdpgf4i02wlyjrwqmbbPEHCG/bOV63Ys3u6NDF4=;
 b=lv6/TaBiH87ihTbSKbGrrPkHYbQRfqCBt17Y0vgyWiqA5/SQITxEcpfLIeIERJ7dlQERUwRVPRpZXbgEWNd5f9OYXptwtg9wZlVs7qDsye/826lxtqw1WV4JyCznRPt/b+KXnDcgx76oOlBQtJdBAORFL9aH8+1ZJysQ1JbmS4Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 17:12:57 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.028; Thu, 22 Jul 2021
 17:12:57 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Check pmops for desired suspend state
Thread-Topic: [PATCH] drm/amdgpu: Check pmops for desired suspend state
Thread-Index: AQHXfrpJeO9zEZjH5UyWP+5O7eU6k6tPO/H0
Date: Thu, 22 Jul 2021 17:12:56 +0000
Message-ID: <BL1PR12MB51447688D66FC358D6096CD7F7E49@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20210722052714.626304-1-Pratik.Vishwakarma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-22T17:12:56.412Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 450f9460-9f81-48f0-04c1-08d94d33f363
x-ms-traffictypediagnostic: BL1PR12MB5285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB528570869719E23FF5E092D3F7E49@BL1PR12MB5285.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+JWQq7kDKmUpFu4e2gl7SLFqJ4m+F7t9ShXBkSf3haCpDzrcUoruFotsbWKTgJCAJ6KbcfQON3cKbpONHUG4R1KeGyYZo9QUH2ms8QtjXopdjLWseJ2jzgq00nsihEnb+JxAf91bxyP9xsDSseX3HZ72IAdHvzWuOuV8+tvscvibkRDk121pXWA+z1D7CODU3e9uv4ngZbTHSK+uMNzgBQVPfopbuOqWsnYw0L7Q//JnGBnbBM6LJxF4gyEL0TF9WBz9Dg1ZvDkaSrPX1ascaovnwnY+pYR8Yfxu25yI9VglL0hHkbZl701qBCfsjBLHHfiC9RAezIHBalvVINfNbkEINOqkxIcpTvyYcCu3adgWa/QE5V8tWhUZCitayTV1dPZR3MrguiHZ68TML16D69X9DFR2XXndyzOtFD8GLThHtfA6dzhKPbhjz/ionLtnURUTuBI4vhGBQ4kKEx2gZOE4hEl5JgUGN9oKkkFDdJ32eeYixe/KhurQ6cZUHgOh3S9wFq11TwJSdfaFMNR6+S3a7XfdjuBR0LYE4HkkcykzkEWsqjJpDAc5ZTrEg2w0oPClYYIUQZ8VFcrFNrClMVShlS958f6BDkkzgB7C3Zf3WB0yURrguBzzgJd4m/1D7RL1INrsxf0S1GXQabIKxBRluAjwe4pz19xy1ZUKElwMyHrAiI+cSB5GVBHNxrcZysn9/aRPoU5lrLlfniusTBE1i90D+p4BFT508+CUGjim0ZkqHWf7HBXtXixcQ7DVijmw2aabWe8Di6x6r7GjfrbNeRGRugVQhqOBHoxXGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(53546011)(76116006)(52536014)(186003)(71200400001)(478600001)(9686003)(316002)(21615005)(66946007)(66446008)(66556008)(64756008)(66476007)(122000001)(83380400001)(86362001)(6506007)(5660300002)(55016002)(7696005)(8936002)(19627405001)(15650500001)(38100700002)(966005)(166002)(33656002)(8676002)(26005)(110136005)(2906002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1FtCCHlQkqe4M4pscTqL5DjofSVPLt0XV3CxBJ/3MWYtOn7jzugii2SB6Yy?=
 =?us-ascii?Q?DB7J2aFH7h5LO5KnYA3av8ictyfQBhBTJSk4mTlkLQ/zXa0wtF6WV6M7cSIc?=
 =?us-ascii?Q?cNOuVWR6GxENc1kh0WVa7lSvZajBKmTZakQmVJwQhatn8T5dz2q4TOb1XKcW?=
 =?us-ascii?Q?HsWDtKKjym8X6Mz1wV77Y6M06ci4+sDY6qPUTVqx8YW8nwNrhW3bdUq+0+3k?=
 =?us-ascii?Q?+PMaayGRIlE6+266XqzPq9wuEvZ1oOSOQEUFlwD9oBDgz2OpA9fN1XTO4SD+?=
 =?us-ascii?Q?T9XvehscAbSQTaIfFb+z7GXXOHsV9H6QYN+0hlJ/SpXjWXpH88w7V+b1M81O?=
 =?us-ascii?Q?AA9A6bUWzrFAdAcT2tyxYx1HjojYs2uanXunG/w+62bXlqjgAo1K8dFkluUN?=
 =?us-ascii?Q?2BdqQ027o8sgHSrQjifLs0QxJAgRJhF552LoFix4cSzAeku/tBHJTkcVieos?=
 =?us-ascii?Q?3XSQe2CqQWMLa5B01dabnPNXzKtTt14XExhMhMWl0sc2K9ykyGVYMwe7ECgU?=
 =?us-ascii?Q?Hmv+cTaohemHDFq2ENOdA33rAvFbV3lq0yzgNaZxIG6h/I4y23v38l2hmolk?=
 =?us-ascii?Q?J9u8peeqJfvtb2wbeJFg/OMRqzwJnPvIIrrdiYDoiH7bw8HpBLdxHz1O4+Vk?=
 =?us-ascii?Q?7zIhxG+F9QKTemt0rIyuLbbgkOXgqSrdKCj2ulior/ycHzgpuZ+wr5k7w+IK?=
 =?us-ascii?Q?JNOgE2eQajrgFUra2emTCza6ink2m6NG0N2Ycy2I4VG+eJtrPncXXm/5Yb4g?=
 =?us-ascii?Q?g1Qlx0XFnZBBnUJvjNCznEQ7batutyY44OxwAqrSAEl9lEu/fiOCVMdgf42V?=
 =?us-ascii?Q?eTc+6dUNVoo1o+iZLwc6Lwi0pemqF0RoIjLUgJ5pG5ut4viqxymD3y5JS3DQ?=
 =?us-ascii?Q?tLnbuLbAJqSLd6QrGjNV0djjuF+kO1FG45QxxXq2S2DzsC08WB9QIaSU6KeM?=
 =?us-ascii?Q?gcsycDDePZW/F940Yi7gX7ZPMasisTsbG1GuLMqcWLuNvYiNrbbsNCMb0Iqs?=
 =?us-ascii?Q?7Ayhxd1yu77wJBBSxpNpuZTUNe0HcnENl3cSx5cS/7G8ni09vJiMpPUJxeW4?=
 =?us-ascii?Q?MTiZEXEDAHgrpqQ6rXUUXw2IAKyrn1tbKVm+8DVL6wAlMcQtGzHVX9bVGHtP?=
 =?us-ascii?Q?7t1E73WP0PHezWbvvLkYyGx24aGKqGPIdJejbwp2vQILAouJvXMpAdjlChpn?=
 =?us-ascii?Q?FGAaXQWvmIoy8RgqQi0LPr3Ky9vFWosZmJahG5liiVvtw53t2hSnsRaMeBJ5?=
 =?us-ascii?Q?qlQQ6+WsA7v+CEBqKjyw+6fHyEH2RZHet0CFH8KrIBbcGbPQ1d1PlcE2Fqoz?=
 =?us-ascii?Q?ZCUD37vTDmJJiwP0OJQKRy2/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450f9460-9f81-48f0-04c1-08d94d33f363
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 17:12:56.9986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWfabveBKoKtmW/BuN/sUQgik0FWiDijP1MH2OIEyQhXbnM5L/Z5lnKTeEA8aUqD9HP415cVcUrjWAiuPQq+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
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
Content-Type: multipart/mixed; boundary="===============0471229735=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0471229735==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB51447688D66FC358D6096CD7F7E49BL1PR12MB5144namp_"

--_000_BL1PR12MB51447688D66FC358D6096CD7F7E49BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I sent a similar patch out a while ago, but never had a chance to follow up=
 on it.  The problem is users might change the default.
https://www.spinics.net/lists/amd-gfx/msg60578.html


Alex

________________________________
From: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Sent: Thursday, July 22, 2021 1:27 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>
Subject: [PATCH] drm/amdgpu: Check pmops for desired suspend state

[Why]
User might set mem_sleep as deep and it will result
in amdgpu resume errors.

[How]
Check with pm for default suspend state

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index af1710971ff3..d92196429741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1468,7 +1468,8 @@ static int amdgpu_pmops_suspend(struct device *dev)
         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
         int r;

-       if (amdgpu_acpi_is_s0ix_supported(adev))
+       if (amdgpu_acpi_is_s0ix_supported(adev)
+               && pm_suspend_default_s2idle())
                 adev->in_s0ix =3D true;
         adev->in_s3 =3D true;
         r =3D amdgpu_device_suspend(drm_dev, true);
--
2.25.1


--_000_BL1PR12MB51447688D66FC358D6096CD7F7E49BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I sent a similar patch out a while ago, but never had a chance to follow up=
 on it.&nbsp; The problem is users might change the default.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://www.spinics.net/lists/amd-gfx/msg60578.html" id=3D"LPlnk=
">https://www.spinics.net/lists/amd-gfx/msg60578.html</a></div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Vishwakarma, Pratik &=
lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 22, 2021 1:27 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Vishwakarma, Pratik &lt;Pratik.Vishwakarma@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Check pmops for desired suspend state</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
User might set mem_sleep as deep and it will result<br>
in amdgpu resume errors.<br>
<br>
[How]<br>
Check with pm for default suspend state<br>
<br>
Signed-off-by: Pratik Vishwakarma &lt;Pratik.Vishwakarma@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-<br>
&nbsp;1 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index af1710971ff3..d92196429741 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1468,7 +1468,8 @@ static int amdgpu_pmops_suspend(struct device *dev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D drm_to_adev(drm_dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(ade=
v))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(ade=
v)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &amp;&amp; pm_suspend_default_s2idle())<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D true;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_suspen=
d(drm_dev, true);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51447688D66FC358D6096CD7F7E49BL1PR12MB5144namp_--

--===============0471229735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0471229735==--
