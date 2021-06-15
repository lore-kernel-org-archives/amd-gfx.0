Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26AFC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C32461584
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 15:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32461584
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066A889E7B;
	Tue, 15 Jun 2021 15:06:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D418189E7B;
 Tue, 15 Jun 2021 15:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARqU6p/fQUNhd8j4mvJbgifj8MJ+ouik97fXN48qO9pBBkXz2pni8FVVOWW6ZujyxyRbH9SeBHLdZMH1vJgxKwE3hclzgJXhSxn+s/dR0IMPC1KF7RFIk8tc6FLAxQiYZRFWI+42KQW9Y7kqAwelPu5sXFhq2/uIXIqQA0nL+12Cn02NK2MXHrBN4lYyXbuBxxc2LbwTsocmq1TqbguVzDj2dC9k55vuVgb9USFGwA01wxz+hOHrp6p4v8bjWZNAb1ukl1WR+yAy9wGh4JeaoeG8wblKBCO1HvD8gLdAZleRIGqFmxhvObN7oNz3/ErE6VjNK3Bnzln0P0vorRkTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kNEazOZBEll4JajZbiJuKfz9UXuPDMEAOb/fAHucFk=;
 b=OnQ5yoUphGD4mG6pXclAHG8M9Uxq24gC1N5QB0ynbtW4JmCHa8U3xcaqlPYL0Bux1NFnaZLuVJ6JIkHnCe9qWXJQ/aZL+tp2h2/jynzjBXbd3Jpi2rR99txvnnR19KxWnJGt5f5+KPmXc4cltXCZVHtdCkm4jOPBKwc1xoiK8U6iAccItx5ZjsiSivMZtNg2oacWWhsTUKY+Que/JMEENoInEyzcFoq2+3+IjrRdbsOY55rGjJPGMEKvd5O9ZViCX9pe1AtDIxWoco2EEf6Di/FeO85fWJV4acqzPBMa0dkaW3wqPG0FWvhJPIB5FZ0ZWOWc0EBlZxQuSGcFx4EE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kNEazOZBEll4JajZbiJuKfz9UXuPDMEAOb/fAHucFk=;
 b=IWtUJ5jf73bNEbHOQ+cs3XQ/aod6EqkkGktuY7bmU/5vpxXJYY+YCbpHLvJZUPlx/R38m34sepiMmxnGZRDGQFN57XORAu6qfegv0N05PER6ALU7wCcrW6238BMzUEGzmw/xqEOordDwSqL1XB7URx+sLj0wRC7jObzYGiLPETs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Tue, 15 Jun
 2021 15:06:05 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:06:05 +0000
Subject: Re: [RFC PATCH] drm/ttm: Do page counting after populate callback
 succeed
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20210615115746.27424-1-xinhui.pan@amd.com>
 <f70e88b3-f0db-fca8-f05e-f685f1a913ad@gmail.com>
 <4719A30A-0B23-4053-B8EB-AC9BD21DBE40@amd.com>
 <88115e0c-5cee-5b16-f60f-480136f0bcad@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <da147e95-e59b-3f38-2ba2-9f4447f7ea86@amd.com>
Date: Tue, 15 Jun 2021 11:06:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <88115e0c-5cee-5b16-f60f-480136f0bcad@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.203.225]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.203.225) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 15:06:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48489216-cd7b-4e82-d881-08d9300f18de
X-MS-TrafficTypeDiagnostic: BN9PR12MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB511673A837541AB8A5EC8F5792309@BN9PR12MB5116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kA007wykb2hBw1zsySK5G+gS+/zPSM6D8X+WesNhokmKa9n/BTL0/fp8B15dg5/IJRvgR0LtbX2cVZbLji1Fd8iD5A6VRUg1IAmZy8XSBbKujpwwXlNdowl+GrhuTw0bDTRGsOMXaE1UAHhgO5SBh3OP7eOQwBS9rHfd9LSV5QtOjU3ya16RDbQWZcxQmix/FqI/ZwkNQFmR1aZDqHAO7QbwPtjY+ErlJHZqf0HosA+Zhdo8d1tXyjgs5rjUMarrwQAdP1tHuu3D1ELEUjqt6pAALrw9TRv+3wuFH/jYlwzw0bIEz1DN1Sh02kIw8McxktLd62A3DEVIjDdODMCROsobKasCaQhSFoLdvLkN5rxNCQucH+BzlgL9ESje5njugo8nX3iSL/6FpICmLqyW0F/nyNVezAaMW0IB6zof5+oWncG4AblSOtAHxLVOCwz+S0+9V1tRZ0aJwySm14GbP742bpJhxB6WBED9zZsxnQP8w50U3xwm6URSFG/bPRanqIBr/+HrFqO9Ktn7OYohy3k6DPDMS9DrIX1jNlLOmztxnz/xGV5Hg28lp3Y+hLdraHfUXw6hih2OAQzQdvjIGTU2N199M/0u2UISHrdNoSZAwkzVoU6y6c1QmLuGCMDNkftu1U/XVh5Zw0ZDGVmbUx64KT+Z013qbskWXNjmXnFKuaxqW26CV74ZMTgToJq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66476007)(66556008)(8936002)(2906002)(86362001)(8676002)(44832011)(16526019)(38100700002)(478600001)(186003)(4326008)(66574015)(83380400001)(110136005)(54906003)(5660300002)(956004)(31696002)(26005)(316002)(16576012)(6486002)(36756003)(31686004)(66946007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFkvSzhuVnZNRDdBNy9mMlRpRlNrUjhFQUk2Vm1tYml5biswSXg1Q2luaFpJ?=
 =?utf-8?B?UEFJNERCQ3VqdmszTkViaUdkUGkzQk54WmgvbzNzd3RMWC9ucllIaHB1MjZw?=
 =?utf-8?B?N2V2R3VXeXFuZkJkSi8wbHZUZUt0ZVJtWldCbnBheGNWV2RpNXloVTN0Nnph?=
 =?utf-8?B?ZUxhMXVZTWYvalJScThQQTB6L1VWTEwwZzNteDNwalFHakRPdzZEZTR2SDVi?=
 =?utf-8?B?MUdXS2hWNFU0RHh3cW1FbDFnMndvL2E3R1JRTVg4bUlHb2hZYlllZzkzRlYz?=
 =?utf-8?B?LzZINTJsQ1pHbWIzL3F1OUVISzFWR0VPVDYxMmlFc0g2YmhtSmNueE1KTnM5?=
 =?utf-8?B?a1FNcnR5bGo2UnVkUG00VnMwK3RZUWZoZjhScXk2azcvUE9nSGh5Y21QUlFR?=
 =?utf-8?B?UnNhTDBaSlZvRWlreThTc25tQnJ6SDFtMmU0YThqNVh6WWdQdkY3d1NqelBT?=
 =?utf-8?B?Tm9jREpIQ3ptRnBCT0R6bmhxRzMrUStkc2Y4TVRleHZ3L0ZLRWdibzc0TGtX?=
 =?utf-8?B?Q3Vtakl2MDhCYWphTURpK2l4b3RkNThhcGJsZ1B5Q1RRY2p5anp5a0xMeHJq?=
 =?utf-8?B?dyt2bENDcXRkV29IT3hCTE9RZjFCa3BpOU9XR2FnL2MwcE96YkplOVFpVUN0?=
 =?utf-8?B?R0RSYmhOc3ZyaUQreWNyb1kxbE81bWdpMXN3aFVQcjU2RmNsMVUvODBXem9N?=
 =?utf-8?B?WlZOaitFeVp0Q0k1ejZra2w3VU13bERrL1VIYUN2KzdnbThKVnNpS1JPRnJJ?=
 =?utf-8?B?aUpGaXpNYXNRMnBIYU8xMW85VkwvYnNtYmcydG50VTFMSyt2R1VkL2QyWUZG?=
 =?utf-8?B?QXhnTWxwV0JzczY2elU4ZDIwbGZVenYwS0sxL1dQU1RwSFFvb1Q0dW8rVzJP?=
 =?utf-8?B?Q1JFRFV6Z0tuaWRJcnQ3eDV1dWtZMmU4b3lmdU1COGs5K3VKVnd4ckxQVW0r?=
 =?utf-8?B?QzZyWnp1VjFQaU1VVkJmeUNnYk1OL05nMG1teTJXNkhzcEp6MWpGTTU3QlRa?=
 =?utf-8?B?dHRzSmpnK1ZVQ2FnTFdQci9SVUtMQUgvZmdra1V4M2djMFR1NXUxR0xINjEx?=
 =?utf-8?B?cmdzdHlVa2czN3pBMUdIRDVjaTNpVlZkUTRZN0lIUlU0dUJNNUdwZkRuK0Y1?=
 =?utf-8?B?SHlHYzRHcTRKRWE0WkVIVURJRnN1UkoraUFSUUhZMGREMUx1dS8yYTJ5SVRJ?=
 =?utf-8?B?cU53T2c4QWdqTDY1UUttOWFEZ2VBcU9oT1AwNFJVeWxXL096eW4xQU1XWnd4?=
 =?utf-8?B?bUlLQit5ZEtjNGZKQkVsenNwT3M4bEJkUkJDWDg0bldRU1Bvc2FyTVNmem40?=
 =?utf-8?B?ZW1naE5FN2RndDRsNGJFZVYza3hlc25IcldWelEyQnh0L0JqQXd2Skt1UWRi?=
 =?utf-8?B?YkQ1RWtLajA0S2xwVzFxUXM2WHZYYkVpZWdyTi80d2YvRmFhTS9heklOVy9V?=
 =?utf-8?B?YTZNWlYzTUQxQjZ1c1UyZm9sNS83K1liblR1aWRBUjdWNWNBR2owbitINzNE?=
 =?utf-8?B?RzgzdTltOHBKS3JIbGpGRjlEZEJVcmUwL3ZNbzRrOWZXdEhFNUpzajBScjVV?=
 =?utf-8?B?L09uZFo1NXlwbzArQ0laY1h2S0RqL0R0eXNnbU14b2ZWcFpkTGt2MEc3Ty9G?=
 =?utf-8?B?YTNERjJLR1pVSHVkcW1McmtJUjk2bnc3eHhFbmFmTitsb3h5V00xaHgyazV1?=
 =?utf-8?B?OGN2UjJ3WWNrRE4ycWNseUVYTXZmdGtvcVo4ZlgrS3liT0tYNGRTamRaUVNK?=
 =?utf-8?Q?HOtEVrMUEpBxA0hYZcaExANhdnDAcNaWVrcS1JD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48489216-cd7b-4e82-d881-08d9300f18de
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:06:05.2503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkSruNlVDgWmerkSdCsCOLKm/qj6/ZWUlBuAm+Sml1DrvDsZ2a0zSn/XhXddU9nYqFDz/WN/IXI8GAkQTFXzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0xNSB1bSA4OjE4IGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDE1LjA2LjIxIHVtIDE0OjExIHNjaHJpZWIgUGFuLCBYaW5odWk6Cj4+PiAyMDIx5bm0NuaciDE1
5pelIDIwOjAx77yMQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFp
bC5jb20+Cj4+PiDlhpnpgZPvvJoKPj4+Cj4+PiBBbSAxNS4wNi4yMSB1bSAxMzo1NyBzY2hyaWVi
IHhpbmh1aSBwYW46Cj4+Pj4gQW1kZ3B1IHNldCBTRyBmbGFnIGluIHBvcHVsYXRlIGNhbGxiYWNr
LiBTbyBUVE0gc3RpbGwgY291bnQgcGFnZXMKPj4+PiBpbiBTRwo+Pj4+IEJPLgo+Pj4gSXQncyBw
cm9iYWJseSBiZXR0ZXIgdG8gZml4IHRoaXMgaW5zdGVhZC4gRS5nLiB3aHkgZG9lcyBhbWRncHUK
Pj4+IG1vZGlmeSB0aGUgU0cgZmxhZyBkdXJpbmcgcG9wdWxhdGUgYW5kIG5vdCBkdXJpbmcgaW5p
dGlhbCBjcmVhdGlvbj8KPj4+IFRoYXQgZG9lc24ndCBzZWVtIHRvIG1ha2Ugc2Vuc2UuCj4+IGZh
aXIgZW5vdWdoLiBMZXQgbWUgaGF2ZSBhIHRyeS4KPj4gTm8gaWRlYSB3aHkgd2Ugc2V0IFNHIGZs
YWcgaW4gcG9wdWxhdGUgeWVhcnMgYWdvLgo+Cj4gVGhhdCdzIHByZXR0eSByZWNlbnQgSUlSQy4g
RmVsaXggbW92ZWQgdGhlIGNvZGUgYXJvdW5kIGEgYml0IHRvIGZpeAo+IGFub3RoZXIgcHJvYmxl
bS4KCkkgbW92ZWQgc29tZSBjb2RlIGZyb20gcG9wdWxhdGUvdW5wb3B1bGF0ZSB0byBiYWNrZW5k
X2JpbmQvdW5iaW5kIGZvcgphdHRhY2hpbmcgYW5kIGRldGFjaGluZyBkbWFidWZzLiBJIGRpZG4n
dCBjaGFuZ2UgdGhlIHNldHRpbmcvdW5zZXR0aW5nCm9mIFNHIGZsYWdzIGZvciB1c2VycHRyIEJP
cy4gVGhhdCBnb2VzIGJhY2sgYWxsIHRoZSB3YXkgdG8gMjAxNS4KCkFzIGZhciBhcyBJIGNhbiB0
ZWxsLCB0aGlzIGlzIG5lZWRlZCBiZWNhdXNlIHVzZXJwdHIgQk9zIGFyZSBub3QgY3JlYXRlZAph
cyBTRyBCT3MuIFRoYXQncyBzb21ldGhpbmcgSSd2ZSBhbHNvIHBvaW50ZWQgb3V0IGJlZm9yZS4K
ClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IENocmlzdGlhbi4KPgo+Pgo+Pj4gQ2hyaXN0aWFuLgo+
Pj4KPj4+PiBPbmUgZWFzeSB3YXkgdG8gZml4IHRoaXMgaXMgbGV0cyBjb3VudCBwYWdlcyBhZnRl
ciBwb3B1bGF0ZSBjYWxsYmFjay4KPj4+Pgo+Pj4+IFdlIGhpdCBvbmUgaXNzdWUgdGhhdCBhbWRn
cHUgYWxsb2MgbWFueSBTRyBCT3MsIGJ1dCBUVE0gdHJ5IHRvIGRvIHN3YXAKPj4+PiBhZ2FpbiBh
bmQgYWdhaW4gZXZlbiBpZiBzd2Fwb3V0IGRvZXMgbm90IHN3YXAgU0cgQk9zIGF0IGFsbC4KPj4+
Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPj4+
PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jIHwgMzIgKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fdHQuYwo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwo+
Pj4+IGluZGV4IGExYTI1NDEwZWM3NC4uNGZhMGE4Y2Q3MWMwIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRt
L3R0bV90dC5jCj4+Pj4gQEAgLTMxNywxMyArMzE3LDYgQEAgaW50IHR0bV90dF9wb3B1bGF0ZShz
dHJ1Y3QgdHRtX2RldmljZSAqYmRldiwKPj4+PiDCoMKgwqDCoMKgIGlmICh0dG1fdHRfaXNfcG9w
dWxhdGVkKHR0bSkpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+IMKgIC3C
oMKgwqAgaWYgKCEodHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BBR0VfRkxBR19TRykpIHsKPj4+PiAt
wqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdfYWRkKHR0bS0+bnVtX3BhZ2VzLCAmdHRtX3BhZ2Vz
X2FsbG9jYXRlZCk7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChiZGV2LT5wb29sLnVzZV9kbWEz
MikKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfbG9uZ19hZGQodHRtLT5udW1f
cGFnZXMsCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZ0dG1f
ZG1hMzJfcGFnZXNfYWxsb2NhdGVkKTsKPj4+PiAtwqDCoMKgIH0KPj4+PiAtCj4+Pj4gwqDCoMKg
wqDCoCB3aGlsZSAoYXRvbWljX2xvbmdfcmVhZCgmdHRtX3BhZ2VzX2FsbG9jYXRlZCkgPgo+Pj4+
IHR0bV9wYWdlc19saW1pdCB8fAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNf
bG9uZ19yZWFkKCZ0dG1fZG1hMzJfcGFnZXNfYWxsb2NhdGVkKSA+Cj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHR0bV9kbWEzMl9wYWdlc19saW1pdCkgewo+Pj4+IEBAIC0zNDIsNiArMzM1
LDEzIEBAIGludCB0dG1fdHRfcG9wdWxhdGUoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsCj4+Pj4g
wqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOwo+
Pj4+IMKgICvCoMKgwqAgaWYgKCEodHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BBR0VfRkxBR19TRykp
IHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdfYWRkKHR0bS0+bnVtX3BhZ2VzLCAm
dHRtX3BhZ2VzX2FsbG9jYXRlZCk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChiZGV2LT5wb29s
LnVzZV9kbWEzMikKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9taWNfbG9uZ19hZGQo
dHRtLT5udW1fcGFnZXMsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZ0dG1fZG1hMzJfcGFnZXNfYWxsb2NhdGVkKTsKPj4+PiArwqDCoMKgIH0KPj4+PiArCj4+
Pj4gwqDCoMKgwqDCoCB0dG1fdHRfYWRkX21hcHBpbmcoYmRldiwgdHRtKTsKPj4+PiDCoMKgwqDC
oMKgIHR0bS0+cGFnZV9mbGFncyB8PSBUVE1fUEFHRV9GTEFHX1BSSVZfUE9QVUxBVEVEOwo+Pj4+
IMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KHR0bS0+cGFnZV9mbGFncyAmIFRUTV9QQUdFX0ZMQUdf
U1dBUFBFRCkpIHsKPj4+PiBAQCAtMzU1LDEyICszNTUsNiBAQCBpbnQgdHRtX3R0X3BvcHVsYXRl
KHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4g
wqDCoMKgIGVycm9yOgo+Pj4+IC3CoMKgwqAgaWYgKCEodHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BB
R0VfRkxBR19TRykpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYXRvbWljX2xvbmdfc3ViKHR0bS0+
bnVtX3BhZ2VzLCAmdHRtX3BhZ2VzX2FsbG9jYXRlZCk7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlm
IChiZGV2LT5wb29sLnVzZV9kbWEzMikKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdG9t
aWNfbG9uZ19zdWIodHRtLT5udW1fcGFnZXMsCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICZ0dG1fZG1hMzJfcGFnZXNfYWxsb2NhdGVkKTsKPj4+PiAtwqDCoMKg
IH0KPj4+PiDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4gwqAgfQo+Pj4+IMKgIEVYUE9SVF9T
WU1CT0wodHRtX3R0X3BvcHVsYXRlKTsKPj4+PiBAQCAtMzg0LDEyICszNzgsNiBAQCB2b2lkIHR0
bV90dF91bnBvcHVsYXRlKHN0cnVjdCB0dG1fZGV2aWNlCj4+Pj4gKmJkZXYsIHN0cnVjdCB0dG1f
dHQgKnR0bSkKPj4+PiDCoMKgwqDCoMKgIGlmICghdHRtX3R0X2lzX3BvcHVsYXRlZCh0dG0pKQo+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+Pj4gwqAgLcKgwqDCoCB0dG1fdHRfY2xl
YXJfbWFwcGluZyh0dG0pOwo+Pj4+IC3CoMKgwqAgaWYgKGJkZXYtPmZ1bmNzLT50dG1fdHRfdW5w
b3B1bGF0ZSkKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYmRldi0+ZnVuY3MtPnR0bV90dF91bnBvcHVs
YXRlKGJkZXYsIHR0bSk7Cj4+Pj4gLcKgwqDCoCBlbHNlCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHR0
bV9wb29sX2ZyZWUoJmJkZXYtPnBvb2wsIHR0bSk7Cj4+Pj4gLQo+Pj4+IMKgwqDCoMKgwqAgaWYg
KCEodHRtLT5wYWdlX2ZsYWdzICYgVFRNX1BBR0VfRkxBR19TRykpIHsKPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgYXRvbWljX2xvbmdfc3ViKHR0bS0+bnVtX3BhZ2VzLCAmdHRtX3BhZ2VzX2FsbG9j
YXRlZCk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChiZGV2LT5wb29sLnVzZV9kbWEzMikK
Pj4+PiBAQCAtMzk3LDYgKzM4NSwxMiBAQCB2b2lkIHR0bV90dF91bnBvcHVsYXRlKHN0cnVjdCB0
dG1fZGV2aWNlCj4+Pj4gKmJkZXYsIHN0cnVjdCB0dG1fdHQgKnR0bSkKPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnR0bV9kbWEzMl9wYWdlc19hbGxvY2F0
ZWQpOwo+Pj4+IMKgwqDCoMKgwqAgfQo+Pj4+IMKgICvCoMKgwqAgdHRtX3R0X2NsZWFyX21hcHBp
bmcodHRtKTsKPj4+PiArwqDCoMKgIGlmIChiZGV2LT5mdW5jcy0+dHRtX3R0X3VucG9wdWxhdGUp
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGJkZXYtPmZ1bmNzLT50dG1fdHRfdW5wb3B1bGF0ZShiZGV2
LCB0dG0pOwo+Pj4+ICvCoMKgwqAgZWxzZQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB0dG1fcG9vbF9m
cmVlKCZiZGV2LT5wb29sLCB0dG0pOwo+Pj4+ICsKPj4+PiDCoMKgwqDCoMKgIHR0bS0+cGFnZV9m
bGFncyAmPSB+VFRNX1BBR0VfRkxBR19QUklWX1BPUFVMQVRFRDsKPj4+PiDCoCB9Cj4+Pj4gwqAg
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
