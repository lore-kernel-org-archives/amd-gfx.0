Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A48FF34C49
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 13:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF6E10E439;
	Mon, 13 Apr 2026 13:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oFV2xaWu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFDF10E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 13:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7aTEUAdosBB/T4SHAihcwi2g6WVWPYkEqniLwXNJJqWL3dl87FFrcrLz0JrajiMRQz3KAXtet5BeLGST3f5zMhGAl7BrOHFiRfbLVDs6c40LKfB58zfvIljgj3WheXJ8Jy1znNu6eIDLu6d39/3KbQm55TurJ/QKmDBAHJr5RBuxXE4TVwWtSJE8RzL6paUhJq+t5VyItUQAvWQN0N0pRk4gUOAFm6+CZZ+ujiX7atn1jnU/RjhcYAnBUJuiHBDxKCobxV1+CPxIBkco16dH4IQtpvCg/aI4JLgMTrntnbX7tSYHWoMZ3FHJvo/Bztm8VwTJvanQfeSajFmA6bzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lygyk1OmurrmbozOEOZ7CWENYtWERk2arzhmATFKy54=;
 b=UFHw6xaDWE//f4hEK3c/llGIhUnmQFjeU+UhspjoLFsf97f40650A3y5ck58HkzXY0odC2cDswEo8wyZCA7TbTC60xHaVp/63i+R3/5UuoG3jnskIeEYwf8KC5QcbeSFC9DOqoe+kBW3IUJSc9p8PnS6FOvUAlGctPTwwclPiB4yRk3ALUyHzIWLnMtF3rMBiq5d8Ooxv3Q+x9sYUp9b2aUNvC0jwvIX9Ty0OjktQvGsDVlTD9WQ2d31dE2xeJsEI5vNUujkvHhbbF+UYmszJZQxm1nMh1G8pfce1Gr4gxzD0KBtPsbaJ6UqazOi/obMtaFly6kwl9fscre0iUFJJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lygyk1OmurrmbozOEOZ7CWENYtWERk2arzhmATFKy54=;
 b=oFV2xaWuyAzGRI1ntICe2zrbvMo/MO6qrj1O1MfxSVXnFbRXXi3DshT2zJcRGGuNSvm7eYSo7R5ZQrIiWJOd5mUNqRIbXYUa3aoMFOdbUKrAnHNRFshKE89EfidTdX7FxpiqF9Vr07wHTLlyC9p2sgu82w5sqgireR+Ec4rbjFQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 13:07:02 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9818.014; Mon, 13 Apr 2026
 13:07:02 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Avoid ECC status update in hw_fini for VF
 unload
Thread-Topic: [PATCH] drm/amd/ras: Avoid ECC status update in hw_fini for VF
 unload
Thread-Index: AQHcyz61qoHvCkIIs0qBM0GIUF8kirXc9aWw
Date: Mon, 13 Apr 2026 13:07:01 +0000
Message-ID: <BN9PR12MB525761903A8B6417C23AE559FC242@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260413121134.2233632-1-cesun102@amd.com>
In-Reply-To: <20260413121134.2233632-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-13T13:04:31.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB7160:EE_
x-ms-office365-filtering-correlation-id: 39952c6b-911a-480f-92fb-08de995d8d9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: FBzqWODc116LnZkFycnwVKmnV2aJH/dYpuVFIRAi+4OKaE3rUxceyKHV/6kONH3bOTKaPW5BQsNmmOc6lAmnlo1GCZ6o026bSdCm8GjwVQ+AuDRQd/cRRpQwxRIRGgmD0Tq2uMsIi9VPik9RN2phyoD8dp9PLnSrExcVv7tU0dFr1Auj6fAP0p9BaFxVBNp7eNRNunJdVkYItgkOBFB1w93teRTBF6vLZ5afmihpzTsSp73UbfKRdQZODO6F+Z3C+O+mvvjIjqVFSxmAxiRiSCtw7iFwT3pG0vJHJevQ7QmvzQvTDcKX5TqOXU5zwtclz5rSRWdV1M3RsNM9IWgA2TmrHkjoW8odfpo26vjAneuNRjef+SYYC56/A03J3kaJ8ClPZcl3ltqqOVcbX08on7K57aK/18UR1cGfwF4T2JA5wuKymbjwc7clc9hX+8hpPAbxR2S7TlW8i/ux7aJSobPoXIKcvJhQYRoCVnv3t+02T6TEMitughjGnXTg+DRFwuQoaNCbuwCURkD3//mTxp5UJensrIZQr9Uoaosrhw7TSEnBHNX5OA1SJ2jOKp9S5RsMKqa45ZIMO3oNZuPe2GWMPEmUbxyDZpDUMgwKxUlIAtRDuGDjhe6BfpWq2Z37yvXAxen/q0KG/BAbwpMyAOTnGd0OTul0RzmdLBqg9Hi3ahnfM1puIGgaIg9N34FR/1gU/jdbcdr0d4CLeKa9X4zgtRXYJ/2M5k1o/GDUptwbU5CqK1ZxmuKyFl9w24p6o5m8aGpC1cFeNjkKBCq6kGei7xpqUP1BPqUTDhnz62Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oZuFxyRaFR/elOxG5Yo/SAxl9+KEnM8KKkyNU+jmJi1kGIt5tLXrBuru8amR?=
 =?us-ascii?Q?JAmGy6jtPnMU36QNASEgEwrx3lgwrOQ3wLc+reym5uayNXg4xPLOt4vsrbEP?=
 =?us-ascii?Q?i/CLpwCOG1AHRjESal1tDSiam+xHra+Em5ypW097hqoKaqn1Apja6Ng1cBqi?=
 =?us-ascii?Q?2oEkZeZiholWq4yLTiabjXEY/sDhxlHNNMK2up7PhKxg0sO49KPy72cgKTCE?=
 =?us-ascii?Q?ZRTb/yPpvR4Eq0R1V7uxvCiw8K8ZRPPEUrFAYnZtwqhTjwbYRh3n3EoGMBzL?=
 =?us-ascii?Q?Fshw1nNVEXyBRTMk4H2OSxteN/tY6DAyoMSfnR+p1L0ucQSL4zCocRxtHOMa?=
 =?us-ascii?Q?j3mYONqHXd9o5L+45yO1NbEznx3/ueeyXBCrfMNit8fISuHjcKH1bcrsmZTP?=
 =?us-ascii?Q?46M6ygsNd7onfHBi0r1Vwm/tOxByTykOrZ1vf62P4qUCzCWBQ3DbDM8xJcAn?=
 =?us-ascii?Q?Q3jZ2WbP45BZZU2FDJ6C49qlt8X7RibZSROOoZKPCMh+Aj+vhC0K0NQ010jr?=
 =?us-ascii?Q?TWP0N4ziKE1j66cyQGlAhwbHf85LxXdpX8GqmR46qYPKeiv7GEfSSz6zSxaa?=
 =?us-ascii?Q?uuPZMEkSUn724vNZ/dFpViP6Tfv3r40sVNP8IEcxNWyKfXNrWDlphqwAYZQl?=
 =?us-ascii?Q?WsIaMD4YPq4KeZqbmSkV7gZ9/xMcpKcebFJg6TEG74g5kqnbBTmrI+OS9O0T?=
 =?us-ascii?Q?v7pOp8mdEAicRM73E9nOGrMqTRjhuWAONcZz+f/0qi1p+pygYwlQoXmPjZ2B?=
 =?us-ascii?Q?ETqPHIS77ZhkHzYSjr9zD9HE7ZwqTcbweSXILpxwuqldtySJl4R6YgjN7WUF?=
 =?us-ascii?Q?iDNdWOZS+ZC6vaayaIlg3PSDrGbKY87O+hNb5I2ohjjV/vEcatIFKz+GNGRf?=
 =?us-ascii?Q?yrbVN8ex99/BN8aYARZzyaSgEU5guCFuRNZVkPuuVO94ED0Bsp1Rkd97X+Iv?=
 =?us-ascii?Q?Gv46oftWedGmy8klRXt3Uu2/XCW+ElHlKuZjoehFYaZPfoqOOOkgV8WC25yM?=
 =?us-ascii?Q?jnsMaxsDEFEBiIBZOZ4ylTT0Z2TzRy7QvgWAc0GRJycnaYsD+elozBfgYfmm?=
 =?us-ascii?Q?H2qDtcOu6jESqDlYWp1bJ15TXE8jW5K4fZsVoQOO5jnbwc7faHZBee2DNRX0?=
 =?us-ascii?Q?2v8iVRC5v1Yk8s8JAfJKTaWcYo6EBNOLiW4c0t5egOt68v/DnYv/K3gi4Gas?=
 =?us-ascii?Q?CQedkieVny2UGHOtrB0qNw2UB7ymjjNEom3c/tj1xL5/oPwhM+0tazvm5H+e?=
 =?us-ascii?Q?dXma9nBd/2Ps4a7g07Z5gfbTQZnU5g90FUS5UTG+5PS/Me/eBNhuiu2gUlcN?=
 =?us-ascii?Q?+BqJecvv6ke+IVIHdcNDSsFIuat2JNosm3fTcDUVxYRzxhsKumgladNW0Iz8?=
 =?us-ascii?Q?FDfk5pCXVeOBYQnwydIVdGaqMV8cFtjc6S5RdUA99bFx1s7R1cdrfCsrQw/W?=
 =?us-ascii?Q?CK9a+Qj/Hf8nfB0GvXtm3TFCwM67ify/Q7QL/ZhOxY5qgUSLjcu88x13M1NU?=
 =?us-ascii?Q?6HRIWnXzsnQsIxGZn4jP0SMn/ydrT13gC63WQkWAw9Dl4zoWVSxdco0iEiBT?=
 =?us-ascii?Q?H4xxWvrewGJf7pEzIgU0VPTy8bXJ+BJowHpRymCv4QfB3bC0wgzltlzERjbt?=
 =?us-ascii?Q?0qYeei3gFzP4XmJLj/kZSsMaGBsJeOL/dAQ2Ifj9YyPF2bqv0Bq0MxPoMlLB?=
 =?us-ascii?Q?L7XbjEno5coqUhO8twi3wNAItooSJ4Fw/Yi/sAO9JGp0s5Iq?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525761903A8B6417C23AE559FC242BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39952c6b-911a-480f-92fb-08de995d8d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 13:07:01.9640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vaElXpSRX/cfgXywC2PJHDGXqmL40555coGYuSzj2SSxjghp9I4f6ZXbWUiZjzMJkcY/qX9GxaMMG4PXffR1yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
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

--_000_BN9PR12MB525761903A8B6417C23AE559FC242BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Fine to merge this as an initial step toward parity with the legacy impleme=
ntation. Let's follow up on the design: we may be able to fix this by adjus=
ting the current sequence rather than relying on this approach long term.

The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, April 13, 2026 8:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amd/ras: Avoid ECC status update in hw_fini for VF unl=
oad

VF sends IDH_REQ_GPU_FINI_ACCESS before hw_fini during unload.
PF no longer accepts requests, so skip ECC status update to prevent mailbox=
 timeout.

Signed-off-by: Ce Sun <cesun102@amd.com<mailto:cesun102@amd.com>>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driver=
s/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 28f94b92716a..838eb91aef39 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -517,14 +517,9 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev=
)
                        (struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd=
;
        struct vram_blocks_ecc *blks_ecc =3D &virt_ras->blocks_ecc;

-       if (blks_ecc->shared_mem.cpu_addr) {
-               __set_cmd_auto_update(adev,
-                       RAS_CMD__GET_ALL_BLOCK_ECC_STATUS,
-                       blks_ecc->shared_mem.gpa,
-                       blks_ecc->shared_mem.size, false);
-
+       if (blks_ecc->shared_mem.cpu_addr)
                memset(blks_ecc->shared_mem.cpu_addr, 0, blks_ecc->shared_m=
em.size);
-       }
+
        memset(blks_ecc, 0, sizeof(*blks_ecc));

        return 0;
--
2.34.1


--_000_BN9PR12MB525761903A8B6417C23AE559FC242BN9PR12MB5257namp_
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
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - AMD Internal Distribution Only]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Fine=
 to merge this as an initial step toward parity with the legacy implementat=
ion. Let&#8217;s follow up on the design: we may be able to fix this by adj=
usting the current sequence rather than relying
on this approach long term.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">The =
patch is</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
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

From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt; <br>

Sent: Monday, April 13, 2026 8:12 PM<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;YiPeng.C=
hai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Sun, Ce(Overlord) &l=
t;Ce.Sun@amd.com&gt;<br>

Subject: [PATCH] drm/amd/ras: Avoid ECC status update in hw_fini for VF unl=
oad</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">VF s=
ends IDH_REQ_GPU_FINI_ACCESS before hw_fini during unload.</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">PF n=
o longer accepts requests, so skip ECC status update to prevent mailbox tim=
eout.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Ce Sun &lt;<a href=3D"mailto:cesun102@amd.com">cesun102@amd.com<=
/a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 9 ++-------</span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 2 insertions(+), 7 deletions(-)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gp=
u/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 28f94b92716a..838eb91aef39 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
517,14 +517,9 @@ int amdgpu_virt_ras_hw_fini(struct amdgpu_device *adev)</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct a=
mdgpu_virt_ras_cmd *)ras_mgr-&gt;virt_ras_cmd;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vram_blocks_ecc *blks_e=
cc =3D &amp;virt_ras-&gt;blocks_ecc;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (blks_ecc-&gt;shared_mem.cpu_addr) {</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; __set_cmd_auto_update(adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RAS_CMD__GET_ALL_BLO=
CK_ECC_STATUS,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blks_ecc-&gt;shared_=
mem.gpa,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; blks_ecc-&gt;shared_=
mem.size, false);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (blks_ecc-&gt;shared_mem.cpu_addr)</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; memset(blks_ecc-&gt;shared_mem.cpu_addr, 0, blks_ecc-&gt;=
shared_mem.size);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">-&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(blks_ecc, 0, sizeof(*bl=
ks_ecc));</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.34=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB525761903A8B6417C23AE559FC242BN9PR12MB5257namp_--
