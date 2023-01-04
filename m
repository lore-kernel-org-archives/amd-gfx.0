Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27855C46467
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 09:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE30B10E051;
	Wed,  4 Jan 2023 09:17:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D14710E051
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 09:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqfBFlVXcBhpSdIumGXgUMrmXn3BlF7q4fpwCB3pNvck0BfEN09bN89ESJKXPtpnGiUV068Vle9cp+z/f5iRGcvsGQgW/QsLz1Z5dH/KtBi7I/HeKiwY5kw7Wq8OpI9RkJSb1m51ojsUTXOrMSMFR/0WF5uirjwp9/GEB4OUrSKtimV1xLPczIIF9kLmOq7iWS6S8tutx75rOujRa4fxhnIr75Kny2qX6PJ6tIr+eNDe09/6FgaksyLwlidQwnBvZm53vKQj1mBEk0YXUBcbrT/mp1c9jmgNgUBAEbyMrkQZ+vAW5kIjkrY4wLA5Y3wFIJVAlyfB8vEWmW/0OLH6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uajFSCUielWlTII5BrYAospbXmx75p77Eq1gnApQD9c=;
 b=M/1WHGWfMgAeK//BzEQY5E+nMDU1MwJdmwLREZvM3ZWqtSlqDSQ/NMHfxzsE9pPGvJ3WBrTiz8U9GVejWwDZzZo/U0ZHq884IRWQI+hIlDk9We6UoGrOcDppsYOJy96q/s7Cr5o/ybbuFhtTqrCbVghtzrLPK+bHOi/iX9qXP072aCGTPgTgfOZ3hvJe5I6xF85+b7HEDEbYv65v6Ng7jhHQ6Aw9nq0qA95JPImTlR+q6WiksxEbMChr7cELIAzRq+0Z5RJK3TEVsuX6mEf9P802T82vgsFf4OiAA/ZNQzRnP9hnlzt82QiGyX1+KKu5HyMFZyUHZ6SB3XvIXtEhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uajFSCUielWlTII5BrYAospbXmx75p77Eq1gnApQD9c=;
 b=uneU4ZOZKY03dy+GZK+Zk90gAab4UpgPmroDO01ZcTuxStytRiigesRJJ4xGCzExdts7hhy5FBR5/H5oQPlbwaGhPAdqqS0EUPpycWX7S7DC/9gFkUweDbB7JW0URss801TeC3kNLUrBbfkt+nbV1QpZ5AOtmb99H56vm69/ro8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 09:17:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 09:17:50 +0000
Message-ID: <8b00b4b7-640d-4a85-b98f-8fd2a277bea5@amd.com>
Date: Wed, 4 Jan 2023 10:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 "Yadav, Arvind" <arvyadav@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
 <a168df59-8cd3-0262-473a-c4b5f63dc491@amd.com>
 <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ced7bb3b-6de2-145c-ccfd-1143529f0990@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL0PR12MB4865:EE_
X-MS-Office365-Filtering-Correlation-Id: 96436028-22b0-4c11-3a57-08daee348d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7+tBjIS6rwXkokr2angJYIOVCzSv8+HX0w20YrJ28QkQeQxBJDr/rpjrxB1+KerEwgJOVCQQR+aCAsJ/idjakDyZLb2CawXkrgrpBNpKGmSyXS320HeyZuTx+qAzFD537DjAb2RWDki7wf6kj8qpM9v0fLGKEFlZa7Vhop6XzeNj6zJWqo2Wd1TErtLiognjh/d7Bgm9XotxPuYfiAKWC+6GupEjbIz47cHmj+UxMmhV8GR3Z3GwhYwR2g5Z4KSCZ1WMB03C6sqNuB2rNuZxHairNHFRPL7ONH8EAzgiawsQoGUAtwAah6c6ef+P3OJNfe97Tr5jODv3fzo/G65W9jMio83ipplVFTdjrCi4BYPz3H3QC3Hj20eoDMfABCaqpC7Jm+BSK0NCB6n2w4UhFpjnL7OpwumYKbTlogm0Z0P1GAnIIEbukMZ58AEQXWOwOHIQOBSH42BQt7TRf0xsIyYx0GtyHt4lJnLc+kFBm2dsC0MKRFCdndeIKyf7m89ZpC4f5lFpeTxebPfdUID4ot+zD/Mzyu92dUPVJygmIUweCBqEO0+7e/743HMDKzDJ8bLYNXLt61x8z89J0Ojg80NN5oe/SDCaoayvdr+3Pp5tl2aDr14x8PAdFHE/AbH6FsmMVU6yNNYe1SJOeZCWexVsiU7J3J5qhHA2o6y36cbnH+NlJX9EJpOFdgdRaDb+yYGei7me02lgQOJv7OwJvJi8skeS6UBqf0GMXkfq5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(53546011)(6666004)(478600001)(36756003)(110136005)(86362001)(31696002)(38100700002)(66574015)(6512007)(186003)(26005)(83380400001)(6486002)(2616005)(5660300002)(31686004)(8676002)(66556008)(66476007)(66946007)(8936002)(4326008)(316002)(41300700001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFQrazdtdlR0ZWxsdGQxRnFqVVdKdG9raFJpbFFOK2dwRDVyVEk4ZUtoY3Zt?=
 =?utf-8?B?ZlBYVjZjRVUrdjR3aUxsM0QvaE5RVXo0dzRnWHRIQ1I0c0dBdXM0eVNuZXgz?=
 =?utf-8?B?ZFB0VnJyTzBWQjdZL1ZZekpEWlB4YStWaTFLNWtTc0RMeXl1dDdBOWpZYjZK?=
 =?utf-8?B?VXdyaVFsWnNUR2FIQy9wODdCdXJPUnhkbzBKeE1tUGdnWXdvRkdoL2w3ZG9K?=
 =?utf-8?B?Y2pIM3BoMWI4T2p4OUViUWVHR1hUeUMyU3Z5WlpwdHFEbmhBWEtQWG9VWXJY?=
 =?utf-8?B?Ty9tZExtRjZpUURiRXhza250ci9KaUs2OU1sM0FvSHNIbDMzdEMyT0tQRE5L?=
 =?utf-8?B?NGlhRExSSStxQXhpd25tNWE3Rkx6YXFiYnQ4YVlFU3phV3cveUVZVVFhVzNk?=
 =?utf-8?B?bVkyRHcyd294Y0dvSForOU4xekRBNVJObldxdFp6d0R6YkhJMHdIdlhSSURx?=
 =?utf-8?B?dDNibjFCN0lMUUwwSHpjd3lBS2lTRXR4bW5aVTJDZTF0SU03WHhTc1BqQUto?=
 =?utf-8?B?dEdWRTA5WXZ4S3BBTXpVSStTbEpBcVBNZ2NiSXJDMGhIS2F3cFNiYlRoY241?=
 =?utf-8?B?NTRLOGNselNzOEo3SG9LWW1pUWJLNG9pK0V5RGVEWHd4cjBUV1dsWVZDRUNR?=
 =?utf-8?B?UVkzcm9SdW1hbWY3d2ZEV0ZwYjhPWktyc05zKy9IUGNvN2c2ZGU2Qnk4R1JM?=
 =?utf-8?B?alRTNk1VNnYwYUt5T3IzVkdwZ01iS1BTaTd5dzJ5cVdNTmxnTVZtRE0rS05s?=
 =?utf-8?B?cHU2eFF1YkZyNVBqKzdVbXlZVWx2aW1JcStscFc0YnNhSkEyUkNRa0dCamxm?=
 =?utf-8?B?WVlVeGpYeFhuOTR0OUNUVGR1M3MyLzdqaytkMHVKMVFadWhCei85cDdtTTM5?=
 =?utf-8?B?K1UwNlg3RmI0bDNRTjlOcUh1b283ZWh3MjFEdmR1U3NPZW9zblZnYnFiQTJz?=
 =?utf-8?B?bThBZWFlckZmZjd3MnFsK09iaTBzeWJCb29zTSs2TWUrU1RvdVhIbGRjR1Jt?=
 =?utf-8?B?QUNDa0xQTkhJbkxhZU9JSlhXQnJMd0ZiKzhCRDZNSjBPaG1lMVFpZ1BJRktR?=
 =?utf-8?B?Q1QrR0c5Y0JqSVlEVmhpUlRCbzV0TmlOWWNnSG9QbEdGTUdZUEtqVmVnOHVX?=
 =?utf-8?B?WEpMa1I2REhCVnFWS01mOHJyL0luZ3dlMjlRb1VxRjl1akpSWW9mcFhlcWJI?=
 =?utf-8?B?SVdnYWhUblRZU2RwdENYbUg4bFBEbjkwQ2FKdnB0d3ptNzQxeWxoUTg5RW9T?=
 =?utf-8?B?ZHlCVzBUNzNPM0ZzVWdUUEZ4THA4eHBIR1ZsOGJ5THdqUDd1c0phV0hNdUxn?=
 =?utf-8?B?bGQ5c1Jram5PTDVOYnhOdUtIWFA1ck9STnJhbHU3d2FOVm81RVByaU52a1Ra?=
 =?utf-8?B?NDZkVjh3OTNtbEh1VjRseWt1d3h5MXIxbVhQaVBEQVhnejFrQkZ6c0tQWHZk?=
 =?utf-8?B?NE1EZlJzQXZFT3FxZTRGSWFMTE1sNFZtOW9pNkZ4YnM2TjZMOTNscWlJbjI5?=
 =?utf-8?B?Zk5KTytBWDhaaFd6a2ViejM3YU1SVEJLUG5oaFdLMi9XZzFNcVI5T3h2a3BN?=
 =?utf-8?B?akdsSGFINmVla3ZFQktRTWV4QTBNeEVER0lwMlBpWGZVSDhBYTRiL01zY2xF?=
 =?utf-8?B?TnNMbkZ1Ri8ySHk1ejhiZUpaRlN5OE85bURlTjZmRGx2TW1yQzNhWGtSUVVU?=
 =?utf-8?B?ci93bCs3TTkvR1N6dTQwN2dMUDVJZ1lDRkVHZ1hkeGdXblh0YmZTT20xeU9U?=
 =?utf-8?B?WitlM0xoNDQ4T1VwZHNUSVRlZ1hueUhtaW85VmxEUkdNc0ovMGlZZkVpRy9o?=
 =?utf-8?B?dFdBL2VmWXdJTjY5NDk3d1lhZWU0U0hVc25BVHFOZ0RLNm5UTnlFOHJ6Rm05?=
 =?utf-8?B?RU9GMGI5UDRXYyt0YStjOEtzWHBqZE5JNXFsY1c1THpVeU9YdFlCZEs5d2ty?=
 =?utf-8?B?RitNQmRPWkJtKzN3NXUzbkF5M1dwc3dPTWlQOGpFMDlJZ2xZa2R2REFUbEFX?=
 =?utf-8?B?ZDRXM2pydXFsYzh4U1RWR1N4ekVwVnRQZENDMzJoTzZQTWR2dlBMa29vcHEy?=
 =?utf-8?B?RFA5ZFlCQlNmZ2d1N29tRWlmSG5XUHdjcWFxYzloOVVUcjAwT3JsRy9MbXFJ?=
 =?utf-8?Q?ZF9/GWZ0us2wZmSXcyPSYRRxW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96436028-22b0-4c11-3a57-08daee348d92
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 09:17:50.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIIKMpX57u4uTQ1nJx7cMoq9kd23xEO8NHiCsdMfTvDIUB38lNSYo729EIu3wV3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 arvind.yadav@amd.com, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.23 um 10:13 schrieb Shashank Sharma:
>
> On 04/01/2023 10:10, Christian König wrote:
>> Am 04.01.23 um 07:21 schrieb Yadav, Arvind:
>>>
>>> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
>>>> Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
>>>>>>> /*MQD struct for usermode Queue*/
>>>>>>> +struct amdgpu_usermode_queue_mqd
>>>>>> This is specific to GC 11.  Every IP and version will have its 
>>>>>> own MQD
>>>>>> format.  That should live in the IP specific code, not the generic
>>>>>> code.  We already have the generic MQD parameters that we need from
>>>>>> the userq IOCTL.
>>>>>
>>>>> Noted, we can separate out the generic parameters from gen 
>>>>> specific parameter, and will try to wrap it around the generic 
>>>>> structure.
>>>>>
>>>>> - Shashank
>>>>
>>>> Is there a reason why you can't use "struct v11_compute_mqd" from 
>>>> v11_structs.h?
>>>
>>> Hi Felix,
>>>
>>> Yes,  V11_compute_mqd does not have these below member which is 
>>> needed for usermode queue.
>>>
>>>     uint32_t shadow_base_lo; // offset: 0  (0x0)
>>>     uint32_t shadow_base_hi; // offset: 1  (0x1)
>>>     uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>>>     uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>>>     uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>>>     uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>>>     uint32_t shadow_initialized; // offset: 6  (0x6)
>>>     uint32_t ib_vmid; // offset: 7  (0x7)
>>>
>>> So we had to add new MQD structs.
>>
>> Would it make more sense to update the existing MQD structures than 
>> adding new ones?
>>
> Imo, It might be a bit complicated in the bring-up state, but we can 
> take a note of converting this structure into a union of two, or may 
> be renaming it into a superset structure.

Union? Does that mean we have stuff which is individual for both 
versions of the struct?

BTW: Could we drop the "// offset:" stuff? This could cause problems 
with automated checkers.

Christian.

>
> - Shashank
>
>> Regards,
>> Christian.
>>
>>>
>>> thanks
>>>
>>> ~arvind
>>>
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>

