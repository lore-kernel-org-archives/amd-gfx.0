Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D43C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 12:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875426E57A;
	Tue, 30 Nov 2021 12:22:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150B16E55E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 12:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWsfXAZPWs72DKC18FZQkwxlmjmo316mh7CSwXtNkKU320nO3YLvre7Fnpj12DFdqYREyvXp4a1xQq6VbHrk21eyFHL0QKfsCeJe+yV30VxB4zlhOpKlfRl0MLmKxOZbnHLRaAWAyp+hylBSeA9c5TjSKusoYbGwXcawr/oFYlB15oNuRd6aH+L0ni7yJK029DfjrK0OqHG4ZpVB+V3CgR8E6PZdbZAKYFEpLntvXLQntzCX/HJLURe06AV6k/ct1OgWdLTm52FtKUTqfTDmLonN72xB/NpIiBhii0BwS6bfMMwbPNEsnh3B+FPZA6q6OqBmq9XU3e8i+jN4nGsijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgid4IL72iB+/5QSy47gPF5X1PfdwcrTuQDMWPFR+C0=;
 b=N9ZhYDVOIfP8N021/MPO3XNQiYXylne8x+sGMF8rAhESf4nWuCwBqFL2QN9cyR7xqm/N683lbx2oQOsgqUqwphHb5aDeSsJzltJqnqeXEMxDRBl/BB4N3iQwiA7FCWsF1Tqdk5ZydRk1Xu/faz9VfOvMiggdg43wgCrczyN+cp8cqIcHkF5wVZA1aUQofEQNcex3vLxITNjXOtzDL5kMMY+6/UhFlzQLFergo1WaaFnrcRehSKbwsV7vAGhjGyDSjzQN4sFi2IIz4+lOcu/B9yWddzrwtKG/RVrihXhy79d5vi8Z8iNbRBYvoAqug+3aXfQzjsTI2k0Wtq55+KNQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgid4IL72iB+/5QSy47gPF5X1PfdwcrTuQDMWPFR+C0=;
 b=HPQDTOjfdckxuZMYTJZ4oEMyJBiehtJT2EwY5y0w+4ilQwEMFbWhoos2V0ds8LyetH3vF5YgjmFn96rf+aFPX1gQJk7z1jCOP+yyDwkAMOpVKEcgWuzNmDvlH1EkcU33bGGMMO5GwKSEB/1xfCkCdJO9UmDFfLTY1Mrwsx27Eos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:22:39 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 12:22:39 +0000
Message-ID: <a14026bf-192e-55d3-2fd0-e29466941e7f@amd.com>
Date: Tue, 30 Nov 2021 17:52:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 05/17] drm/amd/pm: do not expose those APIs used
 internally only in si_dpm.c
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-6-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130074259.1271965-6-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Tue, 30 Nov 2021 12:22:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0d54f3-ae29-4807-4b42-08d9b3fc1998
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753D372741083E0CEF5368897679@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D79rDjgu8dvZlbLU0xOeKWRcvFr1GfTmUKOETWFTzt5Do0AKITR3ULlWkRjJ4QTJD0Vg+RAR4nrTbJJ+UAIRWvXOYFBfPCfijcXLVbbdBMYZ4gc3VQRxyeZ1HgYaRWzC+FtBjIST1iwhIQzCbm1ehzxOCVe02EWOoJBYEoVd3hJaqcIUYd+P2Zff3KOpQ5YCgsIITxERAbLPmr7aB4wjp8tzwW4nfd3bIXzJgTKqNfxWqhry0Z0VP8MYmTyMLINI2Th1NVzKhuxV6xyf/gPtsx16gGnKam/6zX6tg2sSLnM+S/7vLr5olxuu2JhoRj4GryzS8HMHTGdcOZA5AqaqgqZAhNg22c1sSHfpWg9fq2CVESmTM3Xv2OER8HkY1fmWgVJlE5HOigIYFju9KuhXQ/SST9uIpGC0AaBqzWu1rPjRk/vYkv+COP5LU+WqbOm5lcLc6Z0+Z8rNKw1iGDFKX1QDlrQ+9toMqXCbesyj20YqsIrSAc7G4fwS7ak3zPOkcoY3Aj3tEFCeeRKp7fwhP+9YDaD0hGLLjUbpSJrMskVhk0b4KPQfkGsG6LZOVhG3apRuY9XdGomlgfC7e4pY5HnQsidMi5Y+Iu9dkrHFBWXDUEl8ib5HpEc0XpiGtPBRFYOc/N2dmsqQ0Q/Kslb8n2ppW+gaQaVQJ9oPixQbDzy9fIfV/tugxtfAsmEXe7tY+MIoFBSIZWOYyEOfgJ4MU6nEe6Hp2yffR9cQ9WHsAUXlvWPAGYz+yKrBIH/OytG9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(53546011)(31696002)(186003)(16576012)(5660300002)(31686004)(508600001)(66556008)(6666004)(4326008)(316002)(38100700002)(8936002)(2906002)(26005)(66946007)(66476007)(956004)(2616005)(6486002)(36756003)(86362001)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXJkY3ZTWkNKd0NBTnZlSXVrRlB5enpveGZIVDZLZDJRZitYWDg0NWdhR0RW?=
 =?utf-8?B?NHJXVXVrMUVQaHU5QkdySlZNR1VZVjdYcWpSM3Q1b0pvSFVKTlNEdzdsT1o0?=
 =?utf-8?B?Ky9tV0kxTGdjMi82bitBQ2N3TjdjUWtwQmg1TUN2QktwOS8rTjVxQXZiTDh4?=
 =?utf-8?B?b1E3Q0p0TWIyZHpTd0MwcC9mNi9mNDdaUzhLNkI4R25zbkxQZWltblhBNkZZ?=
 =?utf-8?B?YWVUTE8ya0haOHZPOXlCcUxBbnhlWE5ORDYxMUlSS0tnb1g5Y3czTVpEMVI5?=
 =?utf-8?B?UEROSW1qZ3IyTzB3aGFLK3JpdFNIVTlNc2xQdlRnaSt1VDZvUGd0MU9rNTBY?=
 =?utf-8?B?U3hMV29Ua29Uc1E3M3h6d3UwaHVRa21MamdyOG81RHR1TmZ5V2E3Rm1DZTNK?=
 =?utf-8?B?ZEJSYVhGNE1Ta2I3c01CSHBMdVFMdmNZRHNoRmNlbUx2ZlpCZCsyeG5LWlhK?=
 =?utf-8?B?azFoa0RCRzZ1c3pZMEE5RTdvVlF5Y2d0clVkRTVsc3VpRnBNc0ZjZk8zZTNV?=
 =?utf-8?B?UENldFArNUs3Nm5lbjlRTCtZcXJhVzhmUG84OHZseFlNaldiUWJhNWhEbmdM?=
 =?utf-8?B?WXpMVlJWNFRHK2dNTWN0YWdtUlVEUzRIMnRha2I0aXpXa0dCSElvcThvRExu?=
 =?utf-8?B?dTkrMU9EZzJFQTA4QUo4RG52R1pCV21keTcxZzFPNGJyMTUvNUY4R0ZZMTVE?=
 =?utf-8?B?YWFsNHVpOGs4RmpqWExYZmNPTG16QnVNUDhOM0JRa2xCdmVGYXNFbDA0WmV6?=
 =?utf-8?B?N2lrSnNNanBNa1VGeDBYeU83NGdSeCtZTlROZ2hVZld6UUx0dEovRGw1ZUtM?=
 =?utf-8?B?OWU5UkUyOG9zd2hRZEppMHlBUTRCUUttd1lMMzdvaUlZSjA0cVRhRitGVTR2?=
 =?utf-8?B?ejNaV3poYVpPSzZNYWgrM0NRL0FadlllSEY0RWExTnJnTmoyNkxDNzVCRGZC?=
 =?utf-8?B?TjFnaFhCZmN4dXo2MWVzWDJ5aHFIeHloSUJUV0R5UE5zQUliMG1LcHptQ0Fu?=
 =?utf-8?B?QXIxSTNLemJEbXoraGZWc2p0d0RhdVNuU1Z3dGNqSGpzUHY1QnY4Z2tzWTRm?=
 =?utf-8?B?YkI4RlNVVGUwYTFMVVZyb1BXN0Y0ekE1WnlwTWEvQUhMZkZzcDc2aFd4ZlRP?=
 =?utf-8?B?TE5hQjZtVU1xVmE3V1ZqdWpIc0pOZ0NXSXlWOHhodzhmaFptRldla21sMGly?=
 =?utf-8?B?Ny9EdS9KbXpEeVhYQm8rbVd3UWtEdGcwejYwc2o0aVZBK0IrdVNjSzdhQzh3?=
 =?utf-8?B?QTVpcUdjcjdNR29FdVFpUFpOVDZGRkJvM2tzbW85RHhEVjFuOTJ3TTJ5blpq?=
 =?utf-8?B?MldyZHVXZG1vaHNTdy81ZmdNRUUxS0Z2Y1JEaGo4L01xYlBPNHNOYVdleHNC?=
 =?utf-8?B?cDNNUFh1SVl6YjNYdEtvYnFJNGZKQXNhb1NHbEp3c1VjZFNlTnFrT1pUZDFS?=
 =?utf-8?B?Wk1hSFArSi85eENONXhIVFhNRHpLM29BMFJSNTh3Z3A2NHd5RkdtSWhlUExH?=
 =?utf-8?B?STc5YXJobWg5WHFBQlM4dG5sa1VxK0RYUEFTV1ZoekZTdzNTOFhjMTZkU1NK?=
 =?utf-8?B?SlFGWmJQRHE0bWVmSmJmWUc4ZDdOUFV2WnBRR3d5RXBoQlByVGpseVpGNTFn?=
 =?utf-8?B?a2o4OXVmejN2dmpzbU5sRW12NlAwOXpJN3k4VkRWZ01TbVpxeFZySEd2SDdP?=
 =?utf-8?B?cTZaVFI2MTVSNC9CczBiZi9rYVBuVWpxT2grNG1tYS9JM1FXdE5JWExuUnps?=
 =?utf-8?B?V25pNHp3azBwVGdnQjN4RXF6VGcxTGFNMm5ZMWEzenRtV3VPWEVpMFp0aWYz?=
 =?utf-8?B?NStqbzZsT01xSW9WcURXZnFuL1VhVHRRQ0NMcDgvTEZFb2pLMWoweFAzUFRh?=
 =?utf-8?B?dFlEejErRWZlMzB2dWZjYXFncHJyeW9URTZRTzNxQzZEdXBjVFZIcnBuUnBv?=
 =?utf-8?B?MURPUUp4N3NDLzZDOFdjaGdTNWk5L0xwSnJybkxreXpDSG1XVmlReEVxNi9z?=
 =?utf-8?B?QWxRK1k5Vi9qdzcydE9QbERsL0hiT0ZEZi94YytoRTJVZTRIcko3OHZqdXRK?=
 =?utf-8?B?R3crblNldEUvOTlVSEpkSWRkaloyaG5hN2tLR2ZBelo0RVd4LzVBaG9Vdi9s?=
 =?utf-8?Q?7VMg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0d54f3-ae29-4807-4b42-08d9b3fc1998
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:22:39.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wX4wrnqBi7m418FIPGtvveHMbp4J8cJzLISfmXdX/Ye6tDJ1VGhNsu1ii52aU0iG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
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



On 11/30/2021 1:12 PM, Evan Quan wrote:
> Move them to si_dpm.c instead.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I288205cfd7c6ba09cfb22626ff70360d61ff0c67
> --
> v1->v2:
>    - rename the API with "si_" prefix(Alex)
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 25 -----------
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 25 -----------
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 54 +++++++++++++++++++----
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.h |  7 +++
>   4 files changed, 53 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 52ac3c883a6e..fbfc07a83122 100644
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
> index 81f82aa05ec2..4f84d8b893f1 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -96,6 +96,19 @@ union pplib_clock_info {
>   	struct _ATOM_PPLIB_SI_CLOCK_INFO si;
>   };
>   
> +enum amdgpu_dpm_auto_throttle_src {
> +	AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL,
> +	AMDGPU_DPM_AUTO_THROTTLE_SRC_EXTERNAL
> +};
> +
> +enum amdgpu_dpm_event_src {
> +	AMDGPU_DPM_EVENT_SRC_ANALOG = 0,
> +	AMDGPU_DPM_EVENT_SRC_EXTERNAL = 1,
> +	AMDGPU_DPM_EVENT_SRC_DIGITAL = 2,
> +	AMDGPU_DPM_EVENT_SRC_ANALOG_OR_EXTERNAL = 3,
> +	AMDGPU_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL = 4
> +};
> +

Better to rename the enums also including amdgpu_pcie_gen if they are 
used only within si_dpm.

Thanks,
Lijo

>   static const u32 r600_utc[R600_PM_NUMBER_OF_TC] =
>   {
>   	R600_UTC_DFLT_00,
> @@ -4927,6 +4940,31 @@ static int si_populate_smc_initial_state(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +static enum amdgpu_pcie_gen si_gen_pcie_gen_support(struct amdgpu_device *adev,
> +						    u32 sys_mask,
> +						    enum amdgpu_pcie_gen asic_gen,
> +						    enum amdgpu_pcie_gen default_gen)
> +{
> +	switch (asic_gen) {
> +	case AMDGPU_PCIE_GEN1:
> +		return AMDGPU_PCIE_GEN1;
> +	case AMDGPU_PCIE_GEN2:
> +		return AMDGPU_PCIE_GEN2;
> +	case AMDGPU_PCIE_GEN3:
> +		return AMDGPU_PCIE_GEN3;
> +	default:
> +		if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) &&
> +		    (default_gen == AMDGPU_PCIE_GEN3))
> +			return AMDGPU_PCIE_GEN3;
> +		else if ((sys_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) &&
> +			 (default_gen == AMDGPU_PCIE_GEN2))
> +			return AMDGPU_PCIE_GEN2;
> +		else
> +			return AMDGPU_PCIE_GEN1;
> +	}
> +	return AMDGPU_PCIE_GEN1;
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
> +						    AMDGPU_PCIE_GEN1);
>   
>   		if (si_pi->vddc_phase_shed_control)
>   			si_populate_phase_shedding_value(adev,
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
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> index bc0be6818e21..8c267682eeef 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.h
> @@ -595,6 +595,13 @@ struct rv7xx_power_info {
>   	RV770_SMC_STATETABLE smc_statetable;
>   };
>   
> +enum amdgpu_pcie_gen {
> +	AMDGPU_PCIE_GEN1 = 0,
> +	AMDGPU_PCIE_GEN2 = 1,
> +	AMDGPU_PCIE_GEN3 = 2,
> +	AMDGPU_PCIE_GEN_INVALID = 0xffff
> +};
> +
>   struct rv7xx_pl {
>   	u32 sclk;
>   	u32 mclk;
> 
