Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E8EC25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 09:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE62210E969;
	Fri, 27 Oct 2023 09:56:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9223310E969
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 09:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+mP6VV/ws8pw4b+upU/dSiC/NbCBmfV0iyhigVABjRPgIdbT8s7+Yo+rPhji4RxW13cs+S4KJ8VdLr43YQ6JtZHPeFLbf2k30eLOhy5sl/NRDTtGY265fiPxjF+WPBXg6dCsc/Mixh46BsX7oNOjoQ07A49911asHc+biqWV1HbJ5MzGzcMbI99aUPahS4NY5brkIiizE9WRjLj0/N+3XYTyoKvR954GVsQQms5FhEdH0rMNXyA1txVcPUxGAbUW8pB1tt0WJmLjaYZkGOILdXVx1BGHip43eVSm2cOABxf0SITdtUj9TpJN0538mgrUjyFfDMtiPz1km7Eff/X+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU+r28OPI6GkphndnH2gVIkOjgOcswTbs9duuVMLddc=;
 b=Guz6/RFFYAgmrpxQLhwuCfMnx+0Vzu/gvLplg1m8m52tiqQtkOIyVb5RrpQcdgk+mPaYM/ZWjf1dUbiS58upCJo/XJZfjHRGUPFs3D3SS1BwVxQqHL+a58hd7fBhkN0CYD7M0MWvClx+09DncOmBeaoljlQX/FOP6TJL+40v+kiN56Fb8bVU6p5X78LpPJWCS7zvToGoBv77plnHj8iW65BqNHGdH0ke9MCHEhcVW5JGdTKObbpF1mq9sWlcAnZx9WzBvP2daG8I9kDxKwDqnUzIlW1P462ariNar9mNQZH7fv7+1I0cRlLGidlhqgs3uovTgjilA710JqxBBMieFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU+r28OPI6GkphndnH2gVIkOjgOcswTbs9duuVMLddc=;
 b=K9LsY92rc9cmwLniarXHDgD9O5XpbUoAq/N1/Zarb29o0X/oEsjXvp/jRC2+5rZ9HAOsttiv6Fc8NRp0IMDlM9IMb9g82KWsOPwYVQX5yYM7/mvEfLA6p5d+x654CqVzgAtfcA7Ba2nXr44LQEr8DOlUod2aQ2L2qMiYOTb22b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 09:55:56 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3410:5919:f369:d9ca]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3410:5919:f369:d9ca%7]) with mapi id 15.20.6886.034; Fri, 27 Oct 2023
 09:55:56 +0000
Message-ID: <8d1c0dc9-7bb0-2549-6692-830845879de5@amd.com>
Date: Fri, 27 Oct 2023 15:25:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/5] drm/amdgpu: Use correct KIQ MEC engine for gfx9.4.3
 (v3)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <f68e701c-518d-9782-7da6-2f62f4aaa368@amd.com>
 <20231025205242.40490-1-victorchengchi.lu@amd.com>
 <20231025205242.40490-3-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231025205242.40490-3-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: a2205c5e-786a-4b58-66b9-08dbd6d2ea2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4lhaapYEqGlQNLBZs832F3SjyFbsJTpvkfddvH/sw4Y+fLM2LKMFv5JtT6RIzHE+zaOOE1u2Kdb6VjRTgqF72kgHSNKxQ3wdVpEEGmmZFFYy4vWBmGq5ZUeW7Ll9zrTVXsbmk/X3fF4l1ndAwMdPiCTE5PJ1WFTXgj5fruVJQuLF2CAE1poCxFc2p60VpyyyvIYFuywC3aCACzmNHHEJjiGwHfmwfXUTJoSXw+XvUXVNqVc5NrWOBh3x8noK4PilT+Duukh5j61G1n4mPrNTMg71kzqvMrxQzmeOJAAtE08cUCDOBP8KqWw8iXExn5Pj0cfTzl9+R+xPHziodRUSJTIZcfypD64QR0UGLd22MlUXlTmrk4qjrW0cKaYtpu56yTqCZ4/EurrJq0vDW4bnS6oi+eArg82m82jH4KabR7//ZVw1ahmcd/DT7SxIT2928YrSKBA3QrMh19imuSn5dQBn7Lx51vEOvhGuDQ4Vhh5PwGRl6rrekDonapOdlD4nzxQgr/nlU2KNHVybu6g5wHgp8yzhcHNBIVV6opgtReFn4YUcCcBG/iirTKaFWiFyLf/sm/EeQ2tW8qgWSiL7NhS02BTUrG5qcb0ESf9MqOLtAilJ3GUskjUOkVLpkDHirOY6huSnwQNiy2gaCVvDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(30864003)(66476007)(2906002)(86362001)(38100700002)(41300700001)(6666004)(478600001)(6506007)(66946007)(316002)(66556008)(6512007)(53546011)(6486002)(83380400001)(31696002)(36756003)(5660300002)(2616005)(4326008)(8676002)(8936002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1Ca3NhYklpZzQ0OGVXK2tDaTVOY1IzL1hVTmMwL0ZGcWJwTmNrZnVvSFNT?=
 =?utf-8?B?NXViVzZReXY2OGRCc3doZ2JsSlBTR3BXUklRM2V0Qzl4WmZjWmRFN1krS3JR?=
 =?utf-8?B?K2VhazNjWEg2NnE1eDN2WDBYUDRzYWxVMmFDekpDRjBJV05TR2Y2L1RURXM2?=
 =?utf-8?B?WER1R0lxNnVrTTR2VUxvUjk4TUJLV2pwTFk2VUZ6YXNycXRCTzlSZ1ZaMWlz?=
 =?utf-8?B?SEdjRkR2Umk0MkxVUDNuS2lBcDRkS0dnWHJ6VU1WbEErbVZTL2VQTnd6QWIy?=
 =?utf-8?B?TTh6alFaaTc4bVVRaVBlZy9FYi84Mkc3UDFKcXR2dm40czIxbSsyamgxU2hh?=
 =?utf-8?B?dVduV3R2S1c5SDhWRkluRTZmZTFFYmVHdnI1VThZUDBDTFh6L3U3RTNnTkJn?=
 =?utf-8?B?Nkk4K0RjT3RpM1EvNUkvWk40dWNWYzVKY3RsR2sxcFhyRHBIWGxVVjcwNWY1?=
 =?utf-8?B?ZFdLc3hBTnpRYzNZWXBpT09vc1R6NzBYaVdtS2ZBUFp1ZE5VYzVhS0pQWVFZ?=
 =?utf-8?B?NEMzSjRndldPcWR6N0ErSjhkZlJ4a3lwL2FoYTZYeE9aZ3lySHZWU1lncE1R?=
 =?utf-8?B?TVJPVlRUVWZ2d3hqc2J5bXgxQU90ZjY2K0wwaVJBVGFGNzAzUFpDVzY5R3BS?=
 =?utf-8?B?eUIveTZCNHJLZXZ4YkZ2OU1kNm5BNnRqN0puWEtGKytmaGZadTlxbmFlelVj?=
 =?utf-8?B?ckZncG52Z092RnN5a2VaY2ZTdzFzZXoveDdoc3U1Ym9UVmd4NmdlWUxOclBt?=
 =?utf-8?B?YmZLRE9kNHhUblVDUHVhYVAzNnRVcVh3SUQvSnJuSHkzUmI4eXZtMVQzaXZT?=
 =?utf-8?B?L0UwbGVqRS9QQ0JiQmRKMndIcFVtU2RtZ3AyNEluNlpjVys1UFlsOWxIRFhs?=
 =?utf-8?B?eTExaTI1Zkd4bkN0U3NsSERrSGhjOFUrU3hWMnFaVTl6Um1KTk80VFkvMldr?=
 =?utf-8?B?NWxJUzVUVTFUOWlROEFQZ0g5SU9RcWJYL2lHeXJnR3U5aVZvd1poU3lTOEVn?=
 =?utf-8?B?eGIxZmVldXJyV1EyNForRGh6K2gzWlFrWCtURWkyTjkxTWIySlVZOXhxMUsr?=
 =?utf-8?B?ZWNmMU00bjVjckpLNm9Ed0FMamNVbWF2SXRHdGxiSWJ5em03Q2tUZ2pkL2U3?=
 =?utf-8?B?ZmEvSmNXbCtLRFE3ZkpERjhGY05WeEVVRXQvMTBQVGd1aFVhNE56TXFPZktH?=
 =?utf-8?B?alRNaktFTWpGaWtpU1RMMXhVR1hNWUJVdW1XVEZQUG03WExzU0l3c3Q2enR5?=
 =?utf-8?B?TkRjNXVEUDVxckxGNzhDdFhWN2FWQ1RJNGJ5cTI0ZTY5cWlWY0Uva1B4dEV6?=
 =?utf-8?B?UGpPbXRXTFIzRFFlN1pBeGNkOUZadkc2c2VCZlRySWdIdlRPeXFSa3F2MlJo?=
 =?utf-8?B?TUJnZVl4TWhrYkVYWW05NkZWUnFpNXFaNU0yeUoyUkdOQkxlS1FZSEUvcUlC?=
 =?utf-8?B?M2pibjB6bE5YV2pSaDlWUDVFajhiNlR3UE45bmdYNGEyOE45UWJUMmNFbEIy?=
 =?utf-8?B?b2NNTFBlclhUczQrQ01lTVdHbDkwZWRYUkRScG4yVCtnY09lQlpyREJVK0tK?=
 =?utf-8?B?RWUzcENxdDVjcllDVndoZTJjaStkQ3lZVlkwcVV4OWw5UG1BZitSb21Fakt6?=
 =?utf-8?B?NnhNK3VzbWtFQVRYemhlbUdodnpKeUJMenpuU1Y2azMzcWgrLzk0YWE0R0ZD?=
 =?utf-8?B?WVBWVnh0QTZqWm45ZGlZV1FKb2F0YUlOQy83MlUyVWFuTHE5a09Oa1FkcWMw?=
 =?utf-8?B?azZNSFpGUXNEY1N2UkEweG84RFFZWSsxa29Md3BXeC9QLzAyZGtBVmhNelJa?=
 =?utf-8?B?N1NGcTJpK2pTM1B4MHhRZ3VscEY5elNVN1JKWEExWWt6d2FhQzlBQ1VoZG4v?=
 =?utf-8?B?d3d2Y0k1UDM4SlZXSlBvN2xpTHgvQnhTZE9PSVNyVUZvVGtHR292Y1ZmK0tx?=
 =?utf-8?B?d1RMVG94b0RoTFZJUVI5U0EyZS83bFY0TzlHaHVpbm83b2pFdEdLd3lTNzNG?=
 =?utf-8?B?aWh2Y3Q5eld6MWdKZ1RTVTRoSDU2ck1MNEllNlZkQVlYdCtxQTk3cm5vR0R3?=
 =?utf-8?B?THFETWtLaXVaemdkMUZlOEo0QURtSWRaejZSUitMcTZGOWZDaHRaRXVuL0xS?=
 =?utf-8?Q?7j+5JbfP9arYP3lTSo7gRVBa/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2205c5e-786a-4b58-66b9-08dbd6d2ea2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 09:55:56.6841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afkLKUA94Z1le5r5btcPE9dAto/OYjRz9VWn6FgUbTvtDXPwg39rfQTnLqpeLeO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a2e8c2b60857..09989ebb5da3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1168,11 +1168,18 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   			    uint32_t reg, uint32_t acc_flags);
>   u32 amdgpu_device_indirect_rreg_ext(struct amdgpu_device *adev,
>   				    u64 reg_addr);
> +uint32_t amdgpu_device_xcc_rreg(struct amdgpu_device *adev,
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id);
>   void amdgpu_device_wreg(struct amdgpu_device *adev,
>   			uint32_t reg, uint32_t v,
>   			uint32_t acc_flags);
>   void amdgpu_device_indirect_wreg_ext(struct amdgpu_device *adev,
>   				     u64 reg_addr, u32 reg_data);
> +void amdgpu_device_xcc_wreg(struct amdgpu_device *adev,
> +			    uint32_t reg, uint32_t v,
> +			    uint32_t acc_flags,
> +			    uint32_t xcc_id);
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   			     uint32_t reg, uint32_t v, uint32_t xcc_id);
>   void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
> @@ -1213,8 +1220,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>   #define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
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
> +#define RREG32_XCC(reg, flag, inst) amdgpu_device_xcc_rreg(adev, (reg), flag, inst)
> +#define WREG32_XCC(reg, v, flag, inst) amdgpu_device_xcc_wreg(adev, (reg), (v), flag, inst)
>   #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
>   #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>   #define RREG32_PCIE_PORT(reg) adev->pciep_rreg(adev, (reg))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..c94df54e2657 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -300,7 +300,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
>   	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
>   
>   	for (reg = hqd_base; reg <= hqd_end; reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..47c8c334c779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -239,7 +239,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
>   
>   	for (reg = hqd_base;
>   	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_XCC(reg, mqd_hqd[reg - hqd_base], AMDGPU_REGS_RLC, inst);
>   
>   
>   	/* Activate doorbell logic before triggering WPTR poll. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df05..9a35088b990a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -471,7 +471,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			ret = amdgpu_kiq_rreg(adev, reg);
> +			ret = amdgpu_kiq_rreg(adev, reg, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -508,6 +508,48 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   	BUG();
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
> +				uint32_t reg, uint32_t acc_flags,
> +				uint32_t xcc_id)
> +{
> +	uint32_t ret;
> +
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return 0;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if ((acc_flags & AMDGPU_REGS_RLC) &&
> +		    (!amdgpu_sriov_runtime(adev)) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported) {
> +			amdgpu_sriov_rreg(adev, reg, acc_flags, GC_HWIP, xcc_id);

Since amdgpu_device_xcc_rreg is a new interface and used specifically 
for GFX v9.4.3, suggest to merge all cases of access inside this itself 
rather than going to sriov_rreg. You may be able to simplify it then 
since there is no need to consider any legacy style accesses.

List the specific cases for GFX v9.4.3 like KIQ access, RLC access, 
direct etc. and handle only those. Any legacy logic can be dropped then 
since WREG32_XCC is not used for any common/legacy paths.

> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		ret = adev->pcie_rreg(adev, reg * 4);
> +	}
> +
> +	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
> +
> +	return ret;
> +}
> +
>   /*
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
> @@ -555,7 +597,7 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
>   		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>   		    amdgpu_sriov_runtime(adev) &&
>   		    down_read_trylock(&adev->reset_domain->sem)) {
> -			amdgpu_kiq_wreg(adev, reg, v);
> +			amdgpu_kiq_wreg(adev, reg, v, 0);
>   			up_read(&adev->reset_domain->sem);
>   		} else {
>   			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> @@ -596,6 +638,44 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * amdgpu_device_wreg - write to a memory mapped IO or indirect register with specific XCC
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
> +			uint32_t reg, uint32_t v,
> +			uint32_t acc_flags, uint32_t xcc_id)
> +{
> +	if (amdgpu_device_skip_hw_access(adev))
> +		return;
> +
> +	if ((reg * 4) < adev->rmmio_size) {
> +		if ((acc_flags & AMDGPU_REGS_RLC) &&
> +		    (!amdgpu_sriov_runtime(adev)) &&
> +		    adev->gfx.rlc.rlcg_reg_access_supported) {
> +			amdgpu_sriov_wreg(adev, reg, v, acc_flags, GC_HWIP, xcc_id);
> +		} else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> +		    amdgpu_sriov_runtime(adev) &&
> +		    down_read_trylock(&adev->reset_domain->sem)) {
> +			amdgpu_kiq_wreg(adev, reg, v, xcc_id);
> +			up_read(&adev->reset_domain->sem);
> +		} else {
> +			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
> +		}
> +	} else {
> +		adev->pcie_wreg(adev, reg * 4, v);
> +	}
> +
> +	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
> +}
> +
>   /**
>    * amdgpu_device_indirect_rreg - read an indirect register
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c92e0aba69e1..60ae4bfdc7f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -929,12 +929,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>   		func(adev, ras_error_status, i);
>   }
>   
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq, reg_val_offs = 0, value = 0;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	if (amdgpu_device_skip_hw_access(adev))
> @@ -997,12 +997,12 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	return ~0;
>   }
>   
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id)
>   {
>   	signed long r, cnt = 0;
>   	unsigned long flags;
>   	uint32_t seq;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
>   	BUG_ON(!ring->funcs->emit_wreg);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 7088c5015675..f23bafec71c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -521,8 +521,8 @@ int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>   int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
>   				  struct amdgpu_irq_src *source,
>   				  struct amdgpu_iv_entry *entry);
> -uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
> -void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
> +uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_id);
> +void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t xcc_id);
>   int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
>   void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a0aa624f5a92..c6c8f4fed0c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1076,7 +1076,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
>   	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>   		WREG32_NO_KIQ(offset, value);
>   	else
> -		WREG32(offset, value);
> +		WREG32_XCC(offset, value, acc_flags, xcc_id);
#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)

In this definition access flags are explicitly set to 0. I guess same 
should be applied here.
>   }
>   
>   u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
> @@ -1091,5 +1091,5 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
>   	if (acc_flags & AMDGPU_REGS_NO_KIQ)
>   		return RREG32_NO_KIQ(offset);
>   	else
> -		return RREG32(offset);
> +		return RREG32_XCC(offset, acc_flags, xcc_id);

Same case as with WREG32.
#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)

Flags value needs to be 0 then.

If you are merging the valid accesses inside amdgpu_device_xcc_wreg, 
then both of these modifications can be dropped.

>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 386804f2e95c..b24db7974311 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
>   
>   	switch (state) {
>   	case AMDGPU_IRQ_STATE_DISABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
Below is the definition of RREG32. It passes 0 as access flags.
#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)

With the change, it's passing AMDGPU_REGS_RLC. Is this specific for GFX 
9.4.3? If so, it should be a separate patch. Same goes for other changes 
below.

Thanks,
Lijo
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 0);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
>   		break;
>   	case AMDGPU_IRQ_STATE_ENABLE:
> -		mec_int_cntl = RREG32(mec_int_cntl_reg);
> +		mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, AMDGPU_REGS_RLC, xcc_id);
>   		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
>   					     TIME_STAMP_INT_ENABLE, 1);
> -		WREG32(mec_int_cntl_reg, mec_int_cntl);
> +		WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, AMDGPU_REGS_RLC, xcc_id);
>   		break;
>   	default:
>   		break;
