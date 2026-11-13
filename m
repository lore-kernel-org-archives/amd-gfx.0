Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C7606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F2C6at5a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482E310EC45;
	Fri, 13 Nov 2026 15:46:08 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013002.outbound.protection.outlook.com
 [40.107.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECE910EC2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAG6bSj2XuL+BzuiGTDWhtJF0+WlcYSsRZbKnF9tNzx+T/2odaShxKeqjfA5Cy/1fVC6j+5LHIOYPhIxy9ZaxwLpUEiqdMc1onag+v+00oybdsr4r1g/sxJljN+6zLEilhqJShj5Jv+2DMfMPxeyaBhMB4742BcuQQ1Bn0CWb0+DWqfV0JRuWZChFmDoWM6kB+y3Km1ONdPfWppT9V36EsPLelKYjlXltee359K5nvEh3hNhObVPv92KW2SXC8ABDIwZS9bl78mMkw61aBxHMPcWan65bdcwDrAM0SOtPlnWRmHdWs7xh4BL5QfFixi6AiDlXuyF/0Gcfh5nDuy/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+1h+A6Yef516UOd44fh+/KHh/1mZGCRdg/lEscli8c=;
 b=yKTVBCeN5bXIw8baAlQ1n7pYHqh8yCRbpPpRkJQyqzrwDlM2Pf407KPNiKgZ8JxXTLUON10kigSmqtUAhkRyq3FYLLor7/6DYvsxO6sT7viPriYco7xJV3y2R6uLdlMGvsqVNQxWcHYe/OCtAWFx632ju5WaGxvWMJNRTWrPLevGvCP5Z5CtDgto9adewAKjwMG1FZExGBHZRKmild5HEho9FaYFaEqR39J5kdhT9CW7anuiF4VmUJkqrinSdMaYmG6LsMQw4eEFS2i2AvIr9nfEaObJ7H2tRlOPyf7Fbq0dtTdHZjm6cchfqONWuM2qH0QyEXrhPYCAwXy+zF8j6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+1h+A6Yef516UOd44fh+/KHh/1mZGCRdg/lEscli8c=;
 b=F2C6at5aK+2viXP+3rDXkrNXBLzhrovRO0EYcLcfOgu/CZNkliBc2KjmGvb6LnjLpbsaITU/VbSg5SslHmsEQjKsdAJ6QkBmU4gqVpbXF6tjJpnFQ4v9N45XpA3nysn/HYoDFmAkyrx8SS4EGsKLvXIaOxM1jlh7hSrvi8SiP0g=
Received: from DS5PPFFF21E27DC.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::66b) by SN7PR12MB6713.namprd12.prod.outlook.com
 (2603:10b6:806:273::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 15:45:56 +0000
Received: from DS5PPFFF21E27DC.namprd12.prod.outlook.com
 ([fe80::7bd7:c841:6faa:48f1]) by DS5PPFFF21E27DC.namprd12.prod.outlook.com
 ([fe80::7bd7:c841:6faa:48f1%4]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 15:45:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Topic: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path
Thread-Index: AQHdc2MgKnddJsGKx0eMecLZ1eo65bcsBCMA
Date: Fri, 13 Nov 2026 15:45:55 +0000
Message-ID: <DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2@DS5PPFFF21E27DC.namprd12.prod.outlook.com>
References: <20261113032813.352632-1-cesun102@amd.com>
In-Reply-To: <20261113032813.352632-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Ce.Sun@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-13T13:47:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPFFF21E27DC:EE_|SN7PR12MB6713:EE_
x-ms-office365-filtering-correlation-id: 070f27ec-80f9-494a-ea68-08df419d3493
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261026121527099003|10067099003|261009223027099003|261028144727099003|261026140227099003|3023799007|261102123227099003|261022105027099003|261022075727099003|261021121427099003|56012099006|5023799004|38070700021|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: HUMUDkuWhu7bL4n6eWurfkgu5u/n+rk2gj96zM6jTzHWbovzzhdgGBcQKUVBatZm5VbzKdt0DlY6MlSll1QJyfqRxrdflp260iMuIxuL2H1SWnmK01ZQGEru1Rm/N9gh9HkFmKfF7gSy4pjmTGmXbDCLutBGp2AD8a3uD1xLBdH49OZwROekN5MIWwB6p0agg55st2vrUXY5hKzS/iX8nwqU67hbR1uMj0/WGC5ZRP5g/1qBKDMpjkd8nd5i8fvHuyxGmxiPJyuVkRiAmD0UdeWpBtBZzQrnAsRqycPiImT6Mkg3ni063qG3R8kk7ChhQO1x6Vi5yjjEH7uVwBu1PX8pt3pfkG/NNEvnJXaTjgBJwmJwcUTiPDzct9ge2BF2uo4BgCtqho1oywszrPXJFUSRPGM6okGtnOJ7ycs4Xnkv7czs2W5bmro1xD+JcTn6t4gqV07lxrMHvDuuCmIfRKuZa1w7bfnZnzYU2G9P/xRcXwPlkzl//DJwfyXu201xOsWqRdbYxRzLQXnHqErWSKGUvu4uUTjkkKnhNN9YfOdnxeftT3KFEKScz1hEGknBvgHRLrAwuoU65kf/2raPZpeSvnyuCDfKe55WBoDuKD9bJEtSsIEOcnBGtxKMP8Pz8UT39AIdTDL0pw10NUhshifDVaEcAzUd7a+WVwjE1D0VKBQbuFNJNBRVQpVICub5esRVHuV8QBkhL/4ZBpUa4u13oGU+5CyACPVdo2+7xFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPFFF21E27DC.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261026121527099003)(10067099003)(261009223027099003)(261028144727099003)(261026140227099003)(3023799007)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(5023799004)(38070700021)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?idUWAnzhv3j+DlTKEofjhVOeXb5ih+sUW8nq8+rr/PkqF1SbG5Fq/WrFVwuP?=
 =?us-ascii?Q?HnQYT9gPYVAAobCYQCvsKVAZZO0dYELuou8oxmIw2QYQ859prD+QVU48EQBX?=
 =?us-ascii?Q?ODFGw2PQG+Tf5eLPT6TG/6KT24HJQ1lYHFYCw1kg1kVrK38E09cCyXaLVdFt?=
 =?us-ascii?Q?nFOLG5vfdzbjbUazFxZ0S8Osp7UumnB37nBEfCvOZR3sytZ1KvsbFGtLZWEV?=
 =?us-ascii?Q?CQGxrHSQ1jTzSgDgO1kmuAY4jzbin2D/37jxFzXyauewwRH3YshnpHkZxKQF?=
 =?us-ascii?Q?pFDIv3LEczEC1dn6neJrOrdVA/ESL4HM5PPTxqn2VNKIxRH+ywkDDMqYKbm9?=
 =?us-ascii?Q?np41XnOjxZVi6sYkEXobuoXQ90gZX5v5pWvLKeUdiaZ/+gFW5wkBZYhT/I6P?=
 =?us-ascii?Q?XTqa78Jr0jFbi9HmNb+7FU2UbyIU0+rYd/EZJC5bzvUGqruMGY2K9KkYGhhW?=
 =?us-ascii?Q?WAM1nwqIQCPnC18WqRFePgxdQmEThAqTlQHF+/IBTsDs9CADELFnNfcVMSTK?=
 =?us-ascii?Q?7BJqdHqLOhsM2YM2Vap+1LTcFbf6XZVmqEBDowkaWS4P5cKqK1KpoU983kjL?=
 =?us-ascii?Q?UDsc5j7U/4HhsOzbMZyq6DBYrBrKDu3c0p7dshEYi8PPh3xHJcM5KzSFCdDq?=
 =?us-ascii?Q?TEYI02vLpiO5cH6vS+O2ooUpSTz0DmD51V8rxyF9DaAKNCliXxAYcXL+jFw6?=
 =?us-ascii?Q?FvFLJp3agWrXEK24vf627wynh05y/bayCmDIfCuOFnLdwgChHS7X5fjitODy?=
 =?us-ascii?Q?ek4HuwL9GNKnHZSQSCmtqbozNJ7/dYpwwEg+XZxQsGazLwjlIl2XuzQ7ygnY?=
 =?us-ascii?Q?FjeTcDZnm6GsNxHEFYO6HAZNthAhhghKJjhVJeSW13JM9MEWbW+GJ5JGT2/r?=
 =?us-ascii?Q?nyQ3SrjvQQwLMXIZgxdAz9EI6X/a4ICuJ1sia4k4D0czZNYvDn0WDt4a8ZnL?=
 =?us-ascii?Q?zz+Y//6XwsJjB7wi0uubButhPO2GiTuWI73KiWlJh2Py/YR6aArqvtt60NJ8?=
 =?us-ascii?Q?hBI4x6j6jvOvdGS+fqOBqvrrkESlgYyQHyPigtBPA3XP3B6exfbVaNvmD7pz?=
 =?us-ascii?Q?Dwnbk4AQwSy+U94PKdgQd8w50xl7ZgYr9YrTKvKQ7cx7oMupda3I6afuqFLI?=
 =?us-ascii?Q?t2nHPBDTC9ddr9ucYIEdMgJ4SHG1E3B/tahLgYM9SeE+srmg3hNSxZfLBbTq?=
 =?us-ascii?Q?eVMy33Aj810VB3E6kibhtyg7Aj608O9keOrTCA4EC2zdb4knETJVDz4H6UCf?=
 =?us-ascii?Q?rnZklxFezPfJtp5qJ7l0YRrnoavlN1cIZdO9LdKDK9XOhOT2IMaMgmjiE1Ak?=
 =?us-ascii?Q?VFoFT3yyKvVpAJheZ+0TMsJvMu8zXjZxAXyBU8x3KlBK5wMNyKc3QSfMjXdt?=
 =?us-ascii?Q?GUAjP1heQZ3z9qCWNYpzaSoZ2O/oXDmOPlsbmw4V8FHoyWEiNKi7+j621R37?=
 =?us-ascii?Q?QzAtG3++prMl8IjEoES9InXwU0Exqs0k6nYcK+UHUKsZwp08eHc1l5xERvDU?=
 =?us-ascii?Q?3X6uarszRdGTnIaoi1wQb87jup/dDncvJ2guJW95f+kaCT7IKP+wErtpp0TF?=
 =?us-ascii?Q?WxInrpZtzRlJlckrfcg9fRKD0bomWiaarZikcFN2l1LjXIry0cLFLUIAMjaZ?=
 =?us-ascii?Q?2egkeHuxm/RaR8MJuJZAIWnZE7kXEuiFK+zPoOH0Jzpd6IuhqvV8/sEJCCYO?=
 =?us-ascii?Q?ykZQk6G3+dAPq5lOcdj4WlV6MSo9KKeKizkUmoapXvrmgXG3?=
Content-Type: multipart/alternative;
 boundary="_000_DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2DS5PPFFF21E27DC_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFFF21E27DC.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070f27ec-80f9-494a-ea68-08df419d3493
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 15:45:55.7647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6MrXwp/yN2M1hgD4aIZt3GDgEMA5FmoEaS5xmQBxRsTITFVRioNgIvZlBjG77oFGAhfb6Vv7B9PLSqntR+OYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2DS5PPFFF21E27DC_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Hi @Sun, Ce(Overlord)<mailto:Ce.Sun@amd.com>

I'm concerned about the current amdgpu_uniras_query_block_ecc implementatio=
n. RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and s=
hould not be invoked in the current UniRAS code path. Using it in a bare-me=
tal environment would trigger an unsupported RAS command error and could ca=
use GPU reset to fail.

Could we evaluate updating amdgpu_persistent_edc_harvesting_supported to pr=
event inappropriate calls to amdgpu_uniras_query_block_ecc? We should also =
consider adding an explicit check to ensure that amdgpu_uniras_query_block_=
ecc is called only for SR-IOV VFs, or retiring the function if it is no lon=
ger needed.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ce Sun
Sent: Friday, November 13, 2026 11:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Sun, Ce(Overlord) <Ce.Sun@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path

amdgpu_uniras_query_block_ecc doesn't support being called during GPU reset=
.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 08c6e55a7927..7be33d5559ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
        if (!amdgpu_persistent_edc_harvesting_supported(adev))
                return 0;

+       if ((amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) &&
+            amdgpu_uniras_enabled(adev))
+               return 0;
+
        if (amdgpu_ras_query_error_status(adev, &info) !=3D 0)
                drm_warn(adev_to_drm(adev), "RAS init query failure");

--
2.34.1


--_000_DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2DS5PPFFF21E27DC_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">AMD=
 General<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hi <=
a href=3D"mailto:Ce.Sun@amd.com"><font color=3D"#2B579A"><span style=3D"bac=
kground-color:#E1DFDD;">@Sun, Ce(Overlord)</span></font></a></span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I&#8=
217;m concerned about the current amdgpu_uniras_query_block_ecc implementat=
ion. RAS_CMD__GET_BLOCK_ECC_STATUS is an SR-IOV VF-specific RAS command and=
 should not be invoked in the current UniRAS
code path. Using it in a bare-metal environment would trigger an unsupporte=
d RAS command error and could cause GPU reset to fail.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Coul=
d we evaluate updating amdgpu_persistent_edc_harvesting_supported to preven=
t inappropriate calls to amdgpu_uniras_query_block_ecc? We should also cons=
ider adding an explicit check to ensure
that amdgpu_uniras_query_block_ecc is called only for SR-IOV VFs, or retiri=
ng the function if it is no longer needed.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ce=
 Sun<br>

Sent: Friday, November 13, 2026 11:28 AM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; Chai, Thomas &lt;YiP=
eng.Chai@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: skip uniras block ECC query in GPU reset path<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">amdg=
pu_uniras_query_block_ecc doesn't support being called during GPU reset.</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: YiPeng Chai &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Ch=
ai@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 4 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 08c6e55a7927..7be33d5559ab 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
3770,6 +3770,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgp=
u_device *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_persistent_edc_har=
vesting_supported(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((amdgpu_in_reset(adev) || amdgpu_ras_=
in_recovery(adev)) &amp;&amp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_unir=
as_enabled(adev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_query_error_sta=
tus(adev, &amp;info) !=3D 0)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; drm_warn(adev_to_drm(adev), &quot;RAS init query failure&=
quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-- <=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_DS5PPFFF21E27DCC7BEC4115A3B132AF3BCFC7F2DS5PPFFF21E27DC_--
