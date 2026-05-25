Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264FFCD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 18:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA1610E3B6;
	Mon, 25 May 2026 18:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iDUeMyp+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB0610E3B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 18:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZtrS2FId6mb5dhc7zyboAXMpVnqH/M/Ax3HFwB1e2n3XRps7e9D6toofFzjzFlE7JFxqozSkt5emvU5iVGqd5buqm6kxPmU1vu6YCaXfHaWS+aUYdUiRWeUzb3nEkJ0Tbk56KOhG7yfIdcZT+Jshr5HOTLH/+1lnRSM2+Otm/erPD8zltl7lQknxu5X3Bqv03djYX4Rc6Ltqei4HibhAnIFTNkHgG+cLlPWigZTIcSGsf0VbvnEVlvJFap+wnR1N6Hpekb9aMaLyjNjxmrlYaVI+nYzMhKbbdNamOsWXw81gaTyQ9ekXvPgcBKxm62MQwqMjQCttMVpVTe0E8f06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtVben14P7OpAnb41Wc9+3+vMSGBYMryjaZ5lKunVQA=;
 b=UCjLzqrQH60QO0dHBRr7DJRmc1nPP88QAjDJrUB0hGnER2NzQgzq4wTttTfAOnm1wE4Zcgz3DJOsKpUnzb7JfE442iIwb/DQz7oPwZV8NH1mjvUqe9LE/4VD1swJFYg7ZY+NYlsyF5eXbZXfjCa9R4OCSlGQbvkqAJKpxG/OEkjlcZeqsZHetSBy46c3nM+9NcwaA8lDoLkQPIr12r4TcBYMbaWXJnrEAmSbxRgnSGWlTiWXzaasAQRRwR+Rf8ZKya3hq8bAOaZ2mF1o/QHpqWYIb7Q789sAztP9d/SScDZZdbxWjRhwzu8ewt2N4cOOiBGS7M4QkEKbRFDo1GDcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtVben14P7OpAnb41Wc9+3+vMSGBYMryjaZ5lKunVQA=;
 b=iDUeMyp+p9oqVLR3BVFywV76PZfKJTdVFEq7qFvNXvdPVR1jwSYgLi8Tt3KuZTWPuQebofREjST4a+h2HhTYAd+YeII36YQY2KGLxogk5blAOrrKZ+QRRvtTf7WfX/T657baxX+cz2tw/MKnSy0Gms20PEl4YawxbPcag1pa8Xg=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:37:10 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 18:37:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>, "Clement, Sunday" <Sunday.Clement@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Add missing SE/SH bounds checks in
 mqd_symmetrically_map_cu_mask_v12_1
Thread-Topic: [PATCH] drm/amdkfd: Add missing SE/SH bounds checks in
 mqd_symmetrically_map_cu_mask_v12_1
Thread-Index: AQHc7HJ1WxEOEq/7tUGdeqkwKemY6bYfEdl5
Date: Mon, 25 May 2026 18:37:10 +0000
Message-ID: <BL1PR12MB5898345233087A61EAD61698850A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260525181429.28636-1-Sunday.Clement@amd.com>
In-Reply-To: <20260525181429.28636-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T18:36:16.6596670Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH8PR12MB7280:EE_
x-ms-office365-filtering-correlation-id: 11b372ef-3ab3-44bb-0b02-08deba8ca1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|56012099003|22082099003|38070700021|18002099003|11063799006;
x-microsoft-antispam-message-info: HYau6xOsDxSkkksTz+AJIiKdn6IRvwL2UEDVWSMdYtUjyy9xKEMDGtextezS8b2kwMSOISfBtukXAdmpPN159caZPXUgyExSbXRZwzLIOadccIoNyqNk2a1glSlJS6/Y00g/viTdMMEvheclAfQAjR/KQoTHFS5XnXt4D5fumvn+m6rK7Se1op6z+qvxzAzbwFp4knWFrIT96P3J5uykiAQm+/07VbH1/uNXQxz5Lq/DSoprmWBoTggTz1anTgwKa3YTCjRdCqlb+vIUC8EanGgYRK+r+kVzyGAkM5mHnG8OlWjUFDrmL2ZIu0Hn5ClBHAzkr5TbcDtxS61kw/RmabfgkRX+SbePMoy2c2aT0LSvVRvcsF3CNKqi4sl5j91yN4zxPHbXTlPRn0Plja5svQBCaY1Ym5yfzOEvSh0meeuoI77K/+xHmkZh3fgE1ZWDkj8NqR+xfMpu69SZne4dOPpQEtRjKforoekqgb5n2QgL0EFExtXKfwF0SXiFcZdMj1ChlDLTGIWFVSGvq8YZBbw+EMO3Fec1ERTz7/D7z9XdmUfx7bR+Jc0Tf2C9bUShrTjxux26FgolvLi9X2vmUB9wY+zJuCHyuwKDga1bsAqtXYD+FrXGCXZOPOBcAD3Pc9BeQeJ3/QkPQ8bSrjJ1xk1wNFtk++ow9Ba6RrQjlBHOpyb6NjaYyDTWbKrbp+jyDtgcseYPuL1GaeghGvMCnzHS8wh4kPuUpCId4mXVzMdtuSGll3/yX7uXl5bKmVfk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(56012099003)(22082099003)(38070700021)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?We4xNCvbK5gR8FgCSsld5lul+/C81hEPxR3JGabZx3ebMb8g0PXtQMIjLyxc?=
 =?us-ascii?Q?Rvf7yJ/O+nAy0JDGFUkYcKBj3h92X7vTkgxv/HuY2FV3Vp5Kmiql8cp/h7kF?=
 =?us-ascii?Q?uChj0bgDJJB/5zHigMt4vpqKbHVacnXKDZRluvm9DINbvK4Gp59KU4KvzaTx?=
 =?us-ascii?Q?Z8CfAL4BBXEbQbU/Mtk7bq7KySVvK+KIgvHXLpISuDUqzuSTzf+yzMg4EW5s?=
 =?us-ascii?Q?M3MZP9Wf5RnUCEltya4ShUzqrkHfUw2QQw22sNDksdeYnQ32Mxy8yrnMMHlB?=
 =?us-ascii?Q?g62elic0BcufgVHvLd9HDq6lX6sVnYJbEkfYYJ3ahSg9HkNT59FPuozH1h4X?=
 =?us-ascii?Q?67yq6ksMevPkP2TJ8O/58iZKstI/2B+KKUd9d0mXSbfatD3wdp/gciX5B4au?=
 =?us-ascii?Q?/OuvIpp0MJkUZ0VZ/WdLfAHUjfBUv5A6gb3Ww56GGtyZuTcTiVbfhmTeCv+d?=
 =?us-ascii?Q?vU3EA//yvEEmHYkqSq04PlXgMkp0yHquoTjD3mdKdAnfznOMfvdR7N6yYYaY?=
 =?us-ascii?Q?udbjc1vs6FVR1s7gGeNEoSjUv+7uE6MxVxgHw0R9zscDtTMd8NZZQ9/r+xig?=
 =?us-ascii?Q?j/v8PLvxS/RYVRRIE9YHhOpfzZFrua4QSZWO/L39WWvpO9C/UJHjP0OqWRrN?=
 =?us-ascii?Q?6Uxnj2FjCsFuV99oXWSVreRyb5yOVcS0V6xSsPzeo2u1tXBxo9nQaQVElKUj?=
 =?us-ascii?Q?cyNCUwrpUJoXTKmBr1RkdaTTeCkD/F/7N5BbuJqqJGGfXdklBW6on7NF+Ifi?=
 =?us-ascii?Q?E+Z6AxHqjkneZ+FSBSWosHditNVbGsgYV6M995gx6W73LScGi0q4tci+G9vs?=
 =?us-ascii?Q?4rwhiHZja2+ajuQwHsk7FJLvv4uAAwj2xFHbiZPL7Z+382np9B5SIxPdqoi/?=
 =?us-ascii?Q?2NkPCJJVU9ea2S0AlJD43oQMhrDRpC4A5SBHDDm4f3G/aECZMq4QGGDvWpd7?=
 =?us-ascii?Q?uozyTByDA9//HoQs9A0WGi0fT9TL5SsrKGM/LYwd9VSseKPdBnYIipocDUZj?=
 =?us-ascii?Q?/W9CWkrsn6fmW21EqeGro9uW7ZKz0hBGaWOU7DInl/Az8BzAKZ644IH+e6MB?=
 =?us-ascii?Q?wTlZndz7/xOEGcv6H1CQRot+XhF4JblW8atB0Vo3/uz9NeAjje9gTs+1na0Q?=
 =?us-ascii?Q?8cOCZzq2BDuU1mLsY3nyW7NduRPDPlH5QCBRMOBHbZwEHD8KZgR/gl14qvNN?=
 =?us-ascii?Q?HftI51O80KlnokZF94KGUg4OmIrTFyKX2bn6hWDAjxTs9XHNCKzqGscIaoRi?=
 =?us-ascii?Q?wHouuEuq5WEfYh+288+b7UhB2NLp52ElJhMTORA5KI5yCl4Z4nPcpvgbDnj/?=
 =?us-ascii?Q?GDZKxaZySJ2Kk4+j0Ssuk8f467IPWXDGMvXde4VD5SoOrOt/kyZvodzcuWx8?=
 =?us-ascii?Q?iw+InpDNiWYnfF2xGDFQMiCl+lLJRJT9r/mFV35BIy243ZXjszZ4zOYAr7dr?=
 =?us-ascii?Q?A8gX2L3hG705u0MCUukgAFKAL6ozBa602+t6JQfyJXo1r9oZKR/tDpUES01F?=
 =?us-ascii?Q?eXsRpPgorKOEYw428MP9elsNnGF8yMaYlvqeyJ94Xi+i+lnHg6lmG8DzOowS?=
 =?us-ascii?Q?I/G7Am0ZY/tTfFsX7InJz2oikSyLzHBrbF+n+SUa4X0iyrA0EZdbuHNO5LOa?=
 =?us-ascii?Q?bkYJytACEsHzGlaPKT4fqZ0wkG23Z3hCHPYLuulQLBr/MuEL686WRWiPWio8?=
 =?us-ascii?Q?gXY6meNfBqiDiOR+RdiVfq0+BC+G2UDdjdvMJW1Deol+Vb/pkDPAF4Ewp799?=
 =?us-ascii?Q?jo2C88+MIQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5898345233087A61EAD61698850A2BL1PR12MB5898namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b372ef-3ab3-44bb-0b02-08deba8ca1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 18:37:10.1915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqbAmcXzsCVnPNBW1D3NZUMUvE3xvfCgItn/4wjvuYDceEH40bYq+DiGckUgyeGb6sGVeJ74QBvAhpG6whOOtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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

--_000_BL1PR12MB5898345233087A61EAD61698850A2BL1PR12MB5898namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Should we also print the values of those defines? Generally people dislike =
parsing the source code when they get error messages.

 Kent
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Sunday C=
lement <Sunday.Clement@amd.com>
Sent: Monday, May 25, 2026 2:14:29 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Jos=
hi@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Clem=
ent, Sunday <Sunday.Clement@amd.com>
Subject: [PATCH] drm/amdkfd: Add missing SE/SH bounds checks in mqd_symmetr=
ically_map_cu_mask_v12_1

The function mqd_symmetrically_map_cu_mask_v12_1() indexes a fixed-size
array cu_per_sh[2][2] using hardware-reported values from
gfx_info->max_shader_engines and gfx_info->max_sh_per_se without
validating they are within array bounds.

This can cause stack buffer overflow if hardware reports more than 2
shader engines or more than 2 shader arrays per engine. The lack of
bounds checking is a risk for future hardware and is a regression from
the v12 implementation, which checks these bounds via
mqd_symmetrically_map_cu_mask() in gfx12.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 9014912ed82c..fb9d4fb6705f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -52,7 +52,7 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct mq=
d_manager *mm,
 {
         struct amdgpu_cu_info *cu_info =3D &mm->dev->adev->gfx.cu_info;
         struct amdgpu_gfx_config *gfx_info =3D &mm->dev->adev->gfx.config;
-       uint32_t cu_per_sh[2][2] =3D {0};
+       uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] =3D {0};
         uint32_t en_mask =3D 0x3;
         int i, se, sh, cu, cu_inc =3D 0;
         uint32_t cu_active_per_node;
@@ -63,6 +63,23 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct m=
qd_manager *mm,
         if (cu_mask_count > cu_active_per_node)
                 cu_mask_count =3D cu_active_per_node;

+       /* Exceeding these bounds corrupts the stack and indicates a coding=
 error.
+       * Returning with no CU's enabled will hang the queue, which should =
be
+       * attention grabbing.
+       */
+       if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
+               dev_err(mm->dev->adev->dev,
+                       "Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
+                       gfx_info->max_shader_engines);
+               return;
+       }
+       if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
+               dev_err(mm->dev->adev->dev,
+                       "Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
+                       gfx_info->max_sh_per_se * gfx_info->max_shader_engi=
nes);
+               return;
+       }
+
         /*
          * Count active CUs per SE/SH.
          */
--
2.43.0


--_000_BL1PR12MB5898345233087A61EAD61698850A2BL1PR12MB5898namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
Should we also print the values of those defines? Generally people dislike =
parsing the source code when they get error messages.</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(3=
3, 33, 33);">
&nbsp;Kent&nbsp;</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Sunday Clement &lt;Sunday.Cle=
ment@amd.com&gt;<br>
<b>Sent:</b> Monday, May 25, 2026 2:14:29 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Joshi, Muk=
ul &lt;Mukul.Joshi@amd.com&gt;; Kasiviswanathan, Harish &lt;Harish.Kasivisw=
anathan@amd.com&gt;; Clement, Sunday &lt;Sunday.Clement@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdkfd: Add missing SE/SH bounds checks in mqd_=
symmetrically_map_cu_mask_v12_1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The function mqd_symmetrically_map_cu_mask_v12_1()=
 indexes a fixed-size<br>
array cu_per_sh[2][2] using hardware-reported values from<br>
gfx_info-&gt;max_shader_engines and gfx_info-&gt;max_sh_per_se without<br>
validating they are within array bounds.<br>
<br>
This can cause stack buffer overflow if hardware reports more than 2<br>
shader engines or more than 2 shader arrays per engine. The lack of<br>
bounds checking is a risk for future hardware and is a regression from<br>
the v12 implementation, which checks these bounds via<br>
mqd_symmetrically_map_cu_mask() in gfx12.<br>
<br>
Signed-off-by: Sunday Clement &lt;Sunday.Clement@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c&nbsp;&nbsp;&nbsp; | 19 +++=
+++++++++++++++-<br>
&nbsp;1 file changed, 18 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
index 9014912ed82c..fb9d4fb6705f 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c<br>
@@ -52,7 +52,7 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct mq=
d_manager *mm,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cu_info *cu_=
info =3D &amp;mm-&gt;dev-&gt;adev-&gt;gfx.cu_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gfx_config *=
gfx_info =3D &amp;mm-&gt;dev-&gt;adev-&gt;gfx.config;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cu_per_sh[2][2] =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cu_per_sh[KFD_MAX_NUM_SE][KF=
D_MAX_NUM_SH_PER_SE] =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t en_mask =3D 0x3;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, se, sh, cu, cu_inc =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cu_active_per_nod=
e;<br>
@@ -63,6 +63,23 @@ static void mqd_symmetrically_map_cu_mask_v12_1(struct m=
qd_manager *mm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cu_mask_count &gt; cu_=
active_per_node)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cu_mask_count =3D cu_active_per_node;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Exceeding these bounds corrupts th=
e stack and indicates a coding error.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Returning with no CU's enabled will=
 hang the queue, which should be<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * attention grabbing.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_info-&gt;max_shader_engines &=
gt; KFD_MAX_NUM_SE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(mm-&gt;dev-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Exceeded K=
FD_MAX_NUM_SE, chip reports %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_info-&gt;max=
_shader_engines);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gfx_info-&gt;max_sh_per_se &gt; K=
FD_MAX_NUM_SH_PER_SE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(mm-&gt;dev-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Exceeded K=
FD_MAX_NUM_SH, chip reports %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_info-&gt;max=
_sh_per_se * gfx_info-&gt;max_shader_engines);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Count active CUs p=
er SE/SH.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5898345233087A61EAD61698850A2BL1PR12MB5898namp_--
