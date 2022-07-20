Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FEDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 08:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9B811A90D;
	Wed, 20 Jul 2022 08:28:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CE011A90D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 08:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix02g97+kj6vhSN84qR+y1s247eFokuqCZZ/lNSA6Hko5BqgCE+xwstCjeZZZqKrGQotU/LVxgT9EXb8qJP/rlKz4TncusSFVRX033ymkxk2nG/PdFOyMrABHwB76I1RIshlsNO9gl7ZL276iHaaNbU3oN1BuuubehhTT+dQOgxeZXCsMkja9hps1MFm4n3QXNYjC9i987Km04XKmrCdmbP8/tg3V7XN5SVZsjgS3WHub0fny/bWFL+46FNT2o8nUfEoCgveMf4Ne8EodPUE1WGvRiJiYgNKFnSRuOAHfWFIxyDYhLbT1KeJCwj/q2PeDjyNG5tHM/y0ZsD6RCz9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCsycFHSAUwo7t5KwxsECEu4Ksh10JMdCdLWRXf+i20=;
 b=GCtkyoiJFylxYPOmvpNEJpII/CyO2MRjuRP7CIRGLH/zQU7YUfYUyMRgfAciDEPE9vT7d636Ym1wVc4ZTdCod4cHD07FreJ6rLGefJgWpHkQDZBFNT4Dyou9CrvxIevckRyoLXclRGlg4ZmXn06TJXmuhXQoxBhjeq+hoifLRc26OLM4u4wnP1F3XiEZfmxl/L1dhepQQWsnrnP4vxAQw/e68kh1xx8O2X9PovVx2BOyih4gb7dJoHNsle8yRCS4k0MfvrYN8gXBIa6FISmmaYDkeac41MFlqjuzvGfE2k7QjfHvxOxlMEPFKVdmZpLnyIpuM8QVUnU7yyqGAWu15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCsycFHSAUwo7t5KwxsECEu4Ksh10JMdCdLWRXf+i20=;
 b=LsKUqQRF7+TIQqU3Goel8akqH/QW1fGvb0uAPVZxvlzcZDlPCrTNg6We2Z7sopqQgRdhTq9iblZkv+BR7SlVKVv8hOWap5dJZX1PASomYoi0ug6Ap9fhuE/JObesqBOhHLySrkQSeX66lyonZJtTjBvEoMPn0mPoXyydAaq18ZM=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Wed, 20 Jul 2022 08:28:49 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::ac73:1fda:f26b:f1d]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::ac73:1fda:f26b:f1d%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 08:28:47 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the incomplete product number
Thread-Topic: [PATCH] drm/amdgpu: Fix the incomplete product number
Thread-Index: AQHYnBKCsdY9+F0XAEaxGj6ik+l2S62G7Pnp
Date: Wed, 20 Jul 2022 08:28:47 +0000
Message-ID: <DM6PR12MB55346E58904FE63EC9E19ECEFF8E9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20220720082659.49637-1-Roy.Sun@amd.com>
In-Reply-To: <20220720082659.49637-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-20T08:28:44.644Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
suggested_attachment_session_id: 69e04c69-a6e1-43b2-7e1e-e06934b6fee3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9371f04-f095-46e5-ac4b-08da6a29dddd
x-ms-traffictypediagnostic: DM6PR12MB5024:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ojlnw42UPuYHw/i8Ew8kO/giEU+sQMiipTUtvjQKxXRfhDHfLWEZkRuJJwVFUBLayO6aLvw4ezwFa0H7JOrOnzw1CEBpUOHM2tpxZ7TgX/OjiMFkUveY6PsZ7hnuarRy46Ll3pXOgsDUOcejw+hV/ajAsMe2sYvpay2UkkYbadqlneWq/P8SRt7V8P+OMb61/vp64kOlK03mhNtoBL7vmjlRQvBhdfJCTJu+cym1zbfx8Pp0Kz4ApYOM2mBuG8xfAbT2wTW9g2Kv0TALJomcEgTl4dokWG87JwK/eoLtglwl9vzqMHEKVc9veZpCYsYikoMBr9h6uWJfgI1ETW3BbDQQ63cD87p5bZOK3VT4CazkVMJymVjeG+/zKsTkqfO43/blhZ2gatTVJ2nTcgL0ZUXpTfTgw9sLtYbdg03wGocLIwdy9VbvcMD8Bh4rrdbqLBA2XasyMb2sh4/ANVcNRV1jJDK2sZFmn4W1awHOheuBiCacid6xXXj6XnqX7xng+uMnYdPvuSaTd4CsMiS3gI6Ka0aEC3SkSW2vT1aQkGHmmBk+POJoYIcdn4zf9nsPqzGOfIsZHSe0y+hVne1RmK4IFkne5NtLGq2BfwJThturl46XrCrlqn8EhWY9XNU0nQUo79t0vOdSvUhoYGgzW9XUpjl90kzVRae/89C3naPoGABBiymEqz3VI38Kg6XmTcdCdlXiX88XaugzSF9cVIb3TJgudzzSg1OSKVcuoJGs25k+dVGCK02O6D+tirJ3GfM5wr65JBHLSvmhnpP9E7wDrgfMtkc+PZ2sX92f8Dw5aK2IjVOYubBlCM81LsF9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(9686003)(2906002)(52536014)(8936002)(38070700005)(5660300002)(6916009)(316002)(76116006)(83380400001)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(186003)(91956017)(122000001)(86362001)(38100700002)(7696005)(6506007)(19627405001)(53546011)(55016003)(478600001)(33656002)(71200400001)(26005)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uVLKVxhUhcDnMVAerRudU6s4yFv0p6+lUEKgJ0CaEPoOI0RzeufKfJxRE0?=
 =?iso-8859-1?Q?2cgZGKPS8vqf9sygMBNPXX2vkL+O6jDgvdab1cPPjjpSbxi7es0ZoLlnn1?=
 =?iso-8859-1?Q?JZkvkhqARKaxcurPQyMMC4SeiUbKoitgm1y0hPHk3rAwz7OMZDtOfF2XKT?=
 =?iso-8859-1?Q?c7lswI79I5L0wd88MBKtfES+AcM9O5XLYTtMZHsJm4ZOrypiaHsZxVhDEJ?=
 =?iso-8859-1?Q?B8vLfq0Mvr/9Z8UA53SiBh4CRSmmDQfMvvaXXlmbJNLNmRmBV8bFncHUkQ?=
 =?iso-8859-1?Q?8GzuZ7EddZ3Six3LFG4ZeqnUYBjN768QKD9HOKuNkvbtkslg7xtrHeYmmG?=
 =?iso-8859-1?Q?i9rZhGFn9wzWcNgojS6hAdSPLmDXu1T5qVCkipBfN3ZBQpGWWQwsUOKjgL?=
 =?iso-8859-1?Q?++7p2+HNPl9Sy1MoGUO8J750dDZRJUC6Nuuo8iSoJ2HZoNzIo/1IQHHy49?=
 =?iso-8859-1?Q?CatSRbGJOb7vQ0amw3KiLT1z/YGV02NQ2iVD2r4r5H1JJINvVhAgOmU/UO?=
 =?iso-8859-1?Q?H7ypllDJUbsOON0Jw21/8omkRYDrTHF7nl/LpQvKJtppbSQuQV3FNiVFD1?=
 =?iso-8859-1?Q?bCc+wDSxewZTV/LESUIy6Dgc3gh2vkoB4aPhglPVI/rE3BplfwkEzQFrX4?=
 =?iso-8859-1?Q?g7yRa8vm1Syb4cWgZod2ukhBu0sr4vuSAnGxpLARQNsEgpsQhvWMXI5lYN?=
 =?iso-8859-1?Q?9MTinrKlqt7XKnZeuYxysg5kaNu12dP8mUPaIo179iHS2pE+ldONdBPaNT?=
 =?iso-8859-1?Q?cStxGT7N8Hn+Ew2pXdLE7Mt2Uhum9dFHhGlAfkRnTx3uCmmXe1k9jCJEp/?=
 =?iso-8859-1?Q?n8AgsnY9z9n897QFwbc05vrO5v37q7+3/fUBqSdOPumuPVnakWTLdfkE4Y?=
 =?iso-8859-1?Q?oZ1BozMDzUyuhRd6QVO9qdKJ3Z4RMdTZovnG73Lqe2MN18klfUfOAEyqZa?=
 =?iso-8859-1?Q?iv3MU24lN6QWY4CzjmfxdXTeahNQKp8hOqyMLrNhQAGCMmlZzx9mVU8dqX?=
 =?iso-8859-1?Q?4iurtrMnG7PTDMvsZAcAVIdsqhy2LKl+q197NqCZtjaOdkntu6A2R1+BoK?=
 =?iso-8859-1?Q?4RKT9h0Wc9XnQCWbPuFEEsO99xmhgykLYwp86hPNh+5q8leLAwkEYZ9hGB?=
 =?iso-8859-1?Q?MCVr5mdWzkoC7b5nmq4OBgYyOiYoLKYyZt2npRzDffYRVWEVYuFyHCcmh1?=
 =?iso-8859-1?Q?rVi467EayV4AbaG1l+5kjMCbl1DWfR2K7bQRjB2VyTCu+DCSEqXvpkiA5o?=
 =?iso-8859-1?Q?9jx2/BXzmQcQOBkiCBB5GgW5G8FSRE+sS6QGmJJLszw2wviUJkLk1xj4wk?=
 =?iso-8859-1?Q?udLf93DOJyi87T/WjjWfN3OhSS5Iz5kVsJHHQDZG9bANkU00keSqFMjouh?=
 =?iso-8859-1?Q?F2jxPm79TIZsb4RcVhxJ6m2nq6YcT8EyyuqTnjRvAdGVC/cr7PbpHibVHF?=
 =?iso-8859-1?Q?XQTxX6obX94MHidtGyYAoSewJqFyoo2KiooCqmkB4uRGgrZHKOILHzajN3?=
 =?iso-8859-1?Q?AfoBRzEq4+JZ3xC5sySAS1MRAGoabgUhO9pWNrANS/x3zWnnQXWSo2q93M?=
 =?iso-8859-1?Q?Cva8TepN5mZjsRRzoPgXIu8rvAXc1xG4jl/qIzzKGPoqGOhhE0be6Sa0yA?=
 =?iso-8859-1?Q?e3Ep9+9vAso5A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB55346E58904FE63EC9E19ECEFF8E9DM6PR12MB5534namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9371f04-f095-46e5-ac4b-08da6a29dddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 08:28:47.4685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0zP/90Yhs2YBCIAteGBISpAzys2CjOpa0xmvmyRdyq1wE/r1BVSBriSLS3H4i18JPF3r8IsdqReinE2pTD3vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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

--_000_DM6PR12MB55346E58904FE63EC9E19ECEFF8E9DM6PR12MB5534namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Double checked.

BR
Roy
________________________________
From: Roy Sun <Roy.Sun@amd.com>
Sent: Wednesday, July 20, 2022 4:26 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the incomplete product number

The comments say that the product number is a 16-digit HEX string so the
buffer needs to be at least 17 characters to hold the NUL terminator.

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 9f729a648005..187e3dae3965 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,7 +1019,7 @@ struct amdgpu_device {
         bool                            psp_sysfs_en;

         /* Chip product information */
-       char                            product_number[16];
+       char                            product_number[20];
         char                            product_name[AMDGPU_PRODUCT_NAME_L=
EN];
         char                            serial[20];

--
2.34.1


--_000_DM6PR12MB55346E58904FE63EC9E19ECEFF8E9DM6PR12MB5534namp_
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
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Double checked.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
BR</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Roy</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Roy Sun &lt;Roy.Sun@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, July 20, 2022 4:26 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Sun, Roy &lt;Roy.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix the incomplete product number</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The comments say that the product number is a 16-d=
igit HEX string so the<br>
buffer needs to be at least 17 characters to hold the NUL terminator.<br>
<br>
Signed-off-by: Roy Sun &lt;Roy.Sun@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 9f729a648005..187e3dae3965 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1019,7 +1019,7 @@ struct amdgpu_device {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_sysfs=
_en;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Chip product informatio=
n */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_number[16];<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_number[20];<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; product_n=
ame[AMDGPU_PRODUCT_NAME_LEN];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; serial[20=
];<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB55346E58904FE63EC9E19ECEFF8E9DM6PR12MB5534namp_--
