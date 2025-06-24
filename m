Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFAEC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 15:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C1010E04F;
	Tue, 24 Jun 2025 15:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DX3pZrPJ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5DB610E04F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 15:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMVpMvzxgGlgTNSUKPv3XvtgleXFGqlK9hOgLv0oxY5qaqd/2Vv3aJvZWtKR7G97zjVNUXyGZCgAi92yhocW7HIEKsr4tE/XoQ5FtdAIpaNrOZSG+XEzRU3C7hHIGgad/qwOK1S2avqaVJ+wgT4tY9ymL7O5QTYn9OdOK5d+XmY1RqIzCYv4QBkDzMsg6vE75wYkntwAw9B7vqWGV79VHuFWp1MWNqIB11HAY1oRmTgv85bQAydelF0eWS12mfWgAw3rbqp9KK8G7H5NByCbXAEiK3ukEXmoWcctVSiGoWdijgbkG0yocdgtZNn9LctXW9e0Ks+r5XTyyqknR3MPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJWAj3w57LQOG1uY2XxHS3S1TKqiSDh0CXQs1BzqtPM=;
 b=JdLr58ZmKaNJYfr5qDNvWkUn9nprK7Pk0CAb/1/4N2Kl5qXqImIDl87OWZpthpWIbl6ORryN+YldGp+omb91/6XgPuA1/FP1ugQZPMroU2bjJRrTEFpymFFt2Na2zsfPqAwS5SCXAMInFM22x18RsUCTOvmVy7LCHrkXGQGkvXXfdSnh/yFksXKwIWhxqJKMZWk6Ax1hws3UWZajJzmqlErN2n9xO2tFh1Ai+gE7XsIDJCRW+TeRLBm/PbzuGNBWS2aZpV/hO+w9dlMNsmgkZl8pjFyU8zWVfKCeQUijMb26zdUf0Tu1uwZXSYVVx1fM2aMwiKdmSpDxUHIOtHLlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJWAj3w57LQOG1uY2XxHS3S1TKqiSDh0CXQs1BzqtPM=;
 b=DX3pZrPJQbsrd5eImYX3NCQI4WRKxQY7nx5ytnoHxwOf3BwtNXRVQ007XO3qCvROX5f58KpKloQc4H+cwxLtMdd4bFJsyGmIpRab35bRe2CfhV8zqGpA62XMXIxDq2tbWGiiYzS66PHvqVvsHFtGQ76W2+i+7pWmgAjIt1U7+j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 15:18:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 15:18:56 +0000
Message-ID: <6361af84-a911-4e42-a2c4-2419dd43129b@amd.com>
Date: Tue, 24 Jun 2025 11:18:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250623165936.6178-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250623165936.6178-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9009cfa6-0a2e-4799-6da7-08ddb3326fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmoxMjVyWWxvSWNqd3NhMy9EeERZU0tEdGVLLzZVbUdUcVl5KzNqR3ArWHQ5?=
 =?utf-8?B?MmpNUFkweUdyMmp4Q2dEaFkzWjJGS0djalIyU0s0S1pHZDJGbGFqZnBRMk1K?=
 =?utf-8?B?a1gvdHNreTMvK0Y3ejNhajNLS0gweU1uVmdJNHJKNXNSaGJwejI2TE5zWDN0?=
 =?utf-8?B?SzV5MGY2RFdkYmdJMWl5RUlpNTFRcjdkV2o5RTdyTlY3L3JFQmFoRS96RThW?=
 =?utf-8?B?RWwyKzQvUWFyRm1GNFU4OWluZFVHMlEvRlQzaVl4S0w1MHhSaUpwVTcycHox?=
 =?utf-8?B?QUxROUhORGI3OWhoOWMyNHNLdGVCRnBicVk5SHd3SktZbjhoUFU1eVY0eDlS?=
 =?utf-8?B?NU5wQnJPakpFNEx0QnNPQkJxbGFGZUlSeC9vTmlnc2JWTE1qTFd0NUIyTlQy?=
 =?utf-8?B?THZLUjdMYkV5OTllZWcwMGpJaldVYVFlVlBNWHM2Z1RnM01wa1lrU0lleCtp?=
 =?utf-8?B?RVNnV09DeTEyQUs1bVJRd1hkblJjUjFTeWNSMjRodkh0ZVZTdVJOOHpHeU8v?=
 =?utf-8?B?ZzNLa2JGSTZ3SWEvWEVVMVRnNnNaVGdDSCtFeXBNVk1mTVA2U053SDBKcWJm?=
 =?utf-8?B?UUNNQWprZ1lDM3l1MmErWHhVN2hKVzVMcnQzOFROTEtRY0hvaWZsTTFCaGNw?=
 =?utf-8?B?NkxPTVR0MTV5NHBBZ0VmMjVjMjFTM0d3MDFMSXhSUjBub3g3dXFuV1V1NnNw?=
 =?utf-8?B?bDF2L3lMS1lqdTl3REJiQlV2YklBRlk0SUFwMEFhUDQ4eUNwMUN5SnlQcUxo?=
 =?utf-8?B?VERwQkI2VkpVSFFwYUR2eFZKYlNldXV0Z3B0S0pnYjBRcnU0cWRiNmQ1WXdO?=
 =?utf-8?B?d1QyV0ovZGtTMXlGeFNISkhZRjdsTjVvWlBTTzI3NmRxSWN3VVJIdnRrbTVF?=
 =?utf-8?B?aXdtemRzTW5Samk0ZkNHeDNmSnJ1akxLOHJQK3J6RXBHeEpDNVdTWFJIQlh5?=
 =?utf-8?B?OWl2K0VlY0laeFF2eUpldi8xSzEzSVJMYy9PNVFJblo5TURiNWRzWm5kQnd5?=
 =?utf-8?B?aW9zM3NEdmN2cGtobWorOFdha3F4NkgrVGZHcU1jNzNERnk2eWZEU0pQdyto?=
 =?utf-8?B?SUI0aDE3TTV6MEFnZlk4ZjJDUWJKMjZOcWYrMjl0YVhoMUljaHRpZmFxMEZY?=
 =?utf-8?B?MG4wcEx5R2c0OFFZdVFGUUl0ZkZ4L1ZVNnh4ZS9QSnVPbjY0Z2ZKQmV5VUxi?=
 =?utf-8?B?bU03b2NQQTRmZnpNZWdrbFlDNWlITzFYLzgvSk1PNHpibC9YaDBoOFFXZW9p?=
 =?utf-8?B?SkJvYXpNSEVodG9QTHcvdy9vd1k5TjNjb004amxCOS9ydUNrRENRWHJxMmNS?=
 =?utf-8?B?Y3pTejhjWmNrTzM4bG5wUGUyc2NzbGJGNTVQWFQxZTgvWjB2YnhlTjBuOWNU?=
 =?utf-8?B?cnRVRVhiajUzVUQ2S1ZUcEFqL0Z6bGFMQUcxcjA5c0djZWhxaTNOM2tOMzF5?=
 =?utf-8?B?UVJvT1R2QjhDTVpCbmZpZENXZkhua3NQZkpVTm9sNGJncVVHM09TNGpIaUkz?=
 =?utf-8?B?YjVtVnNRbW0vYmlSR1Q4SGtYdkZVdldtUStPcWxmS2w5NDVjYzlGQmpIdVp6?=
 =?utf-8?B?NVNFeGtqWllyenRUTWMvQ0lUNVpjeHd6aENFdjBvc2w3OE1lT01Ld2Qwa3E5?=
 =?utf-8?B?c3pqYXpEcU1LU1FSSGYyTFRLU3lBQlVPL29GTWxQQkVzdlpzNzU5WlFPU1Bj?=
 =?utf-8?B?YWZ0WWtUejQxbDVVQ1BKL2VhUmZjT3IrZENjMk13UDdLM0tJZlhiTXlwdmxD?=
 =?utf-8?B?cVlKb3BFbGp1NmZmOXJDZlFQZWV5bEFobUtPU3ZWN1RPK0k3ajM2dEtiZjFl?=
 =?utf-8?B?TnJ0eEtWYy95YUVOZGFmTnNZWm1qcVkzWnJlbXlkS0FGZXNnUU1ZdW45OG42?=
 =?utf-8?B?S2pRK3h6amJSUHlrVXFJV2Z0eXZMMnE4U0diTGR0eGpGRHRwcHBrUXBCTldu?=
 =?utf-8?Q?xKBRHV8x0AI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWF2SmdudmN3LzZvRXJaUlNCTzVRWitvWkdnb1NodUJQd0wya1ZoMStaaUp2?=
 =?utf-8?B?Si82WC9xTUUyUzNYYzhuZ1lNbnVsZUlDajVOWWRUNUJCY1grRCt6U1VqdXZU?=
 =?utf-8?B?cWF1M0x2RjYzM2s5NFZNbVNwUS9EMVZ3TTVYU05rY3BidDNFblVwTTk5a1I1?=
 =?utf-8?B?RmQ5WUhJUHdYbHE0RFhpdDZ4eUdGK0lEYTA3bnlMQmZQYStiY2tVdlRINURM?=
 =?utf-8?B?Ynl3L1ZUYWc0d2JWNjAvMXE5VWEvc215QjBxTS9TSzRRZGJjMGxLY2J4dHdQ?=
 =?utf-8?B?YmtVN0huZ2RpT3pJdXVURnVRanBlT3E5VjFIQUlXT0ErV2pGTGJnMXJUeGNZ?=
 =?utf-8?B?US9iQnd6OW9NeUJFbHBoTWh6eDMzbzZLdmFPdWZTa09uYm9ySTl0UjJhSkRL?=
 =?utf-8?B?L0F0YUYyK3Z5aytKOEFNTWwzb0YxdTlXbmsvS0FZbkt5MUtFTkNSZnN3SlVO?=
 =?utf-8?B?NFFDcUFWeWh6KytqUjAxQmhmYzJnVE1vQmtlZ3ZYMVVXS1JaUSs2NXVWR2hO?=
 =?utf-8?B?RFBWdGdiVUx4eVp4K2ViQXlvMjBRcldZQUU4d0xXUFhvQ0tyMDRTYUJVK1lV?=
 =?utf-8?B?RzA5WEw1QUdDNjBmaXZTOUJCL3NUSHFzczNiRzQyY3VoS3pSdm54b0R3QmpP?=
 =?utf-8?B?N0V2bThlVW9LQU9hSlB3YVNMNGxlUmNGYlpnbTBKcmJYbklFRnpFT0ZSaHN5?=
 =?utf-8?B?Q1lyVCtBRGZzQkZKMDR4ZU4vQVU1VGJqemN6eDZJb3dzRms2RGNEUGFCL0Nn?=
 =?utf-8?B?YXl3cTYzd0ZZdXhmVzJOZ2orVitjc3VjUmRoVVZCN1QrT2IvWmtjamdwZ2lB?=
 =?utf-8?B?THFMcmN0Qy8xZ21MU3N2b2FHQXlSWitsb2l6dGdtdnpNbmJmUHl6YkN4Rjhn?=
 =?utf-8?B?OWFjYVNVakVLaFpPOTRlTXNJa21oL2ZlZDB6T3FkQktUSTFEemRlbmpsRmdm?=
 =?utf-8?B?aUR2dlBiWHdSVkFlNzNwL0gzSStFbzgyZndTclpuMkVSK1VhRzVLVjAxWWhn?=
 =?utf-8?B?ZUs1b1g0QzBYUmNSWGdOOXdodjQ4c25RUzZxUFpzM3JYUU01b2hrN1FiYmFE?=
 =?utf-8?B?ZDVKc0crSWZ1a3R3a1hPamNjdE9xTm1mRmhsbURudmRpWWR0dzhueU1NVXVq?=
 =?utf-8?B?V3hLcEVPRjl6dkRjcUQ0Q3JkM2o3RXh5L0ExVEY4ZWtmcDQyWk9XMjNLVnBT?=
 =?utf-8?B?amhjWENWSzczRDdCQ1BHU05panVnV0Uzd0lUcXlBUmxOZmNWdS9hQmF0SElD?=
 =?utf-8?B?YVNiZE9lRmNRRUtRNHh2NXN1S3RsdU1OVWM0aGdpaUlBUEQvbk54cityR213?=
 =?utf-8?B?aFNRR0JOUWZTeEtNSVFzdUVCcERMcXh1R1FHN0RJQis1VkVzVHpValU1clh4?=
 =?utf-8?B?YW91TDRIS3pSNWJkRGF0THh3QVRvK2JwczY2OTVXcnVSZ2M5dGt5Vzg5SjVv?=
 =?utf-8?B?VzJUYjBPK2xzSGZldDlpWk9NdGdHdUNZM0hkVGVjajkrY2x3a21EbkxzcWVE?=
 =?utf-8?B?cE5zREJuVmdxRERvckRwUGdLWWtNS1hjbjRCeGhLWDdkemVmalZDNVAzWUhN?=
 =?utf-8?B?VUFWVnlhMmVjT1VCekVCazEramdPM2VDa3JzTTZGYUJndm12LzBkNTlHVml4?=
 =?utf-8?B?cU85TVRoOWpHYkNPYWU3VlhUMEV2aEp5Tk1NSXhIUVlwa3J2TVJvQnViNUZS?=
 =?utf-8?B?TWI2MXJld2JtcGdVTllqa0Y3K0NrR2Rodm8rMEd6SDR0YVEvZk5CdTA1b0lX?=
 =?utf-8?B?UFBneVQzbnlaVy9OM2JXV2lMTzBnd0cxaWIzMVoxUmhGREM0ZFFPT3N1MGxS?=
 =?utf-8?B?bjVaUVljUnVCRGU4aEhWeHhiSHJUbXhXL0s0WWQzMlJiNDVkb0J6OTA5NUh6?=
 =?utf-8?B?Si9UMEE5MnRYczVyUXdsQWlPQnJiNFB1ajdaWHFxVzlxeFczTENuSndtbjd1?=
 =?utf-8?B?WnJIeUdiQUY3a0JoTUY2bHVqSFJTQ01MdjdQd1dzYnZPeVVjYjhaK0FZa3NW?=
 =?utf-8?B?MjBDRWVyZzB4STJmZlk1bnBiVDgyQ0RkanpCdG1MbERKYWI5ZUdjUmJxU2Na?=
 =?utf-8?B?UXdNWnBpQytSV2pLaStGR1FDVWlXMXFKM01nQ0FFem9YbTY2djh4YkhYbnBz?=
 =?utf-8?Q?eQUDOAGfG0/qhJgFzbv7mqmnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9009cfa6-0a2e-4799-6da7-08ddb3326fcf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:18:56.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS1SAS1rycy3ec73++DmcSwClxNm1MbWKOxKm1e9+KH6gtP06t+v4LJbKbQ+f7SfCS+dbGNd5hpzY+GGWNN8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001
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


On 2025-06-23 12:59, Philip Yang wrote:
> If the process is exiting, the mmput inside mmu notifier callback from
> compactd or fork or numa balancing could release the last reference
> of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
> with below backtrace.
>
> The deadlock will leak kfd process as mmu notifier release is not called
> and cause VRAM leaking.
>
> The fix is to take mm reference mmget_non_zero when adding prange to the
> deferred list to pair with mmput in deferred list work.
>
> The backtrace of hung task:
>
>  INFO: task python:348105 blocked for more than 64512 seconds.
>  Call Trace:
>   __schedule+0x1c3/0x550
>   schedule+0x46/0xb0
>   rwsem_down_write_slowpath+0x24b/0x4c0
>   unlink_anon_vmas+0xb1/0x1c0
>   free_pgtables+0xa9/0x130
>   exit_mmap+0xbc/0x1a0
>   mmput+0x5a/0x140
>   svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
>   mn_itree_invalidate+0x72/0xc0
>   __mmu_notifier_invalidate_range_start+0x48/0x60
>   try_to_unmap_one+0x10fa/0x1400
>   rmap_walk_anon+0x196/0x460
>   try_to_unmap+0xbb/0x210
>   migrate_page_unmap+0x54d/0x7e0
>   migrate_pages_batch+0x1c3/0xae0
>   migrate_pages_sync+0x98/0x240
>   migrate_pages+0x25c/0x520
>   compact_zone+0x29d/0x590
>   compact_zone_order+0xb6/0xf0
>   try_to_compact_pages+0xbe/0x220
>   __alloc_pages_direct_compact+0x96/0x1a0
>   __alloc_pages_slowpath+0x410/0x930
>   __alloc_pages_nodemask+0x3a9/0x3e0
>   do_huge_pmd_anonymous_page+0xd7/0x3e0
>   __handle_mm_fault+0x5e3/0x5f0
>   handle_mm_fault+0xf7/0x2e0
>   hmm_vma_fault.isra.0+0x4d/0xa0
>   walk_pmd_range.isra.0+0xa8/0x310
>   walk_pud_range+0x167/0x240
>   walk_pgd_range+0x55/0x100
>   __walk_page_range+0x87/0x90
>   walk_page_range+0xf6/0x160
>   hmm_range_fault+0x4f/0x90
>   amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
>   amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
>   init_user_pages+0xb1/0x2a0 [amdgpu]
>   amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
>   kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
>   kfd_ioctl+0x29d/0x500 [amdgpu]
>
> Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 10d1276f8e1c..5fe92f9a1ce1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>  		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
>  			prange->work_item.op = op;
>  	} else {
> -		prange->work_item.op = op;
> -
> -		/* Pairs with mmput in deferred_list_work */
> -		mmget(mm);
> -		prange->work_item.mm = mm;
> -		list_add_tail(&prange->deferred_list,
> -			      &prange->svms->deferred_range_list);
> -		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
> -			 prange, prange->start, prange->last, op);
> +		/* Pairs with mmput in deferred_list_work.
> +		 * If process is exiting and mm is gone, don't update mmu notifier.
> +		 */
> +		if (mmget_not_zero(mm)) {
> +			prange->work_item.mm = mm;
> +			prange->work_item.op = op;
> +			list_add_tail(&prange->deferred_list,
> +				      &prange->svms->deferred_range_list);
> +			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
> +				 prange, prange->start, prange->last, op);
> +		}
>  	}
>  	spin_unlock(&svms->deferred_list_lock);
>  }
> @@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>  
>  	if (range->event == MMU_NOTIFY_RELEASE)
>  		return true;
> -	if (!mmget_not_zero(mni->mm))
> -		return true;

I looked for other uses of mm inside svm_range_cpu_invalidate_pagetables, and I found this call chain: svm_range_cpu_invalidate_pagetables -> svm_range_unmap_from_cpu -> svm_range_unmap_split -> svm_range_add_child. It currently assigns mm to a work item without taking a reference count. But it seems that mm isn't even used later. So maybe we should just assign

    pchild->work_item.mm = NULL;

Then we could also remove the mm parameter from svm_range_unmap_split and svm_range_add_child.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>  
>  	start = mni->interval_tree.start;
>  	last = mni->interval_tree.last;
> @@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>  	}
>  
>  	svm_range_unlock(prange);
> -	mmput(mni->mm);
>  
>  	return true;
>  }
