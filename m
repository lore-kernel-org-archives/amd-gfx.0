Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC309D374A2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827B710EBB7;
	Fri,  5 Dec 2025 21:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ogdFEBt0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 976AD10EBB7
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnHUR0suXqHX1BD2cDd/MspxbJqwYsXcu2juwXdQPTrhO3LD8UULhOt6JAgTxM6NG+tddy06d8/m/NPnduf1d/FN474kVtGQzdeKbMVp00waBEJ5nhYXFFp1Wf1posQFIOmn3PTJ4t2mN5V9m/pDiYCUOYNjUvoaA6qzeLHOAErY4yEw/s9uPGDrg0JSvG+E7rcRiw1D2r5vM0NVxOEUqKnEGwy1Ff7hSLpSdUzG+qOkbQRwmUKbAb/JeOGT3tZaA/ttbxLQojOTRL8UDrUjj48vQa4Vh1Y1TLexmfKxRsCKtV+xgSoiNzk+B+s2+eknRM9Cio7zGNQoXMUm0HcxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBE9HyQvuS83lKQv8zPmzD8CEJZWM/m0sHeviB3tTQ4=;
 b=nQiF3VO9C+vG9bYJwyInd5l3NK30IrOEOfHPSSmWL3atu5SUh4XBuYWdHDmmPEEUTMTxnDrKMNL1jpJs1Sx1kXlWx03D186YJcsUs75fgDXu6gpeMX9ERrPpEQYN8EL2QrFU32qlY3xvNKkbFCrSEK3k2jM+NeTXgQlTNcwXByol199JYfiL4DdS/XdrS5d5hWw0TH5TivK24sjqLSh01O1Eao7Tm8r5jsFPzuY8ygCj031TxneFHvzGSNM5Yxeo+QqPAhYJJ6HPme8qUqZljOL2mv5YtlUw5gELUX9kehyyxYTDdKS3xGkoaZeojcb80WGyIGPjfnOE6h2UF+n2Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBE9HyQvuS83lKQv8zPmzD8CEJZWM/m0sHeviB3tTQ4=;
 b=ogdFEBt0Ls6PUFU0Yg2g78uz8ELwoLe34kNJog+p50k5ZRL9xd5RNoT4G+Tx0vFsXLBjBn1ssZM1Mi9LT1EC3sMc5O2xKR6nxudDGlqraAEwr23n8OxJwlg1D0O9B6ENaL3jIcrV82Lw3PSAc4OKwERi37oetNMy5HaKfsaTWlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW6PR12MB8951.namprd12.prod.outlook.com (2603:10b6:303:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 21:22:34 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 21:22:34 +0000
Message-ID: <8f483f3a-6829-4fc5-936a-f1cf19d2f2ab@amd.com>
Date: Fri, 5 Dec 2025 16:22:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-4-Philip.Yang@amd.com>
 <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
 <fec99fdd-a8b5-4c48-a835-31ac604f3755@amd.com>
 <3461429f-fd3b-40b9-8d83-c45be32563c3@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <3461429f-fd3b-40b9-8d83-c45be32563c3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0463.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW6PR12MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b3b43be-fba3-42a7-4340-08de3444680e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXFTdUo2ODJaei9ZYnlpNnVIb1pveUZlOTFtNTRSNHF3ZWQ0ZkhlaE41Tk1z?=
 =?utf-8?B?elFKbGVDUjkxdWNCQy9SbXVlOUllTE9Mc1ZOdklEU0hnSWdvN3FVeEdyenRQ?=
 =?utf-8?B?ZzhBdU5VRDh4ZWtlUU1idklRV01YZ3l3WnE2T1FBRkhzdUtDazJLbSsyckxJ?=
 =?utf-8?B?RldNQm4rVHVYNTlMVmNrcXlwaEwwQUJoZFJvNWpRcFBpUUE4ekNrNTNaMzc3?=
 =?utf-8?B?Z1FaY21tVk1QYmZ0TEt2cllSSnJRYWNyUlVVYmNOM2VGTmxabTQrcHN1czFj?=
 =?utf-8?B?ZUlHYitWRU9TVVdzRDJsTUxia0ltNldVckpCM0JKenZmazNJazJ5RVVqT29M?=
 =?utf-8?B?OFdPR3N5b0hKQnBaTi9SRXhNNkVtb0FjSi9xVmZGZnh4T1FKSHo4cE9ERkJS?=
 =?utf-8?B?RUFvUGg3dVJYVzNYSCtIempsVGwrYitZSmNqTTdTLzlYVEVsaVBDNFlmZmJQ?=
 =?utf-8?B?cFJraVJDR2JkaVBtOTUrNE8wQmdncDFsSWRjeEJ4ZjJkUFFBOUlsYUhSRzFt?=
 =?utf-8?B?YnZ1TEY2QllXUkI2VHl5ekxkbFVXM3gwQlgrZzlPUUNxS091OXVtU2tuY1J6?=
 =?utf-8?B?M2dKNGVsR25ReGpteXNuNWNQaUNmdldRTGJhajdoNlIyUGQ1S3VtdU01TEdI?=
 =?utf-8?B?U3oxTTJBVUUwellzenlQTVV1bVp3dWpldWx1bUVrTzhHVlVxdndsS0tXSDBt?=
 =?utf-8?B?OUhRLzdjbjA1QldkWGFiMlZWSkZsS2pXMDVMWnNhd1pKVGdSVW1peVM5b0sr?=
 =?utf-8?B?TXd3d2dPK3pzR055RVBhRVZsUFZXMlVWTzJjRVV5Ti9sUDYySXNUSmw3YVdP?=
 =?utf-8?B?dW9rUWczRGEzTktoYWxEanhROXFmMkhPVGZrVUEwNzh3RVFZQzdENTBoZEg0?=
 =?utf-8?B?dTdqd25NSms0YVVBVXpOL2tmSlpONElhZkVnWXkyaHpSa1pFSWxZVFkwMks5?=
 =?utf-8?B?ZjZlbkFVRlF5ZmFFNGRUTDA3VVk2L1BNYnBIb0s4dTBPNGdtU08zU0tBU2U5?=
 =?utf-8?B?NjlyckR0T2tGNnJyVy9FL05mSkkxaFNiT213YzJqRVgxbmQxQk5NYkZodU5G?=
 =?utf-8?B?ZTNpN1pmM0sveEppeWNMOHBWUjZoQnF3Y1Vid1VKanQ4bGNnVTB3ZDUvVVI3?=
 =?utf-8?B?NzFHZ2dMT1ByaFIrK2VDbUE1YXA0UkRIeFhKK2t3U1FFYlFkKzFFd3NvREox?=
 =?utf-8?B?eW5pZ1pHazRybWJ4U2tpemQ3bnpYaDRtL3N6QUtBQjd1SjA2amZrc2c3Z1RD?=
 =?utf-8?B?SUVNSCtmSmNMMUJrRWtkVmhnYThQSm56a055Zk9JcWNDZHQ5dDh4YktuSkJP?=
 =?utf-8?B?dkRjN2diQnM0RXkrbmQzMlZFMmFMMjBQMTdTeExBdy9KMEI1L28xMTQzYzhp?=
 =?utf-8?B?V1RDRnRGRElIU3FqRjByRjUzRHk2Q0lZemRZZHRPd1Z2Q3ZYaVk4N2YwTmtQ?=
 =?utf-8?B?V05ldDdsOFlyQlRhLzRIY1JvbnFpVll0TGh3UEJ2TytiSDFlVU1ubUxwcWdY?=
 =?utf-8?B?S2JzNGRHS3hNSFhiSkNTcGJIcWJFY0J5R1RkK2xkL2xzVHlJci9pSFZxMWNQ?=
 =?utf-8?B?WTdaNXFyTXJ0U1JFbEJPUm12eHVjT1NNQ1hIYWhZYmlFVUUxVFRTRTNHVkYw?=
 =?utf-8?B?U0xRQmEvanFWVzlscVU4Y3dEL0llOVNHUHZsL3BpdWxhMDlNUkEyRXhXUDN3?=
 =?utf-8?B?U1JLRStEV0Zqckt5enJ2T3NWU2tMdHFRaGF2YlJZeHY5MlhoZnZrZzU4UmlY?=
 =?utf-8?B?R0FmSTRxR0NTSW0vdlcvb2lSOUh6aWh5M3BNcXJKTU1ZdEZMQnM3TVgzUmZ3?=
 =?utf-8?B?QlBpd1hRMTJ2ZHNqa2hPN1J4K0RxenV3S21lNkpKUHBHWU02NlJoSmo0S0hR?=
 =?utf-8?B?N285WHYwUU1rQzJXekFzUVdKcEZ4M2VzWkxnbnBBdEVTanFreDA5MjdISVVz?=
 =?utf-8?Q?iJgD62g6elKHZltPrZt1O1xV/Y7brvWQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUN2MjhMTnY0V1RIRUtqNkJSVGEvei96UElXOUZSMTZSTjZVaUJKRXhFTVQw?=
 =?utf-8?B?RWFiVHhjUkl6MXpsWWdUZ2VNTVZ1WEk4SlVtaFpQSFlHb0IvcHNPTUo0NVc1?=
 =?utf-8?B?TUd5S2diMngwcGZvdG9oSnVqWWtUaEl2T0gzaGdKa3BwOG0yYkhRTlRrSXNC?=
 =?utf-8?B?a1hkNFV1cnExcCtMSEZ5d2g4U1NzYVgwSzZNd2Z4bmZJYWNlS2hFemxwR0Vy?=
 =?utf-8?B?bGs2akQrUXJMV3RYcTNBQlpLTFJSTnJWNWs3aGxXVUZMYUFvWGZBYktHdm1X?=
 =?utf-8?B?MUV3T0FaQ21uenNFdzZtMlg2SitWVFI4WDFidGtKSStkcjFMa3UrN3ZDQ2R0?=
 =?utf-8?B?b1hwU3hrYjhvc1FnN1RjQzNMVHlObytQMEwvRjdkeTU3WHVKc0JQNG0zQ1Bx?=
 =?utf-8?B?NEthclRQZ1NwcGhhVlFTRGdaRTQ2eE9Rc1J3SUZ2cDM2SE13ZG40eUpqTjY4?=
 =?utf-8?B?RmFIRVJ3anBUU3hqT3VDN3kxVnlpYUlBUUErdVVCektnMTZLWnliTWlJYzU1?=
 =?utf-8?B?ckMyeEpITWExa3pBTEFIODlVeXJtVktNSGxndFFqM1hpRnVpSmxRV0xBMW5a?=
 =?utf-8?B?MnN0dGVQQTg1dXNwdythRmE4UFJNRStnbDFGOVQ3c3RRYWhhZ3I1K3dFTy9r?=
 =?utf-8?B?c3lPc3VCbVV2djYyVUFUc3pIMzJJK2ZnTDl3UUN2V2hweUkzTjNuZVJsNEZI?=
 =?utf-8?B?RVJ4SGJ0eFdXNUFCcXNUeU9XM3UxS1ZyYUFSM2RMSXJpTlBqKzNUWmdXNzAx?=
 =?utf-8?B?MERmZTdQL1VneVlkblBWYzNVdjJnVmM3TFhCdk5HZXpOQUV5QnRTZjlNSDRa?=
 =?utf-8?B?ZURCVTBOdytBcGtrYVQ0OTFoYUJJUXdMYXRUTTJ1WndpY0ZKUW4xNXRsdG5K?=
 =?utf-8?B?cGRONUszZjBucUpFdnU1RUNyZDdqdlhxYWR3cXhySlV1bzI2aDJGQ0I0N2h1?=
 =?utf-8?B?MG93SVlaVytzVldidHMvQjlWMjVlRnVyNVozVEhGMWpuelBNUUgza2NQNXlR?=
 =?utf-8?B?YW5uMG1OQ3NTa1p4R0Q5NmRNdWk5aHQvT3RmYnBIN0wrTnByOWpRRmRHY2Ru?=
 =?utf-8?B?QmV6RUY4RElzaDhManRSRHhNbHJIdU1CMjZVNTRtbGNBTjZTMXRUbys2U1ly?=
 =?utf-8?B?TFFuc2c0U3BVT3VIRE9sUTBjTGxlb3JEZUZ2cjZrNmNLM2RpWnF5MkE1N0dw?=
 =?utf-8?B?dkpML2krcmN3cE43NnEydnFsQzNPdENoaTdPK0dXVkU5Y09MNWxXK1M1SnJH?=
 =?utf-8?B?RE9FNEtzYzBEa0tGaE9DSndURkh5dkl0UHV4UVVWQ0NER2Y1ZVBNZ1hIQW4y?=
 =?utf-8?B?USt6YUticTRGWDd2bzN1bmc0QXdXeFhlMEVFRUlkWmYxVlJkUjc1MUh3c0Zi?=
 =?utf-8?B?WElhaTBRVUVNQjFRS0ZDOHg2UG9UbVpiMnpOMy95ZDlTWjNmZEx4SEszRGNm?=
 =?utf-8?B?RUFpMGw3ODlMdURqTHd2T3VLVzg1VDFoaWlIcWE4Ym10dFl3MmExRkorb0M4?=
 =?utf-8?B?N0ozRkRyaTRqbE1FbnJOaEMxOU5xeTFBOGdSYWtOTVo2WnUxb0ViN3NyNlBs?=
 =?utf-8?B?NU9VNlZFdXZkYnFZdDcycHJpb1Fvb28vRUt1di9JS0dzd04weFEydS9NU1c3?=
 =?utf-8?B?VWtDcUdjQ0pxVjRyT05ycC9GZjNpWmRPWkQ0S0FhVEdjVk5yOFJFdUhBb0E0?=
 =?utf-8?B?MkR5UXNoajR2TU0vQU5MYnAzNWVtQTVpekZKbDh6eVBVZzJqaTBDeTcxbUJl?=
 =?utf-8?B?ZkxPNDdBci9kWW5hNnFpd1FOMExPYmpPL3I5elR1MFRXNTZzOEFmdGxFdnIv?=
 =?utf-8?B?OU5hNE41S0FIbnBIMUJ0NnFuNjVXRXlxbEhtd2YvVDFKSVNTT0hpSzFpMUdh?=
 =?utf-8?B?WC9TVFpsVUZXQXlZbTlYcmJJT2p6NVdnK2hLSkhNNks4WGlnaDZ4Z0ZNcllD?=
 =?utf-8?B?anNacDVyZ3BPQVd5dFZWVDROcG9BSXNDYk9WK25QY3h0WUQyTEJ5cGFsSml6?=
 =?utf-8?B?SVBZZTZSaDJuNVI1MlFEQ05Cem11MVdNZVFpU2tBV2tHWnVpWWdrRG9iSFRw?=
 =?utf-8?B?a05uK1Uzb2NSR0pTbzJRSFVGeU9nRFpVSFBHaFBvZHloaGRNQS9ud2tKME12?=
 =?utf-8?Q?13b4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3b43be-fba3-42a7-4340-08de3444680e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:22:34.2691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk77eAv8cwYjYCwsSWgGAIH3sh2sWiscrYP5h+9JIb7uqYXUtKQSx/mvgwHxysKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8951
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



On 2025-12-05 14:46, Felix Kuehling wrote:
> On 2025-12-04 17:51, Philip Yang wrote:
>>
>>
>> On 2025-12-03 12:55, Kuehling, Felix wrote:
>>> On 2025-12-01 09:28, Philip Yang wrote:
>>>> To reduce queue switch latency further, move MQD to VRAM domain, add
>>>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
>>>> using one buddy block.
>>>
>>> Why does it need to be contiguous? In the next patch you're mapping 
>>> it in the GART anyway.
>> Without AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, amdgpu_bo_gpu_offset 
>> trigger this warning
>>
>>     WARN_ON_ONCE(bo->tbo.resource->mem_type == TTM_PL_VRAM &&
>>              !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
>>
>> This makes senses because we pass the FB aperture address to CP, this 
>> should be contiguous pages.
>
> That's right, if you query the VRAM offset of the BO, you're assuming 
> that it's contiguous. If you're mapping it in the GART, you wouldn't 
> use that VRAM offset, you'd use the GART address instead. Since you 
> don't want to use the mapping of the BO in the FB aperture (because 
> that gives you the wrong MTYPE), you should not need to use 
> amdgpu_bo_gpu_offset at all.
With this patch, MQD move to VRAM and pass amdgpu_bo_gpu_offset to CP, 
this works with FB aperture mtype, so need contiguous flag.

The next patch with GART mapping, yes, we can remove contiguous flag. 
Because MQD size is small, pinned, use contiguous allocation is also 
simpler to update GART mapping.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Philip
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index 9cd1660b8f60..c11e37915365 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>>>> amdgpu_device *adev, size_t size,
>>>>       bp.size = size;
>>>>       bp.byte_align = PAGE_SIZE;
>>>>       bp.domain = domain;
>>>> -    bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>>> +    bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>>>> +           AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>>>       bp.type = ttm_bo_type_kernel;
>>>>       bp.resv = NULL;
>>>>       bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> index a489d43d5f64..c6945c842267 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>>>> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>>>> kfd_node *node,
>>>>               (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>>>               ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>>>               NUM_XCC(node->xcc_mask),
>>>> -            AMDGPU_GEM_DOMAIN_GTT,
>>>> +            AMDGPU_GEM_DOMAIN_VRAM,
>>>>               &(mqd_mem_obj->gtt_mem),
>>>>               &(mqd_mem_obj->gpu_addr),
>>>>               (void *)&(mqd_mem_obj->cpu_ptr), true);
>>

