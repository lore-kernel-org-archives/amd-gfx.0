Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF86C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC9561248
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 12:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CC9561248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B025289A86;
	Tue, 24 Aug 2021 12:07:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA3589A86
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 12:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nspOSVsWOolWfPPjwXdSu0EkangL5U1beMKPaARzb7k9UjwEzD9+ChzxH0jqcJu7aT9tTVeVjURoS9eoY/Rk+o7ejCawoMN4JwH5T2YXaYdtgbmpekCyAo/gLvam2aM/LqPyg8w1JQDkxQIZyPy+fGh3+5oMoXCS7I4Ad63uAXvHEdeErl8eOVHS2UDsG85oycEecj5nVaDbiHOOfGvNl3eAQgxkOH66MfWp8m+htMClTpJkYnwy0r9AWYOqewgTwPThMFRjLrgXIQXzihkoGut9a/LhCaZIwmjxKN7ZEX5QZSZKQPC/sCVPkEkwi7u5BNiR59oDApEnYMb0djXyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS+xwdzVwkFvofXB60LXOjJxv1QSBqcHiZw6HFfwvMA=;
 b=Bjvx6EBM5bVVk5iMlyBZbMbR2caXeApzLSuREGdFSu23gZAhXwHIGip8XUv8fzIfWyjezDHwHXxjzGdg7eW7lkguLw0Eykq9PyrLnR93IU0EhJkZITFg0Tvwprujp1xH02UQkJ8xHh+M/8BWeZoQEkLGXpOQLeM40MdIzMUtn9FfV50w8cX/2IQQX2kIW4vuhTMkE1Krjmm7g+LKb59Ml6ClRgxf3OeFndr+gYDlNOJyNsj/fPGEKfKcArLslRcVsVTF3sXHA1cTBdEem7M5ezc8nNE9YOgmJZb9OzbSannxyKZXSHXNPMpvirmyZn+LMdGadVHyIvrvBoWUD7dMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS+xwdzVwkFvofXB60LXOjJxv1QSBqcHiZw6HFfwvMA=;
 b=YCgXb33w4ke7wP63UbsVfwESukMCxo+wWSl4LR2R0kxM/pg/T2SidOawv/BG/wvjkQhml2pmlMYXFtQcRc8vVpzdXlY0eIZPugDYtegaK5mNBbdA66x3ah1PHD26ZLWit6JYK1AAS5DIwilh3sWHoAcPknDhCBQune3RHiNK54k=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 12:07:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 12:07:42 +0000
Subject: Re: [PATCH 1/5] drm/sched:add new priority level
To: "Das, Nirmoy" <nirmoy.das@amd.com>, Satyajit Sahu
 <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <66607af7-5310-629f-1851-df4b74cebf7d@amd.com>
 <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <49509444-2e27-86e6-abe5-8a44dedc0f10@amd.com>
Date: Tue, 24 Aug 2021 14:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <4e2337a6-8d76-49ba-c0b3-e89f4c04b4a0@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P193CA0020.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM9P193CA0020.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 12:07:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a04b04c-5f8e-4724-d200-08d966f7c645
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913AF478EAB92A169D0CCA383C59@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkVTpFDkPC6LuarW8fOlOhepmPq9LoCMD+QX9fU+tBNwpGSGKzkMZWHyNJuXcN9vE9/JUZQ64RUMAAPKka8xnxInr7QBfuF8moWf3xHehr2L5jatQdecNuaLldg0zeIECH/NX0efzKucLW6G7H0fwWgKZ1Tn8mvtcspNO3dyFSRL7PgJ7jVta7ElaaguAjCk5f6pXmCCBqORWWCLhJw9pPJudV/yp/bSi3lOZE1uHAGAARrz0xOtjBysZuKBZE5IG5qWmCBdvW6paeULOwkZoqUAdM7DWvuJbB0KEukz2uBsizMjoA0vO74Bh2TGnWJPtFSiYh4oe2tqHEZ3JwTEQZ/n7zFxeC3TqI9VLZqqJwdswMEgqFNk5yPZ7V7QEcm4qt0Z/QQOMqZgFbzt75InluGp2OpKKcQNzLLa/ZSsKqfrMb9CNyH50Wh40PUQXh4fd8Nl1O2jBG/rWHllJADMDE8Qd48J1ldqg+zpOQ4zJxlk2lb4VV9GYMzSGZhM56PVYYTO0hzbRyJapzdL0BABQM02QYVv/yC36qOv304W1G1gfw/ptrkDEpUCSDR8k7BrKG8HexPP/V1fCI/M4+pCfBT0hkeCNjOlTVBQEOHNGTyHC/ayY+UyIaKnc8x9bC5aY0skRPc4xUfPsSRjI3R787PvCvkYDSu10p7NxtmekxsHl58EMYs3Z52gWFhh6ctMskwOGQ+ySx9GljH6ngWjr62RKdOTv7gLE/OdDPokuSk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(26005)(36756003)(31686004)(186003)(110136005)(86362001)(6666004)(4326008)(16576012)(316002)(31696002)(508600001)(8676002)(5660300002)(38100700002)(6486002)(66946007)(66476007)(2906002)(66556008)(2616005)(956004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NKZWZ1UFpJMjRxNVBqSmRyRWpZTEhaeSt3Zm1nMHczQjVhQ1NoTFgzSVhW?=
 =?utf-8?B?dnp3UXN0U0h4aE1ieHEvR0VzWmJGNzVsV0orWS92RkkyOU50YkRHQk9mS0tE?=
 =?utf-8?B?aEFvbEZRUjR3MGF0YWRaeHRyTDJ0R0pyTFNqU2NONWxoV1h3THhxeHhzaldU?=
 =?utf-8?B?Y2FtOE56OWhwcldCUnZSc0o4cWxWRmdNUHl4clp6ZVhobHFuNW55UkpscTVF?=
 =?utf-8?B?R09uekwvTmpLOS9pZXZQNTVpd3pwMkZRZG9yS1QvcTRVbWZRQ3Z4QmI0RnV0?=
 =?utf-8?B?TWl2a05MMU96SExrb3ZQMUxmd2t6ekIvRG5wVjZQY2ZlUlEyRytNRU55cGth?=
 =?utf-8?B?bFVibXEydHA4YVhPdGZrQ2tFZXlyVFFXcGtNVk1XbWI3WHdMbnJkcWMwQ2ti?=
 =?utf-8?B?S3BzOGtwWWlvd3RPcUczRTgzb1B5bEVYS1djK010STNDUW1za1FNM0VtdUpm?=
 =?utf-8?B?aEkwT2tRRCtpM3pTdGdtMXBJU3N3Ymh4M2FJWTd2OURLM2dNSWdUVGQvVk84?=
 =?utf-8?B?NWNrWDBlVTVuZTRQMElGMXgvNnZiYjlkTzQ0NWZiZWk1YmFMTlUrUVlvYlAx?=
 =?utf-8?B?ZFMvdVJLcG1VUG9YR0VROEp5OGhORXIyeURWRWUxYnNCSnNNUDZOQjFHamRz?=
 =?utf-8?B?MkgrQ3R6UG9tUDI2SmpPK1lzU3ZHdzFPUSt1MExpU3BpK1FxaklZeS9wazZr?=
 =?utf-8?B?VnVOM3MrNFJsWGNoQ3VHM1BMbVBnWndNS1RZZHcyeUZRNDl0Yy9ES2w2ajRP?=
 =?utf-8?B?dE00TXFsNXJMMTlIcmF6Mzd2elZzc2NESXdzeWZvNWptZGtybitoenE5MDBn?=
 =?utf-8?B?Vlhjb2R2VUxwY0xUN0dsWjNXOXVZWCt2dVJRbVZNamtlYnJSOUhOTTJacXRK?=
 =?utf-8?B?cXY4a2tGTitaMm5lOWk2SkdKNnNNU0RUbTdvM01teWNNdnM5bjU0NS9zMXp2?=
 =?utf-8?B?TDFuTUdIRTdLYXhlZjdrUTdRaFZjbGlvTHNwbmVaVmYvdWcrY0pxM1lYc0Y0?=
 =?utf-8?B?ZHFHd2QxNzVIQ0VwMFJZQ0VnVFFSbDcvZXJMLzFxLzNDaEM1ZUlFRnE2S0xD?=
 =?utf-8?B?cWpsL0F6R29XOTMra3huUVZFN1VTWGltMUoxKzloTVJoVmtEaTJ4bDltM1dm?=
 =?utf-8?B?bjNzSDdONVIvTXBZQ2JNQWVLcmpFT3NiQXFZT2QzRitMNUJkN3pOREZiU0RU?=
 =?utf-8?B?TlFpektLc2hXclg0ZzhucUMrSFpHSVRFQkoxZ3JqZHA5Nks0ZUd6cXcvWndU?=
 =?utf-8?B?bzlucTlRWlR1bEd6akdZN0MxRTcxa2NBaUJMRVRxeklqMXFNdjg4RmRoNnMv?=
 =?utf-8?B?MzZkOGR1VnZCTVV3UEljdk9WMjRHNDZYVFZwUEZqTnk1aXVUekNub1ZNZEJL?=
 =?utf-8?B?WWJEYWI5UXZMSVVSbmYxZGt4dGEwQ0prdHdMVjUzM3hmenhVbXJGN1Y0L3M0?=
 =?utf-8?B?YzZFZ0pmU1hYSlFQcDBsa2d5RWJHMlFmRXNJejNDQmcybEJBOXhEZmtYT0h0?=
 =?utf-8?B?STNPa2NwT1NjbkNqRnFFK1Uva2ZpTzJzbUpvZ2dsRHNJbTlNKy82aTFGQ3Fz?=
 =?utf-8?B?QVhOemJYa1pYM3pha1BZUGpIaTh6RWRpWUVzKzZ6YjVGTC9NYTRUY0p0eEM0?=
 =?utf-8?B?TWgwQkFnaXNvUzRqcHdoWVlvVUl6VDFZNVNiQmJ4bmd2RDBpa3lYMkJLbHho?=
 =?utf-8?B?am1WUENmWlp1dGJHTmU2RUo5b3ZpU3Bic2ZFWWZHemlZMGxLMWY5M0ZnejN4?=
 =?utf-8?Q?8S+49uSY6RYrMqdqm2bfD4ZRNemwQqRMybWkhfr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a04b04c-5f8e-4724-d200-08d966f7c645
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 12:07:42.1184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvfNPZGcQuQkKUSQ49NKkoUjngoAS7A3aoOQbl8LYPmlBKkCpDDxSevKv9HGcpj3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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

Am 24.08.21 um 13:57 schrieb Das, Nirmoy:
> Hi Christian,
>
> On 8/24/2021 8:10 AM, Christian König wrote:
>> I haven't followed the previous discussion, but that looks like this 
>> change is based on a misunderstanding.
>
>
> In previous discussion I sort of suggested to have new DRM prio as I 
> didn't see any other way to map priority provided by the userspace to 
> this new 3rd hw priority.
>
> Do you think we should use other information from userspace like queue 
> id to determine hardware priority ?

If I'm not completely mistaken we have dropped the concept of exposing 
multiple queues/instances completely.

What we should probably do is to use the (cleaned up) UAPI enum for 
init_priority and override_priority instead of the drm scheduler enums.

Regards,
Christian.

>
>
> Regards,
>
> Nirmoy
>
>>
>> Those here are the software priorities used in the scheduler, but 
>> what you are working on are the hardware priorities.
>>
>> That are two completely different things which we shouldn't mix up.
>>
>> Regards,
>> Christian.
>>
>> Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
>>> Adding a new priority level DRM_SCHED_PRIORITY_VERY_HIGH
>>>
>>> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
>>> ---
>>>   include/drm/gpu_scheduler.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
>>> index d18af49fd009..d0e5e234da5f 100644
>>> --- a/include/drm/gpu_scheduler.h
>>> +++ b/include/drm/gpu_scheduler.h
>>> @@ -40,6 +40,7 @@ enum drm_sched_priority {
>>>       DRM_SCHED_PRIORITY_MIN,
>>>       DRM_SCHED_PRIORITY_NORMAL,
>>>       DRM_SCHED_PRIORITY_HIGH,
>>> +    DRM_SCHED_PRIORITY_VERY_HIGH,
>>>       DRM_SCHED_PRIORITY_KERNEL,
>>>         DRM_SCHED_PRIORITY_COUNT,
>>

