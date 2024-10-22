Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D8CD1715D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 03:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A02D10E0B8;
	Tue, 22 Oct 2024 03:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7C67g+L";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E7510E0B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 03:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ojp56UjY1hhgOT7H2kQ0rF9jpFqRqXctEnL7vaVOnlA3jkV4fF+1hsXfaUvFc1WeamJ8DPHdcBVzziDjd9Hi0SnfgfP2oz+PK2WfiLBidg1EeCZZlpcqZcLNpk8BR1f9atEUovjgTKV83KZbqcPq1b/nNJb6r/seute6oBKDT0NBaqOaja7QR9xFvqmk0tFnxxgaOVmLknubCEfMoubnqPh4p8SrVVqzI/1kCTZVLdZXuYhbejYTrETigqUORrzfD+dIUra/91U8yFUm04AvjYyZOxsbD1A1F59W+mbgzcpyQ2GDdGpqEE3ewyLkMt0uyH3fYv8qm9JGr23sRwW4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOsmGApz7cJLEb+KP41pLQZsu09eGp74Ulkjy5E+9xw=;
 b=YqcWZWc9rbpSCdaYSUlF6Zz+XAluBG64Kt30etzh1XshdR9Vas690jAC+PQuTEjf8Qsx9k6K+1xGTTOV7Vag1/957iMhi4hWlt5CT9THk83nCVW735GV+uGaZc6bZ+l5bF9ZoHLlsj92PJHb5LzGfLNG2JJQMd2c857z1H9CQfGVnT92yaIkwT3fPr9ZDXl/eoFn56akSQWk1lHMllaCPBEYYiVNGgRY4sTIlmePFI3ud7E7IPkJSxcVaCeFzNokABtviMyPt7nuvK8QLm3vifVe/Fl+4QpqTsr6PwAY/cdkw0BaKpcTwTmJdLVQlWjmUpda/YcQ4APzZabzzXLQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOsmGApz7cJLEb+KP41pLQZsu09eGp74Ulkjy5E+9xw=;
 b=s7C67g+LgaL5m0drz5gF0qk3FtI/Fz2yLKA1bIIpwSnFi488I3FQ7ZoaNCU2cB+YWgNcXoRi1WmDqiUsk4MsB5PCrEICxny/nuqoCK3AM8X5ieElkftxLkPTQvbMw0BJG8ctVLoiNP36UfSN3gLKKhw4Hx/FSHbkL8j69NYNWaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 03:24:18 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8069.020; Tue, 22 Oct 2024
 03:24:18 +0000
Message-ID: <f98e47e4-8b79-4bdc-84cc-06f95069b7fa@amd.com>
Date: Tue, 22 Oct 2024 11:24:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: Explicitly specify data type amdkfd_process_info
 in related functions
To: Felix.Kuehling@amd.com, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241015035150.1477582-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <20241015035150.1477582-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: d098bd9d-e054-437c-0159-08dcf24902f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG14K1R1NkdHK1JUeHQ1YkNHMzBvSjVnSkRxRmt5Q0lFZVNKdHVBcEQyY1lQ?=
 =?utf-8?B?Um5jcnkxejJiVXRvQTZBRFdvOFJwT2xYMTdQNUpVNVluMVIyeXVXQ2lpcU5i?=
 =?utf-8?B?WlNOTGJrUWZiT1l5YlYwakxCTXVtZk9ua2FDeENOOHl5djVtcG13M2R3Y3lK?=
 =?utf-8?B?U3JNc1NYMTlVb3ZaandpMEUrUGl2YVZySFN2c0VwL1p0OUszTEZELzFwZDND?=
 =?utf-8?B?dEZFQmtYMGhmMDZzOHBCenB2SWdzQ2xuMEdsWURrRlZoYWtPZjFPd2VlTFVG?=
 =?utf-8?B?NVMvaHRxU2Z0QndJRlpzUCthZW8rS0Q1K0I2aEt3MlRMVWp2MitCNDI0Yk16?=
 =?utf-8?B?M0c4QXpjamExY2c2QnhQazNwcVR2TXNqaHFla3A5N2FqYkxPcXpNRVdiTEZt?=
 =?utf-8?B?WFpGZWlKMkJadlU5SVZjZmFXTHpDN1Z5TmZuSmVEZlV6NGxxczB5SG52OTZo?=
 =?utf-8?B?NEgxbnhubjNZaWVDenlOQ0IwcFd4MXhENEJLcWJzdXFKNDF6YkR6d1B6MkZ1?=
 =?utf-8?B?WW1wTE5kR2o5c0tFaTZDL21ZVjlJT01hdVhSMTEvZDRienNIK0VsdnllV2J5?=
 =?utf-8?B?QVowekhwMSs3RVhpYUJwQWRndmR4dlBBRGh2VDBKbWdIZGhEc2pMUEdYRGlJ?=
 =?utf-8?B?WGNUMTlhcTM3VHVZOEVlc0VaOXpBNnhNZG5KeFdrSnpYN1BDUEUvU1V1MTFM?=
 =?utf-8?B?YTN3T3FBekNQdHdBSTA2Z25ueEVhUkIrUXI5enNNcHYzTUhPTWRDV0k2UkZ6?=
 =?utf-8?B?R3dQVStMTXJFVHVrcy85K0FhaU9GWFNrWUY3andHQXFCL0NVTGNsRXNZbDdY?=
 =?utf-8?B?N2RFSmJTbXRyNkRFV0lWQk5ScDRJbVBsa0pOeWdiRmdPOTU3UHpnRUEzNTEv?=
 =?utf-8?B?M0Rid3VRZ1VvVkE4dlFpdW9sZDJkdEptS2VGSk1BZUpUODErNUtsQjRwdUhJ?=
 =?utf-8?B?bkkxb0xyWnNwU3BkVEVFYnhackpMQXNkUkVZWmRSRXRCT3Z3MmtXcEJJWmp6?=
 =?utf-8?B?amFRRlFDMkszQklvcmxESVBMTXBpWTF6bjA5NTkwV081dzZCZFc4ZVpIdUk3?=
 =?utf-8?B?ZTIxOGRta3pja041S1Z0eHU2SERROWhtTmpLVUFkY2RERWZqaVNpdFkzYjRH?=
 =?utf-8?B?YnFpYTlaWktQV2RCc2FCMkh4b3NRamNpQTVSVXNNaFg1SEMzYXFZM0Noa01a?=
 =?utf-8?B?ajVKYU43U0RWSCszSWlTSFZmWXA2MFFJMEMrSWVUSFRTNHVIMGhnNGJrbWh4?=
 =?utf-8?B?bWtIb1J5M0ovdWhobnZQeWdmQTJ3NWVGSUJRUWlueGdFVkdidzBkYisvNVYx?=
 =?utf-8?B?MTUyTmx6VXFTRTErRzFaMVc5bExpNUVlN01wSmpJbzZWUER0UFFURmdLT3Iy?=
 =?utf-8?B?a2g2enFQSGlIekhIRytCRGozWHI2SVRhd3ZtQWIwOGswRlpJZDA2WjNvTlRo?=
 =?utf-8?B?MklLWkMrM2E3T3MzY0dqTFNDQzE4QkM2Rld2U2JnWlUvUE1abDhFMkU3MGh3?=
 =?utf-8?B?bzJ5N3FXT2JDZHZNcUZvd1VRZjFGVFBjYjU0SlBpNnlJMTVYaDFQR3k1TGwy?=
 =?utf-8?B?dzZHVXFTNDFPREI3V2d0alR6NnQvYkVpdnQ5aFMwd1YwbWRLblpNeVVPYW51?=
 =?utf-8?B?Z0YzMEhEbUpWWU5iRlBnZWpMOW5tWEhFV0dUVXNuR2ZCc1VyWjIyUUF0RFQ4?=
 =?utf-8?B?V0ptdUxmOTRoSkp6NGNJNXVISmxub01ZL0laZnBkTmFhZjc2dkVjcUFtZVha?=
 =?utf-8?Q?t+j4+GBl4/1hngC76tT1pGhD6ZQiZPPgl0QHawi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hKckZadTAwYjA0VFh5cWEwWXIrd29FWHI0Zyt0QnhHdDdGcEhBUzZha29C?=
 =?utf-8?B?WDA1OXNjcUIyTk40NzRHM0hzWTE3VXllSDlvanh2MzkwbFpsVW9ZaER5bTE5?=
 =?utf-8?B?enpRNmQ0Ym1haFZGQ3lQaW9iVFZ6blNHaGVJMVZZUjNibHMvMDcyai9QVDF6?=
 =?utf-8?B?bFc3ajE3a3dTNSt5OVp5VUVONGhqODNXbGkvRGdsRk9UazhieVRrdWdQcGFn?=
 =?utf-8?B?bEZiTVFYaWVKcWtnUUpubHgvUjhxWlo0Rm1zZTdEUjhrSkZzNGx2NCtBeDhK?=
 =?utf-8?B?S1l6WUg5amk1KzdDZlRrMzVsMGF3WnUyYm9ZLzlOQVZhQkFJSGpLV2VKcnIy?=
 =?utf-8?B?c0h6bklqM2pMVXIvUzBMUm5Namk5Z3lySklOS0dRcnZKNUZHV04ybW1OYWcw?=
 =?utf-8?B?cWZhZC9xWjFXVnFsYVNCSExiVXZuZDBJeERxTTA2cTdBYnJzTkw2Wm1rWENP?=
 =?utf-8?B?VjFtd3pjc2NvM3hYVXQvWXhMRUpBbzA0dUhudWVhbmNDYlZKdlR6K2NuNHJ2?=
 =?utf-8?B?L3Q3dFlwYVhxY0tsbnozbWNQS093VnFJY1EyL09FZGNCa09NYnJUWk1pcEJi?=
 =?utf-8?B?dmVnaEZPREZJY2UwdE9BYXJ5WmVMWW5EVXc1blhHaEZPcjZHakpDemJNNm9i?=
 =?utf-8?B?SGYvYUFMYlhNVXJwQXdZUm5FYzVkbVVwbnlpUXUyd01SUGloTUJYdjVxYm5Q?=
 =?utf-8?B?dnlnYUhQWjBHakNteGlrMDV5U3k0eVQyNUc5UmtqeENUbnVycnU3MDB6RDcz?=
 =?utf-8?B?ai81NC9LNW5USzNJMHpYdFB2dGY4NzNNQVFpaUZJTkJ0UUdlcmlMYlJjaU85?=
 =?utf-8?B?azRQMnEyVi84Uzdoenh5OGZ1OTlubGZHTG5uWGdxOFlkS2h0UEF4T0p5Mi9i?=
 =?utf-8?B?dndrVG5VQUdEeTVHSDhpbFJ1YkN3amFtcTlYUlRab2lmMWVRbHFOR3YrU1ZG?=
 =?utf-8?B?WVQ1Q3Iwbmw3c3c4N3hhbEcyb2c5b0gvTkt0RDJIcjcxT20vRXU2T0UwaDRO?=
 =?utf-8?B?a0ZzVmd0TTd0d1gvWnJ3eFVjNHR6NzY5TEszTDJ2ckk3RlpxS1VTTXRpbkV3?=
 =?utf-8?B?K3dDSGtvVEVEL1ZsaUZSR3Z4VVkweXREOVJ2R3BkN01vRnNaNVl5ZEVyUXpm?=
 =?utf-8?B?VzlUWkJtOS9zcHNzODdydUVZM05ib3laMW5OdVBnMjA2WXZtd0VZWGxVVytW?=
 =?utf-8?B?aW5wWHRRUklGV0N3bGNrOUtkc3RCb1lWV0p0bmZjbk4wdXVabkI0MVZERnhi?=
 =?utf-8?B?VnpSWm1kQWlJYlZJUjR5anhCQmdseFE4MTdGSVR4NnA5VENIZHVwUkliNE1N?=
 =?utf-8?B?SUpLTWRKUWZwTGJ1bkV6enVlT2JmczMwcHNJMDk0clYxOTJwU3ZKUDJsRHBu?=
 =?utf-8?B?VStjdDVMTlRjWVlCdU5uemFRSDhFYkpnZ0l1cUVNTG54YjRCUlplU1BGOWRq?=
 =?utf-8?B?Vk1xQmF3S2w1eWE5VEtDcUpMM3JaYWIwUHFFR25nd09JcEJQK0tManZRRys0?=
 =?utf-8?B?ck5Gb3hmTmtzeWJQY3orWVowWWowN0NLM2VRWVdzbWJNeVhWMkNHMGZReUw3?=
 =?utf-8?B?R2RaQVRiR2FMa2krejhNVGI2Qnh5R0lGdWVDNmpVakp1TGlrQWhMc2xzeDZQ?=
 =?utf-8?B?V1hKU2VrTldUMDBhTjY5elVLRmJJeVhrdStCMXBGQ2wvMXhhZUIxWUhVM3ZY?=
 =?utf-8?B?NjVTdS9BMk1IMk5jVUo1T0hMck1jeXdVbC93cUY2VkpFRm5TZ3BlbENuK3c5?=
 =?utf-8?B?anpIbzdNMFVVNVlHUVpXOUM0VVBUaUErVzVzb3dsa3pyL01adkdkdUhJZjBh?=
 =?utf-8?B?dzUvWEFtaWlpOVJmR0VERnR2YjVXUXNRSENJYU81alNHSE5jdkZXdFNtSm9Z?=
 =?utf-8?B?SWNscllSeEl0NEhrbExrSzNMNUFVZ1JNMXFieCtQUXV0ZlVxbGVId3dKOWl3?=
 =?utf-8?B?TkhBNVBnSW12bE9aK0FUUnQ3R1hRNEIycm95clBEbkNQU1JlQWU2MVRqSUsz?=
 =?utf-8?B?U1FjSWtPU1pUT0lMRWg0UXNHbFh2MWVkWVdhdWU3UGxIeE9Pb0V0MHNFVjhm?=
 =?utf-8?B?cnJ5Q2x6TEIrNE5TSzRTd1l3ZGIxUUNoK3hnaHJ3Sy9xd2NyTmNLTGZ2dFZH?=
 =?utf-8?Q?dvyWuthsbGTLP9DYuwHMRMs2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d098bd9d-e054-437c-0159-08dcf24902f9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 03:24:17.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDZkXpX/iVUhgvN7FOFAFqLTd7f6x0S1iOjSHrMKnoTQOf8qViSAm+VsO0h6aIDgE24U2kPv1ZDtKL+B1xkeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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

Gentle Ping

On 10/15/2024 11:51 AM, Zhu Lingshan wrote:
> This commit specifies data type struct amdkfd_process_info
> rather than general void* in ralted functions.
>
> kfd_process->kgd_process_info is initialized
> in init_kfd_vm() by such code:
>
> static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>                        struct dma_fence **ef) {
>         struct amdkfd_process_info *info = NULL;
>
>         if (!*process_info) {
>                 info = kzalloc(sizeof(*info), GFP_KERNEL);
>
>         *process_info = info;
> }
>
> That means kfd_process->kgd_process_info is type
> struct amdkfd_process_info, therefore we should avoid using void*
>
> Using a specified data type other than void* can help improve
> readability. There are other benifits like: type safety,
> avoid casting and better compling chekings.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 10 +++---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 31 ++++++++-----------
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  3 files changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index f9d119448442..c1346b8c9ab7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -239,8 +239,8 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj);
>  int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>  				void **mem_obj);
>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem);
> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem);
>  uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>  				      enum kgd_engine_type type);
>  void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
> @@ -299,7 +299,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>  				     struct amdgpu_vm *avm, u32 pasid);
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					struct amdgpu_vm *avm,
> -					void **process_info,
> +					struct amdkfd_process_info **process_info,
>  					struct dma_fence **ef);
>  void amdgpu_amdkfd_gpuvm_release_process_vm(struct amdgpu_device *adev,
>  					void *drm_priv);
> @@ -348,8 +348,8 @@ void amdgpu_amdkfd_ras_pasid_poison_consumption_handler(struct amdgpu_device *ad
>  
>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);
>  bool amdgpu_amdkfd_bo_mapped_to_dev(void *drm_priv, struct kgd_mem *mem);
> -void amdgpu_amdkfd_block_mmu_notifications(void *p);
> -int amdgpu_amdkfd_criu_resume(void *p);
> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo);
> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo);
>  int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>  		uint64_t size, u32 alloc_flag, int8_t xcp_id);
>  void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index ce5ca304dba9..2a1ee17e44a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1376,7 +1376,7 @@ static int process_update_pds(struct amdkfd_process_info *process_info,
>  	return 0;
>  }
>  
> -static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
> +static int init_kfd_vm(struct amdgpu_vm *vm, struct amdkfd_process_info **process_info,
>  		       struct dma_fence **ef)
>  {
>  	struct amdkfd_process_info *info = NULL;
> @@ -1552,7 +1552,7 @@ int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
>  
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>  					   struct amdgpu_vm *avm,
> -					   void **process_info,
> +					   struct amdkfd_process_info **process_info,
>  					   struct dma_fence **ef)
>  {
>  	int ret;
> @@ -1639,19 +1639,16 @@ uint64_t amdgpu_amdkfd_gpuvm_get_process_page_dir(void *drm_priv)
>  	return avm->pd_phys_addr;
>  }
>  
> -void amdgpu_amdkfd_block_mmu_notifications(void *p)
> +void amdgpu_amdkfd_block_mmu_notifications(struct amdkfd_process_info *pinfo)
>  {
> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
> -
>  	mutex_lock(&pinfo->lock);
>  	WRITE_ONCE(pinfo->block_mmu_notifications, true);
>  	mutex_unlock(&pinfo->lock);
>  }
>  
> -int amdgpu_amdkfd_criu_resume(void *p)
> +int amdgpu_amdkfd_criu_resume(struct amdkfd_process_info *pinfo)
>  {
>  	int ret = 0;
> -	struct amdkfd_process_info *pinfo = (struct amdkfd_process_info *)p;
>  
>  	mutex_lock(&pinfo->lock);
>  	pr_debug("scheduling work\n");
> @@ -3093,13 +3090,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
>  	return ret;
>  }
>  
> -int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem)
> +int amdgpu_amdkfd_add_gws_to_process(struct amdkfd_process_info *pinfo, void *gws, struct kgd_mem **mem)
>  {
> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>  	struct amdgpu_bo *gws_bo = (struct amdgpu_bo *)gws;
>  	int ret;
>  
> -	if (!info || !gws)
> +	if (!pinfo || !gws)
>  		return -EINVAL;
>  
>  	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
> @@ -3110,8 +3106,8 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	INIT_LIST_HEAD(&(*mem)->attachments);
>  	(*mem)->bo = amdgpu_bo_ref(gws_bo);
>  	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
> -	(*mem)->process_info = process_info;
> -	add_kgd_mem_to_kfd_bo_list(*mem, process_info, false);
> +	(*mem)->process_info = pinfo;
> +	add_kgd_mem_to_kfd_bo_list(*mem, pinfo, false);
>  	amdgpu_sync_create(&(*mem)->sync);
>  
>  
> @@ -3136,7 +3132,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	if (ret)
>  		goto reserve_shared_fail;
>  	dma_resv_add_fence(gws_bo->tbo.base.resv,
> -			   &process_info->eviction_fence->base,
> +			   &pinfo->eviction_fence->base,
>  			   DMA_RESV_USAGE_BOOKKEEP);
>  	amdgpu_bo_unreserve(gws_bo);
>  	mutex_unlock(&(*mem)->process_info->lock);
> @@ -3149,7 +3145,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  bo_reservation_failure:
>  	mutex_unlock(&(*mem)->process_info->lock);
>  	amdgpu_sync_free(&(*mem)->sync);
> -	remove_kgd_mem_from_kfd_bo_list(*mem, process_info);
> +	remove_kgd_mem_from_kfd_bo_list(*mem, pinfo);
>  	amdgpu_bo_unref(&gws_bo);
>  	mutex_destroy(&(*mem)->lock);
>  	kfree(*mem);
> @@ -3157,17 +3153,16 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
>  	return ret;
>  }
>  
> -int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
> +int amdgpu_amdkfd_remove_gws_from_process(struct amdkfd_process_info *pinfo, void *mem)
>  {
>  	int ret;
> -	struct amdkfd_process_info *process_info = (struct amdkfd_process_info *)info;
>  	struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
>  	struct amdgpu_bo *gws_bo = kgd_mem->bo;
>  
>  	/* Remove BO from process's validate list so restore worker won't touch
>  	 * it anymore
>  	 */
> -	remove_kgd_mem_from_kfd_bo_list(kgd_mem, process_info);
> +	remove_kgd_mem_from_kfd_bo_list(kgd_mem, pinfo);
>  
>  	ret = amdgpu_bo_reserve(gws_bo, false);
>  	if (unlikely(ret)) {
> @@ -3176,7 +3171,7 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
>  		return ret;
>  	}
>  	amdgpu_amdkfd_remove_eviction_fence(gws_bo,
> -			process_info->eviction_fence);
> +			pinfo->eviction_fence);
>  	amdgpu_bo_unreserve(gws_bo);
>  	amdgpu_sync_free(&kgd_mem->sync);
>  	amdgpu_bo_unref(&gws_bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d6530febabad..b0426a1235b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -934,7 +934,7 @@ struct kfd_process {
>  	bool signal_event_limit_reached;
>  
>  	/* Information used for memory eviction */
> -	void *kgd_process_info;
> +	struct amdkfd_process_info *kgd_process_info;
>  	/* Eviction fence that is attached to all the BOs of this process. The
>  	 * fence will be triggered during eviction and new one will be created
>  	 * during restore

