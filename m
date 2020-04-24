Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC9C54FD0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDFAD20728
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AAwfC+ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDFAD20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 990086E069;
	Fri, 24 Apr 2020 13:48:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D62B6E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 13:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+g3gO62SzhTyuqPLMJZAE4nzRa1B7/wAv8Y8wudgz7MS7OhyzVwybQamqWN7v8JgTm0PyO9rwaS20iHKqTOxpS4E8KJz4Pdcd8cdAYiaF62UMviAPZATLWGsiMnHsgHIcA+fIGA25UJN4O2Kty8b9MVFxpimitMOad80MNGGxyA1CHnV/zMsyJKaeTX6MZrasLI0rxhAwRFVLgm1U3FncDX5+p0gEFu3JSIOIKFt+0s1hRHmEsIonChAPp5GWh5MXvdw6dqK9bqWNsVYKmp2RF0bCre5uFk5U0eZe3+tRhlso867E2lLPjHy/a3YMnD1Smh6LDUYlSxPe7ptx3s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTrkAuQBcjhlGXBL1ONeVhjzGhkc9SqVuetrG0kmQ3U=;
 b=JZu5VDhG75AIBkBC5uCkW3G8rreUFqcx8P2CHq7q5HFHukNTbpARCp2IXdhBi6JpJ0IwpGNGt3Iu0rMuFCvisB9TmUwZ71MpJrcEQ/bgRek+H1ZMxwtKh91RLnk0i/+F4xwgND4e+2mL4hKJdt5L/Vb0lPpEeHfOXm1xOXC80joOoI11FixPDzvvToGmdM19JoYsTtCIfPGO+xUr02OidjCavFE5sDD8fmSKsfFkJsEzQQ28Ir/JLM0mbltmDfwKIEg0lc0w/c3FrdtQJapSco5DoYrVnil1HBRLOKCRbIdVY0OkTMEGxruXRIcp1MnsY68nDIbD6LVeIz005toSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTrkAuQBcjhlGXBL1ONeVhjzGhkc9SqVuetrG0kmQ3U=;
 b=AAwfC+ea7E5n406sAXaLn+tyQCf6kZ8BuBDmiIci8o2AT5EciFZTtlZ2diVTPD8JAVJGsxDj+ub+L6IZAIQm1Di5/Z+WHGsDpkNgXSbXh7hR+0z7tS6wbK3/oxmHvRbj7t1txTH8QBuk6SgEO/sXq8k3LkHXegIS94TgDOIG9EE=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3614.namprd12.prod.outlook.com (2603:10b6:208:c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 13:48:55 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 13:48:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter
Thread-Topic: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm
 enter
Thread-Index: AQHWGg85jE3sbM3BLUix4ahjyxa42qiISf+v
Date: Fri, 24 Apr 2020 13:48:55 +0000
Message-ID: <MN2PR12MB44881F657A4967AA4802DA84F7D00@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200424080547.25599-1-evan.quan@amd.com>,
 <20200424080547.25599-2-evan.quan@amd.com>
In-Reply-To: <20200424080547.25599-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T13:48:54.818Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.72.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79371a49-7e94-4d26-02b9-08d7e8563b36
x-ms-traffictypediagnostic: MN2PR12MB3614:|MN2PR12MB3614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3614546BD3E91726DEE6D60DF7D00@MN2PR12MB3614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(66476007)(66556008)(54906003)(4326008)(9686003)(110136005)(76116006)(86362001)(55016002)(316002)(53546011)(19627405001)(6506007)(66446008)(66946007)(64756008)(52536014)(81156014)(71200400001)(5660300002)(186003)(8936002)(33656002)(2906002)(8676002)(26005)(478600001)(7696005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ucJXRDSs50iB7/p2O+5lKGndwuBoPtsKlHvsjvWcdXnvPHQqAR6mMvX8py/M9y6RY3EQLvJHIk0LZwjJKvTgBV/TigWX9V3PLlhPNBaPeFgbAduNaRrUHcbtljRd6V/+ud3/iT/N7uLxnHUZ4qJABXK5g75N6Y00ydzdnQJAXWPCW49WKzydE6awrevjfN9+wgwB9F6wsXM9+M2vUHNNjYgLM2s1UOiJNO14tz2n8xLIeRZE7X3Hebz5UCOEQqi7J8AdxSBDc0UiqKPFoiltu19j7zR6c0XiTbPi+Ss3YCYCHtxvStnLRt4ZZEMYZxP3eeNBbTRftxQqFBTJk+bSUkUuQfTqtQahk3yERRGBai7FXLHrEMt8IiP7seuRPR/Ghn6UI365g8dJdMDvIkfXg0DACLrxgUA14hu4NbUZkZeFZwOHX2g/YMM+tYRoxNg
x-ms-exchange-antispam-messagedata: BRL5kSfYRnCKiA4xQzCil5Pb5PbAz9zk3qEBuIaENZPDWzN8etKVFuzrq9QFQ5KHouLdnpxtGsKIq67qwAANnrY3UX7uDVfnPBZRyqbEFQ0HG3ColHlXmVWHPaXZjMUXsPM6fqeKMEM2Dw7bitl2TA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79371a49-7e94-4d26-02b9-08d7e8563b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 13:48:55.3206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6OcY9aNKYVYO9Fupx+7kiWSEEScQvgyXKrWMhk1D4uQ8miz4KeQITeMLk7xvB4LqHdD9vswG6bShdcAArUM4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3614
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>
Content-Type: multipart/mixed; boundary="===============1209760460=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1209760460==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44881F657A4967AA4802DA84F7D00MN2PR12MB4488namp_"

--_000_MN2PR12MB44881F657A4967AA4802DA84F7D00MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, April 24, 2020 4:05 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Quan, Evan <Evan.Qua=
n@amd.com>
Subject: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter

CG/PG ungate is already performed in ip_suspend_phase1. Otherwise,
the CG/PG ungate will be performed twice. That will cause gfxoff
disablement is performed twice also on runpm enter while gfxoff
enablemnt once on rump exit. That will put gfxoff into disabled
state.

Change-Id: I489ca456770d3fe482b685f132400202467f712b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 08eeb0d2c149..71278942f9f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3453,9 +3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)
                 }
         }

-       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
-       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
-
         amdgpu_ras_suspend(adev);

         r =3D amdgpu_device_ip_suspend_phase1(adev);
--
2.26.2


--_000_MN2PR12MB44881F657A4967AA4802DA84F7D00MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Friday, April 24, 2020 4:05 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&=
gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runp=
m enter</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">CG/PG ungate is already performed in ip_suspend_ph=
ase1. Otherwise,<br>
the CG/PG ungate will be performed twice. That will cause gfxoff<br>
disablement is performed twice also on runpm enter while gfxoff<br>
enablemnt once on rump exit. That will put gfxoff into disabled<br>
state.<br>
<br>
Change-Id: I489ca456770d3fe482b685f132400202467f712b<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---<br>
&nbsp;1 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 08eeb0d2c149..71278942f9f0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3453,9 &#43;3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool fbcon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_=
PG_STATE_UNGATE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_=
CG_STATE_UNGATE);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_suspend(adev);<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_sus=
pend_phase1(adev);<br>
-- <br>
2.26.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44881F657A4967AA4802DA84F7D00MN2PR12MB4488namp_--

--===============1209760460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1209760460==--
