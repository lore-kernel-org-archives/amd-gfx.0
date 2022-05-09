Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E338C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 14:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E01B10E140;
	Mon,  9 May 2022 14:15:25 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2CD10E140
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 14:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5Mom//nYS8XtF6+yEeehHRAfj6MkwuXG8bg5cKXFYjXbpfpPnUwGOgp4IlcEfdQp4K8LZNQv1VGugpwo7WKZMxVFD3Rs/72CHjTGW+xaDLfuY2MuBaWDCAlIHnEyoiEhU59KAeBtTIyRFvGOcv+3xA2h+GK1gXAqxeoS35GnFntHj/ETKT79k01bNFyPAs1Fjmoj6Kmc+ii0ijNbnTzKU19qlSD342bIxxO4zfYCHAQlu13VMJ6zCqOpLNz0aHiTg2uW+sLad4O5ftRxt/65idrqdikJWDk2gahuesAAVMYI3s3Y4tKlVCBglbeRAU9pwnKN5jeSR3l68hQyolvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK/x8cWhJ9pxYveDBZ5jtSnNy5UAfK4NXb5Gxf6PGzo=;
 b=NE+kJ9V8d4W9umwPdbIaH8P5QQGHr5JW1mfHmdtDX7C7rslwqWCCi82m4u7UYn3yn6yneUUKeuI7umN6GbXNyqclcztrhevTraj2WqVmcFL+cLpvrGQVZ4uhFMJF6MMtAr5a/fa5Nvrp6bUb0fFn/FZoFlrvCDGxofR+xl+WSRx8oLq2OV5wd9M5/bH26dINXaULAqIV11QQ8QAG4YpCMf+ysdj967DMTz5+q9sGIWBKHabeTzOoObB6zGZA5si9QvBXidDEvF3HV/YhaHpuClZZDLzN3D5oWAgI852B+Y8Lc/x+uYz9hrlWHVTQHaN0dEKhqq+FR8xQYU4EgksRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK/x8cWhJ9pxYveDBZ5jtSnNy5UAfK4NXb5Gxf6PGzo=;
 b=Lg78rz9R4ng70AOkxQc56dE0v73qr6DGM6bhHQrOMZzpbmAL6wWAjiMj0MUe6mS838wsUh9608OGwRB3bw/7HBa6CHe5IU0F/4CcuIiJY3/nLamPlWjYhLtyZUbrdzMC6iOxhn/GqExrH8WF4LtSJR9+kHJMHWbAPHDZWIdVpaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BYAPR12MB3543.namprd12.prod.outlook.com (2603:10b6:a03:130::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:15:18 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 14:15:18 +0000
Message-ID: <067c7558-8b07-139a-9eb5-e4fe9ce0cbf0@amd.com>
Date: Mon, 9 May 2022 10:15:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: How are the DC patches tested? (was: [PATCH 00/15] DC Patches May
 9, 2022)
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Daniel Wheeler <Daniel.Wheeler@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
 <DM6PR12MB352902B7FE179953EBBD474F9CC69@DM6PR12MB3529.namprd12.prod.outlook.com>
 <f284dad0-9a9e-0edb-54df-db97b58451e9@molgen.mpg.de>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <f284dad0-9a9e-0edb-54df-db97b58451e9@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::22) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e14f992-a2cb-4275-3093-08da31c65864
X-MS-TrafficTypeDiagnostic: BYAPR12MB3543:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3543A99858486223D4A9C0E798C69@BYAPR12MB3543.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hGJqB44wNij/5UMsATQorZgslrOHkq4+Y/yep215WOXGE6mRRjJ0ruT2HdaTrbP1YG8ByKg1BoYZZ22LREwFtuTjlqEVMSUwzekXauM5hStPIONlMajhsJPIQ3gl+lLi+sq33OdRhB5pcr8VN0T1Kn1ycu6s92YNDWRaROR/uEYl9dIeT1opPVcDn48Tr2QByv3OZ5/zzbKeV0X+mUuPz6tRNEGDpVkcUvzNtIXTJR/ttBy+M8MFe7eXQf585vQhfq08IZRfNZfOIZWMlppYvjvt9d8nMeyf7yA4PwXVbgJ2KrIdutSQcdENt595bGp68N2og+p75UxeVc6H8M60MJxi6jAlBkf2SFbaKDY++OR8AMTm19PBSmlWP2rBM5uv3gL+qM65rK6HEnFic8fjss5LteoCg2KynI6o4l9lkb0nlVCj7Bvb49FYsNswlfq7Ojao00ovLS7C/bvWN1nDMWBP00vWQ604n/Ncc49LVxbireY2+4nFVTibU+wa5yyU7O/ZU1qKIwTHdTJWVPIBSS3znYFkDJiW28Jlx9kWqETEiAxCI1vMwDCphg+tAgLz5X4CmTYvidTxX+DdVaIH0LMohIKSsAeyrtPoeJus/VBUA9Zqfx58GUbuq91LePdHuWzFjP+UwsrTp/w48VBvO5DILaDROsZI3KR5DtucihbV4U5rCaIyKIofjThgTGOHc6crRxvETBgVrOLxJvzllod00Na9QF6B9MrP8T1gCyJzXKqbs2LNnTuxq6l0Zp/fhjfNiGIlGVJtqRHkdWkv78AHHxD6JiSzS0N8qTq8Xns4Nx1+rcIXjnakZ3PEUuJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(6506007)(53546011)(26005)(6512007)(83380400001)(36756003)(66556008)(5660300002)(186003)(2616005)(2906002)(31696002)(38100700002)(8936002)(966005)(316002)(508600001)(6486002)(4326008)(66946007)(86362001)(8676002)(66476007)(6636002)(54906003)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJseTBWVjBqc2ZIYmJBVlRkKzNvdmxhUldtUS9IZUtLc2ZuQlZ2ZWZQM2c4?=
 =?utf-8?B?amFaNkVsWSs0S3F3dC8vU1ZoemU1NGMzNm0zKzFRVXlyVEVQQk9RbVdMQWgx?=
 =?utf-8?B?QWdadkhlY0VYdW5lTDhra1dWeEFuV2g3emljLy80OWNkVVVpbk9Ya2pPQ2Uy?=
 =?utf-8?B?bHF2d0Z1Szg0R2tIdDJlT2NFTE41T295bFVGQVFpcE04ak9Nb09IcVZUTzJL?=
 =?utf-8?B?Y09vYTFhVldvdWpaUXovYzRvM0hRZFpLNFlmckdaaWZOMENnclErYlduVmdn?=
 =?utf-8?B?Z1B0T0VHT1VLMVp3aUJ4TndyTUU3NEpaWFIwb2ZGaVlTMEp4d0UxQUg5Y1Ny?=
 =?utf-8?B?QmZhR2xqbys4UjFjTFhvblpvU0x0a2sxcUQ2TFJuTzdyWXVLWkdSSXNjQTJY?=
 =?utf-8?B?dUIvTkQyV2xIdEx1SkZNRWZuaDhNaDBzTXM5aVI2MWdoYjVlQnpob0Q3RFZL?=
 =?utf-8?B?QkZaKzFQb3laeDJpS0V2eGx4cGJxRTdQRVNhcUF4NFdBR0NGQksxUFpqM1Iz?=
 =?utf-8?B?dmdMT0h1TDRuZGtuK3IvemJwcWpqMjRnd3FMUm9mdUNjUzlCaElnWTdvdGFW?=
 =?utf-8?B?STBhb0xLY25zeEhBeDBoUDIxR3FnTmhvWW1NS1RnSXIzMjU2T0JUZzdnbEFR?=
 =?utf-8?B?eVdRUndKYzI4NnV0bFFsTVZ6dTZFdHVxNHY5emZvVlV1bWV5V3VNSFJBR1lU?=
 =?utf-8?B?SUxNbDZBNWdSaUpUNzFXWGoyZXI4Zk9wUnRNZUUvWUljZ2tML0Z5ejlHUjVj?=
 =?utf-8?B?QTFCMjdMYW9TaGlGWWZkcVdKZmxnNHRRb1YzRFQyS2M1M3dwdmwzZGQ2V29Z?=
 =?utf-8?B?R1VOVGJIb2M4aldacWgwWHRXL2l1dDB2aFEySUp2UEpZQnBITkJ3S1BsZkta?=
 =?utf-8?B?Y2NxNVNrTUNBdEc0THRQVXJJUjNLU1A3cFhxNVI0Ny9Gc01SQm9JYk5CTWN1?=
 =?utf-8?B?UkdJK0JRMUx1bHdMenZsbGFxVFhOaWxvb29NdnQ2RW4zMDFyc3hSNnRGNUxz?=
 =?utf-8?B?czIyYUQ1UEJsOFplV2RYRWIyam9ha2w1TVhFMWVmTEw4R0dFUWhPOEMweHRN?=
 =?utf-8?B?aEJRcnVGNnppL3RVa2lvZENLUkc2L2s2V0xKUXVKdVpLM1VPWVA3VWhQbGI1?=
 =?utf-8?B?bWYxbXF4SkNSYXNFSlBMdHlTSVNka00rMFl0M2ZrNFUzeUo3SDZQWlpsUVdB?=
 =?utf-8?B?ck0zRm5HZ2NqN1hlRVdKbTNFbjdZNlk3T2I2L0NVSC83ZWF4QjFYaGxJczBI?=
 =?utf-8?B?L1lLQzBkMktIdHFocnZDU3VGZFR4eTJ4YXFQOFFzZWpMR1FsWWpMUnV6WW9S?=
 =?utf-8?B?eTRnODIwQThPZnJZRkFzTk9qNHRhd1ZERUp5OVZKTlh0MUcvUFZWTVU0TTBo?=
 =?utf-8?B?L0JKQ2l1NmxuQm5MNW81SHNpRzRvNzlVSjJLakVjOXkyNFJqTVNOMm9nRnFr?=
 =?utf-8?B?T1BXWDNqbUZkRWlyQWxKUFdjQkF3RnpQS2VML1lzVWNLRmdzSTN3cGdWS2Z0?=
 =?utf-8?B?NTZTZzhrQmYyamFqSW54L1Y1YzNzeEhmdkxZYUh2bnExVFFXWmhEQjh3NXkx?=
 =?utf-8?B?ajVFRTdYYlZIYWtkNmRJUzBUZjI4QkQvVCtXMWJoSWdpRkNhSzhKOXRjcmRZ?=
 =?utf-8?B?eHl2RG40aXc2ZlkzYTNBMm1UaXlNVnJCcUFoaGJib1RKR09JbnhTTXlGZ3dK?=
 =?utf-8?B?SURWMTFZeS80QUNHZ0Vja0FJZUlOdlNCaXZkZDloaDM2dUhrTDhkUUpVSHg0?=
 =?utf-8?B?WGc4dEJxOURmdVh1dUFTRmdkYkRxOXRMQ09lQWRnWG9hdHFXbTA2dHRSSVd4?=
 =?utf-8?B?ZjNyWkV0ODhrZXZYRFdMcFFuMXRLalBmWHhkNnExYUx3d1FpN1N4TGFYVHlM?=
 =?utf-8?B?M2Vrd3VmNEhrcEdFeXZUb2tTT3JZaUc1Q3VhRXpKMGhHUndKd0hML1hCd0Iv?=
 =?utf-8?B?dWdqalRKZzU5MVQ4UUNWT1lSV1JWWU53a2V0cGZ2ZGludzlsTUVzTk9xU2FG?=
 =?utf-8?B?UnJib1hralpCWVdBR3RjRTFiWmNZcGpjYmRsOFpWUFlURzY1NzZMNFBFVE1D?=
 =?utf-8?B?OUtQSURWeHVEUmdHTDJCTVM2QVEyd3Y1YjVWa2lxSEJrWlEvaVl4VWJtNm04?=
 =?utf-8?B?bkg1STZQZnZ2eUZURTdvZ28rTXp4b2dvcC90bGdqZjJvQWoyTUdyQ0ZSYTIz?=
 =?utf-8?B?VGtWNjN3WGdwQTRwNWo2ZFlyQmljdkYwaHY0eGplT2ltajNzKzdxdWkzMlp1?=
 =?utf-8?B?U3lPNFJ0S2VBK0VoaVBSNW5lOE5QUFluRUs5Z252di9MNFR4ajc0TmFrVWxR?=
 =?utf-8?B?elFvMU1wNFpqQ2hwTlFiUFhRZWVrTXY1ZU5oZzRFc0RkakMzYjlvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e14f992-a2cb-4275-3093-08da31c65864
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:15:18.4468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFhnbzZw+eXtfiH7Wpa9LLvzPKA9F0iEz5VVSAjHTkiXDMWwsNlIK31uoZrpG05hesNKJHBcz2MRECvcwSUBtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3543
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Sun Peng Li <Sunpeng.Li@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Solomon Chiu <Solomon.Chiu@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Agustin Gutierrez <Agustin.Gutierrez@amd.com>,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-09 10:00, Paul Menzel wrote:
> [Sorry for the incomplete first message.]
> 
> Dear Daniel,
> 
> 
> Am 09.05.22 um 15:14 schrieb Wheeler, Daniel:
> 
> […]
> 
>> This week this patchset was tested on the following systems:
>>
>> Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following
>> display types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p
>> 144hz (via USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and
>> then DP to DVI/VGA)
>>
>> Sapphire Pulse RX5700XT with the following display types: 4k 60hz
>> (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP to
>> DVI/VGA)
>>
>> Reference AMD RX6800 with the following display types: 4k 60hz  (via
>> DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI and
>> USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
>>
>> Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz and
>> DSC via USB-C to DP DSC Hub with 3x 4k 60hz.
>>
>> Tested on Ubuntu 22.04 with Kernel Version 5.16, and ChromeOS
> 
> I am curious, what this means exactly? You clone the Ubuntu Linux 5.16 
> kernel source, and then apply your patches on top? (Do they even apply?)

All of these "promotion" patches are tested by using 
amd-staging-drm-next. In a few words:

1. We get the latest code from amd-staging-drm-next;
2. We apply these weekly promotion patches on top of it;
3. We compile, run unit tests, and run many manual tests (Daniel does that).

If everything is alright with Daniel's tests, we feel confident to merge 
these series on top amd-staging-drm-next (we are basically trying to 
avoid regressions here).

Anyway, maybe we can rephrase:

  Tested on Ubuntu 22.04 with Kernel Version 5.16, and ChromeOS

to

  Tested on Ubuntu 22.04 and ChromeOS with amd-staging-drm-next + 
promotion patches.

> The same for Chrome OS. Do you use Chrome OS Flex [1] with the systems 
> you listed? If not, what Google Chromebooks/-boxes did you test with? 
> The Linux kernel version is also tied for a device and Chrome OS 
> release. Please mention those too.
> 
> Is it documented somewhere, what tests you run exactly?

We run IGT tests, some scripts that validate some specific areas, and 
Daniel has an extensive set of manual tests.

Thanks
Siqueira

> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: 
> https://chromeenterprise.google/os/chromeosflex/ 
> 

