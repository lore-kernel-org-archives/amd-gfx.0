Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E8CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 02:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4992310E087;
	Wed, 20 May 2026 02:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FeO2zHT3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010067.outbound.protection.outlook.com
 [40.93.198.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F15D10E087
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 02:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbyvTj5AjlQDWJ+c7hb+OsyXf2gIM4TReI68OoOhcQkcx7sTiB21PcgOaKe0Im3i/TKSnQ+sF+19MA2HVH9pQb40Vx2lMfzeE2WfqVb4szeHYCBCp3foGVF41eyUf8THvpVSfZ0kB60uwPPYOxc0JNBoxsWzBDrv37gkVoOU0fT1prmzahv7d8cFf+vKhEcljjVzXP3ntLVp6pibD4M1/aU2B3ixmXlKdcSeYwGHorLmS9EJ8Ivs9/Ptvm48ETYY626EqlFkpZTNA8lkDB1W4P+QnKprigLSX5MNkvLiyxDS/wmZ2uetWGPiuZ3sNfQkZSkhVTmGS4op+03o2rsORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FNhpWOf7JXOwVPphJRCbdKi+e6LcGel3VLkREfl+sg=;
 b=HwhGFPhBDzapDI+MHhfAH4ALkMhhVDkZ6TGtLNDXk8M4bWbxPOfMS/G3i9dGFdeWthzhYb3VEJKjrMUTtelR+cUuxUzDXqILaex89OChBuJpFj2Tw62TK8ZmSP1CYhPP3A26vy1tCC0TqdDePMRcVwiB4jDdBjv0Zvn7gukxYwd5/hEYqv04WExblf7Lp4YS/8pONGrN7bh6uW4d8NqkTayfuKD7Yg8UDfinK12+vN7lYFxIEeJ/fFTNa5UUFstOzETAQ/05pVpsFoVTWWqQHfQPGYYfHX6CcJpOSZg62+rARMHQ9kJRFXDIUnqGJCQrD60BHh/p9q52pC3Vi6u65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FNhpWOf7JXOwVPphJRCbdKi+e6LcGel3VLkREfl+sg=;
 b=FeO2zHT3nOnJAmMxJ10oMy9JW6etqbcatPIwm5L+WuStird9kfrr8d4P9KvDofwMnA5PDBrhNW7dD+rwLBHZCEjCyUbZNJgdNdPgNsdSyISTjKkL8He1K9pD30Q+DmqZaR1ZRtBhagCaOkiSxyaXg+PBcwF/Q0h+c1luswlw3Rk=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:21:14 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 02:21:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix TOCTOU on UniRAS  command response size
Thread-Topic: [PATCH] drm/amdgpu: Fix TOCTOU on UniRAS  command response size
Thread-Index: AQHc4XKmU4AEInJrDEK1IGsHYvEc/LYWO54g
Date: Wed, 20 May 2026 02:21:13 +0000
Message-ID: <BN9PR12MB5306DDDC411104732EE61024FC012@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260511181854.37706-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260511181854.37706-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T02:21:13.056Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|CYYPR12MB8853:EE_
x-ms-office365-filtering-correlation-id: 37c9a0f9-dca3-40c8-c22f-08deb6167710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3023799007|8096899003|22082099003|11063799006|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: v5R3c8n1zsfIthgQClhXDtHbKi7z9vBpNhNKnjl2Efz31yIG77srBnpT3q9MbD8c80amyDdBsIgc4ZWDxXRZJV7GLlqeLL67Ot6kPQlNhrm3NpJrkFFcHM3ZWvYKZtBPWgpITH9ocyEWnMPd3IDt/qzJLrLCE3UxQlDZeUO8tjFnPlm85Iz2cDW9VcVdluPtPHsdiN+NGQS0kj3BAhVKXIgEaqQWEce4o9ACHrMD2cU1V4CY9lKQ2IYIST9Z6TyX8K6+A2FpR83vQCyXad0gsnDMeBrdfgq0/sydEf9ylBKxz7TgzaRlCJgMhaLbaOPHKK2A0EgUEuEXdMHkm0ARf50b6g4dOKrqA3U5Bh+5EL91ytFRsZRbooM1QudoPA9Vn8oLxAcy8/4+hNMhGwGRvrMUvzjVQspoWzjf3feBo/mnCsXalN60XLwVuLKxEVxXYa4HBxzCKT64RIfTQAcnhqMC/Ug/d5CbYno86WhCA/RgVKsZ9GEiVr2AbT/oDlvesjAnbFy+Tk60ifzSRQzJTL6sDh7ZU6up45oUD2otEEu9doCzFBiSK3LEcMFso9DRxh408zFpGh6d4JbCrpnC8TaEhJvBQ+zTpq7n62HqaR0ioVtF+jTlzt1vyjYOyZT4HAeZWSMP2Ez/c3NTIPaMMKKyoUFFtkomI03sMcSdzeihH8uASFrnllfnDmSAZT0ky67dvtDu4d3NixjvfJp812pSYDXCwjAPAynazQgK3ZMkZGOM8F3GPMD35zNy/4BY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3023799007)(8096899003)(22082099003)(11063799006)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?dTNCrAmbV6jaUwAGtgpwIytSp4GKnJXZuo6e5Qje0SrT/BMTUG9y4gX0?=
 =?Windows-1252?Q?uBqSMY5ZuHrPRwTL2HLfv2TCJgVTTV9OI94dVXgPPTFAWalmruMuuesl?=
 =?Windows-1252?Q?MQSNqFNpeyXSo7QtHswoB2KJ2/ESMA8c8/SZECkSgy59mIi8pi0Hrw3a?=
 =?Windows-1252?Q?fbfX/x2FCAunQivwSnwFZMl/rCxx9S80Y/nTluXDj+hl0u987hRgXa5Z?=
 =?Windows-1252?Q?B7vJtKMpJ3tst9KQ3N4tTCJvVhVgRb+1TXI0/hphusuhKLQsbtgaNK2M?=
 =?Windows-1252?Q?7u11hvvt8yS49qGdmHV46tx3eniqd8bVFC/BVSfASdi24UazxsEq7Kiv?=
 =?Windows-1252?Q?mjxMQneLGmEMA9K+EOIl1GFJhKz0hzfg2SeveoR/21sHa7Y1i6fWZSCs?=
 =?Windows-1252?Q?0sY+lYEbX20JU8JXuH34Hx6Kx3cF1KLwyGLvawOFO8U7xxYgfzxnO2Aw?=
 =?Windows-1252?Q?BwFC3ghema3Eh/FBVVJn8ApusDuTxLURnuennmpRxld6IveOzEmC+O2c?=
 =?Windows-1252?Q?WsVbmDTq8bhONWk4afqmdSNmksT4NXDrwfGFv9nTBYh+uKmJiU9PiQIc?=
 =?Windows-1252?Q?nRcjr4EeXQGCSajbDiLa35hgZfwGYn2gQsrrDQVU1+opoWD+xAu7wrSn?=
 =?Windows-1252?Q?OEG0iXaIv0g3ULw4EENgMuNxLf+h2i16MGCxfNxeuEz3IDm6BwOfNeJx?=
 =?Windows-1252?Q?A69kJKyohNt4PcCPKPlfW96Sxv0rdQ/OvblFilEAuWQdcStBKy+HOUHF?=
 =?Windows-1252?Q?Cwm8GoI/EY4c1qXLE0cJsRZ/gjB7x+OY7jW4mLy1OAuqrHvXV1WF1kwd?=
 =?Windows-1252?Q?L0H0IhdyXeo9yAek2isMJscJAUp8TBBPTXA3jizgm3MQOMEU/LB8Tz4U?=
 =?Windows-1252?Q?BIkJNS0znydZyx/S2jsf8Y+IszcSfwITNGa8X+Mplckc79ybIEys6xQj?=
 =?Windows-1252?Q?W+5anIG8yeDTXod+PQttlqqaO/r2dlZXylU/mT/8z8nyqOv8b1sjvE3c?=
 =?Windows-1252?Q?EymaE+Z9UqV1BV5ZHsH53bqqED1icG7ukLkr+0hQYMMOl2ehFbBNMeox?=
 =?Windows-1252?Q?nzpbnknC4uUf16qvPj92soucrCf44lh+JL/0KWOEPFgfBweJU6lvP2A1?=
 =?Windows-1252?Q?6qXVKkxJ9VoXBwtub0SBdEH9uht8z6YjincUHclTL3+TF7CYHamq/STC?=
 =?Windows-1252?Q?tQ5gPckhxDRTEFJuTvtAgCvb+6fhlyNCigngPR36+atZ4xRxUZQYbtyA?=
 =?Windows-1252?Q?xkHgyTMZGEG2gcU/6pffTaf72BW6G7URxSypEaivJrLPLfAoGKEX6j5D?=
 =?Windows-1252?Q?aGBEFerGrhjS6doph5/aE2j2Zqn7wlUnXwai0fMGdmVv5Iyo8JcWcVut?=
 =?Windows-1252?Q?57uGAQXvgwtpt8sLMO1CGF6avOlqsqsZr99Q/eqp0hs0Wwx3e8a10gCE?=
 =?Windows-1252?Q?/73xY3nXJz3PuN3aejtsci/SOI9n7lu6y0vbQaH6876Ll6ogoWEPPrz9?=
 =?Windows-1252?Q?lWLrO4GvNdZI1g0qLWpbLJ22b9t2fFHkGBq4fG1mJ+RM+7xEw0Tq7Nf8?=
 =?Windows-1252?Q?oegoM521SPLpYBQ6Fe1qXNoMErj1VMOiiUiMW6v3lAmudDKu86/jwjLm?=
 =?Windows-1252?Q?uigYZUgUteOYSJLBKhfHvGB0/RnkXOj1xieVDqcgg7yEfOVI721QVlbE?=
 =?Windows-1252?Q?M13vD4COxqL4H1V/c16ouZJ91HPrXH60g1Jnp/1FMI5k1LrSaQmFLQnD?=
 =?Windows-1252?Q?HdlkPTNtthsguiUfkhpqNNOt4hB7LVxNScvybwaO+LVufxgl3lGe/E/F?=
 =?Windows-1252?Q?eeN3G9d/A4EagLID8hx+f57ZR1osiYV4AfTqmTnE67YHAi52?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5306DDDC411104732EE61024FC012BN9PR12MB5306namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c9a0f9-dca3-40c8-c22f-08deb6167710
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 02:21:13.6274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8TjeL/RJCtp4g4X8zfLUb6gFOI1UcT7QzOOltqXRDfC4/GrzKCWs0qZD/67s2OpFY/2z520UhPQVj6aG3ue5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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

--_000_BN9PR12MB5306DDDC411104732EE61024FC012BN9PR12MB5306namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

Best Regards,
Thomas
________________________________
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Tuesday, May 12, 2026 2:18 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Chai, Th=
omas <YiPeng.Chai@amd.com>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix TOCTOU on UniRAS command response size

The guest maps the PF response in shared VRAM (struct ras_cmd_ctx in the
command buffer). After amdgpu_virt_send_remote_ras_cmd() returns, the code
validated rcmd->output_size against the caller buffer, then copied
rcmd->output_buff_raw using rcmd->output_size again. A malicious PF could
change output_size between those reads so the memcpy length exceeds the
caller=92s output_size and overflows guest stack or heap buffers.

Snapshot output_size with READ_ONCE() once, assign cmd->output_size from
that value, and use the same snapshot for the bounds check and memcpy.
Also read cmd_res once with READ_ONCE() so the error branch and
cmd->cmd_res assignment do not observe different values from shared memory.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I815c5edc234a651a29657d126bf117be9364920a
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 838eb91aef391..4a10c19128fb1 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -108,15 +108,19 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ra=
s_core_context *ras_core,
         ret =3D amdgpu_virt_send_remote_ras_cmd(ras_core->dev,
                                 shared_mem.gpa, mem_len);
         if (!ret) {
-               if (rcmd->cmd_res) {
-                       ret =3D rcmd->cmd_res;
+               uint32_t cmd_res =3D READ_ONCE(rcmd->cmd_res);
+               uint32_t osz;
+
+               if (cmd_res) {
+                       ret =3D cmd_res;
                         goto out;
                 }

-               cmd->cmd_res =3D rcmd->cmd_res;
-               cmd->output_size =3D rcmd->output_size;
-               if (rcmd->output_size && (rcmd->output_size <=3D output_siz=
e) && output_data)
-                       memcpy(output_data, rcmd->output_buff_raw, rcmd->ou=
tput_size);
+               osz =3D READ_ONCE(rcmd->output_size);
+               cmd->cmd_res =3D cmd_res;
+               cmd->output_size =3D osz;
+               if (osz && osz <=3D output_size && output_data)
+                       memcpy(output_data, rcmd->output_buff_raw, osz);
         }

 out:
--
2.34.1


--_000_BN9PR12MB5306DDDC411104732EE61024FC012BN9PR12MB5306namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Reviewed-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, sans-serif; font=
-size: 11pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, sans-serif; font=
-size: 11pt; color: rgb(0, 0, 0);">
Thomas</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xie, Chenglei &lt;Che=
nglei.Xie@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2026 2:18 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;<br>
<b>Cc:</b> Chan, Hing Pong &lt;Jeffrey.Chan@amd.com&gt;; Luo, Zhigang &lt;Z=
higang.Luo@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;; Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai=
@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix TOCTOU on UniRAS command response s=
ize</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The guest maps the PF response in shared VRAM (str=
uct ras_cmd_ctx in the<br>
command buffer). After amdgpu_virt_send_remote_ras_cmd() returns, the code<=
br>
validated rcmd-&gt;output_size against the caller buffer, then copied<br>
rcmd-&gt;output_buff_raw using rcmd-&gt;output_size again. A malicious PF c=
ould<br>
change output_size between those reads so the memcpy length exceeds the<br>
caller=92s output_size and overflows guest stack or heap buffers.<br>
<br>
Snapshot output_size with READ_ONCE() once, assign cmd-&gt;output_size from=
<br>
that value, and use the same snapshot for the bounds check and memcpy.<br>
Also read cmd_res once with READ_ONCE() so the error branch and<br>
cmd-&gt;cmd_res assignment do not observe different values from shared memo=
ry.<br>
<br>
Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
Change-Id: I815c5edc234a651a29657d126bf117be9364920a<br>
---<br>
&nbsp;.../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c&nbsp;&nbsp;&nbsp; | 16 =
++++++++++------<br>
&nbsp;1 file changed, 10 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
index 838eb91aef391..4a10c19128fb1 100644<br>
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c<br>
@@ -108,15 +108,19 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ra=
s_core_context *ras_core,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_virt_send_r=
emote_ras_cmd(ras_core-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shared_mem.gpa, mem_len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (rcmd-&gt;cmd_res) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D rcmd-&gt=
;cmd_res;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t cmd_res =3D READ_ONCE(rcmd-&gt;cmd_res);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t osz;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cmd_res) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cmd_res;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cmd-&gt;cmd_res =3D rcmd-&gt;cmd_res;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cmd-&gt;output_size =3D rcmd-&gt;output_size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (rcmd-&gt;output_size &amp;&amp; (rcmd-&gt;output_size &lt;=
=3D output_size) &amp;&amp; output_data)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(output_da=
ta, rcmd-&gt;output_buff_raw, rcmd-&gt;output_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; osz =3D READ_ONCE(rcmd-&gt;output_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cmd-&gt;cmd_res =3D cmd_res;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cmd-&gt;output_size =3D osz;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (osz &amp;&amp; osz &lt;=3D output_size &amp;&amp; output_dat=
a)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(output_da=
ta, rcmd-&gt;output_buff_raw, osz);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;out:<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5306DDDC411104732EE61024FC012BN9PR12MB5306namp_--
