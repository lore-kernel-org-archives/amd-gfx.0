Return-Path: <SRS0=lEWV=I5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95988C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41DB9619BC
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Mar 2021 06:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41DB9619BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF9E16E9DF;
	Wed, 31 Mar 2021 06:44:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F076E9DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Mar 2021 06:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QX4MDHZg7yWXNwwhIbpeqOAp8fM5JTmhEXqwfs5N+t3c6kr3BhpbmwQpy3ri8XAP0b77TRo5u1MCwPp7e3LGAqlov77BiKm/NVWgE29qRanLunRtzI1zIb5jRu2pMPMEg0fDXC+VDfjWr190dQHJjuL2pWXILB/NxwcRYEw7KtCFjNNzl6vOYO0Jp5r1q2TRbYhzqRZjeSF5D4iDj2iip6r9NgjnFvTSe+TItSlQtUmrNjgBsv8lshToGv3gRkkN095wM7E0+fEWGA2tnLJMNgMvMQnYiLou4/gc+EvWkzEMAzduaZzl8Ny2qu7ZNkqSTJfm6irqBHS7IOwQUmLFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHUgw9nl4wR1noQusWp0WuChJRzHnLGPXYScNVakRqo=;
 b=gm1siaS5XJmanPdsrCwUwzsjEyZdUCkpMvkXW/YVqHmyg9aBgVW0B8GzwI/G+FZccM+tu2v9p5ZOGq3l4RN2dzHBpvlP2Y39Vn3ttqQ/D4SbhTVjbcBnJvwqx/nJ4cyNZIFWhDbqXygTZT6acpod3GgWx/kob8K1MhrBKBphAUkPkIiv4G4lWVYL+/HvTdCWqU3gUIX6zzcIttNWkpoCnqLLSaB09kwUvs5Qjp1rivsvrekiGUuvVk+pVcLc3mh8tdJFIiVRqxuGFyPTnbNYykBRdVtVLmXtJ4r8TkIfxVjcSYg2j/jir0yIGms00IGyLKx82zMBjheWScmpzqqT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHUgw9nl4wR1noQusWp0WuChJRzHnLGPXYScNVakRqo=;
 b=k4n0O2hnvGKhRQagZ0YoIIVz2p2IRPtPadA05ml/RWF35sez2l5n1n7gwaof8v21/iDXRXhfJCSvXxIt2h7MnrKA2foTOWwyp+z0T+1FWdeEgTccKNoi8xBNMZcz8PSgj/lOHwM+bskUourMw2vxTKKbj0KQUofSGUcAwfPpsZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) by
 MN2PR12MB4342.namprd12.prod.outlook.com (20.180.245.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Wed, 31 Mar 2021 06:44:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 06:44:18 +0000
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
Date: Wed, 31 Mar 2021 08:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:46d6:1b43:479c:c70b]
X-ClientProxiedBy: AM3PR05CA0106.eurprd05.prod.outlook.com
 (2603:10a6:207:1::32) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:46d6:1b43:479c:c70b]
 (2a02:908:1252:fb60:46d6:1b43:479c:c70b) by
 AM3PR05CA0106.eurprd05.prod.outlook.com (2603:10a6:207:1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 06:44:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa5dca1b-d528-4eb4-a91f-08d8f4106840
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43429F36A89ACA9ED7D2813F837C9@MN2PR12MB4342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8GAxO99BwDr+XYl+MrSPRDnB63VlTVTVUCpWR3ThBNlPZygNAZ/GpcKZmFyfZowB3/TzeTkNT3HpfXNrJMbLZ5iMZXzKKoPWcOy/UG4QBRoiUPo7AXvvS/LUw6xmIctc0yW2WuBuiDxtzbBRh63aVvzwxGv0Pz9IC6r9Hr7Js6OrnbFvgsVyudekUTkPzosd78JXUZOOoNoUPD3gKTIXtBJVSowctwH8rOfR0hEKFfnfiQXHeB5Q4sLkyXTSrSsfzgQ2iQCt7SVwnju3OxLHPOpLlRtae/hSXAyim0Ikj494aWXAc4i4KoqmZbreoIaxejlEROfoj3aGRk/4SzSN2lBTEG3bx4ig9p5n36d2HIrEQpRQTGCDgsDwBg2pMW4MQXRK6MaeXwMYvzoSyPShf64Av7aixAGP6vkJHSF0d2WMYmpDgv9fZno1zwiskqrRC/6CNCQaDxQ0Qsj52rH9exlBHXL/6hxEk24LlmNI2mrkKIU/uT8aZiFFXnbTnEdPmVoV3v+mUyq0H61Yr8NzWf96EmwY/3GabhvF9hf1Zqg2qyxfRu7nTh2IQvEo7e2AGqrMEDmY/jaPiFp552A4BJxKOfzJ1vyRQFfmO6lFPO9LJOYOWLvcDU/u0ZK4lsSMlGs6E9w+ZgkJBu9TOUI98Arn57WCSFRynYscRvJXvuxRcVA0b65EWToIKUsHNcYYUsVzVtZrRPhefJyTrdladY1QS2J6rq7MV3UU/GN0KPQJbnGJ0XESXtIJySzxk+EskLmsJvyDs6HQtPrb0lcNiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(5660300002)(186003)(2906002)(86362001)(16526019)(8936002)(52116002)(38100700001)(33964004)(2616005)(66574015)(166002)(31686004)(4326008)(478600001)(966005)(66946007)(45080400002)(31696002)(8676002)(316002)(6916009)(36756003)(83380400001)(66556008)(6486002)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OU92RTg4NVViYXJjVkRDQ0lnRW9kcWFTbDM1aU5RMmxadXVqNGE3ekhjRS9J?=
 =?utf-8?B?OWUwLzdacGpoMXVzRWhkWVZ6R284RzhKdUViZ1RSeUpXVUtmRHd0cVRycWFl?=
 =?utf-8?B?eTRseFI3YnlOMmVSV1FDc0VlditsVjRqMXJEVlUzejJTZDlrYlM4QlZ3YklD?=
 =?utf-8?B?V2hJWVdvSlZOM3JWZW4zZi9CSmFiN3dYbzZVak9RUnh1ems5VmZZWFZUbTVz?=
 =?utf-8?B?ejlZdVEzZ2pjVzkvYjNLeWRscHFROE55aU5RT0lEazJhUmYyaktZalhaOHAy?=
 =?utf-8?B?OFlpaGNaQlBkK3UrbHY5NkNGQnc3NlZQM3U4aEZvYmhoTVJ1MDdYK283b1pR?=
 =?utf-8?B?VmJjLzhMNmhCa1MwMW9rbHhMRVJ5K3ZyUXRRL21EUFhZWTlJM3lzZVJiYW41?=
 =?utf-8?B?Y1dBUFFzZlNaNU1RUDdwUTA0RS9aTnIyQXdWVGJaRHVyVW1FdEl4RE9SZ0w4?=
 =?utf-8?B?eU12c1ptdG9ZNlBrZnFsektWYlJLQWd1SXJXRCthK3p3c1ViU3VISWtUbFVH?=
 =?utf-8?B?Y2l3NHNtMHRxODZTRWwxeGVRMHdOWThUdCtRT2JZZWlXUldpTnBQWlZQRENS?=
 =?utf-8?B?RHJOUjFHTVFWZEhUN1d5TDA5TVBoWllkdXhQSVZxK0xaR3lxNHg1MGdpSy9x?=
 =?utf-8?B?bVlLNEszdmk3ZGtqY3FCZHZleDVLcW80c2NhbTB6ci9ZLzFTcDRLOVFHd2VD?=
 =?utf-8?B?V1R6K3BZOERPcmJjK3FsSzZLdHZRSzJHZWVWcElaM2dhSDBWV1hVbTFlS3g5?=
 =?utf-8?B?V2szeDdrR0lJOEo3MUFwVDZFaGZFczhneEwxS0p0NG12ak9YQVNGNVVGclNl?=
 =?utf-8?B?c3Y5Z1paWm1zZzVPN2Q5TFo2MGkrUndjKzVpZEpaUTg4Uk5tdm5CNzVTdUJh?=
 =?utf-8?B?b1BTQ01xeTZjUmtDYmEweHVtYlZJU05WdjRDNTFrdXYxOE8wZGxjdlFZNG53?=
 =?utf-8?B?MUIvYzNPOEtrTU1NSlY3ckRTek80L1RLeWZyd3ZhNndvUUR0RGFPOFZhdUc5?=
 =?utf-8?B?N2VuTmZTbVJiTzR2ZFgyTFoxa0pWT1M2bHFZRndrUlBnWVZiMlIwVFhxVnFR?=
 =?utf-8?B?WjVjQ2g1ZGp5Q3JKcmdDdVlJVnRqa2lpaTFnUy9kMUpoS0tZS2VCbElCcXRa?=
 =?utf-8?B?b1FlZlczcmRXakdybStqd2lwZW53RURJY000ZmdmKzYyanB5RlE1OEgrRzJH?=
 =?utf-8?B?enBJdk1yQzlVdU95TkZ1ZUo5UHFNSnVTenU4ZmJTaFpzbW1BS2RyMXJWWXBS?=
 =?utf-8?B?dTR6bDZHY3o2T0lXSXpkd2lYNGhTSXBkM0c1M1I0RTA2cTdRUmpzR1pLNFJD?=
 =?utf-8?B?dDhqK1ZwZ2ZLZUlTaUREZzlqWkt5SXVqRExSdFpkQW50ZGhLWUNGeE5hZ25W?=
 =?utf-8?B?WW52Q3RNczk0VzlyTU1CZzJDMzhTVzIwRnlVV21iaHFocDBrK0g5T3hKYkhy?=
 =?utf-8?B?NFZtbnJzQzY0LzlYd21jUmNMclFoMmhxMjJack1DbEtMRXEwTU50MGMxVU5N?=
 =?utf-8?B?OTdLTFlWemgvNDZyQndxVHZoZ3V6YWJ3akVhdFQ4clZRVFNYSDIyc3RiOFlN?=
 =?utf-8?B?M0tqWDl6WkxxdXpnWkNCZ0JoYUhuczFrbktnYkYrTS9hSVBNSkV3amJUejJP?=
 =?utf-8?B?MHFIYnBQTVUyTkg1WFUvakhEbWtpT0NlRXI3SEU2UUs0dCt0UERqWUZ4SWFl?=
 =?utf-8?B?ZE5zUFNaaG5DOHhkci9DOTh3WDExVGNFZ3pRRXVEWkt4U2l5WXV3Q1VOV3pN?=
 =?utf-8?B?UXpuNjg3VjMvQTZGQ1hWMnhJMXlzRmc3dUQrbzl5Y2MrTDJ1VFErRncyTXJi?=
 =?utf-8?B?ZnNybEN6NU4vaGE5OEdRVXk3RmFqODZ3L2JsZlpWWWxUdk5FbllqSE5Uays0?=
 =?utf-8?Q?F3G1eJZPBiu3o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5dca1b-d528-4eb4-a91f-08d8f4106840
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 06:44:18.0786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HYhxBTBsOyXZdUjwfLMuAq9sqTUqy4kUbq+aaNvLKEWDYoQSHK7SRRQz9WgQgvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
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
Cc: alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 benh@kernel.crashing.org
Content-Type: multipart/mixed; boundary="===============0333889135=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0333889135==
Content-Type: multipart/alternative;
 boundary="------------E281DCBE0558163012EB2F7E"
Content-Language: en-US

--------------E281DCBE0558163012EB2F7E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alberto,

well a frame rate of 24Hz is perfectly reasonable for a TV and desktop 
usage.

This is probably caused by the TVs limited HDMI bandwidth and a refresh 
rate of 30/25 Hz for the interlaced mode isn't much better either.

Regards,
Christian.

Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
> The frame-rate at 24Hz is extremely poor for normal desktop usage.
>
> If the highest resolution, aka 1080p, uses that refresh rate then the 
> desktop will default to that frame-rate.
>
> Other progressive modes don't exhibit any issue.
>
> On Tue, 30 Mar 2021 at 18:26, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Hi Alberto,
>
>>     I think the driver should only support resolutions that are
>>     *progressive*, but also at least of *50Hz*.
>
>     Why do you think so?, the 24Hz resolution seems to be the native
>     one of the display.
>
>     Regards,
>     Christian.
>
>     Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
>>     This is why I'm using interlaced:
>>
>>     $ *xrandr*
>>     Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
>>     DisplayPort-0 disconnected (normal left inverted right x axis y axis)
>>     HDMI-0 connected primary 1920x1080+0+0 (normal left inverted
>>     right x axis y axis) 16mm x 9mm
>>        1920x*1080i*    60.00*+  50.00    59.94
>>        1920x1080 *24.00*    23.98
>>        1280x*720*      60.00    50.00    59.94
>>        1024x768      75.03    70.07    60.00
>>        832x624       74.55
>>        800x600       72.19    75.00    60.32    56.25
>>        720x576       50.00
>>        720x576i      50.00
>>        720x480       60.00    59.94
>>        720x480i      60.00    59.94
>>        640x480       75.00    72.81    66.67    60.00  59.94
>>        720x400       70.08
>>     DVI-0 disconnected (normal left inverted right x axis y axis)
>>
>>     I think the driver should only support resolutions that are
>>     *progressive*, but also at least of *50Hz*.
>>
>>     On Tue, 30 Mar 2021 at 15:41, Christian König
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>         Mhm, no idea why an interlaced resolution would cause a
>>         crash. Maybe some miscalculation in the display code.
>>
>>         But apart from that if you just connected your PC to a TV I
>>         also wouldn't recommend using an interlaced resolution in the
>>         first place.
>>
>>         See those resolutions only exists for backward compatibility
>>         with analog hardware.
>>
>>         I think we would just disable those modes instead of
>>         searching for the bug.
>>
>>         Regards,
>>         Christian.
>>
>>         Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
>>>         I guessed so.
>>>
>>>         The GPU is a Radeon HD5870, and the screen is an old
>>>         Telefunken TV (TLFK22LEDPVR1).
>>>
>>>         Since my real display got into repair I used this TV
>>>         meanwhile, and to my surprise it froze the system.
>>>
>>>         On Tue, 30 Mar 2021 at 10:15, Christian König
>>>         <christian.koenig@amd.com <mailto:christian.koenig@amd.com>>
>>>         wrote:
>>>
>>>             Hi Alberto,
>>>
>>>             well what hardware do you have?
>>>
>>>             Interlaced resolutions are not used any more on modern
>>>             hardware, so they
>>>             are not well tested.
>>>
>>>             Regards,
>>>             Christian.
>>>
>>>             Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>>>             > The entire desktop hangs after some minutes when using
>>>             the module
>>>             > "radeon" with an interlaced resolution.
>>>             >
>>>             > Easier to trigger by playing a video on Firefox, at
>>>             least on kwin_x11.
>>>             > Wayland didn't exhibit the problem.
>>>             >
>>>             > Other display drivers, from different computers I have
>>>             tried, didn't
>>>             > allow those interlaced resolutions all together. It
>>>             seems they know
>>>             > there will be problems.
>>>
>>>
>>>         _______________________________________________
>>>         amd-gfx mailing list
>>>         amd-gfx@lists.freedesktop.org  <mailto:amd-gfx@lists.freedesktop.org>
>>>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx  <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cchristian.koenig%40amd.com%7C24d157e6250d4979c5fc08d8f3beb949%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527347790767402%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=efPyW%2BUl4PhnDWqghsRmaE7DKAUYoylzMP529%2BWrHDU%3D&reserved=0>
>>
>


--------------E281DCBE0558163012EB2F7E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Alberto,<br>
    <br>
    well a frame rate of 24Hz is perfectly reasonable for a TV and
    desktop usage.<br>
    <br>
    This is probably caused by the TVs limited HDMI bandwidth and a
    refresh rate of 30/25 Hz for the interlaced mode isn't much better
    either.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 30.03.21 um 22:59 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com">
      
      <div dir="ltr">
        <div>The frame-rate at 24Hz is extremely poor for normal desktop
          usage.<br>
        </div>
        <div><br>
        </div>
        <div>If the highest resolution, aka 1080p, uses that refresh
          rate then the desktop will default to that frame-rate.</div>
        <div><br>
        </div>
        <div>Other progressive modes don't exhibit any issue.<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at 18:26,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Hi Alberto,<br>
            <br>
            <blockquote type="cite">I think the driver should only
              support resolutions that are <b>progressive</b>, but also
              at least of <b>50Hz</b>.</blockquote>
            <br>
            Why do you think so?, the 24Hz resolution seems to be the
            native one of the display.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            <div>Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">
                <div>This is why I'm using interlaced:<br>
                </div>
                <div><br>
                </div>
                <div>$ <b>xrandr</b><br>
                  Screen 0: minimum 320 x 200, current 1920 x 1080,
                  maximum 8192 x 8192<br>
                  DisplayPort-0 disconnected (normal left inverted right
                  x axis y axis)<br>
                  HDMI-0 connected primary 1920x1080+0+0 (normal left
                  inverted right x axis y axis) 16mm x 9mm<br>
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
                  &nbsp; &nbsp;640x480 &nbsp; &nbsp; &nbsp; 75.00 &nbsp; &nbsp;72.81 &nbsp; &nbsp;66.67 &nbsp; &nbsp;60.00 &nbsp;
                  &nbsp;59.94 &nbsp;<br>
                  &nbsp; &nbsp;720x400 &nbsp; &nbsp; &nbsp; 70.08 &nbsp;<br>
                  DVI-0 disconnected (normal left inverted right x axis
                  y axis)</div>
                <div><br>
                </div>
                <div>I think the driver should only support resolutions
                  that are <b>progressive</b>, but also at least of <b>50Hz</b>.<br>
                </div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at
                  15:41, Christian König &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com" target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex">
                  <div> Mhm, no idea why an interlaced resolution would
                    cause a crash. Maybe some miscalculation in the
                    display code.<br>
                    <br>
                    But apart from that if you just connected your PC to
                    a TV I also wouldn't recommend using an interlaced
                    resolution in the first place.<br>
                    <br>
                    See those resolutions only exists for backward
                    compatibility with analog hardware.<br>
                    <br>
                    I think we would just disable those modes instead of
                    searching for the bug.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    <div>Am 30.03.21 um 11:07 schrieb Alberto Salvia
                      Novella:<br>
                    </div>
                    <blockquote type="cite">
                      <div dir="ltr">
                        <div>I guessed so.</div>
                        <div><br>
                        </div>
                        <div>The GPU is a Radeon HD5870, and the screen
                          is an old Telefunken TV (TLFK22LEDPVR1).</div>
                        <div><br>
                        </div>
                        <div>Since my real display got into repair I
                          used this TV meanwhile, and to my surprise it
                          froze the system.<br>
                        </div>
                      </div>
                      <br>
                      <div class="gmail_quote">
                        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar
                          2021 at 10:15, Christian König &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class="gmail_quote" style="margin:0px 0px 0px
                          0.8ex;border-left:1px solid
                          rgb(204,204,204);padding-left:1ex">Hi Alberto,<br>
                          <br>
                          well what hardware do you have?<br>
                          <br>
                          Interlaced resolutions are not used any more
                          on modern hardware, so they <br>
                          are not well tested.<br>
                          <br>
                          Regards,<br>
                          Christian.<br>
                          <br>
                          Am 30.03.21 um 10:04 schrieb Alberto Salvia
                          Novella:<br>
                          &gt; The entire desktop hangs after some
                          minutes when using the module <br>
                          &gt; &quot;radeon&quot; with an interlaced resolution.<br>
                          &gt;<br>
                          &gt; Easier to trigger by playing a video on
                          Firefox, at least on kwin_x11. <br>
                          &gt; Wayland didn't exhibit the problem.<br>
                          &gt;<br>
                          &gt; Other display drivers, from different
                          computers I have tried, didn't <br>
                          &gt; allow those interlaced resolutions all
                          together. It seems they know <br>
                          &gt; there will be problems.<br>
                          <br>
                        </blockquote>
                      </div>
                      <br>
                      <fieldset></fieldset>
                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C24d157e6250d4979c5fc08d8f3beb949%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527347790767402%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=efPyW%2BUl4PhnDWqghsRmaE7DKAUYoylzMP529%2BWrHDU%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="FzLY3MMo7iou9tOatMaCSBBSKUlSZqhIgcDgC4I1+NpBqC8KtBEjmZJAvNKY/47tcTbizkF+rw0/0AvPsfKS8ebf+gcEguFNhJkjnlBOpdtvsHyfx5OiQ9ifyu+4dxn3ANCdqTivEYQfnDLHAyKr9pe9gpjWj60hza30DWA5sVE=" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
            <br>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------E281DCBE0558163012EB2F7E--

--===============0333889135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0333889135==--
