Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0810C54E41
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 14:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276F710F22D;
	Mon, 26 Feb 2024 14:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r2J4uaOx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3ECB10F227
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 14:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaPHYKjF+T9kc4HhtPEef3YmM8kt5T0aNJsCGyRpQwsbZ2G2TxdtVb7sy/wd0203wuHUkfKRFRYhzCK/zzdZZwleYOFUI3Ywk77QuU6JTGcMgbDrdE7/wiu5ycI8sEnT44qRw3oMoYfBqdXXR59wF+lJvYJGtrJJx06b9REHnBISDw+Mojxm+fCrLeyCajkhDuT0EVtX2RL8J7/UlInAkI1ipu4sIcy0slcrPLo98QPC96gVggYgUROXU8EgGy3U50gGOlgWR3DYIqUopj+wA/euimM3PNyS24rvNBMcB3YnL+J2DfSkIugXJyQjsKdJ/ZpNFDwU8il6z4XUkYqmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPJ3ZTctucAuCiZCUnRu0XNdAE5tNSvF6Q5b913TlL8=;
 b=dOPq3Sx629f7hLfql48tsN05aZA1Am4Hy990FcRhyGKYpidL/Q72AWJ217xlR9eDox2Eo03TFjE/rcTnu3JO7mIkRWXWlpGy7FboSD6Uoi85NJ48qWTKu8TpyPBbg9prkNPbl3xy3Qs3Qn+Sec59RoNYOFR1jr7CH33zbQrid0d25qfz8vFisAF/X6bOCULKqWOLPRmjjOnYkp+Jm02FXw2c7qQIniCjTEMYOZkRufy/Ce676MbZ3TcADacOcPJJOBj76/G204QKwkWlNwgyk8h4QWgqnnR6waL+vkTBYSCsfbrNsxqGsHI72KYTZb1pDqvqqC7dSzww2ZDGgxIwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPJ3ZTctucAuCiZCUnRu0XNdAE5tNSvF6Q5b913TlL8=;
 b=r2J4uaOx7Mcsk9CpOoy5+sg1pPXt929x28ce5w6zdTZYv/vRmDQ0KIkDPEIdBkfpnEzznTeso9P6W+IxSh1nu7mZxaUBjNZ/nWaommiEZ8WIeSxTNPs53G3SJCYPvku+lZlF+YJiBlHWBpJ2f/jcuYHDz1LzvUFp1Da11aX69OY=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 14:52:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::b001:1430:f089:47ae%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 14:52:54 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Jammy
 Zhou <Jammy.Zhou@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
 atom_get_src_int()
Thread-Topic: [PATCH] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of
 atom_get_src_int()
Thread-Index: AQHaZuwpIiEQ/+idV0eFgsrg6+n61bEcuQh5
Date: Mon, 26 Feb 2024 14:52:54 +0000
Message-ID: <BL1PR12MB51442D40464ED45BC8C4F16AF75A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
 <20240224063847.1512027-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240224063847.1512027-2-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-26T14:52:54.223Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB6134:EE_
x-ms-office365-filtering-correlation-id: bfb7428f-af62-407d-1e07-08dc36da9d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bIHFdqHrVsGyIzYOdI7XlaQ86XpLySFEEgtnje2kb9Y7EI8RqIQyvDYYMCD8zgelNwBvsVvt93gVW6WYpqZqS1pejGzTz7lYI2S6t4DKmt36jGkV7WZbFNMQSMmrEfl+bptqdKs9iQDrE1DGhZKVMuL9f/4ZguPbEsstR55ait41JdBHhwMAqcVocuTIZP4AkuEKKRIMZ44thuGL1/3PSUQXFABUcV/+u99AsIWj61LcJyZJd+KhiZztOsGmoviW2zwy7PWhlEwIgFJCFH/L0eH/PMOfQUClghKlNnBrJUi1dmNy511S3f9LxF8r0fUBq6AwQCaxhq8k34MV4gE5mMgmZcqPCpc7EYOf2/MtFDESbZ4NwjfTzUkagzDCs66cHt8n8Pw4jNT4wWxbudgNw7waCHzdhPm8jSCbs0BujS04Hnvdy5VGKpBSI2PphXOFBt64WRIHrL5qRZ/Lg1lHkBRqItvMfwbx7CweuauCsCIaFY9YYB0s8heCoPiwTyXligi6BKH/sKCR8+lHF7kA/UPJuQi8IRUg9fpYowPn0CleFSwW1ywcEm+P6xfoXo1zg5Ib4aUJBKFdbDUt5hy5oZ0J4EEZ1wX0pHhwrTR7vrbf/PasvjFvWvZ8bTmmlbQpREfENv5DLhrtgIduNnvBNVxEgGdtM1hXLrRwYUKnxr2ubLqqaV8rb3bDuPddV593E8oI2SI1tWtmyFmPII05HVwOjORYexq1ItlDKoIJAA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x+y+uhhm4KwAcdiYu3jYxtOFZUDK4sZA5NYYsZMEE0fwb+yiqEKIpCAo8x?=
 =?iso-8859-1?Q?i4A2XPplYpB0URSrG/JLLivpHVCYuF/Dc3BizrtFoDzUG29Pr6svWBAfMB?=
 =?iso-8859-1?Q?fp+F4XWU03KvzqTiANFkbFPbxbqEK2QST3QSdXeAwfwqVIFmbKZenMYLAd?=
 =?iso-8859-1?Q?mFpqEcNIBwOTVUg7D8Rh2QfZe7zdxecjCP2iyYFnnt748A6hnf8LMHfSh1?=
 =?iso-8859-1?Q?DgRjN5MEwtBvP3Ix5ot4kxRQq6FDcal4eNpkmF4C5dZwvIXC4JRu8DWZl4?=
 =?iso-8859-1?Q?oU6xuEdQm64j2Vjt8sa0BmXBGIe4tI8f0cTKizMsBfvbihn6TlgUqGm9o7?=
 =?iso-8859-1?Q?SeDQYbQca1Scr4MIk6AIDcWeXkPA959/8V7bJL7Deo3GPcwQnNLO5tmxNa?=
 =?iso-8859-1?Q?kSY036xKKoGxywR+4Whq1mAn7SPruuRSdxJNgWxh6Q5il1+ARqEAsKb3is?=
 =?iso-8859-1?Q?nTM97PworzUFjIucPYLnZ4EnCQyljCSLS6CYXaTFZJ2xNGh+N43KxdmfM1?=
 =?iso-8859-1?Q?1bdr4RnsBOq8UkO1KdPWzB5TKtu3R6TS6s0EZhrqrZH0s8PFEmsLfaRsMz?=
 =?iso-8859-1?Q?V+uRU7XWycbG/BpM0UYL42B1+/1rpEcswSeiTcsaxKqGEU4KDZC4vI0HL7?=
 =?iso-8859-1?Q?VJugHqoUb1PsnhVFrU7o5KptjIXJ4I3IaEYJJxGrjzpwFoV0kVm33WNi/u?=
 =?iso-8859-1?Q?HStl7Luqeukue7Z60KsaHTQ1VCzWHYm5WDAQhNnasqkIm68w5ZDTBIlbsH?=
 =?iso-8859-1?Q?4DU1b3HIRkypPDZCasiNeOStVNO0XX6TPqt0S2da59rlZJ/AdS4vIfA6uU?=
 =?iso-8859-1?Q?WXiXXZEQ4Y3NHB8cnKyzJDfeyFiI6654oxQ6C64g2t4pzEYeOH5sRqNZUT?=
 =?iso-8859-1?Q?VdyL35pA30k6+EMUWn/OlkeE+BmH8YkhbioOKdx9ICozMdpnhmgTUzIwlB?=
 =?iso-8859-1?Q?sXBPxzIM3Hd96OEUUQgXFoO1sbUelCmYatz0sUUVEdtb6CgpSHDXmmvNeV?=
 =?iso-8859-1?Q?bcZ7K8Tnz/z/4QdMG8Xk0JguuFlDbmc0OMVfCzUyPLTzghAjr53bTmKLJx?=
 =?iso-8859-1?Q?DjYji81WS0LF2gY1gzQS5+KU3m1OO9HCIkbg0t4N6SqOwg9vEFVQCz1kfN?=
 =?iso-8859-1?Q?IzkDMwDL1x9SCIgXn1U9ZJcw57ah149dU1sn1nITDfL+gf0A30xQR4lUy5?=
 =?iso-8859-1?Q?kekU57wk0msfI80+6yBKPTcvh0sSMxGXuHmIRLXcNjNiG9sm0omVMNMgKD?=
 =?iso-8859-1?Q?nyzD4WPJasMhXyMactK/wjH0DaGSScoeJJHuLFhLUMG9uWCRXiS4+xzrf+?=
 =?iso-8859-1?Q?foi7Dv9wy9tkPTg4hClsCxZWFX/ddU+0CCEaOUzRtyt1tnKCXFz3ckUAMn?=
 =?iso-8859-1?Q?/W9HkvbmzEh4CJ/C9m9fwYCnibfOopr8TJgVrg8KoC/0T3eRD2lNqFJmg7?=
 =?iso-8859-1?Q?p0dpWzMtZYVuuR7ph6R5dIagVnZldK+XcreEQ94DU8GAs7LFQuSWOmXnpa?=
 =?iso-8859-1?Q?LCG3yQXfmmmAnJ8ElMo/d5FMHb/v2v2CdcDV5tN9iADg53PraY/DNoObGs?=
 =?iso-8859-1?Q?eAaTegSywJbloDjLBi+HgziLM+MQUbkdq7NmijpicSt96q1+TICFzdcS3E?=
 =?iso-8859-1?Q?ZCraD6tIf9Ojo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442D40464ED45BC8C4F16AF75A2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7428f-af62-407d-1e07-08dc36da9d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 14:52:54.5855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+/kRlnuqKqxPLEJ9rz+7lHYvMlymD0Fl3/VbMR/GyujSZt/ltTxODgoK43/Rm2LfIHccBK5L0s/pzq0PCH4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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

--_000_BL1PR12MB51442D40464ED45BC8C4F16AF75A2BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Saturday, February 24, 2024 1:38 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Jammy Zhou <Jammy.Zhou@amd.co=
m>
Subject: [PATCH] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom=
_get_src_int()

Missing break statement in the ATOM_ARG_IMM case of a switch statement,
adds the missing break statement, ensuring that the program's control
flow is as intended.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:323 atom_get_src_int() warn: ignoring unr=
eachable code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: Jammy Zhou <Jammy.Zhou@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c
index b888613f653f..72362df352f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -320,7 +320,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx=
, uint8_t attr,
                                 DEBUG("IMM 0x%02X\n", val);
                         return val;
                 }
-               return 0;
+               break;
         case ATOM_ARG_PLL:
                 idx =3D U8(*ptr);
                 (*ptr)++;
--
2.34.1


--_000_BL1PR12MB51442D40464ED45BC8C4F16AF75A2BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Saturday, February 24, 2024 1:38 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Jammy Zhou=
 &lt;Jammy.Zhou@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case =
of atom_get_src_int()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Missing break statement in the ATOM_ARG_IMM case o=
f a switch statement,<br>
adds the missing break statement, ensuring that the program's control<br>
flow is as intended.<br>
<br>
Fixes the below:<br>
drivers/gpu/drm/amd/amdgpu/atom.c:323 atom_get_src_int() warn: ignoring unr=
eachable code.<br>
<br>
Fixes: d38ceaf99ed0 (&quot;drm/amdgpu: add core driver (v4)&quot;)<br>
Cc: Jammy Zhou &lt;Jammy.Zhou@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu=
/atom.c<br>
index b888613f653f..72362df352f6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
@@ -320,7 +320,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx=
, uint8_t attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEBUG(&quot;IMM 0x%02X\n&quot;, =
val);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ATOM_ARG_PLL:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; idx =3D U8(*ptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (*ptr)++;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442D40464ED45BC8C4F16AF75A2BL1PR12MB5144namp_--
