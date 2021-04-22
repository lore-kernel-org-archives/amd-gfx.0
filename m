Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E89C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DBA961445
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 08:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DBA961445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278E06E047;
	Thu, 22 Apr 2021 08:04:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF666E047
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 08:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIyVTdpKWeqQxYjZhwseLXRyyOJjrplTM3fhV5xaGbY3dIrI/MZ3Ahvh536ezVV7D1PtTgwfFU4d4ubIDHPw5nG71za1ZaaN5xb0Ew5+7pXgVSLZ/iDatFSlMBtnTCr7pCweI0gBfVV0tF/ftqLY9WvX+94fz3YTUQmv6K1wL9gOLZHPocvuQAmDMvAgxx/uNIeehtemQm3YRg4xtF9nhkEwEVsFVxFB55z0s47EGs9NGE7FtOoMa9Ywz6VqR6j07ATuDxsk4LB3vpTDxtd4DECK4rEtHEKk+FGcFNjjVGEJtrjOQdRzxA5Hl+yNTy1Xm87YkK236kZsN9N5QGCojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBfdXNuxAjsnYWcTVL2sr7DN725vTufqM8q2kPbOnpg=;
 b=UFXZT1triIZMjuk1Gyn5EPa9TxvX425pExXvdfk+6KUn6gw83wjMN+TvbCFGCd69lUqWlpXS0pJUlwKXoGLsfjbv09y5A+q7Q3B6R7V5ohB+l8CW6RxGxU1+8X7/H1zt3gmJMjOlaba97ccaxc2gdUIZq2HrJb4/GZ3Mqek4nhfC+r77AVbNfFCcNrJ/tzhmtz9WGzTwqBKHOOo9sOLoRUtWn8693wg1KRlMQ0ywFICRzOZm7zz688oY496/eGqHOEL4qIm5n9zg3R8+rqPuQfU/hwGWD3IfI7sJJiLknVxayV1zrZzYN/oDOZpVhMaLc83ZpcFRUukaUPFCoW3AHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBfdXNuxAjsnYWcTVL2sr7DN725vTufqM8q2kPbOnpg=;
 b=boUSB6q9mt/7aWwtF1gPuX691RkzvIyZ98dNZPAv708lawTPTrH+0w40ryrgqPI1MP2P0GoN7bepei3Sn3O7cIjfR7/LsVICpuW/NnNSztBQ1G2M2j1Zro3y6snbhiuBr/7x4FWAPPEp1SbHErKiGgTAPu3ixNi5XVRVMFBvka8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Thu, 22 Apr
 2021 08:04:42 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 08:04:42 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: create shadow bo using
 amdgpu_bo_create_shadow()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210421163523.14493-1-nirmoy.das@amd.com>
 <20210421163523.14493-2-nirmoy.das@amd.com>
 <bb44558e-44dd-303b-de5f-9cefb584dbb0@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ad7a26ac-4c41-5317-c3f7-a3a418d9951a@amd.com>
Date: Thu, 22 Apr 2021 10:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <bb44558e-44dd-303b-de5f-9cefb584dbb0@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::31) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.127.111) by
 AM8P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:04:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a324bc44-e68c-403d-cfa3-08d9056548a8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18455472F6210389046669718B469@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwILkdPjo4F9LyKSfnytACB7CTBG4aOO0qol0ZQIWcJe3egNzLLmKpchWMg7/0qzeSmjz9USoMriJtQ1e3sLlVwQlba7k8uUX1kKlyS0hDhwd2Iw/UVEUSTsdSzVXfe00NGnvdQbvdCEww6j1vKP/nBIFSewuHNBMuIBqYQ20tQpH/z23rvRVscV+jjwPDoXmVHkonmHT6Yx8LBZ7n2gHJnd4ZWBEOUKvaqPWIky4b2FzT4hTUpyS8CEpJmi1TNrTxbColR+tjZxUsoyHv/L4mHXnOAGSMR+n0EE88C2E3Wj4wbdl1W0nP8fh4WTP2BzYCrovTtQJBrSoNDsqthia7Jp8Z9k7q33qtX1sFdpAVuHAML7aEvq40OskRPQqZ2un/Ltarq+cSHNHGYQTKhwjJmT9WWFePJJUuzlyeqcD08b+64Gl6qCsgiFXC7HKSt7mMqUuqJizgPRmhpgrbzlVIXwqPoLXgyWz7nNTJAaBZfBMtEeiQvXaw/PKrsEDXaXu/vT8Hzr9SW5XvZSOaxzZKJ3767MonEp0SMMsD6wMoBB1sTYa8VYdh0F2goq+Qni6EvskYRGLsgd7yLKOl1pn9ZoFk2+dNz2Kct3vLI5UURAL8bMN+ozDOdACn73/rpnXLLi8qRoMPWU+Es0LtUKfBxap+3xdGOz3k4ObVcp8jc9b31jXEknqMXARBIcO5Ou9xbzSOUo+fmrGltSLbwdSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(31686004)(38100700002)(2906002)(6486002)(6636002)(53546011)(956004)(31696002)(38350700002)(2616005)(36756003)(4326008)(26005)(478600001)(316002)(8936002)(8676002)(66946007)(6666004)(66556008)(66476007)(5660300002)(66574015)(83380400001)(16576012)(186003)(16526019)(110136005)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VjhHbEJQN1ZLSjBvdTNnQ09PdXdJZUtDS3V4dnlnOHlVOXVVb3c2V3BYYUFO?=
 =?utf-8?B?Q1QrdzdtQk1UTTJLZGU1M0ZQZHhsb3A0TitkNklQL1c3YnZXQjFLeTNtanJs?=
 =?utf-8?B?TUdTbEJCQmJtazF1Z1dnYTdMcVNiV0E3enZtRmlONnB0a1ExdTRlUEEyWGdV?=
 =?utf-8?B?K25Td0ZSbTQvQmNKd2lBbE1PSnl2NitTQ25QaXpsYmdYcUhBbWw5ZTJzVEsr?=
 =?utf-8?B?TURIR0xKTmZRS2M4alB2eDJHUi9vSTlWc1lqbFM0S0dsL21ZckhwZkk1RUtJ?=
 =?utf-8?B?bFRTVEdHN0hCN3hMUWhSNGpRTTV0MHJ5T0djNDBFNWwzTEw4akwwNW42STFE?=
 =?utf-8?B?bmJObGxaZ3VJQWZIQVNMNWgzR24wMHErUDZtZlZiQS9yeFNPQ01XdUEyQSsx?=
 =?utf-8?B?WCtKeFZUL1p2V0NDUG1KQXZhSHBVaWRxRi95ZkZkcjR6MUxTQk5GK0Joa3pH?=
 =?utf-8?B?S0l4QW1hckdIVXkzeHRUK2xyeTkwNEJiRXRxYWR0L0xTK0ZaMW1CcmdNNmFy?=
 =?utf-8?B?Y0NVQmZsUWJnRUk4N3hFQ2dHTFJiMXNyWnRmbE1sVlJNcWVJTmIxNmI2ME1C?=
 =?utf-8?B?Zy80WlJuaGhhZmZZUDZ5ckJBQkJtNWJjZ3JZQ0FyTWpzd0trR2N3S2NRQmlI?=
 =?utf-8?B?bjRBV1U1S2tBbHZISUh4ZStDVDcxM3hscUJWRnlEOG0vYXJHelcvNVpaSmlj?=
 =?utf-8?B?VWtuRmFWZ3gwZFFPTWQwVDZQVVVNUXZVemVSSWg1THoyN0RFemdUVjIwUnhm?=
 =?utf-8?B?K3loV1paWTl3cEFKL0tVa09jYlBmNUZwZzliZWFodGdENitxRkZhbmswaHB1?=
 =?utf-8?B?Z2lJWk5qTXF1MUtnOE1yZFBrVlNxRnQ2eE9VZVlnSGNQckF2enJxQXpGc3Nh?=
 =?utf-8?B?K3VhSndNNGRQRVVwV0JGUmw0STIrZXpSbWJ6enEwWGJzbmcvdFprbE1CbjF3?=
 =?utf-8?B?OFJzWjFndXA4d0NVVzB1aCtLMHVYa3R0QWdLWnZyNE8vSHlRK2dxbjdKV2t3?=
 =?utf-8?B?bktsUmJzbEtUamlHWWFNSVNwVGttQWVIN2hDMml4S0J6cUlhSmFOdHF0YTh5?=
 =?utf-8?B?d0VMZWh4MDdpd0w1Rm9pRTRITHdTQU00Y3Noa3ZMajI4R0lVZDBPT2xIRG1r?=
 =?utf-8?B?bENlV0UyTVU3M1g2RXdnNFpaUmF5YzVPbU5zWDdzR3BYUUJKUHVmeXA4cXBB?=
 =?utf-8?B?RitIK2ZzeVhSTUVJcGlsM2VaUHg2dnBTWXRpWGxmOUlxT1JRSGgzMytUWFBM?=
 =?utf-8?B?TDRZSndGVjNjZ3ZOeHJOWFRFNmtaQVF4RWIxWTllazZSUldCaG8yaEJDOVB1?=
 =?utf-8?B?dE5VelFCUk1OOThxbjhuaGJoMStmbjBpbzNnY29ERXVZTDU2dTNGOWZqWjZK?=
 =?utf-8?B?aWViM1FtUW83dWpzeHUzNzJVUFVHYUU5b2M4amtkOFQ0Mzl0UCtjVHNOWWds?=
 =?utf-8?B?OEQxSy9rNVhRNVFvY1BZYUZLcDhTYXFrUWpPdVNHSjB0c3FEVjBaWHgwNWNp?=
 =?utf-8?B?d1hLNUJ5ZHkwWlNkZ1ZTYVYwOGIydnJ0MWRhdEYyZFg5ZmtrYVk0dWREUTZm?=
 =?utf-8?B?RkJjTnVMSnhXYlk1NnAxd1I0TEUweXE4a2RBNEVqRHdRQ3cxNU51N2dBZWJP?=
 =?utf-8?B?L2crY0o5b1ZDU3dQOUY4L1RsWmVLeEYySGdTVlJsdE1FYldmRjBtVlpyVm9B?=
 =?utf-8?B?NHh2U3lHaHkvNFU0UnVWM3J2dkorNHN4elF5ejNLR0hBRTBWeVZwNmJycHlS?=
 =?utf-8?Q?xJHJiDiym1EmDUABVLXjm3pTC8Shmvnf2W4cjsZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a324bc44-e68c-403d-cfa3-08d9056548a8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:04:42.0743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SqigjLFwF94qymcJNi5R/qYJVpGR7lRzkR6K1S+D9gSOfDJJL/v/WbKV15gGVmwKmBFC/J0TOXTlkC0smYeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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

Ck9uIDQvMjIvMjEgOTowOCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMS4wNC4y
MSB1bSAxODozNSBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IFNoYWRvdyBCT3MgYXJlIG9ubHkgbmVl
ZGVkIGZvciB2bSBjb2RlIHNvIGNhbGwgYW1kZ3B1X2JvX2NyZWF0ZV9zaGFkb3coKQo+PiBkaXJl
Y3RseSBpbnN0ZWFkIG9mIGRlcGVuZGluZyBvbiBhbWRncHVfYm9fY3JlYXRlKCkuCj4KPiBBcyBm
YXIgYXMgSSBjYW4gc2VlIHRoYXQgd29uJ3Qgd29yayBjb3JyZWN0bHkuCj4KPiBOb3cgeW91IG9u
bHkgY3JlYXRlIHRoZSBzaGFkb3cgZm9yIHRoZSByb290IEJPLCBidXQgbm90IGZvciBhbnl0aGlu
ZyAKPiBlbHNlLgoKClllcywgSSBqdXN0IHJlYWxpemVkLCBJIGhhdmUgdG8gdGFrZSBjYXJlIG9m
IGFsbCBhbWRncHVfdm1fYm9fcGFyYW0oKSAKY2FsbGVycy4KCgpUaGFua3MsCgpOaXJtb3kKCj4K
PiBDaHJpc3RpYW4uCj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRh
c0BhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMgfCAxOSArKysrKysrKysrKysrKystLS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPj4gaW5kZXggZjk1YmNkYTg0NjNmLi5iYzMwMjU0OGRmYmEgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC04NzMsOCAr
ODczLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX3BhcmFtKHN0cnVjdCAKPj4gYW1kZ3B1
X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4+IMKgwqDCoMKgwqAgYnAtPmJv
X3B0cl9zaXplID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm8pOwo+PiDCoMKgwqDCoMKgIGlmICh2
bS0+dXNlX2NwdV9mb3JfdXBkYXRlKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYnAtPmZsYWdzIHw9
IEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4+IC3CoMKgwqAgZWxzZSBp
ZiAoIXZtLT5yb290LmJhc2UuYm8gfHwgdm0tPnJvb3QuYmFzZS5iby0+c2hhZG93KQo+PiAtwqDC
oMKgwqDCoMKgwqAgYnAtPmZsYWdzIHw9IEFNREdQVV9HRU1fQ1JFQVRFX1NIQURPVzsKPj4gKwo+
PiDCoMKgwqDCoMKgIGJwLT50eXBlID0gdHRtX2JvX3R5cGVfa2VybmVsOwo+PiDCoMKgwqDCoMKg
IGJwLT5ub193YWl0X2dwdSA9IGltbWVkaWF0ZTsKPj4gwqDCoMKgwqDCoCBpZiAodm0tPnJvb3Qu
YmFzZS5ibykKPj4gQEAgLTI4NDQsMTIgKzI4NDMsMjQgQEAgaW50IGFtZGdwdV92bV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4+IMKg
wqDCoMKgwqAgdm0tPmV2aWN0aW5nID0gZmFsc2U7Cj4+IMKgIMKgwqDCoMKgwqAgYW1kZ3B1X3Zt
X2JvX3BhcmFtKGFkZXYsIHZtLCBhZGV2LT52bV9tYW5hZ2VyLnJvb3RfbGV2ZWwsIAo+PiBmYWxz
ZSwgJmJwKTsKPj4gLcKgwqDCoCBpZiAodm1fY29udGV4dCA9PSBBTURHUFVfVk1fQ09OVEVYVF9D
T01QVVRFKQo+PiAtwqDCoMKgwqDCoMKgwqAgYnAuZmxhZ3MgJj0gfkFNREdQVV9HRU1fQ1JFQVRF
X1NIQURPVzsKPj4gwqDCoMKgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCAmYnAsICZy
b290KTsKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJy
b3JfZnJlZV9kZWxheWVkOwo+PiDCoCArwqDCoMKgIGlmICghKHZtX2NvbnRleHQgPT0gQU1ER1BV
X1ZNX0NPTlRFWFRfQ09NUFVURSkgJiYKPj4gK8KgwqDCoMKgwqDCoMKgICghdm0tPnJvb3QuYmFz
ZS5ibyB8fCB2bS0+cm9vdC5iYXNlLmJvLT5zaGFkb3cpKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoIWJwLnJlc3YpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdBUk5fT04oZG1hX3Jlc3Zf
bG9jayhyb290LT50Ym8uYmFzZS5yZXN2LAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlVMTCkpOwo+PiArwqDCoMKgwqDCoMKgwqAgciA9IGFt
ZGdwdV9ib19jcmVhdGVfc2hhZG93KGFkZXYsIGJwLnNpemUsIHJvb3QpOwo+PiArCj4+ICvCoMKg
wqDCoMKgwqDCoCBpZiAoIWJwLnJlc3YpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYV9y
ZXN2X3VubG9jayhyb290LT50Ym8uYmFzZS5yZXN2KTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKHIpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlZigmcm9vdCk7
Cj4+ICvCoMKgwqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgciA9IGFtZGdwdV9ib19yZXNlcnZlKHJv
b3QsIHRydWUpOwo+PiDCoMKgwqDCoMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290
byBlcnJvcl9mcmVlX3Jvb3Q7Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
