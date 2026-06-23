Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AECCD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 04:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862F610E92B;
	Tue, 23 Jun 2026 04:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mWsJrGW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D482A10E927
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 04:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L14i0ki3bijnb4PFyUoJ0Rr45myWyomcV8Lfk9sAIPo5Vjr3g4NfuXSjEtq0w6fubjdpeZYK/rvS1lmU1TqMTGRgb++ePxbL/UI0/4XM8itPgcNzaxotEETQBTXueehFrKffzHi9wRg5ZkJbhsIgrvi8m5ukPz/1+hbClv5HuZNL8nOIggBrdmC1G+FyVhhQrwOthxA6jkU9SC643rumwklgw2CLzIRqbhc48ruZvQTiI3Oze96u3obwKIx/8Zc5gnLPKFyu504txfVy/V6uYENq3NDiGgc7PBxjG3hdWwn7ippHMDfP/fPwRnEMETTJE8hv2TppyGHZwkC0mZdPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5NklH8upZIPRgR/CKDC3DdBYOAkyXfFUNfCrCGr8PM=;
 b=xCit2ujdX4O3pvbj1tEzOcvUPajN491jZILtoFaGk1BSQTLDDicMU1NBc7qOEzmcmuRv5Gg8le8YwVpgDKDT8MMY3IIizYzu6GIj0AGZre2gJ5R74/WLXSYKCXotT1Rqr2Rto6ONjDrCXseh5Zja0eo9JwnaMCDazTi9mvogu/BRJUiJYUzTkr/eYDJTW79LMRTa/juXCy3bb4AjAdlaywSZhO0OfnC+hRRIRH5JGtsLiCu2GMKMug7tkS/n6oorai/b3lL762a59lqQLWgEz1M4DH+9oszU/zQ2kt3xiDxdZP4j4Fqstw3uODFxkE4Bm2nCG+wmrtgtKTp5V4RZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5NklH8upZIPRgR/CKDC3DdBYOAkyXfFUNfCrCGr8PM=;
 b=5mWsJrGWWyIt+THN7XFVEgGKzss/2ZySn+gxL9hnFg+toehaCfk2ndL6ooBqit8QMh/p5Kv8MkMxS6qQRBk5QIay89M0x8Cnyr+lNmKAL/iu8nZWUJ5XKvVcUB/DkJyGhMW93rkPpRaA7qva64AhjgcrHTXvFhBloYJqbbpK0x0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 04:13:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 04:13:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: don't free standalone ip_discovery sysfs in
 sysfs_fini
Thread-Topic: [PATCH] drm/amdgpu: don't free standalone ip_discovery sysfs in
 sysfs_fini
Thread-Index: AQHdAmL7MKBZic0cbUKQmDdwtTmUBLZLiJLN
Date: Tue, 23 Jun 2026 04:13:56 +0000
Message-ID: <BL1PR12MB51446646E01EC863E1EA315EF7EE2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260622161914.1648195-1-mario.limonciello@amd.com>
In-Reply-To: <20260622161914.1648195-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-23T04:13:56.265Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4341:EE_
x-ms-office365-filtering-correlation-id: cc941939-f308-4a3f-eba4-08ded0ddd839
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|18002099003|22082099003|11063799006|56012099006|8096899003;
x-microsoft-antispam-message-info: hdXbPulbWTELAPzcgn9jN/74Ao2iXWNsbGUMpfVKS/3Svx3AIvnaNk/a6LzCSCz0IFogIabcYrWmlCQsszgZFma2T74HErfpOdkJIDtZUF6cHW9/q2OTfJQ7zTxZFnkeNxjSRP/oQVE3WWjE2YWlhw4xostTuj81vZILtQ3tpfu31rkzp+ZbOkwYI6yUV+IWOqZzT1V7jgpkqajz0HFWShtsrIXmib83ni6JVyVhJ+CvksdU2Yqx/24quMXFWR/6XtbkcC8+pVyoXrfA/8tmv0gVIURrFzmxA2Jrels9a2+dU15psf1B7zUJ18EjQf67yFeS79fCCN6H6LzPD6scvxO/tYEVb97sVtmSRFyedx3VJdb83FOjgeLPVPogo+triJbOUdsFC3QCbG9vW/sbDSlECeeDl9chT0Uehs4DQwwNInrxHhf6QxNuSbcoYO9MMl9XWSkRKYNHTPB/DUblj8LSTVZFpD0ixdgwIY3FngEXj+yKasKAvoFtvlPAYLVUwmiKEmeuwsIdTJABtUxg9Mv1CREv8d17bEmdNYSwIuuXQyKPSOFRnS9h7hKPxJPtC6hkBYQblPK0Hq1nr5R+frRlz15xg2t35yjHYeTiek+2aANJ92jY4noTk37Dm9MaIMGMRHapRpFDPMq+RysBufL4eIh1R2xfMWUmJ5yyzZFR8BmfFijWzJS64ntt5pkBb0auDx6V5cRSDvGo+RY5RPAlEGsg9/1K1FEc3dVYexw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JqCbgOZzub0jng0DK/oanjEZfFkJbnXIjSFTr8ZIEdF7T5rGHwmHxBhpt40D?=
 =?us-ascii?Q?iIDOSExzABMFeFbhaCCkbQoxfq2G+J+Bgil347BZ2+j2UHhLAiEnLha1xnWV?=
 =?us-ascii?Q?SsIzzdvRd4Ef6VTjxfLGHUlyi1JSRpYEXNeSQvnTZQCE4xdkyCjdvdkDBgxZ?=
 =?us-ascii?Q?9nWhRQvhrZ3RWqZWzexs0gXGARO3QVGRSDD3TCm7fxoPto6lm4OSECdyOtrb?=
 =?us-ascii?Q?Zc71CVuwTGO8RvQhSBdayBbuUqsKtUiQu7h9kh3FhvDaRLdZ6uPQXvDYhaNw?=
 =?us-ascii?Q?K6gbz5U2/sFMB/Mdvcg94niN6ozHXV0WHxsDyvx9QR4ycYgMdBr6fQZ8XTNt?=
 =?us-ascii?Q?GGyj2wRYOuu4LQjhcjjV/mpBKTuJWdXhek+kfWtgEN6eXbXQeqT/TWAYkHfi?=
 =?us-ascii?Q?bBhAfXKPyyyKUvMa90YJe80akbFH65dC+zH9XjQwRsVBV+cpeTW4CT/Zwhqz?=
 =?us-ascii?Q?QCAwn4FaNmcHqOXSFwXIPg/zaFLiYRAdsxIy0VuIB/NwCUq7IHLhDeDQSjKw?=
 =?us-ascii?Q?/HyXWJcpJUKKG89rg2dl+4A8VTuix7/jJklEtkaYCzOV+KN/RvLzr0/uZh97?=
 =?us-ascii?Q?Tu0nMi0gq217e5rRdmiStmn9e2FZezlTp+UxPgVDZRYSj1gbb+moSwnE/063?=
 =?us-ascii?Q?S9J1QFzYMDnfzOTdN6nRprRk5gQu3Q/9MhIHBmUBuoMey3GO+ZO3afxTT0w3?=
 =?us-ascii?Q?pfR5xiIBz3nCWmlLAlEhwc6EmFmGxwKXZnIImaGUqhJEjTtSWgkXxFW37lh5?=
 =?us-ascii?Q?lwk3kNzMkKeASdVQegTmqp4elfT1Z4cIMGq/YAszNxvYEde87zTZPtdfbuBi?=
 =?us-ascii?Q?W3sqpo/h4ndgAdyO2rFVQu/1JCbG7q3IQ5lMLC6MpkLlviCSUI9UVMF3TVH0?=
 =?us-ascii?Q?JsWK1jtlvYggQ3QlEUsovplTkts3ySSQwGjtW90R7fHwiVXWdcelQRGvCHqW?=
 =?us-ascii?Q?AeNU1PVNDJDz5f/LLs9zaogSqWe6HHjdqs2yo2H3sr+Vj41D+HyCJ2aYOtZ8?=
 =?us-ascii?Q?BG/FkaWSyA96nAEoVlMo363u641prG3QhKhR26sW8ZzU/S7hGkCiP76yzIXH?=
 =?us-ascii?Q?sPyyRT8nBEvXdsYMa/J9x90rFM1k4/vY2VfyFGm/OspxBOrH9Udezt9L8QFC?=
 =?us-ascii?Q?T9YkemvZ05QgcITgaGqXBOEbhBltbjGq+uF3NPtwH9shEzPsLlXT2X3i/NgG?=
 =?us-ascii?Q?Q8ag8ab/yVrVJOxW7PfBRUGlh/HZ9JruHhJXqMERs+oWqaJL1mnFt0HoEbrC?=
 =?us-ascii?Q?GsK1X8lCbgyvLtuAj62ZMjo63SYqGDt0woXi1LBTpyk6eCHsKJyhVDwFceQI?=
 =?us-ascii?Q?9J/ROt285EVE1z6b9UMjrpAX5a9LzgJ3C5ftPLCj79d24vxejoPdJwEbEhpe?=
 =?us-ascii?Q?dw30p94zn6F4vjvxqxYTxaHFpZwP4xMLU7Lnh7IH2TCIqLlNBT0K5AJSJwoy?=
 =?us-ascii?Q?4j8VLQ/PaiQ8yS5I55xKReoDnZ46GxNjBvL5XUA0572O7WmgqYhGJA3uECLa?=
 =?us-ascii?Q?F2zVG93xUghckaRC0aTGUjtVzSIzINfcZOOmdSPN0uFXkSqV5gVHLPwSNtkG?=
 =?us-ascii?Q?kNg16+moSJACfkGkLKlWdc8X0TBBCZwS0+X5SEp9mmt+ijbESTv6/8OuUcEP?=
 =?us-ascii?Q?G1I2rBnFVkNcPSxxBy8wXPkzrngLnllhT4E90Qz0ckB+mpdO4r7WZjguh1S8?=
 =?us-ascii?Q?Y8kQa01/qM8u0P9MzvIwP6OlWlReg29EeK+sKz39l6Sw4cFf?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51446646E01EC863E1EA315EF7EE2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc941939-f308-4a3f-eba4-08ded0ddd839
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 04:13:56.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HusRWVzUzSJo1vrCoyjNPt5HINvD9oOGt3+QyUBqrfbMrDRURLZjDXgJdJg0eOHOUmjfsHEqR7nxosYwFXuupA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

--_000_BL1PR12MB51446646E01EC863E1EA315EF7EE2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Monday, June 22, 2026 12:19 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: don't free standalone ip_discovery sysfs in sy=
sfs_fini

The standalone_mode ip_discovery sysfs hierarchy is tied to the PCI
device lifetime and tracked in early_ip_discovery_list. It is torn down
only by amdgpu_discovery_sysfs_early_fini() on driver unbind, which is
why amdgpu_discovery_fini() already guards its teardown with
!standalone_mode.

Commit 7779863780dc ("drm/amdgpu: clean up discovery and preempt sysfs
entries on shutdown") added an unconditional amdgpu_discovery_sysfs_fini()
call in amdgpu_device_sys_interface_fini(), which runs during
amdgpu_device_fini_hw() on every unbind/reload. On reload this freed the
PCI-device-owned ip_top via kobject_put()->ip_disc_release()->kfree(),
leaving a dangling pointer in early_ip_discovery_list. The subsequent
amdgpu_discovery_sysfs_early_fini() then dereferenced and put the freed
object, causing a use-after-free and double-free, and prematurely
destroyed the sysfs that was meant to persist across reloads.

Make amdgpu_discovery_sysfs_fini() skip standalone_mode objects so the
invariant is centralized at the teardown site and the new call site
cannot free the PCI-device-owned ip_top. Teardown of standalone sysfs
remains the sole responsibility of amdgpu_discovery_sysfs_early_fini().

Fixes: 7779863780dc ("drm/amdgpu: clean up discovery and preempt sysfs entr=
ies on shutdown")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index a229fe9d043bc..029931f4e6ed1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1490,6 +1490,15 @@ void amdgpu_discovery_sysfs_fini(struct amdgpu_devic=
e *adev)
         if (!ip_top)
                 return;

+       /*
+        * In standalone mode the sysfs hierarchy is tied to the PCI device
+        * lifetime and is torn down by amdgpu_discovery_sysfs_early_fini()=
.
+        * Freeing it here would leave a dangling pointer in the early
+        * discovery list, causing a use-after-free on driver unbind.
+        */
+       if (ip_top->standalone_mode)
+               return;
+
         adev->discovery.ip_top =3D NULL;
         die_kset =3D &ip_top->die_kset;
         spin_lock(&die_kset->list_lock);
--
2.43.0


--_000_BL1PR12MB51446646E01EC863E1EA315EF7EE2BL1PR12MB5144namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Monday, June 22, 2026 12:19 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: don't free standalone ip_discovery sysf=
s in sysfs_fini</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The standalone_mode ip_discovery sysfs hierarchy i=
s tied to the PCI<br>
device lifetime and tracked in early_ip_discovery_list. It is torn down<br>
only by amdgpu_discovery_sysfs_early_fini() on driver unbind, which is<br>
why amdgpu_discovery_fini() already guards its teardown with<br>
!standalone_mode.<br>
<br>
Commit 7779863780dc (&quot;drm/amdgpu: clean up discovery and preempt sysfs=
<br>
entries on shutdown&quot;) added an unconditional amdgpu_discovery_sysfs_fi=
ni()<br>
call in amdgpu_device_sys_interface_fini(), which runs during<br>
amdgpu_device_fini_hw() on every unbind/reload. On reload this freed the<br=
>
PCI-device-owned ip_top via kobject_put()-&gt;ip_disc_release()-&gt;kfree()=
,<br>
leaving a dangling pointer in early_ip_discovery_list. The subsequent<br>
amdgpu_discovery_sysfs_early_fini() then dereferenced and put the freed<br>
object, causing a use-after-free and double-free, and prematurely<br>
destroyed the sysfs that was meant to persist across reloads.<br>
<br>
Make amdgpu_discovery_sysfs_fini() skip standalone_mode objects so the<br>
invariant is centralized at the teardown site and the new call site<br>
cannot free the PCI-device-owned ip_top. Teardown of standalone sysfs<br>
remains the sole responsibility of amdgpu_discovery_sysfs_early_fini().<br>
<br>
Fixes: 7779863780dc (&quot;drm/amdgpu: clean up discovery and preempt sysfs=
 entries on shutdown&quot;)<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 9 +++++++++<br>
&nbsp;1 file changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index a229fe9d043bc..029931f4e6ed1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1490,6 +1490,15 @@ void amdgpu_discovery_sysfs_fini(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_top)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * In standalone mode the sysfs =
hierarchy is tied to the PCI device<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lifetime and is torn down by =
amdgpu_discovery_sysfs_early_fini().<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Freeing it here would leave a=
 dangling pointer in the early<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * discovery list, causing a use=
-after-free on driver unbind.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_top-&gt;standalone_mode)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;discovery.ip_top =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; die_kset =3D &amp;ip_top-&=
gt;die_kset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;die_kset-&g=
t;list_lock);<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB51446646E01EC863E1EA315EF7EE2BL1PR12MB5144namp_--
