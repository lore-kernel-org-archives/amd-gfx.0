Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9EEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 07:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6064110E14C;
	Wed, 19 Jan 2022 07:31:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE8110E14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 07:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyPL9inrMbDuR6HPnhdE/4ELfL7OCBpgIZSaw1gylbKBbbzAP0wTe9bGry+f8OFEcBxkp1JqkYtyWqcSJFaepjBL357pboP6fteXXb2OtI+BXCt/XIuJqG7E3BWVv47fr/AzrNdTfMkq4KRGgOe6eI7KGd6YpvuD3LTEuxfUdV05xhTDLBOo+lPdQKub1wXv70aUqehiGnjwAk5EanE9UzTpUS1LPMFIC/gWp/Jgyru9DWPjhnONFr/13jK1qhcOAoeVsZcceRKbZQ6/w7uppj3pYSdNJ2gFM2CHpE94bzwTgP135B2gWE+OOxKlTYR8Z/eHBKWdLf2aUoRD3RXp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sY2/JHEmBs/48P+uxdwCrKApDNd6RLFSQ+LZ0iPvMQ=;
 b=VSbeKngaYkHvHvDCtJSzVCr5Gcv0SqyJXVARaYmf1fYk3/cbupO2dm9D0v56fAoAC1CipIupWaAsZGZgfLUFp00DkW0askzkHqx3Lm3sYk6nDrs8L1TlZRfqiOn8ldivo3S+vCto7XlW+GYrvYjn5GeFu4oO8ZNXwz9WypSf+cKNXRoQQZoHuGCJykY6CLUx0TEkwmUSpdhnjVc9X1fjbYN5dSCh8ndXBoykYjUqjbaLGI3NANSb4l9IYeUtbKoVGVNhl/I1uDMVwOfhci7WnsmQ5X/+jF87JX3OpaPE89JtCqaHfgHbtTcOcivk/FrNIDwg3PqAnfLyq9AGyloEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sY2/JHEmBs/48P+uxdwCrKApDNd6RLFSQ+LZ0iPvMQ=;
 b=OmYavK4vLVwyBDgRLrBBOP8V+532FMRyavzIu8ODkti6ADO2Bc0skyFHde3YO/uRN/1f6jEWFr/CrWMTofs4+NFNKopG6YobqEpPDaUjIkI9BjcI8qF9GadkY8Tjdr3ybNTJxzLIP0p3WglzPFTn9Lc99YzOOM600hiSC9GJVFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3603.namprd12.prod.outlook.com (2603:10b6:408:4a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 07:31:18 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 07:31:18 +0000
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
To: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Russell, Kent" <Kent.Russell@amd.com>
References: <20220118161552.11122-1-jinhuieric.huang@amd.com>
 <CADnq5_OVpDd7O+q=9N8j14dwa-+2PqKjmDvKv6JkQGiiuQDYSQ@mail.gmail.com>
 <2f7705db-d5ac-3e7c-a991-79634c0b9f8c@amd.com>
 <DM5PR12MB1308EAE234EBFD55B3374B3085589@DM5PR12MB1308.namprd12.prod.outlook.com>
 <CADnq5_N4i9+FfzUGD8UWrVjc-9rs78PEzMW9wpWeqe4JqQnvfg@mail.gmail.com>
 <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9469b409-0056-7a55-a350-d1b9b5fc0ca2@amd.com>
Date: Wed, 19 Jan 2022 08:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <f182bb24-d2ff-f1e0-1a20-4b71b665d558@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM6P195CA0082.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1df0bc7f-0f38-42fd-f2c4-08d9db1daeac
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3603C4BBB95715A2FB6F2E4C83599@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tMjcgaEpyfnDqPv3/+o/XAcWVL0HhW35E6NDldqqY2ntsBgzKbJfKd0XNcSfjbzkcjIaB/EuVmpEEIrJ3PtWwte4Hx1ZLuUSqxE+lrs0BIQmcwOmArzlpAE0FLTIvWirkdsY3JRqHy/1Ziv+4IGuToKVA4NzJ3rhzTvKnhpYnKq+oYUZgUu+9JjLS6mH7fLdN9f6M4zXWlPDWlpcN7hp3lrl+73jD6oM3vt3mKslxsFS09M0SjOGY7wqHjrChTuYP3Ii82QzHMDHfLa1Hz8b6MIZO1OqRNba8jR7wcrW/saqExwQkHUHRz+LmHwRmhz+wTuGijGGn5Lpl7RLvNAkL5O2JN8+kJfaeEEPnU6kkCWqEaIDiDcD5xMg2E++jMkIGQ5grfRrT8yeaPIWrGVYdu0T5rgi3tVMcISTGGNt+99f9oKeaxdPm0waU/fKemIKLn7EAxakMDgKDSflmZF6L7TcYUvHfwqo/S6xqG4k5Rn3XYyzM3f4G/QfQVeOJdZ5kJrK8Ktjda2FYIv83zqX9CZIEqb9z/zSl6cffZOSSy7Gh8tWnIM57wTDSRiWXOr6x8h0s51Zp5+SRXbaqI7vfoMey5XaY0aghuE9+EmlguQkQJkbD+cFo6zMyXpr8RC79wwAjcUcHXKnoF3b2bnY4U3hpKjA3z3uWbv1CTyHorFEBm3G7bVcGY4ODoJ6Z2H2B8bTaUlsK490vYikewxiWuUP1j3NaAfVIceK7Bh84Ni1OOICCvKL9RuTTtmexv7/wCfsTnZFPcNvw2lGoqOSxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(36756003)(508600001)(38100700002)(8936002)(4744005)(8676002)(66476007)(66556008)(6666004)(31686004)(316002)(186003)(86362001)(6506007)(6486002)(26005)(4326008)(6636002)(110136005)(2616005)(2906002)(5660300002)(31696002)(6512007)(16393002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGw5bktsUzM5TzYwaEpmZWRoZ1VPVG04Wnp2R3JhRkVES2hyaGlkZU9UWFMy?=
 =?utf-8?B?VGVCdDBWVEdsd0d3Vnc0bWJiVm5XdmY1WEJQYk9aVFJYSzdIS25GZ3V3UHR1?=
 =?utf-8?B?Zm12UjlYSzU4UlhhR1NxVmk2NkREWWE4NmN1dFBSSGZBUEdDUEFtSThxelhm?=
 =?utf-8?B?T2gxdHlZOHlIcStSTDEvcjJSMmdJM1o2MHBibGJKSEhYdjZqOW01UnBwUW9m?=
 =?utf-8?B?M0dXaDFBeExDUzdpNkh6cUpOelVwa0tTc2YvczBOTnpudVN0ZFQ0Q3d2SEY0?=
 =?utf-8?B?M1B3emFWbHdqSmR0dXZsZkZraEZSZFZ1WExLY25oS2M0dVpQb0FEY1lkTytV?=
 =?utf-8?B?QkU3Ulc0WldDaUxyeGJDSkhxNHBIWEVGNmFsSTdwRTZQWkVZb1Z4REc0UUw2?=
 =?utf-8?B?TmxScThNcmg5bHF1VWVISEVFOUpWRG9RN1ZRZEMxVmNoNVVVbDlIam11Q202?=
 =?utf-8?B?Z29qVVhjT1RoR1E2bkJIZzJ0a1YxTGx6N0NsTHZ1QVhldExhbG1NUDVsb3Fm?=
 =?utf-8?B?Qis3dDZGbnNtZkt6aHpNK2xXQVRlVU80UXBQaUNPMElMWmIwYlRCQTR5Rmh0?=
 =?utf-8?B?bWRvODF5blVzWnBWbzhqRUN0YVhiZjFyb2k4aERDb2x5OEZ3Smo5WDMrcjRm?=
 =?utf-8?B?YXpFdVRqVzNOaVhPa3FzS3NKOE4wUFJwYytXWEFuWHBkamJZbDdjS2ZISkRv?=
 =?utf-8?B?TTgvSE1hbkJrN1NDeWErbEdsY3phOHhRZVNXTVd4Y08vbWZKam1CYUZnREZG?=
 =?utf-8?B?UlRzcFJERCtxM1hxMG51b3JoTVFzV3N6Wm13bWVxNjQ0SWV4Ui90NEZkRGdT?=
 =?utf-8?B?OFIvdGEvbkgvZnNkelBtckxvZnQ0MkdyMXMrMkhHdUEwZnpDTEVWQUliSW9l?=
 =?utf-8?B?K0g0eEJ6QkZVVGNtZFZVcmpUSE1ONHlMcXhMR0g1VW03eWtDbFIxeG9VK0dZ?=
 =?utf-8?B?VUZFaW9TbENLU28zRkhmMGpQWXIvSWRXUGZISnJBblFQcVltK1dtcWFNeXph?=
 =?utf-8?B?Nk1WdDhrOEhKbXExcEhqK2p6cjF2V1AvcDhLTzBTNmFvK3VQVjQ0ckRhUjhq?=
 =?utf-8?B?eC9FRUFjRHY2NmZRaGt1OHdHZzJzS0krenhscEw5OE8rNFhZdXVRN2pLWWJT?=
 =?utf-8?B?Q2RYajQxRVNRTE1hak5JM25CVGZtSTFua2E3Q3p5RUlHZlVXTkVJZHhKWHRi?=
 =?utf-8?B?VEtiMjI2UVBoSzFueHhwY3dQRXZPM2EvRzVFRThEWFBHYjB3Z1RRTHl3ZFVn?=
 =?utf-8?B?ejFmam1lOXdqaSsxL3E2YnlVZkpoL3ZmR01CNkozb0h4ZGZkVzRyMC9zMGN5?=
 =?utf-8?B?a21LNTlZQkFVNEQ3dHRyY0JYdEFPR1ZNVWF1MUVCYVVTNlo1UnN0NnZxOVZJ?=
 =?utf-8?B?bjV1R0oxUGxFWUljRlYyYldnSFpmUDNmMGdIU0pzVWFZWWdPenZsejArNGJG?=
 =?utf-8?B?OUV4VnJ4ckdiTC9IV3M0N2JtcUc1S29jSHE0b044aEtVZnJ4ZlBZMmZwNDZH?=
 =?utf-8?B?cXJ2RXRkU0FGdkljeEoxV2poOEpLcVpVWUttMnZBVDRoVDBkMkNpZURXczk3?=
 =?utf-8?B?RFRWd1ZHUngrUjkrTmQzOFVxTlJuc0pJZG43cEJsQW92NXZaVUlhM1BwR1lJ?=
 =?utf-8?B?b01xMVhQRlZSUGxwQnVaL2taOC9CUXpIcThibG13Znd2RUZDV2lTQVZjaWkr?=
 =?utf-8?B?b2E1MHVUU080TGxCVENMUitFQ2NhUStvYlV3OTJicTNYK21yS09PZDZWQ21p?=
 =?utf-8?B?VWlNdmZCeU1RM3F2REovdy9IdXNUbUdCa0J5aUJSSXBwZFpuTUJ1RkxtVFUy?=
 =?utf-8?B?SnFvYWlDcXh0Zy9lODdwWW55Ti9IOHFpWExXZlcvYUFiVyszZEVzN2FKdXE2?=
 =?utf-8?B?L3hVcHEwREVQRG9XK0MrZVRHQU4ybTIvR25PcVpEU05hRlpKdWFDWDYzMk00?=
 =?utf-8?B?UDdvSEZFNFFjcmxuT1ZDY0RuK1dXZUJwU0RlY2pxM3g1MnZ2M2tVRmtFbi9E?=
 =?utf-8?B?M0JpTXBmS0ZybHdRbXZPbllSY3pQdDBWTWQ5Ym0ySzNzbVpPQThOa0dBcGpH?=
 =?utf-8?B?d0pvdm5tVStObWxjL3JBdjNGVHNZU09hN1c0QlpsdWc4eUhTeEFubnlDME82?=
 =?utf-8?Q?KGY4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df0bc7f-0f38-42fd-f2c4-08d9db1daeac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:31:18.5427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj7xcpXkuDDhEz7rTGbD+t/E9dcD7EaCBrxbCx6QSQlqdXCh7dbOx3OCoM4TgDXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 18.01.22 um 21:13 schrieb Eric Huang:
> I understand Alex's concern. I think usually we only check the version 
> when a feature is only available in a specific version, and other 
> version or newer version doesn't have.
>
> In case of FW fix, we assume the driver and FWs have to be 
> synchronous. If we have driver backward compatibility for FWs, there 
> must be a lot of redundant codes for FW version check. So this patch 
> and SDMA fix will be pushed into ROCm 5.1 release branch at the same 
> time.

Others replied as well, but just to make it clear this approach is an 
absolutely clear NAK.

Driver backward compatibility is a documented mandatory feature.

So if you already pushed this to ROCm 5.1 then please revert that ASAP.

Regards,
Christian.

>
> Regards,
> Eric

