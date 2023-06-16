Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301FAEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 15:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5955F10E089;
	Fri, 16 Jun 2023 15:28:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E703910E089
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 15:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abnmGH3Nt5arF23pTXj1dfmgFm0lt9k6zUCZ5TG1hx47sErwwS+wrXYdEchBro/ayTPnBy0UlxBef4HzJgNYB3gBHcffW49do8yyMNGOKMyw8+zlZL2rEeJD1xCqnPQ+YJPm4gfc06qcAU8xUf9/fpb5vxg6Nz788MpABV5iAnoDU43ooxei/p17nYTJtufgySIdbcurlvg5YMYSvfqROTPsDwaN74rRfEwmNZixroMnzhaRFPs8WvrhSwmJ0qeUKHtMgRhGv0ytLSOpDNKolFqGnbvB+kyqIP7/cwzwfXLieqHtuW4KXVdpl+JAA/mHBsVofdI9KLIMAT5CsBywsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2muub0izgZa5RsV/YxFpYB4wAx/VSXf1HS6To4Tc6sQ=;
 b=m7jyPdjlBS93y3UGx0RP0UTQWK3JmIBCaZgcPj5Lk51nE21oNoXewW4QtZlUSHph6XECDcUM5VfrG2MNCnMx2xS3KNRwZ6Xi/pQNqYw/cwHAIenBLsfz6SKAXKSX8dHjeEDyTBiZiMRTQApXtv5pMDwjYQf8k5Ibn05eau5XJZhuXP00eIqS5wJ80LpLJVu5+734tufqOFdkVY8MfSPSP9JVIn+AGzR4G8kKbQmbAYnl35ncZDDt/zNkgrBH8gsEX1/HzPljz7pFgkUzmTJNK8agEwO0g36xHIPdLy9gJ6dsljwhe8kieuTBn8feWBF5eOO4wJt1ZgmKwrTIN9WAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2muub0izgZa5RsV/YxFpYB4wAx/VSXf1HS6To4Tc6sQ=;
 b=gLwBXja5m0uNidZ3MavSibjIIV5FV9FMKIZPPYW4sD+3uHUz4cV/KG79IyS6anbCUXbrs3kxUYFoTyhBypCA+2X9TadKAVem3D9QzPhnhGZ05kAfzx8YzJ2xONjgwlI2O1ca8/+8fc9tqDzezpbCjghVKftx6t2PV7ggDlcGk6w=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 15:27:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 15:27:57 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Modify for_each_inst macro
Thread-Topic: [PATCH] drm/amdgpu: Modify for_each_inst macro
Thread-Index: AQHZoDyegAPsujx99EGvvlZ6GhHfHa+NjYZv
Date: Fri, 16 Jun 2023 15:27:57 +0000
Message-ID: <BYAPR12MB461498B181C44842783B77DE9758A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230616102340.1665822-1-lijo.lazar@amd.com>
In-Reply-To: <20230616102340.1665822-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-16T15:27:02.6421416Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|LV2PR12MB5822:EE_
x-ms-office365-filtering-correlation-id: 772a6a60-0ca6-4bfd-29a6-08db6e7e4312
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EDjxWWCy1nQCT2Fv5sOloEGSSNuvA5e6tejks1AY+2+CjTE7mdXUsSJGJH9JH1xGNitFXLYltTrCPWpagCXOpCkwRVIvkjTZdJpNPdHnaAAcIGCuy0eNVRsps8/pqHJcByJvUDj7Ipe1U17C1QA9wGsHbmK7iTLEKMIdxuKACH9yTYGcuM3+AlhKJbwns5E3+pPrFDS+rQ112/gdtYzDID8CVjXJdA3dSBfvrTZx/V0SQXdFES/GPuMGatUIx8o6uf2zeLeFVT41Wu49U4R+GNGvnQsAtkai04MInjcP02l7D9bRWqHSU/SRnD330Du6PSNtHfqwvNLD61qbQ//O+9jH2kut57xnxiLPZVMhnUQn53xs9nOAJU9x6UxqeXoEjFJU04oV4aUxWU0oJ9o46ietk04TpZ/dMTEfGFWSzx1evfDiX0ASjRpBFe68ixEUhRJ5lu7YjUgIjvPnCfTw+ytm+R0PpqEASQozl1U5+M0BYh8dCKKTtjjlko5h/WiokeJiscCgfRtOWpfS3wpYz4o5NlVEdg0/+ogeYTvk6aZtQtY22JR8RkalgFaBly4tyRCInVVVbNBH+rS0NyEXysmoUU7HtLMrUh/vxwKjGoHJUyPLVdCDMzC5gvXKAuxt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(5660300002)(8676002)(52536014)(122000001)(86362001)(38100700002)(83380400001)(8936002)(316002)(38070700005)(41300700001)(66446008)(6916009)(4326008)(64756008)(66946007)(66556008)(66476007)(76116006)(91956017)(54906003)(33656002)(186003)(9686003)(53546011)(478600001)(26005)(6506007)(2906002)(7696005)(55016003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Go8SbYB7dk2WErq6+hVViHkOolweclcxhii+7hf6oMfh2QBO7mbLce/ggAvu?=
 =?us-ascii?Q?gWtaTVLv2RBROBTgTwZiZvRD7ca/7lTrtvpv6W/wEH+XBOEyxCgGg7mN2PIx?=
 =?us-ascii?Q?L2v7RNxlWavXR/dWDjwJa59lUPeluNQJYpar8ezwW1wiX2wRSZeFSKMCJVLe?=
 =?us-ascii?Q?sUuHmlUVQZvaiEeJJ4v3uLxf7uyCJ0sja1DHlKGfb8Bj3pZo80sCGlRP7BpX?=
 =?us-ascii?Q?N93YkK68np3zKplvhmVGZv5ZfAB+Fb3bT93S4GLWXOabkXJ+x15di23uJLHK?=
 =?us-ascii?Q?CCQKQwxByLindGzZT1ZItgky9oBQJGELMomjjjz5ocGqJXmxx4NDUTrGdm8N?=
 =?us-ascii?Q?0/3WkAoTDp3u9fEmMIFWZsBs5lk6g8oALEOAkMYdkQO7x4iIqZcNxHg8edne?=
 =?us-ascii?Q?qUicEqDH1PcD6ZpU25QdFMvDAtFD+i/Cd6Fhj4PqOYLAuV3ivi/a0BnloK+l?=
 =?us-ascii?Q?vy9pbmmRKnfcofeIGg9/exP3gJVEt+pf13pTRoDtsYLX7fZa1yl7MQAVPShs?=
 =?us-ascii?Q?h2uclj+Ree7tkzkP2hpgGGLK17yjOojDsv36OsZyavfKlKU87C/7P2AUNez4?=
 =?us-ascii?Q?65SsO4Dc8cpHhPSDjQCN8mP4JAMAj+uBZxW8yKxqKA516BQ/Ei8wJieilF57?=
 =?us-ascii?Q?o8/ATpZdNA6ZZx4N0n/drRksCAuYR9vcaP0+geVX0FjZi6jT9Pl3oTay7QhU?=
 =?us-ascii?Q?hT47MdZvMkqF72/VibKRiWzpxTPOFmBkUnVIm3CXFuL3bcxd/mtq2bOhH49U?=
 =?us-ascii?Q?HSEabfZA4YLpTmw/rmgUZaMdDoQt/yuefSoCFCQRnjBqUrZE8oRs34vsBADy?=
 =?us-ascii?Q?RntQnDukEMklvXt7D9X9QMWAXMEDWZzOxx/JseWoDTRBUMXy0JsLUFpvjSIR?=
 =?us-ascii?Q?CBr8dVhSYrwHHtge/orlYLUPy8sm7VhYTJBk3m7PVWHxGFiQtMCttAaUsN0f?=
 =?us-ascii?Q?kwQ3KBs7ocSKEHTDwDp2Om10YVSarOd6oKTKY3vBVJ+I4h/aXjndQo8Op2mr?=
 =?us-ascii?Q?ehBMHZJgVlsd25HnP58cl2SWL8FgGqdPWVuiozXJigN3APKGI2rhKWbb+dnS?=
 =?us-ascii?Q?0OdbQBhYpJX1idlVsEHvaSUYYQ1IK5+70B9GOXSeg1TU+BE2B7VaOg6RlEPC?=
 =?us-ascii?Q?XiPYxLq8a2PDyainYorfhc10JHlrHpuzMQHp8aOEoqkuQPUxgdF/dvPMsE6M?=
 =?us-ascii?Q?HYs3ix50ehG3Rs6SgM6MKk1ogrTf2bzN1LaYAANTnqUyo4TvN5xZKDIcC0Lm?=
 =?us-ascii?Q?49HtwGiciV1s/CWqBub0mtr4Bu7Il9kYm00HeyBHuQQ7NqWCfSY5FVTynv5a?=
 =?us-ascii?Q?BounozMf7jNDLVzjEdYO65r9gsN7knV38GhKYx8n09/clJAcNGqk8MjSGIH/?=
 =?us-ascii?Q?34UuUe23yh26BhEKYf/99c7ufxWlHtmH+XAFF4PUmxw63LGkp2vi9NOedkWj?=
 =?us-ascii?Q?BUy2Y/vKBpzEWp37Rn3FRm6Ja6LwNZ90hHxmHLwuludo29nZYaava78lHKgj?=
 =?us-ascii?Q?sNQJTpX8aTJHymTOuQ6T/sIq6KjMLA6E0+TgGwZdDXWbqkQhW18Uqsa04bNS?=
 =?us-ascii?Q?F2EHHiUWeU6IiD3Px2GzzIopwOlph3+Ad1/ngb70?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461498B181C44842783B77DE9758ABYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772a6a60-0ca6-4bfd-29a6-08db6e7e4312
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 15:27:57.2910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4euFiMxPPb8C4qxj71MQvkpx3ECBrzhef4Fv1V/VCuGrrsjRw3UEULI5Ip+TEoMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461498B181C44842783B77DE9758ABYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

cc: Victor

Victor pointed at a shift beyond MSB condition. Will send a v2.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Lijo Laz=
ar <lijo.lazar@amd.com>
Sent: Friday, June 16, 2023 3:53:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Modify for_each_inst macro

Modify it such that it doesn't change the instance mask parameter.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index f4029c13a9be..c5451a9b0ee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1295,9 +1295,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);

 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter)=
);

-#define for_each_inst(i, inst_mask)                                       =
     \
-       for (i =3D ffs(inst_mask) - 1; inst_mask;                          =
      \
-            inst_mask &=3D ~(1U << i), i =3D ffs(inst_mask) - 1)
+#define for_each_inst(i, inst_mask)        \
+       for (i =3D ffs(inst_mask); i-- !=3D 0; \
+            i =3D ffs((inst_mask & (~0U << (i + 1)))))

 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))

--
2.25.1


--_000_BYAPR12MB461498B181C44842783B77DE9758ABYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"" dir=3D"auto">cc: Victor</div>
<div style=3D"" dir=3D"auto"><br>
</div>
<div style=3D"" dir=3D"auto">Victor pointed at a shift beyond MSB condition=
. Will send a v2.</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Lijo Lazar &lt;lijo.lazar@amd=
.com&gt;<br>
<b>Sent:</b> Friday, June 16, 2023 3:53:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma, Le &lt=
;Le.Ma@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;; Zhang, Hawking =
&lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Modify for_each_inst macro</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Modify it such that it doesn't change the instance=
 mask parameter.<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h | 6 +++---<br>
&nbsp;1 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index f4029c13a9be..c5451a9b0ee4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1295,9 +1295,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);<br=
>
&nbsp;<br>
&nbsp;#define amdgpu_inc_vram_lost(adev) atomic_inc(&amp;((adev)-&gt;vram_l=
ost_counter));<br>
&nbsp;<br>
-#define for_each_inst(i, inst_mask)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D ffs(inst_mask) - 1; inst_m=
ask;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; inst_ma=
sk &amp;=3D ~(1U &lt;&lt; i), i =3D ffs(inst_mask) - 1)<br>
+#define for_each_inst(i, inst_mask)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D ffs(inst_mask); i-- !=3D 0=
; \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D f=
fs((inst_mask &amp; (~0U &lt;&lt; (i + 1)))))<br>
&nbsp;<br>
&nbsp;#define MIN(X, Y) ((X) &lt; (Y) ? (X) : (Y))<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB461498B181C44842783B77DE9758ABYAPR12MB4614namp_--
