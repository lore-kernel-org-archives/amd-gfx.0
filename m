Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433CCAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 18:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 906DF10E1C8;
	Wed, 17 Sep 2025 18:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3k3Eej97";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011068.outbound.protection.outlook.com
 [40.93.194.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A03110E1C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 18:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9teGrCSJKR89dhN0uGIUaG6CsTb4dOfN36S4RQGbY7ggykfNPLWf+fXNCGrHWVBdEtGm/QVSVPmOQu7sDOZRyCpL6ZDbdNIkcpwSufYa6Qxt8GsjCk/3RpfFUQlTJ/aqo/RQUjKug/A2PTLGjmulHANQC7hevcFVfOpeWgclm6N2Nh8W01CCvPTrEd59kVcsosCdb7qhZuLqZFvAnqleDHx3shCDywjQP0/ZPp6/PaxamGNFXGr/7vKv7mfCHl5Xxsnc083A2MrcfV9w3agQvnhM+P6Bded6uqNQIOsMdN2mvZdb7jDp7KSmZVaBRHcggiu9C1s5f7BoxsLxnqbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnfHmrXYqaVP3IGDDiPxq1Rd5JB3IGYC/X/1HqR00es=;
 b=lApnLrJMPR9/KqcRL3qoLAlI1M+hSnvmQAPd/NKHrR11vJZjZm3g85B7MWSs1pCvqhhtev3Rvk/JpF87UN5k7isyAxWFX9SPBmy6QE7dCur+6HBigYuGS+9cqqktVAigRnthPNQbeMvEDoCX6Lq35API/+EaINxaYPTvv/mMSzG2UzAVCxDHim9ld2BQtoLchWYLykK93JfG2xtwCkzjT1ThnjRjWb+DRC0ktBwLeKtOGOUE5Jt1RqtuafRa9DKQqTX22crPms6qdViKi6hb9KtuYJdy1KGDGyJK0ROe+JQB0U+zY6SFnqZJijl1bd3mAVUzcpJ4T1qufQmyRmP5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnfHmrXYqaVP3IGDDiPxq1Rd5JB3IGYC/X/1HqR00es=;
 b=3k3Eej97f5MetitQc5MbbuTwxE+e6wsZUgEb1dZiGrPtRxoL9qT19wop2zFCCA+rh0WxMiB4Fyb4mpsHMUaQFzWbltRcy1zAI7BSTKVEJXiy6dx48d66G7prSUwOoE6GIZ1/pAxI8EgI+bj15XO0WnbbkZ6tO8GFzTM9NjagJIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 18:21:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 18:21:15 +0000
Message-ID: <dab2b252-d6ac-46e0-8fa7-ec8a4bd55865@amd.com>
Date: Wed, 17 Sep 2025 14:21:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use hmm_pfns instead of array of pages
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917172201.3874839-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250917172201.3874839-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: d6574f58-39da-4f5d-e04a-08ddf616fd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3ZzcGdtMGNoblN1VzgvMERNb0dXakQzYmg4VXZPbnl3MjlaeWprYmZPYnVP?=
 =?utf-8?B?WkRLWHpxME5IVUlFUzhKRVlSKzhiM1VqWnlSVXI3TUVMbFZPVENQZlNuRW91?=
 =?utf-8?B?NWZSeDJjdmpyUzBpN3lQOTB6NmQyN0cyVUtvckhPdWY5TlRITExzWnI0SWtP?=
 =?utf-8?B?cmRVSUtENTJibnVnUzZPczdlc252TDBodkNsTFlMVzNDVi91NVFDMUhMTnAx?=
 =?utf-8?B?eGZnazNLWHRKejAxWmtBWjU5eTF1V1lKYlI3bytyeU5LK3d1QTJPcC9aM3Vo?=
 =?utf-8?B?Q2tHRDEwRDRVcEs5d2dRLzJ0RDBUa0lnNkpYU0hSbXhRWk9QdGg5QlJ4UWdH?=
 =?utf-8?B?QkVyTUVYK0tNMzF6WGNHRG1Bc0R1TUE3RmV3RmYySk44NDArVDYrbm9QVEdC?=
 =?utf-8?B?NmRrRnd2Ni9yZ1o0WHFldnNDbzkzVVlTWW53VkJkQ3hBQVhJZ0MvdE12a0tM?=
 =?utf-8?B?T25XZ3JwaHV2dm1MczlOdkEyN0lHY0NXaUx1VGVRTUlLRDJyN3N5c0pTS0NW?=
 =?utf-8?B?TU1NdnBpbERNUEwxTUFrK20zWFhWeHlEOWo2dVZtM0k0ckc3S3JZQ09BTUg2?=
 =?utf-8?B?cmpKYnJmUUViaThuUXhocFVEbTBLY3JKcWNPMmJqaU44TGxvVHJURW1XRnpv?=
 =?utf-8?B?U0JZOFhQZDhlS3N0MjdvcHB2di80TmpDK2xqbW8wWXVZRzlya1ZUYUJQcytx?=
 =?utf-8?B?ZzJCNVgyM1dRMDVKZFpteVpVbGFaczUvRVV6MTd6NWpkcmlwcUhzaGN1dHJr?=
 =?utf-8?B?UUtXYVlXREhlUkZUd3piemJPai9obmlwMUNaTXBMYXI5Mzh0S1hTRUFORUtr?=
 =?utf-8?B?cE1ydlBvalJGcytiNFkrOHBCMWlyanp3RTRsakNVcm4yeE1ZR2duRG15Lzhi?=
 =?utf-8?B?Ym9wV1F2OWFqd0w3Y0p4SUNYR0ZKekZSNWg3ZXV0UWFCRm91SXZiN3prUmsx?=
 =?utf-8?B?dXR0WUh6UUpqakp2WUQxdnlNUHF2SExyK3AwclZOeEhBOGxhSkJQeEFpVUgz?=
 =?utf-8?B?NllhRURab3FkM2ZBVHk4d1B6WDRGZ09JbEtjTHp1OUtoZ3JPRm5Eb1d1dERj?=
 =?utf-8?B?VG5DVW1MaXBjVFBMdUE1MVEzSkJZcVpFUUJzT0xPajNqMlhGNitzVVBWbkZG?=
 =?utf-8?B?R2Qzb1I0Q0hDeDJCcVpNZEcvYThpYTYrcVZFZWlEck05Uy9hZWtQT2pFa2hq?=
 =?utf-8?B?eHcyQks2V2RhbTVWZHphV2pUOXhKUmpTOUE2eUpkWDNiMjNHRCswQzgvdVpp?=
 =?utf-8?B?SCtSTmdGb3B6T0ZGdXlDSFJsNnc2VHdJMmRmSG1tMk9STzFJMVQ1Yzd5cHhD?=
 =?utf-8?B?bzdFaFl2R01Bb2NFK1N2RzBZNks5VER4SzhKZ3B4M2VPdStnVmhtSk9lb1B4?=
 =?utf-8?B?b01CNEVzM3RuVktBeGFyWVVucFFHWUdNbUpCY3prTlFTQkpXWFdlbmlrRGVy?=
 =?utf-8?B?MVd6Y0crTzRmUkFKOW5NNGIvS0dtMnR0Z0FWUnlBVkw3SnNiU0NiMXJuYStR?=
 =?utf-8?B?bEZGQUIzaThFQUtlUm13Y3ZmREdXUGhHeFZNdkJBVUFsMGk2b21XbkJHTXpN?=
 =?utf-8?B?aEYxREhudEdqUFZCUG4zd05Va3NBY2N3VXFKU3BzTXZURzVlakVEUENjUWZa?=
 =?utf-8?B?a2hQMDhMSVJ2Y3JRM3pBejVVRHg0TC9ERi9JbDFqMkY2Z2NmT1B1REUyRmx2?=
 =?utf-8?B?cUFNRloySHBCRXFnQXM2d2tDN1NLbW01YkJaMGc1TDRieU04b3lPdkpmOEZK?=
 =?utf-8?B?RENBSi9sV2wxeUVuZW5ZbFk4WUlHSlBLdzJTbHdNMDVLNENpMVZTN0h1dzBs?=
 =?utf-8?B?T3lRUDh3OGN5amo1Z1VjOXZLajh2R1NmSmg5NEZ4bjdMQlJDaTNmZVh1c2sr?=
 =?utf-8?B?TGoxRVJjNXJIVWRzNnpiSU0vV0x5NzlsbURNOGFWTDJncG01SnRtRXRBRHlp?=
 =?utf-8?Q?GXVyb4Epz8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm56QVVKeEtFTzBuY2xORGZ2cld1enZxMmk3TDhxWmtKb29Da1g0eUpibEVh?=
 =?utf-8?B?S3Z0Q3lnWTdvVktMd2V1aFBBeXdzMy93VFkwZDZ5RzJJMVZrMlFCdHBFZHVi?=
 =?utf-8?B?YytxZW8wbzJZZTZ5aE16Mjk3STY2MWM0OUQ4dy9KVFVtUXMycXFKRzFySy83?=
 =?utf-8?B?TE0rRmF2aGE2OGVIL1IrVWl4cjRqVkV4OVZaV2JSYnVyOWdWUXZXS3pucUtY?=
 =?utf-8?B?Qkk1ZFppU3N2Nk5UanlHNG5UL29XekFITnFvRzRuaUVyNE9aVldMQ054eVJn?=
 =?utf-8?B?ODJ2QXNKZWpmdkRzN1BxbWFyMytlQnYvekt0VkIvWU5MQ2tQSWI3Vkc1VkJr?=
 =?utf-8?B?TE83ZUtjci9HbnUrd0RDQWZ3cFZlNVlCQ0hESVRMVmxwR3RCcCtWODRnRVdX?=
 =?utf-8?B?U3Q1czJZVlBVQ1dLNHUyTHZMUkdHZ21KRDFrSW1aMHByWGRGVmY1OW5DaUpw?=
 =?utf-8?B?eENibDJ4a0c3eWxySEJzeFRIak9ja1JVUExoVzNxdHN1QzF5NzZaZ05RT1FV?=
 =?utf-8?B?Vzcva3o5bFMycVg1NE0yRUxrMEVJazhjT1FkL3hQbExpNEFwb2dWNHFpSUpu?=
 =?utf-8?B?WGt3N0lMM29qby9sV1k2SUtLNXZGZDZCN2ZXV1VMTkNJOGo2TXdwOGhaZnhN?=
 =?utf-8?B?UWI3WFdrSk9yQzFnSkFrZDRvbUxKWVhBd0tzYmVFeGVtSmJadlpuVGswaExO?=
 =?utf-8?B?eFhYNXpjdzBOYkt4T0RVYm8xS1RKWmpudXlyd2tHb2xWaWx2dFp4aW9FU2Vt?=
 =?utf-8?B?U0hYaFZZcUJNSHp1c25Da01rR3dUZUxYZ2ZDT0NheCtOOEN4QXQwaUpVb2tN?=
 =?utf-8?B?NDIwdzFYMXJZSy90UlRjc3ZiWGpnT3djV3IvRC9iYngxSjFsNFNlU1dmaDFG?=
 =?utf-8?B?ZkR5UDhhMVdNeklRVGF2R3JJQUtvTGtQWWFSdkxOb2srK3ZXcHZCNElNVzlH?=
 =?utf-8?B?dXphMGRDb2pWL3hkMWgwOG5reHF2UU9LMDZ2V1h6UGFFTUpkcDMwR3hHQ0x4?=
 =?utf-8?B?Mm1XbUs4RERUTTgrR0YxdWNHdXZ6aXI4MFhibGQvRHRHN3hKbGt3K0V1ay9O?=
 =?utf-8?B?QmpwZ1ZKcTdKL1FkbDhISnJhQ2JSTlpPNDBUaXVXRUQ3TzJ2MVM1czJFaXhK?=
 =?utf-8?B?Mm1nRFNWZERpTm9tK0tqSS9laTQwYXY0UjVZZTlmQVQrNDJRRmx6Qk9ERmgv?=
 =?utf-8?B?Y3NxekxiWUROaG1WNktYRXE2Q3JBQVBXQmJ0OWYwN3o2Zi9EQ0hycnllY3pH?=
 =?utf-8?B?MEVBNDBzRGxFS2pBa245YzFmakJTc2x2N3U0WnpGVTQrVytESFhMLzVYY2l6?=
 =?utf-8?B?YUxsQUY0WVRBUmNpd0kyaFpSVFhPd2lyalRtaE92cnNPRmYveXp1YUl0N0FR?=
 =?utf-8?B?SDhreHBYUnNUVlI1a2tqMWEvaDJFWExseENSTTU2cjJXRTJnN3Q3OWJ3TEpZ?=
 =?utf-8?B?SDV1cHc2ZkpLa2FiaFFjQzlxZVIvNGE4anIzNWhQckdsTnhsWUlWYndDdXBt?=
 =?utf-8?B?NUJZek1VK1FUM3p2NTVMdklUUkw3RXBzdmI4N0d4elZRaitsNVNwWVM2NUNG?=
 =?utf-8?B?eTZ1VUpQcFU3ZFlEL0FDUk1SaCtRbHJhOVUyMEtJbnpXTkFTOVVrZjlZZjZt?=
 =?utf-8?B?ZGZEN1Y5YWNBbk1hZGZHKy80UWRxUFJLTm5zTmVHZmFkTnV6VFIzSDV5Rng1?=
 =?utf-8?B?eTZDUkxFY1NsY1JVZ2F3VVl4ZmJmUUs2R2VqSlp0eGY3TVd4NjBEU0NKbDAx?=
 =?utf-8?B?YTBTMEk4cUZUbVAwWWFmTUVjY0dvYlZ5REZsTU52Z0NIL0NOT2xLaWZsbm8v?=
 =?utf-8?B?U1BPVzBhUUxHQjEyVzlTeW9BVVQxVnhzLzVLN1VZRFdYanprVkM1aHZnNUtm?=
 =?utf-8?B?RlQvcEtvOVNZTWZvZ0VqUU1ONVlsRThqc1lzQS8wZHptejBDajN6ZnlCNjU1?=
 =?utf-8?B?VmY5MCtlbkNYeUpLcnVUSlU0TFpCbDdZNVFGYTlOQ1ZkWXVaYUlGdW01ZVdw?=
 =?utf-8?B?MDZrQ00veTdqZFdsNm9kN21oa0loZnpBS0c0MlE2T0E3dTM0bDd6RHV2VDMv?=
 =?utf-8?B?YVFVVHM3cGROREhQazN4UXZBVjJjU2NTTXNnblZKUHRNdDFtK29lS2FpS3Zx?=
 =?utf-8?Q?cE2ZkakVoYnc2BmNASdvc+FiO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6574f58-39da-4f5d-e04a-08ddf616fd2d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 18:21:15.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfWiofrZz6wHOg5fChGKX9h1WJh6Q/EsjlZSi5cxDsQ12DzTz+/gNpphaT0JK8Hk80Peodd07sL7D6R0sobX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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

On 2025-09-17 13:22, Sunil Khatri wrote:
> we dont need to allocate local array of pages to hold
> the pages returned by the hmm, instead we could use
> the hmm_range structure itself to get to hmm_pfn
> and get the required pages directly.
>
> This saved alloc/free a lot of memory without
> any impact on performance.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 10 +++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 30 ++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 10 +------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  8 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  5 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
>   9 files changed, 25 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c3b34a410375..7c54fe6b0f5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		return 0;
>   	}
>   
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>   	if (ret) {
>   		if (ret == -EAGAIN)
>   			pr_debug("Failed to get user pages, try again\n");
> @@ -1103,6 +1103,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		pr_err("%s: Failed to reserve BO\n", __func__);
>   		goto release_out;
>   	}
> +
> +	amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +
>   	amdgpu_bo_placement_from_domain(bo, mem->domain);
>   	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   	if (ret)
> @@ -2565,8 +2568,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   		}
>   
>   		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> -						   &mem->range);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>   		if (ret) {
>   			pr_debug("Failed %d to get user pages\n", ret);
>   
> @@ -2595,6 +2597,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			ret = 0;
>   		}
>   
> +		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, mem->range);
> +
>   		mutex_lock(&process_info->notifier_lock);
>   
>   		/* Mark the BO as valid unless it was invalidated
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 555cd6d877c3..a716c9886c74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -38,7 +38,6 @@ struct amdgpu_bo_list_entry {
>   	struct amdgpu_bo		*bo;
>   	struct amdgpu_bo_va		*bo_va;
>   	uint32_t			priority;
> -	struct page			**user_pages;
>   	struct hmm_range		*range;
>   	bool				user_invalidated;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index defb511acc5a..744e6ff69814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,6 +29,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/sync_file.h>
>   #include <linux/dma-buf.h>
> +#include <linux/hmm.h>
>   
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_syncobj.h>
> @@ -885,24 +886,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		struct amdgpu_bo *bo = e->bo;
>   		int i;
>   
> -		e->user_pages = kvcalloc(bo->tbo.ttm->num_pages,
> -					 sizeof(struct page *),
> -					 GFP_KERNEL);
> -		if (!e->user_pages) {
> -			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
> -			r = -ENOMEM;
> -			goto out_free_user_pages;
> -		}
> -
> -		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, &e->range);
> -		if (r) {
> -			kvfree(e->user_pages);
> -			e->user_pages = NULL;
> +		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
> +		if (r)
>   			goto out_free_user_pages;
> -		}
>   
>   		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
> -			if (bo->tbo.ttm->pages[i] != e->user_pages[i]) {
> +			if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
>   				userpage_invalidated = true;
>   				break;
>   			}
> @@ -946,7 +935,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		}
>   
>   		if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
> -		    e->user_invalidated && e->user_pages) {
> +		    e->user_invalidated) {
>   			amdgpu_bo_placement_from_domain(e->bo,
>   							AMDGPU_GEM_DOMAIN_CPU);
>   			r = ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
> @@ -955,11 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   				goto out_free_user_pages;
>   
>   			amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
> -						     e->user_pages);
> +						     e->range);
>   		}
> -
> -		kvfree(e->user_pages);
> -		e->user_pages = NULL;
>   	}
>   
>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
> @@ -1001,11 +987,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   		struct amdgpu_bo *bo = e->bo;
>   
> -		if (!e->user_pages)
> -			continue;
>   		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> -		kvfree(e->user_pages);
> -		e->user_pages = NULL;
>   		e->range = NULL;
>   	}
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index a8fa09184459..8524aa55e057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,8 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		goto release_object;
>   
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> -						 &range);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>   		if (r)
>   			goto release_object;
>   
> @@ -580,6 +579,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		if (r)
>   			goto user_pages_done;
>   
> +		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +
>   		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>   		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>   		amdgpu_bo_unreserve(bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index e36fede7f74c..4441572d6ad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -167,7 +167,7 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>   
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner, struct page **pages,
> +			       void *owner,
>   			       struct hmm_range **phmm_range)
>   {
>   	struct hmm_range *hmm_range;
> @@ -222,14 +222,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	hmm_range->start = start;
>   	hmm_range->hmm_pfns = pfns;
>   
> -	/*
> -	 * Due to default_flags, all pages are HMM_PFN_VALID or
> -	 * hmm_range_fault() fails. FIXME: The pages cannot be touched outside
> -	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
> -	 */
> -	for (i = 0; pages && i < npages; i++)
> -		pages[i] = hmm_pfn_to_page(pfns[i]);
> -
>   	*phmm_range = hmm_range;
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index e2edcd010ccc..953e1d06de20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -33,7 +33,7 @@
>   
>   int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner, struct page **pages,
> +			       void *owner,
>   			       struct hmm_range **phmm_range);
>   bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4e2486dbc0a6..280400b13c54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -707,7 +707,7 @@ struct amdgpu_ttm_tt {
>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>    * once afterwards to stop HMM tracking
>    */
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   				 struct hmm_range **range)
>   {
>   	struct ttm_tt *ttm = bo->tbo.ttm;
> @@ -744,7 +744,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
>   
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>   	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
> -				       readonly, NULL, pages, range);
> +				       readonly, NULL, range);
>   out_unlock:
>   	mmap_read_unlock(mm);
>   	if (r)
> @@ -796,12 +796,12 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>    * that backs user memory and will ultimately be mapped into the device
>    * address space.
>    */
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages)
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
>   {
>   	unsigned long i;
>   
>   	for (i = 0; i < ttm->num_pages; ++i)
> -		ttm->pages[i] = pages ? pages[i] : NULL;
> +		ttm->pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index bb17987f0447..6ac94469ed40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -190,7 +190,7 @@ void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   				 struct hmm_range **range);
>   void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>   				      struct hmm_range *range);
> @@ -198,7 +198,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>   				       struct hmm_range *range);
>   #else
>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct page **pages,
>   					       struct hmm_range **range)
>   {
>   	return -EPERM;
> @@ -214,7 +213,7 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>   }
>   #endif
>   
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
>   int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>   			      uint64_t *user_addr);
>   int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 68ba239b2e5d..273f42e3afdd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1738,7 +1738,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   
>   			WRITE_ONCE(p->svms.faulting_task, current);
>   			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -						       readonly, owner, NULL,
> +						       readonly, owner,
>   						       &hmm_range);
>   			WRITE_ONCE(p->svms.faulting_task, NULL);
>   			if (r)
