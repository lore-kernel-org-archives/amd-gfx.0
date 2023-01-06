Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F4C5479D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 10:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D545110E850;
	Fri,  6 Jan 2023 10:01:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93AF10E84E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 10:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGECJFhP6tAvLcETECLEM9o5ZJNtj2QsnDxEObS8SS+V9BjQeTlB3ZZyd3YAxrlYhtmYtJw6EXyH85qpgP3NxM1PW85PksYm6QU+pS/Gqdfkh3R0nUZqs4BpQ51IKnqBFDFFsI1gKf3DnmoPpbYgpzQ3jYZcQ5ozBbkz0Z4kGVgA/zPinSB536lVYG6wtu/pD8Tfvf1ZQ9oGFiTRbfwwy6N9dGO4lErbzmMRQwkZC4yX8up5Y+Rk1nln0/+JRXCOLAcqLbKK06m7GhiJ8TtJznXZ4l4jUsEcmDlhcDH2DHPF/21j/N2oBEPrigzvy15yhT2XUhtjxOrfM5bzOe5cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5u2/DD61OzqToy3l5cL9e8qEEiPpAodzTixeDtkBrE=;
 b=IWuXwCnrI8KLjuWhmk8Ml4GMlZMjdKS4mtOrnmPj4o6D09+UOyUoUXEiXM54NAMvQRfQa94hQM+SHiYh70pHvRmnAktmrc7cw7Qy1svH4pEdK7peo/fmyHjKisYRCU+BDs8ROwgxWzDk37rKTw/OrXb8TBXHP3i/8isxpmNUe2rj77NvP6+7bIMKodI6OrAZLALe8s1NE5384TEXBtaAjbXWVjLngCouh2TgirEtszPz/Y7zr0C+5jv3XDBnkcGT5iUQ9D5WaT+atvTSZ4EKiIVerYSSxLkpIIw+yvGELom20yWwFphi/9p3YLde+eukeNx0AcU/gnYsMl9OOeVrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5u2/DD61OzqToy3l5cL9e8qEEiPpAodzTixeDtkBrE=;
 b=SKmhBww/SEexKWKdHQ6KGxf8J7ZG88UWp+HiTNDU/bQILYhYwYGR87NK01Y6u1SKsVMKRlUChymF6PoMwADyaw0z2gjhgry2AMaLDmtRJh3Hh8rrZ+5ukI+ssCoJ8Pz5XzUalgZZUcQc5wPejO2ExATJr6ZuHfawiU6gvEljWwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 10:01:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 10:01:37 +0000
Message-ID: <0c23d7cc-4985-ac01-72a6-5cc0832ce96b@amd.com>
Date: Fri, 6 Jan 2023 15:31:26 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261939E92BC8DAFF8905653AE4FB9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7474c8-ef28-4c1c-a784-08daefccffc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GcmCJ3yLWpqTO4607ie84lvOLyAkoc58lQWXqHXC0Cz7fOWM0P4X2zTSRuFP8PbgkZ1lg+MxvnH5QIDGHYnP0Ro/Z6Y6T1Vkiw4b4EADZWwvcf912kDZhhSHVEZGlpOqJbo82D0knxUlfKh9CqI1eucEfQYI9HYtIfGagSePXSHE1RqSdKfQHjNAZklFJkqGCur9JeJBMNQhVbxabEW7fhDDMYSaHfixigHO/Hkr1FvL9wFK/q38sV42SZRmjCZiY4jy+oqLFMh2cO1Owdc4oOaga+4mazZ1++MtgEOPIJ5MmYhTCSH7tpjRq6LgmrMvKntbJ3F2YxoSToFeSaUMOqq0e9I3/VK/0ymzZOPWzzvve/1ORfmiUzXvQM2MtvNvaaNuW2+uxhJcgbdgUTq/Zro8GT/3TECTr6sB2hwTHCy284JhKyu4CAY7iaCf3yCl0ocKdeRa/ORPO38rKVSh3ivzfvHga57ed4vnCaV07+r141owaYjasjsGIr4IXp3ZffxHsMhZUMLZjzFZtiVtoi0mPwRwMhHhPr0wBlUsWliDza1V+MAzwiCxlwZQ355WLMa+dHB3Ckoi8p0eFhpyvdbQ4L1YBAPbwKL0lR2Rq9FNJx2xx7pRFmaZ7ljB2aI6AUuali5rxDthKOlDs/K4pmd4uWUtNn97INHidCEdukoc3a3nmQzsFuV+0cgX3dbgxdetWBAMooxoJs25jg/5+msHbNkxGrAVLm0f/Smiog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(6666004)(6512007)(26005)(186003)(31686004)(6486002)(478600001)(2616005)(6506007)(53546011)(110136005)(8676002)(66556008)(4326008)(66946007)(8936002)(41300700001)(66476007)(30864003)(83380400001)(5660300002)(2906002)(38100700002)(86362001)(31696002)(316002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZmTTU5bWZRWXpCbExkWjkzemdoNXBQcnZyNTY3SElsMVFkMDlRSGpZQ2Vo?=
 =?utf-8?B?bjNCa3BkMUh1eVQ2bXQxWW1WMis2aFdoSDlQWHdTMEhEdzVnRE1OWEs4enhH?=
 =?utf-8?B?WGVoM0VtUkh6M1FNdUNXaWFwRzJTc1cvb3ZLUTl2bWtMVU1KTUlaOEFtb0ZH?=
 =?utf-8?B?TWRoUGR2MFE0Ukt6WWlEb3ZTdGgxVUZmVmF1MGM0eFhLVVhnVmxJTnhZMGpl?=
 =?utf-8?B?T28rNm9XT1ZZY0J2V1l4WGFhOXhNaFdVekwrU0tJR3B1UXRyOFcrREJHeDh4?=
 =?utf-8?B?SW40VGkzc1B4eXNuYU9hVnNTaVhxenkwNHlHYVZxenhSbVFmbmQ1U25FSTcr?=
 =?utf-8?B?Vlc5VklGUm5ZNTQySG8xaitnN253YjdLSWcvUnl4SlVDQzVJNVBMS3lzbjdn?=
 =?utf-8?B?V3NTNzZYQ0ZnbFVnNkpESnF4Nm8wWnF2MUg1SHd1NnBOaEFENlZNU2lieXBQ?=
 =?utf-8?B?YmNuVHdXUUVIRU55UmRyeEh6V1NQeDlmMk5MaE4rT25WckpyYWsvQUd2b0E1?=
 =?utf-8?B?Wmw1WGFHblVidzdLZk5yRzJtU2wvQVdRZFUrRDdmRWhBTWpJSC9JdHhBcmt3?=
 =?utf-8?B?S2lhNC9FdjJUeTBneXZtWVVwVGtqUDJrbXVlcFd4TzdtbGN0WEI5NGhYZytY?=
 =?utf-8?B?VUh4REJOWlBsQ1pBSTE1UEhSWXQwNUQ3TEJnbHV1Nm50UWZ5Y3Z2RCtOUFFY?=
 =?utf-8?B?Z1hHVDBMTjliZ0w3cVl5aTNDQURHeGd4eWUva3NhM01ETWVOSFlBL3pKVHBM?=
 =?utf-8?B?ZThJcTZlTzNnaE00dmpleEVmYm5PdzI2WUZ4MXRQQU5pb1U2VWFWTGtaYlp1?=
 =?utf-8?B?Nk9NY1M4c09CbXZVNDFWbTVHTFFjaGswaUNHZ2xGN3drbFltZWpGVDlKTHFv?=
 =?utf-8?B?SUJCRjlWd1pQS0RRZUNmTk96djEwNm5LVnZ1M0I5UzJnQUJacnFTcXVmek1B?=
 =?utf-8?B?MW5zVTR5cHJkY1VtemYrOVlQZExGcE1FQmFSeWdOUFZMRzZrakRsWVMwcUoy?=
 =?utf-8?B?NFJ2elRDWnpBVFhnZ0VkbnNKRWR6VkMrbUxmcHE0R0t0dDhFTXhnQXVyUHJa?=
 =?utf-8?B?a0tiV09EdHMycmdiUU1CN1Z0YnRXVjRwMWRiaUllTFFBb3piOWdEaXk3cm44?=
 =?utf-8?B?b1g0Q2d0Yys3Z0UrUmFUOGdwVWkyNXl2YnZ4RlNUdG1GT0lVSUtkQ0JkeUlP?=
 =?utf-8?B?TlJrOGFueGVpMHpQZmEzaE96Sm85aDdKYURXME9wdVpVeVNhb2VEZGhid284?=
 =?utf-8?B?bWhwNGNvRGpIZytXRHdsajFGdnpySDlFTVRSV2dwVkh5VjJ0bVViTm5GUS8v?=
 =?utf-8?B?WHg5VmtyRzl5dnV0ZHFhY01LNkZ2SVBWM08rNzNJb05yZzA4M2FDWWRyWXVn?=
 =?utf-8?B?SHJyaFNHb3EybjZjakRLQytLL09ZUWVHUEFWZHc2eU5lRkdZa0xpd1FXMUlZ?=
 =?utf-8?B?bzV6NUcxT1U0N3p2NElkMWdjelNFM2FVMERReTlJa0hkekNBaFRhVVlxVUlH?=
 =?utf-8?B?enZsM2M0aUpTb2NTT2ZENkQ3a1QyWFhxb0dZcnJHUkRrdWVXSk1TZ05GSDJY?=
 =?utf-8?B?Z29JVk9EblIvaEZJWUpKTDFtSGdRbG1MOGI5MlFUVVd5ZzhlOGFPYncwWlNp?=
 =?utf-8?B?VTkydnh0UTFWaVlOOVhVWElWTXhIT3AvTWFseC9OWHYyTU80NkxCQ2tPSjZh?=
 =?utf-8?B?M21YcUZYa1c2U2RjaG1jQncybk9qMFYrMDRHbjRzcTZHUHoyS1JlNXFvQW5O?=
 =?utf-8?B?M1JMQWI1bkk0dEU1UXFPM3dvQXJMSTZHdkR0Q0kwSkpiN3hINEx4cEcvQlNO?=
 =?utf-8?B?eXdabnNlZmEwejhEL1pOZG52ckdSNnlSYmwxdEw3WXpQU2hpRUxWZm53Y3Vr?=
 =?utf-8?B?eGNqQUwySURnRnNRbTVOU2xvbS9hUTliZzU4OU90dEhET1hYZTB4RTIzRUh5?=
 =?utf-8?B?dStWMXhjR2JRMjlJRmpSZHc4MXJ2bVBubTROK2szTE1ZRzJ2WUV5T2c3cmUx?=
 =?utf-8?B?YnFneHhjdzJhaDA1M1UvSENzYm5GcDNvMGUzdmtZd3E5TVFqeklnQVh1bTdC?=
 =?utf-8?B?djllM1RLTnJ5QkFPSWVNNEpITTlndzRlS0VhNk9hV3c1U0wycnc2aWpMR3BY?=
 =?utf-8?Q?rHRgmZIDlieWhev0LvwYhzxyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7474c8-ef28-4c1c-a784-08daefccffc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 10:01:37.3828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2b3l70SrAEnMLPEDvcz8qsF8qYZJHb9gd0HpwucHkRjJDpcwQ8I3TvEd3JYMzlF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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



On 1/6/2023 2:14 PM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 6, 2023 11:55 AM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
>> support
>>
>>
>>
>> On 1/6/2023 7:34 AM, Quan, Evan wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Thursday, January 5, 2023 9:58 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>> interfaces support
>>>>
>>>>
>>>>
>>>> On 1/5/2023 8:52 AM, Evan Quan wrote:
>>>>> Make the code more clean and readable with no real logics change.
>>>>>
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200 ++++++++++++++------
>> ---
>>>> ------
>>>>>     1 file changed, 98 insertions(+), 102 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> index fb6a7d45693a..c69db29eea24 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct
>>>> amdgpu_device *adev, struct amdgpu_device_
>>>>>     			       uint32_t mask, enum amdgpu_device_attr_states
>>>> *states)
>>>>>     {
>>>>>     	struct device_attribute *dev_attr = &attr->dev_attr;
>>>>> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>> -	const char *attr_name = dev_attr->attr.name;
>>>>>
>>>>>     	if (!(attr->flags & mask) ||
>>>>>     	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) &
>>>>> adev->pm.sysfs_if_supported))  { @@ -2016,112 +2013,14 @@ static int
>>>> default_attr_update(struct amdgpu_device *adev, struct
>> amdgpu_device_
>>>>>     		return 0;
>>>>>     	}
>>>>>
>>>>> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name, #_name))
>>>>> -
>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
>>>>> -		    gc_ver == IP_VERSION(9, 4, 1) ||
>>>>> -		    gc_ver == IP_VERSION(9, 4, 2))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>> -		if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>>>> -		*states = ATTR_STATE_UNSUPPORTED;
>>>>> -		if (amdgpu_dpm_is_overdrive_supported(adev))
>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 0,
>>>> 1))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>>>>> -		/* PCIe Perf counters won't work on APU nodes */
>>>>> -		if (adev->flags & AMD_IS_APU)
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(unique_id)) {
>>>>> -		switch (gc_ver) {
>>>>> -		case IP_VERSION(9, 0, 1):
>>>>> -		case IP_VERSION(9, 4, 0):
>>>>> -		case IP_VERSION(9, 4, 1):
>>>>> -		case IP_VERSION(9, 4, 2):
>>>>> -		case IP_VERSION(10, 3, 0):
>>>>> -		case IP_VERSION(11, 0, 0):
>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>> -			break;
>>>>> -		default:
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -		}
>>>>> -	} else if (DEVICE_ATTR_IS(pp_features)) {
>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 0,
>>>> 0))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
>>>>> -		if (gc_ver < IP_VERSION(9, 1, 0))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>>>> -		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>>>> -EOPNOTSUPP)
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -		else if (gc_ver == IP_VERSION(10, 3, 0) &&
>>>> amdgpu_sriov_vf(adev))
>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>> -	}
>>>>> -
>>>>> -	switch (gc_ver) {
>>>>> -	case IP_VERSION(9, 4, 1):
>>>>> -	case IP_VERSION(9, 4, 2):
>>>>> -		/* the Mi series card does not support standalone
>>>> mclk/socclk/fclk level setting */
>>>>> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>>>>> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>>>>> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>> -			dev_attr->store = NULL;
>>>>> -		}
>>>>> -		break;
>>>>> -	case IP_VERSION(10, 3, 0):
>>>>> -		if (DEVICE_ATTR_IS(power_dpm_force_performance_level)
>>>> &&
>>>>> -		    amdgpu_sriov_vf(adev)) {
>>>>> -			dev_attr->attr.mode &= ~0222;
>>>>> -			dev_attr->store = NULL;
>>>>> -		}
>>>>> -		break;
>>>>> -	default:
>>>>> -		break;
>>>>> -	}
>>>>> -
>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>> -		/* SMU MP1 does not support dcefclk level setting */
>>>>> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>> -			dev_attr->store = NULL;
>>>>> -		}
>>>>> -	}
>>>>> -
>>>>> -	/* setting should not be allowed from VF if not in one VF mode */
>>>>> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>>>> {
>>>>> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO)) {
>>>>>     		dev_attr->attr.mode &= ~S_IWUGO;
>>>>>     		dev_attr->store = NULL;
>>>>>     	}
>>>>>
>>>>> -#undef DEVICE_ATTR_IS
>>>>> -
>>>>>     	return 0;
>>>>>     }
>>>>>
>>>>> -
>>>>>     static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>>>>>     				     struct amdgpu_device_attr *attr,
>>>>>     				     uint32_t mask, struct list_head *attr_list)
>>>> @@ -3411,6
>>>>> +3310,101 @@ static const struct attribute_group *hwmon_groups[] = {
>>>>>     	NULL
>>>>>     };
>>>>>
>>>>> +static void amdgpu_sysfs_if_support_check(struct amdgpu_device
>>>>> +*adev) {
>>>>> +	uint64_t *sysfs_if_supported = &adev->pm.sysfs_if_supported;
>>>>> +	umode_t *sysfs_if_attr_mode = adev->pm.sysfs_if_attr_mode;
>>>>> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>> +	int i;
>>>>> +
>>>>> +	/* All but those specific ASICs support these */
>>>>> +	*sysfs_if_supported &= ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +	*sysfs_if_supported &=
>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
>>>>> +
>>>>> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
>>>>> +		*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
>>>>> +
>>>>> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
>>>>> +			*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +		}
>>>>> +
>>>>> +		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>> +			*sysfs_if_supported &=
>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>> +	} else {
>>>>> +		switch (gc_ver) {
>>>>> +		case IP_VERSION(9, 4, 0):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +			break;
>>>>> +		case IP_VERSION(9, 4, 1):
>>>>> +		case IP_VERSION(9, 4, 2):
>>>>> +			*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +			/* the Mi series card does not support standalone
>>>> mclk/socclk/fclk level setting */
>>>>> +
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT] &=
>> ~S_IWUGO;
>>>>> +
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT] &=
>> ~S_IWUGO;
>>>>> +
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &=
>> ~S_IWUGO;
>>>>> +			break;
>>>>> +		case IP_VERSION(10, 1, 2):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>> +			break;
>>>>> +		case IP_VERSION(10, 3, 0):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>> +			if (amdgpu_sriov_vf(adev)) {
>>>>> +				*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>> +
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFOR
>>>> MANCE_LEVEL_BIT] &= ~S_IWUGO;
>>>>> +			}
>>>>> +			break;
>>>>> +		case IP_VERSION(10, 3, 1):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>> +			break;
>>>>> +		case IP_VERSION(11, 0, 0):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>> +			break;
>>>>> +		case IP_VERSION(11, 0, 2):
>>>>> +			*sysfs_if_supported |=
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>> +			break;
>>>>> +		default:
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>> +		*sysfs_if_supported &=
>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
>>>>> +
>>>>
>>>> With this change, the IP version based checks need to be moved to
>>>> respective smu_v* checks so that each IP version decides what is
>>>> supported at which level (R/W) rather than consolidating it here.
>>>> Only generic checks like amdgpu_sriov_is_pp_one_vf may be maintained
>> here.
>>>> That way it really helps.
>>> [Quan, Evan] For some of them, they could be moved to respective
>> smu_v* or gfx_v* checks.
>>> But for some of them, it will be difficult. For example, for "mp1_ver <
>> IP_VERSION(10, 0, 0)" or " gc_ver >= IP_VERSION(10, 0, 0)", you need to
>> figure out which asics it refers to first and then apply the same change to
>> every of them. That seems more error prone.
>>> So, my thought is just left these old chunks as they were. And we just need
>> to take care of the future/new asics. How do you think?
>>>
>> My preference is to clean up this as much as possible. Also, you may be able
>> to set some of them generically based on FEAT_DPM bits in
>> swsmu/powerplay.
> I see. But I would expect the future ASICs take the way used in patch3(more straightforward instead of implicit checking for some APIs or DPM features).
> That's also the reason why I do not want to cleanup those old chunks. As I do not expect them to serve for future ASICs.
> Then it's not worth to take the efforts(and risk) to do the cleanup. Thoughts?
> 

It's to make sure consistency. I don't think leaving two options to do 
the same thing is a good idea. Otherwise older will continue and cause 
confusion. Changing to newer one for all is the preferred method and 
handling common things in smu_common/powerplay is better rather than 
having to do everything in individual versions.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +	if (adev->flags & AMD_IS_APU)
>>>>> +		*sysfs_if_supported &=
>>>> ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
>>>>> +
>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>> +
>>>>> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
>>>>> +		*sysfs_if_supported &=
>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
>>>>> +
>>>>> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -
>>>> EOPNOTSUPP)
>>>>> +		*sysfs_if_supported &=
>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>> +
>>>>> +	if (gc_ver >= IP_VERSION(10, 0, 0))
>>>>> +		sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT]
>>>> &= ~S_IWUGO;
>>>>> +
>>>>> +	/* setting should not be allowed from VF if not in one VF mode */
>>>>> +	if (amdgpu_sriov_vf(adev) &&
>>>>> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
>>>>> +		for (i = 0; i <
>>>> AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
>>>>> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>>     int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>>>     {
>>>>>     	int ret;
>>>>> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct
>> amdgpu_device
>>>> *adev)
>>>>>     	if (adev->pm.dpm_enabled == 0)
>>>>>     		return 0;
>>>>>
>>>>> +	amdgpu_sysfs_if_support_check(adev);
>>>>> +
>>>>>     	adev->pm.int_hwmon_dev =
>>>> hwmon_device_register_with_groups(adev->dev,
>>>>>
>>>> DRIVER_NAME, adev,
>>>>>
>>>> hwmon_groups);
