Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76482C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 09:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F0E10F883;
	Mon, 11 Apr 2022 09:47:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F74E10F86A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 09:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E997p5il5PWPFmF87uEChz4qryQX75VdVt8qzIr5OxQ/Gh8/ujfzRckTo4hyoAP7bfOE20MRDBD6ofsq4Xj9miDkjdCxzpBJvd/OKJXluFiHqvwC1nuYib0vCPveEv+HYYHyWT4995TPogi1jMBkZUygs94sIEOZ9ifgee5+kQ8lDcT+D71AyS1xErMIQ49HeW0I21TSHT2taqV7aVMF9H0pBWd2BEKX8SXRvLNpm3Ha75RyF+4AIaby6gi0G9xHMJeDAreECECQlKKKAhjX0UNuHL/rtckQ6p+cjxZjbVtq9uJ+HipEHlbEPFlE+VT3ArWNFsGa0wJgop4LHNzqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vGqJFnUjA0u5iSHymuSe/PhcvZf49/PlZ4dkJrl1Q4=;
 b=WAXPl2Pwxy8N27T6lpZhU8AcK3gaS83IoLRTz2i2ePZOGRI56AqTBw3WZdYsIjGTCLAWJu5mo81XVmQClVHZgy9hxQWE/5tr2NNFH9v59Q+J35DK7/RUjAp8ex6yUKXGreZRPs9IOabTf0OzP68jutfJeTa3btl8C/wGCxu+NYh1kKwU0pCdExWUxpq1mr83liVLt/M5tQ6AyIfVZxku41xIVIazS+AF6yjgKHlJMZeTTcgj1K7bWU7YG0VeldHren2+IOPEdU+XA3NASS9ZOqQ/DsACQ7g5MMWNdFkEUUCrW6AUxOtmbzRb6k2YoAGJT/a6Gkz55MAS+sQo/tkTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vGqJFnUjA0u5iSHymuSe/PhcvZf49/PlZ4dkJrl1Q4=;
 b=DOqWRrG7R4RE195KlVrBrNTSYwwwTQ/sAKnko6A9w4/sqEiUYXL2SxTwK6bEQ+vxutlwyaBj7QONia8pp1t+w/wR6L/yApYuHhiqJnCCmAzPr2XgUyPUIXHt9xQHcCK37msIgENOw9k9N1pC490fxcCztUUuxiNzmFRvSEPGv18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 09:47:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::f110:5c81:79d0:a302%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 09:47:33 +0000
Message-ID: <3efffad4-f15b-bca4-2fd0-adcb6457e264@amd.com>
Date: Mon, 11 Apr 2022 15:17:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220411074732.36486-1-evan.quan@amd.com>
 <23716ed2-95a0-8f23-1f82-9d8f5b02f41e@amd.com>
 <DM6PR12MB2619F6FF2CCE1B0812680504E4EA9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619F6FF2CCE1B0812680504E4EA9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca65b73a-cd59-4f29-4721-08da1ba04d08
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5223745846C261E0A4E19BFF97EA9@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NU6pF1rN6ORYbgeclo0Hd1Pwj+yNBTd3kIeT0yUoFLfMJG6ClJ9uhdAJaUv+/08Cek6q6ojJieas2tdLmqkICaNk9Y2TOEkS7JEMjRvZYARht6GTpLQPAMB5EDxzOnYzv5PMGgzkxJDiWJfoleIYeLO4s1dI2aiG/U6AGk6bNijOCVVVwBfLpibt9I38RdiNyOMgAnMfvDSk1BLxOCLy5G/gsDso3h/HwKK4N/OypRcPAXa+2AV5Z0cO2kkv5bmOjsCaIh6it9CYhvdrsKVo2okAZKbqLQovDzsLyoxATWv61MHcpKJQMRhkNCYrdtm9u087IG0Mh3T2k7vcf3kvjM/Dd8Nf/RizXRVTHrhLR3g3hYAELreU37D3659gYtlCZK/VffOgpcJRbEUdjB4G807FQdMa5hgfJP5oBSr6KzIOnBMx8DyumwUZnC12A+PRSNzaEmwCtAh0q1IpQxJJv8gfWtivb+fibLywPPZqNJQSx8xonwO4vTqta/ZrBGK8ZohvGJQ3BiEwYnmbuo5lBkkLle42QpzPGpzu/Sis8HmBbaiOBDWQbM2dNuey626epFsCxAUV6XV1DN006gyIGPdRy0CC3txHnMvraHE+LRVFyyf61DnJsYNDL+/dllQsWv9FseFa0Kj0pGRerjRpm2dpPQSsz/ffyfpOK7/L+V2141daB8HHoq+vamjC3rAxR4IUTkRRwPwlUpKftUhPeU8SFYAorOc6f+r3b1SEkANYT3er7DJI3UOsJ+n8eoi29cALZ+xln+0H4N8vXKxRUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(2616005)(8936002)(66556008)(2906002)(31696002)(86362001)(38100700002)(6666004)(26005)(4326008)(66476007)(6512007)(186003)(8676002)(83380400001)(6506007)(316002)(110136005)(53546011)(508600001)(54906003)(6486002)(31686004)(36756003)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UngzVWY5UjNkQ2FXb0hueFFIQTZxV1A2VFNSY2lCaks5NnJTam82RElHcDlB?=
 =?utf-8?B?a0dOa0dFTlhZSmZYNWRuNTdIREJlTjBTMkRCcnd0TE1TU3poaWRSZ1JqQjlQ?=
 =?utf-8?B?dlBzTXdHb2EvaGswNVpvdEJuWkF5ZTU0aUtSL055WFB5Q05MNHMwV1BOR1da?=
 =?utf-8?B?dmU3VVgzRnljdVlXdjhDRTN5cDI5YWRtL0twYjIrSkRsTzNPS3N5WDBGKzFz?=
 =?utf-8?B?a0M4NjBSMHpEdGczcXh5ZE43RFYvbE4vb2FmL1lNTkloQXhLWWZXM2p2d0Fk?=
 =?utf-8?B?Yy9XTWU3b2FNNzluN2xzWmdKMDlpVmhUSEJ4L0N3UlpEeXJla0FyTnNmVW5V?=
 =?utf-8?B?R1IzbzUxcDRrN0xPdTRZcm51NEdEckREQ2tRQWtpMSt5R01XNjh5V09pWDR0?=
 =?utf-8?B?NlNRd01kR0ErTEhlaFBCQTJ3Nlk2QkkwV1dBaGxkUkMyaStOVTJsMUEzMVdz?=
 =?utf-8?B?b2J4SG11ZGFGWGdoL2MyN09TcFdQRFNlb2R2UFNvakdmTVE5TFRIMHlLN1Vx?=
 =?utf-8?B?N1FDeGNhYytaTFdpSS9Zb0IrSVVLQTVhaVV1UE5yRDNJaWhNZUt5azA0RHRT?=
 =?utf-8?B?ZUJITmlaTjJSQU9kUVZYN1k5Y2Q1RWlYaWFjMEc4MVZ4SmRxKzBER2x2MzEw?=
 =?utf-8?B?ZnZpSi9vQUtpcTJjMnFuS1ViSUVjTmhjOFVVMndwZVc5TjZGdGVMb21DWGc3?=
 =?utf-8?B?cDJ3QW5ZZHp1WEx2YzlsRmZ6WTVkN3ZtZGRFeitrM3BJdDlrV2o3R3lmZ2Fz?=
 =?utf-8?B?TmMrK3lONnM3UG40U1dlS0U1ZXNhSG56dmNTbVJEUGtVREF6SVdXZVlXbkJ0?=
 =?utf-8?B?ZmhTNCtvM1FhVklDVEZhYzQ5UW4xMk90cHFjUUtIVUxsd3NVVUJpNHF2MkdR?=
 =?utf-8?B?TlovU0NQRVhENnR5TU5XdDQzUms4YUZLdzVBYzFRdDE1RXlJSjY1ZFdtWk9S?=
 =?utf-8?B?K0lFRkJYUmp6MUV6UlJWZW8zRDVYc1ZWYmtQWGxzand6V0JWYUNuQTNPSlhq?=
 =?utf-8?B?c0ZUcnZUOGNHMEplSmtla0FMRVczUTVPQm5HdURJYlhDakQ3VkdHZ0xpUDFr?=
 =?utf-8?B?SmJDKzc1OE5sOTd1MExQQkFTL1U2S0NlYXFuQVFvV1MvRlpmNXFEQ3BvK0Jn?=
 =?utf-8?B?bUlLWFFhMkVYSXdjU29ONjl6ZFRWczVFUmtZYWt2ZDN0TzdCK0QwVGlyR1pI?=
 =?utf-8?B?c004M0tTekI5RlMwU1NBZE15WXZnVnUwS1VIRGZlVVhzU05vOTF2VjZ2eTBh?=
 =?utf-8?B?a3h2OGZVckRicEthZW1yVEFMYWRiYVdkSmdCblo2Z0FoV3VQQzEvWmdlVVlu?=
 =?utf-8?B?ZWpvVW5GQjRsS215N0tMOTFMdHE4Ukp4ZVRoaHdDamVpUEZ1cG5hSFZaNnpY?=
 =?utf-8?B?cGZFRDRxeUQxVFcwelhveTg4czl4bXZ1M3l0WDhXdndTTlJXSkFuVlVaZ3Iy?=
 =?utf-8?B?Qm5UZmFSRzFkOE1PMnFvNVk4bW1kMFcyRWNQZkNNditDYXJjRDU5UGpPMC9S?=
 =?utf-8?B?L2ZvNkZUb0RSR0ZjWXFybFZBdTZGTG5RRG5FSTFGbCtQZzRBYms5NkNkQ2pG?=
 =?utf-8?B?VFNrOTVQWkZBNFFHNnhSUHByUWpTa0JxSHlWcmFNSlYxSkFLMXRXNElVeDVq?=
 =?utf-8?B?MTZteFdWSEp3NEFIck1yR3NkS1NlcTlSeWRjMXR2eU5ZZmQ1TkhsN1N2b3dZ?=
 =?utf-8?B?b2RxL0FIQnYwV2NRc0xKem5MS2lRSUZodlNpbzRTbkFTczNIWW9wdkppTklV?=
 =?utf-8?B?SnVjZ0xTTlk1VWgyOEY0V28vTnJXcFMzcDNhNWxvbnFRazBqOERmZHVwV2d2?=
 =?utf-8?B?YkR2SXFaS1NDaHgrT3RlZFJSdjRrSU9ReVdCZUpUVGVYSUJReTRZdHZpVmlZ?=
 =?utf-8?B?TWpPU0xqdjA3WUhKbU9BVUdOeGxReXNNcWlMeTIyWWR1NmcrMTRYZ1hGNEdl?=
 =?utf-8?B?eXk5KzlIVWxMZVB1K2FaUHVnR3ZSRHYvczFDMUlRSlpIVzc2Znp4SkJsMVp4?=
 =?utf-8?B?UThVaU1VbGN3UnFXbm9DdzVOaStORTAwa3EyVHNJK2xWUStUTEdnMXQrazdS?=
 =?utf-8?B?L041cFBsZXZiZXV6YU1ZOUQ2NmYvRnlST1VXd0M5dzN3eW9rNGVlRWg2NGNT?=
 =?utf-8?B?UWFrcVR6ekNpSk9LV1ZzN3U3MXlKSXd1NURwSFZIVkM4M3ZIY3NMRGhvZ29P?=
 =?utf-8?B?c1BCOTI1SUE1NU9JdlR4OGcwVnZ5TWJzVlBNU3JOQmVzZXg1THFrdm5PSXNC?=
 =?utf-8?B?MDVmQzJrdzBkNkdWSVZlM1NqV29veEhBOG1KNkZkQ3JGK3hDc1JJQ1pFRWxV?=
 =?utf-8?B?UHpFRndDd3FCY3VBNXdvUGJWVDNzZGQydUUzbEVkRjNKV0lUR1Y5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca65b73a-cd59-4f29-4721-08da1ba04d08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 09:47:33.0732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUX2lVmtANUDwPs5eN2O3zyUPbkZIOeZAf20DoufJY0whS5Ub3q1rKPY5/FjVmYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "arthur.marsh@internode.on.net" <arthur.marsh@internode.on.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/11/2022 2:55 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, April 11, 2022 5:05 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
>> arthur.marsh@internode.on.net
>> Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
>>
>>
>>
>> On 4/11/2022 1:17 PM, Evan Quan wrote:
>>> By placing those unrelated code outside of adev->pm.mutex protections
>>> or restructuring the call flow, we can eliminate the deadlock issue.
>>> This comes with no real logics change.
>>>
>>> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in
>>> amdgpu_dpm.c")
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I75de4350d9c2517aba0d6adc12e1bc69430fd800
>>> ---
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39
>> +++++++++++++++++++
>>>    .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>>>    drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>>>    .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>>>    4 files changed, 39 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 5504d81c77b7..72e7b5d40af6 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct
>> amdgpu_device *adev, enum amd_pp_sensors senso
>>>    void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>>>    {
>>>    	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>>> +	int i;
>>>
>>>    	if (!adev->pm.dpm_enabled)
>>>    		return;
>>> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct
>> amdgpu_device *adev)
>>>    	if (!pp_funcs->pm_compute_clocks)
>>>    		return;
>>>
>>> +	if (adev->mode_info.num_crtc)
>>> +		amdgpu_display_bandwidth_update(adev);
>>> +
>>> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> +		struct amdgpu_ring *ring = adev->rings[i];
>>> +		if (ring && ring->sched.ready)
>>> +			amdgpu_fence_wait_empty(ring);
>>> +	}
>>> +
>>>    	mutex_lock(&adev->pm.mutex);
>>>    	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>>>    	mutex_unlock(&adev->pm.mutex);
>>> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct
>> amdgpu_device *adev, bool enable)
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>
>> Bringing family specific code to this layer is not the proper fix. Need to specify
>> what is the deadlock and why can't it be handled in family specific
>> implementation.
> [Quan, Evan] Please check V2. I added some details about this deadlock there.
> For those legacy ASICs, let's make the solution simple and straight forward.
> 

Now it does watermark programming outside of lock. I don't think that is 
the right assumption.

Thanks,
Lijo

> Thanks,
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> +		mutex_lock(&adev->pm.mutex);
>>> +		if (enable) {
>>> +			adev->pm.dpm.uvd_active = true;
>>> +			adev->pm.dpm.state =
>> POWER_STATE_TYPE_INTERNAL_UVD;
>>> +		} else {
>>> +			adev->pm.dpm.uvd_active = false;
>>> +		}
>>> +		mutex_unlock(&adev->pm.mutex);
>>> +
>>> +		amdgpu_dpm_compute_clocks(adev);
>>> +		return;
>>> +	}
>>> +
>>>    	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>> AMD_IP_BLOCK_TYPE_UVD, !enable);
>>>    	if (ret)
>>>    		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n", @@ -453,6
>> +477,21 @@
>>> void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>>>    {
>>>    	int ret = 0;
>>>
>>> +	if (adev->family == AMDGPU_FAMILY_SI) {
>>> +		mutex_lock(&adev->pm.mutex);
>>> +		if (enable) {
>>> +			adev->pm.dpm.vce_active = true;
>>> +			/* XXX select vce level based on ring/task */
>>> +			adev->pm.dpm.vce_level =
>> AMD_VCE_LEVEL_AC_ALL;
>>> +		} else {
>>> +			adev->pm.dpm.vce_active = false;
>>> +		}
>>> +		mutex_unlock(&adev->pm.mutex);
>>> +
>>> +		amdgpu_dpm_compute_clocks(adev);
>>> +		return;
>>> +	}
>>> +
>>>    	ret = amdgpu_dpm_set_powergating_by_smu(adev,
>> AMD_IP_BLOCK_TYPE_VCE, !enable);
>>>    	if (ret)
>>>    		DRM_ERROR("Dpm %s vce failed, ret = %d. \n", diff --git
>>> a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> index 9613c6181c17..d3fe149d8476 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
>>> @@ -1028,16 +1028,6 @@ static int
>> amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>>>    void amdgpu_legacy_dpm_compute_clocks(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -	int i = 0;
>>> -
>>> -	if (adev->mode_info.num_crtc)
>>> -		amdgpu_display_bandwidth_update(adev);
>>> -
>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>> -		if (ring && ring->sched.ready)
>>> -			amdgpu_fence_wait_empty(ring);
>>> -	}
>>>
>>>    	amdgpu_dpm_get_active_displays(adev);
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> index caae54487f9c..633dab14f51c 100644
>>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>>> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct
>> amdgpu_device *adev)
>>>    }
>>>    #endif
>>>
>>> -static int si_set_powergating_by_smu(void *handle,
>>> -				     uint32_t block_type,
>>> -				     bool gate)
>>> -{
>>> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> -
>>> -	switch (block_type) {
>>> -	case AMD_IP_BLOCK_TYPE_UVD:
>>> -		if (!gate) {
>>> -			adev->pm.dpm.uvd_active = true;
>>> -			adev->pm.dpm.state =
>> POWER_STATE_TYPE_INTERNAL_UVD;
>>> -		} else {
>>> -			adev->pm.dpm.uvd_active = false;
>>> -		}
>>> -
>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>> -		break;
>>> -	case AMD_IP_BLOCK_TYPE_VCE:
>>> -		if (!gate) {
>>> -			adev->pm.dpm.vce_active = true;
>>> -			/* XXX select vce level based on ring/task */
>>> -			adev->pm.dpm.vce_level =
>> AMD_VCE_LEVEL_AC_ALL;
>>> -		} else {
>>> -			adev->pm.dpm.vce_active = false;
>>> -		}
>>> -
>>> -		amdgpu_legacy_dpm_compute_clocks(handle);
>>> -		break;
>>> -	default:
>>> -		break;
>>> -	}
>>> -	return 0;
>>> -}
>>> -
>>>    static int si_set_sw_state(struct amdgpu_device *adev)
>>>    {
>>>    	return (amdgpu_si_send_msg_to_smc(adev,
>> PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
>>> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs
>> = {
>>>    	.print_power_state = &si_dpm_print_power_state,
>>>    	.debugfs_print_current_performance_level =
>> &si_dpm_debugfs_print_current_performance_level,
>>>    	.force_performance_level = &si_dpm_force_performance_level,
>>> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>>>    	.vblank_too_short = &si_dpm_vblank_too_short,
>>>    	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>>>    	.get_fan_control_mode = &si_dpm_get_fan_control_mode, diff --
>> git
>>> a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> index dbed72c1e0c6..1eb4e613b27a 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
>>> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void
>> *handle)
>>>    {
>>>    	struct pp_hwmgr *hwmgr = handle;
>>>    	struct amdgpu_device *adev = hwmgr->adev;
>>> -	int i = 0;
>>> -
>>> -	if (adev->mode_info.num_crtc)
>>> -		amdgpu_display_bandwidth_update(adev);
>>> -
>>> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>>> -		struct amdgpu_ring *ring = adev->rings[i];
>>> -		if (ring && ring->sched.ready)
>>> -			amdgpu_fence_wait_empty(ring);
>>> -	}
>>>
>>>    	if (!amdgpu_device_has_dc_support(adev)) {
>>>    		amdgpu_dpm_get_active_displays(adev);
>>>
