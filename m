Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E6FD116EC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 04:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FD410E0A7;
	Fri, 25 Oct 2024 04:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1TupgJsG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A4C10E0A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 04:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLZ1RkEQEfK/xZG3RuXYLPO9GOX0e8bkmxiPnp/kKobRGcY7BX5LBsnubh1bo7Wv91Hoe+wDufJfmU9GKVqZLQVs56xfTnMEvXln2SNUrM4s78EpefyDT95cKBosjQxnTQWGy21K/5zgRwLqMpm6Kard8eIqWccmTIxKt1z727adnWVcuADylIj8ST+pskd4ke6kJxWgXUBykFQUdAS6WuFQPp2gPEeyWfc+Z2cQvKE657dwdPzJMadsZ5KD1uNrhg47+cD7yLdiEfCdZS7TKNSnmaJJk/DTT0taoC1cgEQMc10QXMN4wgNjeZKyzD1NfcjhALbW0DpS3PM9ya9izA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfwOqpFjkFIwzZehEMIFk0IAj+6vxxDbNqVeaC9TfKU=;
 b=wJz7sAk6N33G7fzbF7JEInCNVyc0uzuYGOtNCwPyIAYkZrByFE6wHOyfV8+RkJGw89M6ucGFXtgyDBdbu9i5JTQfl4puOg1Cfw4ZPhLfbgEgd+Sw0OSbO52vwps+blnQs/P3kpS7jA24yQ6X5Sr4YEn+Fpc25JQQa60SwTYGOr9Xd4fxzXa9SWtdf5FU+sFfxc5aJVwQwSUP2FjmuB4BzLXsCK7q3xhnRTANPChAxRMa3GGzUSW6Mmbo2uOs4VDjJnHUC0P8yFlkoczDO/ojKFAKOaXEJjRwyfVUtDewGr/53e8BGBP0R41/nCkZxbcZqzI7ZQnspLw4JF4h1xNpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfwOqpFjkFIwzZehEMIFk0IAj+6vxxDbNqVeaC9TfKU=;
 b=1TupgJsGm/Dh8TIhgLn0byKIqo4axAL6/Sm21MOXVwmrAmp+FD9PHtM/YDTa3YRE6IOJ4epNqxxv9TwymEH4lplQ0pvji27FhexlfRecmvBlPD6XnlL4i6Ms+5UsPOmudU/jtiVgLzKbje3sBEjzawY3vrVrC2L3lWYSszKZg1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 04:49:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 04:49:06 +0000
Message-ID: <7c773395-9112-4bfe-8774-01a487bfb55e@amd.com>
Date: Fri, 25 Oct 2024 10:18:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241024082159.45701-1-Prike.Liang@amd.com>
 <20241024082159.45701-2-Prike.Liang@amd.com>
 <5eb496bc-f0dd-40eb-8eb1-3b97771384d5@amd.com>
 <DS7PR12MB60054EE24DCE9FCD0FD1979AFB4F2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB60054EE24DCE9FCD0FD1979AFB4F2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eb6b0f-2852-409f-adae-08dcf4b05b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3FNUyt3T1RsUng4MC9RRGFKYi80QkRiRTkyRDFmNWdBY1ZEOXBJa2dubmVs?=
 =?utf-8?B?ZmtiLzhDSHdvY1pJR1VZaE9yTmsvdXBvR2ZvWnE5VG0xQ2diZSs3MStld2Z0?=
 =?utf-8?B?azZxRUM5VkJpVFptZVMrNEx5TnlkeCs5d3V6c3lwV3FtWkVrbFp5VGRtWGQr?=
 =?utf-8?B?YS9sN0FkdmlnWWJhWDBBaGMzZEVUWG9hM0ZpbzczM3E2TnZWOGRRRm9lVUU3?=
 =?utf-8?B?VTZjaFhpWEtIQVRuUVZlYlN4UlNGOEtXT3ZwdngwWUhPYUdDc3JJTzRXWXVD?=
 =?utf-8?B?N2NIRVJlSEZSSFArWW9keGZZdkpYVXpDU0dhQm9haVhjV3haNXNuUU10b1Nr?=
 =?utf-8?B?OTNCbUdtTWlqdDJUQnFOQU1qNWFrMlQwNmlQSngzdW5qRWVzMkRJR012U0hz?=
 =?utf-8?B?Y1NSalhtaXQydGpKVkVDQjhRcXg5LzNUdWNtNUdTckpCNnozV1RXUEM0SlMv?=
 =?utf-8?B?UGM4L0d2TU5hVnkxRzlZR0ZJanBnS2xhNEt1T2lSNEVKenhDK2h3aitoS05a?=
 =?utf-8?B?ZlZNQnpTcHhWa00yMEpSVnZiZnZDeXZCN01rSHFQZUN4WDc4U0hQckNJdXhj?=
 =?utf-8?B?WUI1ZVRxaWEyVXFiNjlGaXdZSkpOelJ4Q3kzamlhNU9lUjMyNUdPVXpsMW9x?=
 =?utf-8?B?Nk8rOXlHL0VzNmYyTENXL3YxclNsRDd1ZnQrZmZqSTMyNzdwMDIyM21VczVs?=
 =?utf-8?B?ZFlDWGxrR1E3bmt5cnFQWU90dzR6Y09yV2U3SkRkUTJVb0JYYWRiTVlQbkZt?=
 =?utf-8?B?cFRnL05NV3JzN3NKV1h5RjFkV0RJb2FwejA4YjF6UVIyUGtxUTFyak9PaDdO?=
 =?utf-8?B?MTdXNUlKVkxrUWVNSGprRUQ5a21OWGQ0eGY1YTNqN0pmUG5nNVRpS0pUeXhn?=
 =?utf-8?B?cE1aTXFoZDRhQUdBaEMwUEgrQnJmc2tIU2JTR1hTMU5Eb0hFZjA2RFFvcVhT?=
 =?utf-8?B?NkVSZnRjZEdxMUJhMUlyUUw0NWVXRkl1Qmw4REdKUURiZnhhL2pBblgxLzEy?=
 =?utf-8?B?SDBYTTdtS2VIRmpMQUZHbUdOVTRUMFhBaE1nUHVCdVFuYktpZHQrSGtaeXN4?=
 =?utf-8?B?Z1EwMTB2S0gybzJSOXFHWVNkNEY5L2lDQ2lwR1pRTVd4ckl3K0UxUFpDM3FU?=
 =?utf-8?B?ZkRTTUVyZGV2K2hodGM2RTJLMndNS2hsTklwclozS2ZTT0NMRThQYWdqU3Fj?=
 =?utf-8?B?OG81aUVTdzJ0c0s4SG1GOHdFV0VIVnJpZ25JN2RnODRmZC9Vb1lnR2NJSENE?=
 =?utf-8?B?OWV2WThqSUgzM3lJbUsyd1Erc2psNHl2cDQrWm1VQ2ladWZRbnJJaU1HY1Bm?=
 =?utf-8?B?dVlod1I1VHpsUVU2WXJxSGNMZlhqemdjMU5ySUNUVm13UkltMGdBdzNOYU96?=
 =?utf-8?B?d04xaHBxZUx4aXlYVGtteVB5MTNxeEk4eDg3M3dyUXVUa095Njd5V2pHcHho?=
 =?utf-8?B?M1NhWVIyRys4SWdOU1pkKzU2ekp5YlRucG16Y2tzUk1SSURjcVJoQ1QzajB1?=
 =?utf-8?B?SnIwWTByVjNib3drdWtlSVdZUTIveTRYdHh5cnJydE80VkFDaURXcEZaS2U1?=
 =?utf-8?B?RGNwN05OWjZVTjBBL21kd0xhaW9Eb0xQcSs4NVJ2aVhncG9CNVAvSmc2WEpv?=
 =?utf-8?B?cTcxeUo0UTFNWUNtK2FIU3FyUTFZYm5La3pDMnVtN04zaTh0NjdBdUU4U0FW?=
 =?utf-8?B?ZDBsNFZpY3hXTGNhVVdJZ3BFamxTdDN2VzhYYUw5TjVSZytDbEJZM25tS2xG?=
 =?utf-8?Q?zIRu3p1ytrV8dJl2jWyEVuI0ckdnyUeR/s1Vrb7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzN2WDRLWTJRWFNJV0tMU3Y4N004R3F5VEFscG9qbDdUSk1DRWxwTDR2b21K?=
 =?utf-8?B?V2VqZTdOZFhtTU4xTlBPbXczSytSa2JzMmJ0MExzekNxdFNrR3F0eGQ1L0Y4?=
 =?utf-8?B?aVVMbWFVZDBxQVozZlZGVjdpU1BIVVlsMnVxdUdqdnVEYzNlWXBaVnhQNGNY?=
 =?utf-8?B?NmZuTmJ2eDRURllaWVk4ZzlmMElYRm40TjdxaFMwZlYvMUFpa0xUNVV5NnBw?=
 =?utf-8?B?ZTFJV0xZTEh6T0RGQjZzRFRudTFSTVpBa0NkblM0aEpUNTVVYThsdHV1WTNR?=
 =?utf-8?B?QWg0bjJiL1ZhYWs5STJOd2VrUmtxek0wcGZ5R3BMMTlJNGVick1jcDZWRHIy?=
 =?utf-8?B?VHVZWWZ2a2RKYk9XR0R1M3kyNVFwNWR3eHBuNVBtMlorb2w2aGE5cmhTMS9y?=
 =?utf-8?B?SDl0REpQdFdobzVhY2JPWjI1ZkhjcVh1clUxWE04ZHhLbGp0bHF5L2ptdHFZ?=
 =?utf-8?B?VXZNYkhwREowVEovTkpyamZjK1JuZjRSa3lmVFB2VDQwMzJiTzRpYzRzWDJt?=
 =?utf-8?B?Q1dPcC9iSWQ4Ti9lcVRWeGQvMmM2eXZhSkFQdlJaVmlTWG1DcWh4ZjJZeFZk?=
 =?utf-8?B?YXF4aE5VZDNXM05zSFplN3BoN2NpUGZJVXdKUVpoZ2V1TUtYU1pYSDN6OEg5?=
 =?utf-8?B?WHdWQjFLaWo4ekRyTlBJQ0l6bnNhUmhmMjhnQ1RENXFPRDg3UEJUZzhnYTlt?=
 =?utf-8?B?SmRJYmZ2SmFVMlVRODBmb1BXSnY3VVl6azhEMmhkSFdybWRNM0pYZWY0Z3RH?=
 =?utf-8?B?UVJnNFNPOXJyU2V4QWlxTmkxTlluak1KOG1jWlBybUoxODV2bTFwbzlRT0s5?=
 =?utf-8?B?UTVHbHlBMmhKM1FzZnllYUtJZnZTVTlQR3RnZDdpa3ozTmM2Vmo4WndZQzhF?=
 =?utf-8?B?czgvS3NjelBvanFjanZHM3BiU1NwV2IvUjFIUW5TcVVubk1Gc1pKaHVxSzdo?=
 =?utf-8?B?YXpSSUtNdys2aVRBMHRFUVc5N1o5Z2UwL0x6b0gwbjN1TGIzMlovVzRjZ2Yx?=
 =?utf-8?B?TkprYk00SWZBRnk5N3JJZlJWQ1hPM3lVcWFRZUQvTTlnM3JYV2FaYi8vSFVR?=
 =?utf-8?B?YzJUYjhXUkdqRUtVZGhkcGsvcHAxVS9aZm1lek9lbGZqaUlyOWY2RkNnZXJ0?=
 =?utf-8?B?RTNBMjlNaHRkU3E2bGJZN2pWcDVLVTEwVGRqeHlFS3VyOUdqN1lOVWxDeTdm?=
 =?utf-8?B?bDQwWkFVYVRINGpsM0VJOTBlSFNEd2ZRK3ZQT2h5NnF5V3l4WFNWV3N4OFZ5?=
 =?utf-8?B?NENPeWxoVldmNzhiN1prN1FjRENzZEpSdVhySUNBelE1V3ExZ09wVUM0NlBs?=
 =?utf-8?B?ditpZDFJVzdCZHZ6aDdqV1c5eEw5eTdZK1JobWtVVW04anNvdnBJMlNVZDBv?=
 =?utf-8?B?emwvZ3E4dnVWbUthdnkzYkhrMlRrQWV4Y0dSKzVkYzhLQisvUzJ5eGRQWDFu?=
 =?utf-8?B?dC8xNFR3MlR1YmFaVDROUXJqZm14aS9KNEM0OG40NzI3SEdoVHFZZHdIeWhG?=
 =?utf-8?B?WGxzOEU5Mk5QNTlHYXBJK0tHNTZJWEFVRFI1MFR5S1BQVEVOc0RjTzNDV2hw?=
 =?utf-8?B?VHh4Y21BTlgya2JjUE9uUWM0cXZRcmo4OERJUTlHbFVTcTBEb29RampEcDNv?=
 =?utf-8?B?UEJlLzR4Z2IrNjdrYkVJRkFpODg5bDYvSFBMYmhadDRFVHJHbk9HYzRjenFh?=
 =?utf-8?B?K3ZlNnU3TjBxTDlVWURZdGZsSnQwQ00zTGdPT2F3ZHVqWFhpaklyQkdLUmFS?=
 =?utf-8?B?SnJaYko5ZE90ZjhJaGtVaFRUUGo3RFdiTTZEYi9EckovejlKemRtZkpOcjc4?=
 =?utf-8?B?MVNlUUR5aDBjbWdKSTh5THh6dlM1UzNPZWc2OVU2ZXlIcVNwSlVCS2pFMy91?=
 =?utf-8?B?RzAwTDRCbmxCRzE5Nll6c1EzL3pNY3JHaHErbzQyMEZpbU1hYndxSm9JRC80?=
 =?utf-8?B?R0V1WHNVMjBkM05RZ3N3cnU5ZnpUS216Vk5Ua3RLYVZsMFlTeFVKcHNMRDJH?=
 =?utf-8?B?RkVpUFBhNmoxNGpPUmF4dDNQdHorVkZyRUpEcm84ZnY4cmd5c05XZmd6VE5K?=
 =?utf-8?B?b01Rc3Y1TmR1ZkYyaDZlZEsxZWMyYlRxbTJkYnhnb0RYNEJ4U0xneG5NVjc5?=
 =?utf-8?Q?WB6YIlk3Ol7aHJynvKjwQf+RK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eb6b0f-2852-409f-adae-08dcf4b05b2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 04:49:06.4608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9jfVNK4kbJXQii+PsB5MzZJ0ivB6gnnwfISegM/9K4TOFKcWINdKx/qbpl8w4d5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618
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



On 10/25/2024 8:54 AM, Liang, Prike wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, October 24, 2024 4:40 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v3 2/2] drm/amdgpu: clean up the suspend_complete
>>
>>
>>
>> On 10/24/2024 1:51 PM, Prike Liang wrote:
>>> To check the status of S3 suspend completion, use the PM core
>>> pm_suspend_global_flags bit(1) to detect S3 abort events. Therefore,
>>> clean up the AMDGPU driver's private flag suspend_complete.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 --
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 --
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/soc15.c      |  7 ++-----
>>>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 16 ++++++----------
>>>  5 files changed, 10 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 48c9b9b06905..9b35763ae0a7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>>>     bool                            in_s3;
>>>     bool                            in_s4;
>>>     bool                            in_s0ix;
>>> -   /* indicate amdgpu suspension status */
>>> -   bool                            suspend_complete;
>>>
>>>     enum pp_mp1_state               mp1_state;
>>>     struct amdgpu_doorbell_index doorbell_index; diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 680e44fdee6e..78972151b970 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>
>>> -   adev->suspend_complete = false;
>>>     if (amdgpu_acpi_is_s0ix_active(adev))
>>>             adev->in_s0ix = true;
>>>     else if (amdgpu_acpi_is_s3_active(adev)) @@ -2516,7 +2515,6 @@
>>> static int amdgpu_pmops_suspend_noirq(struct device *dev)
>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>
>>> -   adev->suspend_complete = true;
>>>     if (amdgpu_acpi_should_gpu_reset(adev))
>>>             return amdgpu_asic_reset(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index b4c4b9916289..6ffcee3008ba 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device
>> *adev)
>>>      * confirmed that the APU gfx10/gfx11 needn't such update.
>>>      */
>>>     if (adev->flags & AMD_IS_APU &&
>>> -                   adev->in_s3 && !adev->suspend_complete) {
>>> -           DRM_INFO(" Will skip the CSB packet resubmit\n");
>>> +                   adev->in_s3 && !pm_resume_via_firmware()) {
>>> +           DRM_INFO("Will skip the CSB packet resubmit\n");
>>>             return 0;
>>>     }
>>>     r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> index 12ff6cf568dc..d9d11131a744 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct
>> amdgpu_device *adev)
>>>      *    performing pm core test.
>>>      */
>>>     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>>> -                   !pm_resume_via_firmware()) {
>>> -           adev->suspend_complete = false;
>>> +                   !pm_resume_via_firmware())
>>>             return true;
>>> -   } else {
>>> -           adev->suspend_complete = true;
>>> +   else
>>>             return false;
>>> -   }
>>>  }
>>>
>>>  static int soc15_asic_reset(struct amdgpu_device *adev) diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> index c4b950e75133..8d5844d7a10f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>> @@ -897,22 +897,18 @@ static int soc21_common_suspend(struct
>>> amdgpu_ip_block *ip_block)
>>>
>>>  static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)  {
>>> -   u32 sol_reg1, sol_reg2;
>>> +   u32 sol_reg;
>>>
>>>     /* Will reset for the following suspend abort cases.
>>>      * 1) Only reset dGPU side.
>>>      * 2) S3 suspend got aborted and TOS is active.
>>>      */
>>> -   if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
>>> -       !adev->suspend_complete) {
>>> -           sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>> -           msleep(100);
>>> -           sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>> -
>>> -           return (sol_reg1 != sol_reg2);
>>> -   }
>>>
>>> -   return false;
>>> +   sol_reg = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>
>> Actually, two samples are taken intentionally to make sure that FW is not hung
>> before deciding on reset.
>>
> However, the original two samples cannot filter out the case where the dGPU is completely suspended. When the dGPU is in competition to suspend, the SOL remains at zero until the PSP resumes. Therefore, the original two SOL samples checking will wrongly reset the case of the dGPU being completely suspended. Personally, one SOL check is sufficient to determine if the dGPU device has been completely suspended.
> 

If the dGPU is completely suspended (D3), then those two samples will be
0. In that case, there won't be any reset (sol_reg1 != sol_reg2).

If it's ticking, then SOS is active - then a reset is possible. If it's
non-zero, but not ticking, FW is hung. There is no point in trying a
reset as FW needs to be active to do so. That case will eventually end
up in a different failure.

Thanks,
Lijo

> Thanks,
> Prike
> 
>> Thanks,
>> Lijo
>>
>>> +   if (!(adev->flags & AMD_IS_APU) && sol_reg)
>>> +           return true;
>>> +   else
>>> +           return false;
>>>  }
>>>
>>>  static int soc21_common_resume(struct amdgpu_ip_block *ip_block)
