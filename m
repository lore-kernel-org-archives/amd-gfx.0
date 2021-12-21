Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE5FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 07:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB60710E15F;
	Tue, 21 Dec 2021 07:52:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C9A10E130
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 07:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiKqTh6bQ3YTMeH8Ti9cjSQFdjuKcu09XC3a4Dc9bgGDgu2eXC/F1q3cwApBnZYNwY9dEGdjlkNBDhP4ffuwYt6emWStAVdZs3BOXev1JgKxJKhuRxjqaodZ14nCV6RqaLCsYNReIz4Fc573zmILCz6nwp3R1CziVXN5otlNkMcsI6/5bIiO5Jn+o3yQ8zVpwNIT5pjKrHUSMEMCLT6iK16e/8L6Jmkf2dBWqKAjgKrioqiNP9FJDZ3MJZcDhEy3fkofsOGHpH/5JnmkEWJrYRKL/+QqKPfrWcJP+vn5AET9PaUOR/m4ljn0NhpnZW0jZdfPch1l3YoKJbb0CDNETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcMb3MuvmlZ6M/HHk+mDBi17Ze955Lx3N1hauEyHLhA=;
 b=lzIfy3/tdBx5A5QQ97S+udxeAQTdYlZXbQDnqdkjlZ9tcGLZjqPnbmDJnRrdvNiC3fPhJJhUX+z488zSePn9YFuB7gQdUC9V1hIygY8Gs93scJJj/yGqSj253J2H+iWAMjnmn8J4PFP25dez3VjAPKiTSK4sTY94OFWiA4AzWk66a56+mhVBeMm0OmPc2Fw9plmIih/cohQIObjYhdzua7d0WD60ztUpbJy5cozK6EKqb2EG84fAl6ey6D1MwixZjS0NuwRflSWVkAiVcP9EYBtlLchXOref4BNSLPYKVB/kxmfXg2kwhWpnMWpr31dfYVLe5KoVchHfwkrN8TLg1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcMb3MuvmlZ6M/HHk+mDBi17Ze955Lx3N1hauEyHLhA=;
 b=NI8CzY//onyEXKoYsbu3b/KRyZk9XmaEzQw0aXDL8hYf8DdiGgBLYyB29ptm2YUjhqRPoTShVrxPMXTh+sGUW3uOZgb/YlTmx/C11yV/W4iJSn5vGD9/wFe0CqsllRrnolnLMAJMTzvz2pIU0nRuNRjenniYEcjNEcKJEAQDUqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 07:52:04 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::17b:556a:9bb2:60e7%12]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:52:04 +0000
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Imre Deak <imre.deak@intel.com>, "Wentland, Harry" <harry.wentland@amd.com>
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
 <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ebe70af1-d90a-7c98-b8d3-e631b777013b@amd.com>
Date: Tue, 21 Dec 2021 08:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAHk-=wgtGHeEqE9e-NSYQ51pU8QR13CL5Njp_wh9n2hwPiKZEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0078.eurprd07.prod.outlook.com
 (2603:10a6:207:6::12) To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6443706e-fd92-40b2-73d4-08d9c456c776
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB274650EDF617F69BE03243F0837C9@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfXestJbKKENIfP0Q3pYYsZ84HtkhfWXAnhztdOI27SvYu3PEF9rZmLZ7xkSMLDnVq7RFLHBdqDJVifvlZdYaIInCu9mC+e8fL8MCTNpk7yAY1/NgQoO/EHxG35s0y7mZw3RDyEie4LERIp5Jf8cBABueFr9CRzUvY5iqrhRJpG7MTy6C3Lgu5iEp05GpOT1cKCghgEwT7wUALpZIa4gFlqAYpuhxil3JxpmIYE1InXP0mcDtEhMwh1v88BXAjOOpDlJM4nn+UDdtgq6XBEao08LYO+jvuEV0z2a3fsiAhr0X4F62F2WwFNJXnqSanrDMosu5oTkw74icx+QGZl5hQULt/3x1U3CB4389Uj9iow1NLhcQQh5+SPO2bBx+kV24AZPAuq6x7HY8GrLUoTDsQflvGREwwqYHP570T2x6xWJRQNJq0xtc+8wP0znrgETRg8LbwDfvSjZmRwdWE4dWAiJJNJujCulA8tPsA9i4/tGaB8qIrdhYH9YyQW+SnwuxeZJkxKdPag2GJiv8OZPPX1OdQN23r7KM9HV18Wlx70krtoqaXTCVHN2ICQVVtOO0kUuAF51UL5vpbdhbKpSfqVYVxMyEtA+KxWpwqRseHTf2ZibltHKtKgxvCZGjdfTnbuVEFN6CJPs7NcboTkWvQe/FU8TvarcAuRoH1M0VxdTiXa2dT65BwKQWBLIGnCr0fs5wKWXUsOqj2vh0UTWOfsIyvXWI6ccNfmIr+h9dxA78oyhEk4M/YMAcjitxpC3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(31696002)(508600001)(2616005)(83380400001)(8936002)(6512007)(8676002)(186003)(6486002)(6506007)(110136005)(2906002)(6636002)(38100700002)(316002)(54906003)(5660300002)(86362001)(4326008)(36756003)(66556008)(66476007)(66946007)(31686004)(6666004)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNhYTNXL1U3OGlXc0wrV3NlV05LTmdGUzdhTFpwdzdCN2hiZmNTWEpWUU5O?=
 =?utf-8?B?K0V5QXcreHZ0T3JHVU5qNUQyNmMzVzRXS2htWExNaVR3aFAvZzdkV2kxYkE0?=
 =?utf-8?B?RStwTkwrK052ZmlBNnB1TkxYTDJnR2t6M29vV0lnV1dIVTNwYWJJaU1MZmhm?=
 =?utf-8?B?UDJhQ0EyUmNrcVpqUVc5MThEdXdOdDhHOTZEdCtoTzNheSttVDVVa1IzVFRq?=
 =?utf-8?B?TXBKTGl4SjJXSldiL3BnUUhSdUJBb292amhHTmNCZ3FiWlNUM2VkNmtXSkVw?=
 =?utf-8?B?bTB4UEF5YUVBdGZEK0w4bHR0TE1kWUVEZWl0RnpXS21HaS9WM1loMERBbkZW?=
 =?utf-8?B?R2huUzV2eEc0aWVoN3gzODN2bnVqSEp3QzB1VDZvdTl2VFI0TzhmSDZ2MXlP?=
 =?utf-8?B?MUduQy91eFF4RmZsSW44b2JmM3FlRk1NR2g5aVk1WWJFQUs4M2crNG16L2p4?=
 =?utf-8?B?REN1SDZKa0J0cWlpYnpLcEh4TmNOY3pzZW1ib1lIK3pDU3BYejltMFg1L3Zj?=
 =?utf-8?B?VlByR0JWYm43cUhCQnRLWTU1KzNOZ2FLSHNoVWRtK2svUUo0K01QckZMbkFt?=
 =?utf-8?B?a1dFMnNMLzNHZmV3YThOeWNYUmErZVJsUGQzdXB2eFEvN3dVd21RTlJpSGND?=
 =?utf-8?B?d3BKM0tJTFJTbVFxeHBvOWRubXJrOEpMVEJHMXlsUUhMSk5qV0J1T1JlQldv?=
 =?utf-8?B?Yzkya1JnVGhZRjZIZ1B6TG0zc05qdVpjZThHZWg5N2lKQzAvakI0QjRJTVBP?=
 =?utf-8?B?ZHJTaHpib3ROLzhYeWE3eWUvVGhIdkFkTFhmZGNCRGR4ZjVXTmRqRjF5OUxL?=
 =?utf-8?B?WjY3MDMzeGVHOWhMbzZhYnR3cnBuaDU0alV2NWRROE5ianJLQ1NoZU5xYVdU?=
 =?utf-8?B?dDU4TEt2M2V5bEZpZzdxcThiS2dsUWRaZnM5SXVNNzd0M3RIREdsQUh0WVFX?=
 =?utf-8?B?bUdXM2kvL3dhN3RNK1NWVzIza0JLU3c4WStWc3RGVjArMThIVkltUzJMdGFP?=
 =?utf-8?B?LzRxcm5rL205SFpGbE5vaXdwODRRWkwrS0czaDhCcEJVTjhmenE2MTI0am8y?=
 =?utf-8?B?K001WTh2d2R2aVFDbVV3eHBaWFg2ckQ1MUdyVlNCd0t6dVNZZkxBVnBNVERH?=
 =?utf-8?B?c3ZHNGtZUXJCSzdCWWRhMkNWNXcwRUxaTitibk83akZJWGFaTHhFRTVGWC90?=
 =?utf-8?B?OGJpdFJyRTRxM0pzdFhZNVpNZzFaL0JNR1BqT0dTNHI4Szl3R21DTUNwOTI0?=
 =?utf-8?B?NE5LNFJHREtzRTNPVklhazlaOVJoeW9ESktMaTVQLzV4enhBTzE3TjlTbVlQ?=
 =?utf-8?B?Q0piemc2ckZ5TzFjcDVhNXBoTmkzRnF2cGM5TDZOU2ZNZDY2MHBXWFE4MjJk?=
 =?utf-8?B?cjFmZG4yQjRPdGgxYlhZdUlZS1ltWGhDRXNBRFlNUEtCaDJCcjhGU0JGN1hH?=
 =?utf-8?B?UDhoNFhYRVVwYlVwb3VQMms1MDJadUdsRFZWTmVJN2pzSjN6N3VlVzVRRmtw?=
 =?utf-8?B?QllsY2ZFSnRaR3ZNRDhtYUJBR1lRU2xKZzNhS2s0TW1iKzNSYmNhSXNLR3Vr?=
 =?utf-8?B?R1hxTHdYYUc1ZTMyMUwrYlVKL2F3ekZUemZqa2pXK05iN252b3ZkSXRzTTBQ?=
 =?utf-8?B?N1o4WFJwUWp3YVlYNUFYeW5HRFEvNWRKeDdrb1ZYSEhEdFZmQ2QyV01mbUNP?=
 =?utf-8?B?VlJ4UGhMOFRtRG55NXA4bFlLM2hwdVRZNnhvdWZjNkE0cjl6RVI5MkQrekRm?=
 =?utf-8?B?VlgvM0dHODJmRzVVNHk4T2pMQU1OOXdDS1BNQ2x3RVZHNTlRN3VjZGVCb2Nw?=
 =?utf-8?B?aWF1TWZLWW1laWQzdHJEa05GbDNMeDQxOStGMWxadmZLQWdEYzE0VWlyK28r?=
 =?utf-8?B?dzJzbEpjcFJGditmUlhJRFlTdWJOQVV5SkROTVFYTk9qbTI0V01HNm43MXA3?=
 =?utf-8?B?VXVmeTdPTVlPWWMvY2lMVnhnUk05L3g3ZzhhbTBYUHBFbnJnRWtSOG1Bby9i?=
 =?utf-8?B?em9HV0tWakdIL0lRZHBudFVmb0YxZkRxeE1xWFNveDIyamdHejBJZkVpcGZR?=
 =?utf-8?B?NE50SzhUR3V3ZWhHTldXUWxvMCtSaFlqYTZnLzVGQlFValduZnpybDFPSGJ2?=
 =?utf-8?Q?xRcM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6443706e-fd92-40b2-73d4-08d9c456c776
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:52:04.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szLfySIDIvXd0179ounSSceyjmGb9XKuQ0Hok02HzG9nyVFRF7L5PFrTr47B1APK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good morning guys,

first of all get better soon Linus.

I'm unfortunately not the best expert for runtime power management 
(Alex) nor display (Harry), but from the lack of their response I guess 
that they are already on vacation. So maybe take everything I explain 
here with a grain of salt.

Then for the background we have two separate power management features 
here which doesn't seem to work as they should.

The first buggy one is runtime power management, which is what commit 
55285e21f045 surfaces. My educated guess is that the now corrected 
reference counting turns of the GPU before userspace has a chance to 
send a signal to the monitor to turn of it's backlight. Double checking 
the code I can see the correct calls to pm_runtime_get_*() and 
pm_runtime_put_*() in amdgpu_dm_atomic_commit_tail(), but to be honest 
that function seems to be quite a mess.

A trace of what exactly happens during PM autosuspend might help here. 
Daniel do you know any tracepoint for that?

Then we have DPMS, which is basically the way of telling the monitor to 
shut of it's backlight. When this doesn't work as expected (e.g. you 
need *two* cycles) then it can as well be that userspace is not sending 
the right command.

When you use X you could double check with "xset dpms force off" and 
"xset dpms force suspend". At least with my monitor it turns of the 
backlight in both cases, but maybe your hardware behaves differently.

Regards,
Christian.

Am 20.12.21 um 23:21 schrieb Linus Torvalds:
> [ Adding back in more amd people and the amd list, the people Daniel
> added seem to have gotten lost again, but I think people at least saw
> my original report thanks to Daniel ]
>
> With "amdgpu.runpm=0", things are better, but not perfect. With that I
> can lock the screen, and it has to go through *two* cycles of "No
> signal, turning off", but on the second cycle it does finally work.
>
> This was exposed by commit 55285e21f045 ("fbdev/efifb: Release PCI
> device's runtime PM ref during FB destroy"), probably because that
> made runtime PM actually potentially work, but it is then broken on
> amdgpu.
>
> Absolutely nothing odd in my setup. Two monitors, one GPU. PCI ID
> 1002:67df rev e7, subsystem ID 1da2:e353.
>
> I'd expect pretty much any amdgpu person to see this.
>
> On Mon, Dec 20, 2021 at 2:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Note: on my machine, I get that
>>
>>     amdgpu 0000:49:00.0: amdgpu: Using BACO for runtime pm
>>
>> so maybe the other possible runtime pm models (ARPX and BOCO) are ok,
>> and it's only that BACO case that is broken.
> Hmm. The *documentation* says:
>
>      PX runtime pm
>          2 = force enable with BAMACO,
>          1 = force enable with BACO,
>          0 = disable,
>          -1 = PX only default
>
> but the code actually makes anything != 0 enable it, except on VEGA20
> and ARCTURUS, where it needs to be positive.
>
> My card is apparently "POLARIS10", whatever that means, which means
> that any non-zero value of amdgpu_runtime_pm will enable runtime PM as
> long as "amdgpu_device_supports_baco()" is true. Which it is.
>
> Whatever. Now I'm just kwetching about the documentation not matching
> what I see the code doing, which is never a great sign when things
> don't work.
>
>                Linus

