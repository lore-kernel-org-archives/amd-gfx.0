Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA83AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 08:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C0910E50E;
	Fri, 18 Mar 2022 08:35:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618B410E759
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 08:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmQ2JmL9QkVqi/YQeBXm1W2WwUH/682Pk47dA71z9HeAftTWbd9Aq+UZF1pe/N+BqMFamdWA3vmvV+Nw7pO1x3AurSVXyW/EGfdp2o+mMNRgimEeC1YGcQ5tIEBbxfKBRUd7zT+IhFANmRs9ByhSjCIU/dFXRd3isqSpKLG5Qb0fpBzCfgawEq4jBaJjIHrFQIxQsaA29Gpn/rDSjL867lkAUZpnkAltXXEI+irQkpRzH1nc3EEjHBe0KxDBwgB0pawJrWStegGzpQ4QxcbVeaNsZ1v4/aW7wY4OByj1nywACFrJn51/0wjmyMN4HfknPspF/KY8n4L8gxmPR5eZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=740gLFrtZonrfhvXq46VML0pTvdkPrdTxmcPIuNoBUE=;
 b=LTA6ztdgntL+fsu4t2anZl/Id6h5Lgvy5U0B+eIUEcPscodEneveZcQlcN4ekMu5pH1UrrMgH/7YH3WI0nTTt6q0jOyOuJMa+aGibTr7a9b10budhdU35RL/ztiBGaZtPG1jla/wMiM0fCitzsuwUFQiSTrYkfuAc2Cs8hG7GRDYwv/nKWL8QpWqKSa8tC4pxpPNTYP6ayz2BNLBKkzcW92RgRaA0aF+aRtLXivpNMmwSftqMIXOQRVO5bih+wIpbVoguEpcvxG20dxYmh/V8+CB7xRS+Ja9L8q5/1BGtjaFUtiht+y8mcbZ4dVt9dXzrG94HCHisigZzKh1+bNcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=740gLFrtZonrfhvXq46VML0pTvdkPrdTxmcPIuNoBUE=;
 b=D3d0wDjaXIzpJT9o8SeSIk5K/+DcDtJfhiUzlT/3xqirFGaYmtGnnsjmDkdp1nxHTfr/JXF3/FmPSvaW9dqx5A68pw7auuDw756wFlSBOmP3DspYnvORfcgHkTtgzCHUxuUOw4jreYx+w5yB2DajWyBm+8RmNzcLpYL/2Ja04LU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB3941.namprd12.prod.outlook.com (2603:10b6:610:28::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Fri, 18 Mar
 2022 08:35:38 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 08:35:38 +0000
Content-Type: multipart/alternative;
 boundary="------------L7mEsylvQruaJp7AiHPbORSc"
Message-ID: <cd95435c-7ad5-6126-26f6-76a62f6f85fb@amd.com>
Date: Fri, 18 Mar 2022 09:35:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: radeon ring 0 test failed on arm64
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <ece56cf6-5ef2-6bd4-8e62-7828adca9844@rock-chips.com>
 <CAMdYzYoTz7rbs7pMDTcDzVPVaaP97BkUeMOM0Ab5FVSqOQRgxg@mail.gmail.com>
 <7652b236-238c-4e8a-f1c5-e3b7f7f71be6@rock-chips.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <7652b236-238c-4e8a-f1c5-e3b7f7f71be6@rock-chips.com>
X-ClientProxiedBy: AM6PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::31) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0dd9d12-9a70-4ff4-0f82-08da08ba4741
X-MS-TrafficTypeDiagnostic: CH2PR12MB3941:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39417A86013AC755343CD99483139@CH2PR12MB3941.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/HQuJGe6zBVwDIAXOlyvxQ6udJZ17cDP5PyAva/ynWzsBza4D9ODHmXyUX1Bmyo9eygFE6kdAEtvGvL+urO4lda+eADWYjeWbU5uu4QbQzSYU9xUu20sZ5TbJpWF/xP7yI27H2Al4TXSdZOiwlf0aM6keqGzpwi1+U5kUQJF8lyGihHS1k+THUoEzwCzc1L/t0tzD1ri6DDxIXN8wi0vCbD5dyYJYhDDBDcYZM/9XI9AIKCfOZzpckxK8UNqlxz7AnsxndUSe4sWvFBGpuwKBN8h5ycrB9XJLbzyMaBzmcaUYnOh1IuUIe6hKmiqtFUTNb8rHKF08jsbCwRq5D0vnBv1i5K+/kjqxwYgYfZs8OJkzpoZtFtEXLmj7MI78X/9nFRXcBIJ4nUQghdKqkykKwVKwZhmM8fiVHXSqs0pf21Psuj8qzPwZmK/dbvZwsYtl4j3EZc3vzS+TMqrobcD/GHV7/Y7xqGHyUKsfngBHJ2rqYGfFhyNzUeRXYi3QpW6tTBg4Yyu6JwYFx2cYB8etyEVPI8vb23eImst/eGgcMxJNz8MK77MkU37E9wjHYVmtNQgBl9aSJFwOMYnXwnHQTywzLzgtCkxPwLj+QlpCCFMxRoOnEhQDs0ovi/jlzw23TLbL6GkQOBfNaCyy1IMWfFjXRRnjuZLgYzoXbbH3lbcRajzX/m+2Y1CQW3OeqV6+2BtgwcpPP6nbePwx1BDU0Ew8/hZx8LMKDdAFj3dL0uw3hfW1W58wB+aXnu6ticOudwHimaF/tKHW4+0wvx2UtroppetQ39EBAmqTbMI4zisOmuX+6f2s6cf1BqOjxEK+yIu+liPG7ICzFgvQfZYRzkowQm62EXziYJiyPNlxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(38100700002)(66574015)(166002)(33964004)(83380400001)(53546011)(6666004)(6506007)(6512007)(86362001)(186003)(45080400002)(2616005)(508600001)(2906002)(66476007)(8676002)(66946007)(4326008)(30864003)(66556008)(966005)(5660300002)(31696002)(6486002)(316002)(36756003)(8936002)(54906003)(110136005)(45980500001)(43740500002)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG4wNFB5d1FGVzFoRnJLUERnOGpsL3BFd3RKNThWNGRPWWdVVFdKU085TWtF?=
 =?utf-8?B?Si9ZSzU3RjVLYTBjRXZGOHgwa2hQWXBjVHBZOTFMcEFlUTBjU2J1ZTF6ZWpB?=
 =?utf-8?B?YklDWCtWOGF3T3RKSUNrKzV0YkdtajB6cEhMbmp3bm9tSzI1czBWaHlDZTdR?=
 =?utf-8?B?MWt5TVAxZ2ZVR3ZsUmpuWlFZeklOb2RvMXBpNDNHdVlITDYwczVOR2VXTys1?=
 =?utf-8?B?UTlPMkN4S1hYcmNDQkwxM2N6dVkzY1Zic0I5Yys3Qm84YytKRHRDbXVmSUFm?=
 =?utf-8?B?SklkVlRBdFM2b0wyMzg0bWJRVGtDNXZFMlU1d0RqaXhCMVdERW1MMGhWSnNu?=
 =?utf-8?B?clhLRzlJN3JybGJ5RTdkNWp6M0NLSXY0K2hrRUQyNnB1WHlsK2gyY0lUbmEv?=
 =?utf-8?B?YWZ5bkxJWVNReWxxVVlIQjNOTVIrZ0txdEloQ0ZNdDZCWDFKTUJrVGlBdmlE?=
 =?utf-8?B?Y0JMR3N4RlhPYWVUZ29jTE5TYjczdU1mQjZXTG0vZ0x1Nis3WWFRQzJodmRq?=
 =?utf-8?B?cDRyNzltK09Vdzl1bXRGSlNkNGtxQld1c3RmNFJ5b0lONnpkdDZHaldxdE5l?=
 =?utf-8?B?Z2N0eG41T1E0MTlFVm1jcDIyVFk1MStLNGxzVzJENHpPbW9CSEl0SGFvM3Qv?=
 =?utf-8?B?bUlrVyttdGllajVXakJhdjRqbGZjQ3h5T0tqeXMxaGxIcDdHMjFBQ1FLOTVr?=
 =?utf-8?B?emp3RTBjVS8ydGFmSVdWT285b2s5WHp5b2RBTm1CWDduQ1pYQkZjTVVHOTNy?=
 =?utf-8?B?c1hxRUlMWlM4ZWVQSUE5M0dEUjFuVG9NSDR3UDhQSWN4Yk5hbGh4bVJ2U3U3?=
 =?utf-8?B?WDV6ZVE0UkEzWEgwT1h1cHpieEFNb1lybXlReXJqUG52a3N6L01PMFduWmpH?=
 =?utf-8?B?bFJ6NWtvMVorTHlUaGl3L1R0YVMvTUpCQ295akEyNjRydEtQQjh1bk16M1ZH?=
 =?utf-8?B?SnMzNGpVd1hDZFlWMUVpQnBoZDhWM2lob2RzZUF1dEZBOUlrL0IrUmVzc0U1?=
 =?utf-8?B?azZLMUFPK1VrMUY2NGtEQVRPYlBVQ2hhc24wME55K2ZrNjZiWHB2WW5pS3d5?=
 =?utf-8?B?WDJkYitFNzlWdFp0SHkyM3l3ZUF5enJ1ejE3S2hCaFd2eW5QY21hVnFvVXRL?=
 =?utf-8?B?Q1JpTWxpSENod0ZIMTZ0d0lmbGJqRzUzRGczYXMraE0yak1yUkNiTEZqZm1E?=
 =?utf-8?B?a3JKS1JVdldleFRTaDBsbiswV0dEallnU3RIdHdiTXM0MlBjdko4NHE0R3F2?=
 =?utf-8?B?YkpRU3lneDN2ak9WOGxId1MxNDJxYXRoS1NWaHlmL0VEL25RQis1elFRK0tn?=
 =?utf-8?B?UE1CWE92Ymx3VjlXb1ppNkx3ZkZMN3hhWDFpMGlyZlU1ZVluaWFVMUh5ZHZ6?=
 =?utf-8?B?dGhFUHQzcDZrQklhK2FDZTY4NStFS1RCaW1NS2ltUXNsQ09VS3N0bEJtZGND?=
 =?utf-8?B?dlNXNFFGWVhKTjROU2pSaDErdDZJUE9HV3d2UE5wUmhEczY5SDluN2cyQ0xN?=
 =?utf-8?B?QTFNdmZyN0NwelhjekpxN1NsMmJKVXFraGNLeEVudVVuYmpBWW5xSWI5eTMr?=
 =?utf-8?B?dUFXWUVxS3BtUEVoRUtsYUVjSDV0aEg5TWNQOGltQkxxZ2E1UkhCbS8wdkxY?=
 =?utf-8?B?OHRNaGJESHNGL1BNNXhZU1NUZEZSREpFaFVwRkJnYTYxWnRKUmo0VVpwRlpj?=
 =?utf-8?B?Tk03aUtKTzA0Mm5qWGZPQmhMRkNjMjUxSk1ILzlRRjA2VThXK2FMNGlSTUl3?=
 =?utf-8?B?bDB4azNqT250UnFXZGttZ3Ruak90cGxFeVZUenlxdGMvWHZSbTFCOUsvSWVB?=
 =?utf-8?B?bTFYN0pkZzdlK3RBV0lCakRYU2psS0wweGtjVFpJRXYwalovMWdjSlBNSGhB?=
 =?utf-8?B?by91d0lMWmVZMlU1T3o5U0hGV0ZQandmU2pkc0FOQm1FK0daTVE4TDQ0aUdR?=
 =?utf-8?B?azZPM0R2dkdZZStwOTdRdVpRQkJyWVpUSlBFQVJsd0JScWRSbEs4VXhvalpu?=
 =?utf-8?B?TFRrT3JPVTZmbE9HZnRDNStqSEtZc0tQWFh5c0dVdVcybzd4c1VLZzVFSmVw?=
 =?utf-8?Q?fA+8Q5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dd9d12-9a70-4ff4-0f82-08da08ba4741
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 08:35:38.1856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D988S1Dh2kqZFeVw7hpqc+ADKbBwL/cuKs/b2aE0Q0n1/NQGxtljoWZm93bTw9AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3941
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
Cc: Tao Huang <huangtao@rock-chips.com>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------L7mEsylvQruaJp7AiHPbORSc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 18.03.22 um 08:51 schrieb Kever Yang:
>
> On 2022/3/17 20:19, Peter Geis wrote:
>> On Wed, Mar 16, 2022 at 11:08 PM Kever Yang 
>> <kever.yang@rock-chips.com> wrote:
>>> Hi Peter,
>>>
>>> On 2022/3/17 08:14, Peter Geis wrote:
>>>> Good Evening,
>>>>
>>>> I apologize for raising this email chain from the dead, but there have
>>>> been some developments that have introduced even more questions.
>>>> I've looped the Rockchip mailing list into this too, as this affects
>>>> rk356x, and likely the upcoming rk3588 if [1] is to be believed.
>>>>
>>>> TLDR for those not familiar: It seems the rk356x series (and possibly
>>>> the rk3588) were built without any outer coherent cache.
>>>> This means (unless Rockchip wants to clarify here) devices such as the
>>>> ITS and PCIe cannot utilize cache snooping.
>>>> This is based on the results of the email chain [2].
>>>>
>>>> The new circumstances are as follows:
>>>> The RPi CM4 Adventure Team as I've taken to calling them has been
>>>> attempting to get a dGPU working with the very broken Broadcom
>>>> controller in the RPi CM4.
>>>> Recently they acquired a SoQuartz rk3566 module which is pin
>>>> compatible with the CM4, and have taken to trying it out as well.
>>>>
>>>> This is how I got involved.
>>>> It seems they found a trivial way to force the Radeon R600 driver to
>>>> use Non-Cached memory for everything.
>>>> This single line change, combined with using memset_io instead of
>>>> memset, allows the ring tests to pass and the card probes successfully
>>>> (minus the DMA limitations of the rk356x due to the 32 bit
>>>> interconnect).
>>>> I discovered using this method that we start having unaligned io
>>>> memory access faults (bus errors) when running glmark2-drm (running
>>>> glmark2 directly was impossible, as both X and Wayland crashed too
>>>> early).
>>>> I traced this to using what I thought at the time was an unsafe memcpy
>>>> in the mesa stack.
>>>> Rewriting this function to force aligned writes solved the problem and
>>>> allows glmark2-drm to run to completion.
>>>> With some extensive debugging, I found about half a dozen memcpy
>>>> functions in mesa that if forced to be aligned would allow Wayland to
>>>> start, but with hilarious display corruption (see [3]. [4]).
>>>> The CM4 team is convinced this is an issue with memcpy in glibc, but
>>>> I'm not convinced it's that simple.
>>>>
>>>> On my two hour drive in to work this morning, I got to thinking.
>>>> If this was an memcpy fault, this would be universally broken on arm64
>>>> which is obviously not the case.
>>>> So I started thinking, what is different here than with systems 
>>>> known to work:
>>>> 1. No IOMMU for the PCIe controller.
>>>> 2. The Outer Cache Issue.
>>>>
>>>> Robin:
>>>> My questions for you, since you're the smartest person I know about
>>>> arm64 memory management:
>>>> Could cache snooping permit unaligned accesses to IO to be safe?
>>>> Or
>>>> Is it the lack of an IOMMU that's causing the ali gnment faults to 
>>>> become fatal?
>>>> Or
>>>> Am I insane here?
>>>>
>>>> Rockchip:
>>>> Please update on the status for the Outer Cache errata for ITS 
>>>> services.
>>> Our SoC design team has double check with ARM GIC/ITS IP team for many
>>> times, and the GITS_CBASER
>>> of GIC600 IP does not support hardware bind or config to a fix 
>>> value, so
>>> they insist this is an IP
>>> limitation instead of a SoC bug, software should take  care of it :(
>>> I will check again if we can provide errata for this issue.
>> Thanks. This is necessary as the mbi-alias provides an imperfect
>> implementation of the ITS and causes certain PCIe cards (eg x520 Intel
>> 10G NIC) to misbehave.
>>
>>>> Please provide an answer to the errata of the PCIe controller, in
>>>> regard to cache snooping and buffering, for both the rk356x and the
>>>> upcoming rk3588.
>>>
>>> Sorry, what is this?
>> Part of the ITS bug is it expects to be cache coherent with the CPU
>> cluster by design.
>> Due to the rk356x being implemented without an outer accessible cache,
>> the ITS and other devices that require cache coherency (PCIe for
>> example) crash in fun ways.
> Then this is still the ITS issue, not PCIe issue.
> PCIe is a peripheral bus controller like USB and other device, the 
> driver should maintain the "cache coherency" if there is any, and 
> there is no requirement for hardware cache coherency between PCIe and CPU.

Well then I suggest to re-read the PCIe specification.

Cache coherency is defined as mandatory there. Non-cache coherency is an 
optional feature.

See section 2.2.6.5 in the PCIe 2.0 specification for a good example.

Regards,
Christian.

>
> We didn't see any transfer error on rk356x PCIe till now, we can take 
> a look if it's easy to reproduce.
>
> Thanks,
> - Kever
>
>
>> This means that rk356x cannot implement a specification compliant ITS 
>> or PCIe.
>> >From the rk3588 source dump it appears it was produced without an
>> outer accessible cache, which means if true it also will be unable to
>> use any PCIe cards that implement cache coherency as part of their
>> design.
>>
>>>
>>> Thanks,
>>> - Kever
>>>> [1] 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298e8049d4f&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=LcwZggIwIqjvzjDH2DUnIDwxsgk7WmhE9LK13knx36E%3D&amp;reserved=0
>>>> [2] 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=fXALLO1EnGi2s8pClt6aMrUlzqDy2KDO8wzpi033qtU%3D&amp;reserved=0
>>>> [3] 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953414755970850816%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=tx%2Bw9ayScUTftjWAFL0GY%2FADQswxEJGRUhgxDw2TSzQ%3D&amp;reserved=0
>>>> [4] 
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852422%2Funknown.png&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=8VXuZvQAhD%2FsQBJ6WEXe0YElD6wCI675oxqHesKhclY%3D&amp;reserved=0
>>>>
>>>> Thank you everyone for your time.
>>>>
>>>> Very Respectfully,
>>>> Peter Geis
>>>>
>>>> On Wed, May 26, 2021 at 7:21 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>> Hi Robin,
>>>>>
>>>>> Am 26.05.21 um 12:59 schrieb Robin Murphy:
>>>>>> On 2021-05-26 10:42, Christian König wrote:
>>>>>>> Hi Robin,
>>>>>>>
>>>>>>> Am 25.05.21 um 22:09 schrieb Robin Murphy:
>>>>>>>> On 2021-05-25 14:05, Alex Deucher wrote:
>>>>>>>>> On Tue, May 25, 2021 at 8:56 AM Peter Geis <pgwipeout@gmail.com>
>>>>>>>>> wrote:
>>>>>>>>>> On Tue, May 25, 2021 at 8:47 AM Alex Deucher
>>>>>>>>>> <alexdeucher@gmail.com> wrote:
>>>>>>>>>>> On Tue, May 25, 2021 at 8:42 AM Peter Geis 
>>>>>>>>>>> <pgwipeout@gmail.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>> Good Evening,
>>>>>>>>>>>>
>>>>>>>>>>>> I am stress testing the pcie controller on the rk3566-quartz64
>>>>>>>>>>>> prototype SBC.
>>>>>>>>>>>> This device has 1GB available at <0x3 0x00000000> for the PCIe
>>>>>>>>>>>> controller, which makes a dGPU theoretically possible.
>>>>>>>>>>>> While attempting to light off a HD7570 card I manage to get a
>>>>>>>>>>>> modeset
>>>>>>>>>>>> console, but ring0 test fails and disables acceleration.
>>>>>>>>>>>>
>>>>>>>>>>>> Note, we do not have UEFI, so all PCIe setup is from the Linux
>>>>>>>>>>>> kernel.
>>>>>>>>>>>> Any insight you can provide would be much appreciated.
>>>>>>>>>>> Does your platform support PCIe cache coherency with the 
>>>>>>>>>>> CPU?  I.e.,
>>>>>>>>>>> does the CPU allow cache snoops from PCIe devices?  That is 
>>>>>>>>>>> required
>>>>>>>>>>> for the driver to operate.
>>>>>>>>>> Ah, most likely not.
>>>>>>>>>> This issue has come up already as the GIC isn't permitted to 
>>>>>>>>>> snoop on
>>>>>>>>>> the CPUs, so I doubt the PCIe controller can either.
>>>>>>>>>>
>>>>>>>>>> Is there no way to work around this or is it dead in the water?
>>>>>>>>> It's required by the pcie spec.  You could potentially work 
>>>>>>>>> around it
>>>>>>>>> if you can allocate uncached memory for DMA, but I don't think 
>>>>>>>>> that is
>>>>>>>>> possible currently.  Ideally we'd figure out some way to 
>>>>>>>>> detect if a
>>>>>>>>> particular platform supports cache snooping or not as well.
>>>>>>>> There's device_get_dma_attr(), although I don't think it will work
>>>>>>>> currently for PCI devices without an OF or ACPI node - we could
>>>>>>>> perhaps do with a PCI-specific wrapper which can walk up and defer
>>>>>>>> to the host bridge's firmware description as necessary.
>>>>>>>>
>>>>>>>> The common DMA ops *do* correctly keep track of per-device 
>>>>>>>> coherency
>>>>>>>> internally, but drivers aren't supposed to be poking at that
>>>>>>>> information directly.
>>>>>>> That sounds like you underestimate the problem. ARM has 
>>>>>>> unfortunately
>>>>>>> made the coherency for PCI an optional IP.
>>>>>> Sorry to be that guy, but I'm involved a lot internally with our
>>>>>> system IP and interconnect, and I probably understand the situation
>>>>>> better than 99% of the community ;)
>>>>> I need to apologize, didn't realized who was answering :)
>>>>>
>>>>> It just sounded to me that you wanted to suggest to the end user that
>>>>> this is fixable in software and I really wanted to avoid even more
>>>>> customers coming around asking how to do this.
>>>>>
>>>>>> For the record, the SBSA specification (the closet thing we have 
>>>>>> to a
>>>>>> "system architecture") does require that PCIe is integrated in an
>>>>>> I/O-coherent manner, but we don't have any control over what 
>>>>>> people do
>>>>>> in embedded applications (note that we don't make PCIe IP at all, 
>>>>>> and
>>>>>> there is plenty of 3rd-party interconnect IP).
>>>>> So basically it is not the fault of the ARM IP-core, but people 
>>>>> are just
>>>>> stitching together PCIe interconnect IP with a core where it is not
>>>>> supposed to be used with.
>>>>>
>>>>> Do I get that correctly? That's an interesting puzzle piece in the 
>>>>> picture.
>>>>>
>>>>>>> So we are talking about a hardware limitation which potentially 
>>>>>>> can't
>>>>>>> be fixed without replacing the hardware.
>>>>>> You expressed interest in "some way to detect if a particular 
>>>>>> platform
>>>>>> supports cache snooping or not", by which I assumed you meant a
>>>>>> software method for the amdgpu/radeon drivers to call, rather than,
>>>>>> say, a website that driver maintainers can look up SoC names on. I'm
>>>>>> saying that that API already exists (just may need a bit more work).
>>>>>> Note that it is emphatically not a platform-level thing since
>>>>>> coherency can and does vary per device within a system.
>>>>> Well, I think this is not something an individual driver should mess
>>>>> with. What the driver should do is just express that it needs 
>>>>> coherent
>>>>> access to all of system memory and if that is not possible fail to 
>>>>> load
>>>>> with a warning why it is not possible.
>>>>>
>>>>>> I wasn't suggesting that Linux could somehow make coherency 
>>>>>> magically
>>>>>> work when the signals don't physically exist in the interconnect - I
>>>>>> was assuming you'd merely want to do something like throw a big
>>>>>> warning and taint the kernel to help triage bug reports. Some 
>>>>>> drivers
>>>>>> like ahci_qoriq and panfrost simply need to know so they can program
>>>>>> their device to emit the appropriate memory attributes either 
>>>>>> way, and
>>>>>> rely on the DMA API to hide the rest of the difference, but if you
>>>>>> want to treat non-coherent use as unsupported because it would 
>>>>>> require
>>>>>> too invasive changes that's fine by me.
>>>>> Yes exactly that please. I mean not sure how panfrost is doing it, 
>>>>> but
>>>>> at least the Vulkan userspace API specification requires devices 
>>>>> to have
>>>>> coherent access to system memory.
>>>>>
>>>>> So even if I would want to do this it is simply not possible 
>>>>> because the
>>>>> application doesn't tell the driver which memory is accessed by the
>>>>> device and which by the CPU.
>>>>>
>>>>> Christian.
>>>>>
>>>>>> Robin.
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-rockchip&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=F77FbO3SqslbzKu2%2FnjRLrQF45kljtD3%2FAEXEFd7NQs%3D&amp;reserved=0 
>>>

--------------L7mEsylvQruaJp7AiHPbORSc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">Am 18.03.22 um 08:51 schrieb Kever
      Yang:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:7652b236-238c-4e8a-f1c5-e3b7f7f71=
be6@rock-chips.com">
      <br>
      On 2022/3/17 20:19, Peter Geis wrote:
      <br>
      <blockquote type=3D"cite">On Wed, Mar 16, 2022 at 11:08 PM Kever
        Yang <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:kever.yang@r=
ock-chips.com">&lt;kever.yang@rock-chips.com&gt;</a> wrote:
        <br>
        <blockquote type=3D"cite">Hi Peter,
          <br>
          <br>
          On 2022/3/17 08:14, Peter Geis wrote:
          <br>
          <blockquote type=3D"cite">Good Evening,
            <br>
            <br>
            I apologize for raising this email chain from the dead, but
            there have
            <br>
            been some developments that have introduced even more
            questions.
            <br>
            I've looped the Rockchip mailing list into this too, as this
            affects
            <br>
            rk356x, and likely the upcoming rk3588 if [1] is to be
            believed.
            <br>
            <br>
            TLDR for those not familiar: It seems the rk356x series (and
            possibly
            <br>
            the rk3588) were built without any outer coherent cache.
            <br>
            This means (unless Rockchip wants to clarify here) devices
            such as the
            <br>
            ITS and PCIe cannot utilize cache snooping.
            <br>
            This is based on the results of the email chain [2].
            <br>
            <br>
            The new circumstances are as follows:
            <br>
            The RPi CM4 Adventure Team as I've taken to calling them has
            been
            <br>
            attempting to get a dGPU working with the very broken
            Broadcom
            <br>
            controller in the RPi CM4.
            <br>
            Recently they acquired a SoQuartz rk3566 module which is pin
            <br>
            compatible with the CM4, and have taken to trying it out as
            well.
            <br>
            <br>
            This is how I got involved.
            <br>
            It seems they found a trivial way to force the Radeon R600
            driver to
            <br>
            use Non-Cached memory for everything.
            <br>
            This single line change, combined with using memset_io
            instead of
            <br>
            memset, allows the ring tests to pass and the card probes
            successfully
            <br>
            (minus the DMA limitations of the rk356x due to the 32 bit
            <br>
            interconnect).
            <br>
            I discovered using this method that we start having
            unaligned io
            <br>
            memory access faults (bus errors) when running glmark2-drm
            (running
            <br>
            glmark2 directly was impossible, as both X and Wayland
            crashed too
            <br>
            early).
            <br>
            I traced this to using what I thought at the time was an
            unsafe memcpy
            <br>
            in the mesa stack.
            <br>
            Rewriting this function to force aligned writes solved the
            problem and
            <br>
            allows glmark2-drm to run to completion.
            <br>
            With some extensive debugging, I found about half a dozen
            memcpy
            <br>
            functions in mesa that if forced to be aligned would allow
            Wayland to
            <br>
            start, but with hilarious display corruption (see [3]. [4]).
            <br>
            The CM4 team is convinced this is an issue with memcpy in
            glibc, but
            <br>
            I'm not convinced it's that simple.
            <br>
            <br>
            On my two hour drive in to work this morning, I got to
            thinking.
            <br>
            If this was an memcpy fault, this would be universally
            broken on arm64
            <br>
            which is obviously not the case.
            <br>
            So I started thinking, what is different here than with
            systems known to work:
            <br>
            1. No IOMMU for the PCIe controller.
            <br>
            2. The Outer Cache Issue.
            <br>
            <br>
            Robin:
            <br>
            My questions for you, since you're the smartest person I
            know about
            <br>
            arm64 memory management:
            <br>
            Could cache snooping permit unaligned accesses to IO to be
            safe?
            <br>
            Or
            <br>
            Is it the lack of an IOMMU that's causing the ali gnment
            faults to become fatal?
            <br>
            Or
            <br>
            Am I insane here?
            <br>
            <br>
            Rockchip:
            <br>
            Please update on the status for the Outer Cache errata for
            ITS services.
            <br>
          </blockquote>
          Our SoC design team has double check with ARM GIC/ITS IP team
          for many
          <br>
          times, and the GITS_CBASER
          <br>
          of GIC600 IP does not support hardware bind or config to a fix
          value, so
          <br>
          they insist this is an IP
          <br>
          limitation instead of a SoC bug, software should take&nbsp; care =
of
          it :(
          <br>
          I will check again if we can provide errata for this issue.
          <br>
        </blockquote>
        Thanks. This is necessary as the mbi-alias provides an imperfect
        <br>
        implementation of the ITS and causes certain PCIe cards (eg x520
        Intel
        <br>
        10G NIC) to misbehave.
        <br>
        <br>
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">Please provide an answer to the errata
            of the PCIe controller, in
            <br>
            regard to cache snooping and buffering, for both the rk356x
            and the
            <br>
            upcoming rk3588.
            <br>
          </blockquote>
          <br>
          Sorry, what is this?
          <br>
        </blockquote>
        Part of the ITS bug is it expects to be cache coherent with the
        CPU
        <br>
        cluster by design.
        <br>
        Due to the rk356x being implemented without an outer accessible
        cache,
        <br>
        the ITS and other devices that require cache coherency (PCIe for
        <br>
        example) crash in fun ways.
        <br>
      </blockquote>
      Then this is still the ITS issue, not PCIe issue.
      <br>
      PCIe is a peripheral bus controller like USB and other device, the
      driver should maintain the &quot;cache coherency&quot; if there is an=
y, and
      there is no requirement for hardware cache coherency between PCIe
      and CPU.</blockquote>
    <br>
    Well then I suggest to re-read the PCIe specification.<br>
    <br>
    Cache coherency is defined as mandatory there. Non-cache coherency
    is an optional feature.<br>
    <br>
    See section <span style=3D"left: 272.106px; top: 897.633px;
      font-size: 16.7px; font-family: sans-serif; transform:
      scaleX(0.866889);" role=3D"presentation" dir=3D"ltr">2.2.6.5 in the
      PCIe 2.0 specification for a good example.</span><br>
    <span style=3D"left: 272.106px; top: 897.633px; font-size: 16.7px;
      font-family: sans-serif; transform: scaleX(0.866889);" role=3D"presen=
tation" dir=3D"ltr"><br>
      Regards,<br>
      Christian.</span><br>
    <br>
    <blockquote type=3D"cite" cite=3D"mid:7652b236-238c-4e8a-f1c5-e3b7f7f71=
be6@rock-chips.com">
      <br>
      We didn't see any transfer error on rk356x PCIe till now, we can
      take a look if it's easy to reproduce.
      <br>
      <br>
      Thanks,
      <br>
      - Kever
      <br>
      <br>
      <br>
      <blockquote type=3D"cite">This means that rk356x cannot implement a
        specification compliant ITS or PCIe.
        <br>
        &gt;From the rk3588 source dump it appears it was produced
        without an
        <br>
        outer accessible cache, which means if true it also will be
        unable to
        <br>
        use any PCIe cards that implement cache coherency as part of
        their
        <br>
        design.
        <br>
        <br>
        <blockquote type=3D"cite">
          <br>
          Thanks,
          <br>
          - Kever
          <br>
          <blockquote type=3D"cite">[1]
<a class=3D"moz-txt-link-freetext" href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2FJeffyCN%2Fmirrors%2Fcommit=
%2F0b985f29304dcb9d644174edacb67298e8049d4f&amp;amp;data=3D04%7C01%7Cchrist=
ian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp=
;sdata=3DLcwZggIwIqjvzjDH2DUnIDwxsgk7WmhE9LK13knx36E%3D&amp;amp;reserved=3D=
0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith=
ub.com%2FJeffyCN%2Fmirrors%2Fcommit%2F0b985f29304dcb9d644174edacb67298e8049=
d4f&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bdb8c3a6a2e4643b=
bfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63783186722476=
6930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DLcwZggIwIqjvzjDH2DUnIDwxsgk7Wmh=
E9LK13knx36E%3D&amp;amp;reserved=3D0</a><br>
            [2]
<a class=3D"moz-txt-link-freetext" href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Flore.kernel.org%2Flkml%2F871rbdt4tu.wl-=
maz%40kernel.org%2FT%2F&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com=
%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%=
7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DfXALLO1EnGi=
2s8pClt6aMrUlzqDy2KDO8wzpi033qtU%3D&amp;amp;reserved=3D0">https://nam11.saf=
elinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.kernel.org%2Flkml%2=
F871rbdt4tu.wl-maz%40kernel.org%2FT%2F&amp;amp;data=3D04%7C01%7Cchristian.k=
oenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdat=
a=3DfXALLO1EnGi2s8pClt6aMrUlzqDy2KDO8wzpi033qtU%3D&amp;amp;reserved=3D0</a>=
<br>
            [3]
<a class=3D"moz-txt-link-freetext" href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F9264=
87797844541510%2F953414755970850816%2Funknown.png&amp;amp;data=3D04%7C01%7C=
christian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a=
mp;amp;sdata=3Dtx%2Bw9ayScUTftjWAFL0GY%2FADQswxEJGRUhgxDw2TSzQ%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F9534147559708=
50816%2Funknown.png&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8=
bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%=
7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3Dtx%2Bw9ayScUTft=
jWAFL0GY%2FADQswxEJGRUhgxDw2TSzQ%3D&amp;amp;reserved=3D0</a><br>
            [4]
<a class=3D"moz-txt-link-freetext" href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttps%3A%2F%2Fcdn.discordapp.com%2Fattachments%2F9264=
87797844541510%2F953424952042852422%2Funknown.png&amp;amp;data=3D04%7C01%7C=
christian.koenig%40amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8=
eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&a=
mp;amp;sdata=3D8VXuZvQAhD%2FsQBJ6WEXe0YElD6wCI675oxqHesKhclY%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fcdn.discordapp.com%2Fattachments%2F926487797844541510%2F953424952042852=
422%2Funknown.png&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bd=
b8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3D8VXuZvQAhD%2FsQBJ=
6WEXe0YElD6wCI675oxqHesKhclY%3D&amp;amp;reserved=3D0</a><br>
            <br>
            Thank you everyone for your time.
            <br>
            <br>
            Very Respectfully,
            <br>
            Peter Geis
            <br>
            <br>
            On Wed, May 26, 2021 at 7:21 AM Christian K=C3=B6nig
            <br>
            <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:christian.koe=
nig@amd.com">&lt;christian.koenig@amd.com&gt;</a> wrote:
            <br>
            <blockquote type=3D"cite">Hi Robin,
              <br>
              <br>
              Am 26.05.21 um 12:59 schrieb Robin Murphy:
              <br>
              <blockquote type=3D"cite">On 2021-05-26 10:42, Christian
                K=C3=B6nig wrote:
                <br>
                <blockquote type=3D"cite">Hi Robin,
                  <br>
                  <br>
                  Am 25.05.21 um 22:09 schrieb Robin Murphy:
                  <br>
                  <blockquote type=3D"cite">On 2021-05-25 14:05, Alex
                    Deucher wrote:
                    <br>
                    <blockquote type=3D"cite">On Tue, May 25, 2021 at 8:56
                      AM Peter Geis <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:pgwipeout@gmail.com">&lt;pgwipeout@gmail.com&gt;</a>
                      <br>
                      wrote:
                      <br>
                      <blockquote type=3D"cite">On Tue, May 25, 2021 at
                        8:47 AM Alex Deucher
                        <br>
                        <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:a=
lexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a> wrote:
                        <br>
                        <blockquote type=3D"cite">On Tue, May 25, 2021 at
                          8:42 AM Peter Geis <a class=3D"moz-txt-link-rfc23=
96E" href=3D"mailto:pgwipeout@gmail.com">&lt;pgwipeout@gmail.com&gt;</a>
                          <br>
                          wrote:
                          <br>
                          <blockquote type=3D"cite">Good Evening,
                            <br>
                            <br>
                            I am stress testing the pcie controller on
                            the rk3566-quartz64
                            <br>
                            prototype SBC.
                            <br>
                            This device has 1GB available at &lt;0x3
                            0x00000000&gt; for the PCIe
                            <br>
                            controller, which makes a dGPU theoretically
                            possible.
                            <br>
                            While attempting to light off a HD7570 card
                            I manage to get a
                            <br>
                            modeset
                            <br>
                            console, but ring0 test fails and disables
                            acceleration.
                            <br>
                            <br>
                            Note, we do not have UEFI, so all PCIe setup
                            is from the Linux
                            <br>
                            kernel.
                            <br>
                            Any insight you can provide would be much
                            appreciated.
                            <br>
                          </blockquote>
                          Does your platform support PCIe cache
                          coherency with the CPU?&nbsp; I.e.,
                          <br>
                          does the CPU allow cache snoops from PCIe
                          devices?&nbsp; That is required
                          <br>
                          for the driver to operate.
                          <br>
                        </blockquote>
                        Ah, most likely not.
                        <br>
                        This issue has come up already as the GIC isn't
                        permitted to snoop on
                        <br>
                        the CPUs, so I doubt the PCIe controller can
                        either.
                        <br>
                        <br>
                        Is there no way to work around this or is it
                        dead in the water?
                        <br>
                      </blockquote>
                      It's required by the pcie spec.&nbsp; You could
                      potentially work around it
                      <br>
                      if you can allocate uncached memory for DMA, but I
                      don't think that is
                      <br>
                      possible currently.&nbsp; Ideally we'd figure out som=
e
                      way to detect if a
                      <br>
                      particular platform supports cache snooping or not
                      as well.
                      <br>
                    </blockquote>
                    There's device_get_dma_attr(), although I don't
                    think it will work
                    <br>
                    currently for PCI devices without an OF or ACPI node
                    - we could
                    <br>
                    perhaps do with a PCI-specific wrapper which can
                    walk up and defer
                    <br>
                    to the host bridge's firmware description as
                    necessary.
                    <br>
                    <br>
                    The common DMA ops *do* correctly keep track of
                    per-device coherency
                    <br>
                    internally, but drivers aren't supposed to be poking
                    at that
                    <br>
                    information directly.
                    <br>
                  </blockquote>
                  That sounds like you underestimate the problem. ARM
                  has unfortunately
                  <br>
                  made the coherency for PCI an optional IP.
                  <br>
                </blockquote>
                Sorry to be that guy, but I'm involved a lot internally
                with our
                <br>
                system IP and interconnect, and I probably understand
                the situation
                <br>
                better than 99% of the community ;)
                <br>
              </blockquote>
              I need to apologize, didn't realized who was answering :)
              <br>
              <br>
              It just sounded to me that you wanted to suggest to the
              end user that
              <br>
              this is fixable in software and I really wanted to avoid
              even more
              <br>
              customers coming around asking how to do this.
              <br>
              <br>
              <blockquote type=3D"cite">For the record, the SBSA
                specification (the closet thing we have to a
                <br>
                &quot;system architecture&quot;) does require that PCIe is
                integrated in an
                <br>
                I/O-coherent manner, but we don't have any control over
                what people do
                <br>
                in embedded applications (note that we don't make PCIe
                IP at all, and
                <br>
                there is plenty of 3rd-party interconnect IP).
                <br>
              </blockquote>
              So basically it is not the fault of the ARM IP-core, but
              people are just
              <br>
              stitching together PCIe interconnect IP with a core where
              it is not
              <br>
              supposed to be used with.
              <br>
              <br>
              Do I get that correctly? That's an interesting puzzle
              piece in the picture.
              <br>
              <br>
              <blockquote type=3D"cite">
                <blockquote type=3D"cite">So we are talking about a
                  hardware limitation which potentially can't
                  <br>
                  be fixed without replacing the hardware.
                  <br>
                </blockquote>
                You expressed interest in &quot;some way to detect if a
                particular platform
                <br>
                supports cache snooping or not&quot;, by which I assumed yo=
u
                meant a
                <br>
                software method for the amdgpu/radeon drivers to call,
                rather than,
                <br>
                say, a website that driver maintainers can look up SoC
                names on. I'm
                <br>
                saying that that API already exists (just may need a bit
                more work).
                <br>
                Note that it is emphatically not a platform-level thing
                since
                <br>
                coherency can and does vary per device within a system.
                <br>
              </blockquote>
              Well, I think this is not something an individual driver
              should mess
              <br>
              with. What the driver should do is just express that it
              needs coherent
              <br>
              access to all of system memory and if that is not possible
              fail to load
              <br>
              with a warning why it is not possible.
              <br>
              <br>
              <blockquote type=3D"cite">I wasn't suggesting that Linux
                could somehow make coherency magically
                <br>
                work when the signals don't physically exist in the
                interconnect - I
                <br>
                was assuming you'd merely want to do something like
                throw a big
                <br>
                warning and taint the kernel to help triage bug reports.
                Some drivers
                <br>
                like ahci_qoriq and panfrost simply need to know so they
                can program
                <br>
                their device to emit the appropriate memory attributes
                either way, and
                <br>
                rely on the DMA API to hide the rest of the difference,
                but if you
                <br>
                want to treat non-coherent use as unsupported because it
                would require
                <br>
                too invasive changes that's fine by me.
                <br>
              </blockquote>
              Yes exactly that please. I mean not sure how panfrost is
              doing it, but
              <br>
              at least the Vulkan userspace API specification requires
              devices to have
              <br>
              coherent access to system memory.
              <br>
              <br>
              So even if I would want to do this it is simply not
              possible because the
              <br>
              application doesn't tell the driver which memory is
              accessed by the
              <br>
              device and which by the CPU.
              <br>
              <br>
              Christian.
              <br>
              <br>
              <blockquote type=3D"cite">Robin.
                <br>
              </blockquote>
            </blockquote>
          </blockquote>
          _______________________________________________
          <br>
          Linux-rockchip mailing list
          <br>
          <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Linux-rockch=
ip@lists.infradead.org">Linux-rockchip@lists.infradead.org</a>
          <br>
<a class=3D"moz-txt-link-freetext" href=3D"https://nam11.safelinks.protecti=
on.outlook.com/?url=3Dhttp%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo=
%2Flinux-rockchip&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C8bd=
b8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DF77FbO3SqslbzKu2%=
2FnjRLrQF45kljtD3%2FAEXEFd7NQs%3D&amp;amp;reserved=3D0">https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.infradead.org%2Fmailm=
an%2Flistinfo%2Flinux-rockchip&amp;amp;data=3D04%7C01%7Cchristian.koenig%40=
amd.com%7C8bdb8c3a6a2e4643bbfd08da08b42da4%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637831867224766930%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;amp;sdata=3DF77F=
bO3SqslbzKu2%2FnjRLrQF45kljtD3%2FAEXEFd7NQs%3D&amp;amp;reserved=3D0</a>
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------L7mEsylvQruaJp7AiHPbORSc--
