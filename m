Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5719EC4741F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF0D20735
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mp8vK7dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0D20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1246E237;
	Thu,  5 Nov 2020 15:31:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF80A6E237
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 15:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxhE5jdmyJ6SqcHPM4knQ+UmueQSAP+q6hvQHSqyWvUVhj4RzX6qyaV3y8dMAX9bINZx0PEhyB9L76qrS3PhX39OYkuv93rQMx61ermUPWBl8Afi1bUTLmoePjnPF42fh/6pvHRTb/CbwlmzwXRfQDx/Q4x1B+5/uTWWJVc/FihWCUPPRZSbSGXCjRaZszNWoXd3awhlM6IfeBU2O+TkA0hA+XbSiOKePi97L3o82+GS2SI+GuQeBnpkgwEwufOwO71+ZogR9fIZpSmxt/NoMVrzMiTHtN6qv9BLDTb7lzNlgb9st96qlW1zxb2RTULmzKhU5lVyH518qg4H0E4X0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMFzBs7Qpi5vBpKPJu6yM3iPHCy/uMd2oSg4fz0gMRA=;
 b=JFm4vWvZi7cQ41ftRx5RABqnFvlwVHrWM6E9wdyrK6e5ujiGY5Drcx2+tNcjIoanOkaWQcLWtJ35PGWHyKupYVk3AU8dzkjqz0r1wB/f5swmb0Bzhm5bAkjbhKppJODNWrIbEdlYtLbzET0YXDNVi8NINQHcJhRFGgztP6MPzvflB2ZxG364Xlhplc0uWbrG6eEzEALHkxIMIws5EHMqpurkUbfPe6h4Zt1S0/AS0atg6d9i8AFLaU8wAAa5cNu59grnTfR0N5S3/lmMmyjfMaszyX81UNcCHtsya3T65J1jpgCZsVPFPdXjxsU6lpM5U/Ih3ZxyrAZypfuKhabW3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMFzBs7Qpi5vBpKPJu6yM3iPHCy/uMd2oSg4fz0gMRA=;
 b=mp8vK7dcumGf5bDClYfhw/eeKb2LWV3WkaP/P3JSY9KnWUQ6aTQ3vEGLHyWkJQcQktvR/TQgQ3+UMt7tc4vGyZvMsquEV/HttO+7aqRACaMGn3jTOOZHJacXC+aRxVHYw/4IcKDXYjtvctDLlvxwggdokAf2FWXbD9nJQwAE7vI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Thu, 5 Nov
 2020 15:31:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:31:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix Arcturus fan speed reporting
Thread-Topic: [PATCH] drm/amdgpu: Fix Arcturus fan speed reporting
Thread-Index: AQHWs4d32gNCGOYiZ0KN9V6agYDNLam5qnXV
Date: Thu, 5 Nov 2020 15:31:53 +0000
Message-ID: <MN2PR12MB4488FCCDD4400EC566A14043F7EE0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201105152019.3651-1-kent.russell@amd.com>
In-Reply-To: <20201105152019.3651-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-05T15:31:53.251Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cafb343f-309c-48b4-21b4-08d8819fec6d
x-ms-traffictypediagnostic: MN2PR12MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4045B56F627E25A17AE65CA6F7EE0@MN2PR12MB4045.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AuKLgljtMQotM4UnqbNk90k6aPq+ZEaq1Wldh1o9lzFyORVXfpwwrBuD2IkAIVAsBHWXJ9iv3B3LTe5hPECqgn6W+o7Apoe45/mygvAPPqul620GHC6kJLQOAOWf9xxb4QVDF4MRJfGSMwAQ/iQWJKvBmgItfgB5TT6I5TsmEWU3fs7eQVJEcXg55uOBU/iz0yQKvp9UIEU2dQs8PYahEi1Brocoygw4jYqGehBz6QBMEFDChc3YcZLPxcF1kRJw8vupyE0FQK0AiPagbLOEGpO9/c4EjhAablgceQGD6eCAwAzPogKrN5b1mCn5AU7Bn5KhK2iG+9s5SOlsxFVGQVR7AVU1Jfc4YPgSwpdURKU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(26005)(83380400001)(53546011)(316002)(33656002)(2906002)(6506007)(19627405001)(5660300002)(7696005)(166002)(71200400001)(110136005)(86362001)(55016002)(966005)(66446008)(8936002)(64756008)(66946007)(8676002)(52536014)(66556008)(66476007)(9686003)(478600001)(76116006)(186003)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qontkCaJ1Wpv5dBnqfyTmNeQxFoCqFF5nYWuIPz3jW1aeU7K47tDCb1p1njFXXIi4MTvQ1txp12+LyxcxqDMdHFlAfcDbebrA53/CS4ybF9gEM6DlxtI3ZuUqV0t2Hz/KGsIf68mzh3DMAu08sMXEdYDgfjYHKwnxGWwsyP2m3LrCTk6y+OP7WarpYPq8a/1qY9L9yMRA1rA7KUkYdmQ/1fiaAsmWQjEmdeiV0RfmS134UaURGJk8HYq/FdkdTAgCqYjGLiyQYMiwFwMkJUlNPq3xhPw0uZN28mmRgXewNiAVbKMbP1gURLAeuwPldMVGO9JetfMeKvJBInUhen4VT3gz4ZKOGXslWD7vuQv125RDqSpknZ+9V/nhU5QgK7qAAwN5mXXqI7e/0vG4l36oJzqyjqyXLRRndg6BuhXzwWI0St/MI02f13bU3z3Bpkw2d3/PbiaOtnLS4y1IdqSWY0MC2nVRKWvM0wBZUjF4KRvZQgi0C34J+51IC7/7pOICcGW3PHsAepXS6uFiqblwDenPEeveyky/rzurlHxf3j2y7HnVXRfnkJIikURY1muAM1Xo7dS34OSOBkpVfPMCNqyIexGUa/i7T9wdbUAzgzC7Ag2mxN8CLPkce2LIp8b9jeT0DiDaQ64ntBnDst5YQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafb343f-309c-48b4-21b4-08d8819fec6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 15:31:53.8148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwrgJlO6ICPrfI7zHuWPNcfHs5Oqaswjs2oByc+m0V3gDEwKm1G6qFYkj4XTovE/xM8XsUMBDSJBFlCUPigk2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
Content-Type: multipart/mixed; boundary="===============1302693194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1302693194==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488FCCDD4400EC566A14043F7EE0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488FCCDD4400EC566A14043F7EE0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Thursday, November 5, 2020 10:20 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Arcturus fan speed reporting

Arcturus doesn't have a fan. The assumption of "if the manual fan
control bit isn't set, it's on automatic mode" does not hold true if the
fan is missing, and results in exposing an invalid value for fan speed.

The SMU metrics table accurately reflects the lack of fan and will
return 0 for the fan speed. Trying to use the
smu_v11_0_get_fan_speed_rpm function will return invalid data, so just
stick with the SMU metrics for Arcturus

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d96048e98237..4fd850e58004 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1139,14 +1139,9 @@ static int arcturus_get_fan_speed_rpm(struct smu_con=
text *smu,
         if (!speed)
                 return -EINVAL;

-       switch (smu_v11_0_get_fan_control_mode(smu)) {
-       case AMD_FAN_CTRL_AUTO:
-               return arcturus_get_smu_metrics_data(smu,
-                                                    METRICS_CURR_FANSPEED,
-                                                    speed);
-       default:
-               return smu_v11_0_get_fan_speed_rpm(smu, speed);
-       }
+       return arcturus_get_smu_metrics_data(smu,
+                                            METRICS_CURR_FANSPEED,
+                                            speed);
 }

 static int arcturus_get_fan_parameters(struct smu_context *smu)
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cc266d21dcb5e4d84073808d8819e9820%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637401865460755885%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DO8kmXHVEGi01B7S0gk5MPafIEiuBC9v7catH%2FASo6iQ%3D&amp;reserved=3D0

--_000_MN2PR12MB4488FCCDD4400EC566A14043F7EE0MN2PR12MB4488namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Kent Russell &lt;kent.russell=
@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 5, 2020 10:20 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix Arcturus fan speed reporting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Arcturus doesn't have a fan. The assumption of &qu=
ot;if the manual fan<br>
control bit isn't set, it's on automatic mode&quot; does not hold true if t=
he<br>
fan is missing, and results in exposing an invalid value for fan speed.<br>
<br>
The SMU metrics table accurately reflects the lack of fan and will<br>
return 0 for the fan speed. Trying to use the<br>
smu_v11_0_get_fan_speed_rpm function will return invalid data, so just<br>
stick with the SMU metrics for Arcturus<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 11 +++--------<br=
>
&nbsp;1 file changed, 3 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
index d96048e98237..4fd850e58004 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<br>
@@ -1139,14 +1139,9 @@ static int arcturus_get_fan_speed_rpm(struct smu_con=
text *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu_v11_0_get_fan_control_mod=
e(smu)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_FAN_CTRL_AUTO:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return arcturus_get_smu_metrics_data(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; METRICS_CURR_FANSPEED,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; speed);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_v11_0_get_fan_speed_rpm(smu, speed);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return arcturus_get_smu_metrics_data(=
smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; METRICS_CURR_FANSPEED,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; speed);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int arcturus_get_fan_parameters(struct smu_context *smu)<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cc266d21dcb5e4d84073808d8819e9820%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637401865460755885%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DO8kmXHVEGi01B7S0gk5MPafIEiuBC9v7catH%2FASo6iQ%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cc266d21dcb5e4d84073808d8819e98=
20%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637401865460755885%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DO8kmXHVEGi01B7S0gk5MPafIEiuBC9v7catH%2FASo6i=
Q%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488FCCDD4400EC566A14043F7EE0MN2PR12MB4488namp_--

--===============1302693194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1302693194==--
