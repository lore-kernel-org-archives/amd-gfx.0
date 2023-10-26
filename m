Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AFEC25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0AA710E7F7;
	Thu, 26 Oct 2023 14:16:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 039F910E7F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZbqicVSl5N2J5qwpsNiTz/gyu5KoHA8fGQvnf3bj3oznBAw39XNrwvaX0BDlATFAHJTdpN3BmlMpn35web5/k5vWXb5TsBcVO7udgYlnEb5xnIlWZ6aJqpjetHIXLeEUuQwMZWMlp3t9KZ6UrOpc3k8q6wuwQPEWJ0NgOAPDBWUvUgkO/M217EnsYGPG5Q0AO63HeHgQrkkLlPj0tetEX4w33G9PtCdQT/KI8GCXIiDHF2V0gWUiR3/EkRxMAsWchl0WhozIcNz5v2Wpamcy/p3J9cmIDDck2FF8T4bC+Ow+FmPVAD0zyAtLFzNwg07a32q4OhU+2ZBt2Vy6gnkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egyg78sUv39g/IHsBQS/qiUPVZSF4PBS7X0zN8DNm14=;
 b=mBP2IQ7mK/VF8kb4MpIFi6M75nHzHmA8J9HJfLq2sCqZXNVhaDZYyB7i2s6aHcLcSBw+uXPwHSLsJ/IQBC3JuwYkCi08zKMiT2K1KbEwQ86rBAB3pzGCE6PvV0sWg26REFkrmyK+Cmj+JyLay3CiIYvih7TSyDYjCt5yIQSfqKHuFdFEbXplYmJ1YRmDjl2HrIezqBQZ1zRsnUZILe26RyXgda5/v2N7nla+A3h9moC2njsJjxaDSAKwvghlLp6/lSSZHogeR2fo5keCy6CZw21eMUQekH2RQIXAos8CFnOZUgD1B+MJhHlQMHGzwDn4YMjaSzeb6aaNsr71T/yF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egyg78sUv39g/IHsBQS/qiUPVZSF4PBS7X0zN8DNm14=;
 b=GDGsA7HI1Ak9guGiyzE56EruhklbyojLL5g4G7erj9+o3VUnnr8M+PWaqAVRwKYrXZdzu7/ccwifDo3BrN750L8Yk5pBY0zefzd1lE993QKYVgY3KSumFKIfRNELvtMB+Y3T2foLFq6Wh1/bNTnl6CoVh/2seEvDWHysJ+kLbCk=
Received: from DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:16:19 +0000
Received: from DS0PR12MB8503.namprd12.prod.outlook.com
 ([fe80::7399:91ed:6cb5:d018]) by DS0PR12MB8503.namprd12.prod.outlook.com
 ([fe80::7399:91ed:6cb5:d018%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 14:16:18 +0000
From: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
 (v3)
Thread-Topic: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
 (v3)
Thread-Index: AQHaB4VbNpyAAT36vUq0WKqyy0u3ALBbunoAgABiwwg=
Date: Thu, 26 Oct 2023 14:16:18 +0000
Message-ID: <DS0PR12MB8503EA7B0AF48C0DBB484FCBFADDA@DS0PR12MB8503.namprd12.prod.outlook.com>
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
 <20231025205242.40490-3-victorchengchi.lu@amd.com>
 <66077329-08cb-8857-584c-1b14bbe23a11@amd.com>
In-Reply-To: <66077329-08cb-8857-584c-1b14bbe23a11@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-26T14:16:17.531Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8503:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: f5252046-7b35-4d34-70ec-08dbd62e1f72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: biV+7uaVDRTIS4flAAntnFPhMieDbfEuGvp8nlDQxZjFlL8FhzA74yXUjg1a0hEymupwiMJR7vvTcXxkYrb+uFALxDGN9w06WiM8dh1lr9tAO+0iLC4NC+eqnDBeQpJHzIa0F+CjJPN42XU+c7pTjts2bs5LRofxmCWjYKRBggG3jFNYqP3c3+GQazkzKJYPuaJ2gpzcxLoyanOQrC98AW0lKSmvqWQRu+qhzA79RXGGzWyYgUgRYApkOMhYKGz+lWp1aDyCxPZyqKuBic7qjyfCtwD8EbEXCsYF6+mEsEbnQvUk//j699z+WNgD8A5RWWsDsRkqnePOJcHbX9dve+Pxq5auQMJupQNRFxbpCFPfEJmzrQj0R8q/YSDGTsSofBPCBBgvWGqh+ZE1NrufgG5OktGpWTil0nioA9EV6CGKof/UuMJtWROmovEDjXaNToOuZDH+NEoZ8imup986dm87iERxT4IMeNKAsC7K5dOUQ35uVgObweJ/MxzMV04KsRGza8qF91wtyKNDItiyca+IWYsT1ZEpbyCCk0WJKMOrsKrCNVfOocJQCSPcJ3POt75MD5Re5anFdrp9wpnTTQKnzjkLg35gQObm9i7rN5vpXKQTg51+bpQO81m5EuQI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8503.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(38070700009)(19627405001)(30864003)(38100700002)(2906002)(55016003)(122000001)(52536014)(8676002)(8936002)(4326008)(33656002)(7696005)(71200400001)(91956017)(41300700001)(478600001)(66446008)(5660300002)(6506007)(66946007)(76116006)(110136005)(66556008)(64756008)(316002)(66476007)(83380400001)(86362001)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PHu0fMnhs5NOEwG+IyR60GR/7XTnYftnc00F7yDmAPgeYSvcpx0Qn/J6h6S8?=
 =?us-ascii?Q?u5OMDsOQGuJFO9EgvhcIrWH5iehDv6t28X2snZODra2tXCwPw1cH3TUlP/nU?=
 =?us-ascii?Q?y7hTwDkvpZ2qNob1CpcKv5d7Y7L4TRhAFMme7KBwLJxRNSFMmx3nlDENVl9j?=
 =?us-ascii?Q?l43BvqInUkYmw55DiEYw2k54TLpzUq7aOcAzC/3plPAGjImCds0nQLgiMDaj?=
 =?us-ascii?Q?Hdg7RPunaRe2g79Iccv2/0TA/4r1TB9gA6Lhz9SwGu+J9vkPWehUsXtt1Y4J?=
 =?us-ascii?Q?u6CW9RAmm2gUAgCtZLefRrOORZdsAK8bQTB+I8yINQ8oCEAIxxNn5q4ov2Pa?=
 =?us-ascii?Q?QYohZLM8lvnRZCcQKX9CTsOUGY0s1vVyMbjV35RiY5FPp3FUObgZpgBVmVAm?=
 =?us-ascii?Q?xuvsLMX9Nzt1+gExBC1rbuW0DYLTaZw5+akxQzGeNI8bJnQApWDwU/f0b/hQ?=
 =?us-ascii?Q?DQUS0egzkLbL1GMwbuqT1xiWQUL3gztMzdNIgwAZBzn9VLsA50fFSS2SXlQR?=
 =?us-ascii?Q?G8BL04cxNRDYCw0P1d3LLltRsnGq9Mg67FcXg1qU7vSPWWorWfQp16491J2G?=
 =?us-ascii?Q?O59dj/0W4IHHRmQBLW+CATQddgTVFJhDoSRCdAb/SI1z7WVMA0sxOLmkrgs0?=
 =?us-ascii?Q?9Qlr2rhKml1h/7SCl1mcxwchEqlBx76HoHRtyLTPNj3BHCIZjOh3XEAxWuSp?=
 =?us-ascii?Q?wM16mUs9Gndlr6pgvuPipgQD6/m9QOag2+vUxcqtfhGQslgQG1CYSeJsMX33?=
 =?us-ascii?Q?XqMFC/85qKqs02NyjYwXFlOBguEHaA25H412tymLDPNUs/lgPK6/Q5xgtlAF?=
 =?us-ascii?Q?7WfZi7k6wKL+WJmFbA45WhLBRCxrF/EQQhf4LDnLE4m5aIH4aLQiUaujp9mg?=
 =?us-ascii?Q?tsh7XuTkQSovbDWDPY5hJSL0VsbD7TbSqGbEh2UdXIqSfP2lKEDSoObC2S4h?=
 =?us-ascii?Q?2YsgdRjok2FsDjwy+/LZtS8X2JF3DxrW1jipPC9XgjsTYWIGmF/L//qkijPB?=
 =?us-ascii?Q?S0w2LGxbBZnSf3GoFOi2Hy5QyMgpJrIoiEU5I9997LD14V3pGWm8eFUKssOo?=
 =?us-ascii?Q?z6iKJXrVcsnOrthCjdm4cyXsSZTgnSTCw6it/IcgMwZR7fLd0EXTBHuj/8tQ?=
 =?us-ascii?Q?DPRLX1IOeNFGwfekbBDIhAfG01dno0l93gPySj6Sm30Du1l8t8N+froCMLKj?=
 =?us-ascii?Q?Me4W6WG21ejBMn8DTU1eHkKLvdsqU/e2Rpp7zqAGYQPP3lhynEug1r0B0jCY?=
 =?us-ascii?Q?cYxxW5vfECbFCSOarQGiro52aXP3QjcCKT1dPXh6GHfmz+wdul+XxOqgyya7?=
 =?us-ascii?Q?ZJjM2KLOUpX/jbbDqsdNbxSepem3yh7EJeWtjOJgKn9hguXOoLcRVC3Iw87h?=
 =?us-ascii?Q?hW1UKh4ZkR59aTzhL9R/RcMitkeV2zKb5w/q8reCbnZ+OyRmRGNalOIM3NZ8?=
 =?us-ascii?Q?h/94hRyh0otAzw0uz0xa0qpHk5LS2/xU/1MiYhdbYXf2d+wJrRIkxPwZL8I/?=
 =?us-ascii?Q?yvJF+DnTimOHjOg+RkkB9/q9LpFCZxZQi9qQMGmiwYPjF+5RlKsmqk/mldmY?=
 =?us-ascii?Q?EGCQLe1iBRsRKHDMk/k=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB8503EA7B0AF48C0DBB484FCBFADDADS0PR12MB8503namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5252046-7b35-4d34-70ec-08dbd62e1f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:16:18.7303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9juV4Bh5K12gQDQlnpa/atY5DekUgMEYiL8H/J298kacDqZwd4xa7k9Cp6L/RW6ACFHuQz4Uf+2wh+eoyGg6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DS0PR12MB8503EA7B0AF48C0DBB484FCBFADDADS0PR12MB8503namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Yes, I have tested this.

The (!amdgpu_sriov_runtime(adev) && adev->gfx.rlc.rlcg_reg_access_supported=
) conditions in amdgpu_device_xcc_wreg will guarantee it will go into amdgp=
u_virt_rlcg_reg_rw instead of looping back to WREG32_XCC.

Thanks,
Victor
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 26, 2023 4:16 AM
To: Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>; amd-gfx@list=
s.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Ming, Davis <Davis.Ming@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.=
3 (v3)



On 10/26/2023 2:22 AM, Victor Lu wrote:
> amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.
>
> Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC
> and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.
>
> v3: use W/RREG32_XCC to handle non-kiq case
>
> v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters
>      of amdgpu_device_wreg/rreg
>
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 ++-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 84 ++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  4 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  8 +-
>   8 files changed, 107 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a2e8c2b60857..09989ebb5da3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1168,11 +1168,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device =
*adev,
>                            uint32_t reg, uint32_t acc_flags);
>   u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
>                                    u64 reg_addr);
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +                             uint32_t reg, uint32_t acc_flags,
> +                             uint32_t xcc_id);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
>                        uint32_t reg, uint32_t v,
>                        uint32_t acc_flags);
>   void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
>                                     u64 reg_addr, u32 reg_data);
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +                         uint32_t reg, uint32_t v,
> +                         uint32_t acc_flags,
> +                         uint32_t xcc_id);
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>                             uint32_t reg, uint32_t v, uint32_t xcc_id);
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8=
_t value);
> @@ -1213,8 +1220,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_=
NO_KIQ)
>   #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDG=
PU_REGS_NO_KIQ)
>
> -#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
> -#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
> +#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)
> +#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)
>
>   #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>   #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
> @@ -1224,6 +1231,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
>   #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
>   #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
> +#define RREG32_XCC(reg, flag, inst) amdgpu_device_xcc_rreg(adev, (reg), =
flag, inst)
> +#define WREG32_XCC(reg, v, flag, inst) amdgpu_device_xcc_wreg(adev, (reg=
), (v), flag, inst)
>   #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
>   #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>   #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..c94df54e2657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_devi=
ce *adev, void *mqd,
>        hqd_end =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL=
_DISPATCH_ID_HI);
>
>        for (reg =3D hqd_base; reg <=3D hqd_end; reg++)
> -             WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +             WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, i=
nst);
>
>
>        /* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..47c8c334c779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, v=
oid *mqd,
>
>        for (reg =3D hqd_base;
>             reg <=3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ=
_WPTR_HI); reg++)
> -             WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +             WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, i=
nst);
>
>
>        /* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df05..9a35088b990a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -471,7 +471,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *ade=
v,
>                if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>                    amdgpu_sriov_runtime(adev) &&
>                    down_read_trylock(&adev->reset_domain->sem)) {
> -                     ret =3D amdgpu_kiq_rreg(adev, reg);
> +                     ret =3D amdgpu_kiq_rreg(adev, reg, 0);
>                        up_read(&adev->reset_domain->sem);
>                } else {
>                        ret =3D readl(((void __iomem *)adev->rmmio) + (reg=
 * 4));
> @@ -508,6 +508,48 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, =
uint32_t offset)
>        BUG();
>   }
>
> +
> +/**
> + * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect register
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Returns the 32 bit value from the offset specified.
> + */
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +                             uint32_t reg, uint32_t acc_flags,
> +                             uint32_t xcc_id)
> +{
> +     uint32_t ret;
> +
> +     if (amdgpu_device_skip_hw_access(adev))
> +             return 0;
> +
> +     if ((reg * 4) < adev->rmmio_size) {
> +             if ((acc_flags & AMDGPU_REGS_RLC) &&
> +                 (!amdgpu_sriov_runtime(adev)) &&
> +                 adev->gfx.rlc.rlcg_reg_access_supported) {
> +                     amdgpu_sriov_rreg(adev, reg, acc_flags, GC_HWIP, xc=
c_id);
> +             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +                 amdgpu_sriov_runtime(adev) &&
> +                 down_read_trylock(&adev->reset_domain->sem)) {
> +                     ret =3D amdgpu_kiq_rreg(adev, reg, xcc_id);
> +                     up_read(&adev->reset_domain->sem);
> +             } else {
> +                     ret =3D readl(((void __iomem *)adev->rmmio) + (reg =
* 4));
> +             }
> +     } else {
> +             ret =3D adev->pcie_rreg(adev, reg * 4);
> +     }
> +
> +     trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
> +
> +     return ret;
> +}
> +
>   /*
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
> @@ -555,7 +597,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>                if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>                    amdgpu_sriov_runtime(adev) &&
>                    down_read_trylock(&adev->reset_domain->sem)) {
> -                     amdgpu_kiq_wreg(adev, reg, v);
> +                     amdgpu_kiq_wreg(adev, reg, v, 0);
>                        up_read(&adev->reset_domain->sem);
>                } else {
>                        writel(v, ((void __iomem *)adev->rmmio) + (reg * 4=
));
> @@ -596,6 +638,44 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *a=
dev,
>        }
>   }
>
> +/**
> + * amdgpu_device_wreg - write to a memory mapped IO or indirect register=
 with specific XCC
> + *
> + * @adev: amdgpu_device pointer
> + * @reg: dword aligned register offset
> + * @v: 32 bit value to write to the register
> + * @acc_flags: access flags which require special behavior
> + * @xcc_id: xcc accelerated compute core id
> + *
> + * Writes the value specified to the offset specified.
> + */
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +                     uint32_t reg, uint32_t v,
> +                     uint32_t acc_flags, uint32_t xcc_id)
> +{
> +     if (amdgpu_device_skip_hw_access(adev))
> +             return;
> +
> +     if ((reg * 4) < adev->rmmio_size) {
> +             if ((acc_flags & AMDGPU_REGS_RLC) &&
> +                 (!amdgpu_sriov_runtime(adev)) &&
> +                 adev->gfx.rlc.rlcg_reg_access_supported) {
> +                     amdgpu_sriov_wreg(adev, reg, v, acc_flags, GC_HWIP,=
 xcc_id);


I see this path

WREG32_XCC -> amdgpu_device_xcc_wreg -> amdgpu_sriov_wreg -> WREG32_XCC

Similar for rreg. I'm not able to work out the RLC/sriov runtime
conditions. Is this tested before submitting?

Thanks,
Lijo
> +             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +                 amdgpu_sriov_runtime(adev) &&
> +                 down_read_trylock(&adev->reset_domain->sem)) {
> +                     amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> +                     up_read(&adev->reset_domain->sem);
> +             } else {
> +                     writel(v, ((void __iomem *)adev->rmmio) + (reg * 4)=
);
> +             }
> +     } else {
> +             adev->pcie_wreg(adev, reg * 4, v);
> +     }
> +
> +     trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
> +}
> +
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index c92e0aba69e1..60ae4bfdc7f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device=
 *adev,
>                func(adev, ras_error_status, i);
>   }
>
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint3=
2_t xcc_id)
>   {
>        signed long r, cnt =3D 0;
>        unsigned long flags;
>        uint32_t seq, reg_val_offs =3D 0, value =3D 0;
> -     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>        struct amdgpu_ring *ring =3D &kiq->ring;
>
>        if (amdgpu_device_skip_hw_access(adev))
> @@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev=
, uint32_t reg)
>        return ~0;
>   }
>
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v)
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v, uint32_t xcc_id)
>   {
>        signed long r, cnt =3D 0;
>        unsigned long flags;
>        uint32_t seq;
> -     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
>        struct amdgpu_ring *ring =3D &kiq->ring;
>
>        BUG_ON(!ring->funcs->emit_wreg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 7088c5015675..f23bafec71c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_devi=
ce *adev,
>   int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>                                  struct amdgpu_irq_src *source,
>                                  struct amdgpu_iv_entry *entry);
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v);
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint3=
2_t xcc_id);
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t =
v, uint32_t xcc_id);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t =
ucode_id);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index a0aa624f5a92..c6c8f4fed0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>        if (acc_flags & AMDGPU_REGS_NO_KIQ)
>                WREG32_NO_KIQ(offset, value);
>        else
> -             WREG32(offset, value);
> +             WREG32_XCC(offset, value, acc_flags, xcc_id);
>   }
>
>   u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
> @@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>        if (acc_flags & AMDGPU_REGS_NO_KIQ)
>                return RREG32_NO_KIQ(offset);
>        else
> -             return RREG32(offset);
> +             return RREG32_XCC(offset, acc_flags, xcc_id);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 386804f2e95c..b24db7974311 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interr=
upt_state(
>
>        switch (state) {
>        case AMDGPU_IRQ_STATE_DISABLE:
> -             mec_int_cntl =3D RREG32(mec_int_cntl_reg);
> +             mec_int_cntl =3D RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_R=
LC, xcc_id);
>                mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
>                                             TIME_STAMP_INT_ENABLE, 0);
> -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> +             WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC,=
 xcc_id);
>                break;
>        case AMDGPU_IRQ_STATE_ENABLE:
> -             mec_int_cntl =3D RREG32(mec_int_cntl_reg);
> +             mec_int_cntl =3D RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_R=
LC, xcc_id);
>                mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_=
INT_CNTL,
>                                             TIME_STAMP_INT_ENABLE, 1);
> -             WREG32(mec_int_cntl_reg, mec_int_cntl);
> +             WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC,=
 xcc_id);
>                break;
>        default:
>                break;

--_000_DS0PR12MB8503EA7B0AF48C0DBB484FCBFADDADS0PR12MB8503namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
Yes, I have tested this.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 ContentPasted=
1 ContentPasted2 ContentPasted3 ContentPasted4 ContentPasted5 ContentPasted=
6">
The (!amdgpu_sriov_runtime(adev) &amp;&amp; adev-&gt;gfx.rlc.rlcg_reg_acces=
s_supported) conditions in&nbsp;amdgpu_device_xcc_wreg will guarantee it wi=
ll go into&nbsp;amdgpu_virt_rlcg_reg_rw instead of looping back to WREG32_X=
CC.</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 ContentPasted=
1 ContentPasted2 ContentPasted3">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 ContentPasted=
1 ContentPasted2">
Thanks,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0 ContentPasted=
1 ContentPasted2">
Victor</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 26, 2023 4:16 AM<br>
<b>To:</b> Lu, Victor Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com&gt;;=
 amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Ming, Davis &lt;Davis.Ming@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for =
gfx9.4.3 (v3)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 10/26/2023 2:22 AM, Victor Lu wrote:<br>
&gt; amdgpu_kiq_wreg/rreg is hardcoded to use MEC engine 0.<br>
&gt; <br>
&gt; Add an xcc_id parameter to amdgpu_kiq_wreg/rreg, define W/RREG32_XCC<b=
r>
&gt; and amdgpu_device_xcc_wreg/rreg to to use the new xcc_id parameter.<br=
>
&gt; <br>
&gt; v3: use W/RREG32_XCC to handle non-kiq case<br>
&gt; <br>
&gt; v2: define amdgpu_device_xcc_wreg/rreg instead of changing parameters<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; of amdgpu_device_wreg/rreg<br>
&gt; <br>
&gt; Signed-off-by: Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 13 ++-<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c&nbsp;&nbsp; |&=
nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |&nbsp; 2 +-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p; | 84 ++++++++++++++++++-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 4 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 4 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 8 +-<br>
&gt;&nbsp;&nbsp; 8 files changed, 107 insertions(+), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index a2e8c2b60857..09989ebb5da3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1168,11 +1168,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags);<br>
&gt;&nbsp;&nbsp; u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *=
adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 reg_ad=
dr);<br>
&gt; +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcc_id);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_wreg(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t reg, uint32_t v,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t acc_flags);<br>
&gt;&nbsp;&nbsp; void amdgpu_device_indirect_wreg_ext(struct amdgpu_device =
*adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 =
reg_addr, u32 reg_data);<br>
&gt; +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 uint32_t reg, uint32_t v,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 uint32_t acc_flags,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 uint32_t xcc_id);<br>
&gt;&nbsp;&nbsp; void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; uint32_t reg, uint32_t v, uint32_t xcc_id);<br>
&gt;&nbsp;&nbsp; void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t =
offset, uint8_t value);<br>
&gt; @@ -1213,8 +1220,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev=
);<br>
&gt;&nbsp;&nbsp; #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg),=
 AMDGPU_REGS_NO_KIQ)<br>
&gt;&nbsp;&nbsp; #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (re=
g), (v), AMDGPU_REGS_NO_KIQ)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))<br>
&gt; -#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))<br>
&gt; +#define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg), 0)<br>
&gt; +#define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v), 0)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))<br>
&gt;&nbsp;&nbsp; #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))<br=
>
&gt; @@ -1224,6 +1231,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev=
);<br>
&gt;&nbsp;&nbsp; #define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v)=
, 0)<br>
&gt;&nbsp;&nbsp; #define REG_SET(FIELD, v) (((v) &lt;&lt; FIELD##_SHIFT) &a=
mp; FIELD##_MASK)<br>
&gt;&nbsp;&nbsp; #define REG_GET(FIELD, v) (((v) &lt;&lt; FIELD##_SHIFT) &a=
mp; FIELD##_MASK)<br>
&gt; +#define RREG32_XCC(reg, flag, inst) amdgpu_device_xcc_rreg(adev, (reg=
), flag, inst)<br>
&gt; +#define WREG32_XCC(reg, v, flag, inst) amdgpu_device_xcc_wreg(adev, (=
reg), (v), flag, inst)<br>
&gt;&nbsp;&nbsp; #define RREG32_PCIE(reg) adev-&gt;pcie_rreg(adev, (reg))<b=
r>
&gt;&nbsp;&nbsp; #define WREG32_PCIE(reg, v) adev-&gt;pcie_wreg(adev, (reg)=
, (v))<br>
&gt;&nbsp;&nbsp; #define RREG32_PCIE_PORT(reg) adev-&gt;pciep_rreg(adev, (r=
eg))<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
&gt; index 490c8f5ddb60..c94df54e2657 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c<br>
&gt; @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_d=
evice *adev, void *mqd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hqd_end =3D SOC15_REG_OFFSET=
(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D hqd_base; reg &=
lt;=3D hqd_end; reg++)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Activate doorbell logic b=
efore triggering WPTR poll. */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index 51011e8ee90d..47c8c334c779 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev=
, void *mqd,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (reg =3D hqd_base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; reg &lt;=3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI)=
; reg++)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Activate doorbell logic b=
efore triggering WPTR poll. */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 7ec32b44df05..9a35088b990a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -471,7 +471,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *=
adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_runtime(adev) &amp=
;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock(&amp;adev-&gt=
;reset_domain-&gt;sem)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_kiq_rreg=
(adev, reg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_kiq_rreg=
(adev, reg, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read=
(&amp;adev-&gt;reset_domain-&gt;sem);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 readl(((void __iomem *)adev-&gt;rmmio) + (reg * 4));<br>
&gt; @@ -508,6 +508,48 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *ade=
v, uint32_t offset)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +<br>
&gt; +/**<br>
&gt; + * amdgpu_device_xcc_rreg - read a memory mapped IO or indirect regis=
ter<br>
&gt; + *<br>
&gt; + * @adev: amdgpu_device pointer<br>
&gt; + * @reg: dword aligned register offset<br>
&gt; + * @acc_flags: access flags which require special behavior<br>
&gt; + * @xcc_id: xcc accelerated compute core id<br>
&gt; + *<br>
&gt; + * Returns the 32 bit value from the offset specified.<br>
&gt; + */<br>
&gt; +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, uint32_t acc_flags,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xcc_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_skip_hw_access(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((reg * 4) &lt; adev-&gt;rmmio_size) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((acc_flags &amp; AMDGPU_REGS_RLC) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (!amdgpu_sriov_runtime(adev)) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlcg_reg_access_supported) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_rreg(adev,=
 reg, acc_flags, GC_HWIP, xcc_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_runtime(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock(&amp;adev-&gt;reset_domain-&g=
t;sem)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_kiq_rreg=
(adev, reg, xcc_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;r=
eset_domain-&gt;sem);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D readl(((void __=
iomem *)adev-&gt;rmmio) + (reg * 4));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D adev-&gt;pcie_rreg(adev, reg * 4);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_device_rreg(adev-&gt;pdev-&gt;d=
evice, reg, ret);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * MMIO register write with bytes helper functions<br=
>
&gt;&nbsp;&nbsp;&nbsp; * @offset:bytes offset from MMIO start<br>
&gt; @@ -555,7 +597,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_runtime(adev) &amp=
;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock(&amp;adev-&gt=
;reset_domain-&gt;sem)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_kiq_wreg(adev, r=
eg, v);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_kiq_wreg(adev, r=
eg, v, 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read=
(&amp;adev-&gt;reset_domain-&gt;sem);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writel(=
v, ((void __iomem *)adev-&gt;rmmio) + (reg * 4));<br>
&gt; @@ -596,6 +638,44 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device=
 *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +/**<br>
&gt; + * amdgpu_device_wreg - write to a memory mapped IO or indirect regis=
ter with specific XCC<br>
&gt; + *<br>
&gt; + * @adev: amdgpu_device pointer<br>
&gt; + * @reg: dword aligned register offset<br>
&gt; + * @v: 32 bit value to write to the register<br>
&gt; + * @acc_flags: access flags which require special behavior<br>
&gt; + * @xcc_id: xcc accelerated compute core id<br>
&gt; + *<br>
&gt; + * Writes the value specified to the offset specified.<br>
&gt; + */<br>
&gt; +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, uint32_t =
v,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t acc_flags, uin=
t32_t xcc_id)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_skip_hw_access(adev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if ((reg * 4) &lt; adev-&gt;rmmio_size) {<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((acc_flags &amp; AMDGPU_REGS_RLC) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (!amdgpu_sriov_runtime(adev)) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.rlcg_reg_access_supported) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_wreg(adev,=
 reg, v, acc_flags, GC_HWIP, xcc_id);<br>
<br>
<br>
I see this path<br>
<br>
WREG32_XCC -&gt; amdgpu_device_xcc_wreg -&gt; amdgpu_sriov_wreg -&gt; WREG3=
2_XCC<br>
<br>
Similar for rreg. I'm not able to work out the RLC/sriov runtime <br>
conditions. Is this tested before submitting?<br>
<br>
Thanks,<br>
Lijo<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_runtime(adev) &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; down_read_trylock(&amp;adev-&gt;reset_domain-&g=
t;sem)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_kiq_wreg(adev, r=
eg, v, xcc_id);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; up_read(&amp;adev-&gt;r=
eset_domain-&gt;sem);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; writel(v, ((void __iome=
m *)adev-&gt;rmmio) + (reg * 4));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;pcie_wreg(adev, reg * 4, v);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_device_wreg(adev-&gt;pdev-&gt;d=
evice, reg, v);<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_device_indirect_rreg - read an indirect reg=
ister<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.c<br>
&gt; index c92e0aba69e1..60ae4bfdc7f5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; @@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; func(adev, ras_error_status, i);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)<br=
>
&gt; +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, ui=
nt32_t xcc_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long r, cnt =3D 0;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq, reg_val_offs =
=3D 0, value =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D &amp;adev-&gt;gfx=
.kiq[0];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D &amp;adev-&gt;gfx=
.kiq[xcc_id];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D=
 &amp;kiq-&gt;ring;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_skip_hw_ac=
cess(adev))<br>
&gt; @@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *a=
dev, uint32_t reg)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ~0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32=
_t v)<br>
&gt; +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32=
_t v, uint32_t xcc_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signed long r, cnt =3D 0;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t seq;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D &amp;adev-&gt;gfx=
.kiq[0];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D &amp;adev-&gt;gfx=
.kiq[xcc_id];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D=
 &amp;kiq-&gt;ring;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!ring-&gt;funcs-&gt;e=
mit_wreg);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.h<br>
&gt; index 7088c5015675..f23bafec71c5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; @@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_d=
evice *adev,<br>
&gt;&nbsp;&nbsp; int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src =
*source,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry=
 *entry);<br>
&gt; -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);<b=
r>
&gt; -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32=
_t v);<br>
&gt; +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, ui=
nt32_t xcc_id);<br>
&gt; +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32=
_t v, uint32_t xcc_id);<br>
&gt;&nbsp;&nbsp; int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);<br=
>
&gt;&nbsp;&nbsp; void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *ad=
ev, uint32_t ucode_id);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_virt.c<br>
&gt; index a0aa624f5a92..c6c8f4fed0c1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
&gt; @@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *ade=
v,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU_R=
EGS_NO_KIQ)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(offset, value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(offset, value);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_XCC(offset, value, acc_flags, xcc_id);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,<br>
&gt; @@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acc_flags &amp; AMDGPU_R=
EGS_NO_KIQ)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return RREG32_NO_KIQ(offset);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32(offset);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return RREG32_XCC(offset, acc_flags, xcc_id);<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; index 386804f2e95c..b24db7974311 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; @@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_int=
errupt_state(<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABL=
E:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIP=
E0_INT_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE=
:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32(mec_int_cntl_reg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mec_int_cntl =3D RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mec_int_cntl =3D REG_SET_FIELD(mec_int_cntl, CP_ME1_PIP=
E0_INT_CNTL,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TIME_STAMP_INT_ENABLE, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32(mec_int_cntl_reg, mec_int_cntl);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DS0PR12MB8503EA7B0AF48C0DBB484FCBFADDADS0PR12MB8503namp_--
