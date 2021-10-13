Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 08:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE1160C40
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 08:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CE1160C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138DB6E0AD;
	Wed, 13 Oct 2021 08:07:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695C26E0AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 08:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLqwJhvNSnVSIS4Ii92WNtaTyXWkpXRx55maQnUb1AkAElKwbaMonGgHldV7/ubfyowz+tx6HAGcoveU+J/AiqqmLwEnCptzLp6LrA8Csc+/VXL1l1D2NBEMTdGdSyxgsS4B5tcNIyk9TGF5H/CwyvxRJBkGpiwg/xAPUkGYDiTwdTgOZLfWOA6FVScE8FW9p/vSmhp3yHWDCtvweIYwVu7rjv+MrS4zrviqoLDeTZ2qrUYvukv7Yw76F5eubQaW3Eg465YQ7L+YQTAkbFfAO7cLC3vlFLl0PjyRBxyAUzNde7qWODsQJa1fXyMcmhCmHq/yO4qwiNkJDtxmdiDVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ncdCf/or7ocjgSG4fjW8VkVd09CpG8hzcjv7xWk7B8=;
 b=Omv1IZLb8Odf2f2z3JQkicmQxHDhMWiGjqQqnSNeiHtk2O9NLmPnmX957EHc8iQnh79rjxMIGHvBzBRy+AiF5qvADthA8ZRjqsaM0zXwAuHAXWIaK8KwVGN9Q2SbkrP+XlP5G611BFZXiEyWeEgz41d1qdmazLbvn5HB1e3H8534z9aj/+6QdY3JMstjO2GcwEvcIwPyJfydVs7aAutr3s5DrI+CjzrzrH4ymTr6wRD1BLT7Us5rR1Mrh/4dl1PrQ/xqK3EMSsA4yZ3js93LOY+d3Tuwmcw7vXzHS5fJqNtae80pZKygBO/Y0IPqIeDiqE/GyLml+xgwGEOOX7FuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ncdCf/or7ocjgSG4fjW8VkVd09CpG8hzcjv7xWk7B8=;
 b=UH4dhNZxWhzL6JheQQY9XxmHl5alJynxx40mKog5yd6Sh3nu35dYi21KJ6BqUgFqgZsgOIJJ0brn2nbY7N93EJKP6wtZiRG5trKYItqRhHu9qC/UV8/q+9vZ+FttoKC7Eg7xfS0mPWkFzeQ4RlbviSxLSeOSNomfxqESZmqMnmM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 08:07:02 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:07:02 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a __user pointer dereference in
 create_signal_event
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20211013073334.987240-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <8b450b74-0e16-5527-f50c-1490d20d62e4@amd.com>
Date: Wed, 13 Oct 2021 13:36:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211013073334.987240-1-lang.yu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::30) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0044.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Wed, 13 Oct 2021 08:06:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf33fec8-977e-48e9-a516-08d98e207039
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2603786F39D338698FF6C84397B79@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64mzFFC0JvGFblxV+X8dOeXGByVieZfFxD4tLvFJ2L+cE0l8UDBeD8iyaz799LpxEfjJV5vtgmqoBPz2ABk/IEq4mrzQUIIwlUNvitofXicgyJcT/6qyRTR8ihxU3kYDopMpvWzqykyYzoBHPCdG2nQeEwH4Nenf6mK0XHxFgp7XkGZsOOOMzVp8HZb4QOmqu9cYCzY2u/6wtXUl65kfgt4dkfW4C53Pp4Mz7K4br2fyGt77D8/K5269sFo6wKFvTmQYXjXtZTUMM+QjeQ03meeTUWuJNE2tWHD0D1vpm7O9e1nlrAwPP0OVFkjLpNW/l7eoW2+K7LWldPVq9M4gYPTvBKELQPof4qol/ghiZ2Gdjq7i3MUI2AyZSXaPvZt2rPyetkS1Rk/Z+o23W02+VC2fFmSV2//60kq6qHerfeqRE8tMcmhHGBZcAGKsUdhZsxKvP59wsWd7MhN4SDB1NalJFCOluJfRodo9H35kjU727JY9MN855yRkujLUHN5iW+0WkM/7khIM5rqaOcw3OhivxbgjIa4LRXwBt2EQUQVwc5CW+8F4Km2Belcv4e166Qp+XRS8h3cVabGyV6AmV+LEd4pCG9AQ3oZOyWRpNkGpPqdGLc/DgLuvlsXTHsbPCSVKkvyN4PDDioCXJMFClHyCVtM7SkndOe4TNt0TOw+0V/1qHuwqf8elDSffb1Y1qXBqW5Da0M/NvNjOVvKhlpOWq0/eFLJfDQf7yXvfxyCQU/TQxO2kJzqRcAZ6dQ49P71bpJvajXRChkX2OAh0DUFTlej6qD2J9N7L5+rdgd6nN0LZE9e9o5HHofC9y1AF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(26005)(2616005)(186003)(508600001)(966005)(4326008)(36756003)(8936002)(53546011)(83380400001)(8676002)(38100700002)(316002)(6636002)(5660300002)(956004)(6486002)(66946007)(110136005)(6666004)(86362001)(66556008)(31696002)(66476007)(31686004)(2906002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzN0SnRQK3p2S2VDWExoZG1tUk1SNW56ZGQrRW95aUpTeXMybDljMTJsdjVs?=
 =?utf-8?B?eXJjYUtWaUUwdWJ1RTUxMDRoeGNSWTR2N09WMkY0WkpQV0lJZFlBU2FuK2tu?=
 =?utf-8?B?NDhDY21aRWVnZTVsU3hIZGQ3RXNiRHMzTTZJeHlodnNqcDEycUduY0ZFOHBq?=
 =?utf-8?B?TW9EZjduQmxCVHpyc21PZmwzcWNLazFNVXU2dXh2OFRSL0NPTjdhcllNREFL?=
 =?utf-8?B?TkN1K1JNTTBxRGNHZlZMSHZyNkJJcUV4R1dydy9CYlR6eWJtc050OVFVdS96?=
 =?utf-8?B?TWdRanVJcGZkQ1hEaTZDY2F2RktYNWZ1cG9TTTlaekdHcEQrSnAvZHM3WmQy?=
 =?utf-8?B?QlFTdmRiVGpGWnNvYUxDSS9mTnRZbFBkZEJGNnNtaUUyQnMwVENWVWFyUkJp?=
 =?utf-8?B?WSt4VXhpRUZqcnV5ZDYxcXdFbzdnVkVNZnE2ZjJEc3hwUHgycVQ2REI3RHg3?=
 =?utf-8?B?cEc2ZVlPL2trL3h5aEp2SmdqbnNlWElYaHAzVVdwQysvMHdFSFdtVWdWdjg4?=
 =?utf-8?B?OWVaZWZUL1BMUXpiVVdqZ2VBZFlTK0VKakViWHpNK2NlT1VYY1lXaXRVcjNK?=
 =?utf-8?B?OHFtMlB6aXY4akgraGJWN2ZXK3N2T2VhSEVTSmhlZ1ZkWmJUZ1ZHWHF4QWZv?=
 =?utf-8?B?cUxkL2pmWnZJT3BuT2NrVlpFcFZpdTdPRmtJdWFGWnFyVlhDbnoyc1Fhek9H?=
 =?utf-8?B?eHpEVU9LSlpJVWpQblZFK1l3b2VlSE53SDJKSHI1NTVzUGhxejFkMFhkeVpG?=
 =?utf-8?B?YkxDRDRHVEFzRzc5alRsb1hFbklXVFBTOUl5aW9XekFubDNXM0Z6V2RSZHFC?=
 =?utf-8?B?dXhXQk93WVlucU5OVGdiUEc3ZXZ6N1I4N2RCNWUzWS9nWGNSSzNRYlNPTFVD?=
 =?utf-8?B?YythckxmcXdseUFGV2lsb2FUYVRMYmtjZmtIYTFOVFZQZFhGTXJBTkJNZkxX?=
 =?utf-8?B?YURpS3pPamN3MGwvQldya3QyakVmYkhnOGw1aCtTMjcxVkNTaTk1S0pSR0V5?=
 =?utf-8?B?djRpa0pnUTh6TlFJWHVJT1ZTVjRBTUV6TnowaS96cURFUEF1QjhueFlNYXRW?=
 =?utf-8?B?c3NydjFtcVRlcmdsaDNSSWdnTXJCNUVGdzdLbTBQR3RFK2h0dmRhZmg0NFhS?=
 =?utf-8?B?TW5vTGd2QnlMYXFFNktZNWRRQnYwUFhzajRxTndtRHFMVERYVkVocUFjOTMx?=
 =?utf-8?B?cW93dkd6Z2IxbEkvTHpHcmpCZ2N5cWJ6eEV3WEtVK29BakhLVkhUZUlIazY0?=
 =?utf-8?B?MXhtM0dyMVJSeVRia21hWXFtVTNWYmczd0JMVTdXSDYrclVUNWtKd1RmMzJH?=
 =?utf-8?B?VW1NbkNiQkNPWlc1MWsrb2dGOG82WVVoUXR2WnhGRUIrcTJTdnFwbkprNUQz?=
 =?utf-8?B?TDZGQ3JtRmFJd3dRTWdFQ3NEaFRVUUQ3TWhoeDZGRmt6RzlyYUF4b0hzYTd0?=
 =?utf-8?B?bDd2RXBBWTRwMENpK2F2V0x4eEs5SGZaT0F1L2JJWjhKbVB6bEpKaWtwWlNB?=
 =?utf-8?B?RkpzLzlrV1Vnd1Q2N0ZmWmhUY3JYTXhiSDlvU3dyakhoTWNFVVJKcUl6a3Ri?=
 =?utf-8?B?Y3BWa253UXRSR3BXNTc2ZHNwYlV2bFFGeGphZ1g5bUVreDhmMUk3RDIzaHQy?=
 =?utf-8?B?NER0RjZpR1hXOTZLMlF4OTV5QW1PT1ppU0J1YWZnRVoxN0xwRVlBcWx2VGdv?=
 =?utf-8?B?bzkwaVFZTUY5aVpZZTl6Mm04S0ZzVkV6N1R4eDhtL0phSnlHaVZTRlF1SnJI?=
 =?utf-8?Q?jUt3PWCuifpzPtWzZQVpDj2tKXH9PPRbV7rw+cB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf33fec8-977e-48e9-a516-08d98e207039
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 08:07:02.3918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bhfi5vwJ1+G0T/OiNBiJ4vz4+dWBPt1E/c6OI9srHBBOvcdzPXaNCftivz7rDjTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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



On 10/13/2021 1:03 PM, Lang Yu wrote:
> We should not dereference __user pointers directly.
> https://yarchive.net/comp/linux/user_pointers.html
> 
> Fixes: 482f07775cf5
> ("drm/amdkfd: Simplify event ID and signal slot management")
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 3eea4edee355..74d3bdcfe341 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -201,7 +201,7 @@ static int create_signal_event(struct file *devkfd,
>   
>   	p->signal_event_count++;
>   
> -	ev->user_signal_address = &p->signal_page->user_address[ev->event_id];

This is interesting. I thought this wouldn't dereference.

See here -

https://en.cppreference.com/w/c/language/operator_member_access

"If the operand is an array index expression, no action is taken other 
than the array-to-pointer conversion and the addition, so &a[N] is valid 
for an array of size N (obtaining a pointer one past the end is okay, 
dereferencing it is not, but dereference cancels out in this expression)"

Thanks,
Lijo


> +	ev->user_signal_address = p->signal_page->user_address + ev->event_id;
>   	pr_debug("Signal event number %zu created with id %d, address %p\n",
>   			p->signal_event_count, ev->event_id,
>   			ev->user_signal_address);
> 
