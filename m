Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C7C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7110761164
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 21:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7110761164
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3746E427;
	Mon, 21 Jun 2021 21:46:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 908A76E427
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 21:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHXPCeDXz48UNAgDX5lYtFBrYo/BYq/uxCX2vuca0Yl+PGAgpNqcY13XMVJF0UqKMEQEFSq8bw0k+dIbeqO6n7pc/RHTUhAEzZCpzh6CcO3LOl6ISM4pXM0Sm1tPMhzGfobyRuGTGB2nLunkb8vS1fwCshh6+/a5AIcB7YUrFo1HR3frDD2snMlQT5DvdUlVlSftTyxkPVz6sxM04tedAnxNGNYXplRHr5k03WRrJhYSzG/ald2gKfcp7g1eLJCl/naDWgkPbOT8MTbi52p0P/JxE6zja5m2BK59qP42fSOPKAv26nzPQGMp7lUOPU4s2h/aCJ6HtAlYh33BpfWLaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8bQToX4Xxbg1EwtjoejdCeHSGwMHKJwuTmcWdNZCZw=;
 b=OnVie/V60qC2aP3EQ22wYnbpwiOf3l3Xc3UCQRYdf1YvJrSDxQ11C5vyUWGMMHWKDZly3DNKhsvDSLA2RdQwPSx2LqpYUYVpBQoubespaYVJWENs/CDsxF5nMCM2YQU+DBcgddvWtRLVwk+M///+T2xxI9+ylHQBXhW1pINbopJ+Z+WYR8Hm/c84C8Z7shfzLqKb8+5R0z0JMpBJiRUP64F1g0FgmEqM6WBHXkVMg9ud6dmtGZ0duottZUgggzBDXNRN1xVNe1CCjjK9qKeDpraelQgPVFW9CuYHXpVI1Km6xP2HKeNwO12lP79f2X/3bRgdg8wdiODUP9T4D4M2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8bQToX4Xxbg1EwtjoejdCeHSGwMHKJwuTmcWdNZCZw=;
 b=BRbY/9vNC2Gl2kZiOw4ex8Luv7I3FwZ+FvP7HudY2+JuVsHkN4VKkBo3947m6UwJrrIZ/jnjLfOY8D4finKWdgtVDa44OIdM239oz2PrBfbeLFy/tqfjJN5d+X1Vrn2CUQeO1nl9xzfKaqAzukm8l1iTb//sDGBxAU+wf4yD76Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5307.namprd12.prod.outlook.com (2603:10b6:408:104::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Mon, 21 Jun
 2021 21:46:17 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 21:46:17 +0000
Subject: Re: [PATCH 10/10] drm/amdkfd: protect svm_bo ref in case prange has
 forked
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210621160423.3517-1-alex.sierra@amd.com>
 <20210621160423.3517-10-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <2948e0c8-29c9-0085-f5de-ac9e0f8c61ba@amd.com>
Date: Mon, 21 Jun 2021 17:46:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210621160423.3517-10-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 21:46:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc47548f-af84-4bb5-a3b6-08d934fdff9e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5307:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB53075007B140D2BD92046197920A9@BN9PR12MB5307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSf7kHBMs9CWDoDWorgaAuNu3x/AOBf8xe8/6hi0jjsvqKxucJVDORcx/wH+79yZD4N/xbwBUpx64XHVln+UTLhrZb1Ww6JQedQZNmjkf3Emg/aUv9QQ4PD4rSVVk2UeXxRvLBBqfP3pPb+r3hf40OzAyuYSjDPy5YQVirexjSRd4Jhh164XfbF8/fP+06l8pFcYx5z8/Mdgq0AK0fnUuN5NjQ8YmcXXOIO5ebLI9HUlzuAbSquX4QbADHAgKLwzCjGjabntXe4KNqtinU4Nrdyk9mpuuV/C40q70rsYPXujlz2J2JkaQIhMxdrN58yGBpFmvRkcco9ApUfwREOUuGoLv04NP/ocjzZx7kvVi6Uo8SHeEP/8ISO6J0AYAOvtM3Cp5P8JXkBYvogxRZ5Kamp3/F0jRfXYN1lMUhSDJD1+UOcnveKyeuRCAZFatKTmkwfDaPfcqKV9isGBeJCcekGyGok+tdPjmPR0M3hWv61PpKM2A5Un4XVVNj3Z4xO1W9ZX1iX9iz84FtScDAiiIBL2IXUiSjT25oq4pcgygqb26tXZm6mts8/g6d4xl6AX7lplt4O1yK7TPjgf75xkIPeCZcy2ZqSgUyNSnX9FhQ4ZKTW8/rjY/WjFue/ISeiDgGN8bjXyUhrWpMhDSurP0tUm0jMOjdCwfRWA7YU6gG0lgF5Gte1NlK4sDSw+L87f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(83380400001)(86362001)(36756003)(5660300002)(31696002)(66556008)(66476007)(66946007)(2616005)(956004)(186003)(31686004)(16526019)(38100700002)(316002)(16576012)(8936002)(8676002)(2906002)(36916002)(6486002)(44832011)(478600001)(26005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlMemlsY2pwSThtN0JDdVZDNHRLQ3QwWExrVFZoQmE0SXprUUtMVUVuOWpt?=
 =?utf-8?B?YTQ0UGM3SXRqRFREU01JQ29mcVFvbVZqcXRjOUI4SzQ1SzlvMW52aFhrcm1h?=
 =?utf-8?B?Vm5UQm9TbkNmcHVOOER2K05ERWxoTnluUk9TWURGZHBxaHY2UEV4dFBHUGJH?=
 =?utf-8?B?ZFJkU1o4MFRaVkx1TWJQRXplZFJEU0xTMlE3Y0JjSWlwd3M3ei84cXlyYm44?=
 =?utf-8?B?R0NXSjFQdTNJZDRYb3FvSjNpdUlvZ0ZvWVgzZnNkLytaR2xsWksreXJKTWtn?=
 =?utf-8?B?Ukg3T0JEeGV0azdtamJ5cElOZ0NVZ21lWGRBU24xakkxVmNoRlFKWWlBbFpm?=
 =?utf-8?B?MjdXY0UyVUJ2YmI2TjVacTZQTTQveU55ZFc3ek5SUFFrdTducDVWK29iblNz?=
 =?utf-8?B?cE9rMUtRN1BlSmZSMlh6OUNTaWhvQjlvTFJQeWRua0dvWFNmWUppbFlyMTFK?=
 =?utf-8?B?Y29VVU5zK0xGWG0rZmRCVVZBb25RQ1Y1Tnp1V1dScWdmb0t6ODhadkczM3RL?=
 =?utf-8?B?cE5qNjVIVENjTnJSaUZmZU1xQUNMQ3o4YldPNkFFQVdsUDdFVjVKSWRJMmc3?=
 =?utf-8?B?eGFpVzdDUmtDTW9aUUUycFB4TEQydFBtVzd2VWExZUQ5WjhDSTZCRTJjKzRG?=
 =?utf-8?B?MEJSNVd5YlZPTFdjWG55UkFYcGVLMC9uTVJnMFBkQ3ZxSmZxSVBza1o4OTdz?=
 =?utf-8?B?ZHc2OVgweWtleExjZXpRL3FVQVJWcFNlbHBuVE1idENpQ3poT0pMMXhsTVUy?=
 =?utf-8?B?a0xmd0xuR0lsUXA5NFplWTdMUlBTSFJsVHJ0TnpiOWx0ZFh3L2FxeWJpQnhS?=
 =?utf-8?B?K0FNcEdwdlFJc3l0RjBhek1IamwrWFRIY25qSnVacGJqeEZTSUVUU2pyVEZL?=
 =?utf-8?B?YnFESTNYRk92ZkpvZ3RYMjhjdFAvMTU0cW52SnNWekxJd2Vna0cyZ2hUYTM2?=
 =?utf-8?B?QmhSbkxuQVErK21BVWJTemV2ZENBMU9RQUMrNGlQSmt2MDF3dDlxd2lRSFA3?=
 =?utf-8?B?TTZZcm1MUnlXdFBGdFBGUms1dkRTZFBURzN1elB5bjB3VEJQbkdCbXQ2Uys0?=
 =?utf-8?B?ZE9uM2ptamY0VE55RTNJakJ3N3lscndmUnZ0cVJpelNibjQ2Wm9tbS96b0Ra?=
 =?utf-8?B?bGVKb05QQUpOTjkvb2x1MHFDQ3Uwd2Vmd3VKc0hHRHcvUkpkV2t5S2kvVG5E?=
 =?utf-8?B?RW0rSzE4RFkwOU1wbm8yUjBnYzBlWm52L1FPejB0aVZSbUVlbWoyVVdORDFw?=
 =?utf-8?B?dGFuZlZlNEI3RTRRWWJtMndBMUhCQWNVWElpWWRFaSs2YlZ1MGp2dnhBRkFq?=
 =?utf-8?B?LzdoaGZSbzI2K1dZMkxpb2FQR2dCY1ZDa3ZiczcxUW1US1BhSEdFWnhOU2ZQ?=
 =?utf-8?B?K3VpazNLRTNmV1lZOHFqQUFZQnRaMmFXQXRnMXdrR25mWURxc2NZTTdKNXdq?=
 =?utf-8?B?a2VVVnNHSklFczBOY1dJU0RNc2lvQmZLOWRITm1UOXlYV0cyVFpBMHJXaG5W?=
 =?utf-8?B?TUpEL29acXdDbWppbzBwUlg0T0RuUW5HZWZkeUNucTVlOG8xUFB6emJaYTIv?=
 =?utf-8?B?T0JRVVZSRHhYZFhacWloQy8zdDlXRHdwSkV4N1U0YS9aMkYvMHhRamhvL3VX?=
 =?utf-8?B?WlRRRGYyRy85MjVjWjc5UTdFTlJBYXZpUWpCaFdabmJPK21xSi9VaExhcG05?=
 =?utf-8?B?S3pSS210cDJtQ2hkNGZ0V0dHaG9la1RlWVlOKzUyNW5nWGVKMEszS0JqQ2la?=
 =?utf-8?Q?/AxXg8f8LA5/dDZg76zZhTy3Mrfm6diPUFCxyKt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc47548f-af84-4bb5-a3b6-08d934fdff9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 21:46:17.1922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZlR+5pMTDoqli5Ldjl1uzHMePJ9uXbf762cO33giT7Wd4kO28iRC8P44Y5XoNTvezd1RXHKUcISGVgBKKiytA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5307
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

T24gMjAyMS0wNi0yMSAxMjowNCBwLm0uLCBBbGV4IFNpZXJyYSB3cm90ZToKPiBLZWVwIHRyYWNr
IG9mIGFsbCB0aGUgcGFnZXMgaW5zaWRlIG9mIHByYW5nZXMgcmVmZXJlbmNlZCB0bwo+IHRoZSBz
YW1lIHN2bV9iby4KClRoaXMgZGVzY3JpcHRpb24gaXMgYSBiaXQgY29uZnVzaW5nIGJlY2F1c2Ug
eW91J3JlIG5vdCB0cmFja2luZyBwYWdlIApyZWZlcmVuY2VzIGJ1dCBCTyByZWZlcmVuY2VzLgoK
Cj4gICBUaGlzIGlzIGRvbmUsIGJ5IHVzaW5nIHRoZSByZWYgY291bnQgaW5zaWRlIHRoaXMgb2Jq
ZWN0Lgo+IFRoaXMgbWFrZXMgc3VyZSB0aGUgb2JqZWN0IGhhcyBmcmVlZCBhZnRlciB0aGUgbGFz
dCBwcmFuZ2UgaXMgbm90IGxvbmdlcgo+IGF0IGFueSBHUFUuIEluY2x1ZGluZyByZWZlcmVuY2Vz
IHNoYXJlZCBiZXR3ZWVuIGEgcGFyZW50IGFuZCBjaGlsZCBkdXJpbmcKPiBhIGZvcmsuCgpSZWZl
cmVuY2VzIHRvIHRoZSBCTyBhcmUgbm90IHJlYWxseSBzaGFyZWQgYmV0d2VlbiBwYXJlbnQgYW5k
IGNoaWxkIApwcm9jZXNzZXMuIFRoZXkgc2hhcmUgcGFnZSByZWZlcmVuY2VzLiBXaGF0IHdlJ3Jl
IGRvaW5nIGhlcmUgaXMsIHdlJ3JlIApyZW1vdmluZyBhc3N1bXB0aW9ucyBhYm91dCB0aGUgbGlm
ZXRpbWUgb2YgdGhlIHN2bV9ibyBieSB0eWluZyBpdCB0byB0aGUgCmxpZmV0aW1lIG9mIGFueSBw
YWdlcyByZWZlcmVuY2luZyBpdC4KCkknZCBzdWdnZXN0IHRoaXMgZGVzY3JpcHRpb246Cgpkcm0v
YW1ka2ZkOiBNYWludGFpbiBzdm1fYm8gcmVmZXJlbmNlIGluIHBhZ2UtPnpvbmVfZGV2aWNlX2Rh
dGEKCkVhY2ggem9uZS1kZXZpY2UgcGFnZSBob2xkcyBhIHJlZmVyZW5jZSB0byB0aGUgU1ZNIEJP
IHRoYXQgbWFuYWdlcyBpdHMgCmJhY2tpbmcgc3RvcmFnZS4gVGhpcyBpcyBuZWNlc3NhcnkgdG8g
Y29ycmVjdGx5IGhvbGQgb24gdG8gdGhlIEJPIGluIApjYXNlIHpvbmVfZGV2aWNlIHBhZ2VzIGFy
ZSBzaGFyZWQgd2l0aCBhIGNoaWxkLXByb2Nlc3MuCgoKPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXgg
U2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IENoYW5nZS1JZDogSWJmZTVlZmJmZWQyOGMy
ZDc2ODFmZTA5MTI2NGE1ZDBkNWYzNjU3YjIKClBsZWFzZSByZW1vdmUgdGhlIENoYW5nZS1JZC4K
Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYyB8IDEw
ICsrKysrKysrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyAgICAg
fCAxMCArLS0tLS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmgg
ICAgIHwgMTAgKysrKysrKysrLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbWlncmF0ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3Jh
dGUuYwo+IGluZGV4IGFjYjlmNjQ1NzdhMC4uYzhjYTMyNTJjYmMyIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCj4gQEAgLTI0NSw3ICsyNDUsNyBAQCBzdm1f
bWlncmF0ZV9nZXRfdnJhbV9wYWdlKHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwgdW5zaWduZWQg
bG9uZyBwZm4pCj4gICAJc3RydWN0IHBhZ2UgKnBhZ2U7Cj4gICAKPiAgIAlwYWdlID0gcGZuX3Rv
X3BhZ2UocGZuKTsKPiAtCXBhZ2UtPnpvbmVfZGV2aWNlX2RhdGEgPSBwcmFuZ2U7Cj4gKwlwYWdl
LT56b25lX2RldmljZV9kYXRhID0gcHJhbmdlLT5zdm1fYm87Cj4gICAJZ2V0X3BhZ2UocGFnZSk7
Cj4gICAJbG9ja19wYWdlKHBhZ2UpOwo+ICAgfQo+IEBAIC0zMzYsNiArMzM2LDcgQEAgc3ZtX21p
Z3JhdGVfY29weV90b192cmFtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qgc3Zt
X3JhbmdlICpwcmFuZ2UsCj4gICAJCQlzdm1fbWlncmF0ZV9nZXRfdnJhbV9wYWdlKHByYW5nZSwg
bWlncmF0ZS0+ZHN0W2ldKTsKPiAgIAkJCW1pZ3JhdGUtPmRzdFtpXSA9IG1pZ3JhdGVfcGZuKG1p
Z3JhdGUtPmRzdFtpXSk7Cj4gICAJCQltaWdyYXRlLT5kc3RbaV0gfD0gTUlHUkFURV9QRk5fTE9D
S0VEOwo+ICsJCQlzdm1fcmFuZ2VfYm9fcmVmKHByYW5nZS0+c3ZtX2JvKTsKCkl0IHdvdWxkIGJl
IGNsZWFuZXIgdG8gbW92ZSB0aGlzIGludG8gc3ZtX21pZ3JhdGVfZ2V0X3ZyYW1fcGFnZSwgd2hl
cmUgCnlvdSBhc3NpZ24gdGhlIHByYW5nZS0+c3ZtX2JvIHJlZmVyZW5jZSB0byBwYWdlLT56b25k
ZV9kZXZpY2VfZGF0YS4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKCj4gICAJCX0KPiAgIAkJaWYgKG1p
Z3JhdGUtPmRzdFtpXSAmIE1JR1JBVEVfUEZOX1ZBTElEKSB7Cj4gICAJCQlzcGFnZSA9IG1pZ3Jh
dGVfcGZuX3RvX3BhZ2UobWlncmF0ZS0+c3JjW2ldKTsKPiBAQCAtNTQwLDcgKzU0MSwxMiBAQCBz
dm1fbWlncmF0ZV9yYW1fdG9fdnJhbShzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsIHVpbnQzMl90
IGJlc3RfbG9jLAo+ICAgCj4gICBzdGF0aWMgdm9pZCBzdm1fbWlncmF0ZV9wYWdlX2ZyZWUoc3Ry
dWN0IHBhZ2UgKnBhZ2UpCj4gICB7Cj4gLQkvKiBLZWVwIHRoaXMgZnVuY3Rpb24gdG8gYXZvaWQg
d2FybmluZyAqLwo+ICsJc3RydWN0IHN2bV9yYW5nZV9ibyAqc3ZtX2JvID0gcGFnZS0+em9uZV9k
ZXZpY2VfZGF0YTsKPiArCj4gKwlpZiAoc3ZtX2JvKSB7Cj4gKwkJcHJfZGVidWcoInN2bV9ibyBy
ZWYgbGVmdDogJWRcbiIsIGtyZWZfcmVhZCgmc3ZtX2JvLT5rcmVmKSk7Cj4gKwkJc3ZtX3Jhbmdl
X2JvX3VucmVmKHN2bV9ibyk7Cj4gKwl9Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQKPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gaW5kZXggZWJjMWFlN2U1MTkzLi40YjVmYzIz
NzU2NDEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jCj4gQEAgLTMwOSwx
NCArMzA5LDYgQEAgc3RhdGljIGJvb2wgc3ZtX2JvX3JlZl91bmxlc3NfemVybyhzdHJ1Y3Qgc3Zt
X3JhbmdlX2JvICpzdm1fYm8pCj4gICAJcmV0dXJuIHRydWU7Cj4gICB9Cj4gICAKPiAtc3RhdGlj
IHN0cnVjdCBzdm1fcmFuZ2VfYm8gKnN2bV9yYW5nZV9ib19yZWYoc3RydWN0IHN2bV9yYW5nZV9i
byAqc3ZtX2JvKQo+IC17Cj4gLQlpZiAoc3ZtX2JvKQo+IC0JCWtyZWZfZ2V0KCZzdm1fYm8tPmty
ZWYpOwo+IC0KPiAtCXJldHVybiBzdm1fYm87Cj4gLX0KPiAtCj4gICBzdGF0aWMgdm9pZCBzdm1f
cmFuZ2VfYm9fcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3JlZikKPiAgIHsKPiAgIAlzdHJ1Y3Qgc3Zt
X3JhbmdlX2JvICpzdm1fYm87Cj4gQEAgLTM1NSw3ICszNDcsNyBAQCBzdGF0aWMgdm9pZCBzdm1f
cmFuZ2VfYm9fcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3JlZikKPiAgIAlrZnJlZShzdm1fYm8pOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyB2b2lkIHN2bV9yYW5nZV9ib191bnJlZihzdHJ1Y3Qgc3ZtX3Jh
bmdlX2JvICpzdm1fYm8pCj4gK3ZvaWQgc3ZtX3JhbmdlX2JvX3VucmVmKHN0cnVjdCBzdm1fcmFu
Z2VfYm8gKnN2bV9ibykKPiAgIHsKPiAgIAlpZiAoIXN2bV9ibykKPiAgIAkJcmV0dXJuOwo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmggYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmgKPiBpbmRleCAyN2ZiZTE5MzY0OTMuLjIxZjY5
Mzc2N2EwZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3Zt
LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmgKPiBAQCAtMTUw
LDYgKzE1MCwxNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc3ZtX3JhbmdlX3VubG9jayhzdHJ1Y3Qg
c3ZtX3JhbmdlICpwcmFuZ2UpCj4gICAJbXV0ZXhfdW5sb2NrKCZwcmFuZ2UtPmxvY2spOwo+ICAg
fQo+ICAgCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHN2bV9yYW5nZV9ibyAqc3ZtX3JhbmdlX2Jv
X3JlZihzdHJ1Y3Qgc3ZtX3JhbmdlX2JvICpzdm1fYm8pCj4gK3sKPiArCWlmIChzdm1fYm8pCj4g
KwkJa3JlZl9nZXQoJnN2bV9iby0+a3JlZik7Cj4gKwo+ICsJcmV0dXJuIHN2bV9ibzsKPiArfQo+
ICsKPiAgIGludCBzdm1fcmFuZ2VfbGlzdF9pbml0KHN0cnVjdCBrZmRfcHJvY2VzcyAqcCk7Cj4g
ICB2b2lkIHN2bV9yYW5nZV9saXN0X2Zpbmkoc3RydWN0IGtmZF9wcm9jZXNzICpwKTsKPiAgIGlu
dCBzdm1faW9jdGwoc3RydWN0IGtmZF9wcm9jZXNzICpwLCBlbnVtIGtmZF9pb2N0bF9zdm1fb3Ag
b3AsIHVpbnQ2NF90IHN0YXJ0LAo+IEBAIC0xNzgsNyArMTg2LDcgQEAgdm9pZCBzdm1fcmFuZ2Vf
ZG1hX3VubWFwKHN0cnVjdCBkZXZpY2UgKmRldiwgZG1hX2FkZHJfdCAqZG1hX2FkZHIsCj4gICB2
b2lkIHN2bV9yYW5nZV9mcmVlX2RtYV9tYXBwaW5ncyhzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2Up
Owo+ICAgdm9pZCBzdm1fcmFuZ2VfcHJlZmF1bHQoc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLCBz
dHJ1Y3QgbW1fc3RydWN0ICptbSwKPiAgIAkJCXZvaWQgKm93bmVyKTsKPiAtCj4gK3ZvaWQgc3Zt
X3JhbmdlX2JvX3VucmVmKHN0cnVjdCBzdm1fcmFuZ2VfYm8gKnN2bV9ibyk7Cj4gICAjZWxzZQo+
ICAgCj4gICBzdHJ1Y3Qga2ZkX3Byb2Nlc3M7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
