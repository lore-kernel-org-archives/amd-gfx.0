Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B47EC2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 04:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783EE10E3AC;
	Fri,  7 Aug 2026 04:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuDKEUMd";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771DF10E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 04:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjsCdIC1ZKUHsIzqs5AtwNzrr56YtTNd1l5sedu12IcOR7DAK8AHgw37Uw3EGHerh2PmsFUrDLwXzbbKT14k0H2aS2tNVOROTlSz4K6XpS2FlIqmcGGzR1+2JblAccOtW2pLHTPzCVeswHof0AoPBxCD+RChn1CX1g0piBLzZWg0ZkCeUn0+1Yx+PxKjaoRGqpm1wIfdOUD4Eq3wy6uUuETSIDIQpINE5rBjmM4aPDA1SLBRC/s5jlgAS2V3uFPKpT8WuYk3ERCNDdPrffbfwE7+y/ML3B07ETuWuRuCXhwsHAMpWNj9UQsfUvKZQO/8IQoYu2kMZHUJph09baqvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvlxAIyMiKyMC0FNh33fEPEnwpKFXLewfk49KlWRwGw=;
 b=sdDwRaJSL3VAdkeOTiTiMGZOEuZaAyNGD8j59mhjTkOLCdR2TtcIGhiFfE9DlmnxWYx9Mtq70SbbZTIqASzoyboGZJyGNMPNq401Nnwlzd0w8FvaZ0mp08qTlVNJi2AjOyWmJIII4KDYB8RwnNKb3Gaoz+HxaXIKDNI3bi8hMoTkH3EI/cF0zyPZp+xHMD3V8HxPkLbGYDFcRZysEFBcAfvg5R0DQRqbKjjRXNcheqWJKW+4S+BhanQSH8Dwc1/eQ6sFZRxVgeQKiWBzQ9xEpGdFwCgBmCSWpx3hN/FEKwzVlo8Vo7/cH+JsCBSJk5TuFQkXOIDr1EjkSZ7DJqzW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvlxAIyMiKyMC0FNh33fEPEnwpKFXLewfk49KlWRwGw=;
 b=uuDKEUMd9Eulj/YFyCnmyUqm1M2o3P0AC9GlD5JAfJWf7gAIwe1H2qVIv7H2I7F98NuPCg9fMbgbab9TSuGNygpEC9eqtrZhBlUBweyhpG66P6JZVw7MMrT+xXi+dWRBKTKnEDp9nsDDtTs6rna4gEjaNBa07TzdqByHLjSSyPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 04:50:19 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 04:50:19 +0000
Message-ID: <5c93281b-14d9-477c-86b2-a5e6acdec78a@amd.com>
Date: Fri, 7 Aug 2026 10:20:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260806061413.3720389-1-lijo.lazar@amd.com>
 <BN9PR12MB52110CD725737790A39A3E8682D22@BN9PR12MB5211.namprd12.prod.outlook.com>
 <024580be-2d0c-4ceb-8155-c276c63e0d4c@amd.com>
 <BN9PR12MB5211B0562AA983BC39E5A66282D22@BN9PR12MB5211.namprd12.prod.outlook.com>
 <bb56d0f5-52bb-4757-856f-c22b4bbe363b@amd.com>
Content-Language: en-US
In-Reply-To: <bb56d0f5-52bb-4757-856f-c22b4bbe363b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25f::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e6f37c-8608-4542-364b-08def43f613a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: L733QJ0FPKRqer4HbBJftN0t5cPPbA8EbCXAEM2rYYPUP97XjSW4aXzvapL0WirpDUGIEBRRaoozOyIcumI7MgS+3lL63lrRDGFJ0+GWYObLLROPPDZzVe4Y1uK3liZmUhPXin42bp7fq7xMRr6+h7eQzkt3O6gx5L8rMtm3ptyJQrEvSIfDvX4M9pk95jygXCTqU1Sdd5kygbGsXB3gXLmDvngENLYOk71ngb5u57JfuoaNyncCMrRdl7hqOfULK6WmXd+AfTo4QqZ40DaTHnwxyqrOgzRyf3be2ncb3oH3V5F0pRtPElYrhdHqMlEacxe6BDsH11mU2PhSOLGm5IsUo4M+XJEkXVN8loP37G3qcR0FnX4wWVuuw+3AzIObZB36adxO2yY2qyyunyOd8aQpV06fYy+jVn6C3rVVfsjCWB2VMnHMsC6CW9ZSa5FjH6gDh/7oeHcO+nGx1NeQ8ZW7/9gmD9tPbM7yjqXwl0QjzyELmHyoafMJNd8ZiQIlG38vbS4usqcpCuJBaZoc4xdTgeSzHktVjO7fhUBStKbyDIgAwB2kfp9xGw4mBEL09HgeVrWym+VMuMq7dzKrKEhpiUyB3JeYB7abMF+OxVvXuMNkVOIV1NAhjWxhs2XIolrVGWfMEuWHQCAV7BogFMK5rr/W9KLEOSAZ/KY6LWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkszUHRrd0laVUV4OFpBVHdETmdMZ0lXVWdqbjE3NXRtajBLVkJrNVZmR0wy?=
 =?utf-8?B?UjkwdjlxTldjeWZadzdHcUQ0a2QzK2hNWnllc2lUdjkwWWJMRTR6VE01Y21N?=
 =?utf-8?B?K25SNXhVZXdSVUpWTmthVG14Ny9RSDdqRWpKNDdnNWU3Y0E2N2lnTjlBam1L?=
 =?utf-8?B?WGdHZVI2ZUtBZC84bzFqcUVNRlFQaldYb2IvV002YlVwbUVNYjhaV2ZqOE52?=
 =?utf-8?B?dHhnUWpWRjlDcEdyU0IvcGE5TG40UDNkc3NvakpFVEh2K1IzNnFrek1Od1FL?=
 =?utf-8?B?SEpPOGhYUHMzcnRlU2g5eTZ1ZlJyV3ViMC9Gc0k3MTZtMllDQTdxMytGSEhz?=
 =?utf-8?B?NWQwMDhBaUlCVXYvYnU0TWI1bDNaUGZ4dlh0SXVVbCtiTEpqSGdURHMzVzJx?=
 =?utf-8?B?V2tiOHBucVJ2NmhXU0NDVG9QNmtUbE8wMkNwMU1NVnFta1hwdHg2VHZUTnNJ?=
 =?utf-8?B?ZHRFR0hZNXBHNVJGR1EwcGdyUzZZeHZWeTRPWjFmSUtZbUs0MTlqZXF3SXJL?=
 =?utf-8?B?L29mSWhBMDI0QU41Q25BeWcyMnRWbzZkc091K3J0bEVJNUt0WU1WWjNnMDBH?=
 =?utf-8?B?Vm1ybHdsQzMyMVo1aEJnM3BQQkgxNVZSTENjeHQwQWF4bFU2R21YR0YyZWJD?=
 =?utf-8?B?Q2dWR05qcHZUN2lBVUlXOWVPOUtxZTd2R09tcWVPRmZHTG4vTFpnNkZsMm1J?=
 =?utf-8?B?YWhPZVRBd3hYTFM5U3g4TDZXM0NSUXNnMGNsZ2pBSmZPell2Yi9IR05yL00z?=
 =?utf-8?B?NmNvcmVsU3NIZFZISlBPZDMrTUNzY2JER29MZUR4bWZjNzJ3K0RYVGdPUHJH?=
 =?utf-8?B?VGpLRlA4dzJUa0dEZ1F3ckpDM08wWklvb0RqakgxemYzSzlIMVhWWTB6Z29i?=
 =?utf-8?B?ZnpuMWVDbktMWnhWN0pqMHZKQzNRZ0NsMGlwRnpiZVVPbUZMTzJNMUtTUjkw?=
 =?utf-8?B?eEh2ZWNKSi9KZnZVVlpLd1p0OFNVY09HZDYxREtaRWIwZVg4alJRbi90aitR?=
 =?utf-8?B?YVhSYVlEVmN2OUVsTmFweHBJdFljVlR0ZjBoMDRJSUJSdUxiUUJDZGVnMndD?=
 =?utf-8?B?VU16NHgyWG05UW4xbDFQUm1sUWs5S1BzUTI0UkRFb1d4Wnk5b3hoMTdKdGw5?=
 =?utf-8?B?Lzk5Z0tCN0JVNHJneEdlanhpUnJHZ0lQOHVuVy85d2Jwb1NjL0JQWkU2Z0Vl?=
 =?utf-8?B?dEwvajdSMzl4d3EwMjFOWGhQK1dCcS9Udk9kSkp4T2h0STZCN0ZRNGJnUTRx?=
 =?utf-8?B?U1pQYTNndGdha3Q1NnhsMXNETThDZWNyUGsvTVg1Q0QxMVE2c1hmdzF5S3pi?=
 =?utf-8?B?VEZqN0lsaWpBYXdvTjhjOWhKQzA1UFBFL3lRUHFWVG1lTnlWOVFiQ3BHUGx4?=
 =?utf-8?B?MG9VbUJLZHVTTFRQWUdHNEZGOW1TUWVJZFpxV3JwU0lCU3ROcDIrQTJwOXRq?=
 =?utf-8?B?MDVwZXlJUUhuRlhUVHArRVZhazllcDhBcytQN0xyNmZ6dDRhOFFWbkZtTGxM?=
 =?utf-8?B?OHpGTnFBNUF5QjlaanpUbGhBREI3dUN4UjZzcmxKOEh1d1NBYTNpYmRXUmNW?=
 =?utf-8?B?SHVyblB0dVVrVGF5Ly8weldIcHZhcXAxcmF3eDdWc3gvUmFLRzk0RDFUTE1m?=
 =?utf-8?B?S1pnbS9RTXBzcWFFZXNtUkFMTlFQazlWbWNkenIvaHRDRTV0MUNNT0NaWXJD?=
 =?utf-8?B?WXdaV0thK2FZUFRhdlptQWxpbHU3OENCTnFvV1FnZ0o5V2hvYWgzN3NWZUt4?=
 =?utf-8?B?c0lmMTlaVnBIYndDa0lFYU5KcnVMSWxuZk5kRmxydGtiUjJSWUFwL3V4M1lk?=
 =?utf-8?B?MWQvclgvcUdKcmpSU2Nubnl1SjlsZGhhMjhqNURIU2lkemRWNEFaalJrS1Qx?=
 =?utf-8?B?NVQ3eWVIZE02U3RMeWg3anJlQnN4Vjc5bkZIYUVBdTlZL1ZRL2RQVERYQVFF?=
 =?utf-8?B?M0pBQmM5ZGZ0enNMOUU4SURDZ1c0Z2x5S3dMd3E0bjlBNDlEM1EvZ3dYb0RR?=
 =?utf-8?B?R2VudzJITVlONFRDbUpmVGprMlFlbU82a0k5VUV5VEIvYkwvQkMvd09zUHR0?=
 =?utf-8?B?anFIYjVxYWtZeFBCdVB6ZUpQbTJkWEZlODRPd21PMGExOEllNEZiU3JjVk5s?=
 =?utf-8?B?Q1MrOVVrcGhUeDkyQXR1dnk4MHgvT2o3VXozT1ZOVS9XaWVVTDNqVHdhWFoy?=
 =?utf-8?B?UHJrb3lnTVYrT1hZU1k3V0tSRGdTUkVMcGhoS2oxOE40MlEwc1VncXlDM09T?=
 =?utf-8?B?TGNsN2NIaE0rZHRvejFLVmQ3SUhPLzdyZWt6MzdmU25aVzltc3p4alNHVndS?=
 =?utf-8?B?UzZnK1JBSG14WG1YQ1RyazFFRVExTkR2YUFEYVZBWFBvY0x3dWU2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e6f37c-8608-4542-364b-08def43f613a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 04:50:18.9202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgVojvABKVmkIi6OFrBHxHGoEl44OP+QkPr0kwxQukvD6NVYykJXm6GrHX/7vhqH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619
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



On 06-Aug-26 1:32 PM, Lazar, Lijo wrote:
> 
> 
> On 06-Aug-26 1:26 PM, Wang, Yang(Kevin) wrote:
>> AMD General
>>
>>> Driver triggers resets which could relaod the whole FW. In such cases 
>>> driver
>>> remains responsible for restoring the last known power limit. The 
>>> current
>>> method doesn't do that.
>>
>> No, the original code already contains this restore logic, include 
>> suspend/resume + gpu recovery, and save/restore logic has been 
>> verified on Navi21 and Navi48 ASICs.
>>
>> And the if no user edit power limit from user side, the driver will 
>> skip restore power limit, in this case, the driver will use default 
>> value after firmware reloading.
>>
>> btw, your change will break gpu od + power limit logic in navi3x/navi4x.
> 
> This patch doesn't break that. Whatever user has set as the last limit 
> will be the current limit in Navi3x/Navi4x case. That will be restored. 
> If user hasn't edited limit, current limit will be equivalent to default 
> limit and then it's not set again.
> 

Hi Kevin,

Does this address your concern?

Thanks,
Lijo

>>
>> So What issue you have facing now ?
>>
> 
> Driver remains responsible for restoring the state triggered by inband 
> actions like suspend/resume or reset as OOB doesn't monitor everything. 
> In such cases, driver being the inband owner needs to restore the proper 
> state after the event.
> 
> Thanks,
> Lijo
>> Best Regards,
>> Kevin
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, August 6, 2026 3:48 PM
>>> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>>> Subject: Re: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>>
>>>
>>>
>>> On 06-Aug-26 1:03 PM, Wang, Yang(Kevin) wrote:
>>>> AMD General
>>>>
>>>> I do not agree with adding a read-to-cache path for the current PPT 
>>>> limit.
>>>>
>>>> The current limit is PMFW runtime state. A read of that state must 
>>>> remain an
>>> observation; it must not implicitly create or update driver-owned 
>>> persistent
>>> policy.
>>>> This separation is intentional: the driver keeps immutable 
>>>> capabilities from
>>> the PPTable and restores only limits that it successfully programmed 
>>> itself.
>>>>
>>>> Caching a value returned by GetPptLimit would turn a potentially 
>>>> transient
>>> or out-of-band PMFW state into a value that the driver replays after 
>>> suspend
>>> or reset.
>>>>
>>>> There is no ownership, notification, or synchronization mechanism that
>>> makes such a cache authoritative, so it can only become stale.
>>>> and the existing user_dpm_profile policy *CACHE ALREADY* handles the
>>> supported driver-owned update path.
>>>>
>>>
>>> The existing path also doesn't have any synchronization with out-of- 
>>> band, so
>>> the same argument holds. i.e., it overwrites whatever set by external 
>>> source.
>>>> If no bug fix or feature improve, please drop this patch.
>>>
>>> Driver triggers resets which could relaod the whole FW. In such cases 
>>> driver
>>> remains responsible for restoring the last known power limit. The 
>>> current
>>> method doesn't do that.
>>>
>>> I will add a bug fix tag as the previous patch doesn't restore the 
>>> current limit
>>> properly.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>>
>>>> Best Regards,
>>>> Kevin
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Thursday, August 6, 2026 2:14 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>;
>>> Wang,
>>>>> Yang(Kevin) <KevinYang.Wang@amd.com>
>>>>> Subject: [PATCH] drm/amd/pm: Track current PPT limit for restore
>>>>>
>>>>> Cache the applied PPT limit in the ppt limit range and refresh it on
>>>>> every get and set. Initialize with the default value on fresh load; a
>>>>> value equal to default is treated as unset.
>>>>>
>>>>> On suspend or reset recovery, restore the cached current limit when
>>>>> it differs from the default, falling back to the default otherwise.
>>>>> This replaces the user- mask based restore, covering limits changed
>>>>> outside the user profile path as well.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39
>>> +++++++++++++----
>>>>> -- 
>>>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>>>>>    2 files changed, 29 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index f45cd4e31415..7edd919a7832 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -495,16 +495,11 @@ static void smu_restore_ppt_limits(struct
>>>>> smu_context *smu,  {
>>>>>         enum smu_power_src_type power_source;
>>>>>         struct smu_ppt_limit_range *range;
>>>>> -     uint32_t restore_mask;
>>>>>         uint32_t limit;
>>>>>         int i, ret;
>>>>>
>>>>>         power_source = smu->adev->pm.ac_power ?
>>>>>                 SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
>>>>> -     restore_mask = smu-
>>>>>> user_dpm_profile.ppt_limit_user_mask[power_source] &
>>>>> -             smu->ppt_limits.supported_mask;
>>>>> -     if (!restore_mask && !restore_defaults)
>>>>> -             return;
>>>>>
>>>>>         smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
>>>>>
>>>>> @@ -512,14 +507,14 @@ static void smu_restore_ppt_limits(struct
>>>>> smu_context *smu,
>>>>>                 if (!(smu->ppt_limits.supported_mask & BIT(i)))
>>>>>                         continue;
>>>>>
>>>>> -             if (restore_mask & BIT(i)) {
>>>>> -                     limit = smu-
>>>>>> user_dpm_profile.ppt_limits[power_source][i];
>>>>> -             } else if (restore_defaults) {
>>>>> -                     range = &smu->ppt_limits.range[power_source][i];
>>>>> +             range = &smu->ppt_limits.range[power_source][i];
>>>>> +             if (range->current_value &&
>>>>> +                 range->current_value != range->default_value)
>>>>> +                     limit = range->current_value;
>>>>> +             else if (restore_defaults)
>>>>>                         limit = range->default_value;
>>>>> -             } else {
>>>>> +             else
>>>>>                         continue;
>>>>> -             }
>>>>>
>>>>>                 ret = smu_set_ppt_limit(smu, i, limit);
>>>>>                 if (ret)
>>>>> @@ -875,6 +870,21 @@ static int smu_early_init(struct amdgpu_ip_block
>>>>> *ip_block)
>>>>>         return smu_init_microcode(smu);
>>>>>    }
>>>>>
>>>>> +static void smu_init_ppt_limits_current(struct smu_context *smu) {
>>>>> +     struct smu_ppt_limit_range *range;
>>>>> +     int i, j;
>>>>> +
>>>>> +     for (i = SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT;
>>>>> i++) {
>>>>> +             for (j = SMU_PPT_LIMIT_PPT0; j < SMU_LIMIT_TYPE_COUNT;
>>>>> j++) {
>>>>> +                     if (!(smu->ppt_limits.supported_mask & BIT(j)))
>>>>> +                             continue;
>>>>> +                     range = &smu->ppt_limits.range[i][j];
>>>>> +                     range->current_value = range->default_value;
>>>>> +             }
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>    static int smu_set_default_dpm_table(struct smu_context *smu)  {
>>>>>         struct amdgpu_device *adev = smu->adev; @@ -1911,6 +1921,9 @@
>>>>> static int smu_smc_hw_setup(struct smu_context *smu)
>>>>>         if (ret)
>>>>>                 dev_err(adev->dev, "Error during wbrf init call\n");
>>>>>
>>>>> +     if (!adev->in_suspend && !amdgpu_reset_in_recovery(adev))
>>>>> +             smu_init_ppt_limits_current(smu);
>>>>> +
>>>>>         return ret;
>>>>>    }
>>>>>
>>>>> @@ -2999,6 +3012,9 @@ int smu_get_ppt_limit(void *handle,
>>>>>         switch (limit_level) {
>>>>>         case SMU_PPT_LIMIT_CURRENT:
>>>>>                 ret = smu_get_asic_ppt_limit(smu, limit_type, limit);
>>>>> +             if (!ret)
>>>>> +                     smu-
>>>>>> ppt_limits.range[power_source][limit_type].current_value =
>>>>> +                             *limit;
>>>>>                 break;
>>>>>         case SMU_PPT_LIMIT_DEFAULT:
>>>>>                 *limit = smu-
>>>>>> ppt_limits.range[power_source][limit_type].default_value;
>>>>> @@ -3061,6 +3077,7 @@ static int smu_set_ppt_limit(void *handle,
>>>>> uint32_t limit_type, uint32_t limit)
>>>>>         ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
>>>>>         if (ret)
>>>>>                 return ret;
>>>>> +     range->current_value = limit;
>>>>>         if (!(smu->user_dpm_profile.flags &
>>>>> SMU_DPM_USER_PROFILE_RESTORE)) {
>>>>>                 smu-
>>>>>> user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
>>>>>
>>>>> smu->user_dpm_profile.ppt_limit_user_mask[power_source]
>>>>> |= diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> index 92658eb3886d..5222b48eba25 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> @@ -229,6 +229,7 @@ enum smu_ppt_limit_level {
>>>>>
>>>>>    struct smu_ppt_limit_range {
>>>>>         uint32_t default_value;
>>>>> +     uint32_t current_value;
>>>>>         uint32_t min;
>>>>>         uint32_t max;
>>>>>         uint32_t od_min;
>>>>> -- 
>>>>> 2.49.0
>>>>
>>
> 

