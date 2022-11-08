Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CAFC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 03:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEC3610E214;
	Tue,  8 Nov 2022 03:46:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4011D10E214
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 03:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os5i4Qo24yk91Blu0SAnBp8Zo81bQRz0RmqwlzHqPclrYQ3u4/gP5W8TZ9UibrAAse7zlp53jCtRaigTPCjyl6oRhneL9CCoOQXu626YRIaLOaj/GRW8kWBhu9RUT49ltUFC6GH+IRyl14z2FPSC9SSPxM6efzMtiQt6WTH1R2u8zhahGuEWhfKZOG7mUsUqCfwOiWqZXqDzbvHtzB/8XW5XBZnx+Rc25f9kbpMANt4zLhpq/9ycIyS/l9w5R+dOzHHT0MRvvQV7b5985XOw5eKYn/aLcHqgiiaiELNK7yRxiQC2o2vkcNrV67RlPi9iOmL897Z3MTVLaT8SeaiA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxxzofTSEO6lUP6v3TfcAmOqqxghbHLZ47n//Z3RrWw=;
 b=Hdx8yVyia98kS95r274oyMi1DO4Ova9OpYV6fCK8oFy9Z6rs2LYy6w5hPOM2bRGTi4uLlkJSClxtJBpzobczQEzyKEl9Q7hF323Yw7pUJXqz5MY8zbjlZ+GLJdI2VIJ4+VqrvIdKqkFGJaqs2ZI2keViuCKXUZkzB0g4X1pjMAylSJ3XVV3lZmiH16d5xyS6L23SRdNf7JFOAoJB7qpkvwz0uKfKo9pPFWln3Xv+dfF690rsz6rBtZ86oFhjYiHyVu0zAinqgJ3IgS2mrZt8Nzprw34G8le0aVpcYKX30/wAHwoDzj8adPi4L7rCdFrzcoGlqNotXWiL+Rc2fzJcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxxzofTSEO6lUP6v3TfcAmOqqxghbHLZ47n//Z3RrWw=;
 b=XvFH9t+lMRN2CdbkBgHlc7681/hMKAsf7UkD0StxH2V0pNsOe1us21xUWfQYoDI7s/Hzm2/sUYlUZiXAkfy9AFZdMDektAUQSEHkX76+h7hqQDgGZnoLWS2g6TSxfUIVQMt39lSu9GUFaC8y2bJtRJCBu7LpUXMe9RKslG4+lMs=
Received: from DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) by
 PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:45:58 +0000
Received: from DS0PR12MB6391.namprd12.prod.outlook.com
 ([fe80::dca1:4eb:3107:d001]) by DS0PR12MB6391.namprd12.prod.outlook.com
 ([fe80::dca1:4eb:3107:d001%5]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 03:45:57 +0000
From: "Patel, Krunalkumar Mukeshkumar" <KrunalkumarMukeshkumar.Patel@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7
Thread-Topic: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7
Thread-Index: AQHY8n+62brZrpXvBECas9xwelV5fa40Y8TN
Date: Tue, 8 Nov 2022 03:45:57 +0000
Message-ID: <DS0PR12MB63911377B20123352536679B9D3F9@DS0PR12MB6391.namprd12.prod.outlook.com>
References: <20221107080501.3205127-1-krunalkumarmukeshkumar.patel@amd.com>
In-Reply-To: <20221107080501.3205127-1-krunalkumarmukeshkumar.patel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-08T03:44:19.6459053Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6391:EE_|PH7PR12MB7138:EE_
x-ms-office365-filtering-correlation-id: e2fa0afa-4226-475b-e054-08dac13bbf08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o/6Meu+Rkf3IKb+O/D4EXH6zqGObPAW3rgGbA/mR3SBmGVoCtnHvS+AlRlY9Kz9P3joNVUP4dY3NCSOVtB8hCDHOfFa52Sn6KM1sEg6+vEaqy3NM9MX2987j8rzL4fEqBILsLAM56B7TVeFnGcw5NBSyK99g8p5JlDEcx5OzQZZ8PCgir5G849WiSVCnEWyutIUXmsCro3karX3sGIJ5yig6GUW9r8BSya8XnWvpb6/fSiXbrdfDkyFIdCozs89VSlHk2OVNhtb6akeQOfFzlwHJLtdNsjoOUpEiX5Jazotgbq1wLuSh2+gy+MrmVmhM7wWuWD5beUwm+sKjUnBoWdDAzJX++afQg+pxB3duaEbAWIuotLhHRyLHtc0fIFjCG+6DulRuGxwumt+0gJYqqOfFrOa3Nddod5tdZrACOI6ThiSvpBaxY9szu67jaUmU+A2cloJQowjYLKJMEkEp77KMZkRZuzdt+GfePbEZK7rVoUU3HDF345c9/pHzP+At8ljMdR8xBvKYHH/JuPa6auJ1tt7FZy9c3r+KQK3JGBavq0j5PL3DJjwiA+c1ks/vAtBkdxydcB9z5xYLq3W6wdEIyXvQIl9xCU5NI6eZWwBpMJHEm1w5UlvdNgQCUf5gZCS9FDofMtJedZ58WW1SMeWjvAzDjAVsxDXMBA00BYbBbX4Ptdee3Gmds+oA9VXneKurte4uvIl0+zaVqy4+4x6YSbZrHgQHXadTb1hZATPGq+W8U3/uKIPT5SFxbhoG71/CLV5xnhRHcNWkhm5BcHohJnEKmgBj0oWh3Eeq474=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6391.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(4326008)(66946007)(66446008)(55016003)(8676002)(64756008)(91956017)(66476007)(66556008)(316002)(71200400001)(76116006)(5660300002)(33656002)(110136005)(54906003)(6636002)(38100700002)(2906002)(122000001)(41300700001)(8936002)(52536014)(6506007)(7696005)(921005)(186003)(26005)(83380400001)(53546011)(478600001)(9686003)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DQb6GEyiViDt6Ot/x2on19X5ck/lo/DYc0kauy/zzsDYRDJwngFWQUAg39wk?=
 =?us-ascii?Q?668pyq0apCEd/g5UQJk2gE35STVNuImRDTLiRbAq+S2T+Y8gFGvAoVpHYEcK?=
 =?us-ascii?Q?opxm5g17yr06Y2dqpfAonzNR0vxwCI41ZkXzd0hqIE/+YIwqsmq9r4i9vYjV?=
 =?us-ascii?Q?FqKE87o6b32RjCu+WSHilrHIyX5ug7yTRtRRFIE2SGT4mucqvpZoGzgnQ9HL?=
 =?us-ascii?Q?2CTNxFBygEklxT1fXgjjwQk5GCExpnDkdNFBsODua9EyCYB+gPnzeSG/KHop?=
 =?us-ascii?Q?fyyNjkWpaWG4h8n90iru7SWkD1y6JEuYWsltyjehBiy+olIZ9siLjNhh+VZq?=
 =?us-ascii?Q?90U1C2EPNF6Yy7jiAAnMcpZ+S0lIhr9D8LiPhzR8ruQtfGKWzZ5l3m43rDl/?=
 =?us-ascii?Q?C+SLh1wlyc8eRFMp5O11VQL1udC8LOo0z15nw5g4s9o8H1UKBo7L422sIfJ2?=
 =?us-ascii?Q?NvhdqmpRJQCdqMvtnK/z1KjpKJxSHoGZmKLmzxoTLdlI1QZo05lePdd3YdiM?=
 =?us-ascii?Q?JIA3dFxhBiQprS8JH9zAdoNFkvBUQzKLxRvRod8qlexs9TYqXUKQWH3IYt58?=
 =?us-ascii?Q?8EXEdP0d5imiX+hHuymOe7i6lzejcV5dy8S1PRChu5MkS+Fv1Wf9DSqaq/uL?=
 =?us-ascii?Q?elzUmXrFTTJeA7PbrVBog/ikqd1UYwV3f5fQRvDPweVfn5p0Cf0/GcviQruh?=
 =?us-ascii?Q?o4MARtGm6+TFpmtcuEQd+UPd9CWR1hzrcNU5ExBqKyOp7vOjXpPjahXciWVu?=
 =?us-ascii?Q?V9BsK9i/SCdEdyr6kP+VmBVUvttVaX5qJSeRR87PX3Nn+AkVEMm6Z/rSOg0B?=
 =?us-ascii?Q?KAZN31XOF3UBbJaFbe4nOrDmAOS5imCqvIlsEoIZkUy+nqHYJpR6+dQ8XuC1?=
 =?us-ascii?Q?gUbq/Fbrdfi7PEy+JNN4JD2IKH2CLnEho3KXXxtm2PGP6IObDKT+JIo8poAN?=
 =?us-ascii?Q?bvaLxWnIEWLPOUH2dSYwPooZpOgYV0TS7kjWXZ55hRyTWJev7NSXHDqH+YOq?=
 =?us-ascii?Q?KKtkRkJu7R0A5ykSbfiSnL4/sn4y54d3XvLREsONsMZ2YAZ6hcb6lO1xRozS?=
 =?us-ascii?Q?Ht6fkBpviMdmp+hjetbtKg46nOkExfJ5LX2j0duHCX47HSP5lgGVA59pErM3?=
 =?us-ascii?Q?zN7ajCCW/qnEqZmrF4QhG/5ODioqpN6VAHwxSbQwSvwieV/sEu+OSXEL4Y1m?=
 =?us-ascii?Q?w/V5kaZMJvilU3fsPE6uZ6+D5+Tpw3OdPprTJ+zYFixJdKnyWNVudPbDF3VP?=
 =?us-ascii?Q?5G+e5JcW1Xpvra4FHoR1PheCVTequwT+NWPgvd1V2WS9+inblbdiJHdAUSfl?=
 =?us-ascii?Q?E9GVNPO9DCWF6DjRKlXKshAUNdWcAIJ2fWsxD+mIWTC5Jmt/1Hamnq90r96R?=
 =?us-ascii?Q?Np7vVnAnvOVbQl1RH5S2//S125UuaKTKaFfbrJFgDer3VqvabMSsPtp+Q240?=
 =?us-ascii?Q?5/5Unf1MqteeooRRz2+eY7oPOhWlt32U4d0UWWM6A0ie8CRt8Ciu94LAZAh1?=
 =?us-ascii?Q?AP3JjkdMYNNSFOVvtzz4FOOhsn0Z2lHcvDZeFInCKnuC30Wg0GqZqqQvGsnT?=
 =?us-ascii?Q?5EwkQCGKlntkvhw81sEH4OBkw145T4Xzldvry5OyEtVHjAeEVd7i8oGTrySt?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB63911377B20123352536679B9D3F9DS0PR12MB6391namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fa0afa-4226-475b-e054-08dac13bbf08
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 03:45:57.8295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQcE4+V+OzDsMngloBp7Ke7K4rq1VjulKdY/lQAhToGdkxwCPr9FhruNEeqvg0RriOnlFrDjbWgtCMsbvN7vfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS0PR12MB63911377B20123352536679B9D3F9DS0PR12MB6391namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

+Likun, Hawking

Hi,

Can you please help with the review of the patch?

Thanks and regards
Krunal
________________________________
From: Patel, Krunalkumar Mukeshkumar <KrunalkumarMukeshkumar.Patel@amd.com>
Sent: Monday, November 7, 2022 1:35:01 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui <Xinhui.Pan=
@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; S, Shiri=
sh <Shirish.S@amd.com>; Patel, Krunalkumar Mukeshkumar <KrunalkumarMukeshku=
mar.Patel@amd.com>
Subject: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7

With this change it will add support for clock gating for sdma 5.2.7

- Additional changes are to re-arrange the chip version sequentially.

Signed-off-by: Krunal Patel <krunalkumarmukeshkumar.patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 809eca54fc61..404b255cb4e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1647,12 +1647,13 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
ndle,

         switch (adev->ip_versions[SDMA0_HWIP][0]) {
         case IP_VERSION(5, 2, 0):
-       case IP_VERSION(5, 2, 2):
         case IP_VERSION(5, 2, 1):
+       case IP_VERSION(5, 2, 2):
+       case IP_VERSION(5, 2, 3):
         case IP_VERSION(5, 2, 4):
         case IP_VERSION(5, 2, 5):
         case IP_VERSION(5, 2, 6):
-       case IP_VERSION(5, 2, 3):
+       case IP_VERSION(5, 2, 7):
                 sdma_v5_2_update_medium_grain_clock_gating(adev,
                                 state =3D=3D AMD_CG_STATE_GATE);
                 sdma_v5_2_update_medium_grain_light_sleep(adev,
--
2.25.1


--_000_DS0PR12MB63911377B20123352536679B9D3F9DS0PR12MB6391namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
+Likun, Hawking</div>
<div dir=3D"auto">
<div><br>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Hi,</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"color: rgb(33=
, 33, 33); background-color: rgb(255, 255, 255);">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"color: rgb(33=
, 33, 33); background-color: rgb(255, 255, 255);">
Can you please help with the review of the patch?</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"color: rgb(33=
, 33, 33); background-color: rgb(255, 255, 255);">
<br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"color: rgb(33=
, 33, 33); background-color: rgb(255, 255, 255);">
Thanks and regards</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"color: rgb(33=
, 33, 33); background-color: rgb(255, 255, 255);">
Krunal</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Patel, Krunalkumar Mu=
keshkumar &lt;KrunalkumarMukeshkumar.Patel@amd.com&gt;<br>
<b>Sent:</b> Monday, November 7, 2022 1:35:01 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pan, Xinhu=
i &lt;Xinhui.Pan@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; S, Shirish &lt;Shirish.S@amd.com&gt;; Patel, Krunalkumar Mukeshkumar &=
lt;KrunalkumarMukeshkumar.Patel@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.=
2.7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">With this change it will add support for clock gat=
ing for sdma 5.2.7<br>
<br>
- Additional changes are to re-arrange the chip version sequentially.<br>
<br>
Signed-off-by: Krunal Patel &lt;krunalkumarmukeshkumar.patel@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +++--<br>
&nbsp;1 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 809eca54fc61..404b255cb4e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -1647,12 +1647,13 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
ndle,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[SDMA0_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 0):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 1):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 4):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 5):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 6):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_v5_2_update_medium_grain_clock_gating(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_v5_2_update_medium_grain_light_sleep(adev,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB63911377B20123352536679B9D3F9DS0PR12MB6391namp_--
