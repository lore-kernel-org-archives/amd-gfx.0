Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF5AC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 07:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32ACE10E4A5;
	Wed, 15 May 2024 07:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="buYYagsU";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339CF10E342
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 07:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izg45Twi9KcY6MZQBHIGbK6JTrsdXpRuX5KQg98W2xVagYupIXQWH/j9tcOCaBA8xfGjgmC/6I9IlllaA8DKULrc95DRsx1OANY8IgFVA0G7fHrybSl1vB8aDWZ9HhTxvx+pSiqPvmBrcqWHlpMdgQhrI3/OGsjmJMQuwELi06IGCJlqp68QkrY2SWefM4l8cjt3C+2plfSURU2M3oEgZknOcxGqCNvAboZ44rRM7wbR9zfYHkNo8FrsmnEruUSW2rli54hAqlUoU7o3myaLRpb6ZMWiiq3PyEKsJougu9N07Pk/soduDDwIs3kO3vF7OnSgrJp1jB7qMafANjH9pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVrMpwvFyk4L+K14BMKUIbeOa0wJDhFxERYHXVHNrWI=;
 b=eqrSU80btt0QAxFg/rqP8P/zoUv2Nkk6LfechouIb3fslV7R61M9MYYTBSKCAqG4Twma3HOM4MD707K45pOLNfbC97uBOYYQzo9EPQRRuEFRW1CnnjOdxs86RS3+ZMRfkruRW/KSupXZtqmocPnNkGS0386aUJg3kgmpwzyV8Bb3t74S03nGw1Hz+2DipQduGKE1Hg1jfjH8vARHSzX0DLLplu56Xe1P+6pCLCNGGGsPEQwA1SBFA3WO3zjqlhVrHdscXvgPMflaYkffbAQSuvvBzASWjFrBl5MJIxis/za3u929QZy8wn/q71epXTEKEF+An2ODjOR2oAveaciZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVrMpwvFyk4L+K14BMKUIbeOa0wJDhFxERYHXVHNrWI=;
 b=buYYagsULFGUyE0QbFP5CRXPb7u3vrywb5/Zk6njoB+5LLZv/wXIjYik2TGKnTN+CrrJhYIPUxdqgkcicnVNjzXyUBgY7RSrLNEJSbKvy8sxKmhxsYNmtAxHM1CdUW5N7YvTfLiTJ1gouT9sBkj39qbnRL9FqzJS8zOJsP8/+I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 15 May
 2024 07:03:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 07:03:37 +0000
Message-ID: <1cca2073-eff9-4c86-946b-ea105b82a90e@amd.com>
Date: Wed, 15 May 2024 12:33:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Add PM policy interfaces
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 Le.Ma@amd.com
References: <20240514110606.396234-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20240514110606.396234-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::23) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: d55b26c7-ab8c-4982-2918-08dc74ad24c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpZQU1lSkZyMmc0SlNmeUIrRmtqQVRmL3lPWXZCZWNwUHQzcmFRUkZSL2pq?=
 =?utf-8?B?YVV5VVlUV01vMVFqQzFWK2V2QVlCQjNqT0tXdHF3MmtPREJRZ1lLeTloM24z?=
 =?utf-8?B?dGZ4ZWZKWlY2cVZoVURlcitqdTZEQnJVT1BmdFE0M2Flc2MzWngzRFJEdUI1?=
 =?utf-8?B?VFNSOEMraFBFMzR1cUJOV29icEZkOTZPd1pLYjBCTHR0VXovTHdOZmNOaTF2?=
 =?utf-8?B?U25ydGZNOGN3Yi9qczZsMytrNFljYmxtK1RzcURITnlZV1QyUzJRd0FidnV0?=
 =?utf-8?B?YkprblhySDlzUUNoVWRzcHExRjBpSWxzZVVpbUtOakE5Wk00bStwejhZSFBB?=
 =?utf-8?B?blRlK3FKY3gyMFVpcENnVGJDVU9ISjVmTFRQbnNGclhRWkY2UzFwRUw5eDZ4?=
 =?utf-8?B?RnZuUzdrZlVOZURVbHBPbnhSUGFnV3FRU1RUNEg4T0R6TFk5N3pSK28rSUVl?=
 =?utf-8?B?dko2NVJrMXh5NFloeTJaWW9rYmtnQlZTMi9VLzBJT2RDSjBkRlBFYVVSdER5?=
 =?utf-8?B?QkFSZUlKVFo0YkNTeWpVQ202cTZ2anpZa3NsMlQ1OUJtTDd1YmVNQmh0a25O?=
 =?utf-8?B?MVVNQUE5UjNHNUFFWWdlQlpPYzk5T3hvZnBiVDV3TjBZQ1RmQXJtQWFVZUlq?=
 =?utf-8?B?VmZ4aUJyeWtWdzJXSjV4MGdaYjFKSTIxS29mOHpNRTIyazIrQytXdURwdTdS?=
 =?utf-8?B?UHZGT1VYZlhvOVBobFl5enBjMVdlakZicTdaS203ajhQd3lQNWNaNENtWExU?=
 =?utf-8?B?dUJsMTFYZ2NrRTRsSW0vN3ZMN1V5Y21SdjROZHpPOGVvWWJGLzhPU1VMd2d5?=
 =?utf-8?B?WmVoelBlSzZCQkhDZ0FMRjFsa29nbDhSZEgwaVUzNDdCWmp3RGl2enI3UmZE?=
 =?utf-8?B?MHpVaU9oa2oxaHFiMlJ3N2l1Mm1CZXhRV3NLdnBzczdjVFUrck1aS3NaZmh6?=
 =?utf-8?B?K0J3aDR6cy9wVGhGSzFmMHdJWUN1eUxJeThLUjRqNlhtV3EwVmJMOTNBYldP?=
 =?utf-8?B?blpRQ2c5MXFUdkZ5cVpBR016MFp6aUxCYnNvWCtvR2JKbXJiOTY5L3NoT3dG?=
 =?utf-8?B?Y1B2ejVSbmlBT0hvTnZ2VWFOdHZRbG9tYmlsWWgxTUxGeStMbDk1Y0FBY09Z?=
 =?utf-8?B?K2N1aElQejhsRGltWUltUUJmWW5ybVBKZmRaM1JjVXJtcGcyMHN1SFBVcmVW?=
 =?utf-8?B?dkFCZkRWTkRaSElCK2R0b1NtTGYybUxTb0orS0xseVJhZzNCdnJ2KzZhcU80?=
 =?utf-8?B?M0hOc3N6QVhsRzNIS3plbmlrWFdsWlFtWmczZ2IwOTkySnYwbzRyMFFwWmlm?=
 =?utf-8?B?RjhURWt6RWV3S1BGNlc4NVZuTXVaZnV5K2R3elFvTXZJbTRqRmVTTThrWkhw?=
 =?utf-8?B?eWMzcnpKMFV4K3VQTVREMkI3M2NRaGJYaHhtYWZSdVhLZU1HZGxjVm9DMHlV?=
 =?utf-8?B?TjRySTRDUy81R1pteitHTVVYcVRZT3FvNHFQOWUvNzFBWnFnSFBLeFVxczc2?=
 =?utf-8?B?b3NONzR4UGN3SlloTlJlQXhUQ1BNVVNMRE9SSXZ2ZkZ1N3dnM1ZnRmhmLy8r?=
 =?utf-8?B?WGlWQ2tMcTlPdlhuSHhOcVpTazRUWHFVeFRLVThRRHJTUnJwSmYvYnM3dnBD?=
 =?utf-8?B?TWNSRmYreTZ3dExldjRLaURYMCtldlhnc1F5WTVQdmYyVzNrYzhHUTZMeVBr?=
 =?utf-8?B?YllFN3JCUkF3Z0hQWVh5bUJIT2VuYWxRTFlUMG5ZOFVYWGhnMUFZTHJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajY0czlyWmFtbjBwYjlscWhMRGFTRWR2NUN0T0F1VHZKT1U5c3ZmaTFrbndM?=
 =?utf-8?B?VmR5cmdMWWlFWmcrUTZldUhaUm5RWkJkZ0cvYXVtUFRtYUhSbEFmRy9KQ1dm?=
 =?utf-8?B?L3hsQUJEL3VodTNmUGNwQTdMT2J2cWlhc2tqWGw3SWNBSVZHcTRFRytlRUo2?=
 =?utf-8?B?ZHNOQUZuREZHcEFYRVdQbzJ6eHVWWENPWlpKakZ2dlFqZUZvemFGbjNTK3Bi?=
 =?utf-8?B?ZytSWHFqM0JDZ0htNTZkQ0RvZGFGQVhXWHVpYmFmOTJVRDRuRlVjdngwSFpM?=
 =?utf-8?B?dHVwVVFqNDJoaU50bDB5UHZUMzFEVy95U3lMTVdaRlppcDUzS2x0dWFhRVJQ?=
 =?utf-8?B?aFJ2RGF1NDhudlA2MFRlbDFUZGxHMXBFYjBSc1FHUlZma3l2c1dVYnFpalZu?=
 =?utf-8?B?VTRqVktaWXJMTmxMRXVKbnBrb3hNenZQbDIybWNJb25uUmZCeGJkRnV4QnNx?=
 =?utf-8?B?VDZXNi9rRVM3YUJCQ1kxbWN1MFMrVFROYUFzZ0xSZUVTV2hLbVdPM09rc0x1?=
 =?utf-8?B?TjNCNjJVcWtKa2RPTGZkTjZOOEk4RmsvVkFPbkxCa1lhdTZ6cXA3QTFvdjRw?=
 =?utf-8?B?V1YyNVg0Wkd6MGJPRFNpTzNaSmRzSmFRdi9CbGRzbkJxaGZaenpuc0E1UnEw?=
 =?utf-8?B?M0dHb01FSGNwQjJnQ0JSL1FjcE8wS1VSd3kvYm13VnZTa05XSW16Tmk1eERK?=
 =?utf-8?B?OERSRkxRTFNMNTdNcnkwTnhtbGh6Wk05NkJZVlI2RGNzY25XcnptVDdZMFJz?=
 =?utf-8?B?UXVIc21UczlXUG1VbWNUTG1tYk4xUzhOUUNFQWx6a3BuYjBaRmh3TjNZbVhR?=
 =?utf-8?B?S1RRQTV0TTZJaWxuRW1XZ0g1ZXhET1ZKNU9rSWR0V3FwWTFISmNhdGdyMWxl?=
 =?utf-8?B?dHNhRmVJOXo0RERzajU5S0FHeWFBRFczU3hwRlZiQlBOVUNWRFhoRkNMR3Fq?=
 =?utf-8?B?NG5UUVVZelN6RHhVV1V5MmkzbTl6N3NLTGJITkNHRnU5NGZhTDRjcmoyT3Ny?=
 =?utf-8?B?NHJmWGFMQlBQYUhrbzAxSmJ5ODFjWE1tS3o0ZmxlWUphQitvTGo3VzJacFEr?=
 =?utf-8?B?dThaVCt4cHlOR3A5SU9pVGpVWGJ0RUl3a1hQVTlqOVRHTWhpYVE2anJzL2V4?=
 =?utf-8?B?L3lLN3lyamw0aEZVSHlMbGVFa1JZZGZCUTVMbWtRRnNNMlJmNzIrUG8rT1F6?=
 =?utf-8?B?YnNtWWRVLzZXWjFqYTVMcnhWYVZxL0xUcG9zTzhQVmVLK0ZSKzJRUGk4V010?=
 =?utf-8?B?cnE0VTRvcTgyeko1MmRMNHJjN1J2MkkydVpveEpPbG9Bc29qUy9pU2haSExI?=
 =?utf-8?B?TzlLd0ZiOHRvdXlqWUczSXlOSGxrRENrWDRhemoyRVNrQTgxVmVJcVJPVS9a?=
 =?utf-8?B?bzJhNXE2WWEvUnI2N1BtZTl1V1VwK25VVXdUS1BTMWJHS1hJK3l6Q0JEMlM3?=
 =?utf-8?B?cHdYRlUwMHBUUmZ0VVBibkhpY3cyQ2psczdJKzJ0VDM0Wm1JemFMR3d2Rk41?=
 =?utf-8?B?S0lIRVdvRGtjUHZkMFhBMnVCN2RGb2VNTVNpcHN5S1A4aytoY01LWmd2c3cv?=
 =?utf-8?B?VE9XNExVM295a25vS25CYll5U2k1eVJKL0wxRHRVY1hTZTB5dkliNDFMNy84?=
 =?utf-8?B?S2RLTFRiUkVHYzNmdXV4TmNDbmZCY3B0UEF5cjhiUzFMR2FjZnpmazc1RVBS?=
 =?utf-8?B?Z2I5N0pJTEY1SXVzanZiaG5mU1ZVYW1zTlB5OTlZaHN2amlObEJLVnpybjFp?=
 =?utf-8?B?VDRlT0dvZ2Uxd2V1TUYyTjZrem5JSURESlBCQ2x0SWdqdXc2OEJNWUZGcEJL?=
 =?utf-8?B?Sjd6QjdIUERpS2RwdjlCZm9STGZHZ0VzSkNSRWIySnVSMk9KeXdaZkIxRGp4?=
 =?utf-8?B?d2U0VERRd1MrZWJ3dTVyMjdURUlPdGhJWmY0U1I2MkdVeHpIanJ4SEt0SktT?=
 =?utf-8?B?TWNBSkR3UmMvVVhKQzVXclZVL1BaV245b1ZHUEY5QnhKdGRwVDlvTGgrSHBY?=
 =?utf-8?B?R29HR0w3TGdsLzQwcDBtSTBBUDRnVHc3NUhYc21DQWFST2VPSkRMaTJibkxx?=
 =?utf-8?B?RFpvODNTeGpiVC9heksxZ1A5OXB2cUdNbFFJVWlBY2tQSzk5bGhzQ2orajhk?=
 =?utf-8?Q?EXscGkrlBofur9bzDsoThU4Sx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55b26c7-ab8c-4982-2918-08dc74ad24c4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 07:03:37.8384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1468rscFhPaMIA/7r5g4mqTX7HjQPfh7svZfSWuOjdeVtWbUHMqafA8J/LZJ/9B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755
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

<ping>

On 5/14/2024 4:35 PM, Lijo Lazar wrote:
> This series adds APIs to get the supported PM policies and also set them. A PM
> policy type is a predefined policy type supported by an SOC and each policy may
> define two or more levels to choose from. A user can select the appropriate
> level through amdgpu_dpm_set_pm_policy() or through sysfs node pm_policy. Based
> on the specific PM functional area, multiple PM policies may be defined for an
> SOC For ex: a policy may be defined to set the right setting for XGMI per link
> power down feature and another may be defined to select the SOC Pstate
> preferences.
>  
> Presently, XGMI PLPD and SOC Pstate policy types are supported. It also removes
> the legacy sysfs interface to set XGMI PLPD as it is not used any client like
> SMI tool.
> 
> v2:
>  Add NULL checks to avoid access on SOCs which don't support any policy.
> 
> v3:
>  Rebase and add documentation patch
> 
> v4:
>  Use consistent policy type naming for read/write (Alex Deucher)
> 
> Lijo Lazar (10):
>   drm/amd/pm: Add support for DPM policies
>   drm/amd/pm: Update PMFW messages for SMUv13.0.6
>   drm/amd/pm: Add support to select pstate policy
>   drm/amd/pm: Add xgmi plpd policy to pm_policy
>   drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
>   drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
>   drm/amd/pm: Add xgmi plpd to arcturus pm_policy
>   drm/amd/pm: Remove legacy interface for xgmi plpd
>   drm/amd/pm: Remove unused interface to set plpd
>   Documentation/amdgpu: Add PM policy documentation
> 
>  Documentation/gpu/amdgpu/thermal.rst          |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  32 ++--
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 136 ++++++++++++----
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   9 +-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 113 +++++++++++--
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  40 ++++-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 +++++---
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  59 ++++---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 +++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
>  17 files changed, 533 insertions(+), 169 deletions(-)
> 
