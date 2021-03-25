Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8C3C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE0661A2C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE0661A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1B26EDB0;
	Thu, 25 Mar 2021 16:28:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E846EDB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD2xcoQLqaVa0BCQXJCHnMtJhZOI85qZY8/QyKUcvNSjfkj3ia0YyEWgnYJ6SfHdw13kAxVd8GyYqeVX1TPcmA9SRtya3b+MiLFboD7yzs334TWDiUTfWD6E/ZpJ6DlyoVzxVR+G3Bl8xBJxBO+XDjPCdJmgGyxsIkNoof/ouNerUGnoxys/U6uAxaa/D9inIZTegZ9wTezs/z3G7htW5h6xApf227qht0uEF6/2EGd9rr+YhQYE9l6AX9W0nrkMR17EKhWOUOf70aiXjHvodoqAZXrR1hq1kL6XxV/9f1sQ2df398MevqfYi+8Y1hyLbJ4x3bzjNgkIy37Yxq0Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO47HwZaumzfi9+3V9XhkWy+f/9nmWNf6QHUUtvZvQQ=;
 b=SD/mBr0Va/75gKJ4SDSooAuh73/xlzErSaERderLeX1pSsO7Q+zgn1c9QKFZiQlsXWqV01OmMjpVy4eXcEZtuMHaizGGdkmBJsBKumfC5cQpVNwWnZY3wHufwws4kOq77k6LaX6UoEUSBy+UU6EdwrA+0jTa8rxa4NphHRnn46g6iWzV8TUvQjgIQoUTm5eRYhBxapBcGBuJI8g4bDLam7qaS/SW02N/D8nMOHH7JpUJeaRqcXRV/Kj7EsBfjv6tkvzUOnyP0WTdkvSbAKEQNyAP966/E0++CHHHjEN3SpbHZ6tpMTZnPtHNsNLyIh7xxg8cB7jF69kmp2tTUnBb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO47HwZaumzfi9+3V9XhkWy+f/9nmWNf6QHUUtvZvQQ=;
 b=HREZbnw4tBLnYChcS7PzUthGnzeXwGaoPCeCFvrjkjEDM6Ebp7LcyebDOrqXcVb4YFIJAx1oINYyJ73rJWTcn4FXZviqfj9MJMdkE1OlMe27SmPQwSnRQ80g4Kfjf+dDUxsv688/2G4BgyvJKtSj1/7LgzvV//cm9tLcLPHrGaM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 25 Mar
 2021 16:28:36 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.036; Thu, 25 Mar 2021
 16:28:36 +0000
Subject: Re: Need to support mixed memory mappings with HMM
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <ba49d13c-6b64-f9a6-f309-0dda56e90abf@amd.com>
 <dc28799b-d3a9-6922-f06a-c19eb75a9805@amd.com>
 <415c5920-0c70-819b-555e-a0c0fce301ef@amd.com>
 <ee1951eb-f789-14c2-608e-a6f77355c9ab@amd.com>
 <a6b6ac1a-d3f2-379f-fc0e-3b10908abc46@amd.com>
 <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7c4be3bd-8d73-bd8d-3eed-9ddc68a9c364@amd.com>
Date: Thu, 25 Mar 2021 12:28:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <94b1e462-eff6-77f3-f0c4-1ae99f02a178@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.84.209]
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.84.209) by
 YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 25 Mar 2021 16:28:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb7456dd-415f-45f9-3773-08d8efab0a22
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49464DC4CCB94DBFD670D1D192629@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +14wITkYd3VIUE7vzxea1VkwJbCedWTCPViwr2ajpRXom1z8FgRj7UgajJs0aLNPkFv50Qe37+/vnZf4mC0k4xo2CCNcO8EkzRWEmofVWX49dvwdWXh58QIaF1tpzzqmo47mKkF0z3QgOPBwV8W0O7tGJNJUm6+8/Ga3tXz3bAR8L8ctwFmTgFWsGt/uvrsnEuLaQk3wVSCOivcqzt0tXVqKQQ/McrUf2AK8SQdc4ktA/nH/7YobP1d1a8sRgVB8zP6Vrghc4GhGmJzrBU/8DoAxI2qSWOw7Su79CaXZgjSNrx1UtMAlO5MhKok40X7gqWuAGeXwnMNcDHd79drBfEVnTGNrNStTBd8//WM/O5zSE4YV5wTysUA5Y2P1SkqAHb/VCqTermIzODAcKmjQAEBBwQ4VlNq6iG6efITbYN38uhcD8jysjFr/0/D4I9wyQm9DpEKXRp+XOVF6IShYgXC9zu/kgyGXqnr/gsWY9njubFxlwC4CIwWntuGWT2tjJSXHRnkaeYGaB4Kqxmb1z5zwhw5EY/QwkK3Rw4rkxVsrUzp4Vas9WVk26mIHeufvCLHoArLtNqZ1n+JrfNgNoo2i2RmVtUkm6emklztJVWOwd44wRGB3Zd3L96HnmfqNM5VidtAPwJ6nX2U7i0NcAaxl1XEVvw6XEDWnOQqi/KihRrpWwtXANP4zrWHOOpVWa4sloljwqzq4ZPKfJwntPx80QihJYzqEiEvDVRl+Ax8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(66556008)(478600001)(186003)(5660300002)(16526019)(110136005)(66946007)(26005)(31696002)(16576012)(31686004)(66476007)(316002)(86362001)(83380400001)(8936002)(6486002)(44832011)(2616005)(8676002)(66574015)(38100700001)(2906002)(36756003)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dU11N0NtY3MzSXF1Y2hkU0VIb09IdFloSXlOV0tWU0FxU0t2RHFrb0N5ZlBU?=
 =?utf-8?B?L0lwQVhVU2E4Y1owcnczMHRaaU9WR3puRXZ3TlRlendrZUVlaW5mbXhacjdG?=
 =?utf-8?B?eVd6WEJBb01ncmNUblBkeHFzNWtJZ21Ud3RNUzFQL3RTWklvSG1PeWpWeDRt?=
 =?utf-8?B?QWx0MkFybGRPU2w5ZkZWd2ozZ0FJVitjdXR4TXBZSmJYVE1WSnZCNzRscVJt?=
 =?utf-8?B?ZHRVNXoya0NxekRPL1lPVmczUUNpTTM5eXVkR25ndlE2ZEM2TGhKOERqVGk2?=
 =?utf-8?B?NVgrV2xsbG5aa0tIa0dtaFBZQ1lUZnBqWExhOXg0Q1dIdmNFYVN2azJXV1B2?=
 =?utf-8?B?RDVpNEVIcGF0d3Rmdkxpbi9nNi9TSGN1ams2cFVuQ2JSdGJ6eGJndWxWdWZB?=
 =?utf-8?B?WnVhbzZBVHEyNE9kdmZIU2tkMFFSNVFsU1dJN2V1U0FXT0hmRjB5T1BtM3NV?=
 =?utf-8?B?Y3RlVkFXb01BMks1RDdNMCtUQ3dxUWl1b3RNdnYzQTBPV1RSU3V5Y0pWT0F0?=
 =?utf-8?B?bXBGVHVtYUI1U0lyRC90U2F5TU9za0Evdmg1cFpaUnhZKzk3eEw5cG5xU056?=
 =?utf-8?B?NUhNemYzM3RxRGMwVmRDakpCeDgwL1FId1Vza1BVSUxKNzYyaVVKS01RZlJr?=
 =?utf-8?B?cXVNWlhacnVmQXZrTmVvQ2IrZlJoQzQ3Y1RlNTMrWE5HZHVnazNycGZhYnp5?=
 =?utf-8?B?b0xlMWUwdTI3am56TmdUaGFqcUhqSmtiN1lrSEs3WVRNRndSK2JQVkZQS1Qz?=
 =?utf-8?B?U3RFbG03cHZ2ZFQ5SlBjdFpyNG1xRDZCdGYrajdvamFxUExRc2I1U3lKWjcz?=
 =?utf-8?B?aytUL1drUWp1SzFNc3Jxd1J2TXFlSTl2aVNOai9WQWUrejB5NktTdXRGUzZ0?=
 =?utf-8?B?d0ZSTHRzcDkrYjNOWTRHU1NxZXVRaDBaUER2ZWhRTlZtMXB0YlhpanBoOVky?=
 =?utf-8?B?Zlg1Ymt1aVkxamVJclFhK0I2N1R6QSsxTm1CY0pMNHJOZWFSZE5td0dJNkF5?=
 =?utf-8?B?MUsvWWNPL1B0TDh5TS9vYy94aW5odElyd0syL3lNRGQyakhib1lzeW0xUTE5?=
 =?utf-8?B?QVZkT0tqaDhJdUEwdkRiZkdoajlPVjRSSXdUV0txeUZ1d0ZVT2dnYlYwM1hX?=
 =?utf-8?B?aTdGVjhNUGIrb3o2bjhhdmhKdXFsTzJtYTIwQlVZQXlxdzJuVXRac1RIR0Vp?=
 =?utf-8?B?ckxkQitWdWtVeVBxUDFadFJJd0VvOGUrK3dFdkViK2U3bzRhRFlCazczekdZ?=
 =?utf-8?B?aHNHQjRORFk4eWxwL3pUNDBBSFJ0WWljai9nUWNPYVRvV3JFRnM3bk5ndzcr?=
 =?utf-8?B?dUJ0eDZ1RWZ0TjJMbW5admlKTS9INlRjUG5yQUR6aXNEQlBmNVd0blRkREFw?=
 =?utf-8?B?T0NEKzJLZ0V1S0tacHM1bTQrdkxWSDFrVVZqNHcvMFdQUzcvZ1YwUW1LRUtW?=
 =?utf-8?B?anZ4YkZxYVhwQmpHbzBYU0YrWkRqT0M0bytmUldIY3dZOGRJaE1HcFJmbVJy?=
 =?utf-8?B?RXh4azZzUFIxbzNEay90Ty9BV0JlSjhCa3dhQTFrNmduUjlyQktyb08yKzdw?=
 =?utf-8?B?WDduRTFYdWtlRFl1a1MrSnluSS9TUmRZY01TNzEvcU1NWkk2NlZnYnZlRVUz?=
 =?utf-8?B?K1hVN204L1pnL1I0RWxNSGEwUUFTTEN6T096blV1QnN5RkxjalZ3OGgrQVRY?=
 =?utf-8?B?VVJQUWFpU3RnbU95QXFyWkZNMGs3aUcvMGFteGxLZVpIc2JpNWJWeEoxZXpO?=
 =?utf-8?Q?x6wuZWvYOJkLGcZEG4Ouygwfkl7+jgWkgTByfpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7456dd-415f-45f9-3773-08d8efab0a22
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:28:36.4631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Fa3vCk6NFCcvHB7NIw1eypUSpbG4GjqiWgMqwogMJ3B7RpXXbxVc9bijYY6BTe47f1WkN7k4pUxn4Do6HZ3dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDMtMjUgdW0gMTI6MjIgcC5tLiBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+
Pj4+PiBNeSBpZGVhIGlzIHRvIGNoYW5nZSB0aGUgYW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nIGlu
dGVyZmFjZSB0byB1c2UKPj4+Pj4+IHNvbWUKPj4+Pj4+IGhpZ2gtYml0IGluIHRoZSBwYWdlc19h
ZGRyIGFycmF5IHRvIGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIEZvciB0aGUKPj4+Pj4+IGRlZmF1
bHQgcGFnZSB0eXBlICgwKSBub3RoaW5nIHJlYWxseSBjaGFuZ2VzIGZvciB0aGUgY2FsbGVycy4g
VGhlCj4+Pj4+PiAiZmxhZ3MiIHBhcmFtZXRlciBuZWVkcyB0byBiZWNvbWUgYSBwb2ludGVyIHRv
IGFuIGFycmF5IHRoYXQgZ2V0cwo+Pj4+Pj4gaW5kZXhlZCBieSB0aGUgaGlnaCBiaXRzIGZyb20g
dGhlIHBhZ2VzX2FkZHIgYXJyYXkuIEZvciBleGlzdGluZwo+Pj4+Pj4gY2FsbGVycwo+Pj4+Pj4g
aXQncyBhcyBlYXN5IGFzIGNoYW5naW5nIGZsYWdzIHRvICZmbGFncyAoYXJyYXkgb2Ygc2l6ZSAx
KS4gRm9yCj4+Pj4+PiBITU0gd2UKPj4+Pj4+IHdvdWxkIHBhc3MgYSBwb2ludGVyIHRvIGEgcmVh
bCBhcnJheS4KPj4+Pj4gWWVhaCwgSSd2ZSB0aG91Z2h0IGFib3V0IHN0dWZmIGxpa2UgdGhhdCBh
cyB3ZWxsIGZvciBhIHdoaWxlLgo+Pj4+Pgo+Pj4+PiBQcm9ibGVtIGlzIHRoYXQgdGhpcyB3b24n
dCB3b3JrIHRoYXQgZWFzaWx5LiBXZSBhc3N1bWUgYXQgbWFueSBwbGFjZXMKPj4+Pj4gdGhhdCB0
aGUgZmxhZ3MgZG9lc24ndCBjaGFuZ2UgZm9yIHRoZSByYW5nZSBpbiBxdWVzdGlvbi4KPj4+PiBJ
IHRoaW5rIHNvbWUgbG93ZXIgbGV2ZWwgZnVuY3Rpb25zIGFzc3VtZSB0aGF0IHRoZSBmbGFncyBz
dGF5IHRoZSBzYW1lCj4+Pj4gZm9yIHBoeXNpY2FsbHkgY29udGlndW91cyByYW5nZXMuIEJ1dCBp
ZiB5b3UgdXNlIHRoZSBoaWdoLWJpdHMgdG8KPj4+PiBlbmNvZGUKPj4+PiB0aGUgcGFnZSB0eXBl
LCB0aGUgcmFuZ2VzIHdvbid0IGJlIGNvbnRpZ3VvdXMgYW55IG1vcmUuIFNvIHlvdSBjYW4KPj4+
PiBjaGFuZ2UgcGFnZSBmbGFncyBmb3IgZGlmZmVyZW50IGNvbnRpZ3VvdXMgcmFuZ2VzLgo+Pj4g
WWVhaCwgYnV0IHRoZW4geW91IGFsc28gZ2V0IGFic29sdXRlbHkgemVybyBUSFAgYW5kIGZyYWdt
ZW50IGZsYWdzCj4+PiBzdXBwb3J0Lgo+PiBBcyBsb25nIGFzIHlvdSBoYXZlIGEgY29udGlndW91
cyAyTUIgcGFnZSB3aXRoIHRoZSBzYW1lIHBhZ2UgdHlwZSwgSQo+PiB0aGluayB5b3UgY2FuIHN0
aWxsIGdldCBhIFRIUCBtYXBwaW5nIGluIHRoZSBHUFUgcGFnZSB0YWJsZS4gQnV0IGlmIG9uZQo+
PiBwYWdlIGluIHRoZSBtaWRkbGUgb2YgYSAyTUIgcGFnZSBoYXMgYSBkaWZmZXJlbnQgcGFnZSB0
eXBlLCB0aGF0IHdpbGwKPj4gYnJlYWsgdGhlIFRIUCBtYXBwaW5nLCBhcyBpdCBzaG91bGQuCj4K
PiBZZWFoLCBidXQgY3VycmVudGx5IHdlIGRldGVjdCB0aGF0IGJlZm9yZSB3ZSBjYWxsIGRvd24g
aW50byB0aGUKPiBmdW5jdGlvbnMgdG8gdXBkYXRlIHRoZSB0YWJsZXMuCj4KPiBXaGVuIHlvdSBn
aXZlIGEgbWl4ZWQgbGlzdCB0aGUgY2hhbmNlIGZvciB0aGF0IGlzIGp1c3QgY29tcGxldGVseSBn
b25lLgoKQ3VycmVudGx5IHRoZSBkZXRlY3Rpb24gb2YgY29udGlndW91cyByYW5nZXMgaXMgaW4g
YW1kZ3B1X3ZtX3VwZGF0ZV9tYXBwaW5nOgoKPiBpZiAobnVtX2VudHJpZXMgPiBBTURHUFVfR1BV
X1BBR0VTX0lOX0NQVV9QQUdFKSB7IHVpbnQ2NF90IHBmbiA9Cj4gY3Vyc29yLnN0YXJ0ID4+IFBB
R0VfU0hJRlQ7IHVpbnQ2NF90IGNvdW50OyBjb250aWd1b3VzID0KPiBwYWdlc19hZGRyW3BmbiAr
IDFdID09IHBhZ2VzX2FkZHJbcGZuXSArIFBBR0VfU0laRTsgdG1wID0gbnVtX2VudHJpZXMKPiAv
IEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0U7IGZvciAoY291bnQgPSAyOyBjb3VudCA8IHRt
cDsgKytjb3VudCkKPiB7IHVpbnQ2NF90IGlkeCA9IHBmbiArIGNvdW50OyBpZiAoY29udGlndW91
cyAhPSAocGFnZXNfYWRkcltpZHhdID09Cj4gcGFnZXNfYWRkcltpZHggLSAxXSArIFBBR0VfU0la
RSkpIGJyZWFrOyB9IG51bV9lbnRyaWVzID0gY291bnQgKgo+IEFNREdQVV9HUFVfUEFHRVNfSU5f
Q1BVX1BBR0U7IH0gCgpJZiBhIHBhZ2UgdHlwZSBjaGFuZ2VzIGZyb20gb25lIHBhZ2UgdG8gdGhl
IG5leHQsIGl0IHdpbGwgZW5kIGEKY29udGlndW91cyByYW5nZSBhbmQgY2FsbCBpbnRvIHRoZSBs
b3dlciBsZXZlbCAoYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKS4KSSBkb24ndCB0aGluayBhbnl0aGlu
ZyBuZWVkcyB0byBjaGFuZ2UgaW4gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzLCBiZWNhdXNlCmFsbCBw
YWdlcyBjb250aWd1b3VzIHBhc3NlZCB0byBpdCB1c2UgdGhlIHNhbWUgcGFnZSB0eXBlLCBzbyB0
aGUgc2FtZQpmbGFncy4gQW5kIHRoZSBleGlzdGluZyBjb2RlIGluIGFtZGdwdV92bV91cGRhdGVf
bWFwcGluZyBhbHJlYWR5IGRvZXMKdGhlIHJpZ2h0IHRoaW5nLiBJIGhvbmVzdGx5IGRvbid0IHNl
ZSB0aGUgcHJvYmxlbS4KClJlZ2FyZHMsCsKgIEZlbGl4CgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0
aWFuLiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
