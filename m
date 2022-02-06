Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC01C433F5
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Feb 2022 16:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2097910E187;
	Sun,  6 Feb 2022 16:57:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9432710E187
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Feb 2022 16:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAbCSzDFa4ZOcdx6UA15aFlT5pLcqz8kynI+fMpNpAma54h229P8JbldeWGsTVHZfH3zk5vvixcmTfhmPE5W4urPmQFlev5j+LOhI7pWGIcK3iIPDiqOtHGqoQAuV6mWKwOj6dHHnS8EoUnUDIIut7aoVT2lca36MjA+8FxstLPBRfF3hEXX6UUILC4q34bEi22wELq+RB91WlYsPAi4oQ1NOyWhv8Wjxl7jfchr9sr7yyguObKOrVOzuECMXRGsailfqAO+9njlwaSuA89P0TUvVoEoo/O6eE1/N9Dia19JmXtyex1+V/ubgfxDbLbb3QQ3QQAfD2w3f77e5ejcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUA6aR/CpYgMqnqjfqgtwdtEeY7z9oviZWJ77G9Z/R0=;
 b=jBDsOypAWYIUlaR5k/esbju0GQNGdRe16Fyq48jmICP62r5TFJzUGeen/YYIVYZ3kvpMYnOPuyJ/YsQC574o0FRHllSnXPc2+dKFT1ey5yrhe+EBciMPbZ1ipNn8DZRzzx52+z8esBSeqUinaDq6Hhyr7vHqS4tIoRLQ/18W+UTMbLtR3C5em1nqqs5KQtgk0HIhhlw7+80vujQoTgrxjhqtEgVaRZjCocOA6ZmCT+EYVLobpmjgJcQJGRCu/OAZDfC6UKtPUxK1V2Cs5EFG4v5AfOzOp61+s3qusT+Gb8Gc0xt4fBK7x3qQbJolSNjo1MvxSZLCg354XmFKT9vtfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUA6aR/CpYgMqnqjfqgtwdtEeY7z9oviZWJ77G9Z/R0=;
 b=wHHvSWfnRVwZCsfMmAsLF43Uo1MA/4ZoF9r0nxQ5omk3BGGeVsvgkb5cYBSzz/g7i19T7bjwjBH7GUFWY/0KFhs5EiYPuAjJqwxG0pFAzXfy7wCiZdiJEdIb2ngyuYXeEsfFBgZgM6l0bwYZ9pcncwyfORHtrrxays5L8PKOZXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 16:57:31 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 16:57:31 +0000
Message-ID: <7190426d-0300-da40-963d-af1cc280cd69@amd.com>
Date: Sun, 6 Feb 2022 17:57:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Minimal GPU setup
Content-Language: en-US
To: Amol <suratiamol@gmail.com>, amd-gfx@lists.freedesktop.org
References: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001b5e40-e79b-4b84-f206-08d9e991c337
X-MS-TrafficTypeDiagnostic: BY5PR12MB3844:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3844CE94B103A5744034964B832B9@BY5PR12MB3844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDu83uurQ7DWsAMrRoraod2aoXk1JcLjHjxVOQWGEuvryrwF0L+XghY7tmzIgjPjg4wC1GDp+OcuMamGnwTmheU1DYo3bd/t8BwWXyf1jr3hsUyKrnLJLCyZMuRcMYRLdR/B6WBo1O9hr5o9mfQJ9MwPD2Qt86ZlNwP+pknJKVYnUoCPEVmseIo/6XirEG9P+cH/f3HQUqIjhtKXMkdeFLaGy+K7ommi2t/wsg8y+hNFS+AXN4wKR+Y4xgZgXe3cjtH/R/pOriygWJ3oUS4AhO7488cwrlMpxzIIkrT/9WbNielSLfHRwMy6GE5p4YWvTwrpEuHtUm3fAiLVvdr6oKvotozD/AOvbLg6MMZKvI5dB8BTkjJ6LVidt95CZ5XPoVBanTkOzMga7FjKwnJkpLA67s0yHLNVda8lkro30shAvv3lEltlihU/a/CaIgBEKnEO6hMXSR3tEyrpyHx3dsfOpqOf1Vi8xiz+BQ9BQ18CIh3wdi3dp7FoZ+ENi+bANQGtc3fBO5kPbJOaSWk8DqkoaroJr6R+psd+iEqSG0ZUyluST6V2OjKH5FPLus8P3qNi7RJeKK9yRXH+9U9m/EsZMDghjmQmOb6QrgnLpXwiweHossrsDEBizzaZD2mc9El0tVwIJGduZqDKyU7p0ICXPz8LwtRJDtGEZpWZYUSMtho5mtiBf1zVyUCZX1VgayvOthTZPId1V+OYW4foKlue915JXcr7qe64Xizzw+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(6666004)(66556008)(186003)(8676002)(8936002)(316002)(86362001)(5660300002)(3480700007)(31696002)(6486002)(6512007)(38100700002)(2906002)(7116003)(6506007)(2616005)(83380400001)(508600001)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M29pemR5TytFbDBjYk5XL3ZpeHZMbWtiTEZUM2NtcS8xZjZKTGtiTGNKN2Np?=
 =?utf-8?B?bjU0L3FtRzZYRXlLVzZoenlEVFlRYXR0OGtOQmtlcTRoUitTZXZ0R3ljWHNI?=
 =?utf-8?B?WTc4ZEoyN1FrNk54dHZLMlExd0daVC9reUxvT2dKWVptUHdsZUNZZUg4czhj?=
 =?utf-8?B?dzRQVGcyRUgrcTRweWN3YnJsUjFsd0p5Q3JnZ0N2Z2N2eWpNVWtqbWdDaS9S?=
 =?utf-8?B?K3YyMWcySWtWdGMxUy9JVEZHMGpWZ3h0MGNkVHV6cjZpT3Z2ZDFpaU5QMHZl?=
 =?utf-8?B?UmYycEE4QnpjL2xoSjF0NGltaVNvcnliUVJ5RFpsQUc1M3grcVBkbVJQMUc5?=
 =?utf-8?B?TXhKeC9vT1hQaDEvZlhLenhmaDRLYlFUZTBrUkhaMmJtbEovSFhYd0l6K01v?=
 =?utf-8?B?cmQwVlBwOXloWE4xcmJMU1orSXk5a0hXbDhWS1ZCWTBaeXE0ZHp2cHM3czha?=
 =?utf-8?B?dWNNSmNLa0IyaEhnNlVBVHpOdjRQOGdWSXJVQ3ByVFNPVDlxVEZIcjRJUHlz?=
 =?utf-8?B?NUNLcDE5bjQ5K2gwR05TZnpsK2pRSVBiNlRSSGlrR29mWE45MFNiZFhIdDMr?=
 =?utf-8?B?VXNKNUF2Wk5TeEl6NFBmZmN1WGdMNW1odlFUQjBkbUhaQlpVL3FUWXFWT0Nq?=
 =?utf-8?B?eUtod3lQa1dNMVVjcVRINVkrWm9DK2NydVVoRWl5QUs1S1c0V2NCeEZpdko0?=
 =?utf-8?B?QXVoY3F5R2I1Y3FxNmpqUHowbkIvR29wU29SVnJsSTRXWFl5VitEdVp6MVVF?=
 =?utf-8?B?cFlEWXBuUm5NTzR1NHdSdVp4SnA3S25yanp1MzhCbjljN0c5QUFRalp4cnZn?=
 =?utf-8?B?dk1vbzFMMmUvRjdQVlYvVkhOaWJaWDJrRzU4dnFQcnY0RG84NVRtTWJHbzdi?=
 =?utf-8?B?WmEydmQ5elVhSTFoV1VBRkYvckFqZzg2S0J3ZkxTNlVUbm5WSStwc2dwQldV?=
 =?utf-8?B?WGY3Ylp0UlFjZkhEYUVUc0ZHM1c4WGl5THpLVEEzYzdieXA5MWg0MWNXTnV2?=
 =?utf-8?B?SkVjZG95akNoWU11QlVVenB1YVJPalFLdXpjcWJVN1UvZGlhOFN3T045b2RO?=
 =?utf-8?B?NGQ4OWZ2VnkrUmhRRHlhMnNoOW5CWSswSVBrTmpJV0RmV2hXVFVUaUk5R3BD?=
 =?utf-8?B?R0EwRis5cEFKTUp1a1d4MnQ1aVRvT3E5dk9aVHJ0bjA3WWorVHA4eHUrMVlL?=
 =?utf-8?B?QlVDQnd0Q1ExUVMwNWZiRlFJS2creVQrZDVpMFJZNHVDYzc5enA3WUxWRE9k?=
 =?utf-8?B?UTREZUlLYllHWjN4QlQ0VTN2MHc4Q3RzTEJFVFdNNWZzUFgwcUIzdnFPcHp2?=
 =?utf-8?B?NzNDRmgvMjc0OVQwMGN6VVZ0ZkZ5VUEvWllMeXhiYVozZWgxc0dvTXp3ZURT?=
 =?utf-8?B?NUpZMDRqTlRkMHhjVHliVEZIZFlwMkdDYVZSd1FIWENmL0dQNEw3cHlkL1dm?=
 =?utf-8?B?c1c0QjJRREtONTJNYlZJZkh4RDVTREtsWFV4MEQvQkdpTVhXVzhDL29TcXhp?=
 =?utf-8?B?U2t0M2tIUDFmc0FHRDlPRkJTRmJlS01YdlF4SXZRaTZDcnV3YlFlaW5JTE5Y?=
 =?utf-8?B?MStFZ20yZWVDYTd2cEtHZkxUcnREUmwxbm1LNlcwMXdob0YzZ3YwcVhPVHhq?=
 =?utf-8?B?dWdlazY4bGNsWG8zSmJDbDlqdWdBaFZGazNtREVBTHhod01WaCtNblA4dWxG?=
 =?utf-8?B?SGJWS01jSkNFU0pYZmdxYUN4RkZOb3BVbEk1Mm9VcHZvbXVKelpVK1BrZnJo?=
 =?utf-8?B?NE0xSkZZYnJsSTBmTzVHV1pHc2x1aWptaDFjM2NaUDh6WkQrUGNCUFZhN2Zi?=
 =?utf-8?B?and6TGtON2ZJWWxPQ3hGbkszMDhhekUvTWRXNFlTRzFCaFlXNWw3aTlRNFBs?=
 =?utf-8?B?Y1JZU1lCYmdrU0twaVpnZk5QTDhHajU3VkMrT21pZ0RGUzVqUlVGV2ZacnQw?=
 =?utf-8?B?VkhaQURWMWIvaG1JYTJyZFUySERxelVLYjdFU3o5NUkxSGlzSEdTZmZtU0Fj?=
 =?utf-8?B?b3dKb2FrMWxzTnoxM3AzLzJ3dWNSeWxrZ2lFM3BvZFk2cVI5TndDelVNVFdo?=
 =?utf-8?B?emUwbTdZTE1Rd1o1VmVXUE50YTZnYjlMRDJncFRFMS9kM2ptTVdHOE0wbUo2?=
 =?utf-8?B?ODQ1UXJtZ0s3UU9mcDU3UmZhdlYvcUJiWGlRQjlyS3hKa2ZvaWgvZjZBdEZD?=
 =?utf-8?Q?EZOWrcygdcXjV5PINjIG3C4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001b5e40-e79b-4b84-f206-08d9e991c337
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 16:57:31.0013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvM1FZm8nBDtcygyZsTZ1uIB4qVBsq9LP0hcaTLi82e21/ty9aNF1A6EkkZ01hxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3844
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

Hi Amol,

Am 05.02.22 um 10:47 schrieb Amol:
> Hello,
>
> I am learning to program Radeon HD 7350 by reading the radeon
> driver source in Linux, and the guides/manuals from AMD.
>
> I understand the general flow of initialization the driver performs. I
> have also been able to understand and re-implement the ATOM
> BIOS virtual machine.

That sounds like you already came pretty far.

> I am trying to program the device up from scratch (i.e. bare-metal).
> Do I need to perform all those steps that the driver does? Reading
> the evergreen_gpu_init function is demotivating; it initializes many
> fields and registers which I suspect may not be required for a minimal
> setup.
>
> Is posting the BIOS and loading the microcode enough to get me started
> with running basic tasks (DMA transfers, simple packet processing, etc.)?

Well yes and no. As bare minimum you need the following:
1. Firmware loading
2. Memory management
3. Ring buffer setup
4. Hardware initialization

When that is done you can write commands into the ring buffers of the CP 
or SDMA and see if they are executed (see the *_ring_test() functions in 
the driver). SDMA is usually easier to get working.

When you got that working you can worry about IB (indirect buffers) 
which are basically subroutines calls written into the ring buffers.

Most commands (like copy from A to B, fill something, write value X to 
memory or write X into register Y) can be used from the ring buffers 
directly, but IIRC some context switching commands which are part of the 
rendering process require special handling.

But keep in mind that all of this will just be horrible slow because the 
ASIC runs with the bootup clocks which are something like 100Mhz or even 
only 17Mhz on very old models. To change that you need to implement 
power management, interrupt handling etc etc....

Good luck,
Christian.

>
> Thanks,
> Amol

