Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE5C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF83861994
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83861994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2086E93F;
	Tue, 30 Mar 2021 16:26:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED576E93D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 16:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgfOrqMiZtJ4LerVsnEPLkN+8BjRfqyX8r945qo0xwOXUisjEFek7GAwbho45+ZSJTjYA+1/rs+/NqvTYu6R9ooDOVsJ5MNu6cP9EnKkXk0IfDi5f1yUpeX9PmHxRWRB8s/otwDmUDQPoF36U5Cz3CULzP2eEUZQcGF9aTvb41vuZXaB2j7+T0kYEN65lt3pVBn1IkWG5pfXvb42F3aeIoqI8F2h13ezF9NTxhQQ4xzbOkKVdFrfWsGK1bUQYJEtL+CHOp9MHvy550lVGnwM/uY3xWt+TzRBkB3xY+MF2E1ViQgQhe3RRcV66U/57VxZ1Plerbl+odxBH3WjqIFF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9UDw21jXD51CQfOadSSTik5a7vSGqMEy0m3XAFy+Sc=;
 b=C387X60gESP1pHJCrApTAY+LkaAiO2XswFB4/1a5ne44ebmmxmCl4dCgZ/9J++Cn1VxOF5PkONMSg7uR80p5yCVr6JaUNhEro/xdJ8VOGEaTmxvIKu6kqF7xcEfKOrJL0Xeo9O/tYJG12dygz5P7QiodBxc2NthVfnC/XO4GtP1PQgmMxY1+bPslLgW69F4XOHdB3H7+VWgsLzjDxe/4Zismcnje/sl0in8jABfiCs93h46cPZCrsIlLuveyKsRNvzaV7WgQ4s+8JCeqw+1aN6i2Pbe3r1O90rdjZmeuV5C1HlCR4OVsP2IegCs/IGg+UvZdqyaXCOSc/H6y1Gsj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9UDw21jXD51CQfOadSSTik5a7vSGqMEy0m3XAFy+Sc=;
 b=p4svA/pmXJbmE8AsOt8QRTXaLqEq4KSZOrBg7l2/CD19VFHyBfd5Sf29Ipv3aZv3pgbJD4B6RzAkPHFkD3yqu59UCoUx6jOVZoVhyFMPP8MlvhTGz9O1+lXquROMofZa6oRrSE2Hing1Y6vuMYKolxBIgI9xX1yaRTw+msVRW/k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 30 Mar
 2021 16:26:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 16:26:27 +0000
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
Date: Tue, 30 Mar 2021 18:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM3PR07CA0098.eurprd07.prod.outlook.com
 (2603:10a6:207:6::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
 (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by
 AM3PR07CA0098.eurprd07.prod.outlook.com (2603:10a6:207:6::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.17 via Frontend Transport; Tue, 30 Mar 2021 16:26:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f61a08da-0373-4484-fa6e-08d8f398917d
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4897A56EA0D3F58030C61E56837D9@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z55w4Wi7S4t1I8i6Ww3mb6aXnjmctK7TZwUKgGHq149PA0SRjE/VIpT2ut+BJxA8YrKXSRHe7RxCvVwzjL8B3T1tEnsdu7h/olpoto6Bm6O5Ci5Em5khGzZ60LHTJcv/aUHIwDEzwS+fi7o5SBFlvS9q7+71qNyGbkhP6VeZPQj+VNc3CL5yvvKzpxU+ZLbqM+Si5HO9/GFMvWpb6/hSpE9FIahj1Rq2sE/DAc/pNkhVtnPItTSNJcDlYh+IXlCjKvQLKeAZpZdT1bD7Ljb41kxUogeuiju5O4squlabBGJVSvHjyLWDk81xsStviitd4hM00cyhkmx03feNAlc9Q0T9hnF8alcgA6NR7hrWoqCDuzR/Ja9CjLnnhtwgulRRv4wVjfsvzvEWWSK+H9YXw635CIiutRNvebUv/vKssBvEG8o7Pup7xCZm2/nOq0U810GAc1yjvsNjyHJiUNrnklSyzrsSUf0TU492LmRFlw33sjYvsswOR9LQDlnYJwta7OJJk/NSo9HcN5afbZvoGqb30l0GkCUVFLMpuckzM70UWJ7IiRivVXPWSm96GwQENaA4jgORwsdrTHaHgXURYRGJ8q7rNjYQx2b/2NPxx406Dbu9wrjtKo1QWjOsqJ1StmYOLhahkql3nfAAbr61o6mdtkt8WlHmESqmT38rZ3mrEQGTtS5ELhJbGjhgefhfRPokRfz9KU8tGtXSU2SCCr+pZEev10Ph0MMrWSJaGWsUQgjIR/XaH4Qgv8ELZ8+FCeO/USZWoVAVaR2qzN7/0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(396003)(366004)(136003)(5660300002)(52116002)(38100700001)(31686004)(33964004)(6486002)(166002)(66574015)(36756003)(83380400001)(31696002)(16526019)(8676002)(2906002)(8936002)(66476007)(66556008)(86362001)(66946007)(2616005)(6666004)(110136005)(45080400002)(478600001)(186003)(4326008)(316002)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3dnUHdkL1Y4eS9sSFBBd1Z4eXhZbFV2VEExNWRtaDg5cFJVcHZieXA2UUhX?=
 =?utf-8?B?VGhoOTJQME9iQVVqRnFMeFdGSWRJU0RvR3BjUTZ0WGtWdk5FcHhGc1N2Q3RJ?=
 =?utf-8?B?cmhEVEEvVFlEY3ZUZUpMa3JSRCtvM25vN3RTS1lTbklOZjhKa2x1UHpsQ0ZQ?=
 =?utf-8?B?aE1hblJVSis2TDV2RnJnME9WV3g2ZkZLY01RWTZJV1d4OWNYWmJ6VEJudGxx?=
 =?utf-8?B?MG1sSlRjSGJEQjhIMC9PcFlnaGd5bUtURzBhQ3NFYVlhVDRUUDVQM1doUXNq?=
 =?utf-8?B?RTZ4dExxWUs2RkkzdHZSbm9XOEs2UlEzamtJZ21uMlhSQW9kNzNZOU9hU21p?=
 =?utf-8?B?TThpbGtCV3FsZVZacTVod1luRG9JdjdubGJGZ3VwMkQvN2xDa24zL2xGUkhx?=
 =?utf-8?B?ZkFmSElPUE1vZDdwMU5LWkZiMUFqUkFVUlkzMWNMVzJwR21oeU9JYkI1L283?=
 =?utf-8?B?N3gwWmF1cEI4RUNQakdJRXJzWittTWJLb3o1Z2N0R1Q3MkxlTkdwcmNJMVA0?=
 =?utf-8?B?Y0k0UnlkV1JxdCt1RGRMaWZHSEI2ZGgvd2grVDZhMUpaV1J6UEd2RnNIME1J?=
 =?utf-8?B?OGw1Mml0WkhKeDIwK0VBK1BZbXY5MmZ4RUZyTW1Edkw3U25rbEwvdkxFTEJj?=
 =?utf-8?B?L1RtZlExY1Z6eVdqcjZoQmtRVm5vWit2Q2I2Z1gwclZkY3pPMjVEQVJVRDd2?=
 =?utf-8?B?UmhUYzA1OHhpV2hpNEpGYjlVZ3JWVXYwZDgyUU5FUGVERERIcFJ5SzVTSEtj?=
 =?utf-8?B?NFVBQVZ4c2MvOUxaV2Rydk5wb1BCU0g3U3JsOGw2OGNWNjJjc2d4UVhyTGxk?=
 =?utf-8?B?L2RNREZzVmdoYmZKa285bXRzR2dVTXo2SDUraG0wMDRDUDFuT3RnbktZL1Ix?=
 =?utf-8?B?N1djclVuZ3hPcWorVUY1NDRvV2VUTFhsT1R1cExUZ0g2NWdJKzRRV2dMWG41?=
 =?utf-8?B?T1lxWGNlT1BlWWVpR1o5djJYWFVPZnpjb0xDVHhlanJmWURMdmE2eDl0Zmdh?=
 =?utf-8?B?bkNJTDAvUERPUjRnTHBkV1k3dGNjZHM2c2NqaUtqNEt4WXpPV0pMVWlMZjFr?=
 =?utf-8?B?SG5uZ3JaMjc5UXNpTHhQZHUrSG9RY1QydkhzMklOYkhhbWVYeWk1VWlISFpY?=
 =?utf-8?B?N1lNMlZPdVhPaEFCbWU5ZnRlb3BkT1N1bE51U2pwRDJQVGdUSTM0TFFBWGho?=
 =?utf-8?B?MXJQbGR2V3QrMGF3L3oxT0ZLOW1ib2E5RlRVUFFaMUM1MHhtdlMxaGxockdO?=
 =?utf-8?B?NUwvSW50WEVYMlBKNSt5OHRCTE84NTdnRTZuUlVxdDFnSU1LVytqRlVTZU8w?=
 =?utf-8?B?SXhPZjErQjBGYk9vaTA0Q3p6QmdkWHJwR2tTTy9CNEw0U0pNWWphWmZYb3R6?=
 =?utf-8?B?SDNrcDZhNm1vRzVtRWtEUHFuaDYwcmE1eHdIakFDdW5aU3BiUlMwdk9qaUtm?=
 =?utf-8?B?V042TExRSSsvTFpVdHM4QXplZjdqaklTWkorT05RcG42djdHQ1oxVVdQajFE?=
 =?utf-8?B?SHV4aHM2Y3ltU0orcFJOTklaZ2dGVnlrWldteWNCb1h1Q2MyODNpTkxqZFFZ?=
 =?utf-8?B?SDR5aTBoanZtMk5lWElmNXZkUXliWnMwcWR6dFZKbVJscG5FUStJTC8yMHFw?=
 =?utf-8?B?N1BIYjV1c004UUVhZ002ZDVGcUlQQkxEak9HQ2FjS09HNkFwTDVEY2RiWGRL?=
 =?utf-8?B?U2ovY2ZxMnllUWlQbTVSNWpxbG9GQnRPRUU1ZHlJMHRNMjQ2VHVlQkNob2ta?=
 =?utf-8?B?bFk0Vzh2RXljZVFXUDFIVE4yR0pRMWVybHh0TVRzSHBiNGhMbzhheFRrU0ND?=
 =?utf-8?B?MUJOZTZjVVB4RlovMUdvUXpNZGQ5d0tCaXJXZkl4em02em1xMjQxeW4zc2g3?=
 =?utf-8?Q?+d7yDaTCGfzOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61a08da-0373-4484-fa6e-08d8f398917d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 16:26:27.8443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/jmPWL09EdF8S7TkXGCHXXsMerDCZT2rIz4XjRrVs66ALHK7qM9zWEC7l4UtpGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
Cc: alexander.deucher@amd.com, benh@kernel.crashing.org,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1492468947=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1492468947==
Content-Type: multipart/alternative;
 boundary="------------0FC637F9C797FDE7BAD5F7B0"
Content-Language: en-US

--------------0FC637F9C797FDE7BAD5F7B0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alberto,

> I think the driver should only support resolutions that are 
> *progressive*, but also at least of *50Hz*.

Why do you think so?, the 24Hz resolution seems to be the native one of 
the display.

Regards,
Christian.

Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
> This is why I'm using interlaced:
>
> $ *xrandr*
> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
> DisplayPort-0 disconnected (normal left inverted right x axis y axis)
> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted right x 
> axis y axis) 16mm x 9mm
>    1920x*1080i*    60.00*+  50.00    59.94
>    1920x1080 *24.00*    23.98
>    1280x*720*      60.00    50.00    59.94
>    1024x768      75.03    70.07    60.00
>    832x624       74.55
>    800x600       72.19    75.00    60.32    56.25
>    720x576       50.00
>    720x576i      50.00
>    720x480       60.00    59.94
>    720x480i      60.00    59.94
>    640x480       75.00    72.81    66.67    60.00    59.94
>    720x400       70.08
> DVI-0 disconnected (normal left inverted right x axis y axis)
>
> I think the driver should only support resolutions that are 
> *progressive*, but also at least of *50Hz*.
>
> On Tue, 30 Mar 2021 at 15:41, Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Mhm, no idea why an interlaced resolution would cause a crash.
>     Maybe some miscalculation in the display code.
>
>     But apart from that if you just connected your PC to a TV I also
>     wouldn't recommend using an interlaced resolution in the first place.
>
>     See those resolutions only exists for backward compatibility with
>     analog hardware.
>
>     I think we would just disable those modes instead of searching for
>     the bug.
>
>     Regards,
>     Christian.
>
>     Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>     I guessed so.
>>
>>     The GPU is a Radeon HD5870, and the screen is an old Telefunken
>>     TV (TLFK22LEDPVR1).
>>
>>     Since my real display got into repair I used this TV meanwhile,
>>     and to my surprise it froze the system.
>>
>>     On Tue, 30 Mar 2021 at 10:15, Christian König
>>     <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>>
>>         Hi Alberto,
>>
>>         well what hardware do you have?
>>
>>         Interlaced resolutions are not used any more on modern
>>         hardware, so they
>>         are not well tested.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>         > The entire desktop hangs after some minutes when using the
>>         module
>>         > "radeon" with an interlaced resolution.
>>         >
>>         > Easier to trigger by playing a video on Firefox, at least
>>         on kwin_x11.
>>         > Wayland didn't exhibit the problem.
>>         >
>>         > Other display drivers, from different computers I have
>>         tried, didn't
>>         > allow those interlaced resolutions all together. It seems
>>         they know
>>         > there will be problems.
>>
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C71c42210b976438bfbb908d8f391bb3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527154536688236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=jfWL5eoMUhK5phoM1Xs6Nv7SLsKCst7wWwq5URYNazk%3D&reserved=0>
>


--------------0FC637F9C797FDE7BAD5F7B0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Alberto,<br>
    <br>
    <blockquote type="cite">I think the driver should only support
      resolutions that are <b>progressive</b>, but also at least of <b>50Hz</b>.</blockquote>
    <br>
    Why do you think so?, the 24Hz resolution seems to be the native one
    of the display.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 30.03.21 um 17:37 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com">
      
      <div dir="ltr">
        <div>This is why I'm using interlaced:<br>
        </div>
        <div><br>
        </div>
        <div>$ <b>xrandr</b><br>
          Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192
          x 8192<br>
          DisplayPort-0 disconnected (normal left inverted right x axis
          y axis)<br>
          HDMI-0 connected primary 1920x1080+0+0 (normal left inverted
          right x axis y axis) 16mm x 9mm<br>
          &nbsp; &nbsp;1920x<b>1080i</b> &nbsp; &nbsp;60.00*+ &nbsp;50.00 &nbsp; &nbsp;59.94 &nbsp;<br>
          &nbsp; &nbsp;1920x1080 &nbsp; &nbsp; <b>24.00</b> &nbsp; &nbsp;23.98 &nbsp;<br>
          &nbsp; &nbsp;1280x<b>720</b> &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;50.00 &nbsp; &nbsp;59.94 &nbsp;<br>
          &nbsp; &nbsp;1024x768 &nbsp; &nbsp; &nbsp;75.03 &nbsp; &nbsp;70.07 &nbsp; &nbsp;60.00 &nbsp;<br>
          &nbsp; &nbsp;832x624 &nbsp; &nbsp; &nbsp; 74.55 &nbsp;<br>
          &nbsp; &nbsp;800x600 &nbsp; &nbsp; &nbsp; 72.19 &nbsp; &nbsp;75.00 &nbsp; &nbsp;60.32 &nbsp; &nbsp;56.25 &nbsp;<br>
          &nbsp; &nbsp;720x576 &nbsp; &nbsp; &nbsp; 50.00 &nbsp;<br>
          &nbsp; &nbsp;720x576i &nbsp; &nbsp; &nbsp;50.00 &nbsp;<br>
          &nbsp; &nbsp;720x480 &nbsp; &nbsp; &nbsp; 60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
          &nbsp; &nbsp;720x480i &nbsp; &nbsp; &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
          &nbsp; &nbsp;640x480 &nbsp; &nbsp; &nbsp; 75.00 &nbsp; &nbsp;72.81 &nbsp; &nbsp;66.67 &nbsp; &nbsp;60.00 &nbsp; &nbsp;59.94 &nbsp;<br>
          &nbsp; &nbsp;720x400 &nbsp; &nbsp; &nbsp; 70.08 &nbsp;<br>
          DVI-0 disconnected (normal left inverted right x axis y axis)</div>
        <div><br>
        </div>
        <div>I think the driver should only support resolutions that are
          <b>progressive</b>, but also at least of <b>50Hz</b>.<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at 15:41,
          Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Mhm, no idea why an interlaced resolution would cause a
            crash. Maybe some miscalculation in the display code.<br>
            <br>
            But apart from that if you just connected your PC to a TV I
            also wouldn't recommend using an interlaced resolution in
            the first place.<br>
            <br>
            See those resolutions only exists for backward compatibility
            with analog hardware.<br>
            <br>
            I think we would just disable those modes instead of
            searching for the bug.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>I guessed so.</div>
                <div><br>
                </div>
                <div>The GPU is a Radeon HD5870, and the screen is an
                  old Telefunken TV (TLFK22LEDPVR1).</div>
                <div><br>
                </div>
                <div>Since my real display got into repair I used this
                  TV meanwhile, and to my surprise it froze the system.<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at
                  10:15, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">Hi Alberto,<br>
                  <br>
                  well what hardware do you have?<br>
                  <br>
                  Interlaced resolutions are not used any more on modern
                  hardware, so they <br>
                  are not well tested.<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:<br>
                  &gt; The entire desktop hangs after some minutes when
                  using the module <br>
                  &gt; &quot;radeon&quot; with an interlaced resolution.<br>
                  &gt;<br>
                  &gt; Easier to trigger by playing a video on Firefox,
                  at least on kwin_x11. <br>
                  &gt; Wayland didn't exhibit the problem.<br>
                  &gt;<br>
                  &gt; Other display drivers, from different computers I
                  have tried, didn't <br>
                  &gt; allow those interlaced resolutions all together.
                  It seems they know <br>
                  &gt; there will be problems.<br>
                  <br>
                </blockquote>
              </div>
              <br>
              <fieldset></fieldset>
              <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C71c42210b976438bfbb908d8f391bb3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527154536688236%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jfWL5eoMUhK5phoM1Xs6Nv7SLsKCst7wWwq5URYNazk%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="gvB1D14vInNTBTFhWQboU8jPfXvuStmwbvwMkaKHSiT+zP3LSG4kwka3qMy349t+CZvELjc8AqO0JT/jfuPX4kNZGYVDmcC2Bw0FjDaj/e/j3ZkpSnZXCw5R0FPi48VWFEuLj7iyp4lbgPA45rnwQ1IpRnY5o2fI3+W0k33V/dU=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------0FC637F9C797FDE7BAD5F7B0--

--===============1492468947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1492468947==--
