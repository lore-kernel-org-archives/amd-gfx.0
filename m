Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E14C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 06:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E819910E2FF;
	Mon, 14 Feb 2022 06:20:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CD610E2FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 06:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOdErd1nk8ttImU92HF0rLJn4z1jFJVY3CoVTLby+MLk3XKN/wN8KPLSka72Z0NM0tiJPiGFkvDGelOxgmKXqi4Aiprh70HkjPBNecGDZzvLuaSTHJo4TNg9Hnt1UeSa8V6csXV1UEtZbf+OWJIqDxd9A/ypWE+tBotVwnJu2lXh2QVOaSjJI8zXbgXTMNKDJ3GvD9ziDmWvtllNGrPXZCpjbwriogZu+fPJCp8fqHEbr6B+DCKiKpu21OetmuyLTu39KdlCit4XbrwyXErKiicuqe20GKPT69LhzUvkNrFVVHxgJuOXoeV9zz3l05kQBmx6lHe8cZefBriR6mlJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4I1Pb+pIuYXM0xEZ7nxMUb93ZJhcR0qCFRUfa1T5eo=;
 b=FTDDgsZvN166/G+4NHDNfSqtaqZxYHMJo5hGa3bd0FMZGeV20zTcQkGUnZq37zApGAG64pRvuFTstatntHW2pwxZK51MpDZOvnSd+UBkh1FqTwT9hvJqoeW/c8sVm4Q8WwIQrNIptb0zMQVydtmF3cCenQQ+i7ndDU9KmkM5jA2TgVQYtQ4HEguU1bB+I8/hl6XjeJ1qf9gqswDLJxoE6Ldgo7gCuNuz3Uw/QizEjT3VyxUnxT6ilc1exozPQWUZq5auh0luzYbLFt+tEQB+OA5qLB3YvGS92nF67IgbRfdhJc2dNS6Y7SPZTVY+PlOx97FI3sEebNeTj63cs1ry/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4I1Pb+pIuYXM0xEZ7nxMUb93ZJhcR0qCFRUfa1T5eo=;
 b=WYcTHUDUAEP6OUhicsnnb6sH7cQ1caMoNo66yrV7HUSkuOAryvv76Ph/uU4JRgr28E5Yp482/y+jhFGHOqGhi08MniqLbVFC6hMBwisYUehR536Z1j88oLaYfDr12RG+QjH/Ai8JqlLbdPwidF2XekL/z4p0fRF212bgYrwR08Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3632.namprd12.prod.outlook.com (2603:10b6:208:c1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 06:20:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.015; Mon, 14 Feb 2022
 06:20:34 +0000
Message-ID: <b30922e2-04f5-2135-695c-2ea84d9307ac@amd.com>
Date: Mon, 14 Feb 2022 07:20:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: AMDGPU: RX 6500 XT: System reset when loading module
Content-Language: en-US
To: Cal Peake <cp@absolutedigital.net>, amd-gfx@lists.freedesktop.org
References: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <alpine.LNX.2.00.2202131848490.20545@lancer.cnet.absolutedigital.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0071.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::48) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1afda64-81f1-49b5-dea4-08d9ef821abf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3632:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB363253DAED7633A9411DE8DA83339@MN2PR12MB3632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NykYjt1Zj/22wxFRIBB6ndtf3d+I7M/i3Ko+XIGpvFGeaalEXG+vMMb/ucsvpgGGh+T4ZAa282DgVplGboMe558j64AbuN229iOtS2yxeQceZM7Et2CR8tVih1pHweN2QvVfkvLNlEBOdFNlMtw04tJN1CToeNMY0XnLhqv+UK6IJojPu4QETi5EBLl1Naj+MMuHFZGzPGB9as8noz+B+sI8YHNQg2zlBl3dsiVsFGWa9FavDxxdEd55KU1aPqu3YeB674gtO9X+i53b1K2jhncdTYQzfMXfw1xdmEW67WYF7pfhFVum7hjsfB6OIyQ6cqzdonH3bt38Go8HTT+WE6mdpMTzILBEGpVouFzR3+LcJ15oUyR9iw6Sdm+C0AhDeeJsQDA3hQPfm4a+S5nBNnVM0VqpJRN7s1my3Cr8Vvtz/7+qCq/yQJqtpy8D7tLnf/eqdOvFg2H+rGqI6bcKrLP4rju8x7/zhTX+NS4bUfpYJ3MCa7AKVzlcYM9N/OkVbfN4kITLRCE1HkJwZf9fpven68aR4myyv/iUJoSnRX22g6k8my7mdsvRBeGTl2CkSLMd27VdBxaT0hPOQd0IcyHakKlpkGh40JrmKZfmO37n8o+sIDrkWiYNFf0DsCOHy+m8yJ6INeAoWFBps76AJyFztM0aVTqjkZeFhkWr8iv/vVSL6DY11GfIfmlZ2BHqqkoAQwJ4ZwOSaSxwHuXvBnhnaTqqf9TyZ6e7SgzDQF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(8676002)(66946007)(8936002)(66556008)(38100700002)(5660300002)(66476007)(31686004)(86362001)(36756003)(31696002)(6666004)(2616005)(83380400001)(508600001)(186003)(6506007)(2906002)(6486002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjgySCtNWmRoYjRmU04wbTFYUEdXcGF6VXFjZ2w4UHdMdDAwQVdBT21PV25M?=
 =?utf-8?B?RFdxcm5TU2ZYdGdjRmFycU5JVkRjVWZ2UE0vSTV3ZERlUVV5Rlg3Sm9BR0U2?=
 =?utf-8?B?RWhORGl0b1JHSXpZc3l0QStscUI2ZWpYTGFTVmcyRXlqUEVxcXdyUTVSQVcz?=
 =?utf-8?B?aGx2RHc3eGg4U3hUL1lTZkZhRkxkQzFmWjM1aHdtUWpyc1hLRi9wSTZVMnpj?=
 =?utf-8?B?a250aVBFNkNLNlZEUjd3YXlZVUoyYkRsWFhnTCt5SGxUYXdObXRFdk9leVRm?=
 =?utf-8?B?NS94d0VPUVErV0NKMnpOKy9pR2poNGw2Z0J0eDZyNVRPNXFEUHF1dVRsUkk0?=
 =?utf-8?B?YTBYS1VDRDEvcEJBU3hYTWNxWklPa3Flb1p4bFRzMFBqckN5YUpEVzZEU0JV?=
 =?utf-8?B?YTdMdHdkTjhWdElxUHJqSWo4QllzZlhMd295dTNmdUZONCtrMmowb3d2a05i?=
 =?utf-8?B?TWRCaktjR2V6RVRJcExhT0lXbHVJZW1pZGdrN0Q5NU9UMFdiZFlJRVRBVVhm?=
 =?utf-8?B?RUxkWXlxeFdqeGFlUWxVZDZQY0dOSkRvcHdtNncwR1FVM3FFNFFLQzZVR29H?=
 =?utf-8?B?TGFUamZyWGJ3WDFVYVlZYWpCYk9wNTNieVI5VTJzaTUvVDRVOWZZTW94R2tC?=
 =?utf-8?B?cU9oR3hIN3ZwcjN6K0pPaUVTVklaWmxnaDRDV0VQWnFKdjQ5OTNDZ0owZC9x?=
 =?utf-8?B?b1pyaHpQR3FYek5qd0IycENnbGhtRjR5SlBvM1o4Z2czek00NGxZbXpIR2dV?=
 =?utf-8?B?U25kRGRmVUZCU0tEd3FVRGFwMzFZY1ZsOWliRHY5S2ZtRngyY0R0RE9ZWWlM?=
 =?utf-8?B?MmZzSjVvTU9qeXhON0Exc1drTWlEbzRodDBJM0gxdUl0MDVIQ3lTZWdIdEta?=
 =?utf-8?B?Q2RsZU9mbzNneEE3NVRoa1NEZUdmTlA5YWNqRm5hWExDTTNWZ2gxeFNLOHA1?=
 =?utf-8?B?Wk9vM29ZVFlhYTJpd1pIVWt3ZWRIR0lCOEpuaFFuUXdsRmRQTzJoUHFKWjZq?=
 =?utf-8?B?VmlzZDVDYmdRNVZiWjBTT3c4Q0RkSEFFRGV3RDJnMjRUMkJ5N0NydHFLUUVN?=
 =?utf-8?B?WkpNZlVET243SUJ3THdqaTdmQm55N1ZxbEJMNFBhNDByR1M0ZDdzcU5XVXBF?=
 =?utf-8?B?Y0xKcXEvNHJORkZBeER6VjUvUUp4MUIxZ1RvU1JWMUVxMzF4dkk2SHJsM2pM?=
 =?utf-8?B?VnJiU0QyUTI4RjgxRGFoUUlJRnY5cWlqSGJVbms0UGpRdTlKTm5hN0NPK1BX?=
 =?utf-8?B?ZmJFdzVHbEpBeFNMYUJTclZkalNqV1lhdlF1N0xMUHkySkhmUkloNnpFMjdI?=
 =?utf-8?B?Q3dHeG9aQ3Jod0tNYXJOQW5pQnEyUGVpMmVlSWp2MTBGdGFXeWc2ZS82akpF?=
 =?utf-8?B?cVkyVEVTZXdZU2lvenhreS93a0t5WDQveG41V0YyeGx5ajk1R1VhMFhmZ2JQ?=
 =?utf-8?B?OHczOC81NWtwNE5MbjkvemVaY0lRWWpJcVVleWpGL2pFd1ZlRFFLR05vWHU5?=
 =?utf-8?B?TkpCK2p3MzBFRmJGMjdxR2lJU0c4TEZCU243WE96SFRIc0hHMmJTOU0wKzhq?=
 =?utf-8?B?WHRQOXJ6YzBqNzVBRnZPRDhmcE9mbzBoMmdSWDRYOGRXY3dpRHhSaUt6QzZD?=
 =?utf-8?B?M21ORE5zTFE1MzVmWThSbHVwd3UvRGZFQ0FkdnptM2ZOc1RDVmYzQzMwWWtq?=
 =?utf-8?B?UjdBL285Q1l0Nzh6UW56OWtsL3R5MEwySUhta1VJZWdhaVhjRzAvYkpoaXBz?=
 =?utf-8?B?ZSt2Qmgwb1FxVW53WDNmQVh6aThocDV6Vkp1YzF0NWNBcDV2eVg3Q1ZrOHVp?=
 =?utf-8?B?Ym53UUVVaXVPbnR2b0gva1M5dWg4WFI5L3l5eHpVSk02ZEVJQW9pUk00alZG?=
 =?utf-8?B?MG1vWEhKTVNlSlVjNW00WDlIRUk4MkZ4dUJCYUdFekI3MG94NnhPYUNyUC9X?=
 =?utf-8?B?MzNvOUdZWGg2b0hGci9GZXlWYnpWdll6Nlc4d2pUdzc4VFR6M2xCa2xHcXhW?=
 =?utf-8?B?VEIvMDhJbDVSM0lpWDNYU0kxeDNDeUE2ZTNySzJnN1pjYmR1MUNyTEZGdDZa?=
 =?utf-8?B?b0o5b2dyQTRRL0tuZXU2Vjc2dGJNa2FvL2NJaXRzdWtrUDVkTUF4NVE1dVpi?=
 =?utf-8?B?QUhJQTdzMENsLy9sbzFHcGRFZXp6ZHlVb2laY3Npa3FScEZScHJsaWFtd3Iw?=
 =?utf-8?Q?dYw+5gKLwIEoaWb9yjs8Zjc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1afda64-81f1-49b5-dea4-08d9ef821abf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 06:20:33.9141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVLuhHeftYpFsu5y79d6Zf4HjmN8zHPPxpbRBGId5hj6qvoFF5orrMI++d9BnGWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3632
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

Hi Cal,

Am 14.02.22 um 00:58 schrieb Cal Peake:
> [ 2nd try after subbing to the ml :) ]
>
> Hi,
>
> I'm trying to get my shiny new Sapphire 6500 XT (PCI 1002:743f rev c1,
> subsys 1da2:e457) up and running, but upon loading the amdgpu driver, the
> system does a hard reset.

well that sounds strongly like some hardware problem. What power supply 
do you have in that system?

 From your dmesg it looks like the kernel driver actually initializes 
fines. So my educated guess is that as soon as the desktop tries to draw 
we suck to much power and go into brown out reset.

>
> If I pass test=1, it will delay the reset -- that is, the framebuffer code
> will kick in and the resolution of the console will change, but after the
> testing is done, it resets.
>
> I've tested kernels 5.15.19, 5.16.9, and 5.17.0-rc3+, all with the latest
> firmware, all with the same result. Trying this on Slackware64 15.0, but
> it's the same story on Fedora Rawhide, openSUSE Tumbleweed, Ubuntu 22.04,
> and EndeavourOS.

Just to make sure that the hardware combination works fine: Does it 
works on windows?

Thanks,
Christian.

>
> Attached is the gzipped kernel output with test=1 passed and DRM debugging
> maxed out.
>
> I've tried a bunch of module options and flipped a bunch of BIOS options
> as well, all to no avail. So, any help is appreciated. Thanks!
>

