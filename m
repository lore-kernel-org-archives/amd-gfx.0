Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86674C54FD4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 21:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2466210E057;
	Wed, 29 Jul 2026 21:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ttNR+pyI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8823010E057
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 21:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8QEik6lj/QAp3Oo1yS/jurF88HO3TMHBASrudrfJCbMUy6IP9uXHQSKez6Oz6Xs92Zsbw+0uL+yvnAln50/ixb+t4LDvArJMD0nQq/QyEJg1BIRj1dJdvor4JlLNVWsrJ317BcuIa7Gt2nOJBwIY6W9kh7dn60J5ejLi500K08JhDdGMpAilDI6zhZ5QNehXtT8ZwyhqlZ7aCNo0yYkdFojiQrbtsaP+r9kAL5uFIelVsSxNiMQtkVtFMu+Vp9NXm1ughhR+MSzbzdpSOfBsn9Mzm6fXBipVeGv04C97wgcQp9tOewmVQAZ39M+S2x3dM8iFeea2OJ3VDTjUIRS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75BGMawpJ866LAjcP1QOnqH11dFJdpvHUnH0VFhH2+c=;
 b=uq9JC3i5V1Bop/RE5bBfjbbTsggcZMFNX+cWixj41hX50UiFzTfDp1/8Wht+OnbZk89BN/Tho/YhJh4bLaZl01EcU5Qd74bFoZx12kG+xutovYpaFyQQs5gT7Fq8PsN/cJhYwbGZpxbls0u/t9rlcxZD7mKjQCqKIeZZFaiiWPv5TYh/f/+fnqi60nnCa/8WOERmetCuWnzwtPvsWGZwGcfj/P8QmtkVEtkiFucSbmWUdxUtpDZw/rKWKYKq2oxggebzS7lGjXDk1A8HV+cKMvyhgKHnJfUVOezG8gQGRrrzCGkCtFdQhXOciZcchYRVDYU6IFkYl7rVExpi1y0rUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75BGMawpJ866LAjcP1QOnqH11dFJdpvHUnH0VFhH2+c=;
 b=ttNR+pyITeJjJ2mTPo22OJi7bTiMIiTpgSG95MkG+V6ZfS60cFHteB0hZhQQUkqiAkVE4nfQmI1ZfaiADL+Qa/2esGSCXnXQ+Iy/Ep4YzSbfSm/SxrZZIhxx65EXLzHbo/KHSoWC5rBoIoOuBu0+tEIrt5wjYN7uMhAW0oNVxnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB5686.namprd12.prod.outlook.com
 (2603:10b6:510:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Wed, 29 Jul
 2026 21:20:45 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::e2a6:da85:2544:e542%4]) with mapi id 15.21.0223.017; Wed, 29 Jul 2026
 21:20:45 +0000
Message-ID: <b6d6789a-f5db-495b-9cd9-e13016383ae4@amd.com>
Date: Wed, 29 Jul 2026 17:20:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] drm/amdkfd: Unmap SVM range from GPU set to
 no-access
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260729163538.229530-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260729163538.229530-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: fff972ce-531b-4b45-2f7a-08deedb7406f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nA3SzKNaD3WIMxVoGYrgx6gYgCJuQdYcb5RoRLmyc9vEpnd8mVrsgAuKnW1Ix9bhmylPayWWP4VT3Mey9F6GGEXbM5Kw3h6qSqEXeAQaVc+n7pXaJ9izVesVTibQ1Ym8pVmRFZYUUoekqrZ+9ebIEzRj4z47Ag2Y4CNm4fDTpeuVuSN+5yFAxFiTpoM0ugPQgjaGgTgZO4kHTqzMQpkDG/58ezRkEnXzUTsV6BfDgua2N5g2wSurfWvPXBZHhvXk8NB7IrQ8cAAyNu9n2B1+Q6+nTWVSSAmrqK7firtM1vEKp+ge7sx2BPEE1n0awCL6cIdzUQmKZWZ9V91uYPKkh2tAJYy7NMbtLptxGxdaFKTQvVG7Z+VqSFbeJXC2C3UsTPe+RnYC1W/BjCU50/8CTpjUrWE372S2TRNAQqvpG1EeGZPNVBCkFVBGH5zWsM5gKMjuXKqlSaPqv1qoD6Bs2Zu4+hkZk53H7Db+oHVeNJU4xTjopCWb+FyQTYaLbS5mCPXPecTuZGYst/junczEU0mbaf+d5GbUgFJzfp+fwO/apURLodaca1m0d/mADGoXJeMlBY1wj6zfqz99fRhuPpjFWWZk6hA7ZYHCHy1l/gmTrkSeA/uA5VqGXxZUxHgz0/zYnkTvFnRbK4r2ZQ4hhtWoEYbJk8mkJ5Vwg+MK0zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5tUzdBSjJEOGRNU3Ryb2RsRW9EY2RrcDJreVJYR0piY0dvOTRoM2M0eUQr?=
 =?utf-8?B?djROdVBaektMcFJqZGowTDZTMnBnUEVMK3l6VzdlWEZIM0xSOUpxK3N1RUxL?=
 =?utf-8?B?REtrZ25TUWhvTzk5UW9zN01xL21CWi82Rlg0MFNaOWN0ajVIZThMaFA2UUpi?=
 =?utf-8?B?N3dHUW1TNmQ4R2NKNWJGckc5WFFneitCS013Mkl0SmdUaUZDVWlES1dMTUtG?=
 =?utf-8?B?ZlIyU0hINWtabWlsVlRocitFeXZKRDF5UG5OdWMvcVUyUFBOcml0bmMrNjJs?=
 =?utf-8?B?eXVtT3FIM3hOK0wvSUJOZjlnajZMVDhDRU13OW9WQjR4ZHhEcUl2Yjd0S2pG?=
 =?utf-8?B?VUIwbjlxZ0JSM2IvVDcvZmVkK1RzUXVoMythdHVqZFpGVmVmQ3VaV0Y0eDdn?=
 =?utf-8?B?TytrMlJpRWNJVXU3ZW5Qa1l6MEc5dVoxZE1zS0NpK3lZNWlZOXVJdjBJZnpT?=
 =?utf-8?B?SzR4V2tzUkZSRFZiT3VGbDdmNElycmpmRnE0bGlaTC9qSjZET1hDMGw3K29h?=
 =?utf-8?B?Nm9UMllXMVJTb3FiL012VkFVaE1aOWNNK1RQbnVNQUhqUmFMMjBHRGJJTmdY?=
 =?utf-8?B?OVB4eXNGdm1qcll0eU9QbWNJVGRFcENKWEovY0FDWjI4bnN1UkVhRWh0QlYw?=
 =?utf-8?B?eDJHVzNYdGhiNkgrVU5PRVRCc2ltMm9GN2tDNC91bHYrRTNwMlRDTU91Zm1B?=
 =?utf-8?B?MjlZazBaNEI5V1Z3Z0c3c3loV3llemNQYVNkekJZcVFSWDlRWkVBbGpZaURT?=
 =?utf-8?B?MXBDd2k2OTJUZnJUTGQwZFNTVENuQitPbUxuQldrUlFhVWdVaUhwMENRb2pL?=
 =?utf-8?B?NWdLdTJPZWhndmNMTGhkbkQ0Sk54Q2tYRDIvUzlsK0NkSWN0aWoxZDBoOEJB?=
 =?utf-8?B?VVE1YTBKL1gxenR1OG5pSGxoUTJhZEs4ZFg0eE12SnZzSUZnb3lJeGRvYk5J?=
 =?utf-8?B?cDFYU0hrZzJoRzMzckFGbG1NNmJvazZyajV0MXUzQ05RWVllWStWcXVVekxL?=
 =?utf-8?B?UExLSUdCa01WSU90Wm5wVDRMMDNFTklFRVZURU1YR09kOXB3VUFUWUp0R1JJ?=
 =?utf-8?B?ZXpzeWQzdllWQ1ZPbWcwZEt2akNrNXdMdk1wZHI1MmQ3Q2V5UEdQTlNkVDFq?=
 =?utf-8?B?QURCUkk0aUdJeWdVWGhabzhqdkwydFJFUUNDcXFxMG9qN3NSQ0Q1OEd0UGtM?=
 =?utf-8?B?RmtrMWF3RFJtazg2aUc0YTBFSlM2T1VmRFdUYW5xeHY5cjYxd2IrS1M3b1Fp?=
 =?utf-8?B?MGVtODJxNm56S1VHbjcrODdoQWhjVk0xQzNJVVUxa2VDTTQrZEljOWxIZ1VR?=
 =?utf-8?B?T1NVVjN5WHJITXVvVS9UVjJ1ZDY4NHdsQkZNemJaSnErY21hN2M4QzI1Qm9p?=
 =?utf-8?B?dTBFQjRJSTIwMUxDVmJhMFM1YjBIdDBXbFZRblh2cHpoNG9iZkF1ems4ZlNS?=
 =?utf-8?B?VFhnV3lmQzBQcmFZN0ZmRHVjT3g3cDBmNGk3N2ZlZGRhdzc2S1B6ODdqNys3?=
 =?utf-8?B?QzdPS0VMRC85MEU2OCtWalEvYlc5VmwvMk85SFgxcXJ0VncyODNZc25OQ09v?=
 =?utf-8?B?aVdnM0xYdFVjcVJvOERZMkFSdHJmQ0cvdUEraDlDd2JSMEpSNnpCeGExeHFv?=
 =?utf-8?B?VFdKRVU1eWhaT0IvbEZVQ2NsQ2wra3R0TWFpWG1yMUJWQko2Z1VBZ0MyZmpY?=
 =?utf-8?B?a2tJUHlSSGtsb2hNNDM2TFBxM0ZFWnVlZkdkdWtzTVpCRzF4WS9KMGF2L25R?=
 =?utf-8?B?cjJ4dVNSVFMyS2RLMVVobU9uUVdSRHJZMVhxOXVXYW55cGZURzg3RHc5ZHN5?=
 =?utf-8?B?NVNYcVk2N01FckV2OWxQNUVSb0hnNmlJSE9oNHVnRndqMW90cmkxSWFtdHVV?=
 =?utf-8?B?ckh4cUxCbURVdjJpUmYrV1hZekIzUnhsaVBQV2tKcG5jbVl6bm1jdUxnZURF?=
 =?utf-8?B?bTZpVGs5aXhkQ0I1ekloZ2NrdHlDMmc2NmY3UlYxZUg3RnAvT1d4YVVvbXZS?=
 =?utf-8?B?UHBJNTZBd3BOM0NsMnFlZHBBYzZXYjRmT0RyNDNwTmFJUXBVdjdjRDFEREFY?=
 =?utf-8?B?ZW5wQnhNOS9mMEdxaDZXbEl5TEgzRURLVjhzNUZVMndtUWRIeDhXQmR4Q08r?=
 =?utf-8?B?NkU5cTdjaWkyMFZreTdJbTE2cTltVlFNaVBGOTZKd2Q2NHBQaThKcU13YUlL?=
 =?utf-8?B?cWoyTENtT2ZIUFJBU3hWdnV3VjZkWkdjL1ZXYXZoU0p4dWZGU3FSaFBXT3Vz?=
 =?utf-8?B?RVNJMW9Hc25jNGlHbUg3Vnh4U0Jrdnl4SklBMlFXVEJ0Wi9BRWZRdEtEcUpC?=
 =?utf-8?B?aFo3WUlOTnU3RU5IaC9nRmFFUFB6WU9xQU8xa240bWJiNUdLOEkwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff972ce-531b-4b45-2f7a-08deedb7406f
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 21:20:45.0709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MwtBHLWImteP2Dge7JViQ9wy7gjKDvBumg8zSVNFn49y/ZKxR7lKZl0OBIi4ZkQtcPC2zGp5X0OA0Iam/JRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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

On 2026-07-29 12:35, Philip Yang wrote:
> Setting KFD_IOCTL_SVM_ATTR_NO_ACCESS on a GPU used to do nothing: the
> range stayed mapped, so the MMU notifier kept evicting GPU queues on CPU
> page faults even though the app wanted no access from that GPU.
>
> Patch 1 adds a helper to update the fault checkpoint timestamp and makes
> the timestamp atomic so the page fault handler can read it locklessly.
>
> Patch 2 unmaps the range from each GPU set to no-access. Once no GPU maps
> the range, the MMU notifier skips queue eviction. It bumps the checkpoint
> timestamp so retry faults queued before the unmap are dropped.
>
> v3:
>   - Patch 1: fix checkpoint_ts atomic double-read race
>   - Patch 2: move checkpoint timestamp update into svm_range_needs_unmap

The series is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> Philip Yang (2):
>    drm/amdkfd: Add helper svm_range_update_checkpoint_timestamp
>    drm/amdkfd: Unmap svm range from GPU set to no-access
>
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c |   5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 191 +++++++++++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   7 +-
>   4 files changed, 126 insertions(+), 79 deletions(-)
>
