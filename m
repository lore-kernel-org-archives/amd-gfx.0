Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B3C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 18:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5602610A8
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 18:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5602610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344A06F8A6;
	Fri, 21 May 2021 18:24:20 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CAB6F8C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 18:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpXraM0GgeGLHhVRUH7CrBi6HZ6RKHef2z2K/RJ2ES2os99u5xxtY32al5apSbhQPefBTj1igFaBAYwJFlII8qnnp9ngVkmWcrzbflXBH7y0N7ylHSohW/IoGHbadecHx1e0Eo3lx2esP14upzGdaA+hhEUlMocBuRI27Px8qdlx9JGcGZAsU91k0NMAqMl/Z+jRYsg6u6iJELzhMDRTJBXP2zAeJeWLS09kGqUhDh1nYIhoCKAyJJloFBILAQfc4JstpqL8Es70esJwvDb+hUxX3S9JR6fMR+L4D4F0TgvyGpMpHWaAWE8+1BvqiDa1ic0PZZSMrImFfFnRWheNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvrMm2x+HJy5RNCYuuN0EBfZBtXdKUNfANPvXC2ukN0=;
 b=Lm5Lq5ImWVzbn+BZ63hU7nAhvKietTR/N2hnZ1vhknqIddH8Z4imIVK+hBxI6al55SFbGquXM/Wov0h1luFGCBv8xB7lJK2g7bk9g0MIR45DWeu+skao8AKRVZuL8H9lU1zqOHtw7bV/hG4jmLucrBNP/zTdtoDeVQugM/WtDyni5YjMWbg7wjI1ZoK9llBB/ZAjDFFYyJH+P4ib2552z9EXjBAmL4+jQlFpjGn4ZqgZCULqpj9u609OyUVKO2Zr9hO43cLIBII3NAvv0cY2mF1VY63lTCrSwhSfqq4qhEpRLDaRFg5nwROV0sSj5NkEV0W5AkETUxGUmPn4oVJTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvrMm2x+HJy5RNCYuuN0EBfZBtXdKUNfANPvXC2ukN0=;
 b=zbTFld97QJm9ArEEAY+9YxxZW6xMIcz+OudwKVjjI2dXZ2i4o3yV3na1SOvgSx6eHiqe0iPClvios0tZ5OtWXH5IpNPZg8aJCiPxa9IOy2mjZ1XjlVODWSlOyy5Gmoad2Z1DvKy4UZHOvlKMdj9AeWHWFxilfvjUOUxyJQXCk7A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5033.namprd12.prod.outlook.com (2603:10b6:408:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 18:24:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 18:24:13 +0000
Subject: Re: [PATCH] drm/amdgpu: Use dma_resv_lock instead in BO release_notify
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521052606.20323-1-xinhui.pan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1c46b6a8-db7a-9aaf-7909-c61886ce1879@amd.com>
Date: Fri, 21 May 2021 14:24:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210521052606.20323-1-xinhui.pan@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 21 May 2021 18:24:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb892459-8986-4e16-bb1b-08d91c85a23d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5033:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5033514CD8F9F91E2E90F90892299@BN9PR12MB5033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34pxh5iBE8MXQqZa3K6MfuT7aaFYlg3lrlCWgcQ3IP7JyGJNKQ2MwUpSOuwZtXjYG7ILnrRIhXDwJXFnYGTgQBWAhAdpk9dgn1jlM8ivtnlN87ISYt0C1rVVKH+am5ABMSxNTAC8tSyFo2hIe7rDgrBJNLhYZMyrw0uL68Ol5Gp/uO2gLM/Pd4kxfQg1OZXHwACT8qpwM6DNKtNG+85gFCVxAPqaf6cD4+dJVRvdDjDz/pw8C4IhayUfJf/7ri6aPcxnWM5HaUqedAXhwxdTvyj71rOqetXMie/NRiEGTYy5sLmmZagFQvD0oNSSjQ+9aoS/8mHV6TQDY6C7G5jpQ6aIQ/KA/w7uxDPk/E1Snyx2XwXL/Tt7wb16Btva7hVJVX/fc0+X0vZ4+7bY7Y+rZq2EBln1RWP2ONR+TVNVqjxNAbZdahumJkWwPHq0C/v1g1yUuc1CUW3WJu/+Vf+9I6/D0EsCk9g1d20k2Ma3rJV4pMUztP0wtR0q3TLFZhxEZ5i0M8xKdcynbhyua4NyXpd9sTflheJHkWbUpUhGt9BCMIzQJag/V52Dci2HRIIeGjKHCf/ZyX96EeUoW1IxJHiC1nRxEOW2KqvTZpEQsetdJS5LFOudz9WI8K7EwYd7sCHOyiBZk3BPaCMDJ1dXBQmc5TR/jipeTXjuYepp4VnQioA1X7djmdvzfsLqfQeO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(36756003)(4326008)(478600001)(8676002)(44832011)(186003)(83380400001)(16576012)(16526019)(6486002)(31686004)(316002)(31696002)(66946007)(2616005)(2906002)(86362001)(66476007)(66556008)(26005)(5660300002)(38100700002)(956004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QW9ER1p0MjlTWkxxNlNHMVRvUE1aTForTWI1bmdQbDNyOGdvY0NsM0lBNDU4?=
 =?utf-8?B?RFA3U2szc05vUlkwdkgyN0pITExBMkVWZXVjaGlXaU5SU214bWdDV1FZZjRU?=
 =?utf-8?B?bVljNTNSK2JiMW14TlQzdHd1eXcyaGFHK3FUOVBxWWMyS05NZ2JMeHpLT3U3?=
 =?utf-8?B?bjIxVkFzVmY5S0NsSUwyQ3pKV0JORGhWclhTeU5KSlFkVVJDd1poNlJwQXNq?=
 =?utf-8?B?emRmNlJrazR6WTQxRFMrdkVVdTRMWGxPaHN6TGRBcDZDY3JjcnJJQXFCaXZp?=
 =?utf-8?B?YmZ4SjF4TGxKN3lMTy9xM29seEpHYzNjSlNDbTd1Wjdma3h2VXNyK3JtSE1G?=
 =?utf-8?B?Y0dnWnh3dlJReHB2d0Ivb3V2TS81MkJOVERVcXViekZKUTg5UlRYNmxiWXda?=
 =?utf-8?B?aTQ2cm02VktqYWdTbmJWMUFEaVF1cEU3YUNMbGtlV3dJVVBBcFhUUkNDdE10?=
 =?utf-8?B?YmpmLzN2Mld6dklrZDBzenIrMGp1Y3JpUUhhSFpOaGhYVFM4bi9tR21qWXBF?=
 =?utf-8?B?VEF2NVJxRlNHQ3RxdHI4cno1ZEFBc0JuV3k2dGtLcFlyRlh6c3JLQ3RMRnVa?=
 =?utf-8?B?QmVwNVJRK3FFaXhYaHBwWmhDMUYyRFUvVm5zYVVCWnAxM2VneVBJbm1RN3Zw?=
 =?utf-8?B?ZkF4T1dkREprb1lpRWtmYjNTdERHdnQzeTlRK1ZKRG9aU280bEF5c1BDZ1dS?=
 =?utf-8?B?LzdnTDJzeHdDcjh6bmNiNEpzd2lMM0hCTEIwVzY3Sk5sRUNOWEkycWVzdlM3?=
 =?utf-8?B?OU5WSFVWWjkyajFXYVhSczZXekFNYkw2M21sY1RBOWtSa0hpOXdOZEdhU3JD?=
 =?utf-8?B?OHAxbjhHWHltYlJEaXp0WDhtMFZibTF5cHluN2hMMy9lN0lpc0I5UVlKWVY0?=
 =?utf-8?B?bDN5dDN1Z1hwL29Rd2hSWUptaGVTZ21zbDhiVTFHaWs1SHlydURSamIxUkNx?=
 =?utf-8?B?VkMyL3ZKaDRWWGVIb2xSS1psWEF4OTFOWURTV1F4TitSYlVIeGRSdElwa3hx?=
 =?utf-8?B?U0FkZktONFhFRS82dHF6YmpKbllmMjhMS0c1bHAwdWxGdHVKYnZhR3ZDYXA3?=
 =?utf-8?B?TzU3QmhhTVl6cFhiQlBzV2lESDE0YmpiREpGa0xqcWRZdWZzbW1GQUphOGlB?=
 =?utf-8?B?dmd1OXJXelN2dTA5UFk0aVdQaklSQ05uRmRSaGZVTXZFWDVlUzA4bnA5MUU2?=
 =?utf-8?B?dUJvZXR1SFJpWWtSeWlnSE4vbEQ3S3ovU1FGYUxTWFVOKzJQRWcrY0VXU3hy?=
 =?utf-8?B?YXJYZXNaeGN6M3hzRUJuUlo3dWlpQW8zbTBEZE90WVNXU3hUMS9tVGN6N2M5?=
 =?utf-8?B?bE1TcGtEcVM1ekFxZnJlaFF0M1RNRGpHbWp1S3l1b2IwdTdEMi9xVGNsWHV2?=
 =?utf-8?B?OVBWY3k2ck96WExxVkd0UmdIdDdqbmh2ZGlRdHo2Mjg0RThvaUZTTXZKUjhZ?=
 =?utf-8?B?SENObWVTcE5VUUtKbE5qa0s2eVRabGYzM2MrdGhkQmVFUGpuQzFCK0JxWGJw?=
 =?utf-8?B?RUF6YThmcGVmbFVZWWxCWHEyRkIwcm4rS0ZURHV0eVFzTWdvenJDZExuNzh2?=
 =?utf-8?B?c282VlZZQWthazkzSUl2dDJVWFZVRE5tTnVPT3ZRVy94MXZHZnZVSndmcUpZ?=
 =?utf-8?B?dWVFMGE5Mk5UWFhjVGwwWXA2YW9QeXFLMER1c2VwT1NiMFFOZnM1VThhcVdp?=
 =?utf-8?B?ZmRWSVlBQnJaVlphM3c5endydzhEcmZLZEF0bDJMR3pydVhraElISTJHS09h?=
 =?utf-8?Q?VlYwHTpVK7D+ZVzn2PHCWl4kGpzoNwHOObOPi3U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb892459-8986-4e16-bb1b-08d91c85a23d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 18:24:12.9401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERRmzI9EVFKDT63JULMu0HnM54rSxSkTNEEJa7UiPOUebQtJL9hCSYH7A35JnwJv/X1eaxnxvFXM4c5Xc+YXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5033
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDUtMjEgdW0gMToyNiBhLm0uIHNjaHJpZWIgeGluaHVpIHBhbjoKPiBUaGUgcmVz
ZXJ2YXRpb24gb2JqZWN0IG1pZ2h0IGJlIGxvY2tlZCBhZ2FpbiBieSBldmljdC9zd2FwIGFmdGVy
Cj4gaW5kaXZpZHVhbGl6ZWQuIFRoZSByYWNlIGlzIGxpa2UgYmVsb3cuCj4gY3B1IDAJCQkJCWNw
dSAxCj4gQk8gcmVsZWFzZQkJCQlCTyBldmljdCBvciBzd2FwCj4gdHRtX2JvX2luZGl2aWR1YWxp
emVfcmVzdiB7cmVzdiA9ICZfcmVzdn0KPiAJCQkJCXR0bV9ib19ldmljdF9zd2Fwb3V0X2FsbG93
YWJsZQo+IAkJCQkJCWRtYV9yZXN2X3RyeWxvY2socmVzdikKPiAtPnJlbGVhc2Vfbm90aWZ5KCkg
e0JVR19PTighdHJ5bG9jayhyZXN2KSl9Cj4gCQkJCQlpZiAoIXR0bV9ib19nZXRfdW5sZXNzX3pl
cm8pKQo+IAkJCQkJCWRtYV9yZXN2X3VubG9jayhyZXN2KQo+IEFjdHVhbGx5IHRoaXMgaXMgbm90
IGEgYnVnIGlmIHRyeWxvY2sgZmFpbHMuIFNvIHVzZSBkbWFfcmVzdl9sb2NrCj4gaW5zdGVhZC4K
ClBsZWFzZSB0ZXN0IHRoaXMgd2l0aCBMT0NLREVQIGVuYWJsZWQuIEkgYmVsaWV2ZSB0aGUgdHJ5
bG9jayBoZXJlIHdhcwpuZWVkZWQgdG8gYXZvaWQgcG90ZW50aWFsIGRlYWRsb2Nrcy4gTWF5YmUg
Q2hyaXN0aWFuIGNhbiBmaWxsIGluIG1vcmUKZGV0YWlscy4KClJlZ2FyZHMsCsKgIEZlbGl4CgoK
Pgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMiAr
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBp
bmRleCA5MjhlOGQ1N2NkMDguLmJlYWNiNDYyNjVmOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKPiBAQCAtMzE4LDcgKzMxOCw3
IEBAIGludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3RydWN0IGFt
ZGdwdV9ibyAqYm8pCj4gIAllZiA9IGNvbnRhaW5lcl9vZihkbWFfZmVuY2VfZ2V0KCZpbmZvLT5l
dmljdGlvbl9mZW5jZS0+YmFzZSksCj4gIAkJCXN0cnVjdCBhbWRncHVfYW1ka2ZkX2ZlbmNlLCBi
YXNlKTsKPiAgCj4gLQlCVUdfT04oIWRtYV9yZXN2X3RyeWxvY2soYm8tPnRiby5iYXNlLnJlc3Yp
KTsKPiArCWRtYV9yZXN2X2xvY2soYm8tPnRiby5iYXNlLnJlc3YsIE5VTEwpOwo+ICAJcmV0ID0g
YW1kZ3B1X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2UoYm8sIGVmKTsKPiAgCWRtYV9yZXN2
X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7Cj4gIApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
