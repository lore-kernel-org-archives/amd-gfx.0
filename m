Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D60C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 08:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A33A10EA80;
	Tue, 22 Sep 2026 08:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8oGzyFQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB82E10EAFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:39:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3HuH8qLClWe5A0I4Jo7qOQ4MppMJ8/0ZNec3efeqKuY3CTWWu6BX9Btlc7FvCDxCANz7JvG7Q8z1qAMQYzfVIFImRtv5tJgaBUepZYcd5AzQO3cLJvLxJd+yyIpOlmY7fh1+rbca88mCqQgvxV9uxE/U/5HB05NBetQXcl0Nu5zGUU6sB0UpSCQKAb5e0JAaZlkPi3GUqaRUhfwcoqfBzjIV8J63IIge2u6hl/LE7B6MUBO6IB7xeNftlESUjYQnqrEEQAnLG1sBeni19nMJzq7RKwwfLk8a84bpifj152sgzdqjtrwb4VjGJ2UAlove9ovSqJJost11MT3oH5nuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0NCIUEsnzv1gLua/Gpi24NZzJrbnx6veplH0waQPjM=;
 b=QEbPbxumtzZP9oGXuLXvgWrEaSkbJId57xZH4nVZafvlQCwCiJVdWZoMbXXYJe7P+uNzndUEyPmJA3tRrYYPpW3UwxI88Evmb95Dc541BBU0C/SDtLdPQ+DE914uElBMr6fqcqhU81Gxn6wlnu+aD3KOFazAX/WaTt4j+i7bA45+Jbe7wQzdPL6PaXVXYCHQcLhq3bnQAyJ0juJ6F8Jx0+JT0f3dZK7bjTdVMU2uCXTXt/YYjGOiK2Cnt2SdWjuttyfy1apYkA3kXILgu4KPtjGx8Uqaub6bayAfWfpH7WGzoWiVY09He4w5DkUpPo+mELwghJQOwAMKwewBercXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0NCIUEsnzv1gLua/Gpi24NZzJrbnx6veplH0waQPjM=;
 b=W8oGzyFQjo+9JuT6HMLjze20eAKdg0VUN+jo3NVZ6HVW7+4SAU9xZebgtNCclMoNDZHP5bnglPMI1OOOvbG+N/qwJnqLP/TuYZ8pZCqQ81vJR8ItOqPBDJRiCMxlJQuowBUcwyB+IxTXO7QunqPRULe1n8+gsXyJzDrnbomtlxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by CH8PR12MB820196.namprd12.prod.outlook.com (2603:10b6:610:32c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 08:39:36 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:39:36 +0000
Content-Type: multipart/alternative;
 boundary="------------kdHbJb1xKWcsr40gbRM7lio6"
Message-ID: <cbf15177-c94a-4bee-9ba2-f14b7860c4c4@amd.com>
Date: Tue, 22 Sep 2026 16:39:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>
Cc: Alexander.Deucher@amd.com, felix.kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com> <arI0hEYQbrsWVlV1@amd.com>
 <580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com>
X-ClientProxiedBy: SEWP216CA0103.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::15) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|CH8PR12MB820196:EE_
X-MS-Office365-Filtering-Correlation-Id: 64146908-660c-450d-179b-08df188508b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|4143699003|56012099006|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tW0WiZ6af2DpaUUd5YObbKybvPpI1ZEWc7E7agnsxOpUqJ2wjm81H/b0ol4gcUCITDNnfm11KH8nS3j58Zu+sGuJGzSl7tpDZJzMKBM7FxPnh0m+jADIDi0M/BALfwjvqwetksmWgscMp5HTmywAh1ufCBIi4gqwl1iql1yPZdN8Nlo4YtfMy1MF8JqCxaF+URGz0kyiOSMAp4BA6kRqYLATjWnIvWKzwiQ/Iu1E/ZxbLS24l85Jjy9NxPwDxftxUA8VqH4AdG7rDCtZe1tIFzDDCVRaLx7XZHo5Oamh/bCNjWXUuj1Z5yuXQULfUT1hdnlXpzNuCXVxiBPSkXaHszdk53eNhPK46uygq3f+hnVyKIbojTzjfHOFafsAQKhNn0bcHFrbFnRI1YskPdXrKK5Sv4uDW9CPnhyWL0vGhNkU7bmHWV7H6C8SOkpUYIymdqy09XENSg4iL/VZQOgsRnNcIdUifj7nWE52+0Exa2LepX4Ri7eFM/U88VzuzOzIHmrGlfMBzDpHtrn8S/qpPbdwMEdUpPv3DNBUdJo8Xz2BlN0CpvkQvMDwXlxPid4Uk8mfzlIBySLV0WPrnW/G3RzD6+NtyJqlGp5sMi44utEJ6HAKKskHxuIIqor9kzNNAfVexqp+O9hTYdkQ7UrT+WU7XDakQhLF73As8tsg0zE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlqVkJMNFREUVZRbHBhSG5mcWRrbGptZks4a29ndCtTL29XWHpQZUVSQUZS?=
 =?utf-8?B?bjYrV0cyekVnd2FQbGVnSkdabi9Tc1BqOCt5dEVPTEpLN2s2ZHJZb2NqTzV6?=
 =?utf-8?B?KzhBUEhJQmdXUWlhNVE5azhqLzRQTVkwR3BweUdlaVAxZGdSWStCVEcvQzBp?=
 =?utf-8?B?Y3hzOG9KU2t2cTZXeG1xWjJXUVZLbkxsMkdFajExMG1wTHI1empvTlMvL1B4?=
 =?utf-8?B?MDUwQTk2RzF5bEV4YWtQQlhiWFU1cVZ0S3FnL2pGMkthQlhvaytPR1J2RWFG?=
 =?utf-8?B?T01ON2lERUZuMzhCMmpCUG5iMnpqOGwyc1BQS1FkeU1RMllESmI5aXNnUDR2?=
 =?utf-8?B?alN2dXdSTFZMUnRtVUMvSUNtR1V6WFpRZEsrUFVLZXFGUUpmck02Y0RCRCs4?=
 =?utf-8?B?WGFZLzlaMHM1cllPY2ptZzhZRWp4bEJySGVNVXpPZUFLck9jUXJOYmtacXZr?=
 =?utf-8?B?ZlErYlUySFYySlF2eW1qVktPK3diMW5rTHNOOFRNUEZSUmVlcFRMSWt2SEdL?=
 =?utf-8?B?RjZPVG1Bd1J0U3A3S2RvNjRLTGlhMzJvUk5mNnkyMmZtMU5kNXExOVdqN2hx?=
 =?utf-8?B?cHkvQ2NjRXRqdXByUnZLSnJyY003Mm0ycWNPbHB4SGRQTE5CTEdUaGpsL1o5?=
 =?utf-8?B?QndzZWZVemlmWkdqcjU2VDlCVWhRTk1SNGlacnZ5dmdGWmpQSC9ybzZYR012?=
 =?utf-8?B?cy9wSVV2ejl3aThCNjF3V1ZFYWIwUnZFOENyTkQvQmdETVl6QUF2ZS9hZkRF?=
 =?utf-8?B?Mm1vK3BicjBoMCtBb2MvOURRbEl3K1JVSTF4VVFXWEh3RUFTTnA0dTcrZnZl?=
 =?utf-8?B?d3FCU3NnaGdhaFkxR2ZEV1JNVERWZWt0Z0x4WGhiMGR4MzVtV3J4eDdTSERC?=
 =?utf-8?B?d1dTZVYxcVZYWlVIeTJiMXc3R3BSSlZZaUFUTkxFSnN1YTRQQnFIdEp6RWda?=
 =?utf-8?B?eFhxMVhkNkUyRHF6ZTVSUEVVMXh0cEFwb3NsMzRtTWN1aG9lZzI3ME9qaHNX?=
 =?utf-8?B?dzV5dXIrMzIzSG52TU5oOXl0RG94WVN3ZUZ0M3c3NHljaVZLSURtVU42L0dj?=
 =?utf-8?B?a1ZHOVUwUlFyN1c1OEc0a0d1TkFHNFRoTzFscGNJUk9MdWZ3WDVIT1Zhc3V0?=
 =?utf-8?B?TVJxTjhIeTJreHFjcUk0WitxMnVBMXpNZTk2SnZISXdLb0p3ZmVQaXhHeFhF?=
 =?utf-8?B?Z3VuVzNGdjl5b1dtRkdyUWVXQXNkOTVxWEc2L25ITmk4TmErTEFOemtMWCsr?=
 =?utf-8?B?eEplTWhhcGFwYXlmbHJaQno5ZUVVVUQ0endpdXJBbzl2ZXFFMHMwL3kzVm16?=
 =?utf-8?B?dkM1YnR0N1JrOUozY0JWc0NXRm1pbWtCMmRRM2dBRGxnNlZYdEpGV1NENUd2?=
 =?utf-8?B?UGg1R0pjMmtFc3BhSEdRRmY4UkNHc3UrTGJrVCtEdkxIVUsvdzFxZ21vaUsy?=
 =?utf-8?B?NjhyMUd1dmVwWDQwWXpGTXpkcWw0VkNHODMyemFRT0EzS3h0bTJtSmx4WTZR?=
 =?utf-8?B?dTZIRDF1TlJ3dEZkWU45OXpmUm9OSzdnRmZEbHJNMWZlM1UyNHhwdG80QitQ?=
 =?utf-8?B?K3JCajFhdFN0TXVqVi9TbnRxSlJ1c2dBTHRWSWhPd3grc2pwYU1ETmJoOTkr?=
 =?utf-8?B?STUreGFYbjk5NkNBN3Z2bWFuK2d4MGxBZjh5WjJBV1RCZmEwYmRLUlQ4UlFj?=
 =?utf-8?B?NDk5dmhCdTNSOFppOG5jZThZMWZXMG5FVW5Dclk3R0wwcnpJWHVDZkdFZVFr?=
 =?utf-8?B?eFBoV2pJMUdhdE9TUVI4cWVkaHc3aC83RklRWjRkeHE2VHhiZnlVcCt1NXpN?=
 =?utf-8?B?aDB0RDJ1T2ROdDBTeW1DWG9nV3NTY1FFTHRId1dFemt6QlpFc0ZvNXZDU00w?=
 =?utf-8?B?TVZxVG1JMkY2MnRjMzVLT0tuTGNkcUV0ZDZLTERzZjJpK21TSTh2T3BFd2My?=
 =?utf-8?B?a3cwTkJNTGhYWnFva3JZZW02VDBFSnNjT2NtNXE1MHBQQXBITjE1YXNENEI0?=
 =?utf-8?B?ZzJUanBUa2tFVVl2VGMyRG5haWtnZHlrQlVFWExWaSsvME8yL1NMMFNXMEVW?=
 =?utf-8?B?WGZPMGpyMWdNcWFpMkRkTGxKS05BZXlrckl0NWcva21QUnRGYWZKbXV4cy9a?=
 =?utf-8?B?MHdud0tMRHkreFZQL0Rva05SanduNkxENzdna2JTVW5mcUNzUFo5VUlETlgy?=
 =?utf-8?B?R2FoTk5nYmd3Z1ZkMk5OeHAxZDBJVjJRMkgzSG80dXpPUS9ZY1lSOWIwWEs5?=
 =?utf-8?B?ZldsRW51TFJxWlcxeGRNOENBMzlxZFhWSXg4MG9iTzRTYVJyUVl4L1BNWnVP?=
 =?utf-8?Q?Ucs4FLRWu43WL3zAm0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64146908-660c-450d-179b-08df188508b3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:39:36.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6j+6vqQzOyBseSp8VQ5uPsAeLuVKJGbo5vsvvkr+Fr/xZrtnkExag6FOXpca/BC7y8Wc0iljFweRhDGDYZMgfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB820196
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

--------------kdHbJb1xKWcsr40gbRM7lio6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/2026 4:04 PM, Christian König wrote:

> On 9/22/26 09:55, Huang Rui wrote:
> ...
>>> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.
>>>
>> Assuming every kref_get() has a matching kref_put(), and the queue object
>> itself does not participate in a circular ownership chain, I don't
>> immediately see how taking a temporary queue reference would cause
>> correctness issues.
> The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.

why only IOCTL???? Since the kref has been embedded in the struct user queue, it should keep the queue alive during ANY OPERATIONS, Not only IOCTL.
Or it will race with the destruction callback in kref_put, and causing UAF problems.

Do you see any kernel documents says that kref should only be used in ioctl contexts? 

>
> It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.
>
> This is just standard refcounting rules to keep objects alive during an IOCTL.
Where do you see such standard? It is just a atomic number, not a lock. 
>> Could you please point us to the historical issue or the corresponding
>> commits that led to removing this approach previously?
> See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.
>
> I don't remember if it was actually committed or if we only discussed that on the mailing list.
>
> Regards,
> Christian.
>
>> Thanks,
>> Ray
--------------kdHbJb1xKWcsr40gbRM7lio6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/22/2026 4:04 PM, Christian König wrote:</pre>
    <blockquote type="cite" cite="mid:580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com">
      <pre wrap="" class="moz-quote-pre">On 9/22/26 09:55, Huang Rui wrote:
...
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Assuming every kref_get() has a matching kref_put(), and the queue object
itself does not participate in a circular ownership chain, I don't
immediately see how taking a temporary queue reference would cause
correctness issues.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The reference on the user queue object is meant to keep it alive for the duration of IOCTLs, e.g. prevent concurrent destruction from the close IOCTL.</pre>
    </blockquote>
    <pre>why only IOCTL???? Since the kref has been embedded in the struct user queue, it should keep the queue alive during ANY OPERATIONS, Not only IOCTL.
Or it will race with the destruction callback in kref_put, and causing UAF problems.

Do you see any kernel documents says that kref should only be used in ioctl contexts? </pre>
    <blockquote type="cite" cite="mid:580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com">
      <pre wrap="" class="moz-quote-pre">

It CAN'T be used to grab references from either atomic, interrupt or worker context since then you can't drop the reference any more without risking destruction from non IOCTL context which in turn causes tons of lifetime problems.

This is just standard refcounting rules to keep objects alive during an IOCTL.</pre>
    </blockquote>
    Where do you see such standard? It is just a atomic number, not a
    lock.&nbsp;
    <blockquote type="cite" cite="mid:580d3ecd-57f0-4b4e-8631-5c27f69ddd54@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Could you please point us to the historical issue or the corresponding
commits that led to removing this approach previously?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
See Sunils original approach, he made exactly the same mistake and I already had to fix that back then.

I don't remember if it was actually committed or if we only discussed that on the mailing list.

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Thanks,
Ray
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------kdHbJb1xKWcsr40gbRM7lio6--
