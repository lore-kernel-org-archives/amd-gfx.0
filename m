Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F317EEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jul 2023 09:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAB810E352;
	Tue, 11 Jul 2023 09:59:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A53210E352
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jul 2023 09:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdg+1XglyrR3ZB7Fa6ghaot+pBaMLtq2gODRGeddGlLcU5OnREgtD8xJEdexYAOWBtrdCnwbVVtNn63iTgxs0HyfKGMAQ/hK+j4GN1feUjvwEXndLr+RerrCwTKucY00w/Xae9HRk2cRoEgmziGSRfYwwf4UwwgaquZ5bPT4QDf4kE6k+FIUSWAzFzM1MUUu9EaswJUm3ry6T2x39bIMTpvkOnlLD7KWJwqYkBPMdDeHr9vzjfHL53HCRkmqUiPwoi2K7ZGDHrhdSGZAkQ2Ks7p3X2dkpohrUwxXLsUxd2ycuUxZCrk4rdjMrmz7wFoh2yRvp5/331w2+fpc8WLh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8dM3MPJ5wb7ED5wZrEMh3xD33gYS6fE4y4iK9RGwms=;
 b=msMR42tgreb9H7ndY6VrKx6W1BgkfeN3o2zqYLUvRoW9uzpTb1X0KN36JJrgTbOPJFT6jDO9UTEneZv2/AZWcL1xdunqY0aVCtrrqfZjq7oow2TQZfHwisWA9Pm0ZD/wRznbeYmO3MFYBuwX6gCT2mQN2fNGT3n7PTvHkoP8Ak1z4ejsMbP9S7/cqUUNYr/scIAeOYAkSUyR+SGkBAnkclG6zmfmSdqVq47xHSlP09DpVfFP/JQEPvlG7UP+MeIBPHmpKGo8fVE0G8fCyG/dFkO9DD+lHvkgFRlLa8EjHRmUpWv6jADQY2R24aQYkWF4lF58fpvOA9WY12AWuP3ZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8dM3MPJ5wb7ED5wZrEMh3xD33gYS6fE4y4iK9RGwms=;
 b=DVfJDQTXY7nojsaCFXF068IhgGkhoaoWUhAIxPVuh5UDZEHeni8mCPDH1Er0NtfkOoXouJIOtrBYt+DmSu8lncXOpHZQ383u2qsqDlJiMvJxYB18JZxMwFTubC0EolhC2zWd4hOj/wU9MiKHjQA7JCnhwKSXqbisqJ0hhmWlA+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 09:59:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 09:59:46 +0000
Content-Type: multipart/alternative;
 boundary="------------u0AYaHFTCVO6Z9q7L8VzpSKm"
Message-ID: <8caae4b2-96b6-8141-8b89-50c8d8992c9f@amd.com>
Date: Tue, 11 Jul 2023 11:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
 "Prica, Nikola" <Nikola.Prica@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
References: <20230711013831.2181718-1-guchun.chen@amd.com>
 <2a71b5c0-a79d-16e7-cba4-37018f2ebecf@gmail.com>
 <DM5PR12MB24692FEDD2317DF87B8DCD45F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
 <8f8d56be-eb2f-3a4d-edb6-34640faeaea2@gmail.com>
 <DM5PR12MB2469C1707C855DEFAC306744F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM5PR12MB2469C1707C855DEFAC306744F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: b6117388-aade-4ad2-321a-08db81f58e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DQkT3lU9EGwA+ltMJLQJAg/fSBOyCqXqKMqvbkqH0d4bw03hR9yZ0lwwq/HLQRgG+ZGpvOhLAascMFQ/UgUHTOHgUfUyd83Ro6IRToEC4c0knHwSMfz1/Y3bP0kXHm91aj8Ss8PKJhUVQ/oB6FLsVEMZmFLv2EuVywCRosw5DJaXbZD8ykbjaFasHP0rYppdSs7NWDMfAsepNgKScod+QKHIDR+iZfFo5suGg6jqgj3oj/3Ro8Kz72kBi8HbCjJ+fSR84Igs4kwd/kgRbNswKWJlWyD4gC2OufR28OvVgqO9nCaOoVv1Jv2+jpNIcougLZfqEnoIhbjVdJ/BcRqvVfvoU089ehuoKqIeDr/7930jEpYIv68AOJBe61YRpSKaqpJngBqtpq9t62DIbtyFKJT7be4SRDIgPaRxMoY+AwwKcqN7ha2oVE21XKyRmJ9Yp2RpiLbUA2YeuElfA60vO+GR4ORmZ7Op2clYNfJDbSshv65UPv4YNGVds75q8zeErdHLEFa+rmGCO6XaC10wFPx8WYP0v9xpK/riy8XYl6s3l3fqLBzsKASOGuL4CEkRzi+OKlMDnLsT/Yu1ZIulE40HhRk+0DoC2WU+5UMld/e5PgQECYlB2tKEskR1QYutYy7NyoJawJ5opdqcjCNSKmu0uK4QYOwq84sB+sbMweipjGK3QdMdAdcqUUwqZq4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36756003)(86362001)(31696002)(166002)(38100700002)(921005)(478600001)(110136005)(6666004)(33964004)(6486002)(6512007)(8676002)(8936002)(5660300002)(2906002)(316002)(6636002)(4326008)(66946007)(66556008)(66476007)(41300700001)(31686004)(30864003)(2616005)(66574015)(6506007)(53546011)(83380400001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZhUmFuZmpOSzMzdjNwbXNKWVBHTWpRU0NYSDl3aTkraTY2SDV1UkkwUFhK?=
 =?utf-8?B?MVZ1eWVCcElVNCs2WjJtUWJrQWVxcG8wTkpuNU9YMFhoMnB3aExDelVBdC9w?=
 =?utf-8?B?Yk9QZHBKdHl5MG1CRE9lUFBrUWtxcXRRajkzR0ZVWGh2RHdiWlA2THBZelpl?=
 =?utf-8?B?ZnArL01kaXlhc1FMbGVrS3Z3ek5ocXkwTGNzVitWZFF0YUtvQTJreVd3cHZM?=
 =?utf-8?B?UlhhZjU1ZUsyYlZkYmR0YlJBRnpocFZNN0dzeGFiRytTYnNPN1B2VHphcThO?=
 =?utf-8?B?cHpEbTQxM2M3Nit6cDd5b1B6U1FHc3RaRit6UWxnbjVPZGJ5YURMZ0VnT2p4?=
 =?utf-8?B?TlkzcGxaa0M0OEFxSHVNQ2pTNzlvMXNQbWNvOW9kOEU5ZGkzb0o4Z3dMZVNR?=
 =?utf-8?B?WVZ2RDJWVkptcXlvdVREZi9tME5LNjJTVjNRK0FiQ2NSSkoyQzV6OGxidjFV?=
 =?utf-8?B?a2FPempsc1d0R3ZPbG5NcUhWNnJrOTRlTmxjT3Y1bDM4VHNDL2J2a3BFWW1Y?=
 =?utf-8?B?OFp2RUhRUkFkaURCUkVERHYyM0ljUU1GeCt3VnJ4dis1anlwV1hlUUtQckNR?=
 =?utf-8?B?eVg5OEswbDczODkyNHhHUy9sVlBiNk9KSGtvYUsrSUdzandBTS9qdStWNlg1?=
 =?utf-8?B?cFAvL2VLdTFlZnNncERDK2pIZkxwbDk1bC9hWFJ2MnNFZERnZ1V1WG9kUE9E?=
 =?utf-8?B?V2libDdyeS84WVpEejBWTWcxUW1oRjNDRGwzMnlra05TUlh0Y3hSL0xQNFRG?=
 =?utf-8?B?VE1iVVVXYU9hdVRYekdTVU9INXpvY1hDTkF0Y0NCbHVYa1RDQncvQ3FMSFor?=
 =?utf-8?B?MlJrR2dDaVVDeHllcTIrSWtTemJaTW5kYkhLbTkvTTRQdXR0UTJuVmtGYkxY?=
 =?utf-8?B?Z0tzVUE2dHRHc0dDRnZrbklyOTc1RC9FaWVwMVZUQStBdzNwNE5lMjJjSjBp?=
 =?utf-8?B?elJ0WEVncG1qTTRuN0tKRnJJRHZXUlNTbXBqQUxiRmZUOTlPOWU5R1I5MUl4?=
 =?utf-8?B?TndEK3dnNXBHK2N2TDRyUGd4Y1dFVDM4dHMxQy9wcCt0OG44blNzd2YxZ2hl?=
 =?utf-8?B?L01sdTNTVHVxQTFsdmhJQ3VwUkR4NndVcGt4cThPa2RHMmptYVdVdVhCdVNo?=
 =?utf-8?B?bjE0eGJreVRLQkpqeUNOUWFidy9CSUgwaTh0YzMyRllPQWl2LzdreVFaS0RB?=
 =?utf-8?B?NGFqVUozTXRlM0dHYzZPMWFVVWJEalc0NFBYUzNjS1l3Y2ZlTmdLczlhcEcy?=
 =?utf-8?B?cmt0S1FlRmNMdGNzc2doMWF1UmMrYnFoOFRzM1djckJqUGgyZjNzWDFHS1ls?=
 =?utf-8?B?VWV4b2llVU9MaStCRS9rb1JpVXNkZ3Z0eE1kVFIzUmhpdFNqUmErRFQ2K29w?=
 =?utf-8?B?bjRDQkFCbVVTS2hVNHhjZVYvcEZWa3RUOVhGelV2cHNBR0JJNWZ1N3ZmeHZw?=
 =?utf-8?B?UkpJQ3NZSi9FQ0RvT3dGNDVUK21vbkhMbGI1TnQ0Tzk0Snd4c1FYcFFGTnVC?=
 =?utf-8?B?bmpmMDJMeEZBU1RjUU5uWjI3dG4zemFTYSs3YVNHb2YyaElxNU9ZdXdGZ0Fk?=
 =?utf-8?B?cS9YU2g4bzRYUU5KYXdIeUVRRUpQYVpqSUVOaDk0TmtUWGQyNDNKMjVXZEJY?=
 =?utf-8?B?Snh4cjg1bU44Nk5Zb1NQY09VV1RBQW5uTUU0UXdrUDZKb3JaNEc5ZlBOOFNK?=
 =?utf-8?B?YXdTemZWbXEwdkp4Z3Z3Nkg1SVR6amFXNDkwaSt1SVVpcGNEak1FNGNubXFo?=
 =?utf-8?B?M1g4Y3VjcmRqQU1xUWhPNnp6dHVpTnB4MUxlUFIvSU5sdVpUK0JXcGVia0Jo?=
 =?utf-8?B?T0o1K1VIU2RrUVdBM2NYQjR4OG5kRFNSR0pNSjZqc01salV3MGdTZ0VFVVlV?=
 =?utf-8?B?TERONnNvRkhnZ2VsY0Q3N2czdUtRMm5XcHhFYk5vVEkxRzJzM2FlRnVEamQ0?=
 =?utf-8?B?Rkh4Sk5wOVNlVlVBeXZzcTVOTngxSU9pRy8ycnpCOE02eUY3eW43QmZrMjNz?=
 =?utf-8?B?RWtkQTBUNGlTY1FHenQ3c29IbFBNSk1iMXZ2TzBXM201UDF6QWZ4ZXhnVW9I?=
 =?utf-8?B?ZDA0WkhPVGEyK0JiajB4dEZ0aFlVeXBHdjZVbWJDMjZhMmNFaktrM3UzdVVN?=
 =?utf-8?B?d0F3Smg3YzBwU0tKWXVmaWxseTNWWWREMTJycUFGeSthVEwvT3gxNGdFYUhY?=
 =?utf-8?Q?GEdHog4J6wTMbSLfDnkjy0gGn2j/D06FAt0L0of5NTGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6117388-aade-4ad2-321a-08db81f58e70
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 09:59:46.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CptEeMRn3tBZPRBYaoooxKSt/DIY0I8QUhfZT2goKZ1xzeehEd6XqSHyKX0KSvTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302
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
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------u0AYaHFTCVO6Z9q7L8VzpSKm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.07.23 um 11:31 schrieb Chen, Guchun:
> [Public]
>
>> -----Original Message-----
>> From: Christian König<ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, July 11, 2023 5:23 PM
>> To: Chen, Guchun<Guchun.Chen@amd.com>; amd-
>> gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Milinkovic, Dusica
>> <Dusica.Milinkovic@amd.com>; Prica, Nikola<Nikola.Prica@amd.com>; Cui,
>> Flora<Flora.Cui@amd.com>
>> Cc:stable@vger.kernel.org
>> Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
>> hrtimer_try_to_cancel
>>
>> Am 11.07.23 um 11:15 schrieb Chen, Guchun:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Christian König<ckoenig.leichtzumerken@gmail.com>
>>>> Sent: Tuesday, July 11, 2023 5:09 PM
>>>> To: Chen, Guchun<Guchun.Chen@amd.com>; amd-
>>>> gfx@lists.freedesktop.org; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>;
>>>> Koenig, Christian<Christian.Koenig@amd.com>; Milinkovic, Dusica
>>>> <Dusica.Milinkovic@amd.com>; Prica, Nikola<Nikola.Prica@amd.com>;
>>>> Cui, Flora<Flora.Cui@amd.com>
>>>> Cc:stable@vger.kernel.org
>>>> Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
>>>> hrtimer_try_to_cancel
>>>>
>>>>
>>>>
>>>> Am 11.07.23 um 03:38 schrieb Guchun Chen:
>>>>> In below thousands of screen rotation loop tests with virtual
>>>>> display enabled, a CPU hard lockup issue may happen, leading system
>>>>> to unresponsive and crash.
>>>>>
>>>>> do {
>>>>>       xrandr --output Virtual --rotate inverted
>>>>>       xrandr --output Virtual --rotate right
>>>>>       xrandr --output Virtual --rotate left
>>>>>       xrandr --output Virtual --rotate normal } while (1);
>>>>>
>>>>> NMI watchdog: Watchdog detected hard LOCKUP on cpu 1
>>>>>
>>>>> ? hrtimer_run_softirq+0x140/0x140
>>>>> ? store_vblank+0xe0/0xe0 [drm]
>>>>> hrtimer_cancel+0x15/0x30
>>>>> amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
>>>>> drm_vblank_disable_and_save+0x185/0x1f0 [drm]
>>>>> drm_crtc_vblank_off+0x159/0x4c0 [drm] ?
>>>>> record_print_text.cold+0x11/0x11 ?
>>>>> wait_for_completion_timeout+0x232/0x280
>>>>> ? drm_crtc_wait_one_vblank+0x40/0x40 [drm] ?
>>>>> bit_wait_io_timeout+0xe0/0xe0 ?
>>>>> wait_for_completion_interruptible+0x1d7/0x320
>>>>> ? mutex_unlock+0x81/0xd0
>>>>> amdgpu_vkms_crtc_atomic_disable
>>>>>
>>>>> It's caused by a stuck in lock dependency in such scenario on
>>>>> different CPUs.
>>>>>
>>>>> CPU1                                             CPU2
>>>>> drm_crtc_vblank_off                              hrtimer_interrupt
>>>>>        grab event_lock (irq disabled)                   __hrtimer_run_queues
>>>>>            grab vbl_lock/vblank_time_block
>>>> amdgpu_vkms_vblank_simulate
>>>>>                amdgpu_vkms_disable_vblank                       drm_handle_vblank
>>>>>                    hrtimer_cancel                                         grab dev->event_lock
>>>>>
>>>>> So CPU1 stucks in hrtimer_cancel as timer callback is running
>>>>> endless on current clock base, as that timer queue on CPU2 has no
>>>>> chance to finish it because of failing to hold the lock. So NMI
>>>>> watchdog will throw the errors after its threshold, and all later
>>>>> CPUs are
>>>> impacted/blocked.
>>>>> So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
>>>>> does not need to wait the handler to finish. And also it's not
>>>>> necessary to check the return value of hrtimer_try_to_cancel,
>>>>> because even if it's
>>>>> -1 which means current timer callback is running, it will be
>>>>> reprogrammed in hrtimer_start with calling enable_vblank to make it
>> works.
>>>>> v2: only re-arm timer when vblank is enabled (Christian) and add a
>>>>> Fixes tag as well
>>>>>
>>>>> v3: drop warn printing (Christian)
>>>>>
>>>>> Fixes: 84ec374bd580("drm/amdgpu: create amdgpu_vkms (v4)")
>>>>> Cc:stable@vger.kernel.org
>>>>> Suggested-by: Christian König<christian.koenig@amd.com>
>>>>> Signed-off-by: Guchun Chen<guchun.chen@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 13 ++++++++++---
>>>>>     1 file changed, 10 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>>>> index 53ff91fc6cf6..b870c827cbaa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
>>>>> @@ -46,7 +46,10 @@ static enum hrtimer_restart
>>>> amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>>>>>       struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct
>>>> amdgpu_crtc, vblank_timer);
>>>>>       struct drm_crtc *crtc = &amdgpu_crtc->base;
>>>>>       struct amdgpu_vkms_output *output =
>>>>> drm_crtc_to_amdgpu_vkms_output(crtc);
>>>>> +   struct drm_vblank_crtc *vblank;
>>>>> +   struct drm_device *dev;
>>>>>       u64 ret_overrun;
>>>>> +   unsigned int pipe;
>>>>>       bool ret;
>>>>>
>>>>>       ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
>>>>> @@ -54,9 +57,13 @@ static enum hrtimer_restart
>>>> amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
>>>>>       if (ret_overrun != 1)
>>>>>               DRM_WARN("%s: vblank timer overrun\n", __func__);
>>>>>
>>>>> +   dev = crtc->dev;
>>>>> +   pipe = drm_crtc_index(crtc);
>>>>> +   vblank = &dev->vblank[pipe];
>>>>>       ret = drm_crtc_handle_vblank(crtc);
>>>>> -   if (!ret)
>>>>> -           DRM_ERROR("amdgpu_vkms failure on handling vblank");
>>>>> +   /* Don't queue timer again when vblank is disabled. */
>>>>> +   if (!ret && !READ_ONCE(vblank->enabled))
>>>>> +           return HRTIMER_NORESTART;
>>>> When drm_crtc_handle_vblank() returns false when vblank is disabled I
>>>> think we can simplify this to just removing the error.
>>>>
>>>> Regards,
>>>> Christian.
>>> Sorry, I didn't get you. What do you mean by "removing the error"?
>> We should just remove the "DRM_ERROR("amdgpu_vkms failure on handling
>> vblank");" message.
>>
>> When the drm_crtc_handle_vblank() returns false it doesn't really indicate a
>> failure, it just indicates that the vblank is disabled and shouldn't be re-armed.
>>
>> Regards,
>> Christian.
> drm_crtc_handle_vblank which is a wrapper of drm_handle_vblank, has two early test calls to check if vblank is initialized. Though this will never happen in our case, I still check the value of vblank->enabled when drm_crtc_handle_vblank returns false, and when it's indeed disabled, return HRTIMER_NORESTART to not re-arm timer, otherwise, returning HRTIMER_RESTART when it's going as expected.
>
> Anything wrong or am I misunderstanding it?

The extra check for vblank enabled in the driver is just superfluous and 
a little bit erroneous, see drm_handle_vblank():

/* Need timestamp lock to prevent concurrent execution with
* vblank enable/disable, as this would cause inconsistent
* or corrupted timestamps and vblank counts.
*/
spin_lock 
<https://elixir.bootlin.com/linux/latest/C/ident/spin_lock>(&dev->vblank_time_lock 
<https://elixir.bootlin.com/linux/latest/C/ident/vblank_time_lock>);

/* Vblank irq handling disabled. Nothing to do. */
if(!vblank 
<https://elixir.bootlin.com/linux/latest/C/ident/vblank>->enabled 
<https://elixir.bootlin.com/linux/latest/C/ident/enabled>){
spin_unlock 
<https://elixir.bootlin.com/linux/latest/C/ident/spin_unlock>(&dev->vblank_time_lock 
<https://elixir.bootlin.com/linux/latest/C/ident/vblank_time_lock>);
spin_unlock_irqrestore 
<https://elixir.bootlin.com/linux/latest/C/ident/spin_unlock_irqrestore>(&dev->event_lock 
<https://elixir.bootlin.com/linux/latest/C/ident/event_lock>,irqflags 
<https://elixir.bootlin.com/linux/latest/C/ident/irqflags>);
returnfalse <https://elixir.bootlin.com/linux/latest/C/ident/false>;
}


This function already checks for us if vblank is enabled/disabled *and* 
it also holds the correct locks to do so.

So we should *not* check that again in the driver, especially not 
without holding the correct locks.

Regards,
Christian.

>
> Regards,
> Guchun
>>> Regards,
>>> Guchun
>>>>>       return HRTIMER_RESTART;
>>>>>     }
>>>>> @@ -81,7 +88,7 @@ static void amdgpu_vkms_disable_vblank(struct
>>>> drm_crtc *crtc)
>>>>>     {
>>>>>       struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
>>>>>
>>>>> -   hrtimer_cancel(&amdgpu_crtc->vblank_timer);
>>>>> +   hrtimer_try_to_cancel(&amdgpu_crtc->vblank_timer);
>>>>>     }
>>>>>
>>>>>     static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc
>>>>> *crtc,

--------------u0AYaHFTCVO6Z9q7L8VzpSKm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 11.07.23 um 11:31 schrieb Chen, Guchun:<br>
    <blockquote type="cite" cite="mid:DM5PR12MB2469C1707C855DEFAC306744F131A@DM5PR12MB2469.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">[Public]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
Sent: Tuesday, July 11, 2023 5:23 PM
To: Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a>; amd-
<a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Hawking
<a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Koenig, Christian
<a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Milinkovic, Dusica
<a class="moz-txt-link-rfc2396E" href="mailto:Dusica.Milinkovic@amd.com">&lt;Dusica.Milinkovic@amd.com&gt;</a>; Prica, Nikola <a class="moz-txt-link-rfc2396E" href="mailto:Nikola.Prica@amd.com">&lt;Nikola.Prica@amd.com&gt;</a>; Cui,
Flora <a class="moz-txt-link-rfc2396E" href="mailto:Flora.Cui@amd.com">&lt;Flora.Cui@amd.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
hrtimer_try_to_cancel

Am 11.07.23 um 11:15 schrieb Chen, Guchun:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[Public]

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">-----Original Message-----
From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
Sent: Tuesday, July 11, 2023 5:09 PM
To: Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a>; amd-
<a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>; Deucher, Alexander
<a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Zhang, Hawking
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>;
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Milinkovic, Dusica
<a class="moz-txt-link-rfc2396E" href="mailto:Dusica.Milinkovic@amd.com">&lt;Dusica.Milinkovic@amd.com&gt;</a>; Prica, Nikola <a class="moz-txt-link-rfc2396E" href="mailto:Nikola.Prica@amd.com">&lt;Nikola.Prica@amd.com&gt;</a>;
Cui, Flora <a class="moz-txt-link-rfc2396E" href="mailto:Flora.Cui@amd.com">&lt;Flora.Cui@amd.com&gt;</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Subject: Re: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
hrtimer_try_to_cancel



Am 11.07.23 um 03:38 schrieb Guchun Chen:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">In below thousands of screen rotation loop tests with virtual
display enabled, a CPU hard lockup issue may happen, leading system
to unresponsive and crash.

do {
     xrandr --output Virtual --rotate inverted
     xrandr --output Virtual --rotate right
     xrandr --output Virtual --rotate left
     xrandr --output Virtual --rotate normal } while (1);

NMI watchdog: Watchdog detected hard LOCKUP on cpu 1

? hrtimer_run_softirq+0x140/0x140
? store_vblank+0xe0/0xe0 [drm]
hrtimer_cancel+0x15/0x30
amdgpu_vkms_disable_vblank+0x15/0x30 [amdgpu]
drm_vblank_disable_and_save+0x185/0x1f0 [drm]
drm_crtc_vblank_off+0x159/0x4c0 [drm] ?
record_print_text.cold+0x11/0x11 ?
wait_for_completion_timeout+0x232/0x280
? drm_crtc_wait_one_vblank+0x40/0x40 [drm] ?
bit_wait_io_timeout+0xe0/0xe0 ?
wait_for_completion_interruptible+0x1d7/0x320
? mutex_unlock+0x81/0xd0
amdgpu_vkms_crtc_atomic_disable

It's caused by a stuck in lock dependency in such scenario on
different CPUs.

CPU1                                             CPU2
drm_crtc_vblank_off                              hrtimer_interrupt
      grab event_lock (irq disabled)                   __hrtimer_run_queues
          grab vbl_lock/vblank_time_block
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_vkms_vblank_simulate
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">              amdgpu_vkms_disable_vblank                       drm_handle_vblank
                  hrtimer_cancel                                         grab dev-&gt;event_lock

So CPU1 stucks in hrtimer_cancel as timer callback is running
endless on current clock base, as that timer queue on CPU2 has no
chance to finish it because of failing to hold the lock. So NMI
watchdog will throw the errors after its threshold, and all later
CPUs are
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">impacted/blocked.
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">So use hrtimer_try_to_cancel to fix this, as disable_vblank callback
does not need to wait the handler to finish. And also it's not
necessary to check the return value of hrtimer_try_to_cancel,
because even if it's
-1 which means current timer callback is running, it will be
reprogrammed in hrtimer_start with calling enable_vblank to make it
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">works.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">
v2: only re-arm timer when vblank is enabled (Christian) and add a
Fixes tag as well

v3: drop warn printing (Christian)

Fixes: 84ec374bd580(&quot;drm/amdgpu: create amdgpu_vkms (v4)&quot;)
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@vger.kernel.org">stable@vger.kernel.org</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Guchun Chen <a class="moz-txt-link-rfc2396E" href="mailto:guchun.chen@amd.com">&lt;guchun.chen@amd.com&gt;</a>
---
   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 13 ++++++++++---
   1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 53ff91fc6cf6..b870c827cbaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -46,7 +46,10 @@ static enum hrtimer_restart
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     struct amdgpu_crtc *amdgpu_crtc = container_of(timer, struct
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_crtc, vblank_timer);
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     struct drm_crtc *crtc = &amp;amdgpu_crtc-&gt;base;
     struct amdgpu_vkms_output *output =
drm_crtc_to_amdgpu_vkms_output(crtc);
+   struct drm_vblank_crtc *vblank;
+   struct drm_device *dev;
     u64 ret_overrun;
+   unsigned int pipe;
     bool ret;

     ret_overrun = hrtimer_forward_now(&amp;amdgpu_crtc-&gt;vblank_timer,
@@ -54,9 +57,13 @@ static enum hrtimer_restart
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     if (ret_overrun != 1)
             DRM_WARN(&quot;%s: vblank timer overrun\n&quot;, __func__);

+   dev = crtc-&gt;dev;
+   pipe = drm_crtc_index(crtc);
+   vblank = &amp;dev-&gt;vblank[pipe];
     ret = drm_crtc_handle_vblank(crtc);
-   if (!ret)
-           DRM_ERROR(&quot;amdgpu_vkms failure on handling vblank&quot;);
+   /* Don't queue timer again when vblank is disabled. */
+   if (!ret &amp;&amp; !READ_ONCE(vblank-&gt;enabled))
+           return HRTIMER_NORESTART;
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">When drm_crtc_handle_vblank() returns false when vblank is disabled I
think we can simplify this to just removing the error.

Regards,
Christian.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Sorry, I didn't get you. What do you mean by &quot;removing the error&quot;?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
We should just remove the &quot;DRM_ERROR(&quot;amdgpu_vkms failure on handling
vblank&quot;);&quot; message.

When the drm_crtc_handle_vblank() returns false it doesn't really indicate a
failure, it just indicates that the vblank is disabled and shouldn't be re-armed.

Regards,
Christian.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
drm_crtc_handle_vblank which is a wrapper of drm_handle_vblank, has two early test calls to check if vblank is initialized. Though this will never happen in our case, I still check the value of vblank-&gt;enabled when drm_crtc_handle_vblank returns false, and when it's indeed disabled, return HRTIMER_NORESTART to not re-arm timer, otherwise, returning HRTIMER_RESTART when it's going as expected.

Anything wrong or am I misunderstanding it?</pre>
    </blockquote>
    <br>
    The extra check for vblank enabled in the driver is just superfluous
    and a little bit erroneous, see drm_handle_vblank():<br>
    <br>
    <pre><span class="w">	</span><span class="cm">/* Need timestamp lock to prevent concurrent execution with</span>
<span class="cm">	 * vblank enable/disable, as this would cause inconsistent</span>
<span class="cm">	 * or corrupted timestamps and vblank counts.</span>
<span class="cm">	 */</span><span class="w"></span>
<span class="w">	</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/spin_lock">spin_lock</a></span><span class="p">(</span><span class="o">&amp;</span><span class="n">dev</span><span class="o">-&gt;</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/vblank_time_lock">vblank_time_lock</a></span><span class="p">);</span><span class="w"></span>

<span class="w">	</span><span class="cm">/* Vblank irq handling disabled. Nothing to do. */</span><span class="w"></span>
<span class="w">	</span><span class="k">if</span><span class="w"> </span><span class="p">(</span><span class="o">!</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/vblank">vblank</a></span><span class="o">-&gt;</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/enabled">enabled</a></span><span class="p">)</span><span class="w"> </span><span class="p">{</span><span class="w"></span>
<span class="w">		</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/spin_unlock">spin_unlock</a></span><span class="p">(</span><span class="o">&amp;</span><span class="n">dev</span><span class="o">-&gt;</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/vblank_time_lock">vblank_time_lock</a></span><span class="p">);</span><span class="w"></span>
<span class="w">		</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/spin_unlock_irqrestore">spin_unlock_irqrestore</a></span><span class="p">(</span><span class="o">&amp;</span><span class="n">dev</span><span class="o">-&gt;</span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/event_lock">event_lock</a></span><span class="p">,</span><span class="w"> </span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/irqflags">irqflags</a></span><span class="p">);</span><span class="w"></span>
<span class="w">		</span><span class="k">return</span><span class="w"> </span><span class="n"><a href="https://elixir.bootlin.com/linux/latest/C/ident/false">false</a></span><span class="p">;</span><span class="w"></span>
<span class="w">	</span><span class="p">}</span><span class="w"></span></pre>
    <span class="p"></span><span class="w"></span><br>
    This function already checks for us if vblank is enabled/disabled
    *and* it also holds the correct locks to do so.<br>
    <br>
    So we should *not* check that again in the driver, especially not
    without holding the correct locks.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DM5PR12MB2469C1707C855DEFAC306744F131A@DM5PR12MB2469.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Guchun
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Regards,
Guchun
</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">     return HRTIMER_RESTART;
   }
@@ -81,7 +88,7 @@ static void amdgpu_vkms_disable_vblank(struct
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">drm_crtc *crtc)
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">   {
     struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);

-   hrtimer_cancel(&amp;amdgpu_crtc-&gt;vblank_timer);
+   hrtimer_try_to_cancel(&amp;amdgpu_crtc-&gt;vblank_timer);
   }

   static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc
*crtc,
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------u0AYaHFTCVO6Z9q7L8VzpSKm--
