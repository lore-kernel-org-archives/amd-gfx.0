Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB98CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 16:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9A210E037;
	Thu,  6 Nov 2025 16:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4aBiU80T";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47CC10E037
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 16:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaWJBK7L81eGnWTqNdRI+RFsTO1zyGeo1mjMoSlS5MA9rgNs8vLDPc1SR7bFwI8ds+3ezfAnF1+rZaHo/3rdWowD7Ku6j6nS8bntgYPdRtRRdZKk13Wx1ZHaEVN2pOz684srOWL4qx7E4CncwChAlWSby4kkwqKU75C6+30lsthbQxfZMxRQF10AAm0nq92KaJw/dzJlKPzC12cFmDZwXHbFR9K+xFtpi0xfRjT+tqiZ2YqofsZf3DJEsSGxbqjYmBpM95v2f28y6G5xA/7ONAVhuVgwrZ/fnon6T0NsmnliNGIlTAGDgGqHYS+HDJEBzbrkAU9azdpalki9Dbr/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p60/zl0cZWDMuIILaQlGgA26lXN+UnafcrO1x8uupQw=;
 b=Txpg9FNIsbvijOWLAEY7dxkYCDQ719+nhwuB9tlM3S/HGLr4q/HJ1ZyZAwvRBZyLyvIwaJaxW3SaS4kL1XCC7BjeO4OHVYU89paxiDGYqtsZnjVvBRrR7YgI4TmRUKG+kp8zQvZAAbFOSu9g01ebJzHJ1jFJ/GouC+yukJdKD27Za6O8yLjb+A9dNPSwYkd4PjYk2t1h6y26rdQf1f04oVuh4JJCcLxnl3J3LHf7WCcW7Be+8tOaiHb7k3267kutC183p+75gVQ3cileF8yBjlF9UcOkYu0oJ9egfqxnnvWyy46cpUKF//iXGVPwArCVdoM1pcCGZU2tjWdIRGPbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p60/zl0cZWDMuIILaQlGgA26lXN+UnafcrO1x8uupQw=;
 b=4aBiU80TnkwsqsA+L2kaJlIG86amIlWmwLiSdBhn2RI3HAvO7WeEen6UGg74oFIlr4Ki+vkwJOQiwk3l1CFmB07Rlpg0O3snuCFKnpj7CYQSja8TtG3QxIS7qoJmeao99HXVG94Q21hWe/ZvgCgCdJ8ZXKF72q4wAm2SO4Q3m/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB999104.namprd12.prod.outlook.com (2603:10b6:8:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 16:12:37 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:12:37 +0000
Message-ID: <6c64f5e6-e69e-4d14-9262-17b27112ed7e@amd.com>
Date: Thu, 6 Nov 2025 21:42:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amd/pm: Expose ppt1 limit for gc_v9_5_0
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251106153328.3783505-1-asad.kamal@amd.com>
 <20251106153328.3783505-3-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251106153328.3783505-3-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0054.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB999104:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d2b38-44b2-411c-266e-08de1d4f4d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z25rNk01b3lQM1cxY1U0amNrZ2w1UE9BVlZ2bXlwWnpONnphMnBQMzk1dTYx?=
 =?utf-8?B?Y0c3Zks2SkhFREQwb3k3K2pUbms2M0RiMm1YbU40SzJnNS9xYUJIVStHMENS?=
 =?utf-8?B?MVc2YitWeXcvVFloZWlMZVg5MnltaExKd2JkNEF2YjY0ZEd3WHFsdUFlbGxJ?=
 =?utf-8?B?R0k2MWNqL0hGaFY2eExkSGJNOHJHaVpDTjRBS0FHUkptLzIxN3h5SkVUcVFP?=
 =?utf-8?B?ZC9WTVAwRHdYeTNic09hbk9IV05DaWhEQnUzb2ZtTkJ1QTZDdkg4V1czMkVm?=
 =?utf-8?B?TjE2N3FNYnF3YnAyU3M5REpCV2pibWM3ZWgvR0VnSWtrQk1WQzUvN21pYTVw?=
 =?utf-8?B?dE9NOFo1Q3lCMzBrMnRlOWlGSERhYitVNWllV1R1TlVaMDkvNXNrMGRtWElh?=
 =?utf-8?B?YlBGWnB5enp0clF4THVmWElCc3JBVjAyY2xVMXRCZnVOaGRrR21RR2dDdFlW?=
 =?utf-8?B?SjdNM0ZiK1VUV1pKS1ZHOTNuNmVCd3c1dHNjbU9GV2c4NUR5a0ZzcFhaK0pE?=
 =?utf-8?B?TFkwcG9zakxSR0FVSGRlTWhXYUJNNFhYN3VyODlIenhKYnJiclhlQlU0Y1Ni?=
 =?utf-8?B?QWFPUG9TSlBSVENiWUQ2ekw3aUpETEMrSkJoV3I5My8wRTdqdXJRZVVpT1dW?=
 =?utf-8?B?S2kzN0RoL2FGSWo1ajhyNFFGa2ovY1MvdkVNS2hsQmF5YWVjOFdVQmk0cjFD?=
 =?utf-8?B?dXVmKzFTbUZxQXYyamFrS0JYall4NG1wWkdyVXUyVHJRN0JNSWNqTjVnU1Zj?=
 =?utf-8?B?VEJkNDFqbFBpa05yMGZmYkhQT3hCTGFvcDZkYTFqekFXMEJMSHdLL1ZpTEFH?=
 =?utf-8?B?dklKTnBaSjkzOVZSM0diQkFCaWtwb0lXOHl3MWpGOWNNSS83Wm9aa212cDZU?=
 =?utf-8?B?ZXl3UEpXWXhpbTVRd2RhbFBPZDZ0VnIvMDBRMDE0ZkpXdk9jSTZBN3ZsQnp2?=
 =?utf-8?B?ODg4c25oSlFkZ1EwbWtOTmJhbG1USU84aE1BYmNxVkhjcWFYUTdORElDRDk2?=
 =?utf-8?B?TDlMVC8vRXhkNGtoQWVzN3lxdlk1TGF2RWFNMkZmbWIzZTF0Ulo0ZmVwKy9r?=
 =?utf-8?B?a3c0NTFkek9XU1hiZHFPdGtUSml6cC9LM0RWMDNuZ2hyUVEvbWVEbjNjWkt3?=
 =?utf-8?B?aFE1RmorZUZnVTQzcnRsQzF2Sm9iZ0JQVHNGVU9neFFjS2Y2dzhhWHV3N05X?=
 =?utf-8?B?TnNzakJ1OUZjV2NtZ1lBdmVNZVBrdWFnTHUrQXAwcHpnNGhsNzhCajNySUNr?=
 =?utf-8?B?Q0VjL0QwMkJHY1FLbGFab0E1NDlOSFpPRHhsZ2dYWmVWKzhoZ2o4YnpjSEx0?=
 =?utf-8?B?Y0k3UU9sU2lrVEo3Q3ZJQ2hxU0hSRGtSQXJIVXpVWTJ1THB1bERoM3BCR0RL?=
 =?utf-8?B?TERIYURYdzFmYWpZM3phYVErczh6T2lWRnNMMTFyZGRINThFVEdheXZxSmUr?=
 =?utf-8?B?eWtxM2tGOUZtanZ0Qll6RUx5VTJ4VjBhcTZKSnNJeEgyRXNqRFo0TEpnQlBS?=
 =?utf-8?B?cjdPTVNpSzh6S1dRamEvZlBDRUtWNWNKM1IxeEJYY2tXRDlmY3BLcGdnOGFt?=
 =?utf-8?B?dTVIRmswSVBWTFlWODVJNUcrVy8xTnBiTlA0RUNRTkdtUitocEpna2F5emU1?=
 =?utf-8?B?TFVXR2pHWkxhb1RTL3I2ZE12UU9SbWpTTTdxSEVwdHJ0NEdsSkhSNE9mbnE2?=
 =?utf-8?B?VHBZeXpJdlR3eEo2eEJEWW9WNTFCbS9aZnAvM2RsMUFsR016K0RpY1JHcllq?=
 =?utf-8?B?K3RpMnFQUkFXRlhVQmorbWc4Wkc3cGpvS0pHTW5tRDR6VHN4Q3poNHc2TmZ3?=
 =?utf-8?B?WGlocTNaUDhsd00vM0hLLzVVK0NzdWhKVFdtNC94WW95ajdnQ3lCQmxnWFpT?=
 =?utf-8?B?Q1JLRGROb1RWOVdRemViUzJxenl3K1p3N1B0ZVF2OG0vMHcwTkZQRS9yRUNF?=
 =?utf-8?Q?/XAyN0HDd5bmD5as4DBVYkB+SxRkZKUL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFMwM0pncGJEQUZ1VS92UXFjQ2twTS9pTXNmSnByQUV0WU15QlRxMUZKWXlP?=
 =?utf-8?B?YkZkOFNoR0UwRUlpdlZUQ2t3cllWMmRsa1N5ZUp6Um9OOGhPOGhHMjZGUXNS?=
 =?utf-8?B?ZlEzcHhyVmZMdXlFbFA4REtTVHJpRzFkZVVtL3lNTDNsUHNjT0p5eWVrd05O?=
 =?utf-8?B?bGFZWjN0UVhZcWFXZ3I0dW4vWkdSa2IzSlM3UFhkdzQ4dENyQXpxNnBQcHBr?=
 =?utf-8?B?ZHQrZHFqYXdGOGtQQjA1WjUzeGhsV0w1SEZ3TDZ0SkdFbjZGNlhSMjFTU3hj?=
 =?utf-8?B?YVdiZ0l1WGJhWWsyWnNsSVJGVnF0TW5wMXNuUENNbWJ4ekNzUGV0QzJDSWti?=
 =?utf-8?B?eHhabnpDNmpPTVdPZE5FVUlLcVNBd3JIeVZRb1lYbElJY0ZlU05BMkpxYWY4?=
 =?utf-8?B?aFFSait0VEY2dXpHZDlQT2JpMzcyZGxvd01IUysveitYZjlMUXFQNDlPMUlG?=
 =?utf-8?B?eXFhSmhwQnVNSnlxc0ltb1lGQk14K25TSWtSWUN1aHZSc1VLMU4ya0FzWUo3?=
 =?utf-8?B?cEhXd3BVbk0wV05lcEFTR2FqYjlzOTBzTENzZ3pQNUZsSE56Mk1yK1p4aStN?=
 =?utf-8?B?di9MdUM5SzVSM2lwVnV5Z3h2WGorVWJlaExVSk5XUVFXTEl1WDdybVZkbWNV?=
 =?utf-8?B?WlBRemZhOWZFem82elBBQVlVZXl5OWdWRHRoNU0vVzBneVBvSVE2RGZVTEZU?=
 =?utf-8?B?SXlxOTE0NXNxcDg2UXEva3VwekJnQlBiZ251TXA4MTBEMGxvYmJCVE96cFM1?=
 =?utf-8?B?b0s2RlVQcHBaMkVpa041cFVVc2pHT1lST2FPM3NSSDJDa2YzYUNqejRPaC9Y?=
 =?utf-8?B?cVBJM1RJY2VRcjZwYk56MDRnYkthRjZUZDIyT0pBU01FUzBDcVdlZWtKelp4?=
 =?utf-8?B?bjczMmg5cGtHbDRsWFQxMU5JVTEvN3JpN01vRzdqNzNLUURZSlNOWnpLemxU?=
 =?utf-8?B?cmpuK1pFTlRBcTkydVVDY3RjUStSQmo5U2xpQlhnRmxaT2VrZ056QWpHdFJ2?=
 =?utf-8?B?RHBRYlVHdnlJWjA2K2ZKK0JLMnM2eER2aERrUVlEclRObjQ4ZWNtb0VvYXBz?=
 =?utf-8?B?ZzYyajlmR2N1UnJUWlUvWmN4WlZoN0VySkcvQ2h0TFROL3BFeVpoZUZrWTYr?=
 =?utf-8?B?ekNmMWM0QkhTSmJlMGJZSHI2ZG5SdGNBQTZFTVdpek03NW9JV2tUZ1dTQWVD?=
 =?utf-8?B?alZtMVhWakhINUNEK3JnTEk3ODMzNmloRWgwZlhoWWtZL1poVkFYN2s1cHFS?=
 =?utf-8?B?Z0JlbDloeHVjWVpyOUdzZ1Q5dXlER3F5T00rUHRKSktvV1FqWHE2L2xDamUz?=
 =?utf-8?B?S2c2ZFFGVHhzWjd6WnNES3ZoRTVxV0Y1TG8xZEtxdTZkR29yVEh3ZUIwMFZH?=
 =?utf-8?B?RU40NFJXb25RWkRNUE9IWGN6VG91VktKb041dXhNb0duMW5wZTdzVEMzcnZQ?=
 =?utf-8?B?S2UvVFhyZFBKWGptazhNSTBrMi9idS9ZUU82RGFKU0JEemFmVjh4NTMrZ29m?=
 =?utf-8?B?RUl6dXFsb3N5VXlVZHZzQ0QyUkExUVB3TThGTUJ1NUV6UmUzc1pWQStLaDRw?=
 =?utf-8?B?OXpZZzE2SGxYVE1mRVdmSFp5d0l6UGI1ZTBqaExYM3QzbDF4d3pMYmVJSlZ0?=
 =?utf-8?B?ZHBtSWpPaDdiY2VLMWh2L0VBZUdxTStZU25ZQnlkMU9zWGV6RExrc2ZzVWJk?=
 =?utf-8?B?QWFvTGVMM0syZk9DUjRiSCtuZmdqTlREUjhvZGRPRGNGTGdKejQxVTZGM3dF?=
 =?utf-8?B?dmVVWHF1MUViQ0lkQ0liNTRVMmluZlBtY1I2RElDeFlnUXNGOXFoVHQ4N2Jk?=
 =?utf-8?B?NFBjWkpKT0VxelFlRzJiQ01GOHRINis4SUVaRGlPQ01Dc1hBQVJFSWFoVWYx?=
 =?utf-8?B?VDhvZmxEdG03YWovNmEyODdjUFB6THFkY0Y0bVVXTTBaUWh6cHdORUxmOVlK?=
 =?utf-8?B?VVo2TGRBd0s1SVdwS2g2RVFpdlFDdGtMUmtRaWcxT3dsajZYdkQwUXVBUmZo?=
 =?utf-8?B?QTUvWUk5SzlZclN5UG9RejZaWWd0L0RhYzhUNnNIQ0R1aWhMbS9CRzdQZDM1?=
 =?utf-8?B?MDNtL1lwaithMmFEY1E0MmNreDlvakMraUJmK1pEUHRyaXNjVjVUdytNT2hj?=
 =?utf-8?Q?vObY0xTzD+sRtDBP18rCkaUYU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d2b38-44b2-411c-266e-08de1d4f4d58
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:12:37.1910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J4zVcvczEYvRcaiFRzV6uE4HRGDnEgmaLHpYgb02k+NpgEdw17T+8kwzBD/ZVQ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999104
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



On 11/6/2025 9:03 PM, Asad Kamal wrote:
> Expose power2_cap hwmon node for retrieving and configuring ppt1
> limit on supported boards for gc_v9_5_0
> 
> v2: Remove version check (Lijo)
> 
> v3: Remove power2_average (Lijo)

Sorry, this one needs to be a separate patch. I didn't mean to combine 
with this series.

Thanks,
Lijo
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 15 ++++++++-------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  2 ++
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 69aa8e22f103..d9e37fd6e186 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3373,7 +3373,9 @@ static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
>   				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
>   				  "fastPPT" : "slowPPT");
>   	else
> -		return sysfs_emit(buf, "PPT\n");
> +		return sysfs_emit(buf, "%s\n",
> +				  to_sensor_dev_attr(attr)->index == PP_PWR_TYPE_FAST ?
> +				  "PPT1" : "PPT");
>   }
>   
>   static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
> @@ -3578,7 +3580,6 @@ static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_m
>   static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
>   static SENSOR_DEVICE_ATTR(power1_cap_default, S_IRUGO, amdgpu_hwmon_show_power_cap_default, NULL, 0);
>   static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
> -static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
>   static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
> @@ -3627,7 +3628,6 @@ static struct attribute *hwmon_attributes[] = {
>   	&sensor_dev_attr_power1_cap.dev_attr.attr,
>   	&sensor_dev_attr_power1_cap_default.dev_attr.attr,
>   	&sensor_dev_attr_power1_label.dev_attr.attr,
> -	&sensor_dev_attr_power2_average.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
>   	&sensor_dev_attr_power2_cap.dev_attr.attr,
> @@ -3826,13 +3826,14 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   		return 0;
>   
>   	/* only Vangogh has fast PPT limit and power labels */
> -	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
> -	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
> +	if ((attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
> +	     attr == &sensor_dev_attr_power2_label.dev_attr.attr) &&
> +	     (amdgpu_dpm_get_power_limit(adev, &tmp,
> +					 PP_PWR_LIMIT_MAX,
> +					 PP_PWR_TYPE_FAST) == -EOPNOTSUPP))
>   		return 0;
>   
>   	return effective_mode;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index c0e7c45ac0e6..8b49fb86c77b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2938,6 +2938,8 @@ int smu_get_power_limit(void *handle,
>   	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
>   		if (smu->ppt_funcs->get_ppt_limit)
>   			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> +		else
> +			return -EOPNOTSUPP;
>   	} else {
>   		switch (limit_level) {
>   		case SMU_PPT_LIMIT_CURRENT:

