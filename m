Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F1EEA8550
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CF110E67B;
	Tue, 10 Mar 2026 08:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="fYIU2BYr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azolkn19010091.outbound.protection.outlook.com [52.103.10.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB3110E1D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 20:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAsRJRKylG2PUJebl0rNGBe+Vme6AMUh/O/2E/bQ/TfZqPn/L1te4DxS4O55sCDqLFtrFdt+2KbShirgDSSv9z5lBQQguH9EYuq8UOypjaPZYABCXvYwkAZ0LCqOUvtW8s/beWmUoRi00rtZVwteVUAgCvnSAiCKI0M4WCBIoLwb36pPY/FPE3IGcNym0BnwKvT0UIyzz1vJoIqcNtWU6smEWpxFqKsxSs8cNIdIJMdRHU+OOusVDF8IfI07U9/Mud3R4cDRoBjbSiPdpSwZAchgnwKMFqosc3F6JePuksA33EqeQdkTa/OEApH94XWRIt4wA5lAkxojKOkATCVfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAOmmqbUvVq1p7qqYuTytB9KU4w4h13I1hmDidjxOZE=;
 b=HXBCXjesj+OKaulbLjkZ0Sh/gk+8V7MKwyldfPJ4vRMW9Mbpy1ctrMKShAfBMVSMGw3b3a1B/ME5KxLzOkVThs6aFP2/SP6ex4yxrJ9Qu+Y9vYNEumba53uvPobUXlk1KUG1yY+d84oS/xzuRsriGaS0BEySdvunZL/luFNuK68zEVp48nwqokWW92wSCW2kDQ16H4sSQgdXFsO/KCCqBAY1AntA1zI47welEEa2Ma5j0M+dUCKlGSQaUNE5pU8xUydp106l+byJXSw32O4H3aKbp6v8YJGTPZTg1vFTeatmaYc3i/H5riTPGa18h2DaNrqP02KNAYKP8gyb6VDAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAOmmqbUvVq1p7qqYuTytB9KU4w4h13I1hmDidjxOZE=;
 b=fYIU2BYrDsCSECi63Kk3LBG8q0+c6iYrRnB/aFZ+AqCQaN35WxQMmRUXmUplM9HA+JEpOUnoAPvvnYvPz63/FqjL3cMnm8V+cVgFn9ozd7Em21PRbEMVmERcMD+Sa4+0MatebtIdA3JrGLgd7PCtNbZ643VSb5xm/pu1O0ed9fNAscXi2mSktOAH3Hx2KT8i+fTuSHQNcBCyobVlOWuZI5lORxgKYuW1/cYWnPyEy+lbbIVNisFMAcItz1xmOtKtJqCbwOTvSroNZvrnGKnYfIL1XAQfd6BeWIvnMwej7N3cPFa4Pj43C5imGXyOQGalaBcVhK99GlbOk7b89r5bag==
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com (2603:10d6:103:180::10)
 by SCYPR80MB7315.lamprd80.prod.outlook.com (2603:10d6:300:ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 20:43:08 +0000
Received: from CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d]) by CPUPR80MB6583.lamprd80.prod.outlook.com
 ([fe80::26cd:a90b:7748:403d%4]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 20:43:08 +0000
From: Danilo Machado <danilomachado2002@hotmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>
Subject: =?Windows-1252?Q?[BUG_REPORT]_AMD_Radeon_R9_380_(Tonga)_=96_HDMI_no_signa?=
 =?Windows-1252?Q?l_after_suspend_(possible_EDID_regression_since_kernel_6?=
 =?Windows-1252?Q?.13)?=
Thread-Topic: =?Windows-1252?Q?[BUG_REPORT]_AMD_Radeon_R9_380_(Tonga)_=96_HDMI_no_signa?=
 =?Windows-1252?Q?l_after_suspend_(possible_EDID_regression_since_kernel_6?=
 =?Windows-1252?Q?.13)?=
Thread-Index: AQHcsAT2TFlhLxdclkaBecssHohRHg==
Date: Mon, 9 Mar 2026 20:43:07 +0000
Message-ID: <CPUPR80MB6583D407EA175269FE066E77A379A@CPUPR80MB6583.lamprd80.prod.outlook.com>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CPUPR80MB6583:EE_|SCYPR80MB7315:EE_
x-ms-office365-filtering-correlation-id: c898570e-4948-4183-98b4-08de7e1c788d
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|22091999003|25031999004|24121999003|41001999006|8060799015|8062599012|31061999003|12050799012|39105399006|15080799012|19110799012|15030799006|20031999003|9400799043|55001999003|40105399003|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info: =?Windows-1252?Q?Jrx6ocuFAORFVok0V+GtfAWK3aKEwuvY+m1b3aVmSSibzD5sEqxQgS1U?=
 =?Windows-1252?Q?VvPxGEF2tF3RjaDcMvqCf4dN6gpCg70nUHtV13llgtjtb8iTLdsuqxkW?=
 =?Windows-1252?Q?w4JKKjzSk/ntEW1W2ctMi9WpJjV0mgiOjt72pw8TIlLjkQUF3KiD0KJZ?=
 =?Windows-1252?Q?A7c3tYM8YLFrThUL/4zLd6BpMjwSIdpKgAcXNFr6A5ifD3SbqW1BpYe2?=
 =?Windows-1252?Q?ZGXg/nS+ORRAHqy1fZ+nLJOLgphG4Zcth1RNnPi+q9sxt6UOm+jXcsqS?=
 =?Windows-1252?Q?j3cjZmQ75GitYmHN5hG7rCp4K6iJydzjXESn5v8mlHAYw8TE2r93348S?=
 =?Windows-1252?Q?l98c315dJdPyfpvtAcFLZk+xU/+J0jBhZCMYtHIchoqplw5boWxt6oHn?=
 =?Windows-1252?Q?qSmIrh920kd2YAGKdk+6OXAKhhY/GyvFAGnvFVktHbKpJHhlGxZDwZdh?=
 =?Windows-1252?Q?aSzw/PWoz6EQ2z0DfRUUIbe/xRjS6AII4ioeKnxDbPny4F0HFIHWWWF5?=
 =?Windows-1252?Q?6C/EbVfzpYZETHvSFnOKPoht3UWLTz+1WIb0AEc7Ka5QFRqG4V5e2z16?=
 =?Windows-1252?Q?JobcyWR3Z/DY9z3THztzVPDHdicJ5JhMnIAiYH/QKgeenOVdKDhE6igz?=
 =?Windows-1252?Q?D38qNDYMCkeRLXwiHktDEbetbFAMtndY/cXyntxMY0WaJNAdu0rHxR1x?=
 =?Windows-1252?Q?3BArwiZ3qntNy6CiAWELK6OUFAfCItbFMunWR9F/oST9qaDM1ItT4GGO?=
 =?Windows-1252?Q?3LpruOqTh1nngqkuVi4aa5fBq4CqGbr6cl97zSD1xW/n2DqXotz+Fmjc?=
 =?Windows-1252?Q?4VaEguaY+HKQrd0gsROkg2qWYWiEVVlJZk45ft5y8FcF4/zqmkyAD4VZ?=
 =?Windows-1252?Q?04KDUoAui+71DFS0hkuT0ySQVzmb8l1HzjNhHDcP4nAh8OPjoOMGKJ4E?=
 =?Windows-1252?Q?JreJe07C19pgBFSn8EnSDxyW9NkZ3+KoxpGnL47laLpD9dXlFOcwIVyl?=
 =?Windows-1252?Q?fbf64fTXJE9119rKOwJXwgTT0LCaIUH7Pu+aRp+zBmjXxRce+PkWQYXH?=
 =?Windows-1252?Q?Ita9c4x4U+qwAUVBvI/bkvT2XnpjhadDOU7Gs07kbXyLxXZTK53DZJJc?=
 =?Windows-1252?Q?BhbXACTt4CUmwrs1RppUL/CBkWW92PS3GmngiIO0gdV4gvMkGw/WTZwz?=
 =?Windows-1252?Q?q6p9XUE/s4tnp/D+ZncNeaTh2nNZpQIZg89IH1wE1PKInx0l4ZozoBQ1?=
 =?Windows-1252?Q?u14bdPghBZy1USeekxQ9YmN2VrTe6BCFNMocE6oYaiHVYdmbOj+Zx5q7?=
 =?Windows-1252?Q?FmKk5w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?inNxjKIxMHyp8H9mrv6Zt7RqIETFWK2Xu3FRRapWBCrYDAndO62bZl6q?=
 =?Windows-1252?Q?zYkK9+CzrPP5RGcSKa+Xjhq+EunM3nky21u/Zpn58JotEO23e8itl8Rr?=
 =?Windows-1252?Q?zupwBUdZkVyIy1g5lTrV/P3MoAbtDgljFcYg/Vnvcm4dZqC8/P3kMgrF?=
 =?Windows-1252?Q?SWGaMxsHdAL5xGTyq8RDLDJISmqdsG8SL4qFfJZV8Bm5KKK8pa3JwRNo?=
 =?Windows-1252?Q?pqBVlqXVF3gfvF43rFF8vK4gJA0m34tQbhZwABSSNoOjINf96ThAzM3O?=
 =?Windows-1252?Q?vUyzybkTeSdFN/DNvzuY6F5T8zQ9OLcfgCzjibqjSUP6FyxNepOjTy0k?=
 =?Windows-1252?Q?lZPzzlSS3lbAHI6TPTQ2TBYu8r8DnjKdffdeVognv5Yd/eNZRqyzMI6i?=
 =?Windows-1252?Q?Z42WVTDiyEldfAWjtUFT8ayx+AgV7fwCfdLM+EaXsyRzDR3lLs2fsr9s?=
 =?Windows-1252?Q?Xxam+HdBcEiIDdCecPhBqxh33kNlVBfZTq8tkm6L8LiA6KlftAxpBxLh?=
 =?Windows-1252?Q?KhaXWhC0MkSbGgExOUfI3n5rcUjCTxU+1oLso2U/HWbs2CiM2AO8Q8f7?=
 =?Windows-1252?Q?viLGL4dz9m+hLxE0aLgFdCcP1S+xIKTP9OKfVOclYziCSB8SLBULET2u?=
 =?Windows-1252?Q?RCtqEeZam+ZoBuGztoS1ZSHacG8RfwAoURcTMZWFB0/1LqP2ZBUfuxA5?=
 =?Windows-1252?Q?hLW3hembAPB7KGJX1m5/a7GCyBb/SOxTE6JIR+u1VI7T9L3G/XDf2qIU?=
 =?Windows-1252?Q?eTIVstMXxs1wYV6DhQb6dfe3t9SGp2vbfmbhDprH0FJXr+SymDfAQh6c?=
 =?Windows-1252?Q?e3inX4pTEcLdSG2UaN42vG3M/SwvBLJeDYaLCrppNfr2AGbab1i2D8NZ?=
 =?Windows-1252?Q?D+ijCqpdh4gmZl11SX0y0r/Duwm4h3GIdD9Mv+DRXv0mG0NyypVik3Ir?=
 =?Windows-1252?Q?/QkXQwriCWANZQVnO3ABo8bqlhq+S51FRChii8jM/8ouNJleb3N209mL?=
 =?Windows-1252?Q?h+hQ2hRB4TS2qKFj/KrUdPBMxLZq4cUDis8aFvvYATCzqFr+fp9BgFW7?=
 =?Windows-1252?Q?tCwH4PGauGV69IaNKDK9eJCCi8J9LPJqTVDC4eX1loa/ol5I1YHJ72rr?=
 =?Windows-1252?Q?AvxEvSOV29M6v9K5giaoQjTnS5Sspwz3L+MdRoM8AhrgaNtn934WZJ6L?=
 =?Windows-1252?Q?tdGERvIa8lCl8EZ3obtWbPOZ65EurqtOpi5hs0sw+wcxjGiEtVO4/IDM?=
 =?Windows-1252?Q?beUQChRl61BAnVWR/ccowE70wG/ZZdXqW0ElnbaPwlt6R3K+BzR3KhuD?=
 =?Windows-1252?Q?3KPKTSgH2pJtVyiSccInosouURg8x2kSXUWcJcJfUvS8yvo3NRpuixuU?=
 =?Windows-1252?Q?07EyVodS3YrOFFvHI2QKyKBllRKXHSNEtPtUCErWewbYNZuYHj4xXVNQ?=
 =?Windows-1252?Q?ivQmxCU+cfgDgINT3U4LVZvKD6a0Tmyl2yFhLNZl8CGM7xwBuKWEpUhc?=
 =?Windows-1252?Q?/B89TCbCk50dkajc3MIBJMerrtE0sbBYMNfseutJUJnTYaiGT15ub+wY?=
 =?Windows-1252?Q?L4Gys0b6lIvDsgLjkQRfn7a6xltR8SVSFvYu9Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CPUPR80MB6583D407EA175269FE066E77A379ACPUPR80MB6583lamp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-665fe.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CPUPR80MB6583.lamprd80.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c898570e-4948-4183-98b4-08de7e1c788d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 20:43:07.9591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCYPR80MB7315
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:25:11 +0000
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

--_000_CPUPR80MB6583D407EA175269FE066E77A379ACPUPR80MB6583lamp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,
I am reporting a regression affecting my AMD Radeon R9 380 (Tonga / GCN 1.2=
) related to HDMI output after system suspend. I am sharing detailed observ=
ations in case they help identify the cause.
This issue has also been reported in the Ubuntu bug tracker:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
________________________________
System information
GPU: AMD Radeon R9 380 (Tonga / GCN 1.2)
CPU: AMD Ryzen 5 5500
Motherboard: Gigabyte B450 AORUS PRO WIFI
Connection: HDMI directly to monitor
Distribution: Zorin OS 18 (Ubuntu-based)
Desktop environments tested: GNOME (Wayland and X11 sessions)
________________________________
Summary of the issue
Since kernel 6.13, my system occasionally resumes from suspend with no HDMI=
 signal.
The system itself resumes normally, but the monitor remains black and repor=
ts no input signal.
This behavior appears related to a failure in EDID detection or HDMI link r=
einitialization after suspend.
Kernel 6.12 and earlier do not show this behavior.
________________________________
Kernel behavior comparison
Kernel 6.12.x
Stable operation
Suspend and resume work correctly
HDMI output always restored
Kernel 6.13.x and newer
Regression observed
After suspend, the system resumes but HDMI signal is sometimes not restored
________________________________
Relevant kernel log excerpt
During resume when the issue occurs, the following messages appear in dmesg=
:
[drm] ERROR HDMI-A-1: probed a monitor but no|invalid EDID
amdgpu 0000:0b:00.0: amdgpu: failed to read EDID from connector HDMI-A-1
amdgpu 0000:0b:00.0: amdgpu: link training failed during resume
These messages suggest that EDID detection or HDMI link reinitialization ma=
y be failing during the resume sequence.
The complete logs and additional system information are available in the La=
unchpad bug report linked above.
________________________________
Wayland vs X11 behavior
I also tested different display sessions to help isolate the issue.
Wayland session:
Suspend and resume work reliably in my tests. The monitor wakes normally an=
d HDMI output is restored.
X11 session:
Short suspend cycles usually resume correctly. However, after longer suspen=
d periods (approximately 10=9615 minutes or more), the system resumes but t=
he monitor receives no signal.
The system itself continues running normally in the background.
This suggests that the issue may involve display reinitialization during de=
eper power-state transitions or differences in display management between W=
ayland compositors and the X11 stack.
________________________________
Troubleshooting attempts
Before reporting this bug, I performed several tests and troubleshooting st=
eps:
=95 Tested multiple kernel versions
=95 Confirmed stable behavior with kernel 6.12
=95 Reproduced the issue with newer kernels
=95 Tested both Wayland and X11 sessions
=95 Verified HDMI cable and monitor behavior
=95 Compared suspend durations to identify patterns
=95 Collected logs and monitored dmesg output
Because kernel 6.12 remains stable on this system, I have temporarily staye=
d on the LTS kernel (6.8 series) to maintain reliability.
________________________________
Background
I was previously a long-time Windows user (from Windows XP through Windows =
11), but I recently migrated fully to Linux and do not plan to return to Wi=
ndows.
My goal is to maintain a stable Linux system and eventually upgrade to newe=
r kernels once this regression is fully resolved.
I appreciate the work of the kernel and AMDGPU developers and hope this rep=
ort helps identify the issue.
If additional logs, kernel parameters, or test kernels would be helpful, I =
would be glad to assist with further testing.
Best regards,
Danilo Machado


--_000_CPUPR80MB6583D407EA175269FE066E77A379ACPUPR80MB6583lamp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Hello,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
I am reporting a regression affecting my AMD Radeon R9 380 (Tonga / GCN 1.2=
) related to HDMI output after system suspend. I am sharing detailed observ=
ations in case they help identify the cause.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
This issue has also been reported in the Ubuntu bug tracker:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
<a class=3D"OWAAutoLink" id=3D"OWAe8ad875d-e42d-f11e-cb62-87fa87e7cbed" hre=
f=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389">https://=
bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389</a></div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
System information</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
GPU: AMD Radeon R9 380 (Tonga / GCN 1.2)<br>
CPU: AMD Ryzen 5 5500<br>
Motherboard: Gigabyte B450 AORUS PRO WIFI<br>
Connection: HDMI directly to monitor<br>
Distribution: Zorin OS 18 (Ubuntu-based)<br>
Desktop environments tested: GNOME (Wayland and X11 sessions)</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Summary of the issue</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Since kernel 6.13, my system occasionally resumes from suspend with no HDMI=
 signal.<br>
The system itself resumes normally, but the monitor remains black and repor=
ts no input signal.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
This behavior appears related to a failure in EDID detection or HDMI link r=
einitialization after suspend.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Kernel 6.12 and earlier do not show this behavior.</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Kernel behavior comparison</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Kernel 6.12.x<br>
Stable operation<br>
Suspend and resume work correctly<br>
HDMI output always restored</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Kernel 6.13.x and newer<br>
Regression observed<br>
After suspend, the system resumes but HDMI signal is sometimes not restored=
</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Relevant kernel log excerpt</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
During resume when the issue occurs, the following messages appear in dmesg=
:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
[drm] ERROR HDMI-A-1: probed a monitor but no|invalid EDID<br>
amdgpu 0000:0b:00.0: amdgpu: failed to read EDID from connector HDMI-A-1<br=
>
amdgpu 0000:0b:00.0: amdgpu: link training failed during resume</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
These messages suggest that EDID detection or HDMI link reinitialization ma=
y be failing during the resume sequence.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
The complete logs and additional system information are available in the La=
unchpad bug report linked above.</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Wayland vs X11 behavior</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
I also tested different display sessions to help isolate the issue.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Wayland session:<br>
Suspend and resume work reliably in my tests. The monitor wakes normally an=
d HDMI output is restored.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
X11 session:<br>
Short suspend cycles usually resume correctly. However, after longer suspen=
d periods (approximately 10=9615 minutes or more), the system resumes but t=
he monitor receives no signal.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
The system itself continues running normally in the background.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
This suggests that the issue may involve display reinitialization during de=
eper power-state transitions or differences in display management between W=
ayland compositors and the X11 stack.</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Troubleshooting attempts</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Before reporting this bug, I performed several tests and troubleshooting st=
eps:</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
=95 Tested multiple kernel versions<br>
=95 Confirmed stable behavior with kernel 6.12<br>
=95 Reproduced the issue with newer kernels<br>
=95 Tested both Wayland and X11 sessions<br>
=95 Verified HDMI cable and monitor behavior<br>
=95 Compared suspend durations to identify patterns<br>
=95 Collected logs and monitored dmesg output</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Because kernel 6.12 remains stable on this system, I have temporarily staye=
d on the LTS kernel (6.8 series) to maintain reliability.</div>
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Background</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
I was previously a long-time Windows user (from Windows XP through Windows =
11), but I recently migrated fully to Linux and do not plan to return to Wi=
ndows.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
My goal is to maintain a stable Linux system and eventually upgrade to newe=
r kernels once this regression is fully resolved.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
I appreciate the work of the kernel and AMDGPU developers and hope this rep=
ort helps identify the issue.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
If additional logs, kernel parameters, or test kernels would be helpful, I =
would be glad to assist with further testing.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Best regards,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
Danilo Machado</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_CPUPR80MB6583D407EA175269FE066E77A379ACPUPR80MB6583lamp_--
