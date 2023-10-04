Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF14DE7B61D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 14:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5035610E12B;
	Wed,  4 Oct 2023 14:02:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EEC10E12B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 14:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjS0nAfm+Eh93kecK4aVxGmJ13vz/yIlrElkSKaHvifsnkp3jVutjM4bgIM7b4ZnTqAY3ENjGhdE6WDclNF/GTaigT5B1lF+KZCHf4Y4gY/ryqVVXQPJ/qZTaMwOvDwtyjwzNc6wRjhsgGZ3Sg46OZ6qTQXW0O3k+kqP3S93nyz2aor2PNCFw1rTzG966btWHEEZ2RPMGSVNeVFV1CuxsZPDlScT4EXWFQqnK36f+1ChK8l/vvpu0SsQMJCnCVpWWGq1hKwQqJeFhyvdaPn5wZvmyXBMHonJlhExg8oBaEa7Azl+GtwXrQKTBSxZsKUdGo1VfFZ6t0gjFizsjCzYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr7iLHdXSbkyMqHlXbkfzx/CAFo/D2nyJpZmAB1TeMI=;
 b=ELGVuDXAq2vNmBnvAhR0BZdc4AlYPmnb9bGjawSp46amZi0a4h1G6Emp0x9iE6xqP9RNGe3VP7k3zIRFgAjFIT5SjarV5/fIWlnqd73+fg+U9jCyP/mHtIqOm9uRFrw+pIRv49fgAZIFNd+TdLmKflk0JfDJfaJLR3rR983RQLfLDaGCpzwWb1QcWncMfk32bRgP0zjNQd9WNfV4xGDmYBL8lBqhRo+0vrGbsFpzY+/NmVPZCRmpvUWbv52l1o5qg0HmI5CKfTBlsQjp+lhWZbPkrVuFoLe2lX0a+lrFh1zJyo+ixMTv5If7JFuKUJP/T1TAKWJvQv7xT3ppsN5RYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr7iLHdXSbkyMqHlXbkfzx/CAFo/D2nyJpZmAB1TeMI=;
 b=hfdBaJZs4v0wK8VsJ8xwIkAHwJsuE908tiJnSABABMPMcQGo8t+eRc5jve2wfv1nHFdvc+S7aiZaCe2hOsijLIy9m1Md/jkg1n2gEsaKqJG2wQnRuL6GBti/9hamdY7s+SmauZ5KOAhPYT1HK8EUQ3/5JSxISH9hCOYiSqtD12E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 14:01:58 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::d890:af2f:d92e:9d4b%7]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 14:01:58 +0000
Content-Type: multipart/alternative;
 boundary="------------AzTH6O1IjmqyG0g2Xq7WMLwN"
Message-ID: <6ae1cb47-2ee2-1507-f5a8-46b778d7feea@amd.com>
Date: Wed, 4 Oct 2023 19:31:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/amdgpu: fix ip count query for xcp partitions
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20230921124929.1965750-1-sathishkumar.sundararaju@amd.com>
 <CADnq5_NTHMU5OAb_Rw1iWyHB0ksgv8v7C2J7A9TnUdgRt-1_Yg@mail.gmail.com>
 <d96ed183-6806-c2a8-7972-fab3944aa02a@amd.com>
 <CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com>
 <07ffc69b-d1db-8d73-013b-46ad7321f29d@amd.com>
 <41c0b2b7-e1d2-46c4-a368-5f879896d259@gmail.com>
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <41c0b2b7-e1d2-46c4-a368-5f879896d259@gmail.com>
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 4654daa0-f7ee-4786-2ef0-08dbc4e27965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVn3CuUZt4CtCcK1LWedxCy23TgSF8yaQCWMhXqf7pt3bl3qgWIhStnRQFVH7J4C/baKWbzFW/QZlkXyghR61MePLbhsudagHR/YH9gS1zIV5uJJPAXDejFyhx48RmoO9AwH/nlxWcb/xFYgGJ3kWLqvwHMhkRAVnfbpOdpENsWq8FmzryIZLUXJXyJ7OpOm6W6Qz+OlThFRurt/5NBlmI4T+Qj0nMlxzf7WSvD1JYnoVbn2BPXE5CzrRbRkkTYabL2MUi+HfP5NDwxglpPv6ODjlsroXirrk2nLVtG5FQB0IskdE516FA1nxrKT2zHloZGfYjxWZh7jmHIsuio3XaTW1YvdPkaGpqLFJbK6j5kDO7XEvpeCoFPUUB3VHUYz8CWPqe36aNWrNJTx/hQumDlE9d8rtw37TBVwUfU9Euy2Dzx72TzfvF2nCb59D7mqmIM4b9FNr8BBVmgBGtXAyji/nIzZHvLrUYfhUKMgqo8Sg8/RDBxQ6zd75+I4JLbBgqD2yLWgBshPNvpP4ar8b9zspvdaI6GXoIvprlMnRpnWQ+iOuC1Q1QtpvrMJ1ru4kHSwvDtDfZ6VQo+lxS3hVNPLFv7PCYBcM02IT/CckkArsRUdoYU6KP+f2TTpgC8J74ajp4y8O0IcDbpAxdYWZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(6486002)(36756003)(6512007)(6666004)(31696002)(53546011)(6506007)(33964004)(478600001)(316002)(66556008)(54906003)(66476007)(2616005)(66946007)(41300700001)(38100700002)(26005)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(110136005)(30864003)(2906002)(45980500001)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBQM0xKV2hlRHZIa0FZZGtaMzhwUFBXT1NxRTQxcUM4UysvV2svMFI2TEtC?=
 =?utf-8?B?T2lQV1NzN1dxMm51YzRyVXdhOVlJRGxwQnhZZWdBUUI1NkFUbFRaVzA0U3FC?=
 =?utf-8?B?R013WEtaTUJldDFtb0VoWXNKQWwvTXRZUmlVbldHTCtqeU5TMGs1Tmhka0Fo?=
 =?utf-8?B?ODA0b3paVmtPZ2dWeHcvQ2ZHeE5yUG5CUzBaalk3TXE1S0s3eEkrQkJTeTZ3?=
 =?utf-8?B?RlZwQ2lDbm5idjRtVFgzVEk4RS9EeVZ4M01RZTAyTVkrYWxHaHlXSmNyRnF1?=
 =?utf-8?B?WDhXWEhIbWlRc2tUNm41Q3pyQzhncys5Sy9nWjRmYmRza0NMNW5uTGZxTTZQ?=
 =?utf-8?B?cHRQeDViOEdudXQ4a1praUZKaDJSV2IwQVMvK3NKZ0UrbGlxN01UTkgwZGcv?=
 =?utf-8?B?RFZqN1pmQ1UyNEFoR3Z5cmgvK3Y1Q2VvOEt4d1paK01LQzREMWRJSWpEQVVD?=
 =?utf-8?B?L1ZObkx6V21VbUtqY1A4MVFoVnZSTDlXWUc1K1hWWTRDZ2R1Sll6L0NTR1Zw?=
 =?utf-8?B?RmRxbkJOeFNUWUs1alZiSDY5a0RqYzJRR2o3TisrTitSOXp2RzhIMjZjSDdT?=
 =?utf-8?B?cm03YVFKcy9OaEt5RkVldWRpWTd3aUFuVGQxQnArNVRWdDZ1L3lZcGFTVFVO?=
 =?utf-8?B?akNEdmhlWUtpZVFHWXVIcHRvajIycHp1L0hNTDJIWUwxT2hnM0lQUSswbUpE?=
 =?utf-8?B?b1VxSUs4N2dKaDFBQ3diRVVOS3hrSWN4ZUZkS21LRmFQYVlkV05yL1NvRUhH?=
 =?utf-8?B?ZkN2U0V0c2t6OXJxbVhCNXhiUVpybGZtQkJIT0pIc1lKWFVoeXZZOHdjcUJv?=
 =?utf-8?B?Sy9SNTZkUVQ1NnUzUU9TWG5jdHYwV0haZU5hZU5EVVdNSVhRVFlxN2o5WExk?=
 =?utf-8?B?S2M5RkJRVGlyKytJalp1RXIvM1laTUVtNDgwRGUrMGQ1WUcwbmpyTlFmL0xJ?=
 =?utf-8?B?OVB0azZlRUxyWjcyQzBaVUZhc0sxOVdSdVU5SzN0NmVoS0VTVXZaQUFxVkFI?=
 =?utf-8?B?V0RaYVNNTlRqWlRxRDFXNTAxcGlIMExMMHMrZ1hVZGdkSUNmVVBzNXZxQ29Y?=
 =?utf-8?B?bk0rSE5Ea29KZGdUMGJUaFcvQ1FObDIycVh0d3JRTUd6blM1ZHhMazBrTCtN?=
 =?utf-8?B?UkhDbVVJR1VwQTBxN1Zzd0NzQlZ5MzdmTjNNakZEeElIRUZFZ2pYalB2cDcx?=
 =?utf-8?B?ZldSblBKTWF1ZUYvckJKOVFEZytXNUdqOElpRHJCMTJnZnpobHNvcEljSW5O?=
 =?utf-8?B?MW5kRHk5WGp3a3pNY1BMTFlNaFVoY2FPOHZEMm1YR3M3UTA5QjBpdmhmaWM5?=
 =?utf-8?B?VnI1OWt6em5CUzRWMFduNjlPYlVFRFJWdFVUQTlsUDBwam5xMjVHcnFhNDZH?=
 =?utf-8?B?SDByUHJkQVlmKzhnUnJ4Q0oyOXYxeFJ0aGFCdDVSdVZDMjhXWGxXNHhHQXdL?=
 =?utf-8?B?R0tVY3NwbktkODl5LytZQk93dEFuVE5QMmNTYUFKNVpuWlJWenp4YzJ3YTNV?=
 =?utf-8?B?OHV6SmtPdkdXTlNXMzZKWE92cVJHMHAxaFhEc2VTT1Z5UzJhcHNTSUc0V0cw?=
 =?utf-8?B?UFIrMmpUN09jWmRGOTY1SXNnTi84aHN0dkpKNE5WemVpczFIWnV4eVVvcHE4?=
 =?utf-8?B?K3BYbldaRzJxR3pmTDhyV1U0ek1janJTZFZmZlY4ZUxURVNoNXdPT2gyekFX?=
 =?utf-8?B?bWpBTGdFQ3NzUUpTNlU1SDZoTFhseDZzWjdubFhKZmhOTmFVYmkxc3VtT3h6?=
 =?utf-8?B?VEpuT0JzTDQ1ZGpRNGI3LzBRbFdhMGtFRE9GeTVqRlNDU1lIL3ZvWC9NcWxi?=
 =?utf-8?B?Nms1eXZUWnk5c3pHejVzSnh5VEJYTU9xSHprL2xUTk1FWVdpUUljdGJzWHlt?=
 =?utf-8?B?YWJBa0ZpWE50SVJ5eTUrV1p2ZGRlWDkxK1dKNm5DUWVnSUk1S0pmVStJVy95?=
 =?utf-8?B?K3JnOEIvcllLbG5nM0tUMmYrUlBrRW9tZDY3WW9HUlJ0bUo0OE9oQkZ6N3g5?=
 =?utf-8?B?YmV5WDM2UmJxQm9WVlIyMlJTWThsRzR4K1V6TUpzaGVIWk1ZUzJFUUFFeTFs?=
 =?utf-8?B?K2xvWHRkZ0s4V3htYUx1YXhpK2RMQXFLYU1vcHRYS3JXUGpnRkd6bDhkbW9t?=
 =?utf-8?Q?7Kb2vm02lAZhFIMKMmXFiKDtb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4654daa0-f7ee-4786-2ef0-08dbc4e27965
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:01:58.5860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKce4052r4S1CV9Ay0JkBst2b9Ax1epJlHVc+bKXqYR2v/eLPSZW86wBQypQJqiZ443rPx7gqjObbVC3/m7m0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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
Cc: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>,
 Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, James.Zhu@amd.com, "Liu,
 Leo" <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Srinath Rao <Srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------AzTH6O1IjmqyG0g2Xq7WMLwN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Thank you for explaining, I understand it now.

Regards,

Sathish

On 10/4/2023 7:23 PM, Christian König wrote:
> Hi Sathish,
>
> an ack from a maintainer basically means "go ahead, push it to a 
> branch" (in this case to amd-staging-drm-next).
>
> A reviewed-by means "I've verified the technical background and think 
> that this is correct".
>
> A RB is indeed better, but not always necessary.
>
> Regards,
> Christian.
>
> Am 03.10.23 um 18:43 schrieb Sundararaju, Sathishkumar:
>>
>> Hi Alex,
>>
>> My apology, I was under the impression that RB is a must. I 
>> understand now that ACK is good, checked with Leo after your 
>> response. Thank you.
>>
>>
>> Regards,
>>
>> Sathish
>>
>>
>> On 10/3/2023 10:01 PM, Alex Deucher wrote:
>>> On Tue, Oct 3, 2023 at 12:22 PM Sundararaju, Sathishkumar
>>> <sasundar@amd.com>  wrote:
>>>> Hi ,
>>>>
>>>> Kind request to help review the change. Thank you.
>>> I acked this change back when you sent it out, but if it didn't come
>>> through for some reason:
>>> Acked-by: Alex Deucher<alexander.deucher@amd.com>
>>>
>>>> Regards,
>>>>
>>>> Sathish
>>>>
>>>> On 9/21/2023 8:17 PM, Alex Deucher wrote:
>>>>> On Thu, Sep 21, 2023 at 9:07 AM Sathishkumar S
>>>>> <sathishkumar.sundararaju@amd.com>  wrote:
>>>>>> fix wrong ip count INFO on spatial partitions. update the query
>>>>>> to return the instance count corresponding to the partition id.
>>>>>>
>>>>>> v2:
>>>>>>    initialize variables only when required to be (Christian)
>>>>>>    move variable declarations to the beginning of function (Christian)
>>>>>>
>>>>>> Signed-off-by: Sathishkumar S<sathishkumar.sundararaju@amd.com>
>>>>> Acked-by: Alex Deucher<alexander.deucher@amd.com>
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
>>>>>>    1 file changed, 36 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>> index 081bd28e2443..d4ccbe7c78d6 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>> @@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>>>           struct drm_amdgpu_info *info = data;
>>>>>>           struct amdgpu_mode_info *minfo = &adev->mode_info;
>>>>>>           void __user *out = (void __user *)(uintptr_t)info->return_pointer;
>>>>>> +       struct amdgpu_fpriv *fpriv;
>>>>>> +       struct amdgpu_ip_block *ip_block;
>>>>>> +       enum amd_ip_block_type type;
>>>>>> +       struct amdgpu_xcp *xcp;
>>>>>> +       uint32_t count, inst_mask;
>>>>>>           uint32_t size = info->return_size;
>>>>>>           struct drm_crtc *crtc;
>>>>>>           uint32_t ui32 = 0;
>>>>>>           uint64_t ui64 = 0;
>>>>>> -       int i, found;
>>>>>> +       int i, found, ret;
>>>>>>           int ui32_size = sizeof(ui32);
>>>>>>
>>>>>>           if (!info->return_size || !info->return_pointer)
>>>>>> @@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>>>                   return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>>>>>>           case AMDGPU_INFO_HW_IP_INFO: {
>>>>>>                   struct drm_amdgpu_info_hw_ip ip = {};
>>>>>> -               int ret;
>>>>>>
>>>>>>                   ret = amdgpu_hw_ip_info(adev, info, &ip);
>>>>>>                   if (ret)
>>>>>> @@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>>>                   return ret ? -EFAULT : 0;
>>>>>>           }
>>>>>>           case AMDGPU_INFO_HW_IP_COUNT: {
>>>>>> -               enum amd_ip_block_type type;
>>>>>> -               struct amdgpu_ip_block *ip_block = NULL;
>>>>>> -               uint32_t count = 0;
>>>>>> -
>>>>>> +               fpriv = (struct amdgpu_fpriv *) filp->driver_priv;
>>>>>>                   type = amdgpu_ip_get_block_type(adev, info->query_hw_ip.type);
>>>>>>                   ip_block = amdgpu_device_ip_get_ip_block(adev, type);
>>>>>> +
>>>>>>                   if (!ip_block || !ip_block->status.valid)
>>>>>>                           return -EINVAL;
>>>>>>
>>>>>> +               if (adev->xcp_mgr && adev->xcp_mgr->num_xcps > 0 &&
>>>>>> +                       fpriv->xcp_id >= 0 && fpriv->xcp_id < adev->xcp_mgr->num_xcps) {
>>>>>> +                       xcp = &adev->xcp_mgr->xcp[fpriv->xcp_id];
>>>>>> +                       switch (type) {
>>>>>> +                       case AMD_IP_BLOCK_TYPE_GFX:
>>>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
>>>>>> +                               count = hweight32(inst_mask);
>>>>>> +                               break;
>>>>>> +                       case AMD_IP_BLOCK_TYPE_SDMA:
>>>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &inst_mask);
>>>>>> +                               count = hweight32(inst_mask);
>>>>>> +                               break;
>>>>>> +                       case AMD_IP_BLOCK_TYPE_JPEG:
>>>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>>>>>> +                               count = hweight32(inst_mask) * adev->jpeg.num_jpeg_rings;
>>>>>> +                               break;
>>>>>> +                       case AMD_IP_BLOCK_TYPE_VCN:
>>>>>> +                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
>>>>>> +                               count = hweight32(inst_mask);
>>>>>> +                               break;
>>>>>> +                       default:
>>>>>> +                               return -EINVAL;
>>>>>> +                       }
>>>>>> +                       if (ret)
>>>>>> +                               return ret;
>>>>>> +                       return copy_to_user(out, &count, min(size, 4u)) ? -EFAULT : 0;
>>>>>> +               }
>>>>>> +
>>>>>>                   switch (type) {
>>>>>>                   case AMD_IP_BLOCK_TYPE_GFX:
>>>>>>                   case AMD_IP_BLOCK_TYPE_VCE:
>>>>>> @@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>>>                   return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>>>>>           case AMDGPU_INFO_FW_VERSION: {
>>>>>>                   struct drm_amdgpu_info_firmware fw_info;
>>>>>> -               int ret;
>>>>>>
>>>>>>                   /* We only support one instance of each IP block right now. */
>>>>>>                   if (info->query_fw.ip_instance != 0)
>>>>>> @@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>>>>>                   struct drm_amdgpu_info_device *dev_info;
>>>>>>                   uint64_t vm_size;
>>>>>>                   uint32_t pcie_gen_mask;
>>>>>> -               int ret;
>>>>>>
>>>>>>                   dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
>>>>>>                   if (!dev_info)
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>
--------------AzTH6O1IjmqyG0g2Xq7WMLwN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Christian,</p>
    <p>Thank you for explaining, I understand it now.</p>
    <p>Regards,</p>
    <p>Sathish<br>
    </p>
    <div class="moz-cite-prefix">On 10/4/2023 7:23 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:41c0b2b7-e1d2-46c4-a368-5f879896d259@gmail.com">
      
      Hi Sathish,<br>
      <br>
      an ack from a maintainer basically means &quot;go ahead, push it to a
      branch&quot; (in this case to amd-staging-drm-next).<br>
      <br>
      A reviewed-by means &quot;I've verified the technical background and
      think that this is correct&quot;.<br>
      <br>
      A RB is indeed better, but not always necessary.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      <div class="moz-cite-prefix">Am 03.10.23 um 18:43 schrieb
        Sundararaju, Sathishkumar:<br>
      </div>
      <blockquote type="cite" cite="mid:07ffc69b-d1db-8d73-013b-46ad7321f29d@amd.com">
        <p> </p>
        <p class="MsoPlainText">Hi Alex,</p>
        <p class="MsoPlainText">My apology, I was under the impression
          that RB is a must. I understand now that ACK is good, checked
          with Leo after your response. Thank you.</p>
        <p class="MsoPlainText"><br>
        </p>
        <p class="MsoPlainText">Regards,</p>
        <p class="MsoPlainText">Sathish</p>
        <p class="MsoPlainText"><br>
        </p>
        <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
</style>
<![endif]--></p>
        <div class="moz-cite-prefix">On 10/3/2023 10:01 PM, Alex Deucher
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:CADnq5_MM-_zR6_nDdfejpoC=m0Xv4eM5ZQkoVZH6qnChfcaWCA@mail.gmail.com">
          <pre class="moz-quote-pre" wrap="">On Tue, Oct 3, 2023 at 12:22 PM Sundararaju, Sathishkumar
<a class="moz-txt-link-rfc2396E" href="mailto:sasundar@amd.com" moz-do-not-send="true">&lt;sasundar@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Hi ,

Kind request to help review the change. Thank you.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I acked this change back when you sent it out, but if it didn't come
through for some reason:
Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,

Sathish

On 9/21/2023 8:17 PM, Alex Deucher wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Thu, Sep 21, 2023 at 9:07 AM Sathishkumar S
<a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a> wrote:
</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">fix wrong ip count INFO on spatial partitions. update the query
to return the instance count corresponding to the partition id.

v2:
  initialize variables only when required to be (Christian)
  move variable declarations to the beginning of function (Christian)

Signed-off-by: Sathishkumar S <a class="moz-txt-link-rfc2396E" href="mailto:sathishkumar.sundararaju@amd.com" moz-do-not-send="true">&lt;sathishkumar.sundararaju@amd.com&gt;</a>
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>

</pre>
              <blockquote type="cite">
                <pre class="moz-quote-pre" wrap="">---
  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 44 ++++++++++++++++++++-----
  1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 081bd28e2443..d4ccbe7c78d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -595,11 +595,16 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
         struct drm_amdgpu_info *info = data;
         struct amdgpu_mode_info *minfo = &amp;adev-&gt;mode_info;
         void __user *out = (void __user *)(uintptr_t)info-&gt;return_pointer;
+       struct amdgpu_fpriv *fpriv;
+       struct amdgpu_ip_block *ip_block;
+       enum amd_ip_block_type type;
+       struct amdgpu_xcp *xcp;
+       uint32_t count, inst_mask;
         uint32_t size = info-&gt;return_size;
         struct drm_crtc *crtc;
         uint32_t ui32 = 0;
         uint64_t ui64 = 0;
-       int i, found;
+       int i, found, ret;
         int ui32_size = sizeof(ui32);

         if (!info-&gt;return_size || !info-&gt;return_pointer)
@@ -627,7 +632,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return copy_to_user(out, &amp;ui32, min(size, 4u)) ? -EFAULT : 0;
         case AMDGPU_INFO_HW_IP_INFO: {
                 struct drm_amdgpu_info_hw_ip ip = {};
-               int ret;

                 ret = amdgpu_hw_ip_info(adev, info, &amp;ip);
                 if (ret)
@@ -637,15 +641,41 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return ret ? -EFAULT : 0;
         }
         case AMDGPU_INFO_HW_IP_COUNT: {
-               enum amd_ip_block_type type;
-               struct amdgpu_ip_block *ip_block = NULL;
-               uint32_t count = 0;
-
+               fpriv = (struct amdgpu_fpriv *) filp-&gt;driver_priv;
                 type = amdgpu_ip_get_block_type(adev, info-&gt;query_hw_ip.type);
                 ip_block = amdgpu_device_ip_get_ip_block(adev, type);
+
                 if (!ip_block || !ip_block-&gt;status.valid)
                         return -EINVAL;

+               if (adev-&gt;xcp_mgr &amp;&amp; adev-&gt;xcp_mgr-&gt;num_xcps &gt; 0 &amp;&amp;
+                       fpriv-&gt;xcp_id &gt;= 0 &amp;&amp; fpriv-&gt;xcp_id &lt; adev-&gt;xcp_mgr-&gt;num_xcps) {
+                       xcp = &amp;adev-&gt;xcp_mgr-&gt;xcp[fpriv-&gt;xcp_id];
+                       switch (type) {
+                       case AMD_IP_BLOCK_TYPE_GFX:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       case AMD_IP_BLOCK_TYPE_SDMA:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_SDMA, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       case AMD_IP_BLOCK_TYPE_JPEG:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &amp;inst_mask);
+                               count = hweight32(inst_mask) * adev-&gt;jpeg.num_jpeg_rings;
+                               break;
+                       case AMD_IP_BLOCK_TYPE_VCN:
+                               ret = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &amp;inst_mask);
+                               count = hweight32(inst_mask);
+                               break;
+                       default:
+                               return -EINVAL;
+                       }
+                       if (ret)
+                               return ret;
+                       return copy_to_user(out, &amp;count, min(size, 4u)) ? -EFAULT : 0;
+               }
+
                 switch (type) {
                 case AMD_IP_BLOCK_TYPE_GFX:
                 case AMD_IP_BLOCK_TYPE_VCE:
@@ -678,7 +708,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 return copy_to_user(out, &amp;ui64, min(size, 8u)) ? -EFAULT : 0;
         case AMDGPU_INFO_FW_VERSION: {
                 struct drm_amdgpu_info_firmware fw_info;
-               int ret;

                 /* We only support one instance of each IP block right now. */
                 if (info-&gt;query_fw.ip_instance != 0)
@@ -823,7 +852,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
                 struct drm_amdgpu_info_device *dev_info;
                 uint64_t vm_size;
                 uint32_t pcie_gen_mask;
-               int ret;

                 dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
                 if (!dev_info)
--
2.25.1

</pre>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------AzTH6O1IjmqyG0g2Xq7WMLwN--
