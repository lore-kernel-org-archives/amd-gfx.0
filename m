Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA6ECCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 07:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D5BA10E947;
	Thu,  9 Oct 2025 07:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isER4eJX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D05210E952
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 07:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLVLYc6j25FydXummU2+C37PxefwqTQuM8y3boc6JsV6hIvrcwwcXj/vHz+dmxIoN8+3XBsYX2wl6/ogO7/Y8HWkJCHTJmGwPKBh0teFyVamQZtBp/tZ2HUaQn+TvO59pj6260+59U2KrC42y7flQngnneP+d5fpz7uPhzmQhAsJgaIhQL95DO7aKZLRAA3DWlAZkOgACfGV5p9nrpF9ar6PJV7TGzXX2C85/C4AAd8RfRvfJ3tRwQ2fqudG37cJ6i1agBDOZNHtmc5lPl6S0rEaWgTS3fKFiMw0/toQBsLesy5N12o38Z7pcay9rFSpM6kDwqPhPBuB0lSd2jwvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk0itmVyN5MjRNzEJdPdnlGxzzRG448iFPOoJpj1MgE=;
 b=Xe2l0g/WiZzcFXJCx9xOsnvNoDQuWs6r07+PcfamDImg+RLOJw9f4aaH5Yi9/s98TFXQrFm2Sk2g2Z2M877b1lAf3Ileyh+lSZfaOG/x3PS/w4nTrs4pyA/yEiztpGKxtFikBNG1VF8yKNj5Q5jGtR5pL8FiJQAKT6QcULf2l10GYqDmyuVxUmi75Ysje1+RUtNBnQGz2DiVX0LdzmBUyjy/tNvs8eiuqKBs1DnN+a4opmmohPz48bd6N1JMMw6ozIAMGaV0cpurlyA5yEJluR0qfeZdfqtEJ2QbQIl1hjmwSzDTBJvePhAfqdUNuTaiqk1xtHMOmbyYkcO4Kt+waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk0itmVyN5MjRNzEJdPdnlGxzzRG448iFPOoJpj1MgE=;
 b=isER4eJXLhX979YCxFHX5YXnQn97e9paH+RSREgjPYJc7JDg6eMSqVA5zWDFWH+xgEmt8tYgQYKb7q+EXsiNKC7sAciIVhXuFXMtKezWeDKtMTCn/DxE0p9AeNP1SxRTwC3Q28YM35X6cRTmAyG/0z0YKpFNxRtzPTE5F4uDnoU=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Thu, 9 Oct 2025 07:30:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 07:30:58 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Topic: [PATCH 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
Thread-Index: AQHcOMdCN3Yiu//KtEyG5niJw4Hj+7S5Z/Tg
Date: Thu, 9 Oct 2025 07:30:58 +0000
Message-ID: <DS0PR12MB78048E7EAD08BE665E5FF5A197EEA@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251009024822.3973163-1-Victor.Zhao@amd.com>
 <20251009024822.3973163-2-Victor.Zhao@amd.com>
In-Reply-To: <20251009024822.3973163-2-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-09T07:17:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DS7PR12MB8292:EE_
x-ms-office365-filtering-correlation-id: a0e5672e-f975-4a1c-de20-08de0705ca49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GumXrjeRsGSHRKwtOmFPuZ/LazPtJPz0qh6wn26UVBPCrzpjqG/rBAAdhyfw?=
 =?us-ascii?Q?9EbTKCwAAH0Tr/rJHIphI+fzgwhm0WYFMVJ45BtCAjWRVV+rbWuTAGPoKEv4?=
 =?us-ascii?Q?R+9Smcl1Rf1neJBwb7MHI+JCGVoEs4pqKYS2sjxdRPX7iVq+z3TDuJU/FweZ?=
 =?us-ascii?Q?Pu0JjpR9dcM32/HLaTw2AOnoQwjFY9DlQqReEemRe/a94Abbv5sNLnLVO6cL?=
 =?us-ascii?Q?t/kf6rVHee1m0dd6JfixAtRBmRDhq2yqRU/hF2Alhu3/I7tOmdYusQo236Qp?=
 =?us-ascii?Q?82cmnzZ4VI4GEutDAYQmz6jed0aSUxKoWy/jKX9aakPfeMBDK6nMzv+QIcZy?=
 =?us-ascii?Q?ZudOO9wwDrsDxuLn3+tct48TIOG+qbQBOMKVX8bAduqVAccNDW6ktz/fw81Y?=
 =?us-ascii?Q?Tl20OE/FkmUg+/cIlzdq3pKzrQUs1ZRMCmwbKMlN23at0/RtBF9AYxfr+I+C?=
 =?us-ascii?Q?d4q4X40iXXu88zHZJdBWFN5Ft/2jaV+0v5aoPcR+2THTAqFaq2xwDiwRPeD/?=
 =?us-ascii?Q?P76cOrcya4EdmfAVK7pC3MRZFnaUYkc4ERsa+N6HiDdeVMaKg+Bx/u7m0F2b?=
 =?us-ascii?Q?6R/hmWigDHeJtOQpF+UF+xIAJS5jKP1VnT0RhJjXCNLYUuQLQBlItWABdbAE?=
 =?us-ascii?Q?z+OxqcAmfrGzvVDEa++J6uFT2E7jHSvN88eZPGnMYovlmJgPl5rR0q03Kk4G?=
 =?us-ascii?Q?PvRkhrzqCOtt72R8BFtkyf/IN17xmtSSx2Of9OQO1wPtPE7T0VAdKrScFDdQ?=
 =?us-ascii?Q?hfO7CB8sCej+ZyH/dLUZ9Z8uV70fdV/oWPfQIfcNuuYzuRWJ8ghZM1wRReQd?=
 =?us-ascii?Q?Bukd8nTQ4fN+/jfE7q26hG300dG9m1ljlPNka1+Npy/DcQNLwlGJ/m+JWq11?=
 =?us-ascii?Q?/C3RVmkVJrf4YZ3vh8VEchDKUToNfU0FCmeBbSvpSp6svdl2WmUe8KY70jL8?=
 =?us-ascii?Q?6d8CdYlA4R1oZKPZe6ytmNanZav/uR1lQQypJ5sRuaCrtVtqujaEKtDeoT6H?=
 =?us-ascii?Q?WvRmaf8hLEGb/0YNZMrPaHPbRtiMJB2iKa38TggHSPMewLWXV2pBJIwCpyvY?=
 =?us-ascii?Q?MLZWpYKUFn4ypctWD0K9Pq2ohLilBRMuzGWAqRGuJbDlceIo9eGF1GXjqhaB?=
 =?us-ascii?Q?cglIIFm7itploQ28G8HYBOZZnWWnyJCA+YpSR62QVwRstz/oMuqruMBJkQF/?=
 =?us-ascii?Q?EOWxgszinCUHUjrOshr2QpYwqv7mWjO7TzY0i9TYQcY1dXpAEDlRj6BgKjkM?=
 =?us-ascii?Q?fY85rF5tw17YkojfdjV+P1LGiVrBfCEZdFM8vQgQrhmPpI7SSZ3BtW0StWrX?=
 =?us-ascii?Q?TjdOErchUwcc4GGJIn7Bg1bXu67dh4fBm5CmWG034m0CAWXPDJFAjdqq6F8x?=
 =?us-ascii?Q?IP4DrUvgF78Hc6VrY2Ss76ebD+o6fAOByDUlk1VYm8aLmOaAPDZ33EtFBaFy?=
 =?us-ascii?Q?/LJqO5PUCXW0dIaDxRKaMqEluoxbKM9pJ8P7fxd0+tb3qTBJm3AgjdkBTFbv?=
 =?us-ascii?Q?iMs7zCmg2+GXwLL6ekcUauele+DqK+7rRNDk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iFv6tZG+1AoBoedjg1CfqH0tvM7/QbVzyhHS32StfDL8N+YDCDk/jtWgMSct?=
 =?us-ascii?Q?01UHr+fTtwrDqY9T+e7fPnIJlMvL+Uq4IPQs7nb6/DI1gDfgbSqQ+GTuEn8V?=
 =?us-ascii?Q?pgN1q723+vyYHUQwXrOnjHLRYGpYD0KHK6xxxzxf/fk/oIJJ9C7HHjBGWlUG?=
 =?us-ascii?Q?AH0nZ/18D3eBZMLgOuFF9AdDiARBolAPyAnd/0q6chRUabWy9xPD1heAt3iT?=
 =?us-ascii?Q?hj749EbWUXwiloHh4pMxSa5pioYjOnDLUstWbbnABykNKboYvRDGgcYoank4?=
 =?us-ascii?Q?VQ7qWrROGIHQkl20oBbmOD2hdsaFuMnK9EW6A6qGt+JBhr9BMAGajO/l7oHk?=
 =?us-ascii?Q?Xo8AFp+gKM02wLgm+/oxKuiDrXN4Oivjt+lrnEDc1hLmrIQ4MnOCI/PsajHb?=
 =?us-ascii?Q?QP9JUAue9IC8/bLn2SUyMuv9FMpMnj2DOXHNvhj0o8fWeGk0nxKv33mKL57b?=
 =?us-ascii?Q?dZMFYrkEHdG/L9ZHEXupYpAHGbsx1dzEcLM6AaQzh0+bZxa4Aev1s29wM49n?=
 =?us-ascii?Q?jeQU4VH1ayKoanFqDS/vtGhQGedyi+uXKWcqj0BnhOm65LA4C/GygUe1WcWM?=
 =?us-ascii?Q?uJ9m3HseH0vy8HDAEUN1GnSL/Op4iZW2aomfkDEsdzmkNpt6t/ORpC/NnefN?=
 =?us-ascii?Q?M51KgQi791k+7QFw0V9g3LY00XxD5tQj1qoFsWgh6k7vVt2KHVbTqNsgCvq5?=
 =?us-ascii?Q?urFZvMhEV44iQyk0mcDMbfa0wQCYZ55v3PMU7BMrnuoSLsEDLl8+M+Et2+no?=
 =?us-ascii?Q?ar83gDBMFX2EvJ4Rt8eO3c35Obs7EGYZFa5Qe2ElTy44l6mlynC/3vZKebDs?=
 =?us-ascii?Q?847RDbi1ygSsp7+S6Dk+tWaqRl4TECfBAHnuKkqjZkQhjvbVvDBvjNmScYVd?=
 =?us-ascii?Q?VnEzO2y5ohY0NZmO9O2XEmkozxXAO+1vcIfVhtWFG+vMdZyA6KMoEw6/qgxG?=
 =?us-ascii?Q?kZFRZrpuEpQrzjZEKPO6BLuHh/wyXVDdgHxcNN/fCGC8yilN2L2AFFthuc/b?=
 =?us-ascii?Q?LzwpDjGmqO9IdUFgPgRW5xMPvf+LnQcG5LrUiBHdPaE4lr0CCEGVX2GDTnzz?=
 =?us-ascii?Q?qziV2sjFFSK/WbolLIf0BSagmmRHnaNp9Y3iEu2YD7Pimxp8nJV9CQD9KRuS?=
 =?us-ascii?Q?YlF4wb3An75gQXzZcyh8fjSB3Ow0A0IPkJ/diiu5a91B9NZWvgP2L1bF3Fbd?=
 =?us-ascii?Q?pYbnM1lep6GGOdwb8WXXxP8X9dYznxy/vZKrXn281cWQ2RRxL9zWWldBrR81?=
 =?us-ascii?Q?OSWlWivjwCNx6k1Otm9gNM1pkZWNYgtB4Sm6NEooCKZoyRXjQTVm8Q0+RVdR?=
 =?us-ascii?Q?dvSfweGlRvrs+JUyGyR68mTWyc5FXXX2XkldtpcMH4zOx3hAk+8VbuaDRn8M?=
 =?us-ascii?Q?/LIAaYbYAJ4tIMreM8gZin7MwtWfKukxmtSQ0hUKkkeLPFA9WtlQXFlSMDn6?=
 =?us-ascii?Q?ipFNXMoVhYCpqZTDmPSncY5TdqteFp8JAk3P6P3RV2MXxPYhKXggVyu3cIBV?=
 =?us-ascii?Q?lAHv6kU0ZFULajledUI3xAOCLZQim9+fpI6C6yAWO5SuSmZcCgfacnqsFkKu?=
 =?us-ascii?Q?ySgABbpn2Qg3dFYWFO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e5672e-f975-4a1c-de20-08de0705ca49
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 07:30:58.3214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjIt7pN3V1foGOzlpU5KU1QouWm6yzWJDChGFyTJ+UGLWG6n3Rz/XPbtmJpmFZwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292
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
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor
>Zhao
>Sent: Thursday, October 9, 2025 8:18 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Zhao, Victor
><Victor.Zhao@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: use GPU_HDP_FLUSH for sriov
>
>Currently SRIOV runtime will use kiq to write HDP_MEM_FLUSH_CNTL for hdp
>flush. This register need to be write from CPU for nbif to aware, otherwis=
e it will
>not work.
>
[lijo]
I think this may be related to routing in mult-xcc-SOCs. You may keep the o=
riginal path as fallback for SOCs without multi-xcc.

>Implement amdgpu_kiq_hdp_flush and use kiq to do gpu hdp flush during
>sriov runtime.
>
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 73
>++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
> 3 files changed, 76 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 7a899fb4de29..eff43757f983 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -7281,6 +7281,8 @@ void amdgpu_device_flush_hdp(struct
>amdgpu_device *adev,
>
>       if (ring && ring->funcs->emit_hdp_flush)
>               amdgpu_ring_emit_hdp_flush(ring);
>+      else if (!ring && amdgpu_sriov_runtime(adev))
>+              amdgpu_kiq_hdp_flush(adev, 0);
[lijo]

If there is no use case of passing a different xcc_id, the extra parameter =
may be removed and always be assumed that logical xcc 0 will be used.

>       else
>               amdgpu_asic_flush_hdp(adev, ring);
> }
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>index 7f02e36ccc1e..ecd7908590de 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>@@ -1194,6 +1194,78 @@ void amdgpu_kiq_wreg(struct amdgpu_device
>*adev, uint32_t reg, uint32_t v, uint3
>       dev_err(adev->dev, "failed to write reg:%x\n", reg);  }
>
>+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id)
>+{
>+      signed long r, cnt =3D 0;
>+      unsigned long flags;
>+      uint32_t seq;
>+      uint32_t hdp_flush_req_offset, hdp_flush_done_offset,
>ref_and_mask;
>+      struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>+      struct amdgpu_ring *ring =3D &kiq->ring;
>+
>+      BUG_ON(!ring->funcs->emit_hdp_flush);
[lijo]

This may be kept as a warning. It's not necessary to bring-down the system.

>+
>+      if (amdgpu_device_skip_hw_access(adev))
>+              return;
>+
>+      if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready) {
>+              hdp_flush_req_offset =3D adev->nbio.funcs-
>>get_hdp_flush_req_offset(adev);
>+              hdp_flush_done_offset =3D adev->nbio.funcs-
>>get_hdp_flush_done_offset(adev);
>+              ref_and_mask =3D adev->nbio.hdp_flush_reg-
>>ref_and_mask_cp0; /* Use CP0
>+for KIQ */
>+
>+              amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset,
>hdp_flush_done_offset,
>+                                            ref_and_mask, ref_and_mask);
>+              return;
>+      }
[lijo]

This part may be kept as amdgpu_mes_hdp_flush and moved inside amdgpu_mes.c

Thanks,
Lijo

>+
>+      spin_lock_irqsave(&kiq->ring_lock, flags);
>+      r =3D amdgpu_ring_alloc(ring, 32);
>+      if (r)
>+              goto failed_unlock;
>+
>+      amdgpu_ring_emit_hdp_flush(ring);
>+      r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
>+      if (r)
>+              goto failed_undo;
>+
>+      amdgpu_ring_commit(ring);
>+      spin_unlock_irqrestore(&kiq->ring_lock, flags);
>+
>+      r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
>+
>+      /* don't wait anymore for gpu reset case because this way may
>+       * block gpu_recover() routine forever, e.g. this virt_kiq_rreg
>+       * is triggered in TTM and ttm_bo_lock_delayed_workqueue() will
>+       * never return if we keep waiting in virt_kiq_rreg, which cause
>+       * gpu_recover() hang there.
>+       *
>+       * also don't wait anymore for IRQ context
>+       * */
>+      if (r < 1 && (amdgpu_in_reset(adev) || in_interrupt()))
>+              goto failed_kiq_hdp_flush;
>+
>+      might_sleep();
>+      while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
>+              if (amdgpu_in_reset(adev))
>+                      goto failed_kiq_hdp_flush;
>+
>+              msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
>+              r =3D amdgpu_fence_wait_polling(ring, seq,
>MAX_KIQ_REG_WAIT);
>+      }
>+
>+      if (cnt > MAX_KIQ_REG_TRY)
>+              goto failed_kiq_hdp_flush;
>+
>+      return;
>+
>+failed_undo:
>+      amdgpu_ring_undo(ring);
>+failed_unlock:
>+      spin_unlock_irqrestore(&kiq->ring_lock, flags);
>+failed_kiq_hdp_flush:
>+      dev_err(adev->dev, "failed to flush HDP via KIQ\n"); }
>+
> int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)  {
>       if (amdgpu_num_kcq =3D=3D -1) {
>@@ -2484,3 +2556,4 @@ void
>amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
>                           &amdgpu_debugfs_compute_sched_mask_fops);
> #endif
> }
>+
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>index fb5f7a0ee029..5bccd2cc9518 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>@@ -615,6 +615,7 @@ int amdgpu_gfx_cp_ecc_error_irq(struct
>amdgpu_device *adev,
>                                 struct amdgpu_iv_entry *entry);
> uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg,
>uint32_t xcc_id);  void amdgpu_kiq_wreg(struct amdgpu_device *adev,
>uint32_t reg, uint32_t v, uint32_t xcc_id);
>+void amdgpu_kiq_hdp_flush(struct amdgpu_device *adev, uint32_t xcc_id);
> int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);  void
>amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t
>ucode_id);
>
>--
>2.25.1

