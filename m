Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BA3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A866661004
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 03:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A866661004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA3D6E525;
	Fri, 22 Oct 2021 03:53:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EBD6E525
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 03:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2fW701vvmfmuXWUOID/HbveELZyDk5dQpC7gZB6Y7B9O9bYMZw9tsyknZzrhZa0apvFIxpmBlz3MLNgJ44fhCvc4ge1IpvFGuDZINVX4bmvr0Dd0hJVuwlZhO0BjvBHtVkSbhnwI1D363Qz05lyUJ91Zjcgrs2g8w9qM5s06N9Ksj5Z2jOwMmPRN3JSUyQXliZjDyLYy1mpQfHDoiJtvxb4eqcOmU1FHpUuz9oD4VFkAtUK84qpeNQAPhTkSunpFk/kAQwps7SvZ3nM0Uu+HY5TMstM1D3mibyLapWFNP/Tks7NsQp21nnOC6/kuAsj4JXMJQR6wSWeS9K83orVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy7IwQToIvVFxBFKtasjyLO4T/iwW42+zrht3LODlnU=;
 b=RvJj4OHyGnIC95io8n3+psM84gnG2OBkUAqShmMQ08IDOlFUBUMVqU2nTS3idMjDGWuCd3LS3diwAxqBN868PTxCKLspgmJtDJqx4VJTnZd1I65laUka5pw+As35P4bjLVOyAAIosAL/tUMACg9s4tEMAnWVv4Ze/r6AmvkTFfcG/l1f9U12/HoGNrehiMMj/3WGFcRSbWa1a8aFemWMrfeldY7WGrDE9IKKdzGrBqWiVq+qRNGHVeDe05ohqYdeOfpvGJNEZDtSl+ra/Vqm5pOyePI4WUqLezL0PaZbGrXzCp3ErtWDzZSF6PPvlYjkJiKCW4YyvtcU+/l1hhsm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy7IwQToIvVFxBFKtasjyLO4T/iwW42+zrht3LODlnU=;
 b=kia4LRgPXzzbstamQgqWJo/7tGMwzFXnVS9+IlEmFzZ4lo2QwXAY5iv1QcqEG1U6x5fSrd8yGZ588VwsKtviF09i9DcKUbte8xzgD2DL3uSfiv/JF8J2QkE4+1HwgatSsltz+FTMi4+sGhPGVy868AfHl8qQh4a0d9t34KHbpGE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Fri, 22 Oct 2021 03:53:00 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 03:53:00 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
Thread-Topic: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12
Thread-Index: AQHXvF8M7xNtW1IyokihaLCsBYHxNqved4JQ
Date: Fri, 22 Oct 2021 03:53:00 +0000
Message-ID: <DM5PR12MB2469BFD61964E0CF258F64E5F1809@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211008161021.1922011-1-alexander.deucher@amd.com>
In-Reply-To: <20211008161021.1922011-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T03:52:57Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ebce89ce-636f-425c-8f11-5a073c09dfc0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8587ee96-7ecb-45af-7d9e-08d9950f7129
x-ms-traffictypediagnostic: DM6PR12MB3770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37709D1EB7C4E7F3D46F99E1F1809@DM6PR12MB3770.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O7HGZeoFX9R9L7cI3vY14Xs0vYYb0xMQEBPRZ8WHYj8XJ2ProBNuVIkvl00ZI2G+E2O3kjh8soZd8BhZ6RruWl7NeXakxcia2cC3coFO1zOFRGx9R0afvCAo8xrHB1sHCvRvYowAdZWSAGZfpf6j6sUay+lR6RAEGLKY+lL7BgQc6fU3O3Sl1BRdub5MAcUVD0dUb420kwISINU2snmWFIVKH7qr/TZjdGeAlUdmM8EqdPxr41m7xDxa3gP/peq/B5ysxbpiJ0Kg28q+JMQeAv2bPvOFHMeRe90uqqol7annho8GZkNQ4d7S+s2U5uPRToHvmxPCd9rmQ8iKbceH7luW7I5LhuoKhW1nOi8snJZdGiFF4Fj7d1HLXfiwVXxAbJkvdZS0UTeW70qQiwxUs6Zp6wb3E2pHBPyriOuVjR+JLk8+W4O8/LJfI+ILuIH7IMXOPMeRHRKKsvD3Yp53KkHqgmicUN+teUH+fY9EIFBG/Wv0ndDn//79+ZhY6j/KvfClbn1ozaZjayanBaov8E2elwGUKOATqEja02JEpIwbiw6qg+KYCumEVeptlc5QBu+5M7j8VvaaKf1R0sYOrXnLDwDHtkd38zVwu0u8SdGZIHHuKDvU0Ldw9SkZ1UFS2OUxM/O0TArJhvwdXDKGE+Xv1niuGKKGeyaZOx2bD9ViRk1rs0lXCdK/HWsKeLg0FT5oCffAwJxVtoO5CH4IGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2906002)(508600001)(8936002)(9686003)(33656002)(7696005)(53546011)(110136005)(64756008)(316002)(26005)(76116006)(186003)(66476007)(30864003)(8676002)(71200400001)(86362001)(55016002)(5660300002)(6506007)(122000001)(66556008)(66946007)(66446008)(83380400001)(52536014)(4326008)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9wCShWcfFNaqTGnQ4HheVkCyJygGAMPG7lK71ulKE0K16R3u8BqKyjlveO7K?=
 =?us-ascii?Q?tP9oueU1N29VTcLaeS7gz2DzSCxp3U6D6OijIELF6+TPPfn8BcTEu+RZ3/Ue?=
 =?us-ascii?Q?kVqxR2oyQExXfsvoq9y5eIZK6yCEhPKWlS6+f+aoRb1miUEgS7BHZsjIuWE1?=
 =?us-ascii?Q?3VE2I8FlBpL/L08bhENwqX6It+w/bRbXNS5AtsToScWa03Mtt2LZds9abZYP?=
 =?us-ascii?Q?bodp7TDxdO2UInAQrbsHQv3eYtK7tXf8DKU5PcGulkaoJJ8dzY75aV6LKsgt?=
 =?us-ascii?Q?b5jD+G+VmQAYvDsVpBqPFlD47ph4zfcs2x6ctK/W7boQE88D8LyBWaZMbIFs?=
 =?us-ascii?Q?P1f+L5zlInS0IPTbLT3F/2KEdv427/6FCz8SY4y8z7FtQgEVuYMwZvXjeaZ0?=
 =?us-ascii?Q?07CdA7C8pu0clklRS2ZqIGbKCeylEkdyccqrPI5Hwq7BjxZa+QYoQxneCDXf?=
 =?us-ascii?Q?5BU6ctVRXwlqiEe4++mIfcRE9yNNARoyjA6x1XOfbCHXWJVp+tmiDO7EMKvw?=
 =?us-ascii?Q?DDM6apnNrQcy4bnVdcqSW2n7FHL5yRN8VI6rZH+ACQFTr0UZnS/Ly6t4dA4/?=
 =?us-ascii?Q?u3cwo38REfzghWkuaYZkMc4pLW+e7DCo3YYQdhB43Iq9nz3Au5xZoLoe/1MF?=
 =?us-ascii?Q?OeuJgahafTbtmkMRRt3eHFKK32snScHsnD8lR/irH7+6ZL43HPJGHqc8PbIo?=
 =?us-ascii?Q?oqQWd1FK9e/TumgeGJCE+VETsQda8d8ePt5ajfWa08v8jfpbBchk8YW+LwBN?=
 =?us-ascii?Q?nM0LPpl6KrV4eBWUADrw8rDZ3vbMhtw9ilwUHUKTwkclan1wp6/JihrSMw/h?=
 =?us-ascii?Q?oEKwh1NVVaxbYjdxKVatV0ABTAyZ4TgPfvWUhdaKPCLd8S+zdGE6d7yV9VhX?=
 =?us-ascii?Q?znfwexR4EZx1+Xzyuum11XLQR38obYMT97jhf79ZF+pSm1bYj0/yDh6TnRyg?=
 =?us-ascii?Q?W5pME+mVttT0YMH94rWrh1Y+8Ze9aVg1AkQ7/z8UvUXPLTNjdB+Yzm8s+ytO?=
 =?us-ascii?Q?egbd645V2isZ1xy5Q1gaBMWah5E1+91+MZQwy0lSbhT6PU4dQHeof0dH9xBd?=
 =?us-ascii?Q?L3GYpQef9rNS/41GOIotg3Le8Rhuv0h8omzUezIbtl7m4AJ1dwnE1vJUXRRp?=
 =?us-ascii?Q?q1fsEPLutin/5Bqvl/pgD36Wru2wtxu+RG4me52S51AL68l5FrJj49dtdU3V?=
 =?us-ascii?Q?R5z901AnOfsfbAUZSs7QPuyRQLMkCu13uI/r2ggOEMGvOEz17vxscZv3U3sp?=
 =?us-ascii?Q?hI6/B5rxcpfibBbmfIcq0yQvtHKWVH/YGsV1rq9fBK5bUaw8bHddoDa7JXAa?=
 =?us-ascii?Q?QO2SU4S/iZo0/N7fVdij+iRO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8587ee96-7ecb-45af-7d9e-08d9950f7129
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 03:53:00.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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

This patch caused ring test of SDMA failure on Vega20.

Oct 12 00:18:24 vega20-ebd-11 kernel: [   11.900968] IPv6: ADDRCONF(NETDEV_=
CHANGE): eno1: link becomes ready
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.007480] AMD-Vi: AMD IOMMUv2 dr=
iver by Joerg Roedel <jroedel@suse.de>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.007482] AMD-Vi: AMD IOMMUv2 fu=
nctionality not available on this system
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069082] [drm] amdgpu kernel mo=
desetting enabled.
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069226] amdgpu: CRAT table not=
 found
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069229] amdgpu: Virtual CRAT t=
able created for CPU
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069288] amdgpu: Topology: Add =
CPU node
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069415] checking generic (9000=
0000 300000) vs hw (90000000 10000000)
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069416] fb0: switching to amdg=
pudrmfb from EFI VGA
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069700] Console: switching to =
colour dummy device 80x25
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.069755] amdgpu 0000:03:00.0: v=
gaarb: deactivate vga console
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070047] amdgpu 0000:03:00.0: e=
nabling device (0006 -> 0007)
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070241] [drm] initializing ker=
nel modesetting (VEGA20 0x1002:0x66A1 0x1002:0x081E 0x06).
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070244] amdgpu 0000:03:00.0: a=
mdgpu: Trusted Memory Zone (TMZ) feature not supported
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070257] [drm] register mmio ba=
se: 0xA0300000
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070258] [drm] register mmio si=
ze: 524288
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070263] [drm] add ip block num=
ber 0 <soc15_common>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070264] [drm] add ip block num=
ber 1 <gmc_v9_0>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070265] [drm] add ip block num=
ber 2 <vega20_ih>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070266] [drm] add ip block num=
ber 3 <psp>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070266] [drm] add ip block num=
ber 4 <powerplay>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070267] [drm] add ip block num=
ber 5 <dm>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070267] [drm] add ip block num=
ber 6 <gfx_v9_0>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070268] [drm] add ip block num=
ber 7 <sdma_v4_0>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070269] [drm] add ip block num=
ber 8 <uvd_v7_0>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070269] [drm] add ip block num=
ber 9 <vce_v4_0>
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070286] amdgpu 0000:03:00.0: a=
mdgpu: Fetched VBIOS from VFCT
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.070293] amdgpu: ATOM BIOS: 113=
-D1640600-103
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072517] [drm] UVD(0) is enable=
d in VM mode
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072519] [drm] UVD(1) is enable=
d in VM mode
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072520] [drm] UVD(0) ENC is en=
abled in VM mode
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072520] [drm] UVD(1) ENC is en=
abled in VM mode
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072521] [drm] VCE enabled in V=
M mode
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072632] amdgpu 0000:03:00.0: a=
mdgpu: MEM ECC is active.
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072633] amdgpu 0000:03:00.0: a=
mdgpu: SRAM ECC is not presented.
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072651] amdgpu 0000:03:00.0: a=
mdgpu: RAS INFO: ras initialized successfully, hardware ability[105] ras_ma=
sk[105]
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072657] [drm] vm size is 26214=
4 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072668] amdgpu 0000:03:00.0: a=
mdgpu: VRAM: 16368M 0x0000008000000000 - 0x00000083FEFFFFFF (16368M used)
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072669] amdgpu 0000:03:00.0: a=
mdgpu: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072676] amdgpu 0000:03:00.0: a=
mdgpu: AGP: 267894784M 0x0000008400000000 - 0x0000FFFFFFFFFFFF
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072683] [drm] Detected VRAM RA=
M=3D16368M, BAR=3D256M
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072684] [drm] RAM width 4096bi=
ts HBM
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072736] [drm] amdgpu: 16368M o=
f VRAM memory ready
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072738] [drm] amdgpu: 16368M o=
f GTT memory ready.
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072745] [drm] GART: num cpu pa=
ges 131072, num gpu pages 131072
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072819] [drm] PCIE GART of 512=
M enabled.
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.072820] [drm] PTB located at 0=
x0000008000300000
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.075598] amdgpu 0000:03:00.0: a=
mdgpu: PSP runtime database doesn't exist
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.075605] amdgpu: hwmgr_sw_init =
smu backed is vega20_smu
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.083924] [drm] Found UVD firmwa=
re ENC: 1.2 DEC: .43 Family ID: 19
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.083956] [drm] PSP loading UVD =
firmware
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.085826] [drm] Found VCE firmwa=
re Version: 57.6 Binary ID: 4
Oct 12 00:18:39 vega20-ebd-11 kernel: [   27.085837] [drm] PSP loading VCE =
firmware
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.254187] [drm] reserve 0x400000=
 from 0x83fec00000 for PSP TMR
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336956] amdgpu 0000:03:00.0: a=
mdgpu: HDCP: optional hdcp ta ucode is not available
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336964] amdgpu 0000:03:00.0: a=
mdgpu: DTM: optional dtm ta ucode is not available
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336967] amdgpu 0000:03:00.0: a=
mdgpu: RAP: optional rap ta ucode is not available
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.336970] amdgpu 0000:03:00.0: a=
mdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.340605] [drm] Display Core ini=
tialized with v3.2.156!
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.356874] snd_hda_intel 0000:03:=
00.1: bound 0000:03:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.404543] [drm] kiq ring mec 2 p=
ipe 1 q 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.446720] [drm] UVD and UVD ENC =
initialized successfully.
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.645505] [drm] VCE initialized =
successfully.
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651286] [drm] TX was terminate=
d, IC_TX_ABRT_SOURCE val is:1000001
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651289] [drm:smu_v11_0_i2c_xfe=
r [amdgpu]] *ERROR* Received I2C_NAK_7B_ADDR_NOACK !!!
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651460] [drm:smu_v11_0_i2c_xfe=
r [amdgpu]] *ERROR* WriteI2CData() - I2C error occurred :1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651641] [drm:amdgpu_ras_eeprom=
_init [amdgpu]] *ERROR* Failed to read EEPROM table header, res:-5
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.651789] amdgpu 0000:03:00.0: a=
mdgpu: Failed to initialize ras recovery! (-5)
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.652729] kfd kfd: amdgpu: Alloc=
ated 3969056 bytes on gart
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729075] memmap_init_zone_devic=
e initialised 4194304 pages in 40ms
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729082] amdgpu: HMM registered=
 16368MB device memory
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729266] amdgpu: SRAT table not=
 found
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.729267] amdgpu: Virtual CRAT t=
able created for GPU
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730290] amdgpu: Topology: Add =
dGPU node [0x66a1:0x1002]
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730294] kfd kfd: amdgpu: added=
 device 1002:66a1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730313] amdgpu 0000:03:00.0: a=
mdgpu: SE 4, SH per SE 1, CU per SH 16, active_cu_number 60
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730951] amdgpu 0000:03:00.0: a=
mdgpu: ring gfx uses VM inv eng 0 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730953] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730955] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730956] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730957] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730958] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730959] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730960] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730961] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730962] amdgpu 0000:03:00.0: a=
mdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730963] amdgpu 0000:03:00.0: a=
mdgpu: ring sdma0 uses VM inv eng 0 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730964] amdgpu 0000:03:00.0: a=
mdgpu: ring page0 uses VM inv eng 1 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730965] amdgpu 0000:03:00.0: a=
mdgpu: ring sdma1 uses VM inv eng 4 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730966] amdgpu 0000:03:00.0: a=
mdgpu: ring page1 uses VM inv eng 5 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730967] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_0 uses VM inv eng 6 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730968] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_enc_0.0 uses VM inv eng 7 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730969] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_enc_0.1 uses VM inv eng 8 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730970] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_1 uses VM inv eng 9 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730972] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_enc_1.0 uses VM inv eng 10 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730973] amdgpu 0000:03:00.0: a=
mdgpu: ring uvd_enc_1.1 uses VM inv eng 11 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730974] amdgpu 0000:03:00.0: a=
mdgpu: ring vce0 uses VM inv eng 12 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730975] amdgpu 0000:03:00.0: a=
mdgpu: ring vce1 uses VM inv eng 13 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.730976] amdgpu 0000:03:00.0: a=
mdgpu: ring vce2 uses VM inv eng 14 on hub 1
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.742823] amdgpu: Detected AMDGP=
U DF Counters. # of Counters =3D 8.
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.742901] amdgpu: Detected AMDGP=
U 2 Perf Events.
Oct 12 00:18:40 vega20-ebd-11 kernel: [   27.745583] [drm] Initialized amdg=
pu 3.44.0 20150101 for 0000:03:00.0 on minor 0
Oct 12 00:18:41 vega20-ebd-11 kernel: [   28.755954] amdgpu 0000:03:00.0: [=
drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on sdma0 (-110).
Oct 12 00:18:42 vega20-ebd-11 kernel: [   29.779951] amdgpu 0000:03:00.0: [=
drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on page0 (-110).
Oct 12 00:18:43 vega20-ebd-11 kernel: [   30.803948] amdgpu 0000:03:00.0: [=
drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on sdma1 (-110).
Oct 12 00:18:44 vega20-ebd-11 kernel: [   31.827955] amdgpu 0000:03:00.0: [=
drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on page1 (-110).
Oct 12 00:18:44 vega20-ebd-11 kernel: [   31.931041] [drm:amdgpu_device_del=
ayed_init_work_handler [amdgpu]] *ERROR* ib ring test failed (-110).

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, October 9, 2021 12:10 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio7.4: don't use GPU_HDP_FLUSH bit 12

It's used internally by firmware.  Using it in the driver could conflict wi=
th firmware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 91b3afa946f5..3b7775d74bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -56,12 +56,15 @@
  * These are nbio v7_4_1 registers mask. Temporarily define these here sin=
ce
  * nbio v7_4_1 header is incomplete.
  */
-#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK	0x00001000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK	0x00001000L /* Don't use.  Firm=
ware uses this bit internally */
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK	0x00002000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK	0x00004000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK	0x00008000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK	0x00010000L
 #define GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK	0x00020000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK	0x00040000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK	0x00080000L
+#define GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK	0x00100000L
=20
 #define mmBIF_MMSCH1_DOORBELL_RANGE                     0x01dc
 #define mmBIF_MMSCH1_DOORBELL_RANGE_BASE_IDX            2
@@ -332,14 +335,14 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_r=
eg =3D {
 	.ref_and_mask_cp7 =3D GPU_HDP_FLUSH_DONE__CP7_MASK,
 	.ref_and_mask_cp8 =3D GPU_HDP_FLUSH_DONE__CP8_MASK,
 	.ref_and_mask_cp9 =3D GPU_HDP_FLUSH_DONE__CP9_MASK,
-	.ref_and_mask_sdma0 =3D GPU_HDP_FLUSH_DONE__SDMA0_MASK,
-	.ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__SDMA1_MASK,
-	.ref_and_mask_sdma2 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK,
-	.ref_and_mask_sdma3 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
-	.ref_and_mask_sdma4 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
-	.ref_and_mask_sdma5 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
-	.ref_and_mask_sdma6 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
-	.ref_and_mask_sdma7 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+	.ref_and_mask_sdma0 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
+	.ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
+	.ref_and_mask_sdma2 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
+	.ref_and_mask_sdma3 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
+	.ref_and_mask_sdma4 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+	.ref_and_mask_sdma5 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
+	.ref_and_mask_sdma6 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
+	.ref_and_mask_sdma7 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
 };
=20
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
--
2.31.1
