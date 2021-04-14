Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 08:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380BB611F2
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 08:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380BB611F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F0F6E8EF;
	Wed, 14 Apr 2021 08:07:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A52E46E8EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 08:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvmLqTIQImZC/0dQz816WxmaIP66x9lpl1jeDSN0ajgmQ31B8JU0Wk8f8HdYAlJy4k3ZdYiTvchv3ISIkwNYRvwqrkAsMUVkXSlf9zuOZownCTO+eSPOtfzG7z6NNhQaz2eSoSlePkB//ScWvXVS43B7EAQbI2W3AUA45kB2kVfwPEz7OolSixeeOkH54KyioWFc2KoWKWQ7KgfoMjPnshjHn0vGp9cg3k1sCVN2b9K137qUevqRmHE6zT64MGPo+5Ivg0a2spdcHtyLIn8ncPxY3tNGHp36p9PxQuaKGyeRVftyNhbL8Ek7q8/YQraUnuPug+n+FNLK702gUYwiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsB38pxVxV7iQZ9WqBuwguvE6FZ0QKKYpF7zb2dsElY=;
 b=dYHJfmrl4xeu/zd1B+qFEQXJsdATrkHZ/z5zGgyFm9em+s4m6FVnNep8R+QmIHSPus5q52t4dGDxvQJlT4i1npd9rSQfxW5iUXPy/ze0MhXEc5RaulygoXgGFum1I6wv9KKA6iOHeji3dRs9oPfV7WxDRfHvXyN9WGiEcIzvbalgUb4UqYEPqjUmKcjbIskEOc0qG5Jn41OaBu9f8Xq3tqJrJ3Wwf0MDT2w3VE6gxwZqBTyrfGwJDIDshb6aANEQPOsUmGRd6ZkMWiPNDtyGKgBDnfWBSsVBjMSn/2CiJ/gMNMkAqWW1Ps+V1r8i/Y+v0tVFkRJKD9f1qisAMKFeCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsB38pxVxV7iQZ9WqBuwguvE6FZ0QKKYpF7zb2dsElY=;
 b=3tLLkqcq1wxTr0ureKSpMrWz/+FOm0aFxCAypIXPsM3nlMmMgH1J/rdtoUWev8I3UfdE1you2MGjMl6SITpQrmrx6uwSNHXfC5uLtZPhMaeCVqCNNrMQltvGeNmoE+tKDfnH3e9yzAinCuNS/e6/usLl/Aw4KluuZEyjQvZHeD0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1384.namprd12.prod.outlook.com (2603:10b6:903:3d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 08:07:41 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 08:07:41 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use pre-calculated bo size
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210413205740.24120-1-nirmoy.das@amd.com>
 <f785cd6d-7c3e-8967-05e6-ea144832021a@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <79bd2fc9-5bf6-f68e-7193-012fef32d91e@amd.com>
Date: Wed, 14 Apr 2021 10:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <f785cd6d-7c3e-8967-05e6-ea144832021a@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.134] (165.204.84.11) by
 BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Wed, 14 Apr 2021 08:07:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e759103-53b6-4ca0-f127-08d8ff1c604f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB138475F2DD62AE7B6CE2C34C8B4E9@CY4PR12MB1384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHMwgVtfxejo2JED24mQfCcXTtQE8/ERVd/eNsFxqeZcXPzgPP/0oy4fvGZPp16Vb1eQxHtjYhRRUjP11EXB3RdS3wZjWa5RJMiiaiGRkGm1sFmIBAAyEi0tq66yNFlxgbg/gfZu/od2uxwD+MpZBRIzZCOfHv2Y9u9Yv9LdFcDm5Hkk2ef3e0hx4qsr6m40rKQJbKsj07rjTDbmA0CAjPkwCVNFfVUgQAKU9gQQ2ySdhdRz+UmiDPw3AGqsfPVEdDwQbBwS/fCereEBfuW6+v2Stzlvr8xUk9WIppvMYTbbRHQO2/3Yit3CTlf+ETSq4j6l2ANqVD4ARJQ68o4HV1JvXtUbJqvd1NUVK4PCoCE26MHvPF1jQrifdHWsg2zstipGW4KuE53dXJYdZiTVKOIQPG9HbGXgQktYtoRnlggyO0ALxN9xcL/ho0cLUf2SnsXGdMvBu1wv/7tYSQQm1jzHaEk+tNtuOeyt7dZphsU4Bkm7IdS0Wwy+TYaGCgf4A7J89UK2diHTwX5uKFwCWuxEqPHsCnVDenXqisElXHV5MnxMZueSKwSI6aLkxZM9khPPQIPPoPJHnhoSvN1fjv4q7IGTDZJ8zSM81pl6Nt39PmkDXQ9pTb7e3ry7Wv60gBE6Zd+UM2FVn9AXPztbXEbwFNEeSdmTJOGUGY+I30UE0trhRk9lLW+8bHxoeZeaAaSyLMlMmA5qjUsg6fMhQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(956004)(2616005)(8676002)(8936002)(66476007)(31686004)(66946007)(6636002)(66556008)(6666004)(31696002)(110136005)(2906002)(16576012)(316002)(38350700002)(52116002)(186003)(83380400001)(36756003)(26005)(16526019)(53546011)(5660300002)(478600001)(4326008)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eUY1RHg5ZCtqT3BrQVhzTFY1T0prSkU1ckdzRTV6N1JHZ2dMejJyNFNwTlNm?=
 =?utf-8?B?Y3JYVHpqZXlvTHdJSFpGeXNwZXpzZlhiT1pKVDNKb2JZKy9nU2V5OG9hWVIy?=
 =?utf-8?B?Q1Q3WGtxWmJuOGZ3My9IckVIdGVKYVE4bXA2d0ZaM3U0KzQwREZaU0J5R01i?=
 =?utf-8?B?UVJmSC9xVDhuNGRLMHVKR3FMWkdtbzRuL1dqTlhRRnh6T0xObUZjdG12eHdV?=
 =?utf-8?B?SnA0ejBac2lMRDI3RjVJdEZOMUhPR0pnNEgwWHk1cDJmcHY3MHZ0bVVrNTFQ?=
 =?utf-8?B?Wm1ETlRwWmxidXFsbmovSU80LzZzWENvcHphQnJibjE1QklsQ0NWdTRoQTRQ?=
 =?utf-8?B?T3JpL2RjVHJKQ3lUWmpqNmpwVXNvY3p1V0ZuWmpmN3VadjYweXJaeUlDdS9S?=
 =?utf-8?B?dEwxQ3BDbVpGTnZzZFpJVitJdHFFYVB4cFZCZmxPY1hPSzNRVFBJQjFkYzNZ?=
 =?utf-8?B?U0IxRDR3NThkZk9NTlQ5ZmptcmtaRy9Oc3ZyQkw5SE5GL3ZYSHU5eTBEM01k?=
 =?utf-8?B?SWpoMGEvT21pRVh0ZTIyQy9PRmNWa0pXNGVKTG1sVUp0YWhBOWpHOTNKbmJz?=
 =?utf-8?B?R1FtdVNGbmx3V29NckJ0L3NSQ3gwRldUcHhPZXZhVm42WkVrMWl2QnppbWUx?=
 =?utf-8?B?Q3RoWGs5K1hFYll5T0NTOFc0QUlLUXRpWmdWZ1VaaU1paks4VlNOWDlYNW10?=
 =?utf-8?B?ME4vQ2NoNkRERFFwS2pRZWRPK0VJanlRSHZOdDVSOGdtVlZRb2s5dFRua3No?=
 =?utf-8?B?OHJjNC9GNVFEQS9naUxQQWVHNTNTV0QzKy9YWnVWREVsWko1Y3l2b1N5aHh6?=
 =?utf-8?B?ZDdMQStpVi96UnZJOXdQbm5sOHcvNzgzQm81dHR5R2R0NGUrYzU2Z1FyUGRy?=
 =?utf-8?B?OUxXaXFQSjZDdDVNK0g2Vk1QUjI1NFBXRmFUeE5BcjFzTUVKT2V5cm0vK1lG?=
 =?utf-8?B?aWJpYmdpQmhJT1BJcG9lOFk1U1A3Z2ZpTnRmMzl5eGJvVmdtU3p3NWxUVDRL?=
 =?utf-8?B?ZUlSeU5QZDFKY2pqaEhGUHdxeW9VcW5uUGk4dHp3bFpZZWorTlcvL0VjdUJU?=
 =?utf-8?B?NlFQTlpBQmJ3UXNuTitVQS84REVTci9sd2NBcUpVWG9SeEptVUZTOUp3S0dI?=
 =?utf-8?B?TktjVUtDclJXSkVYejh6YXpTdDlsbmdTUjBkaXp2Ui9hM2NhSGp1ejFuMk5U?=
 =?utf-8?B?SXBCOUllazhDMk5iZVYvYzY5bW9QOXdHMHczSnM1dHZkZmhnY2Rsa1BvMHRo?=
 =?utf-8?B?bUNPdW8wY3EzN1ZPQ0tkMTlUenBRVzlKRmNPaENPT3NrT0gyaTRERDJYN3lQ?=
 =?utf-8?B?Tmg2eTNmc1FHKzluOTJqc0tCM1VxREpwOW5MTnVNUjl5WFlYc0o2WU91TThI?=
 =?utf-8?B?Qy9ZTkxzMmRxUldzMFpyTHFHbmExRG14ODV4NVJHQ3hVdml4SThrcnlHZmxH?=
 =?utf-8?B?WkdVQkdkWFJ3M3ZqRDNXT2dJN3dPTnRqV0dzeHpycFVUWnJSN1pQQi9CUEZV?=
 =?utf-8?B?VjdYUERkRW4vKzNKcUpuMUY4bVpnUFlOT2F3Si9zeGNRaDNEYlp6RGpFeDdF?=
 =?utf-8?B?ODFMTlhJTys4YTIzbkhlS1k5SnNwZW5kemxUcnY3U3JkcFZwR216bFozSlFi?=
 =?utf-8?B?L2hvUVBNZTh3Z3dDdTljK3MzUU01aEU0RDFoUTltbnNhRFp4Vm1VeWVLbW5O?=
 =?utf-8?B?cHFWZ1BBZmkwRnZKWFBidkp6bmhubXBpLzlFaGUxSmRTbXNHRGMzVE9MWk9s?=
 =?utf-8?Q?VkjNqewSyrTQAZUpoqcvSFUP2OZaNRbUsXKLSFT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e759103-53b6-4ca0-f127-08d8ff1c604f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 08:07:41.6172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Uur/mdS1TWs36nA/EDZhZ1CFAPLLV8DkPt4JcpOGJfiOlsMBYGF0eRlxEoJK+EA/krpMk/PH7/igfAr6dqsqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1384
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMTQvMjEgODo1MiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxMy4wNC4y
MSB1bSAyMjo1NyBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFVzZSBiby0+dGJvLmJhc2Uuc2l6ZSBp
bnN0ZWFkIG9mIGNhbGN1bGF0aW5nIGl0IGZyb20gbnVtX3BhZ2VzLgo+Cj4gVGhvc2UgZG9uJ3Qg
Y2xhc2ggd2l0aCB0aGUgdHdvIEkndmUgc2VuZCBvdXQgeWVzdGVyZGF5LCBkb24ndCB0aGV5PwoK
Ckl0IGRvZXMsIEkgZGlkbid0IGNoZWNrIGRyaS1kZXZlbCdzIFtQQVRDSCAxLzddIGRybS9ub3V2
ZWF1OiB1c2UgCmJvLT5iYXNlLnNpemUgaW5zdGVhZCBvZiBtZW0tPm51bV9wYWdlcykgc2VyaWVz
IHllc3RlcmRheS4KCgpSZWdhcmRzLAoKTmlybW95CgoKPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAyICstCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uY8KgwqDCoCB8IDIgKy0KPj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgCj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4+IGluZGV4IDEzNDVmN2Vi
YTAxMS4uNzRlY2MwYzE4NjNmIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCj4+IEBAIC0xMzcxLDcgKzEzNzEsNyBAQCB2bV9mYXVsdF90IAo+PiBh
bWRncHVfYm9fZmF1bHRfcmVzZXJ2ZV9ub3RpZnkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bykKPj4gwqDCoMKgwqDCoCBpZiAoYm8tPm1lbS5tZW1fdHlwZSAhPSBUVE1fUExfVlJBTSkKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCAtwqDCoMKgIHNpemUgPSBiby0+bWVt
Lm51bV9wYWdlcyA8PCBQQUdFX1NISUZUOwo+PiArwqDCoMKgIHNpemUgPSBiby0+YmFzZS5zaXpl
Owo+PiDCoMKgwqDCoMKgIG9mZnNldCA9IGJvLT5tZW0uc3RhcnQgPDwgUEFHRV9TSElGVDsKPj4g
wqDCoMKgwqDCoCBpZiAoKG9mZnNldCArIHNpemUpIDw9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1f
c2l6ZSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBpbmRleCA5MzZiM2NmZGRlNTUuLjI2ZGVhY2U3
ODUzOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+PiBA
QCAtMjA0OCw3ICsyMDQ4LDcgQEAgaW50IGFtZGdwdV9maWxsX2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1
X2JvICpibywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgwqDC
oMKgwqAgfQo+PiDCoCAtwqDCoMKgIG51bV9ieXRlcyA9IGJvLT50Ym8ubWVtLm51bV9wYWdlcyA8
PCBQQUdFX1NISUZUOwo+PiArwqDCoMKgIG51bV9ieXRlcyA9IGJvLT50Ym8uYmFzZS5zaXplOwo+
PiDCoMKgwqDCoMKgIG51bV9sb29wcyA9IDA7Cj4+IMKgIMKgwqDCoMKgwqAgYW1kZ3B1X3Jlc19m
aXJzdCgmYm8tPnRiby5tZW0sIDAsIG51bV9ieXRlcywgJmN1cnNvcik7Cj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
