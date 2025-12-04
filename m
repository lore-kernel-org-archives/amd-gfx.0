Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7893FD1D893
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 08:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2074E10E8DC;
	Thu,  4 Dec 2025 08:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yrWkIewx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA19110E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 08:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QymD5p9zlWel+h0F3JgW4tSiwM9lCcGG4i+owRY9Oi7jpr8BKeo98J9Kb9tphLLfw4P6sdyXtJ45ZDPn5qCibCCK/n9IQ2AQIRf+ecaRqg8wwuzVxZJ416li5Fyb2kapYQU8yXMS86D8/X8nLPcekNU8vu732Fq+FEo5EBRI3p65myyJ33Q1O1GshuSkSzS1u5BgsJanVBntehGUw5QrGTBAs7fz/o4rGBwtzLVcrhHT244LrDAbjgprfUVEabV+qFJx/2jMdbYgkmxlAwRs0Txq9LIsz2gmSr5LmOdVIqzxFWzlPYFCd+0WBlijpJucqg5z+cndhfme9PLSaYPztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLdtMXjiJOAWQjwEb1MUr1cHRAu7QeJeU3CT94nIcak=;
 b=R8Gz6qlgXyqK2x+7UmdOxee6incjlF8l1Sf1TrtyzWtwCS06r0L//JGg9WVqFETJzsqPs6OPBYPm98w0MTTOha40v0PGYVEe9hHMGpDziNF2xwXUpVgwHbv9NpkvMttTYvukVMe56nE7tEwMPVUnBcR3aDTVhN6TfVvAt3z3lU91cKE6694zUmrRPHqP5ImoJhnBJ343bBiiaY4cn/+REk2Ghk5j/wYD6Xf8sOyrSvYXzOKTqQr7rcRk/nkmBOxUAlFgMQZQsD+gSGxAwcgjGW9cwN68CIgZaksE7a9KtYccJ7HK3fx3d+GzJdBa9ZJ1TBCVY3H2DWeU/PIjjilLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLdtMXjiJOAWQjwEb1MUr1cHRAu7QeJeU3CT94nIcak=;
 b=yrWkIewxFBhJFqETDRsM4ox78bos+f3cmJV9+nCa24Dijrw2rSU94nxiHAS01ntUlf5/LbTLtiIvAwlTorxSp1CpLL420HFz5IotS9H7cnS245tVDd0X64n8bPOFgsPpHE7l0divjdVK4nT32a5nJWAt2b81CGUGaUi/WKcEQB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 08:09:05 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 08:09:05 +0000
Message-ID: <44dab57b-19bf-4cc4-91b1-ba2607a25fa0@amd.com>
Date: Thu, 4 Dec 2025 13:38:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
To: Krzysztof Kozlowski <krzk@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-3-lijo.lazar@amd.com>
 <d5b202f2-c8cf-4b29-b183-e3cbf73f4225@kernel.org>
 <e15baf60-403f-46bb-8a70-f880f8b1d61f@amd.com>
 <80770cbc-0014-4bec-9e3a-1d3db1b98984@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <80770cbc-0014-4bec-9e3a-1d3db1b98984@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0103.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b10598-9628-4c35-5b10-08de330c647d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFdNdGhtbGpPM3REYUE5QllMbGhyNVFWZkVMTEtyK25EWnVuRTU2YkowNXdB?=
 =?utf-8?B?VUc0MlFkNDlHcEtUMnM5YytnL0prM0ZsRVB2QnlESVVITFJpOVhObFNaUkhT?=
 =?utf-8?B?VUZBdmpaSkJkRElVNk9GUzRNVzhybzhRSlc4enljWEh6ZkJQbmFGdS9hSnls?=
 =?utf-8?B?WkxKMmthZGl0S1EzT0MxaEpRYmV5RTA4c2EwWUJ4R0NxSU8wRVl3R2dJeUEr?=
 =?utf-8?B?by9XbThEY2VGZmxJK3pCbDNWdGVGb081L3k5Q0lwc0x0THBQTzJBU0IzOXhD?=
 =?utf-8?B?YVhOM3BLNHVZc09zM0RLUWJGUG5pZUhIMVgxZG93dDJuZXBTS2xtWFJMTFhw?=
 =?utf-8?B?YUJtUkhrZ0I2NFExZ3dUWkY4aXNDNG52UHc5MmZrS0h1RGUwclFGVGEzeldm?=
 =?utf-8?B?TVRaVHlxQ2dxaE9OVTF1dEZwVVBhYjlpMTIrSGxGU2Rra1NoYSsvTTk0TTZ1?=
 =?utf-8?B?NzBDYk05d0RkSm9BOHBpNjZ3S1RMeUNrWlhBZEJGbWU2N05WZjFPMXd0N2Qy?=
 =?utf-8?B?Rm10WWs0dU03T1l2Y0JLNVRIcmdqa0NFMUtSall2cjlvUC9vb1lsQVQzUVp0?=
 =?utf-8?B?VStPbHVGTHFJRkdETmFnWkZJZDBibDRGbGlXYjVnOG8wZGswZ1hnSG4wSjVE?=
 =?utf-8?B?TllxSEVvSGg1ZExYOEFxKzY3Q2xaM2RmRnRrL1JFY0xWQUZIclQrekVBeXlM?=
 =?utf-8?B?ODJqL3c4ZXVXWCtnVnFPbkFXbjNvN3N1NzFnM0x4VHI3WXQ5empWK2JMdXVF?=
 =?utf-8?B?cDVJQTN3by9yTC9pcGkxYmIzVC91OE5IMXluNXVLLzdQWjhrZldEV2lSTkJk?=
 =?utf-8?B?ZEM4QS94UnhKTFJLY1V2MmFqSXYvbW5KZDllbkhiTlBlWVhGR2pUNExiUTdV?=
 =?utf-8?B?ZHJ6d3JTUU1hNjQ2TDh2S2pTTWNqVlVxZFA2TDNyYUd0OEd3dGFodTdVNGMw?=
 =?utf-8?B?c3JLQWxMWVJrR2pINFg3eFIzTmdKamk4MVBVZGtYY0xNaHE1Z0ozcVdIQWVN?=
 =?utf-8?B?dWpmQjd1YnlLNWRET1NBdE5QWHRCbmhlZmlFKzVrSlpZTmY3NUlOREh4TVVQ?=
 =?utf-8?B?elNOcUwxVHY2UEdHQUQwRE50QUFjSzZpSzN3Nyt6U2taa1ZYY25lZlJKS3Ba?=
 =?utf-8?B?bWpMTmpBa25SR2tLRFkycExoMU4rbzRzUXJIMnNHV2pHcmViMGluTzFiREND?=
 =?utf-8?B?Ry9SVGN2Ni8rZ0tSbGhxbHJFc3NuMWN2eExPL2dTYU5hTjFTMDNwQk1WU0lQ?=
 =?utf-8?B?QU1zV01GdmhnVjVuNldINTNKRGNPWDl6UkZYQ1RsVXZJQWN1TEE1dW5PNWdq?=
 =?utf-8?B?WnBoMG1OK3oyYkUxS05Mbm9tTmJLWkRaOTZiWCtLZnB1N0xBOVVJbENxUjFz?=
 =?utf-8?B?WGxLRS9icS9HYzdxbm53dDFvU3FmYk9QeDk4K2F4OU1NL1hkdFg3UGxsVXI5?=
 =?utf-8?B?ZWpqNHN3Vkk4Y25VL0RUY2dUWVlsT3NyOGZEVDFYeXU2U05vUDJ2MnM4NDFM?=
 =?utf-8?B?aEk1ZGQ5ZkN4WVZUT2wwVUIwT3Jkb1NlUG1KMUVkaUJDQjBwcEJLd2lLN0x4?=
 =?utf-8?B?UEFCbzBRM3hjUU9neEJCa1BzdHFOUTRGWjFMUTBNRzJ6anp2VmdweE1KckdH?=
 =?utf-8?B?TE91ZlZWYzhOWmc3aVdNdU15Y2JiaVcxUG93azNpbm1ma2lVSEc3S3BFMjJW?=
 =?utf-8?B?emFqRTRoUlc1UmF1OUJyOE9XOUVtSVExQkpiRnBqakh1Wit2MmdhelpBcU9T?=
 =?utf-8?B?bCtUU0FLYmU2RzM0ZnIweGEzSDRmU01oQy8zVU8xTlBLNG5VWDM3b1UzdXc4?=
 =?utf-8?B?Q3VmL3l3MlFPZ1VSbFd2V2p4SjloUERMLysxSmFYS2N6NndVbzlFQWpESFpY?=
 =?utf-8?B?c05KQjVDbWZrMEZwZXNScGVOVDdhdjJYWW9EU1E3ckhlTXRRNTMrRXRoQjMr?=
 =?utf-8?Q?O7jXniggbwBKOSGFY70Cxf9lmXXeHjbE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXYwVVo0ZUQzazVsZUhZTWI0VGc1ZzgvdE9jWCtuQlFYTXpJamU4M0JaV0Vi?=
 =?utf-8?B?bE9ZYVV1VzhWK3hncDI0aCtmOUxUUUFqeHhoSSs4a05xcDdEUG82T0VWSS9H?=
 =?utf-8?B?eEkzTmRwM2I0T005c2dhZjJRVDc3WWxZMzhkV1ZZdzNaalplL1hRTkpFMnBy?=
 =?utf-8?B?VGFlK1hnZnNYOWpVb3RidXlpSmh2ZXJkY0NEUkNtbzF6R1p1VmJFcG5TbFVH?=
 =?utf-8?B?TU9UVVZGb0FFUkYxSVJCb2ttTTdEN1ZIZmJvY2VmSXAwWnlJMVQxWElWQnkw?=
 =?utf-8?B?Ni9NNjErSHVITlJtaHJTYjAvZDFZNE0rbTdkZ3lJTWVjOXdHUVg2L1phcGRN?=
 =?utf-8?B?cGxGQVZCblpBcnVaWThmSktNUDlnb3N2aVduNkJhVFdPdFM5eWhyYUdzRlVk?=
 =?utf-8?B?ZGdQYXB5c1oxVGJTMGdQZU9UQk5oVmZ1TlFmb0FQQjhIeDdLeDQ1YXVYVmNX?=
 =?utf-8?B?UThOVm9Fd3NMREZBd0pCZlhtK1ZzMEU4WkI5OFNxNUxQMEUwVm8xaS9FTTJO?=
 =?utf-8?B?cXZZQXNBbzNxcE55Ykx3bldaNEt5OVd5NU11TTJwQUdhTFZxcExaZmFqRVM3?=
 =?utf-8?B?OW1uM21lRCtqc2xrUVJMMUd3Wm1IU3JTMlNLL0NoU1lWcWRuWTUwTDB1Vi9s?=
 =?utf-8?B?eW5iWU5iejVPNHdUeTU2b2IxOERiZnFPclBPN1VwWG90RlZSN0dhY2d5QUZU?=
 =?utf-8?B?R2c5enh4c2lJRlpYT1Y4dWZ5MTM3SjF2djhyQys0ZW5iOFN6bzQ4bzV6bUZF?=
 =?utf-8?B?V2EyeHQwVXJVQ2JySEpWdWZybERQaUNZZVd6Y2RRSEs3VlR3K2hiYUxOSWJM?=
 =?utf-8?B?dUgzQUFTSkpNN04wN1VOd3psN3B3SlFxWDQ5cmN1RU5aNi8xTTUvRWNveHpX?=
 =?utf-8?B?SzN6MTRUdWZVbHVkbjhrQ1ZJd0F1NjdhQUEyWFRoMUZKeFpsRFBQYjhKN2tM?=
 =?utf-8?B?aDB0V1dnbzJabnkvVFBISzdvQTZsRFZreFpDbVVibmZkM3U0MTFsc1pzQ2Vm?=
 =?utf-8?B?THR1cEQzMXJKaHdnVzVEbFRhL2dHQTFsaFZYMDloQUtUNlhFcGg4RGdnM0I2?=
 =?utf-8?B?YmRqblpJeGkyZVd3cWl5RVEzMGdwUm1PaEFoaHFUSVJBcis3Rk14MitwSWhu?=
 =?utf-8?B?aVFQd2dISmdySTVBeG5SWS9maGRxRW4vTSt4dXczQzNJQW1kakc4WlJweWE5?=
 =?utf-8?B?Y1d2RmNNUGFlNS9PRjJHRkx6N0w4UUR6a2d6cWhqalhNcjQ1THA3QXZvVjJM?=
 =?utf-8?B?UnI3NSt4VWF3NlRlaDhzZ1h0RFdmYnBlRDJlY1ArS2J0ZkEwWEptcjZLdSsy?=
 =?utf-8?B?aUo3a1QwaUlyZ3lhb1Znakt1TjNTamhvQld0eVRWeXhQUUNSS1o1MnRONXJv?=
 =?utf-8?B?VDVleWNyNmdEY1F2eTF3OGRVTDhGOTFwRHRKM0t4WEpNMDRFeERxTlVLSjVk?=
 =?utf-8?B?eUN6UUNTU25ub0diaEpvclZUbjQ2R3JxdDZUZHpidUtFaCtjYkw5eGUrZFlh?=
 =?utf-8?B?Lzh3a2doU0YxZ0RhZlA4ckMvejJCcE9XYUZlVS9GMFloWWFaYm9idUlrVGpL?=
 =?utf-8?B?WkJjQWJvbzVqaUFPTkgveG1IRmQ1RlRIaXJVTTVReW44ZDNWdmh2cEQ2Z056?=
 =?utf-8?B?RHRYR1VyaitJdWN1VmpRdzV3K3RiUGo5YkFzNlNWY0k3bHBnY0MyN3g5by9Y?=
 =?utf-8?B?bVJCV1VNYTN4NXltamNoeS9uL0JYOHI2Nmg4bHl1cFdnNDJwN1REUk1Qb2FQ?=
 =?utf-8?B?TnR2RjJhQ2JmZGpBNVpwWS9CUGZSTkZmTnVmMkVCNFR1YzB2dnh1QzNKSHlw?=
 =?utf-8?B?d2FaUjVQaDIzRUh2SUlQOFhSOXBzL0E0Z2tLbXp0ejRpZ3lPSUtQRmF3aXdo?=
 =?utf-8?B?aXdMcFp0ZzNYMU8rVW5FUFRnbTM5eExNdEVuVjNTbU8rOTh0NHlrTVVPb3NO?=
 =?utf-8?B?aFYyWjN0dHRxclAvKzAzS2ttZUR3NDlvZ3pSeGZVdXp3NEFiaFRDY2RJOTF6?=
 =?utf-8?B?Q3EyMTNNWGROemlESm5EMkt5NHRxVXFhK2JiSHIrVmdwTm1MaGZSKzVscXQ4?=
 =?utf-8?B?akx2d1RxRy8wdDduWWZyb1dMMW9HR0EreWF5Y2t3L2FnY1FOZVk3blM4ZTFW?=
 =?utf-8?Q?z1iLtY9JT35EW1IsRcehI2FDk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b10598-9628-4c35-5b10-08de330c647d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:09:05.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZCrSgNAymZacvRg50WkNWYBOW9OUxIlXAFvRgo99asuRr0l7o24uazcola7roAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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



On 12/4/2025 1:36 PM, Krzysztof Kozlowski wrote:
> On 04/12/2025 09:03, Lazar, Lijo wrote:
>>
>>
>> On 12/4/2025 1:06 PM, Krzysztof Kozlowski wrote:
>>> On 03/12/2025 13:54, Lijo Lazar wrote:
>>>> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
>>>> +		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
>>>> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
>>>> +	} else {
>>>> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
>>>> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
>>>> +		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
>>>> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
>>>> +	}
>>>> +}
>>>> +
>>>> +int amdgpu_cwsr_init(struct amdgpu_device *adev)
>>>> +{
>>>> +	struct amdgpu_cwsr_info *cwsr_info __free(kfree) = NULL;
>>>
>>>
>>> This is an undesired syntax explicitly documented as one to avoid. You
>>> need here proper assignment, not NULL. Please don't use cleanup.h if you
>>> do not intend to follow it because it does not make the code simpler.
>>>
>>
>> Could you explain more about the hazard here? There are no multiple
>> cleanup variables declared in this case.
>>
> 
> I am not saying there is a hazard. I am saying that you do not follow
> coding style and very explicit, documented rule. There are exceptions of
> course, but they need reason and such is missing here. You made the code
> worse here, more confusing with the fake assignment, fake constructor.
> 
> If you do not want to follow cleanup.h coding style, then simply do not
> use cleanup.h. Cleanup.h is to make code simpler but worse.
> 

Got it. Will revise this to make the assignment in the next version.

Thanks,
Lijo


> Best regards,
> Krzysztof

