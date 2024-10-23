Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B87CD2E008
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 03:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF3E10E0D8;
	Wed, 23 Oct 2024 03:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpW/sNwY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C9C10E0D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 03:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGEaeM1n8t1vgLQjRRlGeRsZPeodD92XzF751I5Fb4deT+NEJZU6i3NfAkYxQlFA+DA3Vps81Mv3vPq+vxF/LZicdGrLwysxYyA8RWhXAu3u+9i64Eh02a1jLN1HTqGjB+v5SgH8lyRtLeohgj/gXknkdoQJXy8Dq/NTBHLQ7GzEA7/SPO5uJ/fgWoiXufm6eVaNP0EyCfSkKEWOYjgsUjhLOYDY6RDmBgqoZTd1VpUpCJb5GqE/82WxtlM4+Q2Cex3qn7Ghf3LnUK4UfHR+oxFeOS32f657odaDvv1kPnMWlsYmgcC2vfvUsJ+o2+0Xu5rlyMtZb2B1YKLSk6DQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQgdzJtbtWo2WLqaGsUYUOAqPr4yzlk/UcT9bFnO8E4=;
 b=hC7VsrkNK6XHU9BjXOtgKvD6NE7mmTWepw/Fvgn0u9gollDDhIjMR5PovjVLXyMvPycekdvW7d6MeFa7rNEmqNHc2d2JTSQTLVsIHjABPhH0lgA3TL9NRZ7ODnGozPT4Cw10JuJt5HEo10uy8rvIr5e/pvEW2v9C091sGSdSEiUnRlljKaQx95wcX3OPJ8SCvz/zfMiXga9/e4h+M4bTpahh5fEo8OGGssA4k4uUZVibbSpOXf1U/YeCBSdtc3jwajfF8K8IH9sn4Tu9MR8UjIaU+WGMkV3kwZwVnslH7GF4CQxsBt9OnyZFcF5+QN0vHOKMI7eCeyvfWBz7vzLuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQgdzJtbtWo2WLqaGsUYUOAqPr4yzlk/UcT9bFnO8E4=;
 b=BpW/sNwYPnZMLF4Gd5aOCINOdnnhIlpxHAKDaorXiyYZzhs5dtXTSRc73YzKx4LLOlMoEVdGPu8raLp+NSS4aYys/MQICcxyue7r/NSplMA9HYF3iop4oA+o8QHlJqXiqJyrKL2UdabhQGbBTkpfEodhjTvgaEMJaqDZx5To0lM=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 03:12:40 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 03:12:40 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
Thread-Topic: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
Thread-Index: AQHbH5EjaIU4SZbBCE+Y2kRp2/Qfv7KTs2bw
Date: Wed, 23 Oct 2024 03:12:40 +0000
Message-ID: <DS7PR12MB6333A2566E654A9DD79130DAF44D2@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20241016060219.1811607-1-jiadong.zhu@amd.com>
 <20241016060219.1811607-3-jiadong.zhu@amd.com>
In-Reply-To: <20241016060219.1811607-3-jiadong.zhu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=50b17a2a-5257-4a61-b7c7-5d641b1a6899;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-23T03:11:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|PH7PR12MB7889:EE_
x-ms-office365-filtering-correlation-id: 1f3b30de-650c-4025-6735-08dcf3108e16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ejXsT3x3qx5rT2VSLH0gcgEtgnCb+JxKgjRNV1VrEgXkgyQW+dDDxKLmU0tU?=
 =?us-ascii?Q?UanPSUmasF25XCo9nGCWFNcFYfctIPM3Vgd659S/LEhOGUNh2unBzizALjCC?=
 =?us-ascii?Q?l+fOkZedeXP4kJY/95LOhzLNsUJgW9zDz5S3IQOnr/d0vay4tHAAvaXsbS8h?=
 =?us-ascii?Q?N2+BoVVdabSk+YRnhCJx7uX7L/h1dBL4+yX6kgOSamYM7JQX+vcvR2Rs4nGA?=
 =?us-ascii?Q?4f7PiS079PyOhtSiTgS1DZVBUtAZXagNQQpWj69F9bNeeiXIlhGFpp2PQz0i?=
 =?us-ascii?Q?vrT4ei+lKajwF7KMXNFro0aDJ6GphWF03P6O06ShTsbdMafB2Bz06efLkYhK?=
 =?us-ascii?Q?pEV4x6L9/2S9w2l49TH88RXrggqACd6fX9Ic6qE5D14/EUjcZu6RkhNQRsLr?=
 =?us-ascii?Q?VcSZGj+1EnYRsj1DpumkVaBW1DgvJuP9DwbnTIdfnN2LdOxf6oQi+cioEn+w?=
 =?us-ascii?Q?u0KbFNaID9Ab9oIyeEQadxmQCLKPSETomyI6s2FRQ50Xxn2+5HgniQ9Hj6a2?=
 =?us-ascii?Q?bUU4aLmJ0OxRsU3pqegTNFDhJ0FWk1kAMIuttJIVNUZRkOGofIwa309WSgCG?=
 =?us-ascii?Q?eJv7Ht7/nrLi0zzgp53akqYElp2oYmjdXNXupbWnU2ERCLtnuu2ynh9zwpRl?=
 =?us-ascii?Q?3z9b1NH8o6UheToIoS2Is3w/jGh32SA5o664V/MER25ga0yM1n27BMqsIQOo?=
 =?us-ascii?Q?jwfY2Ch6OrbEXtU7/RHOdjVv4K3JgWpJk/nPCBC+/y9x22JhT/xnnk53tWso?=
 =?us-ascii?Q?WidNTyOizWdzC/Twyk3mESavdPSJXX7741mfeTkh07K99w8T+8LTRR7+h8eP?=
 =?us-ascii?Q?726LlC57+ZJdP69fkBN9LnsmdkJxuwTsw3yrmeLZeggqhKmppu8erKN5bbHd?=
 =?us-ascii?Q?92hBCghBuRRfdoDnvBOlIY1ttjQxL6vgsQ3dVTbU7Xz1KQZ2RP0RKv7JVITu?=
 =?us-ascii?Q?Qqhb/7ToP/X8O8dl9J1dDQBatGUMfZb05u5yk20L1Jo3uJeSc8i5WjQbsmQ8?=
 =?us-ascii?Q?SndwxSzpdMWeCFcFyf7EwNezaSTRO0AVpAFemp867Oq82MTDv8VeObudZyEH?=
 =?us-ascii?Q?Oki7vm3OdjCAsiS/Sqvrd9H4h6xVWV5G1h/7Kno43QkDnxznPhJAAu4WHzAZ?=
 =?us-ascii?Q?u6ipK82WHs2dhh8CsvwUpNceh/oJ8Lg8RdXdjnfOTwzLSx/9How1FTI0CG2r?=
 =?us-ascii?Q?2AdNA+WmayVL5Jwf/ZJA5RPq/6zLf14stx2/ZjWkMiTGbudpaiDweGs9CJ4h?=
 =?us-ascii?Q?6bAm7tr3/JJVmbqqFC6CvWqxufvtA10+DEPJ5iMR34GCFNmFVKivZLdyGZ99?=
 =?us-ascii?Q?imM3TLUj3O6O7cyw6T9enRyQPZkJRCr44YHPH8xSkNGcH+Vvqy92cJu60hO1?=
 =?us-ascii?Q?q28DwPo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIv/IX/8MjZOt+/8+lxpFMlqK2fhwQh6qbpdp0gg9om0huHjANjRHyIj1IM5?=
 =?us-ascii?Q?h+q5yEVu1BZ9440K6jveCcgzuzwzn6Kh1j7TAhVkZw3PpBMHKo0QuwK1YgHu?=
 =?us-ascii?Q?H4xDdvc8wk3sNBWppAElo2hrQFjdkxsCCGp/wVd0bB+JAZLnsSkG6xj61cVl?=
 =?us-ascii?Q?op3vMuKjpTGZYrqUBaN1uTyAlQXp/XI/I9Al6Of5VdYi8aW6H6f5MjiXbP5B?=
 =?us-ascii?Q?xyNbbqDG+bOLmvMUfcaWmtoenzT9pfWGR6uvVIQ60nO48PvJOPZrg2QvyHra?=
 =?us-ascii?Q?UrKUcfaZDIh21YMFRkTxKzecoy6XDCBiAa2fvLDFD43A0KfiaIaYRIXGzD5I?=
 =?us-ascii?Q?Kv3IH6wTXtbIOeTGK/pwOjXiC8hTb/qhaU1SFJGsZYgyDsrDSOgIvuD0hKNw?=
 =?us-ascii?Q?o/oGMVGEY+vM5uy9d4v7k1UCXoo4Cnk5amQBpkKXuaNy/8jfWjL9v1P3j4o2?=
 =?us-ascii?Q?egWQcSqphh3vdkcHT1ocL86wmi4uScFO6n0iwATJi7tBWDVi/4IkHgMnCHGT?=
 =?us-ascii?Q?LlAvHSHl+MmlwG9bBgfPkjf89Fp8kAHRMx6IWB6o6mmB75qW4ohbd8u1z1k5?=
 =?us-ascii?Q?kpKN7MlfTfXSL7FeqW0x0IKYX9+99kWOYGJn2C7QMbgq1dfYeLMwf2p+JVr4?=
 =?us-ascii?Q?Dg5nFFSkRvGdUQsipOULONW/zy44jHSmFLqKRDDzD5hcJjLSrX7d+ewlB85W?=
 =?us-ascii?Q?yOjU1BTByvfPYHF+LRAa15gTMGxXQeKPLTw6begTLiA7E0dUa8KTlnuc7IMb?=
 =?us-ascii?Q?2MhUyLSRmsIC+NdK4wyNf4ODo8Y2Rq1w1onWNA1pmzU3eh4D6IJbK6zZ5Bu5?=
 =?us-ascii?Q?yJBBDx9EXYn1ypNDVEQFMu3Ok9/oS5mWBQKwSW5plD23Ij8AAcEFpqdjNAKH?=
 =?us-ascii?Q?A4W5BLJZuFgLFbHJPISMQrpMOH1i4TUj1/7eCVaMTF5McjsOapKjZzE96waJ?=
 =?us-ascii?Q?6RizwlOvYMSFAhCq2YCg6JJVJ9PRpCdzZ9aBuPzcdZCg5mhp9wokg6u/20fy?=
 =?us-ascii?Q?dzyYSHa/wyALaEhq6BHoOP/xFXyqGJftnyw+QcQx90atdVpSyHOfd5hHMBk+?=
 =?us-ascii?Q?TzKLwStg3/ALbUYhhgiHlZcFmdZuonpOSVgS0Nd2UZTHpdn0oY3Db1glR07u?=
 =?us-ascii?Q?RdCkZGAB6YXSoPqWO1ZTxrLH2RpZhAEZOE2vUyGnbwf+vj32EEFV3rF4ia+d?=
 =?us-ascii?Q?svb9DUxglHVABwjD4cj2UqNJoxncInlefmzci82xOyRQ9BJst9d5mSP1I8CE?=
 =?us-ascii?Q?qWkrYXjiJKL+8LXedsZEo0Bh5mQS8cruCM1lgKAoeT15zp0m23zv26ha5ICs?=
 =?us-ascii?Q?6Y0yucC1ETqSdrf+RFR6wEk8iFryRSEPsOakH3YeK1UkfduQEn3znjyJxk9N?=
 =?us-ascii?Q?6ygB9yyqtXMoXEXTEJXNDLoDihAqkT2n8phtsoyc2rwPsv6lNpuDZTbs7s1E?=
 =?us-ascii?Q?ksxba9Q8ntYiTZZgzELHGY7JDEuYfnysvdQ1KhRYFV+5eiU4c9ATU7c76l/e?=
 =?us-ascii?Q?JevlHAFE4AU/l89o9dqPUv+4moPsdFHIYZ1pOv4HGWc+lLR4Z8vHftxvJQlw?=
 =?us-ascii?Q?Mb+xamEypho/b8CQmlA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b30de-650c-4025-6735-08dcf3108e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 03:12:40.8249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbJdb1IqqwAh6d8Ox69SkOYOakqHtbFA/XzpG8Mq3pHew6o/9IlY7W7i77BgLYzzr0l2V30/SeMqV2c3no80vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889
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

Ping on the series.

Thanks,
Jiadong

> -----Original Message-----
> From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Sent: Wednesday, October 16, 2024 2:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>
> Subject: [PATCH v4 3/3] drm/amdgpu/sdma4.4.2: implement ring reset callba=
ck for
> sdma4.4.2
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback via SMU interface.
>
> v2: Leverage inst_stop/start functions in reset sequence.
>     Use GET_INST for physical SDMA instance.
>     Disable apu for sdma reset.
> v3: Rephrase error prints.
> v4: Remove redundant prints. Remove setting PREEMPT registers as
>     soft reset handles it.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 90 +++++++++++++++++++-----
>  1 file changed, 72 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c77889040760..29e2066a59ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct
> amdgpu_ring *ring, uint32_t rb_cntl)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> + * @restore: used to restore wptr when restart
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned =
int i)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned
> +int i, bool restore)
>  {
>       struct amdgpu_ring *ring =3D &adev->sdma.instance[i].ring;
>       u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct
> amdgpu_device *adev, unsigned int i)
>       WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>       WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>
> -     ring->wptr =3D 0;
> +     if (!restore)
> +             ring->wptr =3D 0;
>
>       /* before programing wptr to a less value, need set minor_ptr_updat=
e first */
>       WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>
>       /* Initialize the ring buffer's read and write pointers */
> -     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -     WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +     if (restore) {
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring-
> >wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI,
> upper_32_bits(ring->wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring-
> >wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI,
> upper_32_bits(ring->wptr << 2));
> +     } else {
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +     }
>
>       doorbell =3D RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>       doorbell_offset =3D RREG32_SDMA(i,
> regSDMA_GFX_DOORBELL_OFFSET); @@ -759,7 +768,7 @@ static void
> sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned=
 int
> i)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev,
> +unsigned int i, bool restore)
>  {
>       struct amdgpu_ring *ring =3D &adev->sdma.instance[i].page;
>       u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct
> amdgpu_device *adev, unsigned int i)
>       WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>
>       /* Initialize the ring buffer's read and write pointers */
> -     WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> -     WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> -     WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> -     WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +     if (restore) {
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring-
> >wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI,
> upper_32_bits(ring->wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring-
> >wptr << 2));
> +             WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI,
> upper_32_bits(ring->wptr << 2));
> +     } else {
> +             WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> +             WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> +             WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> +             WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +     }
>
>       /* set the wb address whether it's enabled or not */
>       WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI, @@ -792,7
> +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev,
> unsigned int i)
>       WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>       WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >>
> 40);
>
> -     ring->wptr =3D 0;
> +     if (!restore)
> +             ring->wptr =3D 0;
>
>       /* before programing wptr to a less value, need set minor_ptr_updat=
e first */
>       WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1); @@ -
> 916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct
> amdgpu_device *adev,
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
> -                               uint32_t inst_mask)
> +                               uint32_t inst_mask, bool restore)
>  {
>       struct amdgpu_ring *ring;
>       uint32_t tmp_mask;
> @@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devic=
e
> *adev,
>               sdma_v4_4_2_inst_enable(adev, false, inst_mask);
>       } else {
>               /* bypass sdma microcode loading on Gopher */
> -             if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP &&
> +             if (!restore && adev->firmware.load_type !=3D
> AMDGPU_FW_LOAD_PSP &&
>                   adev->sdma.instance[0].fw) {
>                       r =3D sdma_v4_4_2_inst_load_microcode(adev, inst_ma=
sk);
>                       if (r)
> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devic=
e
> *adev,
>               uint32_t temp;
>
>               WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -             sdma_v4_4_2_gfx_resume(adev, i);
> +             sdma_v4_4_2_gfx_resume(adev, i, restore);
>               if (adev->sdma.has_page_queue)
> -                     sdma_v4_4_2_page_resume(adev, i);
> +                     sdma_v4_4_2_page_resume(adev, i, restore);
>
>               /* set utc l1 enable flag always to 1 */
>               temp =3D RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
>       if (!amdgpu_sriov_vf(adev))
>               sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>
> -     r =3D sdma_v4_4_2_inst_start(adev, inst_mask);
> +     r =3D sdma_v4_4_2_inst_start(adev, inst_mask, false);
>
>       return r;
>  }
> @@ -1566,6 +1583,42 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>       return 0;
>  }
>
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned
> +int vmid) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     int i, r;
> +     u32 inst_mask;
> +
> +     if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
> +             return -EINVAL;
> +
> +     /* stop queue */
> +     inst_mask =3D 1 << ring->me;
> +     sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> +     if (adev->sdma.has_page_queue)
> +             sdma_v4_4_2_inst_page_stop(adev, inst_mask);
> +
> +     r =3D amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
> +     if (r)
> +             return r;
> +
> +     udelay(50);
> +
> +     for (i =3D 0; i < adev->usec_timeout; i++) {
> +             if (!REG_GET_FIELD(RREG32_SDMA(ring->me,
> regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
> +                     break;
> +             udelay(1);
> +     }
> +
> +     if (i =3D=3D adev->usec_timeout) {
> +             dev_err(adev->dev, "timed out waiting for SDMA%d unhalt aft=
er
> reset\n",
> +                     ring->me);
> +             return -ETIMEDOUT;
> +     }
> +
> +     return sdma_v4_4_2_inst_start(adev, inst_mask, true); }
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>                                       struct amdgpu_irq_src *source,
>                                       unsigned type,
> @@ -1948,6 +2001,7 @@ static const struct amdgpu_ring_funcs
> sdma_v4_4_2_ring_funcs =3D {
>       .emit_wreg =3D sdma_v4_4_2_ring_emit_wreg,
>       .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
> +     .reset =3D sdma_v4_4_2_reset_queue,
>  };
>
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D { =
@@ -
> 2160,7 +2214,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_=
t
> inst_mask)
>       if (!amdgpu_sriov_vf(adev))
>               sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>
> -     r =3D sdma_v4_4_2_inst_start(adev, inst_mask);
> +     r =3D sdma_v4_4_2_inst_start(adev, inst_mask, false);
>
>       return r;
>  }
> --
> 2.25.1

