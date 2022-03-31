Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A4CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 13:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F19A710F264;
	Thu, 31 Mar 2022 13:18:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB5810F264
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 13:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl/PmabO5ehILmqfqjuHLhPre+Sww00MSSqVo06XSvbfggxyzEPxYlIgT6D9NHAXsZ3IletHCJ52AWuZB+KfAuX+aCyL0Odp9qkA4JK/3pw9KRJS6qsivCIaQ8HX5LsRNmwqYqZ7nmW+80DHooitbzEYPPA77FrzZ86oCG/kUEUwLxNicUuHDbZQBKQGaBLjn5kNgdDm5DBUpkUL83NNloPitI9HgQ7U8iq00XX10FhlA5ammO4FrfbISNAfPSoEDOrV/5KllW4JPlW+RdW+nhG3VUMFVRrokgG75oqJ9FY4pcqyHto9hkUkCQLHqiyeoVj0S/o6GpWEmlm4/1xKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLTbrAXb5ZdCDTRYKE7MdHQ7aRCraU9FU/SSWQJlGB0=;
 b=meBWqKO/EnWHljRo+vAp8TDVe1YgH1+yMVrVI04EwAF6Exurj1ntBl0aTk/jUUouK8XvhvTadwNdwRYc/CBHR12uEx61jFyUGnQsvbqlr8ICS59mqKkgqQJpBJfuc3/7qHE7rBz50f931tIH2rlNT+Uwq3/L3Su3w4mSali7yLJhJlgI8/2te7w01lYAdkPJiTJ5dsS95qlqzhIIap1vaodXd5yFIfT0blB1tJnJLWsz/RWb0UbKLyHcjJXukBxh5zz6exoZXld3s8uhddqXpL3rDmy1s6ziqcBMT/l28WzxlymDECZcKBgBo2/ZhbLctn2SlHuRvBgnWE6837cZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLTbrAXb5ZdCDTRYKE7MdHQ7aRCraU9FU/SSWQJlGB0=;
 b=FE/jZE0zZ1xHu99x2A0X++TrkH+OrxN348Bsmdjwpftgp29gOFbUu8mjYC+t9uTnBIm966M3lt9ojwqXrh3uV4a1OX5PNDfb+udALlMG6p/8NJvgKYDYOgKnjcEDvWYZJnu49E1KkzGGLqj5FFTnIbJInB89Ufo0uUYU6miQU3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by BN8PR12MB3044.namprd12.prod.outlook.com (2603:10b6:408:45::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 13:18:19 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::84a2:64f8:f2ec:fc08]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::84a2:64f8:f2ec:fc08%4]) with mapi id 15.20.5102.022; Thu, 31 Mar 2022
 13:18:19 +0000
Message-ID: <6dd99676-6d43-c16d-ef4b-3243278de0e1@amd.com>
Date: Thu, 31 Mar 2022 09:18:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>,
 "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>
References: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
 <c8c00a40-5f1f-d861-adde-3dc246cd2338@molgen.mpg.de>
 <MW4PR12MB5668E0D09D8A0B1D9B7E6EC2961F9@MW4PR12MB5668.namprd12.prod.outlook.com>
 <20220330135737.iuoo7qnjbhthjs45@mail.igalia.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
In-Reply-To: <20220330135737.iuoo7qnjbhthjs45@mail.igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b34728-b979-40f3-a193-08da1318ec14
X-MS-TrafficTypeDiagnostic: BN8PR12MB3044:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB304464FD043CFBE4C29E9D7098E19@BN8PR12MB3044.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZB6lbRlDdcQK4uzu2LMYbDRMOK4TSfF+S/kiaJXr4kxIcgqxP9cZkBtsS+covDMeeYcoA7F4yKqHKKT6cgdxOvLqa+DG8YbErMHMIrRLfnlKd8ykFp+CO/uTBYPsRrgC0rmM6JrOmC3nQXLyv2aXTST8/CAWO/lSuhhW/lB8w6+ikm7X9qHNLmbHlMmLtPIOIAC/sr+iwZlNoRs+1B+fMCERKZY1zp4PHx1K8/XsoYqonT5KrOR7iUQewNQp90hQXCGz/Gl+osPBR4TU0BYftp75htID38IE6M48Cos/z5FRXvG4I+OyolLWvvJfxszWJX1htlk/ww84pm008nfr5UAI2bA8W0RV5K7MvjDBOEpk621v+iJIYSvPz34mFZZEqQc6Yblvnb+L9xbLBu0Wnw0FrT9sRu4ey7xuF5CXto/Dygu1wNHgJNNmCn9Rmxdu1V7m8rAfjZGyHGpOzdFRGiXqolakoij2IdsoZ8/fqPQTeezXwDm/K3OhoxQXybPFcN0xINPn7UhUxAxxiMXZfLXFRflzoY2tFF0cYbN4m4t2hTxoupFn30KK6IMYtN8ZZP3wIMHBrxg7e/KkAVFllqpY12CnjCasSyc9eOXtCMB+vpU4jn2bbqAlnO3nqADdOnFU9zRRcyqlDrpyOWDQdT0FiIzmm6ThAOXojjUs3Qz6IVfv5QE6MPQk2WgpBSNEgqIm0H1jDLQWrJ9TNF751skcNKF/eI/7nw3kbEBFijhVNHunAiR+X3hQbp4HBFtn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(4326008)(2616005)(110136005)(2906002)(6506007)(54906003)(8936002)(508600001)(53546011)(5660300002)(31696002)(6636002)(6666004)(6512007)(316002)(66574015)(186003)(36756003)(38100700002)(66476007)(66556008)(8676002)(31686004)(66946007)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVl3TTVQYkgyYUlpM1drQWo0MWpjTWNpUyt1R2phSXJEbnd6bzhFS2dwU0tn?=
 =?utf-8?B?QzkzQ09oTTJYZktnNFhoVzFzTmN5SWNVNHJnRE95ci9jOHF4MStSdDVvbDc0?=
 =?utf-8?B?UElIaWt4WW1ManFhTURqTnR0dnVuSTVZUW5iUEJyRGU4aW9ORWgzTktHQStD?=
 =?utf-8?B?bVIzVk5NWHBweFVVNHJjcGU5ekVrMUplRndiYTg3K3hEcFB5SitYdEdMdXdp?=
 =?utf-8?B?REgwUmNUREFjT1ZaKytiR2czR0xMVC84dUNNUXZtUjVVVHhBa2xkMWxQMjJK?=
 =?utf-8?B?OWFqcHdiQUdpVXNhdmY2RFVRN1ViZGp4MTlxWEJqMExMRGkxSy9OUVExUlBX?=
 =?utf-8?B?MkJYUTk0dHJsQU54MmNlL21mekczdURMWW5JZFVzVmlRTUZ2bWVoNXRReXNk?=
 =?utf-8?B?MU9vcWlDSWtxSUoyWURFOG5TU3RvbVpZdTRLRzRaUUc2VUpkWkd2K0hMUUNi?=
 =?utf-8?B?MnVEK0Zsdi9JeXZicWY2VEUvTTc5ZitXNy9ndnByYVE2ck5KUHBKa2E2dUo3?=
 =?utf-8?B?TGhVRmd6MmhlVWRRKzZUTlpWVW1MNUVXaHhqcFJEODBjZEtHaWZlUWwxc1BM?=
 =?utf-8?B?NjFIa1hPYXU4emdpazUrWm05YWpoZkV3MDRHbzluNWlSeUtreE1JMGJ6Tk5K?=
 =?utf-8?B?Z0RuTzRWQ2FVbGVza0toL3hicWcyRXEyMGVUS09hWWhpWnNqTVQ0TDE1VzJs?=
 =?utf-8?B?TDYrSjl2NlUxSC9iN0N4ZlF4YWhxdTJSbHd4RDg4NlhSRmt2SGM0eDEvMUI2?=
 =?utf-8?B?N3ZtZ3RBdW1HZmp2NnNQRlB4bExzdm1mcDJVYURCQ1M1dEtVT1QwR3hSUXpG?=
 =?utf-8?B?NGFybFFhU1psMjR2OE9FeWYvUTVoUnZ6ZFpQU005RGpUMFhJeDFpNWFnalJn?=
 =?utf-8?B?cHhTdWxGTDRScUFBZWZYTy9zSmphYVZHWmNwc29uWnhsbHZyaTRBL0VaZDcx?=
 =?utf-8?B?R0ZwdkxFdWVSY2I5T2lPUXhCcmRTWFFuNW1pV2RIZ0hCR1h0MGdrd0VhTXVn?=
 =?utf-8?B?Y3F0NFBvMTBPV0xiVzNLZkFhckVPK2QzMmcyYWFrT1JDN2Z5dE5XblUrcnlK?=
 =?utf-8?B?MFNHRCtrYUdXaHlKYk9UUmRuV2oyNkhtRTlvTmE2Q0ExdG5EWDBKeFVTMW5G?=
 =?utf-8?B?ek5zVUI0bEhtWkExbXNOeWJXVGNoREl1YzFBVk1XTHd6ODZXNjhaVEkxeWox?=
 =?utf-8?B?TkJSbDZiMHNUbU1WeXgreXJKbkRIWjhpeUl0OCtTMHVNTEszRUs5SXdoZWND?=
 =?utf-8?B?VkFZcHlmNytPalpiOEZMMEl1N2ZaVnl0L1hkejRjYTh3TXlLSUFHcmZISFZa?=
 =?utf-8?B?WWZPeTNaR2tSSzk3Rlg4Z2RPS09aWkVDK3JZSGdDNjFqTEVuRVZLU1AxM0ZX?=
 =?utf-8?B?WXNrNmRpV2hWRjRpTEgrUG9INEJjcmJiTW01VTNzT21WTWk1NFJPMGlUSVVN?=
 =?utf-8?B?anBUaVZUdXRUcnlsQkU5a0RVTnZBWnd1SEdwUS9YK3pVZmUzd1BIclV3QW10?=
 =?utf-8?B?VVJzajZyRDEzUXJxaGQ4V2RRTDVTQTEwSVI1aWZ1ZUhVREp1cTVnODdsR3lT?=
 =?utf-8?B?Sk9ULzdYV2RVRVVrRFF6OGpzOXRGSUFOTnZZUzg4bG5vRDhDa0NXVTVTQzVt?=
 =?utf-8?B?OU1uT0dudm02bVYwVGFzQmFYNmhtbUQ5TTM1Wm9RbU0wSVRlUURRSHRUY2gv?=
 =?utf-8?B?bmsyaXE2RFhuc1dBbzBDMUtheUF3TjJhRWtQcmhJTG5HTzg3azA4Uk5HTmNQ?=
 =?utf-8?B?OTJTcis5dGEwVlowSmNvaTRsMXloTStEK1R0c1E1am4xV2VSRVJuWXlWOTdI?=
 =?utf-8?B?Um9TOHJNcUdmRDlMWlNTK2Vkb3gzV05oQUlaNHVKZWQ0Z2luMjF5YXl3TVlN?=
 =?utf-8?B?QURGTnpwMXBYODhLYmk0NGowdllTbWM2RUl0ZlRNeU5RN2N5OWVUbTJqTGdo?=
 =?utf-8?B?Tmwyalh1cnRPajJmUkhNL2RXODVHWi9kV05vYlROdVNHZ3lHZTRraERkU2ox?=
 =?utf-8?B?WmplMmEyenFLdXRoQzVJRnN1VC9naUpiMGtHRHp3Z29IV1V5K25zbGlDNGo1?=
 =?utf-8?B?YmxOYk15UzdmNWFXRVIxNXVreC9YMklPb1VzbExpbGRzY2Z0T0Z3NHNaV2tW?=
 =?utf-8?B?NEtDKzZOTG5XYjBBRnI4OVQ4MitCRFRld29tZHM5dXVtVnFBVEtKRXhTdk4x?=
 =?utf-8?B?ZXRKZGJBZzdMaUY5T25ma2lpMXpMbVQ0Vm9PUXhQbnpVaitPblZ2SVhaTjQ1?=
 =?utf-8?B?RGJxS01idWVuT1JoZCtSclJnYXVzQ0dhclhMd3IyejZSTFNQeTJRRnAycVV6?=
 =?utf-8?B?UnhaTUVyOUVCVkg2MVFJQWU1UWNPNjZoeExVUEErQU9teFRpYngvMnl5d2py?=
 =?utf-8?Q?oe3NfS8ZlKuHIuY8zOkedVUs0Dclc39g74/OHa56eI5zX?=
X-MS-Exchange-AntiSpam-MessageData-1: jMcwE5M6w5ueRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b34728-b979-40f3-a193-08da1318ec14
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 13:18:18.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4bsJNuySgzIpePRU52R/6KlAr9GxAx4eGG8OR0CG4g0Ac3MLfPWp4K9eJBBwdm65WSnpl1cvuh1m0RYXm3YlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3044
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-03-30 09:57, Melissa Wen wrote:
> On 03/30, VURDIGERENATARAJ, CHANDAN wrote:
>> Hi Paul,
>>
>>> Am 29.03.22 um 10:29 schrieb CHANDAN VURDIGERE NATARAJ:
>>>
>>> Is it common to spell your name all uppercase? If not, please use Chandan nVurdigere Nataraj.
>>>
>>>> [WHY]
>>>
>>> The [] already emphasize the word, so Why could be used.
>>>
>>>> Below general protection fault observed when WebGL Aquarium is run for
>>>> longer duration. If drm debug logs are enabled and set to 0x1f then
>>>> the
>>>
>>> In what browser and what version?
>> The issue was observed on ChromiumOS and Chromium Browser version 100.0.4877.0
>>>
>>>> issue is observed within 10 minutes of run.
>>>
>>> Where you able to reproduce it without drm debug logs?
>> Yes. It took 34 hours to reproduce without drm debug logs. Using drm debug logs was a faster way to reproduce the issue.
>>>
>>>> [  100.717056] general protection fault, probably for non-canonical address 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI
>>>> [  100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G        W         5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b
>>>> [  100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f
>>>> [  100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00
>>>> f2 42 0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10
>>>> 0f 57 c0 <f3> 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff
>>>> 48 8b [  100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246 [
>>>> 100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX:
>>>> 0000000000000000 [  100.819656] RDX: 0000000000000001 RSI:
>>>> ffff99deb712c49c RDI: 0000000000000000 [  100.826781] RBP:
>>>> ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99deb712462c [
>>>> 100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12:
>>>> ffff99deb712ae44 [  100.841033] R13: 0000000000000001 R14:
>>>> 0000000000000000 R15: ffffa9230079f0a0 [  100.848159] FS:  00007af121212640(0000) GS:ffff99deba780000(0000) knlGS:0000000000000000 [  100.856240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  100.861980] CR2: 0000209000fe1000 CR3: >000000011b18c000 CR4: 0000000000350ee0 [  100.869106] Call Trace:
>>>> [  100.871555]  <TASK>
>>>> [  100.873655]  ? asm_sysvec_reschedule_ipi+0x12/0x20
>>>> [  100.878449]  CalculateSwathAndDETConfiguration+0x1a3/0x6dd
>>>> [  100.883937]
>>>> dml31_ModeSupportAndSystemConfigurationFull+0x2ce4/0x76da
>>>> [  100.890467]  ? kallsyms_lookup_buildid+0xc8/0x163
>>>> [  100.895173]  ? kallsyms_lookup_buildid+0xc8/0x163
>>>> [  100.899874]  ? __sprint_symbol+0x80/0x135 [  100.903883]  ?
>>>> dm_update_plane_state+0x3f9/0x4d2 [  100.908500]  ?
>>>> symbol_string+0xb7/0xde [  100.912250]  ? number+0x145/0x29b [
>>>> 100.915566]  ? vsnprintf+0x341/0x5ff [  100.919141]  ?
>>>> desc_read_finalized_seq+0x39/0x87 [  100.923755]  ?
>>>> update_load_avg+0x1b9/0x607 [  100.927849]  ?
>>>> compute_mst_dsc_configs_for_state+0x7d/0xd5b
>>>> [  100.933416]  ? fetch_pipe_params+0xa4d/0xd0c [  100.937686]  ?
>>>> dc_fpu_end+0x3d/0xa8 [  100.941175]  dml_get_voltage_level+0x16b/0x180
>>>> [  100.945619]  dcn30_internal_validate_bw+0x10e/0x89b
>>>> [  100.950495]  ? dcn31_validate_bandwidth+0x68/0x1fc
>>>> [  100.955285]  ? resource_build_scaling_params+0x98b/0xb8c
>>>> [  100.960595]  ? dcn31_validate_bandwidth+0x68/0x1fc
>>>> [  100.965384]  dcn31_validate_bandwidth+0x9a/0x1fc
>>>> [  100.970001]  dc_validate_global_state+0x238/0x295
>>>> [  100.974703]  amdgpu_dm_atomic_check+0x9c1/0xbce
>>>> [  100.979235]  ? _printk+0x59/0x73
>>>> [  100.982467]  drm_atomic_check_only+0x403/0x78b [  100.986912]
>>>> drm_mode_atomic_ioctl+0x49b/0x546 [  100.991358]  ?
>>>> drm_ioctl+0x1c1/0x3b3 [  100.994936]  ?
>>>> drm_atomic_set_property+0x92a/0x92a
>>>> [  100.999725]  drm_ioctl_kernel+0xdc/0x149 [  101.003648]
>>>> drm_ioctl+0x27f/0x3b3 [  101.007051]  ?
>>>> drm_atomic_set_property+0x92a/0x92a
>>>> [  101.011842]  amdgpu_drm_ioctl+0x49/0x7d [  101.015679]
>>>> __se_sys_ioctl+0x7c/0xb8 [  101.015685]  do_syscall_64+0x5f/0xb8 [
>>>> 101.015690]  ? __irq_exit_rcu+0x34/0x96
>>>>
>>>> [HOW]
>>>> It calles populate_dml_pipes which uses doubles to initialize.
>>>
>>> calls
>>>
>>> Excuse my ignorance. So using doubles causes a context switch?
>> If we don’t add FPU protection then context switch can happen. DC_FP_START would in-turn call preempt_disable.
>>
>>>> Adding FPU protection avoids context switch and probable loss of vba
>>>> context as there is potential contention while drm debug logs are enabled.
>>>>
>>>> Signed-off-by: CHANDAN VURDIGERE NATARAJ
>>>> <chandan.vurdigerenataraj@amd.com>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>>> b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>>> index 826970f2bd0a..f27262417abe 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>>>> @@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,
>>>>    
>>>>    	BW_VAL_TRACE_COUNT();
>>>>    
>>>> +	DC_FP_START();
>>>>    	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt,
>>>> &vlevel, fast_validate);
>>>> +	DC_FP_END();
>>>>    
>>>>    	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg

Hi Chandan,

This change lgtm, however, you need to rebase this patch with the latest 
code from amd-staging-drm-next... with that change:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

>>>>    	if (pipe_cnt == 0)
> Acked-by: Melissa Wen <mwen@igalia.com>
> 
> In fact, I revisited the code and realized the FPU protection is
> missing for two other dcn30 functions called by dcn31:
> - dcn30_populate_dml_writeback_from_context()
> - dcn30_set_mcif_arb_params()
> 
> I'll send a patch addressing this shortly.
> 
> CC'ing: Siqueira
> 
> Best regards,
> 
> Melissa
>>>
>>>
>>> Kind regards,
>>>
>>> Paul

