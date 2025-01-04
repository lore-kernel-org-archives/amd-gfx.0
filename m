Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDB2E77188
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2025 00:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50CCA10E974;
	Sat,  4 Jan 2025 00:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTABPapG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 459B210E974
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2025 00:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQEWEEI+lsvZC8pt3pGn29PD7jumMJFsXCWWGnnq5BMM7fePNmBBsiLZMakCJEkOSKizWdagxG/QSicJcVC8jm0sdoGqtoBoAPz2topnzjBWcR7QcFE6aFHgqRsH982mznFmYkt7QCP4YlT+T+7nzxmORgSHkwZ2KZkGd/iOvPc7JPPg3xDiVn72WF4ZyY9nhbZSxi2ugZFLAVM8Lz5zaxyABrx8BZrgjqQm19Gmg3JhfXx81UKteNtsfgdFCQY3tI0k+rn9EDq7H/91dSB2sQpOOitKLBLBEBGrt2PxJ/xP+rMJA4w7elSME8+EdFG7d1MNwKULBqcLkjnUnaxwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bQrxsxy8U/knmj6opDC7lo+9LoWw7ZPe+e05jFgvvk=;
 b=GsxjwLa1MK+cYQdUpHFFWV/Up2ciCxJEptcQ2cc0owTEUkjo4+0OtwwF8QBgCUuQ0Kv/I6k2P6CpP8yJcJBNURS69PI6GQJkaPXchS5TtRpHb0dv16/rqxny+giqid1ECZhZYuB0IwwO0tVX/FRVB5l0/xUGwojfRhZPORgexJhOynA7ZI1Ex82zXqFjricgSWxxLK6waw1YnXQEevVosgrnNYyuFQ83EVbBKLWF3TSriucUPdu2vFs3ujev+Rypge5elvLmvZpIbWxg0HgMeprVGMEuPR3fX9e+QWYH1H4xjbRMs6reGVpF88G9y4eAgbE4wxCQGa4vLuhhvRJ8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bQrxsxy8U/knmj6opDC7lo+9LoWw7ZPe+e05jFgvvk=;
 b=VTABPapGZ89r3uYaNstmjz+5khMrHT89FZvaP7Lm+UQ3+t6KqYOtDAXFaF6C0Fuy4mn1FTYSl14cL6aY4OBmP71tiF9zzSEiVaNEPUxcPrwOioF2EdhNDTiup8O+yZwPHQyna9jR4oMf1zVFrLRVkd/RVtTsHCVue8HqQgAW8GE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Sat, 4 Jan
 2025 00:10:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8314.013; Sat, 4 Jan 2025
 00:10:25 +0000
Message-ID: <002da1de-e1e8-488f-9189-3390219a7140@amd.com>
Date: Fri, 3 Jan 2025 19:10:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, jonathan.kim@amd.com
References: <20241203180309.192263-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241203180309.192263-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0318.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5529556e-c7bb-4518-6c91-08dd2c543004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RloyK0Z0eDlEZ2NER1VQeUFaWEErc29KTTFEOWIrU1hPZS85dXJtSldXNnRH?=
 =?utf-8?B?U3BRS0NFN2NlWVBoeVI2N29lTFB2L2paTGNyY3Q1eEVKek4zN2dmY2dkVDVR?=
 =?utf-8?B?TDMwL2t6aE1wSW9hb1RZc01RdlpxUFRZVjFxVSs0dVhsZlVHTWJtNlZTZVZX?=
 =?utf-8?B?SzhTRUJTMEQvMklpb0p0L1d3Ky9MR2JUZ1NkS1oralFKWUE1cGNJK3h3aG5O?=
 =?utf-8?B?cUcvV25oR1pOdkg2cUlaOGo3TVZBa3RHRGlZZFEvZDAzclVvOWJWUTl1bVdo?=
 =?utf-8?B?eWs2REVjenlURGtTNW9ZV1g3SEo0OW5DMGExNTI1ckgyY0RSNzdOVElZY08r?=
 =?utf-8?B?a0IyaCtaTGgxK3RYT3hXM0ZtbWJIRVFRTUpTaEhaTlN1dDh6b09CLzNoT0ds?=
 =?utf-8?B?L3hkbXYyQnpYYXpWSFkxTEg0c2hHL2tXYmFqUUdkcGtlajlzdFYxSFJWcUYw?=
 =?utf-8?B?MGVQcGphNHN5UE01SStrUUFMbVhLRGVzdEhCSmhLcC9sTnZhaVM5WjhxbFQ4?=
 =?utf-8?B?L2NsL3BoeUdvOFhhN0FyQUc0TGJDUytKSjNTb3g4RS9SZDlzaCtvMlFvZGli?=
 =?utf-8?B?cCtjZW5WTStEUEZJcUU0Tisway93amE4blZha0JwdWg5bVA3T1U1NDE4amx6?=
 =?utf-8?B?SEdZdU9hd0tZY2dVakZ4aE5NckhSZEdoMkIxSnY5SDBDWThpRVR5TTlhWDVt?=
 =?utf-8?B?U210WlZzc3dKNTFiblliakRWM1daVVJkN1EyR1VQcXNGK09DSjJBWkZEeHJ5?=
 =?utf-8?B?THY2WkN1ckg5NkoyOHU4c0Z1Q1BYNnIyYTBDeVdDSWlUaWYxeWJrekE4R3dQ?=
 =?utf-8?B?NHZ6cE56SnVWV2NKaXo0TzJZbExEbnBlR1VGWEhQS215a29IQUk1eFVQNU1T?=
 =?utf-8?B?VGxybnJBUlFIQ2hPclFZRmpKZGxyTlNVWHNxSEtjd1M3QWxwMEdDRkgzZ2tU?=
 =?utf-8?B?NkJIL3ZBS3EvSVN1RDZ4ZWRCYXVRenVOZHdyRDcvUE16dVNxVzhZOS82d09D?=
 =?utf-8?B?ODRiTkZSOWdqeGV6VDk0ZkNYelVqUzlCQlZMZHE0YTRKanVPSzRtNEozR0E1?=
 =?utf-8?B?YlcxVEErVllvTWxkWUpoNUVpV0JoODhQTkFPRm9PVWVhcENPTVJHcjNxYWll?=
 =?utf-8?B?bWp5ajMzOWwzMVAwbU5Cc0VLOVpzQmJLc21CVzRFQVhleFVVS2w2bERaeGIw?=
 =?utf-8?B?V1dYRit1eERJWnRGSWdhaGhrczlPWEtoK3Z0L1ZyVDNWbXliTjZOQWVxTURl?=
 =?utf-8?B?V3VCRW1iUUkvR1pMZk01MDQ0a0JxM3ZpakEwU2VYclZWZkZFU2V3eSs3MmpF?=
 =?utf-8?B?WWl0MGJpcGFOK3RZK3NaMnFCWUZmaHFaVVY0RWZWcDJFc3lZbXZVemNnVmlH?=
 =?utf-8?B?Z245UHdYNXZ5a1FDN1RpMVlFZDB1SVU4UnVZV2pZTmhzdnI3dUxLK1gxMlQ4?=
 =?utf-8?B?ZlV6ckJ0Q0lTRmxIOEcxaldmQ0lYSU43d1FJSkh0TjZINkhyVitaMldlWmNO?=
 =?utf-8?B?Qi9EdlEzYlZTS1lpUzZ2N2E2VFI0SzlpUFhsQ3ZTNTEwYmNXTjh0QllnSXpI?=
 =?utf-8?B?MnQ5cnpsTzR3RVhMcGVLelE4TUxkb3Q2Rmlsckp4SURGeVVtdDBRUXpnelF0?=
 =?utf-8?B?bkg0S3lBWEcxa1R3c3BqWFdwUnJBeXpyY3BWR3N6akIzMUs4R01BTkxubGU0?=
 =?utf-8?B?MjAyV0hiYVBYcDZKVHIzTThTWm9nbDlXYUtEdHJPNWFBWXd0QWhUcXJ4WDhM?=
 =?utf-8?B?TERRUitnZ1FQUk0wV0dBNEZ1OHZBZ0lKektEQjZYcGRIdjVaakJFRytvdjFM?=
 =?utf-8?B?eStGUm1acVk3K091YkVTMDUvdXRoT0I2TG5ZRW5TaTZEcmg2a2taR0RTTTVm?=
 =?utf-8?Q?MrOikTJu0Lw45?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXJYdFFjK01ZVE5Dd1BUV0o0V01QL0YvTVZWVm9zQjEyNm0wVGVHSnJURGdH?=
 =?utf-8?B?RE10SzlnMGVUeWJZT3ZkVy9OOGRFMVZYVDl2OVFEeGlkS0JlUk5XcVM4MWdZ?=
 =?utf-8?B?QXZ0eUM3bkNNblY4a3lTbDZXWEwwZkZweVNxN2dYUWtqMFNhcGpWY1NqZ09j?=
 =?utf-8?B?R1BSWnhmSUROaWprbVBQaXZNdEl1OFJONjNvQy8vc25jT0pEYXpqbldWUktW?=
 =?utf-8?B?U2ptMTV2Ri9QNlpGNXROVjFSYlNzMkJMa0RPUlYyL3dmWHJhemVZWmdHb201?=
 =?utf-8?B?a2l6L2F5dmJraW96ZUJvSjBzL2dNOXpWYWFUdWZZRDVBN0MvQVNhYzh0QzNP?=
 =?utf-8?B?NDVkSkxVUXFNRVJFdXdRVU8yTTMra0QvUmkvNE5uWTlrVm1kWk1ySytKaXUw?=
 =?utf-8?B?ZGhKdGl3b3duVWNhUWlmM1l3aCtoMFhOZE5lL3o3WTNUOEdLWllhOEs2SnRj?=
 =?utf-8?B?dVpzT3FvajJUdThxdDJ3SVZBQmpqWGhCTEltSjZmbFBwTnVnMHE2UEZXSnFx?=
 =?utf-8?B?bVVmUkxnU05UUkVkcE1kWUJjRjhubTQ4RlF0b0F6UHQrT3RpckMyUW83Rk5n?=
 =?utf-8?B?M0NJSlpWc3hSSEtNRGhWbDd0VFdQbG04U05EQ08wTFlPVXZibjNrTXdOZzl6?=
 =?utf-8?B?ZjN3RmlyMk8xVmJGblNiVnRyam1Idm9tNjNPQjlacUwveGgvcFhRRDREbWhl?=
 =?utf-8?B?YmdKemV2dTZhTmZSNEhDK0JmSm5yK2V4TlQ3Z3F0VWkzRDE3ZGdDZTB6T0pH?=
 =?utf-8?B?UWE0V3FMVWJPNkpyT0Y3SExKc0c1OHVVVDkyR1ZONVZUOWJDdGtOMkp6dUFw?=
 =?utf-8?B?aVplVUI5Ri9iZHZJekFJMVk4am5UZUJMZ2F0bXRYeFZVT1pBRGN5dFJYWWRp?=
 =?utf-8?B?RS9SeU1KMEwwQ2N2RXNDaWFBMStsd01JemR1RWxMQmd0U0ZxMWxJbjBYRVF1?=
 =?utf-8?B?TFN0NDNkK3lVVXZFTll6azFtbWtWd0QzL0VZSHFwMXEwTTJPY1QyUlc1NTFs?=
 =?utf-8?B?QTFqRzAxOXdWZGlFV3h4eE52UzJkSHJscENzb0taOUFIQ3JkQ1IycU9Ld0xL?=
 =?utf-8?B?TkhtZHZyQXJVQXQ5aTNqSERwVk9xdjZ6blIzWTdiY2Qwa012ZjZzdE5YY2Ft?=
 =?utf-8?B?bkZGQUdaU3BKQmJWb3o2UlFDVCtRNXdNNXJzbC9CbjcvOEFSMUtxdm9pUVZB?=
 =?utf-8?B?TGVhTVFJcndNZUZHMUZqZEwrQnV6KzRMYnczelR2L3NPWmc5WVZMMGFhQUl6?=
 =?utf-8?B?VEtUV2ZPWVlwOTZVUzhBRmNHWGtYN011SXppeUgreEl5dzloUWJtaFZWNU41?=
 =?utf-8?B?ZENsQVhKaVpBMSszOU5OWGk4VzhYend3SzdIQjlHUmswbjV0MmVZeEpPVExR?=
 =?utf-8?B?RVhtQjRzTGhWdlV4MXMzbEljWHg2S2w4S0pXRXdIMnVpbW1yODc4amR0UjFz?=
 =?utf-8?B?TTRyQURGWUthVitRdndibmpYVm5oZWFCRUNSTGRFanJ4Q1Biam5vOVU5dTFt?=
 =?utf-8?B?OS9kMDcrZGllQjZwcEkyNUtON0w1cmF6aU1BWVJPS3E3U3NBRkxjOUJzQ0J1?=
 =?utf-8?B?a2NodUVLVkxUanJQaUpSSW1GYis1N0EzYjRXN0pRK2V5QjNSakdlWExoQndN?=
 =?utf-8?B?UmZQK3pjUE5nWkJRQlo3bHdkMHdOZzg2V09KRjVRb2hGV3YrZkF2L1JIbzc0?=
 =?utf-8?B?VzhVVDZEMDdnQUhzaEpkZ3EyWHBvSjRrQnBVUUQ3LzJkR0lFc0Z2WGp6b1FO?=
 =?utf-8?B?cXI4T1hhUC93dzlTNm5abmUxMndUV0lZMnlzNDF5SlBZUHFvOVVVclFidlRH?=
 =?utf-8?B?SkhRenNVeUZOMmRsNGtFSGZWUm9nbjRwNDhCQkRmdTgrR1RHVzIrRjVOb2xU?=
 =?utf-8?B?bEx2eVpDU1ZaUDN4VFZZUzArNE8rdkZDdWxHWGdtN21aUkRZbnVicjFzSDRl?=
 =?utf-8?B?UXF3Mm5DUkNWMW5rNWh5K1lqRmNXaEpveTF4KzNYZ015NHFOSjN1V1dyRnc2?=
 =?utf-8?B?RUpzcFA3bnNwM0c1YnYrOWdhaCtIbC8wdUxpdTdSRWxrT1NPemszVkxVd0Ix?=
 =?utf-8?B?emV3YWluUlgyR2huN0s0RkthbFdETWcrdmdINGt5bDZFRmtvdlpGSGxqSFRD?=
 =?utf-8?Q?BqSUtUHaC3GIsujFK/Y0TEeTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5529556e-c7bb-4518-6c91-08dd2c543004
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 00:10:25.2584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXr1E6VcBVjoYKz2gHbFinZiEV/cvgmXRtmm1bx7kArlF6IPTXjCV2FOu8awPFWR1J8dj3xVkvJ6/wfcI0VOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
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


On 2024-12-03 13:03, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Current kfd driver has its own PASID value for a kfd process and uses it to
> locate vm at interrupt handler or mapping between kfd process and vm. That
> design is not working when a physical gpu device has multiple spatial
> partitions, ex: adev in CPX mode. This patch has kfd driver use same pasid
> values that graphic driver generated which is per vm per pasid.
>
> These pasid values are passed to fw/hardware. We do not need change interrupt
> handler though more pasid values are used. Also, pasid values at log are
> replaced by user process pid; pasid values are not exposed to user. Users see
> their process pids that have meaning in user space.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

I found one more reference leak and a few more nit-picks. See inline. 
Other than that, I think this looks good.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  21 ----
>   .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  14 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  25 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  14 +--
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  77 ++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  43 ++++---
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |   2 +-
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 +-
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   3 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  11 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 115 +++++++++++-------
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  10 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  19 +--
>   15 files changed, 191 insertions(+), 172 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 4b80ad860639..c1bc77f5bea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>   };
>   
>   struct amdgpu_device;
> +struct kfd_process_device;
>   struct amdgpu_reset_context;
>   
>   enum kfd_mem_attachment_type {
> @@ -299,8 +300,6 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
>   	(&((struct amdgpu_fpriv *)					\
>   		((struct drm_file *)(drm_priv))->driver_priv)->vm)
>   
> -int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid);
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					struct amdgpu_vm *avm,
>   					void **process_info,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index f30548f4c3b3..08a97f1b7ebd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1529,27 +1529,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
>   	amdgpu_bo_unreserve(bo);
>   }
>   
> -int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
> -				     struct amdgpu_vm *avm, u32 pasid)
> -
> -{
> -	int ret;
> -
> -	/* Free the original amdgpu allocated pasid,
> -	 * will be replaced with kfd allocated pasid.
> -	 */
> -	if (avm->pasid) {
> -		amdgpu_pasid_free(avm->pasid);
> -		amdgpu_vm_set_pasid(adev, avm, 0);
> -	}
> -
> -	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					   struct amdgpu_vm *avm,
>   					   void **process_info,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 795382b55e0a..b6efe7437e55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -107,10 +107,16 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
>   		kfd_signal_hw_exception_event(pasid);
>   	else if (ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
>   		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
> +		struct kfd_process_device *pdd;
>   		struct kfd_vm_fault_info info;
> +		struct kfd_process *p;
>   
>   		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> +		p = kfd_lookup_process_by_pasid(pasid, &pdd);
> +		if (!pdd)

You're relying on kfd_lookup_process_by_pasid to initialize pdd to NULL 
here in the error case. It would be safer (and easier for static 
checkers) if you initialized pdd to NULL in its declaration.


> +			return;
> +
> +		kfd_evict_process_device(pdd);
>   
>   		memset(&info, 0, sizeof(info));
>   		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->adev, &info);
> @@ -118,9 +124,11 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
>   			return;

This return leaks the process reference count.


>   
>   		if (info.vmid == vmid)
> -			kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
> +			kfd_signal_vm_fault_event(pdd, &info, NULL);
>   		else
> -			kfd_signal_vm_fault_event(dev, pasid, NULL, NULL);
> +			kfd_signal_vm_fault_event(pdd, &info, NULL);
> +
> +		kfd_unref_process(p);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 065d87841459..8b1fd8e7452b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -155,8 +155,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
>   	/* filep now owns the reference returned by kfd_create_process */
>   	filep->private_data = process;
>   
> -	dev_dbg(kfd_device, "process %d opened, compat mode (32 bit) - %d\n",
> -		process->pasid, process->is_32bit_user_mode);
> +	dev_dbg(kfd_device, "process pid %d opened kfd node, compat mode (32 bit) - %d\n",
> +		(int)process->lead_thread->pid, process->is_32bit_user_mode);

Why do you need to cast pid to int? It uses pid_t, which is defined as 
__kernel_pid_t, which in turn should be int. More of the same below ...


>   
>   	return 0;
>   }
> @@ -361,8 +361,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_acquire_queue_buf;
>   	}
>   
> -	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
> -			p->pasid,
> +	pr_debug("Creating queue for process pid 0x%x on gpu 0x%x\n",
> +			(int)p->lead_thread->pid,
>   			dev->id);
>   
>   	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
> @@ -415,9 +415,9 @@ static int kfd_ioctl_destroy_queue(struct file *filp, struct kfd_process *p,
>   	int retval;
>   	struct kfd_ioctl_destroy_queue_args *args = data;
>   
> -	pr_debug("Destroying queue id %d for pasid 0x%x\n",
> +	pr_debug("Destroying queue id %d for process pid 0x%x\n",
>   				args->queue_id,
> -				p->pasid);
> +				(int)p->lead_thread->pid);
>   
>   	mutex_lock(&p->mutex);
>   
> @@ -468,8 +468,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
>   	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
>   	properties.priority = args->queue_priority;
>   
> -	pr_debug("Updating queue id %d for pasid 0x%x\n",
> -			args->queue_id, p->pasid);
> +	pr_debug("Updating queue id %d for process pid 0x%x\n",
> +			args->queue_id, (int)p->lead_thread->pid);
>   
>   	mutex_lock(&p->mutex);
>   
> @@ -695,7 +695,7 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
>   	struct kfd_process_device_apertures *pAperture;
>   	int i;
>   
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x", (int)p->lead_thread->pid);
>   
>   	args->num_of_nodes = 0;
>   
> @@ -747,7 +747,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
>   	int ret;
>   	int i;
>   
> -	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
> +	dev_dbg(kfd_device, "get apertures for process pid 0x%x",
> +			(int)p->lead_thread->pid);
>   
>   	if (args->num_of_nodes == 0) {
>   		/* Return number of nodes, so that user space can alloacate
> @@ -3365,12 +3366,12 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>   
>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>   
> -	pr_debug("pasid 0x%x mapping mmio page\n"
> +	pr_debug("process pid 0x%x mapping mmio page\n"
>   		 "     target user address == 0x%08llX\n"
>   		 "     physical address    == 0x%08llX\n"
>   		 "     vm_flags            == 0x%04lX\n"
>   		 "     size                == 0x%04lX\n",
> -		 process->pasid, (unsigned long long) vma->vm_start,
> +		 (int)process->lead_thread->pid, (unsigned long long) vma->vm_start,
>   		 address, vma->vm_flags, PAGE_SIZE);
>   
>   	return io_remap_pfn_range(vma,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 312dfa84f29f..e96e3895056e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -204,11 +204,12 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>   				   size_t exception_data_size)
>   {
>   	struct kfd_process *p;
> +	struct kfd_process_device *pdd;
>   	bool signaled_to_debugger_or_runtime = false;
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, &pdd);
>   
> -	if (!p)
> +	if (!pdd)

This again depends on kfd_lookup_process_by_pasid initializing pdd to 
NULL in the error case, which is not obvious without looking up the 
implementation in another file. It would be safer and easier to 
static-check, if you NULL-initialized pdd in the declaration above.


>   		return false;
>   
>   	if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
> @@ -238,9 +239,8 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>   
>   			mutex_unlock(&p->mutex);
>   		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
> -			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
> -			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
> -							exception_data);
> +			kfd_evict_process_device(pdd);
> +			kfd_signal_vm_fault_event(pdd, NULL, exception_data);
>   
>   			signaled_to_debugger_or_runtime = true;
>   		}
> @@ -276,8 +276,8 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   		data = (struct kfd_hsa_memory_exception_data *)
>   						pdd->vm_fault_exc_data;
>   
> -		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
> -		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
> +		kfd_evict_process_device(pdd);
> +		kfd_signal_vm_fault_event(pdd, NULL, data);
>   		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c79fe9069e22..22a807718fd4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,7 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   		return -EIO;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> -	queue_input.process_id = qpd->pqm->process->pasid;
> +	queue_input.process_id = pdd->pasid;
>   	queue_input.page_table_base_addr =  qpd->page_table_base;
>   	queue_input.process_va_start = 0;
>   	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
> @@ -527,6 +527,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			struct qcm_process_device *qpd,
>   			struct queue *q)
>   {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct device *dev = dqm->dev->adev->dev;
>   	int allocated_vmid = -1, i;
>   
> @@ -545,9 +546,9 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   
>   	pr_debug("vmid allocated: %d\n", allocated_vmid);
>   
> -	dqm->vmid_pasid[allocated_vmid] = q->process->pasid;
> +	dqm->vmid_pasid[allocated_vmid] = pdd->pasid;
>   
> -	set_pasid_vmid_mapping(dqm, q->process->pasid, allocated_vmid);
> +	set_pasid_vmid_mapping(dqm, pdd->pasid, allocated_vmid);
>   
>   	qpd->vmid = allocated_vmid;
>   	q->properties.vmid = allocated_vmid;
> @@ -799,6 +800,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   		return -EOPNOTSUPP;
>   	}
>   
> +	/* taking the VMID for that process on the safe way using PDD */
> +	pdd = kfd_get_process_device_data(dev, p);
> +	if (!pdd)
> +		return -EFAULT;
> +
>   	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
>   	 * ATC_VMID15_PASID_MAPPING
>   	 * to check which VMID the current process is mapped to.
> @@ -808,23 +814,19 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
>   		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
>   				(dev->adev, vmid, &queried_pasid);
>   
> -		if (status && queried_pasid == p->pasid) {
> -			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
> -					vmid, p->pasid);
> +		if (status && queried_pasid == pdd->pasid) {
> +			pr_debug("Killing wave fronts of vmid %d and process pid 0x%x\n",
> +				 vmid, p->lead_thread->pid);
>   			break;
>   		}
>   	}
>   
>   	if (vmid > last_vmid_to_scan) {
> -		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
> +		dev_err(dev->adev->dev, "Didn't find vmid for process pid 0x%x\n",
> +			p->lead_thread->pid);
>   		return -EFAULT;
>   	}
>   
> -	/* taking the VMID for that process on the safe way using PDD */
> -	pdd = kfd_get_process_device_data(dev, p);
> -	if (!pdd)
> -		return -EFAULT;
> -
>   	reg_gfx_index.bits.sh_broadcast_writes = 1;
>   	reg_gfx_index.bits.se_broadcast_writes = 1;
>   	reg_gfx_index.bits.instance_broadcast_writes = 1;
> @@ -1060,8 +1062,8 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
>   	if (q->properties.is_suspended)
>   		return 0;
>   
> -	pr_debug("Suspending PASID %u queue [%i]\n",
> -			pdd->process->pasid,
> +	pr_debug("Suspending process pid %u queue [%i]\n",
> +			pdd->process->lead_thread->pid,
>   			q->properties.queue_id);
>   
>   	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
> @@ -1108,8 +1110,8 @@ static int resume_single_queue(struct device_queue_manager *dqm,
>   
>   	pdd = qpd_to_pdd(qpd);
>   
> -	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
> -			    pdd->process->pasid,
> +	pr_debug("Restoring from suspend process pid %u queue [%i]\n",
> +			    pdd->process->lead_thread->pid,
>   			    q->properties.queue_id);
>   
>   	q->properties.is_suspended = false;
> @@ -1142,8 +1144,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		goto out;
>   
>   	pdd = qpd_to_pdd(qpd);
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	pdd->last_evict_timestamp = get_jiffies_64();
>   	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -1200,8 +1202,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!pdd->drm_priv)
>   		goto out;
>   
> -	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	/* Mark all queues as evicted. Deactivate all active queues on
>   	 * the qpd.
> @@ -1259,8 +1261,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		goto out;
>   	}
>   
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			    pdd->process->lead_thread->pid);
>   
>   	/* Update PD Base in QPD */
>   	qpd->page_table_base = pd_base;
> @@ -1343,8 +1345,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!pdd->drm_priv)
>   		goto vm_not_acquired;
>   
> -	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
> -			    pdd->process->pasid);
> +	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
> +			     pdd->process->lead_thread->pid);
>   
>   	/* Update PD Base in QPD */
>   	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
> @@ -2136,7 +2138,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>   	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   
>   	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid 0x%0x is reset\n",
> -		q->properties.queue_id, q->process->pasid);
> +		q->properties.queue_id, pdd->process->lead_thread->pid);
>   
>   	pdd->has_reset_queue = true;
>   	if (q->properties.is_active) {
> @@ -2970,19 +2972,18 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
>   {
>   	struct kfd_process_device *pdd;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, &pdd);
>   	struct device_queue_manager *dqm = knode->dqm;
>   	struct device *dev = dqm->dev->adev->dev;
>   	struct qcm_process_device *qpd;
>   	struct queue *q = NULL;
>   	int ret = 0;
>   
> -	if (!p)
> +	if (!pdd)

Same as above.


>   		return -EINVAL;
>   
>   	dqm_lock(dqm);
>   
> -	pdd = kfd_get_process_device_data(dqm->dev, p);
>   	if (pdd) {
>   		qpd = &pdd->qpd;
>   
> @@ -3015,6 +3016,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
>   
>   out:
>   	dqm_unlock(dqm);
> +	kfd_unref_process(p);

Ah, this was a bug in the existing code. Maybe fix that in a separate 
patch that goes before this one.


>   	return ret;
>   }
>   
> @@ -3056,24 +3058,23 @@ static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
>   	return ret;
>   }
>   
> -int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
> +int kfd_evict_process_device(struct kfd_process_device *pdd)
>   {
> -	struct kfd_process_device *pdd;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct device_queue_manager *dqm;
> +	struct kfd_process *p;
>   	int ret = 0;
>   
> -	if (!p)
> +	p = pdd->process;
> +	dqm = pdd->dev->dqm;
> +	if (!p || !dqm)

I think these checks are unnecessary. A pdd without a process or a 
device without a queue manager would be some serious bug somewhere else. 
You could just let that cause a kernel oops.


>   		return -EINVAL;
> +
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
> -	pdd = kfd_get_process_device_data(dqm->dev, p);
> -	if (pdd) {
> -		if (dqm->dev->kfd->shared_resources.enable_mes)
> +
> +	if (dqm->dev->kfd->shared_resources.enable_mes)
>   			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
>   		else
>   			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);

Please fix the indentation here.


> -	}
> -
> -	kfd_unref_process(p);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ea3792249209..f1a0562c4ca8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -727,7 +727,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   	 * to process context, kfd_process could attempt to exit while we are
>   	 * running so the lookup function increments the process ref count.
>   	 */
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return; /* Presumably process exited. */
> @@ -1128,8 +1128,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   
>   	if (type == KFD_EVENT_TYPE_MEMORY) {
>   		dev_warn(kfd_device,
> -			"Sending SIGSEGV to process %d (pasid 0x%x)",
> -				p->lead_thread->pid, p->pasid);
> +			"Sending SIGSEGV to process pid %d",
> +				p->lead_thread->pid);
>   		send_sig(SIGSEGV, p->lead_thread, 0);
>   	}
>   
> @@ -1137,13 +1137,13 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   	if (send_signal) {
>   		if (send_sigterm) {
>   			dev_warn(kfd_device,
> -				"Sending SIGTERM to process %d (pasid 0x%x)",
> -					p->lead_thread->pid, p->pasid);
> +				"Sending SIGTERM to process pid %d",
> +					p->lead_thread->pid);
>   			send_sig(SIGTERM, p->lead_thread, 0);
>   		} else {
>   			dev_err(kfd_device,
> -				"Process %d (pasid 0x%x) got unhandled exception",
> -				p->lead_thread->pid, p->pasid);
> +				"Process pid %d got unhandled exception",
> +				p->lead_thread->pid);
>   		}
>   	}
>   
> @@ -1157,7 +1157,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
>   	 * to process context, kfd_process could attempt to exit while we are
>   	 * running so the lookup function increments the process ref count.
>   	 */
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return; /* Presumably process exited. */
> @@ -1166,22 +1166,20 @@ void kfd_signal_hw_exception_event(u32 pasid)
>   	kfd_unref_process(p);
>   }
>   
> -void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
> +void kfd_signal_vm_fault_event(struct kfd_process_device * pdd,

No space between * and pdd.


>   				struct kfd_vm_fault_info *info,
>   				struct kfd_hsa_memory_exception_data *data)
>   {
>   	struct kfd_event *ev;
>   	uint32_t id;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = pdd->process;
>   	struct kfd_hsa_memory_exception_data memory_exception_data;
>   	int user_gpu_id;
>   
> -	if (!p)
> -		return; /* Presumably process exited. */
> -
> -	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
> +	user_gpu_id = kfd_process_get_user_gpu_id(p, pdd->dev->id);
>   	if (unlikely(user_gpu_id == -EINVAL)) {
> -		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
> +		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n",
> +			  pdd->dev->id);
>   		return;
>   	}
>   
> @@ -1218,7 +1216,6 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
>   		}
>   
>   	rcu_read_unlock();
> -	kfd_unref_process(p);
>   }
>   
>   void kfd_signal_reset_event(struct kfd_node *dev)
> @@ -1253,7 +1250,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   		}
>   
>   		if (unlikely(!pdd)) {
> -			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
> +			WARN_ONCE(1, "Could not get device data from process pid:0x%x\n",
> +				  p->lead_thread->pid);
>   			continue;
>   		}
>   
> @@ -1262,8 +1260,15 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   
>   		if (dev->dqm->detect_hang_count) {
>   			struct amdgpu_task_info *ti;
> +			struct amdgpu_fpriv *drv_priv;
> +
> +			if (unlikely(amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))) {
> +				WARN_ONCE(1, "Could not get vm for device %x from pid:0x%x\n",
> +					  dev->id, p->lead_thread->pid);
> +				continue;
> +			}
>   
> -			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
> +			ti = amdgpu_vm_get_task_info_vm(&drv_priv->vm);
>   			if (ti) {
>   				dev_err(dev->adev->dev,
>   					"Queues reset on process %s tid %d thread %s pid %d\n",
> @@ -1300,7 +1305,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>   
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   {
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	struct kfd_hsa_memory_exception_data memory_exception_data;
>   	struct kfd_hsa_hw_exception_data hw_exception_data;
>   	struct kfd_event *ev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> index b3f988b275a8..c5f97e6e36ff 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -194,7 +194,7 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
>   	enum amdgpu_ras_block block = 0;
>   	int ret = -EINVAL;
>   	uint32_t reset = 0;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 0cb5c582ce7d..b8a91bf4ef30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -146,7 +146,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>   {
>   	enum amdgpu_ras_block block = 0;
>   	uint32_t reset = 0;
> -	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
>   	u64 event_id;
>   	int old_poison, ret;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 1f9f5bfeaf86..d56525201155 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -47,7 +47,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> @@ -106,7 +106,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
>   		packet->bitfields2.exec_cleaner_shader = 1;
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
>   	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
>   	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index c1199d06d131..347c86e1c378 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -42,6 +42,7 @@ unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
>   static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>   				struct qcm_process_device *qpd)
>   {
> +	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>   	struct pm4_mes_map_process *packet;
>   
>   	packet = (struct pm4_mes_map_process *)buffer;
> @@ -52,7 +53,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
>   					sizeof(struct pm4_mes_map_process));
>   	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
>   	packet->bitfields2.process_quantum = 10;
> -	packet->bitfields2.pasid = qpd->pqm->process->pasid;
> +	packet->bitfields2.pasid = pdd->pasid;
>   	packet->bitfields3.page_table_base = qpd->page_table_base;
>   	packet->bitfields10.gds_size = qpd->gds_size;
>   	packet->bitfields10.num_gws = qpd->num_gws;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9e5ca0b93b2a..b6aba42d1f6b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -849,6 +849,8 @@ struct kfd_process_device {
>   
>   	/* Tracks queue reset status */
>   	bool has_reset_queue;
> +
> +	u32 pasid;
>   };
>   
>   #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
> @@ -908,8 +910,6 @@ struct kfd_process {
>   	/* We want to receive a notification when the mm_struct is destroyed */
>   	struct mmu_notifier mmu_notifier;
>   
> -	u32 pasid;
> -
>   	/*
>   	 * Array of kfd_process_device pointers,
>   	 * one for each device the process is using.
> @@ -1034,7 +1034,8 @@ void kfd_process_destroy_wq(void);
>   void kfd_cleanup_processes(void);
>   struct kfd_process *kfd_create_process(struct task_struct *thread);
>   struct kfd_process *kfd_get_process(const struct task_struct *task);
> -struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
> +						 struct kfd_process_device **pdd);
>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
>   
>   int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
> @@ -1331,7 +1332,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
>   struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
>   					enum kfd_queue_type type);
>   void kernel_queue_uninit(struct kernel_queue *kq);
> -int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
> +int kfd_evict_process_device(struct kfd_process_device *pdd);
>   int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
>   
>   /* Process Queue Manager */
> @@ -1486,7 +1487,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>   int kfd_get_num_events(struct kfd_process *p);
>   int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>   
> -void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
> +void kfd_signal_vm_fault_event(struct kfd_process_device * pdd,

No space between * and pdd.


Regards,
   Felix


>   				struct kfd_vm_fault_info *info,
>   				struct kfd_hsa_memory_exception_data *data);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 87cd52cf4ee9..de963b8b2e09 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -282,8 +282,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   	cu_cnt = 0;
>   	proc = pdd->process;
>   	if (pdd->qpd.queue_count == 0) {
> -		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
> -			 dev->id, proc->pasid);
> +		pr_debug("Gpu-Id: %d has no active queues for process pid %d\n",
> +			 dev->id, (int)proc->lead_thread->pid);
>   		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
>   	}
>   
> @@ -327,12 +327,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
>   static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   			       char *buffer)
>   {
> -	if (strcmp(attr->name, "pasid") == 0) {
> -		struct kfd_process *p = container_of(attr, struct kfd_process,
> -						     attr_pasid);
> -
> -		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
> -	} else if (strncmp(attr->name, "vram_", 5) == 0) {
> +	if (strcmp(attr->name, "pasid") == 0)
> +		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
> +	else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
>   		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
> @@ -1056,8 +1053,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> -		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
> -				pdd->dev->id, p->pasid);
> +		pr_debug("Releasing pdd (topology id %d, for pid 0x%0x)\n",
> +			 pdd->dev->id, (int)p->lead_thread->pid);
>   
>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>   		kfd_process_device_destroy_ib_mem(pdd);
> @@ -1172,7 +1169,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>   
>   	kfd_event_free_process(p);
>   
> -	kfd_pasid_free(p->pasid);
>   	mutex_destroy(&p->mutex);
>   
>   	put_task_struct(p->lead_thread);
> @@ -1523,12 +1519,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	atomic_set(&process->debugged_process_count, 0);
>   	sema_init(&process->runtime_enable_sema, 0);
>   
> -	process->pasid = kfd_pasid_alloc();
> -	if (process->pasid == 0) {
> -		err = -ENOSPC;
> -		goto err_alloc_pasid;
> -	}
> -
>   	err = pqm_init(&process->pqm, process);
>   	if (err != 0)
>   		goto err_process_pqm_init;
> @@ -1582,8 +1572,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   err_init_apertures:
>   	pqm_uninit(&process->pqm);
>   err_process_pqm_init:
> -	kfd_pasid_free(process->pasid);
> -err_alloc_pasid:
>   	kfd_event_free_process(process);
>   err_event_init:
>   	mutex_destroy(&process->mutex);
> @@ -1722,15 +1710,18 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (ret)
>   		goto err_init_cwsr;
>   
> -	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
> -	if (ret)
> -		goto err_set_pasid;
> +	if (unlikely(!avm->pasid)) {
> +		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
> +			 avm);
> +		goto err_get_pasid;
> +	}
>   
> +	pdd->pasid = avm->pasid;
>   	pdd->drm_file = drm_file;
>   
>   	return 0;
>   
> -err_set_pasid:
> +err_get_pasid:
>   	kfd_process_device_destroy_cwsr_dgpu(pdd);
>   err_init_cwsr:
>   	kfd_process_device_destroy_ib_mem(pdd);
> @@ -1816,25 +1807,53 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
>   		idr_remove(&pdd->alloc_idr, handle);
>   }
>   
> -/* This increments the process->ref counter. */
> -struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
> +static struct kfd_process_device *kfd_lookup_process_device_by_pasid(u32 pasid)
>   {
> -	struct kfd_process *p, *ret_p = NULL;
> -	unsigned int temp;
>   
> -	int idx = srcu_read_lock(&kfd_processes_srcu);
> +	struct kfd_process_device *ret_p = NULL;
> +	struct kfd_process *p;
> +	unsigned int temp;
> +	int i;
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
> -		if (p->pasid == pasid) {
> -			kref_get(&p->ref);
> -			ret_p = p;
> -			break;
> +		for (i = 0; i < p->n_pdds; i++) {
> +			if (p->pdds[i]->pasid == pasid) {
> +				ret_p = p->pdds[i];
> +				break;
> +			}
>   		}
> +		if (ret_p)
> +			break;
> +	}
> +
> +	return ret_p;
> +
> +}
> +
> +/* This increments the process->ref counter. */
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
> +						 struct kfd_process_device **pdd)
> +{
> +	struct kfd_process_device *ret_p;
> +
> +	int idx = srcu_read_lock(&kfd_processes_srcu);
> +
> +	ret_p = kfd_lookup_process_device_by_pasid(pasid);
> +	if (ret_p) {
> +		if (pdd)
> +			*pdd = ret_p;
> +		kref_get(&ret_p->process->ref);
> +
> +		srcu_read_unlock(&kfd_processes_srcu, idx);
> +		return ret_p->process;
>   	}
>   
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   
> -	return ret_p;
> +	if (pdd)
> +		*pdd = NULL;
> +
> +	return NULL;
>   }
>   
>   /* This increments the process->ref counter. */
> @@ -1990,7 +2009,7 @@ static void evict_process_worker(struct work_struct *work)
>   	 */
>   	p = container_of(dwork, struct kfd_process, eviction_work);
>   
> -	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
> +	pr_debug("Started evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>   	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
>   	if (!ret) {
>   		/* If another thread already signaled the eviction fence,
> @@ -2002,9 +2021,9 @@ static void evict_process_worker(struct work_struct *work)
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
>   
> -		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished evicting process pid 0x%x\n", (int)p->lead_thread->pid);
>   	} else
> -		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to evict queues of process pid 0x%x\n", (int)p->lead_thread->pid);
>   }
>   
>   static int restore_process_helper(struct kfd_process *p)
> @@ -2021,9 +2040,11 @@ static int restore_process_helper(struct kfd_process *p)
>   
>   	ret = kfd_process_restore_queues(p);
>   	if (!ret)
> -		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
> +		pr_debug("Finished restoring process pid 0x%x\n",
> +			 (int)p->lead_thread->pid);
>   	else
> -		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
> +		pr_err("Failed to restore queues of process pid 0x%x\n",
> +			(int)p->lead_thread->pid);
>   
>   	return ret;
>   }
> @@ -2040,7 +2061,7 @@ static void restore_process_worker(struct work_struct *work)
>   	 * lifetime of this thread, kfd_process p will be valid
>   	 */
>   	p = container_of(dwork, struct kfd_process, restore_work);
> -	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
> +	pr_debug("Started restoring process pasid 0x%x\n", (int)p->lead_thread->pid);
>   
>   	/* Setting last_restore_timestamp before successful restoration.
>   	 * Otherwise this would have to be set by KGD (restore_process_bos)
> @@ -2056,8 +2077,8 @@ static void restore_process_worker(struct work_struct *work)
>   
>   	ret = restore_process_helper(p);
>   	if (ret) {
> -		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
> -			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
> +		pr_debug("Failed to restore BOs of process pid 0x%x, retry after %d ms\n",
> +			 (int)p->lead_thread->pid, PROCESS_BACK_OFF_TIME_MS);
>   		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
>   				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
>   			kfd_process_restore_queues(p);
> @@ -2073,7 +2094,7 @@ void kfd_suspend_all_processes(void)
>   	WARN(debug_evictions, "Evicting all processes");
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
> -			pr_err("Failed to suspend process 0x%x\n", p->pasid);
> +			pr_err("Failed to suspend process pid 0x%x\n", (int)p->lead_thread->pid);
>   		signal_eviction_fence(p);
>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
> @@ -2087,8 +2108,8 @@ int kfd_resume_all_processes(void)
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		if (restore_process_helper(p)) {
> -			pr_err("Restore process %d failed during resume\n",
> -			       p->pasid);
> +			pr_err("Restore process pid %d failed during resume\n",
> +			       (int)p->lead_thread->pid);
>   			ret = -EFAULT;
>   		}
>   	}
> @@ -2143,7 +2164,7 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
>   	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
>   	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
>   							KFD_IRQ_FENCE_CLIENTID;
> -	irq_drain_fence[3] = pdd->process->pasid;
> +	irq_drain_fence[3] = pdd->pasid;
>   
>   	/*
>   	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
> @@ -2173,7 +2194,7 @@ void kfd_process_close_interrupt_drain(unsigned int pasid)
>   {
>   	struct kfd_process *p;
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, NULL);
>   
>   	if (!p)
>   		return;
> @@ -2295,7 +2316,7 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
>   
>   	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
>   		seq_printf(m, "Process %d PASID 0x%x:\n",
> -			   p->lead_thread->tgid, p->pasid);
> +			   p->lead_thread->tgid, (int)p->lead_thread->pid);
>   
>   		mutex_lock(&p->mutex);
>   		r = pqm_debugfs_mqds(m, &p->pqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c76db22a1000..1f98c16e0fe9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -69,8 +69,8 @@ static int find_available_queue_slot(struct process_queue_manager *pqm,
>   	pr_debug("The new slot id %lu\n", found);
>   
>   	if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
> -		pr_info("Cannot open more queues for process with pasid 0x%x\n",
> -				pqm->process->pasid);
> +		pr_info("Cannot open more queues for process with pid 0x%x\n",
> +			pqm->process->lead_thread->pid);
>   		return -ENOMEM;
>   	}
>   
> @@ -425,8 +425,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   	}
>   
>   	if (retval != 0) {
> -		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
> -			pqm->process->pasid, type, retval);
> +		pr_err("process pid 0x%x DQM create queue type %d failed. ret %d\n",
> +			pqm->process->lead_thread->pid, type, retval);
>   		goto err_create_queue;
>   	}
>   
> @@ -520,7 +520,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
>   		if (retval) {
>   			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
> -				pqm->process->pasid,
> +				pdd->pasid,
>   				pqn->q->properties.queue_id, retval);
>   			if (retval != -ETIME)
>   				goto err_destroy_queue;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 3e2911895c74..a443c5d8ae1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -563,7 +563,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	int r;
>   
>   	p = container_of(prange->svms, struct kfd_process, svms);
> -	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
> +	pr_debug("process pid: %x svms 0x%p [0x%lx 0x%lx]\n",
> +		 (int)p->lead_thread->pid, prange->svms,
>   		 prange->start, prange->last);
>   
>   	if (svm_range_validate_svm_bo(node, prange))
> @@ -2969,7 +2970,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		return -EFAULT;
>   	}
>   
> -	p = kfd_lookup_process_by_pasid(pasid);
> +	p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	if (!p) {
>   		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
>   		return 0;
> @@ -3232,7 +3233,8 @@ void svm_range_list_fini(struct kfd_process *p)
>   	struct svm_range *prange;
>   	struct svm_range *next;
>   
> -	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p\n", (int)p->lead_thread->pid,
> +		 &p->svms);
>   
>   	cancel_delayed_work_sync(&p->svms.restore_work);
>   
> @@ -3255,7 +3257,8 @@ void svm_range_list_fini(struct kfd_process *p)
>   
>   	mutex_destroy(&p->svms.lock);
>   
> -	pr_debug("pasid 0x%x svms 0x%p done\n", p->pasid, &p->svms);
> +	pr_debug("process pid 0x%x svms 0x%p done\n",
> +		(int)p->lead_thread->pid, &p->svms);
>   }
>   
>   int svm_range_list_init(struct kfd_process *p)
> @@ -3618,8 +3621,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	bool flush_tlb;
>   	int r, ret = 0;
>   
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> -		 p->pasid, &p->svms, start, start + size - 1, size);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, size);
>   
>   	r = svm_range_check_attr(p, nattr, attrs);
>   	if (r)
> @@ -3727,8 +3730,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   out:
>   	mutex_unlock(&process_info->lock);
>   
> -	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
> -		 &p->svms, start, start + size - 1, r);
> +	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n",
> +		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, r);
>   
>   	return ret ? ret : r;
>   }
