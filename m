Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0D2C02198
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4591E10E888;
	Thu,  6 Feb 2025 15:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WKN0gAau";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A2610E888
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQ+CG/Wx0WGPDHQvwhGqaYxA0VnDCgsdmdCkFH4CACIEXOEG+XwR2efKnTV9SqzwciB00PMMjh/R+aXuWTEv3x9IGO6CrxxrarmAOeypVQ9ZOSErzHvkTNIkvrydCSL21qDDnBNZQV8G8WcVLfw9PJU/ES3KD07Hr0TGCfXlBLwlml5AvSxOLFgkzjKMTwNoiAdnJQ5kr676V0TMeoxH1m0DIz6dSPS2+ErPdEv0cCGaioo/m4ZdfNbj5hA3GB9PJ019wuKV/eS/sHK5pZPmXJS/vQwaZeh2uxPifAPX/CyUYAxUsRVwfrxUx/H0ysagNbum25nLR9umSVjEwp81wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpAyJ0P+rVLz4BjCNEa2r/JXKwVS+kKfMzVa+ZVzr4Y=;
 b=ohEQsYQA0BBqgpJP6+b+K+LvAvpmdWljsSBYd9rpeDqGSqF3KsM4ZZwBuKWbIX5bTXW7PWLKxF82rHYSD2/56VvDnHp1M4AhGufcfCtuuN4MrAoyXThE9VsAY51XCqQkr3o90bcw29cYZM08gQv/KzYe0HSVcd26kG/Xr3Fqs9WqN8rx1m+6f5cZsRa13KGSUCywe/ZlVvHkJHclWOHIliXDRQRXAg5MfwTZBG9hVM9TVoB5g9hTrXjSU9Hzt1nRRXn02Fi+pqGL+ukQgHEEl1Ini1xBjpmGHcIJ7OBob8GW+NK3LiAAchMo8jvvXDBlI43eP5zrJ0hwHo+6eqND/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpAyJ0P+rVLz4BjCNEa2r/JXKwVS+kKfMzVa+ZVzr4Y=;
 b=WKN0gAauS3RGsZviPsVX4ARvEa9wQIM3PyYrm2z//HyOJ6KoS7jU74mDONaRFXmwndB0BpsQtqGLezbeTXYIdsdpJmuJ5qn7ng05QNmB954o32pvmO5lJPJRkcHMq6JahFHw6zR6AMomZF3DrqBSFJHrXja2FbJw58CmO//CKew=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 15:22:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 15:22:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amdgpu: Make VBIOS image read optional
Thread-Topic: [PATCH v2 4/4] drm/amdgpu: Make VBIOS image read optional
Thread-Index: AQHbeE7uAkOyViIP7EaZdymrp2bG7bM6ZUog
Date: Thu, 6 Feb 2025 15:22:55 +0000
Message-ID: <BN9PR12MB5257CD4DCFEC0C4695BA1F0FFCF62@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250206042259.1927200-1-lijo.lazar@amd.com>
 <20250206042259.1927200-4-lijo.lazar@amd.com>
In-Reply-To: <20250206042259.1927200-4-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d3a4ba88-d6b8-4614-b236-6353f99595fb;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-06T15:22:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5968:EE_
x-ms-office365-filtering-correlation-id: 62bdb5fe-edd0-4f6b-478e-08dd46c22186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NJ3rgGz9ku+virITG//YQETRRVGTNjDozpGKiRWzQ9h9dpLRAyYRqGRggqg9?=
 =?us-ascii?Q?7YbQPr0Kv2btLowK8LgEpWjW/ONLfaT0TeaLaazmKYoMNnh6Vh8knyjfVH/I?=
 =?us-ascii?Q?EsiBljsXWeOUMuHuQVYV7cgjW5BRdKI1vLqmJ9DRCyMBEcEuzodQhSTn3hHN?=
 =?us-ascii?Q?7vJBLtxXMTmDr7uF3WvEKHwP9k9jIHFfTc8SA0MIUFmPdGKnos+zoyY6/kIx?=
 =?us-ascii?Q?BiJZZYYXMGLgv6wTsBPWH1nSBk1AAgyWx48uRZil5G+cau2dnO+iDDOYxN/l?=
 =?us-ascii?Q?1uzR72eM9RH0TG9xVnHUFrKpJUuGapsk88kMquv6sbs0q84imrtX7oQsoYVm?=
 =?us-ascii?Q?2BQhpMxSN3qSHZCqpbBxFe8l8VcGg1khnPM7tGRQSB/h5/ZLYjGvJz5D2Cnf?=
 =?us-ascii?Q?dBqZC6hNOmcOavf72JmHmtWaOhhMe1Qwox29Z52oXTxFFjCpgK7iDL+k9Tmf?=
 =?us-ascii?Q?qyqTEXxnGzmsOHsnyc7kgyQuMmHVzU9oL76eG6PbQgLf9bomYzx5Y+TVasOe?=
 =?us-ascii?Q?k7T4KMcRQxBaUymFhaoB6G7pkZyEL7IQe2TiHdr4AsbKhcXnSpR0N+dU9lCg?=
 =?us-ascii?Q?0hZYU+zuIhl72O43kmDTFFQirchGok8fnuRdTkry78+7yGq824zz2g4PaFao?=
 =?us-ascii?Q?ytvSsYfiHhEA7k1z+Td4PSb72jyiCMP/Ya3dpkfe82cRvB7/fbFR/vWnqpXL?=
 =?us-ascii?Q?hc930HEqJECuGYPzI6vGHLwANVlEwlYGixeagU0AQt9W7NiaIb4/zbm8j7+R?=
 =?us-ascii?Q?il2Z+alJj5n8J1DlDaM/GCM/5oGNiR0Trl3pxRZfYSruMWHJAeclb34Pm64p?=
 =?us-ascii?Q?iP4OwEvmU1cQQA4fjeczfLPgvVl65QJ5ZpVIKF4iiiYXNOikmR8dkz7B2Pl9?=
 =?us-ascii?Q?fvrLvcKRJeFqDP/Nt8wXe7sTbCUV5cLUWYTSYTE8gf36zPL8lnDFHbOKFLR0?=
 =?us-ascii?Q?7pgqm11H8tQT6djtQjmJv3s+9yjHpGkEZPi+nsEdBg0qX5GndwmJJ1HM2uHq?=
 =?us-ascii?Q?tCpp6gAVL9Hy333R7KYTQ/mN38bcBWGnu35bt02rsWA2+/xxyn7d0gfZgDqL?=
 =?us-ascii?Q?UGSUtxKJyKT7ggUoIB6lPb4V/CKrldrpR5urPY9z01nuazCpVvVv9gW+0if4?=
 =?us-ascii?Q?KszVqSXNPC4fHeXxwERqS5+70czUCd7K/3jMQTjSgmhhWPpbTpYGmtjAvq33?=
 =?us-ascii?Q?bYXVYjxnJ5Hxp9ikUrh4EUl84Cznr2YrH3TQbRHMMpL4tanE/AGPpZ+eUMj8?=
 =?us-ascii?Q?vJh8HXhb2Z4Fl9Jz0AyNgXRn4tIA9b7uIbUnpurp9EFledPFju17enj3oRL8?=
 =?us-ascii?Q?HY99XF+xKsfqOkjKICq06DaX/vLVMfnjrpARNJwZQ/M2DNQbz+Wgx8sVrLGL?=
 =?us-ascii?Q?xZztFC8NAUpjgxkEm7eMccTI4ToJCw8JBYWBObbedrcdYsEp0wtN6Gocu/Nh?=
 =?us-ascii?Q?dCJ2jUPaKzm/cV4TFzHdxehOqax6SjiQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aToIvwE2x8aRQkTGjxcdI1IBvUGUmOqMYmAeGOKvOIFA8iRe7zx7xTyTc9d2?=
 =?us-ascii?Q?HYr3l534mbZN3TNUWnAjQgyMwml9Vt25GMMJJhE5MqLicB3zxLM0sd8SE2BZ?=
 =?us-ascii?Q?Peeujv1tg0gmQld9g50QVzI8lUKrqbpbvLfe13neVA/R+AFMbLHMXqT1hrLB?=
 =?us-ascii?Q?zFBqaiw+2rgL2LIcwqYPjdwHsf7NxkDeg9CoYwALmBS/Pt//Uu1lIFK5Ls6w?=
 =?us-ascii?Q?/n+3+nLr61LxoxATMSCwkkWNw8hSne6hu1qettbC6rMNHTAHJ4oCBbhF2e0Q?=
 =?us-ascii?Q?u4iuAU+DF0d5SlgbZvJgfkhLlRw+gz1icBxn7voLg/9KcwP2xpoZOSRsQ1iz?=
 =?us-ascii?Q?bqaVo//lTqC/P8vTj6zQsilNtpDEKTDh65FZDNMfBn4eVTIUGL1t54k+SpEX?=
 =?us-ascii?Q?LbRebpn/g1ApX5rlWmsc6rbX2qGIXqrc+JiayfTMCnRrHs162frv3GHBga0W?=
 =?us-ascii?Q?yUT2E0DEUVS9ohWlnAdY104xKBKXCK4UoSrlsQ56+ue2CYk8PZEglkEXp/2d?=
 =?us-ascii?Q?YC/lUHlfVRC+CSzjGxgmZgLaAUz69iEQxvcY0kZCUGlYWPCxI75qnmuQQWhU?=
 =?us-ascii?Q?Pe3FBNFr4el9fUvik1rT3xcWyi2eW7FNTM9meDlkfdV0YCTLUAZbgosn2vMZ?=
 =?us-ascii?Q?xSpMJ773OT0sZODsqJAGLbXYkm/QsUbhFfU4a4RuhaNr+9uWVCj2bMOL+N/+?=
 =?us-ascii?Q?iTD5H3A0UCZIO3MXLNJuquwISFnJJ7VgCXIBxOtHLXz4mmZgR7xLZM1rszI1?=
 =?us-ascii?Q?VM72cJeaNuiK5cM97UIjJ0hcE5EuTQu0khEUp8tAuAnIBqQRVoBEEb31HesN?=
 =?us-ascii?Q?wR9C3C/24itj1fJfd0M+gVT52Uhiosg+f9y9uPNZ2J2DKrUukIt1gwNW91Bx?=
 =?us-ascii?Q?V6yGe/s+QLbh6ElflnxnxnBHAOXfPChka4+lYf31zmF/CGNFVobuGkdpOK8J?=
 =?us-ascii?Q?X3wf7+UQ+K/fTG/yg3v5z8MW4aHvWAdQcRrpPUSjX8aeSKMIYYt6LDXOeiH/?=
 =?us-ascii?Q?uVOKiZfZgt8HuthtULmglZWzyaWViRu2NzVIpqd24a4BWrq8BXwlTpeQGl3o?=
 =?us-ascii?Q?7nSsO5DvWJyWEn2H+JhIvlORqGhk5h6L6IAqxx430UoxNQJMDPr7HJqU6f39?=
 =?us-ascii?Q?5VatAjQoHihwmk3wclpNwR4vW+Vn+aALq2rIngQxsi5VkGc27pAcsA3NKFFb?=
 =?us-ascii?Q?X9hw2uQVNOzU2acJbMdmL5Z00Fiamyek0u20BL2wE31Pr7VgMV3jTPH9bIeq?=
 =?us-ascii?Q?7jBBiciQT4UmZfzCApOI2W/qKhZYND0Re5xvfWs9Sh9VwY/ittG5QDvWyPCh?=
 =?us-ascii?Q?0yrT3V/0W+Aw0JaIdq9jv5F0pxhRLnJJBmnJJD69j0uHWZSnbMuNNk1Ei+ZZ?=
 =?us-ascii?Q?Fhypv9Z5Q1+GB7XvS4sTQw3t4xHbko/xVwn4+xVcRr3HazNIzrvgEltjS+5F?=
 =?us-ascii?Q?mxaa8Ty1GEwXS6npQiJElD1FRz0wl8lbOZSpPz69oDpLyoV8Wkw95QfIMrwY?=
 =?us-ascii?Q?wCaqObeyUI1iG6bneOqm8wGlitnllMISJcmxMTJUsmQZ2HC+CKCc5GUB04rf?=
 =?us-ascii?Q?eOgmZAm0io+2H9nEaVX8Sa96QsDODP0UI6EazasW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bdb5fe-edd0-4f6b-478e-08dd46c22186
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 15:22:55.6168 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mngz0i5o44iPWBsyWi7itEFN5j5jDM45N09Xy9/Wj3Ma5AqubeJcSOgdR83idoZgukQSomaO9Ih5t4d0ApWTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, February 6, 2025 12:23
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Make VBIOS image read optional

Keep VBIOS image read optional for select SOCs in passthrough mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 16a61fa70afb..eab530778fbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1397,6 +1397,9 @@ static uint32_t amdgpu_device_get_vbios_flags(struct =
amdgpu_device *adev)
        if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
                return AMDGPU_VBIOS_SKIP;

+       if (hweight32(adev->aid_mask) && amdgpu_passthrough(adev))
+               return AMDGPU_VBIOS_OPTIONAL;
+
        return 0;
 }

--
2.25.1

