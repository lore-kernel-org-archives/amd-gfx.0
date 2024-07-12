Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C187CC2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 17:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59BF910ED8E;
	Fri, 12 Jul 2024 17:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0jLSLBm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D40C10ED88
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 17:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2yV5Ts0Ree7xMPJjPsqyMQSKv4PjO4HyFuTJGnIJo5g0pqt1FuK0JUtS7HFUifingxs7o/ZOE6M6Hk6WCuO40fXp2rIPWHu/N/mQ31B5bWvz057zr5MBiKU5du8EwEfXTibpO+VzKYs25CJRMmYO0OkeFF3yl3SLqI6ORjIBFhZWTKzeth6oO0t6lkoTfARMNDsoTo3ksayVN8wqHlMY8dSA9v6U/oW0L7xDvbBpN7E2gXlz4ItgTgA+lcKrqwQ0fcxOOtzkjJHYQ/06bSmZhho3fXvjOdZykMdnsYsnSd8oG7AXP/ANGLGOrz9baOwiSFthfnvq3W2V/CbLJWU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI4xR4tPJKMQ98wa5MXQArqM5EAaTTD4+2rBiTLjge8=;
 b=AurBp96CL37yorUMvX2QayLMLVVOz5qGRwRAZJ3nTMClnpDwLu/FKCNfzrlUc3J5xraSm+7iyHTOa6rDylcRmJdLAVUgQ3qCh35Ng/Hxtuex+n8IQXQeZAO9rPCifOZ+RmoCmpnxEIgHJENcCqm1zR1TrcHODqSVX6K0Z9hfL16D0CozuQI0Sas3FXOEanS//3XQsUThuuxejGoDVzwJTJgpLwN8lgzhDIQwnZvGCWhl3ZaQL6UO8yazxonPalI9xBob6ZLck4bz0Mvk52O4tYM2bZ+Gmzx7ukCk+TKGlWLJ58/moVq8fGm2/5P4eF1xia3VkTGgVrYu9+jDaEx/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI4xR4tPJKMQ98wa5MXQArqM5EAaTTD4+2rBiTLjge8=;
 b=l0jLSLBmgsxvqf6iCF293Tx7qpLxOzn5BuMYr2G8V8DIaTHm/yj/XsQ1I6sO36N+Q2CqSS/6EKGlckqdhvxpY4cZQdYfpNbboqJfKFFpIpYSQ34hxSyRvXws5lPwwOTjvrwTBuKYRpi61GxX/1Lf/dFfrZ+tDcxTbm9yhZ6iniw=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 17:56:24 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 17:56:23 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/50] DC Patches July 10th, 2024
Thread-Topic: [PATCH 00/50] DC Patches July 10th, 2024
Thread-Index: AQHa0wCYiGlPegPHbEiOaboCCttwWbHzYwZA
Date: Fri, 12 Jul 2024 17:56:23 +0000
Message-ID: <DS0PR12MB6534B2EF207B73E7944072619CA62@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ActionId=da36695d-0fec-449f-997b-625f47e3b46e;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_ContentBits=0;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Enabled=true;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Method=Privileged;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_Name=Published AMD
 Product;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SetDate=2024-07-12T17:54:43Z;
 MSIP_Label_0fec2151-cbe0-4586-8a3f-997880a38a28_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA1PR12MB8224:EE_
x-ms-office365-filtering-correlation-id: e538c362-cb63-4841-7c92-08dca29bf18d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?h0oUKl4Rvlcbz7iA4JxXPtd5obsMLHgJEAO1hXuhEjFmMqdvVj1PO6hRlcqg?=
 =?us-ascii?Q?h5FhGrOc5XrWzs8zsmpWr4honYi4AIymguR01gd7P5ucol82O/cLULtqhRia?=
 =?us-ascii?Q?A1sYFpmooOnNdJYcMRt5PRrnh3doiWxo1DfMQ8/ZCu7umc3itNWw0zq0+WVZ?=
 =?us-ascii?Q?pgTFcrwGc7HKRFja6hglWF1VJg2vvXkmEnj1cvVi9tNRpmjBLwUOsKzkIDFN?=
 =?us-ascii?Q?QjWFOpL7tHoN34HBHfW18Id4K1PJ4HfwMjR/jChi9xQGuqEbHqlm4ksKsjnN?=
 =?us-ascii?Q?EIcY085jVIlt3AP8qsL2j0WOlEveUpt/nzbdm9CipXqZb0Q7AEdVx0UIHGsg?=
 =?us-ascii?Q?kvNprVt0hhJeePgI9I1Xh7CxPVL6XSub7+cNNXs9ClrWOhlKkGniDiUcQWkv?=
 =?us-ascii?Q?rF4hIhZH09ON3IoNMOJQ6Tkv/ZbrUtEPfN9KzO2VlkA8JsrWn60YdQDcP2i/?=
 =?us-ascii?Q?jW8ka4poKFXVj+V1NihzKK6FRarI1rtp+FjA+BuyIYvfpdGIlxNJpe67rP+6?=
 =?us-ascii?Q?Q1WlVR7NWgj6TG+qWTZZvrXiIzOnnulpvIyeZi7HJotyZIPATue8CJDSqET7?=
 =?us-ascii?Q?EOVlu6AoadFPL8CX4C753hQ+gjwXjAUN4KM5orbxEuz9wEbdoyKjocQgNxI8?=
 =?us-ascii?Q?XT6mMkCnb545+8YWsYYV7atwMChebdbH/r0B/VNvHSw2nwQr6dCTuPEPCEqS?=
 =?us-ascii?Q?ye2zcubL4F5iqcKyIe3tSVttvtZo5hra52Dr87vGZQ1+4U8IIH6IRPe4V8nI?=
 =?us-ascii?Q?c2Znpdg3XME582UmUhDA6A6PCMxhRWGmcYA2ImqKmqtBbHYN+KpZof0dKC6t?=
 =?us-ascii?Q?/I5W4HzfHvWH3V5Pp2l5mGwcPPrm3yfaqxf7xwnAAD7R0vqe/Jio1ifkFrh+?=
 =?us-ascii?Q?onvZP7i+vi0d2/I1fZlZZ9x6epxSJeQ/7UfmQVZOFm+G3MuBeITdPpG5RDoE?=
 =?us-ascii?Q?dyYau8mbXHhfpf6wl3b8iO6Hw3odyz47C1YMJ8XZomv7X4EheOzhWsLyazxe?=
 =?us-ascii?Q?FzMCOGldsM0XsQRJMAnMxA3ZpId3lncG+GCY31Pk/fLE+khiyi5Mg8ua8GZn?=
 =?us-ascii?Q?KVQwt9nL1deTnpxWhaagIMaI+lzw54LxGtlzNQt7WfOq4Ot+9h0QEdGRER1t?=
 =?us-ascii?Q?JBgWZih/W4cFIPQdqZzVm56GZraVq7XkystoCl680nQTkyUb+3h0MYsfVYMN?=
 =?us-ascii?Q?oqLSC71B2ginbJO3hL3O3OtivMGJmdUsHd3xZZQ6rn6FTWLS7UhuwoLa4bBm?=
 =?us-ascii?Q?71ZyZeZQPQDYfFNDuq7wnlj0VL4sfddtzEPCzY0W1SAvHkmUxObXrqOmMUY3?=
 =?us-ascii?Q?nzCrZNJmVDCzuZhTex0W6aToQZTNPE8g+tLqKD7HzNgNcGgMbmjVD50kTjMz?=
 =?us-ascii?Q?y9Z48RdubIKhtGzrKcP41AWNX9mVI/XmaM7FZoSvl31ji7JP5A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/2jWOH4cVohK1I5v7CQgtKxzw9yRI+3l+dX9EZvPx5734i3I2PfWgQtAf5a?=
 =?us-ascii?Q?BY8rJChAZsWFRvmg4RowDWSCe6SKRmxTaN75j6zg7HoShmnWB+3vo771Gf7h?=
 =?us-ascii?Q?5gUmTmg/T40hqhhmb0GJpGkXaU6GQepdKLGbHziJHRQasph973SI2SXwPR4D?=
 =?us-ascii?Q?jZmiqxFpKgzRQRQ9d36Uc4CeTxKJbCkAA8ZFDzpyJ8r0OXFIXJXD2n0GAEpf?=
 =?us-ascii?Q?bzVcrAPOMmCbpUdyJ2EdnJpdzQdu62YuBI3/4gyaXr08zPOS9QR2Ddsh23nb?=
 =?us-ascii?Q?A/dOReZsMHHa8UCbMgkt0u/QOrgcfCRBSosVjKJQOgdNO/qBYZN9DDAP1RYm?=
 =?us-ascii?Q?VNmt+qOGypFdiIKlzJzW9+nZaGFOyTPTG1BMkO8Sc3TxW877Fbh/x9X2d4H9?=
 =?us-ascii?Q?6EfkQM8iSs2lQ7K3bJHdqd2t3RPMrCWe0SF5E5d1RfFaxHtZHpq//3zGzdK9?=
 =?us-ascii?Q?YGTkGSiZROzu6woQXvvZx/Bfo3Iqj36DL7Ghi4FMmKq4o/Bmsuc1AcHHE5Mn?=
 =?us-ascii?Q?VquaO3N2NPWpnkejkQWID0h6bIXQfPzyJR2sddGbJcYZxAwFdy4pgR87yO/X?=
 =?us-ascii?Q?M1DK2dDY24BsXzq+AgiDb2rgjjPsXHDKggNZNgk0026vKN34b5n1xjh86gyX?=
 =?us-ascii?Q?3KQrjayFMOcxcAjUwaKSPW70qODAMRxyMuklNsTvASJuChwnMd67pHJ4h9XM?=
 =?us-ascii?Q?66i44vwsTkjfTWgacVh8VjJtkcsABI4ojjw4VlmcJL/JHV0v4CZIpdBoboNu?=
 =?us-ascii?Q?KVTAXNvnS0y+Y6dIN5zvC+9FKBmS8VChSrD3bNmBv8Xf66zJtwyvMJxE0pjV?=
 =?us-ascii?Q?mEU1rrnrXv2fXM5duNp/mDj1r0D2o/m45O8aGAH01Wns7xE1tXAzOJ5y6m3p?=
 =?us-ascii?Q?sUuJsiREnnNHtvQDEfv0yQ7D6BFLUcH5J+68b1bNy99nfWhaYzcJwFDGbVip?=
 =?us-ascii?Q?BdZ8WrR3FwM4pVE80+M5hw0kVjgKNRX+XxMMjnAmeusv61b9k60TccwlBDUu?=
 =?us-ascii?Q?9NEJ56K2fhde4iR4JBaLJ2eDH3gn5XyB5ZxKpgcwDYCi7RQcUsizlYINJfD1?=
 =?us-ascii?Q?vGyw0SUqpS+Wvs1MsSIYomePzxH0gFgJ3eq/X+CYRxUcQ+IExItqIYpStlQn?=
 =?us-ascii?Q?QOvBkS+SdS4/DJoXHpwPE8aysvdNtF/Q0AttdIwu5hyAGnRo3gEoHuT4Sh/q?=
 =?us-ascii?Q?b79gQJm4H5/nVRGpkCvU6XPIbmdi1tbTxzzZqIdAmW1bn7fPnyWYfZbTS2D6?=
 =?us-ascii?Q?Ien9ZAcRV2BXrfkQIvvC7bj9p7xsgbXHvYu6rAmxRYl7BmwSaMaszWc+lGNa?=
 =?us-ascii?Q?WGVruWaKBa8653fGzTAZ/y5TwAZjZktO8YhjG7o/zeOkohj5URGQqUo3st1V?=
 =?us-ascii?Q?wZP2G3Lzo1a+HRuLc2VzxXzAnj9g0NNt5EfkKYn99JlfecrEsJ9Oaculgnt6?=
 =?us-ascii?Q?G8Zo3FvqzrqQPHMZk9Cappa44Dm67rrMngeesSx8qx0fWQWU4nZWBMOtqBx1?=
 =?us-ascii?Q?Ops4m/8I/TV15HBr3ij8amugZ2I4egosob7MmIW2sxBHljkQSLKFXLpXzz0w?=
 =?us-ascii?Q?8AtEv0NHtZOZymc4E+M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e538c362-cb63-4841-7c92-08dca29bf18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 17:56:23.5533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWw6zTdb/dCb5nZA3x6GUWOaCdOZsNiNg1II3uYP712ZCtwfhpn60DOlAlfbPWx0jvY4uILzsgEKgbxl6jDDAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224
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

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - drm=
/amdgpu: add ras event state device attribute support) with new patches add=
ed on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Sent: Wednesday, July 10, 2024 3:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Zuo,=
 Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/50] DC Patches July 10th, 2024

This DC patchset brings improvements in multiple areas.

* FW Release 0.0.225.0
* DML2 fixes
* Re-enable panel replay feature
* Allow display DCC for DCN401
* Refactor DWB, OPP, MPC, MMHUBBUB
* Fix dscclk Programming issue on DCN401

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (11):
  drm/amd/display: Revert "Check HDCP returned status"
  drm/amd/display: Initialize denominators' default to 1
  drm/amd/display: Check null-initialized variables
  drm/amd/display: Check phantom_stream before it is used
  drm/amd/display: Pass non-null to
    dcn20_validate_apply_pipe_split_flags
  drm/amd/display: Check null pointers before using them
  drm/amd/display: Check stream before comparing them
  drm/amd/display: Check link_res->hpo_dp_link_enc before using it
  drm/amd/display: Check null pointers before used
  drm/amd/display: Check null pointers before multiple uses
  drm/amd/display: Increase array size of dummy_boolean

Alvin Lee (5):
  drm/amd/display: Disable HBR audio for DP2 for certain ASICs
  drm/amd/display: Don't consider cursor for no plane case in DML1
  drm/amd/display: When resync fifo ensure to use correct pipe ctx
  drm/amd/display: Disable subvp based on HW cursor requirement
  drm/amd/display: Calculate ODM width using odm slice rect, not recout

Aric Cyr (1):
  drm/amd/display: 3.2.292

Aurabindo Pillai (3):
  drm/amd/display: free bo used for dmub bounding box
  drm/amd/display: Allow display DCC for DCN401
  drm/amd/display: improve logic for addition of modifers

Chaitanya Dhere (1):
  drm/amd/display: DML2.1 resynchronization

Chris Park (1):
  drm/amd/display: Deallocate DML memory if allocation fails

Daniel Sa (1):
  drm/amd/display: Set Cursor Matrix to bypass instead of Input Plane

Dillon Varone (3):
  drm/amd/display: Add blanked streams override to DML2.1
  drm/amd/display: Add P-State Keepout to dcn401 Global Sync
  drm/amd/display: Export additional FAMS2 global configuration options
    from DML

Duncan Ma (1):
  drm/amd/display: Add visual confirm for Idle State

Fudongwang (1):
  drm/amd/display: add dmcub support check

Gabe Teeger (1):
  drm/amd/display: Fix DP-DVI dongle hotplug

Jingwen Zhu (1):
  drm/amd/display: avoid disable otg when dig was disabled

Joshua Aberback (1):
  drm/amd/display: Remove unnecessary DSC power gating for DCN401

Mounika Adhuri (1):
  drm/amd/display: Refactoring MPC

Mudimela (1):
  drm/amd/display: Refactoring DWB related files from dcn30 Files

Nevenko Stupar (1):
  drm/amd/display: Issue with 3 or more mcaches per surface

Relja Vojvodic (1):
  drm/amd/display: Implement bias and scale pre scl

Revalla Hari Krishna (2):
  drm/amd/display: Refactoring OPP
  drm/amd/display: Refactoring MMHUBBUB

Rodrigo Siqueira (1):
  drm/amd/display: Remove unused dml2_core_ip_params struct

Roman Li (1):
  drm/amd/display: Replace assert with error message in
    dp_retrieve_lttpr_cap()

Ryan Seto (1):
  drm/amd/display: Added logging for automated DPM testing

Samson Tam (2):
  drm/amd/display: quality improvements for EASF and ISHARP
  drm/amd/display: remove dc dependencies from SPL library

Sridevi Arvindekar (1):
  drm/amd/display: Add option to allow transition when odm is forced

Sung Joon Kim (2):
  drm/amd/display: Do 1-to-1 mapping between OPP and DSC in DML2
  drm/amd/display: Check stream pointer is initialized before accessing

Tom Chung (3):
  drm/amd/display: Disable replay if VRR capability is false
  drm/amd/display: Fix VRR cannot enable
  drm/amd/display: Re-enable panel replay feature

Wenjing Liu (2):
  drm/amd/display: fix dscclk programming sequence on DCN401
  drm/amd/display: apply vmin optimization even if it doesn't reach vmin
    level

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   74 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   31 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   27 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |    2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   18 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  250 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   22 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  102 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   34 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    7 -
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   48 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    9 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    6 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   32 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    6 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    2 +
 .../dc/dce110/dce110_timing_generator.c       |    1 +
 .../dc/dce110/dce110_timing_generator.h       |    1 +
 .../dc/dce110/dce110_timing_generator_v.c     |    1 +
 .../dc/dce120/dce120_timing_generator.c       |    1 +
 .../display/dc/dce60/dce60_timing_generator.c |    3 +-
 .../display/dc/dce80/dce80_timing_generator.c |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |    2 -
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |    3 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |    4 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |    2 +-
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |    9 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    2 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |    2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |    7 +-
 .../amd/display/dc/dml/display_mode_structs.h |    1 +
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    3 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |   45 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |    1 +
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  145 +-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   13 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |    1 -
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    1 -
 .../dml21/inc/dml_top_display_cfg_types.h     |    2 +-
 .../dc/dml2/dml21/inc/dml_top_policy_types.h  |    1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |    6 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    2 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  124 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  189 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |    2 +-
 .../dml21/src/dml2_core/dml2_core_factory.c   |    1 -
 .../dml21/src/dml2_core/dml2_core_factory.h   |    1 -
 .../dml21/src/dml2_core/dml2_core_shared.c    |   44 +-
 .../dml21/src/dml2_core/dml2_core_shared.h    |    1 -
 .../src/dml2_core/dml2_core_shared_types.h    |    8 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    3 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.h   |    1 -
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.c   |    1 -
 .../dml2/dml21/src/dml2_mcg/dml2_mcg_dcn4.h   |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.h     |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.h   |    1 -
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c   | 1250 ------------
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.h   |   25 -
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  553 +++---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |    1 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |    1 -
 .../lib_float_math.c                          |    1 -
 .../lib_float_math.h                          |    1 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../src/dml2_top/dml2_top_optimization.h      |    1 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   17 +-
 .../dml2/dml21/src/dml2_top/dml_top_mcache.c  |   23 +-
 .../dml2/dml21/src/dml2_top/dml_top_mcache.h  |    1 -
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |    1 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |    1 -
 .../src/inc/dml2_internal_shared_types.h      |   27 +-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |   27 +-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h  |    3 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |    3 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   14 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  540 +++---
 drivers/gpu/drm/amd/display/dc/dwb/Makefile   |    9 +
 .../dc/{ =3D> dwb}/dcn30/dcn30_cm_common.h      |    0
 .../display/dc/{ =3D> dwb}/dcn30/dcn30_dwb.c    |    0
 .../display/dc/{ =3D> dwb}/dcn30/dcn30_dwb.h    |    0
 .../display/dc/{ =3D> dwb}/dcn30/dcn30_dwb_cm.c |    0
 .../drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c  |    1 -
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    3 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   20 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   13 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |    2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   41 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   15 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   19 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 -
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h |    2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |    5 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   13 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |    5 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../display/dc/link/accessories/link_dp_cts.c |    5 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |    5 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |    7 +
 .../drm/amd/display/dc/link/link_detection.c  |    5 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   41 +-
 .../dc/link/protocols/link_dp_capability.c    |    8 +-
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |    9 +
 .../dc/{ =3D> mmhubbub}/dcn20/dcn20_mmhubbub.c  |    0
 .../dc/{ =3D> mmhubbub}/dcn20/dcn20_mmhubbub.h  |    0
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |   27 +
 .../display/dc/{ =3D> mpc}/dcn10/dcn10_mpc.c    |    0
 .../display/dc/{ =3D> mpc}/dcn10/dcn10_mpc.h    |    0
 .../display/dc/{ =3D> mpc}/dcn20/dcn20_mpc.c    |    0
 .../display/dc/{ =3D> mpc}/dcn20/dcn20_mpc.h    |    0
 .../display/dc/{ =3D> mpc}/dcn30/dcn30_mpc.c    |    2 +-
 .../display/dc/{ =3D> mpc}/dcn30/dcn30_mpc.h    |    0
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |   16 +
 .../display/dc/{ =3D> opp}/dcn10/dcn10_opp.c    |    0
 .../display/dc/{ =3D> opp}/dcn10/dcn10_opp.h    |    0
 .../display/dc/{ =3D> opp}/dcn20/dcn20_opp.c    |    0
 .../display/dc/{ =3D> opp}/dcn20/dcn20_opp.h    |    0
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |    9 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   36 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dce110/dce110_resource.c      |    1 +
 .../dc/resource/dce112/dce112_resource.c      |    5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    3 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    1 +
 .../dc/resource/dcn32/dcn32_resource.c        |    7 +
 .../resource/dcn32/dcn32_resource_helpers.c   |   10 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    1 +
 .../dc/resource/dcn35/dcn35_resource.c        |    1 +
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    3 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1306 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  426 +++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   33 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   51 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   23 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  518 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  546 ++++++
 .../gpu/drm/amd/display/dc/spl/spl_os_types.h |   77 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    4 +
 .../gpu/drm/amd/display/include/fixed31_32.h  |    6 +
 .../display/modules/hdcp/hdcp1_execution.c    |   18 +-
 175 files changed, 6110 insertions(+), 3122 deletions(-)  delete mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/=
dml2_pmo_dcn4.h
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn30/dcn30_cm_common.h =
(100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn30/dcn30_dwb.c=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn30/dcn30_dwb.=
h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dwb}/dcn30/dcn30_dwb=
_cm.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mmhubbub}/dcn20/=
dcn20_mmhubbub.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> mmhub=
bub}/dcn20/dcn20_mmhubbub.h (100%)  rename drivers/gpu/drm/amd/display/dc/{=
 =3D> mpc}/dcn10/dcn10_mpc.c (100%)  rename drivers/gpu/drm/amd/display/dc/=
{ =3D> mpc}/dcn10/dcn10_mpc.h (100%)  rename drivers/gpu/drm/amd/display/dc=
/{ =3D> mpc}/dcn20/dcn20_mpc.c (100%)  rename drivers/gpu/drm/amd/display/d=
c/{ =3D> mpc}/dcn20/dcn20_mpc.h (100%)  rename drivers/gpu/drm/amd/display/=
dc/{ =3D> mpc}/dcn30/dcn30_mpc.c (99%)  rename drivers/gpu/drm/amd/display/=
dc/{ =3D> mpc}/dcn30/dcn30_mpc.h (100%)  rename drivers/gpu/drm/amd/display=
/dc/{ =3D> opp}/dcn10/dcn10_opp.c (100%)  rename drivers/gpu/drm/amd/displa=
y/dc/{ =3D> opp}/dcn10/dcn10_opp.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/{ =3D> opp}/dcn20/dcn20_opp.c (100%)  rename drivers/gpu/drm/amd/disp=
lay/dc/{ =3D> opp}/dcn20/dcn20_opp.h (100%)  create mode 100644 drivers/gpu=
/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h

--
2.34.1

