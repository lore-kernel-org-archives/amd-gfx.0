Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A9606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dwtuMDQw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4488D10F2EF;
	Tue, 27 Oct 2026 09:19:52 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E612510E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 09:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg5oeD6mBbe8IO+tgg1nD8TcfeJyOGZtJBZaNFXCKahbxEJqZeVtJcsHFeMLVQPvXKVjCKLJAUvW4pI8ObBHVB9yfMLMk4jk/R/mfNn3wM3hFZ4I5cGV8prcE2uLmAh/A+Uzs6jRMPk+Minuk8QSwE3Eatf2ntXjmZbpVgk9NKgt5YRtmPcpkHplwxEWRGBd8uC9YvmNUPshxV8vD5U9UNee6vvRtAgmXpKq7IgPzMR4YP0d4tQTZ4o7ZWVEhnrtzxaoN81g+QmMzQMow8rvXM0u6ojPQxwKDC/sjDBsprQ2crjSu67K15B7vhjRDv8O086HLf2T+/qGNSDqCNfA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEF3AGNpCpFhPcVFLIqbXIkVRyRNFQQqvD2X+M/Vimg=;
 b=lyBBiUydagkerDqAEr7ozhJGWN18QoSgzYXCzEgu+96fBTBtp1ahSZXzrDsFedamzSIXJ+KwhqJdCIyw5LJq/kQJ2KTo7uMoYNIHx9cS8PdE5B+vYqL//FYDDEI1gwwMgJHntfpwZ3Y0Mwm2rEA3ebcdrqKKEC1U/F6uyJdxQwWBPpHC7cdu9z6FHsFhd4IP+ZoWcc4TT+sNBKhuJbMlVLiq24+gndA44UGPNw/Uk+iys86lCmXzNDR+O51+wwzSz7xeJ3RKPefLznVTbJ7JNQc+Wy3oJIfG33Ov7BDfjX/qQMj+A4268qVbZz2SyLf7kJ62LzAiIWDj4PsdfVO5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEF3AGNpCpFhPcVFLIqbXIkVRyRNFQQqvD2X+M/Vimg=;
 b=dwtuMDQwCNHn2Yci/RPYAsYZpmomvdfCD59B5CtPQwA0ezGG6Ot2wughurrBLW5D0U4/7KEx4fgNA2lW8/QHDa2pnjJR81mLBXA4/z+L+RX+SNwtz9PkelBwUq1c05LyeGPqKFtoS6//ooyu8N6spxptV534uDoRQTP+ePAGdVo=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH1PPFF9270C127.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:19:41 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:19:41 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: =?iso-8859-2?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, Mario Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, 
 Manu" <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v2 03/15] drm/amdgpu/gfx11: add a gfx engine reset
Thread-Topic: [PATCH v2 03/15] drm/amdgpu/gfx11: add a gfx engine reset
Thread-Index: AQHdYf4xfthUs358oU++pQZvoOJxNLcOg14AgAEB1NCAAQCKAIAAeGpQ
Date: Tue, 27 Oct 2026 09:19:41 +0000
Message-ID: <DM4PR12MB51527687E313AAB37E9452FAE3602@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
 <20261022082011.331462-3-Jesse.Zhang@amd.com>
 <uwzBcRnwS66upuRrx7Ywcw@gmail.com>
 <DM4PR12MB515270DDDF3DA61E1CAF739FE3612@DM4PR12MB5152.namprd12.prod.outlook.com>
 <62012beac646bf55f09efc83c1b402077e90d982.camel@gmail.com>
In-Reply-To: <62012beac646bf55f09efc83c1b402077e90d982.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T07:02:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH1PPFF9270C127:EE_
x-ms-office365-filtering-correlation-id: db7157cc-725e-4130-5eb5-08df340b6e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|10067099003|261021121427099003|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: WvbInONMDEMmYTkswRph/2oKjlFIwIRqQ8VpBrpt78MlNYVaHQ2/NlkcBw/moTruO3196/5ihKW2ywe+kST6hRCAAIXszWz8x3hnB2vt4Cs/UEPdgro8oPrml+ZNv6l6nRaXLQqsxcrs895+oz11x6C/Rxko6S8et3hmLkt4S+nDPHnA2bsDLx0ebKLoMfG4JjfTXcoxkVykXrp7/R0B1DWq8eWx67+Q5Wtp+3sBpsgaG3kIsKcrfuOPcv9y+AXHSheqsAvJrN/s+WsDjQS0GLcJx2YPxApSPKnUljo7QeJKTnzh7fx/y0TjdYrpsmqKJJWi4Siv1X+8jBKvIjtKe1VgJjbs8LPHd3gGHyQ7t38Bu0ULC6n2uxAcj6t5ksTh29cVD9tu+mnZ0+cQPOpczLop/vLtV5nK5v2E553g3DRc31dxKIVfmOm611CREHH/2sc/Mjw0YUFy590urcIxVrFLCe4wb9tSPFmvVZbQRN9pF7XX5AA0yXU5LLV1+A0MLjzlVpuFT83ZtceMbQRGWW00dtIaB9mKJkk7gACqag4kylk1VL9KEeEn/yE+mK17WG2Z9y5mlIBTqcZlW6PJmVtMHZoQ+HBg529mrErz9y4cjt0j5aSiE8kU55xKjTmD/xgERWzhKj9YKjKdWy+SfRyomC9xz+T+b/nDnqeEtZLmfg/709R1k7y81hg+ckQR2+MpLIpSMwi7ydVtzIaYZ03nycN3jlWxxWlkdBT3Nv4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(10067099003)(261021121427099003)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?cQkrQYRlDXRW7Kf5KviQmi6Zo27miDs6jEbXO3q5xUtOCr64Nw17cpyYJq?=
 =?iso-8859-2?Q?gHB7Wl5uF8pqhhP7rJvBN76CAaE7t67yecYXQCIEi20xT90Cd/Hn7BTpN+?=
 =?iso-8859-2?Q?SmlB0rly1E3zAyYSCYPSXeKBnNjVcLrKg+cLNn6jKcOO66Z/biQ9X02XrN?=
 =?iso-8859-2?Q?CL4xY9B6RhZ94izg5ZCebhrpEuwZ6eEqTGbt356P4MQGdV7LZPqe5hovyj?=
 =?iso-8859-2?Q?RNZWQQlFmQnPFuTDpHABvAkTdPPlZ2uHRuCFlgN4CWlhZLUDfUiNVYUiWh?=
 =?iso-8859-2?Q?xaRtoq60PoAuA4QvHe9p0Wr5jOcFKET2p0BZmsM1WDuVyjKBlRjp1HgUxo?=
 =?iso-8859-2?Q?HcIKiXo0R/MhNgqRfGkUvLg3+6+1mhJp3Xu49wdatqTfYmuno1JWbEoo/p?=
 =?iso-8859-2?Q?rwrPkzYYsn8yc+NSYmrnov1LIAQ27pLD04jjXDyYnLdv+0xqgmLRDoxBkI?=
 =?iso-8859-2?Q?3SPoyXd2iGPpyYphy6lPOU36lTbHHg47hmklK3c7gNe/uaysaMibOShU0V?=
 =?iso-8859-2?Q?Xz6+DuvEQEV7mxBEMHi8J0z7QB2xv1LTzZD8HKaAd1C+SBnQN2tEv2koUs?=
 =?iso-8859-2?Q?F7fl32x85i8Zr+ZIPEsMLblFlsbyjFUH7NZTzw8sP32RC4ytlnvVhDMkYV?=
 =?iso-8859-2?Q?lDSDlyszdGxjgTEiCOMi8UGvmn2L9z9L1PDGYABF/L3a2IHKnh+bsZdKdF?=
 =?iso-8859-2?Q?bsgwrKyehHJtZ6exFtfbApZv13u77PexYtRWY2hxU/ljfB9NuWJ8UHURi8?=
 =?iso-8859-2?Q?kjIKRlaPxvDGCR0+rm+4DzfSFt+qawWqhElUfr+oDka9Xxy3NmSNBLutVn?=
 =?iso-8859-2?Q?NWr8OidyxRD9eMG1n993QQek1VStp6L8USCdKGjWayyZp1Ul7d+LvrR6ah?=
 =?iso-8859-2?Q?RG7VH0M7TpPLaJmYRCCJjLwmHyNBxd6RRbBuEbSaBGjtbfyl62gceo31b7?=
 =?iso-8859-2?Q?Pn4/fiJTKENguoUR0uMDEBCvXsvdg2upOheBbBA9pdZxA1Ad9QIay1097R?=
 =?iso-8859-2?Q?1HFNdOz9GZkcex37Vo/mV74NipV9dpMj5R1AYyaUeu74K83nTauGESvIHO?=
 =?iso-8859-2?Q?d4s/dFtBVx76r7h64EC2ErdyLKrlELVzgWizDL+h2/I7HWQrozUGzV6s87?=
 =?iso-8859-2?Q?+hR/eepFCYdd81+ilp12uX974dou0xr6Ig/b59IVcb49iz9vzqe6LjU/xC?=
 =?iso-8859-2?Q?6bX9N2RsQJpqloH3AxYg73d0pNThunHsKjzBnLY24adeTmd6148MjSEUxn?=
 =?iso-8859-2?Q?gH77JiYkWMN8q28X7yyTVdrFb3FqG0bFeWLWjk6slz+JL/BbR96MlzE0x5?=
 =?iso-8859-2?Q?36amjuOaGiRr2cpkt7VWBtupwOkSI3gQLq/Q5lwpZmk2dm9ODllO7yHkRv?=
 =?iso-8859-2?Q?U2ZrZad2OCAImLNgPfsTMR2wVGM9VFsM9e1bEK2xRiSgoZPXtZSeA9/0uT?=
 =?iso-8859-2?Q?oodZnOcD2+dZx8WSSVBJEEbiVU1n3K0nH7+abzIS2OB2mRPNFNQdXQxL4h?=
 =?iso-8859-2?Q?xKo9p5EBSnorEusW8+rvxApEdgG7cl/AJ3XHuMoW42uItlz7hWrdkvYufb?=
 =?iso-8859-2?Q?8gi0IEoD+8fMgDzLfEm1MEMwGBrOvVi1V8WB6QO2E8dHetKZoUpo/VzvDE?=
 =?iso-8859-2?Q?riM1eFRfgqxymKzsDrBwF/b5yLRarj+TlEw6zeW7ZIp0x71kv278Yow8AV?=
 =?iso-8859-2?Q?hS8dwaf8D4339CEzkyIscRwxzVmchp8Qn1gqoppKBAEUariA6aYouNoXay?=
 =?iso-8859-2?Q?qDgeJJLf20iDxUih1e5KnfKFaWMgeJ3iPiCyRCFLqohQ8T?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7157cc-725e-4130-5eb5-08df340b6e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 09:19:41.1256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5TLViprSs1Uvs+8YfjUm1UKItSP8M+Yd3G4nH/aVoizXiajwCP12AJ6BV4WIuMGPsvJa9F6g7JmjChl004fuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF9270C127
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: Timur Krist=F3f <timur.kristof@gmail.com>
> Sent: Tuesday, October 27, 2026 7:51 AM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> Subject: Re: [PATCH v2 03/15] drm/amdgpu/gfx11: add a gfx engine reset
>
> On Mon, 2026-10-26 at 08:35 +0000, Zhang, Jesse(Jie) wrote:
> > >
> > > On 2026. okt=F3ber 22., cs=FCt=F6rt=F6k 10:19:43 k=F6z=E9p-eur=F3pai =
t=E9li id=F5
> > > Jesse Zhang
> > > wrote:
> > > > Implement the reset_engine callback for the graphics engine of
> > > > gfx11, as for gfx12:
> > > > - halt PFP/ME and wait for the memory requests of the CP DMA to
> > > > complete;
> > > > - with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and
> > > GFX_HQD_REG_RESET set,
> > > >   pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock,
> > > > and
> > > >   wait for the memory requests again;
> > > > - clear CP_VMID_RESET;
> > > > - restart PFP/ME from the start of their RS64 firmware and restore
> > > >   CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the
> > > > reset so
> > > >   that a full reset follows;
> > > > - remap the kernel gfx queue through MES from its MQD backup and
> > > > restart
> > > >   it with gfx_v11_0_cp_gfx_start().
> > > >
> > > > MES resets a gfx queue by writing CP_VMID_RESET, which the PFP
> > > > handles.
> > > > When the PFP hung, eg. on a bad opcode, the request stays pending
> > > > across the CPF/CPG reset, and the restarted PFP then waits on it
> > > > forever for queues the reset already cleared.
> > > >
> > > > gfx11 has no helper to restart PFP/ME from their start addresses
> > > > outside of the firmware load: add one. A later patch enables the
> > > > reset with MES, async gfx rings and the RS64 firmware.
> > >
> > > I don't think it's enough to soft-reset just the CP and expect the
> > > GFX queue to continue. There are other parts of the GFX block which
> > > can hang, for example a badly written NGG shader can easily hang the
> > > PA. I think we need to use the SOFT_RESET_GFX bit as well.
> > >
> > > I noticed that the soft reset implementation needs to also re-
> > > initialize the clock and power gating for the GFX block, otherwise
> > > the GPU can consume more power after the reset than before on older
> > > GPU generations (and some GPUs just fall off the PCIe bus). We need
> > > to check how GFX11-12 behaves.
> > > I think it
> > > would be best to re-initialize the clock and power gating here too.
> > >
> > > Additionally, as I said on the other patch, I think the cleanest
> > > would be to reset the entire GFX block instead of just parts of it,
> > > for two reasons:
> > > (1) gang submit can hang both gfx and compute at the same time, and
> > > those hangs can only be resolved by resetting both gfx and compute.
> > > (2) if we choose to reset the whole gfx block, that allows us to
> > > reuse the code from the suspend() and resume() functions, which
> > > means better code reuse and more consistency.
> > >
> > > What do you think?
> > >
> >
> > Hi Timur,
> >
> > Thanks for the review. I'm glad you find the idea useful.
> >
> > I would keep the gfx-only CP reset as a separate recovery level. Its
> > purpose is to recover an isolated gfx CP hang without resetting
> > independent compute workloads.
> > Replacing it with a whole GFX IP reset would lose that benefit.
>
> I see your point. I'm skeptical because the GFX7-8 soft reset code was al=
so
> supposed to do that, but it never actually worked and nobody noticed it f=
or
> many years until I fixed it recently.
>
> >
> > There are several reasons for keeping this distinction:
> >
> > - The hardware supports this narrower scope through
> >   CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and
> CMP_ONLY_SOFT_RESET.
> >   This gives us an intermediate recovery step when a queue or pipe
> > reset
> >   cannot clear the hang.
>
> We need to test each code path very thoroughly to make sure it can recove=
r
> from all possible hangs on both graphics and compute queues.
> There should also be a code path that resets all engines at the same time=
 if
> needed.
>
> > - A whole GFX IP reset also affects compute resources and requires
> >   recovery of the affected MES queue state and all the KFD/ROCm
> > queues.
>
> The soft reset code already handles that for kernel queues.
> It just needs to be extended to also consider user queues.
>
> >   The gfx-only CP reset preserves that state and the pending compute
> > work, although MES
> >   suspend/resume can temporarily pause scheduling. We have successful
> >   HIP and compute test runs across these resets, demonstrating the
> > value
> >   of preserving independent compute workloads.
>
> Nice! That's impressive.
>
> >
> > - The locking doesn't fit either: amdgpu_device_ip_soft_reset() takes
> >   the reset domain for write. [...]
>
> We can change that.
>
> > It is also reached from the user queue reset path, not only from a
> > kernel ring timeout.
>
> I was planning to extend the soft reset code to be reachable when user qu=
eues
> hang the GPU. Just haven't done it yet as currently user queues don't yet=
 work
> well on any supported GPU.
>
> > - gfx12 has no soft_reset callback, and the gfx11 one isn't enabled as
> >   a recovery step. A whole GFX reset for these generations needs new
> >   work and validation in any case.
>
> If we really want to have the capability to reset graphics and compute
> separately, then I think the right way to go about it is to make soft res=
et more
> fine-grained instead of introducing another reset type.
> I think that would simplify the code and benefit both implementations.
>
> In my opinion, we should do the following:
>
> 1. amdgpu_device_ip_soft_reset() needs to be extended to handle user
> queues. It should be able to save and recover non-guilty user queues (it
> already does that for kernel queues), and it should be reachable when use=
r
> queues hang.

This series already does that for gfx user queues: the gfx engine reset
saves the ring state of the non-guilty gfx user queues before the reset
and maps them again after it, and it is reached from the gfx user queue
reset path when the queue and pipe resets fail.
Compute user queues would be the next step, together with a compute engine =
reset.

>
> 2. We should add an IP block function called soft_reset_engine() and move
> your engine reset implementation there. The argument should be a bit mask=
,
> each bit representing an engine so that the function should be able to re=
set
> multiple engines at once if needed (when all bits are set, it should rese=
t all
> engines at the same time, ie. equivalent to a full IP block reset).

That's close to how I implemented it at first. I'm not sure we need a
bit mask though: the GFX IP is the only one where we need to choose
between engines, gfx or compute, as the hardware can reset them
separately (CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET /
CMP_ONLY_SOFT_RESET). Other IPs like SDMA or VCN reset per instance and
can keep using soft_reset(). So an engine selection for the GFX IP
(gfx, compute, or all) would be enough, and the new callback would be
optional for the other IPs.

>
> 3. amdgpu_device_ip_soft_reset() should call soft_reset_engine() if it ex=
ists.
I am fine with this way .

One more requirement: for a gfx-only reset, the reset domain has to be
taken for read. KFD only try-locks it for read before it adds or removes
MES queues, so under the write lock those calls fail with -EIO; we saw
that with an earlier version of this series.

 @Deucher, Alexander,  do you have any concerns with this direction?
I'll rework the series along these lines and send a v3.

Thanks
Jesse
>
> I'm happy to help with the code if you want. Can you share what is your t=
est
> case and how to reproduce it?
>
> Best regards,
> Timur
