Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB69D1D884
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5FE10E8D9;
	Thu,  4 Dec 2025 08:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWjvV1h/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9424F10E8DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 08:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXn7S6nVQCiKJUX8Ds3jCUcA8DsZk+l+vv7itx0gEVBLbdrQNfL4uu2UcW7LgHkN4/vG8B5cGeqAYn0+lPTxeYsV/gx1rQVIYLBxy0SbsnHu848UMRBTVq0bGQP6MFC56AGdmfOBWl4SEDo4xlNuKy9QEu/0ONWdLnhWzswIiz1F78r/E5R6o6Qfk7sMURitc0IeQR17pcH6dTqYUFOPj+V/jEkmdvAZOp4CUIiozBOJB+N0BOvahhMDvhTd2GzScVnwyq5Q2evsmi+3fDYPcERr5ooGNH8EI4G1ScBIyWRi1Hlgy8D+7pj1up6C2aXRhZKNrGcozt/TMKNjwve62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soMDBKOZrUx3nB6CZ22WBoOP/xZ+NuNdoO5YihionBw=;
 b=jrtQawFMgH4BNYiRqW0EJPuscSIPalIDEPXz+GH0OHbbHrnR+6s4ZMnijEWLY+yRQOjVQw7rKqFISJE65H1CLViIuj88GFDvVBIyIq+FFczbQ3CKBRUmwMD/O7iBDVkBlVYc61WfynFpVfqoc+RVAVjbV2J55QJIStJrEY3b+g+Q/wcGdMhubCKwOXKyLitfTjQp7+bwWkXIyTd2lGSVE4pDkF7q0jsSdN4gqJ1pPaIocPc73kzMF6ufXL5tblvqgpH7uPyjQVxIN0Jpw44spHV+RBgStgOTfknZoFAur/uRzHst40UZa3ejFZKN/7/4d9vvs8P5sXGh9tYYWIKVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soMDBKOZrUx3nB6CZ22WBoOP/xZ+NuNdoO5YihionBw=;
 b=DWjvV1h/NU69/ZIdquhgHI1Ozs8TbP3oxe655mya/wGtgFf2Y0r8zauwJSHV2y3BY3QVz+kG5ITRCzgMUg5d8gLo2Cz0Nhxfei2p2AYkamNbI96wIEOT+qlewckbs+8iHZtonDBiggElmCkPWK68nzjkcxR6jViem6ymKmNDbYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB5840.namprd12.prod.outlook.com (2603:10b6:8:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:03:52 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 08:03:51 +0000
Message-ID: <e15baf60-403f-46bb-8a70-f880f8b1d61f@amd.com>
Date: Thu, 4 Dec 2025 13:33:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
To: Krzysztof Kozlowski <krzk@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-3-lijo.lazar@amd.com>
 <d5b202f2-c8cf-4b29-b183-e3cbf73f4225@kernel.org>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d5b202f2-c8cf-4b29-b183-e3cbf73f4225@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de88332-8304-4d11-be2d-08de330ba93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y216MjFxVlk1TDdjZTg4Y084bUdqTUpnZDAxbjJjZnNSRU1KckhkTG5XNDgz?=
 =?utf-8?B?MmFhWTB2RVpHVmNmR3NlWW0ycm1RckhUb1ZvWlFwcEZ6NW94U20vVVhxbFU3?=
 =?utf-8?B?NzRFRHBCNEZzamFiSnN5T1JNLzYyMExzTHFhNHpJNU1zdllxYWFzQ1VzcFFy?=
 =?utf-8?B?SXBpRjJuNU9NUTlFRUFjZDNwSTRXcGxrL1A2RDN6ZzVqZ1JJUElLM2s2MUN1?=
 =?utf-8?B?dUlDWm5tRGhJcnZwbDVneW5ZeUVCb3dKdkR6VkRYVkFRNHE4SUFQa2t5THlv?=
 =?utf-8?B?ODVVR1Uzb2F3ZkFublRKb3pxbGk4a0R6ZGdQandqQ2poTXJNazU3Tlhoa0hN?=
 =?utf-8?B?UFhvRjV5YS9aSEk1RmxDZUFCWk9YSVlmK2xoVEM2cjBhTGdkY05DOGw3SVVv?=
 =?utf-8?B?THcyNjZ0VFh0ODhZMWlBV3ZJUUloT1NCbG9wQUN3WWNJakkwUzNTQzRRZXFC?=
 =?utf-8?B?emJZcElCRXcxSGlCZzFrY2Q4WkFtV3QvTzFhNXhISVBsRGxtRFc5a2hOTXZp?=
 =?utf-8?B?UlROZXJkVUo0aUhqdFljRzVsWVBIaG5rQUp4clE5YjNFeGlWVnBxaGt1L0xD?=
 =?utf-8?B?M0FIZUVUZWhQMUxDMjlrTm44ZytsbHI4ZWlOZ3BTdVBzOXpOQ1RtYVFWNVZM?=
 =?utf-8?B?S1pQOWNJeTRSSmloczBqc1lwYkc4K2hId2ZPaTdCYWE5TjBwUDdzQXNXbGFU?=
 =?utf-8?B?cWw2OVZQc3cyeXhLRlNzS3J6QnpwTzc4ZURtdjZOS21ZRHRkOTlRQklaMTFN?=
 =?utf-8?B?WlpxMTJsVUZSTWM3TC94dW40cWphTnhsN25pK0hQbkV0Wk5uaXZPNVdIS2hz?=
 =?utf-8?B?aXpUaExLd1RtYVNFOER6aXFIcXNkZi9iWGF4S0hrdXhnbXV0dVVXYktvYUxK?=
 =?utf-8?B?UzJMN3VkL09VNysvcm8xbk82NnJVRytOSjI0Yk1KNU0yOWtiZ1NhTWVzNkF2?=
 =?utf-8?B?ajgyV0g5eWwvQlVvT2pQR1g5NWhtSUNOMFpaVEtUYlpZWk1PcE5peEszMGJT?=
 =?utf-8?B?d2piSXkzWEJacnV5MDZIWGJ4Y3NyTkFTa3JSWm1KZWtHb2hXV0ptQjQ5Y3A5?=
 =?utf-8?B?SWo5QlJWVEwxK2phSkYvM3cydnkrRzBjclNqY09ONTl1YU13QUpwTDJEUTNw?=
 =?utf-8?B?UFR2RDNQeVd6bmFQSlE4REpZK3N2OEptWURWZGNrN2pTanI2N010N21mUGNB?=
 =?utf-8?B?aDdXd1ZTUWVtTEJxR1ZRWldJeEtsbHUweG9ETzhDWGJaajIrcWg5OU45Ylpj?=
 =?utf-8?B?ZC9CK2p3ZTFkbTE0ekJJR2oyVGNCaGt1MFdselBYL0FYNGc4SW9xMTYzOVQ4?=
 =?utf-8?B?MnZUOXp3WGpkaWpVVCt4eWFhQmh2dHZkdmVSRGVXc1ZGRzdUUHo5djhwOHZi?=
 =?utf-8?B?cDd6Z0wzUm1pYjJNWDJLYWZpYjFOdjI1SVdESU40SVFhWDVnMjVLaFQyUWx0?=
 =?utf-8?B?L0c0bGVZRlUwUDM1Z0Z3N0tVOEgvV21yNzZyTjZlUWxSQUcrS21HeTh6MFNK?=
 =?utf-8?B?cUwxbU5DZ1NNbWJ5Zi9ycmZQamE4dDZtR2djNmRQWktNYzB2T2Vhdk54YW5F?=
 =?utf-8?B?VE5MMEZEbUZ6VkRPNURNZkRqN3RWN3BsU2lsdXdTakVUMEVJZTlaMTYxRURo?=
 =?utf-8?B?T0pmWFdLZ2djSEdxeHkvMDczY1JOMTBnYmEySURzaTIwaFUvcUdTYUlYeUU4?=
 =?utf-8?B?L0REQURuV3FZYUg5dU9TVElnV0R4bjZqUFNmUDhlbW1WbjAzZjBqSVF2OVYy?=
 =?utf-8?B?b2V0WWdBT3crN0ZXSHZMditXS25ldTRRbVlPMWl2VnNUZFNGYW9QNjU3TTdh?=
 =?utf-8?B?SjdBUHE0Tk9FQ0VnYm5CUmhyRnRESytXTzBhaVJPc3NLR1UzRlZmb1l1YTNM?=
 =?utf-8?B?dXVIREtKWC9RcHNRUmUwbWhmUVdBc3FMZTZSNEo1MWZiMmp4S2hxNkFuU3pl?=
 =?utf-8?Q?u3M629bVrX0m4o3sNp55d7eEIgInJVMc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OERSa1V3WFRlRnFUNTlad3FUQXVsdEp0Y1VIaGgrYVNCeGpMbE40Lzl0emlD?=
 =?utf-8?B?Ukw2aW1CYmxRVTBrSFozZEkyUmUvOHhaempjS2E2Ti9uYzMvREVSazNJNzRa?=
 =?utf-8?B?N0h6TTN1M1J3b1I4eDcxckpPa3NDa0V0UElzSDVGUFJlOUs1a09iUWloeFhC?=
 =?utf-8?B?b0ZQeGN6cmQ3ZmFGV2REaDBlUW1YSEhmemlUcnNUR21yZnlPN1VaWXVpUGlt?=
 =?utf-8?B?Qy84eWVFYVREMk1ZWHo3R0NmTmRJN283bzRtZVNSSFdSZ1hudVNZZ3dGcjhx?=
 =?utf-8?B?RWpyZmlTWGdyMDdWRmN4ZTQyci8yZVZ6QVRjNGV5c0pGY0RBZ1cwcjdVQVJX?=
 =?utf-8?B?d05waFJCb1VzMno1RDJBdk5nbXcrRjh4OVM2UGdLSWNWanlrZjFtZVBXNnVT?=
 =?utf-8?B?a2EzRDFHRmcvQ1k1SWZQYzArOWVuNFcxeHZtZGE4L3NHak8xbmp1RGx4TjRP?=
 =?utf-8?B?anpNMWlCbTRsK3RYNzZadWNzLytOMG9UUUdTOHQ0aGtPbjNGMytRcGNYSm1L?=
 =?utf-8?B?WTBNaHA0ai95c28yMytuR1BzOXU3ZnhCR1Q0dHB1MVV1Mm56YU1QYUhZVlZN?=
 =?utf-8?B?SitOSlpTMFh3bUY0NUFXSjl5Q0F4SUY4Zjl0aXZqeGhCVmZzeVAwMFdQM2pU?=
 =?utf-8?B?RXdQaWlWRFhVMEtEa2pmQzRjc1U1ckRja3UybWN4Y2I2RVlHVXdZU1NGc0lS?=
 =?utf-8?B?WWtnVmtpcWxqZDZDQ0l2UnM2V1U1V1ZpMGlJaG1oNWlNM3BPU0l3SERuRFEr?=
 =?utf-8?B?RVNxRG93OWRxbjIrTkY5R01CbU9QaU5YTVZ0d05qMDNnVHJmbEJ6dDltdXB3?=
 =?utf-8?B?TlpRNlNPUVg2N2RtMGZ4NWdJNHl0dEdCVjAzODZHemt0YW10QTNUWFhaayt5?=
 =?utf-8?B?aDhDdFFEekNzU2lBWllKUjhmZEtJL3NaWXZLSm12UzZqOURDMEJQc2pLKzF3?=
 =?utf-8?B?SXFSRVErNVVGRndqNStLRHRrU2toZ1IrQkhZVU00VjMwdjdRcE40SkxzS0tL?=
 =?utf-8?B?N2VNZEpwWHl3VFh3RDNrcWcyZzJkYTgxMnVkTGc5c3J6bTU0Y1RtcWR5bURx?=
 =?utf-8?B?VytCOTRoZUZQN3FXcXZacWYrVmhBUTFIdnFwNW1OY3RoL0RHNmNraERYSnVY?=
 =?utf-8?B?WENKYXV1azNFdVNpMGlvNmQzSmxGQWN0Y1BPM21GZ0loZHY1dmRwTnluZzI2?=
 =?utf-8?B?cm5PdFJSTVJQNkRCak4xdHNkQkhlT2EvZjcwVHY2clJOQkE3UFd1dVVZS1Zz?=
 =?utf-8?B?Zno5SXErWlE3dUJ6NU1lT0FuK3NFblZzSFFXTWpIbC95OStHSVFtcUd6a0Ji?=
 =?utf-8?B?M1o3VG13ODJvY2FhelhOZk85U2hLb2xNaG5HU01qSjZ1bFE1QTU5aGgwdTlY?=
 =?utf-8?B?UmpxUmZyTWFVSjgwd21EaHovdTJqTUoyMjNHQndVbWRkdHdRSHNnaFRHRkVw?=
 =?utf-8?B?T0VoaEVCWXJLUnUxdm5lQnJ3bHJVSm84VEE4YTF6Rm04eWJYdXZDMjg3VU4v?=
 =?utf-8?B?UjhxcFVmUHNOYnpDMnJEVEZJeXdnRmRHMW9HZVlzSmVKOGJiV0ZLVHdISjVn?=
 =?utf-8?B?enVldkNFOFI3d1JFYkZIYzh1dW9WTDRqeDdacDNsR3VDbDZyUW02cG4veTkx?=
 =?utf-8?B?b0lCOGhnNUJRS0ZaYVAzTmpabkVTREEybUs0QUlrWkxOSGNmdndZWk9tRjU3?=
 =?utf-8?B?MkY2ZW1rdWhoZGlod3pTZFJVZG9ySXoveEtVaERiRHlCc3plR09aZ1RkRTl2?=
 =?utf-8?B?MlBLNFhnMTVrRk13TXI0bG1wN2NHN295ZitBMi8xbHorYllpRUREOWJyZGly?=
 =?utf-8?B?ZTJyU2IvWkJVWFR5VjdIR0NRdFJkZ3V3TVM3Z1hxQTNndTlvYUFFYlNlaitW?=
 =?utf-8?B?WU9FblNJQnR2WUZNN3pkZG5OMEZua0lzbTFMRHMxa3FCQTF5QlJ3cFh0MHdG?=
 =?utf-8?B?OFIrUXpnaml3akNFS202TS9FWS9UdEdGeXFIY3BvT1YrdFF2QVorNlJFSXVx?=
 =?utf-8?B?N0IyZnBDZzNQZjRqQi9KMERHcVlIV0lPa3FMc2lMSTJpQ24wSGFlcFBteXNH?=
 =?utf-8?B?bWNDTWRVdzZ3dHhlZS9xeFpOVDkrUi93alZ2dm9PWlNJaHhsUjlsWVR1WXht?=
 =?utf-8?Q?W8/0xXtob8vFOv6IzQHX4Timq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de88332-8304-4d11-be2d-08de330ba93b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:03:51.3598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V0Hsz/XH4ZtiDB7PFgC96OZarOxnAyyEAW7IDX7dS3zBR1eOzhaAIdtfeP736iq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5840
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



On 12/4/2025 1:06 PM, Krzysztof Kozlowski wrote:
> On 03/12/2025 13:54, Lijo Lazar wrote:
>> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
>> +		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
>> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
>> +	} else {
>> +		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
>> +			     AMDGPU_CWSR_TBA_MAX_SIZE);
>> +		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
>> +		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
>> +	}
>> +}
>> +
>> +int amdgpu_cwsr_init(struct amdgpu_device *adev)
>> +{
>> +	struct amdgpu_cwsr_info *cwsr_info __free(kfree) = NULL;
> 
> 
> This is an undesired syntax explicitly documented as one to avoid. You
> need here proper assignment, not NULL. Please don't use cleanup.h if you
> do not intend to follow it because it does not make the code simpler.
> 

Could you explain more about the hazard here? There are no multiple 
cleanup variables declared in this case.

Thanks,
Lijo

> 
> Best regards,
> Krzysztof

