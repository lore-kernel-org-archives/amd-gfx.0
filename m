Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF42FD5323
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E50310EAB2;
	Fri, 27 Feb 2026 09:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="PCgjrO5b";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn19011035.outbound.protection.outlook.com
 [52.103.33.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E3A10E9C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 17:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd3FH/g4HAS/k1dR59z+Q4vxxgnHC0FOXQkvUtuPbqhBr4cKLUl63vahLB4tA7GQfDm/QbxC1efe2iRK9WxgXovb5EXFw6adv+9LVaFHK4vQ4Vtk3ba9Pi1nbpTkoW4ZWICy9PcF14tGvQMRkmduegH1KA2LwcrMqlsyO9mrk3FXkZ2UvQc61NuLLmUtOC1jl9l9QGilLpzetZJNTpm7e4iDNb8gT9CM0Oafn2PEz+4UFPNrBKdiC2w9mW1m8HzllZtMedKpgZcyw1GnWYIbF7jnWmpYcj9PDadwX6Cmu3ZXgCkbnxu0kp+zBy/S4dGqgIOSXn52zjysYshX6vSjmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqiWERNzNvYnmvZR1xbakSA1gF1dImQP5svNi/sR4kM=;
 b=TlinJ6SG79TSZmvdtiPXqrtock795vhSKGtsDzYxLbSnabhbV7PPywO88a5RNCXQz3UY3t20aUgelcEkVqdtgXqwpaDdZ/ZvUHGX3wPnSc2b8xtjUayOmEnSadvWNnnS0bp3SDcdr4754/L9rXp00HM17l4wC45pIEfE6SJv6Qxa9WkTn+MR6+vPCycsGj95YzoeOFQOU03HH+LKjw2J6N1IpzMalI7V1O9WtJBWwqbY0Q//QJm0b4D/orkZJ0MT6ZkGm/UeuDOT9ArPULMgGAvFgZ3v+sGUS030Z8cqTZht19clvGnoJf5zQGCwRbJTds+2NQMJUPP3rHEBcfCsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqiWERNzNvYnmvZR1xbakSA1gF1dImQP5svNi/sR4kM=;
 b=PCgjrO5b0vWmqwLXPsJuf9+KyKI1scAaXacv9i4aZmKgQGEz2GTBDuE6UYE3rbYIM3dAkw8TznpGnz2UXS224UahIvqxtsVg+4xRGqGzi95M79E1d+GWPtj7MIy8wJh8jk1i68KwakmgSUu39Cei092nuKfg5AxLIjQYiH1QBC4vpUxqhzGphNVo6CWs1W8OBtTlEZtqlt6RYq8rO76QcFoOMdzXT44I6oNIyjJWXx53IbOnOsQ/SY6U+RYOI6QOAESCbFuwV4Hq9BaCDeJZKZhlqwDugAKVCaQp7Zokpe8wfsw/4yUEfeaKEuZY1Sr9iCqLhLb0BqwXPRRUzmhnBw==
Received: from VI0P251MB1186.EURP251.PROD.OUTLOOK.COM (2603:10a6:800:2c7::9)
 by DB9P251MB0324.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 17:00:35 +0000
Received: from VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
 ([fe80::4df7:d492:7941:a68c]) by VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
 ([fe80::4df7:d492:7941:a68c%3]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 17:00:35 +0000
From: outlook user <RACP@outlook.fr>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Inquiry: Raven Ridge `RLC_RESTORE_LIST_CNTL` failure (0xFFFF300F) on
 Kernel 6.17 - Missing GFX9 fix?
Thread-Topic: Inquiry: Raven Ridge `RLC_RESTORE_LIST_CNTL` failure
 (0xFFFF300F) on Kernel 6.17 - Missing GFX9 fix?
Thread-Index: AQHcp0FINCiukw/80Ua+DqPOnGFf1g==
Date: Thu, 26 Feb 2026 17:00:35 +0000
Message-ID: <VI0P251MB11869B2637BE556CFA76E6C89772A@VI0P251MB1186.EURP251.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P251MB1186:EE_|DB9P251MB0324:EE_
x-ms-office365-filtering-correlation-id: bdda53b1-23b8-4450-ae74-08de75588f11
x-ms-exchange-slblob-mailprops: qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpoCjQtDLo6RCLq60410KIVlxOzw9OhUglkzhvAvZyj2rTZlLP9f0JfJ3pjRQ0XfAJJTdtllpktcIR0N4UUgxq6BwlMBvaFzhHoRlK0sxrOsSaX/WeoGuPiLJGMrqbTBIOeikik5AH9AQ9HzUvm+Gj4XGr2XXjP2fvfH+o74C7EpgISpRfOZFvLR0Nfc550NBnkCs/1ZYTGT+OuDprhUKHqx+2/lGtG7vRnCvF+iltAohqSiMrvOuU8Fp8atx1uFd4iCESrGkeOdpaSTP95NICM8Sa1ipuPdLcDFfJMjJJ8XB7hG4Fkxo4fIn9TG/twfmQXWsDe9kK1UDpHTl5uLE9eNTL+VoguPbGqNu+6sr4sCRf3y4P5E1XSgMEV6lDgaC5RIKb4zieJeF6lLomcd2p9tOdpVfwshmC/rh50YvBQcur/kjFGRSRSgKohoFGOvbkdTEBDrHd1wluUpYvXfEPu2Uyy8q62c9esziLROUYQ/bbzR6wbtbRf7hEXlxbAgPr1OufRhBO28MgAn9t5CVWbxEMSFEo/l7O3EEaCfZBElFhA64Ro8IRwC9hGB0SlIZG4vv8v8Y2Bv+UoBSHL3fcvDcBS5yNIN0Ddv7VRRph8kS4KfZs6ZWtDDfSc3Fj3Jn5TJ6ju2rXtjDetdU3Cu46jq6S+i+fYgtDl0pEaxXd66gb/yR0qzBzU3CwR9ZbhcTAy+FGFj8a9jA4KwdN1pypC3l8jpWuzLYZJYocHEVwor52NpNRH++C45BqLtGD9AQVr
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|39105399006|55001999003|20031999003|8062599012|8060799015|19110799012|15080799012|15030799006|31061999003|21061999006|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Pcj6C5I/d3R2wZ6btqxErSpsDcIQtC28X0o4Bw4gAiDYAbY/zRDaS9Frzh?=
 =?iso-8859-1?Q?QkUZGLGcYrqIuXfyW4X0ywrubHN5GbPTPx+Lm4mLDCtvEtxQRg/yhosuG1?=
 =?iso-8859-1?Q?6VTtuWEoVdGTF/KYHOk/Z+8untgAjxlAlESXoI6qz6w7VT/kV2YAU0yK5t?=
 =?iso-8859-1?Q?4KplXsUIZ0EKq4ahAmi1jKO2QnsmwZwoYZ2cVuyE5usW0UMlRrInrahZVl?=
 =?iso-8859-1?Q?hj1xaGOThhTZseNtvq5Wne1TEn9vkfLjTYtXuzmxuP7crsidRz92ZV19D/?=
 =?iso-8859-1?Q?5CivT0+oK+/hTOJZCZWvsZjyHFt/XMeKd4w2GUwCurC4ipI+23gjm0mfFh?=
 =?iso-8859-1?Q?IaKS40XMo8fl5YBS80vfuMVtXHYDXu2CYKPjgGBz4uIzVNmzDfjijq32Au?=
 =?iso-8859-1?Q?tB9OUUXRu4ZuazO//lhabH2b4wNdu7hLEnF0z+N62OPdrT8ug+jiTF1gk2?=
 =?iso-8859-1?Q?m5JIgiZkB0YOX/WV21t0uiBeZewf7+nGsTWpdCWWZQyuTAZM2ZduVi17Kl?=
 =?iso-8859-1?Q?B+5ZT2SuE0QAlcm1YyttPB29NXW09MBT4RIKtv8gKqyQOqgWZzSYH3aZ1F?=
 =?iso-8859-1?Q?l8+TrtVOgICTro49wlb3xPnq7fsUxeEqWgYCKJUxxeRfoyhMwymHeqdvgK?=
 =?iso-8859-1?Q?Hi/wg9GeaT8AeQ6TtgBpym6o89cQ5/eZGlAkcywJ5ScjbjUh3i5JOBC2rI?=
 =?iso-8859-1?Q?2Ky43wiZm9QbYOKFIlrdTEo6MbtHNI9D8j0Bn7NAJ2D7nUSYhn85yTa1yq?=
 =?iso-8859-1?Q?emXbx8FSwwZQ4m+Q+65gxFwtvv3qYOjM7x63zG4fzHYxWBi56ZwXHhPT5N?=
 =?iso-8859-1?Q?Kbyxy48nNPSf9rBYgfY5VdOhY7JDP3ZufiJDlIolym/RPid7EHM8czPdF5?=
 =?iso-8859-1?Q?yLNp2zaXM3M0ohRG/wp+544e2kB6x9mN+ClkfO3fMVF83vd0eiBJYNmGhO?=
 =?iso-8859-1?Q?up7Tz7iNVv0CXbMQcabkUQrV+sUUAO4i3u5YlEF99pCmkeq2VwEwLtk4uM?=
 =?iso-8859-1?Q?CG1xsKwZ0PQG+w/K9Y9GG+YrjbuLBnWBTSsbu427KRxQEqeitsSYP/07xR?=
 =?iso-8859-1?Q?TNrj2iaJlvCMkj1euBOfWZo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PuqX1dSmHaZf6yjjQfysH5+6Vcb4FPg8RETpyJgl9RsDCFxzZGCmpG5suj?=
 =?iso-8859-1?Q?0pkk3/gzA9Dcyfyle/2Iu/UlO+L3JcpsFl7l9wwa5Wh5EbmzAYxpSC173I?=
 =?iso-8859-1?Q?PALBF59CfGHFbl017DtK6GMQOsviq5WmC8bxyXFfSQ9SxgMNxQ04G5SpE/?=
 =?iso-8859-1?Q?jbwAY0qJeIVBka7n7ZN4Gh8MaWNLQD4rb0EB+EkqGVdxVGuC5dn2T9Rwps?=
 =?iso-8859-1?Q?3/NpjGGOt/XVDK8UjU4cF9o/TaD0MXowLmmvN4f+3A34UAK53sgIXZvhMj?=
 =?iso-8859-1?Q?l21GwWEn4G+0RnrQwpnayQaLyCpVqMLhDXoR+DeBVfczwA9mU5j9WjjJl7?=
 =?iso-8859-1?Q?NwaAVCXmcUBrsyM0iFN7bdU6whtWZ2Tby/mCba2Bm6FFOwz8pE/KZuAlR1?=
 =?iso-8859-1?Q?ZqZwO7ZqX8j5GP9ENoilOQ8HtsVU/W1ENOc87L37HbOKol4zMzXCB8Jedx?=
 =?iso-8859-1?Q?+e0fO1oL9JWfAi1717Y96hxYBi96OOsreXH7h+fyk5dy6cAFrPNpyPCLA6?=
 =?iso-8859-1?Q?9E/7KvA7t/a2CUucSml1+uSGvIuZxcc430JPUrmtWytiuHEFEaSninLrof?=
 =?iso-8859-1?Q?sl9MKakjhkcrJpzOh9fWt3tPsR1hjdR1Vo6TRDk9z4pAydEIz6/FgTvavl?=
 =?iso-8859-1?Q?iNJHy3ZdDgVaUxgY5DsW1w+YcNWU6UoYzn6SNWcxERNaaMGqxRAUhYaoCO?=
 =?iso-8859-1?Q?ZxwY4Ni+1O5LFQfp61ildVuUbWsC5nIE+0Z493xat18ZOaXfwpVN/103qn?=
 =?iso-8859-1?Q?z38fiO8zwfV9k5yvLmQA1XAUISuRZ6nz7QezFfuGqrGu1CYZkprQNx7THN?=
 =?iso-8859-1?Q?T3444bnPS2/8moZkaa4ANuCsyuxmPeFt9m0/Z5Ygzuw9w6jcBLkR1WbNcD?=
 =?iso-8859-1?Q?/SHvfQz8Joez5ZGAIi1BPig5MGUiR1PMBx0oD1xt8xx0CLN6mxeUifLNRm?=
 =?iso-8859-1?Q?+eYoSuSC+ZzRFGAuwXdwCdNIqVur0o3BKrKpm2UdlQ386kY/BFxkL4LipM?=
 =?iso-8859-1?Q?z2wFsmQqS23HA2Qv4vv2SqbOA5ZKyfotyO9PwSZ+VAp8BRZJSWUb/CcFue?=
 =?iso-8859-1?Q?Hh/9FTikiIC5mJOSSohgLAU1FnS9rpS7B1ivOm19KrpN9ZsqBiqnl9RODE?=
 =?iso-8859-1?Q?s2CPhw1FZhlhx6rQkOLYg1Hr9lD7M6+WEkTUXDkUUQ4El4T9fpUpiutxk4?=
 =?iso-8859-1?Q?+mOe4CkAqEKKFqa7FblS4elclybRMbEnijbIvFMpaW+hgtXgbM2WY9Dpxh?=
 =?iso-8859-1?Q?hqTNbM3jIIF6uoCByhXlRasc2qEiSruYNTMYfyObmPZ+a/CljkJu6nGg7A?=
 =?iso-8859-1?Q?p5JLeoa8woQRfURqC4vIq86EYS1jQRhPA1a7HVlWq20DHwdURuRzCcSUtC?=
 =?iso-8859-1?Q?syHGn2Syw8kXIAGRi0czmCRlWwNYNhUx1VnjT63FNvqpfL4eqeAug=3D?=
Content-Type: multipart/alternative;
 boundary="_000_VI0P251MB11869B2637BE556CFA76E6C89772AVI0P251MB1186EURP_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P251MB1186.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bdda53b1-23b8-4450-ae74-08de75588f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 17:00:35.0912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P251MB0324
X-Mailman-Approved-At: Fri, 27 Feb 2026 09:17:00 +0000
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

--_000_VI0P251MB11869B2637BE556CFA76E6C89772AVI0P251MB1186EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Hi team,
>
> I am running a Raven Ridge APU (Ryzen 5 3500U, device 0x15D8) on kernel 6=
.17.
>
> **The Issue:**
> I see persistent firmware load failures at boot:
> `amdgpu: failed to load ucode RLC_RESTORE_LIST_CNTL`
> `psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF300=
F)`
>
> **Context:**
> I noticed the recent patch *[PATCH] drm/amdgpu: fixing rlc firmware loadi=
ng failure issue* (Aug 2024) which fixed header size mismatch issues for GF=
X10 by switching to `request_firmware`.
>
> **My Question:**
> Should this fix also apply to GFX9 (gfx_v9_0.c)?
>
> My system is currently using `amdgpu_ucode_request` for the "kicker" path=
, and the hardware rejects the firmware (likely due to the signature/header=
 mismatch mentioned in the GFX10 patch). This leaves the GPU without RLC lo=
aded, leading to intermittent system freezes.
>
> Is this a known gap for Raven Ridge, or is there a specific firmware vers=
ion I should be using?
>
> Thanks.

--_000_VI0P251MB11869B2637BE556CFA76E6C89772AVI0P251MB1186EURP_
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
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Hi team,</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I am running a Raven Ridge APU (Ryzen 5 3500U, device 0x15D8) on kerne=
l 6.17.</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; **The Issue:**</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I see persistent firmware load failures at boot:</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; `amdgpu: failed to load ucode RLC_RESTORE_LIST_CNTL`</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; `psp gfx command LOAD_IP_FW(0x6) failed and response status is (0xFFFF=
300F)`</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; **Context:**</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I noticed the recent patch *[PATCH] drm/amdgpu: fixing rlc firmware lo=
ading failure issue* (Aug 2024) which fixed header size mismatch issues for=
 GFX10 by switching to `request_firmware`.</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; **My Question:**</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Should this fix also apply to GFX9 (gfx_v9_0.c)?</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; My system is currently using `amdgpu_ucode_request` for the &quot;kick=
er&quot; path, and the hardware rejects the firmware (likely due to the sig=
nature/header mismatch mentioned in the GFX10 patch). This leaves the GPU w=
ithout RLC loaded, leading to intermittent system
 freezes.</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Is this a known gap for Raven Ridge, or is there a specific firmware v=
ersion I should be using?</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: &quot;Calibri&quot;, &quot;Helvetica&quot;, sans=
-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Thanks.</div>
</body>
</html>

--_000_VI0P251MB11869B2637BE556CFA76E6C89772AVI0P251MB1186EURP_--
