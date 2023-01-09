Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A739BC54EBD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 10:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2670910E3D3;
	Mon,  9 Jan 2023 10:52:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1E10E3D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 10:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ0OKWvSobyqm3ZGT9/IshARUtQhVcoAVGf0mPcGXDWlz90VGkoacGu4/hxWaqDdxLbtn2Ua5zIciJySZpOo2oWLzqsUHpYejllnIgOkmQ5s6eQU7U60esDyDMhRjjFh6RbyYK38lzSj4gMVS8e9+lfAPWfHeS8qDattPIRe3vTzkaXmkskp/MddQHiC89eAt+Ek4uZ6mZ+t9h42d1zgxgXLweXkOaLhattPgacjtWpt4yhJca9bTpKL/ympZdpS4H6rzZtMw8LyE8GFD76XJ/wsPIdQJkWnsq9zXeo4epVkh3sufQ226T0NZBe+JEdb/H6shvA2qA0tCHuTDdVPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLMNXK2X0MYzX+jFZ6s7H6xmHdKQtgqEuP+d0d3IjLg=;
 b=Mv4IEgUeAbxwGXjstay/KW+GxgyF6iH6OAyINbZusLpllatI5Mdj992oB4fGJLwnI0sksvFj0EC9T3MBCrSyEqHLCK1KeOZteqaP6+5UdkEdxynGk1cw5iiguTQpBVILAy7dNB8vhBxUY0U8CXLJwj4WZMONqjpkhWKbx+bcv3s5lHfINvoaV18si+fo8di0Dfwuqr+epZeOEtq/anyyJs9dHq4748GRnmUftYYj6BErS5grbGr8g+ClVgckIO6MWpfic316/Dz/B/vk9Q/ApXAlOKMFIbD5VdXsTN3v7u3pX0FyIyJ81EPls6i22XfEpaA1bo4VfKhbGKPvduQ90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLMNXK2X0MYzX+jFZ6s7H6xmHdKQtgqEuP+d0d3IjLg=;
 b=vqt64viRf7vmv/uMY4LD0kLSvxLiDpXs6iFRbgkV4IH7ZZwZ5fqd4DZOUTkMT3cQM4Xo4gdfMVnrA4BXP+w37uyplhg4lknV94Dsbx/EbFvSBWS4Qni0BtOZoPNqlqc9c3wnwgNek/qDzv+Cs9zn0vh61Kwwq5RIlBTUQopWstU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 10:52:08 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 10:52:08 +0000
Message-ID: <cb89d17b-04f5-d566-04b2-51da8fccd50f@amd.com>
Date: Mon, 9 Jan 2023 16:21:57 +0530
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
 <c6464af2-285b-adbc-bcee-d713400a34cd@amd.com>
 <DM6PR12MB261939E92BC8DAFF8905653AE4FB9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <0c23d7cc-4985-ac01-72a6-5cc0832ce96b@amd.com>
 <DM6PR12MB2619CEBFA961B7398709BF07E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <a81fe0f2-b2a2-0013-01d7-1686f5d7c440@amd.com>
 <DM6PR12MB26198B3A9C78CE958CC05190E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26198B3A9C78CE958CC05190E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 63faa728-efa5-4d2c-a858-08daf22f8d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxI4B37p+2nH53mps4W3A+wSHMtbih/cboR9QxTBEfiOkbFhAF9l+EbANeP8NhK6ANz02eobdDUKuj2xie1aI72wgmrKWYeWiodqeiMz9l1ONqFmKVtYs05SE70ndC1Qvm6tw0RlX2pR2b+OtmCIVOzei7+bhvAKyvGfWtQ7ydmTzod5WuHL6hkp0Wf+SnNzYqyz5Ivt8OCpI0bjlePYCqncEWkKIoXHDg2x+ifhmbOk1VBS0n4FNKFS8GuCjbHJN0THzsb5WTXLpzDwhfYvkb/EcF1OKPiV+4hEiJI22rfFB6Wd0ZjXLTz3/f3fZ0GXQ0kI2g7OcH7hBesgbHhYtJ8egClsvVFJOorCzi9Z54F0ezW4cFJzLI45oenVFGjWnFbmP+t+hvRiN9M/K57vVjb7rktknlt/It1nkdo2oEd2A6q9LSf3508AJpNOWWX9o8TxzTuDxHPNi770r7iQV9/Hpa73revMT1KTAboOOK9Xynch2M+hEBZNxHlC4O4ocQ66E9HTJoBa/sjpC0wSVU+B/SgnGm/apmlFf0MpXHrrTSXa1FP5gukAUzV5e0C9kdjhDr3PYbqlyvEAlj+XGu6vicvRkeLZFulxzhYK/rqkWSRFVxzojKmw91ylIYDL/Cv39ecWRlkMBA8q7i4B4d0Sxh2SVK0RDJE6zxL7Q+Jm58++Ej1H6wNYFvONGIgXauX0qhR7mQwuajKLkfwSNCsKMHdcU4bbq7HTC1+VQpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199015)(30864003)(5660300002)(316002)(26005)(6512007)(186003)(6486002)(478600001)(2616005)(41300700001)(31696002)(110136005)(4326008)(66556008)(8676002)(66946007)(66476007)(8936002)(83380400001)(86362001)(36756003)(6666004)(31686004)(53546011)(6506007)(38100700002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm9WY09SWUR0ZG56WXlXcW9rZDJ6bGJZbUltSGlGYlhwL3cxdldJS1hQRVBj?=
 =?utf-8?B?R0owdDdWeXN4ZjkwKzhPNnl4YUdIeENJTmdFVThuYXA5aW9mR1VOdHducWU4?=
 =?utf-8?B?bmdPMndnZmF1cDRqT0c5ZEU3YnVYTnBrN09xZVIraEtRZEM3RFhhTzEzQ2VF?=
 =?utf-8?B?RlFYbVhDaGNrUERLMDVNdkIrejlMSmhZQzhFdU4xdGhpR1BxYmUzZDhCTWQr?=
 =?utf-8?B?amQ5bWlXeXRyRHBwNG9DZ2RFdmVUa1B4cCtGSTVSVmM0bm1DQzV0SEcrRXl5?=
 =?utf-8?B?aUdhN3l6WlVEZGYxTFJRK3MvNmJGWkgwMmhBMWIwN2RoTlJmZGlmMTVSTU5X?=
 =?utf-8?B?UzBsODliZ1VZRDFyenJQRUlNWnlrUHdyUTI1TmdoZWYxSWE4cG9icGFiaGk3?=
 =?utf-8?B?WHZyUGcwVXlZRlBlaWlXLzl6WUNtVUNxSWlzMjlGcDJTWVJjY0YvME9RNkt6?=
 =?utf-8?B?bWdIWElwUmgwQTl4eGhRc0ZweFNmdE5WeTBHamdvWXk5TEJzYlZ1OEYySUY2?=
 =?utf-8?B?NDhIWWxKcmxZQW5GOStBend5bmxnV216YVdDMitCRERXbnQ3aElLa0hEemJy?=
 =?utf-8?B?dFBtWDc5bEtNSkJ3Y1NmaVFQdnNzcUYwZmpSeXJIYzNBTTBLUm1kNDA5SWxN?=
 =?utf-8?B?RVo5eXNkTEYva2VxUU5aN24ybk1DK1RjekhKdjRIZE5sWXF2QjFqOXUvNkJn?=
 =?utf-8?B?QVR0NDY4bVc4MGZiTzExQXQ0clZpSWxVZzFZNVFqNUI4T3JHTktYM1F2ck0y?=
 =?utf-8?B?b0V6cUNYU25nS0F2bWFKbVBzR29XSGttV0N6TkM1TkpVMG9DUUJoYzdIbzkv?=
 =?utf-8?B?dWpCVnhYRGU0cEZBU1Y1cVVIbmIrQ1hSMFN0WnpQQlFOZStyRGtIWnZ5OTZB?=
 =?utf-8?B?c1ZCUXNZaXdtQTZVaFdSWmd1RS9COGdFQXdvUkpRTHBXYUp5YkNOdWpPVU1W?=
 =?utf-8?B?d040MXhTK2NUNGorOTRpcW9pME9JOENjZ2dLRWIzUVR5UHUvUnp5SFRyOUw2?=
 =?utf-8?B?Q3RLeVNjaFNyeldZV2lKSUJYVHJpN0VwS2xKU2UxbUU0ZkNhVHdLNHJaMHhJ?=
 =?utf-8?B?K09FbjcxOHJPZnZkSWw3RGVvbTUrRlMrV1VCN0RsZ2J4SklaQWV3c3NSOWps?=
 =?utf-8?B?UjRiMm1INFZKV0RiZnJYNjNDdE51ZVRBM3N5OFY3V3RMVW56UjBXa0k4SThj?=
 =?utf-8?B?ZXFQcitUMWkwUTh2U2pkT2ZYR1ZiaHdjTFNVMDc3TC9sS0dMdVZZbWJhVS9K?=
 =?utf-8?B?OVlkMnV4Ty9YK2dDb3dWV3ViN2RlRmFXQXVQRmdkV1kyUTNoSVEwYUovVUtJ?=
 =?utf-8?B?b1kxVHpzbzBmbUdwNXd4U09sOE1oT0tiazRwV2tERFdtdVZ5REQ4aTZWOHQ5?=
 =?utf-8?B?aEpQRGREYzBleVRMeTVYck5mL3h5Nk1JemkxckFWQWFnVXJucThhN0d1cW5p?=
 =?utf-8?B?a0J0TUx5d25NS2lpOTgrNkRwLzRIeGtnbEQ3WnVRdENNQlR0dDU0Q08vUlE4?=
 =?utf-8?B?R1RjY2ZnakgwdytFOWtzcmswYVBZd3hEeE9TRncvY0V1WXJpby9pV0UwMlZl?=
 =?utf-8?B?VWRFMlNQK2pmUGVxbHFRdHVveUc4a21mUWpmeUpZdXhEK1Z1RWxxQXMxQ0J4?=
 =?utf-8?B?d3VKM1JoRlp1MDhGYWVBcEI5RDFkQyt2UERzMWdYMzNRamJ2TzE5aE9ISUd4?=
 =?utf-8?B?MEFEY293cXFGWWFHSXF4Q0ErVXA0YmV0ZU9ObUR4aDNDRFlGd28rUzBuS3hS?=
 =?utf-8?B?SGlSUnh2RWtPdW9wYjBVQVFXYzh3UnR1MnBvRUd0aUJsdERrU2F2MGlXY1JG?=
 =?utf-8?B?ekl5QmVuYXhvVVg0TmZEeDBmSUNyS0t1eWJ3V0JsekVtL1hyZE8vclowamFL?=
 =?utf-8?B?dHBJRVo1ZzNxUFNGMVpCQWlMcHNabGtqeGJtN1V3UjJjUEQyM21GcmtNT0o5?=
 =?utf-8?B?T3NUVENkcTVlQ2tGNHpWYWNhWUNJNEcrQXhHZEVENVp3NUZQZ3czVXZaQTN4?=
 =?utf-8?B?a2JmL1dnVSt4YitScHk1K0RsOUp2WTJoeEs5M0lmRzRBUWZNNW9FZ1F2WFB2?=
 =?utf-8?B?Rm9RTUVtNmo5UHB5ZHh3Q3ozVkxzU1M5OGZRdFBhWVhKVFFzMHZ1ZkJLNk9u?=
 =?utf-8?Q?D/17cYUe2/mDT+RiodindRYyJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63faa728-efa5-4d2c-a858-08daf22f8d8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 10:52:08.0633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzNSX9RrDgq2KaQu9Jp7gdhtkO4jxughN9mB48x6ac0PHxK9uykOlRhOKsc8f2c/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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



On 1/9/2023 2:27 PM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, January 9, 2023 11:28 AM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
>> support
>>
>>
>>
>> On 1/9/2023 7:42 AM, Quan, Evan wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, January 6, 2023 6:01 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>> interfaces support
>>>>
>>>>
>>>>
>>>> On 1/6/2023 2:14 PM, Quan, Evan wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Friday, January 6, 2023 11:55 AM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>>>> interfaces support
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/6/2023 7:34 AM, Quan, Evan wrote:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>> Sent: Thursday, January 5, 2023 9:58 PM
>>>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>>>>>> interfaces support
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/5/2023 8:52 AM, Evan Quan wrote:
>>>>>>>>> Make the code more clean and readable with no real logics change.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>>>>> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
>>>>>>>>> ---
>>>>>>>>>       drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200
>> ++++++++++++++--
>>>> ----
>>>>>> ---
>>>>>>>> ------
>>>>>>>>>       1 file changed, 98 insertions(+), 102 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>> index fb6a7d45693a..c69db29eea24 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct
>>>>>>>> amdgpu_device *adev, struct amdgpu_device_
>>>>>>>>>       			       uint32_t mask, enum
>>>> amdgpu_device_attr_states
>>>>>>>> *states)
>>>>>>>>>       {
>>>>>>>>>       	struct device_attribute *dev_attr = &attr->dev_attr;
>>>>>>>>> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>>>> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>>>> -	const char *attr_name = dev_attr->attr.name;
>>>>>>>>>
>>>>>>>>>       	if (!(attr->flags & mask) ||
>>>>>>>>>       	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) &
>>>>>>>>> adev->pm.sysfs_if_supported))  { @@ -2016,112 +2013,14 @@
>> static
>>>>>>>>> adev->int
>>>>>>>> default_attr_update(struct amdgpu_device *adev, struct
>>>>>> amdgpu_device_
>>>>>>>>>       		return 0;
>>>>>>>>>       	}
>>>>>>>>>
>>>>>>>>> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name,
>>>> #_name))
>>>>>>>>> -
>>>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
>>>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 1) ||
>>>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 2))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>>>> -		if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>>>>>>>> -		*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -		if (amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver ==
>>>> IP_VERSION(9, 0,
>>>>>>>> 1))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>>>>>>>>> -		/* PCIe Perf counters won't work on APU nodes */
>>>>>>>>> -		if (adev->flags & AMD_IS_APU)
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(unique_id)) {
>>>>>>>>> -		switch (gc_ver) {
>>>>>>>>> -		case IP_VERSION(9, 0, 1):
>>>>>>>>> -		case IP_VERSION(9, 4, 0):
>>>>>>>>> -		case IP_VERSION(9, 4, 1):
>>>>>>>>> -		case IP_VERSION(9, 4, 2):
>>>>>>>>> -		case IP_VERSION(10, 3, 0):
>>>>>>>>> -		case IP_VERSION(11, 0, 0):
>>>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>>>> -			break;
>>>>>>>>> -		default:
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -		}
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_features)) {
>>>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver <
>>>> IP_VERSION(9, 0,
>>>>>>>> 0))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 1, 0))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>>>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>>>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>>>>>>>> -		if (amdgpu_dpm_get_power_profile_mode(adev,
>>>> NULL) ==
>>>>>>>> -EOPNOTSUPP)
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -		else if (gc_ver == IP_VERSION(10, 3, 0) &&
>>>>>>>> amdgpu_sriov_vf(adev))
>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	switch (gc_ver) {
>>>>>>>>> -	case IP_VERSION(9, 4, 1):
>>>>>>>>> -	case IP_VERSION(9, 4, 2):
>>>>>>>>> -		/* the Mi series card does not support standalone
>>>>>>>> mclk/socclk/fclk level setting */
>>>>>>>>> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>>>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>>>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>> -		}
>>>>>>>>> -		break;
>>>>>>>>> -	case IP_VERSION(10, 3, 0):
>>>>>>>>> -		if
>>>> (DEVICE_ATTR_IS(power_dpm_force_performance_level)
>>>>>>>> &&
>>>>>>>>> -		    amdgpu_sriov_vf(adev)) {
>>>>>>>>> -			dev_attr->attr.mode &= ~0222;
>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>> -		}
>>>>>>>>> -		break;
>>>>>>>>> -	default:
>>>>>>>>> -		break;
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>>>> -		/* SMU MP1 does not support dcefclk level setting */
>>>>>>>>> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
>>>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>> -		}
>>>>>>>>> -	}
>>>>>>>>> -
>>>>>>>>> -	/* setting should not be allowed from VF if not in one VF
>>>> mode */
>>>>>>>>> -	if (amdgpu_sriov_vf(adev)
>>>> && !amdgpu_sriov_is_pp_one_vf(adev))
>>>>>>>> {
>>>>>>>>> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO))
>>>> {
>>>>>>>>>       		dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>>       		dev_attr->store = NULL;
>>>>>>>>>       	}
>>>>>>>>>
>>>>>>>>> -#undef DEVICE_ATTR_IS
>>>>>>>>> -
>>>>>>>>>       	return 0;
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> -
>>>>>>>>>       static int amdgpu_device_attr_create(struct amdgpu_device
>> *adev,
>>>>>>>>>       				     struct amdgpu_device_attr *attr,
>>>>>>>>>       				     uint32_t mask, struct list_head
>>>> *attr_list)
>>>>>>>> @@ -3411,6
>>>>>>>>> +3310,101 @@ static const struct attribute_group
>> *hwmon_groups[]
>>>> =
>>>>>>>>> +{
>>>>>>>>>       	NULL
>>>>>>>>>       };
>>>>>>>>>
>>>>>>>>> +static void amdgpu_sysfs_if_support_check(struct
>> amdgpu_device
>>>>>>>>> +*adev) {
>>>>>>>>> +	uint64_t *sysfs_if_supported = &adev-
>>>>> pm.sysfs_if_supported;
>>>>>>>>> +	umode_t *sysfs_if_attr_mode = adev-
>>>>> pm.sysfs_if_attr_mode;
>>>>>>>>> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>>>> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>>>> +	int i;
>>>>>>>>> +
>>>>>>>>> +	/* All but those specific ASICs support these */
>>>>>>>>> +	*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +	*sysfs_if_supported &=
>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
>>>>>>>>> +
>>>>>>>>> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
>>>>>>>>> +
>>>>>>>>> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +		}
>>>>>>>>> +
>>>>>>>>> +		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>>>> +	} else {
>>>>>>>>> +		switch (gc_ver) {
>>>>>>>>> +		case IP_VERSION(9, 4, 0):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(9, 4, 1):
>>>>>>>>> +		case IP_VERSION(9, 4, 2):
>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +			/* the Mi series card does not support
>>>> standalone
>>>>>>>> mclk/socclk/fclk level setting */
>>>>>>>>> +
>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT]
>> &=
>>>>>> ~S_IWUGO;
>>>>>>>>> +
>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT]
>> &=
>>>>>> ~S_IWUGO;
>>>>>>>>> +
>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &=
>>>>>> ~S_IWUGO;
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(10, 1, 2):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(10, 3, 0):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>> +			if (amdgpu_sriov_vf(adev)) {
>>>>>>>>> +				*sysfs_if_supported &=
>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>>>> +
>>>>>>>>
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFOR
>>>>>>>> MANCE_LEVEL_BIT] &= ~S_IWUGO;
>>>>>>>>> +			}
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(10, 3, 1):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(11, 0, 0):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>> +			break;
>>>>>>>>> +		case IP_VERSION(11, 0, 2):
>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>> +			break;
>>>>>>>>> +		default:
>>>>>>>>> +			break;
>>>>>>>>> +		}
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>> +	if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
>>>>>>>>> +
>>>>>>>>
>>>>>>>> With this change, the IP version based checks need to be moved to
>>>>>>>> respective smu_v* checks so that each IP version decides what is
>>>>>>>> supported at which level (R/W) rather than consolidating it here.
>>>>>>>> Only generic checks like amdgpu_sriov_is_pp_one_vf may be
>>>>>>>> maintained
>>>>>> here.
>>>>>>>> That way it really helps.
>>>>>>> [Quan, Evan] For some of them, they could be moved to respective
>>>>>> smu_v* or gfx_v* checks.
>>>>>>> But for some of them, it will be difficult. For example, for
>>>>>>> "mp1_ver <
>>>>>> IP_VERSION(10, 0, 0)" or " gc_ver >= IP_VERSION(10, 0, 0)", you
>>>>>> need to figure out which asics it refers to first and then apply
>>>>>> the same change to every of them. That seems more error prone.
>>>>>>> So, my thought is just left these old chunks as they were. And we
>>>>>>> just need
>>>>>> to take care of the future/new asics. How do you think?
>>>>>>>
>>>>>> My preference is to clean up this as much as possible. Also, you
>>>>>> may be able to set some of them generically based on FEAT_DPM bits
>>>>>> in swsmu/powerplay.
>>>>> I see. But I would expect the future ASICs take the way used in
>>>> patch3(more straightforward instead of implicit checking for some
>>>> APIs or DPM features).
>>>>> That's also the reason why I do not want to cleanup those old
>>>>> chunks. As I
>>>> do not expect them to serve for future ASICs.
>>>>> Then it's not worth to take the efforts(and risk) to do the cleanup.
>>>> Thoughts?
>>>>>
>>>>
>>>> It's to make sure consistency. I don't think leaving two options to
>>>> do the same thing is a good idea. Otherwise older will continue and cause
>> confusion.
>>>> Changing to newer one for all is the preferred method and handling
>>>> common things in smu_common/powerplay is better rather than having
>> to
>>>> do everything in individual versions.
>>> Those old bunches left in amdgpu_sysfs_if_support_check() can be divided
>> into three types:
>>> 1. those which check for the existence for some API(like
>> amdgpu_dpm_is_overdrive_supported/
>> amdgpu_dpm_get_power_profile_mode). The better choice for them is still
>> left in amdgpu_pm.c I believe.
>>> 2. those which check for some common flags(like sriov or apu). The
>>> better choice for them is also left in amdgpu_pm.c 3. those which check for
>> gc ip version or smu ip version. A better choice for them might be to move to
>> amdgpu_discovery.c I think. But as mentioned before, I do not think it's
>> worth to take the efforts(and risk) to do so.
>>> So, as you can see, I do not think there is anything we can move to
>> smu_common/powerplay part.
>>
>> If you are moving to a different method, think in terms of the new method
>> and not the legacy way. Otherwise, we can continue the legacy method as
>> described above. Keeping two options open is not a choice.
> [Quan, Evan] Sorry, I'm still not persuaded. It's not about legacy way.

What is the reason for anyone not to maintain it in the legacy way for 
new ASICs also. This patch is at best half cooked. Either cook it fully 
or throw it out.

Thanks,
Lijo

> In fact, all the code has been transformed into bitmask related.
> I think your suggestions are about finding a new place for the code above.
> I'm not convinced as i believe they served for legacy asics only and they cannot benefit for future asics.
> So, it's not worth to take efforts to move them to new places and take the risks.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> But if you were talking about splitting some changes in patch3 into
>> smu_common/powerplay part, that will be a different story.
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> BR
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Evan
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>> +	if (adev->flags & AMD_IS_APU)
>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
>>>>>>>>> +
>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>>>> +
>>>>>>>>> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
>>>>>>>>> +
>>>>>>>>> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>>>> -
>>>>>>>> EOPNOTSUPP)
>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>>>> +
>>>>>>>>> +	if (gc_ver >= IP_VERSION(10, 0, 0))
>>>>>>>>> +
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT]
>>>>>>>> &= ~S_IWUGO;
>>>>>>>>> +
>>>>>>>>> +	/* setting should not be allowed from VF if not in one VF
>>>> mode */
>>>>>>>>> +	if (amdgpu_sriov_vf(adev) &&
>>>>>>>>> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
>>>>>>>>> +		for (i = 0; i <
>>>>>>>> AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
>>>>>>>>> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
>>>>>>>>> +	}
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>       int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>>>>>>>       {
>>>>>>>>>       	int ret;
>>>>>>>>> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct
>>>>>> amdgpu_device
>>>>>>>> *adev)
>>>>>>>>>       	if (adev->pm.dpm_enabled == 0)
>>>>>>>>>       		return 0;
>>>>>>>>>
>>>>>>>>> +	amdgpu_sysfs_if_support_check(adev);
>>>>>>>>> +
>>>>>>>>>       	adev->pm.int_hwmon_dev =
>>>>>>>> hwmon_device_register_with_groups(adev->dev,
>>>>>>>>>
>>>>>>>> DRIVER_NAME, adev,
>>>>>>>>>
>>>>>>>> hwmon_groups);
