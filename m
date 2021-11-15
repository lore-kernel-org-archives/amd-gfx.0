Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63017C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA4060F51
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CA4060F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CF256EC3A;
	Mon, 15 Nov 2021 14:37:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31946EC3A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 14:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtJgODk0k5l3RwslnjNY3LqbHBas6q9wf6gjCLMxmyjo166reeK/a98ti18eU3icE0f3FKnqcZdbk1J/FHw78cGRc5ZLVih9jmJ+2DCx9YXV/fgynqdg2CG1MVwgOMUzhvz3XfEh8HMEL19sUKkPoK6DSmLEUqrkwHIS+1gShuTXCtJ0Blg7b9gCjupRWZIthJ/vOVYGkUg9sJLsbahObmzF1Ar9m9FJj+P83ZW1zOnK/Q/mcRHxkjGPf63dvWpS2yL7z4t2BjkKoJ2YZuxXsj+DtNfOX32sBIg/CqHlqzwDRyiOGbFAUFznpm6RlKIUUsO2Ad/waURfnAjxFk0cbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+9lMejjwuqaYdz8ulybyLK6s/Jmc6faDdbsOFDF/oQ=;
 b=OL6h+oumKK3LtJrOUhhQ3sw8Ut6CMGbbpBHASx/R1gVq6YBwjjgFooFK75qbaZ3VbEB9ie4GZOyzrnKYdOrgmiCXDLSh2QmIlWNPxLZBRIw8oR/o/wLiaquI/ywV1eI4BHZo1MP39wTo/DTNTOwxJC4DrZvLNG8627SRf+5LZCgOyrgdjCaZZDixRriL+9zodGNSe/yoJmd7aM1S/s6kJSZIvnaQl/yZolzEitgDiZ0N3MgZWe3LEmvFord4GoxYORimZV1aHrCdpgBLzshDpHSh4cj+95wkf+i6dGKReyFFrf0RG9VWguWo1Ipk6oZPTuazRM9OSDIKvk9b8yM29g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+9lMejjwuqaYdz8ulybyLK6s/Jmc6faDdbsOFDF/oQ=;
 b=pcTqa4yn1nD4CnyiJ3n/TvLG2C4KDD3M8eI3nMQfSBy0LTusdl+zzpdVXGKc8aBneiKTYS2xIe11mIKD2XBlwaUaDO5V19oI+ceXd1Zf79PYUxCuAuiwe8Q9UySHlsTThjHeH8A7cad0m1s0FgBuJxRotiFXHzodPipZakS1T/U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Mon, 15 Nov
 2021 14:37:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::6452:dc31:2a24:2830%8]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 14:37:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
Thread-Topic: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x
Thread-Index: AQHX2fRb4zp08giCREWM2EyKZPfU6qwEqJ1s
Date: Mon, 15 Nov 2021 14:37:21 +0000
Message-ID: <BL1PR12MB5144454FA6CEABE4C763C8EEF7989@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211115074216.16025-1-lijo.lazar@amd.com>
In-Reply-To: <20211115074216.16025-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-15T14:37:20.775Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: b12233c5-96f7-d81a-47d3-de8981d8d2ac
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea4ac7b-fe3b-4e7e-5451-08d9a8456ee9
x-ms-traffictypediagnostic: BL1PR12MB5269:
x-microsoft-antispam-prvs: <BL1PR12MB52693594F1946BDBDB225647F7989@BL1PR12MB5269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFGH1dTMyOme+B8q8xXL+8milI7QR0gpNWXv6PYjzp/YnbKpvG+O4jbDKcwIBuCreJM+1j/oRnUOiTYI/rHioNtSw1fl8VRpmyF2hEPKFlHB6Jp1h3uEuGaFytrlH5UlJJnHLpIfGmxwrAuomeBaZ1lswlxDbCSWkJ9Rwe3uoixyKetl2xigGiRHI8ZmV1tr3gJcqfWC/FDgyGNghw6VodFeBaBoWeOu97gQwT0YhNZVVL186OZBPoAKjVUNgxtOlbwP96lJD+CKfP8PW0Osh0I+GCobfp/TYuQXyW2dd2bLxiYEWJmzCLgm6zdnOLd0ObTDQf3lP6tOydcscgb7B63mxLh8VP9oa6bfPXjXgWTqdqWTH74u+NOUnmB2bgbqR0aAaft01SzhadP1LdwZAPM7nz9/VNv36A60oXIh2pC4ybQOGI1NmujF0vGrgdHrBpB6hHBqdV57aFcgrJBVXCbcUU45UmqZQS3z4RYvSX0TdEu0IVFs3DtBlYBd2Oywr/XJebZOvqv1JNDuB0vcOIt533sAONV55Gpoc+DWEQp52RqHvGAnf7OPTpKdXD7eui5Zr+b2r55uMy3aeiN6WdInqqk5ipNm+7NlLOScD8aJ9CAW12SOPvWsSXAHQvFCyxMu543g5yTfib47Xg0+1WLsQe9OoN9iCIGzTJ+p17ssvX0rM5Y91jFSzn6T1nmCcnZEGwdeqaoBEEIyAr+3F99HgiOun+3yVBja5jaWWTk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(2906002)(508600001)(8676002)(55016002)(83380400001)(4326008)(316002)(76116006)(54906003)(110136005)(66476007)(66556008)(64756008)(66946007)(8936002)(26005)(19627405001)(71200400001)(6506007)(33656002)(5660300002)(86362001)(52536014)(7696005)(38070700005)(9686003)(38100700002)(53546011)(66446008)(122000001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tp0lDzsA23mqdnaASikOPmseeFAcaX/D79H4tfekZhIUFC0DlW9Wl3iMLYW3?=
 =?us-ascii?Q?rO+C6KUOHaqE+MWQaEE8ODclGjg1fwVd/9vJ7ooxvDXxtigpq9esgIsh8r82?=
 =?us-ascii?Q?WsIExd0b7YXfUQqvHXTWHVipF1cjy+sH97h8+XexJoc1OOx9fYxdcDA5mu6+?=
 =?us-ascii?Q?mC3v1Vja5jDVKEdnm3h3QZWyMZUhv2nuUUJyMXXA9gJZDAgP9SCoGX89dEJW?=
 =?us-ascii?Q?v3Ym3TW5EgDHYQIvfJDwriTJsC6Un2GEy1zOt2DmhKthlZB4Ur3mwuOqCMLk?=
 =?us-ascii?Q?rLX5/WaCWfjHO8gw67IhevM3cm8Olmp/68NmDCAenhACfeCw5rnADvIzlDya?=
 =?us-ascii?Q?ezHIriH08+TTT43pjSZBvaPjO6Gk6KD+sBYxLI6D7zGL407MhhSDrpmVnXvQ?=
 =?us-ascii?Q?rG0jcPuYeAcggvfrO5UxygSQWx3D2nTR0Bpjsn19ic3UX8amrvp73G0RkxV9?=
 =?us-ascii?Q?gAI+KrUmhpCmAd9dHIwRcL0xm9E1XE4fMO1yQ3pzPeI2IGKJOPNF1wZT2oXI?=
 =?us-ascii?Q?YkvhP9x5pzvyQL2eDe0Em8+xCNCxKa7f8puKbxGHTZSxdR5C2j1mIli9VX+A?=
 =?us-ascii?Q?lFGjOatcubQomFWOJ5HBCV4qkI6cGd/TCp2bgeNNCQBxj2vcueH5oVIAQjce?=
 =?us-ascii?Q?nkp4qCW7yxOfe/SehNr7ZeZ1sbwdsm3jkhbn+yVdMYt3281+6F2xOfIhzeKO?=
 =?us-ascii?Q?KPoDqzkP2bi6vBobRQQhCxreFkUdR7w9AaKY72sgrksD0Ewc93X9HHp4VBN6?=
 =?us-ascii?Q?M2Fy5H28ouJKDwN+O00QamMtWx4iUGujijET3/MAwzpaBapBteNdoFGlOBBe?=
 =?us-ascii?Q?b9KwXHG7zLQCnFV7VtcoKS/BfEVTvOmHQh+ISxCec2H9GQ8261oNDA2yhz3d?=
 =?us-ascii?Q?VtfYdcTYWd6P45KSgrcsuOMOVSX5NxHUzizOZHDYKdpaE30d1ygwfXQ6j5cZ?=
 =?us-ascii?Q?o7kiD7PRKpfdhVjmeJ9m9WJ4q+/gvKTVw7Htr07mYLIeERwpn1Wkc0jRFbbY?=
 =?us-ascii?Q?mB17dNPICmZ3jpvNu4jTp9d4ZrcmjhhxKldVLptCr3QOzr9k/3+DYDobDXYP?=
 =?us-ascii?Q?Dc2NlUs7s0lh+9J0lCJUt2j0RMo4gc6kB7Obq1hHZKesxmgxzd/reOFU58NF?=
 =?us-ascii?Q?IgjW3oxlzRGwihEAC6/TKv10KVWj4l0HHMGewys/4oPY2eNQ6nNIsZOCL0Vv?=
 =?us-ascii?Q?xvLk4cLdCUHaEFjQsFyheWlLcZg4Yk6B2y0T5QeUUqg5ZZNWFb+yE0Objzcr?=
 =?us-ascii?Q?zrsn0asmXBetzxncoXR4EucQow5uIG7RDtPGGrtrj1i0zXRHDKPu2xtWKPqS?=
 =?us-ascii?Q?lbxihvJcfxJLR/tm9kV51gHJ3qbmwsbaocL5aI6DRAiGzsk8Prz45gS1ONui?=
 =?us-ascii?Q?xP9mKlpJBchJgzvZqjUpfANJMZFzddQDcdf2jQi4flkts79AW5v66MZseJ5g?=
 =?us-ascii?Q?5soBKgY05L4kL8bDCahoA23/b0aitRlQy/0fTXO16f8JYNXU7Jfov1dmuvPH?=
 =?us-ascii?Q?xnPEJpKOHgMK/SANXnvxy2A1aSqSHdvcKZjwH4torqS4+OycSkBuUCsvfnSR?=
 =?us-ascii?Q?kshyj7zzn3VGKah/y5CZaDJGkdQlVPtp/adIdK5QnnIjWoUZWsy5EZg3U6BU?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144454FA6CEABE4C763C8EEF7989BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea4ac7b-fe3b-4e7e-5451-08d9a8456ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 14:37:21.5037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBHJO26FLN/piF0IoGTyOd6SXUKyCDVphetlogYiwP5JtsdIeGBlhz5UXYcdZSwZU2HF0Wu1g4xbBp7kVFfm4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144454FA6CEABE4C763C8EEF7989BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, November 15, 2021 2:42 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Quan, Evan <Ev=
an.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x

Print Navi1x fine grained clocks in a consistent manner with other SOCs.
Don't show aritificial DPM level when the current clock equals min or max.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71161f6b78fe..60a557068ea4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1265,7 +1265,7 @@ static int navi10_print_clk_levels(struct smu_context=
 *smu,
                         enum smu_clk_type clk_type, char *buf)
 {
         uint16_t *curve_settings;
-       int i, size =3D 0, ret =3D 0;
+       int i, levels, size =3D 0, ret =3D 0;
         uint32_t cur_value =3D 0, value =3D 0, count =3D 0;
         uint32_t freq_values[3] =3D {0};
         uint32_t mark_index =3D 0;
@@ -1319,14 +1319,17 @@ static int navi10_print_clk_levels(struct smu_conte=
xt *smu,
                         freq_values[1] =3D cur_value;
                         mark_index =3D cur_value =3D=3D freq_values[0] ? 0=
 :
                                      cur_value =3D=3D freq_values[2] ? 2 :=
 1;
-                       if (mark_index !=3D 1)
-                               freq_values[1] =3D (freq_values[0] + freq_v=
alues[2]) / 2;

-                       for (i =3D 0; i < 3; i++) {
+                       levels =3D 3;
+                       if (mark_index !=3D 1) {
+                               levels =3D 2;
+                               freq_values[1] =3D freq_values[2];
+                       }
+
+                       for (i =3D 0; i < levels; i++) {
                                 size +=3D sysfs_emit_at(buf, size, "%d: %u=
Mhz %s\n", i, freq_values[i],
                                                 i =3D=3D mark_index ? "*" =
: "");
                         }
-
                 }
                 break;
         case SMU_PCIE:
--
2.17.1


--_000_BL1PR12MB5144454FA6CEABE4C763C8EEF7989BL1PR12MB5144namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, November 15, 2021 2:42 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@am=
d.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: Remove artificial freq level on Navi1x<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Print Navi1x fine grained clocks in a consistent m=
anner with other SOCs.<br>
Don't show aritificial DPM level when the current clock equals min or max.<=
br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 13 ++++++++-----<br=
>
&nbsp;1 file changed, 8 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
index 71161f6b78fe..60a557068ea4 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<br>
@@ -1265,7 +1265,7 @@ static int navi10_print_clk_levels(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
smu_clk_type clk_type, char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *curve_settings;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, size =3D 0, ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, levels, size =3D 0, ret =3D 0;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cur_value =3D 0, =
value =3D 0, count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t freq_values[3] =
=3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mark_index =3D 0;=
<br>
@@ -1319,14 +1319,17 @@ static int navi10_print_clk_levels(struct smu_conte=
xt *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_=
values[1] =3D cur_value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mark_=
index =3D cur_value =3D=3D freq_values[0] ? 0 :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cu=
r_value =3D=3D freq_values[2] ? 2 : 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mark_index !=
=3D 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D (freq_values[0] + freq_v=
alues[2]) / 2;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; 3; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels =3D 3;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mark_index !=
=3D 1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels =3D 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; freq_values[1] =3D freq_values[2];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; levels; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf, siz=
e, &quot;%d: %uMhz %s\n&quot;, i, freq_values[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i =3D=3D ma=
rk_index ? &quot;*&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case SMU_PCIE:<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144454FA6CEABE4C763C8EEF7989BL1PR12MB5144namp_--
