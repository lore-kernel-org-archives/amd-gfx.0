Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0573FC61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 17:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FFA10E00C;
	Thu, 12 Jun 2025 17:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tyGmuo/m";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FF810E00C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 17:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSa2jKXcMqoHG9zve3DZq6KHXJpMUPUwL84S5P2lSPxqnNQUK9p/IFugMzWiARvn3Yc3FPpGhIMNnSZGwv8Rt72yQZVR0m1T6TkEfT78k2QoPBO/UG4oxl0QpWwYwa5jfGX1KeRnPZULHyj0Pgi8X/EFKEpoff1duc7FV7UsJzmvpqYmrD00UrPAVzdSb7YRpG3Aa0HYdWz6XbTw+bXU2PFsSQTrbAceqx5oyzvkPSXdoEMCbV3xE9luzi8AZBPM3Q9N5P4n5I2LnRUq99Sh6nMcE+dKZMvG+dqYLy6uuaz83bTBB6AOyZehOVPHmkShGDAIWVB9qIKEYngXuSDIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubgivN+/rr3Iwxdbu3oKtijqmlTxIM5fRA74YH/eeDI=;
 b=ppKQWV3lfe3bE4DRKwZwXHC7TuJTG/3PyLnbtaD8ptL7NhIVBNAEesebTPHaTw1Z1zcMINBl7OuL06FkZVBh2zA7MK0GB+X2680qd22sdRQwQQ/dmTKRqbh86RTEjQuVLPRuFX76cPxENiMDiucJegCIT62dV9Ev7awEKBIqDleRZBBVGw2yGoU2Le8vipuIq0eE109yNmHrG5aGZ0oKtG0+7PmXbNYYBptG0OxQKPKhWh+zoMQRyVzmlGi0qC3Y6I7myjYkipeN6wy7VjH8qWfKG9h2Ggr2OCqPWWE37oxHSD3WINd78MS/ozA2Ly4T7KsH0x7r2JZ6ffqAuYrE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubgivN+/rr3Iwxdbu3oKtijqmlTxIM5fRA74YH/eeDI=;
 b=tyGmuo/ms+5pHlRVw417PNAR/00WkV4WWAin+W8grfaoaTyW7eNYYdxg0NXxUroB71r9SQ2gx/HzIHgkF6LM+++2pIyUHiV12gP246TjK2mrD3RE2La0MhZNUy53yXoQlyCzqZPRbo4MckkvoBGZ/ju6X4Qlh2Ze/+5KlS3IxNY=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 17:47:35 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 17:47:35 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during
 DPG pause
Thread-Topic: [PATCH] drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during
 DPG pause
Thread-Index: AQHb26z7TuiEl2J/vEm++oLxoGtXWrP/zLLg
Date: Thu, 12 Jun 2025 17:47:35 +0000
Message-ID: <DM8PR12MB53994FCE08B2C0CBB7AC76B3E574A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250612151600.966838-1-sonny.jiang@amd.com>
In-Reply-To: <20250612151600.966838-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-12T17:47:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|BL4PR12MB9507:EE_
x-ms-office365-filtering-correlation-id: bcbc8944-838e-4f5a-9c27-08dda9d9374a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aEeq4Ia4rO7162+jOUQEMPe1vT1oILyh+DJbCZEVwPseTI+V9EkAQV38w+3R?=
 =?us-ascii?Q?92AfaidCVmnilexGGXCM07lGTZk12KAEjekQUjtBMt/397p0tIEvkQlMB3rV?=
 =?us-ascii?Q?bYraz+wlAgnzsZ3E1hd7xQyD9g0BuzpRzTblgWYRWmNMZsom7D+ynaiwZ35J?=
 =?us-ascii?Q?SSxSRcyFJIP+gRuLgWhn93zfTTqRZDOQi040CJlxO7QtQWd3bVzJOUkohof1?=
 =?us-ascii?Q?SeqNO+JMQqT6o38jlquu7ivEi5tTp6tYncI+57k2QL2UUJ8kXs0D0gO87jMl?=
 =?us-ascii?Q?z51x4xj7Qubn7Z9lNytJCacfMAcUMuSHnDQE8BDeL7/r4sFOcIQtfx35LfI9?=
 =?us-ascii?Q?9sUFMU64fJ1MwCA23yTlmiHH9+iFkuOiNd+tu0tPTTS7rIL+71+L/no37Egm?=
 =?us-ascii?Q?Xavupd53k1fDxMJPBlYtsHUMCKppFXoHGGi+m68HMLpoYvj/lHbInOnm00ME?=
 =?us-ascii?Q?DPFsLIxOBVwK8lU0keIi/LBZNkCsB5xmfa/8xYedpbape8zxeYw2Q5ms1pTJ?=
 =?us-ascii?Q?ddXIFReGyerCxsZS5p5lWjVJWeL3P72/9zHrzb7iiSl6yCZ1AYKQkTKftvoH?=
 =?us-ascii?Q?/2s/jXuwpo14h/Uc4MEi+BgewBBWi8G5Fcq6ksk5Cr8CAXCqz8/bRyys9tzX?=
 =?us-ascii?Q?vrzDyD0SXyTjeKD37NNFj3b5I+tJQQV73ATKV63FN5aIpJ4KWxHvSs1tETS4?=
 =?us-ascii?Q?oydJ+6ASIadIWYPMYMjpNwL15BFZBnXj5qepjJZTr09f1nK2II4UcBzfb3Jx?=
 =?us-ascii?Q?V2WBFNUmdLvxzN5VjyeXjQdGxsuNV5TnpkOm5bwhgMXNMDgf4Ly7+JM7R5lj?=
 =?us-ascii?Q?sRuSXTmnKfvsfEZkvbQKve4rMinendVpF7qNELh16XaI7dFJs3hcEvG370wf?=
 =?us-ascii?Q?bzp4d0Gys5s2+fRV7ZVHE2M7GJ3Of5mpEQz3hq5bA+Cs102RQQPUKd04/6vk?=
 =?us-ascii?Q?tWCyu0O7+h7DeWmpk0ABw7UHjkjrTFXb60p5T4KXSZ05ZIMRAcSDB8qXpAgH?=
 =?us-ascii?Q?LktIcXCqW3x+nQG/uJr72kWBWxeahRooPoCzZUU45OaeUUJY5Xuht4cklSIa?=
 =?us-ascii?Q?vsvGb/Qdn5gJFebfl9+C5UntAIMIdXkaUwNoKnnV140GLLqQXkiNdeuZlKp9?=
 =?us-ascii?Q?LA6i5WJlAmxq9OQXkIbNnhhNZG6mILvwpI8G0Vevb1umhx4oiIXCaRQYrscj?=
 =?us-ascii?Q?qfYK6qHgiN7+f+J0i8u9WJ/qMsAu9+Ea9ucJSB72YlYqOxkNCHUcjdsKnTTm?=
 =?us-ascii?Q?jF9x+ShzCYZ8zp0sXeTLzfDscrXi5MFEfQ6vvIA/Nk28vGIBHsDQrJWs1Xeb?=
 =?us-ascii?Q?Ex/TdqSiMpOBxM9DecqJ9DvHC2mCJPL+uRgPU8oi5DFa6Xkl5VIYQPJV/LzE?=
 =?us-ascii?Q?4lAFO9P3alR/4AKH0M8cxuRdLo4RMYbMNTPl4x8KSnJo/Z9V2uICeS7qFExD?=
 =?us-ascii?Q?TbIwlEaMfpF/fgWI9XjtcN2YCzjY7FXDeqVygydWrBSKU5uFP9BJSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+PSYEvxrtp5yrLjzgTS2MnN96tDk4TMTToOSQAnve9ovcgKMxPtk90y/XpkY?=
 =?us-ascii?Q?wKu5s48UXJb5czXmbJOS4MG26ih3EPMxsbCbaPqM2laqx4WCC3NfUwUmFwI4?=
 =?us-ascii?Q?h5FI77MRNaNhtnlqOG991ok29XTmAH3RgZyBQG4D5KVvi3b2fye3czHbMeSj?=
 =?us-ascii?Q?5Z7elmkJvcDgNEjQDhsKAQDOqM4snKmOB572cRhT6siX8wl1o+RWcC+ayqPO?=
 =?us-ascii?Q?XzWDznGEAe6tZdXRYJaLYLAjVmGkyYWvXk/bDJGFvOcZwrsedxhDPTS9MpBM?=
 =?us-ascii?Q?JvbXZlguE+TVVXt+l6dB9psY9ikNzvmMNHKMqJMq2OKx5ZdS9n7953xVIk6z?=
 =?us-ascii?Q?wK0qC6D8/AdtCz4yfnF9exHamZQI5lyBkOWqm6dZQJsSA7zKZ2VMOqpP136Q?=
 =?us-ascii?Q?ENo4dbm8cMslN68Vq6yD4ezUu76xLAWgyR8w10PKCU6Oup4cPwDrkgEHwvsr?=
 =?us-ascii?Q?ifoRRrHS7XbAwGHx+9CgPOKhcG+dwQh0vR6GNdQG0pu2Wurf4QmS0T+IIKOy?=
 =?us-ascii?Q?dX9NLEIAbMhpkDL24VlX/zun6/iDz5rzVxe/WW9x3Fh40ZogzPmoqjqXaiIa?=
 =?us-ascii?Q?bBstHG5icz/QOQ2/miNtT6cMhLVU/Ar0enOinLyFkVoksU2ucsisEjIoWC77?=
 =?us-ascii?Q?jvZiQZI9sj4/nAJr1b9cLAN1q0MFfxVi2NauQ8sHWPJzo/aiaZFklJUlAyKg?=
 =?us-ascii?Q?5+0BrQIvRCZz9LfF+7cki5idiI0UVbB0YlA2s4YDPqKBqbdugUMbCVmQxmuF?=
 =?us-ascii?Q?kVsY1w4bTTZj4jMWA+SYnUB1mm1w4Ue2zIr6oqG6si9VxSbQI6slE6sJzeXY?=
 =?us-ascii?Q?rXBLgZvsiANPMm4AO2j6mBwfH842fcJdNpSChHmOXR0cfQfB+iS/YzLTIxRT?=
 =?us-ascii?Q?1psLVEgkpLXBUso+rjdR2HCedi6zdNoG2PNodkIqY+JGTkzfYvqnbkTsfH9i?=
 =?us-ascii?Q?qZLhecSImydF6TJmrMC9uF54gcriN7gyleH6dZK2/sXMvU/j09b//cIPPq4C?=
 =?us-ascii?Q?D13ECJkBGK7HC5JKxRe5QHxdqAbPX48v+oCDp0OAuseOUJ8kgqZVDToEeodL?=
 =?us-ascii?Q?C7eN7XDGR2A+Jh6GDB/sIFGgl3wwG59zRrwi6QXwJOn02BbfkFrN2tH9TAly?=
 =?us-ascii?Q?I8Fn+8t+3ld0miV+8T0KgnK/E0DBoL1LlA8fionNFCUoVKJzm0aL71WisrFR?=
 =?us-ascii?Q?JdHc8WrVJRgkhD7NAah+KGaUvWwD0rXWJDqye7n+Wf+V2taJdGvSCuV6hON4?=
 =?us-ascii?Q?myxv8mUWSHUUv92a63RZuIrtLuoAw4VZdAl6R2cf4cDix6RVQw8nBIFvv35F?=
 =?us-ascii?Q?24csR0zA7LPBsCmoaX0jZdppNBz6e3kFAFKtoWljNWyjn3Hx5g3cz470F88s?=
 =?us-ascii?Q?pWEhLG0Zh4rbOEoTzO9fQYkddh0yTxn+mo+rqTxGzftzfaUneQiv/dXiFEU/?=
 =?us-ascii?Q?LC0XXNmw15B6ilFUlzIxHdwWst7nll5g0Dkuh0z73rrI9auLczYKc4tlYEXM?=
 =?us-ascii?Q?0OPIWDond43KTePvVWRLHcZgvvmj3SAlxusrKGulNZQgewTUkWY4slWYGw2p?=
 =?us-ascii?Q?+fgKfZCA/4cdlKbSMQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbc8944-838e-4f5a-9c27-08dda9d9374a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 17:47:35.6861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wN6Im+vi4e47jlgGRNLC7Abu6ZLlHPutH6tWpk8R86V0nVKvdwNjDyt1p6xTQfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507
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

Acked-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny
> Jiang
> Sent: June 12, 2025 11:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: [PATCH] drm/amdgpu: VCN v5_0_1 to prevent FW checking RB during
> DPG pause
>
> This is a WA for unknown WPTR touched during DPG pause
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 338cf43c45fe..cdefd7fcb0da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -669,6 +669,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>       if (indirect)
>               amdgpu_vcn_psp_update_sram(adev, inst_idx,
> AMDGPU_UCODE_ID_VCN0_RAM);
>
> +     /* resetting ring, fw should not check RB ring */
> +     fw_shared->sq.queue_mode |=3D FW_QUEUE_RING_RESET;
> +
>       /* Pause dpg */
>       vcn_v5_0_1_pause_dpg_mode(vinst, &state);
>
> @@ -681,7 +684,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>       tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
>       tmp &=3D ~(VCN_RB_ENABLE__RB1_EN_MASK);
>       WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> -     fw_shared->sq.queue_mode |=3D FW_QUEUE_RING_RESET;
> +
>       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
>       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
>
> @@ -692,6 +695,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>       tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
>       tmp |=3D VCN_RB_ENABLE__RB1_EN_MASK;
>       WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +     /* resetting done, fw can check RB ring */
>       fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET |
> FW_QUEUE_DPG_HOLD_OFF);
>
>       WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
> --
> 2.49.0

