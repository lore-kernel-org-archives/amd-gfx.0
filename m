Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A87DCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 01:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCE3112CD4;
	Mon,  1 Jun 2026 01:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NokiTb1h";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A5B112CD4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 01:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUPdn5hvyzCXZXlT/bW4UvwferomZYWNahdgYNRLIY0rM8SDeMNX2GyIV+g3JMULgmNVLg7hoORd+k/QsxBfO6y1A1M4X4prqCtY3IUtD+E+CVrHj6wzWbzDU/zksyOzNHX0c2j/oy1kRrQqO0bvMwTMSIwVYmInuq7z8v5O2DE6l6kDd6viM709QGkUvJKUwIHVghCX+dplgcQ0m4Y3GiCJiNkWDDnkDYhroP3sUyFDxaxJywlHWRRH53TFlHsJ7ni0x//G9tRwwq2WgIJfD5sQWCI+8NaDH25902nMlcIzcp00MbXI+HPc17AoCBNTnBUQIKwbJ98izfLigwFLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvvHQSiTtGbf2WiBLeNVUp0cezgAoU0AOJwpUXjKBrU=;
 b=oiVQW4YUH4DOKAiy1/t1NTkHd/TN0ehqJ9Y0+Wj88P/NOpWQoPDCofN2sm4UXIfCrwGZljCykknMCshT3TPkwuRJmJfjCUKnB31B1GaST4DxKKMEALLVBB77ulT+PErVFRwxN6zN9b1/q4oJN6PTPnYkwnV67YyvoIlK5jMYC7v+pBNUeLcVAcc3DdpUm7N1kNWXjqeunuFOSdnW6nDmfg11JecZjoqmKhkJOmyVJSQ/3wNelYUtql01gB2E4dgMW5j8hyx47Fag1mYjYif3EhkzmNzivVkuCvdS9toIullmArc9NOrtbZBFG6oM2kDOnPZxbTCnf/sKXT2rIz6B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvvHQSiTtGbf2WiBLeNVUp0cezgAoU0AOJwpUXjKBrU=;
 b=NokiTb1h/tIRUFJC+TOumgKrLjmTod20AIZDh6BVDPemk7pbtvSdqd0VLNxAgzsd5Pyq0Y1r1p+VLfPIqjDEXE9cO1b4vyt1rf1m8jWXz3O7QxntGjQ8QggjgLGxpjXZWaLCxNFWIGl+6ZM34XoP3h7NOKYxRdvTb7KZP4EE2FI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 01:28:49 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 01:28:49 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Lin,
 Amber" <Amber.Lin@amd.com>
CC: "Rastogi, Manu" <Manu.Rastogi@amd.com>
Subject: RE: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and
 add HQD cleanup
Thread-Topic: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and
 add HQD cleanup
Thread-Index: AQHc6YEDQQnhu2VXNUCwyuBdLK4/M7YlNuAAgAPB3rA=
Date: Mon, 1 Jun 2026 01:28:49 +0000
Message-ID: <DM4PR12MB5152490B7248EC133821454EE3152@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-14-alexander.deucher@amd.com>
 <CH0PR12MB53728609509717B364E84FFFF4162@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53728609509717B364E84FFFF4162@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T15:38:11.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV5PR12MB9777:EE_
x-ms-office365-filtering-correlation-id: 89ee533c-92b9-4b78-94b4-08debf7d21fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|3023799007|18002099003|11063799006|6133799003|56012099006|4143699003|921020|38070700021;
x-microsoft-antispam-message-info: lsxfWpkRHnQXkgm3KZh34JLn/c7PC+yJCVZ/ajDPBvgGl+H227U/eL4kAnPtigkpM3iT5ct7sjFwf0QzXgT0CJ9sg2jB0hXMD+yU9jImxIpP4Od3+qkZP3BtIEx9zB0LYHxqYOeMhckGFKnP4B0Ujf30/Ub2MyWko/VANWDFQ4edD/8/qNoK4LdzRSB+vUyHZ0/5NPDOISAdIPIVCmzR0WwdtsUecgQC7CJ7r1qIaO+CyZtjEnehEA+V7fN7bjTOSZUMCDW1PxR8jKRNDLEUVYvCzE2WUl8QpG9jC4dLDYNMYbYtVQ3vYdTkOymm+TXEhNBtrUccUvRNb6SO98Y4VJHKMauBlg/J+XgrVMUKLjLLD87IFRebIOLEBMFsEqTXRhaFtr27+28yRLS5iGDMgQdcrvSGDtkyqqoyHFWpfPXeNhpQB95JJthdeoR0L9AAkzJYoTtxKn35wKyfhKne2Hq9Xwn1fTEwIIaVqBjc3IsYKXnkSVcahPeezDwY0pTg5n32aDnQ10MI8937zuHy9byrgBIXP2SzbIMudKi+jVyqFg4oeRIXQ+EpL6tIpM3e4m/YoYaHtCvcRnBkI2M4cI9BEU47m6SDseWMTnKTkLbaIxnZlq0gEj77v+gW5MWvamTuVQrs14FhdYlImxsv3QiXUr5tFmCL7JfEQ94XJnk2/4NWLTIZWB3/O61y3qjcMSMZKfVoP6x3l6R44DPU0DnsxvjfgZ5t365/zyMWJN9vU2PUWFle72G+JLZoL5JBC4UUprTqI1XI27ElPPVcnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(3023799007)(18002099003)(11063799006)(6133799003)(56012099006)(4143699003)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q941iyxux56ewgcEmYnpAoh6K3npRG2R8UDZc47/JI7gU/h8hrPgIp1z2Jke?=
 =?us-ascii?Q?A4q5pta3wCFEw4kX+vElkPOWjWsSif85DD04n9WPZj+yDAiyLUL46I4QSkdL?=
 =?us-ascii?Q?13OCwmokYsqG9t8hY+KSLmJzk3P+Afu6PKt3p3xRI8sisRatIpBwhlEZEg1x?=
 =?us-ascii?Q?CMo8vLsu+r7IAAyI/JHgFbolUgmEgIMHgzaY4zNN5squGB8w++MQVmNaQ3oq?=
 =?us-ascii?Q?o4aNFUx8/1QBmmDfzDf47bxGRTppCEV3c83YhSDGd1VNJiLWo9Hjvu2VKi0D?=
 =?us-ascii?Q?R4PGUd4KvG4VC3pxF5Oh+HlVb2H5xGRv4BaQJ4meHhCYWqq1V4Eo3zV8UARC?=
 =?us-ascii?Q?fCmTJ2Npsi++RZbhqv1vhCpAwxo7D8HItJXuShs3Kl3tsRvl6km8JLAGSraP?=
 =?us-ascii?Q?dE1ifEgaHii24BC/kG3sYDbfM2Oh168XEOqRYL1fn5nFiM7bwhb2sOzu/zpx?=
 =?us-ascii?Q?rOUtKqfkPQJEnomejjIjreMiw15JwjnOz+0vbWAsW9nEMjw27hgykf9r86F9?=
 =?us-ascii?Q?I4lmgAramNdaDkLP33+MfxJ6WOHT0CyqhbjRwv9ok/HqaW+XJa4Y1h/6pQMZ?=
 =?us-ascii?Q?7FUEg2YUL894K+5yWdASJCETmgQ5OmtkTcsE11K9Qo4fRxUU++30cnz/m8dJ?=
 =?us-ascii?Q?cDYKPykJjcWEVPxp2+oIg2FJLRr7EIt9qKBgVwSIDk15hTC9bZNQJTN7Z7Cs?=
 =?us-ascii?Q?zAAhrmcBjYhv4NRNfj5d21ZYilwxBnMJnUAcKLpXIt0qFd4Ve3fRp/V4Qipm?=
 =?us-ascii?Q?+OPAnkuRvzMA19BZsWqzXbSgHw54xfJL3CIIVmC4w/lyUJSgRrRMtL2Zwm7D?=
 =?us-ascii?Q?omxZmUoIZLsrA2MTocJI0/zbPRdXyv/kb4iScQs8x2Sl2aN7NF7zOPdlF5JR?=
 =?us-ascii?Q?rEH/76qmw2ElqL6XdqPhi9P89lipGTGfLMVDRAEGzurfBdEkUyE+X1I+O73Z?=
 =?us-ascii?Q?V3gwjdmUrzrx4BXsLtetWNOfhCPN85EByMZjX9rKoJu5EI5ORXk0N5L22g11?=
 =?us-ascii?Q?+Bhhld6hwwm9nNUTWRDtsAqKwOQAL96FD/T9OsFYjLbDS6wIVdW9MPPt7tTz?=
 =?us-ascii?Q?0Kkx5Vj6yMAnrefk4bji+bAXvln1ht4b2P7GGhp2Vmxs/Gnr3SFfHReCV2oa?=
 =?us-ascii?Q?j49f5KYUWQ9GgUPCI2XRaE4y49ZL/z5am+GBRJZMC7Tr2VEUNci4D7NvhGhJ?=
 =?us-ascii?Q?vl8vsczBOLJIrVIifiNul9wbuX/872W/Tu9lp6e66208JBbvlAIU8LoqNkSD?=
 =?us-ascii?Q?NUya5ACxh6ERY1xDy+17xHgfjwqQLvOX6gHaqYltvk4INTYmJOVPdaBh7wCF?=
 =?us-ascii?Q?bpvnYkzcP+On7YGNc7Teqqb4nxlJsTCWrUwuCGekhd1w9EGOrufflVbmBali?=
 =?us-ascii?Q?LwKNFv7vkznlSIHV/8zv86gyUDD9/GXxHfHI4vonOUlqkjyIrUYGveyr83oo?=
 =?us-ascii?Q?GaIv6IQ7z3cslBPIr9K6/sYBDSDCbLetjGxUkw7PqZkL0DTw/0wMP5gTsXq0?=
 =?us-ascii?Q?HzV3LDUXIxeFcJp0NFmdLj9cDgfY7LEho2noTlH3D1AXoSowMrQXD5FftqoH?=
 =?us-ascii?Q?sXEL9N1GddkWY023R0PQMPp02NBmrRDEWTnRE30KmlEJ3CFjtLWagd7XMdkn?=
 =?us-ascii?Q?G4IW746FWGV7ULYXtTzGoMHDUDhbl+rLZ0T4eUz/IBDTvLhnTzA5J0GntLqp?=
 =?us-ascii?Q?uK3y1Xp3/dJs1ul6VusGTfM16HAGYQGCMZNWxNwntnTNSlci?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ee533c-92b9-4b78-94b4-08debf7d21fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 01:28:49.4987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjet5TZhtttzaayFOcMG33+u/A4fV5cfi4ovFCwTiW8BDXwIXI99/IXHqqXo4FJFap2MmB1ARgHcd3FK6PuWig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777
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

AMD General

> -----Original Message-----
> From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
> Sent: Saturday, May 30, 2026 12:05 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; =
Khatri,
> Sunil <Sunil.Khatri@amd.com>; Lin, Amber <Amber.Lin@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>
> Cc: Rastogi, Manu <Manu.Rastogi@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: RE: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset =
and
> add HQD cleanup
>
> AMD General
>
> Comments inline .
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deuche=
r,
> Alexander
> Sent: Thursday, May 21, 2026 8:20 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Rastogi, Manu <Manu.Rastogi@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 13/42] drm/amdgpu/gfx11: Refactor compute pipe reset and =
add
> HQD cleanup
>
> From: Jesse Zhang <Jesse.Zhang@amd.com>
>
> Refactor gfx_v11_0_reset_compute_pipe() to accept explicit me, pipe, and =
queue
> parameters instead of deriving them from the ring structure. This enables=
 the
> function to be used in generic pipe reset flows.
>
> Introduce gfx_v11_0_clear_hqds_on_mec_pipe() to properly clear
> CP_HQD_ACTIVE and CP_HQD_DEQUEUE_REQUEST for all queues on a
> given MEC pipe while the pipe reset is asserted, ensuring the HQDs are to=
rn down
> correctly before deasserting reset.
>
> Switch the KCQ reset path to use the common MEC pipe reset helper
> amdgpu_gfx_mec_pipe_reset_run(), which coordinates the reset sequence
> including KFD suspend/resume to avoid conflicts with user mode queues.
>
> v2: just update the sequence (Alex)
>
> Suggested-by:  Manu Rastogi <manu.rastogi@amd.com>
> Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 166 +++++++++++++++----------
>  1 file changed, 100 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index dd4f33d2ce45f..1995de5e69991 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6874,11 +6874,39 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring
> *ring,
>         return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
> -static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
> +/*
> + * With MEC pipe reset asserted, clear CP_HQD_ACTIVE /
> +CP_HQD_DEQUEUE_REQUEST for
> + * every queue on (me, pipe). HQDs must be torn down while pipe reset
> +stays
> + * asserted; only then clear the pipe reset bit.
> + * Caller must hold adev->srbm_mutex.
> + */
> +static void gfx_v11_0_clear_hqds_on_mec_pipe(struct amdgpu_device *adev,=
 u32
> me,
> +                                            u32 pipe)
>  {
> +       unsigned int q;
> +       int j;
>
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t reset_pipe =3D 0, clean_pipe =3D 0;
> +       for (q =3D 0; q < adev->gfx.mec.num_queue_per_pipe; q++) {
> +               soc21_grbm_select(adev, me, pipe, q, 0);
> +               /* Start from a clean HQD dequeue state before forcing HQ=
D inactive. */
> +               WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
> [shaoyunl] When  we are here , you should already execute the pipe reset
> successfully , now just need to clear the ACTIVE and  DEQUEST_RESET direc=
tly .
> Don't need to check it again .
[Zhang, Jesse(Jie)] Thanks Shaoyun, 1.will remove the HQD active poll gfx_v=
11_0_clear_hqds_on_mec_pipe() - direct clear under pipe reset.
2. this applies to per-queue MMIO reset(DEQUEUE_REQUEST=3D0x2 + SPI reset) =
in mes_v11_0_reset_queue_mmio().

>
> +               if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +                       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST,
> 1);
> +                       for (j =3D 0; j < adev->usec_timeout; j++) {
> +                               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIV=
E) & 1))
> +                                       break;
> +                               udelay(1);
> +                       }
> +               }
> +
> +               WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0);
> +       }
> +}
> +
> +static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
> +                                          u32 me, u32 pipe, u32 queue)
> +{
> +       uint32_t reset_val, clean_val;
>         int r;
>
>         if (!gfx_v11_pipe_reset_support(adev))
> @@ -6886,109 +6914,115 @@ static int gfx_v11_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>
>         gfx_v11_0_set_safe_mode(adev, 0);
>         mutex_lock(&adev->srbm_mutex);
> -       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
> -
> -       reset_pipe =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> -       clean_pipe =3D reset_pipe;
> +       soc21_grbm_select(adev, me, pipe, queue, 0);
>
>         if (adev->gfx.rs64_enable) {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
> +               clean_val =3D reset_val;
>
> -               switch (ring->pipe) {
> +               switch (pipe) {
>                 case 0:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE0_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE0_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE0_RESET, 0);
>                         break;
>                 case 1:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE1_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE1_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE1_RESET, 0);
>                         break;
>                 case 2:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE2_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE2_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE2_RESET, 0);
>                         break;
>                 case 3:
> -                       reset_pipe =3D REG_SET_FIELD(reset_pipe, CP_MEC_R=
S64_CNTL,
> -                                                  MEC_PIPE3_RESET, 1);
> -                       clean_pipe =3D REG_SET_FIELD(clean_pipe,
> CP_MEC_RS64_CNTL,
> -                                                  MEC_PIPE3_RESET, 0);
> +                       reset_val =3D REG_SET_FIELD(reset_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 1);
> +                       clean_val =3D REG_SET_FIELD(clean_val, CP_MEC_RS6=
4_CNTL,
> +                                                 MEC_PIPE3_RESET, 0);
>                         break;
>                 default:
>                         break;
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_val);
> +               gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +               soc21_grbm_select(adev, me, pipe, queue, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_val);
>                 r =3D (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << =
2) -
>                                         RS64_FW_UC_START_ADDR_LO;
>         } else {
> -               if (ring->me =3D=3D 1) {
> -                       switch (ring->pipe) {
> +               reset_val =3D RREG32_SOC15(GC, 0, regCP_MEC_CNTL);
> +               clean_val =3D reset_val;
> +
> +               if (me =3D=3D 1) {
> +                       switch (pipe) {
>                         case 0:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE0_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE0_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME1_PIPE0_RESET, 0);
>                                 break;
>                         case 1:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE1_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE1_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME1_PIPE1_RESET, 0);
>                                 break;
>                         case 2:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE2_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE2_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE2_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME1_PIPE2_RESET, 0);
>                                 break;
>                         case 3:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE3_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME1_PIPE3_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME1_PIPE3_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME1_PIPE3_RESET, 0);
>                                 break;
>                         default:
>                                 break;
>                         }
>                         /* mec1 fw pc: CP_MEC1_INSTR_PNTR */
>                 } else {
> -                       switch (ring->pipe) {
> +                       switch (pipe) {
>                         case 0:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE0_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE0_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE0_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME2_PIPE0_RESET, 0);
>                                 break;
>                         case 1:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE1_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE1_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE1_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME2_PIPE1_RESET, 0);
>                                 break;
>                         case 2:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE2_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE2_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE2_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME2_PIPE2_RESET, 0);
>                                 break;
>                         case 3:
> -                               reset_pipe =3D REG_SET_FIELD(reset_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE3_=
RESET, 1);
> -                               clean_pipe =3D REG_SET_FIELD(clean_pipe, =
CP_MEC_CNTL,
> -                                                          MEC_ME2_PIPE3_=
RESET, 0);
> +                               reset_val =3D REG_SET_FIELD(reset_val, CP=
_MEC_CNTL,
> +                                                         MEC_ME2_PIPE3_R=
ESET, 1);
> +                               clean_val =3D REG_SET_FIELD(clean_val, CP=
_MEC_CNTL,
> +
> + MEC_ME2_PIPE3_RESET, 0);
>                                 break;
>                         default:
>                                 break;
>                         }
>                         /* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
>                 }
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
> -               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_val);
> +               gfx_v11_0_clear_hqds_on_mec_pipe(adev, me, pipe);
> +               soc21_grbm_select(adev, me, pipe, queue, 0);
> +               WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_val);
>                 r =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> regCP_MEC1_INSTR_PNTR));
>         }
>
> @@ -6996,8 +7030,8 @@ static int gfx_v11_0_reset_compute_pipe(struct
> amdgpu_ring *ring)
>         mutex_unlock(&adev->srbm_mutex);
>         gfx_v11_0_unset_safe_mode(adev, 0);
>
> -       dev_info(adev->dev, "The ring %s pipe resets to MEC FW start PC: =
%s\n",
> ring->name,
> -                       r =3D=3D 0 ? "successfully" : "failed");
> +       dev_dbg(adev->dev, "MEC pipe me%u pipe%u queue%u resets to MEC FW
> start PC: %s\n",
> +               me, pipe, queue, r =3D=3D 0 ? "successfully" : "failed");
>         /*FIXME:Sometimes driver can't cache the MEC firmware start PC co=
rrectly,
> so the pipe
>          * reset status relies on the compute ring test result.
>          */
> @@ -7017,7 +7051,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring
> *ring,
>         r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_m=
mio, 0);
>         if (r) {
>                 dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe r=
eset\n", r);
> -               r =3D gfx_v11_0_reset_compute_pipe(ring);
> +               r =3D gfx_v11_0_reset_compute_pipe(adev, ring->me,
> + ring->pipe,
> +ring->queue);
>                 if (r)
>                         return r;
>         }
> --
> 2.54.0
>

