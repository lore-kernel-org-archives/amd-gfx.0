Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD77D3C928
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 16:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A5810E76C;
	Wed, 10 Dec 2025 16:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXw8Jslc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FA710E76C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 16:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKPF+oHdie0TKZRCbIA57ZF+QEDdjyc4W5oduDsUsJLFRPxo8gpm5qLRRhKP5LvWVrVDmjLVeUawySlXc9rvuhqsPRJNM/Q38f1u84/7C8F8djFTvn+TY7D6hJy9n1Grpjaz86e0BO/mA2mt2x+XzmwFum6q0WRGmHhWHxxyhsfjlxQWr/DJKzspM1+YHx04SxXNL7ASxw+E1vvvU6yvF/WBHwFfOPgQ4DCo2BJbvxMhaRFD45KoozxLEmHeVaUaI0mBTLXYcdzRuUHwjHp5Sab9D8/izrnMtbNgt3I6X0Yi/GQCwe+1i9P0KcaVi1UFfQe7OhoqK1O5Ky80LEBXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtzrCTHAHtbHCSiGB6wJ30xcQcVxj9hk+pm8MrPx0C4=;
 b=D47COXmGp8HXRsNW/ve/Ttde/wyYEqfs7NQ9BKx6hrrZ1DR88vQQPleKMeXSAAuHRkFmgalEbuk7zS6qs7Kg26giHHhCAMMkk6oDnLNC65nF4/tYfjaimERST7eCXJoFawVwmt7zyy5KBbsqqu1h+xZYI7Lb4s3T7IfnkGUZW3NbbTx3Uo4YYFp7Tv0fgwe+bYNhJeGSFikab59lPSioUudwHvgySghXzr9PtcP9T8UUKw/tzlmXiwWJFn9zXR34SSY0bXQx3HvDZcDqzr5uWxWcnfda+ntOIcSrg/CNUYHK22a2lVP0COxeWlzt2FHQD+Nlxbw1Y9EyJvyuhCxmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtzrCTHAHtbHCSiGB6wJ30xcQcVxj9hk+pm8MrPx0C4=;
 b=LXw8JslcYXXa+dJ0QBQkTdqIJfA4XHVmPNZNxXiZWML7fnPjWOMoCT/JMhCArNpwxTMf0/EILzfgT/mDmWn3Dz+K1SCXknigO916nH0d1eF5m5JD2uZnlfYP60t2TrhxyyhqWW08uM4Ysuo6mNzxQi9UK9OrEZb1gBeQ/bi+9/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 16:43:04 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 16:43:04 +0000
Message-ID: <17dca9c3-ff1a-4dca-ae6c-8f0dac6e3096@amd.com>
Date: Wed, 10 Dec 2025 10:43:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251209203657.440714-1-Philip.Yang@amd.com>
 <0e0acd6d-ab5d-42ff-8b6d-c531b708e2d8@amd.com>
 <cfd82f70-cc30-4761-8162-0762afe65a7d@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <cfd82f70-cc30-4761-8162-0762afe65a7d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0198.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::23) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 78de570d-c1e6-4b2e-5abd-08de380b305d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VKM1Fkdm85OVVQandCb1VWV3JWKzRlMzVBa1hBeno5U0FMdjFuOHh6T1Za?=
 =?utf-8?B?WVpLbjEwYU9FMUhBUFhFNzBuMmJ5NGdXVXpmUC9LZ3JHcmkwb0ROZ1pvOTQ0?=
 =?utf-8?B?NTAzSW13U0ZEVGNydlcxRlJycWZSZko1QVdiZk5HRnIvbHpDRGRjc2w0Zk8x?=
 =?utf-8?B?RGIxaGJrL25zTWdETGo1U0RvWWN4RW5uWjFQMTRzeXczcSt6WXIwZTJER0FU?=
 =?utf-8?B?ZkdpeUpyOEJhRG85OUZwdTNSWUt5V3dPRUtGazZtVG43QmtZMjBaRmU0K1NS?=
 =?utf-8?B?VWs1emFCZVlCMmZOcUx5dDNqTUo3NE83NnI2aWRrVmM4ZEQ1MjJRQUJpd2gw?=
 =?utf-8?B?N0FnSFVpQnZWYVJIaEd4OGVZU3dOdXlkL2Y1NWlna0Z2c05GdmZKaEMyOHFu?=
 =?utf-8?B?U1NRWVB4Q3R1bjJEbDdTTTd1M21sdE1FdWNoWmtBRkE4T2Mvd1ZlTWFZTVBz?=
 =?utf-8?B?T3hReHkzQkxZVWQvNkQzYkg4MnExdlV6bkJGNE1nNzlpRXE4VysyQXRUdzcx?=
 =?utf-8?B?VnVsZk9xSWtZc0tUT1Q0S3J2VVM3ZGdXVXcwKzN5LzVzUUxjc0pPZWw2VHJN?=
 =?utf-8?B?WDdTTmFxN1NZMDVOaDg5TE9nN3haeHhRQWc3Y1FQQTlyNHFxRXBDMEw1Q1RG?=
 =?utf-8?B?enZoVVBQUkRudmNNSzZLZTZ2N2EzR1BtOHNvbC9kOUJ0VFJ0b3VOcHRhV0NP?=
 =?utf-8?B?QWJ1UHlIN3hzTERuK3RCUDlNK1NRdld3cDMybVV3ZXdOSXQ2cE53UUJGTHIz?=
 =?utf-8?B?bXJETjBobW1EOTJ0RXNCL2ptdmxQTWxEdmp2WE1oaHhFQVkyR3dJRjY4T0hE?=
 =?utf-8?B?cG5GcER3Mmw0KzlWVXhtSnY0MllCZkNnOHZ4ODdrUXJHcVRSZmVESDFwUnJZ?=
 =?utf-8?B?QnlKeFJPMHlSQ2hmQ2pJcFNjRU5ZM2V5ejVUTGhhUDJlWC9veklGRVlseVVD?=
 =?utf-8?B?elJ4anMyaldjLytQRkFzWm4zSFFoalBSRmNtWHM5TnBUSmVlMnErNFJhbHB0?=
 =?utf-8?B?U3JoODIrZEJyNWxHTC9VOVVWczRheHoxb0JKa1BHQzJ1R1FEV1luZVdWY3kr?=
 =?utf-8?B?d1RyL3Q1bTQ0Q0NqQ3BTaitaTkh1dWVFNjdvNjB6MnlVaGw3cUdnVUFUSnkw?=
 =?utf-8?B?VGdIOEt3cE1PRkFKQjhQRHc1M1FFV0x0cVkrL2J3Vy9mdE5ZTGFaWit0UUw4?=
 =?utf-8?B?b21BOWwvd1ZUdmRqTUg0dTZpdW5GU1NlM3hyTkFRMGdiUjJnb1oxSTRaWkZV?=
 =?utf-8?B?QnZLbXMrdk4rS0xHMyszVWJubEpMNVJDRVN0QXJKaDg1eUkxcWxKNzhWK0hB?=
 =?utf-8?B?NkNCcVN2bElkaXlYSVJlVEVZZWRXaGg4VlJUK0VhR2EwOExRMDh3R25iZko4?=
 =?utf-8?B?cndaWDNURGVMRmFabzhOUzVuTjRpcXpMbFRPM1NLQ2twUUtNZXE4MlhZTmgx?=
 =?utf-8?B?RzNPSVN4K2RCb1M1Nk1aVnlENUdka1hSbXBuaFFrNkpwL3U3dzhLWnhjU3Np?=
 =?utf-8?B?MnY1T3NTZTVYT3dHNG4wSlhGN1kxTFJRVUpQeE4vOEgzYXU3UmxYeDEwRW5O?=
 =?utf-8?B?VjRGVVMrOThXQUhIeEhYUXphek0rQ0VoV3BFWFIvMHVkZEJ3R3pJSGJEVzly?=
 =?utf-8?B?U2hjazl1Ujl6cnJJRU1MWm1pRlQ4RUw4QWNObVBuSTEzMGJZUy8rNkFlTHlN?=
 =?utf-8?B?TXhPRFFGN0dtZk9LZ2p1RnQ4a0h6VTV4R21jSjYvQkhRSTBYQ0x1dCtFRDNt?=
 =?utf-8?B?b0ZYbWZpcVNiSWtXZXFZT0ZXWUZGNVgzNFNNYmFzb1JMUnZnQk8ra283MThI?=
 =?utf-8?B?dFFGNG5VMjc5bWJxamRrL2NlbFNEOU0xblpHUHZuVkI3VVpBNUYyLzJ6Qjlm?=
 =?utf-8?B?Y1BHTE4zN0laSUlhd1M4YSt3MUNERTNKWFcrYllydlJSNmU3WjJhcWlEOVR0?=
 =?utf-8?Q?oKszALcWXyCXvk2kmjNrVNtSGcXREqjX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFlMVkJFZy96RXBlQWVzY2NnQmJya0preEVic0tKWm9FM0kyY0c2bElsam9J?=
 =?utf-8?B?SnJUUmRlQ2c3a0ZZNzBITGNHRDdkT0dWcVJaTWJ5Y2EzYVowTWxCMGhFQ3hk?=
 =?utf-8?B?N04xcDJvdTJPSGM0Z2pQLzVrZlNPeEFCdllQNWhHSTc0WjN3QjA2dEZxSFF6?=
 =?utf-8?B?bVZXVjI2ckJFMG1oRXVmeXQyOXBQRmRqNjNxTzJ6ZzlFYU1SUkVtM0h6Z2VQ?=
 =?utf-8?B?QkV0WENlQTR2V200TElhb1pUTm9yeVFSd3hqTzF1OVBvWmZxaXVJMHR1UEJ0?=
 =?utf-8?B?bnB2am12bGZ0bTIzWkoyc0ZyVlFtaHp5V2x5aHg5QkNLQ2tyYm55WCthMkZy?=
 =?utf-8?B?bG5MUW8ydnNVSUpnd1NlRE8rWVpYbzlDMlJBRTg5REpoTlM4NFdDZ2VHNlhT?=
 =?utf-8?B?QlVQNGdSNy9qbWorTm9rVnZCT3FBaFB0REozcHRUZWNmUW9SZmExNzl3Z20x?=
 =?utf-8?B?N0twamhOTU1URklXM2prL0tidlBOZEZ5NXRuVlMrSFhIK2R6S28rVW9ic0RO?=
 =?utf-8?B?VVBweGVaenRsZHp2OVc2OTM0YjJVYWUyd3RoQUxlWmVERlc3aXp2SHNJM1NJ?=
 =?utf-8?B?M3RlcUFienRJdzFtU1l0Qk04QWpURlBxV1pwSUt5QnE2Y1R1bzRvdGFjOVNV?=
 =?utf-8?B?Ti9WQmRlOUJ5bktJb1UwYms5cWtUSEw2ZW1HYVFkWGUzY05hUEJTalloZzJF?=
 =?utf-8?B?UXlxNnIrSEZTWjFtOFkwU3pwcm5hYnYvWXFjMXJJSTFRci9qakQ0Q1JlYWVH?=
 =?utf-8?B?b3E1bG9MbmZVQ1k1WXpQUXhZNCtzTVlkclVFZ2xLckxUakF5UnVHeUs5ZzFi?=
 =?utf-8?B?WUUyei9VSndvd3JoRWpPemFxM3dNUTBaWmVkSnJuQ1A1aSswVXg3YUdpOWpF?=
 =?utf-8?B?Z0hLbHUxTVdrL3k2SlprVDBEaVRtYmcxUzlJd0lKS0FlK0dUZmNEZy8wbHM3?=
 =?utf-8?B?R2R5a0k5emd1YXlFL1dBVnM5VWdhMFNRdWtRbU5ZVzBNMWd2L0JXemk5bGtY?=
 =?utf-8?B?MHBXeHRocWc1ZHpkbjBOUXBTVm51TWJJSlBKbDZlUDIvWTB3bHpiYTRrM2F4?=
 =?utf-8?B?Q1NKVTJzaHBBY1ovM2w1MndtQmlYN295d21FajdRZ0UrbGFFVktlVVpSSE92?=
 =?utf-8?B?MkcvWGFUVGkzRXRzZzQ2OWJIS3BvNEd5R2U0NzNJalpzK2tTL0hvZUpub2Nw?=
 =?utf-8?B?VjFmRklXai9wVTlLK3BVN2hDZTNoZCtiUGVUakdzZkIwRk5MZmo1NmxNd1kr?=
 =?utf-8?B?K1EwKzdjaTYzRjhIKy85QXJMWHNmNXlkNWc4SVZWSmtYL2xBakNkU0tRemdW?=
 =?utf-8?B?UTlzc1czV2tqQ21TVFV6aWJQZVgxbFJRaUR5SlZCTm5JNFhMeG45eUk4OGdT?=
 =?utf-8?B?R1VuN3Y3em9xWjI4L3JyNlg0VXpMTUd4UGcwY0l3K0Zodms5bGJIb0l5OUJK?=
 =?utf-8?B?Yi9BK3pmaGJ0VUNzWFJsWE9pVEV6ZHhzczA2NGJvSDczQjVEdXQvOHJrblhB?=
 =?utf-8?B?bE0xSVdnYW9McHB5eEZyT2pBU2VWb3hOUVJHVWtYV1dZL0NYZmFrUS9UclZN?=
 =?utf-8?B?MjRFUGRNdWIyMWRyMDMyNGlzbUtiRHJMYnN2VXI1NDh2dDRIZjROTGJENHdv?=
 =?utf-8?B?N3NmYk1oWnRvaTJHNzJFbTB1aWN4Y0xYdDk5OWp0ZjBRVEhNY21UK3ZybjhX?=
 =?utf-8?B?VEMyMzBOUk9PY2FHYVZyWDZWUzJYV01yYlg4MFpaTU54OWdnbjdnOHRpSHhD?=
 =?utf-8?B?UUtjMU1SSmFSLzVxdlQyUUxOQzg0K3hucFI0ZFB4WlcweUlLWmtReUxYTGhq?=
 =?utf-8?B?MzRwWGliMTQ2UUYyd2JwUTFUek9KTUJHRW03YWFkczhQc21RQ0tEYjJ5WEMz?=
 =?utf-8?B?eHU2MlRrdklXNDUxaUFsR0N6Z1F1SXNjN0VnWnYxR28wUW5zeTB5b3FxNkFm?=
 =?utf-8?B?cE9PT1hMcEdrNXp2eTZ0R2F0QVVKeUFBcUkwRmo5alJ0WFliZ3pGcmJGdE4r?=
 =?utf-8?B?ZnZEQXZrWm8yUVpndm90VmRaSmZpRzYwd2FDYzBRbEZsYkpFbG9uRXhmRzkr?=
 =?utf-8?B?cnBJbWFJRjNDTHh4SjJxL3Jsc0VDUmFuU2N4ZXVWd2hqVUt3MlFRNlcxZ3do?=
 =?utf-8?Q?G63Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78de570d-c1e6-4b2e-5abd-08de380b305d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:43:04.2478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBeXFdJTNmp+DlSCWKp8rsYtC/5NmEaq1pbQG5oufl6OBAl8iK146pnNIZcn5CEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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


On 12/10/2025 8:11 AM, Philip Yang wrote:
>
>
> On 2025-12-09 17:13, Chen, Xiaogang wrote:
>>
>> On 12/9/2025 2:36 PM, Philip Yang wrote:
>>> Error handling path should unreserve bo then return failed.
>>>
>>> Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 232103742712..6babdf025359 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct 
>>> process_queue_manager *pqm,
>>>                        p->queue_size)) {
>>>               pr_debug("ring buf 0x%llx size 0x%llx not mapped on 
>>> GPU\n",
>>>                    p->queue_address, p->queue_size);
>>> +            amdgpu_bo_unreserve(vm->root.bo);
>>
>> but why need have amdgpu_bo_reserve before call kfd_queue_buffer_get? 
>> kfd_queue_buffer_get just check if mapping at addr exist, it adds 
>> bo_ref and mapping->bo_va->queue_refcount. Then after immediately 
>> call kfd_queue_unref_bo_va and kfd_queue_buffer_put.
> amdgpu_vm_bo_lookup_mapping access vm->va interval tree, this requires 
> to take vm lock.

ok, it locks a vm->root.bo. I sought it locks a general bo.  I think the 
lock/unlock can be inside kfd_queue_buffer_get before and after 
amdgpu_vm_bo_lookup_mapping because that is what need be protected, then 
do not have to care unlock after this function call as current case.

For such lock can we use drm_exec_init/amdgpu_vm_lock_pd instead, as it 
is a more general way?

Regards

Xiaogang

>
> Regards,
> Philip
>>
>> Regards
>>
>> Xiaogang
>>
>>
>>>               return -EFAULT;
>>>           }
>
