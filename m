Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037CCD111AD
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 05:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B1D210E375;
	Mon,  4 Nov 2024 05:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/mhfy5c";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A8A10E375
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 05:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKgwL5DikR0JsHDWe2oaXAerQ7Z8lF8ZEi7DeFaHya6cSyMbwjM2wL1BZjPtQCK6MHxp7WOkDZaMm2u1MoPBUL7BgB1Qn2h+85UUXAobHfjddDVXVZPau9/QgFeEugGbCMBa4nueb/XGiN7lFYEFfimoDPPxUTltPVfG3dyHbYa8eMOM188yZoVMMHaEDZiO/Hs1kxpZcPeI+7xsQ0rIJWMEXbXR008uZv1S0W2UYXMD8AF/WEJ32hnx7Y3kfOF6Tkk1W2KGjq0QwyirBms+rhOY/9iBeM6Ib3qQVpJoi4XITQDVpEBwnyrTiXc52LXCCZUk6aaOn4VHJYyM1kLD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IDV6q3t8Uzg+kIy2sP4C1vVxe0AvbobIuYm2xVL1BI=;
 b=wPp2JE1IQMQADqo8dZhST/wZ+AdZL0YM7q90U7JH91hVjTekhHkfiTaTlVQYPp0twir0yNGsKvsRkM7OYd4Q2bJbsUSANCGbGxCw1eKqwP1naqMM9EoUQx2dWYIEkjoTNcDZCTFJsT4PLkihcXa5I3eD/SIsbaYYQLn8Tdmoc4oBPkOQetn0Nw/QAU0rWOxCm6GLsHadw/uc7rtinxLHkLQSDkmEXlSi4c42CMG51YsLrqiaRSz8tAgjMwSaPVhQwabdqofVUFGfLh32WrUNgHnxSJu/E2zEm0U6iso8RI0II+0isvvymS2pq1mnhXxi9iJblPk7i0xuDIn4yIfbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IDV6q3t8Uzg+kIy2sP4C1vVxe0AvbobIuYm2xVL1BI=;
 b=n/mhfy5cL8fyL1G+QqKnNVF3yTelZk6SlxZLk47KqzsD8kIy6c34LByUiQJrH78spudUroVS8+fL8jNrF4B48EX6a47PvRaKXLJWdr7RRe+dwXqElXAgXjUgJYvozNJOEv5038cozp5968wCj4Q7LKycuas1eALl8++2eR2XTdA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 05:57:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:57:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip IP coredump for RAS errors
Thread-Topic: [PATCH] drm/amdgpu: Skip IP coredump for RAS errors
Thread-Index: AQHbLnROhBXa5mu6Q02LdWQQ6QjXD7Kmn8RQ
Date: Mon, 4 Nov 2024 05:57:23 +0000
Message-ID: <BN9PR12MB5257139A495A05B2EFA7D3A6FC512@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241104044414.3204284-1-lijo.lazar@amd.com>
In-Reply-To: <20241104044414.3204284-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=079f4f03-96b9-4772-a523-0ab1f6e16936;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-04T05:56:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: cc07f62a-fe07-423a-09f3-08dcfc958d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QQHu9jKIjHwgqdDCaR/Ehi1/Rar2f65Fxl8dkl5kakBHQrN9cAR0lkziimIq?=
 =?us-ascii?Q?V32mnWTpE7jaYV+FMwCKGfGs3fcNSShPAr8Qyh8BAl2d/FjDsJ3Jv/L3M4yR?=
 =?us-ascii?Q?wl3/JEYR9vwl1T9rclpNSw9W384H55frODsHpKPDBfoRk+meQPcJ1RXj3sJN?=
 =?us-ascii?Q?3vKe9lFyXxpRkNM7SpBhDIEnFeWn04swdlaFrSBtQ+KefHFQKdisgDjMobdZ?=
 =?us-ascii?Q?8oL6k3TP8FPQCCxPkXMRebEXz3gtH23nHKAy208qIN5a5shxiTXqExm9Lz0G?=
 =?us-ascii?Q?R9Jk2Fh4zBgD2qFrYkz6vS/Mh9aWc+BTqetFHR2dMLrSpgvl+ZARbHhig8ib?=
 =?us-ascii?Q?6KihWCy9IhDm9pDJwmO8m1lKTTpzJDpq/6u3o4aXRUd08TdpK/y3zX2HqrYu?=
 =?us-ascii?Q?oDUJdPX2bgW9indEVQvMGCREiMLk6OetKcXB13CA48oCVTcUe7iu1ey95/sJ?=
 =?us-ascii?Q?yIym/uLmCr+zMsGKTMGwl7AW6L+MgSP20N+vHy+YLLkJo2u66c2IVtiI9Ghk?=
 =?us-ascii?Q?+MGhC/Tkvc0n3ruWF2Jma/oF7BY+vJJSk4OTxj6DCHVHwcklnYZtVG2XCrHm?=
 =?us-ascii?Q?EyOwy6fT3TBZeu9qN8jKutsdbEAsLLWoz69gHGSjWlkoDEHwWzgAFKnpQpxO?=
 =?us-ascii?Q?PAb/Xe5KKbKePdrA5V52TH2id7FA1s+II9om0v8Y7sftxBqM5BI6YPdHVtyl?=
 =?us-ascii?Q?IrO08gg7aIYZ5sNTpYMWBjQ800WE/AeC9zcrkcKgI8az7OXF6O7YhLAQipEG?=
 =?us-ascii?Q?GrM5hdmG7yDIRL/u8ju7ut8QRwu0ZwQ7/4mG/BOB8RDKBOBlXE7vxBp0uU2i?=
 =?us-ascii?Q?cw1Pd3oFiO9e8FSwZNLoN3ATO45biEGCcU54+WjwYEsLsYCIcH6W2P9b25TN?=
 =?us-ascii?Q?+CcO0KmdXTqzDX7lsAQnXgydfv5J1XGaRRn1Ww9VSQtmyeTquyBuxrjRWDfI?=
 =?us-ascii?Q?7JUWVHEJrljra3TUInda8e4tMdZRAiJTcmuiK3f7kXaFStqQpwhr9Y+b9omW?=
 =?us-ascii?Q?0rNIwOtJa/EEIBQTmgPzzmUUkaFWPu1WzVg456ISpC/FlRVHSr4yHGq8vIgc?=
 =?us-ascii?Q?nJtVES4klQReh0zCfWOT+VpCq2v/+Is+kBMT3YXaZzzE0xyosW7S1ChUYa8s?=
 =?us-ascii?Q?sTWI5Lyg9uyFlPcwc8opfHKnRV2z+XEtdYwbnMZBtpOl8WBqCxfAcrvfTZCl?=
 =?us-ascii?Q?WVOucmYsUq3a3llXPA3XE04QC1wZx9XbumQJwD+OAFazP50NFmxMZbxwc6SB?=
 =?us-ascii?Q?V/EVpRkbQyjRO9K17zJElwj9ScHjlY7nyzrTeT6+MNB4Iga+3fn7edRdQwMK?=
 =?us-ascii?Q?RK9aeKb0i8NvWTeWWkU6nS5ogedo3XNiFRAvCg1iQnSH9RUY/4fao9SASBip?=
 =?us-ascii?Q?L2rmN2s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gb9AVqGzT5du/16qaoUYmEzR0POhtcX7gdvIcsJlTp6tPrit9hTapzpEMZY4?=
 =?us-ascii?Q?unfoVsXkeHMbB5sGXiePfAzqhC9krVefnzwFvciQ4Pw/8Ujn+FWuzL06wEUX?=
 =?us-ascii?Q?fn9YpLxAthlHD8yMi2SHLHnSHdBY2SNZGx9wjz/X4OkNScyaWhNfEwK+luyW?=
 =?us-ascii?Q?Aq3UeoHA93CwuQWAA+qE39Tune89i936JPKEUdDcSRyIJViUkLAGF49ssvHn?=
 =?us-ascii?Q?enMcxuw2sqbGwlNCzrHrqSOOy4lC4ZzlOdWAJKZ/Y4hRQ10OsCIiCJ35UOCY?=
 =?us-ascii?Q?LkL0ZRMNtv8/JSHI0K6iwtTIFMb/1vM506YdfO0Wl4G5/0BFrsVay545PN5e?=
 =?us-ascii?Q?oZfy6DFV71oK2fK3N3PjwE7Q34Paigudrn5XrXu6cAnsIKBl0wT92BsgDP08?=
 =?us-ascii?Q?AtT+FhPBqqvUwWkHCAmI7t8Rw4Bftf9ibhXQncrScr2d1LnkshYjGCRd6HQP?=
 =?us-ascii?Q?AGw9WnN/gI85bkbrUFK9wygbo5NDWB1jBnAzzuOYbCetw6M6ziTHGO0/Xnyl?=
 =?us-ascii?Q?rCmn4SmvmEZybLjucU0U9cRPwPv4XsqOIW2PQREGTw34tvwy5bPUQJqQmQMf?=
 =?us-ascii?Q?GEsksYNGG/y9XtKBwhDtEATW8KiV/aE5kR4N2mLoK9q0EXRvjMkgOVbkAAt5?=
 =?us-ascii?Q?usYN5GVOekImp9K7/NEjGkrfqaHqQCazhJqvpf1xMZLqSGMVVDWVZCfuPZF/?=
 =?us-ascii?Q?eNUNL1Eg96HJZf1Q5/3Ql98ALp1zICbrgD2l6j+WY5lIfTHOSZ2W8aQ7VTyA?=
 =?us-ascii?Q?uUeOfA2bplOuzRhn2b3Pz2Ot15To5AMI7o4SEFRPzcAQjAExWHpqrIoecykW?=
 =?us-ascii?Q?Z2lQB1xa+Dk8KLdxRuySgnikaS+SgM4hYVfZdbqLO2/bo6TrY1v3nuRloche?=
 =?us-ascii?Q?l1wb9G3Ia/sC+ccPMf2McAOnHDZbeSMgQKZpng6Jw0E3Mevy2fwfDZf6J43f?=
 =?us-ascii?Q?eygUYGCQCKUiB6vCu4ea3pihd0NjyIQuf5PrqSTJLZUnKW0fhIfXMp4NvwJq?=
 =?us-ascii?Q?LSESHsPoeGsbgY2li1pdu3jFxp5BSMDLef4P0kHih99k2pa9f3tIfumJAfFH?=
 =?us-ascii?Q?GwqPxDaKEvRBugI9x4h7K0wV2I+yRkj0WTphp0w6dYllg+IshJJin5VpQQtj?=
 =?us-ascii?Q?0Jlz0QZjdN8ZHGJa0wa+LENJby04lJFWEB6absrP00pmPoeXpd1XcffHUHWu?=
 =?us-ascii?Q?au739RnzH0Pe2YIc2uzCqtMAudbSHo7mxWuBuCYgv4aP9yrEvdjbJPugfdR/?=
 =?us-ascii?Q?qkLHx+OoMHKZ8ACh55FVvEG7Z689CZFXquYRYJTVDCgsvf48uQNGsSToZ+Av?=
 =?us-ascii?Q?I4MNC+T4QXWcy1t85FAQ5djWUABtdCPd+dDGY4XfDefv+3Ff7UKa6Trh2dcs?=
 =?us-ascii?Q?GeaD2n3dlXVoRY/m2GuoYBF9qzZjIRUaVWw9VTefmJuAy0vbMcTPcaQBD8mE?=
 =?us-ascii?Q?Is6HEHyi/JFtjdS/o/NRe99FdYYxDg6L1NvC7EZPsM/oGVl/1ebd/jZK98IZ?=
 =?us-ascii?Q?YKEATUSQrCXPl8WETXx01SVpqfYg3bf2ASXqxwFkJvpVDUul3s28jgJqbBLF?=
 =?us-ascii?Q?KuJOcYKx1Wcans4AcSs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257139A495A05B2EFA7D3A6FC512BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc07f62a-fe07-423a-09f3-08dcfc958d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:57:23.0332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wKLsc4XexW4VTTsnzR9oYabYQSaTjgXXX9TPjasqwtltqau6LW/1+2ovnqKmHVpUfs+39k5KwqdlUrKqRpXGnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

--_000_BN9PR12MB5257139A495A05B2EFA7D3A6FC512BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]


Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, November 4, 2024 12:44
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Khatri, Sunil <Sunil.Khatr=
i@amd.com>
Subject: [PATCH] drm/amdgpu: Skip IP coredump for RAS errors

For RAS errors, source of error is known. Skip the core dump of IP states.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 17af8c58e676..bcfda997bfe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2606,6 +2606,7 @@ static void amdgpu_ras_do_recovery(struct work_struct=
 *work)
                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
                reset_context.src =3D AMDGPU_RESET_SRC_RAS;
+               set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);

                /* Perform full reset in fatal error mode */
                if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
--
2.25.1


--_000_BN9PR12MB5257139A495A05B2EFA7D3A6FC512BN9PR12MB5257namp_
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
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Hawk=
ing</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">-----O=
riginal Message-----<br>

From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; <br>

Sent: Monday, November 4, 2024 12:44<br>

To: amd-gfx@lists.freedesktop.org<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander &lt;Al=
exander.Deucher@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Khatri, =
Sunil &lt;Sunil.Khatri@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Skip IP coredump for RAS errors</span></font><=
/div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">For RA=
S errors, source of error is known. Skip the core dump of IP states.</span>=
</font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">Signed=
-off-by: Lijo Lazar &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@am=
d.com</a>&gt;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">---</s=
pan></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> drive=
rs/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;"> 1 fil=
e changed, 1 insertion(+)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">diff -=
-git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">index =
17af8c58e676..bcfda997bfe8 100644</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--- a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+++ b/=
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">@@ -26=
06,6 +2606,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work=
)</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; reset_context.method =3D AMD_RESET_METHOD_NONE;</span></fon=
t></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; reset_context.reset_req_dev =3D adev;</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; reset_context.src =3D AMDGPU_RESET_SRC_RAS;</span></font></=
div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">+&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; set_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context.flags);</span></font>=
</div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Perform full reset in fatal error mode */</span></font><=
/div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_ras_is_poison_mode_supported(ras-&gt;adev))</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">--</sp=
an></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">2.25.1=
</span></font></div>
<div><font face=3D"Arial" size=3D"2"><span style=3D"font-size:11pt;">&nbsp;=
</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257139A495A05B2EFA7D3A6FC512BN9PR12MB5257namp_--
