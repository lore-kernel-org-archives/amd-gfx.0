Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694B5EA3F0D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 07:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F5A10E4D7;
	Tue, 10 Feb 2026 07:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TLNmFdbu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E5810E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 07:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDccdFN18hpc/8R306N/MrsI4sXOF2ilpSBlsY4LuY+W5yOL9xvkHow+8ngrSQM9gsvm6NJfmDvQB8qepmLWsRHU95j7uGAML3zrt8FqkIBlkapeeciyjNZrYUmaT/iBoG3cXMdsErmI6e+do0Cu6FUZ1tt0IaWlLIJr0fuck7Lr/mVESDMJQxSRr4CeOPGDqkoPMx6NaqeHGhbpN6NVNnDd4PmW3vz4dkS1ogBWt1ximh80a4Ev+4l1w1tcDE1occQQnKsqLXnmpuN0kUJ4ii2C/wuF+w31IMheq23K+VvBDOMXhpNrInd1bIuKJ6B8dBj9++XbXZ59cuwbZhskmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6woBUNMxnDF0rQsKsKb/eqxvjx19CbPDqA1oHtxcEU0=;
 b=IkTVPQtTRtYPppdMFxgGF+QjqbhaaFYhJo3DCV3JKLaWx5PPxon/p/Pd2LTukmdrEFshWQlr2GcaGuodWHC8IB963V6HzrjoQ5Geid80oLPStC8qTJkaupV5+/uyopGwUdl4ZRMbI8MDJUp9WSvO9schuLP+MdKcEh2kNLa0BwtlJSLny8J5eliMwJ7nkZT8ZECC3zpc6hKFJL6UTnVZP4Uge5DSkbBv/06PoZF9ludEzhurwWwwS+iHIm8neV5a72Rkndi1qbaThJBqj46ZpzJhNfXVRqRvjAiSXdSHQJTC5bvNVqQKngQNZ4rfqtxZwVH1hazSpDNO2PzX7CeoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6woBUNMxnDF0rQsKsKb/eqxvjx19CbPDqA1oHtxcEU0=;
 b=TLNmFdbun+rbiw2W2NaFbdv9j6ub3oaFwM3xJGBV16gLNmrCx3hyaxRQ0wJfSQxvFbjuwtg6Dwl//H7xLCGAeWWHNMnipdn96UpPurp6liET0s+dUu/nVlkUToaf85sBAuTFQn99mvGlj9B43wRBOo9qO6tlDFfIKpX2k9CBT50=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 07:28:43 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 07:28:42 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Remove amdgpu_device_flush_hdp
Thread-Topic: [PATCH 1/2] drm/amdgpu: Remove amdgpu_device_flush_hdp
Thread-Index: AQHcmlddQfePuA4ObEClUH/1Ax0QZrV7iQNA
Date: Tue, 10 Feb 2026 07:28:41 +0000
Message-ID: <DS7PR12MB607109B12AB655DDCBA438768E62A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260210063419.4154560-1-lijo.lazar@amd.com>
In-Reply-To: <20260210063419.4154560-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T07:28:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB7985:EE_
x-ms-office365-filtering-correlation-id: 5bc67ebd-4f4e-44cf-b3dd-08de687604a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?m/MqUamJy1XmgfsyR++u3H6JPF8aP2pQQ/cX+dfsPHMfTCCJWubQBIBgErbQ?=
 =?us-ascii?Q?TWXSPXeKF48FuKGhaYkZrBHE2mK9At8HEjUka602+dBqisRQ62CQQOxJ74ez?=
 =?us-ascii?Q?uusbT/srMbvXse9NF5Z4qxNF2+orK4yROG2BqP0ut8k4E1zlfbeQxn7KcJw2?=
 =?us-ascii?Q?XMFjs58w0PP7RK1QePDiMqele67BTD1cFZhixfp1qzEsnY4Qqn1h/Mtd9EJP?=
 =?us-ascii?Q?+VbI2oBdvSsm61eTwWEiP9riXeeJMivonuQlFDbOKTtTao6MiSHJlNTHIZ2+?=
 =?us-ascii?Q?4laorbbcMvATUVBQw7a9nF0gZcguyw+JKWLjMQ+EMEKViyzm2L/Mv5gVuVdF?=
 =?us-ascii?Q?RgXeljI65wlHG19LrOVIFUF81MP0hlT0fQt5SFlZidOUuc+hwIkefypEqWwh?=
 =?us-ascii?Q?nM53SpTJmg+ieegMAzsyRVg5WyeDMzO1tBPHoLz8xTafenxshv/t5cGDxrZT?=
 =?us-ascii?Q?q/OOSZpyZ28hHzJHttw8BbEAZm9JxAfKjTZ1U4aaPl5ceDcBdVfV1tJ70B8i?=
 =?us-ascii?Q?1dJfpiXXSqkBSdtJGzFnkqNuqjNrrWqfaQd6yNEJ1/wGiBX4UqXuUggXrG2y?=
 =?us-ascii?Q?PuR5zfxKuq0psnU7Rm/rF820KhwJcHum35Tg540rXRrOKLKQKR1nFHbmmdP2?=
 =?us-ascii?Q?xaJRjpm4NaOJQ7z53XPhSy0320LgyTHZ3faf0qIviQ+iBHGhqPxp5UGaSVOM?=
 =?us-ascii?Q?w8nfqp5a9vJXsfEuPKxD2HlKp+vNXCBnNWQ4nDGEfYOIm9ANtojqSznVm1mn?=
 =?us-ascii?Q?CiGcEw/yyv2TFB/EXW+1JE9bkt8+urUdM829HOCLU3X6TRbvMcSceKJ2NeRn?=
 =?us-ascii?Q?g+c9bE65/elRuECDl4z/+MOc56rUyb5Nto+5j0m53j3OcuemAtWaCvc4M5UK?=
 =?us-ascii?Q?Jf4t7q2oYFHb4VGevTK0qrVM8bgkrLP/v0rF44Y4MmzjqhgqdsWmne7O6fbZ?=
 =?us-ascii?Q?hAmt39wdeeQnYcMtVWOnkdjaH4nfDed+5oSucMseR8WdREsxZ2Tkx9gpd98B?=
 =?us-ascii?Q?WWuvGmeqQT5yy3ADscD/sepl6n4zYhb95j8HWVpFwPM8AeS4a3hQ4Kn1bVRG?=
 =?us-ascii?Q?XlX5cWcqtrnN3MKqTsd07N1x1av372ZbfLUMNAiAknvtuqq/tbIZB5fS5Il9?=
 =?us-ascii?Q?cXVgP1rfZX/0ti9ln6oTLX+fdpWj3yoopOJ09tcoW3yZWct99b65dqsCNyQz?=
 =?us-ascii?Q?7J7+wYd87kJNlDKgX5JqxkAb90qKauaGO1vpNLYgYo0gJK4/fY4OVMjCdoZB?=
 =?us-ascii?Q?dlwvL0pRPyWlUOVUmmXbYsLVzHM/eDlxJY1dmLHd4cHpSQMllBxuD0Dkne2V?=
 =?us-ascii?Q?Zmrv1D2B6hbuTsbZ7uNKhuWQgNAjuakuvk37QjlFCgSHf5AXbX0+XIhWoh4l?=
 =?us-ascii?Q?dwYUno5xERjRoYVMMpZ2rkebvLpe+B2n5NL7ZIH9UZ6mS7e1rZIEGXBBVRHB?=
 =?us-ascii?Q?T8yAdULmuLwUN/6Wlfz1FPajTwt1Zu/QkQHPUPWYCcjzSavne//u1Zr2RwWf?=
 =?us-ascii?Q?L45vGXok7ey7wDvK2ozpXVtwyVyyA4dME9YTl6WJitau/XuujZ7gPUGmYOmG?=
 =?us-ascii?Q?2+iBoLKArSINkbOkxaPcAspA+v9Su/8fOM0zy5TkN8wzfxCd+JCGY6K73UJL?=
 =?us-ascii?Q?+Ts8HlrBpS0ZAX2eNLyyBkk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?75Y7MMxdmeavSIhYsj7BKJ1n0o2npRNwmXwx/okneWyQq0LWRFfg3Q4LwRL7?=
 =?us-ascii?Q?1CnU37++BQvsve8jW2U9qYkv57AUs/pEKfhMtFKgBMB8msYmk5hiDD9YJSET?=
 =?us-ascii?Q?mDYwxW20w0O0L27iX1KG+EJnUXBERr4XMJNGWhHIwdmHBlmddBd8bmbgk2hs?=
 =?us-ascii?Q?/d+/KyIx+/x3ZWhbnjjG4szqcrdSF4nPdUC2fiWqNAe6+lnenZFga3e0XWr3?=
 =?us-ascii?Q?PzoY4ukdyeoVEs3QFlq6E/tqlJaJsiWTtmH7CvQX9gTSuvrZwNhaPR5SXn7K?=
 =?us-ascii?Q?CC5jC+WOYtT8fIlnLGTCaAHGLKYb6/2xgTpwylr0sSQuLXcxInZSjv6KcEXM?=
 =?us-ascii?Q?UTZlaMvzXqFcNOIPBpMSNiAjWbyhFuqZsJBSKViBg0pgHbHr4xymjMGBcIBL?=
 =?us-ascii?Q?Nq4SykOF2egaKgXB6hCH3TWXzd63pfCeLHoh3M85GnJfhTDLtBoZSMbGE2+X?=
 =?us-ascii?Q?blDnD0K/a7ONJCp+jLbocptVxh5szE6VBDm6ugluRzLUaY1XA4dV5lKMCgwP?=
 =?us-ascii?Q?Ifn0AHB27jN3wrPViEP+RBwDbA86GVahT5/eLbWj49avW65ngNqCPGz9XHiJ?=
 =?us-ascii?Q?FN1u+kCBD0p/smlFtWpjx1yfXgig5FVJz/hkmOHKfPd3bNfYNv8g9X+FPn3h?=
 =?us-ascii?Q?rxiWJjEwGi35v0SzBc+aSSHCwvo1En423oQQH3ufH5Zu4em3uoYaUfx2eVqN?=
 =?us-ascii?Q?O4OZuby6rRuTHUFGs1/6tIXx1+aK65UHVgQKLc/J7XrIigDo24Osx432q0sa?=
 =?us-ascii?Q?y5HYoe9TOJwJZ1vAx0Y7f2b3xACNqV5NZTDNfW5ujGchMk9py/ga+gbwwtBp?=
 =?us-ascii?Q?A+TAac/QG4p/W8SG2psZJJdTL1BLGipjPRAP03ma8UytPLvfA6KZnkflwVzp?=
 =?us-ascii?Q?CU1/ERSoGWx/mfIYnYoW/9PLmGw7zVF9mMAKyIO8hXckw8ti7Yk3ZdzVxFBD?=
 =?us-ascii?Q?aC46g6UcyRzl8inGsgofXi+OtmgTYKCju2GrNLvcolTa1FVjB6g7SKuNqJMl?=
 =?us-ascii?Q?bCYhRFfMLE8253aiHYs2qpPpL3fFcb5WfxjfLu4jejsNUAeBlMIqFvtZ+wp+?=
 =?us-ascii?Q?f31xL8Kj5C9Qjk/K9sN5t1RF64+LgHXJesDSUPuiHrFEqIh1YByT+IJFrbSr?=
 =?us-ascii?Q?V6Pd1JW6s9j54J4wG/gi2KcxgrE6ADviizb+NQ6/d6Db1qmcBwb4ltPmsexa?=
 =?us-ascii?Q?rkk0oV1dWniebYMPpg2FeAY3p9VGznPGrmELZf5YIxgT7cGms5MksoD8pIRY?=
 =?us-ascii?Q?DJMcaEBBZHPRiIAAYj31RkPElHGq8/4z5fewQZJrB2jGP2WYOQUszEE04GR1?=
 =?us-ascii?Q?IPeRkgIPVB8eci3AHluRlzFs9QwfKk1s5GDX49CYL/RGK6Pg10en81wDuMAf?=
 =?us-ascii?Q?7ffLx2bnTm6zHL78TGgF10GPsqF7Blb99HY4uEabcfnmtalBnSQS9JXp6ZYL?=
 =?us-ascii?Q?AaS2ii59xO9UifDQR/AeA5+L4StG+btDyz4cb/jcKmlDpi9EBHPvkEN1Fw8h?=
 =?us-ascii?Q?cmhDQyXQH2AfRcY0bGESAfdpGGhVarUJFrKKFcC3g+L+EAhA9fx4Xp0fmae1?=
 =?us-ascii?Q?oMMl8ZMpYJIglTeLc1F4ChuMGf2IpBXUXwwSLjBUoCS1vHn2qosEpqng2PcE?=
 =?us-ascii?Q?+pODJ+CRrEqky1JUJ3Rb57Sbiq+Y9UFIrAoiukbL8UwVK7gSP6VvCghEX+rs?=
 =?us-ascii?Q?oiU4lU1kTOdGgpMbjHFrSW249zdBBqtJtV7On7jEREzY2YnL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc67ebd-4f4e-44cf-b3dd-08de687604a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 07:28:41.8608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DL3wggjlzAgesADq6Yf2OB3ry7zCKFKtJowARhdF8CdOnKqj/k5yDkcoEk26q1quz/h21/7E/Jt2SEciCEpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, February 10, 2026 12:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Remove amdgpu_device_flush_hdp

Merge the logic into amdgpu_hdp_flush and use it as the public interface.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c       | 17 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  8 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  6 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c        |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  6 ++---
 23 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 1f5d15110e43..c1eded4bfa75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1527,8 +1527,6 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_d=
evice *adev,  int amdgpu_device_baco_enter(struct amdgpu_device *adev);  in=
t amdgpu_device_baco_exit(struct amdgpu_device *adev);

-void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
-               struct amdgpu_ring *ring);
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
                struct amdgpu_ring *ring);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 3bfd79c89df3..ed153e9008e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -738,7 +738,7 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_d=
evice *adev)

 void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device *adev)  {
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);
 }

 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev) diff --git a/drivers=
/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
index 48540300b10a..212eadb90c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -771,7 +771,7 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *=
adev, loff_t pos,
                         * after the system memory contents are sent over P=
CIe device
                         */
                        mb();
-                       amdgpu_device_flush_hdp(adev, NULL);
+                       amdgpu_hdp_flush(adev, NULL);
                } else {
                        amdgpu_device_invalidate_hdp(adev, NULL);
                        /* Make sure HDP read cache is invalidated before i=
ssuing a read @@ -7288,29 +7288,6 @@ bool amdgpu_device_load_pci_state(stru=
ct pci_dev *pdev)
        return true;
 }

-void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
-               struct amdgpu_ring *ring)
-{
-#ifdef CONFIG_X86_64
-       if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
-               return;
-#endif
-       if (adev->gmc.xgmi.connected_to_cpu)
-               return;
-
-       if (ring && ring->funcs->emit_hdp_flush) {
-               amdgpu_ring_emit_hdp_flush(ring);
-               return;
-       }
-
-       if (!ring && amdgpu_sriov_runtime(adev)) {
-               if (!amdgpu_kiq_hdp_flush(adev))
-                       return;
-       }
-
-       amdgpu_hdp_flush(adev, ring);
-}
-
 void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
                struct amdgpu_ring *ring)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_gart.c
index ec911dce345f..0f4a39f48c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -443,7 +443,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *a=
dev)

        mb();
        if (down_read_trylock(&adev->reset_domain->sem)) {
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);
                up_read(&adev->reset_domain->sem);
        }
        for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_gfx.c
index cab3196a87fb..eeec7947fc49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -676,7 +676,7 @@ static int amdgpu_gfx_mes_enable_kcq(struct amdgpu_devi=
ce *adev, int xcc_id)
        uint64_t queue_mask =3D ~0ULL;
        int r, i, j;

-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        if (!adev->enable_uni_mes) {
                spin_lock(&kiq->ring_lock);
@@ -736,7 +736,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, i=
nt xcc_id)
                queue_mask |=3D (1ull << amdgpu_queue_mask_bit_to_set_resou=
rce_bit(adev, i));
        }

-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        dev_info(adev->dev, "kiq ring mec %d pipe %d q %d\n", kiq_ring->me,
                 kiq_ring->pipe, kiq_ring->queue);
@@ -781,7 +781,7 @@ int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, i=
nt xcc_id)
        if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
                return -EINVAL;

-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        if (adev->mes.enable_legacy_queue_map) {
                for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) { diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_hdp.c
index 5a60d69a3e1f..c085031a6f09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -77,6 +77,23 @@ void amdgpu_hdp_invalidate(struct amdgpu_device *adev, s=
truct amdgpu_ring *ring)

 void amdgpu_hdp_flush(struct amdgpu_device *adev, struct amdgpu_ring *ring=
)  {
+#ifdef CONFIG_X86_64
+       if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
+               return;
+#endif
+       if (adev->gmc.xgmi.connected_to_cpu)
+               return;
+
+       if (ring && ring->funcs->emit_hdp_flush) {
+               amdgpu_ring_emit_hdp_flush(ring);
+               return;
+       }
+
+       if (!ring && amdgpu_sriov_runtime(adev)) {
+               if (!amdgpu_kiq_hdp_flush(adev))
+                       return;
+       }
+
        if (adev->asic_funcs && adev->asic_funcs->flush_hdp)
                adev->asic_funcs->flush_hdp(adev, ring);
        else if (adev->hdp.funcs && adev->hdp.funcs->flush_hdp) diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_ib.c
index 44f230d67da2..f4885a140967 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -243,7 +243,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed int num_ibs,
                cond_exec =3D amdgpu_ring_init_cond_exec(ring,
                                                       ring->cond_exe_gpu_a=
ddr);

-       amdgpu_device_flush_hdp(adev, ring);
+       amdgpu_hdp_flush(adev, ring);

        if (need_ctx_switch)
                status |=3D AMDGPU_HAVE_CTX_SWITCH;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index b0540b009e84..57a8ac2c69db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3479,7 +3479,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
        write_frame->fence_addr_hi =3D upper_32_bits(fence_mc_addr);
        write_frame->fence_addr_lo =3D lower_32_bits(fence_mc_addr);
        write_frame->fence_value =3D index;
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        /* Update the write Pointer in DWORDs */
        psp_write_ptr_reg =3D (psp_write_ptr_reg + rb_frame_size_dw) % ring=
_size_dw; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 22e2e5b47341..df978a39ed96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -112,7 +112,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update=
_params *p,
                atomic64_inc(&p->vm->tlb_seq);

        mb();
-       amdgpu_device_flush_hdp(p->adev, NULL);
+       amdgpu_hdp_flush(p->adev, NULL);
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 1893ceeeb26c..b413f10e51c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6153,7 +6153,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct=
 amdgpu_device *adev)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0); @@ -6231,=
7 +6231,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_de=
vice *adev)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0); @@ -6308,7=
 +6308,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_dev=
ice *adev)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0); @@ -6683,7=
 +6683,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_de=
vice *adev)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0); d=
iff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v11_0.c
index b1a1b8a10a08..f4eba3247533 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -2522,7 +2522,7 @@ static int gfx_v11_0_config_me_cache(struct amdgpu_de=
vice *adev, uint64_t addr)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0); @@ -2566,7=
 +2566,7 @@ static int gfx_v11_0_config_pfp_cache(struct amdgpu_device *ade=
v, uint64_t addr)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0); @@ -2611,=
7 +2611,7 @@ static int gfx_v11_0_config_mec_cache(struct amdgpu_device *ad=
ev, uint64_t addr)
        }

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        tmp =3D RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_CNTL);
        tmp =3D REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0); @=
@ -3248,7 +3248,7 @@ static int gfx_v11_0_cp_gfx_load_pfp_microcode_rs64(st=
ruct amdgpu_device *adev)
        amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
                lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -3466,7 +3466,7 @@ static int gfx_v11_0_cp_gfx_load_me_microcode_rs64(st=
ruct amdgpu_device *adev)
        amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
                lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -4703,7 +4703,7 @@ static int gfx_v11_0_gfxhub_enable(struct amdgpu_devi=
ce *adev)
        if (r)
                return r;

-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        value =3D amdgpu_vm_fault_stop !=3D AMDGPU_VM_FAULT_STOP_ALWAYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index a418ae609c36..3d068dca1442 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2405,7 +2405,7 @@ static int gfx_v12_0_cp_gfx_load_pfp_microcode_rs64(s=
truct amdgpu_device *adev)
        amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_LO,
                lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
@@ -2549,7 +2549,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(st=
ruct amdgpu_device *adev)
        amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);

        if (amdgpu_emu_mode =3D=3D 1)
-               amdgpu_device_flush_hdp(adev, NULL);
+               amdgpu_hdp_flush(adev, NULL);

        WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_LO,
                lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
@@ -3560,7 +3560,7 @@ static int gfx_v12_0_gfxhub_enable(struct amdgpu_devi=
ce *adev)
        if (r)
                return r;

-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        value =3D amdgpu_vm_fault_stop !=3D AMDGPU_VM_FAULT_STOP_ALWAYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index 2568eeaae945..dffb130489a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -250,7 +250,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
        ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;

        /* flush hdp cache */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        /* This is necessary for SRIOV as well as for GFXOFF to function
         * properly under bare metal
@@ -946,7 +946,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *=
adev)
        adev->hdp.funcs->init_registers(adev);

        /* Flush HDP after it is initialized */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        value =3D amdgpu_vm_fault_stop !=3D AMDGPU_VM_FAULT_STOP_ALWAYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 6349e239a367..c322b438d0e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -238,7 +238,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
        ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;

        /* flush hdp cache */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        /* This is necessary for SRIOV as well as for GFXOFF to function
         * properly under bare metal
@@ -918,7 +918,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *=
adev)
                return r;

        /* Flush HDP after it is initialized */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        value =3D amdgpu_vm_fault_stop !=3D AMDGPU_VM_FAULT_STOP_ALWAYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v12_0.c
index b9671fc39e2a..2e5c373a8289 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -309,7 +309,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,
                return;

        /* flush hdp cache */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        /* This is necessary for SRIOV as well as for GFXOFF to function
         * properly under bare metal
@@ -969,7 +969,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *=
adev)
                return r;

        /* Flush HDP after it is initialized */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        value =3D amdgpu_vm_fault_stop !=3D AMDGPU_VM_FAULT_STOP_ALWAYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index e35ed0cc2ec6..47b989036de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2175,7 +2175,7 @@ static int gmc_v9_0_hw_init(struct amdgpu_ip_block *i=
p_block)
        adev->hdp.funcs->init_registers(adev);

        /* After HDP is initialized, flush HDP.*/
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_ALWAYS)
                value =3D false;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index 0bd83820dd20..21eef7f6afb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -495,7 +495,7 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *=
adev)
        memcpy((void *)table_loc, &header, size);

        /* Perform HDP flush before writing to MMSCH registers */
-       amdgpu_device_flush_hdp(adev, NULL);
+       amdgpu_hdp_flush(adev, NULL);

        /* message MMSCH (in VCN[0]) to initialize this client
         * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr di=
ff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amd=
gpu/mes_v11_0.c
index 09ebb13ca5e8..ec50df3ea9d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1212,7 +1212,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *rin=
g)
        mqd->cp_hqd_iq_timer =3D regCP_HQD_IQ_TIMER_DEFAULT;
        mqd->cp_hqd_quantum =3D regCP_HQD_QUANTUM_DEFAULT;

-       amdgpu_device_flush_hdp(ring->adev, NULL);
+       amdgpu_hdp_flush(ring->adev, NULL);
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 9aa988982304..691b305f28c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -551,7 +551,7 @@ static int psp_v11_0_memory_training(struct psp_context=
 *psp, uint32_t ops)
                        }

                        memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-                       amdgpu_device_flush_hdp(adev, NULL);
+                       amdgpu_hdp_flush(adev, NULL);
                        vfree(buf);
                        drm_dev_exit(idx);
                } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index af4a7d7c4abd..7106ad806a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -640,7 +640,7 @@ static int psp_v13_0_memory_training(struct psp_context=
 *psp, uint32_t ops)
                        }

                        memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-                       amdgpu_device_flush_hdp(adev, NULL);
+                       amdgpu_hdp_flush(adev, NULL);
                        vfree(buf);
                        drm_dev_exit(idx);
                } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v14_0.c
index 38dfc5c19f2a..5fb35d9b0f5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -505,7 +505,7 @@ static int psp_v14_0_memory_training(struct psp_context=
 *psp, uint32_t ops)
                        }

                        memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-                       amdgpu_device_flush_hdp(adev, NULL);
+                       amdgpu_hdp_flush(adev, NULL);
                        vfree(buf);
                        drm_dev_exit(idx);
                } else {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 804851632c4c..da062d13414f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3497,7 +3497,7 @@ int suspend_queues(struct kfd_process *p,

                dqm_unlock(dqm);
                mutex_unlock(&p->event_mutex);
-               amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
+               amdgpu_hdp_flush(dqm->dev->adev, NULL);
        }

        if (total_suspended) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dcf4bbfa641b..fbcb12e0888a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -754,7 +754,7 @@ static void init_mqd_v9_4_3(struct mqd_manager *mm, voi=
d **mqd,
        }

        if (mqd_on_vram(mm->dev->adev))
-               amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+               amdgpu_hdp_flush(mm->dev->adev, NULL);
 }

 static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd, @@ -793,7=
 +793,7 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
        }

        if (mqd_on_vram(mm->dev->adev))
-               amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+               amdgpu_hdp_flush(mm->dev->adev, NULL);
 }

 static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd, @@ -834=
,7 +834,7 @@ static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **=
mqd,
        }

        if (mqd_on_vram(mm->dev->adev))
-               amdgpu_device_flush_hdp(mm->dev->adev, NULL);
+               amdgpu_hdp_flush(mm->dev->adev, NULL);
 }
 static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
                   enum kfd_preempt_type type, unsigned int timeout,
--
2.49.0

