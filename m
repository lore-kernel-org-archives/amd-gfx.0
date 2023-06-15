Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441DFEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 22:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5406310E566;
	Thu, 15 Jun 2023 22:58:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4AD10E566
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 22:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeeTnts+qFpaz8iDB8lP+fZGWiMzMl5rjChVsTVQG8pMyRSQF167Wzbu5CUifnwRwUIK2mKKkmroz0Ov/MackXFrDH4Tm5peKxrIzkC8A72o+AnOWImUB4o1/BK+u91/Okqr7v4W1cG5a3aNhFA1mI5plj5XGDlrjri+4FMN4Via8oVgg/HliEFPJW++v6URDEbpXlN4ybAfOenNUH6LTIUsz21E4IE30PXIyICVS4S25cbh9/pX7/eu6FE05D2UL8cuijLe4lqnxlNVc/UpoNIPDNxYpBP10VwT7ilIEa4me4WxCLQ/B2DSl6IQPdYNySGop0CMIgwWoMPd/AaGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7oL1b6iQXAuuPSIZCpcjwZTesDHglMn0bNGMvVEdsM=;
 b=ORllOgZOF9cMmtH4m3yNbYeYvCw4zq2ZXzIY3IA5A8iIv960vYiNwfUMcNLHH86H/p3FAEdhxp+XgQcnvaEdYY4SHHhoRlhprZP4e9fThi+k4Wx5fDt7029O8GwiYafJn+DDEi2LV1M4zl/uCRD84FmtaejSBmGsdvrlmaezFhlr1reb7WyVfDbbnt9E+N5eHpwn3ehDOnGwsZQrFYYUfROe0VKe7MBhc1jAusBwD9v8smawHspBl4y7LoL9i7CDL+Fr3EwUtiVogCK542gUsp/CS4FWqODXmdqVXzhrDsFUqIDJNHmcygs/z8+UDZ3aec3r7cu3DPgy/z0B44ubyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7oL1b6iQXAuuPSIZCpcjwZTesDHglMn0bNGMvVEdsM=;
 b=s9xzOBkQN1rmrGoZgXftd9HMUMTPsexp4WOCJan3fmxIb9xRzsxqaysaklubMeWedA4ln6LRw+a2Fe1fsG+6ePfbJSCuOnf9O8c8z6OFryqCWrcwHb+Q0gEwKzeYoB/JIA36ttjqxiKF+gXwfxzT7vl1BBDnpRb9Cs9b/aXBwng=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 22:58:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 22:58:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: fix LPDDR5 width reporting
Thread-Topic: [PATCH] drm/amdgpu/atomfirmware: fix LPDDR5 width reporting
Thread-Index: AQHZn9akGlzz662m50W0q88zM9ZlpK+MeeFs
Date: Thu, 15 Jun 2023 22:58:43 +0000
Message-ID: <BN9PR12MB52577ED1CF427F6C0D6102E1FC5BA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230615221317.3795214-1-alexander.deucher@amd.com>
In-Reply-To: <20230615221317.3795214-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-15T22:57:36.7767007Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM6PR12MB4925:EE_
x-ms-office365-filtering-correlation-id: 798117cd-6371-4c36-b9a2-08db6df41167
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6dZpjGZy6gnGNraYA0oLCJD/zX4CQ/0ECj4xPb73wGqRcF1t/bqezzNGgpOc/kCiRYImVewLDMn/wCfyhbwpSpNfPuSKzn2K9l6zL5/az6neo1A02s8BNBPbnrPMLR4/8McNB7cLpDilhE9xxcZzMo2l8nt3jEo03A5btg0F7JnKR4OiPH6xt1Ls103Sv38t1Rak9VoJFqZG+n7lcYnbiMDLFkxAKa9ak83T56b/xl0FbGp5kC65KLYc+a4MDQRDpOpe5E0rV6+7Bn0eRavFXVc1lDj6lfRwX8oQPBxRcg2T91oP6D7SPxj8SkvfTUF/6WUdlU47y3569z0/m7lpWyMuWAziN1J+qk09G5gCpHHMyuwDergVdaZ5OFlPDCvb8On4UA0HrvxH2erHDwfnc3lm5LMZuQlBMdoj2yDIZuId0VTlABRs2fxC+bUcWPYQTpEa2zdv5cZT5xFaLoYcb/+S2XPGgz746Tr5hsJzjJpAiqGu1nWmBwzpuxIw0xsYxmpW+3nOlYNwgR2bBycBcV2lReL7IVi3BdzWbuvHzA72x1Vj67ftFhm9d39AJ1ljjstMZPNcykqEovdxnvQWCq2v7RELiN1itE/+4tRdJQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(5660300002)(83380400001)(52536014)(186003)(55016003)(6506007)(2906002)(966005)(41300700001)(8936002)(9686003)(7696005)(8676002)(166002)(122000001)(110136005)(38070700005)(316002)(33656002)(53546011)(478600001)(45080400002)(76116006)(6636002)(66556008)(4326008)(66946007)(66476007)(38100700002)(86362001)(66446008)(64756008)(91956017)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bHrIWH+iJzZ6kF/KCQcHDnX6qFbhRu7ChjhUsSsf8BpPq1RIgh8wnsEMHfqn?=
 =?us-ascii?Q?u5ZeGxePK/u0FB7TZwev/on1btcOG8wTwtLuHCrdcDk0e3co0yc9smOa2qfD?=
 =?us-ascii?Q?/I9Bkyd0e7ii+pM1x1i+ocTzW9sseF1C0SE6SvojWzhc0eUimfuO+LzxZfSJ?=
 =?us-ascii?Q?2mU+S74lG40omnxdfrxhw0QigKCZaTisfPIEE2YyfDNuhmwLz3eJrBbEGIEq?=
 =?us-ascii?Q?Qob28pnF2fJYxR5f3fpr2854CzuKlgEX46yvLyz3pt039tlDXKWnS3gxb/rz?=
 =?us-ascii?Q?qMkE+89ACSf0j7GqljAS9FeJVQgmxRbx+vSGIitsHHmtVCE7rwhOeKk6Ivl2?=
 =?us-ascii?Q?aDdmOnGNFOgQletB5et0eVsLL/oMot/vnFiPv16ZEcRxCAx4HWSGf5Dim8lx?=
 =?us-ascii?Q?xbLQf0sEPnPWBH9WSB+rpzy33pzrAqCuaIqnn327lhkeRPV82z8Hxwb/8xaY?=
 =?us-ascii?Q?BenQLZzErGO2WfREjslJqGSp2i1mOmx3NILDoKTgYY4i9nOcNqnmAvEMWUWj?=
 =?us-ascii?Q?6b0SRKOlvB8symv7B/D7q2mt1/Jy9GWsfSCwCHn/JEH/PwTQwyQJuoX6E/ag?=
 =?us-ascii?Q?wkFCa4Tvpm6vHSriU+fDyh3gWrz+gacaMK3wM4n/QrXUybb5bVSkq266CnRW?=
 =?us-ascii?Q?zTOewCpWjAVDwmmpDaMQfYmDGx5ZnrKkFAShhZJUx9fuehm6f/Wb++qehcA+?=
 =?us-ascii?Q?eJ95QAHiPi3Sh8vvqI9fGuoMS1XRm+saSwHYkYoo2ISuPppx0iQ5kDp9a8eY?=
 =?us-ascii?Q?klLsFQwJf/zquRIG8pg2hzpYlWpybxy+X+YZXRRPsj2pMrz4oY37K/mbZxnT?=
 =?us-ascii?Q?9++r9DcUuWLu9S/IaojfVlNbmYP42HqUjsw+mOgL0BgtNEE/Z4NfFx7dSmre?=
 =?us-ascii?Q?PoqqdKfVAWm94yck67DgBh/BCYGnQSpJlDzSaru1nRs86/TqOCp5/Oih/r1c?=
 =?us-ascii?Q?s6FuOd4Lk/33ab+yJfagEh18pkDo2TQ7o99bf4bRCHZqz2PrRvaOnUDKn32p?=
 =?us-ascii?Q?dXx4QTGqdIbXBTwg1EanQ1ybEnc4fDjTUA6EJ6Q2oqWm8aPllq8yU8yZreyJ?=
 =?us-ascii?Q?w3F8N+TwW8+UXjbXpdViXvX7gJngeBDJLaDGtSb91vqytPxbHfZoYOqtGtcO?=
 =?us-ascii?Q?dmdjqFX/tLD3fMB1wzcXn6gDiJXYJNHpDsAKMfWkAF58/WXF1Yto2Ns0ci70?=
 =?us-ascii?Q?IK/pufEcmd8X7m4xAo5qQ/IFFeiJaJRs6Vqli9BZLikC7elFt3oz0ShrZoEX?=
 =?us-ascii?Q?EFvl+7Ku44fsYllT66vj6v/02+mGUw6ZsPwk+TE0k0akbJpHSk+FXrL3/r/B?=
 =?us-ascii?Q?YyxjJaKt/BNkzRJCIwFUk8ZJEECglX/ixaV1gLNectECPt2lxpq7Ng23ZXKO?=
 =?us-ascii?Q?c7rWx1KyPScA4432WIKDqNF7Gnu2GXw1qykvr9T0LL7VWniN+DYOUY9NTtMy?=
 =?us-ascii?Q?fQfPOxY6Wa1likyMi7m7oQjwHW9Mok/Aaeeku72vK09tnlvLlAfCvVLTn3VZ?=
 =?us-ascii?Q?NFfoTadh9yhw1YaAE7xSFoqSKTyR07iFFp4AF0Xuq4KnnVZihIrp8cQSEdyP?=
 =?us-ascii?Q?g6Z4S/B3K4MFbnHTRcHrNAbj6BLgDKiAd5xdPH1KrfG2v2EhFtTDs9sztvmZ?=
 =?us-ascii?Q?zgkyQyV1O1P2LqBdjax3RTWeQHHFzPiEo+On9dOwDloGthqgix1J8oVADHQ2?=
 =?us-ascii?Q?BjKipQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52577ED1CF427F6C0D6102E1FC5BABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 798117cd-6371-4c36-b9a2-08db6df41167
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 22:58:43.4248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoeuKi03eYW9WKWemRbzAFFvChILB+d3EN6mIfsJQJ2rjd2rE/lMm30sK4/kS4l7jt/kgL/hFwBXSIZnc4yhzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52577ED1CF427F6C0D6102E1FC5BABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Sent: Friday, June 16, 2023 6:13:17 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: fix LPDDR5 width reporting

LPDDR5 channels are 32 bit rather than 64, report the width properly
in the log.

v2: Only LPDDR5 are 32 bits per channel.  DDR5 is 64 bits per channel

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2468
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ef4b9a41f20a..0b7f4c4d58e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -327,10 +327,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
                                         mem_channel_number =3D igp_info->v=
11.umachannelnumber;
                                         if (!mem_channel_number)
                                                 mem_channel_number =3D 1;
-                                       /* channel width is 64 */
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * 64;
                                         mem_type =3D igp_info->v11.memoryt=
ype;
+                                       if (mem_type =3D=3D LpDdr5MemType)
+                                               mem_channel_width =3D 32;
+                                       else
+                                               mem_channel_width =3D 64;
+                                       if (vram_width)
+                                               *vram_width =3D mem_channel=
_number * mem_channel_width;
                                         if (vram_type)
                                                 *vram_type =3D convert_ato=
m_mem_type_to_vram_type(adev, mem_type);
                                         break;
@@ -345,10 +348,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,
                                         mem_channel_number =3D igp_info->v=
21.umachannelnumber;
                                         if (!mem_channel_number)
                                                 mem_channel_number =3D 1;
-                                       /* channel width is 64 */
-                                       if (vram_width)
-                                               *vram_width =3D mem_channel=
_number * 64;
                                         mem_type =3D igp_info->v21.memoryt=
ype;
+                                       if (mem_type =3D=3D LpDdr5MemType)
+                                               mem_channel_width =3D 32;
+                                       else
+                                               mem_channel_width =3D 64;
+                                       if (vram_width)
+                                               *vram_width =3D mem_channel=
_number * mem_channel_width;
                                         if (vram_type)
                                                 *vram_type =3D convert_ato=
m_mem_type_to_vram_type(adev, mem_type);
                                         break;
--
2.40.1


--_000_BN9PR12MB52577ED1CF427F6C0D6102E1FC5BABN9PR12MB5257namp_
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
<div>
<div>
<div dir=3D"ltr">
<div>Acked-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Regards,</div>
<div dir=3D"ltr">Hawking</div>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Get <a href=3D"https://aka.ms/o0ukef">Outlook for iOS</a></div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.de=
ucher@amd.com&gt;<br>
<b>Sent:</b> Friday, June 16, 2023 6:13:17 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/atomfirmware: fix LPDDR5 width reporting=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">LPDDR5 channels are 32 bit rather than 64, report =
the width properly<br>
in the log.<br>
<br>
v2: Only LPDDR5 are 32 bits per channel.&nbsp; DDR5 is 64 bits per channel<=
br>
<br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/2468">http=
s://gitlab.freedesktop.org/drm/amd/-/issues/2468</a><br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp;&nbsp; | 18 +++++++=
+++++------<br>
&nbsp;1 file changed, 12 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
index ef4b9a41f20a..0b7f4c4d58e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
@@ -327,10 +327,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_channel_number =3D igp_info-&gt;v11.umachannelnumber;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!mem_channel_number)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel=
_number =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* channel width is 64 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (vram_width)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_width =3D mem_ch=
annel_number * 64;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_type =3D igp_info-&gt;v11.memorytype;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (mem_type =3D=3D LpDdr5MemType)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel_width =3D =
32;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel_width =3D =
64;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (vram_width)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_width =3D mem_ch=
annel_number * mem_channel_width;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (vram_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_type =
=3D convert_atom_mem_type_to_vram_type(adev, mem_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
@@ -345,10 +348,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_channel_number =3D igp_info-&gt;v21.umachannelnumber;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!mem_channel_number)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel=
_number =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* channel width is 64 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (vram_width)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_width =3D mem_ch=
annel_number * 64;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mem_type =3D igp_info-&gt;v21.memorytype;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (mem_type =3D=3D LpDdr5MemType)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel_width =3D =
32;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_channel_width =3D =
64;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if (vram_width)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_width =3D mem_ch=
annel_number * mem_channel_width;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (vram_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vram_type =
=3D convert_atom_mem_type_to_vram_type(adev, mem_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>
-- <br>
2.40.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN9PR12MB52577ED1CF427F6C0D6102E1FC5BABN9PR12MB5257namp_--
