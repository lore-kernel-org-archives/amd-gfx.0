Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6120FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 08:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AE010E0F0;
	Wed,  5 Nov 2025 08:28:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QP3MqgyL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DD510E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 08:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0XY8JV0oGhygLNHzIEKSK3BpDOXzirEypfyvAeR4atGCKikY+dxtN5Um2BucxY7rgHKSBFA3yMNna55iLvcVKqHWHS+wYaA1WJfEjtWk0lNGpXT1KQxM6J5jzWNZ/IKPNXJ3+OaICwDmKv7zrpji7cMK8L4woL0bTagp33kMn0DLTX5RpSmV/7tGqJqHf/OzebmDlR+L0s2CzU55ffkbA0W2fVYYmH5aot1ED/2Iiq2fclBoAC6WY0MvNozurq0CfPxQaidRIfqPBfixAzeBSxd1QQ3WFfMykUybWlRDrCS40ZGq3mpSGHPbRqTht5SloyjaRDYaWx80l2Eegp8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k69X19TWxu9Xoozy0I825Q4KrFQkMy4IjBvfG3/C4K8=;
 b=wED/yLALreZrORsgeblBhHGzIdWpg8iJzT4Ec+F7/EIT2V272UVa71AMDjZ/fxanerLTF9r8zDWm2eGVdRW1eFSSHv5RUpSyt8C+KNF0IsODb8voozJCwsKkkxIffl2sPZhZAPgSC06kJ+/EVJP+mgh42tGorHc8mafXWHHl5zCWewiLwHnCfpgMV4v1lgsMlHU1g6y4DaM3v/yc9J9XmgpN5vgmB2akGNYnauL67rcUGgTrRkQZzVThqmJANh9Plw5TOVFF8r4ohlP5PL0edWsv72YuQ5/4LlE/wJtm26nRYT4OURk/+9jCAig8L4bBNhtHzZ9tDDynsCIkUPP23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k69X19TWxu9Xoozy0I825Q4KrFQkMy4IjBvfG3/C4K8=;
 b=QP3MqgyLtIsiXfIdDvGgQImRFfuwLIpmHemiWVCuCOPhYlSrVL+vQCsy1dwvfVSgRJKOCc8ZpDVPQ73vRvkNHYsw/LAZLOh9b4pQ9fof5E04+jylfzdVXBppvACmEZBaNWFwzn5zMJABjYV69LVnBAlxjHp21w6ban188XHFHPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999081.namprd12.prod.outlook.com (2603:10b6:8:2ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:28:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 08:28:43 +0000
Message-ID: <82d641b2-3941-4b3e-9fc6-b571f3f96b13@amd.com>
Date: Wed, 5 Nov 2025 09:28:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: add user queue vm identifier
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251105061630.4146604-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251105061630.4146604-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8bef36-0555-4046-58dc-08de1c455490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TW10R1FCSGlXdlZhbng1aXJWems0OTlFek54MFkvMVMxWWlZUStWeXh5R0pI?=
 =?utf-8?B?akdQcVN5OXgvcWd6MGRCbGtIcU55TFh5UHdOc3QwaHBBOWlSa2dJaDRpVUIx?=
 =?utf-8?B?ckJVbnZJRE9HdWlVV2lwY2JFeUdtckxUa1NJU05RUElQT3RycnZvR2ZiTWF1?=
 =?utf-8?B?K1NsWE5OQ0hSSXBFckZrMFNkMkZXQWhPeHc3WnlTcEk1UWFmR0ZiU0VKQWt6?=
 =?utf-8?B?OHZRcEpKZEg5V1ErSmtsSFhBV09za2NjMXNPNXFtNEQ2eW54MkhRUmNPNFVx?=
 =?utf-8?B?bVpOQjBnRGVZazVBeklDbUEwY0tXQ0tKZEdpZ3RFWWkxU3prdnMvUmVacEJR?=
 =?utf-8?B?OE90VzFhYTFSSW0rSXFsT1I3UU1LcGM1bnhiUjJQR0tZeHNvSTVZQ3lBUzNB?=
 =?utf-8?B?bUFmajBpNVNuaTZUUTBGcWdrbGtwNXRBQjIyWWhta2QxcEZpZG5VbzVnVEE3?=
 =?utf-8?B?VWtnYURRUnFwcjRrdmo4QVlINFVMWi9OQVVRQ296N1RVQU00QjhBZmRIeEhx?=
 =?utf-8?B?TjltVUszQ1AxQ2tHbm1TTENmZmJuSnU3VGlLRUNkZ1dac25paUtvdnN5Wkc0?=
 =?utf-8?B?N3QwaWdwVUg5cHFzLzZzRmpxRVVxWFVJVGYyNG8rRkZoOHUxMFU4UlE0MWVX?=
 =?utf-8?B?bW0xSEI3VUhSNW9lQmh6eEc5WmJWSk81QnNRN29HL3A5MDVKcnBjSnRJUGxO?=
 =?utf-8?B?Ny9rRktjNjBoQkdtQmxZRWRjNDlkcjRYQ3hyblhXNDhYYXBIN01RSlBSdG8v?=
 =?utf-8?B?S3lMeDRsM1lsZFBQWGpXTkx6dkNzbFkyWUZzK2tRUEtkYTVzcHAxZkJlYXRU?=
 =?utf-8?B?NVEyTXNyQ3ZHMUlBY3V0RFVranZWckxqbEFOd29PZ1U0Nkp5VEZSajFnb1ZD?=
 =?utf-8?B?TDNwdDcrWFBnZUs1dVI1dXl5M0hQM0ZXaVdsayswQ01uVjRNdzVQL3JDeUQy?=
 =?utf-8?B?RVU2Vzc1M0tkRUpWeVUvWkIxOEZRTHlKTmh1ZzRLWEgyMnkrQkJtY2Q0RU1W?=
 =?utf-8?B?Zld3Y2pIdFNsajRHR3BOZUpWdlJabHYyTFludmQxYW5uMStCRTRyMUI4SWpK?=
 =?utf-8?B?c3NlRHk1dE90QnF6T3V6S0hJMFpjbEs5MWZTa1ErVUtvTUxQOUhCendXaUpt?=
 =?utf-8?B?aEJBUWZGRDNVNlJNNDVidll5TEpaLzVyUWNkcWRucklIV1IyZ2tEczBWeGJD?=
 =?utf-8?B?VzVvQnJpODRjTWc4U0NUTW1OS25mUCtSRnVSeXI0eHlXUStSU0R0cHBrVFJE?=
 =?utf-8?B?RXFXZGdyYU5XdWMrRUY1SlEra25HRm02WlpmOFZhd0NBaHdOcVNmZ2Nlb1Q5?=
 =?utf-8?B?Z1A0bVlKRVNhcHZhTWlWUnlNSEJVK1VzZC9IeTV3eVhTY09HaEJpMDJaZXE5?=
 =?utf-8?B?OEFZNzZpOTFEMlNjbG91ekdaNmMyYVlqdEZscTdIc1MxaEhvZURuTHU3bVpI?=
 =?utf-8?B?dlNjSEtjdG1zaCttcVkzY1JCTGtleWVZSjdzUGN2ZW8ycjVsalNCYndFNE4w?=
 =?utf-8?B?M1VJeEQ5MC85TUlKV1k4bUt2emhiMUpFSVVpUkhBMjBBVGZGdFplOWNSVWN1?=
 =?utf-8?B?Yy9KeVk3VWJQWVRHN3dzdG5kMStHbGNQRGFvclNYQlh1Vm5PM0Y4NkkyVGYr?=
 =?utf-8?B?dkJNVFJDUHF2S0NxV0VZbmpqb09hYkdLTFlpZGtqQkNqOVhyQzhOZXVBazQv?=
 =?utf-8?B?MDVNV1J6ZEM1YnBzUmwxdVpQbE9mR3h6SW4xRzdLcG9YcVorQWNoNlN0bnJv?=
 =?utf-8?B?TTgxUTlTcE4vQWp0YzFLNlZBYmwzc2xyZlRYVm0zWFA1ekM0ZWJPWE9sY25F?=
 =?utf-8?B?aWlVenZJV2RwajZlWVMzKzBxZFhFNDlCcVRWeWViMWVWQmJISC8rWWFDclJw?=
 =?utf-8?B?S09DT3lLMUxRTm1xclJaYjhUV0FNTVltUmNwTlNEMjhPSTVwR3R1ZlBTa3Nu?=
 =?utf-8?Q?gKSMyrfgwxlLmLyMQTtcWv7cbWQO2i0M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hWQkljOEVHSzZtWk9RKzVUbm5LY2U1cjJZc3l4ZFlXYTc5QUl4TUYzemdt?=
 =?utf-8?B?SjkyalowLzloalRJNGRQNHp6MllvbTRjRHBxT0tQWnJXVzJRRVdhYm1pY0o2?=
 =?utf-8?B?czk0ZzQ4SS9tRHZBQUg1WFh0Q1hpQ2x4UUF1YVpWeXFpMCsySWV3Z3pQRUdP?=
 =?utf-8?B?ekdJM3lKUjZGVmRCUnZXOTFneEhMWG93SDd0cWgrR1lJOVE0N0l5Ymo4QUow?=
 =?utf-8?B?bVpuM3dPZEoxU1o1VitLZW1CQTFVeElqNzZFS1dadGZYczZWcUZZbXVQVDBt?=
 =?utf-8?B?Um84aEo4dGNzZ01KVE51NDhKSWFWMXNhblBnUXUvaEszYlFaYU50SWxUZXox?=
 =?utf-8?B?VzVrMmZZNG5laThrMFhRZnJSYzBGbHBIZGhMZmNINlJ5dU9VQ3V3VnVQRzRy?=
 =?utf-8?B?RkEvZEFOTkNUc3diQ1BZYU93UDBnRS90ckhZTUl6eTVrUVF4bVpGNzNOazhj?=
 =?utf-8?B?c2ZRclJzRHFHc2s5Tm8vSVNVcHN2SUVZd2s0MVRiOS9IakFLRTJlc2grUWcz?=
 =?utf-8?B?RVk0ODA4ZmNQSHZIM2FvUzRSdGZaVG50OG1IemEraGE0WjIyc2pjUnM1dlhC?=
 =?utf-8?B?WEZmYy9Zc3FjWWo4L1p4bnNBQmJ1S3h6WWFqK05LWnZGKzhHOUFFckQySjVw?=
 =?utf-8?B?NWo3eUJwOEI1MWhQcS9XYVpwQVM3VlljWFhzQ05SUk1Uek9kWnVEMm42NEw1?=
 =?utf-8?B?M2QvaHlhNmM2azUyb1ZqM29hMVprM0FCMkIveUJqcFNmbHNTbDVHRFppazNL?=
 =?utf-8?B?Z1ZTWW1HVk5heE14bjlXbkZEb1YvcHR3RTZoODVsWkM5YVRITmFQZkdDNXBp?=
 =?utf-8?B?UnJBOWplbGlxZGJtc1dYd1ZpM0tiQ3oyNmYyc0lJL29obE5MRTdFRkdTL1gx?=
 =?utf-8?B?Z2Y5WDdHaFpFUDIyMDVLRjRxMnR2eGlvNFlvbVNCalBNeW1uUzhkU3lrTVU2?=
 =?utf-8?B?blVZa3N1MWJGTWphSUlrU1hhMkpmZUN1YU5SNFBLMG4rOFZBcFVCU2pnS3Jq?=
 =?utf-8?B?NnlybmR4TEcrMVRTWFVLWHdxMCtNa29PbUJsdk9BSXc2UEVEWHFkcjdBQjJP?=
 =?utf-8?B?cEJsZEpERHovK2cza3ZYZDg0VjBkbmZqMi9Bb3MzbFVzUVMzcUdiRnFxUXQ5?=
 =?utf-8?B?R0dCVjM1OERQY1pjVDlxZlhJdnltQURDUWpibVlNTC9UNVBzejBkdVBGL05t?=
 =?utf-8?B?OUtTVU1Fa2JIaSt1N0VDUVVjMEw1cmtXeS9mV0dLRG93c3l2RnFEdkM4VWR1?=
 =?utf-8?B?Q3lJb2RpR3ltcVJ2V2hPMUROSlJ3YmZBWXpFMVVBSlo5dlpQajQyaGMzZHZW?=
 =?utf-8?B?Sm4xeTZPc2ZYSlpYQTVNQkZ5UmFnaVZnTGQwNlNDcDJnZ1ZabDJXMmxKV3Zu?=
 =?utf-8?B?a1F5MUVFUXJxQTkrb3pkMEdDamFJRjBOL2pLcDNNaWZvQ0VzL0RYMXdQc2Nu?=
 =?utf-8?B?dVRKdlJCbEFjOXNZTVYreElMcXB6S3Q2ZHlodDV4S0FlcG9uUnArRzVVbEpT?=
 =?utf-8?B?RlVCV01lM2ExQUwwdk5vSnJ1NUpFUzVnWTRyRHFTMzBuZHlpNXVRL1M1KzFJ?=
 =?utf-8?B?TjFmdGhKMGpjQ0JiVXNCbWh1V2Jwc2NTV1phaEJoNVBJOWhvb2hXRS9QR1FE?=
 =?utf-8?B?Q1Fja29RNm01NmxGRyt3cVVLYlBKcWxsb3dlZnh1M3ZIUTdvZjE5TWdVNlk4?=
 =?utf-8?B?VkV6aUF2NDVRcGIvMXdFN3lRakloRjdQMWVIWDRUbE9ZaFZPaytYYzJINnBS?=
 =?utf-8?B?M0I3cGV0elM0NXIzVm45dmdRTUxyek9CRU1ReE8xcU1PaEhFeXpHS2FGM1Rw?=
 =?utf-8?B?OXZtTjk3alcxQk5GbWIxeTBSeTNMbm5kbHRFa2dueXRENm8weVlBd0RKdWpy?=
 =?utf-8?B?OFlId1o2WjRWOE55Y0hHd0pjdWNQUkw5T3YrWDhRQk9CSDY0c1FDOFdCMzBs?=
 =?utf-8?B?NklBUEIxaU5hREtKV0ZtVVIxNVdVTUIxVGxhcTc4R2Z1N3NJclREWm1pZkpi?=
 =?utf-8?B?M2U3d2draXU2amMyeGFyVGp3dDVZTjN4UXFCRktkK0pGNG9ITzJTQ3N1STEw?=
 =?utf-8?B?Q1poRUFPdDNwSmJHNXpRNHYrMDNGeG1DeHVNaGlMdjhjZFFwUGZld1RWZ0Ji?=
 =?utf-8?Q?OZ46xt6t+Ylfigh8zYSqrsFx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8bef36-0555-4046-58dc-08de1c455490
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:28:43.3965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqK549Vn10sB+w9vypW4OrKS8fo+ndcpUYBd1DMOI4BHrxQLs4cmlB2xpN4hA55Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999081
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

On 11/5/25 07:16, Prike Liang wrote:
> Add a user queue vm identifier for each userqueue
> kms opt accessing.

Clear NAK to that approach, we don't want any specialized handling in the VM if userqueues are enabled.

Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8888be4e758c..a8bb3f1b8649 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1249,10 +1249,13 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>  			  struct amdgpu_device *adev)
>  {
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(userq_mgr);
> +
>  	mutex_init(&userq_mgr->userq_mutex);
>  	xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
>  	userq_mgr->adev = adev;
>  	userq_mgr->file = file_priv;
> +	fpriv->vm.is_userq_context = true;
>  
>  	INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_worker);
>  	return 0;
> @@ -1262,6 +1265,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  {
>  	struct amdgpu_usermode_queue *queue;
>  	unsigned long queue_id;
> +	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(userq_mgr);
>  
>  	cancel_delayed_work_sync(&userq_mgr->resume_work);
>  
> @@ -1276,6 +1280,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>  	xa_destroy(&userq_mgr->userq_mgr_xa);
>  	mutex_unlock(&userq_mgr->userq_mutex);
>  	mutex_destroy(&userq_mgr->userq_mutex);
> +	fpriv->vm.is_userq_context = false;
>  }
>  
>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db66b4232de0..48a64d828eb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2591,7 +2591,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
>  
>  	vm->is_compute_context = false;
> -
> +	vm->is_userq_context = false;
>  	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
>  				    AMDGPU_VM_USE_CPU_FOR_GFX);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 77207f4e448e..cbe7dfa4ffcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -439,7 +439,7 @@ struct amdgpu_vm {
>  	struct ttm_lru_bulk_move lru_bulk_move;
>  	/* Flag to indicate if VM is used for compute */
>  	bool			is_compute_context;
> -
> +	bool			is_userq_context;
>  	/* Memory partition number, -1 means any partition */
>  	int8_t			mem_id;
>  

