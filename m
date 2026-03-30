Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6471061B12
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 16:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA1610E1F0;
	Mon, 30 Mar 2026 16:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aNd+WQbf";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996C610E033
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 16:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZJu7C/yDIoA6zLzPTI1zvq5FTKwHWRQBiCwMYLxJ1UIElX8gGfa6aRF8Z2eAVSKuJQ2J7qWXXgdc9nDsV4LVM9xL6T2/BLpbx3y7aDMPr6dVGGZeG6otvhtUpCpRvCxSsc4AwrIEBkpC8H7+nF+7pdVyCJqR60icugMyTF8lsg5q7TkxaD+m76vk/i1RkHE4cWmQ6UbqOIviypRolDGzRLbCNjSO5VswxawaBdPEZ8/mz2x0pNuAbNs9sOOsoDgOBvHwH1/46qcQkblKccgcONwuPNedA8lNWidFFhuqLkxC/0Lw1ZIKRuT/YXvHxhv2G5wLB5oNJAIinSn3ymqkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x/ZI3MBgK5PJS2gkjiYB1OBT8Po8nAen1d7OjEsAEk=;
 b=tgrwT0GxE/951OqRuFfFpSZGkyJQofJB2oQ3rGnPl3GcZO7nefSCcPGGOtDsGF9c76Hp1gB4ORVi02W3kHEMf0OeJE1EXm5Zy4LcUu2G6SjG3BTNXZrQHt3YEYN8JpEbGy157Pl4G/AFyJyxfOEOhY/UJv0lxYV5d48xYDiX+t846+B//0Du3p9RI8csGlWK9Tlax6ACIRGapd6jAik6gFSoOclAGrb0rlt7FD2TkIG0pRfoneh+46S5S42YStYpPjmAH94QNDgWlcMQrCoveo3iKld44gAhomfTXn2DgHofFncqdEkp2x6y5nSIlnFZQRUgjUd9Mjjf3G4GBvQdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x/ZI3MBgK5PJS2gkjiYB1OBT8Po8nAen1d7OjEsAEk=;
 b=aNd+WQbfwnoR66lgze8zCBsAVGaN/WCxR39MvJ1hZuFbuQo52p5R7S1bkg+IzcaRPOGaFLHn+wHhOvf4dD3d0PFzztTl5bd6BLDlT9X+ysryIJOPjpZgqJCYtEdDixKsGF5G4gk+IYul/BXWoAtzYoeo8tIu7wNJ0wV2fKpozMU=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:14:50 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9723.018; Mon, 30 Mar 2026
 16:14:50 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Topic: [PATCH] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Index: AQHcwFWOn1wTtKapi0W1ZZIRkVpi27XHP1WG
Date: Mon, 30 Mar 2026 16:14:50 +0000
Message-ID: <SJ2PR12MB8650A5E01217D0ED84101EF88C52A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260330145717.63832-1-Alysa.Liu@amd.com>
In-Reply-To: <20260330145717.63832-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-30T16:14:49.890Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|CH3PR12MB8074:EE_
x-ms-office365-filtering-correlation-id: dd92c533-5e40-43bd-00e3-08de8e777832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003|8096899003;
x-microsoft-antispam-message-info: eYABY/H/IjS2v4DkGra52TprvACN6yvKJgSXErtRQFosZ3lRYaX0CMIgHZAVv8B/WTFA5doLafS1Ol41Ezv10PhXH3Lmiu5RxOQ4qm+rUXTewtpJ1g7EimePUWHOESp2GhF8u8Ed88C1Pdvz+Eq3sejHI6QQ/j566TKntWP8OA1ezVS4ymVb2rO+vE3NYZ47YC28NYwxV6yUn3cNhTrX1+BvoP2KXYGD0DfoGeYYaaqq+sXe9K513ZdpmLwzXmUZfQYTHoWuikFbnxBeyOjRzQ71dcdRyaDECtKgBpn72GX3h5lNo8K9ReYlRzcd6qpXgaq5fCRmc6kwD3MzEGEBo+InTywlhZs/T8EiCVJ11uWon2nPoDsUxLvMLhahKPbMlVXVlI7rgnsIdw8SlOVNVoDDKPWVHJ0k5cWdq0L6KOMCmv1KmzaM2+Ru2+w3f1kxinNVl2Mdkw7NCkFGCsgiA0NE3vEsuzYlf22rlodWC5pDm/kg+4eZdCaWLqSNH4soS99eLqE8yGhkOAAtwPb0gsw6pLRaf0nMZnkObAiPYpgAC/cB1Jywr0gflWacvx/Zm8Ggz/1M7NePBECVr2U/ZW4R0PqUVbW1Xd9E/EtIAUqoX9FDxpP39gfwf1JLEORT4yGHmdUBHVVS8JK/c4asbmySxXcvwmlx+bYjwecYAogx964AzA9UnxAUgfRQBAOHRg2ImVsQd+YyJlrxkhtDvwwu3GgNh6zWoWXBCbeCp//BWLpQSKqJQTBU3HUkYGECzUcbUm4ewI0oS6hLe0+y+81E69LmFVbnZDMOsbPBrWo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O9SwnH53CLWahzNRltSzIOGZWb2LdTbP0AQHOSHp75ZPdoWzUQjzuVhcD3?=
 =?iso-8859-1?Q?hWEIMaoVNbPJ73l/00OOQWnlIVreVazGfnXWbem9XKlU42DkAdz9cVf1zc?=
 =?iso-8859-1?Q?8x5Hmf0RO9As31NG5aN2kE6REXzCNJfCHuF3hnueE6cRg61y35wHQkycMK?=
 =?iso-8859-1?Q?02rZRPjnnm0AoCfZtNcfV/NsEDwe3NOp7IgB2AOXc+7zR29tWkJF7FuR2u?=
 =?iso-8859-1?Q?rrKUjR0k2s7P5hSGek+YacuAr13Fwz3QV0H/KzohcVWiV5HP2/XXSKKqvJ?=
 =?iso-8859-1?Q?t223Qyapw+lT5xZNCpXIx9H7v7Hv1sgwu2iU1fEK21d/RyKp6AqVFn7C7s?=
 =?iso-8859-1?Q?rShblvkHWAmLkLRJDRjcHv5XOgGFyhLJN+faq2B84QqHdAYTTijIt5fHvU?=
 =?iso-8859-1?Q?uNcpRfZQ1DLvaaMUvuG5Q6NTK9armp8vcWq7o/RNk0EXShx8E5JFcE9atg?=
 =?iso-8859-1?Q?9rWaz6JUjmy+Uj8yZFs4dQEvvXz9xA9qEixYgDf69UIDnP3YBO9BrD0esR?=
 =?iso-8859-1?Q?P4H1kabfV/DIfJeHPbX59lkwY7s2BHgfblbv2hv9RwNjleRBqWCXePT7UI?=
 =?iso-8859-1?Q?VgecQy+EiK2TUH9cjAy4P/nW/2nmm6g6f82IVZSZGZ17L+5r2ntZIzul+s?=
 =?iso-8859-1?Q?T4uwfMPk38e3ucQdklXp/wd/9DRiCCNTMo7H/Xil3hzTPWla6nmI+Q7gcH?=
 =?iso-8859-1?Q?ssYeQOUhILNpytGCj6HdKAmxGzgMNd0JewumKSoisRFJ18RqDOHJkRuKg0?=
 =?iso-8859-1?Q?E9s0MbbNmroNOJWcwWSBcUzwPc283TmOvIPsEJrznB+kx0lVY6hGLj7F3B?=
 =?iso-8859-1?Q?4Tt+SsRXFgzjirSMi1wzCBjKvnuJAgSaOViwHebfCUEEZNrVCft4OeF91M?=
 =?iso-8859-1?Q?xOOjM9idUOVuG+QDhVEAMZGLS9Q/gbH4uWfQhMmQX+LIyZdJJs5oTAFTN4?=
 =?iso-8859-1?Q?YLMWpyg9GjUeyp36kBKqt8R9e10ZEk+2+82Fm3cSwa+NMZX4xAqWvQb+zp?=
 =?iso-8859-1?Q?/On47djpShrIjYo7VfL9NuicpEbolOuFsCq6oTdWUmHHli5K4r5oZ8pmsm?=
 =?iso-8859-1?Q?ZatPW7tzRxnheDx5TICHV0V2dWQieC2woyqtND2gh28Jj1ZnR8TEy79Qn7?=
 =?iso-8859-1?Q?+Kemu7KZuEWvth2QJDtS8OsOs7VZVEj5WyOLFgWZOONxdMkJYsNaAOkhm5?=
 =?iso-8859-1?Q?oighrh6BJd+ljehq7Bo2A5dFCm552RdjcMK6+8Wfn89bs9hJ1wm2FKiWZD?=
 =?iso-8859-1?Q?0FWxhfECQDt8GyyPrPNi2AZSNXThHsq8i2sEEdxLu8bwHKhop7tJbIzKeB?=
 =?iso-8859-1?Q?bHVer6P7qsoaOyTx77+LYptaUi3HDcvrA+Wo5YyPO3hzlMOac23FsUu0Pb?=
 =?iso-8859-1?Q?sr6arxl6rrcAVJKoM/ETv4UwjeMrF0pGYgOvfLEFhv1tja9WoWCT7K8Fzf?=
 =?iso-8859-1?Q?Ec1PlCjqRYTi9fMbva4K/UDNiMaQ1Bhp7BiZogKhaoitftiTjYqiLga8J/?=
 =?iso-8859-1?Q?1T3pDCsOrW0dfrXqoVjiF3aFH/zTVmX4X0iMRP1Q4FlKufyEL2iOrv6WHl?=
 =?iso-8859-1?Q?Gb3/R6iTyOpPFFQFp5K4aj1QNw0HiBVlbhA9dyI+CVnYPLbjxTJOuL8DrZ?=
 =?iso-8859-1?Q?Q2YY3qk2onWM3pQ3y9UTcnFsnjDW1Oh86Vgr7kjQbtfP5VjlJ7H+OY/+6Y?=
 =?iso-8859-1?Q?1qhWumR7cb3QM77qQyZOIb++4ISxaoktNCZVvCjyD7AzKcJPL+UHm+oOCD?=
 =?iso-8859-1?Q?d3uHb1QZJyqw53AGmPzKB2wqZkxo4vuQvm2K69J3Y7rYsw?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB8650A5E01217D0ED84101EF88C52ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd92c533-5e40-43bd-00e3-08de8e777832
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 16:14:50.1464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxZWrmxM+mUDIE3PCZekagpSCPp+o4qTwU9M0ZPoUAWMIFk46whSipgT0O9tak77GKGqBnBLM2qCnn3f5UCDgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074
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

--_000_SJ2PR12MB8650A5E01217D0ED84101EF88C52ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

One comment below.


________________________________
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Monday, March 30, 2026 10:57 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: Add upper bound check for num_of_nodes

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 1db565442c48..9e37c2709083 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,
                 goto out_unlock;
         }

+       if (args->num_of_nodes > NUM_OF_SUPPORTED_GPUS)
+               return -EINVAL;
+

You should use p->n_pdds instead of NUM_OF_SUPPORTED_GPUS. Thanks.


         /* Fill in process-aperture information for all available
          * nodes, but not more than args->num_of_nodes as that is
          * the amount of memory allocated by user
--
2.34.1


--_000_SJ2PR12MB8650A5E01217D0ED84101EF88C52ASJ2PR12MB8650namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
One comment below.</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, March 30, 2026 10:57 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdkfd: Add upper bound check for num_of_n=
odes </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">drm/amdkfd: Add upper bound check for num_o=
f_nodes<br>
in kfd_ioctl_get_process_apertures_new.<br>
<br>
Signed-off-by: Alysa Liu &lt;Alysa.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 1db565442c48..9e37c2709083 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;num_of_nodes &gt; NUM_OF=
_SUPPORTED_GPUS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
You should use p-&gt;n_pdds instead of NUM_OF_SUPPORTED_GPUS. Thanks.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-size: 11pt;"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in process-apertur=
e information for all available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * nodes, but not mor=
e than args-&gt;num_of_nodes as that is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the amount of memo=
ry allocated by user<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_SJ2PR12MB8650A5E01217D0ED84101EF88C52ASJ2PR12MB8650namp_--
