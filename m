Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A267CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 17:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D3510E206;
	Tue,  4 Jan 2022 17:24:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE88610E206
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 17:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSEcFQuLAsq0MDXYVSj0pPFEP8wDp73IuSUaXc/46w86LGcl0TkzejPfhyP1/lAVdSpw5G0GOIh0jkBL/3gqOwWWuv5QWB5atderDK18m7lS+f08cJLa7qXy0NhAOvO/wM0aMcrc/S5qnJe/FHVurv6XYfkGx1enVQ/Wil+2cyLGy5t8aQb8iEO4V0O2X5aQ6CzSsuv8ZYLD0pMuuVzNQdmIJWWzk4aE5eXwA77fWrQlRFVLmv1REGoISKeNZE5PVX+ZBqC3Rk9jXTkWNSTdLy/XvkYaaLkGu97VPQj1VVhxnwRTv2cVBw8ROwNfiK5dUHtRHpAMeXNjfnRMGShUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72dorpE4SJsBeENSqMRLmhLjdnDsZNH26LEVkAltu9E=;
 b=hI+V2Mk5jWXJsyQY0XYIUvT7TBARcLyT+QgnNIdGIivVIAMH5HQUzn/O6rk5/kItANltpZciqd8InTb+Q8hkirC2xL1RBHqazcp1I/09h/Er0KneS1OLGSX0e30WJJUApa0xCzXKl+UQUK45S4jhNXR3+aMpyhj1puL+79oEWRL25qcQSTI7mvzSpfkHT9Yzy3nRARJv7yxlIcdbJKh4n9W+SBDmS7FnA2sY/yC+L+pYoHVINgGpL5t2cwP3ht8ID70ug9nAujPofNvwtQQ800PRZi7pYveF3JCbM+eYe4zJFSxB1cVbKv+EH4c2z2NSlpP7KPHD5c4S4QUYHRUK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72dorpE4SJsBeENSqMRLmhLjdnDsZNH26LEVkAltu9E=;
 b=kmT2KMlcEFB/YyFj7cAgDjjcFUPZCwkOEIBNcVphNSYpFsSYCIq974kARE6LtANc49E0otLp9tMwIdsIzxCqAaO2zU8nwmq4Usijzr2PRTwZIxz0hhjGMLsWll0LQHPFxBW7aL5RCLE0McBBmgko61yooodRrI02UUCCFpJdtgo=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 17:24:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f170:3712:b17e:bd65%8]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 17:24:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Topic: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time
Thread-Index: AQHYALX1XY5+mnZkv0+jwyBJh15KmqxTHepG
Date: Tue, 4 Jan 2022 17:24:27 +0000
Message-ID: <BL1PR12MB5144856BFAA05B8100781100F74A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220103152311.1453-1-mario.limonciello@amd.com>
 <20220103152311.1453-2-mario.limonciello@amd.com>
In-Reply-To: <20220103152311.1453-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T17:24:26.537Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: accbc3f2-e213-6048-6f4d-4d01ebe2bf2e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5e5677b-9394-4081-82e1-08d9cfa70f3e
x-ms-traffictypediagnostic: BL1PR12MB5112:EE_
x-microsoft-antispam-prvs: <BL1PR12MB51120DEBD58BAC7E93C22DA4F74A9@BL1PR12MB5112.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5a7EBkDQzZZoy0gC+2uiMhSjjLTxc6hhIMVt9GEXaGL70bpLAoWpIVVDXn0QdAiS5aLISYCduacdSwiHEy0bQejNPQuODA/hzJnVi2EJDOTvvqbBkRF97JBToMLcq+x7LeyzjmQ7CoT0MCYrIGnhNi8EcAr9dW0a6u5CAlcogAmtwCdteMDBbfA9JB9kZdUp9qM2G7YGAFSnwv7QbG4KmMJyPXO+X9MqohE/Ur7qhtosA7dQoljezRb0dZUw5hm7ocUtM1ZnO5HTZ8rtZPoCJBQg5OnbbmFCA5Bv2+7y7PoPyK9MVaA5vPlDAOVudqktT64XMOvTBFT3ctuE5mWu0RXJj+Hl0vNE1aKuZTWvsApR4CEfcyJv1/OJN7wjxS3yo6CcVl1SeM2fHoW1fdnyDitFBs+Q4Uum0gEAjr+MEwhtnjMYRxIHNhz9lVEZlaGo/S2bmY+WZxlQm/kaZzzAIlBMOH/zaKV84nuKHZauw+Ul0rMkBdO59qmuxHfnUBWM0wMRfoGHcA57pSqtRIA8lZ/nPo99eBOnl0xjx6CmglPjfGH3j5OPDVO+PbBJI38AT1BxLRDhZ54teDF1XTEj38MVMj+B7tr7Fba+i6xwWjnnX/Jgn891s/iFq6XHXpkyYYwZpN/uXSE2Cjle//7nOuP4479KlDDHAGao/T5aCBOESPXPnPdSRk155+qZQWCErN3irkbHmt4Bd2zhR1u93zU27ehx4jdkDQl7ILoQ40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(8676002)(7696005)(5660300002)(8936002)(33656002)(2906002)(66946007)(38070700005)(186003)(26005)(508600001)(83380400001)(316002)(76116006)(110136005)(55016003)(6506007)(9686003)(19627405001)(71200400001)(53546011)(64756008)(122000001)(52536014)(66446008)(86362001)(66476007)(66556008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cEQQQNsA4R1FTnmPnyxFKaNMK4FcgGKZaro6XRVw1E5p/q3dMcqBdDVSN/Tg?=
 =?us-ascii?Q?TSWpQnYGG0MKcmTx1YdQlXU/8kFtmFh1Cp/6ojyUn/0fP7VYKLPcAHC4mQgx?=
 =?us-ascii?Q?CPkpghZu3FxoFJqlt35GhjM8F9P4yClzivI76qsP+L7xe1HX2h+eiSGXM5xk?=
 =?us-ascii?Q?T8hWociE5yfPZJ10o8o+Y9teqUNlj0xe/+z8OfaSdi5jTMVAdrYi12eyDG/c?=
 =?us-ascii?Q?yNPD0Bhm4MlVi7qyXEKctFmEqYZVZ1jdRWtSJuNFyu7ctxaXxpROclJcpCLG?=
 =?us-ascii?Q?KPEPz44Ziuuwrjc1U4d4PN7lY2D3D/m51CCL3s1GjibpVbpxaPN1SofWMYtU?=
 =?us-ascii?Q?boFbsBIqnHn3fb91tK7A/bpw8/+ecfX9AOiwjNmFU/NYqHutmEklMzqMK4Fu?=
 =?us-ascii?Q?TeEkXDDmeR7KNVj9cNQKQJiBSB7zzcjxA7/nIR5fVUkWOLTQshSnMa2bC+YF?=
 =?us-ascii?Q?MVkTMA5aAJJxl+NLGbMt/Ik+fsXHxExACgWq9NQYXx3LmKOMMtjU0/kRk1q2?=
 =?us-ascii?Q?pF0WqUGFdD4+MijxupflBIhl1ky3UiG3KomuWZciDlIix5Q6U1T6UTRngBqH?=
 =?us-ascii?Q?UdvtBoRfuegzRVSsjzd8QgzZ12Ckc4A3Zq9yPLnGvyD3F8DT8crgrDSIau3B?=
 =?us-ascii?Q?O1dAiuWQW0Q6n3KOJKI2nsTyMrtVaxyRmGIcONETjTixE9Lg7+9hkdtwJzqY?=
 =?us-ascii?Q?SareH1jRK20x5Ta/c2ixmb1tT3KCOegIm+ITilMefqBHYlpzqObfT7v8NUJ4?=
 =?us-ascii?Q?eJe9tiz3v93o4UmMZKXj6GnQ23/UbVbdsXRTUlHvAKaYpzhcY/Yi5uQrSo8M?=
 =?us-ascii?Q?rZiwbKFTpsbtJKVzlJ2FMirrhApfRfHfjuEz4Sm5tN5G1A5U1e3Fgn7c9WIp?=
 =?us-ascii?Q?H1JfhNcWNKZSJFX6/3hKDrpQWQTMz5ADaZ9Ahhy2JVAC+UxHV+3Yf55rXOQ6?=
 =?us-ascii?Q?78woPmhJS5tEdhImuONkqieY9QhzKvbgLEsau4b3Lrm7ybFrqyd8QuKo68Jr?=
 =?us-ascii?Q?8/Cd1XrvDAswuZssCzbG2tCt1fC9yh6bSvVVnOnCcsLyaxL/sNFIM2LGVl3U?=
 =?us-ascii?Q?woHym6B/TbSaRdTHp/KiQRy5HvEjNkPwM+uhI8icusHd2Gt6BNHq0YF2vy/z?=
 =?us-ascii?Q?pQx1XQ0YiQ/MELKKD3OJOtoZsVaXLaTX5TGJwDO/vxp6ayMAFKbeACesSEw0?=
 =?us-ascii?Q?+63erPQl9jOWaY+b1kHItSoqhwfNeVmkYh+1I7XzOpV3nDf5pfuEwxiXpKk7?=
 =?us-ascii?Q?BMflWn42jF5jvXa5m6fxOGDZN4bh8dq0b6S+HQpdXbUByAYRO4i7E8XLzjpq?=
 =?us-ascii?Q?1NL+91bm8UP1mkhZ1q8DAteNTUcAppAYP71eT8BHGTaLvNmYgMuV4/DzyBcA?=
 =?us-ascii?Q?hiiCJxALRCfX28BmQap5uEcJGeukiIpcDnZKZpcZW+l3zH02Icqq+AlP3NxT?=
 =?us-ascii?Q?yYHa3kyQc26ZgQ88v92Iz7t+MZfxQi/9LBIqEPvhoS/aqcYWWFE/6gfqAQZ1?=
 =?us-ascii?Q?aoB5pSKQb5hAUzqz8xYgzCQiz3HWUB1vAa/fJb/SF1BJyGPE6wu1Cw3r2KOt?=
 =?us-ascii?Q?XB0noQLG5daTEO0vXXrn53HU509Hlr+eWtlxoAzSwX9k3yuvLwhSnw5bvu9O?=
 =?us-ascii?Q?K5Sm5RbCcnlNZkl0DXjeld4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144856BFAA05B8100781100F74A9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e5677b-9394-4081-82e1-08d9cfa70f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 17:24:27.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YJ0VlAOi/RmDizYdzA4pWLoxgnDWaZsVlbkF/+1unTMKQy44HqwrrzK27gYz71HLZ/7/xCZAtANi2OIzBCaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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

--_000_BL1PR12MB5144856BFAA05B8100781100F74A9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

I don't think this will work properly.  The in_s3 flag was mainly for runti=
me pm vs system suspend.  I'm not sure if in_s0ix is properly handled every=
where we check in_s3.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Monday, January 3, 2022 10:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same time

This makes it clearer which codepaths are in use specifically in
one state or the other.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index db2a9dfd5918..413fecc89e6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)

         if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D true;
-       adev->in_s3 =3D true;
+       else
+               adev->in_s3 =3D true;
         r =3D amdgpu_device_suspend(drm_dev, true);
-       adev->in_s3 =3D false;
         if (r)
                 return r;
         if (!adev->in_s0ix)
@@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)
         r =3D amdgpu_device_resume(drm_dev, true);
         if (amdgpu_acpi_is_s0ix_active(adev))
                 adev->in_s0ix =3D false;
+       else
+               adev->in_s3 =3D false;
         return r;
 }

--
2.25.1


--_000_BL1PR12MB5144856BFAA05B8100781100F74A9BL1PR12MB5144namp_
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
I don't think this will work properly.&nbsp; The in_s3 flag was mainly for =
runtime pm vs system suspend.&nbsp; I'm not sure if in_s0ix is properly han=
dled everywhere we check in_s3.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, January 3, 2022 10:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: don't set s3 and s0ix at the same t=
ime</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This makes it clearer which codepaths are in use s=
pecifically in<br>
one state or the other.<br>
<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--<br>
&nbsp;1 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index db2a9dfd5918..413fecc89e6c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2165,9 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_ac=
tive(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;in_s3 =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_suspen=
d(drm_dev, true);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s3 =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;in_s0ix)<br>
@@ -2188,6 +2188,8 @@ static int amdgpu_pmops_resume(struct device *dev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_resume=
(drm_dev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_ac=
tive(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;in_s0ix =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;in_s3 =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144856BFAA05B8100781100F74A9BL1PR12MB5144namp_--
