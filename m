Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055D6D58CC9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 12:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF9C10E693;
	Tue, 24 Mar 2026 12:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T1+8TkvK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3AD10E693
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 12:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNHrcz+PYjDuIT8EWtzuu3rGe7PQnk1hoTXKkd1Z5w96IVt2UFhO96KwtXsqrzIqVWPm+ky3E9ZGJ+545RoGL6574GbMGqeHQ1AvPE1N3zZdvUSvbflC/gLQ8e1IjDZ651+uqlM+sfTcw1UVx8JHE1kEySpRhzNLr0vOy2Tfa5EcadQ2+D5jErahTZ7CQtzBZjxrtR1H9a6dyBbbZl64Y9ueCvv4U4v+YUtg0Gca1ySmwxfagEX/aAABsmUpGD62M1n6/PuEWyW6w1gl28QJyRxpaiIWx7CzS1YyeAXUhxe8uqnoOKu7SIUTtsZZ/4nzZH04ComfkaS98L17syUAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbUKoPYOTVB6LfjLIA64QVptyLYi9LNG5V4ALjXKSnE=;
 b=LxLENTTJrW/LV/81Bs15dxiBhhbdGmeSQgHp3YZTYS3btkCa927M1TT5EThx8zR1j+MFqsb8aEbQDR090z9szTe6/0IPIpukGzVma1pbvAO5AiOvYCST/c58P0XN5tvvjXA+rfCBGfS23AtFUUUz1UdflhVUsf35zQbOjlZu/JEQo4kgDVm0CRrZI/D8aAIORR9FaweaAOgCEdCwNm6uEOVK7eHpng+dygSo6OWhTMpvFLDZXB0DVXV8B3bebsN9i0QfuVdJhBCovbbtT7BIxYKIPTTR93GNcX0oroC0KMEi6l/fw2DQ6lNOOovK4vzt717hXZlFJ1JBg14+lZqxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbUKoPYOTVB6LfjLIA64QVptyLYi9LNG5V4ALjXKSnE=;
 b=T1+8TkvKGab80eLknkuaigJxDxEMblUQoIPjqc4V5XyLShopXYQGHDurBqEubyKfeDxjyc2qBNccwA1ivrC+MY7ZGB1aPbztrCzGWyVNjvQ3d8PGiCxv9ZW7d60M0q9WZYv8qkaCL3LB7HeU9uyXZlcQtyy35/Xwb4WXl55ynNg=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:35:48 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 12:35:48 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [Patch v1] drm/amdgpu/userq: dont use goto to jump when at end of
 function
Thread-Topic: [Patch v1] drm/amdgpu/userq: dont use goto to jump when at end
 of function
Thread-Index: AQHcu2MYwczL1CzShECBl3e0neahnbW9nqMZ
Date: Tue, 24 Mar 2026 12:35:47 +0000
Message-ID: <BL1PR12MB575358F35CCAE32F698AB0949348A@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20260324075149.622626-1-sunil.khatri@amd.com>
In-Reply-To: <20260324075149.622626-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-24T12:35:32.4378294Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|DS0PR12MB8480:EE_
x-ms-office365-filtering-correlation-id: 15e78f9c-045a-49c3-6195-08de89a1e056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021|56012099003|22082099003|7053199007|18002099003;
x-microsoft-antispam-message-info: tac0UzsQXlHhbUAw4rslIuFBxIayGsVpulExAHelMkrH1PMuYylniqRrJyn0mY+09iQCMNgRFKc95iIgncY6rrnHTOR/BGIQuVUIt0aly6cT6pRuUxJgCMoDXIbap3PQNzB15MgYsGyEk+tscLcfVCPGhWf5i1XqzXtZpEVGK1Ojcp/dVgZxMWVSOk7LM5Ejbn5WtL12FfkU2pxbwFx+uko1y0nAf73RmkWae8SBcxLyaa3VucOXQ8mtKoPUXAfqhNRwZLnZ3RC2OrUigjyTagAV8pAnxjYLKwePaVqt2Q2zMQiCGQHQzTvaeJdt59v6Hpk/RJXlB++C+lpuGAKfBLuMqnt1v5LopUHyCLd1y1dvvjCilUrpWOkZOPfcgbGcsdg4aFDoPomdeBZapTeNtTBXRpYQs/pJtFXve3+NB4puvpjfqU+tJ005FLswIr7gmihPkADaprH/Xp2ufaeQVa13lK52f271ozBTjEBi07BjKjMWHV2xqJXmjk1EKNZHtpri+rVqUTVDcNDwp0AlnFgRAxauVrEFQQMvRQslbw/540PbIssmrZdjZORgrfyrly79raOg/HmOZAZkdIlOJC/GpPPvtI+D7UaQ2SRnAG0TGtpfknOTdxf7fQ+Epj6vLizOh7LeWdbEsQWtynfuB8GDPm27R6o7LMSrJKpu0tjXfSp177ZkMgvZ54rT+qMR/wlK+yoE7836iP8IdirM81EziD27mtVWaH0PKePn+PpVTo3Ghilb6wGPdxcpv9yvcwb2eyUXWTDCi3nFuBh+zYsIBNaF3u4fY/xoDb1YdRI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HS92IaQmT2d3MiywEcgj5lY3VGjv5ExrA9VyzKMupYC68T4LU2Q0aeeFqh++?=
 =?us-ascii?Q?ZfOp2pQ3e3TJ0F2MUVgpcIyntyJXlbg5R/XIfbfFZvLVwwLLTp+lAVY6BB9U?=
 =?us-ascii?Q?15ZyHbOiGVPhSurfzyoWDv8l1BQRh3NbJK9Ayoab4XRmSpOiWDk1j7jeCZDV?=
 =?us-ascii?Q?k6yKWGJbJ4MHC724ZZM/Smfw0BxLsZsT/nsbDLnNDkCFU/bNt1nrq2N63ZBp?=
 =?us-ascii?Q?7QQzfyyIONcmSAMOebd3ptz1EOu/6pxfsRypVpiHcLz+Xyq2N/K1lauL72pU?=
 =?us-ascii?Q?bMFmEw6HeYwkQgIbM29KhTTJjHJHmzE6n2fjEl9F6Pg1OY3y+2KXFIgu6LaY?=
 =?us-ascii?Q?VR3DIlfil7V9uixk04OI8C6cQesYRPKPv1W2NHEqd+tR4s+U3z0w7Nf9uBZL?=
 =?us-ascii?Q?Emebc/+9cBe8XOKkOXLpiyZG6kkqUdxzVT0L+KC2gT/gIS8zextY4WXmiEb7?=
 =?us-ascii?Q?MBKx8c+/6Jg1CvoZDiYwrGtzsV0LAsEH9htAQK1gzatfDKSmQbRcnEJPk+vH?=
 =?us-ascii?Q?hNY7ORZ29SsqfbFFtjDci2LCNQZpiXOemk7oWrcYe9DFuEKXr6k2/TApmYhM?=
 =?us-ascii?Q?xJCVS+lcf05Du+Mt/R7kPmCLEQN3vgvJWZI05JFtcb836DsRAmtAiuylm88m?=
 =?us-ascii?Q?0qaAGmIX8tlgyu0eAnMd0ecM1OSImysh+r8Ct9qv3AkfHXVeKZz0fpqgZ4m7?=
 =?us-ascii?Q?foSycF8rO4jTNunT9oKeTWaT9jyRa0a599cy4/JOEMSCwpLz+xNd8fA1qcn0?=
 =?us-ascii?Q?Dcw+4UVrTjFChhDjV1fg1K2NsZQ8ZU5TNxTNsf4xjaku0UN7I0JOoQ2vz9aF?=
 =?us-ascii?Q?j9tT5OCMTbKSorYk7njkKojvCGmR9kLzUK0GQ8Qzhl7vpkk+zGY9MsKQe7QU?=
 =?us-ascii?Q?0Rzpd66eSXzrjXc4bseAY6fO/tXnHF+2bpzB0PeofMO6Jv08+hfNsp4sqXYJ?=
 =?us-ascii?Q?4C5f+knhdrQTvEiad6swSAWWcvFt0D8LSDAhpkAB1fPFsMxitoPmFSHFjBOc?=
 =?us-ascii?Q?/xzAgdq+MX3iaKzReWzzg+1gboGAN800wz19H1cKbDJuJbLuol4d9a5Kv57U?=
 =?us-ascii?Q?wVr8XshGctTDL2QzbPjrv4yHjfMUe1D7PZKYP4jExAjAd3FpI5FVfAoMeku7?=
 =?us-ascii?Q?/HDMTGwVLXVah003yQMxMORPIi32HCLQQSK5Sg59EA8hMbQUknH62HRutnGb?=
 =?us-ascii?Q?4+l3ndngNylOLNPCmAUtvsg2WdKJuqUpCJOxI8t2QBkvNZCUuWpwbvwzVKNr?=
 =?us-ascii?Q?2+Q2R2sOu4pbx9Sg+AQZu1ejnFF9L9Q6g503RViYMS5ybatX6tXoosmrY+W4?=
 =?us-ascii?Q?2C528S4RiNyUjfOBfUPqOhpBpcOdkTLo9aDMOr84J3zAfnXxJYJnyzQu8Rzs?=
 =?us-ascii?Q?bmABlly2y9Of+ngmqTKuhYx30R2AwSxDemHwaBGFcv/4i3/LYXbHxr5yF511?=
 =?us-ascii?Q?+NTLW+XN3HhoyNHnEZcvWsAFQK1M/GuIZY/b6jq/5ikETGkCbYenY3Gd4YuP?=
 =?us-ascii?Q?KhKG1VBrW/Vfkkff8FXPmcJP9HveEEAgBhgVwCrEBTHXQXQ79Yc8wfav14KP?=
 =?us-ascii?Q?n9XQysgQARpxVCKpaz/Jo1R8OvtVKTWYZy/ocq2QlnaO5TNrz73wZujcPhs+?=
 =?us-ascii?Q?TT26aOd0BztfiYHYiBD11ueCKDjP2Bt3j3jW21JkvjcF4KbApI3GbTkUfVpT?=
 =?us-ascii?Q?LuMDV27TGFqG2cB5MMjmcMqCJ1x5EDZdH+OFJUm198UyjO6pa8+EbaXpEXAU?=
 =?us-ascii?Q?I6snF56dbg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB575358F35CCAE32F698AB0949348ABL1PR12MB5753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e78f9c-045a-49c3-6195-08de89a1e056
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:35:47.9158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTMLPR2LBW8TcC4q3K+fQAU1fa2UEQyhA0jCpZ0KBYfXaLnNk2UJlwMiXXUmz/5rkj1d25SaDMrp91iZRwnKOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
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

--_000_BL1PR12MB575358F35CCAE32F698AB0949348ABL1PR12MB5753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ping!

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Tuesday, March 24, 2026 1:21:49 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khatri, =
Sunil <Sunil.Khatri@amd.com>
Subject: [Patch v1] drm/amdgpu/userq: dont use goto to jump when at end of =
function

In function amdgpu_userq_restore_worker we dont need to use
goto as we already in the end of function and it will exit
naturally.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c
index eb07ed078bfa..a351383b432b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1227,10 +1227,8 @@ static void amdgpu_userq_restore_worker(struct work_=
struct *work)
         }

         ret =3D amdgpu_userq_restore_all(uq_mgr);
-       if (ret) {
+       if (ret)
                 drm_file_err(uq_mgr->file, "Failed to restore all queues\n=
");
-               goto unlock;
-       }

 unlock:
         mutex_unlock(&uq_mgr->userq_mutex);
--
2.34.1


--_000_BL1PR12MB575358F35CCAE32F698AB0949348ABL1PR12MB5753namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, -apple-system, HelveticaNeue, sans-serif;=
font-size: 12pt">
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" dir=
=3D"ltr">
Ping!</div>
</div>
<div id=3D"ms-outlook-mobile-body-separator-line" style=3D"font-family: Apt=
os, -apple-system, HelveticaNeue, sans-serif;font-size: 12pt" dir=3D"auto">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" style=3D"font-family: Aptos, -apple=
-system, HelveticaNeue, sans-serif;font-size: 12pt">
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sunil Khatri &lt;suni=
l.khatri@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 24, 2026 1:21:49 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b> [Patch v1] drm/amdgpu/userq: dont use goto to jump when at =
end of function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In function amdgpu_userq_restore_worker we dont ne=
ed to use<br>
goto as we already in the end of function and it will exit<br>
naturally.<br>
<br>
Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 +---<br>
&nbsp;1 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_userq.c<br>
index eb07ed078bfa..a351383b432b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c<br>
@@ -1227,10 +1227,8 @@ static void amdgpu_userq_restore_worker(struct work_=
struct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_userq_resto=
re_all(uq_mgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_file_err(uq_mgr-&gt;file, &quot;Failed to restore=
 all queues\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto unlock;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;unlock:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;uq_mgr-&=
gt;userq_mutex);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB575358F35CCAE32F698AB0949348ABL1PR12MB5753namp_--
