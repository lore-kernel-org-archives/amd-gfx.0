Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F6C5AE5A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 15:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68BF610E588;
	Wed, 28 Aug 2024 15:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YwUA/9Ic";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9360610E588
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 15:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJEF97BfSaIeX9zgUd2wKolEke5yuVQ4eQx9vjywXPTW92o1bu+obH7Y2hNOFsnWyJIYvjBO9bBLl4lBdAII9c2uc1EEtHRVc8j4fBCq5jMJ2ZEsyWgDxRNuRqy2toufOlTsja74EWMHsbYBMLY9y6rLcmIxc0xKmk4CIAsj9sLzPCxvQjh2pIdjhac3EaGujwMS+PLLgjdcjvaqe7015uWu0CPnpLP09nHzDcwXNSnGJXWkghp57VECwSZsYBsqT0k1AZOxH4Lig2UpIJbsOIlFuWQfW7K2KADOqrcVcLlN9fiuOQVFY0ijn8ro1p1MCJSH6wFOyKR6+X/Om97aRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jW3qvGTv+R3OEDK45F1bAu4NBsFhO9yCQ6COU7l8EM=;
 b=PSdQwtlzl/wGlYlh32bttTT5RB9QSJQ4nggx8Qpg/08EaHeCD+z0yJuFmNMMNrM4Cq8yOAgQcTAS708WTXISZDu/B2wTaQ/3e74QALMpO8jLQ64BCVX0hX7jlSv8Fo67KtqC+D0FVpp17VLpAl4swRx62pvJTzU9PL+wY5r6coXJPuPy+42kCu/Ic68dafyjyejpmZJITsc2Vgf7Pmp1nk44D4wxs88LbZxXWapEgMg6lR/XpR4tb1fD0uM/+NTRy2RsQtbau6Z6X1MS6Jfi7H5dhbkGsZyerZ+9a5Wg3BBzKm8AK1Buc2KPPsjV+FBJ6p4Q7bfnxRo0ziMCqJGTPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jW3qvGTv+R3OEDK45F1bAu4NBsFhO9yCQ6COU7l8EM=;
 b=YwUA/9Ic1EjFdYB7pRFjkkpYvqrH+uM2uV42GSgfPKDyzMS9zMMs3NdWVR1VEtStWvQGVUnbJwxg14CfipvRDUjKzNd8UbGILkiwcuL71YaD+aAlrssi27V12tQPGWlr1bkd26yDudu5b8HIUpRe8GDO4iYnmJ0EWN0AC0Ayndg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.26; Wed, 28 Aug 2024 15:18:12 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 15:18:12 +0000
Message-ID: <a409f928-ffc8-4edf-b139-2660d8a715ed@amd.com>
Date: Wed, 28 Aug 2024 10:18:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/: Add missing kdoc entry in
 amdgpu_vm_handle_fault function
Content-Language: en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>
References: <20240828030926.4065919-1-srinivasan.shanmugam@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20240828030926.4065919-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:806:127::16) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: a7afb841-ead4-4331-273f-08dcc774a16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alBJOWRsVFB5SDNKR2VlUDgxY1BvT1pvY1Nmbk5ndHMzdkpjdTg3V01wSUVX?=
 =?utf-8?B?RUR5cC9hK0pGOUp4cFFjRnpNQnI0a3MrVGZCMi9aUzJvT2J5RGw2SFJCdUJR?=
 =?utf-8?B?cHZ2NXlPcXdMa3ovWUVzMWJibVpmL0FtL0FmbnIzTm05OXBmNHdvTTN4SlJq?=
 =?utf-8?B?TE9pQUdxRmNFdUNWWitpN2luTkFDYW9tUU5NTHo2aHp0VGxnMWlBVlp6RHI5?=
 =?utf-8?B?bXFYUWJLWW0xMUtST3M2cnJoMkhRM09EYjNQYzlTSWV0WGJHdE95RFlxUUNT?=
 =?utf-8?B?ampzVHVKQzZWSkp4TDlOc09EWkJQUGlqeHd1bExheTlLTDFqeDh4WVZJYjR4?=
 =?utf-8?B?TENqcnlUMVdzY2E4ajVzbVN6akFhaW95aUJDeDE3SEJpSURiV0RJeXZYTmRz?=
 =?utf-8?B?N0lLWTBKRDlWMEhFSG9rSTVITnhoVEJpZ0hTRnJNcXRISXk2bUtaZk5LNE5V?=
 =?utf-8?B?dFpLMzRvQnRkQXlFbk54b2FXbXIzcVhUbGVhaEEzMTllU0FDU3E3MlYwLzRY?=
 =?utf-8?B?RjREdnR4amlybUM5NFI3WnFkUXVvd0o2N1N5SzRCNWFnOXBZVkJMLzlRb2VW?=
 =?utf-8?B?VUpTcVFvck9BWHQwdGtCYVpwUkh3cXRtMndUZkdTOUlmVCtPZWF0RGRpaDUz?=
 =?utf-8?B?eUdCUmEwYnFVZUtmd2E4bGlUYzVZbExhbWh5VW5nUWZwSmFmZThEM2FiU2hj?=
 =?utf-8?B?Yzk4WW1HREthYzZWTnFCRTM5Q3ZHcElnNzZ1MlRDYXlXRCtoZ2dDbHJIYUd0?=
 =?utf-8?B?ZWN3alExWTdIY1BQZjRaV3NsN2hUS29Kc0ppenAvSFhWSUVqRHNHN0ErMFJy?=
 =?utf-8?B?NEovQzBHZk1nSkN0ejRPNzlCaHp0amdhN0p6V2tjRXhMTGVodk9mTW54S0F0?=
 =?utf-8?B?bXFTbUkyOHQzUkFIOUN5d0UyV2dzTlhKa0dBSWNXaUN5NWkwOUx0U1dmaEsx?=
 =?utf-8?B?bUN1ajIweTZNSzV6RFNQZjEveXhQNkRyakdiK3JVU01JVER2VU1wRWpFM290?=
 =?utf-8?B?TUp4QURaZTYyL2xNNjNscUdQWVhDSGtTejlqTXdpQ0NlaHVyMThETlhxeWJ5?=
 =?utf-8?B?blhXdFVidW12Wk91ZVpyZEg5M1pObXFnenNVUnExMkwwQS9RWGZkVW1ZV25o?=
 =?utf-8?B?K2JVQ090WUxwanZ2Y0VoNGM5TUJ5U3h2eEtadFRIZlpBbW9NMHFjZXREMm1U?=
 =?utf-8?B?ZnJ0RzdCbFZhWDRqSGdlVU5qU2JURCs4NGdIRGFxTm5VbTBmak5JMy9DWDJO?=
 =?utf-8?B?STdtZFAwNWVDRG5FZ29mSXBvR2MvQjdCeDZSUlpJUGdoODBSM0tpZ3JWUUdW?=
 =?utf-8?B?VjR5Y0N5RXlrN0tpUUs0TElvT0hsbTJlY0t0RVptcmlwRzMyVzZPZFFTMGlL?=
 =?utf-8?B?TFZFWmF2UXNWSTVmc0dadWlNV002NzJTbnBGRU81Q0xTdEhIZHRpSjNXUzFB?=
 =?utf-8?B?bjhoZlNaS0RZTGtVUWdhWlZhTjVEeEVEWnhPQ051NHlLcThabUZjVHRxUE0v?=
 =?utf-8?B?cGlyTGZUVGhXLzh5aE4zNldzbXpPVnRVOXN1WXU1a1pmUWtZMmEvUXl0OWNP?=
 =?utf-8?B?RVo5Y09GSjFIWGV3QThZTXlVc2dEYXQvZmk4U05GL2pFNzlJTExLVDFzSnRJ?=
 =?utf-8?B?M2U0Zi9Nd2ZBNGsxbi90aEpoOTdxelQ2Q2ZXTXZUeVU3M1F5Z1V3Nm85UDEv?=
 =?utf-8?B?UU5SaTFmaGh2dUFLZHJ5RjVya0xhWitBaG10L1dJUGtTQmJCRFpZUWxldy8r?=
 =?utf-8?B?TSs5Z3l0YmozL2htNlMvNEk2NU16RkMvODdPdmRUaUpQY0pORjZjZHYyQWJr?=
 =?utf-8?Q?c0lGl2k2QHMPNWNmPBGeYxwlLOG+Mdmi2cejI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNseWptMUxLZGhIaGFhOEJJQU1ZaFpLbXpDYjdSR3ZqWHl4alVQM2dWd2JP?=
 =?utf-8?B?L2ZTMWpycFZUazhZaTMrdmQzbFNZblp1bGhlNnA2WHRqZVcxcXFRM3A1OC8w?=
 =?utf-8?B?cXVmbEhabWxKTnJxOVFrV0ZUeGI0S0k4MFNpMlJueFBEZEhYOVZ3dDB1T0Jz?=
 =?utf-8?B?MmRGaXRmVnErM3k4RkNSU1RKV0Fja2Z4MGNDZjhUanNOdHpoR0lFNVUrKzZB?=
 =?utf-8?B?aG5NVUFXTDFGNzdHZVZCZkJEcFB4Q3hnRndpaVl5TWNNMWtHS2kwY1ppNlhM?=
 =?utf-8?B?alltY3d6cGlwTFFDSEFPd0luTExHZ0ZYbHdvRXhoUlZ6ZDlFZTlmRlpaaU1V?=
 =?utf-8?B?azBwTEJuWVd1MHlCaW95T1hHd0VxWjQyTVVxRkI4Y3NSQ1ZGaDJ2YkVnMUJS?=
 =?utf-8?B?RUtUZzhJZm43SmxOWWNZWlU4RTd1Z3BlSTBya01jSVlnaWE5ejl3VXJlc2xy?=
 =?utf-8?B?dCt4QThScFJmOXRLVDNObkwvMXJuZTZ6SXoyRHBVNWVjL29Pam95M2pMb3Z3?=
 =?utf-8?B?bHVGazVsZWU0b0VKQkhGRWNBOFo5SGpVdDhqSmRXNWVFbTBWRWx4MDVFWEx4?=
 =?utf-8?B?MGhrNGVMV2x2blVOVTI3Z1ZZdWRHSzdTSnVuc09WbzZJZ3NDaFRtSXNiNWto?=
 =?utf-8?B?Mzk5NFIxdzN4VUFtTDdDemVNN3dyc04yc2l6NWN5M004U3htSjd0TGZuZk5Q?=
 =?utf-8?B?eEwzTVBSK2lPaU9LaVFaMEFTNlg5YU1WVzUvRFF2ME9KRzZJcE1Kdk96NS91?=
 =?utf-8?B?dEdOYTNicVZSNXk4TWhHUmI4VzlleXZCNkE3NnJhZUJQMVJxb3lFL2dLMkNm?=
 =?utf-8?B?ZlcxMEkvblowZmlYdEpFZ2dtbURpZXJXVmx5OHMzWENTY29nRkVxWTB5bUpU?=
 =?utf-8?B?c1dlbFhxNmlkYWt1REtZK3VRenZjb1BPYVJxSnFQSGZyZDNmMUJyOW5WT00y?=
 =?utf-8?B?RWM2VkZRdUJubnptTWNkaGZ1cUxZUnUzUnBTUktvbXZBb3A2NHFTUmVaekVO?=
 =?utf-8?B?MmZ3ZTE3REhpRy9PYmZZSEFhcm45MWlxMzR4WXlGNStyejh5TXdWYUxwN01r?=
 =?utf-8?B?UWR4eVZzU1dFVkxPbFVEOFQ2WjZuZFhmL1FJdktrTGxybkJmNXhYVE5PVHhz?=
 =?utf-8?B?c0xjT1Z0NDNxVmszeWJOcmRiTjhjZWM3M2dOa0c0emdZN0p4Lzl2ZHk4eUls?=
 =?utf-8?B?VWFsekxUd3dPSktYYW9HeFZnSDI2RHZyTzQ5RmtyNEJISWtUV250RU9qaHlw?=
 =?utf-8?B?enI5NkJzMEFxM1NEL3EvZGdTTEN3UHNoV05YNnEvWWZGZFZHaGxtVHdRRWw5?=
 =?utf-8?B?a3FDTjBwL2xSQ2dYaUVRb2ZPTFBCekxOd1hTYVZnQldnRjVwRk5zNzRaNVdT?=
 =?utf-8?B?aElqbE9odTZ2MEMrYXF4a0JidnYzK3ZvSUlYMmRsb2ptMmZFOE1iVG5ya0hl?=
 =?utf-8?B?ejBWUjVhZm9zRm5PMUg0TG9veVY1bHg0a1JsbHVEVDU2OW5DeWllNTcwdjhX?=
 =?utf-8?B?ZGxPR1VjMTBUYXdwWW1ZZWJvUXBvSXR5WHFGeUwxYnIxT2doSlAwN3BSNGxr?=
 =?utf-8?B?VlNKbXNpQlNGWVZMY0VXWmJIZVNhMjd4bkRkb01iajRKYlBGdlI1ZE5WWDBz?=
 =?utf-8?B?d3RwaFlDQ3ROcTk4M2Zic3g1bFo5WC9ieHlXNVpNbGZvNktZRFJIQlpocUR6?=
 =?utf-8?B?L0w2VGlPOXJPVWU1czNjRDZkTTNuR3JrNi9VZlpMZkxHTXFocEFueTNLL0pT?=
 =?utf-8?B?ZEg3ekJ3MDM4eGU4SEZ5S29pRE1KYzhUK2dkVnlmb2J2N2M0OWM0SDNlSDBh?=
 =?utf-8?B?cXc1L1JqN1oxVW1YaWliakpKUk50QTlLTVU2d1VEK2xyS0lkVW1WUXlzdk5O?=
 =?utf-8?B?Z0xCdUNpVXhaanpoaGdBc2FPRG5neTFRVXhxZmFSeUNYNXg1eTdSVy9hcjF2?=
 =?utf-8?B?NERWWlp1SW1La0t1NHVpaFVaOUVYVXU1RzdKRjVHbE5lZytWSDczNTNCVDhB?=
 =?utf-8?B?R1lxenNPZVg2aWpvZzZCcTRpQTRkRUV1T3UrM1IrMXRId0dldndnZ09NZ0xX?=
 =?utf-8?B?ZE1Eb2RlQko4UG9mVnBoK3o0T2dhWHk4bUFnWnd3QlR6aWJ3VThYcDlnQjlo?=
 =?utf-8?Q?EBlE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7afb841-ead4-4331-273f-08dcc774a16d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:18:11.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSLUt3cuCdgGoDhQxCP4s0c9iy9Lx4PNoVq1CpzEl8uROj1bRKiCAk4b/cjXHGwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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


Reviewed-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

On 8/27/2024 10:09 PM, Srinivasan Shanmugam wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> This commit adds a description for the 'ts' parameter in the
> amdgpu_vm_handle_fault function's comment block.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2781: warning: Function parameter or struct member 'ts' not described in 'amdgpu_vm_handle_fault'
>
> Cc: Xiaogang.Chen <Xiaogang.Chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408251419.vgZHg3GV-lkp@intel.com/
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2: Added Reported-by (Xiaogang)
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ad2e469548c9..0fa165e8fb40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2766,6 +2766,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>    * @adev: amdgpu device pointer
>    * @pasid: PASID of the VM
> + * @ts: Timestamp of the fault
>    * @vmid: VMID, only used for GFX 9.4.3.
>    * @node_id: Node_id received in IH cookie. Only applicable for
>    *           GFX 9.4.3.
> --
> 2.34.1
>
