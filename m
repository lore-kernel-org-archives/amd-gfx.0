Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC61C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 05:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE76C6EAB3;
	Thu,  2 Dec 2021 05:12:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7346EAB3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 05:12:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZfPS8PBdrcs46dFqdvRo1MiBql5LWbFV4FqX8CMymBvhEkp0jP5zoHP/g7ljoFnpZIYCqNszCRzmzD9Qigniz8th5GvTQb7vGpJkXs/eVTUMqbAEAEpa2UeBSNfmRR5MmrbmmV/fvU9ZIEbkGsmM4DO7zokMD4nWLy9HvaanwQ09Q8arxRv6kVJJzFqR4jXLQDu4/WYubIHvUkE64jj9xh28/Y/OsHKtBfsYBdbm+rFj9y0NYZmJ013CK10uErid5s1laEnGqKidXxd8R9YupFQTtT06IL5ngnyuaThK8Xyij0/X8tJMdBg2JKbJt+oSpDWgTsZqO1aqXEO/dtkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dcxlz+ZM4HF3kYiSX0C2NS10LB5vD2/YdCjTA/2/vPY=;
 b=UyZLwpNsJFESdOl5EXRVV8/H/5TZF0C52Eazbax8VyCQeJyyyW3lv2NyV1LFcXBsyy8N8oo4SGBRGX4xIxmJtg/O140IZh5fkt5NwY0or1QB9fzdtNvJ8WVjn7fHztpwFZrA+QXV7VxI4W3cZAoP7Pn2jW24wAjMrdNgdqkYUfxZKykdKTgOFs9to2OQOk8GBmHNQc8LYQlKexQ6WAzUh1r6QwwtSPEPbXggxe0Od4cCamDzTY/kZNkYuJsS3wow0oz9uaxQAtQm8HsUWbkP/gu8wASZ1mfpdnq3cFqJGPrK6T+s02ST5ou7hml0/jxCvkwBeOYxKLE0hQ6axx7Nig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcxlz+ZM4HF3kYiSX0C2NS10LB5vD2/YdCjTA/2/vPY=;
 b=iCM0iO2y0Rksb+om2kjA/qYaWvZJMjVMMNadVan3b+kW0ELMgeyCE3bzTbf5eqR+nOy9YfBouqHRQAPqvH/zrOSdPgBsoXjcsLbK6lmLOlBokeRnR/JqzhWhuLLVhzdUTLDf9v+mKn8bHKeScHZqXnfEdyZXFmmpgvTf0GlTOxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 05:12:08 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 05:12:08 +0000
Message-ID: <817c62ad-9cee-804b-3f8a-71fad5f14d6f@amd.com>
Date: Thu, 2 Dec 2021 10:41:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 01/17] drm/amd/pm: do not expose implementation details
 to other blocks out of power
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211202030930.1681278-1-evan.quan@amd.com>
 <20211202030930.1681278-2-evan.quan@amd.com>
 <7e4f1675-5047-2994-bb7a-0cf03631b5c6@amd.com>
 <DM6PR12MB261937B5DB4D92DAA516411FE4699@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB261937B5DB4D92DAA516411FE4699@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::32) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 05:12:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9773d48-ba1e-4f77-262d-08d9b5524970
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49435BADA1EA6E923608974997699@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQAB2P8Me6ghu0cGHrGy+t1nYPUBwXzWrhP6gcVJaZp3YSBQpVpXBPUnJOw1Txff0/wcCdz6B/HY7yQWBNCbjGez8hOeTWIbUdfUGAILYTl+9okkm4UxqSvmGc3eHbj4OkdSGJuZfnpJlsLMDhyW+gA0akNA7HCXYQ6RZ8EAKm7P+933vWWFWA5WhvC9CgkJ3SojMjCcLSJm+H/UGDVogvJyUeL83AAl7om2+FUMVIcHnWaJThyKjrzrYzCia7IXcEZ1kGnk0UKdIG4ZCUgWkPhzH/UydPzaRjGdz9pztVtBlGCuhlHWoDcSXv4FgAAHbUJlskamuVlthhpKbyCCniVRnrsw9mHVz381frdLsst9QVPVZXnEBR5owOPQ/IWyxjjeImXCi4O31TvkrdyxX0uQsJyBYD/CRZZPiISBfoEiz0AzLfj7h+W7xK5tKBnKIWjpoaTwvoWtZKxxSwt+7aBKom+nnblLJMZjm5OcGUo9cXwXToJsileg8RAM1PHdK4A5w59gmUKmcT4ubPO8uNNwwZaKpzHWm3xRjwHR0N6D0vcaCSxxdG+8KN4RC8UloMDqT92DIHwOQXZ0o1kN2NEFlbtlhUJK6YNAHbJ1hyqqU+czXmFWmySobo5PpVhB2NB9dsBvj1hAco62+h1P1WXeceJT4LfBXBnvFZoH9smhlT0McgQnPSs78fUv1DL9w+Uf7IneZlG6hNJoanCfCtgfK6og0zAuYYy3M71yH3IwpWbgJQPW5+BYtOJawC09
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(16576012)(66476007)(6486002)(54906003)(2616005)(8936002)(110136005)(6666004)(36756003)(4326008)(508600001)(66556008)(8676002)(2906002)(19627235002)(5660300002)(38100700002)(86362001)(31696002)(53546011)(26005)(83380400001)(66946007)(30864003)(316002)(956004)(186003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2l6SzdRc2s5alkyS2x6MXdRV2VMZHp2WlVMWWNlMU94bjhVVUdwUzE5SzJx?=
 =?utf-8?B?QjRIZzNJMEE2L21aS3dRNDQ1VzlPN2ZRUEhueGg5aFJNakpnSDB3K3dnZzUw?=
 =?utf-8?B?eHhQaHloUVNaRmtaaGJtSDFsY0ZVQjZYY2hWU280OVZJM3c4TXNJZUFYVitJ?=
 =?utf-8?B?K0dCZjZuRERwSklCaEdCSjR0WDd1ZzVpZThLMUFpYjBPYmlJVlJxdC81VXhq?=
 =?utf-8?B?aWhHTmVkNGhwTFgyUXlDRGw4eE9pY1BnMXdRSy9TSm0vQUNuRzlHSHBLMk1M?=
 =?utf-8?B?eTNtOWhNYzF5eGNPR3hwcDM4MUxYVGlra2pBM3krZ2psYnRaaWpDOXcwNGxn?=
 =?utf-8?B?ZmxJZTVNWXJrNzIwN1hmWGU5WWc1R2QxV3BIZzJydDl5MjgzZUtMTStFTmp3?=
 =?utf-8?B?VHd4TWZDdGpmSkFrRkY1dWV6bXdtbWs0eDVRQkNPVmx0am9BS3A1WElrVlNu?=
 =?utf-8?B?eGJiYmdWTHZXb05RT0M2ek5ZOUo4eXVJenByYnBlYnR3ZmRjTlJFTGNDa2tD?=
 =?utf-8?B?R0lUU0w0RE9ENGRUcmFyZWVZT1R4OHZJYkVJV3hpK0cvZFhVK2VpSzFuQkN1?=
 =?utf-8?B?OGhpOWVkcmRNc2Y3Y3RTSkNhOWROK1JhR2RjNmdyazk2SHZNWUQvK24xL1Q0?=
 =?utf-8?B?S0J2SjFzRlcwZ3NmZE0zUkxCR1RXV0JwbWd0RExpMXV4MTNGak1jNnFVRXhu?=
 =?utf-8?B?T3BFZ05jQXJQYnhYSmR2UWh2UDcyZFBQUWh5ekhvaFFYMUU3Y0pVNnNlODEy?=
 =?utf-8?B?MnA3V0xDWEQrMStNMVlucmpnbmVHVlFYVmlMV2w2Z2hlYzZIRUtXbms3cmR3?=
 =?utf-8?B?cWlWRWlZSUhKSEtndFhwaG5GUEtQdHVqTkVyaXVsZklOSForSlhMNm1CM1dr?=
 =?utf-8?B?a09VZDhyNVJoUnJJR3BrNWlEbEVGaERkQy81eldEVW9FUG9hZWI1OTd5SFRx?=
 =?utf-8?B?OFg2R01Ga0lXWnNGVTRrOHVlN1JLaG1BNzQ0U0xrZEgrRS9NVm1KRldRREFN?=
 =?utf-8?B?bWszczRZa1VVUE81RTJxVGw4dXJuWk5ndG1IZGg5Qmx4bVNOL2J6UG5NS1NQ?=
 =?utf-8?B?bG1ERzlHV1NKME1oQkM4bGJuMFhFYjRFUlpGWjFYOUprVDQxcUFYSW5GSE5Q?=
 =?utf-8?B?aU1udFlZd3NOU0ZYcnppaGJxSjhId3lzeTRFSTdUV3lsOVh3RGV5N3VlQ29n?=
 =?utf-8?B?UEtxM3N5YnRQL0ZlMzdSMkFJOFI3Skhrd05KQXBIQTRRajJrNkwxUEFPeEpU?=
 =?utf-8?B?OFBWVU92NTZMRUt0cEZwVXl1M1ZxNFZYd3BvYkJNQ0dxc3JXc0w2V1g4ZjdS?=
 =?utf-8?B?bXNJZG40VDlmSFBOenhEVFhOcndjME1PRjNKQm0wYkZvRFVESzdDMFBPZDg5?=
 =?utf-8?B?ZjBBbE9tbkhlODZST2VJajh3cVpNUjNqWWZZa3hwYW5rTHNiK2hoZ21UYXpE?=
 =?utf-8?B?QXF6blFyTFNkWXlCRUNZazJ0Q0g5TkEzQ2JqeU1KVFRScG9JdXhxRStzS1Bs?=
 =?utf-8?B?Tlo4UUVWR1NGalF6SlNYZ2ZMcjlGeWszQmE2WUVOSkVmeUlDZ1lmZTF5ZjQx?=
 =?utf-8?B?d3lzak5zbXU0dkVWTDdMWXJIS3FKUjQ2V3dvViswOUNPTmpQZmI0OUEzdmhy?=
 =?utf-8?B?WGpkWHNzQ25NbFZjOFVxZithZWptV0xoVHNuRko2bENXbjZYekJVU3p2ckY2?=
 =?utf-8?B?NmRQZTZQb2pGUEZUL3dQZnVzZ2NqbzJPa3FyV05HNnNoQ1IydnF4d1ZoeTJu?=
 =?utf-8?B?SkNHMTFON0JZQnpLRzl0Q0Uyb1ArWmt4Y2lkM1NFbEJtVGVhMHBIRXBIQjdo?=
 =?utf-8?B?ZkdwbEx3YVE0UzR3d1ZSRXdKRi9TRFpqN1ZDeGtzT0NVejdsb3dXRUV2RDhM?=
 =?utf-8?B?akdaYXVHdlczUkVaV1FUZS9rVmpVTkxhMVlrSnZZMVJ1MDFPZC9aS29MZ0Zl?=
 =?utf-8?B?OHpiekRXd0d0aEwxU3cvaTNlTHlES3pGUFcxRkcvUm13TVRDL2RPSS8vT1NO?=
 =?utf-8?B?SVFabDByM24zK2k0aWJVQ2w4REVyMlN3c1daMEtHR0s4ZzgwWUltR2lVZVpZ?=
 =?utf-8?B?Y0dWdDQ1b2hBYmszWlVYWHRKaWVLL0E1OTUzS2xDNXl5UC9KKzkrR0t1dmtZ?=
 =?utf-8?Q?B5Bg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9773d48-ba1e-4f77-262d-08d9b5524970
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 05:12:07.8745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OwB5E7Yskl7ZutgAEjsp1BqtKJaVOOvEJpOdDoWH1FHuV2ocdeVal87f8CbTMsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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



On 12/2/2021 10:22 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, December 2, 2021 12:13 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH V3 01/17] drm/amd/pm: do not expose implementation
>> details to other blocks out of power
>>
>>
>>
>> On 12/2/2021 8:39 AM, Evan Quan wrote:
>>> Those implementation details(whether swsmu supported, some ppt_funcs
>>> supported, accessing internal statistics ...)should be kept
>>> internally. It's not a good practice and even error prone to expose
>> implementation details.
>>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: Ibca3462ceaa26a27a9145282b60c6ce5deca7752
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 +++---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 18 +---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 --
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  2 +-
>>>    .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +
>>>    drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 90
>> +++++++++++++++++++
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 25 +++++-
>>>    drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       | 11 +--
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 26 +++---
>>>    13 files changed, 161 insertions(+), 65 deletions(-)
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
>>
>> Hi Evan,
>>
>> As mentioned in the earlier comments, I suggest you to leave these newer
>> APIs and take care of the rest of the APIs. These may be covered as
>> amdgpu_smu* in another patch set. Till that time, it's not needed to move
>> them to amdgpu_dpm (as mentioned before, some of them are are not
>> even remotely related to power management).
> [Quan, Evan] This patch series highly relies on such change. That is swsmu is another framework as powerplay and all access should come through amdgpu_dpm.c.
> More specifically, patch 13 and 17 directly relies on this.
> Further more, without the unified lock protection from patch 17, the changes for dropping unneeded locks(which had been in my local branch) will be impossible.
> 
Patch 13 is directly related to smu context. I don't see many smu 
context related APIs added in amdgpu_dpm. I guess you could convert 
those APIs directly to pass amdgpu_device instead of smu_context.

Ex: smu_get_ecc_info(struct amdgpu_device *adev,

As for the mutex change, we could still use pm.mutex in place of smu 
mutex, right?

> I'm fine with the idea that naming those APIs supported by swsmu only with prefix amdgpu_smu*. But that has to be done after this patch series.
> And I would expect those APIs are located in amdgpu_dpm.c(instead of amdgpu_smu.c) also.

I don't think so. amdgpu_dpm and amdgpu_smu should be separate. I guess 
we shouldn't plan to have additional APIs in amdgpu_dpm anymore and move 
to component based APIs.

Thanks,
Lijo

> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
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
>>> index 08362d506534..54abdf7080de 100644
>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>>> @@ -1614,3 +1614,93 @@ int amdgpu_pm_load_smu_firmware(struct
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
>>> +	return smu_send_hbm_bad_pages_num(&adev->smu, size); }
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
>>> index f738f7dc20c9..942297c69de0 100644
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
>>> @@ -1412,15 +1407,15 @@ int smu_set_ac_dc(struct smu_context *smu);
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
>>>    int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t
>> size);
>>>    void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
>>> -
>>> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t
>>> +size);
>>>    #endif
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index 5839918cb574..d8cd7c8c4479 100644
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
>>> @@ -3285,3 +3281,13 @@ void amdgpu_smu_stb_debug_fs_init(struct
>> amdgpu_device *adev)
>>>    #endif
>>>
>>>    }
>>> +
>>> +int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t
>>> +size) {
>>> +	int ret = 0;
>>> +
>>> +	if (smu->ppt_funcs && smu->ppt_funcs-
>>> send_hbm_bad_pages_num)
>>> +		ret = smu->ppt_funcs->send_hbm_bad_pages_num(smu,
>> size);
>>> +
>>> +	return ret;
>>> +}
>> >
