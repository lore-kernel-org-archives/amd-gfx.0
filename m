Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1170C3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 03:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E3010E836;
	Fri,  6 Jan 2023 03:55:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816F910E836
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 03:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO5dEerPvicidHi98XVy9HErPp+asCAZ0/rK2n9X3oIQSfb8UACAv1yPEoo6/6AWDxiv2XtCjukkShYl/fBqKpdfBI3dJOSojnpLNG+msCOszSubOOd7Fo+XDo5xQSncVF28QpmGyLZPaQP2fHlqeaWCMytmr129haA3oss/1V6UR9bzzX2iAD9sKdnMuX4uFjNH3mBXL9He6WtjFk8FWrTkQVFXZ7nNW43gZoCzWKVaHpnnMiVBD6kWSlAbkiRRQvQ3srBzJdZiZWcj0WnwwIa0rGdKOx30gNusIklhWO+bEODSHwDIlg7cjT17reTpXJjfSUBJz2LRFot9H18HwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJBaqUCMvy4ECsVC7CoJKKRcdrM/7zuQrBVsWdbfpzU=;
 b=IEttySB6Yc9KsnSgEpNmAn36OEMGjE4ACqp8IExXb55rCgl8w2qxyuFjfwXeqjQSPIrWi1bGFUr1YyjEYlQfBm3q2hXabYpVGFsLZEabEsga6RMyv9URXx0HFgN3C5lWuz2Un8VkbIHcL4FMNeM/sFbPv4of/HOjz/v9ZsJPND1jCbzRYAa7l3r0PC+jBgM+HCPemNgF9gwRjl+W/FyDgQXvzLFA8r8IRhWXKGpU1hkuslOwACovq7QIrBsDInhBzF7HkY5I1NJKGk5UXdAFYB6kmRtul/ctRCYFbsvdZgO1bpkjyblKLUxrs1NOra88l/l5nErWD1O1keWtpz+cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJBaqUCMvy4ECsVC7CoJKKRcdrM/7zuQrBVsWdbfpzU=;
 b=G+LzYsytFHSTSOBsThZOyDuSznWWNDbCsAR6qIC5gHEzG7wNTEiHF3tESqlJEWvjtff3q8VIXYp7LRJqzsZpJBFKKeyAPdKMY9TlRNR8rETGmywGjk9iig5SPnA+ZVgO76VjPSQosQ7Z1b/k76V1i7DzXy4HpNfx259qC8/kAzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:55:11 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:55:11 +0000
Message-ID: <c6464af2-285b-adbc-bcee-d713400a34cd@amd.com>
Date: Fri, 6 Jan 2023 09:25:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
 support
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-2-evan.quan@amd.com>
 <e505ace7-4606-e048-9ded-ce7f6ffa023e@amd.com>
 <DM6PR12MB2619E5A0C6A0DA9B6A036945E4FB9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619E5A0C6A0DA9B6A036945E4FB9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: d48e46ce-44db-4bed-2379-08daef99cf39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQsRpIFB8IxaYtupZXMW1noDaJjBfjUSlRoOWKSSmyZn3ujbifdOOiRYMXwKaePZ9Tx4n/+yeKZL79QPhFsSDl2q8y0z9rEIqEiVS7R3KPe8dfTVJlxiCGDANO2VAByaHFFeH+dIUkTkSfgRv4/vuX4TqBH68M8WB/xiGg8AaWUz0/K80E8o92rtp8tl/hXZd/dSj9T8G39rVL0XqDb+DtYinR2PKPz8YIE0GoTT7I8yESOy8SadMhYKb0cd+kvmDsRI3LRg6QKykKwymJodGidxdfDTj7KVYne+36/E86OCHaACIM8H1lIh3Pd3eSyXAOepGspHaf08WoKlPm7eyXrfsSg9kvNXm8fchoAnGahqDxrOwlrDMbm4G22Yg6tcWjFuJXH9yFH+wBAmNFwc4DpTpbmMcs1aJ3ze3t06eaBXQBhOfMhP105eapK+GOh92oHBFNXVPLLtYQULoNkDcXedSECuMc35VBXhbYASX4OnBHvFgy/WL5R3+3CFsWX2gQup007X95n0Hgyflrrpj5fa9E/RVPv7l4upz9CdJ+rcRnq5+QBquO1E4xyRSyqL1hi2hqW7hz94lFYPvtpzt/QfNFpYb6tnAyFjEsPUJbGh6xGIQIGC8RNwd2CbZDcFMDx3rwjLNdLAod4LVM1yYq0pBPxxMp51lW2hzsMnRl5h3jnvkGYeYybaLogTJ6dwJuO0gQbA4kVaRo/gT5PFAxldLYVpJWFr6EzE/PFNcRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199015)(2616005)(6512007)(6666004)(53546011)(36756003)(26005)(6506007)(186003)(83380400001)(6486002)(478600001)(8936002)(86362001)(5660300002)(31696002)(4326008)(66476007)(66946007)(66556008)(8676002)(31686004)(110136005)(316002)(38100700002)(41300700001)(2906002)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhPRWdtNzBMQVhsZzl3TXB2SGNoQis1aEZEM1FQMjR4czB4eHB5QWNQSm5E?=
 =?utf-8?B?WUNkMTFONFFJRnRzYlF0LzN3Vm5STVB2UlBVeHNrbDFnQ0owdmQ2ODdXaWFy?=
 =?utf-8?B?Q2FMcjVpaDBVbmg4RU5wSVZkR1hwbSt2VFVkQjlYM2MvVVpBcnlsK1hLLzNu?=
 =?utf-8?B?RGpIQ2poMVJiZHZyMGdmWlNMejJaTElJUnFGOVRKaTl6YTQwbXN2aDVGMVBG?=
 =?utf-8?B?elp1MHdib1NuL3k3M05NcmtUZG9BK3JHWWcvTUlEYlJSNStkRlBiQzg1cmM4?=
 =?utf-8?B?TFppRHRzeVZOVXZUTnp0RGl6RXgzSEtBOERuM3FzZHUvVXpmUWtpbzFoZTJY?=
 =?utf-8?B?aHBLZ3JIV1lyNk1PaEgxTTA5L0VYVFJnV1J3bmtYTGt1aXNYVTROVFFKRzRR?=
 =?utf-8?B?VHhtWGNBVkpzTEE3ZXh6bDhCR3IrVlg0emZZTVk1elBtUEZKaWlid3JZV1N0?=
 =?utf-8?B?aTNlSUNNWmU1ejdiZDNVK3d4dTFDZXkyMUZraGM2OWhodFNycWRyN29QdTNW?=
 =?utf-8?B?QjFxVlpaMHp3anBZL2x1SVdPaHJLU01TZnU2UnJQQ3UreWc2L2ZkZWJHaE9w?=
 =?utf-8?B?Ni9xenNhZUorMG5qK2hoQlR6alQrN3R2NUE1TDVyQWpmWmhway9ZSFRQTmJB?=
 =?utf-8?B?MUFMNDNadmtKdVhhUXFhb3Z1TWpyZVo2RWZzWjNFUWFBdndKK2dvaE9IZEpY?=
 =?utf-8?B?TkdnZHdDMnVMbHorQ2oxOWFYWEVRbTU2U3gwenJ5c0RpNWo1UHRqOGNzbVRE?=
 =?utf-8?B?bTh3WkplK3ducFFBQW9JcWdqWW04ZHNFbUh6Ymo1TlVBbUZaQ2tRNkhiMk9r?=
 =?utf-8?B?YUhTZVgvcEZtdVlZeGRvY1R0cXJPVUtjVjFzQzRyVzJURXhiQ25pMm94dVVQ?=
 =?utf-8?B?VWJDQlBVWGxyeW93bFJHcEpwK2diWWN1ZkpSUlB0c01DTm91bUV3RmQ2aHdB?=
 =?utf-8?B?MC9qVFJSaTRXdm43N3ZOSytkTG9WU1JBKzZlMVBEdW8xNHJkK0tqb1ZwNVJk?=
 =?utf-8?B?K3B6eWl3RG1PQkhjcTdHNEx1anZNREkvTWdicXJ1cHIvSC9SUjQ0ZjBrY2hq?=
 =?utf-8?B?bjd4R0dwRmpwUituZ0NhYWFlRVBXTWZzcHpaeDNiVjRrNUgwVHVxR2xYazdT?=
 =?utf-8?B?L2M1aWtmRUdSUDhSRWRPMTVFd3pXS1dJcDZLQXhpWnNwSGs5SFBzSTN4elZl?=
 =?utf-8?B?S1VMZ3dNYXNCMHBqK1gwTXVtTjRtNEkzeTFkOXArdWR6S1pFZG9mTnFCMVVH?=
 =?utf-8?B?Y2wvaExaUnB3b1NzZnBWc0x6STJaZk9pRDBvTUl0UjIrZEJhekhmeEFEaUZv?=
 =?utf-8?B?eHlidnFZdTEzakxEbHNmQzA1RWRvdDhvTDhadG03eldGcU01SDdJQWhoRjMz?=
 =?utf-8?B?cEt0QUpvRG9jVGJxcXU5Y3FFVDZJeEI0NC9tY25FSDI2WHNpVmpoZjQrbmZq?=
 =?utf-8?B?alpHUmhVSkZFZWg5aUw4TG1VTzNCZWtEU1d2TmJOSzI3SDVwVFZWOUJHVkp5?=
 =?utf-8?B?VFJCRzNmd0ZrR1grS1JHdW5qejZLR0QyTkcyTXo2U21VcmNsNzNjT25YZEZi?=
 =?utf-8?B?dllmeWttdXlHQzAzTlRULzBlTW5HRUhYVDllMTFWM0dNRHVZeDdOS2QvQytS?=
 =?utf-8?B?MngzYTA0LzFxYVBCUUpNakdEd3RHcFdNNC9JSE51Qis4Zmh1aE8rRkVJSUpO?=
 =?utf-8?B?OGM2TmVMRzhWZVRsbmM5NzVUeEkyN2xDbldzbjlyZ0NXaVpCMlFFRjJwangz?=
 =?utf-8?B?U2JyMHFrelgwU1llTUVMaHRmZEQ0REJlbHVFbjZuU0crelZJTkhoSGIrUXNV?=
 =?utf-8?B?OGZvbGVtTUI4WmJ2TkJlMzlpcjBpVlRDYTd2SklES0lDdzBjSkdaTFhKcEJT?=
 =?utf-8?B?UGFBcFNzdUNDeGVFdlQvTS9DV2NnenZjMnJqN3lMN0I3WjFucklKRnZqa3pj?=
 =?utf-8?B?Q1FlR1F2RnFKOFBFR3gzUHZvZTVqY0VhNXpOcG4xMkhDMzJtQVN4cEtVb2pH?=
 =?utf-8?B?Zm0vK0NJRDVQTmJlT1ViYm1hTXJQRFpsL0poN0VaRjFlOVZlUWJuM2FZRHBI?=
 =?utf-8?B?YmRuNHBDZnVkSkdMNFA0Yys3M0FiK2FGb2sxZ2VsWElJWmJJdThxZzQrcjNT?=
 =?utf-8?Q?NQELWv+sAZJ62/tk+yRQoc9Jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48e46ce-44db-4bed-2379-08daef99cf39
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:55:11.5915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1EsgXyqCtbSDmtbxkSY3vcEbqSk327yzDVjVMpGr1AdxTUD+Z8pQT5navLiqT9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/6/2023 7:34 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, January 5, 2023 9:58 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
>> support
>>
>>
>>
>> On 1/5/2023 8:52 AM, Evan Quan wrote:
>>> Make the code more clean and readable with no real logics change.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200 ++++++++++++++---------
>> ------
>>>    1 file changed, 98 insertions(+), 102 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> index fb6a7d45693a..c69db29eea24 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct
>> amdgpu_device *adev, struct amdgpu_device_
>>>    			       uint32_t mask, enum amdgpu_device_attr_states
>> *states)
>>>    {
>>>    	struct device_attribute *dev_attr = &attr->dev_attr;
>>> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>> -	const char *attr_name = dev_attr->attr.name;
>>>
>>>    	if (!(attr->flags & mask) ||
>>>    	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) &
>>> adev->pm.sysfs_if_supported))  { @@ -2016,112 +2013,14 @@ static int
>> default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>>>    		return 0;
>>>    	}
>>>
>>> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
>>> -
>>> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>>> -		if (gc_ver < IP_VERSION(9, 0, 0))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
>>> -		    gc_ver == IP_VERSION(9, 4, 1) ||
>>> -		    gc_ver == IP_VERSION(9, 4, 2))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>> -		if (mp1_ver < IP_VERSION(10, 0, 0))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>> -		*states = ATTR_STATE_UNSUPPORTED;
>>> -		if (amdgpu_dpm_is_overdrive_supported(adev))
>>> -			*states = ATTR_STATE_SUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>> -		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0,
>> 1))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>>> -		/* PCIe Perf counters won't work on APU nodes */
>>> -		if (adev->flags & AMD_IS_APU)
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(unique_id)) {
>>> -		switch (gc_ver) {
>>> -		case IP_VERSION(9, 0, 1):
>>> -		case IP_VERSION(9, 4, 0):
>>> -		case IP_VERSION(9, 4, 1):
>>> -		case IP_VERSION(9, 4, 2):
>>> -		case IP_VERSION(10, 3, 0):
>>> -		case IP_VERSION(11, 0, 0):
>>> -			*states = ATTR_STATE_SUPPORTED;
>>> -			break;
>>> -		default:
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -		}
>>> -	} else if (DEVICE_ATTR_IS(pp_features)) {
>>> -		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0,
>> 0))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
>>> -		if (gc_ver < IP_VERSION(9, 1, 0))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>> -		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>> -EOPNOTSUPP)
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -		else if (gc_ver == IP_VERSION(10, 3, 0) &&
>> amdgpu_sriov_vf(adev))
>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>> -	}
>>> -
>>> -	switch (gc_ver) {
>>> -	case IP_VERSION(9, 4, 1):
>>> -	case IP_VERSION(9, 4, 2):
>>> -		/* the Mi series card does not support standalone
>> mclk/socclk/fclk level setting */
>>> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>>> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>>> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>> -			dev_attr->store = NULL;
>>> -		}
>>> -		break;
>>> -	case IP_VERSION(10, 3, 0):
>>> -		if (DEVICE_ATTR_IS(power_dpm_force_performance_level)
>> &&
>>> -		    amdgpu_sriov_vf(adev)) {
>>> -			dev_attr->attr.mode &= ~0222;
>>> -			dev_attr->store = NULL;
>>> -		}
>>> -		break;
>>> -	default:
>>> -		break;
>>> -	}
>>> -
>>> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>> -		/* SMU MP1 does not support dcefclk level setting */
>>> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>> -			dev_attr->store = NULL;
>>> -		}
>>> -	}
>>> -
>>> -	/* setting should not be allowed from VF if not in one VF mode */
>>> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>> {
>>> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO)) {
>>>    		dev_attr->attr.mode &= ~S_IWUGO;
>>>    		dev_attr->store = NULL;
>>>    	}
>>>
>>> -#undef DEVICE_ATTR_IS
>>> -
>>>    	return 0;
>>>    }
>>>
>>> -
>>>    static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>>>    				     struct amdgpu_device_attr *attr,
>>>    				     uint32_t mask, struct list_head *attr_list)
>> @@ -3411,6
>>> +3310,101 @@ static const struct attribute_group *hwmon_groups[] = {
>>>    	NULL
>>>    };
>>>
>>> +static void amdgpu_sysfs_if_support_check(struct amdgpu_device *adev)
>>> +{
>>> +	uint64_t *sysfs_if_supported = &adev->pm.sysfs_if_supported;
>>> +	umode_t *sysfs_if_attr_mode = adev->pm.sysfs_if_attr_mode;
>>> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>> +	int i;
>>> +
>>> +	/* All but those specific ASICs support these */
>>> +	*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +	*sysfs_if_supported &=
>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
>>> +
>>> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
>>> +		*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
>>> +
>>> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
>>> +			*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +		}
>>> +
>>> +		if (gc_ver < IP_VERSION(9, 0, 0))
>>> +			*sysfs_if_supported &=
>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>> +	} else {
>>> +		switch (gc_ver) {
>>> +		case IP_VERSION(9, 4, 0):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +			break;
>>> +		case IP_VERSION(9, 4, 1):
>>> +		case IP_VERSION(9, 4, 2):
>>> +			*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +			/* the Mi series card does not support standalone
>> mclk/socclk/fclk level setting */
>>> +
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT] &=
>> ~S_IWUGO;
>>> +
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT] &=
>> ~S_IWUGO;
>>> +
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &=
>> ~S_IWUGO;
>>> +			break;
>>> +		case IP_VERSION(10, 1, 2):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>> +			break;
>>> +		case IP_VERSION(10, 3, 0):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>> +			if (amdgpu_sriov_vf(adev)) {
>>> +				*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>> +
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFOR
>> MANCE_LEVEL_BIT] &= ~S_IWUGO;
>>> +			}
>>> +			break;
>>> +		case IP_VERSION(10, 3, 1):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>> +			break;
>>> +		case IP_VERSION(11, 0, 0):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>> +			break;
>>> +		case IP_VERSION(11, 0, 2):
>>> +			*sysfs_if_supported |=
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>> +			break;
>>> +		default:
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (mp1_ver < IP_VERSION(10, 0, 0))
>>> +		*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
>>> +
>>
>> With this change, the IP version based checks need to be moved to
>> respective smu_v* checks so that each IP version decides what is supported
>> at which level (R/W) rather than consolidating it here. Only generic checks
>> like amdgpu_sriov_is_pp_one_vf may be maintained here.
>> That way it really helps.
> [Quan, Evan] For some of them, they could be moved to respective smu_v* or gfx_v* checks.
> But for some of them, it will be difficult. For example, for "mp1_ver < IP_VERSION(10, 0, 0)" or " gc_ver >= IP_VERSION(10, 0, 0)", you need to figure out which asics it refers to first and then apply the same change to every of them. That seems more error prone.
> So, my thought is just left these old chunks as they were. And we just need to take care of the future/new asics. How do you think?
> 
My preference is to clean up this as much as possible. Also, you may be 
able to set some of them generically based on FEAT_DPM bits in 
swsmu/powerplay.

Thanks,
Lijo

> Evan
>>
>> Thanks,
>> Lijo
>>
>>> +	if (adev->flags & AMD_IS_APU)
>>> +		*sysfs_if_supported &=
>> ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
>>> +
>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>> +
>>> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
>>> +		*sysfs_if_supported &=
>>> +~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
>>> +
>>> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -
>> EOPNOTSUPP)
>>> +		*sysfs_if_supported &=
>>> +~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>> +
>>> +	if (gc_ver >= IP_VERSION(10, 0, 0))
>>> +		sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT]
>> &= ~S_IWUGO;
>>> +
>>> +	/* setting should not be allowed from VF if not in one VF mode */
>>> +	if (amdgpu_sriov_vf(adev) &&
>>> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
>>> +		for (i = 0; i <
>> AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
>>> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
>>> +	}
>>> +}
>>> +
>>>    int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>    {
>>>    	int ret;
>>> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device
>> *adev)
>>>    	if (adev->pm.dpm_enabled == 0)
>>>    		return 0;
>>>
>>> +	amdgpu_sysfs_if_support_check(adev);
>>> +
>>>    	adev->pm.int_hwmon_dev =
>> hwmon_device_register_with_groups(adev->dev,
>>>
>> DRIVER_NAME, adev,
>>>
>> hwmon_groups);
