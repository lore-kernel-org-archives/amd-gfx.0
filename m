Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE1FC61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC2E10E4F8;
	Wed,  2 Sep 2026 13:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1QY+0c2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010065.outbound.protection.outlook.com
 [40.93.198.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B9410F1CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LY5GnVDlltSsyPagwiEn9EhNj7gBfnQt9kTxD0sK2y5PmuBtHuTYJjOxoUt3AHo83PVGw6iKCXTJXKFbsGkm1hP8ri547KeT+7gdQGr5TI97s6xZMeTVcOR/BNNzoa1lfWGM8dlsYBGTqLcoMO7d3XgXhtNuUCkKm2W9D4zlANnhMYIbiL7NvHmX3PBqrKFx5DljvvE97B3brLcFNIPBcS27lRFyh+KYYdM2Rys/boGFOvNhJdA1ElOjnAhhBmVgUjyFgonXRX0esiN9ntf0eLc4gIJqFgfk5d6ty3oUOrgc5hPhamug1hIi6KjuamT+6ztcBKyJ0Qpqh1NDKkFwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUTAdUkPefYe1GpT2qjr78wrNWHNWZX/zVkPzVMtmwU=;
 b=H26pD9FIOEHPF7YRrlpZrwFr2l+zDA+29Dp1jMSZZ9CHgCzqI5pwTVPmDEwsBbPLpiRK/mh5SifEsOiK82innZMPiMt9gcbKuNpPlV7b5jfpL0ok+Zcg5u1J61EDipsWZhv9UpLi8thHD5RTkEF8JLODJ3t1160mqBSvxP2MQUEPTzeANyi4pdaHtc46u0v0OlP1fRsYer52szw+B3pnW8T0yQfB2ynZRn/qEBkRgkAzDShfgkRS0v6LC2oPKQg5hbYKRmHLE/m1ZF7s8zaL0MQk2RlF8rTVszRpylccSGul3XjOLZEJN5u1FXMLrxwiymn772QHkWOyMJhDBlYq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUTAdUkPefYe1GpT2qjr78wrNWHNWZX/zVkPzVMtmwU=;
 b=r1QY+0c2+0woChsVSQ9ZSfGeyDr8zEiq9kEdLA/81Uy46QAv6P05mst8i1kMNJlOAyKxaENzPNss4igRQxo8btRV4E4Xve8xjQPyPK/NpN0PNFSWC8g5uJDfn2AyLOXV0YMn0uAXHLiK5zfneif42dRW/3uhoNgl/l0mfRHnXHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:20:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 13:20:49 +0000
Message-ID: <db022549-86b8-43a3-9b8e-b46bcdee2033@amd.com>
Date: Wed, 2 Sep 2026 15:20:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/31] Rework GPU TLB invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
 <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e6c181-b13c-4628-0212-08df08f50170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: YRtwVp3xYWj1yeGoo7CaPi1xpE1ZUHGSUL+4298lTI4EoI+JEH+a2CBct7UfTV9TFLniI6TCg8IQsTl3b5Dp44Oy8mXJWg8L3eFwt3BL6JhRoI2x3Ger1CuK7AjHGJJ15ZN7Eu5XBRkm3BnQCHO4OyN4IiOcxWITl8FZEg0iF15yKvaFLdZjbok32nKVUChuBtxZCYMUSeoewvpfiTctXDPGo8LnDQqAFZA20ZkF7by5ZKFK/cM6ExSPpGqgd2zNQGbDeHVS/AdG6eGR1wX98njr9QgB39iZdp/VhUi9RR5wGwTbgOCpATMGrppWM0ijn8ntzSAFX8pTYM61SlaghIL9dOrXajnR72at9f9ZiU8+6/obz/wvT0MJ3qVABA/imxJ3is6VIuj8Cx4+nQ2OSxpkLohqbXikKbGpkILJaqRTbNccQxeTnkxMDmsYmPrErJ5XojqUZV2Asq3MVm9EuNAfyFjKN/HUruRZPp5ao2wAASiyEFyRxxEaGZy3n0YN9/bhr3fa8tb/Whhg/6xjgUY/Rn5KvXb4XdVpiCRf3T2rYCMeS3lMQADay+ElFf5VRSBr/x7VN9Vzyi266HfKG7pdY48V/LKsGjZ8yyyJrhCm20unrm/DAPVdvuebcM29
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmg1YTA5S0FrRHNwUUNGbnl6dGdDSXZNaytaTVRCNVluUjQ4bm9tOUdWKzhB?=
 =?utf-8?B?S0xnWkpnVlRrUXFDaE5VQ1dFREhNcVh3SjJKMFVlYTBmdm5IZEIxdE9JUmRk?=
 =?utf-8?B?TkFuTkFPN0RWS1BZZVhTaExCRkljbXNVQUZiZmhHZ1NnZ1UyNnZPNmxlcldP?=
 =?utf-8?B?dXY4MXBVWnJZVGRkWWRDdEhpbnkvTmRJRldKMmhwRi9aSFJobzVoOWdzYWVB?=
 =?utf-8?B?SzVrRU1KREcxbVJRamdSenQwakw5cVlxOWUyTmY5czNVOTFneE9tSmJRSWs2?=
 =?utf-8?B?ZHFScjVHb0lObU5zeWFrdEZoQTN4ZlNNaUpjOFdwdEpmN2RsMmlMN0RCRVZ3?=
 =?utf-8?B?OEE5VzRxR2pReE1pRHc5SHRnbWFVWTFOUXF6SmU2SEtrS0llTUFOT3h4ZjEy?=
 =?utf-8?B?eXpYb2p2QkZLbG83bXdwQkh4TlNQbVNBVXBPUXJYL0JMOWNpMzRCb2tiTVVM?=
 =?utf-8?B?ZllrYkVBK3VqMGhRRjhBYUVEbDZJSm1oaGxBeHp5d1ErQUIyL0I3RzJWbmdX?=
 =?utf-8?B?MGhuTG9LTjc1cjl1Wm1pNG8xZE9GL3pqYVd2UG56MEd5MGtaLzdFMm5DT2lB?=
 =?utf-8?B?NFZvbFdYUWZhMGo0T0MxdnJXZ3ZzSGl2VU10OUIxbFFaV2Nlamc1anNlSVRz?=
 =?utf-8?B?VFhCOHNVMGJLTVlNVmRSRVlVRURqcG41N1NCTDlTNWFoTFRaaXJpb1dySEZK?=
 =?utf-8?B?R1VTNy9BNUxacXhVamovdkVrT2lLQVhtb3V6TTRhazRrZ3NaTC81aUI2VW1M?=
 =?utf-8?B?ejZyaEp4Rnl1bC9sL2NVdzZCTVY2ZTgySmZGZS92VHRwYStlZFZXaWppVUxJ?=
 =?utf-8?B?MDByWU5VWjd4NlNlOG44NlFHTExSNlFnQ1B3VmR2QVBnQWdlOCt2VElKdmM4?=
 =?utf-8?B?V2xodHJZVnovcWduZHB6Zk0zRm9KOVlqcHNCb3liaWw4UHJBZXdEanNLSi8r?=
 =?utf-8?B?azhFUXFwNHRidjNVd09sakFBUkVscE1EeTZid1RXL1c4ajZTTk5IQ3FHZytV?=
 =?utf-8?B?YzQwSy82U2FYOVNuQUk3Y2I0TmlubUVzSVhKMmNtVUZBbUdrNm9XdDFMUDhy?=
 =?utf-8?B?VzRLQmVGVE9EM3FqekhqNmZ2b0UwSDNVTUNEdVljZjR3SWE4ejdXZHRvL0dW?=
 =?utf-8?B?SDlsRFZkcmJxeFVXWVcrMkR5RzkvOVVaUUNQR3BNNFVLbDcvNmlIYWl2SHcw?=
 =?utf-8?B?YUxHdUxRbzFzTDl4QWRqU3Z6L1IxN3Q5ZzducjlkZ01yY0hEQnFmYmRQNUtK?=
 =?utf-8?B?SjZXUUNyZzRuY3JkSk4wblMrT01Vb0MrL2hHSHZsc1h0Q2hYL3NhOWNma3NF?=
 =?utf-8?B?UVVBTWoxNVJpQnUxbnJMRStsVndNR21JdythQkNUcExvRzNWODE3UzNMWkVj?=
 =?utf-8?B?OExrdU5tZU01cC81UXBCNnJ6em11TUJyRFhtaU5IdjV6czhpaUVDYXpCZHBQ?=
 =?utf-8?B?YnE4TjhQNDI0L2NxSjdhRStlN0d2OFRudy9PdmFwbFE2WjI0MnF6N2g5QlJ4?=
 =?utf-8?B?M2NnanRIUDZaN0IzSE1XaW81cXBxOEVHZ2ZQWHo0YVFSS0JpVGc0elNlS21z?=
 =?utf-8?B?ZEpjeXYvNG84MFBUVXlkR0VkZEN5V1o5d2hydHlTK3Bremx1ajd5cm5FTXgw?=
 =?utf-8?B?OWJybTQ3UkQ3UmlyNlNWS28xTjVlLzU1ajlFeVRNemJ2S2NWVmFuSVpiMXEx?=
 =?utf-8?B?U1JWWmtyM3FhOHV4amJuSkc3ZnVJRXJ5bFNQRVd6U0pxR05pM0hZR2RoVVpY?=
 =?utf-8?B?OUxQaHBwUVlKUmVFL01mWDFEeit4TFZ1U3Ztb2lSeTFORzBmeVhVeWIvN2h4?=
 =?utf-8?B?TTN0U1paendYMTBMRXRydmY3QmNQdGZQL0o2MVZ1U09wTCtFZ3VyMld6b0dV?=
 =?utf-8?B?Unp6NE92OHNHbGZuSU5RYk4rR0laV2F4dkV1VUJhVTJBODdZUEp1OXhpWlNT?=
 =?utf-8?B?MUs1SFg0dWMrNVE4c3VtYjRwVDZXYmlUU1VtN0dPZ1R2aVZuMGtlSVlsSUZE?=
 =?utf-8?B?N2xpcklHV0tVR0NRT1NnNTg1c1NTeVYwbUQ0REVCZG5mOW9RZC9RemYrUnNH?=
 =?utf-8?B?S2lNcXhXbjUzakg4dVo1aWJBNG9LQmxZZ0crUkp1ZTZNZFFIOWhweVR5OEIr?=
 =?utf-8?B?bElCQlRVTjN5M2dYZkg1a2FyOWZFdU14UXJ0R0lXOEdqRnJVUllybWVzTDJo?=
 =?utf-8?B?ZE1LOHhVNkFsNC9XYjN4V0U5WXpBYXJkdEtOU2Q1K0RYVTVIdk1ZUW5DejBJ?=
 =?utf-8?B?NGQ5MVlQWUtQL3UrZUdFSGtmcDA5bWNhWE5mdmY5SGxFUjA2YjE4RVFMSmQ2?=
 =?utf-8?Q?CzFQfXDAgej8MDt0y4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e6c181-b13c-4628-0212-08df08f50170
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:20:49.5745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrt4TindUp9+BW5umZxpnNSks+0POIFOU7MNNMjMxbIseziE4Ynk7rVvwT29uCjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

On 9/2/26 15:06, Alex Deucher wrote:
> On Wed, Sep 2, 2026 at 3:25 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 9/1/26 22:10, Alex Deucher wrote:
>>> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which would
>>> require disallowing GFXOFF.  KIQ and MES are management queues however and if
>>> they hang, they cannot be recovered by a queue reset since they are the
>>> mechanisms which handle queue resets.  Since using KIQ or MES will exit GFXOFF
>>> anyway, explicitly disallow it on the MMIO path and use that. Next, switch to
>>> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special packets
>>> specifically for this purpose.
>>
>> That packet was just introduced to work around SRIOV issues and proved to cause stability issues as well.
>>
> 
> It was introduced because of gfxoff and having to toggle it to use
> MMIO.

No, that was completely unrelated to GFXOFF. This also applies to HW where the SDMA is not even in the GFX domain.

The problem was the SRIOV could interrupt the SDMA while it waited for the ACK and when the VF was scheduled in again the ACK bit was resetted.

So a single packet was introduced which couldn't be interrupted by the hypervisor.

> WIndows uses SDMA pretty much exclusively for TLB
> invalidations.  It's also what the memory hubs team recommends.

That is rather interesting.
>> Since Arun now found that on basically all Navi generations the SDMA can hang while doing a TLB invalidation I have to clearly NAK this approach.
>>
>> In the long run we should do the TLB invalidations on newer HW completely with the MES, the SDMA was always just a workaround we should not push forward.
>>
> 
> Well KIQ and MES also seem to be problematic as well.  See the thread
> from Denis about KIQ and his renoir system. There are also various
> reports of MES timeouts doing TLB invalidations.

The MES is the only instance which knows the process to VMID mapping for user queues.

The hack to read out the PASID->VMID mapping register directly from the IH is not really something we can use in the future.

So the plan was to move all of that into MES in the near term. IIRC the MES even added a new packet for that.

Regards,
Christian.

> 
> Alex
> 
>> Regards,
>> Christian.
>>
>>> If SDMA hangs while doing the invalidation for
>>> some reason, it's easier to reset the SDMA queue than KIQ or MES.  Finally,
>>> most of the TLB invalidation code between GMC 9 through 12 was identical, so
>>> move it to common GMC helpers and remove the IP specific code.  If the SMDA
>>> and MMIO pathes prove to be stable, the KIQ pathes can be removed in the future
>>> to further simplify things. SDMA 4.x could also be updated to support PASID
>>> invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
>>> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
>>>
>>> Code is available on this branch as well:
>>> https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_type=heads
>>>
>>> V2:
>>> - Add missing hub callbacks in gmc9 hubs
>>>
>>> Alex Deucher (31):
>>>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
>>>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
>>>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
>>>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
>>>   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
>>>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
>>>   drm/amdgpu/gmc9: use MMIO for TLB flushes
>>>   drm/amdgpu/gmc10: use MMIO for TLB flushes
>>>   drm/amdgpu/gmc11: use MMIO for TLB flushes
>>>   drm/amdgpu/gmc12: use MMIO for TLB flushes
>>>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
>>>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
>>>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
>>>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
>>>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
>>>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
>>>   drm/amdgpu: add tlb invalidation method enum
>>>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
>>>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
>>>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
>>>   drm/amdgpu: add a gmc callback for the inv semaphore
>>>   drm/amdgpu/gmc: rework pasid flushing
>>>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
>>>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
>>>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
>>>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
>>>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
>>>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
>>>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
>>>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
>>>   drm/amdgpu/gmc: add helpers for various tlb inv functions
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
>>>  22 files changed, 943 insertions(+), 1015 deletions(-)
>>>
>>

