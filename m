Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A9606AB01
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FNhX/UIr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA30110EBD2;
	Tue, 20 Oct 2026 13:49:05 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6050810E5C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 13:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4h1218re6lSRKQNJ3DVKARIIdgxvizlehmPFew4Hol/Oz+ihbOLduXoikXwxOAosIh4Dh47j8D67i6PXhjrvt3Z1BR2lOZgGROxnVoJkljMBuhw+1mSA4uAsHLqts78+p4F7uU/v0oRLW0os8KaYD//cIHY/vRmDuyR1lESmgtzan+5pQuwB0TD62dxManjuygrEmpkg3OS9lyatOd1GW2hqCAqgiP+e55i3UnCkhAa2B844kPlM6JfA1TwdH6ufB3zAqvzbGUcTk8jXiDxolE6x4wOPAmc9TpS7QQdM/X7MjGSJGgAerhJVZPk/0AWZU6jJ716zkNc9fftT6TqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3Y6Ex2OtvnHimPILvncOFPOOdg5I5esOZqSWJMVHRg=;
 b=qNw/JOD2wTlqJmNqWFCADsEeFAQnYwlz6k+VtkzlpEtR7vYTFAdAHXH+ZG5kWtD5NTuV9popxVPjffgiUpCjAUB/K5mQTv6ApuluMmR63crsTY1lhA9cudEMQXqDrg2h5/8HvGdcTB8+bJvx+UJ/GXXwHDtLP0fPjcKbx5/BNj5p46k+fwH3eK31xQf/Zke1C7RysgWX0GPEht3JAc5Fvwf9SyL2269YOBRUzrQH4xK+Xfj4aTOizlKijaUpAlauSaHocHXNBWvDWqEfZkuZPCo3sy89PTyoZtTH7oqhmhuEq4fYxT/1prtBxEP+/4R1QChHheHTSFd4wGNkArgrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3Y6Ex2OtvnHimPILvncOFPOOdg5I5esOZqSWJMVHRg=;
 b=FNhX/UIrNSGj14aXJVh6jopJurV40Uc5pKoNdP3qxfTbhL7FaQXgz/7PF5aNoAYBFVvOofeaLgZvxsS0DCBjPzRa7Y/ZBTQS5o5k1WOHvcaAyDUBbqdlj76ei0ttdgdl9/AePV4S0JPVgUnKSgVpDtSaVO020aCBI2QANFGK9+s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB999203.namprd12.prod.outlook.com (2603:10b6:610:35a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 13:48:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:48:02 +0000
Message-ID: <cae42b7c-d751-49de-bdff-96c08d5545ff@amd.com>
Date: Tue, 20 Oct 2026 15:47:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Size the vm_pte_scheds array by maximum
 number of SDMA instances
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
 <20261020132739.31852-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020132739.31852-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB999203:EE_
X-MS-Office365-Filtering-Correlation-Id: ac872977-6a58-422e-65ce-08df2eb0c22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vpN5nkqcEoip575RAYuTJaDy20PvfMcPbe8xlI3WGc0iSzX5xkESeqxTDEvh+HgJqS5jaq1MeVBJLj6W2/IqdwzXbX/wMeynxL4PxyfUSuXmcuMetTOSz8qjEvdJSor2uOLHjjwgsV3G55T/lRL7RMutzhQxz/LggNPIuJ07A6pIjeia3tdtBOkPvneCxgzsTuEyanseIQzUaedRaJZ+M+VOi6aFKHKXRBwDW97XnMh7jSXzMhW89YLq7leP8IGk5SLUspzAgcx8Pbcf3CkRySmcIUL0c3wOOydjDB4mBMemh7QM7kr37r/B+5f2pk2P3S2qTBWD+zoZWX3MzNSMAFcYJ/VIt2NS3iF3u0HnogS7AmErxxtMxnIBt4pqa9hLNTDT/LxaijOZF1BQ0X6+vRlOCcCULfY625qleFlsQ2owrRBjZa2r27UHE2faiTFxK00WOYd9zu6SbHB0w13I/TA66kaFGNb+TbX1x/kpIGFCDVGiHk9+X3G/JRl5Ix49iMNhb4YX37/6KI04kQwpPlXpYtL/IQsxPRAA/ZB9n0OVbuyZjqQIVQVHRCnk0rX6HfGBYGW50evzbnjjEF11ISxRWLoC/qVkyOaFtmuvvX4ggJe91eGyanwNChUB5sHG4otpk5URHyk1j+h86aCdlWG/HFbZPIlfcH4cr52bRzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRWMnRGc3hzRkd1OUtkeHVLREZrSjJKSEwvcDRTbWUrZ2JVU1NaeWx2Yklj?=
 =?utf-8?B?blYxbnRlbTk4eUtqTlU4eFZLejI4NzRKaGp0MXFhTk16blByWW5PZFgxTjQ3?=
 =?utf-8?B?N2YweGMxdUNkdm43WjRad2QyTjVtK2huNXVjblBMTnF2MEtycnkxWWVuMEpt?=
 =?utf-8?B?ejdqNHZiZHJrVWR0a0R3SmpPL1hkdkNJb0xBL3V4UHpubWlJRWpaYVB0dHRJ?=
 =?utf-8?B?Y04za0w3K05ITDFTQXRsOS9VUnUvQ0NQZ0V6c0laV2VWUHBvUldscUpJMS9m?=
 =?utf-8?B?OEZtVWd2Y1B3bTArOU1PeFdXVkVyc2I3bm5WSTh0UWg1RjBvVXMxQU9XcTJT?=
 =?utf-8?B?VG0yRWZ1QlZrbHVJUVV0enI5Q0drSGl3VlZYdno1N3lsbzVVc3htWWxTVUdv?=
 =?utf-8?B?SGlaeWZ3emNEcjdOM3dRVWh2RHdOeWw1aGpObHMyanduYmRVeFNkSVBRZWh5?=
 =?utf-8?B?bkpHeVAxamVSbEQ2amdKd1lTZ2h4Q2V0b2hzd1ZjYlZmVVdjVjhNQUtaRDU3?=
 =?utf-8?B?MWlZaGgxTzlFcGhKeDVKM0dyS2w0NDJaTFpIakFzMWVod0x2TWhheWFVcUZJ?=
 =?utf-8?B?Y1YzUGc1YS9zdXFHVk5vcmV2REMwOVVGS0RuZGVlejExTUE4T0lUSnM3V1FR?=
 =?utf-8?B?dUZlZVhoc1R2OW9KMXgvSjdnUWVCaytvTEZ0Y3JxTnF3Mnlqa3BvLzNSZElz?=
 =?utf-8?B?cWoxZEtxUXA1WElsRzF2VThReUs2L3pjckJuWkFnT01XM3ZKbHZhVmhab0pD?=
 =?utf-8?B?eEcrR0VGS1JHOFd5QVBIR1BvOCtiamJWbFU0Mml4TFpJVVRlZ0lWcHNWc1NK?=
 =?utf-8?B?c3BGeDdjNGROQXJoTjYzMGxEUlQzUDJZMlFuTUR0dklPeE5qSDZZOGZIR3FV?=
 =?utf-8?B?Wi9yeVFGZWlmY3RGeFNUdkpqc05rS2tDYUp4NU9LYmZtSVJ5MkZYS1hReW1S?=
 =?utf-8?B?S05xMUoxdVVmUTJVS2U4TFVaZ1JYSklpWTRZRUx3MG5IckJqM1N0ckxIdG01?=
 =?utf-8?B?K21wY045ODkvTUpvVGI2aUlPbFpkbzgwN2lmc2krcnR3RmRrZlJXajZ5Tk00?=
 =?utf-8?B?cElCQWwrQ2pNYzJEYmk2UDV0M2JFSW5JVUFmOW5HcXhXVFpFZW1rZlE0Wm1u?=
 =?utf-8?B?SFJjNUlrQWN1bnJBOHBhSm5qYTVkeUNUWkRPU1dZSWIwZWRtcktaOS9rZ0Fy?=
 =?utf-8?B?ZytHSjB4TXZDd01QVFY3eW80UXFmNURnV08yRE1tVFg4S0pHNytPME5mK3k1?=
 =?utf-8?B?UDhNZHQySkV2MEQ2TTlhN3VCckVoRXdQc2p6a0lnT0U4NzY3WUVGejM0OHh4?=
 =?utf-8?B?VEUzQk8vKy9rbWtwaE5qV0pVN2h5QS8vWG0zL21lSDZ3czZ1WkQvbHdwV01l?=
 =?utf-8?B?a2dHN2psNVV5RjFNaUh6dEd4WUdTNzk1ZzlnanI4QjZBR1djRFdIa0NSaFFB?=
 =?utf-8?B?R0N0NjdUTW1wTHdiZTF2ZVI5REhkdVRKQXBjWUlLTzBkYmRKTEYrczJsdUE5?=
 =?utf-8?B?NFhWdVhFL2YyM05OY2JmbFAxaDVPUW5ST0t1MHVkSU5tbGc1Y0NiQkt4QnBZ?=
 =?utf-8?B?Qnc5RDNxZnQzN2tOK3NLZXl4NG8zUThxdEk1dkF2cHlEajJYMGFPNEdSeVpj?=
 =?utf-8?B?d2xRMnFNSXBvYWJQT0tjVTYya0laZ1Z6ZG9BNHVEeGtJWTRtWmVFWWR5UHlt?=
 =?utf-8?B?aTRSYmNKS0xYU3BneHJSQ09BRWpHZnlSeWp3K0RXb05kTFBBN0VCSndhY2N0?=
 =?utf-8?B?Wk1xRzQ5SGdVcnFnUjZ6MzFlZ0MzdCtxenVXTUpIT1EwanBKSVhLbjJKV2dM?=
 =?utf-8?B?Ymk2ZmMyQmxUQ09mR3BoMkhLR3NxSC9JN1BSUWVSclBjQUNaYkNsSzZVVjE3?=
 =?utf-8?B?K2ZMelBFSk54S1dRUFRGbDBDMDBaVHZEeTFoWXFXL0lhQjdLR1FYMUhFNG9y?=
 =?utf-8?B?aXVTWndqVmhkd29FbkpwMGhyK3NjakVRbUpqVWIyTDF5RjhsT1BkcGcvN1Fz?=
 =?utf-8?B?ZU9DbWZEdUJ5eGxramhLUkVDcjFuUlpqdkFtbTk1d1dqbFl0UlJhZ3NQSGVG?=
 =?utf-8?B?cG5lNHFLOCtwbWJGVXVySDRuS2ExdHF0U25JL05JTFBpN0hESEJCZEU4S1hJ?=
 =?utf-8?B?NElKSmJlWHJoZUVXeWFNcHpab1p0cGRWeXJWN2V5dTZQdTkwMTB3OGhQUDVM?=
 =?utf-8?B?VjA5dWw0YUs1bjRBK2twbitvYkd5TmZvRTFOdEZnN3NpS3FVRWRuZzJoOHcz?=
 =?utf-8?B?OW9PcEZQZGZsMTFhSmF4NWROR0Uxclh1YSs4bFFreFZzQllsVUZOTWJyWnBT?=
 =?utf-8?Q?3VZyxzX2XR2nHj2cc0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac872977-6a58-422e-65ce-08df2eb0c22d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:48:01.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2/2J6Dg/+PhqCSY29KR3rcsGd0mZ02uyYpTlk5LpQM7OG2sEegTMBykTaoMaqm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB999203
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 15:27, Tvrtko Ursulin wrote:
> The array is populated from a loop capped by adev->sdma.num_instances so
> it makes sense to size it using AMDGPU_MAX_SDMA_INSTANCES and save some
> memory.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b8aa45db1d84..98c48c45ce61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -395,7 +395,7 @@ struct amdgpu_vm_manager {
>  	u64					vram_base_offset;
>  	/* vm pte handling */
>  	const struct amdgpu_vm_pte_funcs	*vm_pte_funcs;
> -	struct drm_gpu_scheduler		*vm_pte_scheds[AMDGPU_MAX_RINGS];
> +	struct drm_gpu_scheduler		*vm_pte_scheds[AMDGPU_MAX_SDMA_INSTANCES];
>  	unsigned				vm_pte_num_scheds;
>  	struct amdgpu_ring			*page_fault;
>  

