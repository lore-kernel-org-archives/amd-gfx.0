Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD07C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D592072A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QEg7Z/nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D592072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58896EA5C;
	Wed,  8 Apr 2020 13:27:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8A46EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhGmvge22oQPhT+lejc6pFyDWhCda56Nd5dGVXsvCL7quJqsJ21vlRiOtuN3R0G5eTSGmc99mDZIacP2hTugNBxDe6B2D9OW5BqXCyv3jpuGhfxjYcceJsWYcUPkUwKkn+9hVgNLEO4YNBrwicZRGqv59Hrd2bQQgo+WNpNtKayhAE0z9YZvB3UEMII68oKqkg9gVI7GFgRaSQS/l3VA6si5hevrmro76GARvAcW/JeO928Vkk187AX1GUyGfTWQuKWwzt28rfVjLTDNiSC7LhU4+2bGDk9oG0eiCWttciQih53T0+eRwJKa3T7hLRVqkuNkNApdy57rLZxKMCxWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWWMpdifUtjhgK+84qlhdCQToMHie0p1YZ/jhdctrso=;
 b=WHL3x8SsPVkZftAM3oGpPFuN0cAukCj7pd2KbOVRzvmwm8bBdXnsL4R0Thz1gXKq4HV/kvd/jkvHRZZFwqw0u+7UgXI7+2GwyCoixGAOZRXno0HNnnsPghsIMhmaFTUw4451kCwarF6DD6eDG9lDN/mgdbpeohPdP6AL0sRQfWw/ANiJbpabCnH8/ATEBMGi2/9WuwIVZ1KqBlgvuXfnZmb1bgXvuxQtvSScHio+arD0AfGoHB0t7V6HLbkpyHu+COxJdkDQq1Zv/saSZ2voGlhYextSGGSfi3vZ2Gdg6oLVuCDPrJhKryg2tX0IHKPj4afqTEe/g6E1ArmdPg9uXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWWMpdifUtjhgK+84qlhdCQToMHie0p1YZ/jhdctrso=;
 b=QEg7Z/nk8LjmeQL+Qnvh/bX83eAzzA7BHumbHQKfw4JM6tTaPHxMb7RSoieAHQT3c5HZCc/4UT4FS8xwPMgKqKNv3qUSBGTpToSVE/o3okcSrMTB0/cN8s8ojfHIJifyD/VdXyeOe1IpHmp0pa3tnTOpPTvzZh2yl4Zsh7NNP6U=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Wed, 8 Apr
 2020 13:27:09 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 13:27:09 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
Thread-Topic: [PATCH] drm/amdgpu/sriov move program of sq_config to PF
Thread-Index: AQHWDZEtkMLw9DEZf0q3eoCCfYVTX6hvN5Tm
Date: Wed, 8 Apr 2020 13:27:09 +0000
Message-ID: <MN2PR12MB4488FA323BA0F10D1D894BFBF7C00@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
In-Reply-To: <1586342024-29088-1-git-send-email-Jack.Zhang1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-08T13:27:09.210Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d6c47c8-e3f2-455b-2d78-08d7dbc08a6b
x-ms-traffictypediagnostic: MN2PR12MB3693:|MN2PR12MB3693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB36930818A055DB5F1066FDA7F7C00@MN2PR12MB3693.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(66446008)(6506007)(66556008)(64756008)(76116006)(45080400002)(966005)(66476007)(9686003)(55016002)(66946007)(478600001)(7696005)(110136005)(316002)(53546011)(52536014)(86362001)(81166007)(33656002)(2906002)(19627405001)(8676002)(71200400001)(26005)(186003)(8936002)(5660300002)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +64ixqeq1A408f7sud0Qz8E5J7oU4rbAlkK1o7sOJntaq0tmbPkW3KGdXQ0iHBOXczl4GkI7BfDTQsx4VB/d1E42JIvXZtDqsGNsFd4wMWaP9Qd6uepX2YMn5DEPzRKLng3gqkjya5T3cLVZXXb55N6lW7FJI7Rr5RcXrztaQnnFd1qjzcncj4ER2qz9qVRYAeJXGlyf2n3krS5Bi8v9WdX6eeV0cU+AswGE5DiqLhjTCQX5tu3rWtDKxc0sDwKx5uuJHt0VeDC3NdpOvqdg8xNtnx0r+LkjtoUwZTvtybrEuv9yeaUwdXyg50KQmv/mserYdZ2xJU9LhzLmXc4TfTXRCDNUyjQPfikL/CoU+lyhJe8pscqZuZYGeZj2ybUd/zs7lG9icnE2F+h+aEpen74aPvpneGTeR90JI7M3D+8vTlz/jZBJngp70hlaSbULzPSj5fRcY+KxL52TG7Scr+TRieepIRDMJpGYkvD6JS0=
x-ms-exchange-antispam-messagedata: bHlmKrAVjSqueODc3UW+aRC3Byrz+4wfNZl38bCRQBBzv09foq8hQzQj585cnkY1dNrHPK/g9gXzWO+9zbCyzNuO/phg2+zKYEbaw5EbyOJkp46cgIk3MeLeYk92RYcSYbKcoe9pHvGVB23K7xVQmA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6c47c8-e3f2-455b-2d78-08d7dbc08a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 13:27:09.7493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YsWWSbIuBNQnZI1YY4/tmH+9WRyGheO1kySaS0FrFshq42u2U/BILMt5BDTuX52fEOze9lHJLhHBEiHva4AkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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
Content-Type: multipart/mixed; boundary="===============1535943799=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1535943799==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FA323BA0F10D1D894BFBF7C00MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FA323BA0F10D1D894BFBF7C00MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jack Zha=
ng <Jack.Zhang1@amd.com>
Sent: Wednesday, April 8, 2020 6:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: [PATCH] drm/amdgpu/sriov move program of sq_config to PF

Since SQ_CONFIG will influence performance behavior, it's
unsafe to program in VF. Therefore, program of SQ_CONFIG
need to be moved to PF under siov. Skip it here in guest driver.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 2d56b067..9bb89f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2575,7 +2575,8 @@ static void gfx_v9_0_constants_init(struct amdgpu_dev=
ice *adev)

         gfx_v9_0_init_compute_vmid(adev);
         gfx_v9_0_init_gds_vmid(adev);
-       gfx_v9_0_init_sq_config(adev);
+       if (!amdgpu_sriov_vf(adev))
+               gfx_v9_0_init_sq_config(adev);
 }

 static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C38604ab03f8142a547f808d7dba854d4%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637219388971131150&amp;sdata=3DgBSa%2BchPmFMSaTgAq=
8z5Sabs3G6ARuHN8wAPSi%2FoJqA%3D&amp;reserved=3D0

--_000_MN2PR12MB4488FA323BA0F10D1D894BFBF7C00MN2PR12MB4488namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jack Zhang &lt;Jack.Zhang1@am=
d.com&gt;<br>
<b>Sent:</b> Wednesday, April 8, 2020 6:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov move program of sq_config to PF</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Since SQ_CONFIG will influence performance behavio=
r, it's<br>
unsafe to program in VF. Therefore, program of SQ_CONFIG<br>
need to be moved to PF under siov. Skip it here in guest driver.<br>
<br>
Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 2d56b067..9bb89f2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2575,7 &#43;2575,8 @@ static void gfx_v9_0_constants_init(struct amdgpu=
_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_compute_vmid=
(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_gds_vmid(ade=
v);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_init_sq_config(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v9_0_init_sq_config(adev);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)<=
br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C38604ab03f8142a547f808d7dba854d4%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637219388971131150&amp;amp;sdata=3D=
gBSa%2BchPmFMSaTgAq8z5Sabs3G6ARuHN8wAPSi%2FoJqA%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7C38604ab03f8142a547f808d7dba854d4%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637219388971131150&amp;amp;sdata=3DgBSa%2BchPmFM=
SaTgAq8z5Sabs3G6ARuHN8wAPSi%2FoJqA%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FA323BA0F10D1D894BFBF7C00MN2PR12MB4488namp_--

--===============1535943799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1535943799==--
