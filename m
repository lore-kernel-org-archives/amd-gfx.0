Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4166C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 04:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44ADD10E526;
	Tue, 10 Jan 2023 04:46:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC17510E526
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 04:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmz9EFuY2AxeE6ewcFKyhVYeIZUXwhkkkfXGM1+6K6ppBNZ98iGWIO23fzhNfdjmPBFwG1kN+IUpMtvsT+xOohY/+hdvU5f+uvYjaTeCoAbLzeLtbUJovyqe9T+4lCOXIZgiLgJ+Gl3a8fpFUm0x2fAH3QeJUdp48YMQdj6IOWwGINtCVskjB73T8YBA2yl7Bt485crtNos6YRxUTB5rnPILWhssRvEbZf15TmrK5qFZUQPSgAEMtD8majUEQxqGaSWkMTHPsXMcsfUDUGuzYSjATB8lqw+t3AitgIvQFhxiM7YOIUmPDn4PvzjZm5zO6l7qrQCwPbbE9cyXa4sckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flCoyVegPtLTS/3YoSXQNeUwWvnTqBXGkZWv2Otn5hY=;
 b=DILP6+8x6cJ2IsnkFmMthvD2Vt7EKFL7/Si5F1xZqWzhSuWzs3JPn3BtI7Ga2YVCGzYQyzdbp1Ja6ROXX16WZflx3RARDaDbdIt0zZBiBUkgee4la7nTeJuHhnXUndmfEbn7Z/N1sawfT/KcJmqb4umX1dVtxPhT4VQQFCVhrb+0FRasvSOeZUpUZLkgGA8iG1tpOQ9/KcBSRvxZpRgdIFjkkY/LgPC3KeuQhagx6l2Qpi1rlCSwi6+XmQK9YiH/Ja2NySIyVk4o4lUFaop+wntx1qs18nVZ5s60iRIzelpRKid5/c3MZFK8TAVcf8vzOybp40WyLtaVTbeweNqWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flCoyVegPtLTS/3YoSXQNeUwWvnTqBXGkZWv2Otn5hY=;
 b=bFp/eX+gU5gEe3Lwen6cO1iI4C5E5rJP7dZsQINQ7cGNiABPdlME7Ikh8TKzNSMHOCuoje+rYCU1+1dK8J3gnvnJBQIHd7yYirQcBwXjX/btff+LDtlTIscdANa5eFr3sFeYXRdyorNox13d7z9nnDqMsLZT04GUw0o3F/h8xzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:46:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:46:43 +0000
Message-ID: <554d0a88-acba-3acd-5b06-640afbf5ff99@amd.com>
Date: Tue, 10 Jan 2023 10:16:31 +0530
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
 <cb89d17b-04f5-d566-04b2-51da8fccd50f@amd.com>
 <DM6PR12MB2619A872FE009EABD089DD27E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619A872FE009EABD089DD27E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d82f4b9-0333-4934-cc80-08daf2c5abe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPUJHclc/eePLilKCEpqSUddpi2ukYTEQre4Fk/v/1hDe2gioHkZ0BUEMmBNVSdPcvgrw9+zxxSq0kDdBkBqJR8Pg/kiLmiSxZ2lgyrPcCJEPjIm4jTJtfJquiF3gfxwQCEU7wpV+XpNuNpcLD52k9bftNk2rSp10LovdhFUKa1oznlbVIsBy91w2P4L0vfmG2wx0o0wvUqGrLF2q2/GKQeePE6br3RFgI4LaHo/rxNZMZw174+Wp1iHsB2kPutJlHCzSlwNt/5qNVekg+z6x8AAngENl3DqOibnUyLEoIq5E4SOycmxb0o/4MFZfsop/oesZUyzJHG2GsxeQPbyFxPvIlBVX9r8hZ1drXdVgyNw+X+xKpQjNFYUocZV6tse6UuOgnVk4pd3R4oQHLIld7uFDnUgV0vFQjF3u1jaWlad6mHJd+a5j0F+RKqXsjBSpDtz2MSkaXYnUa5YOf6i+7e+Z7rdEtuKV3gS8uBU0kYRi5oUz5xJkK1Rua9LQWn47I8Kfmi+GlP0nvoJod7XViPNBTa9GfUGa8QzII3IIJgLbFRU4pisnCHZfEbXhvpdeYsSvxcK8zDr9thugfaq+8xvcil9J6DE6I+sS5GJZw14Ozhe4vjvYrBr6+XZudtBDEEqhWGsxFhlkGdCzcp9/OYf8wyhAarid4Q1WrOjVVTbclpSoeIyyNHCDF7+n+lBoiAgD1OYtrqeYGz1BCjjDc+zrMJ8Mzm//Py/Xwz04bY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199015)(36756003)(31686004)(66899015)(66556008)(86362001)(8676002)(41300700001)(110136005)(66476007)(31696002)(66946007)(83380400001)(4326008)(38100700002)(6666004)(6486002)(186003)(6506007)(26005)(53546011)(478600001)(316002)(8936002)(2906002)(5660300002)(30864003)(6512007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZJL1Q4eGFJdjVYOG10NE5wdmZUdkZyY1REM3hlNCt3TGNZdGZjblQ0UkdB?=
 =?utf-8?B?eWFhc3RzTmErMWFGV24ydGFPYmErRWIwTXliL01Ua3hQci9VNHZZeUxJV2ln?=
 =?utf-8?B?dmpLc3pEVytUbnpxSENFOThyU1JLSlhuRFVCWnNHV3V0TmJka0lsS0hGajds?=
 =?utf-8?B?SUs1cUpkeEE3V3QzR0dGK3NaOFI1ZmpndWpWUHM5OElsWnVpRlVNZXA4dE1h?=
 =?utf-8?B?dGZ2UWdEaG5zTEluN0lSZm14OTl3TkluZ0s5b1pCSlcra1haMzc4WXMyYXJ4?=
 =?utf-8?B?cW14cU1HMU8zY2ZGUytjK0diclVWYzh1NGczNnhUaVdYamVNaTcvUWVMcjlO?=
 =?utf-8?B?ZlArTnRaUVRRVlVlaFpVMkJWb1VSU3dOVkFNMFBZNXJBeThKcnhOZUlCakF0?=
 =?utf-8?B?K3g5VVlwZUtZS0FaNUZjYS9tV2NVYzBsb0cwa2Nray9xL0dJT3dOS0tvS0pz?=
 =?utf-8?B?WUxZd1NVb1pyaXZ1bll4STlEVk5VMm1mTzFJSFVaN0tFSG5RaUZPQUs0Z0c4?=
 =?utf-8?B?UXUwOVYyMTZPV3NlVjdoUVA1Zk80UVZiREx2MTZnZnl1ay9aeTdsalpQSHdi?=
 =?utf-8?B?K3E4anJ4eEZKZU9HUE93c3RTbFIzc05uUXB6cHJRVGcwRVJBcHJlUmJqdmZ4?=
 =?utf-8?B?Z2RHMzl4dFZoREZLY1dycDhLN2QxQmxxMVFuc0ltUFhzWFZNSjNwUjNmdjZE?=
 =?utf-8?B?a1NTTVNhQW1EUG9jT0tvZGZ4M0dEeWg1Y2NZSzIxWEtkbjgvUkFxYWtlWE9K?=
 =?utf-8?B?ZDFlS3dpSUsrLzlSSHVGaVU2c1N1RmRBQ2N2a3VUM3hnMmwrcG15d0VXM0Vj?=
 =?utf-8?B?RitHUCs1U2l3RmJnQXZTd0xDcFZlWHZ2eWw1WUw4dkwzbGE1TnRMTldOelZ1?=
 =?utf-8?B?WnJoL3ZHZVJHaDFtUS9GL2YwZXhOMzA2cDVXYmtKam1sbW8yZ1ZNYk5LTjFh?=
 =?utf-8?B?dUp5am9YcTFsSHN4ZURXUlhLMnY5K1crcVkxZmdzVktTMTU2ckQvdytsZkIv?=
 =?utf-8?B?OS9VS3BiTDRpOU1iMmgzN2pxQ0h2TEtZZlVGTjRyMHdZMVUzekNVWUNKelMw?=
 =?utf-8?B?NldNRHBmVTBUZjVnckZNUW9iTXNqNnRWYkR0Qlo2eHQzN0pIZElyZkIxOUFC?=
 =?utf-8?B?bzZwaDFvanJzZmlsa0I3QnZIZWZnNG11Q29VVi8vTFo2eDY5VlhXOEpDZ3JV?=
 =?utf-8?B?cUtVd1FZdkVWeDQrZ1hvVk1sYXRmVHBCS1lSU3RNdVBIdE52NGdkVnJhci9V?=
 =?utf-8?B?MUpyZHR2Z3FBVlNKQzB1NEd5UU0zc0RDcVQ5ZXBMWGIwRGZ4WVlMejhXY3FB?=
 =?utf-8?B?K2UydFZ6VzdwbnlCbW84ZHBPdkNtNnM5RVJuYyt4UlVaRVBUSGtzSXpoS3dE?=
 =?utf-8?B?UkhYMXRaOTVkSVRYUktiZUxEK0krQVZHdXNxd2YyUHloUEp6OU5KTGFObjB3?=
 =?utf-8?B?VWluZ2NvUTlENS9hWE0yTWRMY3V4dXp5dVM2NjA4YVZ0bEIrTGRVbVI1ZnE2?=
 =?utf-8?B?ck9NM1NHQnFFblhVSEFqM2VTSDBvR2FkS00ydGg3dnRvbGVKM29xTEh4b01z?=
 =?utf-8?B?ekpaVUhsRUdUUUJqUnZaaUNUYUJ2cXZZWFdNVklvTzYvY0dvZUpPZ0JOMWdU?=
 =?utf-8?B?Ukc1NlNZMEdsendiemRFWjhSRllKSzhaaHhNUnk3dXZyUDM5d2h6b3dqVVIx?=
 =?utf-8?B?Q2tZZTk1SGxkaUFkOEJkY3JVSGVhc0F6K1hJOGhKampGbEZ5cm9TNkg2aG8w?=
 =?utf-8?B?TFA3RmJ5S0lkOVpPTGlPc3ZlM3JRZ0N0WWJ5ak5nZkJ1dXVXajRBdjc2R2pL?=
 =?utf-8?B?aWVkRDFibytSQWY4ZjUrS3JXRTB0V25tMXlOMG5PRFZEZGt5WldkUjROaTdn?=
 =?utf-8?B?RVhsOUxnK1dUa0tFa3BDaDdnM2ZaL1RTWDZpQXRDVGRyVVhPSTdpQVB6bVZL?=
 =?utf-8?B?YWFRdWI2NU1VcWErclJOWEdHblZLMklydTIzdG5Ua2VHZWFzcXNnWFhzTllV?=
 =?utf-8?B?WnJWcVpzNG5lSnFOSU9yc0JaczdaczJISkFybTNJM2h4UXRKeForTW9CSExF?=
 =?utf-8?B?QzB4MXVLRDVjVmN5U2o4RGF1TXRyY1UraXJWRVZwKzFtZ0R3dndTQ1M3ZFJ3?=
 =?utf-8?Q?ACDGipq1x5wWR+DFvqgb+O6Cr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d82f4b9-0333-4934-cc80-08daf2c5abe2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 04:46:43.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjvKE/2YlKf5zyD96+rFi0hbVXi5kp8JVvvd8vm5ynIpAPRk6aGwUaJjjvrqHlQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
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



On 1/10/2023 8:07 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, January 9, 2023 6:52 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs interfaces
>> support
>>
>>
>>
>> On 1/9/2023 2:27 PM, Quan, Evan wrote:
>>> [AMD Official Use Only - General]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, January 9, 2023 11:28 AM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>> interfaces support
>>>>
>>>>
>>>>
>>>> On 1/9/2023 7:42 AM, Quan, Evan wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Friday, January 6, 2023 6:01 PM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>>>> interfaces support
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 1/6/2023 2:14 PM, Quan, Evan wrote:
>>>>>>> [AMD Official Use Only - General]
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>> Sent: Friday, January 6, 2023 11:55 AM
>>>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>>>> gfx@lists.freedesktop.org
>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for sysfs
>>>>>>>> interfaces support
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 1/6/2023 7:34 AM, Quan, Evan wrote:
>>>>>>>>> [AMD Official Use Only - General]
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>>>>> Sent: Thursday, January 5, 2023 9:58 PM
>>>>>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>>>>>> gfx@lists.freedesktop.org
>>>>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>>>>>>> Subject: Re: [PATCH 2/8] drm/amd/pm: refine the checks for
>>>>>>>>>> sysfs interfaces support
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 1/5/2023 8:52 AM, Evan Quan wrote:
>>>>>>>>>>> Make the code more clean and readable with no real logics
>> change.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>>>>>>>> Change-Id: I21c879fa9abad9f6da3b5289adf3124950d2f4eb
>>>>>>>>>>> ---
>>>>>>>>>>>        drivers/gpu/drm/amd/pm/amdgpu_pm.c | 200
>>>> ++++++++++++++--
>>>>>> ----
>>>>>>>> ---
>>>>>>>>>> ------
>>>>>>>>>>>        1 file changed, 98 insertions(+), 102 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>>>> index fb6a7d45693a..c69db29eea24 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>>>>>>>>> @@ -2006,9 +2006,6 @@ static int default_attr_update(struct
>>>>>>>>>> amdgpu_device *adev, struct amdgpu_device_
>>>>>>>>>>>        			       uint32_t mask, enum
>>>>>> amdgpu_device_attr_states
>>>>>>>>>> *states)
>>>>>>>>>>>        {
>>>>>>>>>>>        	struct device_attribute *dev_attr = &attr->dev_attr;
>>>>>>>>>>> -	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>>>>>> -	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>>>>>> -	const char *attr_name = dev_attr->attr.name;
>>>>>>>>>>>
>>>>>>>>>>>        	if (!(attr->flags & mask) ||
>>>>>>>>>>>        	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) &
>>>>>>>>>>> adev->pm.sysfs_if_supported))  { @@ -2016,112 +2013,14 @@
>>>> static
>>>>>>>>>>> adev->int
>>>>>>>>>> default_attr_update(struct amdgpu_device *adev, struct
>>>>>>>> amdgpu_device_
>>>>>>>>>>>        		return 0;
>>>>>>>>>>>        	}
>>>>>>>>>>>
>>>>>>>>>>> -#define DEVICE_ATTR_IS(_name)	(!strcmp(attr_name,
>>>>>> #_name))
>>>>>>>>>>> -
>>>>>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
>>>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 0, 0) ||
>>>>>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 1) ||
>>>>>>>>>>> -		    gc_ver == IP_VERSION(9, 4, 2))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>>>>>> -		if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>>>>>>>>>>> -		*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -		if (amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
>>>>>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver ==
>>>>>> IP_VERSION(9, 0,
>>>>>>>>>> 1))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pcie_bw)) {
>>>>>>>>>>> -		/* PCIe Perf counters won't work on APU nodes */
>>>>>>>>>>> -		if (adev->flags & AMD_IS_APU)
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(unique_id)) {
>>>>>>>>>>> -		switch (gc_ver) {
>>>>>>>>>>> -		case IP_VERSION(9, 0, 1):
>>>>>>>>>>> -		case IP_VERSION(9, 4, 0):
>>>>>>>>>>> -		case IP_VERSION(9, 4, 1):
>>>>>>>>>>> -		case IP_VERSION(9, 4, 2):
>>>>>>>>>>> -		case IP_VERSION(10, 3, 0):
>>>>>>>>>>> -		case IP_VERSION(11, 0, 0):
>>>>>>>>>>> -			*states = ATTR_STATE_SUPPORTED;
>>>>>>>>>>> -			break;
>>>>>>>>>>> -		default:
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -		}
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_features)) {
>>>>>>>>>>> -		if (adev->flags & AMD_IS_APU || gc_ver <
>>>>>> IP_VERSION(9, 0,
>>>>>>>>>> 0))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(gpu_metrics)) {
>>>>>>>>>>> -		if (gc_ver < IP_VERSION(9, 1, 0))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>>>>>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>>>>>>>>>>> -		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(10, 3, 0) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(10, 1, 2) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 0) ||
>>>>>>>>>>> -		      gc_ver == IP_VERSION(11, 0, 2)))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>>>>>>>>>>> -		if (amdgpu_dpm_get_power_profile_mode(adev,
>>>>>> NULL) ==
>>>>>>>>>> -EOPNOTSUPP)
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -		else if (gc_ver == IP_VERSION(10, 3, 0) &&
>>>>>>>>>> amdgpu_sriov_vf(adev))
>>>>>>>>>>> -			*states = ATTR_STATE_UNSUPPORTED;
>>>>>>>>>>> -	}
>>>>>>>>>>> -
>>>>>>>>>>> -	switch (gc_ver) {
>>>>>>>>>>> -	case IP_VERSION(9, 4, 1):
>>>>>>>>>>> -	case IP_VERSION(9, 4, 2):
>>>>>>>>>>> -		/* the Mi series card does not support standalone
>>>>>>>>>> mclk/socclk/fclk level setting */
>>>>>>>>>>> -		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>>>>>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
>>>>>>>>>>> -		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
>>>>>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>>>> -		}
>>>>>>>>>>> -		break;
>>>>>>>>>>> -	case IP_VERSION(10, 3, 0):
>>>>>>>>>>> -		if
>>>>>> (DEVICE_ATTR_IS(power_dpm_force_performance_level)
>>>>>>>>>> &&
>>>>>>>>>>> -		    amdgpu_sriov_vf(adev)) {
>>>>>>>>>>> -			dev_attr->attr.mode &= ~0222;
>>>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>>>> -		}
>>>>>>>>>>> -		break;
>>>>>>>>>>> -	default:
>>>>>>>>>>> -		break;
>>>>>>>>>>> -	}
>>>>>>>>>>> -
>>>>>>>>>>> -	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>>>>>>>>>>> -		/* SMU MP1 does not support dcefclk level setting */
>>>>>>>>>>> -		if (gc_ver >= IP_VERSION(10, 0, 0)) {
>>>>>>>>>>> -			dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>>>> -			dev_attr->store = NULL;
>>>>>>>>>>> -		}
>>>>>>>>>>> -	}
>>>>>>>>>>> -
>>>>>>>>>>> -	/* setting should not be allowed from VF if not in one VF
>>>>>> mode */
>>>>>>>>>>> -	if (amdgpu_sriov_vf(adev)
>>>>>> && !amdgpu_sriov_is_pp_one_vf(adev))
>>>>>>>>>> {
>>>>>>>>>>> +	if (!(adev->pm.sysfs_if_attr_mode[attr->if_bit] & S_IWUGO))
>>>>>> {
>>>>>>>>>>>        		dev_attr->attr.mode &= ~S_IWUGO;
>>>>>>>>>>>        		dev_attr->store = NULL;
>>>>>>>>>>>        	}
>>>>>>>>>>>
>>>>>>>>>>> -#undef DEVICE_ATTR_IS
>>>>>>>>>>> -
>>>>>>>>>>>        	return 0;
>>>>>>>>>>>        }
>>>>>>>>>>>
>>>>>>>>>>> -
>>>>>>>>>>>        static int amdgpu_device_attr_create(struct
>>>>>>>>>>> amdgpu_device
>>>> *adev,
>>>>>>>>>>>        				     struct amdgpu_device_attr *attr,
>>>>>>>>>>>        				     uint32_t mask, struct list_head
>>>>>> *attr_list)
>>>>>>>>>> @@ -3411,6
>>>>>>>>>>> +3310,101 @@ static const struct attribute_group
>>>> *hwmon_groups[]
>>>>>> =
>>>>>>>>>>> +{
>>>>>>>>>>>        	NULL
>>>>>>>>>>>        };
>>>>>>>>>>>
>>>>>>>>>>> +static void amdgpu_sysfs_if_support_check(struct
>>>> amdgpu_device
>>>>>>>>>>> +*adev) {
>>>>>>>>>>> +	uint64_t *sysfs_if_supported = &adev-
>>>>>>> pm.sysfs_if_supported;
>>>>>>>>>>> +	umode_t *sysfs_if_attr_mode = adev-
>>>>>>> pm.sysfs_if_attr_mode;
>>>>>>>>>>> +	uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
>>>>>>>>>>> +	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>>>>>>>>>>> +	int i;
>>>>>>>>>>> +
>>>>>>>>>>> +	/* All but those specific ASICs support these */
>>>>>>>>>>> +	*sysfs_if_supported &=
>>>>>> ~BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +	*sysfs_if_supported &=
>>>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT));
>>>>>>>>>>> +
>>>>>>>>>>> +	if (gc_ver < IP_VERSION(9, 1, 0)) {
>>>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_GPU_METRICS_BIT);
>>>>>>>>>>> +
>>>>>>>>>>> +		if (gc_ver == IP_VERSION(9, 0, 1)) {
>>>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT);
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +		}
>>>>>>>>>>> +
>>>>>>>>>>> +		if (gc_ver < IP_VERSION(9, 0, 0))
>>>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>>>>>> +	} else {
>>>>>>>>>>> +		switch (gc_ver) {
>>>>>>>>>>> +		case IP_VERSION(9, 4, 0):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(9, 4, 1):
>>>>>>>>>>> +		case IP_VERSION(9, 4, 2):
>>>>>>>>>>> +			*sysfs_if_supported &=
>>>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT);
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +			/* the Mi series card does not support
>>>>>> standalone
>>>>>>>>>> mclk/socclk/fclk level setting */
>>>>>>>>>>> +
>>>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_MCLK_BIT]
>>>> &=
>>>>>>>> ~S_IWUGO;
>>>>>>>>>>> +
>>>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT]
>>>> &=
>>>>>>>> ~S_IWUGO;
>>>>>>>>>>> +
>>>>>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_FCLK_BIT] &=
>>>>>>>> ~S_IWUGO;
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(10, 1, 2):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(10, 3, 0):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>>>> +			if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>> +				*sysfs_if_supported &=
>>>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>>>>>> +
>>>>>>>>>>
>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_POWER_DPM_FORCE_PERFOR
>>>>>>>>>> MANCE_LEVEL_BIT] &= ~S_IWUGO;
>>>>>>>>>>> +			}
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(10, 3, 1):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(11, 0, 0):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_UNIQUE_ID_BIT);
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		case IP_VERSION(11, 0, 2):
>>>>>>>>>>> +			*sysfs_if_supported |=
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_VCLK_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCLK_BIT);
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		default:
>>>>>>>>>>> +			break;
>>>>>>>>>>> +		}
>>>>>>>>>>> +	}
>>>>>>>>>>> +
>>>>>>>>>>> +	if (mp1_ver < IP_VERSION(10, 0, 0))
>>>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>>> ~BIT_ULL(AMD_SYSFS_IF_PP_DPM_FCLK_BIT);
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> With this change, the IP version based checks need to be moved
>>>>>>>>>> to respective smu_v* checks so that each IP version decides
>>>>>>>>>> what is supported at which level (R/W) rather than consolidating it
>> here.
>>>>>>>>>> Only generic checks like amdgpu_sriov_is_pp_one_vf may be
>>>>>>>>>> maintained
>>>>>>>> here.
>>>>>>>>>> That way it really helps.
>>>>>>>>> [Quan, Evan] For some of them, they could be moved to respective
>>>>>>>> smu_v* or gfx_v* checks.
>>>>>>>>> But for some of them, it will be difficult. For example, for
>>>>>>>>> "mp1_ver <
>>>>>>>> IP_VERSION(10, 0, 0)" or " gc_ver >= IP_VERSION(10, 0, 0)", you
>>>>>>>> need to figure out which asics it refers to first and then apply
>>>>>>>> the same change to every of them. That seems more error prone.
>>>>>>>>> So, my thought is just left these old chunks as they were. And
>>>>>>>>> we just need
>>>>>>>> to take care of the future/new asics. How do you think?
>>>>>>>>>
>>>>>>>> My preference is to clean up this as much as possible. Also, you
>>>>>>>> may be able to set some of them generically based on FEAT_DPM
>>>>>>>> bits in swsmu/powerplay.
>>>>>>> I see. But I would expect the future ASICs take the way used in
>>>>>> patch3(more straightforward instead of implicit checking for some
>>>>>> APIs or DPM features).
>>>>>>> That's also the reason why I do not want to cleanup those old
>>>>>>> chunks. As I
>>>>>> do not expect them to serve for future ASICs.
>>>>>>> Then it's not worth to take the efforts(and risk) to do the cleanup.
>>>>>> Thoughts?
>>>>>>>
>>>>>>
>>>>>> It's to make sure consistency. I don't think leaving two options to
>>>>>> do the same thing is a good idea. Otherwise older will continue and
>>>>>> cause
>>>> confusion.
>>>>>> Changing to newer one for all is the preferred method and handling
>>>>>> common things in smu_common/powerplay is better rather than
>> having
>>>> to
>>>>>> do everything in individual versions.
>>>>> Those old bunches left in amdgpu_sysfs_if_support_check() can be
>>>>> divided
>>>> into three types:
>>>>> 1. those which check for the existence for some API(like
>>>> amdgpu_dpm_is_overdrive_supported/
>>>> amdgpu_dpm_get_power_profile_mode). The better choice for them is
>>>> still left in amdgpu_pm.c I believe.
>>>>> 2. those which check for some common flags(like sriov or apu). The
>>>>> better choice for them is also left in amdgpu_pm.c 3. those which
>>>>> check for
>>>> gc ip version or smu ip version. A better choice for them might be to
>>>> move to amdgpu_discovery.c I think. But as mentioned before, I do not
>>>> think it's worth to take the efforts(and risk) to do so.
>>>>> So, as you can see, I do not think there is anything we can move to
>>>> smu_common/powerplay part.
>>>>
>>>> If you are moving to a different method, think in terms of the new
>>>> method and not the legacy way. Otherwise, we can continue the legacy
>>>> method as described above. Keeping two options open is not a choice.
>>> [Quan, Evan] Sorry, I'm still not persuaded. It's not about legacy way.
>>
>> What is the reason for anyone not to maintain it in the legacy way for new
>> ASICs also. This patch is at best half cooked. Either cook it fully or throw it out.
> I think we spent too much time on those discussions about the proper designs(about where(which api/file) should some piece of code be placed).

Yes, the time is spent as the patch doesn't look fine.
> If you do not see any issue that affects these patch function correctly, can we just land them first?
> Please let us do the thing right first.

Sorry, I don't think this is the right approach. I suggest to drop this 
for now and do it in the right way later rather than using fix-it-later 
approach.

Thanks,
Lijo

> And i'm open with(and welcome) any further update to the logics introduced in those patches if you do see a better design.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> In fact, all the code has been transformed into bitmask related.
>>> I think your suggestions are about finding a new place for the code above.
>>> I'm not convinced as i believe they served for legacy asics only and they
>> cannot benefit for future asics.
>>> So, it's not worth to take efforts to move them to new places and take the
>> risks.
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> But if you were talking about splitting some changes in patch3 into
>>>> smu_common/powerplay part, that will be a different story.
>>>>>
>>>>> BR
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> BR
>>>>>>> Evan
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>>>
>>>>>>>>> Evan
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Lijo
>>>>>>>>>>
>>>>>>>>>>> +	if (adev->flags & AMD_IS_APU)
>>>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>>> ~(BIT_ULL(AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PCIE_BW_BIT) |
>>>>>>>>>>> +
>>>>>>>>>> BIT_ULL(AMD_SYSFS_IF_PP_FEATURES_BIT));
>>>>>>>>>>> +
>>>>>>>>>>> +	if (!amdgpu_dpm_is_overdrive_supported(adev))
>>>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT);
>>>>>>>>>>> +
>>>>>>>>>>> +	if (amdgpu_dpm_get_power_profile_mode(adev, NULL) ==
>>>>>> -
>>>>>>>>>> EOPNOTSUPP)
>>>>>>>>>>> +		*sysfs_if_supported &=
>>>>>>>>>>> +~BIT_ULL(AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT);
>>>>>>>>>>> +
>>>>>>>>>>> +	if (gc_ver >= IP_VERSION(10, 0, 0))
>>>>>>>>>>> +
>>>>>> 	sysfs_if_attr_mode[AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT]
>>>>>>>>>> &= ~S_IWUGO;
>>>>>>>>>>> +
>>>>>>>>>>> +	/* setting should not be allowed from VF if not in one VF
>>>>>> mode */
>>>>>>>>>>> +	if (amdgpu_sriov_vf(adev) &&
>>>>>>>>>>> +	    !amdgpu_sriov_is_pp_one_vf(adev)) {
>>>>>>>>>>> +		for (i = 0; i <
>>>>>>>>>> AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
>>>>>>>>>>> +			sysfs_if_attr_mode[i] &= ~S_IWUGO;
>>>>>>>>>>> +	}
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>        int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>>>>>>>>>>>        {
>>>>>>>>>>>        	int ret;
>>>>>>>>>>> @@ -3424,6 +3418,8 @@ int amdgpu_pm_sysfs_init(struct
>>>>>>>> amdgpu_device
>>>>>>>>>> *adev)
>>>>>>>>>>>        	if (adev->pm.dpm_enabled == 0)
>>>>>>>>>>>        		return 0;
>>>>>>>>>>>
>>>>>>>>>>> +	amdgpu_sysfs_if_support_check(adev);
>>>>>>>>>>> +
>>>>>>>>>>>        	adev->pm.int_hwmon_dev =
>>>>>>>>>> hwmon_device_register_with_groups(adev->dev,
>>>>>>>>>>>
>>>>>>>>>> DRIVER_NAME, adev,
>>>>>>>>>>>
>>>>>>>>>> hwmon_groups);
