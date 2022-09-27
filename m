Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D3AC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 18:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD5610E0A7;
	Tue, 27 Sep 2022 18:20:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA1610E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 18:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu+QQQbw7/LCJvhq1hXv69F8VTDZeQG67K2sK/V7PIhpKwNwraJGwX0s4lD+ZYkchwsVfZu5wjEvludFTTSlvdw4ki7zeGY+BdB9GZQ5/kXCGcwf6nE1SjpanHmkl6ulGH9xABJdoRA1elsuI4Hqt38ZFdIPzl9mN0FNGbWrXmr1h/7QR1v6O52wiojZagGWI3T28isaYnX3h+tKV2sAjcffhreZPRGzjiHRTGPQbf9x1qWhPe5CfI+U90LHgq20kKdE9I8uFgObys2Xqi1nY5LtXhpm1FhrUbgjAwCbEjpwlwNajmBoeMSy+Fic87EK85dGKQoXLUhACobYf0pl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTBpkducYolz3OmuhiIpWAJxvq07tAOTPyw70SIYsXc=;
 b=EkVEboG+aan78IJVP0ZBvRewDw52m6vgBU7729Loy7tOWV3WmELwxEPAwGJn3id9vafR8HjV6KTCX0U4Ya4oGw8kUZVnTQunP/dizOmaneafcXu7UYkxcaPoRVGpoT6wHniszmr4XV1oXHlo2tLzcjnmy9x5XcuG2dY8QvresDXERanudftCTW2SiAcxWSV/yDNuVDO1INmMfDIw8LgaTmvwE3lVt8jNx60Ap+RwZF9FRxLrodn0xg3Xb1pysbifDaQt7wi9eHvf+8WXfxBkpjYeVmC2fz3XwPZuJk1Jx/InhDILPCKNA8s+lokAIZomAYQz+uwBZ45hnzf4VL47qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTBpkducYolz3OmuhiIpWAJxvq07tAOTPyw70SIYsXc=;
 b=IAbZbQoBCbW5vo9s9S/XExjFH0wQrVxckSkgpNfUvcU02Lv78vwvhkYdPMGPQ3qpMorLsDHcLgYa/MSWGc0qz6z/BvLncjGUl/rJOkEMWIOzBW5Yuz6Vw98DTVUCsYSn+MNtIR32KPKS6WzDlb/e2Bqas1ziNSPilrpnuEK/WiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 18:20:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 18:20:28 +0000
Message-ID: <4c9c09b3-abbd-1dff-33f6-e9478e8a137c@amd.com>
Date: Tue, 27 Sep 2022 20:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v6)
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <20220923131630.1260501-1-jiadong.zhu@amd.com>
 <20220923131630.1260501-4-jiadong.zhu@amd.com>
 <3d88b423-1d14-2954-e3ce-0c50887cf621@gmail.com>
 <DS7PR12MB633336F275D92829CA93BF2CF4559@DS7PR12MB6333.namprd12.prod.outlook.com>
 <fad25aa5-3f0a-0135-e580-1c96bfc37120@amd.com>
 <6a8623f8-941f-4fa4-b0e4-0beb9b4715b3@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <6a8623f8-941f-4fa4-b0e4-0beb9b4715b3@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ce1340-ebe0-4a5f-17e5-08daa0b4f44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fweVtDsGnZEKMKgR8flshGULGsmiw5eqBXTMGIX5a7KhpPZKRGaBVttxzCTr2jKseNW7gjQBpAvLfdjie4O80ihdcjIO2jH4NJBRAeciJssBIXNEo2IW5b3m3xaL3ov7pXn76ePBZXZeNt+PfLBa9QbNTPctleZj9cXwcg+D/uT6bzKK7XKcy0qhyjRaTobaSTK8RwoKv1BNWBWqhfrDSGkCTGxLQdXt3NgjhPA2iB/eeGqQ/LeFXIC6mL6Yw7UqGFWFDwNf37kRfgQqopGDrENCGBGmucU+Zex6cyR6Dp7/ptbwgSsXZ9NurbM1LKBxoBn7QhnNEi68oQnIHrIEPkmQw9013LSYklw7Hh/w3PF78tWn+jmrzTRcNTfXWkX777B9i1FvLo3Hto30D0IKzTPcmDPC8P9c+7QA4goYBPywrhl6xd2UGu1SqCsbyBcrSDR0FpimSJx2WSQrvpbRxdncr3m5ZY5fZQuq3vyi478lO6k5MI6I7tJ5I2lw5fjqjGQOT8VgO4HHoXzvnn9f47KR8nNJE3TT7vBBfWvkTZgOIkGhcgUpE2J+yOWIHEeF5RT33bskEfP9hP0WUy/QIEYgNV7fGOmfVu2HeWw6eFwNfiYFsKLo6q8jOIWKS3dU5ue3lV238mSm+9u9muVqH/CMBuvLcNVu1DMp3bjS6r547SkxpcHYbvNO5tBJ0Rddc8mkertn1L5yXCOmJAdkl9gfjrUVz9mi0Lo8OoYC5dMIKpBVAjvk+t92Y/ht7eJe3+ryaHkWtPKjqBHFdaw8rF/wUbFnu3ASny5+sZnXAJbP5a4orXeMgJZ5Rbtl1tHDq/yM4Aru4vGKKCqGpUV0Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(316002)(6512007)(54906003)(6916009)(41300700001)(36756003)(2906002)(31696002)(86362001)(8676002)(66946007)(66476007)(4326008)(66556008)(478600001)(45080400002)(83380400001)(186003)(6486002)(966005)(53546011)(6506007)(38100700002)(2616005)(6666004)(66574015)(30864003)(31686004)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2twWS85cDhsYWY2bWhhUTJjSUgxV1g0UWhaV0lzekNmTGdhVGRkRXBpT2V4?=
 =?utf-8?B?U1FYTEVxM0ZQemQvWS82RVNJSitHQmRaSkJ2Nno4TGszcnQwSWNJT1gxTU5u?=
 =?utf-8?B?VkNRMnBqdStqK09DYnJLVEsxTUpuU20vckpaeGJwb2o0ZWVra2xKak81NGph?=
 =?utf-8?B?YUFzOWF5S2pUaU9HWkdXNVVPTU1zWThrcFJISXJhQlJ3QVVrdWF4TUpxMG5k?=
 =?utf-8?B?ZGIvQktFVmlPLzhMYzJhVy9hUkpPdm5XUEJYN0dnVGwxcGI5QnhGSzFrSUFk?=
 =?utf-8?B?WHB6VUk4WDZ6amFlRm5VSHhJL2hGbXkreGU4NUNYa1RmYTJOcnJJUjBEWFJO?=
 =?utf-8?B?NEF4YW5RVmswalUvTzFzcjZDSTFJaEFkV2I4SzB3UDVrRWVEaWd1Mll3b0FL?=
 =?utf-8?B?TFByWXZyazdVWHBVbzNLQnZBbTZRQWkzdklsVS95VmxUaFRqRGtWYWlVeWM4?=
 =?utf-8?B?TU1zMkNyWjBybWtoYWFmUkpHNGNxNVZYeVcweExYMS9WVEl1bzE3S1UvT0pv?=
 =?utf-8?B?YjJ0Ny91by96cXE0aCsrWFo1ZDcwV0xCc3FWMVFpUFJjU1dWcUZQcEZwV3I3?=
 =?utf-8?B?NnBzUXR1ZitJaE9NS2ZPd2h1VEJuT3d6akhhRkNjRXFqZjZlOENjSTl4Q2V3?=
 =?utf-8?B?bGxFbjJPMlBlMnR2RXFHQkxKS0V3MTJBQUNLNEpLTm14cFB1L2gxNks1WENs?=
 =?utf-8?B?Q1hQZHFEZUMvZjlwY0RUZzVyMHBzVVI3ZnI4MDBlYUcwazFZbTFSRS9MeVNt?=
 =?utf-8?B?eE5wN3FHaUt5SmhSY0drTFRUNlRRNlU4alhCVXlsVTAzRDhPZ1JlWlVLMStG?=
 =?utf-8?B?QUpxL3djc1JPMUFrR2RLcGlQTjYyQXRlT1QvSFluOCtib3AwQXpmVHBpQmdZ?=
 =?utf-8?B?Z0FXOTVDR0svTkt0RkpmV05TZEpuTll6ZGJpNWUzWUYzUlhYQ1NDdUFLYzds?=
 =?utf-8?B?QURzMEFKdENoZG92aCtWR2IxVlliejlhdCtuK2JWN3lZeG5tWHJodllSczA2?=
 =?utf-8?B?UUxhcHc3N1p5YkpvR3QybzVxNWJwc21NMnNnK04vckpzVGlNK2RJVlJVN1lU?=
 =?utf-8?B?Z1NYMlJOeklTVlowaU5xdFhFSjNDZzliNklNUHc1VFBaK1ZMaGhtY3lMUGFU?=
 =?utf-8?B?UWg3L2N3NjhtVTlPZUkwTEV4em5jWXpHTHRqd0E5SUsya1V4ajVGaStLb2g0?=
 =?utf-8?B?YVpCV2lIN092TlB5ZEx6V293Ymw3dml0eEF5dU1oMnV1NkQyd3RvcFEwcWRH?=
 =?utf-8?B?Nm5TRWFzcjJSYVdCTEt4ME5ER2tURVI0aG83bzB1KzZQZGZ0ZmszKzZpR053?=
 =?utf-8?B?eGJpd3NkY0hTVXR6MEcxQnhadjFRUUs1WmNrQlkzWVVOSU9PSlppUVdvamVF?=
 =?utf-8?B?TXZtaXJVeXJLN1lFb1FuTisxNDlacWpZRGpRWS9yRHNBYU9EZ25waC9PMURI?=
 =?utf-8?B?ZXdLblBQSzRiUTBNU0FSbFVkTGlXczZSM2VzaGdrc2pxWk93NnkwQmtQMWdO?=
 =?utf-8?B?RG80aW9Hem5zdTBGbWhWN1QvQk1SWTk0SURYdnFsOGFjL0hlejBZRzFIYldD?=
 =?utf-8?B?MDJHMFpoV2l4RGlBcGlMdU82aFI0bm91bXg1SmlLRkwzdGtvT1NmUDJ5ODVH?=
 =?utf-8?B?UGdhTmhnOE92dkZmUUs1YktzZUlyd0l0MXlVL0FDODlHUnVPNmJmUVZ2QUVk?=
 =?utf-8?B?cDJ6a0RNMUpQV2RZb0Vpc3laV002cXZIbklvTWZtWUoxU3I2WFhQcE1UNFMy?=
 =?utf-8?B?dTdGZmdyNEd2SjlHb0NQcyt4cWx4YVAveHVFbWM5SE5vb0hxeUExeVQzSjBr?=
 =?utf-8?B?NEJ1THppMlp1aWJnVE1wNWM2TVBLVWhxd1orQ2RWWHhGWHNRb3VNV1d3L1k2?=
 =?utf-8?B?bVdXTjQxQXN5Zk8yemViakFUK05IQnhBelp1K0hldkZwbmFyN1B6ZVZBcGtj?=
 =?utf-8?B?UmVZT1lpSjQxaVFtbFhRNlhjRmo3SDVON3JKeXVzeGJUb3dJdUtSNlkwN29r?=
 =?utf-8?B?amJIb2MwYzQwRnlKQlNlU1FnSmNQRForKzBNL1ZYaXZQRU83cDNTcTdJdno1?=
 =?utf-8?B?YlFiTTJzWU1GVlVvWW1pbzBnMHExa0VKTCs5WStGTU1FYXp0WjRRQjhDSnV6?=
 =?utf-8?B?RWdYRE9Td2QzYThnQjVJQkVUSDQwODFTTDg4c1dCYXJoQ1dWd2tGZlppSGlu?=
 =?utf-8?Q?1UCPsqimUXBfFTCZvzw8zioykgU+4PM93Qtzyxiru+8T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ce1340-ebe0-4a5f-17e5-08daa0b4f44b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 18:20:28.2122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFn8eyZLcDiPP5gtLmZnqozP4SBkCc/h52UKgy4mvXbIPmTi0/qmCadpUIOe9Vwn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This work is solely for gfx9 (e.g. Vega) and older.

Navi has a completely separate high priority gfx queue we can use for this.

Thanks,
Christian.

Am 27.09.22 um 19:49 schrieb Michel Dänzer:
> On 2022-09-27 08:06, Christian König wrote:
>> Hey Michel,
>>
>> JIadong is working on exposing high/low priority gfx queues for gfx9 and older hw generations by using mid command buffer preemption.
> Yeah, I've been keeping an eye on these patches. I'm looking forward to this working.
>
>
>> I know that you have been working on Gnome Mutter to make use from userspace for this. Do you have time to run some tests with that?
> I just tested the v8 series (first without amdgpu.mcbp=1 on the kernel command line, then with it, since I wasn't sure if it's needed) with https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.gnome.org%2FGNOME%2Fmutter%2F-%2Fmerge_requests%2F1880&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7Cc6345d9230004549ba4d08daa0b0abcd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637998977913548768%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=P1Qo2AwDmfmPrxJe2SxTFsVjdJ9vjabK8s84ZVz%2Beh8%3D&amp;reserved=0 on Navi 14.
>
> Unfortunately, I'm not seeing any change in behaviour. Even though mutter uses a high priority context via the EGL_IMG_context_priority extension, it's unable to reach a higher frame rate than a GPU-limited client[0]. The "Last preempted" line of /sys/kernel/debug/dri/0/amdgpu_fence_info remains at 0x00000000.
>
> Did I miss a step?
>
>
> [0] I used the GpuTest pixmark piano & plot3d benchmarks. With an Intel iGPU, mutter can achieve a higher frame rate than plot3d, though not than pixmark piano (presumably due to limited GPU preemption granularity).
>
>> Am 27.09.22 um 05:18 schrieb Zhu, Jiadong:
>>> [AMD Official Use Only - General]
>>>
>>>> I need more time for an in deep review of this, but form the one mile high view it looks correct to me now.
>>>> Can we do some pre-commit qa testing with this?
>>> I changed drm test "Command submission Test (GFX)" to send high priority ibs meanwhile running Manhattan on Screen/Unigine heaven foreground, checking mcbp/resubmit triggered by cat /sys/kernel/debug/dri/0/amdgpu_fence_info
>>>
>>> I have continued running this scenario for 2 daytime and 1 night, no hangs happen yet(lots of hangs has been fixed in the previous patches).
>>>
>>> I will ask QA team to do more test.
>>>
>>> Thanks,
>>> JIadong
>>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Monday, September 26, 2022 2:49 PM
>>> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>>> Subject: Re: [PATCH 4/4] drm/amdgpu: MCBP based on DRM scheduler (v6)
>>>
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> Am 23.09.22 um 15:16 schrieb jiadong.zhu@amd.com:
>>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>>
>>>> Trigger Mid-Command Buffer Preemption according to the priority of the
>>>> software rings and the hw fence signalling condition.
>>>>
>>>> The muxer saves the locations of the indirect buffer frames from the
>>>> software ring together with the fence sequence number in its fifo
>>>> queue, and pops out those records when the fences are signalled. The
>>>> locations are used to resubmit packages in preemption scenarios by coping the chunks from the software ring.
>>>>
>>>> v2: Update comment style.
>>>> v3: Fix conflict caused by previous modifications.
>>>> v4: Remove unnecessary prints.
>>>> v5: Fix corner cases for resubmission cases.
>>>> v6: Refactor functions for resubmission, calling fence_process in irq handler.
>>>>
>>>> Cc: Christian Koenig <Christian.Koenig@amd.com>
>>>> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
>>>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>>>> Acked-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>>> I need more time for an in deep review of this, but form the one mile high view it looks correct to me now.
>>>
>>> Can we do some pre-commit qa testing with this?
>>>
>>> Thanks,
>>> Christian.
>>>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  13 +
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 323 ++++++++++++++++---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  30 ++
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  26 ++
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c       |   2 +
>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  10 +-
>>>>     8 files changed, 368 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> index 258cffe3c06a..af86d87e2f3b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>> @@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>>                 }
>>>>         }
>>>>
>>>> +     amdgpu_ring_ib_begin(ring);
>>>>         if (job && ring->funcs->init_cond_exec)
>>>>                 patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>>
>>>> @@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>>>>             ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
>>>>                 ring->funcs->emit_wave_limit(ring, false);
>>>>
>>>> +     amdgpu_ring_ib_end(ring);
>>>>         amdgpu_ring_commit(ring);
>>>>         return 0;
>>>>     }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> index 13db99d653bd..84b0b3c7d40f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>> @@ -33,6 +33,7 @@
>>>>
>>>>     #include <drm/amdgpu_drm.h>
>>>>     #include "amdgpu.h"
>>>> +#include "amdgpu_sw_ring.h"
>>>>     #include "atom.h"
>>>>
>>>>     /*
>>>> @@ -569,3 +570,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring
>>>> *ring)
>>>>
>>>>         return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
>>>>     }
>>>> +
>>>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring) {
>>>> +     if (ring->is_sw_ring)
>>>> +             amdgpu_sw_ring_ib_begin(ring); }
>>>> +
>>>> +void amdgpu_ring_ib_end(struct amdgpu_ring *ring) {
>>>> +     if (ring->is_sw_ring)
>>>> +             amdgpu_sw_ring_ib_end(ring); }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> index e90d327a589e..6fbc1627dab7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>> @@ -312,6 +312,9 @@ struct amdgpu_ring {
>>>>     #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
>>>>
>>>>     int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>>> +void amdgpu_ring_ib_begin(struct amdgpu_ring *ring); void
>>>> +amdgpu_ring_ib_end(struct amdgpu_ring *ring);
>>>> +
>>>>     void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
>>>>     void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
>>>>     void amdgpu_ring_commit(struct amdgpu_ring *ring); diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>> index 662aadebf111..788567e3b743 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>> @@ -28,23 +28,146 @@
>>>>
>>>>     #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
>>>>
>>>> +static struct kmem_cache *amdgpu_mux_chunk_slab;
>>>> +
>>>> +static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
>>>> +                                                             struct
>>>> +amdgpu_ring *ring) {
>>>> +     return ring->entry_index < mux->ring_entry_size ?
>>>> +                     &mux->ring_entry[ring->entry_index] : NULL; }
>>>> +
>>>> +/* copy packages on sw ring range[begin, end) */ static void
>>>> +amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>>>> +                                               struct amdgpu_ring *ring,
>>>> +                                               u64 s_start, u64
>>>> +s_end) {
>>>> +     u64 start, end;
>>>> +     struct amdgpu_ring *real_ring = mux->real_ring;
>>>> +
>>>> +     start = s_start & ring->buf_mask;
>>>> +     end = s_end & ring->buf_mask;
>>>> +
>>>> +     if (start == end) {
>>>> +             DRM_ERROR("no more data copied from sw ring\n");
>>>> +             return;
>>>> +     }
>>>> +     if (start > end) {
>>>> +             amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
>>>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
>>>> +                                        (ring->ring_size >> 2) - start);
>>>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>>>> +     } else {
>>>> +             amdgpu_ring_alloc(real_ring, end - start);
>>>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>>>> +     }
>>>> +}
>>>> +
>>>> +static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux,
>>>> +bool is_fallback) {
>>>> +     struct amdgpu_mux_entry *e = NULL;
>>>> +     struct amdgpu_mux_chunk *chunk;
>>>> +     uint32_t seq, last_seq;
>>>> +     int i;
>>>> +
>>>> +     if (is_fallback) {
>>>> +             if (!spin_trylock(&mux->lock)) {
>>>> +                     amdgpu_ring_mux_schedule_resubmit(mux);
>>>> +                     DRM_ERROR("reschedule resubmit\n");
>>>> +                     return;
>>>> +             }
>>>> +     } else {
>>>> +             spin_lock(&mux->lock);
>>>> +     }
>>>> +
>>>> +     /*find low priority entries:*/
>>>> +     if (!mux->s_resubmit) {
>>>> +             spin_unlock(&mux->lock);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>>> +             if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>>>> +                     e = &mux->ring_entry[i];
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (!e) {
>>>> +             DRM_ERROR("%s no low priority ring found\n", __func__);
>>>> +             spin_unlock(&mux->lock);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     last_seq = atomic_read(&e->ring->fence_drv.last_seq);
>>>> +     seq = mux->seqno_to_resubmit;
>>>> +     if (last_seq < seq) {
>>>> +             /*resubmit all the fences between (last_seq, seq]*/
>>>> +             list_for_each_entry(chunk, &e->list, entry) {
>>>> +                     if (chunk->sync_seq > last_seq && chunk->sync_seq <= seq) {
>>>> +                             amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, e->ring,
>>>> +                                                                   chunk->start,
>>>> +                                                                   chunk->end);
>>>> +                             mux->wptr_resubmit = chunk->end;
>>>> +                             amdgpu_ring_commit(mux->real_ring);
>>>> +                     }
>>>> +             }
>>>> +     }
>>>> +
>>>> +     del_timer(&mux->resubmit_timer);
>>>> +     mux->s_resubmit = false;
>>>> +     spin_unlock(&mux->lock);
>>>> +}
>>>> +
>>>> +static void amdgpu_mux_resubmit_fallback(struct timer_list *t) {
>>>> +     struct amdgpu_ring_mux *mux = from_timer(mux, t,
>>>> +resubmit_timer);
>>>> +
>>>> +     DRM_INFO("calling %s\n", __func__);
>>>> +     amdgpu_mux_resubmit_chunks(mux, true); }
>>>> +
>>>>     int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>>>>                          unsigned int entry_size)
>>>>     {
>>>>         mux->real_ring = ring;
>>>>         mux->num_ring_entries = 0;
>>>> +
>>>>         mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
>>>>         if (!mux->ring_entry)
>>>>                 return -ENOMEM;
>>>>
>>>>         mux->ring_entry_size = entry_size;
>>>> +     mux->s_resubmit = false;
>>>> +
>>>> +     amdgpu_mux_chunk_slab = kmem_cache_create("amdgpu_mux_chunk",
>>>> +                                               sizeof(struct amdgpu_mux_chunk), 0,
>>>> +                                               SLAB_HWCACHE_ALIGN, NULL);
>>>> +     if (!amdgpu_mux_chunk_slab) {
>>>> +             DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
>>>> +             return -ENOMEM;
>>>> +     }
>>>> +
>>>>         spin_lock_init(&mux->lock);
>>>> +     timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback,
>>>> + 0);
>>>>
>>>>         return 0;
>>>>     }
>>>>
>>>>     void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>>>>     {
>>>> +     struct amdgpu_mux_entry *e;
>>>> +     struct amdgpu_mux_chunk *chunk, *chunk2;
>>>> +     int i;
>>>> +
>>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>>> +             e = &mux->ring_entry[i];
>>>> +             list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
>>>> +                     list_del(&chunk->entry);
>>>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>>>> +             }
>>>> +     }
>>>> +     kmem_cache_destroy(amdgpu_mux_chunk_slab);
>>>>         kfree(mux->ring_entry);
>>>>         mux->ring_entry = NULL;
>>>>         mux->num_ring_entries = 0;
>>>> @@ -64,62 +187,46 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
>>>>         ring->entry_index = mux->num_ring_entries;
>>>>         e->ring = ring;
>>>>
>>>> +     INIT_LIST_HEAD(&e->list);
>>>>         mux->num_ring_entries += 1;
>>>>         return 0;
>>>>     }
>>>>
>>>> -static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
>>>> -                                                             struct amdgpu_ring *ring)
>>>> -{
>>>> -     return ring->entry_index < mux->ring_entry_size ?
>>>> -                     &mux->ring_entry[ring->entry_index] : NULL;
>>>> -}
>>>> -
>>>> -/* copy packages on sw ring range[begin, end) */ -static void
>>>> amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>>>> -                                               struct amdgpu_ring *ring,
>>>> -                                               u64 s_start, u64 s_end)
>>>> -{
>>>> -     u64 start, end;
>>>> -     struct amdgpu_ring *real_ring = mux->real_ring;
>>>> -
>>>> -     start = s_start & ring->buf_mask;
>>>> -     end = s_end & ring->buf_mask;
>>>> -
>>>> -     if (start == end) {
>>>> -             DRM_ERROR("no more data copied from sw ring\n");
>>>> -             return;
>>>> -     }
>>>> -     if (start > end) {
>>>> -             amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
>>>> -             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
>>>> -                                        (ring->ring_size >> 2) - start);
>>>> -             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>>>> -     } else {
>>>> -             amdgpu_ring_alloc(real_ring, end - start);
>>>> -             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
>>>> -     }
>>>> -}
>>>> -
>>>>     void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
>>>>     {
>>>>         struct amdgpu_mux_entry *e;
>>>>
>>>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT)
>>>> +             amdgpu_mux_resubmit_chunks(mux, false);
>>>> +
>>>>         e = amdgpu_ring_mux_sw_entry(mux, ring);
>>>>         if (!e) {
>>>>                 DRM_ERROR("cannot find entry for sw ring\n");
>>>>                 return;
>>>>         }
>>>>
>>>> +     /* We could skip this set wptr as preemption in process. */
>>>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && mux->pending_trailing_fence_signaled) {
>>>> +             DRM_ERROR("amdgpu_ring_mux_set_wptr skipped\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>>         spin_lock(&mux->lock);
>>>>         e->sw_cptr = e->sw_wptr;
>>>> +     /* Update cptr if the package already copied in resubmit functions */
>>>> +     if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && e->sw_cptr < mux->wptr_resubmit)
>>>> +             e->sw_cptr = mux->wptr_resubmit;
>>>>         e->sw_wptr = wptr;
>>>>         e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>>>
>>>> -     amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>>>> -     e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>>> -     amdgpu_ring_commit(mux->real_ring);
>>>> -
>>>> +     /* Skip copying for the packages already resubmitted.*/
>>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT || mux->wptr_resubmit < wptr) {
>>>> +             amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
>>>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>>> +             amdgpu_ring_commit(mux->real_ring);
>>>> +     } else {
>>>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>>> +     }
>>>>         spin_unlock(&mux->lock);
>>>>     }
>>>>
>>>> @@ -181,3 +288,145 @@ u64 amdgpu_ring_mux_get_rptr(struct
>>>> amdgpu_ring_mux *mux, struct amdgpu_ring *ri
>>>>
>>>>         return e->sw_rptr;
>>>>     }
>>>> +
>>>> +void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux) {
>>>> +     mod_timer(&mux->resubmit_timer, jiffies +
>>>> +AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
>>>> +}
>>>> +
>>>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>>>> +amdgpu_ring *ring) {
>>>> +     struct amdgpu_mux_entry *e;
>>>> +     struct amdgpu_mux_chunk *chunk;
>>>> +
>>>> +     amdgpu_mux_resubmit_chunks(mux, false);
>>>> +
>>>> +     e = amdgpu_ring_mux_sw_entry(mux, ring);
>>>> +     if (!e) {
>>>> +             DRM_ERROR("cannot find entry!\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
>>>> +     if (!chunk) {
>>>> +             DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     chunk->start = ring->wptr;
>>>> +     list_add_tail(&chunk->entry, &e->list); }
>>>> +
>>>> +static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux
>>>> +*mux, struct amdgpu_ring *ring) {
>>>> +     uint32_t last_seq, size = 0;
>>>> +     struct amdgpu_mux_entry *e;
>>>> +     struct amdgpu_mux_chunk *chunk, *tmp;
>>>> +
>>>> +     e = amdgpu_ring_mux_sw_entry(mux, ring);
>>>> +     if (!e) {
>>>> +             DRM_ERROR("cannot find entry!\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     last_seq = atomic_read(&ring->fence_drv.last_seq);
>>>> +
>>>> +     list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
>>>> +             if (chunk->sync_seq <= last_seq) {
>>>> +                     list_del(&chunk->entry);
>>>> +                     kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
>>>> +             } else {
>>>> +                     size++;
>>>> +             }
>>>> +     }
>>>> +}
>>>> +
>>>> +void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct
>>>> +amdgpu_ring *ring) {
>>>> +     struct amdgpu_mux_entry *e;
>>>> +     struct amdgpu_mux_chunk *chunk;
>>>> +
>>>> +     e = amdgpu_ring_mux_sw_entry(mux, ring);
>>>> +     if (!e) {
>>>> +             DRM_ERROR("cannot find entry!\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
>>>> +     if (!chunk) {
>>>> +             DRM_ERROR("cannot find chunk!\n");
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     chunk->end = ring->wptr;
>>>> +     chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
>>>> +
>>>> +     scan_and_remove_signaled_chunk(mux, ring); }
>>>> +
>>>> +/* Trigger Mid-Command Buffer Preemption (MCBP) and find if we need
>>>> +to resubmit. */ int amdgpu_mcbp_trigger_preempt(struct
>>>> +amdgpu_ring_mux *mux) {
>>>> +     int r;
>>>> +
>>>> +     spin_lock(&mux->lock);
>>>> +     mux->pending_trailing_fence_signaled = true;
>>>> +     r = amdgpu_ring_preempt_ib(mux->real_ring);
>>>> +     spin_unlock(&mux->lock);
>>>> +     return r;
>>>> +}
>>>> +
>>>> +bool amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux
>>>> +*mux) {
>>>> +     struct amdgpu_mux_entry *e;
>>>> +     struct amdgpu_ring *ring = NULL;
>>>> +     int i;
>>>> +
>>>> +     if (!mux->pending_trailing_fence_signaled)
>>>> +             return false;
>>>> +
>>>> +     if (mux->real_ring->trail_seq != le32_to_cpu(*mux->real_ring->trail_fence_cpu_addr))
>>>> +             return false;
>>>> +
>>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>>> +             e = &mux->ring_entry[i];
>>>> +             if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
>>>> +                     ring = e->ring;
>>>> +                     break;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     if (!ring) {
>>>> +             DRM_ERROR("cannot find low priority ring\n");
>>>> +             return false;
>>>> +     }
>>>> +
>>>> +     amdgpu_fence_process(ring);
>>>> +     if (amdgpu_fence_count_emitted(ring) > 0) {
>>>> +             mux->s_resubmit = true;
>>>> +             mux->seqno_to_resubmit = ring->fence_drv.sync_seq;
>>>> +             amdgpu_ring_mux_schedule_resubmit(mux);
>>>> +     }
>>>> +
>>>> +     mux->pending_trailing_fence_signaled = false;
>>>> +     return true;
>>>> +}
>>>> +
>>>> +/*scan on low prio rings to have unsignaled fence and high ring has
>>>> +no fence.*/ int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux) {
>>>> +     struct amdgpu_ring *ring;
>>>> +     int i, need_preempt;
>>>> +
>>>> +     need_preempt = 0;
>>>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>>>> +             ring = mux->ring_entry[i].ring;
>>>> +             if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT &&
>>>> +                     amdgpu_fence_count_emitted(ring) > 0)
>>>> +                     return 0;
>>>> +             if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT &&
>>>> +                     amdgpu_fence_count_emitted(ring) > 0)
>>>> +                     need_preempt = 1;
>>>> +     }
>>>> +     return need_preempt && !mux->s_resubmit; }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>> index 8c1691e11b1c..bf8f5ca61605 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>> @@ -29,6 +29,7 @@
>>>>     #include "amdgpu_ring.h"
>>>>
>>>>     struct amdgpu_ring;
>>>> +
>>>>     /**
>>>>      * struct amdgpu_mux_entry - the entry recording software rings copying information.
>>>>      * @ring: the pointer to the software ring.
>>>> @@ -37,6 +38,7 @@ struct amdgpu_ring;
>>>>      * @sw_cptr: the position of the copy pointer in the sw ring.
>>>>      * @sw_rptr: the read pointer in software ring.
>>>>      * @sw_wptr: the write pointer in software ring.
>>>> + * @list: list head for amdgpu_mux_chunk
>>>>      */
>>>>     struct amdgpu_mux_entry {
>>>>         struct                  amdgpu_ring *ring;
>>>> @@ -45,6 +47,7 @@ struct amdgpu_mux_entry {
>>>>         u64                     sw_cptr;
>>>>         u64                     sw_rptr;
>>>>         u64                     sw_wptr;
>>>> +     struct list_head        list;
>>>>     };
>>>>
>>>>     struct amdgpu_ring_mux {
>>>> @@ -55,6 +58,26 @@ struct amdgpu_ring_mux {
>>>>         unsigned int            ring_entry_size;
>>>>         /*the lock for copy data from different software rings*/
>>>>         spinlock_t              lock;
>>>> +     bool                    s_resubmit;
>>>> +     uint32_t                seqno_to_resubmit;
>>>> +     u64                     wptr_resubmit;
>>>> +     struct timer_list       resubmit_timer;
>>>> +
>>>> +     bool                    pending_trailing_fence_signaled;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct amdgpu_mux_chunk - save the location of indirect buffer's package on softare rings.
>>>> + * @entry: the list entry.
>>>> + * @sync_seq: the fence seqno related with the saved IB.
>>>> + * @start:- start location on the software ring.
>>>> + * @end:- end location on the software ring.
>>>> + */
>>>> +struct amdgpu_mux_chunk {
>>>> +     struct list_head        entry;
>>>> +     uint32_t                sync_seq;
>>>> +     u64                     start;
>>>> +     u64                     end;
>>>>     };
>>>>
>>>>     int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>>>> amdgpu_ring *ring, @@ -65,4 +88,11 @@ void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *r
>>>>     u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
>>>>     u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct
>>>> amdgpu_ring *ring);
>>>>
>>>> +void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct
>>>> +amdgpu_ring *ring); void amdgpu_ring_mux_end_ib(struct
>>>> +amdgpu_ring_mux *mux, struct amdgpu_ring *ring); void
>>>> +amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
>>>> +
>>>> +int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux); int
>>>> +amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux); bool
>>>> +amdgpu_mcbp_handle_trailing_fence_irq(struct amdgpu_ring_mux *mux);
>>>>     #endif
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>> index 5ae12d6641ca..a3ec7bdf72a6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>> @@ -59,3 +59,29 @@ void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
>>>>     {
>>>>         WARN_ON(!ring->is_sw_ring);
>>>>     }
>>>> +
>>>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>> +
>>>> +     WARN_ON(!ring->is_sw_ring);
>>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
>>>> +             if (amdgpu_mcbp_scan(mux) > 0)
>>>> +                     amdgpu_mcbp_trigger_preempt(mux);
>>>> +             return;
>>>> +     }
>>>> +
>>>> +     amdgpu_ring_mux_start_ib(mux, ring); }
>>>> +
>>>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring) {
>>>> +     struct amdgpu_device *adev = ring->adev;
>>>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>> +
>>>> +     WARN_ON(!ring->is_sw_ring);
>>>> +     if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
>>>> +             return;
>>>> +     amdgpu_ring_mux_end_ib(mux, ring); }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> index 9596c22fded6..b7e94553f4fb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>> @@ -601,6 +601,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
>>>>                 return 0;
>>>>
>>>> +     amdgpu_ring_ib_begin(ring);
>>>>         if (ring->funcs->init_cond_exec)
>>>>                 patch_offset = amdgpu_ring_init_cond_exec(ring);
>>>>
>>>> @@ -661,6 +662,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>                 amdgpu_ring_emit_switch_buffer(ring);
>>>>                 amdgpu_ring_emit_switch_buffer(ring);
>>>>         }
>>>> +     amdgpu_ring_ib_end(ring);
>>>>         return 0;
>>>>     }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> index 669532f658da..1620300f0dde 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> @@ -5619,7 +5619,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>>>         ring->trail_seq += 1;
>>>>         amdgpu_ring_alloc(ring, 13);
>>>>         gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
>>>> -                              ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
>>>> +                              ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC
>>>> + | AMDGPU_FENCE_FLAG_INT);
>>>>         /*reset the CP_VMID_PREEMPT after trailing fence*/
>>>>         amdgpu_ring_emit_wreg(ring,
>>>>                               SOC15_REG_OFFSET(GC, 0,
>>>> mmCP_VMID_PREEMPT), @@ -6045,9 +6045,11 @@ static int
>>>> gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>>>>
>>>>         switch (me_id) {
>>>>         case 0:
>>>> -             /* Fence signals are handled on the software rings*/
>>>> -             for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>>>> -                     amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>>>> +             if (!amdgpu_mcbp_handle_trailing_fence_irq(&adev->gfx.muxer)) {
>>>> +                     /* Fence signals are handled on the software rings*/
>>>> +                     for (i = 0; i < GFX9_NUM_SW_GFX_RINGS; i++)
>>>> +                             amdgpu_fence_process(&adev->gfx.sw_gfx_ring[i]);
>>>> +             }
>>>>                 break;
>>>>         case 1:
>>>>         case 2:

