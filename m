Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8FEEB64D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C70610E61E;
	Fri, 16 Jun 2023 13:34:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE5B10E61E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 13:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHaJRwIOXvZiILCburq8m/O/cBYvMUi8zmJdwjUF1/HLvAxWag3wtupm2luOLrSXkQyDRBXytMiwgUEzqhEs3Zj8oKZSlfnEBlDDN5Na/3GdOihJM9Dzn9WNLTS3eYC2Wy9gurQWvLPqN5j75rRrg+s9rRzClX9GfWigBeiWT+FCfxMFihJhfqsXYQLF4pE1EjVob/Vi5iYd1fFNrp7j2n4+ydpzqyHMMWs6E8jvPQYs9K7cF3tA90sgeitwzi1DFK/npmOaReiWJnBgnXT0A5fhZTSvgRaFQV7oSKggCST/i/Sy06Xp/+G4S1goQjCjT37qRz3VY4y2EoL0Bdexfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjJyydn/ayBBcxxdsZUf7pRl3LpiRCc5b5IeFSom0dI=;
 b=GpBxmQtjMWnr6Va0VCgzzedsPeEN6KyJYQfNHWxfwfxWjJwMVGTAdJLIaaWsBvFTKL5MLqKs3dDThgDWlvKGDyGBdQqVyES3Xqr7os7Hbvs0UKLgx/0Be9/IVk9T8k+X4/SjtiKHoaxrWJBLRp4SzLDojIbu9AXvf2+VnLTu1OEePAuBY2JZRlt8oQz9cXbalOsAtG1xjgE4sBzVe7/LesNUckIREV2zLVUlwDMgseapfBRueMexx/TIAcQhfIeASb5Z+iJvOCl3KFh7lzRHKb3JQUNsWw/EfRxFkY2oO7h2pk0y7mJo4GY/4RxwCGL16j22gQuowLYwlA4zXiyZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjJyydn/ayBBcxxdsZUf7pRl3LpiRCc5b5IeFSom0dI=;
 b=aN+PyUZ5W4/i/IakaytS8shsH9loUlzcPdMIi/vEJoDuHwlB1jS22p46sx9kXlqwQLn9UqCld+rmxTAA0X+fkYeZi+Y6kjdea/KT5D7dLiTdrKUMFZIBn3lfpAGbYADrbS0Ban69V2L7pbIC47IkfdXMOUbx4tGx+HmWeRJZgds=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 13:33:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 13:33:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Modify for_each_inst macro
Thread-Topic: [PATCH] drm/amdgpu: Modify for_each_inst macro
Thread-Index: AQHZoDyq8MKdFIzy70qysYSSJtZT2a+NbdKm
Date: Fri, 16 Jun 2023 13:33:54 +0000
Message-ID: <BL1PR12MB51440109FB74A8CBDFC9C2EAF758A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230616102340.1665822-1-lijo.lazar@amd.com>
In-Reply-To: <20230616102340.1665822-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-16T13:33:53.911Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB7020:EE_
x-ms-office365-filtering-correlation-id: 917228f6-700b-47d7-dd6b-08db6e6e54b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTWMnGI+Budw/c3jEjA6yUqxpsNcVv0gN9Y/bFxO50L35s2b0gV/NHx8sBdy/U3ZmTYoTmsr5H5SDhPSNHKd3BAGd9cNaLP34HhO1jb7+lQVpWFuTB9VI11FxxmL+21tX0TS7gWs1ZpgCxagrGg5QAjjEpP0cUYcHLLE7jswn7CdgjiTzOKf9x43q5QKzLOMDskPVsbyVDr4vJ/dgjOkOW66ZHcXQcBStRA2341WXpQXWg2oATky+BWEfCRby01CXn+JnW+3apKVdw5AubW+qpHxwLhKZdx2+rX37U8GaBY5kSQJr1L65A5Mrq9wTefPqq94RSgbvIxDKoD0ExxHZNoDZMdcW1vd0HckuciHO4qdpPi8ibGOMQab3yB6KyYxjEuy+3rGl37faMuktrNaUpRiQoBhR8Vc3YtuXjSBNh6xj7uqCym6RC0rBzYd5u0hUd/biVQFzHJYJ5LlMwqTTE6kIAJ/wjDd1WwiXSreVYgZv8s6AmFEdYGv5DspfjcpKak+Wd60XxvxxfV9OCDgtQR4fw32njqTMbmvdU/96BWXzrKDlKvJ6zav1mvABpi45kHm8HmD72s88rOtzIg3XmFaMhXwiFT41Eh0iEdVTwF1d8g98MlbRH+qNrG8OkwP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(86362001)(38070700005)(33656002)(54906003)(110136005)(66556008)(64756008)(66446008)(66476007)(316002)(4326008)(76116006)(66946007)(71200400001)(478600001)(7696005)(55016003)(52536014)(41300700001)(8676002)(2906002)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(9686003)(26005)(53546011)(6506007)(186003)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xsB+uuWuqeJDGl8LslnNdpPs0Ki+0ZbU6R1K/oJKhjt05TC51MqnR2IOURAh?=
 =?us-ascii?Q?sRbr5+eSYlT7+5br2OdiVtZPwFfkdyvauSZF9mL1yOaocrwDcRcue6+MM4SQ?=
 =?us-ascii?Q?epyrvfG/4M3F+CHLCMxoO+eDe1+bTe4Q4RRZ9ZBq/esZMupzYrME1Bsopn3d?=
 =?us-ascii?Q?KoyyIxz6MLNo4/JtY78XczkBrcNtA8/ppYDBgCeDmeXV66UXa7Z8BHxq7oJH?=
 =?us-ascii?Q?e7n3yMNc/naQBRkiXLmSGygMDPgO9ErrYkAnMgq9lAWlHMi6FapbU3g9Wm5b?=
 =?us-ascii?Q?3YsT6g24+HaB58P3tG1N46GX+OY2s5OB1fnz8qRsM44QOL0jE177ObsHIw4L?=
 =?us-ascii?Q?TE8G3nwBYPiRt6QE2XvfHOhuBEed62T8ORKf4vShg376uw9L9UglrJuzW+yE?=
 =?us-ascii?Q?ak9IW8C6067r+D2hSytKVDWDWgCjznsnSyGGbSQ4wefTeP9UNZ0+6HzsCLr+?=
 =?us-ascii?Q?lfS2JG/Zx98m0pUuJXSE5G+GkWepREqVk7HNoj5xwmSWVLOfrWUYwxsTaKY5?=
 =?us-ascii?Q?9RcNpIqXB0jhrZIGXuXlxizYDl/yV1Tq9C6DGJ6bITKSGzUbJpaZZpjpE6wv?=
 =?us-ascii?Q?C4yTJCgf5ihT+NPItHM5sU5+3bxic+pC4S9e2fYvJAJPocSQ2fXBR1sxiIpV?=
 =?us-ascii?Q?RfI0To/VKnnJHyxlE3TYmB7IHo0cygvpTX97vgPPuc0lhFZMdDrWO4ITmwIu?=
 =?us-ascii?Q?s0KXqnoqix+pB7ondk2/6WAusi7/FRet0TuEuzyKg4lhrHE3v0WzSKmVfr/6?=
 =?us-ascii?Q?hT2eluyJS8wksWjpuDTWpnM4KPpFl+Bq4BA3QLZBWG57GP6/DJxztmp1d+GK?=
 =?us-ascii?Q?s4wllqPBL8ADFIr20a0ge2e3a/uLSdPQRlUqOe5uZXI5npU1rtPML21AJCwv?=
 =?us-ascii?Q?XtNESOCnQKO1vg8ZVN+qRnB/GzhaeAlPmb249PsQ3TpvfEfwxcvbYm7MzMg0?=
 =?us-ascii?Q?46c2CvB+yr/Mopk8wP7M2HKpCQ6aIdDR07p6d1QmZ45778OOOuOWU5lu3/f+?=
 =?us-ascii?Q?sy23mRU3069jOkt73aI2lQFINnpvGGtB1YUMFuaIbRJxoGEFeX/QAHQ7j97e?=
 =?us-ascii?Q?DmyIQgsd6FQwMV4pLL8tj59Yc9Pv9amEd4YhN6iGgno5Ucii3vjGmQsLWqiW?=
 =?us-ascii?Q?4ZMdQrE59Ur10FLAW1dlwDBVqY3QaN/zZ8avoOihZvjLKI+tOHQtKkM/oq7M?=
 =?us-ascii?Q?SZhUeg8sw2mr3ZFL5/8e/7NCOwEhK2FFKAb/Tsbft37KCYpIZ4y6rsY4HYql?=
 =?us-ascii?Q?FRCSAyRsvJDH1Re626tJRaO5259HZ+m028vnPmhP/fzXA4l/cocl2cmkNvoF?=
 =?us-ascii?Q?TZxmMeqlcBWQ/fw6k0zdKAHmcUbFqD+59aXCFuPZJ7L87Xq1tFsJyvFQx2BG?=
 =?us-ascii?Q?LiKXWgRvq5lVlXjUEyOJ7uJetJRUTDJqg+Ua/lyKtlWEY9F6L8QU0q9tsHSb?=
 =?us-ascii?Q?XnLVg+FNjw7YkoGEMb9I4S/fxCkOXIvErTcRcb1PBYlcFRwrM5UiOnYhfACp?=
 =?us-ascii?Q?ZA7ns9hGw456nY/LiI/7ae0AapGsp923VSNaTWce8+/r+6fI1k1n6yK11w6T?=
 =?us-ascii?Q?D/OneCYpx1JrTOplxYI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440109FB74A8CBDFC9C2EAF758ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917228f6-700b-47d7-dd6b-08db6e6e54b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 13:33:54.9530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCYwSCpb6LYlt1b7OXP637f7Nrs6oTpOGK/4Lxct9tOLcXWMT1QDE7qEgUjDXTjlYTgouWZAza9xk/aIZMFisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51440109FB74A8CBDFC9C2EAF758ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, June 16, 2023 6:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
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


--_000_BL1PR12MB51440109FB74A8CBDFC9C2EAF758ABL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, June 16, 2023 6:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
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

--_000_BL1PR12MB51440109FB74A8CBDFC9C2EAF758ABL1PR12MB5144namp_--
