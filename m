Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AC8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 12:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F07310FFE1;
	Thu, 12 May 2022 12:57:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA5210FFE1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 12:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+o3i2F2EOTth6ihHE7f2/upw82V9++Y9ZUUSTV8r0mjFD9lY+jP9qt7+1cx27NZaM6ZVP0zZztC8fhFuog1tmSdgBs/N8He756v1EZ0e9vrwPQB2zmufsLNRK8Hww00oeyj6EME0Amu5g1Hpp0HbKgYm6EG9VLTIVwZGADSRSUM/5iCRUgA8nZHjRmRKPbAf5+Y32qSLpM7xvxTINb+XxcQdX5qQXqp2toD5mBLhVkbaC8RXjF8zLuZAUcmLDUJ11iKM1WqmrUpTP5McwgjCvGyitToM/tibYr6GFXC1jWab7A2srvsC0It4VSbcnPLuhaduRrLDwNdD6LOe9JjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v44W2vycLw69rkQHkdhlJ6VyAHF9G1f+NMwDmEvqlG4=;
 b=dR5zJ5WA1dauR7Ix4OLWEHyz4OODuZ+Q4919TIw27kr32X+0ch5vWCxiWQnyxE6D8HKOu4i5gCVW/c1N8vF6ceB5+Z1B9hp3lzrCJivFLo9QEvQen9Q9tFRI+znAGK21lVlvHK8sdeD3chdlvlvSrdUEq1Rj8QQVOwFJ8xu2aOZLO6TolQSBZV1GYKpZ+8DRKd1ok0HW1dwKNU0KoolPj0v/+WT+/yDbNknjDAS87NbbbTWtjll/o0jQPs2g+fKmOH6GNr/7DvazliJ7HYcZSyYt1zaDw8YngpwmgRq3fk81T+komjFKzHbqa68rp0kIjWnQnEkW+ojEWI94cG4E9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v44W2vycLw69rkQHkdhlJ6VyAHF9G1f+NMwDmEvqlG4=;
 b=QpPsUztMkxlBuECtLN5yDa3UTVx2kYfk8VZgcy6wnK5AW9EpBG5sqcPnozrDxDMwsFu7RU9GD7drqoSzPLN8HjXxBw/atcJQuMe3iWyjOFiNrvorMTMS5EGP0aDGWAlau7s5nccYpzIpd0jQxpIcLX8MgIvB7BED33N2XhbfqBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3961.namprd12.prod.outlook.com (2603:10b6:5:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 12:57:50 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 12:57:50 +0000
Message-ID: <00fd912a-205b-a8e4-ae19-f2ede0dd4474@amd.com>
Date: Thu, 12 May 2022 08:57:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
 <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
 <5f49de9e-dfa0-3371-c800-581f00556820@amd.com>
 <82cf78c6-9246-e892-bc42-99f6ec668481@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <be946517-4355-0f9f-4dad-9653af3f9140@amd.com>
 <a1ba4b3e-3a28-49ea-4923-50e0ae6f16da@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <a1ba4b3e-3a28-49ea-4923-50e0ae6f16da@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a1b2fba-ff32-4dbe-cf66-08da3417051b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3961:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39614189B4D5E00E9B91B493EACB9@DM6PR12MB3961.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gb4AuZBwkYqx2D5XKxP+VEl4W8R8U9I7OnnvtIQ1Lk1ioVXP50IORzAnfWfy7FDlVHmhzrx+/yotITkgrH4xpGeY2v55FxSX87pSDywkUUiH5FDAxy8HzKkRNGTzUH0Ya57kOy5ckW/yG2qrCtUUzVmeOjMsCGHS04EjgL6vggw5FuPFHZa0QsZU7n2JEkD100hS89J8qsZLcaiL3+CKpLKVRBm2I4xXW37YKZnkbwzRjrSE63UVd9w45uKDMhGJjv/2DWl+YCHgs6C7lXVMkBEs1wutZKThcBC3RkM4016BNdBKdvvxysdD+IPAkXhgHiVp186I9ZgnCpYfHuBt30fzDkFtNub6Adfc50d7rfxC1OLLi8+JZt6FECtxHw/q6Vyr9csk3Cri1q40KpZoomwtWD3MYlRlfXM0CmHJFGs2DFXWtmIT7n6XXCs8WTrJlkV43GpopjwNcPQ+7I5MyAHJujRjrc9B+DVwBYLDnGknoA6xHLIBYzcNUK8QflE5JH80aoU4PxFnU2G6td5+qEnMSvz/FiyEwHs3B+BRES6czs4sL6qXaIAu2TJuOScehOaaGI5TaG2SWDLum/LGSvbjSXms63tXear8SKngDj0tNWEMLVlzMmSw2efiL+UKr3VkeE4l1boJsTgP+RWptJ+Fnuoov7WXFscKZjiCOs66EAKLt63JEvYTZ1EtyXQ0Rsxhwxi8jai57STVaao8ix2vFALgyCj80Deb4MxC7cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(110136005)(66574015)(83380400001)(508600001)(86362001)(31696002)(316002)(186003)(8676002)(4326008)(36756003)(6512007)(38100700002)(53546011)(5660300002)(31686004)(44832011)(66476007)(66556008)(66946007)(30864003)(6506007)(8936002)(2906002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWk2YTBUREc2UXp0RGNSSWtBT1F0SU5WbDRlSmdCVmp0NytsREN2NlJ6SmVR?=
 =?utf-8?B?NEgrRE96ai9WVVpUcWtndzR1NU00YUlkL3pja1h4eG9pdWtod0szcG1icUNr?=
 =?utf-8?B?anl2TDN5dzNlRW8wcWtXN3FZS3IrUWZ5NjBoODJqV3VaWmJMc3FDKzZuQS9n?=
 =?utf-8?B?cUZwUHUwQ21STFk5SlJKbFNBeEZndVkyaE4rM3lpdWpsWjJlLzVvaXMxWjE4?=
 =?utf-8?B?VEQxY2NhUDUzWGVnWEJGSUduZ01ycUdCRFZiekMzYnplTVd1YlJZenZIV0xo?=
 =?utf-8?B?T0hQVmZlbmVBUEczcVpRZ2cyWER2R01rSi9FNXQxdEhNNjd3WTNkdTN0NVVx?=
 =?utf-8?B?ZENtejNKRDBTTkF2RkFkQWJvWE5vZlhaV3hFVUhyTTZFa3N6K3U3MnBNKzJL?=
 =?utf-8?B?Y2xERnFYN0tsZXlvaUhiWURXY0djSnFFaUpqNnZxM0VqYWYreU03WUM1U1pV?=
 =?utf-8?B?RHlYMnUycFVCWnl5elVFb2xQcU9LL3NZMkVCdXBzaGU0c244aUVwbHBSc0hi?=
 =?utf-8?B?ZGd0eEtBYUtGRFZOWTlCRFJpd25EZm9HTzBFYlEyVkdHanZ3YjZ5bHZYazJy?=
 =?utf-8?B?dlY0eDE2Y3Y1VldnM2Z0VW84MmdoNUlQU0VCSENocFU0aXBtSEw2SWQ3dzdI?=
 =?utf-8?B?TCsyRmpydVdIM1ZFSkRncTRYMHVMMVpkV3ZRZXB6b0w1K240Q0h1bml5cmVk?=
 =?utf-8?B?NTNERWpQN1RIUWtSM3hicTQ2dkhEWWFBOVVObjFWakVieFZkTjF3ak1tYTky?=
 =?utf-8?B?WmpxNGtPWkdIRGNHZVA3Rm9GRERpdzRtcCtubkZjem9QN1FCL0Z3QTV6RDhH?=
 =?utf-8?B?Wnc5dDVlL1hoTWhuWGEzN3BOdWcvVWdROHVxZXJxUlFuZTQxdXFnWXljNGIx?=
 =?utf-8?B?ZmdnTDJBZDVOdkJTYWNhMUc3TExpRnNNZlIzQTc0OEFvamcvekp6cmJQU3gx?=
 =?utf-8?B?enVYd3hrSk1rM1NjNnhDeU52ZmJ1OStrZ0ttNEcvbVVJSWtPS09SajU2cUFh?=
 =?utf-8?B?TiszRTMwWmErcDVGRlVPTlBSUVlLRHpMc0dYUHJtSXpCK2x5OWRRR0tqMzJv?=
 =?utf-8?B?UWFKV3pKeHFkT2VEVlAwYzB2RW9vU1Z2NXp5N1V3alF3ZHU0S2luQ3V0WU16?=
 =?utf-8?B?Ym9pYkE5T2l2RDVaSEN3SVpabThuRFUwVkJGeDVLZi9sSUo4V1lnRWtDN0Fr?=
 =?utf-8?B?cENKRWpOU2VPeVVUWEJvZDRZZFFicVdkSkozeFR5QUE1Zm9RMnBnQWo5eXB3?=
 =?utf-8?B?eDMwSjRwSXN2VnFkTWgvSXUzQWpDR2tqd0Y2OS9URWc2MDhqV1JuS3ovRm5I?=
 =?utf-8?B?RUZLdEhzSWJEVFVKbjBZb24wQkZOREs1OTIydUhtNkwycjYwTVhmaHEvN1Fz?=
 =?utf-8?B?cTBIWlhiTE5BZ2FUcGtHbFdjaXpSVnV5SzZZVDJFTi9UZWlHMEVIR3VjclhW?=
 =?utf-8?B?ZDZNQnRQUGNYd0lFMmdDRXY4aG41NkpkUzJEdDBHUXYxOWtqbFFTZnRvSTFi?=
 =?utf-8?B?ZmM4VHkvdWxBcU55QmlZTmFGT0pMTWtHeVhlTjFYY2o0cFZ6YzBpN2MrVGJi?=
 =?utf-8?B?Y25xN2JSMmxKWmlIaWdhRFAwbENyenIwL0lWenR0SzZrN1JkZG1hU0dNNjBZ?=
 =?utf-8?B?Y1NXRjZoV0xvSDV2RXRWSWZRbEJKUlZCK2o1MnIvVkhNUnp6aVM3aUJBakti?=
 =?utf-8?B?Ym5Oa1ZibkZIUStwd0liVEQ5LzFxVVFhWlFwUnVwMlBueW1aODh4R3RJUXJs?=
 =?utf-8?B?SnRPK1c0V0hBTi8vaUFmbkEvWnRpMHhJZXlTWFdQTFdDT1VRdW5GdmhSQ21y?=
 =?utf-8?B?cUdYL1dkZ2xZRlZUTjRTaE9oc2svWUV3aXdFaGNVQjlFWHhSSkVDS0pXR0ZM?=
 =?utf-8?B?U1RHaGhZdXQzc2srNStkWnFZZTM0K0J5TVA0VlhHVldyditxNVJ6VURxc29x?=
 =?utf-8?B?Ti94czl1UElpWERNVUMxZytIZzdxSW1OREpod0liSDBmVlFIOWMvU0VuSksv?=
 =?utf-8?B?dU03MG1QckVMdmNhYWNvbjh5YjNmdERwUEJlb0lPOWtHTGhaT3VKOVU1RW1L?=
 =?utf-8?B?YjRwU3F6UjFoR1lJemF6NVpWU0k0dVE1MjdzREZnaGFkODZzVis4cTZLc3hK?=
 =?utf-8?B?T3F2ZVNteVVKNUNidFZMdDZPSStCa2svNC96RmEwY3lZV29MWDZOZFNxcVFE?=
 =?utf-8?B?UDF0THJCMENMTWwvNWRjbTVJTXJjUlRrT1JQRmVBSWM2N0hRVTJtaXE1M2N2?=
 =?utf-8?B?REUrZ2hLVVhjSllkVjVFaGlYNTl6TnBxTXFNaEl4cGZyL1RwV0JLWjlKT3kw?=
 =?utf-8?B?em5kbGVETHNKZ09zZjk0ZEVzVFJreGQxMkFaamQrZFNBNzNSNmpla2JIMlpw?=
 =?utf-8?Q?kYn3bvkYZhpcP8qAyfMU6inViDB8BmMRAPDlyb6Uvb15L?=
X-MS-Exchange-AntiSpam-MessageData-1: uTLMHYf18PXNYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1b2fba-ff32-4dbe-cf66-08da3417051b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 12:57:50.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9x/brfuWQyOj52PN2ZFhCGXqK8alcN3yWTW06dWU4w49kiSVkyq/xI6DfwfkPQpSCcWuqms6WDgaiolIMyS7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3961
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-05-12 02:03, Christian König wrote:
> Am 11.05.22 um 17:57 schrieb Andrey Grodzovsky:
>> [SNIP]
>>>>>> How about we do it like this then:
>>>>>>
>>>>>> struct amdgpu_reset_domain {
>>>>>>      ....
>>>>>>      union {
>>>>>>          struct {
>>>>>>              struct work_item debugfs;
>>>>>>              struct work_item ras;
>>>>>>              ....
>>>>>>          };
>>>>>>          struct work_item array[]
>>>>>>      } reset_sources;
>>>>>> }
>>>>>>
>>>>>
>>>>> If it's only about static array,
>>>>>
>>>>> enum amdgpu_reset_soruce {
>>>>>
>>>>> AMDGPU_RESET_SRC_RAS,
>>>>> AMDGPU_RESET_SRC_ABC,
>>>>> .....
>>>>> AMDGPU_RESET_SRC_XYZ,
>>>>> AMDGPU_RESET_SRC_MAX
>>>>>
>>>>> };
>>>>>
>>>>> struct work_struct reset_work[AMDGPU_RESET_SRC_MAX]; => An index 
>>>>> for each work item
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>
>>>>
>>>> It's possible though it makes harder to generalize reset_domain 
>>>> later for other drivers.
>>>> But still one caveat, look at amdgpu_recover_work_struct and it's 
>>>> usage in amdgpu_device_gpu_recover and in gpu_recover_get,
>>>> At least for debugfs i need to return back the result of GPU reset 
>>>> and so I cannot store actual work items in the array mentioned above
>>>> but rather pointers to work_item because i need a way to get back 
>>>> the return value from gpu_recover like I do now in 
>>>> amdgpu_device_gpu_recover.
>>>
>>> You should try to avoid that as well.
>>
>>
>> Why ?
>
> Because pointers need a lifetime. When the work items are allocated as 
> part of the structure you can be sure that they are not freed not 
> reused for something else.
>
>>
>>>
>>> What we should do instead is to cache the status of the last reset 
>>> in the reset domain.
>>
>>
>> Probably an atomic ret in reset_domain then.
>>
>> Another 2 points i forgot to ask -
>>
>> 1) What race condition you had in mind about insertion and extraction 
>> from the list if all is done under lock ?
>
> A work item is essentially a linked list and a function to call when 
> the worker thread has time to process the item. This means you now 
> have two linked lists representing essentially the same.
>
> To make it even worse those two lists are protected by two different 
> locks. The work item list is protected by the worker lock and the 
> reset item by our own.
>
> Keeping all that synced up is rather racy.


I really don't see a problem as the locking order is always preserved so 
that the reset list lock scope is around the internal worker thread list 
lock.


>
>>
>> 2) This I asked already - why you opposed so much to allocation on 
>> the stack ? I understand the problem with dynamic memory allocations 
>> but why stack ? We do multiple allocations on the stack for any function
>> we call during GPU reset, what so special in this case where we 
>> allocate work struct on the stack? It's not like the work struct is 
>> especially big compared to other stuff we allocate on the stack.
>
> The problem is once more the lifetime. When the reset work items are 
> allocated on the stack we absolutely need to make sure that their 
> pointer is not flying around anywhere when the function returns. Keep 
> in mind that a stack is just another form of memory management.
>
> It's certainly possible to get that right, but it's just the more 
> error prone approach.


I believe i got that right as at any place where the reset_work item 
life cycle ends i was always calling pending works list delete to not 
leave dangling pointers.

I guess it's all pros and cons, Yes, it' maybe more risky this way since 
it creates a risk of dangling pointers if forgetting to remove but on 
the other hand this approach in my opinion gives cleaner and more 
generic design then
the other alternative as you can see from the other problem I 
encountered with not being able to retrieve amdgpu_device pointer which 
we discuss in another thread and having to explicitly name each reset 
source in reset domain.

Andrey


>
> Regards,
> Christian.
>
>>
>> Andrey
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>> Not 100% sure if that works, but something like that should do 
>>>>>> the trick.
>>>>>>
>>>>>> My main concern is that I don't want to allocate the work items 
>>>>>> on the stack and dynamic allocation (e.g. kmalloc) is usually not 
>>>>>> possible either.
>>>>>>
>>>>>> Additional to that putting/removing work items from a list, array 
>>>>>> or other container is a very common source for race conditions.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>>>> to the cancellation list which you showed above. In current 
>>>>>>>>> way all this done automatically within reset_domain code and 
>>>>>>>>> it's agnostic to specific driver and it's specific list of 
>>>>>>>>> reset sources. Also in case we would want to generalize 
>>>>>>>>> reset_domain to other GPU drivers (which was
>>>>>>>>> a plan as far as i remember) this explicit mention of each 
>>>>>>>>> reset works for cancellation is again less suitable in my 
>>>>>>>>> opinion.
>>>>>>>>
>>>>>>>> Well we could put the work item for the scheduler independent 
>>>>>>>> reset source into the reset domain as well. But I'm not sure 
>>>>>>>> those additional reset sources should be part of any common 
>>>>>>>> handling, that is largely amdgpu specific.
>>>>>>>
>>>>>>>
>>>>>>> So it's for sure more then one source for the reasons described 
>>>>>>> above, also note that for scheduler we already cancel delayed 
>>>>>>> work in drm_sched_stop so calling them again in amdgpu code kind 
>>>>>>> of superfluous.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Andrey
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> The only difference is I chose to do the canceling right 
>>>>>>>>>>>>> BEFORE the HW reset and not AFTER. I did this because I 
>>>>>>>>>>>>> see a possible race where a new reset request is being 
>>>>>>>>>>>>> generated exactly after we finished the HW reset but 
>>>>>>>>>>>>> before we canceled out all pending resets - in such case 
>>>>>>>>>>>>> you wold not want to cancel this 'border line new' reset 
>>>>>>>>>>>>> request.
>>>>>>>>>>>>
>>>>>>>>>>>> Why not? Any new reset request directly after a hardware 
>>>>>>>>>>>> reset is most likely just falsely generated by the reset 
>>>>>>>>>>>> itself.
>>>>>>>>>>>>
>>>>>>>>>>>> Ideally I would cancel all sources after the reset, but 
>>>>>>>>>>>> before starting any new work.
>>>>>>>>>>>>
>>>>>>>>>>>> Regards,
>>>>>>>>>>>> Christian.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> You can see that if many different reset sources share 
>>>>>>>>>>>>>>>> same work struct what can happen is that the first to 
>>>>>>>>>>>>>>>> obtain the lock you describe bellow might opt out from 
>>>>>>>>>>>>>>>> full HW reset because his bad job did signal for 
>>>>>>>>>>>>>>>> example or because his hunged IP block was able to 
>>>>>>>>>>>>>>>> recover through SW reset but in the meantime another 
>>>>>>>>>>>>>>>> reset source who needed an actual HW reset just 
>>>>>>>>>>>>>>>> silently returned and we end up with unhandled reset 
>>>>>>>>>>>>>>>> request. True that today this happens only to job 
>>>>>>>>>>>>>>>> timeout reset sources that are handled form within the 
>>>>>>>>>>>>>>>> scheduler and won't use this single work struct but no 
>>>>>>>>>>>>>>>> one prevents a future case for this to happen and also, 
>>>>>>>>>>>>>>>> if we actually want to unify scheduler time out 
>>>>>>>>>>>>>>>> handlers within reset domain (which seems to me the 
>>>>>>>>>>>>>>>> right design approach) we won't be able to use just one 
>>>>>>>>>>>>>>>> work struct for this reason anyway.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Just to add to this point - a reset domain is 
>>>>>>>>>>>>>>> co-operative domain. In addition to sharing a set of 
>>>>>>>>>>>>>>> clients from various reset sources for one device, it 
>>>>>>>>>>>>>>> also will have a set of devices like in XGMI hive. The 
>>>>>>>>>>>>>>> job timeout on one device may not eventually result in 
>>>>>>>>>>>>>>> result, but a RAS error happening on another device at 
>>>>>>>>>>>>>>> the same time would need a reset. The second device's 
>>>>>>>>>>>>>>> RAS error cannot return seeing that a reset work already 
>>>>>>>>>>>>>>> started, or ignore the reset work given that another 
>>>>>>>>>>>>>>> device has filled the reset data.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> When there is a reset domain, it should take care of the 
>>>>>>>>>>>>>>> work scheduled and keeping it in device or any other 
>>>>>>>>>>>>>>> level doesn't sound good.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Lijo
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I'd put the reset work struct into the reset_domain 
>>>>>>>>>>>>>>>>> struct. That way you'd have exactly one worker for the 
>>>>>>>>>>>>>>>>> reset domain. You could implement a lock-less scheme 
>>>>>>>>>>>>>>>>> to decide whether you need to schedule a reset, e.g. 
>>>>>>>>>>>>>>>>> using an atomic counter in the shared work struct that 
>>>>>>>>>>>>>>>>> gets incremented when a client wants to trigger a 
>>>>>>>>>>>>>>>>> reset (atomic_add_return). If that counter is exactly 
>>>>>>>>>>>>>>>>> 1 after incrementing, you need to fill in the rest of 
>>>>>>>>>>>>>>>>> the work struct and schedule the work. Otherwise, it's 
>>>>>>>>>>>>>>>>> already scheduled (or another client is in the process 
>>>>>>>>>>>>>>>>> of scheduling it) and you just return. When the worker 
>>>>>>>>>>>>>>>>> finishes (after confirming a successful reset), it 
>>>>>>>>>>>>>>>>> resets the counter to 0, so the next client requesting 
>>>>>>>>>>>>>>>>> a reset will schedule the worker again.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>   Felix
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Additional to that keep in mind that you can't 
>>>>>>>>>>>>>>>>>>> allocate any memory before or during the GPU reset 
>>>>>>>>>>>>>>>>>>> nor wait for the reset to complete (so you can't 
>>>>>>>>>>>>>>>>>>> allocate anything on the stack either).
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> There is no dynamic allocation here, regarding stack 
>>>>>>>>>>>>>>>>>> allocations - we do it all the time when we call 
>>>>>>>>>>>>>>>>>> functions, even during GPU resets, how on stack 
>>>>>>>>>>>>>>>>>> allocation of work struct in 
>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover is different from any other 
>>>>>>>>>>>>>>>>>> local variable we allocate in any function we call ?
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I am also not sure why it's not allowed to wait for 
>>>>>>>>>>>>>>>>>> reset to complete ? Also, see in 
>>>>>>>>>>>>>>>>>> amdgpu_ras_do_recovery and gpu_recover_get (debugfs) 
>>>>>>>>>>>>>>>>>> - the caller expects the reset to complete before he 
>>>>>>>>>>>>>>>>>> returns. I can probably work around it in RAS code by 
>>>>>>>>>>>>>>>>>> calling atomic_set(&ras->in_recovery, 0) from some 
>>>>>>>>>>>>>>>>>> callback within actual reset function but regarding 
>>>>>>>>>>>>>>>>>> sysfs it actually expects a result returned 
>>>>>>>>>>>>>>>>>> indicating whether the call was successful or not.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> I don't think that concept you try here will work.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Also in general seems to me it's cleaner approach 
>>>>>>>>>>>>>>>>>>>> where this logic (the work items) are held and 
>>>>>>>>>>>>>>>>>>>> handled in reset_domain and are not split in each 
>>>>>>>>>>>>>>>>>>>> adev or any other entity. We might want in the 
>>>>>>>>>>>>>>>>>>>> future to even move the scheduler handling into 
>>>>>>>>>>>>>>>>>>>> reset domain since reset domain is supposed to be a 
>>>>>>>>>>>>>>>>>>>> generic things and not only or AMD.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Andrey
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>>>>>>> Christian.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Signed-off-by: Andrey Grodzovsky 
>>>>>>>>>>>>>>>>>>>>>>>> <andrey.grodzovsky@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu.h | 11 +---
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 
>>>>>>>>>>>>>>>>>>>>>>>> +++--
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 73 
>>>>>>>>>>>>>>>>>>>>>>>> +++++++++++++++++++++-
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 3 +-
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 7 ++-
>>>>>>>>>>>>>>>>>>>>>>>>   8 files changed, 104 insertions(+), 24 
>>>>>>>>>>>>>>>>>>>>>>>> deletions(-)
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>>>>>>>>>>>>>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>>>>>>>>>>>>>>>>>>   #include "amdgpu_ras.h"
>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>     #define MAX_GPU_INSTANCE 16
>>>>>>>>>>>>>>>>>>>>>>>>   @@ -509,16 +510,6 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_allowed_register_entry {
>>>>>>>>>>>>>>>>>>>>>>>>       bool grbm_indexed;
>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>   -enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>> - AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>> -};
>>>>>>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>>>>>>>>>>>>>>>>>>       u32 codec_type;
>>>>>>>>>>>>>>>>>>>>>>>>       u32 max_width;
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -5201,6 +5201,12 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>> tmp_vram_lost_counter = 
>>>>>>>>>>>>>>>>>>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +    /* Drop all pending resets since we will 
>>>>>>>>>>>>>>>>>>>>>>>> reset now anyway */
>>>>>>>>>>>>>>>>>>>>>>>> +    tmp_adev = 
>>>>>>>>>>>>>>>>>>>>>>>> list_first_entry(device_list_handle, struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device,
>>>>>>>>>>>>>>>>>>>>>>>> + reset_list);
>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>>>>>>>>>>>>>>>>>>       /* Host driver will handle XGMI hive 
>>>>>>>>>>>>>>>>>>>>>>>> reset for SRIOV */
>>>>>>>>>>>>>>>>>>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>>>>>>>>>>>>>>>> @@ -5296,7 +5302,7 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_job *job;
>>>>>>>>>>>>>>>>>>>>>>>>       int ret;
>>>>>>>>>>>>>>>>>>>>>>>> @@ -5304,7 +5310,7 @@ struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>>     static void 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base);
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_recover_work_struct 
>>>>>>>>>>>>>>>>>>>>>>>> *recover_work = container_of(work, struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_recover_work_struct, base.base.work);
>>>>>>>>>>>>>>>>>>>>>>>> recover_work->ret = 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>>>>>>>>>>>>>>>>>>> recover_work->job);
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>> @@ -5316,12 +5322,15 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_gpu_recover(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev,
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_recover_work_struct work = 
>>>>>>>>>>>>>>>>>>>>>>>> {.adev = adev, .job = job};
>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&work.base, 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&work.base.base, 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&work.base.node);
>>>>>>>>>>>>>>>>>>>>>>>>         if 
>>>>>>>>>>>>>>>>>>>>>>>> (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>> &work.base))
>>>>>>>>>>>>>>>>>>>>>>>>           return -EAGAIN;
>>>>>>>>>>>>>>>>>>>>>>>>   - flush_work(&work.base);
>>>>>>>>>>>>>>>>>>>>>>>> + flush_delayed_work(&work.base.base);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>> &work.base);
>>>>>>>>>>>>>>>>>>>>>>>>         return work.ret;
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>>>>>>>>>>>>>>>>>>> *amdgpu_reset_create_reset_domain(enum 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_d
>>>>>>>>>>>>>>>>>>>>>>>> atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>>>>>>>>>>>>>>>>>> init_rwsem(&reset_domain->sem);
>>>>>>>>>>>>>>>>>>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_init(&reset_domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>       return reset_domain;
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>   diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>>>>>>>>>>>>>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>>>>>>>>>>>>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>>>>>>>>>>>>>>>>>>   -#include "amdgpu.h"
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/atomic.h>
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/mutex.h>
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/list.h>
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/kref.h>
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/rwsem.h>
>>>>>>>>>>>>>>>>>>>>>>>> +#include <linux/workqueue.h>
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_device;
>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_job;
>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_hive_info;
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>>>>>>>>>>>>>>>>>> AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>> +enum amd_reset_method {
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_NONE = -1,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_LEGACY = 0,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE0,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE1,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_MODE2,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_BACO,
>>>>>>>>>>>>>>>>>>>>>>>> + AMD_RESET_METHOD_PCI,
>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method method;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>>>>>>>>>>>>>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>>>>>>>>>>>>>>>>>>       unsigned long flags;
>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>   +struct amdgpu_reset_control;
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>>>>>>>>>>>>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>>>>>>>>>>>>>>>>>>       struct list_head handler_list;
>>>>>>>>>>>>>>>>>>>>>>>> @@ -76,12 +100,21 @@ enum 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_type {
>>>>>>>>>>>>>>>>>>>>>>>>       XGMI_HIVE
>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>   +
>>>>>>>>>>>>>>>>>>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>>>>>>>>>>>>>>>>>>> +    struct delayed_work base;
>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head node;
>>>>>>>>>>>>>>>>>>>>>>>> +};
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>>>>>>>>>>>>>>>>>>       struct kref refcount;
>>>>>>>>>>>>>>>>>>>>>>>>       struct workqueue_struct *wq;
>>>>>>>>>>>>>>>>>>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>>>>>>>>>>>>>>>>>>       struct rw_semaphore sem;
>>>>>>>>>>>>>>>>>>>>>>>>       atomic_t in_gpu_reset;
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +    struct list_head pending_works;
>>>>>>>>>>>>>>>>>>>>>>>> +    struct mutex reset_lock;
>>>>>>>>>>>>>>>>>>>>>>>>   };
>>>>>>>>>>>>>>>>>>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_put_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *dom
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     static inline bool 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_schedule(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>> - struct work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +    if (!queue_delayed_work(domain->wq, 
>>>>>>>>>>>>>>>>>>>>>>>> &work->base, 0)) {
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> +        return false;
>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + list_add_tail(&work->node, 
>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works);
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +    return true;
>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain,
>>>>>>>>>>>>>>>>>>>>>>>> + struct amdgpu_reset_work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&work->node);
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +static inline void 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_pending_list(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *domain)
>>>>>>>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_lock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>> + list_for_each_entry_safe(entry, tmp, 
>>>>>>>>>>>>>>>>>>>>>>>> &domain->pending_works, node) {
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + list_del_init(&entry->node);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> +        /* Stop any other related pending 
>>>>>>>>>>>>>>>>>>>>>>>> resets */
>>>>>>>>>>>>>>>>>>>>>>>> + cancel_delayed_work(&entry->base);
>>>>>>>>>>>>>>>>>>>>>>>> +    }
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + mutex_unlock(&domain->reset_lock);
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>>>>>>>>>>>>>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>>>>>>>>>>>>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>>>>>>>>>>>>>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>>>>>>>>>>>>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS (1 << 
>>>>>>>>>>>>>>>>>>>>>>>> 0) /* vBIOS is sr-iov ready */
>>>>>>>>>>>>>>>>>>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV (1 << 1) 
>>>>>>>>>>>>>>>>>>>>>>>> /* sr-iov is enabled on this GPU */
>>>>>>>>>>>>>>>>>>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>>>>>>>>>>>>>>>>>>       uint32_t reg_val_offs;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src ack_irq;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_irq_src rcv_irq;
>>>>>>>>>>>>>>>>>>>>>>>> -    struct work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_mm_table mm_table;
>>>>>>>>>>>>>>>>>>>>>>>>       const struct amdgpu_virt_ops *ops;
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_vf_error_buffer vf_errors;
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>   @@ -380,7 +380,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>> @@ -389,6 +390,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_ai_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     static int xgpu_ai_request_init_data(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>>>>>>>>>>>>>>>>>>   @@ -407,7 +407,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>> @@ -416,6 +417,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_nv_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>> diff --git 
>>>>>>>>>>>>>>>>>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>>>>>>>>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>>>>>>>>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>>>>>>>>>>>>>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>>>>>>>>>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct 
>>>>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> -    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> +    struct amdgpu_virt *virt = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(work, struct amdgpu_virt, 
>>>>>>>>>>>>>>>>>>>>>>>> flr_work.base.work);
>>>>>>>>>>>>>>>>>>>>>>>>       struct amdgpu_device *adev = 
>>>>>>>>>>>>>>>>>>>>>>>> container_of(virt, struct amdgpu_device, virt);
>>>>>>>>>>>>>>>>>>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>>>>>>>>>>>>>>>>>>> @@ -610,7 +610,8 @@ int 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_get_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>           return r;
>>>>>>>>>>>>>>>>>>>>>>>>       }
>>>>>>>>>>>>>>>>>>>>>>>>   - INIT_WORK(&adev->virt.flr_work, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>>>>>>>>>>>>>>>>>>> + INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>>>>>>>>>>>>>>>>>>         return 0;
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>> @@ -619,6 +620,8 @@ void 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_mailbox_put_irq(struct amdgpu_device 
>>>>>>>>>>>>>>>>>>>>>>>> *adev)
>>>>>>>>>>>>>>>>>>>>>>>>   {
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>>> + 
>>>>>>>>>>>>>>>>>>>>>>>> amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>>>>>>>>>>>>>>>>>>> &adev->virt.flr_work);
>>>>>>>>>>>>>>>>>>>>>>>>   }
>>>>>>>>>>>>>>>>>>>>>>>>     const struct amdgpu_virt_ops 
>>>>>>>>>>>>>>>>>>>>>>>> xgpu_vi_virt_ops = {
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>
>
