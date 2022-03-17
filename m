Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49E7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 12:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B1010EB93;
	Thu, 17 Mar 2022 12:51:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB5210EB91
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 12:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gawfJlCTqXQJUPiSwRhU5lx8h18Kw3RAe+1PsdSfx18mM8Wopc3GmdrdflIQqevLD9PDahvqW71hun6g0v6N1TgWVIuNWOW/tU06WFmnhV7MTI19SP2P23dwf4Bq+Vr6TUHkNyionJZRKqEmNyjiirfEgIJWn+uPR3yhJYA+Jz4833D+vyu7T3ugEl8p/cdnpF1SL3bxUMGse8woLvLZHPPAKcVNCNUQ2K+OSNcSBchKkWBy9IYAxFPbXH1SRT2nCLs5wGNIlxI1iuVs3/koAzH0b7NMdQhDAr6/VSwfFyM44Rkftk/IWwtboh0y8nGOemGSOv3Na3ygVdfc+u6wiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBAbSX33WRmhbkzwubiroRpZaWG6Vlwt9RBIHe5hfqI=;
 b=H8I2q0n6g3rncvAF2SE0gKL3FESkT2ksOKNUjc5zNqFbTXrnz7kvT+pk9s4rnJWLa3yLEcnXWrUGbtjd1up160pQoQlmke68/lI5n7zINPvkbxUYlYvj4lb9Y8X20x2qunvkJs8pIRsDZyYN/wlJ8pUMklFfBBtM5F9Mjm/MdhKzay5thBBA3STBbu2A7dqy8b4dsUa3rNn2yMaTMEz1ie7EyWdak702iVhdGzRCKCs6UlxS0Qnkkk9KU96i4Bx78uU6oskWp49uL+ncV+8XgDe4NEdTNV8FGv13dxeTsD8L7qosBIkmVYK5BaisMZ6MpfpjtXAyXNTTjRHBpNp4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBAbSX33WRmhbkzwubiroRpZaWG6Vlwt9RBIHe5hfqI=;
 b=DtcCJ5sP+lNQWUl+HTt34x/c1EvOhnp0h75Hc2hI+dwUt5en3DY5S7hmT7qFDMEh4aMBhPiil82HbvgTHkYHEOrYBOtbFuGKIM5QdyEsNXhN9NQuLvP75KmO9FJCexUzNvl8U8F6xiNb7C/cZFKmSO7Je2cfubSsSlDTSuVr1Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Thu, 17 Mar
 2022 12:51:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5081.015; Thu, 17 Mar 2022
 12:51:13 +0000
Message-ID: <919a09e8-f7c1-25d4-0473-2f7793fe1626@amd.com>
Date: Thu, 17 Mar 2022 13:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: radeon ring 0 test failed on arm64
Content-Language: en-US
To: Peter Geis <pgwipeout@gmail.com>, Robin Murphy <robin.murphy@arm.com>
References: <CAMdYzYptw9L=5SECtVkNZruTT-x57+03vj0A+5efvq8cESzLyQ@mail.gmail.com>
 <CADnq5_NXmRr_Q7JuWZxJAjmavVkvJjNcWayQ1x8LhfcX5CS0uA@mail.gmail.com>
 <CAMdYzYoamh-igvBbKaLSJ6bSc3wA29=8mooJDLMJkj9YQ=wj0A@mail.gmail.com>
 <CADnq5_NXFZPA_z6413FDgr8WRObhCB+HdkHE5P=PAAMV4FiWiA@mail.gmail.com>
 <20dffd4d-fa54-5bc3-c13b-f8ffbf0fb593@arm.com>
 <599edb94-8294-c4c5-ff7f-84c7072af3dd@gmail.com>
 <546bf682-565f-8384-ec80-201ce1c747f4@arm.com>
 <8afb06c4-7601-d0d7-feae-ee5abc9c3641@amd.com>
 <CAMdYzYqH57HuqMMydMtQw2Ep2A_Qhjg3N_gTw6GuO6Kuxd9chQ@mail.gmail.com>
 <c3bd7c08-f7e3-153e-8445-8e867916d03c@arm.com>
 <CAMdYzYpt1vOCXiDUHCnuVRKnQ51Qissj9-w75FB6nVrFWS-9iw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAMdYzYpt1vOCXiDUHCnuVRKnQ51Qissj9-w75FB6nVrFWS-9iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e1bd1a-f005-4278-4f4e-08da0814d11c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3399:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33990B5B7544126098D3213C83129@BYAPR12MB3399.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uxtRulddJ5s41Gayomrk6pTgkNZlJ3yYyNB4KhgfUN21V9A2e+hRbd6Dssa43i88Kp3eUXMGuFwaVkr+7oIihhlnRFxeg1gdSCuo11Gzhg3siKtU/JScBXZq31pEAjelbri+XVIyu+OBr5qqDOeGBC5AMBSnt04Tam+RY0t7T70SiIUmOJgZpG7PJZ7cDd7b1x2QKWU67PUjEgYcnd0xqP8OBKimufAOrKmLELQ/W9vGpDqAmnahCEixBUp8ed5dVOIErE97/81RAuF1+W+YB2HIHrFo8OXC+cmzdFVusUFzKInIGcBQrcmr8jMjF/LapupD7HUvE0g5nSPHK8LWcQ87T6VR2qOOkNq83qkXlqE5X/WWbcvVvGgv7aRQIPH78DzS61EI7YYv7+Kw4WwVx1pLFytwwE9EwatqfiP9sCnM7at8BcASkEQt0pEFfFEUmlvtWUuI4WSpSZhwUtAjpWU5EpvrKf2bepJYJadv3O/K9HhOue0lwJXd2qu7L93JeMdtpIWeyKnJxC8UadOZoSxgZCrqqyjEM2ePt9w0xkhk5RMaC5smmaC70n2cc585BeBpJa9ihREWBoLCWts5PJMzHOch2LskaqicLEE4c64q7XXd1pk1RIDrQ1SmnPjpTLf3ILvDZ63R7fqU4sYb2lLdrE1DwLR67+jatAknKdulV5uoCLFEIgpqJ5l4+vMXGI6w9fn131Nagnm9aFFCE+MtCMhipX703iQaxBQ544=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6486002)(508600001)(38100700002)(8936002)(4326008)(8676002)(66476007)(66946007)(66556008)(5660300002)(316002)(54906003)(110136005)(2906002)(53546011)(31696002)(6666004)(6506007)(6512007)(31686004)(86362001)(2616005)(186003)(26005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25lWjNpZUd4ZXhHc0FzTnhpMnJTVEZ6aVBJMC9WelFoeTBIWWlXNDJQd29Z?=
 =?utf-8?B?TzhUN3BIS2hYZ0JhZDc4dEJ0aDBnZ2YxUEJtZDN3S0JsU3pBVWpmamh6M0l1?=
 =?utf-8?B?K0RxeHVYdUxDTDVsdVFuTU5Eb3JicXM1MFZwN2ZBbzZKbGxrQmd0c2pMKzdB?=
 =?utf-8?B?OHFsTW1ncS9hRUtZa0dCV3IxZHlFdTZZQjZWZHRpaUVES284WngxTTZHUmxi?=
 =?utf-8?B?QzVqRG10Q2FiRW45RU9xVWdETkpKYUZzRmd6SnVjMUkzNnZiK3dUQUsrSng1?=
 =?utf-8?B?NWhUV1EyMkpsU3FJd3RqUEk1TmNsdkNaUGMySEJpSFN6MjNDQTFWSitCdXc1?=
 =?utf-8?B?ZnpabmhiUGtjbTlNOCsvbjZvQ044U3BHbGlqU3VNN1hXUFMwcmsrUW5GVFN0?=
 =?utf-8?B?QTg5WVAvbWRaQy9CL3FkZ2Y1K21xRXRxWGoyb1dCUVFDVjNZOGRaVTFSdjFz?=
 =?utf-8?B?RWh3SFIreklXb05QR0UrREh2TlAxY0lvcnViRktkdUZsK0xick4yek1qa1V0?=
 =?utf-8?B?dS80OFlGTHBsMThnZGJ1Tk9yTkJWbzRTMkNCMVRKTGY2dmRQUTZQRjM0NCts?=
 =?utf-8?B?dUhTRmVWOENGbldyaVM0TGV5aXBVc2dyQnk2OXFUQ1QrYTEvYnF3UXJGazZH?=
 =?utf-8?B?T2dkUDdtTFd6V0xkSjRsMEtWa0NBRlhYWW1PM2ZPanBGemMzbldQNFBnVFdt?=
 =?utf-8?B?MWFEVlE1SU5DQXdrcTdlQVcwQjFmY0wxTVhEWllHNlFSOGc2M08xSmROT09C?=
 =?utf-8?B?MXdKcDl0NURiSWZDS2o3OVlleW5mL2JPOW1FN3owRW8wekJQTE1pYkhFK0NR?=
 =?utf-8?B?cVVMZWtqd2l1dlJQTkExaGZiYVNOYWVOR3hsVnoyY2c0VnVqRkJmTHp6c1Fx?=
 =?utf-8?B?cHZPL0pzNUExdm5DZTVxV28vaW5GSkdqdzNrQlV1OTFlbkZseUFYbUs2eDUy?=
 =?utf-8?B?ZWJVUnBSNEVySmhrKzQxWVROeGlQRFJaUGpyWUtjQTVzaVlsclhPTVpncS9L?=
 =?utf-8?B?THdTYlpXdkVtODlNRG4vOUMwUWI4ck5aWVVETlc3OTR5NEk5K0pUVnNpd1NE?=
 =?utf-8?B?QnczRG4vM2JqVU8wSlpBSW43UHFpRXd3enlDbVo2WlRRNm5vUVYrL2NrY0ht?=
 =?utf-8?B?RWdqNEhFTXV5NlZrQXJiVEJpRzhESUw2R01wbzBGdjdIZHpLck9GTHFlWVNC?=
 =?utf-8?B?K2pnclB4STJwUmxBOEYyY2JCNjdvRlEyaHFaam15aGZmR2JXTTRPN0FYSGZR?=
 =?utf-8?B?TVFZaGVMN1RmRUNFSDdFSWpiaEdUWG1NZUMxR1dFQXE5YXFKVHJUN1hlNC8y?=
 =?utf-8?B?OWp4dm5OLzZ5a1BwcGdkejJUd2xWZzJRcXYrY2M3Q0VZUnFvdmQ2ZTVua1pP?=
 =?utf-8?B?UzdBbDc3ZU81V2w4OEY1YkZraCtyOCswTkh1RlZkY0h2WGMyN1VxTjF2Q0lM?=
 =?utf-8?B?S01JcXNaT2NMTGIzWWRzNmdoL2R0K3VGUnp6Uk9hS3pOYURzQVJzY1RrYU5X?=
 =?utf-8?B?UXVMUWVERUxMWkxlbVhPRDdwQXcyS2dZYUZiRDBxUHcrZEhwNXdOS0dwS2ZO?=
 =?utf-8?B?OStrYXpqVDh4RzZBZjFGdUxDSUJQQWZuTm9BMjBYRHRoMUtBb0dWTlpWZ05i?=
 =?utf-8?B?bE5OTHcyWG1RNFc3M1JRdWZ1OG9RSStJT3M0MkZQMnJpZjBMbmFPamF2VFA1?=
 =?utf-8?B?d3NJNUY3ZTVNeUdxSWczNmhjR1p1ZFp4dGJhZHZhOWoyNS8vVklROG1PZ29o?=
 =?utf-8?B?dmlBWWNmNXc2ZURnb0VPZlV5RjE5Z2QyL3RZdTdRWUJHVytZQkdHSW45eWhY?=
 =?utf-8?B?Z3AzS0ZGbThpc0tqU1ZTVE15K1JlWnRuVGZ0ZG1WRnpadGoxQjBadEg0NFUw?=
 =?utf-8?B?aFRkMlpMVE5FQklrQUVDcEdTWjdVZmNEQ00wMTEzQ2tOUWttNDVjbnh3SXFM?=
 =?utf-8?Q?zVuCy+LfXC4OnyTM3RHiJ8SqHG/iKJFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e1bd1a-f005-4278-4f4e-08da0814d11c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 12:51:13.2476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjU3lrD7LrAf4MrutNz/gw8O5h6GV5mMlei8T4LG1asLVDUidtauKZY4OIGMvoC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3399
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
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.03.22 um 13:26 schrieb Peter Geis:
> On Thu, Mar 17, 2022 at 6:37 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2022-03-17 00:14, Peter Geis wrote:
>>> Good Evening,
>>>
>>> I apologize for raising this email chain from the dead, but there have
>>> been some developments that have introduced even more questions.
>>> I've looped the Rockchip mailing list into this too, as this affects
>>> rk356x, and likely the upcoming rk3588 if [1] is to be believed.
>>>
>>> TLDR for those not familiar: It seems the rk356x series (and possibly
>>> the rk3588) were built without any outer coherent cache.
>>> This means (unless Rockchip wants to clarify here) devices such as the
>>> ITS and PCIe cannot utilize cache snooping.
>>> This is based on the results of the email chain [2].
>>>
>>> The new circumstances are as follows:
>>> The RPi CM4 Adventure Team as I've taken to calling them has been
>>> attempting to get a dGPU working with the very broken Broadcom
>>> controller in the RPi CM4.
>>> Recently they acquired a SoQuartz rk3566 module which is pin
>>> compatible with the CM4, and have taken to trying it out as well.
>>>
>>> This is how I got involved.
>>> It seems they found a trivial way to force the Radeon R600 driver to
>>> use Non-Cached memory for everything.
>>> This single line change, combined with using memset_io instead of
>>> memset, allows the ring tests to pass and the card probes successfully
>>> (minus the DMA limitations of the rk356x due to the 32 bit
>>> interconnect).
>>> I discovered using this method that we start having unaligned io
>>> memory access faults (bus errors) when running glmark2-drm (running
>>> glmark2 directly was impossible, as both X and Wayland crashed too
>>> early).
>>> I traced this to using what I thought at the time was an unsafe memcpy
>>> in the mesa stack.
>>> Rewriting this function to force aligned writes solved the problem and
>>> allows glmark2-drm to run to completion.
>>> With some extensive debugging, I found about half a dozen memcpy
>>> functions in mesa that if forced to be aligned would allow Wayland to
>>> start, but with hilarious display corruption (see [3]. [4]).
>>> The CM4 team is convinced this is an issue with memcpy in glibc, but
>>> I'm not convinced it's that simple.
>>>
>>> On my two hour drive in to work this morning, I got to thinking.
>>> If this was an memcpy fault, this would be universally broken on arm64
>>> which is obviously not the case.
>>> So I started thinking, what is different here than with systems known to work:
>>> 1. No IOMMU for the PCIe controller.
>>> 2. The Outer Cache Issue.
>>>
>>> Robin:
>>> My questions for you, since you're the smartest person I know about
>>> arm64 memory management:
>>> Could cache snooping permit unaligned accesses to IO to be safe?
>> No.
>>
>>> Or
>>> Is it the lack of an IOMMU that's causing the alignment faults to become fatal?
>> No.
>>
>>> Or
>>> Am I insane here?
>> No. (probably)
>>
>> CPU access to PCIe has nothing to do with PCIe's access to memory. From
>> what you've described, my guess is that a GPU BAR gets put in a
>> non-prefetchable window, such that it ends up mapped as Device memory
>> (whereas if it were prefetchable it would be Normal Non-Cacheable).
> Okay, this is perfect and I think you just put me on the right track
> for identifying the exact issue. Thanks!
>
> I've sliced up the non-prefetchable window and given it a prefetchable window.
> The 256MB BAR now resides in that window.
> However I'm still getting bus errors, so it seems the prefetch isn't
> actually happening.
> The difference is now the GPU realizes that an error has happened and
> initiates recovery, vice before where it seemed to be clueless.
> If I understand everything correctly, that's because before the bus
> error was raised by the CPU due to the memory flag, vice now where
> it's actually the bus raising the alarm.

Mhm, that's really interesting.

The BIF (bus interface) should be able to handle all power of twos 
between 8bits and 128bits on the hardware generation IIRC (but could 
also be 64bits or 256bits, need to check the hw docs as well).

So once the request ended up at the GPU it should be able to handle it. 
Maybe a mis-configured bridge in between?

> My next question, is this something the driver should set and isn't,
> or is it just because of the broken cache coherency?

As Robin noted as well we have two different issues here:

1. Cache coherency of system memory.
2. Unaligned accesses on IO memory.

The later can actually be avoided if we absolutely have to. E.g. for 
bringup with test the ASICs alone without any DRAM attached. That is so 
called ZFB (zero frame buffer) mode for the driver.

I don't think we ever made the necessary patches for that public, but in 
theory it is possible.

Only the first item is just not solvable cleanly as far as I understand it.

Regards,
Christian.

>
>> Robin.
> Thanks again!
> Peter

