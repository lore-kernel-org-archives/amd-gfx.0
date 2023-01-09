Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C8C5479D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jan 2023 03:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C5710E045;
	Mon,  9 Jan 2023 03:28:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3096E10E045
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jan 2023 03:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxLbIXk4xNvffn4vu3G8UK4EBRhpgLreEg7Q3UITzacNBNZSVl2/e16MEmEHLqVv1VzGiqfcFSkaKE4Z5GGMqWIrA5R7LAo4va8cho9Y7yQDdCf4isk+LWsMeihz/iQL+XKz9C+0rtMcqC2dvRETRO5RX8zjMx5DoZvNd09yHv5VJyfJzO3nnlL09V7Mkugrh5RclRRSGkrX7QaCy9YHI4p/hSyIXHt1ISrrgXEGILpt67PTDSTVUrvvu3WkXI0l63lX7ne541s+66yPwt0aQxN0+VYZijZ8U7OvMbOt5dYPJMHt8iOftEOXbyOjN1n1gL/0Nl7/Uq01HQtAuFblgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRECXvQcV3cqNksJLu4o6oELc99jiUP59s932aT468Y=;
 b=bDshh+T3pE49KDmfJj6QxFeT9JYREx8dtRRP7SboOWLEjGwmRwCK8PkjRWjkbUrP2vkfDRCD/UUK2q90fl/ryXHeMj6gEt2UWWY2SxFZv4t+YxuEYRLejnwgIRdDPQum08/CvDll4SshvZhRfZ8j+n8M9DWjbqDn636cyzroLTrq/+6ALPh5BmvJJ5SdshmOa++1RTeW3pq5oY+p74hUtEkRQo9N6etqLMBVI3gCtyH0Vtkn7If8xVNA9Mg8oK2gnv1TqdtZNNJpZNuuBR9SrnPVnJG2PzKIjM8qu9NtBqKsiLDXg4BOPwElfqm8UrqTdxlDOGpyvXn9pausEm5e1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRECXvQcV3cqNksJLu4o6oELc99jiUP59s932aT468Y=;
 b=1La4UUUN06XTS9nptyQcKN/zyhkHrEpvx7eHsHqdWX5KEWg5Na1MXNjmpHS2tv1SiqmYhllg3qmxJlhGHCJc3TbuGoQ/f5I8R/shseJvdbRs8nGnRh1ujZ8V2dduASrGsydA/RoFZImhfRIdlX/e1JBSA2R2EoOSyzoa6VKKdDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 03:28:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 03:28:36 +0000
Message-ID: <a81fe0f2-b2a2-0013-01d7-1686f5d7c440@amd.com>
Date: Mon, 9 Jan 2023 08:58:26 +0530
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
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619CEBFA961B7398709BF07E4FE9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::11) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dc286d-3220-4131-196e-08daf1f197b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXR3EF+FXaZaccr5LH11YzTSSW2JP5rgVd+Ykp6OZgcO7Dk0Qz7GrhlSIOg3gzt/6sG49JlXbb/x5VE1AMYa7YLqf53lMRU39Oixs6KjIs19PV7WrxhpdBrK/SzUK1lfZoTeJa3DqDVCWNSQAEMqcktCFP49+RRyYpDHOtrekGqqgL6RdYnD5He8vSnErMO+DYBzvPf+sw8NMNaV/YuAMIvpP/UOe069cbpfHyP4rrHqCPXpeR1hV0nKRskAikunBL86PqIsQc9aC1n6MYdllmwTRHSPPWpTje3Wi3Oa+S7sRPOYRJuWObKoyfnJarWPJ/kdpNTurNj1+FS809OXqrpKhMNyinuzxeh6NVPci/9VPOXkB923+LVbLsz/QZc3GEpD0gaqFaqVVqRlxskAquVmOgV2KzFBnxWD9gtrU06zRGj4odyx0Pjf8s7cdmckvdPacqrSkjAndmFZtzTnK8thmKFWnmFgiBTJkZ67NEKYIGt1dwklk2nm9GVKGY2hOZbHIY9KnBNm8u24hriAmFEdlDGyiI1/ntJPxq7eQxHuMFKFWkxNQXGkk2iD/Kci48Ny1IqvKmjvAexGKblIB84ujpS+nHSAcpxUlxPJ8iZUBddVD86Tp9ZbhB1+2eYdPWfrrEagwxo87sT4o/DCF5hENulCfoYI+xH0Klg4IHXjMuPaL8XHQc/BtikuOKxzYn6oVv7JmbZxNAyjHP08Xsnz41XaEtKuk0+uCYyC8wA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(41300700001)(110136005)(2616005)(316002)(4326008)(36756003)(66946007)(66476007)(66556008)(8676002)(8936002)(86362001)(31696002)(38100700002)(5660300002)(83380400001)(30864003)(2906002)(6506007)(53546011)(31686004)(6486002)(6666004)(186003)(6512007)(26005)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDd5REEwT0RyWWI0UFdXUWdJa0duTlgzRHpONVdZS0piMHE4RytkYXVyRVhi?=
 =?utf-8?B?dlRNcVZrMjIrWk9MRGlpVzNrYk5MYmRBeVZyZE9Gb3Q2YWJodWQyOVFzajBa?=
 =?utf-8?B?YVZsZzlxZTVaaHg5ei9SZHlSVjgxQkpna2pXQ3ZQeVc1S3BqM0R1MnZYSDNI?=
 =?utf-8?B?UVd1U0tLUWg1NTVUMVhVekJSa0d2bFVQMTVQdEJBYlNtaExmaGdZeUx4U2NN?=
 =?utf-8?B?RnpTNW9wUnpETnB5cER0QVZCNFNZa3FEM21OSWxtT1FleXNONjhhNWlpcHlx?=
 =?utf-8?B?QTc2eUJVWGdYSGx1RU51ZFZ3Z2FLd0oyMEI4VkNZSEJNdDBJeENka3p3RXda?=
 =?utf-8?B?TzhLUjAyU25YL0NwcDVXbXZhS2g3cmVEZWo0b3Y2MmF1QnVLRmVrWFJ6SHpG?=
 =?utf-8?B?bHhJMmxETWQ1dWljaGhOZVQyblVUbEJTbHJMSU11c0JoUWJLN1d3aCswbGNi?=
 =?utf-8?B?WkYwelpFNXBibUlpRktBUHNIZ1JnSmtHM2tkNEdHWW40cVlRbGZsUWw0SkZ5?=
 =?utf-8?B?Z1hPbXd6VFphd1dLcWVVZS81UC9jSWEybjJIZHZxU0JlZDhDTzlUOU1mbTNx?=
 =?utf-8?B?MC9DQmJueXFXM2ZsY2lPa2IzTktSdWxqYW9CcnRqUzhiMWZmejYwcXI3RlF3?=
 =?utf-8?B?bWFzMDM3MlJuTWRNdDJjRC9tU1FvRU15L0VyT3ZxYXZCYXVqSHk4akUxWkZa?=
 =?utf-8?B?N25GYTlUbFY0d2luOTVmVEVvRXlkNTFHdUJuWTJDRk9QYk5jaXVIck51Unlu?=
 =?utf-8?B?TDZzL3lPWld2dGhzd1NiOHgxTklYd0RTN2V5dHBZZFV4TmlVM3I0NUVneHpX?=
 =?utf-8?B?ZzF1QW11dGFqVmlFWW1IZUhDTkdJTjFFaXNkTHphSkJsaWFkT1A2aTdOV09Y?=
 =?utf-8?B?bWtlZGY3S2orSGRwNFdTSE1FbmJ2QW9QaXlJYUhudllOcklNNEFaOVQ0ejJ3?=
 =?utf-8?B?Vm9namJCT2R6SHBkWEo0UFpoa2RhRUhPWmp5VVFaaStTLzIxS0NWRGNzTFdB?=
 =?utf-8?B?R001d0hMd0w2NEpmZE5WUktoVkRzdGp3VHgyMU83UEs4MUw2M2dWTkN6L1hX?=
 =?utf-8?B?VXhkTXRnM2JrdkZSMEswMEVET25TN2FjUG9GbHRISXR2d1Z1dmRNaVVjWkJC?=
 =?utf-8?B?OTUwQVhoejFmcWpTVTJkMW1PTSthdENMcU9TalRjYVVtQTc5a3NqWERobUQ2?=
 =?utf-8?B?djRHU2tqeVloNDI3eUVLak1GQ1VkamJXS3RxWG1oc2hVcGlSUWFQOForcnk4?=
 =?utf-8?B?ZUx3R0dRNmx1ZkFKOHBZeTNpdXVqaEljM1VZaGtMa2xQekZtZk4wbC8rMFll?=
 =?utf-8?B?ZG5ueFVSTHBIVkZ2K2FFRkMwMTJXdko3emFVQTV4bmNtSXlSbUwxUGpCcnY0?=
 =?utf-8?B?dmxFa2RBQjB2NU42Z08vOVkwdmRnbzNXNjBQRndObzhjbG9UOFJKQ0hMQ0wz?=
 =?utf-8?B?dVdWMmlMSjhzMmVlN2Y3UE1tYmpmVVo3U1cxeEwvTUlGU2p1QnRVYnpJU1N6?=
 =?utf-8?B?MVkxS1ZzS1pieS9zWXE5Wlhxb2l2SWNOS2xaSHQySVdwbG80OTJ1Tmg0cDRk?=
 =?utf-8?B?VGJheEFBaEJ1MmdZaXNQNFRzamxBU3FmaThrL09SbWYvZmU3RktrSkxScGp2?=
 =?utf-8?B?dEMrSFQ4a2ZGblpvTVNvWlRRakdtSW1Ca1JpL3JmMGNJOWpQamdSNC82bFNM?=
 =?utf-8?B?TW5RU3VQYitnUVRZUGZYcXNKZG9ydGUvVXRiWi9BVlg5YjBOd0dWdWdYaCtX?=
 =?utf-8?B?VXBPQkpmQU1wTnhkVzZNTjJKMG5rYnlHcUdzOEVVRWE4WWZXUStOcGw3eitF?=
 =?utf-8?B?UCs4dktCUURZbVhPOXZJTjBxZFFYSXJkV3RGOGhvN2p6S3V5RjNNeS9vMDBN?=
 =?utf-8?B?TG1oYnNINmR6Yjhzb1Fpb2JWaGNkMllkNTBVSGxmOCtJSHNKSXd6VlVGcHFi?=
 =?utf-8?B?cnFBdkpTeCtkUnAzYXRGWkRyeDZWeDdPQkI3NVpUbFRObEZqRkxMc3huNHMy?=
 =?utf-8?B?Z0N3V3ZRWEU0ZWp3cFJzbC9OdzdRU3NGb3dkUU0rOFE4bzc3Vk9tR29ucHVN?=
 =?utf-8?B?SkVpanVmZG9qUXRMUnFIR01SK2lRak5wWkFDZmFhVHZGL0ZYNnZtUGJEUksz?=
 =?utf-8?Q?95b7j6UN3WvoNRxxYVmRsHiG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dc286d-3220-4131-196e-08daf1f197b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 03:28:36.5049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3DxMQM2no6AdU0asxN2CWc0TCpUxK3trgOgNQNgNQyFWE9bQ6F0YEGexzykNBJ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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



On 1/9/2023 7:42 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 6, 2023 6:01 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
>> support
>>
>>
>>
>> On 1/6/2023 2:14 PM, Quan, Evan wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, January 6, 2023 11:55 AM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>> interfaces support
>>>>
>>>>
>>>>
>>>> On 1/6/2023 7:34 AM, Quan, Evan wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Thursday, January 5, 2023 9:58 PM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>>>> interfaces support
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/5/2023 8:52 AM, Evan Quan wrote:
>>>>>>> Make the code more clean and readable with no real logics change.
>>>>>>>
>>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>>> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200 ++++++++++++++--
>> ----
>>>> ---
>>>>>> ------
>>>>>>>      1 file changed, 98 insertions(+), 102 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>> index fb6a7d45693a..c69db29eea24 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct
>>>>>> amdgpu_device *adev, struct amdgpu_device_
>>>>>>>      			       uint32_t mask, enum
>> amdgpu_device_attr_states
>>>>>> *states)
>>>>>>>      {
>>>>>>>      	struct device_attribute *dev_attr = &attr->dev_attr;
>>>>>>> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>> -	const char *attr_name = dev_attr->attr.name;
>>>>>>>
>>>>>>>      	if (!(attr->flags & mask) ||
>>>>>>>      	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) &
>>>>>>> adev->pm.sysfs_if_supported))  { @@ -2016,112 +2013,14 @@ static
>>>>>>> adev->int
>>>>>> default_attr_update(struct amdgpu_device *adev, struct
>>>> amdgpu_device_
>>>>>>>      		return 0;
>>>>>>>      	}
>>>>>>>
>>>>>>> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name,
>> #_name))
>>>>>>> -
>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 1) ||
>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 2))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>> -		if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>>>>>> -		*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -		if (amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver ==
>> IP_VERSION(9, 0,
>>>>>> 1))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>>>>>>> -		/* PCIe Perf counters won't work on APU nodes */
>>>>>>> -		if (adev->flags & AMD_IS_APU)
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(unique_id)) {
>>>>>>> -		switch (gc_ver) {
>>>>>>> -		case IP_VERSION(9, 0, 1):
>>>>>>> -		case IP_VERSION(9, 4, 0):
>>>>>>> -		case IP_VERSION(9, 4, 1):
>>>>>>> -		case IP_VERSION(9, 4, 2):
>>>>>>> -		case IP_VERSION(10, 3, 0):
>>>>>>> -		case IP_VERSION(11, 0, 0):
>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>> -			break;
>>>>>>> -		default:
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -		}
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_features)) {
>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver <
>> IP_VERSION(9, 0,
>>>>>> 0))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
>>>>>>> -		if (gc_ver < IP_VERSION(9, 1, 0))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>>>>>> -		if (amdgpu_dpm_get_power_profile_mode(adev,
>> NULL) ==
>>>>>> -EOPNOTSUPP)
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -		else if (gc_ver == IP_VERSION(10, 3, 0) &&
>>>>>> amdgpu_sriov_vf(adev))
>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	switch (gc_ver) {
>>>>>>> -	case IP_VERSION(9, 4, 1):
>>>>>>> -	case IP_VERSION(9, 4, 2):
>>>>>>> -		/* the Mi series card does not support standalone
>>>>>> mclk/socclk/fclk level setting */
>>>>>>> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>> -			dev_attr->store = NULL;
>>>>>>> -		}
>>>>>>> -		break;
>>>>>>> -	case IP_VERSION(10, 3, 0):
>>>>>>> -		if
>> (DEVICE_ATTR_IS(power_dpm_force_performance_level)
>>>>>> &&
>>>>>>> -		    amdgpu_sriov_vf(adev)) {
>>>>>>> -			dev_attr->attr.mode &= ~0222;
>>>>>>> -			dev_attr->store = NULL;
>>>>>>> -		}
>>>>>>> -		break;
>>>>>>> -	default:
>>>>>>> -		break;
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>> -		/* SMU MP1 does not support dcefclk level setting */
>>>>>>> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>> -			dev_attr->store = NULL;
>>>>>>> -		}
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	/* setting should not be allowed from VF if not in one VF
>> mode */
>>>>>>> -	if (amdgpu_sriov_vf(adev)
>> && !amdgpu_sriov_is_pp_one_vf(adev))
>>>>>> {
>>>>>>> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO))
>> {
>>>>>>>      		dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>      		dev_attr->store = NULL;
>>>>>>>      	}
>>>>>>>
>>>>>>> -#undef DEVICE_ATTR_IS
>>>>>>> -
>>>>>>>      	return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> -
>>>>>>>      static int amdgpu_device_attr_create(struct amdgpu_device *adev,
>>>>>>>      				     struct amdgpu_device_attr *attr,
>>>>>>>      				     uint32_t mask, struct list_head
>> *attr_list)
>>>>>> @@ -3411,6
>>>>>>> +3310,101 @@ static const struct attribute_group *hwmon_groups[]
>> =
>>>>>>> +{
>>>>>>>      	NULL
>>>>>>>      };
>>>>>>>
>>>>>>> +static void amdgpu_sysfs_if_support_check(struct amdgpu_device
>>>>>>> +*adev) {
>>>>>>> +	uint64_t *sysfs_if_supported = &adev-
>>> pm.sysfs_if_supported;
>>>>>>> +	umode_t *sysfs_if_attr_mode = adev-
>>> pm.sysfs_if_attr_mode;
>>>>>>> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>> +	int i;
>>>>>>> +
>>>>>>> +	/* All but those specific ASICs support these */
>>>>>>> +	*sysfs_if_supported &=
>> ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +	*sysfs_if_supported &=
>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
>>>>>>> +
>>>>>>> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
>>>>>>> +		*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
>>>>>>> +
>>>>>>> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
>>>>>>> +			*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +		}
>>>>>>> +
>>>>>>> +		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>> +			*sysfs_if_supported &=
>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>> +	} else {
>>>>>>> +		switch (gc_ver) {
>>>>>>> +		case IP_VERSION(9, 4, 0):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(9, 4, 1):
>>>>>>> +		case IP_VERSION(9, 4, 2):
>>>>>>> +			*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +			/* the Mi series card does not support
>> standalone
>>>>>> mclk/socclk/fclk level setting */
>>>>>>> +
>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT] &=
>>>> ~S_IWUGO;
>>>>>>> +
>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT] &=
>>>> ~S_IWUGO;
>>>>>>> +
>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &=
>>>> ~S_IWUGO;
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(10, 1, 2):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(10, 3, 0):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>> +			if (amdgpu_sriov_vf(adev)) {
>>>>>>> +				*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>> +
>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFOR
>>>>>> MANCE_LEVEL_BIT] &= ~S_IWUGO;
>>>>>>> +			}
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(10, 3, 1):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(11, 0, 0):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>> +			break;
>>>>>>> +		case IP_VERSION(11, 0, 2):
>>>>>>> +			*sysfs_if_supported |=
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>> +			break;
>>>>>>> +		default:
>>>>>>> +			break;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>> +		*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
>>>>>>> +
>>>>>>
>>>>>> With this change, the IP version based checks need to be moved to
>>>>>> respective smu_v* checks so that each IP version decides what is
>>>>>> supported at which level (R/W) rather than consolidating it here.
>>>>>> Only generic checks like amdgpu_sriov_is_pp_one_vf may be
>>>>>> maintained
>>>> here.
>>>>>> That way it really helps.
>>>>> [Quan, Evan] For some of them, they could be moved to respective
>>>> smu_v* or gfx_v* checks.
>>>>> But for some of them, it will be difficult. For example, for
>>>>> "mp1_ver <
>>>> IP_VERSION(10, 0, 0)" or " gc_ver >= IP_VERSION(10, 0, 0)", you need
>>>> to figure out which asics it refers to first and then apply the same
>>>> change to every of them. That seems more error prone.
>>>>> So, my thought is just left these old chunks as they were. And we
>>>>> just need
>>>> to take care of the future/new asics. How do you think?
>>>>>
>>>> My preference is to clean up this as much as possible. Also, you may
>>>> be able to set some of them generically based on FEAT_DPM bits in
>>>> swsmu/powerplay.
>>> I see. But I would expect the future ASICs take the way used in
>> patch3(more straightforward instead of implicit checking for some APIs or
>> DPM features).
>>> That's also the reason why I do not want to cleanup those old chunks. As I
>> do not expect them to serve for future ASICs.
>>> Then it's not worth to take the efforts(and risk) to do the cleanup.
>> Thoughts?
>>>
>>
>> It's to make sure consistency. I don't think leaving two options to do the
>> same thing is a good idea. Otherwise older will continue and cause confusion.
>> Changing to newer one for all is the preferred method and handling common
>> things in smu_common/powerplay is better rather than having to do
>> everything in individual versions.
> Those old bunches left in amdgpu_sysfs_if_support_check() can be divided into three types:
> 1. those which check for the existence for some API(like amdgpu_dpm_is_overdrive_supported/ amdgpu_dpm_get_power_profile_mode). The better choice for them is still left in amdgpu_pm.c I believe.
> 2. those which check for some common flags(like sriov or apu). The better choice for them is also left in amdgpu_pm.c
> 3. those which check for gc ip version or smu ip version. A better choice for them might be to move to amdgpu_discovery.c I think. But as mentioned before, I do not think it's worth to take the efforts(and risk) to do so.
> So, as you can see, I do not think there is anything we can move to smu_common/powerplay part.

If you are moving to a different method, think in terms of the new 
method and not the legacy way. Otherwise, we can continue the legacy 
method as described above. Keeping two options open is not a choice.

Thanks,
Lijo

> But if you were talking about splitting some changes in patch3 into smu_common/powerplay part, that will be a different story.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +	if (adev->flags & AMD_IS_APU)
>>>>>>> +		*sysfs_if_supported &=
>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
>>>>>>> +
>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>> +
>>>>>>> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>> +		*sysfs_if_supported &=
>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
>>>>>>> +
>>>>>>> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>> -
>>>>>> EOPNOTSUPP)
>>>>>>> +		*sysfs_if_supported &=
>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>> +
>>>>>>> +	if (gc_ver >= IP_VERSION(10, 0, 0))
>>>>>>> +
>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT]
>>>>>> &= ~S_IWUGO;
>>>>>>> +
>>>>>>> +	/* setting should not be allowed from VF if not in one VF
>> mode */
>>>>>>> +	if (amdgpu_sriov_vf(adev) &&
>>>>>>> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
>>>>>>> +		for (i = 0; i <
>>>>>> AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
>>>>>>> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
>>>>>>> +	}
>>>>>>> +}
>>>>>>> +
>>>>>>>      int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>>>>>      {
>>>>>>>      	int ret;
>>>>>>> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct
>>>> amdgpu_device
>>>>>> *adev)
>>>>>>>      	if (adev->pm.dpm_enabled == 0)
>>>>>>>      		return 0;
>>>>>>>
>>>>>>> +	amdgpu_sysfs_if_support_check(adev);
>>>>>>> +
>>>>>>>      	adev->pm.int_hwmon_dev =
>>>>>> hwmon_device_register_with_groups(adev->dev,
>>>>>>>
>>>>>> DRIVER_NAME, adev,
>>>>>>>
>>>>>> hwmon_groups);
