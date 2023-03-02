Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB4CC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 15:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF8710E10E;
	Thu,  2 Mar 2023 15:36:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DB910E10E
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 15:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOMBWvVRBdQb9qMP/cvg2R2EmPrRawaXh77KCQENySH1V10eT9UCe5BKgp8E/qqxun14+CGqoRqN+6ZWE8QI7LKkgsDoZhNGc2UNMzPpG/gyoaJopH1jh2fnKlM1klgMcWX5YCztMuvI6DzRboS7XTBFZ/ceP4lzhzTTSTMQ7j/6881XNE8kvqWzfSLn1B9789a7XCi7YzqNIObt5fWcGkeH/gwZWeOfv6eqctSuMLhmnGLckiBziAkcVncRqVokiQSg6rwqcZmXGinZLhYs0N/CUDjWnArZn0f5Gn1GqM3iNOqwvnbIHmYhw0s0PFL90WnyRHE1AGE8mfdPEvmgnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuOF9K7Q9yH7xR9V5v6r1rvSdQ7AW2itUY0ACGF41g8=;
 b=CpiphSJ3/N5VrgozNJfhULWpa/S0+6l7XAdIwFRtKAcee+GYoJ/6We9jmxh3LiMNgDTGKnjOOq0l9GiTdf6U0Vw/HYV/rjVrppF34xOxv5qSZ16jtbhDGW4LKF6OsUFqYV36uBiFDOcwqep2TTcF9Ec4LLnR0BggrjkmNRGgQizDqbgXrZc1DbxxzCNxJNbxtKkZichuP4B9C1RVjASvCxB0b21/TdisrIRmxtAjMLKj0ANEvDXi7+BiL4n3YR4WFKJYL0vsv/qZ+QhEJZ5g10OZO50ngB2grXWjjr8nlEl0rxAAqSVOv3yy2kULWnnsyE9yGYcmp9RRaZAvSt5AlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuOF9K7Q9yH7xR9V5v6r1rvSdQ7AW2itUY0ACGF41g8=;
 b=KgOy2kn6wHgECHSZXa8SIS6gECWvNYPAXZknz/JjtWgznP3FziZuWg6FVTfsv3F5qSUR4yD+NiEhSiQy5aXgcEs4y0qWr8JFkqsYVOhKjUcXUrpTGv33Cgk+lrrYylAhbDOGCQfV7PUjS2fr8SncuLryOLcAtYBsQLyj6kd40yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 15:36:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 15:36:05 +0000
Message-ID: <ea9fdc41-f61f-35da-b35e-e710fb621b1e@amd.com>
Date: Thu, 2 Mar 2023 21:05:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
 <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <f72fe6fd-8d41-b99d-fd0c-d893e2d5e158@amd.com>
 <DM6PR12MB261981BCAAB3ECAC82031921E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51446EF4033480FC8BB6F82BF7B29@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB51446EF4033480FC8BB6F82BF7B29@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: eff57040-4600-4237-2fde-08db1b33d5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTO/VwJI1T6wNda1WmEBzmDsM6WjlESwx+/hojbrxtw8v6N/i58RMMm2rbQ9sQMRyZ+ch7B17iprr9ItNA6rVqndpeIUuOqRdXxzX+uSHnoGQ9/67PYuHmsElUgZOatdAZYnLucuHL8wSnMT1iEDmQPARaXBOo8fKG+Wwp7sdCsXqY7Dvx9ssJ2xJM5578BRaix3gSM8uCT0UHhL5sGrUfatm1MJPIpMdusyzrAKZ/a9qIQewVlLMWxBlIth7e38iG7E9nZ97TZMnsqsqgthnQoUzh2ttXPHY/1PegC4+4fYBenf6duQ5ndEgbjnvTY0vS+dNI6uiHDl9n46K2j/zYo4zO55UyNHSdzxa42RcjZ8nlaBB5tWkfLEFkzAD5FmTF175j4LjkzFtGysQX1bsLY1G0XNCvFNIRmhwI8L+0a0GHMuXylRE3lAjAa8vKAAULqEPqSvc6ZzEEhXQw951niLYZsVGwOrJvlye0Bn+1kro7lLm6e6Vsp1D1mxjO94GpWlHIyy497Y55VmzHDB6lJ+QOI1vr4tSFtvtfXoB23867MP88iYBR1IppselBenb2HUo5cC+YMbGnNJWV3oZwcnaGKM87T/PBPYlGlRO2zBayl84AHu0lG0IAKUqPS36F3ssBnK/HOs9Q1KE46F4Kzkyr4+4Gj/GY8r28mOJGxQvfkddZwpRx9fGdlI07OtqK+p7uPVAVT3/F+i89kmVAk0Y/FVtSFTvh16E7JEntw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(36756003)(6666004)(53546011)(6486002)(186003)(26005)(2616005)(6512007)(6506007)(316002)(41300700001)(110136005)(66476007)(66556008)(66946007)(8676002)(2906002)(478600001)(8936002)(5660300002)(38100700002)(31696002)(86362001)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZzTnp2S1FudGxXVVcwU0ZNcHl4K2h0NG5tY285b0R0VlhqTERBYmFJUmhH?=
 =?utf-8?B?MElEYXJzVjQwMFlBWFVPNVZzb00vV3ZaNEsvQ1ZWa1loUVM4WEtxd0tKRFYr?=
 =?utf-8?B?Y1dVQk9CdTBiODN0ZzduZkR0cWMrYnBQckx2RkFPbkJkNnhIOEt0VHJDYUNC?=
 =?utf-8?B?eE9iQTRtNDNsTm1XTEx0ZFZublRQZGdvU09qdnZUZ2pncndwakpQWXFRa1Jv?=
 =?utf-8?B?bVFGRlpkcVFCWmV4d2ZUdVBPUWhVbk5JSkw1d3VoU2VzTkJCUjByUkZQeUpW?=
 =?utf-8?B?VG9nK3V5QkZyYTF0Q2FiaE80T2JmNWxBQzVkUWpkRHRpNDBWcFhvQzJGOS9L?=
 =?utf-8?B?UWRaSEJqcGRMQW5kYXFlUHUrMHNNRnVVQ0xLeEV6a1ZxZFdmYVJ2S1o4VkVx?=
 =?utf-8?B?eDgrcFdVTzNSbHBhNlRiZnlrYnhzYTd2aytOYWsrdW9oK2VvRWc4aTczVDZW?=
 =?utf-8?B?Z3grS3ZhM2UwZ2JwN1Fza1p5eG1GQUEvNTFFZlMvdGJIcTVOWEdvaWJnOGt0?=
 =?utf-8?B?ZGRVMWhZR1pqMFB2QU13UlJGVDlKYXg2RFZhYTFxWWtDL1lwdlg0b2NKbFF0?=
 =?utf-8?B?OEpod3dXYXNFODYwanc5aHhJQ2NsVXBzMFJWaEROb01La0FmekRjV05TT3NY?=
 =?utf-8?B?cTBQSitNV3lYODBQMWw5R2JUcXNDdXN5VHNxYUZEaFBkdDlCZnVLN2xIVEk2?=
 =?utf-8?B?MUhUckpNcmNoR2lZdzdOcnYyNXFyRVlOajFqdzd0YWFjZHFEbFFrNm10aXN1?=
 =?utf-8?B?OThFUVlDMnUzNHgvcHJpU1M2Y2NBNUpqMkl4MkYxamt1TUxjTE05UG9EMFoy?=
 =?utf-8?B?OWFhTmpTOU0wTWlqcW9TanRCV0M3WlJtSjhzUGRyRDBDbjVKQ0Y2eFlsRTdD?=
 =?utf-8?B?aUMwMDlPckYyYjlWQ2NiRjJJQ0M0ek9ZYTNxVTlLOE9xdTQvcVhpSHRYTSt2?=
 =?utf-8?B?SmZtdkpudFV0bGVrS3FWTm51dHovc1FHR0E2aTcvRlNaN0h0a1U1dTN1WkU3?=
 =?utf-8?B?OXNTZTBPRlVJRUNYMW9VWmpuVW85eEZQRTZpV1M0Z29WVlJhdklJZ1BnWXlo?=
 =?utf-8?B?dkdqd29DZStadDlCRk9aazdNY0tEREdQQUMzN0NweTRxR2xxSVFHQkdzb1hz?=
 =?utf-8?B?aEYyZ0tTaXlqa2QrNUxXQ29hQ3JZK08zQ1VwbmtmZ09YMHFTcWpQWExyR0Y0?=
 =?utf-8?B?UVJnV1hyZk83TVRtU0kxMGQ3MFpzMGR1d3BWdEJONk5aOFF0cVJzYm5qVWEy?=
 =?utf-8?B?Z2N2WXRXeDZZMnFzcmVTZ0R4RjJBWkQxQWlWWWF5MjdGNFYwNTRMYTJucDVz?=
 =?utf-8?B?aU5HTVNNY1JBUDFhM1F4SzVPWnJyYlNOT3ZGUk1nd1Z1R3hWczhyYktrR0JY?=
 =?utf-8?B?UUdJaUszZ09jVGpENWZZQ1k3NmkvQW1Pd3E5cUlibWVGVGpiM09Gdzk5TmJB?=
 =?utf-8?B?THMrcjJoTnkzQm1xOVJocHBlR1lib2N5ckk3UTJWL1RHQjNoRVQwL2paRGh5?=
 =?utf-8?B?NTlrd2YzZzNlM3EySWY0dXhxSkI0Y2FXa1lRRWhJa3VVbkkvMlYwWGpSZ1Js?=
 =?utf-8?B?Ujd4dCtwYlpOclFlMkQyK2JocXFyK0FqTE05RU1OTGlwbjV2SmJXREk2L1FO?=
 =?utf-8?B?Mm85V1NKWDRXTFRzSFFrbXhBbHlPaXgxd1dBNEt5eTNGSU1QQzlIcmsvNmFU?=
 =?utf-8?B?VTVUUGsxSnZwWmtLN1ZBOFpUeXhWU1NYZGwxRlNjaG9kVWkwWkVsTkN4QmlH?=
 =?utf-8?B?NnpaNHFITTVrT1I2ZUJ0MU5vM2o4eHNRdUFpQUkwZG14VCtxUU9HdVNYakZK?=
 =?utf-8?B?Q01NVXlRWldhcUJvNG9lNFNkUEhXWjB2MjhhODgwbjhsWjV3SGFjOVArMzZa?=
 =?utf-8?B?N3dsYnEzalZzeHovTVJMYncxaktCcmM1UGtWMFI1Rm1KTzRMOEh1Q0R0ZDcw?=
 =?utf-8?B?L3ovRGhZaEcvd1hSd05KT1g2bDgrUUo4OEhiVjR3anJncDJVVVBzcjhPNy82?=
 =?utf-8?B?N2ZpZXBIRHo5RnovNFZSTy9QSW1FVDVFUHNXSmFURkVOOVJuL0IzNUJkWGYw?=
 =?utf-8?B?VVBYT2lzWm9QS2k4aE5jR3J4Yk5wNGtJdHdWUkZJZVBMM1U4bUR4anF1LytU?=
 =?utf-8?Q?GKvr2BcIwvHk4mJfsp0nm81zs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff57040-4600-4237-2fde-08db1b33d5c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 15:36:05.1077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q15Jkm2fumzNBzOzCVq38+ZEz/mCHM12KB8ZTgWgSR5AXR2FFHO8lPiiA+/0zmoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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



On 3/2/2023 8:56 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Thursday, March 2, 2023 4:31 AM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver
>> reloading scenario
>>
>> [AMD Official Use Only - General]
>>
>>
>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, March 2, 2023 5:21 PM
>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver
>>> reloading scenario
>>>
>>>
>>>
>>> On 3/2/2023 2:43 PM, Quan, Evan wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Thursday, March 2, 2023 4:28 PM
>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver
>>>>> reloading scenario
>>>>>
>>>>>
>>>>>
>>>>> On 3/2/2023 12:28 PM, Evan Quan wrote:
>>>>>> Gpu reset might be needed during driver reloading. To guard
>>>>>> that(gpu
>>>>>> reset) work, df cstate needs to be disabled properly.
>>>>>>
>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>> Change-Id: I5c074c265c0b08a67b6934ae1ad9aa3fed245461
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>>>>>>     1 file changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 51bbeaa1f311..3c854461ef32 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -2816,6 +2816,15 @@ static int
>>>>>> amdgpu_device_ip_fini_early(struct
>>>>> amdgpu_device *adev)
>>>>>>     	amdgpu_device_set_pg_state(adev,
>> AMD_PG_STATE_UNGATE);
>>>>>>     	amdgpu_device_set_cg_state(adev,
>> AMD_CG_STATE_UNGATE);
>>>>>>
>>>>>> +	/*
>>>>>> +	 * Get df cstate disabled properly on driver unloading.
>>>>>> +	 * Since on the succeeding driver reloading, gpu reset might
>>>>>> +	 * be required. And cstate disabled is a prerequisite for
>>>>>> +	 * that(gpu reset).
>>>>>> +	 */
>>>>>> +	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>>>>>> +		dev_warn(adev->dev, "Failed to disallow df cstate");
>>>>>> +
>>>>>
>>>>> This looks more like a firmware bug. Driver sends the Unload
>>>>> message to
>>> FW.
>>>>> In that case FW should disable all features including C-state.
>>>> Driver does not send the Unload message. We want PMFM alive and
>>>> ready
>>> for handling possible gpu reset on reloading.
>>>>
>>>
>>> Actually, soc21_need_reset_on_init code itself has a bug. PSP won't
>>> get unloaded by default on ring destruction. Even if PSP stops, it
>>> could just keep the heartbeat value as non-zero (just that it won't
>> increment).
>>>
>>> Probably, that needs to be fixed first rather than keeping PMFW alive
>>> for a reset.
>> As I remembered, the change(asic reset during reloading) seemed
>> introduced to address some sriov issues.
>> @Deucher, Alexander might share more backgrounds about this.
>> To be honest, I'm not a fan of this(perform asic reset during reloading).
> 
> I'm open to doing it a better way.  We did it for two reasons:
> 1. often times the device was left in a weird state after the driver unload/VM killed. Etc.  We needed a way to put the device into a known good state so the driver could re-initialize it.  Plus, IIRC, on some of the older ASICS, once the SMU or PSP firmware was loaded, there was no way to reload it without a reset so you needed one anyway.  This is largely why we have to reset for S4 as well.
> 2. Some large servers didn't power off PCI devices on reboots to save time.  This left the devices with whatever state they had before the system was rebooted which led to driver initialization problems on subsequent boots because the device was in an unknown state.
> 
> If there is a better way to handle these situations, I'm all for it.
> 

Are those cases valid still? We have this for GFX9 - reset done only for 
pass through. And some of the GFX9 ASICs are used in large servers.

         /* Just return false for soc15 GPUs.  Reset does not seem to
          * be necessary.
          */
         if (!amdgpu_passthrough(adev))
                 return false;

Thanks,
Lijo

> Alex
> 
> 
>>
>> Evan
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> BR
>>>> Evan
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>>     	amdgpu_amdkfd_suspend(adev, false);
>>>>>>
>>>>>>     	/* Workaroud for ASICs need to disable SMC first */
