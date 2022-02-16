Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3967C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 22:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7474610E4C5;
	Wed, 16 Feb 2022 22:21:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8649C10E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 22:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZqnJJvhKpbGlO1uleKes57RM26E00r/EtSnCURtAoqGnZE8rQkCilylQ0IH5qxUIHgcJbt/2/Fdd5glU5QKmwqS7E4dcUI6xzQeN9J1LJQdTraWEo+L02ez1xZO6KgPD1T2eQS056FcCJ89WdQpg7LqxCChfjlH0qNqmUoBNZlehIE/EqYp/oAms1A4Xl3OkmpH5UdosFmNghRbdH5VXLZU5f81xPTK81WXkPbTEkX67QVCeEaLd+1x8DuVt7HERG7SHk6eUY0UNPOYUxgEJAxTV/EjWDjeD1UZ0nFNW2AHjsbJu4E8Ds18o9u/lwIOzzKkOCk1dGgeRuv7bw2TLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOugQd8CXnVgZ+zrcXxZA9tv4z9zIeCl5eUNivTTWsw=;
 b=ZXvXqMtwW8RefNaIFFU4TH+axPLtL/UWBpl9qWLskp2An9E0gJP4Ddm9La+bZMHx1oLSaq/z0E7P7Jg+J++JXKOcq2PtR+PduHyVPGrnlkzqYT6m8zia2gtfBUuxjma9NDK/uJ+O89f1Vby9jKnEXJ+RHkBWIHjmOn/KkdHfaZwimxgWc652QBEvv1C7Pa/C3NGw5uvsA2wwsTV5gjT5zpFYigoF4S4wB1AEE3h3xdCnO2ULlBY/xkHttNf/t66KP9jwuPn8TouDm2ePqUSFlrJ4kaYWOSPTC9U3nPJG9B7qmTXJY/1Fsst/e1oYdWnmjm6ljnOxpC+xj7vtoAkxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOugQd8CXnVgZ+zrcXxZA9tv4z9zIeCl5eUNivTTWsw=;
 b=nSW13PlC9XzwNFiC8ymfB3eOLW6n4ohFBirCD6Lyk8zXQCpEckv01PwBxHfyvsgszzO+dm3fuZkGReK6cbAxTpVWQU7rHIMvmQeVJ4AoRZ06g+tahNbSMX2kLLlGYQ+NdNgkTHAMWLgXNtlZmHRAuLR5IA5JYxpLps0fsrwGOJI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MWHPR12MB1277.namprd12.prod.outlook.com (2603:10b6:300:f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 22:21:03 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2877:73e4:31e7:cecf%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 22:21:03 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix ARM compilation warning
Thread-Topic: [PATCH] drm/amdgpu: Fix ARM compilation warning
Thread-Index: AQHYI4HTtm4bJGZhwke/BGmNWiP386yWv9ZE
Date: Wed, 16 Feb 2022 22:21:03 +0000
Message-ID: <BL1PR12MB5144244E34396AAB7E07CAC0F7359@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <202202160733.1Egjqp9Y-lkp@intel.com>
 <20220216220853.59961-1-luben.tuikov@amd.com>
In-Reply-To: <20220216220853.59961-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-16T22:21:02.667Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 14ab4264-3068-ddcd-6eca-8817d6c18f0a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47e0bb1-686d-47f0-8ad3-08d9f19a9e5a
x-ms-traffictypediagnostic: MWHPR12MB1277:EE_
x-microsoft-antispam-prvs: <MWHPR12MB127707A69480AAC899C23BB7F7359@MWHPR12MB1277.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:41;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nRpgS9Yh6nuBU+0NG20Vx0ClI1MLmLFoEEOmxLTGjuM6Ab+RMiq1BLKJ/54f3jzkdJmRCBrz0TUcuaa0jm7MpR5d8sKWGlDI4TsGFMZAfoSsjNq/tzNjXL7UoRWBU2HnxUaYXroLngiVn720KYUzlFuoucuyOUfYCsXDFJuhvRoB0Ixosu6XOTfOlnpmsdpzf56LrTwwCmWA2GV1rRfCY9FGF54cRkEP3bKe+z31wjCXc0CQqUstOoFuuEXMngqO1UGYqdjPTIrf3NTaNwTx2oGzOuZ795Gcsx2NZ0OT2thJIGgXU8rv3TSE7m3TTL/V65imxsnhw6si27I9gMK20J/p3FCcfP0p7LX6v65+QVAFK7kQfvRghPQeiP5NHZ9I4paAfTqHAa6hChYZsp/cjC3qpXMGE8HHuRRH+Ov2Tr3PVv7ZnQvtGtrn6xw9FXZwaXUHJC3l4pZWo93JVSVghErgEEIIYleZL2T1VLREvMmEmd/omLZtoXPQfM5QxuPrIQp3SZ3ECWkCiEZTcwifb/mvZylOOJ5OsgfS+28v+NFiDCpERNGhP6RsAByR3pPZKEoSUB+4oPn0SSAAnGAS2yTPbmmnfxLqEeI6mpQiGy+fNhUAsnv1+jsVLyaf8McTX/PrLffKVjeRcxPd1DQeUFJc7HfPowScx+Lbu6Bj4JZE0RZRXe54i99Tvs8O7dKq9n0D5no2YzeGuYsitSTh0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(83380400001)(9686003)(186003)(8936002)(38100700002)(508600001)(122000001)(53546011)(71200400001)(4326008)(66476007)(66446008)(54906003)(5660300002)(64756008)(38070700005)(66556008)(52536014)(55016003)(110136005)(2906002)(19627405001)(86362001)(6506007)(76116006)(7696005)(66946007)(8676002)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e199PgnqlLCQMZ9uYHdAfSvCDqCq7/oeIQwz9oF5sahRPDwq7HA/FMN0O32Y?=
 =?us-ascii?Q?Rg9KJ/Fj7tvx53qXP9WRt+LIwlpzPnegSXY4GLqffXEfNl6wtfporifc0Esz?=
 =?us-ascii?Q?Evo7mK66bliETPzgZs6X2zMvM+ykSOCPwaJU0rwqj+pTVdii7ssfL1E9ry+x?=
 =?us-ascii?Q?N29vhFGlzD2bSxruG/cHlW9UA86PCiktMk71s1KwRh0ZKqPgWXBBGu1012iQ?=
 =?us-ascii?Q?hfzKlLGu1HyHG1bjofbWH2DIc3vb5OZhWuVzocoYJKZSOMM/AJfcdpte6LMS?=
 =?us-ascii?Q?IHj2wVSknWxFmBp4D1ShuKJtjPPkfIEGPxq8ydpoKJM0sgGB3doT3OjUF/Hb?=
 =?us-ascii?Q?6kyLPfziWsVmOZYA7kymHm4R5RfFw4wGySL6Z9TU9juVSIBLSCXviDK4Gnfe?=
 =?us-ascii?Q?zD1wgPvD50LsbtBLf5mE1EEADYg413X+Gu9XyBTxRKmXPXqP5+n8acU205Eg?=
 =?us-ascii?Q?uTvNZNFUGFcIkNbJ6vCKFW5VJF4kWJHWsMXnYwzS88Y9aJppZeGCxbfDuU85?=
 =?us-ascii?Q?SlRP2S13piakBeXQUvuis0HGPV4L1hDN97fPivahVfgwsggdDtfc9AwIvIMA?=
 =?us-ascii?Q?3D1ZjvkaJWA88fIOznx8hzYGaMSzhNAPRa6GFHBi6+02J0xAcgDQJ7Uhqhf0?=
 =?us-ascii?Q?c4I51qKgerfmtVhhXw/DeuWmE8psqucoSwkm/P/wvongc4zrWk5z6UzCufdB?=
 =?us-ascii?Q?2UrBhigjPvBBcsTH19n7n9Q8xjKoH3BMZybx2IqnkCVVZc4urSwGMautFSuP?=
 =?us-ascii?Q?EZ3MMuKpI8acRSOvnCmtTdo8KBFVcrRZwje0kofu80Td3msnBqNKYUg8uPaL?=
 =?us-ascii?Q?Fp5b1X/R/lG7Lh6i2H3qCq4G2OHWGXI0U30i109hlLVq9b5nE1HH8UNVyytL?=
 =?us-ascii?Q?eJXxkz6BfCTYUxg43x/pX6Diyii32sLDoFUAdRCVTKulzinSuN+hZgJeWchw?=
 =?us-ascii?Q?HsHV3S2pXgx6HYM41HWNkQIjppN46l4ZTrZOk/J/QODJpUyeqQMOQiZF3Bkt?=
 =?us-ascii?Q?VOSkjLYDLKPK8Qn3z2gYhHtRU5oODEK1qKRbcpQytSkxvgEf3ri/liq7y1b2?=
 =?us-ascii?Q?VEXPcJQTd5UOgaFg49uAMOTBubCNqpbPpxXLH+Su3CVhR7O6HKAv265bHhT4?=
 =?us-ascii?Q?DvQdmGEV9OeS/Lvus+Yf/qblJWEN6b1U8virktrqZGwqwPwf/Ha6jDLFAkxg?=
 =?us-ascii?Q?v/Os61UPtLtrXo5hR8wliD5Weu1qS1iVE0ODmgjueZLEtBTn3MDu/MLlOSDD?=
 =?us-ascii?Q?ksIMNGMJgskNOhf6/BRSEuBaz+DWqWO6S1809UUbqYn27Gp/7uwjNYprr79f?=
 =?us-ascii?Q?8iYd8atGbnv2Xk7Mg8FIXlq7BCRGf1kZbNybNpmrDu/PxcSBWtJyhUKos89i?=
 =?us-ascii?Q?EQXz+CozSHIXnqEqtbAJinb05vR9U04Qwdz5MLWwWHN4J4kXL5gAUjX3Tufq?=
 =?us-ascii?Q?KyfMwGnaUzs156A4hLwh86WDVJprpfkIr01FidJHPy6MIwyoS1Enus3PCrjq?=
 =?us-ascii?Q?93uq3E1//egj579MsfUVqlktlFc3/Pfz8jijtSKJIKtBihSGC9ORKT0WTdLM?=
 =?us-ascii?Q?oJALBl6QkBqffgOc9lf2LjBR01Q6LLTRD/tdqgrZpdYzK5OE0jL+yRPmCV1G?=
 =?us-ascii?Q?LAaAEUJFGvQJvf7JRbfHnqA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144244E34396AAB7E07CAC0F7359BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47e0bb1-686d-47f0-8ad3-08d9f19a9e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 22:21:03.2690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TULWl6lFzZALMfIB/GGJxbbaZFhTpF3zob0cuMtyCnrnBrMHDJv1BIaXvnt3bwO4dFBdJMMYI6iMBgie+tD+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
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
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144244E34396AAB7E07CAC0F7359BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.co>
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, February 16, 2022 5:08 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; kbuild-all@lists.01.org <kbuild-all@lists.01.org>; linux-ker=
nel@vger.kernel.org <linux-kernel@vger.kernel.org>; kernel test robot <lkp@=
intel.com>
Subject: [PATCH] drm/amdgpu: Fix ARM compilation warning

Fix this ARM warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'
expects argument of type 'long int', but argument 4 has type 'size_t' {aka
'unsigned int'} [-Wformat=3D]

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: kbuild-all@lists.01.org
Cc: linux-kernel@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7e60fbfbdc10a0 ("drm/amdgpu: Show IP discovery in sysfs")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index ad2355b0037f52..6c3a3c74e0231f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_dev=
ice *adev,
                             le16_to_cpu(ip->hw_id) !=3D ii)
                                 goto next_ip;

-                       DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset=
);
+                       DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset=
);

                         /* We have a hw_id match; register the hw
                          * block if not yet registered.

base-commit: f723076ae13011a23d9a586899e38bc68feeb6b2
--
2.35.1.129.gb80121027d


--_000_BL1PR12MB5144244E34396AAB7E07CAC0F7359BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.co&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, February 16, 2022 5:08 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; kbuild-all@lists.01.org &lt;kbuild-all@li=
sts.01.org&gt;; linux-kernel@vger.kernel.org &lt;linux-kernel@vger.kernel.o=
rg&gt;; kernel test robot &lt;lkp@intel.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix ARM compilation warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix this ARM warning:<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'=
<br>
expects argument of type 'long int', but argument 4 has type 'size_t' {aka<=
br>
'unsigned int'} [-Wformat=3D]<br>
<br>
Cc: Alex Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: kbuild-all@lists.01.org<br>
Cc: linux-kernel@vger.kernel.org<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Fixes: 7e60fbfbdc10a0 (&quot;drm/amdgpu: Show IP discovery in sysfs&quot;)<=
br>
Signed-off-by: Luben Tuikov &lt;luben.tuikov@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index ad2355b0037f52..6c3a3c74e0231f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; le16_to_cpu(ip-&gt;hw_id) !=3D ii)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto next_ip;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;=
match:%d @ ip_offset:%ld&quot;, ii, ip_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;=
match:%d @ ip_offset:%zu&quot;, ii, ip_offset);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* We=
 have a hw_id match; register the hw<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 * block if not yet registered.<br>
<br>
base-commit: f723076ae13011a23d9a586899e38bc68feeb6b2<br>
-- <br>
2.35.1.129.gb80121027d<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144244E34396AAB7E07CAC0F7359BL1PR12MB5144namp_--
