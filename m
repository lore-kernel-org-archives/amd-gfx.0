Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A282C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 12:46:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159542080C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YGTW5OTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159542080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71E46E10E;
	Wed, 26 Aug 2020 12:46:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605C96E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 12:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur6pacHMZDbqrgj9WZZBJcCZ48Z7DIOFR4Qy52HrtrfnW67BsuhzoRxZzvwjbmJq9fkknF5abj57/XcxQ0wpZP31H23LctCtU1+mSeP7n0UBEGpEV+b/0MdYmdlmG56Rtr5/qWGWyxOvv1YlJeAzvTJtWqS647M65degMVuHUAST1BC+Y7xM8GLZmNe0PTWQbukkdU4KowfhWoU51TgGIV27NX3kMq28z8cRgeiZUEKE8bvW8kh4AiZJb6AQHSM1Y8zaW+Bn8oR+kek6T71PKLqmw4IEOt+twzAvFoYGo2dXsqj3G5zQDeXP5YMROUADtweE5Ec+uBGqbIybkoUIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mALdRKykjoRgdAD1L6f32WPOPx/K1y0irJL/rlFbQic=;
 b=csd3MqK7BLMqwQz4gofdqWZNfbi58krUNs8LvpNqMXeSw0Ho+Hn/rrp+UhPIS1xDRxMcMSIsgrgJjEOlt5RHZh3gkjk6QYfbAk6g7ITQjpXBkUMh2CDhuMi3k9yBb0F3k6xKkdeZgyneW+cVp9EC799NrXxbrU8PlGpcHNXW8wNp1q1809dJMDlMohOdJnIPfQTbPHjQuhqc32Ygaz0AKWI9R9Df8NSl+n6v+SIP2KwSaRFHP6hKhlCHegNCLQG4lgNO78ibuBW41pejXv9e00UUBQV3LjH91e+b6dJrRUc6yqSmC4ndZcA8YNqmDeY5LOFco9dL/rAwPsqh8RmYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mALdRKykjoRgdAD1L6f32WPOPx/K1y0irJL/rlFbQic=;
 b=YGTW5OTPg8qkVW/3I1JNfU5XKyZoPaswiayP5LxkYtS5MjVUVtK1YUb1S9DtxzFmPYNmhzNSosIgYuuiU0Zjh15PEHgIHlWMU3MBqV14QavQ2+3KlcSGC+Rpzz0kVzznIOZ61sf3LrMy58UMUOZpeMPGLybs0TnNabdqyQe8AvU=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3983.namprd12.prod.outlook.com (2603:10b6:208:169::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 12:46:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 12:46:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: suppress static checker warning
Thread-Topic: [PATCH] drm/amd/pm: suppress static checker warning
Thread-Index: AQHWe1mgJEQDpbGw4US0og5AeO67QalKVwLP
Date: Wed, 26 Aug 2020 12:46:18 +0000
Message-ID: <MN2PR12MB4488CEC0B1717AC9EB5C3450F7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200826033246.9063-1-evan.quan@amd.com>
In-Reply-To: <20200826033246.9063-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-26T12:46:18.036Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 012c5926-a594-4efe-22e8-08d849be074a
x-ms-traffictypediagnostic: MN2PR12MB3983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3983E82D55ACDF87A604B36BF7540@MN2PR12MB3983.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EpQFJb+fgrxnFN1BRTCEHXnYVuKsr8IMLByH/mU3Ji5synLGBbcIlS9uJZOEGIodGZv2mwN5BjwUTM5474QL0SB6nt71WZgvjMtE01RMvamWUbUTgxTPhwYvbfXxINyxxT4bCy/eG5nvpSOTxuhWFQEerw/U2pfkN9OHOkI/UiLf9T2LOyAiZw2g7lfMMohnKHI4NyGn68zh4pa5DbnmOZnut7gr2UvyP5p5tEWcKxt9WhjrmWA84YWVe4qqymWK0V9SSFSsZ5UQufWO7IAkgEC+MHOB9Mk65vSwLzZC/TnXTCzzVFdTuc0JgSER5Mz05tEJ1qsU9w72yXKoY55MMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(8676002)(19627405001)(86362001)(55016002)(8936002)(71200400001)(110136005)(33656002)(52536014)(2906002)(53546011)(478600001)(186003)(7696005)(4326008)(316002)(64756008)(66946007)(26005)(6506007)(66556008)(66476007)(66446008)(5660300002)(76116006)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SYvcNB/tI0DtO2lo2ZO+NMquk2ZYrYgp/g+hx2V2KsUJhG1wwMEdCyQaT8DnuBQJh1ntzUWKY1IDJNb+8YqfYOlQTksn4DL3hKv8IbtIeOHd1bJBrg3ajKPpC5jKRj+PQ9KguXtX0ox6l+LCayYb27FNh/Kov0pGNy7SjqNAlhlaquckfF7k2aTpdKM3nlbXarjl/uqnhs8xB8JEaBtjXGMXPujjrA4sHn7S4bfb+N0gVlqiQaqU0P2QJGXXhujOL6Vp+ltR907CFjM5bFHzXNCot+5NBbNo5Dze0KZWpBRM8pVW03T466jb3pY2ETfwHtjZP2EyOypF3FwjJmw7kzdKf2RxYr0VOGUXLu/CafGCIRLx/v/px5Mr1FGtZ7oRanBaIIGjt0E/z95c0wVaKHrgvY4PX8joFj0Bxa1XeSvxxHWYsvoc59MoFpt0cIMUUJT5xKWpBPv5Mr4GDGnKL+YI0CIOU36IULH+vqD11mYh9Q0ciUkJSKene0VkdUrVHepP7zWbhE149rCF8bf9uMNRLjo879WLaT4ejcGFLOFq/Wwkns50xt01oGefJAl8QQFKWMkmsCglunMYR6PTc5CxrViHW0mEIooQXRf3N17iLKsug1q83GCDU6NNLyTud4dlbLpEA3D1d9X4D44ppA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012c5926-a594-4efe-22e8-08d849be074a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 12:46:18.5379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irVJmpuxqfMb8/9qXq3Fyh+IGi/ZR/leDEDAUm0rsH6D3ckafaU5pb3VyJv79vzIIh4s7vc6KaU0eMil5qGOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3983
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
Cc: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
Content-Type: multipart/mixed; boundary="===============0038527153=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0038527153==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488CEC0B1717AC9EB5C3450F7540MN2PR12MB4488namp_"

--_000_MN2PR12MB4488CEC0B1717AC9EB5C3450F7540MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Tuesday, August 25, 2020 11:32 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; dan.carpenter@oracle.co=
m <dan.carpenter@oracle.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: suppress static checker warning

Suppress the warning below:
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:274 phm_=
check_smc_update_required_for_display_configuration()
warn: signedness bug returning '(-22)'

Change-Id: If50e39fe401c16d981d917ef7d8d5ea81d6538df
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/dri=
vers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 9454ab50f9a1..1f9b9facdf1f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -271,7 +271,10 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmg=
r)

 bool phm_check_smc_update_required_for_display_configuration(struct pp_hwm=
gr *hwmgr)
 {
-       PHM_FUNC_CHECK(hwmgr);
+       if (hwmgr =3D=3D NULL ||
+           hwmgr->hwmgr_func =3D=3D NULL)
+               return false;
+
         if (hwmgr->pp_one_vf)
                 return false;

--
2.28.0


--_000_MN2PR12MB4488CEC0B1717AC9EB5C3450F7540MN2PR12MB4488namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 25, 2020 11:32 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; dan.carpen=
ter@oracle.com &lt;dan.carpenter@oracle.com&gt;; Quan, Evan &lt;Evan.Quan@a=
md.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: suppress static checker warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Suppress the warning below:<br>
drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:274 phm_=
check_smc_update_required_for_display_configuration()<br>
warn: signedness bug returning '(-22)'<br>
<br>
Change-Id: If50e39fe401c16d981d917ef7d8d5ea81d6538df<br>
Reported-by: Dan Carpenter &lt;dan.carpenter@oracle.com&gt;<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c | 5 ++++-<br=
>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/dri=
vers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c<br>
index 9454ab50f9a1..1f9b9facdf1f 100644<br>
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c<br>
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c<br>
@@ -271,7 +271,10 @@ int phm_start_thermal_controller(struct pp_hwmgr *hwmg=
r)<br>
&nbsp;<br>
&nbsp;bool phm_check_smc_update_required_for_display_configuration(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHM_FUNC_CHECK(hwmgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwm=
gr_func =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;pp_one_vf)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-- <br>
2.28.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488CEC0B1717AC9EB5C3450F7540MN2PR12MB4488namp_--

--===============0038527153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0038527153==--
