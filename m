Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9949C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 03:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAC86E44C;
	Wed,  1 Dec 2021 03:33:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CE389D79
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 03:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/OlN9X2IzT/H66ZOQ7eJo8OSf5pzVMEAuvB+P9xAy/flKWK+Rai9rlZ5KiJigwubDwfzu0nirGPrXdXfeJqNZjxZqBXFMApijUfHwzepwH4AxgGyzb5uBtd9xuy54/Crn+OsGDp3QxrucTwCOi346hVOgiJMUFOytrboGXjl7QHIMy3ktYAyZxZgITwhkxdoR2WbMenSj2Ng4Bl8CW7OmTaFNYD64rWx/0CRzQXMghfNxn93F/loo/hqmIgjV2/2yVCHpLUmXxXzaAzLUWGOM/z5RrgHcFc33ssyLVkjTGcuFeu9CRnshUjXKFkuiGSMz2knEPBSWptd8gXb5Nz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s79YR0dUz5KIo+dK+beW/zkSR3V7kUebrICZZ73Wsk=;
 b=bizm55jicwf+NLFbwX6zlD0fwXATTn5oVqQd/zfbrhxDF6WVq5GCgVYJjgfFp+IXQ7jpM3sdHahMiijkKs/zIsC2O5aBFlN5AQG2UONkHglc0fohpoMXhUzINObW4yWwKg6cWf2SkPFFC0LuyEDvgJJSmoTGNWxMIHv5otXdtjVlugOLDtSvyCF7lrcDXQKiM9IaKYKi9v+Q83hKvZ7joYlxNDwOoNsjh1mjHz+0nzP0iv+uqL608elJObjc5nibo7h5Sk1yAAZfj67+7tY4rMRRFKzPvSeZBY2o4EVNWGAk93Axd0MD13Lt9P0g8EXvpRPssX7znMW/zn4KNAMIIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s79YR0dUz5KIo+dK+beW/zkSR3V7kUebrICZZ73Wsk=;
 b=Q6QJRhsTMrIT9POFFP8xOGBQdqw3Tket0Tu2ZaQmuDmELhY4TUwINNs/kj+4KwTKAGY21mKtzBiWBbNJd8agkRIP5VQucT8PxsMxsDDZhW3L3JL6mAKuJHsbck/IszVL0ibFob9FSfyNY59bxa8DmGZtfYJH3mY/I2wZPkNAcYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 1 Dec
 2021 03:33:28 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 03:33:28 +0000
Message-ID: <9bc16bef-1eee-b216-b4d2-047cd27c140d@amd.com>
Date: Wed, 1 Dec 2021 09:03:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH V2 01/17] drm/amd/pm: do not expose implementation details
 to other blocks out of power
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211130074259.1271965-1-evan.quan@amd.com>
 <20211130074259.1271965-2-evan.quan@amd.com>
 <e0c706ef-7531-d4c2-a360-2771b36aa584@amd.com>
 <DM6PR12MB261944D2BFAB475B69C10E69E4689@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261944D2BFAB475B69C10E69E4689@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Wed, 1 Dec 2021 03:33:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1b007a8-a46b-4bd8-8dec-08d9b47b56a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211CA6D61A6B6F93551205497689@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1T/uljgsY0DmDkiokry4PrLMAYXKCoo8KnZzaEMA9kN5lUZsb/Ah6oZQUrYwgwZsfAandupQzQ3nMb71NBr5QDM8iDgrDfg8tx9SXHca92fhiLni8QhHmibsVyRLfgCUAFlYi/lVg6Wg/aWPTfpzBQRMAKUaPvZuytzIxEdeEtMYd0MyFfSVCJDcpI6YxHKSkNlIua2zNOIJN0D/1Kda4J1Us58ll8xTtvY7dCG6GQBGeM5y81kA9YRMpv3pX/PKBtUVd4FWy7Kq9QWGQJ73Z2QBPBeLP6qWwa4raWQqI/e1ZGv7pdbSOv+MEvOODZpvE4IPJcvRPqwrCMlfq5ZgOEHjt/er9BlszdFu0df2nprbgv2A0fJETTSRVRL+cspByyWTzVkI3T66sJnJE6yrvqgeQsmlyEvXoUmpoi3EnWqAdCuBQSklN+iV6KmVbh+WKQpVextH752FFJ6voEQoP78uiXEPDWIUxn6T0Jb/y+bXco9Ib10qhY7WLghnfMHBFMvbwz8842DS/CMs5xmwUsxrzb6wsF8rWO7to20vah0gBefxgOo9CicYsr8ck52WFFg0sBuKgvd9Xpm2Mnbp7o0onBlYETZqYWoB/GT5dylNGJv2RJcwgeCZsqOBlmy67vDx5Gl81ZTdF1Y8rzHxEH4ZBC+9TQT0LJAR6sT+jv701hrxBgXU+vlJ8KsglUIbzTyuHkuKiFKRIxwkpdHTIWTZForv6Fc2kSWdwl2tQMhVrcTz1FES/Vt65o4LJPg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(26005)(53546011)(956004)(508600001)(8676002)(86362001)(4326008)(8936002)(2616005)(31696002)(83380400001)(16576012)(5660300002)(316002)(36756003)(30864003)(110136005)(66476007)(19627235002)(54906003)(66946007)(2906002)(31686004)(66556008)(186003)(6666004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVsdVQzU1Q1K3Z5L1U4R282QVl5R3dlUzkrc0V3Nk5LdjNtWHJraThKV2Z4?=
 =?utf-8?B?OEdQZ3JuZTQzbXQ2Y0VTWVJsQkZITDBCUnYzOVZuVlJDL3g3eGJDU2lFWHZk?=
 =?utf-8?B?ZjRKeUVHSjJWK2x0N2hUWldFWEIyaHJYRmJFNmZ5VGZJSlRnd0U0amRYK09O?=
 =?utf-8?B?ekhtaWU1VGkwMUxzR1AxS1VCbTdtYUM2ZUZOR0FwQ0F3UjExSVNtRzZ3d3Vm?=
 =?utf-8?B?bVNtTTNEeVBrWmlSdUUxeXZMVG9rZHJFWHhBRXd4Z0hQVjVIS1Y0aGJVTlFh?=
 =?utf-8?B?czZESjc3ZGxNRGluMkxHSFRNWHhWaU94Rk9EZWFULzl3TjBKckJqMGVPemtz?=
 =?utf-8?B?OC94K05ZMEJ3U0RQd3NlTkNOMVBnOUhxYkRyZWwwT3cwWDZzdUI3b3dBdisw?=
 =?utf-8?B?USt6TURuT05aN2l5ektLWU9Kc1lFek5qQUdhQWpleEoyWDFBM25NMURudDJE?=
 =?utf-8?B?eWI3Z1QzdG1JTUx1WE55bTNLOXBLTjQ3aFZhc0c4Yy9TQzFWZ1VLUm1qTFdM?=
 =?utf-8?B?OXdYTDFsZkNhYWJjRXVIdU5BaXpQZHpSOG81VG9SYklpM0ZSYlpOT1hyTW52?=
 =?utf-8?B?R0E1MWFQUVRrcVhGV01XTjlpZkNvbnRReW5JRUwxZXFtbEcrR0EzTSthVjh0?=
 =?utf-8?B?czdiM3hEOWJpbU00K1F2K01NSndEWGdXVEF5WkRvYXA5VHNlUjVGN3pRT1Yx?=
 =?utf-8?B?WkdPbExjZTY4bEIwbTViWTFTeWdHaHJqMkQxV2JWem41M3l5VmNOL09oY0Vh?=
 =?utf-8?B?cis2NFJUQ0ttMFpicElqdlJHMkhtZ2tudGd0OUVWaG1xQk9vWjJoQXJ3VW9H?=
 =?utf-8?B?aTgzOVRSaFY1Qml1Skxsc2dqaVA2VGdES1BnT01ZNFMxNE5ZSC9waHBRODRu?=
 =?utf-8?B?UzlUSFJQbjcyYXRQMnhySnBSc25xd2p5SXhmNlBuY1ZIazVFMGFpcnZVTk9O?=
 =?utf-8?B?c2NJNzhnSHJNYkgwWGR0N09QSjJVaHB6TGhTcXlYaytHR3kySGRYZmswVk9k?=
 =?utf-8?B?L1VqVnFCSlQvb29uU0tvMi82SmxseGVlcURqZlRkM2tUSHJNSFI3UGROc2ly?=
 =?utf-8?B?cEY1R0Y4SHFmTUZLY2ZwMGZGV2dTT2pIMzJWbWo0V0VhUjBvaEQzNURuR3Fj?=
 =?utf-8?B?SnhNZDRYOVpQQVEwbWpRM3pBV0o2UmZ1bVR2eDZsSjQzV2lVZ0oyOHhVNEdz?=
 =?utf-8?B?bTlvUUxyTENqZndyTXFFb2lrRjRXalF5NUNWaWU3ejFEdEl4MmNmaUI4d3ZX?=
 =?utf-8?B?RThQdE1pQnl6blp2NE1ka1V6Y0hTS0pUcjRKdEppcG5Za3FCcGpWcmNCeFdz?=
 =?utf-8?B?V0pFVkFmSHNUaHpLbllzb2dPeWZEamYvZ2x2YjF2ZSs5ZGFSczZOZThFVXBU?=
 =?utf-8?B?N203V1F2bC90Vnp6cUtzdHYxZzE5cmZPdElDaWNkL2tXTmtncG5KZjJFNUxj?=
 =?utf-8?B?c0tpZExya0QvejN0a1phSTloM1Q4RGlVRnBha1JXMjZuVzMySExQRXB5ck5H?=
 =?utf-8?B?aWQ3Zk9pRU9mbmxpTS9FME5sY2tYT0lMZ3VrdGRkN0FvdkY4eTI1SWpNM0JQ?=
 =?utf-8?B?VmQ0ZkNldEtzektWY2F3Y3dYL1Y3bnpZMHNvN0ExWTBMUHdzWUZNTTd5YWJG?=
 =?utf-8?B?Ynp4Sjg2QTV1aXBYSGViV09NVXZTQ3RML0FMd1pWbUNvSWFJR3BNbUwwMm5Z?=
 =?utf-8?B?V1FLdTU1OEVvYXRQQkJvem1vaXAwUmZZWnFjS0V6WHZJZk1teTRLUnlQZUJt?=
 =?utf-8?B?alRFVnJwWUtIcjk5djUzOVVpV0pzZkNja0J2UFhzVVNXblhWV20vMkZRRzQ3?=
 =?utf-8?B?Q0xReDlvS0QzQWZqTUxPeWR3VWtkeHFCampob2RFQWFxQkE3ZEVPa2taWFpW?=
 =?utf-8?B?bVVmakVpdC92K1JtWlNxV28rWFROcGxsM0NFNmNmdDJNN2VyUFJMWVh1eDFu?=
 =?utf-8?B?NVJsQzNtWVZHVDRndXJEUHo4eXhNc3NjV3hZUzZCZTByMFlOVUExK1lUOUt2?=
 =?utf-8?B?aVk4YXhGcjhzL3o0TmszcnlSOXlyMGVFQmd6RGhXUVA4WnlGOE5EenE0MVMy?=
 =?utf-8?B?bEkvNk5mK2JISE5XWjY4dE9meWZtMkY1RzR6bURib2JiQm95NHhvN20yQnVZ?=
 =?utf-8?Q?w4OY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b007a8-a46b-4bd8-8dec-08d9b47b56a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 03:33:28.1734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkN1JFtxQowWacvLiNKwxUlkAX3rwkUBFisvq/JprTysXF6uCiru05tVUg/hHPgs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/1/2021 7:29 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lazar, Lijo
>> Sent: Tuesday, November 30, 2021 4:10 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth
>> <Kenneth.Feng@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH V2 01/17] drm/amd/pm: do not expose implementation
>> details to other blocks out of power
>>
>>
>>
>> On 11/30/2021 1:12 PM, Evan Quan wrote:
>>> Those implementation details(whether swsmu supported, some ppt_funcs
>>> supported, accessing internal statistics ...)should be kept
>>> internally. It's not a good practice and even error prone to expose
>> implementation details.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: Ibca3462ceaa26a27a9145282b60c6ce5deca7752
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 ++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 18 +---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 --
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  2 +-
>>>    .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 95
>> +++++++++++++++++++
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 25 ++++-
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 +-
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ++--
>>>    13 files changed, 155 insertions(+), 64 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> index bcfdb63b1d42..a545df4efce1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>> @@ -260,7 +260,7 @@ static int aldebaran_mode2_restore_ip(struct
>> amdgpu_device *adev)
>>>    	adev->gfx.rlc.funcs->resume(adev);
>>>
>>>    	/* Wait for FW reset event complete */
>>> -	r = smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
>>> +	r = amdgpu_dpm_wait_for_event(adev,
>> SMU_EVENT_RESET_COMPLETE, 0);
>>>    	if (r) {
>>>    		dev_err(adev->dev,
>>>    			"Failed to get response from firmware after reset\n");
>> diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 164d6a9e9fbb..0d1f00b24aae 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1585,22 +1585,25 @@ static int amdgpu_debugfs_sclk_set(void *data,
>> u64 val)
>>>    		return ret;
>>>    	}
>>>
>>> -	if (is_support_sw_smu(adev)) {
>>> -		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK,
>> &min_freq, &max_freq);
>>> -		if (ret || val > max_freq || val < min_freq)
>>> -			return -EINVAL;
>>> -		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK,
>> (uint32_t)val, (uint32_t)val);
>>> -	} else {
>>> -		return 0;
>>> +	ret = amdgpu_dpm_get_dpm_freq_range(adev, PP_SCLK,
>> &min_freq, &max_freq);
>>> +	if (ret == -EOPNOTSUPP) {
>>> +		ret = 0;
>>> +		goto out;
>>>    	}
>>> +	if (ret || val > max_freq || val < min_freq) {
>>> +		ret = -EINVAL;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK,
>> (uint32_t)val, (uint32_t)val);
>>> +	if (ret)
>>> +		ret = -EINVAL;
>>>
>>> +out:
>>>    	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>    	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>> -	if (ret)
>>> -		return -EINVAL;
>>> -
>>> -	return 0;
>>> +	return ret;
>>>    }
>>>
>>>    DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL, diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 1989f9e9379e..41cc1ffb5809 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -2617,7 +2617,7 @@ static int amdgpu_device_ip_late_init(struct
>> amdgpu_device *adev)
>>>    	if (adev->asic_type == CHIP_ARCTURUS &&
>>>    	    amdgpu_passthrough(adev) &&
>>>    	    adev->gmc.xgmi.num_physical_nodes > 1)
>>> -		smu_set_light_sbr(&adev->smu, true);
>>> +		amdgpu_dpm_set_light_sbr(adev, true);
>>>
>>>    	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>>>    		mutex_lock(&mgpu_info.mutex);
>>> @@ -2857,7 +2857,7 @@ static int
>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>    	int i, r;
>>>
>>>    	if (adev->in_s0ix)
>>> -		amdgpu_gfx_state_change_set(adev,
>> sGpuChangeState_D3Entry);
>>> +		amdgpu_dpm_gfx_state_change(adev,
>> sGpuChangeState_D3Entry);
>>>
>>>    	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>>>    		if (!adev->ip_blocks[i].status.valid)
>>> @@ -3982,7 +3982,7 @@ int amdgpu_device_resume(struct drm_device
>> *dev, bool fbcon)
>>>    		return 0;
>>>
>>>    	if (adev->in_s0ix)
>>> -		amdgpu_gfx_state_change_set(adev,
>> sGpuChangeState_D0Entry);
>>> +		amdgpu_dpm_gfx_state_change(adev,
>> sGpuChangeState_D0Entry);
>>>
>>>    	/* post card */
>>>    	if (amdgpu_device_need_post(adev)) { diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 1916ec84dd71..3d8f82dc8c97 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -615,7 +615,7 @@ int amdgpu_get_gfx_off_status(struct
>> amdgpu_device
>>> *adev, uint32_t *value)
>>>
>>>    	mutex_lock(&adev->gfx.gfx_off_mutex);
>>>
>>> -	r = smu_get_status_gfxoff(adev, value);
>>> +	r = amdgpu_dpm_get_status_gfxoff(adev, value);
>>>
>>>    	mutex_unlock(&adev->gfx.gfx_off_mutex);
>>>
>>> @@ -852,19 +852,3 @@ int amdgpu_gfx_get_num_kcq(struct
>> amdgpu_device *adev)
>>>    	}
>>>    	return amdgpu_num_kcq;
>>>    }
>>> -
>>> -/* amdgpu_gfx_state_change_set - Handle gfx power state change set
>>> - * @adev: amdgpu_device pointer
>>> - * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2
>>> -sGpuChangeState_D3Entry)
>>> - *
>>> - */
>>> -
>>> -void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum
>>> gfx_change_state state) -{
>>> -	mutex_lock(&adev->pm.mutex);
>>> -	if (adev->powerplay.pp_funcs &&
>>> -	    adev->powerplay.pp_funcs->gfx_state_change_set)
>>> -		((adev)->powerplay.pp_funcs->gfx_state_change_set(
>>> -			(adev)->powerplay.pp_handle, state));
>>> -	mutex_unlock(&adev->pm.mutex);
>>> -}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index f851196c83a5..776c886fd94a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -47,12 +47,6 @@ enum amdgpu_gfx_pipe_priority {
>>>    	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
>>>    };
>>>
>>> -/* Argument for PPSMC_MSG_GpuChangeState */ -enum
>> gfx_change_state {
>>> -	sGpuChangeState_D0Entry = 1,
>>> -	sGpuChangeState_D3Entry,
>>> -};
>>> -
>>>    #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>>>    #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>>>
>>> @@ -410,5 +404,4 @@ int amdgpu_gfx_cp_ecc_error_irq(struct
>> amdgpu_device *adev,
>>>    uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
>>>    void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
>> uint32_t v);
>>>    int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev); -void
>>> amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum
>> gfx_change_state state);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 3c623e589b79..35c4aec04a7e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -901,7 +901,7 @@ static void amdgpu_ras_get_ecc_info(struct
>> amdgpu_device *adev, struct ras_err_d
>>>    	 * choosing right query method according to
>>>    	 * whether smu support query error information
>>>    	 */
>>> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc));
>>> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(ras->umc_ecc));
>>>    	if (ret == -EOPNOTSUPP) {
>>>    		if (adev->umc.ras_funcs &&
>>>    			adev->umc.ras_funcs->query_ras_error_count)
>>> @@ -2132,8 +2132,7 @@ int amdgpu_ras_recovery_init(struct
>> amdgpu_device *adev)
>>>    		if (ret)
>>>    			goto free;
>>>
>>> -		if (adev->smu.ppt_funcs && adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num)
>>> -			adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num(&adev->smu, con-
>>> eeprom_control.ras_num_recs);
>>> +		amdgpu_dpm_send_hbm_bad_pages_num(adev,
>>> +con->eeprom_control.ras_num_recs);
>>>    	}
>>>
>>>    #ifdef CONFIG_X86_MCE_AMD
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> index 6e4bea012ea4..5fed26c8db44 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>> @@ -97,7 +97,7 @@ int amdgpu_umc_process_ras_data_cb(struct
>> amdgpu_device *adev,
>>>    	int ret = 0;
>>>
>>>    	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
>>> -	ret = smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc));
>>> +	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
>>>    	if (ret == -EOPNOTSUPP) {
>>>    		if (adev->umc.ras_funcs &&
>>>    		    adev->umc.ras_funcs->query_ras_error_count)
>>> @@ -160,8 +160,7 @@ int amdgpu_umc_process_ras_data_cb(struct
>> amdgpu_device *adev,
>>>    						err_data->err_addr_cnt);
>>>    			amdgpu_ras_save_bad_pages(adev);
>>>
>>> -			if (adev->smu.ppt_funcs && adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num)
>>> -				adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num(&adev->smu, con-
>>> eeprom_control.ras_num_recs);
>>> +			amdgpu_dpm_send_hbm_bad_pages_num(adev,
>>> +con->eeprom_control.ras_num_recs);
>>>    		}
>>>
>>>    		amdgpu_ras_reset_gpu(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> index deae12dc777d..329a4c89f1e6 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> @@ -222,7 +222,7 @@ void
>>> kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
>>>
>>>    	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
>>>    		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>>> -		       atomic64_read(&dev->adev->smu.throttle_int_counter));
>>> +		       amdgpu_dpm_get_thermal_throttling_counter(dev-
>>> adev));
>>>
>>>    	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,
>> 	fifo_in, len);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> index 5c0867ebcfce..2e295facd086 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> @@ -26,6 +26,10 @@
>>>
>>>    extern const struct amdgpu_ip_block_version pp_smu_ip_block;
>>>
>>> +enum smu_event_type {
>>> +	SMU_EVENT_RESET_COMPLETE = 0,
>>> +};
>>> +
>>>    struct amd_vce_state {
>>>    	/* vce clocks */
>>>    	u32 evclk;
>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> index 08362d506534..9b332c8a0079 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1614,3 +1614,98 @@ int amdgpu_pm_load_smu_firmware(struct
>>> amdgpu_device *adev, uint32_t *smu_versio
>>>
>>>    	return 0;
>>>    }
>>> +
>>> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool
>> enable)
>>> +{
>>> +	return smu_set_light_sbr(&adev->smu, enable); }
>>> +
>>> +int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device
>> *adev,
>>> +uint32_t size) {
>>> +	int ret = 0;
>>> +
>>> +	if (adev->smu.ppt_funcs && adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num)
>>> +		ret = adev->smu.ppt_funcs-
>>> send_hbm_bad_pages_num(&adev->smu,
>>> +size);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>>> +				  enum pp_clock_type type,
>>> +				  uint32_t *min,
>>> +				  uint32_t *max)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	switch (type) {
>>> +	case PP_SCLK:
>>> +		return smu_get_dpm_freq_range(&adev->smu, SMU_SCLK,
>> min, max);
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>>> +				   enum pp_clock_type type,
>>> +				   uint32_t min,
>>> +				   uint32_t max)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	switch (type) {
>>> +	case PP_SCLK:
>>> +		return smu_set_soft_freq_range(&adev->smu, SMU_SCLK,
>> min, max);
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}
>>> +
>>> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
>>> +			      enum smu_event_type event,
>>> +			      uint64_t event_arg)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return smu_wait_for_event(&adev->smu, event, event_arg); }
>>> +
>>> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev,
>> uint32_t
>>> +*value) {
>>> +	if (!is_support_sw_smu(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	return smu_get_status_gfxoff(&adev->smu, value); }
>>> +
>>> +uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct
>>> +amdgpu_device *adev) {
>>> +	return atomic64_read(&adev->smu.throttle_int_counter);
>>> +}
>>> +
>>> +/* amdgpu_dpm_gfx_state_change - Handle gfx power state change set
>>> + * @adev: amdgpu_device pointer
>>> + * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2
>>> +-sGpuChangeState_D3Entry)
>>> + *
>>> + */
>>> +void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
>>> +				 enum gfx_change_state state)
>>> +{
>>> +	mutex_lock(&adev->pm.mutex);
>>> +	if (adev->powerplay.pp_funcs &&
>>> +	    adev->powerplay.pp_funcs->gfx_state_change_set)
>>> +		((adev)->powerplay.pp_funcs->gfx_state_change_set(
>>> +			(adev)->powerplay.pp_handle, state));
>>> +	mutex_unlock(&adev->pm.mutex);
>>> +}
>>> +
>>> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>>> +			    void *umc_ecc)
>>> +{
>>> +	if (!is_support_sw_smu(adev))
>>> +		return -EOPNOTSUPP;
>>> +
>>
>> In general, I don't think we need to keep this check everywhere to make
>> amdgpu_dpm_* backwards compatible.  The usage is also inconsistent. For
>> ex: amdgpu_dpm_get_thermal_throttling_counter doesn't have any
>> is_support_sw_smu check whereas amdgpu_dpm_get_ecc_info() has it.
>> There is no reason to keep adding is_support_sw_smu() check for every new
>> public API. For sure, they are not going to work with powerplay subsystem.
>>
>> I would rather prefer to leave old things and create amdgpu_smu_* for
>> anything which is supported only in smu subsystem. It's easier to read from
>> code perspective also - separate the ones which is supported by smu
>> component and not supported in older powerplay components.
>>
>> Only for the common ones that are supported in powerplay and smu, keep
>> amdgpu_dpm_*, for others preference would be to keep amdgpu_smu_*.
> [Quan, Evan] I get your point. However, then it will bring back the problem we are trying to avoid.
> That is the caller need to know whether the amdgpu_smu_* can be used. They need to know whether the swsmu framework is supported on some ASIC. >

swsmu has been for sometime. I'm suggesting to move away from 
amdgpu_dpm_* which is the legacy interface. There is no need to add new 
dpm_* APIs which are supported only in swsmu component. We only need to 
maintain the existing usage of dpm_*.

For the newer ones, let us move to component based APIs like 
amdgpu_smu_*. All the clients of swsmu are part of this component based 
architecture and they need to be aware of services of swsmu. It is 
similar to what is followed in other components like amdgpu_gmc_*, 
amdgpu_vcn* etc.

Thanks,
Lijo

> And yes, there is some inconsistent cases existing in current power code. Maybe we can create new patche(s) to fix them?
> For this patch series, I would like to avoid any real code logic change.
> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> +	return smu_get_ecc_info(&adev->smu, umc_ecc); }
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> index 16e3f72d31b9..7289d379a9fb 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>> @@ -23,6 +23,12 @@
>>>    #ifndef __AMDGPU_DPM_H__
>>>    #define __AMDGPU_DPM_H__
>>>
>>> +/* Argument for PPSMC_MSG_GpuChangeState */ enum
>> gfx_change_state {
>>> +	sGpuChangeState_D0Entry = 1,
>>> +	sGpuChangeState_D3Entry,
>>> +};
>>> +
>>>    enum amdgpu_int_thermal_type {
>>>    	THERMAL_TYPE_NONE,
>>>    	THERMAL_TYPE_EXTERNAL,
>>> @@ -574,5 +580,22 @@ void amdgpu_dpm_enable_vce(struct
>> amdgpu_device *adev, bool enable);
>>>    void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool
>> enable);
>>>    void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
>>>    int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev,
>> uint32_t
>>> *smu_version);
>>> -
>>> +int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool
>>> +enable); int amdgpu_dpm_send_hbm_bad_pages_num(struct
>> amdgpu_device
>>> +*adev, uint32_t size); int amdgpu_dpm_get_dpm_freq_range(struct
>> amdgpu_device *adev,
>>> +				       enum pp_clock_type type,
>>> +				       uint32_t *min,
>>> +				       uint32_t *max);
>>> +int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
>>> +				        enum pp_clock_type type,
>>> +				        uint32_t min,
>>> +				        uint32_t max);
>>> +int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum
>> smu_event_type event,
>>> +		       uint64_t event_arg);
>>> +int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev,
>> uint32_t
>>> +*value); uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct
>>> +amdgpu_device *adev); void amdgpu_dpm_gfx_state_change(struct
>> amdgpu_device *adev,
>>> +				 enum gfx_change_state state);
>>> +int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
>>> +			    void *umc_ecc);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> index f738f7dc20c9..29791bb21fba 100644
>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>> @@ -241,11 +241,6 @@ struct smu_user_dpm_profile {
>>>    	uint32_t clk_dependency;
>>>    };
>>>
>>> -enum smu_event_type {
>>> -
>>> -	SMU_EVENT_RESET_COMPLETE = 0,
>>> -};
>>> -
>>>    #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
>>>    	do {						\
>>>    		tables[table_id].size = s;		\
>>> @@ -1412,11 +1407,11 @@ int smu_set_ac_dc(struct smu_context *smu);
>>>
>>>    int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
>>>
>>> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t
>>> *value);
>>> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
>>>
>>>    int smu_set_light_sbr(struct smu_context *smu, bool enable);
>>>
>>> -int smu_wait_for_event(struct amdgpu_device *adev, enum
>>> smu_event_type event,
>>> +int smu_wait_for_event(struct smu_context *smu, enum
>> smu_event_type
>>> +event,
>>>    		       uint64_t event_arg);
>>>    int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
>>>    int smu_stb_collect_info(struct smu_context *smu, void *buff,
>>> uint32_t size); diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 5839918cb574..ef7d0e377965 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -100,17 +100,14 @@ static int smu_sys_set_pp_feature_mask(void
>> *handle,
>>>    	return ret;
>>>    }
>>>
>>> -int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t
>>> *value)
>>> +int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
>>>    {
>>> -	int ret = 0;
>>> -	struct smu_context *smu = &adev->smu;
>>> +	if (!smu->ppt_funcs->get_gfx_off_status)
>>> +		return -EINVAL;
>>>
>>> -	if (is_support_sw_smu(adev) && smu->ppt_funcs-
>>> get_gfx_off_status)
>>> -		*value = smu_get_gfx_off_status(smu);
>>> -	else
>>> -		ret = -EINVAL;
>>> +	*value = smu_get_gfx_off_status(smu);
>>>
>>> -	return ret;
>>> +	return 0;
>>>    }
>>>
>>>    int smu_set_soft_freq_range(struct smu_context *smu, @@ -3167,11
>>> +3164,10 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>>>    	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
>>>    };
>>>
>>> -int smu_wait_for_event(struct amdgpu_device *adev, enum
>>> smu_event_type event,
>>> +int smu_wait_for_event(struct smu_context *smu, enum
>> smu_event_type
>>> +event,
>>>    		       uint64_t event_arg)
>>>    {
>>>    	int ret = -EINVAL;
>>> -	struct smu_context *smu = &adev->smu;
>>>
>>>    	if (smu->ppt_funcs->wait_for_event) {
>>>    		mutex_lock(&smu->mutex);
>>>
