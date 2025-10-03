Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B48CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 21:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A3410E983;
	Fri,  3 Oct 2025 21:46:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7JUR3pf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B73F10E983
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 21:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl8j8CJQk2W37ckeS5CKGeg9NkXhw/DJaETP52Ufh+ubjBbbI4ygOWrKps0vfdPOtU3yaZ0n6OcV9++YFia8mP0AAkTILt4qAiIWUttuKw94ZDGG+ttrpzx15/pST3X44Iw+vrfSE1OblqmROpvf5aTpEwHTQnr9bFnQTkUAlFBkikEqICjZ55sT/sAyXhIGaJaAurKDm65nWl0JAdXzKYFC6p+rf5Bs6oKOvaKIRvRUQs/VruQNa6UHhx3qRUOCb6en3rNcVDz8CidlxV0hsy2veXqqsfrPanh1H0TPoFVRSDs4mU10p+EiwoAI20BYDnqTR8I6nd409UQy7ndLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzu0FOLzptgIvr+RSR17DY32jEJbqYoQgzHDCX6p+bE=;
 b=C7tlRXloDw4pv2oDTflu/c+t2XP3T/E5ComReacOo1TGxWJgLEcEdOwT5eqto/L32XClYxvPSp855G0kRGrIjNxMxxNiUr4iYfQIjl3WbhOGZAGCphRefdOzLnweeORUfVbCq1KlUHn8Ko96GfNE1EpflsY3lD03KtYeex+sZXj80sU8nhKnlSa2NhZyAwNzZRcGgmBtXkMgu9+siAyk0xFbi74BCDSByY2Da9bkB0Oj5BldFXF0Y/lm0+QHdt1870kXKordlRLx0lkfc8/KlRKcZrHOWCd6BxfDEght76bpMbaJR+2ZRvQ1z/Ar82+fvvAb211LlyFud2U5CiOPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzu0FOLzptgIvr+RSR17DY32jEJbqYoQgzHDCX6p+bE=;
 b=E7JUR3pfhgoeMvpu9W8qLJbdfwonji5viQ2mqYrXbl+tfE3ms/+/ax3y6y2a9bwgypMOtAU8FXijWaxHhbER7tX99H6mPpfPj1p7357A70dUpxi1+7LhaTilu9ptbHIRi474/6uUHdpH0dEtQLxoq+2ZznRG9QgAdMcXoNBDJsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 21:46:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 21:46:15 +0000
Message-ID: <1fecb017-1f23-8014-f9bc-4b86d0736436@amd.com>
Date: Fri, 3 Oct 2025 17:46:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] drm/amdkfd: svm unmap use page aligned address
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com, Xiaogang.Chen@amd.com
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-2-Philip.Yang@amd.com>
 <2ac6c9db-ea01-4598-ba4b-e264d973633a@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <2ac6c9db-ea01-4598-ba4b-e264d973633a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d28356b-c754-4c8c-e6ff-08de02c64743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnlTQ2JXZGhhSjFxVU13OU1hYUUxamRmTWhzTnlXY2JBc3ZicVNweGVCY2Uv?=
 =?utf-8?B?ZGlkTTczZ0lFSTFSYzZjVU41ZWdoRi96aVlUNHFyclcyR29XdytDUHFYUG4z?=
 =?utf-8?B?eWdwMDVUaFk0bTRaK1lSTkN1azN3VlVuM2t2cnI0RmthOXVTbklRYVc0dmtL?=
 =?utf-8?B?MHorSTMxV0swZkF1YzBTL3FFWHZCK3g5SFE5TlV0M2JuMEVzU2grNEsvV05t?=
 =?utf-8?B?OUlRU3MvY1ZMZ2h3ZC9QRHdBREhlQUhQOExCUWxSU09UQzZ0bmJkWEYxWkFX?=
 =?utf-8?B?NVRiRE5MVmM0QWplWUlqQnhqeWxWQ1dFMXBSc0NGaEhNcGd1dW1MNjJJYjVq?=
 =?utf-8?B?WVB1ZVJkQWdwdE9ZRjNvanh1RitESDd4UlZLcmpSclZJS0NRZWU0SWFFVmRH?=
 =?utf-8?B?NngwdVpMNzhvR2VVN0ZpQUxvTXRlWDAwYmJrZVJOZzdDbWJBdVFucEc0VVUx?=
 =?utf-8?B?OFFMVmYrdlpmYWJQWEVMeHM3YUdVd3lReW5YYUtWYW9yVWd1cFFyY0FhZEgz?=
 =?utf-8?B?Z2Y0SEFJUWI2YXdWcnp1cXE4WVM0RVJBQ2N2TlBrNjYrS2lNMG5EaDVjQXg0?=
 =?utf-8?B?RjBNYjM3MTYxTXlnSkx6Z3ZPQmQxQlJaVy9HNG5RdXkvYWdwSlR5VEdiSDV0?=
 =?utf-8?B?N0Exem40WDVlOWJsSnR0WVFRZ0dWYUVmZ2hBNG83NG1NZWFicXV3YVFMbWUy?=
 =?utf-8?B?cUp2R1VvS0VrUW5jYWlxb3JvRHZMMGxUWTZXRDhabjhiRm5mTm9mdUY3TkUy?=
 =?utf-8?B?VzZTUUlQQm1Ua3FwSEJjSWNZZ2ovSlB6b2VmMStxRjJCODkxSm5wREFWbDhp?=
 =?utf-8?B?UzJhQVJlbTBKSFlFSkV3ZkN2TWIzRDRybkczVzZaejJKL09TMmR6b1ZQS0RM?=
 =?utf-8?B?aVk3MmkrazdrQmw5SytvVm5uc0pMS2hEWnRzdDYzUDNIaEtuRk9tbWMwcWhM?=
 =?utf-8?B?Yk1zV3ppQkxIb252VTZ6eEIrRmhGMXplK291d0JYSTY2MW55T08ybXpKNDJl?=
 =?utf-8?B?TG5UL3FrUEZuOTJNVG85b3BXSWtuMFZIUExsVnYwcmIvTVQwVTN6d1Q1alY0?=
 =?utf-8?B?dWx2ajlrRDJzTE9BT2swcnp3WW40WXBTYVQxeFlOQktXeCsrelNjaDQ3RUp6?=
 =?utf-8?B?SkpGekxFc2Vwb2ZKSmN4cHZFbkpQS2UxK0wyQUgvbDcvUVl0azhHUGVRVmI2?=
 =?utf-8?B?RzJtRjM5NmZtT0Zla1lQQUgzNnFiMFpTZG9JZ2JNa2ZyenN4NEN0clI1ZUQw?=
 =?utf-8?B?b1E3c0xuMGNhZU1JUWdzdm1tUy9RSEpOSzR6TXJsVnQxVDdOellBNmVmejVh?=
 =?utf-8?B?amc5anJMWXVBWDM4c1dubi9YRXVKQkh6Y1liU3hwaTE1eG9JeFB6a2kxZENv?=
 =?utf-8?B?YWtWbjV0VEFXN0RlY2pTVTN6MHkrMDFiVVliZThmYnhSQ1hDZ0Nlclk1djZY?=
 =?utf-8?B?VXJpTmRnUnltc1FNT0c4ZzBXcTBqWFZrQjJQcEJtc2xBZmJEYWs1eU5UOStx?=
 =?utf-8?B?K3RYM1kwUUVOSTFqR2ZwMUZnb09uK2Y1eTI1THhsYVFyLzljWFB0eENucUto?=
 =?utf-8?B?dzh4K251QWVteEhrY2g0eGJsTXdnWXROVGROQm9UZ2R1anBYdk1jS1pINnk0?=
 =?utf-8?B?T2tZY1lrMEdkNktGdmJEeU5RdUhYNldxT2tseklhUG84MlRvamwySUhoN1dw?=
 =?utf-8?B?eFdIVXN1MWx4WHFTQmFCL0M3NjlIOXdmVDkvNjVJSFRpaFNGUERhU1B5alRB?=
 =?utf-8?B?UmkwTGZEenB4Rk9vQnZOUW9WNW9xVzl5RkVRNC9nQjlHUXR0a2NKMGROeWs1?=
 =?utf-8?B?NzZxY3RsdjVmcXA0WmhXdWlKb3NtTXZuQjcwVXlaNm9vWlB5YXJuRVZZKys3?=
 =?utf-8?B?cGZxYTRaN1FtdnNkejBHbkxSTUJLM0J5blFNTHpocVBxWnNvMUxkU3hFaUVH?=
 =?utf-8?Q?tDgUWKgmrO8UdXjYZmhKN3xB2O4t8eg8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZLS3VvRHVkd1lUcDR0Q1NYWUorZGhyaDNDZ1R3b25Zbk5QMHBya2dUL1R0?=
 =?utf-8?B?TzdCR1Qza2lwWHNjV0xqRWJtUE9zOWtLY213NjE2dEoxZWRybzZ3MUVsV1VS?=
 =?utf-8?B?Zkg1U0QwaGxHL3pKMW5ubmxsb05TVjdocEhndC9EV0ZMM3NiM3QzY1MxOWEw?=
 =?utf-8?B?VVpwbUpPSzJlM3lQN1paTjNnS3lJZ1JpdGxoSnNZZHdHcC9EWjlJUVVjbk9r?=
 =?utf-8?B?Ris2TFBhRVkycnY0VHBCa3c5aGFWSkE3SCtTOXduSE11YTU5WUNnTjliOGtk?=
 =?utf-8?B?a09YNW11T0hjSFc4SFc0N2ZkZEVkZ09yYXJjckxCd0pha01aSjNsR3VQUHZF?=
 =?utf-8?B?RkxqU0xFUzA3V1NlNXBTL0NUTkVwd1h2YktQRWNqM25UQkg2TE9ud3R3alhN?=
 =?utf-8?B?a2RrLzdIVVJQWUlzTXpBQzdrSWh1QWY3NTJ4bnZ6blI3Mk83d0p6RlBvbHlX?=
 =?utf-8?B?MzdZZlhnS2paek5BU3NId0lLZml4dFBGTXV4UTU4NUVuRjVwcWsreDljOFdz?=
 =?utf-8?B?Y1BZRE1UVnpwZHhIN1VqdXIwVllRVVRINkRWS2hNOGNwaldjYzRxdThpNWlR?=
 =?utf-8?B?Y3pGWGVRWFVYb2FaVUxkRG1jRlVqeGtIazhyZXlkV2ErQVppdVJ3ZEpEdXFM?=
 =?utf-8?B?bEFxdWxWYXVEdUFBZTNrOVBwbGRGYXppT0x4b1BKTy92emdDWG9pRmJ2dUdv?=
 =?utf-8?B?WnhMaUlZQlZjblpaUjJLS0MwdnJad0VsWnRla1dOK3JBMGpnVTZtVWRRYlBr?=
 =?utf-8?B?UzlWVUsvcDdoTGJnU2JiTldvMk9jOXFhdzM1aTZQc1VEc3NqMU9vUW4rU01N?=
 =?utf-8?B?YnJ6RlRZWXQvZndFTVNKQlZ0TmJlVzBKcCtFZzBpUTFLYkY5Z2VYcVMxZ1B0?=
 =?utf-8?B?M3MwaWlEdTVaSmJCM01YelZkOEtTTXIxK2xpTkkrSEp2a1VEYUxrR2N6c3g3?=
 =?utf-8?B?TGw4VzhOSWFBdWJ6QVpwZW9vL0llWDRkcWJkbi81QmFpV2xBWld2WEtncWor?=
 =?utf-8?B?ei92RmJJbUtoQW9QWHR5VFlsU2tMa1hZdG1CVExWQlJhN21za1VHQjlWUitZ?=
 =?utf-8?B?RStDM0tGQjNSVkoxSEVKMUZhbkkzdWZkK3A1aE5xbk9ETjhtU1JEUGVDVnFD?=
 =?utf-8?B?NGJBS3BIZEY2ZjV2VHFXNlBpdXdzVXQ1VTFMY0tXb01MVS9OWmxYMEtkeXdj?=
 =?utf-8?B?cnljTXBybmxUK1hqTTZFSS9RUlA2bjhJU29YTEt6Z211dU53c0srNnFKV0ly?=
 =?utf-8?B?Q1p0K0tpSkhkbm9iQkdpQ295dTJHMFVyWUdVSnloSHJkcmw2Mi81SS9TRGRn?=
 =?utf-8?B?SFFnZUxyc3d1a29MVlMyVE1Md2ZQYTVFRTQvQjJHNVdkU3hxVFQzR2pueGUr?=
 =?utf-8?B?RnhWanoyT1VkQ1BvZENzb0ppMkFRUU53aG9QdTdteTEyNXRrV3RLdVgwc2py?=
 =?utf-8?B?eCtMRzhPMEliZ3JwY01xMkR6b0xza1p2RnRueGRrMnQ5Z2piT3p5aU8rQ3Jk?=
 =?utf-8?B?cC9MZkEzd2hDM2gvMzhTbjI3bHdBNTVKR2ppZjVINEVVRlBkNU0wN1VUZk9P?=
 =?utf-8?B?RW9CdTNGYTZwcm5lWHZaS2diczZJNTBSMS9iRW5Wa2xTWVNzaks4Y09NT0I5?=
 =?utf-8?B?OFR2QjdoaEwrVCtsdUNjUnN2TkY4ZVhPTEVSdGF1Rk12Z2hhdERJaWYwemNX?=
 =?utf-8?B?QlN5aXYrS2k5RENKWDZNYmJhV01yWGpmdWQ2Q0NlalVwMXZHRm4zODBQZzZq?=
 =?utf-8?B?N3ZlOS9XQzVWVmFIN3l6eVUyenpyOWdGa2Z6NDNBT1FFY0wvVmR0b3VFQ003?=
 =?utf-8?B?MWFncnE4MGxmRCtGNWZBVnZEOWtMVTE3dk10WVZyTHFMdXd6UzMrWnBNbmk4?=
 =?utf-8?B?RldvSFN4Q0hab3hVankzcjFxb2I4VHBvZ2xCanE0enZQdjlZU05uWFYzVFZu?=
 =?utf-8?B?TnNUTDBsbU9qNkFKTjhZRHVDSHlYdGx6VjJRTTBIZUxpaXdzT1ZpbWs5Y0F3?=
 =?utf-8?B?bTF4cnJQOGwrMFRYLzV0N2xKZUVoTnpLWHlkTHkzL2Rud2d0WjArekQ2dzBm?=
 =?utf-8?B?c05Id3dLM2psN0pMNCt5NzZhTWcxVU5sMy9tdmNkc1ZPZUZUMjByQWFXa0NS?=
 =?utf-8?Q?wUYA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d28356b-c754-4c8c-e6ff-08de02c64743
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:46:15.6884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2Dpe+Oz7B8/5ae9w9kMj9p64LCEB5qmplmvU9ELg2z3VKl1R0b81OBN7V1qXuzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474
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


On 2025-10-03 16:27, Felix Kuehling wrote:
> On 2025-10-03 14:15, Philip Yang wrote:
>> svm_range_unmap_from_gpus uses page aligned start, end address, the end
>> address is inclusive.
>>
>> Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in 
>> SVM mapping")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index e8a15751c125..0aadd20be56a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1723,10 +1723,9 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                   svm_range_lock(prange);
>>                   if (vma->vm_flags & VM_WRITE)
>>                       pr_debug("VM_WRITE without VM_READ is not 
>> supported");
>> -                s = max(start, prange->start);
>> -                e = min(end, prange->last);
>> -                if (e >= s)
>> -                    r = svm_range_unmap_from_gpus(prange, s, e,
>> +                s = max(addr >> PAGE_SHIFT, prange->start);
>> +                e = s + npages - 1;
>
> This is confusing. The old code was clamping prange->start/last with 
> start/end. start/end are based on map_start/map_end. Your updated code 
> uses npages, which comes from the VMA, which may not start at the same 
> address as the prange or the map_start. So I think just using npages 
> here is incorrect.
For restore_pages, the map_start and map_end could be partial range, but 
we should not get here as vm_flags VM_NONE or VM_WRITE. For svm restore 
worker, map_start, map_end is entire prange, start is from loop variable 
addr, npages clamp to VMA end, to go over VMAs of prange.

> You also completely removed the condition that s >= e. I think that's 
> OK, since all callers make sure that map_start/map_end fall inside 
> prange->start/last.
>
> What are you actually trying to unmap here? Do you want to unmap the 
> entire prange, the part of prange inside map_start..map_end, or the 
> part of prange that overlaps with the VMA, or something else?
>
For svm restore work no VMA case in next patch, this will unmap entire 
prange.

Regards,

Philip

> Regards,
>   Felix
>
>
>> +                r = svm_range_unmap_from_gpus(prange, s, e,
>> KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>                   svm_range_unlock(prange);
>>                   /* If unmap returns non-zero, we'll bail on the 
>> next for loop
