Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC4C2D0CA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39ABB20663
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 21:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="inZAst2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ABB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 448076EB4D;
	Fri, 13 Dec 2019 16:59:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770053.outbound.protection.outlook.com [40.107.77.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D64546EB44
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 16:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgH0oCUd1tAx4LqrLtpJp/3VKsFXDX/oAPFVanT/2wySInuw4rLl6ne8dkaybHwMGM7Ou4WaPI2uAqyW8oVzB59ulQFj2XjNHDc7FoGtuchueCN8eMpagGco0k5v7Dl56oN5nsui6v/AX80cffAg7xn2LPihP5W4X7tUv/hMSyoKI/of5L1nPbmh0fjLSRlEj60ipDITQwrfZmiwxX18jqJkJbcaR9RXPGucQyVXvnW68jv+bxSp/4IkpnPJR/n7zGxeVAB7+eR81UaGOlEQcSriBwBzZtF0BoZfn/LQDwgw26ZG3NtUwFfOavfK8EHyXks3EenvNF9GxlUSFIs+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2FzLiOXHGOwV677UDXLMbgFTR5UwFLfR7i/YhxRIeo=;
 b=g/3pYEiG/BGX6byul6S/kSTEkoncDPYknD9ZE/mq6xT9rb6R0EkBbnRmLUz1blyAi2XZO//e6ZobupsbCqBNRlr8RpLwR/azfHV9lgrt/pIEbT+abvJwZ8RnmVWOzyoQ0WV+G6ABhAJfjlj1Z2tto+jlCj2wH/2Z0L7t2jFLxQ9Ni+qLf7zPnX7kZw0OdDZZm3WAmTgIvWsvQDzV782R6zSNlEl3gRugw+QolUUwipWOZkhpeVSUP8mjsMrIVLARG5IhLVo7W4OJuKQPKpzpyiVsR56hOrAQHaWxIiNvFBssuNRuW8jgYSB/kfk151dVR4ZHzABM7jdy2R/pgYX/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2FzLiOXHGOwV677UDXLMbgFTR5UwFLfR7i/YhxRIeo=;
 b=inZAst2LFAI4b75Lf2DgPS8iCj2I79NTbrXGALHCYvh2J3g60LqwnGctTU8z5bRqYpwWk8jV721RLHM3qy3Pkls+N6yVjbfFZK7dSndrRvlJaMHH0tFWrxtWxWJhf2pCW3rf8Q2dR7bZjP8nuA8ykUOjEShfc+vdpNCsIVuUJK8=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1552.namprd12.prod.outlook.com (10.172.53.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Fri, 13 Dec 2019 16:59:47 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 16:59:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add CU info print log
Thread-Topic: [PATCH] drm/amdgpu: Add CU info print log
Thread-Index: AQHVsHgrT+bVOUG/cEy7qfgrCS5Abqe4THB3
Date: Fri, 13 Dec 2019 16:59:47 +0000
Message-ID: <MWHPR12MB135891748F7D943358FB8E30F7540@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191211230958.31523-1-Yong.Zhao@amd.com>
In-Reply-To: <20191211230958.31523-1-Yong.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-13T16:59:46.504Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25dc88dc-2a82-48b4-ec07-08d77feddc1a
x-ms-traffictypediagnostic: MWHPR12MB1552:|MWHPR12MB1552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1552FFE5827F0711B4D1FB5EF7540@MWHPR12MB1552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(189003)(199004)(19627405001)(5660300002)(33656002)(52536014)(6506007)(53546011)(7696005)(8676002)(86362001)(66446008)(64756008)(316002)(26005)(9686003)(66476007)(55016002)(8936002)(110136005)(2906002)(81166006)(71200400001)(81156014)(76116006)(478600001)(45080400002)(66946007)(186003)(966005)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1552;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mN3FtMqUPsi7rTZHjFzV+0+x8a6YRmhVoV/PL8YMF3DD9YNNER124RiRxpRP348bsfCfin9NUfjZUN36vame6wlMF1pzrgzVeU/MC8izvGZh201Ubke15sZiLNRH8s8MDmmw9ichDjHBXsuDqHiTbuEeIteiLMRt4E+ihvcHYIFj0lDJf2YHgIDcyvxwe02EBulSxxhhzZkHbh5nA8I8pKZTd4+PwG2admQ/KYotyxTRyFjHu1pkY8Tu/ydSAbVsn076T7AGARn+9WOR3leBDjh6cULwWHLSfszYtHq1g1T/aQmzg03XS5wHyCau5n72jYarcycTqCroyeSIbMcbTvAPy8PmXIAVGeTyvEPu8f3olUUWsZn/7SDMJ5fMqT15kUYF/GdRyc42JUf+ixgPvNcmXg6zdSEdzQ4FjHsX7PBGqI/KWQeLa9v2JsWmQeEw0cZ6XqD1R0kFtKqRJlGXL8NxtIkhoLNwchIo9jkhdiY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dc88dc-2a82-48b4-ec07-08d77feddc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 16:59:47.1533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ebbdOCA6/1QjrKOa6h33o7dWBSrqYDhkZEnsFJ+dyERuFAO280wPbpauxYfxxl1BdcPrm9kcNWDVut0Bvo9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1552
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
Content-Type: multipart/mixed; boundary="===============1001118885=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1001118885==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB135891748F7D943358FB8E30F7540MWHPR12MB1358namp_"

--_000_MWHPR12MB135891748F7D943358FB8E30F7540MWHPR12MB1358namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yong Zha=
o <Yong.Zhao@amd.com>
Sent: Wednesday, December 11, 2019 6:09 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: Add CU info print log

The log will be useful for easily getting the CU info on various
emulation models or ASICs.

Change-Id: Ic1c914938aa3445d8dbfdf6a237bc1d58b0d5267
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8992506541d8..c778b6db5e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3032,6 +3032,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                 goto failed;
         }

+       DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n=
",
+                       adev->gfx.config.max_shader_engines,
+                       adev->gfx.config.max_sh_per_se,
+                       adev->gfx.config.max_cu_per_sh,
+                       adev->gfx.cu_info.number);
+
         adev->accel_working =3D true;

         amdgpu_vm_check_compute_bug(adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ca823e1d397ec41ec64f208d77e8f47bb%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637117026245492516&amp;sdata=3DrqL98htPP6x%2BufHyG=
CzVo65Zib7x3%2BdEPz83uNHzMx0%3D&amp;reserved=3D0

--_000_MWHPR12MB135891748F7D943358FB8E30F7540MWHPR12MB1358namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yong Zhao &lt;Yong.Zhao@amd.c=
om&gt;<br>
<b>Sent:</b> Wednesday, December 11, 2019 6:09 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add CU info print log</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The log will be useful for easily getting the CU i=
nfo on various<br>
emulation models or ASICs.<br>
<br>
Change-Id: Ic1c914938aa3445d8dbfdf6a237bc1d58b0d5267<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 &#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 8992506541d8..c778b6db5e42 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3032,6 &#43;3032,12 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;SE %d, SH per SE =
%d, CU per SH %d, active_cu_number %d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.config.max_shader_engines,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.config.max_sh_per_se,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.config.max_cu_per_sh,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx=
.cu_info.number);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D=
 true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_check_compute_bu=
g(adev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ca823e1d397ec41ec64f208d77e8f47bb%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637117026245492516&amp;amp;sdata=3D=
rqL98htPP6x%2BufHyGCzVo65Zib7x3%2BdEPz83uNHzMx0%3D&amp;amp;reserved=3D0">ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.fre=
edesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexan=
der.deucher%40amd.com%7Ca823e1d397ec41ec64f208d77e8f47bb%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637117026245492516&amp;amp;sdata=3DrqL98htPP6x%2=
BufHyGCzVo65Zib7x3%2BdEPz83uNHzMx0%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR12MB135891748F7D943358FB8E30F7540MWHPR12MB1358namp_--

--===============1001118885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1001118885==--
