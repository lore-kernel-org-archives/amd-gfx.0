Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291FCD41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 03:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F72910E0EE;
	Mon, 15 Dec 2025 03:44:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Tp76/RC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BFD10E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s55KQxL+J/Kcdyw/Xix8oDu0U9LetlGhWzrZDREl0Tz0UsiPoDKOLhRWj8tseqEbnwtUAkYgSUd9C67/9GrfAfLmmjqjefJIaLL45CkLeasK+ubdG1exJPwQX5vkVGWjndhWGFsoY6BiY4OnZZJAQGrtob+BdtQLa/jfpl10KbtuAcebCufyW6zxyOml55x9C8RzAN3RdixFCtvig+LR0o2/szMKicxcyAthEQ8d9yr0NfDU5Cv3YwRzRjgvozEAAcw5FwEtPDb2fxkIKGSGR3vWkTAtyOL/0/kDaz5Hl9/tDwkIsIWNETlegVbIjtAMBzXA0P7ekG1NA7igbOc0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siJEmrJXfkLPp1rEWNRf0A6IOVj4pPpNN9iMyVv8ox4=;
 b=VQwWLZLqdkgwIYq3IKviTPk5hfR5Y6vFw+gCs6PsVTJIehSzDMI5pG2LS3x1w88s4d6yFiD+JzVgwXRhXRjqHVqaMUmWcgegXUyFL5otBJuSjk4rVN2CwQk1MF5kHHEeeeEV+DBx3ZrkyTqwhvDSV59jujQ+4IQVJEOxYqxIlrLAojBLSg73wtp8gcJd5hjBuAyCu8H8lO3TNMPrQTpBlacsKxS6GG2Mz8dz5+Xvijc8X0M2j+LQqYTQR2T0dRUeEjGsDuJkP1VqB+opf6p0fal5FQ3TnMQKjQQpQCuAO9B6VwXhleU8emdOYQKFdRIh/tULWegr7hfEboXjIQ3WdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siJEmrJXfkLPp1rEWNRf0A6IOVj4pPpNN9iMyVv8ox4=;
 b=5Tp76/RCoWvID0Oc7vVy38Fnnx1uZL5rorUscMZjY6sIVxwrJwQgGeo1bXSXM0C1R3nXbW93Y4JmP9HJIiHSIIQ3FyI5dSAc+HHLTtmeJtTrhUWVaq+pxsWhDpQZ2X465wLpjHMuKH6ZDOcFn0Fa4HYoS7xkv3IrIS9Zf7T6dRY=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CH3PR12MB8996.namprd12.prod.outlook.com (2603:10b6:610:170::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 03:44:23 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 03:44:22 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove frame cntl for gfx v12
Thread-Topic: [PATCH] drm/amdgpu: remove frame cntl for gfx v12
Thread-Index: AQHcbXQGdIJOg+7fCke7UXj3vXydrbUiDhVA
Date: Mon, 15 Dec 2025 03:44:22 +0000
Message-ID: <DM4PR12MB5181DEE123782697DB04D57CEFADA@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20251215033640.729151-1-likun.gao@amd.com>
In-Reply-To: <20251215033640.729151-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-15T03:40:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CH3PR12MB8996:EE_
x-ms-office365-filtering-correlation-id: 5f6ba814-77fb-455d-e2f3-08de3b8c3c77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?4LzqwPmyhALcCKusCopFVpfHJ94JTuLWY8ha2TX82J1bd+fNUy2RSZqqL/E9?=
 =?us-ascii?Q?UmF3bYOye0GICGfJ/jEUz6uaaNgR1zwOJ5XDL/ZJhq8YUfdK2FDhpZRngZF1?=
 =?us-ascii?Q?+qgBE69ipfW6TErK7/J8eZ/NWzZEJB3KUTpUPSH8rHqc2DazcpTVyrBxpt5Y?=
 =?us-ascii?Q?yl8liHw23uf5H1T47QzqcZL00Hyfq7cjaWlm2AR7eAWkB6LutUud72RYuSp9?=
 =?us-ascii?Q?nUgLnqACq/WCilsM9zzHEcA6RFojO4V9QbJ28DtLqG2vwtlz92ffR77WmNZc?=
 =?us-ascii?Q?dD4uUmG0HiRaRJ0xuakHYOkhTQcBJAKWfjUvNZzJLgo9Ymw4gZPmnj1ov0kp?=
 =?us-ascii?Q?EN0x5FFEhe6FvRgfZFwhTCv33P34wFH5dBtn79gKDmUYJQYTCQmG/pBnjmfm?=
 =?us-ascii?Q?7mwRbJEuZyK10SrRGnJSNcIuKH+mYOhOGQToVPRMjBEUJftbs7acpu9/fVUS?=
 =?us-ascii?Q?h3PfL7gl+tIOssJ0v0yc677V8wSBIbVh5Whhw24IMb89hAn6TeA1w/rHR/zy?=
 =?us-ascii?Q?+rVXIP1+jmwZSaR+Ke8GIHRACMjQ70pM/EiyR52ulo/IoHBhQCGyejyWjYJO?=
 =?us-ascii?Q?uApukmR0Sr5+0+jwCTYj03DrR7GhAXZyb8L1qSQxjgLruJGLUavdZcgo3m1A?=
 =?us-ascii?Q?Wk6llCy+l+Gc1TT/DV6CChkUXabr0DS/LzmfiDYcT5H6WCnZzgHEQOURb2aC?=
 =?us-ascii?Q?P5ogyKUF0HN9dBXySZ0ccYjkyF8F6KUJWZgUY39dU+MT5WJI5IjKlN57bawV?=
 =?us-ascii?Q?OavrjR5QTtxL3Vsi8jPpOgrQy95lulcma+0/ZVKCRhlNKeFjpKGLpeNk49Bl?=
 =?us-ascii?Q?scoVcDAOleTo+YzAcRebTjn7PsL6oqOeHls97c48HijBa6baMcuYV7egiIbx?=
 =?us-ascii?Q?Ld46+esswgU0GUa9+/+mB27UVVgdvScVrh8I53aovCOZCRcQYhCIXlthmhqn?=
 =?us-ascii?Q?rO0i906Xmw1AOIOHeKxnxdxv6n9JE6tIoQDP4GWa2/mpDetPrL1t68L0TwYX?=
 =?us-ascii?Q?JclGv0qOg02JYr0OIDyARhsxay+koUJTQtjSJu+wTscAQEuPPM9pmNJCZIgF?=
 =?us-ascii?Q?Sm9uQ3VWQVO0IBojFH9e/04eNlAlf28DJXknRvoqMnwAfX06Zb3fkg6elE7V?=
 =?us-ascii?Q?MFXjFji/Bio1K7WfOsIt1+P0u77uAilQzGFxtg1tm4RfT41+ne6HoQaZX7Bj?=
 =?us-ascii?Q?w8qBSWn3SGrvADK5H/Wqa2FtCPtwnfTCOdxWeS3n1jYlGGJhjegTufLMlmCj?=
 =?us-ascii?Q?rrbO96NOKyC06r5yANjOPCVcm7gxYA3Xdp7RSK2d7YeqsKxT7VkcGxYUe0Qj?=
 =?us-ascii?Q?8nk/noeQmOlZU53E7LhFeTFSadyJSK7i1vvvuL9yxoCuP0V8CsbJ4DnkGj7w?=
 =?us-ascii?Q?BvFQB/q50HUXSXdADck9CzeGjstrTZiqzKCcbTW8LLaSkSnoYixIXq9jQCHt?=
 =?us-ascii?Q?X2X0wHXhdHmQhKRaWysrIljdHur8nBiCdIpCSWGhR5BccZhET4ozXo58lK8N?=
 =?us-ascii?Q?RmsnIx0ggEtbOGVluVxPac3QIEqm0ps/mogu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OL753Mj86lWteDTOr0prdk6u0LaJ2sJcJTsuRX9PhBDjAtuh2aWAJcdS7ZFi?=
 =?us-ascii?Q?exatwDnz9/UlOt+WfP4vxlqG3FJZNVlGiyu3e36I7ElaCjIoGvsM+IzLejzu?=
 =?us-ascii?Q?3KbgMfbNvGCvf32xP3/od6c8fAZwvPcHTkCVooZrjwZB1Uzzr/GN3rAThC6a?=
 =?us-ascii?Q?Wz+nSo27UWATa3vuXrGgieyzhCVOXG9icXshW4dLDttnW0PxxFp7VK0k7OV2?=
 =?us-ascii?Q?hfOMPw1aGVJBFqL9LsY4aKw1o1SnWEM2cejkSueSuJcF0XMyE/GDUXczHeAf?=
 =?us-ascii?Q?ziKF2rQcNmux+U3BP1N8LvHG1XXTZnJoRrTIE6Fk84DvHBeH20elKi6F8sn7?=
 =?us-ascii?Q?T/Y1MRcdOMcl/odkwZGjKDysNN7dBn7NS5WFoH7fDGhtCyfUyCi+AbiUDj3T?=
 =?us-ascii?Q?t6leKAxm9lbMxR2F2EgxTzjKFvSlDWgG9440NzJjykWyeGWi45oXTV2fbYlQ?=
 =?us-ascii?Q?4j0goIAZlXWDStgHoLCTOrFdrYLi+W+vIGBykuLpwHqiwca/sShqKwLbMwmF?=
 =?us-ascii?Q?icG6okBQqQXenK5NzePGN3ksIIuv/w2lvZZeFUJODpD15COhOEn2ZYkynEru?=
 =?us-ascii?Q?lk2qBpv4/vQBnvN3OpLs5tbMx/rokgeAzKpOjLd4qPHJfXHjGj8tKvfslgKe?=
 =?us-ascii?Q?aHvb05XiP4x2psxJiirme2trgoHFwa1fZTHHa5PF4+/bUsjs/NAYpo0UyX8d?=
 =?us-ascii?Q?Gnr0OWd2m03h4E0O53Z35E0YUC1OUlbTwOtUP1GUC7siOyMpWhPk9vPS3owP?=
 =?us-ascii?Q?gDuRI3u4ZOna/tOjNTd55lcqAd07gYWLyuupse6F81c0LACZMgPS0lNlipMp?=
 =?us-ascii?Q?DbzVvb2b8jgR4QJrAzSWB/pbVyZTXE2dPX+W03I0+ybjci8qxPp5md9CJLdV?=
 =?us-ascii?Q?T0dLSNVl0tJM2jD3p9U71c2Aic7kqUZd309Kg03rRv09hlrqSt7FFc/KkHgR?=
 =?us-ascii?Q?CRX7YMpuX8fnMNaMYRcWViRnI9zRc+QE7TsDRod3RkU2Z5WqUKURvHRF7QG7?=
 =?us-ascii?Q?Ua9C+XHVoOkLEyhFV8Sdh9SwKiU3BjkYP+LJZqs9L7kY9Wps5y+6F6MJA+/E?=
 =?us-ascii?Q?Ff2qRb1iZumtkFVh65UVyH0Y76DOzfnoQaWk0ufVMMbI9kkebPBOzO2Ki0Nx?=
 =?us-ascii?Q?X0NAzxnwchXBVFu0kFT2wz7/3TrzNjcRV1YZecgllMqFtwCkAGZBMLHTVWm6?=
 =?us-ascii?Q?9Y7o9ttaeySLGec+plaF1P9CW/Slhc7kCAPr8h6nwA5p5W4BER9M2IqIA3Tr?=
 =?us-ascii?Q?+YinS64lOrKwTXZhbkar/E/xZ3JrsaYjV9YgFA3VROoWriqJMj+YW/sSu5Ne?=
 =?us-ascii?Q?e11uCpQpAH5pUvD5h4YuRhxFimLxPRtcS0ILE+KQOdCRHVMKEk/6SkeRTTbu?=
 =?us-ascii?Q?v26MLXrCk7j0yWdoQSk8g2YIvI5z8T3cm7OdIhNia+6sffQoVT+Y8qdUYtma?=
 =?us-ascii?Q?Px2iRXzKAE4itlLllZTS0Unr9nxUmdfYN1DxUurvkTwWzZRmHtlB9QFSjo2M?=
 =?us-ascii?Q?H6u1HiLF/9DlEIRT5QsBH/0k9NqhEW52OqIesh1mxYKeBUdWrLuZ78JojqL7?=
 =?us-ascii?Q?v/2nclxiXFu5gQ5bjHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6ba814-77fb-455d-e2f3-08de3b8c3c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 03:44:22.8888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaapTGeti/gIm4Lo0aiOSWgbbfQQgnjw1wkh65J3XSPJabO8SF8U8GgR3P1eXGCG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8996
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

[AMD Official Use Only - AMD Internal Distribution Only]

From: Likun Gao <Likun.Gao@amd.com>

Remove emit_frame_cntl function for gfx v12, which is not support.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index b4dd954363ee..12a429fb1409 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -278,7 +278,6 @@ static void gfx_v12_0_select_se_sh(struct amdgpu_device=
 *adev, u32 se_num,
                                   u32 sh_num, u32 instance, int xcc_id);  =
static u32 gfx_v12_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *ade=
v);

-static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool =
start, bool secure);  static void gfx_v12_0_ring_emit_wreg(struct amdgpu_ri=
ng *ring, uint32_t reg,
                                     uint32_t val);
 static int gfx_v12_0_wait_for_rlc_autoload_complete(struct amdgpu_device *=
adev); @@ -4629,16 +4628,6 @@ static int gfx_v12_0_ring_preempt_ib(struct a=
mdgpu_ring *ring)
        return r;
 }

-static void gfx_v12_0_ring_emit_frame_cntl(struct amdgpu_ring *ring,
-                                          bool start,
-                                          bool secure)
-{
-       uint32_t v =3D secure ? FRAME_TMZ : 0;
-
-       amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
-       amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
-}
-
 static void gfx_v12_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t re=
g,
                                     uint32_t reg_val_offs)
 {
@@ -5515,7 +5504,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_=
funcs_gfx =3D {
        .emit_cntxcntl =3D gfx_v12_0_ring_emit_cntxcntl,
        .init_cond_exec =3D gfx_v12_0_ring_emit_init_cond_exec,
        .preempt_ib =3D gfx_v12_0_ring_preempt_ib,
-       .emit_frame_cntl =3D gfx_v12_0_ring_emit_frame_cntl,
        .emit_wreg =3D gfx_v12_0_ring_emit_wreg,
        .emit_reg_wait =3D gfx_v12_0_ring_emit_reg_wait,
        .emit_reg_write_reg_wait =3D gfx_v12_0_ring_emit_reg_write_reg_wait=
,
--
2.34.1

