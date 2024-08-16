Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C079C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 23:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEE210E85F;
	Fri, 16 Aug 2024 23:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyU7vPYi";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1052010E85F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 23:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHPOhY2PXvHHUXWlCFtKCT63Xml8OXKpKJCBoNVf5lHT5S+X9uBorD1+9X4uUhQtoMshxuxIrAOciEgPIaWR8vkD1EdFBAUSj9x/bK/OK5+/Q+1axwzIWQVzZ/+xhyR7KEVoXewIeTshkNmDYlt/I5FMte0fArgicxhfiP7DDm7UBTLqLTwxVFX3fKXjZQRlgIa7WkX6PmXqMthqfeH+KPtVtEumqmxx6lJwI21ygalD9cAKk41sIAUYvI5ujLNL+Qyb2RHkEdeWDZ7Bm6fAIXR6l7GklKRWL5VKF7uoO1nJNzmgLbY2l0gJN3ypuGuyeZD1zWEJl5V3MbnvNTnxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9/E82Pxg2EhroLK7s5xP/dnehUcY1Xjrigvh7u7jPk=;
 b=OKds0+18LuHk/nJJ2HEKBTgEIGpnOu/5Ss/R6ya0e0InGHVWs0iD6+2/iVV1pJ5w5ve6Xh8t2z2KU7OVKpxn1/dggc6z3Luy6nDWU3sxipyKjELEfHrYHkeJePY2yefrZKQyuRfzXwPbSOQKh9v5mDg7Fj+2IgjeSrFzISFLIX1UX8q1MJKDDSnYuOUun9v6QUTLfOojCLs5NzLGcKWPetNEUHWLw3BDlUCQ2ZcakOoFooJqYjZ6Xhy4pXK0EQ1z6KpDO8S8UF72NxfSKz55FEXJDCC2QUcyQ4hlObVN3wq5IJGR0wFFTtVD3grY9EdgVd26BICZVBlpFjEoTwXpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9/E82Pxg2EhroLK7s5xP/dnehUcY1Xjrigvh7u7jPk=;
 b=YyU7vPYivZ4ELZSpx63fM2iSCESxmzes8thX4qG3bdO3aIE07D3ks/K38x7cUvgqx+29tXTsbTyqykpUCEpD8i0zAiCBC9x9wzbsWoVJdoaDx8MCMZtpBwsPOBREg4r3ePDxKQimXkKzOqtpKG6WHU1/3J/di86kxM3DVF4odME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 23:08:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 23:08:32 +0000
Message-ID: <705be5db-9fc8-497b-9a06-644b65066ebf@amd.com>
Date: Fri, 16 Aug 2024 19:08:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/3] drm/amdkfd: Update queue unmap after VM fault with
 MES
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240816180138.1171558-1-mukul.joshi@amd.com>
 <20240816180138.1171558-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240816180138.1171558-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e30b28d-45e8-4898-9334-08dcbe48595d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVNLL2lWNjdDdmZsd1psME5RYzZYTmpnOWlKQUJWYnNPeEJIcnpiMFgza3p0?=
 =?utf-8?B?eUtuc2NXV1Y1TTRBMmlBeHEwaCtTbGliRmpOOTdGbmxGZmVYNU9iUWlZcnVB?=
 =?utf-8?B?YzIyVUY1T2dKK3JSaGZGQUFhQkZzSUIxK2NMeE42UU9nL3M0OE1KL0hNU29p?=
 =?utf-8?B?U0NpQWVTb1VkV2VYekRmSVJDVkJuUmFJWEpuQ0dFbXhmRkkvQlEzWnpXdmg5?=
 =?utf-8?B?TDI2Z0puT000QXVoOVpNS01FeUtGUUMwWkQ5LzFWT1ZIMnZVaGtWSDkwRjNv?=
 =?utf-8?B?dVllTHZuSXhENEoyRXk4R3ZqeGEvREw2NXpPSmVCbjhCRkxhalRqcnNwVjFr?=
 =?utf-8?B?aDh3eWJYVlhBL3lwa1N1RTVRYlBBV09NQWNRd0tMeEJaUW5jOGJpVUttQWRB?=
 =?utf-8?B?SmpaOWFRUGZtOGtXTDVIR2JCcWtReU5xdVFicXdMTjREd25oSkhUdWlSSUdG?=
 =?utf-8?B?L2hFV0pNK2N5ZU0zY2hRRjVPZXQ1ajFBakZCck4yZkFWdUZYdlhiZllBKzgv?=
 =?utf-8?B?OUtaeFRHeGpDWXRCNkZLQUdnVHJTZlhxM3ZvV3VrR0JhaEtBNUg2VWdRR0Zq?=
 =?utf-8?B?dW5jcHN4cTMwNi9zYU0wUWw0ZGRzbGNRbWRlSHhmVTZKUTd1b0N3V3VjQkta?=
 =?utf-8?B?Mkc5RHArZ0JKK0VUazl1SmxIdXVNVlVsbjMzUmZoS1Vzc2tSS2ttemFLdWtt?=
 =?utf-8?B?TC9JNkhpSWdiZ3RDL1E5VFVabno1YkJmWmZ5ckdNSzNoRVB2WG9iNm5waEhF?=
 =?utf-8?B?akVsRmVzd05PVm5NYlUvMDFuMmlYZFlDSTNjTHVvOElzNkdaV0FDZElaRy8w?=
 =?utf-8?B?dEk4dlJGL2p0amt0VVVWdlF1S1BzSTV4bHJMdkFRckQvanV2U2ZpRVZqMlRL?=
 =?utf-8?B?dlFPRzRGUGMvZzMxNHhJMGg1Y3RSK09OeWIxei9Pb2JZWlM1QWxIZHBOdllv?=
 =?utf-8?B?MmR3enpYR2xMT2lhT0psc21QejFxZVd5SjFJN1IwcWF1c3ZUSkFUSTF4dXYw?=
 =?utf-8?B?alFKQVdiVHR3VXRzckRoSEV2d0FHeTEvOGIxK1BFYkJYZmVQUXdnR3lZUXBz?=
 =?utf-8?B?dFVZaG9GTHZlK0dvdFFaeFplUTVERnd2M0NEQmdaYlhiWlJacHBmU1VwSHI0?=
 =?utf-8?B?NG90QyszUXM1ak1QcWFpb3dMTVdJWGtGeDB3MGlGVkZINWhtcUxFRkZyNWVH?=
 =?utf-8?B?T2N1bndUa0s5aGJ5dzh3alpOWlRqVDI0YW16OGE0M2Y1eS80dUVDbDNEVk4z?=
 =?utf-8?B?ajZMNHBkNTJYOHk1UzlYNEJ1VmZ2aUw0TFFreXMwMFZKcVFReldDTkZuU2hJ?=
 =?utf-8?B?WTNCNVBIRzl6ZXNkQVpWVVN4VUVFdjE3eVp4bllYODNhMno4UWtONkYwU01s?=
 =?utf-8?B?VkF2TlpXb1p0bWhMQlh4aVh5Y1lMckxyNThDaEdnZzJ0elAvQWdmVm80bHRs?=
 =?utf-8?B?Zjdwa2ZWUzVNMCtKdXFHaXdGZHNpVEpKTTBUdk9tNWtaOEJ1U2tySktkUGNI?=
 =?utf-8?B?eTBiMjZZdHBVTzgycUZ3R2I2VnhpTmkvK0ZuV2QySjIvK2ZaZDZHaXNGRDJn?=
 =?utf-8?B?NVBMWFJjVXpaWUVVOGZZdkQ3WlE1MmwvRG1EWW1mYW02b1NGSkVwUGxsMGFq?=
 =?utf-8?B?a0l1ZlhDYWRRYmFBSUxsMjQ0V1VHcmFka3M4K3BSVUdzS2g3eHRxelNzMjVT?=
 =?utf-8?B?Y20xSTNrYnhRNk5YREZpRXJiSTFnTXlRYzZjaitiZ0ZQcnNDUW1yeVkwaWI4?=
 =?utf-8?B?N3NiVFFGWXZ2OERwVVN4ZWliOHBNK21Tb0ZCUFhJOEVwVGRYTy94dkJwUVlC?=
 =?utf-8?B?UGlhYkpReEZJc1BnSUQvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGgyV0NqN0RtS1Q0dzlMQWtFWEhtemtZeDl2WG8xNVBrL09LYkxFKy9Gb1R5?=
 =?utf-8?B?YlVxNXpsa1hEa1ZRS1h2RVR5M2U2SDl0UlIwMEszV1gyWDNnamk5eG1oSXNT?=
 =?utf-8?B?OUE1ODV1VlZyMi9xUFozdTFBdFphTEdsOGs4eS95NFVLbDBaOXptbEhkR01S?=
 =?utf-8?B?dXZ1djFJVjQvVE56RjBEMVovZnhqVjdETFZBZy9lQ0YzRDA3NitDbStOZ1dk?=
 =?utf-8?B?MUxSWTFhQ0p0WHljdGtzVEZMdnJmbVNsbVFyMzN1OXArQ1pyODN1S0paelhC?=
 =?utf-8?B?L2Y4VDlROENSTkFUQ0Z2YUhMTG5tVm8yZTdXSkpqSFY1a1c1ejRjeHNJWG93?=
 =?utf-8?B?NDhvVzFIWWQvdUsxandOb1N6QVVVeXNISGNWNllFVkJTMDBQYUNMekI3TklJ?=
 =?utf-8?B?VWVXZjQvaEFKS3JLMmgyYmlyRUNHRVlidllSZEpvelVoNkl4MU93Q3MweEs3?=
 =?utf-8?B?b3NxNHhiME8rNzhyVEgzY3FRQnB0ZXVHWmFWOVZodURWSi9zS29TbDNZWEox?=
 =?utf-8?B?WFkvQTJtRGhxK2dFZWc3SUxKTVU0S1FwNU9GeEo1YkxnSUJsSFk0MjRJcFFC?=
 =?utf-8?B?WWozUEs3OVBmV2VvVVhIRVNDREhTRWxRZ1ZiZURzM09vWFl5cDd3VWhVSGNs?=
 =?utf-8?B?ZW1TZExjdGc0Mlc3SG9uVlppb1NnT1ZPcFcxbmRGZjBGRXJLb29oQTh4TStN?=
 =?utf-8?B?QTlOSU1rQUV3TzBxREJmRE9EVElVNjBWaXJPWlM4WHAyNjZzOTlUcVZmbllY?=
 =?utf-8?B?SlFoRE9HLzBCVExUT1VwV25rdERXWHVDamVibVdoQ0ZUdXNibjFvcTU3dWZr?=
 =?utf-8?B?UTRNSmErOFVVNnVRcktDYVBLKzczT2dUSmptZnFPc1NhRDd2djFLWDJyd2Yv?=
 =?utf-8?B?cWlJakFtZkZFSjJDS3d2dXR6UWlUS0J4cWRCakVpT1BnWjBuc2FoZTRlOHY5?=
 =?utf-8?B?QnVTYjlFVmZTcVAyK0drQlI5T1B1c1p2eEYxM3pleHR0eDNsbDZKdWVTOEJG?=
 =?utf-8?B?Q0I4WnRjV1pQN2RjYWg4a0pXd2VId0V2QkFIRU5FU0F6bXVQVVJ1MGpBMEU0?=
 =?utf-8?B?NFhpNyttbklsMERkQjRxUkhNM2tYRlgrOXV2RjJPdktSMmlONUdIdWhXVTRJ?=
 =?utf-8?B?YUxoK3ZPK3l3L0xqZHQ1b0VkMmM3dmg5OTlmNlNPS1hBY1Y4VUUzc0hvaDIy?=
 =?utf-8?B?cFljNkpBa3l0WENNM3BscitFL1pab2J3SU8wOFgvd3BrNU8rMXBubS9PMDZz?=
 =?utf-8?B?cmFSL3FFTG9EY1BscmxzdWJHa2UrSlZmMUpqUG9GOVFvWUVHRlNIYjR5ZHNw?=
 =?utf-8?B?alVtZ0RqdW1vWjZMUnNDaHhxZFJEVG1MZkJHRUtIZU4xMHY5NDY2TnV1VDkw?=
 =?utf-8?B?QWNFS1AwOHUvcDRpWnlJL04zSEtPMUtCZzFxU0p1NktZcFdmOW9jeDh2ZUZ4?=
 =?utf-8?B?VE5nVUNnamowZWpadUY5VWljWnhwRFFrN0drdTBxS3ptSWR6NHd2WjIxV0FZ?=
 =?utf-8?B?enIwdnNuT09mdHpENG4yMlNIZmFHdzdrclFNbi9BanZYd0g5SlRCOVF1U2lh?=
 =?utf-8?B?RlBqSTdVM0hieDdwWXd2Rzh4THhFYjc2OFdLbWo4c0x3dmovNmpzL2FJYXJ1?=
 =?utf-8?B?ZmdSeG1WMnhPM3NScmV5b3Rqd2U1VzVCeTd3clZYbVpwaUwwNXgvRnFBaFJT?=
 =?utf-8?B?ZURYODZWb2dOMjN4U2JPU3BuRHZpS081WS9VVU95QWUwUjRab0pxeUhHZkN4?=
 =?utf-8?B?V1VzQzVCbFFGTXR2eEl0RllXZnlUTzBXdFNRNHF6d0JxV2FqSGRVVGV3a1N1?=
 =?utf-8?B?MHlqRHA3UXZzUUxMR2NtRTJoK2VFazZISGNZdGcrbEtETVB5eTliTm5ucWxF?=
 =?utf-8?B?VVNzT3F2MXB2Z0puREYwa01lYjVmdHRpZE54ckEwTktydy82NW5jS1YwUDgv?=
 =?utf-8?B?UXFyZFJuNi9qV1NzanZZa1NvTDdvOTNvTjdOb3phWEg0eGZBN0JqeXh5VkRE?=
 =?utf-8?B?YThSZER1VGFxQjMveE9zbUJONldlY01oMjJseGtkR0JyVGJGOGdFb1Q3cEkv?=
 =?utf-8?B?SmZFVWUybzZuKzVibkNMM1l0VDNYQnl3Y1BDclY0SXlmNzZzVlNicjlqMEVN?=
 =?utf-8?Q?RN8x76gwWtDhBhiISIExOIriW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e30b28d-45e8-4898-9334-08dcbe48595d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 23:08:32.7635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0qXT9iyDCap6MZXOCZKWWudrAxB8BDTfFxoAgTvdXE66Jp6xjUoyGkPyKsyEj8un1G1DMFralRlMUxfO7XncA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263
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


On 2024-08-16 14:01, Mukul Joshi wrote:
> MEC FW expects MES to unmap all queues when a VM fault is observed
> on a queue and then resumed once the affected process is terminated.
> Use the MES Suspend and Resume APIs to achieve this.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - Add MES FW version check.
> - Separate out the kfd_dqm_evict_pasid into another function.
> - Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.
>
> v2->v3:
> - Use down_read_trylock/up_read instead of dqm->is_hws_hang.
> - Increase eviction count if the process is already evicted in
>    kfd_dqm_evict_pasid_mes to make sure the process stays evicted.
>
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 87 ++++++++++++++++++-
>   1 file changed, 85 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f6e211070299..0ca933d2099c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -319,6 +319,46 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
>   	return retval;
>   }
>   
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int r = 0;
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return -EIO;
> +
> +	r = amdgpu_mes_suspend(adev);
> +	up_read(&adev->reset_domain->sem);
> +
> +	if (r) {
> +		dev_err(adev->dev, "failed to suspend gangs from MES\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> +		kfd_hws_hang(dqm);
> +	}
> +
> +	return r;
> +}
> +
> +static int resume_all_queues_mes(struct device_queue_manager *dqm)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	int r = 0;
> +
> +	if (!down_read_trylock(&adev->reset_domain->sem))
> +		return -EIO;
> +
> +	r = amdgpu_mes_resume(adev);
> +	up_read(&adev->reset_domain->sem);
> +
> +	if (r) {
> +		dev_err(adev->dev, "failed to resume gangs from MES\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> +		kfd_hws_hang(dqm);
> +	}
> +
> +	return r;
> +}
> +
>   static void increment_queue_count(struct device_queue_manager *dqm,
>   				  struct qcm_process_device *qpd,
>   				  struct queue *q)
> @@ -2835,6 +2875,44 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
>   	kfree(dqm);
>   }
>   
> +static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> +				   struct qcm_process_device *qpd)
> +{
> +	struct device *dev = dqm->dev->adev->dev;
> +	int ret = 0;
> +
> +	/* Check if process is already evicted */
> +	dqm_lock(dqm);
> +	if (qpd->evicted) {
> +		/* Increment the evicted count to make sure the
> +		 * process stays evicted before its terminated.
> +		 */
> +		qpd->evicted++;
> +		dqm_unlock(dqm);
> +		goto out;
> +	}
> +	dqm_unlock(dqm);
> +
> +	ret = suspend_all_queues_mes(dqm);
> +	if (ret) {
> +		dev_err(dev, "Suspending all queues failed");
> +		goto out;
> +	}
> +
> +	ret = dqm->ops.evict_process_queues(dqm, qpd);
> +	if (ret) {
> +		dev_err(dev, "Evicting process queues failed");
> +		goto out;
> +	}
> +
> +	ret = resume_all_queues_mes(dqm);
> +	if (ret)
> +		dev_err(dev, "Resuming all queues failed");
> +
> +out:
> +	return ret;
> +}
> +
>   int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>   {
>   	struct kfd_process_device *pdd;
> @@ -2845,8 +2923,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
>   		return -EINVAL;
>   	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>   	pdd = kfd_get_process_device_data(dqm->dev, p);
> -	if (pdd)
> -		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +	if (pdd) {
> +		if (dqm->dev->kfd->shared_resources.enable_mes)
> +			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> +		else
> +			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> +	}
> +
>   	kfd_unref_process(p);
>   
>   	return ret;
