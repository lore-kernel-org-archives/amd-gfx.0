Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F17C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 00:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E2F10E0E1;
	Thu,  1 Dec 2022 00:24:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523D010E0E1
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 00:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmwiSDWHj/uCgSYkvdu7SyptTi9wkVxd4kh8C74A1KzNFHqcepiWWHOnLQ6HkCsDbfo/QLDOC9i16WNrvYeNJfNpNU78WgI1H9qo00/UWbjruYfAH8lHl3HNOQkakxA3BUW5NtqmosXTNhQ/HL7GuQ9Xi/rQENzYgh3D7Ch+ilIg5RxPozbq2fKSKcQJLNae4SrQd0rzTmNfKXbxfE0Ehb0Q6uBc+JYvvqILfy2r38hyNnf+luabzbsZsCEIXwFPqwJ8WJ2c/I26Kr5uzevuev+1o25kQS7xO/iVPsZAg3f0jYdol/fnX+rk1qT1+MdwTy0O+Y37hKD4sGc6wrm4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78Cnvj2H8xQ+AGwpp+A8xrdFLMxSg91m+bNVsNJPh7c=;
 b=INrt7zXV5ViPNJsfpsOlWoWZN7axs0MmLDit/ntIvIrZaFX1RauM2ojTsj9hnM2yhzk90OCh1hDpzMwSY9NLRj0SfpddjulrNt/HXTyBmx2egVs9SqXZ+BOHESXunfweSryh/cyrkEh7+OvmoA/36d+nMTkuEEZcRIREvtAUMp3du/XvMmgMYZ872Ej2QHkJZxCRmjY3loXbSCttPNfwS4kau0iq4XDb1y/yHQCrtejxNCqiKfLXGV8Gng9legmw4v3AVOp6pzu/k99FFCNeTfBXBPSIkRARCpN9Q4S9Rqlz1bQCf8qzJwqzsrnAOLmaMf9Q5krbzYNbiD/I0GzVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78Cnvj2H8xQ+AGwpp+A8xrdFLMxSg91m+bNVsNJPh7c=;
 b=w/zEJuB3P8nhgJ9cp7xMg3Mb6uhnQh9lE5u1WzngKCPFnfy4Ec/2buauXCAjN/BKyi7Lv43Br2eC0CYxkL/DQc6xxfdmWzkodBRquw9pqvz5iC2aFFVfhYV7XNQt1rTt4sknXDeFpB8X2SnWJsirwlpD3orBvO/X2o5WDg8a/28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 00:23:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:23:58 +0000
Message-ID: <3867f5ec-a32a-7800-2c2a-f6311c8d371e@amd.com>
Date: Wed, 30 Nov 2022 19:23:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 05/29] drm/amdgpu: setup hw debug registers on driver
 initialization
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-5-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-5-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1a181c-db77-4744-ba45-08dad33256da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSs82fdWXHnp55OrDr1hQDw3gVEPF+vfYtHxtrb/jvGLCBgZCTBKZGDoe1jFXYhKGBNtyly5lQoAs7pNuHrq4wJb7Ni8/U9SZOIiweFRmR+B+rCo6toGGYUroCwhFkdt/u8Rq5h9h/NBDPHcZnmFonfIj2dRt9IC4aNyPZv7MTV8IM3mVGx9YYA5iX1VhgwikmmZ8OWvL/NN23Zvt5Kik7vDjxagSOhdgrNyD1xddTA3gbUU8CR3zzGuRkdwcpJu0QFYb0qQLHzr4rqHEKOH6sfSFlS9VSmwoA9lOE3I0AlO47BrvRhStFsaKpjlhjaLr9dWVtzLIUeSqxT7w5I86EMntSvBh9IlFLCax6hZfUGI1Zwh8vbe79dYJipu3Xntv9kBx4/G8VTvzx46Ito+2q1/T6Uc1smdfl9GDYbwOzoANFQavAhNn+qlBPFX+2EGfvfDNblmFdRDNGQeLa6blUo0h3ZWM97P5jMCr4UFyIGV0HX9PzU6WVg7XK0R01eaEbmmrOhA52N4DmA460OL3fXVKFoFVX6b0qXknXmIhXrynXHYIYyW8aBnhQv7J8DBqRqVEqJIMyEu2BVmb5mOneLmxWhHM1D1Ut/SA27kGRyZ1ct0H5WdZBBLRbLnufavvTeRnYjsgjcyl5SRfdC2Kb5nZKpmy9pdA0i0Uh9HbJ5t6CMMR7frzLT8bBL9e+5Pa9NxAqlWCRAD3zGCt7QNay5zD19nCMA/lGl59wXKA0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(478600001)(31686004)(36916002)(6486002)(6506007)(31696002)(2616005)(66946007)(36756003)(8676002)(41300700001)(66556008)(186003)(5660300002)(66476007)(8936002)(316002)(26005)(6512007)(53546011)(4001150100001)(2906002)(86362001)(83380400001)(44832011)(30864003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFzOGgxNHBHR3dRdnhPSWx2Z3NrYmdiZm0xdXVVcTB3dlB6emlFOXE4WFNJ?=
 =?utf-8?B?eG5zeXUwK09lY0FaRjJCbGN1VWROSUNhcHA1djNyaG5EMTVXV2lEZjNFOHlt?=
 =?utf-8?B?TEhHbmE0WUxzZ3I1T01QdytPd2hBekk0NVFidFVvRGllZWl0ejVTdldrTzRs?=
 =?utf-8?B?TXJaVUNnRUdOKzZWckZGSWRXWTd1VlJUOUhudjZySXNoVmtOOGdVOVZHU3p1?=
 =?utf-8?B?dDZxa09ZNDVsWG41V0g1NFhrK0dxbnBIcHhWdSs5MU9zN1I0amNEVWsyT2R2?=
 =?utf-8?B?S0s5WWI4c2hwcjIrbUxWZnJMRHIzajYyMG1wbGsvaHlKbmV2ZENjWVpxR1ZD?=
 =?utf-8?B?T2ZlaTBKOVA1WXg5b3FaSWJDMW8zL3hPa2dmM09oVThmeUdxcjNaN3dOMEhI?=
 =?utf-8?B?RHZuVnorQkZmalJyV0h3U3hFWitnU3UxbTZCUnY3di9YVk1zQUk4M1oyY2w4?=
 =?utf-8?B?aHdKVjNLR1crNVhYSk01dFFLdWJKRzNTbDZWQzVMODV3L1I4dXdsNTB0MEEv?=
 =?utf-8?B?OEluOVlMVUNvc3RERXNYYm1PR2p5RzNqcGhGY3o0NUdnZWlrZitsUFp2WXdt?=
 =?utf-8?B?WTJoNXJOU04zY2NRN1FNMVp4VWxmK2F3aHNSNllUemxaTE9xK3labnBRUVlK?=
 =?utf-8?B?U01JQkx6emV0SEF0eTJsYlk5akYvQ0V6UUFiM3dVd1loZ1hXMmpHUkdZSk5t?=
 =?utf-8?B?WVFWd0l5MHhPb3UyQW8xa3doOFRSTzhtRFJGVG5IR25zWk0reHREV1Q2WXJI?=
 =?utf-8?B?ZWljcmwvQ2k4RUZOMlV4ODRRVHAyOXA1ampQOUREY1hGSlgvVzd0eitjcmc5?=
 =?utf-8?B?N0U5alJtN2RGUjJYYnRrL0o1MWJRWVczTHhtU3dlclZhcFF1UG9BUjFMR2hP?=
 =?utf-8?B?Vyt4dkpEdThOcHFZck9zRjRTQlFBVTBaUWRoNU9ueERGWG9ydGpXWEZQNGUz?=
 =?utf-8?B?bVdIdmhZL29PNTZacmkyTnpmeTNmOEpuUzkrbWcrcVJvMFB4dVNvZHpwN0hZ?=
 =?utf-8?B?eVN4L0Y3cDdmR05VNXhlclR4UlZsdmJyT3B4NnlzRU5QU1BJdEZwRjhXS2dX?=
 =?utf-8?B?K0s1eDdoQllzS2FFOHNuazIrUTNzT2JSY3ZWaVk0Nkxrd0xXUG5XTUhZdWlX?=
 =?utf-8?B?TUlmV1N6d2kzMGpWMzBoRjFZYzRISWhFd2k2SmVLSHp1K2k4cDVSZW9veVVr?=
 =?utf-8?B?NWRBQWFPRDlXZldMN1d0bDZjd1l6eEJyL2JlR2RHOXJKakM1cHlZbzIyMzRD?=
 =?utf-8?B?TU5BTEdUcW5ZNXh1Z3BtNmJwRGZQaHYyTnFUUnNsWG1DaExsN0J4Ykcrb2RJ?=
 =?utf-8?B?ZUgyUzN6bTROMWZrWncwZDFKbUlabkpHT1pmTmI0R1VVdFlCYzVsUTdac25x?=
 =?utf-8?B?c24wQXF6NTNqK3JJeGxxbk0yUUd2dkJCaFJac1V1WFZxbHpFWThPSU1WdFlY?=
 =?utf-8?B?WVZ6WEpDazZzSDlkZDhuanRIWkpHRkJDdFJVdTNsT3hKNDdVYTNzRVRDYnV2?=
 =?utf-8?B?WWQva3RseVNGaUFFS0VXVGh2a3cyY3pZZUVIQ1JiQW5xTmZaWVBrWUhiT0gw?=
 =?utf-8?B?UXU3aGVKMDk4VUVpWG84Zi9XYSthQVBFYkJyYWs5NDlmZFJKV2laSEc2MWd0?=
 =?utf-8?B?R1FsS2pmUEdOdXVBdmtuM2lPbWNwVHQvaS9rMHZ5V05ob1ZxUVlOWjNSQmhC?=
 =?utf-8?B?NGZDMTMzS0FmZmh0VzlXamxPWUJncW9PWEl1aU1YRkQyVTMvZ1NDMjl6MjFF?=
 =?utf-8?B?emR6MTRTazhRYUlGbExTZEYwVE0wUlpKdEw1djdLNXNLOVBwUGNwYVZ1ejBk?=
 =?utf-8?B?MHZsN3BPSmpaM0YwYVJvM1hTYWhnM0lybzFtNWs3Y3ZZeFRPNjdNMFdRTTll?=
 =?utf-8?B?U1JjdHNnbEpQNFBzYXpSSkNtRjMxRXozL3E0eFNqL2o5aFJOTXM3RkxaVXdU?=
 =?utf-8?B?UEh1enN4azNqMmVkVGtUeDZ4QmhNSXpRVFE3S0tBNWsyMVFCMUw1bkhNUytV?=
 =?utf-8?B?dmxmRi9adElVdGRyZVZha2tWWTlReVdUVGdPVEpGUW91T0ZPM2lmSFM5RE1W?=
 =?utf-8?B?TDdqQTZWNWtrWVZWNG8xNldwcS9NQityb0tOWHcvVGRrWEtEQ01jakI5cFRE?=
 =?utf-8?Q?geIDE9h4dzfbTDjo1LcELzlIQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1a181c-db77-4744-ba45-08dad33256da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 00:23:58.6753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veQlrXADbdPteD18M4bW/ZvJ2ER1g9k2SYExB9zLsL5Pi1Ap3Ko/97qr5xEqQmzBtewzBN9ZTOp7OZCLlpJYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Add missing debug trap registers references and initialize all debug
> registers on boot by clearing the hardware exception overrides and the
> wave allocation ID index.
>
> For debug devices that only support single process debugging, enable
> trap temporary setup by default.
>
> Debug devices that support multi-process debugging require trap
> temporary setup to be disabled by default in order to satisfy microbench
> performance when in non-debug mode.
>
> The debugger requires that TTMPs 6 & 7 save the dispatch ID to map
> waves onto dispatch during compute context inspection.
> In order to correctly this up, set the special reserved CP bit by default
> whenever the MQD is initailized.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 30 ++++++++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  5 ++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  5 ++
>   .../include/asic_reg/gc/gc_10_1_0_offset.h    | 14 ++++
>   .../include/asic_reg/gc/gc_10_1_0_sh_mask.h   | 69 +++++++++++++++++++
>   .../include/asic_reg/gc/gc_10_3_0_offset.h    | 10 +++
>   .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   |  4 ++
>   8 files changed, 163 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index af94ac580d3e..d49aff0b4ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4904,6 +4904,29 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
>   
>   #define DEFAULT_SH_MEM_BASES	(0x6000)
>   
> +static void gfx_v10_0_debug_trap_config_init(struct amdgpu_device *adev,
> +				uint32_t first_vmid,
> +				uint32_t last_vmid)
> +{
> +	uint32_t data;
> +	uint32_t trap_config_vmid_mask = 0;
> +	int i;
> +
> +	/* Calculate trap config vmid mask */
> +	for (i = first_vmid; i < last_vmid; i++)
> +		trap_config_vmid_mask |= (1 << i);
> +
> +	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> +			VMID_SEL, trap_config_vmid_mask);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			TRAP_EN, 1);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
> +}
> +
>   static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -4935,6 +4958,9 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>   		WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>   	}
> +
> +	gfx_v10_0_debug_trap_config_init(adev, adev->vm_manager.first_kfd_vmid,
> +					AMDGPU_NUM_VMID);
>   }
>   
>   static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0320be4a5fc6..a0e5ad342f13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2337,6 +2337,29 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
>   	adev->gfx.config.num_rbs = hweight32(active_rbs);
>   }
>   
> +static void gfx_v9_0_debug_trap_config_init(struct amdgpu_device *adev,
> +				uint32_t first_vmid,
> +				uint32_t last_vmid)
> +{
> +	uint32_t data;
> +	uint32_t trap_config_vmid_mask = 0;
> +	int i;
> +
> +	/* Calculate trap config vmid mask */
> +	for (i = first_vmid; i < last_vmid; i++)
> +		trap_config_vmid_mask |= (1 << i);
> +
> +	data = REG_SET_FIELD(0, SPI_GDBG_TRAP_CONFIG,
> +			VMID_SEL, trap_config_vmid_mask);
> +	data = REG_SET_FIELD(data, SPI_GDBG_TRAP_CONFIG,
> +			TRAP_EN, 1);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_CONFIG), data);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_MASK), 0);
> +
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA0), 0);
> +	WREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_TRAP_DATA1), 0);
> +}
> +
>   #define DEFAULT_SH_MEM_BASES	(0x6000)
>   static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
>   {
> @@ -4609,6 +4632,13 @@ static int gfx_v9_0_late_init(void *handle)
>   	if (r)
>   		return r;
>   
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
> +		gfx_v9_4_2_debug_trap_config_init(adev,
> +			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);

Where is this function defined. I don't see it in any of your patches. 
Did you forget to git add a file?

Regards,
   Felix


> +	else
> +		gfx_v9_0_debug_trap_config_init(adev,
> +			adev->vm_manager.first_kfd_vmid, AMDGPU_NUM_VMID);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index d3e2b6a599a4..cb484ace17de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -117,6 +117,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>   			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>   
> +	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
> +	 * DISPATCH_PTR.  This is required for the kfd debugger
> +	 */
> +	m->cp_hqd_hq_scheduler0 = 1 << 14;
> +
>   	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 0778e587a2d6..86f1cf090246 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -164,6 +164,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>   			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>   
> +	/* Set cp_hqd_hq_scheduler0 bit 14 to 1 to have the CP set up the
> +	 * DISPATCH_PTR.  This is required for the kfd debugger
> +	 */
> +	m->cp_hqd_hq_status0 = 1 << 14;
> +
>   	if (q->format == KFD_QUEUE_FORMAT_AQL) {
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 18d34bbceebe..7d384f86bd67 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -5190,6 +5190,20 @@
>   #define mmSPI_WCL_PIPE_PERCENT_CS6_BASE_IDX                                                            0
>   #define mmSPI_WCL_PIPE_PERCENT_CS7                                                                     0x1f70
>   #define mmSPI_WCL_PIPE_PERCENT_CS7_BASE_IDX                                                            0
> +#define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
> +#define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
> +#define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
> +#define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
> +#define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
>   #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
>   #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> index 4127896ffcdf..08772ba845b0 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_sh_mask.h
> @@ -19646,6 +19646,75 @@
>   //SPI_WCL_PIPE_PERCENT_CS7
>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE__SHIFT                                                                0x0
>   #define SPI_WCL_PIPE_PERCENT_CS7__VALUE_MASK                                                                  0x7FL
> +//SPI_GDBG_WAVE_CNTL
> +#define SPI_GDBG_WAVE_CNTL__STALL_RA__SHIFT                                                                   0x0
> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID__SHIFT                                                                 0x1
> +#define SPI_GDBG_WAVE_CNTL__STALL_RA_MASK                                                                     0x00000001L
> +#define SPI_GDBG_WAVE_CNTL__STALL_VMID_MASK                                                                   0x0001FFFEL
> +//SPI_GDBG_TRAP_CONFIG
> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL__SHIFT                                                                   0x0
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL__SHIFT                                                                 0x2
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL__SHIFT                                                                0x4
> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH__SHIFT                                                                 0x7
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH__SHIFT                                                               0x8
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH__SHIFT                                                              0x9
> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN__SHIFT                                                                  0xf
> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL__SHIFT                                                                 0x10
> +#define SPI_GDBG_TRAP_CONFIG__ME_SEL_MASK                                                                     0x00000003L
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_SEL_MASK                                                                   0x0000000CL
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_SEL_MASK                                                                  0x00000070L
> +#define SPI_GDBG_TRAP_CONFIG__ME_MATCH_MASK                                                                   0x00000080L
> +#define SPI_GDBG_TRAP_CONFIG__PIPE_MATCH_MASK                                                                 0x00000100L
> +#define SPI_GDBG_TRAP_CONFIG__QUEUE_MATCH_MASK                                                                0x00000200L
> +#define SPI_GDBG_TRAP_CONFIG__TRAP_EN_MASK                                                                    0x00008000L
> +#define SPI_GDBG_TRAP_CONFIG__VMID_SEL_MASK                                                                   0xFFFF0000L
> +//SPI_GDBG_TRAP_MASK
> +#define SPI_GDBG_TRAP_MASK__EXCP_EN__SHIFT                                                                    0x0
> +#define SPI_GDBG_TRAP_MASK__REPLACE__SHIFT                                                                    0x9
> +#define SPI_GDBG_TRAP_MASK__EXCP_EN_MASK                                                                      0x01FFL
> +#define SPI_GDBG_TRAP_MASK__REPLACE_MASK                                                                      0x0200L
> +//SPI_GDBG_WAVE_CNTL2
> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK__SHIFT                                                                 0x0
> +#define SPI_GDBG_WAVE_CNTL2__MODE__SHIFT                                                                      0x10
> +#define SPI_GDBG_WAVE_CNTL2__VMID_MASK_MASK                                                                   0x0000FFFFL
> +#define SPI_GDBG_WAVE_CNTL2__MODE_MASK                                                                        0x00030000L
> +//SPI_GDBG_WAVE_CNTL3
> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS__SHIFT                                                                  0x0
> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS__SHIFT                                                                  0x1
> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS__SHIFT                                                                  0x2
> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS__SHIFT                                                                  0x3
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG__SHIFT                                                                 0x4
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0__SHIFT                                                                 0x5
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1__SHIFT                                                                 0x6
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2__SHIFT                                                                 0x7
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3__SHIFT                                                                 0x8
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4__SHIFT                                                                 0x9
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5__SHIFT                                                                 0xa
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6__SHIFT                                                                 0xb
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7__SHIFT                                                                 0xc
> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION__SHIFT                                                            0xd
> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT__SHIFT                                                                0x1c
> +#define SPI_GDBG_WAVE_CNTL3__STALL_PS_MASK                                                                    0x00000001L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_VS_MASK                                                                    0x00000002L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_GS_MASK                                                                    0x00000004L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_HS_MASK                                                                    0x00000008L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CSG_MASK                                                                   0x00000010L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS0_MASK                                                                   0x00000020L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS1_MASK                                                                   0x00000040L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS2_MASK                                                                   0x00000080L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS3_MASK                                                                   0x00000100L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS4_MASK                                                                   0x00000200L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS5_MASK                                                                   0x00000400L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS6_MASK                                                                   0x00000800L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_CS7_MASK                                                                   0x00001000L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_DURATION_MASK                                                              0x0FFFE000L
> +#define SPI_GDBG_WAVE_CNTL3__STALL_MULT_MASK                                                                  0x10000000L
> +//SPI_GDBG_TRAP_DATA0
> +#define SPI_GDBG_TRAP_DATA0__DATA__SHIFT                                                                      0x0
> +#define SPI_GDBG_TRAP_DATA0__DATA_MASK                                                                        0xFFFFFFFFL
> +//SPI_GDBG_TRAP_DATA1
> +#define SPI_GDBG_TRAP_DATA1__DATA__SHIFT                                                                      0x0
> +#define SPI_GDBG_TRAP_DATA1__DATA_MASK                                                                        0xFFFFFFFFL
>   //SPI_COMPUTE_QUEUE_RESET
>   #define SPI_COMPUTE_QUEUE_RESET__RESET__SHIFT                                                                 0x0
>   #define SPI_COMPUTE_QUEUE_RESET__RESET_MASK                                                                   0x01L
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> index 3973110f149c..d09f1a06f4bf 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
> @@ -26,6 +26,8 @@
>   #define mmSQ_DEBUG_STS_GLOBAL_BASE_IDX                                                                 0
>   #define mmSQ_DEBUG_STS_GLOBAL2                                                                         0x10B0
>   #define mmSQ_DEBUG_STS_GLOBAL2_BASE_IDX                                                                0
> +#define mmSQ_DEBUG                                                                                     0x10B1
> +#define mmSQ_DEBUG_BASE_IDX                                                                            0
>   
>   // addressBlock: gc_sdma0_sdma0dec
>   // base address: 0x4980
> @@ -4849,10 +4851,18 @@
>   #define mmSPI_WCL_PIPE_PERCENT_CS3_BASE_IDX                                                            0
>   #define mmSPI_GDBG_WAVE_CNTL                                                                           0x1f71
>   #define mmSPI_GDBG_WAVE_CNTL_BASE_IDX                                                                  0
> +#define mmSPI_GDBG_TRAP_CONFIG                                                                         0x1f72
> +#define mmSPI_GDBG_TRAP_CONFIG_BASE_IDX                                                                0
>   #define mmSPI_GDBG_TRAP_MASK                                                                           0x1f73
>   #define mmSPI_GDBG_TRAP_MASK_BASE_IDX                                                                  0
>   #define mmSPI_GDBG_WAVE_CNTL2                                                                          0x1f74
>   #define mmSPI_GDBG_WAVE_CNTL2_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_WAVE_CNTL3                                                                          0x1f75
> +#define mmSPI_GDBG_WAVE_CNTL3_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA0                                                                          0x1f78
> +#define mmSPI_GDBG_TRAP_DATA0_BASE_IDX                                                                 0
> +#define mmSPI_GDBG_TRAP_DATA1                                                                          0x1f79
> +#define mmSPI_GDBG_TRAP_DATA1_BASE_IDX                                                                 0
>   #define mmSPI_COMPUTE_QUEUE_RESET                                                                      0x1f7b
>   #define mmSPI_COMPUTE_QUEUE_RESET_BASE_IDX                                                             0
>   #define mmSPI_RESOURCE_RESERVE_CU_0                                                                    0x1f7c
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> index d4e8ff22ecb8..fc85aee010fe 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
> @@ -47853,6 +47853,10 @@
>   
>   
>   // addressBlock: sqind
> +//SQ_DEBUG
> +#define SQ_DEBUG__SINGLE_MEMOP_MASK 0x00000001L
> +#define SQ_DEBUG__SINGLE_MEMOP__SHIFT 0x00000000
> +
>   //SQ_DEBUG_STS_GLOBAL
>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0_MASK 0x000000ffL
>   #define SQ_DEBUG_STS_GLOBAL2__FIFO_LEVEL_GFX0__SHIFT 0x00000000
