Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8301C7EE29
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 13:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8237310E238;
	Tue, 13 Jun 2023 13:07:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A531810E238
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 13:07:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsT0TBzTyPCha18CxNof+mxnLPMXhP+aeY3MiHGxafMy5by2yW+ie2W435QbnLES1eBCTevWlFjVNtynH3FBAUL5pGweEh7nNM+m4DppaEPpezvR1HJe2AEObH8A5DryZh6b6Ppp2IwhEdzO/tVmb4SCcgtfqlkKyuq0hROpD0n+FOG7nHvIQq5bTB+EuZHWJqFslusm+jigecpMxHZTxVyIwDvYBe9TRyRWYRr0UkgOT0YipgN26tAUV9LNRKkWxr/t4dfAPWR0FA2dkiuXPA4N66UNgwvwIWo7UeMyobK83Go+Kls2dMrk8Z1hldW10fFJDpWgFPWDIcHmYrOZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjoUFSjNPfIZ4dLK2YWtv7iodQMEDw82oGI6cg+iO84=;
 b=HoSl87xbR0DLeKykqygkyl1qEdsPR0tu4a/F/m4BxVkj+bm4PEX9G1chsdj6xklY8s17Au2CzpNApHvm4SAaCQDQj6yfiksw4RYICEVLbFDKXrqFv2E4TeyHOE1T/iQ/0D/VuM2YGVrSfsz+rO++KIr3MAf5q+3NRc1oKGj0KBc1fy6N9yHLh1NIrR484l7geoirUmpTkJmM59M4xflrXpala3rE82i57bxhPnGI2KYNOEKtWuVo6+U9IL+Z3owpYGtDhSI+85fiY8aQlnQasVJnN5zXbd8o5amK5E6l1aMLsRamrqN75LLa5iG6K3mPMTtQcs+ymfGEaxTuIehHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjoUFSjNPfIZ4dLK2YWtv7iodQMEDw82oGI6cg+iO84=;
 b=1ah/NS8Vr2JSzLWZq1lKPeptzheiKxEnB2ONDi4D3eJzpj/klnGCNNdHbPoal80h8LBLSI1vnIFqLPx0tKQiLNYRQD2AofkepxY59apVDIUkgjESBe07BBoaHzGBj//scwh6vFaBaZ4CR6izHsAmfbUWRX2J/zSis9nbhDzLNW4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 13:07:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 13:07:46 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Remove DUMMY_VRAM_SIZE
Thread-Topic: [PATCH] drm/amdkfd: Remove DUMMY_VRAM_SIZE
Thread-Index: AQHZnYKjgifToB95fkWPy64c21/8oa+ItP5j
Date: Tue, 13 Jun 2023 13:07:45 +0000
Message-ID: <BL1PR12MB514404816E1E09722C049191F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230612230651.755557-1-mukul.joshi@amd.com>
In-Reply-To: <20230612230651.755557-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-13T13:07:45.063Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV8PR12MB9230:EE_
x-ms-office365-filtering-correlation-id: 7e0044a2-c592-47cc-ff17-08db6c0f2e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8IwTZkUj0AbBhbLo4NrDNho6J78o/4DNIZBJ8ek218u75cHQPeauUYYfolp5HAuoTO8wd36xECla/V83/W/qtgZUFleTXRPIjnFDpK2vwSOHza0C610wbIhdraloUwJLIvc+bZy8Id37xFF67DCyKiIe62BIrYkBnuitDQGIHYDdXrWWFjSC9BcNh7honYSu0VqaBDfibqux09ebJ8IOi/apZtgxWwMm/jv3ll8mriEz9s7TdxPtFkb7UsXIrHeOdfPigpt2djkBfp0/VBu+PFrPd3ef96TFjC32qB9dNyRXEf9NALNwO/4O/hEDh3Uajp25QFekET6JuigPY+ldmgvHyARG686nXLr8Z0a424O3Jm0C1wgJJcdyWS1T8g/9btd1Z5iE96YlsBVx3Su/Q0r8zs5KRxa0Ljykem+/Sxpb59qezD2VRif1DZ2enGcW9dSQw3KGItmlafqPsMMJqAPzDNP8yFS20zwY/dUno8jcR21NDcyXfFXTuQzcSEX0WZFkhPwRatvCQRwLOvN/Up+rprO/FO7iX9SohrblzSUMW7v7eRteP6FS0m3Cv5ufWAufBiYSUPUu1kxDBM6ZhClq5FvAnHWtbMFYcr2lU2BmtiksW8Q948fkM6Sk7VY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(2906002)(38070700005)(33656002)(86362001)(52536014)(19627405001)(55016003)(5660300002)(7696005)(83380400001)(186003)(6506007)(26005)(53546011)(9686003)(122000001)(71200400001)(110136005)(66446008)(66556008)(66476007)(64756008)(4326008)(316002)(38100700002)(66946007)(76116006)(478600001)(8936002)(41300700001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nuSjZ4KTe4SE8f+hVCS8JEVobX0I9gKg7CtLZb6V54u6LGLgYV4Dl4OlwjzV?=
 =?us-ascii?Q?dSJhh8KjAojN1QBIVHnMdBgDlwJ+l7GpbDr5etTNNT9W8DuwEWYLGifg8d/e?=
 =?us-ascii?Q?yPMe7xFbHG1e6YDIOZaCFeQacLHqMD3mronTCQoL4RdDOCS4/O117ZQKoVmY?=
 =?us-ascii?Q?Z/xd7+ZtKBghw+vLtHc5ZmWTajVCSEo4obn351jPatvwQbcaPWD6tav8oKnW?=
 =?us-ascii?Q?NsKoQf6FC9NYR4y9NH50WwCL8PZ/TiRZ6o5Hh94QQN4+VuikxI2HN0Oiw2Sk?=
 =?us-ascii?Q?Lru0p/5rHAXyRmnsQumAgVZA+fVputpbb2y55wIsG3Kr5Tmcda29qj+WWLDx?=
 =?us-ascii?Q?GhxezbFEC7ChiOftAIs5CGPpLyV0Vz7Z5HuwJGZyTk2GtySv2nRYHcHAZ8Yz?=
 =?us-ascii?Q?dgA3uv3XScQzXM2PmijRyVR0J1OLAGGhzXPSLBoB+7Ko09pvjcuilB1xPSou?=
 =?us-ascii?Q?k6wd8BOIPqtAjGiP+0mPvqFP8+BfzJHlqrZivLHrsNc0fawWyHDK5mAicWqR?=
 =?us-ascii?Q?jh+mR8I/EGmqWyQ3ZKX1CBS5qmlZm7dE7ChdyHTg2gAB5pJZw8jjGRHru2ny?=
 =?us-ascii?Q?NBe+h1b4QnkEo7eSoXA+Kucs73dT+OQY5XsZUAwPnM/K5XTMz4ecK3EJ3tZf?=
 =?us-ascii?Q?mOk0LZUGfTYTT6FQS3ND7oA8z1+yy340vLQdcjSNRCOQ9Gl4qcndBmjtoH7a?=
 =?us-ascii?Q?kqaRAiBfMpyPzaYDeSdcx++21GLNgIBYSRKZc7ydvkC4PlN3cTebIp3Dnjxg?=
 =?us-ascii?Q?V+pNFp3IlE/UVbAt8Ug63C5mxEFEz2olOOBR7cuhagQEA+j5qUJ/gJ2zOMOM?=
 =?us-ascii?Q?H5BnIZ3fDStiqXWvvHvwZN7+wgqDYntGzKreXhXngBgIZoe+pQ642os9wATm?=
 =?us-ascii?Q?Cl3RLlnMEN1yQ/CKa0a6dQrLmv2vYledJL+PT1D9C6jqAQnvswGPXG1WLK8/?=
 =?us-ascii?Q?0vMpaXIebUhX4i+Uq8Pn+ufOvvAx0gwAGXTOtEh72TI4Z3zvcYUep0UAUa4r?=
 =?us-ascii?Q?c9iC8l9YP49IQ0wl/800xGF+6bq56+NtE9H6NSxEQiM0yG/16pG2Th+ipewW?=
 =?us-ascii?Q?R6exT1n6pjycg7PfhmQC0rFU1HZulZg2dIEeom/yWIGx97Cy8rBwb6kOCAO2?=
 =?us-ascii?Q?tWSo8/DjHJ+D+zHsuC+eRXOSAVGwJthhXgbiapogsgF9l+KwkbFbYfxqJH4T?=
 =?us-ascii?Q?0u2APOI/nnWTKM9AFmohTAOHGe7TZj8rBvyCstTATvaU8jsUGzriCocHV0sN?=
 =?us-ascii?Q?LVyjz2zo+yxtRmM8XcwdoWON/Ptqij5lqeGRZEPmxcehjYv0NZdJmCB//G9R?=
 =?us-ascii?Q?Pakv9wW8nFSlIOGymEHBbJnihYoIugPs6kL/Wz7Tg5l154kFgoy0cxFwFGaR?=
 =?us-ascii?Q?PhXJJjpKuFmfxSbn87JVSln+d0VhgwzsZEShwcZgKU6/+UkoYG6QKI/lUJQX?=
 =?us-ascii?Q?EzmRzXE+VUAiHzYLr0J1ObwIkV3d6Ihg7ozIUq5JhzkQCf7nDH0hmddnMJSc?=
 =?us-ascii?Q?DiO7KMR0OBC536OB4xI8KeraDNsDARGqAVYRUnq8Hvk33EIZWPONviCXXmow?=
 =?us-ascii?Q?v7df9Yq0iuuputYZWuo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514404816E1E09722C049191F755ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0044a2-c592-47cc-ff17-08db6c0f2e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 13:07:46.0012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a78J1pRIhRo2q06hA+jtr+Blfj5IW0Cb2C1QBMb8UcZUdEVOGci7rvEokkCYmJ7BP43h3UA0mpnNXLhGo9BeUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514404816E1E09722C049191F755ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mukul Jo=
shi <mukul.joshi@amd.com>
Sent: Monday, June 12, 2023 7:06 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH] drm/amdkfd: Remove DUMMY_VRAM_SIZE

Remove DUMMY_VRAM_SIZE as it is not needed and can result
in reporting incorrect memory size.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 3dcd8f8bc98e..49f40d9f16e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -30,9 +30,6 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"

-/* Fixme: Fake 32GB for 1PNPS1 mode bringup */
-#define DUMMY_VRAM_SIZE 31138512896
-
 /* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
  * GPU processor ID are expressed with Bit[31]=3D1.
  * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
@@ -1056,8 +1053,6 @@ static int kfd_parse_subtype_mem(struct crat_subtype_=
memory *mem,

                         props->heap_type =3D heap_type;
                         props->flags =3D flags;
-                       if (size_in_bytes =3D=3D 0)
-                               size_in_bytes =3D DUMMY_VRAM_SIZE; /* Fixme=
: TBD */
                         props->size_in_bytes =3D size_in_bytes;
                         props->width =3D width;

--
2.35.1


--_000_BL1PR12MB514404816E1E09722C049191F755ABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mukul Joshi &lt;mukul.joshi@a=
md.com&gt;<br>
<b>Sent:</b> Monday, June 12, 2023 7:06 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Joshi, Mukul &lt;Mukul.Joshi@amd.com&gt;; Kuehling, Felix &lt;Fe=
lix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Remove DUMMY_VRAM_SIZE</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove DUMMY_VRAM_SIZE as it is not needed and can=
 result<br>
in reporting incorrect memory size.<br>
<br>
Signed-off-by: Mukul Joshi &lt;mukul.joshi@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c<br>
index 3dcd8f8bc98e..49f40d9f16e8 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<br>
@@ -30,9 +30,6 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&nbsp;<br>
-/* Fixme: Fake 32GB for 1PNPS1 mode bringup */<br>
-#define DUMMY_VRAM_SIZE 31138512896<br>
-<br>
&nbsp;/* GPU Processor ID base for dGPUs for which VCRAT needs to be create=
d.<br>
&nbsp; * GPU processor ID are expressed with Bit[31]=3D1.<br>
&nbsp; * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GP=
U IDs<br>
@@ -1056,8 +1053,6 @@ static int kfd_parse_subtype_mem(struct crat_subtype_=
memory *mem,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; props=
-&gt;heap_type =3D heap_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; props=
-&gt;flags =3D flags;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size_in_byte=
s =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_in_bytes =3D DUMMY_VRAM_SIZE; /* Fixme=
: TBD */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; props=
-&gt;size_in_bytes =3D size_in_bytes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; props=
-&gt;width =3D width;<br>
&nbsp;<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514404816E1E09722C049191F755ABL1PR12MB5144namp_--
