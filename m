Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC00EC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 08:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DBB10E66B;
	Thu, 13 Oct 2022 08:39:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F1110E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 08:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV5I0y2h7mPynwk+fFFg8Kez9YsMZCaMVc+qmeOzQNiySbw6EdyFdPlLGDUNYZMFILMIYUkOLruY2ruUMPsa1UcrYJVIlelMCZSZuNUeShNCeqOfsUIYrLJOfMwuDxhWMdm3r3pCQW227Gv1B3zqAyTlUFRz/07GTJWdy0RApI3yNhFYS+VDGe18JNIJUSEtfg6cW3zroYI8fvg0oYQ+jKW4qP8mNNT2ueA4kcS1XXWICxWbMitCS90wlz+C6/1w4UZojk6H2MXR81PLp+OZWlLsT1YETIIJXRNBJnYPzLv96w2i/McBRLGh1ZxQDOCyGMfKgqSIFjN25YRe/b6DfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ones6RBLgWlGgWDSVVA1UdH7PA0DQWeIH6GQp5N32+g=;
 b=d0imUndxcFokcEoGkvPdH8YoJfTKVCDwAdbSSal+XuOidKE8rVgMNKC7Ag0jXJMnd7OJ48mlRi185ElKkoeg6DLzlh5ApLI7YDXFfX4DzZMuS9rEH020VoAG7P9uosp2YcKJEr90koiIDgz3AD98OQKk3HOjsl1NZT+3kXqHPU5X6AmlCMcUe6OlU2DoVBVQya9OnPI1+h7d3S8BVMk85sQWJqlsSShRkwQY2fjr06ZjcgSXhD7nGIzLfR0rqxdH2Zi8s9zpNB+N1jXvBYmzv5nJ9f2Jx+hhccoY0ea3pIZpXus9KFVcq8Zu5iuW7akoqkTqUaiXqlRvbApScmlISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ones6RBLgWlGgWDSVVA1UdH7PA0DQWeIH6GQp5N32+g=;
 b=vs7lQcUcQDpnMzayWp7694Kfiv4qpp9lyV7suL7BvtaZFC/RGc6lhyoElR5YjT9NIJjv50I85I4e1hza8B2Vrq6sOPpxl3ZBBJS0SiBTr4Kbhe93OYD5PQr85B/IRi1ka4Wt/tj8LJYubEUeC8z0K8pOmXfaDCIjTQiSnwtYasQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 13 Oct
 2022 08:39:33 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821%6]) with mapi id 15.20.5676.030; Thu, 13 Oct 2022
 08:39:33 +0000
Message-ID: <d260fe40-7001-84eb-36b3-4687edeba1c1@amd.com>
Date: Thu, 13 Oct 2022 14:09:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu reset
 scenario
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221013013141.75369-1-evan.quan@amd.com>
 <20221013013141.75369-3-evan.quan@amd.com>
 <b0888073-7636-bc8e-11df-eb6b32c0e8ac@amd.com>
 <DM6PR12MB26198A696F4DBFE65C8067C0E4259@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26198A696F4DBFE65C8067C0E4259@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5186ce-356d-49aa-2b68-08daacf673de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hgC8XryHL3n3f4hffh4cpibQDQWREiJDz+OoJ7Vtq59Ucjxse4R7UfAEuJwo1jVaVDd0BtUO6wiyX57c6ZNUdmUP1JFn6tzhRGxt3SBXmWQJv5Mu272sh+/6BuDEMCtE6nffq+4tNeDL8WVHV1ph3dpiLL/neQ3XhUb4GIdj3sO0HbB7cTD45JFAVo/3wj3zkSN49FKXl0sOCzFxgQTk5LFUpJ/aI28QbnFEjvgN2sSuhYVWf3wKN1kc9UYzz65xex46iWhwunw5vDolf+Yj82LFJ+BUcXoAOxSFDJddEhQ5ZWvtCixuv/O98F3C0LfUlzY2W+J0DFoB1gfqUU9g4w/cfLZl4EIuDyhmu49gNY+CVJnC1ctf4m44DwHHGHqIv+MbyKryLF+ADqaBMxZdEaTr5bs+abgfSEyqfy/jCcIHLL+hvb53jY41QagEZmVVT7BKc57r/A7SxodKPKasvWh5UBV8JT5CkwyUsyRZZtLlLJfR+QIRspLY+dKZqPw+b3+36NHXbSE5KSBzEj9OCpvo3X+MGSCE0s12cm0G2/F91fdQJPcTefqlnhqXWBFffY9wPPnBFOkpSAkREpVYTJ39kDCi9tTdvF/I2YQJMLVRkCXBg6c9p/+rE2sUBA0AyXnnAZXrQfXIRXMQvpYrK7STBZGr0Lr0WF35FW7ifU6Ndq1QCdlxH076zWImm+nP7XoZ4Omi/cSksSoVolOVgoOxbMYSq0sa8HE/p5STJKgHlcGQqvRAwkqtCVg5iTK2Aj+p15uslY9RxyqbUBPK//h6u31z9wLjpXG42Om6h8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(54906003)(6512007)(6506007)(8936002)(8676002)(36756003)(2616005)(26005)(5660300002)(53546011)(6486002)(478600001)(4326008)(83380400001)(66476007)(66946007)(110136005)(86362001)(2906002)(31686004)(186003)(41300700001)(316002)(38100700002)(66556008)(6666004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk4rWC9SME9IUFVWUHRCK1pXSzJyYXRLNHAxem5KTnZvTEI3bUJ1azF1Q2ZH?=
 =?utf-8?B?YTNtMDFlMXJPTjBGTVZWeGoxU2V6YzVIWFNPSXdLVGJVWkxzR2FTNTBQY3Yy?=
 =?utf-8?B?WnpGaUlrWE05b2UwT1RFbVZQWEZ5V1VNRTJ3TGZmWThVSCtCSVA5YXd1Wnha?=
 =?utf-8?B?MmJSUTJ5eVVBM0lXa3ZaanpSczNTRGlsdUtmYXNFK3RzRWFQcWJrVFdYaXpM?=
 =?utf-8?B?OXk1Y1NuTnNFK2JvUmZ3M0JaNUpnWm1Jc2w5eDJ5TFE3QXBSbGdPOVlaQi9P?=
 =?utf-8?B?UnluWHBPZnA1R2pHNk1OTG15bXB2K0pWV3RGWDlaMGxDaEpSYklFUDR6aTk4?=
 =?utf-8?B?cTFDdHUxY000SSt3clM2R1puZlpBamhyRXFVMjJEZldNK1graUYrd0haejVj?=
 =?utf-8?B?Z2tNTU9QcytRUWpWclI3RWcxR0FtOUxKQnNoL1lxTjc5bmlWOGlSQlJZQVY1?=
 =?utf-8?B?dTQrYmZiY1NOMDlTVlc3MEJWaUw2d2QvbGxEL0xtSzh0ODFPczJqcUlZZmNh?=
 =?utf-8?B?dXNiK0hMd3VXaFhsWGlUejhYeWd4UjAyem82clFZc1p4NmpiajduR1c5YlA0?=
 =?utf-8?B?Qzkyajg1NE1LZTdObUs3SFpMNFRQY1BGWFJWaHBNRENlNjQxTUFWcjRXNTRP?=
 =?utf-8?B?SnJkS0pDMy91dFhOOXcrY2JzZnc0VFpEaFJNcFEzblg5Q09OanRWSTFoamlj?=
 =?utf-8?B?T1dZbUZKK3Z1RmNnaDV0Y1FJMzhLM0E4b2NCV3hqc2ZNWjNsSzlOY09VY1hH?=
 =?utf-8?B?WTFzc2YwY0VWOHVsb1J1VjdFdTBYdzZiQkdBNndKMUF1ei93YldhWjhiRXhX?=
 =?utf-8?B?VTFEV1JGVTAzNUI3ZVV6MVVqeFp1ckF1TWEvdnFIMVlCRElnMStIaGhBbGV3?=
 =?utf-8?B?eDZxSTJFWHo5VmF4NUNMUy92ZlFXZldWRjJwNGN6K2tOcUZZYXBBNlpMd3ZL?=
 =?utf-8?B?M2hacGFkMTU5LzBNOGNKRjJDN01VSnJRMXA3SFBrWmd6aDdsY29SbEJzc1dm?=
 =?utf-8?B?eTNsczRPd3VWRExrV2ZselVYRW1NQmdGcU5uMXJtbzBpeks5RXV5UmRlS3pM?=
 =?utf-8?B?akhFQ2xTYnk2cW4vVWpHNXl0YmlPbGJmMUtTUTc2K2F2NVlLcnU3SmZlYWZ0?=
 =?utf-8?B?SGNlZCtNT1YwWURRbjVMeDlsdHg3ckpzSUNOeXJIWHhjWXlmYzBhL3kwTVUy?=
 =?utf-8?B?eWNGait6VGFxdVNWdWoyR3hFYUplbVprU3JBUkg4SzlMeGF1UkJsWGVySDNF?=
 =?utf-8?B?dXVxQS9ZRUFWOU1jMDQ4azF3SW1IZzRILzR5M00xOGswZUV5aWdOSkJObmRQ?=
 =?utf-8?B?T0hTM3FkM254SzhlcnFRV3lmaWlrT2hjalV5Qm9DdVlabWwxbXJWUUpIL3RG?=
 =?utf-8?B?WE1BZVhjZ1g0ZGlNNXZHVVVqOVloZzQrTW5SM0NmakZkMGlsejJHZGhaOVBo?=
 =?utf-8?B?MFpES1d0U1RTZ3ZRc01nTTIyaHA2bWpVTXQrNEp1V0VNWGl4WGJ2Wm9jSEE2?=
 =?utf-8?B?QkpGcXNXT0hqWjNjWENqNklBdHZ5bjNrZGM2aWd2NGZ2U0ZabEgveVVaaGFh?=
 =?utf-8?B?by8zQzUycmJwcFJnc3BHV2wxRW5zb0lMVFVacUJXT1l2WVVpNnFPQ21qVDlv?=
 =?utf-8?B?Z3VJekNEbDlKSmQrOE95SFh6aVZKdmp0clE4VHVxdnh2TElOMXJOaXk5eEx6?=
 =?utf-8?B?UG8rcDB0dVU2b09VSmRPc3g4NDBkZlY2UUh6ZXN6MXJRdldLMUFaTjZyTXMv?=
 =?utf-8?B?c0dFMktMb3BWQ0tPcDYyendGNGl4dTVzZjlxdy9tWnJyT1hFWG5leEl2bjFG?=
 =?utf-8?B?dUFZdzAvd1FabUNMTi9BZ2dzRmdvNGtJVWtxMHRBY0grQ1FrN0xMcmh3ckdJ?=
 =?utf-8?B?TTNnS2pEUHdudzNYak9WVitmZXgvcHNyNVc1L0VwZXpIOXlDTGNkU0dIbTh6?=
 =?utf-8?B?TGdjWEtDNmNpOUZxeElUNm5TR210RlN6ZFlTR3kvU3BUOGJ1Q3Z1UkRudVY2?=
 =?utf-8?B?WUxaR0pFYzd6YVJyVUxKQmFRdk0zVHpJVXZFTk8zVERUN0ozVUdzb0NVSHU5?=
 =?utf-8?B?dmFYd0hGVHFUOGNuV3R5WDhXLzVDOFVkbDlEaTl3NllJZFlIOFNqQkYrK1BL?=
 =?utf-8?Q?V0QxEgNQ9TraNSzkSVyfcVuo/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5186ce-356d-49aa-2b68-08daacf673de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 08:39:33.5655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETDOKUWtCiBeSR8SgtywNo/ai6q0esX6C3cG9YDKzeg4r0jeCeEMtWV33DvnAXtp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/13/2022 10:56 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, October 13, 2022 12:14 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>
>> Subject: Re: [PATCH V3 3/3] drm/amd/pm: disable cstate feature for gpu
>> reset scenario
>>
>>
>>
>> On 10/13/2022 7:01 AM, Evan Quan wrote:
>>> Suggested by PMFW team and same as what did for gfxoff feature.
>>> This can address some Mode1Reset failures observed on SMU13.0.0.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Change-Id: Ieb4e204c49abd405b1dce559c2ff75bb3887b6f9
>>> --
>>> v1->v2:
>>>     - revise the code comments(Alex)
>>>     - limit this to SMU13.0.0 and 13.0.7
>>> v2->v3:
>>>     - make this happen before display suspending
>>
>> A better thing would be do
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 8 ++++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 7 +++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 7 +++++++
>>>    3 files changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ab8f970b2849..874bf623f394 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2928,6 +2928,14 @@ static int
>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>    	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>    	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>
>>> +	/*
>>> +	 * Per PMFW team's suggestion, driver needs to handle gfxoff
>>> +	 * and df cstate features disablement for gpu reset(e.g. Mode1Reset)
>>> +	 * scenario. Add the missing df cstate disablement here.
>>> +	 */
>>> +	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>>> +		dev_warn(adev->dev, "Failed to disallow df cstate");
>>> +
>>
>> If it's only related to display, you could move this right after below line so that
>> headless systems don't need to take care of this. That will avoid any special
>> handling needed for Aldebaran/Arcuturus also.
> [Quan, Evan] Not quite sure. I know df cstate affects DAL a lot(MALL related features).
> But I'm not sure whether there is other clients/IPs which are affected by df cstate.
> I want this(cstate disablement) performed before all 'consumers'.
>

Thanks for the clarification.

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> BR
> Evan
>>
>>                  if (adev->ip_blocks[i].version->type !=
>> AMD_IP_BLOCK_TYPE_DCE)
>>                           continue;
>>
>> Thanks,
>> Lijo
>>
>>>    	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>>    		if (!adev->ip_blocks[i].status.valid)
>>>    			continue;
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> index 445005571f76..7d34f40460eb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>>> @@ -2245,6 +2245,13 @@ static int arcturus_set_df_cstate(struct
>> smu_context *smu,
>>>    	uint32_t smu_version;
>>>    	int ret;
>>>
>>> +	/*
>>> +	 * Arcturus does not need the cstate disablement
>>> +	 * prerequisite for gpu reset.
>>> +	 */
>>> +	if (amdgpu_in_reset(adev) || adev->in_suspend)
>>> +		return 0;
>>> +
>>>    	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>>>    	if (ret) {
>>>    		dev_err(smu->adev->dev, "Failed to get smu version!\n");
>> diff
>>> --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> index 619aee51b123..93a0f7f6a34e 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>> @@ -1640,6 +1640,13 @@ static bool aldebaran_is_baco_supported(struct
>> smu_context *smu)
>>>    static int aldebaran_set_df_cstate(struct smu_context *smu,
>>>    				   enum pp_df_cstate state)
>>>    {
>>> +	/*
>>> +	 * Aldebaran does not need the cstate disablement
>>> +	 * prerequisite for gpu reset.
>>> +	 */
>>> +	if (amdgpu_in_reset(adev) || adev->in_suspend)
>>> +		return 0;
>>> +
>>>    	return smu_cmn_send_smc_msg_with_param(smu,
>> SMU_MSG_DFCstateControl, state, NULL);
>>>    }
>>>
