Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2DBCD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 22:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B38D890C7;
	Wed, 20 May 2026 22:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGIVP0qW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F19890C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 22:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCx4XimybTf5D2IaW13jTt76Zm4Hu3eFRdFAj7c0SU5jCvjs3lH2dX3tIDPkpYOLK+OB8LOdpaP+3LOJCteM+fbXJlvF7VoAvcwJw02lHKCGvCW//YythrCZWfY1Mi2Gg0t6XDbbKKZR758DiLC77o9dHmwczaomhyrPIAIqAyPTPnNJxwf0tQfdjpgpE46m4ls6jYzXExpdKHD7AyPoW52wVRO9dyqnlJv7zDGTPuqXosOJxAIVDVOTTunSQEZt7jusJKPuYd6DzndyG0O8q37dISWlr8VwoZ3EPAeobae6C+NnL1cQxGE33Fo7fUE+pSKaLaTtm9c3RcURVT22wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CWxpvfurkeqzpwhe7PgmtWzH/0NkOmVAqvwijuHKN4=;
 b=Ypj7p3JSgnxqlY0h6yJ9DDzpZm1UFP2NuLatj6yKK38mzxECt+XuROlsQzblWNWh300cEj/l53Qa0LNPjWwIsuk37rR/ISF6aE0R+4Xt/82nxxoJLRSLKKMFL5w0eyeew/xZyut5b2bw+C62RHxikEyvgjA18ql4T5+ljU/2EJwZA/Le0Ojvs4+M1/aTLYNcv4VBUA/sqxwq/BGR14Mv2CMLjBOluXQ5WXBoq3BncAy8EXBXJ+Igy9goO6h58DcygFZKM+wjBWW9jegoLmJgYAjvfOZVTNq4+l6QbRBxtMoXLQs+HIdMgXXmunGBfhBq/xT1QrWGCUvvrEhlDMYAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CWxpvfurkeqzpwhe7PgmtWzH/0NkOmVAqvwijuHKN4=;
 b=AGIVP0qWWi52QvFOrhGbuOdZQWrfJHZNXltMTGU+YRVGGx8NrRnGUdvrYu/HDkoQzprvT3IJB+AodfJsu8Rf7uU91Oh5L2zO2Tw+qL/HTHrPNBFjjgVO7i65dbe7o5ELhbkCw72VYCIKzzO8oacv2pjvjmTNmUhh4wR5mH6aWT4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:55:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 22:55:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: fix duplicated buffer allocation for
 concurrent
Thread-Topic: [PATCH 3/3] drm/amdgpu: fix duplicated buffer allocation for
 concurrent
Thread-Index: AQHc6DOsAJUGzLF0CUOeLCRPQe/yHLYXhtwj
Date: Wed, 20 May 2026 22:55:00 +0000
Message-ID: <BL1PR12MB514496B8359FB5B7D94E475AF7012@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260520083518.191863-1-shiwu.zhang@amd.com>
 <20260520083518.191863-3-shiwu.zhang@amd.com>
In-Reply-To: <20260520083518.191863-3-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T22:55:00.089Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: 85acafca-f9dc-4e33-45e8-08deb6c2d291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|4143699003|38070700021|11063799006|8096899003;
x-microsoft-antispam-message-info: hSYvrs8h3uOOCRBN0BTxbDO4eq91MUZNfHxr4+Kj6Gri/8jZRg2muox67d0YAEHcPGAhaf0T/gtEn2LZVIqLJ7C0Giwpv4BwcVAEasMJwrdIWmyTbTHOC54p2JuWJzxYD358PJoYWMLVy/bQOvTiVayJ1SwUq4nF0U8bnoVaC7AOdo5DbOcva3gPpJy5b9Ds6MAxUuByU1pPGjV2BFA2/Bdy1cNyY1IU1wZF2glZKSpcGjsdaxMbM93wKoAEyxqfuNCmwRhR7snPcLZi16niblA8pWn6whIlVNSreuC9L7G43x9ApcNtLeWjdHs310VmjACO3cOTuOOI/baTKS/WK+aZ+WD1+Bvvht1Jq9ElL+Tc6DfN+0qr3V0FJgybW2aM7RKWq8rwrA4DjP9eY6J2rg4Aig/SZL33GFoRxqMRZn2U4l5e0NDc+8GhbbA39DzZo6khQKnB3156umIBomqQi74p4xw5sLqcixpNK5xyfqyUw4lORlfxtCU9LGSV24a8HQzPaz5AMX6ntzRm2yNzrGsRIOp9oXqDzZNNyX4ePVkevP97RPv0MQEG/hmrcq7iZ9dA1eMAL0TgifFA8RkjNFqqGxAIihOd14FevuDQI49hNezK/k4LiBV4LiuIRbAAUVUckFJ7EKAVAiI7aDlS/JX/08YAoQikYiWTP68DnoR+F79C7WLg09PXvckD1/O37252PU3gIjOyNc1Mnfdrkt9Hc2KSgmkAk5qKM/FDPvNoKESVBUaLROodgA1DnJd6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(4143699003)(38070700021)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4TIKGFpSFoaeWZU5RCnpVu/x6xNDgwKj2eqLofmn3V5WzHhjixQE0BMSfD2?=
 =?us-ascii?Q?3+0x1SXpGot9ZfEm2L3lCwr292mHc9QMi/blUrhCcs09XkEZUiK9RDYmfkFJ?=
 =?us-ascii?Q?7R6HOhRl+CZNyWcujxFiMYJcGr009QPcDeqlG04UUMunAhlLdnGf3um9Hwll?=
 =?us-ascii?Q?ftymnx5fLeSUdBoObe//tSc/+fcuhiunmP6C6XM7eqowPd5xkKnyl7qgsjfG?=
 =?us-ascii?Q?0P9RuzAKbIkwhKOSvOYY83V8/DuF20KiwfFpyFJqpC/VMZvf9597Bmffq+NH?=
 =?us-ascii?Q?8k7FkUBf/LRohnRXWsSs9nPWlOJxIfrqCCl55NjG0GVzR1Fy4taXYEQr8Ovv?=
 =?us-ascii?Q?GnqK4zru2ibVvHjcRp8TjaK3JzNkibiwPUEXoWfuk3DSiowrEM5f0aZ9fGEa?=
 =?us-ascii?Q?Uv/Xd2r/MmZ1+Tg8pMxEm/vqxkcathQEiQFV0THfLU/YNmoVlecvD/QA2dkG?=
 =?us-ascii?Q?eRcXmV+P55nkqzezs/IRGhRSwe+cSv94SzU71gXAtmSxw4BnldIcVSxvsan5?=
 =?us-ascii?Q?mBVzpwzJUn//TD7OytkCa+4H/jEUR7xvwpK4nUN4Myj9WeLw059fAzGOSnG1?=
 =?us-ascii?Q?TpbyP28Phh7lIRjZ58/5x3HXzpn8pha9azeS8OxC8SAEublWWfhi+OpP6UaJ?=
 =?us-ascii?Q?grpA8RcuQYgPNHy5RzTJq6GErXzl55wXErapB1dcgdxPhM5t0adaWr1hNDb5?=
 =?us-ascii?Q?0Ut3P9aNhHXSa8Z9aitsLUoqAISibTX7hD4dyFBr962nH0Rl94CY6UuAfXFu?=
 =?us-ascii?Q?ibEFzfJSvQTF56VZFWC3NWLXXlyVXVrypvIJEKeAAmI4Qf6N4ZcylJZJG1vj?=
 =?us-ascii?Q?ydHrPpXtzvem9iHs/JoSUL7gV6GXNAUkd6CIVS2cNyhNIkoEHxzOg7NdwCMx?=
 =?us-ascii?Q?jd/1u4o0uA+MBGd0kgDhnzaHrvVzELVIH58zomkJjbEAYrthqLfbMQaipXCw?=
 =?us-ascii?Q?5Q8sYHYrRlwIuUBpQweEY2F0i2B6Ifus54Aha8DrNkcqXXtGfbR0KVk1UDtW?=
 =?us-ascii?Q?qnnoOu1KcUHI0foLZHB7nmHyJyqFNs/mhAbd2pnI/vHD4FoFO1Bx5XvUtTlt?=
 =?us-ascii?Q?d/61NxO1xfBvyISx92yRSVfrDahhmgYOw/krqNuRMQ0DmVVKmIJ7DqaAWMx8?=
 =?us-ascii?Q?VFvT8jja6Dd82ONKJaUelPO3drB5Ff+RN6Mk1smC9Opl2KR6QKdimKyaGg7v?=
 =?us-ascii?Q?/dmnltSaCJsnPgE0UoaQAU7SFrJiqVIcX+z1bnB6ttt6ckHgM2Yi3tAurIx0?=
 =?us-ascii?Q?smOfDwnJxM7RcHzP+uasIuRCvQGJ0mXApVGmjQBkwA0aGU9L+skNxQq1ff6o?=
 =?us-ascii?Q?XXYmwEWiMmFsEEtds1WjIaSbJ86cBkZYYEEyqmBAVDABpmBIz3Js91NzIacQ?=
 =?us-ascii?Q?OpZJuSVRb7zuRtaQZtmuDlcEyphgpLh9fJv/RF7qRkcwquwIhX8BJ4c+appb?=
 =?us-ascii?Q?FGdv8lIvjjRWUVpuv2fNJsyEviUHF3KrmA6NY9sltbduFtro1dMVjC2umEZ3?=
 =?us-ascii?Q?CaEqJb4GPgx5u/JYkA6xX2dHiKzF+uCwgMFrNorqO7dx6n4/cOwUecsBb0PL?=
 =?us-ascii?Q?Beo+ZDs064bHwsHPmG4WRmGY3uGTIEr0GWlXH4ujHzWerEZWnh3uXzDE4Ijr?=
 =?us-ascii?Q?E7lphX+RnSlbOxOEPMUa2I15WfcNiyYng3dGGCRH3Ve93ZY6y5/z4WaKyzUd?=
 =?us-ascii?Q?5aBIefd2IepObzbx7zMFH0nRnkyRZWwkh9Kg2liIxuDFpEWS?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514496B8359FB5B7D94E475AF7012BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85acafca-f9dc-4e33-45e8-08deb6c2d291
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 22:55:00.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxebX/6jnivItqdtFbQo44OyvfeUNnXua/WuFGoDfN4qwEqHWJkHUsCsWw+bMKiS5lsDuNu4H/XIxKUqTfcOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

--_000_BL1PR12MB514496B8359FB5B7D94E475AF7012BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Shiwu Zh=
ang <shiwu.zhang@amd.com>
Sent: Wednesday, May 20, 2026 4:34 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: fix duplicated buffer allocation for concu=
rrent

In case of concurrent calling to the bin file writing, use the mutex
to avoid allocating the temporary buffer more than once.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 576372ead63e..60a1d86ba9fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4942,14 +4942,17 @@ static ssize_t amdgpu_psp_vbflash_write(struct file=
 *filp, struct kobject *kobj,
                 return -ENOMEM;
         }

+       mutex_lock(&adev->psp.mutex);
+
         /* TODO Just allocate max for now and optimize to realloc later if=
 needed */
         if (!adev->psp.vbflash_tmp_buf) {
                 adev->psp.vbflash_tmp_buf =3D kvmalloc(AMD_VBIOS_FILE_MAX_=
SIZE_B, GFP_KERNEL);
-               if (!adev->psp.vbflash_tmp_buf)
+               if (!adev->psp.vbflash_tmp_buf) {
+                       mutex_unlock(&adev->psp.mutex);
                         return -ENOMEM;
+               }
         }

-       mutex_lock(&adev->psp.mutex);
         memcpy(adev->psp.vbflash_tmp_buf + pos, buffer, count);
         adev->psp.vbflash_image_size +=3D count;
         mutex_unlock(&adev->psp.mutex);
--
2.43.0


--_000_BL1PR12MB514496B8359FB5B7D94E475AF7012BL1PR12MB5144namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Shiwu Zhang &lt;shiwu.zhang@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, May 20, 2026 4:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: fix duplicated buffer allocation fo=
r concurrent</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In case of concurrent calling to the bin file writ=
ing, use the mutex<br>
to avoid allocating the temporary buffer more than once.<br>
<br>
Signed-off-by: Shiwu Zhang &lt;shiwu.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++--<br>
&nbsp;1 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 576372ead63e..60a1d86ba9fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -4942,14 +4942,17 @@ static ssize_t amdgpu_psp_vbflash_write(struct file=
 *filp, struct kobject *kobj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;psp.mutex);<=
br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Just allocate max =
for now and optimize to realloc later if needed */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;psp.vbflash_=
tmp_buf) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.vbflash_tmp_buf =3D kvmalloc(AMD_VBIOS_F=
ILE_MAX_SIZE_B, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;psp.vbflash_tmp_buf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;psp.vbflash_tmp_buf) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&am=
p;adev-&gt;psp.mutex);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;psp.mutex);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(adev-&gt;psp.vbflas=
h_tmp_buf + pos, buffer, count);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.vbflash_image=
_size +=3D count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;psp.mutex);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB514496B8359FB5B7D94E475AF7012BL1PR12MB5144namp_--
