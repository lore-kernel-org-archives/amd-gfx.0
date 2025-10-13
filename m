Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EE1CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 11:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FBD10E43A;
	Mon, 13 Oct 2025 11:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I0JvFmw7";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D1910E431
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 11:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZeSCxrcE73Gt4IcpITGIMGIBgKc/LiUhkgiEHyAZ0qSjcaSrxEY8PSi+9JClf9WPPGZpnXyhqohFsIbz6dCua6J8lQc3K7r13n/5xsDWqxVQrrU3cRPmkubNDmmaaiamV89+TsueVRYTENY3I0hNURO/B3XR/deBQ3xE3YEAgo6S4Sbq7KabH/ZH9SoHShYApW7Snu78t5iLbVzlLEv+XmsDJAZEAV/HuCuVWkdh93zN7VzTnCWNrIZZ6NvNSTyUKkknVbB/DJlrGoiQ5MfqdMyfHW9+o6ZE+pwLLj3Ad0RbQvvIDc/9lNPScATCupvIWB7xQGUWDuysLvL6occoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIJGh00BZcdmx9JCktDPPWl+k4dqFLyWRCsIGwZFmcg=;
 b=F7BQjIZw6qBrl2OJxgW0OTA1UWoAR0HxV4P/3tfb0Z5m27CyDu4OYJNzeWvkUGSlqwlC3jmbfbpbALP/hGleRWWsd52x6Sm4T+kf3eSRK3m24KYtpU3U68L2QNSuN9uettETFun3SmekoAQ+BqksLK0krgbgSFXYZUaIzJgRv/wUYk7ajZRMdUhr6UnX7nB6cZs1PenRQuzl8pIiCT1msMMO654Y8toeGsk0ua5bhy2Rl8Mx+jHs0bCdxu++ybVUMCeEB9+l1fDW7aIHeMgMRL+LvgB+QGp6fOzhff1Y3F0YCoqI65Tyeh+Be4IAB22qQqYf1R0sd9CD2Xxlp1pH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIJGh00BZcdmx9JCktDPPWl+k4dqFLyWRCsIGwZFmcg=;
 b=I0JvFmw7AaGonCdDGDX39mRsWlsD/jNHrS8u0/jGHxLLO3GuaWNVqIj8GzQAglvCWNPHnzNCOUajCZhtv8inAS504nnHJDaI6/Ea9kM66FYFh7x/Zqn0iq7IN/oyy+E9KLRsR+rMsuPd9zcW3Rl4eHSrdXagADuN0dn9cBZ7hF4=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Mon, 13 Oct 2025 11:41:57 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 11:41:57 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/2] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
Thread-Topic: [PATCH 0/2] drm/amd/pm: Avoid writing nulls into
 `pp_od_clk_voltage`
Thread-Index: AQHcPBQE5DETxm8lCkqJ4yx/Khi+eLS/zZvg
Date: Mon, 13 Oct 2025 11:41:57 +0000
Message-ID: <DS0PR12MB78045FDBDBE3D3557AA8E92897EAA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
In-Reply-To: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-13T09:22:30.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CH2PR12MB4295:EE_
x-ms-office365-filtering-correlation-id: 8ae0f564-10d8-481e-8ea2-08de0a4d83ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vQwdTYNZudkM4IZH/w8tRDKP2nBNhytBvDmmeo1HzySDG+b3f2LQiZmAvSIM?=
 =?us-ascii?Q?lj86UXWzk3q9JKIviOuD2jZqFY5mwaEo/yEwibg0NjvGAN2CecDiP29UiF3b?=
 =?us-ascii?Q?RRU/72bjC5sKnmYa4TyEmrefA0ACVowcbcCaAcpHsroz3JsYF2tV2YudgtS0?=
 =?us-ascii?Q?L9qUpS6V6hvS3mk18fQzUuGELJDLK76TRxVv7CyYwnsoRLOmnjQhGWYgFtlh?=
 =?us-ascii?Q?JTNktVRKffOdaTkVRfjfVnbV234CB7pK84bX0MiHK5rz80BsxbbFZ6K0ZMuW?=
 =?us-ascii?Q?lc9QSH3gMUp9ZpAZyJ3067+E6EFu4hHup7YHx9JXQvTAXs9cnSUTxsADCEld?=
 =?us-ascii?Q?uKDRFOk/lM65w8v5MsrnrSDZbLPpuyo57J8RrFwwcgdR9pX0NlfWnV+0W2wQ?=
 =?us-ascii?Q?ke9013imS4GWCs9Dc4PhGnje+s5fxLX3Swn+F7FxbwMZBoc3tNG2dkpyuArK?=
 =?us-ascii?Q?quzMlNykv3lRvuym37YOHxsF2oiHM2jZ8C9AuuZ+I+ea4MCim2hXrC2BlpIk?=
 =?us-ascii?Q?BJrboUBwmhotWWAHi8/elcLBMuDOZELIjzSZIv6Lk2qq0J5AJbQ5HBcBN/t3?=
 =?us-ascii?Q?CgB/kEyImI9F60ZZ3sUeKRTtLDm7e8qaX1HBRQZKA9BdTr7vCF4or7H1NhmO?=
 =?us-ascii?Q?slbrT9see9Dw8rX+jEmYZxZIy7i/rL0JF7UEBUatFIuweXHu29lAZ+OOYViv?=
 =?us-ascii?Q?G2+F6sGQjFzsTOcwZDgglFj8s2crTmVhaDs9Xqc4MwlfPS57r3wRTZxYX6zu?=
 =?us-ascii?Q?2GYyG9VhlkzAveWAWmS5VL2OCpJdgyOwfPBzjNazc5aEW2EqoVV04zudK8Eq?=
 =?us-ascii?Q?p/+kbzqUT0DmamGStMW1uG92EyxgdbvMHJ5Ib84mYfyg3jV2OzWp5FOdBE8P?=
 =?us-ascii?Q?B3Lvt3lfvnEd9yRE+GriHs+NDM/ehBqTsxn7z77VgiHkyhdi3lWLD5QcLcB0?=
 =?us-ascii?Q?2Iup16yrOmpH06tq+rlLznP+lfmQfTKtEaotleXhg8Yaij5oOXe18gQGUCWW?=
 =?us-ascii?Q?TzpIuM6sNt/gcjF4C1o2LwL1kN+mJW0Rg3AJxZd7AtpyfyRmgqwoRBT/EL02?=
 =?us-ascii?Q?fioSOSKGv7pbhbNuY98UmRpGNbHIq0wecwZr17jN72LWPjWe/iTgFTV0C+8H?=
 =?us-ascii?Q?BitmtWgMyQCskIXzpxLFOM5Fp1bAznA1hBBfGtuWmhJRWe1QJqoUmvk487lJ?=
 =?us-ascii?Q?DZEZQmnpo3gumgGr6J4N/dgcWzrHdb/7YNWVTtRc1/LxcFUSiC8Gxv318NEI?=
 =?us-ascii?Q?RGoAQzCiiEGsJWMTmJR9D4eL/srrGY/RnjLPOMM2hWtv3tP4kIXeEcy4jJA3?=
 =?us-ascii?Q?Ogi5lnHBbljTWz2u1g12CMMn421s2J23Nv+7YS7E6Aayl4SzZC53n97ItYXZ?=
 =?us-ascii?Q?Wo5S5aU57MevM/tNLt0RR+6E0RG3kokzVa6pVifqKyxXyZ/o9MV70/OeCmnG?=
 =?us-ascii?Q?lex1Qs627sRv7+vyntGnVkN8W8BDQ7AjBBU2/r7XNale/K04plYuahsb44ey?=
 =?us-ascii?Q?D4HneATsO88v30UP1VQdY2OfCpv/kEPfkZuz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bntVSx73hmdP0xO+Woq0Dc5qtrKyn2lhkHd8Ftewp/94igE7bAksw71NLEuc?=
 =?us-ascii?Q?CxDFsLGIGTGxMGfOIBT6h45Cmc+SXIrZXX9oRlzH0XMurJ0qSkD53H5m2vf8?=
 =?us-ascii?Q?edXRf9ax3Wi2ZLrgEQyKCYKDF6nhw7KC8cqfMD9omhRoHizvvgssebYPqR7/?=
 =?us-ascii?Q?EtK+SQsFzwFrNCYUoH1770CTHcHWE1PH6229SQCzCRCfY3z6HYxyigNDYPep?=
 =?us-ascii?Q?LakSE8e4+GGYlqqlRt4TkDOFAcpIfpC05zLAI30nxz9LLMGUVuLTSeIRcCdO?=
 =?us-ascii?Q?Ci9l801oGDs1KxtK1B+FZX9D5NLglT0YW6L67k/Zp7DfUR/0z6ardkC91m8+?=
 =?us-ascii?Q?E8qGsbXg68tZsbM90h6hX8S5RXhJY1G6hBUcp7J/arToWcBTVAiGDlEJc5lG?=
 =?us-ascii?Q?nmek1HrWkkVqT0lUSXybLShGy6utbIJrH//9a78Viw7aY21EBK96hGWuqq53?=
 =?us-ascii?Q?LfWLlmqXQGfXev/mA+6cRluKBY56F3+C1tmbctqZ0+/JX2FUeRGYBRdZo1cB?=
 =?us-ascii?Q?LjBcJXKlfgQ1Y14srpfpTn5iDS5PgVX+1Rx9HQ0tSAe6blwpPY9LJI+h3VEz?=
 =?us-ascii?Q?drVIEwjvDhNd7i9IJw2BORDho4vPPtosGCJ8bC0ZarMahThooGQin38SIjtq?=
 =?us-ascii?Q?uh3N83BxHz4ioNmKZG9ZRSKJfDcyBrhCZ2eEiPwDd7/Qgy71ETR2w4jmBgPv?=
 =?us-ascii?Q?4yxV4rEss1vI+u5/9YDC/KdwBaG5lEsBV1v3a3uULsLgtt71FxvQwsdSjqT6?=
 =?us-ascii?Q?GMRx5O6GqcMGf/h3jnM8hFMHQX1OkBeJ9naRUhTGBk27jLa5ApuEhozF9Ztb?=
 =?us-ascii?Q?NrFrN1MT1Lo+N4BbqTLxIeBUSEWpK6hN7ax0ASuwYT/h7CePjh2SH4uiE7Pl?=
 =?us-ascii?Q?FRErUwi7RcR7v8AFUVVCiFuF5HXVKimuLlXJYBt2rRkjHsdIHW3Q9lHoEJHk?=
 =?us-ascii?Q?W8SLgHW268Osk08YZXY7CWJsOZlXDxHXEP5/Nk8O+6hiUKVx4lfYNxbFzIMg?=
 =?us-ascii?Q?GHdLGKEpBR5CSxLOK9jI8QZl6gf43an0GmqQTm9GKu0qUF6hNTRWNV2+UVJg?=
 =?us-ascii?Q?HMkp7A97FKeZZRs4Qg8Sh5dKt1EjJe8vPcZ1tJUOSV8TLijOBFhvoGx/+wxz?=
 =?us-ascii?Q?xf6IArn9hPCp6js+puPmsZpQsiYjc+xYCsUlOB07yMlSghPHr5powxlFzBkW?=
 =?us-ascii?Q?l5xWSYXMUHvIXU/ALH60zN++d/FAdJvHhNJUNuto4CGtVSXpbfsJspLtx1BN?=
 =?us-ascii?Q?GpjReDlgMP42bHm6m1YNOUgcEHezTXuwFPK7NLlKcPe4CuH/X/HA7SioXmyg?=
 =?us-ascii?Q?D9tuNdEFrlZSFsWDpu2HaU4X4bxVZqJq3P9ZqxhfugkGF17LoEm9WFuosX2h?=
 =?us-ascii?Q?lii7RkqW4BFT/w617eupCvqNAKNGd4SjrMLgzVCGo3eB6kBcVOAWBqsKlBma?=
 =?us-ascii?Q?NIrmIo/bDgIu7x0+jtIWSyH2jfu/bHaTAjNuwYWqBncYhm6l2JWOPJTWTb+/?=
 =?us-ascii?Q?Idfp6cYe4717H+miIb65FGc8Xs+VOWLCLXJe5fADhbsV72d9d4aIqotNAfui?=
 =?us-ascii?Q?Fqg3deRwQU9kSbQeUPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae0f564-10d8-481e-8ea2-08de0a4d83ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 11:41:57.4526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +p03w+ZuR654DQ9JCbheXGGGGxO6QL3PgwX+Hfe3Tol8LCOqm9UHNbBu2lgpAREy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ilya
>Zlobintsev
>Sent: Saturday, October 11, 2025 7:17 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
>Subject: [PATCH 0/2] drm/amd/pm: Avoid writing nulls into
>`pp_od_clk_voltage`
>
>Previously, reading from the `pp_od_clk_voltage` sysfs file would include =
lots of
>null bytes between the sections, e.g.:
>
>$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
>OD_SCLK:
>0: 500Mhz
>1: 2514Mhz
>OD_MCLK:
>0: 97Mhz
>1: 1000MHz
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@OD_VDDGFX_OFFSET:
>0mV
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
>^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^
>@^@^@^@^@^@^@^@^@^@^@^@^@^@OD_RANGE:
>SCLK:     500Mhz       3000Mhz
>MCLK:     674Mhz       1075Mhz
>
>The reason for this is that calling `smu_cmn_get_sysfs_buf` aligns the off=
set
>used for `sysfs_emit_at` to the current page boundary, and then gets retur=
ned
>from the various `print_clk_levels` implementations to be directly added t=
o the
>buffer position. Instead, only the relative offset showing how much was wr=
itten
>to the buffer should be returned, regardless of how it was changed for
>alignment purposes.
>
>Now, the file is clean without any garbage data:
>
>$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
>OD_SCLK:
>0: 500Mhz
>1: 2519Mhz
>OD_MCLK:
>0: 97Mhz
>1: 1000MHz
>OD_VDDGFX_OFFSET:
>0mV
>OD_RANGE:
>SCLK:     500Mhz       3000Mhz
>MCLK:     674Mhz       1075Mhz
>
>I have changed this for SMU11, SMU13 and SMU14 as there have been user
>reports of this issue on all three, and the code is the same between them.
>However, I only have access to a 6900XT (SMU11), so the newer ones are
>untested. I've split the change into separate patches for
>SMU11 (tested) and SMU13/14 (untested), in case you believe that this
>change is risky and could break something.
>
>Sidenote: This is also my first time submitting patches to a mailing list,=
 so please
>tell me if there are any issues with the patch or email formatting.
>
>Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
>
>Ilya Zlobintsev (2):
>  drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage` (SMU11)
>  drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage` (SMU13/SMU14)
>
> drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 5 +++--
> drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 5 +++--
> 8 files changed, 24 insertions(+), 16 deletions(-)
[lijo]

Unfortunately, there are a few more. A grep of smu_cmn_get_sysfs_buf will s=
how the files. Would you mind fixing them as well?

Thanks,
Lijo

>
>--
>2.51.0

