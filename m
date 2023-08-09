Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8089C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 21:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3CF10E12F;
	Wed,  9 Aug 2023 21:28:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BFE10E12F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 21:28:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZneo5VYON46MVRqw+zk7RtvENfatB4acG8rURNV6jk64KYUb6Gc9/lpozhvu5m1ondrlSe3KnNeEXU9usaJL25/X+zrULTJBf3X/B+aPSMM30aR58RX1khxFgmqHfR1tBCrKFu0ltJejDVMK8ZYwAvwBBgk7p3DIX45AqxLUwI4d+wXwMoj2FZRUlp6I6IBci89A9R8+c5DmHDZOyG4cshh+84lKeWkqoY6O8iF+xyq0X5hyh2XRvFSlVktYonZb/F/wTs6qNTT36lRk3M9X4jWlLnaEW7oke9NWGRUYhKyNvrzwmnwhDWH3k3b+UuLIsvONqwvxULAVf5cTql0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy6ePzPDxJRtsuQxaN4ZKfI4Y1j8IRxXWZBvO4JzVmw=;
 b=W3crscsOmYBDo49pjDQZP0BZHiQu3019D4KHBd8Fsme1Pzrj4cggTWvfA8OCxtII/kGGWZrarFGSk/m6imsd40F2ah8PYS3pr+QtMPKmJi8ihBzGWXeHugyG2bQ5hhrI0aefoYD7hLtMMiPrk0U/T5a4aF5H9I7C4t26GHWBt4/VmltVzqVKZw3YZqGOsSlpXC+N7bckuds4x5CTzKk6H+Eu9OgnimLj/otJAD5AtmG399J8R+a0hxvIY+xyhNn0YEWR3zEfruasq69hlOsjculPqwSGzxqZq470VqwsCl3seko/ryRt54PFjuKGCHMJr3GaCXx7AyBYLuy7T4/nug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy6ePzPDxJRtsuQxaN4ZKfI4Y1j8IRxXWZBvO4JzVmw=;
 b=SuMHge2PHLpK+tnW62MABKEFuEGk7ovFe4u6x15IYmVfQRvl5A4ZfXmBEMe+lRQVc0OlgblamfRQIYITCMBQeg4+CHgpNxdmf33jDZzlQqDyPdyqFsPtbHhUt7ly2giapxSPypkzibxt6T2w/ptjX8yFhtTyVLyX8g5UprnXdwU=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 9 Aug
 2023 21:28:40 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::858f:e2c1:3f1e:fefe]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::858f:e2c1:3f1e:fefe%4]) with mapi id 15.20.6652.029; Wed, 9 Aug 2023
 21:28:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add missing tba_hi programming on aldebaran
Thread-Topic: [PATCH] drm/amdkfd: Add missing tba_hi programming on aldebaran
Thread-Index: AQHZywg/omduURlaFkCXNN50FmAZLK/ieq05
Date: Wed, 9 Aug 2023 21:28:40 +0000
Message-ID: <BN9PR12MB51466E7AC5A55C6C025F26C8F712A@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20230809212615.137674-1-jay.cornwall@amd.com>
In-Reply-To: <20230809212615.137674-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-09T21:28:39.726Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|LV2PR12MB5989:EE_
x-ms-office365-filtering-correlation-id: ca52a9b6-2e96-4034-5067-08db991f99c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fpgUZj96AIboIqLpkHvG/0jf/0lAgvseqiourVRepkqruXmtyyEnz1I2AdkxvtgeIdEGhef57xTlAgYdUt2Pd9WvUMLymFTQlrftKZqmJIjOqbu1lO9OuSK3tfHek4k221dpHks93zJe+zNAFT62kWBbIyTxIvMziqY6A5cJri82gZHXUoHRvBl+nZ4zmMiyNKx00xPRUfukA29VFHOs8bxZ/qW3wz0buuOrXTd8sax0MeksrATy8DFdT0MnuMHOVIKjWVxAnxYARIe35VyfTUN59Wc2vwix+8GdcWWhw5JOzrquNEWtEBRc4smoFRYowiNL/+i+HvcEMoZCCVEUsSZjKNyNe3y3jSJEoJWG+N8ZJlbHRSPWjN3fYT8W/lPId4ARRBXN9rWpJjOMY5a/5wB/ssS3NA4casgDuNDkI1A5Ghzm2rFPbbrirlxyfw4n6NZNmMQ04bYvl//GEln39U7DTdHV6DcwOSC+0hbG4aqKCNUm6pd6nob+ZZIIoqeXfaeLK5LalACbt+sbjohIUue5Qw8BnA8S/dajNtNGUByh3FCU+QRwZ6q7UpwrZU5Cv3WEyqI2wfzP5ntwOgZ9YPTbyAMX901STEyZzjW7/RYEWsp7i6u8kthtkoGO8sQo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(186006)(1800799006)(451199021)(55016003)(19627405001)(66946007)(76116006)(91956017)(66446008)(66556008)(64756008)(66476007)(53546011)(6506007)(26005)(71200400001)(110136005)(478600001)(33656002)(41300700001)(316002)(9686003)(4326008)(7696005)(2906002)(86362001)(52536014)(8936002)(8676002)(5660300002)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTc9sCvtl7NSrxlYdxbf0gRSXTAyrOlGnV0nzAy8JEIGbgNh6is6fC3U4+j5?=
 =?us-ascii?Q?m2uaI+7SHccbzaNJXIklX0n/Azz6GmG9ZyjMsQHMNhEJ6/SpNyn6JL6ioUc4?=
 =?us-ascii?Q?Hj5hbYFpQc46IBzsSa6l3S5qjRoeD75M0iPLLZ+TWevi9V+5apEN8SsXDQu2?=
 =?us-ascii?Q?g8Q2gJpri+7WXQDhOeXrMnq85hY9C/0aF28wWw8A7+1Dw4a7oZqcQpL7wqi4?=
 =?us-ascii?Q?g8+2f5tP53LR0A00wRQR30z3141znESLufaJIVrkSnIfCkdVPC5bSVDqNNQN?=
 =?us-ascii?Q?tfd1Nv6tn3NkPPq9SS5dw1cLcEpSAgU9Mhuc66DIOxuJmtTTBPtxQVVlKGDl?=
 =?us-ascii?Q?blXBIeG8oy952rJNaFA470rRCNRMkyqIyONTQLlDAj/7UhnTjSX4LFgRDEqc?=
 =?us-ascii?Q?aT+0x+k3D3HqtVcP3Mce4PAOkWr9MNyETEg9lAbj75ez2GHYkLbMt4AQiJEb?=
 =?us-ascii?Q?oCw1ewPsdUwLhVmL7B8grchVvr9GUPKPdVnwaNihPZYCQr5iG7hA0d50WzZp?=
 =?us-ascii?Q?5N2BOI2f8YKFlQspmr3DgJfYwPadU0c4k30hv3QLcrukl+3mGFF/g5byIzin?=
 =?us-ascii?Q?OEvacsj9c0/isq7WLxy4Ja1GnhRxAAnVsMaAb4IAzOd1GqlSBRRn6agb0yI/?=
 =?us-ascii?Q?8ZS11apeIXNoT82UhikqF78L+meEehtJWcDJUinvYcCY0xEuE0HyOr1zltYx?=
 =?us-ascii?Q?7Y76nHSR6x+E2L3q3SJHosI6SJvI6C3X+RuIFqPeGLO/o4DCyNjguUngrUw0?=
 =?us-ascii?Q?z3ldLsLVaIQxQgPeCwh6fZpyF0HL18sQgPr7IWhOt3YcS484Kvz9iSDxGuH8?=
 =?us-ascii?Q?3VTSfIWFQngZz7Pdle2WBnLHcCXTyyD1wSLcGY0pXqiS/fPy52MsVoHRzzfy?=
 =?us-ascii?Q?cIK/KxX+XjZU170HGwCLzn7d6mPxmhCe0lu8ov/Xbb8o0ZDs/Wl15CXTX89I?=
 =?us-ascii?Q?ePPAoEvTjnXlycRiall9bH+RGXnHU0nIA3SMPNLsyLPMlinzc2KtswWJKr+P?=
 =?us-ascii?Q?9efNP6Sk67Bjm4TNgTfa28Q9x2wBcHdK3eaUAqTrVRfWHyNWq1xmz+xuwB5f?=
 =?us-ascii?Q?zc98jcyMlcWtvuwuOz4NJN/GXZFHVGaZZvOyEAKt0kKnRmv9T7KWJxlF87hn?=
 =?us-ascii?Q?IAkwo3Jd5IobRXa9kcR/FWndVgRzvkvns58oDZU8GeZBiOLavqOFFr/Yc5eb?=
 =?us-ascii?Q?R2IufTmH+YS40dWDsfkrkqHJahGHIk9eh8cZ2p+tWXl8ObZUxcO9xSIiXDFs?=
 =?us-ascii?Q?3UUqEJo+M7zXGJOvHMeT0C+UEV8ui9FrM3Gv6cQk+djyDBQVqSzcQHTvkqFo?=
 =?us-ascii?Q?t/ABwE+MhkM3k/YJu81tad2WsbaeDswPPkAoUKJDXC/OOM69Lo2/23An1rRC?=
 =?us-ascii?Q?+btafTgc+C1VqvWI4m7N5L+RDXaSFil2xQw4EPN6lg2rFFB20kgbCP2xRF8V?=
 =?us-ascii?Q?E1H1qG6LVd7SjvKDAENDWNXpvBpAk64V3UqSYXTTAubbhIcYj0H480Q/2oeT?=
 =?us-ascii?Q?iFxlKKqWgxskd1nHtg50KrT2aXXT+nYAx6H4g8ZCV9RiHhJW4aTf3TV4a5m2?=
 =?us-ascii?Q?7DZr2vIROIKAdzKe2rc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB51466E7AC5A55C6C025F26C8F712ABN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca52a9b6-2e96-4034-5067-08db991f99c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 21:28:40.5673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Z77FhrzGJ0uP0tO9jrY7Xqq7ZCwyDMUZpUdsN5zoVWH41pfRkAYUXOH98FXVfMKaWHFTgHF8wTMV2YC9uX4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB51466E7AC5A55C6C025F26C8F712ABN9PR12MB5146namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jay Corn=
wall <jay.cornwall@amd.com>
Sent: Wednesday, August 9, 2023 5:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kasiviswanathan, Harish <Harish.K=
asiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: Add missing tba_hi programming on aldebaran

Previously asymptomatic because high 32 bits were zero.

Fixes: 615222cfed20 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM h=
ole")
Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fda16e6fee6..8ce6f5200905 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -121,6 +121,7 @@ static int pm_map_process_aldebaran(struct packet_manag=
er *pm,
         packet->sh_mem_bases =3D qpd->sh_mem_bases;
         if (qpd->tba_addr) {
                 packet->sq_shader_tba_lo =3D lower_32_bits(qpd->tba_addr >=
> 8);
+               packet->sq_shader_tba_hi =3D upper_32_bits(qpd->tba_addr >>=
 8);
                 packet->sq_shader_tma_lo =3D lower_32_bits(qpd->tma_addr >=
> 8);
                 packet->sq_shader_tma_hi =3D upper_32_bits(qpd->tma_addr >=
> 8);
         }
--
2.25.1


--_000_BN9PR12MB51466E7AC5A55C6C025F26C8F712ABN9PR12MB5146namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jay Cornwall &lt;jay.cornwall=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 9, 2023 5:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Cornwall, Jay &lt;Jay.Cornwall@amd.com&gt;; Kasiviswanathan, Har=
ish &lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add missing tba_hi programming on aldeb=
aran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Previously asymptomatic because high 32 bits were =
zero.<br>
<br>
Fixes: 615222cfed20 (&quot;drm/amdkfd: Relocate TBA/TMA to opposite side of=
 VM hole&quot;)<br>
Signed-off-by: Jay Cornwall &lt;jay.cornwall@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
index 8fda16e6fee6..8ce6f5200905 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c<br>
@@ -121,6 +121,7 @@ static int pm_map_process_aldebaran(struct packet_manag=
er *pm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; packet-&gt;sh_mem_bases =
=3D qpd-&gt;sh_mem_bases;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;tba_addr) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tba_lo =3D lower_32_bits(qpd-&gt=
;tba_addr &gt;&gt; 8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; packet-&gt;sq_shader_tba_hi =3D upper_32_bits(qpd-&gt;tba_addr &=
gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tma_lo =3D lower_32_bits(qpd-&gt=
;tma_addr &gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; packet-&gt;sq_shader_tma_hi =3D upper_32_bits(qpd-&gt=
;tma_addr &gt;&gt; 8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB51466E7AC5A55C6C025F26C8F712ABN9PR12MB5146namp_--
