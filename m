Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4447AC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C7600CC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49C7600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4B46EB7C;
	Fri, 23 Apr 2021 11:30:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A398A6EB7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD8eP1/7DBFE9lp8Nbr9KJ2Xv966I5TdbG8uVULRBYQAl48n5BGmujuQzuK/Rc6XTKMeAEt0o8kLOjQksU9qQ38EP/tmbs1PzVImE4ZlKul6+n19yHUEvXZ3qRX6HYZ5WmIQMnxt7SaNbMVQby37dqIxk7lXP27Eiu68xXYFM1tOoOGu0pv4FbDRkbYT/mijVX+kK8MHVgBQGqIZZyaT3L+cYlr8gIb+30Ht2Y3He3FAgt8b27jyw8J62Vpu+9wm92lfMs7Fe48lw1J+Eah+ZCd3H0qjmvCyqx553mt7w8wi4tu4P/KAVDkxGeMvQbzdazNbRPW1f3jhk6X3Q6sqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrhFdqrBIpk4yASNS6xp82+VTQL1YSHEZNWVRwTYRO4=;
 b=kfATttoyGdyeitQMhPUhOdkkmNLQxp11oA6TO5+EXofdV7ggi8caC/OzCiWjIHU04c6oxrLr27i61LL48geF1Vx2fkmvsFmVEP9b/grsAezdm1F2saO7UANBFIAasYpTU76b9KCHt4I3HIdeWMxW2Di1Q5wkasZoQG5xnHw5jKbnlCQgrAe32LEMzWG00TKE6aSeKmfjAwIAAl2ncFGlmKT8NySGlkvrYIPhM2BuDBFqxgLzZ6V0WaFxMnG59/sWxjkc5BaCl0ewRuB/WxqsnrVxr1LmU2H4diPjDPPpiWf3UhowGRcvkxevLTwfH2KYxzuJ4DNgNezZPaJK96v8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrhFdqrBIpk4yASNS6xp82+VTQL1YSHEZNWVRwTYRO4=;
 b=XICbaB5rIlxbxeKxOxk+N7wMJ3TW/oZlkisI49ZKO+osEkoWW4pEiw05l30LkWI2c4z6Ce0AWiH7qAdrX99tZFGf2ByhIBciRbRZuDzb9+8M56kxElgF26gjmbsqPn7f6AvPnziDtQBFRK22+Aq1odzZOuDrAQQT/GK6dJSv/gw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3968.namprd12.prod.outlook.com (2603:10b6:208:16f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 11:30:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:30:42 +0000
Subject: Re: [PATCH 1/6] drm/amdgpu: expose amdgpu_bo_create_shadow()
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8ff9125-6f16-9a46-9388-644f2ddde834@amd.com>
Date: Fri, 23 Apr 2021 13:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:88a3:b9e2:1bf9:4d38]
X-ClientProxiedBy: PR0P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:88a3:b9e2:1bf9:4d38]
 (2a02:908:1252:fb60:88a3:b9e2:1bf9:4d38) by
 PR0P264CA0114.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 11:30:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6521131d-c5da-4e3b-3743-08d9064b3a6d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3968:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3968493732B73B3F9EB1A88E83459@MN2PR12MB3968.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rp0917LUIp29dSF8nQ7Yvljk3qbt2gBr9a9kWDxuyX9virSHhiDt5vP/4WPdO9Y8jwOJrNAEXRNd/F4ZxjmnSyqFaN/GB72c1om2zW3se5DMKrEtLbwJBFFbULcpSELe3vhLn/pXSbaBQG7xUzVun7nySqG1wY2HreJMAty1s7Y38rhaLRyZFF/9+Uf14NZjokpVf4F5CXwKOiwWsK/HOeIJxUPupvIZNHrD7nIWCaQYiXL/klg9EaNRNBmF6thl3uvCJTS5ksVdwf5VYZNJ07PVk4quaHZvhkJSVUB28fwM2ny/u2E5MFDkz7miynx/exboezyFo0jrjRYExarxs+sve9FrgT4CL/KCetdkTnAukCU7u17ZucB6+PHFTilQ7SUhdAEol90aAsKb5DdK7ikwcPCi1JdNjJI2tzH4LPS+FuuDt9slK9SDiacGWu4U67LK//8OWhW3hMHb2z6k/L6tZnqZqnEVdm2Vdfp5x7pIpFXGYZoc+Btt/mHGj2IoNfVFScXXciZ8l0b2OiRAUISviaYdfTu3E98rKlTUOiUvq2E0jnepGdzoGS7n8f076yT3nei85Njxe3L3kDixyeK5+nVvbdFlDvdUGTQEf2ixh0mVqfgmqTqSUnHYTXWiKWvGtXOtkzBSCLXt5N9tUGP8TAhoBonu2v3L1Y0MHUKYer8ItLDpCSpsJRmDRZsL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(16526019)(66946007)(36756003)(8936002)(8676002)(66556008)(6486002)(83380400001)(6862004)(316002)(86362001)(66476007)(31686004)(31696002)(2616005)(38100700002)(2906002)(52116002)(186003)(4326008)(37006003)(5660300002)(6666004)(478600001)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wk5va3g2NG9vSW8rdytZM3VoNUMyd3RlbHIwVWgvWE1sTGV1QzI2c2Q0bTd0?=
 =?utf-8?B?T2hDY1E2RG5MRVhGRVJKRXQzSEtrRUZtR1JsV1Z2ZmtaTGxTQU5EVTBNd1FE?=
 =?utf-8?B?RHp4YUJhUnFIWm1iWWwwWmpnQ0F3TExVNUxYMzh3bm5wbFVkY1huUmNCaFY5?=
 =?utf-8?B?ZEp2Y3NSQkhKV094dGIraVJoWnVsa2U4ZWVjNVRzUWIyZG1ndzR5K0NVYnFL?=
 =?utf-8?B?Mk1hNE1QbU9TTVcxRk9makxSbEVCcWJjYUpFZXE4clF1Z0ZDMjlSVm5Eb3Fa?=
 =?utf-8?B?NkprUkpLdk9hQjdPeUNtN3RXczFjVWNwMVUwSVVKZ09mMi91NHRkSGhoM21m?=
 =?utf-8?B?QjcwTmZsQXo3QmJlOVNGVE82VEVlOW5kRzhBSFI3MVBqdU1yUythNjNlVFBD?=
 =?utf-8?B?bWdiVDcwbm5NT2JHOUpJMXhSYTJIVnlkcURiUkxrb2Y1Uk9seWl3VnYwc3c4?=
 =?utf-8?B?Sk96ZXlVQXBZeWk0STlraUFia08zUXQ1TExqNjBNcGZ1Z3RxdHJ1MDdmVmMy?=
 =?utf-8?B?REo5Mm1BcUUzZEUrdm9CZ05SK1dhR25YMEo0cDlFV1ppZG1GZ2s4QTRRTklT?=
 =?utf-8?B?M3FlNTR2clZGZHlSemU1SjlZNE1VbmRROHVNTUxjZnRSSDVkSFhRWDUzMmgy?=
 =?utf-8?B?ZDU3S1dlQmx4cFJaS1M4MzFPdkpDNWtuK0E4YmppUkxZd3pqYTZja2hrRFlj?=
 =?utf-8?B?S2pOYkhtZEEyQS80MHFJQ3Z5eFF5ZmtNUEF3aXFDeVcxb0MxaEhYWG1UdWVK?=
 =?utf-8?B?Y1V0S2hQMXdNYVhMazhYbE01LzRJZnBKK0xrMGZwUDdMTHFLcWR6S1VobTBp?=
 =?utf-8?B?UVo1ZWxUQytXWjg3ZHcwQjRWYVluNVMwakJyc1FMTllmeG56eFdRZnlpTWRC?=
 =?utf-8?B?N051K2xMWHZINmNHb2JZQ0xiSFd6eWR3ZTBGOUdLZURUdHZJVVlCdDZUamZI?=
 =?utf-8?B?R0JjcDlzQnlMY25xNlFCUHZJMUxTNGozMXUvYzZQcHEzOFJMYXR5dzJkL2Vw?=
 =?utf-8?B?R0Jlb3JkQUhkeDROMjVLeGpqdGEwNkZWMEUvSnNoMnZJbkhpcVlnVFlmeU9J?=
 =?utf-8?B?RXYwaFU4M3Z3QjN0eGpOK2lKdDB4MTVDZ0tsSkdGWXN0QlQ3UXVZejRHSWlT?=
 =?utf-8?B?ZUdMaGdNeEJNTFJaN2g0L3FVaDluZ3RhVWdqK3NtSmNkR3NLTFN4eS9BQ2lJ?=
 =?utf-8?B?Q29GQ2lVaW9YN2Y0dGl6VnBkSUlxWXJKSzJjMEVYYXF6Ym8rcEw1OGJ3ZTN2?=
 =?utf-8?B?aGV2Y2hiRnh2b3ppNGxaU0FOTlo2S0RLaG9MY216UGErZzk0Rk9tck1FeU9G?=
 =?utf-8?B?UlYwL2FkK0dXczF4OWQrSzJnN2IxZ3VKOXlWdjM5dTFrWmI1ZUdWSlZEdGI3?=
 =?utf-8?B?aml1ZlMwblZ3TWFGVEJUMVV6eUxuc1RJckRSaXhBNGNGa2pHZ1dFMnlCTW5q?=
 =?utf-8?B?enlaRzQ1TlBTc1NhaVdOY3JwSW9CbHR5ZUV2OWFRVGN0TkVZRnVUMys2UzJX?=
 =?utf-8?B?ZmpFVklYdEtHNk9tK0hqVDI3cG1wWFJzSnVPMzd1WGhLLzgrNFZMRjVBOWc2?=
 =?utf-8?B?cnNaVjN5c0hlMGExVTVHbC9OYWFwSmpRS2lmWUhlbmF5TjQzOFdyaUd2YVdI?=
 =?utf-8?B?a0dMQVkybnFKL3lQdGZXQkFwUk5ienVIZXhaYnpNVCtJczM3Qy90OW5SUTcy?=
 =?utf-8?B?TW04b0QzTmp4dVZOUmJpYVAxL0wxbEpuNW5pV1BpUzA1dE9UVzVoc0hEbHp2?=
 =?utf-8?B?SGNaRHdudHZMM0ZqY3hpb2FSQ1czdU16dzZMNkw3RGRxRWF0cVpZdFMxVm1s?=
 =?utf-8?B?djlkUFg2aWJCOGY1bEtqVVNHZFN6OThKZEdvSWlMYU95bzhBeWU0bDJQVjFL?=
 =?utf-8?Q?kHv9AhCVSWRZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6521131d-c5da-4e3b-3743-08d9064b3a6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:30:42.3185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqKgSQXVbMjsuuuUIn+stA5rRRcYrpBnQgLHboFPtpiJv7Z7Da1okOmmEkAIV1dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3968
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
Zm9yIHRoZSBzZXJpZXMuCgpBbSAyMy4wNC4yMSB1bSAxMzoxNyBzY2hyaWViIE5pcm1veSBEYXM6
Cj4gRXhwb3NlZCBhbWRncHVfYm9fY3JlYXRlX3NoYWRvdygpIHdpbGwgYmUgbmVlZGVkCj4gZm9y
IGFtZGdwdV92bSBoYW5kbGluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1v
eS5kYXNAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyB8IDYgKysrLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmggfCAzICsrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jCj4gaW5kZXggMTM0NWY3ZWJhMDExLi45Y2RlYjIwZmI2Y2QgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTYyNSw5ICs2MjUsOSBA
QCBzdGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCj4gICAJcmV0dXJuIHI7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCBhbWRncHVfYm9fY3Jl
YXRlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAtCQkJCSAgIHVuc2lnbmVk
IGxvbmcgc2l6ZSwKPiAtCQkJCSAgIHN0cnVjdCBhbWRncHVfYm8gKmJvKQo+ICtpbnQgYW1kZ3B1
X2JvX2NyZWF0ZV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJCSAgICB1
bnNpZ25lZCBsb25nIHNpemUsCj4gKwkJCSAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKPiAgIHsK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtIGJwOwo+ICAgCWludCByOwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRleCA5NzNjODhiZGYzN2IuLmUw
ZWM0OGQ2YTNmZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfb2JqZWN0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmgKPiBAQCAtMjcxLDYgKzI3MSw5IEBAIGludCBhbWRncHVfYm9fY3JlYXRlX3VzZXIoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkgIHN0cnVjdCBhbWRncHVfYm9fdXNlciAq
KnVib19wdHIpOwo+ICAgdm9pZCBhbWRncHVfYm9fZnJlZV9rZXJuZWwoc3RydWN0IGFtZGdwdV9i
byAqKmJvLCB1NjQgKmdwdV9hZGRyLAo+ICAgCQkJICAgdm9pZCAqKmNwdV9hZGRyKTsKPiAraW50
IGFtZGdwdV9ib19jcmVhdGVfc2hhZG93KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICsJ
CQkgICAgdW5zaWduZWQgbG9uZyBzaXplLAo+ICsJCQkgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8p
Owo+ICAgaW50IGFtZGdwdV9ib19rbWFwKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB2b2lkICoqcHRy
KTsKPiAgIHZvaWQgKmFtZGdwdV9ib19rcHRyKHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKPiAgIHZv
aWQgYW1kZ3B1X2JvX2t1bm1hcChzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
