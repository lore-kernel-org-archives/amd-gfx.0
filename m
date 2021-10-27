Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D685CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 05:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8762561073
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 05:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8762561073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D3B6E524;
	Wed, 27 Oct 2021 05:21:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6103D6E517
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 05:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC2LeeiOZhHRHPjjxyALf7ODv03zUxc9lUNammytjdt98X8ROjcmYJv8kjNfxrsOE+uLSnpj/Pf9hgYx2691qPZXkwMhevCk8Z1taOsTgJVZuyx7SAjKOMIPc+FnuVzSEeTGiabJmTY+HcarRpSC9b654VpNlgzJEf/7SAOKjhmi7B/YSky2nVcZh72gPMtKmGa/WijKkBSqCf2m3+HX0H3m3zZG10vFNqH7O8Ay6ecOGXplR+4UklZ7wIoibNlD586wdJCLdu5mKKYLiCB+lo69GtjOyPdg77m9ZkyY6bD08xxGYohVjBLFOOry0jzhl2vFwDsWBHNeqPdYk4PbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbDCtLbfu2q0iWyC7QrULyDQwwBIpX2+ZmQ7vQSC3jI=;
 b=SWMrUwmNtkAGxTnFhz+7mqXi5zuGyMU7KWpg97ZEO7J/3iXDQpCOONdBBQaF8AFr0O+onre3vz81M8Ww9vLAbhAQtTQ7/9tMXqMmsFfrKLyKpJOfF0iNnE172HHXECShJlGxFsajKQz7Rn0Ju+w0TWA/r1gxpgs3OFMr4LZcvosVluA3uOycjL+VuS7p9F2L+WHKEtiTzbdIESCIYodgi5nLTH1oxC65VdgH8fYSqB+/E0FjgMbrHQ5cq2lORFNu2rfe3yRkCsiJqlLafA9Wm+mWMFBpPR3YU8Gy29qrNho3SmhkK8rvn346I3yzAP9IhQInI7bhtOIQdGgElwM3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbDCtLbfu2q0iWyC7QrULyDQwwBIpX2+ZmQ7vQSC3jI=;
 b=PRcMMwoGelQ3fhRCp0wuim/yzXyVswJxWWe8uWsWtMhSR7TdSacPPY5hfkruyMXnl+b4wJID9X5wmR6g24dZLJCTrggilTG8l64QqJ8duThies0b8IjzPMEm25Adm6BZxA8IMdyZIAXzgcO31M0J4gIQ9bkA5jCoT1FxYYHpkcw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 05:20:54 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 05:20:54 +0000
Message-ID: <d0ed1ed4-42e8-4c05-f027-7bbb5486909b@amd.com>
Date: Wed, 27 Oct 2021 10:50:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
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
 <04c721d1-0561-fef8-263e-e492499ef77b@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <04c721d1-0561-fef8-263e-e492499ef77b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 05:20:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 140677a3-adaf-4322-307e-08d999098c4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4780BE6248FE0008568A910097859@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0BuW4OiSrfu5T3IFznPsHkwtikiwEZeRatOUIiuy0mm+hBSjxc/JiqFs0K6PMAOehLVjKXsFhW8APCNYmF9dBPiEySL96oXjbfB6W8pAQhemd9TaQqnrXyci7dlynfAbmcihtT2sJv13/Ugh/UFc2YygfGEIrwyFtG5BRcTjB/7vYqtBXiTPdgt4AQpyijPJKSMMngJXYbagKZTvQLzBOO9sAA1jopZb86u1uJFhDQJ+IErBBHtYsaCkhkaHNdoiGucE08hPBBlt4q943AdWLFbCmUTUupmgIu1yrprnN+BMefbQc337ubqcZqoQHbgb1zBfPOY+YIOgvVA+vz0EwoB2Qd0+0KsUYwrtHiIufMVvDhAI+kpV7uU/dVtO2kCflOEaabrWMdzQgNApTpIt3TVUKmo3HoewBuPDHpGxxyfP9trmkOjsGNmipKIBbOww8+Zn+UWyevEF6iIWAbCdzRZXypALFuWuUoPoMxLrufGr/VNVbusO2mqFyURRXzAx1UjVnO9htzXSh3fNwJuZdPl5Ou8cj0QW+ktGAA0+mKR+k+N3wniv36djaXa1Yxx20StGW1Pe+1di+Qwjq1Cw3BkGvkgkpreBSWkqVxrQP6V0mqroedcgE4X4oPDExzf/FYl6G+BJThe+imuFGCpbpi9HnyNsNB0O1gV8tqyBmza6yzRiSsCJnc/Z+0pUi28XeDrUvsPel5aLnQ2bWYMVYvpm4iM62jldLy/J3beFhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(66946007)(316002)(54906003)(2616005)(66556008)(31686004)(83380400001)(4326008)(110136005)(8676002)(4001150100001)(2906002)(66476007)(30864003)(38100700002)(8936002)(31696002)(186003)(16576012)(956004)(86362001)(5660300002)(36756003)(26005)(6666004)(6486002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHBCTzkzbjl6YUd3bUppMGlDT0Y5ejI5QXVkN1E1Wkg5OTdPNTdwRDNJSUxN?=
 =?utf-8?B?WmsrTmhQckUyUGwrTXd0dmU1WVRKMWhSbUorcUF2WElvbWZZellUenVrQ01F?=
 =?utf-8?B?R3pOSzhJZG9sNVZpbHpFOEJ2L0dJZUhPaXI4ZGtiOSs1eUNPUENaa3BISXk1?=
 =?utf-8?B?Wks2a2dxS0JBNFFJRjVPa3RBRjdEdXNOL1Y0dTY5UDlQcHljSWRiODdOR2NK?=
 =?utf-8?B?TURVNHpuKzZrU2NzNlEvSm4rNGYvS2dzSGJTcDZyRjFUOUVkWXJJQTVodHlS?=
 =?utf-8?B?UHhEbnFiL0RCRWhNSXpzaGxRZ0RZMzhFcmZ0dTVpRWMzRW1Sb2h6Z3A1SU93?=
 =?utf-8?B?L2djUHgzVm1iSlhFT2UvOTZ5dHoyNU9Jc3FobFdLQUpaQzlIbXduU0JZVnho?=
 =?utf-8?B?REJiOTZvSGt1L1FiakVSN3dUY1ppWS9vKzgrQ3Vmd2d6OCs1MVNmVGRxRmxl?=
 =?utf-8?B?MjV0WnMrR2lidzFWQXFUZlJWOGoyc1NIUkUrbksyTFZSN1RPRWpMNk5lcjM3?=
 =?utf-8?B?Qk9GQXcyWnd1enBtbUlwZlFvb25lbkJENFRhUnpDN1BGRmhnYWVwSUI3MTd5?=
 =?utf-8?B?cW0wdkY5SzZmM3VKOGYzNWVqYU50eWk3Zjl1akQ4RGhKTW5ONzBOL2xjQlVp?=
 =?utf-8?B?bCtKdEdxZFFXN0FzQlppS2FJZEozVHgyTHRJWHJrTzhGT1pkL0M4VUppdWM1?=
 =?utf-8?B?WmVWeFZneFU3MkVSNlRSQzZrZWwxekZxVUQxUTlGRzd1bWtPZVhpcnlrWHAw?=
 =?utf-8?B?QjBUbjhFaTQ1M3krejdsei9FcnRnSHdOYlh3aTV0VUJEOWQ5L2ZuUmRrN2FH?=
 =?utf-8?B?TUYyNUJtMGZTSnprYklLTnNldlJ5eWljVU04UUpxY0tsbG85QXNlaEZqSFV1?=
 =?utf-8?B?eG5qMjY3Vk04dEZsT0dHeVZBak5RRHhZM2dDUDlwYkxwSE8xWVUrSC9ERWJI?=
 =?utf-8?B?V0wwcGdvNlJSTW9aeXIvcW91L0tCYks2NUZxNTFHY2ViYW9yd1FtVnJjSmQr?=
 =?utf-8?B?OVpab25pWS9UWDd5SXVuRmtBSWloQkNqYUVmVmc4OGhkc2xxU0NyWER5SWFh?=
 =?utf-8?B?Zlgxcy9QcWZLd3l6SWJZelF3WFd5bitxWU5xZmpqTGowWkZDc296MmVBMjJy?=
 =?utf-8?B?QVlQVFpmb3VGSjRKSWFaZXhmYUY4OVpXWXlXLzBxNVdRYnJEOVo2a0NPbGdp?=
 =?utf-8?B?eUtDT0JxcXQraEpSaXZQZnRraUx3RGRrWlV3VU41S3lTYjlEWElqN0N4NmNk?=
 =?utf-8?B?WllDR2xkd3JsWngrbElBalg3UXNyN3YxelZreDdock9kR1lWZXllcU43dGMz?=
 =?utf-8?B?U3MyZHZtbVZNYzQvdEZxNVNaQ1N3TnhBOHBhTmUvZGRSNVY4Mm5SQXpINWw1?=
 =?utf-8?B?S2Q4ZDZRVkd2a1J2N3pFb3ltb0NmZDhaQXhEdm1XZTloaXl1VHNvdG9nRm9z?=
 =?utf-8?B?Z1pjS1pwbmJVSWQ1RGhkNjhleWdoQmVmbkFWWDRpcWlKYUV0aXo5VTRwUGtV?=
 =?utf-8?B?UmR4UlhQVXlDSExZM01mMHBYK0NDdnY1U2pEdzExaVdNbi9OTVloMDBOZWk4?=
 =?utf-8?B?WURMU0J5NmdpcXdzSDEvUWRrQVVld2FhL091R0djNGwzZUZjcENzdXFYdTNK?=
 =?utf-8?B?VlV5OTBsYlk0UE1LUUY1T0U2ejhub085eFpESEJIZ1BvK25Pd2Rtc3dJL2Uy?=
 =?utf-8?B?eGl4ejczdW5RYmtZTmdKZFJOMnl5K3RlNHFaaWJFaG00dHJYSDBZSzBEUHhW?=
 =?utf-8?B?eWpiWDBtb21lSUtxNDI4ZGJ4WlRMa3UwK1FLWkY3V1UrV0JIRHVIZTdXQjlq?=
 =?utf-8?B?MjZ2V0ZVNytmYkhjaUpMYTlGUDdtUGhYSmJvdTZqS0owVHJrb3g5bUh4bGhi?=
 =?utf-8?B?U3ZjL2xGQ2U5bU1oMXVjMmdQZmtIRmxpS2N6VG5IazNnUEFpWVpzSW5mSlVa?=
 =?utf-8?B?b015cG9NVW1GbXBtNi9KeHhHcXQ2SGJ0dllGRlJzR3JycE9BYmNhUkM3VVRz?=
 =?utf-8?B?SHpTZExrVytHRkh3SENCN0duM0p1VmkzNXJseGlHVWFIVGlzRjVwRkx4VVBZ?=
 =?utf-8?B?NVdnSEJEbG81UXVKWmE4dzRPTklBRW13ZllBY3JPaEZUMjZDdFZ5ZlpQRHYr?=
 =?utf-8?Q?nmw0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140677a3-adaf-4322-307e-08d999098c4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 05:20:54.1750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wNd6BIlsPbe8t392duiwDdk1QMhfOCtaSj1gaQLu6QwzgmPIg1qo9GJufFm4cQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
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



On 10/27/2021 3:30 AM, Luben Tuikov wrote:
> On 2021-10-26 17:26, Alex Deucher wrote:
>> On Tue, Oct 19, 2021 at 9:54 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>> It again fails with the same message!
>>> But this time it is different!
>>> Here's why:
>>>
>>> openat(AT_FDCWD, "/sys/class/drm/card0/device/pp_dpm_fclk", O_RDONLY) = 3
>>> read(3, "0: 571Mhz \n1: 1274Mhz *\n2: 1221M"..., 8191) = 36
>>> read(3, "", 8191)                       = 0
>>> close(3)                                = 0
>>> write(2, "python3: /home/ltuikov/proj/amd/"..., 220python3: /home/ltuikov/proj/amd/rocm_smi_lib/src/rocm_smi.cc:913: rsmi_status_t get_frequencies(amd::smi::DevInfoTypes, uint32_t, rsmi_frequencies_t*, uint32_t*): Assertion `f->frequency[i-1] <= f->frequency[i]' failed.
>>> ) = 220
>>> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f531f9bc000
>>> rt_sigprocmask(SIG_UNBLOCK, [ABRT], NULL, 8) = 0
>>> rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) = 0
>>> getpid()                                = 37861
>>> gettid()                                = 37861
>>> tgkill(37861, 37861, SIGABRT)           = 0
>>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>>> --- SIGABRT {si_signo=SIGABRT, si_code=SI_TKILL, si_pid=37861, si_uid=1000} ---
>>> +++ killed by SIGABRT (core dumped) +++
>>> Aborted (core dumped)
>>> $cat /sys/class/drm/card0/device/pp_dpm_fclk
>>> 0: 571Mhz
>>> 1: 1274Mhz *
>>> 2: 1221Mhz
>>> $_
>>>
>>> Why is the mid frequency larger than the last?
>>> Why does get_frequencies() insists that they be ordered when they're not? (Does the tool need fixing or the kernel?)
>>>
>>> The current patchset doesn't report 0, and doesn't report any current if 0 would've been reported as current. But anything else is reported as it would've been reported before the patch. And I tested it with vanilla amd-staging-drm-next--same thing.
>>>
>> Seems to crash both ways.  I'd rather either:
>> 1. Remove the * when the clock is outside of the min and max ranges
>> or
>> 2. Clamp the clock to the max or min if it's above or below.
>>
>> And then fix the tools accordingly.  Those seem like the choices of
>> least surprise considering the interface is supposed to show the
>> current and available DPM levels.
> 
> So, if we get a case such as the one above, we remove the whole line at 1:, not just the asterisk, right? (for option 1 above).
> The rocm-smi lib would fail if they're out of order, so only removing the * char would still confuse the tool.
> 
> What does it mean when the current frequency (line 1:) is above the "max" (line 2:) as shown in my output above?
> 
> Do we perhaps want to sort them and report current still, and swap lines 1 and 2?
> 
> Or should we simply remove the ordering requirement in rocm-smi lib?
> 
These nodes help to find the current state of ASIC. Clamping the values 
will just erase questions like these and possible improvements/fixes.

For ex: if the situation above is a case of OD (this is only example, 
don't know what is really the case above) that goes beyond regular DPM 
min/max levels, then we could add + as improvement.

IMO, the node should reflect the current state of ASIC and masking the 
values shouldn't be done. Other cases could be 0 or FW handshake 
failures where * itself will be missing.

Thanks,
Lijo

> Regards,
> Luben
> 
>>
>> Alex
>>
>>
>>> Regards,
>>> Luben
>>>
>>>
>>> On 2021-10-19 09:25, Russell, Kent wrote:
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> It was the rocm-smi -c flag. Maybe some work was done to make it more robust, that would be nice. But the -c flag is supposed to show the current frequency for each clock type. -g would do the same, but just for SCLK.
>>>
>>>
>>>
>>> Kent
>>>
>>>
>>>
>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>> Sent: Tuesday, October 19, 2021 12:27 AM
>>> To: Russell, Kent <Kent.Russell@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> Kent,
>>>
>>> What is the command which fails?
>>> I can try to duplicate it here.
>>>
>>> So far, things I've tried, I cannot make rocm-smi fail. Command arguments?
>>>
>>> Regards,
>>> Luben
>>>
>>> On 2021-10-18 21:06, Russell, Kent wrote:
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> The * is required for the rocm-smi’s functionality for showing what the current clocks are. We had a bug before where the * was removed, then the SMI died fantastically. Work could be done to try to handle that type of situation, but the SMI has a “show current clocks” and uses the * to determine which one is active
>>>
>>>
>>>
>>> Kent
>>>
>>>
>>>
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Russell, Kent
>>> Sent: Monday, October 18, 2021 9:05 PM
>>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
>>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> +Harish, rocm-smi falls under his purview now.
>>>
>>>
>>>
>>> Kent
>>>
>>>
>>>
>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>> Sent: Monday, October 18, 2021 4:30 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org; Russell, Kent <Kent.Russell@amd.com>
>>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> I think Kent is already seen these patches as he did comment on 1/5 patch.
>>>
>>> The v3 version of the patch, posted last week, removes the asterisk to report the lowest frequency as the current frequency, when the current frequency is 0, i.e. when the block is in low power state. Does the tool rely on the asterisk? If this information is necessary could it not use amdgpu_pm_info?
>>>
>>> Regards,
>>> Luben
>>>
>>> On 2021-10-18 16:19, Deucher, Alexander wrote:
>>>
>>> [Public]
>>>
>>>
>>>
>>> We the current behavior (0 for clock) already crashes the tool, so I don't think we can really make things worse.
>>>
>>>
>>>
>>> Alex
>>>
>>>
>>>
>>> ________________________________
>>>
>>> From: Quan, Evan <Evan.Quan@amd.com>
>>> Sent: Thursday, October 14, 2021 10:25 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Russell, Kent <Kent.Russell@amd.com>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> +Kent who maintains the Rocm tool
>>>
>>>
>>>
>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
>>> Sent: Thursday, October 14, 2021 1:07 AM
>>> To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> Or maybe just a list without default hint, i.e. no asterisk?
>>>
>>>
>>> I think this is also fine meaning we are having trouble in determining the current frequency or DPM level. Evan/Alex? Don't know if this will crash the tools.
>>>
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>> ________________________________
>>>
>>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>>> Sent: Wednesday, October 13, 2021 9:52:09 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
>>>
>>>
>>>
>>> On 2021-10-13 00:14, Lazar, Lijo wrote:
>>>> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
>>>>> Some ASIC support low-power functionality for the whole ASIC or just
>>>>> an IP block. When in such low-power mode, some sysfs interfaces would
>>>>> report a frequency of 0, e.g.,
>>>>>
>>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>>>> 0: 500Mhz
>>>>> 1: 0Mhz *
>>>>> 2: 2200Mhz
>>>>> $_
>>>>>
>>>>> An operating frequency of 0 MHz doesn't make sense, and this interface
>>>>> is designed to report only operating clock frequencies, i.e. non-zero,
>>>>> and possibly the current one.
>>>>>
>>>>> When in this low-power state, round to the smallest
>>>>> operating frequency, for this interface, as follows,
>>>>>
>>>> Would rather avoid this -
>>>>
>>>> 1) It is manipulating FW reported value. If at all there is an uncaught
>>>> issue in FW reporting of frequency values, that is masked here.
>>>> 2) Otherwise, if 0MHz is described as GFX power gated case, this
>>>> provides a convenient interface to check if GFX is power gated.
>>>>
>>>> If seeing a '0' is not pleasing, consider changing to something like
>>>>         "NA" - not available (frequency cannot be fetched at the moment).
>>> There's a ROCm tool which literally asserts if the values are not ordered in increasing order. Now since 0 < 550, but 0 is listed as the second entry, the tool simply asserts and crashes.
>>>
>>> It is not clear what you'd rather see here:
>>>
>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>> 0: 550Mhz
>>> 1: N/A *
>>> 2: 2200MHz
>>> $_
>>>
>>> Is this what you want to see? (That'll crash other tools which expect %uMhz.)
>>>
>>> Or maybe just a list without default hint, i.e. no asterisk?
>>>
>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>> 0: 550Mhz
>>> 1: 2200MHz
>>> $_
>>>
>>> What should the output be?
>>>
>>> We want to avoid showing 0, but still show numbers.
>>>
>>> Regards,
>>> Luben
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>>>>> 0: 500Mhz *
>>>>> 1: 2200Mhz
>>>>> $_
>>>>>
>>>>> Luben Tuikov (5):
>>>>>     drm/amd/pm: Slight function rename
>>>>>     drm/amd/pm: Rename cur_value to curr_value
>>>>>     drm/amd/pm: Rename freq_values --> freq_value
>>>>>     dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>>>>>     dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
>>>>>
>>>>>    .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>>>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>>>>>    2 files changed, 86 insertions(+), 47 deletions(-)
>>>>>
>>>
>>>
>>>
>>>
>>>
> 
