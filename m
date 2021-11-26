Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EBFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDE18991E;
	Fri, 26 Nov 2021 06:13:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E93B889A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcEoR6kPUwCi3oWNaJTeu/JsYhdcki2wrWGNd0Cj6n2jxteEDsj61QsRmHknNkEYVY6bHqEhVjLBiAyQqvY/LQrVP4H/Uz9WN8d0vUS930No3WDjGSSBp2CwylOa0tClv28U071WDv6oDw3l0/4MttcjAlJ/sIRgwfojZQUiHyD+H/H2pW0arupduXfixU406UX5fsdKkR+jrALkiCVQiOF/VzZONCoaGdOWrjqlnXm+P8yuYT25cQneDBOMiT28Farwk7md7Kykes4QScTnLDwIOYxxTdS2Lhq44aaXPmK1QC16q91yLpehZ5FiKc1ULu6qQ/X9UBtreX25jU0MOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiE8o+in1sFlgxIjDL87qGpYaqIJ7IQZBOrBKLgkYps=;
 b=liXEhlx/vMMEZBARbJnqXWbJPpIdCVjIesI5NirAAW33BffBDIMfKBNoi8vBsI53G/Thg+CHIkEec3Ee5U0r8wfWM5PiM8NYf+Wm9AtSH/74RmFj6WMV+b6N4oSucIsfUdK4jYg3fZPUxwUi5PuvInaNl5fqxDygFLjHFsbyd3EyHAInLGr4r/mz69ZvnPxczqhLKkVqUPy56xAYiniwzZFXK8FYRzkjP8y9ZarQMqdtsi3kr/NjdygmOIFJ7jlg5LdaiZ3N30A+CJ2xjan93w8Crxn69OIsXoxS8se++6PKmvyacayX5Y9C5qLFdqvvI68bQe6BtbCznGrnvZN/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiE8o+in1sFlgxIjDL87qGpYaqIJ7IQZBOrBKLgkYps=;
 b=zJU/hieo1BNPfUgWLx4v1L0Ne4u92XVl8NubFCIbdKPNfZSLqqov3jTEKkCh72YHKVmp1ThoCO1mcyn/suiX+sdiGh7n6/2sev2P2nILyKspMG/p1zoJM2jLh6jIDWS4bkrKqBkshpbd6d49LTCGmmVzKT3+5tQTY/d0QFxaB9c=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 26 Nov
 2021 06:12:59 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 06:12:59 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix the missed handling for SDMA2 and SDMA3
Thread-Topic: [PATCH] drm/amdgpu: fix the missed handling for SDMA2 and SDMA3
Thread-Index: AQHX4oRTiEF+asBDu0GE4xSJBkAiEawVVC5F
Date: Fri, 26 Nov 2021 06:12:59 +0000
Message-ID: <CO6PR12MB5473046156BB68A255EC6FAA82639@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211126051254.24012-1-guchun.chen@amd.com>
In-Reply-To: <20211126051254.24012-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T06:12:59.102Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4b021a28-8178-d508-01d6-9fb8efddfb7d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f838a59-9331-454b-5e7d-08d9b0a3cbee
x-ms-traffictypediagnostic: CO6PR12MB5473:
x-microsoft-antispam-prvs: <CO6PR12MB5473AE4F3A7E386F34E47AA982639@CO6PR12MB5473.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cR+/1Lr3B7ovvASYmkmq2epWL/LREA4H1drA7iNdiIycmfmqCuSAHqNX+T++PDcnCMwPq8TinP/JVnvMCCQ0IxZAN7taBXUoq6vQZmj8K8M3LasvwylavyP29vwggeUC/TMjfc8R/5C+mEI9MzbS8uyfzNfrCU2f73WQURRYuOAZ1lrsmfu7ySi6IcuD9IMcNWSjwdhIggwdvlpOh3Ddck8VBnfveJiRj4tnA+j+G/6dEXuv99e1kkoeLnk5Rr08QyWYCCf+ingcKKJdtf4y+BJV4RBYAKliEyJuwp4aCKlvRvgGnwSt8ZFUTZ8q3IXYN3rrAH/wwQge7QCFgsdLjcC+wvoHfwEd9ylfv7gVzAgLJKP355GZYdBFNFoU8l8VOznQ/SfsC53MingzdeFnqLQzKZS6lMFt0rl8iAxtAvIDr+pdWOK+VM9pXTsoc7c+hk34RzRvMSj7GVFm8KzG0gnYmiKE5dAO/i9ZNhjhxiTGaAhxROSa8hN7en5qlgbe1M7wSEjzR9/4HLS1StiygkgTfImgr/iP1EwYytmNVYhtbpYeASb2e332yrGolbjcF77WddGqBZKvuHa1iOhucGnjSPDJ6ocGXzuuokvLdXuJU194zmzb322+X9L3zBZ878azvVisXKbeQx4HiEO39aXcjiL0+A8TdcQIXyib4QKJHG4Y+Mko648uBYZ1ux5vC80jP4/fDPOuV43lWjenpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(8936002)(7696005)(9686003)(76116006)(52536014)(38100700002)(186003)(66476007)(6506007)(8676002)(110136005)(508600001)(55016003)(71200400001)(91956017)(2906002)(66446008)(66946007)(19627405001)(38070700005)(66556008)(86362001)(316002)(122000001)(64756008)(6636002)(33656002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GUStayWt6Qoke7tveLW2ZuMDTKF5FNr+N+YXgdNRwZ10HhoLpXbd6ckcFs?=
 =?iso-8859-1?Q?BjT1ujT6pyn2PQJNeIoySmWy6+8gRFyeKU/Qufjg095czaQ6pQK4Ogh37K?=
 =?iso-8859-1?Q?0NmBCegLIRT5AycpagUryJAdlDyf93x7E7pejhx22mBzNH96ECTplfxZ/F?=
 =?iso-8859-1?Q?pJDja8NciBicMZ0A3tnXyktBAr+XcLWKwjc3o9FQqyIp2rMEGS4a424q3T?=
 =?iso-8859-1?Q?uVsK+4z1qSEQOlbs7J/6zOEjGS5Wp2mWnOEFb2tFfB+MMtWCUlpNHh56L6?=
 =?iso-8859-1?Q?9TM+cpy/ebS4Ko2haEMVX//jT9/830vi4M0eOPL6Eb6raOxCB76d4My4PS?=
 =?iso-8859-1?Q?/Zw04q2ZTu99fNCZYPKeeglSAUh8HgqI33YgI0OBqB7tf1GcaXwSjUmzDd?=
 =?iso-8859-1?Q?DZimcqMaO4u5VKnOySL4NPJfnjtL7WZ63vzqZwHxuIANynJG1j/0gF2YNe?=
 =?iso-8859-1?Q?52358fH7tbV8GsKqP0CP+gDxHWixOzaqb6ZSE0erK8IgfJbIOAB6FR+ruR?=
 =?iso-8859-1?Q?C605K56gGwg8zI4sb1o1N9OR3CLa7B3Fcoi0+PTUezaEJ0uXFEFKKYooln?=
 =?iso-8859-1?Q?eV6zPMPqJIENmPyEW7w2rUVnSaxMNUzyyWlQfUl2yJWKM51M7J84HlLhIx?=
 =?iso-8859-1?Q?SyWqIq0yzoDzfj1KPitdcbqdPl8seLukwKcBqy9jWT62NecXosMLd6s4Km?=
 =?iso-8859-1?Q?M/kKQ+pFAMCD1BLJWhhSm54O7tY1Cldwgo9H7cKxdQFzM5WFBk9QwexYYt?=
 =?iso-8859-1?Q?7h1Opvf8J6Uk9WQVfWRtobkRqFtapxP/fNWGYsQ2/GdN2Ppp4cxWzCITP0?=
 =?iso-8859-1?Q?tsT4+WFv5YfP0kdXYq7XRPqcQAJyRKK4noLElbklXQyuyPzBAswmoTuaCK?=
 =?iso-8859-1?Q?0U9MukTlji7Ml4BjQHz2tm1tytxyi+5E2hBmBEhh2X4FnP5JpvebbwJkET?=
 =?iso-8859-1?Q?t63wKR+GnAjdzt/ryJbx3sNHcwTbuNS8aTyEW1ayD3KNFEwFw9S1I/0SMC?=
 =?iso-8859-1?Q?sDGO4Ps6oVUrg+PHcuNhGJ6Vhc2tisgb76CMSvydUYKFVt0lCOc90/G/6M?=
 =?iso-8859-1?Q?ZYXhHCLP6ds8u1IPKUYmniNc4QWYETFT7DusI7srXHQuhEFZyEZ8X1UOmX?=
 =?iso-8859-1?Q?Qlz3iSRYgxWxVWxQHVmYsjVUb+QNcc8kK98LGyJXbv+dijmVE8GfCz05oI?=
 =?iso-8859-1?Q?Yh1wLmbQxln7WTOkRu0MWL+illTz55h5MPbauMELBrvi0RmM2RJHRCJ+2/?=
 =?iso-8859-1?Q?z6j8bHuKkCh4JHGjHNXpJhgJRTbmLGw41DBd38qresp6wopYt/1oYZrn56?=
 =?iso-8859-1?Q?VKdDiM1le+8+FjOgmAT8wAB6hI1IRt5L8j7RHKmDsfLoRquKaq/k+C3pnQ?=
 =?iso-8859-1?Q?Br7inW9iIfnZOa2i2/ukDPuKLGmmtdmXRNIisYCfueA1lCG1c0T3A2vb62?=
 =?iso-8859-1?Q?wgfSFKRs2wl/N8QKJR5UKfjACLhSHMX1jVviJPUiJFe5YHBg51QKXDFm8X?=
 =?iso-8859-1?Q?o7WAH5bS4hqQalYULRi3IGc76m5Ns6RoChoiQ7+kNuBUAEEnd24uZWz7Wt?=
 =?iso-8859-1?Q?2vzrWEDcm3FDYkfIgszHtezKccf5DydYptXP8VXh+siHab8GEo9Oflbs+G?=
 =?iso-8859-1?Q?jjxam6yAWhQ7AYWWgA/AFzkOHEBTrpdjKHu2Ij7P1aX9CUm1//qKkQtPPX?=
 =?iso-8859-1?Q?UqHF+n/IYZX5Iu47Pxc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473046156BB68A255EC6FAA82639CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f838a59-9331-454b-5e7d-08d9b0a3cbee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 06:12:59.5069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FqWp1+deXKKsaZiOFywSG/nRCoA7vga+KjzZeBlTrowuoGsJID0xaACaAuY7dTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5473
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

--_000_CO6PR12MB5473046156BB68A255EC6FAA82639CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Guchun C=
hen <guchun.chen@amd.com>
Sent: Friday, November 26, 2021 1:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: fix the missed handling for SDMA2 and SDMA3

There is no base reg offset or ip_version set for SDMA2
and SDMA3 on SIENNA_CICHLID, so add them.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index f6fae79203ee..ea00090b3fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -157,6 +157,8 @@ static int hw_id_map[MAX_HWIP] =3D {
         [HDP_HWIP]      =3D HDP_HWID,
         [SDMA0_HWIP]    =3D SDMA0_HWID,
         [SDMA1_HWIP]    =3D SDMA1_HWID,
+       [SDMA2_HWIP]    =3D SDMA2_HWID,
+       [SDMA3_HWIP]    =3D SDMA3_HWID,
         [MMHUB_HWIP]    =3D MMHUB_HWID,
         [ATHUB_HWIP]    =3D ATHUB_HWID,
         [NBIO_HWIP]     =3D NBIF_HWID,
--
2.17.1


--_000_CO6PR12MB5473046156BB68A255EC6FAA82639CO6PR12MB5473namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
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
Reviewed-by: Kevin Wang &lt;kevinyang.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Guchun Chen &lt;guchun.chen@a=
md.com&gt;<br>
<b>Sent:</b> Friday, November 26, 2021 1:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;<=
br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix the missed handling for SDMA2 and S=
DMA3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">There is no base reg offset or ip_version set for =
SDMA2<br>
and SDMA3 on SIENNA_CICHLID, so add them.<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index f6fae79203ee..ea00090b3fb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -157,6 +157,8 @@ static int hw_id_map[MAX_HWIP] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [HDP_HWIP]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D HDP_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SDMA0_HWIP]&nbsp;&nbsp;&n=
bsp; =3D SDMA0_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SDMA1_HWIP]&nbsp;&nbsp;&n=
bsp; =3D SDMA1_HWID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SDMA2_HWIP]&nbsp;&nbsp;&nbsp; =3D SD=
MA2_HWID,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SDMA3_HWIP]&nbsp;&nbsp;&nbsp; =3D SD=
MA3_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [MMHUB_HWIP]&nbsp;&nbsp;&n=
bsp; =3D MMHUB_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ATHUB_HWIP]&nbsp;&nbsp;&n=
bsp; =3D ATHUB_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [NBIO_HWIP]&nbsp;&nbsp;&nb=
sp;&nbsp; =3D NBIF_HWID,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473046156BB68A255EC6FAA82639CO6PR12MB5473namp_--
