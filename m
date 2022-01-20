Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1693C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 14:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBD210E374;
	Thu, 20 Jan 2022 14:10:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE0410E374
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 14:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4S+XeUiOxZ9rAaumC6ZUknL5vib0tUMqB9Fk4YsS80IUKncG63dCxjCtaECpU/moyZnuF8nVqHYnP3v6gl6HOvR0HkIQ6XqrhCCfaGNQlXx7abCgqK24aOH99kl2xoQGRrqIQGVJB1t2M7xPiipvdG0nbrGJTuyuwqosLKgoW0zLUrJAFGHANzdo6VT3dIL06m/LV865eXJoFTwnpcMX8tcasFBQOcsqtybroQhqc63hsZNpATdMrwh7u3Lx9nLzFyLgwO6LcsKXwEA8YMlZfVWbbyytP4Gn6ap1z9Ja8FBMvT5Br0fGmj6GeG5Q4Z42l0oOJ0dlJpOgsZi01Ygkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScTGRhKoTscAgfUYGjpZpAfFNwgfgM3KnjmUdV5txrM=;
 b=ZDD8Z2pL4q9veLz5qn5C14TE3NaOHge/b3fGZqe30GKO9hEc1McroK5qtnHhmcufZsIulzqlfdypoCCVflaffBgEqOmcQ+0lTgooQ7uzTTxl671R6sGGFShZp74ZwjRCSztnc6+7RHZjfj0izJtQhksZhyW/66I5B66ppsuCM6vkey/DhV29ag0aS98wwtqnnSb7HGMH4ifkxkPZmM7xktpmE8MBiT3NroKPdDAUspf/sBMm6bZ4QonwOhnpj7wyNB3lJAJ7Gt7R19OH5iitEoFPKk6RQF3BQcDByROd9Igi4MBZOafhAly1c6e53T1WRycvlquIaYrvKs6OyCfN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScTGRhKoTscAgfUYGjpZpAfFNwgfgM3KnjmUdV5txrM=;
 b=z0iIrQkoJcN6lmOmy8LpM3CldyXtRczqxR9jNWV1km80groydumdHwMuid/Y5fuqvDbbuRcqw3FWIZm9Y5zkOPPMZU5zHw5s6O6/tB6Skt40QINLNpsPK2+R7yInTmb+ozyQx0RwjdMwCIKIDHV0osBcvZg/PFf+Zb+uO9ciCtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 14:09:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 14:09:59 +0000
Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220118120157.102453-1-christian.koenig@amd.com>
 <DM5PR12MB24692C6D246264672211B712F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <99b919b4-97df-16bc-46c2-682bc03117f4@gmail.com>
 <DM5PR12MB2469F71C6D7237AA6CC28B37F1589@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB24693B64F61260F9F28B326DF1599@DM5PR12MB2469.namprd12.prod.outlook.com>
 <4fce003f-e00f-d3ff-6523-fceb06df57ed@amd.com>
 <DM5PR12MB24697899BB92BEA2E87993BCF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <88ed5995-22e3-52a6-c531-c7386a03bb86@amd.com>
Date: Thu, 20 Jan 2022 15:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM5PR12MB24697899BB92BEA2E87993BCF15A9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0100.eurprd03.prod.outlook.com
 (2603:10a6:208:69::41) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bedb26fc-5c17-4539-bc39-08d9dc1e8b00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4128113CF100AB1F7F359FD8835A9@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zz5KMRifH2gJi1DQHUKZ80pvRvQKCH2bsFGOptNIAdBS+enIkp+f2kCyroOR8jJloWjShWaHtoRgsqD8sMjcrvnKQaKX/3j4Rj7No9YKK3TnP5a+yDx69reJbFsw86FAa8a0jopuhEJX/xl8EGPYmkILmFg2cFh4v6qFpxEZILFUEyeMxwfRfSsodcFSUePikiqzGg5OmPppNVvc/vVQhyfwT0BvnQ2Kgdduuv/dn9rZR8GGf+vPkdRI0P07E6+Cv2aBaWaJ84zEe8MLi64lMUqFMemnSGvOWJq8rcNgnUj4PJXq+Uh2cWHU8RM2p4t+WGJJTyfwLi7K019TQX63aQ3lvZPkcInadFW1IqJ0/bvBXJPX0aV2ZUCZKLBjMBCkNp0Bb0aKHebbwMvTDOyfncf/PzdJPK6sdXNqP2PX3nH50kQjK+TFGeusIcvFGhBW8JPPT7p6xO2Iw58VmKRdmdUrx/qw33uvv1iZDwYmQxr8Nct+LzDmlMqNuyudcrj58mnefSstHW7L/crUb8jMtS15zhtWORR8EQO/KlZ54ZQaXz+EfDcescu/n/R0t2+t+pieh2nbalYnxL8ySU4qIM4yefhsGjiB7m6zU4mvHZ4IJB2WLWcNvUhfrtfO84tWPWDm1eHqLCrgo65d6FzvOLOYszF87e8gr/9mEzexYbr3Wqnn9Ao/6NA/6N2VXJpFkoZ3qCwCyWC5AIKZcb4YdjYYS7T9djH2eo+XnJhsiR6iEt9ZzmiG1OQ0ySPnz1Fu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(8936002)(110136005)(2906002)(6506007)(66574015)(66476007)(508600001)(8676002)(53546011)(186003)(26005)(30864003)(316002)(36756003)(83380400001)(31696002)(66946007)(66556008)(2616005)(6486002)(86362001)(6666004)(31686004)(6512007)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a245QVROUXN4TjRSZ0ZFZEQvbHp2bllweTFTWE8vbmJtYmhxVytRbTBpekdQ?=
 =?utf-8?B?TzVFUTZuRXBUQWVGUFRDaFJyZGpmWkF2aW5sS096VDNLLzZwTEF6aFJjUXUy?=
 =?utf-8?B?aTdYVFJnYTd2Z3dZUTdaazNZZk05azhQZGJhSml1TEFJcW1ndGc3c1AwNXZ6?=
 =?utf-8?B?WHZrRCtZSGNKRWo4NEtkY3lxNncvbStvWjUrS3l5RnRPUUNQbW9IejRmSDJU?=
 =?utf-8?B?azFjSGlJOTc3Wk5QMkN0cFp4RUJ1L0kxeTBhTStGV0pUa0tPTXpLT3RvNUxv?=
 =?utf-8?B?bnphWWtoUk5yNUFDenZMTjdMMjVJTDdTR2VvbDlQUlNzNXY4Z25TcC95c29o?=
 =?utf-8?B?M3FhZ3FLRThsdUJrMCsyc2ozNXlSWER6amt2aUk3dE9jZ05id3grYWQ3MDVj?=
 =?utf-8?B?dmFWR05OdHd4ekhkVjZlRnlFQTJxWk1OdWJoRnFUeHV0TlI0KzBEMmU0cDZR?=
 =?utf-8?B?bldrWFRQbDJhMllIN20zV1F5ekZrRHFkNGI0UWIrOWxmSzBHcnF4VmpwcWVD?=
 =?utf-8?B?RWtaU1NMZkUwVjVIdVRMVzFjZ1hzaUdPbkNSNmt1NW9DQkJsaGoydVFaMUxv?=
 =?utf-8?B?VXBYcko1Ylp3UDdvUTk3ZTlZa0owb1dPMzNIeHhLNHpJL3VjbW9YTUxkY2pj?=
 =?utf-8?B?c2pyK3ZaRG50cGp4T3NjMjh0SUlRL2RkRExyaFNST1ZyRkNnb3BDSXErbGlM?=
 =?utf-8?B?M0todFJUUWgvUWx5ODZObzNsNVY1dkFhUEc0djd6MThrOE5Pcm5lMVI3NTRm?=
 =?utf-8?B?czB6UzRFNmtDVTRSUzFjTy85TjZmaVhjTHJ5WVJtVTVCM1BoczJsOFV1bVJl?=
 =?utf-8?B?UHBWSS8rQlVQMGNydXVvK0JXcFEwT25YWFVOM0R0dkcwQjB4R2FtQWdhWWgv?=
 =?utf-8?B?aTBEY3VtTHREV2JsTkcrYVZ1SlNZY3VUZlFYekhMTXBYa3AzaG13L1hYUnZq?=
 =?utf-8?B?bWdoQUh2aFVnZk8vVitETW1kMkFuZ1Z4NE5zN0RYM0xiMnhEQldMQno4SFdU?=
 =?utf-8?B?aUIwdEkvR0JZNm1WVFlhcllsNGNVK0FhUzFvcElUc0UxbnJmallWazVueEc4?=
 =?utf-8?B?ZTdTaVZRMGFjTjQ5ZUdLV1BQZXFDUUNyeWMzbUZ5OUliY2IrL1kzUDRiRmVa?=
 =?utf-8?B?Y05uNEViTDNrbHVqdTgvM1NBVU0vTlZwS3ZPMko5QU1PL2oxeHFDMER0MVpU?=
 =?utf-8?B?WTFrOVZIdXZpT3pnamljaUN3VDVlY041aHFMSnVLbEZOV0IxaWJOZE9peVdE?=
 =?utf-8?B?bTFNd3VjbnVlMk1ST09GMGw0UmJ6NnFwQmJReDlKV3Job3EyWmxIcnR5SXNi?=
 =?utf-8?B?cU1lVUFQUXJ3UERDLy9ONGZYVUFlMGdLQTFsTGJjbDRPRGxOLzYwODc3dGsv?=
 =?utf-8?B?ZmFkYzF5U04zMlZlOEFKQjgvb2cyVFBBU0NBekdXT1pNMHV2cXNQeEtqMnBv?=
 =?utf-8?B?Ulk0SkNzMDhEMUV1MXFKWW9kZk9kQ1ZWalI0OEhTdVNSckxqY1ZiUmU4czRs?=
 =?utf-8?B?enYxNUo0NXo3R0FiQXJOWnpKMHpBUWpEN0VWMkRrOGg1RmZ2MXlaYzZUUjU3?=
 =?utf-8?B?MFFJRkZvckRmTnN0Ukt4ZHhIRENEMDNEazBHRm5LZnNjaEJkeFRlNUlDV01P?=
 =?utf-8?B?cVZPR1BJV2V5R0FKZnprZ24vTDdtR1phRGxRS0l4S00weGszQXlxM0NMOSts?=
 =?utf-8?B?Yk5WRGdDUmt4ZGtieDNYMUh3bXlSQmxESGdZZ0ZnSENMa09oV05XQ1BXdFlx?=
 =?utf-8?B?T0pmdnQrSllGZXdZT2g1RVRybnlpZzdBWlBoOHBZcUZSM0RSNjM5K2pMT3dh?=
 =?utf-8?B?Mm8zZU5MSDZKcWhxOC9WWTFTQW4wYlY4c29FRFNmaDg0S1VyY0w2MVFHbVg4?=
 =?utf-8?B?RHFidmpLN0NWTUJ0WFB3NCt1RStIY0RRZTNuamdJNUNxaXdvVk95aFFtRTU2?=
 =?utf-8?B?Ym40TWRhaW9DcURhVHZDYVNOd1NUd0dJRmZIQmR1TkV6cXBrbndZbFFYMEt0?=
 =?utf-8?B?NFRqZ3VqRE51YWIydStSUHFrYm1yRks5MzRKR0NrZS9wajVNdTdrQmYxV25W?=
 =?utf-8?B?WWZEVkFxSWI5Z3R1YWdVSXJLd3RHcC8rS3gxRDV2TTR5Yjc0R3Q4VjR3Qzds?=
 =?utf-8?Q?ENyE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedb26fc-5c17-4539-bc39-08d9dc1e8b00
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 14:09:59.3533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kowCqm65TnCKhVa+MQkn/f93G+Xc+CntYuIYMHQBw8Bv3BSL68Bz4SLW4XrNEJ4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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

I actually suggested to allocate the bounce buffer in VRAM, but that add 
a bit more latency.

Christian.

Am 20.01.22 um 15:00 schrieb Chen, Guchun:
> [Public]
>
> Hi Christian,
>
> Unfortunately, your patch brings another warning from the same sdma_access_bo's creation in amdgpu_ttm_init.
>
> In your patch, you introduce a new check of WARN_ON(!adev->gart.ptr)), however, sdma_access_bo targets to create a bo in GTT domain, but adev->gart.ptr is ready in gmc_v10_0_gart_init only.
>
> Hi Jonathan,
>
> Is it mandatory to create this sdma_access_bo in GTT domain? Can we change it to VRAM?
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, January 19, 2022 10:38 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; Christian König <ckoenig.leichtzumerken@gmail.com>; Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>
> Hi Guchun,
>
> yes, just haven't found time to do this yet.
>
> Regards,
> Christian.
>
> Am 19.01.22 um 15:24 schrieb Chen, Guchun:
>> [Public]
>>
>> Hello Christian,
>>
>> Do you plan to submit your code to drm-next branch?
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Chen, Guchun
>> Sent: Tuesday, January 18, 2022 10:22 PM
>> To: 'Christian König' <ckoenig.leichtzumerken@gmail.com>; Kim,
>> Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: remove gart.ready flag
>>
>> [Public]
>>
>> Thanks for the clarification. The patch is:
>> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>>
>> Regards,
>> Guchun
>>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, January 18, 2022 10:10 PM
>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: remove gart.ready flag
>>
>> Am 18.01.22 um 14:28 schrieb Chen, Guchun:
>>> [Public]
>>>
>>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>> -		goto skip_pin_bo;
>>> -
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> -
>>> -skip_pin_bo:
>>>
>>> Does deleting skip_pin_bo path cause bo redundant pin in SRIOV case?
>> Pinning/unpinning the BO was already removed as well.
>>
>> See Nirmoy's patches in the git log.
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Guchun
>>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Tuesday, January 18, 2022 8:02 PM
>>> To: Chen, Guchun <Guchun.Chen@amd.com>; Kim, Jonathan
>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>> Subject: [PATCH] drm/amdgpu: remove gart.ready flag
>>>
>>> That's just a leftover from old radeon days and was preventing CS and GART bindings before the hardware was initialized. But nowdays that is perfectly valid.
>>>
>>> The only thing we need to warn about are GART binding before the table is even allocated.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 35 +++-------
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    | 15 ++--
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  9 +--
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 77 ++++++---------------
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +-
>>>     drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 11 +--
>>>     drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  7 +-
>>>     drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       |  8 +--
>>>     drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  8 +--
>>>     drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +--
>>>     drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  5 +-
>>>     11 files changed, 52 insertions(+), 137 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> index 645950a653a0..53cc844346f0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>> @@ -150,7 +150,7 @@ void amdgpu_gart_table_vram_free(struct amdgpu_device *adev)
>>>      * replaces them with the dummy page (all asics).
>>>      * Returns 0 for success, -EINVAL for failure.
>>>      */
>>> -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>     			int pages)
>>>     {
>>>     	unsigned t;
>>> @@ -161,13 +161,11 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>     	uint64_t flags = 0;
>>>     	int idx;
>>>     
>>> -	if (!adev->gart.ready) {
>>> -		WARN(1, "trying to unbind memory from uninitialized GART !\n");
>>> -		return -EINVAL;
>>> -	}
>>> +	if (WARN_ON(!adev->gart.ptr))
>>> +		return;
>>>     
>>>     	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>> -		return 0;
>>> +		return;
>>>     
>>>     	t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>     	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE; @@ -188,7 +186,6 @@ int
>>> amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>     		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
>>>     
>>>     	drm_dev_exit(idx);
>>> -	return 0;
>>>     }
>>>     
>>>     /**
>>> @@ -204,7 +201,7 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>      * Map the dma_addresses into GART entries (all asics).
>>>      * Returns 0 for success, -EINVAL for failure.
>>>      */
>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>     		    int pages, dma_addr_t *dma_addr, uint64_t flags,
>>>     		    void *dst)
>>>     {
>>> @@ -212,13 +209,8 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>     	unsigned i, j, t;
>>>     	int idx;
>>>     
>>> -	if (!adev->gart.ready) {
>>> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>>     	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>> -		return 0;
>>> +		return;
>>>     
>>>     	t = offset / AMDGPU_GPU_PAGE_SIZE;
>>>     
>>> @@ -230,7 +222,6 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>     		}
>>>     	}
>>>     	drm_dev_exit(idx);
>>> -	return 0;
>>>     }
>>>     
>>>     /**
>>> @@ -246,20 +237,14 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>      * (all asics).
>>>      * Returns 0 for success, -EINVAL for failure.
>>>      */
>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>>     		     int pages, dma_addr_t *dma_addr,
>>>     		     uint64_t flags)
>>>     {
>>> -	if (!adev->gart.ready) {
>>> -		WARN(1, "trying to bind memory to uninitialized GART !\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> -	if (!adev->gart.ptr)
>>> -		return 0;
>>> +	if (WARN_ON(!adev->gart.ptr))
>>> +		return;
>>>     
>>> -	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>> -			       adev->gart.ptr);
>>> +	amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
>>> +adev->gart.ptr);
>>>     }
>>>     
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> index 78895413cf9f..8fea3e04e411 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>> @@ -46,7 +46,6 @@ struct amdgpu_gart {
>>>     	unsigned			num_gpu_pages;
>>>     	unsigned			num_cpu_pages;
>>>     	unsigned			table_size;
>>> -	bool				ready;
>>>     
>>>     	/* Asic default pte flags */
>>>     	uint64_t			gart_pte_flags;
>>> @@ -58,12 +57,12 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);  void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);  int amdgpu_gart_init(struct amdgpu_device *adev);  void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev); -int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>> -		       int pages);
>>> -int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>> -		    int pages, dma_addr_t *dma_addr, uint64_t flags,
>>> -		    void *dst);
>>> -int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>> -		     int pages, dma_addr_t *dma_addr, uint64_t flags);
>>> +void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>> +			int pages);
>>> +void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>> +		     int pages, dma_addr_t *dma_addr, uint64_t flags,
>>> +		     void *dst);
>>> +void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
>>> +		      int pages, dma_addr_t *dma_addr, uint64_t flags);
>>>     void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
>>> #endif diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> index 9151950e0cc3..babdd915c4c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> @@ -224,26 +224,21 @@ uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
>>>      *
>>>      * Re-init the gart for each known BO in the GTT.
>>>      */
>>> -int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>>>     {
>>>     	struct amdgpu_gtt_node *node;
>>>     	struct drm_mm_node *mm_node;
>>>     	struct amdgpu_device *adev;
>>> -	int r = 0;
>>>     
>>>     	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>>     	spin_lock(&mgr->lock);
>>>     	drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>     		node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
>>> -		r = amdgpu_ttm_recover_gart(node->tbo);
>>> -		if (r)
>>> -			break;
>>> +		amdgpu_ttm_recover_gart(node->tbo);
>>>     	}
>>>     	spin_unlock(&mgr->lock);
>>>     
>>>     	amdgpu_gart_invalidate_tlb(adev);
>>> -
>>> -	return r;
>>>     }
>>>     
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index b489cd8abe31..9cdb61ec669e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -246,10 +246,7 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>>>     		dma_addr_t *dma_addr;
>>>     
>>>     		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
>>> -		r = amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags,
>>> -				    cpu_addr);
>>> -		if (r)
>>> -			goto error_free;
>>> +		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
>>>     	} else {
>>>     		dma_addr_t dma_address;
>>>     
>>> @@ -257,11 +254,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
>>>     		dma_address += adev->vm_manager.vram_base_offset;
>>>     
>>>     		for (i = 0; i < num_pages; ++i) {
>>> -			r = amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
>>> -					    &dma_address, flags, cpu_addr);
>>> -			if (r)
>>> -				goto error_free;
>>> -
>>> +			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
>>> +					flags, cpu_addr);
>>>     			dma_address += PAGE_SIZE;
>>>     		}
>>>     	}
>>> @@ -826,14 +820,13 @@ static void amdgpu_ttm_tt_unpin_userptr(struct
>>> ttm_device *bdev,  #endif  }
>>>     
>>> -static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>> -				struct ttm_buffer_object *tbo,
>>> -				uint64_t flags)
>>> +static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>> +				 struct ttm_buffer_object *tbo,
>>> +				 uint64_t flags)
>>>     {
>>>     	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
>>>     	struct ttm_tt *ttm = tbo->ttm;
>>>     	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>> -	int r;
>>>     
>>>     	if (amdgpu_bo_encrypted(abo))
>>>     		flags |= AMDGPU_PTE_TMZ;
>>> @@ -841,10 +834,8 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>     	if (abo->flags & AMDGPU_GEM_CREATE_CP_MQD_GFX9) {
>>>     		uint64_t page_idx = 1;
>>>     
>>> -		r = amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>> -				gtt->ttm.dma_address, flags);
>>> -		if (r)
>>> -			goto gart_bind_fail;
>>> +		amdgpu_gart_bind(adev, gtt->offset, page_idx,
>>> +				 gtt->ttm.dma_address, flags);
>>>     
>>>     		/* The memory type of the first page defaults to UC. Now
>>>     		 * modify the memory type to NC from the second page of @@ -853,21 +844,13 @@ static int amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>>     		flags &= ~AMDGPU_PTE_MTYPE_VG10_MASK;
>>>     		flags |= AMDGPU_PTE_MTYPE_VG10(AMDGPU_MTYPE_NC);
>>>     
>>> -		r = amdgpu_gart_bind(adev,
>>> -				gtt->offset + (page_idx << PAGE_SHIFT),
>>> -				ttm->num_pages - page_idx,
>>> -				&(gtt->ttm.dma_address[page_idx]), flags);
>>> +		amdgpu_gart_bind(adev, gtt->offset + (page_idx << PAGE_SHIFT),
>>> +				 ttm->num_pages - page_idx,
>>> +				 &(gtt->ttm.dma_address[page_idx]), flags);
>>>     	} else {
>>> -		r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>> -				     gtt->ttm.dma_address, flags);
>>> +		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>> +				 gtt->ttm.dma_address, flags);
>>>     	}
>>> -
>>> -gart_bind_fail:
>>> -	if (r)
>>> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>> -			  ttm->num_pages, gtt->offset);
>>> -
>>> -	return r;
>>>     }
>>>     
>>>     /*
>>> @@ -883,7 +866,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>>>     	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>     	struct amdgpu_ttm_tt *gtt = (void*)ttm;
>>>     	uint64_t flags;
>>> -	int r = 0;
>>> +	int r;
>>>     
>>>     	if (!bo_mem)
>>>     		return -EINVAL;
>>> @@ -930,14 +913,10 @@ static int amdgpu_ttm_backend_bind(struct
>>> ttm_device *bdev,
>>>     
>>>     	/* bind pages into GART page tables */
>>>     	gtt->offset = (u64)bo_mem->start << PAGE_SHIFT;
>>> -	r = amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>> -		gtt->ttm.dma_address, flags);
>>> -
>>> -	if (r)
>>> -		DRM_ERROR("failed to bind %u pages at 0x%08llX\n",
>>> -			  ttm->num_pages, gtt->offset);
>>> +	amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
>>> +			 gtt->ttm.dma_address, flags);
>>>     	gtt->bound = true;
>>> -	return r;
>>> +	return 0;
>>>     }
>>>     
>>>     /*
>>> @@ -987,12 +966,7 @@ int amdgpu_ttm_alloc_gart(struct
>>> ttm_buffer_object *bo)
>>>     
>>>     	/* Bind pages */
>>>     	gtt->offset = (u64)tmp->start << PAGE_SHIFT;
>>> -	r = amdgpu_ttm_gart_bind(adev, bo, flags);
>>> -	if (unlikely(r)) {
>>> -		ttm_resource_free(bo, &tmp);
>>> -		return r;
>>> -	}
>>> -
>>> +	amdgpu_ttm_gart_bind(adev, bo, flags);
>>>     	amdgpu_gart_invalidate_tlb(adev);
>>>     	ttm_resource_free(bo, &bo->resource);
>>>     	ttm_bo_assign_mem(bo, tmp);
>>> @@ -1006,19 +980,16 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>>      * Called by amdgpu_gtt_mgr_recover() from amdgpu_device_reset() to
>>>      * rebind GTT pages during a GPU reset.
>>>      */
>>> -int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo)
>>>     {
>>>     	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>>>     	uint64_t flags;
>>> -	int r;
>>>     
>>>     	if (!tbo->ttm)
>>> -		return 0;
>>> +		return;
>>>     
>>>     	flags = amdgpu_ttm_tt_pte_flags(adev, tbo->ttm, tbo->resource);
>>> -	r = amdgpu_ttm_gart_bind(adev, tbo, flags);
>>> -
>>> -	return r;
>>> +	amdgpu_ttm_gart_bind(adev, tbo, flags);
>>>     }
>>>     
>>>     /*
>>> @@ -1032,7 +1003,6 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,  {
>>>     	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>>     	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>> -	int r;
>>>     
>>>     	/* if the pages have userptr pinning then clear that first */
>>>     	if (gtt->userptr) {
>>> @@ -1052,10 +1022,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
>>>     		return;
>>>     
>>>     	/* unbind shouldn't be done for GDS/GWS/OA in ttm_bo_clean_mm */
>>> -	r = amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>> -	if (r)
>>> -		DRM_ERROR("failed to unbind %u pages at 0x%08llX\n",
>>> -			  gtt->ttm.num_pages, gtt->offset);
>>> +	amdgpu_gart_unbind(adev, gtt->offset, ttm->num_pages);
>>>     	gtt->bound = false;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 084aa49e627d..d9691f262f16 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -119,7 +119,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device
>>> *adev);
>>>     
>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>> uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr); -int
>>> amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>> +void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>>>     
>>>     uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager
>>> *man);
>>>     
>>> @@ -162,7 +162,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>>>     			struct dma_fence **fence);
>>>     
>>>     int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo); -int
>>> amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>> +void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>>     uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev,
>>> uint32_t type);
>>>     
>>>     #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 4f8d356f8432..867c94a1a81a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -1000,14 +1000,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>>>     		return -EINVAL;
>>>     	}
>>>     
>>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>> -		goto skip_pin_bo;
>>> -
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> -
>>> -skip_pin_bo:
>>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>     	r = adev->gfxhub.funcs->gart_enable(adev);
>>>     	if (r)
>>>     		return r;
>>> @@ -1033,8 +1026,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>>>     		 (unsigned)(adev->gmc.gart_size >> 20),
>>>     		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>>>     
>>> -	adev->gart.ready = true;
>>> -
>>>     	return 0;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> index cd6c38e083d0..3baece11d74e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>> @@ -469,16 +469,14 @@ static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)  {
>>>     	uint64_t table_addr;
>>> -	int r, i;
>>>     	u32 field;
>>> +	int i;
>>>     
>>>     	if (adev->gart.bo == NULL) {
>>>     		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>     		return -EINVAL;
>>>     	}
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>     
>>>     	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>     
>>> @@ -558,7 +556,6 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
>>>     	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>     		 (unsigned)(adev->gmc.gart_size >> 20),
>>>     		 (unsigned long long)table_addr);
>>> -	adev->gart.ready = true;
>>>     	return 0;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index ab8adbff9e2d..cf83f8c258f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -613,17 +613,14 @@ static void gmc_v7_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)  {
>>>     	uint64_t table_addr;
>>> -	int r, i;
>>>     	u32 tmp, field;
>>> +	int i;
>>>     
>>>     	if (adev->gart.bo == NULL) {
>>>     		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>     		return -EINVAL;
>>>     	}
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> -
>>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>     	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>     
>>>     	/* Setup TLB control */
>>> @@ -712,7 +709,6 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>>>     	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>     		 (unsigned)(adev->gmc.gart_size >> 20),
>>>     		 (unsigned long long)table_addr);
>>> -	adev->gart.ready = true;
>>>     	return 0;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 054733838292..7cc7c8001734 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -837,17 +837,14 @@ static void gmc_v8_0_set_prt(struct amdgpu_device *adev, bool enable)  static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)  {
>>>     	uint64_t table_addr;
>>> -	int r, i;
>>>     	u32 tmp, field;
>>> +	int i;
>>>     
>>>     	if (adev->gart.bo == NULL) {
>>>     		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>>>     		return -EINVAL;
>>>     	}
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> -
>>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>     	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
>>>     
>>>     	/* Setup TLB control */
>>> @@ -953,7 +950,6 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>>>     	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
>>>     		 (unsigned)(adev->gmc.gart_size >> 20),
>>>     		 (unsigned long long)table_addr);
>>> -	adev->gart.ready = true;
>>>     	return 0;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index c76ffd1a70cd..9f71f810c2f8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1783,14 +1783,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>>>     		return -EINVAL;
>>>     	}
>>>     
>>> -	if (amdgpu_sriov_vf(adev) && amdgpu_in_reset(adev))
>>> -		goto skip_pin_bo;
>>> -
>>> -	r = amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>> -	if (r)
>>> -		return r;
>>> -
>>> -skip_pin_bo:
>>> +	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
>>>     	r = adev->gfxhub.funcs->gart_enable(adev);
>>>     	if (r)
>>>     		return r;
>>> @@ -1807,7 +1800,6 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>>>     	DRM_INFO("PTB located at 0x%016llX\n",
>>>     			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
>>>     
>>> -	adev->gart.ready = true;
>>>     	return 0;
>>>     }
>>>     
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> index d5d2cf2ee788..88db82b3d443 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
>>> @@ -86,10 +86,7 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
>>> uint64_t npages,
>>>     
>>>     	cpu_addr = &job->ibs[0].ptr[num_dw];
>>>     
>>> -	r = amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>> -	if (r)
>>> -		goto error_free;
>>> -
>>> +	amdgpu_gart_map(adev, 0, npages, addr, pte_flags, cpu_addr);
>>>     	r = amdgpu_job_submit(job, &adev->mman.entity,
>>>     			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
>>>     	if (r)
>>> --
>>> 2.25.1

