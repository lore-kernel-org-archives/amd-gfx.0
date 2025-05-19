Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACCC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CCC010E250;
	Mon, 19 May 2025 13:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EcShlYyR";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4845510E247
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPl+uB8srvj6VVNyqj5Tfe/V+5EFu7Lm7v3vCrsk7SITBXyv7cBiw5tC0jl4jHJybfetfqLaSK2EBh/T7hb7uOYa4ejbyDGo2Pf8x5V6HbnADNMzA3A7HIvXOLo6ly1XlL0fOJuAJionFHLPIg57nAFqEEWflQ6c99mKriK95Fvl/GsQ25pMDG7VaTN3f1iTI1FwISk2AS6bxUym+vhBiAh9WbF2n/1uoX7D/H7t7ibzn16FXckz9cAsAjzgRVxSJKNYHIAyO1MzDOPnsIulUAw0fgumcj7KwxFZO/szHwxeaCdyOQmF8YOxmanawy2bx5mA/u2jFWdUfsElv/r8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtGmw6YyohPF2L9ex8jqGJ/Krb32dTz5ZjYSm0dRON4=;
 b=evpoAMWM6N/5/KpAV0g+YRXcyDTFUxHrHcGoj/gdPv2NsmagvJcY1B6uvVoJEB0mY9k7dwq4OuPe4xXk3JBKoDTQVQFWaAJErUwD5E7FNZKL3k6WXIF+7ydhXqBS9p+A3OwcFgLNuSqJ0Z/hSpuD+bXHcgJzFB5eT5ERE1gkjza3p0kRr/w4WU43AWQ/vh8uvsq8q3LmDXEp4Qwc64PFgTcdT7ZZ2Rjq0bM2pmtLqQ3OXvru1Bd9HrlApCi9JW001wEiUlanJT+olLieoAgcaj6/ufG6ZDUNZ/lkrRDf7UkbG2bby3sx9jbk604k3yIJzAfr/FYGprH3aFg2Jp9mKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtGmw6YyohPF2L9ex8jqGJ/Krb32dTz5ZjYSm0dRON4=;
 b=EcShlYyRHTHr+hnzZA4g1IzY6FMy7PmZPw0+JbllBp7DKvGmnAr7dwJPwBXf8V+cF/muv+Ui0V1ThInp33nf4fLD/3k578tqK5KXJm7G0HZs+y5nMvCu9SaeAVva929g7YaiYbX9aEN/zy4jNCuvXbUetTMaZ6T+w8ShaSCKLwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 13:40:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 13:40:16 +0000
Message-ID: <94123faa-9801-4ba8-9f48-eb6f341f94a5@amd.com>
Date: Mon, 19 May 2025 15:40:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Refactor amdgpu_gem_va_ioctl for Handling
 Last Fence Update and Timeline Management v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250424032123.3888361-1-srinivasan.shanmugam@amd.com>
 <20250518060324.1384914-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250518060324.1384914-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1727c761-f192-4d36-b0be-08dd96dab051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2tqMXd4aUJqbGRPelZFVE94S0lxay9aZ1dUZ1ZyeTlhdWJvMDFGZWRQdkFq?=
 =?utf-8?B?bTEzTXlUQkhoOWZZVkZWd0dJRm4yUXlRV2FzNG0rWWxmcXB1VGlucjJZVm9X?=
 =?utf-8?B?NTFscVFGUjZpU25pL0F2Yi9NR3E5YXp1VnZvdXJYbkhsWXNHQzlUTExzZjZZ?=
 =?utf-8?B?YjljM29TakNpbktpczlTQzFmbXViaGVrY1VyRzFObGZvYWt6dWhHcGxGRkRN?=
 =?utf-8?B?Z1hWYjNTa1VLQXI4T1RXZWsxMzIrRk1BeWljSGFmNDFqRW1NVzMzWVNUM2hJ?=
 =?utf-8?B?OG1PM1NEUHJqZGt3eHk4Zlpxb2tUdnhwaW83S1MxK2xHUUFCVjZ2dzNENjhw?=
 =?utf-8?B?M296ZXYrRFBEbktzL3g2WTRqMThWdnhaem9PVFlwTEFxUEY5VTY0a1dXenVL?=
 =?utf-8?B?dmlOSlRLSmYxVHhXd3ZFbDFKYVR0dFJJQUZwMHZ0MUZHNExaOUR2RFpvR3Fq?=
 =?utf-8?B?WVpzV0NiYi9UK1MxK05ibXZha2Y2UFBjcFlodmJBSmtpTUJpenh0dy9IRTMx?=
 =?utf-8?B?R3ZGWS9zaWl5aytpRGdKcFF1a1dkam85T1R2K0huYjFteWhWVTNqMTJnT3M5?=
 =?utf-8?B?cGhJWlNzR3VBeWtXSjV5SmdyUGpwTGZqS2EzdHRvVFVoRC8yUXJYeTQrRVdp?=
 =?utf-8?B?SmdVMTNvclJCcnU5MXhEalNpRUtvUDZGTjhrMzc4RVJrWFBxRGFpWWtlNUMw?=
 =?utf-8?B?MU5RL1FHWDRkT2dxdTl3c1NVTWdsejNUNVNJcUhZZ21Rd1Y3clJTNit6WVlq?=
 =?utf-8?B?TExURDlrME5uWFhjSXI2Vk5xOXZxMW5rd0JWdGlrZTExMjBwNHZSaUhqaUxk?=
 =?utf-8?B?aUhmOHNNOXZYcVJCUUxaL1BoTEtKNWdjNnVvbllzcWpIYU96TnYremtjSVdZ?=
 =?utf-8?B?RVVNOC9KUmVVbDZHRjRJeldmT1FndDVZdFZQTWE4OWdIK1owMkRaWDJBVWZw?=
 =?utf-8?B?SkZEeS9scW5FOENUMXNxRkVLMDlwdG9mZlUwVi9SQjZuY2JVRkJYQVZuTTRw?=
 =?utf-8?B?SVJWZXZpUnp1NXFCemhBNm9Sbzh6TDR0TTFkdUpmSnA3Z1pvTXRSM2xhU01T?=
 =?utf-8?B?NEFhQzhuR09mUmtPUjBoZ29JTmVQNUJwSms0T2tPSU01bS9MekYyK2p3T3Rt?=
 =?utf-8?B?bDFBblNnZUtYcVkwbnFhRi9Zcmo4Q3FKZ1d4elpNazdVVk5FZ2k2SlV2dVpG?=
 =?utf-8?B?NmlQQkREWm81aWhqYytCVm1QN2cxTmpzckFwZ21YaEFtc2RCYURiU1g5SmpI?=
 =?utf-8?B?ZzBYell2UWp5THkvNEdMTW1IZHc1Uk1sU1ZSdzBGNXVHcWp3cGw5VHdFTUdV?=
 =?utf-8?B?WjdVSk9JaFlFNFNKWkZvdE9iSWJVTVBvQldIbTRvVjNKcGtGbjFyL2pzeWJi?=
 =?utf-8?B?eE9aTDU3R09kWkM3ZnJEYVZnRVArMHNsV1VrNCtlYjJhK3NkNUwzMmVYNlc4?=
 =?utf-8?B?Y0ZBNFR2MlFmejJTV0RJZ1VqZHFGTHBnNnJSdEVXZHM4aDFwU0wwNjBWUDV2?=
 =?utf-8?B?T1Z6Vlh1K0lNWjhyNGE3eitOMElBYW4xYy9aNTlncE1mSEpodk1HWDBpOEZQ?=
 =?utf-8?B?NEMzeHJxaldxV2lxZG9wT3JaK0lQWUx5OWR6WEIzN2lxaXNXYUx5NHNLbFl3?=
 =?utf-8?B?Wk9ySStwTFFveCtuQ2lGdUR3QlJPRExLREJOVHFDTlU0dlI0ZHVraWZ6Vm1q?=
 =?utf-8?B?eGoyaHovRk1adVN4QkFaTkYrRS8yUVhrS1B2bEZsT01nMTdJVmxaK2hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FtR0NkbEU3Qjkwb0xEUUZocXJoK055Q0o0SmhITU9vd1BGaWxBWCtYcTJB?=
 =?utf-8?B?Y3VQdllzRmFvazV6ckhKNVhDN3B6Q2phcnZxamNnM3h6cktaNjRqbDNCcHV6?=
 =?utf-8?B?VDFFR3F0NElCZFlsVlpPamx1N0Q4emc4djBLbDBwZ3pUdzExblJZQ3BXNGQr?=
 =?utf-8?B?YlhXZDlvOE1kK0p5V3NZdHpxOWtEN0d2eC9DSG1ReTF3MDFwakcwTlNjcXA2?=
 =?utf-8?B?NTZwUERWeXBJSE1rNkRtcXJQYWZXYkN1ZWkrZUxTLzVJNHRxQnIrNkxER2lC?=
 =?utf-8?B?NVJxeXBrVnNLdWtoa3ZmOVNFLzhhSXowaDBQM2hTazdpT1owQlB5Qlp4bTEv?=
 =?utf-8?B?SXI1Q0kvTUh3eEZGdGRSUGhhejlKMDNiTHMxL3YxcE9RdXNyTk9NYmJvUU1x?=
 =?utf-8?B?WmVCcUMzSFZWNWQ5djFYY3FSaTlBT2hZc3ZLSWFQeDljZDFnVzlvcEE1eDBV?=
 =?utf-8?B?cmc1cGJ1TU9ENXBDV0NuSU9FSDZzQ3JqZEZ6b0FObEFHekgrOC9CQk1IZVc4?=
 =?utf-8?B?R2ZTRkYyT2pDUUVLdTdQMWlmSEhEYjNIckx2R0p5MkpJWXBOMmc0ZzJJS0Zi?=
 =?utf-8?B?OVNHanM4WTFPSnFEOGlMdFNpdG1pVk1zNFI3TEFCNHhwVUFrSXJFRDhiNStR?=
 =?utf-8?B?aFpEN0ZEaVVxS3pxOE9vRzNPYTBUUDB3N3k3UStPWFhmckowalJWVUgvZUF6?=
 =?utf-8?B?alk4RVB6ZVF5SnlpWUE2a2crVXVKUmJCN3hMbXFDenFUTXdvR0pTenVQUEt2?=
 =?utf-8?B?Ym4zdjdFTGNVYWVFaUNqeG9WNmFJSFpaTzd2NGoyeHFsMHl5Z2Y1OFJxOUFh?=
 =?utf-8?B?SFJlajhtMjZvZElkOVUzRjFOM2hpY3FPMU0rSm9YcFA1T2pNQXJvaWI1L01y?=
 =?utf-8?B?dDJtdzJNMGNiaFlYa0V2WjV1SDZkSE1RbldER2loaktBRThxc21tMzZ5WDdU?=
 =?utf-8?B?RzBpUmtGZUcwSEMxSUc2U3VqczE0eTV6MGdVT24ydDVMUkFkU2hpQWJpUkxK?=
 =?utf-8?B?MklqYlBzeUhBcmV4WHhMc0xRU0VyMU51L0JFVlV6QW9Kb1VteUZ3S1JHRUJt?=
 =?utf-8?B?V1NaVklsNkNIOUVaTFBqM0NZTWVEcy94a3NCZ2Z1a0Fka2xoR2FwS2JGZEY2?=
 =?utf-8?B?Qm1Fa1VNU3FOVWZOUXlMbEVXbTdPWGg1WENoZ2hwYW9FV2plRXJFdGJBaWJD?=
 =?utf-8?B?QmFBZ0lZTHhqTGp0MnNlNk9pSyt5OTBVS2FuSnNVOThKZWFXZ1VWOVU0TFg2?=
 =?utf-8?B?TUdOQy9zVm9BWEluQ05RKytvN3htNWhvT21TdjJxOHBGK3FEVyt1MW1ZZ3Rr?=
 =?utf-8?B?Ni9XM0VES205NGFlbU54cTlSS3dTTmhsU1BzdzcyQ0hxdVVJNmN3dzZtc0Mw?=
 =?utf-8?B?U3cvRnBwakxucnhnMUhmNGpHRXY0dW0zR2FkVGt6ZGEzTlk3dURYa1ZyNTg2?=
 =?utf-8?B?OTdSaEkxdC9KN3psSGExTnpQWEl0Z2t0bElUOFhUUG9YU0dYWGordXdMa0ho?=
 =?utf-8?B?WlFSWllSNkhjUUdQd0UyN3FTR3hqcXVWRzhpdUFadWdxalNjTHlYOCtlTHdm?=
 =?utf-8?B?clhmMjhkQU1xREFSRlFyc1M0OVZIWEh3VFVFcU1vNFB1Vml1RHBFcEcxclFS?=
 =?utf-8?B?cEJadmcvL2ZLMFBXQm8vclV6dGZoUCtOdURSOXJEa1ZCUS9Vbjl4WkRYdFNu?=
 =?utf-8?B?ZmdtOGZaMDloYm8rVXE4RE1CRjIrSmNPU2c1RG8xSU5ORnZxbXFzcUI1U3VZ?=
 =?utf-8?B?djRzSjdOblAvN083bUN1M0c2V0pId1pMV0I0ZEhLQVFIc2VZbjJ2VXMrTVpk?=
 =?utf-8?B?d0c5bzNteU15akZaZXVQV0s1SlVlTWJWNHRNVXFxT0RHYXBjKzJMM3Vqc3Bt?=
 =?utf-8?B?K0NBN2w1cVZmcWtzWHdEL0VkTWdHQXpKOGNvdWdLMXhEV2FzYkF2YUtuSW1W?=
 =?utf-8?B?NWhvMGF3OVVUdzZ3TGIwcUorV05rTm9rOUJIaHFnbWNpNG5NSjd6SVFuV0lQ?=
 =?utf-8?B?enJZQ2tiYmh5YnFNcE5weDQ5TFpvQmlMTTM5cW9GOUlscUdJc1RaRUhKZlU4?=
 =?utf-8?B?UFlIbk9JaTdpWVVoTStsS1p6bjNmdG5HS1JnQ0JJSkp3MVJNRDV3RTZWV3lZ?=
 =?utf-8?Q?P8YA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1727c761-f192-4d36-b0be-08dd96dab051
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:40:16.3270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu4KCGUbQZWw9+hgvRvnvF0ZwfTNiFw89xEvQVpwcenAMSNq9h9I+5OkmNn3S/hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

On 5/18/25 08:03, Srinivasan Shanmugam wrote:
> This commit simplifies the amdgpu_gem_va_ioctl function, key updates
> include:
>  - Moved the logic for managing the last update fence directly into
>    amdgpu_gem_va_update_vm.
>  - Introduced checks for the timeline point to enable conditional
>    replacement or addition of fences.
> 
> v2: Addressed review comments from Christian.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 82 +++++++++----------------
>  1 file changed, 30 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 2c68118fe9fd..aea0c63e441a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -112,47 +112,6 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  	return 0;
>  }
>  
> -static void
> -amdgpu_gem_update_bo_mapping(struct drm_file *filp,
> -			     struct amdgpu_bo_va *bo_va,
> -			     uint32_t operation,
> -			     uint64_t point,
> -			     struct dma_fence *fence,
> -			     struct drm_syncobj *syncobj,
> -			     struct dma_fence_chain *chain)
> -{
> -	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
> -	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> -	struct amdgpu_vm *vm = &fpriv->vm;
> -	struct dma_fence *last_update;
> -
> -	if (!syncobj)
> -		return;
> -
> -	/* Find the last update fence */
> -	switch (operation) {
> -	case AMDGPU_VA_OP_MAP:
> -	case AMDGPU_VA_OP_REPLACE:
> -		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> -			last_update = vm->last_update;
> -		else
> -			last_update = bo_va->last_pt_update;
> -		break;
> -	case AMDGPU_VA_OP_UNMAP:
> -	case AMDGPU_VA_OP_CLEAR:
> -		last_update = fence;
> -		break;
> -	default:
> -		return;
> -	}
> -
> -	/* Add fence to timeline */
> -	if (!point)
> -		drm_syncobj_replace_fence(syncobj, last_update);
> -	else
> -		drm_syncobj_add_point(syncobj, chain, last_update, point);
> -}
> -
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> @@ -780,6 +739,12 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			goto error;
> +
> +		/* Set the last_update fence based on the operation */
> +		if (amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo))
> +			fence = vm->last_update; /* Use VM's last update fence */
> +		else
> +			fence = bo_va->last_pt_update; /* Use buffer object's last update fence */

The those are not very good comments. A comment should always explain why something is done and not what is done. Additional to that it makes the line to long.

I would just drop them.

>  	}
>  
>  	r = amdgpu_vm_update_pdes(adev, vm, false);
> @@ -845,6 +810,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	uint64_t vm_size;
>  	int r = 0;
>  
> +	/* Validate virtual address */
>  	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>  		dev_dbg(dev->dev,
>  			"va_address 0x%llx is in reserved area 0x%llx\n",
> @@ -878,6 +844,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		return -EINVAL;
>  	}
>  
> +	/* Operational check */
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  	case AMDGPU_VA_OP_UNMAP:
> @@ -901,6 +868,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		abo = NULL;
>  	}
>  
> +	/* Add input fence for synchronization */
>  	r = amdgpu_gem_add_input_fence(filp,
>  				       args->input_fence_syncobj_handles,
>  				       args->num_syncobj_handles);
> @@ -923,6 +891,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  			goto error;
>  	}
>  
> +	/* Find buffer object virtual address */
>  	if (abo) {
>  		bo_va = amdgpu_vm_bo_find(&fpriv->vm, abo);
>  		if (!bo_va) {
> @@ -935,6 +904,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		bo_va = NULL;
>  	}
>  
> +	/* Update timeline node for synchronization */

Same with those comments, write a bit why we do things and not what is done.

>  	r = amdgpu_gem_update_timeline_node(filp,
>  					    args->vm_timeline_syncobj_out,
>  					    args->vm_timeline_point,
> @@ -943,6 +913,10 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	if (r)
>  		goto error;
>  
> +	/* Call to update VM and retrieve the resulting fence */

That's a good comment.

Apart from the comments, the patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> +					args->operation);
> +
>  	switch (args->operation) {
>  	case AMDGPU_VA_OP_MAP:
>  		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
> @@ -968,19 +942,23 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	default:
>  		break;
>  	}
> +
>  	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
> -		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> -
> -		if (timeline_syncobj)
> -			amdgpu_gem_update_bo_mapping(filp, bo_va,
> -					     args->operation,
> -					     args->vm_timeline_point,
> -					     fence, timeline_syncobj,
> -					     timeline_chain);
> -		else
> +		if (timeline_syncobj) {
> +			if (!args->vm_timeline_point) {
> +				/* Replace the existing fence if point is not set */
> +				drm_syncobj_replace_fence(timeline_syncobj,
> +							  fence);
> +			} else {
> +				/* Add last update fence at a specific timeline point */
> +				drm_syncobj_add_point(timeline_syncobj,
> +						      timeline_chain,
> +						      fence,
> +						      args->vm_timeline_point);
> +			}
> +		} else {
>  			dma_fence_put(fence);
> -
> +		}
>  	}
>  
>  error:

