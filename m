Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D993CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 16:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3128410E925;
	Thu,  9 Dec 2021 16:53:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D219289E65
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 12:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9iHUPYDDQ5/QxGujRu6ax8Ax6IGL4uRQWCPLZ26+7KtnhHiHVv0w5N9wBVqiAZrk8wiouDZq25ojBZD5K0j+hTldKGsf7+ppSxaWYVTaOYHNpx6/Udg+BA+Av82HH1ZujOycH/0j6MeHc+NdYmDA8scBYXfKjMKMzddoTndc6EjddL4DeN2vKscU+vNIbzX5w6srwlqrYnMDPGvJZ6q/oIeX2ZVjBgC8FtLrpYMQqUMoYLo5MGadb1/X3vHUv4R8CBJ9MWyFRH0D0y4wkZlFVlSnY+GjsktOQ2blUqxDUd1XRQ2OWCs1WcqipQ4Z5jaq2l/QxEjuKae0xYhYyhAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I200/4BqTXUCsDsor6u4b3gj+YtkinOLIQqv32rsVsM=;
 b=kB67nPI90qyo2uHcDibGE0/W8eYT5XWaF+E2fV0QzxzEutLVSeyHdwCKdbJ3A1Xvf6Ylj6MzUUm/zgGFfp1nd4jLQLCge/5bL7iV+2ELnxbeaTY4mzwejF/scTBPGgm3aNahdCHARJeMaaLw7KZfxQNf65f2tvam/HNb0Oh8Tje9zmst/zmmnjcMbG4ro9zXlRQsphxYLTfs/PQ9QoJJvgY0yBM6TyOGcuEN2wI/FFy8kZFbtSuJxWr1SgAUaxQ0Xx7PvmznHQJLLL3dS2RMPZXGKZOX21QR3C/WBSzq+Q4YqyGz8YBRnMnxxUTl5+w3utVMOBjQS5eZMuXKonRyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I200/4BqTXUCsDsor6u4b3gj+YtkinOLIQqv32rsVsM=;
 b=R3Zuxtte4AIwhdoARVMdK8DfHjJMWSzQvkYv9cE4xy1JCAFgaikJrg+5DFFciRuVFsAmBaucbARMUKWCkjAmkSDaGhoe/YvdZ6DKDqT4ecFGadcZPp9OaQbEzHb/u29mODFqVQEmFaSUzfMS2zpWUNL8xyHAPAqCPEoCnM8itys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:08:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 12:08:52 +0000
Message-ID: <865156ff-a640-370f-9624-ceb2edc7e0d6@amd.com>
Date: Thu, 9 Dec 2021 17:38:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 05/17] drm/amd/pm: do not expose those APIs used
 internally only in si_dpm.c
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211203030540.1710564-1-evan.quan@amd.com>
 <20211203030540.1710564-5-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211203030540.1710564-5-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6f5b97-acaa-43f6-4581-08d9bb0caa3a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40093E581F83C819EF2E2D8397709@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRpCYHrkaOsWb5RugLFNJt+Q6vYwZMjgvCZaFs0Eyj3svJEcv1gXH3mzW+R+znTsDXfUiynuhgf4s3cvku+GPp2WTuHL7+362FsKbXH0xty/dCA3ouCOtopcgFrbsi6gxG8mcY6HPckY64Xbd+g4BkK3xIHSeNrPneBycQboum2XB6XjKXuDlMtWenSra1u3EjERJcPpYrd+RrVxqeMDTqc7o1b3K+C3BEt7JTAMXB+aKueN9PgJ9Droy6rhw2Do6fF+XmEbGRy21JAb1wg7QGKLcmbRtYgNpLFdSrak/Eqg9RV0Fm2u6Sd6Idpxxr4gKLzmEX67JTyMEkkuWEeh3TyDn1i46hg9H4bkob1OFcQWRwDjKtDWkjqgShmIMOM1IfUqbxwsWhr17nmXCt0xM4kwdbNQIKjHuUA2T/S9bC6lZjVhQlekmft6ywEYw13pCyjJZd+Ahc129Ik/+mmjMow/BBm9XRyF37wU1wIs1kTsa7+9sLYbntOPA5mgNTbWZTrNhgnzW+C3ALcl1NNSlWDHAaf6oc8gxJqz/kJJTikmIqJDZeV8sjq3IwE/NMAZ+kI3Kz2GhddY51MMR86YMGTMhF58h1lkew4gWqZffxDTn4KpE98S9la5rOO4Shag5SiqbeAmJWtjaGIESnaSTqceg+1a8rG1uCT7s3i458HQ2Bc9yl9tKRYDbDVb0ip/b/bnioSXK+D+qZhN5pjA+jPNEP58JxbuqMmhFodf5fA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(6666004)(53546011)(6486002)(316002)(2906002)(31696002)(6512007)(86362001)(31686004)(66476007)(66556008)(66946007)(508600001)(83380400001)(26005)(8676002)(36756003)(186003)(5660300002)(8936002)(4326008)(2616005)(30864003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRtWVlxcDFoM0xzUC9zN2UxRjF5ZGMwVE9DaDluTGZ2RjZvMGFEL1c3WVFO?=
 =?utf-8?B?cmFSa3kzVEgybWRaTHM0bzl3VCtFemdoR2JVTEgyMXhXUHhob2s2M2xoYlY1?=
 =?utf-8?B?dHQ2YXlObVBmVU02clRmOVIrMEEzdjhRZlRYVy9nZkg5MnZyMEY1Q0tET0F1?=
 =?utf-8?B?WXJrbkw1SEtkdlFYN3NsaWNkUXlTdUVSb0xRRGZRbUpJU293dVFIY0NLZTN5?=
 =?utf-8?B?YXZsa1g2WUx2Z0lWQU16c0M2RTBuUDN4Wlh2KzYrOFdneHExSkVoRXZ2dmNC?=
 =?utf-8?B?bDVsN2NBeUNzM2tYdmVuYlNSaU1zTXFDYXN2a0Z4WDlhOGlhVXVOamxkamU2?=
 =?utf-8?B?bWhBSFBXZVJRcWxUYk1XOWtpWFhrSUg2KyttZ3I1VEswdVltdlpaWVBzMCth?=
 =?utf-8?B?TXY2OEhOY2orNjlZeHI2eDJKWEp1MUJDL1BZZ1o3NDQ4Nk9SWStNSnl0RTdF?=
 =?utf-8?B?bVJucC82Ri9POE5DaDF3aXF0ZW52cjRmcEptMHhyUUQ0L2Z4T3l3MW1nN1l6?=
 =?utf-8?B?bjFvNThwVEd5Skc1aHFBblNsOUJBb3pyb2kxcXJJNjhLMjV4OXcvY1FNQlRz?=
 =?utf-8?B?VG9UZTZ1QitDVW5ub0dDY2g0dTlISjl4Yk9ibzhUektrRHJRRVIvVTNOOHBy?=
 =?utf-8?B?RVRnU0x6R1pqVXFCZExXVXBKMllkWEtxUytLZ1F0ZEduTmNmNHhpbmZPa0NB?=
 =?utf-8?B?RGxkc1ZWaldBdVlYQVJyRUYvdFRYcHJvU0EwYTF6ZHBtSmUyWjhOa2tQNDYx?=
 =?utf-8?B?RWw2TlFPWnc3VUl6Y3BUUjV3NGFsa25OdGlsaDRQMUVmZVEyM1BlTlFrTkh3?=
 =?utf-8?B?OXQxc3p1ZTlZdDgwaGQveFRZdWxpNThtYmFTS21ZcFdJU3Vxc085MDZFUWEr?=
 =?utf-8?B?UlBBU0ZCTUtVUEc2bDdUMUEwSWZuZXBJaE1QWVFwdGRkMHI3YkNLTnY4MlZu?=
 =?utf-8?B?TklDNTZhZ0kvbmE5QkVoMG81akRnblFyOTFWcURNNkNHMmlodmVLbE9xeUJ4?=
 =?utf-8?B?VmdBY0duYVRJc0Z0eVEwYThHSUtWb25UK0pKaW1wbFJjQjQzVCtYbXF3QWNW?=
 =?utf-8?B?cy9DQmF6RWtrbWxtUzVMMEg3RTFWb2FaT21YeE1lZW9aSGh4MnpoQzYyaU5a?=
 =?utf-8?B?TDg2ckxLS1VGWWltZ2RBY3pZWlJpdzhJUkY5Z01kQ3BBSEx6VFp6NkRZNGJG?=
 =?utf-8?B?WFN1bElBS2psRk1YdGRBV2s4TVZydCtQUmxUU0ZQRFB5ZXFYaWxxMnVkQ1k3?=
 =?utf-8?B?L0NvS2JhME9lMmJPcGRhZnhQLzdGUlkvU2w3dTNwYzVJOHNPdEpKRGdzUDlh?=
 =?utf-8?B?SFpTMkcvd2ZSTXFCNFpoL0M4Wm9RSE5sREZNaXhtVkVKSVgvelMvcVRNeEJS?=
 =?utf-8?B?U2s3MW44VVRBdlp5SlpzQ3VpUFE3aWQ3VnBkVkpqL3MwM1ZXY3JaSHN3QzNx?=
 =?utf-8?B?Z2ROZGkyQk04VkY3OHNWUlV6MVl1U2R1VzRlNHpQVzRqYkFsRVMxa255cFlY?=
 =?utf-8?B?WkhRWG8zQnZlSTN6U3ZJaVUveThjRU1FOS9qZmw2cWNtcnVnM3VScWJBdzFy?=
 =?utf-8?B?bTlrQm5BWHpoVUtEMGF2SUhqOGM0WEtRd2QvL2VTZE9va1hkcW1YMTk1bkxI?=
 =?utf-8?B?Q3FUd3E2MzQ0ZDZwR1VkMEwwWThvRVAvTDVDcDhnd0RWYnNPOC9TUFpoWXlw?=
 =?utf-8?B?czNvSjlnWHlyakxGL2RyaHBzbElmSjJZcStodk9UOXEreDA0dWg2NGlFcmdV?=
 =?utf-8?B?TTZuVzhnWDdSbTdkdzNRc3lDK2VtWmgxVzFQSmRYc0ZFczh0dStadWxuWjFk?=
 =?utf-8?B?VFlYT2FuTEZOb2dVZERHT3hRV2FVcklGRitESTl5S09UT2NHK2pYUWlhbDZo?=
 =?utf-8?B?UEtmVFNpSk5WM1dvN2d5anZ1UWhTZ3NxaFlCKzEwNFJyU2tBQ3FPUzJ1cEw3?=
 =?utf-8?B?ZHQyak4wQUcvZzN4U2Vqckc1VEk4azgvc25vQS9HV2haYWh5WHEwQXFUMzc3?=
 =?utf-8?B?aUdvdE9Ha0VWUFlrRlZKT2F3bm5Jdytyc3RHN3MxY1dPdWpvL2lHY3VRWW03?=
 =?utf-8?B?ekI0aEJlZ1NJYlFVbVVrald3bkhvWWM5TjBnQ1F2Y0NvMVRSSVVzbmc1Vko1?=
 =?utf-8?Q?2BOE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f5b97-acaa-43f6-4581-08d9bb0caa3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 12:08:52.3710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0yh2ZZs6Bs1fklTZ0JTLBikMvv+WQWxT5FoEpdH91Jme4grFJI7o4YK5d6RLOYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/3/2021 8:35 AM, Evan Quan wrote:
> Move them to si_dpm.c instead.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I288205cfd7c6ba09cfb22626ff70360d61ff0c67
> --
> v1->v2:
>    - rename the API with "si_" prefix(Alex)
> v2->v3:
>    - rename other data structures used only in si_dpm.c(Lijo)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c       |  25 -----
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  25 -----
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 106 +++++++++++++++-------
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  15 ++-
>   4 files changed, 83 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 72a8cb70d36b..b31858ad9b83 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -894,31 +894,6 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
>   	}
>   }
>   
> -enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
> -						 u32 sys_mask,
> -						 enum amdgpu_pcie_gen asic_gen,
> -						 enum amdgpu_pcie_gen default_gen)
> -{
> -	switch (asic_gen) {
> -	case AMDGPU_PCIE_GEN1:
> -		return AMDGPU_PCIE_GEN1;
> -	case AMDGPU_PCIE_GEN2:
> -		return AMDGPU_PCIE_GEN2;
> -	case AMDGPU_PCIE_GEN3:
> -		return AMDGPU_PCIE_GEN3;
> -	default:
> -		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
> -		    (default_gen == AMDGPU_PCIE_GEN3))
> -			return AMDGPU_PCIE_GEN3;
> -		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
> -			 (default_gen == AMDGPU_PCIE_GEN2))
> -			return AMDGPU_PCIE_GEN2;
> -		else
> -			return AMDGPU_PCIE_GEN1;
> -	}
> -	return AMDGPU_PCIE_GEN1;
> -}
> -
>   struct amd_vce_state*
>   amdgpu_get_vce_clock_state(void *handle, u32 idx)
>   {
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 6681b878e75f..f43b96dfe9d8 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -45,19 +45,6 @@ enum amdgpu_int_thermal_type {
>   	THERMAL_TYPE_KV,
>   };
>   
> -enum amdgpu_dpm_auto_throttle_src {
> -	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
> -	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
> -};
> -
> -enum amdgpu_dpm_event_src {
> -	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
> -	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
> -	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
> -	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
> -	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
> -};
> -
>   struct amdgpu_ps {
>   	u32 caps; /* vbios flags */
>   	u32 class; /* vbios flags */
> @@ -252,13 +239,6 @@ struct amdgpu_dpm_fan {
>   	bool ucode_fan_control;
>   };
>   
> -enum amdgpu_pcie_gen {
> -	AMDGPU_PCIE_GEN1 = 0,
> -	AMDGPU_PCIE_GEN2 = 1,
> -	AMDGPU_PCIE_GEN3 = 2,
> -	AMDGPU_PCIE_GEN_INVALID = 0xffff
> -};
> -
>   #define amdgpu_dpm_reset_power_profile_state(adev, request) \
>   		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
>   			(adev)->powerplay.pp_handle, request))
> @@ -403,11 +383,6 @@ void amdgpu_free_extended_power_table(struct amdgpu_device *adev);
>   
>   void amdgpu_add_thermal_controller(struct amdgpu_device *adev);
>   
> -enum amdgpu_pcie_gen amdgpu_get_pcie_gen_support(struct amdgpu_device *adev,
> -						 u32 sys_mask,
> -						 enum amdgpu_pcie_gen asic_gen,
> -						 enum amdgpu_pcie_gen default_gen);
> -
>   struct amd_vce_state*
>   amdgpu_get_vce_clock_state(void *handle, u32 idx);
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 81f82aa05ec2..ab0fa6c79255 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -96,6 +96,19 @@ union pplib_clock_info {
>   	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
>   };
>   
> +enum si_dpm_auto_throttle_src {
> +	DPM_AUTO_THROTTLE_SRC_THERMAL,
> +	DPM_AUTO_THROTTLE_SRC_EXTERNAL
> +};
> +

Since the final usage is something like (1 << 
DPM_AUTO_THROTTLE_SRC_EXTERNAL), it's better to associate the SI context 
also along with that - SI_DPM_AUTO_THROTTLE_SRC_EXTERNAL - to denote 
that these are SI specific values.

Thanks,
Lijo

> +enum si_dpm_event_src {
> +	DPM_EVENT_SRC_ANALOG = 0,
> +	DPM_EVENT_SRC_EXTERNAL = 1,
> +	DPM_EVENT_SRC_DIGITAL = 2,
> +	DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
> +	DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
> +};
> +
>   static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =
>   {
>   	R600_UTC_DFLT_00,
> @@ -3718,25 +3731,25 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
>   {
>   	struct rv7xx_power_info *pi = rv770_get_pi(adev);
>   	bool want_thermal_protection;
> -	enum amdgpu_dpm_event_src dpm_event_src;
> +	enum si_dpm_event_src dpm_event_src;
>   
>   	switch (sources) {
>   	case 0:
>   	default:
>   		want_thermal_protection = false;
>   		break;
> -	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL):
> +	case (1 << DPM_AUTO_THROTTLE_SRC_THERMAL):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGITAL;
> +		dpm_event_src = DPM_EVENT_SRC_DIGITAL;
>   		break;
> -	case (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
> +	case (1 << DPM_AUTO_THROTTLE_SRC_EXTERNAL):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_EXTERNAL;
> +		dpm_event_src = DPM_EVENT_SRC_EXTERNAL;
>   		break;
> -	case ((1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
> -	      (1 << AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL)):
> +	case ((1 << DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
> +	      (1 << DPM_AUTO_THROTTLE_SRC_THERMAL)):
>   		want_thermal_protection = true;
> -		dpm_event_src = AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
> +		dpm_event_src = DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL;
>   		break;
>   	}
>   
> @@ -3750,7 +3763,7 @@ static void si_set_dpm_event_sources(struct amdgpu_device *adev, u32 sources)
>   }
>   
>   static void si_enable_auto_throttle_source(struct amdgpu_device *adev,
> -					   enum amdgpu_dpm_auto_throttle_src source,
> +					   enum si_dpm_auto_throttle_src source,
>   					   bool enable)
>   {
>   	struct rv7xx_power_info *pi = rv770_get_pi(adev);
> @@ -4927,6 +4940,31 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static enum si_pcie_gen si_gen_pcie_gen_support(struct amdgpu_device *adev,
> +						u32 sys_mask,
> +						enum si_pcie_gen asic_gen,
> +						enum si_pcie_gen default_gen)
> +{
> +	switch (asic_gen) {
> +	case PCIE_GEN1:
> +		return PCIE_GEN1;
> +	case PCIE_GEN2:
> +		return PCIE_GEN2;
> +	case PCIE_GEN3:
> +		return PCIE_GEN3;
> +	default:
> +		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
> +		    (default_gen == PCIE_GEN3))
> +			return PCIE_GEN3;
> +		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
> +			 (default_gen == PCIE_GEN2))
> +			return PCIE_GEN2;
> +		else
> +			return PCIE_GEN1;
> +	}
> +	return PCIE_GEN1;
> +}
> +
>   static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>   				      SISLANDS_SMC_STATETABLE *table)
>   {
> @@ -4989,10 +5027,10 @@ static int si_populate_smc_acpi_state(struct amdgpu_device *adev,
>   							      &table->ACPIState.level.std_vddc);
>   		}
>   		table->ACPIState.level.gen2PCIE =
> -			(u8)amdgpu_get_pcie_gen_support(adev,
> -							si_pi->sys_pcie_mask,
> -							si_pi->boot_pcie_gen,
> -							AMDGPU_PCIE_GEN1);
> +			(u8)si_gen_pcie_gen_support(adev,
> +						    si_pi->sys_pcie_mask,
> +						    si_pi->boot_pcie_gen,
> +						    PCIE_GEN1);
>   
>   		if (si_pi->vddc_phase_shed_control)
>   			si_populate_phase_shedding_value(adev,
> @@ -5430,7 +5468,7 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
>   	bool gmc_pg = false;
>   
>   	if (eg_pi->pcie_performance_request &&
> -	    (si_pi->force_pcie_gen != AMDGPU_PCIE_GEN_INVALID))
> +	    (si_pi->force_pcie_gen != PCIE_GEN_INVALID))
>   		level->gen2PCIE = (u8)si_pi->force_pcie_gen;
>   	else
>   		level->gen2PCIE = (u8)pl->pcie_gen;
> @@ -6147,8 +6185,8 @@ static void si_enable_voltage_control(struct amdgpu_device *adev, bool enable)
>   		WREG32_P(GENERAL_PWRMGT, 0, ~VOLT_PWRMGT_EN);
>   }
>   
> -static enum amdgpu_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
> -						      struct amdgpu_ps *amdgpu_state)
> +static enum si_pcie_gen si_get_maximum_link_speed(struct amdgpu_device *adev,
> +						  struct amdgpu_ps *amdgpu_state)
>   {
>   	struct si_ps *state = si_get_ps(amdgpu_state);
>   	int i;
> @@ -6177,27 +6215,27 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
>   							     struct amdgpu_ps *amdgpu_current_state)
>   {
>   	struct si_power_info *si_pi = si_get_pi(adev);
> -	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> -	enum amdgpu_pcie_gen current_link_speed;
> +	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> +	enum si_pcie_gen current_link_speed;
>   
> -	if (si_pi->force_pcie_gen == AMDGPU_PCIE_GEN_INVALID)
> +	if (si_pi->force_pcie_gen == PCIE_GEN_INVALID)
>   		current_link_speed = si_get_maximum_link_speed(adev, amdgpu_current_state);
>   	else
>   		current_link_speed = si_pi->force_pcie_gen;
>   
> -	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
> +	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
>   	si_pi->pspp_notify_required = false;
>   	if (target_link_speed > current_link_speed) {
>   		switch (target_link_speed) {
>   #if defined(CONFIG_ACPI)
> -		case AMDGPU_PCIE_GEN3:
> +		case PCIE_GEN3:
>   			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN3, false) == 0)
>   				break;
> -			si_pi->force_pcie_gen = AMDGPU_PCIE_GEN2;
> -			if (current_link_speed == AMDGPU_PCIE_GEN2)
> +			si_pi->force_pcie_gen = PCIE_GEN2;
> +			if (current_link_speed == PCIE_GEN2)
>   				break;
>   			fallthrough;
> -		case AMDGPU_PCIE_GEN2:
> +		case PCIE_GEN2:
>   			if (amdgpu_acpi_pcie_performance_request(adev, PCIE_PERF_REQ_PECI_GEN2, false) == 0)
>   				break;
>   			fallthrough;
> @@ -6217,13 +6255,13 @@ static void si_notify_link_speed_change_after_state_change(struct amdgpu_device
>   							   struct amdgpu_ps *amdgpu_current_state)
>   {
>   	struct si_power_info *si_pi = si_get_pi(adev);
> -	enum amdgpu_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
> +	enum si_pcie_gen target_link_speed = si_get_maximum_link_speed(adev, amdgpu_new_state);
>   	u8 request;
>   
>   	if (si_pi->pspp_notify_required) {
> -		if (target_link_speed == AMDGPU_PCIE_GEN3)
> +		if (target_link_speed == PCIE_GEN3)
>   			request = PCIE_PERF_REQ_PECI_GEN3;
> -		else if (target_link_speed == AMDGPU_PCIE_GEN2)
> +		else if (target_link_speed == PCIE_GEN2)
>   			request = PCIE_PERF_REQ_PECI_GEN2;
>   		else
>   			request = PCIE_PERF_REQ_PECI_GEN1;
> @@ -6864,7 +6902,7 @@ static int si_dpm_enable(struct amdgpu_device *adev)
>   	si_enable_sclk_control(adev, true);
>   	si_start_dpm(adev);
>   
> -	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
> +	si_enable_auto_throttle_source(adev, DPM_AUTO_THROTTLE_SRC_THERMAL, true);
>   	si_thermal_start_thermal_controller(adev);
>   
>   	ni_update_current_ps(adev, boot_ps);
> @@ -6904,7 +6942,7 @@ static void si_dpm_disable(struct amdgpu_device *adev)
>   	si_enable_power_containment(adev, boot_ps, false);
>   	si_enable_smc_cac(adev, boot_ps, false);
>   	si_enable_spread_spectrum(adev, false);
> -	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, false);
> +	si_enable_auto_throttle_source(adev, DPM_AUTO_THROTTLE_SRC_THERMAL, false);
>   	si_stop_dpm(adev);
>   	si_reset_to_default(adev);
>   	si_dpm_stop_smc(adev);
> @@ -7148,10 +7186,10 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
>   	pl->vddc = le16_to_cpu(clock_info->si.usVDDC);
>   	pl->vddci = le16_to_cpu(clock_info->si.usVDDCI);
>   	pl->flags = le32_to_cpu(clock_info->si.ulFlags);
> -	pl->pcie_gen = amdgpu_get_pcie_gen_support(adev,
> -						   si_pi->sys_pcie_mask,
> -						   si_pi->boot_pcie_gen,
> -						   clock_info->si.ucPCIEGen);
> +	pl->pcie_gen = si_gen_pcie_gen_support(adev,
> +					       si_pi->sys_pcie_mask,
> +					       si_pi->boot_pcie_gen,
> +					       clock_info->si.ucPCIEGen);
>   
>   	/* patch up vddc if necessary */
>   	ret = si_get_leakage_voltage_from_leakage_index(adev, pl->vddc,
> @@ -7318,7 +7356,7 @@ static int si_dpm_init(struct amdgpu_device *adev)
>   
>   	si_pi->sys_pcie_mask =
>   		adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_MASK;
> -	si_pi->force_pcie_gen = AMDGPU_PCIE_GEN_INVALID;
> +	si_pi->force_pcie_gen = PCIE_GEN_INVALID;
>   	si_pi->boot_pcie_gen = si_get_current_pcie_speed(adev);
>   
>   	si_set_max_cu_value(adev);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> index bc0be6818e21..77614ff10df6 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> @@ -595,13 +595,20 @@ struct rv7xx_power_info {
>   	RV770_SMC_STATETABLE smc_statetable;
>   };
>   
> +enum si_pcie_gen {
> +	PCIE_GEN1 = 0,
> +	PCIE_GEN2 = 1,
> +	PCIE_GEN3 = 2,
> +	PCIE_GEN_INVALID = 0xffff
> +};
> +
>   struct rv7xx_pl {
>   	u32 sclk;
>   	u32 mclk;
>   	u16 vddc;
>   	u16 vddci; /* eg+ only */
>   	u32 flags;
> -	enum amdgpu_pcie_gen pcie_gen; /* si+ only */
> +	enum si_pcie_gen pcie_gen; /* si+ only */
>   };
>   
>   struct rv7xx_ps {
> @@ -967,9 +974,9 @@ struct si_power_info {
>   	struct si_ulv_param ulv;
>   	u32 max_cu;
>   	/* pcie gen */
> -	enum amdgpu_pcie_gen force_pcie_gen;
> -	enum amdgpu_pcie_gen boot_pcie_gen;
> -	enum amdgpu_pcie_gen acpi_pcie_gen;
> +	enum si_pcie_gen force_pcie_gen;
> +	enum si_pcie_gen boot_pcie_gen;
> +	enum si_pcie_gen acpi_pcie_gen;
>   	u32 sys_pcie_mask;
>   	/* flags */
>   	bool enable_dte;
> 
