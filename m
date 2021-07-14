Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C64C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E65E613C3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E65E613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3FE6E400;
	Wed, 14 Jul 2021 15:24:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 763506E400
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxokkSjOdkEhhyyN0kVa/F8YflnIRS46x3U1gF7ZoQIvc29ELD3pNvprXZCoacKDO/dPu9L03Jw92+nEX54UFOeXHclnWZ4E2U4ij3Mk70io1SGwHoPeRfMQLBAomuLYtgcnyogEsrY6MlOka4thqQp7+yFzz8odQb0U9kJTuOdq7dxDW387j0da6iFZIIDALrCNSDmwRve1CackXYlIhCevbi6Mz6RNjaYljPYDeDPlbl0b+uEv/9QlUuZnm8pcnVo7NJ9f3vGYEwvxoLBAR5/BZ/+msCCJCgqRcZT9wzWmGOcTXOrmN70YbqsGIhVd9Nz9bhJJx3hun/UCHP7Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7Si64pqm+nIEqkgJ9fkDjzxCXxitj8QXEDaqcYYHyU=;
 b=ncKWeXLemX5F9IjsSnoH4dHewp70KtMD9B1mVXQq4CR3XtxFK36XU0KEhrUkV1d2zZQGydYLAVWaFHqTroHvtrxCU8oHZYaRDeHZQS0e3hAuidQk3c10zGqRZEitgH/EpNd2KBCJXE5zuG/gQrBSnsZZ6C1E33e8RDgrLqqQEwEM+69EuS/lbrp+wR4QqCMluHYfQZRTESRBqPqE4KoLpgDWDDpSs9yyuDPUmbFlEIVFMsIDpncuzpn8WuueQZ9JHzMGEi9+AwwOrcekXLYJSbF/1CGn2viXwdyFXectBuMCdp4wjfVy02vKYR/+4MZUQDkz5UWjjPaA0Zz/FlbXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7Si64pqm+nIEqkgJ9fkDjzxCXxitj8QXEDaqcYYHyU=;
 b=CAIDm2BcqJnRDIVmpEkUnBoh0cesgMNLrB3CUqng+mwRZ8EyZ2AheWP2fzxPBCiLHcaHlgKmrKgK3DzEDfvi1j+JqWhRLaMULi0x4GDR6TjDvG3gVg9b7tDyTCbqV+pGE+2oFczkTgrEd2xv6eb65fg/IlgXG6FRz226Cq/PRe0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 15:24:43 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d49:f837:16e3:9561%4]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 15:24:43 +0000
Subject: Re: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
From: Eric Huang <jinhuieric.huang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210708195333.322119-1-jinhuieric.huang@amd.com>
 <CY4PR12MB128747CFF7E872B1170AF60CF1189@CY4PR12MB1287.namprd12.prod.outlook.com>
 <401e0e0b-2f44-0eb4-e8fa-e61cb3598d03@amd.com>
Message-ID: <00135db4-630c-1400-4b8e-cfa48fef301f@amd.com>
Date: Wed, 14 Jul 2021 11:24:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <401e0e0b-2f44-0eb4-e8fa-e61cb3598d03@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:890e:34c4:757:cc76]
 (2607:9880:2048:122:890e:34c4:757:cc76) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 15:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 312df07d-09af-4422-bac1-08d946db8150
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53016C386FB806550420162882139@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUQUBNH8ufeeTiosykU15dmsK7+5OU7ZRsd5+FEBk9wAB6NCGGFVFx2X3ctafhoSbm7/0GEMzf+3TG6cl8gio+BaiyQEKBJCX3lvr2vzQ4IZcA94JQz/ewMZPbGm6Zca1lKQnJe0YyLv6FHHRgooTjG8Gab6v6YBw2ApUKlEJk49pIygoxpjGtHXPBd6ZEw6P1dQHMu5RBb82FOLKin1lb8TKqROrdiADMZYUQZPSzSaIRhGRXbkAriI0moNtNznou8gX43j63fvSou1SnFJijGMQCVYGmyCCIN+KdXcsI0Ae+YLthHVbUEqjM90DwS7g1UW3yg3SYHG56quUXWUYNik1WFJoehkcc8q5vpZlFdp4yjWzKt9y0aNK6Cj12ZKYDnFp1sYnVjvlB8VD4GehtwdGk32cp7/qPwIPZrQ1eJUJ7VAD0pZAC8IzR+tlzEHkzBn8N745Bz1PDopBvoha6EBHA/X82z/nhWUpDexhX601WO5uady8JXTrrmvetdP0QZ7MoONvreQTa3Of8PPPeXjORxfMeGxWinbCFlzHtxHFpoZe8sEVVnGHUbL//XEfWXLFGI1Ya97Z7pJNOEx5EuMYQ4EEimmLT+rBpZI1br8W18Bw+849mWtvv4ixt+4n3XPuaB/mSiCIuDzKEKtvr5xWojKKMARjaQAvBe26u3hUEwpc9ye9L2+18Nd0wVW6nl6bnkjfhHmlVYclvl2vsl+LdhdsSm/J0oflbeaR/3EZIYpOIINFf8vpwghBeEq48DZJCYHd3ux3cl40Y9ytg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(31686004)(186003)(6486002)(45080400002)(2906002)(8676002)(31696002)(2616005)(36756003)(66556008)(5660300002)(66476007)(478600001)(66946007)(966005)(38100700002)(110136005)(83380400001)(8936002)(86362001)(53546011)(316002)(16393002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlFNYzhqMDB1U1Fvb1JzdkkzVDZHQ3I5eUo2aG9EaXZQeDIzMkQ4UDVjOXhw?=
 =?utf-8?B?Q2xqVEUxdE51bzduak5OSllEUWlaVFVXZVR6bkQ3QUVSN0JSc3laMHdJK21H?=
 =?utf-8?B?QlZiY2JlcHE5NmpVanBFalcyelNWdm9qM1lSVXNzaTlTQ2FpWnpPNkUwR0M1?=
 =?utf-8?B?SHEzQzlhaWZSaDVRQS9sdi9mdkNwWWRzVTQrMHZ0Q3dxa2hMWWRqZnBkS1R6?=
 =?utf-8?B?RjVySnhWTWx0WCtmOWJ6aFFvQ2l6Vkw5L3dWTDc5UC9LWVljcU5YdkRySG9y?=
 =?utf-8?B?YUF3cGpIeXNyMndLOHc0enhlWitNUXdvTTZ5d200cDQ4NEdXckxVZWxtTEhx?=
 =?utf-8?B?VFNldjJlcGdYdk5oN25FSlhodnptek9lejNLbXZFVkgzcUR4cHZNQUZDcmND?=
 =?utf-8?B?MG9sMHBzV0xxQ1RINDlWTTBNL3VHcy9zdDBBd3ZyUzZDMm9xYmpkd01xbVA0?=
 =?utf-8?B?eHZmZlRBekNEU013UDdzT2RFZUM0Nk56ZldCUENEa282VVNqMUFtNjRjQkky?=
 =?utf-8?B?eHN4Qy9kakxZMG5Pa0lnRktkUFBUSzViT0N4T1RNWUNybHJYQlh6WmZHT1g5?=
 =?utf-8?B?UnNXM0lDaEgwa0t0dXZtdFFESm1JZFNGQlRDL1c1cjNyc0VvYm9hQVZrM1lB?=
 =?utf-8?B?a1JMQUM2SjYwZDhDcVR5QzUwaXlRbERTOE1ONGF4TWJxeG5WUFZ4Y05UMHBj?=
 =?utf-8?B?SGdDd3M4cVVxTUxHNDFCNTFYcUd2R2liZzE0S200akc0cXVjelR4aERSVjhv?=
 =?utf-8?B?cGxxdm1KcjNCVGdzTUpteUJiNHNVekwvelBIWmxWRjZvTU12REpGeU8vYnAr?=
 =?utf-8?B?NU5DZjVRREFidlY4dnJDNHVWRTBTUnJkSHU0ZUJieU1PUUM4cVZ1dkNmczZO?=
 =?utf-8?B?SVRGSFZKbUxmTlpBaEVrNndsRldqREZVU3J6enJSV09FQnIrT3JxVW4yeC9E?=
 =?utf-8?B?aVQxQ0ROeUg0aXlKL0w5WUtQck5PQ2QyaE93NkNkeVBLWEdNdVBxWUVyclo0?=
 =?utf-8?B?aHRhSGxFdjJpYmhjVU5ZNkNoTUhxUEhVMlgydkllRm1MNm9MZGdjMlhDcUZI?=
 =?utf-8?B?R3dHcyswRmFQVTcyY2t3N0dXbU5ubHhseWhzeXNpc0Y3czlWSzg3dTc1ZEVU?=
 =?utf-8?B?aTVKWUZDdGo5WVkzd0Y3a1MwZUQwM2VHblAwNHhRV210M0U4VVplUHVwNUZP?=
 =?utf-8?B?am5WR201em5Fb1prYThlTXgrUHk0VG1OQTJKRGJZak8wNHV1bmUwWkZjMmFu?=
 =?utf-8?B?VC9QbUp3YzBZbXRnV2NZV0dDdVFoVDNtcE13Z1N1bHFHMktoSkx6K2R2dk1k?=
 =?utf-8?B?c2swQ3BFQngwRmZaNkJDdUpQT2wrZy9sUzRGTHArbStDekdEZXc5WEN1WjBS?=
 =?utf-8?B?dU9lK0pCOVlLLzZCcU1uV0kxbDJ5b2lxRDExR2FFSytJSGZKdVJ6UlM0VVhM?=
 =?utf-8?B?cjRTZThnZmE2RHpTR05Wci9CcUYwSWRMNmlIa2VLc3JiTnlnQ1F6dFEvOUlx?=
 =?utf-8?B?WFhFZjFBSURFbmxONDZneEJXNExjbjAzdGRzb2N0YVhCZ0NJSVhjVEhMQnlt?=
 =?utf-8?B?TWhpWHh6TWdTVHA2TTNUYy9EWWVnS3RCRHc0dC9yRVRkUEhXY25pRmlRVHll?=
 =?utf-8?B?Qk93L0Jhc1QwdnU4dXc1cngzdVFMcTZXaTZLWnVLL0JOSCtnL2Z5aW01WG5z?=
 =?utf-8?B?WVk0YmZkOWpxbUlLS3Y4T0VuN3VmbHNLbTBDbUEvWFhCRXRUdDNQWTZsRkJQ?=
 =?utf-8?B?dng2MkVNc3FvVGdKTm1xL2l0MDZjYnVLeUhKYUhqcHQvcWhZeVNLeU1nRVhD?=
 =?utf-8?B?MS9RSkZWR0ZzS0c2aTZDVGdYbGZubHI5OUJvb0J2dmtlQmRHa1RMa1JlNFl5?=
 =?utf-8?Q?hLvCYBb1GFVm2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312df07d-09af-4422-bac1-08d946db8150
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:24:43.2014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrK29Er6MHyJJkoG0kG1Wg2VhU5ytWkEoYdWHNLkY/eyvmkTvfU0Iy5MrHSGy2oN9hYelYhKBqeKNlH+2HNRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q29ycmVjdGlvbiBpbmxpbmUuCgpPbiAyMDIxLTA3LTE0IDExOjIyIGEubS4sIEVyaWMgSHVhbmcg
d3JvdGU6Cj4gSGkgRmVsaXgsCj4KPiBJIHdhcyBub3QgYWJsZSB0byByZXByb2R1Y2UgdGhlIFZN
IGZhdWx0IGlzc3VlIG9mIFNXREVWLTI5MjYxMShub3QgCj4gU1dERVYtMjQ5MjQxKSwgd2hpY2gg
aXMgdGhlIG9ubHkgcmVncmVzc2lvbiByZXBvcnRlZCBvbiBNSTIwMC4gU28gdGhlIAo+IHBhdGNo
IGlzIHZhbGlkIHRvIHJldmlldy4gUGxlYXNlIHRha2UgYSBsb29rLgo+Cj4gVGhhbmtzLAo+IEVy
aWMKPgo+IE9uIDIwMjEtMDctMDkgMTo0NSBhLm0uLCBDaGVuLCBHdWNodW4gd3JvdGU6Cj4+IFtQ
dWJsaWNdCj4+Cj4+IE9yaWdpbmFsIHBhdGNoIHdpbGwgY2F1c2UgcmVncmVzc2lvbnMgb24gQWxk
ZWJhcmFuIGFzIHdlbGwsIHNvIHRoaXMgCj4+IHdvcmthcm91bmQgaXMgc3RpbGwgaW52YWxpZC4K
Pj4KPj4gUmVnYXJkcywKPj4gR3VjaHVuCj4+Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
Cj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+
IE9uIEJlaGFsZiBPZiAKPj4gRXJpYyBIdWFuZwo+PiBTZW50OiBGcmlkYXksIEp1bHkgOSwgMjAy
MSAzOjU0IEFNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBDYzogSHVh
bmcsIEppbkh1aUVyaWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT47IEt1ZWhsaW5nLCBGZWxp
eCAKPj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2Ft
ZGtmZDogT25seSBhcHBseSBoZWF2eS13ZWlnaHQgVExCIGZsdXNoIG9uIAo+PiBBbGRlYmFyYW4K
Pj4KPj4gSXQgaXMgdG8gd29ya2Fyb3VuZCBIVyBidWcgb24gb3RoZXIgQXNpY3MgYW5kIGJhc2Vk
IG9uIHJldmVydGluZyB0d28gCj4+IGNvbW1pdHM6Cj4+IMKgwqAgZHJtL2FtZGtmZDogQWRkIGhl
YXZ5LXdlaWdodCBUTEIgZmx1c2ggYWZ0ZXIgdW5tYXBwaW5nCj4+IMKgwqAgZHJtL2FtZGtmZDog
QWRkIG1lbW9yeSBzeW5jIGJlZm9yZSBUTEIgZmx1c2ggb24gdW5tYXAKPj4KPj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gwqAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYyB8IDM3ICsrKysrKysrKysr
KystLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTcg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFy
ZGV2LmMKPj4gaW5kZXggZWJiNDg3MmM1YTlkLi41ZjI2NTVjZjAxNjIgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+PiBAQCAtMTc3MywyNiArMTc3Mywy
OSBAQCBzdGF0aWMgaW50IAo+PiBrZmRfaW9jdGxfdW5tYXBfbWVtb3J5X2Zyb21fZ3B1KHN0cnVj
dCBmaWxlICpmaWxlcCwKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2Nr
KCZwLT5tdXRleCk7Cj4+IMKgIC3CoMKgwqAgZXJyID0gYW1kZ3B1X2FtZGtmZF9ncHV2bV9zeW5j
X21lbW9yeShkZXYtPmtnZCwgKHN0cnVjdCAKPj4ga2dkX21lbSAqKSBtZW0sIHRydWUpOwo+PiAt
wqDCoMKgIGlmIChlcnIpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIHByX2RlYnVnKCJTeW5jIG1lbW9y
eSBmYWlsZWQsIHdhaXQgaW50ZXJydXB0ZWQgYnkgdXNlciAKPj4gc2lnbmFsXG4iKTsKPj4gLcKg
wqDCoMKgwqDCoMKgIGdvdG8gc3luY19tZW1vcnlfZmFpbGVkOwo+PiAtwqDCoMKgIH0KPj4gK8Kg
wqDCoCBpZiAoZGV2LT5kZXZpY2VfaW5mby0+YXNpY19mYW1pbHkgPT0gQ0hJUF9BTERFQkFSQU4p
IHsKPj4gK8KgwqDCoMKgwqDCoMKgIGVyciA9IGFtZGdwdV9hbWRrZmRfZ3B1dm1fc3luY19tZW1v
cnkoZGV2LT5rZ2QsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHN0cnVjdCBr
Z2RfbWVtICopIG1lbSwgdHJ1ZSk7Cj4+IMKgIC3CoMKgwqAgLyogRmx1c2ggVExCcyBhZnRlciB3
YWl0aW5nIGZvciB0aGUgcGFnZSB0YWJsZSB1cGRhdGVzIHRvIAo+PiBjb21wbGV0ZSAqLwo+PiAt
wqDCoMKgIGZvciAoaSA9IDA7IGkgPCBhcmdzLT5uX2RldmljZXM7IGkrKykgewo+PiAtwqDCoMKg
wqDCoMKgwqAgcGVlciA9IGtmZF9kZXZpY2VfYnlfaWQoZGV2aWNlc19hcnJbaV0pOwo+PiAtwqDC
oMKgwqDCoMKgwqAgaWYgKFdBUk5fT05fT05DRSghcGVlcikpCj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbnRpbnVlOwo+PiAtwqDCoMKgwqDCoMKgwqAgcGVlcl9wZGQgPSBrZmRfZ2V0X3By
b2Nlc3NfZGV2aWNlX2RhdGEocGVlciwgcCk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoV0FSTl9P
Tl9PTkNFKCFwZWVyX3BkZCkpCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+
PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFhbWRncHVfcmVhZF9sb2NrKHBlZXItPmRkZXYsIHRydWUp
KSB7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtmZF9mbHVzaF90bGIocGVlcl9wZGQsIFRM
Ql9GTFVTSF9IRUFWWVdFSUdIVCk7Cj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9y
ZWFkX3VubG9jayhwZWVyLT5kZGV2KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChlcnIpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZGVidWcoIlN5bmMgbWVtb3J5IGZhaWxlZCwgd2Fp
dCBpbnRlcnJ1cHRlZCBieSB1c2VyIAo+PiBzaWduYWxcbiIpOwo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBnb3RvIHN5bmNfbWVtb3J5X2ZhaWxlZDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0K
Pj4gLcKgwqDCoCB9Cj4+IMKgICvCoMKgwqDCoMKgwqDCoCAvKiBGbHVzaCBUTEJzIGFmdGVyIHdh
aXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZXMgdG8gCj4+IGNvbXBsZXRlICovCj4+ICvC
oMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYXJncy0+bl9kZXZpY2VzOyBpKyspIHsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGVlciA9IGtmZF9kZXZpY2VfYnlfaWQoZGV2aWNlc19h
cnJbaV0pOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKCFwZWVy
KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcGVlcl9wZGQgPSBrZmRfZ2V0X3Byb2Nlc3NfZGV2aWNlX2RhdGEo
cGVlciwgcCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChXQVJOX09OX09OQ0UoIXBl
ZXJfcGRkKSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFhbWRncHVfcmVhZF9sb2NrKHBlZXItPmRkZXYs
IHRydWUpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga2ZkX2ZsdXNoX3Rs
YihwZWVyX3BkZCwgVExCX0ZMVVNIX0hFQVZZV0VJR0hUKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhbWRncHVfcmVhZF91bmxvY2socGVlci0+ZGRldik7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCB9Cj4+IMKg
wqDCoMKgwqAga2ZyZWUoZGV2aWNlc19hcnIpOwo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+
PiAtLSAKPj4gMi4yNS4xCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDQlN0MwMSU3Q0ppbkh1aUVyaWMuSHVhbmcl
NDBhbWQuY29tJTdDZTMwYjk1NjU2NmI3NDEyNmI3YmEwOGQ5NDZkYjM5NGUlN0MzZGQ4OTYxZmU0
ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NjE4NzI5NjM4MDk0MDIwJTdDVW5r
bm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPVJkTXglMkZuVXhl
c1VSRnJzMUxmZFZXSVBUNHN4WmVjQ1JKNHlUUlp4OGg0ZyUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4K
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDQlN0MwMSU3Q0ppbkh1aUVyaWMuSHVhbmclNDBhbWQuY29tJTdDZTMwYjk1NjU2
NmI3NDEyNmI3YmEwOGQ5NDZkYjM5NGUlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgz
ZCU3QzAlN0MwJTdDNjM3NjE4NzI5NjM4MTAzOTgxJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUzRCU3QzMwMDAmYW1wO3NkYXRhPXpwUUtZUWlxRVVJclQlMkZkaG1xd2k4Q2dvNGNmWkFv
MzNpOTVoOGV0eXBsZyUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
