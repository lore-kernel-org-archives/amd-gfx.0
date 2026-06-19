Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC365CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 16:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D84E10E0AA;
	Fri, 19 Jun 2026 16:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="afZGAAhH";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9184810E0AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 16:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H85efjtvBAf9jnGTvsVdQvgxnvQq9TGLU/JEok6xrav5ZDZMeUQstNkJbyl4daw6NkXRR0Fa93KtFj7g/u01XbAS0o5hmx2J0zpd+1CDqaK/tVjlYfHX6xdgkH5YjUThDlzC7bud7n6jKni9bSZIJw05klJsjv7G4ecRnypVikQywHpSkVlBMjbA9A5OWw7Sv2tynpS9oriBCdBxEJMgZAI78UxImv5rtM9GLpfdmk20iU45VEXYAl0o0pHcgqMGU31RRNwJab86Ori2+ID3jFYmXB2Fh9iBKNuqKWGAtv0yZBQ8NWw3GVD45YONL3egxW3n5uv0MCgDegeZ+nsnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OoKi09CfBHplD3lHJvWf5NiaJNv3xUrLMWrMbmTkXQ=;
 b=QfKZaimgLvLRFCc66Hb+FFKWcnZ/Bs8Za3jBkGH1dup1UNq1ZPLQweGHI8pg6Py1lFbYFO7equOBMNR+sXMPBp1psKku24yZZyIdZvoEp+y+FWhXmVPd0qxOaNf6TeJ7unWHUNecmKnLR1xPsAk4m+XHZlCT/5FKKG1A753qPTS8w+yZpJ4GJSoDl6iF/uDHDExJw+0ArbZaNA47P1gnotuawMwbSaoCzEjIHRp+8z0BP6v5+YjBBEFhCI9fZCYXHSydFHYFJZcrKBBuOshRa2XUfLnFBtr2Nn6ALkW+ylOZTEUhmKvFCgKjy3HlI+YP0xloe5YGFtO2dkl2A/GZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OoKi09CfBHplD3lHJvWf5NiaJNv3xUrLMWrMbmTkXQ=;
 b=afZGAAhHrpVsqG2EzzeDmYtlOwNhDgkDviAnivuVjCEBiESva9a9noPqAe3LEUSSn9prkQZ1RHQLHdqMUTPIo2gYF0KKHiB4V4ENUmntuV13jzFJh4sk4x2XPQJFpRwJUhTkbuh+yJ97oL5B/7LKBds2uakyHVHmP5pxYyADJak=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 16:17:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 16:17:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Charles Munger <charleslmunger@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
Thread-Topic: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
Thread-Index: AQHc/7td0wfeVhEMi0ekVJ5NSEbL4rZGDpmA
Date: Fri, 19 Jun 2026 16:17:27 +0000
Message-ID: <BL1PR12MB514432F894701A3CBAD341E9F7E22@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260619045904.5872-1-charleslmunger@gmail.com>
In-Reply-To: <20260619045904.5872-1-charleslmunger@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-19T16:17:14.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CYXPR12MB9278:EE_
x-ms-office365-filtering-correlation-id: c323c862-76d5-410e-18b0-08dece1e414f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: NzL3vhfDYti/xyGGENmZqBHTtHsbfMuSSqMB0JTwSu6Pp3q2gGCMrQuBsgR5Y20K4G9z5IdyHKzyK9w2e6GofS+A4HQ+N3lgdkyoflnBoH1huOzBgeSnyhfSYecp7R77sPTUWNCR6+VPv/8Q8WKL7xBBqJbkXPScrCzSZwKQY1V3YkpJZLLbkqWTmRKtvrTmCh/k6ucavoYgbEHaOMEJ7f5X7fx7cCouPEHdg02OhVU8/d1DYPZFvcA5WmUYOf4yxKrySYrHdBcyIA+GyWpQ5xWX/+6pIylZN3xrbmuI6Wi0qlCZ2LxSbfSpVnqZziw17QbqWbyS8qsYT5U5yeb1+gsXApNGgTBj/89VVFeXehDHbUPHTEvURtdjp7d2AUXrTF2fonYQMpQoq8RAAn+LC95fe52u+E40VU5mpt5fROVyL6uAyesEen5x4YmeUNtX1dfRE+0tJNnRwCX23IC/ymq8pPhPx1hLAxsYqJSW6TgG4V5FeROG2rTsY0VgWCebodNEohruQ2U+tvzewrruyJLIdkzWr+B1o2gGj0dbtF4wY23085+xahxlf/1PBl7lKTfzvNr6cezo+aa+5NySzVZ2gcWle6nAlr/FBCwBX9D2TBcPASNQ+LcQyb/v9vjCrsOpu9p3Nc4CzptzaPqo8Td/j/5N3UOZyz6ufllIpaBvaMLi4LV9rrrVaxmjDWup9CWi743/tmx7azox+vKfRlblz84syHvtyMiUrR3AGnQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/92huY+8CNIG1xUp4XYYPe0JGHhy1+uz9CsaAoiWUCqiFslufJsOHSa26MYd?=
 =?us-ascii?Q?WU709BwP13skCicHEEtXnUl7Q/kQcu10HVrXmOp7R1GtHYmp3GAjFUZ5jHzv?=
 =?us-ascii?Q?f4zQGbSIlym4ywjf4Qu8xqgNzbZM2l/HzGf9DrSkX7ZMqGrKndPdoqvt8Ier?=
 =?us-ascii?Q?U3RFHNc+6mwS8X5J9S4D/TQchzuf7NYmOPylqqIu2Cr5ylxQPVSd95J1qdpC?=
 =?us-ascii?Q?q62bL6wJVklZlEOhIrSdXF5Ms97b4iauP8Oio+uEHFvDhiWF8OEVoxFMwhlm?=
 =?us-ascii?Q?wM1jQPvLUxdxyDO8JBNbR4xr5vw7/dMznTlJhcF3qLLRRpS7WqurqAlg4JGq?=
 =?us-ascii?Q?sjiuHwnFtVnIMH++Qx1iikoesGEm/UGab98jCGJXUVLnHnJ8jZAXsXzN3jxv?=
 =?us-ascii?Q?sFfLzHcHhUj0v2yz0RdHBUgC2Jd+/UJYDdS+FKUUam4hSYakpdpAcUH1dxHs?=
 =?us-ascii?Q?sYGO70wd/yS+DwITcd1vMB+ZnAZ0jQvBgtez4EwP6hPwaYlhb9xW4juFmtLY?=
 =?us-ascii?Q?4zqGVChv1IgO6ezD2QWBAp0hnUPWkKi4GEPpDWGzSaDZgLCJ700VFKoxu5yZ?=
 =?us-ascii?Q?wp9ugDXMKnVcfJEwTOweNeryx5iAlD5I2GWFDhT33Bl6o4lZIPCYln5JuNQB?=
 =?us-ascii?Q?KIPR+9yrsHcWhISMvcapa90sQf1YnN9mD+WUCwTBzUxJW3hk710tFcPp+h8o?=
 =?us-ascii?Q?6500WiyI/wLFqCH2VeZFQiknDx4j7/7/z6eCo3NgY2yhQeVs5wc8NjhzA0tu?=
 =?us-ascii?Q?E/LWkBqv7U9QoTmGQXJIuFCHr3Kany5aRvcecKvZXsQEy7YoXRgMzcF/PGWm?=
 =?us-ascii?Q?3xzcHmrIbZjOkdJzXhTt9CSBrY+xFyrEfYtYCy1dMs+EZGGd+8y24ZSKyCh0?=
 =?us-ascii?Q?0ivJQ0HlgGwQcfKuODqLeykJSp3s0IPb3wHbJ+aPSxddtkjZfF74soNacu8W?=
 =?us-ascii?Q?wM44QlNxd8Q0Hu7efB510Lc0yzxMrJZjRxwkOr1L1QTl1rwNGsxFF5ZRXsoP?=
 =?us-ascii?Q?2HWePft9tp/sSHd0Gy5Z24tO/njOf4rw6yzJw/or7ei6gY5cu9sNntrRzgsN?=
 =?us-ascii?Q?xCFvmD/fggFWj8CBASt8PuX0jB6+H+xqzmP8viX72QnAvqU/iwcgDAGtmjd/?=
 =?us-ascii?Q?g9jQRMB3PeJFHowKX3Tl2/UnvPD6Bu57z1a0PE/eGKhqjhHvOsMT/SEV9KLr?=
 =?us-ascii?Q?dFu1NZaXlUwNaOIyTUo5hs1GQx/dte1ynwWUI24vRC7vGc4xadDhBvufD6mb?=
 =?us-ascii?Q?2Zay1qNpWQ36M7AYvb5N1/eVDGd35MSsdyup1Gu2TGoR0hYI5FfnVjm9FuyW?=
 =?us-ascii?Q?t5Rw/v9EeYU3gmcq6QzAp2D5HW7AoWEUyxjTIf3J3H0AKosVKTaLMXqVD43Y?=
 =?us-ascii?Q?1pDMRFhNGLoIpQSJoTVclauz/HVyCv9PJsZpYdOUVpqb0IMk/l3F4mIDaSZh?=
 =?us-ascii?Q?KqspCRgn4o7DXsMcvuYg4jh6U1GkOb+ZMDMo+B/LGbocuVkMpZA4pF84crYa?=
 =?us-ascii?Q?J8rCV7XLpPHtdTCs9lAPv+630fbwu0GQGr66odUjYxGPwrBh/M6B7rePPZ7y?=
 =?us-ascii?Q?t6Re8Rrvoxso/NtYg5+0e/74SpdTy/343JVz5rwWEErNKtgZaweMzNJAzO0M?=
 =?us-ascii?Q?TmZ7UuVcELveRd/IEnxuQQ264mLAyOWgZGnpP3G9Itv8nTsu2vgPzhrQvi+Q?=
 =?us-ascii?Q?08BhDMNLJZLgvN8bGoOozh3I7YKA4UyYaquM0Llucip1Dexg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323c862-76d5-410e-18b0-08dece1e414f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 16:17:27.3182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/0iXz6jIr/H2m+k9U50BBb40CzJtYKP05lCl8OjOhMEShbtS/WEDh+fMKXp0aN9F4oLAnhoyJ7z9e2P9aGunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

Public

Adding a few display folks to review.

Thanks,

Alex

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Charles Munger
> Sent: Friday, June 19, 2026 12:59 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Charles Munger <charleslmunger@gmail.com>
> Subject: [PATCH] drm/amdgpu: Add Paradetech OUI to VRR compat list
>
> There's at least two firmware versions on the CalDigit DP20-HDMI21 adapte=
r,
> which is powered by the ParadeTech PS196G chip. The first version has a b=
ug
> where it incorrectly neglects to set the DOWN_STREAM_PORT_PRESENT field
> in the DPCD:
>
> $ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D0
> 0x2205:  00
> $ sudo dpcd_reg read --offset=3D0x0005 --count=3D1 --device=3D0
> 0x0005:  00
>
> The newer one fixes this, and with this patch correctly negotiates VRR.
>
> [~]$ sudo dpcd_reg read --offset=3D0x5 --count=3D1 --device=3D2
> 0x0005:  1d
> [~]$ sudo dpcd_reg read --offset=3D0x2205 --count=3D1 --device=3D2
> 0x2205:  1d
>
> So if you're using a Paradetech adapter and it doesn't negotiate VRR, che=
ck
> that it has a firmware that produces the correct DPCD.
>
> Signed-off-by: Charles Munger <charleslmunger@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 6c827e6703a0..f463495d1c87 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1410,6 +1410,7 @@ bool dm_helpers_is_vrr_pcon_allowed(const
> struct dc_link *link, const struct drm
>       case DP_BRANCH_DEVICE_ID_00E04C:
>       case DP_BRANCH_DEVICE_ID_90CC24:
>       case DP_BRANCH_DEVICE_ID_2B02F0:
> +     case DP_BRANCH_DEVICE_ID_001CF8:
>               return true;
>       }
>
> --
> 2.54.0

