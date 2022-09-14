Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706FBECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 04:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24AB410E82E;
	Wed, 14 Sep 2022 04:30:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626C110E82E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 04:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVwGJNBsjAK5TONcp6AtBvDmpOgxDPXtiC28uwwbUWYaXbICMq/GiNdGzoibBObLwncMuf1guQfo2ZZ8sC++xJHCGT86xsAEIKP94UndVlkmN7LsSDDLQ0YGUfXrRTQOUN9lo1OzueaobblzqYkSX5hcoIPTGt95oiI4Q+86yFmlI7bR7482L/42kIkSaQUunSyHH48+S7Booc31fvIRVUNvfUkIQJvp8R00Jqe1Pfvt39fw2PB234VMDBL6bKQVQWX7ikSR58UpfUoU0fgU+lJ264nccUIhe708cA8UKrchaqbShV96NcuiYpmRC4d4KxQKgIQCJFKNPYnXyD/R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxvrbMVyi3pyQtrHMyZ1BuZMZcJ8q3R7iAscSM6a0r4=;
 b=MTZClJGEz6lZSomKOzmv7+Yq/nvVv23BXZQn2xcAsdzEdYMiKXw/c4w68U+IrGMLX9kyFZC+3OpD5iuoEa8FS+y2PmHKmY1FZfB3URWs3d/u6NPcnAPiNCH5EzfAcTaOVKa+7fsh1KQPo2LogCVfEVZx4Uz7zSe3hllFbUk0JCTeCPpEoU9fGEsOgy84UPRU3wegsrGAOcaodMKZV/HPwig6Sqtn7iOlZ6xbPni054UqAj8w4uGW29qFG5QDmNWXmpM81AzjyiCwMGMih76KJTamxGjzq7h+ARSz9SuIaHDowfWeQpoKOqkQYH9hLCMx4arNrH7SHonHHjv1w1JQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxvrbMVyi3pyQtrHMyZ1BuZMZcJ8q3R7iAscSM6a0r4=;
 b=bwxkEGsLhX/ns1HZP3ZcGQOiNbRkrkMxt0p1opvukhrujML06T/aLjFcW++UWCdJt7JZZ5z2EHXFBACFruhSMeN4SjVmy1kliElJ+D5Rd6JwqRotUDnd7bjGzVGpiKJ/2fpzUmQL3jfx0byrpP8p/Ls7TupLXiTLCRQYXiKI9Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 04:30:45 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 04:30:45 +0000
Message-ID: <b422c82d-28ed-39a4-01e9-0393ce9ba3fe@amd.com>
Date: Wed, 14 Sep 2022 00:30:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-CA
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <2d46d127-ea75-7813-2b37-2b1d4e77249b@amd.com>
 <DS7PR12MB63334FFA08E2F46245005175F4469@DS7PR12MB6333.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DS7PR12MB63334FFA08E2F46245005175F4469@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: bb629cd2-cb03-4275-5380-08da9609e3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MKBX9ZMuNI4lGhOz+eFgPRXEzQzGiueNt39huBuBzlU5cq6VM21+ng79nCZTDOGPGVEhc57vjpPo5NKIBxczvGtjICq9s66hDLUm7b71+5LKai7IyU8hOO/dshss3fh8s60ywDJBC8TOSP+MJI/XIZuUvcBD6IYbzlRx4unhWg24NmVSdxlP/ZscnCSMS3gGhzJmQgsoEb55vHtDF9VYA8qDlKtw6UmCluvFStDgfrfDGWnhAJtxYALFAUACbDzxxTvR81M4OGEZWu2b02yKxIvFu52K272J8L0V7F0kFhpnpLsMMdunJS3PhcFmrxrj9ipahN0d+5FS7KWwoWN7TPfPuvOejMWJp0I+COb8Pguy5x5DF/XgZKTq/UqUcWkE4uU8gbWUCTwKowT+3A9LNFSJVOOMIhxRKd5gYHboQo1YWIZYFa6XeSxIjWNC+n8mqdquUZd1OzG+kkShyqdwSb9wFNNz9uNJg2NdfruFFSbj4HJZdX8eVgRcoYPrggGRP04OBP/ei6b5ir/Ev94/1f5bG+9ZuI/JnAntOHKBiF7194pFanB2GxruMDLWxqwKLsm4ogOsyR5EPOjSPTZc+hNZ+4VrsRJVitUGzC2eUj8Nuyf1X9KhSMS51DnTWssCQVDPX4LjB6xQIUHly1/NerPZMHXBJJ8/FCbS77rrtInRisbx/gKES0w5Zwjw1l8pQntBTzVMc3LOnjTxPPxrtc3Yo37VUzR+NgCrpx5U4Bkr9uuBXSQ1w3Y+dZh43I9i0PAJM9IymRufPLo7BkffIB3YR7AVwkKwKEgHBNOCLw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(31696002)(316002)(2906002)(66946007)(478600001)(41300700001)(6506007)(6486002)(83380400001)(53546011)(44832011)(36756003)(6512007)(66556008)(26005)(186003)(4326008)(5660300002)(38100700002)(2616005)(66476007)(31686004)(86362001)(6666004)(8936002)(8676002)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2JjZnE5YUY3VnI4QXRlVUJOQ0lZUWVsS1duK3l2OXpnSERVZ3l1TXQwM1JX?=
 =?utf-8?B?TjFIZXZWQkt2Kytoay96NUFlYUF2QWxwc0ttdWxyeW9IVDlZLzZ4MkVnWm1j?=
 =?utf-8?B?bjBrb01rbDJMbUFKN3BZY1FmaXZtQ0pVRXpzdk00bER2K3hOcS9iRFpkYmFI?=
 =?utf-8?B?OS9nMTdsOE43YnN3YTVBVFYxN2pEc0tqZ1IzTTVBeW9xVUVvamtXRlJSTTEv?=
 =?utf-8?B?SksvUnIxZ0hBbUhhc0RJSGdiYUJ5bUpvVG5FZEdQcFlaTUhqN0x1emRrb0tm?=
 =?utf-8?B?Q0lwQkIybnEwZHBqWTFISUlxa0xYMUI5bDlTMVkrUzhhS294L3VjcTJTZ3FW?=
 =?utf-8?B?RHNEdnNXSlNFZUVJL0hIN3I1L1pxMmRqcndaVVlIQVlYMHE0VllLTUJjMjlH?=
 =?utf-8?B?dVJnSDF5aVZWSEk1UkgxS0NBUUlSazJxRFd3SGJiR0ZNcWFvelViRHhQcWdQ?=
 =?utf-8?B?MFhOTjdOL25kUGw2dlNBK0kxWnRZWk9rcnFHVGg3SkZXQkgzbDdGbVh4cllo?=
 =?utf-8?B?WkJvTWd1MDdjbUgwNE9qT0wrMXlOWFVmcnRMb2U3RW43RzQyTnhVbU1HQkdC?=
 =?utf-8?B?bmUvRTFaYXN0ZFJmL1Q0TDlpd2pzVDlVSzFab2s3RFFFRlBMRDQ5a3ZqWFZD?=
 =?utf-8?B?M01SeDZRYkNsNjJEWmpQdnZaU1VOQTA5YVFUaUNBR2dkRHRON24vRWkycXhV?=
 =?utf-8?B?ZFpZWGtlQjM0ZFhpbTdoLzd2eEdaOEdJUzk4c0VLMnJBeGs0ZVYvQmVITTRL?=
 =?utf-8?B?N243VExlSXA1UEtNcStOK2I1L3dONi91ZXBxc3BLR1dmbWN3SUl5THFqa3lN?=
 =?utf-8?B?K1NhdjlFcjhJVHhyZVBuTjlJSGlYWmh1ZDhRK1NaaDJ4UldGSWhGM2RYNGZi?=
 =?utf-8?B?djQvTW9kZzlNUDVCZEU3RzZCaGZhRzhYTkNVaG5KNWtEbEltQVVVTWNkRkY5?=
 =?utf-8?B?eHZFaTdYZHQzZ24xQ3gxcTdjc1pGN1M0KzJMUHhYMWRveGhnUzJpczdaSlRl?=
 =?utf-8?B?b29pYkJQZko1alRJRldsVXhqUDgzWUJBWm90REdlM2hHaFpsL3ZUYU9SMzN6?=
 =?utf-8?B?M3JPZXpvekpmckFJbXRzNEc4a1laWTY3NUZKY3crK2p2alVWQzJJUW5mRjJV?=
 =?utf-8?B?VW8zZzBpMXJtbVpkamJqN2tnbUFvaE5YNXh6cHZ6WHFkVk5wc25NTm4xS3Zn?=
 =?utf-8?B?MndJSkx2bXV0cnEvSzRkSGkvWkNYZmliQWdkZjkxMmJKeHI2cHk2TVZiRWMy?=
 =?utf-8?B?V1JJcEJka1RoV0dsRE1qY3NxdThPWEFFR016OVR2d1VHYWJobWRUWENUb3Zw?=
 =?utf-8?B?cmpqNmdKbDJ4cmM3ZWdFdmt6QWJtWXNoUFdwL0FZUFF6aXg0N0Rwd3lWay9p?=
 =?utf-8?B?dWU2N3NEVGNCZzh4QjZtL3NWaHJ6N3RQeEJENWtWZnFvUGlJM3FsNkd2UEkv?=
 =?utf-8?B?cWtvaFphMmNhQk1CUmQxaUZwZCtSRFp3WlR2ekFLNlR1dW1LTktGRWNPS1RV?=
 =?utf-8?B?R0I4TFJPcDdUWlNscGF0R3JjNkpSRThvaDA5SFBROFJOR1p5K0tHTHJZZEdw?=
 =?utf-8?B?ekZlaUdEc0owdUEzdzNhMVh5elphT01KZFNnM2taSml4Y2NMTHRYUUV0TTVG?=
 =?utf-8?B?VC9aWDhlSlhXVlRMR0xwTTJYMFdVdldQZ0EzWnc0SCtyM214UGZUNGVxQ0Uw?=
 =?utf-8?B?cWppYjNSTG0vY0JEVWpxSkZXVCtuMTRaT1loSHpmb0VwcS9pWlphNDF6OVR4?=
 =?utf-8?B?eTkvMlYxMUtKSUdVYnhhd0hTcitWT1M5MkRnNmF0OXlRVXFyTjVzc3VWZitT?=
 =?utf-8?B?ZS9rZEJlYkRpUlphaEFqQ0JSd01PMWNaaGcxYy9VYXJ6K3JyYzB1N1NQN084?=
 =?utf-8?B?R09JanZjUldXREhBOElwSGh1Um9Db05QWlF3MzhTcXVnSDBGSkw4QzdkOFJY?=
 =?utf-8?B?WmF3RlhQSTBhc3FEZjJSQzhkREJlK3MrclNtdzNEbW5LRU5zZDhFZkVWR2ZH?=
 =?utf-8?B?NjlPVEtGYnZKb2dvQ0tKY3V4dEVPRzBmcnBCYkpncU8wYlRuVWFwUXVOc3hV?=
 =?utf-8?B?YjA0TzBQM2diOEdIZjhpVThpU2pFRnVNZmEveitpYzJNOExFVlRwc1BRVCtV?=
 =?utf-8?Q?vHAlaoUGxYEMjRoxKjnpt6gYE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb629cd2-cb03-4275-5380-08da9609e3e6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 04:30:45.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFPZIuahL6PS7a+MnR40PI2MmM3D/udbKmEyFuZYzmfJa5DT6H/d0CfIM0TA7/xU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-13 22:34, Zhu, Jiadong wrote:
>> +
>> +     r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>> +     r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
>> These names are very much the same to a human. How about writep and readp?
> r_rptr for real ring's read ptr differed from sw_rptr. Maybe we change to real_rptr/real_wptr?
> 

"real_rptr" and "real_wptr" is the same as "r_rptr" and "r_wptr", and actually worse.
The problem is that there's too little entropy on those names and as such to a human
they look the same. In the current version of the patch, you have only one out of six
characters different and that's in the middle of the word--very hard for a human to see,
note and distinguish. The situation is even worse with "real_rptr" and "real_wptr",
as that's one out of nine characters different and still very hard for a human to
notice the difference.

For this reason I suggested, using "writep" and "readp" which are immediately
distinguishable from each other as they have high entropy. Now, what they mean,
you can put that in a comment, but please use names with high entropy in them,
i.e. they are different from each other and easily distinguishable by a human.

Regards,
-- 
Luben
