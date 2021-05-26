Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B550C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40537610A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40537610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18026ECF8;
	Wed, 26 May 2021 13:55:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5926ECF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgdUy6Tcq5josJG71+DaNA+r6c9vjuOt1qnpSYU6ay1/R6jTxx1bftyavF5XCZxrCJfxzqfnd/ElhWOQSXCKsLsnUF0a9VxSwLur+OZ47kvZjjsdL9ZhirSScgwuzZWiFXrz1LfIDDnncgGOLPhhItZ7DDFsTcFuLyp4uVyP3FS9ySWxDOQvKoKoYTc7XJx3HORW9XDZPid5dEdCQcljyAf+MogLNs1pF3HM01HzwBXnuqH15QNZyJwf1udOTbOnVGIRQLPN7kpnm8n93XjDIoIrICMrVO/9bqNplO0+zL3E35UTW2nJ3Jr92j68TKEK3RdsUiFhpoMW4o9tVx1D+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo0KX+ekqSP6vO2nSFGf/88QIC8NlW810wms3LqvlhE=;
 b=BqjDctZoFxxxhQJjrLwP0x+WxNijY+yjoMner+jfZKnwRGOLADcBXosPKQZ/tWUNQWKKe1G/2937a6EJLbI+eLgx+WXGLlPXjlZUr0kUGnFolYiim2Kun3qFTFuxSafPFK60MHsbBysFJgO/LDrnFbZKvbKMkavYRLHlXcjjWjMiccSIHLjTysUq2C5CMXtfP135EtRuDnjgWYmBCE3Sx3nyBGUH5i1cY39ZftQ4L03ikPPC3Egz7y2XMq3ifg2G31cD731Hm9dlvh9Duiq/ZxVIdyQjrc+pyv99rVpJCwA9ovRIJ4dLlqmCedDhwyRO1mADIMUluongMC7AKmC/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo0KX+ekqSP6vO2nSFGf/88QIC8NlW810wms3LqvlhE=;
 b=HClVb0CLDqfY+otr/pCkYRCUs7HaHMSFLfOTp+qPvm2jfvLTn35LvQbPhuqRrx4xERCnWClTKfT0QO22pyunlAQRzKM7HT8i1ddxp9LTBvC1lZmJomTnsu8L+OMmuUa3JwiTFMRQ74iSj0GXD7Gvi3tmBggLaC4Ou+JU+wqPA0Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 13:55:47 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 13:55:47 +0000
Subject: Re: [PATCH] drm/amdgpu: Don't flush HDP on A+A
To: Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <af255014-a915-cf58-2642-f94ae40bd10d@amd.com>
Date: Wed, 26 May 2021 09:55:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend
 Transport; Wed, 26 May 2021 13:55:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f093e04-b226-4afd-1661-08d9204df6ea
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51153514ECB927B3389470E492249@BN9PR12MB5115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NOedvC5gYb50u1NDujRvp9SUTYZ5jLyRYG+mkfUQwNdB+eVOVWMyZRtggAMcVHGZ4kW3xjPXYas+5ITfM1jhmDGfB9AwBqaHdzZA8w6FsMe6h1T1Qyveg73zkS9DRo2DZjFGISL0RyrTN+VFQS887VAsHcEPKxJnJdb/E0paN0ESMNmHw8E/Yk0qkFTOPTZ1WpWv/ZxShJQov5uOjL1iDSzpiZFQ+JQX6e1gtZVQe1enFU453r3JerN4hmAfKEBJ3a578ku2LiNl6v9nccwNaUqgvAAtGMmSDcN6TWkDgUW7NeD2o3qTc165fWE1b3mpGBi3XtqTmqnMEmOa1+ZdJZ7+R0TO/nfjRT9qxyNVNWx5Vuss9w8pkRV5CPTxSjZE1BH310TLnwNkn4JzpXpR8JxKdvAxYquFz4tGC2lpIj3pP6jIyqYV5Vc2Qw4Wmb2g7jzRfRm/JsQSgIhWhFkxDzV8NZlNhCG/8qRYoVkK6bbhc9nGUDxGspMrMAHBl+j1VltjFUPuUCR+W9AydxfWI/xIJgxfayKLZdlEB9/r1HJkwi/o5CiwNkesOHeDpTbIAmiklxcxIJykT75FBBDHw2piQldC+gTh8egiAKKBUm165yKixVDWny1/u/lwapXFgBA+eRDPwO9UhRkl6N/9h8C57Ywkq9caUIMpA/TUL9t1L+Yw0LUf5jH8XxzU+xE1cHIKHf4mAWq49VD+89vbq5DeuHaSlSIxdI61b6Ayeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39840400004)(346002)(956004)(2616005)(44832011)(478600001)(8936002)(26005)(16526019)(966005)(36756003)(186003)(8676002)(110136005)(16576012)(316002)(38100700002)(66476007)(6486002)(86362001)(5660300002)(66556008)(66946007)(31696002)(83380400001)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?djdZSkZnTTJtb3h5R3A5VCtOZ213THQxR1pUekpvd1M2WXJONXFzMUtRVjFY?=
 =?utf-8?B?Mit2OCsrU3Bmb0RjdzhHKzBVdFpnY0hnYXNZVXUyWkhVSGVlT1FiQjR5dW85?=
 =?utf-8?B?bkwzbGkzWmpxRnMxeXJkN0Irc1ZIQjJBNkRqeGVmdzB5VUtMMVUxZGhpUXRt?=
 =?utf-8?B?SkRKZXNTQ0FJRlJiZ2lsNVJmbXBJMmxSbGd6MXNRMVA1ejdzbkJjSW9XTDFG?=
 =?utf-8?B?VmZ4TW1YVVdNMlArYis1aHhUY3lLdVB2N3BRWmZhek5uSHhSWHR1NFJmOUtZ?=
 =?utf-8?B?ZUZsc2o2RXhPZ3Q5VWlNUzY0a0hoQjJJclNKNW56NGF0TXdyOUM4ajBtSWsy?=
 =?utf-8?B?U0xiV293ajVMY01abEkvc0RaSzJOKytIUXFheUhpWEtJMEEvbmxGa0NnY0tN?=
 =?utf-8?B?Q0hSQThrSmhPR045NWxCK1dJOVh5RXR2QUw5bWRFTUZBQUZ3SVFzT25DNW1N?=
 =?utf-8?B?cVQ5MmVzck42N3RvMG90QzZNazVKMnNKbVJoRU84SnpmUUVkMjRsVDR2Zmpq?=
 =?utf-8?B?MjRKQklmNG9wazU4VjJRQ2FFNVJlZ3pJVmlWQ0dLcFdZZWlFU0lVUSsvQjlw?=
 =?utf-8?B?a0RDRG1tWXRva1A3cVFvME90Q0ZLSGxzd2diTmhJOUdpbHdQenNpRmV6Q0VQ?=
 =?utf-8?B?NERITUhFL0Q2M2FjaG5EYXBZVW91MUJwblMwK0FMMnBneTZETnpRTGJqcElr?=
 =?utf-8?B?bmtGN2t0b3lFMCtPTDFZNnJsaUM4TzAxUTRaeVV4dnhETzAya2ttdjVjbzZY?=
 =?utf-8?B?NnNNVEFkSzE4UTlud3c3cm8zb1VXYzY1Q2hUQ2FReDlxbGt3SjdBLzNlRUZr?=
 =?utf-8?B?TTRVMEdTemYxeXhCOVdmSEdMMnR1aEJFdVgvR3Y0b0diVmdMQUU3SDJJcTZt?=
 =?utf-8?B?blFQTVdFWC9ZOUNqVGMzbVBkWXdoVEtQdmVmUVQ2QkJSWitGNzhxa1NJTjlT?=
 =?utf-8?B?ak55ajN0aHZvSENNWE03VG4rQ0dtYktGMmJOWUxVcEFTYWtYd0VYdmZESWNo?=
 =?utf-8?B?TlBPY3lUZ2xnRG10OHFxRnhudWFDSnhHRDhjOHRlZjBaR1UzcnVhSGVGK3dk?=
 =?utf-8?B?NHBCS0xkc1YwbFNzakJjb1lpMi9INDFyQjQvc3BVNEdZdVdCVnJ6VTVmWHQ5?=
 =?utf-8?B?dXp2NDdKVzA0ZVBXMU9MQ3QyRmY4V0xaMTRiL0l1QVFEc09oajB5QVIvYmZo?=
 =?utf-8?B?a1Q4TVNUUHdSTWt3cVZnNHIzRE9sckp2VXBXWDhrVlhVUW5JZE5oOE9PYSsz?=
 =?utf-8?B?N0d3SXU3c2lVelBRRkpxQklGbVNTS2FEcEFkUDBzYlpqTjhJdTV0YjZoM0s0?=
 =?utf-8?B?Qzd0eWdYTThFMURuWWZSbUZ1WlhPNWtpbGJlS04zZXBsU2pqUGcxcjVPSDJk?=
 =?utf-8?B?VzJvcHZTQXFtaXZCQWV3Ri8wMG91cndwSXY2ekY3VTdJTHVXRTc0TXFsbnBP?=
 =?utf-8?B?K2MrbEptRUo0WGczbWZidHhhcGZKOGZLaSt2QTd5a0JGMHMvSWdmMkhkUzZM?=
 =?utf-8?B?YjhMQlFsK21YeFl3NEVOL0pQc2JkcEczeG5jOU0weFd4N2YzUGJuZk9oWFVJ?=
 =?utf-8?B?Q2NZNko5Zm81RmUrT3puMDF2SG1iZU9TaFNkOHFUVko3YjB5MjZzdkYvY2JL?=
 =?utf-8?B?MG50TmMwVk5nRWR3TWhkaEhTc09OVk1EdW5hYjYwaHVkNkxxU0xvNkF0cGg0?=
 =?utf-8?B?SjRJejE4d0pRQTBBWjBidVc5TkFjbkRTR3VaZW1kQVJDNEltdk5sUWEvSkt2?=
 =?utf-8?Q?AU+4KdJEUU35kK8id7bAFg5/dtcvO4NmYXB4twp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f093e04-b226-4afd-1661-08d9204df6ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:55:47.8066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Olkeb+PDhvu9NFkTQbGthIZHcgtEBk2C5/2+hp3Z8z+rVP1Y5KG5ko20CICyf7zgYGvOSH60VAA9pwbc+dHolw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
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

QW0gMjAyMS0wNS0yNSB1bSAxOjU2IHAubS4gc2NocmllYiBFcmljIEh1YW5nOgo+IFdpdGggWEdN
SSBjb25uZWN0aW9uIGZsdXNoaW5nIEhEUCBvbiBQQ0llIGlzIHVubmVjZXNzYXJ5LAo+IGl0IGlz
IGFsc28gdG8gb3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fY3B1LmMKPiBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9jcHUuYwo+IGluZGV4IGFjNDVkOWM3YTRl
OS4uYWVmYjNkMjkyN2Q1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bV9jcHUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bV9jcHUuYwo+IEBAIC0xMDgsNiArMTA4LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fY3B1
X3VwZGF0ZShzdHJ1Y3QKPiBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPiDCoHN0YXRpYyBp
bnQgYW1kZ3B1X3ZtX2NwdV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpw
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiDCoHsKPiArwqDCoMKgwqDCoMKg
IGlmIChwLT5hZGV2LT5nbWMueGdtaS5jb25uZWN0ZWRfdG9fY3B1KQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwoKSSB3b25kZXIgaWYgdGhpcyBjaGVjayBzaG91bGQg
YmUgaW5zaWRlIGhkcF92NF8wX2ZsdXNoX2hkcCBpbnN0ZWFkIHNvIGl0CmNhdGNoZXMgYWxsIHVu
bmVjZXNzYXJ5IEhEUCBmbHVzaGluZy4gT24gdGhlIG90aGVyIGhhbmQsIHRoYXQgd291bGQKc3Rp
bGwgbGVhdmUgdGhlIG1iKCkuIEJ1dCB0aGF0IG1iKCkgaXMgcHJvYmFibHkgbmVlZGVkIGFueXdh
eSB0byBlbnN1cmUKdGhhdCB0aGUgR1BVIHdpbGwgc2VlIGFueSBwcmV2aW91cyBtZW1vcnkgd3Jp
dGVzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+IMKgwqDCoMKgwqDCoMKgIC8qIEZsdXNoIEhEUCAq
Lwo+IMKgwqDCoMKgwqDCoMKgIG1iKCk7Cj4gwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2FzaWNfZmx1
c2hfaGRwKHAtPmFkZXYsIE5VTEwpOwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
