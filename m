Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257BBC61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 19:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A20DF10F18A;
	Thu, 27 Aug 2026 19:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eL8vnLPP";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A40710F18A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 19:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX9fge3HqhEWG0l2E2Ck/tYCdjF8/U0vR3LVDftGx/ljPxHRtVDG4Z+78FYVlLPVVEVD6Ki7aKMySp0Jwsto6SzbTTcs/vFh/kAO8XdFKQVt7iaNXO26Xfrf6ZOmFeO4RtOBYf2QtO8UfOoZZSYoA0O6i99+D5AY6Gd5m798pjbOLvxl/VryOAGcKejnGnBoXF90bIj/YOVcrxxsJJwQQTnF2NgkKZhV6EkBOCaeqUfa0rh+J7ChczdWUGo7DA7JMFrrpUMjDIaI0gOveVsdPot6AV2M8qgB5r7/SJqBe17viYy96B6I27nWDI8Bv25ah2llU9OVmHtfQd0WW1/jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLog0CRyqwJ4SoOIsutPRE2CvQP03wWo0KO1UEhVYEE=;
 b=qyyUjQ06mKijtCmfX64fmbuCu/kAng9zx3oQLBKhd+3E/TXgt+erYxtDdyogzqbHJfntjGhXJ4c+VHdeP6/GSKdWmC/QKm4aVscOwa4ryNAFfHAbadBs8WKneQHK2KfJlgWMUTdqZ43mX2VOKFXBQ6kDzbPBV/Ni3SUdIq2ob3yRKbV3GSL2TLNS5ojv8ylq8FfQ5gjO0RSbMoGWjtpXt51wvtPa4hybs5SO0Q7oQ2OvKfG7o/s8DrQBUwWV8M1lSkMSUqAz4d949ncfzBg+XHl38Mxca3I1Tsoq4uVMnc84HdV7OI5amqP1EnOKVScNrtH7LvBRnqKxL/MI0kpPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLog0CRyqwJ4SoOIsutPRE2CvQP03wWo0KO1UEhVYEE=;
 b=eL8vnLPPbi8/27XKn21AAcwkoYsnePfzZMZCpP78FL4JuYa94tF9r7aRa26lD1lKIYbbgPWzRfw7UaT4TKzPTO5/zsFDYdl1Gct2AQR6P0qAR6eJnv5PXMyLqSN3I19DDjMibYA8/wle6I65/u1BUXzEyvFC5+RVU3UxBWPHKUQ=
Received: from BN7PPF48E601ED5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6ce) by DM6PR12MB4107.namprd12.prod.outlook.com
 (2603:10b6:5:218::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:20:15 +0000
Received: from BN7PPF48E601ED5.namprd12.prod.outlook.com
 ([fe80::7fec:1d85:2abd:1156]) by BN7PPF48E601ED5.namprd12.prod.outlook.com
 ([fe80::7fec:1d85:2abd:1156%8]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:20:15 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Lin, Amber" <Amber.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Update queue reset support version
Thread-Topic: [PATCH] drm/amdgpu: Update queue reset support version
Thread-Index: AQHdNlgyeDfNLuyQDUyx9OYc9LpG+LayRSTT
Date: Thu, 27 Aug 2026 19:20:15 +0000
Message-ID: <BN7PPF48E601ED52D53AAB6D5FCD46D01C094AD2@BN7PPF48E601ED5.namprd12.prod.outlook.com>
References: <20260827191322.1295826-1-amber.lin@amd.com>
In-Reply-To: <20260827191322.1295826-1-amber.lin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-27T19:20:13.617Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPF48E601ED5:EE_|DM6PR12MB4107:EE_
x-ms-office365-filtering-correlation-id: 76f3b6da-ddda-413f-663f-08df0470391f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|8096899003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: xEBqZst7uSuf71WyrJkIddZBS41Keg4cdIVW3fWhSnOTkyseY/MiLPvTYM1reUCJHz/rH5gFuasxBi1v31ZniLqcRPCTSEDDgEAFgH/gfn+NrT6rGEErUf7ErEdadae+9uwsJDDvNWUXy/4NmhfhQPlfJIG88c4+fIEwAB+7z/6KdabRUNSWVvKMEl2tQ3rMPuugvzAv4XO6I0AV6DX9GcaTKE5LqBT6t80PaPyU14bdvvxPf6ybiLFUXsOI7w82ASMusXLw3ycNtIlhVHZgTweR7EavGRBOr+tbaBZfdXqwtc9cgMw+t+TZQSg9mrJ12id6OrqZufpg1XoRxzGMAYMQur1/l4Gn75iqpkIjqzwFeA7B63YDTwIa+BNn66pu49qJgmqmcX+I/BSRN0qfJAnvWzxHdQwqF0h546gMUu9VOv1h8SXEBL7R+qpb7kLr8duutgg43I8LuOr5PQ01a3SYioGCP+yhDxffYGPR99ut9owU3eY+DJnYZU/DKB2s6IJEqyySqb13gEb/dKu2uxUJsd7rxXdZEsh+n1m1hJY4Ta1vkKE7MSm/MIc7jMh9kQL+Bep8/gp69x9egFocRLgG7qtzApZA96v/j1GpcFa6Jf22UVN4CGw/mqP36J5ZgDh03pdingh5L07kA8idb8Sf6VlvQ6nBQLpZGrNfpYOqZI3vFfhx+ltJ1oytAr3rLDxJtgSyegqHZ0kcEBCez0uKZbbVy0h2Q6lsRZm+klQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF48E601ED5.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(8096899003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cI3vo8C75DewxbP3bGLocvSfVx7TTZAbCcAFUGv/YMsXrm5bf4ahXbnRJGha?=
 =?us-ascii?Q?9TlWcCXJS0gqlhn4CvloYFUo6TSPRvR4BEHnBsB6pjE/xA/4BlpYk/r4x/FR?=
 =?us-ascii?Q?ygsaNQmHs0pz7w8ZpUJ5KulQiFvsO+m7ZxdYfHsspd0ge5DvS50HyRDRXK5/?=
 =?us-ascii?Q?r8JpJk7uiuuzQq+3iZGT9CMTWM6c6kk/Y3XNTXtlmCcikdt72QPj1DsgUYpj?=
 =?us-ascii?Q?IFMRFjogtEHXf+SkUE73Mp0GZgW/VkVhVkO2cjCeL0Efi9SriRTvjgUBIzej?=
 =?us-ascii?Q?+Ys46Ghsk2paRjkzpvFkv3Ad9+LxVlkxgleUtqPLzJv+y8eDhwlH+XOWYo6a?=
 =?us-ascii?Q?98ZhAm463SmZiIjq05vismW2hIBMg6tepJ3ntOYKENxy+W3gj+iIFOqImNio?=
 =?us-ascii?Q?AbR06zlqdXkDSDz1V0XxGbJCOk2nkpW51ZM7fzXValnv0RKWCUWhVWRp7jKZ?=
 =?us-ascii?Q?dQXDhmT/I1x68ZlE9CalKqyOzLywdDpIQaONfWQ4jrZnm3lc0MtbtHEFDBYd?=
 =?us-ascii?Q?BGFsvA/wL8eZNq6yYEih8UEotQoMPCzBz2uJDuPkFlP66/SCkRDNTZwKGp99?=
 =?us-ascii?Q?HUgigROOcxEVn6AnOU7ofYk5M3F0Hno632wMG3MKsfCdvEImzPoe+7TmUZ0z?=
 =?us-ascii?Q?Ws7nn1Gs4L4cD4/8mjkIaJWwa2+lVLLaldG5B2mFsr+JZODb5rcAc1CYid9v?=
 =?us-ascii?Q?aFxDyQ0yL3fM+JN3Wc40VmUBLrvLVOFlgtGgUzWoCvu67Edcd4vTmW70Jdnh?=
 =?us-ascii?Q?QHFJL5GQ/lqFiHq3fiB/TP0gnPFAeMnL0N1kA5286Knkoq6ur2xUoZFCauqJ?=
 =?us-ascii?Q?oXlA/K2t0xS5dD/HzqcYKAgYtOtfuft++Ef7ksuvCi/Lmo2hBk5hxCxmBQ05?=
 =?us-ascii?Q?VI1RX7nqFCZJYviOWacGJEQSH/ZMhCPbwbo/Q1wJEa8p1UH6GJAer7Eq0How?=
 =?us-ascii?Q?EUUTadPjG3zDYVzMQW0QlNUXZ08cPcWJdKiyG3H5rWAhbkiRixXIa52j+XAY?=
 =?us-ascii?Q?IdpafsS7d+uo6i3ozlXNt+AzIxY5wnMxTv0NAxXahHp0LFoXXwqHE9UEAdjJ?=
 =?us-ascii?Q?CF/9CLyuGwLX8o/GAVsDMh7rUL2IMRleK0y+cancpj3PzYwkbz6Sj5Nvorv9?=
 =?us-ascii?Q?FLu7mxq8Y+JRCgEoT2nxGDAoDdE4wX5CcI/F5lg49iThu8gnyPvrbbmz0v+j?=
 =?us-ascii?Q?pHRc48z6ngShir1VWw2rD/i+M1l6Xjay5Oh3AUlgO8Z4gLo1Z1TvwCMRfuEF?=
 =?us-ascii?Q?xLW1GZEzeIKr5lDj6exmWXuUl0a483InuSEt/pVDxZhmxQuEKJik50Wsq/vG?=
 =?us-ascii?Q?XN6+nUakHlR7TdYaH2rToNR3+4lZy1BN7U1FZ2nNMjEWunw69/kmr3DpvPdC?=
 =?us-ascii?Q?ubEQT2M2NUuYkFuSXDO6oq8peZCDKnf27nPJFtuKduphYbuq7P9IZ60WfELL?=
 =?us-ascii?Q?C4ScMrY6OKl6nTZzhxsG/gRzLXwbpH8/sjOdYc+qcTo6d98NGdz46CWBP6d1?=
 =?us-ascii?Q?eAv7ZJC/oCW79MqVd3vDKIBpz2wEift4zhEzhAWhS2tq4B/2+dtduGmisL/+?=
 =?us-ascii?Q?jjmougC2ObE9EPQL/W+hl8RlFm/SDhXc5jJUEvfig5nWtfdLn0HOows1G//A?=
 =?us-ascii?Q?4ql0sprfiGsSTCOVUzgoCb0an/rPOUp+CWUwZzIJhMp13tXlw15/S65ekwao?=
 =?us-ascii?Q?6eXM6cfSpUa6VURY5dHYJsFP8ozpA2/wx/8XjifnQg4yBUcC?=
Content-Type: multipart/alternative;
 boundary="_000_BN7PPF48E601ED52D53AAB6D5FCD46D01C094AD2BN7PPF48E601ED5_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF48E601ED5.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f3b6da-ddda-413f-663f-08df0470391f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 19:20:15.0498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vruXIl/o6rtjb158FF4W31wxYCnEGqdIl8qJJQ4w9zBgMsKs8w09amyGjOAxP7XZGKwCEjjrMYg1bU1liNIAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

--_000_BN7PPF48E601ED52D53AAB6D5FCD46D01C094AD2BN7PPF48E601ED5_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Lin, Amber <Amber.Lin@amd.com>
Sent: Thursday, August 27, 2026 3:13 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Zhang, J=
esse(Jie) <Jesse.Zhang@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liu,=
 Shaoyun <Shaoyun.Liu@amd.com>
Cc: Lin, Amber <Amber.Lin@amd.com>
Subject: [PATCH] drm/amdgpu: Update queue reset support version

Update queue reset required MES version for MES 12.1 to 0x7b since we
change the implementation from detect-and-reset method to
per-queue-reset method.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index e0e38d6bcafc..d88c95a8117c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -886,7 +886,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct amd=
gpu_device *adev)

         return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
                 ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0=
x8d) ||
-               ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x=
73);
+               ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x=
7b);
 }

 /* Fix me -- node_id is used to identify the correct MES instances in the =
future */
--
2.43.0


--_000_BN7PPF48E601ED52D53AAB6D5FCD46D01C094AD2BN7PPF48E601ED5_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lin, Amber &lt;Amber.=
Lin@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 27, 2026 3:13 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Chen, Michael &lt;Micha=
el.Chen@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<br>
<b>Cc:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update queue reset support version</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update queue reset required MES version for MES 12=
.1 to 0x7b since we<br>
change the implementation from detect-and-reset method to<br>
per-queue-reset method.<br>
<br>
Signed-off-by: Amber Lin &lt;amber.lin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index e0e38d6bcafc..d88c95a8117c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -886,7 +886,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct amd=
gpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (ip_maj =3D=3D 11 &=
amp;&amp; mes_sched &gt;=3D 0x8c) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((ip_maj =3D=3D 12 &amp;&amp; ip_min =3D=3D 0) &amp;&=
amp; mes_sched &gt;=3D 0x8d) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((ip_maj =3D=3D 12 &amp;&amp; ip_min =3D=3D 1) &amp;&amp; mes_sc=
hed &gt;=3D 0x73);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((ip_maj =3D=3D 12 &amp;&amp; ip_min =3D=3D 1) &amp;&amp; mes_sc=
hed &gt;=3D 0x7b);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Fix me -- node_id is used to identify the correct MES instances in=
 the future */<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN7PPF48E601ED52D53AAB6D5FCD46D01C094AD2BN7PPF48E601ED5_--
