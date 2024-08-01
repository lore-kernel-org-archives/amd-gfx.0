Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FDC3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7278A10E644;
	Thu,  1 Aug 2024 03:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ty/p8FkL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829C210E644
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tusNFPFxgYJIvG9vEo4aYyAavUoAe39i/3Cuu0TIqLfgx2BQnSe+jocnTd9tCNkc6K/c4Yh5a2Qk9wx2zn90/Yusx6FYxlywxafGMP8y7N/3yzmDKgAFpmrdqcn2T8J+g5m85kqcsmLShtmryZCa+PTnTxmbHG5ESsnZcNJxH6io8GKOMZnt4JpObXw2kMoGeSR/GBKJ/Rl5ihZxiyF+k4DxMPRtJ5f20yl3ktPcuGKPqTqCehvUtxgyk2iCnS7NsDnsJN77aC7OnWjInpBnEjcBqbMlcodu/+ivLJ3z/Jj3HubD9aZSn8Y/5phqUNSyY77r2PDyQr42k2kpfgTzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1tDgPo+An3w4twOQPb056GEQNjYWljVm62bbjPH30w=;
 b=jH/DB2e0fPfi+LPaooOH03F4oxCj1xXVtORUR6OhqLdXDqBTXtQbMzahggOAysG1aNhaR1BKIMoYUkn7grrGNXtm1ixhP191QP/v58hJkxzXPw0Cky8CQieT4/ZkzZjQhyxVx4IqMuCl1fIbYjMRZXARMWRVQAbsAsTN8hsTmMKfpfhBV5YEJwk59GrJEWaweBYR70oCyDcDLTM3hpMTT8P0MKQ41beZsq1CXA3pyO83QZiWOiSrpOWuV+xDIYKSotq4aUA0PEWyjCs1/LctzVQ1UJhy0N6mNBdHYbmSBUEE5NAVRKJCVOE0NX1us3DBHtYSoZv358EhFD54J1r9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1tDgPo+An3w4twOQPb056GEQNjYWljVm62bbjPH30w=;
 b=Ty/p8FkLIs8rwpGx2LRTlX9c/oIPqfzSFssNA58g39AmYZTg+nOK1iEYbn5wTLI1om8qE49BkAH+aJDzjOdQC12lEOKxGDkH7nfYDduhadS7KLgmTEYAfpcmmknPKkYPv04gLN5w6V0kcvhjAMde4XAj9jbpKO5nRIofhMuq5r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:54:23 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 03:54:23 +0000
Message-ID: <dc66bf74-f617-49ce-8668-1fabca490938@amd.com>
Date: Thu, 1 Aug 2024 09:24:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: report bad status in GPU recovery
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <92c3bb8c-c8f8-4445-8f01-822ab14e450b@amd.com>
 <PH7PR12MB8796907AF24DBCCB555F5A1FB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB8796907AF24DBCCB555F5A1FB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe18b89-450d-44cc-187a-08dcb1dda176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWpZeDlFWjkvQzVwSDhoL3BSWm9zaUNVVmlyYmRRbExTQzBuUHZQeEg4dmw4?=
 =?utf-8?B?blgrOC9tOWdyeFF6WW1CRVBFaGIwN1ZLb3ZSMDFGanlRdEF0eURkbjU1Rk5B?=
 =?utf-8?B?QlRLTEVrM2t4NzRlamcraG1GWjE3bmd0V1dQbCtFZW5uNWhIbDh5K1czdU8w?=
 =?utf-8?B?Y1hpbWhybXQ4UFExdmdWaE9vQnAxN0gvdHBPZGZNTWcxMUcwOTZUOVhBUUQ4?=
 =?utf-8?B?L1lBTS93YjFHUjUrMkUvWDhWZGorNVBkMmVDRml1bWtPd1ZkUGJxRytvSVY1?=
 =?utf-8?B?S0Z2dlJVdDRIUWp5QjRuTWxFTDFidUNnWTJqY29kVmxMMThoZWU4SngzZ1c1?=
 =?utf-8?B?anV1WEdvWSsyNlgyZWd6Ym0yK1JpT0FVL215OHI3TzhPT1NHWFBxa3pJUDR5?=
 =?utf-8?B?Znh6RHAwNndRSGFXTW5uRE8wZDZVUEY4cC9vcjd4OFlRYXdlVWhKc0t6bkgy?=
 =?utf-8?B?UDF6bUVMV2d1dlpCdTdZdnVWTWtXRUFlY0s2STd0Nk9iS1h5WG10eGZ1VExJ?=
 =?utf-8?B?ampTWkM5ZHhiZnV0Uk53OXFvYmRHc3YrYWRKVHFWYWdaOE5Ba2NHZ05TaHdZ?=
 =?utf-8?B?VGJxTUpReVV4RXV1czFDOURmT09tQjlIZGl4bVR2OU9pT1BoNkFJSi9Scitk?=
 =?utf-8?B?emNBV1ZCRE5JOWI2YWRKSWxTdTJnVHhpSHhVVjhndVRWY0VTbU9IWmdDeVhV?=
 =?utf-8?B?ZCtoeTRqSWEraGdjdU81MFdOemdDamx4NkxoekFZM01GZnNCSW1qZlB3RVc5?=
 =?utf-8?B?U0ZMOGg3WUJOSnBXN1dnUlJaRHN6dTFuSEtlNFlDd2hkeGJBTFpLZXJjbWhP?=
 =?utf-8?B?QTVjUlZvZ1QycFRsZnFjWThmUU1BRlFpVVMrODBucUhHRlhSSk1YRndBeWlS?=
 =?utf-8?B?MDQ0dWFHZ2F3b1liZUIwcVc2NERlNXpHM1pUcUlFaDlCd0xDRXgwKzdGN2Q5?=
 =?utf-8?B?QytnZUxCU0F6QkFxcVErcGh5Y2lCc3Z3Nzk5aFlOcFFBcUhmR2ZjMyttV3Rv?=
 =?utf-8?B?T0VoK1I4UWF1cU13WEVpcDdkQVV0VUxXZEFhT2hGQWc0NHk5OUVSV2ZLZk9U?=
 =?utf-8?B?VVFtT2VJZUVvejRKWWlGc2ZUQkZaQWVGbXhFRERzMTBhcUU3YXRZeEVlVDZD?=
 =?utf-8?B?MnRuYzJEcnYvckFOenZtZ3VHV1ZvWFZYVFBpRHBQdzYzUVJWaEV1cmxEcFUw?=
 =?utf-8?B?dGdOMGh4Y1JxWWhWZ2ZKZ2hxY0FWbys0NURsMDNEdkpiMUMrWTFGZEVkU29W?=
 =?utf-8?B?Qmh4TEo3SEhJbFJpUU9uT0l6cFhrUEpIN3I2M1prWDF3WHhIbENIUGFYQ2pG?=
 =?utf-8?B?dTErdkJZb0RXM0tsUW5ZUUZHSVd4eU1KQXBZSXZSVFRadHQybjNjbEVZYTl4?=
 =?utf-8?B?R2gwZitXUk5DNm4xZDlmclpQVWRoa1VTVW9JTEgzUUVqWE4zUmFHWU96SFE2?=
 =?utf-8?B?ejNJTzdZNERTUjRNS3Y1SThGWm1sNmtNRDNMRENsNGtsZ3dYUHQvZGlUS2V1?=
 =?utf-8?B?MmlhNnVXbU9rK2hpclJtaWRUS2Y5RjhLNVZOTzIxTGZkRWFUdmFyTWU5OFND?=
 =?utf-8?B?RkJOYVpYZlJ0My9kV1dsaGs2OWZtVWlHSHU2b3NqV0gzZkJ4bHJudGc1Y21j?=
 =?utf-8?B?cG04SzlmWUg2YlgxZWNQQ2xRTzZnTU5MNG16Q2F0REI2VnZFNkMwUE9MUGcw?=
 =?utf-8?B?VmJDem5ma3QyMzZoUTQ5aVBoYktFN3B1QWh5ejBFWXNUbnVrSUxTQ2NLbzFr?=
 =?utf-8?Q?TpbmcXJwuje95LfjTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDN3ckNNbTdwNHNsQzhXSGdHeGJhVUo2S05uOUc4RC9TS0FoblI3N0xSUnAz?=
 =?utf-8?B?ZEtLWDZDbFc1K3pETVpiQWxTNm9td2RheDVsTC9tQURoUG1mK3U1TndteHRP?=
 =?utf-8?B?d3pIb3VCaENWVVp0UlVmZVQxbHhnQmIzcnZ2aUFwcUNnRW1KUXB5SG1vYXJ4?=
 =?utf-8?B?MEdhazZEWlRSbVNJT1R4V2Z5NWxJbkorMUE5eWJ1aXlhZ2dIaUNicjd0WEhT?=
 =?utf-8?B?OC9nMzhwK2VyQktvWjBFTC9XY2d2dVpJa0hXTTJKeVovSVlsRUxPNDR5eTVG?=
 =?utf-8?B?OE1NZXVqbWVQQys1Q05FYVJpUHNGdGdNY0diamxkRHRRTjNDcVdKMGxtVUFH?=
 =?utf-8?B?YlFIZk5rYmhhTllxRWQ4SzA2L1hpL0ZEcXQ3V3kwaEtiU1ZaRzFEbithcWF5?=
 =?utf-8?B?OUtUQ2hydDFHSDVXb0xuN3N2VkhRQ1ZJd3FqRWhyc3VTeS9iNmd4eVRUanBH?=
 =?utf-8?B?endwNEYyd0I0V0lpWG1ZZXJybWZadGFmNVFITXIrcFhCWlhsb3pkSFdLa0tO?=
 =?utf-8?B?bkdWa1dvcGk2ZDdVekJ4MDU5RVc0NUpLUmF1YzNpbjlCZXJ4dXdQVmlmYkZR?=
 =?utf-8?B?OG9uSTYvZ1hoWmd5U0Voa1hBR2ZjTm5sNEFzSWNIU0ZvT3p0SURWU0t2aFUr?=
 =?utf-8?B?SDVNMC94ZG5FSHRUTjQrcm5RaVUybHlWcUJPVEFSZHFlT01HSkF1c3VKUTRn?=
 =?utf-8?B?ajJwajA4WkwxRE9nR3NzakpmVTBhOWxRWWx4bC9zZHZ2bTRsaDJYalluaktM?=
 =?utf-8?B?WjMxckd4NlVkSzUvdFdFelIxTzdkR2g5cFhyN2N2U3lZSGtNbjN0amczR1dP?=
 =?utf-8?B?SjQ3UXBlVXdCWlFpSE83bmZWbTJHZHF5ZHFabGt6L0hjc2xxeUhURE8wYmRk?=
 =?utf-8?B?bUpLeUVTZUMzT0N4YjU0OXBrUVJQVUd6cEpXLzBGNXNqV2kzaGRsbDI3YjBq?=
 =?utf-8?B?OC9ha1VCNmJLYVlVOXRNVGxSMzAvamh4UUpnUnAwMDE4V1JlUGdwVnRwbUJq?=
 =?utf-8?B?SEFIZFljdUg5NjRmYVlhcWhQb0Zod0tqV1dFbGhqTWhWVkhPVnJOSFppQTI2?=
 =?utf-8?B?OEF0aU8zR1lyTTkyb29lU1NwcjdTVUN1L3llaUhjTDQreDI4Ukg0R1l4T2g2?=
 =?utf-8?B?TU9JanJzOXJnc0RtSzZjT2RLS0tlQmMrU0E4MDY2TmpHbkVDQ2ZSdnBaeEwr?=
 =?utf-8?B?d3lHSTJESEpKQnBvL3hXTjM1M3R0SHJtd1EvRXJCMUNLL0x0b1ZScW9JQU5k?=
 =?utf-8?B?cVpzYnd2N0xKOHdSK1d1SzhSMjNCNVJxaDF6QU9MaEJyTjd3UWVla3Zvaklx?=
 =?utf-8?B?TkpYOU55T0N6dmFvOEJVR1hvUm03VnMrcjZqK0N4cXpmZWY3QkpnZFhORSs1?=
 =?utf-8?B?dHFtRHIwNURVYVM2NGNYdmhWeFV6V25XRjlwWlphS2kxVTVubTNtQkxUYUxV?=
 =?utf-8?B?c2s0Mno3SVpnc09Rc3dRcGhORm1MQjVLeUFHWVZpaXE0M3VPNHNCTHBFVHZW?=
 =?utf-8?B?anJLWmkzWG5RWUJyOXNzS04remhuVWZFT0J4VFY0dUVQWGo4SGtYVG0xRyt0?=
 =?utf-8?B?b2ZIS2ZWN2FOMVNVeFd6TXh4TmFFK0VHSEtNSTlvOGhoNjZya1laL0xKbjV0?=
 =?utf-8?B?YnlLNUp5Q2JudUxzUWhoN05qbW1MNGY3QjMzTzNhV202L3g2dXJqNnYxUDZT?=
 =?utf-8?B?aEExWG1zb0Z2eWc4bUNMNUdNMVVHcEVBQ0h5Z2t6TlQyaEt6ZWdUT0s5NkN0?=
 =?utf-8?B?Z1RIb25ZZmJsdURORkw3enJTZ1F0VFNsd0VHaFk3OGtvcTJHbFVDZEZDY3Zh?=
 =?utf-8?B?ZW8yWWhST1pKU0ptZWVjNzE3TWJzL3ppV3dWRkJIanE1dHJ3SnhPR3Q0c0tR?=
 =?utf-8?B?ZUlsSnhkanBpbS9oN3NEaXJCSjRLYkVXSi8yVk55a1BmOUF2ZmxZWDlqWlRE?=
 =?utf-8?B?VTh2VkFJNGFnUzBTQVQyb21BYmEzbDZtNmRFTjlWR3UyUUJZM3U5VjFLRG1G?=
 =?utf-8?B?KytWV0tJcGNTUWozZUc4NEJyWWoxTFFwOVl0QkQ5eGF6OStTeGVxWFZJZXdF?=
 =?utf-8?B?MnRIOGpzYnJiNitWdEFjNXV5eUNSWmN3ZThsOFp6L1pyMnBKQ0hTNnFtT2w2?=
 =?utf-8?Q?gdNIeK8iZo9Jn8kVbeGONaROd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe18b89-450d-44cc-187a-08dcb1dda176
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 03:54:23.5612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dz9nxugM7l/HjUi2mA58vrGLmBEWemLgYH9Cvs41vuVe5klDtditZaJjZljdwZKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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



On 8/1/2024 9:17 AM, Zhou1, Tao wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, July 31, 2024 9:31 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: report bad status in GPU recovery
>>
>>
>>
>> On 7/31/2024 3:35 PM, Tao Zhou wrote:
>>> Instead of printing GPU reset failed.
>>>
>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 355c2478c4b6..b7c967779b4b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>>             tmp_adev->asic_reset_res = 0;
>>>
>>>             if (r) {
>>> -                   /* bad news, how to tell it to userspace ? */
>>> -                   dev_info(tmp_adev->dev, "GPU reset(%d) failed\n",
>> atomic_read(&tmp_adev->gpu_reset_counter));
>>> +                   /* bad news, how to tell it to userspace ?
>>> +                    * for ras error, we should report GPU bad status instead
>> of
>>> +                    * reset failure
>>> +                    */
>>> +                   if
>> (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
>>> +                           dev_info(tmp_adev->dev, "GPU reset(%d)
>> failed\n",
>>> +                                   atomic_read(&tmp_adev-
>>> gpu_reset_counter));
>>
>> Better to check reset_context.src == AMDGPU_RESET_SRC_RAS to confirm that
>> the reset is indeed triggered due to ras error.
> 
> [Tao] It seems AMDGPU_RESET_SRC_RAS is not used currently, I will set it before use the flag.
> 

It's set here -
https://elixir.bootlin.com/linux/v6.11-rc1/source/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c#L2607

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>                     amdgpu_vf_error_put(tmp_adev,
>> AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
>>>             } else {
>>>                     dev_info(tmp_adev->dev, "GPU reset(%d)
>> succeeded!\n",
>>> atomic_read(&tmp_adev->gpu_reset_counter));
