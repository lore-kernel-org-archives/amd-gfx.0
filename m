Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D74C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 14:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E2810E2CD;
	Tue, 29 Apr 2025 14:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YR1jqM7T";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F2010E2CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 14:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQ4SX68iNl3CYn/5ACC/EHxPvr7BqgLIT1vsrPdG5plWjWqSoyAzDWtvFzFiqv117+O2LVX/kVq6UUykeNgSwI/9yleW4bSbt9vel8dMI5pQQWktfGjMjzmbqTngSAYfW4HV0UNCkzK6Rn5PWQiJhjAq29nvg1fjhc7jyfiX20O8+hAdMwVoVW+cwXWCM57AbDaxogUTd9uH0FcV0/bc9kKFD6Jcdq9evfHynyzR3Pxo1UAZeq2cvagr6+5d3pwwOY9adrAA5WeofNOJ/8bMZxdQtLuUyOmHaX5ZM4QXJgmE7J3ZKHT09JLWizUzNNuiDAha1AF39P7JxX809N+cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ6m2o/axR+fip070QKZ09HAyuH/OfN9y4FbeFHNhj0=;
 b=pQa+2PwW5pw7LRySB9VgECuY2LBPklXQyvvi7j2yGSRL0NpVoSehEg+0elfM6/YsBLkbHXpFoQqGOs/w2956n+N8sk3yhr63fAH11E+DQ1RXnj/7D8rhIPOL34QDde+8Z16wljJnByJ2D56eiKOtPEWdBr1ZNr7Tvqq9ElIHS4hJL+T6N7yuTehwQeCFEtUAaUVccBpp2MQCpMlpJOKIMA3E7IePQsQnEqQvtnoY1+p6fPrjhI35F+YMBenwPckxKeH8KfbOEOoCh1YhT8dc5MHX5mvDAJqZQZllncdM4oYR7NaZM8ua3FhxjwlYzua1jdUo2LX5dvR84vn1D4o2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ6m2o/axR+fip070QKZ09HAyuH/OfN9y4FbeFHNhj0=;
 b=YR1jqM7Tuid5Ifdc1qBuQrb4tBaMQEyHgE0hgfMg1x2ZyhissQlMSp00LRZdoGjMO1xq5R1Och8eicQXYHSc3PzGkZRJHgroPMoW+UsXFqTHCCl2CpI+xRP/6ZxrBExhs1FjDGz8ZhJSpJtTq8CcodcUweKUH8W1f3book8wEgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 14:02:33 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%6]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 14:02:33 +0000
Date: Tue, 29 Apr 2025 22:02:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Trigger Huang <Trigger.Huang@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove re-route ih in psp v12
Message-ID: <aBDb59NyMq1G0iW3@amd.com>
References: <20250429102954.3913983-1-ray.huang@amd.com>
 <34919514-46de-4e4d-9eae-e58bb8c7bb94@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34919514-46de-4e4d-9eae-e58bb8c7bb94@amd.com>
X-ClientProxiedBy: KU1PR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:802:18::31) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: ead99ee8-cb79-44b5-a425-08dd87267d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?aSxXobYYxTZfU+PFXLs53C/G3S+wRfjnXG/W+dNIUtoduoqZxX0ZarzDF3?=
 =?iso-8859-1?Q?gfKsxhfWqiDLOo9pyPzy7Wy2CG5PrJc+VYqaNWxUhh7ZFfKwYIWj//mzL8?=
 =?iso-8859-1?Q?hLAPEeP6rLzmRh2TZUlI7n/IU9adNoYm4m2OMAEjVExw7+tayKQA2u1T0v?=
 =?iso-8859-1?Q?+sPurzGtGEh1ZQD7xTs0DSSYG7hR3nDlePMLaDiXxQJgeP7U07jrR7i1t5?=
 =?iso-8859-1?Q?lNSXi/f0eAJtPfY0PNi+KNKNohwltB4M6+QpuS0EGcjXippWMaFhz828Ng?=
 =?iso-8859-1?Q?I/GU1DIhqRo6BUBMimr9YOyIMDV7KacaXqG1+52+fKW/ccZSCwz4mxHQeF?=
 =?iso-8859-1?Q?5415wfxP2xxm7RZG64goI4vptFwe4QJDnB/YKDmdv+ZvDdEv6njwPPMgNg?=
 =?iso-8859-1?Q?YSo6iDHp2c8/mEcbrYJofTHsLd6Hq3zVmuQOmBrjPWq2UUONn8Ok95Z5HM?=
 =?iso-8859-1?Q?lz4tAdlCHoHY3EffkPL0Jj2EfDmLEsXqfEWfx/D9rxzKv+J8pkizbIefi0?=
 =?iso-8859-1?Q?gwsipeUnqa04ROx0pFoOT31MyRtuxDrea8RSwCQR7EgzP4gCCcpv6GM/jT?=
 =?iso-8859-1?Q?zUkPLlxGXaPxXEllJN8+XqNc5h0Q+E78VzKeRWzKVmtfJ8jO7QqXhiHUb/?=
 =?iso-8859-1?Q?+0zpY9/jE7vYiEA+/4N9ZwbY6oyN9Pl/3vqYwzVk7FRRG0jHiuDSmUQ50D?=
 =?iso-8859-1?Q?geXIVlPc1AJi/mos5bTbZV++O1sH76RSzt0V3gv67VxG+9rS8oMBP51/jt?=
 =?iso-8859-1?Q?GNPDv9IfYBS+qkcB6VFygLEjf8A9nLgDzNGJoY9wkVAw8knKQmcOqMR4J9?=
 =?iso-8859-1?Q?V30dR/JSeydpEbTRiGLOsKgbcSCtbTikKGBMOgv+9Lks2/QHJHQsIM+znF?=
 =?iso-8859-1?Q?wv4hdki+Gjgi46YEUJOmKW6hk64Yc8nnAIkrtpcPYNcQtoaDBXG1S0MI22?=
 =?iso-8859-1?Q?s5I6f64rmrhvHsrFoR/MmKyR8b0iOSUW74BFE0/b0xDdyHgWuoq37gnQns?=
 =?iso-8859-1?Q?O174JWJwnQgZ88L3q0rPzStzGCYDS5ydL2V/8yEvBycV1R7slUJXSNX9A0?=
 =?iso-8859-1?Q?XqdyBMthEpvp0FurZarxEK3QsTmaycSluNLCy3+baP7RgCL2RvUx3GREK5?=
 =?iso-8859-1?Q?9Rgze0FlEp3Ar+RrxcrttE6bmqQr+mjcEzpHXifyYqG/AZxrIKEF6+lskl?=
 =?iso-8859-1?Q?M/AnFFz9gZMCGbQ8zDI/TEt8gPSA63LCHg1wg176hfTeeC7B3VfIgAwmHJ?=
 =?iso-8859-1?Q?6mGXLkuYj4IlSJPn35SN8MQ0UghqmlvYc1NvGtkOT84a4IS1yx6t4CQDex?=
 =?iso-8859-1?Q?J5ZLmAjb49k3DpJ0DbQJ5pGE9ufRMjqzDyXRN7gFCnqxGM4DI4516G5nIF?=
 =?iso-8859-1?Q?PHCcx3UXV49yZCfF6CDUhmFdzHpFhcEZjKxwZ+S+nn4pnnO2xWEfmxpH8k?=
 =?iso-8859-1?Q?UK0ntaAbLMcE/phQEdv+ODtlN/+sDR8mOkRsrRiiOeGK4YuEwAutf71LQ8?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NwxrLd5LbLr7lTPZf1jQrvyKhs2tbKC4HMFLgMAYgVuzFXTB9HPg2kDJWa?=
 =?iso-8859-1?Q?v8aoYR/TG8Du77PV0DjhVRmGAMvBwVl0I/oPSfM60VuaJNF8s4B3x1ssGs?=
 =?iso-8859-1?Q?WWndLQi+FYzxmzAJiDdS5iqwXOvpOn8yzKmbvvDt/tFbiABhCXXXpg6zrW?=
 =?iso-8859-1?Q?+u0jBu2UCSsdZKpbQK0/TriYSiE12xsIV+HKq4L48FZ/m3Nk2rVakU/+J4?=
 =?iso-8859-1?Q?Fu4hTo9iriZyz8r1hu6+/G5UrYJtqXUWUkrbB+B7W0wlZAcnCRTWOwCQeh?=
 =?iso-8859-1?Q?8TQz2rI3x+GzgXg4AmC6+qb8ztE7nxxYL15eR10hwDnusoNLJ2uyxFZTbD?=
 =?iso-8859-1?Q?pLnI2wPTKAmGi+MTG2w0j9lFbDvdAJpOmma7NE3c2QmrvnQpbtb5uUM8zJ?=
 =?iso-8859-1?Q?zDveneu74gvVqU/f4Gc5luM2NZlgaUKn4NSvoTsruPxIAg4VeUk1hDuzrt?=
 =?iso-8859-1?Q?PJVabMDe6fz0y2P4DJvpfof6uUdXOPsGoYzz4WU2HKvBBvfadcN8MZUl7X?=
 =?iso-8859-1?Q?0WGjMyLD5qDeXpsnqZ5vuvBG/5h00Su83ZBJ0zvBiScT9v5w3s+q+Ak5Dv?=
 =?iso-8859-1?Q?+yTasBavaX+h4Vff7YJ+mguHg5KRVdA4+HcQY1pBzL62sYW66Ct+QJwOO3?=
 =?iso-8859-1?Q?RXU76MTZGcmX/WyUQIpME3KDV1AOkmT2Y4RKWL3SIQQDa8frgvjOc0lQXf?=
 =?iso-8859-1?Q?dCtkic1LaosDxr6N86mVF8f3EwOZ9DDEk3k+jtU2iLsA+WNee7dF87/5Wi?=
 =?iso-8859-1?Q?udbDrVqfyulsbS65pMUBmszZRArah3dzUToLOj32NHObxpQ8AlhZAPPdxK?=
 =?iso-8859-1?Q?BHluXBosi4xHX+Ys69z0Z53V45JjbA8R5EDzY3WjFM65B8QP1oaYyHPhld?=
 =?iso-8859-1?Q?DjWRTJEdCQhXxez0gjqX5tLy2T0mglKrQ6YpXk2AcvFnv7HVMWY1uS0KY3?=
 =?iso-8859-1?Q?xbs4G9E7nffqQK13maPl9UOUeRHnApjD6oeOUU0dd3Lm66d59PrJsQgo9c?=
 =?iso-8859-1?Q?RTsSXyF1OqiASrbW1BdOK/wnf+kerPOJArt8sSZ/xbWlEiVH3CimT+h64H?=
 =?iso-8859-1?Q?kur5vd43BH9TxNa1m60flwDRjt/LVoiq6quvRSA2+65hf+W6Ppir7g6zcB?=
 =?iso-8859-1?Q?xfNmLKHZqb1+TtfuwBvsCllEMbktHhcIO9vBLgxcXEAWaYVf8n0450W7es?=
 =?iso-8859-1?Q?q4QcRPVzg6aVd2P7VJWjWOZVt+rgLogME0PIOuj7qLtmaHFWaiCB7s7sk+?=
 =?iso-8859-1?Q?9ZEV27IIFs1bvpIvQwXenDKwTSiJIkxoiAAqjoyQ2hPHbnBb2FRxhlBqL0?=
 =?iso-8859-1?Q?ZFuX6e6oqApnvcQpZOT9MtTg4qwjJZDcH4bNEI6bht3oIE11VlaRfyO9ZT?=
 =?iso-8859-1?Q?Wi8lQBnytJ/sNPQWi9sbjw+YesGtZBKusWP77YBb0IaC9wLLULULRfNZ98?=
 =?iso-8859-1?Q?01A0IAcrJDhCniTxP5jGgwc3inuTFLaOyZR/VM+iiCodNZXvAU8B+Qzn6T?=
 =?iso-8859-1?Q?D0SWvkc7t/Q23qx3i8rm1/NHC06Ss+76mMh7uyH8OmPjusyg71pdeuTMU+?=
 =?iso-8859-1?Q?xg95zRSdLEFSD4Vk8ZUcvT2iF6YYfFJ/r29c/HFN06cogBfmSs33gv6sCH?=
 =?iso-8859-1?Q?+dEGrRPeFtUhd3GoScv5v4bzhU/jRJqy1L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead99ee8-cb79-44b5-a425-08dd87267d09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 14:02:33.4560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMItpWJxTHiYfFYmj3Ra4Bv4IOL53guQe45zkSMc90xqYTEPD7wk2QGhzUvAKJ9Ng++zMWYu18GWn/qUvRUaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

On Tue, Apr 29, 2025 at 03:50:25PM +0200, Christian König wrote:
> On 4/29/25 12:29, Huang Rui wrote:
> > APU doesn't have second IH ring, so re-routing action here is a no-op.
> > It will take a lot of time to wait timeout from PSP during the
> > initialization. So remove the function in psp v12.
> 
> 
> Not 100% sure, but I think this code is also used for non APUs.
> 
> So we need to keep it around, just don't try to re-route faults to the second IH ring on APUs.

Yes, psp v12 is only for APUs like Renoir and related APU kicker and won't
be applied to dGPU. I think we should make series to modify these series to
update re-routing into dGPUs next step.

Thanks,
Ray

> 
> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 34 --------------------------
> >  1 file changed, 34 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > index 6331941440d9..ed24f61e1ab8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> > @@ -34,9 +34,6 @@
> >  #include "sdma0/sdma0_4_0_offset.h"
> >  #include "nbio/nbio_7_4_offset.h"
> >  
> > -#include "oss/osssys_4_0_offset.h"
> > -#include "oss/osssys_4_0_sh_mask.h"
> > -
> >  MODULE_FIRMWARE("amdgpu/renoir_asd.bin");
> >  MODULE_FIRMWARE("amdgpu/renoir_ta.bin");
> >  MODULE_FIRMWARE("amdgpu/green_sardine_asd.bin");
> > @@ -142,35 +139,6 @@ static int psp_v12_0_bootloader_load_sos(struct psp_context *psp)
> >  	return ret;
> >  }
> >  
> > -static void psp_v12_0_reroute_ih(struct psp_context *psp)
> > -{
> > -	struct amdgpu_device *adev = psp->adev;
> > -	uint32_t tmp;
> > -
> > -	/* Change IH ring for VMC */
> > -	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1244b);
> > -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
> > -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> > -
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 3);
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
> > -
> > -	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> > -		     0x80000000, 0x8000FFFF, false);
> > -
> > -	/* Change IH ring for UMC */
> > -	tmp = REG_SET_FIELD(0, IH_CLIENT_CFG_DATA, CREDIT_RETURN_ADDR, 0x1216b);
> > -	tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> > -
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, 4);
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, tmp);
> > -	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GBR_IH_SET);
> > -
> > -	psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
> > -		     0x80000000, 0x8000FFFF, false);
> > -}
> > -
> >  static int psp_v12_0_ring_create(struct psp_context *psp,
> >  				enum psp_ring_type ring_type)
> >  {
> > @@ -179,8 +147,6 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
> >  	struct psp_ring *ring = &psp->km_ring;
> >  	struct amdgpu_device *adev = psp->adev;
> >  
> > -	psp_v12_0_reroute_ih(psp);
> > -
> >  	if (amdgpu_sriov_vf(psp->adev)) {
> >  		/* Write low address of the ring to C2PMSG_102 */
> >  		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
> 
