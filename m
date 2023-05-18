Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997A2C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 14:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182D210E0E0;
	Thu, 18 May 2023 14:47:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94EB110E0E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 14:47:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShPzj0HTLUIHO1HLsciVk/YtTWI3nlDyaGt2st6V8Axi9qJJlAqV2SiaFKSYP8SjgUV+rsw5cSpPN4PCmpCHhhYcw6D1ZluxaMZ3NkJUk0ydyI5QWK7vvta3ByDYRvBztIQBlAAK2wUaLqgkHpftW05U5p0xcsX+lFWnwxSzRVJIvLI4fXCim993k9Rjo/OtmHmRzs7IyO2JDBJIlqtkrfEj8ERcILNJczrZEPdPM70tVX4SFsbb/lrkfFaIn05ni5MQLtk5igrOBkS3EnorVqwqh7LKHz6q+PsWWpJcBJ9NMy85bbRctx4MRbKlNncZiga6xKbX2T6KsrTaNn4mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ise/db3oK1uJmjfSFaAvg6hGdgG+6FqlcFOpJh6D3KA=;
 b=HN03MlXB3mhmW0V/czaZdpiTxvMiux4IbqzfONysRuzs5KEL3L/nEzYWLtT0E9nsrcsUPG645axoIGagcCld0ULX42KqnNEiV5cPTbhkLGIo5ioqIDftaO0s3rcCej2M4cd3j5PzSssxc4/hcB0rL7D1Esk+BrPwEcNkZnt5xUCByX3C+xtsUS65Np1CB2+j5PS9aBJzTJEjSvXp7FofakG5FjzOnKK9LCM6rTSvjUEY4Hp32eguszsmvbjX+HKsL+keS3W5CV0s0XP1d9WM9K9hnvzCjxxYix/afi7bPsK98/aMevYKnaOKZSVcIC2cCFGvweNTIkfAOaEFMKEVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ise/db3oK1uJmjfSFaAvg6hGdgG+6FqlcFOpJh6D3KA=;
 b=rtYVuc3pNtz1dFYHSL+19ZkzemlmOJJkX2BtAWk8p0Wv1iIKAGGGubG+SdA//9UabdPkej4U2oXuv8D445LWPWyBAvFf72uXDYzhr+k9+SQe8voCl/QwrMYIdzIHIVip/BTDoBcsBzfy9yX9XzWqfpvhfC5Opa7Yers0fSkALI4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:47:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:47:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: Re: [PATCH 0/3] cleanup abuse of sched.ready in each ring init
Thread-Topic: [PATCH 0/3] cleanup abuse of sched.ready in each ring init
Thread-Index: AQHZiVa5pfUabrNiNECY0SvPrxyydq9gHGeE
Date: Thu, 18 May 2023 14:47:18 +0000
Message-ID: <BL1PR12MB514476AAFB76CFD21C81BFD3F77F9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
In-Reply-To: <20230518070215.3556653-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-18T14:47:17.739Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB8860:EE_
x-ms-office365-filtering-correlation-id: 33039d14-7b02-48c4-479e-08db57aec73a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LaPE+Jt0NM0+EDjmL2NGNIwpDJiixx7LWfXY3SnuzqfWkPyaYOaXFJNZYPEAJ5NJJm+Nt8tAJuSvCYoLjU7LvZvymsVkswoBbFJYmU52lxJj0cj6DJ5dsqmHT22fwEL/db5CvN16ZZVBSf4xwJKbiPWiLcNXcu2fD3fFPe1alGp6LDCeW8UdFlV/gmlYgUao5xSzIilpwLBaZkqUiNom9fgHqjmr0zoZj1uKcAjLfhB1znyaLDDFzTbA8QeOL9EwOM8cAleHHJC990eHfGKo1dBebKtyoIhYqcuts2PpRqm8L6+xJC9x70CP6rmNLDjhT8zhr9YQRPZ39uhLS7e7vYOj0AMrU7UurPwHBO4SL1dcFo7TnWfd6kc/UR98jsP5g2AsDOoEGxkyrDwm6qVA35ld9naPZImBLxbCfCGpT3VhP7wJh0eU4ZCoEv+Id1EMN2CyR2Md+m04csG6BowLcl4ANXpJKxMrtLUFDgvaot24Sfr1ectSF5FpcZNKGvMOIZxaYG3QPk3oMLJgCFIgTdwzRaep4xqooRDQa/nD8zCfBMr5p4MhQGOthN4wDiagI4g9IgYHU9i/jKt67RhOyBTQj3fVtgc2rYmleY5DKJs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(38100700002)(38070700005)(186003)(110136005)(478600001)(71200400001)(6506007)(9686003)(26005)(53546011)(83380400001)(2906002)(8676002)(5660300002)(52536014)(6636002)(8936002)(33656002)(41300700001)(122000001)(66446008)(76116006)(66476007)(66946007)(64756008)(66556008)(86362001)(55016003)(316002)(7696005)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EpmY5uDMo7zTthQwfrRBSlFV8ecgykEI6tD2EbgMmXDBfnFMqLN2yBQ9IbUi?=
 =?us-ascii?Q?gLdYp9OkmHcXQbFzueJm0wCWFOUvM65n5BrW+6A4OAg6bxecf4g984e3AJ0R?=
 =?us-ascii?Q?Asb8KpmSSVV21dI3iBZj5WVMGQy697j8lGZLgxODVObUduOSVRI6kPxb8y8V?=
 =?us-ascii?Q?c1cnsRQUz/tz1UtUFt2DwaOXyJ3vnCFxTTPLK+IuBHdHHsdR3EfXhQxFEDGt?=
 =?us-ascii?Q?ngoU5RTl6PT/v0K+M+JQofhdwiXiSvASpU24G35SAmIG42Jx2EolxIdY7gKe?=
 =?us-ascii?Q?WY58XkoglB3y4u0gT0lxAantPS0QdkJWK5XBahOZDjhrq5lAKZKxc5Qkot/p?=
 =?us-ascii?Q?cg6L5jznLXGSS6tcqs4O7X6TcM/qEeGK7jo/t8ZEfJ5Lg0bY0lx/5u0bb0t6?=
 =?us-ascii?Q?XsmSnN/mbrDKKeCGAN6ZvzZ0/MC5gDC0WCimgNcIGPqjEzLyNaPXfRUu15iw?=
 =?us-ascii?Q?xC183mO71pB1lx7NOJFMWvLEAOkBl03a74/jUT1BCD1X8tpA5PeJqVrEDV8F?=
 =?us-ascii?Q?FDWB8dznr81MQJkrTh/J+nLOTL8D9V1bO5GRjTg7OIabu2exf18yhzPS0Lxe?=
 =?us-ascii?Q?WZqoIhtnZNVM0HIPQGSaoM45Xh+HqAW30V2/eL9NGQmA56gzCC99gPs/ziBM?=
 =?us-ascii?Q?YTng7fF9tTfqhaza3zAl+egHtjP+aVulYtULSmoqighTAIBmggDnwpSZp5l5?=
 =?us-ascii?Q?RVAOWzM4OIr/tF7vgVX5i7hqgDyApIhbVw/SkPmUVOQC4H1zi6LYDaEWNwp5?=
 =?us-ascii?Q?ewVEzbAJ5t61xBBRdleUBaZSTItzMjGziCALOkyzTDs1Suq5sBVbJ3Z62llQ?=
 =?us-ascii?Q?8uIruBFPoLJawotvI7KPQKwLil6zm++DIe2SNrBGcq0jlDMf0hBwNBJDEtxp?=
 =?us-ascii?Q?LNhl1nYdCFSKH+glmvWSibl8LGlYCCk7RV+BBPqjb+iIPF867BlMvUokT1I7?=
 =?us-ascii?Q?vQS42PfWYnYbxlvb/x4FOqhQE+Rd/3D5UQJJxF8m/1NvtQK/BGFy07f3ee1n?=
 =?us-ascii?Q?vyHjYCrUZz5LwpcJG1bV3saNenvhD24k7jVL1tPfPIHgvjDhuQfWX57WNPVe?=
 =?us-ascii?Q?hTZDAW4SVlXLY0XyJDO14UvYwKWOEwA0Vs3vxzznEH+UwFJSfeTqdJFqAC4i?=
 =?us-ascii?Q?CmxacpLQU8meFFibAmqRBHSb8dNFr1rqPL2Z7p7ENt9asLOl+TF/hoQHvSZP?=
 =?us-ascii?Q?JlPzN26nFQD4prGNXJ4d7SehgT8lKuUNj2iccXiArEiqFeFexmxwoEtFcp2+?=
 =?us-ascii?Q?pyMsQ4KNPbcLiFipuohEgBE9AOSIh/vwkMSkvXSypsf/8Xbh3yvtTM8hZMyz?=
 =?us-ascii?Q?mY+391A+pKSTwOm/ugSwr0o9j/TuhdwZhpcKngS1MLUIrXYizdVJKw3GAXDL?=
 =?us-ascii?Q?oOpKTvjuDAf+ICsmS4aTpkJT5kpAE3YtmbvL3fAKsquyS3vWIKRTWskWFeFE?=
 =?us-ascii?Q?eLZcK06rTIE0a4MtTHAHKiMlWh/1wUhu8xnP2/P44AovPq/wtQ6/yrHOLz9z?=
 =?us-ascii?Q?Z+6RdqdSQXZKZAPgl+LSwkLCNU1Gvd5la5KBNHU9B1OBv9bxvaX/jjRugysk?=
 =?us-ascii?Q?jIIiwrBr+Cdve3zrQjk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514476AAFB76CFD21C81BFD3F77F9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33039d14-7b02-48c4-479e-08db57aec73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 14:47:18.1391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5XYxV+bHdhB80OKDKTwEhl01jtm0TDIFLkLy6w21+3M229C4wdLd8ZRmZUmvDW4R5QB1uF2tYJJEhXOFVPrOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
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

--_000_BL1PR12MB514476AAFB76CFD21C81BFD3F77F9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Threre are a lot of places in the code where we check sched.ready.  Will th=
is break any of those?

Alex

________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, May 18, 2023 3:02 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 0/3] cleanup abuse of sched.ready in each ring init

This series intend to fix the abuse of flag sched.ready in
each ring init process. Its status needs to be updated only after
respective ring/IB test in init/resume.

Guchun Chen (3):
  drm/amdgpu/sdma: set sched.ready status after ring/IB test in sdma
  drm/amdgpu/gfx: set sched.ready status after ring/IB test in gfx
  drm/amdgpu: switch to unified amdgpu_ring_test_helper

 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 24 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 25 ++++--------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  1 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c   |  8 +-------
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  4 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  8 ++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  6 +-----
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 --
 17 files changed, 15 insertions(+), 95 deletions(-)

--
2.25.1


--_000_BL1PR12MB514476AAFB76CFD21C81BFD3F77F9BL1PR12MB5144namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Threre are a lot of places in the code where we check sched.ready.&nbsp; Wi=
ll this break any of those?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 18, 2023 3:02 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/3] cleanup abuse of sched.ready in each ring init<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This series intend to fix the abuse of flag sched.=
ready in<br>
each ring init process. Its status needs to be updated only after<br>
respective ring/IB test in init/resume.<br>
<br>
Guchun Chen (3):<br>
&nbsp; drm/amdgpu/sdma: set sched.ready status after ring/IB test in sdma<b=
r>
&nbsp; drm/amdgpu/gfx: set sched.ready status after ring/IB test in gfx<br>
&nbsp; drm/amdgpu: switch to unified amdgpu_ring_test_helper<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c&nbsp; |&nbsp; 9 ++-------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp; | 24 ++++---------=
----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c&nbsp;&nbsp; | 25 ++++---------=
-----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 --<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v10_1.c&nbsp;&nbsp; |&nbsp; 8 +-------=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp;&nbsp; |&nbsp; 7 +------<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp; |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |&nbsp; 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c&nbsp;&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp; |&nbsp; 8 ++------=
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c&nbsp;&nbsp; |&nbsp; 6 +-----<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 --<br>
&nbsp;17 files changed, 15 insertions(+), 95 deletions(-)<br>
<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514476AAFB76CFD21C81BFD3F77F9BL1PR12MB5144namp_--
