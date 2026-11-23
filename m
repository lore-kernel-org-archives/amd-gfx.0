Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A99606A320
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QdXuzreY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265F410E09F;
	Mon, 23 Nov 2026 05:46:25 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFAC10E09F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 05:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw5ohMItBCFYE2OZAsi9oqufa5+VfiTb66rDm5gg9uMxcIPVFUpvFucvoQMMkgte+WnUE8/9kb5Bv2yUnJ1M8By+yHlLCdoBhR7Y+0HYbrFH8GYozzIjv0BvMJACiJ44pVHR2UV6bu/ZbH1uHhZDEA9yJ+yTEypNau2RIaiFBSz8kwFaxuS/2JhP/RjC5gFEwM24VMWOOIiM/wcrRdLdTU0gOL+KgQfi4Un6UGjB1umXspGc+QK1xGEGBdYZr6iFaAA3AUu0CCWEXJiHZbX3WeHXPnCAnjRBmyH6FRHWCgvYftLB5vAicns8qVrmDpGTyolbh2i1cb2WQ6p0Fq0ezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3/PDgh+knN4P0/p/p688ZDcNaWHpjGWBTXcQEj4tN0=;
 b=Cv1m9yvcESsvSYG/khPzaYkQufQBv9DMFBm3Je2yY+3L/8Hwla2ctS3aEHK+oG6aI/PZypj+2BRv3H0S5k0v4diqnNzkR1mwZp3Q1OKaH6yluWH61+1hEwKwEpdipr/SAbSd55Q/vBvpuw70T5zuSlO/iKpPMlF1pSi8qjAK+Jg0z61ETaHKlhyhvM6uD6Q6NKVlYDK4Lwfvsxk6ibfrnYu3Z9LGt9XHBO/fpIuzuqD2jQSuUHN+KXA0PC83aOgdkyWwA1EBHBGcT6iyrpgnulIslWcGb4OmXN1Kcv8Ig4eysp0DACX+U4aczloQ8YUJa7fp2IHj+qO+G4lfcMA0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3/PDgh+knN4P0/p/p688ZDcNaWHpjGWBTXcQEj4tN0=;
 b=QdXuzreYosx3+HFEwPT4UvhqrbuClIthv0Ioyo1yIRbgXW1AoPZdHNE48glYLeuOWu9LexDYQI9Wpw3xcnEmpnAZ6RRKvb5Rnou2jvrjMQmSCvmtULdpbmtCPSvop8eu0zfPRRRM+3R8gdh5lUbxLbCqCx9+2NxZXXPEg5hPhN0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 05:46:15 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 05:46:15 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?iso-8859-1?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v4 09/13] drm/amdgpu/gfx12: add a gfx engine soft reset
Thread-Topic: [PATCH v4 09/13] drm/amdgpu/gfx12: add a gfx engine soft reset
Thread-Index: AQHdbNK67dcEVyDHwUi361aGsHrUKbc1XIqAgAW+2vA=
Date: Mon, 23 Nov 2026 05:46:15 +0000
Message-ID: <DM4PR12MB5152DFE2108D0B345EEC38F9E3452@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-9-Jesse.Zhang@amd.com>
 <7f108e1161bc2825a5d8f542ee3b7c8b6cabf399.camel@gmail.com>
In-Reply-To: <7f108e1161bc2825a5d8f542ee3b7c8b6cabf399.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-23T03:27:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|PH7PR12MB6809:EE_
x-ms-office365-filtering-correlation-id: 788bfc6b-d5e2-4cca-435b-08df492516b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003|261102123227099003|261021123027099003|261022105027099003|261026140227099003|261021121427099003|261028144727099003|261022075727099003|261009223027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: ghJ22I+A2VyMvK6ePNUckUlUH7frzCE/W7tjB/zcr9Ig04ChwbhVWMz8aCvK5rYN9NK2ueaRes3aruYNakT7qoO0z1I5mBdj4ccMAdIN9d9pdOfqPY02VgLxMCAEK9AzDviukHoI6YQ1ODEXU6D4o8zDDBuLdnomblbOKPs2Xs7HYtu1veH2xi1i4nZoZrIvxhvqN0mnxf5sc/mk4y9rg/Uy2JOqvkhal/hf66clQi0CG/gyGYud6ypxnZrj88NPfTrleo3MAbdhj/YFeawRFmwp57qMWFZEgFfXJIxumzKo39c2+d4nlYBpfOF2uU14ewhmoRsbpKBUanq27xEW4UeFImFm0CLzaaSS69tMlq7mx0QaCrdc0Pa5hwOZOH3mDyh4oWwICJgO8Koo9hbKr6tZ2+KYrt9RQzEV736J3Fmbjm0BZs+3w3seyCqEg3zsmpfxS8Uu+ODo4yXUDVnwqQjYoF6nTUKwYXqdkH291suMzhPORr0pftqlOlxDkXJq0zF6UceD56F4hJdHqEg0qmNAEopxBuplHpLnNXnXkv8c1A/BH5Jt0VOUNEQsxT1RpXu0sa7d7ByD50Heo1KCbnV/kXq3989D5CYYgZx3UDzdImXXXTFVQIZ8Kn7L1OO4uknSaHoEYJHE81DOgXlbcL0+YvlD1Iqxfgigx3lAa7izb+0Z0Q/fqyo9EG94jKZZwbFPo1aY1MwOYWFzRJaPzhupS8lC/lDVpPDTZVHDh6g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003)(261102123227099003)(261021123027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022075727099003)(261009223027099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rw4hqT7dGTMuShUV5xhS5oemJz1PSeH7+K7YHtvk/De6EjVPm5hKkmtkzK?=
 =?iso-8859-1?Q?F/WP9b2w1loxd2snx7zO5RZChxVXJUFAZCOz9RSoG5/fIseyxHLAjZHuE/?=
 =?iso-8859-1?Q?FmeWRsiJ6AxF3viC6HaTbkXij4UQuA66nns/zaLNw8RrEoZeGUpX/dDR6J?=
 =?iso-8859-1?Q?0JEfxiSXelgfAUFT/K5SM8xABVKghQbsWX+OXea03aPPnQcmoES3pYPF97?=
 =?iso-8859-1?Q?4eXHbvP4GPUhq9kwvvYutCfj8rfN6NPgTi+1NvasD1s1CS7SLXs5ao7zET?=
 =?iso-8859-1?Q?Y3R1HpGORj3+VYli3wnDFAfw9CrlXg4DFQVLICEzLTDrTDobFWrVkdmaLf?=
 =?iso-8859-1?Q?eWPV4zBfiAKzFyCoAO2UWksnEoiy12+r0/2JXsyue7CeKFu+dnBnqXwKGu?=
 =?iso-8859-1?Q?gT3M6WUWXIfkJvObBfAO7/FRUSs+o85Id92cnZeQZvCMpujTCZg4ppWNOY?=
 =?iso-8859-1?Q?KATe08q8f3QFCjM5zx9RqAkrB+lpqTJJsQFIfIOxsgJRB6tedgidAfOKaH?=
 =?iso-8859-1?Q?iCjDx2mMrBuvPB3bBkqcf4OE/nUJyyRrnf5itpUMDKy3pc++6VnUMVHeDE?=
 =?iso-8859-1?Q?CsrWjyp2Kx1kxmNU1ZOxvR4Xkw8OMZUTRyGmWRN9xajcDVwa3z0Wu2P14H?=
 =?iso-8859-1?Q?mEmCSefJEHmYK6QFmGMlAo/f8EcW1M9zeYiya5Z9FOIvnOAMaCCxP9S0Vl?=
 =?iso-8859-1?Q?BAvapdg3UFywMPVhnQ+djeUONtXLastCNuhtLVSCzy5eFm31mOD/nqn/tw?=
 =?iso-8859-1?Q?mToF6k/14OUaE6a6lGE9sBq2ays7qYlupHv0rl6+uwu86Rq1UW/kRwjTxe?=
 =?iso-8859-1?Q?F0upTEgF+/AKeTsp9fRVgsw8hSMgvpGcW8BTXzE7xLKIEHORJ1IuySzy/d?=
 =?iso-8859-1?Q?dp1EY5t+NCTuJ5gRCIzMRuVqrFz/NfUsp0/DQ4jv/eMcaqWp7I+61M5rI8?=
 =?iso-8859-1?Q?N2XjwAGZ7/Od2Ou4fzbuw5TPfUk4GVUMrzyMeO91jniM8ymUffxNom9buY?=
 =?iso-8859-1?Q?ZD7iJFbbd04B+a7ZGO3n01UU3i4GlHQe89UXZHT4q6cRNQzBdEpFgxUSeG?=
 =?iso-8859-1?Q?HTsCoNBmvg9N7KTOT9Lrgb3AKyCylpf4uffgwrDFh0dacn60Xa2ozlIRix?=
 =?iso-8859-1?Q?TMk537LUrMixRi14CbqLGI3vxvgTQURs7Z+ULVH7C8UgTdiAB4MZX6lxRc?=
 =?iso-8859-1?Q?STnh9E9IZ4uYDBryvqRQ9TSUuTI8OefJdZY7+y4H+6e3d/FZizz+37tARo?=
 =?iso-8859-1?Q?87zYWTayWr3onwgQn16OzV6v/B/Mxsqt9W+O8uqYz5aFn6wzgjaATNfCC8?=
 =?iso-8859-1?Q?8HGPOMP5tEJgc8k3XTzUqnOsS9XCTcEQx4SM+z3HW2QVhoKM11dblc4Ffu?=
 =?iso-8859-1?Q?GlLSAuQSmVY3cpAxeETVUZhIVeM8XT4k0INKqT11z1i7JqqQryc5rYHazl?=
 =?iso-8859-1?Q?6X9cD2Vz7n+uJlp+dipqEwIR9H8XqJHaRQBJnYq0wFOQaC094LCyR94aWC?=
 =?iso-8859-1?Q?UjB+WWOlM2s/WbOkxHqEM1VpyHQOHySxwEcfF+Csp1mKXobcTxJElxKEVa?=
 =?iso-8859-1?Q?PHrU/lczLwI3iZlDhF4zg5LInLLWYu27sD/4NdB9DebbtzDUt7BtoHwrvJ?=
 =?iso-8859-1?Q?8lN01GtY64enNYiwrWe5KC4lO2E2VuAuRTO/cP/kRjdhGFACKwBs0OH07C?=
 =?iso-8859-1?Q?Th5C1fP+NUnzZiozyD/1hXCrxsYbS7klUnfzDhV4q2YGqimkkRZ38Xyjai?=
 =?iso-8859-1?Q?ijRUXMA6g6eeOuN4BJzcFbzYMxuZKKHaIFmFpS/Kbu+OLq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788bfc6b-d5e2-4cca-435b-08df492516b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 05:46:15.2758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nUfji65nvKBvATCF8arN/JX57UpQccXAhI9F7vJswi6qvyT4mb+CWhi2A9ha58HpVN9zpTmDNPo2pVGN48dyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Timur Krist=F3f <timur.kristof@gmail.com>
> Sent: Thursday, November 19, 2026 7:43 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> Subject: Re: [PATCH v4 09/13] drm/amdgpu/gfx12: add a gfx engine soft res=
et
>
> On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> > Some hangs leave the gfx streaming engine of the CP front-end stuck,
> > eg.
> > waiting for packet data that never arrives. Neither a queue nor a pipe
> > reset can stop it, so they end in a full GPU reset.
> >
> > Implement soft_reset_engine() for the graphics engine: halt PFP/ME,
> > pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG with
> > CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and GFX_HQD_REG_RESET,
> restart
> > PFP/ME and map the kernel gfx queue again.
> > MEC, MES and the compute queues keep running. The MES lock is held
> > across the pulse, as MES fetches its queues through CPF, and the CP
> > DMA is drained around it, as a request in flight leaves the ME busy.
> >
> > MES is suspended meanwhile, and the gfx user queues the reset clears
> > are saved and restored around it. If the CP doesn't go idle, the reset
> > fails and a full reset follows.
> >
> > v4: Implement soft_reset_engine() directly instead of a reset_engine
> > gfx
> >     callback (Timur).
> >
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 129
> > +++++++++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > index 484e876fe235..8b96f2a29b1f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -3860,6 +3860,134 @@ static int gfx_v12_0_wait_for_idle(struct
> > amdgpu_ip_block *ip_block)
> >     return -ETIMEDOUT;
> >  }
> >
> > +/* The CP DMA and the interfaces its memory requests go through */
> > +#define GFX12_CP_STAT_MEM_BUSY
>       (CP_STAT__DMA_BUSY_MASK | \
> > +                            CP_STAT__TCIU_BUSY_MASK | \
> > +                            CP_STAT__RCIU_BUSY_MASK | \
> > +                            CP_STAT__UTCL2IU_BUSY_MASK)
> > +
> > +/* Reset CPF/CPG, PFP/ME and the gfx HQDs, then boot PFP/ME again.
> > */
> > +static int gfx_v12_0_soft_reset_gfx_cp(struct amdgpu_device *adev) {
> > +   u32 tmp, cntl, me_cntl, ib_control;
> > +   int i;
> > +
> > +   amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > +   /* MES fetches its queues through CPF: keep it out of the
> > reset. */
> > +   amdgpu_mes_lock(&adev->mes);
> > +
> > +   me_cntl =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > +   ib_control =3D RREG32_SOC15(GC, 0,
> > regCP_PFP_IB_CONTROL);      /* cleared by the reset */
> > +
> > +   tmp =3D REG_SET_FIELD(me_cntl, CP_ME_CNTL, ME_HALT, 1);
> > +   tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 1);
> > +   WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > +   udelay(50);
> > +
> > +   /* A CP DMA in flight during the reset leaves the ME busy
> > after it. */
> > +   for (i =3D 0; i < adev->usec_timeout; i++) {
> > +           if (!(RREG32_SOC15(GC, 0, regCP_STAT) &
> > GFX12_CP_STAT_MEM_BUSY))
> > +                   break;
> > +           udelay(1);
> > +   }
> > +
> > +   /* GFX_ONLY keeps compute and MES out; CPF alone leaves the
> > stream stuck. */
> > +   cntl =3D RREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL);
> > +   tmp =3D REG_SET_FIELD(cntl, CP_SOFT_RESET_CNTL,
> > GFX_ONLY_SOFT_RESET, 1);
> > +   tmp =3D REG_SET_FIELD(tmp, CP_SOFT_RESET_CNTL,
> > GFX_HQD_REG_RESET, 1);
> > +   WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, tmp);
> > +
> > +   tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> > +   tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF,
> > 1);
> > +   tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG,
> > 1);
>
> I still think that this needs the SOFT_RESET_GFX bit too.
>
>
> > +   WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> > +   tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
>
> This should be moved below the delay.
>
> > +   udelay(50);
> > +   tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPF,
> > 0);
> > +   tmp =3D REG_SET_FIELD(tmp, GRBM_SOFT_RESET, SOFT_RESET_CPG,
> > 0);
> > +   WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
> > +   tmp =3D RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
> > +
> > +   WREG32_SOC15(GC, 0, regCP_SOFT_RESET_CNTL, cntl);
> > +
> > +   /* The halted PFP stays busy: only wait for the memory
> > requests. */
> > +   for (i =3D 0; i < adev->usec_timeout; i++) {
> > +           if (!(RREG32_SOC15(GC, 0, regCP_STAT) &
> > GFX12_CP_STAT_MEM_BUSY))
> > +                   break;
> > +           udelay(1);
> > +   }
> > +   amdgpu_mes_unlock(&adev->mes);
>
> We should clear the CP_VMID_RESET register here, same as we do on GFX11.
> It makes no sense for the CP to be doing a VMID reset while we are soft-
> resetting it.
Agreed, Thanks Timer and will update it.
>
> > +
> > +   gfx_v12_0_set_pfp_ucode_start_addr(adev);
> > +   gfx_v12_0_set_me_ucode_start_addr(adev);
> > +   tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > +   tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, CE_HALT,
> > +                       REG_GET_FIELD(me_cntl, CP_ME_CNTL,
> > CE_HALT));
> > +   WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > +   WREG32_SOC15(GC, 0, regCP_PFP_IB_CONTROL, ib_control);
>
> Why is it important to restore the CP_PFP_IB_CONTROL register?
> The kernel driver currently never writes this register, isn't the default=
 value
> good enough?
It isn't needed. Will  drops it.

Thanks
Jesse

>
> > +   amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > +
> > +   tmp =3D RREG32_SOC15(GC, 0, regCP_ME_CNTL);
> > +   tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, ME_HALT, 0);
> > +   tmp =3D REG_SET_FIELD(tmp, CP_ME_CNTL, PFP_HALT, 0);
> > +   WREG32_SOC15(GC, 0, regCP_ME_CNTL, tmp);
> > +   for (i =3D 0; i < adev->usec_timeout; i++) {
> > +           if (!RREG32_SOC15(GC, 0, regCP_STAT))
> > +                   return 0;
> > +           udelay(1);
> > +   }
> > +   return -ETIMEDOUT;
> > +}
> > +
> > +static int gfx_v12_0_soft_reset_engine(struct amdgpu_ip_block
> > *ip_block,
> > +                                  enum amdgpu_ring_type
> > ring_type,
> > +                                  struct amdgpu_usermode_queue
> > *guilty_queue)
> > +{
> > +   struct amdgpu_device *adev =3D ip_block->adev;
> > +   int i, r;
> > +
> > +   if (ring_type !=3D AMDGPU_RING_TYPE_GFX)
> > +           return -EOPNOTSUPP;
> > +
> > +   mutex_lock(&adev->gfx.mec.reset_mutex);
> > +   amdgpu_gfx_off_ctrl(adev, false);
> > +
> > +   /* A hung gfx stream can keep MES from suspending: reset
> > anyway. */
> > +   amdgpu_mes_suspend(adev, 0);
> > +   amdgpu_userq_save_hqds(adev, AMDGPU_HW_IP_GFX);
> > +
> > +   r =3D gfx_v12_0_soft_reset_gfx_cp(adev);
> > +   if (r) {
> > +           dev_err(adev->dev, "gfx CP still busy after reset,
> > CP_STAT 0x%08x\n",
> > +                   RREG32_SOC15(GC, 0, regCP_STAT));
> > +           goto fail;
> > +   }
> > +
> > +   /* The reset cleared the HQD of the kernel gfx queue: map it
> > again. */
> > +   r =3D amdgpu_gfx_disable_kgq(adev, 0);
> > +   if (r)
> > +           goto fail;
> > +   for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> > +           amdgpu_gfx_mqd_reset_restore(&adev-
> > >gfx.gfx_ring[i]);
> > +   r =3D amdgpu_gfx_enable_kgq(adev, 0);
> > +   if (!r)
> > +           r =3D gfx_v12_0_cp_gfx_start(adev);
> > +   if (r)
> > +           goto fail;
> > +
> > +   amdgpu_userq_restore_hqds(adev, AMDGPU_HW_IP_GFX,
> > guilty_queue);
> > +   r =3D amdgpu_mes_resume(adev, 0);
> > +   goto out;
> > +
> > +fail:
> > +   amdgpu_userq_clear_hqds(adev, AMDGPU_HW_IP_GFX);
> > +   amdgpu_mes_resume(adev, 0);
> > +out:
> > +   amdgpu_gfx_off_ctrl(adev, true);
> > +   mutex_unlock(&adev->gfx.mec.reset_mutex);
> > +   return r;
> > +}
> > +
> >  #define GFX12_HPD_QUEUE_STATE_CONNECTED_MIN        3
> >  #define GFX12_HPD_QUEUE_STATE_CONNECTED_MAX        15
> >
> > @@ -5375,6 +5503,7 @@ static const struct amd_ip_funcs
> > gfx_v12_0_ip_funcs =3D {
> >     .suspend =3D gfx_v12_0_suspend,
> >     .resume =3D gfx_v12_0_resume,
> >     .wait_for_idle =3D gfx_v12_0_wait_for_idle,
> > +   .soft_reset_engine =3D gfx_v12_0_soft_reset_engine,
> >     .set_clockgating_state =3D gfx_v12_0_set_clockgating_state,
> >     .set_powergating_state =3D gfx_v12_0_set_powergating_state,
> >     .get_clockgating_state =3D gfx_v12_0_get_clockgating_state,
