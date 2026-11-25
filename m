Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098C606A683
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X1SaLFoQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21BC710FC70;
	Wed, 25 Nov 2026 13:55:15 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348FC10FC74
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 13:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0Af3OZOUIFO0ux18i2m3O+zMTiEbESclm3/dcfJcAwsDfXSKI05FuYXe0ZT+m4KipoNHxknxy74ze5iUx/Asu370sGHpMbHxu7rA7VRzM6lfMN/R34kFe6ZSUY4hRoqC3oPg579pQTryUEd4nKoSV9GHokAwldu7/E/4EZH4RLdWou5TlRpEa9kEJYeNpHJZ5dCIutcuzfFPchNwQFZARRzWQiBUHlSBKfMvBP6DRRjOmht+LCGI1u9tnOyWuwVOYiTlQd9x442VndxNbdk3BETCD2ogXxrdsTMGucpYKDnSSiEHE7yOfrMC82HEwDG+OxFeTBP3pLisQ/Z2Qf2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkkO0voqy3h07U30k3pMNm8Myb9ZkGnwmNTwviX7mM0=;
 b=LAYIzF8W4lRgY1hcVRpMQcUrON/lUjMmvSnhzTYBoqca6yUwfjfq20YTrAD9mPkqp0dxTkYMOK9TDb7sd0y1Q+XjycQFdcGMBeO37qILHRYarb1AWAYIi/tsu0avmPwxg4jGM5AYfGPPoA4lAVr6CBkRHDRl9Ea52RSjdxi/N2SJnjHF+eeMRWrMQQ86//u0PxmvUqCLWr5AF6rvLrXtLU9sVnKYunkCLw4hymdrCHFWrlZ1gsneJiZid6GkgsGzRIjLTdhwoqfpyZUc6Fnn1ArAwHYKU0U7hX9EVexI5FAOOzsORtsVQ1WV/c4WLSpjwFsiHLt62gKSd2ENsmCm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkkO0voqy3h07U30k3pMNm8Myb9ZkGnwmNTwviX7mM0=;
 b=X1SaLFoQyBQBwTa7Ff5lSv3Yd57hvYBc65xOWzFP1LbBZeeYdGDCITUmKVRbV6QM0afGtV1fcLrSF8WVsjrg0wUM18wgT4DykQ0u7Tlx2rquYG4qBp4UR4c1kw0nZ592delPhCQ+u+GWipZQeY/MZwnNxFywrgTPQ/WbzwdYx9Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 13:55:05 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 13:55:04 +0000
Message-ID: <100cb94d-66c9-450f-aad2-eac5c3c0c5c7@amd.com>
Date: Wed, 25 Nov 2026 14:54:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: track finished page table updates with a
 fence chain
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261124044544.3561866-1-chongli2@amd.com>
 <DS7PR12MB5768B725FF09752C9BD1E1F59B432@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB5768B725FF09752C9BD1E1F59B432@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:32b::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: c1beef38-b578-4bd7-8985-08df4afbb50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261009221227099003|261009223027099003|261102123227099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: n4SaDPeuMzTsodqzSI8ZJxh8qT+F8ZwMN8W566oTxukeOtNgh6LU7EVVvkD/CF+Dbr7I50f+zY3gofRp9qSpXQAaF+Rk+iZXkC5Bp+YybJoAZEJT2IcCb4yrEE1CaS0SadmSEywDe2JG5tH2F5rDtxtr2sVR4MG7fRldUwRTTNve/g9sYHG9LyHeoNlMeoEyCnhIhr5PcNsQTX58FMXWgD6p1ZMg1SdHHJfDQJOHEgceOsdHTA/rUIniR2F0efz+35ja2gFgIOVXIfKnmfUrZejhJDzNugP0qVMxllx1GHRCzVELiMkzm/Lyu7D13iZwqFP1n2e4w9ArQjBgLQXQnMznO6gR2PcBZFtijkl3hV/78IoLNaRxfz1vsvlJ+ameoOFl6RFUvO5pu2o0eZWvrpq0Qz9jbkU8hPpkqwQhqi9XJcFknwkQS1YY6dDCrTh/Bc3KzAPz2N1HX0nNnkBXG296sy2c6hrinW01AtvSH2bXNdmEebipX/vmGLtHgEGpZndsZOpYjQ4P1qKFIINLMBbxKc/Amw3I04oq6+0OTsPrRqCA7wEX/XkOB8ALSJ58aGb6NZhrAyiYeie6pPUV3qOV6Q5AYaTPRszu1PqwnExO1UsdPhSd+0Y8ccAFIx8hYbbfb+npMNQz+QWe3z9oaXTp1yBAUEdr0lJkJTENOrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261009221227099003)(261009223027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUMwVmtpZ3czSTA0c0lMdzlrZ01WZEtKQzM5OHJDcVBueGtoZEFPUUVsakQr?=
 =?utf-8?B?aHlnbUFFMHd0cmdyb1NCQ2VCZnRhVDcxYk9vcXcrZkhEVGtjd2w5TWcxVEhU?=
 =?utf-8?B?Rm1SUTZScS95VFRBOFlvNDc1eWJUclkzSTVyaHJjbnZsL2x6UEQyTXlQYTk2?=
 =?utf-8?B?TEQvM1Y4Tk9yZENHUUVvQW1CQUJ2L3B3SlJLZEo2bmtYUHRWdkU1UTVKUDFM?=
 =?utf-8?B?eCtrak5oTW53c3c5eVA2ZTkxNXlpVXE0cFVmWk1LUjVKVEIrS1hOUGVZeVl1?=
 =?utf-8?B?N2t3V3U4U1VEWU5sOXU0S3p3bW5LOGQzakFrakpQMFBuN2I4ekJFaHlpVE02?=
 =?utf-8?B?Y3pVQi82cjhVYk1naGJEOWNiMlRsVWFkOFVReWNWMm9XLzRoMHh4VWlCbWg1?=
 =?utf-8?B?ZlNwK04waTNVK0dyNU1EZ1AxdFpHYkRXTWh5STVDbUZ1T3A2NEdIcUNJL2Jw?=
 =?utf-8?B?UjNZYjdCcCtqMTV4Mm5yNExtS3MwMkFlc3pxdmNDN0ZYakJpRko0T2dDTFJF?=
 =?utf-8?B?UHdscnVYMWVRVzN0ellqVk9vNGphckhwY0ZjSHYrb2ltRWRDUzBVaVlrNWZ0?=
 =?utf-8?B?a3Bka0V4aDdrVWJTamR0SGwrYnJTYzh6TWJ4bGprbFdjTUZZcmFkQ3lteHpx?=
 =?utf-8?B?OXdaQmcrNStEMmo1MW9NcWNjKzA2Vzh6aDJCcy92dnVTTzViM1VWRmtzWElZ?=
 =?utf-8?B?V1JVRVpqdjhXM0tXNFl3Q2xJR3ovTnkxT3VRZUt2TGg3SUJqalp0Rmo0bHZp?=
 =?utf-8?B?ekZPcFJVdUgxNHZ0Vnp0TWpFRkpGQysxSHZSNzVDMmxWU01UU3BPMk81Qmta?=
 =?utf-8?B?aFlydm1OSWVJaVY2OVVlNDN5ZmRWTlBraG5IbHZlUTZpSDZUNHhZTEZITi9S?=
 =?utf-8?B?Y0FicW14cjlZSkRCMW1RblRSSEJ3YzB6NS9RNnptb0E2ejFvTFN1eFRSWENB?=
 =?utf-8?B?OFR6RUVIYTlIUWNBN2pYcTQwTVFabkJzeit3N01mRzlXY2pJRFI0aitZSDZv?=
 =?utf-8?B?V294YlJqdUdjZVhhMGdrY25zS2k4b2F4OThYaUpzNFpMSkdqVVRRbFZjeGRq?=
 =?utf-8?B?VmF6ZDZrS2F2cWZmb3BheEsrcWUzZXNqNTFBNzdsd1JlTmhOWlRUS0pFVDFG?=
 =?utf-8?B?WklvQjZINnhPSUtwM3U2ZE9aNVBYeDZ5K09qVEVJT1BaRzAxV2lTTUdzT2h4?=
 =?utf-8?B?ejZ5b0Uzejc1MEZ5UFBvVUt5UHFEVmQ5MzkvdFdaZ0NXanE2REU5RzlISW1X?=
 =?utf-8?B?QVQ3L0x0Ym96c3ozdlFJVi8xbFNNMVNVemtscThyeTcrM2RhVWlyM0d0ZHR3?=
 =?utf-8?B?NWg1aEx1TkRVdWlIbzlSaUFnbGxmQjlUQzZVRGIrRHpPN3RaYWpCUjJ1R1c0?=
 =?utf-8?B?Q1VKeENmRkl2clk5azNOUkpEVFpSdDVPa0xLdHRyRDBtWGhVYlk0b1dWZHFw?=
 =?utf-8?B?enA4QkRibTVDcU9XVTc1OFo4UEkwYjY1WHdidnhaaThFUXFkVnBkc2JIbXVU?=
 =?utf-8?B?a1hmZlRJM0UvN01rYVg4VkhwNURKL3duUG9HZi9POVN1cnRCZVZWYUtSN0Q2?=
 =?utf-8?B?ZE1BSVg5WWFUaW1PL1FnZ3ZuY1QwZEYyL1UxeExjcUlWZGlkOHZvb0FyQUti?=
 =?utf-8?B?cHRJSExSdTZKT1lXYVN6S1ZhckQ5bjNZL3NIMVVHdGY5NnJ2MHZ5MzY4K2xX?=
 =?utf-8?B?R1VnN0U2TlBUSjlCcTNPMlM2SEIzMjZ5RFU2NmlrS0xva05td2NJNi9KVGsw?=
 =?utf-8?B?VGxHbW83clk3aDBWdlFPSTdXcWlGSUZKTStOejlKVTMwdlB2UDhua1BFTmpW?=
 =?utf-8?B?YUJwL01TOWgyb3RNaTBaWjNOSkRxdzJsRlJ0cFJxd2QwVmVoUjJrQWFPY0Jv?=
 =?utf-8?B?V3l3TTdUS2hORER6UGJVWXRvSzRVYXR6RGlpdUpCL3F4VEpkR3Q4aExJV1dI?=
 =?utf-8?B?RDEySFFweHMweGVYbGtGV2Y3UVkvWHMzMmx6UC85TU1WUkxzZGJBMk9YTkRB?=
 =?utf-8?B?cEdEUkc4YkNkN243c0pvYm9ob3NVbEdiRy8xYzU1d3JzNlZ0bmo0N1lOWDFv?=
 =?utf-8?B?SlcrblN5akxiem9GYUF2TmpxbzVyN29tR2syTWVyN0pBQ2hoM1Q4V2pMUmc3?=
 =?utf-8?B?QnBIT2d4empVMUlnTEJDN0tqeTFsdTdlVU5NSXpHKzFpTW82VE55ME5QaXBo?=
 =?utf-8?B?ZmRiZkhMMU5yaythZXBvWGhBbVR3MThWY0t0RUdjWmY5cDBVdWNUSnhyR3Ri?=
 =?utf-8?B?ZVhGei84em95WjY3THVhcW9TWWxuUnJ4dERyR0hwdGNha2xFYUZuZWxZNlZN?=
 =?utf-8?Q?fGAXLs/TwB67GSFOCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1beef38-b578-4bd7-8985-08df4afbb50f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:55:04.6511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyzWIikCrWqGNsZaaGkoR9qkTOj1zaRCX82F5m7UdSV3ZO6MUAkOdJwC2SGA5WyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 11:45, Li, Chong(Alan) wrote:
> AMD General
> 
>> Yeah that doesn't work either. There is no guarantee that the sequence
>> numbers in the chain are contigious because of garbage collection.
> 
> My patch does not need the numbers of the remaining nodes to be
> contiguous. It only uses the seqno of the head. For the nodes in the
> chain it only checks whether their fence has signaled:
> 
>     seq += head->seqno;
>     dma_fence_chain_for_each(iter, head) {
>         if (!dma_fence_is_signaled(dma_fence_chain_contained(iter)))
>             --seq;
>     }
> 
> - The nodes are numbered 1, 2, 3, ... when they are added, so
>   head->seqno is the number of updates added so far.
> - Garbage collection only removes nodes whose fence has signaled, so
>   every unsignaled node is still in the chain.
> - head->seqno minus the number of unsignaled nodes is therefore the
>   number of finished updates, no matter which nodes were collected or
>   in which order they finished.

Except for the first fence you will never see a signaled fence returned by dma_fence_chain_for_each().

Additional to that it can be that multiple threads walk the dma_fence_chain up at the same time resulting in different results on different CPUs. That is not necessarily incorrect but also not the best for debugging either.

>> I will fix the code to break on the first signaled one and send that
>> patch out again.
> 
> If I understand this correctly, the loop starts from the head and
> breaks at the head when the head has signaled, so the older nodes are
> not checked. When an older node signals later, amdgpu_vm_tlb_seq()
> still returns the seqno of the head, so a job which waits for the older
> node can skip the flush.
> 
> The count in my patch changes whenever a node signals, also in this case.
> Could you take another look at my patch?
> If you prefer to do the fix yourself, I can help review the new version.

I will send out a fixed version in a minute or so.

Regards,
Christian.

> 
> 
> -----Original Message-----
> From: Li, Chong(Alan) <Chong.Li@amd.com>
> Sent: Tuesday, November 24, 2026 12:46 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; timur.kristof@gmail.com
> Cc: amd-gfx@lists.freedesktop.org; Li, Chong(Alan) <Chong.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: track finished page table updates with a fence chain
> 
> amdgpu_vm_tlb_seq() waits for the tlb_seq callback of a page table update by taking the lock of vm->last_seq_flush. But every fence has its own lock, and a newer update replaces vm->last_seq_flush without waiting for the callbacks of older updates. A job scheduled after an older fence has signaled, but before its callback has finished, takes the lock of the newer fence, misses the tlb_seq increment and can reuse a VMID without flushing the TLB after the page table update it waited for.
> 
> how to fix:
> Stop incrementing tlb_seq from a fence callback. Put the fences of the updates which need a TLB flush into a dma_fence_chain and let
> amdgpu_vm_tlb_seq() add the number of updates which have signaled. A dependent job then sees the sequence change together with the signaled bit of the fence it waited for. The chain nodes are numbered consecutively. The number of the newest node minus the number of unsignaled nodes therefore also counts the signaled nodes which were already pruned, in any completion order. Nothing references the VM from a fence callback any more, so amdgpu_vm_fini() no longer needs to wait for vm->last_seq_flush.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 77 +++++++-------------------  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 31 ++++++-----
>  2 files changed, 38 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a627a3092990..dafcebd95555 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -114,21 +114,6 @@ struct amdgpu_prt_cb {
>         struct dma_fence_cb cb;
>  };
> 
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -       /**
> -        * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
> -        */
> -       struct amdgpu_vm *vm;
> -
> -       /**
> -        * @cb: callback
> -        */
> -       struct dma_fence_cb cb;
> -};
> -
>  /**
>   * amdgpu_vm_assert_locked - check if VM is correctly locked
>   * @vm: the VM which schould be tested
> @@ -1089,47 +1074,33 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         return r;
>  }
> 
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -                                struct dma_fence_cb *cb)
> -{
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -       tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -       atomic64_inc(&tlb_cb->vm->tlb_seq);
> -       kfree(tlb_cb);
> -}
> -
>  /**
>   * amdgpu_vm_tlb_flush - prepare TLB flush
>   *
>   * @params: parameters for update
>   * @fence: input fence to sync TLB flush with
> - * @tlb_cb: the callback structure
> + * @chain: preallocated chain node to track the update with
>   *
>   * Increments the tlb sequence to make sure that future CS execute a VM flush.
>   */
>  static void
>  amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>                     struct dma_fence *fence,
> -                   struct amdgpu_vm_tlb_seq_struct *tlb_cb)
> +                   struct dma_fence_chain *chain)
>  {
>         struct amdgpu_vm *vm = params->vm;
> +       struct dma_fence *prev, *iter;
> 
> -       tlb_cb->vm = vm;
> -       if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
> -                                            amdgpu_vm_tlb_seq_cb)) {
> -               dma_fence_put(vm->last_seq_flush);
> -               vm->last_seq_flush = dma_fence_get(fence);
> -       } else {
> -               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -       }
> +       /* The reference of vm->last_seq_flush to prev moves into the chain */
> +       prev = rcu_dereference_protected(vm->last_seq_flush,
> +                                        lockdep_is_held(&vm->eviction_lock));
> +       dma_fence_chain_init(chain, prev,
> +                            fence ? dma_fence_get(fence) : dma_fence_get_stub(),
> +                            prev ? prev->seqno + 1 : 1);
> +       rcu_assign_pointer(vm->last_seq_flush, &chain->base);
> +
> +       /* Prune signaled nodes, not every VM reads the sequence */
> +       dma_fence_chain_for_each(iter, &chain->base);
> 
>         /* Prepare a TLB flush fence to be attached to PTs */
>         /* The check for need_tlb_fence should be dropped once we @@ -1177,7 +1148,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                            struct ttm_resource *res, dma_addr_t *pages_addr,
>                            struct dma_fence **fence)
>  {
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +       struct dma_fence_chain *chain;
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_res_cursor cursor;
>         int r, idx;
> @@ -1185,8 +1156,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> -       tlb_cb = kmalloc_obj(*tlb_cb);
> -       if (!tlb_cb) {
> +       chain = dma_fence_chain_alloc();
> +       if (!chain) {
>                 drm_dev_exit(idx);
>                 return -ENOMEM;
>         }
> @@ -1291,14 +1262,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                 goto error_free;
> 
>         if (params.needs_flush) {
> -               amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
> -               tlb_cb = NULL;
> +               amdgpu_vm_tlb_flush(&params, *fence, chain);
> +               chain = NULL;
>         }
> 
>         amdgpu_vm_pt_free_list(adev, &params);
> 
>  error_free:
> -       kfree(tlb_cb);
> +       dma_fence_chain_free(chain);
>         amdgpu_vm_end_critical(&params);
>         drm_dev_exit(idx);
>         return r;
> @@ -2685,7 +2656,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> 
>         vm->last_update = dma_fence_get_stub();
>         vm->last_unlocked = dma_fence_get_stub();
> -       vm->last_seq_flush = dma_fence_get_stub();
> +       RCU_INIT_POINTER(vm->last_seq_flush, NULL);
>         vm->last_tlb_inv = dma_fence_get_stub();
>         vm->generation = amdgpu_vm_generation(adev, NULL);
> 
> @@ -2730,7 +2701,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> 
>  error_free_delayed:
>         dma_fence_put(vm->last_update);
> -       dma_fence_put(vm->last_seq_flush);
>         dma_fence_put(vm->last_tlb_inv);
>         dma_fence_put(vm->last_unlocked);
>         ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move); @@ -2863,7 +2833,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>         struct amdgpu_bo_va_mapping *mapping, *tmp;
>         bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>         struct amdgpu_bo *root;
> -       unsigned long flags;
>         int i;
> 
>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm); @@ -2876,11 +2845,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>                                       false, MAX_SCHEDULE_TIMEOUT);
>         dma_fence_wait(vm->last_unlocked, false);
>         dma_fence_put(vm->last_unlocked);
> -       dma_fence_wait(vm->last_seq_flush, false);
> -       /* Make sure that all fence callbacks have completed */
> -       dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> -       dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
> -       dma_fence_put(vm->last_seq_flush);
> +       dma_fence_put(rcu_dereference_protected(vm->last_seq_flush, true));
>         dma_fence_put(vm->last_tlb_inv);
> 
>         list_for_each_entry_safe(mapping, tmp, &vm->freed, list) { diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f6285a9d9e98..6142a86a8b80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -24,6 +24,7 @@
>  #ifndef __AMDGPU_VM_H__
>  #define __AMDGPU_VM_H__
> 
> +#include <linux/dma-fence-chain.h>
>  #include <linux/idr.h>
>  #include <linux/kfifo.h>
>  #include <linux/rbtree.h>
> @@ -330,7 +331,7 @@ struct amdgpu_vm {
> 
>         /* Last TLB seq/fence */
>         atomic64_t              tlb_seq;
> -       struct dma_fence        *last_seq_flush;
> +       struct dma_fence __rcu  *last_seq_flush;
>         atomic64_t              kfd_last_flushed_seq;
>         uint64_t                tlb_fence_context;
>         struct dma_fence        *last_tlb_inv;
> @@ -554,22 +555,24 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>   */
>  static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)  {
> -       unsigned long flags;
> -       spinlock_t *lock;
> +       u64 seq = atomic64_read(&vm->tlb_seq);
> +       struct dma_fence *head, *iter;
> 
> -       /*
> -        * Workaround to stop racing between the fence signaling and handling
> -        * the cb. The lock is static after initially setting it up, just make
> -        * sure that the dma_fence structure isn't freed up.
> -        */
>         rcu_read_lock();
> -       lock = dma_fence_spinlock(vm->last_seq_flush);
> +       head = dma_fence_get_rcu_safe(&vm->last_seq_flush);
>         rcu_read_unlock();
> -
> -       spin_lock_irqsave(lock, flags);
> -       spin_unlock_irqrestore(lock, flags);
> -
> -       return atomic64_read(&vm->tlb_seq);
> +       if (!head)
> +               return seq;
> +
> +       /* Add the updates in the chain which have finished, in any order */
> +       seq += head->seqno;
> +       dma_fence_chain_for_each(iter, head) {
> +               if (!dma_fence_is_signaled(dma_fence_chain_contained(iter)))
> +                       --seq;
> +       }
> +       dma_fence_put(head);
> +
> +       return seq;
>  }
> 
>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
> --
> 2.48.1
> 

