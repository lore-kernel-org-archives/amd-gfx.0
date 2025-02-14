Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD28C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 05:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E18410E46E;
	Fri, 14 Feb 2025 05:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zGR5AzSq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3F510E46E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 05:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB9MSMul+bJTwMWcvO++F2dF/LTRuOdxWaMqwr1hsiIraXmzX18VevOveJVJZwRRaT2Jejc+7DqOMj1gwOXlJAY6Rl1YcGvFDqEZF6FOdcH2ea0TlppdoNvquJKo9Q6sDlyVnOqqE4jddjUOB+MxOkGlYk7rtSXy6UUBoGd41uO6+T/Fwgw8+1UwUsII1O6S6nttJx4OE098acOH4pFWQ+mez1bq2W9wmCs2tGLrrSy3hRXef1sNaw13UXiZW9Yy+pmVT7Jq7fADVasBDS73gCQeYSwNxj5mGxgMMSpkM+qQqGJPvOcBQDzYOjxAlOwLeeOn/bdwms9kqX+4i0Kniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cBz4GcRIzG19+P8Ve2llUpZWQcCKvl3igV8w2mMgD8=;
 b=VwXGmRgpeGRp/K52Jxr5CDFklYSDNULiLCahlr6XaB9qaMlGgIQlC+Xc9bJJGc++Xcr38O/PqUw/yc3FGlOBIqkfy4PX9JOXfdHa/WF/csSofv73uoHFeIRit1b29qmgtVySzUCjY+okMywI840XkvSxShOxS0efSDc3O7VywV2arOfBlmZyvpXtPw2Ip5M4EPC7zY2IdnXvbPz75QRir6SAmFXLQdNWHyZZdnhDV0YO2GxQrba2FQ5M3JWbz4Z3sFwgHuaFnyVTcHuuCHtKQFOtpAE/g6eIegvzkOqcyfanx10wEoiQHLYjQseK2v1oUBL+9lhdLalIK90F0p60CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cBz4GcRIzG19+P8Ve2llUpZWQcCKvl3igV8w2mMgD8=;
 b=zGR5AzSqSPgwD0h+KaZigod+HMgCOyZpiu8HAJWYaGAmnmbTJwm/741R6b5JP2gd6laNvXjgHiw/EdPuyMEBxoJ+P1xh+nAeR8PZ6DS/lFOTv1BL84deZ5/LWAtdNjE1j52qEyYdU1ha3IknXi282Eail0OQvZ7stjEGZYgL9qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Fri, 14 Feb
 2025 05:58:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 05:58:22 +0000
Message-ID: <3536548b-9e4f-4223-92a3-d616c4843f90@amd.com>
Date: Fri, 14 Feb 2025 11:28:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250212155734.2213096-1-jonathan.kim@amd.com>
 <63230f85-c3de-43aa-b23a-d7cec00d23ab@amd.com>
 <CY8PR12MB743521D96B986FABB06327D285FF2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB743521D96B986FABB06327D285FF2@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: c24a7094-9afa-4474-d9d5-08dd4cbc96b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHE4ZVF5aHFHS0kwRk1PN2hvQm1ZSit1aTg1WjFLZHlLT0QwQSt0SzlKQkFu?=
 =?utf-8?B?WG5pS2pvQlNaTGpNYS8vNld4YU5seEViOUlnajJveUpPdFNZQlAzNTNLbUVE?=
 =?utf-8?B?dkF4WndldC9IWUJtSEdDc3hpWVpYcWQrU1AwNEFkQVFhZ25KRENYbUFWenMw?=
 =?utf-8?B?R3RzZEhjYjNNdDcvLy9YdFJoamhjRUgycFFLazNZWTF2VUVOZXl6YnVuNXhI?=
 =?utf-8?B?TTNzNk9ocXpkdGdZbExCVkhxUXlGUlJMM08rSUVHdkFOZTEzbmJTSUkrWUVu?=
 =?utf-8?B?em1XMElueGZCT0w3LzlmRUcvTzNtcEh4UnBZRFErWEM0SEV4VHdnSFBUYWxZ?=
 =?utf-8?B?WGdWZUl0cUZ1OE9PMk9BQmhZdmJ1WVdaeUJicmhRVXJXNnh5UDgxTGpGcjlL?=
 =?utf-8?B?c0N5QTlGRktXajQ0aGg2TFl6NlBXMUZ1MlhCMFU5Zkx4S0w5bzEvc25Ncm1P?=
 =?utf-8?B?WllRa3dIZnJYd212L0hlKzE2MytqTE1jb3N1Ui9WS21ZTHN1VVpqT3ZUNE9u?=
 =?utf-8?B?a3NSQXg3NGhVNHhhYk9yeDN4RjhwcHFWbks4KzJaRWNUUU5GTWtsYzFmQW5M?=
 =?utf-8?B?SWp5b25yVitZUit1L0x4T3oyeEF4K3UxdnRpa24ybmpWNHR4WFMyVEJCMGda?=
 =?utf-8?B?L2RBOS9ScXlXbU91S0xwM3duUU0rRTdPYWJxRWJiK05VenlFM0tnMEpoSCtG?=
 =?utf-8?B?c01pNFFzQVRlcDYrS3BjM0hBMnVjU2ExSEhkQUI5bUh4TnJnL3hTbXVmaUxG?=
 =?utf-8?B?ZDJtN3dOWVJtR09BWVZrRHlwMGVEKzZUaGVGaUNWbElLSHZmQ2MvQkpOYko3?=
 =?utf-8?B?MlJHZ1NoaTBpODdGTVFtc21rZVRJWm91OHhURU16RmU0bkZYRm1RU0RmVVBD?=
 =?utf-8?B?RUFSOWhsaDRMc3RxYlNqTlBWNkpKMFVKTTVIdEdXa0ZiRzVibkJJaXMrT21R?=
 =?utf-8?B?K2lwOXFUNHFzSDFPZUtudEUzeFB1b2xvSFM0aE5zV0RZZmlwdnIxNXdoN2kz?=
 =?utf-8?B?dkZDR3ZQcEVEVmw2VFQ5STBSOHhyNzVqb2NDRURPUXFZbXllQVY3a3dEV1ZP?=
 =?utf-8?B?YXpXbkE0d3FBclR2OVFFem12SXhUZE10bTc5blBtUmx0NkdSUnUrL0FQK0gz?=
 =?utf-8?B?VUNvZkRGTlp4WmtHREc5SUZ2elpsNURhVW92azhLRHVvclNSb2hPSzY5dllP?=
 =?utf-8?B?NmFqTFM1eGo4N3hodVpoSk9jWm9HWXFqVmNCTisyMldsUTUxd0h3dXJ6MWtj?=
 =?utf-8?B?NFBiVnNyMk1Bd1dxcUs4R2t1dEJKeUd0WU9pSXpWZnAzbGRLWXV6Z04rYnQr?=
 =?utf-8?B?VkVMTnMwaHpmbHRGT2ZPKzgzb0xIUHZQTE9lZWdKVkNyN3ZLYWVmcFJwVDN0?=
 =?utf-8?B?eUw2U25aKzkyUy9zTmFBQzY0aHJwSno2VGhHbTFNNUExSVNpckpzMkN1eDEw?=
 =?utf-8?B?TXQxY1AwUHlWeE9lYzl5Ri8xNWltM1BESkpEbHJNcWpYaytPc3I2OEQvdmFP?=
 =?utf-8?B?bnlOV3h0NE9HeW1FRyt6QTJUL2ljbFdkQ2VUTTVaZ1ljbzdOVElTcDhSUVNG?=
 =?utf-8?B?ejZBdzJNN3BOTHF0VDg0MUg2bTN2cmRtdmRVZXJJOTJKbXdYYWhyRDFLTzdx?=
 =?utf-8?B?VnRiTVdSNFJ3SU1Gc2RNRFFKZmpoUlQ5bU5NRXlUUFJTMFp1SFF0Q2trM3FE?=
 =?utf-8?B?OWIxaVdZS3g5VGNYYWd3MlVBVVM2N0R3RVhGaTh2c3FNWEsvZXJLRTZjUGMz?=
 =?utf-8?B?aVpRU0pQdVprVW9zV3V1VEdicTQ0RE4xTDBNdjh5QitxcnRiSXRzVjcwdUdK?=
 =?utf-8?B?TGFGSEVyZ3lMaVFSZjZoNG44U2FQSWRZSHIrNFFkUW9LT0NtYVlKQ3dWZnh0?=
 =?utf-8?Q?F6jeIuIoCytrt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNXYmRyditDbHpONnN2T0JyQ1FJRjVjY1JhNzZvQjAxaGhwV3l4MW5iQTYz?=
 =?utf-8?B?N3ZkNlF6ZVFpYk0rMllWMGxwM0U2cHcvMS9QdXAySWNkUHMyUTlaZ09YWWJS?=
 =?utf-8?B?V2wxbWNPY05nWWNlS1lOTUtqdkVnM0hqWk42cTJBeVV6S1pPdVdSN1dpUEVF?=
 =?utf-8?B?UC9zWm1HaXNVQlMvelNZQUNKWTlLS3NsZzJ5OEFlckY0c3dRZ2NMQW4ybE5B?=
 =?utf-8?B?czRldWpvcjhtZzZZdGxLQWpRbW1rbGRTY2ZsdjZnbTl5TXpscEM4d1BqVXZS?=
 =?utf-8?B?QXY0U0hGei9VUUY2cnI1ZUlnZEIvekFvZkMwQ1RXM2toT3FCdm43b3h1U0tY?=
 =?utf-8?B?ZkZtN1ZUU0xaaUg3MURmL2U4ZldqQzF3Zld2T29XZ093Qi9wTnYwMFZ2YWlk?=
 =?utf-8?B?RDFwWGZHYUlaSE8zVkZ3VWdBajlybDkvOGZsQTR0bFNtWkVNem44MGl0cnZh?=
 =?utf-8?B?SkY4cVVnalZHdmxNSU02Y2pLeW9zWVlNb2ZKdmZCQnJ6SFI5TWVOeXFzKzNz?=
 =?utf-8?B?S1ZjTTFmQmgrT3kra3BjNjlQZkN1MnRaUGNvcVMxVFJBZ09QL0twOHoyK3dj?=
 =?utf-8?B?MzlkYTVlajZEbDFNQzN5bzRBanR1K1FNTUFGUUxzVE4waC9HbVVadE03bk9M?=
 =?utf-8?B?WGdGZDRBWE55czcyV0NwcjlsNFZjRk8yNkdLam42TjBCVzhQZVFESitwREJK?=
 =?utf-8?B?R0dYNFBBVk05bEd6M3Y0UmZUaE1uMjNOSnlqeWFjR3dVU3gvTWxFRC9xUDZC?=
 =?utf-8?B?SmxwdXJWTGVMdEVpaXlyZVN2SmoxNmZoMUp1MmFxcTRIM2s3bWR5U1NsTWd0?=
 =?utf-8?B?TTdBK3U2S0c4RkRyNlRMejFOZk9PUGQxVFJxaXFZTE9pTnBhOXZ0aVdVcUl5?=
 =?utf-8?B?VHNreUY5Vlp1UUVkL1c1aGtzbTlaUldtZlRkWXJJTHNnZnE5ckt0SHdDbHR3?=
 =?utf-8?B?VE9GUzZSZHFhNkFpL0R4cjdKOEYzaHBnMHdwcTBUcHF2SVgzTGlaL3g3QTBD?=
 =?utf-8?B?R3FMRWxxWjlkZ3crWWRJS1JrSWdrM3EvREc0YzZZTkpQbnZYd1YzUGJlOThs?=
 =?utf-8?B?Y24wNjJsc0VBcG94YW1VUVY1empiQ0R1b0ZNTFlMK0hDTk93WUxFMlR4OGJs?=
 =?utf-8?B?eUtwRXlpUTdEQnliK0lTdzBiR3hjbGE0eGpsVFo4YStqSXVwS01zSG9sYVBk?=
 =?utf-8?B?SzgrcUR1ZEYxN0FIbmhCbStkbkFOeGhQMzNmS1FoM1NhbG5Yb1ZMOWlWSDFx?=
 =?utf-8?B?d3NNVmswRFRzY3lXY3NudFJlTTJuNEhSS3o0Ly9vR0lNRUVrWXlNNkdyUjZL?=
 =?utf-8?B?dWh2VS9YZkRyTC9ocEMzSWtYNkJZTnRQZWgxVDdCOFJweGkvYyt2ZUxvSzhm?=
 =?utf-8?B?Nk94SHZ3TDBJUWNqMjVjMnFuYXU5Q3dhV1d1TkR5bnkrTmpRSUF5d09iN0Z2?=
 =?utf-8?B?RUNXdVBubXFvVHZkbndRMkZ3eklRL0FjUjJ1TjZzeTBVYlBKZjVpbEhzcVdp?=
 =?utf-8?B?cXRlcnFLbTBVL2JQR2xDc201dVlaVlpQdHJiaWwvVmUxcHNSM29LVUdaRFpC?=
 =?utf-8?B?WlNDdEZsZDVhWWJWNTVZemhhTlpjU2ZHVWRTdnE2UnVyc0t3VXB1bGcyRVE0?=
 =?utf-8?B?UHJOd3NuK2ZmcW1VczJSMFVGMXg0RVZCRE04a29RS3NvVDA0RE9mVkdhbEJW?=
 =?utf-8?B?QnJHMXpQeGVxYU4zNnRveVdOVGVxTXV3MWpqUEgvSndpWHdpdW1RZEpvdWlx?=
 =?utf-8?B?ZDNhN2FZNUZhYmxOa2FYRGhJZVBZcVd4WVcrYUlaazJBWUlnSzBZRHRBYnpi?=
 =?utf-8?B?VE03U2VsTEVldjJBeVloSjNFNlNMNVRWUkc5SDFtSEo5U09XN09CYzB4dWYy?=
 =?utf-8?B?QS8yVkRuWTUyOVdndUVST2RRdldkWFJoOSsrVWkzN1ZyYWlmYTh6YTlPekF6?=
 =?utf-8?B?OUI1b3BmRUFTZ0doYkVnVzZndmczQnZiZU9XS0JtZllUMjVLdnM2RWhEWGhB?=
 =?utf-8?B?OEZJS2d1OU5YSHhwdkx3Yk1YSFZtTkRoOHB6YnhMaVFIRkxNVlZWOGxsUjdK?=
 =?utf-8?B?bUlxNVBRSmlpMzRjU1NsOEF5cWoxZHB0Z2JUL2JnN0ZaOWtIelVaWUF0K3Uy?=
 =?utf-8?Q?B6aW4ducuPj/rJiGvaPUd2CFV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24a7094-9afa-4474-d9d5-08dd4cbc96b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 05:58:22.6069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVrlw3nCqDhF85dhV2Mi262ZR1uGdUja8a75JZ/N9RIEHsbish0thqf9BGhGxIj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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



On 2/13/2025 9:20 PM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, February 13, 2025 1:35 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: simplify xgmi peer info calls
>>
>>
>>
>> On 2/12/2025 9:27 PM, Jonathan Kim wrote:
>>> Deprecate KFD XGMI peer info calls in favour of calling directly from
>>> simplified XGMI peer info functions.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ------------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 51 +++++++++++++++++-----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  6 +--
>>>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 11 +++--
>>>  5 files changed, 48 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 0312231b703e..4cec3a873995 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> amdgpu_device *adev, int dma_buf_fd,
>>>     return r;
>>>  }
>>>
>>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>>> -                                     struct amdgpu_device *src)
>>> -{
>>> -   struct amdgpu_device *peer_adev = src;
>>> -   struct amdgpu_device *adev = dst;
>>> -   int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
>>> -
>>> -   if (ret < 0) {
>>> -           DRM_ERROR("amdgpu: failed to get  xgmi hops count between
>> node %d and %d. ret = %d\n",
>>> -                   adev->gmc.xgmi.physical_node_id,
>>> -                   peer_adev->gmc.xgmi.physical_node_id, ret);
>>> -           ret = 0;
>>> -   }
>>> -   return  (uint8_t)ret;
>>> -}
>>> -
>>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>>> -                                       struct amdgpu_device *src,
>>> -                                       bool is_min)
>>> -{
>>> -   struct amdgpu_device *adev = dst, *peer_adev;
>>> -   int num_links;
>>> -
>>> -   if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
>>> -           return 0;
>>> -
>>> -   if (src)
>>> -           peer_adev = src;
>>> -
>>> -   /* num links returns 0 for indirect peers since indirect route is unknown. */
>>> -   num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
>>> -   if (num_links < 0) {
>>> -           DRM_ERROR("amdgpu: failed to get xgmi num links between
>> node %d and %d. ret = %d\n",
>>> -                   adev->gmc.xgmi.physical_node_id,
>>> -                   peer_adev->gmc.xgmi.physical_node_id, num_links);
>>> -           num_links = 0;
>>> -   }
>>> -
>>> -   /* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for
>> bandwidth. */
>>> -   return (num_links * 16 * 25000)/BITS_PER_BYTE;
>>> -}
>>> -
>>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev,
>> bool is_min)
>>>  {
>>>     int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 092dbd8bec97..28eb1cd0eb5a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -255,11 +255,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct
>> amdgpu_device *adev, int dma_buf_fd,
>>>                               uint64_t *bo_size, void *metadata_buffer,
>>>                               size_t buffer_size, uint32_t *metadata_size,
>>>                               uint32_t *flags, int8_t *xcp_id);
>>> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
>>> -                                     struct amdgpu_device *src);
>>> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
>>> -                                       struct amdgpu_device *src,
>>> -                                       bool is_min);
>>>  int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev,
>> bool is_min);
>>>  int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
>>>                                     uint32_t *payload);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> index 74b4349e345a..d18d2a26cc91 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> @@ -818,28 +818,59 @@ int amdgpu_xgmi_update_topology(struct
>> amdgpu_hive_info *hive, struct amdgpu_dev
>>>   * num_hops[2:0] = number of hops
>>>   */
>>>  int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>>> -           struct amdgpu_device *peer_adev)
>>> +                          struct amdgpu_device *peer_adev)
>>>  {
>>>     struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>>>     uint8_t num_hops_mask = 0x7;
>>>     int i;
>>>
>>> +   if (!adev->gmc.xgmi.supported)
>>> +           return 0;
>>> +
>>>     for (i = 0 ; i < top->num_nodes; ++i)
>>>             if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>>>                     return top->nodes[i].num_hops & num_hops_mask;
>>> -   return  -EINVAL;
>>> +
>>> +   DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d
>> and %d.\n",
>>
>> Suggest to use dev_ function to identify the device pci number. Since
>> the function still passes, maybe info level is good enough.
> 
> Ack'd.  Will change.
> 
>>
>>> +             adev->gmc.xgmi.physical_node_id,
>>> +             peer_adev->gmc.xgmi.physical_node_id);
>>> +
>>> +   return 0;
>>>  }
>>>
>>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>>> -           struct amdgpu_device *peer_adev)
>>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev,
>>> +                                struct amdgpu_device *peer_adev)
>>>  {
>>> -   struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
>>> -   int i;
>>> +   int num_links = !peer_adev ? 1 : 0;
>>>
>>> -   for (i = 0 ; i < top->num_nodes; ++i)
>>> -           if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
>>> -                   return top->nodes[i].num_links;
>>> -   return  -EINVAL;
>>> +   if (!adev->gmc.xgmi.supported)
>>> +           return 0;
>>> +
>>> +   if (peer_adev) {
>>> +           struct psp_xgmi_topology_info *top = &adev-
>>> psp.xgmi_context.top_info;
>>> +           int i;
>>> +
>>> +           for (i = 0 ; i < top->num_nodes; ++i) {
>>> +                   if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
>>> +                           continue;
>>> +
>>> +                   num_links =  top->nodes[i].num_links;
>>> +                   break;
>>> +           }
>>> +   }
>>> +
>>> +   /* num links returns 0 for indirect peers since indirect route is unknown. */
>>> +   if (!num_links) {
>>
>> This looks problematic. I guess, it is better to keep the old way of
>> passing min/max. Otherwise, there is a chance that min reports some
>> value and max could report this error.
> 
> I don't think this is a problem.  The old way of passing is_min ==  true is tied to peer_dev == NULL, which made it a redundant argument.
> is_min ==  false doesn't prevent the issue you've mentioned from happening because the old code effective sets num_link = 0 if the peer_dev search fails anyways.

The problem I was thinking about was with respect to usage in KFD
properties. With this way, min_bandwidth will report some value even if
no link is present between the devices. Max bandwidth will report 0.
Ideally, we should report both min/max = 0 when there is no link present
between the devices. I haven't checked if KFD does some other check to
ensure that there are links between devices before calling the API.


> With the line at the top of the proposed function:
>>> +   int num_links = !peer_adev ? 1 : 0;
> The sematics are as follows:
> - NULL peer_dev indicates that caller doesn't want peer-to-peer data to factor num_links into bandwidth reporting so assume a single XGMI link in bandwidth calculation.

I think this semantics doesn't provide enough clarity. XGMI is
interconnect between devices and ideally we expect two devices to be
passed to the API. If any one is NULL, then it's better to reject.

> - If a failed peer_dev search ends up with num_links == 0, that means the caller passed in an invalid node (i.e. it's not one of the nodes that's been registered to the hive).
> Currently, get_hops_count (old and proposed) operates in the same fashion too.
> So the functionality between the proposed changes and old changes should have remained the same.
> 

The API is usage is clear and general expectation is two devices are not
NULL. That is clear in the case of get_hops_count.

> I'm open to adjusting get_num_hops & get_bandwidth_mbytes to return either -ENODEV (device not found in hive) or -EINVAL (bad peer_dev request) on a failed search.

On a failed search, does returning 0 work - zero hop/bandwidth
considered as no link found between the provided devices?

Thanks,
Lijo

> That would require a change to KFD CRAT logic to error return itself on an error.
> However, this would change the behaviour of a bandwidth reporting error where ROCm could still function, to the KFD not loading at all.
> Currently, the consequence of passing an incorrect peer_dev to the bandwidth call would result in the ROCm Runtime not issuing an SDMA ganged copy i.e. potential peer-to-peer performance drop.
> 
> Jon
> 
>>
>> Thanks,
>> Lijo
>>
>>> +           DRM_ERROR("amdgpu: failed to get xgmi num links between
>> node %d and %d.\n",
>>> +                     adev->gmc.xgmi.physical_node_id,
>>> +                     peer_adev->gmc.xgmi.physical_node_id);
>>> +   }
>>> +
>>> +   /*
>>> +    * TBD - will update IP based bandwidth later.
>>> +    * Bandwidth currently assumed to be x16 lanes x 25Gbps.
>>> +    */
>>> +   return (num_links * 16 * 25000)/BITS_PER_BYTE;
>>>  }
>>>
>>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>> index d1282b4c6348..325e7972469d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
>>> @@ -62,10 +62,8 @@ int amdgpu_xgmi_update_topology(struct
>> amdgpu_hive_info *hive, struct amdgpu_dev
>>>  int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
>>>  int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
>>>  int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
>>> -int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
>>> -           struct amdgpu_device *peer_adev);
>>> -int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
>>> -           struct amdgpu_device *peer_adev);
>>> +int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct
>> amdgpu_device *peer_adev);
>>> +int amdgpu_xgmi_get_bandwidth_mbytes(struct amdgpu_device *adev, struct
>> amdgpu_device *peer_adev);
>>>  bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
>>>                                     struct amdgpu_device *peer_adev);
>>>  uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 70b3ae0b74fe..a787d192390c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -2133,8 +2133,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
>> *avail_size,
>>>             bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
>>>             int mem_bw = 819200, weight = ext_cpu ?
>> KFD_CRAT_XGMI_WEIGHT :
>>>
>>       KFD_CRAT_INTRA_SOCKET_WEIGHT;
>>> -           uint32_t bandwidth = ext_cpu ?
>> amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
>>> -                                                   kdev->adev, NULL, true) :
>> mem_bw;
>>> +           uint32_t bandwidth = ext_cpu ?
>> amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
>>> +                                          mem_bw;
>>>
>>>             /*
>>>              * with host gpu xgmi link, host can access gpu memory whether
>>> @@ -2198,12 +2198,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int
>> *avail_size,
>>>
>>>     if (use_ta_info) {
>>>             sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
>>> -                   amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev,
>> peer_kdev->adev);
>>> +                   amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev-
>>> adev);
>>>             sub_type_hdr->maximum_bandwidth_mbs =
>>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
>>> -                                                   peer_kdev->adev, false);
>>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev,
>> peer_kdev->adev);
>>>             sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr-
>>> maximum_bandwidth_mbs ?
>>> -                   amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
>> NULL, true) : 0;
>>> +                   amdgpu_xgmi_get_bandwidth_mbytes(kdev->adev, NULL) :
>> 0;
>>>     } else {
>>>             bool is_single_hop = kdev->kfd == peer_kdev->kfd;
>>>             int weight = is_single_hop ?
>> KFD_CRAT_INTRA_SOCKET_WEIGHT :
> 

