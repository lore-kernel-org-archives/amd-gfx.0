Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49243C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 22:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24E06109D
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 22:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F24E06109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0EF89F8E;
	Tue, 26 Oct 2021 22:00:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB4A89F8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 22:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6cqSlRU+s+eWj4BCoU4tKZvh/jOXTlmVU2/2xlG946vMR5qE6VNIVB+Ip0sxVChZShiL9lGnnIu57CiV/wRNeo/s7i2+4BaY/jBwYvoIX3+C+6e1PpnsqOB2/UQ2HH2/iYrtps0H2mBD8QhKzr7kbIagmDU4hO7+IUV17IEI/sipicimUlgOlRbbyIkVA1ieYxS1gVdTNpPgtyLeJ6fBAmiTJsYiOMtOJ8HSD0NA4qcZW1ArtabADwswE9S+7P8EAm2KBRU+lfSgNJwQvpl0Jf/4b0p6B6AY5AW0hnFwOOT8TOFmKYbb0RAZjNpF/dToffJhuZI+q8RoJ1t1C1iGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzMf9UPj2ASOa1T1AKneQaReDa7/bFKracbb4V+UNZM=;
 b=RR0NgvPkW89qnXJKItZMrMIT/JmS/sk3HI2D255+MLZEgpsBgLNhIVIwG3dEtY/Vap8cf8ZSpfbeXB5szPKc96u0BZZrrcomB4vrVcXK9eAeZDQInAUzd1jPj064M0ETN+OGLny9VUOhbAjRLFthqqHaHWF+v5zYeeBc+nDMRhy+ORKKReZKv1rrfueoYQfU7oNwS4HqoIW/CF5aBULCwV9K4MHDu62GfZmM79ugPnKUYdb8S2wrSiSWc3RKHQWynJDtdUJ0ErCWDyJhyO+XNKr2YxASd+olDWQPJmJyue410c7UkOvrDwhmSQOWguZZdCTBsM1jgRYpO2Rzl65oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzMf9UPj2ASOa1T1AKneQaReDa7/bFKracbb4V+UNZM=;
 b=Fr7fizw9KBucGsxThxFZlObYp+zp/Mr6ImNLo5N/FnJDf7a1Ly18jNMNkKN0zpmVrb088aCFiylIYMcmAw/Hh5Do4Mli1TVzl9LPLmrPPZTfNvmUTUJ5n50IBg+C1g4eKe7ZoRRtR5cTWf7ZfPyST98SsWieZemufLedse7q7Yw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2796.namprd12.prod.outlook.com (2603:10b6:5:50::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 22:00:28 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 22:00:28 +0000
Message-ID: <04c721d1-0561-fef8-263e-e492499ef77b@amd.com>
Date: Tue, 26 Oct 2021 18:00:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <091c6805-a72c-a286-f7fb-9d5d5da344d3@amd.com>
 <DM6PR12MB3324CDCA68D04483A57C150985BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <DM6PR12MB3324C490C0CF191F6F34602C85BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <831e76f9-4fad-da9f-7baf-1e0dc92a378a@amd.com>
 <DM6PR12MB3324ECC96ADE558E587AAFF085BD9@DM6PR12MB3324.namprd12.prod.outlook.com>
 <a0939873-8599-c47c-15ec-cfb5018edf57@amd.com>
 <CADnq5_O2o9e3FaRhdU17jbSwSjNt-czdQBnFY-5MSOBNR-gXPg@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_O2o9e3FaRhdU17jbSwSjNt-czdQBnFY-5MSOBNR-gXPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.36.222] (165.204.84.11) by
 YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 22:00:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a23eaede-5df4-40ec-2da9-08d998cc0544
X-MS-TrafficTypeDiagnostic: DM6PR12MB2796:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27969A227FC391B8D429155899849@DM6PR12MB2796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+kH7ko5jsxy83YdJCJ09IjnjjBeHssTPVA9Kr6qgYklVRyYJ/ooEC6HcHIFB5hA3KS3EcwVLeKNCbiWqfLQ5Wym/aXtH4kpkUSEnl91FDt4ZPP1pY2nNYal/ezc8MQLyQXI+YZ8fmyrp5v1s3asn4EsEGNIxzn9Y9iQ9WUWSTYOrd9eG/zr5Xis7uTDEtcaVlvB4o68EE8vIexPSxgmSDMQbCoxPr3cXM8RES7f/Kmm80B2vqvD9vbhLxIuE0u3+cadcJXl+s2TDNaYdZRIOA9rfwGwltxaYD1kpo0KcE8g1sRqr/KKjgGlwNjkp/5VhS4WvIca6PJGgerrAVp9e/nL8e8WnUGeh7Lx6kr2D62VQZLRN4OrdCFkFCd4ondwyIzdd5/goXSqoqBAwgHCctd3xcY0I7NmdGrO71aclcGLYpWu1glOkBtHFOfRJJGMxvuxonnd25YOhY9+sKa0ZjOlmV+fhLxBQf0Eg/F7XkiInj9TbqaHdOf0/g1J+ymfMkFuz6PZ6KgDcRVaJWky1ZoMtECo8x7EduLHEC1qTT7hfl1cweYJMmnQxtGTO/gqF/BjDxexOTVrQa/C3GlxlsaiHWwHBEa2EGd3EbJZJ+JmhyeWglGL1A9wA3q/K4xxkESzqsDEJZrEFYpxPLp25X8svEO36FCHrY9hPWWqPbaYMjgeGRYbtMWkhtWfbCAgJ18IXAQOeebnzvGbrZT/lKAyJnwJ5JcuJYgQSr5jLZ3A3Ky8SaJOrulTY1arAFgF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66476007)(53546011)(186003)(4001150100001)(86362001)(36756003)(44832011)(38100700002)(26005)(66556008)(5660300002)(2616005)(16576012)(6486002)(8676002)(31696002)(956004)(8936002)(2906002)(508600001)(31686004)(54906003)(4326008)(83380400001)(316002)(6916009)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R215NE1OTlhTQkJtQnkxRW1OK2wxbS9IY1JLT1VOK3RNOG5WRFRuRnhHVGtm?=
 =?utf-8?B?V1FrTCt1WEFRQzFpUm1MbHlBT21ORTRIOE42S2tHeGc3UXhvaVA2ZHhGNWVr?=
 =?utf-8?B?MEVNT0FTdUVVbHBwY3NTNnJ2bzFxSEJ0djJnaVAzSVAyaUZnYTZJdG5ObWpn?=
 =?utf-8?B?S1B1QjVMbEpJUjF2ank3ZjdvbXhKMFRpNUZFSnVFZS9xRjlCN3FVZnZiZUE3?=
 =?utf-8?B?NXZmVlh1YkU3K3YzanAzZ094aXlRMlYzYmIvSG1mUE1NajNGVnVjVWUzUHJF?=
 =?utf-8?B?L05ZMzk1SkdkOEN2L3B1TTBPY3NzcDFpdW1RVGo0aElBSTdZVksyTm9sUG9H?=
 =?utf-8?B?MUVXdjFhSkh5NVNyM0k1ZUdDaHkwTlNLdDdhVUNOMGhHZkJ1bGJjWmZnVzdm?=
 =?utf-8?B?VzdPS2krQ3d2UmtKS2ErTG9BZG5URjlocnl0U3JXQkszVjNsSmFEMFdRVUxp?=
 =?utf-8?B?RGFaY1NGQ3Rsa2MwUjVIVVc0WUt5Mkg0aDlXY2hFVnhpUXFQdWR0TnI2M012?=
 =?utf-8?B?OEZZbkdxbWU3NllkWGVRQTJ6b1JMamJIR2FCK2M3ekVVZWF0bitlT1ZQL2hT?=
 =?utf-8?B?L243MTlPR2lOeHlWOUZ4SFcvdFEzL2hnK1V2REtNWjZWVEQrY1AwTzFTK0Uv?=
 =?utf-8?B?LzFFRno3ZEVObDJsUEZyeFdBRXB3OUE4bUc2TStHVVVzUzk1cjlEL0s1SzRs?=
 =?utf-8?B?eDE4Mk1hSUdKSmM0djZkd3pLaGRTb3VvQzhqL0hJOEZLZFNTcHEzTCt2YzBV?=
 =?utf-8?B?NkRPNE9BcW94T1NUWjlkZFVpUk5XRlpmcGRwN2l6UGZ1YXgxcnBOczdWeFVC?=
 =?utf-8?B?NkhjVVFOQk5lTG1wUWJSMWNXWVYvSUgyejF4emJid3pzWTk2cm9PbXJDek9n?=
 =?utf-8?B?dVR5ajkzMnUyQkp5SVNzdkk2MHZVckpXb2dIL0lGTkRvWU5OZ3cxL3p1V2lt?=
 =?utf-8?B?aGNtODZ5M1NQUmVSQm4vZTlyc2d2TGNYek80bVFrNzZjcElQbUJIWXFTbEgv?=
 =?utf-8?B?dTZnUDhxV3lBb0IyRWY0U3pLTTczRDVheWVlbEpHbFFxVjlIR1BlclMvZ3JW?=
 =?utf-8?B?ZnFjSlFwQUJPNEtLdTRJS2dtczJ4NkFGSm1OeDdsQ2xHTGxvR2p6WVk5NXZG?=
 =?utf-8?B?aXZCWklLZ0cvSGN3SXhEZjhzZDdRbmdtaDBhTlEvOUo3eTJKVlpHMnlkOU5K?=
 =?utf-8?B?UGxNeTVISHVqZm9ZOVJ6c05GSkJ0VEFzeThVeVNCWTNYRHNNQ0crZkV4WnFH?=
 =?utf-8?B?dEJjUHVHTk0xZVZaQ3prdWtUcHhPM0k1NzhDakM0cHREb0o3dW1hMnJTY0FZ?=
 =?utf-8?B?QnM4K1lBSXpxMzBWME0vS0ZDVVBOaGJuUmw2Z1MrTUVvMlQ3UUV2dlFYNm1W?=
 =?utf-8?B?Z1BqT3JvNTIycnRZMDl6NnVVdktydHdsdTh5MmlDQm9wbnlFY2F2M0RIUWFa?=
 =?utf-8?B?aVkyRUhXU01PV2QwTmFYVmFDVyt5Rmd5YjRVakFvT2xyZ2pJR1lFUDZPUmZ1?=
 =?utf-8?B?ZTR6dzRRamthSlBmQUNnSWNHU090QXIrcDNROG1xMFFiYmhER3pScU9SaCtH?=
 =?utf-8?B?ak1TbHN2My9Iak1teXVsZ2RwZTFpL3BSci9HaXE1NnI1SmF0eGNTZy9yVjNo?=
 =?utf-8?B?a0ppRXhYL0ttSlZoVU9PcmM5S0ZGTGZGS0tFNTZOejcxaXJBbmFOVWt3c3lp?=
 =?utf-8?B?TlNBTDFCTnYrZjFSR2pPdHBzU2o0aHM3c1h0aFlSRk1nUjZEVTVibC9pQ1Uw?=
 =?utf-8?B?WnFGR2h5VW9YR1hmZnpBdWhMYVMxaC9xak5sbisxWGg0SmU4Uk9lU1lnK3Ar?=
 =?utf-8?B?emlMbmF3aFhTU2xIazJBMXNNSHpnZGVVUldlTXhyNVJMVEtQWlZhY3RJL0x5?=
 =?utf-8?B?N2FObHZaL2o1ZTBYWXo0VVdzVlA5Tnd0aVR0M2JKZVUxWURlRUxXWXdFR2Nw?=
 =?utf-8?B?a2xySVdvODQ2Tm9JTWVoait0cmFoTTd1SHhRK3ZCa0pwL2F1UXlJNzlZN3JZ?=
 =?utf-8?B?V0NQNkhMMDNvcDVhcU02aTZ6SEwrWUp4RlRpVHovOXNFOG1nNmt6VzFiMXhp?=
 =?utf-8?B?UjFrT0hrbjUzbEJiTkxyZUs0MnN4MnBhUVoxSjBmemZaTzBnK2FqQnBjVGtK?=
 =?utf-8?Q?n0hs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23eaede-5df4-40ec-2da9-08d998cc0544
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 22:00:28.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDEHYikfFE2ENZtOWj4Y7+VPPkJN0+CDPvEc4wpoQNh+Qqc09koIAHF1Dt4efhdP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2796
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

On 2021-10-26 17:26, Alex Deucher wrote:
> On Tue, Oct 19, 2021 at 9:54 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> It again fails with the same message!
>> But this time it is different!
>> Here's why:
>>
>> openat(AT_FDCWD, "/sys/class/drm/card0/device/pp_dpm_fclk", O_RDONLY) = 3
>> read(3, "0: 571Mhz \n1: 1274Mhz *\n2: 1221M"..., 8191) = 36
>> read(3, "", 8191)                       = 0
>> close(3)                                = 0
>> write(2, "python3: /home/ltuikov/proj/amd/"..., 220python3: /home/ltuikov/proj/amd/rocm_smi_lib/src/rocm_smi.cc:913: rsmi_status_t get_frequencies(amd::smi::DevInfoTypes, uint32_t, rsmi_frequencies_t*, uint32_t*): Assertion `f->frequency[i-1] <= f->frequency[i]' failed.
>> ) = 220
>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f531f9bc000
>> rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
>> getpid()                                = 37861
>> gettid()                                = 37861
>> tgkill(37861, 37861, SIGABRT)           = 0
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=37861, si_uid=1000} ---
>> +++ killed by SIGABRT (core dumped) +++
>> Aborted (core dumped)
>> $cat /sys/class/drm/card0/device/pp_dpm_fclk
>> 0: 571Mhz
>> 1: 1274Mhz *
>> 2: 1221Mhz
>> $_
>>
>> Why is the mid frequency larger than the last?
>> Why does get_frequencies() insists that they be ordered when they're not? (Does the tool need fixing or the kernel?)
>>
>> The current patchset doesn't report 0, and doesn't report any current if 0 would've been reported as current. But anything else is reported as it would've been reported before the patch. And I tested it with vanilla amd-staging-drm-next--same thing.
>>
> Seems to crash both ways.  I'd rather either:
> 1. Remove the * when the clock is outside of the min and max ranges
> or
> 2. Clamp the clock to the max or min if it's above or below.
>
> And then fix the tools accordingly.  Those seem like the choices of
> least surprise considering the interface is supposed to show the
> current and available DPM levels.

So, if we get a case such as the one above, we remove the whole line at 1:, not just the asterisk, right? (for option 1 above).
The rocm-smi lib would fail if they're out of order, so only removing the * char would still confuse the tool.

What does it mean when the current frequency (line 1:) is above the "max" (line 2:) as shown in my output above?

Do we perhaps want to sort them and report current still, and swap lines 1 and 2?

Or should we simply remove the ordering requirement in rocm-smi lib?

Regards,
Luben

>
> Alex
>
>
>> Regards,
>> Luben
>>
>>
>> On 2021-10-19 09:25, Russell, Kent wrote:
>>
>> [AMD Official Use Only]
>>
>>
>>
>> It was the rocm-smi -c flag. Maybe some work was done to make it more robust, that would be nice. But the -c flag is supposed to show the current frequency for each clock type. -g would do the same, but just for SCLK.
>>
>>
>>
>> Kent
>>
>>
>>
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Tuesday, October 19, 2021 12:27 AM
>> To: Russell, Kent <Kent.Russell@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> Kent,
>>
>> What is the command which fails?
>> I can try to duplicate it here.
>>
>> So far, things I've tried, I cannot make rocm-smi fail. Command arguments?
>>
>> Regards,
>> Luben
>>
>> On 2021-10-18 21:06, Russell, Kent wrote:
>>
>> [AMD Official Use Only]
>>
>>
>>
>> The * is required for the rocm-smi’s functionality for showing what the current clocks are. We had a bug before where the * was removed, then the SMI died fantastically. Work could be done to try to handle that type of situation, but the SMI has a “show current clocks” and uses the * to determine which one is active
>>
>>
>>
>> Kent
>>
>>
>>
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell, Kent
>> Sent: Monday, October 18, 2021 9:05 PM
>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> [AMD Official Use Only]
>>
>>
>>
>> +Harish, rocm-smi falls under his purview now.
>>
>>
>>
>> Kent
>>
>>
>>
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Monday, October 18, 2021 4:30 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org; Russell, Kent <Kent.Russell@amd.com>
>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> I think Kent is already seen these patches as he did comment on 1/5 patch.
>>
>> The v3 version of the patch, posted last week, removes the asterisk to report the lowest frequency as the current frequency, when the current frequency is 0, i.e. when the block is in low power state. Does the tool rely on the asterisk? If this information is necessary could it not use amdgpu_pm_info?
>>
>> Regards,
>> Luben
>>
>> On 2021-10-18 16:19, Deucher, Alexander wrote:
>>
>> [Public]
>>
>>
>>
>> We the current behavior (0 for clock) already crashes the tool, so I don't think we can really make things worse.
>>
>>
>>
>> Alex
>>
>>
>>
>> ________________________________
>>
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Thursday, October 14, 2021 10:25 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Russell, Kent <Kent.Russell@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> [AMD Official Use Only]
>>
>>
>>
>> +Kent who maintains the Rocm tool
>>
>>
>>
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
>> Sent: Thursday, October 14, 2021 1:07 AM
>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> [AMD Official Use Only]
>>
>>
>>
>> [AMD Official Use Only]
>>
>>
>>
>>> Or maybe just a list without default hint, i.e. no asterisk?
>>
>>
>> I think this is also fine meaning we are having trouble in determining the current frequency or DPM level. Evan/Alex? Don't know if this will crash the tools.
>>
>>
>>
>> Thanks,
>> Lijo
>>
>> ________________________________
>>
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Wednesday, October 13, 2021 9:52:09 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>
>>
>>
>> On 2021-10-13 00:14, Lazar, Lijo wrote:
>>> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
>>>> Some ASIC support low-power functionality for the whole ASIC or just
>>>> an IP block. When in such low-power mode, some sysfs interfaces would
>>>> report a frequency of 0, e.g.,
>>>>
>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>>> 0: 500Mhz
>>>> 1: 0Mhz *
>>>> 2: 2200Mhz
>>>> $_
>>>>
>>>> An operating frequency of 0 MHz doesn't make sense, and this interface
>>>> is designed to report only operating clock frequencies, i.e. non-zero,
>>>> and possibly the current one.
>>>>
>>>> When in this low-power state, round to the smallest
>>>> operating frequency, for this interface, as follows,
>>>>
>>> Would rather avoid this -
>>>
>>> 1) It is manipulating FW reported value. If at all there is an uncaught
>>> issue in FW reporting of frequency values, that is masked here.
>>> 2) Otherwise, if 0MHz is described as GFX power gated case, this
>>> provides a convenient interface to check if GFX is power gated.
>>>
>>> If seeing a '0' is not pleasing, consider changing to something like
>>>        "NA" - not available (frequency cannot be fetched at the moment).
>> There's a ROCm tool which literally asserts if the values are not ordered in increasing order. Now since 0 < 550, but 0 is listed as the second entry, the tool simply asserts and crashes.
>>
>> It is not clear what you'd rather see here:
>>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 550Mhz
>> 1: N/A *
>> 2: 2200MHz
>> $_
>>
>> Is this what you want to see? (That'll crash other tools which expect %uMhz.)
>>
>> Or maybe just a list without default hint, i.e. no asterisk?
>>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 550Mhz
>> 1: 2200MHz
>> $_
>>
>> What should the output be?
>>
>> We want to avoid showing 0, but still show numbers.
>>
>> Regards,
>> Luben
>>
>>> Thanks,
>>> Lijo
>>>
>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>>> 0: 500Mhz *
>>>> 1: 2200Mhz
>>>> $_
>>>>
>>>> Luben Tuikov (5):
>>>>    drm/amd/pm: Slight function rename
>>>>    drm/amd/pm: Rename cur_value to curr_value
>>>>    drm/amd/pm: Rename freq_values --> freq_value
>>>>    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>>>>    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
>>>>
>>>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>>>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>>>>   2 files changed, 86 insertions(+), 47 deletions(-)
>>>>
>>
>>
>>
>>
>>

